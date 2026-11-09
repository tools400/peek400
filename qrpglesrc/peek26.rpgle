**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Kopieren Datensatz in externe Datei          *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.5.0                               *
//  Programm : PEEK26                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 31.10.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Kopieren Datensatz in externe Datei.              *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peek26fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/d_coloratr.rpgleinc'
/copy 'qcopyle/shortcmd_d.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek26.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/usr8100.rpgleinc'
/copy 'qcopyle/usr8151.rpgleinc'
/copy 'qcopyle/usr8152.rpgleinc'
/copy 'qcopyle/usr8153.rpgleinc'
/copy 'qcopyle/usr8154.rpgleinc'
/copy 'qcopyle/usr8155.rpgleinc'

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s yMsgID char(7);
dcl-s yMsgDta char(512);

dcl-s yPgmCmd char(10);
dcl-s yCmdDta like(pgmCmdDt_t);

dcl-s sfBot like(int4_t);
dcl-c NbrFKeys 2;

dcl-s peek21_name like(pgmCallN_t);
dcl-s peek23_name like(pgmCallN_t);

dcl-s r_srcFile like(i_qSrcFile.name);
dcl-s r_srcLib like(i_qSrcFile.lib);
dcl-s r_srcMbr like(i_srcMbr);

//  Werte beim Öffnen des Fensters, F5 stellt sie wieder her
dcl-s r_file like(file_t);
dcl-s r_library like(lib_t);
dcl-s r_member like(mbr_t);
dcl-s r_mbrOpt like(option_t);
dcl-s r_crtFile like(option_t);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek26;
  i_dsp80    like(dsp80_t) const;
  i_qSrcFile likeds(qObj_t) const;
  i_srcMbr   like(mbr_t) const;
  o_toFile   like(file_t);
  o_toLib    like(lib_t);
  o_toMbr    like(mbr_t);
  o_mbrOpt   like(option_t);
  o_crtFile  like(option_t);
  o_msgID    like(msgId_t);
  o_msgDta   like(msgDta_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

//  Schleife für Programmbearbeitung

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
  other;
    write pbbot#1;
    sfBot = 1;
  endsl;

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

  //  F24 - Weitere Tasten
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;

  //  Datenfreigabe
  when (yPgmCmd = '*ENTER');
    exsr c_enter;
    if (*in99 = *off);
      leave;
    endif;

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peek26fm;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr prfB1;

  if (*in99 = *off);
    o_toFile = ##file;
    o_toLib = ##library;
    o_toMbr = ##member;
    o_mbrOpt = ##mbrOpt;
    o_crtFile = ##crtFile;
    o_msgID = 'USR8112';
    o_msgDta = *blanks;
  endif;

endsr;

//============================================================*
//    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
//============================================================*

begsr bzoff1;

  //  DSPATR(PC)
  *in20 = '0';   // ##file
  *in21 = '0';   // ##library
  *in22 = '0';   // ##member
  *in23 = '0';   // ##mbrOpt
  *in24 = '0';   // ##crtFile

  //  DSPATR(RI)
  *in30 = '0';   // ##file
  *in31 = '0';   // ##library
  *in32 = '0';   // ##member
  *in33 = '0';   // ##mbrOpt
  *in34 = '0';   // ##crtFile

  //  Fehler
  *in99 = '0';

endsr;

//============================================================*
//    PRFB1         Prüfen der Eingaben                       *
//============================================================*

begsr prfB1;

  dou ('1');

    exsr prf20;         // File
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf21;         // Library
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf22;         // Member
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf23;         // MbrOpt
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf24;         // CrtFile
    if (*in99 = bTrue);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PRF20         Prüfen:  Datei                            *
//============================================================*

begsr prf20;

  dou ('1');

    if (##file = '' or f_vldName(##file: yMsgID: yMsgDta) = bFalse);
      yMsgID = '';
      yMsgDta = '';
      *in99 = '1';
      clear usr8151.var1;
      usr8151.var1 = ##file;
      p_sndPgmMg('USR8151': usr8151: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in20 = '1';
    *in30 = '1';
  endif;

endsr;

//============================================================*
//    PRF21         Prüfen:  Bibliothek                       *
//============================================================*

begsr prf21;

  dou ('1');

    if (##library = '');
      *in99 = '1';
      clear usr8152.var1;
      usr8152.var1 = ##library;
      p_sndPgmMg('USR8152': usr8152: sds.pgmName);
      leave;
    endif;

    if (%subst(##library: 1: 1) = '*');
      //  Sonderwerte ...
      if (##library = '*LIBL' or ##library = '*CURLIB');
      //  ... gültig
      else;
        //  ... ungültig
        *in99 = '1';
        clear usr8152;
        usr8152.var1 = ##library;
        p_sndPgmMg('USR8152': usr8152: sds.pgmName);
        leave;
      endif;
    elseif (f_vldName(##library: yMsgID: yMsgDta) = bFalse);
      yMsgID = '';
      yMsgDta = '';
      *in99 = '1';
      clear usr8152;
      usr8152.var1 = ##library;
      p_sndPgmMg('USR8152': usr8152: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in21 = '1';
    *in31 = '1';
  endif;

endsr;

//============================================================*
//    PRF22         Prüfen:  Teildatei                        *
//============================================================*

begsr prf22;

  dou ('1');

    if (##member = '');
      *in99 = '1';
      clear usr8153;
      usr8153.var1 = ##member;
      p_sndPgmMg('USR8153': usr8153: sds.pgmName);
      leave;
    endif;

    if (%subst(##member: 1: 1) = '*');
      //  Sonderwerte ...
      if (##member = '*FIRST');
      //  ... gültig
      else;
        //  ... ungültig
        *in99 = '1';
        clear usr8153;
        usr8153.var1 = ##member;
        p_sndPgmMg('USR8153': usr8153: sds.pgmName);
        leave;
      endif;
    elseif (f_vldName(##member: yMsgID: yMsgDta) = bFalse);
      yMsgID = '';
      yMsgDta = '';
      *in99 = '1';
      clear usr8153;
      usr8153.var1 = ##member;
      p_sndPgmMg('USR8153': usr8153: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in22 = '1';
    *in32 = '1';
  endif;

endsr;

//============================================================*
//    PRF23         Prüfen:  Member Option                    *
//============================================================*

begsr prf23;

  dou ('1');

    if (##mbrOpt <> '*ADD'
       and ##mbrOpt <> '*REPLACE'
       and ##mbrOpt <> '*UPDADD');
      *in99 = '1';
      clear usr8154;
      usr8154.var1 = ##mbrOpt;
      p_sndPgmMg('USR8154': usr8154: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in23 = '1';
    *in33 = '1';
  endif;

endsr;

//============================================================*
//    PRF24         Prüfen:  Datei erstellen                  *
//============================================================*

begsr prf24;

  dou ('1');

    if (##crtFile <> '*YES' and ##crtFile <> '*NO');
      *in99 = '1';
      *in24 = '1';
      *in34 = '1';
      clear usr8155;
      usr8155.var1 = ##crtFile;
      p_sndPgmMg('USR8155': usr8155: sds.pgmName);
      leave;
    endif;

    //  CPYF lässt *LIBL mit CRTFILE(*YES) nicht zu (CPF2877)
    if (##crtFile = '*YES' and ##library = '*LIBL');
      *in99 = '1';
      *in21 = '1';
      *in31 = '1';
      clear usr8152;
      usr8152.var1 = ##library;
      p_sndPgmMg('USR8152': usr8152: sds.pgmName);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    c_endPgm      F12    - Programm beenden                 *
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
//    c_refresh     F5  - Eingaben verwerfen                  *
//============================================================*

begsr c_refresh;

  //  Werte beim Öffnen des Fensters wiederherstellen
  ##file = r_file;
  ##library = r_library;
  ##member = r_member;
  ##mbrOpt = r_mbrOpt;
  ##crtFile = r_crtFile;

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

  if (##library = '');
    ##library = '*LIBL';
  endif;

  if (##member = '');
    ##member = '*FIRST';
  endif;

  if (##mbrOpt = '');
    ##mbrOpt = '*ADD';
  endif;

  if (##crtFile = '');
    ##crtFile = '*NO';
  endif;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 8;
    pos = 26;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 6;
    pos = 7;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Quelldatei hat gewechselt ...
  if (i_qSrcFile.name <> r_srcFile or
     i_qSrcFile.lib <> r_srcLib or
     i_srcMbr <> r_srcMbr);
    ##file = *blanks;
    ##library = *blanks;
    ##member = i_srcMbr;
    r_srcFile = i_qSrcFile.name;
    r_srcLib = i_qSrcFile.lib;
    r_srcMbr = i_srcMbr;
  else;
  // - Quelldatei hat nicht gewechselt ...
  //              alte Werte stehenlassen
  endif;

  ##mbrOpt = *blanks;
  ##crtFile = *blanks;

  // - Öffnen der Dateien
  open peek26fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Bildschirmfelder füllen
  exsr fill##;

  // - Werte für F5 merken
  r_file = ##file;
  r_library = ##library;
  r_member = ##member;
  r_mbrOpt = ##mbrOpt;
  r_crtFile = ##crtFile;

  //  Löschen der Cursorosition
  csrRow = *zeros;
  csrCol = *zeros;

  // - Einstellen Darstellung der Funktionstasten
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

