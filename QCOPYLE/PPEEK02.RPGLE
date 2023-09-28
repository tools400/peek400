      *
      /if defined(internal_prototype)
     D PEEK02          PR                  extpgm('PEEK02')
      /else
     D PEEK02          PR                  extpgm(PEEK02_NAME)
      /endif
     D  i_qFile                            const likeds(qObj_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  i_function                         const like(function_t)
     D  o_numE                                   like(int4_t)
     D  o_fldl0100                               likeds(FLDL0100_t)
     D  o_rcdFmtId                               like(fmtId_t)
      *
