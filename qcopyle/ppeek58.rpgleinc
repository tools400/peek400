**free

//============================================================*
//      Modul: Peek058
//============================================================*

//  Konstants: f_wordWrap()
dcl-c cWORDWRAP_PARAGRAPH_NONE 1;
dcl-c cWORDWRAP_PARAGRAPH_MSGD 2;
dcl-c cWORDWRAP_PARAGRAPH_TEXT 4;
dcl-c cWORDWRAP_PARAGRAPH_TRIMR 8;

//-------------------------------------------------------------------*
dcl-pr f_dsplyLn like(int4_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_buffLn like(int4_t);
  i_fldl0100 likeds(fldl0100_t) const;
  i_withLen  like(bool_t) options(*nopass) const;
end-pr;


//-------------------------------------------------------------------*
dcl-pr f_curFldLn like(int4_t);
  i_buffer   like(rcdBuf_t) const;
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;


//-------------------------------------------------------------------*
dcl-pr f_rtvFld opdesc like(int4_t);
  o_buffer      like(rcdBuf_t) options(*varsize);
  i_buffer      like(rcdBuf_t) const;
  i_fldl0100    likeds(fldl0100_t) const;
  i_withLenByte like(bool_t) options(*nopass) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_fldToBuf;
  io_buffer     like(rcdBuf_t);
  i_fieldData   like(rcdBuf_t);
  i_fldl0100    likeds(fldl0100_t) const;
  i_withLenByte like(bool_t) options(*nopass) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isVarLen like(bool_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_binToDec opdesc like(int4_t);
  i_string   like(varString_t) options(*varsize) const;
  i_startPos like(int4_t) const;
  i_length   like(int4_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_len_deprecated opdesc like(int4_t);
  i_string like(varString_t) options(*varsize) const;
end-pr;

//-------------------------------------------------------------------*

dcl-pr f_scan opdesc like(int4_t);
  srchArg char(100) options(*varsize) const;
  string  char(100) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_vldName like(bool_t);
  i_name   like(fieldNme_t) const;
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_vldFloat like(bool_t);
  i_buffer varchar(64) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_execute opdesc like(bool_t);
  i_cmd    like(cmdBuffer_t) options(*varsize) const;
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_basedPF like(bool_t);
  i_file      like(file_t) value;
  i_lib       like(lib_t) value;
  i_mbr       like(mbr_t) value;
  i_rcdFmt    like(rcdFmt_t) value;
  i_rcdMbrNbr like(mbrNbr_t) value;
  o_pFile     like(file_t);
  o_pLib      like(lib_t);
  o_pMbr      like(mbr_t);
  o_pRcdFmt   like(rcdFmt_t);
end-pr;

dcl-pr f_basedMbr like(bool_t);
  i_file   like(file_t) value;
  i_lib    like(lib_t) value;
  i_mbr    like(mbr_t) value;
  i_mbrNbr like(int4_t) value;
  i_rcdFmt like(rcdFmt_t) value;
  o_pFile  like(file_t);
  o_pLib   like(lib_t);
  o_pMbr   like(mbr_t);
  o_rcdFmt like(rcdFmt_t);
end-pr;

dcl-pr f_numBased like(int4_t);
  i_file like(file_t) const;
  i_lib  like(lib_t) const;
  i_mbr  like(mbr_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_setPrdLb;
  i_lib like(lib_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_getPrdLb like(lib_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_cmdLine like(bool_t);
end-pr;


//-------------------------------------------------------------------*
dcl-pr p_expStr opdesc;
  o_string  like(varString_t) options(*varsize);
  i_string  like(varString_t) options(*varsize) const;
  i_stepVal like(int4_t) options(*nopass) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_headline like(colHeading_t);
  i_headTyp  like(type_t) const;
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isNumFld like(bool_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isFloatFld like(bool_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isCharFld like(bool_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_hasCcsid like(bool_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_appMsgF like(file_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_appMsgFL like(lib_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_rmvPgmMg;
  i_pgm like(pgm_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_sndPgmMg;
  i_msgID   like(msgId_t) const;
  i_msgDta  like(msgDta_t) const;
  i_pgmNme  like(pgm_t) const;
  i_msgType like(msgType_t) options(*nopass) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_canUseRefFld like(bool_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_canUseCntFld like(bool_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_mustCvtCcsid like(bool_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isToLong like(bool_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isToLongMax like(bool_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_maxDspLn like(int4_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_cntFldLn like(int4_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_nbrDspRw like(int4_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_decToBin opdesc;
  io_string  char(32767) options(*varsize);
  i_startPos like(int4_t) const;
  i_length   like(int4_t) const;
  i_value    like(int4_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isNotAlw like(bool_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isKeyFld like(bool_t);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_sndStsMg;
  i_msgID  like(msgId_t) const;
  i_msgDta like(msgDta_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_pgmCallN like(pgmCallN_t);
  i_pgmNme like(pgm_t) const;
  i_lib    like(lib_t) options(*nopass) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_rtvMsgD char(2048);
  i_msgID    like(msgId_t) value;
  i_msgDta   like(msgDta_t) value;
  i_rplcSubV like(bool_t) options(*nopass) const;
  i_rtnFmtCC like(bool_t) options(*nopass) const;
  i_msgF     like(file_t) options(*nopass) value;
  i_msgFL    like(lib_t) options(*nopass) value;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_msgText char(512);
  i_msgID  like(msgId_t) value;
  i_msgDta like(msgDta_t) value;
  i_msgF   like(file_t) options(*nopass) value;
  i_msgFL  like(lib_t) options(*nopass) value;
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_movPgmMg;
  i_pgmNme like(pgm_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_wrongKey;
  i_scnAID like(scnAID_t) const;
  i_pgmNme like(pgm_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_keyToMsg;
  i_scnAID like(scnAID_t) const;
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_splttxt_deprecated opdesc like(int4_t);
  i_text   like(varString_t) options(*varsize) const;
  i_strPos like(int4_t) const;
  i_len    like(int4_t) const;
  o_text   like(string_t) options(*varsize);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_center like(varString_t) opdesc;
  i_text like(varString_t) options(*varsize) const;
end-pr;

//===================================================================*
dcl-pr p_hexToChr extproc('cvthc');
  char   like(string_t) options(*varsize);
  hex    like(string_t) options(*varsize);
  lenHex like(int4_t) value;
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_chrToHex extproc('cvtch');
  hex     like(string_t) options(*varsize);
  char    like(string_t) options(*varsize);
  lenChar like(int4_t) value;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_addPtr pointer;
  i_pointer pointer value;
  i_offset  int(5) value;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isKeyExc like(bool_t);
  i_data     like(set0000_t) value;
  i_exclKeys like(pgmCmd_t) dim(25) value;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_num_descr like(int4_t);
  i_type     like(int1_t) value;
  i_length   like(int1_t) value;
  i_fraction like(int1_t) value;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_num_descr2 like(int4_t);
  i_type     like(dataType_t) value;
  i_length   like(int1_t) value;
  i_fraction like(int1_t) value;
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_clrErrno;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_errno int(10);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_strError like(msgDta_t);
  i_errno int(10) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_bitor uns(10);
  i_arg1 uns(10) value;
  i_arg2 uns(10) value;
  i_arg3 uns(10) options(*nopass) value;
  i_arg4 uns(10) options(*nopass) value;
  i_arg5 uns(10) options(*nopass) value;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_rpgToIntLength int(10);
  i_length int(10) value;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_exist ind;
  i_obj    char(10) const;
  i_lib    char(10) options(*omit) const;
  i_type   char(10) const;
  i_mbr    char(10) options(*omit: *nopass) const;
  o_msgID  like(msgId_t) options(*omit: *nopass);
  o_msgDta like(msgDta_t) options(*omit: *nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_wordWrap varchar(4096);
  i_string    varchar(4096) const;
  i_width     uns(10) const;
  io_startPos uns(10);
  i_options   uns(10) options(*nopass) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_startsWith ind;
  i_prefix varchar(4096) const;
  i_string varchar(4096) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_endsWith ind;
  i_suffix varchar(4096) const;
  i_string varchar(4096) const;
end-pr;

//-------------------------------------------------------------------*
//  Converts a given string to upper case.
dcl-pr f_ucase varchar(4096);
  i_string varchar(4096) const;
end-pr;

//-------------------------------------------------------------------*
//  Sends a message to the command line.
dcl-pr f_sndMsgToCmdLine;
  i_msgID  char(7) const;
  i_msgDta char(512) const;
end-pr;

//-------------------------------------------------------------------*
//  Returns the field type as a string.
dcl-pr f_fieldTypeAsString varchar(128);
  i_fldl0100 likeds(fldl0100_t) const;
end-pr;

//-------------------------------------------------------------------*
//  Returns the next headline.
dcl-pr f_nextHeaderType char(10);
  i_headerType char(10) value;
end-pr;

//-------------------------------------------------------------------*
//  Returns the record format ID of a given file.
dcl-pr f_getRecordFormatInf likeds(rcdFmtInf_t);
  i_file    like(file_t) value;
  i_library like(lib_t) value;
  i_rcdFmt  like(fmtId_t) value;
end-pr;

//-------------------------------------------------------------------*
//  Returns an empty string with a given length.
dcl-pr f_space like(varString_t);
  i_length int(10) value;
end-pr;

//-----------------------------------------------------------------*
// Prototype for CEEDOD (Retrieve operational descriptor)
//-----------------------------------------------------------------*
dcl-pr ceedod;
  parmnum   int(10) const;
  descType  int(10);
  dataType  int(10);
  descInfo1 int(10);
  descInfo2 int(10);
  inLen     int(10);
  fc        char(12) options(*omit);
end-pr;
//-------------------------------------------------------------------*
dcl-pr p_kill;
  i_text varchar(128) value;
end-pr;
//-------------------------------------------------------------------*
dcl-pr f_mapCmdToMsg like(msgId_t);
  i_command char(256) const;
  i_section like(section_t) options(*nopass) const;
end-pr;
//-------------------------------------------------------------------*
//  Datum im externen Format eines Feldes (DATFMT, DATSEP).
dcl-pr f_extDate varchar(10);
  i_fldl0100 likeds(fldl0100_t) const;
  i_date     date(*iso) value;
end-pr;
//-------------------------------------------------------------------*
//  Zeit im externen Format eines Feldes (TIMFMT, TIMSEP).
dcl-pr f_extTime varchar(8);
  i_fldl0100 likeds(fldl0100_t) const;
  i_time     time(*iso) value;
end-pr;

