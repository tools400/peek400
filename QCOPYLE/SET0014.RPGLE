**free
//---------------------------------------------------------------
// Datenstruktur für Letzte geöffnete Datei
// SET0014   *PRVFILE
//---------------------------------------------------------------

dcl-ds set0014_t len(256) qualified template;
  //  Letzte geöffnete Datei ...
  set_prvFil char(10) inz('*NONE');
  //  ... Bibliothek
  set_prvLib char(10) inz('*NONE');
  //  ... Teildatei
  set_prvMbr char(10) inz('*NONE');
  //  Endemarkierung
  set_0014   char(1) inz(x'8B');
end-ds;

