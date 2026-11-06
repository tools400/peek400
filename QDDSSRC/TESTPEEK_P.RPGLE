      *===============================================================*
      *  (C) Thomas Raddatz                                           *
      *  Bereich  : PEEK Version 3.4.0                                *
      *  Typ      : PGM                                               *
      *===============================================================*
      *  Kurzdokumentation :                                          *
      *  Peek/400 - Programmtemplate                                  *
      *===============================================================*
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                   *
      *                           SRCFILE(&SL/&SF) +                  *
      *                           SRCMBR(&SM);                        *
      *   >>COMPILE<<                                                 *
      *     >>PARM<< TRUNCNBR(*NO);                                   *
      *     >>PARM<< DBGVIEW(*LIST);                                  *
      *     >>PARM<< CVTOPT(*DATETIME  +                              *
      *                     *VARCHAR   +                              *
      *                     *VARGRAPHIC);                             *
      *   >>END-COMPILE<<                                             *
      *   >>EXECUTE<<                                                 *
      *   >>CMD<<    CRTPGM       PGM(&LI/&OB) +                      *
      *                           MODULE(&LI/&OB) +                   *
      *                           BNDSRVPGM(&LI/PEEK58) +             *
      *                           ACTGRP(*CALLER);                    *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
     H DEBUG
     H ALWNULL(*USRCTL)
     H OPTION(*SRCSTMT : *NODEBUGIO)
      *
      *====================================================*
      *  Dateiliste                                        *
      *====================================================*
     FDSPF      CF   E             WORKSTN usropn
     F                                     infds(workStn)
     F                                     infsr(*pssr)
      *
     FFILE00    UF A E             DISK    usropn
    R *  Eintragen Satzformatname
FMT1-F                                     rename(TESTPEEK  :FFILE00)
     F                                     infsr(*pssr)
     F                                     commit(xCommitLVL)
      *
     FPEEKFLD   IF   E           K DISK    usropn
     F                                     infsr(*pssr)
     F                                     prefix(F_)
      *
      *====================================================*
      *  Referenzfelder & Konstanten                       *
      *====================================================*
      *
      *  Referenzfelder:
     D r_accMode       S              1A   based(ptrDummy)
     D r_bool          S              1A   based(ptrDummy)
     D r_copyRght      S                   like(r_msgDta  )
     D                                     based(ptrDummy)
     D r_dsp80         S                   like(r_bool    )
     D                                     based(ptrDummy)
     D r_type          S             10A   based(ptrDummy)
     D r_keys          S              3A   based(ptrDummy)
     D r_fieldNme      S             10A   based(ptrDummy)
     D r_file          S             10A   based(ptrDummy)
     D r_fKeyDsp       S             18A   based(ptrDummy)
    RD r_FLDL0100      S            532A   based(ptrDummy)
     D r_headTyp       S             10A   based(ptrDummy)
    RD r_hexBuf        S          65532A   based(ptrDummy)
    RD cHexBufLen      C                   const(65532)
    RD r_keyBuf        S           2000A   based(ptrDummy)
    RD cKeyBufLen      C                   const(2000)
     D r_lib           S             10A   based(ptrDummy)
     D r_mbr           S             10A   based(ptrDummy)
     D r_mod           S             10A   based(ptrDummy)
     D r_msgDta        S            512A   based(ptrDummy)
     D r_msgID         S              7A   based(ptrDummy)
     D r_msgType       S             10A   based(ptrDummy)
     D r_pgm           S             10A   based(ptrDummy)
     D r_pgmCallN      S             21A   based(ptrDummy)
     D r_pgmCmd        S             10A   based(ptrDummy)
     D r_pgmCmdDt      S            256A   based(ptrDummy)
     D r_proc          S            256A   based(ptrDummy)
    RD r_rcdBuf        S          32766A   based(ptrDummy)
    RD cRcdBufLen      C                   const(32766)
     D r_rcdNbr        S             10I 0 based(ptrDummy)
     D r_scnAid        S             10A   based(ptrDummy)
     D r_sqlStmt       S           2000A   based(ptrDummy)
     D r_user          S             10A   based(ptrDummy)
      *
      *  Integer & Binärwerte:
     D*r_bin2          S              4B 0 based(ptrDummy)
     D*r_bin4          S              9B 0 based(ptrDummy)
     D*r_int2          S              5I 0 based(ptrDummy)
     D r_int4          S             10I 0 based(ptrDummy)
      *
      *  Feedback Code:
     D r_fc            S             12A   based(ptrDummy)
      *
      *  Accessmode:
     D cRrnSeq         C                   CONST('0')
     D cKeySeq         C                   CONST('1')
     D cSqlSeq         C                   CONST('2')
      *
      *  Boolsche Werte:
     D bTrue           C                   CONST('1')
     D bFalse          C                   CONST('0')
     D bNotDef         C                   CONST('-')
      *
      *  Zustellarten von Nachrichten:
     D cTypInfo        C                   CONST('*INFO')
     D cTypInq         C                   CONST('*INQ')
     D cTypRqs         C                   CONST('*RQS')
     D cTypComp        C                   CONST('*COMP')
     D cTypDiag        C                   CONST('*DIAG')
     D cTypNotify      C                   CONST('*NOTIFY')
     D cTypEscape      C                   CONST('*ESCAPE')
     D cTypStatus      C                   CONST('*STATUS')
      *
      *  Ausgewählter Editor:
     D Editor          S             10A   inz
     D cEDITOR_HEX     C                   const('*HEX')
     D cEDITOR_STRING  C                   const('*STRING')
      *
      *  OVRDBF/OVRDSPF:
     D o_FILE          S             10A   inz
     D o_IN99          S              1A   inz
     D o_LVLCHK        S             10A   inz
     D o_MBR           S             10A   inz
     D o_OVRSCOPE      S             10A   inz
     D o_QCMD          S            256A   inz
     D o_RETURN        S              1A   inz
     D o_SECURE        S             10A   inz
     D o_SEQONLY       S             10A   inz
     D o_SHARE         S             10A   inz
     D o_toFile        S             10A   inz
     D o_toLib         S             10A   inz
     D o_QCMDL         S             15P 5 inz
      *
      *  Übertragen VARGRAPHIC Felder
     D x               S             10I 0 inz
     D offs            S             10I 0 inz
     D rem             S             10I 0 inz
     D len             S             10I 0 inz
      *
      *====================================================*
      *  Prototypen                                        *
      *====================================================*
      *
     D f_rtvFld        PR                  opdesc like(r_int4    )
     D  o_buffer                                  like(r_rcdBuf  )
     D                                            options(*varsize)
     D  i_buffer                           const  like(r_rcdBuf  )
     D  i_FLDL0100                                like(r_fldl0100)
     D  i_withLenByte                      const  like(r_bool    )
     D                                            options(*nopass)
      *
     D p_fldToBuf      PR
     D  io_buffer                                 like(r_rcdbuf  )
     D  i_fieldData                               like(r_rcdbuf  )
     D  i_FLDL0100                                like(r_fldl0100)
     D  i_withLenByte                      const  like(r_bool    )
     D                                            options(*nopass)
      *
     D f_len           PR                  opdesc like(r_int4    )
     D  i_string                  32767A   const options(*varsize)
      *
     D f_pgmCallN      PR                         like(r_pgmCallN)
     D  i_pgmNme                           const  like(r_pgm     )
      *
     D p_rmvPgmMg      PR
     D  i_pgmNme                           const  like(r_pgm     )
      *
     D p_movPgmMg      PR
     D  i_pgmNme                           const  like(r_pgm     )
      *
     D p_sndPgmMg      PR
     D  i_msgID                                   like(r_msgID   )
     D  i_msgDta                                  like(r_msgDta  )
     D  i_pgmNme                           const  like(r_pgm     )
     D  i_msgType                          const  like(r_msgType )
     D                                            options(*nopass)
      *
     D p_wrongKey      PR
     D  i_scnAID                           const  like(r_scnAID  )
     D  i_pgmNme                           const  like(r_pgm     )
      *
      *====================================================*
      *  List API Format FLDL0100 mit eigenen zusätzlichen *
      *  Feldern.                                          *
      *====================================================*
     D FLDL0100        DS
     D  F1FNME                 1     10
     D  F1DTYP                11     11
     D  F1USE                 12     12
     D  F1OBUF                13     16I 0
     D  F1IBUF                17     20I 0
     D  F1FLEN                21     24I 0
     D  F1DIGT                25     28I 0
     D  F1DECP                29     32I 0
     D  F1FTXT                33     82
     D  F1EDTC                83     84
     D  F1EDWL                85     88I 0
     D  F1EDWD                89    152
     D  F1COL1               153    172
     D  F1COL2               173    192
     D  F1COL3               193    212
     D  F1IFNM               213    222
     D  F1AFNM               223    252
     D  F1AFNL               253    256I 0
     D  F1NDBC               257    260I 0
     D  F1NALW               261    261
     D  F1HVRI               262    262
     D  F1DTFM               263    266
     D  F1DTSP               267    267
     D  F1VFMI               268    268
     D  F1FTCC               269    272I 0
     D  F1FDCC               273    276I 0
     D  F1CHCC               277    280I 0
     D  F1EWCC               281    284I 0
      *  zusätzliche Felder
     D  F1PFLD               501    512
     D  F1VFLD               513    522
     D  F1LFLD               523    532
      *
      *====================================================*
      *  Cursorposition                                    *
      *====================================================*
      *
     D                 DS
     D  WScnCsrRow             1      4I 0
     D  WScnCsrCol             5      8I 0
      *
     D workstn         DS
     D  wScnStatus            11     15S 0
     D  wScnOffset           241    242I 0
     D  wScnAID              369    369A
     D  wScnCsrPos           370    371I 0
      *
     D  xScnCsrRow     S                   like(wScnCsrRow) inz
      *
KEEP-D  keepCrsPos     C                   '0'
      *
      *====================================================*
      *  Systemdatenstruktur                               *
      *====================================================*
     D PGMSTS         SDS
      * Programmname
     D  PsPgmName                    10A
      * Programmfehlerstatus
     D  PsPgmStat                     5S 0
      * vorheriger Programmfehlerstatus
     D  PsPrevStat                    5S 0
      * Letzte Anweisungsnummer
     D  PsLastSeq                     8A
      * Letzte Unterroutine
     D  PsLastSubr                    8A
      * Anzahl übergebener Parameter
     D  PsNbrParm                     3S 0
      * Fehler-Msg
     D  PsMsgID                       7A
      *  Fehler-Art
     D   PsMsgPrfx                    3A   OVERLAY(PsMsgID)
      *  Fehler-Nummer
     D   PsMsgNbr                     4A   OVERLAY(PsMsgID:4)
      * MI-Instruktions-Nr.
     D  PsMI_Instr                    4A
      * Arbeitsbereich für Nachrichten
     D  PsWorkArea                   30A
      * Programmbiblitohek
     D  PsPgmLib                     10A
      * CPF-Fehlertext
     D  PsMsgText                    80A
      * Kz der Ausnahmebedingung
     D  PsAUBE                        4A
      * unbenutzt
     D  PsUnused_1                   16A
      * Datumsformat
     D  PsDatFmt                      8A
      * Ersten 2 stellen von *YEAR
     D  PsYear                        2S 0
      * Letzte Dateioperation: Dateiname
     D  PsFileOpr                     8A
      * Datei-Staus-Information
     D  PsFileStat                   35A
      * Jobname
     D  PsJob                        10A
      * Benutzer
     D  PsUser                       10A
      * Jobnummer
     D  PsJobNbr                      6S 0
      * Jobdatum, Aufbau wie UDATE
     D  PsJobD                        6S 0
      * Programm-Ausführungsdatum, Aufbau wie UDATE
     D  PsJobDate                     6S 0
      * Job-Zeit (HHMMSS)
     D  PsJobTime                     6S 0
      * Umwandlungsdatum
     D  PsCrtDate                     6A
      * Umwandlungszeit (HHMMSS)
     D  PsCrtTime                     6A
      * Compiler Version
     D  PsCompVer                     4A
      * Quellendatei
     D  PsSrcFile                    10A
      * Bibliothek mit Quellendatei
     D  PsSrcLib                     10A
      * Quellenteildatei
     D  PsSrcMbr                     10A
      * Program containing procedure
     D  PsPgmProc                    10A
      * Module containing procedure
     D  PsModProc                    10A
      * unbenutzt
     D  PsUnused_2                   76A
      *
      *============================================================*
      *    Definition F-Tasten Bildschirmfelder                    *
      *============================================================*
      *
     D                 DS
     D scrnFKeys                     18A   DIM(32)       INZ(*BLANKS)
     D  XXFKEY01               1     18A
     D  XXFKEY02              19     36A
     D  XXFKEY03              37     54A
     D  XXFKEY04              55     72A
     D  XXFKEY05              73     90A
     D  XXFKEY06              91    108A
     D  XXFKEY07             109    126A
     D  XXFKEY08             127    144A
     D  XXFKEY09             145    162A
     D  XXFKEY10             163    180A
     D  XXFKEY11             181    198A
     D  XXFKEY12             199    216A
     D  XXFKEY13             217    234A
     D  XXFKEY14             235    252A
     D  XXFKEY15             253    270A
     D  XXFKEY16             271    288A
     D  XXFKEY17             289    306A
     D  XXFKEY18             307    324A
     D  XXFKEY19             325    342A
     D  XXFKEY20             343    360A
     D  XXFKEY21             361    378A
     D  XXFKEY22             379    396A
     D  XXFKEY23             397    414A
     D  XXFKEY24             415    432A
     D  XXFKEY25             433    450A
     D  XXFKEY26             451    468A
     D  XXFKEY27             469    486A
     D  XXFKEY28             487    504A
     D  XXFKEY29             505    522A
     D  XXFKEY30             523    540A
     D  XXFKEY31             541    558A
     D  XXFKEY32             559    576A
      *
      *============================================================*
      *
     D PEEK21          S                   like(r_pgmCallN) inz
     D PEEK23          S                   like(r_pgmCallN) inz
     D PEEK32          S                   like(r_pgmCallN) inz
     D PEEK45          S                   like(r_pgmCallN) inz
     D PEEK59          S                   like(r_pgmCallN) inz
     D PEEK64          S                   like(r_pgmCallN) inz
      *
     D ISOT            C                   CONST('00.00.00')
     D HMST            C                   CONST('00:00:00')
     D EURT            C                   CONST('00.00.00')
     D JIST            C                   CONST('00:00:00')
      *
     D ISOL            C                   CONST('0001-01-01')
     D EURL            C                   CONST('01.01.0001')
     D JISL            C                   CONST('0001-01-01')
      *
     D ISOZ            C                   CONST('0001-01-01-00.00.00.000000')
      *
     D RclRsc          C                   CONST('RCLRSC LVL(*) ')
      *
     D xDsp80          S                   like(r_dsp80   )
     D xHeaderTyp      S                   like(r_headTyp )
     D xCopyRight      S                   like(r_copyRght)
     D xRcdNbr         S                   like(r_rcdNbr  )
     D XFile           S                   like(r_file    )
     D XLibrary        S                   like(r_lib     )
     D XMember         S                   like(r_mbr     )
     D xFunction       S             10A
     D xCommitLVL      S              1A
     D xIsUpdKey       S                   like(r_bool    )
     D xScreenNbr      S                   like(r_int4    )
     D xIsLower        S                   like(r_bool    )
     D xCsrRow         S                   like(r_int4    )
     D xCsrCol         S                   like(r_int4    )
     D xMsgID          S                   like(r_msgID   )
     D xMsgDta         S                   like(r_msgDta  )
      *
     D yPgm            S                   like(r_pgm     ) inz
     D yKey            S             10A   inz
     D yPosF24         S                   like(r_int4    ) inz
     D yFKeys          S                   like(r_fKeyDsp ) inz
     D                                     dim(32)
     D yNbrOfKeys      S                   like(r_int4    ) inz
     D yScnAID         S                   like(r_scnAID  ) inz
     D yPgmCmd         S                   like(r_pgmCmd  ) inz
     D yPgmCmdDt       S                   like(r_pgmCmdDt) inz
      *
     D yOutBuffer      S                   like(r_rcdBuf  ) inz
     D yOutBuffLn      S                   like(r_int4    ) inz
     D yMsgID          S                   like(r_msgID   ) inz
     D yMsgDta         S                   like(r_msgDta  ) inz
      *
      * - PEEK 45 -
     D yDsp80          S                   like(r_dsp80   ) inz
     D yHeaderTyp      S                   like(r_headTyp ) inz
     D yCopyright      S                   like(r_copyRght) inz
     D yFldName        S                   like(r_fieldNme) inz
     D yFldInhalt      S                   like(r_rcdBuf  ) inz
     D yProtect        S                   like(r_bool    ) inz(bFalse)
      *
      * - PEEK 59 -
    -D*yDsp80          S                   like(r_dsp80   ) inz
     D yType           S                   like(r_type    ) inz
     D yInpMsgID       S                   like(r_msgID   ) inz
     D yInpMsgDta      S                   like(r_msgDta  ) inz
     D yKeys           S                   like(r_keys    ) inz
    -D*yMsgID          S                   like(r_msgID   ) inz
    -D*yMsgDta         S                   like(r_msgDta  ) inz
      *
     D sfBot           S                   like(r_int4    ) inz
      *
     D isFound         S                   like(r_bool    ) inz(bFalse)
     D isError         S                   like(r_bool    ) inz(bFalse)
    R *  Standardwert für "Eingabe in Kleinbuchstaben"
LCAS-D isLower         S                   like(r_bool    ) inz(bFalse)
    R *  Standardwert für "Satz gesperrt einlesen"
RLCK-D isRcdLockDft    S                   like(r_bool    ) inz(bTrue )
    R *  Eingabe in Kleinbuchstaben erlaubt Ja/Nein
ALWL-D isAlwLower      S                   like(r_bool    ) inz(bTrue )
     D isVisible       S                   like(r_bool    ) inz(bFalse)
     D isCvtChar       S                   like(r_bool    ) inz(bFalse)
     D isRcdLocked     S                   like(r_bool    ) inz(bFalse)
      *
     D scnNbr          S                   like(r_int4    ) inz
     D nbrFKeys        C                   const(3)
      *
     D pgmErrFlag      S                   like(r_bool    ) inz(bFalse)
     D pgmRetMode      S              6A   INZ('*CANCL')
      *
     D buffStart       S                   like(r_int4    ) inz
     D buffEnd         S                   like(r_int4    ) inz
     D buffPos         S                   like(r_int4    ) inz
      *
     D keyChar         S              1A   inz
      *
     D pgmMsgID        S                   like(r_msgID   ) inz
     D pgmMsgDta       S                   like(r_msgDta  ) inz
      *
    R *  ... Feldefinitionen zur Bildschirmsteuerung
DEF1- *
     D EDT00001        S              1A   inz
     D EDT00002        S              1A   inz
     D EDT00003        S              1A   inz
     D EDT00004        S              1A   inz
     D EDT00005        S              1A   inz
     D EDT00006        S              1A   inz
     D EDT00007        S              1A   inz
     D EDT00008        S              1A   inz
     D EDT00009        S              1A   inz
     D EDT00010        S              1A   inz
     D EDT00011        S              1A   inz
     D EDT00012        S              1A   inz
     D EDT00013        S              1A   inz
     D EDT00014        S              1A   inz
     D EDT00015        S              1A   inz
      *
    R *  ... Konstanten für "Felder zu lang" (> 512 Byte und > 1024 Byte)
DEF2- *
     D LNG00001        C                   const('0')
     D MAX00001        C                   const('0')
     D LNG00002        C                   const('0')
     D MAX00002        C                   const('0')
     D LNG00003        C                   const('0')
     D MAX00003        C                   const('0')
     D LNG00004        C                   const('0')
     D MAX00004        C                   const('0')
     D LNG00005        C                   const('0')
     D MAX00005        C                   const('0')
     D LNG00006        C                   const('0')
     D MAX00006        C                   const('0')
     D LNG00007        C                   const('0')
     D MAX00007        C                   const('0')
     D LNG00008        C                   const('0')
     D MAX00008        C                   const('0')
     D LNG00009        C                   const('0')
     D MAX00009        C                   const('0')
     D LNG00010        C                   const('0')
     D MAX00010        C                   const('0')
     D LNG00011        C                   const('0')
     D MAX00011        C                   const('0')
     D LNG00012        C                   const('0')
     D MAX00012        C                   const('0')
     D LNG00013        C                   const('0')
     D MAX00013        C                   const('0')
     D LNG00014        C                   const('0')
     D MAX00014        C                   const('0')
     D LNG00015        C                   const('0')
     D MAX00015        C                   const('0')
      *
      *  Before-Image für Prüfung auf Datensatzänderung
      *  bei optimistischer Satzsperre
     D b4Image         DS                  likeds(RCD_DS   ) inz
      *
      *  Datenpuffer für Hex-Editor ...
    R *  ... umbenennen der Feldnamen
RNM1-D RCD_DS        E DS         32766    extname(FILE00)
     D P_00000001    E                     extfld(ALPHA)
     D V_00000002    E                     extfld(VARALPHA)
     D P_00000003    E                     extfld(INTEGER)
     D P_00000004    E                     extfld(PACKED)
     D P_00000005    E                     extfld(ZONED)
     D P_00000006    E                     extfld(DATE)
     D P_00000007    E                     extfld(TIME)
     D P_00000008    E                     extfld(TIMESTAMP)
     D P_00000009    E                     extfld(NOT_NULL)
     D P_00000010    E                     extfld(REAL)
     D P_00000011    E                     extfld(DOUBLE)
     D P_00000012    E                     extfld(GRAPHIC_NN)
     D P_00000013    E                     extfld(GRAPHIC)
     D V_00000014    E                     extfld(VARGRAP_NN)
     D V_00000015    E                     extfld(VARGRAP)
      *
     D pRCD_BUFFER     S               *   inz(%addr(RCD_DS))
     D RCD_BUFFER      S                   like(RCD_DS   )
     D                                     based(pRCD_BUFFER)
      *
    R *  ... umbenennen der externen Feldnamen
RNM2-IFFILE00
     I              ALPHA                       P_00000001
     I              VARALPHA                    V_00000002
     I              INTEGER                     P_00000003
     I              PACKED                      P_00000004
     I              ZONED                       P_00000005
     I              DATE                        P_00000006
     I              TIME                        P_00000007
     I              TIMESTAMP                   P_00000008
     I              NOT_NULL                    P_00000009
     I              REAL                        P_00000010
     I              DOUBLE                      P_00000011
     I              GRAPHIC_NN                  P_00000012
     I              GRAPHIC                     P_00000013
     I              VARGRAP_NN                  V_00000014
     I              VARGRAP                     V_00000015
      *
      *============================================================*
      * Program Entry
      *============================================================*
      *
     C     *entry        Plist
     C                   Parm                    xDsp80
     C                   Parm                    xHeaderTyp
     C                   Parm                    xCopyRight
     C                   Parm                    xRcdNbr
     C                   PARM                    XFile
     C                   PARM                    XLibrary
     C                   PARM                    XMember
     C                   Parm                    xFunction
     C                   Parm                    xCommitLVL
     C                   Parm                    xIsUpdKey
     C                   Parm                    xScreenNbr
     C                   Parm                    xIsLower
     C                   Parm                    xCsrRow
     C                   Parm                    xCsrCol
     C                   Parm                    xMsgID
     C                   Parm                    xMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK21
     C     P_PEEK21      Plist
     C                   Parm                    yScnAID
     C                   Parm                    yPgm
     C                   Parm                    yPgmCmd
     C                   Parm                    yPgmCmdDt
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK23
     C     P_PEEK23      Plist
     C                   Parm                    yPgm
     C                   Parm                    yKey
     C                   Parm                    yPosF24
     C                   Parm                    yFKeys
     C                   Parm                    yNbrOfKeys
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK32
     C     P_PEEK32      Plist
     C                   Parm                    yOutBuffer
     C                   Parm                    yOutBuffLn
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK59
     C     P_PEEK59      Plist
     C                   Parm                    yDsp80
     C                   Parm                    yType
     C                   Parm                    yInpMsgID
     C                   Parm                    yInpMsgDta
     C                   Parm                    yKeys
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *  Parameterliste für PEEK45/PEEK64
     C     P_PEEK_EDIT   Plist
     C                   Parm                    yDsp80
     C                   Parm                    yHeaderTyp
     C                   Parm                    yCopyright
     C                   Parm                    yFldName
     C                   Parm                    yFldInhalt
     C                   Parm                    yProtect
     C                   Parm                    yMsgID
     C                   Parm                    yMsgDta
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLD
     C     F_KEY         Klist
     C                   Kfld                    F_Field
      *
      *----------------------------------------------------*
      *
     C                   Eval      xMsgID  = ' '
     C                   Eval      xMsgDta = ' '
      *
      * - Setzen Eingabe in Kleinbuchstaben
     C                   If        xIsLower = bTrue or xIsLower = bFalse
     C                   Eval      isLower = xIsLower
     C                   Endif
      *
      * - Darstellen der Befehlstasten
     C                   Eval      sfBot = 1
      *
      * - Setzen Bildschirmattribute
     C                   Exsr      setScreen
      *
      * - Löschen Programmnachrichten
     C                   Callp     p_rmvPgmMg(psPgmName)
      *
      * - Öffnen der Dateien
     C                   Exsr      openFiles
      *
      * - Daten aktualisieren
     C                   Exsr      c_refresh
      *
      * - Anzeigen Copyright
     C                   Eval      pgmMsgID  = 'USR9999'
     C                   Eval      pgmMsgDta = xCopyRight
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
      *
      * - Setzen der Cursorposition
     C                   If        (keepCrsPos)
     C                   Eval      csrRow = xCsrRow
     C                   Eval      csrCol = xCsrCol
     C                   Else
     C                   Eval      csrRow = 0
     C                   Eval      csrCol = 0
     C                   Endif
      *
      *------------------*
      * Hauptschleife    *
      *------------------*
     C                   Do        *hival
      *
      * - Flag für nicht darstellbare Zeichen
     C                   Eval      isCvtChar = bFalse
      *
      * - Feldbezeichnung
     C                   If        xHeaderTyp = '*FIELDNAME'
     C                   Eval      *in70 = *off
     C                   Else
     C                   Eval      *in70 = *on
     C                   Endif
      *
      * - Lower-/Upper-Case
     C                   If        isLower = bTrue
     C                   Eval      *in71 = *on
     C                   Else
     C                   Eval      *in71 = *off
     C                   Endif
      *
      * - geschütze Felder nicht unterstreichen
     C                   Eval      *in72 = *off
      *
      * - Freigeben Schlüsselfelder
     C                   If        (xIsUpdKey = bTrue  )  or
     C                             (xFunction = '*ADD' )  or
     C                             (xFunction = '*COPY')
     C                   Eval      *in73 = *on
     C                   Else
     C                   Eval      *in73 = *off
     C                   Endif
      *
      * - Anzeigen Sperrstatus des Datensatz
     C                   If        xFunction = '*CHANGE'
     C                   Eval      *in74 = *on
     C                   If        isRcdLocked = bTrue
     C                   Eval      RLKMSGNBR = '0129'
     C                   Else
     C                   Eval      RLKMSGNBR = '0130'
     C                   Endif
     C                   Else
     C                   Eval      *in74 = *off
     C                   Eval      RLKMSGNBR = '0130'
     C                   Endif
      *
      * - Initialisieren Bildschirmnummer
     C                   If        (scnNbr < 1  ) or
    R *  ... eintragen max. Anzahl Bildschirmseiten
LSCN-C                             (scnNbr > 005)
     C                   Eval      scnNbr = 1
     C                   Else
      *   ... Wert ist im gültigen Bereich
     C                   Endif
      *
      * - Anzeigen "Weitere"/"Ende"
    R *  ... eintragen max. Anzahl Bildschirmseiten
LSCN-C                   If        (scnNbr = 005)
     C                   Eval      *in83 = *on
     C                   Else
     C                   Eval      *in83 = *off
     C                   Endif
      *
      * - Prüfen ...
     C                   Select
    R *  ... Bildschirmfelder auf nicht darstellbare Zeichen
CHKS- *
     C                   When      scnNbr = 001
     C                   Exsr      chkChar001
     C                   When      scnNbr = 002
     C                   Exsr      chkChar002
     C                   When      scnNbr = 003
     C                   Exsr      chkChar003
     C                   When      scnNbr = 004
     C                   Exsr      chkChar004
     C                   When      scnNbr = 005
     C                   Exsr      chkChar005
     C                   Other
     C                   Eval      scnNbr = 1
     C                   Exsr      chkChar001
     C                   Endsl
      *
      * - Ausgeben Nachricht
      *   "Felder mit nicht darstellbaren Zeichen wurden ausgeblendet"
     C                   Exsr      MSG8164
      *
      * - Anzeigen der Msg-Subfile
     C                   Eval      *in89 = *off
     C                   Write     MSGCTL
      *
      * - Anzeigen Kopf
     C                   Write     HEAD
      *
      * - Anzeigen F-Tasten
     C                   Write     FKEYS
      *
      * - Anzeigen der Befehlstasten
     C                   Select
     C                   When      (sfBot = 2) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT02
     C                   When      (sfBot = 3) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT03
     C                   When      (sfBot = 4) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT04
     C                   When      (sfBot = 5) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT05
     C                   When      (sfBot = 6) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT06
     C                   When      (sfBot = 7) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT07
     C                   When      (sfBot = 8) and
     C                             (yNbrOfKeys > nbrFKeys * (sfBot - 1))
     C                   Write     PBBOT08
     C                   Other
     C                   Write     PBBOT01
     C                   Eval      sfBot = 1
     C                   Endsl
      *
      * - Blättern ...
     C                   Select
    R *  ... generieren Auswahl der anzuzeigenden Bildschirmseite
SCRN- * - Blättern
     C                   When      scnNbr = 001
     C   71              Exfmt     LC001
     C  N71              Exfmt     UC001
     C                   When      scnNbr = 002
     C   71              Exfmt     LC002
     C  N71              Exfmt     UC002
     C                   When      scnNbr = 003
     C   71              Exfmt     LC003
     C  N71              Exfmt     UC003
     C                   When      scnNbr = 004
     C   71              Exfmt     LC004
     C  N71              Exfmt     UC004
     C                   When      scnNbr = 005
     C   71              Exfmt     LC005
     C  N71              Exfmt     UC005
     C                   Other
     C                   Exsr      chkChar001
    R *  ... 1. Bildschirmseite
     C   71              Exfmt     LC001
     C  N71              Exfmt     UC001
     C                   Eval      scnNbr = 1
     C                   Endsl
      *
      * - Zurückgeben aktuelle Bildschirmnummer
     C                   Eval      xScreenNbr = scnNbr
      *
      * - Löschen Programmnachrichten
     C                   Callp     p_rmvPgmMg(psPgmName)
      *
      * - Berechnen Zeile/Spalte
     C     wScnCsrPos    Div       256           wScnCsrRow
     C                   Mvr                     wScnCsrCol
      *
      * - Löschen der Cursorposition
     C                   Eval      csrRow = 0
     C                   Eval      csrCol = 0
      *
      * - Merken der Cursorposition beim Verlassen des Programs
     C                   Eval      xCsrRow = wScnCsrRow - wndTopRow
     C                   Eval      xCsrCol = wScnCsrCol - wndLeftCol - 1
      *
      * - Mappen der gedrückten Taste
      *   in Programmbefehl
     C                   Eval      yScnAID = wScnAID
     C                   Eval      yPgm    = 'PXXXXXXXX'
     C                   Call      PEEK21        P_Peek21
     C                   If        yMsgID <> ' '
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: psPgmName)
     C                   Iter
     C                   Endif
      *
      * - Abfragen der Befehlstasten
     C                   Select
      *   F3  - Beenden
     C                   When      yPgmCmd = '*EXIT'
     C                   Exsr      c_endPgm
     C                   Leave
      *   F5  - Aktualisieren
     C                   When      yPgmCmd = '*REFRESH'
     C                   Exsr      c_refresh
      *
      *   F6  - Umschalten LOWER-CASE
     C                   When      yPgmCmd = '*TGLLUCASE'
     C                   Exsr      c_tgLUCase
      *
      *       - Einschalten Lower-Case
     C                   When      yPgmCmd = '*LOWERCASE'
     C                   Exsr      c_lowCase
      *
      *       - Umschalten Upper-CASE
     C                   When      yPgmCmd = '*UPPERCASE'
     C                   Exsr      c_uppCase
      *
      *   F7  - Umschalten der Überschrift
     C                   When      yPgmCmd = '*HEADLINE'
     C                   Exsr      c_chgHead
      *
      *   F8  - Setzen/Löschen NULL Indicator
     C                   When      yPgmCmd = '*TGLNULL'
     C                   Exsr      c_tgNullInd
     C                   Exsr      keepCsrPos
      *
      *   F9  - Hex-Editor
     C                   When      yPgmCmd = '*HEXEDIT'
     C                   Exsr      c_fldHexEd
     C                   Exsr      keepCsrPos
      *
      *   F10 - String-Editor
     C                   When      yPgmCmd = '*STREDIT'
     C                   Exsr      c_fldStrEd
     C                   Exsr      keepCsrPos
      *   F12 - Beenden
     C                   When      yPgmCmd = '*CANCEL'
     C                   Exsr      c_endPgm
     C                   Leave
      *   F13 - Umschalten Satzsperre
     C                   When      yPgmCmd = '*TGLRCDLCK'
     C                   Exsr      c_tgRcdLock
     C                   Exsr      keepCsrPos
      *   F17 - Anfang Datensatz
     C                   When      yPgmCmd = '*TOP'
     C                   Eval      scnNbr = 1
      *   F18 - Ende Datensatz
     C                   When      yPgmCmd = '*BOT'
    R *  ... eintragen max. Anzahl Bildschirmseiten
LSCN-C                   Eval      scnNbr =  005
      *
      *   F24 - Weitere Tasten
     C                   When      yPgmCmd = '*MOREKEYS'
     C                   Exsr      c_moreKeys
      *   Enter
     C                   When      yPgmCmd = '*ENTER'
     C                   Exsr      updateFile
     C                   If        isError = bFalse
     C                   Leave
     C                   Endif
      *   Page up
     C                   When      (yPgmCmd = '*PAGEUP')   and
    R *  ... eintragen max. Anzahl Bildschirmseiten
LSCN-C                             (scnNbr < 005)
     C                   Eval      scnNbr = scnNbr + 1
      *   Page down
     C                   When      (yPgmCmd = '*PAGEDOWN') and
     C                             (scnNbr  > 1 )
     C                   Eval      scnNbr = scnNbr - 1
      *   Sonstige Tasten
     C                   Other
     C                   Callp     p_wrongKey(wScnAID: psPgmName)
     C                   Endsl
      *
     C                   Enddo
      *
      *   Beenden Programm
     C     ende          Tag
      *
      *   Schließen Dateien
     C                   Exsr      closeFiles
      *
      *   Merken Eingabe in Kleinbuchstaben
     C                   Eval      xIsLower = isLower
      *
     C                   Eval      *inlr = *on
      *
      *===================================================*
      *    Einlesen Datensatz & füllen Bildschirm         *
      *===================================================*
      *
     C     readRecord    Begsr
      *
      *  Einlesen Datensatz für ...
     C                   Select
      *  ... update
     C                   When      xFunction = '*CHANGE'
     C                   Eval      HDGMSGNBR = '0063'
     C                   If        isRcdLockDft = bTrue
     C     xRcdNbr       Chain(E)  FFILE00
     C                   Eval      isRcdLocked = bTrue
     C                   Else
     C     xRcdNbr       Chain(NE) FFILE00
     C                   Eval      isRcdLocked = bFalse
     C                   Endif
     C                   Eval      isFound = %found(FILE00)
     C                   Eval      isError = %error()
      *  ... copy
     C                   When      xFunction = '*COPY'
     C                   Eval      HDGMSGNBR = '0064'
     C     xRcdNbr       Chain(NE) FFILE00
     C                   Eval      isRcdLocked = bFalse
     C                   Eval      isFound = %found(FILE00)
     C                   Eval      isError = %error()
      *  ... add
     C                   When      xFunction = '*ADD'
     C                   Eval      HDGMSGNBR = '0065'
     C                   Exsr      clearRecord
     C                   Eval      isRcdLocked = bTrue
     C                   Eval      isFound = bTrue
     C                   Eval      isError = bFalse
      *  ... FEHLER!!!
     C                   Other
     C                   Eval      isRcdLocked = bFalse
     C                   Eval      pgmMsgID  = 'USR8113'
     C                   Eval      pgmMsgDta = xFunction
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
     C                   Callp     p_movPgmMg(psPgmName)
     C                   Goto      Ende
     C                   Endsl
      *
      *  Fehler aufgetreten ...
     C                   If        isError = bTrue
     C                   Eval      pgmMsgID  = 'USR8156'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
     C                   Callp     p_movPgmMg(psPgmName)
     C                   Goto      ende
     C                   Endif
      *
      *  ... Satz nicht gefunden
     C                   If        isFound = bFalse
     C                   Eval      pgmMsgID  = 'USR8120'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
     C                   Callp     p_movPgmMg(psPgmName)
     C                   Goto      ende
     C                   Endif
      *
     C                   Endsr
      *
      *===================================================*
      *    Löschen aller Felder im Datensatz.             *
      *===================================================*
      *
     C     clearRecord   Begsr
      *
     C                   Clear                   FFILE00
      *
     C                   Eval      %nullind(P_00000001) =*OFF
     C                   Eval      %nullind(V_00000002) =*OFF
     C                   Eval      %nullind(P_00000003) =*OFF
     C                   Eval      %nullind(P_00000004) =*OFF
     C                   Eval      %nullind(P_00000005) =*OFF
     C                   Eval      %nullind(P_00000006) =*OFF
     C                   Eval      %nullind(P_00000007) =*OFF
     C                   Eval      %nullind(P_00000008) =*OFF
     C                   Eval      %nullind(P_00000013) =*OFF
     C                   Eval      %nullind(V_00000015) =*OFF
      *
     C                   Endsr
      *
      *============================================================*
      *    DataToScn     Übertragen der Dateifelder in die         *
      *                  Bildschirmfelder                          *
      *============================================================*
      *
     C     dataToScn     BEGSR
      *
      *  Anzeigen relative Satznummer
     C                   Eval      xxRcdN = xRcdNbr
      *
      *  Anzuzeigender Bildschirm
     C                   Eval      scnNbr = xScreenNbr
      *
      *  Übertragen Dateifelder
      *  in die Bildschirmfelder ...
    R *  ... generieren MOVEL extField => intField (ToScreen)
TSCN- *
     C                   Exsr      s_P_00000001
     C                   Exsr      s_V_00000002
     C                   Exsr      s_P_00000003
     C                   Exsr      s_P_00000004
     C                   Exsr      s_P_00000005
     C                   Exsr      s_P_00000006
     C                   Exsr      s_P_00000007
     C                   Exsr      s_P_00000008
     C                   Exsr      s_P_00000009
     C                   Exsr      s_P_00000010
     C                   Exsr      s_P_00000011
     C                   Exsr      s_P_00000012
     C                   Exsr      s_P_00000013
     C                   Exsr      s_V_00000014
     C                   Exsr      s_V_00000015
      *
    R *  ... prüfen auf ISO-Felder
ISO - *
     C                   If        FLD00006= ' '
     C                   Eval      FLD00006 = ISOL
     C                   Endif
      *
     C                   If        FLD00007= ' '
     C                   Eval      FLD00007 = ISOT
     C                   Endif
      *
     C                   If        FLD00008= ' '
     C                   Eval      FLD00008 = ISOZ
     C                   Endif
      *
      *
     C                   Endsr
      *
      *============================================================*
      *    c_endPgm      F3/F12 - Programm beenden                 *
      *============================================================*
      *
     C     c_endPgm      Begsr
      *
      * - Löschen Programmnachrichten
     C                   Callp     p_rmvPgmMg(psPgmName)
      *
      * - Zurückgeben Abbruchmeldung
     C                   Eval      xMsgID  = 'USR8100'
     C                   Eval      xMsgDta = yPgmCmd
      *
     C                   Endsr
      *
      *============================================================*
      *    c_refresh     F5 - Daten aktualisieren                  *
      *============================================================*
      *
     C     c_refresh     Begsr
      *
      * - IsVisible Bezugszahlen
      *   Einblenden aller Felder
     C                   Exsr      EnableEdit
      *
      * - Einlesen der Daten und füllen Bildschirm
     C                   Exsr      readRecord
     C                   Exsr      dataToScn
      *
      * - Merken aktuelles Image
     C                   Eval      b4Image = RCD_DS
      *
     C                   Endsr
      *
      *============================================================*
      *    c_tgLUCase    F6  - Umschalten Lower/Upper-Case         *
      *============================================================*
      *
     C     c_tgLUCase    Begsr
      *
     C                   If        isLower = bFalse
     C                   Exsr      c_lowCase
     C                   Else
     C                   Exsr      c_uppCase
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    c_lowCase     F6  - Einschalten Lower-Case              *
      *============================================================*
      *
     C     c_lowCase     Begsr
      *
     C                   If        isAlwLower = bTrue
     C                   Eval      isLower = bTrue
     C                   Else
     C                   Eval      pgmMsgID  = 'USR8215'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : 'PEEK05')
     C                   Endif
      *
      *  Beibehalten der Cursorposition ...
     C                   Exsr      keepCsrPos
      *
     C                   Endsr
      *
      *============================================================*
      *    c_uppCase     F6  - Einschalten Upper-Case              *
      *============================================================*
      *
     C     c_uppCase     Begsr
      *
     C                   Eval      isLower = bFalse
      *
      *  Beibehalten der Cursorposition ...
     C                   Exsr      keepCsrPos
      *
     C                   Endsr
      *
      *============================================================*
      *    c_chgHead     F7  - Umschalten der Überschrift          *
      *============================================================*
      *
     C     c_chgHead     Begsr
      *
     C                   If        XHeaderTyp = '*FIELDNAME'
     C                   Eval      xHeaderTyp = '*FIELDTEXT'
     C                   Else
     C                   Eval      xHeaderTyp = '*FIELDNAME'
     C                   Endif
      *
      *  Beibehalten der Cursorposition ...
     C                   Exsr      keepCsrPos
      *
     C                   Endsr
      *
      *============================================================*
      *    c_tgRcdLock   F13 - Umschalten Satzsperre               *
      *============================================================*
      *
     C     c_tgRcdLock   Begsr
      *
     C                   If        xFunction <> '*CHANGE'
     C                   Eval      pgmMsgID  = 'USR8231'
     C                   Eval      pgmMsgDta = ''
     C                   Callp     p_sndPgmMg(pgmMsgID: pgmMsgDta: psPgmName)
     C                   Leavesr
     C                   Endif
      *
     C                   If        isRcdLocked = bTrue
     C                   Exsr      unlockRecord
     C                   Else
      *
      *  ... vergleichen Before-Images auf Abweichungen
     C                   Exsr      readRecord
     C                   If        b4Image <> RCD_DS
      *      ... freigeben Datensatz, bei unterschiedlichen Images
      *          und fragen Benutzer, wie es weiter gehen soll (dennoch aktualis
     C                   Eval      yDsp80     = xDsp80
     C                   Eval      yType      = '*QUESTION'
     C                   Eval      yInpMsgID  = 'USR8232'
     C                   Eval      yInpMsgDta = ''
     C                   Eval      yKeys      = 'YC'
     C                   Eval      yMsgID     = ''
     C                   Eval      yMsgDta    = ''
     C                   Call(E)   PEEK59        P_Peek59
     C                   If        %error()
     C                   Eval      isError = bTrue
     C                   Leavesr
     C                   Endif
      *      ... abbrechen der Operation, wenn vom Benutzer gewünscht
     C                   If        yMsgID = 'USR8190' and yMsgDta <> '*YES'
     C                   Callp     p_sndPgmMg(yMsgID : yMsgDta : psPgmName)
     C                   Eval      isError = bTrue
     C                   Leavesr
     C                   Endif
     C                   Endif
      *
      *      ... sperren Datensatz für UPDATE
     C                   Exsr      lockRecord
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    c_moreKeys    F24 - Weitere Tasten                      *
      *============================================================*
      *
     C     c_moreKeys    Begsr
      *
     C                   Eval      sfBot = sfBot + 1
      *
     C                   Endsr
      *
      *===================================================*
      *    Verarbeiten der Eingaben                       *
      *===================================================*
      *
     C     updateFile    Begsr
      *
      *  Sperren Datensatz, wenn nicht bereits geschehen ...
     C                   If        (xFunction = '*CHANGE') and
     C                             (isRcdLocked = bFalse)
     C                   Exsr      lockRecord
     C                   If        (isFound = bFalse) or (isError = bTrue)
     C                   Leavesr
     C                   Endif
      *  ... vergleichen Before-Images auf Abweichungen
     C                   If        b4Image <> RCD_DS
      *      ... freigeben Datensatz, bei unterschiedlichen Images
      *          und fragen Benutzer, wie es weiter gehen soll (dennoch aktualis
     C                   Exsr      unlockRecord
     C                   Eval      yDsp80     = xDsp80
     C                   Eval      yType      = '*QUESTION'
     C                   Eval      yInpMsgID  = 'USR8225'
     C                   Eval      yInpMsgDta = ''
     C                   Eval      yKeys      = 'YC'
     C                   Eval      yMsgID     = ''
     C                   Eval      yMsgDta    = ''
     C                   Call(E)   PEEK59        P_Peek59
     C                   If        %error()
     C                   Eval      isError = bTrue
     C                   Leavesr
     C                   Endif
      *      ... abbrechen der Operation, wenn vom Benutzer gewünscht
     C                   If        yMsgID = 'USR8190' and yMsgDta <> '*YES'
     C                   Callp     p_sndPgmMg(yMsgID : yMsgDta : psPgmName)
     C                   Eval      isError = bTrue
     C                   Leavesr
     C                   Endif
      *
      *      ... sperren Datensatz für UPDATE
     C                   If        (isRcdLocked = bFalse)
     C                   Exsr      lockRecord
     C                   If        (isFound = bFalse) or (isError = bTrue)
     C                   Leavesr
     C                   Endif
     C                   Endif
      *
     C                   Endif
     C                   Endif
      *
    R *  ... prüfen auf ISO-Felder
ISO - *
     C                   If        FLD00006= ' '
     C                   Eval      FLD00006 = ISOL
     C                   Endif
      *
     C                   If        FLD00007= ' '
     C                   Eval      FLD00007 = ISOT
     C                   Endif
      *
     C                   If        FLD00008= ' '
     C                   Eval      FLD00008 = ISOZ
     C                   Endif
      *
      *
      *  Übertragen Felder vom Bildschirm
      *  in die Dateifelder ...
    R *  ... generieren MOVEL intField => extField (FromScreen)
FSCN- *
     C                   Exsr      chkChar001
     C                   Exsr      chkChar002
     C                   Exsr      chkChar003
     C                   Exsr      chkChar004
     C                   Exsr      chkChar005
      *
     C                   If        EDT00001 = '1'
     C                             and not %nullind(P_00000001)
     C                   Exsr      f_P_00000001
     C                   Endif
     C                   If        EDT00002 = '1'
     C                             and not %nullind(V_00000002)
     C                   Exsr      f_V_00000002
     C                   Endif
     C                   If        EDT00003 = '1'
     C                             and not %nullind(P_00000003)
     C                   Exsr      f_P_00000003
     C                   Endif
     C                   If        EDT00004 = '1'
     C                             and not %nullind(P_00000004)
     C                   Exsr      f_P_00000004
     C                   Endif
     C                   If        EDT00005 = '1'
     C                             and not %nullind(P_00000005)
     C                   Exsr      f_P_00000005
     C                   Endif
     C                   If        EDT00006 = '1'
     C                             and not %nullind(P_00000006)
     C                   Exsr      f_P_00000006
     C                   Endif
     C                   If        EDT00007 = '1'
     C                             and not %nullind(P_00000007)
     C                   Exsr      f_P_00000007
     C                   Endif
     C                   If        EDT00008 = '1'
     C                             and not %nullind(P_00000008)
     C                   Exsr      f_P_00000008
     C                   Endif
     C                   If        EDT00009 = '1'
     C                   Exsr      f_P_00000009
     C                   Endif
     C                   If        EDT00010 = '1'
     C                   Exsr      f_P_00000010
     C                   Endif
     C                   If        EDT00011 = '1'
     C                   Exsr      f_P_00000011
     C                   Endif
     C                   If        EDT00012 = '1'
     C                   Exsr      f_P_00000012
     C                   Endif
     C                   If        EDT00013 = '1'
     C                             and not %nullind(P_00000013)
     C                   Exsr      f_P_00000013
     C                   Endif
     C                   If        EDT00014 = '1'
     C                   Exsr      f_V_00000014
     C                   Endif
     C                   If        EDT00015 = '1'
     C                             and not %nullind(V_00000015)
     C                   Exsr      f_V_00000015
     C                   Endif
      *
      *  Abschließen der Verarbeitung ...
     C                   Select
      *  ... für update
     C                   When      xFunction = '*CHANGE'
     C                   Update(E) FFILE00
     C                   Eval      isError = %error()
      *  ... für copy
     C                   When      xFunction = '*COPY'
     C                   Write(E)  FFILE00
     C                   Eval      isError = %error()
      *  ... für add
     C                   When      xFunction = '*ADD '
     C                   Write(E)  FFILE00
     C                   Eval      isError = %error()
      *  ... FEHLER!!!
     C                   Other
     C                   Unlock(E) FILE00
     C                   Eval      isError = %error()
     C                   Endsl
      *
     C                   If        isError = bTrue
      *  Update/write fehlgeschlagen ...
     C   95              Rolbk
     C  N95              Unlock    File00
     C                   Exsr      ReadRecord
      ***                Exsr      DataToScn
      *  Setzen Fehler-Flag ...
     C                   Eval      isError = bTrue
     C                   Else
      *  Updatze/write OK ...
     C   95              Commit
     C  N95              Unlock    File00
      *  Löschen Fehler-Flag ...
     C                   Eval      isError = bFalse
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    lockRecord    Einlesen Datensatz mit Sperre             *
      *============================================================*
      *
     C     lockRecord    Begsr
      *
      *  Lesen Datensatz mit Satzsperre für nachfolgenden UPDATE ...
     C     xRcdNbr       Chain(E)  FFILE00
     C                   Eval      isFound = %found(FILE00)
     C                   Eval      isError = %error()
      *  ... Fehler aufgetreten
     C                   If        isError = bTrue
     C                   Eval      pgmMsgID  = 'USR8156'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
    R ***                Callp     p_movPgmMg(psPgmName)
    R ***                Goto      ende
     C                   Endif
      *  ... Satz nicht gefunden
     C                   If        isFound = bFalse
     C                   Eval      pgmMsgID  = 'USR8120'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
    R ***                Callp     p_movPgmMg(psPgmName)
    R ***                Goto      ende
     C                   Endif
      *
     C                   If        (isError = bFalse) and (isFound = bTrue)
     C                   Eval      isRcdLocked = bTrue
     C                   Else
     C                   Eval      isRcdLocked = bFalse
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    unlockRecord  Freigeben Datensatzsperre                 *
      *============================================================*
      *
     C     unlockRecord  Begsr
      *
     C                   Unlock    FILE00
      *
     C                   Eval      isRcdLocked = bFalse
      *
     C                   Endsr
      *
      *============================================================*
      *    chkChar       Prüfen auf nicht darstellbare Zeichen     *
      *                  und Schlüsselfeld                         *
      *============================================================*
      *
     C     chkChar       Begsr
      *
     C     F_Key         Chain     FPEEKFLD
     C                   If        not %found(PEEKFLD)
      * - Zugriff fehlgeschlagen, Feld sperren
     C                   Eval      yMsgID  = 'USR8163'
     C                   Eval      yMsgDta = ' '
     C                   Clear                   FLDL0100
     C                   Else
      *
     C                   Eval      FLDL0100 = F_FFD
      *
      *  ... prüfen auf nicht darstellbare Zeichen
      *      ... Konvertieren nicht darstellbarer Zeichen
     C     ' '           Checkr    yOutBuffer:512yOutBuffLn
     C                   Call(E)   PEEK32        P_Peek32
     C                   If        %error()
     C                   Eval      yMsgID  = 'USR8163'
     C                   Eval      yMsgDta = ' '
     C                   Endif
     C                   Endif
      *
      *  Nachricht auswerten und ...
     C                   If        yMsgID <> ' '
      *  ... Felder ausblenden
     C                   Eval      isVisible = *off
     C                   Eval      isCvtChar = bTrue
     C                   Else
      *  ... Felder einblenden
     C                   Eval      isVisible = *on
     C                   Endif
      *
      *  Schlüsselfeld?
     C                   If        (F_DESC <> ' ')
      *  ... JA
     C                   Eval      keyChar = '>'
     C                   Else
      *  ... NEIN
     C                   Eval      keyChar = ':'
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    Öffnen der Dateien                                      *
      *============================================================*
      *
     C     openFiles     Begsr
      *
      *  Überschreiben DB-Datei:
     C                   Eval      o_File     = 'FILE00'
     C                   Eval      o_toFile   = xFile
     C                   Eval      o_toLib    = xLibrary
     C                   Eval      o_Mbr      = xMember
     C                   Eval      o_OvrScope = '*CALLLVL'
     C                   Eval      o_Share    = '*NO'
     C                   Eval      o_SeqOnly  = '*NO'
     C                   Eval      o_Secure   = '*YES'
     C                   Exsr      OvrDbf
      *
      *  Überschreiben Bildschirmdatei:
     C                   Eval      o_File     = 'DSPF'
     C                   Eval      o_toFile   = 'F' + %subst(PsPgmName: 2)
     C                   Eval      o_toLib    = PsPgmLib
     C                   Eval      o_OvrScope = '*CALLLVL'
     C                   Exsr      OvrDspF
      *
      *  Datei öffnen ...
     C                   If        xCommitLVL = '0'
      *  ... ohne Commit
     C                   Eval      *in95 = *off
     C                   Else
      *  ... mit Commit
     C                   Eval      *in95 = *on
     C                   Endif
      *
     C                   Open(E)   FILE00
     C                   If        %error()
      *  Datei konnte nicht geöffnet werden
     C                   Callp     p_movPgmMg(psPgmName)
     C                   Eval      pgmMsgID  = 'USR0005'
     C                   Eval      pgmMsgDta = 'FILE00'
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta :
     C                                        psPgmName:'*ESCAPE'  )
     C                   Goto      Ende
     C                   Endif
      *
      *  Öffnen der Bildschirmdatei
     C                   Open(E)   DSPF
     C                   If        %error()
      *  Datei konnte nicht geöffnet werden
     C                   Callp     p_movPgmMg(psPgmName)
     C                   Eval      pgmMsgID  = 'USR0005'
     C                   Eval      pgmMsgDta = 'DSPF'
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta :
     C                                        psPgmName:'*ESCAPE'  )
     C                   Goto      Ende
     C                   Endif
      *
      *  Öffnen der Feldbeschreibung
     C                   Open(E)   PEEKFLD
     C                   If        %error()
      *  Datei konnte nicht geöffnet werden
     C                   Callp     p_movPgmMg(psPgmName)
     C                   Eval      pgmMsgID  = 'USR0005'
     C                   Eval      pgmMsgDta = 'PEEKFLD'
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta :
     C                                        psPgmName:'*ESCAPE'  )
     C                   Goto      Ende
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    Schließen der Dateien                                   *
      *============================================================*
      *
     C     closeFiles    Begsr
      *
      *  Falls irgendetwas unerwartetes schief
      *  gelaufen sein sollte ...
     C   95              Rolbk
      *
     C                   Close     PEEKFLD
     C                   Close     FILE00
     C                   Close     DSPF
      *
      *  Entfernen der Triggerprogramme aus dem
      *  Arbeitsspeicher ...
     C                   Eval      cmd    = RclRsc
     C                   Eval      cmdLen = 40
     C                   Call      'QCMDEXC'
     C                   Parm                    cmd              40
     C                   Parm                    cmdLen           15 5
      *
     C                   Endsr
      *
      *============================================================*
      *    keepCsrPos    Beibehalten der Cursorposition            *
      *============================================================*
      *
     C     keepCsrPos    Begsr
      *
      *  Beibehalten der Cursorosition
     C                   Eval      csrRow = wScnCsrRow - wndTopRow
     C                   Eval      csrCol = wScnCsrCol - wndLeftCol - 1
      *
     C                   Endsr
      *
      *============================================================*
      *    setScreen     Einstellen 132/80-Zeichen Auflösung       *
      *============================================================*
      *
     C     setScreen     Begsr
      *
     C                   If        xDsp80 = '0'
      *   132-Zeichen Anzeige
     C                   Eval      *in88 = *off
     C                   Eval      wndTopRow  = 1
     C                   Eval      wndLeftCol = 40
     C                   Else
      *    80-Zeichen Anzeige
     C                   Eval      *in88 = *on
     C                   Eval      wndTopRow  = 1
     C                   Eval      wndLeftCol = 7
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    *pssr         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *pssr         Begsr
      *
     C                   If        PgmErrFlag = bFalse
     C                   Eval      pgmErrFlag = bTrue
     C   95              Rolbk
     C                   Dump
     C                   Eval      pgmRetMode = '*CANCL'
     C                   Endif
      *
     C                   Eval      *inlr = *on
      *
     C                   Endsr     pgmRetMode
      *
      *============================================================*
      *    *inzsr        Initialisierung                           *
      *============================================================*
      *
     C     *inzsr        Begsr
      *
     C                   Eval      PEEK21 = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23 = f_pgmCallN('PEEK23')
     C                   Eval      PEEK32 = f_pgmCallN('PEEK32')
     C                   Eval      PEEK45 = f_pgmCallN('PEEK45')
     C                   Eval      PEEK59 = f_pgmCallN('PEEK59')
     C                   Eval      PEEK64 = f_pgmCallN('PEEK64')
      *
     C                   Eval      pgmQ = '*'
      *
     C                   Eval      pgmErrFlag = bFalse
      *
      *  Einlesen der Tastenbelegung
     C                   Eval      yPgm    = 'PXXXXXXXX'
     C                   Eval      yKey    = '*ALL'
     C                   Eval      yPosF24 = 3
     C                   Call      PEEK23        P_Peek23
     C                   Movea (P) yFKeys        scrnFKeys
      *
     C                   Endsr
      *
      *====================================================*
      *  fromBuffer - Übertragen Rohdaten aus IO-Puffer    *
      *====================================================*
      *
     C     fromBuffer    Begsr
      *
     C                   Eval      F_Field = yFldName
     C     F_Key         Chain     FPEEKFLD
     C                   If        %found(PEEKFLD)
     C                   Eval      FLDL0100 = F_FFD
      *
     C                   Callp     f_rtvFld(yFldInhalt:
     C                                      Rcd_Buffer:
     C                                      FLDL0100  :
     C                                      bFalse    )
      *
     C                   If        Editor = cEDITOR_STRING
     C                   Call      PEEK64        P_PEEK_EDIT
     C                   Else
     C                   Call      PEEK45        P_PEEK_EDIT
     C                   Endif
      *
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      ToBuffer
     C                   Endif
     C                   Endif
      *
     C                   Endsr
      *
      *====================================================*
      *  toBuffer   - Übertragen Rohdaten nach IO-Puffer   *
      *====================================================*
      *
     C     toBuffer      Begsr
      *
     C                   Callp     p_fldToBuf(Rcd_Buffer :
     C                                        yFldInhalt :
     C                                        FLDL0100   :
     C                                        bFalse     )
      *
     C                   Endsr
      *
      *====================================================*
      *  MSG8164    - Ausgeben Fehlernachricht             *
      *  Felder mit nicht darstellbaren Zeichen!           *
      *====================================================*
      *
     C     MSG8164       Begsr
      *
      * - Ausgeben Nachricht bei nicht
      *   darstellbaren Zeichen
     C                   If        isCvtChar = bTrue
      *  ... vorhanden
     C                   Eval      pgmMsgID  = 'USR8164'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
     C                   Else
      *  ... nicht vorhanden
     C                   Endif
      *
     C                   Endsr
      *
      *====================================================*
      *  MSG8208    - Ausgeben Fehlernachricht             *
      *  Nur INPUT-Felder können nicht geändert werden.    *
      *====================================================*
      *
     C     MSG8208       Begsr
      *
     C                   Eval      pgmMsgID  = 'USR8208'
     C                   Eval      pgmMsgDta = ' '
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
      *
     C                   Endsr
      *
      *====================================================*
      *  USR8193    - Ausgeben Fehlernachricht             *
      *  Felder &1 enthält nicht darstellbaren Zeichen und *
      *  kann daher nicht mit dem Texteditor bearbeitet    *
      *  werden.                                           *
      *====================================================*
      *
     C     USR8193       Begsr
      *
     C                   Eval      pgmMsgID  = 'USR8193'
     C                   Eval      pgmMsgDta = yFldName
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
      *
     C                   Endsr
      *
      *====================================================*
      *  MSG8221    - Ausgeben Fehlernachricht             *
      *  Editor nicht zulässig. Feld &1 hat ungültigen     *
      *  Datentyp.                                         *
      *====================================================*
      *
     C     MSG8221       Begsr
      *
     C                   Eval      pgmMsgID  = 'USR8221'
     C                   Eval      pgmMsgDta = F1FNME
     C                   Callp     p_sndPgmMg(pgmMsgID : pgmMsgDta : psPgmName)
      *
     C                   Endsr
      *
      *====================================================*
      *  OvrDbf     - Überschreiben DB-Datei               *
      *====================================================*
      *
     C     OvrDbf        Begsr
      *
      *  Überschreiben mit neuer Datei ...
      *     OVRDBF
     C                   MOVEL(P)  'OVRDBF'      o_QCMD
      *     File
     C                   CAT       'FILE(':1     o_QCMD
     C                   CAT       o_FILE:0      o_QCMD
     C                   CAT       ')':0         o_QCMD
      *     ToFile
     C                   CAT       'TO':1        o_QCMD
     C                   CAT       'FILE(':0     o_QCMD
     C     o_toLib       IFNE      *BLANKS
     C                   CAT       o_toLib:0     o_QCMD
     C                   CAT       '/':0         o_QCMD
     C                   ENDIF
     C                   CAT       o_toFile:0    o_QCMD
     C                   CAT       ')':0         o_QCMD
      *     Mbr
     C     o_MBR         IFNE      *BLANKS
     C                   CAT       'MBR(':1      o_QCMD
     C                   CAT       o_MBR:0       o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *     OvrScope
     C     o_OVRSCOPE    IFNE      *BLANKS
     C                   CAT       'OVR':1       o_QCMD
     C                   CAT       'SCOPE(':0    o_QCMD
     C                   CAT       o_OVRSCOPE:0  o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *     Share
     C     o_SHARE       IFNE      *BLANKS
     C                   CAT       'SHARE(':1    o_QCMD
     C                   CAT       o_SHARE:0     o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *     SeqOnly
     C     o_SEQONLY     IFNE      *BLANKS
     C                   CAT       'SEQ':1       o_QCMD
     C                   CAT       'ONLY(':0     o_QCMD
     C                   CAT       o_SEQONLY:0   o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *     Secure
     C     o_SECURE      IFNE      *BLANKS
     C                   CAT       'SECURE(':1   o_QCMD
     C                   CAT       o_SECURE:0    o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *     Level Check
     C     o_LVLCHK      IFNE      *BLANKS
     C                   CAT       'LVLCHK(':1   o_QCMD
     C                   CAT       o_LVLCHK:0    o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *
     C                   MOVEL(P)  *IN99         o_IN99
      *
     C                   Z-ADD     256           o_QCMDL
     C                   CALL      'QCMDEXC'                            99
     C                   PARM                    o_QCMD
     C                   PARM                    o_QCMDL
      *
     C                   MOVEL(P)  *IN99         o_RETURN
      *
     C                   MOVEL(P)  o_IN99        *IN99
      *
     C                   Endsr
      *
      *====================================================*
      *  OvrDspF    - Überschreiben Bildschirmdatei        *
      *====================================================*
      *
     C     OvrDspF       Begsr
      *
      *  Überschreiben mit neuer Datei ...
      *     OVRDSPF
     C                   MOVEL(P)  'OVRDSPF'     o_QCMD
      *     File
     C                   CAT       'FILE(':1     o_QCMD
     C                   CAT       o_FILE:0      o_QCMD
     C                   CAT       ')':0         o_QCMD
      *     ToFile
     C                   CAT       'TO':1        o_QCMD
     C                   CAT       'FILE(':0     o_QCMD
     C     o_toLib       IFNE      *BLANKS
     C                   CAT       o_toLib:0     o_QCMD
     C                   CAT       '/':0         o_QCMD
     C                   ENDIF
     C                   CAT       o_toFile:0    o_QCMD
     C                   CAT       ')':0         o_QCMD
      *     OvrScope
     C     o_OVRSCOPE    IFNE      *BLANKS
     C                   CAT       'OVR':1       o_QCMD
     C                   CAT       'SCOPE(':0    o_QCMD
     C                   CAT       o_OVRSCOPE:0  o_QCMD
     C                   CAT       ')':0         o_QCMD
     C                   ENDIF
      *
     C                   MOVEL(P)  *IN99         o_IN99
      *
     C                   Z-ADD     256           o_QCMDL
     C                   CALL      'QCMDEXC'                            99
     C                   PARM                    o_QCMD
     C                   PARM                    o_QCMDL
      *
     C                   MOVEL(P)  *IN99         o_RETURN
      *
     C                   MOVEL(P)  o_IN99        *IN99
      *
     C                   Endsr
    R *
    R *====================================================*
    R *  Ab hier folgen die Unterroutinen für die          *
    R *  Prüfung auf ungültige Feldinhalte                 *
    R *====================================================*
CHKC- *
      *====================================================*
      *  Prüfung auf ungültige Feldinhalte, Seite 001
      *====================================================*
      *
     C     chkChar001    Begsr
      *
      *  Feld: ALPHA
     C                   If        EDT00001 = '1'
     C                   Eval      F_FIELD = 'ALPHA'
     C                   Eval      yOutBuffer =
     C                             %trim(FLD00001)
     C                   Exsr      chkChar
     C                   Eval      *IN30 = isVisible
     C                   Eval      EDT00001 = *IN30
     C                   Eval      KEY00001 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN30 = EDT00001
     C                   Endif
      *
     C                   If        %nullind(P_00000001)
     C                   Eval      *IN50 = '0'
     C                   Eval      MSG00001 = '0127'
     C                   Else
     C                   Eval      *IN50 = '1'
     C                   Endif
      *
      *  Feld: VARALPHA
     C                   If        EDT00002 = '1'
     C                   Eval      F_FIELD = 'VARALPHA'
     C                   Eval      yOutBuffer =
     C                             %trim(FLD00002)
     C                   Exsr      chkChar
     C                   Eval      *IN31 = isVisible
     C                   Eval      EDT00002 = *IN31
     C                   Eval      KEY00002 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN31 = EDT00002
     C                   Endif
      *
     C                   If        %nullind(V_00000002)
     C                   Eval      *IN51 = '0'
     C                   Eval      MSG00002 = '0127'
     C                   Else
     C                   Eval      *IN51 = '1'
     C                   Endif
      *
      *  Feld: INTEGER
     C                   If        EDT00003 = '1'
     C                   Eval      F_FIELD = 'INTEGER'
     C                   Eval      yOutBuffer =
     C                             %char(FLD00003)
     C                   Exsr      chkChar
     C                   Eval      *IN32 = isVisible
     C                   Eval      EDT00003 = *IN32
     C                   Eval      KEY00003 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN32 = EDT00003
     C                   Endif
      *
     C                   If        %nullind(P_00000003)
     C                   Eval      *IN52 = '0'
     C                   Eval      MSG00003 = '0127'
     C                   Else
     C                   Eval      *IN52 = '1'
     C                   Endif
      *
      *  Feld: PACKED
     C                   If        EDT00004 = '1'
     C                   Eval      F_FIELD = 'PACKED'
     C                   Eval      yOutBuffer =
     C                             %char(FLD00004)
     C                   Exsr      chkChar
     C                   Eval      *IN33 = isVisible
     C                   Eval      EDT00004 = *IN33
     C                   Eval      KEY00004 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN33 = EDT00004
     C                   Endif
      *
     C                   If        %nullind(P_00000004)
     C                   Eval      *IN53 = '0'
     C                   Eval      MSG00004 = '0127'
     C                   Else
     C                   Eval      *IN53 = '1'
     C                   Endif
      *
      *  Feld: ZONED
     C                   If        EDT00005 = '1'
     C                   Eval      F_FIELD = 'ZONED'
     C                   Eval      yOutBuffer =
     C                             %char(FLD00005)
     C                   Exsr      chkChar
     C                   Eval      *IN34 = isVisible
     C                   Eval      EDT00005 = *IN34
     C                   Eval      KEY00005 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN34 = EDT00005
     C                   Endif
      *
     C                   If        %nullind(P_00000005)
     C                   Eval      *IN54 = '0'
     C                   Eval      MSG00005 = '0127'
     C                   Else
     C                   Eval      *IN54 = '1'
     C                   Endif
      *
      *  Feld: DATE
     C                   If        EDT00006 = '1'
     C                   Eval      F_FIELD = 'DATE'
     C                   Eval      yOutBuffer =
     C                             %trim(FLD00006)
     C                   Exsr      chkChar
     C                   Eval      *IN35 = isVisible
     C                   Eval      EDT00006 = *IN35
     C                   Eval      KEY00006 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN35 = EDT00006
     C                   Endif
      *
     C                   If        %nullind(P_00000006)
     C                   Eval      *IN55 = '0'
     C                   Eval      MSG00006 = '0127'
     C                   Else
     C                   Eval      *IN55 = '1'
     C                   Endif
      *
      *  Feld: TIME
     C                   If        EDT00007 = '1'
     C                   Eval      F_FIELD = 'TIME'
     C                   Eval      yOutBuffer =
     C                             %trim(FLD00007)
     C                   Exsr      chkChar
     C                   Eval      *IN36 = isVisible
     C                   Eval      EDT00007 = *IN36
     C                   Eval      KEY00007 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN36 = EDT00007
     C                   Endif
      *
     C                   If        %nullind(P_00000007)
     C                   Eval      *IN56 = '0'
     C                   Eval      MSG00007 = '0127'
     C                   Else
     C                   Eval      *IN56 = '1'
     C                   Endif
      *
      *  Feld: TIMESTAMP
     C                   If        EDT00008 = '1'
     C                   Eval      F_FIELD = 'TIMESTAMP'
     C                   Eval      yOutBuffer =
     C                             %trim(FLD00008)
     C                   Exsr      chkChar
     C                   Eval      *IN37 = isVisible
     C                   Eval      EDT00008 = *IN37
     C                   Eval      KEY00008 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN37 = EDT00008
     C                   Endif
      *
     C                   If        %nullind(P_00000008)
     C                   Eval      *IN57 = '0'
     C                   Eval      MSG00008 = '0127'
     C                   Else
     C                   Eval      *IN57 = '1'
     C                   Endif
      *
      *  Feld: NOT_NULL
     C                   If        EDT00009 = '1'
     C                   Eval      F_FIELD = 'NOT_NULL'
     C                   Eval      yOutBuffer =
     C                             %trim(FLD00009)
     C                   Exsr      chkChar
     C                   Eval      *IN38 = isVisible
     C                   Eval      EDT00009 = *IN38
     C                   Eval      KEY00009 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN38 = EDT00009
     C                   Endif
      *
     C                   Eval      *IN58 = '1'
      *
      *  Feld: REAL
     C                   If        EDT00010 = '1'
     C                   Eval      F_FIELD = 'REAL'
     C                   Eval      yOutBuffer =
     C                             %editflt(FLD00010)
     C                   Exsr      chkChar
     C                   Eval      *IN39 = isVisible
     C                   Eval      EDT00010 = *IN39
     C                   Eval      KEY00010 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN39 = EDT00010
     C                   Endif
      *
     C                   Eval      *IN59 = '1'
      *
      *  Feld: DOUBLE
     C                   If        EDT00011 = '1'
     C                   Eval      F_FIELD = 'DOUBLE'
     C                   Eval      yOutBuffer =
     C                             %editflt(FLD00011)
     C                   Exsr      chkChar
     C                   Eval      *IN40 = isVisible
     C                   Eval      EDT00011 = *IN40
     C                   Eval      KEY00011 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN40 = EDT00011
     C                   Endif
      *
     C                   Eval      *IN60 = '1'
      *
     C                   Endsr
      *
      *====================================================*
      *  Prüfung auf ungültige Feldinhalte, Seite 002
      *====================================================*
      *
     C     chkChar002    Begsr
      *
      *  Feld: GRAPHIC_NN
     C                   If        EDT00012 = '1'
     C                   Eval      F_FIELD = 'GRAPHIC_NN'
     C                   Eval      yOutBuffer =
     C                             %trim(FLD0001201) +
     C                             %trim(FLD0001202) +
     C                             %trim(FLD0001203) +
     C                             %trim(FLD0001204) +
     C                             %trim(FLD0001205) +
     C                             %trim(FLD0001206) +
     C                             %trim(FLD0001207) +
     C                             %trim(FLD0001208)
     C                   Exsr      chkChar
     C                   Eval      *IN30 = isVisible
     C                   Eval      EDT00012 = *IN30
     C                   Eval      KEY00012 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN30 = EDT00012
     C                   Endif
      *
     C                   Eval      *IN50 = '1'
      *
     C                   Endsr
      *
      *====================================================*
      *  Prüfung auf ungültige Feldinhalte, Seite 003
      *====================================================*
      *
     C     chkChar003    Begsr
      *
      *  Feld: GRAPHIC
     C                   If        EDT00013 = '1'
     C                   Eval      F_FIELD = 'GRAPHIC'
     C                   Eval      yOutBuffer =
     C                             %trim(FLD0001301) +
     C                             %trim(FLD0001302) +
     C                             %trim(FLD0001303) +
     C                             %trim(FLD0001304) +
     C                             %trim(FLD0001305) +
     C                             %trim(FLD0001306) +
     C                             %trim(FLD0001307) +
     C                             %trim(FLD0001308)
     C                   Exsr      chkChar
     C                   Eval      *IN30 = isVisible
     C                   Eval      EDT00013 = *IN30
     C                   Eval      KEY00013 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN30 = EDT00013
     C                   Endif
      *
     C                   If        %nullind(P_00000013)
     C                   Eval      *IN50 = '0'
     C                   Eval      MSG00013 = '0127'
     C                   Else
     C                   Eval      *IN50 = '1'
     C                   Endif
      *
     C                   Endsr
      *
      *====================================================*
      *  Prüfung auf ungültige Feldinhalte, Seite 004
      *====================================================*
      *
     C     chkChar004    Begsr
      *
      *  Feld: VARGRAP_NN
     C                   If        EDT00014 = '1'
     C                   Eval      F_FIELD = 'VARGRAP_NN'
     C                   Eval      yOutBuffer =
     C                             %trim(FLD0001401) +
     C                             %trim(FLD0001402) +
     C                             %trim(FLD0001403) +
     C                             %trim(FLD0001404) +
     C                             %trim(FLD0001405) +
     C                             %trim(FLD0001406) +
     C                             %trim(FLD0001407) +
     C                             %trim(FLD0001408)
     C                   Exsr      chkChar
     C                   Eval      *IN30 = isVisible
     C                   Eval      EDT00014 = *IN30
     C                   Eval      KEY00014 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN30 = EDT00014
     C                   Endif
      *
     C                   Eval      *IN50 = '1'
      *
     C                   Endsr
      *
      *====================================================*
      *  Prüfung auf ungültige Feldinhalte, Seite 005
      *====================================================*
      *
     C     chkChar005    Begsr
      *
      *  Feld: VARGRAP
     C                   If        EDT00015 = '1'
     C                   Eval      F_FIELD = 'VARGRAP'
     C                   Eval      yOutBuffer =
     C                             %trim(FLD0001501) +
     C                             %trim(FLD0001502) +
     C                             %trim(FLD0001503) +
     C                             %trim(FLD0001504) +
     C                             %trim(FLD0001505) +
     C                             %trim(FLD0001506) +
     C                             %trim(FLD0001507) +
     C                             %trim(FLD0001508)
     C                   Exsr      chkChar
     C                   Eval      *IN30 = isVisible
     C                   Eval      EDT00015 = *IN30
     C                   Eval      KEY00015 = keyChar
     C                   Else
     C                   Eval      isCvtChar = bTrue
     C                   Eval      *IN30 = EDT00015
     C                   Endif
      *
     C                   If        %nullind(V_00000015)
     C                   Eval      *IN50 = '0'
     C                   Eval      MSG00015 = '0127'
     C                   Else
     C                   Eval      *IN50 = '1'
     C                   Endif
      *
     C                   Endsr
      *
      *====================================================*
      *  Alle Felder freischalten
      *====================================================*
      *
     C     EnableEdit    Begsr
      *
     C                   Eval      EDT00001 = '1'
     C                   Eval      EDT00002 = '1'
     C                   Eval      EDT00003 = '1'
     C                   Eval      EDT00004 = '1'
     C                   Eval      EDT00005 = '1'
     C                   Eval      EDT00006 = '1'
     C                   Eval      EDT00007 = '1'
     C                   Eval      EDT00008 = '1'
     C                   Eval      EDT00009 = '1'
     C                   Eval      EDT00010 = '1'
     C                   Eval      EDT00011 = '1'
     C                   Eval      EDT00012 = '1'
     C                   Eval      EDT00013 = '1'
     C                   Eval      EDT00014 = '1'
     C                   Eval      EDT00015 = '1'
      *
     C                   Endsr
      *
    R *
    R *====================================================*
    R *  Ab hier folgen die Unterroutinen für das          *
    R *  Setzen/Löschen der NULL Indicator                 *
    R *====================================================*
      *
     C     c_tgNullInd   Begsr
      *
     C                   Eval      xScnCsrRow = wScnCsrRow - WndTopRow
      *
     C                   Select
NULL- *
      *  Feld: ALPHA
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 04) and
     C                             (scnNbr      = 001)
     C                   Eval      %nullind(P_00000001) =
     C                             not %nullind(P_00000001)
      *
      *  Feld: VARALPHA
     C                   When      (xScnCsrRow >= 05) and
     C                             (xScnCsrRow <= 05) and
     C                             (scnNbr      = 001)
     C                   Eval      %nullind(V_00000002) =
     C                             not %nullind(V_00000002)
      *
      *  Feld: INTEGER
     C                   When      (xScnCsrRow >= 06) and
     C                             (xScnCsrRow <= 06) and
     C                             (scnNbr      = 001)
     C                   Eval      %nullind(P_00000003) =
     C                             not %nullind(P_00000003)
      *
      *  Feld: PACKED
     C                   When      (xScnCsrRow >= 07) and
     C                             (xScnCsrRow <= 07) and
     C                             (scnNbr      = 001)
     C                   Eval      %nullind(P_00000004) =
     C                             not %nullind(P_00000004)
      *
      *  Feld: ZONED
     C                   When      (xScnCsrRow >= 08) and
     C                             (xScnCsrRow <= 08) and
     C                             (scnNbr      = 001)
     C                   Eval      %nullind(P_00000005) =
     C                             not %nullind(P_00000005)
      *
      *  Feld: DATE
     C                   When      (xScnCsrRow >= 09) and
     C                             (xScnCsrRow <= 09) and
     C                             (scnNbr      = 001)
     C                   Eval      %nullind(P_00000006) =
     C                             not %nullind(P_00000006)
      *
      *  Feld: TIME
     C                   When      (xScnCsrRow >= 10) and
     C                             (xScnCsrRow <= 10) and
     C                             (scnNbr      = 001)
     C                   Eval      %nullind(P_00000007) =
     C                             not %nullind(P_00000007)
      *
      *  Feld: TIMESTAMP
     C                   When      (xScnCsrRow >= 11) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 001)
     C                   Eval      %nullind(P_00000008) =
     C                             not %nullind(P_00000008)
      *
      *  Feld: NOT_NULL
     C                   When      (xScnCsrRow >= 12) and
     C                             (xScnCsrRow <= 12) and
     C                             (scnNbr      = 001)
     C                   Eval      pgmMsgID = 'USR8191'
     C                   Eval      pgmMsgDta = F1FNME
     C                   Callp     p_sndPgmMg(pgmMsgID: pgmMsgDta: psPgmName)
      *
      *  Feld: REAL
     C                   When      (xScnCsrRow >= 13) and
     C                             (xScnCsrRow <= 13) and
     C                             (scnNbr      = 001)
     C                   Eval      pgmMsgID = 'USR8191'
     C                   Eval      pgmMsgDta = F1FNME
     C                   Callp     p_sndPgmMg(pgmMsgID: pgmMsgDta: psPgmName)
      *
      *  Feld: DOUBLE
     C                   When      (xScnCsrRow >= 14) and
     C                             (xScnCsrRow <= 14) and
     C                             (scnNbr      = 001)
     C                   Eval      pgmMsgID = 'USR8191'
     C                   Eval      pgmMsgDta = F1FNME
     C                   Callp     p_sndPgmMg(pgmMsgID: pgmMsgDta: psPgmName)
      *
      *  Feld: GRAPHIC_NN
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 002)
     C                   Eval      pgmMsgID = 'USR8191'
     C                   Eval      pgmMsgDta = F1FNME
     C                   Callp     p_sndPgmMg(pgmMsgID: pgmMsgDta: psPgmName)
      *
      *  Feld: GRAPHIC
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 003)
     C                   Eval      %nullind(P_00000013) =
     C                             not %nullind(P_00000013)
      *
      *  Feld: VARGRAP_NN
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 004)
     C                   Eval      pgmMsgID = 'USR8191'
     C                   Eval      pgmMsgDta = F1FNME
     C                   Callp     p_sndPgmMg(pgmMsgID: pgmMsgDta: psPgmName)
      *
      *  Feld: VARGRAP
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 005)
     C                   Eval      %nullind(V_00000015) =
     C                             not %nullind(V_00000015)
      *
     C                   Endsl
      *
     C                   Endsr
    R *
    R *====================================================*
    R *  Ab hier folgen die Unterroutinen für den          *
    R *  Hex-Editor                                        *
    R *====================================================*
HEX - *
     C     c_fldHexEd    Begsr
      *
     C                   Eval      yDsp80     = xDsp80
     C                   Eval      yHeaderTyp = xHeaderTyp
     C                   Eval      yCopyright = xCopyRight
     C                   Eval      yProtect   = '0'
     C                   Eval      yMsgID     = ' '
     C                   Eval      yMsgDta    = ' '
      *
     C                   Eval      xScnCsrRow = wScnCsrRow - WndTopRow
      *
     C                   Select
      *  Feld: ALPHA
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 04) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00001 = '1') and
     C                             not (LNG00001 = '1')
     C                   Exsr      f_P_00000001
     C                   Endif
     C                   Eval      yFldName = 'ALPHA     '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_P_00000001
     C                   Eval      EDT00001 = '1'
     C                   Eval      %nullind(P_00000001) = *OFF
     C                   Endif
      *
     C                   Exsr      f_P_00000001
     C                   Exsr      s_P_00000001
      *  Feld: VARALPHA
     C                   When      (xScnCsrRow >= 05) and
     C                             (xScnCsrRow <= 05) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00002 = '1') and
     C                             not (LNG00002 = '1')
     C                   Exsr      f_V_00000002
     C                   Endif
     C                   Eval      yFldName = 'VARALPHA  '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_V_00000002
     C                   Eval      EDT00002 = '1'
     C                   Eval      %nullind(V_00000002) = *OFF
     C                   Endif
      *
     C                   Exsr      f_V_00000002
     C                   Exsr      s_V_00000002
      *  Feld: INTEGER
     C                   When      (xScnCsrRow >= 06) and
     C                             (xScnCsrRow <= 06) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00003 = '1') and
     C                             not (LNG00003 = '1')
     C                   Exsr      f_P_00000003
     C                   Endif
     C                   Eval      yFldName = 'INTEGER   '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_P_00000003
     C                   Eval      EDT00003 = '1'
     C                   Eval      %nullind(P_00000003) = *OFF
     C                   Endif
      *
      *  Feld: PACKED
     C                   When      (xScnCsrRow >= 07) and
     C                             (xScnCsrRow <= 07) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00004 = '1') and
     C                             not (LNG00004 = '1')
     C                   Exsr      f_P_00000004
     C                   Endif
     C                   Eval      yFldName = 'PACKED    '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_P_00000004
     C                   Eval      EDT00004 = '1'
     C                   Eval      %nullind(P_00000004) = *OFF
     C                   Endif
      *
      *  Feld: ZONED
     C                   When      (xScnCsrRow >= 08) and
     C                             (xScnCsrRow <= 08) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00005 = '1') and
     C                             not (LNG00005 = '1')
     C                   Exsr      f_P_00000005
     C                   Endif
     C                   Eval      yFldName = 'ZONED     '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_P_00000005
     C                   Eval      EDT00005 = '1'
     C                   Eval      %nullind(P_00000005) = *OFF
     C                   Endif
      *
      *  Feld: DATE
     C                   When      (xScnCsrRow >= 09) and
     C                             (xScnCsrRow <= 09) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00006 = '1') and
     C                             not (LNG00006 = '1')
     C                   Exsr      f_P_00000006
     C                   Endif
     C                   Eval      yFldName = 'DATE      '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_P_00000006
     C                   Eval      EDT00006 = '1'
     C                   Eval      %nullind(P_00000006) = *OFF
     C                   Endif
      *
      *  Feld: TIME
     C                   When      (xScnCsrRow >= 10) and
     C                             (xScnCsrRow <= 10) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00007 = '1') and
     C                             not (LNG00007 = '1')
     C                   Exsr      f_P_00000007
     C                   Endif
     C                   Eval      yFldName = 'TIME      '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_P_00000007
     C                   Eval      EDT00007 = '1'
     C                   Eval      %nullind(P_00000007) = *OFF
     C                   Endif
      *
      *  Feld: TIMESTAMP
     C                   When      (xScnCsrRow >= 11) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00008 = '1') and
     C                             not (LNG00008 = '1')
     C                   Exsr      f_P_00000008
     C                   Endif
     C                   Eval      yFldName = 'TIMESTAMP '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_P_00000008
     C                   Eval      EDT00008 = '1'
     C                   Eval      %nullind(P_00000008) = *OFF
     C                   Endif
      *
      *  Feld: NOT_NULL
     C                   When      (xScnCsrRow >= 12) and
     C                             (xScnCsrRow <= 12) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00009 = '1') and
     C                             not (LNG00009 = '1')
     C                   Exsr      f_P_00000009
     C                   Endif
     C                   Eval      yFldName = 'NOT_NULL  '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_P_00000009
     C                   Eval      EDT00009 = '1'
     C                   Endif
      *
     C                   Exsr      f_P_00000009
     C                   Exsr      s_P_00000009
      *  Feld: REAL
     C                   When      (xScnCsrRow >= 13) and
     C                             (xScnCsrRow <= 13) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00010 = '1') and
     C                             not (LNG00010 = '1')
     C                   Exsr      f_P_00000010
     C                   Endif
     C                   Eval      yFldName = 'REAL      '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_P_00000010
     C                   Eval      EDT00010 = '1'
     C                   Endif
      *
      *  Feld: DOUBLE
     C                   When      (xScnCsrRow >= 14) and
     C                             (xScnCsrRow <= 14) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00011 = '1') and
     C                             not (LNG00011 = '1')
     C                   Exsr      f_P_00000011
     C                   Endif
     C                   Eval      yFldName = 'DOUBLE    '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_P_00000011
     C                   Eval      EDT00011 = '1'
     C                   Endif
      *
      *  Feld: GRAPHIC_NN
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 002)
     C                   If        (EDT00012 = '1') and
     C                             not (LNG00012 = '1')
     C                   Exsr      f_P_00000012
     C                   Endif
     C                   Eval      yFldName = 'GRAPHIC_NN'
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_P_00000012
     C                   Eval      EDT00012 = '1'
     C                   Endif
      *
      *  Feld: GRAPHIC
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 003)
     C                   If        (EDT00013 = '1') and
     C                             not (LNG00013 = '1')
     C                   Exsr      f_P_00000013
     C                   Endif
     C                   Eval      yFldName = 'GRAPHIC   '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_P_00000013
     C                   Eval      EDT00013 = '1'
     C                   Eval      %nullind(P_00000013) = *OFF
     C                   Endif
      *
      *  Feld: VARGRAP_NN
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 004)
     C                   If        (EDT00014 = '1') and
     C                             not (LNG00014 = '1')
     C                   Exsr      f_V_00000014
     C                   Endif
     C                   Eval      yFldName = 'VARGRAP_NN'
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_V_00000014
     C                   Eval      EDT00014 = '1'
     C                   Endif
      *
      *  Feld: VARGRAP
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 005)
     C                   If        (EDT00015 = '1') and
     C                             not (LNG00015 = '1')
     C                   Exsr      f_V_00000015
     C                   Endif
     C                   Eval      yFldName = 'VARGRAP   '
     C                   Eval      Editor = Editor = cEDITOR_HEX
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Exsr      s_V_00000015
     C                   Eval      EDT00015 = '1'
     C                   Eval      %nullind(V_00000015) = *OFF
     C                   Endif
      *
     C                   Endsl
      *
     C                   Endsr
      *
    R *
    R *====================================================*
    R *  Ab hier folgen die Unterroutinen für den          *
    R *  String-Editor                                     *
    R *====================================================*
TXT - *
     C     c_fldStrEd    Begsr
      *
     C                   Eval      yDsp80     = xDsp80
     C                   Eval      yHeaderTyp = xHeaderTyp
     C                   Eval      yCopyright = xCopyRight
     C                   Eval      yProtect   = '0'
     C                   Eval      yMsgID     = ' '
     C                   Eval      yMsgDta    = ' '
      *
     C                   Eval      xScnCsrRow = wScnCsrRow - WndTopRow
      *
     C                   Select
      *  Feld: ALPHA
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 04) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00001 <> '1')
     C                   Eval      yFldName = 'ALPHA     '
     C                   Exsr      USR8193
     C                   Leavesr
     C                   Endif
     C                   If        not (LNG00001 = '1')
     C                   Endif
     C                   Eval      yFldName = 'ALPHA     '
     C                   Eval      Editor = cEDITOR_STRING
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Eval      EDT00001 = '1'
     C                   Eval      %nullind(P_00000001) = *OFF
     C                   Endif
      *
      *  Feld: VARALPHA
     C                   When      (xScnCsrRow >= 05) and
     C                             (xScnCsrRow <= 05) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00002 <> '1')
     C                   Eval      yFldName = 'VARALPHA  '
     C                   Exsr      USR8193
     C                   Leavesr
     C                   Endif
     C                   If        not (LNG00002 = '1')
     C                   Endif
     C                   Eval      yFldName = 'VARALPHA  '
     C                   Eval      Editor = cEDITOR_STRING
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Eval      EDT00002 = '1'
     C                   Eval      %nullind(V_00000002) = *OFF
     C                   Endif
      *
      *  Feld: INTEGER
     C                   When      (xScnCsrRow >= 06) and
     C                             (xScnCsrRow <= 06) and
     C                             (scnNbr      = 001)
     C                   Exsr      MSG8221
      *  Feld: PACKED
     C                   When      (xScnCsrRow >= 07) and
     C                             (xScnCsrRow <= 07) and
     C                             (scnNbr      = 001)
     C                   Exsr      MSG8221
      *  Feld: ZONED
     C                   When      (xScnCsrRow >= 08) and
     C                             (xScnCsrRow <= 08) and
     C                             (scnNbr      = 001)
     C                   Exsr      MSG8221
      *  Feld: DATE
     C                   When      (xScnCsrRow >= 09) and
     C                             (xScnCsrRow <= 09) and
     C                             (scnNbr      = 001)
     C                   Exsr      MSG8221
      *  Feld: TIME
     C                   When      (xScnCsrRow >= 10) and
     C                             (xScnCsrRow <= 10) and
     C                             (scnNbr      = 001)
     C                   Exsr      MSG8221
      *  Feld: TIMESTAMP
     C                   When      (xScnCsrRow >= 11) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 001)
     C                   Exsr      MSG8221
      *  Feld: NOT_NULL
     C                   When      (xScnCsrRow >= 12) and
     C                             (xScnCsrRow <= 12) and
     C                             (scnNbr      = 001)
     C                   If        (EDT00009 <> '1')
     C                   Eval      yFldName = 'NOT_NULL  '
     C                   Exsr      USR8193
     C                   Leavesr
     C                   Endif
     C                   If        not (LNG00009 = '1')
     C                   Endif
     C                   Eval      yFldName = 'NOT_NULL  '
     C                   Eval      Editor = cEDITOR_STRING
     C                   Exsr      fromBuffer
     C                   If        yMsgID = 'USR8112'
     C                   Eval      EDT00009 = '1'
     C                   Endif
      *
      *  Feld: REAL
     C                   When      (xScnCsrRow >= 13) and
     C                             (xScnCsrRow <= 13) and
     C                             (scnNbr      = 001)
     C                   Exsr      MSG8221
      *  Feld: DOUBLE
     C                   When      (xScnCsrRow >= 14) and
     C                             (xScnCsrRow <= 14) and
     C                             (scnNbr      = 001)
     C                   Exsr      MSG8221
      *  Feld: GRAPHIC_NN
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 002)
     C                   Exsr      MSG8221
      *  Feld: GRAPHIC
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 003)
     C                   Exsr      MSG8221
      *  Feld: VARGRAP_NN
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 004)
     C                   Exsr      MSG8221
      *  Feld: VARGRAP
     C                   When      (xScnCsrRow >= 04) and
     C                             (xScnCsrRow <= 11) and
     C                             (scnNbr      = 005)
     C                   Exsr      MSG8221
     C                   Endsl
      *
     C                   Endsr
      *
    R *
    R *====================================================*
    R *  Ab hier folgen die Unterroutinen für den          *
    R *  das Übertragen der Dateifelder ind die Felder     *
    R *  des Bildschirms.                                  *
    R *====================================================*
      *  ALPHA
     C     s_P_00000001  Begsr
      *
     C                   Clear                   FLD00001
      *
     C                   If        not %nullind(P_00000001)
     C                   Eval      FLD00001 = P_00000001
     C                   Endif
      *
     C                   Endsr
      *  VARALPHA
     C     s_V_00000002  Begsr
      *
     C                   Clear                   FLD00002
      *
     C                   If        not %nullind(V_00000002)
     C                   Eval      FLD00002 = V_00000002
     C                   Endif
      *
     C                   Endsr
      *  INTEGER
     C     s_P_00000003  Begsr
      *
     C                   Clear                   FLD00003
      *
     C                   If        not %nullind(P_00000003)
     C                   Eval      FLD00003 = P_00000003
     C                   Endif
      *
     C                   Endsr
      *  PACKED
     C     s_P_00000004  Begsr
      *
     C                   Clear                   FLD00004
      *
     C                   If        not %nullind(P_00000004)
     C                   Eval      FLD00004 = P_00000004
     C                   Endif
      *
     C                   Endsr
      *  ZONED
     C     s_P_00000005  Begsr
      *
     C                   Clear                   FLD00005
      *
     C                   If        not %nullind(P_00000005)
     C                   Eval      FLD00005 = P_00000005
     C                   Endif
      *
     C                   Endsr
      *  DATE
     C     s_P_00000006  Begsr
      *
     C                   Clear                   FLD00006
      *
     C                   If        not %nullind(P_00000006)
     C                   Eval      FLD00006 = P_00000006
     C                   Endif
      *
     C                   Endsr
      *  TIME
     C     s_P_00000007  Begsr
      *
     C                   Clear                   FLD00007
      *
     C                   If        not %nullind(P_00000007)
     C                   Eval      FLD00007 = P_00000007
     C                   Endif
      *
     C                   Endsr
      *  TIMESTAMP
     C     s_P_00000008  Begsr
      *
     C                   Clear                   FLD00008
      *
     C                   If        not %nullind(P_00000008)
     C                   Eval      FLD00008 = P_00000008
     C                   Endif
      *
     C                   Endsr
      *  NOT_NULL
     C     s_P_00000009  Begsr
      *
     C                   Eval      FLD00009 = P_00000009
      *
     C                   Endsr
      *  REAL
     C     s_P_00000010  Begsr
      *
     C                   Eval      FLD00010 = P_00000010
      *
     C                   Endsr
      *  DOUBLE
     C     s_P_00000011  Begsr
      *
     C                   Eval      FLD00011 = P_00000011
      *
     C                   Endsr
      *  GRAPHIC_NN
     C     s_P_00000012  Begsr
      *
      *
     C                   Eval      offs = 0
      *
     C                   For       x = 1 to 8
     C                   Eval      rem = %len(P_00000012)  - offs
     C                   If        (rem > 18)
     C                   Eval      len = 18
     C                   Else
     C                   Eval      len = rem
     C                   Endif
     C                   Select
     C                   When      (x = 1 and len > 0)
     C                   Eval      FLD0001201 = %subst(P_00000012: offs+1: len)
     C                   When      (x = 2 and len > 0)
     C                   Eval      FLD0001202 = %subst(P_00000012: offs+1: len)
     C                   When      (x = 3 and len > 0)
     C                   Eval      FLD0001203 = %subst(P_00000012: offs+1: len)
     C                   When      (x = 4 and len > 0)
     C                   Eval      FLD0001204 = %subst(P_00000012: offs+1: len)
     C                   When      (x = 5 and len > 0)
     C                   Eval      FLD0001205 = %subst(P_00000012: offs+1: len)
     C                   When      (x = 6 and len > 0)
     C                   Eval      FLD0001206 = %subst(P_00000012: offs+1: len)
     C                   When      (x = 7 and len > 0)
     C                   Eval      FLD0001207 = %subst(P_00000012: offs+1: len)
     C                   When      (x = 8 and len > 0)
     C                   Eval      FLD0001208 = %subst(P_00000012: offs+1: len)
     C                   Endsl
     C                   Eval      offs = offs + len
     C                   Endfor
      *
     C                   Endsr
      *  GRAPHIC
     C     s_P_00000013  Begsr
      *
     C                   Clear                   FLD0001301
     C                   Clear                   FLD0001302
     C                   Clear                   FLD0001303
     C                   Clear                   FLD0001304
     C                   Clear                   FLD0001305
     C                   Clear                   FLD0001306
     C                   Clear                   FLD0001307
     C                   Clear                   FLD0001308
      *
     C                   If        not %nullind(P_00000013)
      *
     C                   Eval      offs = 0
      *
     C                   For       x = 1 to 8
     C                   Eval      rem = %len(P_00000013)  - offs
     C                   If        (rem > 18)
     C                   Eval      len = 18
     C                   Else
     C                   Eval      len = rem
     C                   Endif
     C                   Select
     C                   When      (x = 1 and len > 0)
     C                   Eval      FLD0001301 = %subst(P_00000013: offs+1: len)
     C                   When      (x = 2 and len > 0)
     C                   Eval      FLD0001302 = %subst(P_00000013: offs+1: len)
     C                   When      (x = 3 and len > 0)
     C                   Eval      FLD0001303 = %subst(P_00000013: offs+1: len)
     C                   When      (x = 4 and len > 0)
     C                   Eval      FLD0001304 = %subst(P_00000013: offs+1: len)
     C                   When      (x = 5 and len > 0)
     C                   Eval      FLD0001305 = %subst(P_00000013: offs+1: len)
     C                   When      (x = 6 and len > 0)
     C                   Eval      FLD0001306 = %subst(P_00000013: offs+1: len)
     C                   When      (x = 7 and len > 0)
     C                   Eval      FLD0001307 = %subst(P_00000013: offs+1: len)
     C                   When      (x = 8 and len > 0)
     C                   Eval      FLD0001308 = %subst(P_00000013: offs+1: len)
     C                   Endsl
     C                   Eval      offs = offs + len
     C                   Endfor
     C                   Endif
      *
     C                   Endsr
      *  VARGRAP_NN
     C     s_V_00000014  Begsr
      *
     C                   Clear                   FLD0001401
     C                   Clear                   FLD0001402
     C                   Clear                   FLD0001403
     C                   Clear                   FLD0001404
     C                   Clear                   FLD0001405
     C                   Clear                   FLD0001406
     C                   Clear                   FLD0001407
     C                   Clear                   FLD0001408
      *
      *
     C                   Eval      offs = 0
      *
     C                   For       x = 1 to 8
     C                   Eval      rem = %len(V_00000014)  - offs
     C                   If        (rem > 18)
     C                   Eval      len = 18
     C                   Else
     C                   Eval      len = rem
     C                   Endif
     C                   Select
     C                   When      (x = 1 and len > 0)
     C                   Eval      FLD0001401 = %subst(V_00000014: offs+1: len)
     C                   When      (x = 2 and len > 0)
     C                   Eval      FLD0001402 = %subst(V_00000014: offs+1: len)
     C                   When      (x = 3 and len > 0)
     C                   Eval      FLD0001403 = %subst(V_00000014: offs+1: len)
     C                   When      (x = 4 and len > 0)
     C                   Eval      FLD0001404 = %subst(V_00000014: offs+1: len)
     C                   When      (x = 5 and len > 0)
     C                   Eval      FLD0001405 = %subst(V_00000014: offs+1: len)
     C                   When      (x = 6 and len > 0)
     C                   Eval      FLD0001406 = %subst(V_00000014: offs+1: len)
     C                   When      (x = 7 and len > 0)
     C                   Eval      FLD0001407 = %subst(V_00000014: offs+1: len)
     C                   When      (x = 8 and len > 0)
     C                   Eval      FLD0001408 = %subst(V_00000014: offs+1: len)
     C                   Endsl
     C                   Eval      offs = offs + len
     C                   Endfor
      *
     C                   Endsr
      *  VARGRAP
     C     s_V_00000015  Begsr
      *
     C                   Clear                   FLD0001501
     C                   Clear                   FLD0001502
     C                   Clear                   FLD0001503
     C                   Clear                   FLD0001504
     C                   Clear                   FLD0001505
     C                   Clear                   FLD0001506
     C                   Clear                   FLD0001507
     C                   Clear                   FLD0001508
      *
     C                   If        not %nullind(V_00000015)
      *
     C                   Eval      offs = 0
      *
     C                   For       x = 1 to 8
     C                   Eval      rem = %len(V_00000015)  - offs
     C                   If        (rem > 18)
     C                   Eval      len = 18
     C                   Else
     C                   Eval      len = rem
     C                   Endif
     C                   Select
     C                   When      (x = 1 and len > 0)
     C                   Eval      FLD0001501 = %subst(V_00000015: offs+1: len)
     C                   When      (x = 2 and len > 0)
     C                   Eval      FLD0001502 = %subst(V_00000015: offs+1: len)
     C                   When      (x = 3 and len > 0)
     C                   Eval      FLD0001503 = %subst(V_00000015: offs+1: len)
     C                   When      (x = 4 and len > 0)
     C                   Eval      FLD0001504 = %subst(V_00000015: offs+1: len)
     C                   When      (x = 5 and len > 0)
     C                   Eval      FLD0001505 = %subst(V_00000015: offs+1: len)
     C                   When      (x = 6 and len > 0)
     C                   Eval      FLD0001506 = %subst(V_00000015: offs+1: len)
     C                   When      (x = 7 and len > 0)
     C                   Eval      FLD0001507 = %subst(V_00000015: offs+1: len)
     C                   When      (x = 8 and len > 0)
     C                   Eval      FLD0001508 = %subst(V_00000015: offs+1: len)
     C                   Endsl
     C                   Eval      offs = offs + len
     C                   Endfor
     C                   Endif
      *
     C                   Endsr
    R *
    R *====================================================*
    R *  Ab hier folgen die Unterroutinen für den          *
    R *  das Übertragen der Dateifelder in die Felder      *
    R *  der Datei.                                        *
    R *====================================================*
     C     f_P_00000001  Begsr
     C                   Eval      P_00000001 = %trimR(
     C                             FLD00001
     C                             )
     C                   Endsr
     C     f_V_00000002  Begsr
     C                   Eval      V_00000002 = %trimR(
     C                             FLD00002
     C                             )
     C                   Endsr
     C     f_P_00000003  Begsr
     C                   Eval      P_00000003 =
     C                             FLD00003
     C                   Endsr
     C     f_P_00000004  Begsr
     C                   Eval      P_00000004 =
     C                             FLD00004
     C                   Endsr
     C     f_P_00000005  Begsr
     C                   Eval      P_00000005 =
     C                             FLD00005
     C                   Endsr
     C     f_P_00000006  Begsr
     C                   Eval      P_00000006 =
     C                             FLD00006
     C                   Endsr
     C     f_P_00000007  Begsr
     C                   Eval      P_00000007 =
     C                             FLD00007
     C                   Endsr
     C     f_P_00000008  Begsr
     C                   Eval      P_00000008 =
     C                             FLD00008
     C                   Endsr
     C     f_P_00000009  Begsr
     C                   Eval      P_00000009 = %trimR(
     C                             FLD00009
     C                             )
     C                   Endsr
     C     f_P_00000010  Begsr
     C                   Eval      P_00000010 =
     C                             FLD00010
     C                   Endsr
     C     f_P_00000011  Begsr
     C                   Eval      P_00000011 =
     C                             FLD00011
     C                   Endsr
     C     f_P_00000012  Begsr
     C                   Eval      P_00000012 = %trimR(
     C                             FLD0001201 +
     C                             FLD0001202 +
     C                             FLD0001203 +
     C                             FLD0001204 +
     C                             FLD0001205 +
     C                             FLD0001206 +
     C                             FLD0001207 +
     C                             FLD0001208
     C                             )
     C                   Endsr
     C     f_P_00000013  Begsr
     C                   Eval      P_00000013 = %trimR(
     C                             FLD0001301 +
     C                             FLD0001302 +
     C                             FLD0001303 +
     C                             FLD0001304 +
     C                             FLD0001305 +
     C                             FLD0001306 +
     C                             FLD0001307 +
     C                             FLD0001308
     C                             )
     C                   Endsr
     C     f_V_00000014  Begsr
     C                   Eval      V_00000014 = %trimR(
     C                             FLD0001401 +
     C                             FLD0001402 +
     C                             FLD0001403 +
     C                             FLD0001404 +
     C                             FLD0001405 +
     C                             FLD0001406 +
     C                             FLD0001407 +
     C                             FLD0001408
     C                             )
     C                   Endsr
     C     f_V_00000015  Begsr
     C                   Eval      V_00000015 = %trimR(
     C                             FLD0001501 +
     C                             FLD0001502 +
     C                             FLD0001503 +
     C                             FLD0001504 +
     C                             FLD0001505 +
     C                             FLD0001506 +
     C                             FLD0001507 +
     C                             FLD0001508
     C                             )
     C                   Endsr
