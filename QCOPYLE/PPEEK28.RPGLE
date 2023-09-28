
      /if defined(internal_prototype)
     D PEEK28          PR                  extpgm('PEEK28')
      /else
     D PEEK28          PR                  extpgm(PEEK28_NAME)
      /endif
     D  i_attr                             const like(attr_t)
     D  i_noMsg                            const like(bool_t)
     D  o_attrLen                                like(int4_t)
     D  o_attrType                               like(attrType_t)
     D  o_attrValue                              like(attrValue_t)
      *
