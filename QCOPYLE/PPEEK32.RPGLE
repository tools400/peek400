
      /if defined(internal_prototype)
     D PEEK32          PR                  extpgm('PEEK32')
      /else
     D PEEK32          PR                  extpgm(PEEK32_NAME)
      /endif
     D  io_buffer                                likeds(rcdBuffer_t)
     D  i_buffLen                          const like(r§int4)
     D  i_ccsid                            const like(r§int4)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
