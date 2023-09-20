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
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8171
      *----------------------------------------------------*
      *
     D XBuffer         S            128A
     D XType           S              1A
     D XDatTimFmt      S                   like(FLDL0100_t.F1DTFM)
     D XSeparator      S                   like(FLDL0100_t.F1DTSP)
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
      *---API-Formate--------------------------------------*
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
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
     D R_Buffer        S                         LIKE(XBuffer)   INZ(*ZEROS )
     D R_BuffLen       C                         CONST(%SIZE(XBuffer))
      *
     C     *ENTRY        PLIST
     C                   PARM                    XBuffer
     C                   PARM                    XType
     C                   PARM                    XDatTimFmt
     C                   PARM                    XSeparator
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
     C                   EXSR      First
      *
      *  Prüfen Format für ...
     C                   SELECT
      *  ... Datum
     C     XType         WHENEQ    'L'                                         = Date
     C                   SELECT
      *      ... *EUR
     C     XDatTimFmt    WHENEQ    '*EUR'
     C                   EVAL      R_DateEUR = %date(XBuffer: *EUR)
      *      ... *ISO
     C                   OTHER
     C                   EVAL      R_DateISO = %date(XBuffer: *ISO)
     C                   ENDSL
     C                   EVAL      R_FldLen = 10
      *  ... Zeit
     C     XType         WHENEQ    'T'                                         = Time
     C                   SELECT
      *      ... *HMS
     C     XDatTimFmt    WHENEQ    '*HMS'
     C                   EVAL      R_TimeHMS = %time(XBuffer: *HMS)
      *      ... *EUR
     C     XDatTimFmt    WHENEQ    '*EUR'
     C                   EVAL      R_TimeEUR = %time(XBuffer: *EUR)
      *      ... *ISO
     C                   OTHER
     C                   EVAL      R_TimeISO = %time(XBuffer: *ISO)
     C                   ENDSL
     C                   EVAL      R_FldLen = 8
      *  ... Zeitstempel
     C     XType         WHENEQ    'Z'                                         = Timestamp
     C                   EVAL      R_TimeStmp = %timestamp(XBuffer)
     C                   EVAL      R_FldLen = 26
     C                   OTHER
     C                   EXSR      *PSSR
     C                   Endsl
      *
     C                   EVAL      R_Pos = R_FldLen + 1
     C     R_Pos         IFLE      R_BuffLen
     C**                 SUBST (P) XBuffer:R_Pos R_Buffer
     C                   EVAL      R_Buffer = %subst(XBuffer: R_Pos)
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
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
      *
     C                   ENDSR
      *
      *============================================================*
      *    *PSSR         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   EVAL      XMsgID = 'USR8171'
     C                   EVAL      USR81711 = XBuffer
     C                   EVAL      XMsgDta = USR8171
     C                   GOTO      ENDE
      *
     C                   ENDSR     '*CANCL'
      *
