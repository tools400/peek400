**FREE

/if defined(internal_prototype)
dcl-pr peek54 extpgm('PEEK54');
/else
dcl-pr peek54 extpgm(peek54_name);
/endif
  gi_file                            const like(file_t);
  gi_lib                             const like(lib_t);
  gi_mbr                             const like(mbr_t);
  gi_rcdfmt                          const like(fmt_t);
  gi_rcdfmtid                        const like(fmtid_t);
  gi_envfile                         const like(file_t);
  gi_envlib                          const like(lib_t);
  gi_envmbr                          const like(mbr_t);
  gi_isautosave                      const like(bool_t);
  gi_pintabr                         const like(pintabr_t) dim(12);
  gi_nbrpinr                         const like(int4_t);
  gi_pintabc                         const like(fieldnme_t) dim(12);
  gi_nbrpinc                         const like(int4_t);
  gi_accmode                         const like(accessmode_t);
  gi_sqlsel                          const like(sqlwhere_t);
  gi_sqlord                          const like(sqlorder_t);
  gi_iskeylower                      const like(bool_t);
  go_msgid                                 like(msgid_t);
  go_msgdta                                like(msgdta_t);
end-pr;
