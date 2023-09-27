
      /if defined(internal_prototype)
     D PEEK68          PR                  extpgm('PEEK68')
      /else
     D PEEK68          PR                  extpgm(PEEK68_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_pgm                              const like(r§pgm)
     D  i_copyright                        const like(r§copyRght)
     D  o_sflOpt                      2A
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
