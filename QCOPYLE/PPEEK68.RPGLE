
      /if defined(internal_prototype)
     D PEEK68          PR                  extpgm('PEEK68')
      /else
     D PEEK68          PR                  extpgm(PEEK68_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_pgm                              const like(pgm_t)
     D  i_copyright                        const like(copyRght_t)
     D  o_sflOpt                      2A
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
