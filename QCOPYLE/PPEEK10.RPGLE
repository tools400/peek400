                                                                                     *
      /if defined(internal_prototype)
     D PEEK10          PR                  extpgm('PEEK10')
      /else
     D PEEK10          PR                  extpgm(PEEK10_NAME)
      /endif
     D  i_qFile                            const likeds(qObj_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
