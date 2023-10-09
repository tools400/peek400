**FREE
//---------------------------------------------------------------
// Datenstruktur für Attribute der Suchfunktion
// SET0002   *SEARCH
//---------------------------------------------------------------
//
dcl-ds set0002_t len(256) qualified template;
  //  Jokerzeichen
  set_wldcd       char(1) inz('%');
  //  Max. Anzahl zu durchsuchender Datensätze
  set_snbrs       zoned(5) inz(10000);
  //  Endemarkierung
  set_0002        char(1) inz(x'8B');
end-ds;
//
