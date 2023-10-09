**FREE

/if defined(internal_prototype)
dcl-pr peek04 extpgm('PEEK04');
/else
dcl-pr peek04 extpgm(peek04_name);
/endif
  i_qfile                            const likeds(qobj_t);
  i_rcdfmt                           const like(fmt_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
