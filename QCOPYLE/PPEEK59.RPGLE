**free

/if defined(internal_prototype)
dcl-pr peek59 extpgm('PEEK59');
/else
dcl-pr peek59 extpgm(peek59_name);
/endif
  i_dsp80  like(dsp80_t) const;
  i_type   like(type_t) const;
  i_msgid  like(msgid_t) const;
  i_msgdta like(msgdta_t) const;
  i_keys   like(keys_t) const;
  o_msgid  like(msgid_t);
  o_msgdta like(msgdta_t);
end-pr;
