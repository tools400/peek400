**free
/if not defined(QUSLOBJ)
/define QUSLOBJ

//  List Objects (QUSLOBJ) API
dcl-pr quslobj extpgm('QUSLOBJ');
  i_qusrspc    char(20) const;
  i_format     char(8) const;
  i_qobj       char(20) const;
  i_objtype    char(10) const;
  io_errcode   char(65535) options(*nopass: *varsize); // | optGrp 1
  i_authctrl   char(65535) options(*nopass: *varsize) const; // | optGrp 2
  i_slcctrl    char(65535) options(*nopass: *varsize) const; // |
  i_auxstgpool char(65535) options(*nopass: *varsize) const; // | optGrp 3
end-pr;

//  Input Parameter Section
dcl-ds quslobj_inpparm_t qualified template;
  qusrspc        char(20);
  format         char(8);
  objslc         char(10);
  libslc         char(10);
  objtypeslc     char(10);
  reserved_1     char(2);
  errbytprv      int(10);
  lenauthctrl    int(10);
  calllvl        int(10);
  ofsobjauth     int(10);
  numobjauth     int(10);
  ofslibauth     int(10);
  numlibauth     int(10);
  lenslcctrl     int(10);
  slcomtsts      int(10);
  ofssts         int(10);
  numsts         int(10);
  lenauxstgpool  int(10);
  auxstgpoolname char(10);
  auxstgpooltype char(10);
end-ds;
//  Object authorities   ARRAY(*) of CHAR(10)
//  Library authorities  ARRAY(*) of CHAR(10)
//  Statuses             ARRAY(*) of CHAR(1)

//  Authority Control Format
dcl-ds quslobj_authctrl_t qualified template;
  length     char(10);
  calllvl    int(10);
  ofsobjauth int(10);
  numobjauth int(10);
  ofslibauth int(10);
  numlibauth int(10);
  reserved_1 int(10);
end-ds;
//  Object authorities   ARRAY(*) of CHAR(10)
//  Library authorities  ARRAY(*) of CHAR(10)

//  Selection Control Format
dcl-ds quslobj_slcctrl_t qualified template;
  length     int(10);
  slcomtsts  int(10);
  ofssts     int(10);
  numsts     int(10);
  reserved_1 int(10);
end-ds;
//  Statuses             ARRAY(*) of CHAR(1)

/endif
