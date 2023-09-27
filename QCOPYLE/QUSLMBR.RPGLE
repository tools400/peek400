      /if not defined(QUSLMBR)
      /define QUSLMBR
      *
      *  List Database File Members (QUSLMBR) API
     d QUSLMBR...
     d                 pr                         extpgm('QUSLMBR')
     d  i_qUsrSpc                    20A   const
     d  i_format                      8a   const
     d  i_qFile                      20A   const
     d  i_mbr                        10a   const
     d  i_ovrPrc                      1a   const
     d  io_errCode                65535a          options(*nopass: *varsize)
      *
      *  Input Parameter Section
     d QUSLMBR_inpParm_t...
     d                 ds                  qualified template
     d  qUsrSpc                      20a
     d  format                        8a
     d  qFile                        20a
     d  mbr                          10a
     d  ovrOrc                        1a
      *
      *  Header Section
     d QUSLMBR_header_t...
     d                 ds                  qualified template
     d  qFileUsed                    20a
     d  fileAttr                     10a
     d  text                         50A
     d  numMbr                       10i 0
     d  isSrcFile                      N
     d  reserved_1                    3a
     d  textCcsid                    10u 0
      *
      /endif
