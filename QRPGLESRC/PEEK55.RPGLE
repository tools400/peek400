      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK55                                            *
      *  Typ      : RPGLE                                             *
      *                                                               *
      *  erstellt : 04.05.99  RADDATZ                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Peek/400 - Laden     Arbeitsumgebung                         *
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
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEKENV   IF   E           K DISK    usropn
     F                                     prefix(en_)
     FPEEKFLD   UF   E           K DISK    usropn
     F                                     prefix(p_)
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK55
      /undefine internal_prototype
      *
      *---------------------------------------------------*
     D p_loadFile      PR
     D  o_file                                    like(go_file)
      *---------------------------------------------------*
     D p_loadLib       PR
     D  o_lib                                     like(go_lib)
      *---------------------------------------------------*
     D p_loadMbr       PR
     D  o_mbr                                     like(go_mbr)
      *---------------------------------------------------*
     D p_loadRcdFmt    PR
     D  o_rcdFmt                                  like(go_rcdFmt)
      *---------------------------------------------------*
     D p_loadRcdFmtID  PR
     D  o_rcdFmtID                                like(fmtID_t)
      *---------------------------------------------------*
     D p_loadAccM      PR
     D  o_accMode                                 like(go_accMode)
      *---------------------------------------------------*
     D p_loadSqlS      PR
     D  i_file                             const  like(gi_file   )
     D  i_lib                              const  like(gi_lib    )
     D  o_sqlSel                                  like(go_sqlSel )
      *---------------------------------------------------*
     D p_loadSqlO      PR
     D  i_file                             const  like(gi_file   )
     D  i_lib                              const  like(gi_lib    )
     D  o_sqlOrd                                  like(go_sqlOrd )
      *---------------------------------------------------*
     D p_loadIsKeyLower...
     D                 PR
     D  i_file                             const  like(gi_file       )
     D  i_lib                              const  like(gi_lib        )
     D  o_isKeyLower                              like(go_isKeyLower )
      *---------------------------------------------------*
     D p_main          PR
     D  i_file                             value  like(gi_file      )
     D  i_lib                              value  like(gi_lib       )
     D  i_mbr                              value  like(gi_mbr       )
     D  i_rcdFmt                           value  like(gi_rcdFmt    )
     D  i_rcdFmtID                         value  like(gi_rcdFmtID  )
     D  i_envFile                          value  like(gi_envFile   )
     D  i_envLib                           value  like(gi_envLib    )
     D  i_envMbr                           value  like(gi_envMbr    )
     D  i_option                           value  like(gi_option    )
     D  o_pinTabR                                 like(go_pinTabR   ) dim(12)
     D  o_nbrPinR                                 like(go_nbrPinR   )
     D  o_pinTabC                                 like(go_pinTabC   ) dim(12)
     D  o_nbrPinC                                 like(go_nbrPinC   )
     D  o_File                                    like(go_File      )
     D  o_Lib                                     like(go_Lib       )
     D  o_Mbr                                     like(go_Mbr       )
     D  o_RcdFmt                                  like(go_RcdFmt    )
     D  o_AccMode                                 like(go_AccMode   )
     D  o_SqlSel                                  like(go_SqlSel    )
     D  o_SqlOrd                                  like(go_SqlOrd    )
     D  o_isKeyLower                              like(go_isKeyLower)
     D  o_msgID                                   like(go_msgID     )
     D  o_msgDta                                  like(go_msgDta    )
      *---------------------------------------------------*
     D p_loadPinR      PR
     D  i_file                             const  like(gi_file   )
     D  i_lib                              const  like(gi_lib    )
     D  o_pinTabR                                 like(go_pinTabR)
     D                                            dim(12)
     D  o_nbrPinR                                 like(go_nbrPinR)
      *---------------------------------------------------*
     D p_loadPinC      PR
     D  i_file                             const  like(gi_file   )
     D  i_lib                              const  like(gi_lib    )
     D  o_pinTabC                                 like(go_pinTabC)
     D                                            dim(12)
     D  o_nbrPinC                                 like(go_nbrPinC)
      *---------------------------------------------------*
     D p_loadLyt       PR
     D  i_file                             const  like(gi_file   )
     D  i_lib                              const  like(gi_lib    )
      *---------------------------------------------------*
      *
      *----------------------------------------------------*
     D cNOTFOUND       C                   const('*NOTFOUND')
      *
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,FILD0100
      /COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,SET0015
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
      ********************************************************************
      *           Programmsteuerung                                      *
      ********************************************************************
      *
     D PEEK55          PI
     D  gi_file                            const like(file_t)
     D  gi_lib                             const like(lib_t)
     D  gi_mbr                             const like(mbr_t)
     D  gi_rcdFmt                          const like(fmt_t)
     D  gi_rcdFmtID                        const like(fmtId_t)
     D  gi_envFile                         const like(file_t)
     D  gi_envLib                          const like(lib_t)
     D  gi_envMbr                          const like(mbr_t)
     D  gi_option                          const like(option_t)
     D  go_pinTabR                               like(pinTabR_t) dim(12)
     D  go_nbrPinR                               like(int4_t)
     D  go_pinTabC                               like(fieldNme_t) dim(12)
     D  go_nbrPinC                               like(int4_t)
     D  go_File                                  like(file_t)
     D  go_Lib                                   like(lib_t)
     D  go_Mbr                                   like(mbr_t)
     D  go_rcdFmt                                like(fmt_t)
     D  go_AccMode                               like(accessMode_t)
     D  go_SqlSel                                like(sqlWhere_t)
     D  go_SqlOrd                                like(sqlOrder_t)
     D  go_isKeyLower                            like(bool_t)
     D  go_msgID                                 like(msgID_t)
     D  go_msgDta                                like(msgDta_t)
      *
      *----------------------------------------------------*
      *  Schlüssel PEEKENV
     C     en_key4       Klist
     C                   Kfld                    en_USER
     C                   Kfld                    en_SECTION
     C                   Kfld                    en_FILE
     C                   Kfld                    en_LIB
      *
     C     en_key3       Klist
     C                   Kfld                    en_USER
     C                   Kfld                    en_SECTION
     C                   Kfld                    en_FILE
      *
     C     en_key2       Klist
     C                   Kfld                    en_USER
     C                   Kfld                    en_SECTION
      *
      *  Schlüssel PEEKFLD
     C     p_key1        Klist
     C                   Kfld                    p_field
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   Callp     p_main(gi_file       :
     C                                    gi_lib        :
     C                                    gi_mbr        :
     C                                    gi_rcdFmt     :
     C                                    gi_rcdFmtID   :
     C                                    gi_envFile    :
     C                                    gi_envLib     :
     C                                    gi_envMbr     :
     C                                    gi_option     :
     C                                    go_pinTabR    :
     C                                    go_nbrPinR    :
     C                                    go_pinTabC    :
     C                                    go_nbrPinC    :
     C                                    go_File       :
     C                                    go_Lib        :
     C                                    go_Mbr        :
     C                                    go_RcdFmt     :
     C                                    go_AccMode    :
     C                                    go_SqlSel     :
     C                                    go_SqlOrd     :
     C                                    go_isKeyLower :
     C                                    go_msgID      :
     C                                    go_msgDta     )
      *
     C                   Return
      *
      *===================================================================*
      *  Prozedur:  p_crtUsrSg                                 (Body)     *
      *===================================================================*
      *
     P p_main          B
     D                 PI
     D  i_file                             value  like(gi_file      )
     D  i_lib                              value  like(gi_lib       )
     D  i_mbr                              value  like(gi_mbr       )
     D  i_rcdFmt                           value  like(gi_rcdFmt    )
     D  i_rcdFmtID                         value  like(gi_rcdFmtID  )
     D  i_envFile                          value  like(gi_envFile   )
     D  i_envLib                           value  like(gi_envLib    )
     D  i_envMbr                           value  like(gi_envMbr    )
     D  i_option                           value  like(gi_option    )
     D  o_pinTabR                                 like(go_pinTabR   ) dim(12)
     D  o_nbrPinR                                 like(go_nbrPinR   )
     D  o_pinTabC                                 like(go_pinTabC   ) dim(12)
     D  o_nbrPinC                                 like(go_nbrPinC   )
     D  o_File                                    like(go_File      )
     D  o_Lib                                     like(go_Lib       )
     D  o_Mbr                                     like(go_Mbr       )
     D  o_RcdFmt                                  like(go_RcdFmt    )
     D  o_AccMode                                 like(go_AccMode   )
     D  o_SqlSel                                  like(go_SqlSel    )
     D  o_SqlOrd                                  like(go_SqlOrd    )
     D  o_isKeyLower                              like(go_isKeyLower)
     D  o_msgID                                   like(go_msgID     )
     D  o_msgDta                                  like(go_msgDta    )
      *
      *  Arbeitsfelder
     D pFile           S                   like(file_t)
     D                                     inz
     D pLib            S                   like(lib_t)
     D                                     inz
     D pMbr            S                   like(mbr_t)
     D                                     inz
     D pFmt            S                   like(rcdFmt_t)
     D                                     inz
     D pEnvMbr         S                   like(i_envMbr  )
     D                                     inz
     D pRcdFmtID       S                   like(fmtID_t)
      *
      /COPY QCOPYLE,USR8234
      *---------------------------------------------------*
      *
      *  Sonderwerte i_envFile ...
     C                   Select
      *  ... *NONE
     C                   When      i_envFile = '*NONE'
     C                   Eval      o_msgID  = 'USR8185'
     C                   Eval      o_msgDta = ' '
     C                   Goto      Ende
      *  ... *ENVFILE
     C                   When      i_envFile = '*ENVFILE'
     C                   Eval      SET0015 = f_getUsrSg('*ENVFILE'  )
     C                   Eval      i_envFile = SET_EnvFil
     C                   Eval      i_envLib  = SET_EnvLib
     C                   Other
      *  ... genau diese Datei
     C                   Endsl
      *
      *  Sonderwerte i_envLib ...
     C                   Select
      *  ... *PRDLIB
     C                   When      i_envLib  = '*PRDLIB'
     C                   Eval      i_envLib  = §§PgmLib
     C                   Other
      *  ... genau diese Bibliothek
     C                   Endsl
      *
      *  Sonderwerte i_envMbr ...
     C                   Select
      *  ... *FILE
     C                   When      i_envMbr  = '*FILE'
     C                   Eval      pEnvMbr = i_file
     C                   Other
      *  ... genau diese Teildatei
     C                   Eval      pEnvMbr = i_envMbr
     C                   Endsl
      *
      *  Prüfen Arbeitsumgebung  ...
     C                   Callp     f_execute('CHKOBJ'          +
     C                                       ' OBJ('           +
     C                                       %trim(i_envLib)   +
     C                                       '/'               +
     C                                       %trim(i_envFile)  +
     C                                       ')'               +
     C                                       ' OBJTYPE('       +
     C                                        '*FILE'          +
     C                                       ')'               +
     C                                       ' MBR('           +
     C                                       %trim(pEnvMbr)    +
     C                                       ')'               +
     C                                       ' AUT('           +
     C                                        '*USE'           +
     C                                       ')'               :
     C                                       o_msgID           :
     C                                       o_msgDta          )
      *
      *  Programm mit Fehlermeldung beenden
     C                   If        o_msgID <> ' '
     C                   Goto      Ende
     C                   Endif
      *
      *  Überschreiben Datei ...
     C                   EVAL      §File = 'PEEKENV'
     C                   EVAL      §ToFile = i_envFile
     C                   EVAL      §ToLib = i_envLib
     C                   EVAL      §Mbr = pEnvMbr
     C                   EVAL      §OvrScope = '*ACTGRPDFN'
     C                   EVAL      §Share = '*NO'
     C                   EVAL      §SeqOnly = '*NO'
     C                   EVAL      §Secure = '*YES'
      /COPY QCOPYLE,OVRDBF
      *
      *  Öffnen Datei ...
     C                   Open      PEEKENV
      *
     C                   If        i_option = '*SLCLAYOUT'
     C                   Callp     p_loadRcdFmtID(pRcdFmtID)
     C                   If        pRcdFmtID <> '' and pRcdFmtID <> i_rcdFmtID
     C                   Clear                   USR8234
     C                   Eval      USR82341 = i_envFile
     C                   Eval      USR82342 = i_envLib
     C                   Eval      USR82343 = i_envMbr
     C                   Eval      o_msgID  = 'USR8234'
     C                   Eval      o_msgDta = USR8234
     C                   Goto      Ende
     C                   Endif
      *
     C                   Eval      o_file   = i_file
     C                   Eval      o_lib    = i_lib
     C                   Eval      o_mbr    = i_mbr
     C                   Eval      o_rcdFmt = i_rcdFmt
     C                   Else
      *  Einlesen Datei ...
     C                   Callp     p_loadFile(o_file)
     C                   If        o_file = cNOTFOUND
     C                   Eval      o_file = i_file
     C                   Endif
      *
      *  Einlesen Bibliothek ...
     C                   Callp     p_loadLib(o_lib)
     C                   If        o_lib = cNOTFOUND
     C                   Eval      o_lib = i_lib
     C                   Endif
      *
      *  Einlesen Teildatei ...
     C                   Callp     p_loadMbr(o_mbr)
     C                   If        o_mbr = cNOTFOUND
     C                   Eval      o_mbr = i_mbr
     C                   Endif
      *
      *  Einlesen Satzformat ...
      *  (nur bei geänderter Datei)
     C                   If        (i_file <> o_file) or
     C                             (i_lib  <> o_lib )
     C                   Callp     p_loadRcdFmt(o_rcdFmt)
     C                   If        o_rcdFmt = cNOTFOUND
     C                   Eval      o_rcdFmt = i_rcdFmt
     C                   Endif
     C                   Else
     C                   Eval      o_rcdFmt = i_rcdFmt
     C                   Endif
      *
     C                   Endif
      *
      *  Basiert auf physischer Datei ...
     C                   Callp     f_basedPF(o_file     :
     C                                       o_lib      :
     C                                       o_mbr      :
     C                                       o_rcdFmt   :
     C                                       -1         :
     C                                       pFile      :
     C                                       pLib       :
     C                                       pMbr       :
     C                                       pFmt       )
      *
      *  Einlesen AccessMode ...                 (dateiunabhängig)
     C                   Callp     p_loadAccM(o_accMode)
      *
      *  Einlesen SqlSelect ...                  (phys. Datei muss gleich sein)
     C                   Callp     p_loadSqlS(pfile     :
     C                                        '*NONE'   :
     C                                        o_sqlSel  )
      *
      *  Einlesen SqlOrder ...                   (phys. Datei muss gleich sein)
     C                   Callp     p_loadSqlO(pfile     :
     C                                        '*NONE'   :
     C                                        o_sqlOrd  )
      *
      *  Einlesen isKeyLower ...                 (phys. Datei muss gleich sein)
     C                   Callp     p_loadIsKeyLower(pfile       :
     C                                              '*NONE'     :
     C                                              o_isKeyLower)
      *
      *  Beenden, wenn Datei gewechselt hat, weil die Datei neu geöffnet werden muss
      *  und damit alle Layout und PIN Informationen gelöscht werden. PEEK55 wird dann
      *  von PEEK05 erneut aufgerufen, nachdem die Datei geöffnet worden ist.
     C                   IF        (o_file <> i_file)  or
     C                             (o_lib  <> i_lib )  or
     C                             (o_mbr  <> i_mbr )  or
     C                             (o_rcdFmt <> i_rcdFmt)
     C                   Goto      pgmEnde
     C                   Endif
      *
      *  Einlesen Layout ...                     (phys. Datei muss gleich sein)
     C                   Callp     p_loadLyt(pFile     :
     C                                       '*NONE'   )
      *
      *  Einlesen Pin-Record ...                 (phys. Datei und Bibliothek müssen gleich sei
     C                   Callp     p_loadPinR(pfile     :
     C                                        plib      :
     C                                        o_pinTabR :
     C                                        o_nbrPinR )
      *
      *  Einlesen Pin-Column ...                 (phys. Datei muss gleich sein)
     C                   Callp     p_loadPinC(pfile     :
     C                                        '*NONE'   :
     C                                        o_pinTabC :
     C                                        o_nbrPinC )
      *
     C     pgmEnde       Tag
      *
      *  Schließen Datei ...
     C                   Close     PEEKENV
      *
      *  Löschen Überschreibung ...
     C                   EVAL      §File = 'PEEKENV'
     C                   EVAL      §Lvl = '*ACTGRPDFN'
      /COPY QCOPYLE,DLTOVR
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     Ende          Tag
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_loadFile                                 (Body)     *
      *===================================================================*
      *
     P p_loadFile      B
     D                 PI
     D  o_file                                    like(go_file)
      *
      *  definieren Arbeitsfelder ...
      *---------------------------------------------------*
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*FILE'
     C     en_key2       Chain     FPEEKENV                           01
     C                   If        *IN01 = *ON
     C                   Eval      o_file = cNOTFOUND
     C                   Else
     C                   Eval      o_file = en_data
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_loadLib                                  (Body)     *
      *===================================================================*
      *
     P p_loadLib       B
     D                 PI
     D  o_lib                                     like(go_lib)
      *
      *  definieren Arbeitsfelder ...
      *---------------------------------------------------*
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*LIB'
     C     en_key2       Chain     FPEEKENV                           01
     C                   If        *IN01 = *ON
     C                   Eval      o_lib = cNOTFOUND
     C                   Else
     C                   Eval      o_lib = en_data
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_loadMbr                                  (Body)     *
      *===================================================================*
      *
     P p_loadMbr       B
     D                 PI
     D  o_mbr                                     like(go_mbr)
      *
      *  definieren Arbeitsfelder ...
      *---------------------------------------------------*
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*MBR'
     C     en_key2       Chain     FPEEKENV                           01
     C                   If        *IN01 = *ON
     C                   Eval      o_mbr  = cNOTFOUND
     C                   Else
     C                   Eval      o_mbr  = en_data
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_loadRcdFmt                               (Body)     *
      *===================================================================*
      *
     P p_loadRcdFmt    B
     D                 PI
     D  o_rcdFmt                                  like(go_rcdFmt)
      *
      *  definieren Arbeitsfelder ...
      *---------------------------------------------------*
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*RCDFMT'
     C     en_key2       Chain     FPEEKENV                           01
     C                   If        *IN01 = *ON
     C                   Eval      o_rcdFmt = cNOTFOUND
     C                   Else
     C                   Eval      o_rcdFmt = en_data
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_loadRcdFmtID                             (Body)     *
      *===================================================================*
      *
     P p_loadRcdFmtID  B
     D                 PI
     D  o_rcdFmtID                                like(fmtID_t)
      *
      *  definieren Arbeitsfelder ...
      *---------------------------------------------------*
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*RCDFMTID'
     C     en_key2       Chain     FPEEKENV                           01
     C                   If        *IN01 = *ON
     C                   Eval      o_rcdFmtID = ''
     C                   Else
     C                   Eval      o_rcdFmtID = en_data
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_loadAccM                                 (Body)     *
      *===================================================================*
      *
     P p_loadAccM      B
     D                 PI
     D  o_accMode                                 like(go_accMode)
      *
      *  definieren Arbeitsfelder ...
      *---------------------------------------------------*
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*ACCMODE'
     C     en_key2       Chain     FPEEKENV                           01
     C                   If        *IN01 = *ON
     C                   Eval      o_accMode = KEY_SEQ
     C                   Else
     C                   Eval      o_accMode = en_data
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_loadSqlS                                 (Body)     *
      *===================================================================*
      *
     P p_loadSqlS      B
     D                 PI
     D  i_file                             const  like(gi_file   )
     D  i_lib                              const  like(gi_lib    )
     D  o_sqlSel                                  like(go_sqlSel )
      *
      *  definieren Arbeitsfelder ...
     D strPos          S                   like(int4_t)
     D                                     inz
     D lenSql          S                   like(int4_t)
     D                                     inz
     D lenData         S                   like(int4_t)
     D                                     inz
      *---------------------------------------------------*
      *
     C                   Eval      o_sqlSel = ' '
      *
     C                   Eval      strPos  = 1
     C                   Eval      lenSql  = f_len(o_sqlSel)
     C                   Eval      lenData = f_len(en_data)
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*SQLSELECT'
     C                   Eval      en_file    = i_file
      *
     C                   If        i_lib = '*NONE'
     C     en_key3       Setll     FPEEKENV
     C                   Else
     C                   Eval      en_lib     = i_lib
     C     en_key4       Setll     FPEEKENV
     C                   Endif
      *
     C                   Dow       strPos <= lenSql
      *
     C                   If        i_lib = '*NONE'
     C     en_key3       Reade     FPEEKENV                               01
     C                   Else
     C     en_key4       Reade     FPEEKENV                               01
     C                   Endif
      *
     C                   If        *IN01 = *ON
     C                   Leave
     C                   Endif
      *
     C                   Eval      %subst(o_sqlSel:strPos:lenData) = en_data
     C                   Eval      strPos   = strPos + lenData
     C                   Enddo
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_loadSqlO                                 (Body)     *
      *===================================================================*
      *
     P p_loadSqlO      B
     D                 PI
     D  i_file                             const  like(gi_file   )
     D  i_lib                              const  like(gi_lib    )
     D  o_sqlOrd                                  like(go_sqlOrd )
      *
      *  definieren Arbeitsfelder ...
     D strPos          S                   like(int4_t)
     D                                     inz
     D lenSql          S                   like(int4_t)
     D                                     inz
     D lenData         S                   like(int4_t)
     D                                     inz
      *---------------------------------------------------*
      *
     C                   Eval      o_sqlOrd = ' '
      *
     C                   Eval      strPos  = 1
     C                   Eval      lenSql  = f_len(o_sqlOrd)
     C                   Eval      lenData = f_len(en_data)
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*SQLORDER'
     C                   Eval      en_file    = i_file
      *
     C                   If        i_lib = '*NONE'
     C     en_key3       Setll     FPEEKENV
     C                   Else
     C                   Eval      en_lib     = i_lib
     C     en_key4       Setll     FPEEKENV
     C                   Endif
      *
     C                   Dow       strPos <= lenSql
      *
     C                   If        i_lib = '*NONE'
     C     en_key3       Reade     FPEEKENV                               01
     C                   Else
     C     en_key4       Reade     FPEEKENV                               01
     C                   Endif
      *
     C                   If        *IN01 = *ON
     C                   Leave
     C                   Endif
      *
     C                   Eval      %subst(o_sqlOrd:strPos:lenData) = en_data
     C                   Eval      strPos   = strPos + lenData
     C                   Enddo
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_loadIsKeyLower                           (Body)     *
      *===================================================================*
      *
     P p_loadIsKeyLower...
     P                 B
     D                 PI
     D  i_file                             const  like(gi_file       )
     D  i_lib                              const  like(gi_lib        )
     D  o_isKeyLower                              like(go_isKeyLower)
      *
      *  definieren Arbeitsfelder ...
      *---------------------------------------------------*
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*KEYLUC'
     C                   Eval      en_file    = i_file
      *
     C                   If        i_lib = '*NONE'
     C     en_key3       Chain     FPEEKENV                           01
     C                   Else
     C                   Eval      en_lib     = i_lib
     C     en_key4       Chain     FPEEKENV                           01
     C                   Endif
      *
     C                   If        *IN01 = *ON
     C                   Eval      o_isKeyLower = KEY_MODE_UPPER
     C                   Else
     C                   Eval      o_isKeyLower = en_data
     C                   Endif
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_loadPinR                                 (Body)     *
      *===================================================================*
      *
     P p_loadPinR      B
     D                 PI
     D  i_file                             const  like(gi_file   )
     D  i_lib                              const  like(gi_lib    )
     D  o_pinTabR                                 like(go_pinTabR)
     D                                            dim(12)
     D  o_nbrPinR                                 like(go_nbrPinR)
      *
      *  definieren Arbeitsfelder ...
      *
     D                 DS
     D rcd                     1     10S 0 inz
     D chrRcd                  1     10A
     D pintabr         DS                  likeds(pinTabR_t) inz
     D***                                  prefix(pr_       )
     D x               S             10I 0 inz
      *---------------------------------------------------*
      *
     C                   Clear                   pintabr
     C     1             Do        12            x
     C                   Eval      o_pinTabR(x) = pintabr
     C                   Eval      o_nbrPinR    = 0
     C                   Enddo
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*PINROW'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C     en_key4       Setll     FPEEKENV
      *
     C                   Do        *HIVAL
     C     en_key4       Reade     FPEEKENV                               01
     C                   If        *IN01 = *ON
     C                   Leave
     C                   Endif
      *
     C                   Eval      o_nbrPinR = o_nbrPinR + 1
     C                   Eval      o_pinTabR(o_nbrPinR) = en_data
     C                   Enddo
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_loadPinC                                 (Body)     *
      *===================================================================*
      *
     P p_loadPinC      B
     D                 PI
     D  i_file                             const  like(gi_file   )
     D  i_lib                              const  like(gi_lib    )
     D  o_pinTabC                                 like(go_pinTabC)
     D                                            dim(12)
     D  o_nbrPinC                                 like(go_nbrPinC)
      *
      *  definieren Arbeitsfelder ...
     D x               S             10I 0 inz
      *---------------------------------------------------*
      *
     C     1             Do        12            x
     C                   Eval      o_pinTabC(x) = ' '
     C                   Eval      o_nbrPinC    = 0
     C                   Enddo
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*PINCOL'
     C                   Eval      en_file    = i_file
      *
     C                   If        i_lib = '*NONE'
     C     en_key3       Setll     FPEEKENV
     C                   Else
     C                   Eval      en_lib     = i_lib
     C     en_key4       Setll     FPEEKENV
     C                   Endif
      *
     C                   Do        *HIVAL
      *
     C                   If        i_lib = '*NONE'
     C     en_key3       Reade     FPEEKENV                               01
     C                   Else
     C     en_key4       Reade     FPEEKENV                               01
     C                   Endif
      *
     C                   If        *IN01 = *ON
     C                   Leave
     C                   Endif
      *
     C                   Eval      o_nbrPinC = o_nbrPinC + 1
     C                   Eval      o_pinTabC(o_nbrPinC) = en_data
     C                   Enddo
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_loadLyt                                  (Body)     *
      *===================================================================*
      *
     P p_loadLyt       B
     D                 PI
     D  i_file                             const  like(gi_file   )
     D  i_lib                              const  like(gi_lib    )
      *
      *  Arbeitsfelder ...
      /COPY QCOPYLE,ENV0001
      *---------------------------------------------------*
      *
     C                   Open      PEEKFLD
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*LAYOUT'
     C                   Eval      en_file    = i_file
      *
     C                   If        i_lib = '*NONE'
     C     en_key3       Setll     FPEEKENV
     C                   Else
     C                   Eval      en_lib     = i_lib
     C     en_key4       Setll     FPEEKENV
     C                   Endif
      *
     C                   Do        *HIVAL
      *
     C                   If        i_lib = '*NONE'
     C     en_key3       Reade     FPEEKENV                               01
     C                   Else
     C     en_key4       Reade     FPEEKENV                               01
     C                   Endif
      *
     C                   If        *IN01 = *ON
     C                   Leave
     C                   Endif
      *
     C                   Eval      p_field = en_key
     C     p_key1        Chain     FPEEKFLD                           01
     C                   If        *IN01 = *OFF
     C                   Eval      ENV0001 = en_data
     C                   Eval      p_seq     = env_seq
     C                   Eval      p_hidden  = env_hidden
     C                   Eval      p_color   = env_color
     C                   Eval      p_markcol = env_mark
     C                   Eval      p_maxsize = env_size
     C                   Eval      p_edtcde  = env_edtcde
     C                   Update    FPEEKFLD
     C                   Endif
      *
     C                   Enddo
      *
     C                   Close     PEEKFLD
      *
     C                   Return
      *
     P                 E
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
