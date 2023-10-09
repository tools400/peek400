**FREE

/if defined(internal_prototype)
dcl-pr peek50 extpgm('PEEK50');
/else
dcl-pr peek50 extpgm(peek50_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  io_pintabc                               like(fieldnme_t) dim(12);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
