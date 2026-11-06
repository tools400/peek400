**free
//===============================================================*
//                                                               *
//  Additional information about DBRL0200:                       *
//                                                               *
//                                                               *
//===============================================================*

//  list API format DBRL0200
//  (data structure can be used within the calling program
//  to splitt XLIST into its units.)
dcl-ds dbrl0200_t qualified template;
  B2FNmeUsed   char(10);
  B2LNmeUsed   char(10);
  B2MNmeUsed   char(10);
  B2DepFile    char(10);
  B2DepLib     char(10);
  B2DepMbr     char(10);
  B2DepType    char(1);
  B2Res_01     char(3);
  B2JoinRNbr   int(10);
  B2JoinFNbr   int(10);
  B2CnstNmeLib char(10);
  B2CnstNmeLen int(10);
  B2CnstNme    char(258);
end-ds;

