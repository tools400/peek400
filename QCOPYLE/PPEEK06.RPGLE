      *
      /if defined(internal_prototype)
     D PEEK06          PR                  extpgm('PEEK06')
      /else
     D PEEK06          PR                  extpgm(PEEK06_NAME)
      /endif
     D  i_fldl0100                         const likeds(FLDL0100_t)
     D  i_rcdFmt                           const like(r§fmt)
     D  i_srcVar                           const like(r§rcdBuf)
     D  i_qcmdexc                     1A   const
     D  i_cvtCcsid                    1A   const
     D  o_string                                 like(r§rcdBuf)
     D  o_strLen                                 like(r§int4)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
