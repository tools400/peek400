**FREE

/if defined(internal_prototype)
dcl-pr peek16 extpgm('PEEK16');
/else
dcl-pr peek16 extpgm(peek16_name);
/endif
  i_prodlib                          const like(lib_t);
  i_qfile                            const likeds(qobj_t);
  i_rcdfmt                           const like(rcdfmt_t);
  i_scnnbrs                          const like(int2_t);
  i_alwlc                            const like(bool_t);
  i_case                             const like(bool_t);
  i_rcdlock                          const like(bool_t);
  i_nulldft                          const like(bool_t);
  i_keepcrs                          const like(bool_t);
  io_stage                                 like(int4_t);
  i_numpasses                        const like(int4_t);
end-pr;
