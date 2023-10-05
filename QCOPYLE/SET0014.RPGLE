      *---------------------------------------------------------------
      * Datenstruktur für Letzte geöffnete Datei
      * SET0014   *PRVFILE
      *---------------------------------------------------------------
      *
     D SET0014_t       DS           256    qualified template
      *  Letzte geöffnete Datei ...
     D  SET_PRVFIL                   10A   INZ('*NONE')
      *  ... Bibliothek
     D  SET_PRVLIB                   10A   INZ('*NONE')
      *  ... Teildatei
     D  SET_PRVMBR                   10A   INZ('*NONE')
      *  Endemarkierung
     D  SET_0014                      1A   INZ(x'8B')
      *
