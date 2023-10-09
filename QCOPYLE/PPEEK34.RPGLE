**FREE

/if defined(internal_prototype)
dcl-pr peek34 extpgm('PEEK34');
/else
dcl-pr peek34 extpgm(peek34_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  i_function                         const like(option_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
