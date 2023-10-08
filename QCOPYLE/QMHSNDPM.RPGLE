      /if not defined(QMHSNDPM)
      /define QMHSNDPM
      *
      *  Send Program Message (QMHSNDPM) API
     d QMHSNDPM...
     d                 pr                  extpgm('QMHSNDPM')
     d  i_msgID                       7a   const
     d  i_qMsgF                      20A   const
     d  i_msgData                 32767A   const  options(*varsize )
     d  i_length                     10i 0 const
     d  i_msgType                    10a   const
     d  i_callStkE                  256a   const
     d  i_callStkC                   10i 0 const
     d  o_msgKey                      4a
     d  io_ErrCode                32767A          options(*varsize )
     d  i_lenStkE                    10i 0 const  options(*nopass  )            | optGrp 1
     d  i_callStkEQ                  20A   const  options(*nopass  )            |
     d  i_wait                       10i 0 const  options(*nopass  )            |
     d  i_callStkEDT                 10a   const  options(*nopass  )            | optGrp 2
     d  i_ccsid                      10i 0 const  options(*nopass  )            |
      *
      /endif
