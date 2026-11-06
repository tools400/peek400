**free

/if defined(internal_prototype)
dcl-pr peek40 extpgm('PEEK40');
/else
dcl-pr peek40 extpgm(peek40_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  i_file      like(file_t) const;
  ib          like(lib_t) const;
  i_mbr       like(mbr_t) const;
  i_rcdfmt    like(fmt_t) const;
  i_basephyf  like(bool_t) const;
  o_file      like(file_t);
  o_lib       like(lib_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
