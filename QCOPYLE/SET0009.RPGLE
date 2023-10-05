      *---------------------------------------------------------------
      * Datenstruktur für FloatKeys
      * SET0009   *FLOATKEYS
      *---------------------------------------------------------------
      *
     D SET0009_t       DS           256    qualified template
      *  Schlüsselfelder an den Anfang sortieren
     D  SET_FLOAT                     1A   INZ(bTrue)
      *  Endemarkierung
     D  SET_0009                      1A   INZ(x'8B')
      *
