
      /if defined(internal_prototype)
     D PEEK45          PR                  extpgm('PEEK45')
      /else
     D PEEK45          PR                  extpgm(PEEK45_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_headType                         const like(r§headTyp)
     D  i_copyright                        const like(r§copyRght)
     D  i_fldName                          const like(r§fieldNme)
     D  io_fldInhalt                             likeds(r§fldInhalt)
     D  io_length                                like(r§int4)
     D  i_protect                          const like(r§bool)
     D  i_isUcs2                           const like(r§int4)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
