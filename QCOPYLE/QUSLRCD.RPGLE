      /if not defined(QUSLRCD)
      /define QUSLRCD
      *
      *  List Fields (QUSLRCD) API
     d QUSLRCD...
     d                 pr                         extpgm('QUSLRCD')
     d  i_qUsrSpc                    20A   const
     d  i_format                      8a   const
     d  i_qFile                      20A   const
     d  i_override                    1a   const
     d  io_errCode                65535a          options(*nopass: *varsize)    | optGrp 1
      *
      *  Input Parameter Section
     d QUSLRCD_inpParm_t...
     d                 ds                  qualified template
     d  qUsrSpc                            likeds(r§qObj)
     d  format                        8a
     d  qFile                              likeds(r§qObj)
     d  override                      1a
      *
      *  Header Section
     d QUSLRCD_header_t...
     d                 ds                  qualified template
     d  qFileUsed                          likeds(r§qObj)
     d  type                         10a
     d  text                         50A
     d  textCcsid                    10i 0
     d  crtDate                      13a
      *
      /endif
