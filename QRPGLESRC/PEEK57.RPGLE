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
dcl-s ypgmcmd char(10) inz(*blanks);
dcl-s ycmddta like(pgmcmddt_t);
dcl-s ymsgid char(7) inz(*blanks);
dcl-s ymsgdta char(512) inz(*blanks);

//  Peek23:
dcl-s yfkeys char(18) dim(32);
dcl-s ynbrofkeys like(int4_t);

dcl-s sfbot like(int4_t);
dcl-c nbrfkeys 2;
dcl-s ispgmerror like(bool_t) inz(bFalse);

dcl-s peek21_name like(pgmcalln_t);
dcl-s peek23_name like(pgmcalln_t);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek57;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  i_envfile   like(file_t) const;
  i_envlib    like(lib_t) const;
  i_envmbr    like(mbr_t) const;
  i_envtext   like(text_t) const;
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
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
  *in70 = '0';

  //  Nachrichten löschen
  p_rmvpgmmg(sds.pgmname);

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

  //  F9  - Löschen Arbeitsumgebung
  //  (nach dem Löschen zurück zur Liste; bei einem Fehler bleibt das
  //  Fenster mit der Meldung offen)
  when (ypgmcmd = '*DELETEENV');
    exsr c_delenv;
    if (ispgmerror = bTrue);
      iter;
    else;
      leave;
    endif;

  //  F12 - Ende
  when (ypgmcmd = '*CANCEL');
    exsr c_endpgm;
    leave;

  //  F24 - Weitere Tasten
  when (ypgmcmd = '*MOREKEYS');
    exsr c_morekeys;

  other;
    //  Falsche Taste gedrückt
    p_wrongkey(workstn.aid: sds.pgmname);
    iter;
  endsl;

enddo;

close peek57fm;

return;

//============================================================*
//    C_EndPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endpgm;

  p_rmvpgmmg(sds.pgmname);

  o_msgid = 'USR8100';
  usr8100.var1 = ypgmcmd;
  o_msgdta = usr8100;

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr fill##;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_morekeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    C_delEnv      Verarbeiten der Eingaben                  *
//============================================================*

begsr c_delenv;

  f_execute('RMVM'          +
           ' FILE('        +
           %trim(i_envlib ) +
           '/'             +
           %trim(i_envfile) +
           ')'             +
           ' MBR('         +
           %trim(i_envmbr ) +
           ')'             :
           ymsgid          :
           ymsgdta         );

  if (ymsgid <> '');
    p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
    ymsgid = '';
    ymsgdta = '';
    ispgmerror = bTrue;
  else;
    ispgmerror = bFalse;
  endif;

endsr;

//============================================================*
//    FILL##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  ##file  = i_envfile;
  ##lib   = i_envlib;
  ##mbr   = i_envmbr;
  ##text  = i_envtext;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setscreen;

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
  p_rmvpgmmg(sds.pgmname);

  // - Rückkehrcode
  o_msgid = *blanks;
  o_msgdta = *blanks;

  // - Darstellung der Befehlstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setscreen;

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
  dcl-pi *n;
    i_condtoken    likeds(cee_fc_t) value;
    i_pcommarea    int(10) value;
    o_action       int(10);
    o_newcondtoken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

