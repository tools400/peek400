**free
//---------------------------------------------------------------
// Datenstruktur für Benutzervoreinstellungen:  WRK0001

dcl-ds wrk0001_t qualified template;
  wrk_rcdNbr packed(10) inz(0);
  wrk_seq    packed(5) inz(0);
  wrk_kSeq   packed(5) inz(0);
  wrk_hidden char(1) inz(bFalse);
  wrk_color  char(1) inz(color_green);
  wrk_mrkCol char(1) inz(bFalse);
  wrk_maxSiz packed(5) inz(*hival);
  wrk_edtCde char(1) inz('');
end-ds;

