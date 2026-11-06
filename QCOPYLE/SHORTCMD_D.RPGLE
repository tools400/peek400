**free

/copy QCOPYLE,D_VARDEF

dcl-ds ShortCmd_t qualified template;
  SC_Action char(10) inz(*blanks);
  SC_Cmd    like(pgmCmdDt_t) inz(*blanks);
  SC_File   like(file_t) overlay(SC_Cmd: 1);
  SC_Lib    like(lib_t) overlay(SC_Cmd: 11);
  SC_Mbr    like(mbr_t) overlay(SC_Cmd: 21);
end-ds;

