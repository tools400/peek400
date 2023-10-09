**FREE
/if not defined(QECCVTEW)
/define QECCVTEW
//
//  Convert Edit Word (QECCVTEW) API
dcl-pr qeccvtew
       extpgm('QECCVTEW');
  o_editmask      char(65535) options(*varsize);
  o_editmasklen   int(10);
  o_rcvvarlen     int(10);
  i_editword      char(65535) const options(*varsize);
  i_editwordlen   int(10) const;
  io_errcode      char(65535) options(*nopass: *varsize);
  i_srclen        int(10) const  options(*nopass);                       // | optGrp 1
  i_currencysymbol                                                       // |
  char(1) const  options(*nopass);                                       // |
end-pr;
//
/endif
