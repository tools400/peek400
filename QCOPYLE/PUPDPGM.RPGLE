**free

/if defined(internal_prototype)
dcl-pr updpgm extpgm('UPDPGM');
/else
dcl-pr updpgm extpgm(updpgm_name);
/endif
  i_dsp80       like(dsp80_t) const;
  io_headerType like(headerType_t);
  i_copyright   like(copyright_t) const;
  i_rcdNbr      like(rcdNbr_t) const;
  i_file        like(file_t) const;
  i_library     like(lib_t) const;
  i_member      like(mbr_t) const;
  i_function    like(function_t) const;
  i_commitLVL   like(commitLvl_t) const;
  i_isUpdKey    like(bool_t) const;
  io_screenNbr  like(int4_t);
  io_isLower    like(bool_t);
  io_csrRow     like(int4_t);
  io_csrCol     like(int4_t);
  o_msgID       like(msgId_t);
  o_msgDta      like(msgDta_t);
end-pr;

