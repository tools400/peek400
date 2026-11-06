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

dcl-f peekFld usage(*update: *delete: *output) usropn prefix(f_);

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

dcl-s peek02_name like(pgmCallN_t);
dcl-s exit06_name like(pgmCallN_t);
dcl-s isExit06 like(bool_t) inz(bFalse);

dcl-s seqNbr like(f_seq);
dcl-s fieldCount like(int4_t);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek01;
  i_qFile    likeds(qObj_t) const;
  i_rcdFmt   like(fmt_t) const;
  o_rcdFmtID like(fmtId_t);
  o_msgID    like(msgId_t);
  o_msgDta   like(msgDta_t);
end-pi;

dcl-s do_x1 packed(7);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler'): *null: *omit);

exsr inzsr;

exsr first;

//  create list of database relation
peek02(i_qFile: i_rcdFmt: '*CREATE': numFields: fldl0100: o_rcdFmtID);

seqNbr = 0;
fieldCount = 0;

//  read each entry
for do_x1 = 1 to numFields;

  peek02(i_qFile: i_rcdFmt: '*READ': rc: fldl0100: o_rcdFmtID);

  clear fpeekfld;

  f_format = 'FLDL0100';
  f_field = fldl0100.f1FNme;
  seqNbr = seqNbr + 1;
  f_fldSeq = seqNbr;
  f_seq = seqNbr;
  f_kSeq = 0;
  f_color = set0001.set_clmCol;
  f_markCol = bFalse;
  f_maxSize = *hival;
  f_edtCde = fldl0100.f1EdtC;

  f_unKnown = f_isNotAlw(fldl0100);
  if (f_unKnown = bTrue);
    f_hidden = bTrue;
    f_isTransc = bFalse;
  else;
    f_hidden = bFalse;
    if (f_hasCcsid(fldl0100) = bTrue);
      //  PEEK71 sendet die Escape-Nachricht CPF9897, wenn die CCSID des
      //  Feldes nicht in die Job-CCSID umgesetzt werden kann, z.B.
      //  GRAPHIC mit CCSID 835. Die Feldliste wird trotzdem erstellt;
      //  PEEK06 zeigt das Feld dann leer an.
      monitor;
        Transcoder_toJobCcsid(fldl0100.f1fdcc);
        Transcoder_toFieldCcsid(fldl0100.f1fdcc);
        f_isTransc = bTrue;
      on-error;
        f_isTransc = bFalse;
      endmon;
    else;
      f_isTransc = bFalse;
    endif;
  endif;

  exsr cvtEDTCDE;

  //  Internal PEEK/400 field name, max.
  //  length 2 + 8 characters.
  fieldCount = fieldCount + 1;
  if (fieldCount > 99999999);
    leave;
  endif;

  if (f_isVarLen(fldl0100) = bTrue);
    fldl0100.f1vfld = 'V_' + %editc(%dec(fieldCount: 8: 0): 'X');
  else;
    fldl0100.f1vfld = 'P_' + %editc(%dec(fieldCount: 8: 0): 'X');
  endif;

  //  Anzeigereihenfolge
  fldl0100.f1seq = seqNbr;

  //  UCS-2 Feld
  fldl0100.f1ucs2 = (fldl0100.f1DTyp = 'G');

  //  Spaltenüberschriften und Feldtext über EXIT06 überschreiben
  if (isExit06 = bTrue);
    callp(e) exit06(i_qFile.name: i_qFile.lib: sds.user: fldl0100.f1FNme
                   : fldl0100.f1col1: fldl0100.f1col2: fldl0100.f1col3
                   : fldl0100.f1FTxt);
    if (%error());
      isExit06 = bFalse;
    endif;
  endif;

  //  Leeren Feldtext durch die Spaltenüberschrift ersetzen,
  //  z.B. bei SQL Tabellen ohne LABEL ON ... TEXT IS
  if (fldl0100.f1FTxt = ' ');
    fldl0100.f1FTxt = f_headline('*COLHDG': fldl0100);
  endif;

  f_ffd = fldl0100;

  write fpeekfld;
endfor;

//  delete list
// peek02(i_qfile: i_rcdfmt: '*DELETE': rc
//        : fldl0100: o_rcdfmtid);

if (numFields = 0);
  o_msgID = 'USR0001';
  USR0001.var1 = i_qFile.name;
  USR0001.var2 = i_qFile.lib;
  USR0001.var3 = i_rcdFmt;
  o_msgDta = usr0001;
else;
  o_msgID = '';
  o_msgDta = '';
endif;

*inlr = '1';

//============================================================*
//    cvtEDTCDE     Konvertieren des EDTCDE's in einen        *
//                  EDTCDE mit Vorzeichen                     *
//============================================================*

begsr cvtEDTCDE;

  if (f_isNumFld(fldl0100) = bFalse);
    leavesr;
  endif;

  if (f_isFloatFld(fldl0100) = bTrue);
    leavesr;
  endif;

  select;
  //  Keine Umsetzung der EDTCDE's
  when (set0001.set_dspSgn = '0');

  //  Mappen Edit Code
  when (set0001.set_dspSgn = '1');
    select;
    when (f_edtCde = '1');
      f_edtCde = 'J';
    when (f_edtCde = '2');
      f_edtCde = 'K';
    when (f_edtCde = '3');
      f_edtCde = 'L';
    when (f_edtCde = '4');
      f_edtCde = 'M';
    when (f_edtCde = 'Z');
      f_edtCde = 'L';
    when (f_edtCde = 'X');
      f_edtCde = 'L';
    other;
    //  Keine Umsetzung des EDTCDE's
    endsl;

  //  Mappen Edit Code - Keine Nullenunterdrückung
  when (set0001.set_dspSgn = '2');
    select;
    when (f_edtCde = '1');
      f_edtCde = 'J';
    when (f_edtCde = '2');
      f_edtCde = 'J';
    when (f_edtCde = '3');
      f_edtCde = 'L';
    when (f_edtCde = '4');
      f_edtCde = 'L';

    when (f_edtCde = 'B');
      f_edtCde = 'A';
    when (f_edtCde = 'D');
      f_edtCde = 'C';

    when (f_edtCde = 'K');
      f_edtCde = 'J';
    when (f_edtCde = 'M');
      f_edtCde = 'L';

    when (f_edtCde = 'O');
      f_edtCde = 'N';
    when (f_edtCde = 'Q');
      f_edtCde = 'P';

    when (f_edtCde = 'Z');
      f_edtCde = 'L';
    when (f_edtCde = 'X');
      f_edtCde = 'L';

    when (f_edtCde = ' ');
      f_edtCde = set0001.set_editCode;
    endsl;

  endsl;

endsr;

//============================================================*
//    getUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getUsrSetg;

  set0001 = f_getUsrSg('*DSPATTR' );

endsr;

//====================================================*
//  First  --  Initialize program                     *
//====================================================*

begsr first;

  // - Meldung
  p_sndStsMg('USR8104': i_qFile);

  // - Benutzervoreinstellungen
  exsr getUsrSetg;

  // - Los gehts'
  o_msgID = *blanks;
  o_msgDta = *blanks;

  o_rcdFmtID = *blanks;

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

  peek02_name = f_pgmCallN('PEEK02');

  exit06_name = f_pgmCallN('EXIT06');
  isExit06 = f_exist('EXIT06': f_getPrdLb(): '*PGM');

  open peekFld;

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorHandler;
  dcl-pi *n;
    i_condToken    likeds(cee_fc_t) value;
    i_pCommArea    int(10) value;
    o_action       int(10);
    o_newCondToken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

