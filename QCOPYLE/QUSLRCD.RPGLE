**free
/if not defined(QUSLRCD)
/define QUSLRCD

//  List Fields (QUSLRCD) API
dcl-pr quslrcd extpgm('QUSLRCD');
  i_qUsrSpc  char(20) const;
  i_format   char(8) const;
  i_qFile    char(20) const;
  i_override char(1) const;
  io_ErrCode char(65535) options(*nopass: *varsize); // | optGrp 1
end-pr;

//  Input Parameter Section
dcl-ds QUSLRCD_inpParm_t qualified template;
  qUsrSpc  likeds(qObj_t);
  format   char(8);
  qFile    likeds(qObj_t);
  Override char(1);
end-ds;

//  Header Section
dcl-ds QUSLRCD_header_t qualified template;
  qFileUsed likeds(qObj_t);
  type      char(10);
  text      char(50);
  textCcsid int(10);
  CrtDate   char(13);
end-ds;

/endif
