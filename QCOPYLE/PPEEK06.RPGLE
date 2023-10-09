**FREE

/if defined(internal_prototype)
dcl-pr peek06 extpgm('PEEK06');
/else
dcl-pr peek06 extpgm(peek06_name);
/endif
  i_fldl0100                         const likeds(fldl0100_t);
  i_rcdfmt                           const like(fmt_t);
  i_srcvar                           const like(rcdbuf_t);
  i_qcmdexc                          const like(bool_t);
  i_cvtccsid                         const like(bool_t);
  o_string                                 like(rcdbuf_t);
  o_strlen                                 like(int4_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
