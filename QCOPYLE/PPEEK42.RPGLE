**FREE

/if defined(internal_prototype)
dcl-pr peek42 extpgm('PEEK42');
/else
dcl-pr peek42 extpgm(peek42_name);
/endif
  i_file                             const like(file_t);
  i_library                          const like(lib_t);
  i_member                           const like(mbr_t);
  i_rcdformat                        const like(fmt_t);
  i_shortcmd                         const like(shortcmd_t);
  i_rcdnbr                           const like(rcdnbr_t);
  o_execcmd                                like(cmdbuffer_t);
  o_msgid                                  like(msgid_t);
  o_msgdta                                 like(msgdta_t);
end-pr;
