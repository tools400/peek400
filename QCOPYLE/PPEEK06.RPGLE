**free

/if defined(internal_prototype)
dcl-pr peek06 extpgm('PEEK06');
/else
dcl-pr peek06 extpgm(peek06_name);
/endif
  i_FLDL0100 likeds(fldl0100_t) const;
  i_rcdFmt   like(fmt_t) const;
  i_srcVar   like(rcdBuf_t) const;
  i_qcmdexc  like(bool_t) const;
  i_cvtCcsid like(bool_t) const;
  o_string   like(rcdBuf_t);
  o_strLen   like(int4_t);
  o_msgID    like(msgId_t);
  o_msgDta   like(msgDta_t);
end-pr;
