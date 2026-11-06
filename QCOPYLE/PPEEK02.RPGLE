**free

/if defined(internal_prototype)
dcl-pr peek02 extpgm('PEEK02');
/else
dcl-pr peek02 extpgm(peek02_name);
/endif
  i_qfile    likeds(qobj_t) const;
  i_rcdfmt   like(fmt_t) const;
  i_function like(function_t) const;
  o_nume     like(int4_t);
  o_fldl0100 likeds(fldl0100_t);
  o_rcdfmtid like(fmtid_t);
end-pr;

