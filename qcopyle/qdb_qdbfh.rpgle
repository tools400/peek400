**free
//===============================================================*
//                                                               *
//  File Definition Header: Qdb_Qdbfh                            *
//                                                               *
//                                                               *
//===============================================================*

dcl-ds Qdb_Qdbfh based(fdh_ptr);
  Qdbfyret  int(10);
  Qdbfyavl  int(10);

  // Number of data members
  Qdbflbnum int(5) pos(15);

  // Offset to the file scope array
  Qdbfos    int(10) pos(317);
end-ds;

