**free
//===============================================================*
//                                                               *
//  Additional information about RCDL0200:                       *
//                                                               *
//                                                               *
//===============================================================*

//  API format RCDL0200
//  (data structure can be used within the calling program
//  to splitt XValue into its units.)
dcl-ds RCDL0200_t qualified template;
  R2FmtName  char(10);
  R2FmtID    char(13);
  R2Res_01   char(1);
  R2RcdLen   int(10);
  R2NbrFlds  int(10);
  R2Text     char(50);
  R2Res_02   char(2);
  R2TxtCCSID int(10);
end-ds;

