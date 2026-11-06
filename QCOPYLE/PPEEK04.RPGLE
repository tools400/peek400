**free

/if defined(internal_prototype)
dcl-pr peek04 extpgm('PEEK04');
/else
dcl-pr peek04 extpgm(peek04_name);
/endif
  i_qFile  likeds(qObj_t) const;
  i_rcdFmt like(fmt_t) const;
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pr;
