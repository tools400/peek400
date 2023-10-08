      *---------------------------------------------------------------
      * Datenstruktur für: Benutzervoreinstellungen
      * SET0001   *DSPATR
      *---------------------------------------------------------------
      *
     D SET0001_t       DS           256    qualified template
      *  Bildschirmauflösung: 0=132; 1=80Zeichen
     D  SET_DSP80                     1A   INZ('0')
      *  Farbe: Standarddarstellung
     D  SET_StdCol                    1A   INZ(COLOR_Green)
      *  Farbe: markierte Spalten
     D  SET_ClmCol                    1A   INZ(COLOR_Turkis_R)
      *  Farbe: gepinnte Zeilen/Spalten
     D  SET_PinCol                    1A   INZ(COLOR_White_R)
      *  Farbe: Überschriftszeile
     D  SET_HedCol                    1A   INZ(COLOR_Yellow_R)
      *  Farbe: Gefunden (normal)
     D  SET_NmlCol                    1A   INZ(COLOR_White)
      *  Farbe: Gefunden (unterstrichen)
     D  SET_UndCol                    1A   INZ(COLOR_Green_U)
      *  Farbe: Gefunden (invers)
     D  SET_RevCol                    1A   INZ(COLOR_Green_R)
      *  Art der Überschriftszeile: *FILEDNAME=Feldnamen; *FIELDTEXT=Feldtext
     D  SET_HedTyp                   10A   INZ('*FIELDNAME')
      *  Farbe: Tabellierpapier
     D  SET_TblCol                    1A   INZ(COLOR_Blue)
      *  Tabellierpapier: 1=Ja; 0=Nein
     D  SET_TblMde                    1A   INZ(bFalse)
      *  Ersetzen Editcode durch Editcodes mit Vorzeichen:
      *     '0' = Keine Umsetzung des Edit Codes
      *     '1' = Mappen Edit Code auf Edit Code mit Vorzeichen
      *     '2' = Mappen Edit Code auf Edit Code mit Vorzeichen, ohne Nullenunterdrückung
      *           Felder ohne Edit Code werden auf SET_editCode gesetzt.
     D  SET_DspSgn                    1A   INZ('2')
      *  Farbe: Schlüsselfelder
     D  SET_KeyCol                    1A   INZ(COLOR_White_R)
      *  Darstellungsmodus: *DSPNRM=Normale Darst.; *DSPHEX=Hexadez. Darst.
     D  SET_DspMde                   10A   INZ('*DSPNRM')
      *  Anzeigen Ausnamebedingung
     D  SET_EnExc                     1A   INZ(bTrue)
      *  Farbe: Ausnahmebedingung
     D  SET_ExcCol                    1A   INZ(COLOR_Pink_R)
      *  Edit Code, wenn SET_DspSgn = '2'
     D  SET_editCode                  1A   INZ('L')
      *  Endemarkierung
     D  SET_0001                      1A   INZ(x'8B')
      *
