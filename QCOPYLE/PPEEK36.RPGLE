**FREE

/if defined(internal_prototype)
dcl-pr peek36 extpgm('PEEK36');
/else
dcl-pr peek36 extpgm(peek36_name);
/endif
  i_buffer                           const like(smallBuffer_t);
  i_type                             const like(dataType_t);
  i_dattimfmt                        const like(fldl0100_t.f1dtfm);
  i_separator                        const like(fldl0100_t.f1dtsp);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
