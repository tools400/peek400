**free
//---------------------------------------------------------------
// Datenstruktur für Hilfe-Prompt
// SET0008   *PROMPT
//---------------------------------------------------------------

dcl-ds set0008_t len(256) qualified template;
  //  Zeichen für Promptfunktion
  set_prmt   char(1) inz('?');
  //  F4-Felder farbig markieren
  set_dsppmt char(1) inz(btrue);
  //  Endemarkierung
  set_0008   char(1) inz(x'8B');
end-ds;

