      *---------------------------------------------------------------
      * Datenstruktur für Default Display Mode
      * SET0011   *DFTDSPMDE
      *---------------------------------------------------------------
      *
     D SET0011_t       DS           256    qualified template
      *  Eingestellter Darstellungsmodus: *DSPNRM=Normale Darst.; *DSPHEX=Hexadez. Darst.
     D  SET_DFTMDE                   10A   INZ('*DSPNRM')
      *  Endemarkierung
     D  SET_0011                      1A   INZ(x'8B')
      *
