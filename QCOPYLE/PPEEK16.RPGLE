      *
      /if defined(internal_prototype)
     D PEEK16          PR                  extpgm('PEEK16')
      /else
     D PEEK16          PR                  extpgm(PEEK16_NAME)
      /endif
     D  i_prodLib                          const like(r§lib)
     D  i_qFile                            const likeds(r§qObj)
     D  i_rcdFmt                           const like(r§rcdFmt)
     D  i_scnNbrs                     2P 0 const
     D  i_alwLC                            const like(r§bool)
     D  i_case                             const like(r§bool)
     D  i_rcdLock                          const like(r§bool)
     D  i_nullDft                          const like(r§bool)
     D  i_keepCrs                          const like(r§bool)
     D  io_stage                                 like(r§int4)
     D  i_numPasses                        const like(r§int4)
      *
