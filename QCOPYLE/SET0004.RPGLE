**free
//---------------------------------------------------------------
// Datenstruktur für Spracheneinstellungen
// SET0004   *LANGUAGE
//---------------------------------------------------------------

dcl-ds SET0004_t len(256) qualified template;
  //  Eingestellte Benutzersprache
  SET_Lang char(3) inz('GER');
  //  Endemarkierung
  set_0004 char(1) inz(x'8B');
end-ds;

