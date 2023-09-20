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
     D XScnAID         DS            10
     D XScnAID_1               1      1A
     D XPgm            S             10A
     D XPgmCmd         S             10A
     D XCmdDta         S                   LIKE(r§pgmCmdDt)
     D XMsgID          S              7A
     D XMsgDta         S            512A
     D XExclKeys       S                   like(r§pgmCmd  ) DIM(25)
      *
     D Wrk_EOF         S              1A   INZ(bFalse)
      *
     D Wrk_SECTN       S                   LIKE(R§SECTION )
     D                                     INZ(*BLANKS)
     D Wrk_Key         S                   LIKE(R§KEY     )
     D                                     INZ(*BLANKS)
     D Tmp_Key         S                   LIKE(R§KEY     )
     D                                     INZ(*BLANKS)
     D Wrk_Data        S                   LIKE(R§SET0000 )
     D                                     INZ(*BLANKS)
     D Wrk_Cmd         S                   LIKE(R§PGMCMD  )
     D                                     INZ(*BLANKS)
     D Wrk_ExclK       S                   like(r§pgmCmd  ) DIM(25)
      *
     D isExit05        S               N   inz(bFalse)
     D EXIT05          S                   like(r§pgmCallN) inz
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
     D p               S                   like(r§int4    ) inz
      *
     D callExit05      PR
     D  i_pgm                        10A   const
     D  i_type                       10A   const
     D  io_value                     10A
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     C     *ENTRY        PLIST
     C                   PARM                    XScnAID
     C                   PARM                    XPgm
     C                   PARM                    XPgmCmd
     C                   PARM                    XCmdDta
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
     C                   PARM                    XExclKeys
      *
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
      *
     C                   EVAL      Wrk_Key = *BLANKS
      *
     C     XScnAID_1     IFEQ      '#'
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
     C                   EVAL      Wrk_Key = %subst(XscnAID: 2)
      *
      *   Übersetzen key code vor dem Mapping:
     C                   CALLP     callExit05(xPgm: '*OPTION': Wrk_Key)
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
     C     XScnAID       WHENEQ    §F1
     C                   EVAL      Wrk_Key = '*F01'
      *  F2
     C     XScnAID       WHENEQ    §F2
     C                   EVAL      Wrk_Key = '*F02'
      *  F3
     C     XScnAID       WHENEQ    §F3
     C                   EVAL      Wrk_Key = '*F03'
      *  F4
     C     XScnAID       WHENEQ    §F4
     C                   EVAL      Wrk_Key = '*F04'
      *  F5
     C     XScnAID       WHENEQ    §F5
     C                   EVAL      Wrk_Key = '*F05'
      *  F6
     C     XScnAID       WHENEQ    §F6
     C                   EVAL      Wrk_Key = '*F06'
      *  F7
     C     XScnAID       WHENEQ    §F7
     C                   EVAL      Wrk_Key = '*F07'
      *  F8
     C     XScnAID       WHENEQ    §F8
     C                   EVAL      Wrk_Key = '*F08'
      *  F9
     C     XScnAID       WHENEQ    §F9
     C                   EVAL      Wrk_Key = '*F09'
      *  F10
     C     XScnAID       WHENEQ    §F10
     C                   EVAL      Wrk_Key = '*F10'
      *  F11
     C     XScnAID       WHENEQ    §F11
     C                   EVAL      Wrk_Key = '*F11'
      *  F12
     C     XScnAID       WHENEQ    §F12
     C                   EVAL      Wrk_Key = '*F12'
      *  F13
     C     XScnAID       WHENEQ    §F13
     C                   EVAL      Wrk_Key = '*F13'
      *  F14
     C     XScnAID       WHENEQ    §F14
     C                   EVAL      Wrk_Key = '*F14'
      *  F15
     C     XScnAID       WHENEQ    §F15
     C                   EVAL      Wrk_Key = '*F15'
      *  F16
     C     XScnAID       WHENEQ    §F16
     C                   EVAL      Wrk_Key = '*F16'
      *  F17
     C     XScnAID       WHENEQ    §F17
     C                   EVAL      Wrk_Key = '*F17'
      *  F18
     C     XScnAID       WHENEQ    §F18
     C                   EVAL      Wrk_Key = '*F18'
      *  F19
     C     XScnAID       WHENEQ    §F19
     C                   EVAL      Wrk_Key = '*F19'
      *  F20
     C     XScnAID       WHENEQ    §F20
     C                   EVAL      Wrk_Key = '*F20'
      *  F21
     C     XScnAID       WHENEQ    §F21
     C                   EVAL      Wrk_Key = '*F21'
      *  F22
     C     XScnAID       WHENEQ    §F22
     C                   EVAL      Wrk_Key = '*F22'
      *  F23
     C     XScnAID       WHENEQ    §F23
     C                   EVAL      Wrk_Key = '*F23'
      *  F24
     C     XScnAID       WHENEQ    §F24
     C                   EVAL      Wrk_Key = '*F24'
      *  Clear
     C     XScnAID       WHENEQ    §Clear
     C                   EVAL      Wrk_Key = '*CLEAR'
      *  Delete
     C     XScnAID       WHENEQ    §Delete
     C                   EVAL      Wrk_Key = '*DELETE'
      *  Datenfreigabe
     C     XScnAID       WHENEQ    §ENTER
     C                   EVAL      Wrk_Key = '*ENTER'
      *  Hilfe
     C     XScnAID       WHENEQ    §Help
     C                   EVAL      Wrk_Key = '*HELP'
      *  Page down
     C     XScnAID       WHENEQ    §PageDown
     C                   EVAL      Wrk_Key = '*PAGEDOWN'
      *  Page up
     C     XScnAID       WHENEQ    §PageUp
     C                   EVAL      Wrk_Key = '*PAGEUP'
      *  Print screen
     C     XScnAID       WHENEQ    §PrintScn
     C                   EVAL      Wrk_Key = '*PRINT'
      *  Reset
     C     XScnAID       WHENEQ    §Reset
     C                   EVAL      Wrk_Key = '*RESET'
      *  Light pen
     C     XScnAID       WHENEQ    §LightPen
     C                   EVAL      Wrk_Key = '*LIGHTPEN'
      *
     C                   OTHER
      *  Unbekanntes AID-Byte ...
      *  muß unbekannte HEX-Wert einer
      *  unbekannten Taste sein.
     C                   EVAL      Wrk_Key = *BLANKS
     C                   Callp     p_keyToMsg(xScnAID: xMsgID: xMsgDta)
     C                   Endsl
      *
     C                   IF        Wrk_Key = ''
     C                   LEAVESR
     C                   ENDIF
      *
      *   Übersetzen key code vor dem Mapping:
     C                   CALLP     callExit05(xPgm: '*CMDKEY': Wrk_Key)
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
     C                   EVAL      Wrk_Sectn = '*' + %trim(XPgm)
     C                   IF        f_chainUsr(Wrk_Sectn :
     C                                        Wrk_Key   :
     C                                        Wrk_Data  ) = '0'   and
     C                             f_isKeyExc(Wrk_Data  :
     C                                        Wrk_ExclK )= '0'
      *
      *   Übersetzen key code nach dem Mapping:
     C                   CALLP     callExit05(xPgm: '*EVENT': Wrk_Data)
      *
     C                   EVAL      XPgmCmd = Wrk_Data
     C                   EVAL      XCmdDta = *BLANKS
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
     C                   ELSE
      *
      *   Übersetzen key code nach dem Mapping:
     C                   CALLP     callExit05(xPgm: '*USROPT': Wrk_Key)
      *
      *   Prüfen auf Kurzbefehl ...
     C                   EVAL      Wrk_Sectn = '*CMD'
     C                   IF        f_chainUsr(Wrk_Sectn: Wrk_Key: Wrk_Data)='0'
     C                   EVAL      XPgmCmd = '*CMD'
     C                   EVAL      XCmdDta = Wrk_Data
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
     C                   ELSE
      *
     C                   EXSR      ChkEntry
      *  Wenn Tasten definiert sind,
      *  Dann Fehlermeldung ausgeben ...
     C     Wrk_EOF       IFEQ      bFalse
     C                   EVAL      XPgmCmd = *BLANKS
     C                   EVAL      XCmdDta = *BLANKS
     C                   EVAL      XMsgID = 'USR8143'
     C                   EVAL      USR81431 = Wrk_Key
     C                   EVAL      XMsgDta = USR8143
     C                   ELSE
     C                   EVAL      XPgmCmd = '*EXIT'
     C                   EVAL      XCmdDta = *BLANKS
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
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
     C                   EVAL      Wrk_Sectn = '*' + %trim(XPgm)
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
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
      *   Prüfen auf Ausschlüsse ...
      *   Prüfen auf Ausschlüsse ...
     C                   IF        %parms >= 7
     C                   EVAL      Wrk_ExclK = %subarr(XExclKeys: 1)
     C                   ELSE
     C                   EVAL      Wrk_ExclK(*) = ''
     C                   ENDIF
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        BEGSR
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
      *    *PSSR         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   DUMP
      *
     C                   ENDSR     '*CANCL'
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
