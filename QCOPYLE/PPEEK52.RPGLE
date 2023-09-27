
      /if defined(internal_prototype)
     D PEEK52          PR                  extpgm('PEEK52')
      /else
     D PEEK52          PR                  extpgm(PEEK52_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  o_alwLc                                  like(r§bool)
     D  o_case                                   like(r§bool)
     D  o_cdLock                                 like(r§bool)
     D  o_nullDft                                like(r§bool)
     D  o_keepCrs                                like(r§bool)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
     D  i_isUnload                         const like(r§msgID)
      *
