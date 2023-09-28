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
     FPEEK48FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
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
      /COPY QCOPYLE,PPEEK48
      /undefine internal_prototype
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
     D yFKeys          S             18A   DIM(32) inz
     D yNbrOfKeys      S                   like(int4_t) inz
     D yMsgID          S              7A   INZ(*BLANKS)
     D yMsgDta         S            512A   INZ(*BLANKS)
      *
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(pgmCmdDt_t) inz
      *
     D YField          S             10A   INZ(*BLANKS)
      *
     D YSqlOrder       S            512A   INZ(*BLANKS)
      *
     D YRetFile        S             10A   INZ(*BLANKS)
     D YRetLib         S             10A   INZ(*BLANKS)
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D SfBot           S                   like(int4_t) inz
     D NbrFKeys        C                   CONST(3)
      *
     D PEEK21_NAME     S                   like(pgmCallN_t) inz
     D PEEK23_NAME     S                   like(pgmCallN_t) inz
     D PEEK37_NAME     S                   like(pgmCallN_t) inz
     D PEEK38_NAME     S                   like(pgmCallN_t) inz
     D PEEK40_NAME     S                   like(pgmCallN_t) inz
      *
     D tempScnFld      S                   Like(scnFld  ) inz
     D tempFldPos      S                   Like(FldPos  ) inz
     D tempField       S                   Like(##WHERE ) inz
     D tempLen         S                   like(int4_t) inz
     D tempCsrRow      S                   like(int4_t) inz
     D tempCsrCol      S                   like(int4_t) inz
     D tempFldLen      S                   like(int4_t) inz
     D tempFldBy       S                   like(int4_t) inz
      *
     D pFile           DS                  qualified
     D  name                               like(io_file)
     D  library                            like(io_library)
     D  member                             like(io_member)
     D  format                             like(io_rcdFmt)
      *
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK37
      /COPY QCOPYLE,PPEEK38
      /COPY QCOPYLE,PPEEK40
      *
      /COPY QCOPYLE,F_PEEK51
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK63
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK48          PI
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  io_file                                  like(file_t)
     D  io_library                               like(lib_t)
     D  io_member                                like(mbr_t)
     D  io_rcdFmt                                like(fmt_t)
     D  i_accessMode                       const like(accessMode_t)
     D  io_sqlWhere                              like(sqlWhere_t)
     D  io_sqlOrder                              like(sqlOrder_t)
     D  i_enableWhere                      const like(bool_t)
     D  i_enableOrder                      const like(bool_t)
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
      *  Nachrichten senden
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
      *  Nachrichten anzeigen
     C                   EVAL      *IN89 = '0'
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
     C                   EVAL      SFBOT = 1
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
     C                   CALLP     PEEK21(§ScnAID: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C     YMsgID        IFNE      *BLANKS
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
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
     C                   EVAL      o_msgID = 'USR8112'
     C                   EVAL      o_msgDta = *BLANKS
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
     C                   Eval      io_file      = pFile.name
     C                   Eval      io_library   = pFile.library
     C                   Eval      io_member    = pFile.member
     C                   Eval      io_rcdFmt    = pFile.format
     C                   Eval      io_sqlWhere  = ##WHERE
     C                   Eval      io_sqlOrder  = ##ORDER
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
     C     §ScnAID       WHENEQ    §F3
     C                   EVAL      USR81001 = 'F3'
     C     §ScnAID       WHENEQ    §F12
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
      *    C_Prompt      F4  - Prompt                              *
      *============================================================*
      *
     C     C_Prompt      BEGSR
      *
     C                   SELECT
     C     tempScnFld    WHENEQ    '##WHERE'
     C     ##WHERE       OREQ      SET_PRMT
     C                   IF        *IN71 = *ON
     C                   EVAL      §MsgID = 'USR8195'
     C                   EVAL      §MsgDta = *BLANKS
     C                   ELSE
     C                   EXSR      Pmt_Field
     C                   ENDIF
      *
     C     tempScnFld    WHENEQ    '##ORDER'
     C     ##ORDER       OREQ      SET_PRMT
     C                   IF        *IN72 = *ON
     C                   EVAL      §MsgID = 'USR8195'
     C                   EVAL      §MsgDta = *BLANKS
     C                   ELSE
     C                   EXSR      Pmt_Field
     C                   ENDIF
      *
     C                   OTHER
     C                   EVAL      §MsgID = 'USR8179'
     C                   EVAL      §MsgDta = *BLANKS
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
     C                   CALLP     PEEK37(i_dsp80: i_copyright: YField
     C                                    :  yMsgID: yMsgDta)
      *
     C     yMsgID        IFEQ      *BLANKS
      *
     C**   ' '           Checkr    yField        tempLen
     C                   Eval      tempLen = %checkr(' ': yField)
      *
     C                   Select
     C     tempScnFld    WHENEQ    '##WHERE'
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
     C                   EVAL      §MsgID = yMsgID
     C                   EVAL      §MsgDta = yMsgDta
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
     C                   EVAL      §MsgID = 'USR8195'
     C                   EVAL      §MsgDta = *BLANKS
     C                   ELSE
     C                   EXSR      Slc_Key
     C                   ENDIF
     C                   OTHER
     C                   EVAL      §MsgID = 'USR8211'
     C                   EVAL      §MsgDta = *BLANKS
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
     C                   CALLP     PEEK40(i_dsp80: i_copyright
     C                                    : io_file: io_library: io_member
     C                                    : io_rcdFmt: bTrue
     C                                    : YRetFile: YRetLib
     C                                    : yMsgID: yMsgDta)
     C     YRetFile      IFEQ      *BLANKS
     C     *IN99         OREQ      '1'
      *  ... keine Auswahl getroffen
     C                   ELSE
     C                   EVAL      io_file = YRetFile
     C                   EVAL      io_library = YRetLib
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
     C                   EVAL      §MsgID = 'USR8195'
     C                   EVAL      §MsgDta = *BLANKS
     C                   ELSE
     C                   EXSR      Ins_Field
     C                   ENDIF
     C                   OTHER
     C                   EVAL      §MsgID = 'USR8211'
     C                   EVAL      §MsgDta = *BLANKS
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
     C                   EVAL      YSqlOrder = ''
     C                   CALLP     PEEK38(io_file: io_library: YSqlOrder)
      *
     C                   Eval      tempField = YSqlOrder
     C**   ' '           Checkr    tempField     tempLen
     C                   Eval      tempLen = %checkr(' ': tempField)
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
     C                   Eval      $$SQL = 'SELECT * FROM '      +
     C                                     %trim(pFile.library)  +
     C                                     '/'                   +
     C                                     %trim(pFile.name)     +
     C                                     '('                   +
     C                                     %trim(pFile.member)   +
     C                                     ')'                   +
     C                                     ' ...'
      *
     C                   EVAL      ##WHERE = io_sqlWhere
     C                   EVAL      ##ORDER = io_sqlOrder
      *
     C                   If        (i_accessMode = KEY_SEQ) and
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
     C                   EVAL      CsrRow = §ScnCsrRow - Zei
     C                   EVAL      CsrCol = §ScnCsrCol - Pos
     C                   EVAL      CsrCol = CsrCol - 1
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
     C                   EVAL      CsrRow = *ZEROS
     C                   EVAL      CsrCol = *ZEROS
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
     C     i_dsp80       IFEQ      '0'
      *   132-Zeichen Anzeige
     C                   EVAL      *IN88 = '0'
     C                   EVAL      ZEI = 2
     C                   EVAL      POS = 16
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   EVAL      *IN88 = '1'
     C                   EVAL      ZEI = 2
     C                   EVAL      POS = 5
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
     C                   Callp     f_basedPF(io_file    :
     C                                       io_library :
     C                                       io_member  :
     C                                       io_rcdFmt  :
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
     C                   If        i_enableWhere = bTrue
     C                   Eval      *IN71 = *OFF
     C                   Else
     C                   Eval      *IN71 = *ON
     C                   Endif
      *
     C                   If        i_enableOrder = bTrue
     C                   Eval      *IN72 = *OFF
     C                   Else
     C                   Eval      *IN72 = *ON
     C                   Endif
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
     C                   EXSR      DltCsrPos
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
     C                   Eval      PEEK37_NAME = f_pgmCallN('PEEK37')
     C                   Eval      PEEK38_NAME = f_pgmCallN('PEEK38')
     C                   Eval      PEEK40_NAME = f_pgmCallN('PEEK40')
      *
     C                   Callp     PEEK23(§§PgmName: '*ALL': NbrFKeys
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
