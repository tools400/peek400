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
     FPEEK17FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
      * Feldliste
     FPEEKFLD   IF   E           K DISK    USROPN
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
      /define internal_prototype
      /COPY QCOPYLE,PPEEK17
      /undefine internal_prototype
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
     D yPgm            S             10A   inz
     D yKey            S             10A   inz
     D yPosF24         S                   like(r§int4    ) inz
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(r§int4    ) inz
     D yMsgID          S              7A   INZ(*BLANKS)
     D yMsgDta         S            512A   INZ(*BLANKS)
      *
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
     D X               S                   like(r§int4    ) inz
      *
     D R_Sign          S                   INZ(*BLANKS)   LIKE(##Sign )
     D R_Arg30         S                   INZ(*BLANKS)   LIKE(##Arg  )
     D R_QFile         S                   INZ(*BLANKS)   LIKE(i_qFile )
     D R_Member        S                   INZ(*BLANKS)   LIKE(i_member)
     D R_VorK          S                   INZ(*BLANKS)   LIKE(##Arg  )
     D R_NachK         S                   INZ(*BLANKS)   LIKE(##Arg  )
     D R_A1            S              1A   INZ(*BLANKS)
     D R_Field         S                   INZ(*BLANKS)   LIKE(##Field)
      *
     D PEEK21_NAME     S                   like(r§pgmCallN) inz
     D PEEK23_NAME     S                   like(r§pgmCallN) inz
     D PEEK37_NAME     S                   like(r§pgmCallN) inz
      *
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK37
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(r§bool) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK17          PI
     D  i_dsp80                            const like(r§bool)
     D  i_copyright                        const like(r§copyRght)
     D  i_qFile                            const like(r§qObj)
     D  i_member                           const like(r§mbr)
     D  o_field                      10A
     D  o_operation                  10A
     D  o_argument                   63A
     D  o_sign                        1A
     D  o_srchNbrs                   10P 0
     D  o_srchType                   10A
     D  o_srchCase                    1A
     D  o_sgID                                   like(r§msgId)
     D  o_msgDta                                 like(r§msgDta)
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLD
     C     F_KEY         KLIST
     C                   KFLD                    F_Field
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
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
     C                   EVAL      *IN89 = '0'
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
     C                   EVAL      SFBOT = 1
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
     C                   CALLP     PEEK21(§ScnAID: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C     YMsgID        IFNE      *BLANKS
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
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
     C                   EVAL      o_sgID = 'USR8112'
     C                   EVAL      o_msgDta = *BLANKS
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
     C                   EVAL      *IN99 = '1'
     C                   ELSE
      *
     C                   EVAL      R_FIELD = ##FIELD
      *
      *  Prompt?
      *  ... ##Field
     C                   IF        %trim(##Field ) = SET_PRMT
     C                   EXSR      C_Prompt
     C     §MsgID        IFNE      *BLANKS
     C                   EVAL      *IN99 = '1'
     C                   GOTO      E_Enter
     C                   ELSE
      *  ...?
     C                   Endif
     C                   Endif
      *
     C                   EXSR      PRFB1
      *
     C     ##FIELD       IFNE      R_FIELD
     C                   EVAL      MustWait = bTrue
     C                   Endif
      *
     C     MustWait      IFEQ      bTrue
     C                   EVAL      *IN99 = '1'
     C                   ELSE
      *  Wert belassen ...
     C                   Endif
     C                   Endif
      *
     C     E_Enter       TAG
      *
     C     *IN99         IFEQ      '0'
     C                   EVAL      o_field = ##FIELD
     C                   EVAL      o_operation = ##OP
     C                   EVAL      o_argument = R_Arg30
     C                   EVAL      o_sign = ##Sign
     C                   EVAL      o_srchNbrs = ##NBRS
      *
     C                   SELECT
     C     ##TYPE        WHENEQ    'U'
     C                   EVAL      o_srchType = '*UNDERLINE'
     C     ##TYPE        WHENEQ    'R'
     C                   EVAL      o_srchType = '*REVERSE'
     C     ##TYPE        WHENEQ    'P'
     C                   EVAL      o_srchType = '*PINROW'
     C                   OTHER
     C                   EVAL      o_srchType = '*NORMAL'
     C                   Endsl
      *
     C                   EVAL      o_srchCase = ##CASE
      *
     C                   EVAL      o_sgID = 'USR8112'
     C                   EVAL      o_msgDta = *BLANKS
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
     C                   EVAL      *IN20 = '0'                                  ##FIELD
     C                   EVAL      *IN21 = '0'                                  ##OP
     C                   EVAL      *IN22 = '0'                                  ##ARG
     C                   EVAL      *IN23 = '0'                                  ##NBRS
     C                   EVAL      *IN24 = '0'                                  ##TYPE
     C                   EVAL      *IN25 = '0'                                  ##CASE
      *
      *  DSPATR(RI)
     C                   EVAL      *IN30 = '0'                                  ##FIELD
     C                   EVAL      *IN31 = '0'                                  ##OP
     C                   EVAL      *IN32 = '0'                                  ##ARG
     C                   EVAL      *IN33 = '0'                                  ##NBRS
     C                   EVAL      *IN34 = '0'                                  ##TYPE
     C                   EVAL      *IN35 = '0'                                  ##CASE
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
     C                   EVAL      MustWait = bFalse
      *
     C                   EXSR      PRF20                                        Field
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF21                                        Operation
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF22                                        Argument
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF23                                        Search Nbrs
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF24                                        Search Type
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF25                                        Case-Sens.
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
     C                   EVAL      F_FIELD = ##FIELD
     C     F_KEY         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '1'
      *  Fehlermeldung ...
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8136
     C                   EVAL      §MsgID = 'USR8136'
     C                   EVAL      USR81361 = ##Field                           Feldname
     C                   EVAL      §MsgDta = USR8136
     C                   GOTO      EPRF20
     C                   ELSE
     C                   EVAL      FLDL0100 = F_FFD
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
     C                   EVAL      *IN99 = '1'
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
     C                   EVAL      *IN20 = '1'
     C                   EVAL      *IN30 = '1'
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
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8124
     C                   EVAL      §MsgID = 'USR8124'
     C                   EVAL      USR81241 = ##OP                              Operation
     C                   EVAL      §MsgDta = USR8124
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
     C                   EVAL      *IN99 = '1'
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
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8134
     C                   EVAL      §MsgID = 'USR8134'
     C                   EVAL      USR81341 = ##OP                              Operation
     C                   EVAL      USR81342 = ##FIELD                           Feld
     C                   EVAL      §MsgDta = USR8134
     C                   GOTO      EPRF21
     C                   Endif
      *
     C     EPRF21        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN21 = '1'
     C                   EVAL      *IN31 = '1'
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
     C                   EVAL      R_Sign = *BLANKS
     C                   EVAL      ##Sign = *BLANKS
      *
     C     ##ARG         IFEQ      *BLANKS
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8140'
     C                   EVAL      §MsgDta = USR8140
     C                   GOTO      EPRF22
     C                   Endif
      *
      *  Umsetzen in internes Arbeitsfeld ...
     C**   cLOWER:cUPPER XLATE (P) ##Arg         R_Arg30
     C                   EVAL      R_Arg30 = %xlate(cLOWER: cUPPER: ##Arg)
      *
     C                   SELECT
      *  Umsetzen des Sonderwertes "*BLANKS" ...
     C     R_Arg30       WHENEQ    '*BLANKS'
     C     R_Arg30       OREQ      '*BLANK'
     C                   EVAL      R_Arg30 = *BLANKS
      *
      *  Umsetzen des Sonderwertes "*ZEROS" ...
     C     R_Arg30       WHENEQ    '*ZEROS'
     C     R_Arg30       OREQ      '*ZERO'
     C                   EVAL      R_Arg30 = *ZEROS
     C                   OTHER
      *  ... aktuellen Wert belassen
     C                   EVAL      R_Arg30 = ##Arg
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
     C                   EVAL      ##Sign = SET_SignP
     C                   ELSE
      *      ... Vorzeichen stehen lassen
     C                   Endif
      *
      *  ... gültige Daten
      *      ... Komma extrahieren
     C                   IF        FLDL0100.F1DTyp = 'F'                        Float
     C                   IF        f_vldFLoat(R_Arg30) = bFalse
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8192'
     C                   EVAL      USR81921 = ##Field
     C                   EVAL      §MsgDta = USR8192
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
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8141
     C                   EVAL      §MsgID = 'USR8141'
     C                   EVAL      USR81411 = SET_SignP
     C                   EVAL      USR81412 = SET_SignM
     C                   EVAL      §MsgDta = USR8141
     C                   GOTO      EPRF22
     C                   ELSE
      *  ... richtiges Vorzeichen
     C                   Endif
      *
     C                   ELSE
      *  Alpha-numerische Werte ...
      *  ... Vorzeichen
     C                   EVAL      ##Sign = *BLANKS
     C                   Endif
      *
     C     EPRF22        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN22 = '1'
     C                   EVAL      *IN32 = '1'
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
     C**   1             SUBST (P) R_Arg30:X     R_Sign
     C                   EVAL      R_Sign = %subst(R_Arg30: X: 1)
      *   Wenn das extrahierte Zeichen dem '+' oder '-'
      *   Zeichen entspricht, dann die Umsetzung vornehmen ...
     C     R_Sign        IFEQ      SET_SignM
     C     R_Sign        OREQ      SET_SignP
     C                   EVAL      ##Sign = R_Sign
     C                   EVAL      X = X + 1
     C     X             IFLE      30
     C**                 SUBST (P) R_Arg30:X     R_Arg30
     C                   EVAL      R_Arg30 = %subst(R_Arg30: x)
     C                   ELSE
     C                   EVAL      R_Arg30 = *BLANKS
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
     C**   ' '           CHECKR    R_Arg30       X
     C                   EVAL      x = %checkr(' ': R_Arg30)
     C     X             IFEQ      *ZEROS
      *   Wenn nicht gefunden, dann ist nichts zu tun ...
     C                   ELSE
      *   ansonsten das Zeichen extrahieren.
     C**   1             SUBST (P) R_Arg30:X     R_Sign
     C                   EVAL      R_Sign = %subst(R_Arg30: X: 1)
      *   Wenn das extrahierte Zeichen dem '+' oder '-'
      *   Zeichen entspricht, dann die Umsetzung vornehmen ...
     C     R_Sign        IFEQ      SET_SignM
     C     R_Sign        OREQ      SET_SignP
     C                   EVAL      ##Sign = R_Sign
     C                   EVAL      X = X - 1
     C     X             IFGT      *ZEROS
     C**   X             SUBST (P) R_Arg30:1     R_Arg30
     C                   EVAL      R_Arg30 = %subst(R_Arg30: 1: X)
     C                   ELSE
     C                   EVAL      R_Arg30 = *BLANKS
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
     C**   ' '           CHECKR    R_Arg30       X
     C                   EVAL      x = %checkr(' ': R_Arg30)
     C                   EVAL      X = X + 1
     C                   Endif
      *
      *   ansonsten Vorkommastellen ...
     C                   EVAL      X = X - 1
     C     X             IFGT      *ZEROS
     C**   X             SUBST (P) R_Arg30:1     R_VorK
     C                   EVAL      R_VorK = %subst(R_Arg30: 1: X)
     C                   ELSE
     C                   EVAL      R_VorK = *BLANKS
     C                   Endif
      *   ... und Nachkommastellen extrahieren
     C                   EVAL      X = X + 2
     C     X             IFLE      30
     C**                 SUBST (P) R_Arg30:X     R_NachK
     C                   EVAL      R_NachK = %subst(R_Arg30: X)
     C                   ELSE
     C                   EVAL      R_NachK = *BLANKS
     C                   Endif
      *
      *   Anzahl der Nachkommastellen auffüllen ...
     C                   IF        FLDL0100.F1DECP <= 0
      *   ... keine vorhanden
     C                   EVAL      R_NachK = *BLANKS
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
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8125'
     C                   EVAL      §MsgDta = *BLANKS
     C                   GOTO      EPRF23
     C                   Endif
      *
     C     EPRF23        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN23 = '1'
     C                   EVAL      *IN33 = '1'
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
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8126
     C                   EVAL      §MsgID = 'USR8126'
     C                   EVAL      USR81261 = ##TYPE
     C                   EVAL      §MsgDta = USR8126
     C                   GOTO      EPRF24
     C                   Endif
      *
     C     EPRF24        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN24 = '1'
     C                   EVAL      *IN34 = '1'
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
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8133'
     C                   EVAL      §MsgDta = *BLANKS
     C                   GOTO      EPRF25
     C                   Endif
      *
     C     EPRF25        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN25 = '1'
     C                   EVAL      *IN35 = '1'
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
     C                   EVAL      o_sgID = 'USR8100'
      *
     C                   SELECT
     C     §ScnAID       WHENEQ    §F3
     C                   EVAL      USR81001 = 'F3'
     C     §ScnAID       WHENEQ    §F12
     C                   EVAL      USR81001 = 'F12'
     C                   OTHER
     C                   EVAL      USR81001 = 'Fxx'
     C                   Endsl
      *
     C                   EVAL      o_msgDta = USR8100
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
     C                   EVAL      §MsgID = 'USR8179'
     C                   EVAL      §MsgDta = *BLANKS
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
     C                   CALLP     PEEK37(i_dsp80: i_copyright: YField
     C                                    : yMsgID: yMsgDta)
      *
     C     yMsgID        IFEQ      *BLANKS
     C                   EVAL      ##Field = yField
     C                   ELSE
     C                   EVAL      §MsgID = yMsgID
     C                   EVAL      §MsgDta = yMsgDta
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
     C                   EVAL      SFBOT = SFBOT + 1
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
     C     i_qFile       IFNE      R_QFile
     C     i_member      ORNE      R_Member
      *  ... dann die Bildschirmfelder neu
      *      initialisieren.
     C                   EXSR      InitField
     C                   EVAL      R_QFile = i_qFile
     C                   EVAL      R_Member = i_member
     C                   ELSE
      *  ... sonst die Bildschirmfelder belassen
     C                   Endif
      *
     C     F_KEY         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '1'
     C                   CLEAR                   FLDL0100
     C                   ELSE
     C                   EVAL      FLDL0100 = F_FFD
     C                   Endif
      *
      *  Auf numerische Daten prüfen ...
      ***                EXSR      ChkNumeric
      *
      *  Defaultoperationscode einsetzen ...
     C     ##OP          IFEQ      *BLANKS
     C                   EVAL      ##OP = 'EQ'
     C                   ELSE
      *  Operationscode stehenlasen
     C                   Endif
      *
      *  Sonderwerte einsetzen ...
     C                   SELECT
     C     ##ARG         WHENEQ    *BLANKS
     C                   EVAL      ##ARG = '*BLANKS'
     C     ##ARG         WHENEQ    *ZEROS
     C                   EVAL      ##ARG = '*ZEROS'
     C                   OTHER
      *  ... Umsetzung nicht erforderlich
     C                   Endsl
      *
     C     ##Nbrs        IFEQ      *ZEROS
     C                   EVAL      ##Nbrs = SET_SNbrs
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
     C                   EVAL      ##Field = *BLANKS
     C                   EVAL      ##OP = *BLANKS
     C                   EVAL      ##Arg = *BLANKS
     C                   EVAL      ##Sign = *BLANKS
     C                   EVAL      $$WLDCD = SET_WLDCD
     C                   EVAL      ##Nbrs = *ZEROS
     C                   EVAL      ##Type = 'N'
     C                   EVAL      ##Case = bFalse
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
     C                   EVAL      ZEI = 6
     C                   EVAL      ZEI = ZEI + 1
     C                   EVAL      POS = 26
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   EVAL      *IN88 = '1'
     C                   EVAL      ZEI = 4
     C                   EVAL      ZEI = ZEI + 3
     C                   EVAL      POS = 7
     C                   Endif
      *
      *  Prompt-Felder anzeigen ...
     C     SET_DspPmt    IFEQ      bTrue
     C                   EVAL      *IN71 = '1'
     C                   ELSE
     C                   EVAL      *IN71 = '0'
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
     C**                 SUBST (P) R_Arg30:X     R_Arg30
     C                   EVAL      R_Arg30 = %subst(R_Arg30: X)
     C                   ELSE
      *     Nur führende Nullen vorhanden
     C                   EVAL      R_Arg30 = *BLANKS
     C                   Endif
      *
      *     Argument bestand nur aus führenden Nullen
      *     oder nur aus *BLANKS ...
     C     R_Arg30       IFEQ      *BLANKS
     C                   EVAL      R_Arg30 = '0'
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
     C                   EVAL      §MsgID = 'USR8138'
     C                   EVAL      USR81381 = ##Field
     C                   EVAL      §MsgDta = USR8138
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
     C**   ' '           CHECKR    R_Arg30       X                              Zoned
     C                   EVAL      X = %checkr(' ': R_Arg30)
     C     30            SUB       X             X
     C     X             IFGT      *ZEROS                                       Binary
     C     ' '           CAT   (P) R_Arg30:X     R_Arg30
     C                   ELSE
      *     ... ist bereits rechtbündig
     C                   Endif
      *
     C**   ' ':'0'       XLATE (P) R_Arg30       R_Arg30
     C                   EVAL      R_Arg30 = %xlate(' ': '0': R_Arg30)
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
     C                   EVAL      o_sgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
      * - Darstellung der Befehlstasten
     C                   EVAL      SfBot = 1
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   EXSR      SetScreen
      *
      * - Copyright
     C                   EVAL      §MsgID = 'USR9999'
     C                   EVAL      §MsgDta = i_copyright
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
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
     C                   Eval      PEEK21_NAME = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23_NAME = f_pgmCallN('PEEK23')
     C                   Eval      PEEK37_NAME = f_pgmCallN('PEEK37')
      *
     C                   Callp     PEEK23(§§PgmName: '*ALL': 0
     C                                    : yFKeys: yNbrOfKeys)
     C                   Eval      ScrnFKeys = %subarr(YFKeys: 1)
      *
     C                   Endsr
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
