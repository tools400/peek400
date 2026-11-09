**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK12                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 02.10.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Auswahl Satzformat                                           *
//                                                               *
// ============================================================= *
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

dcl-f peek12fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbSfl: sflRec);

dcl-f peekFmt usropn infds(peek_01_ds) prefix(f_);

dcl-ds workstn likeds(workstn_t);

dcl-ds peek_01_ds likeds(infds_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,RCDL0200
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,SDS

/define internal_prototype
/copy QCOPYLE,PPEEK12
/undefine internal_prototype

/copy QCOPYLE,USR8100

dcl-ds rcdl0200 likeds(rcdl0200_t) inz;

dcl-s sfBot like(int4_t) inz;

dcl-s lastRcdNbr like(rcdNbr_t) inz;
dcl-s sflPage like(int4_t) inz;
dcl-s sflRec like(sflPage) inz;
dcl-s sflLastRcd like(sflPage) inz;
dcl-c NBR_F_KEYS 3;

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;

//  PEEK21
dcl-s yPgmCmd char(10) inz(*blanks);
dcl-s yCmdDta like(pgmCmdDt_t) inz(*blanks);
dcl-s yMsgID char(7) inz(*blanks);
dcl-s yMsgDta char(512) inz(*blanks);

//  PEEK23
dcl-s yFKeys char(18) dim(32) inz(*blanks);
dcl-s yNbrOfKeys like(int4_t) inz;

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

/copy QCOPYLE,CEECNDHDLR

dcl-s isInzSr like(bool_t) inz(bFalse);
dcl-s isExitPgm like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek12;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  i_fmtName   like(fmt_t) const;
  i_fmtMode   like(mode_t) const;
  o_rcdl0200  likeds(rcdl0200_t);
  o_fmtNbr    like(int2_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

dow (isExitPgm = bFalse);

  //  Prüfen Positionierung der Subfile
  if ((sfsanr <= 0     )  or
      (sfsanr >  sflRec));
    sfsanr = 1;
  endif;

  //  Modus: DROP/FOLD
  *in86 = sflMde;

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgCtl;

  //  "Keine Sätze ..."
  if (*in80 = *off);
    write pbleer;
  endif;

  //  Anzeigen der Befehlstasten
  write pbbot#0;

  select;
  when ((sfBot = 2) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#2;
  when ((sfBot = 3) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#3;
  when ((sfBot = 4) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#4;
  when ((sfBot = 5) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#5;
  when ((sfBot = 6) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#6;
  other;
    write pbbot#1;
    sfBot = 1;
  endsl;

  //  Anzeige der Subfile
  exfmt pbCtl;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Aktuelle Satz-Nr.
  sfsanr = sflCsr;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
  if (yMsgID <> *blanks);
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    iter;
  endif;

  //  Abfragen der Befehlstasten
  select;
  //  F3  - Ende
  when (yPgmCmd = '*EXIT');
    exsr c_endPgm;
    leave;

  //  F5  - Aktualisieren
  when (yPgmCmd = '*REFRESH');
    exsr c_refresh;
    iter;

  //  F12 - Ende
  when (yPgmCmd = '*CANCEL');
    exsr c_endPgm;
    leave;

  //  Datenfreigabe
  when (yPgmCmd = '*ENTER');
    exsr c_enter;

  //  F24 - Weitere Tasten
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peekFmt;

*inlr = *on;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  if (*in80 = *off);
  // Subfile ist leer
  else;
    dow ('1');
      readc pbSfl;
      if (%eof());
        leave;
      endif;

      //  Die erste markierte Zeile auswählen. Weitere Markierungen und
      //  Zeilen, deren Markierung wieder gelöscht wurde, ignorieren.
      if (sfpau <> '');
        o_rcdl0200 = $$rcdl0200;
        o_fmtNbr = fmtNbr;
        leave;
      endif;
    enddo;
  endif;

  if (o_rcdl0200 <> '');
    isExitPgm = bTrue;
  endif;

endsr;

//============================================================*
//    c_endPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endPgm;

  write rmvwdw;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8100';

  select;
  when (workstn.aid = k_f3);
    usr8100.var1 = 'F3';
  when (workstn.aid = k_f12);
    usr8100.var1 = 'F12';
  other;
    usr8100.var1 = 'Fxx';
  endsl;

  o_msgDta = usr8100;

  o_rcdl0200 = *blanks;
  o_fmtNbr = *zeros;

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr pbFirstRcd;
  exsr pbInit;
  exsr pbSetLL;
  exsr pbReadUp;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    pbInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr pbInit;

  *in89 = '0';
  write msgCtl;

  *in80 = '0'; // SFLDSP
  *in81 = '1'; // SFLDSPCTL
  *in82 = '1'; // SFLCLR
  *in83 = '1'; // SFLEND
  write pbCtl;

  *in82 = '0'; // SFLCLR

  sflRec = *zeros;

  sflLastRcd = *zeros;

endsr;

//============================================================*
//    pbFirstRcd    Ersten geschriebenen Satz der Subfile     *
//                  einlesen                                  *
//============================================================*

begsr pbFirstRcd;

  if (*in80 = *off);
    lastRcdNbr = 0;
  else;

    chain 1 pbSfl;

    if (not %found());
      lastRcdNbr = 0;
    else;
      lastRcdNbr = recordNbr;
    endif;
  endif;

endsr;

//============================================================*
//    pbReadUp      Vorwärts füllen der Subfile               *
//============================================================*

begsr pbReadUp;

  dow ('1');
    read fpeekfmt;
    if (%eof());
      *in83 = bTrue;
      leave;
    endif;

    sflRec = sflRec + 1;

    if (sflRec > 9999);
      *in83 = bTrue;
      leave;
    endif;

    exsr pbFill;

    write pbSfl;

    sflLastRcd = sflRec;

    if (sflRec >= sflPage);
      leave;
    endif;
  enddo;

  exsr pbExit;

endsr;

//============================================================*
//    pbExit        Hinter füllen Subfile                     *
//============================================================*

begsr pbExit;

  exsr pbFirstRcd;

endsr;

//============================================================*
//    pbFill        Füllen Subfilesatz                        *
//============================================================*

begsr pbFill;

  sfpau = *blanks;
  rcdl0200 = f_fmt;
  $$rcdl0200 = f_fmt;
  $$format = rcdl0200.r2FmtName;
  $$text = rcdl0200.r2Text;
  recordNbr = peek_01_ds.rcdNbr;
  fmtNbr = f_fmtNbr;

  *in80 = '1'; // SFLDSP
  lastRcdNbr = peek_01_ds.rcdNbr;

endsr;

//============================================================*
//    pbSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr pbSetLL;

  setll lastRcdNbr fpeekfmt;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 4;
    pos = 12;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 4;
    pos = 8;
  endif;

  sflPage = *hival;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Dateien öffnen
  open peekFmt;

  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Prüfen auf Satzformat
  if ((i_fmtMode = MODE_BATCH) and
      ((peek_01_ds.nbrOfRcd = 1) or (i_fmtName <> '')));
    setll 1 fpeekfmt;
    dou (%eof(peekFmt));
      read fpeekfmt;
      if (not %eof(peekFmt));
        rcdl0200 = f_fmt;
        if ((rcdl0200.r2FmtName = i_fmtName) or
            ((peek_01_ds.nbrOfRcd = 1) and (i_fmtName = '')));
          o_rcdl0200 = f_fmt;
          o_fmtNbr = f_fmtNbr;
          isExitPgm = bTrue;
          leavesr;
        endif;
      endif;
    enddo;
  endif;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  o_rcdl0200 = *blanks;
  o_fmtNbr = *zeros;

  // - Darstellung der Subfile
  sflMde = '1';

  // - Darstellung der Befehlstasten
  sfBot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setScreen;

  // - Subfile füllen
  lastRcdNbr = 1;
  exsr pbInit;
  exsr pbSetLL;
  exsr pbReadUp;

  // - Copyright
  p_sndPgmMg('USR9999': i_copyright: sds.pgmName);

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  pgmQ = '*';

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');

  peek23(sds.pgmName: '*ALL': NBR_F_KEYS
        : yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

  open peek12fm;

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

