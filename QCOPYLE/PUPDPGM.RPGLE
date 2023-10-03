                                                                                     *
      /if defined(internal_prototype)
     D UPDPGM          PR                  extpgm('UPDPGM')
      /else
     D UPDPGM          PR                  extpgm(UPDPGM_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  io_headerType                            like(headerType_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_rcdNbr                           const like(rcdNbr_t)
     D  i_file                             const like(file_t)
     D  i_library                          const like(lib_t)
     D  i_member                           const like(mbr_t)
     D  i_function                         const like(function_t)
     D  i_commitLVL                        const like(commitLvl_t)
     D  i_isUpdKey                         const like(bool_t)
     D  io_screenNbr                             like(int4_t)
     D  io_isLower                               like(bool_t)
     D  io_csrRow                                like(int4_t)
     D  io_csrCol                                like(int4_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
