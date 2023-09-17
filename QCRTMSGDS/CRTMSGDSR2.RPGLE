      * =================================================================== *                 RADDAT
      *                                                                     *                 RADDAT
      *  Kurzdokumentation :                                                *                 RADDAT
      *                                                                     *                 RADDAT
      *  Bereich . . . : CRTMSGDS                                           *                 RADDAT
      *  Objekt  . . . : CRTMSGDSR2                                         *                 RADDAT
      *  Beschreibung  : Tool: CRTMSGDS   (Create Message DS  )             *                 RADDAT
      *  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      *                 RADDAT
      *  Datum . . . . : ?                                                  *                 RADDAT
      *                                                                     *                 RADDAT
      *=====================================================================*                 RADDAT
      *                                                                     *                 RADDAT
      *  This software is free software, you can redistribute it and/or     *                 RADDAT
      *  modify it under the terms of the GNU General Public License (GPL)  *                 RADDAT
      *  as published by the Free Software Foundation.                      *                 RADDAT
      *                                                                     *                 RADDAT
      *  See GNU General Public License for details.                        *                 RADDAT
      *          http://www.opensource.org                                  *                 RADDAT
      *          http://www.opensource.org/licenses/gpl-license.html        *                 RADDAT
      *                                                                     *                 RADDAT
      *=====================================================================*                 RADDAT
      *  History:                                                           *                 RADDAT
      *                                                                     *                 RADDAT
      *  Datum       Name          Änderung                                 *                 RADDAT
      *  ----------  ------------  ---------------------------------------  *                 RADDAT
      *  07.09.2001  Th.Raddatz    Fixed a bug when field length is *ZEROS. *                 RADDAT
      *  10.01.2003  Th.Raddatz    Removed special character § from source. *                 RADDAT
      *  08.03.2005  Th.Raddatz    Fixed problem that trailing blanks of    *                 RADDAT
      *                            message help text were dropped.          *                 RADDAT
      *  21.06.2005  Th.Raddatz    Renamed XMSGT to XMBRT to avoid          *                 RADDAT
      *                            confusion.                               *                 RADDAT
      *                            Increment cL within RPLHPN to fix bug    *                 RADDAT
      *                            that message text was truncated.         *                 RADDAT
      *  18.04.2008  Th.Raddatz    Datenstruktur MS0300 von 1024 auf 8192   *                 RADDAT
      *                            Byte vergrößert.                         *                 RADDAT
      *  26.01.2009  Th.Raddatz    Code des generierten CLP Programms       *                 RADDAT
      *                            geändert. Bibliothek kann jetzt als      *                 RADDAT
      *                            optionaler Parameter übergeben werden.   *                 RADDAT
      *                            Befehlsparameter TYPE um Auswahl         *                 RADDAT
      *                            *CLLE erweitert.                         *                 RADDAT
      *  06.10.2009  Th.Raddatz    Replaced special character '#' by        *                 RADDAT
      *                            '_SIZE' when generating RPGLE copy       *                 RADDAT
      *                            books.                                   *                 RADDAT
      *                                                                     *                 RADDAT
      * =================================================================== *                 RADDAT
      * >>PRE-COMPILER<<                                                    *                 RADDAT
      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *                 RADDAT
      *                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *                 RADDAT
      *   >>COMPILE<<                                                       *                 RADDAT
      *     >>PARM<< TRUNCNBR(*NO);                                         *                 RADDAT
      *     >>PARM<< DBGVIEW(*LIST);                                        *                 RADDAT
      *     >>PARM<< TGTRLS(V7R1M0);                                        *                 RADDAT
      *   >>END-COMPILE<<                                                   *                 RADDAT
      *   >>EXECUTE<<                                                       *                 RADDAT
      * >>END-PRE-COMPILER<<                                                *                 RADDAT
      * =================================================================== *                 RADDAT
      *                                                                     *                 RADDAT
      *  Attention: If you have applied one of the PTFs listed              *                 RADDAT
      *             below or if you are running V4R3 or above               *                 RADDAT
      *             you should set constant OFS to 1.                       *                 RADDAT
      *             Otherwise you should set OFS to 0.                      *                 RADDAT
      *                                                                     *                 RADDAT
      *             V3R1M0 - SF51811                                        *                 RADDAT
      *             V3R2M0 - SF51812                                        *                 RADDAT
      *             V3R6M0 - SF51813                                        *                 RADDAT
      *             V3R7M0 - SF51814                                        *                 RADDAT
      *             V4R1M0 - SF51815                                        *                 RADDAT
      *             V4R2M0 - SF51817                                        *                 RADDAT
      *                                                                     *                 RADDAT
      * =================================================================== *                 RADDAT
 CPY  /COPY QCRTMSGDS,H_SPEC                                                                  RADDAT
      * =================================================================== *                 RADDAT
      *                                                                                       RADDAT
     FSRC       O    F  256        DISK    USROPN                                             RADDAT
      *                                                                                       RADDAT
     D TXT             S              1    DIM(80)                              eine Zeile    RADDAT
     D ORD             S              1    DIM(35) CTDATA PERRCD(1)             Num.f.Feldn.  RADDAT
     D RPG             S             80    DIM(14) CTDATA PERRCD(1)             Sourcezeilen  RADDAT
     D IRPG            S             80    DIM(20) CTDATA PERRCD(1)             Sourcezeilen  RADDAT
     D CLP             S             80    DIM(21) CTDATA PERRCD(1)             Sourcezeilen  RADDAT
     D C               S             80    DIM(10) CTDATA PERRCD(1)             Sourcezeilen  RADDAT
     D fldName         S             40    inz                                                RADDAT
     D fldType         S             40    inz                                                RADDAT
      *                                                                                       RADDAT
      *------------------------------------------------------------*                          RADDAT
      *  Datensatzbeschreibung für Sourcen                                                    RADDAT
      *------------------------------------------------------------*                          RADDAT
      *                                                                                       RADDAT
     D FSRC            DS                                                                     RADDAT
     D  SRCSEQ                 1      6  2                                                    RADDAT
     D  SRCSQ1                 1      4                                                       RADDAT
     D  SRCSQ2                 5      6                                                       RADDAT
     D  SRCDAT                 7     12  0                                                    RADDAT
     D  SRCDTA                13    256                                                       RADDAT
      *                                                                                       RADDAT
      *------------------------------------------------------------*                          RADDAT
      *  interne Prototypen                                                                   RADDAT
      *------------------------------------------------------------*                          RADDAT
     D f_replace...                                                                           RADDAT
     D                 PR           256A                                                      RADDAT
     D  i_string                    256A   value                                              RADDAT
     D  i_var                        20A   value                                              RADDAT
     D  i_value                     256A   value                                              RADDAT
      *                                                                                       RADDAT
     D f_lcase...                                                                             RADDAT
     D                 PR           256A                                                      RADDAT
     D  i_string                    256A   value                                              RADDAT
      *                                                                                       RADDAT
     D f_str...                                                                               RADDAT
     D                 PR           256A                                                      RADDAT
     D  i_value                      30P 0 value                                              RADDAT
      *                                                                                       RADDAT
     D f_structName...                                                                        RADDAT
     D                 PR            20A                                                      RADDAT
      *                                                                                       RADDAT
      *------------------------------------------------------------*                          RADDAT
      *  allg. Feldbeschreibungen für API                                                     RADDAT
      *------------------------------------------------------------*                          RADDAT
      *                                                                                       RADDAT
     D                 DS                                                                     RADDAT
     D  P#VLEN                 1      4I 0                                                    RADDAT
     D  P#FORM                 5     14                                                       RADDAT
     D  P#DTAL                15     18I 0                                                    RADDAT
     D                 DS                                                                     RADDAT
     D  P#MSFL                 1     10                                                       RADDAT
     D  P#MSLI                11     20                                                       RADDAT
     D  P#MSGF                 1     20                                                       RADDAT
      *                                                                                       RADDAT
      *------------------------------------------------------------*                          RADDAT
      *  Definition des Satzformates RTVM0300                                                 RADDAT
      *------------------------------------------------------------*                          RADDAT
     D MS0300          DS                                                                     RADDAT
     D  M3TRTN                 1      4I 0                                                    RADDAT
     D  M3TVAL                 5      8I 0                                                    RADDAT
      *                                                                                       RADDAT
     D  M3MSSV                 9     12I 0                                                    RADDAT
     D  M3ALID                13     16I 0                                                    RADDAT
     D  M3ALOP                17     25                                                       RADDAT
     D  M3LGIN                26     26                                                       RADDAT
     D  M3MGID                27     33                                                       RADDAT
     D  M3RES1                34     36                                                       RADDAT
      *                                                                                       RADDAT
     D  M3NSVF                37     40I 0                                                    RADDAT
     D  M3CSIT                41     44I 0                                                    RADDAT
      *                                                                                       RADDAT
     D  M3CSIR                45     48I 0                                                    RADDAT
     D  M3CCIT                49     52I 0                                                    RADDAT
      *                                                                                       RADDAT
     D  M3OFDR                53     56I 0                                                    RADDAT
     D  M3LGDR                57     60I 0                                                    RADDAT
     D  M3LDRA                61     64I 0                                                    RADDAT
      *                                                                                       RADDAT
     D  M3OFMG                65     68I 0                                                    RADDAT
     D  M3LGMR                69     72I 0                                                    RADDAT
     D  M3LMRA                73     76I 0                                                    RADDAT
      *                                                                                       RADDAT
     D  M3OFMH                77     80I 0                                                    RADDAT
     D  M3LGMH                81     84I 0                                                    RADDAT
     D  M3LMHA                85     88I 0                                                    RADDAT
      *                                                                                       RADDAT
     D  M3OFVF                89     92I 0                                                    RADDAT
     D  M3LGVF                93     96I 0                                                    RADDAT
     D  M3LVFA                97    100I 0                                                    RADDAT
     D  M3LVFE               101    104I 0                                                    RADDAT
      *                                                                                       RADDAT
     D  M3RES2               105    256                                                       RADDAT
     D  M3DATA               257   8192                                                       RADDAT
      *                                                                                       RADDAT
      *-----------------------------------------------------                                  RADDAT
      * Format der Ersetzungsvariablen in der Message                                         RADDAT
      *-----------------------------------------------------                                  RADDAT
      *                                                                                       RADDAT
     D MS030F          DS                                                                     RADDAT
     D  M3FLGD                 1      4I 0                                                    RADDAT
     D  M3FFSZ                 5      8I 0                                                    RADDAT
     D  M3FTYP                 9     18                                                       RADDAT
     D  M3FRS1                19    256                                                       RADDAT
     D  M3FRS2               257    512                                                       RADDAT
      *                                                                                       RADDAT
      *-----------------------------------------------------                                  RADDAT
      * Format der ERROR-Struktur bei API'S                                                   RADDAT
      *-----------------------------------------------------                                  RADDAT
     D ERRCOD          DS                                                                     RADDAT
     D  ERRPRV                 1      4I 0 INZ                                                RADDAT
     D  ERRAVL                 5      8I 0 INZ                                                RADDAT
     D  ERRID                  9     15    INZ                                                RADDAT
     D  ERRRSV                16     16    INZ                                                RADDAT
     D  ERRDTA                17     32    INZ                                                RADDAT
      *                                                                                       RADDAT
      * Zerlegung der MSG-ID                                                                  RADDAT
     D D#MSID          DS                                                                     RADDAT
     D  D#MFCH                 1      1    INZ                                                RADDAT
     D  D#MPRF                 1      3    INZ                                                RADDAT
     D  D#MNBR                 4      7    INZ                                                RADDAT
      *                                                                                       RADDAT
      * Dezimalposition                                                                       RADDAT
     D                 DS                                                                     RADDAT
     D  D#DPS                  1      1  0 INZ                                                RADDAT
     D  D#DEC                  1      1    INZ                                                RADDAT
      *                                                                                       RADDAT
      * VON-BIS Positionen                                                                    RADDAT
     D                 DS                                                                     RADDAT
     D  D#OD                   1      3  0 INZ                                                RADDAT
     D  D#POS                  1      3    INZ                                                RADDAT
      *                                                                                       RADDAT
      * Unterteilung des 6 stelligen RPG Feldnamens                                           RADDAT
     D D#FLD           DS                                                                     RADDAT
     D  D#PRF                  1      1    INZ                                                RADDAT
     D  D#NBR                  2      5    INZ                                                RADDAT
     D  D#ORD                  6      8    INZ                                                RADDAT
      * Unterteilung des 10 stelligen ILE-RPG Feldnamens                                      RADDAT
     D D#IFLD          DS                                                                     RADDAT
     D  D#IPRF                 1      3    INZ                                                RADDAT
     D  D#INBR                 4      7    INZ                                                RADDAT
     D  D#IORD                 8      8    INZ                                                RADDAT
     D  D#EXT                  8     12    INZ                                                RADDAT
      * Länge der Datenstruktur binär                                                         RADDAT
     D                 DS                                                                     RADDAT
     D  D#DSLX                 1      4    INZ                                                RADDAT
     D  D#DSLG                 1      4  0 INZ                                                RADDAT
      *                                7                                                      RADDAT
     D D#DRPL          DS          8192                                                       RADDAT
     D D#MSGT          DS          8192                                                       RADDAT
     D  D#MSG                  1     59                                                       RADDAT
     D D#MSGH          DS          8192                                                       RADDAT
     D D#SUBV          DS          8192                                                       RADDAT
      *                                                                                       RADDAT
      *  Arbeitsfeld                                                                          RADDAT
     D #TEMP           DS          8192                                                       RADDAT
     D #TEXT           DS                                                                     RADDAT
     D  #TB                    1   8192    INZ                                                RADDAT
     D                                     DIM(8192)                                          RADDAT
     D                 DS                                                                     RADDAT
     D  #Y                     1      3P 0 INZ                                                RADDAT
     D                 DS                                                                     RADDAT
     D  #N2                    1      2  0 INZ                                                RADDAT
     D  #A2                    1      2    INZ                                                RADDAT
     D                 DS                                                                     RADDAT
     D  #N5                    1      5  0 INZ                                                RADDAT
     D  #A5                    1      5    INZ                                                RADDAT
      *                                                                                       RADDAT
      *  Boolsche Konstanten                                                                  RADDAT
     D cFALSE          C                   CONST('0')                                         RADDAT
     D cTRUE           C                   CONST('1')                                         RADDAT
      *                                                                                       RADDAT
      *  Konstanten                                                                           RADDAT
     D cC_DELIM        C                   CONST(';')                                         RADDAT
     D cMSGID          C                   CONST('%%MSGID')                                   RADDAT
     D cMSGTXT         C                   CONST('%%MSGTXT')                                  RADDAT
     D cVARTYPE        C                   CONST('%%VARTYPE')                                 RADDAT
     D cVARNAME        C                   CONST('%%VARNAME')                                 RADDAT
     D cDELIMITER      C                   CONST('%%DELIMITER')                               RADDAT
     D cSTRUCTNAME     C                   CONST('%%STRUCTNAME')                              RADDAT
      *                                                                                       RADDAT
      *  Systemdatenstruktur                                                                  RADDAT
     D sds            SDS                                                                     RADDAT
     D  sds_msgID             40     46                                                       RADDAT
     D  sds_msgDta            91    170                                                       RADDAT
      *                                                                                       RADDAT
      *  Offset for SUBST                                                                     RADDAT
      *  ... PTF applied or version V4R3 and above                                            RADDAT
     D OFS             C                   CONST(1)                                           RADDAT
      *  ... PTF not applied                                                                  RADDAT
      ***           0                     C         OFS                                       RADDAT
      *                                                                                       RADDAT
      *-----------------------------------------------------                                  RADDAT
      *                                                                                       RADDAT
     C     *ENTRY        PLIST                                                                RADDAT
      * Input                                                                                 RADDAT
     C                   PARM                    XMSGL                          Msg-Lib       RADDAT
     C                   PARM                    XMSGF                          Msg-File      RADDAT
     C                   PARM                    XMSGI                          Msg-ID        RADDAT
     C                   PARM                    XCPYL                          Cpy-Lib       RADDAT
     C                   PARM                    XCPYF                          Cpy-File      RADDAT
     C                   PARM                    XGENA                          Gener.Art     RADDAT
     C                   PARM                    XISDFN                         Define-Best.  RADDAT
     C                   PARM                    XFIRST                         1. Msg-ID     RADDAT
     C                   PARM                    XLAST                          Letzte Msg-ID RADDAT
      * Output                                                                                RADDAT
     C                   PARM                    XMBRT                          MbrText       RADDAT
     C                   PARM                    XERRID                         Error-ID      RADDAT
     C                   PARM                    XERRDT                         Error-Data    RADDAT
      *                                                                                       RADDAT
      *-----------------------------------------------------                                  RADDAT
      * Programm Vorlauf                                                                      RADDAT
      *-----------------------------------------------------                                  RADDAT
     C                   EXSR      FIRST                                                      RADDAT
      *                                                                                       RADDAT
      *-----------------------------------------------------                                  RADDAT
      * Aufruf API vorbereiten                                                                RADDAT
      *-----------------------------------------------------                                  RADDAT
     C                   Z-ADD     8192          P#VLEN                                       RADDAT
     C                   MOVEL(P)  'RTVM0300'    P#FORM                                       RADDAT
     C                   MOVEL(P)  XMSGI         P#MSGI            7                          RADDAT
     C                   MOVEL(P)  XMSGL         P#MSLI                         Msg File      RADDAT
     C                   MOVEL(P)  XMSGF         P#MSFL                         Msg File      RADDAT
     C                   MOVEL(P)  *BLANKS       P#MSGD           80            Msg Dta       RADDAT
     C     ' '           CHECKR    P#MSGD        P#DTAL                         Msg Dta Len   RADDAT
      * Replace Substitution variables                                                        RADDAT
     C                   MOVEL(P)  '*NO'         P#MSRS           10            Msg Repl Sub  RADDAT
      * Return format control characters                                                      RADDAT
 B01 C                   IF        (XGENA = '*CLP'   )  or                                    RADDAT
     C                             (XGENA = '*CLLE'  )  or                                    RADDAT
     C                             (XGENA = '*SCRIPT')                                        RADDAT
     C                   MOVEL(P)  '*YES'        P#MSFC           10            Ret Form Cha  RADDAT
 X01 C                   ELSE                                                                 RADDAT
     C                   MOVEL(P)  '*NO'         P#MSFC           10            Ret Form Cha  RADDAT
 E01 C                   ENDIF                                                                RADDAT
     C                   CLEAR                   ERRCOD                                       RADDAT
      *                                                                                       RADDAT
     C                   CALL      'QMHRTVM'                            99                    RADDAT
     C                   PARM                    MS0300                                       RADDAT
     C                   PARM                    P#VLEN                                       RADDAT
     C                   PARM                    P#FORM                                       RADDAT
     C                   PARM                    P#MSGI                         Msg ID        RADDAT
     C                   PARM                    P#MSGF                         Msg File      RADDAT
     C                   PARM                    P#MSGD                         Msg Dta       RADDAT
     C                   PARM                    P#DTAL                         Msg Dta Len   RADDAT
     C                   PARM                    P#MSRS                         Msg Repl Sub  RADDAT
     C                   PARM                    P#MSFC                         Ret Form Cha  RADDAT
     C                   PARM                    ERRCOD                                       RADDAT
      *                                                                                       RADDAT
      * prüfen, Aufruf OK                                                                     RADDAT
 B01 C     *IN99         IFEQ      *ON                                                        RADDAT
     C                   MOVEL(P)  'CPF9897'     XERRID                                       RADDAT
     C                   MOVEL(P)  'Aufruf '     XERRDT                                       RADDAT
     C                   CAT       'fehler':1    XERRDT                                       RADDAT
     C                   CAT       'haft:':0     XERRDT                                       RADDAT
     C                   CAT       P#MSGF:1      XERRDT                                       RADDAT
     C                   CAT       'MSGID:':1    XERRDT                                       RADDAT
     C                   CAT       P#MSGI:1      XERRDT                                       RADDAT
     C                   GOTO      ENDE                                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      *                                                                                       RADDAT
 B01 C     ERRAVL        IFGT      *ZERO                                                      RADDAT
     C                   MOVEL(P)  ERRID         XERRID                                       RADDAT
     C                   MOVEL(P)  ERRDTA        XERRDT                                       RADDAT
     C                   GOTO      ENDE                                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      * Default Reply rauslösen                                                               RADDAT
 B01 C     M3LGDR        IFGT      *ZERO                                                      RADDAT
     C     OFS           ADD       M3OFDR        O                                            RADDAT
     C     M3LGDR        SUBST     MS0300:O      D#DRPL                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      * Messagetext rauslösen                                                                 RADDAT
 B01 C     M3LGMR        IFGT      *ZERO                                                      RADDAT
     C     OFS           ADD       M3OFMG        O                                            RADDAT
     C     M3LGMR        SUBST     MS0300:O      D#MSGT                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
     C                   MOVEL(P)  D#MSGT        XMBRT                                        RADDAT
      *                                                                                       RADDAT
      * Messagehelp rauslösen                                                                 RADDAT
 B01 C     M3LGMH        IFGT      *ZERO                                                      RADDAT
     C     OFS           ADD       M3OFMH        O                                            RADDAT
     C     M3LGMH        SUBST     MS0300:O      D#MSGH                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      * Ersetzungsvariable rauslösen                                                          RADDAT
 B01 C     M3LGVF        IFGT      *ZERO                                                      RADDAT
     C     OFS           ADD       M3OFVF        O                                            RADDAT
     C     M3LGVF        SUBST     MS0300:O      D#SUBV                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      * Source generieren                                                                     RADDAT
     C                   EXSR      VGEN                                                       RADDAT
      *                                                                                       RADDAT
     C     ENDE          TAG                                                                  RADDAT
      *                                                                                       RADDAT
      * Datei schließen                                                                       RADDAT
     C                   CLOSE     SRC                                                        RADDAT
      *                                                                                       RADDAT
     C                   RETURN                                                               RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * VGEN  Auswahl welcher Sourcecode generiert wird                                       RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     VGEN          BEGSR                                                                RADDAT
      *                                                                                       RADDAT
 B01 C                   SELECT                                                               RADDAT
      *                                                                                       RADDAT
     C     XGENA         WHENEQ    '*RPG'                                                     RADDAT
     C                   EXSR      VRPG                                                       RADDAT
      *                                                                                       RADDAT
     C     XGENA         WHENEQ    '*ILERPG'                                                  RADDAT
     C                   EXSR      VRPG4                                                      RADDAT
      *                                                                                       RADDAT
     C     XGENA         WHENEQ    '*CLP'                                                     RADDAT
     C     XGENA         OREQ      '*CLLE'                                                    RADDAT
     C                   MOVEL(P)  XMSGL         R#MSGL                         Msg-Lib       RADDAT
     C                   MOVEL(P)  '&LIB'        XMSGL                          Msg-Lib       RADDAT
     C                   EXSR      VCLP                                                       RADDAT
     C                   MOVEL(P)  R#MSGL        XMSGL                          Msg-Lib       RADDAT
      *                                                                                       RADDAT
     C     XGENA         WHENEQ    '*C'                                                       RADDAT
     C                   EXSR      VC                                                         RADDAT
      *                                                                                       RADDAT
      * *SCRIPT wie *CLP verarbeiten, nur einzelne Zeilen rauslassen                          RADDAT
     C     XGENA         WHENEQ    '*SCRIPT'                                                  RADDAT
      * Ersatzvariablen für RUNCLSTM setzen                                                   RADDAT
     C                   MOVEL(P)  XMSGL         R#MSGL                         Msg-Lib       RADDAT
     C                   MOVEL(P)  XMSGF         R#MSGF                         Msg-File      RADDAT
     C                   MOVEL(P)  '&LI'         XMSGL                          Msg-Lib       RADDAT
     C                   MOVEL(P)  '&SF'         XMSGF                          Msg-File      RADDAT
     C                   EXSR      VCLP                                                       RADDAT
     C                   MOVEL(P)  R#MSGL        XMSGL                          Msg-Lib       RADDAT
     C                   MOVEL(P)  R#MSGF        XMSGF                          Msg-File      RADDAT
      *                                                                                       RADDAT
 X01 C                   OTHER                                                                RADDAT
      *****                nichts tun                                                         RADDAT
      *                                                                                       RADDAT
 E01 C                   ENDSL                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * VRPG  generieren RPG-Source                                                           RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     VRPG          BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * Kommentarzeile durchgehend                                                            RADDAT
     C                   MOVEL(P)  RPG(1)        SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile mit Beschreibung                                                       RADDAT
     C                   MOVEL(P)  RPG(2)        SRCDTA                                       RADDAT
     C                   CAT       XMSGI:1       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile nur Stern                                                              RADDAT
     C                   MOVEL(P)  RPG(3)        SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile mit Nachrichtentext                                                    RADDAT
     C                   MOVEA(P)  RPG(3)        TXT                                          RADDAT
     C                   MOVEA     D#MSG         TXT(9)                                       RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile nur Stern                                                              RADDAT
     C                   MOVEL(P)  RPG(3)        SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * Zeile für Datenstrukturfelder erstellen                                               RADDAT
     C                   EXSR      RPGFLD                                                     RADDAT
      * Zeile mit Gesamtlänge der Datenstruktur                                               RADDAT
     C                   EXSR      RPGLNG                                                     RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * VRPG4    generieren Source für ILE-RPG                                                RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     VRPG4         BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * DEFINE-Rahmen 1                                                                       RADDAT
     C                   EXSR      DEFN1RPG4                                                  RADDAT
      *                                                                                       RADDAT
      * Kommentarzeile durchgehend                                                            RADDAT
     C                   MOVEL(P)  IRPG(1)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile mit Beschreibung                                                       RADDAT
     C                   MOVEL(P)  IRPG(2)       SRCDTA                                       RADDAT
     C                   CAT       XMSGI:1       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile nur Stern                                                              RADDAT
     C                   MOVEL(P)  IRPG(3)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile mit Nachrichtentext                                                    RADDAT
     C                   MOVEA(P)  IRPG(3)       TXT                                          RADDAT
     C                   MOVEA     D#MSG         TXT(9)                                       RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile nur Stern                                                              RADDAT
     C                   MOVEL(P)  IRPG(3)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * Zeile für Datenstrukturfelder erstellen                                               RADDAT
     C                   EXSR      RPG4FLD                                                    RADDAT
      * Zeile mit Gesamtlänge der Datenstruktur                                               RADDAT
     C                   EXSR      IPGLNG                                                     RADDAT
      * Kommentarzeile nur Stern                                                              RADDAT
     C                   MOVEL(P)  IRPG(3)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * DEFINE-Rahmen 2                                                                       RADDAT
     C                   EXSR      DEFN2RPG4                                                  RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * DEFN1RPG4 - DEFINE-Rahmen 1                                                           RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     DEFN1RPG4     BEGSR                                                                RADDAT
      *                                                                                       RADDAT
 B01 C     XISDFN        IFEQ      cFALSE                                                     RADDAT
      * keine Ausgabe der DEFINE-Bestimmungen                                                 RADDAT
 X01 C                   ELSE                                                                 RADDAT
      *                                                                                       RADDAT
      * /IF NOT DEFINED(UNDEFINE_ALL)                                                         RADDAT
     C                   MOVEL(P)  IRPG(18)      SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * Ermitteln Namen für Define                                                            RADDAT
     C                   EXSR      EMDEFN                                                     RADDAT
      *                                                                                       RADDAT
      * /IF NOT DEFINED(msgid_MSG)                                                            RADDAT
     C                   MOVEL(P)  IRPG(15)      SRCDTA                                       RADDAT
     C                   CAT       P#DEFN:0      SRCDTA                                       RADDAT
     C                   CAT       ')':0         SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * /DEFINE msgid_MSG                                                                     RADDAT
     C                   MOVEL(P)  IRPG(16)      SRCDTA                                       RADDAT
     C                   CAT       P#DEFN:1      SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * DEFN2RPG4 - DEFINE-Rahmen 2                                                           RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     DEFN2RPG4     BEGSR                                                                RADDAT
      *                                                                                       RADDAT
 B01 C     XISDFN        IFEQ      cFALSE                                                     RADDAT
      * keine Ausgabe der DEFINE-Bestimmungen                                                 RADDAT
 X01 C                   ELSE                                                                 RADDAT
      *                                                                                       RADDAT
      * /ENDIF                                                                                RADDAT
     C                   MOVEL(P)  IRPG(17)      SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * /ENDIF                                                                                RADDAT
     C                   MOVEL(P)  IRPG(17)      SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile nur Stern                                                              RADDAT
     C                   MOVEL(P)  IRPG(3)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * /IF DEFINED(UNDEFINE_ALL)                                                             RADDAT
     C                   MOVEL(P)  IRPG(19)      SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * /UNDEFINE msgid_MSG                                                                   RADDAT
     C                   MOVEL(P)  IRPG(20)      SRCDTA                                       RADDAT
     C                   CAT       P#DEFN:1      SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * /ENDIF                                                                                RADDAT
     C                   MOVEL(P)  IRPG(17)      SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * VCLP     generieren Source für CLP-PROGRAMM                                           RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     VCLP          BEGSR                                                                RADDAT
      *                                                                                       RADDAT
 B01 C     XFIRST        IFEQ      cTRUE                                                      RADDAT
 B02 C     XGENA         IFNE      '*SCRIPT'                                                  RADDAT
      * PGM                                                                                   RADDAT
     C                   MOVEL(P)  CLP(5)        SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Leerzeile                                                                             RADDAT
     C                   MOVEL(P)  *BLANKS       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * DCL &I_LIB                                                                            RADDAT
     C                   MOVEL(P)  CLP(15)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * DCL &LIB                                                                              RADDAT
     C                   MOVEL(P)  CLP(16)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Leerzeile                                                                             RADDAT
     C                   MOVEL(P)  *BLANKS       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * CHGVAR                                                                                RADDAT
     C                   MOVEL(P)  CLP(17)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * MONMSG                                                                                RADDAT
     C                   MOVEL(P)  CLP(18)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * RMVMSG                                                                                RADDAT
     C                   MOVEL(P)  CLP(19)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * CHGVAR                                                                                RADDAT
     C                   EVAL      SRCDTA = f_replace(CLP(20): '%LIB': R#MSGL)                RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * ENDDO                                                                                 RADDAT
     C                   MOVEL(P)  CLP(21)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Leerzeile                                                                             RADDAT
     C                   MOVEL(P)  *BLANKS       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
 X02 C                   ELSE                                                                 RADDAT
      *  Keine Ausgabe bei *SCRIPT                                                            RADDAT
 E02 C                   ENDIF                                                                RADDAT
 X01 C                   ELSE                                                                 RADDAT
      *  Ausgabe nur bei 1. Nachrichten-ID                                                    RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      * Kommentarzeile durchgehend                                                            RADDAT
     C                   MOVEL(P)  CLP(1)        SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile mit Beschreibung                                                       RADDAT
     C                   MOVEA(P)  CLP(2)        TXT(1)                                       RADDAT
     C                   MOVEA     XMSGI         TXT(42)                                      RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile mit Nachrichtentext                                                    RADDAT
     C                   MOVEA(P)  CLP(3)        TXT                                          RADDAT
     C                   MOVEA     D#MSG         TXT(9)                                       RADDAT
     C                   MOVEA     '*/'          TXT(69)                                      RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile durchgehend                                                            RADDAT
     C                   MOVEL(P)  CLP(1)        SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Leerzeile                                                                             RADDAT
     C                   MOVEL(P)  *BLANKS       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * RMVMSGD                                                                               RADDAT
     C                   MOVEA(P)  CLP(7)        TXT                                          RADDAT
     C                   MOVEA     XMSGI         TXT(28)                                      RADDAT
     C                   MOVEA     XMSGL         TXT(42)                                      RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
     C                   CAT       '/':0         SRCDTA                                       RADDAT
     C                   CAT       XMSGF:0       SRCDTA                                       RADDAT
     C                   CAT       ')':0         SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * MONMSG (1)                                                                            RADDAT
     C                   MOVEL(P)  CLP(8)        SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * MONMSG (2)                                                                            RADDAT
      *******              MOVELCLP,9     SRCDTA    P                                         RADDAT
      *******              EXSR WRTRPG                                                        RADDAT
      * Leerzeile                                                                             RADDAT
     C                   MOVEL(P)  *BLANKS       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * ADDMSGD                                                                               RADDAT
     C                   MOVEL(P)  CLP(11)       SRCDTA                                       RADDAT
     C                   CAT       '+':1         SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * Zeile für Datenstrukturfelder erstellen                                               RADDAT
     C                   EXSR      ICLFLD                                                     RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * VC       generieren Source für C-Programme                                            RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     VC            BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * DEFINE-Rahmen 1                                                                       RADDAT
     C                   EXSR      DEFN1C                                                     RADDAT
      *                                                                                       RADDAT
      * Kommentarzeile durchgehend                                                            RADDAT
     C                   EVAL      SRCDTA = c(1)                                              RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile mit Beschreibung                                                       RADDAT
     C                   EVAL      SRCDTA = f_replace(c(2)         :                          RADDAT
     C                                                cMSGID       :                          RADDAT
     C                                                XMSGI        )                          RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile mit Nachrichtentext                                                    RADDAT
     C                   EVAL      SRCDTA = f_replace(c(3)         :                          RADDAT
     C                                                cMSGTXT      :                          RADDAT
     C                                                D#MSG        )                          RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Kommentarzeile durchgehend                                                            RADDAT
     C                   EVAL      SRCDTA = c(4)                                              RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      * Leerzeile                                                                             RADDAT
     C                   MOVEL(P)  *BLANKS       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * Zeile für Datenstrukturfelder erstellen                                               RADDAT
     C                   EXSR      ICFLD                                                      RADDAT
      *                                                                                       RADDAT
      * DEFINE-Rahmen 2                                                                       RADDAT
     C                   EXSR      DEFN2C                                                     RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * DEFN1C    - DEFINE-Rahmen 1                                                           RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     DEFN1C        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
 B01 C     XISDFN        IFEQ      cFALSE                                                     RADDAT
      * keine Ausgabe der DEFINE-Bestimmungen                                                 RADDAT
 X01 C                   ELSE                                                                 RADDAT
      *                                                                                       RADDAT
      * #ifndef                                                                               RADDAT
     C                   EVAL      SRCDTA = f_replace(c(8)          :                         RADDAT
     C                                                cSTRUCTNAME   :                         RADDAT
     C                                    '__' + %trim(f_structName))                         RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * #define                                                                               RADDAT
     C                   EVAL      SRCDTA = f_replace(c(9)          :                         RADDAT
     C                                                cSTRUCTNAME   :                         RADDAT
     C                                    '__' + %trim(f_structName))                         RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * DEFN2C    - DEFINE-Rahmen 2                                                           RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     DEFN2C        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
 B01 C     XISDFN        IFEQ      cFALSE                                                     RADDAT
      * keine Ausgabe der DEFINE-Bestimmungen                                                 RADDAT
 X01 C                   ELSE                                                                 RADDAT
      *                                                                                       RADDAT
      * #endif                                                                                RADDAT
     C                   EVAL      SRCDTA = c(10)                                             RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * ICFLD  Zeilen für Felddefinitionen generieren                                         RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     ICFLD         BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * Zeile mit Datenstrukturnamen                                                          RADDAT
     C                   EVAL      SRCDTA = c(5)                                              RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * Anzahl der MSG-Variablen bestimmen                                                    RADDAT
      * (Länge des kpl. Variablenbereichs / Länge einer Variablestruktur)                     RADDAT
     C                   EXSR      GETANZ                                                     RADDAT
      *                                                                                       RADDAT
 B01 C     P#MANZ        IFLE      *ZEROS                                                     RADDAT
      * ... keine Variablen definiert                                                         RADDAT
     C                   EVAL      SRCDTA = f_replace(c(6)         :                          RADDAT
     C                                                cVARNAME     :                          RADDAT
     C                                                'dummy'      )                          RADDAT
     C                   EVAL      SRCDTA = f_replace(SRCDTA       :                          RADDAT
     C                                                cVARTYPE     :                          RADDAT
     C                                                'char'       )                          RADDAT
     C                   EVAL      SRCDTA = f_replace(SRCDTA       :                          RADDAT
     C                                                cDELIMITER   :                          RADDAT
     C                                                ';'          )                          RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
 X01 C                   ELSE                                                                 RADDAT
      *                                                                                       RADDAT
     C                   Z-ADD     1             OF                                           RADDAT
 B02 C     1             DO        P#MANZ        A                                            RADDAT
      *                                                                                       RADDAT
      * einen Variableninformationsblock aus großen Block herausschneiden                     RADDAT
     C                   EXSR      CUTVAR                                                     RADDAT
      *                                                                                       RADDAT
      * Zeilenschablone vorbereiten                                                           RADDAT
     C                   EVAL      SRCDTA = c(6)                                              RADDAT
      *                                                                                       RADDAT
      * prüfen, ob Datentyp korrekt, sonst Fehler                                             RADDAT
     C                   EXSR      CHKTYP                                                     RADDAT
      *                                                                                       RADDAT
      * Feldnamen zusammenbauen                                                               RADDAT
     C                   EVAL      fldName = 'd' + ord(a)                                     RADDAT
      *                                                                                       RADDAT
      * Dezimalstellen oder *BLANK                                                            RADDAT
     C                   EXSR      GETDEZ                                                     RADDAT
      *                                                                                       RADDAT
 B03 C                   SELECT                                                               RADDAT
     C                   WHEN      F#TYP = 'A'                                                RADDAT
     C                   EVAL      fldType = 'char'                                           RADDAT
     C                   EVAL      fldName = %trim(fldName)                                   RADDAT
     C                                     + '['                                              RADDAT
     C                                     + %trimr(f_str(P#FLDL))                            RADDAT
     C                                     + ']'                                              RADDAT
     C                   WHEN      F#TYP = 'P'                                                RADDAT
     C                   EVAL      fldType = 'decimal'                                        RADDAT
     C                                     + '('                                              RADDAT
     C                                     + %trimr(f_str(P#FLDL))                            RADDAT
     C                                     + ','                                              RADDAT
     C                                     + %trimr(f_str(D#DPS ))                            RADDAT
     C                                     + ')'                                              RADDAT
     C                   WHEN      F#TYP = 'B'                                                RADDAT
 B04 C                   SELECT                                                               RADDAT
     C                   WHEN      P#FLDL = 9                                                 RADDAT
     C                   EVAL      fldType = 'long'                                           RADDAT
     C                   WHEN      P#FLDL = 4                                                 RADDAT
     C                   EVAL      fldType = 'short'                                          RADDAT
 X04 C                   OTHER                                                                RADDAT
     C                   EVAL      fldType = '*error'                                         RADDAT
 E04 C                   ENDSL                                                                RADDAT
 E03 C                   ENDSL                                                                RADDAT
      *                                                                                       RADDAT
     C                   EVAL      SRCDTA = f_replace(c(6)         :                          RADDAT
     C                                                cVARNAME     :                          RADDAT
     C                                                fldName      )                          RADDAT
     C                   EVAL      SRCDTA = f_replace(SRCDTA       :                          RADDAT
     C                                                cVARTYPE     :                          RADDAT
     C                                                fldType      )                          RADDAT
     C                   EVAL      SRCDTA = f_replace(SRCDTA       :                          RADDAT
     C                                                cDELIMITER   :                          RADDAT
     C                                                cC_DELIM     )                          RADDAT
      *                                                                                       RADDAT
 B03 C                   IF        P#FLDL = 0                                                 RADDAT
     C                   EVAL      %SUBST(SRCDTA: 2: 2) = '/*'                                RADDAT
     C                   EVAL      %SUBST(SRCDTA:40: 9) = 'Länge = 0'                         RADDAT
     C                   EVAL      %SUBST(SRCDTA:50: 2) = '*/'                                RADDAT
 E03 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      * Zeile wegschreiben                                                                    RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
 E02 C                   ENDDO                                                                RADDAT
      *                                                                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   EVAL      SRCDTA = f_replace(c(7)          :                         RADDAT
     C                                                cSTRUCTNAME   :                         RADDAT
     C                                %trim(f_structName) + cC_DELIM)                         RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * RPGFLD Zeilen für Felddefinitionen generieren                                         RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     RPGFLD        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * Zeile mit Datenstrukturnamen                                                          RADDAT
     C                   MOVEA(P)  RPG(11)       TXT                                          RADDAT
     C                   MOVEA     D#MFCH        TXT(7)                                       RADDAT
     C                   MOVEA     D#MNBR        TXT(8)                                       RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * Anzahl der MSG-Variablen bestimmen                                                    RADDAT
      * (Länge des kpl. Variablenbereichs / Länge einer Variablestruktur)                     RADDAT
     C                   EXSR      GETANZ                                                     RADDAT
      *                                                                                       RADDAT
 B01 C     P#MANZ        IFLE      *ZEROS                                                     RADDAT
     C                   Z-ADD     *ZEROS        D#DSLG                                       RADDAT
      * ... keine Variablen definiert                                                         RADDAT
     C                   MOVEL(P)  RPG(14)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
 X01 C                   ELSE                                                                 RADDAT
      *                                                                                       RADDAT
     C                   Z-ADD     1             OF                                           RADDAT
     C                   Z-ADD     1             OD                                           RADDAT
 B02 C     1             DO        P#MANZ        A                                            RADDAT
      *                                                                                       RADDAT
      * einen Variableninformationsblock aus großen Block herausschneiden                     RADDAT
     C                   EXSR      CUTVAR                                                     RADDAT
      *                                                                                       RADDAT
      * Zeilenschablone vorbereiten                                                           RADDAT
     C                   MOVEA(P)  RPG(12)       TXT                                          RADDAT
      *                                                                                       RADDAT
      * prüfen, ob Datentyp korrekt, sonst Fehler                                             RADDAT
     C                   EXSR      CHKTYP                                                     RADDAT
      *                                                                                       RADDAT
      * Feldnamen zusammenbauen                                                               RADDAT
     C                   CLEAR                   D#FLD                                        RADDAT
     C                   MOVEL     D#MFCH        D#PRF                                        RADDAT
     C                   MOVEL     D#MNBR        D#NBR                                        RADDAT
     C                   MOVEL (P) ORD(A)        D#ORD                                        RADDAT
     C                   MOVEA     D#FLD         TXT(53)                                      RADDAT
      *                                                                                       RADDAT
      * Dezimalstellen oder *BLANK                                                            RADDAT
     C                   EXSR      GETDEZ                                                     RADDAT
      *                                                                                       RADDAT
 B03 C     F#TYP         IFEQ      'A'                                                        RADDAT
     C                   MOVEL(P)  *BLANKS       F#TYP                                        RADDAT
 E03 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   MOVEA     F#TYP         TXT(43)                                      RADDAT
     C                   MOVEA     D#DEC         TXT(52)                                      RADDAT
      *                                                                                       RADDAT
      * Feld hat Länge 0                                                                      RADDAT
 B03 C                   IF        P#FLDP = 0                                                 RADDAT
     C                   MOVEA     ' * '         TXT(6)                                       RADDAT
     C                   Z-ADD     *ZEROS        D#OD                                         RADDAT
     C                   MOVEA     D#POS         TXT(45)                                      RADDAT
     C                   MOVEA     D#POS         TXT(49)                                      RADDAT
     C                   MOVEA     'Länge = 0'   TXT(61)                                      RADDAT
 X03 C                   ELSE                                                                 RADDAT
      *                                                                                       RADDAT
      * VON-Position                                                                          RADDAT
     C                   Z-ADD     OD            D#OD                           füllen D#POS  RADDAT
     C                   MOVEA     D#POS         TXT(45)                                      RADDAT
     C                   ADD       P#FLDP        OD                                           RADDAT
     C                   SUB       1             OD                                           RADDAT
      *                                                                                       RADDAT
      * BIS-Position                                                                          RADDAT
     C                   Z-ADD     OD            D#OD                           füllen D#POS  RADDAT
     C                   MOVEA     D#POS         TXT(49)                                      RADDAT
     C                   Z-ADD     D#OD          D#DSLG                                       RADDAT
     C                   ADD       1             OD                                           RADDAT
 E03 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      * Zeile wegschreiben                                                                    RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
 E02 C                   ENDDO                                                                RADDAT
      *                                                                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * RPGLNG Zeile mit Länge der Datenstruktur absetzen                                     RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     RPGLNG        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * Zeile mit Datenstrukturdefinition (nur DS, unbenannt)                                 RADDAT
     C                   MOVEA(P)  RPG(11)       TXT                                          RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * Zeile mit Datenstrukturlänge anlegen                                                  RADDAT
     C                   MOVEA(P)  RPG(13)       TXT                                          RADDAT
      *                                                                                       RADDAT
      * Strukturlänge wegschreiben                                                            RADDAT
     C                   MOVEA     D#DSLX        TXT(21)                                      RADDAT
      *                                                                                       RADDAT
      * Feldnamen zusammenbauen                                                               RADDAT
     C                   CLEAR                   D#FLD                                        RADDAT
     C                   MOVEL     D#MFCH        D#PRF                                        RADDAT
     C                   MOVEL     D#MNBR        D#NBR                                        RADDAT
     C                   MOVEL (P) 'LEN'         D#ORD                                        RADDAT
     C                   MOVEA     D#FLD         TXT(53)                                      RADDAT
      *                                                                                       RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * RPG4FLD - Zeilen für Felddefinitionen generieren ILE                                  RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     RPG4FLD       BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * Zeile mit Datenstrukturnamen                                                          RADDAT
     C                   MOVEA(P)  IRPG(11)      TXT                                          RADDAT
     C                   MOVEA     D#MSID        TXT(8)                                       RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * Anzahl der MSG-Variablen bestimmen                                                    RADDAT
      * (Länge des kpl. Variablenbereichs / Länge einer Variablestruktur)                     RADDAT
     C                   EXSR      GETANZ                                                     RADDAT
      *                                                                                       RADDAT
 B01 C     P#MANZ        IFLE      *ZEROS                                                     RADDAT
     C                   Z-ADD     *ZEROS        D#DSLG                                       RADDAT
      * ... keine Variablen definiert                                                         RADDAT
     C                   MOVEL(P)  IRPG(14)      SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
 X01 C                   ELSE                                                                 RADDAT
      *                                                                                       RADDAT
     C                   Z-ADD     1             OF                                           RADDAT
     C                   Z-ADD     1             OD                                           RADDAT
     C                   Z-ADD     *ZERO         D#DSLG                                       RADDAT
 B02 C     1             DO        P#MANZ        A                                            RADDAT
      *                                                                                       RADDAT
      * einen Variableninformationsblock aus großen Block herausschneiden                     RADDAT
     C                   EXSR      CUTVAR                                                     RADDAT
      *                                                                                       RADDAT
      * Zeilenschablone vorbereiten - ILE                                                     RADDAT
     C                   MOVEA(P)  IRPG(12)      TXT                                          RADDAT
      *                                                                                       RADDAT
      * prüfen, ob Datentyp korrekt, sonst Fehler                                             RADDAT
     C                   EXSR      CHKTYP                                                     RADDAT
      *                                                                                       RADDAT
      * Feldnamen zusammenbauen                                                               RADDAT
     C                   CLEAR                   D#IFLD                                       RADDAT
     C                   MOVEL     D#MPRF        D#IPRF                                       RADDAT
     C                   MOVEL     D#MNBR        D#INBR                                       RADDAT
     C                   MOVEL     ORD(A)        D#IORD                                       RADDAT
     C                   MOVEA     D#IFLD        TXT(9)                                       RADDAT
      *                                                                                       RADDAT
      * Dezimalstellen oder *BLANK ...                                                        RADDAT
     C                   EXSR      GETDEZ                                                     RADDAT
      * ... Initialisierung                                                                   RADDAT
 B03 C                   SELECT                                                               RADDAT
     C     F#TYP         WHENEQ    'A'                                                        RADDAT
     C                   MOVEA     '*BLANKS'     TXT(48)                                      RADDAT
     C     F#TYP         WHENEQ    'P'                                                        RADDAT
     C                   MOVEA     '*ZEROS'      TXT(48)                                      RADDAT
     C     F#TYP         WHENEQ    'B'                                                        RADDAT
     C                   MOVEA     '*ZEROS'      TXT(48)                                      RADDAT
 X03 C                   OTHER                                                                RADDAT
     C                   MOVEA     '*ERROR'      TXT(48)                                      RADDAT
 E03 C                   ENDSL                                                                RADDAT
      * ... Feldtyp                                                                           RADDAT
     C                   MOVEA     F#TYP         TXT(40)                                      RADDAT
      * ... Dezimalstellen                                                                    RADDAT
     C                   MOVEA     D#DEC         TXT(42)                                      RADDAT
      * ... Feldlänge                                                                         RADDAT
 B03 C                   IF        P#FLDP = *ZEROS                                            RADDAT
     C                   MOVEA     ' *'          TXT(6)                                       RADDAT
     C                   Z-ADD     *ZEROS        D#OD                           füllen D#POS  RADDAT
     C                   MOVEA     D#POS         TXT(37)                                      RADDAT
     C                   MOVEA     'Länge = 0'   TXT(58)                                      RADDAT
 X03 C                   ELSE                                                                 RADDAT
     C                   Z-ADD     P#FLDL        D#OD                           füllen D#POS  RADDAT
     C                   ADD       P#FLDP        D#DSLG                                       RADDAT
     C                   MOVEA     D#POS         TXT(37)                                      RADDAT
 E03 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      * Zeile wegschreiben                                                                    RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
 E02 C                   ENDDO                                                                RADDAT
      *                                                                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * IPGLNG Zeile mit Länge der Datenstruktur absetzen                                     RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     IPGLNG        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * Zeile mit Datenstrukturdefinition (nur DS, unbenannt)                                 RADDAT
     C                   MOVEA(P)  IRPG(13)      TXT                                          RADDAT
      *                                                                                       RADDAT
      * Strukturlänge wegschreiben                                                            RADDAT
     C                   MOVEA     D#DSLX        TXT(48)                                      RADDAT
      *                                                                                       RADDAT
      * Feldnamen zusammenbauen                                                               RADDAT
     C                   CLEAR                   D#IFLD                                       RADDAT
     C                   MOVEL     D#MPRF        D#IPRF                                       RADDAT
     C                   MOVEL     D#MNBR        D#INBR                                       RADDAT
     C                   MOVEL     '_SIZE'       D#EXT                                        RADDAT
     C                   MOVEA     D#IFLD        TXT(8)                                       RADDAT
      *                                                                                       RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * ICLFLD Zeilen für Felddefinitionen generieren CLP                                     RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     ICLFLD        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * Startposition für Schlüsselworte                                                      RADDAT
     C                   Z-ADD     16            #P                5 0                        RADDAT
      * Startposition für eingerückte Werte                                                   RADDAT
     C                   Z-ADD     21            #Z                5 0                        RADDAT
      * Startposition für Nachrichtentexte                                                    RADDAT
     C                   Z-ADD     1             #Z1               5 0                        RADDAT
      * Arbeitsfeld                                                                           RADDAT
     C                   Z-ADD     *ZEROS        cS                5 0                        RADDAT
     C                   Z-ADD     *ZEROS        cL                5 0                        RADDAT
     C                   Z-ADD     *ZEROS        cI                5 0                        RADDAT
      *                                                                                       RADDAT
      * MSGID()                                                                               RADDAT
     C                   CAT(P)    'MSGID':#P    SRCDTA                                       RADDAT
     C                   EXSR      OPNBRK                                                     RADDAT
     C                   CAT       XMSGI:0       SRCDTA                                       RADDAT
     C                   EXSR      CLSBRK                                                     RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * MSGF()                                                                                RADDAT
     C                   CAT(P)    'MSGF':#P     SRCDTA                                       RADDAT
     C                   EXSR      OPNBRK                                                     RADDAT
     C                   CAT       XMSGL:0       SRCDTA                                       RADDAT
     C                   CAT       '/':0         SRCDTA                                       RADDAT
     C                   CAT       XMSGF:0       SRCDTA                                       RADDAT
     C                   EXSR      CLSBRK                                                     RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * MSG()                                                                                 RADDAT
 B01 C     M3LGMR        IFGT      *ZEROS                                                     RADDAT
     C                   CAT(P)    'MSG':#P      SRCDTA                                       RADDAT
     C                   EXSR      OPNBRK                                                     RADDAT
     C                   CAT       '+':0         SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
     C                   Z-ADD     M3OFMG        cS                                           RADDAT
     C                   ADD       1             cS                                           RADDAT
     C                   Z-ADD     M3LGMR        cL                                           RADDAT
     C     cL            SUBST(P)  MS0300:cS     #TEXT                                        RADDAT
      *                                                                                       RADDAT
     C                   EXSR      RPLHPN                                                     RADDAT
     C     ''''          CAT(P)    #TEXT         #TEXT                                        RADDAT
    R ***                CAT       '''':0        #TEXT                                        RADDAT
     C     cL            ADD       2             cI                                           RADDAT
     C                   MOVEL(P)  ''''          #TB(cI)                                      RADDAT
      *                                                                                       RADDAT
     C                   EXSR      SPLITT                                                     RADDAT
      *                                                                                       RADDAT
     C                   CAT(P)    ') +':#P      SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      * SECLVL()                                                                              RADDAT
 B01 C     M3LGMH        IFGT      *ZEROS                                                     RADDAT
     C                   CAT(P)    'SEC':#P      SRCDTA                                       RADDAT
     C                   CAT(P)    'LVL':0       SRCDTA                                       RADDAT
     C                   EXSR      OPNBRK                                                     RADDAT
     C                   CAT       '+':0         SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
     C                   Z-ADD     M3OFMH        cS                                           RADDAT
     C                   ADD       1             cS                                           RADDAT
     C                   Z-ADD     M3LGMH        cL                                           RADDAT
     C     cL            SUBST(P)  MS0300:cS     #TEXT                                        RADDAT
      *                                                                                       RADDAT
     C                   EXSR      RPLHPN                                                     RADDAT
     C     ''''          CAT(P)    #TEXT         #TEXT                                        RADDAT
     C                   CAT       '''':0        #TEXT                                        RADDAT
     C                   EXSR      SPLITT                                                     RADDAT
      *                                                                                       RADDAT
     C                   CAT(P)    ') +':#P      SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      * SEV()                                                                                 RADDAT
     C                   CAT(P)    'SEV':#P      SRCDTA                                       RADDAT
     C                   EXSR      OPNBRK                                                     RADDAT
     C                   Z-ADD     M3MSSV        #N2                                          RADDAT
     C                   CAT       #A2:0         SRCDTA                                       RADDAT
     C                   EXSR      CLSBRK                                                     RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * Anzahl der MSG-Variablen bestimmen                                                    RADDAT
      * (Länge des kpl. Variablenbereichs / Länge einer Variablestruktur)                     RADDAT
     C                   EXSR      GETANZ                                                     RADDAT
      *                                                                                       RADDAT
 B01 C     P#MANZ        IFLE      *ZEROS                                                     RADDAT
      * ... keine Variablen definiert                                                         RADDAT
     C                   MOVEL(P)  CLP(14)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
 X01 C                   ELSE                                                                 RADDAT
      *                                                                                       RADDAT
      * FMT()                                                                                 RADDAT
 B02 C     P#MANZ        IFGT      *ZEROS                                                     RADDAT
     C                   CAT(P)    'FMT':#P      SRCDTA                                       RADDAT
     C                   EXSR      OPNBRK                                                     RADDAT
     C                   CAT(P)    ' +':0        SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
 E02 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   Z-ADD     1             OF                                           RADDAT
     C                   Z-ADD     1             OD                                           RADDAT
 B02 C     1             DO        P#MANZ        A                                            RADDAT
      *                                                                                       RADDAT
     C                   EVAL      %SUBST(SRCDTA: #Z: 1) = '('                                RADDAT
      *                                                                                       RADDAT
      * einen Variableninformationsblock aus großen Block herausschneiden                     RADDAT
     C                   EXSR      CUTVAR                                                     RADDAT
      *                                                                                       RADDAT
      * prüfen, ob Datentyp korrekt, sonst Fehler                                             RADDAT
     C                   EXSR      CHKTYP                                                     RADDAT
      *                                                                                       RADDAT
      * Dezimalstellen oder *BLANK ...                                                        RADDAT
     C                   EXSR      GETDEZ                                                     RADDAT
      * ... Initialisierung                                                                   RADDAT
 B03 C                   SELECT                                                               RADDAT
     C     F#TYP         WHENEQ    'B'                                                        RADDAT
     C                   CAT       '*BIN':0      SRCDTA                                       RADDAT
 B04 C     P#FLDL        IFGE      5                                                          RADDAT
     C                   Z-ADD     4             P#FLDL                                       RADDAT
 X04 C                   ELSE                                                                 RADDAT
     C                   Z-ADD     2             P#FLDL                                       RADDAT
 E04 C                   ENDIF                                                                RADDAT
 X03 C                   OTHER                                                                RADDAT
     C                   CAT       M3FTYP:0      SRCDTA                                       RADDAT
 E03 C                   ENDSL                                                                RADDAT
      * ... Feldlänge                                                                         RADDAT
     C                   Z-ADD     P#FLDL        D#OD                           füllen D#POS  RADDAT
     C                   CAT       D#POS:1       SRCDTA                                       RADDAT
      * ... Dezimalstellen                                                                    RADDAT
     C                   CAT       D#DEC:1       SRCDTA                                       RADDAT
      *                                                                                       RADDAT
      * Zeile wegschreiben                                                                    RADDAT
     C                   CAT(P)    ') +':0       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
 E02 C                   ENDDO                                                                RADDAT
      *                                                                                       RADDAT
     C                   CAT(P)    ') +':#P      SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      * ALROPT()                                                                              RADDAT
     C                   CAT(P)    'ALR':#P      SRCDTA                                       RADDAT
     C                   CAT(P)    'OPT':0       SRCDTA                                       RADDAT
     C                   EXSR      OPNBRK                                                     RADDAT
     C                   CAT       M3ALOP:0      SRCDTA                                       RADDAT
 B01 C     M3ALID        IFGE      1                                                          RADDAT
     C     M3ALID        ANDLE     99                                                         RADDAT
     C                   Z-ADD     M3ALID        #N2                                          RADDAT
     C                   CAT       #A2:1         SRCDTA                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
     C                   EXSR      CLSBRK                                                     RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * CCSID()                                                                               RADDAT
     C                   CAT(P)    'CCSID':#P    SRCDTA                                       RADDAT
     C                   EXSR      OPNBRK                                                     RADDAT
     C                   Z-ADD     M3CCIT        #N5                                          RADDAT
     C                   CAT       #A5:1         SRCDTA                                       RADDAT
     C                   EXSR      CLSBRK                                                     RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * EOF                                                                                   RADDAT
     C                   CAT(P)    '/*':#P       SRCDTA                                       RADDAT
     C                   CAT       '-EOF-':2     SRCDTA                                       RADDAT
     C                   CAT       '*/':2        SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * Leerzeile                                                                             RADDAT
     C                   MOVEL(P)  *BLANKS       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
 B01 C     XLAST         IFEQ      cTRUE                                                      RADDAT
      * nicht bei *SCRIPT                                                                     RADDAT
     C     XGENA         ANDNE     '*SCRIPT'                                                  RADDAT
      * RCLRSC                                                                                RADDAT
     C                   MOVEL(P)  CLP(12)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * Leerzeile                                                                             RADDAT
     C                   MOVEL(P)  *BLANKS       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
      *                                                                                       RADDAT
      * ENDPGM                                                                                RADDAT
     C                   MOVEL(P)  CLP(13)       SRCDTA                                       RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
 X01 C                   ELSE                                                                 RADDAT
      *  Ausgabe nur bei letzter Nachrichten-ID                                               RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * RPLHPN   - Replace hyphen                                                             RADDAT
      *            Ersetzen Hochkomma durch doppelte                                          RADDAT
      *            Hochkomma                                                                  RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     RPLHPN        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
     C                   Z-ADD     1             #Y                                           RADDAT
      *                                                                                       RADDAT
 B01 C     #Y            DOUEQ     *ZEROS                                                     RADDAT
      *                                                                                       RADDAT
     C     ''''          SCAN      #TEXT:#Y      #Y                                           RADDAT
 B02 C     #Y            IFLE      *ZEROS                                                     RADDAT
      *  Nichts weiter zu tun ...                                                             RADDAT
 X02 C                   ELSE                                                                 RADDAT
      *  Zweite "Hälfte" retten ...                                                           RADDAT
     C                   ADD       1             #Y                                           RADDAT
 B03 C     #Y            IFLE      8192                                                       RADDAT
     C                   SUBST     #TEXT:#Y      #TEMP                                        RADDAT
 X03 C                   ELSE                                                                 RADDAT
      *  "ASSERT"                                                                             RADDAT
     C                   MOVEL     'CPF9897'     sds_msgID                                    RADDAT
     C     '#Y:'         CAT       '> 8192':1    sds_msgDta                                   RADDAT
     C                   EXSR      *PSSR                                                      RADDAT
 E03 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   MOVEA     ''''          #TB(#Y)                                      RADDAT
     C                   ADD       1             #Y                                           RADDAT
     C                   ADD       1             cL                                           RADDAT
 B03 C     #Y            IFLE      8192                                                       RADDAT
     C                   MOVEA     #TEMP         #TB(#Y)                                      RADDAT
 X03 C                   ELSE                                                                 RADDAT
      *  "ASSERT"                                                                             RADDAT
     C                   MOVEL     'CPF9897'     sds_msgID                                    RADDAT
     C     '#Y:'         CAT       '> 8192':1    sds_msgDta                                   RADDAT
     C                   EXSR      *PSSR                                                      RADDAT
 E03 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
 E02 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
 E01 C                   ENDDO                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * SPLITT   - Aufsplitten von #TEXT auf mehrere Zeilen                                   RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     SPLITT        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
     C     71            SUB       #Z1           #L                5 0                        RADDAT
     C                   Z-ADD     *ZEROS        #X                5 0                        RADDAT
      *                                                                                       RADDAT
 B01 C     #TEXT         DOWNE     *BLANKS                                                    RADDAT
      *                                                                                       RADDAT
      *  Übertragen Nachrichtentext in Datenzeile                                             RADDAT
     C                   Z-ADD     1             #S                5 0                        RADDAT
     C     #L            SUBST(P)  #TEXT:#S      SRCDTA                                       RADDAT
      *                                                                                       RADDAT
      *  Entfernen übertragene Zeichen aus Nachrichtentext                                    RADDAT
     C                   ADD       #L            #S                                           RADDAT
 B02 C     #S            IFLE      8192                                                       RADDAT
     C                   SUBST(P)  #TEXT:#S      #TEXT                                        RADDAT
 X02 C                   ELSE                                                                 RADDAT
     C                   MOVEL(P)  *BLANKS       #TEXT                                        RADDAT
 E02 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
      *  Anfügen Fortsetzungszeichen                                                          RADDAT
     C                   MOVEA     SRCDTA        TXT(#Z1)                                     RADDAT
     C     #Z1           ADD       #L            #X                                           RADDAT
      *                                                                                       RADDAT
 B02 C     #TEXT         IFEQ      *BLANKS                                                    RADDAT
     C                   MOVE      '+'           TXT(#X)                                      RADDAT
 X02 C                   ELSE                                                                 RADDAT
     C                   MOVE      '-'           TXT(#X)                                      RADDAT
 E02 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   MOVEA(P)  TXT           SRCDTA                                       RADDAT
      *                                                                                       RADDAT
      *  Ausgeben Datenzeile                                                                  RADDAT
     C                   EXSR      WRTRPG                                                     RADDAT
 E01 C                   ENDDO                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * OPNBRK   - Íffnen Klammer (Open bracket)                                              RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     OPNBRK        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
     C                   CAT       '(':0         SRCDTA                                       RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * CLSBRK   - Schließen Klammer (Close bracket)                                          RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     CLSBRK        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
     C                   CAT       ') +':0       SRCDTA                                       RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * CHKTYP   - Prüfen Datentyp                                                            RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     CHKTYP        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
 B01 C     M3FTYP        IFNE      '*QTDCHAR'                                                 RADDAT
     C     M3FTYP        ANDNE     '*CHAR'                                                    RADDAT
     C     M3FTYP        ANDNE     '*DEC'                                                     RADDAT
     C     M3FTYP        ANDNE     '*HEX'                                                     RADDAT
     C     M3FTYP        ANDNE     '*BIN'                                                     RADDAT
     C                   MOVEL(P)  'CPF9897'     XERRID                                       RADDAT
     C                   MOVEL(P)  'MSG-ID:'     XERRDT                                       RADDAT
     C                   CAT       M3MGID:1      XERRDT                                       RADDAT
     C                   CAT       'Unerla':1    XERRDT                                       RADDAT
     C                   CAT       'ubter':0     XERRDT                                       RADDAT
     C                   CAT       'Typ':1       XERRDT                                       RADDAT
     C                   CAT       M3FTYP:1      XERRDT                                       RADDAT
     C                   GOTO      ENDE                                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * GETANZ   - Bestimmen Anzahl Variablen                                                 RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     GETANZ        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
 B01 C     M3LGVF        IFGT      *ZERO                                                      RADDAT
     C     M3LGVF        DIV       M3LVFE        P#MANZ                                       RADDAT
 X01 C                   ELSE                                                                 RADDAT
     C                   Z-ADD     *ZERO         P#MANZ                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * CUTVAR   - Herausschneiden eines Variablen-                                           RADDAT
      *            informationsblock aus großen Block                                         RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     CUTVAR        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
     C                   CLEAR                   MS030F                                       RADDAT
     C     M3LVFE        SUBST     D#SUBV:OF     MS030F                                       RADDAT
     C                   ADD       M3LVFE        OF                                           RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * GETDEZ   - Ermitteln Anzahl Dezimalstellen                                            RADDAT
      *            und Feldtyp                                                                RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     GETDEZ        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * Feldlänge laut MSGD                                                                   RADDAT
     C                   Z-ADD     M3FLGD        P#FLDL                                       RADDAT
     C                   Z-ADD     M3FLGD        P#FLDP                                       RADDAT
      *                                                                                       RADDAT
      * und rechnen                                                                           RADDAT
 B01 C                   SELECT                                                               RADDAT
     C     M3FTYP        WHENEQ    '*QTDCHAR'                                                 RADDAT
     C                   MOVEL     *BLANK        D#DEC                                        RADDAT
     C                   MOVEL     'A'           F#TYP             1                          RADDAT
      *                                                                                       RADDAT
     C     M3FTYP        WHENEQ    '*CHAR'                                                    RADDAT
     C                   MOVEL     *BLANK        D#DEC                                        RADDAT
     C                   MOVEL     'A'           F#TYP                                        RADDAT
      *                                                                                       RADDAT
     C     M3FTYP        WHENEQ    '*HEX'                                                     RADDAT
     C                   MOVEL     *BLANK        D#DEC                                        RADDAT
     C                   MOVEL     'A'           F#TYP                                        RADDAT
      *                                                                                       RADDAT
     C     M3FTYP        WHENEQ    '*DEC'                                                     RADDAT
     C                   Z-ADD     M3FFSZ        D#DPS                                        RADDAT
      *          die Feldlänge für gepackt errechnen                                          RADDAT
     C     P#FLDL        DIV       2             P#FLDP                                       RADDAT
     C                   ADD       1             P#FLDP                                       RADDAT
     C                   MOVEL     'P'           F#TYP                                        RADDAT
      *                                                                                       RADDAT
     C     M3FTYP        WHENEQ    '*BIN'                                                     RADDAT
 B02 C     P#FLDL        IFEQ      4                                                          RADDAT
     C                   Z-ADD     9             P#FLDL                                       RADDAT
 X02 C                   ELSE                                                                 RADDAT
     C                   Z-ADD     4             P#FLDL                                       RADDAT
 E02 C                   ENDIF                                                                RADDAT
     C                   MOVEL     'B'           F#TYP                                        RADDAT
     C                   Z-ADD     *ZEROS        D#DPS                                        RADDAT
      *                                                                                       RADDAT
 E01 C                   ENDSL                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * WRTRPG Schreiben Zeile in Sourcedatei                                                 RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     WRTRPG        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
     C                   ADD       ,01           SRCSEQ                                       RADDAT
     C                   Z-ADD     *ZERO         SRCDAT                                       RADDAT
     C                   WRITE     SRC           FSRC                                         RADDAT
      *                                                                                       RADDAT
     C                   MOVEL(P)  *BLANKS       SRCDTA                                       RADDAT
     C                   MOVEA(P)  *BLANKS       TXT                                          RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * EMDEFN   - Ermitteln DEFINE-Namen                                                     RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     EMDEFN        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
     C                   CLEAR                   P#DEFN                                       RADDAT
     C                   MOVEL(P)  XMSGI         P#DEFN                                       RADDAT
     C                   CAT       '_MSG':0      P#DEFN                                       RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * Programm Vorlauf                                                                      RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     FIRST         BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * Datei öffnen                                                                          RADDAT
     C                   OPEN      SRC                                                        RADDAT
      *                                                                                       RADDAT
      * Rückgabeparameter initialisieren                                                      RADDAT
     C                   MOVEL     *BLANK        XMBRT                          Msgtext       RADDAT
     C                   MOVEL     *BLANK        XERRID                         Error-ID      RADDAT
     C                   MOVEL     *BLANK        XERRDT                         Error-Data    RADDAT
      *
      * Initialisierung                                                                       RADDAT
      *                                                                                       RADDAT
      * Stelle in RTVM0300 ab der variabler Teil beginnt                                      RADDAT
     C                   Z-ADD     105           R#OFF3                         Offset in DS  RADDAT
      *                                                                                       RADDAT
      * laufender Zähler für Offsets                                                          RADDAT
     C                   Z-ADD     *ZERO         O                                            RADDAT
      *                                                                                       RADDAT
      * laufender Zähler Variablenverarbeitung                                                RADDAT
     C                   Z-ADD     *ZERO         A                                            RADDAT
      *                                                                                       RADDAT
      * Empfangsvariablen für variablen Teil initialisieren                                   RADDAT
     C                   MOVEL(P)  *BLANK        D#DRPL                                       RADDAT
     C                   MOVEL(P)  *BLANK        D#MSGT                                       RADDAT
     C                   MOVEL(P)  *BLANK        D#MSGH                                       RADDAT
     C                   MOVEL(P)  *BLANK        D#SUBV                                       RADDAT
      * Anzahl der Variablen in der MSG                                                       RADDAT
     C                   Z-ADD     *ZERO         P#MANZ                                       RADDAT
      * MSGID in Zerlegungsstruktur bringen                                                   RADDAT
     C                   MOVEL(P)  XMSGI         D#MSID                                       RADDAT
      * Länge der Msg-Variablen                                                               RADDAT
     C                   Z-ADD     *ZERO         P#FLDL                                       RADDAT
     C                   Z-ADD     *ZERO         P#FLDP                                       RADDAT
      * Rest bei Division                                                                     RADDAT
     C                   Z-ADD     *ZERO         P#REST                                       RADDAT
      * Sourcezeilenstruktur RPG erstmals initialisierem                                      RADDAT
 B01 C     XFIRST        IFEQ      cTRUE                                                      RADDAT
     C                   CLEAR                   FSRC                                         RADDAT
     C                   Z-ADD     *ZERO         SRCSEQ                                       RADDAT
 E01 C                   ENDIF                                                                RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * Programm Initialisierung einmalig                                                     RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     *INZSR        BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * Definition Programmaufrufparameter                                                    RADDAT
      * Input                                                                                 RADDAT
     C                   MOVEL     XMSGL         XMSGL            10            Msg-Lib       RADDAT
     C                   MOVEL     XMSGF         XMSGF            10            Msg-File      RADDAT
     C                   MOVEL     R#MSGF        R#MSGF           10            Msg-Lib       RADDAT
     C                   MOVEL     R#MSGL        R#MSGL           10            Msg-File      RADDAT
     C                   MOVEL     XMSGI         XMSGI             7            Msg-ID        RADDAT
     C                   MOVEL     XCPYL         XCPYL            10            Cpy-Lib       RADDAT
     C                   MOVEL     XCPYF         XCPYF            10            Cpy-File      RADDAT
     C                   MOVEL     XGENA         XGENA            10            Gener.Art     RADDAT
     C                   MOVEL     XISDFN        XISDFN            1            Define-Best.  RADDAT
     C                   MOVEL     XFIRST        XFIRST            1            1. Msg-ID     RADDAT
     C                   MOVEL     XLAST         XLAST             1            letzte Msg-ID RADDAT
      * Output                                                                                RADDAT
     C                   MOVEL     XMBRT         XMBRT            80            MbrText       RADDAT
     C                   MOVEL     XERRID        XERRID            7            Error-ID      RADDAT
     C                   MOVEL     XERRDT        XERRDT           80            Error-Data    RADDAT
      *                                                                                       RADDAT
      * Stelle in RTVM0300 ab der variabler Teil beginnt                                      RADDAT
     C                   Z-ADD     R#OFF3        R#OFF3            4 0          Offset in DS  RADDAT
      *                                                                                       RADDAT
      * laufender Zähler für Offsets                                                          RADDAT
     C                   Z-ADD     O             O                 4 0                        RADDAT
     C                   Z-ADD     OF            OF                3 0                        RADDAT
      *                                                                                       RADDAT
      * laufender Zähler für Positionen in generierter Datenstruktur                          RADDAT
     C                   Z-ADD     OD            OD                3 0                        RADDAT
      *                                                                                       RADDAT
      * laufender Zähler Variablenverarbeitung                                                RADDAT
     C                   Z-ADD     A             A                 4 0                        RADDAT
      *                                                                                       RADDAT
      * Anzahl der Variablen in der MSG                                                       RADDAT
     C                   Z-ADD     P#MANZ        P#MANZ            2 0                        RADDAT
      *                                                                                       RADDAT
      * Länge der Msg-Variablen                                                               RADDAT
     C                   Z-ADD     P#FLDL        P#FLDL            3 0                        RADDAT
     C                   Z-ADD     P#FLDP        P#FLDP            3 0                        RADDAT
      *                                                                                       RADDAT
      * Rest bei Division                                                                     RADDAT
     C                   Z-ADD     P#REST        P#REST            3 0                        RADDAT
      *                                                                                       RADDAT
      * Namen für Define                                                                      RADDAT
     C                   MOVEL     P#DEFN        P#DEFN           20                          RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * Fehlerbehandlung                                                                      RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     *PSSR         BEGSR                                                                RADDAT
      *                                                                                       RADDAT
     C                   DUMP                                                                 RADDAT
      *                                                                                       RADDAT
     C                   ENDSR     '*CANCL'                                                   RADDAT
      *****************************************************************                       RADDAT
      *  Replace variables                                                                    RADDAT
      *****************************************************************                       RADDAT
     P f_replace...                                                                           RADDAT
     P                 B                                                                      RADDAT
      *                                                                                       RADDAT
     D f_replace...                                                                           RADDAT
     D                 PI           256A                                                      RADDAT
     D  i_string                    256A   value                                              RADDAT
     D  i_var                        20A   value                                              RADDAT
     D  i_value                     256A   value                                              RADDAT
      *                                                                                       RADDAT
     D x               S             10I 0 inz                                                RADDAT
     D y               S             10I 0 inz                                                RADDAT
     D z               S             10I 0 inz                                                RADDAT
      *---------------------------------------------------------------                        RADDAT
      *                                                                                       RADDAT
     C                   EVAL      x = 0                                                      RADDAT
      *                                                                                       RADDAT
 B01 C                   DOU       x <= 0                                                     RADDAT
      *                                                                                       RADDAT
 B02 C                   IF        x > 0                                                      RADDAT
     C                   EVAL      y = x + %len(%trimr(i_var))                                RADDAT
     C     '>'           CHECK     i_string:y    y                                            RADDAT
 B03 C                   IF        y > 0                                                      RADDAT
     C                   EVAL      z = y - x                                                  RADDAT
 X03 C                   ELSE                                                                 RADDAT
     C                   EVAL      z = %len(%trimr(i_var))                                    RADDAT
 E03 C                   Endif                                                                RADDAT
     C                   EVAL      i_string = %replace(%subst(i_value: 1: z):                 RADDAT
     C                                                  i_string            :                 RADDAT
     C                                                  x                   :                 RADDAT
     C                                                  z                   )                 RADDAT
 E02 C                   Endif                                                                RADDAT
      *                                                                                       RADDAT
     C                   EVAL      x = %scan(%trimr(i_var):                                   RADDAT
     C                                       i_string     )                                   RADDAT
 E01 C                   Enddo                                                                RADDAT
      *                                                                                       RADDAT
     C                   RETURN    i_string                                                   RADDAT
      *                                                                                       RADDAT
     P f_replace...                                                                           RADDAT
     P                 E                                                                      RADDAT
      *****************************************************************                       RADDAT
      *  set to lower                                                                         RADDAT
      *****************************************************************                       RADDAT
     P f_lcase...                                                                             RADDAT
     P                 B                                                                      RADDAT
      *                                                                                       RADDAT
     D f_lcase...                                                                             RADDAT
     D                 PI           256A                                                      RADDAT
     D  i_string                    256A   value                                              RADDAT
      *                                                                                       RADDAT
     D uc              C                   const('ABCDEFGHIJKLMNOPQRSTUVWXYZ')                RADDAT
     D lc              C                   const('abcdefghijklmnopqrstuvwxyz')                RADDAT
      *---------------------------------------------------------------                        RADDAT
      *                                                                                       RADDAT
     C     uc:lc         XLATE     i_string      i_string                                     RADDAT
      *                                                                                       RADDAT
     C                   RETURN    i_string                                                   RADDAT
      *                                                                                       RADDAT
     P f_lcase...                                                                             RADDAT
     P                 E                                                                      RADDAT
      *****************************************************************                       RADDAT
      *  convert to char                                                                      RADDAT
      *****************************************************************                       RADDAT
     P f_str...                                                                               RADDAT
     P                 B                                                                      RADDAT
      *                                                                                       RADDAT
     D f_str...                                                                               RADDAT
     D                 PI           256A                                                      RADDAT
     D  i_value                      30P 0 value                                              RADDAT
      *                                                                                       RADDAT
      *---------------------------------------------------------------                        RADDAT
      *                                                                                       RADDAT
     C                   RETURN    %triml(%editc(i_value: 'Z'))                               RADDAT
      *                                                                                       RADDAT
     P f_str...                                                                               RADDAT
     P                 E                                                                      RADDAT
      *****************************************************************                       RADDAT
      *  c structure name                                                                     RADDAT
      *****************************************************************                       RADDAT
     P f_structName...                                                                        RADDAT
     P                 B                                                                      RADDAT
      *                                                                                       RADDAT
     D f_structName...                                                                        RADDAT
     D                 PI            20A                                                      RADDAT
      *                                                                                       RADDAT
      *---------------------------------------------------------------                        RADDAT
     C                   RETURN    %trim(f_lcase(D#MSID)) + '_t'                              RADDAT
      *                                                                                       RADDAT
     P f_structName...                                                                        RADDAT
     P                 E                                                                      RADDAT
      *                                                                                       RADDAT
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
