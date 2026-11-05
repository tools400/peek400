**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.5.0                               *
//  Programm : PEEK47                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 11.12.1998  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Auswahl Teildatei                                 *
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

dcl-f peek47fm workstn(*ext) usage(*input:*output)
      usropn infds(workstn) sfile(pbsfl:sflrec);

dcl-ds workstn likeds(workstn_t);

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,D_WORKSTN
/COPY QCOPYLE,ShortCmd_D
/COPY QCOPYLE,SDS
/COPY QCOPYLE,MBRL0200
/COPY QCOPYLE,SCRNFKEYS
/COPY QCOPYLE,CEECNDHDLR

/COPY QCOPYLE,USR8100
/COPY QCOPYLE,USR8110
/COPY QCOPYLE,USR8180
/COPY QCOPYLE,USR8209

/define internal_prototype
/COPY QCOPYLE,PPEEK47
/undefine internal_prototype

/COPY QCOPYLE,PPEEK21
/COPY QCOPYLE,PPEEK23
/COPY QCOPYLE,PPEEK27
/COPY QCOPYLE,PPEEK46

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-s yfkeys          char(18) dim(32);
dcl-s ynbrofkeys      like(int4_t);
dcl-s ymsgid          char(7);
dcl-s ymsgdta         char(512);

dcl-s ypgmcmd         char(10);
dcl-s ycmddta         like(pgmcmddt_t);

dcl-s ychoice         char(75) dim(32);
dcl-s ynbrofch        like(int4_t);

dcl-s isnewpos        char(1) inz(bFalse);
dcl-s isfound         char(1) inz(bFalse);
dcl-s isSflError      char(1) inz(bFalse);

dcl-s sftop           like(int4_t);
dcl-s sflpage         like(int4_t);
dcl-s sflpagedds      like(sflpage);
dcl-s sflrec          like(sflpage);
dcl-s sflnbrrcd       like(sflpage);
dcl-s sfbot           like(int4_t);
dcl-s sfl_cmd         char(10);
dcl-c nbrfkeys const(3);

dcl-s peek21_name     like(pgmcalln_t);
dcl-s peek23_name     like(pgmcalln_t);
dcl-s peek27_name     like(pgmcalln_t);
dcl-s peek46_name     like(pgmcalln_t);

dcl-s r_mbr           like(##mbr);
dcl-s lstmbr          like(##mbr);
dcl-s lstnbrrcd       like(sflpage);

dcl-s wrk_sfsanr      like(sfsanr);

dcl-s rc              like(int4_t);
dcl-s nummbr          like(int4_t);

dcl-ds mbrl0200 likeds(mbrl0200_t);

dcl-s isInzSr         like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek47;
  i_dsp80         const like(dsp80_t);
  i_copyright     const like(copyrght_t);
  i_qfile         const likeds(qobj_t);
  i_mbr           like(mbr_t);
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
end-pi;

dcl-s do_x2           packed(7);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

//---------------------------------------------------*
//  Schleife für Programmbearbeitung

dow ('1');

  //  Prüfen Positionierung der Subfile
  if (sfsanr <= *zeros);
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

  //  Anzeigen der Einzelauswahlen
  if sftop > 32
     or sftop > ynbrofch;
    sftop = 1;
  endif;
  $$choice = ychoice(sftop);

  //  Trennlinie
  write pbbot#0;
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
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Anzeige der Subfile
  exfmt pbctl;
  *in70 = '0';

  //  Nachrichten löschen
  p_rmvpgmmg(sds.pgmname);

  //  Aktuelle Satz-Nr.
  if (sflcsr > *zeros);
    sfsanr = sflcsr;
  endif;

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

  //  F16 - Suchen
  when (ypgmcmd = '*SEARCH');
    exsr c_search;
    iter;

  //   F17 - Anfang Datensatz
  when (ypgmcmd = '*TOP');
    exsr c_top;
    iter;

  //   F18 - Ende Datensatz
  when (ypgmcmd = '*BOT');
    exsr c_bot;
    iter;

  //  F23 - Weitere Auswahlen
  when (ypgmcmd = '*MOREOPT');
    exsr c_moreopt;

  //  F24 - Weitere Tasten
  when (ypgmcmd = '*MOREKEYS');
    exsr c_morekeys;

  //  Datenfreigabe
  when (ypgmcmd = '*ENTER');
    exsr c_enter;
    if (i_mbr = *blanks);
    //  ... keine Auswahl getroffen, weiter machen
    else;
      leave;
    endif;
  //  Page up
  when (ypgmcmd = '*PAGEUP');
  //  Page down
  when (ypgmcmd = '*PAGEDOWN');

  other;
    //  Falsche Taste gedrückt
    p_wrongkey(workstn.aid: sds.pgmname);
    iter;
  endsl;

enddo;

close peek47fm;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr vreadc;

  if (##mbr <> '');
    exsr c_search;
  endif;

endsr;

//============================================================*
//    C_Search      F16 - Suchen                              *
//============================================================*

begsr c_search;

  if (##mbr <> '');
    lstmbr = ##mbr;
    ##mbr = *blanks;
  endif;

  if (lstmbr = '');
    *in70 = '1';
    clear usr8209;
    p_sndpgmmg('USR8209': usr8209: sds.pgmname);
  else;
    exsr postombr;
    if (isnewpos = bTrue);
      sfsanr = wrk_sfsanr;
    endif;
  endif;

endsr;

//============================================================*
//    PosToMbr      Subfile neu positionieren                 *
//============================================================*

begsr postombr;

  if (lstmbr <> r_mbr);
    lstnbrrcd = 0;
  endif;

  if (lstmbr = '');
    isnewpos = bFalse;
    lstnbrrcd = 0;
  else;

    exsr srchmbr;
    if (isfound = bFalse);
      isnewpos = bFalse;
      clear usr8180;
      usr8180.var1 = lstmbr;
      p_sndpgmmg('USR8180': usr8180: sds.pgmname);
    else;
      isnewpos = bTrue;
    endif;
  endif;

  r_mbr = lstmbr;

endsr;

//============================================================*
//    SrchMbr       Suchen Member in Subfile                  *
//============================================================*

begsr srchmbr;

  if (*in80 = *off);
    isfound = bFalse;
  else;

    isfound = bFalse;
    lstnbrrcd = lstnbrrcd + 1;

    for sflrec = lstnbrrcd to sflnbrrcd;
      chain(e) sflrec pbsfl;
      *in11 = %error or not %found;
      if (*in11 = *on);
        isfound = bFalse;
        leave;
      endif;

      if lstmbr =
         %subst($$mnme: 1:(f_scan(' ':
                               lstmbr) - 1));
        isfound = bTrue;
        leave;
      else;
        if (sfpau <> '');
          //  ... Satz geändert
          exsr vsfpauchg;
        else;
          //  ... Satz nicht geändert
          exsr vsfpauclr;
        endif;
        update pbsfl;
        iter;
      endif;

    endfor;

    if (isfound = bTrue);
      wrk_sfsanr = sflrec;
      lstnbrrcd = sflrec;
    else;
      wrk_sfsanr = 0;
      lstnbrrcd = 0;
    endif;

  endif;

endsr;

//============================================================*
//    SrchInit      Initialisieren Suchfunktion               *
//============================================================*

begsr srchinit;

  lstmbr    = ' ';
  lstnbrrcd = 0;
  r_mbr     = lstmbr;

endsr;

//============================================================*
//    VReadC        Verarbeiten der Subfileauswahlen          *
//============================================================*

begsr vreadc;

  isSflError = bFalse;

  if (*in80 = *off);
  //   keine Einträge in Subfile vorhanden ...
  else;

    for do_x2 = 1 to sflnbrrcd;
      readc pbsfl;
      *in11 = %eof;
      if (*in11 = *on);
        leave;
      endif;

      chain sflrec pbsfl;
      *in11 = not %found;

      //  Cursorpositionierung ...
      if (isSflError = bFalse);
        sflcsr = sflrec;
      else;
      //  Subfile nicht neu positionieren
      endif;

      //  Linksbündig setzen ...
      sfpau = %triml(sfpau);

      //  Zuordnung AUSWAHL => Befehl ...
      peek21('#' + sfpau: sds.pgmname
            : ypgmcmd: ycmddta: ymsgid: ymsgdta);
      if (ymsgid <> '');
        //  Fehlermeldung ...
        p_sndpgmmg('USR8110': sfpau: sds.pgmname);
        exsr vsfpauerr;
        update pbsfl;
        isSflError = bTrue;
        iter;
      endif;

      //----------------------------*
      //  Ausführen SFL-Befehl ...  *
      //----------------------------*
      sfl_cmd = ypgmcmd;

      select;
      when (sfl_cmd = '*NONE');
      when (sfl_cmd = '*SELECT');
        exsr vpos;
        leave;
      other;
        //  Unbekannter Programmbefehl
        clear usr8110;
        usr8110.var1 = ypgmcmd;
        p_sndpgmmg('USR8110': usr8110: sds.pgmname);
        exsr vsfpauerr;
        update pbsfl;
        isSflError = bTrue;
        iter;
      endsl;

      update pbsfl;
    endfor;

  endif;

endsr;

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

  // - Subfile neu aufbauen
  exsr pbinitkey;
  exsr pbinit;
  exsr pbsetll;
  exsr pbreadup;

  exsr srchinit;

endsr;

//============================================================*
//    C_Top         F17 - Anfang der Subfile                  *
//============================================================*

begsr c_top;

  sfsanr = 1;

endsr;

//============================================================*
//    C_Bot         F18 - Ende der Subfile                    *
//============================================================*

begsr c_bot;

  sfsanr = sflnbrrcd;

endsr;

//============================================================*
//    C_MoreOpt     F23 - Weitere Auswahlen                   *
//============================================================*

begsr c_moreopt;

  sftop = sftop + 1;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_morekeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    VPos          Verarbeiten der Eingaben                  *
//============================================================*

begsr vpos;

  i_mbr = $$mnme;

endsr;

//============================================================*
//    VSfpauClr     Löschen Subfileauswahl                    *
//============================================================*

begsr vsfpauclr;

  sfpau = *blanks;
  *in85 = '0'; // DSPATR(RI)
  *in84 = '0'; // SFLNXTCHG

endsr;

//============================================================*
//    VSfpauErr     Anzeigen fehlerhafter Subfileauswahl      *
//============================================================*

begsr vsfpauerr;

  *in85 = '1'; // DSPATR(RI)
  exsr vsfpauchg;

endsr;

//============================================================*
//    VSfpauChg     Datensatz in Subfile als geändert         *
//                  markieren                                 *
//============================================================*

begsr vsfpauchg;

  *in84 = '1'; // SFLNXTCHG

endsr;

//============================================================*
//    PBInitKey     Initialisieren der Schlüsselfelder        *
//                  zum Füllen der Subfile                    *
//============================================================*

begsr pbinitkey;

  peek46(i_qfile: '*ALL': '*CREATE'
        : nummbr: mbrl0200);

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
  sflnbrrcd = *zeros;

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr pbreadup;

  dow nummbr > 0;
    peek46(i_qfile: '*ALL': '*READ'
          : rc: mbrl0200);
    nummbr = nummbr - 1;

    exsr pbfill;

    sflrec = sflrec + 1;
    write pbsfl;
    sflnbrrcd = sflrec;

    if (sflrec >= sflpage);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PBFill        Füllen Subfilesatz                        *
//============================================================*

begsr pbfill;

  //  ... Membername
  $$mnme = mbrl0200.m2mnme;
  //  ... Memberbezeichnung
  $$mtxt = mbrl0200.m2mtxt;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

  //  ... Löschen Subfileauswahl
  exsr vsfpauclr;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr pbsetll;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setscreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 2;
    pos = 26;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 2;
    pos = 5;
  endif;

  sflpage = 9999;
  sflpagedds = 6;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek47fm;

  // - Programm initialisieren
  p_rmvpgmmg(sds.pgmname);

  ##mbr = *blanks;

  // - Rückkehrcode
  i_mbr = *blanks;
  o_msgid = *blanks;
  o_msgdta = *blanks;

  // - Darstellung der Subfile
  sflmde = '1';

  // - Darstellung der Befehlstasten
  sftop = 1;
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setscreen;

  // - Anzuzeigender Subfilesatz
  sfsanr = 1;

  // - Subfile füllen
  exsr c_refresh;

  // - Copyright
  p_sndpgmmg('USR9999': i_copyright: sds.pgmname);

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
  peek27_name = f_pgmcalln('PEEK27');
  peek46_name = f_pgmcalln('PEEK46');

  peek23(sds.pgmname: '*ALL': nbrfkeys
        : yfkeys: ynbrofkeys);
  scrnfkeys = %subarr(yfkeys: 1);

  peek27(sds.pgmname: ychoice: ynbrofch: *omit: %len($$choice));

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

