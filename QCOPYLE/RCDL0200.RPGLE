?     *===============================================================*                       RADDAT
?     *                                                               *                       RADDAT
?     *  Additional information about RCDL0200:                       *                       RADDAT
?     *                                                               *                       RADDAT
?     *                                                               *                       RADDAT
?     *===============================================================*                       RADDAT
?     *                                                                                       RADDAT
?     *  API format RCDL0200                                                                  RADDAT
?     *  (data structure can be used within the calling program                               RADDAT
?     *  to splitt XValue into its units.)                                                    RADDAT
     D RCDL0200        DS                                                                     RADDAT
     D  R2FmtName              1     10A                                                      RADDAT
     D  R2FmtID               11     23A                                                      RADDAT
     D  R2Res_01              24     24A                                                      RADDAT
     D  R2RcdLen              25     28I 0                                                    RADDAT
     D  R2NbrFlds             29     32I 0                                                    RADDAT
     D  R2Text                33     82A                                                      RADDAT
     D  R2Res_02              83     84A                                                      RADDAT
     D  R2TxtCCSID            85     88I 0                                                    RADDAT
?     *                                                                                       RADDAT
