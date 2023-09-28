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
     FPEEK65P   O    E             PRINTER USROPN
     F                                     OFLIND(*IN60)
      * Feldliste
     FPEEKFLDL0 IF   E           K DISK    USROPN
     F                                     RENAME(FPEEKFLD:FPEEKFLDL0)
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
      /define internal_prototype
      /COPY QCOPYLE,PPEEK65
      /undefine internal_prototype
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
     D OBJD0400        DS                  likeds(OBJD0400_t) inz
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
     D YString         S                   like(r§rcdBuf  )
     D YStrLen         S                   like(r§int4    )
     D YMsgID          S              7A
     D YMsgDta         S            512A
      *
     D YQFile          DS                  likeds(r§qObj) inz
      *
      *  Arbeitsfelder
     D IsRecord        S                   like(r§bool) inz(bFalse)
     D IsCvtChar       S                   like(r§bool) inz(bFalse)
     D IsPrinted       S                   like(r§bool) inz(bFalse)
      *
     D x               S                   like(r§int4)
     D y               S                   like(r§int4)
     D textLen         S                   like(r§int4)
      *
     D R$TEXT          S                   like(FLDL0100_t.F1FTxt)
      *
      *  Qualifizierte Programmnamen
     D PEEK06_NAME     S                   like(r§pgmCallN)
     D PEEK09_NAME     S                   like(r§pgmCallN)
     D PEEK32_NAME     S                   like(r§pgmCallN)
      *
      *  Konstanten
     D cQUOTE          C                   ''''
      *
      /COPY QCOPYLE,PPEEK06
      /COPY QCOPYLE,PPEEK09
      /COPY QCOPYLE,PPEEK32
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK63
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(r§bool) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK65          PI
     D  i_rcdNbr                           const like(r§rcdNbr)
     D  i_file                             const like(r§file)
     D  i_library                          const like(r§lib)
     D  i_member                           const like(r§mbr)
     D  i_rcdFormat                        const like(r§rcdFmt)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLDL0
     C     F1KEY_L0      KLIST
     C                   KFLD                    F_FLDSEQ
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
     C                   EVAL      o_msgID  = 'USR8226'
     C                   EVAL      o_msgDta = ''
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
     C                   Eval      $$FILE = i_file
     C                   Eval      $$LIB  = i_library
     C                   Eval      $$RRN  = %editc(i_rcdNbr: 'X')
     C                   Eval      $$DESC = OBJD0400.O4Text
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
     C                   EVAL      FLDL0100 = F_FFD
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
     C                   EVAL      x = 1
     C                   EVAL      y = 1
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
     C                   monitor
      *
      *  ... aufbereiten des Feldinhaltes
     C                   CALLP     PEEK06(FLDL0100: 'FLDL0100': IO_Buff
     C                                    : bFalse: bTrue: YString: YStrLen
     C                                    : YMsgID: YMsgDta)
      *
      *  ... Konvertieren nicht darstellbarer Zeichen
     C                   CALLP     PEEK32(yString: yStrLen: 0
     C                                    : YMsgID: YMsgDta)
      *
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
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
     C                   Eval      YQFile.name = i_file
     C                   Eval      YQFile.lib = i_library
     C                   Callp     PEEK09(YQFile: OBJD0400: YMsgID: YMsgDta)
     C                   monitor
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C                   If        *IN99 = '1'
     C                   Clear                   OBJD0400
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
     C                                              : i_rcdNbr
     C                                              : bFalse
     C                                              : IO_Buff
     C                                              : IO_NullMap) = bFalse
     C                   EVAL      IsRecord = bFalse
     C                   ELSE
     C                   EVAL      IsRecord = bTrue
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
     C                                           %trim(i_file) + ') +
     C                                        USRDTA(''' +
     C                                           %editc(i_rcdNbr: 'X') + ''') +
     C                                        OVRSCOPE(*CALLLVL)'
      /COPY QCOPYLE,QCMDEXC
      *
     C                   OPEN      PEEK65P
     C                   OPEN      PEEKFLDL0
     C                   CALLP     CIO_open(hFile04
     C                                      : i_file
     C                                      : i_library
     C                                      : i_member
     C                                      : i_rcdFormat
     C                                      : 'rr,arrseq=Y,nullcap=Y,riofb=Y')
      *
      * - Programm initialisieren
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
      * - Einlesen Objektbeschreibung
     C                   EXSR      GetObjText
      *
      * - Einlesen des anzuzeigenden Satzes
     C                   EXSR      ReadRcd
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
     C                   Eval      PEEK06_NAME = f_pgmCallN('PEEK06')
     C                   Eval      PEEK09_NAME = f_pgmCallN('PEEK09')
     C                   Eval      PEEK32_NAME = f_pgmCallN('PEEK32')
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
