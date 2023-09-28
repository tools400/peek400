      *
      /if defined(internal_prototype)
     D PEEK17          PR                  extpgm('PEEK17')
      /else
     D PEEK17          PR                  extpgm(PEEK17_NAME)
      /endif
     D  i_dsp80                            const like(bool_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_qFile                            const like(qObj_t)
     D  i_member                           const like(mbr_t)
     D  o_field                      10A
     D  o_operation                  10A
     D  o_argument                   63A
     D  o_sign                        1A
     D  o_srchNbrs                   10P 0
     D  o_srchType                   10A
     D  o_srchCase                    1A
     D  o_msgId                                  like(msgId_t)
     D  o_msgDta                                 like(msgDta_t)
      *
