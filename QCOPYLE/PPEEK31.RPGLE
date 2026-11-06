**free

/if defined(internal_prototype)
dcl-pr peek31 extpgm('PEEK31');
/else
dcl-pr peek31 extpgm(peek31_name);
/endif
  io_language like(language_t);
  i_prefix    like(prefix_t) const;
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
