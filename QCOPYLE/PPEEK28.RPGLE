
      /if defined(internal_prototype)
     D PEEK28          PR                  extpgm('PEEK28')
      /else
     D PEEK28          PR                  extpgm(PEEK28_NAME)
      /endif
     D  i_attr                             const like(r§attr)
     D  i_noMsg                            const like(r§bool)
     D  o_attrLen                                like(r§int4)
     D  o_attrType                               like(r§attrType)
     D  o_attrValue                              like(r§attrValue)
      *
