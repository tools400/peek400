
      /if defined(internal_prototype)
     D PEEK32          PR                  extpgm('PEEK32')
      /else
     D PEEK32          PR                  extpgm(PEEK32_NAME)
      /endif
     D  io_buffer                                likeds(rcdBuffer_t)
     D  i_buffLen                          const like(int4_t)
     D  i_ccsid                            const like(int4_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
