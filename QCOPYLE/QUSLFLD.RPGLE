      /if not defined(QUSLFLD)
      /define QUSLFLD
      *
      *  List Fields (QUSLFLD) API
     d QUSLFLD...
     d                 pr                         extpgm('QUSLFLD')
     d  i_qUsrSpc                    20A   const
     d  i_format                      8a   const
     d  i_qFile                      20A   const
     d  i_rcdFmt                     10a   const
     d  i_override                    1a   const
     d  io_errCode                65535a          options(*nopass: *varsize)    | optGrp 1
      *
      *  Input Parameter Section
     d QUSLFLD_inpParm_t...
     d                 ds                  qualified template
     d  qUsrSpc                            likeds(r§qObj)
     d  format                        8a
     d  qFile                              likeds(r§qObj)
     d  rcdFmt                       10a
     d  override                      1a
      *
      *  Header Section
     d QUSLFLD_header_t...
     d                 ds                  qualified template
     d  qFileUsed                          likeds(r§qObj)
     d  type                         10a
     d  rcdFmtUsed                   10a
     d  rcdLen                       10i 0
     d  rcdFmtID                     13A
     d  rcdText                      50A
     d  reserved_1                    1a
     d  rcdTextCcsid                 10i 0
     d  varLenFldInd                  1a
     d  graphicFldInd                 1a
     d  datTimFldInd                  1a
     d  nullFldInd                    1a
      *
      /endif
