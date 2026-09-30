**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK40                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 20.03.1998  Raddatz                               *
//  geändert : 06.04.1999  für Version 2.1.0                     *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Auswahl Datenbankrelation                         *
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

dcl-f peek40fm workstn(*ext) usage(*input:*output)
      usropn infds(workstn) sfile(pbsfl:sflrec);

dcl-ds workstn likeds(workstn_t);

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,D_WORKSTN
/COPY QCOPYLE,D_COLORATR
/COPY QCOPYLE,ShortCmd_D
/COPY QCOPYLE,SDS
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,FILD0100
/COPY QCOPYLE,DBRL0200
/COPY QCOPYLE,KEYL0100
/COPY QCOPYLE,SELL0100
/COPY QCOPYLE,SCRNFKEYS
/COPY QCOPYLE,CEECNDHDLR

/COPY QCOPYLE,USR0008
/COPY QCOPYLE,USR8100
/COPY QCOPYLE,USR8110
/COPY QCOPYLE,USR8136
/COPY QCOPYLE,USR8172
/COPY QCOPYLE,USR8209

/define internal_prototype
/COPY QCOPYLE,PPEEK40
/undefine internal_prototype

/COPY QCOPYLE,PPEEK21
/COPY QCOPYLE,PPEEK23
/COPY QCOPYLE,PPEEK27
/COPY QCOPYLE,PPEEK39
/COPY QCOPYLE,PPEEK41

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-s yfkeys          char(18) dim(32)       inz(*blanks);
dcl-s ynbrofkeys      like(int4_t) inz;
dcl-s ymsgid          char(7) inz(*blanks);
dcl-s ymsgdta         char(512) inz(*blanks);

dcl-s ychoice         char(75) dim(32);
dcl-s ynbrofch        like(int4_t) inz;

dcl-s ypgmcmd         char(10) inz(*blanks);
dcl-s ycmddta         like(pgmcmddt_t) inz(*blanks);

dcl-ds yqfile likeds(qobj_t) inz;
dcl-s ymbr            char(10) inz(*blanks);
dcl-s ydata           char(512) inz(*blanks);

dcl-s isnewpos        char(1) inz(bFalse);
dcl-s isfound         char(1) inz(bFalse);
dcl-s issflerror      char(1) inz(bFalse);

dcl-s rc              like(int4_t) inz;
dcl-s numrel          like(int4_t) inz;
dcl-s numkey          like(int4_t) inz;
dcl-s numsel          like(int4_t) inz;

dcl-s sflpage         like(int4_t) inz;
dcl-s sftop           like(int4_t) inz;
dcl-s sflpagedds      inz(0) like(sflpage);
dcl-s sflrec          inz(0) like(sflpage);
dcl-s sflnbrrcd       inz(0) like(sflpage);
dcl-s sfbot           like(int4_t) inz;
dcl-c nbrfkeys const(2);
dcl-s sfl_cmd         char(10) inz(*blanks);

dcl-c UNIQUE const('*UNIQUE');
dcl-c CST    const('*CST');

dcl-s peek21_name     like(pgmcalln_t) inz;
dcl-s peek23_name     like(pgmcalln_t) inz;
dcl-s peek27_name     like(pgmcalln_t) inz;
dcl-s peek39_name     like(pgmcalln_t) inz;
dcl-s peek41_name     like(pgmcalln_t) inz;

dcl-s r_file          inz(*blanks) like(##file );
dcl-s lstfile         inz(*blanks) like(##file );
dcl-s lstnbrrcd       inz(0) like(sflpage);
dcl-s spos            like(int4_t) inz;

dcl-s wrk_sfsanr      inz(*zeros ) like(sfsanr );

dcl-s buffer          char(2000);

dcl-s strpos          like(uint4_t) inz;

dcl-s pfile           inz(*blanks)  like(i_file);
dcl-s plib            inz(*blanks)  like(i_lib );
dcl-s pmbr            inz(*blanks)  like(i_mbr );
dcl-s pfmtname        inz(*blanks)  like(i_rcdfmt);

dcl-ds fild0100 likeds(fild0100_t) inz;
dcl-ds keyl0100 likeds(keyl0100_t) inz;
dcl-ds dbrl0200 likeds(dbrl0200_t) inz;
dcl-ds sell0100 likeds(sell0100_t) inz;

dcl-s isInzSr         like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek40;
  i_dsp80         const like(dsp80_t);
  i_copyright     const like(copyrght_t);
  i_file          const like(file_t);
  i_lib           const like(lib_t);
  i_mbr           const like(mbr_t);
  i_rcdfmt        const like(fmt_t);
  i_basephyf      const like(bool_t);
  o_file          like(file_t);
  o_lib           like(lib_t);
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
end-pi;

dcl-s do_x2           packed(7);
dcl-s do_x3           packed(7);
dcl-s do_x4           packed(7);
dcl-s do_x5           packed(7);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;
if (o_msgid = '');

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
      if (o_file = *blanks);
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

endif;

close peek40fm;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr vreadc;

  if (##file <> *blanks);
    exsr c_search;
  endif;

endsr;

//============================================================*
//    C_Search      F16 - Suchen                              *
//============================================================*

begsr c_search;

  if (##file <> *blanks);
    lstfile = ##file;
    ##file = *blanks;
  endif;

  if (lstfile = *blanks);
    *in70 = '1';
    clear usr8209;
    p_sndpgmmg('USR8209': usr8209: sds.pgmname);
  else;
    exsr postofield;
    if (isnewpos = bTrue);
      sfsanr = wrk_sfsanr;
    endif;
  endif;

endsr;

//============================================================*
//    PosToField    Subfile neu positionieren                 *
//============================================================*

begsr postofield;

  if (lstfile <> r_file);
    lstnbrrcd = 0;
  endif;

  if (lstfile = *blanks);
    isnewpos = bFalse;
    lstnbrrcd = 0;
  else;

    exsr srchfield;
    if (isfound = bFalse);
      isnewpos = bFalse;
      clear usr8136;
      usr8136.var1 = ##file;
      p_sndpgmmg('USR8136': usr8136: sds.pgmname);
    else;
      isnewpos = bTrue;
    endif;
  endif;

  r_file = lstfile;

endsr;

//============================================================*
//    SrchField     Suchen Feld in Subfile                    *
//============================================================*

begsr srchfield;

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

      exsr bztoscreen;

      spos = %check(' ':$$file);
      if (spos <= 0);
        spos = 1;
      endif;

      if lstfile  =
         %subst($$file: spos:(f_scan(' ':
                           lstfile) - 1));
        isfound = bTrue;
        leave;
      else;
        if (sfpau <> *blanks);
          //  ... Satz geändert
          exsr vsfpauchg;
        else;
          //  ... Satz nicht geändert
          exsr vsfpauclr;
        endif;

        exsr bztosubf;
        update pbsfl;
        iter;
      endif;

    endfor;

    if (isfound = bTrue);
      wrk_sfsanr = sflrec;
      lstnbrrcd = sflrec;
    else;
      wrk_sfsanr = *zeros;
      lstnbrrcd = 0;
    endif;

  endif;

endsr;

//============================================================*
//    SrchInit      Initialisieren Suchfunktion               *
//============================================================*

begsr srchinit;

  lstfile   = ' ';
  lstnbrrcd = 0;
  r_file    = lstfile;

endsr;

//============================================================*
//    VReadC        Verarbeiten der Subfileauswahlen          *
//============================================================*

begsr vreadc;

  issflerror = bFalse;

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

      exsr bztoscreen;

      //  Cursorpositionierung ...
      if (issflerror = bFalse);
        sflcsr = sflrec;
      else;
      //  Subfile nicht neu positionieren
      endif;

      //  Linksbündig setzen ...
      sfpau = %triml(sfpau);

      //  Zuordnung AUSWAHL => Befehl ...
      peek21('#' + sfpau: sds.pgmname
            : ypgmcmd: ycmddta: ymsgid: ymsgdta);
      if (ymsgid <> *blanks);
        //  Fehlermeldung ...
        p_sndpgmmg('USR8110': sfpau: sds.pgmname);
        exsr vsfpauerr;

        exsr bztosubf;
        update pbsfl;
        issflerror = bTrue;
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

        exsr bztosubf;
        update pbsfl;
        issflerror = bTrue;
        iter;
      endsl;

      exsr bztosubf;
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

  o_file = h_file;
  o_lib = h_lib;

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

  sflrec = 0;
  sflnbrrcd = 0;
  $$depfile = 0;

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr pbreadup;

  for do_x3 = 1 to numrel;

    peek39(yqfile: ymbr
          : '*READ': rc: dbrl0200);

    if (dbrl0200.b2depfile = '*NONE');
      iter;
    endif;

    if (dbrl0200.b2deptype <> 'D');
      iter;
    endif;

    $$depfile = $$depfile + 1;

    //  Bei erstem Datensatz, ...
    if (*in80 = *off);
      //  ... die physische Datei anzeigen
      h_file = dbrl0200.b2fnmeused;
      h_lib = dbrl0200.b2lnmeused;
      //**                EXSR      StatMsg
      exsr pbfill;
      exsr pbfillkey;
      exsr pbfillsel;
    endif;

    //  Anzeigen der logischen Sichten
    h_file = dbrl0200.b2depfile;
    h_lib = dbrl0200.b2deplib;
    //**                EXSR      StatMsg
    exsr pbfill;
    exsr pbfillkey;
    exsr pbfillsel;
  endfor;

  //  Bei erstem Datensatz, ...
  if (*in80 = *off);
    //  ... die physische Datei anzeigen
    clear dbrl0200;
    h_file = i_file;
    h_lib = i_lib;
    dbrl0200.b2lnmeused = i_lib;
    //**                EXSR      StatMsg
    exsr pbfill;
    exsr pbfillkey;
    exsr pbfillsel;
  endif;

endsr;

//============================================================*
//    StatMsg       Statusnachricht ausgeben                  *
//============================================================*

begsr statmsg;

  //  Nachricht ausgeben ...
  clear usr8172;
  usr8172.var1 = %trimr(h_lib) + '/' + h_file;
  p_sndstsmg('USR8172': usr8172);

endsr;

//============================================================*
//    BzToScreen    Übertragen Bezugszahlen in Bildschirm     *
//============================================================*

begsr bztoscreen;

  *in20 = h_in20;
  *in71 = h_in71;

endsr;

//============================================================*
//    BzToSubf      Übertragen Bezugszahlen in Subfile        *
//============================================================*

begsr bztosubf;

  h_in20 = *in20;
  h_in71 = *in71;

endsr;

//============================================================*
//    PBFill        Füllen Subfilesatz                        *
//============================================================*

begsr pbfill;

  //  Datensatz komplett anzeigen ...
  *in71 = '0';

  //  Abhängigkeit prüfen ...
  if (dbrl0200.b2lnmeused = h_lib or
     *in80 = '0');
    *in20 = '0';
  else;
    *in20 = '1';
  endif;

  //  Einlesen der Dateiinformationen ...
  yqfile.name = h_file;
  yqfile.lib = h_lib;
  peek41(yqfile
        : '*FIRST': '*CREATE': rc: ydata);
  //  ... Bezeichnung
  peek41(yqfile
        : '*FIRST': '*READTEXT': rc: ydata);
  $$ftxt = ydata;

  //  Schreiben der Subfile ...
  exsr pbwrite;

endsr;

//============================================================*
//    PBFillKey     Füllen Subfilesatz, Schlüsselfelder       *
//============================================================*

begsr pbfillkey;

  //  Datensatz nicht komplett anzeigen ...
  *in71 = '1';

  //  Einlesen der Schlüsselinformationen ...
  peek41(yqfile
        : '*FIRST': '*KEY': numkey: ydata);

  buffer = *blanks;

  for do_x4 = 1 to numkey;
    peek41(yqfile
          : '*FIRST': '*READKEY': rc: ydata);
    keyl0100 = ydata;

    if (keyl0100.apkseq = 'D');
      buffer = %trimr(buffer) + COLOR_white;
    else;
      buffer = %trimr(buffer) + COLOR_green;
    endif;

    buffer = %trimr(buffer) + keyl0100.apkeyf;
  endfor;

  if (numkey >= 1 and
     keyl0100.apuniq = 'Y');
    buffer = %trimr(buffer) + COLOR_white + UNIQUE;
  endif;

  select;
  when (dbrl0200.b2deptype = 'C');
    buffer = %trimr(buffer) + COLOR_white + CST;
  other;
  endsl;

  buffer = %trimr(buffer) + COLOR_green;

  strpos = 1;
  dou strpos = 0;
    $$ftxt = f_wordwrap(
                  buffer: %len($$ftxt): strpos);
    //  Schreiben der Subfile ...
    exsr pbwrite;
    if (strpos > 0 and
       %subst(buffer: 1: strpos-1) < x'40');
      //     Positionieren auf Farb-Attribut
      strpos = strpos - 1;
    endif;
  enddo;

endsr;

//============================================================*
//    PBFillSel     Füllen Subfilesatz, SELECT/OMIT           *
//============================================================*

begsr pbfillsel;

  //  Datensatz nicht komplett anzeigen ...
  *in71 = '1';

  //  Einlesen der Select/Omit Informationen ...
  peek41(yqfile
        : '*FIRST': '*SELECT': numsel: ydata);

  for do_x5 = 1 to numsel;
    peek41(yqfile
          : '*FIRST': '*READSEL': rc: ydata);
    sell0100 = ydata;

    //  Wenn das Ende der Liste rreicht ist, ...
    if (sell0100.socomp = 'AL');
    //  ... dann den Eintrag überlesen
    else;
      //  ... ansonsten den Eintrag aufbereiten und anzeigen
      select;
      when (sell0100.sorule = 'S');
        buffer = COLOR_white + '*SELECT';
      when (sell0100.sorule = 'O');
        buffer = COLOR_white + '*OMIT';
      other;
        buffer = COLOR_white;
      endsl;

      %subst(buffer: 10: %len(sell0100.sofld)) =
       sell0100.sofld;
      %subst(buffer: 21: %len(sell0100.socomp)) =
       sell0100.socomp;
      buffer = %trimr(buffer) + ' ' +
              sell0100.sovalu + COLOR_green;
      $$ftxt = buffer;
      //  Schreiben der Subfile ...
      exsr pbwrite;
    endif;

  endfor;

endsr;

//============================================================*
//    PBWrite       Schreiben der Subfile                     *
//============================================================*

begsr pbwrite;

  //  Datensatz nicht komplett anzeigen ...
  if (*in71 = *on);
    $$file = *blanks;
    $$lib = *blanks;
  else;
    //  Bei erstem Datensatz, ...
    if (*in80 = *off);
      $$file = h_file;
      $$lib = h_lib;
    else;
      $$file = ' ' + h_file;
      $$lib = h_lib;
    endif;
  endif;

  //  Anzeigen der Subfile ...
  *in80 = '1';

  //  Löschen Subfileauswahl ...
  exsr vsfpauclr;

  //  Schreiben des Subfilesatzes ...
  sflrec = sflrec + 1;
  exsr bztosubf;
  write pbsfl;
  sflnbrrcd = sflrec;

  if (h_file = i_file and h_lib = i_lib and *in71 = *off);
    sfsanr = sflrec;
  endif;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr pbsetll;

  yqfile.name = pfile;
  yqfile.lib = plib;
  ymbr = pmbr;

  peek39(yqfile: ymbr
        : '*CREATE': numrel: dbrl0200);

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
    pos = 2;
  endif;

  sflpage = *hival;
  sflpagedds = 6;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek40fm;

  // - Programm initialisieren
  p_rmvpgmmg(sds.pgmname);

  ##file = *blanks;
  r_file = ##file;

  // - Rückkehrcode
  o_file = *blanks;
  o_lib = *blanks;
  o_msgid = *blanks;
  o_msgdta = *blanks;

  // - Dateityp feststellen
  pfile = i_file;
  plib = i_lib;
  pmbr = i_mbr;
  pfmtname = i_rcdfmt;

  //   ... Einlesen der Dateiinformationen
  yqfile.name = pfile;
  yqfile.lib = plib;
  peek41(yqfile
        : pfmtname: '*CREATE': rc: ydata);

  if (rc = *zeros);
    //       ... Fehler
    o_msgid = 'USR0008';
    clear usr0008;
    usr0008.var1 = yqfile.name;
    usr0008.var2 = yqfile.lib;
    o_msgdta = usr0008;
  else;
    //       ... kein Fehler
    fild0100 = ydata;
    if (fild0100.atfila = '*LGL');
      //           ... logical file
      peek41(yqfile
            : pfmtname: '*BASED-ON': rc: ydata);
      if (rc = *zeros);
        //               ... Fehler
        usr0008.var1 = yqfile.name;
        usr0008.var2 = yqfile.lib;
        o_msgdta = usr0008;
      else;
        if (i_basephyf = bTrue);
          //                   ... based-on
          pfile = %subst(ydata: 1: 10);
          plib  = %subst(ydata: 11: 10);
          pmbr = '*FIRST';
        else;
        //               ... no based-on
        endif;
      endif;
    else;
    //           ... physical file
    endif;
  endif;

  if (o_msgid <> *blanks);
  //   ... Fehler
  else;

    // - Darstellung der Subfile
    sflmde = '1';

    // -  Darstellung der Auswahlen/Funktionstasten
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
  endif;

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
  peek39_name = f_pgmcalln('PEEK39');
  peek41_name = f_pgmcalln('PEEK41');

  peek23(sds.pgmname: '*ALL': 0
        : yfkeys: ynbrofkeys);
  scrnfkeys = %subarr(yfkeys: 1);

  peek27(sds.pgmname: ychoice: ynbrofch);

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

