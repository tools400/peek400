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
dcl-ds mbrd0200_t qualified template;
  m2BytRet        int(10);
  m2bytAvl        int(10);
  m2File          char(10);
  m2Library       char(10);
  m2Member        char(10);
  m2Attr          char(10);
  m2SrcTyp        char(10);
  m2ObjCrtDt      char(13);
  m2SrcChgDt      char(13);
  m2Text          char(50);
  m2SrcFile       char(1);
  m2Remote        char(1);
  m2FileTyp       char(1);
  m2ODPShare      char(1);
  m2Res_01        char(2);
  m2NbrRcdOn      int(10);
  m2NbrRcdDl      int(10);
  m2DtaSpcSz      uns(10);
  m2AccSpcSz      uns(10);
  m2NumBasedOnMbr int(10);
  m2ChgDateTime   char(13);
  m2SavDateTime   char(13);
  m2RstDateTime   char(13);
  m2ExpDate       char(7);
  m2Reserved_1    char(4);
  m2MediaPref     int(5);
  m2NumDaysUsed   int(10);
  m2DateLstUsed   char(7);
  m2UseResDate    char(7);
  m2Reserved_2    char(2);
  m2DtaSizeMult   int(10);
  m2AccSizeMult   int(10);
  m2MbrTxtCcsid   int(10);
  m2OfsAddInf     int(10);
  m2LenAddInf     int(10);
  m2NumRcds       uns(10);
  m2NumDltRcds    uns(10);
  m2Reserved_3    char(6);
end-ds;

