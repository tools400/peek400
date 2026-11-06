**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK57                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 06.05.1999  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Löschen   "Arbeitsumgebung"                       *
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

dcl-f peek57fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8110

/define internal_prototype
/copy QCOPYLE,PPEEK57
/undefine internal_prototype

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

//  Peek21:
dcl-s yPgmCmd char(10) inz(*blanks);
dcl-s yCmdDta like(pgmCmdDt_t);
dcl-s yMsgID char(7) inz(*blanks);
dcl-s yMsgDta char(512) inz(*blanks);

//  Peek23:
dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);

dcl-s sfBot like(int4_t);
dcl-c NbrFKeys 2;
dcl-s isPgmError like(bool_t) inz(bFalse);

dcl-s peek21_name like(pgmCallN_t);
dcl-s peek23_name like(pgmCallN_t);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek57;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  i_envFile   like(file_t) const;
  i_envLib    like(lib_t) const;
  i_envMbr    like(mbr_t) const;
  i_envText   like(text_t) const;
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

dow ('1');

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgCtl;

  //  Anzeigen der Befehlstasten
  select;
  when ((sfBot = 2) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#2;
  when ((sfBot = 3) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#3;
  when ((sfBot = 4) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#4;
  when ((sfBot = 5) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#5;
  when ((sfBot = 6) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#6;
  when ((sfBot = 7) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#7;
  when ((sfBot = 8) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#8;
  when ((sfBot = 9) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#9;
  when ((sfBot = 10) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#10;
  when ((sfBot = 11) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#11;
  when ((sfBot = 12) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#12;
  other;
    write pbbot#1;
    sfBot = 1;
  endsl;

  //  Anzeigen Bildschirm
  exfmt bild01;
  *in70 = '0';

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
  if (yMsgID <> *blanks);
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
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

  //  F9  - Löschen Arbeitsumgebung
  //  (nach dem Löschen zurück zur Liste; bei einem Fehler bleibt das
  //  Fenster mit der Meldung offen)
  when (yPgmCmd = '*DELETEENV');
    exsr c_delEnv;
    if (isPgmError = bTrue);
      iter;
    else;
      leave;
    endif;

  //  F12 - Ende
  when (yPgmCmd = '*CANCEL');
    exsr c_endPgm;
    leave;

  //  F24 - Weitere Tasten
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peek57fm;

return;

//============================================================*
//    c_endPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endPgm;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8100';
  usr8100.var1 = yPgmCmd;
  o_msgDta = usr8100;

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr fill##;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    c_delEnv      Verarbeiten der Eingaben                  *
//============================================================*

begsr c_delEnv;

  f_execute('RMVM'          +
           ' FILE('        +
           %trim(i_envLib ) +
           '/'             +
           %trim(i_envFile) +
           ')'             +
           ' MBR('         +
           %trim(i_envMbr ) +
           ')'             :
           yMsgID          :
           yMsgDta         );

  if (yMsgID <> '');
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    isPgmError = bTrue;
  else;
    isPgmError = bFalse;
  endif;

endsr;

//============================================================*
//    FILL##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  ##file  = i_envFile;
  ##lib   = i_envLib;
  ##mbr   = i_envMbr;
  ##text  = i_envText;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 6;
    pos = 40;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 6;
    pos = 19;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek57fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Rückkehrcode
  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Darstellung der Befehlstasten
  sfBot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setScreen;

  // - Bildschirm füllen
  exsr c_refresh;

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

  peek23(sds.pgmName: '*ALL': 0
        : yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

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

