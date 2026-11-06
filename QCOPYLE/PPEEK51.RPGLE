**free

//============================================================*
//      Modul: Peek051
//============================================================*

dcl-pr sql_prepareStatement like(bool_t) extproc('SQL_prepareStatement');
  i_check     like(bool_t) value;
  i_file      like(file_t) value;
  i_lib       like(lib_t) value;
  i_mbr       like(mbr_t) value;
  i_format    like(rcdFmt_t) value;
  i_sqlSelect like(sqlSelect_t) value;
  i_sqlOrder  like(sqlWhere_t) value;
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pr;

//-------------------------------------------------------------------*

dcl-pr sql_open like(bool_t) extproc('SQL_open');
  o_hFile  likeds(hFile_t);
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_nextRow like(bool_t) extproc('SQL_nextRow');
  o_buffer  like(rcdBuf_t);
  o_nullMap like(nullMap_t) dim(NULL_MAP_SIZE);
  o_hFile   likeds(hFile_t);
  o_msgID   like(msgId_t);
  o_msgDta  like(msgDta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_previousRow like(bool_t) extproc('SQL_previousRow');
  o_buffer  like(rcdBuf_t);
  o_nullMap like(nullMap_t) dim(NULL_MAP_SIZE);
  o_hFile   likeds(hFile_t);
  o_msgID   like(msgId_t);
  o_msgDta  like(msgDta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_gotoTop like(bool_t) extproc('SQL_gotoTop');
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_gotoBottom like(bool_t) extproc('SQL_gotoBottom');
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_close like(bool_t) extproc('SQL_close');
  o_hFile  likeds(hFile_t);
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_quote like(varString_t) extproc('SQL_quote');
  i_string like(varString_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr sql_count like(int4_t) extproc('SQL_count');
end-pr;
//-------------------------------------------------------------------*
