      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.2.0                               *
      *  Programm : PEEK33                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 19.12.1997  Raddatz                               *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Aktualisierungen beim Versionswechsel                        *
      *                                                               *
      * ============================================================= *
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<<  CALL PGM(&LI/PEEK99) PARM(+                     *
      *                        '&SF' '&SL' '&SM' '&LI' '*NO' +        *
      *                        'PEEK' '&LI' '*NO');                   *
      *   >>EXECUTE<<                                                 *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF                     ?
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR                    ?
      ***/COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Farbattribute------------------------------------*
      /COPY QCOPYLE,D_COLORATR                   ?
      *----------------------------------------------------*
      *
      *---Benutzereinstellungen----------------------------*
      /COPY QCOPYLE,SET0001                       Benutzervoreinstellungen
      /COPY QCOPYLE,SET0012                       Generieren Programme *CRTPGM
      *  Vor V3.0.0
     D SET0012_ALT     DS                  qualified
      *  Kleinbuchstaben erlaubt: 1=Ja; 0=Nein
     D  SET_ALWLC                    10A   INZ('1')
      *  Standardmäßig Klienbuchstaben: 1=Ja; 0=Nein
     D  SET_CASE                     10A   INZ('0')
      *  Endemarkierung
     D  SET_0012                      1A   INZ(x'8B')
      *
      /COPY QCOPYLE,SET0016                       SQL: Limit zum Anzeigen der Anzahl Datensät
      *
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      *----------------------------------------------------*
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0007
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D XVersion        S              9A
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
      *  Arbeitsfelder
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
      *
     D WrkTabDS        DS                  QUALIFIED
     D  Remark                        5A   INZ(*BLANKS)
     D  Section                      10A   INZ(*BLANKS)
     D  Key                          10A   INZ(*BLANKS)
     D  Data                               LIKE(R§SET0000 ) INZ(*BLANKS)
      *
     D o_Data          S                   LIKE(R§SET0000 )
     D                                     INZ
      *
     D WrkTab          S            100A   DIM(100) INZ(*BLANKS)
     D WrkElem         S                   like(r§int4    ) inz
      *
     D TB010100        S            100A   DIM( 59) CTDATA PERRCD(1)
     D ELM010100       C                   CONST(%ELEM(TB010100))
      *
     D TB010200        S            100A   DIM( 36) CTDATA PERRCD(1)
     D ELM010200       C                   CONST(%ELEM(TB010200))
      *
     D TB010300        S            100A   DIM( 12) CTDATA PERRCD(1)
     D ELM010300       C                   CONST(%ELEM(TB010300))
      *
     D TB010400        S            100A   DIM( 42) CTDATA PERRCD(1)
     D ELM010400       C                   CONST(%ELEM(TB010400))
      *
     D TB010500        S            100A   DIM( 52) CTDATA PERRCD(1)
     D ELM010500       C                   CONST(%ELEM(TB010500))
      *
     D TB020000        S            100A   DIM( 34) CTDATA PERRCD(1)
     D ELM020000       C                   CONST(%ELEM(TB020000))
      *
     D TB020100        S            100A   DIM( 40) CTDATA PERRCD(1)
     D ELM020100       C                   CONST(%ELEM(TB020100))
      *
     D TB020200        S            100A   DIM( 30) CTDATA PERRCD(1)
     D ELM020200       C                   CONST(%ELEM(TB020200))
      *
     D TB030000        S            100A   DIM( 22) CTDATA PERRCD(1)
     D ELM030000       C                   CONST(%ELEM(TB030000))
      *
     D TB030100        S            100A   DIM(  4) CTDATA PERRCD(1)
     D ELM030100       C                   CONST(%ELEM(TB030100))
      *
     D TB030101        S            100A   DIM( 24) CTDATA PERRCD(1)
     D ELM030101       C                   CONST(%ELEM(TB030101))
      *
     D TB030205        S            100A   DIM( 26) CTDATA PERRCD(1)
     D ELM030205       C                   CONST(%ELEM(TB030205))
      *
     D TB030401        S            100A   DIM(  4) CTDATA PERRCD(1)
     D ELM030401       C                   CONST(%ELEM(TB030401))
      *
     D TB030402        S            100A   DIM(  4) CTDATA PERRCD(1)
     D ELM030402       C                   CONST(%ELEM(TB030402))
      *
     D TB030500        S            100A   DIM(  4) CTDATA PERRCD(1)
     D ELM030500       C                   CONST(%ELEM(TB030500))
      *
      /COPY QCOPYLE,F_PEEK53
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
     C                   PARM                    XVersion
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *----------------------------------------------------*
      *
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
      *  Ermitteln der abgespeicherten Versions-Nr. ...
     C                   EXSR      GetUsrSetg
      *
      *  Vergleichen mit jetziger Versions-Nr. ...
     C     SET_VSN       IFNE      XVersion
      *  ... und bei Abweichungen den
      *      Aktualisierungsvorgang starten
     C                   EXSR      VPos
     C                   ELSE
     C                   Endif
      *
     C     ENDE          TAG
      *
     C                   MOVEL (P) '1'           *INLR
      *
      *============================================================*
      *    VPos          Durchführen der Aktualisierungsarbeiten   *
      *============================================================*
      *
     C     VPos          BEGSR
      *
      *  Schleife solabge durchlaufen, bis das
      *  der jetzige Versionsstand erreicht worden ist.
     C     SET_VSN       DOWLE     XVersion
      *
      *  ... aktualiseren der früheren Versionsstände
     C                   SELECT
     C     SET_VSN       WHENLT    'V01R01M00'
     C                   EXSR      V01R01M00
     C     SET_VSN       WHENLT    'V01R02M00'
     C                   EXSR      V01R02M00
     C     SET_VSN       WHENLT    'V01R03M00'
     C                   EXSR      V01R03M00
     C     SET_VSN       WHENLT    'V01R04M00'
     C                   EXSR      V01R04M00
     C     SET_VSN       WHENLT    'V01R05M00'
     C                   EXSR      V01R05M00
     C     SET_VSN       WHENLT    'V01R05M01'
     C                   EXSR      V01R05M01
     C     SET_VSN       WHENLT    'V02R00M00'
     C                   EXSR      V02R00M00
     C     SET_VSN       WHENLT    'V02R01M00'
     C                   EXSR      V02R01M00
     C     SET_VSN       WHENLT    'V02R01M01'
     C                   EXSR      V02R01M01
     C     SET_VSN       WHENLT    'V02R02M00'
     C                   EXSR      V02R02M00
     C     SET_VSN       WHENLT    'V02R02M01'
     C                   EXSR      V02R02M01
     C     SET_VSN       WHENLT    'V02R02M02'
     C                   EXSR      V02R02M02
     C     SET_VSN       WHENLT    'V02R03M00'
     C                   EXSR      V02R03M00
     C     SET_VSN       WHENLT    'V02R03M01'
     C                   EXSR      V02R03M01
     C     SET_VSN       WHENLT    'V02R03M02'
     C                   EXSR      V02R03M02
     C     SET_VSN       WHENLT    'V02R04M00'
     C                   EXSR      V02R04M00
     C     SET_VSN       WHENLT    'V02R04M01'
     C                   EXSR      V02R04M01
     C     SET_VSN       WHENLT    'V02R04M02'
     C                   EXSR      V02R04M02
     C     SET_VSN       WHENLT    'V03R00M00'
     C                   EXSR      V03R00M00
     C     SET_VSN       WHENLT    'V03R01M00'
     C                   EXSR      V03R01M00
     C     SET_VSN       WHENLT    'V03R01M01'
     C                   EXSR      V03R01M01
     C     SET_VSN       WHENLT    'V03R01M02'
     C                   EXSR      V03R01M02
     C     SET_VSN       WHENLT    'V03R01M03'
     C                   EXSR      V03R01M03
     C     SET_VSN       WHENLT    'V03R01M04'
     C                   EXSR      V03R01M04
     C     SET_VSN       WHENLT    'V03R01M05'
     C                   EXSR      V03R01M05
     C     SET_VSN       WHENLT    'V03R01M06'
     C                   EXSR      V03R01M06
     C     SET_VSN       WHENLT    'V03R02M00'
     C                   EXSR      V03R02M00
     C     SET_VSN       WHENLT    'V03R02M01'
     C                   EXSR      V03R02M01
     C     SET_VSN       WHENLT    'V03R02M02'
     C                   EXSR      V03R02M02
     C     SET_VSN       WHENLT    'V03R02M03'
     C                   EXSR      V03R02M03
     C     SET_VSN       WHENLT    'V03R02M04'
     C                   EXSR      V03R02M04
     C     SET_VSN       WHENLT    'V03R02M05'
     C                   EXSR      V03R02M05
     C     SET_VSN       WHENLT    'V03R02M06'
     C                   EXSR      V03R02M06
     C     SET_VSN       WHENLT    'V03R03M00'
     C                   EXSR      V03R03M00
     C     SET_VSN       WHENLT    'V03R03M01'
     C                   EXSR      V03R03M01
     C     SET_VSN       WHENLT    'V03R03M02'
     C                   EXSR      V03R03M02
     C     SET_VSN       WHENLT    'V03R03M03'
     C                   EXSR      V03R03M03
     C     SET_VSN       WHENLT    'V03R04M00'
     C                   EXSR      V03R04M00
     C     SET_VSN       WHENLT    'V03R04M01'
     C                   EXSR      V03R04M01
     C     SET_VSN       WHENLT    'V03R04M02'
     C                   EXSR      V03R04M02
     C     SET_VSN       WHENLT    'V03R04M03'
     C                   EXSR      V03R04M03
     C     SET_VSN       WHENLT    'V03R05M00'
     C                   EXSR      V03R05M00
     C     SET_VSN       WHENLT    'V03R05M01'
     C                   EXSR      V03R05M01
     C     SET_VSN       WHENLT    'V03R05M02'
     C                   EXSR      V03R05M02
     C     SET_VSN       WHENLT    'V03R05M03'
     C                   EXSR      V03R05M03
     C     SET_VSN       WHENLT    'V03R05M04'
     C                   EXSR      V03R05M04
     C     SET_VSN       WHENLT    'V03R05M05'
     C                   EXSR      V03R05M05
     C     SET_VSN       WHENLT    'V03R05M06'
     C                   EXSR      V03R05M06
     C     SET_VSN       WHENLT    'V03R05M07'
     C                   EXSR      V03R05M07
     C     SET_VSN       WHENLT    'V03R05M08'
     C                   EXSR      V03R05M08
     C                   OTHER
     C                   LEAVE
     C                   Endsl
      *
      *  ... Abspeichern der neuen Versions-Nr.
     C                   EXSR      SetUsrSetg
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    V01R01M00     Aktualisierung auf Version 1.1.0          *
      *============================================================*
      *
     C     V01R01M00     BEGSR
      *
     C                   MOVEA     TB010100      WrkTab
     C                   Z-ADD     ELM010100     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V01R01M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V01R02M00     Aktualisierung auf Version 1.2.0          *
      *============================================================*
      *
     C     V01R02M00     BEGSR
      *
     C                   MOVEA     TB010200      WrkTab
     C                   Z-ADD     ELM010200     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V01R02M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V01R03M00     Aktualisierung auf Version 1.3.0          *
      *============================================================*
      *
     C     V01R03M00     BEGSR
      *
     C                   MOVEA     TB010300      WrkTab
     C                   Z-ADD     ELM010300     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V01R03M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V01R04M00     Aktualisierung auf Version 1.4.0          *
      *============================================================*
      *
     C     V01R04M00     BEGSR
      *
     C                   MOVEA     TB010400      WrkTab
     C                   Z-ADD     ELM010400     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V01R04M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V01R05M00     Aktualisierung auf Version 1.5.0          *
      *============================================================*
      *
     C     V01R05M00     BEGSR
      *
     C                   MOVEA     TB010500      WrkTab
     C                   Z-ADD     ELM010500     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V01R05M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V01R05M01     Aktualisierung auf Version 1.5.1          *
      *============================================================*
      *
     C     V01R05M01     BEGSR
      *
      ***                MOVEA     TB010501      WrkTab
      ***                Z-ADD     ELM010501     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V01R05M01'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V02R00M00     Aktualisierung auf Version 2.0.0          *
      *============================================================*
      *
     C     V02R00M00     BEGSR
      *
     C                   MOVEA     TB020000      WrkTab
     C                   Z-ADD     ELM020000     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V02R00M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V02R01M00     Aktualisierung auf Version 2.1.0          *
      *============================================================*
      *
     C     V02R01M00     BEGSR
      *
     C                   MOVEA     TB020100      WrkTab
     C                   Z-ADD     ELM020100     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V02R01M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V02R01M01     Aktualisierung auf V02R01M01              *
      *============================================================*
      *
     C     V02R01M01     BEGSR
      *
      ***                MOVEA     TB020101      WrkTab
      ***                Z-ADD     ELM020101     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V02R01M01'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V02R02M00     Aktualisierung auf Version 2.2.0          *
      *============================================================*
      *
     C     V02R02M00     BEGSR
      *
     C                   MOVEA     TB020200      WrkTab
     C                   Z-ADD     ELM020200     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V02R02M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V02R02M01     Aktualisierung auf Version 2.2.1          *
      *============================================================*
      *
     C     V02R02M01     BEGSR
      *
      ***                MOVEA     TB020201      WrkTab
      ***                Z-ADD     ELM020201     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V02R02M01'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V02R02M02     Aktualisierung auf Version 2.2.2          *
      *============================================================*
      *
     C     V02R02M02     BEGSR
      *
      ***                MOVEA     TB020202      WrkTab
      ***                Z-ADD     ELM020202     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V02R02M02'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V02R03M00     Aktualisierung auf Version 2.3.0          *
      *============================================================*
      *
     C     V02R03M00     BEGSR
      *
      ***                MOVEA     TB020300      WrkTab
      ***                Z-ADD     ELM020300     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V02R03M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V02R03M01     Aktualisierung auf Version 2.3.1          *
      *============================================================*
      *
     C     V02R03M01     BEGSR
      *
      ***                MOVEA     TB020301      WrkTab
      ***                Z-ADD     ELM020301     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V02R03M01'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V02R03M02     Aktualisierung auf Version 2.3.1          *
      *============================================================*
      *
     C     V02R03M02     BEGSR
      *
      ***                MOVEA     TB020301      WrkTab
      ***                Z-ADD     ELM020301     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V02R03M02'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V02R04M00     Aktualisierung auf Version 2.4.0          *
      *============================================================*
      *
     C     V02R04M00     BEGSR
      *
      ***                MOVEA     TB020400      WrkTab
      ***                Z-ADD     ELM020400     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V02R04M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V02R04M01     Aktualisierung auf Version 2.4.1          *
      *============================================================*
      *
     C     V02R04M01     BEGSR
      *
      ***                MOVEA     TB020401      WrkTab
      ***                Z-ADD     ELM020401     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V02R04M01'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V02R04M02     Aktualisierung auf Version 2.4.2          *
      *============================================================*
      *
     C     V02R04M02     BEGSR
      *
      ***                MOVEA     TB020402      WrkTab
      ***                Z-ADD     ELM020402     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V02R04M02'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R00M00     Aktualisierung auf Version 3.0.0          *
      *============================================================*
      *
     C     V03R00M00     BEGSR
      *
     C                   MOVEA     TB030000      WrkTab
     C                   Z-ADD     ELM030000     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R00M00'   SET_VSN
      *
      *  Umsetzen Datenstruktur "Generieren Programme" (*CRTPGM, SET0012)
     C                   Eval      SET0012_ALT = f_getUsrSg('*CRTPGM')
      *
     C                   If        (SET0012_ALT.SET_ALWLC = '0' or
     C                              SET0012_ALT.SET_ALWLC = '1'   ) and
     C                             (SET0012_ALT.SET_CASE  = '0' or
     C                              SET0012_ALT.SET_CASE  = '1'   ) and
     C                             (SET0012_ALT.SET_0012  = x'8B' )
     C                   Reset                   SET0012
     C                   Eval      SET_ALWLC = SET0012_ALT.SET_ALWLC
     C                   Eval      SET_CASE  = SET0012_ALT.SET_CASE
     C                   Eval      SET_0012  = SET0012_ALT.SET_0012
     C                   Callp     p_updUsrSg('*CRTPGM': SET0012)
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R01M00     Aktualisierung auf Version 3.1.0          *
      *============================================================*
      *
     C     V03R01M00     BEGSR
      *
     C                   MOVEA     TB030100      WrkTab
     C                   Z-ADD     ELM030100     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R01M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R01M01     Aktualisierung auf Version 3.1.1          *
      *============================================================*
      *
     C     V03R01M01     BEGSR
      *
     C                   MOVEA     TB030101      WrkTab
     C                   Z-ADD     ELM030101     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R01M01'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R01M02     Aktualisierung auf Version 3.1.2          *
      *============================================================*
      *
     C     V03R01M02     BEGSR
      *
      ***                MOVEA     TB030102      WrkTab
      ***                Z-ADD     ELM030102     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R01M02'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R01M03     Aktualisierung auf Version 3.1.3          *
      *============================================================*
      *
     C     V03R01M03     BEGSR
      *
      ***                MOVEA     TB030103      WrkTab
      ***                Z-ADD     ELM030103     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R01M03'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R01M04     Aktualisierung auf Version 3.1.4          *
      *============================================================*
      *
     C     V03R01M04     BEGSR
      *
      ***                MOVEA     TB030104      WrkTab
      ***                Z-ADD     ELM030104     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R01M04'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R01M05     Aktualisierung auf Version 3.1.5          *
      *============================================================*
      *
     C     V03R01M05     BEGSR
      *
      ***                MOVEA     TB030105      WrkTab
      ***                Z-ADD     ELM030105     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R01M05'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R01M06     Aktualisierung auf Version 3.1.6          *
      *============================================================*
      *
     C     V03R01M06     BEGSR
      *
      ***                MOVEA     TB030105      WrkTab
      ***                Z-ADD     ELM030105     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R01M06'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R02M00     Aktualisierung auf Version 3.2.0          *
      *============================================================*
      *
     C     V03R02M00     BEGSR
      *
      ***                MOVEA     TB030106      WrkTab
      ***                Z-ADD     ELM030106     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R02M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R02M01     Aktualisierung auf Version 3.2.1          *
      *============================================================*
      *
     C     V03R02M01     BEGSR
      *
      ***                MOVEA     TB030106      WrkTab
      ***                Z-ADD     ELM030106     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R02M01'   SET_VSN
      *
      *  Eintragen Art und Weise der Umsetzung von Edit Codes in der Subfile:
     C                   Eval      SET0001 = f_getUsrSg('*DSPATTR')
      *
     C                   If        (SET_DspSgn <> '2')
     C                   Eval      SET_DspSgn   = '2'
     C                   Callp     p_updUsrSg('*DSPATTR': SET0001)
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R02M02     Aktualisierung auf Version 3.2.2          *
      *============================================================*
      *
     C     V03R02M02     BEGSR
      *
      ***                MOVEA     TB030106      WrkTab
      ***                Z-ADD     ELM030106     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R02M02'   SET_VSN
      *
      *  Ändern Default Edit Code von 'J' auf 'L'
     C                   Eval      SET0001 = f_getUsrSg('*DSPATTR')
      *
     C                   If        (SET_editCode = 'J')
     C                   Eval      SET_editCode = 'L'
     C                   Eval      SET_DspSgn   = '2'
     C                   Callp     p_updUsrSg('*DSPATTR': SET0001)
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R02M03     Aktualisierung auf Version 3.2.3          *
      *============================================================*
      *
     C     V03R02M03     BEGSR
      *
      ***                MOVEA     TB030106      WrkTab
      ***                Z-ADD     ELM030106     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R02M03'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R02M04     Aktualisierung auf Version 3.2.4          *
      *============================================================*
      *
     C     V03R02M04     BEGSR
      *
      ***                MOVEA     TB030204      WrkTab
      ***                Z-ADD     ELM030204     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R02M04'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R02M05     Aktualisierung auf Version 3.2.5          *
      *============================================================*
      *
     C     V03R02M05     BEGSR
      *
     C                   MOVEA     TB030205      WrkTab
     C                   Z-ADD     ELM030205     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R02M05'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R02M06     Aktualisierung auf Version 3.2.6          *
      *============================================================*
      *
     C     V03R02M06     BEGSR
      *
      ***                MOVEA     TB030206      WrkTab
      ***                Z-ADD     ELM030206     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R02M06'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R03M00     Aktualisierung auf Version 3.3.0          *
      *============================================================*
      *
     C     V03R03M00     BEGSR
      *
      ***                MOVEA     TB030300      WrkTab
      ***                Z-ADD     ELM030300     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R03M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R03M01     Aktualisierung auf Version 3.3.1          *
      *============================================================*
      *
     C     V03R03M01     BEGSR
      *
      ***                MOVEA     TB030301      WrkTab
      ***                Z-ADD     ELM030301     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R03M01'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R03M02     Aktualisierung auf Version 3.3.2          *
      *============================================================*
      *
     C     V03R03M02     BEGSR
      *
      ***                MOVEA     TB030302      WrkTab
      ***                Z-ADD     ELM030302     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R03M02'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R03M03     Aktualisierung auf Version 3.3.3          *
      *============================================================*
      *
     C     V03R03M03     BEGSR
      *
      ***                MOVEA     TB030303      WrkTab
      ***                Z-ADD     ELM030303     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R03M03'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R04M00     Aktualisierung auf Version 3.4.0          *
      *============================================================*
      *
     C     V03R04M00     BEGSR
      *
      ***                MOVEA     TB030400      WrkTab
      ***                Z-ADD     ELM030400     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R04M00'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R04M01     Aktualisierung auf Version 3.4.1          *
      *============================================================*
      *
     C     V03R04M01     BEGSR
      *
     C                   MOVEA     TB030401      WrkTab
     C                   Z-ADD     ELM030401     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R04M01'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R04M02     Aktualisierung auf Version 3.4.2          *
      *============================================================*
      *
     C     V03R04M02     BEGSR
      *
      ***                MOVEA     TB030402      WrkTab
      ***                Z-ADD     ELM030402     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R04M02'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R04M03     Aktualisierung auf Version 3.4.3          *
      *============================================================*
      *
     C     V03R04M03     BEGSR
      *
      ***                MOVEA     TB030403      WrkTab
      ***                Z-ADD     ELM030403     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R04M03'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R05M00     Aktualisierung auf Version 3.5.0          *
      *============================================================*
      *
     C     V03R05M00     BEGSR
      *
     C                   MOVEA     TB030500      WrkTab
     C                   Z-ADD     ELM030500     WrkElem
     C                   EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R05M00'   SET_VSN
      *
      *  Anlegen Einstellung für max. Anzahl Sätze für SQL-COUNT()
     C                   Eval      SET0016 = f_getUsrSg('*SQLLMTCNT')
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R05M01     Aktualisierung auf Version 3.5.1          *
      *============================================================*
      *
     C     V03R05M01     BEGSR
      *
      ***                MOVEA     TB030501      WrkTab
      ***                Z-ADD     ELM030501     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R05M01'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R05M02     Aktualisierung auf Version 3.5.2          *
      *============================================================*
      *
     C     V03R05M02     BEGSR
      *
      ***                MOVEA     TB030502      WrkTab
      ***                Z-ADD     ELM030502     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R05M02'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R05M03     Aktualisierung auf Version 3.5.3          *
      *============================================================*
      *
     C     V03R05M03     BEGSR
      *
      ***                MOVEA     TB030503      WrkTab
      ***                Z-ADD     ELM030503     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R05M03'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R05M04     Aktualisierung auf Version 3.5.4          *
      *============================================================*
      *
     C     V03R05M04     BEGSR
      *
      ***                MOVEA     TB030503      WrkTab
      ***                Z-ADD     ELM030503     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R05M04'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R05M05     Aktualisierung auf Version 3.5.5          *
      *============================================================*
      *
     C     V03R05M05     BEGSR
      *
      ***                MOVEA     TB030503      WrkTab
      ***                Z-ADD     ELM030503     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R05M05'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R05M06     Aktualisierung auf Version 3.5.6          *
      *============================================================*
      *
     C     V03R05M06     BEGSR
      *
      ***                MOVEA     TB030503      WrkTab
      ***                Z-ADD     ELM030503     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R05M06'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R05M07     Aktualisierung auf Version 3.5.7          *
      *============================================================*
      *
     C     V03R05M07     BEGSR
      *
      ***                MOVEA     TB030503      WrkTab
      ***                Z-ADD     ELM030503     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R05M07'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    V03R05M08     Aktualisierung auf Version 3.5.8          *
      *============================================================*
      *
     C     V03R05M08     BEGSR
      *
      ***                MOVEA     TB030503      WrkTab
      ***                Z-ADD     ELM030503     WrkElem
      ***                EXSR      UpdPeekUsr
      *
     C                   MOVEL (P) 'V03R05M08'   SET_VSN
      *
     C                   ENDSR
      *
      *============================================================*
      *    UpdPeekUsr    Aktualisieren der PEEKUSR-Datei           *
      *============================================================*
      *
     C     UpdPeekUsr    BEGSR
      *
     C     1             DO        WrkElem       X
      *
     C                   MOVEL (P) WrkTab(X)     WrkTabDS
      *
     C                   Eval      *IN11 = f_chainUsr(WrkTabDS.Section
     C                                                : WrkTabDS.Key: o_Data)
      *
     C                   ADD       1             X
      *
      *  Wenn der Datenbereich anders als erwartet
      *  belegt ist, ...
     C     o_Data        IFNE      WrkTabDS.Data
      *  ... dann keine Änderung durchführen
     C                   ITER
     C                   ELSE
      *  ... ansonsten die Änderung vollziehen
     C                   MOVEL (P) WrkTab(X)     WrkTabDS
     C                   IF        *IN11 = '1'
     C                   Callp     f_writeUsr(WrkTabDS.Section
     C                                        : WrkTabDS.Key: WrkTabDS.Data)
     C                   ELSE
     C                   Callp     f_updatUsr(WrkTabDS.Section
     C                                        : WrkTabDS.Key: WrkTabDS.Data)
     C                   Endif
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetUsrSetg    Ermitteln der Versions-Nr.                *
      *============================================================*
      *
     C     GetUsrSetg    BEGSR
      *
      *  *VERSION
     C                   Eval      SET0007 = f_getUsrSg('*VERSION'  )
      *
     C                   ENDSR
      *
      *============================================================*
      *    SetUsrSetg    Speichern der Versions-Nr.                *
      *============================================================*
      *
     C     SetUsrSetg    BEGSR
      *
      *  *DSPATR
     C                   Callp     p_updUsrSg('*VERSION': SET0007)
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
**   Section---Schlüssel-Datenbereich-------------------------- Version 1.1.0 -----------
alt: *PEEK05   *F11
neu: *PEEK05   *F11      *LAYOUT
alt: *PEEK05   *F13      *USERSETG
neu: *PEEK05   *F13      *REPEAT
alt: *PEEK05   *F15
neu: *PEEK05   *F15      *USERSETG
alt: *PEEK05   *F19      *LEFT
neu: *PEEK05   *F19      *PAGELEFT
alt: *PEEK05   *F20      *RIGHT
neu: *PEEK05   *F20      *PAGERIGHT
alt: *PEEK05   X
neu: *PEEK05   X         *NEXTMARK
alt: *PEEK05   Y
neu: *PEEK05   Y         *PREVMARK
alt: *PEEK05   L
neu: *PEEK05   L         *LEFT
alt: *PEEK05   R
neu: *PEEK05   R         *RIGHT
alt: *PEEK05   RB
neu: *PEEK05   RB        *REBUILD
alt: *PEEK05   UR
neu: *PEEK05   UR        *CLRPINROW
alt: *PEEK05   UC
neu: *PEEK05   UC        *CLRPINCOL
alt: *PEEK34
neu: *PEEK34             *NONE
alt: *PEEK34   *F03
neu: *PEEK34   *F03      *SAVE_EXIT
alt: *PEEK34   *F05
neu: *PEEK34   *F05      *REFRESH
alt: *PEEK34   *F11
neu: *PEEK34   *F11      *FLOATKEYS
alt: *PEEK34   *F12
neu: *PEEK34   *F12      *CANCEL
alt: *PEEK34   *F24
neu: *PEEK34   *F24      *MOREKEYS
alt: *PEEK34   *ENTER
neu: *PEEK34   *ENTER    *ENTER
alt: *PEEK34   *PAGEUP
neu: *PEEK34   *PAGEUP   *PAGEUP
alt: *PEEK34   *PAGEDOWN
neu: *PEEK34   *PAGEDOWN *PAGEDOWN
alt: *PEEK37   *ENTER
neu: *PEEK37   *ENTER    *ENTER
alt: *PEEK37   *F03
neu: *PEEK37   *F03      *EXIT
alt: *PEEK37   *F05
neu: *PEEK37   *F05      *REFRESH
alt: *PEEK37   *F12
neu: *PEEK37   *F12      *CANCEL
alt: *PEEK37   *F24
neu: *PEEK37   *F24      *MOREKEYS
alt: *PEEK37   *PAGEUP
neu: *PEEK37   *PAGEUP   *PAGEUP
alt: *PEEK37   *PAGEDOWN
neu: *PEEK37   *PAGEDOWN *PAGEDOWN
alt: *PEEK37   1
neu: *PEEK37   1         *SELECT
**   Section---Schlüssel-Datenbereich-------------------------- Version 1.2.0 -----------
alt: *CMD      DM
neu: *CMD      DM        DSPMSG
alt: *CMD      EA
neu: *CMD      EA        EDTOBJAUT OBJ(&L/&F) OBJTYPE(*FILE)
alt: *CMD      FD
neu: *CMD      FD        DSPFD FILE(&L/&F)
alt: *CMD      JL
neu: *CMD      JL        DSPJOBLOG
alt: *CMD      SP
neu: *CMD      SP        WRKSPLF
alt: *CMD      WS
neu: *CMD      WS        WRKSBMJOB
alt: *PEEK05   *F09      *MOVETOP
neu: *PEEK05   *F09      *DSPDBR
alt: *PEEK05   S
neu: *PEEK05   S         *TGLACCESS
alt: *PEEK40   *ENTER
neu: *PEEK40   *ENTER    *ENTER
alt: *PEEK40   *F03
neu: *PEEK40   *F03      *EXIT
alt: *PEEK40   *F05
neu: *PEEK40   *F05      *REFRESH
alt: *PEEK40   *F12
neu: *PEEK40   *F12      *CANCEL
alt: *PEEK40   *F24
neu: *PEEK40   *F24      *MOREKEYS
alt: *PEEK40   *PAGEUP
neu: *PEEK40   *PAGEUP   *PAGEUP
alt: *PEEK40   *PAGEDOWN
neu: *PEEK40   *PAGEDOWN *PAGEDOWN
alt: *PEEK40   1
neu: *PEEK40   1         *SELECT
alt: *PXXXXXXXX*F17
neu: *PXXXXXXXX*F17      *TOP
alt: *PXXXXXXXX*F18
neu: *PXXXXXXXX*F18      *BOT
**   Section---Schlüssel-Datenbereich-------------------------- Version 1.3.0 -----------
alt: *PXXXXXXXX*F09
neu: *PXXXXXXXX*F09      *HEXEDIT
alt: *PEEK45   *F03
neu: *PEEK45   *F03      *EXIT
alt: *PEEK45   *F05
neu: *PEEK45   *F05      *REFRESH
alt: *PEEK45   *F12
neu: *PEEK45   *F12      *CANCEL
alt: *PEEK45   *F24
neu: *PEEK45   *F24      *MOREKEYS
alt: *PEEK45   *ENTER
neu: *PEEK45   *ENTER    *ENTER
**   Section---Schlüssel-Datenbereich-------------------------- Version 1.4.0 -----------
alt: *PEEK47   *ENTER
neu: *PEEK47   *ENTER    *ENTER
alt: *PEEK47   *F03
neu: *PEEK47   *F03      *EXIT
alt: *PEEK47   *F05
neu: *PEEK47   *F05      *REFRESH
alt: *PEEK47   *F12
neu: *PEEK47   *F12      *CANCEL
alt: *PEEK47   *F23
neu: *PEEK47   *F23      *MOREOPT
alt: *PEEK47   *F24
neu: *PEEK47   *F24      *MOREKEYS
alt: *PEEK47   *PAGEUP
neu: *PEEK47   *PAGEUP   *PAGEUP
alt: *PEEK47   *PAGEDOWN
neu: *PEEK47   *PAGEDOWN *PAGEDOWN
alt: *PEEK47   1
neu: *PEEK47   1         *SELECT
neu: *PEEK47
neu: *PEEK47             *NONE
alt: *PEEK05   *F04
neu: *PEEK05   *F04      *PROMPT
alt: *PEEK17   *F04
neu: *PEEK17   *F04      *PROMPT
neu: *PEEK37
neu: *PEEK37             *NONE
alt: *PEEK37   *F23
neu: *PEEK37   *F23      *MOREOPT
alt: *PEEK14   *F09
neu: *PEEK14   *F09      *HEXEDIT
alt: *PEEK49   *ENTER
neu: *PEEK49   *ENTER    *ENTER
alt: *PEEK49   *F03
neu: *PEEK49   *F03      *EXIT
alt: *PEEK49   *F05
neu: *PEEK49   *F05      *REFRESH
alt: *PEEK49   *F12
neu: *PEEK49   *F12      *CANCEL
alt: *PEEK49   *F24
neu: *PEEK49   *F24      *MOREKEYS
alt: *PEEK05   A
neu: *PEEK05   A         *ABOUT
**   Section---Schlüssel-Datenbereich-------------------------- Version 1.5.0 -----------
alt: *PEEK50
neu: *PEEK50             *NONE
alt: *PEEK50   *F03
neu: *PEEK50   *F03      *SAVE_EXIT
alt: *PEEK50   *F05
neu: *PEEK50   *F05      *REFRESH
alt: *PEEK50   *F12
neu: *PEEK50   *F12      *CANCEL
alt: *PEEK50   *F16
neu: *PEEK50   *F16      *SEARCH
alt: *PEEK50   *F17
neu: *PEEK50   *F17      *TOP
alt: *PEEK50   *F18
neu: *PEEK50   *F18      *BOT
alt: *PEEK50   *F22
neu: *PEEK50   *F22      *CLRALL
alt: *PEEK50   *F24
neu: *PEEK50   *F24      *MOREKEYS
alt: *PEEK50   *ENTER
neu: *PEEK50   *ENTER    *ENTER
alt: *PEEK50   *PAGEUP
neu: *PEEK50   *PAGEUP   *PAGEUP
alt: *PEEK50   *PAGEDOWN
neu: *PEEK50   *PAGEDOWN *PAGEDOWN
alt: *PEEK05   *F15      *USERSETG
neu: *PEEK05   *F15      *PINCOLDLG
alt: *PEEK05   ST
neu: *PEEK05   ST        *USERSETG
alt: *PEEK14   *F17
neu: *PEEK14   *F17      *TOP
alt: *PEEK14   *F18
neu: *PEEK14   *F18      *BOT
alt: *PEEK37   *F16
neu: *PEEK37   *F16      *SEARCH
alt: *PEEK37   *F17
neu: *PEEK37   *F17      *TOP
alt: *PEEK37   *F18
neu: *PEEK37   *F18      *BOT
alt: *PEEK34   *F16
neu: *PEEK34   *F16      *SEARCH
alt: *PEEK34   *F17
neu: *PEEK34   *F17      *TOP
alt: *PEEK34   *F18
neu: *PEEK34   *F18      *BOT
alt: *PEEK05   H
neu: *PEEK05   H         *TGLDSP
alt: *PEEK47   *F16
neu: *PEEK47   *F16      *SEARCH
alt: *PEEK47   *F17
neu: *PEEK47   *F17      *TOP
alt: *PEEK47   *F18
neu: *PEEK47   *F18      *BOT
**   Section---Schlüssel-Datenbereich-------------------------- Version 2.0.0 -----------
alt: *PEEK48   *ENTER
neu: *PEEK48   *ENTER    *ENTER
alt: *PEEK48   *F03
neu: *PEEK48   *F03      *EXIT
alt: *PEEK48   *F04
neu: *PEEK48   *F04      *PROMPT
alt: *PEEK48   *F05
neu: *PEEK48   *F05      *REFRESH
alt: *PEEK48   *F09
neu: *PEEK48   *F09      *DSPDBR
alt: *PEEK48   *F11
neu: *PEEK48   *F11      *INSKEYFLD
alt: *PEEK48   *F12
neu: *PEEK48   *F12      *CANCEL
alt: *PEEK48   *F24
neu: *PEEK48   *F24      *MOREKEYS
alt: *PEEK05   *HELP
neu: *PEEK05   *HELP     *SQL
alt: *PEEK52   *ENTER
neu: *PEEK52   *ENTER    *ENTER
alt: *PEEK52   *F03
neu: *PEEK52   *F03      *EXIT
alt: *PEEK52   *F05
neu: *PEEK52   *F05      *REFRESH
alt: *PEEK52   *F12
neu: *PEEK52   *F12      *CANCEL
alt: *PEEK52   *F24
neu: *PEEK52   *F24      *MOREKEYS
alt: *PEEK40   *F16
neu: *PEEK40   *F16      *SEARCH
alt: *PEEK40   *F17
neu: *PEEK40   *F17      *TOP
alt: *PEEK40   *F18
neu: *PEEK40   *F18      *BOT
**   Section---Schlüssel-Datenbereich-------------------------- Version 2.1.0 -----------
alt: *PEEK56   *ENTER
neu: *PEEK56   *ENTER    *ENTER
alt: *PEEK56   *F03
neu: *PEEK56   *F03      *EXIT
alt: *PEEK56   *F05
neu: *PEEK56   *F05      *REFRESH
alt: *PEEK56   *F12
neu: *PEEK56   *F12      *CANCEL
alt: *PEEK56   *F16
neu: *PEEK56   *F16      *SEARCH
alt: *PEEK56   *F17
neu: *PEEK56   *F17      *TOP
alt: *PEEK56   *F18
neu: *PEEK56   *F18      *BOT
alt: *PEEK56   *F23
neu: *PEEK56   *F23      *MOREOPT
alt: *PEEK56   *F24
neu: *PEEK56   *F24      *MOREKEYS
alt: *PEEK56   *PAGEUP
neu: *PEEK56   *PAGEUP   *PAGEUP
alt: *PEEK56   *PAGEDOWN
neu: *PEEK56   *PAGEDOWN *PAGEDOWN
alt: *PEEK56   1
neu: *PEEK56   1         *SELECT
neu: *PEEK56
neu: *PEEK56             *NONE
alt: *PEEK05   SE
neu: *PEEK05   SE        *SAVEENV
alt: *PEEK05   LE
neu: *PEEK05   LE        *LOADENV
alt: *PEEK05   DE
neu: *PEEK05   DE        *DELETEENV
alt: *PEEK57   *F03
neu: *PEEK57   *F03      *EXIT
alt: *PEEK57   *F09
neu: *PEEK57   *F09      *DELETEENV
alt: *PEEK57   *F12
neu: *PEEK57   *F12      *CANCEL
alt: *PEEK57   *F24
neu: *PEEK57   *F24      *MOREKEYS
**   Section---Schlüssel-Datenbereich-------------------------- Version 2.2.0 -----------
alt: *PEEK45   *F19
neu: *PEEK45   *F19      *LEFT
alt: *PEEK45   *F20
neu: *PEEK45   *F20      *RIGHT
alt: *PEEK45   *F17
neu: *PEEK45   *F17      *FIRSTPOS
alt: *PEEK45   *F18
neu: *PEEK45   *F18      *LASTPOS
alt: *PEEK59   *ENTER
neu: *PEEK59   *ENTER    *OK
alt: *PEEK59   *F03
neu: *PEEK59   *F03      *NO
alt: *PEEK59   *F09
neu: *PEEK59   *F09      *YES
alt: *PEEK59   *F12
neu: *PEEK59   *F12      *CANCEL
alt: *PEEK12   *ENTER
neu: *PEEK12   *ENTER    *ENTER
alt: *PEEK12   *F03
neu: *PEEK12   *F03      *EXIT
alt: *PEEK12   *F05
neu: *PEEK12   *F05      *REFRESH
alt: *PEEK12   *F12
neu: *PEEK12   *F12      *CANCEL
alt: *PEEK12   *F24
neu: *PEEK12   *F24      *MOREKEYS
alt: *PEEK56   1         *SELECT
neu: *PEEK56   1         *SLCENV
alt: *PEEK56   2
neu: *PEEK56   2         *SLCLAYOUT
**   Section---Schlüssel-Datenbereich-------------------------- Version 3.0.0 -----------
alt: *PXXXXXXXX*F08
neu: *PXXXXXXXX*F08      *TGLNULL
alt: *PXXXXXXXX*F10
neu: *PXXXXXXXX*F10      *STREDIT
alt: *PXXXXXXXX*F13
neu: *PXXXXXXXX*F13      *TGLRCDLCK
alt: *PEEK14   *F10
neu: *PEEK14   *F10      *STREDIT
alt: *PEEK45   *F07
neu: *PEEK45   *F07      *TGLINPUT
alt: *PEEK64   *ENTER
neu: *PEEK64   *ENTER    *ENTER
alt: *PEEK64   *F03
neu: *PEEK64   *F03      *EXIT
alt: *PEEK64   *F05
neu: *PEEK64   *F05      *REFRESH
alt: *PEEK64   *F12
neu: *PEEK64   *F12      *CANCEL
alt: *PEEK64   *F24
neu: *PEEK64   *F24      *MOREKEYS
alt: *PEEK05   K
neu: *PEEK05   K         *TGLKEYLUC
**   Section---Schlüssel-Datenbereich-------------------------- Version 3.1.0 -----------
alt: *PEEK05   6
neu: *PEEK05   6         *PRINT
alt: *PEEK14   *F21
neu: *PEEK14   *F21      *PRINT
**   Section---Schlüssel-Datenbereich-------------------------- Version 3.1.1 -----------
neu: *PEEK68
neu: *PEEK68             *NONE
alt: *PEEK68   *ENTER
neu: *PEEK68   *ENTER    *ENTER
alt: *PEEK68   *F03
neu: *PEEK68   *F03      *EXIT
alt: *PEEK68   *F05
neu: *PEEK68   *F05      *REFRESH
alt: *PEEK68   *F12
neu: *PEEK68   *F12      *CANCEL
alt: *PEEK68   *F17
neu: *PEEK68   *F17      *TOP
alt: *PEEK68   *F18
neu: *PEEK68   *F18      *BOT
alt: *PEEK68   *F22
neu: *PEEK68   *F22      *MOREOPT
alt: *PEEK68   *F24
neu: *PEEK68   *F24      *MOREKEYS
alt: *PEEK68   *PAGEUP
neu: *PEEK68   *PAGEUP   *PAGEUP
alt: *PEEK68   *PAGEDOWN
neu: *PEEK68   *PAGEDOWN *PAGEDOWN
alt: *PEEK68   1
neu: *PEEK68   1         *SELECT
**   Section---Schlüssel-Datenbereich-------------------------- Version 3.2.5 -----------
neu: *PEEK69
neu: *PEEK69             *NONE
alt: *PEEK69   *ENTER
neu: *PEEK69   *ENTER    *ENTER
alt: *PEEK69   *F03
neu: *PEEK69   *F03      *EXIT
alt: *PEEK69   *F05
neu: *PEEK69   *F05      *REFRESH
alt: *PEEK69   *F12
neu: *PEEK69   *F12      *CANCEL
alt: *PEEK69   *F16
neu: *PEEK69   *F16      *SEARCH
alt: *PEEK69   *F17
neu: *PEEK69   *F17      *TOP
alt: *PEEK69   *F18
neu: *PEEK69   *F18      *BOT
alt: *PEEK69   *F23
neu: *PEEK69   *F23      *MOREOPT
alt: *PEEK69   *F24
neu: *PEEK69   *F24      *MOREKEYS
alt: *PEEK69   *PAGEDOWN
neu: *PEEK69   *PAGEDOWN *PAGEDOWN
alt: *PEEK69   *PAGEUP
neu: *PEEK69   *PAGEUP   *PAGEUP
alt: *PEEK69   1
neu: *PEEK69   1         *SELECT
**   Section---Schlüssel-Datenbereich-------------------------- Version 3.4.1 -----------
alt: *PEEK45   *PAGEUP
neu: *PEEK45   *PAGEUP   *PAGEUP
alt: *PEEK45   *PAGEDOWN
neu: *PEEK45   *PAGEDOWN *PAGEDOWN
**   Section---Schlüssel-Datenbereich-------------------------- Version 3.5.0 -----------
alt: *PEEK64   *ENTER    *OK
neu: *PEEK64   *ENTER    *ENTER
alt: *PEEK64   *F3       *NO
neu: *PEEK64   *F3       *EXIT
