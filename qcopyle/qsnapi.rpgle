**free
      //%METADATA                                                      *
      // %TEXT Definitions for DSM service program QSNAPI              *
      //%EMETADATA                                                     *
//*************************************************************************
//                                                                        *
// Definitions for DSM service program QSNAPI                             *
//                                                                        *
//*************************************************************************


// Constant definitions.


// Constants for environment definition.
dcl-c QsnColorN '1';
dcl-c QsnColorY '2';
dcl-c QsnColorS '3';
dcl-c QsnCDRAS '1';
dcl-c QsnCDRAC '2';
dcl-c QsnDBCSS '1';
dcl-c QsnDBCSO '2';
dcl-c QsnDBCSE '3';
dcl-c QsnDBCSM '4';
dcl-c QsnCoexY '1';
dcl-c QsnCoexN '2';
dcl-c QsnAHelpN '1';
dcl-c QsnTgtReq '*REQUESTER';


dcl-c QsnSame '0';
dcl-c QsnDSP03 '3';
dcl-c QsnDSP04 '4';

dcl-c QsnF1 x'31';
dcl-c QsnF2 x'32';
dcl-c QsnF3 x'33';
dcl-c QsnF4 x'34';
dcl-c QsnF5 x'35';
dcl-c QsnF6 x'36';
dcl-c QsnF7 x'37';
dcl-c QsnF8 x'38';
dcl-c QsnF9 x'39';
dcl-c QsnF10 x'3A';
dcl-c QsnF11 x'3B';
dcl-c QsnF12 x'3C';
dcl-c QsnF13 x'B1';
dcl-c QsnF14 x'B2';
dcl-c QsnF15 x'B3';
dcl-c QsnF16 x'B4';
dcl-c QsnF17 x'B5';
dcl-c QsnF18 x'B6';
dcl-c QsnF19 x'B7';
dcl-c QsnF20 x'B8';
dcl-c QsnF21 x'B9';
dcl-c QsnF22 x'BA';
dcl-c QsnF23 x'BB';
dcl-c QsnF24 x'BC';
dcl-c QsnSLP x'3F';
dcl-c QsnFET x'50';
dcl-c QsnPA1 x'6C';
dcl-c QsnPA2 x'6E';
dcl-c QsnPA3 x'6B';
dcl-c QsnClearK x'BD';
dcl-c QsnEnterK x'F1';
dcl-c QsnHelpK x'F3';
dcl-c QsnRollDnK x'F4';
dcl-c QsnRollUpK x'F5';
dcl-c QsnPageUpK x'F4';
dcl-c QsnPageDnK x'F5';
dcl-c QsnPrintK x'F6';
dcl-c QsnRecBSK x'F8';

dcl-c Qsn5250QY '1';
dcl-c Qsn5250QN '2';
dcl-c Qsn5250QF '3';

dcl-c QsnCC1Null x'00';
dcl-c QsnCC1Lock x'20';
dcl-c QsnCC1MDTN x'40';
dcl-c QsnCC1MDTA x'60';
dcl-c QsnCC1ClrM x'80';
dcl-c QsnCC1NBYA x'A0';
dcl-c QsnCC1NBYM x'C0';
dcl-c QsnCC1All x'E0';

dcl-c QsnCC2Null x'00';
dcl-c QsnCC2NoIC x'40';
dcl-c QsnCC2RstB x'20';
dcl-c QsnCC2SetB x'10';
dcl-c QsnCC2Unlk x'08';
dcl-c QsnCC2Alrm x'04';
dcl-c QsnCC2MOff x'02';
dcl-c QsnCC2MOn x'01';

dcl-c QsnNoSA x'00';
dcl-c QsnSANorm x'20';
dcl-c QsnSACS x'30';
dcl-c QsnSABL x'28';
dcl-c QsnSAUL x'24';
dcl-c QsnSAHI x'22';
dcl-c QsnSARI x'21';
dcl-c QsnSAND x'27';

dcl-c QsnGrn x'20';
dcl-c QsnGrnRI x'21';
dcl-c QsnWht x'22';
dcl-c QsnWhtRI x'23';
dcl-c QsnGrnUL x'24';
dcl-c QsnGrnULRI x'25';
dcl-c QsnWhtUL x'26';
dcl-c QsnRed x'28';
dcl-c QsnRedRI x'29';
dcl-c QsnRedBL x'2A';
dcl-c QsnRedRIBL x'2B';
dcl-c QsnRedUL x'2C';
dcl-c QsnRedULRI x'2D';
dcl-c QsnRedULBL x'2E';
dcl-c QsnND2F x'2F';
dcl-c QsnTrqCS x'30';
dcl-c QsnTrqCSRI x'31';
dcl-c QsnYlwCS x'32';
dcl-c QsnYlwCSRI x'33';
dcl-c QsnTrqUL x'34';
dcl-c QsnTrqULRI x'35';
dcl-c QsnYlwUL x'36';
dcl-c QsnND37 x'37';
dcl-c QsnPnk x'38';
dcl-c QsnPnkRI x'39';
dcl-c QsnBlu x'3A';
dcl-c QsnBluRI x'3B';
dcl-c QsnPnkUL x'3C';
dcl-c QsnPnkULRI x'3D';
dcl-c QsnBluUL x'3E';
dcl-c QsnND3F x'3F';

dcl-c QsnSO x'0E';
dcl-c QsnSI x'0F';

dcl-c QsnNOFFW x'0000';
dcl-c QsnBypass x'6000';
dcl-c QsnDup x'5000';
dcl-c QsnMDT x'4800';
dcl-c QsnAlphaS x'4000';
dcl-c QsnAlphaO x'4100';
dcl-c QsnNumS x'4200';
dcl-c QsnNumO x'4300';
dcl-c QsnKata x'4400';
dcl-c QsnDig x'4500';
dcl-c QsnFFWIO x'4600';
dcl-c QsnSigned x'4700';
dcl-c QsnFFWAE x'4080';
dcl-c QsnFER x'4040';
dcl-c QsnMono x'4020';
dcl-c QsnFFWME x'4008';
dcl-c QsnNoAdj x'4000';
dcl-c QsnRAZero x'4005';
dcl-c QsnRABlank x'4006';
dcl-c QsnFFWMF x'4007';

dcl-c QsnFCWRes x'8000';
dcl-c QsnFCWMSR x'8101';
dcl-c QsnFCWSLP x'8102';
dcl-c QsnMSRSLP x'8103';
dcl-c QsnSLPSA x'8106';
dcl-c QsnFCWDBOn x'8200';
dcl-c QsnFCWDBP x'8220';
dcl-c QsnFCWDBE x'8240';
dcl-c QsnFCWDBOp x'8280';
dcl-c QsnFCWDBOC x'82C0';
dcl-c QsnTransp x'8400';
dcl-c QsnFCWFET x'8501';
dcl-c QsnContF x'8601';
dcl-c QsnContL x'8602';
dcl-c QsnContM x'8603';
dcl-c QsnFCWCP x'8800';
dcl-c QsnFCWHL x'8900';
dcl-c QsnFCWPDS x'8A00';
dcl-c QsnMod11 x'B140';
dcl-c QsnMod10 x'B1A0';

dcl-c QsnHT x'05';
dcl-c QsnVT x'0B';
dcl-c QsnFF x'0C';
dcl-c QsnCR x'0D';
dcl-c QsnNL x'15';
dcl-c QsnBS x'16';
dcl-c QsnBEL x'2F';

dcl-c QsnBeep 'QsnBeep';
dcl-c QsnChgEnv 'QsnChgEnv';
dcl-c QsnChgSsn 'QsnChgSsn';
dcl-c QsnChgWin 'QsnChgWin';
dcl-c QsnClrBuf 'QsnClrBuf';
dcl-c QsnClrFldT 'QsnClrFldTbl';
dcl-c QsnClrScl 'QsnClrScl';
dcl-c QsnClrScr 'QsnClrScr';
dcl-c QsnClrWin 'QsnClrWin';
dcl-c QsnClrWinM 'QsnClrWinMsg';
dcl-c QsnCpyBuf 'QsnCpyBuf';
dcl-c QsnCrtCBuf 'QsnCrtCmdBuf';
dcl-c QsnCrtEnv 'QsnCrtEnv';
dcl-c QsnCrtIBuf 'QsnCrtInpBuf';
dcl-c QsnCrtSsn 'QsnCrtSsn';
dcl-c QsnCrtWin 'QsnCrtWin';
dcl-c QsnDftAct 'QsnDefaultAction';
dcl-c QsnDltBuf 'QsnDltBuf';
dcl-c QsnDltEnv 'QsnDltEnv';
dcl-c QsnDltFldI 'QsnDltFldId';
dcl-c QsnDspSclB 'QsnDspSclB';
dcl-c QsnDspSclT 'QsnDspSclT';
dcl-c QsnDspWin 'QsnDspWin';
dcl-c QsnEndWin 'QsnEndWin';
dcl-c QsnGetAID 'QsnGetAID';
dcl-c QsnGetCsrA 'QsnGetCsrAdr';
dcl-c QsnGetCsrD 'QsnGetCsrAdrAID';
dcl-c QsnInsCsr 'QsnInsCsr';
dcl-c QsnInzEnvD 'QsnInzEnvD';
dcl-c QsnInzSsnD 'QsnInzSsnD';
dcl-c QsnInzWinD 'QsnInzWinD';
dcl-c QsnMovWin 'QsnMovWin';
dcl-c QsnMovWinU 'QsnMovWinUsr';
dcl-c QsnPrtScl 'QsnPrtScl';
dcl-c QsnPutBuf 'QsnPutBuf';
dcl-c QsnPutGBuf 'QsnPutGetBuf';
dcl-c QsnPutICmd 'QsnPutInpCmd';
dcl-c QsnPutOCmd 'QsnPutOutCmd';
dcl-c QsnPutWinM 'QsnPutWinMsg';
dcl-c QsnQColor 'QsnQryColorSup';
dcl-c QsnQModSup 'QsnQryModSup';
dcl-c QsnQSclWrp 'QsnQrySclWrp';
dcl-c QsnQry5250 'QsnQry5250';
dcl-c QsnReadImm 'QsnReadImm';
dcl-c QsnReadInp 'QsnReadInp';
dcl-c QsnReadMDT 'QsnReadMDT';
dcl-c QsnReadMA 'QsnReadMDTAlt';
dcl-c QsnReadMAI 'QsnReadMDTImmAlt';
dcl-c QsnReadScr 'QsnReadScr';
dcl-c QsnReadSsn 'QsnReadSsnDta';
dcl-c QsnRollD 'QsnRollDown';
dcl-c QsnRolSclD 'QsnRollSclDown';
dcl-c QsnRolSclU 'QsnRollSclUp';
dcl-c QsnRollUp 'QsnRollUp';
dcl-c QsnRstScr 'QsnRstScr';
dcl-c QsnRszWin 'QsnRszWin';
dcl-c QsnRszWinU 'QsnRszWinUsr';
dcl-c QsnRtvBufL 'QsnRtvBufLen';
dcl-c QsnRtvBufS 'QsnRtvBufSiz';
dcl-c QsnRtvCWin 'QsnRtvCurWin';
dcl-c QsnRtvDta 'QsnRtvDta';
dcl-c QsnRtvDtaL 'QsnRtvDtaLen';
dcl-c QsnRtvEnvD 'QsnRtvEnvD';
dcl-c QsnRtvEnvU 'QsnRtvEnvDta';
dcl-c QsnRtvEnvW 'QsnRtvEnvWinMod';
dcl-c QsnRtvFldC 'QsnRtvFldCnt';
dcl-c QsnRtvFldD 'QsnRtvFldDta';
dcl-c QsnRtvFldL 'QsnRtvFldDtaLen';
dcl-c QsnRtvFldI 'QsnRtvFldInf';
dcl-c QsnRtvMod 'QsnRtvMod';
dcl-c QsnRtvRdA 'QsnRtvReadAdr';
dcl-c QsnRtvRdAD 'QsnRtvReadAID';
dcl-c QsnRtvRdI 'QsnRtvReadInf';
dcl-c QsnRtvRdL 'QsnRtvReadLen';
dcl-c QsnRtvSclR 'QsnRtvSclNumRoll';
dcl-c QsnRtvSclS 'QsnRtvSclNumShf';
dcl-c QsnRtvScrD 'QsnRtvScrDim';
dcl-c QsnRtvSsnD 'QsnRtvSsnD';
dcl-c QsnRtvSsnU 'QsnRtvSsnDta';
dcl-c QsnRtvSsnL 'QsnRtvSsnLin';
dcl-c QsnRtvWinD 'QsnRtvWinD';
dcl-c QsnRtvWinU 'QsnRtvWinDta';
dcl-c QsnSameAct 'QsnSameAction';
dcl-c QsnSavScr 'QsnSavScr';
dcl-c QsnSclBS 'QsnSclBS';
dcl-c QsnSclCR 'QsnSclCR';
dcl-c QsnSclFF 'QsnSclFF';
dcl-c QsnSclLF 'QsnSclLF';
dcl-c QsnSclNL 'QsnSclNL';
dcl-c QsnSclTab 'QsnSclTab';
dcl-c QsnSetCsrA 'QsnSetCsrAdr';
dcl-c QsnSetCWin 'QsnSetCurWin';
dcl-c QsnSetEnvW 'QsnSetEnvWinMod';
dcl-c QsnSetErr 'QsnSetErr';
dcl-c QsnSetFld 'QsnSetFld';
dcl-c QsnSetOutA 'QsnSetOutAdr';
dcl-c QsnSetWinA 'QsnSetWinAtr';
dcl-c QsnShfSclL 'QsnShfSclL';
dcl-c QsnShfSclR 'QsnShfSclR';
dcl-c QsnStrWin 'QsnStrWin';
dcl-c QsnTglSclW 'QsnTglSclWrp';
dcl-c QsnWrtDta 'QsnWrtDta';
dcl-c QsnWrtPad 'QsnWrtPad';
dcl-c QsnWrtPadA 'QsnWrtPadAdr';
dcl-c QsnWrtSclC 'QsnWrtSclChr';
dcl-c QsnWrtSclL 'QsnWrtSclLin';
dcl-c QsnWrtSFMj 'QsnWrtSFMaj';
dcl-c QsnWrtSFMn 'QsnWrtSFMin';
dcl-c QsnWrtTDta 'QsnWrtTDta';
dcl-c QsnWTD 'QsnWTD';


// Structure definitions.


dcl-ds QsnEnvExtI;
  // Data structure for QsnCrtEnv API.
  QsnEEDta pointer;
  QsnEEChg pointer(*proc);
  QsnEEDlt pointer(*proc);
end-ds;

dcl-ds QsnEnvD;
  // Data structure for QsnCrtEnv and QsnChgEnv APIs
  QsnEnvColr char(1);
  QsnEnvCDRA char(1);
  QsnEnvCDR3 char(1);
  QsnEnvDBCS char(1);
  QsnEnvCoex char(1);
  QsnEnvAltH char(1);
  QsnEnvTgtD char(10);
  QsnEnvDspF char(20);
end-ds;

dcl-ds QsnREnvD;
  // Data structure for QsnRtvEnvD API.
  QsnRERet  int(10);
  QsnREAvl  int(10);
  QsnREColr char(1);
  QsnRECDRA char(1);
  QsnRECDR3 char(1);
  QsnREDBCS char(1);
  QsnRECoex char(1);
  QsnREAltH char(1);
  QsnRETgtD char(10);
  QsnREDspF char(20);
end-ds;

dcl-ds QsnEnvWM;
  // Data structures for QsnSetEnvWinMod API.
  QsnEWAtrC char(1);
  QsnEWULR  int(10);
  QsnEWULC  int(10);
  QsnEWNumR int(10);
  QsnEWNumC int(10);
end-ds;

dcl-ds QsnREnvWM;
  // Data structures for QsnRtvEnvWinMod API.
  QsnREWRet  int(10);
  QsnREWAvl  int(10);
  QsnREWMode char(1);
  QsnREWAtr  char(1);
  QsnREWULR  int(10);
  QsnREWULC  int(10);
  QsnREWNumR int(10);
  QsnREWNumC int(10);
end-ds;

dcl-ds QsnQ5250;
  // Data structure for QsnQry5250 API.
  QsnQ5Ret   int(10);
  QsnQ5Avl   int(10);
  QsnQ5Stat  char(1);
  QsnQ5Wkstn int(5);
  QsnQ5CLvl  char(3);
  QsnQ5R1    char(16);
  QsnQ5WType char(1);
  QsnQ5MType char(4);
  QsnQ5Model char(3);
  QsnQ5KbdID char(1);
  QsnQ5EKbd  char(1);
  QsnQ5PcKbd char(1);
  QsnQ5SNum  char(4);
  QsnQ5MaxIn int(5);
  QsnQ5WSCSp char(2);
  QsnQ5R2    char(1);
  QsnQ5WSCB1 char(1);
  QsnQ5WSCB2 char(1);
  QsnQ5WSCB3 char(1);
  QsnQ5WSCB4 char(1);
  QsnQ5WSCB5 char(1);
  QsnQ5R3    char(5);
  QsnQ5Prt   char(1);
  QsnQ5R4    char(1);
  QsnQ5GrdBf char(1);
  QsnQ5R5    char(9);
end-ds;
//Note: this may be expanded in the future

dcl-ds QsnReadInf;
  // Data structure for QsnRtvReadInf API.
  QsnRIRet   int(10);
  QsnRIAvl   int(10);
  QsnRIR1    char(8);
  QsnRIDta   pointer;
  QsnRIFDta  pointer;
  QsnRIDtaL  int(10);
  QsnRIFDtaL int(10);
  QsnRINumF  int(10);
  readLen    int(10);
  QsnRIRow   int(10);
  QsnRICol   int(10);
  QsnRIAID   char(1);
  QsnRIR2    char(7);
end-ds;

dcl-ds QsnFldInf;
  // Data structure for QsnRtvFldInf API.
  QsnFIRet   int(10);
  QsnFIAvl   int(10);
  QsnFIType  char(1);
  QsnFIRow   int(10);
  QsnFICol   int(10);
  QsnFIFDtaL int(10);
  QsnFIR1    char(11);
  QsnFIDta   pointer;
end-ds;

dcl-ds QsnWinExtI;
  // Data structure for QsnCrtWin API
  QsnWEDta   pointer;
  QsnWEChg   pointer(*proc);
  QsnWEDlt   pointer(*proc);
  QsnWECoord pointer(*proc);
  QsnWEDraw  pointer(*proc);
  QsnWECur   pointer(*proc);
end-ds;

dcl-ds QsnWinD;
  // Data structures for QsnCrtWin and QsnChgWin APIs.
  QsnWTopR   int(10);
  QsnWLeftC  int(10);
  QsnWNumR   int(10);
  QsnWNumC   int(10);
  QsnWMinR   int(10);
  QsnWMinC   int(10);
  QsnWMaxR   int(10);
  QsnWMaxC   int(10);
  QsnWFS     char(1);
  QsnWAtrM1  char(1);
  QsnWAtrM2  char(1);
  QsnWAtrM3  char(1);
  QsnWAtrC1  char(1);
  QsnWAtrC2  char(1);
  QsnWAtrC3  char(1);
  QsnWShowB  char(1);
  QsnWShowBA char(1);
  QsnWShowLA char(1);
  QsnWShowRA char(1);
  QsnWMsgL   char(1);
  QsnWULCh   char(1);
  QsnWTopCh  char(1);
  QsnWURCh   char(1);
  QsnWLCh    char(1);
  QsnWRCh    char(1);
  QsnWLLCh   char(1);
  QsnWBotCh  char(1);
  QsnWLRCh   char(1);
  QsnWGUI    char(1);
  QsnWFlg1   char(1);
  QsnWFlg2   char(1);
  QsnWR1     char(1);
  QsnWBdrF   char(1);
  QsnWTtlF   char(1);
  QsnWTAtrM  char(1);
  QsnWTAtrC  char(1);
  QsnWR2     char(1);
  QsnWR3     char(3);
  QsnWTtlO   int(10);
  QsnWTtlL   int(10);
  QsnWR4     int(10);
end-ds;

dcl-ds QsnRWinD;
  // Data structure for QsnRtvWinD API.
  QsnRWRet   int(10);
  QsnRWAvl   int(10);
  QsnRWTopR  int(10);
  QsnRWLeftC int(10);
  QsnRWNumR  int(10);
  QsnRWNumC  int(10);
  QsnRWMinR  int(10);
  QsnRWMinC  int(10);
  QsnRWMaxR  int(10);
  QsnRWMaxC  int(10);
  QsnRWFS    char(1);
  QsnRWAtrM1 char(1);
  QsnRWAtrM2 char(1);
  QsnRWAtrM3 char(1);
  QsnRWAtrC1 char(1);
  QsnRWAtrC2 char(1);
  QsnRWAtrC3 char(1);
  QsnRWShwB  char(1);
  QsnRWShwBA char(1);
  QsnRWShwLA char(1);
  QsnRWShwRA char(1);
  QsnRWMsgL  char(1);
  QsnRWULCh  char(1);
  QsnRWTopCh char(1);
  QsnRWURCh  char(1);
  QsnRWLCh   char(1);
  QsnRWRCh   char(1);
  QsnRWLLCh  char(1);
  QsnRWBotCh char(1);
  QsnRWLRCh  char(1);
  QsnRWGUI   char(1);
  QsnRWFlg1  char(1);
  QsnRWFlg2  char(1);
  QsnRWR1    char(1);
  QsnRWBdrF  char(1);
  QsnRWTtlF  char(1);
  QsnRWTAtrM char(1);
  QsnRWTAtrC char(1);
  QsnRWR2    char(1);
  QsnRWR3    char(3);
  QsnRWTtlO  int(10);
  QsnRWTtlL  int(10);
  QsnRWR4    int(10);
end-ds;

dcl-ds QsnSsnExtI;
  // Data structure for QsnCrtSsn API
  QsnSEDta   pointer;
  QsnSEChg   pointer(*proc);
  QsnSEDlt   pointer(*proc);
  QsnSECoord pointer(*proc);
  QsnSEDraw  pointer(*proc);
  QsnSECur   pointer(*proc);
end-ds;

dcl-ds QsnSsnD;
  // Data structure for QsnCrtSsn and QsnChgSsn APIs
  QsnSActn  pointer(*proc) dim(24);
  QsnSTRow  int(10);
  QsnSLCol  int(10);
  QsnSNRows int(10);
  QsnSNCols int(10);
  QsnSRollA int(10);
  QsnSShftA int(10);
  QsnSISize int(10);
  QsnSMSize int(10);
  QsnSIncr  int(10);
  QsnSIRows int(10);
  QsnSR1    char(1);
  QsnSWrap  char(1);
  QsnSR2    char(1);
  QsnEBCDIC char(1);
  QsnSEcho  char(1);
  QsnSLDsp  char(1);
  QsnSCDsp  char(1);
  QsnSShowC char(1);
  QsnSCmdAM char(1);
  QsnSCmdAC char(1);
  QsnSR3    char(2);
  QsnSPmtO  int(10);
  QsnSPmtL  int(10);
  QsnSCmdO1 int(10);
  QsnSCmdL1 int(10);
  QsnSCmdO2 int(10);
  QsnSCmdL2 int(10);
  QsnSR4    char(20);
end-ds;

dcl-ds QsnRSsnD;
  // Data structure for QsnRtvSsnD APIs
  QsnRSRet   int(10);
  QsnRSAvl   int(10);
  QsnRSR1    char(8);
  QsnRSActn  pointer(*proc) dim(24);
  QsnRSTRow  int(10);
  QsnRSLCol  int(10);
  QsnRSNRows int(10);
  QsnRSNCols int(10);
  QsnRSRollA int(10);
  QsnRSShftA int(10);
  QsnRSISize int(10);
  QsnRSMSize int(10);
  QsnRSIncr  int(10);
  QsnRSIRows int(10);
  QsnRSR2    char(1);
  QsnRSWrap  char(1);
  QsnRSR3    char(1);
  QsnREBCDIC char(1);
  QsnRSEcho  char(1);
  QsnRSLDsp  char(1);
  QsnRSCDsp  char(1);
  QsnRSShowC char(1);
  QsnRSCmdAM char(1);
  QsnRSCmdAC char(1);
  QsnRSR4    char(2);
  QsnRSPmtO  int(10);
  QsnRSPmtL  int(10);
  QsnRSCmdO1 int(10);
  QsnRSCmdL1 int(10);
  QsnRSCmdO2 int(10);
  QsnRSCmdL2 int(10);
  QsnRSR5    char(20);
end-ds;
