
      /if defined(internal_prototype)
     D PEEK34          PR                  extpgm('PEEK34')
      /else
     D PEEK34          PR                  extpgm(PEEK34_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_function                         const like(option_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
