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
     F                                     infsr(*pssr)
      * Feldliste
     FPEEKFLD   IF   E           K disk    usropn
     F                                     prefix(F_)
     F                                     infds(Peek_01_DS)
     F                                     infsr(*pssr)
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
     Dpeek_01_DS       DS                  likeds(r§infds)
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D xDsp80          S                   like(r§dsp80   )
     D xHeadTyp        S                   like(r§headTyp )
     D xCopyRght       S                   like(r§copyRght)
     D xFldName        S                   like(r§fieldNme)
     D xFldInhalt      S                   like(r§rcdBuf  )
     D                 DS                  based(pXFldInhalt)
     D xFldInhaltSbcs                      like(r§rcdBuf    )
     D xFldInhaltUcs2                      like(r§rcdBufUcs2)
     D                                     overlay(xFldInhaltSbcs)
     D xLength         S                   like(r§int4    )
     D xProtect        S                   like(r§bool    )
     D xIsUcs2         S                   like(r§int4    )
     D xMsgID          S                   like(r§msgID   )
     D xMsgDta         S                   like(r§msgDta  )
      *
      *  Peek21
     D yScnAID         S                   like(r§scnAid  ) inz
     D yPgm            S                   like(r§pgm     ) inz
     D yKey            S             10A   inz
     D yPgmCmd         S                   like(r§pgmCmd  ) inz
     D yCmdDta         S                   like(r§pgmCmdDt) inz
     D yMsgID          S                   like(r§msgID   ) inz
     D yMsgDta         S                   like(r§msgDta  ) inz
      *
      *  Peek23:
      *yPgm            S                   like(r§pgm     ) inz
     D yPosF24         S                   like(r§int4    ) inz
     D yFKeys          S                   like(r§fKeyDsp ) inz
     D                                     dim(32)
     D yNbrOfKeys      S                   like(r§int4    ) inz
      *
      *  Peek32
     D yBuffer         S                   like(r§rcdBuf  ) inz
     D yBuffLen        S                   like(r§int4    ) inz
     D yCcsid          S                   like(r§int4    ) inz
      *yMsgID          S                   like(r§msgID   ) inz
      *yMsgDta         S                   like(r§msgDta  ) inz
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D sfBot           S                   like(r§int4    ) inz
     D §nbrFKeys       C                   const(3)
      *
     D x               S                   like(r§int4    ) inz
     D i               S                   like(r§int4    ) inz
      *
     D isStringInp     S                   like(r§bool    ) inz(bFalse)
     D isPgmError      S                   like(r§bool    ) inz(bFalse)
     D isDataChg       S                   like(r§bool    ) inz(bFalse)
      *
     D §hexChar        C                   const('0123456789ABCDEF')
      *
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
     D PEEK32          S                   like(r§pgmCallN) inz
      *
      *
      * Arbeitsfelder
     D pMaxLenHex      S                   like(r§int4    ) inz
     D pStartPos       S                   like(#StartPos)
     D                                     inz
     D                 DS
     D pFldInhaltSbcs                      like(r§rcdBuf    ) inz
     D pFldInhaltUcs2                      like(r§rcdBufUcs2) inz
     D                                     overlay(pFldInhaltSbcs)
     D pLength         S                   like(r§int4    ) inz
     D pTmpNewLen      S                   like(r§int4    ) inz
     D pTmpHexLen      S                   like(r§int4    ) inz
     D pTmpHexBin      S                   like(#HexString)
     D                                     inz
     D pHexStrLen      S                   like(r§int4    ) inz
      *
     D warning_1       S                   like(r§bool    )
     D                                     inz(bFalse)
     D warning_2       S                   like(r§bool    )
     D                                     inz(bFalse)
     D pgmError        S                   like(r§bool    )
     D                                     inz(bFalse)
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
     IBILD01
     I              $OFS1                       $OfsVal( 1)
     I              $OFS2                       $OfsVal( 2)
     I              $OFS3                       $OfsVal( 3)
     I              $OFS4                       $OfsVal( 4)
     I              $OFS5                       $OfsVal( 5)
     I              $OFS6                       $OfsVal( 6)
     I              $OFS7                       $OfsVal( 7)
     I              $OFS8                       $OfsVal( 8)
      *
     I              #HEX11                      #HexVal( 1)
     I              #HEX12                      #HexVal( 2)
     I              #HEX13                      #HexVal( 3)
     I              #HEX14                      #HexVal( 4)
      *
     I              #HEX21                      #HexVal( 5)
     I              #HEX22                      #HexVal( 6)
     I              #HEX23                      #HexVal( 7)
     I              #HEX24                      #HexVal( 8)
      *
     I              #HEX31                      #HexVal( 9)
     I              #HEX32                      #HexVal(10)
     I              #HEX33                      #HexVal(11)
     I              #HEX34                      #HexVal(12)
      *
     I              #HEX41                      #HexVal(13)
     I              #HEX42                      #HexVal(14)
     I              #HEX43                      #HexVal(15)
     I              #HEX44                      #HexVal(16)
      *
     I              #HEX51                      #HexVal(17)
     I              #HEX52                      #HexVal(18)
     I              #HEX53                      #HexVal(19)
     I              #HEX54                      #HexVal(20)
      *
     I              #HEX61                      #HexVal(21)
     I              #HEX62                      #HexVal(22)
     I              #HEX63                      #HexVal(23)
     I              #HEX64                      #HexVal(24)
      *
     I              #HEX71                      #HexVal(25)
     I              #HEX72                      #HexVal(26)
     I              #HEX73                      #HexVal(27)
     I              #HEX74                      #HexVal(28)
      *
     I              #HEX81                      #HexVal(29)
     I              #HEX82                      #HexVal(30)
     I              #HEX83                      #HexVal(31)
     I              #HEX84                      #HexVal(32)
      *
     I              $STR1                       $StrVal( 1)
     I              $STR2                       $StrVal( 2)
     I              $STR3                       $StrVal( 3)
     I              $STR4                       $StrVal( 4)
     I              $STR5                       $StrVal( 5)
     I              $STR6                       $StrVal( 6)
     I              $STR7                       $StrVal( 7)
     I              $STR8                       $StrVal( 8)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     C     *entry        Plist
     C                   Parm                    xDsp80
     C                   Parm                    xHeadTyp
     C                   Parm                    xCopyRght
     C                   Parm                    xFldName
     C                   Parm                    xFldInhalt
     C                   Parm                    xLength
     C                   Parm                    xProtect
     C                   Parm                    xIsUcs2
     C                   Parm                    xMsgID
     C                   Parm                    xMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK23
     C     P_Peek23      Plist
     C                   Parm                    yPgm
     C                   Parm                    yKey
     C                   Parm                    yPosF24
     C                   Parm                    yFKeys
     C                   Parm                    yNbrOfKeys
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK21
     C     P_Peek21      Plist
     C                   Parm                    yScnAID
     C                   Parm                    yPgm
     C                   Parm                    yPgmCmd
     C                   Parm                    yCmdDta
     C                   Parm                    yMsgID
     C                   PARM                    yMsgDta
      *
     C     P_PEEK32      Plist
     C                   Parm                    yBuffer
     C                   Parm                    yBuffLen
     C                   Parm                    yCcsid
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLD
     C     F_KEY         Klist
     C                   Kfld                    F_Field
      *
      *---------------------------------------------------*
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
     C                   Exfmt     BILD01
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
     C                   Eval      yScnAID = §ScnAID
     C                   Eval      yPgm    = §§PgmName
     C                   Call      PEEK21        P_Peek21
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
     C                   Eval      xMsgID  = 'USR8112'
     C                   Eval      xMsgDta = ' '
     C                   If        (FLDL0100.F1DTYP = 'G')
     C                   Eval      xFldInhaltUcs2 = pFldInhaltUcs2
     C                   Eval      xLength        = pLength
     C                   Else
     C                   Eval      xFldInhaltSbcs = pFldInhaltSbcs
     C                   Eval      xLength        = pLength
     C                   Endif
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
     C                   If        FLDL0100.F1DTYP = 'G'
     C                   Eval      pLength = %len(%trimR(pFldInhaltUcs2))
     C                   Else
     C                   Eval      pLength = %len(%trimR(pFldInhaltSbcs))
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
     C                   If        (FLDL0100.F1DTYP = 'G')
     C                   Eval      #HexString = %trimr(#HexString) + '0020'
     C                   Else
     C                   Eval      #HexString = %trimr(#HexString) + '40'
     C                   Endif
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
     C                   Eval      XMsgID = 'USR8100'
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
     C                   Eval      XMsgDta = USR8100
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
     C                   Eval      $FldName = f_headline(xHeadTyp: FLDL0100)
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
     C                   Eval      yCcsid     = 0
     C                   Call      PEEK32        P_PEEK32
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
     C                   If        XDsp80 = *off
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
     C                   Eval      SET0006 = f_getUsrSg('*CVTCHR'   )
      *
     C                   Endsr
      *
      *============================================================*
      *    GetParameters Laden der *ENTRY Parameterwerte           *
      *============================================================*
      *
     C     GetParameters Begsr
      *
     C                   Eval      pXFldInhalt = %addr(xFldInhalt)
      *
     C                   If        (FLDL0100.F1DTYP = 'G')
     C                   Clear                   pFldInhaltUcs2
     C                   Eval      %subst(pFldInhaltUcs2: 1: xLength) =
     C                                    xFldInhaltUcs2
     C                   Else
     C                   Clear                   pFldInhaltSbcs
     C                   Eval      %subst(pFldInhaltSbcs: 1: xLength) =
     C                                    xFldInhaltSbcs
     C                   Endif
      *
     C                   Eval      pLength = xLength
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
     C                   Eval      F_FIELD = xFldName
     C     F_KEY         Chain     FPEEKFLD                           11
     C                   If        *in11 <> bFound
     C                   Eval      isPgmError = bTrue
     C                   Clear                   FLDL0100
     C                   Clear                   USR8136
     C                   Eval      §msgID     = 'USR8136'
     C                   Eval      USR81361   = xFldName
     C                   Eval      §MsgDta    = USR8136
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Else
     C                   Eval      isPgmError = bFalse
     C                   Eval      FLDL0100   = F_FFD
     C                   Endif
      *
      * - Übernehmen der *ENTRY Parameter
     C                   Eval      pStartPos  = 1
     C                   Exsr      GetParameters
      *
     C                   If        (isPgmError = bTrue)
     C                   Eval      *in70 = '1'
     C                   Else
     C                   Eval      *in70 = xProtect
     C                   Endif
      *
     C                   Eval      xMsgID  = ''
     C                   Eval      xMsgDta = ''
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
     C                   Eval      §msgDta = xCopyRght
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
     C                   Endsr
      *
      *============================================================*
      *    *inzsr        Programminitialisierung                   *
      *============================================================*
      *
     C     *inzsr        Begsr
      *
     C                   Eval      §PgmQ = '*'
      *
     C                   Eval      PEEK21 = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23 = f_pgmCallN('PEEK23')
     C                   Eval      PEEK32 = f_pgmCallN('PEEK32')
      *
     C                   Eval      yPgm    = §§PgmName
     C                   Eval      yKey    = '*ALL'
      ***                Eval      yPosF24 = §NbrFKeys
     C                   Eval      yPosF24 = 0
     C                   Call      PEEK23        P_Peek23
     C                   Eval      ScrnFKeys = %subarr(YFKeys: 1)
      *
     C                   Endsr
      *
      *============================================================*
      *    *pssr         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *pssr         Begsr
      *
     C                   Dump
      *
     C                   Endsr     '*CANCL'
      *
