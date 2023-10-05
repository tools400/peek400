      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK52                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 20.01.99  Raddatz                                 *
      *  geändert : 27.04.99  2.1.0                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Abfrage "Programm erstellen"                      *
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
     FPEEK52FM  CF   E             WORKSTN USROPN
     F                                     INFDS(workstn)
      *
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
      *----------------------------------------------------*
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK52
      /undefine internal_prototype
      *
      *---Variablendefinition ShortCmd---------------------*
      /COPY QCOPYLE,ShortCmd_D
      *----------------------------------------------------*
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0012
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8216
      /COPY QCOPYLE,USR8219
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
     D yFKeys          S             18A   dim(32) inz
     D yNbrOfKeys      S                   like(int4_t) inz
     D yMsgID          S              7A   inz
     D yMsgDta         S            512A   inz
     D YPgmCmd         S             10A   inz
     D YCmdDta         S                   like(pgmCmdDt_t) inz
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D SfBot           S                   like(int4_t) inz
     D NbrFKeys        C                   CONST(2)
      *
     D PEEK21_NAME     S                   like(pgmCallN_t) inz
     D PEEK23_NAME     S                   like(pgmCallN_t) inz
      *
     D doGenerate      S               N   inz(bFalse)
      *
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D set0012         ds                  likeds(set0012_t) inz
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK52          PI
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  o_alwLc                                  like(bool_t)
     D  o_case                                   like(bool_t)
     D  o_cdLock                                 like(bool_t)
     D  o_nullDft                                like(bool_t)
     D  o_keepCrs                                like(bool_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
     D  i_isUnload                         const like(msgID_t)
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
      *
     C                   IF        i_isUnload = bTrue
     C                   CLOSE     PEEK52FM
     C                   EVAL      *INLR = *ON
     C                   GOTO      ENDE
     C                   ENDIF
      *
     C                   EXSR      FIRST
      *
      *---------------------------------------------------*
      *  Schleife für Programmbearbeitung
      *
     C                   DO        *HIVAL
      *
      *  Nachrichten anzeigen
     C                   EVAL      *IN89 = '0'
     C                   WRITE     MSGCTL
      *
      *  Anzeigen der Befehlstasten
     C                   EVAL      doGenerate = bFalse
     C                   EXSR      dspCmdKeys
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
     C                   CALLP     PEEK21(workstn.aid: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C     YMsgID        IFNE      *BLANKS
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   EVAL      YMsgID = ''
     C                   EVAL      YMsgDta = ''
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
     C                   EVAL      o_msgID = 'USR8112'
     C                   EVAL      o_msgDta = *BLANKS
      *
     C                   WRITE     MSGCTL2
     C                   EVAL      doGenerate = bTrue
     C                   EXSR      dspCmdKeys
     C                   WRITE     BILD02
      *
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
      *  Ende der Hauptschleife
      *---------------------------------------------------*
      *
      *  Programm verlassen
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *============================================================*
      *    dspCmdKeys    Anzeigen der Befehlstasten                *
      *============================================================*
      *
     C     dspCmdKeys    BEGSR
      *
     C                   if        (doGenerate)
     C                   eval      SFBOT = 1
     C                   endif
      *
     C                   SELECT
     C                   When      (SFBOT = 2) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#2                                      BT-Tasten 2
     C                   When      (SFBOT = 3) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#3                                      BT-Tasten 3
     C                   When      (SFBOT = 4) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#4                                      BT-Tasten 4
     C                   When      (SFBOT = 5) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#5                                      BT-Tasten 5
     C                   When      (SFBOT = 6) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#6                                      BT-Tasten 6
     C                   When      (SFBOT = 7) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#7                                      BT-Tasten 7
     C                   When      (SFBOT = 8) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#8                                      BT-Tasten 8
     C                   When      (SFBOT = 9) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#9                                      BT-Tasten 4
     C                   When      (SFBOT = 10) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#10                                     BT-Tasten 10
     C                   When      (SFBOT = 11) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#11                                     BT-Tasten 11
     C                   When      (SFBOT = 12) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#12                                     BT-Tasten 12
     C                   OTHER
     C                   If        (not doGenerate)
     C                   WRITE     PBBOT#1                                      BT-Tasten 1
     C                   Else
     C                   WRITE     PBBOT2#1                                     BT-Tasten 1
     C                   Endif
     C                   EVAL      SFBOT = 1
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Enter       "Datenfreigabetaste"                      *
      *============================================================*
      *
     C     C_Enter       BEGSR
      *
     C                   EXSR      PRFB1
      *
     C     E_Enter       TAG
      *
     C     *IN99         IFEQ      '0'
     C                   EVAL      o_alwLc = ##ALWLC
     C                   EVAL      o_case = ##CASE
     C                   EVAL      o_cdLock = ##RCDLCK
     C                   EVAL      o_nullDft = ##NULLDFT
     C                   EVAL      o_keepCrs = ##KEEPCRS
     C                   IF        ##SAVE = bTrue
     C                   EXSR      SavUsrSetg
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRFB1         Prüfen der Eingaben                       *
      *============================================================*
      *
     C     PRFB1         BEGSR
      *
     C                   EXSR      PRF22                                       ##ALWLC
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF20                                       ##CASE
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF24                                       CASE/ALWLC
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF23                                       ##RCDLCK
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF25                                       ##NULLDFT
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF26                                       ##KEEPCRS
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF21                                       ##SAVE
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C     EPRFB1        ENDSR
      *
      *============================================================*
      *    PRF22         Prüfen:  alwlc                            *
      *============================================================*
      *
     C     PRF22         BEGSR
      *
     C     ##ALWLC       IFNE      bTrue
     C     ##ALWLC       ANDNE     bFalse
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8219
     C                   EVAL      USR82191 = ##ALWLC
     C                   Callp     p_sndPgmMg('USR8219': USR8219: §§pgmName)
     C                   GOTO      EPRF22
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
      *    PRF20         Prüfen:  case-sensitive                   *
      *============================================================*
      *
     C     PRF20         BEGSR
      *
     C     ##CASE        IFNE      bTrue
     C     ##CASE        ANDNE     bFalse
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8219
     C                   EVAL      USR82191 = ##CASE
     C                   Callp     p_sndPgmMg('USR8219': USR8219: §§pgmName)
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
      *    PRF23         Prüfen:  Satz gesperrt einlesen           *
      *============================================================*
      *
     C     PRF23         BEGSR
      *
     C     ##RCDLCK      IFNE      bTrue
     C     ##RCDLCK      ANDNE     bFalse
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8219
     C                   EVAL      USR82191 = ##RCDLCK
     C                   Callp     p_sndPgmMg('USR8219': USR8219: §§pgmName)
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
      *    PRF24         Prüfen:  case-sensitive                   *
      *============================================================*
      *
     C     PRF24         BEGSR
      *
     C                   IF        (##ALWLC = bFalse) and
     C                             (##CASE  = bTrue )
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8216
     C                   Callp     p_sndPgmMg('USR8216': USR8216: §§pgmName)
     C                   GOTO      EPRF24
     C                   Endif
      *
     C     EPRF24        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN20 = '1'
     C                   EVAL      *IN30 = '1'
     C                   EVAL      *IN22 = '1'
     C                   EVAL      *IN32 = '1'
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF25         Prüfen:  nullDft                          *
      *============================================================*
      *
     C     PRF25         BEGSR
      *
     C     ##NULLDFT     IFNE      bTrue
     C     ##NULLDFT     ANDNE     bFalse
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8219
     C                   EVAL      USR82191 = ##NULLDFT
     C                   Callp     p_sndPgmMg('USR8219': USR8219: §§pgmName)
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
      *    PRF26         Prüfen:  keepCrs                          *
      *============================================================*
      *
     C     PRF26         BEGSR
      *
     C     ##KEEPCRS     IFNE      bTrue
     C     ##KEEPCRS     ANDNE     bFalse
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8219
     C                   EVAL      USR82191 = ##KEEPCRS
     C                   Callp     p_sndPgmMg('USR8219': USR8219: §§pgmName)
     C                   GOTO      EPRF26
     C                   Endif
      *
     C     EPRF26        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN26 = '1'
     C                   EVAL      *IN36 = '1'
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF21         Prüfen:  save                             *
      *============================================================*
      *
     C     PRF21         BEGSR
      *
     C     ##SAVE        IFNE      bTrue
     C     ##SAVE        ANDNE     bFalse
     C                   EVAL      *IN99 = '1'
     C                   CLEAR                   USR8219
     C                   EVAL      USR82191 = ##SAVE
     C                   Callp     p_sndPgmMg('USR8219': USR8219: §§pgmName)
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
      *    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
      *============================================================*
      *
     C     BZOFF1        BEGSR
      *
      *  DSPATR(PC)
     C                   EVAL      *IN20 = '0'                                  ##CASE
     C                   EVAL      *IN21 = '0'                                  ##SAVE
     C                   EVAL      *IN22 = '0'                                  ##ALWLC
     C                   EVAL      *IN23 = '0'                                  ##RCDLCK
     C                   EVAL      *IN25 = '0'                                  ##NULLDFT
     C                   EVAL      *IN26 = '0'                                  ##KEEPCRS
      *
      *  DSPATR(RI)
     C                   EVAL      *IN30 = '0'                                  ##CASE
     C                   EVAL      *IN31 = '0'                                  ##SAVE
     C                   EVAL      *IN32 = '0'                                  ##ALWLC
     C                   EVAL      *IN33 = '0'                                  ##RCDLCK
     C                   EVAL      *IN35 = '0'                                  ##NULLDFT
     C                   EVAL      *IN36 = '0'                                  ##KEEPCRS
      *
      *  Fehler
     C                   EVAL      *IN99 = '0'
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
     C                   ENDSR
      *
      *============================================================*
      *    C_Refresh     F5  - Aktualisieren der Subfile           *
      *============================================================*
      *
     C     C_Refresh     BEGSR
      *
     C                   EXSR      BZOFF1
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
     C                   Eval      ##ALWLC   = set0012.SET_ALWLC
     C                   Eval      ##CASE    = set0012.SET_CASE
     C                   Eval      ##RCDLCK  = set0012.SET_RCD_LOCK
     C                   Eval      ##NULLDFT = set0012.SET_NULL_DFT
     C                   Eval      ##KEEPCRS = set0012.SET_KEEP_CRS
     C                   Eval      ##SAVE    = bFalse
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
     C                   EVAL      ZEI = 1
     C                   EVAL      POS = 40
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   EVAL      *IN88 = '1'
     C                   EVAL      ZEI = 4
     C                   EVAL      ZEI = 3
     C                   EVAL      POS = 7
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
      *  *CRTPGM
     C                   Eval      SET0012 = f_getUsrSg('*CRTPGM'   )
      *
     C                   ENDSR
      *
      *============================================================*
      *    SavUsrSetg    Sichern der Benutzervoreinstellungen      *
      *============================================================*
      *
     C     SavUsrSetg    BEGSR
      *
      *  *CRTPGM
     C                   EVAL      set0012.SET_CASE = ##CASE
     C                   EVAL      set0012.SET_RCD_LOCK = ##RCDLCK
     C                   EVAL      set0012.SET_ALWLC = ##ALWLC
     C                   EVAL      set0012.SET_NULL_DFT = ##NULLDFT
     C                   EVAL      set0012.SET_KEEP_CRS = ##KEEPCRS
     C                   Callp     p_updUsrSg('*CRTPGM': SET0012)
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
     C                   OPEN      PEEK52FM
      *
      * - Benutzervoreinstellungen
     C                   EXSR      GetUsrSetg
      *
      * - Füllen der Bildschirmfelder
     C                   EXSR      BZOFF1
     C                   EXSR      FILL##
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
      * - Darstellung der Befehlstasten
     C                   EVAL      SfBot = 1
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   EXSR      SetScreen
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
      *
     C                   Callp     PEEK23(§§PgmName: '*ALL': 0
     C                                    : yFKeys: yNbrOfKeys)
     C                   Eval      ScrnFKeys = %subarr(yFKeys: 1)
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
