                                                                                     *
      /if defined(internal_prototype)
     D PEEK18          PR                  extpgm('PEEK18')
      /else
     D PEEK18          PR                  extpgm(PEEK18_NAME)
      /endif
     D  i_fldl0100                         const likeds(FLDL0100_t)
     D  i_rcdFmt                           const like(r§fmt)
     D  i_buffer                                 like(r§rcdBuf)
     D  i_tgtFormat                  10A   const
     D  i_tgtValue                   10A   const
     D  o_buffer                                 like(r§rcdBuf)
     D  o_buffLen                                like (r§int4)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
