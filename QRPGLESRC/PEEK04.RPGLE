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
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      *  list API format KEYL0100
      /COPY QCOPYLE,KEYL0100
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
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
     C                   MOVEL (P) XFile         YFile
     C                   MOVEL (P) XLib          YLib
     C                   MOVEL (P) XRcdFormat    YRcdFormat
     C                   MOVEL (P) '*CREATE'     YFunction
     C                   CALL      PEEK41        P_Peek41
      *
     C     yNbrOfEnt     IFLE      *ZEROS
      *  ... schade, Aufruf ist fehlgeschlagen
     C                   ELSE
      *  Abrufen der Schlüsselfeldinformationen ...
     C                   MOVEL (P) '*KEY'        YFunction
     C                   CALL      PEEK41        P_Peek41
     C                   Eval      nbrOfKey = yNbrOfEnt
      *
     C     nbrOfKey      IFLE      *ZEROS
     C                   MOVEL (P) 'USR0006'     XMsgID
     C                   MOVEL (P) XFile         USR00061
     C                   MOVEL (P) XLib          USR00062
     C                   MOVEL (P) USR0006       XMsgDta
     C                   ELSE
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
     C                   Endif
     C                   Endif
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     ENDE          TAG
      *
     C                   MOVEL (P) '1'           *INLR
      *
      *====================================================*
      *  First  --  Initialize program                     *
      *====================================================*
      *
     C     First         BEGSR
      *
     C                   Z-ADD     *ZEROS        NbrOfKey
      *
      * - Meldung
      ***                Callp     p_sndStsMg('USR8137': XQFile)
      *
      * - Los gehts'
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
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
