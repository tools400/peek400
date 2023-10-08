      /if not defined(QUSROBJD)
      /define QUSROBJD
      *
      *  Retrieve Object Description (QUSROBJD) API
     d QUSROBJD...
     d                 pr                         extpgm('QUSROBJD')
     d  o_rcvVar                  65535a          options(*varsize)
     d  i_lenRcvVar                  10i 0 const
     d  i_format                      8a   const
     d  i_qObj                       20A   const
     d  i_type                       10a   const
     d  io_errCode                65535a          options(*nopass: *varsize)    | OptGrp 1
     d  i_auxStgCtrl              65535a   const  options(*nopass: *varsize)    | OptGrp 2
      *
      *  Auxiliary Storage Pool (ASP) Control Format
     d auxStgCtrl_t    ds                  qualified template
     d  length                       10i 0
     d  device                       10a
     d  searchType                   10a
      *
      /endif
