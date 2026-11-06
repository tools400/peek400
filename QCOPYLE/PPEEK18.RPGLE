**free

/if defined(internal_prototype)
dcl-pr peek18 extpgm('PEEK18');
/else
dcl-pr peek18 extpgm(peek18_name);
/endif
  i_fldl0100  likeds(fldl0100_t) const;
  i_rcdfmt    like(fmt_t) const;
  i_buffer    like(rcdbuf_t);
  i_tgtformat like(format_t) const;
  i_tgtvalue  like(format_t) const;
  o_buffer    like(rcdbuf_t);
  o_bufflen   like(int4_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pr;
