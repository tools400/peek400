**free

/if defined(internal_prototype)
dcl-pr updpgm extpgm('UPDPGM');
/else
dcl-pr updpgm extpgm(updpgm_name);
/endif
  i_dsp80       like(dsp80_t) const;
  io_headertype like(headertype_t);
  i_copyright   like(copyrght_t) const;
  i_rcdnbr      like(rcdnbr_t) const;
  i_file        like(file_t) const;
  i_library     like(lib_t) const;
  i_member      like(mbr_t) const;
  i_function    like(function_t) const;
  i_commitlvl   like(commitlvl_t) const;
  i_isupdkey    like(bool_t) const;
  io_screennbr  like(int4_t);
  io_islower    like(bool_t);
  io_csrrow     like(int4_t);
  io_csrcol     like(int4_t);
  o_msgid       like(msgid_t);
  o_msgdta      like(msgdta_t);
end-pr;

