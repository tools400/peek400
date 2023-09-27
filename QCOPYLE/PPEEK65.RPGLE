
      /if defined(internal_prototype)
     D PEEK65          PR                  extpgm('PEEK65')
      /else
     D PEEK65          PR                  extpgm(PEEK65_NAME)
      /endif
     D  i_rcdNbr                           const like(r§rcdNbr)
     D  i_file                             const like(r§file)
     D  i_library                          const like(r§lib)
     D  i_member                           const like(r§mbr)
     D  i_rcdFormat                        const like(r§rcdFmt)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
