
      /if defined(internal_prototype)
     D PEEK59          PR                  extpgm('PEEK59')
      /else
     D PEEK59          PR                  extpgm(PEEK59_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_type                             const like(r§type)
     D  i_msgID                            const like(r§msgID)
     D  i_msgDta                           const like(r§msgDta)
     D  i_keys                        3A   const
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
