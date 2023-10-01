      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK54                                            *
      *  Typ      : RPGLE                                             *
      *                                                               *
      *  erstellt : 04.05.99  RADDATZ                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Peek/400 - Sichern   Arbeitsumgebung                         *
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
     FPEEKENV   UF A E           K DISK    usropn
     F                                     prefix(en_)
     FPEEKFLD   IF   E           K DISK    usropn
     F                                     prefix(p_)
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK54
      /undefine internal_prototype
      *
      *---------------------------------------------------*
     D p_main          PR
     D  i_file                             value  like(gi_file   )
     D  i_lib                              value  like(gi_lib    )
     D  i_mbr                              value  like(gi_mbr    )
     D  i_rcdFmt                           value  like(gi_rcdFmt )
     D  i_rcdFmtID                         value  like(gi_rcdFmtID)
     D  i_envFile                          value  like(gi_envFile)
     D  i_envLib                           value  like(gi_envLib )
     D  i_envMbr                           value  like(gi_envMbr )
     D  i_isAutoSave                       value  like(gi_isAutoSave)
     D  i_pinTabR                          value  like(gi_pinTabR) dim(12)
     D  i_nbrPinR                          value  like(gi_nbrPinR)
     D  i_pinTabC                          value  like(gi_pinTabC) dim(12)
     D  i_nbrPinC                          value  like(gi_nbrPinC)
     D  i_AccMode                          value  like(gi_AccMode)
     D  i_SqlSel                           value  like(gi_SqlSel )
     D  i_SqlOrd                           value  like(gi_SqlOrd )
     D  i_isKeyLower                       value  like(gi_isKeyLower)
     D  o_msgID                                   like(go_msgID  )
     D  o_msgDta                                  like(go_msgDta )
      *---------------------------------------------------*
     D p_clrEnv        PR
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_mbr                                     like(gi_mbr    )
     D  o_msgID                                   like(go_msgID  )
     D  o_msgDta                                  like(go_msgDta )
      *---------------------------------------------------*
     D p_file          PR
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_fileX                                   like(gi_file   )
      *---------------------------------------------------*
     D p_lib           PR
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_libX                                    like(gi_lib    )
      *---------------------------------------------------*
     D p_mbr           PR
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_mbr                                     like(gi_mbr    )
      *---------------------------------------------------*
     D p_rcdFmt        PR
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_rcdFmt                                  like(gi_rcdFmt )
      *---------------------------------------------------*
     D p_rcdFmtID      PR
     D  i_file                                    like(gi_file    )
     D  i_lib                                     like(gi_lib     )
     D  i_rcdFmtID                                like(gi_rcdFmtID)
      *---------------------------------------------------*
     D f_checkAutoSave...
     D                 PR                         like(bool_t)
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
      *---------------------------------------------------*
     D p_accMode       PR
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_accMode                                 like(gi_accMode)
      *---------------------------------------------------*
     D p_sqlSel        PR
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_sqlSel                                  like(gi_sqlSel )
      *---------------------------------------------------*
     D p_sqlOrd        PR
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_sqlOrd                                  like(gi_sqlOrd )
      *---------------------------------------------------*
     D p_isKeyLower    PR
     D  i_file                                    like(gi_file       )
     D  i_lib                                     like(gi_lib        )
     D  i_isKeyLower                              like(gi_isKeyLower )
      *---------------------------------------------------*
     D p_wrtPinR       PR
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_pinTabR                                 like(gi_pinTabR)
     D                                            dim(12)
     D  i_nbrPinR                                 like(gi_nbrPinR)
      *---------------------------------------------------*
     D p_wrtPinC       PR
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_pinTabC                                 like(gi_pinTabC)
     D                                            dim(12)
     D  i_nbrPinC                                 like(gi_nbrPinC)
      *---------------------------------------------------*
     D p_wrtLyt        PR
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
      *---------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,FILD0100
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
     D PEEK54          PI
     D  gi_file                            const like(file_t)
     D  gi_lib                             const like(lib_t)
     D  gi_mbr                             const like(mbr_t)
     D  gi_rcdFmt                          const like(fmt_t)
     D  gi_rcdFmtID                        const like(fmtId_t)
     D  gi_envFile                         const like(file_t)
     D  gi_envLib                          const like(lib_t)
     D  gi_envMbr                          const like(mbr_t)
     D  gi_isAutoSave                      const like(bool_t)
     D  gi_pinTabR                         const like(pinTabR_t) dim(12)
     D  gi_nbrPinR                         const like(int4_t)
     D  gi_pinTabC                         const like(fieldNme_t) dim(12)
     D  gi_nbrPinC                         const like(int4_t)
     D  gi_AccMode                         const like(accessMode_t)
     D  gi_SqlSel                          const like(sqlWhere_t)
     D  gi_SqlOrd                          const like(sqlOrder_t)
     D  gi_isKeyLower                      const like(bool_t)
     D  go_msgID                                 like(msgID_t)
     D  go_msgDta                                like(msgDta_t)
      *
      *----------------------------------------------------*
      *  Schlüssel PEEKFLD
     C     p_key1        Klist
     C                   Kfld                    p_field
      *----------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   Callp     p_main(gi_file    :
     C                                    gi_lib     :
     C                                    gi_mbr     :
     C                                    gi_rcdFmt  :
     C                                    gi_rcdFmtID:
     C                                    gi_envFile :
     C                                    gi_envLib  :
     C                                    gi_envMbr  :
     C                                    gi_isAutoSave:
     C                                    gi_pinTabR :
     C                                    gi_nbrPinR :
     C                                    gi_pinTabC :
     C                                    gi_nbrPinC :
     C                                    gi_AccMode :
     C                                    gi_SqlSel  :
     C                                    gi_SqlOrd  :
     C                                    gi_isKeyLower :
     C                                    go_msgID   :
     C                                    go_msgDta  )
      *
     C                   Return
      *
      *===================================================================*
      *  Prozedur:  p_crtUsrSg                                 (Body)     *
      *===================================================================*
      *
     P p_main          B
     D                 PI
     D  i_file                             value  like(gi_file   )
     D  i_lib                              value  like(gi_lib    )
     D  i_mbr                              value  like(gi_mbr    )
     D  i_rcdFmt                           value  like(gi_rcdFmt )
     D  i_rcdFmtID                         value  like(gi_rcdFmtID)
     D  i_envFile                          value  like(gi_envFile)
     D  i_envLib                           value  like(gi_envLib )
     D  i_envMbr                           value  like(gi_envMbr )
     D  i_isAutoSave                       value  like(gi_isAutoSave)
     D  i_pinTabR                          value  like(gi_pinTabR)
     D                                     dim(12)
     D  i_nbrPinR                          value  like(gi_nbrPinR)
     D  i_pinTabC                          value  like(gi_pinTabC)
     D                                     dim(12)
     D  i_nbrPinC                          value  like(gi_nbrPinC)
     D  i_AccMode                          value  like(gi_AccMode)
     D  i_SqlSel                           value  like(gi_SqlSel )
     D  i_SqlOrd                           value  like(gi_SqlOrd )
     D  i_isKeyLower                       value  like(gi_isKeyLower)
     D  o_msgID                                   like(go_msgID  )
     D  o_msgDta                                  like(go_msgDta )
      *
      *  Arbeitsfelder
     D pFile           S                   like(file_t)
     D                                     inz
     D pLib            S                   like(lib_t)
     D                                     inz
     D pMbr            S                   like(mbr_t)
     D                                     inz
     D pFmt            S                   like(fmt_t)
     D                                     inz
     D pEnvMbr         S                   like(i_envMbr  )
     D                                     inz
     D canSave         S                   like(bool_t)
      *
      *  Nachrichten
      /COPY QCOPYLE,USR9992
      *---------------------------------------------------*
      *
     C                   if        i_envMbr = '*FILE'
     C                   eval      pEnvMbr = i_file
     C                   else
     C                   eval      pEnvMbr = i_envMbr
     C                   endif
      *
      *  Basiert auf physischer Datei ...
     C                   Callp     f_basedPF(i_file    :
     C                                       i_lib     :
     C                                       i_mbr     :
     C                                       i_rcdFmt  :
     C                                       -1        :
     C                                       pFile     :
     C                                       pLib      :
     C                                       pMbr      :
     C                                       pFmt      )
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
      *  Prüfen, ob gespeichert werden darf
     C                   If        i_isAutoSave = bTrue
     C                   Open(E)   PEEKENV
     C                   If        not %error()
     C                   Eval      canSave =  f_checkAutoSave(pfile: plib)
     C                   Close     PEEKENV
     C                   Else
      *     Fehler beim Öffnen aufgetreten
     C                   clear                   USR9992
     C                   Eval      USR99921 = 3
     C                   Eval      USR99922 = i_file
     C                   Eval      USR99923 = i_lib
     C                   Eval      USR99924 = pEnvMbr
     C                   Callp     f_sndMsgToCmdLine('USR9992': USR9992)
     C                   Eval      canSave = bFalse
     C                   Endif
     C                   Else
     C                   Eval      canSave = bTrue
     C                   Endif
      *
      *  Löschen alte Daten ...
     C                   If        canSave = bTrue
      *
     C                   Callp     p_clrEnv(i_envFile  :
     C                                      i_envLib   :
     C                                      pEnvMbr    :
     C                                      o_msgID    :
     C                                      o_msgDta   )
      *
     C                   If        go_msgID = ' '
      *
      *  Öffnen Datei ...
     C                   Open      PEEKENV
      *
      *  Ausgeben AccessMode ...
     C                   Callp     p_accMode(pfile     :
     C                                       plib      :
     C                                       i_accMode )
      *
      *  Ausgeben Datei ...
     C                   Callp     p_file(pfile  :
     C                                    plib   :
     C                                    i_file )
      *
      *  Ausgeben Bibliothek ...
     C                   Callp     p_lib(pfile :
     C                                   plib  :
     C                                   i_lib )
      *
      *  Ausgeben Teildatei ...
     C                   Callp     p_mbr(pfile :
     C                                   plib  :
     C                                   i_mbr )
      *
      *  Ausgeben Satzformat ...
     C                   Callp     p_rcdFmt(pfile    :
     C                                      plib     :
     C                                      i_rcdFmt )
      *
      *  Ausgeben Satzformat-ID ...
     C                   Callp     p_rcdFmtID(pfile     :
     C                                        plib      :
     C                                        i_rcdFmtID)
      *
      *  Ausgeben SqlSelect ...
     C                   Callp     p_sqlSel(pfile     :
     C                                      plib      :
     C                                      i_sqlSel  )
      *
      *  Ausgeben SqlOrder ...
     C                   Callp     p_sqlOrd(pfile     :
     C                                      plib      :
     C                                      i_sqlOrd  )
      *
      *  Ausgeben isKeyLower ...
     C                   Callp     p_isKeyLower(pfile       :
     C                                          plib        :
     C                                          i_isKeyLower)
      *
      *  Ausgeben Layout ...
     C                   Callp     p_wrtLyt(pfile     :
     C                                      plib      )
      *
      *  Ausgeben Pin-Record ...
     C                   Callp     p_wrtPinR(pfile    :
     C                                       plib     :
     C                                       i_pinTabR:
     C                                       i_nbrPinR)
      *
      *  Ausgeben Pin-Column ...
     C                   Callp     p_wrtPinC(pfile    :
     C                                       plib     :
     C                                       i_pinTabC:
     C                                       i_nbrPinC)
      *
      *  Schließen Datei ...
     C                   Close     PEEKENV
      *
     C                   Endif
     C                   Endif
      *
      *  Löschen Überschreibung ...
     C                   EVAL      §File = 'PEEKENV'
     C                   EVAL      §Lvl = '*ACTGRPDFN'
      /COPY QCOPYLE,DLTOVR
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_clrEnv                                   (Body)     *
      *===================================================================*
      *
     P p_clrEnv        B
     D                 PI
     D  i_envFile                                 like(gi_envFile)
     D  i_envLib                                  like(gi_envLib )
     D  i_envMbr                                  like(gi_envMbr )
     D  o_msgID                                   like(go_msgID  )
     D  o_msgDta                                  like(go_msgDta )
      *
      *  definieren Arbeitsfelder ...
      *---------------------------------------------------*
      *
     C                   Callp     f_execute('CLRPFM'          +
     C                                       ' FILE('          +
     C                                       %trim(i_envLib)   +
     C                                       '/'               +
     C                                       %trim(i_envFile)  +
     C                                       ')'               +
     C                                       ' MBR('           +
     C                                       %trim(i_envMbr)   +
     C                                       ')'               :
     C                                       o_msgID           :
     C                                       o_msgDta          )
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_file                                     (Body)     *
      *===================================================================*
      *
     P p_file          B
     D                 PI
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_fileX                                   like(gi_file   )
      *
      *  definieren Arbeitsfelder ...
     D                 DS
     D idx                     1     10S 0 inz
     D chrIdx                  1     10A
      *---------------------------------------------------*
      *
     C                   Clear                   FPEEKENV
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*FILE'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C                   Eval      en_key     = chrIdx
     C                   Eval      en_data    = i_fileX
      *
     C                   Write     FPEEKENV
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_lib                                      (Body)     *
      *===================================================================*
      *
     P p_lib           B
     D                 PI
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_libX                                    like(gi_lib    )
      *
      *  definieren Arbeitsfelder ...
     D                 DS
     D idx                     1     10S 0 inz
     D chrIdx                  1     10A
      *---------------------------------------------------*
      *
     C                   Clear                   FPEEKENV
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*LIB'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C                   Eval      en_key     = chrIdx
     C                   Eval      en_data    = i_libX
      *
     C                   Write     FPEEKENV
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_mbr                                      (Body)     *
      *===================================================================*
      *
     P p_mbr           B
     D                 PI
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_mbr                                     like(gi_mbr    )
      *
      *  definieren Arbeitsfelder ...
     D                 DS
     D idx                     1     10S 0 inz
     D chrIdx                  1     10A
      *---------------------------------------------------*
      *
     C                   Clear                   FPEEKENV
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*MBR'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C                   Eval      en_key     = chrIdx
     C                   Eval      en_data    = i_mbr
      *
     C                   Write     FPEEKENV
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_rcdFmt                                   (Body)     *
      *===================================================================*
      *
     P p_rcdFmt        B
     D                 PI
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_rcdFmt                                  like(gi_rcdFmt )
      *
      *  definieren Arbeitsfelder ...
     D                 DS
     D idx                     1     10S 0 inz
     D chrIdx                  1     10A
      *---------------------------------------------------*
      *
     C                   Clear                   FPEEKENV
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*RCDFMT'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C                   Eval      en_key     = chrIdx
     C                   Eval      en_data    = i_rcdFmt
      *
     C                   Write     FPEEKENV
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_rcdFmtID                                 (Body)     *
      *===================================================================*
      *
     P p_rcdFmtID      B
     D                 PI
     D  i_file                                    like(gi_file    )
     D  i_lib                                     like(gi_lib     )
     D  i_rcdFmtID                                like(gi_rcdFmtID)
      *
      *  definieren Arbeitsfelder ...
     D                 DS
     D idx                     1     10S 0 inz
     D chrIdx                  1     10A
      *---------------------------------------------------*
      *
     C                   Clear                   FPEEKENV
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*RCDFMTID'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C                   Eval      en_key     = chrIdx
     C                   Eval      en_data    = i_rcdFmtID
      *
     C                   Write     FPEEKENV
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_checkAutoSave                            (Body)     *
      *===================================================================*
      *
     P f_checkAutoSave...
     P                 B
     D                 PI                         like(bool_t)
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
      *
      *  definieren Arbeitsfelder ...
     D en_key1         DS                  qualified
     D  USER                               like(en_USER   )
      *
     D en_key3         DS                  qualified
     D  USER                               like(en_USER   )
     D  SECTION                            like(en_SECTION)
     D  FILE                               like(en_FILE   )
      *
     D en_key4         DS                  qualified
     D  USER                               like(en_USER   )
     D  SECTION                            like(en_SECTION)
     D  FILE                               like(en_FILE   )
     D  LIB                                like(en_LIB    )
      *
      *  Nachrichten
      /COPY QCOPYLE,USR9992
      *---------------------------------------------------*
      /free

         en_key1.USER    = *LOVAL;
         Setll %kds(en_key1) FPEEKENV;
         Read FPEEKENV;
         if (%eof(PEEKENV));
            return bTrue;
         endif;

         en_key3.USER    = '*ALL';
         en_key3.SECTION = '*FILE';
         en_key3.FILE    = i_file;
         Chain %kds(en_key3) FPEEKENV;
         if (not %found(PEEKENV));
            clear USR9992;
            USR99921 = 1;
            USR99922 = i_file;
            USR99923 = '*N';
            USR99924 = '*N';
            f_sndMsgToCmdLine('USR9992': USR9992);
            return bFalse;
         endif;

         en_key4.USER    = '*ALL';
         en_key4.SECTION = '*FILE';
         en_key4.FILE    = i_file;
         en_key4.LIB     = i_lib;
         Chain %kds(en_key4) FPEEKENV;
         if (not %found(PEEKENV));
            clear USR9992;
            USR99921 = 2;
            USR99922 = i_lib;
            USR99923 = '*N';
            USR99924 = '*N';
            f_sndMsgToCmdLine('USR9992': USR9992);
            return bFalse;
         endif;

         return bTrue;

      /end-free
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_accMode                                  (Body)     *
      *===================================================================*
      *
     P p_accMode       B
     D                 PI
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_accMode                                 like(gi_accMode)
      *
      *  definieren Arbeitsfelder ...
     D                 DS
     D idx                     1     10S 0 inz
     D chrIdx                  1     10A
      *---------------------------------------------------*
      *
     C                   Clear                   FPEEKENV
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*ACCMODE'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C                   Eval      en_key     = chrIdx
     C                   Eval      en_data    = i_accMode
      *
     C                   Write     FPEEKENV
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_sqlSel                                   (Body)     *
      *===================================================================*
      *
     P p_sqlSel        B
     D                 PI
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_sqlSel                                  like(gi_sqlSel )
      *
      *  definieren Arbeitsfelder ...
     D                 DS
     D idx                     1     10S 0 inz
     D chrIdx                  1     10A
      *
     D strPos          S                   like(int4_t)
     D                                     inz
     D lenSql          S                   like(int4_t)
     D                                     inz
     D lenData         S                   like(int4_t)
     D                                     inz
      *---------------------------------------------------*
      *
     C                   Clear                   FPEEKENV
      *
     C                   Eval      idx     = 1
     C                   Eval      strPos  = 1
     C                   Eval      lenSql  = f_len(%trim(i_sqlSel))
     C                   Eval      lenData = f_len(en_data)
      *
     C                   Dow       strPos < lenSql
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*SQLSELECT'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C                   Eval      en_key     = chrIdx
     C                   Eval      en_data    = %subst(i_sqlSel:strPos:lenData)
      *
     C                   Write     FPEEKENV
      *
     C                   Eval      idx    = idx + 1
     C                   Eval      strPos = strPos + lenData
     C                   Enddo
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_sqlOrd                                   (Body)     *
      *===================================================================*
      *
     P p_sqlOrd        B
     D                 PI
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_sqlOrd                                  like(gi_sqlOrd )
      *
      *  definieren Arbeitsfelder ...
     D                 DS
     D idx                     1     10S 0 inz
     D chrIdx                  1     10A
      *
     D strPos          S                   like(int4_t)
     D                                     inz
     D lenSql          S                   like(int4_t)
     D                                     inz
     D lenData         S                   like(int4_t)
     D                                     inz
      *---------------------------------------------------*
      *
     C                   Clear                   FPEEKENV
      *
     C                   Eval      idx     = 1
     C                   Eval      strPos  = 1
     C                   Eval      lenSql  = f_len(%trim(i_sqlOrd))
     C                   Eval      lenData = f_len(en_data)
      *
     C                   Dow       strPos < lenSql
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*SQLORDER'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C                   Eval      en_key     = chrIdx
     C                   Eval      en_data    = %subst(i_sqlOrd:strPos:lenData)
      *
     C                   Write     FPEEKENV
      *
     C                   Eval      idx    = idx + 1
     C                   Eval      strPos = strPos + lenData
     C                   Enddo
      *
     C                   Return
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_isKeyLower                               (Body)     *
      *===================================================================*
      *
     P p_isKeyLower    B
     D                 PI
     D  i_file                                    like(gi_file       )
     D  i_lib                                     like(gi_lib        )
     D  i_isKeyLower                              like(gi_isKeyLower )
      *
      *  definieren Arbeitsfelder ...
     D                 DS
     D idx                     1     10S 0 inz
     D chrIdx                  1     10A
      *---------------------------------------------------*
      *
     C                   Clear                   FPEEKENV
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*KEYLUC'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C                   Eval      en_key     = chrIdx
     C                   Eval      en_data    = i_isKeyLower
      *
     C                   Write     FPEEKENV
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_wrtPinR                                  (Body)     *
      *===================================================================*
      *
     P p_wrtPinR       B
     D                 PI
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_pinTabR                                 like(gi_pinTabR)
     D                                            dim(12)
     D  i_nbrPinR                                 like(gi_nbrPinR)
      *
      *  definieren Arbeitsfelder ...
     D                 DS
     D idx                     1     10S 0 inz
     D chrIdx                  1     10A
      *---------------------------------------------------*
      *
     C     1             Do        i_nbrPinR     idx
      *
     C                   Clear                   FPEEKENV
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*PINROW'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C                   Eval      en_key     = chrIdx
     C                   Eval      en_data    = i_pinTabR(idx)
      *
     C                   Write     FPEEKENV
     C                   Enddo
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_wrtPinC                                  (Body)     *
      *===================================================================*
      *
     P p_wrtPinC       B
     D                 PI
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
     D  i_pinTabC                                 like(gi_pinTabC)
     D                                            dim(12)
     D  i_nbrPinC                                 like(gi_nbrPinC)
      *
      *  definieren Arbeitsfelder ...
     D                 DS
     D idx                     1     10S 0 inz
     D chrIdx                  1     10A
      *---------------------------------------------------*
      *
     C     1             Do        i_nbrPinC     idx
      *
     C                   Clear                   FPEEKENV
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*PINCOL'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C                   Eval      en_key     = chrIdx
     C                   Eval      en_data    = i_pinTabC(idx)
      *
     C                   Write     FPEEKENV
     C                   Enddo
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_wrtLyt                                   (Body)     *
      *===================================================================*
      *
     P p_wrtLyt        B
     D                 PI
     D  i_file                                    like(gi_file   )
     D  i_lib                                     like(gi_lib    )
      *
      *  Arbeitsfelder ...
      /COPY QCOPYLE,ENV0001
      *---------------------------------------------------*
      *
     C                   Open      PEEKFLD
      *
     C                   Eval      p_field = ' '
     C     p_key1        Setll     FPEEKFLD
      *
     C                   Do        *HIVAL
     C                   Read      FPEEKFLD                               01
     C                   If        *IN01 = *ON
     C                   Leave
     C                   Endif
      *
     C                   Clear                   FPEEKENV
      *
     C                   Eval      en_user    = '*ALL'
     C                   Eval      en_section = '*LAYOUT'
     C                   Eval      en_file    = i_file
     C                   Eval      en_lib     = i_lib
     C                   Eval      en_key     = p_field
      *
     C                   Clear                   ENV0001
     C                   Eval      env_seq    = p_seq
     C                   Eval      env_hidden = p_hidden
     C                   Eval      env_color  = p_color
     C                   Eval      env_mark   = p_markcol
     C                   Eval      env_size   = p_maxsize
     C                   Eval      env_edtcde = p_edtcde
     C                   Eval      en_data    = ENV0001
      *
     C                   Write     FPEEKENV
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
