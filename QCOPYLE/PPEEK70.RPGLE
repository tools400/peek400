
      /if defined(internal_prototype)
     D PEEK70          PR                  extpgm('PEEK70')
      /else
     D PEEK70          PR                  extpgm(PEEK70_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  i_funk                             const like(r§option)
     D  o_anz                                    like(r§int4)
     D  o_objl0200                               likeds(objl0200_t)
      *
