
      /if defined(internal_prototype)
     D PEEK42          PR                  extpgm('PEEK42')
      /else
     D PEEK42          PR                  extpgm(PEEK42_NAME)
      /endif
     D  i_file                             const like(file_t)
     D  i_library                          const like(lib_t)
     D  i_member                           const like(mbr_t)
     D  i_rcdFormat                        const like(fmt_t)
     D  i_shortCmd                         const like(ShortCmd_t)
     D  i_rcdNbr                           const like(rcdNbr_t)
     D  o_execCmd                                like(cmdBuffer_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
