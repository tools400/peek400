**free

/if defined(internal_prototype)
dcl-pr peek24 extpgm('PEEK24');
/else
dcl-pr peek24 extpgm(peek24_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  o_set0001   likeds(set0001_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
