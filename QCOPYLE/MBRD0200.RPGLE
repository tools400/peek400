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
     D  M2BytRet               1      4I 0
     D  M2BytAvail             5      8I 0
     D  M2File                 9     18A
     D  M2Library             19     28A
     D  M2Member              29     38A
     D  M2Attr                39     48A
     D  M2SrcTyp              49     58A
     D  M2ObjCrtDt            59     71A
     D  M2SrcChgDt            72     84A
     D  M2Text                85    134A
     D  M2SrcFile            135    135A
     D  M2Remote             136    136A
     D  M2FileTyp            137    137A
     D  M2ODPShare           138    138A
     D  M2Res_01             139    140A
     D  M2NbrRcdOn           141    144I 0
     D  M2NbrRcdDl           145    148I 0
     D  M2DtaSpcSz           149    152U 0
     D  M2AccSpcSz           153    156U 0
      *
