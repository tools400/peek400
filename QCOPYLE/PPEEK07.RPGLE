**free

/if defined(internal_prototype)
dcl-pr peek07 extpgm('PEEK07');
/else
dcl-pr peek07 extpgm(peek07_name);
/endif
  i_attr    like(attr_t) const;
  i_nomsg   like(bool_t) const;
  o_attrlen like(int4_t);
  o_attrtyp like(attrtype_t);
  o_alue    like(attrvalue_t);
end-pr;
