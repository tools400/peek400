
      /if defined(internal_prototype)
     D PEEK46          PR                  extpgm('PEEK46')
      /else
     D PEEK46          PR                  extpgm(PEEK46_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  i_mbr                              const like(r§mbr)
     D  i_function                         const like(r§function)
     D  o_numE                                   like(r§int4)
     D  o_mbrl0200                               likeds(mbrl0200_t)
      *
