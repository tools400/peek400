**free
//===============================================================*
//                                                               *
//  Key Specification Array: Qdb_Qdbfk                           *
//                                                               *
//                                                               *
//===============================================================*

dcl-ds qdb_qdbfk;

  // Field name
  qdbfkfld   char(10);

  // Reserved_59
  reserved59 char(3);

  // Key statement seq. attribute flags
  qdbfksq    char(1);

  // Reserved_61
  reserved61 char(17);
end-ds;

