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
     FPEEK64FM  CF   E             workstn usropn
     F                                     infds(workstn)
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
      /COPY QCOPYLE,PPEEK64
      /undefine internal_prototype
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
     D peek_01_DS      DS                  likeds(infds_t)
      *
     D*                DS                  based(pXFldInhalt)
     D*xFldInhaltSbcs                      like(rcdBuf_t)
     D*xFldInhaltUcs2                      like(rcdBufUcs2_t)
     D*                                    overlay(xFldInhaltSbcs)
      *
     D yPgmCmd         S                   like(pgmCmd_t)
     D yCmdDta         S                   like(pgmCmdDt_t)
     D yMsgID          S                   like(msgID_t)
     D yMsgDta         S                   like(msgDta_t)
      *
     D yFKeys          S                   like(fKeyDsp_t) dim(32)
     D yNbrOfKeys      S                   like(int4_t) inz
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D sfBot           S                   like(int4_t)
     D §nbrFKeys       C                   const(3)
      *
     D PEEK21_NAME     S                   like(pgmCallN_t)
     D PEEK23_NAME     S                   like(pgmCallN_t)
      *
      * Arbeitsfelder
     D isPgmError      S                   like(bool_t) inz(bFalse)
     D isDataChg       S                   like(bool_t) inz(bFalse)
     D                 DS
     D pFldInhaltSbcs                      like(rcdBuf_t) inz
     D pFldInhaltUcs2                      like(rcdBufUcs2_t) inz
     D                                     overlay(pFldInhaltSbcs)
     D pLength         S                   like(int4_t)
     D len             S                   like(int4_t)
     D isFieldTooLarge...
     D                 S               N
     D maxFieldLength  S             10I 0
      *
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK71
      *
     D                 DS
     D  #UCS2STR               1   2048C
     D  #UCS2                  1   2048C   CCSID(13488) DIM(16)
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK64          PI
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
     C                   If        (isPgmError = bTrue)
     C                   Goto      ende
     C                   EndIf
      *
      *---------------------------------------------------*
      *  Schleife für Programmbearbeitung
      *
     C                   Do        *hival
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
      *  Übernehmen Bildschirmfelder in Programmfelder
     C                   Exsr      fillPgmFlds
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
     C                   CALLP     PEEK21(workstn.aid: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C                   If        YMsgID <> ' '
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   Eval      YMsgID = ''
     C                   Eval      YMsgDta = ''
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
     C                   Callp     p_wrongKey(workstn.aid: §§pgmName)
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
     C                   If        (i_isUcs2 = 0)
      *
     C                   If        (isFieldTooLarge)
     C                   Eval      pLength = io_length
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
     C                   Eval      pLength = io_length
     C                   Else
     C                   Eval      pLength = %len(%trimR(#UCS2STR))
     C                   Endif
      *
     C                   Eval      %subst(pFldInhaltUcs2: 1: %len(#UCS2STR)) =
     C                               #UCS2STR
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
     C                   If        (i_isUcs2 = 0)
     C                   Eval      len = %len(%trimr(#String))
     C                   Else
     C                   Eval      len = %len(%trimr(#UCS2STR))
     C                   Endif
      *
      *  Zeichenkette zu lang
     C                   If        len > f_dsplyLn(FLDL0100)
     C                   Callp     p_sndPgmMg('USR8176': '': §§pgmName)
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
      *    c_endPgm      F3/F12 - Programm beenden                 *
      *============================================================*
      *
     C     c_endPgm      BEGSR
      *
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      o_msgID = 'USR8100'
      *
     C                   SELECT
     C     workstn.aid   WHENEQ    K_F3
     C                   EVAL      USR81001 = 'F3'
     C     workstn.aid   WHENEQ    K_F12
     C                   EVAL      USR81001 = 'F12'
     C                   OTHER
     C                   EVAL      USR81001 = 'Fxx'
     C                   Endsl
      *
     C                   EVAL      o_msgDta = USR8100
      *
     C                   Endsr
      *
      *============================================================*
      *    c_refresh     F5  - Aktualisieren der Subfile           *
      *============================================================*
      *
     C     c_refresh     BEGSR
      *
     C                   Exsr      GetParameters
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
     C                   EVAL      SFBOT = SFBOT + 1
      *
     C                   ENDSR
      *
      *============================================================*
      *    fill##        Füllen Bildschirm                         *
      *============================================================*
      *
     C     fill##        Begsr
      *
      *  anzeigen Feldinhalt
     C                   If        (i_isUcs2 = 0)
      *
     C                   Eval      #STRING = pFldInhaltSbcs
     C                   Eval      *IN71 = '0'
      *
     C                   Else
      *
     C                   Eval      #UCS2STR = pFldInhaltUcs2
      *
     C                   Eval      #UCS2_1 = #UCS2(1)
     C                   Eval      #UCS2_2 = #UCS2(2)
     C                   Eval      #UCS2_3 = #UCS2(3)
     C                   Eval      #UCS2_4 = #UCS2(4)
     C                   Eval      #UCS2_5 = #UCS2(5)
     C                   Eval      #UCS2_6 = #UCS2(6)
     C                   Eval      #UCS2_7 = #UCS2(7)
     C                   Eval      #UCS2_8 = #UCS2(8)
     C                   Eval      #UCS2_9 = #UCS2(9)
     C                   Eval      #UCS2_10 = #UCS2(10)
     C                   Eval      #UCS2_11 = #UCS2(11)
     C                   Eval      #UCS2_12 = #UCS2(12)
     C                   Eval      #UCS2_13 = #UCS2(13)
     C                   Eval      #UCS2_14 = #UCS2(14)
     C                   Eval      #UCS2_15 = #UCS2(15)
     C                   Eval      #UCS2_16 = #UCS2(16)
      *
     C                   Eval      *IN71 = '1'
      *
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    fillPgmFlds   Füllen Programmfelder                     *
      *============================================================*
      *
     C     fillPgmFlds   Begsr
      *
     C                   If        (i_isUcs2 = 0)
      *
      *    Nothing to do here
      *
     C                   Else
      *
     C                   Eval      #UCS2(1) = #UCS2_1
     C                   Eval      #UCS2(2) = #UCS2_2
     C                   Eval      #UCS2(3) = #UCS2_3
     C                   Eval      #UCS2(4) = #UCS2_4
     C                   Eval      #UCS2(5) = #UCS2_5
     C                   Eval      #UCS2(6) = #UCS2_6
     C                   Eval      #UCS2(7) = #UCS2_7
     C                   Eval      #UCS2(8) = #UCS2_8
     C                   Eval      #UCS2(9) = #UCS2_9
     C                   Eval      #UCS2(10) = #UCS2_10
     C                   Eval      #UCS2(11) = #UCS2_11
     C                   Eval      #UCS2(12) = #UCS2_12
     C                   Eval      #UCS2(13) = #UCS2_13
     C                   Eval      #UCS2(14) = #UCS2_14
     C                   Eval      #UCS2(15) = #UCS2_15
     C                   Eval      #UCS2(16) = #UCS2_16
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
     C                   If        i_dsp80 = *off
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
      *    GetParameters Laden der Programmparameter               *
      *============================================================*
      *
     C     GetParameters begsr
      *
     C                   if        (i_isUcs2 = 0)
     C                   clear                   pFldInhaltSbcs
     C                   Eval      %subst(pFldInhaltSbcs: 1: io_length) =
     C                                    io_fldInhalt.sbcs
     C                   eval      maxFieldLength = %len(#STRING)
     C                   else
     C                   clear                   pFldInhaltUcs2
     C                   Eval      %subst(pFldInhaltUcs2: 1: io_length) =
     C                                    io_fldInhalt.ucs2
     C                   eval      maxFieldLength = %len(#UCS2STR)
     C                   endif
      *
     C                   eval      pLength = io_length
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
     C                   Eval      F_FIELD = i_fldName
     C     F_KEY         Chain     FPEEKFLD                           11
     C                   If        *in11 <> bFound
     C                   Eval      isPgmError = bTrue
     C                   Clear                   FLDL0100
     C                   Clear                   USR8136
     C                   Eval      USR81361   = i_fldName
     C                   Callp     p_sndPgmMg('USR8136': USR8136: §§pgmName)
     C                   Else
     C                   Eval      isPgmError = bFalse
     C                   Eval      FLDL0100   = F_FFD
     C                   Endif
      *
     C                   if        (isPgmError = bTrue)
     C                   leavesr
     C                   endif
      *
      * - Übernehmen der Programmparameter
     C                   exsr      GetParameters
      *
     C                   eval      o_msgID  = ' '
     C                   eval      o_msgDta = ' '
      *
     C                   if        (pLength > maxFieldLength)
     C                   eval      isFieldTooLarge = bTrue
     C                   eval      *in70 = bTrue
     C                   else
     C                   eval      isFieldTooLarge = bFalse
     C                   eval      *in70 = i_protect
     C                   endif
      *
      * - Feld zu groß Hinweis ausgeben
     C                   CLEAR                   USR8123
     C                   EVAL      USR81231 = §White_U
     C                   EVAL      USR81232 = §White
     C                   Callp     p_sndPgmMg('USR8123': USR8123: §§pgmName)
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
     C                   Callp     p_sndPgmMg('USR9999': i_copyright: §§pgmName)
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
