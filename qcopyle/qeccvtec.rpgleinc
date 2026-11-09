**free
/if not defined(QECCVTEC)
/define QECCVTEC

//  Convert Edit Code (QECCVTEC) API
dcl-pr qeccvtec extpgm('QECCVTEC');
  o_editMask               char(65535) options(*varsize);
  o_editMaskLen            int(10);
  o_rcvVarLen              int(10);
  o_zeroBalFillChar        char(1) const;
  i_editCode               char(1) const;
  i_fillOrFloatCurrencyInd char(1) const;
  i_srvVarPrecision        int(10) const;
  i_srvVarDecPos           int(10) const;
  io_errCode               char(65535) options(*nopass: *varsize);
end-pr;

/endif
