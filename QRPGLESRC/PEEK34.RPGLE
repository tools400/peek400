**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.5.0                               *
//  Programm : PEEK34                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 22.12.1997  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Layout                                                       *
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

dcl-f peek34fm workstn(*ext) usage(*input:*output)
      usropn infds(workstn) sfile(pbsfl:sflrec);

dcl-f peekwrk usage(*update:*delete) keyed usropn infds(work_00_ds)
      prefix(w_);

dcl-f peekwrk_ disk(1024) usage(*update:*delete:*output)
      usropn infds(work_01_ds);

dcl-f peekfldl1 usage(*input) keyed usropn infds(peek_01_ds)
      rename(fpeekfld:fpeekfldl1) prefix(f_);

dcl-f peekfld usage(*update:*delete) usropn infds(peek_00_ds)
      prefix(f_);

dcl-ds workstn likeds(workstn_t);

dcl-ds work_00_ds likeds(infds_t);
dcl-ds work_01_ds likeds(infds_t);
dcl-ds peek_00_ds likeds(infds_t);
dcl-ds peek_01_ds likeds(infds_t);

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,D_INFDS
/COPY QCOPYLE,D_WORKSTN
/COPY QCOPYLE,ShortCmd_D
/COPY QCOPYLE,SDS
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,D_COLORATR
/COPY QCOPYLE,SCRNFKEYS
/COPY QCOPYLE,CEECNDHDLR

/COPY QCOPYLE,WRK0001

/COPY QCOPYLE,USR8100
/COPY QCOPYLE,USR8110
/COPY QCOPYLE,USR8136
/COPY QCOPYLE,USR8209

/define internal_prototype
/COPY QCOPYLE,PPEEK34
/undefine internal_prototype

/COPY QCOPYLE,PPEEK21
/COPY QCOPYLE,PPEEK23
/COPY QCOPYLE,PPEEK25
/COPY QCOPYLE,PPEEK35

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

//----------------------------------------------------*
//  I N F D S - D E F I N I T I O N E N               *
//----------------------------------------------------*

dcl-ds ds_peekwrk extname('PEEKWRK') inz len(1024)
       prefix(w_);
end-ds;

dcl-s yfkeys          char(18) dim(32);
dcl-s ynbrofkeys      like(int4_t);
dcl-s yMsgID          char(7);
dcl-s yMsgDta         char(512);

dcl-s ypgmcmd         char(10);
dcl-s ycmddta         like(pgmcmddt_t);

dcl-s yfield          char(10);

dcl-s ycolorattr      char(1);

dcl-s sflpage         like(int4_t);
dcl-s sflpagedds      like(sflpage);
dcl-s sflrec          like(sflpage);
dcl-s sflnbrrcd       like(sflpage);
dcl-c nbrfkeys const(3);

dcl-s sfbot           like(int4_t);
dcl-s sfl_cmd         char(10);

dcl-s issflerror      char(1) inz(bFalse);
dcl-s isnewpos        char(1) inz(bFalse);
dcl-s isfound         char(1) inz(bFalse);
dcl-s isBatch         char(1) inz(bFalse);

dcl-s peek21_name     like(pgmcalln_t);
dcl-s peek23_name     like(pgmcalln_t);
dcl-s peek25_name     like(pgmcalln_t);
dcl-s peek35_name     like(pgmcalln_t);

dcl-s r_field         like(##field);
dcl-s r_seq           like(f_seq);
dcl-s lstfield        like(##field);
dcl-s lstnbrrcd       like(sflpage);
dcl-s srchrec         like(sflpage);
//  Feldnamen der Subfile-Sätze für die Suche
dcl-s sfl_fnmes       like($$fnme) dim(9999);

//  Prüfung auf doppelte Folgenummern
dcl-s isdupseq        like(bool_t) inz(bFalse);
dcl-s isfirst         like(bool_t) inz(bFalse);
dcl-s lstseq          like(wrk0001_t.wrk_seq) inz;
dcl-s lstrcdnbr       like(int4_t) inz;
dcl-s dupnbr          like(int4_t) inz;
//  Zeilen der Subfile: als doppelte Folgenummer markiert (bisher/neu)
//  und in diesem Durchlauf von VReadC verarbeitet
dcl-s isduprow        ind dim(9999) inz(*off);
dcl-s isnewdup        ind dim(9999) inz(*off);
dcl-s isreadrow       ind dim(9999) inz(*off);
dcl-s wrk_sfsanr      like(sfsanr);


dcl-ds fldl0100 likeds(fldl0100_t) inz;
dcl-ds wrk0001  likeds(wrk0001_t) inz(*likeds);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek34;
  i_dsp80         const like(dsp80_t);
  i_copyright     const like(copyrght_t);
  i_function      const like(option_t);
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
end-pi;

dcl-s do_x2           packed(7);

dcl-ds w0key likerec(fpeekwrk: *key);
dcl-ds f1key likerec(fpeekfldl1: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;
if (isBatch = bFalse);

  dow ('1');

    //  Prüfen Positionierung der Subfile
    if (sfsanr <= 0);
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

    //  Anzeige der Subfile
    exfmt pbctl;
    *in70 = '0';

    //  Nachrichten löschen
    p_rmvpgmmg(sds.pgmname);

    //  Aktuelle Satz-Nr.
    if (sflcsr > 0);
      sfsanr = sflcsr;
    endif;

    //  Mappen der gedrückten Taste
    //  in Programmbefehl
    peek21(workstn.aid: sds.pgmname
          : ypgmcmd: ycmddta: yMsgID: yMsgDta);
    if (yMsgID <> '');
      p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
      yMsgID = '';
      yMsgDta = '';
      iter;
    endif;

    //  Abfragen der Befehlstasten
    select;
    //  F3  - Ende
    when (ypgmcmd = '*EXIT');
      exsr c_endpgm;
      leave;

    //  F3  - Sichern & beenden
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

    //  F11 - Float Keys
    when (ypgmcmd = '*FLOATKEYS');
      exsr c_floatkey;
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

  close peek34fm;
endif;

close peekfldl1;
close peekfld;

close peekwrk;
close peekwrk_;
exsr clrpeekwrk;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr vreadc;

  if (##field <> '');
    exsr c_search;
  endif;

endsr;

//============================================================*
//    C_Search      F16 - Suchen                              *
//============================================================*

begsr c_search;

  if (##field <> '');
    lstfield = ##field;
    ##field = '';
  endif;

  if (lstfield = '');
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

  if (lstfield = '');
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
    //  Feldnamen: Nach einem CHAIN auf die Subfile lieferte READC
    //  Zeilen mit Eingabefehlern (SFLNXTCHG) nicht mehr.
    for srchrec = lstnbrrcd to sflnbrrcd;
      if lstfield =
         %subst(sfl_fnmes(srchrec): 1:(f_scan(' ':
                        lstfield) - 1));
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
  isreadrow(*) = *off;

  if (*in80 = *off);
  //   keine Einträge in Subfile vorhanden ...
  else;

    for do_x2 = 1 to sflnbrrcd;
      readc pbsfl;
      if (%eof());
        leave;
      endif;

      chain sflrec pbsfl;
      isreadrow(sflrec) = *on;

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
            : ypgmcmd: ycmddta: yMsgID: yMsgDta);
      if (yMsgID <> *blanks);
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
        clear usr8110.var1;
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
      exsr getcolor;
      exsr fillrecord;
      //  Prüfen, Datensatz ...
      monitor;
        peek35(recordnbr: wrk0001: yfield
              : yMsgID: yMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;
      //  ... Fehler beim Programmaufruf
      if (*in99 = *on);
        exsr vsfpauerr;
      else;
        //  ... Programaufruf war OK
        if (yMsgID = *blanks);
          //      ... Prüfung ist OK
          exsr vpos;
          exsr vsfpauclr;
        else;
          //      ... Fehler bei der Prüfung
          exsr vposcsr;
          exsr vsfpauerr;
          *in85 = '0'; // DSPATR(RI)
          p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
          yMsgID = '';
          yMsgDta = '';
          issflerror = bTrue;
        endif;
      endif;

      //  Setzen Bezugszahlen ...
      exsr pbsetbz;
      update pbsfl;
    endfor;

    //  Doppelte Folgenummern erst nach allen Änderungen prüfen,
    //  damit zwei Felder ihre Nummern tauschen können.
    exsr chkdupseq;

  endif;

endsr;

//============================================================*
//    ChkDupSeq     Prüfen auf doppelte Folgenummern          *
//============================================================*

begsr chkdupseq;

  isdupseq = bFalse;
  isfirst = bTrue;
  isnewdup(*) = *off;

  //  PEEKWRK ist nach der Folgenummer sortiert: Doppelte
  //  Nummern liegen direkt hintereinander.
  clear w0key;
  w0key.w_key = *loval;
  setll %kds(w0key: 1) fpeekwrk;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekwrk));
      leave;
    endif;

    if (isfirst = bFalse and w_key = lstseq);
      isdupseq = bTrue;
      dupnbr = lstrcdnbr;
      exsr markdupseq;
      dupnbr = work_00_ds.rcdnbr;
      exsr markdupseq;
    endif;

    isfirst = bFalse;
    lstseq = w_key;
    lstrcdnbr = work_00_ds.rcdnbr;
  enddo;

  if (isdupseq = bTrue);
    p_sndpgmmg('USR8167': '': sds.pgmname);
    issflerror = bTrue;
  endif;

  //  Markierungen entfernen, die nicht mehr zutreffen. READC liefert
  //  diese Zeilen nicht wieder (SFLNXTCHG wirkt nach CHAIN/UPDATE
  //  nicht); Zeilen aus diesem Durchlauf hat VReadC neu geschrieben.
  for sflrec = 1 to sflnbrrcd;
    if (isduprow(sflrec) and not isnewdup(sflrec)
        and not isreadrow(sflrec));
      chain(e) sflrec pbsfl;
      if (not %error() and %found());
        exsr sflbzoff;
        exsr vsfpauclr;
        exsr pbsetbz;
        update pbsfl;
      endif;
    endif;
  endfor;

  isduprow = isnewdup;

endsr;

//============================================================*
//    MarkDupSeq    Markieren Folgenummer von Satz DupNbr     *
//============================================================*

begsr markdupseq;

  for sflrec = 1 to sflnbrrcd;
    chain(e) sflrec pbsfl;
    if (%error() or not %found());
      leave;
    endif;

    if (recordnbr = dupnbr);
      isnewdup(sflrec) = *on;
      exsr sflbzoff;
      *in20 = '1';         // DSPATR(PC)
      *in30 = '1';         // DSPATR(RI)
      *in85 = '0';         // DSPATR(RI) Auswahl
      exsr vsfpauchg;
      exsr pbsetbz;
      update pbsfl;
      leave;
    endif;
  endfor;

endsr;

//============================================================*
//    GetColor      Auswählen neue Farbe                      *
//============================================================*

begsr getcolor;

  if (##color <> *blanks);

    ycolorattr = $$color;

    monitor;
      peek25(i_dsp80: ycolorattr: yMsgID: yMsgDta);
      *in99 = bFalse;
    on-error;
      *in99 = bTrue;
    endmon;

    if (*in99 = *on);
    // Fehler aufgetreten
    else;
      $$color = ycolorattr;
    endif;

  else;
  //  Cursor steht auf falschem Feld ...
  endif;

  ##color = *blanks;

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

  r_seq = *zeros;

  clear w0key;
  w0key.w_key = 0;
  setll %kds(w0key: 1) fpeekwrk;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekwrk));
      leave;
    endif;

    r_seq = r_seq + 1;

    wrk0001 = w_data;

    chain wrk0001.wrk_rcdnbr fpeekfld;
    if (not %found(peekfld));
      //  Feld nicht mehr vorhanden, z.B. Feldliste neu aufgebaut
      iter;
    endif;

    f_seq = r_seq;
    f_hidden = wrk0001.wrk_hidden;
    f_color = wrk0001.wrk_color;
    f_markcol = wrk0001.wrk_mrkcol;
    f_maxsize = wrk0001.wrk_maxsiz;
    f_edtcde = wrk0001.wrk_edtcde;

    update fpeekfld;
  enddo;

  p_rmvpgmmg(sds.pgmname);

  o_msgid = 'USR8112';
  o_msgdta = '';

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  // - Abrufen der Subfiletexte
  exsr pbsfltxt;

  // - Subfile neu aufbauen
  clear w0key;
  w0key.w_key = 0;

  exsr pbinit;
  exsr pbsetll;
  exsr pbreadup;

  exsr srchinit;

endsr;

//============================================================*
//    C_FloatKey    F11 - Schlüsselfelder an den Anfang       *
//============================================================*

begsr c_floatkey;

  //  Alle nicht Schlüsselfelder mit
  //  negativen Folgenummern versehen ...
  clear w0key;
  w0key.w_key = 0;
  setll %kds(w0key: 1) fpeekwrk;

  dow ('1');
    read fpeekwrk;
    if (%eof(peekwrk));
      leave;
    endif;

    wrk0001 = w_data;

    if (wrk0001.wrk_kseq = 0);
      wrk0001.wrk_seq = wrk0001.wrk_seq * -1;
    else;
      wrk0001.wrk_seq = 0;
    endif;

    w_key = wrk0001.wrk_seq;
    w_data = wrk0001;
    update fpeekwrk;
  enddo;

  //  Nun alle negative Folgenummern neu
  //  durchnummerieren ...
  r_seq = 0;

  clear w0key;
  w0key.w_key = *hival;
  setgt %kds(w0key: 1) fpeekwrk;

  dow ('1');
    readp fpeekwrk;
    if (%eof(peekwrk));
      leave;
    endif;

    wrk0001 = w_data;

    //  Schlüsselfelder? ...
    if (wrk0001.wrk_kseq = 0);
      //  ... nein, kein Schlüsselfeld
      r_seq = r_seq + 10;
      wrk0001.wrk_seq = r_seq;
    else;
      //  ... ja, Schlüsselfeld
      wrk0001.wrk_seq = wrk0001.wrk_kseq * 10;
      if (wrk0001.wrk_seq > r_seq);
        r_seq = wrk0001.wrk_seq;
      else;
      //    R_Seq stehenlassen ...
      endif;
    endif;

    w_key = wrk0001.wrk_seq;
    w_data = wrk0001;
    update fpeekwrk;
  enddo;

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
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_morekeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    FillRecord    Füllen Datensatz in PEEKWRK               *
//============================================================*

begsr fillrecord;

  wrk0001.wrk_seq = ##seq;

  select;
  when (##hidden = bTrue);
    wrk0001.wrk_hidden = bFalse;
  when (##hidden = bFalse);
    wrk0001.wrk_hidden = bTrue;
  other;
    wrk0001.wrk_hidden = ##hidden;
  endsl;

  wrk0001.wrk_color = $$color;
  wrk0001.wrk_mrkcol = ##markcol;
  wrk0001.wrk_maxsiz = ##maxsize;
  wrk0001.wrk_edtcde = ##edtcde;

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
//    VPosCsr       Positionieren Cursor auf fehlerhaftes     *
//                  Feld in der Subfile                       *
//============================================================*

begsr vposcsr;

  select;
  when (yfield = 'SEQ');
    *in20 = '1';         // DSPATR(PC)
    *in30 = '1';         // DSPATR(RI)
  when (yfield = 'HIDDEN');
    *in21 = '1';         // DSPATR(PC)
    *in31 = '1';         // DSPATR(RI)
  when (yfield = 'COLOR');
    *in22 = '1';         // DSPATR(PC)
    *in32 = '1';         // DSPATR(RI)
  when (yfield = 'MARKCOL');
    *in23 = '1';         // DSPATR(PC)
    *in33 = '1';         // DSPATR(RI)
  when (yfield = 'MAXSIZE');
    *in24 = '1';         // DSPATR(PC)
    *in34 = '1';         // DSPATR(RI)
  when (yfield = 'EDTCDE');
    *in25 = '1';         // DSPATR(PC)
    *in35 = '1';
  other;
  //  Weiß noch nicht
  endsl;

endsr;

//============================================================*
//    VPos          Verarbeiten der Eingaben                  *
//============================================================*

begsr vpos;

  chain recordnbr peekwrk_ ds_peekwrk;
  if (not %found(peekwrk_));
  //  Weiß noch nicht, was zu tun ist ...
  else;
    wrk0001 = w_data;
    exsr fillrecord;
    w_key = wrk0001.wrk_seq;
    w_data = wrk0001;
    update peekwrk_ ds_peekwrk;
  endif;

endsr;

//============================================================*
//    VSfpauClr     Löschen Subfileauswahl                    *
//============================================================*

begsr vsfpauclr;

  sfpau = '';
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

  //  Neue Subfile: keine Markierungen für doppelte Folgenummern
  isduprow(*) = *off;

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

  wrk0001 = w_data;

  chain(n) wrk0001.wrk_rcdnbr fpeekfld;

  fldl0100 = f_ffd;

  //  ... Anzeigereihenfolge
  ##seq = wrk0001.wrk_seq;
  //  ... Feldname
  $$fnme = fldl0100.f1fnme;
  //  ... Feldbezeichnung
  $$ftxt = fldl0100.f1ftxt;
  //  ... Datentyp
  $$dtyp = fldl0100.f1dtyp;

  //  ... Anzahl Dezimalstellen
  if (f_isnumfld(fldl0100) = bTrue) and
     (f_isfloatfld(fldl0100) = bFalse);
    $$digt = fldl0100.f1digt;
    //      ... Anzahl Nachkommastellen
    $$decp = fldl0100.f1decp;
    isdecimal = bTrue;
  else;
    $$digt = f_buffln(fldl0100);
    $$decp = 0;
    isdecimal = bFalse;
  endif;

  //  ... Variable Feldlänge
  if (f_isvarlen(fldl0100) = bTrue);
    isvarlen = bTrue;
  else;
    isvarlen = bFalse;
  endif;

  //  ... Unbekannte Feldart
  if (f_unknown = bTrue);
    isunknown = bTrue;
  else;
    isunknown = bFalse;
  endif;

  //  ... Startposition
  $$ibuf = fldl0100.f1ibuf;
  //  ... Keyfeldnummer
  if (f_kseq <> *zeros);
    $$kseq = 'K'+%editc(%dec(f_kseq: 3: 0): 'X');
  else;
    $$kseq = '';
  endif;
  //  ... Sichtbar
  select;
  when (wrk0001.wrk_hidden = bTrue);
    ##hidden = bFalse;
  when (wrk0001.wrk_hidden = bFalse);
    ##hidden = bTrue;
  other;
    ##hidden = wrk0001.wrk_hidden;
  endsl;
  //  ... Farbe
  ##color = '';
  $$color = wrk0001.wrk_color;
  //  ... Farbmarkierung
  ##markcol = wrk0001.wrk_mrkcol;
  //  ... Max. Anzeigebreite (Größe)
  ##maxsize = wrk0001.wrk_maxsiz;
  //  ... Editcode
  ##edtcde = wrk0001.wrk_edtcde;
  //  ... Original-Editcode
  if (fldl0100.f1edtc <> '');
    $$edtc = '(' + %trim(fldl0100.f1edtc) + ')';
    iseditcode = '1';
  else;
    $$edtc = '';
    iseditcode = '0';
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

  setll %kds(w0key: 1) fpeekwrk;

endsr;

//============================================================*
//    PBSetBZ       Setzen Bezugszahlen                       *
//============================================================*

begsr pbsetbz;

  //  Editcode
  if (isdecimal = bFalse);
    *in71 = '0';
  else;
    *in71 = '1';
  endif;

  //  Dezimalstellen
  if (isdecimal = bFalse);
    *in72 = '0';
  else;
    *in72 = '1';
  endif;

  //  Kennzeichnung für variable Länge
  if (isvarlen = bFalse);
    *in73 = '0';
  else;
    *in73 = '1';
  endif;

  //  Unbekannter Feldtyp
  if (isunknown = bFalse);
    *in74 = '0';
  else;
    *in74 = '1';
  endif;

endsr;

//============================================================*
//    PBSflTxt      Abrufen der Subfiletexte                  *
//============================================================*

begsr pbsfltxt;

  txt0080 = f_msgtext('TXT0080': ' ');
  txt0081 = f_msgtext('TXT0081': ' ');
  txt0082 = f_msgtext('TXT0082': ' ');
  txt0083 = f_msgtext('TXT0083': ' ');
  txt0084 = f_msgtext('TXT0084': ' ');

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
            :yMsgID: yMsgDta);
  yMsgID = '';
  yMsgDta = '';

endsr;

//============================================================*
//    CopyToWork    Kopieren PEEKFLD nach PEEKWRK             *
//============================================================*

begsr copytowork;

  r_seq = 0;

  clear f1key;
  f1key.f_seq = 0;
  setll %kds(f1key: 1) fpeekfldl1;

  dow ('1');
    read fpeekfldl1;
    if (%eof(peekfldl1));
      leave;
    endif;

    clear wrk0001;
    clear ds_peekwrk;

    r_seq = r_seq + 10;

    w_key = r_seq;

    wrk0001.wrk_rcdnbr = peek_01_ds.rcdnbr;
    wrk0001.wrk_seq = r_seq;
    wrk0001.wrk_kseq = f_kseq;
    wrk0001.wrk_hidden = f_hidden;
    wrk0001.wrk_color = f_color;
    wrk0001.wrk_mrkcol = f_markcol;
    wrk0001.wrk_maxsiz = f_maxsize;
    wrk0001.wrk_edtcde = f_edtcde;

    w_format = 'WRK0001';
    w_data = wrk0001;

    write peekwrk_ ds_peekwrk;
  enddo;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peekfldl1;
  open peekfld;

  exsr clrpeekwrk;
  open peekwrk;
  open peekwrk_;
  exsr copytowork;

  // - Programm initialisieren
  p_rmvpgmmg(sds.pgmname);

  ##field = '';

  // - Rückkehrcode
  o_msgid = '';
  o_msgdta = '';

  // - Batchverarbeitung
  select;
  when (i_function = '*FLOATKEYS');
    exsr c_floatkey;
    exsr c_saveexit;
    isBatch = bTrue;
    leavesr;
  other;
    isBatch = bFalse;
    open peek34fm;
  endsl;

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
  peek25_name = f_pgmcalln('PEEK25');
  peek35_name = f_pgmcalln('PEEK35');

  peek23(sds.pgmname: '*ALL': nbrfkeys
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

