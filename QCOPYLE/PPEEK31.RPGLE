
      /if defined(internal_prototype)
     D PEEK31          PR                  extpgm('PEEK31')
      /else
     D PEEK31          PR                  extpgm(PEEK31_NAME)
      /endif
     D  io_language                  10A
     D  i_prefix                     10A   const
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
