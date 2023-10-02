      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : CRTMSGDS                                           *
      *  Objekt  . . . : CRTMSGDSR2                                         *
      *  Beschreibung  : Tool: CRTMSGDS   (Create Message DS  )             *
      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
      *  Datum . . . . : ?                                                  *
      *                                                                     *
      *=====================================================================*
      *                                                                     *
      *  This software is free software, you can redistribute it and/or     *
      *  modify it under the terms of the GNU General Public License (GPL)  *
      *  as published by the Free Software Foundation.                      *
      *                                                                     *
      *  See GNU General Public License for details.                        *
      *          http://www.opensource.org                                  *
      *          http://www.opensource.org/licenses/gpl-license.html        *
      *                                                                     *
      *=====================================================================*
      *  History:                                                           *
      *                                                                     *
      *  Datum       Name          Änderung                                 *
      *  ----------  ------------  ---------------------------------------  *
      *  07.09.2001  Th.Raddatz    Fixed a bug when field length is *ZEROS. *
      *  10.01.2003  Th.Raddatz    Removed special character § from source. *
      *  08.03.2005  Th.Raddatz    Fixed problem that trailing blanks of    *
      *                            message help text were dropped.          *
      *  21.06.2005  Th.Raddatz    Renamed XMSGT to XMBRT to avoid          *
      *                            confusion.                               *
      *                            Increment cL within RPLHPN to fix bug    *
      *                            that message text was truncated.         *
      *  18.04.2008  Th.Raddatz    Datenstruktur MS0300 von 1024 auf 8192   *
      *                            Byte vergrößert.                         *
      *  26.01.2009  Th.Raddatz    Code des generierten CLP Programms       *
      *                            geändert. Bibliothek kann jetzt als      *
      *                            optionaler Parameter übergeben werden.   *
      *                            Befehlsparameter TYPE um Auswahl         *
      *                            *CLLE erweitert.                         *
      *  06.10.2009  Th.Raddatz    Replaced special character '#' by        *
      *                            '_SIZE' when generating RPGLE copy       *
      *                            books.                                   *
      *                                                                     *
      * =================================================================== *
      * >>PRE-COMPILER<<                                                    *
      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
      *                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
      *   >>COMPILE<<                                                       *
      *     >>PARM<< TRUNCNBR(*NO);                                         *
      *     >>PARM<< DBGVIEW(*LIST);                                        *
      *     >>PARM<< TGTRLS(V7R1M0);                                        *
      *   >>END-COMPILE<<                                                   *
      *   >>EXECUTE<<                                                       *
      * >>END-PRE-COMPILER<<                                                *
      * =================================================================== *
      *                                                                     *
      *  Attention: If you have applied one of the PTFs listed              *
      *             below or if you are running V4R3 or above               *
      *             you should set constant OFS to 1.                       *
      *             Otherwise you should set OFS to 0.                      *
      *                                                                     *
      *             V3R1M0 - SF51811                                        *
      *             V3R2M0 - SF51812                                        *
      *             V3R6M0 - SF51813                                        *
      *             V3R7M0 - SF51814                                        *
      *             V4R1M0 - SF51815                                        *
      *             V4R2M0 - SF51817                                        *
      *                                                                     *
      * =================================================================== *
 CPY  /COPY QCRTMSGDS,H_SPEC
      * =================================================================== *
      *
     FSRC       O    F  256        DISK    USROPN
      *
     D TXT             S              1    DIM(80)                              eine Zeile
     D ORD             S              1    DIM(35) CTDATA PERRCD(1)             Num.f.Feldn.
     D RPG             S             80    DIM(14) CTDATA PERRCD(1)             Sourcezeilen
     D IRPG            S             80    DIM(20) CTDATA PERRCD(1)             Sourcezeilen
     D CLP             S             80    DIM(21) CTDATA PERRCD(1)             Sourcezeilen
     D C               S             80    DIM(10) CTDATA PERRCD(1)             Sourcezeilen
     D fldName         S             40    inz
     D fldType         S             40    inz
      *
      *------------------------------------------------------------*
      *  Datensatzbeschreibung für Sourcen
      *------------------------------------------------------------*
      *
     D FSRC            DS
     D  SRCSEQ                 1      6  2
     D  SRCSQ1                 1      4
     D  SRCSQ2                 5      6
     D  SRCDAT                 7     12  0
     D  SRCDTA                13    256
      *
      *------------------------------------------------------------*
      *  interne Prototypen
      *------------------------------------------------------------*
     D f_replace...
     D                 PR           256A
     D  i_string                    256A   value
     D  i_var                        20A   value
     D  i_value                     256A   value
      *
     D f_lcase...
     D                 PR           256A
     D  i_string                    256A   value
      *
     D f_str...
     D                 PR           256A
     D  i_value                      30P 0 value
      *
     D f_structName...
     D                 PR            20A
      *
      *------------------------------------------------------------*
      *  allg. Feldbeschreibungen für API
      *------------------------------------------------------------*
      *
     D                 DS
     D  P#VLEN                 1      4I 0
     D  P#FORM                 5     14
     D  P#DTAL                15     18I 0
     D                 DS
     D  P#MSFL                 1     10
     D  P#MSLI                11     20
     D  P#MSGF                 1     20
      *
      *------------------------------------------------------------*
      *  Definition des Satzformates RTVM0300
      *------------------------------------------------------------*
     D MS0300          DS
     D  M3TRTN                 1      4I 0
     D  M3TVAL                 5      8I 0
      *
     D  M3MSSV                 9     12I 0
     D  M3ALID                13     16I 0
     D  M3ALOP                17     25
     D  M3LGIN                26     26
     D  M3MGID                27     33
     D  M3RES1                34     36
      *
     D  M3NSVF                37     40I 0
     D  M3CSIT                41     44I 0
      *
     D  M3CSIR                45     48I 0
     D  M3CCIT                49     52I 0
      *
     D  M3OFDR                53     56I 0
     D  M3LGDR                57     60I 0
     D  M3LDRA                61     64I 0
      *
     D  M3OFMG                65     68I 0
     D  M3LGMR                69     72I 0
     D  M3LMRA                73     76I 0
      *
     D  M3OFMH                77     80I 0
     D  M3LGMH                81     84I 0
     D  M3LMHA                85     88I 0
      *
     D  M3OFVF                89     92I 0
     D  M3LGVF                93     96I 0
     D  M3LVFA                97    100I 0
     D  M3LVFE               101    104I 0
      *
     D  M3RES2               105    256
     D  M3DATA               257   8192
      *
      *-----------------------------------------------------
      * Format der Ersetzungsvariablen in der Message
      *-----------------------------------------------------
      *
     D MS030F          DS
     D  M3FLGD                 1      4I 0
     D  M3FFSZ                 5      8I 0
     D  M3FTYP                 9     18
     D  M3FRS1                19    256
     D  M3FRS2               257    512
      *
      *-----------------------------------------------------
      * Format der ERROR-Struktur bei API'S
      *-----------------------------------------------------
     D ERRCOD          DS
     D  ERRPRV                 1      4I 0 INZ
     D  ERRAVL                 5      8I 0 INZ
     D  ERRID                  9     15    INZ
     D  ERRRSV                16     16    INZ
     D  ERRDTA                17     32    INZ
      *
      * Zerlegung der MSG-ID
     D D#MSID          DS
     D  D#MFCH                 1      1    INZ
     D  D#MPRF                 1      3    INZ
     D  D#MNBR                 4      7    INZ
      *
      * Dezimalposition
     D                 DS
     D  D#DPS                  1      1  0 INZ
     D  D#DEC                  1      1    INZ
      *
      * VON-BIS Positionen
     D                 DS
     D  D#OD                   1      3  0 INZ
     D  D#POS                  1      3    INZ
      *
      * Unterteilung des 6 stelligen RPG Feldnamens
     D D#FLD           DS
     D  D#PRF                  1      1    INZ
     D  D#NBR                  2      5    INZ
     D  D#ORD                  6      8    INZ
      * Unterteilung des 10 stelligen ILE-RPG Feldnamens
     D D#IFLD          DS
     D  D#IPRF                 1      3    INZ
     D  D#INBR                 4      7    INZ
     D  D#IORD                 8      8    INZ
     D  D#EXT                  8     12    INZ
      * Länge der Datenstruktur binär
     D                 DS
     D  D#DSLX                 1      4    INZ
     D  D#DSLG                 1      4  0 INZ
      *                                7
     D D#DRPL          DS          8192
     D D#MSGT          DS          8192
     D  D#MSG                  1     59
     D D#MSGH          DS          8192
     D D#SUBV          DS          8192
      *
      *  Arbeitsfeld
     D #TEMP           DS          8192
     D #TEXT           DS
     D  #TB                    1   8192    INZ
     D                                     DIM(8192)
     D                 DS
     D  #Y                     1      3P 0 INZ
     D                 DS
     D  #N2                    1      2  0 INZ
     D  #A2                    1      2    INZ
     D                 DS
     D  #N5                    1      5  0 INZ
     D  #A5                    1      5    INZ
      *
      *  Boolsche Konstanten
     D cFALSE          C                   CONST('0')
     D cTRUE           C                   CONST('1')
      *
      *  Konstanten
     D cC_DELIM        C                   CONST(';')
     D cMSGID          C                   CONST('%%MSGID')
     D cMSGTXT         C                   CONST('%%MSGTXT')
     D cVARTYPE        C                   CONST('%%VARTYPE')
     D cVARNAME        C                   CONST('%%VARNAME')
     D cDELIMITER      C                   CONST('%%DELIMITER')
     D cSTRUCTNAME     C                   CONST('%%STRUCTNAME')
      *
      *  Systemdatenstruktur
     D sds            SDS
     D  sds_msgID             40     46
     D  sds_msgDta            91    170
      *
      *  Offset for SUBST
      *  ... PTF applied or version V4R3 and above
     D OFS             C                   CONST(1)
      *  ... PTF not applied
      ***           0                     C         OFS
      *
      *-----------------------------------------------------
      *
     C     *ENTRY        PLIST
      * Input
     C                   PARM                    XMSGL                          Msg-Lib
     C                   PARM                    XMSGF                          Msg-File
     C                   PARM                    XMSGI                          Msg-ID
     C                   PARM                    XCPYL                          Cpy-Lib
     C                   PARM                    XCPYF                          Cpy-File
     C                   PARM                    XGENA                          Gener.Art
     C                   PARM                    XISDFN                         Define-Best.
     C                   PARM                    XFIRST                         1. Msg-ID
     C                   PARM                    XLAST                          Letzte Msg-ID
      * Output
     C                   PARM                    XMBRT                          MbrText
     C                   PARM                    XERRID                         Error-ID
     C                   PARM                    XERRDT                         Error-Data
      *
      *-----------------------------------------------------
      * Programm Vorlauf
      *-----------------------------------------------------
     C                   EXSR      FIRST
      *
      *-----------------------------------------------------
      * Aufruf API vorbereiten
      *-----------------------------------------------------
     C                   Z-ADD     8192          P#VLEN
     C                   MOVEL(P)  'RTVM0300'    P#FORM
     C                   MOVEL(P)  XMSGI         P#MSGI            7
     C                   MOVEL(P)  XMSGL         P#MSLI                         Msg File
     C                   MOVEL(P)  XMSGF         P#MSFL                         Msg File
     C                   MOVEL(P)  *BLANKS       P#MSGD           80            Msg Dta
     C     ' '           CHECKR    P#MSGD        P#DTAL                         Msg Dta Len
      * Replace Substitution variables
     C                   MOVEL(P)  '*NO'         P#MSRS           10            Msg Repl Sub
      * Return format control characters
 B01 C                   IF        (XGENA = '*CLP'   )  or
     C                             (XGENA = '*CLLE'  )  or
     C                             (XGENA = '*SCRIPT')
     C                   MOVEL(P)  '*YES'        P#MSFC           10            Ret Form Cha
 X01 C                   ELSE
     C                   MOVEL(P)  '*NO'         P#MSFC           10            Ret Form Cha
 E01 C                   ENDIF
     C                   CLEAR                   ERRCOD
      *
     C                   CALL      'QMHRTVM'                            99
     C                   PARM                    MS0300
     C                   PARM                    P#VLEN
     C                   PARM                    P#FORM
     C                   PARM                    P#MSGI                         Msg ID
     C                   PARM                    P#MSGF                         Msg File
     C                   PARM                    P#MSGD                         Msg Dta
     C                   PARM                    P#DTAL                         Msg Dta Len
     C                   PARM                    P#MSRS                         Msg Repl Sub
     C                   PARM                    P#MSFC                         Ret Form Cha
     C                   PARM                    ERRCOD
      *
      * prüfen, Aufruf OK
 B01 C     *IN99         IFEQ      *ON
     C                   MOVEL(P)  'CPF9897'     XERRID
     C                   MOVEL(P)  'Aufruf '     XERRDT
     C                   CAT       'fehler':1    XERRDT
     C                   CAT       'haft:':0     XERRDT
     C                   CAT       P#MSGF:1      XERRDT
     C                   CAT       'MSGID:':1    XERRDT
     C                   CAT       P#MSGI:1      XERRDT
     C                   GOTO      ENDE
 E01 C                   ENDIF
      *
      *
 B01 C     ERRAVL        IFGT      *ZERO
     C                   MOVEL(P)  ERRID         XERRID
     C                   MOVEL(P)  ERRDTA        XERRDT
     C                   GOTO      ENDE
 E01 C                   ENDIF
      *
      * Default Reply rauslösen
 B01 C     M3LGDR        IFGT      *ZERO
     C     OFS           ADD       M3OFDR        O
     C     M3LGDR        SUBST     MS0300:O      D#DRPL
 E01 C                   ENDIF
      *
      * Messagetext rauslösen
 B01 C     M3LGMR        IFGT      *ZERO
     C     OFS           ADD       M3OFMG        O
     C     M3LGMR        SUBST     MS0300:O      D#MSGT
 E01 C                   ENDIF
     C                   MOVEL(P)  D#MSGT        XMBRT
      *
      * Messagehelp rauslösen
 B01 C     M3LGMH        IFGT      *ZERO
     C     OFS           ADD       M3OFMH        O
     C     M3LGMH        SUBST     MS0300:O      D#MSGH
 E01 C                   ENDIF
      *
      * Ersetzungsvariable rauslösen
 B01 C     M3LGVF        IFGT      *ZERO
     C     OFS           ADD       M3OFVF        O
     C     M3LGVF        SUBST     MS0300:O      D#SUBV
 E01 C                   ENDIF
      *
      * Source generieren
     C                   EXSR      VGEN
      *
     C     ENDE          TAG
      *
      * Datei schließen
     C                   CLOSE     SRC
      *
     C                   RETURN
      *
      ******************************************************
      * VGEN  Auswahl welcher Sourcecode generiert wird
      ******************************************************
      *
     C     VGEN          BEGSR
      *
 B01 C                   SELECT
      *
     C     XGENA         WHENEQ    '*RPG'
     C                   EXSR      VRPG
      *
     C     XGENA         WHENEQ    '*ILERPG'
     C                   EXSR      VRPG4
      *
     C     XGENA         WHENEQ    '*CLP'
     C     XGENA         OREQ      '*CLLE'
     C                   MOVEL(P)  XMSGL         R#MSGL                         Msg-Lib
     C                   MOVEL(P)  '&LIB'        XMSGL                          Msg-Lib
     C                   EXSR      VCLP
     C                   MOVEL(P)  R#MSGL        XMSGL                          Msg-Lib
      *
     C     XGENA         WHENEQ    '*C'
     C                   EXSR      VC
      *
      * *SCRIPT wie *CLP verarbeiten, nur einzelne Zeilen rauslassen
     C     XGENA         WHENEQ    '*SCRIPT'
      * Ersatzvariablen für RUNCLSTM setzen
     C                   MOVEL(P)  XMSGL         R#MSGL                         Msg-Lib
     C                   MOVEL(P)  XMSGF         R#MSGF                         Msg-File
     C                   MOVEL(P)  '&LI'         XMSGL                          Msg-Lib
     C                   MOVEL(P)  '&SF'         XMSGF                          Msg-File
     C                   EXSR      VCLP
     C                   MOVEL(P)  R#MSGL        XMSGL                          Msg-Lib
     C                   MOVEL(P)  R#MSGF        XMSGF                          Msg-File
      *
 X01 C                   OTHER
      *****                nichts tun
      *
 E01 C                   ENDSL
      *
     C                   ENDSR
      *
      ******************************************************
      * VRPG  generieren RPG-Source
      ******************************************************
      *
     C     VRPG          BEGSR
      *
      * Kommentarzeile durchgehend
     C                   MOVEL(P)  RPG(1)        SRCDTA
     C                   EXSR      WRTRPG
      * Kommentarzeile mit Beschreibung
     C                   MOVEL(P)  RPG(2)        SRCDTA
     C                   CAT       XMSGI:1       SRCDTA
     C                   EXSR      WRTRPG
      * Kommentarzeile nur Stern
     C                   MOVEL(P)  RPG(3)        SRCDTA
     C                   EXSR      WRTRPG
      * Kommentarzeile mit Nachrichtentext
     C                   MOVEA(P)  RPG(3)        TXT
     C                   MOVEA     D#MSG         TXT(9)
     C                   MOVEA(P)  TXT           SRCDTA
     C                   EXSR      WRTRPG
      * Kommentarzeile nur Stern
     C                   MOVEL(P)  RPG(3)        SRCDTA
     C                   EXSR      WRTRPG
      *
      * Zeile für Datenstrukturfelder erstellen
     C                   EXSR      RPGFLD
      * Zeile mit Gesamtlänge der Datenstruktur
     C                   EXSR      RPGLNG
      *
     C                   ENDSR
      *
      ******************************************************
      * VRPG4    generieren Source für ILE-RPG
      ******************************************************
      *
     C     VRPG4         BEGSR
      *
      * DEFINE-Rahmen 1
     C                   EXSR      DEFN1RPG4
      *
      * Kommentarzeile durchgehend
     C                   MOVEL(P)  IRPG(1)       SRCDTA
     C                   EXSR      WRTRPG
      * Kommentarzeile mit Beschreibung
     C                   MOVEL(P)  IRPG(2)       SRCDTA
     C                   CAT       XMSGI:1       SRCDTA
     C                   EXSR      WRTRPG
      * Kommentarzeile nur Stern
     C                   MOVEL(P)  IRPG(3)       SRCDTA
     C                   EXSR      WRTRPG
      * Kommentarzeile mit Nachrichtentext
     C                   MOVEA(P)  IRPG(3)       TXT
     C                   MOVEA     D#MSG         TXT(9)
     C                   MOVEA(P)  TXT           SRCDTA
     C                   EXSR      WRTRPG
      * Kommentarzeile nur Stern
     C                   MOVEL(P)  IRPG(3)       SRCDTA
     C                   EXSR      WRTRPG
      *
      * Zeile für Datenstrukturfelder erstellen
     C                   EXSR      RPG4FLD
      * Zeile mit Gesamtlänge der Datenstruktur
     C                   EXSR      IPGLNG
      * Kommentarzeile nur Stern
     C                   MOVEL(P)  IRPG(3)       SRCDTA
     C                   EXSR      WRTRPG
      *
      * DEFINE-Rahmen 2
     C                   EXSR      DEFN2RPG4
      *
     C                   ENDSR
      *
      ******************************************************
      * DEFN1RPG4 - DEFINE-Rahmen 1
      ******************************************************
      *
     C     DEFN1RPG4     BEGSR
      *
 B01 C     XISDFN        IFEQ      cFALSE
      * keine Ausgabe der DEFINE-Bestimmungen
 X01 C                   ELSE
      *
      * /IF NOT DEFINED(UNDEFINE_ALL)
     C                   MOVEL(P)  IRPG(18)      SRCDTA
     C                   EXSR      WRTRPG
      *
      * Ermitteln Namen für Define
     C                   EXSR      EMDEFN
      *
      * /IF NOT DEFINED(msgid_MSG)
     C                   MOVEL(P)  IRPG(15)      SRCDTA
     C                   CAT       P#DEFN:0      SRCDTA
     C                   CAT       ')':0         SRCDTA
     C                   EXSR      WRTRPG
      *
      * /DEFINE msgid_MSG
     C                   MOVEL(P)  IRPG(16)      SRCDTA
     C                   CAT       P#DEFN:1      SRCDTA
     C                   EXSR      WRTRPG
      *
 E01 C                   ENDIF
      *
     C                   ENDSR
      *
      ******************************************************
      * DEFN2RPG4 - DEFINE-Rahmen 2
      ******************************************************
      *
     C     DEFN2RPG4     BEGSR
      *
 B01 C     XISDFN        IFEQ      cFALSE
      * keine Ausgabe der DEFINE-Bestimmungen
 X01 C                   ELSE
      *
      * /ENDIF
     C                   MOVEL(P)  IRPG(17)      SRCDTA
     C                   EXSR      WRTRPG
      *
      * /ENDIF
     C                   MOVEL(P)  IRPG(17)      SRCDTA
     C                   EXSR      WRTRPG
      * Kommentarzeile nur Stern
     C                   MOVEL(P)  IRPG(3)       SRCDTA
     C                   EXSR      WRTRPG
      *
      * /IF DEFINED(UNDEFINE_ALL)
     C                   MOVEL(P)  IRPG(19)      SRCDTA
     C                   EXSR      WRTRPG
      *
      * /UNDEFINE msgid_MSG
     C                   MOVEL(P)  IRPG(20)      SRCDTA
     C                   CAT       P#DEFN:1      SRCDTA
     C                   EXSR      WRTRPG
      *
      * /ENDIF
     C                   MOVEL(P)  IRPG(17)      SRCDTA
     C                   EXSR      WRTRPG
      *
 E01 C                   ENDIF
      *
     C                   ENDSR
      *
      ******************************************************
      * VCLP     generieren Source für CLP-PROGRAMM
      ******************************************************
      *
     C     VCLP          BEGSR
      *
 B01 C     XFIRST        IFEQ      cTRUE
 B02 C     XGENA         IFNE      '*SCRIPT'
      * PGM
     C                   MOVEL(P)  CLP(5)        SRCDTA
     C                   EXSR      WRTRPG
      * Leerzeile
     C                   MOVEL(P)  *BLANKS       SRCDTA
     C                   EXSR      WRTRPG
      * DCL &I_LIB
     C                   MOVEL(P)  CLP(15)       SRCDTA
     C                   EXSR      WRTRPG
      * DCL &LIB
     C                   MOVEL(P)  CLP(16)       SRCDTA
     C                   EXSR      WRTRPG
      * Leerzeile
     C                   MOVEL(P)  *BLANKS       SRCDTA
     C                   EXSR      WRTRPG
      * CHGVAR
     C                   MOVEL(P)  CLP(17)       SRCDTA
     C                   EXSR      WRTRPG
      * MONMSG
     C                   MOVEL(P)  CLP(18)       SRCDTA
     C                   EXSR      WRTRPG
      * RMVMSG
     C                   MOVEL(P)  CLP(19)       SRCDTA
     C                   EXSR      WRTRPG
      * CHGVAR
     C                   EVAL      SRCDTA = f_replace(CLP(20): '%LIB': R#MSGL)
     C                   EXSR      WRTRPG
      * ENDDO
     C                   MOVEL(P)  CLP(21)       SRCDTA
     C                   EXSR      WRTRPG
      * Leerzeile
     C                   MOVEL(P)  *BLANKS       SRCDTA
     C                   EXSR      WRTRPG
 X02 C                   ELSE
      *  Keine Ausgabe bei *SCRIPT
 E02 C                   ENDIF
 X01 C                   ELSE
      *  Ausgabe nur bei 1. Nachrichten-ID
 E01 C                   ENDIF
      *
      * Kommentarzeile durchgehend
     C                   MOVEL(P)  CLP(1)        SRCDTA
     C                   EXSR      WRTRPG
      * Kommentarzeile mit Beschreibung
     C                   MOVEA(P)  CLP(2)        TXT(1)
     C                   MOVEA     XMSGI         TXT(42)
     C                   MOVEA(P)  TXT           SRCDTA
     C                   EXSR      WRTRPG
      * Kommentarzeile mit Nachrichtentext
     C                   MOVEA(P)  CLP(3)        TXT
     C                   MOVEA     D#MSG         TXT(9)
     C                   MOVEA     '*/'          TXT(69)
     C                   MOVEA(P)  TXT           SRCDTA
     C                   EXSR      WRTRPG
      * Kommentarzeile durchgehend
     C                   MOVEL(P)  CLP(1)        SRCDTA
     C                   EXSR      WRTRPG
      * Leerzeile
     C                   MOVEL(P)  *BLANKS       SRCDTA
     C                   EXSR      WRTRPG
      *
      * RMVMSGD
     C                   MOVEA(P)  CLP(7)        TXT
     C                   MOVEA     XMSGI         TXT(28)
     C                   MOVEA     XMSGL         TXT(42)
     C                   MOVEA(P)  TXT           SRCDTA
     C                   CAT       '/':0         SRCDTA
     C                   CAT       XMSGF:0       SRCDTA
     C                   CAT       ')':0         SRCDTA
     C                   EXSR      WRTRPG
      * MONMSG (1)
     C                   MOVEL(P)  CLP(8)        SRCDTA
     C                   EXSR      WRTRPG
      * MONMSG (2)
      *******              MOVELCLP,9     SRCDTA    P
      *******              EXSR WRTRPG
      * Leerzeile
     C                   MOVEL(P)  *BLANKS       SRCDTA
     C                   EXSR      WRTRPG
      * ADDMSGD
     C                   MOVEL(P)  CLP(11)       SRCDTA
     C                   CAT       '+':1         SRCDTA
     C                   EXSR      WRTRPG
      *
      * Zeile für Datenstrukturfelder erstellen
     C                   EXSR      ICLFLD
      *
     C                   ENDSR
      *
      ******************************************************
      * VC       generieren Source für C-Programme
      ******************************************************
      *
     C     VC            BEGSR
      *
      * DEFINE-Rahmen 1
     C                   EXSR      DEFN1C
      *
      * Kommentarzeile durchgehend
     C                   EVAL      SRCDTA = c(1)
     C                   EXSR      WRTRPG
      * Kommentarzeile mit Beschreibung
     C                   EVAL      SRCDTA = f_replace(c(2)         :
     C                                                cMSGID       :
     C                                                XMSGI        )
     C                   EXSR      WRTRPG
      * Kommentarzeile mit Nachrichtentext
     C                   EVAL      SRCDTA = f_replace(c(3)         :
     C                                                cMSGTXT      :
     C                                                D#MSG        )
     C                   EXSR      WRTRPG
      * Kommentarzeile durchgehend
     C                   EVAL      SRCDTA = c(4)
     C                   EXSR      WRTRPG
      * Leerzeile
     C                   MOVEL(P)  *BLANKS       SRCDTA
     C                   EXSR      WRTRPG
      *
      * Zeile für Datenstrukturfelder erstellen
     C                   EXSR      ICFLD
      *
      * DEFINE-Rahmen 2
     C                   EXSR      DEFN2C
      *
     C                   ENDSR
      *
      ******************************************************
      * DEFN1C    - DEFINE-Rahmen 1
      ******************************************************
      *
     C     DEFN1C        BEGSR
      *
 B01 C     XISDFN        IFEQ      cFALSE
      * keine Ausgabe der DEFINE-Bestimmungen
 X01 C                   ELSE
      *
      * #ifndef
     C                   EVAL      SRCDTA = f_replace(c(8)          :
     C                                                cSTRUCTNAME   :
     C                                    '__' + %trim(f_structName))
     C                   EXSR      WRTRPG
      *
      * #define
     C                   EVAL      SRCDTA = f_replace(c(9)          :
     C                                                cSTRUCTNAME   :
     C                                    '__' + %trim(f_structName))
     C                   EXSR      WRTRPG
      *
 E01 C                   ENDIF
      *
     C                   ENDSR
      *
      ******************************************************
      * DEFN2C    - DEFINE-Rahmen 2
      ******************************************************
      *
     C     DEFN2C        BEGSR
      *
 B01 C     XISDFN        IFEQ      cFALSE
      * keine Ausgabe der DEFINE-Bestimmungen
 X01 C                   ELSE
      *
      * #endif
     C                   EVAL      SRCDTA = c(10)
     C                   EXSR      WRTRPG
      *
 E01 C                   ENDIF
      *
     C                   ENDSR
      *
      ******************************************************
      * ICFLD  Zeilen für Felddefinitionen generieren
      ******************************************************
      *
     C     ICFLD         BEGSR
      *
      * Zeile mit Datenstrukturnamen
     C                   EVAL      SRCDTA = c(5)
     C                   EXSR      WRTRPG
      *
      * Anzahl der MSG-Variablen bestimmen
      * (Länge des kpl. Variablenbereichs / Länge einer Variablestruktur)
     C                   EXSR      GETANZ
      *
 B01 C     P#MANZ        IFLE      *ZEROS
      * ... keine Variablen definiert
     C                   EVAL      SRCDTA = f_replace(c(6)         :
     C                                                cVARNAME     :
     C                                                'dummy'      )
     C                   EVAL      SRCDTA = f_replace(SRCDTA       :
     C                                                cVARTYPE     :
     C                                                'char'       )
     C                   EVAL      SRCDTA = f_replace(SRCDTA       :
     C                                                cDELIMITER   :
     C                                                ';'          )
     C                   EXSR      WRTRPG
 X01 C                   ELSE
      *
     C                   Z-ADD     1             OF
 B02 C     1             DO        P#MANZ        A
      *
      * einen Variableninformationsblock aus großen Block herausschneiden
     C                   EXSR      CUTVAR
      *
      * Zeilenschablone vorbereiten
     C                   EVAL      SRCDTA = c(6)
      *
      * prüfen, ob Datentyp korrekt, sonst Fehler
     C                   EXSR      CHKTYP
      *
      * Feldnamen zusammenbauen
     C                   EVAL      fldName = 'd' + ord(a)
      *
      * Dezimalstellen oder *BLANK
     C                   EXSR      GETDEZ
      *
 B03 C                   SELECT
     C                   WHEN      F#TYP = 'A'
     C                   EVAL      fldType = 'char'
     C                   EVAL      fldName = %trim(fldName)
     C                                     + '['
     C                                     + %trimr(f_str(P#FLDL))
     C                                     + ']'
     C                   WHEN      F#TYP = 'P'
     C                   EVAL      fldType = 'decimal'
     C                                     + '('
     C                                     + %trimr(f_str(P#FLDL))
     C                                     + ','
     C                                     + %trimr(f_str(D#DPS ))
     C                                     + ')'
     C                   WHEN      F#TYP = 'B'
 B04 C                   SELECT
     C                   WHEN      P#FLDL = 9
     C                   EVAL      fldType = 'long'
     C                   WHEN      P#FLDL = 4
     C                   EVAL      fldType = 'short'
 X04 C                   OTHER
     C                   EVAL      fldType = '*error'
 E04 C                   ENDSL
 E03 C                   ENDSL
      *
     C                   EVAL      SRCDTA = f_replace(c(6)         :
     C                                                cVARNAME     :
     C                                                fldName      )
     C                   EVAL      SRCDTA = f_replace(SRCDTA       :
     C                                                cVARTYPE     :
     C                                                fldType      )
     C                   EVAL      SRCDTA = f_replace(SRCDTA       :
     C                                                cDELIMITER   :
     C                                                cC_DELIM     )
      *
 B03 C                   IF        P#FLDL = 0
     C                   EVAL      %SUBST(SRCDTA: 2: 2) = '/*'
     C                   EVAL      %SUBST(SRCDTA:40: 9) = 'Länge = 0'
     C                   EVAL      %SUBST(SRCDTA:50: 2) = '*/'
 E03 C                   ENDIF
      *
      * Zeile wegschreiben
     C                   EXSR      WRTRPG
      *
 E02 C                   ENDDO
      *
 E01 C                   ENDIF
      *
     C                   EVAL      SRCDTA = f_replace(c(7)          :
     C                                                cSTRUCTNAME   :
     C                                %trim(f_structName) + cC_DELIM)
     C                   EXSR      WRTRPG
      *
     C                   ENDSR
      *
      ******************************************************
      * RPGFLD Zeilen für Felddefinitionen generieren
      ******************************************************
      *
     C     RPGFLD        BEGSR
      *
      * Zeile mit Datenstrukturnamen
     C                   MOVEA(P)  RPG(11)       TXT
     C                   MOVEA     D#MFCH        TXT(7)
     C                   MOVEA     D#MNBR        TXT(8)
     C                   MOVEA(P)  TXT           SRCDTA
     C                   EXSR      WRTRPG
      *
      * Anzahl der MSG-Variablen bestimmen
      * (Länge des kpl. Variablenbereichs / Länge einer Variablestruktur)
     C                   EXSR      GETANZ
      *
 B01 C     P#MANZ        IFLE      *ZEROS
     C                   Z-ADD     *ZEROS        D#DSLG
      * ... keine Variablen definiert
     C                   MOVEL(P)  RPG(14)       SRCDTA
     C                   EXSR      WRTRPG
 X01 C                   ELSE
      *
     C                   Z-ADD     1             OF
     C                   Z-ADD     1             OD
 B02 C     1             DO        P#MANZ        A
      *
      * einen Variableninformationsblock aus großen Block herausschneiden
     C                   EXSR      CUTVAR
      *
      * Zeilenschablone vorbereiten
     C                   MOVEA(P)  RPG(12)       TXT
      *
      * prüfen, ob Datentyp korrekt, sonst Fehler
     C                   EXSR      CHKTYP
      *
      * Feldnamen zusammenbauen
     C                   CLEAR                   D#FLD
     C                   MOVEL     D#MFCH        D#PRF
     C                   MOVEL     D#MNBR        D#NBR
     C                   MOVEL (P) ORD(A)        D#ORD
     C                   MOVEA     D#FLD         TXT(53)
      *
      * Dezimalstellen oder *BLANK
     C                   EXSR      GETDEZ
      *
 B03 C     F#TYP         IFEQ      'A'
     C                   MOVEL(P)  *BLANKS       F#TYP
 E03 C                   ENDIF
      *
     C                   MOVEA     F#TYP         TXT(43)
     C                   MOVEA     D#DEC         TXT(52)
      *
      * Feld hat Länge 0
 B03 C                   IF        P#FLDP = 0
     C                   MOVEA     ' * '         TXT(6)
     C                   Z-ADD     *ZEROS        D#OD
     C                   MOVEA     D#POS         TXT(45)
     C                   MOVEA     D#POS         TXT(49)
     C                   MOVEA     'Länge = 0'   TXT(61)
 X03 C                   ELSE
      *
      * VON-Position
     C                   Z-ADD     OD            D#OD                           füllen D#POS
     C                   MOVEA     D#POS         TXT(45)
     C                   ADD       P#FLDP        OD
     C                   SUB       1             OD
      *
      * BIS-Position
     C                   Z-ADD     OD            D#OD                           füllen D#POS
     C                   MOVEA     D#POS         TXT(49)
     C                   Z-ADD     D#OD          D#DSLG
     C                   ADD       1             OD
 E03 C                   ENDIF
      *
      * Zeile wegschreiben
     C                   MOVEA(P)  TXT           SRCDTA
     C                   EXSR      WRTRPG
      *
 E02 C                   ENDDO
      *
 E01 C                   ENDIF
      *
     C                   ENDSR
      *
      ******************************************************
      * RPGLNG Zeile mit Länge der Datenstruktur absetzen
      ******************************************************
      *
     C     RPGLNG        BEGSR
      *
      * Zeile mit Datenstrukturdefinition (nur DS, unbenannt)
     C                   MOVEA(P)  RPG(11)       TXT
     C                   MOVEA(P)  TXT           SRCDTA
     C                   EXSR      WRTRPG
      *
      * Zeile mit Datenstrukturlänge anlegen
     C                   MOVEA(P)  RPG(13)       TXT
      *
      * Strukturlänge wegschreiben
     C                   MOVEA     D#DSLX        TXT(21)
      *
      * Feldnamen zusammenbauen
     C                   CLEAR                   D#FLD
     C                   MOVEL     D#MFCH        D#PRF
     C                   MOVEL     D#MNBR        D#NBR
     C                   MOVEL (P) 'LEN'         D#ORD
     C                   MOVEA     D#FLD         TXT(53)
      *
     C                   MOVEA(P)  TXT           SRCDTA
     C                   EXSR      WRTRPG
      *
     C                   ENDSR
      *
      ******************************************************
      * RPG4FLD - Zeilen für Felddefinitionen generieren ILE
      ******************************************************
      *
     C     RPG4FLD       BEGSR
      *
      * Zeile mit Datenstrukturnamen
     C                   MOVEA(P)  IRPG(11)      TXT
     C                   MOVEA     D#MSID        TXT(8)
     C                   MOVEA(P)  TXT           SRCDTA
     C                   EXSR      WRTRPG
      *
      * Anzahl der MSG-Variablen bestimmen
      * (Länge des kpl. Variablenbereichs / Länge einer Variablestruktur)
     C                   EXSR      GETANZ
      *
 B01 C     P#MANZ        IFLE      *ZEROS
     C                   Z-ADD     *ZEROS        D#DSLG
      * ... keine Variablen definiert
     C                   MOVEL(P)  IRPG(14)      SRCDTA
     C                   EXSR      WRTRPG
 X01 C                   ELSE
      *
     C                   Z-ADD     1             OF
     C                   Z-ADD     1             OD
     C                   Z-ADD     *ZERO         D#DSLG
 B02 C     1             DO        P#MANZ        A
      *
      * einen Variableninformationsblock aus großen Block herausschneiden
     C                   EXSR      CUTVAR
      *
      * Zeilenschablone vorbereiten - ILE
     C                   MOVEA(P)  IRPG(12)      TXT
      *
      * prüfen, ob Datentyp korrekt, sonst Fehler
     C                   EXSR      CHKTYP
      *
      * Feldnamen zusammenbauen
     C                   CLEAR                   D#IFLD
     C                   MOVEL     D#MPRF        D#IPRF
     C                   MOVEL     D#MNBR        D#INBR
     C                   MOVEL     ORD(A)        D#IORD
     C                   MOVEA     D#IFLD        TXT(9)
      *
      * Dezimalstellen oder *BLANK ...
     C                   EXSR      GETDEZ
      * ... Initialisierung
 B03 C                   SELECT
     C     F#TYP         WHENEQ    'A'
     C                   MOVEA     '*BLANKS'     TXT(48)
     C     F#TYP         WHENEQ    'P'
     C                   MOVEA     '*ZEROS'      TXT(48)
     C     F#TYP         WHENEQ    'B'
     C                   MOVEA     '*ZEROS'      TXT(48)
 X03 C                   OTHER
     C                   MOVEA     '*ERROR'      TXT(48)
 E03 C                   ENDSL
      * ... Feldtyp
     C                   MOVEA     F#TYP         TXT(40)
      * ... Dezimalstellen
     C                   MOVEA     D#DEC         TXT(42)
      * ... Feldlänge
 B03 C                   IF        P#FLDP = *ZEROS
     C                   MOVEA     ' *'          TXT(6)
     C                   Z-ADD     *ZEROS        D#OD                           füllen D#POS
     C                   MOVEA     D#POS         TXT(37)
     C                   MOVEA     'Länge = 0'   TXT(58)
 X03 C                   ELSE
     C                   Z-ADD     P#FLDL        D#OD                           füllen D#POS
     C                   ADD       P#FLDP        D#DSLG
     C                   MOVEA     D#POS         TXT(37)
 E03 C                   ENDIF
      *
      * Zeile wegschreiben
     C                   MOVEA(P)  TXT           SRCDTA
     C                   EXSR      WRTRPG
      *
 E02 C                   ENDDO
      *
 E01 C                   ENDIF
      *
     C                   ENDSR
      *
      ******************************************************
      * IPGLNG Zeile mit Länge der Datenstruktur absetzen
      ******************************************************
      *
     C     IPGLNG        BEGSR
      *
      * Zeile mit Datenstrukturdefinition (nur DS, unbenannt)
     C                   MOVEA(P)  IRPG(13)      TXT
      *
      * Strukturlänge wegschreiben
     C                   MOVEA     D#DSLX        TXT(48)
      *
      * Feldnamen zusammenbauen
     C                   CLEAR                   D#IFLD
     C                   MOVEL     D#MPRF        D#IPRF
     C                   MOVEL     D#MNBR        D#INBR
     C                   MOVEL     '_SIZE'       D#EXT
     C                   MOVEA     D#IFLD        TXT(8)
      *
     C                   MOVEA(P)  TXT           SRCDTA
     C                   EXSR      WRTRPG
      *
     C                   ENDSR
      *
      ******************************************************
      * ICLFLD Zeilen für Felddefinitionen generieren CLP
      ******************************************************
      *
     C     ICLFLD        BEGSR
      *
      * Startposition für Schlüsselworte
     C                   Z-ADD     16            #P                5 0
      * Startposition für eingerückte Werte
     C                   Z-ADD     21            #Z                5 0
      * Startposition für Nachrichtentexte
     C                   Z-ADD     1             #Z1               5 0
      * Arbeitsfeld
     C                   Z-ADD     *ZEROS        cS                5 0
     C                   Z-ADD     *ZEROS        cL                5 0
     C                   Z-ADD     *ZEROS        cI                5 0
      *
      * MSGID()
     C                   CAT(P)    'MSGID':#P    SRCDTA
     C                   EXSR      OPNBRK
     C                   CAT       XMSGI:0       SRCDTA
     C                   EXSR      CLSBRK
     C                   EXSR      WRTRPG
      *
      * MSGF()
     C                   CAT(P)    'MSGF':#P     SRCDTA
     C                   EXSR      OPNBRK
     C                   CAT       XMSGL:0       SRCDTA
     C                   CAT       '/':0         SRCDTA
     C                   CAT       XMSGF:0       SRCDTA
     C                   EXSR      CLSBRK
     C                   EXSR      WRTRPG
      *
      * MSG()
 B01 C     M3LGMR        IFGT      *ZEROS
     C                   CAT(P)    'MSG':#P      SRCDTA
     C                   EXSR      OPNBRK
     C                   CAT       '+':0         SRCDTA
     C                   EXSR      WRTRPG
      *
     C                   Z-ADD     M3OFMG        cS
     C                   ADD       1             cS
     C                   Z-ADD     M3LGMR        cL
     C     cL            SUBST(P)  MS0300:cS     #TEXT
      *
     C                   EXSR      RPLHPN
     C     ''''          CAT(P)    #TEXT         #TEXT
    R ***                CAT       '''':0        #TEXT
     C     cL            ADD       2             cI
     C                   MOVEL(P)  ''''          #TB(cI)
      *
     C                   EXSR      SPLITT
      *
     C                   CAT(P)    ') +':#P      SRCDTA
     C                   EXSR      WRTRPG
 E01 C                   ENDIF
      *
      * SECLVL()
 B01 C     M3LGMH        IFGT      *ZEROS
     C                   CAT(P)    'SEC':#P      SRCDTA
     C                   CAT(P)    'LVL':0       SRCDTA
     C                   EXSR      OPNBRK
     C                   CAT       '+':0         SRCDTA
     C                   EXSR      WRTRPG
      *
     C                   Z-ADD     M3OFMH        cS
     C                   ADD       1             cS
     C                   Z-ADD     M3LGMH        cL
     C     cL            SUBST(P)  MS0300:cS     #TEXT
      *
     C                   EXSR      RPLHPN
     C     ''''          CAT(P)    #TEXT         #TEXT
     C                   CAT       '''':0        #TEXT
     C                   EXSR      SPLITT
      *
     C                   CAT(P)    ') +':#P      SRCDTA
     C                   EXSR      WRTRPG
 E01 C                   ENDIF
      *
      * SEV()
     C                   CAT(P)    'SEV':#P      SRCDTA
     C                   EXSR      OPNBRK
     C                   Z-ADD     M3MSSV        #N2
     C                   CAT       #A2:0         SRCDTA
     C                   EXSR      CLSBRK
     C                   EXSR      WRTRPG
      *
      * Anzahl der MSG-Variablen bestimmen
      * (Länge des kpl. Variablenbereichs / Länge einer Variablestruktur)
     C                   EXSR      GETANZ
      *
 B01 C     P#MANZ        IFLE      *ZEROS
      * ... keine Variablen definiert
     C                   MOVEL(P)  CLP(14)       SRCDTA
     C                   EXSR      WRTRPG
 X01 C                   ELSE
      *
      * FMT()
 B02 C     P#MANZ        IFGT      *ZEROS
     C                   CAT(P)    'FMT':#P      SRCDTA
     C                   EXSR      OPNBRK
     C                   CAT(P)    ' +':0        SRCDTA
     C                   EXSR      WRTRPG
 E02 C                   ENDIF
      *
     C                   Z-ADD     1             OF
     C                   Z-ADD     1             OD
 B02 C     1             DO        P#MANZ        A
      *
     C                   EVAL      %SUBST(SRCDTA: #Z: 1) = '('
      *
      * einen Variableninformationsblock aus großen Block herausschneiden
     C                   EXSR      CUTVAR
      *
      * prüfen, ob Datentyp korrekt, sonst Fehler
     C                   EXSR      CHKTYP
      *
      * Dezimalstellen oder *BLANK ...
     C                   EXSR      GETDEZ
      * ... Initialisierung
 B03 C                   SELECT
     C     F#TYP         WHENEQ    'B'
     C                   CAT       '*BIN':0      SRCDTA
 B04 C     P#FLDL        IFGE      5
     C                   Z-ADD     4             P#FLDL
 X04 C                   ELSE
     C                   Z-ADD     2             P#FLDL
 E04 C                   ENDIF
 X03 C                   OTHER
     C                   CAT       M3FTYP:0      SRCDTA
 E03 C                   ENDSL
      * ... Feldlänge
     C                   Z-ADD     P#FLDL        D#OD                           füllen D#POS
     C                   CAT       D#POS:1       SRCDTA
      * ... Dezimalstellen
     C                   CAT       D#DEC:1       SRCDTA
      *
      * Zeile wegschreiben
     C                   CAT(P)    ') +':0       SRCDTA
     C                   EXSR      WRTRPG
      *
 E02 C                   ENDDO
      *
     C                   CAT(P)    ') +':#P      SRCDTA
     C                   EXSR      WRTRPG
 E01 C                   ENDIF
      *
      * ALROPT()
     C                   CAT(P)    'ALR':#P      SRCDTA
     C                   CAT(P)    'OPT':0       SRCDTA
     C                   EXSR      OPNBRK
     C                   CAT       M3ALOP:0      SRCDTA
 B01 C     M3ALID        IFGE      1
     C     M3ALID        ANDLE     99
     C                   Z-ADD     M3ALID        #N2
     C                   CAT       #A2:1         SRCDTA
 E01 C                   ENDIF
     C                   EXSR      CLSBRK
     C                   EXSR      WRTRPG
      *
      * CCSID()
     C                   CAT(P)    'CCSID':#P    SRCDTA
     C                   EXSR      OPNBRK
     C                   Z-ADD     M3CCIT        #N5
     C                   CAT       #A5:1         SRCDTA
     C                   EXSR      CLSBRK
     C                   EXSR      WRTRPG
      *
      * EOF
     C                   CAT(P)    '/*':#P       SRCDTA
     C                   CAT       '-EOF-':2     SRCDTA
     C                   CAT       '*/':2        SRCDTA
     C                   EXSR      WRTRPG
      *
      * Leerzeile
     C                   MOVEL(P)  *BLANKS       SRCDTA
     C                   EXSR      WRTRPG
      *
 B01 C     XLAST         IFEQ      cTRUE
      * nicht bei *SCRIPT
     C     XGENA         ANDNE     '*SCRIPT'
      * RCLRSC
     C                   MOVEL(P)  CLP(12)       SRCDTA
     C                   EXSR      WRTRPG
      *
      * Leerzeile
     C                   MOVEL(P)  *BLANKS       SRCDTA
     C                   EXSR      WRTRPG
      *
      * ENDPGM
     C                   MOVEL(P)  CLP(13)       SRCDTA
     C                   EXSR      WRTRPG
 X01 C                   ELSE
      *  Ausgabe nur bei letzter Nachrichten-ID
 E01 C                   ENDIF
      *
     C                   ENDSR
      *
      ******************************************************
      * RPLHPN   - Replace hyphen
      *            Ersetzen Hochkomma durch doppelte
      *            Hochkomma
      ******************************************************
      *
     C     RPLHPN        BEGSR
      *
     C                   Z-ADD     1             #Y
      *
 B01 C     #Y            DOUEQ     *ZEROS
      *
     C     ''''          SCAN      #TEXT:#Y      #Y
 B02 C     #Y            IFLE      *ZEROS
      *  Nichts weiter zu tun ...
 X02 C                   ELSE
      *  Zweite "Hälfte" retten ...
     C                   ADD       1             #Y
 B03 C     #Y            IFLE      8192
     C                   SUBST     #TEXT:#Y      #TEMP
 X03 C                   ELSE
      *  "ASSERT"
     C                   MOVEL     'CPF9897'     sds_msgID
     C     '#Y:'         CAT       '> 8192':1    sds_msgDta
     C                   EXSR      *PSSR
 E03 C                   ENDIF
      *
     C                   MOVEA     ''''          #TB(#Y)
     C                   ADD       1             #Y
     C                   ADD       1             cL
 B03 C     #Y            IFLE      8192
     C                   MOVEA     #TEMP         #TB(#Y)
 X03 C                   ELSE
      *  "ASSERT"
     C                   MOVEL     'CPF9897'     sds_msgID
     C     '#Y:'         CAT       '> 8192':1    sds_msgDta
     C                   EXSR      *PSSR
 E03 C                   ENDIF
      *
 E02 C                   ENDIF
      *
 E01 C                   ENDDO
      *
     C                   ENDSR
      *
      ******************************************************
      * SPLITT   - Aufsplitten von #TEXT auf mehrere Zeilen
      ******************************************************
      *
     C     SPLITT        BEGSR
      *
     C     71            SUB       #Z1           #L                5 0
     C                   Z-ADD     *ZEROS        #X                5 0
      *
 B01 C     #TEXT         DOWNE     *BLANKS
      *
      *  Übertragen Nachrichtentext in Datenzeile
     C                   Z-ADD     1             #S                5 0
     C     #L            SUBST(P)  #TEXT:#S      SRCDTA
      *
      *  Entfernen übertragene Zeichen aus Nachrichtentext
     C                   ADD       #L            #S
 B02 C     #S            IFLE      8192
     C                   SUBST(P)  #TEXT:#S      #TEXT
 X02 C                   ELSE
     C                   MOVEL(P)  *BLANKS       #TEXT
 E02 C                   ENDIF
      *
      *  Anfügen Fortsetzungszeichen
     C                   MOVEA     SRCDTA        TXT(#Z1)
     C     #Z1           ADD       #L            #X
      *
 B02 C     #TEXT         IFEQ      *BLANKS
     C                   MOVE      '+'           TXT(#X)
 X02 C                   ELSE
     C                   MOVE      '-'           TXT(#X)
 E02 C                   ENDIF
      *
     C                   MOVEA(P)  TXT           SRCDTA
      *
      *  Ausgeben Datenzeile
     C                   EXSR      WRTRPG
 E01 C                   ENDDO
      *
     C                   ENDSR
      *
      ******************************************************
      * OPNBRK   - Íffnen Klammer (Open bracket)
      ******************************************************
      *
     C     OPNBRK        BEGSR
      *
     C                   CAT       '(':0         SRCDTA
      *
     C                   ENDSR
      *
      ******************************************************
      * CLSBRK   - Schließen Klammer (Close bracket)
      ******************************************************
      *
     C     CLSBRK        BEGSR
      *
     C                   CAT       ') +':0       SRCDTA
      *
     C                   ENDSR
      *
      ******************************************************
      * CHKTYP   - Prüfen Datentyp
      ******************************************************
      *
     C     CHKTYP        BEGSR
      *
 B01 C     M3FTYP        IFNE      '*QTDCHAR'
     C     M3FTYP        ANDNE     '*CHAR'
     C     M3FTYP        ANDNE     '*DEC'
     C     M3FTYP        ANDNE     '*HEX'
     C     M3FTYP        ANDNE     '*BIN'
     C                   MOVEL(P)  'CPF9897'     XERRID
     C                   MOVEL(P)  'MSG-ID:'     XERRDT
     C                   CAT       M3MGID:1      XERRDT
     C                   CAT       'Unerla':1    XERRDT
     C                   CAT       'ubter':0     XERRDT
     C                   CAT       'Typ':1       XERRDT
     C                   CAT       M3FTYP:1      XERRDT
     C                   GOTO      ENDE
 E01 C                   ENDIF
      *
     C                   ENDSR
      *
      ******************************************************
      * GETANZ   - Bestimmen Anzahl Variablen
      ******************************************************
      *
     C     GETANZ        BEGSR
      *
 B01 C     M3LGVF        IFGT      *ZERO
     C     M3LGVF        DIV       M3LVFE        P#MANZ
 X01 C                   ELSE
     C                   Z-ADD     *ZERO         P#MANZ
 E01 C                   ENDIF
      *
     C                   ENDSR
      *
      ******************************************************
      * CUTVAR   - Herausschneiden eines Variablen-
      *            informationsblock aus großen Block
      ******************************************************
      *
     C     CUTVAR        BEGSR
      *
     C                   CLEAR                   MS030F
     C     M3LVFE        SUBST     D#SUBV:OF     MS030F
     C                   ADD       M3LVFE        OF
      *
     C                   ENDSR
      *
      ******************************************************
      * GETDEZ   - Ermitteln Anzahl Dezimalstellen
      *            und Feldtyp
      ******************************************************
      *
     C     GETDEZ        BEGSR
      *
      * Feldlänge laut MSGD
     C                   Z-ADD     M3FLGD        P#FLDL
     C                   Z-ADD     M3FLGD        P#FLDP
      *
      * und rechnen
 B01 C                   SELECT
     C     M3FTYP        WHENEQ    '*QTDCHAR'
     C                   MOVEL     *BLANK        D#DEC
     C                   MOVEL     'A'           F#TYP             1
      *
     C     M3FTYP        WHENEQ    '*CHAR'
     C                   MOVEL     *BLANK        D#DEC
     C                   MOVEL     'A'           F#TYP
      *
     C     M3FTYP        WHENEQ    '*HEX'
     C                   MOVEL     *BLANK        D#DEC
     C                   MOVEL     'A'           F#TYP
      *
     C     M3FTYP        WHENEQ    '*DEC'
     C                   Z-ADD     M3FFSZ        D#DPS
      *          die Feldlänge für gepackt errechnen
     C     P#FLDL        DIV       2             P#FLDP
     C                   ADD       1             P#FLDP
     C                   MOVEL     'P'           F#TYP
      *
     C     M3FTYP        WHENEQ    '*BIN'
 B02 C     P#FLDL        IFEQ      4
     C                   Z-ADD     9             P#FLDL
 X02 C                   ELSE
     C                   Z-ADD     4             P#FLDL
 E02 C                   ENDIF
     C                   MOVEL     'B'           F#TYP
     C                   Z-ADD     *ZEROS        D#DPS
      *
 E01 C                   ENDSL
      *
     C                   ENDSR
      *
      ******************************************************
      * WRTRPG Schreiben Zeile in Sourcedatei
      ******************************************************
      *
     C     WRTRPG        BEGSR
      *
     C                   ADD       ,01           SRCSEQ
     C                   Z-ADD     *ZERO         SRCDAT
     C                   WRITE     SRC           FSRC
      *
     C                   MOVEL(P)  *BLANKS       SRCDTA
     C                   MOVEA(P)  *BLANKS       TXT
      *
     C                   ENDSR
      *
      ******************************************************
      * EMDEFN   - Ermitteln DEFINE-Namen
      ******************************************************
      *
     C     EMDEFN        BEGSR
      *
     C                   CLEAR                   P#DEFN
     C                   MOVEL(P)  XMSGI         P#DEFN
     C                   CAT       '_MSG':0      P#DEFN
      *
     C                   ENDSR
      *
      ******************************************************
      * Programm Vorlauf
      ******************************************************
      *
     C     FIRST         BEGSR
      *
      * Datei öffnen
     C                   OPEN      SRC
      *
      * Rückgabeparameter initialisieren
     C                   MOVEL     *BLANK        XMBRT                          Msgtext
     C                   MOVEL     *BLANK        XERRID                         Error-ID
     C                   MOVEL     *BLANK        XERRDT                         Error-Data
      *
      * Initialisierung
      *
      * Stelle in RTVM0300 ab der variabler Teil beginnt
     C                   Z-ADD     105           R#OFF3                         Offset in DS
      *
      * laufender Zähler für Offsets
     C                   Z-ADD     *ZERO         O
      *
      * laufender Zähler Variablenverarbeitung
     C                   Z-ADD     *ZERO         A
      *
      * Empfangsvariablen für variablen Teil initialisieren
     C                   MOVEL(P)  *BLANK        D#DRPL
     C                   MOVEL(P)  *BLANK        D#MSGT
     C                   MOVEL(P)  *BLANK        D#MSGH
     C                   MOVEL(P)  *BLANK        D#SUBV
      * Anzahl der Variablen in der MSG
     C                   Z-ADD     *ZERO         P#MANZ
      * MSGID in Zerlegungsstruktur bringen
     C                   MOVEL(P)  XMSGI         D#MSID
      * Länge der Msg-Variablen
     C                   Z-ADD     *ZERO         P#FLDL
     C                   Z-ADD     *ZERO         P#FLDP
      * Rest bei Division
     C                   Z-ADD     *ZERO         P#REST
      * Sourcezeilenstruktur RPG erstmals initialisierem
 B01 C     XFIRST        IFEQ      cTRUE
     C                   CLEAR                   FSRC
     C                   Z-ADD     *ZERO         SRCSEQ
 E01 C                   ENDIF
      *
     C                   ENDSR
      *
      ******************************************************
      * Programm Initialisierung einmalig
      ******************************************************
      *
     C     *INZSR        BEGSR
      *
      * Definition Programmaufrufparameter
      * Input
     C                   MOVEL     XMSGL         XMSGL            10            Msg-Lib
     C                   MOVEL     XMSGF         XMSGF            10            Msg-File
     C                   MOVEL     R#MSGF        R#MSGF           10            Msg-Lib
     C                   MOVEL     R#MSGL        R#MSGL           10            Msg-File
     C                   MOVEL     XMSGI         XMSGI             7            Msg-ID
     C                   MOVEL     XCPYL         XCPYL            10            Cpy-Lib
     C                   MOVEL     XCPYF         XCPYF            10            Cpy-File
     C                   MOVEL     XGENA         XGENA            10            Gener.Art
     C                   MOVEL     XISDFN        XISDFN            1            Define-Best.
     C                   MOVEL     XFIRST        XFIRST            1            1. Msg-ID
     C                   MOVEL     XLAST         XLAST             1            letzte Msg-ID
      * Output
     C                   MOVEL     XMBRT         XMBRT            80            MbrText
     C                   MOVEL     XERRID        XERRID            7            Error-ID
     C                   MOVEL     XERRDT        XERRDT           80            Error-Data
      *
      * Stelle in RTVM0300 ab der variabler Teil beginnt
     C                   Z-ADD     R#OFF3        R#OFF3            4 0          Offset in DS
      *
      * laufender Zähler für Offsets
     C                   Z-ADD     O             O                 4 0
     C                   Z-ADD     OF            OF                3 0
      *
      * laufender Zähler für Positionen in generierter Datenstruktur
     C                   Z-ADD     OD            OD                3 0
      *
      * laufender Zähler Variablenverarbeitung
     C                   Z-ADD     A             A                 4 0
      *
      * Anzahl der Variablen in der MSG
     C                   Z-ADD     P#MANZ        P#MANZ            2 0
      *
      * Länge der Msg-Variablen
     C                   Z-ADD     P#FLDL        P#FLDL            3 0
     C                   Z-ADD     P#FLDP        P#FLDP            3 0
      *
      * Rest bei Division
     C                   Z-ADD     P#REST        P#REST            3 0
      *
      * Namen für Define
     C                   MOVEL     P#DEFN        P#DEFN           20
      *
     C                   ENDSR
      *
      ******************************************************
      * Fehlerbehandlung
      ******************************************************
      *
     C     *PSSR         BEGSR
      *
     C                   DUMP
      *
     C                   ENDSR     '*CANCL'
      *****************************************************************
      *  Replace variables
      *****************************************************************
     P f_replace...
     P                 B
      *
     D f_replace...
     D                 PI           256A
     D  i_string                    256A   value
     D  i_var                        20A   value
     D  i_value                     256A   value
      *
     D x               S             10I 0 inz
     D y               S             10I 0 inz
     D z               S             10I 0 inz
      *---------------------------------------------------------------
      *
     C                   EVAL      x = 0
      *
 B01 C                   DOU       x <= 0
      *
 B02 C                   IF        x > 0
     C                   EVAL      y = x + %len(%trimr(i_var))
     C     '>'           CHECK     i_string:y    y
 B03 C                   IF        y > 0
     C                   EVAL      z = y - x
 X03 C                   ELSE
     C                   EVAL      z = %len(%trimr(i_var))
 E03 C                   Endif
     C                   EVAL      i_string = %replace(%subst(i_value: 1: z):
     C                                                  i_string            :
     C                                                  x                   :
     C                                                  z                   )
 E02 C                   Endif
      *
     C                   EVAL      x = %scan(%trimr(i_var):
     C                                       i_string     )
 E01 C                   Enddo
      *
     C                   RETURN    i_string
      *
     P f_replace...
     P                 E
      *****************************************************************
      *  set to lower
      *****************************************************************
     P f_lcase...
     P                 B
      *
     D f_lcase...
     D                 PI           256A
     D  i_string                    256A   value
      *
     D uc              C                   const('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
     D lc              C                   const('abcdefghijklmnopqrstuvwxyz')
      *---------------------------------------------------------------
      *
     C     uc:lc         XLATE     i_string      i_string
      *
     C                   RETURN    i_string
      *
     P f_lcase...
     P                 E
      *****************************************************************
      *  convert to char
      *****************************************************************
     P f_str...
     P                 B
      *
     D f_str...
     D                 PI           256A
     D  i_value                      30P 0 value
      *
      *---------------------------------------------------------------
      *
     C                   RETURN    %triml(%editc(i_value: 'Z'))
      *
     P f_str...
     P                 E
      *****************************************************************
      *  c structure name
      *****************************************************************
     P f_structName...
     P                 B
      *
     D f_structName...
     D                 PI            20A
      *
      *---------------------------------------------------------------
     C                   RETURN    %trim(f_lcase(D#MSID)) + '_t'
      *
     P f_structName...
     P                 E
      *
**
1
2
3
4
5
6
7
8
9
A
B
C
D
E
F
G
H
I
J
K
L
M
N
O
P
Q
R
S
T
U
V
W
X
Y
Z
**  RPG
      *---------------------------------------------------------------
      * Datenstruktur für Message-ID :
      *
      *
      *
      *
      *
      *
      *
      *
     I            DS
     I I
     I I                                  B   1   40
      *   Keine Ersatzvariablen definiert!
**  IRPG
      *---------------------------------------------------------------
      * Datenstruktur für Message-ID :
      *
      *
      *
      *
      *
      *
      *
      *
     D                 DS
     D                                     INZ(       )
     D                 S             10I 0 INZ(    )
      *   Keine Ersatzvariablen definiert!
 DEF  /IF NOT DEFINED(
 DEF  /DEFINE
 DEF  /ENDIF
 DEF  /IF NOT DEFINED(UNDEFINE_ALL)
 DEF  /IF DEFINED(UNDEFINE_ALL)
 DEF  /UNDEFINE
**  CLP
     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :                              */
     /*                                                             */
     /*-------------------------------------------------------------*/
             PGM        PARM(&I_LIB)

             RMVMSGD MSGID(1234567) MSGF(
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
 wird nicht abgefangen     CPF2407)     /* MsgF  nicht gefunden */

             ADDMSGD
             RCLRSC LVL(*)
             ENDPGM
     /*   Keine Ersatzvariablen definiert!                          */ +
             DCL        VAR(&I_LIB     ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&LIB       ) TYPE(*CHAR) LEN(10)
             CHGVAR     VAR(&LIB       ) VALUE(&I_LIB)
             MONMSG     MSGID(MCH3601) EXEC(DO)
               RMVMSG     PGMQ(*SAME (*)) CLEAR(*ALL)
               CHGVAR     VAR(&LIB) VALUE('%LIB>>>>>>')
             ENDDO
**  C
  /* --------------------------------------------------------------------- */
  /*   Datenstruktur für Message-ID : %%MSGID                              */
  /*   %%MSGTXT>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   */
  /* --------------------------------------------------------------------- */
  typedef _Packed struct {
    %%VARTYPE>>>>>>>>>>  %%VARNAME%%DELIMITER
  } %%STRUCTNAME
#ifndef    %%STRUCTNAME
  #define  %%STRUCTNAME
#endif
