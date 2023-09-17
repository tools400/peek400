      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK50                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 16.03.99  Raddatz                                 *
      *  geändert : 27.04.99  2.1.0                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - SQL-Select/Order by                               *
      *                                                               *
      * ============================================================= *
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<<  CALL PGM(&LI/PEEK99) PARM(+                     *
      *                        '&SF' '&SL' '&SM' '&LI' '*NO' +        *
      *                        'PEEK' '&LI' '*NO') +                  *
      *               /* OPTION(*EVENTF) */;                          *
      *   >>EXECUTE<<                                                 *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEK48FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
     F                                     INFSR(*PSSR)
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
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0000
      /COPY QCOPYLE,SET0008
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8100
 CPY  */COPY QCOPYLE,USR8136
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
      /COPY QCOPYLE,KEYL0100
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D xDsp80          S              1A
     D xCopyRight      S            512A
     D xFile           S             10A
     D xLibrary        S             10A
     D xMember         S             10A
     D xFormat         S             10A
     D xAccess         S              1A
     D xSqlWhere       S            512A
     D xSqlOrder       S            512A
     D xChgSqlW        S              1A
     D xChgSqlO        S              1A
     D xMsgID          S              7A
     D xMsgDta         S            512A
      *
      *  Peek23:
     D yPgm            S             10A   inz
     D yKey            S             10A   inz
     D yPosF24         S                   like(r§int4    ) inz
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(r§int4    ) inz
     D yMsgID          S              7A   INZ(*BLANKS)
     D yMsgDta         S            512A   INZ(*BLANKS)
      *
      *  Peek21:
     D YScnAID         S             10A   INZ(*BLANKS)
      *YPgm            S             10A   INZ(*BLANKS)
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(r§pgmCmdDt) INZ(*BLANKS)
      *YMsgID          S              7A   INZ(*BLANKS)
      *YMsgDta         S            512A   INZ(*BLANKS)
      *
      *  Peek37:
     D YDsp80          S              1A   INZ(*BLANKS)
     D YCopyRight      S            512A   INZ(*BLANKS)
     D YField          S             10A   INZ(*BLANKS)
      *YMsgID          S              7A   INZ(*BLANKS)
      *YMsgDta         S            512A   INZ(*BLANKS)
      *
      *  Peek38:
     D                 DS
      *YFile                         10A   INZ(*BLANKS)
      *YLibrary                      10A   INZ(*BLANKS)
     D YSqlOrder       S            512A   INZ(*BLANKS)
      *
      *  Peek40:
      *YDsp80          S              1A   INZ(*BLANKS)
      *YCopyRight      S            512A   INZ(*BLANKS)
     D YFile           S             10A   INZ(*BLANKS)
     D YLibrary        S             10A   INZ(*BLANKS)
     D YMember         S             10A   INZ(*BLANKS)
     D YFmtName        S             10A   inz(*BLANKS)
     D YBasePhyF       S              1A   INZ(bTrue  )
     D YRetFile        S             10A   INZ(*BLANKS)
     D YRetLib         S             10A   INZ(*BLANKS)
      *YMsgID          S              7A   INZ(*BLANKS)
      *YMsgDta         S            512A   INZ(*BLANKS)
      *
      *  Peek41:
     D                 DS
     D YQFile                        20A   INZ(*BLANKS)
     D  YFileDS                      10A   OVERLAY(YQFile: 1)
     D  YLibDS                       10A   OVERLAY(YQFile:11)
     D YRcdFormat      S             10A   INZ(*BLANKS)
     D YFunction       S             10A   INZ(*BLANKS)
     D YNbrOfEnt       S                   like(r§int4    ) inz
     D YData           S            512A   INZ(*BLANKS)
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D SfBot           S                   like(r§int4    ) inz
     D NbrFKeys        C                   CONST(3)
      *
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
     D PEEK37          S                   like(r§pgmCallN) inz
     D PEEK38          S                   like(r§pgmCallN) inz
     D PEEK40          S                   like(r§pgmCallN) inz
     D PEEK41          S                   like(r§pgmCallN) inz
      *
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
      *
     D tempScnFld      S                   Like(scnFld  ) inz
     D tempFldPos      S                   Like(FldPos  ) inz
     D tempField       S                   Like(##WHERE ) inz
     D tempLen         S                   like(r§int4    ) inz
     D tempCsrRow      S                   like(r§int4    ) inz
     D tempCsrCol      S                   like(r§int4    ) inz
     D tempFldLen      S                   like(r§int4    ) inz
     D tempFldBy       S                   like(r§int4    ) inz
      *
     D NbrOfKey        S                   like(r§int4    ) inz
      *
     D pFile           DS                  qualified
     D  name                               like(xFile)
     D  library                            like(xLibrary)
     D  member                             like(xMember)
     D  format                             like(xFormat)

      /COPY QCOPYLE,F_PEEK51
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK63
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     C     *ENTRY        PLIST
     C                   PARM                    xDsp80
     C                   PARM                    xCopyRight
     C                   PARM                    xFile
     C                   PARM                    xLibrary
     C                   PARM                    xMember
     C                   PARM                    xFormat
     C                   PARM                    xAccess
     C                   PARM                    xSqlWhere
     C                   PARM                    xSqlOrder
     C                   PARM                    xChgSqlW
     C                   PARM                    xChgSqlO
     C                   PARM                    xMsgID
     C                   PARM                    xMsgDta
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
      *  Parameterliste für PEEK37
     C     P_Peek37      PLIST
     C                   PARM                    YDsp80
     C                   PARM                    YCopyRight
     C                   PARM                    YField
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK38
     C     P_Peek38      PLIST
     C                   PARM                    YFile
     C                   PARM                    YLibrary
     C                   PARM                    YSqlOrder
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK40
     C     P_Peek40      PLIST
     C                   PARM                    YDsp80
     C                   PARM                    YCopyRight
     C                   PARM                    YFile
     C                   PARM                    YLibrary
     C                   PARM                    YMember
     C                   PARM                    YFmtName
     C                   PARM                    YBasePhyF
     C                   PARM                    YRetFile
     C                   PARM                    YRetLib
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
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
      *
      *---------------------------------------------------*
      *  Schleife für Programmbearbeitung
      *
     C                   DO        *HIVAL
      *
      *  Nachrichten senden
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
      *  Nachrichten anzeigen
     C                   MOVE      '0'           *IN89
     C                   WRITE     MSGCTL
      *
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
      *  Anzeigen Bildschirm
     C                   EXFMT     BILD01
      *
      *  Berechnen Zeile/Spalte
     C     §ScnCsrPos    DIV       256           §ScnCsrRow
     C                   MVR                     §ScnCsrCol
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Merken Cursorposition
     C                   EXSR      KeepCsrPos
      *
      *  Bezugszahlen löschen
     C                   EXSR      BZOFF1
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
      *  Abfragen der Programmbefehle
     C                   SELECT
      *  F3  - Ende
     C     YPgmCmd       WHENEQ    '*EXIT'                                      ENDE
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *  F4  - Prompt
     C     YPgmCmd       WHENEQ    '*PROMPT'                                    ENDE
     C                   Eval      tempScnFld = scnFld
     C                   Eval      tempFldPos = FldPos
     C                   EXSR      C_Prompt
     C                   ITER
      *
      *  F5  - Aktualisieren
     C     YPgmCmd       WHENEQ    '*REFRESH'                                   AKTUALISIEREN
     C                   EXSR      C_Refresh
     C                   ITER
      *
      *  F9  - Auswählen Sortierfolge
     C     YPgmCmd       WHENEQ    '*DSPDBR'
     C                   Eval      tempScnFld = scnFld
     C                   Eval      tempFldPos = FldPos
     C                   EXSR      C_SelectKy
     C                   ITER
      *
      *  F11 - Einfügen Keyfelder
     C     YPgmCmd       WHENEQ    '*INSKEYFLD'                                 AKTUALISIEREN
     C                   Eval      tempScnFld = scnFld
     C                   Eval      tempFldPos = FldPos
     C                   EXSR      C_InsKeyFd
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
     C                   MOVEL (P) 'USR8112'     xMsgID
     C                   MOVEL (P) *BLANKS       xMsgDta
     C                   LEAVE
     C                   Endif
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
     C                   CLOSE     PEEK48FM
      *
     C                   RETURN
      *
      *============================================================*
      *    C_Enter       "Datenfreigabetaste"                      *
      *============================================================*
      *
     C     C_Enter       BEGSR
      *
     C                   Exsr      DltCsrPos
      *
     C                   Eval      ##ORDER = SQL_quote(##ORDER)
      *
     C                   If        SQL_prepareStatement(
     C                                        '1'       :
     C                                        pFile.name    :
     C                                        pFile.library :
     C                                        pFile.member  :
     C                                        pFile.format  :
     C                                        ##WHERE       :
     C                                        ##ORDER       :
     C                                        §MsgID        :
     C                                        §MsgDta       )
     C                             = bTrue
     C                   Eval      xFile      = pFile.name
     C                   Eval      xLibrary   = pFile.library
     C                   Eval      xMember    = pFile.member
     C                   Eval      xFormat    = pFile.format
     C                   Eval      xSqlWhere  = ##WHERE
     C                   Eval      xSqlOrder  = ##ORDER
     C                   Eval      *IN99 = '0'
     C                   Else
     C                   Eval      *IN99 = '1'
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
      *
      *  DSPATR(RI)
      *
      *  Fehler
     C                   MOVEL (P) '0'           *IN99
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
     C                   MOVEL (P) 'USR8100'     xMsgID
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
     C                   MOVEL (P) USR8100       xMsgDta
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Prompt      F4  - Prompt                              *
      *============================================================*
      *
     C     C_Prompt      BEGSR
      *
     C                   SELECT
     C     tempScnFld    WHENEQ    '##WHERE'
     C     ##WHERE       OREQ      SET_PRMT
     C                   IF        *IN71 = *ON
     C                   MOVEL (P) 'USR8195'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   ELSE
     C                   EXSR      Pmt_Field
     C                   ENDIF
      *
     C     tempScnFld    WHENEQ    '##ORDER'
     C     ##ORDER       OREQ      SET_PRMT
     C                   IF        *IN72 = *ON
     C                   MOVEL (P) 'USR8195'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   ELSE
     C                   EXSR      Pmt_Field
     C                   ENDIF
      *
     C                   OTHER
     C                   MOVEL (P) 'USR8179'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    Pmt_Field     Prompt - Field                            *
      *============================================================*
      *
     C     Pmt_Field     BEGSR
      *
     C                   MOVEL (P) xDsp80        YDsp80
     C                   MOVEL (P) xCopyRight    YCopyRight
     C                   CALL      PEEK37        P_Peek37
      *
     C     yMsgID        IFEQ      *BLANKS
      *
     C     ' '           Checkr    yField        tempLen
      *
     C                   Select
     C     tempScnFld    WHENEQ    '##WHERE'
      **                 Eval      %subst(##WHERE: tempFldPos: tempLen)
      ***                           = yField
     C                   Eval      ##WHERE = %replace(%trimR(yField) + ' '
     C                                                : ##WHERE
     C                                                : tempFldPos
     C                                                : 0)
     C                   Eval      tempCsrRow =  5
     C                   Eval      tempCsrCol = 17
     C                   Eval      tempFldPos = tempFldPos + tempLen + 1
     C                   Eval      tempFldLen = %len(##WHERE)
     C                   Eval      tempFldBy  = 42
      *
     C     tempScnFld    WHENEQ    '##ORDER'
      ***                Eval      %subst(##ORDER : tempFldPos: tempLen)
      ***                           = yField
     C                   Eval      ##ORDER  = %replace(%trimR(yField) + ' '
     C                                                 : ##ORDER
     C                                                 : tempFldPos
     C                                                 : 0)
     C                   Eval      tempCsrRow = 12
     C                   Eval      tempCsrCol = 17
     C                   Eval      tempFldPos = tempFldPos + tempLen + 1
     C                   Eval      tempFldLen = %len(##WHERE)
     C                   Eval      tempFldBy  = 42
      *
     C                   Endsl
      *
     C                   If        tempFldPos > tempFldLen
     C                   Eval      tempFldPos = tempFldLen
     C                   Endif
      *
     C                   If        %rem(tempFldPos: tempFldBy) = 0
     C                   Eval      tempCsrCol = tempCsrCol + tempFldBy
     C                   Else
     C                   Eval      tempCsrCol = tempCsrCol +
     C                                          %rem(tempFldPos: tempFldBy)
     C                   Endif
      *
     C                   If        %rem(tempFldPos: tempFldBy) = 0
     C                   Eval      tempCsrRow = tempCsrRow +
     C                                          %int(tempFldPos/ tempFldBy) - 1
     C                   Else
     C                   Eval      tempCsrRow = tempCsrRow +
     C                                          %int(tempFldPos/ tempFldBy)
     C                   Endif
      *
     C                   Eval      CSRROW = tempCsrRow
     C                   Eval      CSRCOL = tempCsrCol - 1
      *
     C                   ELSE
     C                   MOVEL (P) yMsgID        §MsgID
     C                   MOVEL (P) yMsgDta       §MsgDta
     C                   Endif
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
      *    C_SelectKy    Auswählen Sortierfolge                    *
      *============================================================*
      *
     C     C_SelectKy    BEGSR
      *
     C                   SELECT
     C     tempScnFld    WHENEQ    '##ORDER'
     C                   IF        *IN72 = *ON
     C                   MOVEL (P) 'USR8195'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   ELSE
     C                   EXSR      Slc_Key
     C                   ENDIF
     C                   OTHER
     C                   MOVEL (P) 'USR8211'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    Slc_Key       Auswählen Sortierfolge                   *
      *============================================================*
      *
     C     Slc_Key       BEGSR
      *
     C                   MOVEL (P) xDsp80        YDsp80
     C                   MOVEL (P) xCopyRight    YCopyRight
     C                   MOVEL (P) xFile         YFile
     C                   MOVEL (P) xLibrary      YLibrary
     C                   MOVEL (P) xMember       YMember
     C                   MOVEL (P) xFormat       YFmtName
     C                   MOVEL (P) bTrue         YBasePhyF
     C                   CALL      PEEK40        P_Peek40
     C     YRetFile      IFEQ      *BLANKS
     C     *IN99         OREQ      '1'
      *  ... keine Auswahl getroffen
     C                   ELSE
     C                   MOVEL (P) YRetFile      YFile
     C                   MOVEL (P) YRetLib       YLibrary
     C                   EXSR      Ins_Field
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_InsKeyFd    Insert Key Fields                         *
      *============================================================*
      *
     C     C_InsKeyFd    BEGSR
      *
     C                   SELECT
     C     tempScnFld    WHENEQ    '##ORDER'
     C                   IF        *IN72 = *ON
     C                   MOVEL (P) 'USR8195'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   ELSE
     C                   MOVEL (P) xFile         YFile
     C                   MOVEL (P) xLibrary      YLibrary
     C                   EXSR      Ins_Field
     C                   ENDIF
     C                   OTHER
     C                   MOVEL (P) 'USR8211'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    Ins_Field     Insert Key Fields                         *
      *============================================================*
      *
     C     Ins_Field     BEGSR
      *
     C                   MOVEL (P) *BLANKS       YSqlOrder
     C                   CALL      PEEK38        P_Peek38
      *
     C                   Eval      tempField = YSqlOrder
     C     ' '           Checkr    tempField     tempLen
      *
     C                   Select
     C     tempScnFld    WHENEQ    '##WHERE'
     C                   Eval      %subst(##WHERE: tempFldPos: tempLen)
     C                              = tempField
     C     tempScnFld    WHENEQ    '##ORDER'
     C                   Eval      %subst(##ORDER : tempFldPos: tempLen)
     C                              = tempField
     C                   Endsl
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
      *    FILL##        Füllen Bildschirm                         *
      *============================================================*
      *
     C     FILL##        BEGSR
      *
     C                   Eval      $$SQL = 'SELECT * FROM '      +
     C                                     %trim(pFile.library)  +
     C                                     '/'                   +
     C                                     %trim(pFile.name)     +
     C                                     '('                   +
     C                                     %trim(pFile.member)   +
     C                                     ')'                   +
     C                                     ' ...'
      *
     C                   MOVEL (P) xSqlWhere     ##WHERE
     C                   MOVEL (P) xSqlOrder     ##ORDER
      *
     C                   If        (xAccess = §KeySeq) and
     C                             (##ORDER  = ' '    )
     C                   Eval      tempScnFld = '##ORDER'
     C                   Eval      tempFldPos = 1
     C                   Exsr      C_InsKeyFd
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    KeepCsrPos    Beibehalten der Cursorposition            *
      *============================================================*
      *
     C     KeepCsrPos    BEGSR
      *
      *  Beibehalten der Cursorosition
     C     §ScnCsrRow    SUB       Zei           CsrRow
     C     §ScnCsrCol    SUB       Pos           CsrCol
     C                   SUB       1             CsrCol
      *
     C                   ENDSR
      *
      *============================================================*
      *    DltCsrPos     Löschen der Cursorposition                *
      *============================================================*
      *
     C     DltCsrPos     BEGSR
      *
      *  Löschen der Cursorosition
     C                   Z-ADD     *ZEROS        CsrRow
     C                   Z-ADD     *ZEROS        CsrCol
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
      *============================================================*
      *
     C     GetUsrSetg    BEGSR
      *
      *  *PROMPT
     C                   Eval      SET0008 = f_getUsrSg('*PROMPT'   )
      *
     C                   ENDSR
      *
      *============================================================*
      *    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
      *============================================================*
      *
     C     SetScreen     BEGSR
      *
     C     xDsp80        IFEQ      '0'
      *   132-Zeichen Anzeige
     C                   MOVEL (P) '0'           *IN88
     C                   Z-ADD     2             ZEI
     C                   Z-ADD     16            POS
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   MOVEL (P) '1'           *IN88
     C                   Z-ADD     2             ZEI
     C                   Z-ADD     5             POS
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
      * - Ermitteln physische Datei
     C                   Callp     f_basedPF(xFile    :
     C                                       xLibrary :
     C                                       xMember  :
     C                                       xFormat  :
     C                                       1        :
     C                                       pFile.name    :
     C                                       pFile.library :
     C                                       pFile.member  :
     C                                       pFile.Format  )
      *
      * - Öffnen der Dateien
     C                   OPEN      PEEK48FM
      *
      * - Füllen der Bildschirmfelder
     C                   EXSR      BZOFF1
     C                   EXSR      FILL##
      *
      * - Setzen Ändern erlaubt für: WHERE und ORDER BY
     C                   If        xChgSqlW = bTrue
     C                   Eval      *IN71 = *OFF
     C                   Else
     C                   Eval      *IN71 = *ON
     C                   Endif
      *
     C                   If        xChgSqlO = bTrue
     C                   Eval      *IN72 = *OFF
     C                   Else
     C                   Eval      *IN72 = *ON
     C                   Endif
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
     C                   EXSR      DltCsrPos
      *
     C                   MOVEL (P) *BLANKS       xMsgID
     C                   MOVEL (P) *BLANKS       xMsgDta
      *
      * - Darstellung der Befehlstasten
     C                   Z-ADD     1             SfBot
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   EXSR      SetScreen
      *
      * - Copyright
      ***                MOVEL (P) 'USR9999'     §MsgID
      ***                MOVEL (P) xCopyRight    §MsgDta
      ***                Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
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
     C                   Eval      PEEK37 = f_pgmCallN('PEEK37')
     C                   Eval      PEEK38 = f_pgmCallN('PEEK38')
     C                   Eval      PEEK40 = f_pgmCallN('PEEK40')
     C                   Eval      PEEK41 = f_pgmCallN('PEEK41')
      *
     C                   Eval      yPgm    = §§PgmName
     C                   Eval      yKey    = '*ALL'
     C                   Eval      yPosF24 = NbrFKeys
     C                   Call      PEEK23        P_Peek23
     C                   Movea (P) YFKeys        ScrnFKeys
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
