      /if not defined(QMHRMVPM)
      /define QMHRMVPM
      *
      *  Remove Program Messages (QMHRMVPM) API
     d QMHRMVPM...
     d                 pr                  extpgm('QMHRMVPM')
     d  i_callStkE                  256a   const
     d  i_callStkC                   10i 0 const
     d  i_msgKey                      4a   const
     d  i_msgToRmv                   10a   const
     d  io_ErrCode                65535a          options(*varsize)
     d  i_lenStkE                    10i 0 const  options(*nopass )             | optGrp 1
     d  i_callStkEQ                  20A   const  options(*nopass )             |
     d  i_rmvUnhdlExc                10a   const  options(*nopass )             |
     d  i_callStkEDT                 10a   const  options(*nopass )             | optGrp 2
     d  i_alwDfRpyRjc                10a   const  options(*nopass )             | optGrp 3
      *
     d cRMV_All        c                   const('*ALL')
     d cRMV_NY_KEY     c                   const('*BYKEY')
     d cRMV_NEW        c                   const('*NEW')
     d cRMV_OLD        c                   const('*OLD')
     d cRMV_SCOPE      c                   const('*SCOPE')
      *
      /endif
