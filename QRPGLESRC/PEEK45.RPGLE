      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK45                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 15.08.98  Raddatz                                 *
      *  geändert : 27.04.99  2.1.0                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Hexadezimale Feldeditierung                                  *
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
     FPEEK45FM  CF   E             workstn usropn
     F                                     infds(§Workstn)
      * Feldliste
     FPEEKFLD   IF   E           K disk    usropn
     F                                     prefix(F_)
     F                                     infds(Peek_01_DS)
      *
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
      *----------------------------------------------------*
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_INFDS
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK45
      /undefine internal_prototype
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0006
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8136
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
     Dpeek_01_DS       DS                  likeds(infds_t)
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
      *  Peek21
     D yPgmCmd         S                   like(pgmCmd_t) inz
     D yCmdDta         S                   like(pgmCmdDt_t) inz
     D yMsgID          S                   like(msgID_t) inz
     D yMsgDta         S                   like(msgDta_t) inz
      *
      *  Peek23:
     D yFKeys          S                   like(fKeyDsp_t) inz
     D                                     dim(32)
     D yNbrOfKeys      S                   like(int4_t) inz
      *
      *  Peek32
     D yBuffer         S                   like(rcdBuf_t) inz
     D yBuffLen        S                   like(int4_t) inz
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D sfBot           S                   like(int4_t) inz
     D §nbrFKeys       C                   const(3)
      *
     D x               S                   like(int4_t) inz
     D i               S                   like(int4_t) inz
      *
     D isStringInp     S                   like(bool_t) inz(bFalse)
     D isPgmError      S                   like(bool_t) inz(bFalse)
     D isDataChg       S                   like(bool_t) inz(bFalse)
      *
     D §hexChar        C                   const('0123456789ABCDEF')
      *
     D PEEK21_NAME     S                   like(pgmCallN_t) inz
     D PEEK23_NAME     S                   like(pgmCallN_t) inz
     D PEEK32_NAME     S                   like(pgmCallN_t) inz
      *
      *
      * Arbeitsfelder
     D pStartPos       S                   like(#StartPos)
     D                                     inz
     D                 DS
     D pFldInhaltSbcs                      like(rcdBuf_t) inz
     D pFldInhaltUcs2                      like(rcdBufUcs2_t) inz
     D                                     overlay(pFldInhaltSbcs)
     D pLength         S                   like(int4_t) inz
     D pTmpNewLen      S                   like(int4_t) inz
     D pTmpHexLen      S                   like(int4_t) inz
     D pTmpHexBin      S                   like(#HexString)
     D                                     inz
      *
     D warning_1       S                   like(bool_t)
     D                                     inz(bFalse)
     D warning_2       S                   like(bool_t)
     D                                     inz(bFalse)
      *
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK32
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK71
      *
     D $OfsVal         S              4S 0 dim( 8)   inz
      *
     D #HexString      DS
     D  #HexVal                       8A   dim(32)   inz
      *
     D $EXPSTRING      DS
     D  $StrVal                      16A   dim( 8)   inz
      *
     D idx             S             10I 0 inz
     D ofs             S             10I 0 inz
     D hTranscoder     S                   LIKE(hTranscoder_t ) inz
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK45          PI
     D  i_dsp80                            const like(dsp80_t)
     D  i_headType                         const like(headTyp_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_fldName                          const like(fieldNme_t)
     D  io_fldInhalt                             likeds(fldInhalt_t)
     D  io_length                                like(int4_t)
     D  i_protect                          const like(bool_t)
     D  i_isUcs2                           const like(int4_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLD
     C     F_KEY         Klist
     C                   Kfld                    F_Field
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
      *
     C                   Exsr      First
      *
      *---------------------------------------------------*
      *  Schleife für Programmbearbeitung
      *
     C                   Do        *hival
      *
      *  Nachrichten senden
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
      *  Nachrichten anzeigen
     C                   Eval      *in89 = *off
     C                   Write     MSGCTL
      *
      *  Anzeigen der Befehlstasten
     C                   Select
     C                   When      (SFBOT = 2) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#2                                      BT-Tasten 2
     C                   When      (SFBOT = 3) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#3                                      BT-Tasten 3
     C                   When      (SFBOT = 4) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#4                                      BT-Tasten 4
     C                   When      (SFBOT = 5) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#5                                      BT-Tasten 4
     C                   When      (SFBOT = 6) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#6                                      BT-Tasten 4
     C                   When      (SFBOT = 7) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#7                                      BT-Tasten 2
     C                   When      (SFBOT = 8) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#8                                      BT-Tasten 3
     C                   OTHER
     C                   Write     PBBOT#1                                      BT-Tasten 1
     C                   Eval      sfBot = 1
     C                   Endsl
      *
      *  Füllen "Offset" Angaben
     C                   Eval      idx = 0
     C                   Eval      ofs = pStartPos - 1
     C                   For       idx = 1 to %elem($OfsVal)
     C                   Eval      $OfsVal(idx) = ofs
     C                   Eval      ofs = ofs + %len($StrVal(1))
     C                   Endfor
      *
      *  Anzeigen Bildschirm
     C                   Exsr      ToScreen
     C                   Exfmt     BILD01
     C                   Exsr      FromScreen
      *
      *  Daten geändert
     C                   Eval      isDataChg = *in93
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Bezugszahlen löschen
     C                   Exsr      bzoff1
      *
      *  Mappen der gedrückten Taste
      *  in Programmbefehl
     C                   CALLP     PEEK21(§ScnAID: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C                   If        YMsgID <> ' '
     C                   Eval      §msgID  = yMsgID
     C                   Eval      §msgDta = yMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Iter
     C                   Endif
      *
      *  Abfragen der Programmbefehle
     C                   Select
      *  F3  - Ende
     C                   When      YPgmCmd = '*EXIT'
     C                   Exsr      c_endPgm
     C                   Leave
      *
      *  F5  - Aktualisieren
     C                   When      YPgmCmd = '*REFRESH'
     C                   Exsr      c_refresh
     C                   Iter
      *
      *  F7  - Umschalten der Eingabe
     C                   When      YPgmCmd = '*TGLINPUT'
     C                   Exsr      c_enter
     C                   Exsr      c_tgInput
     C                   Iter
      *
      *  F12 - Ende
     C                   When      YPgmCmd = '*CANCEL'
     C                   Exsr      c_endPgm
     C                   Leave
      *
      *  F17 - an den Afang gehen
     C                   When      YPgmCmd = '*FIRSTPOS'
     C                   EXSR      C_firstPos
      *
      *  F18 - ans Ende gehen
     C                   When      YPgmCmd = '*LASTPOS'
     C                   EXSR      C_lastPos
      *
      *  F19 - nach rechts verschieben (ein Feld)
     C                   When      YPgmCmd = '*LEFT'
     C                   EXSR      C_moveL
      *
      *  F20 - nach links verschieben  (ein Feld)
     C                   When      YPgmCmd = '*RIGHT'
     C                   EXSR      C_moveR
      *
      *  F24 - Weitere Tasten
     C                   When      YPgmCmd = '*MOREKEYS'
     C                   Exsr      c_moreKeys
      *
      *  Page up
     C     YPgmCmd       WHENEQ    '*PAGEUP'
     C                   Exsr      c_pageUp
      *
      *  Page down
     C     YPgmCmd       WHENEQ    '*PAGEDOWN'
     C                   Exsr      c_pageDown
      *
      *  Datenfreigabe
     C                   When      YPgmCmd = '*ENTER'
     C                   Exsr      c_enter
     C                   If        isPgmError = bFalse
     C                   Eval      o_msgID  = 'USR8112'
     C                   Eval      o_msgDta = ' '
      *
     C                   if        (i_isUcs2 = 0)
     C                   Eval      io_fldInhalt.sbcs = pFldInhaltSbcs
     C                   else
     C                   Eval      io_fldInhalt.ucs2 = pFldInhaltUcs2
     C                   endif
      *
     C                   Eval      io_length = pLength
     C                   Leave
     C                   Endif
      *
     C                   Other
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
     C     ende          Tag
      *
     C                   If        %open(PEEKFLD)
     C                   Close     PEEKFLD
     C                   Endif
      *
     C                   If        %open(PEEKFLD)
     C                   Close     PEEKFLD
     C                   Endif
      *
     C                   Close     PEEK45FM
      *
     C                   Return
      *
      *============================================================*
      *    c_enter       "Datenfreigabetaste"                      *
      *============================================================*
      *
     C     c_enter       Begsr
      *
     C                   If        isPgmError = bTrue
      *
      *    ---------------------------------
      *    *** Genereller Programmfehler ***
      *    ***    keine Verarbeitung     ***
      *    ***          möglich          ***
      *    ---------------------------------
      *
     C                   Else
      *
      *  Prüfen der Eingaben
     C                   Exsr      prfb1
      *
     C                   If        isPgmError = bFalse
      *
      *
     C                   If        isDataChg = bTrue
      *
     C                   If        isStringInp = bFalse
      *  Einsetzen geänderten Hex-String ...
      *  ... umwandeln HexString (Bildschirmanzeige) nach HexWert (Pufferinhalt)
     C                   Eval      pTmpHexBin = ' '
     C                   Callp     p_ChrToHex(pTmpHexBin               :
     C                                        #HexString               :
     C                                        %len(%trimr(#HexString)))
      *      (Länge_Hex_Nibble / 2 = Länge_Hex_Bin)
     C                   Eval      x = %len(%trimr(#HexString)) / 2
     C                   Else
     C                   Eval      pTmpHexBin = %subst(pFldInhaltSbcs:pStartPos)
     C                   For       x = 1 to %len($EXPSTRING)
     C                   If        %subst($EXPSTRING: x: 1) <> SET_CVTC
     C                   Eval      %subst(pTmpHexBin: x: 1) =
     C                                   %subst($EXPSTRING: x: 1)
     C                   Endif
     C                   Endfor
      *      (Länge = Feldlänge)
     C                   Eval      x = %len($EXPSTRING)
     C                   Endif
      *
      *  ... einsetzen in Zwischenfeld für Rückgabewert
     C                   Eval      %subst(pFldInhaltSbcs: pStartPos: x) =
     C                                %subst(pTmpHexBin: 1: x)
      *
     C                   If        (i_isUcs2 = 0)
     C                   Eval      pLength = %len(%trimR(pFldInhaltSbcs))
     C                   Else
     C                   Eval      pLength = %len(%trimR(pFldInhaltUcs2))
     C                   Endif
      *
      *  Füllen #HexString und $ExpString
     C                   Exsr      fill##2
      *
      *  Merken der neuen Startposition
     C                   Eval      pStartPos = #StartPos
      *
     C                   Eval      isPgmError = bTrue
     C                   Endif
     C                   Endif
      *
     C                   Endif                                                  IsPgmError
      *
     C                   Endsr
      *
      *============================================================*
      *    c_pageUp      "Page Up"                                 *
      *============================================================*
      *
     C     c_pageUp      Begsr
      *
     C                   Eval      #STARTPOS = #STARTPOS + 128
     C                   If        #STARTPOS > $BufLaenge
     C                   Eval      #STARTPOS = $BufLaenge - 128 + 1
     C                   Endif
      *
     C                   Eval      *IN93 = *ON
     C                   Eval      isDataChg = *IN93
      *
     C                   Exsr      c_enter
      *
     C                   Endsr
      *
      *============================================================*
      *    c_pageDown    "Page Down"                               *
      *============================================================*
      *
     C     c_pageDown    Begsr
      *
     C                   Eval      #STARTPOS = #STARTPOS - 128
     C                   If        #STARTPOS < 1
     C                   Eval      #STARTPOS = 1
     C                   Endif
      *
     C                   Eval      *IN93 = *ON
     C                   Eval      isDataChg = *IN93
      *
     C                   Exsr      c_enter
      *
     C                   Endsr
      *
      *============================================================*
      *    bzoff1        Ausschalten aller Fehlerbezugszahlen      *
      *============================================================*
      *
     C     bzoff1        Begsr
      *
      *  DSPATR(PC)
     C                   Eval      *in20 = *off                                 ##FIELD
     C                   Eval      *in21 = *off                                 ##FIELD
      *
      *  DSPATR(RI)
     C                   Eval      *in30 = *off                                 ##FIELD
     C                   Eval      *in31 = *off                                 ##FIELD
      *
      *  Fehler
     C                   Eval      isPgmError = bFalse
      *
      *  Warnungen
     C                   If        isDataChg = bTrue
     C                   Eval      warning_1 = bFalse
     C                   Eval      warning_2 = bFalse
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    prfb1         Prüfen der Eingaben                       *
      *============================================================*
      *
     C     prfb1         Begsr
      *
      *  Länge und Zeichen des Hex-Strings
     C                   Exsr      prf20
     C                   If        isPgmError = bTrue
     C                   Goto      ePrfb1
     C                   Endif
      *
      *  Startposition
     C                   Exsr      prf21
     C                   If        isPgmError = bTrue
     C                   Goto      ePrfb1
     C                   Endif
      *
     C     ePrfb1        Endsr
      *
      *============================================================*
      *    prf20         Prüfen:  Hex-String                       *
      *============================================================*
      *
     C     prf20         Begsr
      *
      *  prüfen auf unzulässige Zeichen
     C     §HexChar      Check     #HexString    x                        98
     C                   If        (*in98  = *on       )  and
     C                             (x     <= %len(%trimr(#HexString)))
     C                   Eval      yMsgID  = 'USR8174'
     C                   Eval      yMsgDta = %subst(#HexString: x: 1)
     C                   Exsr      setError
     C                   Goto      ePrf20
     C                   Endif
      *
      *  Zeichenkette zu lang
     C                   If        %len(%trimr(#HexString))/2 + pStartPos - 1 >
     C                                f_buffLn(FLDL0100)
     C                   If        warning_2 = bTrue
     C                   Eval      #HexString = %subst(#HexString :
     C                                                 1          :
     C                                                 f_buffLn(FLDL0100) * 2)
     C                   Eval      isDataChg = bTrue
     C                   Else
     C                   Eval      §MsgID  = 'USR8176'
     C                   Eval      §MsgDta = ' '
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Eval      warning_2 = bTrue
     C                   Eval      isPgmError = bTrue
     C                   Goto      ePrf20
     C                   Endif
     C                   Endif
      *
      *  Ungerade Anzahl Zeichen
     C                   Eval      x = %len(%trimr(#HexString))
     C     x             Div       2             x
     C                   Mvr                     x
      *
     C                   If        x <> 0
     C                   Eval      yMsgID  = 'USR8175'
     C                   Eval      yMsgDta = ' '
     C                   Exsr      setError
     C                   Goto      ePrf20
     C                   Endif
      *
      *  Zeichenkette zu kurz
     C                   If        %len(%trimr(#HexString))/2 + pStartPos -1 <
     C                                f_buffLn(FLDL0100)
     C                             and
     C                             (%len(%trimr(#HexString)) < %len(#HexString))
     C                   If        warning_1 = bTrue
     C                   Dow       (%len(%trimr(#HexString))/2 + pStartPos -1 <
     C                                 f_buffLn(FLDL0100))
     C                             and
     C                             (%len(%trimr(#HexString)) < %len(#HexString))
      *
     C                   If        (i_isUcs2 = 0)
     C                   Eval      #HexString = %trimr(#HexString) + '40'
     C                   Else
     C                   Eval      #HexString = %trimr(#HexString) + '0020'
     C                   Endif
      *
     C                   Eval      pFldInhaltSbcs = %subst(pFldInhaltSbcs: 1:
     C                             pStartPos - 1 + %len(%trimr(#HexString)))
     C                   Eval      isDataChg = bTrue
     C                   Enddo
     C                   Else
     C                   Eval      §MsgID  = 'USR8186'
     C                   Eval      §MsgDta = ' '
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Eval      warning_1  = bTrue
     C                   Eval      isPgmError = bTrue
     C                   Goto      ePrf20
     C                   Endif
     C                   Endif
      *
     C     ePrf20        Tag
      *
     C                   If        isPgmError = bTrue
     C                   Eval      *IN20 = *on
     C                   Eval      *IN30 = *on
     C                   Eval      #StartPos = pStartPos
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    prf21         Prüfen:  Startposition                    *
      *============================================================*
      *
     C     prf21         Begsr
      *
     C                   If        #StartPos <= *ZEROS
     C                   Eval      yMsgID  = 'USR8178'
     C                   Eval      yMsgDta = ' '
     C                   Exsr      setError
     C                   Goto      ePrf21
     C                   Endif
      *
     C                   If        #StartPos > $BufLaenge
     C                   Eval      yMsgID  = 'USR8177'
     C                   Eval      yMsgDta = ' '
     C                   Exsr      setError
     C                   Goto      ePrf21
     C                   Endif
      *
     C     ePrf21        Tag
      *
     C                   If        isPgmError = bTrue
     C                   Eval      *in21 = *on
     C                   Eval      *in31 = *on
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    setError      Eintragen Programmfehler                  *
      *============================================================*
      *
     C     setError      BEGSR
      *
     C                   If        isPgmError = bTrue
      *
      *       Alte Fehlermeldung beibehalten
      *
     C                   Else
     C                   Eval      isPgmError = bTrue
     C                   Eval      §msgID  = yMsgID
     C                   Eval      §msgDta = yMsgDta
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    c_endPgm      F3/F12 - Programm beenden                 *
      *============================================================*
      *
     C     c_endPgm      BEGSR
      *
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   Eval      o_msgID = 'USR8100'
      *
     C                   SELECT
     C     §ScnAID       WHENEQ    §F3
     C                   Eval      USR81001 = 'F3'
     C     §ScnAID       WHENEQ    §F12
     C                   Eval      USR81001 = 'F12'
     C                   OTHER
     C                   Eval      USR81001 = 'Fxx'
     C                   Endsl
      *
     C                   Eval      o_msgDta = USR8100
      *
     C                   Endsr
      *
      *============================================================*
      *    c_firstPos    Erste Position anzeigen                   *
      *============================================================*
      *
     C     c_firstPos    BEGSR
      *
     C                   Eval      #StartPos = 1
      *
     C                   Eval      isDataChg = bTrue
     C                   Exsr      c_enter
      *
     C                   ENDSR
      *
      *============================================================*
      *    c_lastPos     Letzte Position anzeigen                  *
      *============================================================*
      *
     C     c_lastPos     BEGSR
      *
     C                   Eval      #StartPos = $BufLaenge            -
     C                                         %len(#hexstring) / 2 +                        R
     C                                         1
     C                   If        #StartPos < 0
     C                   Eval      #StartPos = 1
     C                   Endif
      *
     C                   Eval      isDataChg = bTrue
     C                   Exsr      c_enter
      *
     C                   ENDSR
      *
      *============================================================*
      *    c_moveL       Nach links verschieben                    *
      *============================================================*
      *
     C     c_moveL       BEGSR
      *
     C                   If        #StartPos - %len(#hexString)/2 > 0
     C                   Eval      #StartPos = #StartPos - %len(#hexString)/2
     C                   Else
     C                   Eval      #StartPos = 1
     C                   Endif
      *
     C                   Eval      isDataChg = bTrue
     C                   Exsr      c_enter
      *
     C                   ENDSR
      *
      *============================================================*
      *    c_moveR       Nach rechts verschieben                   *
      *============================================================*
      *
     C     c_moveR       BEGSR
      *
     C                   If        #StartPos + %len(#hexString)/2 < $BufLaenge
     C                   Eval      #StartPos = #StartPos + %len(#hexString)/2
     C                   Else
     C                   Eval      #StartPos = $BufLaenge - %len(#hexString)/2
     C                                         + 1
     C                   If        #StartPos < 0
     C                   Eval      #StartPos = 1
     C                   Endif
     C                   Endif
      *
     C                   Eval      isDataChg = bTrue
     C                   Exsr      c_enter
      *
     C                   ENDSR
      *
      *============================================================*
      *    c_refresh     F5  - Aktualisieren der Subfile           *
      *============================================================*
      *
     C     c_refresh     BEGSR
      *
     C                   Eval      pStartPos  = 1
     C                   Exsr      GetParameters
      *
     C                   EXSR      bzoff1
     C                   EXSR      fill##
      *
     C                   ENDSR
      *
      *============================================================*
      *    c_tgInput     F7  - Umschalten Eingabe                  *
      *============================================================*
      *
     C     c_tgInput     BEGSR
      *
     C                   If        isStringInp = bTrue
     C                   Eval      isStringInp = bFalse
     C                   Else
     C                   Eval      isStringInp = bTrue
     C                   Endif
      *
     C                   Eval      *in51 = isStringInp
      *
     C                   ENDSR
      *
      *============================================================*
      *    c_moreKeys    F24 - Weitere Tasten                      *
      *============================================================*
      *
     C     c_moreKeys    BEGSR
      *
     C                   Eval      SFBOT = SFBOT + 1
      *
     C                   ENDSR
      *
      *============================================================*
      *    fill##        Füllen Bildschirm                         *
      *============================================================*
      *
     C     fill##        Begsr
      *
      *  anzeigen Feldüberschrift
     C                   Eval      $FldName = f_headline(i_headType: FLDL0100)
      *
      *  anzeigen alphanumerisches oder numerisches Feld
     C                   If        (f_isNumFld(FLDL0100) = bTrue) and
     C                             (f_isFloatFld(FLDL0100) = bFalse)
     C                   Eval      *in60 = *on
     C                   Eval      $FldLaenge = FLDL0100.F1DIGT
     C                   Eval      $FldDezSt  = FLDL0100.F1DECP
     C                   Else
     C                   Eval      *in60 = *off
     C                   Eval      $FldLaenge = f_buffLn(FLDL0100)
     C                   Eval      $FldDezSt  = 0
     C                   Endif
      *
      *  anzeigen Pufferlänge
     C                   If        f_isVarLen(FLDL0100) = bTrue
     C                   Eval      *in61 = *on
     C                   Else
     C                   Eval      *in61 = *off
     C                   Endif
      *
     C                   Eval      $BufLaenge = f_buffLn(FLDL0100)
      *
     C                   Eval      #StartPos = pStartPos
      *
     C                   Exsr      fill##2
      *
     C                   Endsr
      *
      *=========================================================*
      *    fill##2    - füllen Felder:  #HexString             *
      *                                 $ExpString             *
      *                 aus pFldInhalt                         *
      *=========================================================*
      *
     C     fill##2       BEGSR
      *
      *  berechnen der Länge der aus dem Puffer zu
      *  entnehmenden Binärzeichenkette
     C                   Eval      pTmpHexLen = $BufLaenge - #StartPos + 1
      *
     C                   If        pTmpHexLen > %len(#HexString) / 2
     C                   Eval      pTmpHexLen = %len(#HexString) / 2
     C                   Endif
      *
      *  entnehmen der Binärzeichenkette aus dem Puffer
     C                   Eval      %subst(pTmpHexBin: 1) =
     C                             %subst(pFldInhaltSbcs: #StartPos: pTmpHexLen)
      *
      *  umwandeln einer Binärzeichenkette in eine
      *  lesbare Hex-Zeichenkette zur Editierung
      *  durch den Benutzer
     C                   Eval      #HexString = ' '
     C                   Callp     p_hexToChr(#HexString    :
     C                                        pTmpHexBin    :
     C                                        pTmpHexLen * 2)
      *
      *  Umsetzen Zeichensatz
     C                   If        (f_hasCcsid(FLDL0100) = bTrue)
     C                   Eval      hTranscoder =
     C                               Transcoder_toJobCcsid(FLDL0100.F1FDCC)
     C                   Eval      pTmpNewLen =
     C                               Transcoder_xlateBuffer(hTranscoder
     C                                                      : %addr(pTmpHexBin)
     C                                                      : pTmpHexLen
     C                                                      : %size(pTmpHexBin))
     C                   If        pTmpHexLen = pTmpNewLen * 2
     C                   For       i = pTmpNewLen downto 1
     C                   Eval      %subst(pTmpHexBin: (2*i)-1: 1) =
     C                             %subst(pTmpHexBin: i: 1)
     C                   Eval      %subst(pTmpHexBin: (2*i)  : 1) = ' '
     C                   Endfor
     C                   Endif
     C                   Endif
      *
      *  anzeigen expandierte Zeichenkette aus dem Puffer ...
      *  ... konvertieren nicht darstellbarer Zeichen
     C                   Eval      yBuffer    = pTmpHexBin
     C                   Eval      yBuffLen   = pTmpHexLen
     C                   CALLP     PEEK32(YBuffer: yBuffLen: 0: yMsgID: yMsgDta)
     C                   Eval      $ExpString = yBuffer
      *
     C                   Endsr
      *
      *============================================================*
      *    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
      *============================================================*
      *
     C     SetScreen     Begsr
      *
     C                   If        i_dsp80 = *off
      *   132-Zeichen Anzeige
     C                   Eval      *in88 = *off
     C                   Eval      zei = 4
     C                   Eval      pos = 43
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   Eval      *in88 = *on
     C                   Eval      zei = 3
     C                   Eval      pos = 4
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
      *============================================================*
      *
     C     GetUsrSetg    Begsr
      *
      *  *CVTCHR
     C                   Eval      SET0006 = f_getUsrSg('*CVTCHR')
      *
     C                   Endsr
      *
      *============================================================*
      *    GetParameters Laden der Programmparameter               *
      *============================================================*
      *
     C     GetParameters Begsr
      *
     C                   If        (i_isUcs2 = 0)
     C                   Clear                   pFldInhaltSbcs
     C                   Eval      %subst(pFldInhaltSbcs: 1: io_length) =
     C                                    io_fldInhalt.sbcs
     C                   Else
     C                   Clear                   pFldInhaltUcs2
     C                   Eval      %subst(pFldInhaltUcs2: 1: io_length) =
     C                                    io_fldInhalt.ucs2
     C                   Endif
      *
     C                   Eval      pLength = io_length
      *
     C                   Endsr
      *
      *============================================================*
      *    First         Initialisierung                           *
      *============================================================*
      *
     C     First         Begsr
      *
      * - Öffnen der Dateien
     C                   Open      PEEKFLD
      *
     C                   Open      PEEK45FM
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      * - Genereller Programmfehler
     C                   Eval      isPgmError = bFalse
      *
      * - Ermitteln der Feldeigenschaften
     C                   Eval      F_FIELD = i_fldName
     C     F_KEY         Chain     FPEEKFLD                           11
     C                   If        *in11 <> bFound
     C                   Eval      isPgmError = bTrue
     C                   Clear                   FLDL0100
     C                   Clear                   USR8136
     C                   Eval      §msgID     = 'USR8136'
     C                   Eval      USR81361   = i_fldName
     C                   Eval      §MsgDta    = USR8136
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Else
     C                   Eval      isPgmError = bFalse
     C                   Eval      FLDL0100   = F_FFD
     C                   Endif
      *
      * - Übernehmen der Programmparameter
     C                   Eval      pStartPos  = 1
     C                   Exsr      GetParameters
      *
     C                   If        (isPgmError = bTrue)
     C                   Eval      *in70 = '1'
     C                   Else
     C                   Eval      *in70 = i_protect
     C                   Endif
      *
     C                   Eval      o_msgID  = ''
     C                   Eval      o_msgDta = ''
      *
      * - Benutzervoreinstellungen
     C                   Exsr      GetUsrSetg
      *
      * - Sperren Felder für Offset-Anzeige
     C                   Eval      *in50 = '0'
      *
      * - Sperren Felder für String-Eingabe
     C                   Eval      isStringInp = bFalse
     C                   Eval      *in51 = isStringInp
      *
      * - Füllen der Bildschirmfelder
     C                   Exsr      bzoff1
     C                   Exsr      fill##
      *
      * - Darstellung der Befehlstasten
     C                   Eval      SfBot = 1
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   Exsr      setScreen
      *
      * - Copyright
     C                   Eval      §msgID  = 'USR9999'
     C                   Eval      §msgDta = i_copyright
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
     C                   Endsr
      *
      *====================================================*
      *  Copy program fields to screen.                    *
      *====================================================*
      *
     C     ToScreen      Begsr
      *
     C                   Eval      $OFS1 = $OfsVal( 1)
     C                   Eval      $OFS2 = $OfsVal( 2)
     C                   Eval      $OFS3 = $OfsVal( 3)
     C                   Eval      $OFS4 = $OfsVal( 4)
     C                   Eval      $OFS5 = $OfsVal( 5)
     C                   Eval      $OFS6 = $OfsVal( 6)
     C                   Eval      $OFS7 = $OfsVal( 7)
     C                   Eval      $OFS8 = $OfsVal( 8)
      *
     C                   Eval      #HEX11 = #HexVal( 1)
     C                   Eval      #HEX12 = #HexVal( 2)
     C                   Eval      #HEX13 = #HexVal( 3)
     C                   Eval      #HEX14 = #HexVal( 4)
      *
     C                   Eval      #HEX21 = #HexVal( 5)
     C                   Eval      #HEX22 = #HexVal( 6)
     C                   Eval      #HEX23 = #HexVal( 7)
     C                   Eval      #HEX24 = #HexVal( 8)
      *
     C                   Eval      #HEX31 = #HexVal( 9)
     C                   Eval      #HEX32 = #HexVal(10)
     C                   Eval      #HEX33 = #HexVal(11)
     C                   Eval      #HEX34 = #HexVal(12)
      *
     C                   Eval      #HEX41 = #HexVal(13)
     C                   Eval      #HEX42 = #HexVal(14)
     C                   Eval      #HEX43 = #HexVal(15)
     C                   Eval      #HEX44 = #HexVal(16)
      *
     C                   Eval      #HEX51 = #HexVal(17)
     C                   Eval      #HEX52 = #HexVal(18)
     C                   Eval      #HEX53 = #HexVal(19)
     C                   Eval      #HEX54 = #HexVal(20)
      *
     C                   Eval      #HEX61 = #HexVal(21)
     C                   Eval      #HEX62 = #HexVal(22)
     C                   Eval      #HEX63 = #HexVal(23)
     C                   Eval      #HEX64 = #HexVal(24)
      *
     C                   Eval      #HEX71 = #HexVal(25)
     C                   Eval      #HEX72 = #HexVal(26)
     C                   Eval      #HEX73 = #HexVal(27)
     C                   Eval      #HEX74 = #HexVal(28)
      *
     C                   Eval      #HEX81 = #HexVal(29)
     C                   Eval      #HEX82 = #HexVal(30)
     C                   Eval      #HEX83 = #HexVal(31)
     C                   Eval      #HEX84 = #HexVal(32)
      *
     C                   Eval      $STR1 = $StrVal( 1)
     C                   Eval      $STR2 = $StrVal( 2)
     C                   Eval      $STR3 = $StrVal( 3)
     C                   Eval      $STR4 = $StrVal( 4)
     C                   Eval      $STR5 = $StrVal( 5)
     C                   Eval      $STR6 = $StrVal( 6)
     C                   Eval      $STR7 = $StrVal( 7)
     C                   Eval      $STR8 = $StrVal( 8)
      *
     C                   Endsr
      *
      *====================================================*
      *  Copy screen to program fields.                    *
      *====================================================*
      *
     C     FromScreen    Begsr
      *
     C                   Eval      $OfsVal( 1) = $OFS1
     C                   Eval      $OfsVal( 2) = $OFS2
     C                   Eval      $OfsVal( 3) = $OFS3
     C                   Eval      $OfsVal( 4) = $OFS4
     C                   Eval      $OfsVal( 5) = $OFS5
     C                   Eval      $OfsVal( 6) = $OFS6
     C                   Eval      $OfsVal( 7) = $OFS7
     C                   Eval      $OfsVal( 8) = $OFS8
      *
     C                   Eval      #HexVal( 1) = #HEX11
     C                   Eval      #HexVal( 2) = #HEX12
     C                   Eval      #HexVal( 3) = #HEX13
     C                   Eval      #HexVal( 4) = #HEX14
      *
     C                   Eval      #HexVal( 5) = #HEX21
     C                   Eval      #HexVal( 6) = #HEX22
     C                   Eval      #HexVal( 7) = #HEX23
     C                   Eval      #HexVal( 8) = #HEX24
      *
     C                   Eval      #HexVal( 9) = #HEX31
     C                   Eval      #HexVal(10) = #HEX32
     C                   Eval      #HexVal(11) = #HEX33
     C                   Eval      #HexVal(12) = #HEX34
      *
     C                   Eval      #HexVal(13) = #HEX41
     C                   Eval      #HexVal(14) = #HEX42
     C                   Eval      #HexVal(15) = #HEX43
     C                   Eval      #HexVal(16) = #HEX44
      *
     C                   Eval      #HexVal(17) = #HEX51
     C                   Eval      #HexVal(18) = #HEX52
     C                   Eval      #HexVal(19) = #HEX53
     C                   Eval      #HexVal(20) = #HEX54
      *
     C                   Eval      #HexVal(21) = #HEX61
     C                   Eval      #HexVal(22) = #HEX62
     C                   Eval      #HexVal(23) = #HEX63
     C                   Eval      #HexVal(24) = #HEX64
      *
     C                   Eval      #HexVal(25) = #HEX71
     C                   Eval      #HexVal(26) = #HEX72
     C                   Eval      #HexVal(27) = #HEX73
     C                   Eval      #HexVal(28) = #HEX74
      *
     C                   Eval      #HexVal(29) = #HEX81
     C                   Eval      #HexVal(30) = #HEX82
     C                   Eval      #HexVal(31) = #HEX83
     C                   Eval      #HexVal(32) = #HEX84
      *
     C                   Eval      $StrVal( 1) = $STR1
     C                   Eval      $StrVal( 2) = $STR2
     C                   Eval      $StrVal( 3) = $STR3
     C                   Eval      $StrVal( 4) = $STR4
     C                   Eval      $StrVal( 5) = $STR5
     C                   Eval      $StrVal( 6) = $STR6
     C                   Eval      $StrVal( 7) = $STR7
     C                   Eval      $StrVal( 8) = $STR8
      *
     C                   Endsr
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
     C                   Eval      PEEK32_NAME = f_pgmCallN('PEEK32')
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
