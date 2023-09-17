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
     D XPgm            S             10A
     D XFKeys          S             75A   DIM(32)
     D XNbrOfKeys      S                   like(r§int4    )
     D XExclKeys       S                   like(r§pgmCmd  ) DIM(25)
      *
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
     C     *ENTRY        PLIST
     C                   PARM                    XPgm
     C                   PARM                    XFKeys
     C                   PARM                    XNbrOfKeys
     C                   PARM                    XExclKeys                      Optional Parm
      *
      *----------------------------------------------------*
      *
     C                   MOVEA (P) *BLANKS       XFKeys
     C                   Z-ADD     *ZEROS        XNbrOfKeys
      *
     C                   EXSR      GetKeyMap
      *
     C                   MOVEL (P) '1'           *INLR
      *
      *============================================================*
      *    GetKeyMap     Einlesen der F-Tastenbelegung             *
      *============================================================*
      *
     C     GetKeyMap     BEGSR
      *
     C                   Z-ADD     1             X
     C                   Z-ADD     1             XNbrOfKeys
      *
      *  Numerische-Auswahlen ...
     C     '*'           CAT   (P) XPgm:0        Wrk_Sectn
     C                   MOVEL (P) *BLANKS       Wrk_Key
     C                   MOVEL     '0'           Wrk_Key
     C                   Callp     p_setllUsr(Wrk_Sectn: Wrk_Key)
      *
     C                   DO        *HIVAL
     C                   IF        f_readeUsr(Wrk_Sectn: Wrk_Key: data)= '1'
     C                   LEAVE
     C                   Endif
      *
      *  Überprüfen Auschlüsse
     C                   IF        %PARMS >= 4
     C                   EVAL      pgmCmd = data
     C     pgmCmd        LOOKUP    XExclKeys                              01
     C                   IF        *IN01 = '1'
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
     C     '*'           CAT   (P) XPgm:0        Wrk_Sectn
     C                   MOVEL (P) *ALLx'FF'     Wrk_Key
     C                   MOVEL     '*'           Wrk_Key
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
     C                   MOVEL (P) *BLANKS       wrk_MsgID
     C                   MOVEL (P) *BLANKS       wrk_MsgTxt
      *
      /COPY QCOPYLE,MAPPCMDMSG
      *
     C     wrk_MsgID     IFNE      *BLANKS
     C     'KEY'         CAT   (P) wrk_MsgID:0   wrk_MsgID
     C                   Eval      wrk_MsgTxt = f_msgText(wrk_MsgID: ' ')
     C                   Endif
      *
      *  Stringlänge
     C     ' '           CHECKR    wrk_MsgTxt    Z
      *  Für Auswahl und "="-Zeichen
     C                   ADD       3             Z
      *  Für Trennleerraum ...
     C     XFKeys(X)     IFNE      *BLANKS
     C                   ADD       2             Z
     C                   Endif
      *
      *  Freie Länge
     C     ' '           CHECKR    XFKeys(X)     Y
     C     63            SUB       Y             Y
     C     Y             IFLT      Z
     C                   ADD       1             X
     C                   ADD       1             XNbrOfKeys
     C                   Endif
      *
     C     X             IFGT      32
      *               Nix tun, Tabelle ist voll
     C                   ELSE
     C     XFKeys(X)     IFEQ      *BLANKS
     C                   MOVEL (P) Wrk_Key       XFKeys(X)
     C                   ELSE
     C                   CAT       Wrk_Key:2     XFKeys(X)
     C                   Endif
     C                   CAT       '=':0         XFKeys(X)
     C                   CAT       wrk_MsgTxt:0  XFKeys(X)
     C                   Endif
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
