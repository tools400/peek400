
      /if defined(internal_prototype)
     D PEEK39          PR                  extpgm('PEEK39')
      /else
     D PEEK39          PR                  extpgm(PEEK39_NAME)
      /endif
     D  i_qFile                            const like(qObj_t)
     D  i_mbr                              const like(mbr_t)
     D  i_function                         const like(function_t)
     D  o_numE                                   like(int4_t)
     D  o_dbrl0200                               likeds(dbrl0200_t)
      *
