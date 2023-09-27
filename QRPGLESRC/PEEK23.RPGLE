      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK23                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 29.10.97  Raddatz                                 *
      *  geändert : 27.04.99  2.1.0                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Einlesen der F-Tastenbelegung                                *
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
      /COPY QCOPYLE,PPEEK23
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
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
     D A1              S              1A            INZ(*BLANKS)
      *
     D R_MsgID         S              4A            INZ(*BLANKS)
     D R_Key           S                            LIKE(R§KEY  )  INZ(*BLANKS)
     D R_PosF24        S                            LIKE(i_posF24)  INZ(*ZEROS)
      *
     D wrk_MsgID       S                   like(r§msgID   ) inz
     D wrk_MsgTxt      S                   like(r§msgDta  ) inz
     D Wrk_Key         S                   LIKE(R§KEY     )
     D                                     INZ
     D Wrk_Sectn       S                   LIKE(R§SECTION )
     D                                     INZ
     D data            S                   LIKE(R§SET0000 )
     D                                     INZ
      *
     D LastKey         S                   LIKE(R§KEY     )
     D                                     INZ
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK23          PI
     D  i_pgm                              const like(r§pgm)
     D  i_key                        10A   const
     D  i_posF24                           const like(r§int4)
     D  o_FKeys                                  like(r§fKeyDsp) dim(32)
     D  o_nbrOfKeys                              like(r§int4)
      *
      *----------------------------------------------------*
      *
     C                   EVAL      o_FKeys(*) = *BLANKS
     C                   EVAL      o_nbrOfKeys = *ZEROS
      *
     C                   EXSR      GetKeyMap
      *
     C                   RETURN
      *
      *============================================================*
      *    GetKeyMap     Einlesen der F-Tastenbelegung             *
      *============================================================*
      *
     C     GetKeyMap     BEGSR
      *
     C                   EVAL      X = 1
     C                   EVAL      R_MsgID = *BLANKS
     C                   EVAL      R_Key = *BLANKS
     C                   EVAL      R_PosF24 = i_posF24
      *
      *  Hilfetaste
     C                   If        (i_key =  '*HELP')  or
     C                             (i_key =  '*ALL' )
     C                   Eval      Wrk_Sectn = '*' + i_pgm
     C                   Callp     p_setllUsr(Wrk_Sectn: '*HELP')
     C                   Eval      lastKey = '*HELP'
     C                   Exsr      ReadKeyMap
     C                   Endif
      *
      *  Funktionstasten F1-F24
     C                   If        (i_key =  '*ALL' )  or
     C                             (i_key <> '*HELP')
     C                   Eval      Wrk_Sectn = '*' + i_pgm
     C                   If        (i_key =  '*ALL' )
     C                   Callp     p_setllUsr(Wrk_Sectn: '*F01' )
     C                   Eval      lastKey = '*F24'
     C                   Else
     C                   Callp     p_setllUsr(Wrk_Sectn: '*'    )
     C                   Eval      lastKey = *all'Z'
     C                   Endif
      *
     C                   Exsr      ReadKeyMap
      *
      *  *MOREKEYS
     C     R_MsgID       IFEQ      *BLANKS
     C     i_posF24      OREQ      *ZEROS
      *            Pech gehabt ...
     C                   ELSE
      *
      *  Anzahl Seiten berechnen
     C     o_nbrOfKeys   DIV       i_posF24      Y
     C     Y             MULT      i_posF24      X
     C     o_nbrOfKeys   IFNE      X
     C                   EVAL      Y = Y + 1
     C                   Endif
     C                   MULT      i_posF24      Y
      *
     C     i_posF24      DO        Y             X
     C                   EVAL      wrk_MsgID = R_MsgID                                   R
     C                   EVAL      Wrk_Key = R_Key
     C                   EXSR      FillField
     C                   Enddo     i_posF24
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ReadKeyMap    Einlesen der F-Tastenbelegung             *
      *============================================================*
      *
     C     ReadKeyMap    Begsr
      *
     C                   Do        *hival
     C                   If        f_readeUsr(Wrk_Sectn: Wrk_Key: data)= '1'
     C                   Leave
     C                   Endif
      *
     C                   If        Wrk_Key > lastKey
     C                   Leave
     C                   Endif
      *
     C                   If        (i_key    <> '*ALL')  and
     C                             (i_key    <> data  )
     C                   Iter
     C                   Endif
      *
     C                   EVAL      wrk_MsgID = *BLANKS
     C                   EVAL      wrk_MsgTxt = *BLANKS
      *
      /COPY QCOPYLE,MAPPCMDMSG
      *
     C     Data          IFEQ      '*MOREKEYS'
     C                   EVAL      R_MsgID = wrk_MsgID
     C                   EVAL      R_Key = Wrk_Key
     C                   ELSE
      *
     C                   EXSR      FillField
     C                   EVAL      X = X + 1
     C                   EVAL      o_nbrOfKeys = o_nbrOfKeys + 1
     C                   Endif
      *
      *  *MOREKEYS
     C     X             IFEQ      R_PosF24
      *  ... Platz reservieren
     C                   EVAL      X = X + 1
     C                   EVAL      o_nbrOfKeys = o_nbrOfKeys + 1
     C                   EVAL      R_PosF24 = R_PosF24 + i_posF24
     C                   Endif
      *
     C     X             IFGT      32
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    FillField                                               *
      *============================================================*
      *
     C     FillField     BEGSR
      *
     C     wrk_MsgID     IFEQ      *BLANKS
      *   Fehler ...
     C                   EVAL      wrk_MsgTxt = *ALL'?'
     C                   ELSE
     C                   Eval      wrk_MsgID = 'KEY' + %trim(wrk_MsgID)
     C                   Eval      wrk_MsgTxt = f_msgText(wrk_MsgID: ' ')
     C                   Endif
      *
     C                   Select
     C                   When      Wrk_Key   = '*HELP'
     C                   Eval      o_FKeys(X) = 'F1'
     C                   Other
     C     Wrk_Key       IFGE      '*F10'
     C                   EVAL      o_FKeys(X) = %subst(Wrk_Key: 2)
     C                   ELSE
     C                   EVAL      A1 = %subst(Wrk_Key: 2: 1)
     C                   EVAL      o_FKeys(X) = %subst(Wrk_Key: 4)
     C                   EVAL      o_FKeys(X) = %trimr(A1) + o_FKeys(X)
     C                   Endif
     C                   Endsl
      *
     C                   EVAL      o_FKeys(X) = %trimr(o_FKeys(X)) +
     C                                          '=' + %trim(wrk_MsgTxt)
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
