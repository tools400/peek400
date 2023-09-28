
      /if defined(internal_prototype)
     D PEEK45          PR                  extpgm('PEEK45')
      /else
     D PEEK45          PR                  extpgm(PEEK45_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_headType                         const like(headTyp_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_fldName                          const like(fieldNme_t)
     D  io_fldInhalt                             likeds(fldInhalt_t)
     D  io_length                                like(int4_t)
     D  i_protect                          const like(bool_t)
     D  i_isUcs2                           const like(int4_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
