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
dcl-s YPgmCmd char(10) inz(*blanks);
dcl-s YCmdDta like(pgmCmdDt_t);
dcl-s YMsgID char(7) inz(*blanks);
dcl-s YMsgDta char(512) inz(*blanks);

//  Peek23:
dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);

dcl-s sfbot like(int4_t);
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

exsr First;

dow ('1');

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgctl;

  //  Anzeigen der Befehlstasten
  select;
  when ((sfbot = 2) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#2;
  when ((sfbot = 3) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#3;
  when ((sfbot = 4) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#4;
  when ((sfbot = 5) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#5;
  when ((sfbot = 6) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#6;
  when ((sfbot = 7) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#7;
  when ((sfbot = 8) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#8;
  when ((sfbot = 9) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#9;
  when ((sfbot = 10) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#10;
  when ((sfbot = 11) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#11;
  when ((sfbot = 12) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#12;
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Anzeigen Bildschirm
  exfmt bild01;
  *in70 = '0';

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
  if (YMsgID <> *blanks);
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    iter;
  endif;

  //  Abfragen der Befehlstasten
  select;
  //  F3  - Ende
  when (YPgmCmd = '*EXIT');
    exsr C_EndPgm;
    leave;
  //  F5  - Aktualisieren
  when (YPgmCmd = '*REFRESH');
    exsr C_Refresh;
    iter;

  //  F9  - Löschen Arbeitsumgebung
  //  (nach dem Löschen zurück zur Liste; bei einem Fehler bleibt das
  //  Fenster mit der Meldung offen)
  when (YPgmCmd = '*DELETEENV');
    exsr C_delEnv;
    if (isPgmError = bTrue);
      iter;
    else;
      leave;
    endif;

  //  F12 - Ende
  when (YPgmCmd = '*CANCEL');
    exsr C_EndPgm;
    leave;

  //  F24 - Weitere Tasten
  when (YPgmCmd = '*MOREKEYS');
    exsr C_MoreKeys;

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peek57fm;

return;

//============================================================*
//    C_EndPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr C_EndPgm;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8100';
  usr8100.var1 = YPgmCmd;
  o_msgDta = usr8100;

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr C_Refresh;

  exsr fill##;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    C_delEnv      Verarbeiten der Eingaben                  *
//============================================================*

begsr C_delEnv;

  f_execute('RMVM'          +
           ' FILE('        +
           %trim(i_envLib ) +
           '/'             +
           %trim(i_envFile) +
           ')'             +
           ' MBR('         +
           %trim(i_envMbr ) +
           ')'             :
           YMsgID          :
           YMsgDta         );

  if (YMsgID <> '');
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    isPgmError = bTrue;
  else;
    isPgmError = bFalse;
  endif;

endsr;

//============================================================*
//    FILL##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  ##File  = i_envFile;
  ##Lib   = i_envLib;
  ##Mbr   = i_envMbr;
  ##Text  = i_envText;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

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

begsr First;

  // - Öffnen der Dateien
  open peek57fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Rückkehrcode
  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Darstellung der Befehlstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr SetScreen;

  // - Bildschirm füllen
  exsr C_Refresh;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  PGMQ = '*';

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');

  peek23(sds.pgmName: '*ALL': 0
        : yFKeys: yNbrOfKeys);
  ScrnFKeys = %subarr(yFKeys: 1);

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

