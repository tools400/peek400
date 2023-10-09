**FREE

/if defined(internal_prototype)
dcl-pr peek28 extpgm('PEEK28');
/else
dcl-pr peek28 extpgm(peek28_name);
/endif
  i_attr                             const like(attr_t);
  i_nomsg                            const like(bool_t);
  o_attrlen                                like(int4_t);
  o_attrtype                               like(attrtype_t);
  o_attrvalue                              like(attrvalue_t);
end-pr;
