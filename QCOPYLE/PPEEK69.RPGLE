
      /if defined(internal_prototype)
     D PEEK69          PR                  extpgm('PEEK69')
      /else
     D PEEK69          PR                  extpgm(PEEK69_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  o_qFile                                  like(r§qObj)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
