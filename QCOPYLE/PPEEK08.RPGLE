**FREE

/if defined(internal_prototype)
dcl-pr peek08 extpgm('PEEK08');
/else
dcl-pr peek08 extpgm(peek08_name);
/endif
  i_qfile                            const like(qobj_t);
  i_pgm                              const like(pgm_t);
  i_rcdfmt                           const like(rcdfmt_t);
  i_fmtid                            const like(fmtid_t);
  i_alwlc                            const like(bool_t);
  i_case                             const like(bool_t);
  i_rcdlock                          const like(bool_t);
  i_nulldft                          const like(bool_t);
  i_keepcrs                          const like(bool_t);
  i_prodlib                          const like(lib_t);
  o_iserror                                like(bool_t);
end-pr;
