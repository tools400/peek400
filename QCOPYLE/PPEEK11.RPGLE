**FREE

/if defined(internal_prototype)
dcl-pr peek11 extpgm('PEEK11');
/else
dcl-pr peek11 extpgm(peek11_name);
/endif
  i_qfile                            const likeds(qobj_t);
  i_function                         const like(function_t);
  o_nume                                   like(int4_t);
  o_rcdl0200                               likeds(rcdl0200_t);
end-pr;
