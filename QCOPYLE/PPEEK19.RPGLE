                                                                                     *
      /if defined(internal_prototype)
     D PEEK19          PR                  extpgm('PEEK19')
      /else
     D PEEK19          PR                  extpgm(PEEK19_NAME)
      /endif
     D  i_rcdBuffer                        const like(r§rcdBuf)
     D  o_keyVal                                 like(r§keyBuf)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
