      *---------------------------------------------------------------
      * Datenstruktur für Versionsnummer
      * SET0007   *VERSION
      *---------------------------------------------------------------
      *
     D SET0007         DS           256
      *  Versionsnummer ...
     D  SET_VSN                       9A   INZ('V00R00M00')
      *  ... Version
     D   SET_VSNV                     2A   OVERLAY(SET_VSN:2)
      *  ... Release
     D   SET_VSNR                     2A   OVERLAY(SET_VSN:5)
      *  ... Modifikation
     D   SET_VSNM                     2A   OVERLAY(SET_VSN:8)
      *  Endemarkierung
     D  SET_0007                      1A   INZ(x'8B')
      *
