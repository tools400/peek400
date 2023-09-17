?     *                                                                                       RADDAT
     C                   MOVEL (P) 別BJ          別BJ             10                          RADDAT
     C                   MOVEL (P) 兵IB          兵IB             10                          RADDAT
     C                   MOVEL (P) 別BJTYPE      別BJTYPE         10                          RADDAT
     C                   MOVEL (P) 冶BR          冶BR             10                          RADDAT
     C                   MOVEL (P) 你UT          你UT             10                          RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL (P) 兌N99         兌N99             1                          RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL (P) 刪ETURN       刪ETURN           1                          RADDAT
     C                   MOVEL (P) 利CMD         利CMD           256                          RADDAT
     C                   Z-ADD     利CMDL        利CMDL           15 5                        RADDAT
?     *                                                                                       RADDAT
?     *  Pr�fen Objekt ...                                                                    RADDAT
?     *     CHKOBJ                                                                            RADDAT
     C                   MOVEL (P) 'CHKOBJ'      利CMD                                        RADDAT
?     *     Objekt                                                                            RADDAT
     C                   CAT       'OBJ(':1      利CMD                                        RADDAT
?     *     - Bibliothek                                                                      RADDAT
 B01 C     兵IB          IFNE      *BLANKS                                                    RADDAT
     C                   CAT       兵IB:0        利CMD                                        RADDAT
 X01 C                   ELSE                                                                 RADDAT
     C                   CAT       '*LIBL':0     利CMD                                        RADDAT
 E01 C                   ENDIF                                                                RADDAT
     C                   CAT       '/':0         利CMD                                        RADDAT
     C                   CAT       別BJ:0        利CMD                                        RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
?     *     Objekttyp                                                                         RADDAT
     C                   CAT       'OBJTYPE(':1  利CMD                                        RADDAT
     C                   CAT       別BJTYPE:0    利CMD                                        RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
?     *     Member                                                                            RADDAT
     C                   CAT       'MBR(':1      利CMD                                        RADDAT
 B01 C     冶BR          IFNE      *BLANKS                                                    RADDAT
     C                   CAT       冶BR:0        利CMD                                        RADDAT
 X01 C                   ELSE                                                                 RADDAT
     C                   CAT       '*NONE'       利CMD                                        RADDAT
 E01 C                   ENDIF                                                                RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
?     *     Berechtigung                                                                      RADDAT
     C                   CAT       'AUT(':1      利CMD                                        RADDAT
 B01 C     你UT          IFNE      *BLANKS                                                    RADDAT
     C                   CAT       你UT:0        利CMD                                        RADDAT
 X01 C                   ELSE                                                                 RADDAT
     C                   CAT       '*NONE'       利CMD                                        RADDAT
 E01 C                   ENDIF                                                                RADDAT
     C                   CAT       ')':0         利CMD                                        RADDAT
?     *                                                                                       RADDAT
?     *     Pr�fung durchf�hren ...                                                           RADDAT
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
