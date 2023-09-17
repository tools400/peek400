?     *                                                                   RADDAT
     C                   MOVEL(P)  佝ILE         佝ILE            10                          RADDAT
     C                   MOVEL(P)  兵VL          兵VL             10                          RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL(P)  兌N99         兌N99             1                          RADDAT
     C                   MOVEL(P)  刪ETURN       刪ETURN           1                          RADDAT
     C                   MOVEL(P)  利CMD         利CMD           256                          RADDAT
     C                   Z-ADD     利CMDL        利CMDL           15 5                        RADDAT
?     *                                                                                       RADDAT
?     *  L飉chen der Datei�berschreibung ...                                                  RADDAT
?     *     DLTOVR                                                                            RADDAT
     C                   MOVEL(P)  'DLTOVR'      利CMD                                        RADDAT
?     *     File                                                                              RADDAT
     C                   CAT       'FILE(':1     利CMD                                        RADDAT
     C                   CAT       佝ILE:0       利CMD                                        RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
?     *     LVL                                                                               RADDAT
 B01 C     兵VL          IFNE      *BLANKS                                                    RADDAT
     C                   CAT       'LVL(':1      利CMD                                        RADDAT
     C                   CAT       兵VL:0        利CMD                                        RADDAT
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
