
      /if defined(internal_prototype)
     D PEEK49          PR                  extpgm('PEEK49')
      /else
     D PEEK49          PR                  extpgm(PEEK49_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  i_release                    17A   const
     D  i_version                     9A   const
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
