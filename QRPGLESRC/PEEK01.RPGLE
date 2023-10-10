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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

dcl-f peekfld usage(*update:*delete:*output) usropn prefix(f_);

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,CEECNDHDLR
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,D_COLORATR
/COPY QCOPYLE,SET0001
/COPY QCOPYLE,SDS

/COPY QCOPYLE,USR0001
/COPY QCOPYLE,USR8104

/define internal_prototype
/COPY QCOPYLE,PPEEK01
/undefine internal_prototype

/COPY QCOPYLE,PPEEK02
/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58
/COPY QCOPYLE,PPEEK71

dcl-ds set0001  likeds(set0001_t);
dcl-ds fldl0100 likeds(fldl0100_t);

dcl-s numFields like(int4_t);
dcl-s rc like(int4_t);

dcl-s peek02_name like(pgmcalln_t);

dcl-s isFld512 char(1) inz(bFalse);

dcl-s seqNbr like(f_seq);
dcl-s fieldCount like(int4_t);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek01;
  i_qfile         const likeds(qobj_t);
  i_rcdfmt        const like(fmt_t);
  o_rcdfmtid      like(fmtid_t);
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
end-pi;

dcl-s do_x1 packed(7);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler'): *null: *omit);

exsr inzsr;

exsr first;

//  create list of database relation
peek02(i_qfile: i_rcdfmt: '*CREATE': numFields
      : fldl0100: o_rcdfmtid);

seqNbr = 0;
fieldCount = 0;
isFld512 = bFalse;

//  read each entry
for do_x1 = 1 to numFields;

  peek02(i_qfile: i_rcdfmt: '*READ': rc
        : fldl0100: o_rcdfmtid);

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

  f_unknown = f_isnotalw(fldl0100);
  if (f_unknown = bTrue);
    f_hidden = bTrue;
    f_istransc = bFalse;
  else;
    f_hidden = bFalse;
    if (f_hasccsid(fldl0100) = bTrue);
      transcoder_tojobccsid(fldl0100.f1fdcc);
      transcoder_tofieldccsid(fldl0100.f1fdcc);
      f_istransc = bTrue;
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

  f_ffd = fldl0100;

  write fpeekfld;

  isFld512 = f_istolong(fldl0100);
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
  if (isFld512 = bTrue);
    o_msgid = 'USR8123';
    o_msgdta = '';
  else;
    o_msgid = '';
    o_msgdta = '';
  endif;
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

  open peekfld;

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorhandler;
  dcl-pi *N;
    i_condtoken     value likeds(cee_fc_t);
    i_pcommarea     int(10) value;
    o_action        int(10);
    o_newcondtoken  likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

