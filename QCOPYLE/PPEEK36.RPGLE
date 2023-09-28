
      /if defined(internal_prototype)
     D PEEK36          PR                  extpgm('PEEK36')
      /else
     D PEEK36          PR                  extpgm(PEEK36_NAME)
      /endif
     D  i_buffer                    128A   const
     D  i_type                        1A   const
     D  i_datTimFmt                        const like(FLDL0100_t.F1DTFM)
     D  i_separator                        const like(FLDL0100_t.F1DTSP)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
