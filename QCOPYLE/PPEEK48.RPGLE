
      /if defined(internal_prototype)
     D PEEK48          PR                  extpgm('PEEK48')
      /else
     D PEEK48          PR                  extpgm(PEEK48_NAME)
      /endif
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  io_file                                  like(file_t)
     D  io_library                               like(lib_t)
     D  io_member                                like(mbr_t)
     D  io_rcdFmt                                like(fmt_t)
     D  i_accessMode                       const like(accessMode_t)
     D  io_sqlWhere                              like(sqlWhere_t)
     D  io_sqlOrder                              like(sqlOrder_t)
     D  i_enableWhere                      const like(bool_t)
     D  i_enableOrder                      const like(bool_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
