**free
//---------------------------------------------------------------
// Datenstruktur für: Benutzervoreinstellungen
// SET0001   *DSPATR
//---------------------------------------------------------------

dcl-ds set0001_t len(256) qualified template;
  //  Bildschirmauflösung: 0=132; 1=80Zeichen
  set_dsp80    char(1) inz('0');
  //  Farbe: Standarddarstellung
  set_stdCol   char(1) inz(color_green);
  //  Farbe: markierte Spalten
  set_clmCol   char(1) inz(color_turkis_r);
  //  Farbe: gepinnte Zeilen/Spalten
  set_pinCol   char(1) inz(color_white_r);
  //  Farbe: Überschriftszeile
  set_hedCol   char(1) inz(color_yellow_r);
  //  Farbe: Gefunden (normal)
  set_nmlCol   char(1) inz(color_white);
  //  Farbe: Gefunden (unterstrichen)
  set_undCol   char(1) inz(color_green_u);
  //  Farbe: Gefunden (invers)
  set_revCol   char(1) inz(color_green_r);
  //  Art der Überschriftszeile: *FIELDNAME, *FIELDTEXT, *COLHDG oder
  //  *FIELDTYPE
  set_hedTyp   char(10) inz('*FIELDNAME');
  //  Farbe: Tabellierpapier
  set_tblCol   char(1) inz(color_blue);
  //  Tabellierpapier: 1=Ja; 0=Nein
  set_tblMde   char(1) inz(bFalse);
  //  Ersetzen Editcode durch Editcodes mit Vorzeichen:
  //     '0' = Keine Umsetzung des Edit Codes
  //     '1' = Mappen Edit Code auf Edit Code mit Vorzeichen
  //     '2' = Mappen Edit Code auf Edit Code mit Vorzeichen, ohne Nullenterdrückung
  //           Felder ohne Edit Code werden auf set_editCode gesetzt.
  set_dspSgn   char(1) inz('2');
  //  Farbe: Schlüsselfelder
  set_keyCol   char(1) inz(color_white_r);
  //  Darstellungsmodus: *DSPNRM=Normale Darst.; *DSPHEX=Hexadez. Darst.
  set_dspMde   char(10) inz('*DSPNRM');
  //  Anzeigen Ausnamebedingung
  set_enExc    char(1) inz(bTrue);
  //  Farbe: Ausnahmebedingung
  set_excCol   char(1) inz(color_pink_r);
  //  Edit Code, wenn set_dspSgn = '2'
  set_editCode char(1) inz('L');
  //  Endemarkierung
  set_0001     char(1) inz(x'8B');
end-ds;

