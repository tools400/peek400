      *
     C                   SELECT
     C     ScnFld        WHENEQ    '##FIELD'
     C                   MOVEL (P) ##FIELD       R#FIELD          10
     C                   MOVEL (P) ##FIELD       YData
     C                   MOVEL (P) *BLANKS       YDataTyp
     C                   Z-ADD     10            YDataLen
     C     ScnFld        WHENEQ    '##MEMBER'
     C                   MOVEL (P) ##MEMBER      R#MEMBER         10
     C                   MOVEL (P) ##MEMBER      YData
     C                   MOVEL (P) *BLANKS       YDataTyp
     C                   Z-ADD     10            YDataLen
     C                   OTHER
     C                   MOVEL (P) *BLANKS       YData
     C                   MOVEL (P) *BLANKS       YDataTyp
     C                   Z-ADD     *ZEROS        YDataLen
     C                   ENDSL
      *
     C                   MOVEL (P) ScnFld        YPromptFor
     C                   CALL      PEEK38        P_Peek38               99
     C     *IN99         IFEQ      '1'
      *  ... Fehler, also ungültige Rückgabedaten
     C                   ELSE
      *
     C     YMsgID        IFNE      *BLANKS
      *
     C     yMsgID        IFEQ      '*NONE'
     C                   MOVEL (P) *BLANKS       yMsgID
     C                   MOVEL (P) *BLANKS       yMsgDta
     C                   ENDIF
      *
     C                   SELECT
     C     ScnFld        WHENEQ    '##FIELD'
     C                   MOVEL (P) R#FIELD       ##Field
     C     ScnFld        WHENEQ    '##MEMBER'
     C                   MOVEL (P) R#MEMBER      ##MEMBER
     C                   ENDSL
      *
     C                   ELSE
      *
     C                   SELECT
     C     ScnFld        WHENEQ    '##FIELD'
     C     YDataLen      SUBST (P) YRetData      ##Field          10
     C     ScnFld        WHENEQ    '##MEMBER'
     C     YDataLen      SUBST (P) YRetData      ##MEMBER         10
     C                   ENDSL
      *
     C                   ENDIF
      *
     C                   ENDIF
      *
