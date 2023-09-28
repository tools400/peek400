      *
      /if defined(internal_prototype)
     D PEEK16          PR                  extpgm('PEEK16')
      /else
     D PEEK16          PR                  extpgm(PEEK16_NAME)
      /endif
     D  i_prodLib                          const like(lib_t)
     D  i_qFile                            const likeds(qObj_t)
     D  i_rcdFmt                           const like(rcdFmt_t)
     D  i_scnNbrs                     2P 0 const
     D  i_alwLC                            const like(bool_t)
     D  i_case                             const like(bool_t)
     D  i_rcdLock                          const like(bool_t)
     D  i_nullDft                          const like(bool_t)
     D  i_keepCrs                          const like(bool_t)
     D  io_stage                                 like(int4_t)
     D  i_numPasses                        const like(int4_t)
      *
