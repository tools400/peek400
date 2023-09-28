
      /if defined(internal_prototype)
     D PEEK56          PR                  extpgm('PEEK56')
      /else
     D PEEK56          PR                  extpgm(PEEK56_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_mode                             const like(mode_t)
     D  i_envFile                          const like(file_t)
     D  i_envLib                           const like(lib_t)
     D  i_envMbr                           const like(mbr_t)
     D  i_rcdFmtID                         const like(fmtId_t)
     D  o_qFile                                  likeds(qObj_t)
     D  o_mbr                                    like(mbr_t)
     D  o_text                                   like(text_t)
     D  o_option                                 like(option_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
