
      /if defined(internal_prototype)
     D PEEK48          PR                  extpgm('PEEK48')
      /else
     D PEEK48          PR                  extpgm(PEEK48_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  io_file                                  like(r§file)
     D  io_library                               like(r§lib)
     D  io_member                                like(r§mbr)
     D  io_rcdFmt                                like(r§fmt)
     D  i_accessMode                       const like(r§accessMode)
     D  io_sqlWhere                              like(r§sqlWhere)
     D  io_sqlOrder                              like(r§sqlOrder)
     D  i_enableWhere                      const like(r§bool)
     D  i_enableOrder                      const like(r§bool)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
