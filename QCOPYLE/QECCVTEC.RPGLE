**free
/if not defined(QECCVTEC)
/define QECCVTEC

//  Convert Edit Code (QECCVTEC) API
dcl-pr qeccvtec extpgm('QECCVTEC');
  o_editmask               char(65535) options(*varsize);
  o_editmasklen            int(10);
  o_rcvvarlen              int(10);
  o_zerobalfillchar        char(1) const;
  i_editcode               char(1) const;
  i_fillorfloatcurrencyind char(1) const;
  i_srvvarprecision        int(10) const;
  i_srvvardecpos           int(10) const;
  io_errcode               char(65535) options(*nopass: *varsize);
end-pr;

/endif
