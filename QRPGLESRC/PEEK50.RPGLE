**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.5.0                               *
//  Programm : PEEK50                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 11.02.1999  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Erweiterte PIN-Funktion                           *
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

dcl-f peek50fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbsfl: sflrec);

dcl-f peekfldl1 keyed usropn infds(peek_01_ds) rename(fpeekfld: fpeekfldl1) prefix(f_);

dcl-f peekfld usropn infds(peek_00_ds) prefix(f_);

dcl-f peekwrk usage(*update: *delete) keyed usropn infds(work_00_ds) prefix(w_);

dcl-f peekwrk_ disk(1024) usage(*update: *delete: *output) usropn infds(work_01_ds);

dcl-ds workstn likeds(workstn_t);

dcl-ds peek_00_ds likeds(infds_t);
dcl-ds peek_01_ds likeds(infds_t);
dcl-ds work_00_ds likeds(infds_t);
dcl-ds work_01_ds likeds(infds_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_COLORATR
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,WRK0002
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8110
/copy QCOPYLE,USR8136
/copy QCOPYLE,USR8205
/copy QCOPYLE,USR8209

/define internal_prototype
/copy QCOPYLE,PPEEK50
/undefine internal_prototype

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-ds ds_peekwrk extname('PEEKWRK') inz len(1024) prefix(w_);
end-ds;

dcl-s yfkeys char(18) dim(32);
dcl-s ynbrofkeys like(int4_t);
dcl-s ymsgid char(7);
dcl-s ymsgdta char(512);

dcl-s ypgmcmd char(10);
dcl-s ycmddta like(pgmcmddt_t);

dcl-s sflpage like(int4_t);
dcl-s sflpagedds like(sflpage);
dcl-s sflrec like(sflpage);
dcl-s sflnbrrcd like(sflpage);

dcl-s sfbot like(int4_t);
dcl-c nbrfkeys 3;
dcl-s sfl_cmd char(10);

dcl-s issflerror char(1) inz(bFalse);
dcl-s isnewpos char(1) inz(bFalse);
dcl-s isfound char(1) inz(bFalse);

dcl-s peek21_name like(pgmcalln_t);
dcl-s peek23_name like(pgmcalln_t);

dcl-s r_field like(##field);
dcl-s lstfield like(##field);
dcl-s lstnbrrcd like(sflpage);
dcl-s srchrec like(sflpage);
//  Feldnamen der Subfile-Sätze für die Suche
dcl-s sfl_fnmes like($$fnme) dim(9999);

dcl-s wrk_sfsanr like(sfsanr);
dcl-s x like(int4_t);
dcl-s nbrpincol like(int4_t);

dcl-ds wrk0002 likeds(wrk0002_t) inz(*likeds);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek50;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  io_pintabc  like(fieldnme_t) dim(12);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pi;

dcl-s do_x2 packed(7);

dcl-ds f1key likerec(fpeekfldl1: *key);
dcl-ds w0key likerec(fpeekwrk: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

dow ('1');

  //  Prüfen Positionierung der Subfile
  if (sfsanr <= *zeros);
    sfsanr = 1;
  endif;

  //  Warnung, bei mehr als 12 Spalten
  if (nbrpincol > %elem(io_pintabc));
    clear usr8205;
    usr8205.var1 = %elem(io_pintabc);
    p_sndpgmmg('USR8205': usr8205: sds.pgmname);
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
  when ((sfbot = 2) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#2;
  when ((sfbot = 3) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#3;
  when ((sfbot = 4) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#4;
  when ((sfbot = 5) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#5;
  when ((sfbot = 6) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#6;
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

  //  F3  - Sichern & beenden
  //  (erst die Eingaben seit dem letzten ENTER übernehmen)
  when (ypgmcmd = '*SAVE_EXIT');
    exsr c_enter;
    if (issflerror = bFalse);
      exsr c_saveexit;
      leave;
    endif;

  //  F5  - Aktualisieren
  when (ypgmcmd = '*REFRESH');
    exsr c_refresh;
    iter;

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

  //  F22 - Alle Löschen
  when (ypgmcmd = '*CLRALL');
    exsr c_clrall;
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

close peek50fm;
close peekfld;
close peekfldl1;
close peekwrk;
close peekwrk_;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr vreadc;

  //  Erst die ungültigen Auswahlen korrigieren, dann suchen; der
  //  Suchbegriff bleibt bis dahin stehen.
  if (##field <> *blanks and issflerror = bFalse);
    exsr c_search;
  endif;

endsr;

//============================================================*
//    C_Search      F16 - Suchen                              *
//============================================================*

begsr c_search;

  if (##field <> *blanks);
    lstfield = ##field;
    ##field = *blanks;
  endif;

  if (lstfield = *blanks);
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

  if (lstfield <> r_field);
    lstnbrrcd = 0;
  endif;

  if (lstfield = *blanks);
    isnewpos = bFalse;
    lstnbrrcd = 0;
  else;

    exsr srchfield;
    if (isfound = bFalse);
      isnewpos = bFalse;
      clear usr8136;
      usr8136.var1 = lstfield;
      p_sndpgmmg('USR8136': usr8136: sds.pgmname);
    else;
      isnewpos = bTrue;
    endif;
  endif;

  r_field = lstfield;

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

    //  Die Suche liest die Subfile nicht, sondern die gemerkten
    //  Feldnamen: Ein UPDATE der durchsuchten Zeilen verwarf bei F16
    //  ohne ENTER die eingegebenen Folgenummern.
    for srchrec = lstnbrrcd to sflnbrrcd;
      if (lstfield =
          %subst(sfl_fnmes(srchrec): 1:(f_scan(' ':
                                lstfield) - 1)));
        isfound = bTrue;
        leave;
      endif;

    endfor;

    if (isfound = bTrue);
      wrk_sfsanr = srchrec;
      lstnbrrcd = srchrec;
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

  lstfield  = ' ';
  lstnbrrcd = 0;
  r_field   = lstfield;

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

      exsr sflbzoff;

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
        //  Setzen Bezugszahlen ...
        exsr pbsetbz;
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
      other;
        //  Unbekannter Programmbefehl
        clear usr8110;
        usr8110.var1 = ypgmcmd;
        p_sndpgmmg('USR8110': usr8110: sds.pgmname);
        exsr vsfpauerr;
        //  Setzen Bezugszahlen ...
        exsr pbsetbz;
        update pbsfl;
        issflerror = bTrue;
        iter;
      endsl;

      //----------------------------*
      //  Verarbeiten               *
      //  Datensatzänderungen       *
      //----------------------------*
      exsr vpos;
      exsr vsfpauclr;

      //  Setzen Bezugszahlen ...
      exsr pbsetbz;
      update pbsfl;
    endfor;

    //  Ungültige Auswahl: Cursor auf die erste fehlerhafte Zeile setzen
    //  (sfsanr wird sonst nur nach der Anzeige aus SFLCSRRRN gesetzt)
    if (issflerror = bTrue);
      sfsanr = sflcsr;
    endif;

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
//    C_SaveExit    F3     - Sichern und beenden              *
//============================================================*

begsr c_saveexit;

  clear io_pintabc;
  x = 0;

  clear w0key;
  w0key.w_key = 0;
  setll %kds(w0key) fpeekwrk;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekwrk));
      *in83 = *on;
      leave;
    endif;

    wrk0002 = w_data;

    if (x < %elem(io_pintabc) and wrk0002.wrk_seq <> 0);
      x = x + 1;
      io_pintabc(x) = wrk0002.wrk_fnme;
    endif;
  enddo;

  p_rmvpgmmg(sds.pgmname);

  o_msgid = 'USR8112';
  o_msgdta = *blanks;

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  // - Subfile neu aufbauen
  clear w0key;
  w0key.w_key = 0;
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
//    C_ClrAll      F22 - Löschen alle Einträge               *
//                        der Pintabelle                      *
//============================================================*

begsr c_clrall;

  clear w0key;
  w0key.w_key = 0;
  setll %kds(w0key) fpeekwrk;

  dow ('1');
    read fpeekwrk;
    if (%eof(peekwrk));
      *in83 = *on;
      leave;
    endif;

    wrk0002 = w_data;

    ##seq = 0;
    exsr fillrecord;
    exsr fillkey;

    w_data = wrk0002;
    update fpeekwrk;
  enddo;

  exsr c_refresh;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_morekeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    FillRecord    Füllen Datensatz in PEEKWRK               *
//============================================================*

begsr fillrecord;

  if (##seq <> 0 and wrk0002.wrk_seq  = 0);
    nbrpincol = nbrpincol + 1;
  endif;

  if (##seq = 0 and wrk0002.wrk_seq <> 0);
    nbrpincol = nbrpincol - 1;
  endif;

  wrk0002.wrk_seq = ##seq;

endsr;

//============================================================*
//    FillKey       Füllen Schlüsselfelder in PEEKWRK         *
//============================================================*

begsr fillkey;

  if (wrk0002.wrk_seq = 0);
    w_key = *hival;
  else;
    w_key = wrk0002.wrk_seq;
  endif;

endsr;

//============================================================*
//    SflBzoff      Aussetzen aller Subfilebezugszahlen       *
//                  für die MArkierung von Eingabefehlern     *
//============================================================*

begsr sflbzoff;

  //  DSPATR(PC)
  %subarr(*in: 20: 10) = '0';
  //  DSPATR(RI)
  %subarr(*in: 30: 10) = '0';

endsr;

//============================================================*
//    VPos          Verarbeiten der Eingaben                  *
//============================================================*

begsr vpos;

  chain recordnbr peekwrk_ ds_peekwrk;
  *in11 = not %found;
  if (*in11 = *on);
  //  Weiß noch nicht, was zu tun ist ...
  else;
    wrk0002 = w_data;
    exsr fillrecord;
    exsr fillkey;
    w_data = wrk0002;
    update peekwrk_ ds_peekwrk;
  endif;

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

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr pbreadup;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekwrk));
      *in83 = *on;
      leave;
    endif;

    exsr pbfill;

    sflrec = sflrec + 1;
    //  Setzen Bezugszahlen ...
    exsr pbsetbz;
    write pbsfl;
    sflnbrrcd = sflrec;
    sfl_fnmes(sflrec) = $$fnme;

    if (sflrec >= sflpage);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PBFill        Füllen Subfilesatz                        *
//============================================================*

begsr pbfill;

  exsr sflbzoff;

  recordnbr = work_00_ds.rcdnbr;

  wrk0002 = w_data;

  chain wrk0002.wrk_rcdnbr fpeekfld;
  *in11 = not %found;

  fldl0100 = f_ffd;

  //  ... Folgenummer
  ##seq = wrk0002.wrk_seq;
  //  ... Feldname
  $$fnme = wrk0002.wrk_fnme;
  //  ... Feldbezeichnung
  $$ftxt = wrk0002.wrk_ftxt;
  //  ... Keyfeldnummer
  if (f_kseq <> 0);
    $$kseq = 'K'+%editc(%dec(f_kseq: 3: 0): 'X');
  else;
    $$kseq = '';
  endif;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

  //  ... Löschen Subfileauswahl
  exsr vsfpauclr;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr pbsetll;

  setll %kds(w0key) fpeekwrk;

endsr;

//============================================================*
//    PBSetBZ       Setzen Bezugszahlen                       *
//============================================================*

begsr pbsetbz;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setscreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 2;
    pos = 2;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 2;
    pos = 2;
  endif;

  sflpage = *hival;
  sflpagedds = 4;

endsr;

//============================================================*
//    ClrPeekWrk    Löschen der Datei PEEKWRK                 *
//============================================================*

begsr clrpeekwrk;

  f_execute('CLRPFM FILE(' +
              %trimr(WORK_FILE_LIBRARY) + '/' +
              %trimr(WORK_FILE_NAME) +
            ') MBR(' + %trimr(WORK_FILE_MEMBER) + ')'
            :ymsgid: ymsgdta);
  ymsgid = '';
  ymsgdta = '';

endsr;

//============================================================*
//    CopyToWork    Kopieren PEEKFLD nach PEEKWRK             *
//============================================================*

begsr copytowork;

  nbrpincol = 0;

  clear f1key;
  f1key.f_seq = 0;
  setll %kds(f1key) fpeekfldl1;

  dow ('1');
    read fpeekfldl1;
    if (%eof(peekfldl1));
      leave;
    endif;

    clear wrk0002;
    clear ds_peekwrk;

    fldl0100 = f_ffd;

    //  ... Folgenummer
    x = %lookup(fldl0100.f1fnme: io_pintabc: 1);
    if (x > 0);
      //  ... gefunden
      ##seq   = x * 10;
      w_key   = x * 10;
    else;
      //  ... nicht gefunden
      ##seq   = 0;
      w_key   = *hival;
    endif;

    exsr fillrecord;

    //  ... sonstige Felder
    wrk0002.wrk_rcdnbr = peek_01_ds.rcdnbr;
    wrk0002.wrk_fnme = fldl0100.f1fnme;
    wrk0002.wrk_ftxt = fldl0100.f1ftxt;

    w_format = 'WRK0002';
    w_data = wrk0002;

    write peekwrk_ ds_peekwrk;
  enddo;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peekfld;
  open peekfldl1;

  exsr clrpeekwrk;
  open peekwrk;
  open peekwrk_;
  exsr copytowork;

  open peek50fm;

  // - Programm initialisieren
  p_rmvpgmmg(sds.pgmname);

  ##field = *blanks;

  // - Rückkehrcode
  o_msgid = *blanks;
  o_msgdta = *blanks;

  // - Darstellung der Subfile
  sflmde = '1';

  // - Darstellung der Befehlstasten
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

  peek23(sds.pgmname: '*ALL': nbrfkeys
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

