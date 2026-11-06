**free

/if defined(internal_prototype)
dcl-pr peek48 extpgm('PEEK48');
/else
dcl-pr peek48 extpgm(peek48_name);
/endif
  i_dsp80       like(dsp80_t) const;
  i_copyright   like(copyrght_t) const;
  io_file       like(file_t);
  io_library    like(lib_t);
  io_member     like(mbr_t);
  io_rcdfmt     like(fmt_t);
  i_accessmode  like(accessmode_t) const;
  io_sqlwhere   like(sqlwhere_t);
  io_sqlorder   like(sqlorder_t);
  i_enablewhere like(bool_t) const;
  i_enableorder like(bool_t) const;
  o_msgid       like(msgid_t);
  o_msgdta      like(msgdta_t);
end-pr;
