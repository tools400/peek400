      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK29                                            *
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
      /COPY QCOPYLE,PPEEK29
      /undefine internal_prototype
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,API_ERROR
      *
     D Value           S              1A   DIM(256)
     D Hex             S              1A   DIM(16)
      *
     D SysInpNbr       DS                  qualified
     D  SysName                       8A   INZ(*BLANKS)
     D  SysVers                       6A   INZ(*BLANKS)
     D  SysSrlNbr                     8A   INZ(*BLANKS)
     D  SysEON                        1A   INZ(x'00'  )
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
     D PEEK29          PI
     D  i_sysName                     8A   const
     D  i_sysVersion                  6A   const
     D  i_sysSrlNbr                   8A   const
     D  i_sysDate                    10I 0 const
     D  o_serialNbr                  20A
      *
      *----------------------------------------------------*
      *
      * -  Systemname des AS/400 Systems
     C                   EVAL      SysInpNbr.SysName = i_sysName
      *
      * -  PEEK-Versionsnummer
     C                   EVAL      SysInpNbr.SysVers = i_sysVersion
      *
      * -  Seriennummer des AS/400 Systems
     C                   EVAL      SysInpNbr.SysSrlNbr = i_sysSrlNbr
      *
      *  - Berechnung der Prüfsumme
     C                   EVAL      Summe = *ZEROS
      *
     C     1             DO        50            X
     C**   1             SUBST     SysInpNbr:X   A1
     C                   EVAL      A1 = %subst(SysInpNbr: X: 1)
     C     A1            IFEQ      x'00'
     C                   LEAVE
     C                   Endif
      *
     C                   EVAL      Y = 1
     C                   EVAL      Y = %lookup(A1: Value)
     C                   IF        (Y > 0)
      *    ... gefunden
     C                   EVAL      Summe = Summe + Y
     C                   ELSE
      *    ... nicht gefunden
      *        (kann eigentlich nicht sein)
     C                   Endif
      *
     C     X             MULT      256           Z
     C                   EVAL      Summe = Summe + Z
     C                   Enddo
      *
      *  - Datum als Komplement
     C                   EVAL      Summe = Summe - i_sysDate
     C                   EVAL      Summe = Summe + 99999999
      *
      *  - Prüfsumme in HEX-Wert umsetzen
     C                   EVAL      R_Dec = Summe
     C                   EXSR      DecToHex
     C                   EVAL      IntSrlNbr = R_Hex
      *
     C**                 CAT       '-':0         IntSrlNbr
     C                   EVAL      IntSrlNbr = %trimr(IntSrlNbr) + '-'
      *
      *  - Originaldatum anfügen, als Komplement gespeichert!
     C**                 Z-SUB     SysDate       R_Dec
     C                   EVAL      R_Dec = 0 - i_sysDate
     C                   EVAL      R_Dec = R_Dec + 99999999
     C                   EXSR      DecToHex
     C**                 CAT       R_Hex:0       IntSrlNbr
     C                   EVAL      IntSrlNbr = %trimr(IntSrlNbr) + R_Hex
      *
     C                   EVAL      o_serialNbr = IntSrlNbr
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
     C                   EVAL      R_Hex = *BLANKS
     C                   EVAL      Rest = R_Dec
      *
     C     R_Dec         DOUEQ     *ZEROS
      *
     C     R_Dec         DIV       16            ZW1
     C     ZW1           MULT      16            ZW2
     C                   EVAL      Rest = R_Dec - ZW2
      *
     C                   EVAL      Rest = Rest + 1
     C**   Hex(Rest)     CAT   (P) R_Hex:0       R_Hex
     C                   EVAL      R_Hex = %trimr(Hex(Rest)) + R_Hex
      *
     C                   EVAL      R_Dec = ZW1
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
     C                   EVAL      Value(193) = 'A'
     C                   EVAL      Value(194) = 'B'
     C                   EVAL      Value(195) = 'C'
     C                   EVAL      Value(196) = 'D'
     C                   EVAL      Value(197) = 'E'
     C                   EVAL      Value(198) = 'F'
     C                   EVAL      Value(199) = 'G'
     C                   EVAL      Value(200) = 'H'
     C                   EVAL      Value(201) = 'I'
      *
     C                   EVAL      Value(209) = 'J'
     C                   EVAL      Value(210) = 'K'
     C                   EVAL      Value(211) = 'L'
     C                   EVAL      Value(212) = 'M'
     C                   EVAL      Value(213) = 'N'
     C                   EVAL      Value(214) = 'O'
     C                   EVAL      Value(215) = 'P'
     C                   EVAL      Value(216) = 'Q'
     C                   EVAL      Value(217) = 'R'
      *
     C                   EVAL      Value(226) = 'S'
     C                   EVAL      Value(227) = 'T'
     C                   EVAL      Value(228) = 'U'
     C                   EVAL      Value(229) = 'V'
     C                   EVAL      Value(230) = 'W'
     C                   EVAL      Value(231) = 'X'
     C                   EVAL      Value(232) = 'Y'
     C                   EVAL      Value(233) = 'Z'
      *
     C                   EVAL      Value(240) = '0'
     C                   EVAL      Value(241) = '1'
     C                   EVAL      Value(242) = '2'
     C                   EVAL      Value(243) = '3'
     C                   EVAL      Value(244) = '4'
     C                   EVAL      Value(245) = '5'
     C                   EVAL      Value(246) = '6'
     C                   EVAL      Value(247) = '7'
     C                   EVAL      Value(248) = '8'
     C                   EVAL      Value(249) = '9'
      *
     C                   EVAL      Hex(1) = '0'
     C                   EVAL      Hex(2) = '1'
     C                   EVAL      Hex(3) = '2'
     C                   EVAL      Hex(4) = '3'
     C                   EVAL      Hex(5) = '4'
     C                   EVAL      Hex(6) = '5'
     C                   EVAL      Hex(7) = '6'
     C                   EVAL      Hex(8) = '7'
     C                   EVAL      Hex(9) = '8'
     C                   EVAL      Hex(10) = '9'
     C                   EVAL      Hex(11) = 'A'
     C                   EVAL      Hex(12) = 'B'
     C                   EVAL      Hex(13) = 'C'
     C                   EVAL      Hex(14) = 'D'
     C                   EVAL      Hex(15) = 'E'
     C                   EVAL      Hex(16) = 'F'
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
