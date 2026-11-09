**free
/if not defined(QMHRMVPM)
/define QMHRMVPM

//  Remove Program Messages (QMHRMVPM) API
dcl-pr qmhrmvpm extpgm('QMHRMVPM');
  i_callStkE    char(256) const;
  i_callStkC    int(10) const;
  i_msgKey      char(4) const;
  i_msgToRmv    char(10) const;
  io_errCode    char(65535) options(*varsize);
  i_lenStkE     int(10) options(*nopass) const; // | optGrp 1
  i_callStkEQ   char(20) options(*nopass) const; // |
  i_rmvUnhdlExc char(10) options(*nopass) const; // |
  i_callStkEDT  char(10) options(*nopass) const; // | optGrp 2
  i_alwDfRpyRjc char(10) options(*nopass) const; // | optGrp 3
end-pr;

dcl-c cRMV_All '*ALL';
dcl-c cRMV_NY_KEY '*BYKEY';
dcl-c cRMV_NEW '*NEW';
dcl-c cRMV_OLD '*OLD';
dcl-c cRMV_SCOPE '*SCOPE';

/endif
