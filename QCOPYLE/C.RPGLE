**free

//============================================================*
//      Modul: Peek063                                        *
//============================================================*
/include QCOPYLE,D_VARDEF
/include QCOPYLE,D_INFDS

dcl-ds hFile_t qualified template;
  fd        pointer;
  isOpen    like(bool_t);
  name      like(file_t);
  lib       like(lib_t);
  mbr       like(mbr_t);
  rcdFormat char(10);
  errno     int(10);
  lastOper  char(10);
  rrn       int(10);
  arrseq    char(1);
  msgID     like(msgId_t);
  msgDta    like(msgDta_t);
end-ds;

//-------------------------------------------------------------------*
dcl-pr cio_open like(bool_t) extproc('PEEK63_CIO_open');
  o_hFile     likeds(hFile_t);
  i_file      like(file_t) const;
  i_lib       like(lib_t) const;
  i_mbr       like(mbr_t) const;
  i_rcdFormat char(10) const;
  i_mode      pointer options(*string) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_isOpen like(bool_t) extproc('PEEK63_CIO_isOpen');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_getFile like(file_t) extproc('PEEK63_CIO_getFile');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_getLibrary like(lib_t) extproc('PEEK63_CIO_getLibrary');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_getMember like(mbr_t) extproc('PEEK63_CIO_getMember');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_getRecordFormat char(10) extproc('PEEK63_CIO_getRecordFormat');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_getRecordLength int(10) extproc('PEEK63_CIO_getRecordLength');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_getRRN int(10) extproc('PEEK63_CIO_getRRN');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_getInfDS likeds(infds_t) extproc('PEEK63_CIO_getInfDS');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_isError like(bool_t) extproc('PEEK63_CIO_isError');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_setErrorMsg extproc('PEEK63_CIO_setErrorMsg');
  io_hFile likeds(hFile_t);
  i_msgID  like(msgId_t) const;
  i_msgDta like(msgDta_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_getError int(10) extproc('PEEK63_CIO_getError');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_getErrorText varchar(512) extproc('PEEK63_CIO_getErrorText');
  i_hFile likeds(hFile_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_chainWithRRN like(bool_t) extproc('PEEK63_CIO_chainWithRRN');
  io_hFile     likeds(hFile_t);
  i_rrn        like(rcdNbr_t) const;
  i_doLock     like(bool_t) const;
  io_rcdBuffer like(rcdBuf_t);
  io_nullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_chainWithKey like(bool_t) extproc('PEEK63_CIO_chainWithKey');
  io_hFile     likeds(hFile_t);
  i_key        like(keyBuf_t) const;
  i_doLock     like(bool_t) const;
  io_rcdBuffer like(rcdBuf_t);
  io_nullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_setllWithRRN like(bool_t) extproc('PEEK63_CIO_setllWithRRN');
  io_hFile likeds(hFile_t);
  i_rrn    like(rcdNbr_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_setllWithKey like(bool_t) extproc('PEEK63_CIO_setllWithKey');
  io_hFile likeds(hFile_t);
  i_key    like(keyBuf_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_setgtWithRRN like(bool_t) extproc('PEEK63_CIO_setgtWithRRN');
  io_hFile likeds(hFile_t);
  i_rrn    like(rcdNbr_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_setgtWithKey like(bool_t) extproc('PEEK63_CIO_setgtWithKey');
  io_hFile likeds(hFile_t);
  i_key    like(keyBuf_t) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_read like(bool_t) extproc('PEEK63_CIO_read');
  io_hFile     likeds(hFile_t);
  i_doLock     like(bool_t) const;
  io_rcdBuffer like(rcdBuf_t);
  io_nullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_readp like(bool_t) extproc('PEEK63_CIO_readp');
  io_hFile     likeds(hFile_t);
  i_doLock     like(bool_t) const;
  io_rcdBuffer like(rcdBuf_t);
  io_nullMap   like(nullMap_t) dim(NULL_MAP_SIZE);
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_delete like(bool_t) extproc('PEEK63_CIO_delete');
  io_hFile likeds(hFile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_unlock like(bool_t) extproc('PEEK63_CIO_unlock');
  io_hFile likeds(hFile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr cio_close like(bool_t) extproc('PEEK63_CIO_close');
  io_hFile likeds(hFile_t);
end-pr;

//-------------------------------------------------------------------*

