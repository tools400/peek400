      *
      *====================================================*
      *  Program Status Data Structure                     *
      *====================================================*
     D §PGMST         SDS
      * Programmname
     D  §§PgmName                    10A
      * Programmfehlerstatus
     D  §§PgmStat                     5S 0
      * vorheriger Programmfehlerstatus
     D  §§PrevStat                    5S 0
      * Letzte Anweisungsnummer
     D  §§LastSeq                     8A
      * Letzte Unterroutine
     D  §§LastSubr                    8A
      * Anzahl übergebener Parameter
     D  §§NbrParm                     3S 0
      * Fehler-Msg
     D  §§MsgID                       7A
      *  Fehler-Art
     D   §§MsgPrfx                    3A   OVERLAY(§§MsgID)
      *  Fehler-Nummer
     D   §§MsgNbr                     4A   OVERLAY(§§MsgID:4)
      * MI-Instruktions-Nr.
     D  §§MI_Instr                    4A
      * Arbeitsbereich für Nachrichten
     D  §§WorkArea                   30A
      * Programmbiblitohek
     D  §§PgmLib                     10A
      * CPF-Fehlertext
     D  §§MsgText                    80A
      * Kz der Ausnahmebedingung
     D  §§AUBE                        4A
      * unbenutzt
     D  §§Unused_1                   16A
      * Datumsformat
     D  §§DatFmt                      8A
      * Ersten 2 stellen von *YEAR
     D  §§Year                        2S 0
      * Letzte Dateioperation: Dateiname
     D  §§FileOpr                     8A
      * Datei-Staus-Information
     D  §§FileStat                   35A
      * Jobname
     D  §§Job                        10A
      * Benutzer
     D  §§User                       10A
      * Jobnummer
     D  §§JobNbr                      6S 0
      * Jobdatum, Aufbau wie UDATE
     D  §§JobD                        6S 0
      * Programm-Ausführungsdatum, Aufbau wie UDATE
     D  §§JobDate                     6S 0
      * Job-Zeit (HHMMSS)
     D  §§JobTime                     6S 0
      * Umwandlungsdatum
     D  §§CrtDate                     6A
      * Umwandlungszeit (HHMMSS)
     D  §§CrtTime                     6A
      * Compiler Version
     D  §§CompVer                     4A
      * Quellendatei
     D  §§SrcFile                    10A
      * Bibliothek mit Quellendatei
     D  §§SrcLib                     10A
      * Quellenteildatei
     D  §§SrcMbr                     10A
      * Program containing procedure
     D  §§PgmProc                    10A
      * Module containing procedure
     D  §§ModProc                    10A
      * unbenutzt
     D  §§Unused_2                   76A
      *
