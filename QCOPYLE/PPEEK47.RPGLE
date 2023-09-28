
      /if defined(internal_prototype)
     D PEEK47          PR                  extpgm('PEEK47')
      /else
     D PEEK47          PR                  extpgm(PEEK47_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_qFile                            const likeds(qObj_t)
     D  i_mbr                                    like(mbr_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
