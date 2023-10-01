      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK56                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 05.04.1999  Raddatz                               *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Auswählen "Arbeitsumgebung"                       *
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
     FPEEK56FM  CF   E             WORKSTN USROPN
     F                                     INFDS(workstn)
     F                                     SFILE(PBSFL:SFLREC)
      *
     FPEEKENV   IF   E           K DISK    usropn
     F                                     extfile(g_envFile)
     F                                     extmbr(g_envMbr)
     F                                     prefix(en_)
      *
     D g_envFile       S             21A
     D g_envMbr        S             10A
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
      /COPY QCOPYLE,PPEEK56
      /undefine internal_prototype
      *
      *---Variablendefinition ShortCmd---------------------*
      /COPY QCOPYLE,ShortCmd_D
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8110
      /COPY QCOPYLE,USR8180
      /COPY QCOPYLE,USR8181
      /COPY QCOPYLE,USR8182
      /COPY QCOPYLE,USR8184
      /COPY QCOPYLE,USR8209
      /COPY QCOPYLE,USR8233
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
      /COPY QCOPYLE,MBRL0200
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,F_PEEK58
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(int4_t) inz
     D yExclKeys       S                   LIKE(pgmCmd_t) DIM(25)
     D yMsgID          S              7A   INZ(*BLANKS)
     D yMsgDta         S            512A   INZ(*BLANKS)
      *
      *  Peek46:
     D YQFile          DS
     D  YFile                        10A   INZ
     D  YLib                         10A   INZ
     D numMbr          S                   like(int4_t) inz
      *
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(pgmCmdDt_t) INZ(*BLANKS)
      *
     D YChoice         S             75A   DIM(32)
     D YNbrOfCh        S                   like(int4_t) inz
      *
     D IsNewPos        S              1A   INZ(bFalse)
     D IsFound         S              1A   INZ(bFalse)
     D IsSflError      S              1A   INZ(bFalse)
     D IsCtlError      S              1A   INZ(bFalse)
     D IsDirty         S              1A   INZ(bFalse)
      *
     D SfTop           S                   like(int4_t) inz
     D SflPage         S                   like(int4_t) inz
     D SflPageDDS      S                   like(SflPage   ) inz
     D SflRec          S                   like(SflPage   ) inz
     D SflNbrRcd       S                   like(SflPage   ) inz
     D SfBot           S                   like(int4_t) inz
     D Sfl_Cmd         S             10A   INZ(*BLANKS)
     D Ctl_Cmd         S             10A   INZ(*BLANKS)
     D NbrFKeys        C                   CONST(3)
      *
     D PEEK21_NAME     S                   like(pgmCallN_t) inz
     D PEEK23_NAME     S                   like(pgmCallN_t) inz
     D PEEK27_NAME     S                   like(pgmCallN_t) inz
     D PEEK46_NAME     S                   like(pgmCallN_t) inz
      *
     D R_Mbr           S                   INZ(*BLANKS) LIKE(##Mbr  )
     D LstMbr          S                   INZ(*BLANKS) LIKE(##Mbr  )
     D LstNbrRcd       S                   INZ(0) LIKE(SflPage)
      *
     D Wrk_SFSANR      S                   INZ(*ZEROS ) LIKE(SFSANR )
      *
     D LastFile        S                   Like(##File    )
     D                                     Inz
     D LastLib         S                   Like(##Lib     )
     D                                     Inz
     D isPrdLib        S                   like(bool_t)
     D                                     inz(bFalse)
      *
     D rcdFmtID        S                   like(fmtid_t)
     D MBRL0200        DS                  likeds(MBRL0200_t) inz
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0015
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK27
      /COPY QCOPYLE,PPEEK46
      *
      /COPY QCOPYLE,F_PEEK53
      *
     D f_isVldOpt      PR                         like(bool_t)
     D  i_option                                  like(SFPAU)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
     D f_loadRcdFmtID...
     D                 PR                  like(fmtid_t)
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK56          PI
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_mode                             const like(mode_t)
     D  i_envFile                          const like(file_t)
     D  i_envLib                           const like(lib_t)
     D  i_envMbr                           const like(mbr_t)
     D  i_rcdFmtID                         const like(fmtId_t)
     D  o_qFile                                  likeds(qObj_t)
     D  o_mbr                                    like(mbr_t)
     D  o_text                                   like(text_t)
     D  o_option                                 like(option_t)
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
     C                   WRITE     PBBOT#7                                      BT-Tasten 4
     C                   When      (SFBOT = 8) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#8                                      BT-Tasten 4
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
      *  Bezugszahlen löschen
     C                   EXSR      clrIndCtl
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
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   EVAL      YMsgID = ''
     C                   EVAL      YMsgDta = ''
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
     C     isCtlError    IFEQ      bFalse
     C                   EXSR      SetUsrSetg
     C                   ENDIF
     C     o_mbr         IFEQ      *BLANKS
     C     isCtlError    OREQ      bTrue
     C     isSflError    OREQ      bTrue
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
     C                   If        workstn.open = '1'
     C                   CLOSE     PEEK56FM
     C                   Endif
      *
     C                   RETURN
      *
      *============================================================*
      *    C_Enter       "Datenfreigabetaste"                      *
      *============================================================*
      *
     C     C_Enter       BEGSR
      *
     C                   Eval      isCtlError = bFalse
     C                   Eval      isDirty    = bFalse
      *
      *  Prüfen der Eingaben im Kontrollsatz
     C                   EXSR      VCtl
      *
      *  Wenn alles OK ist und die Subfile weiterhin gültig ist, ...
     C                   If        (isCtlError = bFalse) and
     C                             (isDirty    = bFalse)
      *  ... dann
      *      Wenn der Teildateiname gefüllt ist, ...
     C                   If        ##MNME <> ' '
      *      ... dann
      *          füllen der Rückgabeparameter
     C                   Eval      o_qFile.name = ##File
     C                   Eval      o_qFile.lib = ##Lib
     C                   Eval      o_mbr    = ##MNME
     C                   Eval      o_text   = ##MTXT
     C                   Eval      o_option = Ctl_Cmd
     C                   Else
      *      ... sonst
      *          prüfen der Subfile
     C                   EXSR      VReadC
      *
     C                   Endif
     C                   Endif
      *
      *  Wenn die Subfile ungültig ist, ...
     C                   If        isDirty = bTrue
      *  ... dann
      *      aktualisieren der Subfile
     C                   Exsr      c_refresh
     C                   Else
      *  ... sonst
      *      Wenn die Teildatei ausgefüllt ist, ...
     C                   If        ##Mbr <> ' '
      *      ... dann
      *          ausführen Suchfunktion
     C                   EXSR      C_Search
     C                   Else
      *      ... sonst
      *          prüfen der Dateiangaben
     C                   Exsr      ChkFile
     C                   Endif
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
     C     ##Mbr         IFNE      *BLANKS
     C                   EVAL      LstMbr = ##Mbr
     C                   EVAL      ##Mbr = *BLANKS
     C                   Endif
      *
     C     LstMbr        IFEQ      *BLANKS
     C                   EVAL      *IN70 = '1'
     C                   CLEAR                   USR8209
     C                   Callp     p_sndPgmMg('USR8209': USR8209: §§pgmName)
     C                   ELSE
     C                   EXSR      PosToMbr
     C     IsNewPos      IFEQ      bTrue
     C                   EVAL      SFSANR = Wrk_SFSANR
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PosToMbr      Subfile neu positionieren                 *
      *============================================================*
      *
     C     PosToMbr      BEGSR
      *
     C     LstMbr        IFNE      R_Mbr
     C                   Eval      LstNbrRcd = 0
     C                   Endif
      *
     C     LstMbr        IFEQ      *BLANKS
     C                   EVAL      IsNewPos = bFalse
     C                   Eval      LstNbrRcd = 0
     C                   ELSE
      *
     C                   EXSR      SrchMbr
     C     IsFound       IFEQ      bFalse
     C                   EVAL      IsNewPos = bFalse
     C                   CLEAR                   USR8180
     C                   EVAL      USR81801 = LstMbr
     C                   Callp     p_sndPgmMg('USR8180': USR8180: §§pgmName)
     C                   ELSE
     C                   EVAL      IsNewPos = bTrue
     C                   Endif
     C                   Endif
      *
     C                   EVAL      R_Mbr = LstMbr
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchMbr       Suchen Member in Subfile                  *
      *============================================================*
      *
     C     SrchMbr       BEGSR
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
     C                   IF        LstMbr =
     C                             %subst($$MNME: 1:(f_scan(' ':
     C                                                      LstMbr) - 1))
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
     C                   EVAL      Wrk_SFSANR = 0
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
     C                   Eval      LstMbr = ''
     C                   Eval      LstNbrRcd = 0
     C                   Eval      R_Mbr = LstMbr
      *
     C                   ENDSR
      *
      *============================================================*
      *    VCtl          Verarbeiten der Eingaben Kontrollsatz     *
      *============================================================*
      *
     C     VCtl          BEGSR
      *
      * - Funktion nicht freigeschaltet
     C                   If        (##File = ' ') or
     C                             (##Lib  = ' ') or
     C                             (SET_ENVENA = bFalse)
     C                   Clear                   USR8184
     C                   Callp     p_sndPgmMg('USR8184': USR8184: §§pgmName)
     C                   Eval      isCtlError = bTrue
     C                   Exsr      posCsr
     C                   Goto      endVCtl
     C                   Endif
      *
      *  ##Lib
     C                   Exsr      Prf41
     C                   If        isCtlError = bTrue
     C                   Goto      endVCtl
     C                   Endif
      *
      *  ##File
     C                   Exsr      Prf40
     C                   If        isCtlError = bTrue
     C                   Goto      endVCtl
     C                   Endif
      *
     C                   If        isDirty = bFalse
      *  ##CTLAU
     C                   Exsr      Prf20
     C                   If        isCtlError = bTrue
     C                   Goto      endVCtl
     C                   Endif
      *
     C                   If        (##CTLAU <> ' ') or
     C                             (##MNME  <> ' ') or
     C                             (##MTXT  <> ' ')
      *  ##MNME
     C                   Exsr      Prf21
     C                   If        isCtlError = bTrue
     C                   Goto      endVCtl
     C                   Endif
      *
      *  ##MTXT
     C                   Exsr      Prf22
     C                   If        isCtlError = bTrue
     C                   Goto      endVCtl
     C                   Endif
      *
     C                   Endif
     C                   Endif
      *
     C     endVCtl       Tag
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prf40         Prüfen ##File                             *
      *============================================================*
      *
     C     Prf40         BEGSR
      *
      *  gültiger Name ?
     C                   If        f_vldName(##File: yMsgID: yMsgDta) = bTrue
     C                   Eval      isCtlError = bFalse
     C                   Else
     C                   Eval      isCtlError = bTrue
     C                   If        (yMsgID <> '')
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   Eval      yMsgID = ''
     C                   Eval      yMsgDta = ''
     C                   Endif
     C                   Goto      ePrf40
     C                   Endif
      *
      *  Prüfen Datei
      *  ------------
     C                   Callp     f_execute('CHKOBJ'      +
     C                                       ' OBJ('       +
     C                                       %trim(##Lib)  +
     C                                       '/'           +
     C                                       %trim(##FILE) +
     C                                       ')'           +
     C                                       ' OBJTYPE('   +
     C                                       '*FILE'       +
     C                                       ')'           +
     C                                       ' MBR('       +
     C                                        '*NONE'      +
     C                                       ')'           +
     C                                       ' AUT('       +
     C                                       '*NONE'       +
     C                                       ')'           :
     C                                       yMsgID        :
     C                                       yMsgDta       )
      *
     C                   If        (yMsgID <> '')
     C                   Eval      isCtlError = bTrue
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   Eval      yMsgID = ''
     C                   Eval      yMsgDta = ''
     C                   Goto      ePrf40
     C                   Else
     C                   Eval      isCtlError = bFalse
     C                   Endif
      *
      *  Datei geändert ?
     C                   If        ##File <> LastFile
     C                   Eval      isDirty = bTrue
     C                   Goto      ePrf40
     C                   Endif
     C
      *
     C     ePrf40        Tag
      *
     C                   If        isCtlError = bTrue
     C                   Eval      *IN40 = *ON
     C                   Eval      *IN50 = *ON
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prf41         Prüfen ##Lib                              *
      *============================================================*
      *
     C     Prf41         BEGSR
      *
      *  gültiger Name ?
     C                   If        f_vldName(##Lib: yMsgID: yMsgDta) = bTrue
     C                   Eval      isCtlError = bFalse
     C                   Else
     C                   Eval      isCtlError = bTrue
     C                   If        (yMsgID <> '')
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   Eval      yMsgID = ''
     C                   Eval      yMsgDta = ''
     C                   Endif
     C                   Goto      ePrf41
     C                   Endif
      *
      *  Prüfen Bibliothek
      *  -----------------
     C                   Callp     f_execute('CHKOBJ'      +
     C                                       ' OBJ('       +
     C                                       %trim(##Lib)  +
     C                                       ')'           +
     C                                       ' OBJTYPE('   +
     C                                       '*LIB'        +
     C                                       ')'           +
     C                                       ' MBR('       +
     C                                        '*NONE'      +
     C                                       ')'           +
     C                                       ' AUT('       +
     C                                       '*NONE'       +
     C                                       ')'           :
     C                                       yMsgID        :
     C                                       yMsgDta       )
      *
     C                   If        (yMsgID <> '')
     C                   Eval      isCtlError = bTrue
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   Eval      yMsgID = ''
     C                   Eval      yMsgDta = ''
     C                   Goto      ePrf41
     C                   Else
     C                   Eval      isCtlError = bFalse
     C                   Endif
      *
      *  Bibliothek geändert ?
     C                   If        ##LIB <> LastLib
     C                   Eval      isDirty = bTrue
     C                   Goto      ePrf41
     C                   Endif
      *
     C     ePrf41        Tag
      *
     C                   If        isCtlError = bTrue
     C                   Eval      *IN41 = *ON
     C                   Eval      *IN51 = *ON
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prf20         Prüfen ##CTLAU                            *
      *============================================================*
      *
     C     Prf20         BEGSR
      *
      *  Zuordnung AUSWAHL => Befehl ...
     C                   Eval      isCtlError =
     C                               f_isVldOpt(##CTLAU: yMsgID: yMsgDta)
     C                   If        isCtlError = bTrue
     C                   Eval      Ctl_cmd = ' '
     C                   If        (yMsgID <> '')
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   Eval      yMsgID = ''
     C                   Eval      yMsgDta = ''
     C                   Endif
     C                   Goto      ePrf20
     C                   Endif
      *
     C                   Eval      Ctl_cmd = YPgmCmd
      *
     C                   If        ((##MNME  <> ' ')  or
     C                              (##MTXT  <> ' ')) and
     C                             (##CTLAU = ' ')
     C                   Clear                   USR8110
     C                   Eval      USR81101   = ##CTLAU
     C                   Callp     p_sndPgmMg('USR8110': USR8110: §§pgmName)
     C                   Eval      isCtlError = bTrue
     C                   Goto      ePrf20
     C                   Endif
      *
     C     ePrf20        Tag
      *
     C                   If        isCtlError = bTrue
     C                   Eval      *IN20 = *ON
     C                   Eval      *IN30 = *ON
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prf21         Prüfen ##MNME                             *
      *============================================================*
      *
     C     Prf21         BEGSR
      *
      *  gültiger Name ?
     C                   If        f_vldName(##MNME: yMsgID: yMsgDta) = bTrue
     C                   Eval      isCtlError = bFalse
     C                   Else
     C                   Eval      isCtlError = bTrue
     C                   If        (yMsgID <> '')
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   Eval      yMsgID = ''
     C                   Eval      yMsgDta = ''
     C                   Endif
     C                   Endif
     C
      *
     C                   If        (yMsgID = 'CPD0078')
     C                   Callp     p_sndPgmMg('CPD0078': yMsgDta: §§pgmName)
     C                   Eval      isCtlError = bTrue
     C                   Endif
      *
     C     ePrf21        Tag
      *
     C                   If        isCtlError = bTrue
     C                   Eval      *IN21 = *ON
     C                   Eval      *IN31 = *ON
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prf22         Prüfen ##MTXT                             *
      *============================================================*
      *
     C     Prf22         BEGSR
      *
     C     ePrf22        Tag
      *
     C                   If        isCtlError = bTrue
     C                   Eval      *IN22 = *ON
     C                   Eval      *IN32 = *ON
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkFile       Prüfen/Anlegen Env.Datei                  *
      *============================================================*
      *
     C     ChkFile       BEGSR
      *
     C                   If        (o_qFile.name = '') and
     C                             (o_qFile.lib  = '') and
     C                             (o_mbr  = '')
     C                   Exsr      clrFileP
     C                   Leavesr
     C                   Endif
      *
      *  Prüfen Datei
      *  ------------
     C                   Callp     f_execute('CHKOBJ'           +
     C                                       ' OBJ('            +
     C                                       %trim(o_qFile.lib ) +
     C                                       '/'                +
     C                                       %trim(o_qFile.name) +
     C                                       ')'                +
     C                                       ' OBJTYPE('        +
     C                                       '*FILE'            +
     C                                       ')'                +
     C                                       ' MBR('            +
     C                                        '*NONE'           +
     C                                       ')'                +
     C                                       ' AUT('            +
     C                                       '*NONE'            +
     C                                       ')'                :
     C                                       yMsgID             :
     C                                       yMsgDta            )
      *
      *  Wenn die Datei nicht gefunden werden konnte, ...
     C                   If        (yMsgID = 'CPF9801')
      *  ... dann
      *      anlegen Datei
     C                   Callp     f_execute('CRTDUPOBJ'        +
     C                                       ' OBJ('            +
     C                                        'PEEKENV'         +
     C                                       ')'                +
     C                                       ' FROMLIB('        +
     C                                       %trim(§§PgmLib)    +
     C                                       ')'                +
     C                                       ' OBJTYPE('        +
     C                                       '*FILE'            +
     C                                       ')'                +
     C                                       ' TOLIB('          +
     C                                       %trim(o_qFile.lib ) +
     C                                       ')'                +
     C                                       ' NEWOBJ('         +
     C                                       %trim(o_qFile.name) +
     C                                       ')'                :
     C                                       yMsgID             :
     C                                       yMsgDta            )
      *
     C                   If        (yMsgID = '')
     C                   Callp     f_execute('RMVM'             +
     C                                       ' FILE('           +
     C                                       %trim(o_qFile.lib ) +
     C                                       '/'                +
     C                                       %trim(o_qFile.name) +
     C                                       ')'                +
     C                                       ' MBR('            +
     C                                        '*ALL'            +
     C                                       ')'                :
     C                                       yMsgID             :
     C                                       yMsgDta            )
      *
     C                   Eval      yMsgID  = ''
     C                   Eval      yMsgDta = ''
     C                   Endif
     C                   Endif
      *
     C                   If        (yMsgID <> '')
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   Eval      yMsgID = ''
     C                   Eval      yMsgDta = ''
     C                   Exsr      clrFileP
     C                   Leavesr
     C                   Endif
      *
      *  Prüfen Teildatei
      *  ----------------
     C                   Callp     f_execute('CHKOBJ'           +
     C                                       ' OBJ('            +
     C                                       %trim(o_qFile.lib ) +
     C                                       '/'                +
     C                                       %trim(o_qFile.name) +
     C                                       ')'                +
     C                                       ' OBJTYPE('        +
     C                                       '*FILE'            +
     C                                       ')'                +
     C                                       ' MBR('            +
     C                                       %trim(o_mbr  )      +
     C                                       ')'                +
     C                                       ' AUT('            +
     C                                       '*NONE'            +
     C                                       ')'                :
     C                                       yMsgID             :
     C                                       yMsgDta            )
      *
      *  Wenn die Teildatei nicht gefunden werden konnte, ...
     C                   If        (yMsgID = 'CPF9815')
      *  ... dann
      *      anlegen Teildatei
     C                   Callp     f_execute('ADDPFM'           +
     C                                       ' FILE('           +
     C                                       %trim(o_qFile.lib ) +
     C                                       '/'                +
     C                                       %trim(o_qFile.name) +
     C                                       ')'                +
     C                                       ' MBR('            +
     C                                       %trim(o_mbr )       +
     C                                       ')'                :
     C                                       yMsgID             :
     C                                       yMsgDta            )
     C                   Endif
      *
     C                   If        (yMsgID <> '')
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   Eval      yMsgID = ''
     C                   Eval      yMsgDta = ''
     C                   Exsr      clrFileP
     C                   Leavesr
     C                   Endif
      *
      *  Ändern Teildateitext
      *  --------------------
     C                   If        o_text <> ' '
     C                   Callp     f_execute('CHGPFM'           +
     C                                       ' FILE('           +
     C                                       %trim(o_qFile.lib ) +
     C                                       '/'                +
     C                                       %trim(o_qFile.name) +
     C                                       ')'                +
     C                                       ' MBR('            +
     C                                       %trim(o_mbr )       +
     C                                       ')'                +
     C                                       ' TEXT('''         +
     C                                       %trim(o_text)       +
     C                                       ''')'              :
     C                                       yMsgID             :
     C                                       yMsgDta            )
      *
     C                   If        (yMsgID <> '')
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   Eval      yMsgID = ''
     C                   Eval      yMsgDta = ''
     C                   Exsr      clrFileP
     C                   Leavesr
     C                   Endif
     C                   Endif
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
     C                   Eval      isSflError = f_isVldOpt(SFPAU  :
     C                                                     yMsgID :
     C                                                     yMsgDta)
     C                   IF        isSflError = bTrue
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   Eval      yMsgID = ''
     C                   Eval      yMsgDta = ''
     C                   EXSR      VSfpauErr
     C                   UPDATE    PBSfl
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
     C     Sfl_Cmd       WHENEQ    '*SLCENV'
     C                   EXSR      VPOS
     C     Sfl_Cmd       WHENEQ    '*SLCLAYOUT'
     C                   EXSR      VPOS
     C                   OTHER
      *  Unbekannter Programmbefehl
     C                   CLEAR                   USR8110
     C                   EVAL      USR81101 = YPgmCmd
     C                   Callp     p_sndPgmMg('USR8110': USR8110: §§pgmName)
     C                   EXSR      VSfpauErr
     C                   UPDATE    PBSfl
     C                   EVAL      IsSflError = bTrue
     C                   ITER
     C                   Endsl
      *
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
      * - Kontrollsatz füllen
     C                   EXSR      CTFILL
      *
      * - Subfile neu aufbauen
     C                   EXSR      PBInitKey
     C                   EXSR      PBInit
     C                   EXSR      PBSetLL
     C                   EXSR      PBReadUp
      *
     C                   EXSR      SrchInit
      *
     C                   Exsr      posCsr
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
     C                   If        i_mode = '*LOAD' and Sfl_Cmd = '*SLCLAYOUT'
     C                   Eval      rcdFmtID = f_loadRcdFmtID()
     C                   If        rcdFmtID <> '' and i_rcdFmtID <> rcdFmtID
     C                   Eval      isSflError = bTrue
     C                   Clear                   USR8233
     C                   Callp     p_sndPgmMg('USR8233': USR8233: §§pgmName)
     C                   Leavesr
     C                   Endif
     C                   Endif
      *
     C                   Eval      o_qFile.name = ##File
     C                   Eval      o_qFile.lib = ##Lib
     C                   Eval      o_mbr = $$MNME
     C                   Eval      o_text = $$MTXT
     C                   Eval      o_option = Sfl_Cmd
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
      *    clrIndCtl     Löschen Bezugszahlen Kontrollsatz         *
      *============================================================*
      *
     C     clrIndCtl     BEGSR
      *
     C                   EVAL      *IN20 = '0'                                  ##CTLAU.PC
     C                   EVAL      *IN30 = '0'                                  ##CTLAU.RI
      *
     C                   EVAL      *IN21 = '0'                                  ##MNME.PC
     C                   EVAL      *IN31 = '0'                                  ##MNME.RI
      *
     C                   EVAL      *IN22 = '0'                                  ##MTXT.PC
     C                   EVAL      *IN32 = '0'                                  ##MTXT.RI
      *
     C                   EVAL      *IN40 = '0'                                  ##FILE.PC
     C                   EVAL      *IN50 = '0'                                  ##FILE.RI
      *
     C                   EVAL      *IN41 = '0'                                  ##LIB.PC
     C                   EVAL      *IN51 = '0'                                  ##LIB.RI
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
     C                   If        (##File <> ' ') and
     C                             (##Lib  <> ' ')
      *
     C                   Eval      LastFile = ##File
     C                   Eval      LastLib  = ##Lib
      *
     C                   EVAL      YFile = ##File
     C                   EVAL      YLib = ##Lib
     C                   CALLP     PEEK46(YQFile: '*ALL':  '*CREATE'
     C                                    : numMbr: MBRL0200)
      *
     C                   Eval      SET_ENVFIL = ##File
     C                   Eval      SET_ENVLIB = ##Lib
      *
     C                   Else
     C                   Clear                   USR8181
     C                   Callp     p_sndPgmMg('USR8181': USR8181: §§pgmName)
     C                   Endif
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
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBReadUP      Vorwärts füllen der Subfile               *
      *============================================================*
      *
     C     PBReadUP      BEGSR
      *
     C     numMbr        DOWGT     *ZEROS
     C                   CALLP     PEEK46(YQFile: '*ALL':  '*READ'
     C                                    : numMbr: MBRL0200)
      *
     C                   EXSR      PBFill
      *
     C                   EVAL      SflRec = SflRec + 1
     C                   WRITE     PBSfl
     C                   EVAL      SflNbrRcd = SflRec
      *
     C     SFLRec        IFGE      SflPage
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBFill        Füllen Subfilesatz                        *
      *============================================================*
      *
     C     PBFill        BEGSR
      *
      *  ... Membername
     C                   EVAL      $$MNme = MBRL0200.M2MNme
      *  ... Memberbezeichnung
     C                   EVAL      $$MTxt = MBRL0200.M2MTxt
      *
      *  ... anzeigen Subfile
     C                   EVAL      *IN80 = '1'                                  SFLDSP
      *
      *  ... Löschen Subfileauswahl
     C                   EXSR      VSfpauClr
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSetLL       Setzen Dateizeiger                        *
      *============================================================*
      *
     C     PBSetLL       BEGSR
      *
     C                   ENDSR
      *
      *============================================================*
      *    CTFill        Füllen Kontrollsatz                       *
      *============================================================*
      *
     C     CTFill        BEGSR
      *
     C                   Eval      ##CTLAU = ' '
     C                   Eval      ##MNME  = ' '
     C                   Eval      ##MTXT  = ' '
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
     C                   EVAL      POS = 5
     C                   Endif
      *
     C                   EVAL      SflPage = 9999
     C                   EVAL      SflPageDDS = 6
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
      *============================================================*
      *
     C     GetUsrSetg    BEGSR
      *
      *  *ENVFILE
     C                   Eval      SET0015 = f_getUsrSg('*ENVFILE'  )
      *
     C                   ENDSR
      *
      *============================================================*
      *    SetUsrSetg    Speichern der Benutzervoreinstellungen    *
      *============================================================*
      *
     C     SetUsrSetg    BEGSR
      *
      *  *ENVFILE
     C                   If        isPrdLib = bTrue
     C                   Eval      SET_ENVLIB = '*PRDLIB'
     C                   Endif
     C                   Callp     p_updUsrSg('*ENVFILE': SET0015)
      *
     C                   ENDSR
      *
      *============================================================*
      *    clrFileP      Löschen Dateiangaben (Rückkehrwerte)      *
      *============================================================*
      *
     C     clrFileP      BEGSR
      *
     C                   EVAL      o_qFile.name = ''
     C                   EVAL      o_qFile.lib = ''
     C                   EVAL      o_mbr = ''
     C                   EVAL      o_text = ''
     C                   EVAL      o_option = ''
      *
     C                   ENDSR
      *
      *============================================================*
      *    posCrs        Positionieren Cursor                      *
      *============================================================*
      *
     C     posCsr        BEGSR
      *
     C                   If        *IN72 = '0'                                  Eingeblendet
     C                   Eval      *IN20 = *ON
     C                   Else
     C                   Eval      *IN20 = *OFF
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
      * - Einlesen Subfileauswahlen
     C                   Select
     C                   When      i_mode = '*SAVE'
     C                   Eval      YExclKeys(1) = '*SLCLAYOUT'
     C                   When      i_mode = '*DELETE'
     C                   Eval      YExclKeys(1) = '*SLCLAYOUT'
     C                   Other
      *           keine Ausschlüsse
     C                   Eval      YExclKeys(*) = ''
     C                   Endsl
      *
     C                   Callp     PEEK27(§§PgmName: YChoice: YNbrOfCh)
      *
      * - Öffnen Bildschirmdatei
     C                   If        workstn.open = '0'
     C                   OPEN      PEEK56FM
     C                   Endif
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EXSR      GetUsrSetg
      *
     C                   Select
     C                   When      i_envFile = '*NONE'
     C                   Eval      ##File = ' '
     C                   Other
     C                   Eval      ##File = i_envFile
     C                   Endsl
      *
     C                   Select
     C                   When      i_envLib = '*NONE'
     C                   Eval      ##Lib    = ' '
     C                   Eval      isPrdLib = bFalse
     C                   When      i_envLib = '*PRDLIB'
     C                   Eval      ##Lib    = §§PgmLib
     C                   Eval      isPrdLib = bTrue
     C                   Other
     C                   Eval      ##Lib    = i_envLib
     C                   Eval      isPrdLib = bFalse
     C                   Endsl
      *
     C                   If        (SET_ENVCHG =  bFalse )  or
     C                             (SET_ENVENA =  bFalse )
     C                   Eval      *IN71 = *ON
     C                   Else
     C                   Eval      *IN71 = *OFF
     C                   Endif
      *
     C                   If        i_mode = '*SAVE'
     C                   Eval      *IN72 = '0'                                  Einblenden
     C                   Else
     C                   Eval      *IN72 = '1'                                  Ausblenden
     C                   Endif
      *
      * - Rückkehrcode
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
     C                   Exsr      clrFileP
      *
      * - Darstellung der Subfile
     C                   EVAL      SflMde = '1'
      *
      * - Darstellung der Befehlstasten
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
     C                   Eval      PEEK21_NAME = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23_NAME = f_pgmCallN('PEEK23')
     C                   Eval      PEEK27_NAME = f_pgmCallN('PEEK27')
     C                   Eval      PEEK46_NAME = f_pgmCallN('PEEK46')
      *
     C                   Callp     PEEK23(§§PgmName: '*ALL': NbrFKeys
     C                                    : yFKeys: yNbrOfKeys)
     C                   Eval      ScrnFKeys = %subarr(YFKeys: 1)
      *
     C                   Endsr
      *
      *===================================================================*
      *  Prozedur:  f_isVldOpt                                 (Body)     *
      *===================================================================*
      *
     P f_isVldOpt      B
     D                 PI                         like(bool_t)
     D  i_option                                  like(SFPAU     )
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  Funktionswert ...
     D isError         S                   like(bool_t)
     D                                     inz(bFalse)
      *---------------------------------------------------*
      *
     C                   CALLP     PEEK21('#' + i_option: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C                   If        yMsgID <> ' '
      *  Fehlermeldung ...
     C                   Clear                   USR8110
     C                   Eval      USR81101 = i_option
     C                   Eval      o_msgID  = 'USR8110'
     C                   Eval      o_msgDta = USR8110
     C                   Eval      isError  = bTrue
     C                   Else
     C                   Eval      o_msgID  = ' '
     C                   Eval      o_msgDta = ' '
     C                   Eval      isError  = bFalse
     C                   Endif
      *
     C                   Return    isError
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_loadRcdFmtID                             (Body)     *
      *===================================================================*
     P f_loadRcdFmtID  B
     D                 PI                  like(fmtid_t)
      *
      *  definieren Arbeitsfelder ...
     D rcdFmtID        S                   like(fmtid_t)
      *
     C     en_key2       Klist
     C                   Kfld                    en_USER
     C                   Kfld                    en_SECTION
      *---------------------------------------------------*
      *
     C                   Eval      g_envFile = %trim(i_envLib) + '/' +
     C                                         %trim(i_envFile)
     C                   Eval      g_envMbr = $$MNme
     C                   Open(E)   PEEKENV
     C                   If        %error()
     C                   Return    ''
     C                   Endif
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*RCDFMTID'
     C     en_key2       Chain     FPEEKENV                           01
     C                   If        *IN01 = *ON
     C                   Return    ''
     C                   Endif
      *
     C                   Eval      rcdFmtID = en_data
      *
     C                   close     PEEKENV
      *
     C                   Return    rcdFmtID
     P                 E
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
