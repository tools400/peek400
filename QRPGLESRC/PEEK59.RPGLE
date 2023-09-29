      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.2.0                               *
      *  Programm : PEEK59                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 06.08.1999  Raddatz                               *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Generische Nachrichtenabfrage                     *
      *                                                               *
      *===============================================================*
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
     FPEEK59FM  CF   E             WORKSTN USROPN
     F                                     INFDS(workstn)
      *
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
      *----------------------------------------------------*
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK59
      /undefine internal_prototype
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8190
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *  Peek21
     D yPgmCmd         S                   like(pgmCmd_t) inz
     D yCmdDta         S                   like(pgmCmdDt_t) inz
     D yMsgID          S                   like(msgID_t) inz
     D yMsgDta         S                   like(msgDta_t) inz
      *
      *  Peek23:
     D yKey            S             10A   inz
     D yFKeys          S                   like(fKeyDsp_t) inz
     D                                     dim(32)
     D yNbrOfKeys      S                   like(int4_t) inz
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D SfBot           S                   like(int4_t) inz
     D NbrFKeys        C                   const(2)
     D msgText         S            200A   inz
     D strPos          S                   like(uint4_t) inz
     D nbrOfKeys       S                   like(int4_t) inz
      *
     D PEEK21_NAME     S                   like(pgmCallN_t) inz
     D PEEK23_NAME     S                   like(pgmCallN_t) inz
      *
     D x               S                   like(int4_t) inz
     D tmpFkey         S                   like($$FKEY01  ) inz
     D int1            S                   like(int4_t) inz
     D int2            S                   like(int4_t) inz
     D isChanged       S                   like(bool_t) inz
      *
     D atoi            PR            10I 0        extproc('atoi')
     D  i_string                       *   value
      *
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
     D $$FKEY          S                   like($$FKEY01  ) DIM(24) inz
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK59          PI
     D  i_dsp80                            const like(dsp80_t)
     D  i_type                             const like(type_t)
     D  i_msgID                            const like(msgID_t)
     D  i_msgDta                           const like(msgDta_t)
     D  i_keys                        3A   const
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
      *
     C                   Exsr      First
      *
      *---------------------------------------------------*
      *  Schleife für Programmbearbeitung
      *
     C                   DO        *HIVAL
      *
      *  Nachrichten senden
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
     C                   Exsr      toScreen
      *
      *  Nachrichten anzeigen
     C                   Eval      *in89 = *off
     C                   Write     MSGCTL
      *
      *  Anzeigen der Befehlstasten
     C                   Select
     C                   When      (sfBot = 2) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#2                                      BT-Tasten 2
     C                   When      (sfBot = 3) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#3                                      BT-Tasten 3
     C                   When      (sfBot = 4) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#4                                      BT-Tasten 4
     C                   When      (sfBot = 5) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#5                                      BT-Tasten 4
     C                   When      (sfBot = 6) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#6                                      BT-Tasten 4
     C                   When      (sfBot = 7) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#7                                      BT-Tasten 2
     C                   When      (sfBot = 8) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#8                                      BT-Tasten 3
     C                   When      (sfBot = 9) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#9                                      BT-Tasten 4
     C                   When      (sfBot = 10) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#10                                     BT-Tasten 4
     C                   When      (sfBot = 11) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#11                                     BT-Tasten 4
     C                   When      (sfBot = 12) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   Write     PBBOT#12                                     BT-Tasten 4
     C                   Other
     C                   Write     PBBOT#1                                      BT-Tasten 1
     C                   Eval      sfBot = 1
     C                   Endsl
      *
      *  Anzeigen Bildschirm
     C                   Exfmt     BILD01
      *
     C                   Exsr      FromScreen
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Bezugszahlen löschen
     C                   Exsr      bzoff1
      *
      *  Mappen der gedrückten Taste
      *  in Programmbefehl
     C                   CALLP     PEEK21(workstn.aid: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C                   If        yMsgID <> ' '
     C                   Eval      §MsgID  = yMsgID
     C                   Eval      §MsgDta = yMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Iter
     C                   Endif
      *
      *  Abfragen der Programmbefehle
     C                   Select
      *  F5  - Aktualisieren
     C                   When      yPgmCmd = '*REFRESH'
     C                   Exsr      c_refresh
     C                   Iter
      *  F9  - Yes
     C                   When      (yPgmCmd = '*YES'   )  and
     C                             (f_scan('Y': i_keys  ) <> 0)
     C                   Exsr      c_yes
     C                   Leave
      *
      *  F21 - No
     C                   When      (yPgmCmd = '*NO'    ) and
     C                             (f_scan('N': i_keys  ) <> 0)
     C                   Exsr      c_no
     C                   Leave
      *
      *  F12 - Cancel
     C                   When      (yPgmCmd = '*CANCEL') and
     C                             (f_scan('C': i_keys  ) <> 0)
     C                   Exsr      c_cancel
     C                   Leave
      *
      *  F24 - Weitere Tasten
     C                   When      yPgmCmd = '*MOREKEYS'
     C                   Exsr      c_MoreKeys
     C                   Iter
      *
      *  Datenfreigabe = OK
     C                   When      (yPgmCmd = '*ENTER' ) and
     C                             (f_scan('E': i_keys  ) <> 0)
     C                   Exsr      c_enter
     C                   Leave
      *
     C                   Other
      *  Falsche Taste gedrückt
     C                   Callp     p_wrongKey(workstn.aid: §§pgmName)
     C                   Iter
     C                   Endsl
      *
     C                   Enddo                                                  *HIVAL
      *
      *  Ende der Hauptschleife
      *---------------------------------------------------*
      *
      *  Programm verlassen
     C     ende          Tag
      *
     C                   Close     PEEK59FM
      *
     C                   Eval      *inlr = *ON
      *
      *============================================================*
      *    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
      *============================================================*
      *
     C     bzoff1        Begsr
      *
      *  DSPATR(PC)
      *
      *  DSPATR(RI)
      *
      *  Fehler
     C                   EVAL      *IN99 = '0'
      *
     C                   Endsr
      *
      *============================================================*
      *    c_yes         F9 = Yes                                  *
      *============================================================*
      *
     C     c_yes         Begsr
      *
     C                   Clear                   USR8190
     C                   Eval      USR81901 = yPgmCmd
     C                   Eval      o_msgID  = 'USR8190'
     C                   Eval      o_msgDta = USR8190
      *
     C                   Endsr
      *
      *============================================================*
      *    c_no          F3 = No                                   *
      *============================================================*
      *
     C     c_no          Begsr
      *
     C                   Clear                   USR8190
     C                   Eval      USR81901 = yPgmCmd
     C                   Eval      o_msgID  = 'USR8190'
     C                   Eval      o_msgDta = USR8190
      *
     C                   Endsr
      *
      *============================================================*
      *    c_enter       "Datenfreigabetaste" = OK                 *
      *============================================================*
      *
     C     c_enter       Begsr
      *
     C                   Clear                   USR8190
     C                   Eval      USR81901 = yPgmCmd
     C                   Eval      o_msgID  = 'USR8190'
     C                   Eval      o_msgDta = USR8190
      *
     C                   Endsr
      *
      *============================================================*
      *    c_cancel      F12 = Cancel                              *
      *============================================================*
      *
     C     c_cancel      Begsr
      *
     C                   Clear                   USR8190
     C                   Eval      USR81901 = yPgmCmd
     C                   Eval      o_msgID  = 'USR8190'
     C                   Eval      o_msgDta = USR8190
      *
     C                   Endsr
      *
      *============================================================*
      *    c_refresh     F5  - Aktualisieren der Subfile           *
      *============================================================*
      *
     C     c_refresh     Begsr
      *
     C                   Exsr      fill##
      *
     C                   ENDSR
      *
      *============================================================*
      *    c_moreKeys    F24 - Weitere Tasten                      *
      *============================================================*
      *
     C     c_moreKeys    Begsr
      *
     C                   Eval      sfBot = sfBot + 1
      *
     C                   Endsr
      *
      *============================================================*
      *    FILL##        Füllen Bildschirm                         *
      *============================================================*
      *
     C     FILL##        Begsr
      *
      *  Überschrift ...
     C                   Select
     C                   When      i_type = '*INFO'
     C                   Eval      $$headLine = f_msgText('MBX0001': ' ')
     C                   When      i_type = '*QUESTION'
     C                   Eval      $$headLine = f_msgText('MBX0002': ' ')
     C                   Other
     C                   Eval      $$headLine = ' '
     C                   Endsl
      *
     C                   Callp     p_center($$headLine)
      *
      *  Nachrichtentext ...
     C                   Eval      msgText = f_msgText(i_msgID: i_msgDta)
      *
      *  ... Zeile 1
     C                   Eval      strPos = 1
     C                   Eval      $$line#01 = f_wordWrap(msgText: 40: strPos)
     C                   Eval      $$line#01 = %triml($$line#01)
      *  ... Zeile 2
     C                   If        strPos > 0
     C                   Eval      $$line#02 = f_wordWrap(msgText: 40: strPos)
     C                   Eval      $$line#02 = %triml($$line#02)
     C                   Endif
      *  ... Zeile 3
     C                   If        strPos > 0
     C                   Eval      $$line#03 = f_wordWrap(msgText: 40: strPos)
     C                   Eval      $$line#03 = %triml($$line#03)
     C                   Endif
      *  ... Zeile 4
     C                   If        strPos > 0
     C                   Eval      $$line#04 = f_wordWrap(msgText: 40: strPos)
     C                   Eval      $$line#04 = %triml($$line#04)
     C                   Endif
      *  ... Zeile 5
     C                   If        strPos > 0
     C                   Eval      $$line#05 = f_wordWrap(msgText: 40: strPos)
     C                   Eval      $$line#05 = %triml($$line#05)
     C                   Endif
      *
      *  Funktionstasten ...
     C                   Eval      nbrOfKeys = 0
     C                   Eval      yFKeys(*) = ''
     C                   Eval      $$FKEY(*) = ''
      *  ... YES
     C                   If        f_scan('Y': i_keys) <> 0
     C                   Eval      nbrOfKeys = nbrOfKeys + 1
     C                   Eval      yKey = '*YES'
     C                   Exsr      getKey
     C                   Eval      $$FKEY(nbrOfKeys) = yFKeys(1)
     C                   Endif
      *  ... NO
     C                   If        f_scan('N': i_keys) <> 0
     C                   Eval      nbrOfKeys = nbrOfKeys + 1
     C                   Eval      yKey = '*NO'
     C                   Exsr      getKey
     C                   Eval      $$FKEY(nbrOfKeys) = yFKeys(1)
     C                   Endif
      *  ... OK
     C                   If        f_scan('E': i_keys) <> 0
     C                   Eval      nbrOfKeys = nbrOfKeys + 1
     C                   Eval      yKey = '*OK'
     C                   Exsr      getKey
     C                   Eval      $$FKEY(nbrOfKeys) = yFKeys(1)
     C                   Endif
      *  ... CANCEL
     C                   If        f_scan('C': i_keys) <> 0
     C                   Eval      nbrOfKeys = nbrOfKeys + 1
     C                   Eval      yKey = '*CANCEL'
     C                   Exsr      getKey
     C                   Eval      $$FKEY(nbrOfKeys) = yFKeys(1)
     C                   Endif
      *
      *  Sortieren der Funktionstasten
     C                   If        nbrOfKeys > 1
     C                   Dou       isChanged = bFalse
     C                   Eval      isChanged = bFalse
     C     2             Do        nbrOfKeys     x
     C                   Eval      tmpFKey = %subst(ScrnFKeys(x-1): 2)+x'00'
     C                   Eval      int1 = atoi(%addr(tmpFkey))
     C                   Eval      tmpFKey = %subst(ScrnFKeys(x  ): 2)+x'00'
     C                   Eval      int2 = atoi(%addr(tmpFkey))
     C                   If        int2 < int1
     C                   Eval      isChanged = bTrue
     C                   Eval      tmpFkey = ScrnFKeys(x-1)
     C                   Eval      ScrnFKeys(x-1) = ScrnFKeys(x)
     C                   Eval      ScrnFKeys(x  ) = tmpFkey
     C                   Endif
     C                   Enddo
     C                   Enddo
     C                   Endif
      *
     C                   Eval      yNbrOfKeys = nbrOfKeys
      *
     C                   Endsr
      *
      *============================================================*
      *    getKey        Einlesen F-Taste                          *
      *============================================================*
      *
     C     getKey        Begsr
      *
     C                   Callp     PEEK23(§§PgmName: yKey: 0
     C                                    : yFKeys: yNbrOfKeys)
      *
     C                   ENDSR
      *
      *============================================================*
      *    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
      *============================================================*
      *
     C     setScreen     Begsr
      *
     C                   If        i_dsp80 = *off
      *   132-Zeichen Anzeige
     C                   Eval      *in88 = *off
     C                   Eval      zei = 6 + 1
     C                   Eval      pos = 40
     C                   Else
      *    80-Zeichen Anzeige
     C                   Eval      *in88 = *on
     C                   Eval      zei = 4 + 3
     C                   Eval      pos = 7
     C                   Endif
      *
     C                   Endsr
      *
      *====================================================*
      *  Copy program fields to screen.                    *
      *====================================================*
      *
     C     ToScreen      Begsr
      *
     C                   Eval      $$FKEY01 = $$FKEY( 1)
     C                   Eval      $$FKEY02 = $$FKEY( 2)
     C                   Eval      $$FKEY03 = $$FKEY( 3)
     C                   Eval      $$FKEY04 = $$FKEY( 4)
     C                   Eval      $$FKEY05 = $$FKEY( 5)
     C                   Eval      $$FKEY06 = $$FKEY( 6)
     C                   Eval      $$FKEY07 = $$FKEY( 7)
     C                   Eval      $$FKEY08 = $$FKEY( 8)
     C                   Eval      $$FKEY09 = $$FKEY( 9)
     C                   Eval      $$FKEY10 = $$FKEY(10)
     C                   Eval      $$FKEY11 = $$FKEY(11)
     C                   Eval      $$FKEY12 = $$FKEY(12)
     C                   Eval      $$FKEY13 = $$FKEY(13)
     C                   Eval      $$FKEY14 = $$FKEY(14)
     C                   Eval      $$FKEY15 = $$FKEY(15)
     C                   Eval      $$FKEY16 = $$FKEY(16)
     C                   Eval      $$FKEY17 = $$FKEY(17)
     C                   Eval      $$FKEY18 = $$FKEY(18)
     C                   Eval      $$FKEY19 = $$FKEY(19)
     C                   Eval      $$FKEY20 = $$FKEY(20)
     C                   Eval      $$FKEY21 = $$FKEY(21)
     C                   Eval      $$FKEY22 = $$FKEY(22)
     C                   Eval      $$FKEY23 = $$FKEY(23)
     C                   Eval      $$FKEY24 = $$FKEY(24)
      *
     C                   Endsr
      *
      *====================================================*
      *  Copy screen to program fields.                    *
      *====================================================*
      *
     C     FromScreen    Begsr
      *
     C                   Eval      $$FKEY( 1) = $$FKEY01
     C                   Eval      $$FKEY( 2) = $$FKEY02
     C                   Eval      $$FKEY( 3) = $$FKEY03
     C                   Eval      $$FKEY( 4) = $$FKEY04
     C                   Eval      $$FKEY( 5) = $$FKEY05
     C                   Eval      $$FKEY( 6) = $$FKEY06
     C                   Eval      $$FKEY( 7) = $$FKEY07
     C                   Eval      $$FKEY( 8) = $$FKEY08
     C                   Eval      $$FKEY( 9) = $$FKEY09
     C                   Eval      $$FKEY(10) = $$FKEY10
     C                   Eval      $$FKEY(11) = $$FKEY11
     C                   Eval      $$FKEY(12) = $$FKEY12
     C                   Eval      $$FKEY(13) = $$FKEY13
     C                   Eval      $$FKEY(14) = $$FKEY14
     C                   Eval      $$FKEY(15) = $$FKEY15
     C                   Eval      $$FKEY(16) = $$FKEY16
     C                   Eval      $$FKEY(17) = $$FKEY17
     C                   Eval      $$FKEY(18) = $$FKEY18
     C                   Eval      $$FKEY(19) = $$FKEY19
     C                   Eval      $$FKEY(20) = $$FKEY20
     C                   Eval      $$FKEY(21) = $$FKEY21
     C                   Eval      $$FKEY(22) = $$FKEY22
     C                   Eval      $$FKEY(23) = $$FKEY23
     C                   Eval      $$FKEY(24) = $$FKEY24
      *
     C                   Endsr
      *
      *============================================================*
      *    First         Initialisierung                           *
      *============================================================*
      *
     C     First         Begsr
      *
      * - Öffnen der Dateien
     C                   Open      PEEK59FM
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   Eval      o_msgID  = ' '
     C                   Eval      o_msgDta = ' '
      *
      * - Füllen der Bildschirmfelder
     C                   Exsr      bzoff1
     C                   Exsr      fill##
      *
      * - Darstellung der Befehlstasten
     C                   Eval      sfBot = 1
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   Exsr      setScreen
      *
     C                   Endsr
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
     C                   Eval      §PgmQ = '*'
      *
     C                   Eval      PEEK21_NAME = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23_NAME = f_pgmCallN('PEEK23')
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
