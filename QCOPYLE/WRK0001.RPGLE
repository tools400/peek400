      *---------------------------------------------------------------
      * Datenstruktur für Benutzervoreinstellungen:  WRK0001
      *
     D WRK0001_t       DS                  qualified template
     D  WRK_RcdNbr                   10P 0 inz(0)
     D  WRK_Seq                       5P 0 inz(0)
     D  WRK_KSeq                      5P 0 inz(0)
     D  WRK_Hidden                    1A   inz(bFalse)
     D  WRK_Color                     1A   inz(§Green)
     D  WRK_MrkCol                    1A   inz(bFalse)
     D  WRK_MaxSiz                    5P 0 inz(*HIVAL)
     D  WRK_EdtCde                    1A   inz('')
      *
