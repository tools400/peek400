**FREE

/if defined(internal_prototype)
dcl-pr peek03 extpgm('PEEK03');
/else
dcl-pr peek03 extpgm(peek03_name);
/endif
  i_qFile                            const likeds(qobj_t);
  i_rcdFmt                           const like(fmt_t);
  i_access                           const like(accessMode_t);
  i_sqlOrder                         const like(sqlOrder_t);
  o_msgId                                  like(msgid_t);
  o_msgDta                                 like(msgdta_t);
end-pr;
