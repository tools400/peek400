      *
      /if defined(internal_prototype)
     D PEEK08          PR                  extpgm('PEEK08')
      /else
     D PEEK08          PR                  extpgm(PEEK08_NAME)
      /endif
     D  i_qFile                            const like(r§qObj)
     D  i_pgm                              const like(r§pgm)
     D  i_rcdFmt                           const like(r§rcdFmt)
     D  i_fmtId                            const like(r§fmtid)
     D  i_alwLC                            const like(r§bool)
     D  i_case                             const like(r§bool)
     D  i_rcdLock                          const like(r§bool)
     D  i_nullDft                          const like(r§bool)
     D  i_keepCrs                          const like(r§bool)
     D  i_prodLib                          const like(r§lib)
     D  o_isError                                like(r§bool)
      *
