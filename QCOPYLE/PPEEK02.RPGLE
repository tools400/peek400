      *
      /if defined(internal_prototype)
     D PEEK02          PR                  extpgm('PEEK02')
      /else
     D PEEK02          PR                  extpgm(PEEK02_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  i_rcdFmt                           const like(r§fmt)
     D  i_option                           const like(r§option)
     D  o_count                                  like(r§int4)
     D  o_listE                                  likeds(FLDL0100_t)
     D  o_rcdFmtId                               like(r§fmtId)
      *
