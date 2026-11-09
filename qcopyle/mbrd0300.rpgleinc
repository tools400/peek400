**free
//===============================================================*
//                                                               *
//  Additional information about MBRD0200:                       *
//                                                               *
//                                                               *
//===============================================================*

//  API format MBRD0200
//  (data structure can be used within the calling program
//  to splitt XValue into its units.)
dcl-ds mbrd0300_t qualified template;
  m3BytRet               int(10);
  m3bytAvl               int(10);
  m3File                 char(10);
  m3Library              char(10);
  m3Member               char(10);
  m3Attr                 char(10);
  m3SrcTyp               char(10);
  m3ObjCrtDt             char(13);
  m3SrcChgDt             char(13);
  m3Text                 char(50);
  m3SrcFile              char(1);
  m3Remote               char(1);
  m3FileTyp              char(1);
  m3ODPShare             char(1);
  m3Res_01               char(2);
  m3NbrRcdOn             int(10);
  m3NbrRcdDl             int(10);
  m3DtaSpcSz             uns(10);
  m3AccSpcSz             uns(10);
  m3numBasedOnMbr        int(10);
  m3ChgDateTime          char(13);
  m3SavDateTime          char(13);
  m3RstDateTime          char(13);
  m3ExpDate              char(7);
  m3Reserved_1           char(4);
  m3MediaPref            int(5);
  m3NumDaysUsed          int(10);
  m3DateLstUsed          char(7);
  m3UseResDate           char(7);
  m3Reserved_2           char(2);
  m3DtaSizeMult          int(10);
  m3AccSizeMult          int(10);
  m3MbrTxtCcsid          int(10);
  m3OfsAddInf            int(10);
  m3LenAddInf            int(10);
  m3NumRcds              uns(10);
  m3NumDltRcds           uns(10);
  m3Reserved_3           char(6);
  m3joinMbr              char(1);
  m3AccPathMaint         char(1);
  m3SQLFileType          char(10);
  m3Reserved_4           char(1);
  m3AlwRead              char(1);
  m3AlwWrite             char(1);
  m3AlwUpdate            char(1);
  m3AlwDelete            char(1);
  m3Reserved_5           char(1);
  m3RcdsForceWrite       int(10);
  m3MaxPercentDltRcdsAlw int(10);
  m3InitNumRcds          int(10);
  m3IncNumRcds           int(10);
  m3MaxNumInc            int(10);
  m3CurrNumInc           uns(10);
  m3RcdCapacity          uns(10);
  m3RcdSlcPgm            char(10);
  m3RcdSlcLib            char(10);
  m3NumCstIdx            int(5);
  m3OfsCstIdxInf         int(10);
  m3Reserved_6           char(46);
end-ds;
//   Array of CHAR(112)	Record format and based-on file list
//   Array of CHAR(320)	Constraint indexes information

//  Record Format and Based-On File List Entry
dcl-ds mbrd0300_basedOnE_t qualified template;
  basedOnFile     char(10);
  basedOnLib      char(10);
  basedOnMbr      char(10);
  fmtName         char(10);
  lfRcdFmtNbr     int(10);
  nbrRcds         int(10);
  nbrDltRcds      int(10);
  accPathSize     int(10);
  accPathSizeM    int(10);
  accPathShared   char(1);
  accPathValid    char(1);
  accPathHeld     char(1);
  accPathOwnrFile char(10);
  accPathOwnrLib  char(10);
  accPathOwnrMbr  char(10);
  accPathJrn      char(1);
  reserved_1      char(2);
  nbrRcdsU        int(10);
  nbrDltRcdsU     int(10);
  reserved_2      char(8);
end-ds;

