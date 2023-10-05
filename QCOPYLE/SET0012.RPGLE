      *---------------------------------------------------------------
      * Datenstruktur für Generieren Programme
      * SET0012   *CRTPGM
      *---------------------------------------------------------------
      *
     D SET0012_t       DS           256    qualified template
      *  Kleinbuchstaben erlaubt: 1=Ja; 0=Nein
     D  SET_ALWLC                     1A   INZ('1')
      *  Standardmäßig Klienbuchstaben: 1=Ja; 0=Nein
     D  SET_CASE                      1A   INZ('0')
      *  Standardmäßig Satzsperre: 1=Ja; 0=Nein
     D  SET_RCD_LOCK                  1A   INZ('1')
      *  Initialisieren NULL-Felder: 1=Ja; 0=Nein
     D  SET_NULL_DFT                  1A   INZ('1')
      *  Cursor Position merken: 1=Ja; 0=Nein
     D  SET_KEEP_CRS                  1A   INZ('0')
      *  Endemarkierung
     D  SET_0012                      1A   INZ(x'8B')
      *
