      /if not defined(QMHRTVM)
      /define QMHRTVM
      *
      *  Retrieve Message (QMHRTVM) API
     d QMHRTVM...
     d                 pr                  extpgm('QMHRTVM')
     d  o_msgInf                  65535a          options(*varsize)
     d  i_msgInfLen                  10i 0 const
     d  i_format                      8a   const
     d  i_msgID                       7a   const
     d  i_qMsgF                      20A   const
     d  i_rplData                 65535a   const  options(*varsize )
     d  i_rpldataLen                 10i 0 const
     d  i_rplVars                    10a   const
     d  i_rtnCtrlChrs                10a   const
     d  io_ErrCode                65535a          options(*varsize )
     d  i_rtvOpt                     10a   const  options(*nopass  )            | OptGrp 1
     d  i_toCcsid                    10i 0 const  options(*nopass  )            |
     d  i_ccsidRplDta                10i 0 const  options(*nopass  )            |
      *
      /endif
