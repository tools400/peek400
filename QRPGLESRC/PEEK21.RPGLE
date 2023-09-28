      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK21                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 27.10.97  Raddatz                                 *
      *  geändert : 27.04.99  2.1.0                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Mappen einer gedrückten Taste auf einen Programmbefehl       *
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
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
      *----------------------------------------------------*
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK21
      /undefine internal_prototype
      *
      *---Variablendefinition ShortCmd---------------------*
      /COPY QCOPYLE,ShortCmd_D
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8143
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
     D Wrk_EOF         S              1A   INZ(bFalse)
      *
     D Wrk_SECTN       S                   LIKE(SECTION_t)
     D                                     INZ(*BLANKS)
     D Wrk_Key         S                   LIKE(KEY_t)
     D                                     INZ(*BLANKS)
     D Tmp_Key         S                   LIKE(KEY_t)
     D                                     INZ(*BLANKS)
     D Wrk_Data        S                   LIKE(SET0000_t)
     D                                     INZ(*BLANKS)
     D Wrk_Cmd         S                   LIKE(PGMCMD_t)
     D                                     INZ(*BLANKS)
     D Wrk_ExclK       S                   like(pgmCmd_t) DIM(25)
      *
     D isExit05        S               N   inz(bFalse)
     D EXIT05          S                   like(pgmCallN_t) inz
     D qPgm            DS                  qualified
     D  name                         10A
     D  lib                          10A
      *
     D chgActEvt       PR                         extpgm(EXIT05)
     D  gi_file                      10A   const
     D  gi_lib                       10A   const
     D  gi_user                      10A   const
     D  gi_pgm                       10A   const
     D  gi_type                      10A   const
     D  gio_option                   10A
      *
     D g_exit05        DS                  qualified
     D  user                         10A   inz
     D  file                         10A   inz
     D  lib                          10A   inz
      *
     D p               S                   like(int4_t) inz
      *
     D callExit05      PR
     D  i_pgm                        10A   const
     D  i_type                       10A   const
     D  io_value                     10A
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK21          PI
     D  i_scnAID                           const like(scnAid_t)
     D  i_pgm                              const like(pgm_t)
     D  o_pgmCmd                                 like(pgmCmd_t)
     D  o_cmdDta                                 like(pgmCmdDt_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
     D  i_exclKeys                         const like(pgmCmd_t) dim(25)
     D                                           options(*nopass)
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
      *
     C                   EXSR      FIRST
      *
     C                   EVAL      Wrk_Key = *BLANKS
      *
     C                   if        (%subst(i_scnAID: 1: 1) = '#')
     C                   EXSR      MapSflOpt
     C                   ELSE
     C                   EXSR      MapCmdKey
     C                   Endif
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *============================================================*
      *    MapSflOpt    Übersetzen Subfileauswahlen                *
      *============================================================*
      *
     C     MapSflOpt     BEGSR
      *
     C**                 SUBST (P) XscnAID:2     Wrk_Key
     C                   EVAL      Wrk_Key = %subst(i_scnAID: 2)
      *
      *   Übersetzen key code vor dem Mapping:
     C                   CALLP     callExit05(i_pgm: '*OPTION': Wrk_Key)
      *
     C                   EXSR      MapUsrInp
      *
     C                   ENDSR
      *
      *============================================================*
      *    MapCmdKey     Übersetzen Tastendruck in Programmbefehl  *
      *============================================================*
      *
     C     MapCmdKey     BEGSR
      *
     C                   SELECT
      *  F1
     C     i_scnAID      WHENEQ    §F1
     C                   EVAL      Wrk_Key = '*F01'
      *  F2
     C     i_scnAID      WHENEQ    §F2
     C                   EVAL      Wrk_Key = '*F02'
      *  F3
     C     i_scnAID      WHENEQ    §F3
     C                   EVAL      Wrk_Key = '*F03'
      *  F4
     C     i_scnAID      WHENEQ    §F4
     C                   EVAL      Wrk_Key = '*F04'
      *  F5
     C     i_scnAID      WHENEQ    §F5
     C                   EVAL      Wrk_Key = '*F05'
      *  F6
     C     i_scnAID      WHENEQ    §F6
     C                   EVAL      Wrk_Key = '*F06'
      *  F7
     C     i_scnAID      WHENEQ    §F7
     C                   EVAL      Wrk_Key = '*F07'
      *  F8
     C     i_scnAID      WHENEQ    §F8
     C                   EVAL      Wrk_Key = '*F08'
      *  F9
     C     i_scnAID      WHENEQ    §F9
     C                   EVAL      Wrk_Key = '*F09'
      *  F10
     C     i_scnAID      WHENEQ    §F10
     C                   EVAL      Wrk_Key = '*F10'
      *  F11
     C     i_scnAID      WHENEQ    §F11
     C                   EVAL      Wrk_Key = '*F11'
      *  F12
     C     i_scnAID      WHENEQ    §F12
     C                   EVAL      Wrk_Key = '*F12'
      *  F13
     C     i_scnAID      WHENEQ    §F13
     C                   EVAL      Wrk_Key = '*F13'
      *  F14
     C     i_scnAID      WHENEQ    §F14
     C                   EVAL      Wrk_Key = '*F14'
      *  F15
     C     i_scnAID      WHENEQ    §F15
     C                   EVAL      Wrk_Key = '*F15'
      *  F16
     C     i_scnAID      WHENEQ    §F16
     C                   EVAL      Wrk_Key = '*F16'
      *  F17
     C     i_scnAID      WHENEQ    §F17
     C                   EVAL      Wrk_Key = '*F17'
      *  F18
     C     i_scnAID      WHENEQ    §F18
     C                   EVAL      Wrk_Key = '*F18'
      *  F19
     C     i_scnAID      WHENEQ    §F19
     C                   EVAL      Wrk_Key = '*F19'
      *  F20
     C     i_scnAID      WHENEQ    §F20
     C                   EVAL      Wrk_Key = '*F20'
      *  F21
     C     i_scnAID      WHENEQ    §F21
     C                   EVAL      Wrk_Key = '*F21'
      *  F22
     C     i_scnAID      WHENEQ    §F22
     C                   EVAL      Wrk_Key = '*F22'
      *  F23
     C     i_scnAID      WHENEQ    §F23
     C                   EVAL      Wrk_Key = '*F23'
      *  F24
     C     i_scnAID      WHENEQ    §F24
     C                   EVAL      Wrk_Key = '*F24'
      *  Clear
     C     i_scnAID      WHENEQ    §Clear
     C                   EVAL      Wrk_Key = '*CLEAR'
      *  Delete
     C     i_scnAID      WHENEQ    §Delete
     C                   EVAL      Wrk_Key = '*DELETE'
      *  Datenfreigabe
     C     i_scnAID      WHENEQ    §ENTER
     C                   EVAL      Wrk_Key = '*ENTER'
      *  Hilfe
     C     i_scnAID      WHENEQ    §Help
     C                   EVAL      Wrk_Key = '*HELP'
      *  Page down
     C     i_scnAID      WHENEQ    §PageDown
     C                   EVAL      Wrk_Key = '*PAGEDOWN'
      *  Page up
     C     i_scnAID      WHENEQ    §PageUp
     C                   EVAL      Wrk_Key = '*PAGEUP'
      *  Print screen
     C     i_scnAID      WHENEQ    §PrintScn
     C                   EVAL      Wrk_Key = '*PRINT'
      *  Reset
     C     i_scnAID      WHENEQ    §Reset
     C                   EVAL      Wrk_Key = '*RESET'
      *  Light pen
     C     i_scnAID      WHENEQ    §LightPen
     C                   EVAL      Wrk_Key = '*LIGHTPEN'
      *
     C                   OTHER
      *  Unbekanntes AID-Byte ...
      *  muß unbekannte HEX-Wert einer
      *  unbekannten Taste sein.
     C                   EVAL      Wrk_Key = *BLANKS
     C                   Callp     p_keyToMsg(i_scnAID: o_msgID: o_msgDta)
     C                   Endsl
      *
     C                   IF        Wrk_Key = ''
     C                   LEAVESR
     C                   ENDIF
      *
      *   Übersetzen key code vor dem Mapping:
     C                   CALLP     callExit05(i_pgm: '*CMDKEY': Wrk_Key)
      *
     C                   EXSR      MapUsrInp
      *
     C                   ENDSR
      *
      *============================================================*
      *    MapUsrInp     Übersetzen Tastendruck in Programmbefehl  *
      *============================================================*
      *
     C     MapUsrInp     BEGSR
      *
      *   Übersetzen ...
     C                   EVAL      Wrk_Sectn = '*' + %trim(i_pgm)
     C                   IF        f_chainUsr(Wrk_Sectn :
     C                                        Wrk_Key   :
     C                                        Wrk_Data  ) = '0'   and
     C                             f_isKeyExc(Wrk_Data  :
     C                                        Wrk_ExclK )= '0'
      *
      *   Übersetzen key code nach dem Mapping:
     C                   CALLP     callExit05(i_pgm: '*EVENT': Wrk_Data)
      *
     C                   EVAL      o_pgmCmd = Wrk_Data
     C                   EVAL      o_cmdDta = *BLANKS
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
     C                   ELSE
      *
      *   Übersetzen key code nach dem Mapping:
     C                   CALLP     callExit05(i_pgm: '*USROPT': Wrk_Key)
      *
      *   Prüfen auf Kurzbefehl ...
     C                   EVAL      Wrk_Sectn = '*CMD'
     C                   IF        f_chainUsr(Wrk_Sectn: Wrk_Key: Wrk_Data)='0'
     C                   EVAL      o_pgmCmd = '*CMD'
     C                   EVAL      o_cmdDta = Wrk_Data
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
     C                   ELSE
      *
     C                   EXSR      ChkEntry
      *  Wenn Tasten definiert sind,
      *  Dann Fehlermeldung ausgeben ...
     C     Wrk_EOF       IFEQ      bFalse
     C                   EVAL      o_pgmCmd = *BLANKS
     C                   EVAL      o_cmdDta = *BLANKS
     C                   EVAL      o_msgID = 'USR8143'
     C                   EVAL      USR81431 = Wrk_Key
     C                   EVAL      o_msgDta = USR8143
     C                   ELSE
     C                   EVAL      o_pgmCmd = '*EXIT'
     C                   EVAL      o_cmdDta = *BLANKS
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
     C                   Endif
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkEntry      Prüfen auf Einträge zum Programm          *
      *============================================================*
      *
     C     ChkEntry      BEGSR
      *
      *   Prüfen ...
     C                   EVAL      Wrk_Sectn = '*' + %trim(i_pgm)
     C                   Callp     p_setllUsr(Wrk_Sectn: '*F01')
     C                   IF        f_readeUsr(Wrk_Sectn: Tmp_Key) = '1'
     C                   EVAL      Wrk_EOF = bTrue
     C                   ELSE
     C     Tmp_Key       IFLT      '*F01'
     C     Tmp_Key       ORGT      '*F24'
     C                   EVAL      Wrk_EOF = bTrue
     C                   ELSE
     C                   EVAL      Wrk_EOF = bFalse
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    First         Initialisierung                           *
      *============================================================*
      *
     C     First         BEGSR
      *
      * - Programm initialisieren
      ***                Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *   Prüfen auf Ausschlüsse ...
      *   Prüfen auf Ausschlüsse ...
     C                   IF        %parms() >= %parmnum(i_exclKeys)
     C                   EVAL      Wrk_ExclK = %subarr(i_exclKeys: 1)
     C                   ELSE
     C                   EVAL      Wrk_ExclK(*) = ''
     C                   ENDIF
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
     C                   Eval      EXIT05 = f_pgmCallN('EXIT05')
      *
     C                   Eval      p = %scan('/': EXIT05)
     C                   If        p > 1
     C                   Eval      qPgm.lib = %subst(EXIT05: 1: p-1)
     C                   If        p < %len(EXIT05)
     C                   Eval      qPgm.name = %subst(EXIT05: p+1)
     C                   Eval      isExit05  = f_exist(qPgm.name
     C                                                 : qPgm.lib
     C                                                 : '*PGM')
     C                   Endif
     C                   Endif
      *
     C                   Eval      g_exit05.user =
     C                                f_getUsr(g_exit05.file: g_exit05.lib)
      *
     C                   ENDSR
      *
      *============================================================*
      *    Aufrufen EXIT05                                         *
      *============================================================*
     P callExit05      b
     D                 pi
     D  i_pgm                        10A   const
     D  i_type                       10A   const
     D  io_value                     10A
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /free

         if (isExit05);
            monitor;
               chgActEvt(g_exit05.file: g_exit05.lib: g_exit05.user
                         : i_pgm: i_type: io_value);
            on-error;
               p_rmvPgmMg('*');
               isExit05 = bFalse;
            endmon;
         endif;

      /end-free
      *
     P                 e
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
