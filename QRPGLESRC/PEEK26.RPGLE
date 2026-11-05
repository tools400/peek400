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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

dcl-f peek26fm workstn(*ext) usage(*input:*output)
      usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,D_WORKSTN
/COPY QCOPYLE,D_COLORATR
/COPY QCOPYLE,ShortCmd_D
/COPY QCOPYLE,SDS
/COPY QCOPYLE,SCRNFKEYS
/COPY QCOPYLE,CEECNDHDLR

/define internal_prototype
/COPY QCOPYLE,PPEEK26
/undefine internal_prototype

/COPY QCOPYLE,USR8100
/COPY QCOPYLE,USR8151
/COPY QCOPYLE,USR8152
/COPY QCOPYLE,USR8153
/COPY QCOPYLE,USR8154
/COPY QCOPYLE,USR8155

/COPY QCOPYLE,PPEEK21
/COPY QCOPYLE,PPEEK23

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-s yfkeys          char(18) dim(32);
dcl-s ynbrofkeys      like(int4_t);
dcl-s ymsgid          char(7);
dcl-s ymsgdta         char(512);

dcl-s ypgmcmd         char(10);
dcl-s ycmddta         like(pgmcmddt_t);

dcl-s sfbot           like(int4_t);
dcl-c nbrfkeys const(2);

dcl-s peek21_name     like(pgmcalln_t);
dcl-s peek23_name     like(pgmcalln_t);

dcl-s r_srcfile       like(i_qsrcfile.name);
dcl-s r_srclib        like(i_qsrcfile.lib);
dcl-s r_srcmbr        like(i_srcmbr);

//  Werte beim Öffnen des Fensters, F5 stellt sie wieder her
dcl-s r_file          like(file_t);
dcl-s r_library       like(lib_t);
dcl-s r_member        like(mbr_t);
dcl-s r_mbropt        like(option_t);
dcl-s r_crtfile       like(option_t);

dcl-s isInzSr         like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek26;
  i_dsp80         const like(dsp80_t);
  i_qsrcfile      const likeds(qobj_t);
  i_srcmbr        const like(mbr_t);
  o_tofile              like(file_t);
  o_tolib               like(lib_t);
  o_tombr               like(mbr_t);
  o_mbropt              like(option_t);
  o_crtfile             like(option_t);
  o_msgid               like(msgid_t);
  o_msgdta              like(msgdta_t);
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
  write msgctl;

  //  Anzeigen der Befehlstasten
  select;
  when (sfbot = 2) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#2;
  when (sfbot = 3) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#3;
  when (sfbot = 4) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#4;
  when (sfbot = 5) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#5;
  when (sfbot = 6) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#6;
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Anzeigen Bildschirm
  exfmt bild01;

  //  Nachrichten löschen
  p_rmvpgmmg(sds.pgmname);

  //  Bezugszahlen löschen
  exsr bzoff1;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmname
        : ypgmcmd: ycmddta: ymsgid: ymsgdta);
  if (ymsgid <> *blanks);
    p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
    ymsgid = '';
    ymsgdta = '';
    iter;
  endif;

  //  Abfragen der Befehlstasten
  select;
  //  F3  - Ende
  when (ypgmcmd = '*EXIT');
    exsr c_endpgm;
    leave;

  //  F5  - Aktualisieren
  when (ypgmcmd = '*REFRESH');
    exsr c_refresh;
    iter;

  //  F12 - Ende
  when (ypgmcmd = '*CANCEL');
    exsr c_endpgm;
    leave;

  //  F24 - Weitere Tasten
  when (ypgmcmd = '*MOREKEYS');
    exsr c_morekeys;

  //  Datenfreigabe
  when (ypgmcmd = '*ENTER');
    exsr c_enter;
    if (*in99 = *off);
      leave;
    endif;

  other;
    //  Falsche Taste gedrückt
    p_wrongkey(workstn.aid: sds.pgmname);
    iter;
  endsl;

enddo;

close peek26fm;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr prfb1;

  if (*in99 = *off);
    o_tofile = ##file;
    o_tolib = ##library;
    o_tombr = ##member;
    o_mbropt = ##mbropt;
    o_crtfile = ##crtfile;
    o_msgid = 'USR8112';
    o_msgdta = *blanks;
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

    if (##file = '' or f_vldname(##file: ymsgid: ymsgdta) = bFalse);
      ymsgid = '';
      ymsgdta = '';
      *in99 = '1';
      clear usr8151.var1;
      usr8151.var1 = ##file;
      p_sndpgmmg('USR8151': usr8151: sds.pgmname);
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
      p_sndpgmmg('USR8152': usr8152: sds.pgmname);
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
        p_sndpgmmg('USR8152': usr8152: sds.pgmname);
        leave;
      endif;
    elseif (f_vldname(##library: ymsgid: ymsgdta) = bFalse);
      ymsgid = '';
      ymsgdta = '';
      *in99 = '1';
      clear usr8152;
      usr8152.var1 = ##library;
      p_sndpgmmg('USR8152': usr8152: sds.pgmname);
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
      p_sndpgmmg('USR8153': usr8153: sds.pgmname);
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
        p_sndpgmmg('USR8153': usr8153: sds.pgmname);
        leave;
      endif;
    elseif (f_vldname(##member: ymsgid: ymsgdta) = bFalse);
      ymsgid = '';
      ymsgdta = '';
      *in99 = '1';
      clear usr8153;
      usr8153.var1 = ##member;
      p_sndpgmmg('USR8153': usr8153: sds.pgmname);
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

    if (##mbropt <> '*ADD'
       and ##mbropt <> '*REPLACE'
       and ##mbropt <> '*UPDADD');
      *in99 = '1';
      clear usr8154;
      usr8154.var1 = ##mbropt;
      p_sndpgmmg('USR8154': usr8154: sds.pgmname);
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

    if (##crtfile <> '*YES' and ##crtfile <> '*NO');
      *in99 = '1';
      *in24 = '1';
      *in34 = '1';
      clear usr8155;
      usr8155.var1 = ##crtfile;
      p_sndpgmmg('USR8155': usr8155: sds.pgmname);
      leave;
    endif;

    //  CPYF lässt *LIBL mit CRTFILE(*YES) nicht zu (CPF2877)
    if (##crtfile = '*YES' and ##library = '*LIBL');
      *in99 = '1';
      *in21 = '1';
      *in31 = '1';
      clear usr8152;
      usr8152.var1 = ##library;
      p_sndpgmmg('USR8152': usr8152: sds.pgmname);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    C_EndPgm      F12    - Programm beenden                 *
//============================================================*

begsr c_endpgm;

  p_rmvpgmmg(sds.pgmname);

  o_msgid = 'USR8100';

  select;
  when (workstn.aid = k_f3);
    usr8100.var1 = 'F3';
  when (workstn.aid = k_f12);
    usr8100.var1 = 'F12';
  other;
    usr8100.var1 = 'Fxx';
  endsl;

  o_msgdta = usr8100;

endsr;

//============================================================*
//    C_Refresh     F5  - Eingaben verwerfen                  *
//============================================================*

begsr c_refresh;

  //  Werte beim Öffnen des Fensters wiederherstellen
  ##file = r_file;
  ##library = r_library;
  ##member = r_member;
  ##mbropt = r_mbropt;
  ##crtfile = r_crtfile;

  exsr fill##;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_morekeys;

  sfbot = sfbot + 1;

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

  if (##mbropt = '');
    ##mbropt = '*ADD';
  endif;

  if (##crtfile = '');
    ##crtfile = '*NO';
  endif;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setscreen;

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
  if (i_qsrcfile.name <> r_srcfile or
     i_qsrcfile.lib <> r_srclib or
     i_srcmbr <> r_srcmbr);
    ##file = *blanks;
    ##library = *blanks;
    ##member = i_srcmbr;
    r_srcfile = i_qsrcfile.name;
    r_srclib = i_qsrcfile.lib;
    r_srcmbr = i_srcmbr;
  else;
  // - Quelldatei hat nicht gewechselt ...
  //              alte Werte stehenlassen
  endif;

  ##mbropt = *blanks;
  ##crtfile = *blanks;

  // - Öffnen der Dateien
  open peek26fm;

  // - Programm initialisieren
  p_rmvpgmmg(sds.pgmname);

  o_msgid = *blanks;
  o_msgdta = *blanks;

  // - Bildschirmfelder füllen
  exsr fill##;

  // - Werte für F5 merken
  r_file = ##file;
  r_library = ##library;
  r_member = ##member;
  r_mbropt = ##mbropt;
  r_crtfile = ##crtfile;

  //  Löschen der Cursorosition
  csrrow = *zeros;
  csrcol = *zeros;

  // - Einstellen Darstellung der Funktionstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setscreen;

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

  peek21_name = f_pgmcalln('PEEK21');
  peek23_name = f_pgmcalln('PEEK23');

  peek23(sds.pgmname: '*ALL': 0
        : yfkeys: ynbrofkeys);
  scrnfkeys = %subarr(yfkeys: 1);

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

