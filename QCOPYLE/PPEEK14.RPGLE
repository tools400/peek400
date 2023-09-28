                                                                                     *
      /if defined(internal_prototype)
     D PEEK14          PR                  extpgm('PEEK14')
      /else
     D PEEK14          PR                  extpgm(PEEK14_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  io_headerType                            like(headerType_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_rcdNbr                           const like(rcdNbr_t)
     D  i_file                             const like(file_t)
     D  i_lib                              const like(lib_t)
     D  i_mbr                              const like(mbr_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  i_function                         const like(function_t)
     D  i_commitLVL                        const like(bool_t)
     D  io_screenNbr                             like(int4_t)
     D  o_msgID                                  like(msgId_t)
     D  o_msgDta                                 like(msgDta_t)
      *
