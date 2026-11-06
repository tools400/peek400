**free
//---------------------------------------------------------------
// Datenstruktur für: Benutzervoreinstellungen
// SET0001   *DSPATR
//---------------------------------------------------------------

dcl-ds set0001_t len(256) qualified template;
  //  Bildschirmauflösung: 0=132; 1=80Zeichen
  set_dsp80    char(1) inz('0');
  //  Farbe: Standarddarstellung
  set_stdcol   char(1) inz(color_green);
  //  Farbe: markierte Spalten
  set_clmcol   char(1) inz(color_turkis_r);
  //  Farbe: gepinnte Zeilen/Spalten
  set_pincol   char(1) inz(color_white_r);
  //  Farbe: Überschriftszeile
  set_hedcol   char(1) inz(color_yellow_r);
  //  Farbe: Gefunden (normal)
  set_nmlcol   char(1) inz(color_white);
  //  Farbe: Gefunden (unterstrichen)
  set_undcol   char(1) inz(color_green_u);
  //  Farbe: Gefunden (invers)
  set_revcol   char(1) inz(color_green_r);
  //  Art der Überschriftszeile: *FIELDNAME, *FIELDTEXT, *COLHDG oder
  //  *FIELDTYPE
  set_hedtyp   char(10) inz('*FIELDNAME');
  //  Farbe: Tabellierpapier
  set_tblcol   char(1) inz(color_blue);
  //  Tabellierpapier: 1=Ja; 0=Nein
  set_tblmde   char(1) inz(bfalse);
  //  Ersetzen Editcode durch Editcodes mit Vorzeichen:
  //     '0' = Keine Umsetzung des Edit Codes
  //     '1' = Mappen Edit Code auf Edit Code mit Vorzeichen
  //     '2' = Mappen Edit Code auf Edit Code mit Vorzeichen, ohne Nullenterdrückung
  //           Felder ohne Edit Code werden auf SET_editCode gesetzt.
  set_dspsgn   char(1) inz('2');
  //  Farbe: Schlüsselfelder
  set_keycol   char(1) inz(color_white_r);
  //  Darstellungsmodus: *DSPNRM=Normale Darst.; *DSPHEX=Hexadez. Darst.
  set_dspmde   char(10) inz('*DSPNRM');
  //  Anzeigen Ausnamebedingung
  set_enexc    char(1) inz(btrue);
  //  Farbe: Ausnahmebedingung
  set_exccol   char(1) inz(color_pink_r);
  //  Edit Code, wenn SET_DspSgn = '2'
  set_editcode char(1) inz('L');
  //  Endemarkierung
  set_0001     char(1) inz(x'8B');
end-ds;

