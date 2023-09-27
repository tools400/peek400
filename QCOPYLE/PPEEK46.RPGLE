
      /if defined(internal_prototype)
     D PEEK46          PR                  extpgm('PEEK46')
      /else
     D PEEK46          PR                  extpgm(PEEK46_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  i_mbr                              const like(r§mbr)
     D  i_funk                             const like(r§option)
     D  o_anz                                    like(r§int4)
     D  o_mbrl0200                               likeds(MBRL0200_t)
      *
