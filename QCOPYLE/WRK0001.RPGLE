**free
//---------------------------------------------------------------
// Datenstruktur für Benutzervoreinstellungen:  WRK0001

dcl-ds WRK0001_t qualified template;
  WRK_RcdNbr packed(10) inz(0);
  WRK_Seq    packed(5) inz(0);
  WRK_KSeq   packed(5) inz(0);
  WRK_Hidden char(1) inz(bFalse);
  Wrk_Color  char(1) inz(COLOR_green);
  WRK_MrkCol char(1) inz(bFalse);
  WRK_MaxSiz packed(5) inz(*hival);
  WRK_EdtCde char(1) inz('');
end-ds;

