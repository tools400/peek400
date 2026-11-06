**free

//====================================================*
//  Program Status Data Structure                     *
//====================================================*
dcl-ds sds qualified psds;
  // Programmname
  pgmName  char(10);
  // Programmfehlerstatus
  PgmStat  zoned(5);
  // vorheriger Programmfehlerstatus
  PrevStat zoned(5);
  // Letzte Anweisungsnummer
  LastSeq  char(8);
  // Letzte Unterroutine
  LastSubr char(8);
  // Anzahl übergebener Parameter
  NbrParm  zoned(3);
  // Fehler-Msg
  msgID    char(7);
  //  Fehler-Art
  MsgPrfx  char(3) overlay(msgID);
  //  Fehler-Nummer
  msgNbr   char(4) overlay(msgID: 4);
  // MI-Instruktions-Nr.
  MI_Instr char(4);
  // Arbeitsbereich für Nachrichten
  WorkArea char(30);
  // Programmbiblitohek
  PgmLib   char(10);
  // CPF-Fehlertext
  msgText  char(80);
  // Kz der Ausnahmebedingung
  aube     char(4);
  // unbenutzt
  Unused_1 char(16);
  // Datumsformat
  datFmt   char(8);
  // Ersten 2 stellen von *YEAR
  year     zoned(2);
  // Letzte Dateioperation: Dateiname
  FileOpr  char(8);
  // Datei-Staus-Information
  FileStat char(35);
  // Jobname
  job      char(10);
  // Benutzer
  user     char(10);
  // Jobnummer
  JobNbr   zoned(6);
  // Jobdatum, Aufbau wie UDATE
  JobD     zoned(6);
  // Programm-Ausführungsdatum, Aufbau wie UDATE
  jobDate  zoned(6);
  // Job-Zeit (HHMMSS)
  JobTime  zoned(6);
  // Umwandlungsdatum
  CrtDate  char(6);
  // Umwandlungszeit (HHMMSS)
  CrtTime  char(6);
  // Compiler Version
  CompVer  char(4);
  // Quellendatei
  srcFile  char(10);
  // Bibliothek mit Quellendatei
  srcLib   char(10);
  // Quellenteildatei
  srcMbr   char(10);
  // Program containing procedure
  PgmProc  char(10);
  // Module containing procedure
  ModProc  char(10);
  // unbenutzt
  Unused_2 char(76);
end-ds;

