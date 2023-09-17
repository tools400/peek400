?     *---------------------------------------------------------------
?     * Datenstruktur für Generieren Programme
?     * SET0012   *CRTPGM
?     *---------------------------------------------------------------
?     *
     D SET0012         DS           256
?     *  Kleinbuchstaben erlaubt: 1=Ja; 0=Nein
     D  SET_ALWLC                     1A   INZ('1')                                           RADDAT
?     *  Standardmäßig Klienbuchstaben: 1=Ja; 0=Nein
     D  SET_CASE                      1A   INZ('0')                                           RADDAT
?     *  Standardmäßig Satzsperre: 1=Ja; 0=Nein                                               RADDAT
     D  SET_RCD_LOCK                  1A   INZ('1')                                           RADDAT
?     *  Initialisieren NULL-Felder: 1=Ja; 0=Nein                                             RADDAT
     D  SET_NULL_DFT                  1A   INZ('1')                                           RADDAT
?     *  Cursor Position merken: 1=Ja; 0=Nein                                                 RADDAT
     D  SET_KEEP_CRS                  1A   INZ('0')                                           RADDAT
?     *  Endemarkierung
     D  SET_0012                      1A   INZ(x'8B')
?     *
