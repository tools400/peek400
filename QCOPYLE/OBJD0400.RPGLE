**FREE
//===============================================================*
//                                                               *
//  Additional information about OBJD0400:                       *
//                                                               *
//                                                               *
//===============================================================*
//
//  API format OBJD0400
//  (data structure can be used within the calling program
//  to splitt XValue into its units.)
dcl-ds objd0400_t qualified template;
  o4bytret        int(10) pos(1);
  o4bytavail      int(10) pos(5);
  o4objname       char(10) pos(9);
  o4objlib        char(10) pos(19);
  o4objtype       char(10) pos(29);
  o4retlib        char(10) pos(39);
  o4auxstpol      int(10) pos(49);
  o4owner         char(10) pos(53);
  o4domain        char(2) pos(63);
  o4crtdttme      char(13) pos(65);
  o4chgdttme      char(13) pos(78);
  o4extattr       char(10) pos(91);
  o4text          char(50) pos(101);
  o4srcfile       char(10) pos(151);
  o4srclib        char(10) pos(161);
  o4srcmbr        char(10) pos(171);
  //   :
  *N              char(292) pos(181);
  //   :
  o4objsize       int(10) pos(473);
  o4objsizem      int(10) pos(477);
end-ds;
//
