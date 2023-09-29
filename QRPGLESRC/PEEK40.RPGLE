      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK40                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 20.03.1998  Raddatz                               *
      *  geändert : 06.04.1999  für Version 2.1.0                     *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Auswahl Datenbankrelation                         *
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
     FPEEK40FM  CF   E             WORKSTN USROPN
     F                                     INFDS(workstn)
     F                                     SFILE(PBSFL:SFLREC)
      *
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
      *----------------------------------------------------*
      *
      *---Farbattribute------------------------------------*
      /COPY QCOPYLE,D_COLORATR
      *----------------------------------------------------*
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK40
      /undefine internal_prototype
      *
      *---Variablendefinition ShortCmd---------------------*
      /COPY QCOPYLE,ShortCmd_D
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR0008
      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8110
      /COPY QCOPYLE,USR8136
      /COPY QCOPYLE,USR8172
      /COPY QCOPYLE,USR8209
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,FILD0100
      /COPY QCOPYLE,DBRL0200
      /COPY QCOPYLE,KEYL0100
      /COPY QCOPYLE,SELL0100
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK27
      /COPY QCOPYLE,PPEEK39
      /COPY QCOPYLE,PPEEK41
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(int4_t) inz
     D yMsgID          S              7A   INZ(*BLANKS)
     D yMsgDta         S            512A   INZ(*BLANKS)
      *
     D YChoice         S             75A   DIM(32)
     D YNbrOfCh        S                   like(int4_t) inz
      *
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(pgmCmdDt_t) INZ(*BLANKS)
      *
     D YQFile          DS                  likeds(qObj_t) inz
     D YMbr            S             10A   INZ(*BLANKS)
     D YData           S            512A   INZ(*BLANKS)
      *
     D IsNewPos        S              1A   INZ(bFalse)
     D IsFound         S              1A   INZ(bFalse)
     D IsSflError      S              1A   INZ(bFalse)
      *
     D rc              S                   like(int4_t) inz
     D numRel          S                   like(int4_t) inz
     D numKey          S                   like(int4_t) inz
     D numSel          S                   like(int4_t) inz
      *
     D SflPage         S                   like(int4_t) inz
     D SfTop           S                   like(int4_t) inz
     D SflPageDDS      S                   INZ(0) LIKE(SflPage)
     D SflRec          S                   INZ(0) LIKE(SflPage)
     D SflNbrRcd       S                   INZ(0) LIKE(SflPage)
     D SfBot           S                   like(int4_t) inz
     D NbrFKeys        C                   CONST(2)
     D Sfl_Cmd         S             10A   INZ(*BLANKS)
      *
     D §UNIQUE         C                   CONST('*UNIQUE')
     D §CONSTR         C                   CONST('*CST')
      *
     D PEEK21_NAME     S                   like(pgmCallN_t) inz
     D PEEK23_NAME     S                   like(pgmCallN_t) inz
     D PEEK27_NAME     S                   like(pgmCallN_t) inz
     D PEEK39_NAME     S                   like(pgmCallN_t) inz
     D PEEK41_NAME     S                   like(pgmCallN_t) inz
      *
     D R_File          S                   INZ(*BLANKS) LIKE(##File )
     D LstFile         S                   INZ(*BLANKS) LIKE(##File )
     D LstNbrRcd       S                   INZ(0) LIKE(SflPage)
     D sPos            S                   like(int4_t) inz
      *
     D Wrk_SFSANR      S                   INZ(*ZEROS ) LIKE(SFSANR )
      *
     D Buffer          S           2000A
      *
     D strPos          S                   LIKE(uint4_t) inz
      *
     D PFile           S                   INZ(*BLANKS)  LIKE(i_file)
     D PLib            S                   INZ(*BLANKS)  LIKE(i_lib )
     D PMbr            S                   INZ(*BLANKS)  LIKE(i_mbr )
     D PFmtName        S                   INZ(*BLANKS)  LIKE(i_rcdFmt)
      *
     D FILD0100        DS                  likeds(FILD0100_t) inz
     D KEYL0100        DS                  likeds(KEYL0100_t) inz
     D DBRL0200        DS                  likeds(DBRL0200_t) inz
     D SELL0100        DS                  likeds(SELL0100_t) inz
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK40          PI
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_file                             const like(file_t)
     D  i_lib                              const like(lib_t)
     D  i_mbr                              const like(mbr_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  i_basePhyF                         const like(bool_t)
     D  o_file                                   like(file_t)
     D  o_lib                                    like(lib_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
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
     C     o_msgID       IFNE      *BLANKS
     C                   GOTO      ENDE
     C                   Endif
      *
      *---------------------------------------------------*
      *  Schleife für Programmbearbeitung
      *
     C                   DO        *HIVAL
      *
      *  Prüfen Positionierung der Subfile
     C     SFSANR        IFLE      *ZEROS
     C                   EVAL      SFSANR = 1
     C                   Endif
      *
      *  Nachrichten senden
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
      *  Modus: DROP/FOLD
     C                   EVAL      *IN86 = SFLMDE
      *
      *  Nachrichten anzeigen
     C                   EVAL      *IN89 = '0'
     C                   WRITE     MSGCTL
      *
      *  "Keine Sätze ..."
     C     *IN80         IFEQ      '0'
     C                   WRITE     PBLEER
     C                   Endif
      *
      *  Anzeigen der Einzelauswahlen
     C     SFTop         IFGT      32
     C     SFTop         ORGT      YNbrOfCh
     C                   EVAL      SFTop = 1
     C                   Endif
     C                   EVAL      $$CHOICE = YChoice(SFTop)
      *
      *  Trennlinie
     C                   WRITE     PBBOT#0
      *  Anzeigen der Befehlstasten
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
     C                   WRITE     PBBOT#5                                      BT-Tasten 4
     C                   When      (SFBOT = 6) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#6                                      BT-Tasten 4
     C                   When      (SFBOT = 7) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#7                                      BT-Tasten 2
     C                   When      (SFBOT = 8) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#8                                      BT-Tasten 3
     C                   When      (SFBOT = 9) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#9                                      BT-Tasten 4
     C                   When      (SFBOT = 10) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#10                                     BT-Tasten 4
     C                   When      (SFBOT = 11) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#11                                     BT-Tasten 4
     C                   When      (SFBOT = 12) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#12                                     BT-Tasten 4
     C                   OTHER
     C                   WRITE     PBBOT#1                                      BT-Tasten 1
     C                   EVAL      SFBOT = 1
     C                   Endsl
      *
      *  Anzeige der Subfile
     C                   EXFMT     PBCTL
     C                   EVAL      *IN70 = '0'
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Aktuelle Satz-Nr.
     C     SFLCSR        IFGT      *ZEROS
     C                   EVAL      SFSANR = SFLCSR
     C                   Endif
      *
      *  Mappen der gedrückten Taste
      *  in Programmbefehl
     C                   CALLP     PEEK21(workstn.aid: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C     YMsgID        IFNE      *BLANKS
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ITER
     C                   Endif
      *
      *  Abfragen der Befehlstasten
     C                   SELECT
      *  F3  - Ende
     C     YPgmCmd       WHENEQ    '*EXIT'
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *
      *  F5  - Aktualisieren
     C     YPgmCmd       WHENEQ    '*REFRESH'
     C                   EXSR      C_Refresh
     C                   ITER
      *
      *  F12 - Ende
     C     YPgmCmd       WHENEQ    '*CANCEL'
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *
      *  F16 - Suchen
     C     YPgmCmd       WHENEQ    '*SEARCH'
     C                   EXSR      C_Search
     C                   ITER
      *
      *   F17 - Anfang Datensatz
     C     YPgmCmd       WHENEQ    '*TOP'
     C                   EXSR      C_Top
     C                   ITER
      *
      *   F18 - Ende Datensatz
     C     YPgmCmd       WHENEQ    '*BOT'
     C                   EXSR      C_Bot
     C                   ITER
      *
      *  F23 - Weitere Auswahlen
     C     YPgmCmd       WHENEQ    '*MOREOPT'
     C                   EXSR      C_MoreOpt
      *
      *  F24 - Weitere Tasten
     C     YPgmCmd       WHENEQ    '*MOREKEYS'
     C                   EXSR      C_MoreKeys
      *
      *  Datenfreigabe
     C     YPgmCmd       WHENEQ    '*ENTER'
     C                   EXSR      C_Enter
     C     o_file        IFEQ      *BLANKS
      *  ... keine Auswahl getroffen, weiter machen
     C                   ELSE
     C                   LEAVE
     C                   Endif
      *  Page up
     C     YPgmCmd       WHENEQ    '*PAGEUP'
      *  Page down
     C     YPgmCmd       WHENEQ    '*PAGEDOWN'
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
     C                   CLOSE     PEEK40FM
      *
     C                   RETURN
      *
      *============================================================*
      *    C_Enter       "Datenfreigabetaste"                      *
      *============================================================*
      *
     C     C_Enter       BEGSR
      *
     C                   EXSR      VReadC
      *
     C     ##File        IFNE      *BLANKS
     C                   EXSR      C_Search
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Search      F16 - Suchen                              *
      *============================================================*
      *
     C     C_Search      BEGSR
      *
     C     ##File        IFNE      *BLANKS
     C                   EVAL      LstFile = ##File
     C                   EVAL      ##File = *BLANKS
     C                   Endif
      *
     C     LstFile       IFEQ      *BLANKS
     C                   EVAL      *IN70 = '1'
     C                   CLEAR                   USR8209
     C                   EVAL      §MsgID = 'USR8209'
     C                   EVAL      §MsgDta = USR8209
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   EXSR      PosToField
     C     IsNewPos      IFEQ      bTrue
     C                   EVAL      SFSANR = Wrk_SFSANR
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PosToField    Subfile neu positionieren                 *
      *============================================================*
      *
     C     PosToField    BEGSR
      *
     C     LstFile       IFNE      R_File
     C                   Eval      LstNbrRcd = 0
     C                   Endif
      *
     C     LstFile       IFEQ      *BLANKS
     C                   EVAL      IsNewPos = bFalse
     C                   Eval      LstNbrRcd = 0
     C                   ELSE
      *
     C                   EXSR      SrchField
     C     IsFound       IFEQ      bFalse
     C                   EVAL      IsNewPos = bFalse
     C                   CLEAR                   USR8136
     C                   EVAL      §MsgID = 'USR8136'
     C                   EVAL      USR81361 = ##File                            Feldname
     C                   EVAL      §MsgDta = USR8136
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   EVAL      IsNewPos = bTrue
     C                   Endif
     C                   Endif
      *
     C                   EVAL      R_File = LstFile
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchField     Suchen Feld in Subfile                    *
      *============================================================*
      *
     C     SrchField     BEGSR
      *
     C     *IN80         IFEQ      '0'
     C                   EVAL      IsFound = bFalse
     C                   ELSE
      *
     C                   EVAL      IsFound = bFalse
     C                   Eval      LstNbrRcd = LstNbrRcd + 1
      *
     C     LstNbrRcd     DO        SflNbrRcd     SflRec
     C     SflRec        CHAIN     PBSFL                              1111
     C     *IN11         IFEQ      '1'
     C                   EVAL      IsFound = bFalse
     C                   LEAVE
     C                   Endif
      *
     C                   EXSR      BzToScreen
      *
     C     ' '           Check     $$File        sPos
     C                   IF        sPos <= 0
     C                   EVAL      sPos = 1
     C                   Endif
      *
     C                   IF        LstFile  =
     C                             %subst($$FILE: sPos:(f_scan(' ':
     C                                                  LstFile) - 1))
     C                   EVAL      IsFound = bTrue
     C                   LEAVE
     C                   ELSE
     C     SFPAU         IFNE      *BLANKS
      *  ... Satz geändert
     C                   EXSR      VSfpauChg
     C                   ELSE
      *  ... Satz nicht geändert
     C                   EXSR      VSfpauClr
     C                   Endif
      *
     C                   EXSR      BzToSubF
     C                   UPDATE    PBSFL
     C                   ITER
     C                   Endif
      *
     C                   Enddo
      *
     C     IsFound       IFEQ      bTrue
     C                   EVAL      Wrk_SFSANR = SflRec
     C                   Eval      LstNbrRcd = SflRec
     C                   ELSE
     C                   EVAL      Wrk_SFSANR = *ZEROS
     C                   Eval      LstNbrRcd = 0
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchInit      Initialisieren Suchfunktion               *
      *============================================================*
      *
     C     SrchInit      BEGSR
      *
     C                   Eval      LstFile   = ' '
     C                   Eval      LstNbrRcd = 0
     C                   Eval      R_File    = LstFile
      *
     C                   ENDSR
      *
      *============================================================*
      *    VReadC        Verarbeiten der Subfileauswahlen          *
      *============================================================*
      *
     C     VReadC        BEGSR
      *
     C                   EVAL      IsSflError = bFalse
      *
     C     *IN80         IFEQ      '0'
      *   keine Einträge in Subfile vorhanden ...
     C                   ELSE
      *
     C     1             DO        SflNbrRcd
     C                   READC     PBSFL                                  1111
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C     SflRec        CHAIN     PBSFL                              11
      *
     C                   EXSR      BzToScreen
      *
      *  Cursorpositionierung ...
     C     IsSflError    IFEQ      bFalse
     C                   EVAL      SflCsr = SflRec
     C                   ELSE
      *  Subfile nicht neu positionieren
     C                   Endif
      *
      *  Linksbündig setzen ...
     C                   EVAL      SFPAU = %triml(SFPAU)
      *
      *  Zuordnung AUSWAHL => Befehl ...
     C                   CALLP     PEEK21('#' + SFPAU: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C     YMsgID        IFNE      *BLANKS
      *  Fehlermeldung ...
     C                   EVAL      §MsgID = 'USR8110'
     C                   EVAL      §MsgDta = SFPAU
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EXSR      VSfpauErr
      *
     C                   EXSR      BzToSubf
     C                   UPDATE    PBSfl
     C                   EVAL      IsSflError = bTrue
     C                   ITER
     C                   Endif
      *
      *----------------------------*
      *  Ausführen SFL-Befehl ...  *
      *----------------------------*
     C                   EVAL      Sfl_Cmd = YPgmCmd
      *
     C                   SELECT
     C     Sfl_Cmd       WHENEQ    '*NONE'
     C     Sfl_Cmd       WHENEQ    '*SELECT'
     C                   EXSR      VPOS
     C                   LEAVE
     C                   OTHER
      *  Unbekannter Programmbefehl
     C                   EVAL      §MsgID = 'USR8110'
     C                   EVAL      USR81101 = YPgmCmd
     C                   EVAL      §MsgDta = USR8110
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EXSR      VSfpauErr
      *
     C                   EXSR      BzToSubf
     C                   UPDATE    PBSfl
     C                   EVAL      IsSflError = bTrue
     C                   ITER
     C                   Endsl
      *
     C                   EXSR      BzToSubf
     C                   UPDATE    PBSfl
     C                   Enddo
      *
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
     C                   EVAL      o_msgID = 'USR8100'
     C                   EVAL      USR81001 = YPgmCmd
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
      * - Subfile neu aufbauen
     C                   EXSR      PBInitKey
     C                   EXSR      PBInit
     C                   EXSR      PBSetLL
     C                   EXSR      PBReadUp
      *
     C                   Exsr      SrchInit
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Top         F17 - Anfang der Subfile                  *
      *============================================================*
      *
     C     C_Top         BEGSR
      *
     C                   EVAL      SFSANR = 1
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Bot         F18 - Ende der Subfile                    *
      *============================================================*
      *
     C     C_Bot         BEGSR
      *
     C                   EVAL      SFSANR = SflNbrRcd
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_MoreOpt     F23 - Weitere Auswahlen                   *
      *============================================================*
      *
     C     C_MoreOpt     BEGSR
      *
     C                   EVAL      SFTop = SFTop + 1
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
      *    VPos          Verarbeiten der Eingaben                  *
      *============================================================*
      *
     C     VPos          BEGSR
      *
     C                   EVAL      o_file = H$File
     C                   EVAL      o_lib = H$Lib
      *
     C                   ENDSR
      *
      *============================================================*
      *    VSfpauClr     Löschen Subfileauswahl                    *
      *============================================================*
      *
     C     VSfpauClr     BEGSR
      *
     C                   EVAL      SFPAU = *BLANKS
     C                   EVAL      *IN85 = '0'                                  DSPATR(RI)
     C                   EVAL      *IN84 = '0'                                  SFLNXTCHG
      *
     C                   ENDSR
      *
      *============================================================*
      *    VSfpauErr     Anzeigen fehlerhafter Subfileauswahl      *
      *============================================================*
      *
     C     VSfpauErr     BEGSR
      *
     C                   EVAL      *IN85 = '1'                                  DSPATR(RI)
     C                   EXSR      VSfpauChg
      *
     C                   ENDSR
      *
      *============================================================*
      *    VSfpauChg     Datensatz in Subfile als geändert         *
      *                  markieren                                 *
      *============================================================*
      *
     C     VSfpauChg     BEGSR
      *
     C                   EVAL      *IN84 = '1'                                  SFLNXTCHG
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBInitKey     Initialisieren der Schlüsselfelder        *
      *                  zum Füllen der Subfile                    *
      *============================================================*
      *
     C     PBInitKey     BEGSR
      *
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBInit        Initialisieren der Subfile zur Anzeige    *
      *                  der nächsten Seite                        *
      *============================================================*
      *
     C     PBINIT        BEGSR
      *
     C                   EVAL      *IN89 = '0'
     C                   WRITE     MSGCTL
      *
     C                   EVAL      *IN80 = '0'                                  SFLDSP
     C                   EVAL      *IN81 = '1'                                  SFLDSPCTL
     C                   EVAL      *IN82 = '1'                                  SFLCLR
     C                   EVAL      *IN83 = '1'                                  SFLEND
     C                   WRITE     PBCTL
      *
     C                   EVAL      *IN82 = '0'                                  SFLCLR
      *
     C                   EVAL      SFLREC = *ZEROS
     C                   EVAL      SflNbrRcd = *ZEROS
     C                   EVAL      $$DepFile = *ZEROS
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBReadUP      Vorwärts füllen der Subfile               *
      *============================================================*
      *
     C     PBReadUP      BEGSR
      *
     C     1             DO        numRel
      *
     C                   CALLP     PEEK39(YQFile: YMbr
     C                                    : '*READ': rc: DBRL0200)
      *
     C                   IF        (DBRL0200.B2DepFile = '*NONE')
     C                   ITER
     C                   Endif
      *
     C                   IF        (DBRL0200.B2DepType <> 'D')
     C                   ITER
     C                   Endif
      *
     C                   EVAL      $$DepFile = $$DepFile + 1
      *
      *  Bei erstem Datensatz, ...
     C     *IN80         IFEQ      '0'
      *  ... die physische Datei anzeigen
     C                   EVAL      H$File = DBRL0200.B2FNmeUsed
     C                   EVAL      H$Lib = DBRL0200.B2LNmeUsed
      ***                EXSR      StatMsg
     C                   EXSR      PBFill
     C                   EXSR      PBFillKey
     C                   EXSR      PBFillSel
     C                   Endif
      *
      *  Anzeigen der logischen Sichten
     C                   EVAL      H$File = DBRL0200.B2DepFile
     C                   EVAL      H$Lib = DBRL0200.B2DepLib
      ***                EXSR      StatMsg
     C                   EXSR      PBFill
     C                   EXSR      PBFillKey
     C                   EXSR      PBFillSel
     C                   Enddo
      *
      *  Bei erstem Datensatz, ...
     C     *IN80         IFEQ      '0'
      *  ... die physische Datei anzeigen
     C                   Clear                   DBRL0200
     C                   EVAL      H$File = i_file
     C                   EVAL      H$Lib = i_lib
     C                   EVAL      DBRL0200.B2LNmeUsed = i_lib
      ***                EXSR      StatMsg
     C                   EXSR      PBFill
     C                   EXSR      PBFillKey
     C                   EXSR      PBFillSel
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    StatMsg       Statusnachricht ausgeben                  *
      *============================================================*
      *
     C     StatMsg       BEGSR
      *
      *  Nachricht ausgeben ...
     C                   Clear                   USR8172
     C                   Eval      USR81721 = %trimr(H$Lib) +
     C                                        '/'           +
     C                                        H$File
     C                   Callp     p_sndStsMg('USR8172': USR8172)
      *
     C                   ENDSR
      *
      *============================================================*
      *    BzToScreen    Übertragen Bezugszahlen in Bildschirm     *
      *============================================================*
      *
     C     BzToScreen    BEGSR
      *
     C                   EVAL      *IN20 = §IN20
     C                   EVAL      *IN71 = §IN71
      *
     C                   ENDSR
      *
      *============================================================*
      *    BzToSubf      Übertragen Bezugszahlen in Subfile        *
      *============================================================*
      *
     C     BzToSubf      BEGSR
      *
     C                   EVAL      §IN20 = *IN20
     C                   EVAL      §IN71 = *IN71
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBFill        Füllen Subfilesatz                        *
      *============================================================*
      *
     C     PBFill        BEGSR
      *
      *  Datensatz komplett anzeigen ...
     C                   EVAL      *IN71 = '0'
      *
      *  Abhängigkeit prüfen ...
     C                   IF        (DBRL0200.B2LNmeUsed = H$Lib or
     C                              *IN80 = '0')
     C                   EVAL      *IN20 = '0'
     C                   ELSE
     C                   EVAL      *IN20 = '1'
     C                   Endif
      *
      *  Einlesen der Dateiinformationen ...
     C                   EVAL      yQFile.name = H$File
     C                   EVAL      yQFile.lib = H$Lib
     C                   CALLP     PEEK41(YQFile
     C                                    : '*FIRST': '*CREATE': rc: YData)
      *  ... Bezeichnung
     C                   CALLP     PEEK41(YQFile
     C                                    : '*FIRST': '*READTEXT': rc: YData)
     C                   EVAL      $$FTXT = YData
      *
      *  Schreiben der Subfile ...
     C                   EXSR      PbWrite
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBFillKey     Füllen Subfilesatz, Schlüsselfelder       *
      *============================================================*
      *
     C     PBFillKey     BEGSR
      *
      *  Datensatz nicht komplett anzeigen ...
     C                   EVAL      *IN71 = '1'
      *
      *  Einlesen der Schlüsselinformationen ...
     C                   CALLP     PEEK41(YQFile
     C                                    : '*FIRST': '*KEY': numKey: YData)
      *
     C                   EVAL      Buffer = *BLANKS
      *
     C     1             DO        numKey
     C                   CALLP     PEEK41(YQFile
     C                                    : '*FIRST': '*READKEY': rc: YData)
     C                   EVAL      KEYL0100 = YData
      *
     C                   IF        (KEYL0100.APKSEQ = 'D')
     C                   EVAL      Buffer = %trimr(Buffer) + §White
     C                   ELSE
     C                   Eval      Buffer = %trimr(Buffer) + §Green
     C                   Endif
      *
     C                   Eval      Buffer = %trimr(Buffer) + KEYL0100.APKEYF
     C                   Enddo
      *
     C                   IF        (numKey >= 1 and
     C                              KEYL0100.APUNIQ = 'Y')
     C                   Eval      Buffer = %trimr(Buffer) + §White + §UNIQUE
     C                   Endif
      *
     C                   SELECT
     C                   WHEN      (DBRL0200.B2DepType = 'C')
     C                   Eval      Buffer = %trimr(Buffer) + §White + §CONSTR
     C                   OTHER
     C                   Endsl
      *
     C                   Eval      Buffer = %trimr(Buffer) + §Green
      *
     C                   Eval      strPos = 1
     C                   Dou       strPos = 0
     C                   Eval      $$FTXT = f_wordWrap(
     C                                            Buffer: %len($$FTXT): strPos)
      *  Schreiben der Subfile ...
     C                   EXSR      PbWrite
     C                   If        (strPos > 0 and
     C                              %subst(Buffer: 1: strPos-1) < x'40')
      *     Positionieren auf Farb-Attribut
     C                   Eval      strPos = strPos - 1
     C                   Endif
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBFillSel     Füllen Subfilesatz, SELECT/OMIT           *
      *============================================================*
      *
     C     PBFillSel     BEGSR
      *
      *  Datensatz nicht komplett anzeigen ...
     C                   EVAL      *IN71 = '1'
      *
      *  Einlesen der Select/Omit Informationen ...
     C                   CALLP     PEEK41(YQFile
     C                                    : '*FIRST': '*SELECT': numSel: YData)
      *
     C     1             DO        numSel
     C                   CALLP     PEEK41(YQFile
     C                                    : '*FIRST': '*READSEL': rc: YData)
     C                   EVAL      SELL0100 = YData
      *
      *  Wenn das Ende der Liste rreicht ist, ...
     C                   if        (SELL0100.SOCOMP = 'AL')
      *  ... dann den Eintrag überlesen
     C                   ELSE
      *  ... ansonsten den Eintrag aufbereiten und anzeigen
     C                   SELECT
     C                   WHEN      (SELL0100.SORULE = 'S')
     C                   Eval      Buffer = §White + '*SELECT'
     C                   WHEN      (SELL0100.SORULE = 'O')
     C                   Eval      Buffer = §White + '*OMIT'
     C                   OTHER
     C                   EVAL      Buffer = §White
     C                   Endsl
      *
     C                   Eval      %subst(Buffer: 10: %len(SELL0100.SOFLD)) =
     C                               SELL0100.SOFLD
     C                   Eval      %subst(Buffer: 21: %len(SELL0100.SOCOMP)) =
     C                               SELL0100.SOCOMP
     C                   Eval      Buffer = %trimr(Buffer) + ' ' +
     C                                      SELL0100.SOVALU + §Green
     C                   EVAL      $$FTXT = Buffer
      *  Schreiben der Subfile ...
     C                   EXSR      PbWrite
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBWrite       Schreiben der Subfile                     *
      *============================================================*
      *
     C     PBWrite       BEGSR
      *
      *  Datensatz nicht komplett anzeigen ...
     C     *IN71         IFEQ      '1'
     C                   EVAL      $$File = *BLANKS
     C                   EVAL      $$Lib = *BLANKS
     C                   ELSE
      *  Bei erstem Datensatz, ...
     C     *IN80         IFEQ      '0'
     C                   EVAL      $$File = H$File
     C                   EVAL      $$Lib = H$Lib
     C                   ELSE
     C                   Eval      $$File = ' ' + H$File
     C                   EVAL      $$Lib = H$Lib
     C                   Endif
     C                   Endif
      *
      *  Anzeigen der Subfile ...
     C                   EVAL      *IN80 = '1'
      *
      *  Löschen Subfileauswahl ...
     C                   EXSR      VSfpauClr
      *
      *  Schreiben des Subfilesatzes ...
     C                   EVAL      SflRec = SflRec + 1
     C                   EXSR      BzToSubf
     C                   WRITE     PBSfl
     C                   EVAL      SflNbrRcd = SflRec
      *
     C     H$File        IFEQ      i_file
     C     H$Lib         ANDEQ     i_lib
     C     *IN71         ANDEQ     '0'
     C                   EVAL      SFSANR = SflRec
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSetLL       Setzen Dateizeiger                        *
      *============================================================*
      *
     C     PBSetLL       BEGSR
      *
     C                   EVAL      yQFile.name = PFile
     C                   EVAL      yQFile.lib = PLib
     C                   EVAL      YMbr = PMbr
      *
     C                   CALLP     PEEK39(YQFile: YMbr
     C                                    : '*CREATE': numRel: DBRL0200)
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
     C                   EVAL      ZEI = 2
     C                   EVAL      POS = 2
     C                   Endif
      *
     C                   EVAL      SflPage = *HIVAL
     C                   EVAL      SflPageDDS = 6
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
     C                   OPEN      PEEK40FM
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      ##File = *BLANKS
     C                   EVAL      R_File = ##File
      *
      * - Rückkehrcode
     C                   EVAL      o_file = *BLANKS
     C                   EVAL      o_lib = *BLANKS
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
      * - Dateityp feststellen
     C                   EVAL      PFile = i_file
     C                   EVAL      PLib = i_lib
     C                   EVAL      PMbr = i_mbr
     C                   EVAL      PFmtName = i_rcdFmt
      *
      *   ... Einlesen der Dateiinformationen
     C                   EVAL      yQFile.name = PFile
     C                   EVAL      yQFile.lib = PLib
     C                   CALLP     PEEK41(YQFile
     C                                    : PFmtName: '*CREATE': rc: YData)
      *
     C     rc            IFEQ      *ZEROS
      *       ... Fehler
     C                   EVAL      o_msgID = 'USR0008'
     C                   CLEAR                   USR0008
     C                   EVAL      USR00081 = yQFile.name
     C                   EVAL      USR00082 = yQFile.lib
     C                   EVAL      o_msgDta = USR0008
     C                   ELSE
      *       ... kein Fehler
     C                   EVAL      FILD0100 = YData
     C                   IF        FILD0100.ATFILA = '*LGL'
      *           ... logical file
     C                   CALLP     PEEK41(YQFile
     C                                    : PFmtName: '*BASED-ON': rc: YData)
     C     rc            IFEQ      *ZEROS
      *               ... Fehler
     C                   EVAL      USR00081 = yQFile.name
     C                   EVAL      USR00082 = yQFile.lib
     C                   EVAL      o_msgDta = USR0008
     C                   ELSE
     C     i_basePhyF    IFEQ      bTrue
      *                   ... based-on
     C                   EVAL      PFile = %subst(YData: 1: 10)
     C                   EVAL      PLib  = %subst(YData: 11: 10)
     C                   EVAL      PMbr = '*FIRST'
     C                   ELSE
      *               ... no based-on
     C                   Endif
     C                   Endif
     C                   ELSE
      *           ... physical file
     C                   Endif
     C                   Endif
      *
     C     o_msgID       IFNE      *BLANKS
      *   ... Fehler
     C                   ELSE
      *
      * - Darstellung der Subfile
     C                   EVAL      SflMde = '1'
      *
      * -  Darstellung der Auswahlen/Funktionstasten
     C                   EVAL      SFTop = 1
     C                   EVAL      SfBot = 1
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   EXSR      SetScreen
      *
      * - Anzuzeigender Subfilesatz
     C                   EVAL      SFSANR = 1
      *
      * - Subfile füllen
     C                   EXSR      C_Refresh
      *
      * - Copyright
     C                   EVAL      §MsgID = 'USR9999'
     C                   EVAL      §MsgDta = i_copyright
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
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
     C                   Eval      PEEK27_NAME = f_pgmCallN('PEEK27')
     C                   Eval      PEEK39_NAME = f_pgmCallN('PEEK39')
     C                   Eval      PEEK41_NAME = f_pgmCallN('PEEK41')
      *
     C                   Callp     PEEK23(§§PgmName: '*ALL': 0
     C                                    : yFKeys: yNbrOfKeys)
     C                   Eval      ScrnFKeys = %subarr(YFKeys: 1)
      *
     C                   Callp     PEEK27(§§PgmName: YChoice: YNbrOfCh)
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
