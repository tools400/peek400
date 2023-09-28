
      /if defined(internal_prototype)
     D PEEK37          PR                  extpgm('PEEK37')
      /else
     D PEEK37          PR                  extpgm(PEEK37_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  o_feld                                   like(fieldNme_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
