**free

/if defined(internal_prototype)
dcl-pr peek09 extpgm('PEEK09');
/else
dcl-pr peek09 extpgm(peek09_name);
/endif
  i_qfile  likeds(qobj_t) const;
  o_data   likeds(objd0400_t);
  o_msgid  like(msgid_t);
  o_msgdta like(msgdta_t);
end-pr;
