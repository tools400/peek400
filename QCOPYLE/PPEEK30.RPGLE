
      /if defined(internal_prototype)
     D PEEK30          PR                  extpgm('PEEK30')
      /else
     D PEEK30          PR                  extpgm(PEEK30_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  o_flag                                   like(r§int4)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
