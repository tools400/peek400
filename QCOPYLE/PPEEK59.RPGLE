**FREE

/if defined(internal_prototype)
dcl-pr peek59 extpgm('PEEK59');
/else
dcl-pr peek59 extpgm(peek59_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_type                             const like(type_t);
  i_msgid                            const like(msgid_t);
  i_msgdta                           const like(msgdta_t);
  i_keys                             const like(keys_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
