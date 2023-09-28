
      /if defined(internal_prototype)
     D PEEK46          PR                  extpgm('PEEK46')
      /else
     D PEEK46          PR                  extpgm(PEEK46_NAME)
      /endif
     D  i_qFile                            const likeds(qObj_t)
     D  i_mbr                              const like(mbr_t)
     D  i_function                         const like(function_t)
     D  o_numE                                   like(int4_t)
     D  o_mbrl0200                               likeds(mbrl0200_t)
      *
