?     *---------------------------------------------------------------
?     * Datenstruktur für Aufbereiten Aufsetzschlüssel
?     * SET0003   *ACCESSKEY
?     *---------------------------------------------------------------
?     *
     D SET0003         DS           256
?     *  Minuszeichen
     D  SET_SignM                     1A   INZ('-')
?     *  Pluszeichen
     D  SET_SignP                     1A   INZ('+')
?     *  Dezimalpunkt
     D  SET_Point                     1A   INZ(',')
?     *  Vorzeichen anzeigen: 1=Ja; 0=Nein
     D  SET_SignX                     1A   INZ(bTrue)
?     *  Trennzeichen zwischen den Feldern
     D  SET_Dlmtr                     1A   INZ(';')
?     *  Endemarkierung
     D  SET_0003                      1A   INZ(x'8B')
?     *
