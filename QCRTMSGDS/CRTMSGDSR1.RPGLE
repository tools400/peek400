000100231110      * =================================================================== *
000200231110      *                                                                     *
000300231110      *  Kurzdokumentation :                                                *
000400231110      *                                                                     *
000500231110      *  Bereich . . . : CRTMSGDS                                           *
000600231110      *  Objekt  . . . : CRTMSGDSR1                                         *
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
002600231110      *  10.01.2003  Th.Raddatz    Removed special character § from source. *
002700231110      *                                                                     *
002800231110      * =================================================================== *
002900231110      * >>PRE-COMPILER<<                                                    *
003000231110      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                         *
003100231110      *                           SRCFILE(&SL/&SF) SRCMBR(&SM);             *
003200231110      *   >>COMPILE<<                                                       *
003300231110      *     >>PARM<< TRUNCNBR(*NO);                                         *
003400231110      *     >>PARM<< DBGVIEW(*LIST);                                        *
003500231110      *     >>PARM<< TGTRLS(V7R1M0);                                        *
003600231110      *   >>END-COMPILE<<                                                   *
003700231110      *   >>EXECUTE<<                                                       *
003800231110      * >>END-PRE-COMPILER<<                                                *
003900231110      * =================================================================== *
004000231110      /COPY QCRTMSGDS,H_SPEC
004100231110      * =================================================================== *
004200231110      *
004300231110      *------------------------------------------------------------*
004400231110      *  allg. Feldbeschreibungen für API
004500231110      *------------------------------------------------------------*
004600231110      *
004700231110     D                 DS
004800231110     D  P#VLEN                 1      4I 0
004900231110     D  P#FORM                 5     14
005000231110     D  P#DTAL                15     18I 0
005100231110     D  P#CCSC                19     22I 0
005200231110     D  P#CCSR                23     26I 0
005300231110     D                 DS
005400231110     D  P#MSFL                 1     10
005500231110     D  P#MSLI                11     20
005600231110     D  P#MSGF                 1     20
005700231110      *
005800231110      *------------------------------------------------------------*
005900231110      *  Definition des Satzformates RTVM0300
006000231110      *------------------------------------------------------------*
006100231110     D MS0300          DS
006200231110     D  M3TRTN                 1      4I 0
006300231110     D  M3TVAL                 5      8I 0
006400231110      *
006500231110     D  M3MSSV                 9     12I 0
006600231110     D  M3ALID                13     16I 0
006700231110     D  M3ALOP                17     25
006800231110     D  M3LGIN                26     26
006900231110     D  M3MGID                27     33
007000231110     D  M3RES1                34     36
007100231110      *
007200231110     D  M3NSVF                37     40I 0
007300231110     D  M3CSIT                41     44I 0
007400231110      *
007500231110     D  M3CSIR                45     48I 0
007600231110     D  M3CCIT                49     52I 0
007700231110      *
007800231110     D  M3OFDR                53     56I 0
007900231110     D  M3LGDR                57     60I 0
008000231110     D  M3LDRA                61     64I 0
008100231110      *
008200231110     D  M3OFMG                65     68I 0
008300231110     D  M3LGMR                69     72I 0
008400231110     D  M3LMRA                73     76I 0
008500231110      *
008600231110     D  M3OFMH                77     80I 0
008700231110     D  M3LGMH                81     84I 0
008800231110     D  M3LMHA                85     88I 0
008900231110      *
009000231110     D  M3OFVF                89     92I 0
009100231110     D  M3LGVF                93     96I 0
009200231110     D  M3LVFA                97    100I 0
009300231110     D  M3LVFE               101    104I 0
009400231110      *
009500231110     D  M3RES2               105    256
009600231110     D  M3XXX3               257    512
009700231110     D  M3XXX4               513    768
009800231110     D  M3XXX5               769   1024
009900231110      *
010000231110      *-----------------------------------------------------
010100231110      * Format der Ersetzungsvariablen in der Message
010200231110      *-----------------------------------------------------
010300231110      *
010400231110     D MS030F          DS
010500231110     D  M3FLGD                 1      4I 0
010600231110     D  M3FFSZ                 5      8I 0
010700231110     D  M3FTYP                 9     18
010800231110     D  M3FRS1                19    256
010900231110     D  M3FRS2               257    512
011000231110      *
011100231110      *-----------------------------------------------------
011200231110      * Format der ERROR-Struktur bei API'S
011300231110      *-----------------------------------------------------
011400231110     D ERRCOD          DS
011500231110     D  ERRPRV                 1      4I 0 INZ
011600231110     D  ERRAVL                 5      8I 0 INZ
011700231110     D  ERRID                  9     15    INZ
011800231110     D  ERRRSV                16     16    INZ
011900231110     D  ERRDTA                17     32    INZ
012000231110      *
012100231110      *-----------------------------------------------------
012200231110      *
012300231110     C     *ENTRY        PLIST
012400231110      * Input
012500231110     C                   PARM                    XMSGL                          Msg-Lib
012600231110     C                   PARM                    XMSGF                          Msg-File
012700231110     C                   PARM                    XMSGI                          Msg-ID
012800231110     C                   PARM                    XRTVO                          RetrieveOptio
012900231110      * Output
013000231110     C                   PARM                    XMSG                           Msgtext
013100231110     C                   PARM                    XERRID                         Error-ID
013200231110     C                   PARM                    XERRDT                         Error-Data
013300231110      *
013400231110      *-----------------------------------------------------
013500231110      * Programm Vorlauf
013600231110      *-----------------------------------------------------
013700231110     C                   EXSR      FIRST
013800231110      *
013900231110      *-----------------------------------------------------
014000231110      * Aufruf API vorbereiten
014100231110      *-----------------------------------------------------
014200231110     C                   Z-ADD     1024          P#VLEN
014300231110     C                   MOVEL(P)  'RTVM0300'    P#FORM
014400231110     C                   MOVEL(P)  XMSGI         P#MSGI            7
014500231110     C                   MOVEL(P)  XMSGL         P#MSLI                         Msg File
014600231110     C                   MOVEL(P)  XMSGF         P#MSFL                         Msg File
014700231110     C                   MOVEL(P)  *BLANKS       P#MSGD           80            Msg Dta
014800231110     C     ' '           CHECKR    P#MSGD        P#DTAL                         Msg Dta Len
014900231110     C                   MOVEL(P)  '*NO'         P#MSRS           10            Msg Repl Sub
015000231110     C                   MOVEL(P)  '*NO'         P#MSFC           10            Ret Form Cha
015100231110     C                   MOVEL(P)  XRTVO         P#RTVO           10            RetrieveOptio
015200231110     C                   Z-ADD     *ZERO         P#CCSC
015300231110     C                   Z-ADD     *ZERO         P#CCSR
015400231110     C                   CLEAR                   ERRCOD
015500231110      *
015600231110     C                   CALL      'QMHRTVM'                            99
015700231110     C                   PARM                    MS0300
015800231110     C                   PARM                    P#VLEN
015900231110     C                   PARM                    P#FORM
016000231110     C                   PARM                    P#MSGI                         Msg ID
016100231110     C                   PARM                    P#MSGF                         Msg File
016200231110     C                   PARM                    P#MSGD                         Msg Dta
016300231110     C                   PARM                    P#DTAL                         Msg Dta Len
016400231110     C                   PARM                    P#MSRS                         Msg Repl Sub
016500231110     C                   PARM                    P#MSFC                         Ret Form Cha
016600231110     C                   PARM                    ERRCOD
016700231110      *  Optional
016800231110     C                   PARM                    P#RTVO                         RetrieveOptio
016900231110     C                   PARM                    P#CCSC
017000231110     C                   PARM                    P#CCSR
017100231110      *
017200231110      * prüfen, Aufruf OK
017300231110 B01 C     *IN99         IFEQ      *ON
017400231110     C                   MOVEL(P)  'CPF9897'     XERRID
017500231110     C                   MOVEL(P)  'Aufruf '     XERRDT
017600231110     C                   CAT       'fehler':1    XERRDT
017700231110     C                   CAT       'haft:':0     XERRDT
017800231110     C                   CAT       P#MSGF:1      XERRDT
017900231110     C                   CAT       'MSGID:':1    XERRDT
018000231110     C                   CAT       P#MSGI:1      XERRDT
018100231110     C                   CAT       P#RTVO:1      XERRDT
018200231110     C                   GOTO      ENDE
018300231110 E01 C                   ENDIF
018400231110      *
018500231110      *
018600231110 B01 C     ERRAVL        IFGT      *ZERO
018700231110     C                   MOVEL(P)  ERRID         XERRID
018800231110     C                   MOVEL(P)  ERRDTA        XERRDT
018900231110     C                   GOTO      ENDE
019000231110 E01 C                   ENDIF
019100231110      *
019200231110     C                   MOVEL(P)  M3MGID        XMSG
019300231110      *
019400231110     C     ENDE          TAG
019500231110      *
019600231110     C                   RETURN
019700231110      *
019800231110      ******************************************************
019900231110      * Programm Vorlauf
020000231110      ******************************************************
020100231110      *
020200231110     C     FIRST         BEGSR
020300231110      *
020400231110      * Rückgabeparameter initialisieren
020500231110     C                   MOVEL     *BLANK        XMSG                           MSGID
020600231110     C                   MOVEL     *BLANK        XERRID                         Error-ID
020700231110     C                   MOVEL     *BLANK        XERRDT                         Error-Data
020800231110      *
020900231110     C                   ENDSR
021000231110      *
021100231110      ******************************************************
021200231110      * Programm Initialisierung einmalig
021300231110      ******************************************************
021400231110      *
021500231110     C     *INZSR        BEGSR
021600231110      *
021700231110      * Definition Programmaufrufparameter
021800231110      * Input
021900231110     C                   MOVEL     XMSGL         XMSGL            10            Msg-Lib
022000231110     C                   MOVEL     XMSGF         XMSGF            10            Msg-File
022100231110     C                   MOVEL     XMSGI         XMSGI             7            Msg-ID
022200231110     C                   MOVEL     XRTVO         XRTVO             7            RetrieveOptio
022300231110      * Output
022400231110     C                   MOVEL     XMSG          XMSG              7            Msg
022500231110     C                   MOVEL     XERRID        XERRID            7            Error-ID
022600231110     C                   MOVEL     XERRDT        XERRDT           80            Error-Data
022700231110      *
022800231110     C                   ENDSR
022900231110      *
