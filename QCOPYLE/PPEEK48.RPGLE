**FREE

/if defined(internal_prototype)
dcl-pr peek48 extpgm('PEEK48');
/else
dcl-pr peek48 extpgm(peek48_name);
/endif
  i_dsp80                            const like(dsp80_t);
  i_copyright                        const like(copyrght_t);
  io_file                                  like(file_t);
  io_library                               like(lib_t);
  io_member                                like(mbr_t);
  io_rcdfmt                                like(fmt_t);
  i_accessmode                       const like(accessmode_t);
  io_sqlwhere                              like(sqlwhere_t);
  io_sqlorder                              like(sqlorder_t);
  i_enablewhere                      const like(bool_t);
  i_enableorder                      const like(bool_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
