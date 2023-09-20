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
     D xPgm            S                   like(r§pgm     )
     D xKey            S             10A
     D xPosF24         S                   like(r§int4    )
     D xFKeys          S                   like(r§fKeyDsp )
     D                                     dim(32)
     D xNbrOfKeys      S                   like(r§int4    )
      *
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
     D A1              S              1A            INZ(*BLANKS)
      *
     D R_MsgID         S              4A            INZ(*BLANKS)
     D R_Key           S                            LIKE(R§KEY  )  INZ(*BLANKS)
     D R_PosF24        S                            LIKE(XPosF24)  INZ(*ZEROS)
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
     C     *ENTRY        Plist
     C                   Parm                    xPgm
     C                   Parm                    xKey
     C                   Parm                    xPosF24
     C                   Parm                    xFKeys
     C                   Parm                    xNbrOfKeys
      *
      *----------------------------------------------------*
      *
     C                   EVAL      XFKeys(*) = *BLANKS
     C                   EVAL      XNbrOfKeys = *ZEROS
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
     C                   EVAL      R_PosF24 = XPosF24
      *
      *  Hilfetaste
     C                   If        (xKey =  '*HELP')  or
     C                             (xKey =  '*ALL' )
     C                   Eval      Wrk_Sectn = '*' + xPgm
     C                   Callp     p_setllUsr(Wrk_Sectn: '*HELP')
     C                   Eval      lastKey = '*HELP'
     C                   Exsr      ReadKeyMap
     C                   Endif
      *
      *  Funktionstasten F1-F24
     C                   If        (xKey =  '*ALL' )  or
     C                             (xKey <> '*HELP')
     C                   Eval      Wrk_Sectn = '*' + xPgm
     C                   If        (xKey =  '*ALL' )
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
     C     XPosF24       OREQ      *ZEROS
      *            Pech gehabt ...
     C                   ELSE
      *
      *  Anzahl Seiten berechnen
     C     XNbrOfKeys    DIV       XPosF24       Y
     C     Y             MULT      XPosF24       X
     C     XNbrOfKeys    IFNE      X
     C                   EVAL      Y = Y + 1
     C                   Endif
     C                   MULT      XPosF24       Y
      *
     C     XPosF24       DO        Y             X
     C                   EVAL      wrk_MsgID = R_MsgID                                   R
     C                   EVAL      Wrk_Key = R_Key
     C                   EXSR      FillField
     C                   Enddo     XPosF24
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
     C                   If        (xKey    <> '*ALL')  and
     C                             (xKey    <> data  )
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
     C                   EVAL      XNbrOfKeys = XNbrOfKeys + 1
     C                   Endif
      *
      *  *MOREKEYS
     C     X             IFEQ      R_PosF24
      *  ... Platz reservieren
     C                   EVAL      X = X + 1
     C                   EVAL      XNbrOfKeys = XNbrOfKeys + 1
     C                   EVAL      R_PosF24 = R_PosF24 + XPosF24
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
     C                   Eval      XFKeys(X) = 'F1'
     C                   Other
     C     Wrk_Key       IFGE      '*F10'
     C                   EVAL      XFKeys(X) = %subst(Wrk_Key: 2)
     C                   ELSE
     C                   EVAL      A1 = %subst(Wrk_Key: 2: 1)
     C                   EVAL      XFKeys(X) = %subst(Wrk_Key: 4)
     C                   EVAL      XFKeys(X) = %trimr(A1) + XFKeys(X)
     C                   Endif
     C                   Endsl
      *
     C                   EVAL      XFKeys(X) =
     C                               %trimr(XFKeys(X)) + '=' + %trim(wrk_MsgTxt)
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
