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
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEK40FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
     F                                     SFILE(PBSFL:SFLREC)
     F                                     INFSR(*PSSR)
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
      /COPY QCOPYLE,FILD0100
      /COPY QCOPYLE,DBRL0200
      /COPY QCOPYLE,KEYL0100
      /COPY QCOPYLE,SELL0100
      *----------------------------------------------------*
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
     D XDsp80          S              1A
     D XCopyRight      S            512A
     D XFile           S             10A
     D XLib            S             10A
     D XMbr            S             10A
     D XFmtName        S             10A
     D XBasePhyF       S              1A
     D XRetFile        S             10A
     D XRetLib         S             10A
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
     D YChoice         S             75A   DIM(32)
     D YNbrOfCh        S                   like(r§int4    ) inz
      *
     D YScnAID         S             10A   INZ(*BLANKS)
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(r§pgmCmdDt) INZ(*BLANKS)
      *
     D                 DS
     D YQFile                        20A   INZ(*BLANKS)
     D  YFile                        10A   OVERLAY(YQFile: 1)
     D  YLib                         10A   OVERLAY(YQFile:11)
     D YMbr            S             10A   INZ(*BLANKS)
     D YRcdFormat      S             10A   INZ(*BLANKS)
     D YFunction       S             10A   INZ(*BLANKS)
     D YNbrOfEnt       S                   like(r§int4    ) inz
     D YData           S            512A   INZ(*BLANKS)
      *
     D IsNewPos        S              1A   INZ(bFalse)
     D IsFound         S              1A   INZ(bFalse)
     D IsSflError      S              1A   INZ(bFalse)
      *
     D NbrOfRel        S                   like(r§int4    ) inz
     D NbrOfKey        S                   like(r§int4    ) inz
     D NbrOfSel        S                   like(r§int4    ) inz
      *
     D SflPage         S                   like(r§int4    ) inz
     D SfTop           S                   like(r§int4    ) inz
     D SflPageDDS      S                   INZ(0) LIKE(SflPage)
     D SflRec          S                   INZ(0) LIKE(SflPage)
     D SflNbrRcd       S                   INZ(0) LIKE(SflPage)
     D SfBot           S                   like(r§int4    ) inz
     D NbrFKeys        C                   CONST(2)
     D Sfl_Cmd         S             10A   INZ(*BLANKS)
      *
     D §UNIQUE         C                   CONST('*UNIQUE')
     D §CONSTR         C                   CONST('*CST')
      *
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
     D PEEK27          S                   like(r§pgmCallN) inz
     D PEEK39          S                   like(r§pgmCallN) inz
     D PEEK41          S                   like(r§pgmCallN) inz
      *
     D R_File          S                   INZ(*BLANKS) LIKE(##File )
     D LstFile         S                   INZ(*BLANKS) LIKE(##File )
     D LstNbrRcd       S                   INZ(0) LIKE(SflPage)
     D sPos            S                   like(r§int4    ) inz
      *
     D Wrk_SFSANR      S                   INZ(*ZEROS ) LIKE(SFSANR )
      *
     D X               S                   like(r§int4    ) inz
      *
     D                 DS
     D  BufferTb               1   2000A   INZ(*BLANKS)  DIM(2000)
     D  Buffer                 1   2000A
      *
     D strPos          S                   LIKE(r§uint4 ) inz
      *
     D PFile           S                   INZ(*BLANKS)  LIKE(XFile)
     D PLib            S                   INZ(*BLANKS)  LIKE(XLib )
     D PMbr            S                   INZ(*BLANKS)  LIKE(XMbr )
     D PFmtName        S                   INZ(*BLANKS)  LIKE(XFmtName)
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
     C                   PARM                    XFile
     C                   PARM                    XLib
     C                   PARM                    XMbr
     C                   PARM                    XFmtName
     C                   PARM                    XBasePhyF
     C                   PARM                    XRetFile
     C                   PARM                    XRetLib
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
      *  Parameterliste für PEEK27
     C     P_Peek27      PLIST
     C                   PARM                    YPgm
     C                   PARM                    YChoice
     C                   PARM                    YNbrOfCh
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK39
     C     P_Peek39      PLIST
     C                   PARM                    YQFile
     C                   PARM                    YMbr
     C                   PARM                    YFunction
     C                   PARM                    YNbrOfEnt
     C                   PARM                    YData
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK41
     C     P_Peek41      PLIST
     C                   PARM                    YQFile
     C                   PARM                    YRcdFormat
     C                   PARM                    YFunction
     C                   PARM                    YNbrOfEnt
     C                   PARM                    YData
      *
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
     C     XMsgID        IFNE      *BLANKS
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
      *  Aktuelle Satz-Nr.
     C     SFLCSR        IFGT      *ZEROS
     C                   Z-ADD     SFLCSR        SFSANR
     C                   Endif
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
     C     XRetFile      IFEQ      *BLANKS
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
     C                   MOVEL (P) ##File        LstFile
     C                   MOVEL (P) *BLANKS       ##File
     C                   Endif
      *
     C     LstFile       IFEQ      *BLANKS
     C                   MOVEL (P) '1'           *IN70
     C                   CLEAR                   USR8209
     C                   MOVEL (P) 'USR8209'     §MsgID
     C                   MOVEL (P) USR8209       §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   EXSR      PosToField
     C     IsNewPos      IFEQ      bTrue
     C                   Z-ADD     Wrk_SFSANR    SFSANR
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
 B01  ***  ##File        IFEQ      R_File
      ***                MOVEL (P) bFalse        IsNewPos
 X01  ***                ELSE
      *
     C     LstFile       IFNE      R_File
     C                   Eval      LstNbrRcd = 0
     C                   Endif
      *
     C     LstFile       IFEQ      *BLANKS
     C                   MOVEL (P) bFalse        IsNewPos
     C                   Eval      LstNbrRcd = 0
     C                   ELSE
      *
     C                   EXSR      SrchField
     C     IsFound       IFEQ      bFalse
     C                   MOVEL (P) bFalse        IsNewPos
     C                   CLEAR                   USR8136
     C                   MOVEL (P) 'USR8136'     §MsgID
     C                   MOVEL (P) ##File        USR81361                       Feldname
     C                   MOVEL (P) USR8136       §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   MOVEL (P) bTrue         IsNewPos
     C                   Endif
     C                   Endif
      *
     C                   MOVEL (P) LstFile       R_File
 E01  ***                ENDIF
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
      *
     C                   EXSR      BzToSubF
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
     C                   EXSR      BzToScreen
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
     C     '#'           CAT   (P) SFPAU:0       YScnAID
     C                   MOVEL (P) §§PgmName     YPgm
     C                   CALL      PEEK21        P_Peek21
     C     YMsgID        IFNE      *BLANKS
      *  Fehlermeldung ...
     C                   MOVEL (P) 'USR8110'     §MsgID
     C                   MOVEL (P) SFPAU         §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EXSR      VSfpauErr
      *
     C                   EXSR      BzToSubf
     C                   UPDATE    PBSfl
     C                   MOVEL (P) bTrue         IsSflError
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
     C     Sfl_Cmd       WHENEQ    '*SELECT'
     C                   EXSR      VPOS
     C                   LEAVE
     C                   OTHER
      *  Unbekannter Programmbefehl
     C                   MOVEL (P) 'USR8110'     §MsgID
     C                   MOVEL (P) YPgmCmd       USR81101
     C                   MOVEL (P) USR8110       §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EXSR      VSfpauErr
      *
     C                   EXSR      BzToSubf
     C                   UPDATE    PBSfl
     C                   MOVEL (P) bTrue         IsSflError
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
     C                   MOVEL (P) H$File        XRetFile
     C                   MOVEL (P) H$Lib         XRetLib
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
     C                   Z-ADD     *ZEROS        $$DepFile
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBReadUP      Vorwärts füllen der Subfile               *
      *============================================================*
      *
     C     PBReadUP      BEGSR
      *
     C     1             DO        NbrOfRel
      *
     C                   MOVEL (P) '*READ'       YFunction
     C                   CALL      PEEK39        P_Peek39
      *
      *  Daten in lesbare Struktur umsetzen ...
     C                   MOVEL (P) YData         DBRL0200
      *
     C     B2DepFile     IFEQ      '*NONE'
     C                   ITER
     C                   Endif
      *
     C     B2DepType     IFNE      'D'
     C                   ITER
     C                   Endif
      *
     C                   ADD       1             $$DepFile
      *
      *  Bei erstem Datensatz, ...
     C     *IN80         IFEQ      '0'
      *  ... die physische Datei anzeigen
     C                   MOVEL (P) B2FNmeUsed    H$File
     C                   MOVEL (P) B2LNmeUsed    H$Lib
      ***                EXSR      StatMsg
     C                   EXSR      PBFill
     C                   EXSR      PBFillKey
     C                   EXSR      PBFillSel
     C                   Endif
      *
      *  Anzeigen der logischen Sichten
     C                   MOVEL (P) B2DepFile     H$File
     C                   MOVEL (P) B2DepLib      H$Lib
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
     C                   MOVEL (P) xFile         H$File
     C                   MOVEL (P) xLib          H$Lib
     C                   MOVEL (P) xLib          B2LNmeUsed
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
     C                   MOVEL (P) §IN20         *IN20
     C                   MOVEL (P) §IN71         *IN71
      *
     C                   ENDSR
      *
      *============================================================*
      *    BzToSubf      Übertragen Bezugszahlen in Subfile        *
      *============================================================*
      *
     C     BzToSubf      BEGSR
      *
     C                   MOVEL (P) *IN20         §IN20
     C                   MOVEL (P) *IN71         §IN71
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
     C                   MOVEL (P) '0'           *IN71
      *
      *  Abhängigkeit prüfen ...
     C     B2LNmeUsed    IFEQ      H$Lib
     C     *IN80         OREQ      '0'
     C                   MOVEL (P) '0'           *IN20
     C                   ELSE
     C                   MOVEL (P) '1'           *IN20
     C                   Endif
      *
      *  Einlesen der Dateiinformationen ...
     C                   MOVEL (P) H$File        YFile
     C                   MOVEL (P) H$Lib         YLib
     C                   MOVEL (P) '*FIRST'      YRcdFormat
     C                   MOVEL (P) '*CREATE'     YFunction
     C                   CALL      PEEK41        P_Peek41
      *  ... Bezeichnung
     C                   MOVEL (P) '*READTEXT'   YFunction
     C                   CALL      PEEK41        P_Peek41
     C                   MOVEL (P) YData         $$FTXT
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
     C                   MOVEL (P) '1'           *IN71
      *
      *  Einlesen der Schlüsselinformationen ...
     C                   MOVEL (P) '*KEY'        YFunction
     C                   CALL      PEEK41        P_Peek41
     C                   Z-ADD     YNbrOfEnt     NbrOfKey
      *
     C                   MOVEL (P) *BLANKS       Buffer
      *
     C     1             DO        NbrOfKey
     C                   MOVEL (P) '*READKEY'    YFunction
     C                   CALL      PEEK41        P_Peek41
     C                   MOVEL (P) YData         KEYL0100
      *
     C     APKSEQ        IFEQ      'D'
     C                   CAT       §White:0      Buffer
     C                   ELSE
     C                   CAT       §Green:0      Buffer
     C                   Endif
      *
     C                   CAT       APKEYF:0      Buffer
     C                   Enddo
      *
     C     NbrOfKey      IFGE      1
     C     APUNIQ        ANDEQ     'Y'
     C                   CAT       §White:0      Buffer
     C                   CAT       §UNIQUE:0     Buffer
     C                   Endif
      *
     C                   SELECT
     C     B2DepType     WHENEQ    'C'
     C                   CAT       §White:0      Buffer
     C                   CAT       §CONSTR:0     Buffer
     C                   OTHER
     C                   Endsl
      *
     C                   CAT       §Green:0      Buffer
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
     C                   MOVEL (P) '1'           *IN71
      *
      *  Einlesen der Select/Omit Informationen ...
     C                   MOVEL (P) '*SELECT'     YFunction
     C                   CALL      PEEK41        P_Peek41
     C                   Z-ADD     YNbrOfEnt     NbrOfSel
      *
     C     1             DO        NbrOfSel
     C                   MOVEL (P) '*READSEL'    YFunction
     C                   CALL      PEEK41        P_Peek41
     C                   MOVEL (P) YData         SELL0100
      *
      *  Wenn das Ende der Liste rreicht ist, ...
     C     SOCOMP        IFEQ      'AL'
      *  ... dann den Eintrag überlesen
     C                   ELSE
      *  ... ansonsten den Eintrag aufbereiten und anzeigen
     C                   SELECT
     C     SORULE        WHENEQ    'S'
     C                   MOVEL (P) §White        Buffer
     C                   CAT       '*SELECT':0   Buffer
     C     SORULE        WHENEQ    'O'
     C                   MOVEL (P) §White        Buffer
     C                   CAT       '*OMIT':0     Buffer
     C                   OTHER
     C                   MOVEL (P) §White        Buffer
     C                   Endsl
      *
     C                   MOVEA     SOFLD         BufferTb(10)
     C                   MOVEA     SOCOMP        BufferTb(21)
     C                   CAT       SOVALU:1      Buffer
     C                   CAT       §Green:0      Buffer
     C                   MOVEL (P) Buffer        $$FTXT
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
     C                   MOVEL (P) *BLANKS       $$File
     C                   MOVEL (P) *BLANKS       $$Lib
     C                   ELSE
      *  Bei erstem Datensatz, ...
     C     *IN80         IFEQ      '0'
     C                   MOVEL (P) H$File        $$File
     C                   MOVEL (P) H$Lib         $$Lib
     C                   ELSE
     C     ' '           CAT   (P) H$File:1      $$File
     C                   MOVEL (P) H$Lib         $$Lib
     C                   Endif
     C                   Endif
      *
      *  Anzeigen der Subfile ...
     C                   MOVEL (P) '1'           *IN80
      *
      *  Löschen Subfileauswahl ...
     C                   EXSR      VSfpauClr
      *
      *  Schreiben des Subfilesatzes ...
     C                   ADD       1             SflRec
     C                   EXSR      BzToSubf
     C                   WRITE     PBSfl
     C                   Z-ADD     SflRec        SflNbrRcd
      *
     C     H$File        IFEQ      XFile
     C     H$Lib         ANDEQ     XLib
     C     *IN71         ANDEQ     '0'
     C                   Z-ADD     SflRec        SFSANR
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
     C                   MOVEL (P) PFile         YFile
     C                   MOVEL (P) PLib          YLib
     C                   MOVEL (P) PMbr          YMbr
     C                   MOVEL (P) '*CREATE'     YFunction
     C                   CALL      PEEK39        P_Peek39
      *
     C                   Z-ADD     YNbrOfEnt     NbrOfRel
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
     C                   Z-ADD     2             POS
     C                   Endif
      *
     C                   Z-ADD     *HIVAL        SflPage
     C                   Z-ADD     6             SflPageDDS
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
     C                   MOVEL (P) *BLANKS       ##File
     C                   MOVEL (P) ##File        R_File
      *
      * - Rückkehrcode
     C                   MOVEL (P) *BLANKS       XRetFile
     C                   MOVEL (P) *BLANKS       XRetLib
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
      * - Dateityp feststellen
     C                   MOVEL (P) XFile         PFile
     C                   MOVEL (P) XLib          PLib
     C                   MOVEL (P) XMbr          PMbr
     C                   MOVEL (P) XFmtName      PFmtName
      *
      *   ... Einlesen der Dateiinformationen
     C                   MOVEL (P) PFile         YFile
     C                   MOVEL (P) PLib          YLib
     C                   MOVEL (P) PFmtName      YRcdFormat
     C                   MOVEL (P) '*CREATE'     YFunction
     C                   CALL      PEEK41        P_Peek41
      *
     C     YNbrOfEnt     IFEQ      *ZEROS
      *       ... Fehler
     C                   MOVEL (P) 'USR0008'     XMsgID
     C                   CLEAR                   USR0008
     C                   MOVEL (P) YFile         USR00081
     C                   MOVEL (P) YLib          USR00082
     C                   MOVEL (P) USR0008       XMsgDta
     C                   ELSE
      *       ... kein Fehler
     C                   MOVEL (P) YData         FILD0100
     C     ATFILA        IFEQ      '*LGL'
      *           ... logical file
     C                   MOVEL (P) '*BASED-ON'   YFunction
     C                   CALL      PEEK41        P_Peek41
     C     YNbrOfEnt     IFEQ      *ZEROS
      *               ... Fehler
     C                   MOVEL (P) YFile         USR00081
     C                   MOVEL (P) YLib          USR00082
     C                   MOVEL (P) USR0008       XMsgDta
     C                   ELSE
     C     XBasePhyF     IFEQ      bTrue
      *                   ... based-on
     C     10            SUBST     YData:1       PFile
     C     10            SUBST     YData:11      PLib
     C                   MOVEL (P) '*FIRST'      PMbr
     C                   ELSE
      *               ... no based-on
     C                   Endif
     C                   Endif
     C                   ELSE
      *           ... physical file
     C                   Endif
     C                   Endif
      *
     C     XMsgID        IFNE      *BLANKS
      *   ... Fehler
     C                   ELSE
      *
      * - Darstellung der Subfile
     C                   MOVEL (P) '1'           SflMde
      *
      * -  Darstellung der Auswahlen/Funktionstasten
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
     C                   Endif
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
     C                   Eval      PEEK39 = f_pgmCallN('PEEK39')
     C                   Eval      PEEK41 = f_pgmCallN('PEEK41')
      *
     C                   Eval      yPgm    = §§PgmName
     C                   Eval      yKey    = '*ALL'
      ***                Eval      yPosF24 = NbrFKeys
     C                   Eval      yPosF24 = *ZEROS
     C                   Call      PEEK23        P_Peek23
     C                   Movea (P) yFKeys        ScrnFKeys
      *
     C                   Eval      yPgm    = §§PgmName
     C                   Call      PEEK27        P_Peek27
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
