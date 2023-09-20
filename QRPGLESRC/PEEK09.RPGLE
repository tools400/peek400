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
      * ============================================================= *
      * >>PRE-COMPILER<<                                              *
*   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
      *                           OBJLIB(&LI) DEVLIB(&LI) +           *
      *                           SBMJOB(*NO) BNDDIR(PEEK) +          *
      *                           INSTALL(*NO);                       *
      *   >>EXECUTE<<                                                 *
      * >>END-PRE-COMPILER<<                                          *
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
      /COPY QCOPYLE,FLDL0100
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
     C                   EVAL      ObjName = XObjName
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
     C                   EVAL      XValue = RcvVar
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
     C                   ELSE
     C                   CLEAR                   OBJD0400
     C                   EVAL      XValue = OBJD0400
     C                   EVAL      XMsgID = §ErrID
     C                   EVAL      XMsgDta = §ErrDta
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
