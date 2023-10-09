**FREE

/if defined(internal_prototype)
dcl-pr peek46 extpgm('PEEK46');
/else
dcl-pr peek46 extpgm(peek46_name);
/endif
  i_qfile                            const likeds(qobj_t);
  i_mbr                              const like(mbr_t);
  i_function                         const like(function_t);
  o_nume                                   like(int4_t);
  o_mbrl0200                               likeds(mbrl0200_t);
end-pr;
