      * =================================================================== *
      *                                                                     *
      *  Kurzdokumentation :                                                *
      *                                                                     *
      *  Bereich . . . : CRTMSGDS                                           *
      *  Objekt  . . . : CRTMSGDSR1                                         *
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
      *  10.01.2003  Th.Raddatz    Removed special character § from source. *
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
      /COPY QCRTMSGDS,H_SPEC
      * =================================================================== *
      *
      *------------------------------------------------------------*
      *  allg. Feldbeschreibungen für API
      *------------------------------------------------------------*
      *
     D                 DS
     D  P#VLEN                 1      4I 0
     D  P#FORM                 5     14
     D  P#DTAL                15     18I 0
     D  P#CCSC                19     22I 0
     D  P#CCSR                23     26I 0
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
     D  M3XXX3               257    512
     D  M3XXX4               513    768
     D  M3XXX5               769   1024
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
      *-----------------------------------------------------
      *
     C     *ENTRY        PLIST
      * Input
     C                   PARM                    XMSGL                          Msg-Lib
     C                   PARM                    XMSGF                          Msg-File
     C                   PARM                    XMSGI                          Msg-ID
     C                   PARM                    XRTVO                          RetrieveOptio
      * Output
     C                   PARM                    XMSG                           Msgtext
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
     C                   Z-ADD     1024          P#VLEN
     C                   MOVEL(P)  'RTVM0300'    P#FORM
     C                   MOVEL(P)  XMSGI         P#MSGI            7
     C                   MOVEL(P)  XMSGL         P#MSLI                         Msg File
     C                   MOVEL(P)  XMSGF         P#MSFL                         Msg File
     C                   MOVEL(P)  *BLANKS       P#MSGD           80            Msg Dta
     C     ' '           CHECKR    P#MSGD        P#DTAL                         Msg Dta Len
     C                   MOVEL(P)  '*NO'         P#MSRS           10            Msg Repl Sub
     C                   MOVEL(P)  '*NO'         P#MSFC           10            Ret Form Cha
     C                   MOVEL(P)  XRTVO         P#RTVO           10            RetrieveOptio
     C                   Z-ADD     *ZERO         P#CCSC
     C                   Z-ADD     *ZERO         P#CCSR
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
      *  Optional
     C                   PARM                    P#RTVO                         RetrieveOptio
     C                   PARM                    P#CCSC
     C                   PARM                    P#CCSR
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
     C                   CAT       P#RTVO:1      XERRDT
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
     C                   MOVEL(P)  M3MGID        XMSG
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      ******************************************************
      * Programm Vorlauf
      ******************************************************
      *
     C     FIRST         BEGSR
      *
      * Rückgabeparameter initialisieren
     C                   MOVEL     *BLANK        XMSG                           MSGID
     C                   MOVEL     *BLANK        XERRID                         Error-ID
     C                   MOVEL     *BLANK        XERRDT                         Error-Data
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
     C                   MOVEL     XMSGI         XMSGI             7            Msg-ID
     C                   MOVEL     XRTVO         XRTVO             7            RetrieveOptio
      * Output
     C                   MOVEL     XMSG          XMSG              7            Msg
     C                   MOVEL     XERRID        XERRID            7            Error-ID
     C                   MOVEL     XERRDT        XERRDT           80            Error-Data
      *
     C                   ENDSR
      *
