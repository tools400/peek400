      *---------------------------------------------------------------
      * Datenstruktur für FloatKeys
      * SET0009   *FLOATKEYS
      *---------------------------------------------------------------
      *
     D SET0009         DS           256
      *  Schlüsselfelder an den Anfang sortieren
     D  SET_FLOAT                     1A   INZ(bTrue)
      *  Endemarkierung
     D  SET_0009                      1A   INZ(x'8B')
      *
