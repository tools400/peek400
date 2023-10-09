**FREE

/if defined(internal_prototype)
dcl-pr peek40 extpgm('PEEK40');
/else
dcl-pr peek40 extpgm(peek40_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  i_file                             const like(file_t);
  ib                                 const like(lib_t);
  i_mbr                              const like(mbr_t);
  i_rcdfmt                           const like(fmt_t);
  i_basephyf                         const like(bool_t);
  o_file                                   like(file_t);
  o_lib                                    like(lib_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
