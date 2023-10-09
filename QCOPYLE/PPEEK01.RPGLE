**FREE

/if defined(internal_prototype)
dcl-pr peek01 extpgm('PEEK01');
/else
dcl-pr peek01 extpgm(peek01_name);
/endif
  i_qfile                            const likeds(qobj_t);
  i_rcdfmt                           const like(fmt_t);
  o_rcdfmtid                               like(fmtid_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;

