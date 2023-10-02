      *---------------------------------------------------------------
      * Datenstruktur für Benutzervoreinstellungen:  WRK0001
      *
     D WRK0001         DS
     D  WRK_RcdNbr                   10P 0 INZ(*ZEROS   )
     D  WRK_Seq                       5P 0 INZ(*ZEROS   )
     D  WRK_KSeq                      5P 0 INZ(*ZEROS   )
     D  WRK_Hidden                    1A   INZ(bFalse   )
     D  WRK_Color                     1A   INZ(§Green   )
     D  WRK_MrkCol                    1A   INZ(bFalse   )
     D  WRK_MaxSiz                    5P 0 INZ(*HIVAL   )
     D  WRK_EdtCde                    1A   INZ(*BLANKS  )
      *
