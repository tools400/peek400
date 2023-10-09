**FREE
/if not defined(QECEDT)
/define QECEDT
//
//  Edit (QECEDT) API
dcl-pr qecedt
       extpgm('QECEDT');
  o_rcvvar        char(65535) options(*varsize);
  i_lenrcvvar     int(10) const;
  i_srcvar        char(65535) const options(*varsize);
  i_srcvarclass   char(10) const;
  i_srvvarprecision
  int(10) const;
  i_editmask      char(65535) const options(*varsize);
  i_editmasklen   int(10) const;
  i_zerobalfillchar
  char(1) const;
  io_errcode      char(65535) options(*nopass: *varsize);
end-pr;
//
/endif
