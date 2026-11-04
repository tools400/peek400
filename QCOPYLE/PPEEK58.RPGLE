**FREE

//============================================================*
//      Modul: Peek058
//============================================================*

//  Konstants: f_wordWrap()
dcl-c cWORDWRAP_PARAGRAPH_NONE   1;
dcl-c cWORDWRAP_PARAGRAPH_MSGD   2;
dcl-c cWORDWRAP_PARAGRAPH_TEXT   4;
dcl-c cWORDWRAP_PARAGRAPH_TRIMR  8;

//-------------------------------------------------------------------*
dcl-pr f_dsplyln like(int4_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_buffln like(int4_t);
  i_fldl0100      const  likeds(fldl0100_t);
  i_withlen       const  like(bool_t) options(*nopass);
end-pr;


//-------------------------------------------------------------------*
dcl-pr f_curfldln like(int4_t);
  i_buffer        const  like(rcdbuf_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;


//-------------------------------------------------------------------*
dcl-pr f_rtvfld opdesc like(int4_t);
  o_buffer               like(rcdbuf_t) options(*varsize);
  i_buffer        const  like(rcdbuf_t);
  i_fldl0100      const  likeds(fldl0100_t);
  i_withlenbyte   const  like(bool_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_fldtobuf;
  io_buffer              like(rcdbuf_t);
  i_fielddata            like(rcdbuf_t);
  i_fldl0100      const  likeds(fldl0100_t);
  i_withlenbyte   const  like(bool_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isvarlen like(bool_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_bintodec opdesc like(int4_t);
  i_string        const  like(varString_t) options(*varsize);
  i_startPos      const  like(int4_t);
  i_length        const  like(int4_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_len_DEPRECATED opdesc like(int4_t);
  i_string        const  like(varString_t) options(*varsize);
end-pr;

//-------------------------------------------------------------------*

dcl-pr f_scan opdesc like(int4_t);
  srcharg         char(100) const  options(*varsize);
  string          char(100) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_vldname like(bool_t);
  i_name          const  like(fieldNme_t);
  o_msgid                like(msgid_t);
  o_msgdta               like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_vldfloat like(bool_t);
  i_buffer        varchar(64) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_execute opdesc like(bool_t);
  i_cmd           const  like(cmdBuffer_t) options(*varsize);
  o_msgid                like(msgid_t);
  o_msgdta               like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_basedpf like(bool_t);
  i_file          value  like(file_t);
  i_lib           value  like(lib_t);
  i_mbr           value  like(mbr_t);
  i_rcdfmt        value  like(rcdfmt_t);
  i_rcdmbrnbr     value  like(mbrnbr_t);
  o_pfile                like(file_t);
  o_plib                 like(lib_t);
  o_pmbr                 like(mbr_t);
  o_prcdfmt              like(rcdfmt_t);
end-pr;

dcl-pr f_basedmbr like(bool_t);
  i_file          value  like(file_t);
  i_lib           value  like(lib_t);
  i_mbr           value  like(mbr_t);
  i_mbrnbr        value  like(int4_t);
  i_rcdfmt        value  like(rcdfmt_t);
  o_pfile                like(file_t);
  o_plib                 like(lib_t);
  o_pmbr                 like(mbr_t);
  o_rcdfmt               like(rcdfmt_t);
end-pr;

dcl-pr f_numbased like(int4_t);
  i_file          const  like(file_t);
  i_lib           const  like(lib_t);
  i_mbr           const  like(mbr_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_setprdlb;
  i_lib           const  like(lib_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_getprdlb like(lib_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_cmdline like(bool_t);
end-pr;


//-------------------------------------------------------------------*
dcl-pr p_expstr opdesc;
  o_string               like(varString_t) options(*varsize);
  i_string        const  like(varString_t) options(*varsize);
  i_stepVal       const  like(int4_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_headline like(colheading_t);
  i_headtyp       const  like(type_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isnumfld like(bool_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isfloatfld like(bool_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_ischarfld like(bool_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_hasccsid like(bool_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_appmsgf like(file_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_appmsgfl like(lib_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_rmvpgmmg;
  i_pgm           const  like(pgm_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_sndpgmmg;
  i_msgid         const  like(msgid_t);
  i_msgdta        const  like(msgdta_t);
  i_pgmnme        const  like(pgm_t);
  i_msgtype       const  like(msgtype_t)
       options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_canusereffld like(bool_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_canusecntfld like(bool_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_mustcvtccsid like(bool_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_istolong like(bool_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_istolongmax like(bool_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_maxdspln like(int4_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_cntfldln like(int4_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_nbrdsprw like(int4_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_dectobin opdesc;
  io_string       char(32767) options(*varsize);
  i_startpos      const  like(int4_t);
  i_length        const  like(int4_t);
  i_value         const  like(int4_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_isnotalw like(bool_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_iskeyfld like(bool_t);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_sndstsmg;
  i_msgid         const  like(msgid_t);
  i_msgdta        const  like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_pgmcalln like(pgmcalln_t);
  i_pgmnme        const  like(pgm_t);
  i_lib           const  like(lib_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_rtvmsgd char(2048);
  i_msgid         value  like(msgid_t);
  i_msgdta        value  like(msgdta_t);
  i_rplcsubv      const  like(bool_t) options(*nopass);
  i_rtnfmtcc      const  like(bool_t) options(*nopass);
  i_msgf          value  like(file_t) options(*nopass);
  i_msgfl         value  like(lib_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_msgtext char(512);
  i_msgid         value  like(msgid_t);
  i_msgdta        value  like(msgdta_t);
  i_msgf          value  like(file_t) options(*nopass);
  i_msgfl         value  like(lib_t) options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_movpgmmg;
  i_pgmnme        const  like(pgm_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_wrongkey;
  i_scnaid        const  like(scnaid_t);
  i_pgmnme        const  like(pgm_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_keytomsg;
  i_scnaid        const  like(scnaid_t);
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_splttxt_DEPRECATED opdesc like(int4_t);
  i_text          const  like(varString_t) options(*varsize);
  i_strPos        const  like(int4_t);
  i_len           const  like(int4_t);
  o_text                 like(string_t) options(*varsize);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_center like(varString_t) opdesc;
  i_text          const  like(varString_t) options(*varsize);
end-pr;

//===================================================================*
dcl-pr p_hextochr extproc('cvthc');
  char                   like(string_t) options(*varsize);
  hex                    like(string_t) options(*varsize);
  lenhex          value  like(int4_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_chrtohex extproc('cvtch');
  hex                    like(string_t) options(*varsize);
  char                   like(string_t) options(*varsize);
  lenchar         value  like(int4_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_addptr pointer;
  i_pointer       pointer value;
  i_offset        int(5)  value;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_iskeyexc like(bool_t);
  i_data          value like(set0000_t);
  i_exclkeys      value like(pgmcmd_t) dim(25);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_num_descr like(int4_t);
  i_type          value  like(int1_t);
  i_length        value  like(int1_t);
  i_fraction      value  like(int1_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_num_descr2 like(int4_t);
  i_type          value  like(dataType_t);
  i_length        value  like(int1_t);
  i_fraction      value  like(int1_t);
end-pr;

//-------------------------------------------------------------------*
dcl-pr p_clrerrno;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_errno int(10);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_strerror like(msgdta_t);
  i_errno         int(10) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_bitor uns(10);
  i_arg1          uns(10) value;
  i_arg2          uns(10) value;
  i_arg3          uns(10) value  options(*nopass);
  i_arg4          uns(10) value  options(*nopass);
  i_arg5          uns(10) value  options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_rpgtointlength
       int(10);
  i_length        int(10) value;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_exist ind;
  i_obj     char(10) const;
  i_lib     char(10) const options(*omit);
  i_type    char(10) const;
  i_mbr     char(10) const options(*omit: *nopass);
  o_msgID   like(msgid_t) options(*omit: *nopass);
  o_msgDta  like(msgdta_t) options(*omit: *nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_wordwrap varchar(4096);
  i_string        varchar(4096) const;
  i_width         uns(10) const;
  io_startpos     uns(10);
  i_options       uns(10) const  options(*nopass);
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_startswith ind;
  i_prefix        varchar(4096) const;
  i_string        varchar(4096) const;
end-pr;

//-------------------------------------------------------------------*
dcl-pr f_endswith ind;
  i_suffix        varchar(4096) const;
  i_string        varchar(4096) const;
end-pr;

//-------------------------------------------------------------------*
//  Converts a given string to upper case.
dcl-pr f_ucase varchar(4096);
  i_string        varchar(4096) const;
end-pr;

//-------------------------------------------------------------------*
//  Sends a message to the command line.
dcl-pr f_sndmsgtocmdline;
  i_msgid         char(7) const;
  i_msgdta        char(512) const;
end-pr;

//-------------------------------------------------------------------*
//  Returns the field type as a string.
dcl-pr f_fieldtypeasstring varchar(128);
  i_fldl0100      const  likeds(fldl0100_t);
end-pr;

//-------------------------------------------------------------------*
//  Returns the next headline.
dcl-pr f_nextheadertype char(10);
  i_headertype    char(10) value;
end-pr;

//-------------------------------------------------------------------*
//  Returns the record format ID of a given file.
dcl-pr f_getrecordformatinf likeds(rcdfmtinf_t);
i_file          value  like(file_t);
i_library       value  like(lib_t);
i_rcdfmt        value  like(fmtid_t);
end-pr;

//-------------------------------------------------------------------*
//  Returns an empty string with a given length.
dcl-pr f_space like(varString_t);
  i_length        int(10) value;
end-pr;

//-----------------------------------------------------------------*
// Prototype for CEEDOD (Retrieve operational descriptor)
//-----------------------------------------------------------------*
dcl-pr ceedod;
  parmnum         int(10) const;
  desctype        int(10);
  datatype        int(10);
  descinfo1       int(10);
  descinfo2       int(10);
  inlen           int(10);
  fc              char(12) options(*omit);
end-pr;
//-------------------------------------------------------------------*
dcl-pr p_kill;
  i_text          varchar(128) value;
end-pr;
//-------------------------------------------------------------------*
dcl-pr f_mapcmdtomsg like(msgid_t);
  i_command       char(256) const;
  i_section       const  like(section_t) options(*nopass);
end-pr;

