**FREE

/if defined(internal_prototype)
dcl-pr peek55 extpgm('PEEK55');
/else
dcl-pr peek55 extpgm(peek55_name);
/endif
  gi_file                            const like(file_t);
  gi_lib                             const like(lib_t);
  gi_mbr                             const like(mbr_t);
  gi_rcdfmt                          const like(fmt_t);
  gi_rcdfmtid                        const like(fmtid_t);
  gi_envfile                         const like(file_t);
  gi_envlib                          const like(lib_t);
  gi_envmbr                          const like(mbr_t);
  gi_option                          const like(option_t);
  go_pintabr                               like(pintabr_t) dim(12);
  go_nbrpinr                               like(int4_t);
  go_pintabc                               like(fieldnme_t) dim(12);
  go_nbrpinc                               like(int4_t);
  go_file                                  like(file_t);
  go_lib                                   like(lib_t);
  go_mbr                                   like(mbr_t);
  go_rcdfmt                                like(fmt_t);
  go_accmode                               like(accessmode_t);
  go_sqlsel                                like(sqlwhere_t);
  go_sqlord                                like(sqlorder_t);
  go_iskeylower                            like(bool_t);
  go_msgid                                 like(msgid_t);
  go_msgdta                                like(msgdta_t);
end-pr;
