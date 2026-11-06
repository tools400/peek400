**free
/if not defined(QMHRMVPM)
/define QMHRMVPM

//  Remove Program Messages (QMHRMVPM) API
dcl-pr qmhrmvpm extpgm('QMHRMVPM');
  i_callstke    char(256) const;
  i_callstkc    int(10) const;
  i_msgkey      char(4) const;
  i_msgtormv    char(10) const;
  io_errcode    char(65535) options(*varsize);
  i_lenstke     int(10) options(*nopass) const; // | optGrp 1
  i_callstkeq   char(20) options(*nopass) const; // |
  i_rmvunhdlexc char(10) options(*nopass) const; // |
  i_callstkedt  char(10) options(*nopass) const; // | optGrp 2
  i_alwdfrpyrjc char(10) options(*nopass) const; // | optGrp 3
end-pr;

dcl-c crmv_all '*ALL';
dcl-c crmv_ny_key '*BYKEY';
dcl-c crmv_new '*NEW';
dcl-c crmv_old '*OLD';
dcl-c crmv_scope '*SCOPE';

/endif
