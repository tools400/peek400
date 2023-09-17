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
     C                   MOVEL (P) bFalse        IsError
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
     C                   Z-ADD     WRK_Seq       W_Key
     C     W0Key         CHAIN     FPEEKWRK                           11
     C     *IN11         IFEQ      '1'
      *  Hurra, eindeutige Numnmer ...
     C                   ELSE
     C                   IF        Work_00_DS.RcdNbr = XRcdNbr
      *  ... auch gut, weil derselbe Datensatz
     C                   ELSE
      *  ... Fehler, doppelter Sortierfolgen-Nr.
     C                   MOVEL (P) bTrue         IsError
     C                   MOVEL (P) 'USR8167'     XMsgID
     C                   MOVEL (P) USR8167       XMsgDta
     C                   GOTO      EPrf20
     C                   Endif
     C                   Endif
      *
     C     EPrf20        TAG
      *
     C     IsError       IFEQ      bTrue
     C                   MOVEL (P) 'SEQ'         XFldName
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
     C                   MOVEL (P) bTrue         IsError
     C                   MOVEL (P) 'USR8168'     XMsgID
     C                   MOVEL (P) WRK_Hidden    USR81681
     C                   MOVEL (P) USR8168       XMsgDta
     C                   GOTO      EPrf21
     C                   Endsl
      *
     C     EPrf21        TAG
      *
     C     IsError       IFEQ      bTrue
     C                   MOVEL (P) 'HIDDEN'      XFldName
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
     C                   MOVEL (P) 'COLOR'       XFldName
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
     C                   MOVEL (P) bTrue         IsError
     C                   MOVEL (P) 'USR8169'     XMsgID
     C                   MOVEL (P) WRK_MrkCol    USR81691
     C                   MOVEL (P) USR8169       XMsgDta
     C                   GOTO      EPrf23
     C                   Endsl
      *
     C     EPrf23        TAG
      *
     C     IsError       IFEQ      bTrue
     C                   MOVEL (P) 'MARKCOL'     XFldName
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
     C                   MOVEL (P) bTrue         IsError
     C                   MOVEL (P) 'USR8170'     XMsgID
     C                   MOVEL (P) WRK_MaxSiz    USR81701
     C                   MOVEL (P) USR8170       XMsgDta
     C                   GOTO      EPrf24
     C                   Endif
      *
     C     EPrf24        TAG
      *
     C     IsError       IFEQ      bTrue
     C                   MOVEL (P) 'MAXSIZE'     XFldName
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
     C                   MOVEL (P) 'EDTCDE'      XFldName
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
     C                   MOVEL (P) XBuffer       WRK0001
      *
      * - Rückkehrcode
     C                   MOVEL (P) *BLANKS       XFldName
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
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
