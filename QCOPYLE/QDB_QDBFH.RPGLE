**FREE
//===============================================================*
//                                                               *
//  File Definition Header: Qdb_Qdbfh                            *
//                                                               *
//                                                               *
//===============================================================*
//
dcl-ds qdb_qdbfh based(fdh_ptr);
  qdbfyret        int(10);
  qdbfyavl        int(10);
  //
  // Number of data members
  qdbflbnum       int(5) pos(15);
  //
  // Offset to the file scope array
  qdbfos          int(10) pos(317);
end-ds;
//
