**free

dcl-ds usri0200_t qualified template;
  bytret       int(10);
  bytavl       int(10);
  usrprf       char(10);
  usrcls       char(10);
  spcauts      char(15);
  grpprf       char(10);
  owner        char(10);
  grpaut       char(10);
  lmtcap       char(10);
  grpauttype   char(10);
  reserved_01  char(3);
  ofssupplgrps int(10);
  numsupplgrps int(10);
  supplgrps    char(10) dim(10);
end-ds;

