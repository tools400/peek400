      *
      /if defined(internal_prototype)
     D PEEK08          PR                  extpgm('PEEK08')
      /else
     D PEEK08          PR                  extpgm(PEEK08_NAME)
      /endif
     D  i_qFile                            const like(qObj_t)
     D  i_pgm                              const like(pgm_t)
     D  i_rcdFmt                           const like(rcdFmt_t)
     D  i_fmtId                            const like(fmtid_t)
     D  i_alwLC                            const like(bool_t)
     D  i_case                             const like(bool_t)
     D  i_rcdLock                          const like(bool_t)
     D  i_nullDft                          const like(bool_t)
     D  i_keepCrs                          const like(bool_t)
     D  i_prodLib                          const like(lib_t)
     D  o_isError                                like(bool_t)
      *
