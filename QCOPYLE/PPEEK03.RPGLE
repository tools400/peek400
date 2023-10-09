**FREE

/if defined(internal_prototype)
dcl-pr peek03 extpgm('PEEK03');
/else
dcl-pr peek03 extpgm(peek03_name);
/endif
  i_qfile                            const likeds(qobj_t);
  i_rcdfmt                           const like(fmt_t);
  i_access                           const like(accessMode_t);
  i_sqlorder                         const like(sqlOrder_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
