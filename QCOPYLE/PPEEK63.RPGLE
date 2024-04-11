**FREE

//============================================================*
//      Modul: Peek063
//============================================================*
/INCLUDE QCOPYLE,D_VARDEF
/INCLUDE QCOPYLE,D_INFDS

dcl-ds hfile_t qualified template;
  fd              pointer;
  isopen          like(bool_t);
  name            like(file_t);
  lib             like(lib_t);
  mbr             like(mbr_t);
  rcdformat       char(10);
  errno           int(10);
  lastoper        char(10);
  arrseq          char(1);
  msgid           like(msgid_t);
  msgdta          like(msgdta_t);
end-ds;

//-------------------------------------------------------------------*
dcl-pr CIO_open like(bool_t) extproc('PEEK63_CIO_open');
  o_hfile                likeds(hfile_t);
  i_file          const  like(file_t);
  i_lib           const  like(lib_t);
  i_mbr           const  like(mbr_t);
  i_rcdformat     const  like(rcdFmt_t);
  i_mode          pointer const  options(*string);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_isOpen like(bool_t) extproc('PEEK63_CIO_isOpen');
  i_hfile         const  likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getFile like(file_t) extproc('PEEK63_CIO_getFile');
  i_hfile         const  likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getLibrary like(lib_t) extproc('PEEK63_CIO_getLibrary');
  i_hfile         const  likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getMember like(mbr_t) extproc('PEEK63_CIO_getMember');
  i_hfile         const  likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getRecordFormat char(10) extproc('PEEK63_CIO_getRecordFormat');
  i_hfile         const  likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getRecordLength int(10) extproc('PEEK63_CIO_getRecordLength');
  i_hfile         const  likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getRrn like(rcdNbr_t) extproc('PEEK63_CIO_getRRN');
  i_hfile         const  likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getMbrNbr int(10) extproc('PEEK63_CIO_getMbrNbr');
  i_hfile         const  likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getInfDS likeds(infds_t) extproc('PEEK63_CIO_getInfDS');
  i_hfile         const  likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_isError like(bool_t) extproc('PEEK63_CIO_isError');
  i_hfile         const  likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setErrorMsg extproc('PEEK63_CIO_setErrorMsg');
  io_hfile               likeds(hfile_t);
  i_msgid         const  like(msgid_t);
  i_msgdta        const  like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getErrorMsg extproc('PEEK63_CIO_getErrorMsg');
  i_hfile         const  likeds(hfile_t);
  o_msgid                like(msgid_t);
  o_msgdta               like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getError int(10) extproc('PEEK63_CIO_getError');
  i_hfile         const  likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_getErrorText varchar(512) extproc('PEEK63_CIO_getErrorText');
  i_hfile         const  likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_chainWithRrn like(bool_t) extproc('PEEK63_CIO_chainWithRRN');
  io_hfile               likeds(hfile_t);
  i_rrn           const  like(rcdNbr_t);
  i_dolock        const  like(bool_t);
  io_rcdbuffer           like(rcdbuf_t);
  io_nullmap             like(nullmap_t) dim(NULL_MAP_SIZE);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_chainWithKey like(bool_t) extproc('PEEK63_CIO_chainWithKey');
  io_hfile               likeds(hfile_t);
  i_key           const  like(keybuf_t);
  i_dolock        const  like(bool_t);
  io_rcdbuffer           like(rcdbuf_t);
  io_nullmap             like(nullmap_t) dim(NULL_MAP_SIZE);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setllWithRrn like(bool_t) extproc('PEEK63_CIO_setllWithRRN');
  io_hfile               likeds(hfile_t);
  i_rrn           const  like(rcdNbr_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setllWithKey like(bool_t) extproc('PEEK63_CIO_setllWithKey');
  io_hfile               likeds(hfile_t);
  i_key           const  like(keybuf_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setgtWithRrn like(bool_t) extproc('PEEK63_CIO_setgtWithRRN');
  io_hfile               likeds(hfile_t);
  i_rrn           const  like(rcdNbr_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setgtWithKey like(bool_t) extproc('PEEK63_CIO_setgtWithKey');
  io_hfile               likeds(hfile_t);
  i_key           const  like(keybuf_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_read like(bool_t) extproc('PEEK63_CIO_read');
  io_hfile               likeds(hfile_t);
  i_dolock        const  like(bool_t);
  io_rcdbuffer           like(rcdbuf_t);
  io_nullmap             like(nullmap_t) dim(NULL_MAP_SIZE);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_readp like(bool_t) extproc('PEEK63_CIO_readp');
  io_hfile               likeds(hfile_t);
  i_dolock        const  like(bool_t);
  io_rcdbuffer           like(rcdbuf_t);
  io_nullmap             like(nullmap_t) dim(NULL_MAP_SIZE);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_delete like(bool_t) extproc('PEEK63_CIO_delete');
  io_hfile               likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_unlock like(bool_t) extproc('PEEK63_CIO_unlock');
  io_hfile               likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_close like(bool_t) extproc('PEEK63_CIO_close');
  io_hfile               likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setEOF_read extproc('PEEK63_CIO_setEOF_read');
  io_hfile               likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr CIO_setEOF_readp extproc('PEEK63_CIO_setEOF_readp');
  io_hfile               likeds(hfile_t);
end-pr;

//-------------------------------------------------------------------*
