**FREE

/if defined(internal_prototype)
dcl-pr peek47 extpgm('PEEK47');
/else
dcl-pr peek47 extpgm(peek47_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  i_qfile                            const likeds(qobj_t);
  i_mbr                                    like(mbr_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
