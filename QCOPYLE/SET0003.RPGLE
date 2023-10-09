**FREE
//---------------------------------------------------------------
// Datenstruktur für Aufbereiten Aufsetzschlüssel
// SET0003   *ACCESSKEY
//---------------------------------------------------------------
//
dcl-ds set0003_t len(256) qualified template;
  //  Minuszeichen
  set_signm       char(1) inz('-');
  //  Pluszeichen
  set_signp       char(1) inz('+');
  //  Dezimalpunkt
  set_point       char(1) inz(',');
  //  Vorzeichen anzeigen: 1=Ja; 0=Nein
  set_signx       char(1) inz(btrue);
  //  Trennzeichen zwischen den Feldern
  set_dlmtr       char(1) inz(';');
  //  Endemarkierung
  set_0003        char(1) inz(x'8B');
end-ds;
//
