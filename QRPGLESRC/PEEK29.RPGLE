      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK28                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 03.11.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Berechnen der Lizenznummer                                   *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *---Fehler-DS----------------------------------------*
      /COPY QCOPYLE,API_ERROR
      *----------------------------------------------------*
      *
     D XSysName        S              8A
     D XSysVers        S              6A
     D XSysSrlNbr      S              8A
     D XSysDate        S                   LIKE(R§INT4)
     D XSerialNbr      S             20A
      *
     D Value           S              1A   DIM(256)
     D Hex             S              1A   DIM(16)
      *
     D SysInpNbr       DS
     D  SysName                       8A   INZ(*BLANKS)
     D  SysVers                       6A   INZ(*BLANKS)
     D  SysSrlNbr                     8A   INZ(*BLANKS)
     D  SysEON                        1A   INZ(x'00'  )
      *
     D SysDate         S              8S 0 INZ(*ZEROS )
      *
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
     D Z               S                   like(r§int4    ) inz
     D A1              S              1A   INZ(*BLANKS)
     D Summe           S             30P 0 INZ(*ZEROS )
     D Rest            S             30P 0 INZ(*ZEROS )
     D ZW1             S             30P 0 INZ(*ZEROS )
     D ZW2             S             30P 0 INZ(*ZEROS )
      *
      *  Konvertierung HEX ==> DEC
     D R_Dec           S             30P 0 INZ(*ZEROS )
     D R_Hex           S             20A   INZ(*BLANKS)
      *
     D IntSrlNbr       S             20A
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
      *  Input
     C                   PARM                    XSysName
     C                   PARM                    XSysVers
     C                   PARM                    XSysSrlNbr
     C                   PARM                    XSysDate
      *  Output
     C                   PARM                    XSerialNbr
      *
      *----------------------------------------------------*
      *
      * -  Systemname des AS/400 Systems
     C                   MOVEL (P) XSysName      SysName
      *
      * -  PEEK-Versionsnummer
     C                   MOVEL (P) XSysVers      SysVers
      *
      * -  Seriennummer des AS/400 Systems
     C                   MOVEL (P) XSysSrlNbr    SysSrlNbr
      *
      * -  Gültig bis Datum (PEEK)
     C                   Z-ADD     XSysDate      SysDate
      *
      *  - Berechnung der Prüfsumme
     C                   Z-ADD     *ZEROS        Summe
      *
     C     1             DO        50            X
     C     1             SUBST     SysInpNbr:X   A1
     C     A1            IFEQ      x'00'
     C                   LEAVE
     C                   Endif
      *
     C                   Z-ADD     1             Y
     C     A1            LOOKUP    Value(Y)                               99
     C     *IN99         IFEQ      '1'
      *    ... gefunden
     C                   ADD       Y             Summe
     C                   ELSE
      *    ... nicht gefunden
      *        (kann eigentlich nicht sein)
     C                   ADD       *ZEROS        Summe
     C                   Endif
      *
     C     X             MULT      256           Z
     C                   ADD       Z             Summe
     C                   Enddo
      *
      *  - Datum als Komplement
     C                   SUB       SysDate       Summe
     C                   ADD       99999999      Summe
      *
      *  - Prüfsumme in HEX-Wert umsetzen
     C                   Z-ADD     Summe         R_Dec
     C                   EXSR      DecToHex
     C                   MOVEL (P) R_Hex         IntSrlNbr
      *
     C                   CAT       '-':0         IntSrlNbr
      *
      *  - Originaldatum anfügen, als Komplement gespeichert!
     C                   Z-SUB     SysDate       R_Dec
     C                   ADD       99999999      R_Dec
     C                   EXSR      DecToHex
     C                   CAT       R_Hex:0       IntSrlNbr
      *
     C                   MOVEL (P) IntSrlNbr     XSerialNbr
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *============================================================*
      *    DecToHex      Konvertieren Decimal ==> Hex              *
      *============================================================*
      *
     C     DecToHex      BEGSR
      *
     C                   MOVEL (P) *BLANKS       R_Hex
     C                   Z-ADD     R_Dec         Rest
      *
     C     R_Dec         DOUEQ     *ZEROS
      *
     C     R_Dec         DIV       16            ZW1
     C     ZW1           MULT      16            ZW2
     C     R_Dec         SUB       ZW2           Rest
      *
     C                   ADD       1             Rest
     C     Hex(Rest)     CAT   (P) R_Hex:0       R_Hex
      *
     C                   Z-ADD     ZW1           R_Dec
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Initialisierung                           *
      *============================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   MOVEL (P) 'A'           Value(193)
     C                   MOVEL (P) 'B'           Value(194)
     C                   MOVEL (P) 'C'           Value(195)
     C                   MOVEL (P) 'D'           Value(196)
     C                   MOVEL (P) 'E'           Value(197)
     C                   MOVEL (P) 'F'           Value(198)
     C                   MOVEL (P) 'G'           Value(199)
     C                   MOVEL (P) 'H'           Value(200)
     C                   MOVEL (P) 'I'           Value(201)
      *
     C                   MOVEL (P) 'J'           Value(209)
     C                   MOVEL (P) 'K'           Value(210)
     C                   MOVEL (P) 'L'           Value(211)
     C                   MOVEL (P) 'M'           Value(212)
     C                   MOVEL (P) 'N'           Value(213)
     C                   MOVEL (P) 'O'           Value(214)
     C                   MOVEL (P) 'P'           Value(215)
     C                   MOVEL (P) 'Q'           Value(216)
     C                   MOVEL (P) 'R'           Value(217)
      *
     C                   MOVEL (P) 'S'           Value(226)
     C                   MOVEL (P) 'T'           Value(227)
     C                   MOVEL (P) 'U'           Value(228)
     C                   MOVEL (P) 'V'           Value(229)
     C                   MOVEL (P) 'W'           Value(230)
     C                   MOVEL (P) 'X'           Value(231)
     C                   MOVEL (P) 'Y'           Value(232)
     C                   MOVEL (P) 'Z'           Value(233)
      *
     C                   MOVEL (P) '0'           Value(240)
     C                   MOVEL (P) '1'           Value(241)
     C                   MOVEL (P) '2'           Value(242)
     C                   MOVEL (P) '3'           Value(243)
     C                   MOVEL (P) '4'           Value(244)
     C                   MOVEL (P) '5'           Value(245)
     C                   MOVEL (P) '6'           Value(246)
     C                   MOVEL (P) '7'           Value(247)
     C                   MOVEL (P) '8'           Value(248)
     C                   MOVEL (P) '9'           Value(249)
      *
     C                   MOVEL (P) '0'           Hex(1)
     C                   MOVEL (P) '1'           Hex(2)
     C                   MOVEL (P) '2'           Hex(3)
     C                   MOVEL (P) '3'           Hex(4)
     C                   MOVEL (P) '4'           Hex(5)
     C                   MOVEL (P) '5'           Hex(6)
     C                   MOVEL (P) '6'           Hex(7)
     C                   MOVEL (P) '7'           Hex(8)
     C                   MOVEL (P) '8'           Hex(9)
     C                   MOVEL (P) '9'           Hex(10)
     C                   MOVEL (P) 'A'           Hex(11)
     C                   MOVEL (P) 'B'           Hex(12)
     C                   MOVEL (P) 'C'           Hex(13)
     C                   MOVEL (P) 'D'           Hex(14)
     C                   MOVEL (P) 'E'           Hex(15)
     C                   MOVEL (P) 'F'           Hex(16)
      *
     C                   ENDSR
      *
      *============================================================*
      *    *PSSR         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   ENDSR     '*CANCL'
      *
