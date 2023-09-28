
      /if defined(internal_prototype)
     D PEEK25          PR                  extpgm('PEEK25')
      /else
     D PEEK25          PR                  extpgm(PEEK25_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  o_colorAttr                   1A
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
