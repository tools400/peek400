
      /if defined(internal_prototype)
     D PEEK29          PR                  extpgm('PEEK29')
      /else
     D PEEK29          PR                  extpgm(PEEK29_NAME)
      /endif
     D  i_sysName                     8A   const
     D  i_sysVersion                  6A   const
     D  i_sysSrlNbr                   8A   const
     D  i_sysDate                    10I 0 const
     D  o_serialNbr                  20A
      *
