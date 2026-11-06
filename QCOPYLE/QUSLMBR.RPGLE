**free
/if not defined(QUSLMBR)
/define QUSLMBR

//  List Database File Members (QUSLMBR) API
dcl-pr quslmbr extpgm('QUSLMBR');
  i_qusrspc  char(20) const;
  i_format   char(8) const;
  i_qfile    char(20) const;
  i_mbr      char(10) const;
  i_ovrprc   char(1) const;
  io_errcode char(65535) options(*nopass: *varsize);
end-pr;

//  Input Parameter Section
dcl-ds quslmbr_inpparm_t qualified template;
  qusrspc char(20);
  format  char(8);
  qfile   char(20);
  mbr     char(10);
  ovrorc  char(1);
end-ds;

//  Header Section
dcl-ds quslmbr_header_t qualified template;
  qfileused  char(20);
  fileattr   char(10);
  text       char(50);
  nummbr     int(10);
  issrcfile  ind;
  reserved_1 char(3);
  textccsid  uns(10);
end-ds;

/endif
