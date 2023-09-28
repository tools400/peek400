                                                                                     *
      /if defined(internal_prototype)
     D PEEK19          PR                  extpgm('PEEK19')
      /else
     D PEEK19          PR                  extpgm(PEEK19_NAME)
      /endif
     D  i_rcdBuffer                        const like(rcdBuf_t)
     D  o_keyVal                                 like(keyBuf_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
