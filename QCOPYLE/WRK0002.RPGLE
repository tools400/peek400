**free
//---------------------------------------------------------------
// Datenstruktur für Benutzervoreinstellungen:  WRK0002

dcl-ds WRK0002_t qualified template;
  WRK_RcdNbr packed(10) inz(0);
  WRK_Seq    packed(5) inz(0);
  Wrk_FNme   char(10) inz('');
  WRK_FTxt   char(50) inz('');
end-ds;

