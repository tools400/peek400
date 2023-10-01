      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK32                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 26.11.97  Raddatz                                 *
      *  geändert : 27.04.99  2.1.0                                   *
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
      /define internal_prototype
      /COPY QCOPYLE,PPEEK32
      /undefine internal_prototype
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
      *  Arbeitsfelder
     D X               S                   like(int4_t) inz
     D pBuffer         S               *   inz
     D char            S              1A   based(pChar)
      *
      /COPY QCOPYLE,F_PEEK53
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK32          PI
     D  io_buffer                                likeds(rcdBuffer_t)
     D  i_buffLen                          const like(int4_t)
     D  i_ccsid                            const like(int4_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
      *----------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
      *
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
      *    Zeichen mit einer DOUBLE BYTE CCSID, wie 1200 oder 13488
      *    können zur Zeit nicht geprüft werden.
     C                   If        (i_ccsid <> 0)
     C                   Exsr      check_ucs2
     C                   Else
     C                   Exsr      check_sbcs
     C                   Endif
      *
     C                   RETURN
      *
      *============================================================*
      *    Prüfen UCS2 Zeichenkette auf ungültige Zeichen          *
      *============================================================*
      *
     C     check_ucs2    BEGSR
      *
      *      DBCS Zeichen lassen sich zur Zeit nicht prüfen.
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prüfen SBCS Zeichenkette auf ungültige Zeichen          *
      *============================================================*
      *
     C     check_sbcs    BEGSR
      *
     C                   EVAL      pBuffer = %addr(io_buffer)
      *
     C     1             DO        i_buffLen     X
     C                   EVAL      pChar = pBuffer + (x-1)
     C                   IF        (char < x'40' or char = x'FF')
     C                   EVAL      char = SET_CVTC
     C                   EVAL      o_msgID = 'USR8163'
     C                   EVAL      USR81631 = SET_CVTC
     C                   EVAL      o_msgDta = USR8163
     C                   ELSE
      *           Zeichen beibehalten
     C                   Endif
     C                   Enddo
      *
     C                   ENDSR
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
     C                   EXSR      GetUsrSetg
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
