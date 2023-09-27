      *
      /if defined(internal_prototype)
     D PEEK09          PR                  extpgm('PEEK09')
      /else
     D PEEK09          PR                  extpgm(PEEK09_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  o_data                                   likeds(OBJD0400_t)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
