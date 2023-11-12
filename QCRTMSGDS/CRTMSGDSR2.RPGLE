000100231110      * =================================================================== *
000200231110      *                                                                     *
000300231110      *  Kurzdokumentation :                                                *
000400231110      *                                                                     *
000500231110      *  Bereich . . . : CRTMSGDS                                           *
000600231110      *  Objekt  . . . : CRTMSGDSR2                                         *
000700231110      *  Beschreibung  : Tool: CRTMSGDS   (Create Message DS  )             *
000800231110      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *
000900231110      *  Datum . . . . : ?                                                  *
001000231110      *                                                                     *
001100231110      *=====================================================================*
001200231110      *                                                                     *
001300231110      *  This software is free software, you can redistribute it and/or     *
001400231110      *  modify it under the terms of the GNU General Public License (GPL)  *
001500231110      *  as published by the Free Software Foundation.                      *
001600231110      *                                                                     *
001700231110      *  See GNU General Public License for details.                        *
001800231110      *          http://www.opensource.org                                  *
001900231110      *          http://www.opensource.org/licenses/gpl-license.html        *
002000231110      *                                                                     *
002100231110      *=====================================================================*
002200231110      *  History:                                                           *
002300231110      *                                                                     *
002400231110      *  Datum       Name          Änderung                                 *
002500231110      *  ----------  ------------  ---------------------------------------  *
002600231110      *  07.09.2001  Th.Raddatz    Fixed a bug when field length is *ZEROS. *
002700231110      *  10.01.2003  Th.Raddatz    Removed special character § from source. *
002800231110      *  08.03.2005  Th.Raddatz    Fixed problem that trailing blanks of    *
002900231110      *                            message help text were dropped.          *
003000231110      *  21.06.2005  Th.Raddatz    Renamed XMSGT to XMBRT to avoid          *
003100231110      *                            confusion.                               *
003200231110      *                            Increment cL within RPLHPN to fix bug    *
003300231110      *                            that message text was truncated.         *
003400231110      *  18.04.2008  Th.Raddatz    Datenstruktur MS0300 von 1024 auf 8192   *
003500231110      *                            Byte vergrößert.                         *
003600231110      *  26.01.2009  Th.Raddatz    Code des generierten CLP Programms       *
003700231110      *                            geändert. Bibliothek kann jetzt als      *
003800231110      *                            optionaler Parameter übergeben werden.   *
003900231110      *                            Befehlsparameter TYPE um Auswahl         *
004000231110      *                            *CLLE erweitert.                         *
004100231110      *  06.10.2009  Th.Raddatz    Replaced special character '#' by        *
004200231110      *                            '_SIZE' when generating RPGLE copy       *
004300231110      *                            books.                                   *
004400231110      *                                                                     *
004500231110      * =================================================================== *
004600231110      * >>PRE-COMPILER<<                                                    *
004700231110      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
004800231110      *                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
004900231110      *   >>COMPILE<<                                                       *
005000231110      *     >>PARM<< TRUNCNBR(*NO);                                         *
005100231110      *     >>PARM<< DBGVIEW(*LIST);                                        *
005200231110      *     >>PARM<< TGTRLS(V7R1M0);                                        *
005300231110      *   >>END-COMPILE<<                                                   *
005400231110      *   >>EXECUTE<<                                                       *
005500231110      * >>END-PRE-COMPILER<<                                                *
005600231110      * =================================================================== *
005700231110      *                                                                     *
005800231110      *  Attention: If you have applied one of the PTFs listed              *
005900231110      *             below or if you are running V4R3 or above               *
006000231110      *             you should set constant OFS to 1.                       *
006100231110      *             Otherwise you should set OFS to 0.                      *
006200231110      *                                                                     *
006300231110      *             V3R1M0 - SF51811                                        *
006400231110      *             V3R2M0 - SF51812                                        *
006500231110      *             V3R6M0 - SF51813                                        *
006600231110      *             V3R7M0 - SF51814                                        *
006700231110      *             V4R1M0 - SF51815                                        *
006800231110      *             V4R2M0 - SF51817                                        *
006900231110      *                                                                     *
007000231110      * =================================================================== *
007100231110 CPY  /COPY QCRTMSGDS,H_SPEC
007200231110      * =================================================================== *
007300231110      *
007400231110     FSRC       O    F  256        DISK    USROPN
007500231110      *
007600231110     D TXT             S              1    DIM(80)                              eine Zeile
007700231110     D ORD             S              1    DIM(35) CTDATA PERRCD(1)             Num.f.Feldn.
007800231110     D RPG             S             80    DIM(14) CTDATA PERRCD(1)             Sourcezeilen
007900231110     D IRPG            S             80    DIM(20) CTDATA PERRCD(1)             Sourcezeilen
008000231110     D CLP             S             80    DIM(21) CTDATA PERRCD(1)             Sourcezeilen
008100231110     D C               S             80    DIM(10) CTDATA PERRCD(1)             Sourcezeilen
008200231110     D fldName         S             40    inz
008300231110     D fldType         S             40    inz
008400231110      *
008500231110      *------------------------------------------------------------*
008600231110      *  Datensatzbeschreibung für Sourcen
008700231110      *------------------------------------------------------------*
008800231110      *
008900231110     D FSRC            DS
009000231110     D  SRCSEQ                 1      6  2
009100231110     D  SRCSQ1                 1      4
009200231110     D  SRCSQ2                 5      6
009300231110     D  SRCDAT                 7     12  0
009400231110     D  SRCDTA                13    256
009500231110      *
009600231110      *------------------------------------------------------------*
009700231110      *  interne Prototypen
009800231110      *------------------------------------------------------------*
009900231110     D f_replace...
010000231110     D                 PR           256A
010100231110     D  i_string                    256A   value
010200231110     D  i_var                        20A   value
010300231110     D  i_value                     256A   value
010400231110      *
010500231110     D f_lcase...
010600231110     D                 PR           256A
010700231110     D  i_string                    256A   value
010800231110      *
010900231110     D f_str...
011000231110     D                 PR           256A
011100231110     D  i_value                      30P 0 value
011200231110      *
011300231110     D f_structName...
011400231110     D                 PR            20A
011500231110      *
011600231110      *------------------------------------------------------------*
011700231110      *  allg. Feldbeschreibungen für API
011800231110      *------------------------------------------------------------*
011900231110      *
012000231110     D                 DS
012100231110     D  P#VLEN                 1      4I 0
012200231110     D  P#FORM                 5     14
012300231110     D  P#DTAL                15     18I 0
012400231110     D                 DS
012500231110     D  P#MSFL                 1     10
012600231110     D  P#MSLI                11     20
012700231110     D  P#MSGF                 1     20
012800231110      *
012900231110      *------------------------------------------------------------*
013000231110      *  Definition des Satzformates RTVM0300
013100231110      *------------------------------------------------------------*
013200231110     D MS0300          DS
013300231110     D  M3TRTN                 1      4I 0
013400231110     D  M3TVAL                 5      8I 0
013500231110      *
013600231110     D  M3MSSV                 9     12I 0
013700231110     D  M3ALID                13     16I 0
013800231110     D  M3ALOP                17     25
013900231110     D  M3LGIN                26     26
014000231110     D  M3MGID                27     33
014100231110     D  M3RES1                34     36
014200231110      *
014300231110     D  M3NSVF                37     40I 0
014400231110     D  M3CSIT                41     44I 0
014500231110      *
014600231110     D  M3CSIR                45     48I 0
014700231110     D  M3CCIT                49     52I 0
014800231110      *
014900231110     D  M3OFDR                53     56I 0
015000231110     D  M3LGDR                57     60I 0
015100231110     D  M3LDRA                61     64I 0
015200231110      *
015300231110     D  M3OFMG                65     68I 0
015400231110     D  M3LGMR                69     72I 0
015500231110     D  M3LMRA                73     76I 0
015600231110      *
015700231110     D  M3OFMH                77     80I 0
015800231110     D  M3LGMH                81     84I 0
015900231110     D  M3LMHA                85     88I 0
016000231110      *
016100231110     D  M3OFVF                89     92I 0
016200231110     D  M3LGVF                93     96I 0
016300231110     D  M3LVFA                97    100I 0
016400231110     D  M3LVFE               101    104I 0
016500231110      *
016600231110     D  M3RES2               105    256
016700231110     D  M3DATA               257   8192
016800231110      *
016900231110      *-----------------------------------------------------
017000231110      * Format der Ersetzungsvariablen in der Message
017100231110      *-----------------------------------------------------
017200231110      *
017300231110     D MS030F          DS
017400231110     D  M3FLGD                 1      4I 0
017500231110     D  M3FFSZ                 5      8I 0
017600231110     D  M3FTYP                 9     18
017700231110     D  M3FRS1                19    256
017800231110     D  M3FRS2               257    512
017900231110      *
018000231110      *-----------------------------------------------------
018100231110      * Format der ERROR-Struktur bei API'S
018200231110      *-----------------------------------------------------
018300231110     D ERRCOD          DS
018400231110     D  ERRPRV                 1      4I 0 INZ
018500231110     D  ERRAVL                 5      8I 0 INZ
018600231110     D  ERRID                  9     15    INZ
018700231110     D  ERRRSV                16     16    INZ
018800231110     D  ERRDTA                17     32    INZ
018900231110      *
019000231110      * Zerlegung der MSG-ID
019100231110     D D#MSID          DS
019200231110     D  D#MFCH                 1      1    INZ
019300231110     D  D#MPRF                 1      3    INZ
019400231110     D  D#MNBR                 4      7    INZ
019500231110      *
019600231110      * Dezimalposition
019700231110     D                 DS
019800231110     D  D#DPS                  1      1  0 INZ
019900231110     D  D#DEC                  1      1    INZ
020000231110      *
020100231110      * VON-BIS Positionen
020200231110     D                 DS
020300231110     D  D#OD                   1      3  0 INZ
020400231110     D  D#POS                  1      3    INZ
020500231110      *
020600231110      * Unterteilung des 6 stelligen RPG Feldnamens
020700231110     D D#FLD           DS
020800231110     D  D#PRF                  1      1    INZ
020900231110     D  D#NBR                  2      5    INZ
021000231110     D  D#ORD                  6      8    INZ
021100231110      * Unterteilung des 10 stelligen ILE-RPG Feldnamens
021200231110     D D#IFLD          DS
021300231110     D  D#IPRF                 1      3    INZ
021400231110     D  D#INBR                 4      7    INZ
021500231110     D  D#IORD                 8      8    INZ
021600231110     D  D#EXT                  8     12    INZ
021700231110      * Länge der Datenstruktur binär
021800231110     D                 DS
021900231110     D  D#DSLX                 1      4    INZ
022000231110     D  D#DSLG                 1      4  0 INZ
022100231110      *                                7
022200231110     D D#DRPL          DS          8192
022300231110     D D#MSGT          DS          8192
022400231110     D  D#MSG                  1     59
022500231110     D D#MSGH          DS          8192
022600231110     D D#SUBV          DS          8192
022700231110      *
022800231110      *  Arbeitsfeld
022900231110     D #TEMP           DS          8192
023000231110     D #TEXT           DS
023100231110     D  #TB                    1   8192    INZ
023200231110     D                                     DIM(8192)
023300231110     D                 DS
023400231110     D  #Y                     1      3P 0 INZ
023500231110     D                 DS
023600231110     D  #N2                    1      2  0 INZ
023700231110     D  #A2                    1      2    INZ
023800231110     D                 DS
023900231110     D  #N5                    1      5  0 INZ
024000231110     D  #A5                    1      5    INZ
024100231110      *
024200231110      *  Boolsche Konstanten
024300231110     D cFALSE          C                   CONST('0')
024400231110     D cTRUE           C                   CONST('1')
024500231110      *
024600231110      *  Konstanten
024700231110     D cC_DELIM        C                   CONST(';')
024800231110     D cMSGID          C                   CONST('%%MSGID')
024900231110     D cMSGTXT         C                   CONST('%%MSGTXT')
025000231110     D cVARTYPE        C                   CONST('%%VARTYPE')
025100231110     D cVARNAME        C                   CONST('%%VARNAME')
025200231110     D cDELIMITER      C                   CONST('%%DELIMITER')
025300231110     D cSTRUCTNAME     C                   CONST('%%STRUCTNAME')
025400231110      *
025500231110      *  Systemdatenstruktur
025600231110     D sds            SDS
025700231110     D  sds_msgID             40     46
025800231110     D  sds_msgDta            91    170
025900231110      *
026000231110      *  Offset for SUBST
026100231110      *  ... PTF applied or version V4R3 and above
026200231110     D OFS             C                   CONST(1)
026300231110      *  ... PTF not applied
026400231110      ***           0                     C         OFS
026500231110      *
026600231110      *-----------------------------------------------------
026700231110      *
026800231110     C     *ENTRY        PLIST
026900231110      * Input
027000231110     C                   PARM                    XMSGL                          Msg-Lib
027100231110     C                   PARM                    XMSGF                          Msg-File
027200231110     C                   PARM                    XMSGI                          Msg-ID
027300231110     C                   PARM                    XCPYL                          Cpy-Lib
027400231110     C                   PARM                    XCPYF                          Cpy-File
027500231110     C                   PARM                    XGENA                          Gener.Art
027600231110     C                   PARM                    XISDFN                         Define-Best.
027700231110     C                   PARM                    XFIRST                         1. Msg-ID
027800231110     C                   PARM                    XLAST                          Letzte Msg-ID
027900231110      * Output
028000231110     C                   PARM                    XMBRT                          MbrText
028100231110     C                   PARM                    XERRID                         Error-ID
028200231110     C                   PARM                    XERRDT                         Error-Data
028300231110      *
028400231110      *-----------------------------------------------------
028500231110      * Programm Vorlauf
028600231110      *-----------------------------------------------------
028700231110     C                   EXSR      FIRST
028800231110      *
028900231110      *-----------------------------------------------------
029000231110      * Aufruf API vorbereiten
029100231110      *-----------------------------------------------------
029200231110     C                   Z-ADD     8192          P#VLEN
029300231110     C                   MOVEL(P)  'RTVM0300'    P#FORM
029400231110     C                   MOVEL(P)  XMSGI         P#MSGI            7
029500231110     C                   MOVEL(P)  XMSGL         P#MSLI                         Msg File
029600231110     C                   MOVEL(P)  XMSGF         P#MSFL                         Msg File
029700231110     C                   MOVEL(P)  *BLANKS       P#MSGD           80            Msg Dta
029800231110     C     ' '           CHECKR    P#MSGD        P#DTAL                         Msg Dta Len
029900231110      * Replace Substitution variables
030000231110     C                   MOVEL(P)  '*NO'         P#MSRS           10            Msg Repl Sub
030100231110      * Return format control characters
030200231110 B01 C                   IF        (XGENA = '*CLP'   )  or
030300231110     C                             (XGENA = '*CLLE'  )  or
030400231110     C                             (XGENA = '*SCRIPT')
030500231110     C                   MOVEL(P)  '*YES'        P#MSFC           10            Ret Form Cha
030600231110 X01 C                   ELSE
030700231110     C                   MOVEL(P)  '*NO'         P#MSFC           10            Ret Form Cha
030800231110 E01 C                   ENDIF
030900231110     C                   CLEAR                   ERRCOD
031000231110      *
031100231110     C                   CALL      'QMHRTVM'                            99
031200231110     C                   PARM                    MS0300
031300231110     C                   PARM                    P#VLEN
031400231110     C                   PARM                    P#FORM
031500231110     C                   PARM                    P#MSGI                         Msg ID
031600231110     C                   PARM                    P#MSGF                         Msg File
031700231110     C                   PARM                    P#MSGD                         Msg Dta
031800231110     C                   PARM                    P#DTAL                         Msg Dta Len
031900231110     C                   PARM                    P#MSRS                         Msg Repl Sub
032000231110     C                   PARM                    P#MSFC                         Ret Form Cha
032100231110     C                   PARM                    ERRCOD
032200231110      *
032300231110      * prüfen, Aufruf OK
032400231110 B01 C     *IN99         IFEQ      *ON
032500231110     C                   MOVEL(P)  'CPF9897'     XERRID
032600231110     C                   MOVEL(P)  'Aufruf '     XERRDT
032700231110     C                   CAT       'fehler':1    XERRDT
032800231110     C                   CAT       'haft:':0     XERRDT
032900231110     C                   CAT       P#MSGF:1      XERRDT
033000231110     C                   CAT       'MSGID:':1    XERRDT
033100231110     C                   CAT       P#MSGI:1      XERRDT
033200231110     C                   GOTO      ENDE
033300231110 E01 C                   ENDIF
033400231110      *
033500231110      *
033600231110 B01 C     ERRAVL        IFGT      *ZERO
033700231110     C                   MOVEL(P)  ERRID         XERRID
033800231110     C                   MOVEL(P)  ERRDTA        XERRDT
033900231110     C                   GOTO      ENDE
034000231110 E01 C                   ENDIF
034100231110      *
034200231110      * Default Reply rauslösen
034300231110 B01 C     M3LGDR        IFGT      *ZERO
034400231110     C     OFS           ADD       M3OFDR        O
034500231110     C     M3LGDR        SUBST     MS0300:O      D#DRPL
034600231110 E01 C                   ENDIF
034700231110      *
034800231110      * Messagetext rauslösen
034900231110 B01 C     M3LGMR        IFGT      *ZERO
035000231110     C     OFS           ADD       M3OFMG        O
035100231110     C     M3LGMR        SUBST     MS0300:O      D#MSGT
035200231110 E01 C                   ENDIF
035300231110     C                   MOVEL(P)  D#MSGT        XMBRT
035400231110      *
035500231110      * Messagehelp rauslösen
035600231110 B01 C     M3LGMH        IFGT      *ZERO
035700231110     C     OFS           ADD       M3OFMH        O
035800231110     C     M3LGMH        SUBST     MS0300:O      D#MSGH
035900231110 E01 C                   ENDIF
036000231110      *
036100231110      * Ersetzungsvariable rauslösen
036200231110 B01 C     M3LGVF        IFGT      *ZERO
036300231110     C     OFS           ADD       M3OFVF        O
036400231110     C     M3LGVF        SUBST     MS0300:O      D#SUBV
036500231110 E01 C                   ENDIF
036600231110      *
036700231110      * Source generieren
036800231110     C                   EXSR      VGEN
036900231110      *
037000231110     C     ENDE          TAG
037100231110      *
037200231110      * Datei schließen
037300231110     C                   CLOSE     SRC
037400231110      *
037500231110     C                   RETURN
037600231110      *
037700231110      ******************************************************
037800231110      * VGEN  Auswahl welcher Sourcecode generiert wird
037900231110      ******************************************************
038000231110      *
038100231110     C     VGEN          BEGSR
038200231110      *
038300231110 B01 C                   SELECT
038400231110      *
038500231110     C     XGENA         WHENEQ    '*RPG'
038600231110     C                   EXSR      VRPG
038700231110      *
038800231110     C     XGENA         WHENEQ    '*ILERPG'
038900231110     C                   EXSR      VRPG4
039000231110      *
039100231110     C     XGENA         WHENEQ    '*CLP'
039200231110     C     XGENA         OREQ      '*CLLE'
039300231110     C                   MOVEL(P)  XMSGL         R#MSGL                         Msg-Lib
039400231110     C                   MOVEL(P)  '&LIB'        XMSGL                          Msg-Lib
039500231110     C                   EXSR      VCLP
039600231110     C                   MOVEL(P)  R#MSGL        XMSGL                          Msg-Lib
039700231110      *
039800231110     C     XGENA         WHENEQ    '*C'
039900231110     C                   EXSR      VC
040000231110      *
040100231110      * *SCRIPT wie *CLP verarbeiten, nur einzelne Zeilen rauslassen
040200231110     C     XGENA         WHENEQ    '*SCRIPT'
040300231110      * Ersatzvariablen für RUNCLSTM setzen
040400231110     C                   MOVEL(P)  XMSGL         R#MSGL                         Msg-Lib
040500231110     C                   MOVEL(P)  XMSGF         R#MSGF                         Msg-File
040600231110     C                   MOVEL(P)  '&LI'         XMSGL                          Msg-Lib
040700231110     C                   MOVEL(P)  '&SF'         XMSGF                          Msg-File
040800231110     C                   EXSR      VCLP
040900231110     C                   MOVEL(P)  R#MSGL        XMSGL                          Msg-Lib
041000231110     C                   MOVEL(P)  R#MSGF        XMSGF                          Msg-File
041100231110      *
041200231110 X01 C                   OTHER
041300231110      *****                nichts tun
041400231110      *
041500231110 E01 C                   ENDSL
041600231110      *
041700231110     C                   ENDSR
041800231110      *
041900231110      ******************************************************
042000231110      * VRPG  generieren RPG-Source
042100231110      ******************************************************
042200231110      *
042300231110     C     VRPG          BEGSR
042400231110      *
042500231110      * Kommentarzeile durchgehend
042600231110     C                   MOVEL(P)  RPG(1)        SRCDTA
042700231110     C                   EXSR      WRTRPG
042800231110      * Kommentarzeile mit Beschreibung
042900231110     C                   MOVEL(P)  RPG(2)        SRCDTA
043000231110     C                   CAT       XMSGI:1       SRCDTA
043100231110     C                   EXSR      WRTRPG
043200231110      * Kommentarzeile nur Stern
043300231110     C                   MOVEL(P)  RPG(3)        SRCDTA
043400231110     C                   EXSR      WRTRPG
043500231110      * Kommentarzeile mit Nachrichtentext
043600231110     C                   MOVEA(P)  RPG(3)        TXT
043700231110     C                   MOVEA     D#MSG         TXT(9)
043800231110     C                   MOVEA(P)  TXT           SRCDTA
043900231110     C                   EXSR      WRTRPG
044000231110      * Kommentarzeile nur Stern
044100231110     C                   MOVEL(P)  RPG(3)        SRCDTA
044200231110     C                   EXSR      WRTRPG
044300231110      *
044400231110      * Zeile für Datenstrukturfelder erstellen
044500231110     C                   EXSR      RPGFLD
044600231110      * Zeile mit Gesamtlänge der Datenstruktur
044700231110     C                   EXSR      RPGLNG
044800231110      *
044900231110     C                   ENDSR
045000231110      *
045100231110      ******************************************************
045200231110      * VRPG4    generieren Source für ILE-RPG
045300231110      ******************************************************
045400231110      *
045500231110     C     VRPG4         BEGSR
045600231110      *
045700231110      * DEFINE-Rahmen 1
045800231110     C                   EXSR      DEFN1RPG4
045900231110      *
046000231110      * Kommentarzeile durchgehend
046100231110     C                   MOVEL(P)  IRPG(1)       SRCDTA
046200231110     C                   EXSR      WRTRPG
046300231110      * Kommentarzeile mit Beschreibung
046400231110     C                   MOVEL(P)  IRPG(2)       SRCDTA
046500231110     C                   CAT       XMSGI:1       SRCDTA
046600231110     C                   EXSR      WRTRPG
046700231110      * Kommentarzeile nur Stern
046800231110     C                   MOVEL(P)  IRPG(3)       SRCDTA
046900231110     C                   EXSR      WRTRPG
047000231110      * Kommentarzeile mit Nachrichtentext
047100231110     C                   MOVEA(P)  IRPG(3)       TXT
047200231110     C                   MOVEA     D#MSG         TXT(9)
047300231110     C                   MOVEA(P)  TXT           SRCDTA
047400231110     C                   EXSR      WRTRPG
047500231110      * Kommentarzeile nur Stern
047600231110     C                   MOVEL(P)  IRPG(3)       SRCDTA
047700231110     C                   EXSR      WRTRPG
047800231110      *
047900231110      * Zeile für Datenstrukturfelder erstellen
048000231110     C                   EXSR      RPG4FLD
048100231110      * Zeile mit Gesamtlänge der Datenstruktur
048200231110     C                   EXSR      IPGLNG
048300231110      * Kommentarzeile nur Stern
048400231110     C                   MOVEL(P)  IRPG(3)       SRCDTA
048500231110     C                   EXSR      WRTRPG
048600231110      *
048700231110      * DEFINE-Rahmen 2
048800231110     C                   EXSR      DEFN2RPG4
048900231110      *
049000231110     C                   ENDSR
049100231110      *
049200231110      ******************************************************
049300231110      * DEFN1RPG4 - DEFINE-Rahmen 1
049400231110      ******************************************************
049500231110      *
049600231110     C     DEFN1RPG4     BEGSR
049700231110      *
049800231110 B01 C     XISDFN        IFEQ      cFALSE
049900231110      * keine Ausgabe der DEFINE-Bestimmungen
050000231110 X01 C                   ELSE
050100231110      *
050200231110      * /IF NOT DEFINED(UNDEFINE_ALL)
050300231110     C                   MOVEL(P)  IRPG(18)      SRCDTA
050400231110     C                   EXSR      WRTRPG
050500231110      *
050600231110      * Ermitteln Namen für Define
050700231110     C                   EXSR      EMDEFN
050800231110      *
050900231110      * /IF NOT DEFINED(msgid_MSG)
051000231110     C                   MOVEL(P)  IRPG(15)      SRCDTA
051100231110     C                   CAT       P#DEFN:0      SRCDTA
051200231110     C                   CAT       ')':0         SRCDTA
051300231110     C                   EXSR      WRTRPG
051400231110      *
051500231110      * /DEFINE msgid_MSG
051600231110     C                   MOVEL(P)  IRPG(16)      SRCDTA
051700231110     C                   CAT       P#DEFN:1      SRCDTA
051800231110     C                   EXSR      WRTRPG
051900231110      *
052000231110 E01 C                   ENDIF
052100231110      *
052200231110     C                   ENDSR
052300231110      *
052400231110      ******************************************************
052500231110      * DEFN2RPG4 - DEFINE-Rahmen 2
052600231110      ******************************************************
052700231110      *
052800231110     C     DEFN2RPG4     BEGSR
052900231110      *
053000231110 B01 C     XISDFN        IFEQ      cFALSE
053100231110      * keine Ausgabe der DEFINE-Bestimmungen
053200231110 X01 C                   ELSE
053300231110      *
053400231110      * /ENDIF
053500231110     C                   MOVEL(P)  IRPG(17)      SRCDTA
053600231110     C                   EXSR      WRTRPG
053700231110      *
053800231110      * /ENDIF
053900231110     C                   MOVEL(P)  IRPG(17)      SRCDTA
054000231110     C                   EXSR      WRTRPG
054100231110      * Kommentarzeile nur Stern
054200231110     C                   MOVEL(P)  IRPG(3)       SRCDTA
054300231110     C                   EXSR      WRTRPG
054400231110      *
054500231110      * /IF DEFINED(UNDEFINE_ALL)
054600231110     C                   MOVEL(P)  IRPG(19)      SRCDTA
054700231110     C                   EXSR      WRTRPG
054800231110      *
054900231110      * /UNDEFINE msgid_MSG
055000231110     C                   MOVEL(P)  IRPG(20)      SRCDTA
055100231110     C                   CAT       P#DEFN:1      SRCDTA
055200231110     C                   EXSR      WRTRPG
055300231110      *
055400231110      * /ENDIF
055500231110     C                   MOVEL(P)  IRPG(17)      SRCDTA
055600231110     C                   EXSR      WRTRPG
055700231110      *
055800231110 E01 C                   ENDIF
055900231110      *
056000231110     C                   ENDSR
056100231110      *
056200231110      ******************************************************
056300231110      * VCLP     generieren Source für CLP-PROGRAMM
056400231110      ******************************************************
056500231110      *
056600231110     C     VCLP          BEGSR
056700231110      *
056800231110 B01 C     XFIRST        IFEQ      cTRUE
056900231110 B02 C     XGENA         IFNE      '*SCRIPT'
057000231110      * PGM
057100231110     C                   MOVEL(P)  CLP(5)        SRCDTA
057200231110     C                   EXSR      WRTRPG
057300231110      * Leerzeile
057400231110     C                   MOVEL(P)  *BLANKS       SRCDTA
057500231110     C                   EXSR      WRTRPG
057600231110      * DCL &I_LIB
057700231110     C                   MOVEL(P)  CLP(15)       SRCDTA
057800231110     C                   EXSR      WRTRPG
057900231110      * DCL &LIB
058000231110     C                   MOVEL(P)  CLP(16)       SRCDTA
058100231110     C                   EXSR      WRTRPG
058200231110      * Leerzeile
058300231110     C                   MOVEL(P)  *BLANKS       SRCDTA
058400231110     C                   EXSR      WRTRPG
058500231110      * CHGVAR
058600231110     C                   MOVEL(P)  CLP(17)       SRCDTA
058700231110     C                   EXSR      WRTRPG
058800231110      * MONMSG
058900231110     C                   MOVEL(P)  CLP(18)       SRCDTA
059000231110     C                   EXSR      WRTRPG
059100231110      * RMVMSG
059200231110     C                   MOVEL(P)  CLP(19)       SRCDTA
059300231110     C                   EXSR      WRTRPG
059400231110      * CHGVAR
059500231110     C                   EVAL      SRCDTA = f_replace(CLP(20): '%LIB': R#MSGL)
059600231110     C                   EXSR      WRTRPG
059700231110      * ENDDO
059800231110     C                   MOVEL(P)  CLP(21)       SRCDTA
059900231110     C                   EXSR      WRTRPG
060000231110      * Leerzeile
060100231110     C                   MOVEL(P)  *BLANKS       SRCDTA
060200231110     C                   EXSR      WRTRPG
060300231110 X02 C                   ELSE
060400231110      *  Keine Ausgabe bei *SCRIPT
060500231110 E02 C                   ENDIF
060600231110 X01 C                   ELSE
060700231110      *  Ausgabe nur bei 1. Nachrichten-ID
060800231110 E01 C                   ENDIF
060900231110      *
061000231110      * Kommentarzeile durchgehend
061100231110     C                   MOVEL(P)  CLP(1)        SRCDTA
061200231110     C                   EXSR      WRTRPG
061300231110      * Kommentarzeile mit Beschreibung
061400231110     C                   MOVEA(P)  CLP(2)        TXT(1)
061500231110     C                   MOVEA     XMSGI         TXT(42)
061600231110     C                   MOVEA(P)  TXT           SRCDTA
061700231110     C                   EXSR      WRTRPG
061800231110      * Kommentarzeile mit Nachrichtentext
061900231110     C                   MOVEA(P)  CLP(3)        TXT
062000231110     C                   MOVEA     D#MSG         TXT(9)
062100231110     C                   MOVEA     '*/'          TXT(69)
062200231110     C                   MOVEA(P)  TXT           SRCDTA
062300231110     C                   EXSR      WRTRPG
062400231110      * Kommentarzeile durchgehend
062500231110     C                   MOVEL(P)  CLP(1)        SRCDTA
062600231110     C                   EXSR      WRTRPG
062700231110      * Leerzeile
062800231110     C                   MOVEL(P)  *BLANKS       SRCDTA
062900231110     C                   EXSR      WRTRPG
063000231110      *
063100231110      * RMVMSGD
063200231110     C                   MOVEA(P)  CLP(7)        TXT
063300231110     C                   MOVEA     XMSGI         TXT(28)
063400231110     C                   MOVEA     XMSGL         TXT(42)
063500231110     C                   MOVEA(P)  TXT           SRCDTA
063600231110     C                   CAT       '/':0         SRCDTA
063700231110     C                   CAT       XMSGF:0       SRCDTA
063800231110     C                   CAT       ')':0         SRCDTA
063900231110     C                   EXSR      WRTRPG
064000231110      * MONMSG (1)
064100231110     C                   MOVEL(P)  CLP(8)        SRCDTA
064200231110     C                   EXSR      WRTRPG
064300231110      * MONMSG (2)
064400231110      *******              MOVELCLP,9     SRCDTA    P
064500231110      *******              EXSR WRTRPG
064600231110      * Leerzeile
064700231110     C                   MOVEL(P)  *BLANKS       SRCDTA
064800231110     C                   EXSR      WRTRPG
064900231110      * ADDMSGD
065000231110     C                   MOVEL(P)  CLP(11)       SRCDTA
065100231110     C                   CAT       '+':1         SRCDTA
065200231110     C                   EXSR      WRTRPG
065300231110      *
065400231110      * Zeile für Datenstrukturfelder erstellen
065500231110     C                   EXSR      ICLFLD
065600231110      *
065700231110     C                   ENDSR
065800231110      *
065900231110      ******************************************************
066000231110      * VC       generieren Source für C-Programme
066100231110      ******************************************************
066200231110      *
066300231110     C     VC            BEGSR
066400231110      *
066500231110      * DEFINE-Rahmen 1
066600231110     C                   EXSR      DEFN1C
066700231110      *
066800231110      * Kommentarzeile durchgehend
066900231110     C                   EVAL      SRCDTA = c(1)
067000231110     C                   EXSR      WRTRPG
067100231110      * Kommentarzeile mit Beschreibung
067200231110     C                   EVAL      SRCDTA = f_replace(c(2)         :
067300231110     C                                                cMSGID       :
067400231110     C                                                XMSGI        )
067500231110     C                   EXSR      WRTRPG
067600231110      * Kommentarzeile mit Nachrichtentext
067700231110     C                   EVAL      SRCDTA = f_replace(c(3)         :
067800231110     C                                                cMSGTXT      :
067900231110     C                                                D#MSG        )
068000231110     C                   EXSR      WRTRPG
068100231110      * Kommentarzeile durchgehend
068200231110     C                   EVAL      SRCDTA = c(4)
068300231110     C                   EXSR      WRTRPG
068400231110      * Leerzeile
068500231110     C                   MOVEL(P)  *BLANKS       SRCDTA
068600231110     C                   EXSR      WRTRPG
068700231110      *
068800231110      * Zeile für Datenstrukturfelder erstellen
068900231110     C                   EXSR      ICFLD
069000231110      *
069100231110      * DEFINE-Rahmen 2
069200231110     C                   EXSR      DEFN2C
069300231110      *
069400231110     C                   ENDSR
069500231110      *
069600231110      ******************************************************
069700231110      * DEFN1C    - DEFINE-Rahmen 1
069800231110      ******************************************************
069900231110      *
070000231110     C     DEFN1C        BEGSR
070100231110      *
070200231110 B01 C     XISDFN        IFEQ      cFALSE
070300231110      * keine Ausgabe der DEFINE-Bestimmungen
070400231110 X01 C                   ELSE
070500231110      *
070600231110      * #ifndef
070700231110     C                   EVAL      SRCDTA = f_replace(c(8)          :
070800231110     C                                                cSTRUCTNAME   :
070900231110     C                                    '__' + %trim(f_structName))
071000231110     C                   EXSR      WRTRPG
071100231110      *
071200231110      * #define
071300231110     C                   EVAL      SRCDTA = f_replace(c(9)          :
071400231110     C                                                cSTRUCTNAME   :
071500231110     C                                    '__' + %trim(f_structName))
071600231110     C                   EXSR      WRTRPG
071700231110      *
071800231110 E01 C                   ENDIF
071900231110      *
072000231110     C                   ENDSR
072100231110      *
072200231110      ******************************************************
072300231110      * DEFN2C    - DEFINE-Rahmen 2
072400231110      ******************************************************
072500231110      *
072600231110     C     DEFN2C        BEGSR
072700231110      *
072800231110 B01 C     XISDFN        IFEQ      cFALSE
072900231110      * keine Ausgabe der DEFINE-Bestimmungen
073000231110 X01 C                   ELSE
073100231110      *
073200231110      * #endif
073300231110     C                   EVAL      SRCDTA = c(10)
073400231110     C                   EXSR      WRTRPG
073500231110      *
073600231110 E01 C                   ENDIF
073700231110      *
073800231110     C                   ENDSR
073900231110      *
074000231110      ******************************************************
074100231110      * ICFLD  Zeilen für Felddefinitionen generieren
074200231110      ******************************************************
074300231110      *
074400231110     C     ICFLD         BEGSR
074500231110      *
074600231110      * Zeile mit Datenstrukturnamen
074700231110     C                   EVAL      SRCDTA = c(5)
074800231110     C                   EXSR      WRTRPG
074900231110      *
075000231110      * Anzahl der MSG-Variablen bestimmen
075100231110      * (Länge des kpl. Variablenbereichs / Länge einer Variablestruktur)
075200231110     C                   EXSR      GETANZ
075300231110      *
075400231110 B01 C     P#MANZ        IFLE      *ZEROS
075500231110      * ... keine Variablen definiert
075600231110     C                   EVAL      SRCDTA = f_replace(c(6)         :
075700231110     C                                                cVARNAME     :
075800231110     C                                                'dummy'      )
075900231110     C                   EVAL      SRCDTA = f_replace(SRCDTA       :
076000231110     C                                                cVARTYPE     :
076100231110     C                                                'char'       )
076200231110     C                   EVAL      SRCDTA = f_replace(SRCDTA       :
076300231110     C                                                cDELIMITER   :
076400231110     C                                                ';'          )
076500231110     C                   EXSR      WRTRPG
076600231110 X01 C                   ELSE
076700231110      *
076800231110     C                   Z-ADD     1             OF
076900231110 B02 C     1             DO        P#MANZ        A
077000231110      *
077100231110      * einen Variableninformationsblock aus großen Block herausschneiden
077200231110     C                   EXSR      CUTVAR
077300231110      *
077400231110      * Zeilenschablone vorbereiten
077500231110     C                   EVAL      SRCDTA = c(6)
077600231110      *
077700231110      * prüfen, ob Datentyp korrekt, sonst Fehler
077800231110     C                   EXSR      CHKTYP
077900231110      *
078000231110      * Feldnamen zusammenbauen
078100231110     C                   EVAL      fldName = 'd' + ord(a)
078200231110      *
078300231110      * Dezimalstellen oder *BLANK
078400231110     C                   EXSR      GETDEZ
078500231110      *
078600231110 B03 C                   SELECT
078700231110     C                   WHEN      F#TYP = 'A'
078800231110     C                   EVAL      fldType = 'char'
078900231110     C                   EVAL      fldName = %trim(fldName)
079000231110     C                                     + '['
079100231110     C                                     + %trimr(f_str(P#FLDL))
079200231110     C                                     + ']'
079300231110     C                   WHEN      F#TYP = 'P'
079400231110     C                   EVAL      fldType = 'decimal'
079500231110     C                                     + '('
079600231110     C                                     + %trimr(f_str(P#FLDL))
079700231110     C                                     + ','
079800231110     C                                     + %trimr(f_str(D#DPS ))
079900231110     C                                     + ')'
080000231110     C                   WHEN      F#TYP = 'B'
080100231110 B04 C                   SELECT
080200231110     C                   WHEN      P#FLDL = 9
080300231110     C                   EVAL      fldType = 'long'
080400231110     C                   WHEN      P#FLDL = 4
080500231110     C                   EVAL      fldType = 'short'
080600231110 X04 C                   OTHER
080700231110     C                   EVAL      fldType = '*error'
080800231110 E04 C                   ENDSL
080900231110 E03 C                   ENDSL
081000231110      *
081100231110     C                   EVAL      SRCDTA = f_replace(c(6)         :
081200231110     C                                                cVARNAME     :
081300231110     C                                                fldName      )
081400231110     C                   EVAL      SRCDTA = f_replace(SRCDTA       :
081500231110     C                                                cVARTYPE     :
081600231110     C                                                fldType      )
081700231110     C                   EVAL      SRCDTA = f_replace(SRCDTA       :
081800231110     C                                                cDELIMITER   :
081900231110     C                                                cC_DELIM     )
082000231110      *
082100231110 B03 C                   IF        P#FLDL = 0
082200231110     C                   EVAL      %SUBST(SRCDTA: 2: 2) = '/*'
082300231110     C                   EVAL      %SUBST(SRCDTA:40: 9) = 'Länge = 0'
082400231110     C                   EVAL      %SUBST(SRCDTA:50: 2) = '*/'
082500231110 E03 C                   ENDIF
082600231110      *
082700231110      * Zeile wegschreiben
082800231110     C                   EXSR      WRTRPG
082900231110      *
083000231110 E02 C                   ENDDO
083100231110      *
083200231110 E01 C                   ENDIF
083300231110      *
083400231110     C                   EVAL      SRCDTA = f_replace(c(7)          :
083500231110     C                                                cSTRUCTNAME   :
083600231110     C                                %trim(f_structName) + cC_DELIM)
083700231110     C                   EXSR      WRTRPG
083800231110      *
083900231110     C                   ENDSR
084000231110      *
084100231110      ******************************************************
084200231110      * RPGFLD Zeilen für Felddefinitionen generieren
084300231110      ******************************************************
084400231110      *
084500231110     C     RPGFLD        BEGSR
084600231110      *
084700231110      * Zeile mit Datenstrukturnamen
084800231110     C                   MOVEA(P)  RPG(11)       TXT
084900231110     C                   MOVEA     D#MFCH        TXT(7)
085000231110     C                   MOVEA     D#MNBR        TXT(8)
085100231110     C                   MOVEA(P)  TXT           SRCDTA
085200231110     C                   EXSR      WRTRPG
085300231110      *
085400231110      * Anzahl der MSG-Variablen bestimmen
085500231110      * (Länge des kpl. Variablenbereichs / Länge einer Variablestruktur)
085600231110     C                   EXSR      GETANZ
085700231110      *
085800231110 B01 C     P#MANZ        IFLE      *ZEROS
085900231110     C                   Z-ADD     *ZEROS        D#DSLG
086000231110      * ... keine Variablen definiert
086100231110     C                   MOVEL(P)  RPG(14)       SRCDTA
086200231110     C                   EXSR      WRTRPG
086300231110 X01 C                   ELSE
086400231110      *
086500231110     C                   Z-ADD     1             OF
086600231110     C                   Z-ADD     1             OD
086700231110 B02 C     1             DO        P#MANZ        A
086800231110      *
086900231110      * einen Variableninformationsblock aus großen Block herausschneiden
087000231110     C                   EXSR      CUTVAR
087100231110      *
087200231110      * Zeilenschablone vorbereiten
087300231110     C                   MOVEA(P)  RPG(12)       TXT
087400231110      *
087500231110      * prüfen, ob Datentyp korrekt, sonst Fehler
087600231110     C                   EXSR      CHKTYP
087700231110      *
087800231110      * Feldnamen zusammenbauen
087900231110     C                   CLEAR                   D#FLD
088000231110     C                   MOVEL     D#MFCH        D#PRF
088100231110     C                   MOVEL     D#MNBR        D#NBR
088200231110     C                   MOVEL (P) ORD(A)        D#ORD
088300231110     C                   MOVEA     D#FLD         TXT(53)
088400231110      *
088500231110      * Dezimalstellen oder *BLANK
088600231110     C                   EXSR      GETDEZ
088700231110      *
088800231110 B03 C     F#TYP         IFEQ      'A'
088900231110     C                   MOVEL(P)  *BLANKS       F#TYP
089000231110 E03 C                   ENDIF
089100231110      *
089200231110     C                   MOVEA     F#TYP         TXT(43)
089300231110     C                   MOVEA     D#DEC         TXT(52)
089400231110      *
089500231110      * Feld hat Länge 0
089600231110 B03 C                   IF        P#FLDP = 0
089700231110     C                   MOVEA     ' * '         TXT(6)
089800231110     C                   Z-ADD     *ZEROS        D#OD
089900231110     C                   MOVEA     D#POS         TXT(45)
090000231110     C                   MOVEA     D#POS         TXT(49)
090100231110     C                   MOVEA     'Länge = 0'   TXT(61)
090200231110 X03 C                   ELSE
090300231110      *
090400231110      * VON-Position
090500231110     C                   Z-ADD     OD            D#OD                           füllen D#POS
090600231110     C                   MOVEA     D#POS         TXT(45)
090700231110     C                   ADD       P#FLDP        OD
090800231110     C                   SUB       1             OD
090900231110      *
091000231110      * BIS-Position
091100231110     C                   Z-ADD     OD            D#OD                           füllen D#POS
091200231110     C                   MOVEA     D#POS         TXT(49)
091300231110     C                   Z-ADD     D#OD          D#DSLG
091400231110     C                   ADD       1             OD
091500231110 E03 C                   ENDIF
091600231110      *
091700231110      * Zeile wegschreiben
091800231110     C                   MOVEA(P)  TXT           SRCDTA
091900231110     C                   EXSR      WRTRPG
092000231110      *
092100231110 E02 C                   ENDDO
092200231110      *
092300231110 E01 C                   ENDIF
092400231110      *
092500231110     C                   ENDSR
092600231110      *
092700231110      ******************************************************
092800231110      * RPGLNG Zeile mit Länge der Datenstruktur absetzen
092900231110      ******************************************************
093000231110      *
093100231110     C     RPGLNG        BEGSR
093200231110      *
093300231110      * Zeile mit Datenstrukturdefinition (nur DS, unbenannt)
093400231110     C                   MOVEA(P)  RPG(11)       TXT
093500231110     C                   MOVEA(P)  TXT           SRCDTA
093600231110     C                   EXSR      WRTRPG
093700231110      *
093800231110      * Zeile mit Datenstrukturlänge anlegen
093900231110     C                   MOVEA(P)  RPG(13)       TXT
094000231110      *
094100231110      * Strukturlänge wegschreiben
094200231110     C                   MOVEA     D#DSLX        TXT(21)
094300231110      *
094400231110      * Feldnamen zusammenbauen
094500231110     C                   CLEAR                   D#FLD
094600231110     C                   MOVEL     D#MFCH        D#PRF
094700231110     C                   MOVEL     D#MNBR        D#NBR
094800231110     C                   MOVEL (P) 'LEN'         D#ORD
094900231110     C                   MOVEA     D#FLD         TXT(53)
095000231110      *
095100231110     C                   MOVEA(P)  TXT           SRCDTA
095200231110     C                   EXSR      WRTRPG
095300231110      *
095400231110     C                   ENDSR
095500231110      *
095600231110      ******************************************************
095700231110      * RPG4FLD - Zeilen für Felddefinitionen generieren ILE
095800231110      ******************************************************
095900231110      *
096000231110     C     RPG4FLD       BEGSR
096100231110      *
096200231110      * Zeile mit Datenstrukturnamen
096300231110     C                   MOVEA(P)  IRPG(11)      TXT
096400231110     C                   MOVEA     D#MSID        TXT(8)
096500231110     C                   MOVEA(P)  TXT           SRCDTA
096600231110     C                   EXSR      WRTRPG
096700231110      *
096800231110      * Anzahl der MSG-Variablen bestimmen
096900231110      * (Länge des kpl. Variablenbereichs / Länge einer Variablestruktur)
097000231110     C                   EXSR      GETANZ
097100231110      *
097200231110 B01 C     P#MANZ        IFLE      *ZEROS
097300231110     C                   Z-ADD     *ZEROS        D#DSLG
097400231110      * ... keine Variablen definiert
097500231110     C                   MOVEL(P)  IRPG(14)      SRCDTA
097600231110     C                   EXSR      WRTRPG
097700231110 X01 C                   ELSE
097800231110      *
097900231110     C                   Z-ADD     1             OF
098000231110     C                   Z-ADD     1             OD
098100231110     C                   Z-ADD     *ZERO         D#DSLG
098200231110 B02 C     1             DO        P#MANZ        A
098300231110      *
098400231110      * einen Variableninformationsblock aus großen Block herausschneiden
098500231110     C                   EXSR      CUTVAR
098600231110      *
098700231110      * Zeilenschablone vorbereiten - ILE
098800231110     C                   MOVEA(P)  IRPG(12)      TXT
098900231110      *
099000231110      * prüfen, ob Datentyp korrekt, sonst Fehler
099100231110     C                   EXSR      CHKTYP
099200231110      *
099300231110      * Feldnamen zusammenbauen
099400231110     C                   CLEAR                   D#IFLD
099500231110     C                   MOVEL     D#MPRF        D#IPRF
099600231110     C                   MOVEL     D#MNBR        D#INBR
099700231110     C                   MOVEL     ORD(A)        D#IORD
099800231110     C                   MOVEA     D#IFLD        TXT(9)
099900231110      *
100000231110      * Dezimalstellen oder *BLANK ...
100100231110     C                   EXSR      GETDEZ
100200231110      * ... Initialisierung
100300231110 B03 C                   SELECT
100400231110     C     F#TYP         WHENEQ    'A'
100500231110     C                   MOVEA     '*BLANKS'     TXT(48)
100600231110     C     F#TYP         WHENEQ    'P'
100700231110     C                   MOVEA     '*ZEROS'      TXT(48)
100800231110     C     F#TYP         WHENEQ    'B'
100900231110     C                   MOVEA     '*ZEROS'      TXT(48)
101000231110 X03 C                   OTHER
101100231110     C                   MOVEA     '*ERROR'      TXT(48)
101200231110 E03 C                   ENDSL
101300231110      * ... Feldtyp
101400231110     C                   MOVEA     F#TYP         TXT(40)
101500231110      * ... Dezimalstellen
101600231110     C                   MOVEA     D#DEC         TXT(42)
101700231110      * ... Feldlänge
101800231110 B03 C                   IF        P#FLDP = *ZEROS
101900231110     C                   MOVEA     ' *'          TXT(6)
102000231110     C                   Z-ADD     *ZEROS        D#OD                           füllen D#POS
102100231110     C                   MOVEA     D#POS         TXT(37)
102200231110     C                   MOVEA     'Länge = 0'   TXT(58)
102300231110 X03 C                   ELSE
102400231110     C                   Z-ADD     P#FLDL        D#OD                           füllen D#POS
102500231110     C                   ADD       P#FLDP        D#DSLG
102600231110     C                   MOVEA     D#POS         TXT(37)
102700231110 E03 C                   ENDIF
102800231110      *
102900231110      * Zeile wegschreiben
103000231110     C                   MOVEA(P)  TXT           SRCDTA
103100231110     C                   EXSR      WRTRPG
103200231110      *
103300231110 E02 C                   ENDDO
103400231110      *
103500231110 E01 C                   ENDIF
103600231110      *
103700231110     C                   ENDSR
103800231110      *
103900231110      ******************************************************
104000231110      * IPGLNG Zeile mit Länge der Datenstruktur absetzen
104100231110      ******************************************************
104200231110      *
104300231110     C     IPGLNG        BEGSR
104400231110      *
104500231110      * Zeile mit Datenstrukturdefinition (nur DS, unbenannt)
104600231110     C                   MOVEA(P)  IRPG(13)      TXT
104700231110      *
104800231110      * Strukturlänge wegschreiben
104900231110     C                   MOVEA     D#DSLX        TXT(48)
105000231110      *
105100231110      * Feldnamen zusammenbauen
105200231110     C                   CLEAR                   D#IFLD
105300231110     C                   MOVEL     D#MPRF        D#IPRF
105400231110     C                   MOVEL     D#MNBR        D#INBR
105500231110     C                   MOVEL     '_SIZE'       D#EXT
105600231110     C                   MOVEA     D#IFLD        TXT(8)
105700231110      *
105800231110     C                   MOVEA(P)  TXT           SRCDTA
105900231110     C                   EXSR      WRTRPG
106000231110      *
106100231110     C                   ENDSR
106200231110      *
106300231110      ******************************************************
106400231110      * ICLFLD Zeilen für Felddefinitionen generieren CLP
106500231110      ******************************************************
106600231110      *
106700231110     C     ICLFLD        BEGSR
106800231110      *
106900231110      * Startposition für Schlüsselworte
107000231110     C                   Z-ADD     16            #P                5 0
107100231110      * Startposition für eingerückte Werte
107200231110     C                   Z-ADD     21            #Z                5 0
107300231110      * Startposition für Nachrichtentexte
107400231110     C                   Z-ADD     1             #Z1               5 0
107500231110      * Arbeitsfeld
107600231110     C                   Z-ADD     *ZEROS        cS                5 0
107700231110     C                   Z-ADD     *ZEROS        cL                5 0
107800231110     C                   Z-ADD     *ZEROS        cI                5 0
107900231110      *
108000231110      * MSGID()
108100231110     C                   CAT(P)    'MSGID':#P    SRCDTA
108200231110     C                   EXSR      OPNBRK
108300231110     C                   CAT       XMSGI:0       SRCDTA
108400231110     C                   EXSR      CLSBRK
108500231110     C                   EXSR      WRTRPG
108600231110      *
108700231110      * MSGF()
108800231110     C                   CAT(P)    'MSGF':#P     SRCDTA
108900231110     C                   EXSR      OPNBRK
109000231110     C                   CAT       XMSGL:0       SRCDTA
109100231110     C                   CAT       '/':0         SRCDTA
109200231110     C                   CAT       XMSGF:0       SRCDTA
109300231110     C                   EXSR      CLSBRK
109400231110     C                   EXSR      WRTRPG
109500231110      *
109600231110      * MSG()
109700231110 B01 C     M3LGMR        IFGT      *ZEROS
109800231110     C                   CAT(P)    'MSG':#P      SRCDTA
109900231110     C                   EXSR      OPNBRK
110000231110     C                   CAT       '+':0         SRCDTA
110100231110     C                   EXSR      WRTRPG
110200231110      *
110300231110     C                   Z-ADD     M3OFMG        cS
110400231110     C                   ADD       1             cS
110500231110     C                   Z-ADD     M3LGMR        cL
110600231110     C     cL            SUBST(P)  MS0300:cS     #TEXT
110700231110      *
110800231110     C                   EXSR      RPLHPN
110900231110     C     ''''          CAT(P)    #TEXT         #TEXT
111000231110    R ***                CAT       '''':0        #TEXT
111100231110     C     cL            ADD       2             cI
111200231110     C                   MOVEL(P)  ''''          #TB(cI)
111300231110      *
111400231110     C                   EXSR      SPLITT
111500231110      *
111600231110     C                   CAT(P)    ') +':#P      SRCDTA
111700231110     C                   EXSR      WRTRPG
111800231110 E01 C                   ENDIF
111900231110      *
112000231110      * SECLVL()
112100231110 B01 C     M3LGMH        IFGT      *ZEROS
112200231110     C                   CAT(P)    'SEC':#P      SRCDTA
112300231110     C                   CAT(P)    'LVL':0       SRCDTA
112400231110     C                   EXSR      OPNBRK
112500231110     C                   CAT       '+':0         SRCDTA
112600231110     C                   EXSR      WRTRPG
112700231110      *
112800231110     C                   Z-ADD     M3OFMH        cS
112900231110     C                   ADD       1             cS
113000231110     C                   Z-ADD     M3LGMH        cL
113100231110     C     cL            SUBST(P)  MS0300:cS     #TEXT
113200231110      *
113300231110     C                   EXSR      RPLHPN
113400231110     C     ''''          CAT(P)    #TEXT         #TEXT
113500231110     C                   CAT       '''':0        #TEXT
113600231110     C                   EXSR      SPLITT
113700231110      *
113800231110     C                   CAT(P)    ') +':#P      SRCDTA
113900231110     C                   EXSR      WRTRPG
114000231110 E01 C                   ENDIF
114100231110      *
114200231110      * SEV()
114300231110     C                   CAT(P)    'SEV':#P      SRCDTA
114400231110     C                   EXSR      OPNBRK
114500231110     C                   Z-ADD     M3MSSV        #N2
114600231110     C                   CAT       #A2:0         SRCDTA
114700231110     C                   EXSR      CLSBRK
114800231110     C                   EXSR      WRTRPG
114900231110      *
115000231110      * Anzahl der MSG-Variablen bestimmen
115100231110      * (Länge des kpl. Variablenbereichs / Länge einer Variablestruktur)
115200231110     C                   EXSR      GETANZ
115300231110      *
115400231110 B01 C     P#MANZ        IFLE      *ZEROS
115500231110      * ... keine Variablen definiert
115600231110     C                   MOVEL(P)  CLP(14)       SRCDTA
115700231110     C                   EXSR      WRTRPG
115800231110 X01 C                   ELSE
115900231110      *
116000231110      * FMT()
116100231110 B02 C     P#MANZ        IFGT      *ZEROS
116200231110     C                   CAT(P)    'FMT':#P      SRCDTA
116300231110     C                   EXSR      OPNBRK
116400231110     C                   CAT(P)    ' +':0        SRCDTA
116500231110     C                   EXSR      WRTRPG
116600231110 E02 C                   ENDIF
116700231110      *
116800231110     C                   Z-ADD     1             OF
116900231110     C                   Z-ADD     1             OD
117000231110 B02 C     1             DO        P#MANZ        A
117100231110      *
117200231110     C                   EVAL      %SUBST(SRCDTA: #Z: 1) = '('
117300231110      *
117400231110      * einen Variableninformationsblock aus großen Block herausschneiden
117500231110     C                   EXSR      CUTVAR
117600231110      *
117700231110      * prüfen, ob Datentyp korrekt, sonst Fehler
117800231110     C                   EXSR      CHKTYP
117900231110      *
118000231110      * Dezimalstellen oder *BLANK ...
118100231110     C                   EXSR      GETDEZ
118200231110      * ... Initialisierung
118300231110 B03 C                   SELECT
118400231110     C     F#TYP         WHENEQ    'B'
118500231110     C                   CAT       '*BIN':0      SRCDTA
118600231110 B04 C     P#FLDL        IFGE      5
118700231110     C                   Z-ADD     4             P#FLDL
118800231110 X04 C                   ELSE
118900231110     C                   Z-ADD     2             P#FLDL
119000231110 E04 C                   ENDIF
119100231110 X03 C                   OTHER
119200231110     C                   CAT       M3FTYP:0      SRCDTA
119300231110 E03 C                   ENDSL
119400231110      * ... Feldlänge
119500231110     C                   Z-ADD     P#FLDL        D#OD                           füllen D#POS
119600231110     C                   CAT       D#POS:1       SRCDTA
119700231110      * ... Dezimalstellen
119800231110     C                   CAT       D#DEC:1       SRCDTA
119900231110      *
120000231110      * Zeile wegschreiben
120100231110     C                   CAT(P)    ') +':0       SRCDTA
120200231110     C                   EXSR      WRTRPG
120300231110      *
120400231110 E02 C                   ENDDO
120500231110      *
120600231110     C                   CAT(P)    ') +':#P      SRCDTA
120700231110     C                   EXSR      WRTRPG
120800231110 E01 C                   ENDIF
120900231110      *
121000231110      * ALROPT()
121100231110     C                   CAT(P)    'ALR':#P      SRCDTA
121200231110     C                   CAT(P)    'OPT':0       SRCDTA
121300231110     C                   EXSR      OPNBRK
121400231110     C                   CAT       M3ALOP:0      SRCDTA
121500231110 B01 C     M3ALID        IFGE      1
121600231110     C     M3ALID        ANDLE     99
121700231110     C                   Z-ADD     M3ALID        #N2
121800231110     C                   CAT       #A2:1         SRCDTA
121900231110 E01 C                   ENDIF
122000231110     C                   EXSR      CLSBRK
122100231110     C                   EXSR      WRTRPG
122200231110      *
122300231110      * CCSID()
122400231110     C                   CAT(P)    'CCSID':#P    SRCDTA
122500231110     C                   EXSR      OPNBRK
122600231110     C                   Z-ADD     M3CCIT        #N5
122700231110     C                   CAT       #A5:1         SRCDTA
122800231110     C                   EXSR      CLSBRK
122900231110     C                   EXSR      WRTRPG
123000231110      *
123100231110      * EOF
123200231110     C                   CAT(P)    '/*':#P       SRCDTA
123300231110     C                   CAT       '-EOF-':2     SRCDTA
123400231110     C                   CAT       '*/':2        SRCDTA
123500231110     C                   EXSR      WRTRPG
123600231110      *
123700231110      * Leerzeile
123800231110     C                   MOVEL(P)  *BLANKS       SRCDTA
123900231110     C                   EXSR      WRTRPG
124000231110      *
124100231110 B01 C     XLAST         IFEQ      cTRUE
124200231110      * nicht bei *SCRIPT
124300231110     C     XGENA         ANDNE     '*SCRIPT'
124400231110      * RCLRSC
124500231110     C                   MOVEL(P)  CLP(12)       SRCDTA
124600231110     C                   EXSR      WRTRPG
124700231110      *
124800231110      * Leerzeile
124900231110     C                   MOVEL(P)  *BLANKS       SRCDTA
125000231110     C                   EXSR      WRTRPG
125100231110      *
125200231110      * ENDPGM
125300231110     C                   MOVEL(P)  CLP(13)       SRCDTA
125400231110     C                   EXSR      WRTRPG
125500231110 X01 C                   ELSE
125600231110      *  Ausgabe nur bei letzter Nachrichten-ID
125700231110 E01 C                   ENDIF
125800231110      *
125900231110     C                   ENDSR
126000231110      *
126100231110      ******************************************************
126200231110      * RPLHPN   - Replace hyphen
126300231110      *            Ersetzen Hochkomma durch doppelte
126400231110      *            Hochkomma
126500231110      ******************************************************
126600231110      *
126700231110     C     RPLHPN        BEGSR
126800231110      *
126900231110     C                   Z-ADD     1             #Y
127000231110      *
127100231110 B01 C     #Y            DOUEQ     *ZEROS
127200231110      *
127300231110     C     ''''          SCAN      #TEXT:#Y      #Y
127400231110 B02 C     #Y            IFLE      *ZEROS
127500231110      *  Nichts weiter zu tun ...
127600231110 X02 C                   ELSE
127700231110      *  Zweite "Hälfte" retten ...
127800231110     C                   ADD       1             #Y
127900231110 B03 C     #Y            IFLE      8192
128000231110     C                   SUBST     #TEXT:#Y      #TEMP
128100231110 X03 C                   ELSE
128200231110      *  "ASSERT"
128300231110     C                   MOVEL     'CPF9897'     sds_msgID
128400231110     C     '#Y:'         CAT       '> 8192':1    sds_msgDta
128500231110     C                   EXSR      *PSSR
128600231110 E03 C                   ENDIF
128700231110      *
128800231110     C                   MOVEA     ''''          #TB(#Y)
128900231110     C                   ADD       1             #Y
129000231110     C                   ADD       1             cL
129100231110 B03 C     #Y            IFLE      8192
129200231110     C                   MOVEA     #TEMP         #TB(#Y)
129300231110 X03 C                   ELSE
129400231110      *  "ASSERT"
129500231110     C                   MOVEL     'CPF9897'     sds_msgID
129600231110     C     '#Y:'         CAT       '> 8192':1    sds_msgDta
129700231110     C                   EXSR      *PSSR
129800231110 E03 C                   ENDIF
129900231110      *
130000231110 E02 C                   ENDIF
130100231110      *
130200231110 E01 C                   ENDDO
130300231110      *
130400231110     C                   ENDSR
130500231110      *
130600231110      ******************************************************
130700231110      * SPLITT   - Aufsplitten von #TEXT auf mehrere Zeilen
130800231110      ******************************************************
130900231110      *
131000231110     C     SPLITT        BEGSR
131100231110      *
131200231110     C     71            SUB       #Z1           #L                5 0
131300231110     C                   Z-ADD     *ZEROS        #X                5 0
131400231110      *
131500231110 B01 C     #TEXT         DOWNE     *BLANKS
131600231110      *
131700231110      *  Übertragen Nachrichtentext in Datenzeile
131800231110     C                   Z-ADD     1             #S                5 0
131900231110     C     #L            SUBST(P)  #TEXT:#S      SRCDTA
132000231110      *
132100231110      *  Entfernen übertragene Zeichen aus Nachrichtentext
132200231110     C                   ADD       #L            #S
132300231110 B02 C     #S            IFLE      8192
132400231110     C                   SUBST(P)  #TEXT:#S      #TEXT
132500231110 X02 C                   ELSE
132600231110     C                   MOVEL(P)  *BLANKS       #TEXT
132700231110 E02 C                   ENDIF
132800231110      *
132900231110      *  Anfügen Fortsetzungszeichen
133000231110     C                   MOVEA     SRCDTA        TXT(#Z1)
133100231110     C     #Z1           ADD       #L            #X
133200231110      *
133300231110 B02 C     #TEXT         IFEQ      *BLANKS
133400231110     C                   MOVE      '+'           TXT(#X)
133500231110 X02 C                   ELSE
133600231110     C                   MOVE      '-'           TXT(#X)
133700231110 E02 C                   ENDIF
133800231110      *
133900231110     C                   MOVEA(P)  TXT           SRCDTA
134000231110      *
134100231110      *  Ausgeben Datenzeile
134200231110     C                   EXSR      WRTRPG
134300231110 E01 C                   ENDDO
134400231110      *
134500231110     C                   ENDSR
134600231110      *
134700231110      ******************************************************
134800231110      * OPNBRK   - Íffnen Klammer (Open bracket)
134900231110      ******************************************************
135000231110      *
135100231110     C     OPNBRK        BEGSR
135200231110      *
135300231110     C                   CAT       '(':0         SRCDTA
135400231110      *
135500231110     C                   ENDSR
135600231110      *
135700231110      ******************************************************
135800231110      * CLSBRK   - Schließen Klammer (Close bracket)
135900231110      ******************************************************
136000231110      *
136100231110     C     CLSBRK        BEGSR
136200231110      *
136300231110     C                   CAT       ') +':0       SRCDTA
136400231110      *
136500231110     C                   ENDSR
136600231110      *
136700231110      ******************************************************
136800231110      * CHKTYP   - Prüfen Datentyp
136900231110      ******************************************************
137000231110      *
137100231110     C     CHKTYP        BEGSR
137200231110      *
137300231110 B01 C     M3FTYP        IFNE      '*QTDCHAR'
137400231110     C     M3FTYP        ANDNE     '*CHAR'
137500231110     C     M3FTYP        ANDNE     '*DEC'
137600231110     C     M3FTYP        ANDNE     '*HEX'
137700231110     C     M3FTYP        ANDNE     '*BIN'
137800231110     C                   MOVEL(P)  'CPF9897'     XERRID
137900231110     C                   MOVEL(P)  'MSG-ID:'     XERRDT
138000231110     C                   CAT       M3MGID:1      XERRDT
138100231110     C                   CAT       'Unerla':1    XERRDT
138200231110     C                   CAT       'ubter':0     XERRDT
138300231110     C                   CAT       'Typ':1       XERRDT
138400231110     C                   CAT       M3FTYP:1      XERRDT
138500231110     C                   GOTO      ENDE
138600231110 E01 C                   ENDIF
138700231110      *
138800231110     C                   ENDSR
138900231110      *
139000231110      ******************************************************
139100231110      * GETANZ   - Bestimmen Anzahl Variablen
139200231110      ******************************************************
139300231110      *
139400231110     C     GETANZ        BEGSR
139500231110      *
139600231110 B01 C     M3LGVF        IFGT      *ZERO
139700231110     C     M3LGVF        DIV       M3LVFE        P#MANZ
139800231110 X01 C                   ELSE
139900231110     C                   Z-ADD     *ZERO         P#MANZ
140000231110 E01 C                   ENDIF
140100231110      *
140200231110     C                   ENDSR
140300231110      *
140400231110      ******************************************************
140500231110      * CUTVAR   - Herausschneiden eines Variablen-
140600231110      *            informationsblock aus großen Block
140700231110      ******************************************************
140800231110      *
140900231110     C     CUTVAR        BEGSR
141000231110      *
141100231110     C                   CLEAR                   MS030F
141200231110     C     M3LVFE        SUBST     D#SUBV:OF     MS030F
141300231110     C                   ADD       M3LVFE        OF
141400231110      *
141500231110     C                   ENDSR
141600231110      *
141700231110      ******************************************************
141800231110      * GETDEZ   - Ermitteln Anzahl Dezimalstellen
141900231110      *            und Feldtyp
142000231110      ******************************************************
142100231110      *
142200231110     C     GETDEZ        BEGSR
142300231110      *
142400231110      * Feldlänge laut MSGD
142500231110     C                   Z-ADD     M3FLGD        P#FLDL
142600231110     C                   Z-ADD     M3FLGD        P#FLDP
142700231110      *
142800231110      * und rechnen
142900231110 B01 C                   SELECT
143000231110     C     M3FTYP        WHENEQ    '*QTDCHAR'
143100231110     C                   MOVEL     *BLANK        D#DEC
143200231110     C                   MOVEL     'A'           F#TYP             1
143300231110      *
143400231110     C     M3FTYP        WHENEQ    '*CHAR'
143500231110     C                   MOVEL     *BLANK        D#DEC
143600231110     C                   MOVEL     'A'           F#TYP
143700231110      *
143800231110     C     M3FTYP        WHENEQ    '*HEX'
143900231110     C                   MOVEL     *BLANK        D#DEC
144000231110     C                   MOVEL     'A'           F#TYP
144100231110      *
144200231110     C     M3FTYP        WHENEQ    '*DEC'
144300231110     C                   Z-ADD     M3FFSZ        D#DPS
144400231110      *          die Feldlänge für gepackt errechnen
144500231110     C     P#FLDL        DIV       2             P#FLDP
144600231110     C                   ADD       1             P#FLDP
144700231110     C                   MOVEL     'P'           F#TYP
144800231110      *
144900231110     C     M3FTYP        WHENEQ    '*BIN'
145000231110 B02 C     P#FLDL        IFEQ      4
145100231110     C                   Z-ADD     9             P#FLDL
145200231110 X02 C                   ELSE
145300231110     C                   Z-ADD     4             P#FLDL
145400231110 E02 C                   ENDIF
145500231110     C                   MOVEL     'B'           F#TYP
145600231110     C                   Z-ADD     *ZEROS        D#DPS
145700231110      *
145800231110 E01 C                   ENDSL
145900231110      *
146000231110     C                   ENDSR
146100231110      *
146200231110      ******************************************************
146300231110      * WRTRPG Schreiben Zeile in Sourcedatei
146400231110      ******************************************************
146500231110      *
146600231110     C     WRTRPG        BEGSR
146700231110      *
146800231110     C                   ADD       ,01           SRCSEQ
146900231110     C                   Z-ADD     *ZERO         SRCDAT
147000231110     C                   WRITE     SRC           FSRC
147100231110      *
147200231110     C                   MOVEL(P)  *BLANKS       SRCDTA
147300231110     C                   MOVEA(P)  *BLANKS       TXT
147400231110      *
147500231110     C                   ENDSR
147600231110      *
147700231110      ******************************************************
147800231110      * EMDEFN   - Ermitteln DEFINE-Namen
147900231110      ******************************************************
148000231110      *
148100231110     C     EMDEFN        BEGSR
148200231110      *
148300231110     C                   CLEAR                   P#DEFN
148400231110     C                   MOVEL(P)  XMSGI         P#DEFN
148500231110     C                   CAT       '_MSG':0      P#DEFN
148600231110      *
148700231110     C                   ENDSR
148800231110      *
148900231110      ******************************************************
149000231110      * Programm Vorlauf
149100231110      ******************************************************
149200231110      *
149300231110     C     FIRST         BEGSR
149400231110      *
149500231110      * Datei öffnen
149600231110     C                   OPEN      SRC
149700231110      *
149800231110      * Rückgabeparameter initialisieren
149900231110     C                   MOVEL     *BLANK        XMBRT                          Msgtext
150000231110     C                   MOVEL     *BLANK        XERRID                         Error-ID
150100231110     C                   MOVEL     *BLANK        XERRDT                         Error-Data
150200231110      *
150300231110      * Initialisierung
150400231110      *
150500231110      * Stelle in RTVM0300 ab der variabler Teil beginnt
150600231110     C                   Z-ADD     105           R#OFF3                         Offset in DS
150700231110      *
150800231110      * laufender Zähler für Offsets
150900231110     C                   Z-ADD     *ZERO         O
151000231110      *
151100231110      * laufender Zähler Variablenverarbeitung
151200231110     C                   Z-ADD     *ZERO         A
151300231110      *
151400231110      * Empfangsvariablen für variablen Teil initialisieren
151500231110     C                   MOVEL(P)  *BLANK        D#DRPL
151600231110     C                   MOVEL(P)  *BLANK        D#MSGT
151700231110     C                   MOVEL(P)  *BLANK        D#MSGH
151800231110     C                   MOVEL(P)  *BLANK        D#SUBV
151900231110      * Anzahl der Variablen in der MSG
152000231110     C                   Z-ADD     *ZERO         P#MANZ
152100231110      * MSGID in Zerlegungsstruktur bringen
152200231110     C                   MOVEL(P)  XMSGI         D#MSID
152300231110      * Länge der Msg-Variablen
152400231110     C                   Z-ADD     *ZERO         P#FLDL
152500231110     C                   Z-ADD     *ZERO         P#FLDP
152600231110      * Rest bei Division
152700231110     C                   Z-ADD     *ZERO         P#REST
152800231110      * Sourcezeilenstruktur RPG erstmals initialisierem
152900231110 B01 C     XFIRST        IFEQ      cTRUE
153000231110     C                   CLEAR                   FSRC
153100231110     C                   Z-ADD     *ZERO         SRCSEQ
153200231110 E01 C                   ENDIF
153300231110      *
153400231110     C                   ENDSR
153500231110      *
153600231110      ******************************************************
153700231110      * Programm Initialisierung einmalig
153800231110      ******************************************************
153900231110      *
154000231110     C     *INZSR        BEGSR
154100231110      *
154200231110      * Definition Programmaufrufparameter
154300231110      * Input
154400231110     C                   MOVEL     XMSGL         XMSGL            10            Msg-Lib
154500231110     C                   MOVEL     XMSGF         XMSGF            10            Msg-File
154600231110     C                   MOVEL     R#MSGF        R#MSGF           10            Msg-Lib
154700231110     C                   MOVEL     R#MSGL        R#MSGL           10            Msg-File
154800231110     C                   MOVEL     XMSGI         XMSGI             7            Msg-ID
154900231110     C                   MOVEL     XCPYL         XCPYL            10            Cpy-Lib
155000231110     C                   MOVEL     XCPYF         XCPYF            10            Cpy-File
155100231110     C                   MOVEL     XGENA         XGENA            10            Gener.Art
155200231110     C                   MOVEL     XISDFN        XISDFN            1            Define-Best.
155300231110     C                   MOVEL     XFIRST        XFIRST            1            1. Msg-ID
155400231110     C                   MOVEL     XLAST         XLAST             1            letzte Msg-ID
155500231110      * Output
155600231110     C                   MOVEL     XMBRT         XMBRT            80            MbrText
155700231110     C                   MOVEL     XERRID        XERRID            7            Error-ID
155800231110     C                   MOVEL     XERRDT        XERRDT           80            Error-Data
155900231110      *
156000231110      * Stelle in RTVM0300 ab der variabler Teil beginnt
156100231110     C                   Z-ADD     R#OFF3        R#OFF3            4 0          Offset in DS
156200231110      *
156300231110      * laufender Zähler für Offsets
156400231110     C                   Z-ADD     O             O                 4 0
156500231110     C                   Z-ADD     OF            OF                3 0
156600231110      *
156700231110      * laufender Zähler für Positionen in generierter Datenstruktur
156800231110     C                   Z-ADD     OD            OD                3 0
156900231110      *
157000231110      * laufender Zähler Variablenverarbeitung
157100231110     C                   Z-ADD     A             A                 4 0
157200231110      *
157300231110      * Anzahl der Variablen in der MSG
157400231110     C                   Z-ADD     P#MANZ        P#MANZ            2 0
157500231110      *
157600231110      * Länge der Msg-Variablen
157700231110     C                   Z-ADD     P#FLDL        P#FLDL            3 0
157800231110     C                   Z-ADD     P#FLDP        P#FLDP            3 0
157900231110      *
158000231110      * Rest bei Division
158100231110     C                   Z-ADD     P#REST        P#REST            3 0
158200231110      *
158300231110      * Namen für Define
158400231110     C                   MOVEL     P#DEFN        P#DEFN           20
158500231110      *
158600231110     C                   ENDSR
158700231110      *
158800231110      ******************************************************
158900231110      * Fehlerbehandlung
159000231110      ******************************************************
159100231110      *
159200231110     C     *PSSR         BEGSR
159300231110      *
159400231110     C                   DUMP
159500231110      *
159600231110     C                   ENDSR     '*CANCL'
159700231110      *****************************************************************
159800231110      *  Replace variables
159900231110      *****************************************************************
160000231110     P f_replace...
160100231110     P                 B
160200231110      *
160300231110     D f_replace...
160400231110     D                 PI           256A
160500231110     D  i_string                    256A   value
160600231110     D  i_var                        20A   value
160700231110     D  i_value                     256A   value
160800231110      *
160900231110     D x               S             10I 0 inz
161000231110     D y               S             10I 0 inz
161100231110     D z               S             10I 0 inz
161200231110      *---------------------------------------------------------------
161300231110      *
161400231110     C                   EVAL      x = 0
161500231110      *
161600231110 B01 C                   DOU       x <= 0
161700231110      *
161800231110 B02 C                   IF        x > 0
161900231110     C                   EVAL      y = x + %len(%trimr(i_var))
162000231110     C     '>'           CHECK     i_string:y    y
162100231110 B03 C                   IF        y > 0
162200231110     C                   EVAL      z = y - x
162300231110 X03 C                   ELSE
162400231110     C                   EVAL      z = %len(%trimr(i_var))
162500231110 E03 C                   Endif
162600231110     C                   EVAL      i_string = %replace(%subst(i_value: 1: z):
162700231110     C                                                  i_string            :
162800231110     C                                                  x                   :
162900231110     C                                                  z                   )
163000231110 E02 C                   Endif
163100231110      *
163200231110     C                   EVAL      x = %scan(%trimr(i_var):
163300231110     C                                       i_string     )
163400231110 E01 C                   Enddo
163500231110      *
163600231110     C                   RETURN    i_string
163700231110      *
163800231110     P f_replace...
163900231110     P                 E
164000231110      *****************************************************************
164100231110      *  set to lower
164200231110      *****************************************************************
164300231110     P f_lcase...
164400231110     P                 B
164500231110      *
164600231110     D f_lcase...
164700231110     D                 PI           256A
164800231110     D  i_string                    256A   value
164900231110      *
165000231110     D uc              C                   const('ABCDEFGHIJKLMNOPQRSTUVWXYZ')
165100231110     D lc              C                   const('abcdefghijklmnopqrstuvwxyz')
165200231110      *---------------------------------------------------------------
165300231110      *
165400231110     C     uc:lc         XLATE     i_string      i_string
165500231110      *
165600231110     C                   RETURN    i_string
165700231110      *
165800231110     P f_lcase...
165900231110     P                 E
166000231110      *****************************************************************
166100231110      *  convert to char
166200231110      *****************************************************************
166300231110     P f_str...
166400231110     P                 B
166500231110      *
166600231110     D f_str...
166700231110     D                 PI           256A
166800231110     D  i_value                      30P 0 value
166900231110      *
167000231110      *---------------------------------------------------------------
167100231110      *
167200231110     C                   RETURN    %triml(%editc(i_value: 'Z'))
167300231110      *
167400231110     P f_str...
167500231110     P                 E
167600231110      *****************************************************************
167700231110      *  c structure name
167800231110      *****************************************************************
167900231110     P f_structName...
168000231110     P                 B
168100231110      *
168200231110     D f_structName...
168300231110     D                 PI            20A
168400231110      *
168500231110      *---------------------------------------------------------------
168600231110     C                   RETURN    %trim(f_lcase(D#MSID)) + '_t'
168700231110      *
168800231110     P f_structName...
168900231110     P                 E
169000231110      *
169100231110**
1692002311101
1693002311102
1694002311103
1695002311104
1696002311105
1697002311106
1698002311107
1699002311108
1700002311109
170100231110A
170200231110B
170300231110C
170400231110D
170500231110E
170600231110F
170700231110G
170800231110H
170900231110I
171000231110J
171100231110K
171200231110L
171300231110M
171400231110N
171500231110O
171600231110P
171700231110Q
171800231110R
171900231110S
172000231110T
172100231110U
172200231110V
172300231110W
172400231110X
172500231110Y
172600231110Z
172700231110**  RPG
172800231110      *---------------------------------------------------------------
172900231110      * Datenstruktur für Message-ID :
173000231110      *
173100231110      *
173200231110      *
173300231110      *
173400231110      *
173500231110      *
173600231110      *
173700231110      *
173800231110     I            DS
173900231110     I I
174000231110     I I                                  B   1   40
174100231110      *   Keine Ersatzvariablen definiert!
174200231110**  IRPG
174300231110      *---------------------------------------------------------------
174400231110      * Datenstruktur für Message-ID :
174500231110      *
174600231110      *
174700231110      *
174800231110      *
174900231110      *
175000231110      *
175100231110      *
175200231110      *
175300231110     D                 DS
175400231110     D                                     INZ(       )
175500231110     D                 S             10I 0 INZ(    )
175600231110      *   Keine Ersatzvariablen definiert!
175700231110 DEF  /IF NOT DEFINED(
175800231110 DEF  /DEFINE
175900231110 DEF  /ENDIF
176000231110 DEF  /IF NOT DEFINED(UNDEFINE_ALL)
176100231110 DEF  /IF DEFINED(UNDEFINE_ALL)
176200231110 DEF  /UNDEFINE
176300231110**  CLP
176400231110     /*-------------------------------------------------------------*/
176500231110     /*   Cmd-ADDMSGD für Message-ID :                              */
176600231110     /*                                                             */
176700231110     /*-------------------------------------------------------------*/
176800231110             PGM        PARM(&I_LIB)
176900231110
177000231110             RMVMSGD MSGID(1234567) MSGF(
177100231110             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
177200231110 wird nicht abgefangen     CPF2407)     /* MsgF  nicht gefunden */
177300231110
177400231110             ADDMSGD
177500231110             RCLRSC LVL(*)
177600231110             ENDPGM
177700231110     /*   Keine Ersatzvariablen definiert!                          */ +
177800231110             DCL        VAR(&I_LIB     ) TYPE(*CHAR) LEN(10)
177900231110             DCL        VAR(&LIB       ) TYPE(*CHAR) LEN(10)
178000231110             CHGVAR     VAR(&LIB       ) VALUE(&I_LIB)
178100231110             MONMSG     MSGID(MCH3601) EXEC(DO)
178200231110               RMVMSG     PGMQ(*SAME (*)) CLEAR(*ALL)
178300231110               CHGVAR     VAR(&LIB) VALUE('%LIB>>>>>>')
178400231110             ENDDO
178500231110**  C
178600231110  /* --------------------------------------------------------------------- */
178700231110  /*   Datenstruktur für Message-ID : %%MSGID                              */
178800231110  /*   %%MSGTXT>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>   */
178900231110  /* --------------------------------------------------------------------- */
179000231110  typedef _Packed struct {
179100231110    %%VARTYPE>>>>>>>>>>  %%VARNAME%%DELIMITER
179200231110  } %%STRUCTNAME
179300231110#ifndef    %%STRUCTNAME
179400231110  #define  %%STRUCTNAME
179500231110#endif
