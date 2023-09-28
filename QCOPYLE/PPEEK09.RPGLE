      *
      /if defined(internal_prototype)
     D PEEK09          PR                  extpgm('PEEK09')
      /else
     D PEEK09          PR                  extpgm(PEEK09_NAME)
      /endif
     D  i_qFile                            const likeds(qObj_t)
     D  o_data                                   likeds(OBJD0400_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
