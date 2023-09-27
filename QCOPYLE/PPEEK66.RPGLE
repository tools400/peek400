
      /if defined(internal_prototype)
     D PEEK66          PR                  extpgm('PEEK66')
      /else
     D PEEK66          PR                  extpgm(PEEK66_NAME)
      /endif
     D  io_buffer                                like(r§cmdBuffer)
     D  io_length                                like(r§int4)
     D  i_inFormat                         const likeds(FLDL0100_t)
     D  i_outFormat                        const likeds(FLDL0100_t)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
