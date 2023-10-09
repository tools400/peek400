**FREE

/if defined(internal_prototype)
dcl-pr peek69 extpgm('PEEK69');
/else
dcl-pr peek69 extpgm(peek69_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  o_qfile                                  like(qobj_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
