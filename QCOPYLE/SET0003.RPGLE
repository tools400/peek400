**free
//---------------------------------------------------------------
// Datenstruktur für Aufbereiten Aufsetzschlüssel
// SET0003   *ACCESSKEY
//---------------------------------------------------------------

dcl-ds SET0003_t len(256) qualified template;
  //  Minuszeichen
  SET_SignM char(1) inz('-');
  //  Pluszeichen
  SET_SignP char(1) inz('+');
  //  Dezimalpunkt
  SET_Point char(1) inz(',');
  //  Vorzeichen anzeigen: 1=Ja; 0=Nein
  SET_SignX char(1) inz(bTrue);
  //  Trennzeichen zwischen den Feldern
  SET_Dlmtr char(1) inz(';');
  //  Endemarkierung
  set_0003  char(1) inz(x'8B');
end-ds;

