
      /if defined(internal_prototype)
     D PEEK39          PR                  extpgm('PEEK39')
      /else
     D PEEK39          PR                  extpgm(PEEK39_NAME)
      /endif
     D  i_qFile                            const like(r§qObj)
     D  i_mbr                              const like(r§mbr)
     D  i_funk                             const like(r§option)
     D  o_anz                                    like(r§int4)
     D  o_list                                   likeds(DBRL0200_t)
      *
