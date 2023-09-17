      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK13                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 07.10.96  RADDATZ                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Ermitteln der Teildateibeschreibung                          *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  INPUT-Parameter:                                             *
      *  ================                                             *
      *                                                               *
      *  XQFile  - Qualifizierter Dateiname                           *
      *  XMbr    - Name der Teildatei                                 *
      *                                                               *
      *  OUTPUT-Parameter:                                            *
      *  =================                                            *
      *                                                               *
      *  XValue  - Objektinformationen im Format MBRD0200             *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      *----------------------------------------------------*
      *  API - DATENSTRUKTUREN                             *
      *----------------------------------------------------*
      *
      *  declarations for QUSRMBRD
     D RcvVar          S            512A   INZ
     D RcvvarLen       S                   INZ(512)         LIKE(R§INT4)
     D FormatName      S              8A   INZ('MBRD0200')
     D FileName        S             20A   INZ
     D Member          S             10A   INZ
     D Override        S              1A   INZ('0')
      *
     D XQFile          S             20A
     D XMbr            S             10A
     D XValue          S            512A
      *
      /COPY QCOPYLE,MBRD0200
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
     C                   PARM                    XQFile
     C                   PARM                    XMbr
      *  Output
     C                   PARM                    XValue
      *
      *---------------------------------------------------*
      *
      * - Meldung
     C                   Callp     p_sndStsMg('USR8109': xQFile + xMbr)
      *
     C                   MOVEL (P) XQFile        FileName
     C                   MOVEL (P) XMbr          Member
      *
     C                   CALL      'QUSRMBRD'
     C                   PARM                    RcvVar
     C                   PARM                    RcvVarLen
     C                   PARM                    FormatName
     C                   PARM                    FileName
     C                   PARM                    Member
     C                   PARM                    Override
     C                   PARM                    §ErrorCode
      *
     C     §ErrAvail     IFEQ      *ZEROS
     C                   MOVEL (P) RcvVar        XValue
     C                   ELSE
     C                   CLEAR                   MBRD0200
     C                   MOVEL (P) MBRD0200      XValue
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
