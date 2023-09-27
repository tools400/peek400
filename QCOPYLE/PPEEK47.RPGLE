
      /if defined(internal_prototype)
     D PEEK47          PR                  extpgm('PEEK47')
      /else
     D PEEK47          PR                  extpgm(PEEK47_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  i_qFile                            const likeds(r§qObj)
     D  i_mbr                                    like(r§mbr)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
