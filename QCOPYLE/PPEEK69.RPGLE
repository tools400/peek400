**free

/if defined(internal_prototype)
dcl-pr peek69 extpgm('PEEK69');
/else
dcl-pr peek69 extpgm(peek69_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  o_qfile     like(qobj_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
