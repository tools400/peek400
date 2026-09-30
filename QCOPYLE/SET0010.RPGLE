**FREE
//---------------------------------------------------------------
// Datenstruktur für Scroll Mode
// SET0010   *SCROLL
//---------------------------------------------------------------
//
dcl-ds set0010_t len(256) qualified template;
  //  Horizontaler Scrollmodus: *BOTH=beide Richtungen; *RIGHT=nur nach rhts
  //                            *LEFT=nur nach links;   *NONE =nicht scroen
  set_scroll      char(10) inz('*BOTH');
  //  Eingabe der "Feldseite": 1=Ja; 0=Nein
  set_fldpge      char(1) inz('0');
  //  Endemarkierung
  set_0010        char(1) inz(x'8B');
end-ds;
//
