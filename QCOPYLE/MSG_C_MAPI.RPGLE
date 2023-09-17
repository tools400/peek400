?     *
?     *====================================================*
?     *  MovPgmMsg  - Schieben aller Nachrichten           *                                  RADDAT
?     *               zum aufrufenden Programm             *                                  RADDAT
?     *====================================================*
?     *
     C     MovPgmMsg     BEGSR                                                                RADDAT
?     *
 B01 C     §CallStack    IFLE      *ZEROS                                                     RADDAT
     C                   Z-ADD     2             §CallStack                                   RADDAT
 X01 C                   ELSE                                                                 RADDAT
?     *            Wert beibehalten                                                           RADDAT
 E01 C                   ENDIF                                                                RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL (P) *BLANKS       §MsgKey
?     *
     C                   CALL      'QMHMOVPM'                                                 RADDAT
     C                   PARM                    §MsgKey                                      RADDAT
     C                   PARM                    §TypToMove                                   RADDAT
     C                   PARM                    §NbrToMove                                   RADDAT
     C                   PARM                    §PgmQ                                        RADDAT
     C                   PARM                    §CallStack                                   RADDAT
     C                   PARM                    §ErrorCode                                   RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL (P) *BLANKS       §MsgKey                                      RADDAT
     C                   MOVEL (P) '*'           §PgmQ                                        RADDAT
     C                   Z-ADD     0             §CallStack                                   RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL (P) '*COMP'       §ToMove_1                                    RADDAT
     C                   MOVEL (P) '*DIAG'       §ToMove_2                                    RADDAT
     C                   MOVEL (P) '*INFO'       §ToMove_3                                    RADDAT
     C                   MOVEL (P) '*ESCAPE'     §ToMove_4                                    RADDAT
?     *
     C                   ENDSR
?     *
