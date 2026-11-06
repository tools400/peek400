**free

/if defined(internal_prototype)
dcl-pr peek65 extpgm('PEEK65');
/else
dcl-pr peek65 extpgm(peek65_name);
/endif
  i_rcdnbr    like(rcdnbr_t) const;
  i_file      like(file_t) const;
  i_library   like(lib_t) const;
  i_member    like(mbr_t) const;
  i_rcdformat like(rcdfmt_t) const;
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
