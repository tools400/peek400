      /if not defined(QSYRUSRI)
      /define QSYRUSRI
      *
      *  Retrieve User Information (QSYRUSRI) API
     d QSYRUSRI...
     d                 pr                  extpgm('QSYRUSRI')
     d  o_rcvVar                  65535a         options(*varsize)
     d  i_lenRcvVar                  10i 0 const
     d  i_format                      8a   const
     d  i_usrprf                     10a   const
     d  io_errCode                65535a          options(*varsize)
      *
      /endif
