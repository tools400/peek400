**FREE
//
//============================================================*
//      Modul: Peek063                                        *
//============================================================*
/INCLUDE QCOPYLE,D_VARDEF
/INCLUDE QCOPYLE,D_INFDS
//
dcl-ds hfile_t qualified template;
  fd              pointer;
  isopen          like(bool_t);
  name            like(file_t);
  lib             like(lib_t);
  mbr             like(mbr_t);
  rcdformat       char(10);
  errno           int(10);
  lastoper        char(10);
  rrn             int(10);
  arrseq          char(1);
  msgid           like(msgid_t);
  msgdta          like(msgdta_t);
end-ds;
//
//-------------------------------------------------------------------*
dcl-pr cio_open
       like(bool_t)
       extproc('PEEK63+
       _CIO_open+
       ');
  o_hfile         likeds(hfile_t);
i_file          const  like(file_t);
i_lib           const  like(lib_t);
i_mbr           const  like(mbr_t);
i_rcdformat     char(10) const;
i_mode          pointer const  options(*string);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_isopen
       like(bool_t)
       extproc('PEEK63+
       _CIO_isOpen+
       ');
  i_hfile         const  likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_getfile
       like(file_t)
       extproc('PEEK63+
       _CIO_getFile+
       ');
  i_hfile         const  likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_getlibrary
       like(lib_t)
       extproc('PEEK63+
       _CIO_getLibrary+
       ');
  i_hfile         const  likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_getmember
       like(mbr_t)
       extproc('PEEK63+
       _CIO_getMember+
       ');
  i_hfile         const  likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_getrecordformat
       char(10)
       extproc('PEEK63+
       _CIO_getRecordFormat+
       ');
  i_hfile         const  likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_getrecordlength
       int(10)
       extproc('PEEK63+
       _CIO_getRecordLength+
       ');
  i_hfile         const  likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_getrrn
       int(10)
       extproc('PEEK63+
       _CIO_getRRN+
       ');
  i_hfile         const  likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_getinfds
       likeds(infds_t)
extproc('PEEK63+
_CIO_getInfDS+
');
i_hfile         const  likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_iserror
       like(bool_t)
       extproc('PEEK63+
       _CIO_isError+
       ');
  i_hfile         const  likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_seterrormsg
       extproc('PEEK63+
       _CIO_setErrorMsg+
       ');
  io_hfile        likeds(hfile_t);
i_msgid         const  like(msgid_t);
i_msgdta        const  like(msgdta_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_geterror
       int(10)
       extproc('PEEK63+
       _CIO_getError+
       ');
  i_hfile         const  likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_geterrortext
       varchar(512)
       extproc('PEEK63+
       _CIO_getErrorText+
       ');
  i_hfile         const  likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_chainwithrrn
       like(bool_t)
       extproc('PEEK63+
       _CIO_chainWithRRN+
       ');
  io_hfile        likeds(hfile_t);
i_rrn           const  like(rcdnbr_t);
i_dolock        const  like(bool_t);
io_rcdbuffer    like(rcdbuf_t);
io_nullmap      like(nullmap_t)
     dim(NULL_MAP_SIZE);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_chainwithkey
       like(bool_t)
       extproc('PEEK63+
       _CIO_chainWithKey+
       ');
  io_hfile        likeds(hfile_t);
i_key           const  like(keybuf_t);
i_dolock        const  like(bool_t);
io_rcdbuffer    like(rcdbuf_t);
io_nullmap      like(nullmap_t)
     dim(NULL_MAP_SIZE);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_setllwithrrn
       like(bool_t)
       extproc('PEEK63+
       _CIO_setllWithRRN+
       ');
  io_hfile        likeds(hfile_t);
i_rrn           const  like(rcdnbr_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_setllwithkey
       like(bool_t)
       extproc('PEEK63+
       _CIO_setllWithKey+
       ');
  io_hfile        likeds(hfile_t);
i_key           const  like(keybuf_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_setgtwithrrn
       like(bool_t)
       extproc('PEEK63+
       _CIO_setgtWithRRN+
       ');
  io_hfile        likeds(hfile_t);
i_rrn           const  like(rcdnbr_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_setgtwithkey
       like(bool_t)
       extproc('PEEK63+
       _CIO_setgtWithKey+
       ');
  io_hfile        likeds(hfile_t);
i_key           const  like(keybuf_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_read
       like(bool_t)
       extproc('PEEK63+
       _CIO_read+
       ');
  io_hfile        likeds(hfile_t);
i_dolock        const  like(bool_t);
io_rcdbuffer    like(rcdbuf_t);
io_nullmap      like(nullmap_t)
     dim(NULL_MAP_SIZE);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_readp
       like(bool_t)
       extproc('PEEK63+
       _CIO_readp+
       ');
  io_hfile        likeds(hfile_t);
i_dolock        const  like(bool_t);
io_rcdbuffer    like(rcdbuf_t);
io_nullmap      like(nullmap_t)
     dim(NULL_MAP_SIZE);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_delete
       like(bool_t)
       extproc('PEEK63+
       _CIO_delete+
       ');
  io_hfile        likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_unlock
       like(bool_t)
       extproc('PEEK63+
       _CIO_unlock+
       ');
  io_hfile        likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
dcl-pr cio_close
       like(bool_t)
       extproc('PEEK63+
       _CIO_close+
       ');
  io_hfile        likeds(hfile_t);
end-pr;
//
//-------------------------------------------------------------------*
//
