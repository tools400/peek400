      *---------------------------------------------------------------
      * Datenstruktur für Attribute der Suchfunktion
      * SET0002   *SEARCH
      *---------------------------------------------------------------
      *
     D SET0002_t       DS           256    qualified template
      *  Jokerzeichen
     D  SET_WldCd                     1A   INZ('%')
      *  Max. Anzahl zu durchsuchender Datensätze
     D  SET_SNbrs                     5S 0 INZ(10000)
      *  Endemarkierung
     D  SET_0002                      1A   INZ(x'8B')
      *
