**free
/if not defined(QECEDT)
/define QECEDT

//  Edit (QECEDT) API
dcl-pr qecedt extpgm('QECEDT');
  o_rcvVar          char(65535) options(*varsize);
  i_lenRcvVar       int(10) const;
  i_srcVar          char(65535) options(*varsize) const;
  i_srcVarClass     char(10) const;
  i_srvVarPrecision int(10) const;
  i_editMask        char(65535) options(*varsize) const;
  i_editMaskLen     int(10) const;
  i_zeroBalFillChar char(1) const;
  io_errCode        char(65535) options(*nopass: *varsize);
end-pr;

/endif
