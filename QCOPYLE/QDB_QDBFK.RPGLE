**free
//===============================================================*
//                                                               *
//  Key Specification Array: Qdb_Qdbfk                           *
//                                                               *
//                                                               *
//===============================================================*

dcl-ds Qdb_Qdbfk;

  // Field name
  Qdbfkfld   char(10);

  // Reserved_59
  Reserved59 char(3);

  // Key statement seq. attribute flags
  Qdbfksq    char(1);

  // Reserved_61
  Reserved61 char(17);
end-ds;

