**FREE

/if defined(internal_prototype)
dcl-pr peek30 extpgm('PEEK30');
/else
dcl-pr peek30 extpgm(peek30_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  o_flag                                   like(int4_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
