      *===============================================================*
      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.2.0                               *
      *  Programm : PEEK05                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 29.09.97  Raddatz                                 *
      *  geändert : 27.04.99  für Version 2.1.0                       *
      *  geändert : 29.04.99  für Version 2.2.0                       *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Hauptprogramm für Auswahl aus Subfile                        *
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
      * Bildschirm
     FPEEK05FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
     F                                     SFILE(PBSFL132:SFLREC132)
     F                                     SFILE(PBSFL080:SFLREC080)
      *--------------------------------------------------------------*
      *
      * Aufbau des Satzformats
     FPEEKFLDL1 IF   E           K DISK    USROPN
     F                                     RENAME(FPEEKFLD:FPEEKFLDL1)
     F                                     PREFIX(F_)
     F                                     INFDS(Peek#L1)
      *
     FPEEKFLD   UF   E           K DISK    USROPN
     F                                     PREFIX(F_)
     F                                     INFDS(Peek#00)
      *
      * Für Einzelsatzzugriff zum Löschen von Datensätzen
     D hFile00         DS                   likeds(r§hFile  )
      *
      * Für Sortierung nach relativer Satznummer
     D hFile01         DS                   likeds(r§hFile  )
      *
      * Für Sortierung nach Schlüsselfolge
     D hFile02         DS                   likeds(r§hFile  )
      *
      * Für SQL Zugriff
     D hFile03         DS                   likeds(r§hFile  )
      *
      * Für Einzelsatzzugriff zum reinen Lesen von Datensätzen
     D hFile04         DS                   likeds(r§hFile  )
      *
      *---Variablendefinition ShortCmd---------------------*
      /COPY QCOPYLE,ShortCmd_D
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,PPEEK01
      /COPY QCOPYLE,PPEEK03
      /COPY QCOPYLE,PPEEK04
      /COPY QCOPYLE,PPEEK06
      /COPY QCOPYLE,PPEEK07
      /COPY QCOPYLE,PPEEK08
      /COPY QCOPYLE,PPEEK09
      /COPY QCOPYLE,PPEEK10
      /COPY QCOPYLE,PPEEK12
      /COPY QCOPYLE,PPEEK13
      /COPY QCOPYLE,PPEEK14
      /COPY QCOPYLE,PPEEK17
      /COPY QCOPYLE,PPEEK18
      /COPY QCOPYLE,PPEEK19
      /COPY QCOPYLE,PPEEK20
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK24
      /COPY QCOPYLE,PPEEK26
      /COPY QCOPYLE,PPEEK27
      /COPY QCOPYLE,PPEEK30
      /COPY QCOPYLE,PPEEK32
      /COPY QCOPYLE,PPEEK33
      /COPY QCOPYLE,PPEEK34
      /COPY QCOPYLE,PPEEK37
      /COPY QCOPYLE,PPEEK38
      /COPY QCOPYLE,PPEEK40
      /COPY QCOPYLE,PPEEK41
      /COPY QCOPYLE,PPEEK42
      /COPY QCOPYLE,PPEEK47
      /COPY QCOPYLE,PPEEK48
      /COPY QCOPYLE,PPEEK49
      /COPY QCOPYLE,PPEEK50
      /COPY QCOPYLE,PPEEK52
      /COPY QCOPYLE,PPEEK54
      /COPY QCOPYLE,PPEEK55
      /COPY QCOPYLE,PPEEK56
      /COPY QCOPYLE,PPEEK57
      /COPY QCOPYLE,PPEEK59
      /COPY QCOPYLE,PPEEK65
      /COPY QCOPYLE,PPEEK68
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK05
      /undefine internal_prototype
      *
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
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
      /COPY QCOPYLE,SET0005
      /COPY QCOPYLE,SET0006
      /COPY QCOPYLE,SET0007
      /COPY QCOPYLE,SET0008
      /COPY QCOPYLE,SET0009
      /COPY QCOPYLE,SET0010
      /COPY QCOPYLE,SET0011
      /COPY QCOPYLE,SET0013
      /COPY QCOPYLE,SET0014
      /COPY QCOPYLE,SET0015
      /COPY QCOPYLE,SET0016
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR0007
      /COPY QCOPYLE,USR0008
      /COPY QCOPYLE,USR0009
      /COPY QCOPYLE,USR0010
      /COPY QCOPYLE,USR0013
      /COPY QCOPYLE,USR0014
      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8108
      /COPY QCOPYLE,USR8110
      /COPY QCOPYLE,USR8123
      /COPY QCOPYLE,USR8128
      /COPY QCOPYLE,USR8144
      /COPY QCOPYLE,USR8147
      /COPY QCOPYLE,USR8148
      /COPY QCOPYLE,USR8190
      /COPY QCOPYLE,USR8196
      /COPY QCOPYLE,USR8200
      /COPY QCOPYLE,USR8201
      /COPY QCOPYLE,USR8202
      /COPY QCOPYLE,USR8203
      /COPY QCOPYLE,USR8206
      /COPY QCOPYLE,USR8207
      /COPY QCOPYLE,USR8212
      /COPY QCOPYLE,USR8217
      /COPY QCOPYLE,USR8218
      /COPY QCOPYLE,USR8223
      /COPY QCOPYLE,USR8224
      /COPY QCOPYLE,USR8235
      /COPY QCOPYLE,USR9993
      /COPY QCOPYLE,USR9996
      /COPY QCOPYLE,USR9998
      /COPY QCOPYLE,USR9999
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
     D OBJD0400        DS                  likeds(OBJD0400_t) inz
      /COPY QCOPYLE,OBJD0400
     D RCDL0200        DS                  likeds(RCDL0200_t) inz
      /COPY QCOPYLE,RCDL0200
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
     D MBRD0200        DS                  likeds(MBRD0200_t) inz
      /COPY QCOPYLE,MBRD0200
     D FILD0100        DS                  likeds(FILD0100_t) inz
      /COPY QCOPYLE,FILD0100
      *----------------------------------------------------*
      *
     D f_int           PR            20S 0
     D  inpValue                     25S 5 value
      *
     D f_chain00       PR             1A
     D  i_rrn                              value  like(r§rcdNbr  )
     D  i_file                             value  like(r§file    )
     D  i_lib                              value  like(r§lib     )
     D  i_mbr                              value  like(r§mbr     )
     D  i_rcdFmt                     10A   value
      *
     D f_chain04       PR             1A
     D  i_rrn                              value  like(r§rcdNbr  )
     D  i_file                             value  like(r§file    )
     D  i_lib                              value  like(r§lib     )
     D  i_mbr                              value  like(r§mbr     )
     D  i_rcdFmt                     10A   value
      *
     D p_pssr          PR
      *
     D p_regPssr       PR                  extproc('CEERTX')
     D  i_procPtr                      *   const  procptr
     D  i_token                        *   const
     D                                     options(*OMIT)
     D  i_fc                                      like(r§fc      )
     D                                     options(*OMIT)
      *
      /COPY QCOPYLE,F_PEEK51
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK63
      *
      *----------------------------------------------------*
      *  I N F D S - D E F I N I T I O N E N               *
      *----------------------------------------------------*
      *
     DFile#X           DS                  likeds(r§infds)
      *
     D IO_Buff         DS
     D  IO_BuffFld                         like(r§rcdBuf)
      *
     D IO_NullMap      S                   like(r§nullMap)
     D                                     dim(§nullMapSize)
      *
     DPeek#L1          DS
     D P1File                 83     92A
     D P1Library              93    102A
     D P1Member              129    138A
     D P1RcdNbr              397    400I 0
      *
     DPeek#00          DS
     D P0File                 83     92A
     D P0Library              93    102A
     D P0Member              129    138A
     D P0RcdNbr              397    400I 0
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D*XQFile          DS
     D* XFile                        10A
     D* XLibrary                     10A
     D*XMember         S             10A
     D*XAccess         S              1A
     D*XProdlib        S             10A
     D*XChgLib         S              1A
     D*XChgFile        S              1A
     D*XChgMbr         S              1A
     D*XUpdModKey      S              1A
     D*XChgSqlW        S              1A
     D*XChgSqlO        S              1A
     D*XQEnvFile       DS
     D* XEnvFile                     10A
     D* XEnvLib                      10A
     D*XEnvMbr         S             10A
     D*XEnvSave        S              1A
     D*XEnvLayout      S              1A
     D*XSqlWhere       S            512A   varying
     D*XSqlOrder       S            512A   varying
      *
     D rtn             DS                  qualified
     D  file                               like(##File)
     D  library                            like(##Library)
     D  member                             like(##Member)
     D  format                             like(##Format)
     D  accessMode                         like(accessMode)
     D  sqlWhere                           like(sqlWhere)
     D  sqlOrder                           like(sqlOrder)
      *
     D YQFile          DS                  inz
     D  YFile                              like(r§file)
     D  YLibrary                           like(r§lib)
     D YFormat         S                   like(R§RCDFMT) inz
     D YMsgID          S              7A   inz
     D YMsgDta         S            512A   inz
      *
     D YMember         S                   like(r§mbr   ) inz
      *
     D YAttrLen        S                   like(r§int4    ) inz
     D YAttrTyp        S              1A   inz
     D YValue          S            512A   inz
      *
     D YDsp80          S                   like(SET_Dsp80) inz
     D YCopyRight      S                   like(r§copyRght) inz(§CopyRight)
      *
     D YFmtNbr         S              5I 0 inz
      *
     D YHeaderTyp      S             10A   inz
     D YRcdNbr         S                   inz(§ZEROS ) like(r§rcdNbr)
     D YFunction       S             10A   inz
     D YCommitLVL      S                   inz('0')     like(CommitLVL)
     D YIsUpdKey       S                   inz(bFalse)  like(isUpdKey )
     D YScreenNbr      S                   like(r§int4    ) inz
     D YIsLower        S                   inz(bFalse ) like(r§bool   )
     D YCsrRow         S                   like(r§int4    ) inz
     D YCsrCol         S                   like(r§int4    ) inz
      *
     D YCvtCcsid       S              1A   inz(bTrue  )
     D YData           S            512A   inz
      *
     D YRetFile        S             10A   inz
     D YRetLib         S             10A   inz
      *
     D YRtnCode        S              1A   inz
      *
     D YField          S                   like(SrchField) inz
     D YOperation      S                   like(SrchOP   ) inz
     D YArgument       S                   like(SrchArg  ) inz
     D YSign           S                   like(SrchSign ) inz
     D YSrchNbrs       S                   like(SrchNbrs ) inz(§ZEROS )
     D YSrchType       S                   like(SrchType ) inz
     D YSrchCase       S                   like(SrchCase ) inz(bFalse )
      *
     D YBuffer         S                   like(r§rcdBuf  )
     D                                     inz
     D                 DS
     D yHexString                          like(r§hexBuf  )
     D yOutBuffer                          like(r§rcdBuf  )
     D                                     overlay(yHexString:1)
     D YOutBuffLn      S                   like(r§int4    ) inz
     D YTgtValue       S             10A   inz
      *
     D YKeyVal         S                   like(r§keyBuf  ) inz
      *
     D YPgmCmd         S             10A   inz
     D YCmdDta         S                   like(r§pgmCmdDt) inz
      *
     D yFKeys          S             18A   dim(32)       inz
     D yNbrOfKeys      S                   like(r§int4    ) inz
      *
     D YChoice         S                   like(r§choice  ) dim(32) inz
     D YNbrOfCh        S                   like(r§int4    ) inz
      *
     D YMbrOpt         S             10A   inz
     D YCrtFile        S             10A   inz
      *
     D YFlag           S                   inz(*ZEROS)  like(r§int4)
      *
     D BuffIdx         S                   like(r§int4    ) inz
      *
     D shortCmd        DS                  likeds(ShortCmd_t) inz
     D YExecCmd        S                   like(r§cmdBuffer) inz
     D YNbrOfEnt       S                   like(r§int4    ) inz
     D YSqlWhere       S            512A   inz
     D YSqlOrder       S            512A   inz
     D YAccess         S              1A   inz
     D yAlwLc          S              1A   inz
     D yCase           S              1A   inz
     D yRcdLock        S              1A   inz
     D yNullDft        S              1A   inz
     D yKeepCrs        S              1A   inz
     D YEnvFile        S                   like(r§file    )  inz
     D YEnvLib         S                   like(r§lib     )  inz
     D YEnvMbr         S                   like(r§mbr     )  inz
     D YIsAutoSave     S                   like(r§bool    )  inz(bFalse)
     D YPinTabR        S                   like(r§pIntAbr )  inz dim(12)
     D YnbrPinR        S                   like(r§int4    )  inz
     D YnbrPinC        S                   like(r§int4    )  inz
     D YAccMode        S              1A   inz
     D YisKeyLower     S                   like(r§bool    )  inz
     D YOption         S                   like(r§option  )  inz
     D YText           S             50A   inz
     D ySflOpt         S              2A
     D YString         S                   like(r§rcdBuf  )
     D                                     inz
     D YStringLen      S                   like(r§int4    ) inz
     D YchgLib         S              1A   inz
     D YchgFile        S              1A   inz
     D YchgMbr         S              1A   inz
     D YupdMod         S              1A   inz
     D YupdKey         S              1A   inz
     D YchgSqlW        S              1A   inz
     D YchgSqlO        S              1A   inz
     D YaccAut         S              1A   inz
     D yEvent          S             10A   inz
     D yUser           S             10A   inz
     D yTimestamp      S               Z   inz
     D ySize           S             10I 0 inz
     D yBImage         S               *   inz
     D yAImage         S               *   inz
      *
     D                 DS
     D ScrnFKeys                     18A   DIM(32)        inz
     D  $$FKEY01               1     18A
     D  $$FKEY02              19     36A
     D  $$FKEY03              37     54A
     D  $$FKEY04              55     72A
     D  $$FKEY05              73     90A
     D  $$FKEY06              91    108A
     D  $$FKEY07             109    126A
     D  $$FKEY08             127    144A
     D  $$FKEY09             145    162A
     D  $$FKEY10             163    180A
     D  $$FKEY11             181    198A
     D  $$FKEY12             199    216A
     D  $$FKEY13             217    234A
     D  $$FKEY14             235    252A
     D  $$FKEY15             253    270A
     D  $$FKEY16             271    288A
     D  $$FKEY17             289    306A
     D  $$FKEY18             307    324A
     D  $$FKEY19             325    342A
     D  $$FKEY20             343    360A
     D  $$FKEY21             361    378A
     D  $$FKEY22             379    396A
     D  $$FKEY23             397    414A
     D  $$FKEY24             415    432A
     D  $$FKEY25             433    450A
     D  $$FKEY26             451    468A
     D  $$FKEY27             469    486A
     D  $$FKEY28             487    504A
     D  $$FKEY29             505    522A
     D  $$FKEY30             523    540A
     D  $$FKEY31             541    558A
     D  $$FKEY32             559    576A
      *
     D §HEX_CHAR       C                   CONST('-')
      *
     D §ZEROS          C                   CONST(0)
      *
     D IsREADSFL       S              1A   inz(bFalse)
     D IsPBINIT        S              1A   inz(bFalse)
     D IsFirstSfl      S              1A   inz(bFalse)
     D IsFileChg       S              1A   inz(bFalse)
     D IsTblCol        S              1A   inz(bFalse)
     D IsTargetOK      S              1A   inz(bFalse)
     D IsSeqNbrOK      S              1A   inz(bFalse)
     D IsOpen          S              1A   inz(bFalse)
     D IsUpdMod        S                   like(r§bool    )  inz(bFalse)
     D IsUpdKey        S                   like(r§bool    )  inz(bFalse)
     D IsVisible       S              1A   inz(bFalse)
     D IsError         S              1A   inz(bFalse)
     D IsFileError     S              1A   inz(bFalse)
     D IsKeyAvail      S              1A   inz(bFalse)
     D IsKeyChg        S              1A   inz(bFalse)
     D IsSflDirty      S              1A   inz(bFalse)
     D IsTryed         S              1A   inz(bFalse)
     D IsPinned        S              1A   inz(bFalse)
     D IsPinModeR      S              1A   inz(bFalse)
     D IsPinModeC      S              1A   inz(bFalse)
     D IsPinOK         S              1A   inz(bFalse)
     D IsPinRmv        S              1A   inz(bFalse)
     D IsEOF           S              1A   inz(bFalse)
     D QueryUser       S                   like(Sfl_Cmd   ) inz(*ALLX'00')
     D IsFound         S              1A   inz(bFalse)
     D IsCmdErr        S              1A   inz(bFalse)
     D IsCancel        S              1A   inz(bFalse)
     D R#IsCmdErr      S              1A   inz(bFalse)
     D IsCvtChar       S              1A   inz(bFalse)
     D IsPinToClr      S              1A   inz(bTrue )
     D IsReadC         S              1A   inz(bFalse)
      *** IsNumeric       S                   like(r§bool    )
      ***                                     inz(bFalse)
     D IsColExc        S                   like(r§bool    )
     D                                     inz(bFalse)
     D isKeyLower      S              1A   inz(bFalse)
      *
     D CommitLVL       S              1A   inz('0')
      *
     D auth            DS                  qualified
     D  chgLib                             like(r§bool    )
     D                                     inz(bFalse)
     D  chgFile                            like(r§bool    )
     D                                     inz(bFalse)
     D  chgMbr                             like(r§bool    )
     D                                     inz(bFalse)
     D  updMod                             like(r§bool    )
     D                                     inz(bFalse)
     D  updKey                             like(r§bool    )
     D                                     inz(bFalse)
     D  chgSqlW                            like(r§bool    )
     D                                     inz(bFalse)
     D  chgSqlO                            like(r§bool    )
     D                                     inz(bFalse)
     D  accAut                             like(r§bool    )
     D                                     inz(bFalse)
      *
     D SflPage         S                   like(r§int4    ) inz
     D SflRec080       S                   inz(0) like(SflPage)
     D SflRec132       S                   inz(0) like(SflPage)
     D SflNbrRcd       S                   inz(0) like(SflPage)
     D SflDataLen      S                   like(r§int4    ) inz
     D SflDataLenFree  S                   like(r§int4    ) inz
     D SfTop           S                   like(r§int4    ) inz
     D SfBot           S                   like(r§int4    ) inz
     D Sfl_Cmd         S             10A   inz
     D SflHeadLRw      S                   inz(0) like(SflPage)
     D SflFirstRw      S                   inz(0) like(SflPage)
     D SflLastRw       S                   inz(0) like(SflPage)
     D SflLeftOfs      S                   like(r§int4    ) inz
     D SflMode         S             10A   inz
     D SflPinRnge      S                   like(r§int4    ) inz
      *
     D §CopyRight      C                   CONST('1997-2023, -
     D                                      Thomas Raddatz - PEEK V3.5.8')
     D §Release        C                   CONST('Stand: 16.09.2023')
     D §Version        C                   CONST('V03R05M08')
      *
     D L#File          S                   like(##File)    inz
     D L#Library       S                   like(##Library) inz
     D L#Member        S                   like(##Member)  inz
     D L#Format        S                   like(##Format)  inz
     D L#MaxSeq        S                   like(F_SEQ   )  inz(§ZEROS )
     D L#MinSeq        S                   like(F_SEQ   )  inz(§ZEROS )
     D L#WndNbr        S                   like(##WndNbr)  inz(§ZEROS )
      *
     D R#Size          S                   like(r§int4    ) inz
      *
     D PEEK01_NAME     S                   like(r§pgmCallN) inz
     D PEEK03_NAME     S                   like(r§pgmCallN) inz
     D PEEK04_NAME     S                   like(r§pgmCallN) inz
     D PEEK06_NAME     S                   like(r§pgmCallN) inz
     D PEEK07_NAME     S                   like(r§pgmCallN) inz
     D PEEK08_NAME     S                   like(r§pgmCallN) inz
     D PEEK09_NAME     S                   like(r§pgmCallN) inz
     D PEEK10_NAME     S                   like(r§pgmCallN) inz
     D PEEK12_NAME     S                   like(r§pgmCallN) inz
     D PEEK13_NAME     S                   like(r§pgmCallN) inz
     D PEEK14_NAME     S                   like(r§pgmCallN) inz
     D PEEK17_NAME     S                   like(r§pgmCallN) inz
     D PEEK18_NAME     S                   like(r§pgmCallN) inz
     D PEEK19_NAME     S                   like(r§pgmCallN) inz
     D PEEK20_NAME     S                   like(r§pgmCallN) inz
     D PEEK21_NAME     S                   like(r§pgmCallN) inz
     D PEEK23_NAME     S                   like(r§pgmCallN) inz
     D PEEK24_NAME     S                   like(r§pgmCallN) inz
     D PEEK26_NAME     S                   like(r§pgmCallN) inz
     D PEEK27_NAME     S                   like(r§pgmCallN) inz
     D PEEK30_NAME     S                   like(r§pgmCallN) inz
     D PEEK32_NAME     S                   like(r§pgmCallN) inz
     D PEEK33_NAME     S                   like(r§pgmCallN) inz
     D PEEK34_NAME     S                   like(r§pgmCallN) inz
     D PEEK37_NAME     S                   like(r§pgmCallN) inz
     D PEEK38_NAME     S                   like(r§pgmCallN) inz
     D PEEK40_NAME     S                   like(r§pgmCallN) inz
     D PEEK41_NAME     S                   like(r§pgmCallN) inz
     D PEEK42_NAME     S                   like(r§pgmCallN) inz
     D PEEK47_NAME     S                   like(r§pgmCallN) inz
     D PEEK48_NAME     S                   like(r§pgmCallN) inz
     D PEEK49_NAME     S                   like(r§pgmCallN) inz
     D PEEK50_NAME     S                   like(r§pgmCallN) inz
     D PEEK52_NAME     S                   like(r§pgmCallN) inz
     D PEEK54_NAME     S                   like(r§pgmCallN) inz
     D PEEK55_NAME     S                   like(r§pgmCallN) inz
     D PEEK56_NAME     S                   like(r§pgmCallN) inz
     D PEEK57_NAME     S                   like(r§pgmCallN) inz
     D PEEK59_NAME     S                   like(r§pgmCallN) inz
     D PEEK65_NAME     S                   like(r§pgmCallN) inz
     D PEEK68_NAME     S                   like(r§pgmCallN) inz
     D PEEK69          S                   like(r§pgmCallN) inz
      *
     D PEEKPGM         S                   like(r§pgm     ) inz
     D PEEKDSPF        S                   like(r§file    ) inz
     D PgmToCall       S                   like(r§pgmCallN) inz
      *
     D EXIT01          S                   like(r§pgmCallN) inz
      *
     D DataDS          DS
     D  Data                          1A   DIM(256) inz
     D  DataElems                   256A   OVERLAY(DataDS)
     D DataMax         C                   CONST(132)
     D DataStr         S                   like(r§int4    ) inz
     D DataEnd         S                   like(r§int4    ) inz
     D DataLen         S                   like(r§int4    ) inz
     D ColrOfs         S                   like(r§int4    ) inz
     D Col_Field       S             10A   DIM(60)  inz
     D Col_ScnStr      S                   like(r§int4    ) dim(60)
     D Col_ScnEnd      S                   like(r§int4    ) dim(60)
     D Col_Error       S                   like(r§bool    ) dim(60) inz(bFalse)
     D CP              S                   like(r§int4    ) inz
      *##StrPage       S                   like(r§int4    ) inz
     D FldStrPos       S                   like(r§int4    ) inz
      *
     D HeadLen         S                   like(r§int4    ) inz
     D FieldLen        S                   like(r§int4    ) inz
     D MaxColLen       S                   like(r§int4    ) inz
     D ColumnLen       S                   like(r§int4    ) inz
      *
     D PinXC           S                   like(r§int4    ) inz
     D MaxPinCol       C                   CONST(12)
     D PinTabC         S             10A   inz             DIM(12)
     D NbrPinCol       S                   inz(§ZEROS )    like(SflPage)
      *
     D PinXR           S                   like(r§int4    ) inz
     D MaxPinRcd       C                   CONST(12)
     D PinTabR         S                   like(r§pIntAbr)
     D                                     inz             DIM(12)
     D PIN#DS          DS                  likeds(pinTabR_t)
     D*PIN#STR         S                   like(PIN#DS) BASED(pPIN#STR)
     D*pPIN#STR        S               *   inz(%addr(PIN#DS))
      ***                                  prefix(PIN#)
     D NbrPinRcd       S                   inz(§ZEROS) like(SflPage  )
      *
      *  Arbeitsfelder
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
     D Z               S                   like(r§int4    ) inz
     D A1              S              1A   inz
      *  Arbeitsfeld für Sortierfolge: Satzfolge/Schlüsselfolge
      *  .. aktuelle Sortierung
     D AccessMode      S              1A   inz(§RrnSeq)
      *  .. neue Sortierung für ChangeFile
     D NewAccMode      S              1A   inz(§RrnSeq)
      *  .. Sortierung vor SQl-Mode
     D OldAccMode      S              1A   inz(§RrnSeq)
      *  Arbeitsfeld für Befehlsverarbeitung, Verhinderung von Rekursionen
     D R#PgmCmd        S                   like(YPgmCmd)  inz
      *  Arbeitsfeld für Eingabe Aufsetzkey
     D R#RcdNbr        S                   like(##RcdNbr)   inz(§ZEROS )
     D R#KeyVal        S                   like(##Key   )   inz
      *  Arbeitsfeld für PIN-Funktion
     D Pin#Field       S             10A   inz
      *  Datensatz-Nr für SETLL und SETGG zum füllen der Subfile
     D Wrk#ReadDn      S                   like(SflPage)    inz(§ZEROS)
     D Wrk#RcdNbr      S                   like(r§rcdNbr)   inz(§ZEROS)
     D                 DS
     D Wrk#KeyVal                          like(r§keyBuf  ) inz
      *  ...
     D Wrk#Field       S                   inz            like(F_Field)
     D Wrk#SeqNbr      S                   inz(§ZEROS )   like(F_Seq)
     D Wrk#Recno       S                   inz(§ZEROS )   like(SflRec132)
     D Wrk#SFPAU       S                   inz            like(SFPAU)
      *  Umschalten der Sortierung
     D Last#RcdNr      S                   like(r§rcdNbr)   inz(§ZEROS)
      *  Farbattribute einsetzen
     D Wrk#Ofs         S                   like(r§int4    ) inz
      *  Felder mit mehr als 512 Zeichen im Datensatz
     D IsFld512        S              1A   inz(bFalse)
      *  Felder für Suchfunktion
     D SrchMode        S             10A   inz('*NEW')
     D SrchFndRcd      S                   like(r§rcdNbr )  inz(§ZEROS )
     D SrchField       S             10A   inz
     D SrchOP          S             10A   inz
     D SrchArg         S             63A   inz
     D SrchSign        S              1A   inz
     D SrchArgFloat    S              8F   inz
     D SrchArgVal      S             63S 0 inz
     D cSRCHARG_DIGITS...
     D                 C                   %len(SrchArgVal)
     D cSRCHARG_DECPOS...
     D                 C                   %decpos(SrchArgVal)
     D SrchLikeTp      S                   like(r§int4    ) inz
     D SrchLikeLn      S                   like(r§int4    ) inz
     D SrchNbrs        S             10P 0 inz(§ZEROS )
     D SrchType        S             10A   inz
     D SrchCase        S              1A   inz(bFalse )
     D SrchCmpStr      S                   like(SrchArg)  inz
     D SrchCmpVal      S                   like(SrchArgVal) inz(§ZEROS )
     D SRCH_CMP_VAL_LENGTH...
     D                 C                   %len(SrchCmpVal)
     D SRCH_CMP_VAL_DECPOS...
     D                 C                   %decpos(SrchCmpVal)
     D SrchCmpFloat    S              8F   inz(§ZEROS )
     D SrchCmpRcd      S                   like(r§rcdBuf  )
     D                                     inz
     D SrchCount       S                   like(SrchNbrs) inz(§ZEROS)
     D SrchCount2      S                   like(SrchNbrs) inz(§ZEROS)
     D SrchDspMsg      S                   like(SrchNbrs) inz(§ZEROS)
     D SrchIsNum       S              1A   inz(bFalse)
     D SrchArgIsFloat  S              1A   inz(bFalse )
      *  Felder für Kopierfunktion
     D CopyFile        S             10A   inz
     D CopyLib         S             10A   inz
     D CopyToMbr       S             10A   inz
     D CopyMbrOpt      S             10A   inz
     D CopyCrtF        S             10A   inz
      *  Überlagern von ##Key132uc mit ##Key80uc
     D ##Key           S                   like(##Key132uc) inz
     D                 DS
     D ##Key132uc                   116A
     D ##Key80uc                     67A   OVERLAY(##Key132uc:1)
     D                 DS
     D ##Key132lc                   116A
     D ##Key80lc                     67A   OVERLAY(##Key132lc:1)
      *
     D SqlWhere                     512A   inz
     D SqlOrder                     512A   inz
     D                 DS
     D rcdNbr#                       10S 0
     D rcdNbr$                       10A   OVERLAY(rcdNbr#: 1)
      *
     D exitMsg         S            512A   varying inz
     D colHeading      S            128A   varying inz
      *
      *  Feldinhalte vor der Bildschirmausgabe
     D B4              DS                  qualified
     D  WndNbr                             like(##WndNbr )
     D  StrPage                            like(##StrPage)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
     D PEEK05          PI
     D  io_qFile                                 likeds(r§qObj)
     D  i_member                           const like(r§mbr)
     D  i_access                           const like(r§accessMode)
     D  i_prodlib                          const like(r§lib)
     D  i_chgLib                           const like(r§bool)
     D  i_chgFile                          const like(r§bool)
     D  i_chgMbr                           const like(r§bool)
     D  i_updModKey                        const like(r§bool)
     D  i_chgSqlW                          const like(r§bool)
     D  i_chgSqlO                          const like(r§bool)
     D  i_qEnvFile                         const likeds(r§qObj)
     D  i_envMbr                           const like(r§mbr)
     D  i_envSave                          const like(r§bool)
     D  i_envLayout                        const like(r§bool)
     D  i_sqlWhere                         const like(r§sqlWhere)
     D  i_sqlOrder                         const like(r§sqlOrder)
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEKPGM
     C     P_PeekPgm     PLIST
     C                   PARM                    YDsp80
     C                   PARM                    YHeaderTyp
     C                   PARM                    YCopyRight
     C                   PARM                    YRcdNbr
     C                   PARM                    YFile
     C                   PARM                    YLibrary
     C                   PARM                    YMember
     C                   PARM                    YFunction
     C                   PARM                    YCommitLVL
     C                   PARM                    YIsUpdKey
     C                   PARM                    YScreenNbr
     C                   PARM                    YIsLower
     C                   PARM                    YCsrRow
     C                   PARM                    YCsrCol
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für EXIT01
     C     P#Exit01      PLIST
     C                   PARM                    YQFile
     C                   PARM                    YMember
     C                   PARM                    YAccess
     C                   PARM                    YchgLib
     C                   PARM                    YchgFile
     C                   PARM                    YchgMbr
     C                   PARM                    YupdMod
     C                   PARM                    YupdKey
     C                   PARM                    YchgSqlW
     C                   PARM                    YchgSqlO
     C                   PARM                    YaccAut
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für EXIT04
     C     P#Exit04      Plist
     C                   Parm                    yFile
     C                   Parm                    yLibrary
     C                   Parm                    yMember
     C                   Parm                    yEvent
     C                   Parm                    yUser
     C                   Parm                    yTimestamp
     C                   Parm                    yRcdNbr
     C                   Parm                    ySize
     C                   Parm                    yBImage
     C                   Parm                    yAImage
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK69
     C     P_Peek69      PLIST
     C                   PARM                    YDsp80
     C                   PARM                    YCopyRight
     C                   PARM                    YQFile
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLDL1
     C     F1KEY_L1      KLIST
     C                   KFLD                    F_SEQ
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLD
     C     F_KEY         KLIST
     C                   KFLD                    F_Field
      *
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
      *
      *---------------------------------------------------*
      *  Schleife für Programmbearbeitung
      *
     C                   DO        *HIVAL
      *
      *  Ermitteln der Feldnummer des ersten
      *  sichtbaren Feldes
     C                   EXSR      GetFrstFld
      *
      *  Öffnen/Schützen "Feldseite"
     C                   If        SET_FLDPGE = '1'
     C                   EVAL      *IN72 = '0'
     C                   Else
     C                   EVAL      *IN72 = '1'
     C                   Endif
      *
      *  Öffnen/Schützen "Aufsetzschlüssel/Satznummer"
     C                   If        AccessMode = §SqlSeq
     C                   EVAL      *IN73 = '1'
     C                   Else
     C                   EVAL      *IN73 = '0'
     C                   Endif
      *
      *  Öffnen/Schützen Dateiauswahlfelder ...
      *  ... ##Library
     C                   If        auth.chgLib = bTrue
     C                   Eval      *IN74 = *OFF
     C                   Else
     C                   Eval      *IN74 = *ON
     C                   Endif
      *  ... ##File
     C                   If        auth.chgFile = bTrue
     C                   Eval      *IN75 = *OFF
     C                   Else
     C                   Eval      *IN75 = *ON
     C                   Endif
      *  ... ##Member
     C                   If        auth.chgMbr = bTrue
     C                   Eval      *IN77 = *OFF
     C                   Else
     C                   Eval      *IN77 = *ON
     C                   Endif
      *
      *  Eingabe der Schlüselfelder in Gross- oder Kleinbuchstaben
     C                   If        isKeyLower = bFalse
     C                   Eval      *IN78 = *OFF
     C                   Eval      ##Key132uc = ##Key
     C                   Else
     C                   Eval      *IN78 = *ON
     C                   Eval      ##Key132lc = ##Key
     C                   Endif
      *
      *  Prüfen Positionierung der Subfile
     C     SFSANR        IFLE      §ZEROS
     C                   EVAL      SFSANR = NbrPinRcd + 1
     C                   Endif
     C     SFSANR        IFGT      SflNbrRcd
     C                   EVAL      SFSANR = SflNbrRcd
     C                   Endif
      *
      *  Für Prüfung: Eingabe neuer Aufsetzkey
     C                   EVAL      R#RcdNbr = ##RcdNbr
     C                   EVAL      R#KeyVal = ##Key
      *
      *  Nachrichten senden
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
      *  Nachrichten anzeigen
     C                   EVAL      *IN89 = '0'
     C                   WRITE     MSGCTL
      *
      *  "Keine Sätze ..."
     C     *IN80         IFEQ      '0'
     C                   WRITE     PBLEER
     C                   Endif
      *
      *  Anzeigen der Einzelauswahlen
     C     SFTop         IFGT      32
     C     SFTop         ORGT      YNbrOfCh
     C                   EVAL      SFTop = 1
     C                   Endif
     C                   EVAL      $$CHOICE = YChoice(SFTop)
      *
      *  Anzeigen der Befehlstasten
     C                   SELECT
     C     SFBOT         WHENEQ    2
     C     YNbrOfKeys    ANDGT     8
     C  N88              WRITE     PBBOT132#2
     C   88              WRITE     PBBOT080#2
     C     SFBOT         WHENEQ    3
     C     YNbrOfKeys    ANDGT     16
     C  N88              WRITE     PBBOT132#3
     C   88              WRITE     PBBOT080#3
     C     SFBOT         WHENEQ    4
     C     YNbrOfKeys    ANDGT     24
     C  N88              WRITE     PBBOT132#4
     C   88              WRITE     PBBOT080#4
     C                   OTHER
     C  N88              WRITE     PBBOT132#1
     C   88              WRITE     PBBOT080#1
     C                   EVAL      SFBOT = 1
     C                   Endsl
      *
      *  Merken Startseite innerhalb des Feldes
     C                   EVAL      B4.WndNbr = ##WndNbr
     C                   EVAL      B4.StrPage = ##StrPage
      *
      *  Anzeige der Subfile
     C  N88              EXFMT     PBCTL132
     C   88              EXFMT     PBCTL080
      *
      *  Übernehmen Schlüselfelder
     C                   If        isKeyLower = bFalse
     C                   Eval      ##Key = ##Key132uc
     C                   Else
     C                   Eval      ##Key = ##Key132lc
     C                   Endif
      *
      *  Berechnen Zeile/Spalte
     C     §ScnCsrPos    DIV       256           §ScnCsrRow
     C                   MVR                     §ScnCsrCol
      *
      *  Löschen der Cursorposition
     C                   EVAL      CsrRow = §ZEROS
     C                   EVAL      CsrCol = §ZEROS
      *
      *  Merker für aktualisieren der Subfile
     C                   EVAL      IsSflDirty = bFalse
      *
      *  Merker für abfragen der Zieldatei
     C                   EVAL      IsTargetOK = bFalse
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Cursor-Pos. löschen
     C                   EVAL      *IN87 = '0'
      *
      *  Aktuelle Satz-Nr.
     C                   EVAL      SFSANR = SFLCSR
      *
      *  Suchmodus
     C     YPgmCmd       IFNE      '*SEARCH'
     C                   EVAL      SrchMode = '*NEW'
     C                   EVAL      SrchFndRcd = §ZEROS
     C                   Endif
      *
      *  Mappen der gedrückten Taste
      *  in Programmbefehl
     C                   CALLP     PEEK21(§ScnAID: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C     YMsgID        IFNE      *BLANKS
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *  Abfragen der Programmbefehle
     C                   EXSR      DoScrnCmd
     C     IsCmdErr      IFEQ      bTrue
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
     C                   Endif
      *
      *  ... Subfile aktualisieren
     C     IsSflDirty    IFEQ      bTrue
     C                   EXSR      PBRefresh
     C                   Endif
      *
      *  ... Offene Datei aktualisieren
     C                   EXSR      GetOpnFile
      *
     C                   Enddo
      *
      *  Ende der Hauptschleife
      *---------------------------------------------------*
      *
      *  Programm verlassen
     C     ENDE          TAG
      *
     C                   EVAL      *INLR = '1'
      *
      *============================================================*
      *    DoScrnCmd     Ausführen Bildschirmbefehl                *
      *============================================================*
      *
     C     DoScrnCmd     BEGSR
      *
      *  Sicherstellen, dass die Startseite innerhalb eines Feldes
      *  immer gefüllt ist:
      *
      *  Verwenden der alten Werte bei F5
     C     YPgmCmd       IFEQ      '*REFRESH'
     C                   EVAL      ##WndNbr = B4.WndNbr
     C                   EVAL      ##StrPage = B4.StrPage
     C                   ELSE
      *
      *  Positionieren auf Feldanfang bei Wechsel des Startfeldes
     C     ##WndNbr      IFNE      B4.WndNbr
     C     ##StrPage     ANDEQ     B4.StrPage
     C                   EVAL      ##StrPage = 1
     C                   ENDIF
      *
     C                   ENDIF
      *
      *  Verwenden der alten Startposition von vor der Bildschirmausgabe
     C     ##StrPage     IFEQ      *ZEROS
     C                   EVAL      ##StrPage = B4.StrPage
     C                   ENDIF
      *
      *  Sicherstellen, dass das Feld gefüllt ist
     C     ##StrPage     IFEQ      *ZEROS
     C                   EVAL      ##StrPage = 1
     C                   ENDIF
      *
      *  Verarbeiten Bildschirmereignis
     C                   EVAL      R#PgmCmd = YPgmCmd
      *
      /COPY QCOPYLE,DOPGMCMD
      *
     C                   EVAL      R#PgmCmd = *BLANKS
      *
     C                   ENDSR
      *
      *============================================================*
      *    DoSflCmd      Ausführen Subfilebefehl                   *
      *============================================================*
      *
     C     DoSflCmd      BEGSR
      *
     C     YPgmCmd       IFEQ      R#PgmCmd
     C                   EVAL      IsCmdErr = bTrue
     C                   EVAL      §MsgID = 'USR8144'
     C                   EVAL      USR81441 = YPgmCmd
     C                   EVAL      §MsgDta = USR8144
     C                   ELSE
      /COPY QCOPYLE,DOPGMCMD
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Enter       "Datenfreigabetaste"                      *
      *============================================================*
      *
     C     C_Enter       BEGSR
      *
      *  Löschen der Cursor-Position ...
     C                   EXSR      DltCsrPos
      *
      *  Datei hat gewechselt ...
     C                   IF        ((##File    <> L#File) and
     C                              (not f_endsWith('*': %trim(##File))) and
     C                              (%trim(##File  ) <> SET_PRMT)) or
     C                             (##Library  <> L#Library      ) or
     C                             ((##Member  <> L#Member) and
     C                              (%trim(##Member) <> SET_PRMT)) or
     C                             ((##Format  <> L#Format) and
     C                              (%trim(##Format) <> SET_PRMT))
     C                   EVAL      *IN93 = '1'
     C                   ELSE
      *
      *  Abfragen Prompt?
      *  ... ##File
     C                   IF        %trim(##File) = SET_PRMT or
     C                             f_endsWith('*': %trim(##File))
     C                   EXSR      C_Prompt
     C     §MsgID        IFNE      *BLANKS
     C                   GOTO      E_Enter
     C                   ELSE
     C                   EVAL      *IN93 = '1'
     C                   Endif
     C                   Endif
      *  ... ##Member
     C                   IF        %trim(##Member) = SET_PRMT
     C                   EXSR      C_Prompt
     C     §MsgID        IFNE      *BLANKS
     C                   GOTO      E_Enter
     C                   ELSE
     C                   EVAL      *IN93 = '1'
     C                   Endif
     C                   Endif
      *  ... ##Format
     C                   IF        %trim(##Format) = SET_PRMT
     C                   EXSR      C_Prompt
     C     §MsgID        IFNE      *BLANKS
     C                   GOTO      E_Enter
     C                   ELSE
     C                   EVAL      *IN93 = '1'
     C                   Endif
     C                   Endif
      *  ... ##Field
     C                   IF        %trim(##Field ) = SET_PRMT
     C                   EXSR      C_Prompt
     C     §MsgID        IFNE      *BLANKS
     C                   GOTO      E_Enter
     C                   ELSE
     C                   EVAL      *IN93 = '1'
     C                   Endif
     C                   Endif
     C                   Endif
      *
     C     *IN93         IFEQ      '0'
      *
      *  Keine Eigaben ...
      *  ... also abfragen der Subfileauswahlen
     C     IsREADSFL     IFEQ      bTrue
      *       verhindern einer Rekursion
     C                   ELSE
     C                   EXSR      C_ReadSfl
     C                   Endif
      *
     C                   ELSE
      *
      *  Wechsel der Datei ...
      ***                If        AccessMode = §SqlSeq
     C                   Eval      NewAccMode = i_access
      ***                Else
      ***                Eval      NewAccMode = AccessMode
      ***                Endif
      *
     C                   EXSR      ChangeFile
      *
      *  Prüfen Seq-Bereich (##WndNbr) ...
     C                   EXSR      ChkSeqRnge
      *
      *  Wechsel des Fenster (##Field) ...
     C                   EXSR      ChangeWnd
      *
      *  Wechsel des Aufsetzkeys ...
     C                   EXSR      ChangeKey
      *
      *  Füllen der Subfile ...
     C     IsFileChg     IFEQ      bTrue
     C                   EXSR      DltCsrPos
     C                   EXSR      C_Top
     C                   ELSE
     C     IsKeyChg      IFEQ      bFalse
     C                   EXSR      PBRefresh
     C                   ELSE
     C                   EXSR      DltCsrPos
     C                   EXSR      KeyHasChg
     C                   Endif
     C                   Endif
      *
     C                   Endif
      *
     C     E_Enter       ENDSR
      *
      *============================================================*
      *    C_ReadSfl     Lesen & Verarbeiten der Subfile-Auswahlen *
      *============================================================*
      *
     C     C_ReadSfl     BEGSR
      *
      *  Merker für: Subfile gelöscht zurück setzen
      *              abbrechen READC, wenn Subfileinhalt
      *              gelöscht worden ist über PBINIT
     C                   EVAL      IsPBINIT = bFalse
      *  Merker für: Programmablauf innerhalb der READC-Schleife
      *              verhindern einer Rekursion über
      *              C_ENTER, C_PAGEUP, C_PAGEDOWN
     C                   EVAL      IsREADSFL = bTrue
      *
     C                   EVAL      R#IsCmdErr = IsCmdErr
      *
      *  Mindestens 1 Eintrag verarbeitet ...
     C                   EVAL      IsReadC = bFalse
      *
     C     *IN80         IFEQ      '0'
      *           Keine Einträge vorhanden
     C                   ELSE
      *
     C     QueryUser     DOUEQ     *ALLX'00'
      *
     C                   EVAL      QueryUser = *ALLX'00'
      *
      *  Lesen, solange bis keine zu verarbeitenden
      *  Sätze mehr da sind, oder bis durch einen
      *  Kurzbefehl (SFPAU) die Subfile neu auf-
      *  gebaut worden ist.
     C     IsPBINIT      DOWEQ     bFalse
      *
     C  N88              READC     PBSFL132                               11
     C   88              READC     PBSFL080                               11
      *
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
      *  Cursorpositionierung ...
     C  N88              Z-ADD     SflRec132     SflCsr
     C   88              Z-ADD     SflRec080     SflCsr
      *
      *  Linksbündig setzen ...
     C                   Eval      SFPAU = %triml(SFPAU)
      *
      *  Prompt ...
     C                   IF        %trim(SFPAU) = SET_PRMT
     C                   EXSR      Pmt_Sfpau
     C                   ENDIF
      *
      *  Zuordnung AUSWAHL => Befehl ...
     C                   CALLP     PEEK21('#' + SFPAU: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C     YMsgID        IFNE      *BLANKS
      *  Fehlermeldung ...
     C                   EVAL      §MsgID = 'USR8110'
     C                   EVAL      §MsgDta = SFPAU
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
    WC                   EXSR      PBSflChain
     C     *IN11         IFEQ      '0'
     C                   EVAL      *IN84 = '1'
     C                   EVAL      *IN85 = '1'
    WC                   EXSR      PBSflUpdat
     C                   Endif
     C                   ITER
     C                   Endif
      *
      *----------------------------*
      *  Ausführen SFL-Befehl ...  *
      *----------------------------*
      *
     C                   EVAL      Sfl_Cmd = YPgmCmd
      *
      *  Vorrangig Blockverarbeitung (F22)
      *  verarbeiten ...
     C     QueryUser     IFNE      *ALLX'00'
     C     Sfl_Cmd       ANDNE     QueryUser
    WC                   EXSR      PBSflChain
     C     *IN11         IFEQ      '0'
     C                   EVAL      *IN84 = '1'
    WC                   EXSR      PBSflUpdat
     C                   Endif
     C                   ITER
     C                   Endif
      *
      *  Verarbeiten der Befehle ...
     C                   EXSR      DoSflCmd
     C     IsCmdErr      IFEQ      bTrue
      *  Fehlermeldung ...
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
    WC                   EXSR      PBSflChain
     C     *IN11         IFEQ      '0'
     C                   EVAL      *IN84 = '1'
     C                   EVAL      *IN85 = '1'
    WC                   EXSR      PBSflUpdat
     C                   Endif
     C     IsCancel      IFEQ      bTrue
     C                   LEAVE
     C                   ELSE
     C                   ITER
     C                   Endif
     C                   Endif
      *
      *  Mindestens ein Eintrag verarbeitet ...
      *  (ignorieren leere Auswahlen)
     C     YPgmCmd       IFNE      '*NONE'
     C                   EVAL      IsReadC = bTrue
     C                   ENDIF
      *
      *  Verarbeitung auswerten ...
    WC                   EXSR      PBSflChain
     C     *IN11         IFEQ      '0'
      *  ... Abbruch mit F3/F12
     C     YMsgID        IFEQ      'USR8100'
     C                   EVAL      *IN84 = '1'
     C                   ELSE
      *  ... Verarbeitung durchgeführt
     C                   EVAL      *IN84 = '0'
     C                   EVAL      *IN85 = '0'
     C                   EVAL      SFPAU = *BLANKS
     C                   Endif
    WC                   EXSR      PBSflUpdat
     C     YMsgID        IFEQ      'USR8100'
     C                   LEAVE
     C                   Endif
     C                   Endif
      *
     C                   Enddo
      *
     C                   Enddo
      *
     C                   Endif
      *
     C                   EVAL      IsCmdErr = R#IsCmdErr
     C                   EVAL      IsREADSFL = bFalse
      *
     C     IsReadC       IFEQ      bTrue
     C                   EXSR      GetObjAttr
     C                   EXSR      GetMbrAttr
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSflChain    CHAIN auf PBSFL                           *
      *============================================================*
      *
     C     PBSflChain    BEGSR
      *
     C  N88SflRec132     CHAIN     PBSFL132                           11
     C   88SflRec080     CHAIN     PBSFL080                           11
      *
     C     *IN11         IFEQ      '0'
      *  ... alles in Ordnung
     C                   ELSE
      *  ... letzte Nachricht löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSflWrite    WRITE auf PBSFL                           *
      *============================================================*
      *
     C     PBSflWrite    BEGSR
      *
     C  N88              WRITE     PBSFL132
     C   88              WRITE     PBSFL080
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSflUpdat    UPDATE auf PBSFL                          *
      *============================================================*
      *
     C     PBSflUpdat    BEGSR
      *
     C  N88              UPDATE    PBSFL132
     C   88              UPDATE    PBSFL080
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_PageUp      PgUp - Vorwärts blättern                  *
      *============================================================*
      *
     C     C_PageUp      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
      *  Verarbeiten der Subfile-Auswahlen
     C     IsREADSFL     IFEQ      bTrue
      *       verhindern einer Rekursion
     C                   ELSE
     C                   EXSR      C_ReadSfl
     C                   Endif
      *
      *  Blättern
     C                   EXSR      PBInit
     C                   EXSR      PBPinRcd
     C                   EXSR      PBReadUP
      *
      *  Keine weiteren Einträge gefunden ...
     C     *IN80         IFEQ      '0'
      *  ... Ende der Liste anzeigen
     C                   EXSR      C_Bot
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_PageDown    PgDn - Rückwärts blättern                 *
      *============================================================*
      *
     C     C_PageDown    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
      *  Verarbeiten der Subfile-Auswahlen
     C     IsREADSFL     IFEQ      bTrue
      *       verhindern einer Rekursion
     C                   ELSE
     C                   EXSR      C_ReadSfl
     C                   Endif
      *
      *  Blättern
     C                   EVAL      SflCsr = NbrPinRcd + 1
     C                   EXSR      PBReadCsr
     C                   EXSR      PBReadDn
      *
     C                   EXSR      PBInit
     C                   EXSR      PBPinRcd
     C                   EXSR      PBReadUp
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_EndPgm      F3/F12 - Programm beenden                 *
      *============================================================*
      *
     C     C_EndPgm      BEGSR
      *
      * - Speichern der Arbeitsumgebung
     C     i_envSave     IFEQ      bTrue
     C                   EVAL      YIsAutoSave = bTrue
     C                   EXSR      SaveEnv
     C                   ENDIF
      *
     C                   EXSR      CloseFile
     C     IsOpen        IFEQ      bFalse
      *
      * - Benutzervoreinstellungen
     C                   EXSR      SetUsrSetg
      *
      * - Endenachricht
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *
     C                   EVAL      §MsgID = 'USR8100'
     C                   EVAL      USR81001 = YPgmCmd
     C                   Eval      exitMsg = f_msgText('USR8100': USR8100)
      *
     C                   Clear                   USR9999
     C                   Eval      §MsgID = 'USR9999'
     C                   Eval      USR99991 = exitMsg
     C                   Eval      USR99992 = ''
     C                   Eval      §MsgDta = USR9999
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Callp     p_movPgmMg(§§pgmName)
      *
     C                   ELSE
      *  Fehlermeldung ...
     C                   EVAL      §MsgID = 'USR8103'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Prompt      F4  - Prompt                              *
      *============================================================*
      *
     C     C_Prompt      BEGSR
      *
     C                   If        isOpen = bFalse
      *
     C                   Select
     C                   When      ((ScnFld   = '##FILE'  ) or
     C                              (##File   = SET_PRMT  ) or
     C                              (f_endsWith('*': %trim(##File))))
     C                   Exsr      Pmt_File
     C                   When      ((ScnFld   = '##MEMBER') or
     C                              (##Member = SET_PRMT  ))
     C                   Exsr      Pmt_Mbr
     C                   Other
      *      Nix tun, keine Datei vorhanden
     C                   Exsr      MsgNoFile
     C                   Endsl
      *
     C                   Else
      *
     C                   Select
     C                   When      ((ScnFld   = '##FIELD ') or
     C                              (##Field  = SET_PRMT  ))
     C                   Exsr      Pmt_Field
     C                   When      ((ScnFld   = '##FILE'  ) or
     C                              (##File   = SET_PRMT  ) or
     C                              (f_endsWith('*': %trim(##File))))
     C                   Exsr      Pmt_File
     C                   When      ((ScnFld   = '##MEMBER') or
     C                              (##Member = SET_PRMT  ))
     C                   Exsr      Pmt_Mbr
     C                   When      ((ScnFld   = '##FORMAT') or
     C                              (##Format = SET_PRMT  ))
     C                   Exsr      Pmt_Fmt
     C                   When      ((ScnFld   = 'SFPAU'   ) or
     C                              (SFPAU    = SET_PRMT  ))
     C                   Exsr      Pmt_Sfpau
     C                   Other
     C                   EVAL      §MsgID = 'USR8179'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Endsl
      *
     C                   Endif
      *
     C                   Exsr      KeepCsrPos
      *
     C                   ENDSR
      *
      *============================================================*
      *    Pmt_Field     Prompt - Field                            *
      *============================================================*
      *
     C     Pmt_Field     BEGSR
      *
     C                   CALLP     PEEK37(SET_Dsp80: §CopyRight: YField
     C                                    : YMsgID: YMsgDta)
      *
     C     yMsgID        IFEQ      *BLANKS
     C                   EVAL      ##Field = yField
     C                   EVAL      *IN93 = '1'
     C                   ELSE
     C                   EVAL      §MsgID = yMsgID
     C                   EVAL      §MsgDta = yMsgDta
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Pmt_File      Prompt - File                             *
      *============================================================*
      *
     C     Pmt_File      BEGSR
      *
      *  Wenn das Feld gesperrt ist, ...
     C     *IN75         IFEQ      *ON
      *  ... dann
      *      ausgeben Meldung
     C                   EVAL      §MsgID = 'USR8179'
     C                   EVAL      §MsgDta = *BLANKS
     C                   ELSE
      *  ... sonst
      *      aufrufen "Auswahl Datei"
     C                   EVAL      YDsp80 = SET_Dsp80
     C                   EVAL      YCopyRight = §CopyRight
     C                   EVAL      YFile = *BLANKS
      *
     C     ##File        IFEQ      *BLANKS
     C     ##File        OREQ      SET_PRMT
     C                   EVAL      yFile = '*ALL'
     C                   ELSE
     C                   EVAL      yFile = ##File
     C                   Endif
      *
     C     ##Library     IFEQ      *BLANKS
     C                   EVAL      yLibrary = '*LIBL'
     C                   ELSE
     C                   EVAL      yLibrary = ##Library
     C                   Endif
      *
     C                   CALL      PEEK69        P_Peek69
      *
     C     yMsgID        IFEQ      *BLANKS
     C                   EVAL      ##File = yFile
     C                   EVAL      ##Library = yLibrary
     C                   EVAL      *IN93 = '1'
     C                   ELSE
     C                   EVAL      §MsgID = yMsgID
     C                   EVAL      §MsgDta = yMsgDta
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Pmt_Mbr       Prompt - Member                           *
      *============================================================*
      *
     C     Pmt_Mbr       BEGSR
      *
      *  Wenn das Feld gesperrt ist, ...
     C     *IN77         IFEQ      *ON
      *  ... dann
      *      ausgeben Meldung
     C                   EVAL      §MsgID = 'USR8179'
     C                   EVAL      §MsgDta = *BLANKS
     C                   ELSE
      *  ... sonst
      *      aufrufen "Auswahl Teildatei"
     C                   EVAL      YFile = ##File
      *
     C     ##Library     IFEQ      *BLANKS
     C                   EVAL      yLibrary = '*LIBL'
     C                   ELSE
     C                   EVAL      yLibrary = ##Library
     C                   Endif
      *
     C                   CALLP     PEEK47(SET_Dsp80: §CopyRight
     C                                    : YQFile: YMember: YMsgID: YMsgDta)
      *
     C     yMsgID        IFEQ      *BLANKS
     C                   EVAL      ##Member = yMember
     C                   EVAL      *IN93 = '1'
     C                   ELSE
     C                   EVAL      §MsgID = yMsgID
     C                   EVAL      §MsgDta = yMsgDta
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    Pmt_Fmt       Prompt - Format                           *
      *============================================================*
      *
     C     Pmt_Fmt       Begsr
      *
     C                   CALLP     PEEK12(SET_Dsp80: §CopyRight: ##FORMAT
     C                                    : §INTER
     C                                    : RCDL0200: YFmtNbr: yMsgID: yMsgDta)
      *
     C     yMsgID        IFEQ      *BLANKS
     C                   EVAL      ##FMTNBR = YFmtNbr
     C                   EVAL      ##Format = RCDL0200.R2FmtName
     C                   EVAL      $$Length = RCDL0200.R2RcdLen
     C                   EVAL      *IN93 = '1'
     C                   ELSE
     C                   EVAL      §MsgID = yMsgID
     C                   EVAL      §MsgDta = yMsgDta
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    Pmt_Sfpau     Prompt - Subfileauswahl                   *
      *============================================================*
      *
     C     Pmt_Sfpau     Begsr
      *
     C                   Callp     PEEK68(SET_Dsp80: §§pgmName: §CopyRight
     C                                    : ySflOpt: yMsgID: yMsgDta)
      *
      *  Einlesen Subfiledatensatz
     C                   EVAL      SflRec132 = SflCsr
     C                   EVAL      SflRec080 = SflCsr
     C                   Exsr      PBSflChain
      *
      *  Abbruch mit F3/F12
     C                   If        (YMsgID = 'USR8100')
     C                   Eval      SFPAU = ''
     C                   EVAL      *IN84 = '1'                                  SFLNXTCHG
     C                   EVAL      *IN85 = '0'                                  SFPAU(RI)
     C                   Else
     C                   Eval      SFPAU = ySflOpt
     C                   EVAL      *IN84 = '1'                                  SFLNXTCHG
     C                   EVAL      *IN85 = '0'                                  SFPAU(RI)
     C                   Endif
      *
      *  Aktualisieren Subfiledatensatz
     C                   Exsr      PBSflUpdat
      *
     C                   If        (YMsgID = 'USR8100')
     C                   Eval      §msgID  = yMsgID
     C                   Eval      §msgDta = yMsgDta
     C                   Else
     C  N88              WRITE     PBCTL132
     C   88              WRITE     PBCTL080
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    C_Refresh     F5  - Aktualisieren der Subfile           *
      *============================================================*
      *
     C     C_Refresh     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
      *      ... aktualisieren "offene Datei"
     C                   EXSR      getOpnFile
      *
      *      ... aktualisieren Subfile
     C                   EXSR      PBRefresh
      *
      *      ... abrufen der Objektattribute
     C                   EXSR      GetObjAttr
      *
      *      ... abrufen der Anzahl Teildateien
     C                   EXSR      GetNbrMbr
      *
      *      ... abrufen Objektattribute
     C                   EXSR      GetObjAttr
      *
      *      ... abrufen der Teildateiattribute
     C                   EXSR      GetMbrAttr
     C                   Endif
      *
      *      ... positionieren Cursor
     C     SflCsr        IFEQ      §ZEROS
     C                   EXSR      C_PosCsr
     C                   ENDIF
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Add         F6  - Neuanlage eines Datensatz           *
      *============================================================*
      *
     C     C_Add         BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C     IsUpdMod      IFEQ      bFalse
      *      Neuanlage nicht möglich, da INPUT-Modus
     C                   EVAL      §MsgID = 'USR0007'
     C                   EVAL      USR00071 = ##FILE
     C                   EVAL      USR00072 = ##LIBRARY
     C                   EVAL      §MsgDta = USR0007
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *
     C                   EVAL      YFunction = '*ADD'
     C                   EXSR      CallUpdPgm
      *
      *  Ermitteln Objektattribute
     C                   EXSR      GetObjAttr
      *
      *  Ermitteln der Teildateiattribute (Anzahl Sätze)
     C                   EXSR      GetMbrAttr
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_ChgHead     F7  - Umschalten der Überschrift          *
      *============================================================*
      *
     C     C_ChgHead     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EVAL      SET_HedTyp = f_nextHeaderType(SET_HedTyp)
      *
     C                   EVAL      IsSflDirty = bTrue
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_TgMrkCol    F8  - Spalte markieren ein/aus            *
      *============================================================*
      *
     C     C_TgMrkCol    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetFldTMrk
      *
     C     Wrk#Field     IFEQ      *BLANKS
      *  Fehler aufgetreten ...
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *
     C                   EVAL      IsSflDirty = bTrue
      *
      *  Umschalten der Farbe im Datensatz ...
     C                   EVAL      F_Field = Col_Field(X)
     C     F_KEY         CHAIN (N) FPEEKFLD                           11
     C     *IN11         IFEQ      '0'
      *
     C     F_MarkCol     IFEQ      bFalse
     C                   EXSR      C_MrkCol
     C                   ELSE
     C                   EXSR      C_UnMrkCol
     C                   Endif
      *
     C                   ELSE
      *        Datensatz nicht gefunden
     C                   Endif
     C                   Endif
      *
      *  Beibehalten der Cursorposition ...
     C                   EXSR      KeepCsrPos
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_MrkCol      F8  - Spalte markieren ein                *
      *============================================================*
      *
     C     C_MrkCol      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetFldTMrk
      *
     C     Wrk#Field     IFEQ      *BLANKS
      *  Fehler aufgetreten ...
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *
     C                   EVAL      IsSflDirty = bTrue
      *
      *  Einschalten der Farbe im Datensatz ...
     C                   EVAL      F_Field = Col_Field(X)
     C     F_KEY         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '0'
     C                   EVAL      F_MarkCol = bTrue
     C                   UPDATE    FPEEKFLD
     C                   ELSE
      *        Datensatz nicht gefunden
     C                   Endif
     C                   Endif
      *
      *  Beibehalten der Cursorposition ...
     C                   EXSR      KeepCsrPos
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_UnMrkCol    F8  - Spalte markieren aus                *
      *============================================================*
      *
     C     C_UnMrkCol    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetFldTMrk
      *
     C     Wrk#Field     IFEQ      *BLANKS
      *  Fehler aufgetreten ...
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *
     C                   EVAL      IsSflDirty = bTrue
      *
      *  Ausschalten der Farbe im Datensatz ...
     C                   EVAL      F_Field = Col_Field(X)
     C     F_KEY         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '0'
     C                   EVAL      F_MarkCol = bFalse
     C                   UPDATE    FPEEKFLD
     C                   ELSE
      *        Datensatz nicht gefunden
     C                   Endif
     C                   Endif
      *
      *  Beibehalten der Cursorposition ...
     C                   EXSR      KeepCsrPos
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_MoveTop     F9  - Selektieren Datensatz               *
      *============================================================*
      *
     C     C_MoveTop     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetSflRcd
      *
     C     SflCsr        IFGT      §ZEROS
      *
     C                   EXSR      PBReadCsr
     C                   EXSR      PBInit
     C                   EXSR      PBPinRcd
     C                   EXSR      PBReadUp
     C                   EVAL      SFSANR = NbrPinRcd + 1
      *
     C                   ELSE
      *  Fehlermeldung ...
     C                   EVAL      §MsgID = 'USR8102'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_PosCsr      F10    - Cursor auf Keyeingabe pos.       *
      *============================================================*
      *
     C     C_PosCsr      BEGSR
      *
     C                   EVAL      *IN87 = '1'
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_UserSetg    F11    - Benutzervoreinstellugnen         *
      *============================================================*
      *
     C     C_UserSetg    BEGSR
      *
     C                   monitor
     C                   callp     PEEK24(SET_Dsp80: §CopyRight: SET0001
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C     *IN99         IFEQ      '1'
      *            Fehler aufgetreten
     C                   ELSE
     C     YMsgID        IFEQ      'USR8112'
     C                   Callp     p_updUsrSg('*DSPATTR' : SET0001)
     C                   EXSR      C_Refresh
     C                   ELSE
      *            Verrabeitung durch Benutzer
      *            abgebrochen
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Repeat      F13 - Wiederholen der Subfileauswahl      *
      *============================================================*
      *
     C     C_Repeat      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
      *  "Keine Sätze ..."
     C     SflNbrRcd     IFEQ      §ZEROS
      *  Keine Datensätze vorhanden.
     C                   ELSE
      *
      *  Ermitteln der letzten Subfile-Auswahl ...
     C                   EXSR      GetLastOpt
     C     IsError       IFEQ      bTrue
      *  Fehlermeldung ...
     C                   EVAL      §MsgID = 'USR8165'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *
      *  "Reaktivieren" der letzten Subfileauswahl ...
     C                   EVAL      SflRec132 = Wrk#Recno
     C                   EVAL      SflRec080 = Wrk#Recno
    WC                   EXSR      PBSflChain
     C                   EVAL      *IN84 = '1'
    WC                   EXSR      PBSflUpdat
      *  Verarbeitung ...
     C                   EVAL      Wrk#Recno = Wrk#Recno + 1
     C                   EXSR      RepeatOpt
     C                   Endif
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Layout      F15    - Layout                           *
      *============================================================*
      *
     C     C_Layout      BEGSR
      *
     C                   monitor
     C                   callp     PEEK34(SET_Dsp80: §CopyRight: '*DISPLAY'
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C     YMsgID        IFEQ      'USR8112'
      *  Beenden und Speichern ...
      *  Merker für aktualisieren der Subfile
     C                   EVAL      IsSflDirty = bTrue
     C                   ELSE
      *  Abbruch durch Benutzer ...
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Search      F16    - Suchfunktion                     *
      *============================================================*
      *
     C     C_Search      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   SELECT
     C     SrchMode      WHENEQ    '*NEW'
     C                   Monitor
     C                   CALLP     PEEK17(SET_Dsp80: §CopyRight
     C                                    : YQFile: ##Member
     C                                    : YField: YOperation: YArgument
     C                                    : YSign: YSrchNbrs: YSrchType
     C                                    : YSrchCase: YMsgID: YMsgDta)
     C                   Eval      *in99 = bFalse
     C                   On-Error
     C                   Eval      *in99 = bTrue
     C                   Endmon
      *
     C     *IN99         IFEQ      '0'
     C     YMsgID        IFEQ      'USR8112'
     C                   EXSR      SrchStart
     C                   ELSE
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
     C                   ELSE
      *  Fehler beim Aufruf von PEEK17 ...
     C                   Endif
      *
     C     SrchMode      WHENEQ    '*FOUND'
     C                   EXSR      SrchCont
      *
     C     SrchMode      WHENEQ    '*MAXIMUM'
     C                   EXSR      SrchContM
      *
     C     SrchMode      WHENEQ    '*EOF'
     C                   EXSR      SrchEOF
      *
     C                   OTHER
      *               ???????????
     C                   Endsl
      *
      *  Gefunden?
     C     SrchMode      IFEQ      '*FOUND'
     C                   EVAL      SrchFndRcd = File#X.RcdNbr
     C                   EXSR      PBReadP
     C                   ELSE
     C                   EXSR      PBReadDn
     C                   Endif
      *
      *  Anzeigen der Subfile
     C                   EXSR      PBInit
     C                   EXSR      PBPinRcd
     C                   EXSR      PBReadUp
      *
      *  Meldung
     C                   SELECT
     C     SrchMode      WHENEQ    '*FOUND'
     C                   EVAL      §MsgID = 'USR8130'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C     SrchMode      WHENEQ    '*EOF'
     C                   EVAL      §MsgID = 'USR8131'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C     SrchMode      WHENEQ    '*MAXIMUM'
     C                   EVAL      §MsgID = 'USR8132'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   OTHER
     C                   Endsl
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Top         F17 - Anfang der Datei                    *
      *============================================================*
      *
     C     C_Top         BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      PBMoveTop
     C                   EXSR      PBInit
     C                   EXSR      PBPinRcd
     C                   EXSR      PBReadUp
      *
     C                   EVAL      SFSANR = NbrPinRcd + 1
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Bot         F18 - Ende der Datei                      *
      *============================================================*
      *
     C     C_Bot         BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      PBMoveBot
     C                   EXSR      PBInit
     C                   EXSR      PBPinRcd
     C                   EXSR      PBReadDn
     C                   EXSR      PBReadUp
      *
     C                   EVAL      SFSANR = SflNbrRcd
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_MoveL       F19 - Nach links verschieben              *
      *============================================================*
      *
     C     C_MoveL       BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C     ##StrPage     IFGT      1
     C     SET_SCROLL    IFEQ      '*BOTH'
     C     SET_SCROLL    OREQ      '*LEFT'
     C                   EVAL      ##StrPage = ##StrPage - 1
     C                   ELSE
     C                   EVAL      ##StrPage = 1
     C                   EVAL      ##WndNbr = ##WndNbr - 1
     C                   Endif
     C                   ELSE
     C                   EVAL      ##WndNbr = ##WndNbr - 1
     C     SET_SCROLL    IFEQ      '*BOTH'
     C     SET_SCROLL    OREQ      '*LEFT'
     C                   EVAL      ##StrPage = *HIVAL
     C                   ELSE
     C                   EVAL      ##StrPage = 1
     C                   Endif
     C                   Endif
      *
     C                   EXSR      ChkSeqRnge
      *
     C                   EXSR      PBRefresh
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_MoveR       F20 - Nach rechts verschieben             *
      *============================================================*
      *
     C     C_MoveR       BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   IF        (CP = 1) and
     C                             (Col_Error(CP) = bTrue)
     C                   IF        ((SET_SCROLL = '*BOTH') or
     C                              (SET_SCROLL = '*RIGHT'))
     C                   EVAL      ##StrPage = ##StrPage + 1
     C                   ELSE
     C                   EVAL      ##WndNbr = ##WndNbr + 1
     C                   EVAL      ##StrPage = 1
     C                   Endif
     C                   ELSE
     C                   EVAL      ##WndNbr = ##WndNbr + 1
     C                   EVAL      ##StrPage = 1
     C                   Endif
      *
     C                   EXSR      ChkSeqRnge
     C                   EXSR      PBRefresh
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_PageL       F19 - Nach links verschieben,             *
      *                  ganze Seite                               *
      *============================================================*
      *
     C     C_PageL       BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   LEAVESR
     C                   ENDIF
      *
      *  Prüfen "Seite innerhalb des Feldes"
     C     ##StrPage     IFGT      1
     C                   EVAL      ##StrPage = ##StrPage - 1
     C                   ELSE
      *
      *  Bereits am Anfang
     C     ##WndNbr      IFEQ      L#MinSeq
     C     ##StrPage     ANDEQ     1
     C                   ELSE
      *
      *  Ermitteln der Feldnummer des 1. angezeigten
      *  Feldes ...
     C                   EVAL      X = NbrPinCol + 1
     C                   EVAL      Wrk#Field = Col_Field(X)
     C                   EXSR      GetSeqNbr
     C     IsSeqNbrOK    IFEQ      bFalse
     C     L#MinSeq      ANDGT     *ZEROS
     C                   EVAL      Wrk#SeqNbr = L#MinSeq
     C                   EVAL      IsSeqNbrOK = bTrue
     C                   ENDIF
      *
     C     IsSeqNbrOK    IFEQ      bTrue
     C                   Exsr      GetPrvSeq
     C                   EVAL      ##WndNbr = Wrk#SeqNbr
     C     SET_SCROLL    IFEQ      '*BOTH'
     C     SET_SCROLL    OREQ      '*LEFT'
     C                   EVAL      ##StrPage = *HIVAL
     C                   ELSE
     C                   EVAL      ##StrPage = 1
     C                   Endif
     C                   ELSE
     C                   EVAL      ##WndNbr = L#MinSeq
     C                   EVAL      ##StrPage = 1
     C                   Endif
      *
      *  Füllen einer Dummy-Zeile von rechts nach
      *  links zur Ermittlung des 1. anzuzeigenden
      *  Feldes ...
     C     ##WndNbr      IFGT      L#MinSeq
     C                   EXSR      PBFillLeft
      *  ... kein Feld gefunden
     C     CP            IFLE      §ZEROS
     C                   EVAL      ##WndNbr = L#MinSeq
     C                   EVAL      ##StrPage = 1
     C                   ELSE
      *  ... Felder gefunden
     C     CP            IFEQ      1
      *      ... aber nur 1 Feld
     C                   EVAL      Wrk#Field = Col_Field(CP)
     C                   ELSE
      *      ... mehrere Felder
     C     Col_Error(CP) IFEQ      bFalse
      *          ... komplett sichtbar
     C                   EVAL      Wrk#Field = Col_Field(CP)
     C                   ELSE
      *          ... nicht komplett sichtbar,
      *              nächstes Feld als Startfeld nehmen
     C                   EVAL      X = CP - 1
     C                   EVAL      Wrk#Field = Col_Field(X)
     C                   EVAL      ##StrPage = 1
     C                   Endif
      *      ... umrechnen in Feldnummer
     C                   EXSR      GetSeqNbr
     C     IsSeqNbrOK    IFEQ      bTrue
     C                   EVAL      ##WndNbr = Wrk#SeqNbr
     C                   ELSE
     C                   EVAL      ##WndNbr = *LOVAL
     C                   EVAL      ##StrPage = 1
     C                   Endif
     C                   Endif
     C                   Endif
     C                   Endif
     C                   Endif
     C                   Endif
      *
     C                   EXSR      ChkSeqRnge
     C                   EXSR      PBRefresh
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_PageR       F20 - Nach rechts verschieben,            *
      *                  ganze Seite                               *
      *============================================================*
      *
     C     C_PageR       BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EVAL      Wrk#Field = Col_Field(CP)
     C                   EXSR      GetSeqNbr
     C     IsSeqNbrOK    IFEQ      bTrue
      *
     C     Col_Error(CP) IFEQ      bTrue
     C                   IF        CP - NbrPinCol = 1
      *
     C     SET_SCROLL    IFEQ      '*BOTH'
     C     SET_SCROLL    OREQ      '*RIGHT'
     C                   EVAL      ##WndNbr = Wrk#SeqNbr
     C                   EVAL      ##StrPage = ##StrPage + 1
     C                   ELSE
     C                   EVAL      ##WndNbr = Wrk#SeqNbr + 1
     C                   EVAL      ##StrPage = 1
     C                   Endif
      *
     C                   ELSE
     C                   EVAL      ##WndNbr = Wrk#SeqNbr
     C                   EVAL      ##StrPage = 1
     C                   Endif
     C                   ELSE
     C                   EVAL      ##WndNbr = Wrk#SeqNbr + 1
     C                   EVAL      ##StrPage = 1
     C                   Endif
      *
     C                   ELSE
     C                   EVAL      ##WndNbr = *HIVAL
     C                   EVAL      ##StrPage = 1
     C                   Endif
      *
     C                   EXSR      ChkSeqRnge
     C                   EXSR      PBRefresh
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_CmdLine     F21 - Befehlszeile                        *
      *============================================================*
      *
     C     C_CmdLine     BEGSR
      *
     C                   IF        f_cmdLine = bTrue
     C                   CALL      'QUSCMDLN'                           99
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_ChgScn      F22 - Umschalten der Bildschirmauflösung  *
      *============================================================*
      *
     C     C_ChgScn      BEGSR
      *
     C                   EVAL      Wrk#ReadDn = SflPage
     C                   EXSR      ChgScreen
     C                   EVAL      Wrk#ReadDn = Wrk#ReadDn - SflPage
      *
     C                   EXSR      PBRefresh
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_MoreOpt     F23 - Weitere Auswahlen                   *
      *============================================================*
      *
     C     C_MoreOpt     BEGSR
      *
     C                   EVAL      SFTop = SFTop + 1
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_MoreKeys    F24 - Weitere Tasten                      *
      *============================================================*
      *
     C     C_MoreKeys    BEGSR
      *
     C                   EVAL      SFBOT = SFBOT + 1
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_NextMark    Fxx - Nächste Markierung ansteueren       *
      *============================================================*
      *
     C     C_NextMark    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetFrstFld
      *
     C                   EVAL      Wrk#SeqNbr = ##WndNbr
     C                   EXSR      GetNxtMark
     C     Wrk#SeqNbr    IFGT      *ZEROS
     C                   EVAL      ##WndNbr = Wrk#SeqNbr
     C                   EVAL      ##StrPage = 1
     C                   ELSE
     C                   EVAL      Wrk#SeqNbr = *LOVAL
     C                   EXSR      GetNxtMark
     C     Wrk#SeqNbr    IFGT      *ZEROS
     C                   EVAL      ##WndNbr = Wrk#SeqNbr
     C                   EVAL      ##StrPage = 1
     C                   ELSE
      *    ... keine Markierung gefunden
     C                   Endif
     C                   Endif
      *
     C                   EXSR      ChkSeqRnge
      *
     C                   EXSR      PBRefresh
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_PrevMark    Fxx - Vorherige Markierung ansteueren     *
      *============================================================*
      *
     C     C_PrevMark    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetFrstFld
      *
     C                   EVAL      Wrk#SeqNbr = ##WndNbr
     C                   EXSR      GetPrvMark
     C     Wrk#SeqNbr    IFGT      *ZEROS
     C                   EVAL      ##WndNbr = Wrk#SeqNbr
     C                   EVAL      ##StrPage = 1
     C                   ELSE
     C                   EVAL      Wrk#SeqNbr = *HIVAL
     C                   EXSR      GetPrvMark
     C     Wrk#SeqNbr    IFGT      *ZEROS
     C                   EVAL      ##WndNbr = Wrk#SeqNbr
     C                   EVAL      ##StrPage = 1
     C                   ELSE
      *    ... keine Markierung gefunden
     C                   Endif
     C                   Endif
      *
     C                   EXSR      ChkSeqRnge
      *
     C                   EXSR      PBRefresh
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_BuildPgm    Erstellen Update Programm                 *
      *============================================================*
      *
     C     C_BuildPgm    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   CALLP     PEEK52(SET_Dsp80: §CopyRight
     C                                    : YAlwLc: YCase: YRcdLock: YNullDft
     C                                    : YKeepCrs: YMsgID: YMsgDta: bFalse)
      *
     C     yMsgID        IFEQ      'USR8112'
      *
     C                   Monitor
      *  Rekursiver CALL auf sich selbst (= PEEK05),
      *  um die alte Referenz auf das Update-Programm zu löschen
     C                   Eval      PgmToCall = f_pgmCallN(§§pgmName)
     C                   CALL      PgmToCall     P_PeekPgm              99
     C                   EVAL      *IN99 = '0'
      *
      *  Initialisierung
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EXSR      GetPgmName
      *
      *  Generierung
     C                   CALLP     PEEK08(YQFile: PeekPgm: RCDL0200.R2FmtName
     C                                    : RCDL0200.R2FmtID
     C                                    : YAlwLc: YCase: YRcdLock: YNullDft
     C                                    : YKeepCrs: §§PgmLib: YRtnCode)
      *
     C                   Eval      *in99 = bFalse
     C                   On-Error
     C                   Eval      *in99 = bTrue
     C                   Endmon
     C                   Endif
      *
     C                   CALLP     PEEK52(SET_Dsp80: §CopyRight
     C                                    : YAlwLc: YCase: YRcdLock: YNullDft
     C                                    : YKeepCrs: YMsgID: YMsgDta: bTrue)
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Register    Prüfen der Registrierungsdaten            *
      *============================================================*
      *
     C     C_Register    BEGSR
      *
     C                   monitor
     C                   callp     PEEK30(SET_Dsp80: YCopyRight
     C                                    : YFlag: YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C     *IN99         IFEQ      '1'
      *  Fehler beim Programmaufruf ...
     C                   Callp     p_movPgmMg(§§pgmName)
     C                   GOTO      ENDE
     C                   ELSE
     C     YFlag         IFNE      -55
     C     YFlag         ANDNE     66
     C     YFlag         ANDNE     243
      *  Fehler im Wertebereich ...
     C                   GOTO      ENDE
     C                   ELSE
      *  Datum ist abgelaufen ...
     C     YFlag         IFEQ      -55
     C                   GOTO      ENDE
     C                   ELSE
      *  Registrierung ist OK ...
     C                   Endif
     C                   Endif
     C                   Endif
      *
      *  "Nachschießen" SPLASH-Screen
     C     YFlag         IFEQ      243
     C     SET_SPLA      ANDEQ     bFalse
     C                   EXSR      S_SplashOn
     C                   EXSR      ShowSplash
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_ClrPinRw    Löschen der Pin-Tabelle für Zeilen        *
      *============================================================*
      *
     C     C_ClrPinRw    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      ClrPinRow
      *
      *  Merker für aktualisieren der Subfile
     C                   EVAL      IsSflDirty = bTrue
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_ClrPinCl    Löschen der Pin-Tabelle für Spalten       *
      *============================================================*
      *
     C     C_ClrPinCl    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      ClrPinCol
      *
      *  Merker für aktualisieren der Subfile
     C                   EVAL      IsSflDirty = bTrue
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_DspDbr      Anzeigen der Datenbankrelationen          *
      *============================================================*
      *
     C     C_DspDbr      Begsr
      *
     C                   If        isOpen = bFalse
      *      Nix tun, keine Datei vorhanden
     C                   Exsr      MsgNoFile
     C                   Else
      *
     C                   monitor
     C                   callp     PEEK40(SET_Dsp80: §CopyRight
     C                                    : ##File: ##Library: ##Member
     C                                    : ##Format: bTrue
     C                                    : YRetFile: YRetLib
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bTrue
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C                   If        (yRetFile = ' ')  or
     C                             (*in99    = *on)
      *  ... keine Auswahl getroffen
     C                   Else
      *  ... prüfen auf neue Dateiauswahl
     C                   Eval      ##file    = yRetFile
     C                   Eval      ##Library = yRetLib
      *
     C                   Eval      NewAccMode = i_access
     C                   Exsr      ChangeFile
      *
     C                   If        IsFileChg = bTrue
     C                   Exsr      C_Top
     C                   Else
     C                   Endif
     C                   Endif
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    C_SortBKey    Anzeigen der Sätze in Schlüsselfolge      *
      *============================================================*
      *
     C     C_SortBKey    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
     C     AccessMode    IFEQ      §KeySeq
      *    ... Sortierung stimmt bereits
     C                   ELSE
      *
      *  Umschalten der Sortierung
     C                   Eval      NewAccMode = §KeySeq
     C                   EXSR      ChangeSort
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_SortBRrn    Anzeigen der Sätze in Satzfolge           *
      *============================================================*
      *
     C     C_SortBRrn    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
     C     AccessMode    IFEQ      §RrnSeq
      *    ... Sortierung stimmt bereits
     C                   ELSE
      *
     C                   IF        f_numBased(##File    :
     C                                        ##Library :
     C                                        ##Member  ) = 1
     C                   Eval      NewAccMode = §RrnSeq
     C                   EXSR      ChangeSort
     C                   ELSE
     C                   CLEAR                   USR8217
     C                   EVAL      §MsgID = 'USR8217'
     C                   EVAL      §MsgDta = USR8217
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ENDIF
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_SortTgl     Umschalten der Sortierfolge               *
      *============================================================*
      *
     C     C_SortTgl     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
     C     AccessMode    IFEQ      §RrnSeq
     C                   Exsr      C_SortBKey
     C                   ELSE
     C                   Exsr      C_SortBRrn
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_TglKeyLC_UC Umschalten Eingabe der Schlüsselfelder    *
      *============================================================*
      *
     C     S_TglKeyLC_UC BEGSR
      *
     C                   If        isKeyLower = bFalse
     C                   Eval      isKeyLower = bTrue
     C                   Clear                   USR8223
     C                   EVAL      §MsgID = 'USR8223'
     C                   EVAL      §MsgDta = USR8223
     C                   Else
     C                   Eval      isKeyLower = bFalse
     C                   Clear                   USR8224
     C                   EVAL      §MsgID = 'USR8224'
     C                   EVAL      §MsgDta = USR8224
     C                   Endif
      *
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_PinCDlg     Pin-Dialog                                *
      *============================================================*
      *
     C     C_PinCDlg     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   monitor
     C                   callp     PEEK50(SET_Dsp80: §CopyRight: PinTabC
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C     *IN99         IFEQ      '0'
     C     YMsgID        IFEQ      'USR8112'
      *
     C                   EXSR      ClrPinCol
      *
     C     1             Do        MaxPinCol     Y
     C                   If        PinTabC(Y) <> ' '
     C                   EVAL      Wrk#Field = PinTabC(Y)
     C                   EXSR      PinCol
     C                   Endif
     C                   Enddo
      *
     C                   Endif
     C                   Endif
      *
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    C_Sql         SQL-Auswahl                               *
      *============================================================*
      *
     C     C_Sql         Begsr
      *
     C                   If        isOpen = bFalse
      *      Nix tun, keine Datei vorhanden
     C                   Exsr      MsgNoFile
     C                   Leavesr
     C                   Endif
      *
     C                   If        FILD0100.ATFILA <> '*PHY'
      *
     C                   Select
     C                   When      FILD0100.ATNOFM = 1
      *  Wenn es sich um eine "single-format logical file" handelt, ...
      *  ... dann prüfen, ob diese Datei über mehere Member geht.
      *      Sortierung nach SQL wird für "multi-member logical files"
      *      (noch) nicht unterstützt ...
     C                   If        FILD0100.ATJOIN = 'N' and
     C                             f_numBased(##File: ##Library: ##Member) > 1
     C
     C                   Eval      §MsgID = 'USR8235'
     C                   Clear                   USR8235
     C                   Eval      §MsgDta = USR8235
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Leavesr
     C                   Endif
      *
     C                   When      FILD0100.ATNOFM > 1
      *  Wenn es sich um eine "multi-format logical file" handelt, ...
      *  ... dann fragen, welches physiche Datei göffnet werden soll:
     C                   CALLP     PEEK59(SET_Dsp80: '*QUESTION'
     C                                    : 'USR8212': '': 'YN'
     C                                    : yMsgID: yMsgDta)
     C                   Eval      USR8190 = yMsgDta
     C                   If        USR81901 = '*YES'
     C                   Callp     f_basedPF(##FILE     :
     C                                       ##LIBRARY  :
     C                                       ##MEMBER   :
     C                                       ##FORMAT   :
     C                                       ##FMTNBR   :
     C                                       ##FILE     :
     C                                       ##LIBRARY  :
     C                                       ##MEMBER   :
     C                                       ##FORMAT   )
     C                   Else
     C                   Leavesr
     C                   Endif
      *
     C                   Endsl
      *
     C                   Endif
      *
      * Let the user enter the SQL WHERE and ORDER BY clauses:
     C                   monitor
     C                   callp     PEEK48(SET_Dsp80: §CopyRight
     C                                    : ##File: ##LIBRARY: ##MEMBER
     C                                    : ##FORMAT
     C                                    : AccessMode: sqlWhere: sqlOrder
     C                                    : auth.chgSqlW: auth.chgSqlO
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bTrue
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C                   If        *in99 <> *off
     C                   Leavesr
     C                   Endif
      *
     C                   If        yMsgID <> 'USR8112'
     C                   Leavesr
     C                   Endif
      *
     C                   Eval      isPinToClr = bFalse
      *
     C                   Exsr      closeFile
      *
     C                   Eval      ##FILE = yFile
     C                   Eval      ##LIBRARY = yLibrary
     C                   Eval      ##MEMBER = yMember
     C                   Eval      ##FORMAT = yFormat
      *
     C                   If        (ySqlWhere  <> ' ') or
     C                             (ySqlOrder  <> ' ')
     C                   IF        accessMode <> §sqlSeq
     C                   Eval      oldAccMode = accessMode
     C                   Endif
     C                   Eval      accessMode = §sqlSeq
     C                   Eval      sqlWhere   = ySqlWhere
     C                   Eval      sqlOrder   = ySqlOrder
     C                   Else
     C                   Eval      accessMode = oldAccMode
     C                   Eval      sqlWhere   = ' '
     C                   Eval      sqlOrder   = ' '
     C                   Endif
      *
     C                   Exsr      openFile
      *
     C                   Eval      isPinToClr = bTrue
      *
     C                   Endsr
      *
      *============================================================*
      *    S_Change      02 - Ändern Einzelsatz                    *
      *============================================================*
      *
     C     S_Change      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C     IsUpdMod      IFEQ      bFalse
      *      Ändern nicht möglich, da INPUT-Modus
     C                   EVAL      §MsgID = 'USR0007'
     C                   EVAL      USR00071 = ##FILE
     C                   EVAL      USR00072 = ##LIBRARY
     C                   EVAL      §MsgDta = USR0007
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *
     C                   EXSR      GetSflRcd
      *
     C     SflCsr        IFGT      §ZEROS
     C                   EVAL      YFunction = '*CHANGE'
     C                   EXSR      CallUpdPgm
     C                   EXSR      ReloadUsrStg
     C                   ELSE
      *        kein Datensatz verfügbar
     C                   Endif
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_Copy        03 - Kopieren Einzelsatz                  *
      *============================================================*
      *
     C     S_Copy        BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C     IsUpdMod      IFEQ      bFalse
      *      Ändern nicht möglich, da INPUT-Modus
     C                   EVAL      §MsgID = 'USR0007'
     C                   EVAL      USR00071 = ##FILE
     C                   EVAL      USR00072 = ##LIBRARY
     C                   EVAL      §MsgDta = USR0007
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *
     C                   EXSR      GetSflRcd
      *
     C     SflCsr        IFGT      §ZEROS
     C                   EVAL      YFunction = '*COPY'
     C                   EXSR      CallUpdPgm
     C                   ELSE
      *        kein Datensatz verfügbar
     C                   Endif
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_CopyExt     09 - Kopieren Einzelsatz in externe Datei *
      *============================================================*
      *
     C     S_CopyExt     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C     auth.updMod   IFEQ      bFalse
      *      Nachricht "Keine Berechtigung" ausgeben.
     C                   ELSE
      *
     C                   EXSR      GetSflRcd
      *
     C     SflCsr        IFGT      §ZEROS
      *
     C     QueryUser     IFNE      YPgmCmd
      *
      *  Abfragen der Zielangaben ...
     C                   EXSR      PBGetTargt
      *
      *  Verarbeitung OK ...
     C     YMsgID        IFEQ      'USR8112'
      *  Fragen Benutzer pro Datensatz ...
     C                   EXSR      PBQueryUsr
     C                   Endif
      *
     C                   ELSE
      *  Kopieren ohne Sicherheitsabfrage ...
     C                   EVAL      YMsgID = 'USR8112'
     C                   EVAL      YMsgDta = *BLANKS
     C                   Endif
      *
      *  Datensatz kopieren ...
     C     YMsgID        IFEQ      'USR8112'
     C                   EXSR      CopyExtRcd
     C                   Endif
      *
     C                   ELSE
      *        kein Datensatz verfügbar
     C                   Endif
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_Delete      04 - Löschen Einzelsatz                   *
      *============================================================*
      *
     C     S_Delete      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C     IsUpdMod      IFEQ      bFalse
      *      Löschen nicht möglich, da INPUT-Modus
     C                   EVAL      §MsgID = 'USR0007'
     C                   EVAL      USR00071 = ##FILE
     C                   EVAL      USR00072 = ##LIBRARY
     C                   EVAL      §MsgDta = USR0007
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *
     C                   EXSR      GetSflRcd
      *
     C     SflCsr        IFGT      §ZEROS
      *
     C     QueryUser     IFNE      YPgmCmd
      *
      *  Fragen Benutzer ...
     C                   EXSR      PBQueryUsr
      *
     C                   ELSE
      *  Löschen ohne Sicherheitsabfrage ...
     C                   EVAL      YMsgID = 'USR8112'
     C                   EVAL      YMsgDta = *BLANKS
     C                   Endif
      *
      *  Datensatz löschen ...
     C     YMsgID        IFEQ      'USR8112'
     C                   EXSR      DelRecord
     C                   Endif
      *
     C                   ELSE
      *        kein Datensatz verfügbar
     C                   Endif
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_Display     05 - Anzeigen Einzelsatz                  *
      *============================================================*
      *
     C     S_Display     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetSflRcd
      *
     C     SflCsr        IFGT      §ZEROS
      *
     C                   monitor
     C                   CALLP     PEEK14(SET_Dsp80: SET_HedTyp: §CopyRight
     C                                    : Wrk#RcdNbr: H_FILE: H_LIB: H_MBR
     C                                    : H_RCDFMT: '*DISPLAY': CommitLVL
     C                                    : YScreenNbr: YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C                   EXSR      ChkHeadChg
      *
     C                   ELSE
      *        kein Datensatz verfügbar
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_Print       06 - Drucken Datensatz                    *
      *============================================================*
      *
     C     S_Print       BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetSflRcd
      *
     C     SflCsr        IFGT      §ZEROS
      *
     C                   monitor
     C                   callp     PEEK65(Wrk#RcdNbr: H_FILE: H_LIB: H_MBR: ''
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C                   IF        YMsgID <> ''
     C                   EVAL      §MsgID  = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   EVAL      YMsgID  = ''
     C                   EVAL      YMsgDta = ''
     C                   ENDIF
      *
     C                   EXSR      ChkHeadChg
      *
     C                   ELSE
      *        kein Datensatz verfügbar
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_PinRcd      P  - Pin Datensatz                        *
      *============================================================*
      *
     C     S_PinRcd      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
    R ***  F4Open        OREQ      '0'
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   IF        f_numBased(##FILE: ##LIBRARY: ##MEMBER) > 1
     C                   CLEAR                   USR8218
     C                   EVAL      §MsgID = 'USR8218'
     C                   EVAL      §MsgDta = USR8218
     C                   Eval      IsCmdErr = bTrue
     C                   Eval      IsCancel = bTrue
     C                   ELSE
      *
     C                   EXSR      GetSflRcd
      *
     C     SflCsr        IFGT      §ZEROS
      *
     C                   IF        f_chain04(Wrk#RcdNbr:
     C                                       H_FILE   :
     C                                       H_LIB    :
     C                                       H_MBR    :
     C                                       H_RCDFMT ) = '0'
     C                   EXSR      PinRecord
      *
     C                   ELSE
      *  Datensatz nicht gefunden ...
     C                   EVAL      §MsgID = 'USR8118'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
     C                   ELSE
      *        kein Datensatz verfügbar
     C                   Endif
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_UnPinRcd    UP - UnPin Datensatz                      *
      *============================================================*
      *
     C     S_UnPinRcd    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetSflRcd
      *
     C     SflCsr        IFGT      §ZEROS
      *
     C                   EXSR      ChkPinRcd
     C     IsPinned      IFEQ      bFalse
      *  Datensatz ist nicht gepinned ...
     C                   EVAL      §MsgID = 'USR8121'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *  Datensatz ist gepinned ...
     C                   EXSR      RmvPinRcd
     C                   Endif
      *
     C                   ELSE
      *        kein Datensatz verfügbar
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_TgTblPap    Toggeln Tabellierpapierfunktion           *
      *============================================================*
      *
     C     S_TgTblPap    BEGSR
      *
     C     SET_TblMde    IFEQ      bTrue
     C                   EXSR      S_TblPapOf
     C                   ELSE
     C                   EXSR      S_TblPapOn
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_TblPapOn    Einschalten Tabellierpapier               *
      *============================================================*
      *
     C     S_TblPapOn    BEGSR
      *
     C     SET_TblMde    IFEQ      bTrue
      *  Fehlermeldung ...
     C                   EVAL      §MsgID = 'USR8149'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   EVAL      SET_TblMde = bTrue
     C                   EVAL      IsSflDirty = bTrue
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_TblPapOf    Ausschalten Tabellierpapier               *
      *============================================================*
      *
     C     S_TblPapOf    BEGSR
      *
     C     SET_TblMde    IFEQ      bFalse
      *  Fehlermeldung ...
     C                   EVAL      §MsgID = 'USR8150'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   EVAL      SET_TblMde = bFalse
     C                   EVAL      IsSflDirty = bTrue
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_TgPinCol    PC - Pin Spalte                           *
      *============================================================*
      *
     C     S_TgPinCol    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetFldTMrk
      *
     C     Wrk#Field     IFEQ      *BLANKS
      *  Fehler aufgetreten ...
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *
     C                   EVAL      Pin#Field = Wrk#Field
     C                   EXSR      ChkPinCol
     C     IsPinned      IFEQ      bFalse
      *  Datensatz ist noch nicht gepinned ...
      *  Spalte pinnen ...
     C                   EXSR      PinCol
     C                   ELSE
     C                   EXSR      RmvPinCol
     C                   Endif
     C                   Endif
     C                   Endif
      *
      *  Beibehalten der Cursorposition ...
     C                   EXSR      KeepCsrPos
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_PinCol      PC - Pin Spalte                           *
      *============================================================*
      *
     C     S_PinCol      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetFldTMrk
      *
     C     Wrk#Field     IFEQ      *BLANKS
      *  Fehler aufgetreten ...
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *  Spalte pinnen ...
     C                   EXSR      PinCol
     C                   Endif
     C                   Endif
      *
      *  Beibehalten der Cursorposition ...
     C                   EXSR      KeepCsrPos
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_UnPinCol    UC - UnPin Spalte                         *
      *============================================================*
      *
     C     S_UnPinCol    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetFldTMrk
      *
     C     Wrk#Field     IFEQ      *BLANKS
      *  Fehler aufgetreten ...
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *
     C                   EVAL      Pin#Field = Wrk#Field
     C                   EXSR      ChkPinCol
     C     IsPinned      IFEQ      bFalse
      *  Spalte ist nicht gepinned ...
     C                   EVAL      §MsgID = 'USR8147'
     C                   EVAL      USR81471 = Wrk#Field
     C                   EVAL      §MsgDta = USR8147
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *  Spalte ist gepinned ...
     C                   EXSR      RmvPinCol
     C                   Endif
     C                   Endif
     C                   Endif
      *
      *  Beibehalten der Cursorposition ...
     C                   EXSR      KeepCsrPos
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_SplashOn    Einschalten Splash-Screen                 *
      *============================================================*
      *
     C     S_SplashOn    BEGSR
      *
     C                   EVAL      SET_Spla = bTrue
      *
     C                   EVAL      §MsgID = 'USR8161'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_SplashOf    Ausschalten Splash-Screen                 *
      *============================================================*
      *
     C     S_SplashOf    BEGSR
      *
     C                   EVAL      SET_Spla = bFalse
      *
     C                   EVAL      §MsgID = 'USR8162'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_ShortCmd    Ausführen Kurzbefehl                      *
      *============================================================*
      *
     C     S_ShortCmd    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   EXSR      GetSflRcd
      *
     C     SflCsr        IFGT      §ZEROS
      *
     C                   CLEAR                   shortCmd
     C                   EVAL      shortCmd.SC_Action = '*CMD'
     C                   EVAL      shortCmd.SC_Cmd = YCmdDta
     C                   CALLP     PEEK42(H_FILE: H_LIB: H_MBR: H_RCDFMT
     C                                    : ShortCmd: Wrk#RcdNbr: YExecCmd
     C                                    : YMsgID: YMsgDta)
      *
     C                   Select
     C     *IN99         WhenEq    '1'
      *           Program error
     C     YMsgID        WhenNe    *BLANKS
     C                   EVAL      §msgId = YMsgID
     C                   EVAL      §msgDta = YMsgDta
     C
     C     YExecCmd      WhenEq    *BLANKS
      *           No command to excute
     C                   other
     C                   EVAL      §QCmd = YExecCmd
      /COPY QCOPYLE,QCMDEXC
     C                   Endsl
      *
     C                   ELSE
      *        kein Datensatz verfügbar
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_About        A - Über Peek/400                        *
      *============================================================*
      *
     C     S_About       BEGSR
      *
     C                   CALLP     PEEK49(SET_Dsp80: §CopyRight
     C                                    : §Release: §Version
     C                                    : YMsgID: YMsgDta)
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_DspNrm      Normale Anzeige                           *
      *============================================================*
      *
     C     S_DspNrm      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
     C     SET_DspMde    IFEQ      '*DSPNRM'
      *    ... Anzeige stimmt bereits
     C                   ELSE
      *
      *  Umschalten der Anzeige
     C                   EVAL      SET_DspMde = '*DSPNRM'
     C                   EVAL      IsSflDirty = bTrue
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_DspHex      Hexadezimale Anzeige                      *
      *============================================================*
      *
     C     S_DspHex      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
     C     SET_DspMde    IFEQ      '*DSPHEX'
      *    ... Anzeige stimmt bereits
     C                   ELSE
      *
     C                   IF        File#X.RcdLen > §rcdBufLen
     C                   CLEAR                   USR8206
     C                   Eval      §MsgID     = 'USR8206'
     C                   Eval      USR82061   = §rcdBufLen
     C                   Eval      §MsgDta    = USR8206
     C                   ELSE
     C                   Eval      SET_DspMde = '*DSPHEX'
     C                   Eval      IsSflDirty = bTrue
     C                   Endif
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_DspTgl      Umschalten der Anzeige                    *
      *============================================================*
      *
     C     S_DspTgl      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
     C     Set_DspMde    IFEQ      '*DSPNRM'
     C                   EXSR      S_DspHex
     C                   ELSE
     C                   EXSR      S_DspNrm
     C                   Endif
      *
     C                   EVAL      IsSflDirty = bTrue
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_SaveEnv     Sichern Arbeitsumgebung                   *
      *============================================================*
      *
     C     S_SaveEnv     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   CALLP     PEEK56(SET_Dsp80: §CopyRight: '*SAVE'
     C                                    : YEnvFile: YEnvLib: YEnvMbr
     C                                    : $$RCDFMTID
     C                                    : YQFile: YMember: YText: YOption
     C                                    : YMsgID: YMsgDta)
      *
     C                   If        YMsgID <> ' '
     C                   Eval      §MsgID  = yMsgID
     C                   Eval      §MsgDta = yMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Else
      *
     C                   Eval      YEnvFile = yFile
     C                   Eval      YEnvLib  = yLibrary
     C                   Eval      YEnvMbr  = yMember
     C                   EVAL      YIsAutoSave = bFalse
     C                   Exsr      SaveEnv
      *
     C                   If        YMsgID <> ' '
     C                   Eval      §MsgID  = yMsgID
     C                   Eval      §MsgDta = yMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_LoadEnv     Laden Arbeitsumgebung                     *
      *============================================================*
      *
     C     S_LoadEnv     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   CALLP     PEEK56(SET_Dsp80: §CopyRight: '*LOAD'
     C                                    : YEnvFile: YEnvLib: YEnvMbr
     C                                    : $$RCDFMTID
     C                                    : YQFile: YMember: YText: YOption
     C                                    : YMsgID: YMsgDta)
      *
     C                   If        YMsgID <> ' '
     C                   Eval      §MsgID  = yMsgID
     C                   Eval      §MsgDta = yMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Else
      *
     C                   Eval      YEnvFile = yFile
     C                   Eval      YEnvLib  = yLibrary
     C                   Eval      YEnvMbr  = yMember
     C                   Exsr      LoadEnv
     C                   EVAL      IsSflDirty = bTrue
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    LoadEnv       Laden Arbeitsumgebung                     *
      *============================================================*
      *
     C     LoadEnv       BEGSR
      *
     C                   Eval      IsPinToClr = bFalse
      *
     C                   if        (##Member = '*NONE')
     C                   leavesr
     C                   endif
      *
     C                   CALLP     PEEK55(##File: ##Library: ##Member: ##Format
     C                                    : $$RCDFMTID
     C                                    : YEnvFile: YEnvLib: YEnvMbr
     C                                    : YOption
     C                                    : PinTabR: NbrPinRcd
     C                                    : PinTabC: NbrPinCol
     C                                    : rtn.file: rtn.library: rtn.member
     C                                    : rtn.format
     C                                    : rtn.accessMode: rtn.sqlWhere
     C                                    : rtn.sqlOrder
     C                                    : isKeyLower
     C                                    :YMsgID: YMsgDta)
      *
     C                   If        yMsgID <> ' '
     C                   Eval      §msgID  = yMsgID
     C                   Eval      §msgDta = yMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Else
      *
     C                   If        (##FILE     <> rtn.file or
     C                              ##LIBRARY  <> rtn.library or
     C                              ##MEMBER   <> rtn.member or
     C                              ##FORMAT   <> rtn.format or
     C                              yAccMode   <> rtn.accessMode or
     C                              ySqlWhere  <> rtn.sqlWhere or
     C                              ySqlOrder  <> rtn.sqlOrder)
     C                   Exsr      closeFile
     C                   Eval      ##FILE     = rtn.file
     C                   Eval      ##LIBRARY  = rtn.library
     C                   Eval      ##MEMBER   = rtn.member
     C                   Eval      ##FORMAT   = rtn.format
     C                   Eval      accessMode = rtn.accessMode
     C                   Eval      sqlWhere   = rtn.sqlWhere
     C                   Eval      sqlOrder   = rtn.sqlOrder
     C                   Exsr      openFile
     C                   CALLP     PEEK55(##File: ##Library: ##Member: ##Format
     C                                    : $$RCDFMTID
     C                                    : YEnvFile: YEnvLib: YEnvMbr
     C                                    : YOption
     C                                    : PinTabR: NbrPinRcd
     C                                    : PinTabC: NbrPinCol
     C                                    : rtn.file: rtn.library: rtn.member
     C                                    : rtn.format
     C                                    : rtn.accessMode: rtn.sqlWhere
     C                                    : rtn.SqlOrder
     C                                    : isKeyLower
     C                                    :YMsgID: YMsgDta)
     C                   Endif
      *
     C                   Eval      PinTabR    = YPinTabR
     C                   Eval      NbrPinRcd  = YNbrPinR
     C                   Eval      NbrPinCol  = YNbrPinC
      *
     C                   Eval      isKeyLower = YisKeyLower
     C                   Endif
      *
     C                   Eval      IsPinToClr = bTrue
      *
     C                   ENDSR
      *
      *============================================================*
      *    SaveEnv       Speichern Arbeitsumgebung                 *
      *============================================================*
      *
     C     SaveEnv       BEGSR
      *
     C                   CALLP     PEEK54(##File: ##Library: ##Member: ##Format
     C                                    : $$RcdFmtID
     C                                    : YEnvFile: YEnvLib: YEnvMbr
     C                                    : YIsAutoSave
     C                                    : PinTabR: NbrPinRcd
     C                                    : PinTabC: NbrPinCol
     C                                    : accessMode: sqlWhere
     C                                    : sqlOrder: isKeyLower
     C                                    : YMsgID: YMsgDta)
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_DelEnv      Löschen Arbeitsumgebung                   *
      *============================================================*
      *
     C     S_DelEnv      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C                   DO        *HIVAL
      *
     C                   CALLP     PEEK56(SET_Dsp80: §CopyRight: '*DELETE'
     C                                    : YEnvFile: YEnvLib: YEnvMbr
     C                                    : ''
     C                                    : YQFile: YMember: YText: YOption
     C                                    : YMsgID: YMsgDta)
      *
     C                   If        YMsgID <> ' '
     C                   Eval      §MsgID  = yMsgID
     C                   Eval      §MsgDta = yMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   LEAVE
     C                   Else
      *
     C                   CALLP     PEEK57(SET_Dsp80: §CopyRight
     C                                    : yFile: yLibrary: yMember: yText
     C                                    : YMsgID: YMsgDta)
      *
     C                   If        yMsgID <> ' '
     C                   If        yMsgDta = '*CANCEL'
     C                   ITER
     C                   ELSE
     C                   Eval      §msgID  = yMsgID
     C                   Eval      §msgDta = yMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   LEAVE
     C                   Endif
     C                   Endif
      *
     C                   Endif
      *
     C                   Enddo
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    MsgNoFile     Nachricht: Keine Datei geöffnet           *
      *============================================================*
      *
     C     MsgNoFile     BEGSR
      *
     C                   EVAL      §MsgID = 'USR9996'
     C                   EVAL      §MsgDta = USR9996
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
     C                   ENDSR
      *
      *============================================================*
      *    MsgInvSqlFile Nachricht: Keine Datei geöffnet           *
      *============================================================*
      *
     C     MsgInvSqlFile BEGSR
      *
     C                   EVAL      §MsgID = 'USR9993'
     C                   EVAL      §MsgDta = USR9993
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
     C                   ENDSR
      *
      *============================================================*
      *    ClrPinRow     Löschen der Pin-Tabelle für Zeilen        *
      *============================================================*
      *
     C     ClrPinRow     BEGSR
      *
     C     IsPinToClr    IFEQ      bTrue
     C                   EVAL      NbrPinRcd = §ZEROS
     C                   EXSR      clrPinTabR
     C                   EVAL      IsSflDirty = bTrue
     C                   ELSE
      *    ... wird nicht gelöscht
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ClrPinCol     Löschen der Pin-Tabelle für Spalten       *
      *============================================================*
      *
     C     ClrPinCol     BEGSR
      *
     C     IsPinToClr    IFEQ      bTrue
     C                   EVAL      NbrPinCol = §ZEROS
     C                   CLEAR                   PinTabC
     C                   EVAL      IsSflDirty = bTrue
     C                   ELSE
      *    ... wird nicht gelöscht
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBGetTargt    Abffragen der Zieldatei                   *
      *============================================================*
      *
     C     PBGetTargt    BEGSR
      *
     C     IsTargetOK    IFEQ      bTrue
     C                   EVAL      YMsgID = 'USR8112'
     C                   EVAL      YMsgDta = *BLANKS
     C                   ELSE
      *
     C                   monitor
     C                   CALLP     PEEK26(SET_Dsp80: YQFile: H_MBR
     C                                    : YFile: YLibrary: YMember
     C                                    : YMbrOpt: YCrtFile: YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      IsError = bTrue
     C                   EVAL      IsTargetOK = bFalse
     C                   ELSE
     C                   EVAL      IsError = bFalse
     C                   EVAL      IsTargetOK = bTrue
      *
     C                   EVAL      CopyFile = YFile
     C                   EVAL      CopyLib = YLibrary
     C                   EVAL      CopyToMbr = YMember
     C                   EVAL      CopyMbrOpt = YMbrOpt
     C                   EVAL      CopyCrtF = YCrtFile
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBQueryUsr    Fragen Benutzer                           *
      *============================================================*
      *
     C     PBQueryUsr    BEGSR
      *
     C                   monitor
     C                   CALLP     PEEK14(SET_Dsp80: SET_HedTyp: §CopyRight
     C                                    : Wrk#RcdNbr: H_FILE: H_LIB: H_MBR
     C                                    : H_RCDFMT: YPgmCmd: CommitLVL
     C                                    : YScreenNbr: YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C                   EXSR      ChkHeadChg
      *
     C     *IN99         IFEQ      '1'
      *            Fehler beim Programmaufruf
     C                   ELSE
      *
     C                   SELECT
      *  Abbruch über F3/F12 ...
     C     YMsgID        WHENEQ    'USR8100'
      *  Alle Datensätze löschen ...
     C     YMsgID        WHENEQ    'USR8111'
     C                   EVAL      QueryUser = YPgmCmd
     C                   EVAL      YMsgID = 'USR8112'
     C                   EVAL      YMsgDta = *BLANKS
      *  Einzelnen Datensatz löschen ...
     C     YMsgID        WHENEQ    'USR8112'
      *  Unerwartete Nachrichten-ID ...
     C                   OTHER
     C                   EVAL      §MsgID = 'USR9998'
     C                   EVAL      USR99981 = YMsgID
     C                   EVAL      USR99982 = 'PEEK14'
     C                   EVAL      §MsgDta = USR9998
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endsl
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PinRecord     Datensatz pinnen                          *
      *============================================================*
      *
     C     PinRecord     BEGSR
      *
     C                   EVAL      IsPinOK = bFalse
      *
     C                   EXSR      ChkPinRcd
     C     IsPinned      IFEQ      bFalse
      *  Datensatz ist noch nicht gepinned ...
     C                   CLEAR                   PIN#DS
     C                   EVAL      x = %lookup(PIN#DS: PinTabR: x)
     C                   IF        (x > 0)
      *  ... Datensatz pinnen
     C                   EVAL      PIN#DS.RCDNBR = Wrk#RcdNbr
     C                   EVAL      PIN#DS.FILE = H_FILE
     C                   EVAL      PIN#DS.LIB = H_LIB
     C                   EVAL      PIN#DS.MBR = H_MBR
     C                   EVAL      PIN#DS.RCDFMT = H_RCDFMT
     C                   EVAL      PIN#DS.MBRNBR = H_MBRNBR
     C                   EVAL      PinTabR(X) = PIN#DS
      *
     C                   EVAL      NbrPinRcd = X
     C                   EVAL      IsSflDirty = bTrue
     C                   EVAL      IsPinOK = bTrue
     C                   ELSE
      *  Kein Platz mehr vorhanden ...
     C                   EVAL      §MsgID = 'USR8118'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
     C                   ELSE
      *  Datensatz ist schon gepinned
     C                   EVAL      §MsgID = 'USR8119'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PinCol        Spalte pinnen                             *
      *============================================================*
      *
     C     PinCol        BEGSR
      *
     C                   EVAL      IsPinOK = bFalse
      *
     C                   EVAL      Pin#Field = Wrk#Field
     C                   EXSR      ChkPinCol
     C     IsPinned      IFEQ      bFalse
      *  Datensatz ist noch nicht gepinned ...
     C                   EVAL      X = 1
     C                   EVAL      Pin#Field = ''
     C                   EVAL      x = %lookup(Pin#Field: PinTabC: x)
     C                   IF        (x > 0)
      *  ... Datensatz pinnen
     C                   EVAL      PinTabC(X) = Wrk#Field
     C                   EVAL      NbrPinCol = X
     C                   EVAL      IsSflDirty = bTrue
     C                   EVAL      IsPinOK = bTrue
     C                   ELSE
      *  Kein Platz mehr vorhanden ...
     C                   EVAL      §MsgID = 'USR8118'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
     C                   ELSE
      *  Datensatz ist schon gepinned
     C                   EVAL      §MsgID = 'USR8119'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    DelRecord     Löschen Datensatz                         *
      *============================================================*
      *
     C     DelRecord     BEGSR
      *
     C                   EVAL      *IN11 = f_chain00(Wrk#RcdNbr:
     C                                               H_FILE   :
     C                                               H_LIB    :
     C                                               H_MBR    :
     C                                               '')
     C     *IN11         IFEQ      '1'
      *  Fehler bei Zugriff auf Datensatz ...
     C                   EVAL      §MsgID = 'USR8200'
     C                   EVAL      USR82001 = Wrk#RcdNbr
     C                   EVAL      §MsgDta = USR8200
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
     C                   ELSE
      *
     C                   IF        CIO_delete(hFile00) = bTrue
     C                   EVAL      *IN99 = '0'
     C                   ELSE
     C                   EVAL      *IN99 = '1'
     C                   ENDIF
     C                   EXSR      F0toFx
      *
     C     *IN99         IFEQ      '1'
     C   55              ROLBK
     C  N55              CALLP     CIO_unlock(hFile00)
     C                   EXSR      F0toFx
      *
     C                   EVAL      §MsgID = 'USR8200'
     C                   EVAL      USR82001 = Wrk#RcdNbr
     C                   EVAL      §MsgDta = USR8200
     C                   ELSE
     C   55              COMMIT
     C  N55              CALLP     CIO_unlock(hFile00)
     C                   EXSR      F0toFx
     C                   EXSR      CallExit04
      *
     C                   EVAL      §MsgID = 'USR8201'
     C                   EVAL      USR82011 = Wrk#RcdNbr
     C                   EVAL      §MsgDta = USR8201
     C                   EVAL      IsSflDirty = bTrue
     C                   Endif
      *
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
     C                   ENDSR
      *
     C     CallExit04    BEGSR
      *
     C                   If        f_exist('EXIT04': '*LIBL': '*PGM') = bTrue
      *
     C                   Eval      yFile      = File#X.File
     C                   Eval      yLibrary   = File#X.Library
     C                   Eval      yMember    = File#X.Member
     C                   Eval      yEvent     = '*DELETE'
     C                   Eval      yUser      = §§User
     C                   Eval      yTimestamp = %timestamp()
     C                   Eval      yRcdNbr    = Wrk#RcdNbr
     C                   Eval      ySize      = File#X.RcdLen
     C                   Eval      yBImage    = %addr(IO_Buff)
     C                   Eval      yAImage    = *NULL
      *
     C                   Call      'EXIT04'      P#Exit04
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    CopyExtRcd    Kopieren Datensatz in externe Datei       *
      *============================================================*
      *
     C     CopyExtRcd    BEGSR
      *
     C                   IF        f_chain04(Wrk#RcdNbr:
     C                                       H_FILE   :
     C                                       H_LIB    :
     C                                       H_MBR    :
     C                                       H_RCDFMT ) = '0'
      *
     C                   EVAL      rcdNbr# = CIO_getRRN(hFile04)
      *
     C                   EVAL      §QCmd = 'CPYF' +
      *  FromFile
     C                                     ' FROMFILE(' +
     C                                     %trim(CIO_getLibrary(hFile04)) +
     C                                     '/' +
     C                                     %trim(CIO_getFile(hFile04)) +
     C                                     ')' +
      *  ToFile
     C                                     ' TOFILE(' +
     C                                     %trim(CopyLib) +
     C                                     '/' +
     C                                     %trim(CopyFile) +
     C                                     ')' +
      *  FromMbr
     C                                     ' FROMMBR(' +
     C                                     %trim(CIO_getMember(hFile04)) +
     C                                     ')' +
      *  ToMbr
     C                                     ' TOMBR(' +
     C                                     %trim(CopyToMbr) +
     C                                     ')' +
      *  MbrOpt
     C                                     ' MBROPT(' +
     C                                     %trim(CopyMbrOpt) +
     C                                     ')' +
      *  CrtFile
     C                                     ' CRTFILE(' +
     C                                     %trim(CopyCrtF) +
     C                                     ')' +
      *  FromRcd
     C                                     ' FROMRCD(' +
     C                                     rcdNbr$ +
     C                                     ')' +
      *  ToRcd
     C                                     ' TORCD(' +
     C                                     rcdNbr$ +
     C                                     ')' +
      *  FmtOpt
     C                                     ' FMTOPT(' +
     C                                     '*MAP *DROP' +
     C                                     ')' +
      *  Record Format
     C                                     ' RCDFMT(' +
     C                                     %trim(CIO_getRecordFormat(hFile04)) +
     C                                     ')'
      /COPY QCOPYLE,QCMDEXC
      *
     C     §QCmdError    IFEQ      '1'
     C   55              ROLBK
     C                   EXSR      F0toFx
      *
     C                   EVAL      §MsgID = 'USR8202'
     C                   EVAL      USR82021 = Wrk#RcdNbr
     C                   EVAL      §MsgDta = USR8202
     C                   ELSE
     C   55              COMMIT
     C                   EXSR      F0toFx
      *
     C                   EVAL      §MsgID = 'USR8203'
     C                   EVAL      USR82031 = Wrk#RcdNbr
     C                   EVAL      §MsgDta = USR8203
     C                   Endif
      *
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
      *  Alles weitere mit ...
     C                   EVAL      CopyMbrOpt = '*ADD'
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkHeadChg    Prüfen, ob die Überschrift gewechselt hat *
      *                  nach:  S_Delete und S_Display             *
      *============================================================*
      *
     C     ChkHeadChg    BEGSR
      *
     C     *IN99         IFEQ      '1'
      *            Fehler beim Programmaufruf
     C                   ELSE
     C     YMsgID        IFEQ      'USR8100'
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   EVAL      SET_HedTyp = YHeaderTyp
     C                   EVAL      IsSflDirty = bTrue
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchStart     Aufsetzen mit neuer Suche                 *
      *============================================================*
      *
     C     SrchStart     BEGSR
      *
      *  Übertragen der Übergabeparameter ...
     C                   EVAL      SrchField = YField
     C                   EVAL      SrchOP = YOperation
     C                   EVAL      SrchArg = YArgument
     C                   EVAL      SrchSign = YSign
      *
      *  ... Anpassungen für LIKE/NLIKE ...
     C     SrchOP        IFEQ      'LIKE'
     C     SrchOP        OREQ      'NLIKE'
      *      ... führendes %-Zeichen
     C     1             SUBST (P) SrchArg:1     A1
     C     A1            IFEQ      SET_WLDCD
     C                   SUBST (P) SrchArg:2     SrchArg
     C                   EVAL      SrchLikeTp = 1
     C                   ELSE
     C                   EVAL      SrchArg = SrchArg
     C                   EVAL      SrchLikeTp = §ZEROS
     C                   Endif
      *
      *      ... nachgestelltes %-Zeichen
     C                   EVAL      x = %checkr(' ': SrchArg)
     C     X             IFGT      §ZEROS
     C                   EVAL      A1 = %subst(SrchArg: x: 1)
      *
     C     A1            IFEQ      SET_WLDCD
     C                   EVAL      X = X - 1
     C     X             IFGT      §ZEROS
     C                   EVAL      SrchArg = %subst(SrchArg: 1: x)
     C                   ELSE
     C                   EVAL      SrchArg = *BLANKS
     C                   Endif
     C                   EVAL      SrchLikeTp = SrchLikeTp + 2
     C                   Endif
      *
     C                   Endif                                                 X
      *
      *      ... Länge von SrchArg
     C                   EVAL      SrchLikeLn = %checkr(' ': SrchArg)
     C                   ELSE
      *  ... keine Anpassungen erforderlich
     C                   EVAL      SrchLikeTp = §ZEROS
     C                   EVAL      SrchLikeLn = §ZEROS
     C                   Endif
      *
     C                   EVAL      SrchNbrs = YSrchNbrs
     C                   EVAL      SrchType = YSrchType
     C                   EVAL      SrchCase = YSrchCase
      *
      *  Ermitteln der Feldattribute
     C                   EXSR      SrchFldAtr
      *
     C     SrchField     IFEQ      '*RECORD'
     C                   EVAL      SrchIsNum = bFalse
     C                   ELSE
     C                   IF        f_isNumFld(FLDL0100) = bTrue
     C                   EVAL      SrchIsNum = bTrue
     C                   ELSE
     C                   EVAL      SrchIsNum = bFalse
     C                   Endif
     C                   Endif
      *
      *  Nicht Case-Sensitive suchen ...
     C     YSrchCase     IFEQ      bFalse
     C     SrchIsNum     ANDEQ     bFalse
     C     cLOWER:cUPPER XLATE (P) SrchArg       SrchArg
     C                   ELSE
      *      keine Konvertierung erforderlich
     C                   Endif
      *
      *  Numerische Suche ...
     C     SrchIsNum     IFEQ      bTrue
     C                   IF        f_isFloatFld(FLDL0100) = bTrue
     C                   EVAL      SrchArgFloat = %float(SrchArg)
     C                   EVAL      SrchArgVal   = 0
     C                   EVAL      SrchArgIsFloat = bTrue
     C                   ELSE
     C                   EVAL      SrchArgVal   = %dec(SrchArg
     C                                                 : cSRCHARG_DIGITS
     C                                                 : cSRCHARG_DECPOS)
     C                   EVAL      SrchArgFloat = 0
     C                   EVAL      SrchArgIsFloat = bFalse
     C                   ENDIF
     C     SrchSign      IFEQ      SET_SignM
      *  ... negativen Wert erzeugen
     C                   MULT      -1            SrchArgVal
     C                   MULT      -1            SrchArgFloat
     C                   ELSE
      *  ... positiven Wert belassen
     C                   Endif
     C                   ELSE
     C                   EVAL      SrchArgVal = §ZEROS
     C                   EVAL      SrchArgFloat = §ZEROS
     C                   Endif
      *
      *  Ermitteln des Startdatensatzes
     C                   EXSR      SrchStrRcd
      *
      *  Suchen ...
     C                   EXSR      SrchUp
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchCont      Fortsetzen der Suche nach "gefunden"      *
      *============================================================*
      *
     C     SrchCont      BEGSR
      *
      *  Ermitteln der Feldattribute
     C                   EXSR      SrchFldAtr
      *
      *  Ermitteln des Startdatensatzes
     C                   EXSR      SrchStrRcd
      *
      *  Suchen ...
     C                   EXSR      SrchUp
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchContM     Fortsetzen der Suche nach "MAXIMUM"       *
      *============================================================*
      *
     C     SrchContM     BEGSR
      *
      *  Ermitteln der Feldattribute
     C                   EXSR      SrchFldAtr
      *
      *  Suchen ...
     C                   EXSR      SrchUp
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchEOF       Fortsetzen der Suche nach Dateiende       *
      *============================================================*
      *
     C     SrchEOF       BEGSR
      *
      *  Ermitteln der Feldattribute
     C                   EXSR      SrchFldAtr
      *
      *  Ermitteln des Startdatensatzes
     C                   EXSR      PBMoveTop
      *
      *  Suchen ...
     C                   EXSR      SrchUp
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchStrRcd    Positionieren auf Startdatensatz          *
      *============================================================*
      *
     C     SrchStrRcd    BEGSR
      *
      *---------------------------------------*
      *  Cursor im Subfilebereich ...
      *---------------------------------------*
     C     SflCsr        IFNE      §ZEROS
     C     SflCsr        ANDGT     NbrPinRcd
      *
      *  ... übersetzen in Satznummer
     C                   EXSR      PBCsrTRcd
      *  ... Fortsetzen der Suche
     C     Wrk#RcdNbr    IFEQ      SrchFndRcd
     C                   EXSR      PBReadCsrA
     C                   ELSE
      *  ... oder neu anfangen
     C                   EXSR      PBReadCsr
     C                   Endif
     C                   ELSE
      *
      *---------------------------------------*
      *  Cursor nicht im Subfilebereich ...   *
      *---------------------------------------*
     C                   EVAL      X = SflFirstRw + NbrPinRcd
     C     §ScnCsrRow    IFLT      X
      *  ... oberhalb der Subfile
     C                   EXSR      PBReadDn
     C                   ELSE
      *  ... unterhalb der Subfile
      *             einfach weitersuchen
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchFldAtr    Ermitteln der Feldattribute des           *
      *                  Suchfeldes                                *
      *============================================================*
      *
     C     SrchFldAtr    BEGSR
      *
     C                   EVAL      F_Field = SrchField
     C     F_Key         CHAIN (N) FPEEKFLD                           11
     C     *IN11         IFEQ      '1'
     C                   CLEAR                   FLDL0100
     C                   ELSE
     C                   EVAL      FLDL0100 = F_FFD
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchUp        Suchen ab einer gegebenen Satznummer      *
      *============================================================*
      *
     C     SrchUp        BEGSR
      *
      *  Suche läuft ...
     C                   Callp     p_sndStsMg('USR8127': ' ')
      *
     C                   EVAL      SrchCount = §ZEROS
     C                   EVAL      SrchCount2 = §ZEROS
      *
     C                   DO        *HIVAL
     C                   EXSR      PBRead
     C     IsEOF         IFEQ      bTrue
     C                   EVAL      SrchMode = '*EOF'
     C                   LEAVE
     C                   Endif
      *
     C                   EVAL      SrchCount = SrchCount + 1
     C     SrchCount     IFGE      SrchNbrs
     C                   EVAL      SrchMode = '*MAXIMUM'
     C                   LEAVE
     C                   Endif
      *
     C                   EXSR      SrchComp
     C     IsFound       IFEQ      bTrue
     C                   EVAL      SrchMode = '*FOUND'
      *  ... suchen & pinnen
     C     SrchType      IFEQ      '*PINROW'
     C                   EVAL      Wrk#RcdNbr = File#X.RcdNbr
     C                   EXSR      PinRecord
     C     IsPinOK       IFEQ      bFalse
     C                   LEAVE
     C                   ELSE
      *        weiter suchen und pinnen
     C                   Endif
     C                   ELSE
      *  ... sonstige Suchfunktionen
     C                   LEAVE
     C                   Endif
     C                   Endif
      *
     C                   EVAL      SrchCount2 = SrchCount2 + 1
     C     SrchCount2    IFGE      SrchDspMsg
     C                   EVAL      SrchCount2 = §ZEROS
      *
     C                   Clear                   USR8128
     C                   Eval      USR81281 = SrchCount
     C                   Eval      USR81282 = SrchNbrs
     C                   Callp     p_sndStsMg('USR8128': USR8128)
     C                   Endif
      *
     C                   Enddo
      *
      *  Statuszeile löschen ...
     C                   Callp     p_sndStsMg('USR9999': ' ')
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchComp      Vergleichen der Suchauswahl               *
      *============================================================*
      *
     C     SrchComp      BEGSR
      *
     C                   EVAL      IsFound = bFalse
      *
      *  Im ganzen Datensatz suchen ...
     C     SrchField     IFEQ      '*RECORD'
     C                   EVAL      SrchCmpRcd = IO_Buff
     C                   ELSE
     C                   EXSR      SrchGetCmp
     C                   Endif
      *
      *  Im ganzen Datensatz suchen ...
     C     SrchField     IFEQ      '*RECORD'
     C                   EXSR      SrchComp_R
     C                   ELSE
      *  Im Datenfeld suchen ...
     C                   EXSR      SrchComp_F
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchGetCmp    Dateninhalt aus Datensatz extrahieren     *
      *                  für Vergleich der Suchfunktion            *
      *============================================================*
      *
     C     SrchGetCmp    BEGSR
      *
     C                   IF        srchIsNum = bTrue
     C                   Callp                  f_rtvFld(yBuffer  :
     C                                                   IO_Buff  :
     C                                                   FLDL0100 :
     C                                                   bTrue    )
      *
     C                   Eval      yTgtValue  = ' '
      *
     C                   IF        SrchArgIsFloat = bTrue
     C                   CALLP     PEEK18(FLDL0100: 'FLDL0100': YBuffer:
     C                                    '*FLOAT': '': YOutBuffer: YOutBuffLn
     C                                    : YMsgID: YMsgDta)
      *
     C                   EVAL      SrchCmpFloat = %float(yOutBuffer)
     C                   EVAL      SrchCmpVal   = 0
     C                   ELSE
     C                   CALLP     PEEK18(FLDL0100: 'FLDL0100': YBuffer:
     C                                    '*ZONED': '': YOutBuffer: YOutBuffLn
     C                                    : YMsgID: YMsgDta)
      *
     C                   Eval      SrchCmpStr =
     C                               %subst(YOutBuffer
     C                                      : YOutBuffLn - %len(SrchCmpStr) + 1
     C                                      : YOutBuffLn)
     C                   EVAL      SrchCmpVal = %dec(SrchCmpStr
     C                                               : SRCH_CMP_VAL_LENGTH
     C                                               : SRCH_CMP_VAL_DECPOS)
     C                   EVAL      SrchCmpFloat = 0
     C                   ENDIF
      *
     C                   ELSE
     C                   Callp                  f_rtvFld(SrchCmpStr:
     C                                                   IO_Buff   :
     C                                                   FLDL0100  )
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchComp_R    Suchen im Datensatz                       *
      *============================================================*
      *
     C     SrchComp_R    BEGSR
      *
      *  Nicht Case-Sensitive suchen ...
     C     SrchCase      IFEQ      bFalse
     C     cLOWER:cUPPER XLATE (P) SrchCmpRcd    SrchCmpRcd
      *  Case-Sensitive suchen ...
     C                   Endif
      *
     C                   EVAL      x = %checkr(' ': SrchArg)
     C     X             IFNE      §ZEROS
     C     SrchArg:X     SCAN      SrchCmpRcd:1  X
     C                   ELSE
     C     SrchArg       SCAN      SrchCmpRcd:1  X
     C                   Endif
      *
      *  Gleich ...
     C     SrchOP        IFEQ      'LIKE'
      *  ... nicht gefunden
     C     X             IFEQ      §ZEROS
     C                   EVAL      IsFound = bFalse
     C                   ELSE
      *  ... gefunden
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   ELSE
      *  UnGleich ...
      *  ... nicht gefunden
     C     X             IFEQ      §ZEROS
     C                   EVAL      IsFound = bTrue
     C                   ELSE
      *  ... gefunden
     C                   EVAL      IsFound = bFalse
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchComp_F    Suchen im Feld                            *
      *============================================================*
      *
     C     SrchComp_F    BEGSR
      *
      *  Nicht Case-Sensitive suchen ...
      *  (nur bei nicht numerischer Suche beachten)
     C     SrchCase      IFEQ      bFalse
     C     SrchIsNum     ANDEQ     bFalse
     C     cLOWER:cUPPER XLATE (P) SrchCmpStr    SrchCmpStr
      *  Case-Sensitive suchen ...
     C                   Endif
      *
      *-----------------------*
      *  Vergleichen ...      *
      *-----------------------*
     C                   SELECT
      *  Gleich ...
     C     SrchOP        WHENEQ    'EQ'
     C     SrchIsNum     IFEQ      bFalse
     C     SrchCmpStr    IFEQ      SrchArg
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   ELSE
     C                   IF        (SrchArgIsFloat = bFalse and
     C                              SrchCmpVal = SrchArgVal) or
     C                             (SrchArgIsFloat = bTrue  and
     C                              SrchCmpFloat = SrchArgFloat)
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   Endif
      *  UnGleich ...
     C     SrchOP        WHENEQ    'NE'
     C     SrchIsNum     IFEQ      bFalse
     C     SrchCmpStr    IFNE      SrchArg
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   ELSE
     C                   IF        (SrchArgIsFloat = bFalse and
     C                              SrchCmpVal <> SrchArgVal) or
     C                             (SrchArgIsFloat = bTrue  and
     C                              SrchCmpFloat <> SrchArgFloat)
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   Endif
      *  Größer ...
     C     SrchOP        WHENEQ    'GT'
     C     SrchIsNum     IFEQ      bFalse
     C     SrchCmpStr    IFGT      SrchArg
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   ELSE
     C                   IF        (SrchArgIsFloat = bFalse and
     C                              SrchCmpVal > SrchArgVal) or
     C                             (SrchArgIsFloat = bTrue  and
     C                              SrchCmpFloat > SrchArgFloat)
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   Endif
      *  Kleiner ...
     C     SrchOP        WHENEQ    'LT'
     C     SrchIsNum     IFEQ      bFalse
     C     SrchCmpStr    IFLT      SrchArg
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   ELSE
     C                   IF        (SrchArgIsFloat = bFalse and
     C                              SrchCmpVal < SrchArgVal) or
     C                             (SrchArgIsFloat = bTrue  and
     C                              SrchCmpFloat < SrchArgFloat)
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   Endif
      *  Größer/Gleich ...
     C     SrchOP        WHENEQ    'GE'
     C     SrchIsNum     IFEQ      bFalse
     C     SrchCmpStr    IFGE      SrchArg
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   ELSE
     C                   IF        (SrchArgIsFloat = bFalse and
     C                              SrchCmpVal >= SrchArgVal) or
     C                             (SrchArgIsFloat = bTrue  and
     C                              SrchCmpFloat >= SrchArgFloat)
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   Endif
      *  Kleiner/Gleich ...
     C     SrchOP        WHENEQ    'LE'
     C     SrchIsNum     IFEQ      bFalse
     C     SrchCmpStr    IFLE      SrchArg
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   ELSE
     C                   IF        (SrchArgIsFloat = bFalse and
     C                              SrchCmpVal <= SrchArgVal) or
     C                             (SrchArgIsFloat = bTrue  and
     C                              SrchCmpFloat <= SrchArgFloat)
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   Endif
      *  Ähnlich ...
     C     SrchOP        WHENEQ    'LIKE'
     C     SrchOP        OREQ      'NLIKE'
      *
     C                   SELECT
      *  ...   ('%ABCD')
     C     SrchLikeTp    WHENEQ    1
     C                   EVAL      x = %checkr(' ': SrchCmpStr)
     C                   EVAL      X = X - SrchLikeLn
     C                   EVAL      X = X + 1
     C     X             IFGT      §ZEROS
     C                   EVAL      SrchCmpStr= %subst(SrchCmpStr: x: SrchLikeLn)
     C     SrchCmpStr    IFEQ      SrchArg
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   Endif
      *
      *  ...   ('ABCD%')
     C     SrchLikeTp    WHENEQ    2
     C                   EVAL      SrchCmpStr= %subst(SrchCmpStr: 1: SrchLikeLn)
     C     SrchCmpStr    IFEQ      SrchArg
     C                   EVAL      IsFound = bTrue
     C                   Endif
      *
      *  ...   ('%ABCD%')
     C                   OTHER
     C                   EVAL      X = SrchLikeLn
     C     SrchArg:X     SCAN      SrchCmpStr:1  X
     C     X             IFGT      §ZEROS
     C                   EVAL      IsFound = bTrue
     C                   Endif
      *
     C                   Endsl
      *
      *  ... auswerten IsFound für LIKE/NLIKE
     C     SrchOP        IFEQ      'LIKE'
      *        ... IsFound ist bereits richtig gesetzt.
     C                   ELSE
      *        ... IsFound muß negiert werden ...
     C     IsFound       IFEQ      bTrue
     C                   EVAL      IsFound = bFalse
     C                   ELSE
     C                   EVAL      IsFound = bTrue
     C                   Endif
     C                   Endif
      *
     C                   OTHER
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchInz       Initialisieren der Suchfunktion           *
      *============================================================*
      *
     C     SrchInz       BEGSR
      *
     C                   EVAL      SrchMode = '*NEW'
     C                   EVAL      SrchFndRcd = 0
      *
     C                   EVAL      SrchField = *BLANKS
     C                   EVAL      SrchOP = *BLANKS
     C                   EVAL      SrchArg = *BLANKS
     C                   EVAL      SrchSign = *BLANKS
     C                   EVAL      SrchNbrs = §ZEROS
     C                   EVAL      SrchType = *BLANKS
      *
     C                   EVAL      SrchCmpStr = *BLANKS
     C                   EVAL      SrchCount = §ZEROS
      *
     C                   EVAL      SrchCount = §ZEROS
     C                   EVAL      SrchCount2 = §ZEROS
     C                   EVAL      SrchDspMsg = 1000
      *
     C                   ENDSR
      *
      *============================================================*
      *    CallUpdPgm    Aufrufen Updateprogramm für F6, 2, 3      *
      *============================================================*
      *
     C     CallUpdPgm    BEGSR
      *
     C                   EVAL      IsTryed = bFalse
      *
     C     *IN99         DOUEQ     '0'
      *
     C                   EXSR      GetPgmName
     C                   EXSR      GetDSpName
      *
     C                   Eval      pgmToCall = f_pgmCallN(peekPgm)
      *
     C                   EVAL      YDsp80 = SET_Dsp80
     C                   EVAL      YHeaderTyp = SET_HedTyp
     C                   EVAL      YCopyRight = §CopyRight
      *
     C                   IF        (YFunction = '*ADD')
     C                   EVAL      YRcdNbr = *ZEROS
     C                   ELSE
     C                   EVAL      YRcdNbr = Wrk#RcdNbr
     C                   ENDIF
      *
     C                   EVAL      YFile = File#X.File
     C                   EVAL      YLibrary = File#X.Library
     C                   EVAL      YMember = File#X.Member
     C                   EVAL      YCommitLVL = CommitLVL
     C                   EVAL      YIsUpdKey = isUpdKey
     C                   CALL      pgmToCall     P_PeekPgm              99
      *
     C                   EXSR      ChkHeadChg
      *
      *  Wenn der Programmaufruf
      *  fehlgeschlagen ist, ...                                      RADDAT
     C     *IN99         IFEQ      '1'
      *  ... und kein REBUILD stattgefunden hat, ...                  RADDAT
     C     IsTryed       IFEQ      bFalse
      *      ... dann versuchen, das Programm
      *          neu zu serstellen
     C                   EXSR      C_BuildPgm
     C                   EVAL      IsTryed = bTrue
     C     *IN99         IFEQ      '0'
      *          Wenn das Programm neu erstellt
      *          werden konnte, dann neuen Versuch
      *          unternehmen ...
     C                   EVAL      *IN99 = '1'
     C                   ITER
     C                   ELSE
      *          ... ansonsten abbrechen
     C                   Eval      IsCmdErr = bTrue
     C                   Eval      IsCancel = bTrue
     C                   LEAVE
     C                   Endif
     C                   ELSE
      *  keine weiterer Versuch möglich ...
     C                   LEAVE
     C                   Endif
     C                   ELSE
      *  Der Programmaufruf hat funktioniert
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    ReloadUsrStg  Aktualisieren Benutzereinstellungen       *
      *============================================================*
      *
     C     ReloadUsrStg  BEGSR
      *
     C                   IF        yMsgID = 'USR8100'
     C                   LEAVESR
     C                   ENDIF
      *
     C                   IF        ##FORMAT <> 'FPEEKUSR'
     C                   LEAVESR
     C                   ENDIF
      *
     C                   IF        ##FILE <> §§User
     C                   LEAVESR
     C                   ENDIF
      *
      *  *SPLASH
     C                   Eval      SET0005 = f_getUsrSg('*SPLASH'   )
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBInit        Initialisieren der Subfile zur Anzeige    *
      *                  der nächsten Seite                        *
      *============================================================*
      *
     C     PBINIT        BEGSR
      *
      *  Merker für: Subfile gelöscht setzen
     C                   EVAL      IsPBINIT = bTrue
      *
     C                   EVAL      *IN80 = '0'
     C                   EVAL      *IN81 = '1'
     C                   EVAL      *IN82 = '1'
     C                   EVAL      *IN83 = '1'
     C  N88              WRITE     PBCTL132
     C   88              WRITE     PBCTL080
      *
     C                   EVAL      *IN82 = '0'
      *
     C                   EVAL      SFLREC132 = §ZEROS
     C                   EVAL      SFLREC080 = §ZEROS
      *
     C                   EVAL      SflNbrRcd = §ZEROS
      *
     C                   EVAL      ##RcdNbr = §ZEROS
     C                   EVAL      ##Key = *BLANKS
      *
     C                   EVAL      $$Head132 = SET_HedCol
     C                   EVAL      $$Head080 = SET_HedCOL
      *
      *  Aufbereiten der Überschrift
     C                   EXSR      PBHeadLine
      *
      *  Logischer Schalter für Tabellierung
     C                   EVAL      IsTblCol = bFalse
      *
      *  Konvertieren nicht darstellbarer Zeichen
     C                   EVAL      IsCvtChar = bFalse
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBCsrTRcd     Übersetzen SflCsr ==> rel. Satznummer     *
      *============================================================*
      *
     C     PBCsrTRcd     BEGSR
      *
     C     SflCsr        IFLE      §ZEROS
     C                   EVAL      *IN11 = '1'
     C                   ELSE
     C     *IN88         IFEQ      '0'
     C                   EVAL      SflRec132 = SflCsr
     C     SflRec132     CHAIN     PBSFL132                           11
     C                   ELSE
     C                   EVAL      SflRec080 = SflCsr
     C     SflRec080     CHAIN     PBSFL080                           11
     C                   Endif
     C                   Endif
      *
     C     *IN11         IFEQ      '1'
     C                   EVAL      Wrk#RcdNbr = §ZEROS
     C                   ELSE
     C                   EVAL      Wrk#RcdNbr = RECORDNBR
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    InitSCmd      Initialisieren Kurzbefehl                 *
      *============================================================*
      *
     C     InitSCmd      BEGSR
      *
     C                   CLEAR                   shortCmd
     C                   EVAL      ShortCmd.SC_Action = '*INIT'
     C                   EVAL      ShortCmd.SC_File = ##File
     C                   EVAL      ShortCmd.SC_Lib = ##Library
     C                   EVAL      ShortCmd.SC_Mbr = ##Member
     C                   CALLP     PEEK42(H_FILE: H_LIB: H_MBR: H_RCDFMT
     C                                    : ShortCmd: Wrk#RcdNbr: YExecCmd
     C                                    : YMsgID: YMsgDta)
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBReadUP      Vorwärts füllen der Subfile               *
      *============================================================*
      *
     C     PBReadUP      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   ELSE
      *
      *  Erster Datensatz in Subfile ...
     C                   EVAL      IsFirstSfl = bTrue
      *
     C                   DO        *HIVAL
     C                   EXSR      PBRead
     C     IsEOF         IFEQ      bTrue
     C                   EVAL      *IN83 = '1'
     C                   LEAVE
     C                   ELSE
     C                   EVAL      *IN83 = '0'
     C                   Endif
      *
     C  N88              ADD       1             SFLRec132
     C   88              ADD       1             SFLRec080
      *
     C     SFLRec132     IFGT      9999
     C     SFLRec080     ORGT      9999
     C                   EVAL      *IN83 = '1'
     C                   EXSR      PBReadP
     C                   LEAVE
     C                   Endif
      *
     C     SFLRec132     IFGT      SflPage
     C     SFLRec080     ORGT      SflPage
     C                   EXSR      PBReadP
     C                   LEAVE
     C                   Endif
      *
     C                   EXSR      PBFillRigh
      *
     C                   EXSR      PBSflWrite
      *
     C  N88              Z-ADD     SflRec132     SflNbrRcd
     C   88              Z-ADD     SflRec080     SflNbrRcd
      *
      *  Setzen Cursor auf gefundenen Datensatz
     C     SrchFndRcd    IFEQ      RECORDNBR
     C  N88              Z-ADD     SflRec132     SFSANR
     C   88              Z-ADD     SflRec080     SFSANR
     C                   Endif
      *
      *  Aufbereiten Aufsetzkey bei 1. geschriebendem Datensatz
     C     IsFirstSfl    IFEQ      bTrue
     C                   EXSR      PBGenKey
     C                   Endif
      *
      *  Tabellierpapierfarben umschalten ...
     C     SET_TblMde    IFEQ      bFalse
      *         Modus ist ausgeschaltet
     C                   ELSE
     C     IsTblCol      IFEQ      bFalse
     C                   EVAL      IsTblCol = bTrue
     C                   ELSE
     C                   EVAL      IsTblCol = bFalse
     C                   Endif
     C                   Endif
      *
      *  ... 1. Datensatz ist fertig
     C                   EVAL      IsFirstSfl = bFalse
      *
     C                   Enddo
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBReadDn      1 Bildschirmseite rückwärts lesen         *
      *============================================================*
      *
     C     PBReadDn      BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   ELSE
      *
     C                   EVAL      Wrk#ReadDn = Wrk#ReadDn + SflPage
     C                   EVAL      Wrk#ReadDn = Wrk#ReadDn - NbrPinRcd
      *
     C     1             DO        Wrk#ReadDn
     C                   EXSR      PBReadP
     C     IsEOF         IFEQ      bTrue
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
     C                   Endif
      *
     C                   EVAL      Wrk#ReadDn = §ZEROS
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBReadCsr     Setzen Dateizeiger auf aktuelle           *
      *                  Cursor-Position  (SflCsr)                 *
      *============================================================*
      *
     C     PBReadCsr     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   ELSE
     C     SflCsr        IFEQ      §ZEROS
      *      Nix tun, keine Datei vorhanden
     C                   ELSE
      *
     C                   EVAL      Wrk#ReadDn = SflNbrRcd - SflCsr
     C                   EVAL      Wrk#ReadDn = Wrk#ReadDn + 1
     C                   EXSR      PBMoveCsrD
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBReadCsrA    Read to Cursor, after                     *
      *                  Setzen Dateizeiger auf aktuelle           *
      *                  Cursor-Position  +1  (SflCsr+1)           *
      *============================================================*
      *
     C     PBReadCsrA    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
     C     SflCsr        IFEQ      §ZEROS
      *      Nix tun, keine Datei vorhanden
     C                   ELSE
      *
     C                   EVAL      Wrk#ReadDn = SflNbrRcd - SflCsr
     C                   EXSR      PBMoveCsrD
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBMoveCsrD    Verschieben Dateizeiger (Richtung BOF)    *
      *============================================================*
      *
     C     PBMoveCsrD    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   ELSE
      *
     C     1             DO        Wrk#ReadDn
     C                   EXSR      PBReadP
     C     IsEOF         IFEQ      bTrue
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
     C                   Endif
      *
     C                   EVAL      Wrk#ReadDn = §ZEROS
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBPinCol      Füllen Subfile mit pinned Spalten         *
      *============================================================*
      *
     C     PBPinCol      BEGSR
      *
     C                   EVAL      IsPinModeC = bTrue
      *
      *  Eintragen der gepinnten Spalten ...
     C     1             DO        NbrPinCol     PinXC
     C     DataStr       IFGT      DataMax
     C     DataStr       ORGT      SflDataLen
     C                   LEAVE
     C                   Endif
      *
     C     DataStr       IFGT      SflPinRnge
      *       Benutzer benachrichtigen
     C                   EVAL      §MsgID = 'USR8148'
     C                   EVAL      §MsgDta = PinTabC(PinXC)
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *       Eintrag austragen
     C                   EXSR      RmvPinCol
     C     IsPinRmv      IFEQ      bTrue
     C                   EVAL      PinXC = PinXC - 1
     C                   Endif
     C                   ITER
     C                   Endif
      *
      *  ... einlesen der Felddaten
     C                   EVAL      F_Field = PinTabC(PinXC)
     C     F_Key         CHAIN (N) FPEEKFLD                           11
     C     *IN11         IFEQ      '1'
      *           Eintrag austragen
     C                   EXSR      RmvPinCol
     C     IsPinRmv      IFEQ      bTrue
     C                   EVAL      PinXC = PinXC - 1
     C                   Endif
     C                   ITER
     C                   Endif
      *
      *  ... Feld nicht anzeigen
     C     F_HIDDEN      IFEQ      bTrue
     C                   ITER
     C                   Endif
      *
     C                   EXSR      PBReadFld1
     C     IsError       IFEQ      bTrue
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
     C                   EVAL      IsPinModeC = bFalse
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBPinRcd      Füllen Subfile mit pinned Datensätzen     *
      *============================================================*
      *
     C     PBPinRcd      BEGSR
      *
     C                   EVAL      IsPinModeR = bTrue
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   ELSE
      *
     C     1             DO        MaxPinRcd     PinXR
     C                   EVAL      PIN#DS = PinTabR(PinXR)
     C                   IF        PIN#DS.RCDNBR = §ZEROS
     C                   LEAVE
     C                   Endif
      *
     C                   IF        f_chain04(PIN#DS.RCDNBR :
     C                                       PIN#DS.FILE   :
     C                                       PIN#DS.LIB    :
     C                                       PIN#DS.MBR    :
     C                                       PIN#DS.RCDFMT ) = '1'
      *           Eintrag austragen
     C                   EXSR      RmvPinRcd
     C                   IF        IsPinRmv = bTrue
     C                   EVAL      PinXR = PinXR - 1
     C                   Endif
     C                   ITER
     C                   Endif
      *
     C                   EXSR      PBFillRigh
      *
     C                   EVAL      SFLRec132 = SFLRec132 + 1
     C                   EVAL      SFLRec080 = SFLRec080 + 1
      *
     C                   EXSR      PBSflWrite
      *
     C  N88              Z-ADD     SflRec132     SflNbrRcd
     C   88              Z-ADD     SflRec080     SflNbrRcd
      *
     C                   Enddo
      *
     C                   Endif
      *
     C                   EVAL      IsPinModeR = bFalse
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkPinRcd     Prüfen, ob Datensatz gepinned ist         *
      *============================================================*
      *
     C     ChkPinRcd     BEGSR
      *
     C                   EVAL      PinXR = 1
     C                   EVAL      PIN#DS.RCDNBR = Wrk#RcdNbr
     C                   EVAL      PIN#DS.FILE = H_FILE
     C                   EVAL      PIN#DS.LIB = H_LIB
     C                   EVAL      PIN#DS.MBR = H_MBR
     C                   EVAL      PIN#DS.RCDFMT = H_RCDFMT
     C                   EVAL      PIN#DS.MBRNBR = H_MBRNBR
     C                   EVAL      pinXR = %lookup(PIN#DS: PinTabR: PinXR)
     C                   IF        (PinXR > 0)
     C                   EVAL      IsPinned = bTrue
     C                   ELSE
     C                   EVAL      IsPinned = bFalse
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkPinCol     Prüfen, ob Spalte gepinned ist            *
      *============================================================*
      *
     C     ChkPinCol     BEGSR
      *
     C                   EVAL      PinXC = 1
     C                   EVAL      PinXC = %lookup(Pin#Field: PinTabC: PinXC)
     C                   IF        (PinXC > 0)
     C                   EVAL      IsPinned = bTrue
     C                   ELSE
     C                   EVAL      IsPinned = bFalse
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    RmvPinRcd     Austragen Datensatz aus PinTabR           *
      *============================================================*
      *
     C     RmvPinRcd     BEGSR
      *
     C                   EVAL      IsPinRmv = bFalse
      *
      *  Remove pinned record from table
     C     PinXR         DO        MaxPinRcd     Y
     C                   EVAL      Z = Y + 1
     C                   CLEAR                   PIN#DS
     C     Z             IFLE      MaxPinRcd
     C                   EVAL      PinTabR(Y) = PinTabR(Z)
     C                   EVAL      PinTabR(Z) = PIN#DS
     C                   ELSE
     C                   EVAL      PinTabR(Y) = PIN#DS
     C                   Endif
     C                   EVAL      IsSflDirty = bTrue
     C                   EVAL      IsPinRmv = bTrue
     C                   Enddo
      *
      *  Detrmine number of pinned records
      *  (find first free record)
     C                   EVAL      X = 1
     C                   CLEAR                   PIN#DS
     C                   EVAL      x = %lookup(PIN#DS: PinTabR: x)
     C                   IF        (x > 0)
     C                   EVAL      NbrPinRcd = X - 1
     C                   ELSE
     C                   EVAL      NbrPinRcd = MaxPinRcd
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    RmvPinCol     Austragen Feld aus PinTabC                *
      *============================================================*
      *
     C     RmvPinCol     BEGSR
      *
     C                   EVAL      IsPinRmv = bFalse
      *
     C     PinXC         DO        MaxPinCol     Y
     C                   EVAL      Z = Y + 1
     C     Z             IFLE      MaxPinCol
     C                   EVAL      PinTabC(Y) = PinTabC(Z)
     C                   EVAL      PinTabC(Z) = *BLANKS
     C                   ELSE
     C                   EVAL      PinTabC(Y) = *BLANKS
     C                   Endif
     C                   EVAL      IsSflDirty = bTrue
     C                   EVAL      IsPinRmv = bTrue
     C                   Enddo
      *
     C                   EVAL      X = 1
     C                   EVAL      Pin#Field = *BLANKS
     C                   EVAL      x = %lookup(Pin#Field: PinTabC: x)
     C                   IF        (x > 0)
     C                   EVAL      NbrPinCol = X - 1
     C                   ELSE
     C                   EVAL      NbrPinCol = MaxPinCol
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBRefresh     Aktualisieren der Subfile                 *
      *============================================================*
      *
     C     PBRefresh     BEGSR
      *
     C                   EVAL      Wrk#ReadDn = SflNbrRcd - SflPage
     C                   EXSR      PBReadDn
     C                   EXSR      PBInit
     C                   EXSR      PBPinRcd
     C                   EXSR      PBReadUp
      *
      *  Evtl. ist die Subfile doch nicht leer ...
      *  (letzter Satz in der Liste wurde gelöscht oder
      *   der Schlüssel wurde geändert)
     C     *IN80         IFEQ      '0'
     C                   EXSR      C_Bot
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBHeadLine    Aufbereiten der Überschriftenzeile        *
      *                  und füllen Tabelle mit anzuzeigenden      *
      *                  Feldern                                   *
      *============================================================*
      *
     C     PBHeadLine    BEGSR
      *
      *  Löschen der Überschrift
     C                   EVAL      $$Head132 = *BLANKS
     C                   EVAL      $$Head080 = *BLANKS
      *
     C                   if        not %open(PEEKFLDL1)
      *  Keine Datei geöffnet
     C                   leavesr
     C                   endif
      *
      *  Löschen Tabelle mit Feldpositionen ...
     C                   EXSR      clrFldArray
      *
      *  Aufbereiten Pseudo-Datensatz
     C                   CALLP     PEEK20('*PHIVAL': IO_Buff: YMsgID: YMsgDta)
      *
     C     YMsgID        IFEQ      *BLANKS
      *
      *  Füllen der Überschriftenzeile ...
     C                   EVAL      SflMode = '*HEADLINE'
     C                   EVAL      Wrk#SeqNbr = ##WndNbr
     C                   EXSR      PBFill_R
      *
      *  Übertragen der Überschriftenzeile
      *  in Bildschirmfeld ...
     C                   Eval      $$Head132 = DataElems
     C                   Eval      $$Head080 = DataElems
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBFillLeft    Füllen einer Datenzeile von rechts        *
      *                  nach links.                               *
      *============================================================*
      *
     C     PBFillLeft    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *  Keine Datei geöffnet
     C                   ELSE
      *
      *  Löschen Tabelle mit Feldpositionen ...
     C                   exsr      clrFldArray
      *
      *  Aufbereiten Pseudo-Datensatz
     C                   CALLP     PEEK20('*PHIVAL': IO_Buff: YMsgID: YMsgDta)
      *
     C     YMsgID        IFEQ      *BLANKS
      *
      *  Füllen der Überschriftenzeile ...
     C                   EVAL      SflMode = '*HEADLINE'
     C                   EVAL      Wrk#SeqNbr = ##WndNbr
     C                   EXSR      PBFill_L
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBFillRigh    Füllen einer Datenzeile von rechts        *
      *                  nach links.                               *
      *============================================================*
      *
     C     PBFillRigh    BEGSR
      *
     C                   Callp     f_basedPF(File#X.File   :
     C                                       File#X.Library:
     C                                       File#X.Member :
     C                                       File#X.RcdFmt :
     C                                       File#X.MbrNbr :
     C                                       H_FILE        :
     C                                       H_LIB         :
     C                                       H_MBR         :
     C                                       H_RCDFMT      )
      *
     C                   EVAL      SFPAU = *BLANKS
     C                   EVAL      H_MBRNBR = File#X.MbrNbr
     C                   EVAL      RECORDNBR = File#X.RcdNbr
      *
      *  Prüfen auf Suchfunktion:
      *  *NORMAL/*REVERSE
     C                   EVAL      IsFound = bFalse
      *
     C     SrchField     IFNE      *BLANKS
     C     SrchType      IFEQ      '*REVERSE'
     C     SrchType      OREQ      '*UNDERLINE'
     C                   EXSR      SrchFldAtr
     C                   EXSR      SrchComp
     C                   Endif
     C                   Endif
      *
      *  Füllen der Datenzeile ...
     C                   EVAL      SflMode = '*DATA'
     C                   EVAL      Wrk#SeqNbr = ##WndNbr
     C                   EXSR      PBFill_R
      *
      *  Übertragen der Datenzeile in
      *  Bildschirmfeld ...
     C                   Eval      Data132 = DataElems
     C                   Eval      Data080 = DataElems
      *
      *  ... anzeigen der Subfile
     C                   EVAL      *IN80 = '1'
      *
      *  ... Subfile-Satz nicht auswählen
     C                   EVAL      *IN84 = '0'
     C                   EVAL      *IN85 = '0'
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBFill_R      Lesen der anzuzeigenden Felder und        *
      *                  aufbereiten der Überschrift oder der      *
      *                  Datenzeile, von links nach rechts         *
      *============================================================*
      *
     C     PBFill_R      BEGSR
      *
      *  Löschen Datentabelle ...
     C                   CLEAR                   Data
     C                   EVAL      DataStr = 1
      *
      *  Eintragen gepinnter Spalten ...
     C                   EXSR      PBPinCol
      *
      *  Eintragen der Feldinhalte ...
     C                   EVAL      F_Seq = Wrk#SeqNbr
     C     F1KEY_L1      SETLL     FPEEKFLDL1
      *
     C     DataStr       DOWLE     DataMax
     C     DataStr       ANDLE     SflDataLen
     C                   READ      FPEEKFLDL1                             11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
      *  ... Feld anzeigen?
     C                   EVAL      Wrk#Field = F_Field
     C                   EXSR      ChkVisible
     C     IsVisible     IFEQ      bFalse
     C                   ITER
     C                   Endif
      *
     C                   EXSR      PBReadFld1
     C     IsError       IFEQ      bTrue
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBFill_L      Lesen der anzuzeigenden Felder und        *
      *                  aufbereiten der Überschrift oder der      *
      *                  Datenzeile, von rechts nach links         *
      *============================================================*
      *
     C     PBFill_L      BEGSR
      *
      *  Löschen Datentabelle ...
     C                   CLEAR                   Data
     C                   EVAL      DataStr = 1
      *
      *  Eintragen gepinnter Spalten ...
     C                   EXSR      PBPinCol
      *
      *  Eintragen der Feldinhalte ...
     C                   EVAL      F_Seq = Wrk#SeqNbr
     C     F1KEY_L1      SETGT     FPEEKFLDL1
      *
     C     DataStr       DOWLE     DataMax
     C     DataStr       ANDLE     SflDataLen
     C                   READP     FPEEKFLDL1                             11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
      *  ... Feld anzeigen?
     C                   EVAL      Wrk#Field = F_Field
     C                   EXSR      ChkVisible
     C     IsVisible     IFEQ      bFalse
     C                   ITER
     C                   Endif
      *
     C                   EXSR      PBReadFld1
     C     IsError       IFEQ      bTrue
     C                   LEAVE
     C                   Endif
      *
     C     ##StrPage     IFGT      1
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBReadFld1    Hilfsroutine für PBReadFld                *
      *============================================================*
      *
     C     PBReadFld1    BEGSR
      *
      *  umsetzen der Daten in die Job CCSID
     C                   IF        SflMode = '*HEADLINE'
     C                   EVAL      YCvtCcsid = bFalse
     C                   ELSE
     C                   EVAL      YCvtCcsid = bTrue
     C                   ENDIF
      *
      *  löschen Ausnahmebedingung für Spalte
     C                   EVAL      IsColExc = bFalse
      *
      *  merken Position für Farbattribut
     C     DataStr       IFLE      DataMax
     C                   EVAL      ColrOfs = DataStr
     C                   EVAL      DataStr = DataStr + 1
     C                   ELSE
     C                   EVAL      ColrOfs = §ZEROS
     C                   Endif
      *
      *  aufbereiten des Feldinhaltes
      *  für Anzeigeformat gemäß EDITCODE ...
     C                   EVAL      FLDL0100 = F_FFD
     C     F_EDTCDE      IFNE      *BLANKS
     C                   EVAL      FLDL0100.F1EDTC = F_EDTCDE
     C                   ELSE
      *  ... Original EDITCODE verwenden
     C                   Endif
      *
     C                   Monitor
      *  umsetzen Datensatzpuffer in Bildschirmdarstellung ...
     C     SET_DspMde    IFEQ      '*DSPNRM'
      *  ... für Normale Anzeige
     C                   IF        IO_NullMap(FLDL0100.F1SEQ) = 1
     C                   CALLP     PEEK06(FLDL0100: 'FLDL0100': *ALLx'00'
     C                                    : bFalse: YCvtCcsid
     C                                    : YOutBuffer: yOutBuffLn
     C                                    : yMsgId: yMsgDta)
     C                   IF        f_isNumFld(FLDL0100) = bTrue
     C                   IF        YOutBuffLn > 1
     C                   EVAL      %subst(yOutBuffer: 1: YOutBuffLn - 1) = ''
     C                   ENDIF
     C                   EVAL      %subst(yOutBuffer
     C                                    : YOutBuffLn
     C                                    : %len(§HEX_CHAR)) = §HEX_CHAR
     C                   ELSE
     C                   EVAL      yOutBuffer = §HEX_CHAR
     C                   ENDIF
     C                   ELSE
     C                   CALLP     PEEK06(FLDL0100: 'FLDL0100': IO_Buff
     C                                    : bFalse: YCvtCcsid
     C                                    : YOutBuffer: yOutBuffLn
     C                                    : yMsgId: yMsgDta)
     C                   ENDIF
      *
     C                   ELSE
      *  ... für Hex-Anzeige
     C                   IF        IO_NullMap(FLDL0100.F1SEQ) = 1
     C                   EVAL      yHexString = §HEX_CHAR
     C                   EVAL      YStringLen = f_buffLn(FLDL0100)
     C                   ELSE
     C                   Eval      YStringLen = f_rtvFld(yString  :
     C                                                   IO_Buff  :
     C                                                   FLDL0100 )
     C                   eval      yHexString = ' '
     C                   Callp     p_hexToChr(yHexString    :
     C                                        yString       :
     C                                        yStringLen * 2)
     C                   Endif
      *
     C                   Eval      YOutBuffLn = yStringLen * 2
     C                   Endif
     C                   Eval      *in99 = bFalse
     C                   On-Error
     C                   Eval      *in99 = bTrue
     C                   Endmon
      *
      *  Fehler bei der Aufbereitung ...
     C     *IN99         IFEQ      '1'
      *  ... ja
     C                   EVAL      IsError = bTrue
     C                   ELSE
      *  ... nein
     C                   EVAL      IsError = bFalse
      *
      *  ermitteln der Spaltenbreite
      *  anhand der Überschrift und
      *  der Feldlänge, sowie der
      *  maximalen Spaltenbreite ...
     C                   EVAL      FLDL0100 = F_FFD
     C                   EVAL      ColumnLen = §ZEROS
     C                   EVAL      FieldLen = YOutBuffLn
     C                   EVAL      MaxColLen = F_MaxSize
      *
      *  Konvertierung nicht darstellbarer Zeichen ...
     C     SflMode       IFEQ      '*HEADLINE'
     C     SET_DspMde    OREQ      '*DSPHEX'
      *  ... keine Konvertierung bei der
      *      Aufbereitung der Überschriftenzeile
     C                   ELSE
      *  ... sonst konvertieren
     C                   monitor
     C                   callp     PEEK32(YOutBuffer: YOutBuffLn: 0
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C     *IN99         IFEQ      '0'
     C     IsCvtChar     IFEQ      bFalse
     C     YMsgID        IFNE      *BLANKS
     C                   EVAL      IsCvtChar = bTrue
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *         keine Nachricht anstehend
     C                   Endif
     C                   ELSE
      *         Nachricht bereits gesendet
     C                   Endif
     C                   ELSE
      *         Fehler bei Programmaufruf
     C                   Endif
     C                   Endif
      *
      *  Bestimmen Länge der Überschrift
      *  und aufbereiten Überschrift ...
     C                   EVAL      colHeading = f_headline(SET_HedTyp: FLDL0100)
     C                   EVAL      HeadLen = %checkr(' ': colHeading)
      *
     C                   If        (SflMode = '*HEADLINE')
     C                   Eval      YHexString = colHeading
     C                   Endif
      *
     C                   Eval      colHeading = ''
      *
      *  ... Bestimmen der Spaltenbreite
     C     HeadLen       IFGT      FieldLen
     C                   EVAL      ColumnLen = HeadLen
     C                   ELSE
     C                   EVAL      ColumnLen = FieldLen
     C                   Endif
      *
     C     ColumnLen     IFGT      MaxColLen
     C                   EVAL      ColumnLen = MaxColLen
     C                   Endif
      *
      *  ... numerische Werte rechtsbündig setzen,
      *      wenn Spaltenbereite kleiner als Feldlänge
     C                   IF        (SflMode   = '*HEADLINE')
      *
      *      ... für die Überschrift
     C                   IF        (ColumnLen < HeadLen ) or
     C                             (ColumnLen < FieldLen)
      *
     C                   SELECT
     C                   WHEN      (HeadLen + 3) <= ColumnLen
     C                   EVAL      %subst(YHexString: HeadLen + 1: 3)
     C                             = %subst('...': 1: 3)
     C                   OTHER
     C                   EVAL      %subst(YHexString: ColumnLen - 2 + 1: 2)
     C                             = %subst('...': 1: 2)
     C                   Endsl
      *
     C                   Endif
      *
     C                   ELSE
      *
      *      ... für die Datenzeile
     C                   IF        (SflMode   <> '*HEADLINE') and
     C                             (ColumnLen <  Fieldlen   )
      ***                EXSR      ChkNumeric
     C                   IF        f_isNumFld(FLDL0100) = bTrue
      *          ... numerische Werte
     C                   IF        (SET_EnExc = bTrue) and
     C                             (%subst(YHexString          :
     C                                     1                   :
     C                                     FieldLen - ColumnLen) <> *BLANKS)
     C                   EVAL      IsColExc = bTrue
     C                   Endif
     C                   Eval      YHexString = %subst(YHexString              :
     C                                                 1 + FieldLen - ColumnLen:
     C                                                 ColumnLen               )
     C                   ELSE
      *          ... alphanumerische Werte
     C                   IF        (SET_EnExc = bTrue) and
     C                             (%subst(YHexString              :
     C                                     ColumnLen + 1           :
     C                                     1 + FieldLen - ColumnLen) <> *BLANKS)
     C                   EVAL      IsColExc = bTrue
     C                   Endif
     C                   Endif
      *
     C                   Endif
     C                   Endif
      *
      *  ... Berechnen der Startposition im Puffer
     C                   Eval      SflDataLenFree = SflDataLen - DataStr + 1
      *
     C                   IF        (##WndNbr = F_Seq)
      *
     C                   IF        (##StrPage * SflDataLenFree) > Columnlen
      *
     C                   IF        (Columnlen / SflDataLenFree) =
     C                             f_int(Columnlen / SflDataLenFree)
     C                   Eval      ##StrPage = (Columnlen / SflDataLenFree)
     C                   ELSE
     C                   Eval      ##StrPage = (Columnlen / SflDataLenFree) + 1
     C                   Endif
      *
     C                   Endif
      *
     C                   Eval      FldStrPos = (##StrPage -1) * SflDataLenFree
     C                                         + 1
     C                   Else
     C                   Eval      FldStrPos = 1
     C                   Endif
      *
      *  ... Berechnen der zu extrahierenden Länge
     C                   EVAL      BuffIdx = FldStrPos
     C                   EVAL      DataEnd = DataStr + ColumnLen
     C                   EVAL      DataEnd = DataEnd - FldStrPos
      *
     C                   IF        DataEnd > DataMax
     C                   EVAL      DataEnd = DataMax
     C                   Endif
      *
     C                   Eval      DataLen = DataEnd - DataStr + 1
      *
      *  ... übertragen aufbereitetes Feld in Subfile
     C                   Eval      %subst(DataDS: DataStr) =
     C                             %subst(YHexString: BuffIdx: DataLen)
      *
      *  ... pflegen der Tabelle mit den Werten der
      *      Spaltenaufteilung ...
     C     DataEnd       IFGE      DataStr
      *      ... pflegen der Feldpositionstabelle
     C     SflMode       IFEQ      '*HEADLINE'
     C                   EVAL      CP = CP + 1
     C                   EVAL      Col_Field(CP) = FLDL0100.F1FNme
     C                   EVAL      Col_ScnStr(CP) = DataStr
     C                   EVAL      Col_ScnEnd(CP) = DataEnd
      *          ... ist das Feld komplett sichtbar?
     C                   IF        (Col_ScnEnd(CP) <= SflDataLen)
      *              ... ja, kein Fehler
     C                   EVAL      Col_Error(CP) = bFalse
     C                   ELSE
      *              ... nein, Fehler!
     C                   EVAL      Col_Error(CP) = bTrue
     C                   Endif
     C                   Endif
      *
     C                   EVAL      DataStr = DataEnd + 1
      *
      *      ... Löschen von "überstehendem" Datenmüll
     C     ColumnLen     IFEQ      MaxColLen
     C     DataStr       ANDLE     DataMax
     C                   EVAL      Data(DataStr) = ''
     C                   Endif
      *
      *      ... umschalten auf "normale" Farbdarstellung
     C     DataStr       IFLE      DataMax
     C                   EVAL      Wrk#Ofs = DataStr
     C                   EXSR      PBStdCol
     C                   Endif
      *
      *      ... "nachziehen" der Spaltenfarbe
     C     ColrOfs       IFLE      §ZEROS
      *          ... Pech gehabt
     C                   ELSE
     C     SflMode       IFEQ      '*HEADLINE'
     C                   IF        (F_KSEQ = 0) or
     C                             (AccessMode = §RrnSeq)
     C                   EVAL      Data(ColrOfs) = SET_HedCol
     C                   ELSE
     C                   EVAL      Data(ColrOfs) = SET_KeyCol
     C                   Endif
     C                   ELSE
     C                   EXSR      PBColor
     C                   Endif
     C                   Endif
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBStdCol      Setzen der "normalen" Datensatzfarbe      *
      *============================================================*
      *
     C     PBStdCol      BEGSR
      *
     C     IsTblCol      IFEQ      bFalse
     C                   EVAL      Data(Wrk#Ofs) = SET_StdCol
     C                   ELSE
     C                   EVAL      Data(Wrk#Ofs) = SET_TblCol
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBGenKey      Generieren Aufsetzkey                     *
      *                  für die Anzeige auf dem Bildschirm        *
      *============================================================*
      *
     C     PBGenKey      BEGSR
      *
     C     AccessMode    IFEQ      §KeySeq
     C                   EXSR      PBBuildKey
     C                   ELSE
     C                   EXSR      PBBuildRrn
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBBuildRrn    Generieren Aufsetzkey: RRN                *
      *============================================================*
      *
     C     PBBuildRrn    BEGSR
      *
     C                   EVAL      ##RcdNbr = RECORDNBR
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBBuildKey    Generieren Aufsetzkey                     *
      *============================================================*
      *
     C     PBBuildKey    BEGSR
      *
     C                   monitor
     C                   CALLP     PEEK19(IO_Buff: YKeyVal: YMsgID: YMsgDta)
      *
      *  ... Konvertieren nicht darstellbarer Zeichen
     C                   EVAL      YOutBuffer = YKeyVal
     C                   EVAL      YOutBuffLn = 132
      *
     C                   callp     PEEK32(YOutBuffer: YOutBuffLn: 0
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C                   EVAL      ##Key = YOutBuffer
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBGenIntKy    Generieren internen Aufsetzkey            *
      *                  für einen Dateizugriff                    *
      *============================================================*
      *
     C     PBGenIntKy    BEGSR
      *
     C     AccessMode    IFEQ      §KeySeq
     C                   EXSR      PBIntKey
     C                   ELSE
     C                   EXSR      PBIntRrn
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBIntRrn      Generieren interne Satznummer             *
      *============================================================*
      *
     C     PBIntRrn      BEGSR
      *
     C                   EVAL      Wrk#RcdNbr = Wrk#RcdNbr
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBIntKey      Generieren internen Aufsetzschlüssel      *
      *============================================================*
      *
     C     PBIntKey      BEGSR
      *
     C                   CALLP     PEEK20(Wrk#KeyVal: yBuffer
     C                                    : YMsgID: YMsgDta)
     C                   EVAL      Wrk#KeyVal = yBuffer
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBColor       Setzen der Spaltenfarbe                   *
      *                  für Datenzeilen                           *
      *                  a) für gepinnte Datensätze                *
      *                  b) für normale Datensätze                 *
      *============================================================*
      *
     C     PBColor       BEGSR
      *
     C                   IF        ColrOfs = §ZEROS
      *                 Nix tun
     C                   ELSE
      *
     C                   IF        IsColExc = bTrue
     C                   EVAL      Data(ColrOfs) = SET_ExcCol
     C                   ELSE
      *
      *---------------------------------------*
      *  Berücksichtigen des Aufrufs von:     *
      *  a) anzeigen "normaler" Datensätze    *
      *  b) anzeigen "gepinnter" Datensätze   *
      *---------------------------------------*
     C     IsPinModeR    IFEQ      bFalse
     C     IsPinModeC    IFEQ      bFalse
      *      ... nix ist gepinnt
     C                   EVAL      IsPinned = bFalse
     C                   ELSE
      *      ... prüfen auf gepinnte Spalten
     C                   EVAL      Pin#Field = FLDL0100.F1FNme
     C                   EXSR      ChkPinCol
     C                   Endif
     C                   ELSE
      *      ... prüfen auf gepinnte Zeilen (=Datensätze)
     C                   EVAL      Wrk#RcdNbr = RECORDNBR
     C                   EXSR      ChkPinRcd
     C                   Endif
      *
      *---------------------------------------*
      *  ... setzen der Datenfarbe            *
      *---------------------------------------*
      *  Spaltenmarkierung ...
     C     F_MarkCol     IFEQ      bTrue
     C                   EVAL      Data(ColrOfs) = F_Color
     C                   ELSE
      *  Keine Spaltenmarkierung ...
     C     IsPinned      IFEQ      bTrue
      *      ... pinned Datensatz
     C                   EVAL      Data(ColrOfs) = SET_PinCol
     C                   ELSE
      *      ... normaler Datensatz
     C                   EVAL      Wrk#Ofs = ColrOfs
     C                   EXSR      PBStdCol
     C                   Endif
     C                   Endif
      *
      *---------------------------------------*
      *  ... Datensatz gefunden               *
      *---------------------------------------*
     C     IsPinned      IFEQ      bFalse
     C                   SELECT
      *      ... Suchfunktionen: *REVERSE
     C     SrchType      WHENEQ    '*REVERSE'
     C     IsFound       IFEQ      bTrue
     C                   EVAL      Data(ColrOfs) = SET_RevCol
     C                   Endif
      *
      *      ... Suchfunktionen: *UNDERLINE
     C     SrchType      WHENEQ    '*UNDERLINE'
     C     IsFound       IFEQ      bTrue
     C                   EVAL      Data(ColrOfs) = SET_UndCol
     C                   Endif
      *
      *      ... Suchfunktionen: *NORMAL
     C     SrchType      WHENEQ    '*NORMAL'
     C     SrchFndRcd    IFEQ      RECORDNBR
     C                   EVAL      Data(ColrOfs) = SET_NmlCol
     C                   Endif
      *
     C                   OTHER
      *       Andere Suchtypen gibt's nicht
     C                   Endsl
     C                   Endif
      *
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSetLL       Setzen Dateizeiger RRN/KEY                *
      *============================================================*
      *
     C     PBSetLL       BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   ELSE
      *
     C                   Select
     C     AccessMode    WhenEQ    §KeySeq
     C                   Callp     CIO_setllWithKey(hFile02: Wrk#KeyVal)
     C                   EXSR      F2toFx
     C     AccessMode    WhenEQ    §RrnSeq
     C                   Callp     CIO_setllWithRRN(hFile01: Wrk#RcdNbr)
     C                   EXSR      F1toFx
     C     AccessMode    WhenEQ    §SqlSeq
     C                   Other
     C                   Endsl
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSetGT       Setzen Dateizeiger RRN/KEY                *
      *============================================================*
      *
     C     PBSetGT       BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   ELSE
      *
     C                   Select
     C     AccessMode    WhenEQ    §KeySeq
     C                   Callp     CIO_setgtWithKey(hFile02: Wrk#KeyVal)
     C                   EXSR      F2toFx
     C     AccessMode    WhenEQ    §RrnSeq
     C                   Callp     CIO_setgtWithRRN(hFile01: Wrk#RcdNbr)
     C                   EXSR      F1toFx
     C     AccessMode    WhenEQ    §SqlSeq
     C                   Other
     C                   Endsl
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBMoveTop     Setzen Dateizeiger auf BOF                *
      *============================================================*
      *
     C     PBMoveTop     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   ELSE
      *
     C     AccessMode    IFEQ      §SqlSeq
     C                   Callp     SQL_gotoTop(§MsgID: §MsgDta)
     C                   ELSE
     C                   EVAL      Wrk#KeyVal = '*LOVAL'
     C                   EVAL      Wrk#RcdNbr = §LowRcdNbr
      *
     C                   EXSR      PBGenIntKy
     C                   EXSR      PBSetLL
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBMoveBot     Setzen Dateizeiger auf EOF                *
      *============================================================*
      *
     C     PBMoveBot     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   ELSE
      *
     C     AccessMode    IFEQ      §SqlSeq
     C                   Callp     SQL_gotoBottom(§msgID: §msgDta)
     C                   ELSE
     C                   EVAL      Wrk#KeyVal = '*HIVAL'
     C                   EVAL      Wrk#RcdNbr = §HghRcdNbr
      *
     C                   EXSR      PBGenIntKy
     C                   EXSR      PBSetGT
     C                   EXSR      PBReadP
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    clrFldArray   Löschen Felder Array                      *
      *============================================================*
      *
     C     clrFldArray   BEGSR
      *
     C                   EVAL      Col_Field(*) = ''
     C                   EVAL      Col_ScnStr(*) = 0
     C                   EVAL      Col_ScnEnd(*) = 0
     C                   EVAL      Col_Error(*) = bFalse
     C                   EVAL      CP = §ZEROS
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChangeFile    Prüfen, ob die Datei gewechselt hat       *
      *============================================================*
      *
     C     ChangeFile    BEGSR
      *
     C                   EVAL      IsFileChg = bFalse
      *
     C     L#File        IFNE      ##File
     C     L#Library     ORNE      ##Library
     C     L#Member      ORNE      ##Member
     C     L#Format      ORNE      ##Format
      *
     C                   EVAL      IsFileChg = bTrue
      *  ... Änderungen prüfen
     C     ##Member      IFEQ      L#Member
     C                   EVAL      ##Member = *BLANKS
     C                   Endif
      *
     C     ##Format      IFEQ      L#Format
     C                   EVAL      ##Format = *BLANKS
     C                   Endif
      *
     C                   EXSR      CloseFile
      *
     C     ##File        IFNE      *BLANKS
     C                   Eval      AccessMode = NewAccMode
     C                   EXSR      OpenFile
     C                   Endif
     C                   Endif
      *
     C                   EXSR      GetOpnFile
     C                   EXSR      GetMaxSeq
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChangeWnd     Prüfen, ob Fenster gewechselt hat         *
      *============================================================*
      *
     C     ChangeWnd     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *      Nix tun, keine Datei vorhanden
     C                   EXSR      MsgNoFile
     C                   ELSE
      *
     C     ##Field       IFNE      *BLANKS
     C                   EVAL      Wrk#Field = ##Field
     C                   EXSR      GetSeqNbr
     C     IsSeqNbrOK    IFEQ      bTrue
     C                   EVAL      ##WndNbr = Wrk#SeqNbr
     C                   EVAL      ##StrPage = 1
     C                   ELSE
      *  Fehlermeldung ...
     C                   CLEAR                   USR8108
     C                   EVAL      §MsgID = 'USR8108'
     C                   EVAL      USR81081 = ##Field
     C                   EVAL      USR81082 = ##File
     C                   EVAL      USR81083 = ##Library
     C                   EVAL      §MsgDta = USR8108
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
     C                   EVAL      ##Field = *BLANKS
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChangeKey     Prüfen, ob der Aufsetzkey gewechselt hat  *
      *                  Auslösen über *IN93                       *
      *============================================================*
      *
     C     ChangeKey     BEGSR
      *
     C     ##RcdNbr      IFNE      R#RcdNbr
     C     ##Key         ORNE      R#KeyVal
     C                   EVAL      IsKeyChg = bTrue
     C                   ELSE
     C                   EVAL      IsKeyChg = bFalse
     C                   Endif
      *
     C                   SELECT
     C     ##RcdNbr      WHENLT    §LowRcdNbr
     C                   EVAL      ##RcdNbr = §LowRcdNbr
     C     ##RcdNbr      WHENGT    §HghRcdNbr
     C                   EVAL      ##RcdNbr = §HghRcdNbr
     C                   OTHER
      *    Im gültigen Bereich ...
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChangeSort    Wechseln der Sortierfolge                 *
      *============================================================*
      *
     C     ChangeSort    BEGSR
      *
     C                   EVAL      L#File = *BLANKS
     C                   EVAL      L#Library = *BLANKS
     C                   EVAL      L#Member = *BLANKS
     C                   EVAL      L#Format = *BLANKS
      *
      *  Merken der letzten Cursorposition
     C                   SELECT
      *    ... außerhalb der Subfile
     C     SflCsr        WHENLE    *ZEROS
      *        ... wird später anhand der
      *            Cursorposition auf dem Bildschirm entschieden
     C                   EVAL      SflCsr = *ZEROS
      *
      *    ... innerhalb der Subfile
     C     SflCsr        WHENGT    NbrPinRcd
      *        ... wird genau dort positioniert
      *
      *    ... innerhalb der gepinnten Datensätze
     C                   OTHER
      *        ... auf 1. angezeigten Datensatz positionieren
     C                   EVAL      SflCsr = 1 + NbrPinRcd
     C                   Endsl
      *
      *  Umsetzen Cursorposition in Satznummer
     C                   EXSR      PBCsrTRcd
     C     Wrk#RcdNbr    IFGT      *ZEROS
    R ***  File#04.Open  ANDEQ     '1'
     C                   EVAL      Last#RcdNr = Wrk#RcdNbr
     C                   ELSE
     C                   EVAL      Last#RcdNr = *ZEROS
     C                   Endif
      *
      *  Wechsel der Datei ...
     C                   EVAL      IsPinToClr = bFalse
     C                   EXSR      ChangeFile
     C                   EVAL      IsPinToClr = bTrue
      *
      *  Prüfen Seq-Bereich (##WndNbr) ...
     C                   EXSR      ChkSeqRnge
      *
      *  Wechsel des Fenster (##Field) ...
     C                   EXSR      ChangeWnd
      *
     C                   CLEAR                   ##RcdNbr
     C                   CLEAR                   ##Key
     C                   CLEAR                   R#RcdNbr
     C                   CLEAR                   R#KeyVal
      *
     C                   EVAL      YMsgID = *BLANKS
     C                   EVAL      YMsgDta = *BLANKS
      *
     C     Last#RcdNr    IFEQ      *ZEROS
      *    Alter Datensatz ist nicht bekannt ...
     C                   ELSE
      *    ... Einlesen letzten Datensatz
     C                   EVAL      RECORDNBR = Last#RcdNr
      *
     C                   IF        f_chain04(RECORDNBR:
     C                                       H_FILE   :
     C                                       H_LIB    :
     C                                       H_MBR    :
     C                                       H_RCDFMT ) = '1'
      *    ... Zugriff fehlgeschlagen
     C                   ELSE
      *    ... Generieren Aufsetzkey
     C                   EXSR      PBGenKey
     C                   Endif
     C                   Endif
      *
      *  Wechsel des Aufsetzkeys ...
     C                   EXSR      ChangeKey
      *
      *  Füllen der Subfile ...
     C     IsKeyChg      IFEQ      bFalse
     C     §ScnCsrRow    IFGT      SflLastRw
      *    ... unterhalb der Subfile
     C                   EXSR      C_Bot
     C                   ELSE
      *    ... oberhalb der Subfile,
      *        bzw. kein Wechsel des Aufsetzkeys
     C                   EXSR      C_Top
     C                   Endif
     C                   ELSE
      *    ... neuer Aufsetzkey innerhalb der Subfile
     C                   EXSR      KeyHasChg
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    OpenFile      Datei öffnen                              *
      *============================================================*
      *
     C     OpenFile      BEGSR
      *
      *  Wenn eine Datei bereits geöffnet ist ...
     C     IsOpen        IFEQ      bTrue
      *  ... dann geöffnet lassen
     C                   Leavesr
     C                   ENDIF
      *
     C                   Eval      YCsrRow = 0
     C                   Eval      YCsrCol = 0
      *
     C                   Exsr      ChkPrvFile
      *
      *  ... erst die Plausi prüfen, dann ...
     C     ##Library     IFEQ      *BLANKS
     C                   EVAL      ##Library = '*LIBL'
     C                   Endif
      *
     C     ##Member      IFEQ      *BLANKS
     C                   EVAL      ##Member = '*FIRST'
     C                   Endif
      *
      *  ... Objektbeschreibung
      *      ... abrufen der Objektattribute (auflösen *LIBL, *CURLIB)
     C                   EXSR      GetObjAttr
     C     IsError       IFEQ      bTrue
      *  Fehler aufgetreten, Öffnen abbrechen.
     C                   Exsr      MsgNoFile
     C                   Leavesr
     C                   Endif
      *
      *  ... Teildateien
     C                   if        (##Member = '*NONE')
     C                   eval      $$NOMB = 0
     C                   else
      *      ... abrufen der Anzahl Teildateien
     C                   exsr      GetNbrMbr
     C                   if        ($$NOMB = 0)
      *  Keine Teildateien vorhanden.
     C                   eval      ##Member = '*NONE'
     C                   endif
     C                   Endif
      *
      *      ... prüfen auf phys. Datei bei Zugriff über SQL
     C*** %SQL%          IF        (AccessMode = §SqlSeq and ATFILA <> '*PHY')
     C***                Exsr      MsgInvSqlFile
     C***                Leavesr
     C***                ENDIF
      *
      *      ... prüfen Name der Teildatei
     C                   EXSR      CheckMbrName
     C     IsError       IFEQ      bTrue
      *  Fehler aufgetreten, Öffnen abbrechen.
     C                   Exsr      MsgNoFile
     C                   Leavesr
     C                   Endif
      *
      *  ... Satzformate
      *      ... abrufen der Satzformate
     C                   EXSR      GetFmtList
      *      ... auswählen Satzformat
     C                   EXSR      GetRcdFrmt
      *
      *  ... prüfen auf Schlüsselfelder
      *      und initialisieren von PEEK41 (= Dateiinformationen)
     C                   EXSR      GetNbrKeyF
      *      ... wenn keine Schlüsselinformationen
      *          vorhanden sind, ...
     C     IsKeyAvail    IFEQ      bFalse
     C     AccessMode    ANDEQ     §KeySeq
      *          ... dann über RRN zugreifen
     C                   EVAL      AccessMode = §RrnSeq
     C                   ELSE
      *          ... sonst Modus beibehalten
     C                   Endif
      *
      *  Ermitteln Sortierung bei Zugriff über SQL ...
     C     AccessMode    IFEQ      §SqlSeq
     C     SqlOrder      IFEQ      '*KEY'
     C                   CALLP     PEEK38(##File: ##Library: sqlOrder)
     C                   ELSE
     C                   EVAL      sqlOrder = SQL_quote(f_ucase(sqlOrder))
     C                   ENDIF
     C                   ENDIF
      *
      * -------------------------------------------------
      *  Prüfen Zugriffsrechte
      * -------------------------------------------------
      *
      *      ... prüfen Zugriffsrechte
     C                   EXSR      s_EXIT01
      *
      *      ... Zugriff nicht erlaubt
     C                   IF        auth.accAut <> bTrue
     C                   EXSR      CloseFile
     C                   Callp     p_rmvPgmMg(§§pgmName)
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Leavesr
     C                   ENDIF
      *
      * -------------------------------------------------
      *  Datei öffnen für Einzelzugriff (Aktualisierung)
      * -------------------------------------------------
      *
     C                   if        (##MEMBER = '*NONE')
     C                   clear                   hFile00
     C                   eval      File#X.Open =bFalse
     C                   eval      File#X.File = ##File
     C                   eval      File#X.Library = ##Library
     C                   eval      File#X.RcdLen = 0
     C                   eval      File#X.Member = ##Member
     C                   eval      File#X.RcdFmt = ##Format
     C                   eval      File#X.MbrNbr = 0
     C                   eval      File#X.RcdNbr = 0
     C                   eval      isOpen = bFalse
     C                   else
      *
     C                   Eval      §FILE   = ##FILE
     C                   Eval      §TOFILE = ##FILE
     C                   Eval      §TOLIB  = ##LIBRARY
     C                   Eval      §MBR    = ##MEMBER
     C                   Eval      §SHARE  = '*NO'
     C                   Eval      §SECURE = '*YES'
      /COPY QCOPYLE,OVRDBF
      *
      *      ... Änderungen erlaubt
     C                   IF        auth.updMod = bTrue
     C                   EVAL      CommitLVL = '1'
      *          ... mit Commit-Steuerung
     C                   IF        CIO_open(hFile00
     C                                      : ##File
     C                                      : ##Library
     C                                      : ##Member
     C                                      : ##FORMAT
     C                                      : 'rr+, arrseq=Y, commit=Y, +
     C                                         nullcap=Y, riofb=Y, +
     C                                         secure=N, ccsid=65535') = bTrue
     C                   EXSR      F0toFx
     C                   EVAL      IsUpdMod = bTrue
     C                   ELSE
      *          ... ohne Commit-Steuerung
     C                   EVAL      CommitLVL = '0'
     C                   IF        CIO_open(hFile00
     C                                      : ##File
     C                                      : ##Library
     C                                      : ##Member
     C                                      : ##FORMAT
     C                                      : 'rr+ , arrseq=Y, commit=N +
     C                                         nullcap=Y, riofb=Y, +
     C                                         secure=N, ccsid=65535') = bTrue
      *
     C                   EXSR      F0toFx
     C                   EVAL      IsUpdMod = bTrue
     C                   ELSE
      *              ... Datei für Einzelsatzzugriff konnte nicht geöffnet werden.
      *                  evtl. handelt es sich um eine JOIN-Datei oder aber
      *                  es könnte auch Referenzielle Integrität definiert sein und
      *                  die läßt sich ohne Journalisierungn nicht anwenden!
     C                   EVAL      IsUpdMod = bFalse
     C                   EVAL      *IN99 = '0'
     C                   Endif
     C                   Endif
     C                   ELSE
      *      ... keine Änderungen erlaubt
     C                   EVAL      IsUpdMod = bFalse
     C                   EVAL      *IN99 = '0'
     C                   Endif
      *
     C                   If        (isUpdMod = bTrue) and (auth.updKey = bTrue)
     C                   Eval      isUpdKey = bTrue
     C                   Else
     C                   Eval      isUpdKey = bFalse
     C                   Endif
      *
      * -------------------------------------------------
      *  Datei öffnen für Sortierfolge
      * -------------------------------------------------
      *
      *  Sortierung 2 nach Schlüsselfelder
     C                   IF        (AccessMode = §KeySeq)
     C                   If        CIO_open(hFile02
     C                                      : ##FILE
     C                                      : ##LIBRARY
     C                                      : ##MEMBER
     C                                      : ##FORMAT
     C                                      : 'rr, arrseq=N, commit=N, +
     C                                         nullcap=Y, riofb=Y, +
     C                                         secure=N, ccsid=65535') = bTrue
     C                   Eval      *IN99 = *OFF
     C                   Else
     C                   Eval      *IN99 = *ON
     C                   Callp     CIO_getErrorMsg(hFile02: §MsgID: §MsgDta)
     C                   Endif
     C                   EXSR      F2toFx
     C                   Endif
      *
      *  Sortierung 1 nach Satzfolge
     C                   IF        (AccessMode = §RrnSeq)
     C                   If        CIO_open(hFile01
     C                                      : ##FILE
     C                                      : ##LIBRARY
     C                                      : ##MEMBER
     C                                      : ##FORMAT
     C                                      : 'rr, arrseq=Y, commit=N, +
     C                                         nullcap=Y, riofb=Y, +
     C                                         secure=N, ccsid=65535') = bTrue
     C                   Eval      *IN99 = *OFF
     C                   Else
     C                   Eval      *IN99 = *ON
     C                   Callp     CIO_getErrorMsg(hFile01: §MsgID: §MsgDta)
     C                   Endif
     C                   EXSR      F1toFx
     C                   Endif
      *
      *  Sortierung 3 nach Sql
     C                   IF        (AccessMode = §SqlSeq)
     C                   Clear                   USR0013
     C                   Callp     p_sndStsMg('USR0013': USR0013)
     C                   If        SQL_prepareStatement(
     C                                        '0'       :
     C                                        ##FILE    :
     C                                        ##LIBRARY :
     C                                        ##MEMBER  :
     C                                        ##FORMAT  :
     C                                        sqlWhere  :
     C                                        sqlOrder  :
     C                                      §MsgID      :
     C                                      §MsgDta     )
     C                             = bTrue
     C                   If        SQL_open(hFile03     :
     C                                      §MsgID      :
     C                                      §MsgDta     )
     C                             = bTrue
     C                   Eval      *IN99 = *OFF
     C                   Else
     C                   Eval      *IN99 = *ON
     C                   Callp     CIO_getErrorMsg(hFile03: §MsgID: §MsgDta)
     C                   Endif
     C                   EXSR      F3toFx
     C                   Else
     C                   Eval      *IN99 = *ON
     C                   Endif
     C                   Endif
      *
      /COPY QCOPYLE,DLTOVR
      *
     C     *IN99         IFEQ      '1'
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Leavesr
     C                   ENDIF
      *      Datei geöffnet ...
      *      ... OPEN-Flag
     C                   EVAL      IsOpen = bTrue
      *
     C                   endif
      *
      *      ... aber Satzlänge größer 32766
     C                   IF        File#X.RcdLen > §rcdBufLen
     C                   EXSR      CloseFile
     C                   Callp     p_rmvPgmMg(§§pgmName)
     C                   CLEAR                   USR8207
     C                   Eval      §MsgID   = 'USR8207'
     C                   Eval      USR82071 = §rcdBufLen
     C                   Eval      §MsgDta  = USR8207
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *
      *      ... löschen Pin-Funktion
     C                   EXSR      ClrPinCol
     C                   EXSR      ClrPinRow
      *      ... auswerten Rückkehrcode
     C     YMsgID        IFEQ      'USR8100'
      *          ... Abbruch mit F3/F12
     C                   EXSR      CloseFile
     C                   ELSE
      *          ... weiter
      *              ... abrufen der Feldliste
     C                   EXSR      GetFldList
      *              ... abrufen der Schlüsselfelder
     C                   EXSR      GetKeyList
      *              ... Sortieren der Schlüsselfelder
     C                   EXSR      FloatKeys
      *              ... Fensterposition
     C                   EVAL      ##WndNbr = §ZEROS
     C                   EVAL      ##StrPage = §ZEROS
      *              ... Suchmodus
     C                   EXSR      SrchInz
      *              ... Blätternfunktion Einzelsatz
     C                   EVAL      YScreenNbr = §ZEROS
      *              ... abrufen der Teildateiattribute
     C                   EXSR      GetMbrAttr
      *              ... initialisieren Kurzbefehl
     C                   EXSR      InitSCmd
      *              ... Nachrichten entfernen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *              ... einblenden Aufsetzkey
     C     AccessMode    IFEQ      §KeySeq
     C                   EVAL      *IN70 = '1'
     C                   ELSE
     C                   EVAL      *IN70 = '0'
     C                   Endif
      *              ... Cursor auf Keyeingabezeile setzen
     C                   EXSR      C_PosCsr
      *
      *              ... Hexmode nicht bei Satzlänge größer 32766
     C                   IF        (File#X.RcdLen > §rcdBufLen) and
     C                             (SET_DspMde = '*DSPHEX')
     C                   CLEAR                   USR8206
     C                   Eval      §MsgID    = 'USR8206'
     C                   Eval      USR82061  = §rcdBufLen
     C                   Eval      §MsgDta   = USR8206
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EXSR      S_DspNrm
     C                   Endif
      *
      *              ... Felder größer 512 Zeichen
     C     IsFld512      IFEQ      bTrue
      *                  ... ohne Commit
     C                   EVAL      §MsgID = 'USR8123'
     C                   EVAL      USR81231 = §White_U
     C                   EVAL      USR81232 = §White
     C                   EVAL      §MsgDta = USR8123
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
      *              ... Felder, welche nicht erlaubt sind
     C                   EVAL      F_Field = *BLANKS
     C     F_KEY         Setll     FPEEKFLD                           11
     C                   DO        *HIVAL
     C                   READ      FPEEKFLD                               11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   ENDIF
     C                   IF        (f_isNotAlw(F_FFD) = bTrue)
     C                   EVAL      §MsgID = 'USR8196'
     C                   EVAL      §MsgDta = F_Field
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ENDIF
     C                   ENDDO
      *
      *              ... Prüfen der Registrierung
     C                   EXSR      C_Register
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
      *              ... Datei geöffnet ...
     C                   if        (IsOpen = bTrue)
     C                   if        (CommitLVL = '0')
      *                  ... ohne Commit
     C                   EVAL      *IN55 = '0'
     C                   EVAL      §MsgID = 'USR0004'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *                  ... mit Commit
     C                   EVAL      *IN55 = '1'
     C                   EVAL      §MsgID = 'USR0003'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
      *              ... Datei für ...
     C                   if        (IsUpdMod = bFalse)
      *                  ... Input geöffnet
     C                   EVAL      §MsgID = 'USR0007'
     C                   EVAL      USR00071 = ##FILE
     C                   EVAL      USR00072 = ##LIBRARY
     C                   EVAL      §MsgDta = USR0007
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *                  ... Update geöffnet
     C                   Endif
     C                   Endif
     C                   Endif
     C                   Endif
      *
     C                   Eval      IsSflDirty = bTrue
      *
     C                   Eval      YIsLower = '-'
      *
     C                   Eval      isKeyLower = bFalse
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBRead        Lesen in Satz- oder Schlüsselfolge        *
      *============================================================*
      *
     C     PBRead        BEGSR
      *
     C                   Eval      IsFileError = bFalse
      *
     C                   DoU       (File#X.RcdFmt = ##Format) or (*in99 = *ON)
      *
     C                   Select
     C     AccessMode    WhenEQ    §KeySeq
     C                   If        CIO_read(hFile02: bFalse
     C                                      : IO_Buff: IO_NullMap) = bEOF
     C                   Eval      *IN99 = *ON
     C                   Else
     C                   Eval      *IN99 = *OFF
     C                   Endif
     C                   EXSR      F2toFx
     C                   Eval      isFileError = CIO_isError(hFile02)
     C     AccessMode    WhenEQ    §RrnSeq
     C                   If        CIO_read(hFile01: bFalse
     C                                      : IO_Buff: IO_NullMap) = bEOF
     C                   Eval      *IN99 = *ON
     C                   Else
     C                   Eval      *IN99 = *OFF
     C                   Endif
     C                   EXSR      F1toFx
     C                   Eval      isFileError = CIO_isError(hFile01)
     C     AccessMode    WhenEQ    §SqlSeq
     C                   If        SQL_nextRow(IO_Buff: IO_NullMap: hFile03:
     C                                         §MsgID : §MsgDta)  = bEOF
     C                   Eval      *IN99 = *ON
     C                   Else
     C                   Eval      *IN99 = *OFF
     C                   Endif
     C                   EXSR      F3toFx
     C                   Eval      isFileError = CIO_isError(hFile03)
     C                   Other
     C                   Endsl
      *
     C                   Enddo
      *
     C     IsFileError   IFEQ      bTrue
     C                   EVAL      IsEOF = bTrue
     C                   ELSE
     C     *IN99         IFEQ      '1'
     C                   EXSR      PBMoveBot
     C                   EVAL      IsEOF = bTrue
     C                   ELSE
     C                   EVAL      IsEOF = bFalse
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBReadP       Rückwärts lesen in Satz- oder             *
      *                  Schlüsselfolge                            *
      *============================================================*
      *
     C     PBReadP       BEGSR
      *
     C                   DoU       (File#X.RcdFmt = ##Format) or (*in99 = *ON)
      *
     C                   Select
     C     AccessMode    WhenEQ    §KeySeq
     C                   If        CIO_readp(hFile02: bFalse
     C                                       : IO_Buff: IO_NullMap) = bEOF
     C                   Eval      *IN99 = *ON
     C                   Else
     C                   Eval      *IN99 = *OFF
     C                   Endif
     C                   EXSR      F2toFx
     C     AccessMode    WhenEQ    §RrnSeq
     C                   If        CIO_readp(hFile01: bFalse
     C                                       : IO_Buff: IO_NullMap) = bEOF
     C                   Eval      *IN99 = *ON
     C                   Else
     C                   Eval      *IN99 = *OFF
     C                   Endif
     C                   EXSR      F1toFx
     C     AccessMode    WhenEQ    §SqlSeq
     C                   If        SQL_previousRow(IO_Buff: IO_NullMap: hFile03:
     C                                             §MsgID : §MsgDta) = bEOF
     C                   Eval      *IN99 = *ON
     C                   Else
     C                   Eval      *IN99 = *OFF
     C                   Endif
     C                   EXSR      F3toFx
     C                   Eval      isFileError = CIO_isError(hFile03)
     C                   Other
     C                   Endsl
      *
     C                   Enddo
      *
     C     *IN99         IFEQ      '1'
     C                   EXSR      PBMoveTop
     C                   EVAL      IsEOF = bTrue
     C                   ELSE
     C                   EVAL      IsEOF = bFalse
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    F0toFx        Übertragen der Dateiinformationen         *
      *                  (Status usw.) der Datei 00 in die         *
      *                  "globalen Felder Fx                       *
      *============================================================*
      *
     C     F0toFx        BEGSR
      *
     C                   EVAL      File#X = CIO_getInfDS(hFile00)
      *
     C                   ENDSR
      *
      *============================================================*
      *    F1toFx        Übertragen der Dateiinformationen         *
      *                  (Status usw.) der Datei 01 in die         *
      *                  "globalen Felder Fx                       *
      *============================================================*
      *
     C     F1toFx        BEGSR
      *
     C                   EVAL      File#X = CIO_getInfDS(hFile01)
      *
     C                   ENDSR
      *
      *============================================================*
      *    F2toFx        Übertragen der Dateiinformationen         *
      *                  (Status usw.) der Datei 02 in die         *
      *                  "globalen Felder Fx                       *
      *============================================================*
      *
     C     F2toFx        BEGSR
      *
     C                   EVAL      File#X = CIO_getInfDS(hFile02)
      *
     C                   ENDSR
      *
      *============================================================*
      *    F3toFx        Übertragen der Dateiinformationen         *
      *                  (Status usw.) der Datei 03 in die         *
      *                  "globalen Felder Fx                       *
      *============================================================*
      *
     C     F3toFx        BEGSR
      *
     C                   EVAL      File#X = CIO_getInfDS(hFile03)
      *
     C                   ENDSR
      *
      *============================================================*
      *    RepeatOpt     Wiederholen der Subfileauswahl            *
      *============================================================*
      *
     C     RepeatOpt     BEGSR
      *
      *  "Keine Sätze vorhanden"
     C     *IN80         IFEQ      '0'
      *  ... nix zu tun
     C                   ELSE
      *
      *  Lese alle Sätze der Subfile ab Wrk#Recno ...
     C     Wrk#Recno     DO        SflNbrRcd     X
      *
     C                   EVAL      SflRec132 = X
     C                   EVAL      SflRec080 = X
    WC                   EXSR      PBSflChain
      *
      *  ... höre auf, bei Dateiende oder Fehler
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   ELSE
      *  ... Wenn SFPAU bereits gefüllt ist,
      *      dann beende die Verarbeitung ...
     C     SFPAU         IFNE      *BLANKS
     C                   EVAL      *IN84 = '1'                                  SFLNXTCHG
    WC                   EXSR      PBSflUpdat
     C                   LEAVE
     C                   ELSE
      *  ... ansonsten wiederhole die Auswahl
     C                   EVAL      SFPAU = Wrk#SFPAU
     C                   EVAL      *IN84 = '1'                                  SFLNXTCHG
    WC                   EXSR      PBSflUpdat
     C                   Endif
     C                   Endif
      *
     C                   Enddo
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetFrstFld    Ermitteln der Feldnummer des ersten       *
      *                  sichtbaren Feldes                         *
      *============================================================*
      *
     C     GetFrstFld    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
     C                   EVAL      ##WndNbr = §ZEROS
     C                   ELSE
      *
     C                   EVAL      ##WndNbr = §ZEROS
      *
     C     1             DO        CP            X
      *
     C                   EVAL      Wrk#Field = Col_Field(X)
     C                   EXSR      ChkVisible
     C     IsVisible     IFEQ      bFalse
      *  ... nicht sichtbar
     C                   ITER
     C                   ELSE
      *  ... sichtbar
      *      ... ermitteln der Sequenznummer
     C                   EVAL      F_Field = Col_Field(X)
     C     F_KEY         CHAIN (N) FPEEKFLD                           11
     C     *IN11         IFEQ      '0'
      *          ... ermittelt
     C                   EVAL      ##WndNbr = F_Seq
     C                   LEAVE
     C                   ELSE
      *          ... kann eigentlich nicht sein
     C                   ITER
     C                   Endif
     C                   Endif
      *
     C                   Enddo
      *
     C                   Endif
      *
      *  Merken letzte Feldposition
     C                   EVAL      L#WndNbr = ##WndNbr
      *
     C                   EXSR      ChkSeqRnge
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetPgmName    Berechnen Programmname                    *
      *============================================================*
      *
     C     GetPgmName    BEGSR
      *
     C                   EVAL      PEEKPGM = 'P' +
     C                                         %subst(RCDL0200.R2FmtID: 1: 2) +
     C                                         %subst(RCDL0200.R2FmtID: 7: 7)
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetDSpName    Berechnen Name Displayfile                *
      *============================================================*
      *
     C     GetDspName    BEGSR
      *
     C                   EVAL      PEEKDSPF = 'F' +
     C                                         %subst(RCDL0200.R2FmtID: 1: 2) +
     C                                         %subst(RCDL0200.R2FmtID: 7: 7)
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetFldTMrk    Holen des zu markierenden Feldnamens      *
      *============================================================*
      *
     C     GetFldTMrk    BEGSR
      *
     C                   EVAL      Wrk#Field = *BLANKS
      *
     C     CP            IFLE      §ZEROS
      *  Funktion bei leerer Feldtabelle möglich ...
     C                   EVAL      §MsgID = 'USR8145'
     C                   EVAL      §MsgDta = *BLANKS
     C                   ELSE
      *
      *  Ermitteln Feldname aus Cursorposition ...
      ***  §ScnCsrRow    IFGE      SflHeadlRw
      ***  §ScnCsrCol    ANDGE     17
      *
     C     1             DO        CP            X
     C                   EVAL      Y = §ScnCsrCol - SflLeftOfs
     C     Y             IFGE      Col_ScnStr(X)
     C     Y             ANDLE     Col_ScnEnd(X)
     C                   EVAL      Wrk#Field = Col_Field(X)
     C                   LEAVE
     C                   Endif
     C                   Enddo
      *
      ***                ELSE
      *  Cursor nicht im gültigen Bereich ...
     C     Wrk#Field     IFEQ      *BLANKS
     C                   EVAL      §MsgID = 'USR8117'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      ***                ENDIF
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetSflRcd     Einlesen Subfilesatz an aktueller         *
      *                  Cursorposition                            *
      *============================================================*
      *
     C     GetSflRcd     BEGSR
      *
     C     SflCsr        IFGT      §ZEROS
     C                   EXSR      PBCsrTRcd
     C                   ELSE
     C                   EVAL      SflCsr = §ZEROS
     C                   EVAL      §MsgID = 'USR8102'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetNbrKeyF    Ermitteln Anzahl Schlüsselfelder          *
      *============================================================*
      *
     C     GetNbrKeyF    BEGSR
      *
     C                   CALLP     PEEK04(YQFile: ##Format: YMsgId: YMsgDta)
     C     YMsgID        IFEQ      'USR0006'
     C                   EVAL      IsKeyAvail = bFalse
     C                   ELSE
     C                   EVAL      IsKeyAvail = bTrue
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetNbrMbr     Ermitteln Anzahl Teildateien              *
      *============================================================*
      *
     C     GetNbrMbr     BEGSR
      *
     C                   CALLP     PEEK41(YQFile: ##FORMAT
     C                                    : '*CREATE': YNbrOfEnt: YData)
     C     YNbrOfEnt     IFGT      *ZEROS
     C                   EVAL      FILD0100 = yData
     C                   ELSE
     C                   CLEAR                   FILD0100
     C                   Endif
      *
     C                   EVAL      $$NOMB = FILD0100.ATNOMB
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetFmtList    Abrufrufen der Satzformatliste            *
      *============================================================*
      *
     C     GetFmtList    BEGSR
      *
     C                   EVAL      YFile = ##File
     C                   EVAL      YLibrary = ##Library
     C                   CALLP     PEEK10(YQFile: YMsgId: YMsgDta)
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetFldList    Abrufrufen der Feldliste                  *
      *============================================================*
      *
     C     GetFldList    BEGSR
      *
     C                   EVAL      YFile = ##File
     C                   EVAL      YLibrary = ##Library
     C                   CALLP     PEEK01(YQFile: ##FORMAT: $$RCDFMTID
     C                                    : YMsgId: YMsgDta)
      *
     C     YMsgID        IFEQ      'USR8123'
     C                   EVAL      IsFld512 = bTrue
     C                   ELSE
     C                   EVAL      IsFld512 = bFalse
     C                   Endif
      *
     C                   OPEN      PeekFld
     C                   OPEN      PeekFldL1
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetKeyList    Abrufrufen der Schlüsselfelder            *
      *============================================================*
      *
     C     GetKeyList    BEGSR
      *
     C                   CALLP     PEEK03(YQFile: ##Format: AccessMode: sqlOrder
     C                                    : YMsgId: YMsgDta)
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetRcdFrmt    Auswählen des Satzformates                *
      *============================================================*
      *
     C     GetRcdFrmt    BEGSR
      *
     C                   CALLP     PEEK12(SET_Dsp80: §CopyRight: ##FORMAT
     C                                    : §BATCH
     C                                    : RCDL0200: YFmtNbr: yMsgID: yMsgDta)
      *
     C     YMsgID        IFNE      'USR8100'
     C                   EVAL      ##FMTNBR = YFmtNbr
     C                   EVAL      ##Format = RCDL0200.R2FmtName
     C                   EVAL      $$Length = RCDL0200.R2RcdLen
     C                   ELSE
      *         Abbruch über F3/F12
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetObjAttr    Abrufrufen und anzeigen der               *
      *                  Objektattribute                           *
      *============================================================*
      *
     C     GetObjAttr    BEGSR
      *
     C                   Monitor
     C                   EVAL      YFile = ##File
     C                   EVAL      YLibrary = ##Library
     C                   CALLP     PEEK09(YQFile: OBJD0400: YMsgId: YMsgDta)
     C                   EVAL      *in99 = bFalse
     C                   On-Error
     C                   EVAL      *in99 = bTrue
     C                   Endmon
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      IsError = bTrue
     C                   ELSE
     C                   EVAL      IsError = bFalse
     C     YMsgID        IFNE      *BLANKS
     C                   EVAL      IsError = bTrue
      *  Objekt nicht gefunden ...
     C                   SELECT
     C     YMsgID        WHENEQ    'CPF9812'
     C                   EVAL      §MsgID = 'USR0008'
     C                   EVAL      USR00081 = ##File
     C                   EVAL      USR00082 = ##Library
     C                   EVAL      §MsgDta = USR0008
     C     YMsgID        WHENEQ    'CPF9810'
     C                   EVAL      §MsgID = 'USR0010'
     C                   EVAL      USR00101 = ##Library
     C                   EVAL      §MsgDta = USR0010
     C                   OTHER
     C                   EVAL      §MsgID = 'USR0009'
     C                   EVAL      USR00091 = ##File
     C                   EVAL      USR00092 = ##Library
     C                   EVAL      §MsgDta = USR0009
     C                   Endsl
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *
     C                   EVAL      IsError = bFalse
      *  Übertragen der Objektbezeichnung
     C                   EVAL      ##File = OBJD0400.O4ObjName
     C                   EVAL      ##Library = OBJD0400.O4RetLib
      *
      *  Übertragen der Objektbeschreibung
     C                   EVAL      $$Text40 = OBJD0400.O4Text
     C                   EVAL      $$Text50 = OBJD0400.O4Text
      *
      *  Wenn die Objektgröße kleiner als 999 ist,
     C                   IF        (OBJD0400.O4ObjSize <= 999)
      *  ... dann in der Einheit "Byte" anzeigen ...
     C                   EVAL      R#Size = §ZEROS
     C                   EVAL      $$UNIT = 'Byt'
     C                   ELSE
      *  ... ansonsten solange durch 1024 teilen,
      *      bis das die nächste passende Einheit
      *      gefunden werden konnte.
     C                   EVAL      R#Size = §ZEROS
      *
     C                   DOW       (OBJD0400.O4ObjSize > 999)
     C                   EVAL      OBJD0400.O4ObjSize =
     C                               %dech(OBJD0400.O4ObjSize / 1024: 10: 0)
     C                   EVAL      R#Size = R#Size + 1
     C                   Enddo
      *
      *  Multiplikator aus der Objektbeschreibung
      *  berücksichtigen und ...
     C                   IF        (OBJD0400.O4ObjSizeM = 1024)
     C                   EVAL      R#Size = R#Size + 1
     C                   ELSE
      *       keine Korrektur erforderlich
     C                   Endif
      *
      *  ... und passende Einheit wählen ...
     C                   SELECT
     C     R#Size        WHENEQ    1
     C                   EVAL      $$UNIT = 'K'
     C     R#Size        WHENEQ    2
     C                   EVAL      $$UNIT = 'MByt'
     C     R#Size        WHENEQ    3
     C                   EVAL      $$UNIT = 'GByt'
     C                   OTHER
     C                   EVAL      $$UNIT = 'TByt'
     C                   Endsl
     C                   Endif
      *
      *  ... sowie Restgröße zur Anzeige bringen
     C                   EVAL      $$SIZE = OBJD0400.O4ObjSize
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetMbrAttr    Abrufen der Attribute der Teildatei       *
      *============================================================*
      *
     C     GetMbrAttr    BEGSR
      *
      *  Beschreibung der Teildatei
     C     IsOpen        IFEQ      bFalse
     C                   EVAL      $$Records = §ZEROS
     C                   LEAVESR
     C                   ENDIF
      *
     C                   if        (##MEMBER = '*NONE')
     C                   clear                   MBRD0200
     C                   eval      $$Records = 0
     C                   eval      $$LmtCnt = ''
     C                   eval      $$Records = 0
     C                   leavesr
     C                   endif
      *
     C                   eval      YFile = ##File
     C                   eval      YLibrary = ##Library
     C                   callp     PEEK13(YQFile: ##Member: MBRD0200)
      *
     C                   if        MBRD0200.M2BytAvail > 0
     C                   if        MBRD0200.M2NbrRcdOn <= 2147483647
     C                   eval      $$Records = MBRD0200.M2NbrRcdOn
     C                   eval      *IN79 = *ON
     C                   eval      $$LmtCnt = ''
     C                   else
     C                   eval      $$Records = 0
     C                   eval      *IN79 = *OFF
     C                   eval      $$LmtCnt = '*OVERFLOW'
     C                   endif
     C                   else
     C                   eval      $$Records = 0
     C                   eval      *IN79 = *OFF
     C                   eval      $$LmtCnt = '*ERROR'
     C                   endif
      *
     C                   If        AccessMode = §SqlSeq
     C                   If        $$Records > SET_MAXRCDS
     C                   Eval      $$Records = 0
     C                   Eval      *IN79 = *OFF
     C                   EVAL      $$LmtCnt = '*SQLLMTCNT'
     C                   Else
     C                   Clear                   USR0014
     C                   Callp     p_sndStsMg('USR0014': USR0014)
     C                   EVAL      $$Records = SQL_count()
     C                   Eval      *IN79 = *ON
     C                   EVAL      $$LmtCnt = *BLANKS
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    CheckMbrName  Prüfen Name der Teildatei                 *
      *============================================================*
      *
     C     CheckMbrName  BEGSR
      *
     C                   if        (##Member = '*NONE')
     C                   clear                   MBRD0200
     C                   eval      IsError = bFalse
     C                   leavesr
     C                   endif
      *
     C                   EVAL      YFile = ##File
     C                   EVAL      YLibrary = ##Library
     C                   callp     PEEK13(YQFile: ##Member: MBRD0200)
     C                   IF        (MBRD0200.M2BytAvail <> 0)
     C                   EVAL      ##MEMBER = MBRD0200.M2Member
     C                   EVAL      IsError = bFalse
     C                   ELSE
     C                   EVAL      IsError = bTrue
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetMaxSeq     Ermitteln der Anzahl Felder               *
      *============================================================*
      *
     C     GetMaxSeq     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
     C                   EVAL      L#MaxSeq = §ZEROS
     C                   EVAL      L#MinSeq = §ZEROS
     C                   ELSE
      *
      *  Ermitteln Anzahl Felder ...
     C                   EVAL      F_Seq = *HIVAL
     C     F1KEY_L1      SETGT     FPEEKFLDL1
      *
     C                   DO        *HIVAL
     C                   READP     FPEEKFLDL1                             11
     C     *IN11         IFEQ      '1'
     C                   EVAL      L#MaxSeq = §ZEROS
     C                   LEAVE
     C                   Endif
      *
      *  ... Prüfen, ob Feld angezeigt wird
     C                   EVAL      Wrk#Field = F_Field
     C                   EXSR      ChkVisible
     C     IsVisible     IFEQ      bFalse
     C                   ITER
     C                   Endif
      *
     C                   EVAL      L#MaxSeq = F_Seq
     C                   LEAVE
     C                   Enddo
      *
      *  Ermitteln Erstes Feld ...
     C                   EVAL      F_Seq = §ZEROS
     C     F1KEY_L1      SETLL     FPEEKFLDL1
      *
     C                   DO        *HIVAL
     C                   READ      FPEEKFLDL1                             11
     C     *IN11         IFEQ      '1'
     C                   EVAL      L#MinSeq = §ZEROS
     C                   LEAVE
     C                   Endif
      *
      *  ... Prüfen, ob Feld angezeigt wird
     C                   EVAL      Wrk#Field = F_Field
     C                   EXSR      ChkVisible
     C     IsVisible     IFEQ      bFalse
     C                   ITER
     C                   Endif
      *
     C                   EVAL      L#MinSeq = F_Seq
     C                   LEAVE
     C                   Enddo
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetMaxSeq     Ermitteln vorhergehendes sichtabres Feld  *
      *============================================================*
      *
     C     GetPrvSeq     BEGSR
      *
     C     IsOpen        IFEQ      bFalse
     C                   EVAL      Wrk#SeqNbr = -1
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      F_Seq = Wrk#SeqNbr
     C     F1KEY_L1      CHAIN     FPEEKFLDL1
     C                   IF        NOT %FOUND()
     C                   EVAL      Wrk#SeqNbr = L#MinSeq
     C                   LEAVESR
     C                   ENDIF
      *
     C                   DO        *HIVAL
     C                   READP     FPEEKFLDL1
     C                   IF        %EOF()
     C                   EVAL      Wrk#SeqNbr = L#MinSeq
     C                   LEAVE
     C                   Endif
      *
      *  ... Prüfen, ob Feld angezeigt wird
     C                   EVAL      Wrk#Field = F_Field
     C                   EXSR      ChkVisible
     C     IsVisible     IFEQ      bFalse
     C                   ITER
     C                   Endif
      *
     C                   EVAL      Wrk#SeqNbr = F_Seq
     C                   LEAVE
     C                   ENDDO
      *
     C                   ENDSR
      *
      *============================================================*
      *    CloseFile     Datei schließen                           *
      *============================================================*
      *
     C     CloseFile     BEGSR
      *
     C     IsOpen        IFEQ      bTrue
      *
     C                   Eval      YCsrRow = 0
     C                   Eval      YCsrCol = 0
      *
      *  Datei 04 für Einzelsatzzugriff
     C                   IF        CIO_isOpen(hFile04) = bTrue
     C                   CALLP     CIO_close(hFile04)
     C                   ENDIF
      *
     C                   Select
     C     AccessMode    WhenEQ    §KeySeq
      *  Sortierung 2 für Schlüsselfolge
     C                   IF        CIO_close(hFile02) = bTrue
     C                   EVAL      *IN99 = '0'
     C                   ELSE
     C                   EVAL      *IN99 = '1'
     C                   ENDIF
     C                   EXSR      F2toFx
     C     AccessMode    WhenEQ    §RrnSeq
      *  Sortierung 1 für Satzfolge
     C                   IF        CIO_close(hFile01) = bTrue
     C                   EVAL      *IN99 = '0'
     C                   ELSE
     C                   EVAL      *IN99 = '1'
     C                   ENDIF
     C                   EXSR      F1toFx
     C     AccessMode    WhenEQ    §SqlSeq
     C                   If        SQL_close(hFile03:§MsgID :§MsgDta)
     C                             = bTrue
     C                   Eval      *IN99 = *OFF
     C                   Else
     C                   Eval      *IN99 = *ON
     C                   Endif
     C                   EXSR      F3toFx
     C                   Other
     C                   endsl
      *
     C                   else
     C                   eval      *in99 = '0'
     C                   endif
      *
      *  Sortierung 0 für Einzelzugriff
     C                   IF        CIO_isOpen(hFile00) = bTrue
     C                   IF        CIO_close(hFile00) = bTrue
     C                   EVAL      *IN99 = '0'
     C                   ELSE
     C                   EVAL      *IN99 = '1'
     C                   ENDIF
     C                   EXSR      F0toFx
     C                   ENDIF
      *
     C     *IN99         IFEQ      '0'
     C                   EVAL      IsOpen = bFalse
      *  Löschen Satzaufbau
     C                   IF        %open(PEEKFLD)
     C                   EVAL      F_Field = *BLANKS
     C     F_KEY         Setll     FPEEKFLD                           11
     C                   DO        *HIVAL
     C                   READ      FPEEKFLD                               11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   ENDIF
     C                   DELETE    FPEEKFLD
     C                   ENDDO
     C                   CLOSE     PeekFldL1
     C                   CLOSE     PeekFld
     C                   ENDIF
      *      ... Satzformat
     C                   EVAL      $$TEXT40 = *BLANKS
     C                   EVAL      $$TEXT50 = *BLANKS
     C                   EVAL      $$Length = §ZEROS
     C                   EVAL      $$Records = §ZEROS
     C                   EVAL      $$Size = §ZEROS
     C                   EVAL      $$RCDFMTID = *BLANKS
     C                   EVAL      $$Unit = *BLANKS
     C                   EVAL      $$NoMb = §ZEROS
     C                   EVAL      ##KEY = *BLANKS
     C                   EVAL      ##RCDNBR = §ZEROS
      *      ... Fensterposition
     C                   EVAL      ##WndNbr = §ZEROS
     C                   EVAL      ##StrPage = §ZEROS
      *
      *      ... SQL-Selektion
     C                   Eval      SqlWhere  = ' '
     C                   Eval      SqlOrder  = ' '
      *
     C                   ELSE
      *             Weiss noch nicht!
     C                   Endif
      *
      *  Subfile initialisieren
     C                   EXSR      PBInit
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetOpnFile    Ermitteln der geöffneten Datei            *
      *============================================================*
      *
     C     GetOpnFile    BEGSR
      *
     C     IsOpen        IFEQ      bTrue
     C                   EVAL      ##File = File#X.File
     C                   EVAL      ##Library = File#X.Library
     C                   EVAL      ##Member = File#X.Member
     C                   ELSE
      ***                MOVEL (P) *BLANKS       ##File
      ***                MOVEL (P) *BLANKS       ##Library
      ***                MOVEL (P) *BLANKS       ##Member
     C                   EVAL      $$Text40 = *BLANKS
     C                   EVAL      $$Text50 = *BLANKS
     C                   EVAL      $$Size = §ZEROS
     C                   EVAL      $$RCDFMTID = *BLANKS
     C                   EVAL      $$Unit = *BLANKS
     C                   Endif
      *
     C                   EVAL      L#File = ##File
     C                   EVAL      L#Library = ##Library
     C                   EVAL      L#Member = ##Member
     C                   EVAL      L#Format = ##Format
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
      *============================================================*
      *
     C     GetUsrSetg    BEGSR
      *
      *  *DSPATR
     C                   Eval      SET0001 = f_getUsrSg('*DSPATTR'  )
      *
      *  *SEARCH
     C                   Eval      SET0002 = f_getUsrSg('*SEARCH'   )
      *
      *  *ACCESSKEY
     C                   Eval      SET0003 = f_getUsrSg('*ACCESSKEY')
      *
      *  *SPLASH
     C                   Eval      SET0005 = f_getUsrSg('*SPLASH'   )
      *
      *  *CVTCHR
     C                   Eval      SET0006 = f_getUsrSg('*CVTCHR'   )
      *
      *  *VERSION
     C                   Eval      SET0007 = f_getUsrSg('*VERSION'  )
      *
      *  *PROMPT
     C                   Eval      SET0008 = f_getUsrSg('*PROMPT'   )
      *
      *  *FLOATKEYS
     C                   Eval      SET0009 = f_getUsrSg('*FLOATKEYS')
      *
      *  *SCROLL
     C                   Eval      SET0010 = f_getUsrSg('*SCROLL'   )
      *
      *  *DFTDSPMDE
     C                   Eval      SET0011 = f_getUsrSg('*DFTDSPMDE')
      *
     C     SET_DftMde    IFEQ      '*LAST'
      *    ... Modus belassen
     C                   ELSE
     C                   EVAL      SET_DspMde = SET_DftMde
     C                   Endif
      *
     C                   SELECT
     C     SET_DspMde    WHENEQ    '*DSPNRM'
     C                   EXSR      S_DspNrm
     C     SET_DspMde    WHENEQ    '*DSPHEX'
     C                   EXSR      S_DspHex
     C                   OTHER
     C                   EXSR      S_DspNrm
     C                   Endsl
      *
      * - Löschen Programmnachricht "keine Datei geöffnet"
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  *SECATR ...
     C                   Eval      SET0013 = f_getUsrSg('*SECATRDFT'   )
      *
      *  ... Verknüpfen *SECATRDFT mit Eingabeparametern ...
      *      ... ##Library
     C                   If        i_chgLib = '*'
     C                   If        SET_ChgLib = '1'
     C                   Eval      auth.chgLib = bTrue
     C                   Else
     C                   Eval      auth.chgLib = bFalse
     C                   Endif
     C                   Else
     C                   If        i_chgLib = '1'
     C                   Eval      auth.chgLib = bTrue
     C                   Else
     C                   Eval      auth.chgLib = bFalse
     C                   Endif
     C                   Endif
      *
      *      ... ##File
     C                   If        i_chgFile = '*'
     C                   If        SET_ChgFil  = '1'
     C                   Eval      auth.chgFile = bTrue
     C                   Else
     C                   Eval      auth.chgFile = bFalse
     C                   Endif
     C                   Else
     C                   If        i_chgFile = '1'
     C                   Eval      auth.chgFile = bTrue
     C                   Else
     C                   Eval      auth.chgFile = bFalse
     C                   Endif
     C                   Endif
      *
      *      ... ##Member
     C                   If        i_chgMbr = '*'
     C                   If        SET_ChgMbr = '1'
     C                   Eval      auth.chgMbr = bTrue
     C                   Else
     C                   Eval      auth.chgMbr = bFalse
     C                   Endif
     C                   Else
     C                   If        i_chgMbr = '1'
     C                   Eval      auth.chgMbr = bTrue
     C                   Else
     C                   Eval      auth.chgMbr = bFalse
     C                   Endif
     C                   Endif
      *
      *      ... updMod
     C                   If        (i_updModKey = §upd_dft  )
     C                   If        SET_UpdMod = '1'
     C                   Eval      auth.updMod    = bTrue
     C                   Else
     C                   Eval      auth.updMod    = bFalse
     C                   Endif
     C                   Else
     C                   If        (i_updModKey = §upd_yes  )  or
     C                             (i_updModKey = §upd_noKey)
     C                   Eval      auth.updMod    = bTrue
     C                   Else
     C                   Eval      auth.updMod    = bFalse
     C                   Endif
     C                   Endif
      *
      *      ... keyUpd
     C                   If        (i_updModKey = §upd_dft  )  or
     C                             (i_updModKey = §upd_yes  )
     C                   Eval      auth.updKey    = bTrue
     C                   Else
     C                   Eval      auth.updKey    = bFalse
     C                   Endif
      *
      *      ... chgSqlW
     C                   If        (i_chgSqlW = §upd_dft  )  or
     C                             (i_chgSqlW = §upd_yes  )
     C                   Eval      auth.chgSqlW = bTrue
     C                   Else
     C                   Eval      auth.chgSqlW = bFalse
     C                   Endif
      *
      *      ... chgSqlO
     C                   If        (i_chgSqlO = §upd_dft  )  or
     C                             (i_chgSqlO = §upd_yes  )
     C                   Eval      auth.chgSqlO = bTrue
     C                   Else
     C                   Eval      auth.chgSqlO = bFalse
     C                   Endif
      *
      *      ... accAut
     C                   If        SET_AccAut = '1'
     C                   Eval      auth.accAut    = bTrue
     C                   Else
     C                   Eval      auth.accAut    = bFalse
     C                   Endif
      *
      *  *PRVFILE
     C                   Eval      SET0014 = f_getUsrSg('*PRVFILE')
      *
      *  *ENVFILE
     C                   Eval      SET0015 = f_getUsrSg('*ENVFILE')
      *
      *  *SQLLMTCNT
     C                   Eval      SET0016 = f_getUsrSg('*SQLLMTCNT')
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetSeqNbr     Übersetzen Field Name in Sequence Nbr     *
      *============================================================*
      *
     C     GetSeqNbr     BEGSR
      *
     C                   EVAL      F_Field = Wrk#Field
     C     F_KEY         CHAIN (N) FPEEKFLD                           11
     C     *IN11         IFEQ      '0'
     C                   EVAL      IsSeqNbrOK = bTrue
     C                   EVAL      Wrk#SeqNbr = F_Seq
     C                   ELSE
     C                   EVAL      IsSeqNbrOK = bFalse
     C                   EVAL      Wrk#SeqNbr = §ZEROS
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetLastOpt    Ermitteln der letzten Subfileauswahl      *
      *============================================================*
      *
     C     GetLastOpt    BEGSR
      *
      *  "Keine Sätze vorhanden"
     C     *IN80         IFEQ      '0'
     C                   EVAL      IsError = bTrue
     C                   EVAL      Wrk#SFPAU = *BLANKS
     C                   EVAL      Wrk#Recno = §ZEROS
     C                   ELSE
      *
     C     1             DO        SflNbrRcd     X
      *
     C                   EVAL      Y = SflNbrRcd - X
     C                   EVAL      Y = Y + 1
      *
     C     *IN88         IFEQ      '0'
     C                   EVAL      SflRec132 = Y
     C     SflRec132     CHAIN     PBSFL132                           11
     C                   ELSE
     C                   EVAL      SflRec080 = Y
     C     SflRec080     CHAIN     PBSFL080                           11
     C                   Endif
      *
     C     *IN11         IFEQ      '1'
     C                   EVAL      IsError = bTrue
     C                   EVAL      Wrk#SFPAU = *BLANKS
     C                   EVAL      Wrk#Recno = §ZEROS
     C                   LEAVE
     C                   ELSE
     C     SFPAU         IFNE      *BLANKS
     C                   EVAL      Wrk#SFPAU = SFPAU
     C  N88              Z-ADD     SflRec132     Wrk#Recno
     C   88              Z-ADD     SflRec080     Wrk#Recno
     C                   EVAL      IsError = bFalse
     C                   LEAVE
     C                   ELSE
      *  Bitte weitersuchen ...
     C                   Endif
     C                   Endif
      *
     C                   Enddo
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetNxtMark    Ermtteln des nächsten markierten Feldes   *
      *============================================================*
      *
     C     GetNxtMark    BEGSR
      *
      *  Suchen des nächsten markierten Feldes ...
     C                   EVAL      F_Seq = Wrk#SeqNbr
     C     F1KEY_L1      SETGT     FPEEKFLDL1
      *
     C                   DO        *HIVAL
     C                   READ      FPEEKFLDL1                             11
     C     *IN11         IFEQ      '1'
     C                   EVAL      Wrk#SeqNbr = *ZEROS
     C                   LEAVE
     C                   Endif
      *
     C                   EXSR      ChkVisible
     C     IsVisible     IFEQ      bFalse
      *    ... Feld ist nicht sichtbar
     C                   ELSE
      *    ... Feld ist sichtbar
     C     F_MarkCol     IFEQ      bTrue
      *        ... und markiert
     C                   EVAL      Wrk#SeqNbr = F_Seq
     C                   LEAVE
     C                   ELSE
      *        ... leider nicht markiert
     C                   Endif
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetPrvMark    Ermtteln des vorherigen markierten Feldes *
      *============================================================*
      *
     C     GetPrvMark    BEGSR
      *
      *  Suchen des nächsten markierten Feldes ...
     C                   EVAL      F_Seq = Wrk#SeqNbr
     C     F1KEY_L1      SETLL     FPEEKFLDL1
      *
     C                   DO        *HIVAL
     C                   READP     FPEEKFLDL1                             11
     C     *IN11         IFEQ      '1'
     C                   EVAL      Wrk#SeqNbr = *ZEROS
     C                   LEAVE
     C                   Endif
      *
     C                   EXSR      ChkVisible
     C     IsVisible     IFEQ      bFalse
      *    ... Feld ist nicht sichtbar
     C                   ELSE
      *    ... Feld ist sichtbar
     C     F_MarkCol     IFEQ      bTrue
      *        ... und markiert
     C                   EVAL      Wrk#SeqNbr = F_Seq
     C                   LEAVE
     C                   ELSE
      *        ... leider nicht markiert
     C                   Endif
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    KeyHasChg     Aufsetzkey hat gewechselt                 *
      *============================================================*
      *
     C     KeyHasChg     BEGSR
      *
     C                   EVAL      Wrk#KeyVal = ##Key
     C                   EVAL      Wrk#RcdNbr = ##RcdNbr
     C                   EXSR      PBGenIntKy
     C     YMsgID        IFNE      *BLANKS
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EVAL      §MsgID = 'USR8139'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   EXSR      PBSetLL
     C                   EXSR      PBInit
     C                   EXSR      PBPinRcd
     C                   EXSR      PBReadUp
      *  Aufsetzkey überschreitet Dateiende
     C     *IN80         IFEQ      '0'
     C                   EXSR      C_Bot
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    FloatKeys     Keyfelder an den Anfang sortieren         *
      *============================================================*
      *
     C     FloatKeys     BEGSR
      *
     C                   IF        (SET_FLOAT  = bTrue)     and
     C                             ((AccessMode = §KeySeq)  or
     C                              (AccessMode = §SqlSeq))
      *
     C                   monitor
     C                   callp     PEEK34(SET_Dsp80: §CopyRight: '*FLOATKEYS'
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C                   ELSE
      *    Es werden keine Schlüselfeldinformationen benötigt
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    KeepCsrPos    Beibehalten der Cursorposition            *
      *============================================================*
      *
     C     KeepCsrPos    BEGSR
      *
      *  Beibehalten der Cursorosition
     C                   EVAL      CsrRow = §ScnCsrRow
     C                   EVAL      CsrCol = §ScnCsrCol
      *
     C                   ENDSR
      *
      *============================================================*
      *    DltCsrPos     Löschen der Cursorposition                *
      *============================================================*
      *
     C     DltCsrPos     BEGSR
      *
      *  Löschen der Cursorosition
     C                   EVAL      CsrRow = *ZEROS
     C                   EVAL      CsrCol = *ZEROS
      *
     C                   ENDSR
      *
      *============================================================*
      *    SetUsrSetg    Speichern der Benutzervoreinstellungen    *
      *============================================================*
      *
     C     SetUsrSetg    BEGSR
      *
      *  Splash-Screen
     C                   Callp     p_updUsrSg('*SPLASH' : SET0005)
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkVisible    Prüfen, ob Feld angezeigt wird            *
      *============================================================*
      *
     C     ChkVisible    BEGSR
      *
     C                   EVAL      IsVisible = bTrue
      *
     C     1             DO        1
      *
      *  ... Feld nicht anzeigen
     C     F_HIDDEN      IFEQ      bTrue
     C                   EVAL      IsVisible = bFalse
     C                   LEAVE
     C                   Endif
      *
      *  ... gepinnte Spalten überlesen
     C                   EVAL      Pin#Field = Wrk#Field
     C                   EXSR      ChkPinCol
     C     IsPinned      IFEQ      bTrue
     C                   EVAL      IsVisible = bFalse
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkSeqRnge    Prüfen der Fensternummer                  *
      *============================================================*
      *
     C     ChkSeqRnge    BEGSR
      *
     C     IsOpen        IFEQ      bFalse
      *            keine Datei geöffnet
     C                   ELSE
      *
     C     ##WndNbr      IFLT      L#MinSeq
     C                   EVAL      ##WndNbr = L#MinSeq
     C                   EVAL      §MsgID = 'USR8115'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EVAL      ##StrPage = 1
     C                   Endif
      *
     C     ##WndNbr      IFGT      L#MaxSeq
     C                   EVAL      ##WndNbr = L#MaxSeq
     C                   EVAL      §MsgID = 'USR8116'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C     SET_SCROLL    IFEQ      '*BOTH'
     C     SET_SCROLL    OREQ      '*RIGHT'
     C                   EVAL      ##StrPage = *HIVAL
     C                   ELSE
     C                   EVAL      ##StrPage = 1
     C                   Endif
     C                   Endif
      *
     C     ##StrPage     IFLT      1
     C                   EVAL      ##StrPage = 1
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
      *============================================================*
      *
     C     SetScreen     BEGSR
      *
      *    Wenn der Bildschirm keine 132-Zeichen
      *    darstellen kann, ...
     C     §ScnNumRows   IFLT      27
      *    ... dann auf 80-Zeichen umschalten.
     C                   EVAL      SET_Dsp80 = '1'
     C                   ELSE
      *    ... sonst die Auflösung 80/132 beibehalten.
     C                   Endif
      *
     C     SET_Dsp80     IFEQ      '1'
      *    80-Zeichen Anzeige
     C                   EVAL      *IN88 = '1'
     C                   EVAL      SflPage = 14
     C                   EVAL      SflDataLen = 64
     C                   EVAL      SflHeadLRw = 6
     C                   EVAL      SflFirstRw = 7
     C                   EVAL      SflLastRw = 20
     C                   EVAL      SflLeftOfs = 15
     C                   ELSE
      *   132-Zeichen Anzeige
     C                   EVAL      *IN88 = '0'
     C                   EVAL      SflPage = 16
     C                   EVAL      SflDataLen = 116
     C                   EVAL      SflHeadLRw = 6
     C                   EVAL      SflFirstRw = 8
     C                   EVAL      SflLastRw = 23
     C                   EVAL      SflLeftOfs = 15
     C                   Endif
      *
      *  Bereich für gepinnte Spalten
     C     SflDataLen    DIV       3             SflPinRnge
     C                   MULT      2             SflPinRnge
      *
      *  Prompt-Felder anzeigen ...
     C     SET_DspPmt    IFEQ      bTrue
     C     *IN77         ANDEQ     *OFF
     C                   EVAL      *IN71 = '1'
     C                   ELSE
     C                   EVAL      *IN71 = '0'
     C                   Endif
      *
      *  Subfileauswahlfeld öffnen ...
     C                   EVAL      *IN76 = '0'
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChgScreen     Wechseln 132/80-Zeichen Auflösung         *
      *============================================================*
      *
     C     ChgScreen     BEGSR
      *
     C     SET_Dsp80     IFEQ      '1'
      *   132-Zeichen Anzeige
     C                   EVAL      SET_Dsp80 = '0'
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   EVAL      SET_Dsp80 = '1'
     C                   Endif
      *
     C                   EXSR      SetScreen
      *
     C                   ENDSR
      *
      *============================================================*
      *    ShowSplash    Anzeigen SPLASH-Screen                    *
      *============================================================*
      *
     C     ShowSplash    BEGSR
      *
     C     SET_SPLA      IFEQ      bFalse
      *            kein Splash-Screen
     C                   ELSE
     C                   WRITE     SPLASH01
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkVersion    Prüfen der Versionsnummer                 *
      *============================================================*
      *
     C     ChkVersion    BEGSR
      *
     C     SET_VSN       IFNE      §Version
     C                   CALLP     PEEK33(§Version: YMsgID: YMsgDta)
     C                   ELSE
      *  Kein Abgleich erforderlich ...
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkPrvFile    Prüfen vorherige Datei                    *
      *============================================================*
      *
     C     ChkPrvFile    Begsr
      *
      *  Datei ...
     C                   If        ##File = '*PRV'
     C                   If        SET_PrvFil  <> '*NONE'
     C                   Eval      ##File = SET_PrvFil
     C                   Endif
      *  Bibliothek ...
     C                   If        SET_PrvLib  <> '*NONE'
     C                   Eval      ##Library = SET_PrvLib
     C                   Else
     C                   Eval      ##Library = ' '
     C                   Endif
      *  Teildatei ...
     C                   If        SET_PrvMbr  <> '*NONE'
     C                   Eval      ##Member = SET_PrvMbr
     C                   Else
     C                   Eval      ##Member = ' '
     C                   Endif
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    s_EXIT01                                                *
      *============================================================*
      *
     C     s_EXIT01      BEGSR
      *
     C                   Eval      YFile = ##File                               Input
     C                   Eval      YLibrary = ##Library                         Input
     C                   Eval      YMember  = ##Member                          Input
     C                   Eval      Yaccess  = accessMode                        Input
     C                   Eval      YchgLib  = auth.chgLib                       I/O
     C                   Eval      YchgFile = auth.chgFile                      I/O
     C                   Eval      YchgMbr  = auth.chgMbr                       I/O
     C                   Eval      YupdMod  = auth.updMod                       I/O
     C                   Eval      YupdKey  = auth.updKey                       I/O
     C                   Eval      YchgSqlW = auth.chgSqlW                      I/O
     C                   Eval      YchgSqlO = auth.chgSqlO                      I/O
     C                   Eval      YaccAut  = auth.accAut                       I/O
     C                   Eval      YmsgID   = ' '                               Output
     C                   Eval      YmsgDta  = ' '                               Output
      *
     C                   Call      EXIT01        P#Exit01
      *
     C     YmsgID        IFNE      *BLANKS
     C                   Callp     p_rmvPgmMg(§§pgmName)
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   Endif
      *
     C                   Eval      auth.chgLib  = YchgLib
     C                   Eval      auth.chgFile = YchgFile
     C                   Eval      auth.chgMbr  = YchgMbr
     C                   Eval      auth.updMod  = YupdMod
     C                   Eval      auth.updKey  = YupdKey
     C                   Eval      auth.chgSqlW = YchgSqlW
     C                   Eval      auth.chgSqlO = YchgSqlO
     C                   Eval      auth.accAut  = YaccAut
      *
     C                   ENDSR
      *
      *============================================================*
      *    clrPinTabR    Löschen PinTabR                           *
      *============================================================*
      *
     C     clrPinTabR    BEGSR
      *
     C                   CLEAR                   PIN#DS
     C     1             DO        MaxPinRcd     PinXR
     C                   EVAL      PinTabR(PinXR) = PIN#DS
     C                   EVAL      yPinTabR(PinXR) = PinTabR(PinXR)
     C                   ENDDO
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
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      * - Einlesen der Benutzervoreinstellungen
     C                   EXSR      GetUsrSetg
      *
      * - Prüfen auf generischen Dateinamen
     C                   IF        %len(%trimR(io_qFile.name)) > 0 and
     C                             %subst(io_qFile.name
     C                                    : %len(%trimR(io_qFile.lib)): 1) = '*'
     C                   IF        *IN75 = *OFF
     C                   EVAL      ##File = io_qFile.name
     C                   EVAL      ##Library = io_qFile.lib
     C                   EXSR      Pmt_File
     C                   IF        §MsgID = *BLANKS
     C                   EVAL      io_qFile.name = ##File
     C                   EVAL      io_qFile.lib = ##Library
     C                   ENDIF
     C                   EVAL      ##File = *BLANKS
     C                   EVAL      ##Library = *BLANKS
     C                   EVAL      §MsgID = *BLANKS
     C                   EVAL      §MsgDta = *BLANKS
     C                   ENDIF
     C                   ENDIF
      *
      * - Öffnen Bildschirmdatei
     C                   OPEN      PEEK05FM
      *
      * - Initialisieren Bildschirm
     C                   EVAL      ##File = io_qFile.name
     C                   EVAL      ##Library = io_qFile.lib
     C                   EVAL      ##Member = i_member
     C                   EXSR      GetObjAttr
      *
     C                   EXSR      ChkPrvFile
     C                   EVAL      ##RcdNbr = §ZEROS
     C                   EVAL      ##Key = *BLANKS
     C                   EVAL      ##WndNbr = §ZEROS
     C                   EVAL      ##StrPage = §ZEROS
     C                   EVAL      ##Field = *BLANKS
      *
     C                   EXSR      clrFldArray
      *
     C                   EVAL      $$SYSTEM = *BLANKS
     C                   EVAL      $$TEXT40 = *BLANKS
     C                   EVAL      $$TEXT50 = *BLANKS
     C                   EVAL      ##FORMAT = *BLANKS
     C                   EVAL      $$Length = §ZEROS
     C                   EVAL      $$Records = §ZEROS
     C                   EVAL      $$SIZE = §ZEROS
     C                   EVAL      $$RCDFMTID = *BLANKS
     C                   EVAL      $$UNIT = *BLANKS
      *
     C                   EVAL      $$HEAD132 = *BLANKS
     C                   EVAL      $$HEAD080 = *BLANKS
      *
      *  Last opened file
     C                   EVAL      L#File = *BLANKS
     C                   EVAL      L#Library = *BLANKS
     C                   EVAL      L#Member = *BLANKS
     C                   EVAL      L#Format = *BLANKS
     C                   EVAL      L#MaxSeq = §ZEROS
     C                   EVAL      L#MinSeq = §ZEROS
     C                   EVAL      L#WndNbr = §ZEROS
      *
      *  SQL-Selektion
     C                   Eval      SqlWhere  = ' '
     C                   Eval      SqlOrder  = ' '
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   EXSR      SetScreen
      *
      * - SPLASH-Screen
     C                   EXSR      ShowSplash
      *
      * -  Darstellung der Auswahlen/Funktionstasten
     C                   EVAL      SFTop = 1
     C                   EVAL      SFBot = 1
      *
      * -  Netzwerkattribute
     C                   CALLP     PEEK07('SYSNAME': bFalse
     C                                    : YAttrLen: YAttrTyp: YValue)
     C     YAttrLen      IFGT      §ZEROS
     C                   EVAL      $$System = %subst(YValue: 1: YAttrLen)
     C                   ELSE
     C                   EVAL      $$System = *BLANKS
     C                   Endif
      *
      * - Öffnen der Datei
     C                   If        isOpen = bFalse
     C                   EVAL      AccessMode = i_access
     C                   If        AccessMode = §SqlSeq
     C                   Eval      SqlWhere  = i_sqlWhere
     C                   Eval      SqlOrder  = i_sqlOrder
     C                   Endif
     C                   EXSR      OpenFile
     C                   Endif
      *
      * - laden Arbeitsumgebung / öffnen Datei
     C                   If        i_qEnvFile.name = '*NONE'
     C                   Eval      YEnvFile = SET_ENVFIL
     C                   Eval      YEnvLib  = SET_ENVLIB
     C                   Eval      YEnvMbr  = '*FILE'
     C                   Else
     C                   If        i_qEnvFile.name = '*ENVFILE'
     C                   Eval      YEnvFile = SET_ENVFIL
     C                   Eval      YEnvLib  = SET_ENVLIB
     C                   Eval      YEnvMbr  = '*FILE'
     C                   Else
     C                   Eval      YEnvFile = i_qEnvFile.name
     C                   Eval      YEnvLib  = i_qEnvFile.lib
     C                   Eval      YEnvMbr  = i_envMbr
     C                   Endif
     C                   If        i_envLayout = bTrue
     C                   Eval      yOption = '*SLCLAYOUT'
     C                   Else
     C                   Eval      yOption = '*SLCENV'
     C                   Endif
     C                   Exsr      LoadEnv
     C                   Endif
      *
      * - Ermitteln der Attribute der geöffneten Datei
     C                   EXSR      GetOpnFile
     C                   EXSR      GetMaxSeq
      *
      *  Wenn eine Datei geöffnet werden konnte, ...
     C                   If        isOpen = bTrue
      *  ... dann
      *      abspeichern *PRVFILE
     C                   Eval      SET_prvFil  = ##File
     C                   Eval      SET_prvLib  = ##Library
     C                   Eval      SET_prvMbr  = ##Member
     C                   Callp     p_updUsrSg('*PRVFILE' : SET0014)
     C                   Endif
      *
      * - Subfile füllen
     C                   EXSR      PBINIT
     C                   EXSR      C_Top
      *
      * - Copyright
     C                   CLEAR                   USR9999
     C                   EVAL      §MsgID = 'USR9999'
     C                   EVAL      USR99991 = §CopyRight
     C                   EVAL      USR99992 = §Release
     C                   EVAL      §MsgDta = USR9999
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   Callp     p_regPssr(%paddr('P_PSSR'): *omit: *omit)
      *
     C                   Eval      §PgmQ = '*'
      *
     C                   Eval      PEEK01_NAME = f_pgmCallN('PEEK01')
     C                   Eval      PEEK03_NAME = f_pgmCallN('PEEK03')
     C                   Eval      PEEK04_NAME = f_pgmCallN('PEEK04')
     C                   Eval      PEEK06_NAME = f_pgmCallN('PEEK06')
     C                   Eval      PEEK07_NAME = f_pgmCallN('PEEK07')
     C                   Eval      PEEK08_NAME = f_pgmCallN('PEEK08')
     C                   Eval      PEEK09_NAME = f_pgmCallN('PEEK09')
     C                   Eval      PEEK10_NAME = f_pgmCallN('PEEK10')
     C                   Eval      PEEK12_NAME = f_pgmCallN('PEEK12')
     C                   Eval      PEEK13_NAME = f_pgmCallN('PEEK13')
     C                   Eval      PEEK14_NAME = f_pgmCallN('PEEK14')
     C                   Eval      PEEK17_NAME = f_pgmCallN('PEEK17')
     C                   Eval      PEEK18_NAME = f_pgmCallN('PEEK18')
     C                   Eval      PEEK19_NAME = f_pgmCallN('PEEK19')
     C                   Eval      PEEK20_NAME = f_pgmCallN('PEEK20')
     C                   Eval      PEEK21_NAME = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23_NAME = f_pgmCallN('PEEK23')
     C                   Eval      PEEK24_NAME = f_pgmCallN('PEEK24')
     C                   Eval      PEEK26_NAME = f_pgmCallN('PEEK26')
     C                   Eval      PEEK27_NAME = f_pgmCallN('PEEK27')
     C                   Eval      PEEK30_NAME = f_pgmCallN('PEEK30')
     C                   Eval      PEEK32_NAME = f_pgmCallN('PEEK32')
     C                   Eval      PEEK33_NAME = f_pgmCallN('PEEK33')
     C                   Eval      PEEK34_NAME = f_pgmCallN('PEEK34')
     C                   Eval      PEEK37_NAME = f_pgmCallN('PEEK37')
     C                   Eval      PEEK38_NAME = f_pgmCallN('PEEK38')
     C                   Eval      PEEK40_NAME = f_pgmCallN('PEEK40')
     C                   Eval      PEEK41_NAME = f_pgmCallN('PEEK41')
     C                   Eval      PEEK42_NAME = f_pgmCallN('PEEK42')
     C                   Eval      PEEK47_NAME = f_pgmCallN('PEEK47')
     C                   Eval      PEEK48_NAME = f_pgmCallN('PEEK48')
     C                   Eval      PEEK49_NAME = f_pgmCallN('PEEK49')
     C                   Eval      PEEK50_NAME = f_pgmCallN('PEEK50')
     C                   Eval      PEEK52_NAME = f_pgmCallN('PEEK52')
     C                   Eval      PEEK54_NAME = f_pgmCallN('PEEK54')
     C                   Eval      PEEK55_NAME = f_pgmCallN('PEEK55')
     C                   Eval      PEEK56_NAME = f_pgmCallN('PEEK56')
     C                   Eval      PEEK57_NAME = f_pgmCallN('PEEK57')
     C                   Eval      PEEK59_NAME = f_pgmCallN('PEEK59')
     C                   Eval      PEEK65_NAME = f_pgmCallN('PEEK65')
     C                   Eval      PEEK68_NAME = f_pgmCallN('PEEK68')
     C                   Eval      PEEK69 = f_pgmCallN('PEEK69')
     C                   Eval      EXIT01 = f_pgmCallN('EXIT01')
      *
      * - PinTabR clearen
     C                   EXSR      clrPinTabR
      *
      * - Versionsabgleich durchführen
     C                   EXSR      ChkVersion
      *
     C                   Callp     PEEK23(§§PgmName: '*ALL': 8
     C                                    : yFKeys: yNbrOfKeys)
     C                   Eval      ScrnFKeys = %subarr(YFKeys: 1)
      *
     C                   Callp     PEEK27(§§PgmName: YChoice: YNbrOfCh)
      *
     C                   Endsr
      *
      *============================================================*
      *    f_int         Integer Wert                              *
      *============================================================*
      *
     P f_int           B
      *
     D f_int           PI            20S 0
     D  inpValue                     25S 5 VALUE
      *
     D integerVal      S             20S 0
      *
     C                   EVAL      integerVal = inpValue
      *
     C                   Return    integerVal
      *
     P f_int           E
      *
      *============================================================*
      *    f_chain00                                               *
      *============================================================*
      *
     P f_chain00       B
      *
     D f_chain00       PI             1A
     D  i_rrn                              value  like(r§rcdNbr  )
     D  i_file                             value  like(r§file    )
     D  i_lib                              value  like(r§lib     )
     D  i_mbr                              value  like(r§mbr     )
     D  i_rcdFmt                     10A   value
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C                   IF        (CIO_getFile(hFile00)    <> i_file ) or
     C                             (CIO_getLibrary(hFile00) <> i_lib  ) or
     C                             (CIO_getMember(hFile00)  <> i_mbr  )
     C                   IF        CIO_isOpen(hFile00) = bTrue
     C                   CALLP     CIO_close(hFile00)
     C                   ENDIF
     C                   ENDIF
      *
     C                   Eval      §FILE   = ##FILE
     C                   Eval      §TOFILE = ##FILE
     C                   Eval      §TOLIB  = ##LIBRARY
     C                   Eval      §MBR    = ##MEMBER
     C                   Eval      §SHARE  = '*NO'
     C                   Eval      §SECURE = '*YES'
      /COPY QCOPYLE,OVRDBF
      *
     C                   IF        CIO_isOpen(hFile00) = bFalse
     C                   IF        CommitLVL = '1'
     C                   CALLP     CIO_open(hFile00
     C                                      : i_file
     C                                      : i_lib
     C                                      : i_mbr
     C                                      : i_rcdFmt
     C                                      : 'rr+ , arrseq=Y, commit=Y +
     C                                         nullcap=Y, riofb=Y, +
     C                                         secure=N, ccsid=65535')
     C                   Else
     C                   CALLP     CIO_open(hFile00
     C                                      : i_file
     C                                      : i_lib
     C                                      : i_mbr
     C                                      : i_rcdFmt
     C                                      : 'rr+ , arrseq=Y, commit=N +
     C                                         nullcap=Y, riofb=Y, +
     C                                         secure=N, ccsid=65535')
     C                   Endif
     C                   Endif
      *
      /COPY QCOPYLE,DLTOVR
      *
     C                   IF        CIO_chainWithRRN(hFile00
     C                                              : i_rrn
     C                                              : bTrue
     C                                              : IO_Buff
     C                                              : IO_NullMap) = bFalse
     C                   EVAL      *IN11 = '1'
     C                   ELSE
     C                   EVAL      *IN11 = '0'
     C                   ENDIF
      *
     C                   EVAL      File#X = CIO_getInfDS(hFile00)
      *
     C                   Return    *IN11
      *
     P f_chain00       E
      *
      *============================================================*
      *    f_chain04                                               *
      *============================================================*
      *
     P f_chain04       B
      *
     D f_chain04       PI             1A
     D  i_rrn                              value  like(r§rcdNbr  )
     D  i_file                             value  like(r§file    )
     D  i_lib                              value  like(r§lib     )
     D  i_mbr                              value  like(r§mbr     )
     D  i_rcdFmt                     10A   value
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C                   IF        (CIO_getFile(hFile04)    <> i_file ) or
     C                             (CIO_getLibrary(hFile04) <> i_lib  ) or
     C                             (CIO_getMember(hFile04)  <> i_mbr  )
     C                   IF        CIO_isOpen(hFile04) = bTrue
     C                   CALLP     CIO_close(hFile04)
     C                   ENDIF
     C                   ENDIF
      *
     C                   IF        CIO_isOpen(hFile04) = bFalse
     C                   CALLP     CIO_open(hFile04
     C                                      : i_file
     C                                      : i_lib
     C                                      : i_mbr
     C                                      : i_rcdFmt
     C                                      : 'rr , arrseq=Y, +
     C                                         nullcap=Y, riofb=Y, ccsid=65535')
     C                   Endif
      *
     C                   IF        CIO_chainWithRRN(hFile04
     C                                              : i_rrn
     C                                              : bFalse
     C                                              : IO_Buff
     C                                              : IO_NullMap) = bFalse
     C                   EVAL      *IN11 = '1'
     C                   ELSE
     C                   EVAL      *IN11 = '0'
     C                   ENDIF
      *
     C                   EVAL      File#X = CIO_getInfDS(hFile04)
      *
     C                   Return    *IN11
      *
     P f_chain04       E
      *
      *============================================================*
      *    p_pssr        Error handler                             *
      *============================================================*
      *
     P p_pssr          B                   export
      *
     D p_pssr          PI
      *
     C                   DUMP
      *
     C                   Return
      *
     P p_pssr          E
      *
