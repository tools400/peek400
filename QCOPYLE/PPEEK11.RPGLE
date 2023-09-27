                                                                                     *
      /if defined(internal_prototype)
     D PEEK11          PR                  extpgm('PEEK11')
      /else
     D PEEK11          PR                  extpgm(PEEK11_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  i_function                         const like(r§function)
     D  o_numE                                   like(r§int4)
     D  o_rcdl0200                               likeds(rcdl0200_t)
      *
