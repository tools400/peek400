?     *                                                                   RADDAT
 B01 C                   If        'Nur' = 'zur Definition'
     C                   MOVEL(P)  佝ILE         佝ILE            10                          RADDAT
     C                   MOVEL(P)  劫OFILE       劫OFILE          10                          RADDAT
     C                   MOVEL(P)  劫OLIB        劫OLIB           10                          RADDAT
     C                   MOVEL(P)  冶BR          冶BR             10                          RADDAT
     C                   MOVEL(P)  刨EQONLY      刨EQONLY         10                          RADDAT
     C                   MOVEL(P)  別VRSCOPE     別VRSCOPE        10                          RADDAT
     C                   MOVEL(P)  刨HARE        刨HARE           10                          RADDAT
     C                   MOVEL(P)  刨ECURE       刨ECURE          10                          RADDAT
     C                   MOVEL(P)  兵VLCHK       兵VLCHK          10                          RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL(P)  兌N99         兌N99             1                          RADDAT
     C                   MOVEL(P)  刪ETURN       刪ETURN           1                          RADDAT
     C                   MOVEL(P)  利CMD         利CMD           256                          RADDAT
     C                   Z-ADD     利CMDL        利CMDL           15 5                        RADDAT
 E01 C                   Endif
?     *                                                                                       RADDAT
?     *  鈁erschreiben mit neuer Datei ...                                                    RADDAT
?     *     OVRDBF                                                                            RADDAT
     C                   MOVEL(P)  'OVRDBF'      利CMD                                        RADDAT
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
?     *     Mbr                                                                               RADDAT
 B01 C     冶BR          IFNE      *BLANKS                                                    RADDAT
     C                   CAT       'MBR(':1      利CMD                                        RADDAT
     C                   CAT       冶BR:0        利CMD                                        RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
 E01 C                   ENDIF                                                                RADDAT
?     *     OvrScope                                                                          RADDAT
 B01 C     別VRSCOPE     IFNE      *BLANKS                                                    RADDAT
     C                   CAT       'OVR':1       利CMD                                        RADDAT
     C                   CAT       'SCOPE(':0    利CMD                                        RADDAT
     C                   CAT       別VRSCOPE:0   利CMD                                        RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
 E01 C                   ENDIF                                                                RADDAT
?     *     Share                                                                             RADDAT
 B01 C     刨HARE        IFNE      *BLANKS                                                    RADDAT
     C                   CAT       'SHARE(':1    利CMD                                        RADDAT
     C                   CAT       刨HARE:0      利CMD                                        RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
 E01 C                   ENDIF                                                                RADDAT
?     *     SeqOnly                                                                           RADDAT
 B01 C     刨EQONLY      IFNE      *BLANKS                                                    RADDAT
     C                   CAT       'SEQ':1       利CMD                                        RADDAT
     C                   CAT       'ONLY(':0     利CMD                                        RADDAT
     C                   CAT       刨EQONLY:0    利CMD                                        RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
 E01 C                   ENDIF                                                                RADDAT
?     *     Secure                                                                            RADDAT
 B01 C     刨ECURE       IFNE      *BLANKS                                                    RADDAT
     C                   CAT       'SECURE(':1   利CMD                                        RADDAT
     C                   CAT       刨ECURE:0     利CMD                                        RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
 E01 C                   ENDIF                                                                RADDAT
?     *     Level Check                                                                       RADDAT
 B01 C     兵VLCHK       IFNE      *BLANKS                                                    RADDAT
     C                   CAT       'LVLCHK(':1   利CMD                                        RADDAT
     C                   CAT       兵VLCHK:0     利CMD                                        RADDAT
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
