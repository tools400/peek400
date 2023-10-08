      *===============================================================*
      *                                                               *
      *  Additional information about MBRD0200:                       *
      *                                                               *
      *                                                               *
      *===============================================================*
      *
      *  API format MBRD0200
      *  (data structure can be used within the calling program
      *  to splitt XValue into its units.)
     D MBRD0200_t      DS                  qualified template
     D  M2BytRet                     10I 0
     D  M2BytAvl                     10I 0
     D  M2File                       10A
     D  M2Library                    10A
     D  M2Member                     10A
     D  M2Attr                       10A
     D  M2SrcTyp                     10A
     D  M2ObjCrtDt                   13A
     D  M2SrcChgDt                   13A
     D  M2Text                       50A
     D  M2SrcFile                     1A
     D  M2Remote                      1A
     D  M2FileTyp                     1A
     D  M2ODPShare                    1A
     D  M2Res_01                      2A
     D  M2NbrRcdOn                   10I 0
     D  M2NbrRcdDl                   10I 0
     D  M2DtaSpcSz                   10U 0
     D  M2AccSpcSz                   10U 0
     D  M2NumBasedOnMbr...
     D                               10I 0
     D  M2ChgDateTime                13A
     D  M2SavDateTime                13A
     D  M2RstDateTime                13A
     D  M2ExpDate                     7A
     D  M2Reserved_1                  4A
     D  M2MediaPref                   5I 0
     D  M2NumDaysUsed                10I 0
     D  M2DateLstUsed                 7A
     D  M2UseResDate                  7A
     D  M2Reserved_2                  2A
     D  M2DtaSizeMult                10I 0
     D  M2AccSizeMult                10I 0
     D  M2MbrTxtCcsid                10I 0
     D  M2OfsAddInf                  10I 0
     D  M2LenAddInf                  10I 0
     D  M2NumRcds                    10U 0
     D  M2NumDltRcds                 10U 0
     D  M2Reserved_3                  6A
      *
