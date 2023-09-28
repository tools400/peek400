      *
      /if defined(internal_prototype)
     D PEEK06          PR                  extpgm('PEEK06')
      /else
     D PEEK06          PR                  extpgm(PEEK06_NAME)
      /endif
     D  i_fldl0100                         const likeds(FLDL0100_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  i_srcVar                           const like(rcdBuf_t)
     D  i_qcmdexc                     1A   const
     D  i_cvtCcsid                    1A   const
     D  o_string                                 like(rcdBuf_t)
     D  o_strLen                                 like(int4_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
