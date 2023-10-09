**FREE

/if defined(internal_prototype)
dcl-pr peek56 extpgm('PEEK56');
/else
dcl-pr peek56 extpgm(peek56_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  i_mode                             const like(mode_t);
  i_envfile                          const like(file_t);
  i_envlib                           const like(lib_t);
  i_envmbr                           const like(mbr_t);
  i_rcdfmtid                         const like(fmtid_t);
  o_qfile                                  likeds(qobj_t);
  o_mbr                                    like(mbr_t);
  o_text                                   like(text_t);
  o_option                                 like(option_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
