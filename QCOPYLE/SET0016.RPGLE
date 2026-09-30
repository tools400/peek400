**FREE
//---------------------------------------------------------------
// Datenstruktur für SQL: Limit zum Anzeigen der Anzahl Datensätze
// SET0016   *SQLLMTCNT
//---------------------------------------------------------------
//
dcl-ds set0016_t len(256) qualified template;
  //  Maximale Anzahl Sätze, bis zu der ein COUNT(*)
  //  zur Ermittlung der Anzahl selektierter Datensätze
  //  abgesetzt wird.
  set_maxrcds     zoned(10) inz(0005000000);
  set_0016        char(1) inz(x'8B');
end-ds;
//
