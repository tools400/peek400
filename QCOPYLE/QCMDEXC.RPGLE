?     *                                                                                       RADDAT
     C                   MOVEL (P) *IN99         利Cmd99           1                          RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL (P) 利Cmd         利Cmd           256                          RADDAT
     C                   Z-ADD     256           利CmdLen         15 5                        RADDAT
     C                   CALL      'QCMDEXC'                            99                    RADDAT
     C                   PARM                    利Cmd                                        RADDAT
     C                   PARM                    利CmdLen                                     RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL (P) *IN99         利CmdError        1                          RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL (P) 利Cmd99       *IN99                                        RADDAT
?     *                                                                                       RADDAT
