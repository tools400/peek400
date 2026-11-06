**free
/if not defined(QUSRMBRD)
/define QUSRMBRD

//  Retrieve Member Description (QUSRMBRD) API
dcl-pr qusrmbrd extpgm('QUSRMBRD');
  o_rcvVar     char(65535) options(*varsize);
  i_lenRcvVar  int(10) const;
  i_format     char(8) const;
  i_qFile      char(20) const;
  i_mbr        char(10) const;
  i_ovrPrc     char(1) const;
  io_errCode   char(65535) options(*nopass: *varsize); // | OptGrp 1
  i_findMbrPrc char(1) options(*nopass) const; // | OptGrp 2
end-pr;

/endif
