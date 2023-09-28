      *
      /if defined(internal_prototype)
     D PEEK05          PR                  extpgm('PEEK05')
      /else
     D PEEK05          PR                  extpgm(PEEK05_NAME)
      /endif
     D  io_qFile                                 likeds(qObj_t)
     D  i_member                           const like(mbr_t)
     D  i_access                           const like(accessMode_t)
     D  i_prodlib                          const like(lib_t)
     D  i_chgLib                           const like(bool_t)
     D  i_chgFile                          const like(bool_t)
     D  i_chgMbr                           const like(bool_t)
     D  i_updModKey                        const like(bool_t)
     D  i_chgSqlW                          const like(bool_t)
     D  i_chgSqlO                          const like(bool_t)
     D  i_qEnvFile                         const likeds(qObj_t)
     D  i_envMbr                           const like(mbr_t)
     D  i_envSave                          const like(bool_t)
     D  i_envLayout                        const like(bool_t)
     D  i_sqlWhere                         const like(sqlWhere_t)
     D  i_sqlOrder                         const like(sqlOrder_t)
      *
