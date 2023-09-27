      *
      /if defined(internal_prototype)
     D PEEK05          PR                  extpgm('PEEK05')
      /else
     D PEEK05          PR                  extpgm(PEEK05_NAME)
      /endif
     D  io_qFile                                 likeds(r§qObj)
     D  i_member                           const like(r§mbr)
     D  i_access                           const like(r§accessMode)
     D  i_prodlib                          const like(r§lib)
     D  i_chgLib                           const like(r§bool)
     D  i_chgFile                          const like(r§bool)
     D  i_chgMbr                           const like(r§bool)
     D  i_updModKey                        const like(r§bool)
     D  i_chgSqlW                          const like(r§bool)
     D  i_chgSqlO                          const like(r§bool)
     D  i_qEnvFile                         const likeds(r§qObj)
     D  i_envMbr                           const like(r§mbr)
     D  i_envSave                          const like(r§bool)
     D  i_envLayout                        const like(r§bool)
     D  i_sqlWhere                         const like(r§sqlWhere)
     D  i_sqlOrder                         const like(r§sqlOrder)
      *
