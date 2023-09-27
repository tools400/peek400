      *
      /if defined(internal_prototype)
     D PEEK04          PR                  extpgm('PEEK04')
      /else
     D PEEK04          PR                  extpgm(PEEK04_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  i_rcdFmt                           const like(r§fmt)
     D  o_msgID                                  like(r§msgId)
     D  o_msgDta                                 like(r§msgDta)
      *
