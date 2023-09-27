
      /if defined(internal_prototype)
     D PEEK57          PR                  extpgm('PEEK57')
      /else
     D PEEK57          PR                  extpgm(PEEK57_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  i_envFile                          const like(r§file)
     D  i_envLib                           const like(r§lib)
     D  i_envMbr                           const like(r§mbr)
     D  i_envText                    50A   const
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
