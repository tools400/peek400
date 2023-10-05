      *---------------------------------------------------------------
      * Datenstruktur für Spracheneinstellungen
      * SET0004   *LANGUAGE
      *---------------------------------------------------------------
      *
     D SET0004_t       DS           256    qualified template
      *  Eingestellte Benutzersprache
     D  SET_Lang                      3A   INZ('GER')
      *  Endemarkierung
     D  SET_0004                      1A   INZ(x'8B')
      *
