**free

/if defined(internal_prototype)
dcl-pr peek25 extpgm('PEEK25');
/else
dcl-pr peek25 extpgm(peek25_name);
/endif
  i_dsp80     like(dsp80_t) const;
  o_colorattr like(color_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
