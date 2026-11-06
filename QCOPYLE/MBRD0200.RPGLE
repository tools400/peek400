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
dcl-ds MBRD0200_t qualified template;
  M2BytRet        int(10);
  m2bytAvl        int(10);
  M2File          char(10);
  M2Library       char(10);
  M2Member        char(10);
  M2Attr          char(10);
  M2SrcTyp        char(10);
  M2ObjCrtDt      char(13);
  M2SrcChgDt      char(13);
  M2Text          char(50);
  M2SrcFile       char(1);
  M2Remote        char(1);
  M2FileTyp       char(1);
  M2ODPShare      char(1);
  M2Res_01        char(2);
  M2NbrRcdOn      int(10);
  M2NbrRcdDl      int(10);
  M2DtaSpcSz      uns(10);
  M2AccSpcSz      uns(10);
  M2NumBasedOnMbr int(10);
  M2ChgDateTime   char(13);
  M2SavDateTime   char(13);
  M2RstDateTime   char(13);
  M2ExpDate       char(7);
  M2Reserved_1    char(4);
  M2MediaPref     int(5);
  M2NumDaysUsed   int(10);
  M2DateLstUsed   char(7);
  M2UseResDate    char(7);
  M2Reserved_2    char(2);
  M2DtaSizeMult   int(10);
  M2AccSizeMult   int(10);
  M2MbrTxtCcsid   int(10);
  M2OfsAddInf     int(10);
  M2LenAddInf     int(10);
  M2NumRcds       uns(10);
  M2NumDltRcds    uns(10);
  M2Reserved_3    char(6);
end-ds;

