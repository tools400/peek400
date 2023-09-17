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
     C                   MOVEL (P) *BLANKS       Wrk_Key
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
     C                   SUBST (P) XscnAID:2     Wrk_Key
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
     C                   MOVEL (P) '*F01'        Wrk_Key
      *  F2
     C     XScnAID       WHENEQ    §F2
     C                   MOVEL (P) '*F02'        Wrk_Key
      *  F3
     C     XScnAID       WHENEQ    §F3
     C                   MOVEL (P) '*F03'        Wrk_Key
      *  F4
     C     XScnAID       WHENEQ    §F4
     C                   MOVEL (P) '*F04'        Wrk_Key
      *  F5
     C     XScnAID       WHENEQ    §F5
     C                   MOVEL (P) '*F05'        Wrk_Key
      *  F6
     C     XScnAID       WHENEQ    §F6
     C                   MOVEL (P) '*F06'        Wrk_Key
      *  F7
     C     XScnAID       WHENEQ    §F7
     C                   MOVEL (P) '*F07'        Wrk_Key
      *  F8
     C     XScnAID       WHENEQ    §F8
     C                   MOVEL (P) '*F08'        Wrk_Key
      *  F9
     C     XScnAID       WHENEQ    §F9
     C                   MOVEL (P) '*F09'        Wrk_Key
      *  F10
     C     XScnAID       WHENEQ    §F10
     C                   MOVEL (P) '*F10'        Wrk_Key
      *  F11
     C     XScnAID       WHENEQ    §F11
     C                   MOVEL (P) '*F11'        Wrk_Key
      *  F12
     C     XScnAID       WHENEQ    §F12
     C                   MOVEL (P) '*F12'        Wrk_Key
      *  F13
     C     XScnAID       WHENEQ    §F13
     C                   MOVEL (P) '*F13'        Wrk_Key
      *  F14
     C     XScnAID       WHENEQ    §F14
     C                   MOVEL (P) '*F14'        Wrk_Key
      *  F15
     C     XScnAID       WHENEQ    §F15
     C                   MOVEL (P) '*F15'        Wrk_Key
      *  F16
     C     XScnAID       WHENEQ    §F16
     C                   MOVEL (P) '*F16'        Wrk_Key
      *  F17
     C     XScnAID       WHENEQ    §F17
     C                   MOVEL (P) '*F17'        Wrk_Key
      *  F18
     C     XScnAID       WHENEQ    §F18
     C                   MOVEL (P) '*F18'        Wrk_Key
      *  F19
     C     XScnAID       WHENEQ    §F19
     C                   MOVEL (P) '*F19'        Wrk_Key
      *  F20
     C     XScnAID       WHENEQ    §F20
     C                   MOVEL (P) '*F20'        Wrk_Key
      *  F21
     C     XScnAID       WHENEQ    §F21
     C                   MOVEL (P) '*F21'        Wrk_Key
      *  F22
     C     XScnAID       WHENEQ    §F22
     C                   MOVEL (P) '*F22'        Wrk_Key
      *  F23
     C     XScnAID       WHENEQ    §F23
     C                   MOVEL (P) '*F23'        Wrk_Key
      *  F24
     C     XScnAID       WHENEQ    §F24
     C                   MOVEL (P) '*F24'        Wrk_Key
      *  Clear
     C     XScnAID       WHENEQ    §Clear
     C                   MOVEL (P) '*CLEAR'      Wrk_Key
      *  Delete
     C     XScnAID       WHENEQ    §Delete
     C                   MOVEL (P) '*DELETE'     Wrk_Key
      *  Datenfreigabe
     C     XScnAID       WHENEQ    §ENTER
     C                   MOVEL (P) '*ENTER'      Wrk_Key
      *  Hilfe
     C     XScnAID       WHENEQ    §Help
     C                   MOVEL (P) '*HELP'       Wrk_Key
      *  Page down
     C     XScnAID       WHENEQ    §PageDown
     C                   MOVEL (P) '*PAGEDOWN'   Wrk_Key
      *  Page up
     C     XScnAID       WHENEQ    §PageUp
     C                   MOVEL (P) '*PAGEUP'     Wrk_Key
      *  Print screen
     C     XScnAID       WHENEQ    §PrintScn
     C                   MOVEL (P) '*PRINT'      Wrk_Key
      *  Reset
     C     XScnAID       WHENEQ    §Reset
     C                   MOVEL (P) '*RESET'      Wrk_Key
      *  Light pen
     C     XScnAID       WHENEQ    §LightPen
     C                   MOVEL (P) '*LIGHTPEN'   Wrk_Key
      *
     C                   OTHER
      *  Unbekanntes AID-Byte ...
      *  muß unbekannte HEX-Wert einer
      *  unbekannten Taste sein.
     C                   MOVEL(P)  *BLANKS       Wrk_Key
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
     C     '*'           CAT   (P) XPgm:0        Wrk_Sectn
     C                   IF        f_chainUsr(Wrk_Sectn :
     C                                        Wrk_Key   :
     C                                        Wrk_Data  ) = '0'   and
     C                             f_isKeyExc(Wrk_Data  :
     C                                        Wrk_ExclK )= '0'
      *
      *   Übersetzen key code nach dem Mapping:
     C                   CALLP     callExit05(xPgm: '*EVENT': Wrk_Data)
      *
     C                   MOVEL (P) Wrk_Data      XPgmCmd
     C                   MOVEL (P) *BLANKS       XCmdDta
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
     C                   ELSE
      *
      *   Übersetzen key code nach dem Mapping:
     C                   CALLP     callExit05(xPgm: '*USROPT': Wrk_Key)
      *
      *   Prüfen auf Kurzbefehl ...
     C                   MOVEL (P) '*CMD'        Wrk_Sectn
     C                   IF        f_chainUsr(Wrk_Sectn: Wrk_Key: Wrk_Data)='0'
     C                   MOVEL (P) '*CMD'        XPgmCmd
     C                   MOVEL (P) Wrk_Data      XCmdDta
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
     C                   ELSE
      *
     C                   EXSR      ChkEntry
      *  Wenn Tasten definiert sind,
      *  Dann Fehlermeldung ausgeben ...
     C     Wrk_EOF       IFEQ      bFalse
     C                   MOVEL (P) *BLANKS       XPgmCmd
     C                   MOVEL (P) *BLANKS       XCmdDta
     C                   MOVEL (P) 'USR8143'     XMsgID
     C                   MOVEL (P) Wrk_Key       USR81431
     C                   MOVEL (P) USR8143       XMsgDta
     C                   ELSE
     C                   MOVEL (P) '*EXIT'       XPgmCmd
     C                   MOVEL (P) *BLANKS       XCmdDta
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
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
     C     '*'           CAT   (P) XPgm:0        Wrk_Sectn
     C                   Callp     p_setllUsr(Wrk_Sectn: '*F01')
     C                   IF        f_readeUsr(Wrk_Sectn: Tmp_Key) = '1'
     C                   MOVEL (P) bTrue         Wrk_EOF
     C                   ELSE
     C     Tmp_Key       IFLT      '*F01'
     C     Tmp_Key       ORGT      '*F24'
     C                   MOVEL (P) bTrue         Wrk_EOF
     C                   ELSE
     C                   MOVEL (P) bFalse        Wrk_EOF
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
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *   Prüfen auf Ausschlüsse ...
      *   Prüfen auf Ausschlüsse ...
     C                   IF        %parms >= 7
     C                   MOVEA     XExclKeys     Wrk_ExclK
     C                   ELSE
     C                   MOVEA     *BLANKS       Wrk_ExclK
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
