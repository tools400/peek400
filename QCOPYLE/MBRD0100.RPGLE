**FREE
//===============================================================*
//                                                               *
//  Additional information about MBRD0100:                       *
//                                                               *
//                                                               *
//===============================================================*
//
dcl-ds mbrd0100_t qualified template;
  byteprv         int(10);
  byteavl         int(10);
  filnme          char(10);
  fillib          char(10);
  mbr             char(10);
  attr            char(10);
  srctyp          char(10);
  crtdattim       char(13);
  chgdattim       char(13);
  text            char(50);
  issrcfile       char(1);
end-ds;
//
