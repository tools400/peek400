**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.5.0                               *
//  Programm : PEEK68                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 11.08.2008  Thomas Raddatz                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Matchcode Subfile-Auswahl                         *
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

dcl-f peek68fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbsfl: SflRec);

dcl-ds workstn likeds(workstn_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK68
/undefine internal_prototype

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8110
/copy QCOPYLE,USR8136
/copy QCOPYLE,USR8209

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK27

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s YMsgID char(7);
dcl-s YMsgDta char(512);

dcl-s YPgmCmd char(10);
dcl-s YCmdDta like(pgmCmdDt_t);

dcl-s YChoice char(75) dim(32);
dcl-s YNbrOfCh like(int4_t);

dcl-s IsSflError char(1) inz(bFalse);

dcl-s SFTop like(int4_t);
dcl-s SflPage like(int4_t);
dcl-s SflPageDDS like(SflPage);
dcl-s SflRec like(SflPage);
dcl-s SflNbrRcd like(SflPage);
dcl-s sfbot like(int4_t);
dcl-c NbrFKeys 2;
dcl-s Sfl_Cmd char(10);

dcl-s peek21_name like(pgmCallN_t);
dcl-s peek23_name like(pgmCallN_t);
dcl-s peek27_name like(pgmCallN_t);

dcl-s IsEOF like(bool_t) inz(bFalse);
dcl-s key like(KEY_t);
dcl-s data like(SET0000_t);

dcl-s wrk_MsgID like(msgId_t);
dcl-s wrk_MsgTxt like(msgDta_t);

dcl-ds usrKey qualified inz;
  section like(SECTION_t);
  key     like(KEY_t);
end-ds;

dcl-ds sflLine qualified inz;
  opt  char(2);
  text char(28) pos(6);
end-ds;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek68;
  i_dsp80     like(dsp80_t) const;
  i_pgm       like(pgm_t) const;
  i_copyright like(copyright_t) const;
  o_sflOpt    like(sfpau_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-s do_x2 packed(7);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr First;

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
  if (SFTop > 32
      or SFTop > YNbrOfCh);
    SFTop = 1;
  endif;
  $$choice = YChoice(SFTop);

  //  Trennlinie
  write pbbot#0;
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
  when ((sfbot = 7) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#7;
  when ((sfbot = 8) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#8;
  when ((sfbot = 9) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#9;
  when ((sfbot = 10) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#10;
  when ((sfbot = 11) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#11;
  when ((sfbot = 12) and
     (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
    write pbbot#12;
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
  if (SflCsr > *zeros);
    sfsanr = SflCsr;
  endif;

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
  when (YPgmCmd = '*EXIT');
    exsr C_EndPgm;
    leave;
  when (YPgmCmd = '*REFRESH');
    exsr C_Refresh;
    iter;
  when (YPgmCmd = '*CANCEL');
    exsr C_EndPgm;
    leave;
  when (YPgmCmd = '*TOP');
    exsr C_Top;
    iter;
  when (YPgmCmd = '*BOT');
    exsr C_Bot;
    iter;
  when (YPgmCmd = '*MOREOPT');
    exsr C_MoreOpt;
  when (YPgmCmd = '*MOREKEYS');
    exsr C_MoreKeys;
  when (YPgmCmd = '*ENTER');
    exsr C_Enter;
    if (o_sflOpt = *blanks);
    //  ... keine Auswahl getroffen, weiter machen
    else;
      leave;
    endif;
  when (YPgmCmd = '*PAGEUP');
  when (YPgmCmd = '*PAGEDOWN');

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peek68fm;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  exsr VReadC;

endsr;

//============================================================*
//    VReadC        Verarbeiten der Subfileauswahlen          *
//============================================================*

begsr VReadC;

  IsSflError = bFalse;
  o_sflOpt = *blanks;

  if (*in80 = *off);
  //   keine Einträge in Subfile vorhanden ...
  else;

    for do_x2 = 1 to SflNbrRcd;
      readc pbsfl;
      *in11 = %eof;
      if (*in11 = *on);
        leave;
      endif;

      chain SflRec pbsfl;
      *in11 = not %found;

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
        //  Leere Auswahl: Markierung eines früheren Fehlers
        //  löschen
        exsr VSfpauClr;
      when (Sfl_Cmd = '*SELECT');
        //  Die erste Auswahl merken. Ausgeführt wird sie nur,
        //  wenn keine Zeile eine ungültige Auswahl enthält.
        if (o_sflOpt = *blanks);
          exsr VPos;
        endif;
        *in85 = '0'; // DSPATR(RI)
        exsr VSfpauChg;
      other;
        //  Unbekannter Programmbefehl
        clear usr8110;
        usr8110.var1 = YPgmCmd;
        p_sndPgmMg('USR8110': usr8110: sds.pgmName);
        exsr VSfpauErr;
        update pbsfl;
        IsSflError = bTrue;
        iter;
      endsl;

      update pbsfl;
    endfor;

    //  Ungültige Auswahl: keine Auswahl übernehmen und den
    //  Cursor auf die erste fehlerhafte Zeile setzen
    if (IsSflError = bTrue);
      o_sflOpt = *blanks;
      sfsanr = SflCsr;
    endif;

  endif;

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
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr C_Refresh;

  // - Subfile neu aufbauen
  exsr PBInit;
  //   Einlesen Subfileauswahlen
  exsr PBInitKey;
  exsr PBSetLL;
  exsr PBReadUp;
  //   Einlesen Kurzbefehle
  if (i_pgm = 'PEEK05');
    exsr PBSeperator;
    exsr PBInitKeyCmd;
    exsr PBSetLL;
    exsr PBReadUp;
  endif;

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
//    C_MoreOpt     F23 - Weitere Auswahlen                   *
//============================================================*

begsr C_MoreOpt;

  SFTop = SFTop + 1;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    VPos          Verarbeiten der Eingaben                  *
//============================================================*

begsr VPos;

  sflLine = $$line;
  o_sflOpt = sflLine.opt;

endsr;

//============================================================*
//    VSfpauClr     Löschen Subfileauswahl                    *
//============================================================*

begsr VSfpauClr;

  sfpau = *blanks;
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
//    PBInitKey     Initialisieren der Schlüsselfelder        *
//                  zum Füllen der Subfile                    *
//============================================================*

begsr PBInitKey;

  usrKey.section = '*' + i_pgm;
  usrKey.key     = '';

endsr;

//============================================================*
//    PBInitKeyCmd  Initialisieren der Schlüsselfelder        *
//                  zum Füllen der Subfile (Kurzbefehle)      *
//============================================================*

begsr PBInitKeyCmd;

  usrKey.section = '*CMD';
  usrKey.key     = '';

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

  SflRec = *zeros;
  SflNbrRcd = *zeros;

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr PBReadUp;

  dow ('1');
    IsEOF = f_readeUsr(usrKey.section: key: data);
    if (IsEOF = bTrue);
      leave;
    endif;

    if (key = '' or %subst(key: 1: 1) = '*');
      iter;
    endif;

    exsr PBFill;

    SflRec = SflRec + 1;
    write pbsfl;
    SflNbrRcd = SflRec;

    if (SflRec >= SflPage);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PBSeperator   Einfügen Trennlinie für Kurzbefehle       *
//============================================================*

begsr PBSeperator;

  if (SflRec >= SflPage);
    leavesr;
  endif;

  clear sflLine;
  sflLine = f_msgText('TXT0141': '');
  $$line = sflLine;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

  //  ... Löschen Subfileauswahl
  exsr VSfpauClr;

  //  ... Sperren Eingabefeld
  *in90 = '1'; // SFPAU(PR)

  SflRec = SflNbrRcd + 1;
  write pbsfl;
  SflNbrRcd = SflRec;

endsr;

//============================================================*
//    PBFill        Füllen Subfilesatz                        *
//============================================================*

begsr PBFill;

  wrk_MsgID = f_mapCmdToMsg(data: usrKey.section);
  if (wrk_MsgID <> '');
    wrk_MsgID  = 'KEY' + wrk_MsgID;
    wrk_MsgTxt = f_msgText(wrk_MsgID: ' ');
  else;
    //  Kurzbefehl ohne eigene Nachricht: Befehl anzeigen
    wrk_MsgTxt = data;
  endif;

  clear sflLine;
  sflLine.opt  = key;
  sflLine.text = wrk_MsgTxt;
  $$line = sflLine;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

  //  ... Freigeben Eingabefeld
  *in90 = '0'; // SFPAU(PR)

  //  ... Löschen Subfileauswahl
  exsr VSfpauClr;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr PBSetLL;

  p_setllUsr(usrKey.section: usrKey.key);

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 5;
    pos = 35;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 3;
    pos = 23;
  endif;

  SflPage = *hival;
  SflPageDDS = 6;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Öffnen der Dateien
  open peek68fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Rückkehrcode
  o_sflOpt = *blanks;
  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Darstellung der Subfile
  sflmde = '1';

  // - Darstellung der Befehlstasten
  SFTop = 1;
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
  peek27_name = f_pgmCallN('PEEK27');

  peek23(sds.pgmName: '*ALL': 0
        : yFKeys: yNbrOfKeys);
  ScrnFKeys = %subarr(yFKeys: 1);

  peek27(sds.pgmName: YChoice: YNbrOfCh: *omit: %len($$choice));

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

