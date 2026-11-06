**free

/if defined(internal_prototype)
dcl-pr peek04 extpgm('PEEK04');
/else
dcl-pr peek04 extpgm(peek04_name);
/endif
  i_qfile  likeds(qobj_t) const;
  i_rcdfmt like(fmt_t) const;
  o_msgid  like(msgid_t);
  o_msgdta like(msgdta_t);
end-pr;
