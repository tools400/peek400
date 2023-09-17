      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK09                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 02.10.96  RADDATZ                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Ermitteln der Objektattribute                                *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  INPUT-Parameter:                                             *
      *  ================                                             *
      *                                                               *
      *  XQObj   - Qualifizierter Objektname                          *
      *                                                               *
      *  OUTPUT-Parameter:                                            *
      *  =================                                            *
      *                                                               *
      *  XValue  - Objektinformationen im Format OBJD0400             *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      *----------------------------------------------------*
      *  API - DATENSTRUKTUREN                             *
      *----------------------------------------------------*
      *
      *  declarations for QUSROBJD
     D RcvVar          S            512A   INZ
     D RcvvarLen       S                   INZ(512)         LIKE(R§INT4)
     D FormatName      S              8A   INZ('OBJD0400')
     D ObjName         S             20A   INZ
     D ObjType         S             10A   INZ('*FILE')
      *
     D XObjName        S             20A
     D XValue          S            512A
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
      /COPY QCOPYLE,OBJD0400
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *---Versenden von Nachrichten------------------------*
      /COPY QCOPYLE,API_ERROR
 CPY  ***/COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *           Main  Control block                                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
      *  Input
     C                   PARM                    XObjName
      *  Output
     C                   PARM                    XValue
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *---------------------------------------------------*
      *
      * - Meldung
     C                   Callp     p_sndStsMg('USR8107': XObjName)
      *
     C                   MOVEL (P) XObjName      ObjName
      *
     C                   CALL      'QUSROBJD'
     C                   PARM                    RcvVar
     C                   PARM                    RcvVarLen
     C                   PARM                    FormatName
     C                   PARM                    ObjName
     C                   PARM                    ObjType
     C                   PARM                    §ErrorCode
      *
     C     §ErrAvail     IFEQ      *ZEROS
     C                   MOVEL (P) RcvVar        XValue
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
     C                   ELSE
     C                   CLEAR                   OBJD0400
     C                   MOVEL (P) OBJD0400      XValue
     C                   MOVEL (P) §ErrID        XMsgID
     C                   MOVEL (P) §ErrDta       XMsgDta
     C                   Endif
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *====================================================*
      *  *INZSR --  Initialize program                     *
      *====================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   ENDSR
      *
      *====================================================*
      *  *PSSR  --  Program error handler                  *
      *====================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   DUMP
      *
     C                   GOTO      ENDE
      *
     C                   ENDSR     '*CANCL'
      *
      *---Versenden von Nachrichten------------------------*
 CPY  ***/COPY QCOPYLE,MSG_C_MAPI
      *----------------------------------------------------*
      *
