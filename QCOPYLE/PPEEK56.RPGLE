
      /if defined(internal_prototype)
     D PEEK56          PR                  extpgm('PEEK56')
      /else
     D PEEK56          PR                  extpgm(PEEK56_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  i_mode                             const like(r§mode)
     D  i_envFile                          const like(r§file)
     D  i_envLib                           const like(r§lib)
     D  i_envMbr                           const like(r§mbr)
     D  i_rcdFmtID                         const like(r§fmtId)
     D  o_qFile                                  likeds(r§qObj)
     D  o_mbr                                    like(r§mbr)
     D  o_text                                   like(r§text)
     D  o_option                                 like(r§option)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
