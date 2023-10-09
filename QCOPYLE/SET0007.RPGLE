**FREE
//---------------------------------------------------------------
// Datenstruktur für Versionsnummer
// SET0007   *VERSION
//---------------------------------------------------------------
//
dcl-ds set0007_t len(256) qualified template;
  //  Versionsnummer ...
  set_vsn         char(9) inz('V00R00M00');
  //  ... Version
  set_vsnv        char(2) overlay(set_vsn:2);
  //  ... Release
  set_vsnr        char(2) overlay(set_vsn:5);
  //  ... Modifikation
  set_vsnm        char(2) overlay(set_vsn:8);
  //  Endemarkierung
  set_0007        char(1) inz(x'8B');
end-ds;
//
