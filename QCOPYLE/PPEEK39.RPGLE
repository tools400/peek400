
      /if defined(internal_prototype)
     D PEEK39          PR                  extpgm('PEEK39')
      /else
     D PEEK39          PR                  extpgm(PEEK39_NAME)
      /endif
     D  i_qFile                            const like(r§qObj)
     D  i_mbr                              const like(r§mbr)
     D  i_function                         const like(r§function)
     D  o_numE                                   like(r§int4)
     D  o_dbrl0200                               likeds(dbrl0200_t)
      *
