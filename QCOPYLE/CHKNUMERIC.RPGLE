?     *                                                                                       RADDAT
?     *============================================================*                          RADDAT
?     *    ChkNumeric    Auf numerisches Datenfeld prüfen          *                          RADDAT
?     *============================================================*                          RADDAT
?     *                                                                                       RADDAT
     C     ChkNumeric    BEGSR                                                                RADDAT
?     *                                                                                       RADDAT
 B01 C     F1DTyp        IFEQ      'S'                                          Zoned         RADDAT
     C     F1DTyp        OREQ      'B'                                          Binary        RADDAT
     C     F1DTyp        OREQ      'P'                                          Packed        RADDAT
     C                   MOVEL (P) bTrue         IsNumeric                                    RADDAT
 X01 C                   ELSE                                                                 RADDAT
     C                   MOVEL (P) bFalse        IsNumeric                                    RADDAT
 E01 C                   ENDIF                                                                RADDAT
?     *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
?     *                                                                                       RADDAT
