      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK32                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 26.11.97  Raddatz                                 *
      *  ge鄚dert : 27.04.99  2.1.0                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Konvertieren nicht darstellbarer Zeichen                     *
      *                                                               *
      * ============================================================= *
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
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8163
      *----------------------------------------------------*
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0006
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
     D XBuffer         DS
     D XTab                           1A   DIM(呀cdBufLen)
     D XBuffLen        S                   like(r告nt4    )
     D xCcsid          S                   like(r告nt4    )
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
      *  Arbeitsfelder
     D X               S                   like(r告nt4    ) inz
     D Y               S                   like(r告nt4    ) inz
      *
      /COPY QCOPYLE,F_PEEK53
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
     C                   PARM                    xBuffer
     C                   PARM                    xBuffLen
     C                   PARM                    xCcsid
     C                   PARM                    xMsgID
     C                   PARM                    xMsgDta
      *
      *----------------------------------------------------*
      *
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
      *
      *    Zeichen mit einer DOUBLE BYTE CCSID, wie 1200 oder 13488
      *    k霵nen zur Zeit nicht gepr�ft werden.
     C                   If        (xCcsid <> 0)
     C                   Goto      ENDE
     C                   Endif
      *
     C     1             DO        XBuffLen      X
      *
     C     XTab(X)       IFLT      x'40'
     C     XTab(X)       OREQ      x'FF'
     C                   EVAL      XTab(X) = SET_CVTC
     C                   EVAL      XMsgID = 'USR8163'
     C                   EVAL      USR81631 = SET_CVTC
     C                   EVAL      XMsgDta = USR8163
     C                   ELSE
      *           Zeichen beibehalten
     C                   Endif
      *
     C                   Enddo
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *============================================================*
      *    GetUsrSetg    Ermitteln der Standardsprache             *
      *============================================================*
      *
     C     GetUsrSetg    BEGSR
      *
      *  *CVTCHR
     C                   Eval      SET0006 = f_getUsrSg('*CVTCHR'   )
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   EXSR      GetUsrSetg
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
