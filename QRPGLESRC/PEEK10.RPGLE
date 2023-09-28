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
     F                                     PREFIX(F_)
      *===============================================================*
      *
      *  list API format RCDL0200
      *  (data structure can be used within the calling program
      *  to splitt XLIST into its units.
     D RCDL0200        DS                  likeds(RCDL0200_t) inz
      /COPY QCOPYLE,RCDL0200
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK10
      /undefine internal_prototype
      *
      /COPY QCOPYLE,PPEEK11
      *
      *---Copystrecken für Nachrichtenaufbau---------------*
      /COPY QCOPYLE,USR0002
      /COPY QCOPYLE,USR8105
      *----------------------------------------------------*
      *
      *---Versenden von Nachrichten------------------------*
      /COPY QCOPYLE,API_ERROR
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
     D sortSeq         S                   LIKE(F_SortSeq) INZ(0)
      *
     D PEEK11_NAME     S                   like(pgmCallN_t) inz
      *
      * Arbeitsfelder
     D nbrOfFmt        S                   like(int4_t) inz
     D fmtCnt          S                   like(int4_t) inz
     D rc              S                   like(int4_t) inz
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK10          PI
     D  i_qFile                            const likeds(qObj_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
      *
     C                   EXSR      First
      *
      *  create list of record formats
     C                   CALLP     PEEK11(i_qFile:
     C                                    '*CREATE': nbrOfFmt: RCDL0200)
      *
     C                   EVAL      sortSeq = *ZEROS
      *  read each entry
     C     1             DO        nbrOfFmt      fmtCnt
      *
     C                   CALLP     PEEK11(i_qFile: '*READ': rc: RCDL0200)
      *
     C                   CLEAR                   FPEEKFMT
      *
     C                   EVAL      F_FORMAT = 'RCDL0200'
     C                   EVAL      F_FMT = RCDL0200
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
     C                   EVAL      o_msgID = 'USR0002'
     C                   EVAL      USR00021 = i_qFile.NAME
     C                   EVAL      USR00022 = i_qFile.LIB
     C                   EVAL      o_msgDta = USR0002
     C                   ELSE
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
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
     C                   Callp     p_sndStsMg('USR8105': i_qFile)
      *
      * - Los gehts'
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
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
      *  InzSr --  Initialize program                      *
      *====================================================*
      *
     C     InzSr         BEGSR
      *
     C                   IF        (isInzSr = bTrue)
     C                   Leavesr
     C                   ENDIF
      *
     C                   Eval      isInzSr = bTrue
      *
     C                   Eval      PEEK11_NAME = f_pgmCallN('PEEK11')
      *
     C                   OPEN      PEEKFMT
      *
     C                   ENDSR
      *
      *============================================================*
      *  Program error handler                                     *
      *============================================================*
      *
     P errorHandler    b
     D                 pi
     D i_condToken                         value likeds(cee_fc_t)
     D i_pCommArea                   10i 0 value
     D o_action                      10i 0
     D o_newCondToken                            likeds(cee_fc_t)
      /free

         dump;
         o_action = CEE_PERCOLATE;

      /end-free
     P                 e
      *
