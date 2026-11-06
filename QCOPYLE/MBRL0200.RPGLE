**free
//===============================================================*
//                                                               *
//  Additional information about MBRL0200:                       *
//                                                               *
//   M2MNME - Member name used                                   *
//   M2SRCT - Source type                                        *
//   M2CRDT - Creation date and time                             *
//   M2LCDT - Last source change date and time                   *
//   M2MTXT - Member text description                            *
//   M2TCID - Member text description CCSID                      *
//                                                               *
//===============================================================*

//  list API format MBRL0200
//  (data structure can be used within the calling program
//  to splitt XLIST into its units. See GETDBR_DMO)
dcl-ds mbrl0200_t qualified template;
  m2MNme char(10);
  m2srct char(10);
  m2crdt char(13);
  m2lcdt char(13);
  m2MTxt char(50);
  m2tccs int(10);
end-ds;

