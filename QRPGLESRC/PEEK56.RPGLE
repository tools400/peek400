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
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEK56FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
     F                                     SFILE(PBSFL:SFLREC)
     F                                     INFSR(*PSSR)
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
      *----------------------------------------------------*
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
      *----------------------------------------------------*
      *  I N F D S - D E F I N I T I O N E N               *
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D XDsp80          S              1A
     D XCopyRight      S            512A
     D XMode           S             10A
      *
     D XEnvFile        S                   LIKE(R§FILE    )
     D XEnvLib         S                   LIKE(R§LIB     )
     D XEnvMbr         S                   LIKE(R§MBR     )
     D XRcdFmtID       S                   LIKE(R§FMTID   )
      *
     D XQFile          DS
     D  XFile                        10A
     D  XLib                         10A
     D XMbr            S             10A
     D xText           S             50A
     D xOption         S                   like(r§option  )
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
     D yPgm            S             10A   inz
     D yKey            S             10A   inz
     D yPosF24         S                   like(r§int4    ) inz
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(r§int4    ) inz
     D yExclKeys       S                   LIKE(r§pgmCmd  ) DIM(25)
     D yMsgID          S              7A   INZ(*BLANKS)
     D yMsgDta         S            512A   INZ(*BLANKS)
      *
      *  Peek46:
     D YQFile          DS
     D  YFile                        10A   INZ
     D  YLib                         10A   INZ
     D YMbr            S             10A   INZ
     D YFunk           S             10A   INZ
     D YAnzahl         S                   like(r§int4    ) inz
     D YList           S            512A   INZ
      *
     D YScnAID         S             10A   INZ(*BLANKS)
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(r§pgmCmdDt) INZ(*BLANKS)
      *
     D YChoice         S             75A   DIM(32)
     D YNbrOfCh        S                   like(r§int4    ) inz
      *
     D IsNewPos        S              1A   INZ(bFalse)
     D IsFound         S              1A   INZ(bFalse)
     D IsSflError      S              1A   INZ(bFalse)
     D IsCtlError      S              1A   INZ(bFalse)
     D IsDirty         S              1A   INZ(bFalse)
      *
     D SfTop           S                   like(r§int4    ) inz
     D SflPage         S                   like(r§int4    ) inz
     D SflPageDDS      S                   like(SflPage   ) inz
     D SflRec          S                   like(SflPage   ) inz
     D SflNbrRcd       S                   like(SflPage   ) inz
     D SfBot           S                   like(r§int4    ) inz
     D Sfl_Cmd         S             10A   INZ(*BLANKS)
     D Ctl_Cmd         S             10A   INZ(*BLANKS)
     D NbrFKeys        C                   CONST(3)
      *
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
     D PEEK27          S                   like(r§pgmCallN) inz
     D PEEK46          S                   like(r§pgmCallN) inz
      *
     D R_Mbr           S                   INZ(*BLANKS) LIKE(##Mbr  )
     D LstMbr          S                   INZ(*BLANKS) LIKE(##Mbr  )
     D LstNbrRcd       S                   INZ(0) LIKE(SflPage)
      *
     D Wrk_SFSANR      S                   INZ(*ZEROS ) LIKE(SFSANR )
      *
     D X               S                   like(r§int4    ) inz
      *
     D LastFile        S                   Like(##File    )                                  R
     D                                     Inz
     D LastLib         S                   Like(##Lib     )                                  R
     D                                     Inz
     D isPrdLib        S                   like(r§bool    )
     D                                     inz(bFalse)
      *
     D rcdFmtID        S                   like(r§fmtid)
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0015
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,F_PEEK53
      *
     D f_isVldOpt      PR                         like(r§bool    )
     D  i_option                                  like(SFPAU     )
     D  o_msgID                                   like(r§msgID   )
     D  o_msgDta                                  like(r§msgDta  )
      *
     D f_loadRcdFmtID...
     D                 PR                  like(r§fmtid)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     C     *ENTRY        PLIST
      *  Input parameters
     C                   PARM                    XDsp80
     C                   PARM                    XCopyRight
     C                   PARM                    XMode
     C                   PARM                    XEnvFile
     C                   PARM                    XEnvLib
     C                   PARM                    XEnvMbr
     C                   PARM                    XRcdFmtID
      *  Output parameters
     C                   PARM                    XQFile                         xFile/xLib
     C                   PARM                    XMbr
     C                   PARM                    XText
     C                   PARM                    XOption
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK23
     C     P_PEEK23      PLIST
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
     C     P_PEEK21a     PLIST
     C                   PARM                    YScnAID
     C                   PARM                    YPgm
     C                   PARM                    YPgmCmd
     C                   PARM                    YCmdDta
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
     C     P_PEEK21b     PLIST
     C                   PARM                    YScnAID
     C                   PARM                    YPgm
     C                   PARM                    YPgmCmd
     C                   PARM                    YCmdDta
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
     C                   PARM                    YExclKeys
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK27
     C     P_Peek27      PLIST
     C                   PARM                    YPgm
     C                   PARM                    YChoice
     C                   PARM                    YNbrOfCh
     C                   PARM                    YExclKeys
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK46
     C     P_PEEK46      PLIST
     C                   PARM                    YQFile
     C                   PARM                    YMbr
     C                   PARM                    YFunk
      *
     C                   PARM                    YAnzahl
     C                   PARM                    YList
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
      *  Prüfen Positionierung der Subfile
     C     SFSANR        IFLE      *ZEROS
     C                   Z-ADD     1             SFSANR
     C                   Endif
      *
      *  Nachrichten senden
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
      *  Modus: DROP/FOLD
     C                   MOVE      SFLMDE        *IN86
      *
      *  Nachrichten anzeigen
     C                   MOVE      '0'           *IN89
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
     C                   Z-ADD     1             SFTop
     C                   Endif
     C                   MOVEL (P) YChoice(SFTop)$$CHOICE
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
     C                   Z-ADD     1             SFBOT
     C                   Endsl
      *
      *  Anzeige der Subfile
     C                   EXFMT     PBCTL
     C                   MOVEL (P) '0'           *IN70
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Bezugszahlen löschen
     C                   EXSR      clrIndCtl
      *
      *  Aktuelle Satz-Nr.
     C     SFLCSR        IFGT      *ZEROS
     C                   Z-ADD     SFLCSR        SFSANR
     C                   Endif
      *
      *  Mappen der gedrückten Taste
      *  in Programmbefehl
     C                   MOVEL (P) §ScnAID       YScnAID
     C                   MOVEL (P) §§PgmName     YPgm
     C                   CALL      PEEK21        P_Peek21a
     C     YMsgID        IFNE      *BLANKS
     C                   MOVEL (P) YMsgID        §MsgID
     C                   MOVEL (P) YMsgDta       §MsgDta
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
     C     isCtlError    IFEQ      bFalse
     C                   EXSR      SetUsrSetg
     C                   ENDIF
     C     XMbr          IFEQ      *BLANKS
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
     C                   If        §open = '1'
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
     C                   Eval      xFile   = ##File
     C                   Eval      xLib    = ##Lib
     C                   Eval      xMbr    = ##MNME
     C                   Eval      xText   = ##MTXT
     C                   Eval      xOption = Ctl_Cmd
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
     C                   MOVEL (P) ##Mbr         LstMbr
     C                   MOVEL (P) *BLANKS       ##Mbr
     C                   Endif
      *
     C     LstMbr        IFEQ      *BLANKS
     C                   MOVEL (P) '1'           *IN70
     C                   CLEAR                   USR8209
     C                   MOVEL (P) 'USR8209'     §MsgID
     C                   MOVEL (P) USR8209       §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   EXSR      PosToMbr
     C     IsNewPos      IFEQ      bTrue
     C                   Z-ADD     Wrk_SFSANR    SFSANR
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
      ***  ##Mbr         IFEQ      R_Mbr
      ***                MOVEL (P) bFalse        IsNewPos
      ***                ELSE
      *
     C     LstMbr        IFNE      R_Mbr
     C                   Eval      LstNbrRcd = 0
     C                   Endif
      *
     C     LstMbr        IFEQ      *BLANKS
     C                   MOVEL (P) bFalse        IsNewPos
     C                   Eval      LstNbrRcd = 0
     C                   ELSE
      *
     C                   EXSR      SrchMbr
     C     IsFound       IFEQ      bFalse
     C                   MOVEL (P) bFalse        IsNewPos
     C                   CLEAR                   USR8180
     C                   MOVEL (P) 'USR8180'     §MsgID
     C                   MOVEL (P) LstMbr        USR81801                       MemberName
     C                   MOVEL (P) USR8180       §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   MOVEL (P) bTrue         IsNewPos
     C                   Endif
     C                   Endif
      *
     C                   MOVEL (P) LstMbr        R_Mbr
      ***                ENDIF
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
     C                   MOVEL (P) bFalse        IsFound
     C                   ELSE
      *
     C                   MOVEL (P) bFalse        IsFound
     C                   Eval      LstNbrRcd = LstNbrRcd + 1
      *
     C     LstNbrRcd     DO        SflNbrRcd     SflRec
     C     SflRec        CHAIN     PBSFL                              1111
     C     *IN11         IFEQ      '1'
     C                   MOVEL (P) bFalse        IsFound
     C                   LEAVE
     C                   Endif
      *
     C                   IF        LstMbr =
     C                             %subst($$MNME: 1:(f_scan(' ':
     C                                                      LstMbr) - 1))
     C                   MOVEL (P) bTrue         IsFound
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
     C                   Z-ADD     SflRec        Wrk_SFSANR
     C                   Eval      LstNbrRcd = SflRec
     C                   ELSE
     C                   Z-ADD     *ZEROS        Wrk_SFSANR
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
     C                   Eval      LstMbr    = ' '
     C                   Eval      LstNbrRcd = 0
     C                   Eval      R_Mbr     = LstMbr
      *
     C                   ENDSR
      *
      *============================================================*
      *    VCtl          Verarbeiten der Eingaben Kontrollsatz     *
      *============================================================*
      *
     C     VCtl          BEGSR
      *
     C                   Eval      ##File = %trim(##File)
     C                   Eval      ##Lib  = %trim(##Lib )
     C                   Eval      ##Mbr  = %trim(##Mbr )
      *
      * - Funktion nicht freigeschaltet
     C                   If        (##File = ' ') or
     C                             (##Lib  = ' ') or
     C                             (SET_ENVENA = bFalse)
     C                   Clear                   USR8184
     C                   Eval      §msgID  = 'USR8184'
     C                   Eval      §msgDta = USR8184
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
     C                   If        f_vldName(##File         :
     C                                       §msgID         :
     C                                       §msgDta        ) = bTrue
     C                   Eval      isCtlError = bFalse
     C                   Else
     C                   Eval      isCtlError = bTrue
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
     C                                       §msgID        :
     C                                       §msgDta       )
      *
     C                   If        §msgID <> ' '
     C                   Eval      isCtlError = bTrue
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
     C                   If        f_vldName(##Lib          :
     C                                       §msgID         :
     C                                       §msgDta        ) = bTrue
     C                   Eval      isCtlError = bFalse
     C                   Else
     C                   Eval      isCtlError = bTrue
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
     C                                       §msgID        :
     C                                       §msgDta       )
      *
     C                   If        §msgID <> ' '
     C                   Eval      isCtlError = bTrue
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
     C                   Eval      isCtlError = f_isVldOpt(##CTLAU:
     C                                                     §msgID :
     C                                                     §msgDta)
     C                   If        isCtlError = bTrue
     C                   Eval      Ctl_cmd = ' '
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
     C                   Eval      §msgID     = 'USR8110'
     C                   Eval      §msgDta    = USR8110
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
     C                   If        f_vldName(##MNME         :
     C                                       §msgID         :
     C                                       §msgDta        ) = bTrue
     C                   Eval      isCtlError = bFalse
     C                   Else
     C                   Eval      isCtlError = bTrue
     C                   Endif
     C
      *
     C                   If        §msgID = 'CPD0078'
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
     C                   If        (xFile = ' ') and
     C                             (xLib  = ' ') and
     C                             (xMbr  = ' ')
     C                   Goto      endChkFile
     C                   Endif
      *
      *  Prüfen Datei
      *  ------------
     C                   Callp     f_execute('CHKOBJ'      +
     C                                       ' OBJ('       +
     C                                       %trim(xLib )  +
     C                                       '/'           +
     C                                       %trim(xFile ) +
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
     C                                       §msgID        :
     C                                       §msgDta       )
      *
      *  Wenn die Datei nicht gefunden werden konnte, ...
     C                   If        §msgID = 'CPF9801'
      *  ... dann
      *      anlegen Datei
     C                   Callp     f_execute('CRTDUPOBJ'     +
     C                                       ' OBJ('         +
     C                                        'PEEKENV'      +
     C                                       ')'             +
     C                                       ' FROMLIB('     +
     C                                       %trim(§§PgmLib) +
     C                                       ')'             +
     C                                       ' OBJTYPE('     +
     C                                       '*FILE'         +
     C                                       ')'             +
     C                                       ' TOLIB('       +
     C                                       %trim(xLib )    +
     C                                       ')'             +
     C                                       ' NEWOBJ('      +
     C                                       %trim(xFile)    +
     C                                       ')'             :
     C                                       §msgID          :
     C                                       §msgDta         )
      *
     C                   If        §msgID = ' '
     C                   Callp     f_execute('RMVM'          +
     C                                       ' FILE('        +
     C                                       %trim(xLib )    +
     C                                       '/'             +
     C                                       %trim(xFile)    +
     C                                       ')'             +
     C                                       ' MBR('         +
     C                                        '*ALL'         +
     C                                       ')'             :
     C                                       §msgID          :
     C                                       §msgDta         )
      *
     C                   Eval      §msgID  = ' '
     C                   Eval      §msgDta = ' '
     C                   Endif
     C                   Endif
      *
     C                   If        §msgID <> ' '
     C                   Goto      endChkFile
     C                   Endif
      *
      *  Prüfen Teildatei
      *  ----------------
     C                   Callp     f_execute('CHKOBJ'      +
     C                                       ' OBJ('       +
     C                                       %trim(xLib )  +
     C                                       '/'           +
     C                                       %trim(xFile ) +
     C                                       ')'           +
     C                                       ' OBJTYPE('   +
     C                                       '*FILE'       +
     C                                       ')'           +
     C                                       ' MBR('       +
     C                                       %trim(xMbr  ) +
     C                                       ')'           +
     C                                       ' AUT('       +
     C                                       '*NONE'       +
     C                                       ')'           :
     C                                       §msgID        :
     C                                       §msgDta       )
      *
      *  Wenn die Teildatei nicht gefunden werden konnte, ...
     C                   If        §msgID = 'CPF9815'
      *  ... dann
      *      anlegen Teildatei
     C                   Callp     f_execute('ADDPFM'        +
     C                                       ' FILE('        +
     C                                       %trim(xLib )    +
     C                                       '/'             +
     C                                       %trim(xFile)    +
     C                                       ')'             +
     C                                       ' MBR('         +
     C                                       %trim(xMbr )    +
     C                                       ')'             :
     C                                       §msgID          :
     C                                       §msgDta         )
     C                   Endif
      *
     C                   If        §msgID <> ' '
     C                   Goto      endChkFile
     C                   Endif
      *
      *  Ändern Teildateitext
      *  --------------------
     C                   If        xText <> ' '
     C                   Callp     f_execute('CHGPFM'        +
     C                                       ' FILE('        +
     C                                       %trim(xLib )    +
     C                                       '/'             +
     C                                       %trim(xFile)    +
     C                                       ')'             +
     C                                       ' MBR('         +
     C                                       %trim(xMbr )    +
     C                                       ')'             +
     C                                       ' TEXT('''      +
     C                                       %trim(xText)    +
     C                                       ''')'           :
     C                                       §msgID          :
     C                                       §msgDta         )
      *
     C                   If        §msgID <> ' '
     C                   Goto      endChkFile
     C                   Endif
     C                   Endif
      *
     C     endChkFile    Tag
      *
     C                   If        §msgID <> ' '
     C                   Exsr      clrFileP
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
     C                   MOVEL (P) bFalse        IsSflError
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
     C                   Z-ADD     SflRec        SflCsr
     C                   ELSE
      *  Subfile nicht neu positionieren
     C                   Endif
      *
      *  Linksbündig setzen ...
     C     ' '           CHECK     SFPAU         X
     C     X             IFGE      1
     C                   SUBST (P) SFPAU:X       SFPAU
     C                   Endif
      *
      *  Zuordnung AUSWAHL => Befehl ...
     C                   Eval      isSflError = f_isVldOpt(SFPAU  :
     C                                                     §msgID :
     C                                                     §msgDta)
     C                   IF        isSflError = bTrue
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EXSR      VSfpauErr
     C                   UPDATE    PBSfl
     C                   ITER
     C                   Endif
      *
      *----------------------------*
      *  Ausführen SFL-Befehl ...  *
      *----------------------------*
     C                   MOVEL (P) YPgmCmd       Sfl_Cmd
      *
     C                   SELECT
     C     Sfl_Cmd       WHENEQ    '*NONE'
     C     Sfl_Cmd       WHENEQ    '*SLCENV'
     C                   EXSR      VPOS
     C     Sfl_Cmd       WHENEQ    '*SLCLAYOUT'
     C                   EXSR      VPOS
     C                   OTHER
      *  Unbekannter Programmbefehl
     C                   MOVEL (P) 'USR8110'     §MsgID
     C                   MOVEL (P) YPgmCmd       USR81101
     C                   MOVEL (P) USR8110       §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EXSR      VSfpauErr
     C                   UPDATE    PBSfl
     C                   MOVEL (P) bTrue         IsSflError
     C                   ITER
     C                   Endsl

     C                   IF        isSflError = bTrue
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EXSR      VSfpauErr
     C                   UPDATE    PBSfl
     C                   ITER
     C                   Else
     C                   LEAVE
     C                   Endif
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
     C                   MOVEL (P) 'USR8100'     XMsgID
     C                   MOVEL (P) YPgmCmd       USR81001
     C                   MOVEL (P) USR8100       XMsgDta
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
     C                   Z-ADD     1             SFSANR
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Bot         F18 - Ende der Subfile                    *
      *============================================================*
      *
     C     C_Bot         BEGSR
      *
     C                   Z-ADD     SflNbrRcd     SFSANR
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_MoreOpt     F23 - Weitere Auswahlen                   *
      *============================================================*
      *
     C     C_MoreOpt     BEGSR
      *
     C                   ADD       1             SFTop
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
      *    VPos          Verarbeiten der Eingaben                  *
      *============================================================*
      *
     C     VPos          BEGSR
      *
     C                   If        xMode = '*LOAD' and Sfl_Cmd = '*SLCLAYOUT'
     C                   Eval      rcdFmtID = f_loadRcdFmtID()
     C                   If        rcdFmtID <> '' and xRcdFmtID <> rcdFmtID
     C                   Eval      isSflError = bTrue
     C                   Clear                   USR8233
     C                   Eval      §msgid = 'USR8233'
     C                   Eval      §msgDta = USR8233
     C                   Leavesr
     C                   Endif
     C                   Endif
      *
     C                   Eval      xFile   = ##File
     C                   Eval      xLib    = ##Lib
     C                   Eval      xMbr    = $$MNME
     C                   Eval      xText   = $$MTXT
     C                   Eval      xOption = Sfl_Cmd
      *
     C                   ENDSR
      *
      *============================================================*
      *    VSfpauClr     Löschen Subfileauswahl                    *
      *============================================================*
      *
     C     VSfpauClr     BEGSR
      *
     C                   MOVEL (P) *BLANKS       SFPAU
     C                   MOVEL (P) '0'           *IN85                          DSPATR(RI)
     C                   MOVEL (P) '0'           *IN84                          SFLNXTCHG
      *
     C                   ENDSR
      *
      *============================================================*
      *    clrIndCtl     Löschen Bezugszahlen Kontrollsatz         *
      *============================================================*
      *
     C     clrIndCtl     BEGSR
      *
     C                   MOVEL (P) '0'           *IN20                          ##CTLAU.PC
     C                   MOVEL (P) '0'           *IN30                          ##CTLAU.RI
      *
     C                   MOVEL (P) '0'           *IN21                          ##MNME.PC
     C                   MOVEL (P) '0'           *IN31                          ##MNME.RI
      *
     C                   MOVEL (P) '0'           *IN22                          ##MTXT.PC
     C                   MOVEL (P) '0'           *IN32                          ##MTXT.RI
      *
     C                   MOVEL (P) '0'           *IN40                          ##FILE.PC
     C                   MOVEL (P) '0'           *IN50                          ##FILE.RI
      *
     C                   MOVEL (P) '0'           *IN41                          ##LIB.PC
     C                   MOVEL (P) '0'           *IN51                          ##LIB.RI
      *
     C                   ENDSR
      *
      *============================================================*
      *    VSfpauErr     Anzeigen fehlerhafter Subfileauswahl      *
      *============================================================*
      *
     C     VSfpauErr     BEGSR
      *
     C                   MOVEL (P) '1'           *IN85                          DSPATR(RI)
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
     C                   MOVEL (P) '1'           *IN84                          SFLNXTCHG
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
     C                   MOVEL (P) ##File        YFile
     C                   MOVEL (P) ##Lib         YLib
     C                   MOVEL (P) '*ALL'        YMbr
     C                   MOVEL (P) '*CREATE'     YFunk
     C                   CALL      PEEK46        P_PEEK46
      *
     C                   Eval      SET_ENVFIL = ##File
     C                   Eval      SET_ENVLIB = ##Lib
      *
     C                   Else
     C                   Clear                   USR8181
     C                   Eval      §msgID  = 'USR8181'
     C                   Eval      §msgDta = USR8181
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
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
     C                   MOVEL (P) '0'           *IN89
     C                   WRITE     MSGCTL
      *
     C                   MOVEL (P) '0'           *IN80                          SFLDSP
     C                   MOVEL (P) '1'           *IN81                          SFLDSPCTL
     C                   MOVEL (P) '1'           *IN82                          SFLCLR
     C                   MOVEL (P) '1'           *IN83                          SFLEND
     C                   WRITE     PBCTL
      *
     C                   MOVEL (P) '0'           *IN82                          SFLCLR
      *
     C                   Z-ADD     *ZEROS        SFLREC
     C                   Z-ADD     *ZEROS        SflNbrRcd
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBReadUP      Vorwärts füllen der Subfile               *
      *============================================================*
      *
     C     PBReadUP      BEGSR
      *
     C     YAnzahl       DOWGT     *ZEROS
     C                   MOVEL (P) '*READ'       YFunk
     C                   CALL      PEEK46        P_PEEK46
      *
     C                   EXSR      PBFill
      *
     C                   ADD       1             SflRec
     C                   WRITE     PBSfl
     C                   Z-ADD     SflRec        SflNbrRcd
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
     C                   MOVEL (P) YList         MBRL0200
      *  ... Membername
     C                   MOVEL (P) M2MNme        $$MNme
      *  ... Memberbezeichnung
     C                   MOVEL (P) M2MTxt        $$MTxt
      *
      *  ... anzeigen Subfile
     C                   MOVEL (P) '1'           *IN80                          SFLDSP
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
     C     XDsp80        IFEQ      '0'
      *   132-Zeichen Anzeige
     C                   MOVEL (P) '0'           *IN88
     C                   Z-ADD     2             ZEI
     C                   Z-ADD     26            POS
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   MOVEL (P) '1'           *IN88
     C                   Z-ADD     2             ZEI
     C                   Z-ADD     5             POS
     C                   Endif
      *
     C                   Z-ADD     9999          SflPage
     C                   Z-ADD     6             SflPageDDS
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
     C                   MOVEL (P) *BLANKS       XFile
     C                   MOVEL (P) *BLANKS       XLib
     C                   MOVEL (P) *BLANKS       XMbr
     C                   MOVEL (P) *BLANKS       xText
     C                   MOVEL (P) *BLANKS       xOption
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
     C                   When      xMode = '*SAVE'
     C                   Eval      YExclKeys(1) = '*SLCLAYOUT'
     C                   When      xMode = '*DELETE'
     C                   Eval      YExclKeys(1) = '*SLCLAYOUT'
     C                   Other
      *           keine Ausschlüsse
     C                   Movea     *BLANKS       YExclKeys
     C                   Endsl
      *
     C                   Eval      yPgm    = §§PgmName
     C                   Call      PEEK27        P_Peek27
      *
      * - Öffnen Bildschirmdatei
     C                   If        §open = '0'
     C                   OPEN      PEEK56FM
     C                   Endif
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EXSR      GetUsrSetg
      *
     C                   Select
     C                   When      xEnvFile = '*NONE'
     C                   Eval      ##File = ' '
     C                   Other
     C                   Eval      ##File = xEnvFile
     C                   Endsl
      *
     C                   Select
     C                   When      xEnvLib = '*NONE'
     C                   Eval      ##Lib    = ' '
     C                   Eval      isPrdLib = bFalse
     C                   When      xEnvLib = '*PRDLIB'
     C                   Eval      ##Lib    = §§PgmLib
     C                   Eval      isPrdLib = bTrue
     C                   Other
     C                   Eval      ##Lib    = xEnvLib
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
     C                   If        xMode = '*SAVE'
     C                   Eval      *IN72 = '0'                                  Einblenden
     C                   Else
     C                   Eval      *IN72 = '1'                                  Ausblenden
     C                   Endif
      *
      * - Rückkehrcode
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
     C                   Exsr      clrFileP
      *
      * - Darstellung der Subfile
     C                   MOVEL (P) '1'           SflMde
      *
      * - Darstellung der Befehlstasten
     C                   Z-ADD     1             SFTop
     C                   Z-ADD     1             SfBot
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   EXSR      SetScreen
      *
      * - Anzuzeigender Subfilesatz
     C                   Z-ADD     1             SFSANR
      *
      * - Subfile füllen
     C                   EXSR      C_Refresh
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
     C                   Eval      PEEK27 = f_pgmCallN('PEEK27')
     C                   Eval      PEEK46 = f_pgmCallN('PEEK46')
      *
     C                   Eval      yPgm    = §§PgmName
     C                   Eval      yKey    = '*ALL'
     C                   Eval      yPosF24 = NbrFKeys
     C                   Call      PEEK23        P_Peek23
     C                   Movea (P) yFKeys        ScrnFKeys
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
      ***/COPY QCOPYLE,MSG_C_MAPI
      *----------------------------------------------------*
      *
      *===================================================================*
      *  Prozedur:  f_isVldOpt                                 (Body)     *
      *===================================================================*
      *
     P f_isVldOpt      B
      *
     D f_isVldOpt      PI                         like(r§bool    )
     D  i_option                                  like(SFPAU     )
     D  o_msgID                                   like(r§msgID   )
     D  o_msgDta                                  like(r§msgDta  )
      *
      *  Funktionswert ...
     D isError         S                   like(r§bool    )
     D                                     inz(bFalse)
      *---------------------------------------------------*
      *
     C     '#'           CAT   (P) i_option:0    yScnAid
     C                   MOVEL (P) §§PgmName     yPgm
     C                   CALL      PEEK21        P_Peek21b
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
     P f_isVldOpt      E
      *
      *===================================================================*
      *  Prozedur:  f_loadRcdFmtID                             (Body)     *
      *===================================================================*
     P f_loadRcdFmtID  B
     D                 PI                  like(r§fmtid)
      *
      *  definieren Arbeitsfelder ...
     D rcdFmtID        S                   like(r§fmtid)
      *
     C     en_key2       Klist
     C                   Kfld                    en_USER
     C                   Kfld                    en_SECTION
      *---------------------------------------------------*
      *
     C                   Eval      g_envFile = %trim(xEnvLib) + '/' +
     C                                         %trim(xEnvFile)
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
