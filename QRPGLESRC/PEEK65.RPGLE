      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 3.1.0                               *
      *  Programm : PEEK65                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 29.06.2008  Raddatz                               *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Drucken Datensatz                                            *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEK65P   O    E             PRINTER USROPN
     F                                     OFLIND(*IN60)
     F                                     INFSR(*PSSR)
      * Feldliste
     FPEEKFLDL0 IF   E           K DISK    USROPN
     F                                     RENAME(FPEEKFLD:FPEEKFLDL0)
     F                                     INFSR(*PSSR)
     F                                     INFDS(Peek_00_DS)
     F                                     PREFIX(F_)
      *
      * Für Einzelsatzzugriff zum reinen Lesen von Datensätzen
     D hFile04         DS                   likeds(r§hFile  )
      *----------------------------------------------------*
      *
     D IO_Buff         DS
     D  IO_BuffFld                         like(r§rcdBuf)
      *
     D IO_NullMap      S                   like(r§nullMap)
     D                                     dim(§nullMapSize)
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_INFDS
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
      /COPY QCOPYLE,OBJD0400
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  I N F D S - D E F I N I T I O N E N               *
      *----------------------------------------------------*
      *
     D Peek_00_DS      DS                  likeds(r§infds)
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
      *  *ENTRY Liste
     D XRcdNbr         S                   LIKE(R§RcdNbr)
     D XFile           S             10A
     D XLibrary        S             10A
     D XMember         S             10A
     D XRcdFormat      S             10A
     D XMsgID          S                   like(r§msgID   )
     D XMsgDta         S                   like(r§msgDta  )
      *
      *  Parameterfelder Peek06/Peek32
     D YData           S            512A                    inz(*BLANKS)
     D YFormat         S             10A
     D YSrcVar         S                   like(r§rcdBuf  ) inz(*BLANKS)
     D YPgmCall        S              1A                    inz(bFalse )
     D YCvtCcsid       S              1A                    inz(bTrue  )
     D YString         S                   like(r§rcdBuf  ) inz(*BLANKS)
     D YStrLen         S                   like(r§int4    ) inz
     D YCcsid          S                   like(r§int4    ) inz
     D YMsgID          S              7A                    inz(*BLANKS)
     D YMsgDta         S            512A                    inz(*BLANKS)
      *
      *  Peek09
     D YQFile          DS
     D  YFile                        10A   INZ(*BLANKS)
     D  YLibrary                     10A   INZ(*BLANKS)
     D YValue          S            512A   INZ(*BLANKS)
      *YMsgID          S              7A   INZ(*BLANKS)
      *YMsgDta         S            512A   INZ(*BLANKS)
      *
      *  Arbeitsfelder
     D IsRecord        S                   like(r§bool    ) inz(bFalse)
     D IsCvtChar       S                   like(r§bool    ) inz(bFalse)
     D IsPrinted       S                   like(r§bool    ) inz(bFalse)
      *
     D x               S                   like(r§int4    ) inz
     D y               S                   like(r§int4    ) inz
     D textLen         S                   like(r§int4    ) inz
      *
     D R$TEXT          S                   like(FLDL0100_t.F1FTxt) inz
      *
      *  Qualifizierte Programmnamen
     D PEEK06          S                   like(r§pgmCallN) inz
     D PEEK09          S                   like(r§pgmCallN) inz
     D PEEK32          S                   like(r§pgmCallN) inz
      *
      *  Konstanten
     D cQUOTE          C                   ''''
      *
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
     C                   PARM                    XRcdNbr
     C                   PARM                    XFile
     C                   PARM                    XLibrary
     C                   PARM                    XMember
     C                   PARM                    XRcdFormat
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK06
     C     P_Peek06      PLIST
     C                   PARM                    YData
     C                   PARM                    YFormat
     C                   PARM                    YSrcVar
     C                   PARM                    YPgmCall
     C                   PARM                    YCvtCcsid
     C                   PARM                    YString
     C                   PARM                    YStrLen
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK09
     C     P_Peek09      PLIST
     C                   PARM                    YQFile
     C                   PARM                    YValue
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK32
     C     P_Peek32      PLIST
     C                   PARM                    yString
     C                   PARM                    yStrLen
     C                   PARM                    yCcsid
     C                   PARM                    yMsgID
     C                   PARM                    yMsgDta
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLDL0
     C     F1KEY_L0      KLIST
     C                   KFLD                    F_FLDSEQ
      *
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
      *
      *---------------------------------------------------*
      *  Drucken Datensatz
     C                   EXSR      PBInit
     C                   EXSR      PBSetLL
     C                   EXSR      PBReadUp
      *
     C                   IF        IsCvtChar = bTrue
     C                   EXSR      PBSeite
     C                   WRITE     ERROR
     C                   ENDIF
      *
     C                   IF        IsPrinted = bTrue
     C                   EVAL      XMsgID  = 'USR8226'
     C                   EVAL      XMsgDta = ''
     C                   ENDIF
      *
      *  Ende der Hauptschleife
      *---------------------------------------------------*
      *
      *  Programm verlassen
     C     ENDE          TAG
      *
     C                   CLOSE     PEEK65P
     C                   CLOSE     PEEKFLDL0
     C                   CALLP     CIO_close(hFile04)
      *
     C                   RETURN
      *
      *============================================================*
      *    PBInit        Initialisieren der Subfile zur Anzeige    *
      *                  der nächsten Seite                        *
      *============================================================*
      *
     C     PBINIT        BEGSR
      *
      *  Überlaufzeile
     C                   EVAL      *IN60 = bTrue
      *
      *  Kopfinformationen
     C                   Eval      $$FILE = XFile
     C                   Eval      $$LIB  = XLibrary
     C                   Eval      $$RRN  = %editc(XRcdNbr: 'X')
     C                   Eval      $$DESC = O4Text
      *
      *  Konvertieren nicht darstellbarer Zeichen
     C                   EVAL      IsCvtChar = bFalse
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSetLL       Setzen Dateizeiger                        *
      *============================================================*
      *
     C     PBSetLL       Begsr
      *
     C                   Eval      F_FLDSEQ = 0
     C     F1Key_L0      Setll     FPEEKFLDL0
      *
     C                   Endsr
      *
      *============================================================*
      *    PBReadUP      Drucken Datenzeilen                       *
      *============================================================*
      *
     C     PBReadUP      BEGSR
      *
     C                   Do        *hival
     C                   Read      FPEEKFLDL0                             83
     C                   If        *in83 = *on
     C                   Leave
     C                   Endif
      *
      *  Feldattribute
     C                   MOVEL (P) F_FFD         FLDL0100
      *
      *  nicht erlaubte Feldtypen
     C                   If        f_isNotAlw(FLDL0100) = bTrue
     C                   Iter
     C                   Endif
      *
      *  Ausgeben Feld
     C                   Clear                   ITEM
     C                   Eval      $$FNME = FLDL0100.F1FNme
      *
     C                   Z-ADD     1             x
     C                   Z-ADD     1             y
     C                   Exsr      PBFill
      *
     C                   Dow       x <= YStrLen or y <= textLen
      *
     C                   Exsr      PBSeite
      *
     C                   If        y <= %len(R$TEXT)
     C                   Eval      $$TEXT = %subst(R$TEXT : y: %len($$TEXT))
     C                   Else
     C                   Eval      $$TEXT = ''
     C                   Endif

     C                   If        x <= %len(YString)
     C                   Eval      $$DATA = %subst(YString: x: %len($$DATA))
     C                   Else
     C                   Eval      $$DATA = ''
     C                   Endif
      *
     C                   Write     ITEM
     C                   Eval      x = x + %len($$DATA)
     C                   Eval      y = y + %len($$TEXT)
     C                   Eval      $$FNME = ''
     C                   Eval      $$TEXT = ''
      *
     C                   Eval      IsPrinted = bTrue
     C                   Enddo
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBFill        Füllen Datenzeile                         *
      *============================================================*
      *
     C     PBFill        BEGSR
      *
      *      ... überschreiben EDTCDE
     C                   if        (F_EDTCDE <> '')
     C                   eval      FLDL0100.F1EDTC = F_EDTCDE
     C                   else
      *       Original EDITCODE verwenden
     C                   endif
      *
      *      ... eintragen Feldbezeichnung
     C                   if        (FLDL0100.F1FTxt = '')
     C                   eval      R$TEXT = '-'
     C                   else
     C                   eval      R$TEXT = FLDL0100.F1FTxt
     C                   endif
      *
     C                   eval      textLen = %len(%trimR(R$TEXT))
      *
      *  ... NULL erlaubt?
     C                   IF        FLDL0100.F1NALW = '1' and
     C                             IO_NullMap(FLDL0100.F1SEQ) = 1
     C                   EVAL      YString = f_msgText('TXT0127': '')
     C                   EVAL      YStrLen = %len(%trimR(YString))
     C                   ELSE
      *
      *  ... aufbereiten des Feldinhaltes
     C                   MOVEL (P) FLDL0100      YData
     C                   MOVEL (P) 'FLDL0100'    YFormat
     C                   MOVEL (P) IO_Buff       YSrcVar
     C                   MOVEL (P) bFalse        YPgmCall
     C                   MOVEL (P) bTrue         YCvtCcsid
     C                   CALL      PEEK06        P_Peek06               99
      *
      *  ... Konvertieren nicht darstellbarer Zeichen
     C                   Z-ADD     *ZEROS        yCcsid
     C                   CALL      PEEK32        P_Peek32               99
     C     *IN99         IFEQ      '0'
      *
     C                   IF        f_isCharFld(FLDL0100) = bTrue and
     C                             YStrLen < %len(YString) - 2
     C                   EVAL      %subst(YString: YStrLen+1: 1) = cQUOTE
     C                   EVAL      YStrLen = YStrLen + 1
     C                   EVAL      %subst(YString: 2) = YString
     C                   EVAL      %subst(YString: 1: 1) = cQUOTE
     C                   EVAL      YStrLen = YStrLen + 1
     C                   ENDIF
      *
     C     IsCvtChar     IFEQ      bFalse
     C     YMsgID        IFNE      *BLANKS
     C                   EVAL      IsCvtChar = bTrue
     C                   EVAL      $$ERROR = f_msgText(YMsgID: YMsgDta)
     C                   ELSE
      *         keine Nachricht anstehend
     C                   Endif
     C                   ELSE
      *         Nachricht bereits gesendet
     C                   Endif
     C                   ELSE
      *         Fehler bei Programmaufruf
     C                   Endif
      *
      *  Ende: FLDL0100.F1NALW
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSeite       Prüfen auf Seitenwechsel                  *
      *============================================================*
      *
     C     PBSeite       Begsr
      *
     C                   If        *IN60 = bTrue
     C                   Write     NEWPAGE
     C                   Write     HEAD1
     C                   Write     HEAD2
     C                   Write     HEAD3
     C                   EVAL      *IN60 = bFalse
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    GetObjText    Abrufrufen der Objektbezeichnung          *
      *============================================================*
      *
     C     GetObjText    BEGSR
      *
     C                   Eval      YFile    = XFile
     C                   Eval      YLibrary = XLibrary
     C                   Call      PEEK09        P_Peek09               99
     C                   If        *IN99 = '1'
     C                   Clear                   OBJD0400
     C                   Else
     C                   Eval      OBJD0400 = YValue
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    ReadRcd       Einlesen des anzuzeigenden Satzes         *
      *============================================================*
      *
     C     ReadRcd       BEGSR
      *
     C                   IF        CIO_chainWithRRN(hFile04
     C                                              : XRcdNbr
     C                                              : bFalse
     C                                              : IO_Buff
     C                                              : IO_NullMap) = bFalse
     C                   MOVEL (P) bFalse        IsRecord
     C                   ELSE
     C                   MOVEL (P) bTrue         IsRecord
     C                   ENDIF
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
     C                   Eval      §QCmd = 'OVRPRTF +
     C                                        FILE(PEEK65P) +
     C                                        TOFILE(' +
     C                                           %trimR(§§PgmLib) + '/PEEK65P) +
     C                                        SPLFNAME(' +
     C                                           %trim(XFILE) + ') +
     C                                        USRDTA(''' +
     C                                           %editc(XRcdNbr: 'X') + ''') +
     C                                        OVRSCOPE(*CALLLVL)'
      /COPY QCOPYLE,QCMDEXC
      *
     C                   OPEN      PEEK65P
     C                   OPEN      PEEKFLDL0
     C                   CALLP     CIO_open(hFile04
     C                                      : xFile
     C                                      : xLibrary
     C                                      : xMember
     C                                      : xRcdFormat
     C                                      : 'rr,arrseq=Y,nullcap=Y,riofb=Y')
      *
      * - Programm initialisieren
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
      * - Einlesen Objektbeschreibung
     C                   EXSR      GetObjText
      *
      * - Einlesen des anzuzeigenden Satzes
     C                   EXSR      ReadRcd
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        Begsr
      *
     C                   Eval      PEEK06 = f_pgmCallN('PEEK06')
     C                   Eval      PEEK09 = f_pgmCallN('PEEK09')
     C                   Eval      PEEK32 = f_pgmCallN('PEEK32')
      *
     C                   Eval      TXT0132 = f_msgText('TXT0132': '')           Datei:
     C                   Eval      TXT0133 = f_msgText('TXT0133': '')           Bibliothek:
     C                   Eval      TXT0134 = f_msgText('TXT0134': '')           RRN:
     C                   Eval      TXT0135 = f_msgText('TXT0135': '')           Seite:
     C                   Eval      TXT0136 = f_msgText('TXT0136': '')           Feldname
     C                   Eval      TXT0137 = f_msgText('TXT0137': '')           Feldbeschr.
     C                   Eval      TXT0138 = f_msgText('TXT0138': '')           Feldinhalt
     C                   Eval      TXT0139 = f_msgText('TXT0139': '')           Text:
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
