      *---------------------------------------------------------------
      * Datenstruktur für Speichern der Arbeitsumgebung
      * SET0015   *ENVFILE
      *---------------------------------------------------------------
      *
     D SET0015_t       DS           256    qualified template
      *  Datei mit Arbeitsumgebungen ...
     D  SET_ENVFIL                   10A   INZ('PEEKENV')
      *  ... Bibliothek
     D  SET_ENVLIB                   10A   INZ('*PRDLIB')
      *  Ändern Datei erlaubt: 1=Ja; 0=Nein
     D  SET_ENVCHG                    1A   INZ('1')
      *  Funktion aktiv: 1=Ja; 0=Nein
     D  SET_ENVENA                    1A   INZ('1')
      *  Endemarkierung
     D  SET_0015                      1A   INZ(x'8B')
      *
