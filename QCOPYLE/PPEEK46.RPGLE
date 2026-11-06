**free

/if defined(internal_prototype)
dcl-pr peek46 extpgm('PEEK46');
/else
dcl-pr peek46 extpgm(peek46_name);
/endif
  i_qfile    likeds(qobj_t) const;
  i_mbr      like(mbr_t) const;
  i_function like(function_t) const;
  o_nume     like(int4_t);
  o_mbrl0200 likeds(mbrl0200_t);
end-pr;
