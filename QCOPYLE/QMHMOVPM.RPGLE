      /if not defined(QMHMOVPM)
      /define QMHMOVPM
      *
      *  Move Program Messages (QMHMOVPM) API
     d QMHMOVPM...
     d                 pr                  extpgm('QMHMOVPM')
     d  i_msgKey                      4a   const
     d  i_msgTypes                   10a   const  dim(64) options(*varsize)
     d  i_numTypes                   10i 0 const
     d  i_callStkE                  256a   const  options(*varsize)
     d  i_callStkC                   10i 0 const
     d  io_ErrCode                65535a          options(*varsize)
     d  i_lenStkE                    10i 0 const  options(*nopass )             | optGrp 1
     d  i_callStkEQ                  20A   const  options(*nopass )             |
     d  i_callStkEDT                 10a   const  options(*nopass )             | optGrp 2
     d  i_pFrmProc                     *   const  options(*nopass ) procptr     |
     d  i_frmCallStkC                10i 0 const  options(*nopass )             |
      *
      /endif
