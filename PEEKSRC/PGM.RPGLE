**free
//===============================================================*
//  (C) Thomas Raddatz                                           *
//  Bereich  : PEEK Version 3.5.0                                *
//  Typ      : PGM                                               *
//===============================================================*
//  Kurzdokumentation :                                          *
//  Peek/400 - RPG-LE Programm, Template v3.5.0                  *
//                                                               *
//  Marken für PEEK16:                                           *
//    //@TAG        PEEK16 fügt hier generierten Code ein, mit   *
//                  der Einrückung der Marke.                    *
//    X_TAG_X       Platzhalter, den PEEK16 ersetzt.             *
//    LIBRARY_NAME  Produktbibliothek der /include-Anweisungen.  *
//===============================================================*
ctl-opt debug;
ctl-opt alwnull(*usrctl);
ctl-opt option(*srcstmt: *nodebugio);

//====================================================*
//  Dateiliste                                        *
//====================================================*
dcl-f DSPF workstn usropn infds(workStn);

//  Eintragen Satzformatname: X_FMT1_X
dcl-f FILE00 disk usage(*update: *output) usropn
             rename(X_FMT1_X: FFILE00)
             infds(rcdFile00)
             commit(commitLvl);

dcl-f PEEKFLD keyed usropn prefix(F_);

dcl-ds rcdFile00 qualified;
  rcdLength int(10) pos(283);
  number    int(10) pos(397);
end-ds;

//====================================================*
//  Referenzfelder & Konstanten                       *
//====================================================*

//  Referenzfelder:
dcl-s r_bool char(1) template;
dcl-s r_copyRght like(r_msgDta) template;
dcl-s r_dsp80 like(r_bool) template;
dcl-s r_fieldNme char(10) template;
dcl-s r_fKeyDsp char(18) template;
dcl-s r_headTyp char(10) template;
dcl-s r_msgDta char(512) template;
dcl-s r_msgID char(7) template;
dcl-s r_pgmCallN char(21) template;
dcl-s r_pgmCmd char(10) template;
dcl-s r_pgmCmdDt char(256) template;
dcl-s r_rcdBuf char(32766) template;
dcl-s r_clCmd varchar(32702) template;
dcl-s r_int4 int(10) template;

//  Boolsche Werte:
// dcl-c bTrue '1';
// dcl-c bFalse '0';
// dcl-c bNotDef '-';

//  Ausgewählter Editor:
dcl-s Editor char(10) inz;
dcl-c cEDITOR_HEX '*HEX';
dcl-c cEDITOR_STRING '*STRING';

//  Übertragen VARGRAPHIC Felder
dcl-s x int(10) inz;
dcl-s offs int(10) inz;
dcl-s rem int(10) inz;
dcl-s len int(10) inz;

//====================================================*
//  Prototypen                                        *
//====================================================*
/include LIBRARY_NAME/QCOPYLE,D_VARDEF
/include LIBRARY_NAME/QCOPYLE,FLDL0100

/include LIBRARY_NAME/QCOPYLE,PEXIT04
/include LIBRARY_NAME/QCOPYLE,PPEEK21
/include LIBRARY_NAME/QCOPYLE,PPEEK23
/include LIBRARY_NAME/QCOPYLE,PPEEK32
/include LIBRARY_NAME/QCOPYLE,PPEEK45
/include LIBRARY_NAME/QCOPYLE,PPEEK53
/include LIBRARY_NAME/QCOPYLE,PPEEK58
/include LIBRARY_NAME/QCOPYLE,PPEEK59
/include LIBRARY_NAME/QCOPYLE,PPEEK64
/include LIBRARY_NAME/QCOPYLE,QCMDEXC
/include LIBRARY_NAME/QCOPYLE,CEECNDHDLR
/include LIBRARY_NAME/QCOPYLE,QTNRCMTI

/define internal_prototype
/include LIBRARY_NAME/QCOPYLE,PUPDPGM
/undefine internal_prototype

//====================================================*
//  List API Format FLDL0100 mit eigenen zusätzlichen *
//  Feldern.                                          *
//====================================================*
dcl-ds FLDL0100 likeds(FLDL0100_t) inz;

//====================================================*
//  Cursorposition                                    *
//====================================================*

dcl-ds *n;
  WScnCsrRow int(10) pos(1);
  WScnCsrCol int(10) pos(5);
end-ds;

dcl-ds workstn;
  wScnAID    char(1) pos(369);
  wScnCsrPos int(5) pos(370);
end-ds;

dcl-s xScnCsrRow like(wScnCsrRow) inz;

//  Cursorposition beibehalten: X_KEEP_X
dcl-s keepCrsPos ind inz(X_KEEP_X);

//====================================================*
//  Systemdatenstruktur                               *
//====================================================*
dcl-ds *n psds;
  // Programmname
  PsPgmName char(10) pos(1);
  // Programmbibliothek
  PsPgmLib char(10) pos(81);
  // Benutzer
  PsUser char(10) pos(254);
end-ds;

//============================================================*
//    Definition F-Tasten Bildschirmfelder                    *
//============================================================*

dcl-ds *n;
  scrnFKeys char(18) dim(32) inz(*blanks);
  XXFKEY01 char(18) pos(1);
  XXFKEY02 char(18) pos(19);
  XXFKEY03 char(18) pos(37);
  XXFKEY04 char(18) pos(55);
  XXFKEY05 char(18) pos(73);
  XXFKEY06 char(18) pos(91);
  XXFKEY07 char(18) pos(109);
  XXFKEY08 char(18) pos(127);
  XXFKEY09 char(18) pos(145);
  XXFKEY10 char(18) pos(163);
  XXFKEY11 char(18) pos(181);
  XXFKEY12 char(18) pos(199);
  XXFKEY13 char(18) pos(217);
  XXFKEY14 char(18) pos(235);
  XXFKEY15 char(18) pos(253);
  XXFKEY16 char(18) pos(271);
  XXFKEY17 char(18) pos(289);
  XXFKEY18 char(18) pos(307);
  XXFKEY19 char(18) pos(325);
  XXFKEY20 char(18) pos(343);
  XXFKEY21 char(18) pos(361);
  XXFKEY22 char(18) pos(379);
  XXFKEY23 char(18) pos(397);
  XXFKEY24 char(18) pos(415);
end-ds;

//============================================================*

dcl-s PEEK21_NAME like(r_pgmCallN) inz;
dcl-s PEEK23_NAME like(r_pgmCallN) inz;
dcl-s PEEK32_NAME like(r_pgmCallN) inz;
dcl-s PEEK45_NAME like(r_pgmCallN) inz;
dcl-s PEEK59_NAME like(r_pgmCallN) inz;
dcl-s PEEK64_NAME like(r_pgmCallN) inz;
dcl-s EXIT04_NAME like(r_pgmCallN) inz;

//  Vorbelegung leerer Zeitstempelfelder. Datums- und Zeitfelder
//  belegt PEEK16 im Format des Feldes vor (ISO -).
dcl-c ISOZ '0001-01-01-00.00.00.000000';

dcl-s yBImage pointer inz;
dcl-s yAImage pointer inz;

dcl-s yFKeys like(r_fKeyDsp) inz dim(32);
dcl-s yNbrOfKeys like(r_int4) inz;
dcl-s yPgmCmd like(r_pgmCmd) inz;
dcl-s yPgmCmdDt like(r_pgmCmdDt) inz;

dcl-s yOutBuffer like(r_rcdBuf) inz;
dcl-s yOutBuffLn like(r_int4) inz;
dcl-s yCcsid like(r_int4) inz;
dcl-s yMsgID like(r_msgID) inz;
dcl-s yMsgDta like(r_msgDta) inz;

// - PEEK 45 -
dcl-s yDsp80 like(r_dsp80) inz;
dcl-s yHeaderTyp like(r_headTyp) inz;
dcl-s yCopyright like(r_copyRght) inz;
dcl-s yFldName like(r_fieldNme) inz;
dcl-s yFldInhalt like(r_rcdBuf) inz;
dcl-s yProtect like(r_bool) inz(bFalse);
dcl-s yIsUcs2 like(r_int4) inz;
dcl-s yLength like(r_int4) inz;

dcl-s sfBot like(r_int4) inz;

dcl-s isFound like(r_bool) inz(bFalse);
dcl-s isError like(r_bool) inz(bFalse);
//  Standardwert für "Eingabe in Kleinbuchstaben": X_LCAS_X
dcl-s isLower like(r_bool) inz(X_LCAS_X);
//  Standardwert für "Satz gesperrt einlesen": X_RLCK_X
dcl-s isRcdLockDft like(r_bool) inz(X_RLCK_X);
//  Eingabe in Kleinbuchstaben erlaubt Ja/Nein: X_ALWL_X
dcl-s isAlwLower like(r_bool) inz(X_ALWL_X);
dcl-s isVisible like(r_bool) inz(bFalse);
dcl-s isCvtChar like(r_bool) inz(bFalse);
dcl-s isRcdLocked like(r_bool) inz(bFalse);

dcl-s scnNbr like(r_int4) inz;
dcl-c nbrFKeys 3;

dcl-s keyChar char(1) inz;

dcl-s clCmd like(r_clCmd);

dcl-ds cmti0100 likeds(cmti0100_t) inz;
dcl-ds errCode likeds(errCode_t) inz;

dcl-s pgmMsgID like(r_msgID) inz;
dcl-s pgmMsgDta like(r_msgDta) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//  NULL-Indikatoren (F8) während des erneuten Lesens zum Sperren
//  (Index = Feldnummer, max. 8000 Felder je Satzformat)
dcl-s nullSave ind dim(8000) inz;

//  ... Feldefinitionen zur Bildschirmsteuerung
//@DEF1

//  ... Konstanten für "Felder zu lang" (> 512 Byte)
//@DEF2

//  Before-Image für Prüfung auf Datensatzänderung
//  bei optimistischer Satzsperre
dcl-ds b4Image likeds(RCD_DS) inz;

//  Datenpuffer für Hex-Editor ...
//  ... umbenennen der Feldnamen (Länge: X_RNM1_X)
dcl-ds RCD_DS extname('FILE00') len(X_RNM1_X);
  //@RNM1
end-ds;

dcl-s pRCD_BUFFER pointer inz(%addr(RCD_DS));
dcl-s RCD_BUFFER like(RCD_DS) based(pRCD_BUFFER);

dcl-pi UPDPGM;
  i_dsp80       like(dsp80_t) const;
  io_headerType like(headerType_t);
  i_copyright   like(copyright_t) const;
  i_rcdNbr      like(rcdNbr_t) const;
  i_file        like(file_t) const;
  i_library     like(lib_t) const;
  i_member      like(mbr_t) const;
  i_function    like(function_t) const;
  i_commitLVL   like(commitLvl_t) const;
  i_isUpdKey    like(bool_t) const;
  io_screenNbr  like(int4_t);
  io_isLower    like(bool_t);
  io_csrRow     like(int4_t);
  io_csrCol     like(int4_t);
  o_msgID       like(msgId_t);
  o_msgDta      like(msgDta_t);
end-pi;

//  ... umbenennen der externen Feldnamen
//  (Eingabebestimmungen in einer generierten /include-Teildatei)
//@RNM2

//----------------------------------------------------*

ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr InzSr;

o_msgID  = ' ';
o_msgDta = ' ';

// - Setzen Eingabe in Kleinbuchstaben
if (io_isLower = bTrue or io_isLower = bFalse);
  isLower = io_isLower;
endif;

// - Darstellen der Befehlstasten
sfBot = 1;

// - Setzen Bildschirmattribute
exsr setScreen;

// - Löschen Programmnachrichten
p_rmvPgmMg(psPgmName);

// - Öffnen der Dateien
exsr openFiles;

// - Daten aktualisieren
exsr c_refresh;

// - Anzeigen Copyright
pgmMsgID  = 'USR9999';
pgmMsgDta = i_copyright;
p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName);

// - Setzen der Cursorposition
if (keepCrsPos);
  csrRow = io_csrRow;
  csrCol = io_csrCol;
else;
  csrRow = 0;
  csrCol = 0;
endif;

//------------------*
// Hauptschleife    *
//------------------*
dow ('1');

  // - Flag für nicht darstellbare Zeichen
  isCvtChar = bFalse;

  // - Feldbezeichnung
  select;
  when (io_headerType = '*FIELDNAME');
    *in70 = *off;
    *in75 = *off;
  when (io_headerType = '*FIELDTYPE');
    *in70 = *off;
    *in75 = *on;
  when (io_headerType = '*COLHDG');
    *in70 = *on;
    *in75 = *on;
  other;
    *in70 = *on;
    *in75 = *off;
  endsl;

  // - Lower-/Upper-Case
  if (isLower = bTrue);
    *in71 = *on;
  else;
    *in71 = *off;
  endif;

  // - geschütze Felder nicht unterstreichen
  *in72 = *off;

  // - Freigeben Schlüsselfelder
  if ((i_isUpdKey = bTrue  )  or
      (i_function = '*ADD' )  or
      (i_function = '*COPY'));
    *in73 = *on;
  else;
    *in73 = *off;
  endif;

  // - Anzeigen Sperrstatus des Datensatz
  if (i_function = '*CHANGE');
    *in74 = *on;
    if (isRcdLocked = bTrue);
      RLKMSGNBR = '0129';
    else;
      RLKMSGNBR = '0130';
    endif;
  else;
    *in74 = *off;
    RLKMSGNBR = '0130';
  endif;

  // - Initialisieren Bildschirmnummer
  //  ... eintragen max. Anzahl Bildschirmseiten: X_LSCN_X
  if ((scnNbr < 1  ) or
      (scnNbr > X_LSCN_X));
    scnNbr = 1;
  else;
  //   ... Wert ist im gültigen Bereich
  endif;

  // - Anzeigen "Weitere"/"Ende"
  //  ... eintragen max. Anzahl Bildschirmseiten
  if (scnNbr = X_LSCN_X);
    *in83 = *on;
  else;
    *in83 = *off;
  endif;

  // - Prüfen ...
  select;
  //  ... Bildschirmfelder auf nicht darstellbare Zeichen
  //@CHKS
  other;
    scnNbr = 1;
    exsr chkChar001;
  endsl;

  // - Ausgeben Nachricht
  //   "Felder mit nicht darstellbaren Zeichen wurden ausgeblendet"
  exsr MSG8164;

  // - Anzeigen der Msg-Subfile
  *in89 = *off;
  write MSGCTL;

  // - Anzeigen Kopf
  write HEAD;

  // - Anzeigen F-Tasten
  write FKEYS;

  // - Anzeigen der Befehlstasten
  select;
  when ((sfBot = 2) and
        (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write PBBOT02; // BT-Tasten 2
  when ((sfBot = 3) and
        (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write PBBOT03; // BT-Tasten 3
  when ((sfBot = 4) and
        (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write PBBOT04; // BT-Tasten 4
  when ((sfBot = 5) and
        (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write PBBOT05; // BT-Tasten 5
  when ((sfBot = 6) and
        (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write PBBOT06; // BT-Tasten 6
  when ((sfBot = 7) and
        (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write PBBOT07; // BT-Tasten 7
  when ((sfBot = 8) and
        (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write PBBOT08; // BT-Tasten 8
  other;
    write PBBOT01; // BT-Tasten 1
    sfBot = 1;
  endsl;

  // - Blättern ...
  select;
  //  ... generieren Auswahl der anzuzeigenden Bildschirmseite
  //@SCRN
  other;
    exsr chkChar001;
    //  ... 1. Bildschirmseite
    //@SCN1
    scnNbr = 1;
  endsl;

  // - Zurückgeben aktuelle Bildschirmnummer
  io_screenNbr = scnNbr;

  // - Löschen Programmnachrichten
  p_rmvPgmMg(psPgmName);

  // - Berechnen Zeile/Spalte
  wScnCsrRow = %div(wScnCsrPos: 256);
  wScnCsrCol = %rem(wScnCsrPos: 256);

  // - Löschen der Cursorposition
  csrRow = 0;
  csrCol = 0;

  // - Merken der Cursorposition beim Verlassen des Programs
  io_csrRow = wScnCsrRow - wndTopRow;
  io_csrCol = wScnCsrCol - wndLeftCol - 1;

  // - Mappen der gedrückten Taste
  //   in Programmbefehl
  PEEK21(wScnAID: 'PXXXXXXXX'
        : yPgmCmd: yPgmCmdDt: yMsgID: yMsgDta);
  if (yMsgID <> ' ');
    p_sndPgmMg(yMsgID: yMsgDta: psPgmName);
    iter;
  endif;

  // - Abfragen der Befehlstasten
  select;
  //   F3  - Beenden
  when (yPgmCmd = '*EXIT');
    exsr c_endPgm;
    leave;
  //   F5  - Aktualisieren
  when (yPgmCmd = '*REFRESH');
    exsr c_refresh;

  //   F6  - Umschalten LOWER-CASE
  when (yPgmCmd = '*TGLLUCASE');
    exsr c_tgLUCase;

  //       - Einschalten Lower-Case
  when (yPgmCmd = '*LOWERCASE');
    exsr c_lowCase;

  //       - Umschalten Upper-CASE
  when (yPgmCmd = '*UPPERCASE');
    exsr c_uppCase;

  //   F7  - Umschalten der Überschrift
  when (yPgmCmd = '*HEADLINE');
    exsr c_chgHead;

  //   F8  - Setzen/Löschen NULL Indicator
  when (yPgmCmd = '*TGLNULL');
    exsr c_tgNullInd;
    exsr keepCsrPos;

  //   F9  - Hex-Editor
  when (yPgmCmd = '*HEXEDIT');
    exsr c_fldHexEd;
    exsr keepCsrPos;

  //   F10 - String-Editor
  when (yPgmCmd = '*STREDIT');
    exsr c_fldStrEd;
    exsr keepCsrPos;
  //   F12 - Beenden
  when (yPgmCmd = '*CANCEL');
    exsr c_endPgm;
    leave;
  //   F13 - Umschalten Satzsperre
  when (yPgmCmd = '*TGLRCDLCK');
    exsr c_tgRcdLock;
    exsr keepCsrPos;
  //   F17 - Anfang Datensatz
  when (yPgmCmd = '*TOP');
    scnNbr = 1;
  //   F18 - Ende Datensatz
  when (yPgmCmd = '*BOT');
    //  ... eintragen max. Anzahl Bildschirmseiten
    scnNbr = X_LSCN_X;

  //   F24 - Weitere Tasten
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;
  //   Enter
  when (yPgmCmd = '*ENTER');
    exsr updateFile;
    if (isError = bFalse);
      leave;
    endif;
  //   Page up
  //  ... eintragen max. Anzahl Bildschirmseiten
  when ((yPgmCmd = '*PAGEUP')   and
        (scnNbr < X_LSCN_X));
    scnNbr = scnNbr + 1;
  //   Page down
  when ((yPgmCmd = '*PAGEDOWN') and
        (scnNbr  > 1 ));
    scnNbr = scnNbr - 1;
  //   Sonstige Tasten
  other;
    p_wrongKey(wScnAID: psPgmName);
  endsl;

enddo;

//   Beenden Programm
exsr exitPgm;

//===================================================*
//    exitPgm   Beenden Programm                     *
//===================================================*

begsr exitPgm;

  //   Schließen Dateien
  exsr closeFiles;

  //   Merken Eingabe in Kleinbuchstaben
  io_isLower = isLower;

  *inlr = *on;
  return;

endsr;

//===================================================*
//    Einlesen Datensatz & füllen Bildschirm         *
//===================================================*

begsr readRecord;

  //  Einlesen Datensatz für ...
  select;
  //  ... update
  when (i_function = '*CHANGE');
    HDGMSGNBR = '0063';
    if (isRcdLockDft = bTrue);
      chain(e) i_rcdNbr FFILE00;
      isRcdLocked = bTrue;
    else;
      chain(ne) i_rcdNbr FFILE00;
      isRcdLocked = bFalse;
    endif;
    isFound = %found(FILE00);
    isError = %error();
  //  ... copy
  when (i_function = '*COPY');
    HDGMSGNBR = '0064';
    chain(ne) i_rcdNbr FFILE00;
    isRcdLocked = bFalse;
    isFound = %found(FILE00);
    isError = %error();
  //  ... add
  when (i_function = '*ADD');
    HDGMSGNBR = '0065';
    exsr clearRecord;
    isRcdLocked = bTrue;
    isFound = bTrue;
    isError = bFalse;
  //  ... FEHLER!!!
  other;
    isRcdLocked = bFalse;
    pgmMsgID  = 'USR8113';
    pgmMsgDta = i_function;
    p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName);
    p_movPgmMg(psPgmName);
    exsr exitPgm;
  endsl;

  //  Fehler aufgetreten ...
  if (isError = bTrue);
    pgmMsgID  = 'USR8156';
    pgmMsgDta = ' ';
    p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName);
    p_movPgmMg(psPgmName);
    exsr exitPgm;
  endif;

  //  ... Satz nicht gefunden
  if (isFound = bFalse);
    pgmMsgID  = 'USR8120';
    pgmMsgDta = ' ';
    p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName);
    p_movPgmMg(psPgmName);
    exsr exitPgm;
  endif;

endsr;

//===================================================*
//    Löschen aller Felder im Datensatz.             *
//===================================================*

begsr clearRecord;

  clear FFILE00;

  //@CLR

endsr;

//============================================================*
//    DataToScn     Übertragen der Dateifelder in die         *
//                  Bildschirmfelder                          *
//============================================================*

begsr dataToScn;

  //  Anzeigen relative Satznummer
  xxRcdN = i_rcdNbr;

  //  Anzuzeigender Bildschirm
  scnNbr = io_screenNbr;

  //  Übertragen Dateifelder
  //  in die Bildschirmfelder ...
  //  ... generieren MOVEL extField => intField (ToScreen)
  //@TSCN

  //  ... prüfen auf ISO-Felder
  //@ISO

endsr;

//============================================================*
//    c_endPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endPgm;

  // - Löschen Programmnachrichten
  p_rmvPgmMg(psPgmName);

  // - Zurückgeben Abbruchmeldung
  o_msgID  = 'USR8100';
  o_msgDta = yPgmCmd;

endsr;

//============================================================*
//    c_refresh     F5 - Daten aktualisieren                  *
//============================================================*

begsr c_refresh;

  // - IsVisible Bezugszahlen
  //   Einblenden aller Felder
  exsr EnableEdit;

  // - Einlesen der Daten und füllen Bildschirm
  exsr readRecord;
  exsr dataToScn;

  // - Merken aktuelles Image
  b4Image = RCD_DS;

endsr;

//============================================================*
//    c_tgLUCase    F6  - Umschalten Lower/Upper-Case         *
//============================================================*

begsr c_tgLUCase;

  if (isLower = bFalse);
    exsr c_lowCase;
  else;
    exsr c_uppCase;
  endif;

endsr;

//============================================================*
//    c_lowCase     F6  - Einschalten Lower-Case              *
//============================================================*

begsr c_lowCase;

  if (isAlwLower = bTrue);
    isLower = bTrue;
  else;
    pgmMsgID  = 'USR8215';
    pgmMsgDta = ' ';
    p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName);
  endif;

  //  Beibehalten der Cursorposition ...
  exsr keepCsrPos;

endsr;

//============================================================*
//    c_uppCase     F6  - Einschalten Upper-Case              *
//============================================================*

begsr c_uppCase;

  isLower = bFalse;

  //  Beibehalten der Cursorposition ...
  exsr keepCsrPos;

endsr;

//============================================================*
//    c_chgHead     F7  - Umschalten der Überschrift          *
//============================================================*

begsr c_chgHead;

  io_headerType =
    f_nextHeaderType(io_headerType);

  //  Beibehalten der Cursorposition ...
  exsr keepCsrPos;

endsr;

//============================================================*
//    c_tgRcdLock   F13 - Umschalten Satzsperre               *
//============================================================*

begsr c_tgRcdLock;

  if (i_function <> '*CHANGE');
    pgmMsgID  = 'USR8231';
    pgmMsgDta = '';
    p_sndPgmMg(pgmMsgID: pgmMsgDta: psPgmName);
    leavesr;
  endif;

  if (isRcdLocked = bTrue);
    exsr unlockRecord;
  else;

    //  ... vergleichen Before-Images auf Abweichungen
    //      (NULL-Indikatoren aus F8 beim Lesen nicht verlieren)
    exsr saveNull;
    exsr readRecord;
    exsr rstNull;
    if (b4Image <> RCD_DS);
      //      ... freigeben Datensatz, bei unterschiedlichen Images
      //          und fragen Benutzer, wie es weiter gehen soll (dennoch aktualisieren?)
      yMsgID     = '';
      yMsgDta    = '';
      callp(e) PEEK59(i_dsp80: '*QUESTION': 'USR8232': ''
                     : 'YC': yMsgID: yMsgDta);
      if (%error());
        isError = bTrue;
        leavesr;
      endif;
      //      ... abbrechen der Operation, wenn vom Benutzer gewünscht
      if (yMsgID = 'USR8190' and yMsgDta <> '*YES');
        p_sndPgmMg(yMsgID : yMsgDta : psPgmName);
        isError = bTrue;
        leavesr;
      endif;
    endif;

    //      ... sperren Datensatz für UPDATE
    exsr lockRecord;
  endif;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//===================================================*
//    Verarbeiten der Eingaben                       *
//===================================================*

begsr updateFile;

  //  Sperren Datensatz, wenn nicht bereits geschehen ...
  if ((i_function = '*CHANGE') and
      (isRcdLocked = bFalse));
    exsr lockRecord;
    if ((isFound = bFalse) or (isError = bTrue));
      leavesr;
    endif;
    //  ... vergleichen Before-Images auf Abweichungen
    if (b4Image <> RCD_DS);
      //      ... freigeben Datensatz, bei unterschiedlichen Images
      //          und fragen Benutzer, wie es weiter gehen soll (dennoch aktualisieren?)
      exsr unlockRecord;
      yMsgID     = '';
      yMsgDta    = '';
      callp(e) PEEK59(i_dsp80: '*QUESTION': 'USR8225': ''
                     : 'YC': yMsgID: yMsgDta);
      if (%error());
        isError = bTrue;
        leavesr;
      endif;
      //      ... abbrechen der Operation, wenn vom Benutzer gewünscht
      if (yMsgID = 'USR8190' and yMsgDta <> '*YES');
        p_sndPgmMg(yMsgID : yMsgDta : psPgmName);
        isError = bTrue;
        leavesr;
      endif;

      //      ... sperren Datensatz für UPDATE
      if (isRcdLocked = bFalse);
        exsr lockRecord;
        if ((isFound = bFalse) or (isError = bTrue));
          leavesr;
        endif;
      endif;

    endif;
  endif;

  //  ... prüfen auf ISO-Felder
  //@ISO

  //  Übertragen Felder vom Bildschirm
  //  in die Dateifelder ...
  //  ... generieren MOVEL intField => extField (FromScreen)
  //@FSCN

  //  Abschließen der Verarbeitung ...
  select;
  //  ... für update
  when (i_function = '*CHANGE');
    update(e) FFILE00;
    isError = %error();
  //  ... für copy
  when (i_function = '*COPY');
    write(e) FFILE00;
    isError = %error();
  //  ... für add
  when (i_function = '*ADD ');
    write(e) FFILE00;
    isError = %error();
  //  ... FEHLER!!!
  other;
    unlock(e) FILE00;
    isError = %error();
  endsl;

  if (isError = bTrue);
    //  Update/write fehlgeschlagen ...
    if (*in95);
      rolbk;
    else;
      unlock FILE00;
    endif;
    exsr saveNull;
    exsr ReadRecord;
    exsr rstNull;
    // exsr DataToScn;
    //  Setzen Fehler-Flag ...
    isError = bTrue;
  else;
    //  Updatze/write OK ...
    if (*in95);
      commit;
    else;
      unlock FILE00;
    endif;
    //  Löschen Fehler-Flag ...
    isError = bFalse;
  endif;

  if (isError = bFalse and
      f_exist('EXIT04': '*LIBL': '*PGM') = bTrue);
    if (i_function = '*ADD');
      yBImage = *NULL;
    else;
      yBImage = %addr(b4Image);
    endif;
    yAImage = %addr(RCD_DS);
    EXIT04(i_file: i_library: i_member
          : i_function: PsUser: %timestamp()
          : rcdFile00.number
          : rcdFile00.rcdLength
          : yBImage: yAImage);
  endif;

endsr;

//============================================================*
//    lockRecord    Einlesen Datensatz mit Sperre             *
//============================================================*

begsr lockRecord;

  //  Lesen Datensatz mit Satzsperre für nachfolgenden UPDATE ...
  //  CHAIN überschreibt auch die NULL-Indikatoren. Die mit F8
  //  gesetzten Indikatoren sichern und danach zurückschreiben,
  //  die Feldinhalte überträgt FSCN anschließend vom Bildschirm.
  exsr saveNull;
  chain(e) i_rcdNbr FFILE00;
  isFound = %found(FILE00);
  isError = %error();
  exsr rstNull;
  //  ... Fehler aufgetreten
  if (isError = bTrue);
    pgmMsgID  = 'USR8156';
    pgmMsgDta = ' ';
    p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName);
    // p_movPgmMg(psPgmName);
    // exsr exitPgm;
  endif;
  //  ... Satz nicht gefunden
  if (isFound = bFalse);
    pgmMsgID  = 'USR8120';
    pgmMsgDta = ' ';
    p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName);
    // p_movPgmMg(psPgmName);
    // exsr exitPgm;
  endif;

  if ((isError = bFalse) and (isFound = bTrue));
    isRcdLocked = bTrue;
  else;
    isRcdLocked = bFalse;
  endif;

endsr;

//============================================================*
//    saveNull      Sichern der NULL-Indikatoren (F8)         *
//    rstNull       Zurückschreiben der NULL-Indikatoren      *
//============================================================*

begsr saveNull;
  //@NSAV
endsr;

begsr rstNull;
  //@NRST
endsr;

//============================================================*
//    unlockRecord  Freigeben Datensatzsperre                 *
//============================================================*

begsr unlockRecord;

  unlock FILE00;

  isRcdLocked = bFalse;

endsr;

//============================================================*
//    chkChar       Prüfen auf nicht darstellbare Zeichen     *
//                  und Schlüsselfeld                         *
//============================================================*

begsr chkChar;

  chain (F_Field) FPEEKFLD;
  if (not %found(PEEKFLD));
    // - Zugriff fehlgeschlagen, Feld sperren
    yMsgID  = 'USR8163';
    yMsgDta = ' ';
    clear FLDL0100;
  else;

    FLDL0100 = F_FFD;

    //  ... prüfen auf nicht darstellbare Zeichen
    //      ... Konvertieren nicht darstellbarer Zeichen
    if (FLDL0100.F1DTYP = 'G'); // = Graphic
      yCcsid = FLDL0100.F1FDCC;
    else;
      yCcsid = 0;
    endif;

    callp(e) PEEK32(yOutBuffer: yOutBuffLn: yCcsid
                   : yMsgID: yMsgDta);
    if (%error());
      yMsgID  = 'USR8163';
      yMsgDta = ' ';
    endif;
  endif;

  //  Nachricht auswerten und ...
  if (yMsgID <> ' ');
    //  ... Felder ausblenden
    isVisible = *off;
    isCvtChar = bTrue;
  else;
    //  ... Felder einblenden
    isVisible = *on;
  endif;

  //  Schlüsselfeld?
  if (F_DESC <> ' ');
    //  ... JA
    keyChar = '>';
  else;
    //  ... NEIN
    keyChar = ':';
  endif;

endsr;

//============================================================*
//    Öffnen der Dateien                                      *
//============================================================*

begsr openFiles;

  //  Überschreiben DB-Datei:
  clCmd = 'OVRDBF ' +
            'FILE(FILE00) ' +
            'TOFILE(' +
              %trim(i_library) + '/' +
              %trim(i_file) +
            ') ' +
            'MBR(' +
              %trim(i_member) +
            ') ' +
            'OVRSCOPE(*CALLLVL) ' +
            'SHARE(*NO) ' +
            'SEQONLY(*NO) ' +
            'SECURE(*YES)';
  QCMDEXC(clCmd: %len(clCmd));

  //  Überschreiben Bildschirmdatei:
  clCmd = 'OVRDBF ' +
            'FILE(DSPF) ' +
            'TOFILE(' +
              %trim(PsPgmLib) + '/' +
              'F' + %subst(PsPgmName: 2) +
            ') ' +
            'OVRSCOPE(*CALLLVL) ' +
            'SHARE(*NO) ' +
            'SECURE(*YES)';
  QCMDEXC(clCmd: %len(clCmd));

  //  Überschreiben PEEKFLD:
  clCmd = 'OVRDBF ' +
            'FILE(PEEKFLD) ' +
            'TOFILE(QTEMP/PEEKFLD) ' +
            'MBR(*FIRST) ' +
            'OVRSCOPE(*CALLLVL) ' +
            'SHARE(*NO) ' +
            'SEQONLY(*NO) ' +
            'SECURE(*YES)';
  QCMDEXC(clCmd: %len(clCmd));

  //  Datei öffnen ...
  if (i_commitLVL = '0');
    //  ... ohne Commit
    *in95 = *off;
  else;
    //  ... mit Commit
    *in95 = *on;
  endif;

  commitLvl = i_commitLVL;

  open(e) FILE00;
  if (%error());
    //  Datei konnte nicht geöffnet werden
    p_movPgmMg(psPgmName);
    pgmMsgID  = 'USR0005';
    pgmMsgDta = 'FILE00';
    p_sndPgmMg(pgmMsgID : pgmMsgDta :
               psPgmName:'*ESCAPE'  );
    exsr exitPgm;
  endif;

  //  Öffnen der Bildschirmdatei
  open(e) DSPF;
  if (%error());
    //  Datei konnte nicht geöffnet werden
    p_movPgmMg(psPgmName);
    pgmMsgID  = 'USR0005';
    pgmMsgDta = 'DSPF';
    p_sndPgmMg(pgmMsgID : pgmMsgDta :
               psPgmName:'*ESCAPE'  );
    exsr exitPgm;
  endif;

  //  Öffnen der Feldbeschreibung
  open(e) PEEKFLD;
  if (%error());
    //  Datei konnte nicht geöffnet werden
    p_movPgmMg(psPgmName);
    pgmMsgID  = 'USR0005';
    pgmMsgDta = 'PEEKFLD';
    p_sndPgmMg(pgmMsgID : pgmMsgDta :
               psPgmName:'*ESCAPE'  );
    exsr exitPgm;
  endif;

endsr;

//============================================================*
//    Schließen der Dateien                                   *
//============================================================*

begsr closeFiles;

  //  Falls irgendetwas unerwartetes schief
  //  gelaufen sein sollte ...
  if (*in95);
    rolbk;
  endif;

  close PEEKFLD;
  close FILE00;
  close DSPF;

  //  Entfernen der Triggerprogramme aus dem
  //  Arbeitsspeicher ...
  clCmd = 'RCLRSC LVL(*)';
  QCMDEXC(clCmd: %len(clCmd));

endsr;

//============================================================*
//    keepCsrPos    Beibehalten der Cursorposition            *
//============================================================*

begsr keepCsrPos;

  //  Beibehalten der Cursorosition
  csrRow = wScnCsrRow - wndTopRow;
  csrCol = wScnCsrCol - wndLeftCol - 1;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = *off;
    wndTopRow  = 1;
    wndLeftCol = 40;
  else;
    //    80-Zeichen Anzeige
    *in88 = *on;
    wndTopRow  = 1;
    wndLeftCol = 7;
  endif;

endsr;

//============================================================*
//  Programminitialisierung                                   *
//============================================================*

begsr InzSr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  PEEK21_NAME = f_pgmCallN('PEEK21');
  PEEK23_NAME = f_pgmCallN('PEEK23');
  PEEK32_NAME = f_pgmCallN('PEEK32');
  PEEK45_NAME = f_pgmCallN('PEEK45');
  PEEK59_NAME = f_pgmCallN('PEEK59');
  PEEK64_NAME = f_pgmCallN('PEEK64');
  EXIT04_NAME = f_pgmCallN('EXIT04': '*LIBL');

  pgmQ = '*';

  //  Einlesen der Tastenbelegung
  PEEK23('PXXXXXXXX': '*ALL': 3
        : yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

  //  Starten Commit Control
  if (i_commitLVL <> '0');
    clear errCode;
    QTNRCMTI(cmti0100: %size(cmti0100)
            : 'CMTI0100': errCode);
    if (cmti0100.statusActGrp <> 'A');
      clCmd = 'STRCMTCTL +
               LCKLVL(*CHG) NFYOBJ(*NONE) +
               CMTSCOPE(*ACTGRP)';
      QCMDEXC(clCmd: %len(clCmd));
      //  Check status when debugging the program
      // QTNRCMTI(cmti0100: %size(cmti0100)
      //         : 'CMTI0100': errCode);
    endif;
  endif;

endsr;

//====================================================*
//  fromBuffer - Übertragen Rohdaten aus IO-Puffer    *
//====================================================*

begsr fromBuffer;

  F_Field = yFldName;
  chain (F_Field) FPEEKFLD;
  if (%found(PEEKFLD));
    FLDL0100 = F_FFD;

    if (FLDL0100.F1UCS2 = '1');
      //   UCS2 field
      yIsUcs2 = FLDL0100.F1FDCC;
      yLength = FLDL0100.F1NDBC;
      f_rtvFld(yFldInhalt: Rcd_Buffer:
               FLDL0100: bFalse);
    else;
      //   non-UCS2 field
      yIsUcs2 = 0;
      yLength = f_rtvFld(yFldInhalt: Rcd_Buffer:
                         FLDL0100: bFalse);
    endif;

    if (Editor = cEDITOR_STRING);
      PEEK64(i_dsp80: io_headerType: i_copyright
            : yFldName: yFldInhalt: yLength
            : yProtect: yIsUcs2
            : yMsgID: yMsgDta);
    else;
      //  Die Datenbank hat CHAR-Felder schon beim Lesen in die
      //  Job-CCSID umgesetzt: PEEK45 darf sie nicht noch einmal umsetzen.
      PEEK45(i_dsp80: io_headerType: i_copyright
            : yFldName: yFldInhalt: yLength
            : yProtect: yIsUcs2
            : yMsgID: yMsgDta: bTrue);
    endif;

    if (yMsgID = 'USR8112'); // = ENTER
      exsr ToBuffer;
    endif;
  endif;

endsr;

//====================================================*
//  toBuffer   - Übertragen Rohdaten nach IO-Puffer   *
//====================================================*

begsr toBuffer;

  p_fldToBuf(Rcd_Buffer :
             yFldInhalt :
             FLDL0100   :
             bFalse     );

endsr;

//====================================================*
//  MSG8164    - Ausgeben Fehlernachricht             *
//  Felder mit nicht darstellbaren Zeichen!           *
//====================================================*

begsr MSG8164;

  // - Ausgeben Nachricht bei nicht
  //   darstellbaren Zeichen
  if (isCvtChar = bTrue);
    //  ... vorhanden
    pgmMsgID  = 'USR8164';
    pgmMsgDta = ' ';
    p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName);
  else;
  //  ... nicht vorhanden
  endif;

endsr;

//====================================================*
//  MSG8208    - Ausgeben Fehlernachricht             *
//  Nur INPUT-Felder können nicht geändert werden.    *
//====================================================*

begsr MSG8208;

  pgmMsgID  = 'USR8208';
  pgmMsgDta = ' ';
  p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName);

endsr;

//====================================================*
//  USR8193    - Ausgeben Fehlernachricht             *
//  Felder &1 enthält nicht darstellbaren Zeichen und *
//  kann daher nicht mit dem Texteditor bearbeitet    *
//  werden.                                           *
//====================================================*

begsr USR8193;

  pgmMsgID  = 'USR8193';
  pgmMsgDta = yFldName;
  p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName);

endsr;

//====================================================*
//  MSG8221    - Ausgeben Fehlernachricht             *
//  Editor nicht zulässig. Feld &1 hat ungültigen     *
//  Datentyp.                                         *
//====================================================*

begsr MSG8221;

  pgmMsgID  = 'USR8221';
  pgmMsgDta = yFldName;
  p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName);

endsr;

//====================================================*
//  Ab hier folgen die Unterroutinen für die          *
//  Prüfung auf ungültige Feldinhalte                 *
//====================================================*
//@CHKC

//====================================================*
//  Ab hier folgen die Unterroutinen für das          *
//  Setzen/Löschen der NULL Indicator                 *
//====================================================*

begsr c_tgNullInd;

  xScnCsrRow = wScnCsrRow - WndTopRow;

  select;
  //@NULL
  endsl;

endsr;

//====================================================*
//  Ab hier folgen die Unterroutinen für den          *
//  Hex-Editor                                        *
//====================================================*
//@HEX

//====================================================*
//  Ab hier folgen die Unterroutinen für den          *
//  String-Editor                                     *
//====================================================*
//@TXT

//====================================================*
//  Ab hier folgen die Unterroutinen für              *
//  das Übertragen der Dateifelder in die Felder      *
//  des Bildschirms.                                  *
//  File --> Screen                                   *
//====================================================*
//@TOS

//====================================================*
//  Ab hier folgen die Unterroutinen für              *
//  das Übertragen der Bildschirmfelder in die Felder *
//  der Datei.                                        *
//  Screen --> File                                   *
//====================================================*
//@TOF

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

  if (*in95);
    rolbk;
  endif;

  dump;

  o_action = CEE_PERCOLATE;

end-proc;
