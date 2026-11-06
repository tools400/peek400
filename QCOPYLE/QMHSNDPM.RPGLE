**free
/if not defined(QMHSNDPM)
/define QMHSNDPM

//  Send Program Message (QMHSNDPM) API
dcl-pr qmhsndpm extpgm('QMHSNDPM');
  i_msgID      char(7) const;
  i_qMsgF      char(20) const;
  i_msgData    char(32767) options(*varsize) const;
  i_length     int(10) const;
  i_msgType    char(10) const;
  i_callStkE   char(256) const;
  i_callStkC   int(10) const;
  o_msgKey     char(4);
  io_ErrCode   char(32767) options(*varsize);
  i_lenStkE    int(10) options(*nopass) const; // | optGrp 1
  i_callStkEQ  char(20) options(*nopass) const; // |
  i_wait       int(10) options(*nopass) const; // |
  i_callStkEDT char(10) options(*nopass) const; // | optGrp 2
  i_ccsid      int(10) options(*nopass) const; // |
end-pr;

/endif
