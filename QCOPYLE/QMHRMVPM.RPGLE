**FREE
/if not defined(QMHRMVPM)
/define QMHRMVPM
//
//  Remove Program Messages (QMHRMVPM) API
dcl-pr qmhrmvpm
       extpgm('QMHRMVPM');
  i_callstke      char(256) const;
  i_callstkc      int(10) const;
  i_msgkey        char(4) const;
  i_msgtormv      char(10) const;
  io_errcode      char(65535) options(*varsize);
  i_lenstke       int(10) const  options(*nopass );                      // | optGrp 1
  i_callstkeq     char(20) const  options(*nopass );                     // |
  i_rmvunhdlexc   char(10) const  options(*nopass );                     // |
  i_callstkedt    char(10) const  options(*nopass );                     // | optGrp 2
  i_alwdfrpyrjc   char(10) const  options(*nopass );                     // | optGrp 3
end-pr;
//
dcl-c crmv_all const('*ALL');
dcl-c crmv_ny_key const('*BYKEY');
dcl-c crmv_new const('*NEW');
dcl-c crmv_old const('*OLD');
dcl-c crmv_scope const('*SCOPE');
//
/endif
