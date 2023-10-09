**FREE

/if defined(internal_prototype)
dcl-pr peek02 extpgm('PEEK02');
/else
dcl-pr peek02 extpgm(peek02_name);
/endif
  i_qfile                            const likeds(qobj_t);
  i_rcdfmt                           const like(fmt_t);
  i_function                         const like(function_t);
  o_nume                                   like(int4_t);
  o_fldl0100                               likeds(fldl0100_t);
  o_rcdfmtid                               like(fmtid_t);
end-pr;

