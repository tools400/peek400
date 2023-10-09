**FREE
/if not defined(QUSRMBRD)
/define QUSRMBRD
//
//  Retrieve Member Description (QUSRMBRD) API
dcl-pr qusrmbrd
       extpgm('QUSRMBRD');
  o_rcvvar        char(65535) options(*varsize);
  i_lenrcvvar     int(10) const;
  i_format        char(8) const;
  i_qfile         char(20) const;
  i_mbr           char(10) const;
  i_ovrprc        char(1) const;
  io_errcode      char(65535) options(*nopass: *varsize);                // | OptGrp 1
  i_findmbrprc    char(1) const  options(*nopass);                       // | OptGrp 2
end-pr;
//
/endif
