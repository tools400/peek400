**free
/if not defined(QECCVTEW)
/define QECCVTEW

//  Convert Edit Word (QECCVTEW) API
dcl-pr qeccvtew extpgm('QECCVTEW');
  o_editMask       char(65535) options(*varsize);
  o_editMaskLen    int(10);
  o_rcvVarLen      int(10);
  i_editWord       char(65535) options(*varsize) const;
  i_editWordLen    int(10) const;
  io_ErrCode       char(65535) options(*nopass: *varsize);
  i_srcLen         int(10) options(*nopass) const; // | optGrp 1
  // |
  i_currencySymbol char(1) options(*nopass) const; // |
end-pr;

/endif
