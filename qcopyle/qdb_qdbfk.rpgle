**free
      //%METADATA                                                      *
      // %TEXT Key Specification Array: Qdb_Qdbfk                      *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  Key Specification Array: Qdb_Qdbfk                           *
//                                                               *
//                                                               *
//===============================================================*

dcl-ds Qdb_Qdbfk;

  // Field name
  Qdbfkfld   char(10);

  // reserved_59
  reserved59 char(3);

  // Key statement seq. attribute flags
  Qdbfksq    char(1);

  // reserved_61
  reserved61 char(17);
end-ds;

