      *---------------------------------------------------------------
      * Datenstruktur für SPLASH-Screen
      * SET0005   *SPLASH
      *---------------------------------------------------------------
      *
     D SET0005         DS           256
      *  Splash-Screen anzeigen: 1=Ja; 0=Nein
     D  SET_SPLA                      1A   INZ(bTrue)
      *  Endemarkierung
     D  SET_0005                      1A   INZ(x'8B')
      *
