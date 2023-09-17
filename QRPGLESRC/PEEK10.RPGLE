      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK10                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 02.10.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Erstellen einer Liste aller verfügbaren Satzformate          *
      *  einer Datei.                                                 *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEKFMT   UF A E             DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     PREFIX(F_)
      *===============================================================*
      *
      *  list API format RCDL0200
      *  (data structure can be used within the calling program
      *  to splitt XLIST into its units.
      /COPY QCOPYLE,RCDL0200
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *---Copystrecken für Nachrichtenaufbau---------------*
      /COPY QCOPYLE,USR0002
      /COPY QCOPYLE,USR8105
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
     D sortSeq         S                   LIKE(F_SortSeq) INZ(0)
      *
     D PEEK11          S                   like(r§pgmCallN) inz
      *
      * Peek11:
     D yQFile          S             20A   inz
     D yFunk           S             10A   inz
     D yAnz            S                   like(r§int4    ) inz
     D yList           S            512A   inz
      *
      * Arbeitsfelder
     D nbrOfFmt        S                   like(r§int4    ) inz
     D fmtCnt          S                   like(r§int4    ) inz
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
     C                   PARM                    XQFILE           20
      *
     C                   PARM                    XMsgID            7
     C                   PARM                    XMsgDta         512
      *
      *---------------------------------------------------*
     C                   EXSR      First
      *---------------------------------------------------*
      *
      *  create list of record formats
     C                   MOVEL(P)  XQFILE        YQFILE
     C                   MOVEL(P)  '*CREATE'     YFUNK
     C                   Z-ADD     *ZEROS        YANZ
     C                   MOVEL(P)  *BLANKS       YLIST
     C                   CALL      PEEK11
     C                   PARM                    yQFile
     C                   PARM                    yFunk
     C                   PARM                    yAnz
     C                   PARM                    yList
      *
     C                   Z-ADD     YANZ          nbrOfFmt
      *
     C                   Z-ADD     *ZEROS        sortSeq
      *  read each entry
     C     1             DO        nbrOfFmt      fmtCnt
      *
     C                   MOVEL(P)  '*READ'       YFUNK
     C                   CALL      PEEK11
     C                   PARM                    YQFILE
     C                   PARM                    YFUNK
     C                   PARM                    YANZ
     C                   PARM                    YLIST
      *
     C                   CLEAR                   FPEEKFMT
      *
     C                   MOVEL (P) 'RCDL0200'    F_FORMAT
     C                   MOVEL (P) YLIST         F_FMT
     C                   ADD       10            sortSeq
     C                   Z-ADD     sortSeq       F_SortSeq
     C                   Z-ADD     fmtCnt        F_FmtNbr
     C                   WRITE     FPEEKFMT
      *
     C                   Enddo
      *
      *  delete list
      ***                MOVEL(P)  '*DELETE'     YFUNK
      ***                CALL      PEEK11
      ***                PARM                    YQFILE
      ***                PARM                    YFUNK
      ***                PARM                    YANZ
      ***                PARM                    YLIST
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     ENDE          TAG
      *
     C     nbrOfFmt      IFEQ      *ZEROS
     C                   MOVEL (P) 'USR0002'     XMsgID
     C     10            SUBST (P) XQFile:1      USR00021
     C     10            SUBST (P) XQFile:11     USR00022
     C                   MOVEL (P) USR0002       XMsgDta
     C                   ELSE
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
     C                   Endif
      *
     C                   MOVEL (P) '1'           *INLR
      *
      *====================================================*
      *  First  --  Initialize program                     *
      *====================================================*
      *
     C     First         BEGSR
      *
      * - Meldung
     C                   Callp     p_sndStsMg('USR8105': xQFile)
      *
      * - Los gehts'
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
     C     1             SETLL     FPEEKFMT
      *
     C                   DO        *HIVAL
     C                   READ      FPEEKFMT                               11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   DELETE    FPEEKFMT
     C                   Enddo
      *
     C                   Z-ADD     *ZEROS        nbrOfFmt
      *
     C                   ENDSR
      *
      *====================================================*
      *  *INZSR --  Initialize program                     *
      *====================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   Eval      PEEK11 = f_pgmCallN('PEEK11')
      *
     C                   OPEN      PEEKFMT
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
