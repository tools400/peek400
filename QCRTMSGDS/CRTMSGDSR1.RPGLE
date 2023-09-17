      * =================================================================== *                 RADDAT
      *                                                                     *                 RADDAT
      *  Kurzdokumentation :                                                *                 RADDAT
      *                                                                     *                 RADDAT
      *  Bereich . . . : CRTMSGDS                                           *                 RADDAT
      *  Objekt  . . . : CRTMSGDSR1                                         *                 RADDAT
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
      *  10.01.2003  Th.Raddatz    Removed special character § from source. *                 RADDAT
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
      /COPY QCRTMSGDS,H_SPEC                                                                  RADDAT
      * =================================================================== *                 RADDAT
      *                                                                                       RADDAT
      *------------------------------------------------------------*                          RADDAT
      *  allg. Feldbeschreibungen für API                                                     RADDAT
      *------------------------------------------------------------*                          RADDAT
      *                                                                                       RADDAT
     D                 DS                                                                     RADDAT
     D  P#VLEN                 1      4I 0                                                    RADDAT
     D  P#FORM                 5     14                                                       RADDAT
     D  P#DTAL                15     18I 0                                                    RADDAT
     D  P#CCSC                19     22I 0                                                    RADDAT
     D  P#CCSR                23     26I 0                                                    RADDAT
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
     D  M3XXX3               257    512                                                       RADDAT
     D  M3XXX4               513    768                                                       RADDAT
     D  M3XXX5               769   1024                                                       RADDAT
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
      *-----------------------------------------------------                                  RADDAT
      *                                                                                       RADDAT
     C     *ENTRY        PLIST                                                                RADDAT
      * Input                                                                                 RADDAT
     C                   PARM                    XMSGL                          Msg-Lib       RADDAT
     C                   PARM                    XMSGF                          Msg-File      RADDAT
     C                   PARM                    XMSGI                          Msg-ID        RADDAT
     C                   PARM                    XRTVO                          RetrieveOptionRADDAT
      * Output                                                                                RADDAT
     C                   PARM                    XMSG                           Msgtext       RADDAT
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
     C                   Z-ADD     1024          P#VLEN                                       RADDAT
     C                   MOVEL(P)  'RTVM0300'    P#FORM                                       RADDAT
     C                   MOVEL(P)  XMSGI         P#MSGI            7                          RADDAT
     C                   MOVEL(P)  XMSGL         P#MSLI                         Msg File      RADDAT
     C                   MOVEL(P)  XMSGF         P#MSFL                         Msg File      RADDAT
     C                   MOVEL(P)  *BLANKS       P#MSGD           80            Msg Dta       RADDAT
     C     ' '           CHECKR    P#MSGD        P#DTAL                         Msg Dta Len   RADDAT
     C                   MOVEL(P)  '*NO'         P#MSRS           10            Msg Repl Sub  RADDAT
     C                   MOVEL(P)  '*NO'         P#MSFC           10            Ret Form Cha  RADDAT
     C                   MOVEL(P)  XRTVO         P#RTVO           10            RetrieveOptionRADDAT
     C                   Z-ADD     *ZERO         P#CCSC                                       RADDAT
     C                   Z-ADD     *ZERO         P#CCSR                                       RADDAT
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
      *  Optional                                                                             RADDAT
     C                   PARM                    P#RTVO                         RetrieveOptionRADDAT
     C                   PARM                    P#CCSC                                       RADDAT
     C                   PARM                    P#CCSR                                       RADDAT
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
     C                   CAT       P#RTVO:1      XERRDT                                       RADDAT
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
     C                   MOVEL(P)  M3MGID        XMSG                                         RADDAT
      *                                                                                       RADDAT
     C     ENDE          TAG                                                                  RADDAT
      *                                                                                       RADDAT
     C                   RETURN                                                               RADDAT
      *                                                                                       RADDAT
      ******************************************************                                  RADDAT
      * Programm Vorlauf                                                                      RADDAT
      ******************************************************                                  RADDAT
      *                                                                                       RADDAT
     C     FIRST         BEGSR                                                                RADDAT
      *                                                                                       RADDAT
      * Rückgabeparameter initialisieren                                                      RADDAT
     C                   MOVEL     *BLANK        XMSG                           MSGID         RADDAT
     C                   MOVEL     *BLANK        XERRID                         Error-ID      RADDAT
     C                   MOVEL     *BLANK        XERRDT                         Error-Data    RADDAT
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
     C                   MOVEL     XMSGI         XMSGI             7            Msg-ID        RADDAT
     C                   MOVEL     XRTVO         XRTVO             7            RetrieveOptionRADDAT
      * Output                                                                                RADDAT
     C                   MOVEL     XMSG          XMSG              7            Msg           RADDAT
     C                   MOVEL     XERRID        XERRID            7            Error-ID      RADDAT
     C                   MOVEL     XERRDT        XERRDT           80            Error-Data    RADDAT
      *                                                                                       RADDAT
     C                   ENDSR                                                                RADDAT
      *                                                                                       RADDAT
