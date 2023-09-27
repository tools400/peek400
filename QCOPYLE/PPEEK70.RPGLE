
      /if defined(internal_prototype)
     D PEEK70          PR                  extpgm('PEEK70')
      /else
     D PEEK70          PR                  extpgm(PEEK70_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  i_function                         const like(r§function)
     D  o_numE                                   like(r§int4)
     D  o_objl0200                               likeds(objl0200_t)
      *
