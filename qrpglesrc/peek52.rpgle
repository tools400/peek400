**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Abfrage 'Programm erstellen'                 *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK52                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 20.01.99  Raddatz                                 *
//  geändert : 27.04.99  2.1.0                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Abfrage "Programm erstellen"                      *
//                                                               *
//===============================================================*
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peek52fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/shortcmd_d.rpgleinc'
/copy 'qcopyle/set0012.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/copy 'qcopyle/usr8100.rpgleinc'
/copy 'qcopyle/usr8216.rpgleinc'
/copy 'qcopyle/usr8219.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek52.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-s yFKeys char(18) dim(32) inz;
dcl-s yNbrOfKeys like(int4_t) inz;
dcl-s yMsgID char(7) inz;
dcl-s yMsgDta char(512) inz;
dcl-s yPgmCmd char(10) inz;
dcl-s yCmdDta like(pgmCmdDt_t) inz;

dcl-s sfBot like(int4_t) inz;
dcl-c NbrFKeys 2;

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;

dcl-s doGenerate ind inz(bFalse);

dcl-ds set0012 likeds(set0012_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek52;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  o_alwLc     like(bool_t);
  o_case      like(bool_t);
  o_cdLock    like(bool_t);
  o_nullDft   like(bool_t);
  o_keepCrs   like(bool_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
  i_isUnload  like(msgId_t) const;
end-pi;

dcl-s do_x1 packed(7);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

if (i_isUnload = bTrue);
  close peek52fm;
  *inlr = *on;
  return;
endif;

exsr first;

//---------------------------------------------------*
//  Schleife für Programmbearbeitung

dow ('1');

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgCtl;

  //  Anzeigen der Befehlstasten
  doGenerate = bFalse;
  exsr dspCmdKeys;

  //  Anzeigen Bildschirm
  exfmt bild01;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Bezugszahlen löschen
  exsr bzoff1;

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

  //  Abfragen der Programmbefehle
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

  //  F24 - Weitere Tasten
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;

  //  Datenfreigabe
  when (yPgmCmd = '*ENTER');
    exsr c_enter;
    if (*in99 = *off);
      o_msgID = 'USR8112';
      o_msgDta = *blanks;

      write msgctl2;
      doGenerate = bTrue;
      exsr dspCmdKeys;
      write bild02;

      leave;
    endif;

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

return;

//============================================================*
//    dspCmdKeys    Anzeigen der Befehlstasten                *
//============================================================*

begsr dspCmdKeys;

  if (doGenerate);
    sfBot = 1;
  endif;

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
    if (not doGenerate);
      write pbbot#1;
    else;
      write pbbot2#1;
    endif;
    sfBot = 1;
  endsl;

endsr;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr prfB1;

  if (*in99 = *off);
    o_alwLc = ##alwLc;
    o_case = ##case;
    o_cdLock = ##rcdLck;
    o_nullDft = ##nullDft;
    o_keepCrs = ##keepCrs;
    if (##save = bTrue);
      exsr savUsrSetg;
    endif;
  endif;

endsr;

//============================================================*
//    PRFB1         Prüfen der Eingaben                       *
//============================================================*

begsr prfB1;

  dou ('1');

    exsr prf22;
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf20;
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf24;
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf23;
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf25;
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf26;
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf21;
    if (*in99 = bTrue);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PRF20         Prüfen:  case-sensitive                   *
//============================================================*

begsr prf20;

  dou ('1');

    if (##case <> bTrue and ##case <> bFalse);
      *in99 = '1';
      clear usr8219;
      usr8219.var1 = ##case;
      p_sndPgmMg('USR8219': usr8219: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in20 = '1';
    *in30 = '1';
  endif;

endsr;

//============================================================*
//    PRF21         Prüfen:  save                             *
//============================================================*

begsr prf21;

  dou ('1');

    if (##save <> bTrue and ##save <> bFalse);
      *in99 = '1';
      clear usr8219;
      usr8219.var1 = ##save;
      p_sndPgmMg('USR8219': usr8219: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in21 = '1';
    *in31 = '1';
  endif;

endsr;

//============================================================*
//    PRF22         Prüfen:  alwlc                            *
//============================================================*

begsr prf22;

  dou ('1');

    if (##alwLc <> bTrue and ##alwLc <> bFalse);
      *in99 = '1';
      clear usr8219;
      usr8219.var1 = ##alwLc;
      p_sndPgmMg('USR8219': usr8219: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in22 = '1';
    *in32 = '1';
  endif;

endsr;

//============================================================*
//    PRF23         Prüfen:  Satz gesperrt einlesen           *
//============================================================*

begsr prf23;

  dou ('1');

    if (##rcdLck <> bTrue and ##rcdLck <> bFalse);
      *in99 = '1';
      clear usr8219;
      usr8219.var1 = ##rcdLck;
      p_sndPgmMg('USR8219': usr8219: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in23 = '1';
    *in33 = '1';
  endif;

endsr;

//============================================================*
//    PRF24         Prüfen:  case-sensitive                   *
//============================================================*

begsr prf24;

  dou ('1');

    if (##alwLc = bFalse and ##case  = bTrue);
      *in99 = '1';
      clear usr8216;
      p_sndPgmMg('USR8216': usr8216: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in20 = '1';
    *in30 = '1';
    *in22 = '1';
    *in32 = '1';
  endif;

endsr;

//============================================================*
//    PRF25         Prüfen:  nullDft                          *
//============================================================*

begsr prf25;

  dou ('1');

    if (##nullDft <> bTrue and ##nullDft <> bFalse);
      *in99 = '1';
      clear usr8219;
      usr8219.var1 = ##nullDft;
      p_sndPgmMg('USR8219': usr8219: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in25 = '1';
    *in35 = '1';
  endif;

endsr;

//============================================================*
//    PRF26         Prüfen:  keepCrs                          *
//============================================================*

begsr prf26;

  dou ('1');

    if (##keepCrs <> bTrue and ##keepCrs <> bFalse);
      *in99 = '1';
      clear usr8219;
      usr8219.var1 = ##keepCrs;
      p_sndPgmMg('USR8219': usr8219: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in26 = '1';
    *in36 = '1';
  endif;

endsr;

//============================================================*
//    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
//============================================================*

begsr bzoff1;

  //  DSPATR(PC)
  *in20 = '0';  // ##CASE
  *in21 = '0';  // ##SAVE
  *in22 = '0';  // ##ALWLC
  *in23 = '0';  // ##RCDLCK
  *in25 = '0';  // ##NULLDFT
  *in26 = '0';  // ##KEEPCRS

  //  DSPATR(RI)
  *in30 = '0';  // ##CASE
  *in31 = '0';  // ##SAVE
  *in32 = '0';  // ##ALWLC
  *in33 = '0';  // ##RCDLCK
  *in35 = '0';  // ##NULLDFT
  *in36 = '0';  // ##KEEPCRS

  //  Fehler
  *in99 = '0';

endsr;

//============================================================*
//    c_endPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endPgm;

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

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr bzoff1;
  exsr fill##;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    FILL##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  ##alwLc   = set0012.set_alwLc;
  ##case    = set0012.set_case;
  ##rcdLck  = set0012.set_rcd_lock;
  ##nullDft = set0012.set_null_dft;
  ##keepCrs = set0012.set_keep_crs;
  ##save    = bFalse;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 1;
    pos = 40;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 3;
    pos = 7;
  endif;

endsr;

//============================================================*
//    getUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getUsrSetg;

  //  *CRTPGM
  set0012 = f_getUsrSg('*CRTPGM');

endsr;

//============================================================*
//    savUsrSetg    Sichern der Benutzervoreinstellungen      *
//============================================================*

begsr savUsrSetg;

  //  *CRTPGM
  set0012.set_case = ##case;
  set0012.set_rcd_lock = ##rcdLck;
  set0012.set_alwLc = ##alwLc;
  set0012.set_null_dft = ##nullDft;
  set0012.set_keep_crs = ##keepCrs;
  p_updUsrSg('*CRTPGM': set0012);

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek52fm;

  // - Benutzervoreinstellungen
  exsr getUsrSetg;

  // - Füllen der Bildschirmfelder
  exsr bzoff1;
  exsr fill##;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  o_msgID = '';
  o_msgDta = '';

  // - Darstellung der Befehlstasten
  sfBot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setScreen;

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

