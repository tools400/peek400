      **************************************************************************
      *                                                                        *
      * Definitions for DSM service program QSNAPI                             *
      *                                                                        *
      **************************************************************************

      *
      * Constant definitions.
      *

      * Constants for environment definition.
     DQsnColorN        C                   '1'
     DQsnColorY        C                   '2'
     DQsnColorS        C                   '3'
     DQsnCDRAS         C                   '1'
     DQsnCDRAC         C                   '2'
     DQsnDBCSS         C                   '1'
     DQsnDBCSO         C                   '2'
     DQsnDBCSE         C                   '3'
     DQsnDBCSM         C                   '4'
     DQsnCoexY         C                   '1'
     DQsnCoexN         C                   '2'
     DQsnAHelpN        C                   '1'
     DQsnTgtReq        C                   '*REQUESTER'


     DQsnSame          C                   '0'
     DQsnDSP03         C                   '3'
     DQsnDSP04         C                   '4'

     DQsnF1            C                   X'31'
     DQsnF2            C                   X'32'
     DQsnF3            C                   X'33'
     DQsnF4            C                   X'34'
     DQsnF5            C                   X'35'
     DQsnF6            C                   X'36'
     DQsnF7            C                   X'37'
     DQsnF8            C                   X'38'
     DQsnF9            C                   X'39'
     DQsnF10           C                   X'3A'
     DQsnF11           C                   X'3B'
     DQsnF12           C                   X'3C'
     DQsnF13           C                   X'B1'
     DQsnF14           C                   X'B2'
     DQsnF15           C                   X'B3'
     DQsnF16           C                   X'B4'
     DQsnF17           C                   X'B5'
     DQsnF18           C                   X'B6'
     DQsnF19           C                   X'B7'
     DQsnF20           C                   X'B8'
     DQsnF21           C                   X'B9'
     DQsnF22           C                   X'BA'
     DQsnF23           C                   X'BB'
     DQsnF24           C                   X'BC'
     DQsnSLP           C                   X'3F'
     DQsnFET           C                   X'50'
     DQsnPA1           C                   X'6C'
     DQsnPA2           C                   X'6E'
     DQsnPA3           C                   X'6B'
     DQsnClearK        C                   X'BD'
     DQsnEnterK        C                   X'F1'
     DQsnHelpK         C                   X'F3'
     DQsnRollDnK       C                   X'F4'
     DQsnRollUpK       C                   X'F5'
     DQsnPageUpK       C                   X'F4'
     DQsnPageDnK       C                   X'F5'
     DQsnPrintK        C                   X'F6'
     DQsnRecBSK        C                   X'F8'

     DQsn5250QY        C                   '1'
     DQsn5250QN        C                   '2'
     DQsn5250QF        C                   '3'

     DQsnCC1Null       C                   X'00'
     DQsnCC1Lock       C                   X'20'
     DQsnCC1MDTN       C                   X'40'
     DQsnCC1MDTA       C                   X'60'
     DQsnCC1ClrM       C                   X'80'
     DQsnCC1NBYA       C                   X'A0'
     DQsnCC1NBYM       C                   X'C0'
     DQsnCC1All        C                   X'E0'

     DQsnCC2Null       C                   X'00'
     DQsnCC2NoIC       C                   X'40'
     DQsnCC2RstB       C                   X'20'
     DQsnCC2SetB       C                   X'10'
     DQsnCC2Unlk       C                   X'08'
     DQsnCC2Alrm       C                   X'04'
     DQsnCC2MOff       C                   X'02'
     DQsnCC2MOn        C                   X'01'

     DQsnNoSA          C                   X'00'
     DQsnSANorm        C                   X'20'
     DQsnSACS          C                   X'30'
     DQsnSABL          C                   X'28'
     DQsnSAUL          C                   X'24'
     DQsnSAHI          C                   X'22'
     DQsnSARI          C                   X'21'
     DQsnSAND          C                   X'27'

     DQsnGrn           C                   X'20'
     DQsnGrnRI         C                   X'21'
     DQsnWht           C                   X'22'
     DQsnWhtRI         C                   X'23'
     DQsnGrnUL         C                   X'24'
     DQsnGrnULRI       C                   X'25'
     DQsnWhtUL         C                   X'26'
     DQsnRed           C                   X'28'
     DQsnRedRI         C                   X'29'
     DQsnRedBL         C                   X'2A'
     DQsnRedRIBL       C                   X'2B'
     DQsnRedUL         C                   X'2C'
     DQsnRedULRI       C                   X'2D'
     DQsnRedULBL       C                   X'2E'
     DQsnND2F          C                   X'2F'
     DQsnTrqCS         C                   X'30'
     DQsnTrqCSRI       C                   X'31'
     DQsnYlwCS         C                   X'32'
     DQsnYlwCSRI       C                   X'33'
     DQsnTrqUL         C                   X'34'
     DQsnTrqULRI       C                   X'35'
     DQsnYlwUL         C                   X'36'
     DQsnND37          C                   X'37'
     DQsnPnk           C                   X'38'
     DQsnPnkRI         C                   X'39'
     DQsnBlu           C                   X'3A'
     DQsnBluRI         C                   X'3B'
     DQsnPnkUL         C                   X'3C'
     DQsnPnkULRI       C                   X'3D'
     DQsnBluUL         C                   X'3E'
     DQsnND3F          C                   X'3F'

     DQsnSO            C                   X'0E'
     DQsnSI            C                   X'0F'

     DQsnNOFFW         C                   X'0000'
     DQsnBypass        C                   X'6000'
     DQsnDup           C                   X'5000'
     DQsnMDT           C                   X'4800'
     DQsnAlphaS        C                   X'4000'
     DQsnAlphaO        C                   X'4100'
     DQsnNumS          C                   X'4200'
     DQsnNumO          C                   X'4300'
     DQsnKata          C                   X'4400'
     DQsnDig           C                   X'4500'
     DQsnFFWIO         C                   X'4600'
     DQsnSigned        C                   X'4700'
     DQsnFFWAE         C                   X'4080'
     DQsnFER           C                   X'4040'
     DQsnMono          C                   X'4020'
     DQsnFFWME         C                   X'4008'
     DQsnNoAdj         C                   X'4000'
     DQsnRAZero        C                   X'4005'
     DQsnRABlank       C                   X'4006'
     DQsnFFWMF         C                   X'4007'

     DQsnFCWRes        C                   X'8000'
     DQsnFCWMSR        C                   X'8101'
     DQsnFCWSLP        C                   X'8102'
     DQsnMSRSLP        C                   X'8103'
     DQsnSLPSA         C                   X'8106'
     DQsnFCWDBOn       C                   X'8200'
     DQsnFCWDBP        C                   X'8220'
     DQsnFCWDBE        C                   X'8240'
     DQsnFCWDBOp       C                   X'8280'
     DQsnFCWDBOC       C                   X'82C0'
     DQsnTransp        C                   X'8400'
     DQsnFCWFET        C                   X'8501'
     DQsnContF         C                   X'8601'
     DQsnContL         C                   X'8602'
     DQsnContM         C                   X'8603'
     DQsnFCWCP         C                   X'8800'
     DQsnFCWHL         C                   X'8900'
     DQsnFCWPDS        C                   X'8A00'
     DQsnMod11         C                   X'B140'
     DQsnMod10         C                   X'B1A0'

     DQsnHT            C                   X'05'
     DQsnVT            C                   X'0B'
     DQsnFF            C                   X'0C'
     DQsnCR            C                   X'0D'
     DQsnNL            C                   X'15'
     DQsnBS            C                   X'16'
     DQsnBEL           C                   X'2F'

     DQsnBeep          C                   'QsnBeep'
     DQsnChgEnv        C                   'QsnChgEnv'
     DQsnChgSsn        C                   'QsnChgSsn'
     DQsnChgWin        C                   'QsnChgWin'
     DQsnClrBuf        C                   'QsnClrBuf'
     DQsnClrFldT       C                   'QsnClrFldTbl'
     DQsnClrScl        C                   'QsnClrScl'
     DQsnClrScr        C                   'QsnClrScr'
     DQsnClrWin        C                   'QsnClrWin'
     DQsnClrWinM       C                   'QsnClrWinMsg'
     DQsnCpyBuf        C                   'QsnCpyBuf'
     DQsnCrtCBuf       C                   'QsnCrtCmdBuf'
     DQsnCrtEnv        C                   'QsnCrtEnv'
     DQsnCrtIBuf       C                   'QsnCrtInpBuf'
     DQsnCrtSsn        C                   'QsnCrtSsn'
     DQsnCrtWin        C                   'QsnCrtWin'
     DQsnDftAct        C                   'QsnDefaultAction'
     DQsnDltBuf        C                   'QsnDltBuf'
     DQsnDltEnv        C                   'QsnDltEnv'
     DQsnDltFldI       C                   'QsnDltFldId'
     DQsnDspSclB       C                   'QsnDspSclB'
     DQsnDspSclT       C                   'QsnDspSclT'
     DQsnDspWin        C                   'QsnDspWin'
     DQsnEndWin        C                   'QsnEndWin'
     DQsnGetAID        C                   'QsnGetAID'
     DQsnGetCsrA       C                   'QsnGetCsrAdr'
     DQsnGetCsrD       C                   'QsnGetCsrAdrAID'
     DQsnInsCsr        C                   'QsnInsCsr'
     DQsnInzEnvD       C                   'QsnInzEnvD'
     DQsnInzSsnD       C                   'QsnInzSsnD'
     DQsnInzWinD       C                   'QsnInzWinD'
     DQsnMovWin        C                   'QsnMovWin'
     DQsnMovWinU       C                   'QsnMovWinUsr'
     DQsnPrtScl        C                   'QsnPrtScl'
     DQsnPutBuf        C                   'QsnPutBuf'
     DQsnPutGBuf       C                   'QsnPutGetBuf'
     DQsnPutICmd       C                   'QsnPutInpCmd'
     DQsnPutOCmd       C                   'QsnPutOutCmd'
     DQsnPutWinM       C                   'QsnPutWinMsg'
     DQsnQColor        C                   'QsnQryColorSup'
     DQsnQModSup       C                   'QsnQryModSup'
     DQsnQSclWrp       C                   'QsnQrySclWrp'
     DQsnQry5250       C                   'QsnQry5250'
     DQsnReadImm       C                   'QsnReadImm'
     DQsnReadInp       C                   'QsnReadInp'
     DQsnReadMDT       C                   'QsnReadMDT'
     DQsnReadMA        C                   'QsnReadMDTAlt'
     DQsnReadMAI       C                   'QsnReadMDTImmAlt'
     DQsnReadScr       C                   'QsnReadScr'
     DQsnReadSsn       C                   'QsnReadSsnDta'
     DQsnRollD         C                   'QsnRollDown'
     DQsnRolSclD       C                   'QsnRollSclDown'
     DQsnRolSclU       C                   'QsnRollSclUp'
     DQsnRollUp        C                   'QsnRollUp'
     DQsnRstScr        C                   'QsnRstScr'
     DQsnRszWin        C                   'QsnRszWin'
     DQsnRszWinU       C                   'QsnRszWinUsr'
     DQsnRtvBufL       C                   'QsnRtvBufLen'
     DQsnRtvBufS       C                   'QsnRtvBufSiz'
     DQsnRtvCWin       C                   'QsnRtvCurWin'
     DQsnRtvDta        C                   'QsnRtvDta'
     DQsnRtvDtaL       C                   'QsnRtvDtaLen'
     DQsnRtvEnvD       C                   'QsnRtvEnvD'
     DQsnRtvEnvU       C                   'QsnRtvEnvDta'
     DQsnRtvEnvW       C                   'QsnRtvEnvWinMod'
     DQsnRtvFldC       C                   'QsnRtvFldCnt'
     DQsnRtvFldD       C                   'QsnRtvFldDta'
     DQsnRtvFldL       C                   'QsnRtvFldDtaLen'
     DQsnRtvFldI       C                   'QsnRtvFldInf'
     DQsnRtvMod        C                   'QsnRtvMod'
     DQsnRtvRdA        C                   'QsnRtvReadAdr'
     DQsnRtvRdAD       C                   'QsnRtvReadAID'
     DQsnRtvRdI        C                   'QsnRtvReadInf'
     DQsnRtvRdL        C                   'QsnRtvReadLen'
     DQsnRtvSclR       C                   'QsnRtvSclNumRoll'
     DQsnRtvSclS       C                   'QsnRtvSclNumShf'
     DQsnRtvScrD       C                   'QsnRtvScrDim'
     DQsnRtvSsnD       C                   'QsnRtvSsnD'
     DQsnRtvSsnU       C                   'QsnRtvSsnDta'
     DQsnRtvSsnL       C                   'QsnRtvSsnLin'
     DQsnRtvWinD       C                   'QsnRtvWinD'
     DQsnRtvWinU       C                   'QsnRtvWinDta'
     DQsnSameAct       C                   'QsnSameAction'
     DQsnSavScr        C                   'QsnSavScr'
     DQsnSclBS         C                   'QsnSclBS'
     DQsnSclCR         C                   'QsnSclCR'
     DQsnSclFF         C                   'QsnSclFF'
     DQsnSclLF         C                   'QsnSclLF'
     DQsnSclNL         C                   'QsnSclNL'
     DQsnSclTab        C                   'QsnSclTab'
     DQsnSetCsrA       C                   'QsnSetCsrAdr'
     DQsnSetCWin       C                   'QsnSetCurWin'
     DQsnSetEnvW       C                   'QsnSetEnvWinMod'
     DQsnSetErr        C                   'QsnSetErr'
     DQsnSetFld        C                   'QsnSetFld'
     DQsnSetOutA       C                   'QsnSetOutAdr'
     DQsnSetWinA       C                   'QsnSetWinAtr'
     DQsnShfSclL       C                   'QsnShfSclL'
     DQsnShfSclR       C                   'QsnShfSclR'
     DQsnStrWin        C                   'QsnStrWin'
     DQsnTglSclW       C                   'QsnTglSclWrp'
     DQsnWrtDta        C                   'QsnWrtDta'
     DQsnWrtPad        C                   'QsnWrtPad'
     DQsnWrtPadA       C                   'QsnWrtPadAdr'
     DQsnWrtSclC       C                   'QsnWrtSclChr'
     DQsnWrtSclL       C                   'QsnWrtSclLin'
     DQsnWrtSFMj       C                   'QsnWrtSFMaj'
     DQsnWrtSFMn       C                   'QsnWrtSFMin'
     DQsnWrtTDta       C                   'QsnWrtTDta'
     DQsnWTD           C                   'QsnWTD'

      *
      * Structure definitions.
      *

     DQsnEnvExtI       DS
      * Data structure for QsnCrtEnv API.
     D  QsnEEDta                     16*
     D  QsnEEChg                     16*   Procptr
     D  QsnEEDlt                     16*   Procptr

     DQsnEnvD          DS
      * Data structure for QsnCrtEnv and QsnChgEnv APIs
     D  QsnEnvColr                    1A
     D  QsnEnvCDRA                    1A
     D  QsnEnvCDR3                    1A
     D  QsnEnvDBCS                    1A
     D  QsnEnvCoex                    1A
     D  QsnEnvAltH                    1A
     D  QsnEnvTgtD                   10A
     D  QsnEnvDspF                   20A

     DQsnREnvD         DS
      * Data structure for QsnRtvEnvD API.
     D  QsnRERet                     10I 0
     D  QsnREAvl                     10I 0
     D  QsnREColr                     1A
     D  QsnRECDRA                     1A
     D  QsnRECDR3                     1A
     D  QsnREDBCS                     1A
     D  QsnRECoex                     1A
     D  QsnREAltH                     1A
     D  QsnRETgtD                    10A
     D  QsnREDspF                    20A

     DQsnEnvWM         DS
      * Data structures for QsnSetEnvWinMod API.
     D  QsnEWAtrC                     1A
     D  QsnEWULR                     10I 0
     D  QsnEWULC                     10I 0
     D  QsnEWNumR                    10I 0
     D  QsnEWNumC                    10I 0

     DQsnREnvWM        DS
      * Data structures for QsnRtvEnvWinMod API.
     D  QsnREWRet                    10I 0
     D  QsnREWAvl                    10I 0
     D  QsnREWMode                    1A
     D  QsnREWAtr                     1A
     D  QsnREWULR                    10I 0
     D  QsnREWULC                    10I 0
     D  QsnREWNumR                   10I 0
     D  QsnREWNumC                   10I 0

     DQsnQ5250         DS
      * Data structure for QsnQry5250 API.
     D  QsnQ5Ret                     10I 0
     D  QsnQ5Avl                     10I 0
     D  QsnQ5Stat                     1A
     D  QsnQ5Wkstn                    5I 0
     D  QsnQ5CLvl                     3A
     D  QsnQ5R1                      16A
     D  QsnQ5WType                    1A
     D  QsnQ5MType                    4A
     D  QsnQ5Model                    3A
     D  QsnQ5KbdID                    1A
     D  QsnQ5EKbd                     1A
     D  QsnQ5PcKbd                    1A
     D  QsnQ5SNum                     4A
     D  QsnQ5MaxIn                    5I 0
     D  QsnQ5WSCSp                    2A
     D  QsnQ5R2                       1A
     D  QsnQ5WSCB1                    1A
     D  QsnQ5WSCB2                    1A
     D  QsnQ5WSCB3                    1A
     D  QsnQ5WSCB4                    1A
     D  QsnQ5WSCB5                    1A
     D  QsnQ5R3                       5A
     D  QsnQ5Prt                      1A
     D  QsnQ5R4                       1A
     D  QsnQ5GrdBf                    1A
     D  QsnQ5R5                       9A
      *Note: this may be expanded in the future

     DQsnReadInf       DS
      * Data structure for QsnRtvReadInf API.
     D  QsnRIRet                     10I 0
     D  QsnRIAvl                     10I 0
     D  QsnRIR1                       8A
     D  QsnRIDta                     16*
     D  QsnRIFDta                    16*
     D  QsnRIDtaL                    10I 0
     D  QsnRIFDtaL                   10I 0
     D  QsnRINumF                    10I 0
     D  ReadLen                      10I 0
     D  QsnRIRow                     10I 0
     D  QsnRICol                     10I 0
     D  QsnRIAID                      1A
     D  QsnRIR2                       7A

     DQsnFldInf        DS
      * Data structure for QsnRtvFldInf API.
     D  QsnFIRet                     10I 0
     D  QsnFIAvl                     10I 0
     D  QsnFIType                     1A
     D  QsnFIRow                     10I 0
     D  QsnFICol                     10I 0
     D  QsnFIFDtaL                   10I 0
     D  QsnFIR1                      11A
     D  QsnFIDta                     16*

     DQsnWinExtI       DS
      * Data structure for QsnCrtWin API
     D  QsnWEDta                     16*
     D  QsnWEChg                     16*   Procptr
     D  QsnWEDlt                     16*   Procptr
     D  QsnWECoord                   16*   Procptr
     D  QsnWEDraw                    16*   Procptr
     D  QsnWECur                     16*   Procptr

     DQsnWinD          DS
      * Data structures for QsnCrtWin and QsnChgWin APIs.
     D  QsnWTopR                     10I 0
     D  QsnWLeftC                    10I 0
     D  QsnWNumR                     10I 0
     D  QsnWNumC                     10I 0
     D  QsnWMinR                     10I 0
     D  QsnWMinC                     10I 0
     D  QsnWMaxR                     10I 0
     D  QsnWMaxC                     10I 0
     D  QsnWFS                        1A
     D  QsnWAtrM1                     1A
     D  QsnWAtrM2                     1A
     D  QsnWAtrM3                     1A
     D  QsnWAtrC1                     1A
     D  QsnWAtrC2                     1A
     D  QsnWAtrC3                     1A
     D  QsnWShowB                     1A
     D  QsnWShowBA                    1A
     D  QsnWShowLA                    1A
     D  QsnWShowRA                    1A
     D  QsnWMsgL                      1A
     D  QsnWULCh                      1A
     D  QsnWTopCh                     1A
     D  QsnWURCh                      1A
     D  QsnWLCh                       1A
     D  QsnWRCh                       1A
     D  QsnWLLCh                      1A
     D  QsnWBotCh                     1A
     D  QsnWLRCh                      1A
     D  QsnWGUI                       1A
     D  QsnWFlg1                      1A
     D  QsnWFlg2                      1A
     D  QsnWR1                        1A
     D  QsnWBdrF                      1A
     D  QsnWTtlF                      1A
     D  QsnWTAtrM                     1A
     D  QsnWTAtrC                     1A
     D  QsnWR2                        1A
     D  QsnWR3                        3A
     D  QsnWTtlO                     10I 0
     D  QsnWTtlL                     10I 0
     D  QsnWR4                       10I 0

     DQsnRWinD         DS
      * Data structure for QsnRtvWinD API.
     D  QsnRWRet                     10I 0
     D  QsnRWAvl                     10I 0
     D  QsnRWTopR                    10I 0
     D  QsnRWLeftC                   10I 0
     D  QsnRWNumR                    10I 0
     D  QsnRWNumC                    10I 0
     D  QsnRWMinR                    10I 0
     D  QsnRWMinC                    10I 0
     D  QsnRWMaxR                    10I 0
     D  QsnRWMaxC                    10I 0
     D  QsnRWFS                       1A
     D  QsnRWAtrM1                    1A
     D  QsnRWAtrM2                    1A
     D  QsnRWAtrM3                    1A
     D  QsnRWAtrC1                    1A
     D  QsnRWAtrC2                    1A
     D  QsnRWAtrC3                    1A
     D  QsnRWShwB                     1A
     D  QsnRWShwBA                    1A
     D  QsnRWShwLA                    1A
     D  QsnRWShwRA                    1A
     D  QsnRWMsgL                     1A
     D  QsnRWULCh                     1A
     D  QsnRWTopCh                    1A
     D  QsnRWURCh                     1A
     D  QsnRWLCh                      1A
     D  QsnRWRCh                      1A
     D  QsnRWLLCh                     1A
     D  QsnRWBotCh                    1A
     D  QsnRWLRCh                     1A
     D  QsnRWGUI                      1A
     D  QsnRWFlg1                     1A
     D  QsnRWFlg2                     1A
     D  QsnRWR1                       1A
     D  QsnRWBdrF                     1A
     D  QsnRWTtlF                     1A
     D  QsnRWTAtrM                    1A
     D  QsnRWTAtrC                    1A
     D  QsnRWR2                       1A
     D  QsnRWR3                       3A
     D  QsnRWTtlO                    10I 0
     D  QsnRWTtlL                    10I 0
     D  QsnRWR4                      10I 0

     DQsnSsnExtI       DS
      * Data structure for QsnCrtSsn API
     D  QsnSEDta                     16*
     D  QsnSEChg                     16*   Procptr
     D  QsnSEDlt                     16*   Procptr
     D  QsnSECoord                   16*   Procptr
     D  QsnSEDraw                    16*   Procptr
     D  QsnSECur                     16*   Procptr

     DQsnSsnD          DS
      * Data structure for QsnCrtSsn and QsnChgSsn APIs
     D  QsnSActn                     16*   Procptr Dim(24)
     D  QsnSTRow                     10I 0
     D  QsnSLCol                     10I 0
     D  QsnSNRows                    10I 0
     D  QsnSNCols                    10I 0
     D  QsnSRollA                    10I 0
     D  QsnSShftA                    10I 0
     D  QsnSISize                    10I 0
     D  QsnSMSize                    10I 0
     D  QsnSIncr                     10I 0
     D  QsnSIRows                    10I 0
     D  QsnSR1                        1A
     D  QsnSWrap                      1A
     D  QsnSR2                        1A
     D  QsnEBCDIC                     1A
     D  QsnSEcho                      1A
     D  QsnSLDsp                      1A
     D  QsnSCDsp                      1A
     D  QsnSShowC                     1A
     D  QsnSCmdAM                     1A
     D  QsnSCmdAC                     1A
     D  QsnSR3                        2A
     D  QsnSPmtO                     10I 0
     D  QsnSPmtL                     10I 0
     D  QsnSCmdO1                    10I 0
     D  QsnSCmdL1                    10I 0
     D  QsnSCmdO2                    10I 0
     D  QsnSCmdL2                    10I 0
     D  QsnSR4                       20A

     DQsnRSsnD         DS
      * Data structure for QsnRtvSsnD APIs
     D  QsnRSRet                     10I 0
     D  QsnRSAvl                     10I 0
     D  QsnRSR1                       8A
     D  QsnRSActn                    16*   Procptr Dim(24)
     D  QsnRSTRow                    10I 0
     D  QsnRSLCol                    10I 0
     D  QsnRSNRows                   10I 0
     D  QsnRSNCols                   10I 0
     D  QsnRSRollA                   10I 0
     D  QsnRSShftA                   10I 0
     D  QsnRSISize                   10I 0
     D  QsnRSMSize                   10I 0
     D  QsnRSIncr                    10I 0
     D  QsnRSIRows                   10I 0
     D  QsnRSR2                       1A
     D  QsnRSWrap                     1A
     D  QsnRSR3                       1A
     D  QsnREBCDIC                    1A
     D  QsnRSEcho                     1A
     D  QsnRSLDsp                     1A
     D  QsnRSCDsp                     1A
     D  QsnRSShowC                    1A
     D  QsnRSCmdAM                    1A
     D  QsnRSCmdAC                    1A
     D  QsnRSR4                       2A
     D  QsnRSPmtO                    10I 0
     D  QsnRSPmtL                    10I 0
     D  QsnRSCmdO1                   10I 0
     D  QsnRSCmdL1                   10I 0
     D  QsnRSCmdO2                   10I 0
     D  QsnRSCmdL2                   10I 0
     D  QsnRSR5                      20A
