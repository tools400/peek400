      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.0.0                               *
      *  Programm : PEEK03                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 23.10.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Aktualisieren der Feldliste mit Schl�sselinformationen       *
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
     FPEEKFLD   UF   E           K DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     PREFIX(F_)
      *===============================================================*
     D PEEK41          S                   like(r吠gmCallN) inz
      *
      *  list API format KEYL0100
      /COPY QCOPYLE,KEYL0100
      *
      *  list API format FLDL0100
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *---Copystrecken f�r Nachrichtenaufbau---------------*
      /COPY QCOPYLE,USR0006
      *----------------------------------------------------*
      *
      *---Versenden von Nachrichten------------------------*
 CPY  ***/COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
     D XQFile          DS
     D  XFile                        10A
     D  XLib                         10A
     D XRcdFormat      S             10A
     D Xaccess         S              1A
     D XsqlOrder       S            512A
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
     D                 DS
     D YQFile                        20A   INZ(*BLANKS)
     D  YFile                        10A   OVERLAY(YQFile: 1)
     D  YLib                         10A   OVERLAY(YQFile:11)
     D YRcdFormat      S             10A   INZ(*BLANKS)
     D YFunction       S             10A   INZ(*BLANKS)
     D YNbrOfEnt       S                   like(r告nt4    ) inz
     D YData           S            512A   INZ(*BLANKS)
      *
     D nbrOfKey        S                   like(r告nt4    ) inz
      *
     D x               S                   like(r告nt4    ) inz
     D y               S                   like(r告nt4    ) inz
     D z               S                   like(r告nt4    ) inz
     D tempStr         S                   like(xSqlOrder ) inz
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
     C                   PARM                    XQFILE
     C                   PARM                    XRcdFormat
     C                   PARM                    Xaccess
     C                   PARM                    XsqlOrder
      *
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste f�r PEEK41
     C     P_Peek41      PLIST
     C                   PARM                    YQFile
     C                   PARM                    YRcdFormat
     C                   PARM                    YFunction
     C                   PARM                    YNbrOfEnt
     C                   PARM                    YData
      *
     C     F_Key         KLIST
     C                   KFLD                    F_Field
      *
      *---------------------------------------------------*
     C                   EXSR      First
      *---------------------------------------------------*
      *
     C                   IF        xAccess = 吱qlSeq
     C                   EXSR      sqlSeq
     C                   ELSE
     C                   EXSR      otherSeq
     C                   Endif
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     ENDE          TAG
      *
     C     nbrOfKey      IFLE      *ZEROS
     C                   EVAL      XMsgID = 'USR0006'
     C                   EVAL      USR00061 = XFile
     C                   EVAL      USR00062 = XLib
     C                   EVAL      XMsgDta = USR0006
     C                   ELSE
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
     C                   Endif
      *
     C                   EVAL      *INLR = '1'
      *
      *====================================================*
      *  sqlSeq     SQL-Auswahl                            *
      *====================================================*
      *
     C     sqlSeq        BEGSR
      *
     C                   Eval      APKEYN = 0
      *
     C                   Eval      x = 1
     C                   Exsr      getNextFld
      *
     C                   DoW       y > 1
      *
     C                   Eval      tempStr = %trim(%subst(xSqlOrder: x: y-x))
      *  Ende des Feldes ...
     C**   '"'           SCAN      tempStr:2     z
     C                   Eval      z = %scan('"': tempStr: 2)
     C                   Eval      APKEYF  = %trim(%subst(tempStr: 2: z-2))
      *
      *  Alles hinter dem Feld ...
     C                   Eval      tempStr = %trim(%subst(tempStr: z+1))
      *
     C                   Select
     C                   When      tempStr = 'ASC'
     C                   Eval      APKSEQ  = 'A'
     C                   Eval      APKEYN  = APKEYN + 1
     C                   Exsr      AddKeyInf
      *
     C                   When      tempStr = 'DESC'
     C                   Eval      APKSEQ  = 'D'
     C                   Eval      APKEYN  = APKEYN + 1
     C                   Exsr      AddKeyInf
      *
     C                   When      tempStr = ' '
     C                   Eval      APKSEQ  = 'A'
     C                   Eval      APKEYN  = APKEYN + 1
     C                   Exsr      AddKeyInf
     C                   Other
     C                   Endsl
      *
     C                   Eval      x = y + 1
     C                   Exsr      getNextFld
     C                   Enddo
      *
     C                   ENDSR
      *
      *====================================================*
      *  getNextFld  n踄hstes Feld im SQL-String           *
      *====================================================*
      *
     C     getNextFld    BEGSR
      *
     C                   If        x > 512
     C                   Eval      y = 0
     C                   Else
      *
     C**   ','           SCAN      xSqlOrder:x   y
     C                   Eval      y = %scan(',': xSqlOrder: x)
      *
     C                   IF        (y = 0) and
     C                             (%subst(xSqlOrder: x) <> ' ')
     C**   ' '           CHECKR    xSqlOrder     y
     C                   Eval      y = %checkr(' ': xSqlOrder)
     C                   Eval      y = y + 1
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  otherSeq   keine SQl-Auswahl                      *
      *====================================================*
      *
     C     otherSeq      BEGSR
      *
      *  Abrufen der Dateiinformationen ...
     C                   EVAL      YFile = XFile
     C                   EVAL      YLib = XLib
     C                   EVAL      YRcdFormat = XRcdFormat
     C                   EVAL      YFunction = '*CREATE'
     C                   CALL      PEEK41        P_Peek41
     C     YNbrOfEnt     IFLE      *ZEROS
      *  ... schade, Aufruf ist fehlgeschlagen
     C                   ELSE
      *  Einlesen der Schl�sselinformationen ...
     C                   EVAL      YFunction = '*KEY'
     C                   CALL      PEEK41        P_Peek41
     C                   EVAL      nbrOfKey = yNbrOfEnt
      *
     C     1             DO        nbrOfKey
     C                   EVAL      YFunction = '*READKEY'
     C                   CALL      PEEK41        P_Peek41
     C                   EVAL      KEYL0100 = YData
      *
     C                   EXSR      ADDKEYINF
     C                   Enddo
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  AddKeyInf  Hinzuf�gen Schl�sselinformationen      *
      *====================================================*
      *
     C     AddKeyInf     BEGSR
      *
     C                   EVAL      F_Field = APKEYF
     C     F_Key         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '0'
     C                   EVAL      F_Desc = APKSEQ
     C                   EVAL      F_KSeq = APKEYN
     C                   EVAL      FLDL0100 = F_FFD
     C                   EVAL      FLDL0100.F1KEYF = '1'
     C                   EVAL      F_FFD = FLDL0100
     C                   UPDATE    FPEEKFLD
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  First  --  Initialize program                     *
      *====================================================*
      *
     C     First         BEGSR
      *
     C                   Z-ADD     *ZEROS        nbrOfKey
      *
      * - Meldung
     C                   Callp     p_sndStsMg('USR8137': XQFile)
      *
      * - Los gehts'
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
      *
     C                   ENDSR
      *
      *====================================================*
      *  *INZSR --  Initialize program                     *
      *====================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   Eval      PEEK41 = f_pgmCallN('PEEK41')
      *
     C                   OPEN      PEEKFLD
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
     C                   RETURN
      *
     C                   ENDSR     '*CANCL'
      *
      *---Versenden von Nachrichten------------------------*
 CPY  ***/COPY QCOPYLE,MSG_C_MAPI
      *----------------------------------------------------*
      *
