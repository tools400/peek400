**free
//===============================================================*
//                                                               *
//  Additional information about OBJD0400:                       *
//                                                               *
//                                                               *
//===============================================================*

//  API format OBJD0400
//  (data structure can be used within the calling program
//  to splitt XValue into its units.)
dcl-ds OBJD0400_t qualified template;
  O4BytRet   int(10) pos(1);
  O4BytAvail int(10) pos(5);
  O4ObjName  char(10) pos(9);
  O4ObjLib   char(10) pos(19);
  O4ObjType  char(10) pos(29);
  O4RetLib   char(10) pos(39);
  O4AuxStPol int(10) pos(49);
  O4Owner    char(10) pos(53);
  O4Domain   char(2) pos(63);
  O4CrtDtTme char(13) pos(65);
  O4ChgDtTme char(13) pos(78);
  O4ExtAttr  char(10) pos(91);
  O4Text     char(50) pos(101);
  O4SrcFile  char(10) pos(151);
  O4SrcLib   char(10) pos(161);
  O4SrcMbr   char(10) pos(171);
  //   :
  *n         char(292) pos(181);
  //   :
  O4ObjSize  int(10) pos(473);
  O4ObjSizeM int(10) pos(477);
end-ds;

