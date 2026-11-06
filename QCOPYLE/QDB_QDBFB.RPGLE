**free
//===============================================================*
//                                                               *
//  File Scope Array: Qdb_Qdbfb                                  *
//                                                               *
//                                                               *
//===============================================================*

dcl-ds qdb_qdbfb;

  // Based on physical file/library
  qdbfbf   char(10) pos(49);
  qdbfbfl  char(10);

  // Record format name
  qdbft    char(10);

  // Bbr of select/omit statements
  qdbfsoon int(5) pos(129);

  // Offset to the select/omit specification array
  qdbfsoof int(10);

  // Offset to the key specification array
  qdbfksof int(10);

  // Record format full  key field count
  qdbfksof int(5);
end-ds;

