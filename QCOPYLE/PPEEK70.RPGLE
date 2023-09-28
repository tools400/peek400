
      /if defined(internal_prototype)
     D PEEK70          PR                  extpgm('PEEK70')
      /else
     D PEEK70          PR                  extpgm(PEEK70_NAME)
      /endif
     D  i_qFile                            const likeds(qObj_t)
     D  i_function                         const like(function_t)
     D  o_numE                                   like(int4_t)
     D  o_objl0200                               likeds(objl0200_t)
      *
