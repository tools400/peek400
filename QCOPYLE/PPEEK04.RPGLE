      *
      /if defined(internal_prototype)
     D PEEK04          PR                  extpgm('PEEK04')
      /else
     D PEEK04          PR                  extpgm(PEEK04_NAME)
      /endif
     D  i_qFile                            const likeds(qObj_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  o_msgID                                  like(msgId_t)
     D  o_msgDta                                 like(msgDta_t)
      *
