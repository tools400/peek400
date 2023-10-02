      *---------------------------------------------------------------
      * Datenstruktur für Zeichenkonvertierung
      * SET0006   *CVTCHR
      *---------------------------------------------------------------
      *
     D SET0006         DS           256
      *  Ersetzungszeichen für nicht darstellbare Zeichen
     D  SET_CVTC                      1A   INZ('÷')
      *  Endemarkierung
     D  SET_0006                      1A   INZ(x'8B')
      *
