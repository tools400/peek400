      *
      /if defined(internal_prototype)
     D PEEK03          PR                  extpgm('PEEK03')
      /else
     D PEEK03          PR                  extpgm(PEEK03_NAME)
      /endif
     D  i_qFile                            const likeds(qObj_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  i_access                      1A   const
     D  i_sqlOrder                  512A   const
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
