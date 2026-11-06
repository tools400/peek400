**free
//===============================================================*
//                                                               *
//  Additional information about BSPF0100:                       *
//  Based-on physical file                                       *
//                                                               *
//===============================================================*

//  list API format BSPF0100
//  (data structure can be used within the calling program
//  to splitt XData into its units.)
dcl-ds bspf0100_t len(256) qualified template;
  bffile   char(10);
  bflib    char(10);
  bfrcdfmt char(10);
end-ds;

