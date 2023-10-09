**FREE

//============================================================*
//      Modul: Peek051
//============================================================*

dcl-pr sql_preparestatement
       like(bool_t)
       extproc('SQL_prepareStatement');
  i_check         value  like(bool_t);
  i_file          value  like(file_t);
  i_lib           value  like(lib_t);
  i_mbr           value  like(mbr_t);
  i_format        value  like(rcdfmt_t);
  i_sqlselect     char(512) value;
  i_sqlorder      char(512) value;
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*

dcl-pr sql_open
       like(bool_t)
       extproc('SQL_open');
  o_hfile         likeds(hfile_t);
o_msgid         like(msgid_t);
o_msgdta        like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_nextrow
       like(bool_t)
       extproc('SQL_nextRow');
  o_buffer        like(rcdbuf_t);
  o_nullmap       like(nullmap_t)
       dim(null_map_size);
  o_hfile         likeds(hfile_t);
o_msgid         like(msgid_t);
o_msgdta        like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_previousrow
       like(bool_t)
       extproc('SQL_previousRow');
  o_buffer        like(rcdbuf_t);
  o_nullmap       like(nullmap_t)
       dim(null_map_size);
  o_hfile         likeds(hfile_t);
o_msgid         like(msgid_t);
o_msgdta        like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_gototop
       like(bool_t)
       extproc('SQL_gotoTop');
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_gotobottom
       like(bool_t)
       extproc('SQL_gotoBottom');
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_close
       like(bool_t)
       extproc('SQL_close');
  o_hfile         likeds(hfile_t);
o_msgid         like(msgid_t);
o_msgdta        like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_quote
       char(512)
       extproc('SQL_quote');
  i_string        char(512) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_count
       int(10)
       extproc('SQL_count');
end-pr;
//-------------------------------------------------------------------*
