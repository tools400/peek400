**free
/if not defined(QMHMOVPM)
/define QMHMOVPM

//  Move Program Messages (QMHMOVPM) API
dcl-pr QMHMOVPM extpgm('QMHMOVPM');
  i_msgKey      char(4) const;
  i_msgTypes    char(10) dim(64) options(*varsize) const;
  i_numTypes    int(10) const;
  i_callStkE    char(256) options(*varsize) const;
  i_callStkC    int(10) const;
  io_ErrCode    char(65535) options(*varsize);
  i_lenStkE     int(10) options(*nopass) const; // | optGrp 1
  i_callStkEQ   char(20) options(*nopass) const; // |
  i_callStkEDT  char(10) options(*nopass) const; // | optGrp 2
  i_pFrmProc    pointer(*proc) options(*nopass) const; // |
  i_frmCallStkC int(10) options(*nopass) const; // |
end-pr;

/endif
