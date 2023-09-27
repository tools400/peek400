
      /if defined(internal_prototype)
     D PEEK40          PR                  extpgm('PEEK40')
      /else
     D PEEK40          PR                  extpgm(PEEK40_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  i_file                             const like(r§file)
     D  ib                                 const like(r§lib)
     D  i_mbr                              const like(r§mbr)
     D  i_rcdFmt                           const like(r§fmt)
     D  i_basePhyF                         const like(r§bool)
     D  o_file                                   like(r§file)
     D  o_lib                                    like(r§lib)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
