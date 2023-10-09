**FREE

/if defined(internal_prototype)
dcl-pr peek65 extpgm('PEEK65');
/else
dcl-pr peek65 extpgm(peek65_name);
/endif
  i_rcdnbr                           const like(rcdnbr_t);
  i_file                             const like(file_t);
  i_library                          const like(lib_t);
  i_member                           const like(mbr_t);
  i_rcdformat                        const like(rcdfmt_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
