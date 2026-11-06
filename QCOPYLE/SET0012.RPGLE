**free
//---------------------------------------------------------------
// Datenstruktur für Generieren Programme
// SET0012   *CRTPGM
//---------------------------------------------------------------

dcl-ds set0012_t len(256) qualified template;
  //  Kleinbuchstaben erlaubt: 1=Ja; 0=Nein
  set_alwlc    char(1) inz('1');
  //  Standardmäßig Klienbuchstaben: 1=Ja; 0=Nein
  set_case     char(1) inz('0');
  //  Standardmäßig Satzsperre: 1=Ja; 0=Nein
  set_rcd_lock char(1) inz('1');
  //  Initialisieren NULL-Felder: 1=Ja; 0=Nein
  set_null_dft char(1) inz('1');
  //  Cursor Position merken: 1=Ja; 0=Nein
  set_keep_crs char(1) inz('0');
  //  Endemarkierung
  set_0012     char(1) inz(x'8B');
end-ds;

