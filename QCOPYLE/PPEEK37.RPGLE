
      /if defined(internal_prototype)
     D PEEK37          PR                  extpgm('PEEK37')
      /else
     D PEEK37          PR                  extpgm(PEEK37_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  o_feld                                   like(r§fieldNme)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
