**free

/if defined(internal_prototype)
dcl-pr peek01 extpgm('PEEK01');
/else
dcl-pr peek01 extpgm(peek01_name);
/endif
  i_qfile    likeds(qobj_t) const;
  i_rcdfmt   like(fmt_t) const;
  o_rcdfmtid like(fmtid_t);
  o_msgid    like(msgid_t);
  o_msgdta   like(msgdta_t);
end-pr;

