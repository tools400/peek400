
      /if defined(internal_prototype)
     D PEEK50          PR                  extpgm('PEEK50')
      /else
     D PEEK50          PR                  extpgm(PEEK50_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  io_pinTabC                               like(r§fieldNme) dim(12)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
