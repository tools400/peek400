**FREE

/if defined(internal_prototype)
dcl-pr peek57 extpgm('PEEK57');
/else
dcl-pr peek57 extpgm(peek57_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  i_envfile                          const like(file_t);
  i_envlib                           const like(lib_t);
  i_envmbr                           const like(mbr_t);
  i_envtext                          const like(text_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
