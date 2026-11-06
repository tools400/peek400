**free

//============================================================*
//      Modul: Peek051
//============================================================*

dcl-pr sql_preparestatement like(bool_t) extproc('SQL_prepareStatement');
  i_check     like(bool_t) value;
  i_file      like(file_t) value;
  i_lib       like(lib_t) value;
  i_mbr       like(mbr_t) value;
  i_format    like(rcdfmt_t) value;
  i_sqlselect like(sqlSelect_t) value;
  i_sqlorder  like(sqlWhere_t) value;
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*

dcl-pr sql_open like(bool_t) extproc('SQL_open');
  o_hfile  likeds(hfile_t);
  o_msgid  like(msgid_t);
  o_msgdta like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_nextrow like(bool_t) extproc('SQL_nextRow');
  o_buffer  like(rcdbuf_t);
  o_nullmap like(nullmap_t) dim(NULL_MAP_SIZE);
  o_hfile   likeds(hfile_t);
  o_msgid   like(msgid_t);
  o_msgdta  like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_previousrow like(bool_t) extproc('SQL_previousRow');
  o_buffer  like(rcdbuf_t);
  o_nullmap like(nullmap_t) dim(NULL_MAP_SIZE);
  o_hfile   likeds(hfile_t);
  o_msgid   like(msgid_t);
  o_msgdta  like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_gototop like(bool_t) extproc('SQL_gotoTop');
  o_msgid  like(msgid_t);
  o_msgdta like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_gotobottom like(bool_t) extproc('SQL_gotoBottom');
  o_msgid  like(msgid_t);
  o_msgdta like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_close like(bool_t) extproc('SQL_close');
  o_hfile  likeds(hfile_t);
  o_msgid  like(msgid_t);
  o_msgdta like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_quote like(varString_t) extproc('SQL_quote');
  i_string like(varString_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_count like(int4_t) extproc('SQL_count');
end-pr;
//-------------------------------------------------------------------*
