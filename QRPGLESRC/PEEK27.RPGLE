      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK27                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 03.11.97  Raddatz                                 *
      *  geändert : 27.04.99  2.1.0                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Einlesen der Einzelauswahlen                                 *
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
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK27
      /undefine internal_prototype
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,MSG_D_MAPI
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
     D i               S                   like(r§int4    ) inz
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
     D Z               S                   like(r§int4    ) inz
      *
     D wrk_MsgID       S                   like(r§msgID   ) inz
     D wrk_MsgTxt      S                   like(r§msgDta  ) inz
     D Wrk_Key         S                   LIKE(R§KEY     )
     D                                     INZ
     D Wrk_Sectn       S                   LIKE(R§SECTION )
     D                                     INZ
     D data            S                   LIKE(R§SET0000 )
     D                                     INZ
     D pgmCmd          S                   LIKE(R§PGMCMD  )
     D                                     INZ
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK27          PI
     D  i_pgm                              const like(r§pgm)
     D  o_choices                                like(r§choice) dim(32)
     D  o_numChoices                             like(r§int4)
     D  o_exclKeys                         const like(r§pgmCmd) dim(25)
     D                                           options(*nopass)
      *
      *----------------------------------------------------*
      *
     C                   EVAL      o_choices(*) = *BLANKS
     C                   EVAL      o_numChoices = *ZEROS
      *
     C                   EXSR      GetKeyMap
      *
     C                   EVAL      *INLR = '1'
      *
      *============================================================*
      *    GetKeyMap     Einlesen der F-Tastenbelegung             *
      *============================================================*
      *
     C     GetKeyMap     BEGSR
      *
     C                   EVAL      X = 1
     C                   EVAL      o_numChoices = 1
      *
      *  Numerische-Auswahlen ...
     C                   EVAL      Wrk_Sectn = '*' + %trim(i_pgm)
     C                   EVAL      Wrk_Key = *BLANKS
     C                   EVAL      Wrk_Key = '0' + Wrk_Key
     C                   Callp     p_setllUsr(Wrk_Sectn: Wrk_Key)
      *
     C                   DO        *HIVAL
     C                   IF        f_readeUsr(Wrk_Sectn: Wrk_Key: data)= '1'
     C                   LEAVE
     C                   Endif
      *
      *  Überprüfen Auschlüsse
     C                   IF        %parms() >= %parmnum(o_exclKeys)
     C                   EVAL      pgmCmd = data
     C                   EVAL      i = %lookup(pgmCmd: o_exclKeys)
     C                   IF        i > 0
     C                   ITER
     C                   ENDIF
     C                   ENDIF
      *
     C                   EXSR      BuildStr
     C     X             IFGT      32
      *          Fertig, Tabelle ist voll
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
      *  String-Auswahlen ...
     C                   EVAL      Wrk_Sectn = '*' + %trim(i_pgm)
     C                   EVAL      Wrk_Key = *ALLx'FF'
     C                   EVAL      Wrk_Key = '*' + Wrk_Key
     C                   Callp     p_setllUsr(Wrk_Sectn: Wrk_Key)
      *
     C                   DO        *HIVAL
     C                   IF        f_readeUsr(Wrk_Sectn: Wrk_Key: data)= '1'
     C                   LEAVE
     C                   Endif
      *
      *  Numerische-Auswahlen, siehe oben ...
     C     Wrk_Key       IFGT      '0'
     C                   LEAVE
     C                   Endif
      *
     C                   EXSR      BuildStr
     C     X             IFGT      32
      *          Fertig, Tabelle ist voll
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    BuildStr      String zusammenbauen                      *
      *============================================================*
      *
     C     BuildStr      BEGSR
      *
     C                   EVAL      wrk_MsgID = *BLANKS
     C                   EVAL      wrk_MsgTxt = *BLANKS
      *
      /COPY QCOPYLE,MAPPCMDMSG
      *
     C     wrk_MsgID     IFNE      *BLANKS
     C                   Eval      wrk_MsgID = 'KEY' + %trim(wrk_MsgID)
     C                   Eval      wrk_MsgTxt = f_msgText(wrk_MsgID: ' ')
     C                   Endif
      *
      *  Stringlänge
     C                   EVAL      Z = %checkr(' ': wrk_MsgTxt)
      *  Für Auswahl und "="-Zeichen
     C                   EVAL      Z = Z + 3
      *  Für Trennleerraum ...
     C     o_choices(X)  IFNE      *BLANKS
     C                   EVAL      Z = Z + 2
     C                   Endif
      *
      *  Freie Länge
     C                   EVAL      Y = %checkr(' ': o_choices(X))
     C                   EVAL      Y = 63 - Y
     C     Y             IFLT      Z
     C                   EVAL      X = X + 1
     C                   EVAL      o_numChoices = o_numChoices + 1
     C                   Endif
      *
     C     X             IFGT      32
      *               Nix tun, Tabelle ist voll
     C                   ELSE
     C     o_choices(X)  IFEQ      *BLANKS
     C                   EVAL      o_choices(X) = %trimr(Wrk_Key)
     C                   ELSE
     C                   Eval      o_choices(X) = %trimr(o_choices(X)) +
     C                                         '  ' + %trimr(Wrk_Key)
     C                   Endif
     C                   Eval      o_choices(X) = %trimr(o_choices(X)) +
     C                                         '=' + %trim(wrk_MsgTxt)
     C                   Endif
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
