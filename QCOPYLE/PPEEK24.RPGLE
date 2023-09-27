
      /if defined(internal_prototype)
     D PEEK24          PR                  extpgm('PEEK24')
      /else
     D PEEK24          PR                  extpgm(PEEK24_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  o_set0001                                likeds(SET0001)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
