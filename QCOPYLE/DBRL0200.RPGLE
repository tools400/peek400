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
  b2fnmeused   char(10);
  b2lnmeused   char(10);
  b2mnmeused   char(10);
  b2depfile    char(10);
  b2deplib     char(10);
  b2depmbr     char(10);
  b2deptype    char(1);
  b2res_01     char(3);
  b2joinrnbr   int(10);
  b2joinfnbr   int(10);
  b2cnstnmelib char(10);
  b2cnstnmelen int(10);
  b2cnstnme    char(258);
end-ds;

