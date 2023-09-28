                                                                                     *
      /if defined(internal_prototype)
     D PEEK12          PR                  extpgm('PEEK12')
      /else
     D PEEK12          PR                  extpgm(PEEK12_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_fmtName                          const like(fmt_t)
     D  i_fmtMode                    10A   const
     D  o_rcdl0200                               likeds(RCDL0200_t)
     D  o_fmtNbr                      5I 0
     D  o_msgId                                  like(msgId_t)
     D  o_msgDta                                 like(msgDta_t)
      *
