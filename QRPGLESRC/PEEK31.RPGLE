      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK31                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 13.11.97  Raddatz                                 *
      *  geändert : 27.04.99  2.1.0                                   *
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
      /define internal_prototype
      /COPY QCOPYLE,PPEEK31
      /undefine internal_prototype
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
      /COPY QCOPYLE,F_PEEK53
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK31          PI
     D  io_language                  10A
     D  i_prefix                     10A   const
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
      *----------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
      *  Ermitteln der zu verwendenden Sprache ...
     C     io_language   IFEQ      '*DFT'
      *  ... Standardsprache
     C                   EXSR      GetUsrSetg
     C                   ELSE
      *  ... Benutzen der übergebenen Sprache
     C                   EVAL      SET_Lang = io_language
     C                   Endif
      *
     C                   IF        o_msgID <> ' '
     C                   GOTO      ENDE
     C                   Endif
      *
      *  ... Prüfen der Nachrichtendatei
     C     1             DO        2
      *
     C                   EXSR      ChkMsgF
     C     §RETURN       IFEQ      '0'
      *      ... kein Fehler
     C                   LEAVE
     C                   ELSE
      *      ... Fehler aufgetreten
     C     SET_Lang      IFEQ      'GER'
      *          ... Standardsprache
     C                   Eval      o_msgID  = 'CPF9897'
     C                   Eval      o_msgDta = 'Sprachendefinition ''' +
     C                                       %trim(io_language) +
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
     C     o_msgID       IFEQ      *BLANKS
     C                   EXSR      SetUsrSetg
     C                   EVAL      io_language = SET_Lang
     C                   ELSE
      *            Fehler aufgetreten
     C                   EVAL      io_language = *BLANKS
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
     C                                                  o_msgID     :
     C                                                  o_msgDta    )
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkMsgF       Prüfen der Nachrichtendatei               *
      *============================================================*
      *
     C     ChkMsgF       BEGSR
      *
     C                   EVAL      §OBJ = %trimr(i_prefix) + SET_Lang
     C                   EVAL      §LIB = §§PgmLib
     C                   EVAL      §OBJTYPE = '*MSGF'
     C                   EVAL      §MBR = '*NONE'
     C                   EVAL      §AUT = '*NONE'
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
