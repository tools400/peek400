
      /if defined(internal_prototype)
     D PEEK50          PR                  extpgm('PEEK50')
      /else
     D PEEK50          PR                  extpgm(PEEK50_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  io_pinTabC                               like(fieldNme_t) dim(12)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
