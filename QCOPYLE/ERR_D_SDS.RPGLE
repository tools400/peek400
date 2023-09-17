?     *
?     *====================================================*
?     *  Systemdatenstruktur                               *
?     *====================================================*
     D §PGMST         SDS
?     * Programmname
     D  §§PgmName                    10A                                                      RADDAT
?     * Programmfehlerstatus
     D  §§PgmStat                     5S 0                                                    RADDAT
?     * vorheriger Programmfehlerstatus
     D  §§PrevStat                    5S 0                                                    RADDAT
?     * Letzte Anweisungsnummer
     D  §§LastSeq                     8A                                                      RADDAT
?     * Letzte Unterroutine
     D  §§LastSubr                    8A                                                      RADDAT
?     * Anzahl übergebener Parameter
     D  §§NbrParm                     3S 0                                                    RADDAT
?     * Fehler-Msg
     D  §§MsgID                       7A                                                      RADDAT
?     *  Fehler-Art
     D   §§MsgPrfx                    3A   OVERLAY(§§MsgID)                                   RADDAT
?     *  Fehler-Nummer
     D   §§MsgNbr                     4A   OVERLAY(§§MsgID:4)                                 RADDAT
?     * MI-Instruktions-Nr.
     D  §§MI_Instr                    4A                                                      RADDAT
?     * Arbeitsbereich für Nachrichten
     D  §§WorkArea                   30A                                                      RADDAT
?     * Programmbiblitohek                                                                    RADDAT
     D  §§PgmLib                     10A                                                      RADDAT
?     * CPF-Fehlertext
     D  §§MsgText                    80A                                                      RADDAT
?     * Kz der Ausnahmebedingung
     D  §§AUBE                        4A
?     * unbenutzt
     D  §§Unused_1                   16A                                                      RADDAT
?     * Datumsformat
     D  §§DatFmt                      8A                                                      RADDAT
?     * Ersten 2 stellen von *YEAR
     D  §§Year                        2S 0                                                    RADDAT
?     * Letzte Dateioperation: Dateiname
     D  §§FileOpr                     8A                                                      RADDAT
?     * Datei-Staus-Information
     D  §§FileStat                   35A                                                      RADDAT
?     * Jobname
     D  §§Job                        10A                                                      RADDAT
?     * Benutzer
     D  §§User                       10A                                                      RADDAT
?     * Jobnummer
     D  §§JobNbr                      6S 0                                                    RADDAT
?     * Jobdatum, Aufbau wie UDATE
     D  §§JobD                        6S 0                                                    RADDAT
?     * Programm-Ausführungsdatum, Aufbau wie UDATE
     D  §§JobDate                     6S 0                                                    RADDAT
?     * Job-Zeit (HHMMSS)
     D  §§JobTime                     6S 0                                                    RADDAT
?     * Umwandlungsdatum
     D  §§CrtDate                     6A                                                      RADDAT
?     * Umwandlungszeit (HHMMSS)
     D  §§CrtTime                     6A                                                      RADDAT
?     * Compiler Version
     D  §§CompVer                     4A                                                      RADDAT
?     * Quellendatei
     D  §§SrcFile                    10A                                                      RADDAT
?     * Bibliothek mit Quellendatei
     D  §§SrcLib                     10A                                                      RADDAT
?     * Quellenteildatei
     D  §§SrcMbr                     10A                                                      RADDAT
?     * Program containing procedure
     D  §§PgmProc                    10A                                                      RADDAT
?     * Module containing procedure
     D  §§ModProc                    10A                                                      RADDAT
?     * unbenutzt
     D  §§Unused_2                   76A                                                      RADDAT
?     *
