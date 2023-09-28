                                                                                     *
      /if defined(internal_prototype)
     D PEEK13          PR                  extpgm('PEEK13')
      /else
     D PEEK13          PR                  extpgm(PEEK13_NAME)
      /endif
     D  i_qFile                            const likeds(qObj_t)
     D  i_mbr                              const like(mbr_t)
     D  o_mbrd0200                               likeds(MBRD0200_t)
      *
