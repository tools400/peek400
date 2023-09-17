?     *---------------------------------------------------------------
?     * Datenstruktur für Sicherheitsattribute
?     * SET0013   *SECATRDFT
?     *---------------------------------------------------------------
?     *
     D SET0013         DS           256
?     *  Ändern Bibliothek erlaubt: 1=Ja; 0=Nein
     D  SET_CHGLIB                    1A   INZ('1')
?     *  Ändern Datei erlaubt: 1=Ja; 0=Nein
     D  SET_CHGFIL                    1A   INZ('1')
?     *  Ändern Teildatei erlaubt: 1=Ja; 0=Nein
     D  SET_CHGMBR                    1A   INZ('1')
?     *  Änderungsmodus: 1=Ja; 0=Nein
     D  SET_UPDMOD                    1A   INZ('1')
?     *  Allg. Zugriffsberechtigung: 1=Ja; 0=Nein
     D  SET_ACCAUT                    1A   INZ('1')
?     *  Ändern Schlüsselfelder                                                               RADDAT
     D  SET_UPDKEY                    1A   INZ('1')                                           RADDAT
?     *  Endemarkierung
     D  SET_0013                      1A   INZ(x'8B')
?     *
