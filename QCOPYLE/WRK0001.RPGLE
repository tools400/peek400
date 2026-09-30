**FREE
//---------------------------------------------------------------
// Datenstruktur für Benutzervoreinstellungen:  WRK0001
//
dcl-ds wrk0001_t qualified template;
  wrk_rcdnbr      packed(10) inz(0);
  wrk_seq         packed(5) inz(0);
  wrk_kseq        packed(5) inz(0);
  wrk_hidden      char(1) inz(bfalse);
  wrk_color       char(1) inz(color_green);
  wrk_mrkcol      char(1) inz(bfalse);
  wrk_maxsiz      packed(5) inz(*hival);
  wrk_edtcde      char(1) inz('');
end-ds;
//
