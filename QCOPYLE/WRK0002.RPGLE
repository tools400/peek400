?     *---------------------------------------------------------------
?     * Datenstruktur für Benutzervoreinstellungen:  WRK0002                                  RADDAT
?     *
     D WRK0002         DS                                                                     RADDAT
     D  WRK_RcdNbr                   10P 0 INZ(*ZEROS   )                                     RADDAT
     D  WRK_Seq                       5P 0 INZ(*ZEROS   )                                     RADDAT
     D  WRK_FNme                     10A   INZ(*BLANKS  )                                     RADDAT
     D  WRK_FTxt                     50A   INZ(*BLANKS  )                                     RADDAT
?     *                                                                                       RADDAT
