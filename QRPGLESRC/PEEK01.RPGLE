**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK01                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 26.09.97  Raddatz                                 *
//  geändert : 27.04.99  für Version 2.1.0                       *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Erstellen einer Satzformatbeschreibung in der Datei PEEKFLD  *
//                                                               *
//===============================================================*
// >>PRE-COMPILER<<                                              *
//   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
//                           OBJLIB(&LI) DEVLIB(&LI) +           *
//                           SBMJOB(*NO) BNDDIR(PEEK) +          *
//                           INSTALL(*NO);                       *
//   >>EXECUTE<<                                                 *
// >>END-PRE-COMPILER<<                                          *
//===============================================================*
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

dcl-f peekfld usage(*update: *delete: *output) usropn prefix(f_);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,CEECNDHDLR
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_COLORATR
/copy QCOPYLE,SET0001
/copy QCOPYLE,SDS

/copy QCOPYLE,USR0001
/copy QCOPYLE,USR8104

/define internal_prototype
/copy QCOPYLE,PPEEK01
/undefine internal_prototype

/copy QCOPYLE,PPEEK02
/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK71
/copy QCOPYLE,PEXIT06

dcl-ds set0001 likeds(set0001_t);
dcl-ds fldl0100 likeds(fldl0100_t);

dcl-s numFields like(int4_t);
dcl-s rc like(int4_t);

dcl-s peek02_name like(pgmcalln_t);
dcl-s exit06_name like(pgmcalln_t);
dcl-s isExit06 like(bool_t) inz(bFalse);

dcl-s seqNbr like(f_seq);
dcl-s fieldCount like(int4_t);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek01;
  i_qfile    likeds(qobj_t) const;
  i_rcdfmt   like(fmt_t) const;
  o_rcdfmtid like(fmtid_t);
  o_msgid    like(msgid_t);
  o_msgdta   like(msgdta_t);
end-pi;

dcl-s do_x1 packed(7);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler'): *null: *omit);

exsr inzsr;

exsr first;

//  create list of database relation
peek02(i_qfile: i_rcdfmt: '*CREATE': numFields: fldl0100: o_rcdfmtid);

seqNbr = 0;
fieldCount = 0;

//  read each entry
for do_x1 = 1 to numFields;

  peek02(i_qfile: i_rcdfmt: '*READ': rc: fldl0100: o_rcdfmtid);

  clear fpeekfld;

  f_format = 'FLDL0100';
  f_field = fldl0100.f1fnme;
  seqNbr = seqNbr + 1;
  f_fldseq = seqNbr;
  f_seq = seqNbr;
  f_kseq = 0;
  f_color = set0001.set_clmcol;
  f_markcol = bFalse;
  f_maxsize = *hival;
  f_edtcde = fldl0100.f1edtc;

  f_unknown = f_isNotAlw(fldl0100);
  if (f_unknown = bTrue);
    f_hidden = bTrue;
    f_istransc = bFalse;
  else;
    f_hidden = bFalse;
    if (f_hasccsid(fldl0100) = bTrue);
      //  PEEK71 sendet die Escape-Nachricht CPF9897, wenn die CCSID des
      //  Feldes nicht in die Job-CCSID umgesetzt werden kann, z.B.
      //  GRAPHIC mit CCSID 835. Die Feldliste wird trotzdem erstellt;
      //  PEEK06 zeigt das Feld dann leer an.
      monitor;
        transcoder_tojobccsid(fldl0100.f1fdcc);
        transcoder_tofieldccsid(fldl0100.f1fdcc);
        f_istransc = bTrue;
      on-error;
        f_istransc = bFalse;
      endmon;
    else;
      f_istransc = bFalse;
    endif;
  endif;

  exsr cvtedtcde;

  //  Internal PEEK/400 field name, max.
  //  length 2 + 8 characters.
  fieldCount = fieldCount + 1;
  if (fieldCount > 99999999);
    leave;
  endif;

  if (f_isvarlen(fldl0100) = bTrue);
    fldl0100.f1vfld = 'V_' + %editc(%dec(fieldCount: 8: 0): 'X');
  else;
    fldl0100.f1vfld = 'P_' + %editc(%dec(fieldCount: 8: 0): 'X');
  endif;

  //  Anzeigereihenfolge
  fldl0100.f1seq = seqNbr;

  //  UCS-2 Feld
  fldl0100.f1ucs2 = (fldl0100.f1dtyp = 'G');

  //  Spaltenüberschriften und Feldtext über EXIT06 überschreiben
  if (isExit06 = bTrue);
    callp(e) exit06(i_qfile.name: i_qfile.lib: sds.user: fldl0100.f1fnme
                   : fldl0100.f1col1: fldl0100.f1col2: fldl0100.f1col3
                   : fldl0100.f1ftxt);
    if (%error());
      isExit06 = bFalse;
    endif;
  endif;

  //  Leeren Feldtext durch die Spaltenüberschrift ersetzen,
  //  z.B. bei SQL Tabellen ohne LABEL ON ... TEXT IS
  if (fldl0100.f1ftxt = ' ');
    fldl0100.f1ftxt = f_headline('*COLHDG': fldl0100);
  endif;

  f_ffd = fldl0100;

  write fpeekfld;
endfor;

//  delete list
// peek02(i_qfile: i_rcdfmt: '*DELETE': rc
//        : fldl0100: o_rcdfmtid);

if (numFields = 0);
  o_msgid = 'USR0001';
  USR0001.var1 = i_qfile.name;
  USR0001.var2 = i_qfile.lib;
  USR0001.var3 = i_rcdfmt;
  o_msgdta = usr0001;
else;
  o_msgid = '';
  o_msgdta = '';
endif;

*inlr = '1';

//============================================================*
//    CvtEDTCDE     Konvertieren des EDTCDE's in einen        *
//                  EDTCDE mit Vorzeichen                     *
//============================================================*

begsr cvtedtcde;

  if (f_isnumfld(fldl0100) = bFalse);
    leavesr;
  endif;

  if (f_isfloatfld(fldl0100) = bTrue);
    leavesr;
  endif;

  select;
  //  Keine Umsetzung der EDTCDE's
  when (set0001.set_dspsgn = '0');

  //  Mappen Edit Code
  when (set0001.set_dspsgn = '1');
    select;
    when (f_edtcde = '1');
      f_edtcde = 'J';
    when (f_edtcde = '2');
      f_edtcde = 'K';
    when (f_edtcde = '3');
      f_edtcde = 'L';
    when (f_edtcde = '4');
      f_edtcde = 'M';
    when (f_edtcde = 'Z');
      f_edtcde = 'L';
    when (f_edtcde = 'X');
      f_edtcde = 'L';
    other;
    //  Keine Umsetzung des EDTCDE's
    endsl;

  //  Mappen Edit Code - Keine Nullenunterdrückung
  when (set0001.set_dspsgn = '2');
    select;
    when (f_edtcde = '1');
      f_edtcde = 'J';
    when (f_edtcde = '2');
      f_edtcde = 'J';
    when (f_edtcde = '3');
      f_edtcde = 'L';
    when (f_edtcde = '4');
      f_edtcde = 'L';

    when (f_edtcde = 'B');
      f_edtcde = 'A';
    when (f_edtcde = 'D');
      f_edtcde = 'C';

    when (f_edtcde = 'K');
      f_edtcde = 'J';
    when (f_edtcde = 'M');
      f_edtcde = 'L';

    when (f_edtcde = 'O');
      f_edtcde = 'N';
    when (f_edtcde = 'Q');
      f_edtcde = 'P';

    when (f_edtcde = 'Z');
      f_edtcde = 'L';
    when (f_edtcde = 'X');
      f_edtcde = 'L';

    when (f_edtcde = ' ');
      f_edtcde = set0001.set_editcode;
    endsl;

  endsl;

endsr;

//============================================================*
//    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getusrsetg;

  set0001 = f_getusrsg('*DSPATTR' );

endsr;

//====================================================*
//  First  --  Initialize program                     *
//====================================================*

begsr first;

  // - Meldung
  p_sndstsmg('USR8104': i_qfile);

  // - Benutzervoreinstellungen
  exsr getusrsetg;

  // - Los gehts'
  o_msgid = *blanks;
  o_msgdta = *blanks;

  o_rcdfmtid = *blanks;

  setll 1 fpeekfld;

  dow ('1');
    read fpeekfld;
    if (%eof());
      leave;
    endif;

    delete fpeekfld;
  enddo;

  numFields = 0;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  peek02_name = f_pgmcalln('PEEK02');

  exit06_name = f_pgmcalln('EXIT06');
  isExit06 = f_exist('EXIT06': f_getprdlb(): '*PGM');

  open peekfld;

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorhandler;
  dcl-pi *n;
    i_condtoken    likeds(cee_fc_t) value;
    i_pcommarea    int(10) value;
    o_action       int(10);
    o_newcondtoken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

