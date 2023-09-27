                                                                                     *
      /if defined(internal_prototype)
     D PEEK20          PR                  extpgm('PEEK20')
      /else
     D PEEK20          PR                  extpgm(PEEK20_NAME)
      /endif
     D  i_keyVal                           const like(r§keyBuf)
     D  o_rcdBuffer                              like(r§rcdBuf)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
