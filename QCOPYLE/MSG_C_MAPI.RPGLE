      *
      *====================================================*
      *  MovPgmMsg  - Schieben aller Nachrichten           *
      *               zum aufrufenden Programm             *
      *====================================================*
      *
     C     MovPgmMsg     BEGSR
      *
     C     §CallStack    IFLE      *ZEROS
     C                   Z-ADD     2             §CallStack
     C                   ELSE
      *            Wert beibehalten
     C                   ENDIF
      *
     C                   MOVEL (P) *BLANKS       §MsgKey
      *
     C                   CALL      'QMHMOVPM'
     C                   PARM                    §MsgKey
     C                   PARM                    §TypToMove
     C                   PARM                    §NbrToMove
     C                   PARM                    §PgmQ
     C                   PARM                    §CallStack
     C                   PARM                    §ErrorCode
      *
     C                   MOVEL (P) *BLANKS       §MsgKey
     C                   MOVEL (P) '*'           §PgmQ
     C                   Z-ADD     0             §CallStack
      *
     C                   MOVEL (P) '*COMP'       §ToMove_1
     C                   MOVEL (P) '*DIAG'       §ToMove_2
     C                   MOVEL (P) '*INFO'       §ToMove_3
     C                   MOVEL (P) '*ESCAPE'     §ToMove_4
      *
     C                   ENDSR
      *
