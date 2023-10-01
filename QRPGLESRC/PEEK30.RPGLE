      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.5.0                               *
      *  Programm : PEEK30                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 03.11.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Lizenzprüfung                                                *
      *                                                               *
      *===============================================================*
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
     FPEEK30FM  CF   E             WORKSTN USROPN
     F                                     INFDS(workstn)
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK30
      /undefine internal_prototype
      *
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
      *----------------------------------------------------*
      *
      *---Farbattribute------------------------------------*
      /COPY QCOPYLE,D_COLORATR
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8158
      /COPY QCOPYLE,USR9997
      *----------------------------------------------------*
      *
     D UsrSpcDta       S             64    based(pSpcPtr)
     D YSrlNbrExt      S                   LIKE(R_SrlNbr ) INZ(*BLANKS)
     D YDateExt        S                   LIKE(R_SrlDate) INZ(*BLANKS)
      *
     D YAttrLen        S                   like(int4_t) inz
     D YAttrTyp        S              1A   INZ(*BLANKS)
     D YValue          S            512A   INZ(*BLANKS)
      *
     D YSysName        S              8A   INZ(*BLANKS)
     D YSysVers        S              6A   INZ(*BLANKS)
     D YSysSrlNbr      S              8A   INZ(*BLANKS)
     D YSrlNbrInt      S                   LIKE(R_SrlNbr ) INZ(*BLANKS)
     D YDateInt        S                   LIKE(R_SrlDate) INZ(*BLANKS)
      *
     D R_SrlData       S             20A   INZ(*BLANKS)
     D R_SrlNbr        S             20A   INZ(*BLANKS)
     D R_SrlDate       S             20A   INZ(*BLANKS)
      *
      *  Konvertierung HEX ==> DEC
     D R_Dec           S             30P 0 INZ(*ZEROS )
     D R_Hex           S                   LIKE(R_SrlNbr ) INZ(*BLANKS)
     D Hex             S              1A   DIM(16)
     D ZW1             S             30P 0 INZ(*ZEROS )
     D Exp             S                   like(int4_t) inz
     D A1              S              1A   INZ(*BLANKS)
     D X               S                   like(int4_t) inz
     D Y               S                   like(int4_t) inz
      *
      *  DeadDate
     D ZWInt           S             30P 0 INZ(*ZEROS )
     D ZWExt           S             30P 0 INZ(*ZEROS )
     D DeadDate        S              8P 0 INZ(*ZEROS )
      *
      *  Aktuelle Datum und Uhrzeit
     D                 DS
     D   CurrDatTim            1     14S 0
     D   CurrTime              1      6S 0 INZ(*ZEROS )
     D   CurrDateFw            7     14S 0 INZ(*ZEROS )
     D   CurrDayFW             7      8S 0 INZ(*ZEROS )
     D   CurrMonFw             9     10S 0 INZ(*ZEROS )
     D   CurrYearFw           11     14S 0 INZ(*ZEROS )
      *
     D                 DS
     D   CurrDateRv            1      8S 0
     D   CurrYearRv            1      4S 0 INZ(*ZEROS )
     D   CurrMonRv             5      6S 0 INZ(*ZEROS )
     D   CurrDayRv             7      8S 0 INZ(*ZEROS )
      *
     D bTrueExt        C                   CONST( 66)
     D bFalseExt       C                   CONST(-55)
     D bShareExt       C                   CONST(243)
      *
     D IsCompOK        S              1A   INZ(bFalse )
     D IsDateErr       S              1A   INZ(bFalse )
     D IsWriteOK       S              1A   INZ(bFalse )
      *
      *  declarations for QUSCRTUS
     D qUsrSpc         ds                  likeds(qObj_t) inz
      *
      *  Programme
     D PEEK07_NAME     S                   like(pgmCallN_t) inz
     D PEEK28_NAME     S                   like(pgmCallN_t) inz
     D PEEK29_NAME     S                   like(pgmCallN_t) inz
      *
     D §Text           C                   CONST('Peek/400-
     D                                      - Lizenzdaten')
      *
      /COPY QCOPYLE,QUSCRTUS
      /COPY QCOPYLE,QUSPTRUS
      *
      /COPY QCOPYLE,PPEEK07
      /COPY QCOPYLE,PPEEK28
      /COPY QCOPYLE,PPEEK29
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
     D PEEK30          PI
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  o_flag                                   like(int4_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
      *
     C                   EXSR      First
      *
     C     IsCompOK      IFEQ      bFalse
      *     Fehler in der Lizenz-Nr. ...
     C     IsDateErr     IFEQ      bTrue
      *     ... Datum abgelaufen
      *         ... Abfragen einer neuen LizenzNr.
     C                   EXSR      GetLicInf
     C     o_flag        IFNE      bTrueExt
      *         ... wenn keine neue LizenzNr eingetragen
      *             worden ist, dann bFalse zurückliefern,
      *             damit kein weiterer Test möglich ist.
     C                   OPEN      PEEK30FM
     C                   EVAL      ZEI = ZEI + 4
     C                   EVAL      POS = POS + 4
     C                   EXFMT     BILD03
     C                   CLOSE     PEEK30FM
     C                   EVAL      o_flag = bFalseExt
     C                   ELSE
      *         ... neue LizenzNr. wurde eingetragen
      *             Rückkehrcode in XFLag ist OK
     C                   Endif
     C                   ELSE
      *     ... Lizenzdaten abfragen
     C                   EXSR      GetLicInf
     C                   Endif
     C                   ELSE
      *     Lizenznummer ist OK ...
     C                   EVAL      o_flag = bTrueExt
     C                   Endif
      *
      *----------------------------------------------------*
      *
      * -  Systemname des AS/400 Systems
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *============================================================*
      *    GetLicInf     Abfragen der Lizenznummer                 *
      *============================================================*
      *
     C     GetLicInf     BEGSR
      *
      * - Öffnen der Dateien
     C                   OPEN      PEEK30FM
      *
      *  Löschen Lizenznummer
     C                   EVAL      ##LicData = *BLANKS
      *
     C                   DO        *HIVAL
      *
      *  Nachrichten anzeigen
     C                   EVAL      *IN89 = '0'
     C                   WRITE     MSGCTL
      *
      *  Anzeigen Bildschirm
     C                   EXFMT     BILD01
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Bezugszahlen löschen
     C                   EXSR      BZOFF1
      *
      *  Abfragen der Befehlstasten
     C                   SELECT
      *  F9  - Ende
     C     workstn.aid   WHENEQ    K_F9
     C                   EXSR      C_EndPgm
     C                   EVAL      o_flag = bShareExt
     C                   EVAL      o_msgID = 'USR9997'
     C                   EVAL      USR99971 = §Yellow_R
     C                   EVAL      USR99972 = §White
     C                   EVAL      o_msgDta = USR9997
     C                   LEAVE
      *
      *  Datenfreigabe
     C     workstn.aid   WHENEQ    K_ENTER
     C                   EXSR      C_Enter
     C     *IN99         IFEQ      '0'
     C                   EVAL      o_flag = bTrueExt
     C                   LEAVE
     C                   Endif
      *
     C                   OTHER
      *  Falsche Taste gedrückt
     C                   Callp     p_wrongKey(workstn.aid: §§pgmName)
     C                   Iter
     C                   Endsl
      *
     C                   Enddo                                                  *HIVAL
      *
      * - Schließen der Dateien
     C                   CLOSE     PEEK30FM
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_EndPgm      Programm beenden                          *
      *============================================================*
      *
     C     C_EndPgm      BEGSR
      *
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Enter       Datenfreigabe                             *
      *============================================================*
      *
     C     C_Enter       BEGSR
      *
     C                   EXSR      PRFB1
      *
     C     *IN99         IFEQ      '0'
     C                   EXSR      WrtLicData
     C     IsWriteOK     IFEQ      bFalse
     C                   EVAL      *IN99 = '1'
     C                   Callp     p_sndPgmMg('USR8159': '': §§pgmName)
     C                   ELSE
     C                   EVAL      ZEI = ZEI + 4
     C                   EVAL      POS = POS + 4
     C                   EXFMT     BILD02
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
      *============================================================*
      *
     C     BZOFF1        BEGSR
      *
      *  DSPATR(PC)
     C                   EVAL      *IN20 = '0'                                  ##LicNbr
      *
      *  DSPATR(RI)
     C                   EVAL      *IN30 = '0'                                  ##LicNbr
      *
      *  Fehler
     C                   EVAL      *IN99 = '0'
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRFB1         Prüfen der Eingaben                       *
      *============================================================*
      *
     C     PRFB1         BEGSR
      *
     C                   EXSR      PRF20                                        ##LicData
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C     EPRFB1        ENDSR
      *
      *============================================================*
      *    PRF20         Prüfen:  Lizenznummer                     *
      *============================================================*
      *
     C     PRF20         BEGSR
      *
     C     ##LicData     IFEQ      *BLANKS
     C                   CLEAR                   USR8158
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8158
     C                   EVAL      USR81581 = ##LicData                         Liz.Nr.
     C                   Callp     p_sndPgmMg('USR8158': USR8158: §§pgmName)
     C                   GOTO      EPRF20
     C                   Endif
      *
     C                   EVAL      R_SrlData = ##LicData
     C                   EXSR      SplittLic
     C                   EVAL      YSrlNbrExt = R_SrlNbr
     C                   EVAL      YDateExt = R_SrlDate
      *
     C                   EXSR      CompLicNbr
     C     IsCompOK      IFEQ      bFalse
     C                   CLEAR                   USR8158
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8158
     C                   EVAL      USR81581 = ##LicData                         Liz.Nr.
     C                   Callp     p_sndPgmMg('USR8158': USR8158: §§pgmName)
     C                   GOTO      EPRF20
     C                   Endif
      *
     C     EPRF20        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN20 = '1'
     C                   EVAL      *IN30 = '1'
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Fill##        Abrufen der Lizenzdaten und füllen der    *
      *                  BIldschirmfelder                          *
      *============================================================*
      *
     C     Fill##        BEGSR
      *
     C                   EVAL      IsCompOK = bTrue
     C                   LEAVESR
      *
      *------------------------------------------*
      *  ... Existenzprüfung  UserSpace          *
      *------------------------------------------*
     C                   IF        (not f_exist(
     C                                qUsrSpc.name: qUsrSpc.lib: '*USRSPC'))
     C                   EXSR      CrtUsrSpc
     C                   Endif
      *
      *------------------------------------------*
      *  ... einlesen der aktuellen Daten        *
      *      ( = YSrlNbrExt)                     *
      *------------------------------------------*
     C                   EXSR      RtvUsrSpc
      *
      *------------------------------------------*
      *  ... vergleichen der Lizenzdaten         *
      *------------------------------------------*
     C                   EXSR      CompLicNbr
      *
     C                   ENDSR
      *
      *============================================================*
      *    CompLicNbr    Vergleichen der Lizenzdaten               *
      *============================================================*
      *
     C     CompLicNbr    BEGSR
      *
      *------------------------------------------*
      *  ... berechnen der Vergleichsserien-Nr.  *
      *      ( = YSrlNbrInt)                     *
      *      für normale Lizenznummer            *
      *------------------------------------------*
     C                   EVAL      IsCompOK = bFalse
     C                   EVAL      IsDateErr = bTrue
      *
     C                   EXSR      ClcIntNbr
     C                   EXSR      CompLicNb2
      *
      *------------------------------------------*
      *  ... berechnen der Vergleichsserien-Nr.  *
      *      ( = YSrlNbrInt)                     *
      *      für Firmenlizenznummer              *
      *------------------------------------------*
     C     IsCompOK      IFEQ      bFalse
     C                   EVAL      IsCompOK = bFalse
     C                   EVAL      IsDateErr = bTrue
      *
     C                   EXSR      ClcIntNbrF
     C                   EXSR      CompLicNb2
     C                   ELSE
      *    ... die Lizenznummer stimmt bereits
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    CompLicNb2    Vergleichen der Lizenzdaten 2             *
      *============================================================*
      *
     C     CompLicNb2    BEGSR
      *
      * -  interne Nummer umsetzen in Dezimalwert
     C                   EVAL      R_Hex = YSrlNbrInt
     C                   EXSR      HexToDec
     C                   EVAL      ZWInt = R_Dec
      *
      * -  externe Nummer umsetzen in Dezimalwert
     C                   EVAL      R_Hex = YSrlNbrExt
     C                   EXSR      HexToDec
     C                   EVAL      ZWExt = R_Dec
      *
      * -  externes Datum umsetzen in Dezimalwert
     C                   EVAL      R_Hex = YDateExt
     C                   EXSR      HexToDec
     C                   Z-SUB     R_Dec         DeadDate
     C                   EVAL      DeadDate = DeadDate + 99999999
      *
      * -  Angleichen externe Nummer
     C                   EVAL      ZWExt = ZWExt - R_Dec
     C                   EVAL      ZWExt = ZWExt + 99999999
      *
      *------------------------------------------*
      *  ... vergleichen interne & externe       *
      *      Seriennummer                        *
      *------------------------------------------*
     C                   TIME                    CurrDatTim
     C                   EVAL      CurrDayRv = CurrDayFw
     C                   EVAL      CurrMonRv = CurrMonFw
     C                   EVAL      CurrYearRv = CurrYearFw
      *
     C     ZWExt         IFNE      ZWInt
     C                   EVAL      IsCompOK = bFalse
     C                   EVAL      IsDateErr = bFalse
     C                   ELSE
     C     DeadDate      IFLT      CurrDateRv
     C                   EVAL      IsCompOK = bFalse
     C                   EVAL      IsDateErr = bTrue
     C                   ELSE
     C                   EVAL      IsCompOK = bTrue
     C                   EVAL      IsDateErr = bFalse
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    CrtUsrSpc     Anlegen UserSpace                         *
      *============================================================*
      *
     C     CrtUsrSpc     BEGSR
      *
     C                   CALLP     QUSCRTUS(qUsrSpc: 'USRSPC': 64: x'00': '*ALL'
     C                                      : 'Peek/400 Lizenzdaten')
      *
     C                   ENDSR
      *
      *============================================================*
      *    RtvUsrSpc     Einlesen UserSpace                        *
      *============================================================*
      *
     C     RtvUsrSpc     BEGSR
      *
     C                   Callp     QUSPTRUS(qUsrSpc: pSpcPtr)
      *
     C                   EVAL      R_SrlData = UsrSpcDta
     C                   EXSR      SplittLic
     C                   EVAL      YSrlNbrExt = R_SrlNbr
     C                   EVAL      YDateExt = R_SrlDate
      *
     C                   ENDSR
      *
      *============================================================*
      *    SplittLic     Splitten der Lizenzdaten                  *
      *============================================================*
      *
     C     SplittLic     BEGSR
      *
     C     '-'           SCAN      R_SrlData     X
     C     X             IFGT      *ZEROS
     C                   EVAL      X = X - 1
     C     X             IFGT      *ZEROS
     C                   EVAL      R_SrlNbr = %subst(R_SrlData: 1: x)
     C                   ELSE
     C                   EVAL      R_SrlNbr = *BLANKS
     C                   Endif
      *
     C                   EVAL      X = X + 2
     C     X             IFLE      64
     C                   EVAL      R_SrlDate = %subst(R_SrlData: x)
     C                   ELSE
     C                   EVAL      R_SrlDate = *BLANKS
     C                   Endif
     C                   ELSE
     C                   EVAL      R_SrlNbr = *BLANKS
     C                   EVAL      R_SrlDate = *BLANKS
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ClcIntNbr     Berechnen der internen Serien-Nr.         *
      *============================================================*
      *
     C     ClCIntNbr     BEGSR
      *
      * -  Netzwerkattribute
     C                   CALLP     PEEK07('SYSNAME': bFalse
     C                                    : YAttrLen: YAttrTyp: YValue)
     C     YAttrLen      IFGT      *ZEROS
     C                   EVAL      YSysName = %subst(YValue: 1: YAttrLen)
     C                   ELSE
     C                   EVAL      YSysName = *BLANKS
     C                   Endif
      *
      * -  Version
     C                   EVAL      YSysVers = '010000'
      *
      * -  Seriennummer
     C                   CALLP     PEEK28('QSRLNBR': bFalse
     C                                    : YAttrLen: YAttrTyp: YValue)
     C     YAttrLen      IFGT      *ZEROS
     C                   EVAL      YSysSrlNbr = %subst(YValue: 1: YAttrLen)
     C                   ELSE
     C                   EVAL      YSysSrlNbr = *BLANKS
     C                   Endif
      *
     C                   CALLP     PEEK29(YSysName: '010000'
     C                                    : YSysSrlNbr: 0: R_SrlData)
      *
     C                   EXSR      SplittLic
     C                   EVAL      YSrlNbrInt = R_SrlNbr
     C                   EVAL      YDateInt = R_SrlDate
      *
     C                   ENDSR
      *
      *============================================================*
      *    ClcIntNbrF    Berechnen der internen Serien-Nr.         *
      *                  für eine Firmenlizenz                     *
      *============================================================*
      *
     C     ClCIntNbrF    BEGSR
      *
     C                   CALLP     PEEK29('*COMPANY': '999999'
     C                                    : '*LICENSE': 0: R_SrlData)
      *
     C                   EXSR      SplittLic
     C                   EVAL      YSrlNbrInt = R_SrlNbr
     C                   EVAL      YDateInt = R_SrlDate
      *
     C                   ENDSR
      *
      *============================================================*
      *    WrtLicData    Schreiben der Lizenzdaten                 *
      *============================================================*
      *
     C     WrtLicData    BEGSR
      *
     C                   Eval      UsrSpcDta = ##LicData
      *
     C                   ENDSR
      *
      *============================================================*
      *    HexToDec      Konvertieren HEX ==> DEC                  *
      *============================================================*
      *
     C     HexToDec      BEGSR
      *
     C                   EVAL      R_Dec = *ZEROS
     C     ' '           CHECKR    R_Hex         X
      *
     C     1             DO        X             Y
     C                   EVAL      A1 = %subst(R_Hex: Y: 1)
     C     A1            IFEQ      *BLANKS
     C                   LEAVE
     C                   Endif
      *
     C                   EVAL      ZW1 = 1
     C                   EVAL      ZW1 = %lookup(A1: Hex)
     C                   IF        (ZW1 = 0)
      *      ... Umsetzung in Dezimalwert nicht gelungen
     C                   ITER
     C                   Endif
      *
     C                   EVAL      ZW1 = ZW1 - 1
      *
     C                   EVAL      Exp = X - Y
     C     Exp           IFGT      *ZEROS
      *      ... Exponenten größer 0
     C     Exp           DOUEQ     *ZEROS
     C                   MULT      16            ZW1
     C                   EVAL      Exp = Exp - 1
     C                   Enddo
      *
     C                   EVAL      R_Dec = R_Dec + ZW1
     C                   ELSE
      *      ... Exponent = 0
     C                   EVAL      R_Dec = R_Dec + ZW1
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
      *============================================================*
      *
     C     SetScreen     BEGSR
      *
     C     i_dsp80       IFEQ      '0'
      *   132-Zeichen Anzeige
     C                   EVAL      *IN88 = '0'
     C                   EVAL      ZEI = 2
     C                   EVAL      POS = 26
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   EVAL      *IN88 = '1'
     C                   EVAL      ZEI = 1
     C                   EVAL      POS = 4
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    First         Initialisierung                           *
      *============================================================*
      *
     C     First         BEGSR
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      * - Rückgabewerte
     C                   EVAL      o_flag = bFalseExt
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
      * - Einlesen und prüfen der Lizenzdaten
     C                   EXSR      FILL##
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   EXSR      SetScreen
      *
      * - Copyright
     C                   Callp     p_sndPgmMg('USR9999': i_copyright: §§pgmName)
      *
     C                   ENDSR
      *
      *====================================================*
      *  InzSr --  Initialize program                      *
      *====================================================*
      *
     C     InzSr         Begsr
      *
     C                   If        (isInzSr = bTrue)
     C                   Leavesr
     C                   Endif
      *
     C                   Eval      isInzSr = bTrue
      *
     C                   Eval      §PgmQ = '*'
      *
     C                   Eval      PEEK07_NAME = f_pgmCallN('PEEK07')
     C                   Eval      PEEK28_NAME = f_pgmCallN('PEEK28')
     C                   Eval      PEEK29_NAME = f_pgmCallN('PEEK29')
      *
     C                   Eval      qUsrSpc.name = 'PEEKSRL'
     C                   Eval      qUsrSpc.lib  = f_getPrdLb()
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
