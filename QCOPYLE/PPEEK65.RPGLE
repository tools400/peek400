
      /if defined(internal_prototype)
     D PEEK65          PR                  extpgm('PEEK65')
      /else
     D PEEK65          PR                  extpgm(PEEK65_NAME)
      /endif
     D  i_rcdNbr                           const like(rcdNbr_t)
     D  i_file                             const like(file_t)
     D  i_library                          const like(lib_t)
     D  i_member                           const like(mbr_t)
     D  i_rcdFormat                        const like(rcdFmt_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
