
      /if defined(internal_prototype)
     D PEEK34          PR                  extpgm('PEEK34')
      /else
     D PEEK34          PR                  extpgm(PEEK34_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  i_function                         const like(r§option)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
