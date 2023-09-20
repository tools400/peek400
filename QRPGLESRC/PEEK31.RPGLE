      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK31                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 13.11.97  Raddatz                                 *
      *  ge鄚dert : 27.04.99  2.1.0                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Ermitteln der Benutzersprache                                *
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
      *----------------------------------------------------*
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0000
      /COPY QCOPYLE,SET0004
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
     D XLanguage       S             10A
     D XPrefix         S             10A
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
     C                   PARM                    XLanguage
     C                   PARM                    XPrefix
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *----------------------------------------------------*
      *
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
      *
      *  Ermitteln der zu verwendenden Sprache ...
     C     XLanguage     IFEQ      '*DFT'
      *  ... Standardsprache
     C                   EXSR      GetUsrSetg
     C                   ELSE
      *  ... Benutzen der �bergebenen Sprache
     C                   EVAL      SET_Lang = XLanguage
     C                   Endif
      *
     C                   IF        XMSGID <> ' '
     C                   GOTO      ENDE
     C                   Endif
      *
      *  ... Pr�fen der Nachrichtendatei
     C     1             DO        2
      *
     C                   EXSR      ChkMsgF
     C     刪ETURN       IFEQ      '0'
      *      ... kein Fehler
     C                   LEAVE
     C                   ELSE
      *      ... Fehler aufgetreten
     C     SET_Lang      IFEQ      'GER'
      *          ... Standardsprache
     C                   Eval      XMsgID  = 'CPF9897'
     C                   Eval      XMsgDta = 'Sprachendefinition ''' +
     C                                       %trim(XLanguage)      +
     C                                       ''' nicht gefunden.'
     C                   LEAVE
     C                   ELSE
      *          ... Benutzersprache
     C                   EVAL      SET_Lang = 'GER'
     C                   ITER
     C                   Endif
     C                   Endif
      *
     C                   Enddo
      *
     C     XMsgID        IFEQ      *BLANKS
     C                   EXSR      SetUsrSetg
     C                   EVAL      XLanguage = SET_Lang
     C                   ELSE
      *            Fehler aufgetreten
     C                   EVAL      XLanguage = *BLANKS
     C                   Endif
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
     C                   Eval      SET0004 = f_getUsrSg('*LANGUAGE':
     C                                                  XMsgID     :
     C                                                  XMsgDta    )
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkMsgF       Pr�fen der Nachrichtendatei               *
      *============================================================*
      *
     C     ChkMsgF       BEGSR
      *
     C     xPrefix       CAT       SET_Lang:0    別BJ
     C                   EVAL      兵IB = 壯PgmLib
     C                   EVAL      別BJTYPE = '*MSGF'
     C                   EVAL      冶BR = '*NONE'
     C                   EVAL      你UT = '*NONE'
      /COPY QCOPYLE,CHKOBJ
      *
     C                   ENDSR
      *
      *============================================================*
      *    SetUsrSetg    Speichern der Spacheneinstellung          *
      *============================================================*
      *
     C     SetUsrSetg    BEGSR
      *
     C                   Callp     p_updUsrSg('*LANGUAGE': SET0004)
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
