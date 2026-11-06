**free
/if not defined(QUSROBJD)
/define QUSROBJD

//  Retrieve Object Description (QUSROBJD) API
dcl-pr qusrobjd extpgm('QUSROBJD');
  o_rcvVar     char(65535) options(*varsize);
  i_lenRcvVar  int(10) const;
  i_format     char(8) const;
  i_qObj       char(20) const;
  i_type       char(10) const;
  io_ErrCode   char(65535) options(*nopass: *varsize); // | OptGrp 1
  i_auxStgCtrl char(65535) options(*nopass: *varsize) const; // | OptGrp 2
end-pr;

//  Auxiliary Storage Pool (ASP) Control Format
dcl-ds auxStgCtrl_t qualified template;
  length     int(10);
  device     char(10);
  searchType char(10);
end-ds;

/endif
