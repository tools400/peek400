
      /if defined(internal_prototype)
     D PEEK42          PR                  extpgm('PEEK42')
      /else
     D PEEK42          PR                  extpgm(PEEK42_NAME)
      /endif
     D  i_file                             const like(r§file)
     D  i_library                          const like(r§lib)
     D  i_member                           const like(r§mbr)
     D  i_rcdFormat                        const like(r§fmt)
     D  i_shortCmd                         const like(ShortCmd_t)
     D  i_rcdNbr                           const like(r§rcdNbr)
     D  o_execCmd                                like(r§cmdBuffer)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
