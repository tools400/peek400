
      /if defined(internal_prototype)
     D PEEK40          PR                  extpgm('PEEK40')
      /else
     D PEEK40          PR                  extpgm(PEEK40_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_file                             const like(file_t)
     D  ib                                 const like(lib_t)
     D  i_mbr                              const like(mbr_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  i_basePhyF                         const like(bool_t)
     D  o_file                                   like(file_t)
     D  o_lib                                    like(lib_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
