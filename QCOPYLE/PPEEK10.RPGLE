**free

/if defined(internal_prototype)
dcl-pr peek10 extpgm('PEEK10');
/else
dcl-pr peek10 extpgm(peek10_name);
/endif
  i_qfile  likeds(qobj_t) const;
  o_msgid  like(msgid_t);
  o_msgdta like(msgdta_t);
end-pr;
