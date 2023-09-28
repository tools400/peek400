                                                                                     *
      /if defined(internal_prototype)
     D PEEK18          PR                  extpgm('PEEK18')
      /else
     D PEEK18          PR                  extpgm(PEEK18_NAME)
      /endif
     D  i_fldl0100                         const likeds(FLDL0100_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  i_buffer                                 like(rcdBuf_t)
     D  i_tgtFormat                  10A   const
     D  i_tgtValue                   10A   const
     D  o_buffer                                 like(rcdBuf_t)
     D  o_buffLen                                like(int4_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
