      *===============================================================*
      *                                                               *
      *  File Definition Header: Qdb_Qdbfh                            *
      *                                                               *
      *                                                               *
      *===============================================================*
      *
     D Qdb_Qdbfh       DS                  BASED(FDH_Ptr)
     D  Qdbfyret               1      4I 0
     D  Qdbfyavl               5      8I 0
      *
      * Number of data members
     D  Qdbflbnum             15     16I 0
      *
      * Offset to the file scope array
     D  Qdbfos               317    320I 0
      *
