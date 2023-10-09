**FREE

/if defined(internal_prototype)
dcl-pr peek15 extpgm('PEEK15');
/else
dcl-pr peek15 extpgm(peek15_name);
/endif
  i_qfile                            const likeds(qobj_t);
  io_scnnbrs                               like(int2_t);
  i_alwlc                            const like(bool_t);
  io_stage                                 like(int4_t);
  i_numpasses                        const like(int4_t);
end-pr;
