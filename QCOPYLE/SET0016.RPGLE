      *---------------------------------------------------------------
      * Datenstruktur für SQL: Limit zum Anzeigen der Anzahl Datensätze
      * SET0016   *SQLLMTCNT
      *---------------------------------------------------------------
      *
     D SET0016         DS           256
      *  Maximale Anzahl Sätze, bis zu der ein COUNT(*)
      *  zur Ermittlung der Anzahl selektierter Datensätze
      *  abgesetzt wird.
     D  SET_MAXRCDS                  10S 0 INZ(0005000000)
     D  SET_0016                      1A   INZ(x'8B')
      *
