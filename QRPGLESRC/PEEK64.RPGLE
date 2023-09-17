      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 3.0.0                               *
      *  Programm : PEEK64                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 26.04.2007                                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Feldeditor                                        *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEK64FM  CF   E             workstn usropn
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
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8123
      /COPY QCOPYLE,USR8136
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
      *---API-Formate--------------------------------------*
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  I N F D S - D E F I N I T I O N E N               *
      *----------------------------------------------------*
      *
     D peek_01_DS      DS                  likeds(r§infds)
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
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D sfBot           S                   like(r§int4    ) inz
     D §nbrFKeys       C                   const(3)
      *
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
      *
      * Arbeitsfelder
     D isPgmError      S                   like(r§bool    ) inz(bFalse)
     D isDataChg       S                   like(r§bool    ) inz(bFalse)
     D                 DS
     D pFldInhaltSbcs                      like(r§rcdBuf    ) inz
     D pFldInhaltUcs2                      like(r§rcdBufUcs2) inz
     D                                     overlay(pFldInhaltSbcs)

     D pLength         S                   like(r§int4        ) INZ
     D x               S                   LIKE(r§int4        ) INZ
     D len             S                   LIKE(r§int4        ) INZ
     D rem             S                   LIKE(r§int4        ) INZ
     D offs            S                   LIKE(r§int4        ) INZ
     D pUcs2Fld        S               *   inz
     D isFieldTooLarge...
     D                 S               N
     D maxFieldLength  S             10I 0
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK71
      *
      *  memcpy -- Copy Bytes
      *     The behavior is undefined if copying takes place
      *     between objects that overlap.
      *     The memcpy() function returns a pointer to dest.
     D memcpy          PR              *          extproc('memcpy')
     D  i_pDest                        *   value
     D  i_pSrc                         *   value
     D  i_count                      10U 0 value
      *
     D                 DS
     D  #UCS2STR               1   2048C
     D  #UCS2                  1   2048C   CCSID(13488) DIM(16)
      *
     IBILD01
     I              #UCS2_1                     #UCS2( 1)
     I              #UCS2_2                     #UCS2( 2)
     I              #UCS2_3                     #UCS2( 3)
     I              #UCS2_4                     #UCS2( 4)
     I              #UCS2_5                     #UCS2( 5)
     I              #UCS2_6                     #UCS2( 6)
     I              #UCS2_7                     #UCS2( 7)
     I              #UCS2_8                     #UCS2( 8)
     I              #UCS2_9                     #UCS2( 9)
     I              #UCS2_10                    #UCS2(10)
     I              #UCS2_11                    #UCS2(11)
     I              #UCS2_12                    #UCS2(12)
     I              #UCS2_13                    #UCS2(13)
     I              #UCS2_14                    #UCS2(14)
     I              #UCS2_15                    #UCS2(15)
     I              #UCS2_16                    #UCS2(16)
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
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLD
     C     F_KEY         Klist
     C                   Kfld                    F_Field
      *
      *---------------------------------------------------*
      *
     C                   Exsr      First
     C                   If        (isPgmError = bTrue)
     C                   Goto      ende
     C                   EndIf
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
     C                   When      YPgmCmd = '*EXIT' or YPgmCmd = '*NO'
     C                   Exsr      c_endPgm
     C                   Leave
      *
      *  F5  - Aktualisieren
     C                   When      YPgmCmd = '*REFRESH'
     C                   Exsr      c_refresh
     C                   Iter
      *
      *  F12 - Ende
     C                   When      YPgmCmd = '*CANCEL'
     C                   Exsr      c_endPgm
     C                   Leave
      *
      *  F24 - Weitere Tasten
     C                   When      YPgmCmd = '*MOREKEYS'
     C                   Exsr      c_moreKeys
      *
      *  Datenfreigabe
     C                   When      YPgmCmd = '*ENTER' or YPgmCmd = '*OK'
     C                   Exsr      c_enter
     C                   If        isPgmError = bFalse
     C                   Eval      xMsgID  = 'USR8112'
     C                   Eval      xMsgDta = ' '
      *
     C                   if        (xIsUcs2 = 0)
     C                   Eval      xFldInhaltSbcs = pFldInhaltSbcs
     C                   else
     C                   Eval      xFldInhaltUcs2 = pFldInhaltUcs2
     C                   endif
      *
     C                   Eval      xLength = pLength
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
     C                   Close     PEEK64FM
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
     C                   If        isDataChg = bTrue
      *
      *  ... einsetzen in Zwischenfeld für Rückgabewert
     C                   If        (xIsUcs2 = 0)
      *
     C                   If        (isFieldTooLarge)
     C                   Eval      pLength = xLength
     C                   Else
     C                   Eval      pLength = %len(%trimR(#STRING))
     C                   Endif
      *
     C                   Eval      %subst(pFldInhaltSbcs: 1: %len(#String)) =
     C                               #String
      *
     C                   Else
      *
     C                   If        (isFieldTooLarge)
     C                   Eval      pLength = xLength
     C                   Else
     C                   Eval      pLength = %len(%trimR(#UCS2STR))
     C                   Endif
      *
     C                   Eval      %subst(pFldInhaltUcs2: 1: %len(#UCS2STR)) =
     C                               #UCS2STR
      *
     C**                 Eval      len = %len(%trimR(#UCS2STR)) * 2
     C**                 Callp     memcpy(
     C**                             %addr(pFldInhalt): %addr(#UCS2STR): len)
      *
     C                   Endif
      *
    R ***                Eval      isPgmError = bTrue
     C                   Endif
     C                   Endif
      *
     C                   Endif                                                  IsPgmError
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
     C                   Eval      *in20 = *off                                 #STRING/#UCS2
      *
      *  DSPATR(RI)
     C                   Eval      *in30 = *off                                 #STRING/#UCS2
      *
      *  Fehler
     C                   Eval      isPgmError = bFalse
      *
     C                   Endsr
      *
      *============================================================*
      *    prfb1         Prüfen der Eingaben                       *
      *============================================================*
      *
     C     prfb1         Begsr
      *
      *  Länge und der Zeichenkette
     C                   Exsr      prf20
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
     C                   If        (xIsUcs2 = 0)
     C                   Eval      len = %len(%trimr(#String))
     C                   Else
     C                   Eval      len = %len(%trimr(#UCS2STR))
     C**                 Eval      len = 0
     C**                 For       x = %elem(#UCS2) downto 1
     C**                 If        %trimr(%trim(#UCS2(x))) <> ''
     C**                 Eval      len = ((x-1) * %len(#UCS2(x))) +
     C**                                 %len(%trimr(#UCS2(x)))
     C**                 Leave
     C**                 Endif
     C**                 Endfor
     C                   Endif
      *
      *  Zeichenkette zu lang
     C                   If        len > f_dsplyLn(FLDL0100)
     C                   Eval      §MsgID  = 'USR8176'
     C                   Eval      §MsgDta = ' '
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Eval      isPgmError = bTrue
     C                   Endif
      *
     C     ePrf20        Tag
      *
     C                   If        isPgmError = bTrue
     C                   Eval      *IN20 = *on
     C                   Eval      *IN30 = *on
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
     C                   Endsr
      *
      *============================================================*
      *    c_refresh     F5  - Aktualisieren der Subfile           *
      *============================================================*
      *
     C     c_refresh     BEGSR
      *
     C                   if        (xIsUcs2 = 0)
     C                   Eval      pFldInhaltSbcs = xFldInhaltSbcs
     C                   else
     C                   Eval      pFldInhaltUcs2 = xFldInhaltUcs2
     C                   endif
      *
     C                   Eval      pLength = xLength
      *
     C                   EXSR      bzoff1
     C                   EXSR      fill##
      *
     C                   ENDSR
      *
      *============================================================*
      *    c_moreKeys    F24 - Weitere Tasten                      *
      *============================================================*
      *
     C     c_moreKeys    BEGSR
      *
     C                   ADD       1             SFBOT
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
    R ***                Eval      $FldName = f_headline(xHeadTyp: FLDL0100)
      *
      *  anzeigen Feldinhalt
     C                   If        (xIsUcs2 = 0)
      *
     C                   Eval      #STRING = pFldInhaltSbcs
     C                   Eval      *IN71 = '0'
      *
     C                   Else
      *
     C                   Eval      #UCS2STR = pFldInhaltUcs2
     C                   Eval      *IN71 = '1'
      *
     C**                 If        (xLength <= %size(#UCS2) * %elem(#UCS2))
     C**                 Eval      len = xLength * 2
     C**                 Else
     C**                 Eval      len = %size(#UCS2) * %elem(#UCS2)
     C**                 Endif
      *
     C**                 Clear                   #UCS2
     C**                 Callp     memcpy(%addr(#UCS2): %addr(pFldInhalt): len)
     C**                 Eval      *IN71 = '1'
      *
     C                   Endif
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
     C                   Eval      zei = 2
     C                   Eval      pos = 4
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    GetParameters Laden der *ENTRY Parameterwerte           *
      *============================================================*
      *
     C     GetParameters begsr
      *
     C                   eval      pXFldInhalt = %addr(xFldInhalt)
      *
     C                   if        (xIsUcs2 = 0)
     C                   clear                   pFldInhaltSbcs
     C                   eval      %subst(pFldInhaltSbcs: 1: xLength) =
     C                                    xFldInhaltSbcs
     C                   eval      maxFieldLength = %len(#STRING)
     C                   else
     C                   clear                   pFldInhaltUcs2
     C                   eval      %subst(pFldInhaltUcs2: 1: xLength) =
     C                                    xFldInhaltUcs2
     C                   eval      maxFieldLength = %len(#UCS2STR)
     C                   endif
      *
     C                   eval      pLength = xLength
      *
     C                   endsr
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
     C                   Open      PEEK64FM
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  ermitteln der Feldeigenschaften
     C                   Eval      F_FIELD = xFldName
     C     F_KEY         Chain     FPEEKFLD                           11
     C                   If        *in11 <> bFound
     C                   Eval      isPgmError = bTrue
     C                   Clear                   FLDL0100
     C                   Clear                   USR8136
     C                   Eval      §msgID     = 'USR8136'
     C                   Eval      USR81361   = xFldName
     C                   Eval      §MsgDta    = USR8136
     C                   Else
     C                   Eval      isPgmError = bFalse
     C                   Eval      FLDL0100   = F_FFD
     C                   Endif
      *
     C                   if        (isPgmError = bTrue)
     C                   leavesr
     C                   endif
      *
      * - Übernehmen der *ENTRY Parameter
     C                   exsr      GetParameters
      *
     C                   eval      xMsgID  = ' '
     C                   eval      xMsgDta = ' '
      *
     C                   if        (pLength > maxFieldLength)
     C                   eval      isFieldTooLarge = bTrue
     C                   eval      *in70 = bTrue
     C                   else
     C                   eval      isFieldTooLarge = bFalse
     C                   eval      *in70 = xProtect
     C                   endif
      *
      * - Feld zu groß Hinweis ausgeben
     C                   MOVEL (P) 'USR8123'     §MsgID
     C                   MOVEL (P) §White_U      USR81231
     C                   MOVEL (P) §White        USR81232
     C                   MOVEL (P) USR8123       §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
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
      *
     C                   Eval      yPgm    = §§PgmName
     C                   Eval      yKey    = '*ALL'
      ***                Eval      yPosF24 = §NbrFKeys
     C                   Eval      yPosF24 = 0
     C                   Call      PEEK23        P_Peek23
     C                   Movea (P) YFKeys        ScrnFKeys
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
