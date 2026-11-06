**free

/if defined(internal_prototype)
dcl-pr peek39 extpgm('PEEK39');
/else
dcl-pr peek39 extpgm(peek39_name);
/endif
  i_qfile    like(qobj_t) const;
  i_mbr      like(mbr_t) const;
  i_function like(function_t) const;
  o_nume     like(int4_t);
  o_dbrl0200 likeds(dbrl0200_t);
end-pr;
