**FREE
/if not defined(QMHMOVPM)
/define QMHMOVPM
//
//  Move Program Messages (QMHMOVPM) API
dcl-pr QMHMOVPM
       extpgm('QMHMOVPM');
  i_msgKey        char(4) const;
  i_msgTypes      char(10) const  dim(64) options(*varsize);
  i_numTypes      int(10) const;
  i_callStkE      char(256) const  options(*varsize);
  i_callStkC      int(10) const;
  io_ErrCode      char(65535) options(*varsize);
  i_lenStkE       int(10) const  options(*nopass );                      // | optGrp 1
  i_callStkEQ     char(20) const  options(*nopass );                     // |
  i_callStkEDT    char(10) const  options(*nopass );                     // | optGrp 2
  i_pFrmProc      pointer(*proc) const  options(*nopass );               // |
  i_frmCallStkC   int(10) const  options(*nopass );                      // |
end-pr;
//
/endif
