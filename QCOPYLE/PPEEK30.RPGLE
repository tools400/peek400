
      /if defined(internal_prototype)
     D PEEK30          PR                  extpgm('PEEK30')
      /else
     D PEEK30          PR                  extpgm(PEEK30_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  o_flag                                   like(int4_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
