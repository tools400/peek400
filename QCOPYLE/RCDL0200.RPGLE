      *===============================================================*
      *                                                               *
      *  Additional information about RCDL0200:                       *
      *                                                               *
      *                                                               *
      *===============================================================*
      *
      *  API format RCDL0200
      *  (data structure can be used within the calling program
      *  to splitt XValue into its units.)
     D RCDL0200_t      DS                  qualified template
     D  R2FmtName              1     10A
     D  R2FmtID               11     23A
     D  R2Res_01              24     24A
     D  R2RcdLen              25     28I 0
     D  R2NbrFlds             29     32I 0
     D  R2Text                33     82A
     D  R2Res_02              83     84A
     D  R2TxtCCSID            85     88I 0
      *
