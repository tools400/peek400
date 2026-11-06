**free

/if defined(internal_prototype)
dcl-pr peek14 extpgm('PEEK14');
/else
dcl-pr peek14 extpgm(peek14_name);
/endif
  i_dsp80       like(dsp80_t) const;
  io_headertype like(headertype_t);
  i_copyright   like(copyrght_t) const;
  i_rcdnbr      like(rcdnbr_t) const;
  i_file        like(file_t) const;
  i_lib         like(lib_t) const;
  i_mbr         like(mbr_t) const;
  i_rcdfmt      like(fmt_t) const;
  i_function    like(function_t) const;
  i_commitlvl   like(bool_t) const;
  io_screennbr  like(int4_t);
  o_msgid       like(msgid_t);
  o_msgdta      like(msgdta_t);
end-pr;
