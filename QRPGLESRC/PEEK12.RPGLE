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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

dcl-f peek12fm workstn(*ext) usage(*input:*output)
      usropn infds(workstn) sfile(pbsfl:sflrec);

dcl-f peekfmt usropn infds(peek_01_ds) prefix(f_);

dcl-ds workstn likeds(workstn_t);

dcl-ds peek_01_ds likeds(infds_t);

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,D_INFDS
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,RCDL0200
/COPY QCOPYLE,D_WORKSTN
/COPY QCOPYLE,ShortCmd_D
/COPY QCOPYLE,SCRNFKEYS
/COPY QCOPYLE,SDS

/define internal_prototype
/COPY QCOPYLE,PPEEK12
/undefine internal_prototype

/COPY QCOPYLE,USR8100

dcl-ds rcdl0200 likeds(rcdl0200_t) inz;

dcl-s sfbot           like(int4_t) inz;

dcl-s lastrcdnbr      like(rcdnbr_t) inz;
dcl-s sflpage         like(int4_t) inz;
dcl-s sflrec          like(sflpage   ) inz;
dcl-s sfllastrcd      like(sflpage   ) inz;
dcl-c NBR_F_KEYS const(3);

dcl-s peek21_name     like(pgmcalln_t) inz;
dcl-s peek23_name     like(pgmcalln_t) inz;

//  PEEK21
dcl-s ypgmcmd         char(10) inz(*blanks);
dcl-s ycmddta         like(pgmcmddt_t) inz(*blanks);
dcl-s ymsgid          char(7) inz(*blanks);
dcl-s ymsgdta         char(512) inz(*blanks);

//  PEEK23
dcl-s yfkeys          char(18) dim(32)       inz(*blanks);
dcl-s ynbrofkeys      like(int4_t) inz;

/COPY QCOPYLE,PPEEK21
/COPY QCOPYLE,PPEEK23
/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

/COPY QCOPYLE,CEECNDHDLR

dcl-s isInzsr like(bool_t) inz(bFalse);
dcl-s isExitPgm like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek12;
  i_dsp80         const like(dsp80_t);
  i_copyright     const like(copyrght_t);
  i_fmtname       const like(fmt_t);
  i_fmtmode       const like(mode_t);
  o_rcdl0200            likeds(rcdl0200_t);
  o_fmtnbr              like(int2_t);
  o_msgid               like(msgid_t);
  o_msgdta              like(msgdta_t);
end-pi;
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

dow (isExitPgm = bFalse);

  //  Prüfen Positionierung der Subfile
  if (sfsanr <= 0     )  or
     (sfsanr >  sflrec);
    sfsanr = 1;
  endif;

  //  Modus: DROP/FOLD
  *in86 = sflmde;

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgctl;

  //  "Keine Sätze ..."
  if (*in80 = *off);
    write pbleer;
  endif;

  //  Anzeigen der Befehlstasten
  write pbbot#0;

  select;
  when (sfbot = 2) and
     (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
    write pbbot#2;
  when (sfbot = 3) and
     (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
    write pbbot#3;
  when (sfbot = 4) and
     (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
    write pbbot#4;
  when (sfbot = 5) and
     (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
    write pbbot#5;
  when (sfbot = 6) and
     (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
    write pbbot#6;
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Anzeige der Subfile
  exfmt pbctl;

  //  Nachrichten löschen
  p_rmvpgmmg(sds.pgmname);

  //  Aktuelle Satz-Nr.
  sfsanr = sflcsr;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmname
        : ypgmcmd: ycmddta: ymsgid: ymsgdta);
  if (ymsgid <> *blanks);
    p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
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

  //  Datenfreigabe
  when (ypgmcmd = '*ENTER');
    exsr c_enter;

  //  F24 - Weitere Tasten
  when (ypgmcmd = '*MOREKEYS');
    exsr c_morekeys;

  other;
    //  Falsche Taste gedrückt
    p_wrongkey(workstn.aid: sds.pgmname);
    iter;
  endsl;

enddo;

close peekfmt;

*inlr = *on;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  if (*in80 = *off);
  // Subfile ist leer
  else;
    dow ('1');
      readc pbsfl;
      if (%eof());
        leave;
      endif;

      o_rcdl0200 = $$rcdl0200;
      o_fmtnbr = fmtnbr;
    enddo;
  endif;

  if (o_rcdl0200 <> '');
    isExitPgm = bTrue;
  endif;

endsr;

//============================================================*
//    C_EndPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endpgm;

  write rmvwdw;

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

  o_rcdl0200 = *blanks;
  o_fmtnbr = *zeros;

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr pbfirstrcd;
  exsr pbinit;
  exsr pbsetll;
  exsr pbreadup;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_morekeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    PBInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr pbinit;

  *in89 = '0';
  write msgctl;

  *in80 = '0'; // SFLDSP
  *in81 = '1'; // SFLDSPCTL
  *in82 = '1'; // SFLCLR
  *in83 = '1'; // SFLEND
  write pbctl;

  *in82 = '0'; // SFLCLR

  sflrec = *zeros;

  sfllastrcd = *zeros;

endsr;

//============================================================*
//    PBFirstRcd    Ersten geschriebenen Satz der Subfile     *
//                  einlesen                                  *
//============================================================*

begsr pbfirstrcd;

  if (*in80 = *off);
    lastrcdnbr = 0;
  else;

    chain 1 pbsfl;

    if (not %found());
      lastrcdnbr = 0;
    else;
      lastrcdnbr = recordnbr;
    endif;
  endif;

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr pbreadup;

  dow ('1');
    read fpeekfmt;
    if (%eof());
      *in83 = bTrue;
      leave;
    endif;

    sflrec = sflrec + 1;

    if (sflrec > 9999);
      *in83 = bTrue;
      leave;
    endif;

    exsr pbfill;

    write pbsfl;

    sfllastrcd = sflrec;

    if (sflrec >= sflpage);
      leave;
    endif;
  enddo;

  exsr pbexit;

endsr;

//============================================================*
//    PBExit        Hinter füllen Subfile                     *
//============================================================*

begsr pbexit;

  exsr pbfirstrcd;

endsr;

//============================================================*
//    PBFill        Füllen Subfilesatz                        *
//============================================================*

begsr pbfill;

  sfpau = *blanks;
  rcdl0200 = f_fmt;
  $$rcdl0200 = f_fmt;
  $$format = rcdl0200.r2fmtname;
  $$text = rcdl0200.r2text;
  recordnbr = peek_01_ds.rcdNbr;
  fmtnbr = f_fmtnbr;

  *in80 = '1'; // SFLDSP
  lastrcdnbr = peek_01_ds.rcdNbr;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr pbsetll;

  setll lastrcdnbr fpeekfmt;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setscreen;

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

  sflpage = *hival;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Dateien öffnen
  open peekfmt;

  // - Prüfen auf Satzformat
  if (i_fmtmode = mode_batch) and
     ((peek_01_ds.nbrOfRcd = 1) or (i_fmtname <> ''));
    setll 1 fpeekfmt;
    dou %eof(peekfmt);
      read fpeekfmt;
      if (not %eof(peekfmt));
        rcdl0200 = f_fmt;
        if (rcdl0200.r2fmtname = i_fmtname) or
           ((peek_01_ds.nbrOfRcd = 1) and (i_fmtname = ''));
          o_rcdl0200 = f_fmt;
          o_fmtnbr = f_fmtnbr;
          isExitPgm = bTrue;
          leavesr;
        endif;
      endif;
    enddo;
  endif;

  // - Programm initialisieren
  p_rmvpgmmg(sds.pgmname);

  o_rcdl0200 = *blanks;
  o_fmtnbr = *zeros;
  o_msgid = *blanks;
  o_msgdta = *blanks;

  // - Darstellung der Subfile
  sflmde = '1';

  // - Darstellung der Befehlstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setscreen;

  // - Subfile füllen
  lastrcdnbr = 1;
  exsr pbinit;
  exsr pbsetll;
  exsr pbreadup;

  // - Copyright
  p_sndpgmmg('USR9999': i_copyright: sds.pgmname);

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzsr = bTrue);
    leavesr;
  endif;

  isInzsr = bTrue;

  PGMQ = '*';

  peek21_name = f_pgmcalln('PEEK21');
  peek23_name = f_pgmcalln('PEEK23');

  peek23(sds.pgmname: '*ALL': NBR_F_KEYS
        : yfkeys: ynbrofkeys);
  scrnfkeys = %subarr(yfkeys: 1);

  open peek12fm;

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

