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
     C                   MOVEL     XBuffer       R_DateEUR
      *      ... *ISO
     C                   OTHER
     C                   MOVEL     XBuffer       R_DateISO
     C                   ENDSL
     C                   Z-ADD     10            R_FldLen
      *  ... Zeit
     C     XType         WHENEQ    'T'                                         = Time
     C                   SELECT
      *      ... *HMS
     C     XDatTimFmt    WHENEQ    '*HMS'
     C                   MOVEL     XBuffer       R_TimeHMS
      *      ... *EUR
     C     XDatTimFmt    WHENEQ    '*EUR'
     C                   MOVEL     XBuffer       R_TimeEUR
      *      ... *ISO
     C                   OTHER
     C                   MOVEL     XBuffer       R_TimeISO
     C                   ENDSL
     C                   Z-ADD     8             R_FldLen
      *  ... Zeitstempel
     C     XType         WHENEQ    'Z'                                         = Timestamp
     C                   MOVEL     XBuffer       R_TimeStmp
     C                   Z-ADD     26            R_FldLen
     C                   OTHER
     C                   EXSR      *PSSR
     C                   Endsl
      *
     C     R_FldLen      ADD       1             R_Pos
     C     R_Pos         IFLE      R_BuffLen
     C                   SUBST (P) XBuffer:R_Pos R_Buffer
     C                   ELSE
     C                   MOVEL (P) *BLANKS       R_Buffer
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
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
     C                   ENDSR
      *
      *============================================================*
      *    *PSSR         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   MOVEL (P) 'USR8171'     XMsgID
     C                   MOVEL (P) XBuffer       USR81711
     C                   MOVEL (P) USR8171       XMsgDta
     C                   GOTO      ENDE
      *
     C                   ENDSR     '*CANCL'
      *
