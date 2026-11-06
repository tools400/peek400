**free

/if defined(internal_prototype)
dcl-pr peek11 extpgm('PEEK11');
/else
dcl-pr peek11 extpgm(peek11_name);
/endif
  i_qfile    likeds(qobj_t) const;
  i_function like(function_t) const;
  o_nume     like(int4_t);
  o_rcdl0200 likeds(rcdl0200_t);
end-pr;
