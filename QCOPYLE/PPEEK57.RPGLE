
      /if defined(internal_prototype)
     D PEEK57          PR                  extpgm('PEEK57')
      /else
     D PEEK57          PR                  extpgm(PEEK57_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_envFile                          const like(file_t)
     D  i_envLib                           const like(lib_t)
     D  i_envMbr                           const like(mbr_t)
     D  i_envText                          const like(text_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
