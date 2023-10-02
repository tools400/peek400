      *===============================================================*
      *                                                               *
      *  File Scope Array: Qdb_Qdbfb                                  *
      *                                                               *
      *                                                               *
      *===============================================================*
      *
     D Qdb_Qdbfb       DS
      *
      * Based on physical file/library
     D  Qdbfbf                49     58A
     D  Qdbfbfl               59     68A
      *
      * Record format name
     D  Qdbft                 69     78A
      *
      * Bbr of select/omit statements
     D  Qdbfsoon             129    130I 0
      *
      * Offset to the select/omit specification array
     D  Qdbfsoof             131    134I 0
      *
      * Offset to the key specification array
     D  Qdbfksof             135    138I 0
      *
      * Record format full  key field count
     D  Qdbfksof             139    140I 0
      *
