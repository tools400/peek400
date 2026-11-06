**free
/if defined(genHeader_t)
/eof
/endif
/define genHeader_t

dcl-ds genHeader_t qualified template;
  sizeHeader    int(10) pos(65);
  release_Level char(4);
  format        char(9) pos(72);
  api_used      char(10);
  crtDateTime   char(13);
  infStatus     char(1);
  sizeUsed      int(10);
  offsetInp     int(10);
  sizeInz       int(10);
  offsetHdr     int(10);
  sizeHdr       int(10);
  OffsetLst     int(10);
  sizeLst       int(10);
  NumLstEnt     int(10);
  EntrySize     int(10);
end-ds;

