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
dcl-ds rcdl0200_t qualified template;
  r2fmtname  char(10);
  r2fmtid    char(13);
  r2res_01   char(1);
  r2rcdlen   int(10);
  r2nbrflds  int(10);
  r2text     char(50);
  r2res_02   char(2);
  r2txtccsid int(10);
end-ds;

