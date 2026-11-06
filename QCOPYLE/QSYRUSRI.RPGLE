**free
/if not defined(QSYRUSRI)
/define QSYRUSRI

//  Retrieve User Information (QSYRUSRI) API
dcl-pr qsyrusri extpgm('QSYRUSRI');
  o_rcvvar    char(65535) options(*varsize);
  i_lenrcvvar int(10) const;
  i_format    char(8) const;
  i_usrprf    char(10) const;
  io_errcode  char(65535) options(*varsize);
end-pr;

/endif
