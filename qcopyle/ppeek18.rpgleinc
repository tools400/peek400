**free

/if defined(internal_prototype)
dcl-pr peek18 extpgm('PEEK18');
/else
dcl-pr peek18 extpgm(peek18_name);
/endif
  i_fldl0100  likeds(fldl0100_t) const;
  i_rcdFmt    like(fmt_t) const;
  i_buffer    like(rcdBuf_t);
  i_tgtFormat like(format_t) const;
  i_tgtValue  like(format_t) const;
  o_buffer    like(rcdBuf_t);
  o_buffLen   like(int4_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pr;
