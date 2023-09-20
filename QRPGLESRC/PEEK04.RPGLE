      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK04                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 28.10.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Abrufen der Dateiinformationen: hier prüfen auf              *
      *                                  Schlüsselinformationen       *
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
      *  list API format KEYL0100
      /COPY QCOPYLE,KEYL0100
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *---Copystrecken für Nachrichtenaufbau---------------*
      /COPY QCOPYLE,USR0006
      *----------------------------------------------------*
      *
      *---Versenden von Nachrichten------------------------*
      /COPY QCOPYLE,API_ERROR
 CPY  ***/COPY QCOPYLE,MSG_D_MAPI
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
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
     D                 DS
     D YQFile                        20A   INZ(*BLANKS)
     D  YFile                        10A   OVERLAY(YQFile: 1)
     D  YLib                         10A   OVERLAY(YQFile:11)
     D YRcdFormat      S             10A   INZ(*BLANKS)
     D YFunction       S             10A   INZ(*BLANKS)
     D YNbrOfEnt       S                   like(r§int4    ) inz
     D YData           S            512A   INZ(*BLANKS)
      *
     D PEEK41          S                   like(r§pgmCallN) inz
      *
     D nbrOfKey        S                   like(r§int4    ) inz
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
      *
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
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
      *---------------------------------------------------*
     C                   EXSR      First
      *---------------------------------------------------*
      *
      *  Abrufen der Dateiinformationen ...
     C                   EVAL      YFile = XFile
     C                   EVAL      YLib = XLib
     C                   EVAL      YRcdFormat = XRcdFormat
     C                   EVAL      YFunction = '*CREATE'
     C                   CALL      PEEK41        P_Peek41
      *
     C     yNbrOfEnt     IFLE      *ZEROS
      *  ... schade, Aufruf ist fehlgeschlagen
     C                   ELSE
      *  Abrufen der Schlüsselfeldinformationen ...
     C                   EVAL      YFunction = '*KEY'
     C                   CALL      PEEK41        P_Peek41
     C                   Eval      nbrOfKey = yNbrOfEnt
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
     C                   Endif
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     ENDE          TAG
      *
     C                   EVAL      *INLR = '1'
      *
      *====================================================*
      *  First  --  Initialize program                     *
      *====================================================*
      *
     C     First         BEGSR
      *
     C                   EVAL      NbrOfKey = *ZEROS
      *
      * - Meldung
      ***                Callp     p_sndStsMg('USR8137': XQFile)
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
