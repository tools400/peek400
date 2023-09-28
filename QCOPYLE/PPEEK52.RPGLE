
      /if defined(internal_prototype)
     D PEEK52          PR                  extpgm('PEEK52')
      /else
     D PEEK52          PR                  extpgm(PEEK52_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  o_alwLc                                  like(bool_t)
     D  o_case                                   like(bool_t)
     D  o_cdLock                                 like(bool_t)
     D  o_nullDft                                like(bool_t)
     D  o_keepCrs                                like(bool_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
     D  i_isUnload                         const like(msgID_t)
      *
