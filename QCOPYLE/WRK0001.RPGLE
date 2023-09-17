?     *---------------------------------------------------------------
?     * Datenstruktur für Benutzervoreinstellungen:  WRK0001                                  RADDAT
?     *
     D WRK0001         DS                                                                     RADDAT
     D  WRK_RcdNbr                   10P 0 INZ(*ZEROS   )                                     RADDAT
     D  WRK_Seq                       5P 0 INZ(*ZEROS   )                                     RADDAT
     D  WRK_KSeq                      5P 0 INZ(*ZEROS   )                                     RADDAT
     D  WRK_Hidden                    1A   INZ(bFalse   )                                     RADDAT
     D  WRK_Color                     1A   INZ(§Green   )                                     RADDAT
     D  WRK_MrkCol                    1A   INZ(bFalse   )                                     RADDAT
     D  WRK_MaxSiz                    5P 0 INZ(*HIVAL   )                                     RADDAT
     D  WRK_EdtCde                    1A   INZ(*BLANKS  )                                     RADDAT
?     *                                                                                       RADDAT
