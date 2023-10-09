**FREE
//---------------------------------------------------------------
// Datenstruktur für Benutzervoreinstellungen:  WRK0002
//
dcl-ds wrk0002_t qualified template;
  wrk_rcdnbr      packed(10) inz(0);
  wrk_seq         packed(5) inz(0);
  wrk_fnme        char(10) inz('');
  wrk_ftxt        char(50) inz('');
end-ds;
//
