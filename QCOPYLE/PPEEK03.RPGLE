      *
      /if defined(internal_prototype)
     D PEEK03          PR                  extpgm('PEEK03')
      /else
     D PEEK03          PR                  extpgm(PEEK03_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  i_rcdFmt                           const like(r§fmt)
     D  i_access                      1A   const
     D  i_sqlOrder                  512A   const
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
