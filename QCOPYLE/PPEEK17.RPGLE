      *
      /if defined(internal_prototype)
     D PEEK17          PR                  extpgm('PEEK17')
      /else
     D PEEK17          PR                  extpgm(PEEK17_NAME)
      /endif
     D  i_dsp80                            const like(r§bool)
     D  i_copyright                        const like(r§copyRght)
     D  i_qFile                            const like(r§qObj)
     D  i_member                           const like(r§mbr)
     D  o_field                      10A
     D  o_operation                  10A
     D  o_argument                   63A
     D  o_sign                        1A
     D  o_srchNbrs                   10P 0
     D  o_srchType                   10A
     D  o_srchCase                    1A
     D  o_msgId                                  like(r§msgId)
     D  o_msgDta                                 like(r§msgDta)
      *
