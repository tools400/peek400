**FREE

/if defined(internal_prototype)
dcl-pr peek70 extpgm('PEEK70');
/else
dcl-pr peek70 extpgm(peek70_name);
/endif
  i_qfile                            const likeds(qobj_t);
  i_function                         const like(function_t);
  o_nume                                   like(int4_t);
  o_objl0200                               likeds(objl0200_t);
end-pr;
