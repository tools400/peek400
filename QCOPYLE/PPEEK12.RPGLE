**free

/if defined(internal_prototype)
dcl-pr peek12 extpgm('PEEK12');
/else
dcl-pr peek12 extpgm(peek12_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  i_fmtname   like(fmt_t) const;
  i_fmtmode   like(mode_t) const;
  o_rcdl0200  likeds(rcdl0200_t);
  o_fmtnbr    like(int2_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
