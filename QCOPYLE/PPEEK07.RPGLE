      *
      /if defined(internal_prototype)
     D PEEK07          PR                  extpgm('PEEK07')
      /else
     D PEEK07          PR                  extpgm(PEEK07_NAME)
      /endif
     D  i_attr                             const like(attr_t)
     D  i_noMsg                            const like(bool_t)
     D  o_attrLen                                like(int4_t)
     D  o_attrTyp                                like(attrType_t)
     D  o_alue                                   like(attrValue_t)
      *
