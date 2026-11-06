**free

/if defined(internal_prototype)
dcl-pr peek50 extpgm('PEEK50');
/else
dcl-pr peek50 extpgm(peek50_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  io_pintabc  like(fieldnme_t) dim(12);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
