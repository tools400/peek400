**free

/if defined(internal_prototype)
dcl-pr peek06 extpgm('PEEK06');
/else
dcl-pr peek06 extpgm(peek06_name);
/endif
  i_fldl0100 likeds(fldl0100_t) const;
  i_rcdfmt   like(fmt_t) const;
  i_srcvar   like(rcdbuf_t) const;
  i_qcmdexc  like(bool_t) const;
  i_cvtccsid like(bool_t) const;
  o_string   like(rcdbuf_t);
  o_strlen   like(int4_t);
  o_msgid    like(msgid_t);
  o_msgdta   like(msgdta_t);
end-pr;
