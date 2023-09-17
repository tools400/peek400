      *===============================================================*
      *  (C) Thomas Raddatz                                           *
      *  Bereich  : PEEK Version 3.5.0                                *
      *  Typ      : PGM                                               *
      *===============================================================*
      *  Kurzdokumentation :                                          *
      *  Peek/400 - RPG-LE Programm, Template v3.5.0                  *
      *===============================================================*
     H DEBUG
     H ALWNULL(*USRCTL)
     H OPTION(*SRCSTMT : *NODEBUGIO)
      *
      *====================================================*
      *  Dateiliste                                        *
      *====================================================*
     FDSPF      CF   E             WORKSTN usropn
     F                                     infds(workStn)
     F                                     infsr(*pssr)
      *
     FFILE00    UF A E             DISK    usropn
      *  Eintragen Satzformatname
FMT1-F                                     rename(X________X:FFILE00)
     F                                     infsr(*pssr)
     F                                     infds(rcdFile00)
     F                                     commit(xCommitLVL)
      *
     FPEEKFLD   IF   E           K DISK    usropn
     F                                     infsr(*pssr)
     F                                     prefix(F_)
      *
     D rcdFile00       DS                  qualified
     D  rcdLength            283    286I 0
     D  number               397    400I 0
      *
      *====================================================*
      *  Referenzfelder & Konstanten                       *
      *====================================================*
      *
      *  Referenzfelder:
     D r_accMode       S              1A   based(ptrDummy)
     D r_bool          S              1A   based(ptrDummy)
     D r_copyRght      S                   like(r_msgDta  )
     D                                     based(ptrDummy)
     D r_dsp80         S                   like(r_bool    )
     D                                     based(ptrDummy)
     D r_type          S             10A   based(ptrDummy)
     D r_keys          S              3A   based(ptrDummy)
     D r_fieldNme      S             10A   based(ptrDummy)
     D r_file          S             10A   based(ptrDummy)
     D r_fKeyDsp       S             18A   based(ptrDummy)
     D r_FLDL0100      S            532A   based(ptrDummy)
     D r_headTyp       S             10A   based(ptrDummy)
     D r_hexBuf        S          65532A   based(ptrDummy)
     D cHexBufLen      C                   const(65532)
     D r_keyBuf        S           2000A   based(ptrDummy)
     D cKeyBufLen      C                   const(2000)
     D r_lib           S             10A   based(ptrDummy)
     D r_mbr           S             10A   based(ptrDummy)
     D r_mod           S             10A   based(ptrDummy)
     D r_msgDta        S            512A   based(ptrDummy)
     D r_msgID         S              7A   based(ptrDummy)
     D r_msgType       S             10A   based(ptrDummy)
     D r_pgm           S             10A   based(ptrDummy)
     D r_pgmCallN      S             21A   based(ptrDummy)
     D r_pgmCmd        S             10A   based(ptrDummy)
     D r_pgmCmdDt      S            256A   based(ptrDummy)
     D r_proc          S            256A   based(ptrDummy)
     D r_rcdBuf        S          32766A   based(ptrDummy)
     D cRcdBufLen      C                   const(32766)
     D r_rcdNbr        S             10I 0 based(ptrDummy)
     D r_scnAid        S             10A   based(ptrDummy)
     D r_sqlStmt       S           2000A   based(ptrDummy)
     D r_user          S             10A   based(ptrDummy)
      *
      *  Integer & Binärwerte:
     D r_int4          S             10I 0 based(ptrDummy)
      *
      *  Feedback Code:
     D r_fc            S             12A   based(ptrDummy)
      *
      *  Accessmode:
     D cRrnSeq         C                   CONST('0')
     D cKeySeq         C                   CONST('1')
     D cSqlSeq         C                   CONST('2')
      *
      *  Boolsche Werte:
     D*bTrue           C                   CONST('1')
     D*bFalse          C                   CONST('0')
     D*bNotDef         C                   CONST('-')
      *
      *  Zustellarten von Nachrichten:
     D cTypInfo        C                   CONST('*INFO')
     D cTypInq         C                   CONST('*INQ')
     D cTypRqs         C                   CONST('*RQS')
     D cTypComp        C                   CONST('*COMP')
     D cTypDiag        C                   CONST('*DIAG')
     D cTypNotify      C                   CONST('*NOTIFY')
     D cTypEscape      C                   CONST('*ESCAPE')
     D cTypStatus      C                   CONST('*STATUS')
      *
      *  Ausgewählter Editor:
     D Editor          S             10A   inz
     D cEDITOR_HEX     C                   const('*HEX')
     D cEDITOR_STRING  C                   const('*STRING')
      *
      *  OVRDBF/OVRDSPF:
     D o_FILE          S             10A   inz
     D o_IN99          S              1A   inz
     D o_LVLCHK        S             10A   inz
     D o_MBR           S             10A   inz
     D o_OVRSCOPE      S             10A   inz
     D o_QCMD          S            256A   inz
     D o_RETURN        S              1A   inz
     D o_SECURE        S             10A   inz
     D o_SEQONLY       S             10A   inz
     D o_SHARE         S             10A   inz
     D o_TOFILE        S             10A   inz
     D o_TOLIB         S             10A   inz
     D o_QCMDL         S             15P 5 inz
      *
      *  Übertragen VARGRAPHIC Felder
     D x               S             10I 0 inz
     D offs            S             10I 0 inz
     D rem             S             10I 0 inz
     D len             S             10I 0 inz
      *
      *====================================================*
      *  Prototypen                                        *
      *====================================================*
COPY- /include LIBRARY_NAME/QCOPYLE,D_VARDEF
COPY- /include LIBRARY_NAME/QCOPYLE,FLDL0100
COPY- /include LIBRARY_NAME/QCOPYLE,F_PEEK53
COPY- /include LIBRARY_NAME/QCOPYLE,F_PEEK58
      *
      *====================================================*
      *  List API Format FLDL0100 mit eigenen zusätzlichen *
      *  Feldern.                                          *
      *====================================================*
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      *
      *====================================================*
      *  Cursorposition                                    *
      *====================================================*
      *
     D                 DS
     D  WScnCsrRow             1      4I 0
     D  WScnCsrCol             5      8I 0
      *
     D workstn         DS
     D  wScnStatus            11     15S 0
     D  wScnOffset           241    242I 0
     D  wScnAID              369    369A
     D  wScnCsrPos           370    371I 0
      *
     D  xScnCsrRow     S                   like(wScnCsrRow) inz
      *
KEEP-D  keepCrsPos     C                   X__X
      *
      *====================================================*
      *  Systemdatenstruktur                               *
      *====================================================*
     D PGMSTS         SDS
      * Programmname
     D  PsPgmName                    10A
      * Programmfehlerstatus
     D  PsPgmStat                     5S 0
      * vorheriger Programmfehlerstatus
     D  PsPrevStat                    5S 0
      * Letzte Anweisungsnummer
     D  PsLastSeq                     8A
      * Letzte Unterroutine
     D  PsLastSubr                    8A
      * Anzahl übergebener Parameter
     D  PsNbrParm                     3S 0
      * Fehler-Msg
     D  PsMsgID                       7A
      *  Fehler-Art
     D   PsMsgPrfx                    3A   OVERLAY(PsMsgID)
      *  Fehler-Nummer
     D   PsMsgNbr                     4A   OVERLAY(PsMsgID:4)
      * MI-Instruktions-Nr.
     D  PsMI_Instr                    4A
      * Arbeitsbereich für Nachrichten
     D  PsWorkArea                   30A
      * Programmbiblitohek
     D  PsPgmLib                     10A
      * CPF-Fehlertext
     D  PsMsgText                    80A
      * Kz der Ausnahmebedingung
     D  PsAUBE                        4A
      * unbenutzt
     D  PsUnused_1                   16A
      * Datumsformat
     D  PsDatFmt                      8A
      * Ersten 2 stellen von *YEAR
     D  PsYear                        2S 0
      * Letzte Dateioperation: Dateiname
     D  PsFileOpr                     8A
      * Datei-Staus-Information
     D  PsFileStat                   35A
      * Jobname
     D  PsJob                        10A
      * Benutzer
     D  PsUser                       10A
      * Jobnummer
     D  PsJobNbr                      6S 0
      * Jobdatum, Aufbau wie UDATE
     D  PsJobD                        6S 0
      * Programm-Ausführungsdatum, Aufbau wie UDATE
     D  PsJobDate                     6S 0
      * Job-Zeit (HHMMSS)
     D  PsJobTime                     6S 0
      * Umwandlungsdatum
     D  PsCrtDate                     6A
      * Umwandlungszeit (HHMMSS)
     D  PsCrtTime                     6A
      * Compiler Version
     D  PsCompVer                     4A
      * Quellendatei
     D  PsSrcFile                    10A
      * Bibliothek mit Quellendatei
     D  PsSrcLib                     10A
      * Quellenteildatei
     D  PsSrcMbr                     10A
      * Program containing procedure
     D  PsPgmProc                    10A
      * Module containing procedure
     D  PsModProc                    10A
      * unbenutzt
     D  PsUnused_2                   76A
      *
      *============================================================*
      *    Definition F-Tasten Bildschirmfelder                    *
      *============================================================*
      *
     D                 DS
     D ScrnFKeys                     18A   DIM(32)       INZ(*BLANKS)
     D  XXFKEY01               1     18A
     D  XXFKEY02              19     36A
     D  XXFKEY03              37     54A
     D  XXFKEY04              55     72A
     D  XXFKEY05              73     90A
     D  XXFKEY06              91    108A
     D  XXFKEY07             109    126A
     D  XXFKEY08             127    144A
     D  XXFKEY09             145    162A
     D  XXFKEY10             163    180A
     D  XXFKEY11             181    198A
     D  XXFKEY12             199    216A
     D  XXFKEY13             217    234A
     D  XXFKEY14             235    252A
     D  XXFKEY15             253    270A
     D  XXFKEY16             271    288A
     D  XXFKEY17             289    306A
     D  XXFKEY18             307    324A
     D  XXFKEY19             325    342A
     D  XXFKEY20             343    360A
     D  XXFKEY21             361    378A
     D  XXFKEY22             379    396A
     D  XXFKEY23             397    414A
     D  XXFKEY24             415    432A
     D  XXFKEY25             433    450A
     D  XXFKEY26             451    468A
     D  XXFKEY27             469    486A
     D  XXFKEY28             487    504A
     D  XXFKEY29             505    522A
     D  XXFKEY30             523    540A
     D  XXFKEY31             541    558A
     D  XXFKEY32             559    576A
      *
      *============================================================*
      *
     D PEEK21          S                   like(r_pgmCallN) inz
     D PEEK23          S                   like(r_pgmCallN) inz
     D PEEK32          S                   like(r_pgmCallN) inz
     D PEEK45          S                   like(r_pgmCallN) inz
     D PEEK59          S                   like(r_pgmCallN) inz
     D PEEK64          S                   like(r_pgmCallN) inz
      *
     D ISOT            C                   CONST('00.00.00')
     D HMST            C                   CONST('00:00:00')
     D EURT            C                   CONST('00.00.00')
     D JIST            C                   CONST('00:00:00')
      *
     D ISOL            C                   CONST('0001-01-01')
     D EURL            C                   CONST('01.01.0001')
     D JISL            C                   CONST('0001-01-01')
      *
     D ISOZ            C                   CONST('0001-01-01-00.00.00.000000')
      *
     D RclRsc          C                   CONST('RCLRSC LVL(*) ')
      *
     D xDsp80          S                   like(r_dsp80   )
     D xHeaderTyp      S                   like(r_headTyp )
     D xCopyRight      S                   like(r_copyRght)
     D xRcdNbr         S                   like(r_rcdNbr  )
     D XFile           S                   like(r_file    )
     D XLibrary        S                   like(r_lib     )
     D XMember         S                   like(r_mbr     )
     D xFunction       S             10A
     D xCommitLVL      S              1A
     D xIsUpdKey       S                   like(r_bool    )
     D xScreenNbr      S                   like(r_int4    )
     D xIsLower        S                   like(r_bool    )
     D xCsrRow         S                   like(r_int4    )
     D xCsrCol         S                   like(r_int4    )
     D xMsgID          S                   like(r_msgID   )
     D xMsgDta         S                   like(r_msgDta  )
      *
     D yFile           S             10A   inz
     D yLib            S             10A   inz
     D yMbr            S             10A   inz
     D yEvent          S             10A   inz
     D yUser           S             10A   inz
     D yTimestamp      S               Z   inz
     D yRcdNbr         S             10I 0 inz
     D ySize           S             10I 0 inz
     D yBImage         S               *   inz
     D yAImage         S               *   inz
      *
     D yPgm            S                   like(r_pgm     ) inz
     D yKey            S             10A   inz
     D yPosF24         S                   like(r_int4    ) inz
     D yFKeys          S                   like(r_fKeyDsp ) inz
     D                                     dim(32)
     D yNbrOfKeys      S                   like(r_int4    ) inz
     D yScnAID         S                   like(r_scnAID  ) inz
     D yPgmCmd         S                   like(r_pgmCmd  ) inz
     D yPgmCmdDt       S                   like(r_pgmCmdDt) inz
      *
     D yOutBuffer      S                   like(r_rcdBuf  ) inz
     D yOutBuffLn      S                   like(r_int4    ) inz
     D yCcsid          S                   like(r_int4    ) inz
     D yMsgID          S                   like(r_msgID   ) inz
     D yMsgDta         S                   like(r_msgDta  ) inz
      *
      * - PEEK 45 -
     D yDsp80          S                   like(r_dsp80   ) inz
     D yHeaderTyp      S                   like(r_headTyp ) inz
     D yCopyRight      S                   like(r_copyRght) inz
     D yFldName        S                   like(r_fieldNme) inz
     D yFldInhalt      S                   like(r_rcdBuf  ) inz
     D yProtect        S                   like(r_bool    ) inz(bFalse)
     D yIsUcs2         S                   like(r_int4    ) inz
     D yLength         S                   like(r_int4    ) inz
      *
      * - PEEK 59 -
    -D*yDsp80          S                   like(r_dsp80   ) inz
     D yType           S                   like(r_type    ) inz
     D yInpMsgID       S                   like(r_msgID   ) inz
     D yInpMsgDta      S                   like(r_msgDta  ) inz
     D yKeys           S                   like(r_keys    ) inz
    -D*yMsgID          S                   like(r_msgID   ) inz
    -D*yMsgDta         S                   like(r_msgDta  ) inz
      *
     D sfBot           S                   like(r_int4    ) inz
      *
     D isFound         S                   like(r_bool    ) inz(bFalse)
     D isError         S                   like(r_bool    ) inz(bFalse)
      *  Standardwert für "Eingabe in Kleinbuchstaben"
LCAS-D isLower         S                   like(r_bool    ) inz(X____X)
      *  Standardwert für "Satz gesperrt einlesen"
RLCK-D isRcdLockDft    S                   like(r_bool    ) inz(X____X)
      *  Eingabe in Kleinbuchstaben erlaubt Ja/Nein
ALWL-D isAlwLower      S                   like(r_bool    ) inz(X____X)
     D isVisible       S                   like(r_bool    ) inz(bFalse)
     D isCvtChar       S                   like(r_bool    ) inz(bFalse)
     D isRcdLocked     S                   like(r_bool    ) inz(bFalse)
      *
     D scnNbr          S                   like(r_int4    ) inz
     D nbrFKeys        C                   const(3)
      *
     D pgmErrFlag      S                   like(r_bool    ) inz(bFalse)
     D pgmRetMode      S              6A   INZ('*CANCL')
      *
     D buffStart       S                   like(r_int4    ) inz
     D buffEnd         S                   like(r_int4    ) inz
     D buffPos         S                   like(r_int4    ) inz
     D*trimLen         S                   like(r_int4    ) inz
     D*isCharFld       S                   like(r_bool    ) inz
      *
     D keyChar         S              1A   inz
      *
     D pgmMsgID        S                   like(r_msgID   ) inz
     D pgmMsgDta       S                   like(r_msgDta  ) inz
      *
      *  ... Feldefinitionen zur Bildschirmsteuerung
DEF1- *
      *
      *  ... Konstanten für "Felder zu lang" (> 512 Byte und > 1024 Byte)
DEF2- *
      *
      *  Before-Image für Prüfung auf Datensatzänderung
      *  bei optimistischer Satzsperre
     D b4Image         DS                  likeds(RCD_DS   ) inz
      *
      *  Datenpuffer für Hex-Editor ...
      *  ... umbenennen der Feldnamen
RNM1-D RCD_DS        E DS                  extname(FILE00)
      *
     D pRCD_BUFFER     S               *   inz(%addr(RCD_DS))
     D RCD_BUFFER      S                   like(RCD_DS   )
     D                                     based(pRCD_BUFFER)
      *
      *  ... umbenennen der externen Feldnamen
RNM2-IFFILE00
      *
      *============================================================*
      * Program Entry
      *============================================================*
      *
     C     *entry        Plist
     C                   Parm                    xDsp80
     C                   Parm                    xHeaderTyp
     C                   Parm                    xCopyRight
     C                   Parm                    xRcdNbr
     C                   PARM                    XFile
     C                   PARM                    XLibrary
     C                   PARM                    XMember
     C                   Parm                    xFunction
     C                   Parm                    xCommitLVL
     C                   Parm                    xIsUpdKey
     C                   Parm                    xScreenNbr
     C                   Parm                    xIsLower
     C                   Parm                    xCsrRow
     C                   Parm                    xCsrCol
     C                   Parm                    xMsgID
     C                   Parm                    xMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK21
     C     P_PEEK21      Plist
     C                   Parm                    yScnAID
     C                   Parm                    yPgm
     C                   Parm                    yPgmCmd
     C                   Parm                    yPgmCmdDt
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK23
     C     P_PEEK23      Plist
     C                   Parm                    yPgm
     C                   Parm                    yKey
     C                   Parm                    yPosF24
     C                   Parm                    yFKeys
     C                   Parm                    yNbrOfKeys
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK32
     C     P_PEEK32      Plist
     C                   Parm                    yOutBuffer
     C                   Parm                    yOutBuffLn
     C                   Parm                    yCcsid
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK59
     C     P_PEEK59      Plist
     C                   Parm                    yDsp80
     C                   Parm                    yType
     C                   Parm                    yInpMsgID
     C                   Parm                    yInpMsgDta
     C                   Parm                    yKeys
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *  Parameterliste für PEEK45/PEEK64
     C     P_PEEK_EDIT   Plist
     C                   Parm                    yDsp80
     C                   Parm                    yHeaderTyp
     C                   Parm                    yCopyRight
     C                   Parm                    yFldName
     C                   Parm                    yFldInhalt
     C                   Parm                    yLength
     C                   Parm                    yProtect
     C                   Parm                    yIsUcs2
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *  Parameterliste für EXIT04
     C     P_EXIT04      Plist
     C                   Parm                    yFile
     C                   Parm                    yLib
     C                   Parm                    yMbr
     C                   Parm                    yEvent
     C                   Parm                    yUser
     C                   Parm                    yTimestamp
     C                   Parm                    yRcdNbr
     C                   Parm                    ySize
     C                   Parm                    yBImage
     C                   Parm                    yAImage
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLD
     C     F_KEY         Klist
     C                   Kfld                    F_Field
      *
      *----------------------------------------------------*
      *
     C                   Eval      xMsgID  = ' '
     C                   Eval      xMsgDta = ' '
      *
      * - Setzen Eingabe in Kleinbuchstaben
     C                   If        xIsLower = bTrue or xIsLower = bFalse
     C                   Eval      isLower = xIsLower
     C                   Endif
      *
      * - Darstellen der Befehlstasten
     C                   Eval      sfBot = 1
      *
      * - Setzen Bildschirmattribute
     C                   Exsr      setScreen
      *
      * - Löschen Programmnachrichten
     C                   Callp     p_rmvPgmMg(psPgmName)
      *
      * - Öffnen der Dateien
     C                   Exsr      openFiles
      *
      * - Daten aktualisieren
     C                   Exsr      c_refresh
      *
      * - Anzeigen Copyright
     C                   Eval      pgmMsgID  = 'USR9999'
     C                   Eval      pgmMsgDta = xCopyRight
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
      *
      * - Setzen der Cursorposition
     C                   If        (keepCrsPos)
     C                   Eval      csrRow = xCsrRow
     C                   Eval      csrCol = xCsrCol
     C                   Else
     C                   Eval      csrRow = 0
     C                   Eval      csrCol = 0
     C                   Endif
      *
      *------------------*
      * Hauptschleife    *
      *------------------*
     C                   Do        *hival
      *
      * - Flag für nicht darstellbare Zeichen
     C                   Eval      isCvtChar = bFalse
      *
      * - Feldbezeichnung
     C                   Select
     C                   When      xHeaderTyp = '*FIELDNAME'
     C                   Eval      *in70 = *off
     C                   Eval      *in75 = *off
     C                   When      xHeaderTyp = '*FIELDTYPE'
     C                   Eval      *in70 = *off
     C                   Eval      *in75 = *on
     C                   Other
     C                   Eval      *in70 = *on
     C                   Eval      *in75 = *off
     C                   Endsl
      *
      * - Lower-/Upper-Case
     C                   If        isLower = bTrue
     C                   Eval      *in71 = *on
     C                   Else
     C                   Eval      *in71 = *off
     C                   Endif
      *
      * - geschütze Felder nicht unterstreichen
     C                   Eval      *in72 = *off
      *
      * - Freigeben Schlüsselfelder
     C                   If        (xIsUpdKey = bTrue  )  or
     C                             (xFunction = '*ADD' )  or
     C                             (xFunction = '*COPY')
     C                   Eval      *in73 = *on
     C                   Else
     C                   Eval      *in73 = *off
     C                   Endif
      *
      * - Anzeigen Sperrstatus des Datensatz
     C                   If        xFunction = '*CHANGE'
     C                   Eval      *in74 = *on
     C                   If        isRcdLocked = bTrue
     C                   Eval      RLKMSGNBR = '0129'
     C                   Else
     C                   Eval      RLKMSGNBR = '0130'
     C                   Endif
     C                   Else
     C                   Eval      *in74 = *off
     C                   Eval      RLKMSGNBR = '0130'
     C                   Endif
      *
      * - Initialisieren Bildschirmnummer
     C                   If        (scnNbr < 1  ) or
      *  ... eintragen max. Anzahl Bildschirmseiten
LSCN-C                             (scnNbr > X_X)
     C                   Eval      scnNbr = 1
     C                   Else
      *   ... Wert ist im gültigen Bereich
     C                   Endif
      *
      * - Anzeigen "Weitere"/"Ende"
      *  ... eintragen max. Anzahl Bildschirmseiten
LSCN-C                   If        (scnNbr = X_X)
     C                   Eval      *in83 = *on
     C                   Else
     C                   Eval      *in83 = *off
     C                   Endif
      *
      * - Prüfen ...
     C                   Select
      *  ... Bildschirmfelder auf nicht darstellbare Zeichen
CHKS- *
     C                   Other
     C                   Eval      scnNbr = 1
     C                   Exsr      chkChar001
     C                   Endsl
      *
      * - Ausgeben Nachricht
      *   "Felder mit nicht darstellbaren Zeichen wurden ausgeblendet"
     C                   Exsr      MSG8164
      *
      * - Anzeigen der Msg-Subfile
     C                   Eval      *in89 = *off
     C                   Write     MSGCTL
      *
      * - Anzeigen Kopf
     C                   Write     HEAD
      *
      * - Anzeigen F-Tasten
     C                   Write     FKEYS
      *
      * - Anzeigen der Befehlstasten
     C                   Select
     C                   When      (sfBot = 2) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT02                                      BT-Tasten 2
     C                   When      (sfBot = 3) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT03                                      BT-Tasten 3
     C                   When      (sfBot = 4) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT04                                      BT-Tasten 4
     C                   When      (sfBot = 5) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT05                                      BT-Tasten 5
     C                   When      (sfBot = 6) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT06                                      BT-Tasten 6
     C                   When      (sfBot = 7) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT07                                      BT-Tasten 7
     C                   When      (sfBot = 8) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT08                                      BT-Tasten 8
     C                   Other
     C                   Write     PBBOT01                                      BT-Tasten 1
     C                   Eval      sfBot = 1
     C                   Endsl
      *
      * - Blättern ...
     C                   Select
      *  ... generieren Auswahl der anzuzeigenden Bildschirmseite
SCRN- * - Blättern
     C                   Other
     C                   Exsr      chkChar001
      *  ... 1. Bildschirmseite
SCN1- * - Blättern
     C                   Eval      scnNbr = 1
     C                   Endsl
      *
      * - Zurückgeben aktuelle Bildschirmnummer
     C                   Eval      xScreenNbr = scnNbr
      *
      * - Löschen Programmnachrichten
     C                   Callp     p_rmvPgmMg(psPgmName)
      *
      * - Berechnen Zeile/Spalte
     C     wScnCsrPos    Div       256           wScnCsrRow
     C                   Mvr                     wScnCsrCol
      *
      * - Löschen der Cursorposition
     C                   Eval      csrRow = 0
     C                   Eval      csrCol = 0
      *
      * - Merken der Cursorposition beim Verlassen des Programs
     C                   Eval      xCsrRow = wScnCsrRow - wndTopRow
     C                   Eval      xCsrCol = wScnCsrCol - wndLeftCol - 1
      *
      * - Mappen der gedrückten Taste
      *   in Programmbefehl
     C                   Eval      yScnAID = wScnAID
     C                   Eval      yPgm    = 'PXXXXXXXX'
     C                   Call      PEEK21        P_Peek21
     C                   If        yMsgID <> ' '
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: psPgmName)
     C                   Iter
     C                   Endif
      *
      * - Abfragen der Befehlstasten
     C                   Select
      *   F3  - Beenden
     C                   When      yPgmCmd = '*EXIT'
     C                   Exsr      c_endPgm
     C                   Leave
      *   F5  - Aktualisieren
     C                   When      yPgmCmd = '*REFRESH'
     C                   Exsr      c_refresh
      *
      *   F6  - Umschalten LOWER-CASE
     C                   When      yPgmCmd = '*TGLLUCASE'
     C                   Exsr      c_tgLUCase
      *
      *       - Einschalten Lower-Case
     C                   When      yPgmCmd = '*LOWERCASE'
     C                   Exsr      c_lowCase
      *
      *       - Umschalten Upper-CASE
     C                   When      yPgmCmd = '*UPPERCASE'
     C                   Exsr      c_uppCase
      *
      *   F7  - Umschalten der Überschrift
     C                   When      yPgmCmd = '*HEADLINE'
     C                   Exsr      c_chgHead
      *
      *   F8  - Setzen/Löschen NULL Indicator
     C                   When      yPgmCmd = '*TGLNULL'
     C                   Exsr      c_tgNullInd
     C                   Exsr      keepCsrPos
      *
      *   F9  - Hex-Editor
     C                   When      yPgmCmd = '*HEXEDIT'
     C                   Exsr      c_fldHexEd
     C                   Exsr      keepCsrPos
      *
      *   F10 - String-Editor
     C                   When      yPgmCmd = '*STREDIT'
     C                   Exsr      c_fldStrEd
     C                   Exsr      keepCsrPos
      *   F12 - Beenden
     C                   When      yPgmCmd = '*CANCEL'
     C                   Exsr      c_endPgm
     C                   Leave
      *   F13 - Umschalten Satzsperre
     C                   When      yPgmCmd = '*TGLRCDLCK'
     C                   Exsr      c_tgRcdLock
     C                   Exsr      keepCsrPos
      *   F17 - Anfang Datensatz
     C                   When      yPgmCmd = '*TOP'
     C                   Eval      scnNbr = 1
      *   F18 - Ende Datensatz
     C                   When      yPgmCmd = '*BOT'
      *  ... eintragen max. Anzahl Bildschirmseiten
LSCN-C                   Eval      scnNbr =  X_X
      *
      *   F24 - Weitere Tasten
     C                   When      yPgmCmd = '*MOREKEYS'
     C                   Exsr      c_moreKeys
      *   Enter
     C                   When      yPgmCmd = '*ENTER'
     C                   Exsr      updateFile
     C                   If        isError = bFalse
     C                   Leave
     C                   Endif
      *   Page up
     C                   When      (yPgmCmd = '*PAGEUP')   and
      *  ... eintragen max. Anzahl Bildschirmseiten
LSCN-C                             (scnNbr < X_X)
     C                   Eval      scnNbr = scnNbr + 1
      *   Page down
     C                   When      (yPgmCmd = '*PAGEDOWN') and
     C                             (scnNbr  > 1 )
     C                   Eval      scnNbr = scnNbr - 1
      *   Sonstige Tasten
     C                   Other
     C                   Callp     p_wrongKey(wScnAID: psPgmName)
     C                   Endsl
      *
     C                   Enddo
      *
      *   Beenden Programm
     C     ende          Tag
      *
      *   Schließen Dateien
     C                   Exsr      closeFiles
      *
      *   Merken Eingabe in Kleinbuchstaben
     C                   Eval      xIsLower = isLower
      *
     C                   Eval      *inlr = *on
      *
      *===================================================*
      *    Einlesen Datensatz & füllen Bildschirm         *
      *===================================================*
      *
     C     readRecord    Begsr
      *
      *  Einlesen Datensatz für ...
     C                   Select
      *  ... update
     C                   When      xFunction = '*CHANGE'
     C                   Eval      HDGMSGNBR = '0063'
     C                   If        isRcdLockDft = bTrue
     C     xRcdNbr       Chain(E)  FFILE00
     C                   Eval      isRcdLocked = bTrue
     C                   Else
     C     xRcdNbr       Chain(NE) FFILE00
     C                   Eval      isRcdLocked = bFalse
     C                   Endif
     C                   Eval      isFound = %found(FILE00)
     C                   Eval      isError = %error()
      *  ... copy
     C                   When      xFunction = '*COPY'
     C                   Eval      HDGMSGNBR = '0064'
     C     xRcdNbr       Chain(NE) FFILE00
     C                   Eval      isRcdLocked = bFalse
     C                   Eval      isFound = %found(FILE00)
     C                   Eval      isError = %error()
      *  ... add
     C                   When      xFunction = '*ADD'
     C                   Eval      HDGMSGNBR = '0065'
     C                   Exsr      clearRecord
     C                   Eval      isRcdLocked = bTrue
     C                   Eval      isFound = bTrue
     C                   Eval      isError = bFalse
      *  ... FEHLER!!!
     C                   Other
     C                   Eval      isRcdLocked = bFalse
     C                   Eval      pgmMsgID  = 'USR8113'
     C                   Eval      pgmMsgDta = xFunction
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
     C                   Callp     p_movPgmMg(psPgmName)
     C                   Goto      Ende
     C                   Endsl
      *
      *  Fehler aufgetreten ...
     C                   If        isError = bTrue
     C                   Eval      pgmMsgID  = 'USR8156'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
     C                   Callp     p_movPgmMg(psPgmName)
     C                   Goto      ende
     C                   Endif
      *
      *  ... Satz nicht gefunden
     C                   If        isFound = bFalse
     C                   Eval      pgmMsgID  = 'USR8120'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
     C                   Callp     p_movPgmMg(psPgmName)
     C                   Goto      ende
     C                   Endif
      *
     C                   Endsr
      *
      *===================================================*
      *    Löschen aller Felder im Datensatz.             *
      *===================================================*
      *
     C     clearRecord   Begsr
      *
     C                   Clear                   FFILE00
      *
CLR - *
      *
     C                   Endsr
      *
      *============================================================*
      *    DataToScn     Übertragen der Dateifelder in die         *
      *                  Bildschirmfelder                          *
      *============================================================*
      *
     C     dataToScn     BEGSR
      *
      *  Anzeigen relative Satznummer
     C                   Eval      xxRcdN = xRcdNbr
      *
      *  Anzuzeigender Bildschirm
     C                   Eval      scnNbr = xScreenNbr
      *
      *  Übertragen Dateifelder
      *  in die Bildschirmfelder ...
      *  ... generieren MOVEL extField => intField (ToScreen)
TSCN- *
      *
      *  ... prüfen auf ISO-Felder
ISO - *
      *
     C                   Endsr
      *
      *============================================================*
      *    c_endPgm      F3/F12 - Programm beenden                 *
      *============================================================*
      *
     C     c_endPgm      Begsr
      *
      * - Löschen Programmnachrichten
     C                   Callp     p_rmvPgmMg(psPgmName)
      *
      * - Zurückgeben Abbruchmeldung
     C                   Eval      xMsgID  = 'USR8100'
     C                   Eval      xMsgDta = yPgmCmd
      *
     C                   Endsr
      *
      *============================================================*
      *    c_refresh     F5 - Daten aktualisieren                  *
      *============================================================*
      *
     C     c_refresh     Begsr
      *
      * - IsVisible Bezugszahlen
      *   Einblenden aller Felder
     C                   Exsr      EnableEdit
      *
      * - Einlesen der Daten und füllen Bildschirm
     C                   Exsr      readRecord
     C                   Exsr      dataToScn
      *
      * - Merken aktuelles Image
     C                   Eval      b4Image = RCD_DS
      *
     C                   Endsr
      *
      *============================================================*
      *    c_tgLUCase    F6  - Umschalten Lower/Upper-Case         *
      *============================================================*
      *
     C     c_tgLUCase    Begsr
      *
     C                   If        isLower = bFalse
     C                   Exsr      c_lowCase
     C                   Else
     C                   Exsr      c_uppCase
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    c_lowCase     F6  - Einschalten Lower-Case              *
      *============================================================*
      *
     C     c_lowCase     Begsr
      *
     C                   If        isAlwLower = bTrue
     C                   Eval      isLower = bTrue
     C                   Else
     C                   Eval      pgmMsgID  = 'USR8215'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : 'PEEK05')
     C                   Endif
      *
      *  Beibehalten der Cursorposition ...
     C                   Exsr      keepCsrPos
      *
     C                   Endsr
      *
      *============================================================*
      *    c_uppCase     F6  - Einschalten Upper-Case              *
      *============================================================*
      *
     C     c_uppCase     Begsr
      *
     C                   Eval      isLower = bFalse
      *
      *  Beibehalten der Cursorposition ...
     C                   Exsr      keepCsrPos
      *
     C                   Endsr
      *
      *============================================================*
      *    c_chgHead     F7  - Umschalten der Überschrift          *
      *============================================================*
      *
     C     c_chgHead     Begsr
      *
     C                   Eval      xHeaderTyp = f_nextHeaderType(xHeaderTyp)
      *
      *  Beibehalten der Cursorposition ...
     C                   Exsr      keepCsrPos
      *
     C                   Endsr
      *
      *============================================================*
      *    c_tgRcdLock   F13 - Umschalten Satzsperre               *
      *============================================================*
      *
     C     c_tgRcdLock   Begsr
      *
     C                   If        xFunction <> '*CHANGE'
     C                   Eval      pgmMsgID  = 'USR8231'
     C                   Eval      pgmMsgDta = ''
     C                   Callp     p_sndPgmMg(pgmMsgID: pgmMsgDta: psPgmName)
     C                   Leavesr
     C                   Endif
      *
     C                   If        isRcdLocked = bTrue
     C                   Exsr      unlockRecord
     C                   Else
      *
      *  ... vergleichen Before-Images auf Abweichungen
     C                   Exsr      readRecord
     C                   If        b4Image <> RCD_DS
      *      ... freigeben Datensatz, bei unterschiedlichen Images
      *          und fragen Benutzer, wie es weiter gehen soll (dennoch aktualisieren?)
     C                   Eval      yDsp80     = xDsp80
     C                   Eval      yType      = '*QUESTION'
     C                   Eval      yInpMsgID  = 'USR8232'
     C                   Eval      yInpMsgDta = ''
     C                   Eval      yKeys      = 'YC'
     C                   Eval      yMsgID     = ''
     C                   Eval      yMsgDta    = ''
     C                   Call(E)   PEEK59        P_Peek59
     C                   If        %error()
     C                   Eval      isError = bTrue
     C                   Leavesr
     C                   Endif
      *      ... abbrechen der Operation, wenn vom Benutzer gewünscht
     C                   If        yMsgID = 'USR8190' and yMsgDta <> '*YES'
     C                   Callp     p_sndPgmMg(yMsgID : yMsgDta : psPgmName)
     C                   Eval      isError = bTrue
     C                   Leavesr
     C                   Endif
     C                   Endif
      *
      *      ... sperren Datensatz für UPDATE
     C                   Exsr      lockRecord
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    c_moreKeys    F24 - Weitere Tasten                      *
      *============================================================*
      *
     C     c_moreKeys    Begsr
      *
     C                   Eval      sfBot = sfBot + 1
      *
     C                   Endsr
      *
      *===================================================*
      *    Verarbeiten der Eingaben                       *
      *===================================================*
      *
     C     updateFile    Begsr
      *
      *  Sperren Datensatz, wenn nicht bereits geschehen ...
     C                   If        (xFunction = '*CHANGE') and
     C                             (isRcdLocked = bFalse)
     C                   Exsr      lockRecord
     C                   If        (isFound = bFalse) or (isError = bTrue)
     C                   Leavesr
     C                   Endif
      *  ... vergleichen Before-Images auf Abweichungen
     C                   If        b4Image <> RCD_DS
      *      ... freigeben Datensatz, bei unterschiedlichen Images
      *          und fragen Benutzer, wie es weiter gehen soll (dennoch aktualisieren?)
     C                   Exsr      unlockRecord
     C                   Eval      yDsp80     = xDsp80
     C                   Eval      yType      = '*QUESTION'
     C                   Eval      yInpMsgID  = 'USR8225'
     C                   Eval      yInpMsgDta = ''
     C                   Eval      yKeys      = 'YC'
     C                   Eval      yMsgID     = ''
     C                   Eval      yMsgDta    = ''
     C                   Call(E)   PEEK59        P_Peek59
     C                   If        %error()
     C                   Eval      isError = bTrue
     C                   Leavesr
     C                   Endif
      *      ... abbrechen der Operation, wenn vom Benutzer gewünscht
     C                   If        yMsgID = 'USR8190' and yMsgDta <> '*YES'
     C                   Callp     p_sndPgmMg(yMsgID : yMsgDta : psPgmName)
     C                   Eval      isError = bTrue
     C                   Leavesr
     C                   Endif
      *
      *      ... sperren Datensatz für UPDATE
     C                   If        (isRcdLocked = bFalse)
     C                   Exsr      lockRecord
     C                   If        (isFound = bFalse) or (isError = bTrue)
     C                   Leavesr
     C                   Endif
     C                   Endif
      *
     C                   Endif
     C                   Endif
      *
      *  ... prüfen auf ISO-Felder
ISO - *
      *
      *  Übertragen Felder vom Bildschirm
      *  in die Dateifelder ...
      *  ... generieren MOVEL intField => extField (FromScreen)
FSCN- *
      *
      *  Abschließen der Verarbeitung ...
     C                   Select
      *  ... für update
     C                   When      xFunction = '*CHANGE'
     C                   Update(E) FFILE00
     C                   Eval      isError = %error()
      *  ... für copy
     C                   When      xFunction = '*COPY'
     C                   Write(E)  FFILE00
     C                   Eval      isError = %error()
      *  ... für add
     C                   When      xFunction = '*ADD '
     C                   Write(E)  FFILE00
     C                   Eval      isError = %error()
      *  ... FEHLER!!!
     C                   Other
     C                   Unlock(E) FILE00
     C                   Eval      isError = %error()
     C                   Endsl
      *
     C                   If        isError = bTrue
      *  Update/write fehlgeschlagen ...
     C   95              Rolbk
     C  N95              Unlock    File00
     C                   Exsr      ReadRecord
      ***                Exsr      DataToScn
      *  Setzen Fehler-Flag ...
     C                   Eval      isError = bTrue
     C                   Else
      *  Updatze/write OK ...
     C   95              Commit
     C  N95              Unlock    File00
      *  Löschen Fehler-Flag ...
     C                   Eval      isError = bFalse
     C                   Endif
      *
     C                   If        isError = bFalse and
     C                             f_exist('EXIT04': '*LIBL': '*PGM') = bTrue
     C                   Eval      yFile      = xFile
     C                   Eval      yLib       = xLibrary
     C                   Eval      yMbr       = xMember
     C                   Eval      yEvent     = xFunction
     C                   Eval      yUser      = PsUser
     C                   Eval      yTimestamp = %timestamp()
     C                   Eval      yRcdNbr    = rcdFile00.number
     C                   Eval      ySize      = rcdFile00.rcdLength
     C                   If        xFunction = '*ADD '
     C                   Eval      yBImage    = *NULL
     C                   Else
     C                   Eval      yBImage    = %addr(b4Image)
     C                   Endif
     C                   Eval      yAImage    = %addr(RCD_DS)
     C                   Call      'EXIT04'      P_EXIT04
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    lockRecord    Einlesen Datensatz mit Sperre             *
      *============================================================*
      *
     C     lockRecord    Begsr
      *
      *  Lesen Datensatz mit Satzsperre für nachfolgenden UPDATE ...
     C     xRcdNbr       Chain(E)  FFILE00
     C                   Eval      isFound = %found(FILE00)
     C                   Eval      isError = %error()
      *  ... Fehler aufgetreten
     C                   If        isError = bTrue
     C                   Eval      pgmMsgID  = 'USR8156'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
      ***                Callp     p_movPgmMg(psPgmName)
      ***                Goto      ende
     C                   Endif
      *  ... Satz nicht gefunden
     C                   If        isFound = bFalse
     C                   Eval      pgmMsgID  = 'USR8120'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
      ***                Callp     p_movPgmMg(psPgmName)
      ***                Goto      ende
     C                   Endif
      *
     C                   If        (isError = bFalse) and (isFound = bTrue)
     C                   Eval      isRcdLocked = bTrue
     C                   Else
     C                   Eval      isRcdLocked = bFalse
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    unlockRecord  Freigeben Datensatzsperre                 *
      *============================================================*
      *
     C     unlockRecord  Begsr
      *
     C                   Unlock    FILE00
      *
     C                   Eval      isRcdLocked = bFalse
      *
     C                   Endsr
      *
      *============================================================*
      *    chkChar       Prüfen auf nicht darstellbare Zeichen     *
      *                  und Schlüsselfeld                         *
      *============================================================*
      *
     C     chkChar       Begsr
      *
     C     F_Key         Chain     FPEEKFLD
     C                   If        not %found(PEEKFLD)
      * - Zugriff fehlgeschlagen, Feld sperren
     C                   Eval      yMsgID  = 'USR8163'
     C                   Eval      yMsgDta = ' '
     C                   Clear                   FLDL0100
     C                   Else
      *
     C                   Eval      FLDL0100 = F_FFD
      *
      *  ... prüfen auf nicht darstellbare Zeichen
      *      ... Konvertieren nicht darstellbarer Zeichen
     C                   If        (FLDL0100.F1DTYP = 'G')                      = Graphic
     C                   Eval      yCcsid = FLDL0100.F1FDCC
     C                   Else
     C                   Eval      yCcsid = 0
     C                   Endif
      *
     C                   Call(E)   PEEK32        P_Peek32
     C                   If        %error()
     C                   Eval      yMsgID  = 'USR8163'
     C                   Eval      yMsgDta = ' '
     C                   Endif
     C                   Endif
      *
      *  Nachricht auswerten und ...
     C                   If        yMsgID <> ' '
      *  ... Felder ausblenden
     C                   Eval      isVisible = *off
     C                   Eval      isCvtChar = bTrue
     C                   Else
      *  ... Felder einblenden
     C                   Eval      isVisible = *on
     C                   Endif
      *
      *  Schlüsselfeld?
     C                   If        (F_DESC <> ' ')
      *  ... JA
     C                   Eval      keyChar = '>'
     C                   Else
      *  ... NEIN
     C                   Eval      keyChar = ':'
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    Öffnen der Dateien                                      *
      *============================================================*
      *
     C     openFiles     Begsr
      *
      *  Überschreiben DB-Datei:
     C                   Eval      o_File     = 'FILE00'
     C                   Eval      o_ToFile   = xFile
     C                   Eval      o_ToLib    = xLibrary
     C                   Eval      o_Mbr      = xMember
     C                   Eval      o_OvrScope = '*CALLLVL'
     C                   Eval      o_Share    = '*NO'
     C                   Eval      o_SeqOnly  = '*NO'
     C                   Eval      o_Secure   = '*YES'
     C                   Exsr      OvrDbf
      *
      *  Überschreiben Bildschirmdatei:
     C                   Eval      o_File     = 'DSPF'
     C                   Eval      o_ToFile   = 'F' + %subst(PsPgmName: 2)
     C                   Eval      o_ToLib    = PsPgmLib
     C                   Eval      o_OvrScope = '*CALLLVL'
     C                   Exsr      OvrDspF
      *
      *  Datei öffnen ...
     C                   If        xCommitLVL = '0'
      *  ... ohne Commit
     C                   Eval      *in95 = *off
     C                   Else
      *  ... mit Commit
     C                   Eval      *in95 = *on
     C                   Endif
      *
     C                   Open(E)   FILE00
     C                   If        %error()
      *  Datei konnte nicht geöffnet werden
     C                   Callp     p_movPgmMg(psPgmName)
     C                   Eval      pgmMsgID  = 'USR0005'
     C                   Eval      pgmMsgDta = 'FILE00'
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta :
     C                                        psPgmName:'*ESCAPE'  )
     C                   Goto      Ende
     C                   Endif
      *
      *  Öffnen der Bildschirmdatei
     C                   Open(E)   DSPF
     C                   If        %error()
      *  Datei konnte nicht geöffnet werden
     C                   Callp     p_movPgmMg(psPgmName)
     C                   Eval      pgmMsgID  = 'USR0005'
     C                   Eval      pgmMsgDta = 'DSPF'
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta :
     C                                        psPgmName:'*ESCAPE'  )
     C                   Goto      Ende
     C                   Endif
      *
      *  Öffnen der Feldbeschreibung
     C                   Open(E)   PEEKFLD
     C                   If        %error()
      *  Datei konnte nicht geöffnet werden
     C                   Callp     p_movPgmMg(psPgmName)
     C                   Eval      pgmMsgID  = 'USR0005'
     C                   Eval      pgmMsgDta = 'PEEKFLD'
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta :
     C                                        psPgmName:'*ESCAPE'  )
     C                   Goto      Ende
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    Schließen der Dateien                                   *
      *============================================================*
      *
     C     closeFiles    Begsr
      *
      *  Falls irgendetwas unerwartetes schief
      *  gelaufen sein sollte ...
     C   95              Rolbk
      *
     C                   Close     PEEKFLD
     C                   Close     FILE00
     C                   Close     DSPF
      *
      *  Entfernen der Triggerprogramme aus dem
      *  Arbeitsspeicher ...
     C                   Eval      cmd    = RclRsc
     C                   Eval      cmdLen = 40
     C                   Call      'QCMDEXC'
     C                   Parm                    cmd              40
     C                   Parm                    cmdLen           15 5
      *
     C                   Endsr
      *
      *============================================================*
      *    keepCsrPos    Beibehalten der Cursorposition            *
      *============================================================*
      *
     C     keepCsrPos    Begsr
      *
      *  Beibehalten der Cursorosition
     C                   Eval      csrRow = wScnCsrRow - wndTopRow
     C                   Eval      csrCol = wScnCsrCol - wndLeftCol - 1
      *
     C                   Endsr
      *
      *============================================================*
      *    setScreen     Einstellen 132/80-Zeichen Auflösung       *
      *============================================================*
      *
     C     setScreen     Begsr
      *
     C                   If        xDsp80 = '0'
      *   132-Zeichen Anzeige
     C                   Eval      *in88 = *off
     C                   Eval      wndTopRow  = 1
     C                   Eval      wndLeftCol = 40
     C                   Else
      *    80-Zeichen Anzeige
     C                   Eval      *in88 = *on
     C                   Eval      wndTopRow  = 1
     C                   Eval      wndLeftCol = 7
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    *pssr         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *pssr         Begsr
      *
     C                   If        PgmErrFlag = bFalse
     C                   Eval      pgmErrFlag = bTrue
     C   95              Rolbk
     C                   Dump
     C                   Eval      pgmRetMode = '*CANCL'
     C                   Endif
      *
     C                   Eval      *inlr = *on
      *
     C                   Endsr     pgmRetMode
      *
      *============================================================*
      *    *inzsr        Initialisierung                           *
      *============================================================*
      *
     C     *inzsr        Begsr
      *
     C                   Eval      PEEK21 = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23 = f_pgmCallN('PEEK23')
     C                   Eval      PEEK32 = f_pgmCallN('PEEK32')
     C                   Eval      PEEK45 = f_pgmCallN('PEEK45')
     C                   Eval      PEEK59 = f_pgmCallN('PEEK59')
     C                   Eval      PEEK64 = f_pgmCallN('PEEK64')
      *
     C                   Eval      pgmQ = '*'
      *
     C                   Eval      pgmErrFlag = bFalse
      *
      *  Einlesen der Tastenbelegung
     C                   Eval      yPgm    = 'PXXXXXXXX'
     C                   Eval      yKey    = '*ALL'
     C                   Eval      yPosF24 = 3
     C                   Call      PEEK23        P_Peek23
     C                   Movea (P) yFKeys        scrnFKeys
      *
     C                   Endsr
      *
      *====================================================*
      *  fromBuffer - Übertragen Rohdaten aus IO-Puffer    *
      *====================================================*
      *
     C     fromBuffer    Begsr
      *
     C                   Eval      F_Field = yFldName
     C     F_Key         Chain     FPEEKFLD
     C                   If        %found(PEEKFLD)
     C                   Eval      FLDL0100 = F_FFD
      *
     C                   if        (FLDL0100.F1UCS2 = '1')
      *   UCS2 field
     C                   eval      yIsUcs2 = FLDL0100.F1FDCC
     C                   eval      yLength = FLDL0100.F1NDBC
     C                   callp     f_rtvFld(yFldInhalt:Rcd_Buffer:
     C                                      FLDL0100: bFalse)
     C                   else
      *   non-UCS2 field
     C                   eval      yIsUcs2 = 0
     C                   eval      yLength = f_rtvFld(yFldInhalt:Rcd_Buffer:
     C                                      FLDL0100: bFalse)
     C                   endif
      *
     C**                   Eval      yLength = f_curFldLn(IO_Buff: FLDL0100)
      *
     C                   If        Editor = cEDITOR_STRING
     C                   Call      PEEK64        P_PEEK_EDIT
     C                   Else
     C                   Call      PEEK45        P_PEEK_EDIT
     C                   Endif
      *
     C                   If        yMsgID = 'USR8112'                           = ENTER
     C                   Exsr      ToBuffer
     C                   Endif
     C                   Endif
      *
     C                   Endsr
      *
      *====================================================*
      *  toBuffer   - Übertragen Rohdaten nach IO-Puffer   *
      *====================================================*
      *
     C     toBuffer      Begsr
      *
     C                   Callp     p_fldToBuf(Rcd_Buffer :
     C                                        YFldInhalt :
     C                                        FLDL0100   :
     C                                        bFalse     )
      *
     C                   Endsr
      *
      *====================================================*
      *  MSG8164    - Ausgeben Fehlernachricht             *
      *  Felder mit nicht darstellbaren Zeichen!           *
      *====================================================*
      *
     C     MSG8164       Begsr
      *
      * - Ausgeben Nachricht bei nicht
      *   darstellbaren Zeichen
     C                   If        isCvtChar = bTrue
      *  ... vorhanden
     C                   Eval      pgmMsgID  = 'USR8164'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
     C                   Else
      *  ... nicht vorhanden
     C                   Endif
      *
     C                   Endsr
      *
      *====================================================*
      *  MSG8208    - Ausgeben Fehlernachricht             *
      *  Nur INPUT-Felder können nicht geändert werden.    *
      *====================================================*
      *
     C     MSG8208       Begsr
      *
     C                   Eval      pgmMsgID  = 'USR8208'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
      *
     C                   Endsr
      *
      *====================================================*
      *  USR8193    - Ausgeben Fehlernachricht             *
      *  Felder &1 enthält nicht darstellbaren Zeichen und *
      *  kann daher nicht mit dem Texteditor bearbeitet    *
      *  werden.                                           *
      *====================================================*
      *
     C     USR8193       Begsr
      *
     C                   Eval      pgmMsgID  = 'USR8193'
     C                   Eval      pgmMsgDta = yFldName
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
      *
     C                   Endsr
      *
      *====================================================*
      *  MSG8221    - Ausgeben Fehlernachricht             *
      *  Editor nicht zulässig. Feld &1 hat ungültigen     *
      *  Datentyp.                                         *
      *====================================================*
      *
     C     MSG8221       Begsr
      *
     C                   Eval      pgmMsgID  = 'USR8221'
     C                   Eval      pgmMsgDta = yFldName
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
      *
     C                   Endsr
      *
      *====================================================*
      *  OvrDbf     - Überschreiben DB-Datei               *
      *====================================================*
      *
     C     OvrDbf        Begsr
      *
      *  Überschreiben mit neuer Datei ...
      *     OVRDBF
     C                   MOVEL(P)  'OVRDBF'      o_QCMD
      *     File
     C                   CAT       'FILE(':1     o_QCMD
     C                   CAT       o_FILE:0      o_QCMD
     C                   CAT       ')':0         o_QCMD
      *     ToFile
     C                   CAT       'TO':1        o_QCMD
     C                   CAT       'FILE(':0     o_QCMD
     C     o_TOLIB       IFNE      *BLANKS
     C                   CAT       o_TOLIB:0     o_QCMD
     C                   CAT       '/':0         o_QCMD
     C                   ENDIF
     C                   CAT       o_TOFILE:0    o_QCMD
     C                   CAT       ')':0         o_QCMD
      *     Mbr
     C     o_MBR         IFNE      *BLANKS
     C                   CAT       'MBR(':1      o_QCMD
     C                   CAT       o_MBR:0       o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *     OvrScope
     C     o_OVRSCOPE    IFNE      *BLANKS
     C                   CAT       'OVR':1       o_QCMD
     C                   CAT       'SCOPE(':0    o_QCMD
     C                   CAT       o_OVRSCOPE:0  o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *     Share
     C     o_SHARE       IFNE      *BLANKS
     C                   CAT       'SHARE(':1    o_QCMD
     C                   CAT       o_SHARE:0     o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *     SeqOnly
     C     o_SEQONLY     IFNE      *BLANKS
     C                   CAT       'SEQ':1       o_QCMD
     C                   CAT       'ONLY(':0     o_QCMD
     C                   CAT       o_SEQONLY:0   o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *     Secure
     C     o_SECURE      IFNE      *BLANKS
     C                   CAT       'SECURE(':1   o_QCMD
     C                   CAT       o_SECURE:0    o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *     Level Check
     C     o_LVLCHK      IFNE      *BLANKS
     C                   CAT       'LVLCHK(':1   o_QCMD
     C                   CAT       o_LVLCHK:0    o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *
     C                   MOVEL(P)  *IN99         o_IN99
      *
     C                   Z-ADD     256           o_QCMDL
     C                   CALL      'QCMDEXC'                            99
     C                   PARM                    o_QCMD
     C                   PARM                    o_QCMDL
      *
     C                   MOVEL(P)  *IN99         o_RETURN
      *
     C                   MOVEL(P)  o_IN99        *IN99
      *
     C                   Endsr
      *
      *====================================================*
      *  OvrDspF    - Überschreiben Bildschirmdatei        *
      *====================================================*
      *
     C     OvrDspF       Begsr
      *
      *  Überschreiben mit neuer Datei ...
      *     OVRDSPF
     C                   MOVEL(P)  'OVRDSPF'     o_QCMD
      *     File
     C                   CAT       'FILE(':1     o_QCMD
     C                   CAT       o_FILE:0      o_QCMD
     C                   CAT       ')':0         o_QCMD
      *     ToFile
     C                   CAT       'TO':1        o_QCMD
     C                   CAT       'FILE(':0     o_QCMD
     C     o_TOLIB       IFNE      *BLANKS
     C                   CAT       o_TOLIB:0     o_QCMD
     C                   CAT       '/':0         o_QCMD
     C                   ENDIF
     C                   CAT       o_TOFILE:0    o_QCMD
     C                   CAT       ')':0         o_QCMD
      *     OvrScope
     C     o_OVRSCOPE    IFNE      *BLANKS
     C                   CAT       'OVR':1       o_QCMD
     C                   CAT       'SCOPE(':0    o_QCMD
     C                   CAT       o_OVRSCOPE:0  o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *
     C                   MOVEL(P)  *IN99         o_IN99
      *
     C                   Z-ADD     256           o_QCMDL
     C                   CALL      'QCMDEXC'                            99
     C                   PARM                    o_QCMD
     C                   PARM                    o_QCMDL
      *
     C                   MOVEL(P)  *IN99         o_RETURN
      *
     C                   MOVEL(P)  o_IN99        *IN99
      *
     C                   Endsr
      *
      *====================================================*
      *  Ab hier folgen die Unterroutinen für die          *
      *  Prüfung auf ungültige Feldinhalte                 *
      *====================================================*
CHKC- *
      *
      *====================================================*
      *  Ab hier folgen die Unterroutinen für das          *
      *  Setzen/Löschen der NULL Indicator                 *
      *====================================================*
      *
     C     c_tgNullInd   Begsr
      *
     C                   Eval      xScnCsrRow = wScnCsrRow - WndTopRow
      *
     C                   Select
NULL- *
     C                   Endsl
      *
     C                   Endsr
      *
      *====================================================*
      *  Ab hier folgen die Unterroutinen für den          *
      *  Hex-Editor                                        *
      *====================================================*
HEX - *
      *
      *====================================================*
      *  Ab hier folgen die Unterroutinen für den          *
      *  String-Editor                                     *
      *====================================================*
TXT - *
      *
      *====================================================*
      *  Ab hier folgen die Unterroutinen für              *
      *  das Übertragen der Dateifelder in die Felder      *
      *  des Bildschirms.                                  *
      *  File --> Screen                                   *
      *====================================================*
TOS - *
      *
      *====================================================*
      *  Ab hier folgen die Unterroutinen für              *
      *  das Übertragen der Bildschirmfelder in die Felder *
      *  der Datei.                                        *
      *  Screen --> File                                   *
      *====================================================*
TOF - *
      *
