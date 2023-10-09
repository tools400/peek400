**FREE
//---------------------------------------------------------------
// Datenstruktur für FloatKeys
// SET0009   *FLOATKEYS
//---------------------------------------------------------------
//
dcl-ds set0009_t len(256) qualified template;
  //  Schlüsselfelder an den Anfang sortieren
  set_float       char(1) inz(btrue);
  //  Endemarkierung
  set_0009        char(1) inz(x'8B');
end-ds;
//
