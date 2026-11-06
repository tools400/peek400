**free

/if defined(internal_prototype)
dcl-pr peek28 extpgm('PEEK28');
/else
dcl-pr peek28 extpgm(peek28_name);
/endif
  i_attr      like(attr_t) const;
  i_nomsg     like(bool_t) const;
  o_attrlen   like(int4_t);
  o_attrtype  like(attrtype_t);
  o_attrvalue like(attrvalue_t);
end-pr;
