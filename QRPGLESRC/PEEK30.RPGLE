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
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEK30FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
     F                                     INFSR(*PSSR)
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
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
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
      *---Fehler-DS----------------------------------------*
      /COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8158
      /COPY QCOPYLE,USR9997
      *----------------------------------------------------*
      *
     D XDsp80          S              1A
     D XCopyRight      S            512A
     D XFlag           S                   LIKE(R§INT4)
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
     D YDtaAra         DS            64
     D YSrlNbrExt      S                   LIKE(R_SrlNbr ) INZ(*BLANKS)
     D YDateExt        S                   LIKE(R_SrlDate) INZ(*BLANKS)
      *
     D YAttr           S             10A   INZ(*BLANKS)
     D YNoMsg          S              1A   INZ(bFalse )
     D YAttrLen        S                   like(r§int4    ) inz
     D YAttrTyp        S              1A   INZ(*BLANKS)
     D YValue          S            512A   INZ(*BLANKS)
      *
     D YSysName        S              8A   INZ(*BLANKS)
     D YSysVers        S              6A   INZ(*BLANKS)
     D YSysSrlNbr      S              8A   INZ(*BLANKS)
     D YSysDate        S                   INZ(*ZEROS )    LIKE(R§INT4)
     D YSrlData        S             20A   INZ(*BLANKS)
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
     D ZW2             S             30P 0 INZ(*ZEROS )
     D Exp             S                   like(r§int4    ) inz
     D A1              S              1A   INZ(*BLANKS)
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
      *
      *  DeadDate
     D ZWInt           S             30P 0 INZ(*ZEROS )
     D ZWExt           S             30P 0 INZ(*ZEROS )
     D ZWDate          S              8P 0 INZ(*ZEROS )
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
     D                 DS
     D  USFNME                 1     20
     D  USNAME                 1     10    INZ
     D  USLIB                 11     20    INZ
     D  USATTR                21     30    INZ
     D  USSIZE                31     34I 0 INZ
     D  USINIT                35     35    INZ
     D  USAUTH                36     45    INZ
     D  USDESC                46     95    INZ
      *
      *  declarations for QUSRTVUS
     D                 DS
     D  USVLEN                 1      4I 0 INZ
     D  USSPOS                 5      8I 0 INZ
      *
      *  declarations for QUSCHGUS
     D  USDATA         S             64A   INZ(*BLANKS)
     D  USFORCE        S              1A   INZ('0'    )
      *
      *  Programme
     D PEEK07          S                   like(r§pgmCallN) inz
     D PEEK28          S                   like(r§pgmCallN) inz
     D PEEK29          S                   like(r§pgmCallN) inz
      *
     D §Text           C                   CONST('Peek/400-
     D                                      - Lizenzdaten')
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
     C                   PARM                    XDsp80
     C                   PARM                    XCopyRight
     C                   PARM                    XFlag
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK07
     C     P_Peek07      PLIST
     C                   PARM                    YAttr
     C                   PARM                    YNoMsg
     C                   PARM                    YAttrLen
     C                   PARM                    YAttrTyp
     C                   PARM                    YValue
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK28
     C     P_Peek28      PLIST
     C                   PARM                    YAttr
     C                   PARM                    YNoMsg
     C                   PARM                    YAttrLen
     C                   PARM                    YAttrTyp
     C                   PARM                    YValue
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK29
     C     P_Peek29      PLIST
     C                   PARM                    YSysName
     C                   PARM                    YSysVers
     C                   PARM                    YSysSrlNbr
     C                   PARM                    YSysDate
     C                   PARM                    YSrlData
      *
      ******************************************************
      *
     C                   EXSR      First
      *
     C     IsCompOK      IFEQ      bFalse
      *     Fehler in der Lizenz-Nr. ...
     C     IsDateErr     IFEQ      bTrue
      *     ... Datum abgelaufen
      *         ... Abfragen einer neuen LizenzNr.
     C                   EXSR      GetLicInf
     C     XFLag         IFNE      bTrueExt
      *         ... wenn keine neue LizenzNr eingetragen
      *             worden ist, dann bFalse zurückliefern,
      *             damit kein weiterer Test möglich ist.
     C                   OPEN      PEEK30FM
     C                   ADD       4             ZEI
     C                   ADD       4             POS
     C                   EXFMT     BILD03
     C                   CLOSE     PEEK30FM
     C                   Z-ADD     bFalseExt     XFlag
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
     C                   Z-ADD     bTrueExt      XFlag
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
     C                   MOVEL (P) *BLANKS       ##LicData
      *
     C                   DO        *HIVAL
      *
      *  Nachrichten senden
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
      *  Nachrichten anzeigen
     C                   MOVE      '0'           *IN89
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
     C     §ScnAID       WHENEQ    §F9
     C                   EXSR      C_EndPgm
     C                   Z-ADD     bShareExt     XFlag
     C                   MOVEL (P) 'USR9997'     XMsgID
     C                   MOVEL (P) §Yellow_R     USR99971
     C                   MOVEL (P) §White        USR99972
     C                   MOVEL (P) USR9997       XMsgDta
     C                   LEAVE
      *
      *  Datenfreigabe
     C     §ScnAID       WHENEQ    §ENTER
     C                   EXSR      C_Enter
     C     *IN99         IFEQ      '0'
     C                   Z-ADD     bTrueExt      XFlag
     C                   LEAVE
     C                   Endif
      *
     C                   OTHER
      *  Falsche Taste gedrückt
     C                   Callp     p_wrongKey(§scnAID: §§pgmName)
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
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8159'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   ELSE
     C                   ADD       4             ZEI
     C                   ADD       4             POS
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
     C                   MOVEL (P) '0'           *IN20                         ##LicNbr
      *
      *  DSPATR(RI)
     C                   MOVEL (P) '0'           *IN30                         ##LicNbr
      *
      *  Fehler
     C                   MOVEL (P) '0'           *IN99
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRFB1         Prüfen der Eingaben                       *
      *============================================================*
      *
     C     PRFB1         BEGSR
      *
     C                   EXSR      PRF20                                       ##LicData
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
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8158'     §MsgID
     C                   MOVEL (P) ##LicData     USR81581                       Liz.Nr.
     C                   MOVEL (P) USR8158       §MsgDta
     C                   GOTO      EPRF20
     C                   Endif
      *
     C                   MOVEL (P) ##LicData     R_SrlData
     C                   EXSR      SplittLic
     C                   MOVEL (P) R_SrlNbr      YSrlNbrExt
     C                   MOVEL (P) R_SrlDate     YDateExt
      *
     C                   EXSR      CompLicNbr
     C     IsCompOK      IFEQ      bFalse
     C                   CLEAR                   USR8158
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8158'     §MsgID
     C                   MOVEL (P) ##LicData     USR81581                       Liz.Nr.
     C                   MOVEL (P) USR8158       §MsgDta
     C                   GOTO      EPRF20
     C                   Endif
      *
     C     EPRF20        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN20
     C                   MOVEL (P) '1'           *IN30
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
     C                   MOVEL (P) bTrue         IsCompOK
     C                   LEAVESR
      *
      *------------------------------------------*
      *  ... Existenzprüfung  UserSpace          *
      *------------------------------------------*
     C                   EXSR      ChkUsrSpc
      *      ... anlegen, wenn nicht vorhanden
     C     §QCmdError    IFEQ      '1'
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
     C                   MOVEL (P) bFalse        IsCompOK
     C                   MOVEL (P) bTrue         IsDateErr
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
     C                   MOVEL (P) bFalse        IsCompOK
     C                   MOVEL (P) bTrue         IsDateErr
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
     C                   MOVEL (P) YSrlNbrInt    R_Hex
     C                   EXSR      HexToDec
     C                   Z-ADD     R_Dec         ZWInt
      *
      * -  externe Nummer umsetzen in Dezimalwert
     C                   MOVEL (P) YSrlNbrExt    R_Hex
     C                   EXSR      HexToDec
     C                   Z-ADD     R_Dec         ZWExt
      *
      * -  externes Datum umsetzen in Dezimalwert
     C                   MOVEL (P) YDateExt      R_Hex
     C                   EXSR      HexToDec
     C                   Z-SUB     R_Dec         DeadDate
     C                   ADD       99999999      DeadDate
      *
      * -  Angleichen externe Nummer
     C                   SUB       R_Dec         ZWExt
     C                   ADD       99999999      ZWExt
      *
      *------------------------------------------*
      *  ... vergleichen interne & externe       *
      *      Seriennummer                        *
      *------------------------------------------*
     C                   TIME                    CurrDatTim
     C                   Z-ADD     CurrDayFw     CurrDayRv
     C                   Z-ADD     CurrMonFw     CurrMonRv
     C                   Z-ADD     CurrYearFw    CurrYearRv
      *
     C     ZWExt         IFNE      ZWInt
     C                   MOVEL (P) bFalse        IsCompOK
     C                   MOVEL (P) bFalse        IsDateErr
     C                   ELSE
     C     DeadDate      IFLT      CurrDateRv
     C                   MOVEL (P) bFalse        IsCompOK
     C                   MOVEL (P) bTrue         IsDateErr
     C                   ELSE
     C                   MOVEL (P) bTrue         IsCompOK
     C                   MOVEL (P) bFalse        IsDateErr
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkUsrSpc     Prüfen, ob UserSpace vorhanden ist        *
      *============================================================*
      *
     C     ChkUsrSpc     BEGSR
      *
     C                   MOVEL(P)  'CHKOBJ'      §QCmd
     C                   CAT       'OBJ(':1      §QCmd
     C                   CAT       USLIB:0       §QCmd
     C                   CAT       '/':0         §QCmd
     C                   CAT       USNAME:0      §QCmd
     C                   CAT       ')':0         §QCmd
     C                   CAT       'OBJ':1       §QCmd
     C                   CAT       'TYPE(':0     §QCmd
     C                   CAT       '*USR':0      §QCmd
     C                   CAT       'SPC':0       §QCmd
     C                   CAT       ')':0         §QCmd
      *
      /COPY QCOPYLE,QCMDEXC
      *
     C                   ENDSR
      *
      *============================================================*
      *    CrtUsrSpc     Anlegen UserSpace                         *
      *============================================================*
      *
     C     CrtUsrSpc     BEGSR
      *
     C                   MOVEL (P) §Text         USDESC
      *
     C                   CALL      'QUSCRTUS'
     C                   PARM                    USFNME
     C                   PARM      'USRSPC'      USATTR
     C                   PARM      64            USSIZE
     C                   PARM      ' '           USINIT
     C                   PARM      '*ALL'        USAUTH
     C                   PARM                    USDESC
      *
     C                   ENDSR
      *
      *============================================================*
      *    RtvUsrSpc     Einlesen UserSpace                        *
      *============================================================*
      *
     C     RtvUsrSpc     BEGSR
      *
     C                   Z-ADD     64            USVLEN
     C                   Z-ADD     1             USSPOS
     C                   CALL      'QUSRTVUS'
     C                   PARM                    USFNME
     C                   PARM                    USSPOS
     C                   PARM                    USVLEN
     C                   PARM                    USDATA
      *
     C                   MOVEL (P) USDATA        YDtaAra
      *
     C                   MOVEL (P) YDtaAra       R_SrlData
     C                   EXSR      SplittLic
     C                   MOVEL (P) R_SrlNbr      YSrlNbrExt
     C                   MOVEL (P) R_SrlDate     YDateExt
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
     C                   SUB       1             X
     C     X             IFGT      *ZEROS
     C     X             SUBST (P) R_SrlData:1   R_SrlNbr
     C                   ELSE
     C                   MOVEL (P) *BLANKS       R_SrlNbr
     C                   Endif
      *
     C                   ADD       2             X
     C     X             IFLE      64
     C                   SUBST (P) R_SrlData:X   R_SrlDate
     C                   ELSE
     C                   MOVEL (P) *BLANKS       R_SrlDate
     C                   Endif
     C                   ELSE
     C                   MOVEL (P) *BLANKS       R_SrlNbr
     C                   MOVEL (P) *BLANKS       R_SrlDate
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
     C                   MOVEL (P) 'SYSNAME'     YAttr
     C                   MOVEL (P) bFalse        YNoMsg
     C                   CALL      PEEK07        P_Peek07
     C     YAttrLen      IFGT      *ZEROS
     C     YAttrLen      SUBST     YValue:1      YSysName
     C                   ELSE
     C                   MOVEL (P) *BLANKS       YSysName
     C                   Endif
      *
      * -  Version
     C                   MOVEL (P) '010000'      YSysVers
      *
      * -  Seriennummer
     C                   MOVEL (P) 'QSRLNBR'     YAttr
     C                   MOVEL (P) bFalse        YNoMsg
     C                   CALL      PEEK28        P_Peek28
     C     YAttrLen      IFGT      *ZEROS
     C     YAttrLen      SUBST     YValue:1      YSysSrlNbr
     C                   ELSE
     C                   MOVEL (P) *BLANKS       YSysSrlNbr
     C                   Endif
      *
      * -  Datum
     C                   Z-ADD     *ZEROS        YSysDate
      *
     C                   CALL      PEEK29        P_Peek29
      *
     C                   MOVEL (P) YSrlData      R_SrlData
     C                   EXSR      SplittLic
     C                   MOVEL (P) R_SrlNbr      YSrlNbrInt
     C                   MOVEL (P) R_SrlDate     YDateInt
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
      * -  Netzwerkattribute
     C                   MOVEL (P) '*COMPANY'    YSysName
      *
      * -  Version
     C                   MOVEL (P) '999999'      YSysVers
      *
      * -  Seriennummer
     C                   MOVEL (P) '*LICENSE'    YSysSrlNbr
      *
      * -  Datum
     C                   Z-ADD     *ZEROS        YSysDate
      *
     C                   CALL      PEEK29        P_Peek29
      *
     C                   MOVEL (P) YSrlData      R_SrlData
     C                   EXSR      SplittLic
     C                   MOVEL (P) R_SrlNbr      YSrlNbrInt
     C                   MOVEL (P) R_SrlDate     YDateInt
      *
     C                   ENDSR
      *
      *============================================================*
      *    WrtLicData    Schreiben der Lizenzdaten                 *
      *============================================================*
      *
     C     WrtLicData    BEGSR
      *
     C                   Z-ADD     1             USSPOS
     C                   Z-ADD     64            USVLEN
     C                   MOVEL (P) ##LicData     USDATA
      *
     C                   CALL      'QUSCHGUS'
     C                   PARM                    USFNME
     C                   PARM                    USSPOS
     C                   PARM                    USVLEN
     C                   PARM                    USDATA
     C                   PARM                    USFORCE
     C                   PARM                    §ErrorCode
      *
     C     §ErrAvail     IFEQ      *ZEROS
     C                   MOVEL (P) bTrue         IsWriteOK
     C                   ELSE
     C                   MOVEL (P) bFalse        IsWriteOK
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    HexToDec      Konvertieren HEX ==> DEC                  *
      *============================================================*
      *
     C     HexToDec      BEGSR
      *
     C                   Z-ADD     *ZEROS        R_Dec
     C     ' '           CHECKR    R_Hex         X
      *
     C     1             DO        X             Y
     C     1             SUBST (P) R_Hex:Y       A1
     C     A1            IFEQ      *BLANKS
     C                   LEAVE
     C                   Endif
      *
     C                   Z-ADD     1             ZW1
     C     A1            LOOKUP    Hex(ZW1)                               11
     C     *IN11         IFEQ      '0'
      *      ... Umsetzung in Dezimalwert nicht gelungen
     C                   ITER
     C                   Endif
      *
     C                   SUB       1             ZW1
      *
     C     X             SUB       Y             Exp
     C     Exp           IFGT      *ZEROS
      *      ... Exponenten größer 0
     C     Exp           DOUEQ     *ZEROS
     C                   MULT      16            ZW1
     C                   SUB       1             Exp
     C                   Enddo
      *
     C                   ADD       ZW1           R_Dec
     C                   ELSE
      *      ... Exponent = 0
     C                   ADD       ZW1           R_Dec
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
     C     XDsp80        IFEQ      '0'
      *   132-Zeichen Anzeige
     C                   MOVEL (P) '0'           *IN88
     C                   Z-ADD     2             ZEI
     C                   Z-ADD     26            POS
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   MOVEL (P) '1'           *IN88
     C                   Z-ADD     1             ZEI
     C                   Z-ADD     4             POS
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
     C                   Z-ADD     bFalseExt     XFlag
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
      * - Einlesen und prüfen der Lizenzdaten
     C                   EXSR      FILL##
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   EXSR      SetScreen
      *
      * - Copyright
     C                   MOVEL (P) 'USR9999'     §MsgID
     C                   MOVEL (P) XCopyRight    §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Initialisierung                           *
      *============================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   Eval      §PgmQ = '*'
      *
     C                   Eval      PEEK07 = f_pgmCallN('PEEK07')
     C                   Eval      PEEK28 = f_pgmCallN('PEEK28')
     C                   Eval      PEEK29 = f_pgmCallN('PEEK29')
      *
     C                   Eval      USNAME = 'PEEKSRL'
     C                   Eval      USLIB  = f_getPrdLb
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
     C                   Z-ADD     bFalseExt     XFlag
     C                   CLOSE     PEEK30FM                             99
     C                   GOTO      ENDE
      *
     C                   ENDSR     '*CANCL'
      *
      *---Versenden von Nachrichten------------------------*
 CPY  ***/COPY QCOPYLE,MSG_C_MAPI
      *----------------------------------------------------*
      *
