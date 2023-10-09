**FREE

/if defined(internal_prototype)
dcl-pr peek18 extpgm('PEEK18');
/else
dcl-pr peek18 extpgm(peek18_name);
/endif
  i_fldl0100                         const likeds(fldl0100_t);
  i_rcdfmt                           const like(fmt_t);
  i_buffer                                 like(rcdbuf_t);
  i_tgtformat                        const like(format_t);
  i_tgtvalue                         const like(format_t);
  o_buffer                                 like(rcdbuf_t);
  o_bufflen                                like(int4_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
