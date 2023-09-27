      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK36                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 29.01.1998  Raddatz                               *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Prüfen Datum-, Zeit, Zeitstempelfelder            *
      *                                                               *
      *  geändert : 01.04.04  für Version 2.2.2                       *
      *                     added support for time format *HMS, *EUR  *
      *                     added support for date format *EUR        *
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
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK36
      /undefine internal_prototype
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8171
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
     D R_DateISO       S               D         DATFMT(*ISO)    INZ(*LOVAL )
     D R_DateEUR       S               D         DATFMT(*EUR)    INZ(*LOVAL )
     D R_TimeISO       S               T         TIMFMT(*ISO)    INZ(*LOVAL )
     D R_TimeHMS       S               T         TIMFMT(*HMS)    INZ(*LOVAL )
     D R_TimeEUR       S               T         TIMFMT(*EUR)    INZ(*LOVAL )
     D R_TimeStmp      S               Z                         INZ(*LOVAL )
     D R_FldLen        S                   like(r§int4    ) inz
     D R_Pos           S                   like(r§int4    ) inz
     D R_Buffer        S                         LIKE(i_buffer)   INZ(*ZEROS )
     D R_BuffLen       C                         CONST(%SIZE(i_buffer))
      *
     D PEEK36          PI
     D  i_buffer                    128A   const
     D  i_type                        1A   const
     D  i_datTimFmt                        const like(FLDL0100_t.F1DTFM)
     D  i_separator                        const like(FLDL0100_t.F1DTSP)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
     C                   EXSR      First
      *
      *  Prüfen Format für ...
     C                   SELECT
      *  ... Datum
     C     i_type        WHENEQ    'L'                                         = Date
     C                   SELECT
      *      ... *EUR
     C     i_datTimFmt   WHENEQ    '*EUR'
     C                   EVAL      R_DateEUR = %date(i_buffer: *EUR)
      *      ... *ISO
     C                   OTHER
     C                   EVAL      R_DateISO = %date(i_buffer: *ISO)
     C                   ENDSL
     C                   EVAL      R_FldLen = 10
      *  ... Zeit
     C     i_type        WHENEQ    'T'                                         = Time
     C                   SELECT
      *      ... *HMS
     C     i_datTimFmt   WHENEQ    '*HMS'
     C                   EVAL      R_TimeHMS = %time(i_buffer: *HMS)
      *      ... *EUR
     C     i_datTimFmt   WHENEQ    '*EUR'
     C                   EVAL      R_TimeEUR = %time(i_buffer: *EUR)
      *      ... *ISO
     C                   OTHER
     C                   EVAL      R_TimeISO = %time(i_buffer: *ISO)
     C                   ENDSL
     C                   EVAL      R_FldLen = 8
      *  ... Zeitstempel
     C     i_type        WHENEQ    'Z'                                         = Timestamp
     C                   EVAL      R_TimeStmp = %timestamp(i_buffer)
     C                   EVAL      R_FldLen = 26
     C                   OTHER
     C                   EXSR      *PSSR
     C                   Endsl
      *
     C                   EVAL      R_Pos = R_FldLen + 1
     C     R_Pos         IFLE      R_BuffLen
     C**                 SUBST (P) XBuffer:R_Pos R_Buffer
     C                   EVAL      R_Buffer = %subst(i_buffer: R_Pos)
     C                   ELSE
     C                   EVAL      R_Buffer = *BLANKS
     C                   Endif
      *
     C     R_Buffer      IFEQ      *BLANKS
      *  ... Alles in Ordnung
     C                   ELSE
     C                   EXSR      *PSSR
     C                   Endif
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *============================================================*
      *    First         Initialisierung                           *
      *============================================================*
      *
     C     First         BEGSR
      *
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
     C                   ENDSR
      *
      *============================================================*
      *    *PSSR         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   EVAL      o_msgID = 'USR8171'
     C                   EVAL      USR81711 = i_buffer
     C                   EVAL      o_msgDta = USR8171
     C                   GOTO      ENDE
      *
     C                   ENDSR     '*CANCL'
      *
