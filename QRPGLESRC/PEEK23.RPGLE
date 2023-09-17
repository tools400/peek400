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
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
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
     C                   MOVEA (P) *BLANKS       XFKeys
     C                   Z-ADD     *ZEROS        XNbrOfKeys
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
     C                   Z-ADD     1             X
     C                   MOVEL (P) *BLANKS       R_MsgID
     C                   MOVEL (P) *BLANKS       R_Key
     C                   Z-ADD     XPosF24       R_PosF24
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
     C                   ADD       1             Y
     C                   Endif
     C                   MULT      XPosF24       Y
      *
     C     XPosF24       DO        Y             X
     C                   MOVEL (P) R_MsgID       wrk_MsgID                                   R
     C                   MOVEL (P) R_Key         Wrk_Key
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
     C                   MOVEL (P) *BLANKS       wrk_MsgID
     C                   MOVEL (P) *BLANKS       wrk_MsgTxt
      *
      /COPY QCOPYLE,MAPPCMDMSG
      *
     C     Data          IFEQ      '*MOREKEYS'
     C                   MOVEL (P) wrk_MsgID     R_MsgID
     C                   MOVEL (P) Wrk_Key       R_Key
     C                   ELSE
      *
     C                   EXSR      FillField
     C                   ADD       1             X
     C                   ADD       1             XNbrOfKeys
     C                   Endif
      *
      *  *MOREKEYS
     C     X             IFEQ      R_PosF24
      *  ... Platz reservieren
     C                   ADD       1             X
     C                   ADD       1             XNbrOfKeys
     C                   ADD       XPosF24       R_PosF24
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
     C                   MOVEL (P) *ALL'?'       wrk_MsgTxt
     C                   ELSE
     C     'KEY'         CAT   (P) wrk_MsgID:0   wrk_MsgID
     C                   Eval      wrk_MsgTxt = f_msgText(wrk_MsgID: ' ')
     C                   Endif
      *
     C                   Select
     C                   When      Wrk_Key   = '*HELP'
     C                   Eval      XFKeys(X) = 'F1'
     C                   Other
     C     Wrk_Key       IFGE      '*F10'
     C                   SUBST (P) Wrk_Key:2     XFKeys(X)
     C                   ELSE
     C     1             SUBST (P) Wrk_Key:2     A1
     C                   SUBST (P) Wrk_Key:4     XFKeys(X)
     C     A1            CAT   (P) XFKeys(X)     XFKeys(X)
     C                   Endif
     C                   Endsl
      *
     C                   CAT       '=':0         XFKeys(X)
     C                   CAT       wrk_MsgTxt:0  XFKeys(X)
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
