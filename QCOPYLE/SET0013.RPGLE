**free
//---------------------------------------------------------------
// Datenstruktur für Sicherheitsattribute
// SET0013   *SECATRDFT
//---------------------------------------------------------------

dcl-ds set0013_t len(256) qualified template;
  //  Ändern Bibliothek erlaubt: 1=Ja; 0=Nein
  SET_ChgLib char(1) inz('1');
  //  Ändern Datei erlaubt: 1=Ja; 0=Nein
  SET_ChgFil char(1) inz('1');
  //  Ändern Teildatei erlaubt: 1=Ja; 0=Nein
  SET_ChgMbr char(1) inz('1');
  //  Änderungsmodus: 1=Ja; 0=Nein
  SET_UpdMod char(1) inz('1');
  //  Allg. Zugriffsberechtigung: 1=Ja; 0=Nein
  SET_AccAut char(1) inz('1');
  //  Ändern Schlüsselfelder
  set_updkey char(1) inz('1');
  //  Endemarkierung
  set_0013   char(1) inz(x'8B');
end-ds;

