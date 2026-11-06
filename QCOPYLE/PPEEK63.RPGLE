**free

//============================================================*
//      Modul: Peek063
//============================================================*
/include QCOPYLE,D_VARDEF
/include QCOPYLE,D_INFDS

dcl-ds hFile_t qualified template;
  fd        pointer;
  IsOpen    like(bool_t);
  name      like(file_t);
  lib       like(lib_t);
  mbr       like(mbr_t);
  rcdFormat char(10);
  errno     int(10);
  lastOper  char(10);
  arrseq    char(1);
  msgID     like(msgId_t);
  msgDta    like(msgDta_t);
end-ds;

//-------------------------------------------------------------------*
dcl-pr CIO_open like(bool_t) extproc('PEEK63_CIO_open');
  o_hFile     likeds(hFile_t);
  i_file      like(file_t) const;
  i_lib       like(lib_t) const;
  i_mbr       like(mbr_t) const;
  i_rcdFormat like(rcdFmt_t) const;
  i_mode      pointer options(*string) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_isOpen like(bool_t) extproc('PEEK63_CIO_isOpen');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getFile like(file_t) extproc('PEEK63_CIO_getFile');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getLibrary like(lib_t) extproc('PEEK63_CIO_getLibrary');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getMember like(mbr_t) extproc('PEEK63_CIO_getMember');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getRecordFormat char(10) extproc('PEEK63_CIO_getRecordFormat');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getRecordLength int(10) extproc('PEEK63_CIO_getRecordLength');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getRRN like(rcdNbr_t) extproc('PEEK63_CIO_getRRN');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getMbrNbr int(10) extproc('PEEK63_CIO_getMbrNbr');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getInfDS likeds(infds_t) extproc('PEEK63_CIO_getInfDS');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_isError like(bool_t) extproc('PEEK63_CIO_isError');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setErrorMsg extproc('PEEK63_CIO_setErrorMsg');
  io_hFile likeds(hFile_t);
  i_msgID  like(msgId_t) const;
  i_msgDta like(msgDta_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getErrorMsg extproc('PEEK63_CIO_getErrorMsg');
  i_hFile  likeds(hFile_t) const;
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getError int(10) extproc('PEEK63_CIO_getError');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getErrorText varchar(512) extproc('PEEK63_CIO_getErrorText');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_chainWithRRN like(bool_t) extproc('PEEK63_CIO_chainWithRRN');
  io_hFile     likeds(hFile_t);
  i_rrn        like(rcdNbr_t) const;
  i_doLock     like(bool_t) const;
  io_rcdBuffer like(rcdBuf_t);
  IO_NullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_chainWithKey like(bool_t) extproc('PEEK63_CIO_chainWithKey');
  io_hFile     likeds(hFile_t);
  i_key        like(keyBuf_t) const;
  i_doLock     like(bool_t) const;
  io_rcdBuffer like(rcdBuf_t);
  IO_NullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setllWithRRN like(bool_t) extproc('PEEK63_CIO_setllWithRRN');
  io_hFile likeds(hFile_t);
  i_rrn    like(rcdNbr_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setllWithKey like(bool_t) extproc('PEEK63_CIO_setllWithKey');
  io_hFile likeds(hFile_t);
  i_key    like(keyBuf_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setgtWithRRN like(bool_t) extproc('PEEK63_CIO_setgtWithRRN');
  io_hFile likeds(hFile_t);
  i_rrn    like(rcdNbr_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setgtWithKey like(bool_t) extproc('PEEK63_CIO_setgtWithKey');
  io_hFile likeds(hFile_t);
  i_key    like(keyBuf_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_read like(bool_t) extproc('PEEK63_CIO_read');
  io_hFile     likeds(hFile_t);
  i_doLock     like(bool_t) const;
  io_rcdBuffer like(rcdBuf_t);
  IO_NullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_readp like(bool_t) extproc('PEEK63_CIO_readp');
  io_hFile     likeds(hFile_t);
  i_doLock     like(bool_t) const;
  io_rcdBuffer like(rcdBuf_t);
  IO_NullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_delete like(bool_t) extproc('PEEK63_CIO_delete');
  io_hFile likeds(hFile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_unlock like(bool_t) extproc('PEEK63_CIO_unlock');
  io_hFile likeds(hFile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_close like(bool_t) extproc('PEEK63_CIO_close');
  io_hFile likeds(hFile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setEOF_read extproc('PEEK63_CIO_setEOF_read');
  io_hFile likeds(hFile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setEOF_readp extproc('PEEK63_CIO_setEOF_readp');
  io_hFile likeds(hFile_t);
end-pr;

//-------------------------------------------------------------------*
