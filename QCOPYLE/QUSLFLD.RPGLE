**FREE
/if not defined(QUSLFLD)
/define QUSLFLD
//
//  List Fields (QUSLFLD) API
dcl-pr quslfld
       extpgm('QUSLFLD');
  i_qusrspc       char(20) const;
  i_format        char(8) const;
  i_qfile         char(20) const;
  i_rcdfmt        char(10) const;
  i_override      char(1) const;
  io_errcode      char(65535) options(*nopass: *varsize);                // | optGrp 1
end-pr;
//
//  Input Parameter Section
dcl-ds quslfld_inpparm_t
       qualified template;
  qusrspc         likeds(qobj_t);
format          char(8);
qfile           likeds(qobj_t);
rcdfmt          char(10);
override        char(1);
end-ds;
//
//  Header Section
dcl-ds quslfld_header_t
       qualified template;
  qfileused       likeds(qobj_t);
type            char(10);
rcdfmtused      char(10);
rcdlen          int(10);
rcdfmtid        char(13);
rcdtext         char(50);
reserved_1      char(1);
rcdtextccsid    int(10);
varlenfldind    char(1);
graphicfldind   char(1);
dattimfldind    char(1);
nullfldind      char(1);
end-ds;
//
/endif
