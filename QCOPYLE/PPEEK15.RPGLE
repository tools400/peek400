                                                                                     *
      /if defined(internal_prototype)
     D PEEK15          PR                  extpgm('PEEK15')
      /else
     D PEEK15          PR                  extpgm(PEEK15_NAME)
      /endif
     D  i_qFile                            const likeds(r§qObj)
     D  io_scnNbrs                    2P 0
     D  i_alwLC                            const like(r§bool)
     D  io_stage                                 like(r§int4)
     D  i_numPasses                        const like(r§int4)
      *
