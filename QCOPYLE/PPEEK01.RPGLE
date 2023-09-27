      *
      /if defined(internal_prototype)
     D PEEK01          PR                  extpgm('PEEK01')
      /else
     D PEEK01          PR                  extpgm(PEEK01_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  i_rcdFmt                           const like(r§fmt)
     D  o_rcdFmtID                               like(r§fmtId)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
