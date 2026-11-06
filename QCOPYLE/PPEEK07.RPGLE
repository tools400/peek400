**free

/if defined(internal_prototype)
dcl-pr peek07 extpgm('PEEK07');
/else
dcl-pr peek07 extpgm(peek07_name);
/endif
  i_attr    like(attr_t) const;
  i_noMsg   like(bool_t) const;
  o_attrLen like(int4_t);
  o_attrTyp like(attrType_t);
  o_alue    like(attrValue_t);
end-pr;
