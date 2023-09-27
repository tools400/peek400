
      /if defined(internal_prototype)
     D PEEK25          PR                  extpgm('PEEK25')
      /else
     D PEEK25          PR                  extpgm(PEEK25_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  o_colorAttr                   1A
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
