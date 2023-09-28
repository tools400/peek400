                                                                                     *
      /if defined(internal_prototype)
     D PEEK11          PR                  extpgm('PEEK11')
      /else
     D PEEK11          PR                  extpgm(PEEK11_NAME)
      /endif
     D  i_qFile                            const likeds(qObj_t)
     D  i_function                         const like(function_t)
     D  o_numE                                   like(int4_t)
     D  o_rcdl0200                               likeds(rcdl0200_t)
      *
