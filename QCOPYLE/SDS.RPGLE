**FREE
//
//====================================================*
//  Program Status Data Structure                     *
//====================================================*
dcl-ds sds qualified psds;
  // Programmname
  pgmName         char(10);
  // Programmfehlerstatus
  pgmStat         zoned(5);
  // vorheriger Programmfehlerstatus
  prevStat        zoned(5);
  // Letzte Anweisungsnummer
  lastSeq         char(8);
  // Letzte Unterroutine
  lastSubr        char(8);
  // Anzahl übergebener Parameter
  nbrParm         zoned(3);
  // Fehler-Msg
  msgID           char(7);
  //  Fehler-Art
  msgPrfx         char(3) overlay(msgid);
  //  Fehler-Nummer
  msgNbr          char(4) overlay(msgid:4);
  // MI-Instruktions-Nr.
  mi_instr        char(4);
  // Arbeitsbereich für Nachrichten
  workArea        char(30);
  // Programmbiblitohek
  pgmLib          char(10);
  // CPF-Fehlertext
  msgText         char(80);
  // Kz der Ausnahmebedingung
  aube            char(4);
  // unbenutzt
  unused_1        char(16);
  // Datumsformat
  datFmt          char(8);
  // Ersten 2 stellen von *YEAR
  year            zoned(2);
  // Letzte Dateioperation: Dateiname
  fileOpr         char(8);
  // Datei-Staus-Information
  fileStat        char(35);
  // Jobname
  job             char(10);
  // Benutzer
  user            char(10);
  // Jobnummer
  jobNbr          zoned(6);
  // Jobdatum, Aufbau wie UDATE
  jobD            zoned(6);
  // Programm-Ausführungsdatum, Aufbau wie UDATE
  jobDate         zoned(6);
  // Job-Zeit (HHMMSS)
  jobTime         zoned(6);
  // Umwandlungsdatum
  crtdate         char(6);
  // Umwandlungszeit (HHMMSS)
  crtTime         char(6);
  // Compiler Version
  compVer         char(4);
  // Quellendatei
  srcFile         char(10);
  // Bibliothek mit Quellendatei
  srcLib          char(10);
  // Quellenteildatei
  srcMbr          char(10);
  // Program containing procedure
  pgmProc         char(10);
  // Module containing procedure
  modProc         char(10);
  // unbenutzt
  unused_2        char(76);
end-ds;
//
