                                                                                     *
      /if defined(internal_prototype)
     D PEEK20          PR                  extpgm('PEEK20')
      /else
     D PEEK20          PR                  extpgm(PEEK20_NAME)
      /endif
     D  i_keyVal                           const like(keyBuf_t)
     D  o_rcdBuffer                              like(rcdBuf_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
