**free
/if not defined(QUSLFLD)
/define QUSLFLD

//  List Fields (QUSLFLD) API
dcl-pr quslfld extpgm('QUSLFLD');
  i_qUsrSpc  char(20) const;
  i_format   char(8) const;
  i_qFile    char(20) const;
  i_rcdFmt   char(10) const;
  i_override char(1) const;
  io_errCode char(65535) options(*nopass: *varsize); // | optGrp 1
end-pr;

//  Input Parameter Section
dcl-ds quslfld_inpparm_t qualified template;
  qUsrSpc  likeds(qobj_t);
  format   char(8);
  qFile    likeds(qobj_t);
  rcdFmt   char(10);
  override char(1);
end-ds;

//  Header Section
dcl-ds quslfld_header_t qualified template;
  qFileUsed     likeds(qobj_t);
  type          char(10);
  rcdFmtUsed    char(10);
  rcdLen        int(10);
  rcdFmtID      char(13);
  rcdText       char(50);
  reserved_1    char(1);
  rcdTextCcsid  int(10);
  varLenFldInd  char(1);
  graphicFldInd char(1);
  datTimFldInd  char(1);
  nullFldInd    char(1);
end-ds;

/endif
