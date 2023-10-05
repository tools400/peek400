      *---------------------------------------------------------------
      * Datenstruktur für Zeichenkonvertierung
      * SET0006   *CVTCHR
      *---------------------------------------------------------------
      *
     D SET0006_t       DS           256    qualified template
      *  Ersetzungszeichen für nicht darstellbare Zeichen
     D  SET_CVTC                      1A   INZ('÷')
      *  Endemarkierung
     D  SET_0006                      1A   INZ(x'8B')
      *
