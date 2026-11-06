**free
//===============================================================*
//                                                               *
//  Additional information about MBRD0100:                       *
//                                                               *
//                                                               *
//===============================================================*

dcl-ds MBRD0100_t qualified template;
  bytePrv   int(10);
  byteAvl   int(10);
  filNme    char(10);
  filLib    char(10);
  mbr       char(10);
  attr      char(10);
  srcTyp    char(10);
  crtDatTim char(13);
  chgDatTim char(13);
  text      char(50);
  isSrcFile char(1);
end-ds;

