                                                                                     *
      /if defined(internal_prototype)
     D PEEK13          PR                  extpgm('PEEK13')
      /else
     D PEEK13          PR                  extpgm(PEEK13_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  i_mbr                              const like(r§mbr)
     D  o_mbrd0200                               likeds(MBRD0200_t)
      *
