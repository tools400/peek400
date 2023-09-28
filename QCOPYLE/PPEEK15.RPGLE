                                                                                     *
      /if defined(internal_prototype)
     D PEEK15          PR                  extpgm('PEEK15')
      /else
     D PEEK15          PR                  extpgm(PEEK15_NAME)
      /endif
     D  i_qFile                            const likeds(qObj_t)
     D  io_scnNbrs                    2P 0
     D  i_alwLC                            const like(bool_t)
     D  io_stage                                 like(int4_t)
     D  i_numPasses                        const like(int4_t)
      *
