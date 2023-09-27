
      /if defined(internal_prototype)
     D PEEK26          PR                  extpgm('PEEK26')
      /else
     D PEEK26          PR                  extpgm(PEEK26_NAME)
      /endif
     D  i_dsp80                            const like(r§dsp80)
     D  i_qSrcFile                         const likeds(r§qObj)
     D  i_srcMbr                           const like(r§mbr)
     D  o_toFile                                 like(r§file)
     D  o_toLib                                  like(r§lib)
     D  o_toMbr                                  like(r§mbr)
     D  o_mbrOpt                     10A
     D  o_crtFile                    10A
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
