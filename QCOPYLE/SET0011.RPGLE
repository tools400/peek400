**free
//---------------------------------------------------------------
// Datenstruktur für Default Display Mode
// SET0011   *DFTDSPMDE
//---------------------------------------------------------------

dcl-ds set0011_t len(256) qualified template;
  //  Eingestellter Darstellungsmodus: *DSPNRM=Normale Darst.; *DSPHEX=Hedez. Darst.
  set_dftMde char(10) inz('*DSPNRM');
  //  Endemarkierung
  set_0011   char(1) inz(x'8B');
end-ds;

