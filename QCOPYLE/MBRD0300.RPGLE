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
dcl-ds MBRD0300_t qualified template;
  M3BytRet               int(10);
  m3bytavl               int(10);
  M3File                 char(10);
  M3Library              char(10);
  M3Member               char(10);
  M3Attr                 char(10);
  M3SrcTyp               char(10);
  M3ObjCrtDt             char(13);
  M3SrcChgDt             char(13);
  M3Text                 char(50);
  M3SrcFile              char(1);
  M3Remote               char(1);
  M3FileTyp              char(1);
  M3ODPShare             char(1);
  M3Res_01               char(2);
  M3NbrRcdOn             int(10);
  M3NbrRcdDl             int(10);
  M3DtaSpcSz             uns(10);
  M3AccSpcSz             uns(10);
  m3numBasedOnMbr        int(10);
  M3ChgDateTime          char(13);
  M3SavDateTime          char(13);
  M3RstDateTime          char(13);
  M3ExpDate              char(7);
  M3Reserved_1           char(4);
  M3MediaPref            int(5);
  M3NumDaysUsed          int(10);
  M3DateLstUsed          char(7);
  M3UseResDate           char(7);
  M3Reserved_2           char(2);
  M3DtaSizeMult          int(10);
  M3AccSizeMult          int(10);
  M3MbrTxtCcsid          int(10);
  M3OfsAddInf            int(10);
  M3LenAddInf            int(10);
  M3NumRcds              uns(10);
  M3NumDltRcds           uns(10);
  M3Reserved_3           char(6);
  m3joinmbr              char(1);
  m3AccPathMaint         char(1);
  m3SQLFileType          char(10);
  M3Reserved_4           char(1);
  M3AlwRead              char(1);
  M3AlwWrite             char(1);
  M3AlwUpdate            char(1);
  M3AlwDelete            char(1);
  M3Reserved_5           char(1);
  M3RcdsForceWrite       int(10);
  M3MaxPercentDltRcdsAlw int(10);
  M3InitNumRcds          int(10);
  M3IncNumRcds           int(10);
  M3MaxNumInc            int(10);
  M3CurrNumInc           uns(10);
  M3RcdCapacity          uns(10);
  M3RcdSlcPgm            char(10);
  M3RcdSlcLib            char(10);
  m3NumCstIdx            int(5);
  M3OfsCstIdxInf         int(10);
  M3Reserved_6           char(46);
end-ds;
//   Array of CHAR(112)	Record format and based-on file list
//   Array of CHAR(320)	Constraint indexes information

//  Record Format and Based-On File List Entry
dcl-ds MBRD0300_basedOnE_t qualified template;
  basedOnFile     char(10);
  basedOnLib      char(10);
  basedOnMbr      char(10);
  fmtName         char(10);
  LFRcdFmtNbr     int(10);
  NbrRcds         int(10);
  NbrDltRcds      int(10);
  AccPathSize     int(10);
  AccPathSizeM    int(10);
  AccPathShared   char(1);
  AccPathValid    char(1);
  AccPathHeld     char(1);
  AccPathOwnrFile char(10);
  AccPathOwnrLib  char(10);
  AccPathOwnrMbr  char(10);
  AccPathJrn      char(1);
  reserved_1      char(2);
  NbrRcdsU        int(10);
  NbrDltRcdsU     int(10);
  reserved_2      char(8);
end-ds;

