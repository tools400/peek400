
      /if defined(internal_prototype)
     D PEEK66          PR                  extpgm('PEEK66')
      /else
     D PEEK66          PR                  extpgm(PEEK66_NAME)
      /endif
     D  io_buffer                                like(cmdBuffer_t)
     D  io_length                                like(int4_t)
     D  i_inFormat                         const likeds(FLDL0100_t)
     D  i_outFormat                        const likeds(FLDL0100_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
