**FREE

/if defined(internal_prototype)
dcl-pr peek19 extpgm('PEEK19');
/else
dcl-pr peek19 extpgm(peek19_name);
/endif
  i_rcdbuffer                        const like(rcdbuf_t);
  o_keyval                                 like(keybuf_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
