      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 3.2.6                               *
      *  Programm : PEEK38                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 05.04.2011  Thomas Raddatz                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Erstellen SQL ORDER BY                            *
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
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
      /COPY QCOPYLE,KEYL0100
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D XFile           S             10A
     D XLib            S             10A
     D XsqlOrder       S            512A
      *
      *  Peek41:
     D                 DS
     D YQFile                        20A   INZ(*BLANKS)
     D  YFileDS                      10A   OVERLAY(YQFile: 1)
     D  YLibDS                       10A   OVERLAY(YQFile:11)
     D YRcdFormat      S             10A   INZ(*BLANKS)
     D YFunction       S             10A   INZ(*BLANKS)
     D YNbrOfEnt       S                   like(r§int4    ) inz
     D YData           S            512A   INZ(*BLANKS)
      *
     D PEEK41          S                   like(r§pgmCallN) inz
      *
     D NbrOfKey        S                   like(r§int4    ) inz
     D tempField       S                   Like(XsqlOrder ) inz
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK41
     C     P_Peek41      PLIST
     C                   PARM                    YQFile
     C                   PARM                    YRcdFormat
     C                   PARM                    YFunction
     C                   PARM                    YNbrOfEnt
     C                   PARM                    YData
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
      *  Input
     C                   PARM                    XFile
     C                   PARM                    XLib
      *  Output
     C                   PARM                    XsqlOrder
      *
      *---------------------------------------------------*
      *
      *  Einlesen der Dateiinformationen ...
     C                   EVAL      YFileDS = XFile
     C                   EVAL      YLibDS = XLib
     C                   EVAL      YRcdFormat = '*FIRST'
     C                   EVAL      YFunction = '*CREATE'
     C                   CALL      PEEK41        P_Peek41
      *
      *  Einlesen der Schlüsselinformationen ...
     C                   EVAL      YFunction = '*KEY'
     C                   CALL      PEEK41        P_Peek41
     C                   EVAL      NbrOfKey = YNbrOfEnt
      *
     C                   Eval      tempField = ' '
      *
     C     1             Do        NbrOfKey
     C                   EVAL      YFunction = '*READKEY'
     C                   CALL      PEEK41        P_Peek41
     C                   EVAL      KEYL0100 = YData
      *
     C                   If        tempField = *BLANKS
     C                   Eval      tempField = %trim(tempField) +
     C                                         '"' + %trim(APKEYF) + '"'
     C                   Else
     C                   Eval      tempField = %trim(tempField) +
     C                                         ', "' + %trim(APKEYF) + '"'
     C                   Endif
      *
     C                   Select
     C                   When      APKSEQ = 'A'
     C                   Eval      tempField = %trim(tempField) + ' ASC'
     C                   When      APKSEQ = 'D'
     C                   Eval      tempField = %trim(tempField) + ' DESC'
     C                   Other
      *          keine Schlüsselangaben gefunden
     C                   Endsl
      *
     C                   Enddo
      *
     C                   Eval      XsqlOrder = tempField
      *
     C                   Return
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        Begsr
      *
     C                   Eval      PEEK41 = f_pgmCallN('PEEK41')
      *
     C                   Endsr
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
