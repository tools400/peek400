                                                                                     *
      /if defined(internal_prototype)
     D PEEK14          PR                  extpgm('PEEK14')
      /else
     D PEEK14          PR                  extpgm(PEEK14_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  io_headerType                            like(r§headerType)
     D  i_copyright                        const like(r§copyRght)
     D  i_rcdNbr                           const like(r§rcdNbr)
     D  i_file                             const like(r§file)
     D  i_lib                              const like(r§lib)
     D  i_mbr                              const like(r§mbr)
     D  i_rcdFmt                           const like(r§fmt)
     D  i_function                         const like(r§option)
     D  i_commitLVL                    N   const
     D  io_screenNbr                             like(r§int4)
     D  o_msgID                                  like(r§msgId)
     D  o_msgDta                                 like(r§msgDta)
      *
