      *
      *====================================================*
      *  Definitionen für Format: RTVM0100  (QMHRTVM)      *
      *====================================================*
      *
     D RTVM0100        DS          2048
     D  RT1_BytRet             1      4I 0 INZ(0)
     D  RT1_BytAvl             5      8I 0 INZ(0)
     D  RT1_LnMgRt             9     12I 0 INZ(0)
     D  RT1_LnMgAv            13     16I 0 INZ(0)
     D  RT1_LnMhRt            17     20I 0 INZ(0)
     D  RT1_LnMhAv            21     24I 0 INZ(0)
     D  RT1_Data              25   2048A   INZ(*BLANKS)
      *
