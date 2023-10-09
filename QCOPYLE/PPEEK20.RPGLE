**FREE

/if defined(internal_prototype)
dcl-pr peek20 extpgm('PEEK20');
/else
dcl-pr peek20 extpgm(peek20_name);
/endif
  i_keyval                           const like(keybuf_t);
  o_rcdbuffer                              like(rcdbuf_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
