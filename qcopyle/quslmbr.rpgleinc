**free
/if not defined(QUSLMBR)
/define QUSLMBR

//  List Database File Members (QUSLMBR) API
dcl-pr quslmbr extpgm('QUSLMBR');
  i_qUsrSpc  char(20) const;
  i_format   char(8) const;
  i_qFile    char(20) const;
  i_mbr      char(10) const;
  i_ovrPrc   char(1) const;
  io_errCode char(65535) options(*nopass: *varsize);
end-pr;

//  Input Parameter Section
dcl-ds QUSLMBR_inpParm_t qualified template;
  qUsrSpc char(20);
  format  char(8);
  qFile   char(20);
  mbr     char(10);
  ovrOrc  char(1);
end-ds;

//  Header Section
dcl-ds QUSLMBR_header_t qualified template;
  qFileUsed  char(20);
  fileAttr   char(10);
  text       char(50);
  numMbr     int(10);
  isSrcFile  ind;
  reserved_1 char(3);
  textCcsid  uns(10);
end-ds;

/endif
