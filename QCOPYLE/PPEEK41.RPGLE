**FREE

/if defined(internal_prototype)
dcl-pr peek41 extpgm('PEEK41');
/else
dcl-pr peek41 extpgm(peek41_name);
/endif
  i_qfile                            const likeds(qobj_t);
  i_rcdfmt                           const like(fmt_t);
  i_function                         const like(function_t);
  o_nbrofent                               like(int4_t);
  o_data                                   char(512);
end-pr;

