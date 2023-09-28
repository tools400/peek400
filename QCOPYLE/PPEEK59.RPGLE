
      /if defined(internal_prototype)
     D PEEK59          PR                  extpgm('PEEK59')
      /else
     D PEEK59          PR                  extpgm(PEEK59_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_type                             const like(type_t)
     D  i_msgID                            const like(msgID_t)
     D  i_msgDta                           const like(msgDta_t)
     D  i_keys                        3A   const
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
