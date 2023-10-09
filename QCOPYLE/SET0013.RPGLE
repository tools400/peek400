**FREE
//---------------------------------------------------------------
// Datenstruktur für Sicherheitsattribute
// SET0013   *SECATRDFT
//---------------------------------------------------------------
//
dcl-ds set0013_t len(256) qualified template;
  //  Ändern Bibliothek erlaubt: 1=Ja; 0=Nein
  set_chglib      char(1) inz('1');
  //  Ändern Datei erlaubt: 1=Ja; 0=Nein
  set_chgfil      char(1) inz('1');
  //  Ändern Teildatei erlaubt: 1=Ja; 0=Nein
  set_chgmbr      char(1) inz('1');
  //  Änderungsmodus: 1=Ja; 0=Nein
  set_updmod      char(1) inz('1');
  //  Allg. Zugriffsberechtigung: 1=Ja; 0=Nein
  set_accaut      char(1) inz('1');
  //  Ändern Schlüsselfelder
  set_updkey      char(1) inz('1');
  //  Endemarkierung
  set_0013        char(1) inz(x'8B');
end-ds;
//
