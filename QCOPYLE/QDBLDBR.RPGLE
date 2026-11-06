**free
/if not defined(QDBLDBR)
/define QDBLDBR

//  List Database Relations (QDBLDBR) API
dcl-pr qdbldbr extpgm('QDBLDBR');
  i_qusrspc  char(20) const;
  i_format   char(8) const;
  i_qfile    char(20) const;
  i_mbr      char(10) const;
  i_rcdfmt   char(10) const;
  io_errcode char(65535) options(*varsize);
end-pr;

/endif
