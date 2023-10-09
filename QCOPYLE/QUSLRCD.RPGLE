**FREE
/if not defined(QUSLRCD)
/define QUSLRCD
//
//  List Fields (QUSLRCD) API
dcl-pr quslrcd
       extpgm('QUSLRCD');
  i_qusrspc       char(20) const;
  i_format        char(8) const;
  i_qfile         char(20) const;
  i_override      char(1) const;
  io_errcode      char(65535) options(*nopass: *varsize);                // | optGrp 1
end-pr;
//
//  Input Parameter Section
dcl-ds quslrcd_inpparm_t
       qualified template;
  qusrspc         likeds(qobj_t);
format          char(8);
qfile           likeds(qobj_t);
override        char(1);
end-ds;
//
//  Header Section
dcl-ds quslrcd_header_t
       qualified template;
  qfileused       likeds(qobj_t);
type            char(10);
text            char(50);
textccsid       int(10);
crtdate         char(13);
end-ds;
//
/endif
