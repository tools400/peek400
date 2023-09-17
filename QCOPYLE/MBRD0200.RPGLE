?     *===============================================================*                       RADDAT
?     *                                                               *                       RADDAT
?     *  Additional information about MBRD0200:                       *                       RADDAT
?     *                                                               *                       RADDAT
?     *                                                               *                       RADDAT
?     *===============================================================*                       RADDAT
?     *                                                                                       RADDAT
?     *  API format MBRD0200                                                                  RADDAT
?     *  (data structure can be used within the calling program                               RADDAT
?     *  to splitt XValue into its units.)                                                    RADDAT
     D MBRD0200        DS                                                                     RADDAT
     D  M2BytRet               1      4I 0                                                    RADDAT
     D  M2BytAvail             5      8I 0                                                    RADDAT
     D  M2File                 9     18A                                                      RADDAT
     D  M2Library             19     28A                                                      RADDAT
     D  M2Member              29     38A                                                      RADDAT
     D  M2Attr                39     48A                                                      RADDAT
     D  M2SrcTyp              49     58A                                                      RADDAT
     D  M2ObjCrtDt            59     71A                                                      RADDAT
     D  M2SrcChgDt            72     84A                                                      RADDAT
     D  M2Text                85    134A                                                      RADDAT
     D  M2SrcFile            135    135A                                                      RADDAT
     D  M2Remote             136    136A                                                      RADDAT
     D  M2FileTyp            137    137A                                                      RADDAT
     D  M2ODPShare           138    138A                                                      RADDAT
     D  M2Res_01             139    140A                                                      RADDAT
     D  M2NbrRcdOn           141    144I 0                                                    RADDAT
     D  M2NbrRcdDl           145    148I 0                                                    RADDAT
     D  M2DtaSpcSz           149    152U 0                                                    RADDAT
     D  M2AccSpcSz           153    156U 0                                                    RADDAT
?     *                                                                                       RADDAT
