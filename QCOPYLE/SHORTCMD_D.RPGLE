**FREE
//
/COPY QCOPYLE,D_VARDEF
//
dcl-ds shortcmd_t qualified template;
  sc_action       char(10) inz(*blanks);
  sc_cmd          like(pgmcmddt_t) inz(*blanks);
  sc_file         like(file_t) overlay(sc_cmd: 1);
  sc_lib          like(lib_t) overlay(sc_cmd:11);
  sc_mbr          like(mbr_t) overlay(sc_cmd:21);
end-ds;
//
