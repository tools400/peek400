                                                                                     *
      /if defined(internal_prototype)
     D PEEK11          PR                  extpgm('PEEK11')
      /else
     D PEEK11          PR                  extpgm(PEEK11_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  i_funk                             const like(r§option)
     D  o_anz                                    like(r§int4)
     D  o_list                                   likeds(RCDL0200_t)
      *
