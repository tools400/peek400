
      /if defined(internal_prototype)
     D PEEK26          PR                  extpgm('PEEK26')
      /else
     D PEEK26          PR                  extpgm(PEEK26_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_qSrcFile                         const likeds(qObj_t)
     D  i_srcMbr                           const like(mbr_t)
     D  o_toFile                                 like(file_t)
     D  o_toLib                                  like(lib_t)
     D  o_toMbr                                  like(mbr_t)
     D  o_mbrOpt                     10A
     D  o_crtFile                    10A
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
