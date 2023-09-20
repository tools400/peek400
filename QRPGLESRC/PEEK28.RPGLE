      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK28                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 03.11.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Ermitteln Systemwerte                                        *
      *                                                               *
      *===============================================================*
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
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *---Fehler-DS----------------------------------------*
      /COPY QCOPYLE,API_ERROR
 CPY  ***/COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
     D XAttr           S             10A
     D XNoMsg          S              1A
     D XAttrLen        S                   like(r§int4    )
     D XAttrTyp        S              1A
     D XValue          S            512A
      *
     D YRcvVar         DS           128    INZ
     D   RcvNbrRet             1      4I 0
     D   RcvOffset             5      8I 0
     D   RcvData               9    128A
      *
     D YRcvVarLen      S                   INZ(128)       LIKE(R§INT4)
     D YNbrOfSysV      S                   INZ(1)         LIKE(R§INT4)
     D YSysValNme      S             10A   INZ('QSRLNBR')
      *
     D YSystemVal      DS           128    INZ
     D   SystemVal             1     10A
     D   TypeOfData           11     11A
     D   InfStatus            12     12A
     D   LenOfData            13     16I 0
     D   SysValData           17    128A
      *
     D X               S                   like(r§int4    ) inz
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
      *  Input
     C                   PARM                    XAttr
     C                   PARM                    XNoMsg
      *  Output
     C                   PARM                    XAttrLen
     C                   PARM                    XAttrTyp
     C                   PARM                    XValue
      *
      *---------------------------------------------------*
      *
      * - Meldung
     C     XNoMsg        IFEQ      bTrue
     C                   Callp     p_sndStsMg('USR8157': ' ')
     C                   ELSE
      *        keine Statusmeldung ausgeben
     C                   Endif
      *
      * - Seriennummer
     C                   EVAL      YSysValNme = XAttr
      *
     C                   CALL      'QWCRSVAL'
     C                   PARM                    YRcvVar
     C                   PARM                    YRcvVarLen
     C                   PARM                    YNbrOfSysV
     C                   PARM                    YSysValNme
     C                   PARM                    §ErrorCode
      *
     C     §ErrAvail     IFEQ      *ZEROS
     C                   EXSR      GetAttr
     C                   ELSE
     C                   EVAL      XAttrLen = *ZEROS
     C                   EVAL      XAttrTyp = *BLANKS
     C                   EVAL      XValue = *BLANKS
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
      *  GetAttr -  Abrufen der Attributwertes             *
      *====================================================*
      *
     C     GetAttr       BEGSR
      *
     C                   EVAL      X = RcvOffset + 1
     C**                 SUBST (P) YRcvVar:X     YSystemVal
     C                   EVAL      YSystemVal = %subst(YRcvVar: X)
      *
     C                   EVAL      XAttrLen = LenOfData
     C                   EVAL      XAttrTyp = TypeOfData
      *
     C                   EVAL      X = 1
     C**   XAttrLen      SUBST (P) SysValData:X  XValue
     C                   EVAL      XValue = %subst(SysValData: X: XAttrLen)
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Initialisierung                           *
      *============================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   ENDSR
      *
      *============================================================*
      *    *PSSR         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   DUMP
      *
     C                   ENDSR     '*CANCL'
      *
      *---Versenden von Nachrichten------------------------*
 CPY  ***/COPY QCOPYLE,MSG_C_MAPI
      *----------------------------------------------------*
      *
