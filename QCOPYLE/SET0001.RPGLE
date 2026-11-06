**free
//---------------------------------------------------------------
// Datenstruktur für: Benutzervoreinstellungen
// SET0001   *DSPATR
//---------------------------------------------------------------

dcl-ds SET0001_t len(256) qualified template;
  //  Bildschirmauflösung: 0=132; 1=80Zeichen
  SET_Dsp80    char(1) inz('0');
  //  Farbe: Standarddarstellung
  SET_StdCol   char(1) inz(COLOR_green);
  //  Farbe: markierte Spalten
  SET_ClmCol   char(1) inz(COLOR_turkis_r);
  //  Farbe: gepinnte Zeilen/Spalten
  SET_PinCol   char(1) inz(COLOR_White_R);
  //  Farbe: Überschriftszeile
  SET_HedCol   char(1) inz(COLOR_yellow_r);
  //  Farbe: Gefunden (normal)
  SET_NmlCol   char(1) inz(COLOR_white);
  //  Farbe: Gefunden (unterstrichen)
  SET_UndCol   char(1) inz(COLOR_green_u);
  //  Farbe: Gefunden (invers)
  SET_RevCol   char(1) inz(COLOR_green_r);
  //  Art der Überschriftszeile: *FIELDNAME, *FIELDTEXT, *COLHDG oder
  //  *FIELDTYPE
  SET_HedTyp   char(10) inz('*FIELDNAME');
  //  Farbe: Tabellierpapier
  SET_TblCol   char(1) inz(COLOR_blue);
  //  Tabellierpapier: 1=Ja; 0=Nein
  SET_TblMde   char(1) inz(bFalse);
  //  Ersetzen Editcode durch Editcodes mit Vorzeichen:
  //     '0' = Keine Umsetzung des Edit Codes
  //     '1' = Mappen Edit Code auf Edit Code mit Vorzeichen
  //     '2' = Mappen Edit Code auf Edit Code mit Vorzeichen, ohne Nullenterdrückung
  //           Felder ohne Edit Code werden auf SET_editCode gesetzt.
  SET_DspSgn   char(1) inz('2');
  //  Farbe: Schlüsselfelder
  SET_KeyCol   char(1) inz(COLOR_White_R);
  //  Darstellungsmodus: *DSPNRM=Normale Darst.; *DSPHEX=Hexadez. Darst.
  SET_DspMde   char(10) inz('*DSPNRM');
  //  Anzeigen Ausnamebedingung
  SET_EnExc    char(1) inz(bTrue);
  //  Farbe: Ausnahmebedingung
  SET_ExcCol   char(1) inz(COLOR_pink_r);
  //  Edit Code, wenn SET_DspSgn = '2'
  SET_editCode char(1) inz('L');
  //  Endemarkierung
  set_0001     char(1) inz(x'8B');
end-ds;

