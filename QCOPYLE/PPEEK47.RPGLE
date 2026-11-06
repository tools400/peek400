**free

/if defined(internal_prototype)
dcl-pr peek47 extpgm('PEEK47');
/else
dcl-pr peek47 extpgm(peek47_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  i_qfile     likeds(qobj_t) const;
  i_mbr       like(mbr_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
