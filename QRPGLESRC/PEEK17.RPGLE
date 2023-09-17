      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.2.0                               *
      *  Programm : PEEK17                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 20.10.97  Raddatz                                 *
      *  geändert : 27.04.99  für Version 2.1.0                       *
      *  geändert : 29.07.99  für Version 2.2.0                       *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Erfassen der Suchkriterien                                   *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEK17FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
     F                                     INFSR(*PSSR)
      * Feldliste
     FPEEKFLD   IF   E           K DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     INFDS(Peek_01_DS)
     F                                     PREFIX(F_)
      *
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
      *----------------------------------------------------*
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *---Variablendefinition ShortCmd---------------------*
      /COPY QCOPYLE,ShortCmd_D
      *----------------------------------------------------*
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0002
      /COPY QCOPYLE,SET0003
      /COPY QCOPYLE,SET0008
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8108
      /COPY QCOPYLE,USR8124
      /COPY QCOPYLE,USR8126
      /COPY QCOPYLE,USR8129
      /COPY QCOPYLE,USR8134
      /COPY QCOPYLE,USR8135
      /COPY QCOPYLE,USR8136
      /COPY QCOPYLE,USR8138
      /COPY QCOPYLE,USR8140
      /COPY QCOPYLE,USR8141
      /COPY QCOPYLE,USR8142
      /COPY QCOPYLE,USR8192
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  I N F D S - D E F I N I T I O N E N               *
      *----------------------------------------------------*
      *
     DPeek_01_DS       DS
     D P1File                 83     92A
     D P1Library              93    102A
     D P1Member              129    138A
     D P1NbrOfRcd            156    159I 0
     D P1RcdNbr              397    400I 0
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D XDsp80          S              1A
     D XCopyRight      S            512A
     D XQFile          DS
     D  XFile                        10A
     D  XLibrary                     10A
     D XMember         S             10A
     D XField          S             10A
     D XOperation      S             10A
     D XArgument       S             30A
     D XSign           S              1A
     D XSrchNbrs       S             10P 0
     D XSrchType       S             10A
     D XSrchCase       S              1A
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
     D yPgm            S             10A   inz
     D yKey            S             10A   inz
     D yPosF24         S                   like(r§int4    ) inz
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(r§int4    ) inz
     D yMsgID          S              7A   INZ(*BLANKS)
     D yMsgDta         S            512A   INZ(*BLANKS)
      *
     D YScnAID         S             10A   INZ(*BLANKS)
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(r§pgmCmdDt) INZ(*BLANKS)
      *
     D YDsp80          S              1A   INZ(*BLANKS)
     D YCopyRight      S            512A   INZ(*BLANKS)
     D YField          S             10A   INZ(*BLANKS)
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D SfBot           S                   like(r§int4    ) inz
     D §NbrFKeys       C                   CONST(2)
      *
     D §Numeric        C                   CONST('1234567890')
      *
     D MustWait        S              1A   INZ(bFalse)
      *** IsNumeric       S              1A   INZ(bFalse)
      *
     D §Lower          C                   CONST('abcdefghijklmnopqrstuvwxyz')
     D §Upper          C                   CONST('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
      *
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
      *
     D R_Sign          S                   INZ(*BLANKS)   LIKE(##Sign )
     D R_Arg30         S                   INZ(*BLANKS)   LIKE(##Arg  )
     D R_QFile         S                   INZ(*BLANKS)   LIKE(XQFile )
     D R_Member        S                   INZ(*BLANKS)   LIKE(XMember)
     D R_VorK          S                   INZ(*BLANKS)   LIKE(##Arg  )
     D R_NachK         S                   INZ(*BLANKS)   LIKE(##Arg  )
     D R_A1            S              1A   INZ(*BLANKS)
     D R_A30           S                   INZ(*BLANKS)   LIKE(##Arg  )
     D R_Field         S                   INZ(*BLANKS)   LIKE(##Field)
      *
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
     D PEEK37          S                   like(r§pgmCallN) inz
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     C     *ENTRY        PLIST
     C                   PARM                    XDsp80
     C                   PARM                    XCopyRight
     C                   PARM                    XQFile
     C                   PARM                    XMember
     C                   PARM                    XField
     C                   PARM                    XOperation
     C                   PARM                    XArgument
     C                   PARM                    XSign
     C                   PARM                    XSrchNbrs
     C                   PARM                    XSrchType
     C                   PARM                    XSrchCase
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK23
     C     P_Peek23      PLIST
     C                   PARM                    yPgm
     C                   PARM                    yKey
     C                   PARM                    yPosF24
     C                   PARM                    yFKeys
     C                   PARM                    yNbrOfKeys
     C                   PARM                    yMsgID
     C                   PARM                    yMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK21
     C     P_Peek21      PLIST
     C                   PARM                    YScnAID
     C                   PARM                    YPgm
     C                   PARM                    YPgmCmd
     C                   PARM                    YCmdDta
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK37
     C     P_Peek37      PLIST
     C                   PARM                    YDsp80
     C                   PARM                    YCopyRight
     C                   PARM                    YField
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLD
     C     F_KEY         KLIST
     C                   KFLD                    F_Field
      *
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
      *
      *---------------------------------------------------*
      *  Schleife für Programmbearbeitung
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
      *  Anzeigen der Befehlstasten
     C                   SELECT
     C                   When      (SFBOT = 2) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#2                                      BT-Tasten 2
     C                   When      (SFBOT = 3) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#3                                      BT-Tasten 3
     C                   When      (SFBOT = 4) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#4                                      BT-Tasten 4
     C                   When      (SFBOT = 5) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#5                                      BT-Tasten 4
     C                   When      (SFBOT = 6) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#6                                      BT-Tasten 4
     C                   OTHER
     C                   WRITE     PBBOT#1                                      BT-Tasten 1
     C                   Z-ADD     1             SFBOT
     C                   Endsl
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
      *  Mappen der gedrückten Taste
      *  in Programmbefehl
     C                   MOVEL (P) §ScnAID       YScnAID
     C                   MOVEL (P) §§PgmName     YPgm
     C                   CALL      PEEK21        P_Peek21
     C     YMsgID        IFNE      *BLANKS
     C                   MOVEL (P) YMsgID        §MsgID
     C                   MOVEL (P) YMsgDta       §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ITER
     C                   Endif
      *
      *  Abfragen der Programmbefehle
     C                   SELECT
      *  F3  - Ende
     C     YPgmCmd       WHENEQ    '*EXIT'                                      ENDE
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *
      *  F4  - Prompt
     C     YPgmCmd       WHENEQ    '*PROMPT'
     C                   EXSR      C_Prompt
     C                   ITER
      *
      *  F5  - Aktualisieren
     C     YPgmCmd       WHENEQ    '*REFRESH'                                   AKTUALISIEREN
     C                   EXSR      C_Refresh
     C                   ITER
      *
      *  F12 - Ende
     C     YPgmCmd       WHENEQ    '*CANCEL'                                    ZURÜCK
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *
      *  F24 - Weitere Tasten
     C     YPgmCmd       WHENEQ    '*MOREKEYS'
     C                   EXSR      C_MoreKeys
      *
      *  Datenfreigabe
     C     YPgmCmd       WHENEQ    '*ENTER'
     C                   EXSR      C_Enter
     C     *IN99         IFEQ      '0'
     C                   MOVEL (P) 'USR8112'     XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
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
      *  Ende der Hauptschleife
      *---------------------------------------------------*
      *
      *  Programm verlassen
     C     ENDE          TAG
      *
     C                   CLOSE     PEEKFLD
     C                   CLOSE     PEEK17FM
      *
     C                   RETURN
      *
      *============================================================*
      *    C_Enter       "Datenfreigabetaste"                      *
      *============================================================*
      *
     C     C_Enter       BEGSR
      *
     C     §MsgID        IFNE      *BLANKS
     C                   MOVEL (P) '1'           *IN99
     C                   ELSE
      *
     C                   MOVEL (P) ##FIELD       R_FIELD
      *
      *  Prompt?
      *  ... ##Field
     C                   IF        %trim(##Field ) = SET_PRMT
     C                   EXSR      C_Prompt
     C     §MsgID        IFNE      *BLANKS
     C                   MOVEL (P) '1'           *IN99
     C                   GOTO      E_Enter
     C                   ELSE
      *  ...?
     C                   Endif
     C                   Endif
      *
     C                   EXSR      PRFB1
      *
     C     ##FIELD       IFNE      R_FIELD
     C                   MOVEL (P) bTrue         MustWait
     C                   Endif
      *
     C     MustWait      IFEQ      bTrue
     C                   MOVEL (P) '1'           *IN99
     C                   ELSE
      *  Wert belassen ...
     C                   Endif
     C                   Endif
      *
     C     E_Enter       TAG
      *
     C     *IN99         IFEQ      '0'
     C                   MOVEL (P) ##FIELD       XField
     C                   MOVEL (P) ##OP          XOperation
     C                   MOVEL (P) R_Arg30       XArgument
     C                   MOVEL (P) ##Sign        XSign
     C                   Z-ADD     ##NBRS        XSrchNbrs
      *
     C                   SELECT
     C     ##TYPE        WHENEQ    'U'
     C                   MOVEL (P) '*UNDERLINE'  XSrchType
     C     ##TYPE        WHENEQ    'R'
     C                   MOVEL (P) '*REVERSE'    XSrchType
     C     ##TYPE        WHENEQ    'P'
     C                   MOVEL (P) '*PINROW'     XSrchType
     C                   OTHER
     C                   MOVEL (P) '*NORMAL'     XSrchType
     C                   Endsl
      *
     C                   MOVEL (P) ##CASE        XSrchCase
      *
     C                   MOVEL (P) 'USR8112'     XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
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
     C                   MOVEL (P) '0'           *IN20                         ##FIELD
     C                   MOVEL (P) '0'           *IN21                         ##OP
     C                   MOVEL (P) '0'           *IN22                         ##ARG
     C                   MOVEL (P) '0'           *IN23                         ##NBRS
     C                   MOVEL (P) '0'           *IN24                         ##TYPE
     C                   MOVEL (P) '0'           *IN25                         ##CASE
      *
      *  DSPATR(RI)
     C                   MOVEL (P) '0'           *IN30                         ##FIELD
     C                   MOVEL (P) '0'           *IN31                         ##OP
     C                   MOVEL (P) '0'           *IN32                         ##ARG
     C                   MOVEL (P) '0'           *IN33                         ##NBRS
     C                   MOVEL (P) '0'           *IN34                         ##TYPE
     C                   MOVEL (P) '0'           *IN35                         ##CASE
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
     C                   MOVEL (P) bFalse        MustWait
      *
     C                   EXSR      PRF20                                       Field
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF21                                       Operation
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF22                                       Argument
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF23                                       Search Nbrs
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF24                                       Search Type
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF25                                       Case-Sens.
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C     EPRFB1        ENDSR
      *
      *============================================================*
      *    PRF20         Prüfen:  Feldname                         *
      *============================================================*
      *
     C     PRF20         BEGSR
      *
     C     ##FIELD       IFEQ      '*RECORD'
      *        suchen im ganzen Datensatz
     C                   ELSE
      *
     C                   MOVEL (P) ##FIELD       F_FIELD
     C     F_KEY         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '1'
      *  Fehlermeldung ...
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8136
     C                   MOVEL (P) 'USR8136'     §MsgID
     C                   MOVEL (P) ##Field       USR81361                       Feldname
     C                   MOVEL (P) USR8136       §MsgDta
     C                   GOTO      EPRF20
     C                   ELSE
     C                   MOVEL (P) F_FFD         FLDL0100
     C                   Endif
      *
      ***                EXSR      ChkNumeric
      *
     C                   IF        FLDL0100.F1DTyp <> 'A' and                   alpha-num
      ***                          FLDL0100.F1DTyp <> 'G' and                   graphic
     C                             FLDL0100.F1DTyp <> 'S' and                   Zoned
     C                             FLDL0100.F1DTyp <> 'B' and                   Binary
     C                             FLDL0100.F1DTyp <> 'P' and                   Packed
     C                             FLDL0100.F1DTyp <> 'T' and                   Time
     C                             FLDL0100.F1DTyp <> 'L' and                   Date
     C                             FLDL0100.F1DTyp <> 'F'                       Float
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8129
     C                   EVAL      §MsgID = 'USR8129'
     C                   EVAL      USR81291 = ##Field                           Feldname
     C                   EVAL      USR81292 = FLDL0100.F1DTyp                   Datentyp
     C                   EVAL      §MsgDta = USR8129
     C                   GOTO      EPRF20
     C                   Endif
      *
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
      *    PRF21         Prüfen:  Operation                        *
      *============================================================*
      *
     C     PRF21         BEGSR
      *
     C     ##OP          IFNE      'EQ'
     C     ##OP          ANDNE     'NE'
     C     ##OP          ANDNE     'LT'
     C     ##OP          ANDNE     'GT'
     C     ##OP          ANDNE     'LE'
     C     ##OP          ANDNE     'GE'
     C     ##OP          ANDNE     'LIKE'
     C     ##OP          ANDNE     'NLIKE'
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8124
     C                   MOVEL (P) 'USR8124'     §MsgID
     C                   MOVEL (P) ##OP          USR81241                       Operation
     C                   MOVEL (P) USR8124       §MsgDta
     C                   GOTO      EPRF21
     C                   Endif
      *
     C     ##FIELD       IFNE      '*RECORD'
     C     ##OP          IFEQ      'LIKE'
     C     ##OP          OREQ      'NLIKE'
     C**   F1DTyp        IFNE      'A'                                          alpha-num
     C**   F1DTyp        ANDNE     'L'                                          Date
     C**   F1DTyp        ANDNE     'T'                                          Time
     C                   IF        FLDL0100.F1DTyp <> 'A' and                   alpha-num
     C                             FLDL0100.F1DTyp <> 'L' and                   Date
     C                             FLDL0100.F1DTyp <> 'T'                       Time
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8135
     C                   EVAL      §MsgID = 'USR8135'
     C                   EVAL      USR81351 = ##OP                              Operand
     C                   EVAL      USR81352 = FLDL0100.F1DTyp                   Datentyp
     C                   EVAL      §MsgDta = USR8135
     C                   GOTO      EPRF21
     C                   Endif
     C                   Endif
     C                   Endif
      *
     C     ##FIELD       IFEQ      '*RECORD'
     C     ##OP          ANDNE     'LIKE'
     C     ##OP          ANDNE     'NLIKE'
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8134
     C                   MOVEL (P) 'USR8134'     §MsgID
     C                   MOVEL (P) ##OP          USR81341                       Operation
     C                   MOVEL (P) ##FIELD       USR81342                       Feld
     C                   MOVEL (P) USR8134       §MsgDta
     C                   GOTO      EPRF21
     C                   Endif
      *
     C     EPRF21        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN21
     C                   MOVEL (P) '1'           *IN31
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF22         Prüfen:  Argument                         *
      *============================================================*
      *
     C     PRF22         BEGSR
      *
     C                   MOVEL (P) *BLANKS       R_Sign
     C                   MOVEL (P) *BLANKS       ##Sign
      *
     C     ##ARG         IFEQ      *BLANKS
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8140'     §MsgID
     C                   MOVEL (P) USR8140       §MsgDta
     C                   GOTO      EPRF22
     C                   Endif
      *
      *  Umsetzen in internes Arbeitsfeld ...
     C     cLOWER:cUPPER XLATE (P) ##Arg         R_Arg30
      *
     C                   SELECT
      *  Umsetzen des Sonderwertes "*BLANKS" ...
     C     R_Arg30       WHENEQ    '*BLANKS'
     C     R_Arg30       OREQ      '*BLANK'
     C                   MOVEL (P) *BLANKS       R_Arg30
      *
      *  Umsetzen des Sonderwertes "*ZEROS" ...
     C     R_Arg30       WHENEQ    '*ZEROS'
     C     R_Arg30       OREQ      '*ZERO'
     C                   MOVEL (P) *ZEROS        R_Arg30
     C                   OTHER
      *  ... aktuellen Wert belassen
     C                   MOVEL (P) ##Arg         R_Arg30
     C                   ENDSL
      *
      *  Verarbeiten numerischer Werte ...
     C                   If        f_isNumFld(FLDL0100) = bTrue
      *
      *  ... Vorzeichen, links
     C                   EXSR      SignLeft
      *  ... Vorzeichen, rechts
     C                   EXSR      SignRight
      *
      *  ... umsetzen *BLANKS in '+' Zeichen
     C     ##Sign        IFEQ      *BLANKS
     C                   MOVEL (P) SET_SignP     ##Sign
     C                   ELSE
      *      ... Vorzeichen stehen lassen
     C                   Endif
      *
      *  ... gültige Daten
      *      ... Komma extrahieren
     C                   IF        FLDL0100.F1DTyp = 'F'                        Float
     C                   IF        f_vldFLoat(R_Arg30) = bFalse
     C                   EVAL      *IN99 = '1'
     C                   MOVEL (P) 'USR8192'     §MsgID
     C                   MOVEL (P) ##Field       USR81921
     C                   MOVEL (P) USR8192       §MsgDta
     C                   ENDIF
     C                   ELSE
     C                   EXSR      SrchPoint
     C                   EXSR      ExpandNum
     C                   EXSR      ChkNumData
     C                   ENDIF
      *
     C     *IN99         IFEQ      '1'
     C                   GOTO      EPRF22
     C                   Endif
      *
      *  ... falsches Vorzeichen
     C     ##Sign        IFNE      SET_SignM
     C     ##Sign        ANDNE     SET_SignP
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8141
     C                   MOVEL (P) 'USR8141'     §MsgID
     C                   MOVEL (P) SET_SignP     USR81411
     C                   MOVEL (P) SET_SignM     USR81412
     C                   MOVEL (P) USR8141       §MsgDta
     C                   GOTO      EPRF22
     C                   ELSE
      *  ... richtiges Vorzeichen
     C                   Endif
      *
     C                   ELSE
      *  Alpha-numerische Werte ...
      *  ... Vorzeichen
     C                   MOVEL (P) *BLANKS       ##Sign
     C                   Endif
      *
     C     EPRF22        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN22
     C                   MOVEL (P) '1'           *IN32
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    SignLeft      Prüfen extrahieren Vorzeichen links       *
      *============================================================*
      *
     C     SignLeft      BEGSR
      *
      *   Suchen erstes Zeichen <> *BLANKS ...
     C     ' '           CHECK     R_Arg30       X
     C     X             IFEQ      *ZEROS
      *   Wenn nicht gefunden, dann ist nichts zu tun ...
     C                   ELSE
      *   ansonsten das Zeichen extrahieren.
     C     1             SUBST (P) R_Arg30:X     R_Sign
      *   Wenn das extrahierte Zeichen dem '+' oder '-'
      *   Zeichen entspricht, dann die Umsetzung vornehmen ...
     C     R_Sign        IFEQ      SET_SignM
     C     R_Sign        OREQ      SET_SignP
     C                   MOVEL (P) R_Sign        ##Sign
     C                   ADD       1             X
     C     X             IFLE      30
     C                   SUBST (P) R_Arg30:X     R_Arg30
     C                   ELSE
     C                   MOVEL (P) *BLANKS       R_Arg30
     C                   Endif
     C                   ELSE
      *   ... ansonsten ist nix zu tun.
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    SignRight     Prüfen und umsetzen Vorzeichen rechts     *
      *============================================================*
      *
     C     SignRight     BEGSR
      *
      *   Suchen letztes Zeichen <> *BLANKS ...
     C     ' '           CHECKR    R_Arg30       X
     C     X             IFEQ      *ZEROS
      *   Wenn nicht gefunden, dann ist nichts zu tun ...
     C                   ELSE
      *   ansonsten das Zeichen extrahieren.
     C     1             SUBST (P) R_Arg30:X     R_Sign
      *   Wenn das extrahierte Zeichen dem '+' oder '-'
      *   Zeichen entspricht, dann die Umsetzung vornehmen ...
     C     R_Sign        IFEQ      SET_SignM
     C     R_Sign        OREQ      SET_SignP
     C                   MOVEL (P) R_Sign        ##Sign
     C                   SUB       1             X
     C     X             IFGT      *ZEROS
     C     X             SUBST (P) R_Arg30:1     R_Arg30
     C                   ELSE
     C                   MOVEL (P) *BLANKS       R_Arg30
     C                   Endif
     C                   ELSE
      *   ... ansonsten ist nix zu tun.
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchPoint     Prüfen und umsetzen Komma                 *
      *============================================================*
      *
     C     SrchPoint     BEGSR
      *
     C                   If        f_isNumFld(FLDL0100) = bFalse
      *    keine Aufbereitung für nicht-numerische Daten
     C                   ELSE
      *
      *  Suchen nach Komma ...
     C     SET_Point     SCAN      R_Arg30       X
     C     X             IFEQ      *ZEROS
      *   Wenn nicht gefunden, dann Länge +1 ...
     C     ' '           CHECKR    R_Arg30       X
     C                   ADD       1             X
     C                   Endif
      *
      *   ansonsten Vorkommastellen ...
     C                   SUB       1             X
     C     X             IFGT      *ZEROS
     C     X             SUBST (P) R_Arg30:1     R_VorK
     C                   ELSE
     C                   MOVEL (P) *BLANKS       R_VorK
     C                   Endif
      *   ... und Nachkommastellen extrahieren
     C                   ADD       2             X
     C     X             IFLE      30
     C                   SUBST (P) R_Arg30:X     R_NachK
     C                   ELSE
     C                   MOVEL (P) *BLANKS       R_NachK
     C                   Endif
      *
      *   Anzahl der Nachkommastellen auffüllen ...
     C                   IF        FLDL0100.F1DECP <= 0
      *   ... keine vorhanden
     C                   MOVEL (P) *BLANKS       R_NachK
     C                   ELSE
      *   ... auffüllen
     C                   DO        *HIVAL
     C**   1             SUBST     R_NachK:F1DECPR_A1
     C                   EVAL      R_A1 = %subst(R_NachK: FLDL0100.F1DECP: 1)
     C
     C     R_A1          IFNE      *BLANKS
     C**   F1DECP        SUBST (P) R_NachK       R_NachK
     C                   EVAL      R_NachK = %subst(R_NachK: 1: FLDL0100.F1DECP)
     C                   LEAVE
     C                   Endif
      *
     C                   CAT       '0':0         R_NachK
     C                   Enddo
     C                   Endif
      *
      *   Ganzzahl zusammenbauen ...
     C     R_VorK        CAT       R_NachK:0     R_Arg30
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF23         Prüfen:  Anzahl Datensätze                *
      *============================================================*
      *
     C     PRF23         BEGSR
      *
     C     ##NBRS        IFEQ      *ZEROS
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8125'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   GOTO      EPRF23
     C                   Endif
      *
     C     EPRF23        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN23
     C                   MOVEL (P) '1'           *IN33
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF24         Prüfen:  Suchtyp                          *
      *============================================================*
      *
     C     PRF24         BEGSR
      *
     C     ##TYPE        IFNE      'N'
     C     ##TYPE        ANDNE     'R'
     C     ##TYPE        ANDNE     'U'
     C     ##TYPE        ANDNE     'P'
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8126
     C                   MOVEL (P) 'USR8126'     §MsgID
     C                   MOVEL (P) ##TYPE        USR81261
     C                   MOVEL (P) USR8126       §MsgDta
     C                   GOTO      EPRF24
     C                   Endif
      *
     C     EPRF24        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN24
     C                   MOVEL (P) '1'           *IN34
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF25         Prüfen:  case-sensitive                   *
      *============================================================*
      *
     C     PRF25         BEGSR
      *
     C     ##CASE        IFNE      bTrue
     C     ##CASE        ANDNE     bFalse
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8133'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   GOTO      EPRF25
     C                   Endif
      *
     C     EPRF25        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN25
     C                   MOVEL (P) '1'           *IN35
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_EndPgm      F3/F12 - Programm beenden                 *
      *============================================================*
      *
     C     C_EndPgm      BEGSR
      *
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   MOVEL (P) 'USR8100'     XMsgID
      *
     C                   SELECT
     C     §ScnAID       WHENEQ    §F3
     C                   MOVEL (P) 'F3'          USR81001
     C     §ScnAID       WHENEQ    §F12
     C                   MOVEL (P) 'F12'         USR81001
     C                   OTHER
     C                   MOVEL (P) 'Fxx'         USR81001
     C                   Endsl
      *
     C                   MOVEL (P) USR8100       XMsgDta
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Prompt      F4  - Prompt                              *
      *============================================================*
      *
     C     C_Prompt      BEGSR
      *
     C                   SELECT
     C     ScnFld        WHENEQ    '##FIELD'
     C     ##Field       OREQ      SET_PRMT
     C                   EXSR      Pmt_Field
     C                   OTHER
     C                   MOVEL (P) 'USR8179'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    Pmt_Field     Prompt - Field                            *
      *============================================================*
      *
     C     Pmt_Field     BEGSR
      *
     C                   MOVEL (P) xDsp80        YDsp80
     C                   MOVEL (P) xCopyRight    YCopyRight
     C                   CALL      PEEK37        P_Peek37
      *
     C     yMsgID        IFEQ      *BLANKS
     C                   MOVEL (P) yField        ##Field
     C                   ELSE
     C                   MOVEL (P) yMsgID        §MsgID
     C                   MOVEL (P) yMsgDta       §MsgDta
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Refresh     F5  - Aktualisieren der Subfile           *
      *============================================================*
      *
     C     C_Refresh     BEGSR
      *
     C                   EXSR      FILL##
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_MoreKeys    F24 - Weitere Tasten                      *
      *============================================================*
      *
     C     C_MoreKeys    BEGSR
      *
     C                   ADD       1             SFBOT
      *
     C                   ENDSR
      *
      *============================================================*
      *    FILL##        Füllen Bildschirm                         *
      *============================================================*
      *
     C     FILL##        BEGSR
      *
      *  Wenn die Datei oder das Member gewechselt hat,
     C     XQFile        IFNE      R_QFile
     C     XMember       ORNE      R_Member
      *  ... dann die Bildschirmfelder neu
      *      initialisieren.
     C                   EXSR      InitField
     C                   MOVEL (P) XQFile        R_QFile
     C                   MOVEL (P) XMember       R_Member
     C                   ELSE
      *  ... sonst die Bildschirmfelder belassen
     C                   Endif
      *
     C     F_KEY         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '1'
     C                   CLEAR                   FLDL0100
     C                   ELSE
     C                   MOVEL (P) F_FFD         FLDL0100
     C                   Endif
      *
      *  Auf numerische Daten prüfen ...
      ***                EXSR      ChkNumeric
      *
      *  Defaultoperationscode einsetzen ...
     C     ##OP          IFEQ      *BLANKS
     C                   MOVEL (P) 'EQ'          ##OP
     C                   ELSE
      *  Operationscode stehenlasen
     C                   Endif
      *
      *  Sonderwerte einsetzen ...
     C                   SELECT
     C     ##ARG         WHENEQ    *BLANKS
     C                   MOVEL (P) '*BLANKS'     ##ARG
     C     ##ARG         WHENEQ    *ZEROS
     C                   MOVEL (P) '*ZEROS'      ##ARG
     C                   OTHER
      *  ... Umsetzung nicht erforderlich
     C                   Endsl
      *
     C     ##Nbrs        IFEQ      *ZEROS
     C                   Z-ADD     SET_SNbrs     ##Nbrs
     C                   ELSE
      *  Wert stehenlassen ...
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    InitField     Initialisieren der Bildschirmfelder       *
      *============================================================*
      *
     C     InitField     BEGSR
      *
     C                   MOVEL (P) *BLANKS       ##Field
     C                   MOVEL (P) *BLANKS       ##OP
     C                   MOVEL (P) *BLANKS       ##Arg
     C                   MOVEL (P) *BLANKS       ##Sign
     C                   MOVEL (P) SET_WLDCD     $$WLDCD
     C                   Z-ADD     *ZEROS        ##Nbrs
     C                   MOVEL (P) 'N'           ##Type
     C                   MOVEL (P) bFalse        ##Case
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
     C                   Z-ADD     6             ZEI
     C                   ADD       1             ZEI
     C                   Z-ADD     26            POS
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   MOVEL (P) '1'           *IN88
     C                   Z-ADD     4             ZEI
     C                   ADD       3             ZEI
     C                   Z-ADD     7             POS
     C                   Endif
      *
      *  Prompt-Felder anzeigen ...
     C     SET_DspPmt    IFEQ      bTrue
     C                   MOVEL (P) '1'           *IN71
     C                   ELSE
     C                   MOVEL (P) '0'           *IN71
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
      *============================================================*
      *
     C     GetUsrSetg    BEGSR
      *
      *  Attribute der Suchfunktion
     C                   Eval      SET0002 = f_getUsrSg('*SEARCH'   )
      *
      *  Attribute der Schlüsselaufbeeitung
     C                   Eval      SET0003 = f_getUsrSg('*ACCESSKEY')
      *
      *  *PROMPT
     C                   Eval      SET0008 = f_getUsrSg('*PROMPT'   )
      *
     C                   ENDSR
      *
      *============================================================*
      *    TrimNum       Nullenunterdrückung für numerische Daten  *
      *============================================================*
      *
     C     TrimNum       BEGSR
      *
     C                   If        f_isNumFld(FLDL0100) = bFalse
      *    keine Aufbereitung für nicht-numerische Daten
     C                   ELSE
      *
     C     '0'           CHECK     R_Arg30       X                              Zoned
     C     X             IFGT      *ZEROS                                       Binary
     C                   SUBST (P) R_Arg30:X     R_Arg30
     C                   ELSE
      *     Nur führende Nullen vorhanden
     C                   MOVEL (P) *BLANKS       R_Arg30
     C                   Endif
      *
      *     Argument bestand nur aus führenden Nullen
      *     oder nur aus *BLANKS ...
     C     R_Arg30       IFEQ      *BLANKS
     C                   MOVEL (P) '0'           R_Arg30
     C                   ELSE
      *         keine Korrektur der Aufbereitung
      *         erforderlich
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkNumData    auf gültige numerische Daten prüfen       *
      *============================================================*
      *
     C     ChkNumData    BEGSR
      *
     C                   If        f_isNumFld(FLDL0100) = bFalse
      *    keine Prüfung für nicht-numerische Daten
     C                   ELSE
      *
     C     §Numeric      CHECK     R_Arg30                                99
     C     *IN99         IFEQ      '1'                                          = Fehler
     C                   MOVEL (P) 'USR8138'     §MsgID
     C                   MOVEL (P) ##Field       USR81381
     C                   MOVEL (P) USR8138       §MsgDta
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ExpandNum     numerische Daten rechtsbündig setzen      *
      *============================================================*
      *
     C     ExpandNum     BEGSR
      *
     C                   If        f_isNumFld(FLDL0100) = bFalse
      *    keine Aufbereitung für nicht-numerische Daten
     C                   ELSE
      *
     C     ' '           CHECKR    R_Arg30       X                              Zoned
     C     30            SUB       X             X
     C     X             IFGT      *ZEROS                                       Binary
     C     ' '           CAT   (P) R_Arg30:X     R_Arg30
     C                   ELSE
      *     ... ist bereits rechtbündig
     C                   Endif
      *
     C     ' ':'0'       XLATE (P) R_Arg30       R_Arg30
      *
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
      * - Öffnen der Dateien
     C                   OPEN      PEEKFLD
     C                   OPEN      PEEK17FM
      *
      * - Benutzervoreinstellungen
     C                   EXSR      GetUsrSetg
      *
      * - Füllen der Bildschirmfelder
     C                   EXSR      FILL##
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
      * - Darstellung der Befehlstasten
     C                   Z-ADD     1             SfBot
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
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        Begsr
      *
     C                   Eval      §PgmQ = '*'
      *
     C                   Eval      PEEK21 = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23 = f_pgmCallN('PEEK23')
     C                   Eval      PEEK37 = f_pgmCallN('PEEK37')
      *
     C                   Eval      yPgm    = §§PgmName
     C                   Eval      yKey    = '*ALL'
      ***                Eval      yPosF24 = §NbrFKeys
     C                   Eval      yPosF24 = *ZEROS
     C                   Call      PEEK23        P_Peek23
     C                   Movea (P) YFKeys        ScrnFKeys
      *
     C                   Endsr
      *
      *============================================================*
      *    *PSSR         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   DUMP
      *
     C                   ENDSR     '*CANCL'
      *
      *---Nachrichten--------------------------------------*
 CPY  ***/COPY QCOPYLE,MSG_C_MAPI
      *----------------------------------------------------*
      *
      *---EXSR: ChkNumeric---------------------------------*
 CPY  ***/COPY QCOPYLE,ChkNumeric
      *----------------------------------------------------*
      *
