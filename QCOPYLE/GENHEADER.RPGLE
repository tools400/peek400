**FREE
/if defined(genHeader_t)
/eof
/endif
/define genHeader_t
//
dcl-ds genheader_t qualified template;
  sizeheader      int(10) pos(65);
  release_level   char(4);
  format          char(9) pos(72);
  api_used        char(10);
  crtdatetime     char(13);
  infstatus       char(1);
  sizeused        int(10);
  offsetinp       int(10);
  sizeinz         int(10);
  offsethdr       int(10);
  sizehdr         int(10);
  offsetlst       int(10);
  sizelst         int(10);
  numlstent       int(10);
  entrysize       int(10);
end-ds;
//
