      /if not defined(QUSPTRUS)
      /define QUSPTRUS
      *
      *  List Objects (QUSPTRUS) API
     d QUSPTRUS...
     d                 pr                         extpgm('QUSPTRUS')
     d  i_qUsrSpc                    20A   const
     d  o_pUsrSpc                      *
     d  io_errCode                65535a          options(*nopass: *varsize)    |
      *
      /endif
