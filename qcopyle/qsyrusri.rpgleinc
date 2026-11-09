**free
/if not defined(QSYRUSRI)
/define QSYRUSRI

//  Retrieve User Information (QSYRUSRI) API
dcl-pr qsyrusri extpgm('QSYRUSRI');
  o_rcvVar    char(65535) options(*varsize);
  i_lenRcvVar int(10) const;
  i_format    char(8) const;
  i_usrPrf    char(10) const;
  io_errCode  char(65535) options(*varsize);
end-pr;

/endif
