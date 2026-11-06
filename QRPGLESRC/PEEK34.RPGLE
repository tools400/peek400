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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

dcl-f peek34fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbsfl: SflRec);

dcl-f peekwrk usage(*update: *delete) keyed usropn infds(Work_00_DS) prefix(w_);

dcl-f peekwrk_ disk(1024) usage(*update: *delete: *output) usropn infds(Work_01_DS);

dcl-f peekfldl1 usage(*input) keyed usropn infds(Peek_01_DS) rename(fpeekfld: fpeekfldl1) prefix(f_)
  ;

dcl-f peekfld usage(*update: *delete) usropn infds(Peek_00_DS) prefix(f_);

dcl-ds workstn likeds(workstn_t);

dcl-ds Work_00_DS likeds(infds_t);
dcl-ds Work_01_DS likeds(infds_t);
dcl-ds Peek_00_DS likeds(infds_t);
dcl-ds Peek_01_DS likeds(infds_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_COLORATR
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,WRK0001

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8110
/copy QCOPYLE,USR8136
/copy QCOPYLE,USR8209

/define internal_prototype
/copy QCOPYLE,PPEEK34
/undefine internal_prototype

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK25
/copy QCOPYLE,PPEEK35

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

//----------------------------------------------------*
//  I N F D S - D E F I N I T I O N E N               *
//----------------------------------------------------*

dcl-ds ds_peekwrk extname('PEEKWRK') inz len(1024) prefix(w_);
end-ds;

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s YMsgID char(7);
dcl-s YMsgDta char(512);

dcl-s YPgmCmd char(10);
dcl-s YCmdDta like(pgmCmdDt_t);

dcl-s YField char(10);

dcl-s YColorAttr char(1);

dcl-s SflPage like(int4_t);
dcl-s SflPageDDS like(SflPage);
dcl-s SflRec like(SflPage);
dcl-s SflNbrRcd like(SflPage);
dcl-c NbrFKeys 3;

dcl-s sfbot like(int4_t);
dcl-s Sfl_Cmd char(10);

dcl-s IsSflError char(1) inz(bFalse);
dcl-s IsNewPos char(1) inz(bFalse);
dcl-s IsFound char(1) inz(bFalse);
dcl-s isBatch char(1) inz(bFalse);

dcl-s peek21_name like(pgmCallN_t);
dcl-s peek23_name like(pgmCallN_t);
dcl-s peek25_name like(pgmCallN_t);
dcl-s peek35_name like(pgmCallN_t);

dcl-s R_Field like(##Field);
dcl-s R_Seq like(F_Seq);
dcl-s LstField like(##Field);
dcl-s LstNbrRcd like(SflPage);
dcl-s srchrec like(SflPage);
//  Feldnamen und Satznummern der Subfile-Sätze für die Suche
dcl-s sfl_fnmes like($$fnme) dim(9999);
dcl-s sfl_rcdnbrs like(recordnbr) dim(9999);

//  Prüfung auf doppelte Folgenummern
dcl-s isdupseq like(bool_t) inz(bFalse);
dcl-s isfirst like(bool_t) inz(bFalse);
dcl-s lstseq like(WRK0001_t.WRK_Seq) inz;
dcl-s lstrcdnbr like(int4_t) inz;
dcl-s dupnbr like(int4_t) inz;
dcl-s duprrn like(int4_t) inz;
//  Zeilen der Subfile: als doppelte Folgenummer markiert (bisher/neu)
//  und in diesem Durchlauf von VReadC verarbeitet
dcl-s isduprow ind dim(9999) inz(*off);
dcl-s isnewdup ind dim(9999) inz(*off);
dcl-s isreadrow ind dim(9999) inz(*off);
//  Feld mit Eingabefehler je Zeile und ob es in diesem Durchlauf von
//  VReadC Eingabefehler gab: Sie behalten Markierung und Cursor, auch
//  wenn die Zeile zusätzlich eine doppelte Folgenummer hat.
dcl-s errfield like(YField) dim(9999) inz;
dcl-s isinperr like(bool_t) inz(bFalse);
dcl-s Wrk_SFSANR like(sfsanr);


dcl-ds fldl0100 likeds(fldl0100_t) inz;
dcl-ds wrk0001 likeds(WRK0001_t) inz(*likeds);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek34;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  i_function  like(option_t) const;
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-s do_x2 packed(7);

dcl-ds W0Key likerec(fpeekwrk: *key);
dcl-ds F1Key likerec(fpeekfldl1: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr First;
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

    //  Anzeige der Subfile
    exfmt pbctl;
    *in70 = '0';

    //  Nachrichten löschen
    p_rmvPgmMg(sds.pgmName);

    //  Aktuelle Satz-Nr.
    if (SflCsr > 0);
      sfsanr = SflCsr;
    endif;

    //  Mappen der gedrückten Taste
    //  in Programmbefehl
    peek21(workstn.aid: sds.pgmName
          : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
    if (YMsgID <> '');
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

    //  F3  - Sichern & beenden
    when (YPgmCmd = '*SAVE_EXIT');
      exsr C_Enter;
      if (IsSflError = bFalse);
        exsr C_SaveExit;
        leave;
      endif;

    //  F5  - Aktualisieren
    when (YPgmCmd = '*REFRESH');
      exsr C_Refresh;
      iter;

    //  F11 - Float Keys
    when (YPgmCmd = '*FLOATKEYS');
      exsr C_FloatKey;
      exsr C_Refresh;
      iter;

    //  F12 - Ende
    when (YPgmCmd = '*CANCEL');
      exsr C_EndPgm;
      leave;

    //  F16 - Suchen
    when (YPgmCmd = '*SEARCH');
      exsr C_Search;
      iter;

    //   F17 - Anfang Datensatz
    when (YPgmCmd = '*TOP');
      exsr C_Top;
      iter;
    //   F18 - Ende Datensatz
    when (YPgmCmd = '*BOT');
      exsr C_Bot;
      iter;

    //  F24 - Weitere Tasten
    when (YPgmCmd = '*MOREKEYS');
      exsr C_MoreKeys;

    //  Datenfreigabe
    when (YPgmCmd = '*ENTER');
      exsr C_Enter;
    //  Page up
    when (YPgmCmd = '*PAGEUP');
    //  Page down
    when (YPgmCmd = '*PAGEDOWN');

    other;
      //  Falsche Taste gedrückt
      p_wrongKey(workstn.aid: sds.pgmName);
      iter;
    endsl;

  enddo;

  close peek34fm;
endif;

close peekfldl1;
close peekfld;

close peekwrk;
close peekwrk_;
exsr ClrPeekWrk;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  exsr VReadC;

  if (##Field <> '');
    exsr C_Search;
  endif;

endsr;

//============================================================*
//    C_Search      F16 - Suchen                              *
//============================================================*

begsr C_Search;

  if (##Field <> '');
    LstField = ##Field;
    ##Field = '';
  endif;

  if (LstField = '');
    *in70 = '1';
    clear usr8209;
    p_sndPgmMg('USR8209': usr8209: sds.pgmName);
  else;
    exsr PosToField;
    if (IsNewPos = bTrue);
      sfsanr = Wrk_SFSANR;
    endif;
  endif;

endsr;

//============================================================*
//    PosToField    Subfile neu positionieren                 *
//============================================================*

begsr PosToField;

  if (LstField <> R_Field);
    LstNbrRcd = 0;
  endif;

  if (LstField = '');
    IsNewPos = bFalse;
    LstNbrRcd = 0;
  else;

    exsr SrchField;
    if (IsFound = bFalse);
      IsNewPos = bFalse;
      clear usr8136;
      usr8136.var1 = LstField;
      p_sndPgmMg('USR8136': usr8136: sds.pgmName);
    else;
      IsNewPos = bTrue;
    endif;
  endif;

  R_Field = LstField;

endsr;

//============================================================*
//    SrchField     Suchen Feld in Subfile                    *
//============================================================*

begsr SrchField;

  if (*in80 = *off);
    IsFound = bFalse;
  else;

    IsFound = bFalse;
    LstNbrRcd = LstNbrRcd + 1;

    //  Die Suche liest die Subfile nicht, sondern die gemerkten
    //  Feldnamen: Nach einem CHAIN auf die Subfile lieferte READC
    //  Zeilen mit Eingabefehlern (SFLNXTCHG) nicht mehr.
    for srchrec = LstNbrRcd to SflNbrRcd;
      if (LstField =
          %subst(sfl_fnmes(srchrec): 1:(f_scan(' ':
                         LstField) - 1)));
        IsFound = bTrue;
        leave;
      endif;

    endfor;

    if (IsFound = bTrue);
      Wrk_SFSANR = srchrec;
      LstNbrRcd = srchrec;
    else;
      Wrk_SFSANR = *zeros;
      LstNbrRcd = 0;
    endif;

  endif;

endsr;

//============================================================*
//    SrchInit      Initialisieren Suchfunktion               *
//============================================================*

begsr SrchInit;

  LstField  = ' ';
  LstNbrRcd = 0;
  R_Field   = LstField;

endsr;

//============================================================*
//    VReadC        Verarbeiten der Subfileauswahlen          *
//============================================================*

begsr VReadC;

  IsSflError = bFalse;
  isreadrow(*) = *off;
  errfield(*) = '';
  isinperr = bFalse;

  if (*in80 = *off);
  //   keine Einträge in Subfile vorhanden ...
  else;

    for do_x2 = 1 to SflNbrRcd;
      readc pbsfl;
      if (%eof());
        leave;
      endif;

      chain SflRec pbsfl;
      isreadrow(SflRec) = *on;

      exsr SflBzoff;

      //  Cursorpositionierung ...
      if (IsSflError = bFalse);
        SflCsr = SflRec;
      else;
      //  Subfile nicht neu positionieren
      endif;

      //  Linksbündig setzen ...
      sfpau = %triml(sfpau);

      //  Zuordnung AUSWAHL => Befehl ...
      peek21('#' + sfpau: sds.pgmName
            : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
      if (YMsgID <> *blanks);
        //  Fehlermeldung ...
        p_sndPgmMg('USR8110': sfpau: sds.pgmName);
        exsr VSfpauErr;
        //  Setzen Bezugszahlen ...
        exsr PBSetBZ;
        update pbsfl;
        IsSflError = bTrue;
        iter;
      endif;

      //----------------------------*
      //  Ausführen SFL-Befehl ...  *
      //----------------------------*
      Sfl_Cmd = YPgmCmd;

      select;
      when (Sfl_Cmd = '*NONE');
      other;
        //  Unbekannter Programmbefehl
        clear usr8110.var1;
        usr8110.var1 = YPgmCmd;
        p_sndPgmMg('USR8110': usr8110: sds.pgmName);
        exsr VSfpauErr;
        //  Setzen Bezugszahlen ...
        exsr PBSetBZ;
        update pbsfl;
        IsSflError = bTrue;
        iter;
      endsl;

      //----------------------------*
      //  Verarbeiten               *
      //  Datensatzänderungen       *
      //----------------------------*
      exsr GetColor;
      exsr FillRecord;
      //  Prüfen, Datensatz ...
      monitor;
        peek35(recordnbr: wrk0001: YField
              : YMsgID: YMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;
      //  ... Fehler beim Programmaufruf
      if (*in99 = *on);
        exsr VSfpauErr;
      else;
        //  ... Programaufruf war OK
        if (YMsgID = *blanks);
          //      ... Prüfung ist OK
          exsr VPos;
          exsr VSfpauClr;
        else;
          //      ... Fehler bei der Prüfung
          exsr VPosCsr;
          exsr VSfpauErr;
          *in85 = '0'; // DSPATR(RI)
          p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
          YMsgID = '';
          YMsgDta = '';
          IsSflError = bTrue;
          errfield(SflRec) = YField;
          isinperr = bTrue;
        endif;
      endif;

      //  Setzen Bezugszahlen ...
      exsr PBSetBZ;
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
  clear W0Key;
  W0Key.W_Key = *loval;
  setll %kds(W0Key: 1) fpeekwrk;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekwrk));
      leave;
    endif;

    if (isfirst = bFalse and W_Key = lstseq);
      isdupseq = bTrue;
      dupnbr = lstrcdnbr;
      exsr markdupseq;
      dupnbr = Work_00_DS.RcdNbr;
      exsr markdupseq;
    endif;

    isfirst = bFalse;
    lstseq = W_Key;
    lstrcdnbr = Work_00_DS.RcdNbr;
  enddo;

  if (isdupseq = bTrue);
    p_sndPgmMg('USR8167': '': sds.pgmName);
    IsSflError = bTrue;
  endif;

  //  Markierungen entfernen, die nicht mehr zutreffen. READC liefert
  //  nicht jede markierte Zeile wieder; Zeilen aus diesem Durchlauf hat
  //  VReadC neu geschrieben.
  for SflRec = 1 to SflNbrRcd;
    if (isduprow(SflRec) and not isnewdup(SflRec)
        and not isreadrow(SflRec));
      chain(e) SflRec pbsfl;
      if (not %error() and %found());
        exsr SflBzoff;
        exsr VSfpauClr;
        exsr PBSetBZ;
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

  //  Die Zeile über die gemerkten Satznummern suchen, statt jede
  //  Zeile per CHAIN zu lesen.
  duprrn = 0;
  if (SflNbrRcd > 0);
    duprrn = %lookup(dupnbr: sfl_rcdnbrs: 1: SflNbrRcd);
  endif;

  if (duprrn > 0);
    SflRec = duprrn;
    chain(e) SflRec pbsfl;
    if (not %error() and %found());
      isnewdup(SflRec) = *on;
      exsr SflBzoff;
      //  Ein Eingabefehler dieser Zeile bleibt markiert. Gibt es
      //  Eingabefehler, bekommen sie den Cursor, nicht die doppelte
      //  Folgenummer.
      if (errfield(SflRec) <> '');
        YField = errfield(SflRec);
        exsr VPosCsr;
      endif;
      if (isinperr = bFalse);
        *in20 = '1';       // DSPATR(PC)
      endif;
      *in30 = '1';         // DSPATR(RI)
      *in85 = '0';         // DSPATR(RI) Auswahl
      exsr VSfpauChg;
      exsr PBSetBZ;
      update pbsfl;
    endif;
  endif;

endsr;

//============================================================*
//    GetColor      Auswählen neue Farbe                      *
//============================================================*

begsr GetColor;

  if (##Color <> *blanks);

    YColorAttr = $$Color;

    monitor;
      peek25(i_dsp80: YColorAttr: YMsgID: YMsgDta);
      *in99 = bFalse;
    on-error;
      *in99 = bTrue;
    endmon;

    if (*in99 = *on);
    // Fehler aufgetreten
    else;
      $$Color = YColorAttr;
    endif;

  else;
  //  Cursor steht auf falschem Feld ...
  endif;

  ##Color = *blanks;

endsr;

//============================================================*
//    C_EndPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr C_EndPgm;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8100';
  usr8100.var1 = YPgmCmd;
  o_msgDta = usr8100;

endsr;

//============================================================*
//    C_SaveExit    F3     - Sichern und beenden              *
//============================================================*

begsr C_SaveExit;

  R_Seq = *zeros;

  clear W0Key;
  W0Key.W_Key = 0;
  setll %kds(W0Key: 1) fpeekwrk;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekwrk));
      leave;
    endif;

    R_Seq = R_Seq + 1;

    wrk0001 = W_Data;

    chain wrk0001.WRK_RcdNbr fpeekfld;
    if (not %found(peekfld));
      //  Feld nicht mehr vorhanden, z.B. Feldliste neu aufgebaut
      iter;
    endif;

    F_Seq = R_Seq;
    F_Hidden = wrk0001.WRK_Hidden;
    F_Color = wrk0001.Wrk_Color;
    F_MarkCol = wrk0001.WRK_MrkCol;
    F_MaxSize = wrk0001.WRK_MaxSiz;
    F_EdtCde = wrk0001.WRK_EdtCde;

    update fpeekfld;
  enddo;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8112';
  o_msgDta = '';

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr C_Refresh;

  // - Abrufen der Subfiletexte
  exsr PBSflTxt;

  // - Subfile neu aufbauen
  clear W0Key;
  W0Key.W_Key = 0;

  exsr PBInit;
  exsr PBSetLL;
  exsr PBReadUp;

  exsr SrchInit;

endsr;

//============================================================*
//    C_FloatKey    F11 - Schlüsselfelder an den Anfang       *
//============================================================*

begsr C_FloatKey;

  //  Alle nicht Schlüsselfelder mit
  //  negativen Folgenummern versehen ...
  clear W0Key;
  W0Key.W_Key = 0;
  setll %kds(W0Key: 1) fpeekwrk;

  dow ('1');
    read fpeekwrk;
    if (%eof(peekwrk));
      leave;
    endif;

    wrk0001 = W_Data;

    if (wrk0001.WRK_KSeq = 0);
      wrk0001.WRK_Seq = wrk0001.WRK_Seq * -1;
    else;
      wrk0001.WRK_Seq = 0;
    endif;

    W_Key = wrk0001.WRK_Seq;
    W_Data = wrk0001;
    update fpeekwrk;
  enddo;

  //  Nun alle negative Folgenummern neu
  //  durchnummerieren ...
  R_Seq = 0;

  clear W0Key;
  W0Key.W_Key = *hival;
  setgt %kds(W0Key: 1) fpeekwrk;

  dow ('1');
    readp fpeekwrk;
    if (%eof(peekwrk));
      leave;
    endif;

    wrk0001 = W_Data;

    //  Schlüsselfelder? ...
    if (wrk0001.WRK_KSeq = 0);
      //  ... nein, kein Schlüsselfeld
      R_Seq = R_Seq + 10;
      wrk0001.WRK_Seq = R_Seq;
    else;
      //  ... ja, Schlüsselfeld
      wrk0001.WRK_Seq = wrk0001.WRK_KSeq * 10;
      if (wrk0001.WRK_Seq > R_Seq);
        R_Seq = wrk0001.WRK_Seq;
      else;
      //    R_Seq stehenlassen ...
      endif;
    endif;

    W_Key = wrk0001.WRK_Seq;
    W_Data = wrk0001;
    update fpeekwrk;
  enddo;

endsr;

//============================================================*
//    C_Top         F17 - Anfang der Subfile                  *
//============================================================*

begsr C_Top;

  sfsanr = 1;

endsr;

//============================================================*
//    C_Bot         F18 - Ende der Subfile                    *
//============================================================*

begsr C_Bot;

  sfsanr = SflNbrRcd;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    FillRecord    Füllen Datensatz in PEEKWRK               *
//============================================================*

begsr FillRecord;

  wrk0001.WRK_Seq = ##Seq;

  select;
  when (##Hidden = bTrue);
    wrk0001.WRK_Hidden = bFalse;
  when (##Hidden = bFalse);
    wrk0001.WRK_Hidden = bTrue;
  other;
    wrk0001.WRK_Hidden = ##Hidden;
  endsl;

  wrk0001.Wrk_Color = $$Color;
  wrk0001.WRK_MrkCol = ##MarkCol;
  wrk0001.WRK_MaxSiz = ##MaxSize;
  wrk0001.WRK_EdtCde = ##EdtCde;

endsr;

//============================================================*
//    SflBzoff      Aussetzen aller Subfilebezugszahlen       *
//                  für die MArkierung von Eingabefehlern     *
//============================================================*

begsr SflBzoff;

  //  DSPATR(PC)
  %subarr(*in: 20: 10) = '0';
  //  DSPATR(RI)
  %subarr(*in: 30: 10) = '0';

endsr;

//============================================================*
//    VPosCsr       Positionieren Cursor auf fehlerhaftes     *
//                  Feld in der Subfile                       *
//============================================================*

begsr VPosCsr;

  select;
  when (YField = 'SEQ');
    *in20 = '1';         // DSPATR(PC)
    *in30 = '1';         // DSPATR(RI)
  when (YField = 'HIDDEN');
    *in21 = '1';         // DSPATR(PC)
    *in31 = '1';         // DSPATR(RI)
  when (YField = 'COLOR');
    *in22 = '1';         // DSPATR(PC)
    *in32 = '1';         // DSPATR(RI)
  when (YField = 'MARKCOL');
    *in23 = '1';         // DSPATR(PC)
    *in33 = '1';         // DSPATR(RI)
  when (YField = 'MAXSIZE');
    *in24 = '1';         // DSPATR(PC)
    *in34 = '1';         // DSPATR(RI)
  when (YField = 'EDTCDE');
    *in25 = '1';         // DSPATR(PC)
    *in35 = '1';
  other;
  //  Weiß noch nicht
  endsl;

endsr;

//============================================================*
//    VPos          Verarbeiten der Eingaben                  *
//============================================================*

begsr VPos;

  chain recordnbr peekwrk_ ds_peekwrk;
  if (not %found(peekwrk_));
  //  Weiß noch nicht, was zu tun ist ...
  else;
    wrk0001 = W_Data;
    exsr FillRecord;
    W_Key = wrk0001.WRK_Seq;
    W_Data = wrk0001;
    update peekwrk_ ds_peekwrk;
  endif;

endsr;

//============================================================*
//    VSfpauClr     Löschen Subfileauswahl                    *
//============================================================*

begsr VSfpauClr;

  sfpau = '';
  *in85 = '0'; // DSPATR(RI)
  *in84 = '0'; // SFLNXTCHG

endsr;

//============================================================*
//    VSfpauErr     Anzeigen fehlerhafter Subfileauswahl      *
//============================================================*

begsr VSfpauErr;

  *in85 = '1'; // DSPATR(RI)
  exsr VSfpauChg;

endsr;

//============================================================*
//    VSfpauChg     Datensatz in Subfile als geändert         *
//                  markieren                                 *
//============================================================*

begsr VSfpauChg;

  *in84 = '1'; // SFLNXTCHG

endsr;

//============================================================*
//    PBInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr PBInit;

  *in89 = '0';
  write msgctl;

  *in80 = '0'; // SFLDSP
  *in81 = '1'; // SFLDSPCTL
  *in82 = '1'; // SFLCLR
  *in83 = '1'; // SFLEND
  write pbctl;

  *in82 = '0'; // SFLCLR

  SflRec = 0;
  SflNbrRcd = 0;

  //  Neue Subfile: keine Markierungen für doppelte Folgenummern
  isduprow(*) = *off;

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr PBReadUp;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekwrk));
      *in83 = *on;
      leave;
    endif;

    exsr PBFill;

    SflRec = SflRec + 1;
    //  Setzen Bezugszahlen ...
    exsr PBSetBZ;
    write pbsfl;
    SflNbrRcd = SflRec;
    sfl_fnmes(SflRec) = $$fnme;
    sfl_rcdnbrs(SflRec) = recordnbr;

    if (SflRec >= SflPage);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PBFill        Füllen Subfilesatz                        *
//============================================================*

begsr PBFill;

  exsr SflBzoff;

  recordnbr = Work_00_DS.RcdNbr;

  wrk0001 = W_Data;

  chain(n) wrk0001.WRK_RcdNbr fpeekfld;

  fldl0100 = f_ffd;

  //  ... Anzeigereihenfolge
  ##Seq = wrk0001.WRK_Seq;
  //  ... Feldname
  $$fnme = fldl0100.f1fnme;
  //  ... Feldbezeichnung
  $$ftxt = fldl0100.f1ftxt;
  //  ... Datentyp
  $$DTyp = fldl0100.F1DTyp;

  //  ... Anzahl Dezimalstellen
  if ((f_isNumFld(fldl0100) = bTrue) and
      (f_isFloatFld(fldl0100) = bFalse));
    $$Digt = fldl0100.f1digt;
    //      ... Anzahl Nachkommastellen
    $$DecP = fldl0100.f1decp;
    isdecimal = bTrue;
  else;
    $$Digt = f_buffLn(fldl0100);
    $$DecP = 0;
    isdecimal = bFalse;
  endif;

  //  ... Variable Feldlänge
  if (f_isVarLen(fldl0100) = bTrue);
    isVarLen = bTrue;
  else;
    isVarLen = bFalse;
  endif;

  //  ... Unbekannte Feldart
  if (F_UnKnown = bTrue);
    isUnKnown = bTrue;
  else;
    isUnKnown = bFalse;
  endif;

  //  ... Startposition
  $$IBuf = fldl0100.F1IBuf;
  //  ... Keyfeldnummer
  if (F_KSeq <> *zeros);
    $$KSeq = 'K'+%editc(%dec(F_KSeq: 3: 0): 'X');
  else;
    $$KSeq = '';
  endif;
  //  ... Sichtbar
  select;
  when (wrk0001.WRK_Hidden = bTrue);
    ##Hidden = bFalse;
  when (wrk0001.WRK_Hidden = bFalse);
    ##Hidden = bTrue;
  other;
    ##Hidden = wrk0001.WRK_Hidden;
  endsl;
  //  ... Farbe
  ##Color = '';
  $$Color = wrk0001.Wrk_Color;
  //  ... Farbmarkierung
  ##MarkCol = wrk0001.WRK_MrkCol;
  //  ... Max. Anzeigebreite (Größe)
  ##MaxSize = wrk0001.WRK_MaxSiz;
  //  ... Editcode
  ##EdtCde = wrk0001.WRK_EdtCde;
  //  ... Original-Editcode
  if (fldl0100.f1edtc <> '');
    $$edtc = '(' + %trim(fldl0100.f1edtc) + ')';
    IsEditcode = '1';
  else;
    $$edtc = '';
    IsEditcode = '0';
  endif;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

  //  ... Löschen Subfileauswahl
  exsr VSfpauClr;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr PBSetLL;

  setll %kds(W0Key: 1) fpeekwrk;

endsr;

//============================================================*
//    PBSetBZ       Setzen Bezugszahlen                       *
//============================================================*

begsr PBSetBZ;

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
  if (isVarLen = bFalse);
    *in73 = '0';
  else;
    *in73 = '1';
  endif;

  //  Unbekannter Feldtyp
  if (isUnKnown = bFalse);
    *in74 = '0';
  else;
    *in74 = '1';
  endif;

endsr;

//============================================================*
//    PBSflTxt      Abrufen der Subfiletexte                  *
//============================================================*

begsr PBSflTxt;

  txt0080 = f_msgText('TXT0080': ' ');
  txt0081 = f_msgText('TXT0081': ' ');
  txt0082 = f_msgText('TXT0082': ' ');
  txt0083 = f_msgText('TXT0083': ' ');
  txt0084 = f_msgText('TXT0084': ' ');

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

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

  SflPage = *hival;
  SflPageDDS = 4;

endsr;

//============================================================*
//    ClrPeekWrk    Löschen der Datei PEEKWRK                 *
//============================================================*

begsr ClrPeekWrk;

  f_execute('CLRPFM FILE(' +
              %trimr(WORK_FILE_LIBRARY) + '/' +
              %trimr(WORK_FILE_NAME) +
            ') MBR(' + %trimr(WORK_FILE_MEMBER) + ')'
            :YMsgID: YMsgDta);
  YMsgID = '';
  YMsgDta = '';

endsr;

//============================================================*
//    CopyToWork    Kopieren PEEKFLD nach PEEKWRK             *
//============================================================*

begsr CopyToWork;

  R_Seq = 0;

  clear F1Key;
  F1Key.F_Seq = 0;
  setll %kds(F1Key: 1) fpeekfldl1;

  dow ('1');
    read fpeekfldl1;
    if (%eof(peekfldl1));
      leave;
    endif;

    clear wrk0001;
    clear ds_peekwrk;

    R_Seq = R_Seq + 10;

    W_Key = R_Seq;

    wrk0001.WRK_RcdNbr = Peek_01_DS.RcdNbr;
    wrk0001.WRK_Seq = R_Seq;
    wrk0001.WRK_KSeq = F_KSeq;
    wrk0001.WRK_Hidden = F_Hidden;
    wrk0001.Wrk_Color = F_Color;
    wrk0001.WRK_MrkCol = F_MarkCol;
    wrk0001.WRK_MaxSiz = F_MaxSize;
    wrk0001.WRK_EdtCde = F_EdtCde;

    W_Format = 'WRK0001';
    W_Data = wrk0001;

    write peekwrk_ ds_peekwrk;
  enddo;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Öffnen der Dateien
  open peekfldl1;
  open peekfld;

  exsr ClrPeekWrk;
  open peekwrk;
  open peekwrk_;
  exsr CopyToWork;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  ##Field = '';

  // - Rückkehrcode
  o_msgID = '';
  o_msgDta = '';

  // - Batchverarbeitung
  select;
  when (i_function = '*FLOATKEYS');
    exsr C_FloatKey;
    exsr C_SaveExit;
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
  exsr SetScreen;

  // - Anzuzeigender Subfilesatz
  sfsanr = 1;

  // - Subfile füllen
  exsr C_Refresh;

  // - Copyright
  p_sndPgmMg('USR9999': i_copyright: sds.pgmName);

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
  peek25_name = f_pgmCallN('PEEK25');
  peek35_name = f_pgmCallN('PEEK35');

  peek23(sds.pgmName: '*ALL': NbrFKeys
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

