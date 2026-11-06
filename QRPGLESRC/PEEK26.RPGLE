**free
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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

dcl-f peek26fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,D_COLORATR
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK26
/undefine internal_prototype

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8151
/copy QCOPYLE,USR8152
/copy QCOPYLE,USR8153
/copy QCOPYLE,USR8154
/copy QCOPYLE,USR8155

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s YMsgID char(7);
dcl-s YMsgDta char(512);

dcl-s YPgmCmd char(10);
dcl-s YCmdDta like(pgmCmdDt_t);

dcl-s sfbot like(int4_t);
dcl-c NbrFKeys 2;

dcl-s peek21_name like(pgmCallN_t);
dcl-s peek23_name like(pgmCallN_t);

dcl-s R_SrcFile like(i_qSrcFile.name);
dcl-s R_SrcLib like(i_qSrcFile.lib);
dcl-s R_SrcMbr like(i_srcMbr);

//  Werte beim Öffnen des Fensters, F5 stellt sie wieder her
dcl-s R_File like(file_t);
dcl-s r_library like(lib_t);
dcl-s R_Member like(mbr_t);
dcl-s r_mbropt like(option_t);
dcl-s r_crtfile like(option_t);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek26;
  i_dsp80    like(dsp80_t) const;
  i_qSrcFile likeds(qObj_t) const;
  i_srcMbr   like(mbr_t) const;
  o_toFile   like(file_t);
  o_TOLIB    like(lib_t);
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

exsr First;

//  Schleife für Programmbearbeitung

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
  other;
    write pbbot#1;
    sfbot = 1;
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

  //  F12 - Ende
  when (YPgmCmd = '*CANCEL');
    exsr C_EndPgm;
    leave;

  //  F24 - Weitere Tasten
  when (YPgmCmd = '*MOREKEYS');
    exsr C_MoreKeys;

  //  Datenfreigabe
  when (YPgmCmd = '*ENTER');
    exsr C_Enter;
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
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  exsr prfb1;

  if (*in99 = *off);
    o_toFile = ##File;
    o_TOLIB = ##Library;
    o_toMbr = ##Member;
    o_mbrOpt = ##MbrOpt;
    o_crtFile = ##CrtFile;
    o_msgID = 'USR8112';
    o_msgDta = *blanks;
  endif;

endsr;

//============================================================*
//    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
//============================================================*

begsr bzoff1;

  //  DSPATR(PC)
  *in20 = '0';   // ##File
  *in21 = '0';   // ##Library
  *in22 = '0';   // ##Member
  *in23 = '0';   // ##MbrOpt
  *in24 = '0';   // ##CrtFile

  //  DSPATR(RI)
  *in30 = '0';   // ##File
  *in31 = '0';   // ##Library
  *in32 = '0';   // ##Member
  *in33 = '0';   // ##MbrOpt
  *in34 = '0';   // ##CrtFile

  //  Fehler
  *in99 = '0';

endsr;

//============================================================*
//    PRFB1         Prüfen der Eingaben                       *
//============================================================*

begsr prfb1;

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

    if (##File = '' or f_vldName(##File: YMsgID: YMsgDta) = bFalse);
      YMsgID = '';
      YMsgDta = '';
      *in99 = '1';
      clear usr8151.var1;
      usr8151.var1 = ##File;
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

    if (##Library = '');
      *in99 = '1';
      clear usr8152.var1;
      usr8152.var1 = ##Library;
      p_sndPgmMg('USR8152': usr8152: sds.pgmName);
      leave;
    endif;

    if (%subst(##Library: 1: 1) = '*');
      //  Sonderwerte ...
      if (##Library = '*LIBL' or ##Library = '*CURLIB');
      //  ... gültig
      else;
        //  ... ungültig
        *in99 = '1';
        clear usr8152;
        usr8152.var1 = ##Library;
        p_sndPgmMg('USR8152': usr8152: sds.pgmName);
        leave;
      endif;
    elseif (f_vldName(##Library: YMsgID: YMsgDta) = bFalse);
      YMsgID = '';
      YMsgDta = '';
      *in99 = '1';
      clear usr8152;
      usr8152.var1 = ##Library;
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

    if (##Member = '');
      *in99 = '1';
      clear usr8153;
      usr8153.var1 = ##Member;
      p_sndPgmMg('USR8153': usr8153: sds.pgmName);
      leave;
    endif;

    if (%subst(##Member: 1: 1) = '*');
      //  Sonderwerte ...
      if (##Member = '*FIRST');
      //  ... gültig
      else;
        //  ... ungültig
        *in99 = '1';
        clear usr8153;
        usr8153.var1 = ##Member;
        p_sndPgmMg('USR8153': usr8153: sds.pgmName);
        leave;
      endif;
    elseif (f_vldName(##Member: YMsgID: YMsgDta) = bFalse);
      YMsgID = '';
      YMsgDta = '';
      *in99 = '1';
      clear usr8153;
      usr8153.var1 = ##Member;
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

    if (##MbrOpt <> '*ADD'
       and ##MbrOpt <> '*REPLACE'
       and ##MbrOpt <> '*UPDADD');
      *in99 = '1';
      clear usr8154;
      usr8154.var1 = ##MbrOpt;
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

    if (##CrtFile <> '*YES' and ##CrtFile <> '*NO');
      *in99 = '1';
      *in24 = '1';
      *in34 = '1';
      clear usr8155;
      usr8155.var1 = ##CrtFile;
      p_sndPgmMg('USR8155': usr8155: sds.pgmName);
      leave;
    endif;

    //  CPYF lässt *LIBL mit CRTFILE(*YES) nicht zu (CPF2877)
    if (##CrtFile = '*YES' and ##Library = '*LIBL');
      *in99 = '1';
      *in21 = '1';
      *in31 = '1';
      clear usr8152;
      usr8152.var1 = ##Library;
      p_sndPgmMg('USR8152': usr8152: sds.pgmName);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    C_EndPgm      F12    - Programm beenden                 *
//============================================================*

begsr C_EndPgm;

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
//    C_Refresh     F5  - Eingaben verwerfen                  *
//============================================================*

begsr C_Refresh;

  //  Werte beim Öffnen des Fensters wiederherstellen
  ##File = R_File;
  ##Library = r_library;
  ##Member = R_Member;
  ##MbrOpt = r_mbropt;
  ##CrtFile = r_crtfile;

  exsr fill##;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    FILL##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  if (##Library = '');
    ##Library = '*LIBL';
  endif;

  if (##Member = '');
    ##Member = '*FIRST';
  endif;

  if (##MbrOpt = '');
    ##MbrOpt = '*ADD';
  endif;

  if (##CrtFile = '');
    ##CrtFile = '*NO';
  endif;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

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

begsr First;

  // - Quelldatei hat gewechselt ...
  if (i_qSrcFile.name <> R_SrcFile or
     i_qSrcFile.lib <> R_SrcLib or
     i_srcMbr <> R_SrcMbr);
    ##File = *blanks;
    ##Library = *blanks;
    ##Member = i_srcMbr;
    R_SrcFile = i_qSrcFile.name;
    R_SrcLib = i_qSrcFile.lib;
    R_SrcMbr = i_srcMbr;
  else;
  // - Quelldatei hat nicht gewechselt ...
  //              alte Werte stehenlassen
  endif;

  ##MbrOpt = *blanks;
  ##CrtFile = *blanks;

  // - Öffnen der Dateien
  open peek26fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Bildschirmfelder füllen
  exsr fill##;

  // - Werte für F5 merken
  R_File = ##File;
  r_library = ##Library;
  R_Member = ##Member;
  r_mbropt = ##MbrOpt;
  r_crtfile = ##CrtFile;

  //  Löschen der Cursorosition
  CsrRow = *zeros;
  CsrCol = *zeros;

  // - Einstellen Darstellung der Funktionstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr SetScreen;

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

