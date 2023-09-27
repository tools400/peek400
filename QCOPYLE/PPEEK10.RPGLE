                                                                                     *
      /if defined(internal_prototype)
     D PEEK10          PR                  extpgm('PEEK10')
      /else
     D PEEK10          PR                  extpgm(PEEK10_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
