
      /if defined(internal_prototype)
     D PEEK69          PR                  extpgm('PEEK69')
      /else
     D PEEK69          PR                  extpgm(PEEK69_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  o_qFile                                  like(qObj_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
