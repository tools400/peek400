
      /if defined(internal_prototype)
     D PEEK60          PR                  extpgm('PEEK60')
      /else
     D PEEK60          PR                  extpgm(PEEK60_NAME)
      /endif
     D  i_alwLC                            const like(r§bool)
     D  o_numPasses                              like(r§int4)
      *
