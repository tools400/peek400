      *
      /if defined(internal_prototype)
     D PEEK01          PR                  extpgm('PEEK01')
      /else
     D PEEK01          PR                  extpgm(PEEK01_NAME)
      /endif
     D  i_qFile                            const likeds(qObj_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  o_rcdFmtID                               like(fmtId_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
