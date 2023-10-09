**FREE

/if defined(internal_prototype)
dcl-pr peek09 extpgm('PEEK09');
/else
dcl-pr peek09 extpgm(peek09_name);
/endif
  i_qfile                            const likeds(qobj_t);
  o_data                                   likeds(objd0400_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
