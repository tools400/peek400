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
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
      *                           OBJLIB(&LI) DEVLIB(&LI) +           *
      *                           SBMJOB(*NO) BNDDIR(PEEK) +          *
      *                           INSTALL(*NO);                       *
      *   >>EXECUTE<<                                                 *
      * >>END-PRE-COMPILER<<                                          *
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
     D File_00_DS      DS                  likeds(infds_t)
     D File_01_DS      DS                  likeds(infds_t)
      *
     D g_peekusr       S             21A
     D g_default       S             21A
      *
      *-------------------------------------------------------------------*
     D g_isInit        S                   like(bool_t) inz(bFalse)
     D g_user          S                   like(user_t) inz
     D g_file          S                   like(file_t) inz
     D g_lib           S                   like(lib_t) inz
      *
      *-------------------------------------------------------------------*
     D f_initUsrS      PR                         like(SET0000_t)
     D  i_key                              const  like(KEY_t)
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
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_INFDS
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *---Farbattribute------------------------------------*
      /COPY QCOPYLE,D_COLORATR
      *----------------------------------------------------*
      *
      *---Benutzervoreinstellungen-------------------------*
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
     D PEEK22_NAME     S                   like(pgmCallN_t) inz
      *
      /COPY QCOPYLE,PPEEK22
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
      *
      *===================================================================*
      *  Prozedur:  p_crtUsrSg                                 (Body)     *
      *===================================================================*
      *
     P p_crtUsrSg      B                   Export
     D                 PI
     D  i_prodLib                          const  like(lib_t)
     D  i_user                             const  like(user_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
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
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_getUsrSg                                 (Body)     *
      *===================================================================*
      *
     P f_getUsrSg      B                   Export
     D                 PI                         like(SET0000_t)
     D  i_key                              const  like(KEY_t)
     D  o_msgID                       7A   options(*NOPASS)
     D  o_msgDta                    512A   options(*NOPASS)
      *
      *  definieren Funktionswert ...
     D f_getUsrSg      S                   like(SET0000_t)
     D                                     inz
      *
      *  Hilfsfelder für optionale Parameter ...
     D o2_msgID        S                   like(o_msgID)
     D                                     inz
     D o3_msgDta       S                   like(o_msgDta)
     D                                     inz
      *
      *  definieren Arbeitsfelder ...
     D X               S                   like(int4_t)
     D Y               S                   like(int4_t)
     D set0000         S                   like(set0000_t)
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Callp     p_opnFile(o2_msgID: o3_msgDta)
     C                   If        o2_msgID = ' '
      *
     C                   EVAL      S_User = g_user
     C                   EVAL      S_Section = '*PGM'
     C                   EVAL      S_Key = i_key
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
      * ---------------------------------------------------------- *
      *    ChkUsrSetg    Prüfen der Benutzervoreinstellungen       *
      *                  auf Aktualität                            *
      * ---------------------------------------------------------- *
      *
     C     ChkUsrSetg    BEGSR
      *
      *  Ende der alten Daten
     C                   EVAL      x = %scan(x'8B': S_Data: 1)
     C                   IF        (X = 0)
     C                   EVAL      x = %checkr(' ': S_Data)
     C                   ELSE
     C                   EVAL      x = x - 1
     C                   ENDIF
      *
      *  Ende der neuen Daten
     C                   EVAL      y = %scan(x'8B': SET0000: 1) - 1
      *
      *  Aktualisieren, wenn die neuen Daten
      *  länger als die "Altdaten" sind ...
     C                   IF        (Y > X)
      *  ... extrahieren alte Daten
     C                   EVAL      S_Data = %subst(S_Data: 1: x)
      *  ... extrahieren überhang der neuen Daten
     C                   EVAL      x = x + 1
     C                   EVAL      SET0000 = %subst(SET0000: x)
      *  ... zusammenfügen alt + neu
     C                   EVAL      %subst(S_Data: x) = SET0000
     C                   ENDIF
      *
     C                   ENDSR
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_updUsrSg                                 (Body)     *
      *===================================================================*
      *
     P p_updUsrSg      B                   Export
     D                 PI
     D  i_key                              const  like(KEY_t)
     D  i_data                             const  like(SET0000_t)
      *
      *  definieren Arbeitsfelder
     D  msgID          S              7A   inz
     D  msgDta         S            512A   inz
      * ------------------------------------------------------------------------
     C                   Callp     p_initSrvPgm
      *
     C                   Callp     p_opnFile(msgID: msgDta)
      *
     C                   EVAL      S_User = g_user
     C                   EVAL      S_Section = '*PGM'
     C                   EVAL      S_Key = i_key
     C     U_Key3        Chain     FPEEKUSR                           11
     C                   If        *IN11 = *OFF
     C                   Eval      S_Data = i_data
     C                   Update    FPEEKUSR
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_chainUsr                                 (Body)     *
      *===================================================================*
      *
     P f_chainUsr      B                   Export
     D                 PI                         like(BOOL_t)
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
     D  o_data                                    like(SET0000_t)
      *
      *  definieren Funktionswert ...
     D f_chainUsr      S                   like(BOOL_t)
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
     C                   EVAL      S_User = g_user
     C                   EVAL      S_Section = i_section
     C                   EVAL      S_Key = i_key
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
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_updatUsr                                 (Body)     *
      *===================================================================*
      *
     P f_updatUsr      B                   Export
     D                 PI                         like(BOOL_t)
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
     D  i_data                             const  like(SET0000_t)
      *
      *  definieren Funktionswert ...
     D f_updatUsr      S                   like(BOOL_t)
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
     C                   EVAL      S_User = g_user
     C                   EVAL      S_Section = i_section
     C                   EVAL      S_Key = i_key
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
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_deletUsr                                 (Body)     *
      *===================================================================*
      *
     P f_deletUsr      B                   Export
     D                 PI                         like(BOOL_t)
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
      *
      *  definieren Funktionswert ...
     D f_deletUsr      S                   like(BOOL_t)
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
     C                   EVAL      S_User = g_user
     C                   EVAL      S_Section = i_section
     C                   EVAL      S_Key = i_key
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
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_writeUsr                                 (Body)     *
      *===================================================================*
      *
     P f_writeUsr      B                   Export
     D                 PI                         like(BOOL_t)
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
     D  i_data                                    like(SET0000_t)
      *
      *  definieren Funktionswert ...
     D f_writeUsr      S                   like(BOOL_t)
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
     C                   EVAL      S_User = g_user
     C                   EVAL      S_Section = i_section
     C                   EVAL      S_Key = i_key
     C                   EVAL      S_Data = i_data
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
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_setllUsr                                 (Body)     *
      *===================================================================*
      *
     P p_setllUsr      B                   Export
     D                 PI
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
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
     C                   EVAL      S_User = g_user
      *
     C                   If        %parms >= 2
     C                   EVAL      S_Section = i_section
     C                   EVAL      S_Key = i_key
     C     U_Key3        Setll     FPEEKUSR
     C                   Else
     C                   EVAL      S_Section = i_section
     C     U_Key2        Setll     FPEEKUSR
     C                   Endif
      *
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_setgtUsr                                 (Body)     *
      *===================================================================*
      *
     P p_setgtUsr      B                   Export
     D                 PI
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
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
     C                   EVAL      S_User = g_user
      *
     C                   If        %parms >= 2
     C                   EVAL      S_Section = i_section
     C                   EVAL      S_Key = i_key
     C     U_Key3        Setgt     FPEEKUSR
     C                   Else
     C                   EVAL      S_Section = i_section
     C     U_Key2        Setgt     FPEEKUSR
     C                   Endif
      *
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_readeUsr                                 (Body)     *
      *===================================================================*
      *
     P f_readeUsr      B                   Export
     D                 PI                         like(BOOL_t)
     D  i_section                          const  like(SECTION_t)
     D  o_key                                     like(KEY_t)
     D                                            options(*NOPASS)
     D  o_data                                    like(SET0000_t)
     D                                            options(*NOPASS)
      *
      *  definieren Funktionswert ...
     D f_readeUsr      S                   like(BOOL_t)
     D                                     inz
      *
      *  definieren Hilfsfelder für optionale Parameter ...
     D o2_key          S                   like(KEY_t)
     D                                     inz
     D o3_data         S                   like(SET0000_t)
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
     C                   EVAL      S_User = g_user
     C                   EVAL      S_Section = i_section
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
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_setllDft                                 (Body)     *
      *===================================================================*
      *
     P p_setllDft      B                   Export
     D                 PI
     D  i_section                          const  like(SECTION_t)
     D  i_key                              const  like(KEY_t)
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
     C                   EVAL      D_User = '*NONE'
     C                   EVAL      D_Section = i_section
     C                   EVAL      D_Key = i_key
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
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_readeDft                                 (Body)     *
      *===================================================================*
      *
     P f_readeDft      B                   Export
     D                 PI                         like(BOOL_t)
     D  i_section                          const  like(SECTION_t)
     D  o_key                                     like(KEY_t)
     D                                            options(*NOPASS)
     D  o_data                                    like(SET0000_t)
     D                                            options(*NOPASS)
      *
      *  definieren Funktionswert ...
     D f_readeDft      S                   like(BOOL_t)
     D                                     inz
      *
      *  definieren Hilfsfelder für optionale Parameter ...
     D o2_key          S                   like(KEY_t)
     D                                     inz
     D o3_data         S                   like(SET0000_t)
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
     C                   EVAL      D_User = '*NONE'
     C                   EVAL      D_Section = i_section
     C     D_Key2        Reade     FDEFAULT                               11
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
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_setUsr                                   (Body)     *
      *===================================================================*
      *
     P p_setUsr        B                   Export
     D                 PI
     D  i_user                             const  like(USER_t)
     D  i_file                             const  like(FILE_t)
     D  i_lib                              const  like(LIB_t)
      * ------------------------------------------------------------------------
      *
     C                   Eval      g_user = i_user
     C                   Eval      g_file = i_file
     C                   Eval      g_lib  = i_lib
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_getUsr                                   (Body)     *
      *===================================================================*
      *
     P f_getUsr        B                   Export
     D                 PI                         like(USER_t)
     D  o_file                                    like(FILE_t)
     D  o_lib                                     like(LIB_t)
      * ------------------------------------------------------------------------
      *
     C                   Eval      o_file = g_file
     C                   Eval      o_lib  = g_lib
      *
     C                   Return    g_user
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_initUsrS                                 (Body)     *
      *===================================================================*
      *
     P f_initUsrS      B
     D                 PI                         like(SET0000_t)
     D  i_key                              const  like(KEY_t)
      *
      *  definieren Funktionswert ...
     D f_initUsrS      S                   like(SET0000_t)
     D                                     inz
      *
     D set0001         DS                  likeds(SET0001_t) inz
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
     C                   Callp     p_sndPgmMg('USR9999'
     C                               : 'PEEK53, f_initUsrS, i_key: ' + i_key
     C                               : '*' : '*ESCAPE')
     C                   Endsl
      *
     C                   Return    f_initUsrS
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_opnFile                                  (Body)     *
      *===================================================================*
      *
     P p_opnFile       B
     D                 PI
     D  o_msgID                       7A
     D  o_msgDta                    512A
      *
     D set0000         S                   like(set0000_t)
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
     C                   Callp     PEEK22('*REPLACE': '*ALL')
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
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_opnDft                                   (Body)     *
      *===================================================================*
      *
     P p_opnDft        B
     D                 PI
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
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_initSrvPgm                               (Body)     *
      *===================================================================*
      *
     P p_initSrvPgm    B
     D                 PI
      * ------------------------------------------------------------------------
      *
     C                   If        g_isInit = bFalse
      *
     C                   If        g_user = ''
     C                   Callp     p_setUsr(§§User: §§User: f_getPrdLb())
     C                   Endif
      *
     C                   Eval      PEEK22_NAME = f_pgmCallN('PEEK22')
      *
     C                   Eval      g_isInit = bTrue
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
