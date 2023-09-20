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
     F                                     INFDS(§Workstn)
     F                                     INFSR(*PSSR)
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
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
      *  *ENTRY
     D xDsp80          S                   like(r§dsp80   )
     D xType           S             10A
     D xInpMsgID       S                   like(r§msgID   )
     D xInpMsgDta      S                   like(r§msgDta  )
     D xKeys           S              3A
     D xMsgID          S                   like(r§msgID   )
     D xMsgDta         S                   like(r§msgDta  )
      *
      *  Peek21
     D yScnAID         S                   like(r§scnAid  ) inz
     D yPgm            S                   like(r§pgm     ) inz
     D yPgmCmd         S                   like(r§pgmCmd  ) inz
     D yCmdDta         S                   like(r§pgmCmdDt) inz
     D yMsgID          S                   like(r§msgID   ) inz
     D yMsgDta         S                   like(r§msgDta  ) inz
      *
      *  Peek23:
      *yPgm            S                   like(r§pgm     ) inz
     D yKey            S             10A   inz
     D yPosF24         S                   like(r§int4    ) inz
     D yFKeys          S                   like(r§fKeyDsp ) inz
     D                                     dim(32)
     D yNbrOfKeys      S                   like(r§int4    ) inz
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D SfBot           S                   like(r§int4    ) inz
     D NbrFKeys        C                   const(2)
     D msgText         S            200A   inz
     D strPos          S                   like(r§uint4   ) inz
     D nbrOfKeys       S                   like(r§int4    ) inz
      *
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
      *
     D x               S                   like(r§int4    ) inz
     D tmpFkey         S                   like($$FKEY01  ) inz
     D int1            S                   like(r§int4    ) inz
     D int2            S                   like(r§int4    ) inz
     D isChanged       S                   like(r§bool    ) inz
      *
     D atoi            PR            10I 0        extproc('atoi')
     D  i_string                       *   value
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
     D $$FKEY          S                   like($$FKEY01  ) DIM(24) inz
      *
     IPBBOT#1
     I              $$FKEY01                    $$FKEY( 1)
     I              $$FKEY02                    $$FKEY( 2)
     IPBBOT#2
     I              $$FKEY03                    $$FKEY( 3)
     I              $$FKEY04                    $$FKEY( 4)
     IPBBOT#3
     I              $$FKEY05                    $$FKEY( 5)
     I              $$FKEY06                    $$FKEY( 6)
     IPBBOT#4
     I              $$FKEY07                    $$FKEY( 7)
     I              $$FKEY08                    $$FKEY( 8)
     IPBBOT#5
     I              $$FKEY09                    $$FKEY( 9)
     I              $$FKEY10                    $$FKEY(10)
     IPBBOT#6
     I              $$FKEY11                    $$FKEY(11)
     I              $$FKEY12                    $$FKEY(12)
     IPBBOT#7
     I              $$FKEY13                    $$FKEY(13)
     I              $$FKEY14                    $$FKEY(14)
     IPBBOT#8
     I              $$FKEY15                    $$FKEY(15)
     I              $$FKEY16                    $$FKEY(16)
     IPBBOT#9
     I              $$FKEY17                    $$FKEY(17)
     I              $$FKEY18                    $$FKEY(18)
     IPBBOT#10
     I              $$FKEY19                    $$FKEY(19)
     I              $$FKEY20                    $$FKEY(20)
     IPBBOT#11
     I              $$FKEY21                    $$FKEY(21)
     I              $$FKEY22                    $$FKEY(22)
     IPBBOT#12
     I              $$FKEY23                    $$FKEY(23)
     I              $$FKEY24                    $$FKEY(24)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     C     *entry        Plist
     C                   Parm                    xDsp80
     C                   Parm                    xType
     C                   Parm                    xInpMsgID
     C                   Parm                    xInpMsgDta
     C                   Parm                    xKeys
     C                   Parm                    xMsgID
     C                   Parm                    xMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK21
     C     P_Peek21      Plist
     C                   Parm                    yScnAID
     C                   Parm                    yPgm
     C                   Parm                    yPgmCmd
     C                   Parm                    yCmdDta
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK23
     C     P_Peek23      Plist
     C                   Parm                    yPgm
     C                   Parm                    yKey
     C                   Parm                    yPosF24
     C                   Parm                    yFKeys
     C                   Parm                    yNbrOfKeys
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *---------------------------------------------------*
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
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Bezugszahlen löschen
     C                   Exsr      bzoff1
      *
      *  Mappen der gedrückten Taste
      *  in Programmbefehl
     C                   Eval      yScnAID = §ScnAID
     C                   Eval      yPgm    = §§PgmName
     C                   Call      PEEK21        P_Peek21
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
     C                             (f_scan('Y': xKeys  ) <> 0)
     C                   Exsr      c_yes
     C                   Leave
      *
      *  F21 - No
     C                   When      (yPgmCmd = '*NO'    ) and
     C                             (f_scan('N': xKeys  ) <> 0)
     C                   Exsr      c_no
     C                   Leave
      *
      *  F12 - Cancel
     C                   When      (yPgmCmd = '*CANCEL') and
     C                             (f_scan('C': xKeys  ) <> 0)
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
     C                             (f_scan('E': xKeys  ) <> 0)
     C                   Exsr      c_enter
     C                   Leave
      *
     C                   Other
      *  Falsche Taste gedrückt
     C                   Callp     p_wrongKey(§scnAID: §§pgmName)
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
     C                   Eval      xMsgID  = 'USR8190'
     C                   Eval      xMsgDta = USR8190
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
     C                   Eval      xMsgID  = 'USR8190'
     C                   Eval      xMsgDta = USR8190
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
     C                   Eval      xMsgID  = 'USR8190'
     C                   Eval      xMsgDta = USR8190
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
     C                   Eval      xMsgID  = 'USR8190'
     C                   Eval      xMsgDta = USR8190
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
     C                   When      xType = '*INFO'
     C                   Eval      $$headLine = f_msgText('MBX0001': ' ')
     C                   When      xType = '*QUESTION'
     C                   Eval      $$headLine = f_msgText('MBX0002': ' ')
     C                   Other
     C                   Eval      $$headLine = ' '
     C                   Endsl
      *
     C                   Callp     p_center($$headLine)
      *
      *  Nachrichtentext ...
     C                   Eval      msgText = f_msgText(xInpMsgID: xInpMsgDta)
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
     C                   Movea     *blanks       yFKeys
     C                   Movea     *blanks       $$FKEY
      *  ... YES
     C                   If        f_scan('Y': xKeys) <> 0
     C                   Eval      nbrOfKeys = nbrOfKeys + 1
     C                   Eval      yKey = '*YES'
     C                   Exsr      getKey
     C                   Eval      $$FKEY(nbrOfKeys) = yFKeys(1)
     C                   Endif
      *  ... NO
     C                   If        f_scan('N': xKeys) <> 0
     C                   Eval      nbrOfKeys = nbrOfKeys + 1
     C                   Eval      yKey = '*NO'
     C                   Exsr      getKey
     C                   Eval      $$FKEY(nbrOfKeys) = yFKeys(1)
     C                   Endif
      *  ... OK
     C                   If        f_scan('E': xKeys) <> 0
     C                   Eval      nbrOfKeys = nbrOfKeys + 1
     C                   Eval      yKey = '*OK'
     C                   Exsr      getKey
     C                   Eval      $$FKEY(nbrOfKeys) = yFKeys(1)
     C                   Endif
      *  ... CANCEL
     C                   If        f_scan('C': xKeys) <> 0
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
     C                   Eval      yPgm      = §§PgmName
     C                   Eval      yPosF24   = 0
     C                   Call      PEEK23        P_Peek23
      *
     C                   ENDSR
      *
      *============================================================*
      *    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
      *============================================================*
      *
     C     setScreen     Begsr
      *
     C                   If        XDsp80 = *off
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
     C                   Eval      xMsgID  = ' '
     C                   Eval      xMsgDta = ' '
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
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *inzsr        Begsr
      *
     C                   Eval      §PgmQ = '*'
      *
     C                   Eval      PEEK21 = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23 = f_pgmCallN('PEEK23')
      *
     C                   Endsr
      *
      *============================================================*
      *    *PSSR         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *pssr         Begsr
      *
     C                   Dump
      *
     C                   Endsr     '*CANCL'
      *
