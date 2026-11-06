**free

dcl-ds USRI0200_t qualified template;
  bytRet       int(10);
  bytAvl       int(10);
  usrprf       char(10);
  usrCls       char(10);
  spcAuts      char(15);
  grpPrf       char(10);
  owner        char(10);
  grpAut       char(10);
  lmtCap       char(10);
  grpAutType   char(10);
  reserved_01  char(3);
  ofsSupplGrps int(10);
  numSupplGrps int(10);
  supplGrps    char(10) dim(10);
end-ds;

