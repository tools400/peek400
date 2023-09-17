?     *---------------------------------------------------------------
?     * Datenstruktur für Hilfe-Prompt
?     * SET0008   *PROMPT
?     *---------------------------------------------------------------
?     *
     D SET0008         DS           256
?     *  Zeichen für Promptfunktion
     D  SET_PRMT                      1A   INZ('?')
?     *  F4-Felder farbig markieren
     D  SET_DSPPMT                    1A   INZ(bTrue)
?     *  Endemarkierung
     D  SET_0008                      1A   INZ(x'8B')
?     *
