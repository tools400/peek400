
      /if defined(internal_prototype)
     D PEEK24          PR                  extpgm('PEEK24')
      /else
     D PEEK24          PR                  extpgm(PEEK24_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  o_set0001                                likeds(SET0001)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
