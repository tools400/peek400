**free
/if not defined(QECCVTEW)
/define QECCVTEW

//  Convert Edit Word (QECCVTEW) API
dcl-pr qeccvtew extpgm('QECCVTEW');
  o_editmask       char(65535) options(*varsize);
  o_editmasklen    int(10);
  o_rcvvarlen      int(10);
  i_editword       char(65535) options(*varsize) const;
  i_editwordlen    int(10) const;
  io_errcode       char(65535) options(*nopass: *varsize);
  i_srclen         int(10) options(*nopass) const; // | optGrp 1
  // |
  i_currencysymbol char(1) options(*nopass) const; // |
end-pr;

/endif
