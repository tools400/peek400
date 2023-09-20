      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK35                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 29.12.1997  Raddatz                               *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Prüfen Datensatz PEEKWRK für WRK0001 auf Plausibilität       *
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
      * Feldliste nach Anzeigefolge
     FPEEKWRK   IF   E           K DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     INFDS(Work_00_DS)
     F                                     PREFIX(W_)
      *
      *----------------------------------------------------*
      *  I N F D S - D E F I N I T I O N E N               *
      *----------------------------------------------------*
      *
     DWork_00_DS       DS                  likeds(r§infds)
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_INFDS
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8167
      /COPY QCOPYLE,USR8168
      /COPY QCOPYLE,USR8169
      /COPY QCOPYLE,USR8170
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---Farbattribute------------------------------------*
      /COPY QCOPYLE,D_COLORATR
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D XRcdNbr         S                   LIKE(R§RcdNbr)
     D XBuffer         S           1024A
     D XFldName        S             10A
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
     D IsError         S              1A   INZ(bFalse)
      *
      *---Arbeitsdatenbereich für PEEKWRK------------------*
      /COPY QCOPYLE,WRK0001
      *----------------------------------------------------*
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     C     *ENTRY        PLIST
     C                   PARM                    XRcdNbr
     C                   PARM                    XBuffer
     C                   PARM                    XFldName
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKWRK
     C     W0KEY         KLIST
     C                   KFLD                    W_Key
      *
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
      *
      *---------------------------------------------------*
      *  Schleife für Programmbearbeitung
      *
     C                   EXSR      PrfB1
      *
      *  Ende der Hauptschleife
      *---------------------------------------------------*
      *
      *  Programm verlassen
     C     ENDE          TAG
      *
     C                   CLOSE     PEEKWRK
      *
     C                   RETURN
      *
      *============================================================*
      *    PrfB1         Prüfen Datensatz                          *
      *============================================================*
      *
     C     PrfB1         BEGSR
      *
     C                   EVAL      IsError = bFalse
      *
     C                   EXSR      Prf20                                        = SEQ
     C     IsError       CABEQ     bTrue         EPrfB1
      *
     C                   EXSR      Prf21                                        = HIDDEN
     C     IsError       CABEQ     bTrue         EPrfB1
      *
     C                   EXSR      Prf22                                        = COLOR
     C     IsError       CABEQ     bTrue         EPrfB1
      *
     C                   EXSR      Prf23                                        = MARKCOL
     C     IsError       CABEQ     bTrue         EPrfB1
      *
     C                   EXSR      Prf24                                        = MAXSIZE
     C     IsError       CABEQ     bTrue         EPrfB1
      *
     C                   EXSR      Prf25                                        = EDTCDE
     C     IsError       CABEQ     bTrue         EPrfB1
      *
     C     EPrfB1        TAG
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prf20         Prüfen der Sortierfolge                   *
      *============================================================*
      *
     C     Prf20         BEGSR
      *
     C                   EVAL      W_Key = WRK_Seq
     C     W0Key         CHAIN     FPEEKWRK                           11
     C     *IN11         IFEQ      '1'
      *  Hurra, eindeutige Numnmer ...
     C                   ELSE
     C                   IF        Work_00_DS.RcdNbr = XRcdNbr
      *  ... auch gut, weil derselbe Datensatz
     C                   ELSE
      *  ... Fehler, doppelter Sortierfolgen-Nr.
     C                   EVAL      IsError = bTrue
     C                   EVAL      XMsgID = 'USR8167'
     C                   EVAL      XMsgDta = USR8167
     C                   GOTO      EPrf20
     C                   Endif
     C                   Endif
      *
     C     EPrf20        TAG
      *
     C     IsError       IFEQ      bTrue
     C                   EVAL      XFldName = 'SEQ'
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prf21         Prüfen des Attributs: Sichtbar            *
      *============================================================*
      *
     C     Prf21         BEGSR
      *
     C                   SELECT
     C     WRK_Hidden    WHENEQ    bTrue
      *  ist zulässig
     C     WRK_Hidden    WHENEQ    bFalse
      *  ist zulässig
     C                   OTHER
     C                   EVAL      IsError = bTrue
     C                   EVAL      XMsgID = 'USR8168'
     C                   EVAL      USR81681 = WRK_Hidden
     C                   EVAL      XMsgDta = USR8168
     C                   GOTO      EPrf21
     C                   Endsl
      *
     C     EPrf21        TAG
      *
     C     IsError       IFEQ      bTrue
     C                   EVAL      XFldName = 'HIDDEN'
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prf22         Prüfen des Attributs: Farbe               *
      *============================================================*
      *
     C     Prf22         BEGSR
      *
      *
     C     EPrf22        TAG
      *
     C     IsError       IFEQ      bTrue
     C                   EVAL      XFldName = 'COLOR'
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prf23         Prüfen des Attributs: Spaltenmarkierung   *
      *============================================================*
      *
     C     Prf23         BEGSR
      *
     C                   SELECT
     C     WRK_MrkCol    WHENEQ    bTrue
      *  ist zulässig
     C     WRK_MrkCol    WHENEQ    bFalse
      *  ist zulässig
     C                   OTHER
     C                   EVAL      IsError = bTrue
     C                   EVAL      XMsgID = 'USR8169'
     C                   EVAL      USR81691 = WRK_MrkCol
     C                   EVAL      XMsgDta = USR8169
     C                   GOTO      EPrf23
     C                   Endsl
      *
     C     EPrf23        TAG
      *
     C     IsError       IFEQ      bTrue
     C                   EVAL      XFldName = 'MARKCOL'
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prf24         Prüfen des Attributs: Max. Breite         *
      *============================================================*
      *
     C     Prf24         BEGSR
      *
     C     WRK_MaxSiz    IFGT      *ZEROS
      *  ist zulässig
     C                   ELSE
     C                   EVAL      IsError = bTrue
     C                   EVAL      XMsgID = 'USR8170'
     C                   EVAL      USR81701 = WRK_MaxSiz
     C                   EVAL      XMsgDta = USR8170
     C                   GOTO      EPrf24
     C                   Endif
      *
     C     EPrf24        TAG
      *
     C     IsError       IFEQ      bTrue
     C                   EVAL      XFldName = 'MAXSIZE'
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prf25         Prüfen des Attributs: Editiercode         *
      *============================================================*
      *
     C     Prf25         BEGSR
      *
      *
     C     EPrf25        TAG
      *
     C     IsError       IFEQ      bTrue
     C                   EVAL      XFldName = 'EDTCDE'
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
     C                   OPEN      PEEKWRK
      *
     C                   EVAL      WRK0001 = XBuffer
      *
      * - Rückkehrcode
     C                   EVAL      XFldName = *BLANKS
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   ENDSR
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
