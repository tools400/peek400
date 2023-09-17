?     *                                                                   RADDAT
     C                   MOVEL(P)  佝ILE         佝ILE            10                          RADDAT
     C                   MOVEL(P)  劫OFILE       劫OFILE          10                          RADDAT
     C                   MOVEL(P)  劫OLIB        劫OLIB           10                          RADDAT
     C                   MOVEL(P)  別VRSCOPE     別VRSCOPE        10                          RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL(P)  兌N99         兌N99             1                          RADDAT
     C                   MOVEL(P)  刪ETURN       刪ETURN           1                          RADDAT
     C                   MOVEL(P)  利CMD         利CMD           256                          RADDAT
     C                   Z-ADD     利CMDL        利CMDL           15 5                        RADDAT
?     *                                                                                       RADDAT
?     *  鈁erschreiben mit neuer Datei ...                                                    RADDAT
?     *     OVRDSPF                                                                           RADDAT
     C                   MOVEL(P)  'OVRDSPF'     利CMD                                        RADDAT
?     *     File                                                                              RADDAT
     C                   CAT       'FILE(':1     利CMD                                        RADDAT
     C                   CAT       佝ILE:0       利CMD                                        RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
?     *     ToFile                                                                            RADDAT
     C                   CAT       'TO':1        利CMD                                        RADDAT
     C                   CAT       'FILE(':0     利CMD                                        RADDAT
 B01 C     劫OLIB        IFNE      *BLANKS                                                    RADDAT
     C                   CAT       劫OLIB:0      利CMD                                        RADDAT
     C                   CAT       '/':0         利CMD                                        RADDAT
 E01 C                   ENDIF                                                                RADDAT
     C                   CAT       劫OFILE:0     利CMD                                        RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
?     *     OvrScope                                                                          RADDAT
 B01 C     別VRSCOPE     IFNE      *BLANKS                                                    RADDAT
     C                   CAT       'OVR':1       利CMD                                        RADDAT
     C                   CAT       'SCOPE(':0    利CMD                                        RADDAT
     C                   CAT       別VRSCOPE:0   利CMD                                        RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
 E01 C                   ENDIF                                                                RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL(P)  *IN99         兌N99                                        RADDAT
?     *                                                                                       RADDAT
     C                   Z-ADD     256           利CMDL                                       RADDAT
     C                   CALL      'QCMDEXC'                            99                    RADDAT
     C                   PARM                    利CMD                                        RADDAT
     C                   PARM                    利CMDL                                       RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL(P)  *IN99         刪ETURN                                      RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL(P)  兌N99         *IN99                                        RADDAT
?     *                                                                                       RADDAT
