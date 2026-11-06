**free

/if defined(internal_prototype)
dcl-pr peek12 extpgm('PEEK12');
/else
dcl-pr peek12 extpgm(peek12_name);
/endif
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  i_fmtName   like(fmt_t) const;
  i_fmtMode   like(mode_t) const;
  o_rcdl0200  likeds(rcdl0200_t);
  o_fmtNbr    like(int2_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pr;
