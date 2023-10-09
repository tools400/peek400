**FREE

/if defined(internal_prototype)
dcl-pr peek24 extpgm('PEEK24');
/else
dcl-pr peek24 extpgm(peek24_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  o_set0001                                likeds(set0001);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
