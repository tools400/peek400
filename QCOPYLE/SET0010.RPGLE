?     *---------------------------------------------------------------
?     * Datenstruktur für Scroll Mode
?     * SET0010   *SCROLL
?     *---------------------------------------------------------------
?     *
     D SET0010         DS           256
?     *  Horizontaler Scrollmodus: *BOTH=beide Richtungen; *RIGHT=nur nach rechts
?     *                            *LEFT=nur nach links;   *NONE =nicht scrollen
     D  SET_SCROLL                   10A   INZ('*BOTH')
?     *  Eingabe der "Feldseite": 1=Ja; 0=Nein
     D  SET_FLDPGE                    1A   INZ('0')
?     *  Endemarkierung
     D  SET_0010                      1A   INZ(x'8B')
?     *
