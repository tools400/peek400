**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK49                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 20.01.99  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  "About" Dialog                                               *
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

dcl-f peek49fm workstn(*ext) usage(*input:*output)
      usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,D_WORKSTN
/COPY QCOPYLE,ShortCmd_D
/COPY QCOPYLE,SDS
/COPY QCOPYLE,SCRNFKEYS
/COPY QCOPYLE,CEECNDHDLR

/COPY QCOPYLE,USR8100

/define internal_prototype
/COPY QCOPYLE,PPEEK49
/undefine internal_prototype

/COPY QCOPYLE,PPEEK21
/COPY QCOPYLE,PPEEK23

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-s yfkeys          char(18) dim(32) inz;
dcl-s ynbrofkeys      like(int4_t) inz;
dcl-s ymsgid          char(7) inz;
dcl-s ymsgdta         char(512) inz;

dcl-s ypgmcmd         char(10) inz;
dcl-s ycmddta         like(pgmcmddt_t) inz;

dcl-s sfbot           like(int4_t) inz;
dcl-c nbrfkeys const(2);

dcl-s r$vers          char(2) inz(*blanks);
dcl-s r$modf          char(2) inz(*blanks);
dcl-s r$rels          char(2) inz(*blanks);

dcl-s peek21_name     like(pgmcalln_t) inz;
dcl-s peek23_name     like(pgmcalln_t) inz;

dcl-s isInzSr         like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek49;
  i_dsp80         const like(dsp80_t);
  i_copyright     const like(copyrght_t);
  i_release       const like(release_t);
  i_version       const like(version_t);
  o_msgid               like(msgid_t);
  o_msgdta              like(msgdta_t);
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
  when (sfbot = 7) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#7;
  when (sfbot = 8) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#8;
  when (sfbot = 9) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#9;
  when (sfbot = 10) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#10;
  when (sfbot = 11) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#11;
  when (sfbot = 12) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#12;
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

  //  Abfragen der Programmbefehle
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
      o_msgid = 'USR8112';
      o_msgdta = *blanks;
      leave;
    endif;

  other;
    //  Falsche Taste gedrückt
    p_wrongkey(workstn.aid: sds.pgmname);
    iter;
  endsl;

enddo;

close peek49fm;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;


endsr;

//============================================================*
//    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
//============================================================*

begsr bzoff1;

  //  DSPATR(PC)

  //  DSPATR(RI)

  //  Fehler
  *in99 = '0';

endsr;

//============================================================*
//    C_EndPgm      F3/F12 - Programm beenden                 *
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
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr bzoff1;
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

  $$cpyright = i_copyright;

  $$release = %subst(i_release: 8);
  r$vers = %subst(i_version: 2: 2);
  r$modf = %subst(i_version: 5: 2);
  r$rels = %subst(i_version: 8: 2);

  if (%subst(r$vers: 1: 1) = '0');
    %subst(r$vers: 1: 1) = ' ';
  endif;

  if (%subst(r$modf: 1: 1) = '0');
    %subst(r$modf: 1: 1) = ' ';
  endif;

  if (%subst(r$rels: 1: 1) = '0');
    %subst(r$rels: 1: 1) = ' ';
  endif;

  $$version = 'V ' +
             %trim(r$vers) + '.' +
             %trim(r$modf) + '.' +
             %trim(r$rels);

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setscreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 6;
    zei = zei + 1;
    pos = 26;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 4;
    zei = zei + 3;
    pos = 7;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek49fm;

  // - Füllen der Bildschirmfelder
  exsr bzoff1;
  exsr fill##;

  // - Programm initialisieren
  p_rmvpgmmg(sds.pgmname);

  o_msgid = *blanks;
  o_msgdta = *blanks;

  // - Darstellung der Befehlstasten
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

