      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK053                                           *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 27.04.99  Raddatz                                 *
      *  geändert : 27.04.99  2.1.0                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Zugriff auf Benutzerdaten                         *
      *                                                               *
      *===============================================================*
     H NOMAIN
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEKUSR   UF A E           K DISK    USROPN
     F                                     PREFIX(S_)
     F                                     INFDS(File_00_DS)
     F                                     EXTFILE(g_peekusr)
      *
     FDEFAULT   IF   E           K DISK    USROPN
     F                                     EXTDESC('PEEKUSR')
     F                                     RENAME(FPEEKUSR: FDEFAULT)
     F                                     PREFIX(D_)
     F                                     INFDS(File_01_DS)
     F                                     EXTFILE(g_default)
      *
     D File_00_DS      DS                  likeds(r§infds)
     D File_01_DS      DS                  likeds(r§infds)
      *
     D g_peekusr       S             21A
     D g_default       S             21A
      *
      *-------------------------------------------------------------------*
     D g_isInit        S                   like(r§bool) inz(bFalse)
     D g_user          S                   like(r§user) inz
     D g_file          S                   like(r§file) inz
     D g_lib           S                   like(r§lib ) inz
      *
      *-------------------------------------------------------------------*
     D f_initUsrS      PR                         like(R§SET0000 )
     D  i_key                              const  like(R§KEY     )
      *
      *----------------------------------------------------*
     D p_opnFile       PR
     D  o_msgID                       7A
     D  o_msgDta                    512A
      *
      *----------------------------------------------------*
     D p_opnDft        PR
     D  o_msgID                       7A
     D  o_msgDta                    512A
      *
      *----------------------------------------------------*
     D p_initSrvPgm    PR
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_INFDS
      *----------------------------------------------------*
      *
      *---Farbattribute------------------------------------*
      /COPY QCOPYLE,D_COLORATR
      *----------------------------------------------------*
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0000
      /COPY QCOPYLE,SET0001
      /COPY QCOPYLE,SET0002
      /COPY QCOPYLE,SET0003
      /COPY QCOPYLE,SET0004
      /COPY QCOPYLE,SET0005
      /COPY QCOPYLE,SET0006
      /COPY QCOPYLE,SET0007
      /COPY QCOPYLE,SET0008
      /COPY QCOPYLE,SET0009
      /COPY QCOPYLE,SET0010
      /COPY QCOPYLE,SET0011
      /COPY QCOPYLE,SET0012
      /COPY QCOPYLE,SET0013
      /COPY QCOPYLE,SET0014
      /COPY QCOPYLE,SET0015
      /COPY QCOPYLE,SET0016
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
     D PEEK22          S                   like(r§pgmCallN) inz
      *
      *  Peek22
     D YMode           S             10A
     D YSection        S             10A
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKUSR
     C     U_KEY3        KLIST
     C                   KFLD                    S_User
     C                   KFLD                    S_Section
     C                   KFLD                    S_Key
      *
     C     U_KEY2        KLIST
     C                   KFLD                    S_User
     C                   KFLD                    S_Section
      *
      *----------------------------------------------------*
      *  Schlüsselliste für DEFAULT
     C     D_KEY3        KLIST
     C                   KFLD                    D_User
     C                   KFLD                    D_Section
     C                   KFLD                    D_Key
      *
     C     D_KEY2        KLIST
     C                   KFLD                    D_User
     C                   KFLD                    D_Section
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK22
     C     P_Peek22      PLIST
     C                   PARM                    YMode
     C                   PARM                    YSection
      *----------------------------------------------------*
      *
      *===================================================================*
      *  Prozedur:  p_crtUsrSg                                 (Body)     *
      *===================================================================*
      *
     P p_crtUsrSg      B                   Export
      *
      *  definieren Procedure Interface ...
     D p_crtUsrSg      PI
     D  i_prodLib                          const  like(r§lib     )
     D  i_user                             const  like(r§user    )
     D  o_msgID                                   like(r§msgID   )
     D  o_msgDta                                  like(r§msgDta  )
      *
      *  definieren Arbeitsfelder
     D  cmd            S            256A   inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Eval      cmd = 'CRTDUPOBJ -
     C                                    OBJ(PEEKUSR) +
     C                                    FROMLIB(' + i_prodLib + ') +
     C                                    OBJTYPE(*FILE) +
     C                                    TOLIB(*FROMLIB) +
     C                                    NEWOBJ(' + i_user + ') +
     C                                    DATA(*NO)'
      *
     C                   Callp     f_execute(cmd     :
     C                                       o_msgID :
     C                                       o_msgDta)
      *
     C                   Eval      cmd = 'CHKOBJ -
     C                                    OBJ(' + %trim(i_prodLib) +
     C                                                  '/PEEKUSR) +
     C                                    OBJTYPE(*FILE) +
     C                                    MBR(*NONE) +
     C                                    AUT(*ALL)'
      *
     C                   Callp     f_execute(cmd     :
     C                                       o_msgID :
     C                                       o_msgDta)
      *
      *
     C                   Return
      *
     P p_crtUsrSg      E
      *
      *===================================================================*
      *  Prozedur:  f_getUsrSg                                 (Body)     *
      *===================================================================*
      *
     P f_getUsrSg      B                   Export
      *
      *  definieren Procedure Interface ...
     D f_getUsrSg      PI                         like(R§SET0000 )
     D  i_key                              const  like(R§KEY     )
     D  o_msgID                       7A   options(*NOPASS)
     D  o_msgDta                    512A   options(*NOPASS)
      *
      *  definieren Funktionswert ...
     D f_getUsrSg      S                   like(R§SET0000 )
     D                                     inz
      *
      *  Hilfsfelder für optionale Parameter ...
     D o2_msgID        S                   like(o_msgID   )
     D                                     inz
     D o3_msgDta       S                   like(o_msgDta  )
     D                                     inz
      *
      *  definieren Arbeitsfelder ...
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Callp     p_opnFile(o2_msgID: o3_msgDta)
     C                   If        o2_msgID = ' '
      *
     C                   Movel (P) g_user        S_User
     C                   Movel (P) '*PGM'        S_Section
     C                   Movel (P) i_key         S_Key
     C     U_Key3        Chain     FPEEKUSR                           11
     C                   If        *IN11 = *OFF
     C                   Eval      SET0000 = f_initUsrS(i_key)
     C                   Exsr      chkUsrSetg
     C                   Update    FPEEKUSR
     C                   Else
     C                   Eval      S_Data  = f_initUsrS(i_key)
     C                   Write     FPEEKUSR
     C                   Endif
      *
     C                   Eval      f_getUsrSg = S_Data
      *
     C                   Endif
      *
      *  Füllen optionale Rückgabeparameter ...
     C                   If        %parms >= 2
     C                   Eval      o_msgID = o2_msgID
     C                   Endif
      *
     C                   If        %parms >= 3
     C                   Eval      o_msgDta = o3_msgDta
     C                   Endif
      *
     C                   Return    f_getUsrSg
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,CHKUSRSETG
      *----------------------------------------------------*
      *
     P f_getUsrSg      E
      *
      *===================================================================*
      *  Prozedur:  p_updUsrSg                                 (Body)     *
      *===================================================================*
      *
     P p_updUsrSg      B                   Export
      *
      *  definieren Procedure Interface ...
     D p_updUsrSg      PI
     D  i_key                              const  like(R§KEY     )
     D  i_data                             const  like(R§SET0000 )
      *
      *  definieren Arbeitsfelder
     D  msgID          S              7A   inz
     D  msgDta         S            512A   inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Callp     p_opnFile(msgID: msgDta)
      *
     C                   Movel (P) g_user        S_User
     C                   Movel (P) '*PGM'        S_Section
     C                   Movel (P) i_key         S_Key
     C     U_Key3        Chain     FPEEKUSR                           11
     C                   If        *IN11 = *OFF
     C                   Eval      S_Data = i_data
     C                   Update    FPEEKUSR
     C                   Endif
      *
     C                   Return
      *
     P p_updUsrSg      E
      *
      *===================================================================*
      *  Prozedur:  f_chainUsr                                 (Body)     *
      *===================================================================*
      *
     P f_chainUsr      B                   Export
      *
      *  definieren Procedure Interface ...
     D f_chainUsr      PI                         like(R§BOOL    )
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
     D  o_data                                    like(R§SET0000 )
      *
      *  definieren Funktionswert ...
     D f_chainUsr      S                   like(R§BOOL    )
     D                                     inz
      *  definieren Arbeitsfelder
     D  msgID          S              7A   inz
     D  msgDta         S            512A   inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Clear                   S_Data
      *
     C                   Callp     p_opnFile(msgID: msgDta)
     C                   If        msgID = ' '
     C                   Movel (P) g_user        S_User
     C                   Movel (P) i_section     S_Section
     C                   Movel (P) i_key         S_Key
     C     U_Key3        Chain (N) FPEEKUSR                           11
     C                   IF        *IN11 = *OFF
     C                   Eval      f_chainUsr = '0'
     C                   Else
     C                   Eval      f_chainUsr = '1'
     C                   Endif
     C                   Else
     C                   Eval      f_chainUsr = '1'
     C                   Endif
      *
     C                   Eval      o_data = S_Data
      *
     C                   Return    f_chainUsr
      *
     P f_chainUsr      E
      *
      *===================================================================*
      *  Prozedur:  f_updatUsr                                 (Body)     *
      *===================================================================*
      *
     P f_updatUsr      B                   Export
      *
      *  definieren Procedure Interface ...
     D f_updatUsr      PI                         like(R§BOOL    )
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
     D  i_data                             const  like(R§SET0000 )
      *
      *  definieren Funktionswert ...
     D f_updatUsr      S                   like(R§BOOL    )
     D                                     inz
      *
      *  definieren Arbeitsfelder
     D  msgID          S              7A   inz
     D  msgDta         S            512A   inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Callp     p_opnFile(msgID: msgDta)
      *
     C                   If        msgID = ' '
     C                   Movel (P) g_user        S_User
     C                   Movel (P) i_section     S_Section
     C                   Movel (P) i_key         S_Key
     C     U_Key3        Chain     FPEEKUSR                           11
     C                   If        *IN11 = *OFF
     C                   Eval      S_Data = i_data
     C                   Update    FPEEKUSR                             11
     C                   If        *IN11 = *ON
     C                   Eval      f_updatUsr = bFalse
     C                   else
     C                   Eval      f_updatUsr = bTrue
     C                   Endif
     C                   Else
     C                   Eval      f_updatUsr = bFalse
     C                   Endif
     C                   Else
     C                   Eval      f_updatUsr = bFalse
     C                   Endif
      *
     C                   Return    f_updatUsr
      *
     P f_updatUsr      E
      *
      *===================================================================*
      *  Prozedur:  f_deletUsr                                 (Body)     *
      *===================================================================*
      *
     P f_deletUsr      B                   Export
      *
      *  definieren Procedure Interface ...
     D f_deletUsr      PI                         like(R§BOOL    )
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
      *
      *  definieren Funktionswert ...
     D f_deletUsr      S                   like(R§BOOL    )
     D                                     inz
      *  definieren Arbeitsfelder
     D  msgID          S              7A   inz
     D  msgDta         S            512A   inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Callp     p_opnFile(msgID: msgDta)
      *
     C                   If        msgID = ' '
     C                   Movel (P) g_user        S_User
     C                   Movel (P) i_section     S_Section
     C                   Movel (P) i_key         S_Key
     C     U_Key3        Chain     FPEEKUSR                           11
     C                   IF        *IN11 = *OFF
     C                   Delete    FPEEKUSR                             11
     C                   If        *IN11 = *ON
     C                   Eval      f_deletUsr = bFalse
     C                   else
     C                   Eval      f_deletUsr = bTrue
     C                   Endif
     C                   Else
     C                   Eval      f_deletUsr = bFalse
     C                   Endif
     C                   Else
     C                   Eval      f_deletUsr = bFalse
     C                   Endif
      *
     C                   Return    f_deletUsr
      *
     P f_deletUsr      E
      *
      *===================================================================*
      *  Prozedur:  f_writeUsr                                 (Body)     *
      *===================================================================*
      *
     P f_writeUsr      B                   Export
      *
      *  definieren Procedure Interface ...
     D f_writeUsr      PI                         like(R§BOOL    )
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
     D  i_data                                    like(R§SET0000 )
      *
      *  definieren Funktionswert ...
     D f_writeUsr      S                   like(R§BOOL    )
     D                                     inz
      *  definieren Arbeitsfelder
     D  msgID          S              7A   inz
     D  msgDta         S            512A   inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Callp     p_opnFile(msgID: msgDta)
      *
     C                   If        msgID = ' '
     C                   Movel (P) g_user        S_User
     C                   Movel (P) i_section     S_Section
     C                   Movel (P) i_key         S_Key
     C                   Movel (P) i_data        S_Data
     C                   Write     FPEEKUSR                             11
     C                   If        *IN11 = *ON
     C                   Eval      f_writeUsr = bFalse
     C                   else
     C                   Eval      f_writeUsr = bTrue
     C                   Endif
     C                   Else
     C                   Eval      f_writeUsr = bFalse
     C                   Endif
      *
     C                   Return    f_writeUsr
      *
     P f_writeUsr      E
      *
      *===================================================================*
      *  Prozedur:  p_setllUsr                                 (Body)     *
      *===================================================================*
      *
     P p_setllUsr      B                   Export
      *
      *  definieren Procedure Interface ...
     D p_setllUsr      PI
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
     D                                     options(*NOPASS)
      *
      *  definieren Arbeitsfelder
     D  msgID          S              7A   inz
     D  msgDta         S            512A   inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Callp     p_opnFile(msgID: msgDta)
     C                   If        msgID = ' '
     C                   Movel (P) g_user        S_User
      *
     C                   If        %parms >= 2
     C                   Movel (P) i_section     S_Section
     C                   Movel (P) i_key         S_Key
     C     U_Key3        Setll     FPEEKUSR
     C                   Else
     C                   Movel (P) i_section     S_Section
     C     U_Key2        Setll     FPEEKUSR
     C                   Endif
      *
     C                   Endif
      *
     C                   Return
      *
     P p_setllUsr      E
      *
      *===================================================================*
      *  Prozedur:  p_setgtUsr                                 (Body)     *
      *===================================================================*
      *
     P p_setgtUsr      B                   Export
      *
      *  definieren Procedure Interface ...
     D p_setgtUsr      PI
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
     D                                     options(*NOPASS)
      *
      *  definieren Arbeitsfelder
     D  msgID          S              7A   inz
     D  msgDta         S            512A   inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Callp     p_opnFile(msgID: msgDta)
     C                   If        msgID = ' '
     C                   Movel (P) g_user        S_User
      *
     C                   If        %parms >= 2
     C                   Movel (P) i_section     S_Section
     C                   Movel (P) i_key         S_Key
     C     U_Key3        Setgt     FPEEKUSR
     C                   Else
     C                   Movel (P) i_section     S_Section
     C     U_Key2        Setgt     FPEEKUSR
     C                   Endif
      *
     C                   Endif
      *
     C                   Return
      *
     P p_setgtUsr      E
      *
      *===================================================================*
      *  Prozedur:  f_readeUsr                                 (Body)     *
      *===================================================================*
      *
     P f_readeUsr      B                   Export
      *
      *  definieren Procedure Interface ...
     D f_readeUsr      PI                         like(R§BOOL    )
     D  i_section                          const  like(R§SECTION )
     D  o_key                                     like(R§KEY     )
     D                                            options(*NOPASS)
     D  o_data                                    like(R§SET0000 )
     D                                            options(*NOPASS)
      *
      *  definieren Funktionswert ...
     D f_readeUsr      S                   like(R§BOOL    )
     D                                     inz
      *
      *  definieren Hilfsfelder für optionale Parameter ...
     D o2_key          S                   like(R§KEY     )
     D                                     inz
     D o3_data         S                   like(R§SET0000 )
     D                                     inz
      *
      *  definieren Arbeitsfelder
     D  msgID          S              7A   inz
     D  msgDta         S            512A   inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Clear                   S_Key
     C                   Clear                   S_Data
      *
     C                   Callp     p_opnFile(msgID: msgDta)
     C                   If        msgID = ' '
     C                   Movel (P) g_user        S_User
     C                   Movel (P) i_section     S_Section
     C     U_Key2        Reade (N) FPEEKUSR                               11
     C                   IF        *IN11 = *OFF
     C                   Eval      f_readeUsr = '0'
     C                   Else
     C                   Eval      f_readeUsr = '1'
     C                   Endif
     C                   Else
     C                   Eval      f_readeUsr = '1'
     C                   Endif
      *
     C                   Eval      o2_key  = S_Key
     C                   Eval      o3_data = S_Data
      *
      *  Füllen optionale Rückgabeparameter ...
     C                   If        %parms >= 2
     C                   Eval      o_key   = o2_key
     C                   Endif
      *
     C                   If        %parms >= 3
     C                   Eval      o_data  = o3_data
     C                   Endif
      *
     C                   Return    f_readeUsr
      *
     P f_readeUsr      E
      *
      *===================================================================*
      *  Prozedur:  p_setllDft                                 (Body)     *
      *===================================================================*
      *
     P p_setllDft      B                   Export
      *
      *  definieren Procedure Interface ...
     D p_setllDft      PI
     D  i_section                          const  like(R§SECTION )
     D  i_key                              const  like(R§KEY     )
     D                                     options(*NOPASS)
      *
      *  definieren Arbeitsfelder
     D  msgID          S              7A   inz
     D  msgDta         S            512A   inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Callp     p_opnDft(msgID: msgDta)
     C                   If        msgID = ' '
      *
     C                   Movel (P) '*NONE'       D_User
     C                   Movel (P) i_section     D_Section
     C                   Movel (P) i_key         D_Key
     C                   If        %parms >= 2
     C     D_Key3        Setll     FDEFAULT
     C                   Else
     C     D_Key2        Setll     FDEFAULT
     C                   Endif
      *
     C                   Endif
      *
     C                   Return
      *
     P p_setllDft      E
      *
      *===================================================================*
      *  Prozedur:  f_readeDft                                 (Body)     *
      *===================================================================*
      *
     P f_readeDft      B                   Export
      *
      *  definieren Procedure Interface ...
     D f_readeDft      PI                         like(R§BOOL    )
     D  i_section                          const  like(R§SECTION )
     D  o_key                                     like(R§KEY     )
     D                                            options(*NOPASS)
     D  o_data                                    like(R§SET0000 )
     D                                            options(*NOPASS)
      *
      *  definieren Funktionswert ...
     D f_readeDft      S                   like(R§BOOL    )
     D                                     inz
      *
      *  definieren Hilfsfelder für optionale Parameter ...
     D o2_key          S                   like(R§KEY     )
     D                                     inz
     D o3_data         S                   like(R§SET0000 )
     D                                     inz
      *
      *  definieren Arbeitsfelder
     D  msgID          S              7A   inz
     D  msgDta         S            512A   inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Clear                   D_Key
     C                   Clear                   D_Data
      *
     C                   Callp     p_opnDft(msgID: msgDta)
     C                   If        msgID = ' '
      *
     C                   Movel (P) '*NONE'       D_User
     C                   Movel (P) i_section     D_Section
     C     D_Key2        Reade (N) FDEFAULT                               11
     C                   IF        *IN11 = *OFF
     C                   Eval      f_readeDft = '0'
     C                   Else
     C                   Eval      f_readeDft = '1'
     C                   Endif
     C                   Else
     C                   Eval      f_readeDft = '1'
     C                   Endif
      *
     C                   Eval      o2_key  = D_Key
     C                   Eval      o3_data = D_Data
      *
      *  Füllen optionale Rückgabeparameter ...
     C                   If        %parms >= 2
     C                   Eval      o_key   = o2_key
     C                   Endif
      *
     C                   If        %parms >= 3
     C                   Eval      o_data  = o3_data
     C                   Endif
      *
     C                   Return    f_readeDft
      *
     P f_readeDft      E
      *
      *===================================================================*
      *  Prozedur:  p_setUsr                                   (Body)     *
      *===================================================================*
      *
     P p_setUsr        B                   Export
      *
      *  definieren Procedure Interface ...
     D p_setUsr        PI
     D  i_user                             const  like(R§USER    )
     D  i_file                             const  like(R§FILE    )
     D  i_lib                              const  like(R§LIB     )
      * ------------------------------------------------------------------------
      *
     C                   Eval      g_user = i_user
     C                   Eval      g_file = i_file
     C                   Eval      g_lib  = i_lib
      *
     C                   Return
      *
     P p_setUsr        E
      *
      *===================================================================*
      *  Prozedur:  f_getUsr                                   (Body)     *
      *===================================================================*
      *
     P f_getUsr        B                   Export
      *
      *  definieren Procedure Interface ...
     D f_getUsr        PI                         like(R§USER    )
     D  o_file                                    like(R§FILE    )
     D  o_lib                                     like(R§LIB     )
      * ------------------------------------------------------------------------
      *
     C                   Eval      o_file = g_file
     C                   Eval      o_lib  = g_lib
      *
     C                   Return    g_user
      *
     P f_getUsr        E
    R *
    R *===================================================================*
    R *  Prozedur:  f_initUsrS                                 (Body)     *
    R *===================================================================*
    R *
     P f_initUsrS      B
      *
      *  definieren Procedure Interface ...
     D f_initUsrS      PI                         like(R§SET0000 )
     D  i_key                              const  like(R§KEY     )
      *
      *  definieren Funktionswert ...
     D f_initUsrS      S                   like(R§SET0000 )
     D                                     inz
      * ------------------------------------------------------------------------
      *
     C                   Select
      *  SET0001 ...
     C                   When      i_key = '*DSPATTR'
     C                   Eval      f_initUsrS = SET0001
      *  SET0002 ...
     C                   When      i_key = '*SEARCH'
     C                   Eval      f_initUsrS = SET0002
      *  SET0003 ...
     C                   When      i_key = '*ACCESSKEY'
     C                   Eval      f_initUsrS = SET0003
      *  SET0004 ...
     C                   When      i_key = '*LANGUAGE'
     C                   Eval      f_initUsrS = SET0004
      *  SET0005 ...
     C                   When      i_key = '*SPLASH'
     C                   Eval      f_initUsrS = SET0005
      *  SET0006 ...
     C                   When      i_key = '*CVTCHR'
     C                   Eval      f_initUsrS = SET0006
      *  SET0007 ...
     C                   When      i_key = '*VERSION'
     C                   Eval      f_initUsrS = SET0007
      *  SET0008 ...
     C                   When      i_key = '*PROMPT'
     C                   Eval      f_initUsrS = SET0008
      *  SET0009 ...
     C                   When      i_key = '*FLOATKEYS'
     C                   Eval      f_initUsrS = SET0009
      *  SET0010 ...
     C                   When      i_key = '*SCROLL'
     C                   Eval      f_initUsrS = SET0010
      *  SET0011 ...
     C                   When      i_key = '*DFTDSPMDE'
     C                   Eval      f_initUsrS = SET0011
      *  SET0012 ...
     C                   When      i_key = '*CRTPGM'
     C                   Eval      f_initUsrS = SET0012
      *  SET0013 ...
     C                   When      i_key = '*SECATRDFT'
     C                   Eval      f_initUsrS = SET0013
      *  SET0014 ...
     C                   When      i_key = '*PRVFILE'
     C                   Eval      f_initUsrS = SET0014
      *  SET0015 ...
     C                   When      i_key = '*ENVFILE'
     C                   Eval      f_initUsrS = SET0015
      *  SET0016 ...
     C                   When      i_key = '*SQLLMTCNT'
     C                   Eval      f_initUsrS = SET0016
      *  Fehler ...
     C                   Other
     C                   Eval      §msgID  = 'USR9999'
     C                   Eval      §msgDta = 'PEEK53, f_initUsrS, i_key: '
     C                                       + i_key
     C                   Callp     p_sndPgmMg(§msgID    : §msgDta  :
     C                                        §§pgmName : '*ESCAPE')
     C                   Endsl
      *
     C                   Return    f_initUsrS
      *
     P f_initUsrS      E
    R *
    R *===================================================================*
    R *  Prozedur:  p_opnFile                                  (Body)     *
    R *===================================================================*
    R *
     P p_opnFile       B
      *
      *  definieren Procedure Interface ...
     D p_opnFile       PI
     D  o_msgID                       7A
     D  o_msgDta                    512A
      * ------------------------------------------------------------------------
      *
      *  Öffnen Datei PEEKUSR ...
     C                   If        File_00_DS.Open <> '1'
      *
     C                   Eval      g_peekusr = %trim(g_lib) + '/' +
     C                                         %trim(g_file)
      *
     C                   Open      PEEKUSR                              99
     C                   If        *IN99 = '1'
     C                   Eval      o_msgID  = 'CPF9897'
     C                   Eval      o_msgDta = §§MsgText
     C                   Else
      *
     C                   If        f_chainUsr('*PGM': '*VERSION': set0000) = '1'
     C                   Eval      YMode    = '*REPLACE'
     C                   Eval      YSection = '*ALL'
     C                   Call      PEEK22        P_Peek22
     C                   Endif
      *
     C                   Eval      o_msgID  = ' '
     C                   Eval      o_msgDta = ' '
     C                   Endif
      *
     C                   Else
     C                   Eval      o_msgID  = ' '
     C                   Eval      o_msgDta = ' '
     C                   Endif
      *
     C                   Return
      *
     P p_opnFile       E
    R *
    R *===================================================================*
    R *  Prozedur:  p_opnDft                                   (Body)     *
    R *===================================================================*
    R *
     P p_opnDft        B
      *
      *  definieren Procedure Interface ...
     D p_opnDft        PI
     D  o_msgID                       7A
     D  o_msgDta                    512A
      * ------------------------------------------------------------------------
      *
      *  Öffnen Datei DEFAULT (PEEKUSR) ...
     C                   If        File_01_DS.Open <> '1'
      *
     C                   Eval      g_default = %trim(f_getPrdLb()) + '/' +
     C                                         'PEEKUSR'
      *
     C                   Open      DEFAULT                              99
     C                   If        *IN99 = '1'
     C                   Eval      o_msgID  = 'CPF9897'
     C                   Eval      o_msgDta = §§MsgText
     C                   Else
     C                   Eval      o_msgID  = ' '
     C                   Eval      o_msgDta = ' '
     C                   Endif
      *
     C                   Else
     C                   Eval      o_msgID  = ' '
     C                   Eval      o_msgDta = ' '
     C                   Endif
      *
     C                   Return
      *
     P p_opnDft        E
    R *
    R *===================================================================*
    R *  Prozedur:  p_initSrvPgm                               (Body)     *
    R *===================================================================*
    R *
     P p_initSrvPgm    B
      *
      *  definieren Procedure Interface ...
     D p_initSrvPgm    PI
      * ------------------------------------------------------------------------
      *
     C                   If        g_isInit = bFalse
      *
     C                   If        g_user = ''
     C                   Callp     p_setUsr(§§User: §§User: f_getPrdLb())
     C                   Endif
      *
     C                   Eval      PEEK22 = f_pgmCallN('PEEK22')
      *
     C                   Eval      g_isInit = bTrue
     C                   Endif
      *
     C                   Return
      *
     P p_initSrvPgm    E
      *
