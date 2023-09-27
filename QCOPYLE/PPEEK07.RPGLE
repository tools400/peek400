      *
      /if defined(internal_prototype)
     D PEEK07          PR                  extpgm('PEEK07')
      /else
     D PEEK07          PR                  extpgm(PEEK07_NAME)
      /endif
     D  i_attr                             const like(r§attr)
     D  i_noMsg                            const like(r§bool)
     D  o_attrLen                                like(r§int4)
     D  o_attrTyp                                like(r§attrType)
     D  o_alue                                   like(r§attrValue)
      *
