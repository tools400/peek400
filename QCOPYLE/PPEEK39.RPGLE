**FREE

/if defined(internal_prototype)
dcl-pr peek39 extpgm('PEEK39');
/else
dcl-pr peek39 extpgm(peek39_name);
/endif
  i_qfile                            const like(qobj_t);
  i_mbr                              const like(mbr_t);
  i_function                         const like(function_t);
  o_nume                                   like(int4_t);
  o_dbrl0200                               likeds(dbrl0200_t);
end-pr;
