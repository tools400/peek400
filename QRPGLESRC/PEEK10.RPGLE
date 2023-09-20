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
      /COPY QCOPYLE,FLDL0100
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
     D XQFILE          DS                  likeds(r§qObj)
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
     C                   PARM                    XQFILE
      *
     C                   PARM                    XMsgID            7
     C                   PARM                    XMsgDta         512
      *
      *---------------------------------------------------*
     C                   EXSR      First
      *---------------------------------------------------*
      *
      *  create list of record formats
     C                   EVAL      YQFILE = XQFILE
     C                   EVAL      YFUNK = '*CREATE'
     C                   EVAL      YANZ = *ZEROS
     C                   EVAL      YLIST = *BLANKS
     C                   CALL      PEEK11
     C                   PARM                    yQFile
     C                   PARM                    yFunk
     C                   PARM                    yAnz
     C                   PARM                    yList
      *
     C                   EVAL      nbrOfFmt = YANZ
      *
     C                   EVAL      sortSeq = *ZEROS
      *  read each entry
     C     1             DO        nbrOfFmt      fmtCnt
      *
     C                   EVAL      YFUNK = '*READ'
     C                   CALL      PEEK11
     C                   PARM                    YQFILE
     C                   PARM                    YFUNK
     C                   PARM                    YANZ
     C                   PARM                    YLIST
      *
     C                   CLEAR                   FPEEKFMT
      *
     C                   EVAL      F_FORMAT = 'RCDL0200'
     C                   EVAL      F_FMT = YLIST
     C                   EVAL      sortSeq = sortSeq + 10
     C                   EVAL      F_SortSeq = sortSeq
     C                   EVAL      F_FmtNbr = fmtCnt
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
     C                   EVAL      XMsgID = 'USR0002'
     C                   EVAL      USR00021 = XQFILE.NAME
     C                   EVAL      USR00022 = XQFILE.LIB
     C                   EVAL      XMsgDta = USR0002
     C                   ELSE
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
     C                   Endif
      *
     C                   EVAL      *INLR = '1'
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
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
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
     C                   EVAL      nbrOfFmt = *ZEROS
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
