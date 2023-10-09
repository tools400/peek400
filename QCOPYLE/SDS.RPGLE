**FREE
//
//====================================================*
//  Program Status Data Structure                     *
//====================================================*
dcl-ds sds qualified psds;
  // Programmname
  pgmname         char(10);
  // Programmfehlerstatus
  pgmstat         zoned(5);
  // vorheriger Programmfehlerstatus
  prevstat        zoned(5);
  // Letzte Anweisungsnummer
  lastseq         char(8);
  // Letzte Unterroutine
  lastsubr        char(8);
  // Anzahl übergebener Parameter
  nbrparm         zoned(3);
  // Fehler-Msg
  msgid           char(7);
  //  Fehler-Art
  msgprfx         char(3) overlay(msgid);
  //  Fehler-Nummer
  msgnbr          char(4) overlay(msgid:4);
  // MI-Instruktions-Nr.
  mi_instr        char(4);
  // Arbeitsbereich für Nachrichten
  workarea        char(30);
  // Programmbiblitohek
  pgmlib          char(10);
  // CPF-Fehlertext
  msgtext         char(80);
  // Kz der Ausnahmebedingung
  aube            char(4);
  // unbenutzt
  unused_1        char(16);
  // Datumsformat
  datfmt          char(8);
  // Ersten 2 stellen von *YEAR
  year            zoned(2);
  // Letzte Dateioperation: Dateiname
  fileopr         char(8);
  // Datei-Staus-Information
  filestat        char(35);
  // Jobname
  job             char(10);
  // Benutzer
  user            char(10);
  // Jobnummer
  jobnbr          zoned(6);
  // Jobdatum, Aufbau wie UDATE
  jobd            zoned(6);
  // Programm-Ausführungsdatum, Aufbau wie UDATE
  jobdate         zoned(6);
  // Job-Zeit (HHMMSS)
  jobtime         zoned(6);
  // Umwandlungsdatum
  crtdate         char(6);
  // Umwandlungszeit (HHMMSS)
  crttime         char(6);
  // Compiler Version
  compver         char(4);
  // Quellendatei
  srcfile         char(10);
  // Bibliothek mit Quellendatei
  srclib          char(10);
  // Quellenteildatei
  srcmbr          char(10);
  // Program containing procedure
  pgmproc         char(10);
  // Module containing procedure
  modproc         char(10);
  // unbenutzt
  unused_2        char(76);
end-ds;
//
