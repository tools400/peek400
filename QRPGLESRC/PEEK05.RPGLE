**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.2.0                               *
//  Programm : PEEK05                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 29.09.97  Raddatz                                 *
//  geändert : 27.04.99  für Version 2.1.0                       *
//  geändert : 29.04.99  für Version 2.2.0                       *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Hauptprogramm für Auswahl aus Subfile                        *
//                                                               *
// ============================================================= *
// >>PRE-COMPILER<<                                              *
//   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
//                           OBJLIB(&LI) DEVLIB(&LI) +           *
//                           SBMJOB(*NO) BNDDIR(PEEK) +          *
//                           INSTALL(*NO);                       *
//   >>EXECUTE<<                                                 *
// >>END-PRE-COMPILER<<                                          *
//===============================================================*
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

// Bildschirm
dcl-f peek05fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbsfl132: SflRec132)
  sfile(pbsfl080: SflRec080);

dcl-f peekfldl1 keyed rename(fpeekfld: fpeekfldl1) prefix(f_) usropn infds(Peek#L1);

dcl-f peekfld usage(*update: *delete) keyed prefix(f_) usropn infds(Peek#00);

dcl-ds workstn likeds(workstn_t);
dcl-ds cursorPosition likeds(cursorPosition_t) inz;

dcl-ds Peek#L1 likeds(infds_t);
dcl-ds Peek#00 likeds(infds_t);
dcl-ds File#X likeds(infds_t);

// Für Einzelsatzzugriff zum Löschen von Datensätzen
dcl-ds hFile00 likeds(hFile_t);

// Für Sortierung nach relativer Satznummer
dcl-ds hFile01 likeds(hFile_t);

// Für Sortierung nach Schlüsselfolge
dcl-ds hFile02 likeds(hFile_t);

// Für SQL Zugriff
dcl-ds hFile03 likeds(hFile_t);

// Für Einzelsatzzugriff zum reinen Lesen von Datensätzen
dcl-ds hFile04 likeds(hFile_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,D_COLORATR
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,SDS
/copy QCOPYLE,OBJD0400
/copy QCOPYLE,RCDL0200
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,MBRD0200
/copy QCOPYLE,FILD0100

/copy QCOPYLE,SET0001
/copy QCOPYLE,SET0002
/copy QCOPYLE,SET0003
/copy QCOPYLE,SET0005
/copy QCOPYLE,SET0006
/copy QCOPYLE,SET0007
/copy QCOPYLE,SET0008
/copy QCOPYLE,SET0009
/copy QCOPYLE,SET0010
/copy QCOPYLE,SET0011
/copy QCOPYLE,SET0013
/copy QCOPYLE,SET0014
/copy QCOPYLE,SET0015
/copy QCOPYLE,SET0016

/copy QCOPYLE,USR0007
/copy QCOPYLE,USR0008
/copy QCOPYLE,USR0009
/copy QCOPYLE,USR0010
/copy QCOPYLE,USR0013
/copy QCOPYLE,USR0014
/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8108
/copy QCOPYLE,USR8110
/copy QCOPYLE,USR8128
/copy QCOPYLE,USR8144
/copy QCOPYLE,USR8147
/copy QCOPYLE,USR8148
/copy QCOPYLE,USR8190
/copy QCOPYLE,USR8196
/copy QCOPYLE,USR8200
/copy QCOPYLE,USR8201
/copy QCOPYLE,USR8202
/copy QCOPYLE,USR8203
/copy QCOPYLE,USR8206
/copy QCOPYLE,USR8207
/copy QCOPYLE,USR8212
/copy QCOPYLE,USR8217
/copy QCOPYLE,USR8218
/copy QCOPYLE,USR8223
/copy QCOPYLE,USR8224
/copy QCOPYLE,USR8235
/copy QCOPYLE,USR9993
/copy QCOPYLE,USR9996
/copy QCOPYLE,USR9998
/copy QCOPYLE,USR9999

/define internal_prototype
/copy QCOPYLE,PPEEK05
/undefine internal_prototype

/copy QCOPYLE,PUPDPGM
/copy QCOPYLE,PPEEK01
/copy QCOPYLE,PPEEK03
/copy QCOPYLE,PPEEK04
/copy QCOPYLE,PPEEK06
/copy QCOPYLE,PPEEK07
/copy QCOPYLE,PPEEK08
/copy QCOPYLE,PPEEK09
/copy QCOPYLE,PPEEK10
/copy QCOPYLE,PPEEK12
/copy QCOPYLE,PPEEK13
/copy QCOPYLE,PPEEK14
/copy QCOPYLE,PPEEK17
/copy QCOPYLE,PPEEK18
/copy QCOPYLE,PPEEK19
/copy QCOPYLE,PPEEK20
/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK24
/copy QCOPYLE,PPEEK26
/copy QCOPYLE,PPEEK27
/copy QCOPYLE,PPEEK30
/copy QCOPYLE,PPEEK32
/copy QCOPYLE,PPEEK33
/copy QCOPYLE,PPEEK34
/copy QCOPYLE,PPEEK37
/copy QCOPYLE,PPEEK38
/copy QCOPYLE,PPEEK40
/copy QCOPYLE,PPEEK41
/copy QCOPYLE,PPEEK42
/copy QCOPYLE,PPEEK47
/copy QCOPYLE,PPEEK48
/copy QCOPYLE,PPEEK49
/copy QCOPYLE,PPEEK50
/copy QCOPYLE,PPEEK52
/copy QCOPYLE,PPEEK54
/copy QCOPYLE,PPEEK55
/copy QCOPYLE,PPEEK56
/copy QCOPYLE,PPEEK57
/copy QCOPYLE,PPEEK59
/copy QCOPYLE,PPEEK65
/copy QCOPYLE,PPEEK68
/copy QCOPYLE,PPEEK69
/copy QCOPYLE,PPEEK51
/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK71
/copy QCOPYLE,PPEEK63

/copy QCOPYLE,PEXIT01
/copy QCOPYLE,PEXIT04

dcl-ds set0001 likeds(SET0001_t) inz;
dcl-ds set0002 likeds(SET0002_t) inz;
dcl-ds set0003 likeds(SET0003_t) inz;
dcl-ds set0005 likeds(SET0005_t) inz;
dcl-ds set0006 likeds(set0006_t) inz;
dcl-ds set0007 likeds(set0007_t) inz;
dcl-ds set0008 likeds(set0008_t) inz;
dcl-ds set0009 likeds(set0009_t) inz;
dcl-ds set0010 likeds(set0010_t) inz;
dcl-ds set0011 likeds(set0011_t) inz;
dcl-ds set0013 likeds(set0013_t) inz;
dcl-ds set0014 likeds(set0014_t) inz;
dcl-ds set0015 likeds(set0015_t) inz;
dcl-ds set0016 likeds(set0016_t) inz;

dcl-ds objd0400 likeds(OBJD0400_t) inz;
dcl-ds rcdl0200 likeds(RCDL0200_t) inz;
dcl-ds fldl0100 likeds(fldl0100_t) inz;
dcl-ds mbrd0200 likeds(MBRD0200_t) inz;
dcl-ds fild0100 likeds(FILD0100_t) inz;

dcl-pr f_int zoned(20);
  inpValue zoned(25: 5) value;
end-pr;

dcl-pr f_chain00 char(1);
  i_rrn    like(rcdNbr_t) value;
  i_file   like(file_t) value;
  i_lib    like(lib_t) value;
  i_mbr    like(mbr_t) value;
  i_rcdFmt char(10) value;
end-pr;

dcl-pr f_chain04 char(1);
  i_rrn    like(rcdNbr_t) value;
  i_file   like(file_t) value;
  i_lib    like(lib_t) value;
  i_mbr    like(mbr_t) value;
  i_rcdFmt char(10) value;
end-pr;

//----------------------------------------------------*
//  I N F D S - D E F I N I T I O N E N               *
//----------------------------------------------------*

dcl-ds IO_Buff;
  IO_BuffFld like(rcdBuf_t);
end-ds;

dcl-s IO_NullMap like(nullMap_t) dim(NULL_MAP_SIZE);

dcl-ds rtn qualified inz;
  file       like(##File);
  library    like(##Library);
  member     like(##Member);
  format     like(##Format);
  AccessMode like(AccessMode);
  sqlWhere   like(sqlWhere);
  sqlOrder   like(sqlOrder);
end-ds;

dcl-ds YQFile inz;
  YFile    like(file_t);
  yLibrary like(lib_t);
end-ds;

dcl-s isLicenceError like(bool_t) inz(bTrue);
dcl-s YFormat like(rcdFmt_t) inz;
dcl-s YMsgID char(7) inz;
dcl-s YMsgDta char(512) inz;

dcl-s yMember like(mbr_t) inz;

dcl-s YAttrLen like(int4_t) inz;
dcl-s YAttrTyp char(1) inz;
dcl-s YValue char(512) inz;

dcl-s YDsp80 like(SET0001_t.SET_Dsp80) inz;
dcl-s yCopyright like(copyright_t) inz(copyright);

dcl-s YFmtNbr int(5) inz;

dcl-s yHeaderType char(10) inz;
dcl-s yRcdNbr inz(0) like(rcdNbr_t);
dcl-s yFunction char(10) inz;
dcl-s yCommitLvl like(commitLvl) inz('0');
dcl-s yIsUpdKey inz(bFalse) like(isUpdKey);
dcl-s yScreenNbr like(int4_t) inz;
dcl-s yIsLower char(1) inz(bFalse);

dcl-ds yCursorPosition likeds(cursorPosition_t) inz;

dcl-s YCvtCcsid char(1) inz(bTrue);
dcl-s YData char(512) inz;

dcl-ds yRetFile likeds(qObj_t);

dcl-s YRtnCode char(1) inz;

dcl-s YField like(SrchField) inz;
dcl-s YOperation like(SrchOP) inz;
dcl-s YArgument like(SrchArg) inz;
dcl-s YSign like(SrchSign) inz;
dcl-s YSrchNbrs like(SrchNbrs) inz(0);
dcl-s YSrchType like(SrchType) inz;
dcl-s YSrchCase like(SrchCase) inz(bFalse);

dcl-s YBuffer like(rcdBuf_t) inz;
dcl-ds *n;
  YHexString like(hexBuf_t);
  YOutBuffer like(rcdBuf_t) overlay(YHexString: 1);
end-ds;

dcl-s YOutBuffLn like(int4_t) inz;
dcl-s YTgtValue char(10) inz;

dcl-s YKeyVal like(keyBuf_t) inz;

dcl-s YPgmCmd char(10) inz;
dcl-s YCmdDta like(pgmCmdDt_t) inz;

dcl-s yFKeys char(18) dim(32) inz;
dcl-s yNbrOfKeys like(int4_t) inz;

dcl-s YChoice like(choice_t) dim(32) inz;
dcl-s YNbrOfCh like(int4_t) inz;

dcl-s YFlag inz(*zeros) like(int4_t);

dcl-s BuffIdx like(int4_t) inz;

dcl-ds ShortCmd likeds(ShortCmd_t) inz;
dcl-s YExecCmd like(cmdBuffer_t) inz;
dcl-s YNbrOfEnt like(int4_t) inz;
dcl-s YSqlWhere like(sqlWhere_t) inz;
dcl-s YSqlOrder like(sqlOrder_t) inz;
dcl-s YAlwLc char(1) inz;
dcl-s YCase char(1) inz;
dcl-s YRcdLock char(1) inz;
dcl-s YNullDft char(1) inz;
dcl-s YKeepCrs char(1) inz;
dcl-s YEnvFile like(file_t) inz;
dcl-s YEnvLib like(lib_t) inz;
dcl-s YEnvMbr like(mbr_t) inz;
dcl-s YIsAutoSave like(bool_t) inz(bFalse);
dcl-s yIsKeyLower like(bool_t) inz;
dcl-s YOption like(option_t) inz;
dcl-s YText like(text_t);
dcl-s ySflOpt char(2);
dcl-s YString like(rcdBuf_t) inz;
dcl-s YStringLen like(int4_t) inz;

dcl-c HEX_CHAR '-';

dcl-s isReadSfl like(bool_t) inz(bFalse);
dcl-s IsPBINIT char(1) inz(bFalse);
dcl-s IsFirstSfl char(1) inz(bFalse);
dcl-s IsFileChg char(1) inz(bFalse);
dcl-s IsTblCol char(1) inz(bFalse);
dcl-s isTargetOK like(bool_t) inz(bFalse);
dcl-s isSeqNbrOK like(bool_t) inz(bFalse);
dcl-s IsOpen like(bool_t) inz(bFalse);
dcl-s isUpdMod like(bool_t) inz(bFalse);
dcl-s isUpdKey like(bool_t) inz(bFalse);
dcl-s isVisible like(bool_t) inz(bFalse);
dcl-s IsError like(bool_t) inz(bFalse);
dcl-s isFileError char(1) inz(bFalse);
dcl-s IsKeyAvail char(1) inz(bFalse);
dcl-s IsKeyChg char(1) inz(bFalse);
dcl-s isSflDirty char(1) inz(bFalse);
dcl-s isTryed char(1) inz(bFalse);
dcl-s IsPinned char(1) inz(bFalse);
dcl-s IsPinModeR char(1) inz(bFalse);
dcl-s isPinModeC char(1) inz(bFalse);
dcl-s IsPinOK char(1) inz(bFalse);
dcl-s IsPinRmv char(1) inz(bFalse);
dcl-s IsEOF char(1) inz(bFalse);
dcl-s queryUser like(Sfl_Cmd) inz(*allx'00');
dcl-s IsFound char(1) inz(bFalse);
dcl-s IsCmdErr char(1) inz(bFalse);
dcl-s isCancel char(1) inz(bFalse);
dcl-s R#IsCmdErr char(1) inz(bFalse);
dcl-s IsCvtChar char(1) inz(bFalse);
dcl-s isPinToClr char(1) inz(bTrue);
dcl-s IsReadC char(1) inz(bFalse);
dcl-s isColumnException like(bool_t) inz(bFalse);
dcl-s isKeyLower like(bool_t) inz(bFalse);

dcl-s commitLvl char(1) inz('0');

dcl-ds auth qualified;
  isChgLibAlw        like(bool_t) inz(bFalse);
  isChgFileAlw       like(bool_t) inz(bFalse);
  isChgMbrAlw        like(bool_t) inz(bFalse);
  isUpdAlw           like(bool_t) inz(bFalse);
  isUpdKeyAlw        like(bool_t) inz(bFalse);
  isChgSQLWhereAlw   like(bool_t) inz(bFalse);
  isChgSQLOrderByAlw like(bool_t) inz(bFalse);
  isAccessAlw        like(bool_t) inz(bFalse);
end-ds;

dcl-s SflPage like(int4_t) inz;
dcl-s SflRec080 inz(0) like(SflPage);
dcl-s SflRec132 inz(0) like(SflPage);
dcl-s SflNbrRcd inz(0) like(SflPage);
dcl-s sflMaxRowLen like(int4_t) inz;
dcl-s SflDataLenFree like(int4_t) inz;
dcl-s SFTop like(int4_t) inz;
dcl-s sfbot like(int4_t) inz;
dcl-s Sfl_Cmd char(10) inz;
dcl-s SflHeadLRw inz(0) like(SflPage);
dcl-s SflFirstRw inz(0) like(SflPage);
dcl-s SflLastRw inz(0) like(SflPage);
dcl-s SflLeftOfs like(int4_t) inz;
dcl-s SflMode char(10) inz;
dcl-s SflPinRnge like(int4_t) inz;

dcl-c COPYRIGHT '1997-2026, Thomas Raddatz - PEEK v4.0.8';
dcl-c RELEASE 'Stand: 02.11.2026';
dcl-c VERSION 'V04R00M08';

dcl-s L#File like(##File) inz;
dcl-s L#Library like(##Library) inz;
dcl-s L#Member like(##Member) inz;
dcl-s L#Format like(##Format) inz;
dcl-s L#MaxSeq like(F_Seq) inz(0);
dcl-s L#MinSeq like(F_Seq) inz(0);
dcl-s L#WndNbr like(##WndNbr) inz(0);

dcl-s R#Size like(int4_t) inz;

dcl-s UPDPGM_NAME like(pgmCallN_t) inz;

dcl-s peek01_name like(pgmCallN_t) inz;
dcl-s peek03_name like(pgmCallN_t) inz;
dcl-s peek04_name like(pgmCallN_t) inz;
dcl-s peek06_name like(pgmCallN_t) inz;
dcl-s peek07_name like(pgmCallN_t) inz;
dcl-s peek08_name like(pgmCallN_t) inz;
dcl-s peek09_name like(pgmCallN_t) inz;
dcl-s peek10_name like(pgmCallN_t) inz;
dcl-s peek12_name like(pgmCallN_t) inz;
dcl-s peek13_name like(pgmCallN_t) inz;
dcl-s peek14_name like(pgmCallN_t) inz;
dcl-s peek17_name like(pgmCallN_t) inz;
dcl-s peek18_name like(pgmCallN_t) inz;
dcl-s peek19_name like(pgmCallN_t) inz;
dcl-s peek20_name like(pgmCallN_t) inz;
dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek24_name like(pgmCallN_t) inz;
dcl-s peek26_name like(pgmCallN_t) inz;
dcl-s peek27_name like(pgmCallN_t) inz;
dcl-s peek30_name like(pgmCallN_t) inz;
dcl-s peek32_name like(pgmCallN_t) inz;
dcl-s peek33_name like(pgmCallN_t) inz;
dcl-s peek34_name like(pgmCallN_t) inz;
dcl-s peek37_name like(pgmCallN_t) inz;
dcl-s peek38_name like(pgmCallN_t) inz;
dcl-s peek40_name like(pgmCallN_t) inz;
dcl-s peek41_name like(pgmCallN_t) inz;
dcl-s peek42_name like(pgmCallN_t) inz;
dcl-s peek47_name like(pgmCallN_t) inz;
dcl-s peek48_name like(pgmCallN_t) inz;
dcl-s peek49_name like(pgmCallN_t) inz;
dcl-s peek50_name like(pgmCallN_t) inz;
dcl-s peek52_name like(pgmCallN_t) inz;
dcl-s peek54_name like(pgmCallN_t) inz;
dcl-s peek55_name like(pgmCallN_t) inz;
dcl-s peek56_name like(pgmCallN_t) inz;
dcl-s peek57_name like(pgmCallN_t) inz;
dcl-s peek59_name like(pgmCallN_t) inz;
dcl-s peek65_name like(pgmCallN_t) inz;
dcl-s peek68_name like(pgmCallN_t) inz;
dcl-s peek69_name like(pgmCallN_t) inz;
dcl-s exit01_name like(pgmCallN_t) inz;
dcl-s exit04_name like(pgmCallN_t) inz;

dcl-s peekPgm like(pgm_t) inz;
dcl-s peekDspF like(file_t) inz;

dcl-ds sflDataRow qualified;
  chars char(1) dim(256) inz;
end-ds;

dcl-c sfl_row_size %elem(sflDataRow.chars);

dcl-s sflRowDataStr like(int4_t);
dcl-s sflRowDataEnd like(int4_t);
dcl-s sflRowDataLen like(int4_t);

dcl-s ColrOfs like(int4_t);
dcl-s Col_Field char(10) dim(60);
dcl-s Col_ScnStr like(int4_t) dim(60);
dcl-s Col_ScnEnd like(int4_t) dim(60);
dcl-s Col_Error like(bool_t) dim(60) inz(bFalse);
dcl-s cp like(int4_t);
dcl-s FldStrPos like(int4_t);

dcl-s HeadLen like(int4_t);
dcl-s FieldLen like(int4_t);
dcl-s MaxColLen like(int4_t);
dcl-s ColumnLen like(int4_t);

dcl-s PinCol_X like(int4_t);
dcl-c max_pin_col %elem(pinTabCol);
dcl-s pinTabCol like(fieldNme_t) dim(12);
//  Rückgabe des Pin-Dialogs (PEEK50): clrpincol löscht pinTabCol
dcl-s yPinTabCol like(fieldNme_t) dim(12);
dcl-s NbrPinCol like(int4_t);

dcl-s PinRcd_X like(int4_t);
dcl-c max_pin_rcd %elem(PinTabRcd);
dcl-s PinTabRcd like(pinTabR_t) dim(12);
dcl-s nbrPinRcd like(int4_t);

dcl-ds pinTabRcdE likeds(pinTabR_t);

//  Arbeitsfelder
dcl-s x like(int4_t);
dcl-s y like(int4_t);
dcl-s z like(int4_t);
dcl-s a1 char(1) inz;

//  Arbeitsfeld für Sortierfolge: Satzfolge/Schlüsselfolge
//  .. aktuelle Sortierung
dcl-s AccessMode char(1) inz(RRN_SEQ);
//  .. neue Sortierung für ChangeFile
dcl-s newAccessMode char(1) inz(RRN_SEQ);
//  .. Sortierung vor SQl-Mode
dcl-s oldAccMode char(1) inz(RRN_SEQ);
//  Arbeitsfeld für Befehlsverarbeitung, Verhinderung von Rekursionen
dcl-s R#PgmCmd like(YPgmCmd) inz;
//  Arbeitsfeld für Eingabe Aufsetzkey
dcl-s R#RcdNbr like(##RcdNbr) inz(0);
dcl-s R#KeyVal like(##Key) inz;
//  Arbeitsfeld für PIN-Funktion
dcl-s Pin#Field char(10) inz;
//  Datensatz-Nr für SETLL und SETGG zum füllen der Subfile
dcl-s Wrk#ReadDn like(SflPage) inz(0);
dcl-s Wrk#RcdNbr like(rcdNbr_t) inz(0);
dcl-ds *n;
  Wrk#KeyVal like(keyBuf_t) inz;
end-ds;
//  ...
dcl-s Wrk#Field inz like(F_Field);
dcl-s Wrk#SeqNbr inz(0) like(F_Seq);
dcl-s Wrk#Recno inz(0) like(SflRec132);
dcl-s Wrk#SFPAU inz like(sfpau);
//  Umschalten der Sortierung
dcl-s Last#RcdNr like(rcdNbr_t) inz(0);
//  Farbattribute einsetzen
dcl-s Wrk#Ofs like(int4_t) inz;
//  Felder für Suchfunktion
dcl-s SrchMode char(10) inz('*NEW');
dcl-s SrchFndRcd like(rcdNbr_t) inz(0);
dcl-s SrchField char(10) inz;
dcl-s SrchOP char(10) inz;
dcl-s SrchArg char(63) inz;
dcl-s SrchSign char(1) inz;
dcl-s SrchArgFloat float(8) inz;
dcl-s SrchArgVal zoned(63) inz;
dcl-c cSRCHARG_DIGITS %len(SrchArgVal);

dcl-c cSRCHARG_DECPOS %decpos(SrchArgVal);

dcl-s SrchLikeTp like(int4_t) inz;
dcl-s SrchLikeLn like(int4_t) inz;
dcl-s SrchNbrs packed(10) inz(0);
dcl-s SrchType char(10) inz;
dcl-s SrchCase char(1) inz(bFalse);
dcl-s SrchCmpStr like(SrchArg) inz;
dcl-s SrchCmpVal like(SrchArgVal) inz(0);
dcl-c srch_cmp_val_length %len(SrchCmpVal);

dcl-c srch_cmp_val_decpos %decpos(SrchCmpVal);

dcl-s SrchCmpFloat float(8) inz(0);
dcl-s SrchCmpRcd like(rcdBuf_t) inz;
dcl-s SrchCount like(SrchNbrs) inz(0);
dcl-s SrchCount2 like(SrchNbrs) inz(0);
dcl-s SrchDspMsg like(SrchNbrs) inz(0);
dcl-s SrchIsNum char(1) inz(bFalse);
dcl-s SrchArgIsFloat char(1) inz(bFalse);

//  Felder für Kopierfunktion
dcl-ds copyExternal qualified;
  file    char(10) inz;
  lib     char(10) inz;
  toMbr   char(10) inz;
  mbrOpt  char(10) inz;
  crtFile char(10) inz;
end-ds;

//  Überlagern von ##Key132uc mit ##Key80uc
dcl-s ##Key like(##Key132uc) inz;
dcl-ds *n;
  ##Key132uc char(116);
  ##Key80uc  char(67) overlay(##Key132uc: 1);
end-ds;
dcl-ds *n;
  ##Key132lc char(116);
  ##Key80lc  char(67) overlay(##Key132lc: 1);
  sqlWhere   like(sqlWhere_t) inz;
  sqlOrder   like(sqlOrder_t) inz;
end-ds;
dcl-ds *n;
  rcdNbr# zoned(10);
  rcdNbr$ char(10) overlay(rcdNbr#: 1);
end-ds;

dcl-s exitMsg varchar(512) inz;
dcl-s colHeading like(colHeading_t);

//  Feldinhalte vor der Bildschirmausgabe
dcl-ds b4 qualified;
  WndNbr  like(##WndNbr);
  StrPage like(##StrPage);
end-ds;

/copy QCOPYLE,CEECNDHDLR

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek05;
  io_qFile    likeds(qObj_t);
  i_member    like(mbr_t) const;
  i_access    like(accessMode_t) const;
  i_prodLib   like(lib_t) const;
  i_chgLib    like(bool_t) const;
  i_chgFile   like(bool_t) const;
  i_chgMbr    like(bool_t) const;
  i_updModKey like(bool_t) const;
  i_chgSqlW   like(bool_t) const;
  i_chgSqlO   like(bool_t) const;
  i_qEnvFile  likeds(qObj_t) const;
  i_envMbr    like(mbr_t) const;
  i_envSave   like(bool_t) const;
  i_envLayout like(bool_t) const;
  i_sqlWhere  like(sqlWhere_t) const;
  i_sqlOrder  like(sqlOrder_t) const;
end-pi;
//Prototype for 'QUSCMDLN'
dcl-pr quscmdln extpgm('QUSCMDLN');
end-pr;

dcl-s do_x10 packed(7);
dcl-s do_x14 packed(7);
dcl-s do_x2 packed(7);
dcl-s do_x3 packed(7);
dcl-s do_x4 packed(7);
dcl-s do_x5 packed(7);
dcl-s do_x6 packed(7);

dcl-ds f1key_l1 likerec(fpeekfldl1: *key);
dcl-ds f_key likerec(fpeekfld: *key);

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler'): *null: *omit);

exsr inzsr;

exsr First;

dow ('1');

  //  Ermitteln der Feldnummer des ersten
  //  sichtbaren Feldes
  exsr GetFrstFld;

  //  Öffnen/Schützen "Feldseite"
  if (set0010.set_fldpge = '1');
    *in72 = '0';
  else;
    *in72 = '1';
  endif;

  //  Öffnen/Schützen "Aufsetzschlüssel/Satznummer"
  if (AccessMode = SQL_SEQ);
    *in73 = '1';
  else;
    *in73 = '0';
  endif;

  //  Öffnen/Schützen Dateiauswahlfelder ...
  //  ... ##Library
  if (auth.isChgLibAlw = bTrue);
    *in74 = *off;
  else;
    *in74 = *on;
  endif;
  //  ... ##File
  if (auth.isChgFileAlw = bTrue);
    *in75 = *off;
  else;
    *in75 = *on;
  endif;
  //  ... ##Member
  if (auth.isChgMbrAlw = bTrue);
    *in77 = *off;
  else;
    *in77 = *on;
  endif;

  //  Eingabe der Schlüsselfelder in Gross- oder Kleinbuchstaben
  if (isKeyLower = bFalse);
    *in78 = *off;
    ##Key132uc = ##Key;
  else;
    *in78 = *on;
    ##Key132lc = ##Key;
  endif;

  //  Prüfen Positionierung der Subfile
  if (sfsanr <= 0);
    sfsanr = nbrPinRcd + 1;
  endif;
  if (sfsanr > SflNbrRcd);
    sfsanr = SflNbrRcd;
  endif;

  //  Für Prüfung: Eingabe neuer Aufsetzkey
  R#RcdNbr = ##RcdNbr;
  R#KeyVal = ##Key;

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgctl;

  //  "Keine Sätze ..."
  if (*in80 = *off);
    write pbleer;
  endif;

  //  Anzeigen der Einzelauswahlen
  if (SFTop > 32
      or SFTop > YNbrOfCh);
    SFTop = 1;
  endif;
  $$choice = YChoice(SFTop);

  //  Anzeigen der Befehlstasten
  select;
  when (sfbot = 2 and yNbrOfKeys > 8);
    if (*in88 = bFalse);
      write pbbot132#2;
    else;
      write pbbot080#2;
    endif;
  when (sfbot = 3 and yNbrOfKeys > 16);
    if (*in88 = bFalse);
      write pbbot132#3;
    else;
      write pbbot080#3;
    endif;
  when (sfbot = 4 and yNbrOfKeys > 24);
    if (*in88 = bFalse);
      write pbbot132#4;
    else;
      write pbbot080#4;
    endif;
  other;
    if (*in88 = bFalse);
      write pbbot132#1;
    else;
      write pbbot080#1;
    endif;
    sfbot = 1;
  endsl;

  //  Merken Startseite innerhalb des Feldes
  b4.WndNbr = ##WndNbr;
  b4.StrPage = ##StrPage;

  //  Anzeige der Subfile
  if (*in88 = bFalse);
    exfmt pbctl132;
  else;
    exfmt pbctl080;
  endif;

  //  Übernehmen Schlüsselfelder
  if (isKeyLower = bFalse);
    ##Key = ##Key132uc;
  else;
    ##Key = ##Key132lc;
  endif;

  //  Berechnen Zeile/Spalte
  cursorPosition.row = workstn.csrPos / 256;
  cursorPosition.column = %rem(workstn.csrPos: 256);

  //  Löschen der Cursorposition
  CsrRow = 0;
  CsrCol = 0;

  //  Merker für aktualisieren der Subfile
  isSflDirty = bFalse;

  //  Merker für abfragen der Zieldatei
  isTargetOK = bFalse;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Cursor-Pos. löschen
  *in87 = '0';

  //  Aktuelle Satz-Nr.
  sfsanr = SflCsr;

  //  Suchmodus
  if (YPgmCmd <> '*SEARCH');
    SrchMode = '*NEW';
    SrchFndRcd = 0;
  endif;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
  if (YMsgID <> *blanks);
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
  else;
    //  Abfragen der Programmbefehle
    exsr doScreenCmd;
    if (YPgmCmd = '*EXIT' or YPgmCmd = '*CANCEL');
      leave;
    endif;
    if (IsCmdErr = bTrue);
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
    endif;
  endif;

  //  ... Subfile aktualisieren
  if (isSflDirty = bTrue);
    exsr PBRefresh;
  endif;

  //  ... Offene Datei aktualisieren
  exsr GetOpnFile;

enddo;

*inlr = '1';

//============================================================*
//    DoScrnCmd     Ausführen Bildschirmbefehl                *
//============================================================*

begsr doScreenCmd;

  //  Sicherstellen, dass die Startseite innerhalb eines Feldes
  //  immer gefüllt ist:

  //  Verwenden der alten Werte bei F5
  if (YPgmCmd = '*REFRESH');
    ##WndNbr = b4.WndNbr;
    ##StrPage = b4.StrPage;
  else;

    //  Positionieren auf Feldanfang bei Wechsel des Startfeldes
    if (##WndNbr <> b4.WndNbr
        and ##StrPage = b4.StrPage);
      ##StrPage = 1;
    endif;

  endif;

  //  Verwenden der alten Startposition von vor der Bildschirmausgabe
  if (##StrPage = *zeros);
    ##StrPage = b4.StrPage;
  endif;

  //  Sicherstellen, dass das Feld gefüllt ist
  if (##StrPage = *zeros);
    ##StrPage = 1;
  endif;

  //  Verarbeiten Bildschirmereignis
  R#PgmCmd = YPgmCmd;
  //   exsr doPgmCmd;
/copy QCOPYLE,DOPGMCMD
  R#PgmCmd = '';

endsr;

//============================================================*
//    DoSflCmd      Ausführen Subfilebefehl                   *
//============================================================*

begsr doSflCmd;

  if (YPgmCmd = R#PgmCmd);
    IsCmdErr = bTrue;
    clear usr8144;
    usr8144.var1 = YPgmCmd;
    p_sndPgmMg('USR8144': usr8144: sds.pgmName);
  else;
  //      exsr doPgmCmd;
/copy QCOPYLE,DOPGMCMD
  endif;

endsr;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  //  Löschen der Cursor-Position ...
  exsr DltCsrPos;

  //  Datei hat gewechselt ...
  if (((##File    <> L#File) and
      (not f_endsWith('*': %trim(##File))) and
      (%trim(##File  ) <> set0008.set_prmt)) or
      (##Library  <> L#Library      ) or
      ((##Member  <> L#Member) and
      (%trim(##Member) <> set0008.set_prmt)) or
      ((##Format  <> L#Format) and
      (%trim(##Format) <> set0008.set_prmt)));
    *in93 = '1';
  else;

    //  Abfragen Prompt?
    //  ... ##File
    if (%trim(##File) = set0008.set_prmt or
        f_endsWith('*': %trim(##File)));
      exsr C_Prompt;
      if (*in93 = '0');
        leavesr;
      endif;
    endif;
    //  ... ##Member
    if (%trim(##Member) = set0008.set_prmt);
      exsr C_Prompt;
      if (*in93 = '0');
        leavesr;
      endif;
    endif;
    //  ... ##Format
    if (%trim(##Format) = set0008.set_prmt);
      exsr C_Prompt;
      if (*in93 = '0');
        leavesr;
      endif;
    endif;
    //  ... ##Field
    if (%trim(##Field ) = set0008.set_prmt);
      exsr C_Prompt;
      if (*in93 = '0');
        leavesr;
      endif;
    endif;
  endif;

  if (*in93 = *off);

    //  Keine Eigaben ...
    //  ... also abfragen der Subfileauswahlen
    if (isReadSfl = bTrue);
    //       verhindern einer Rekursion
    else;
      exsr c_readSfl;
    endif;

  else;

    //  Wechsel der Datei ...
    newAccessMode = i_access;

    exsr changeFile;

    //  Prüfen Seq-Bereich (##WndNbr) ...
    exsr ChkSeqRnge;

    //  Wechsel des Fenster (##Field) ...
    exsr ChangeWnd;

    //  Wechsel des Aufsetzkeys ...
    exsr ChangeKey;

    //  Füllen der Subfile ...
    if (IsFileChg = bTrue);
      exsr DltCsrPos;
      exsr C_Top;
    else;
      if (IsKeyChg = bFalse);
        exsr PBRefresh;
      else;
        exsr DltCsrPos;
        exsr KeyHasChg;
      endif;
    endif;

  endif;

endsr;

//============================================================*
//    C_ReadSfl     Lesen & Verarbeiten der Subfile-Auswahlen *
//============================================================*

begsr c_readSfl;

  //  Merker für: Subfile gelöscht zurück setzen
  //              abbrechen READC, wenn Subfileinhalt
  //              gelöscht worden ist über PBINIT
  IsPBINIT = bFalse;
  //  Merker für: Programmablauf innerhalb der READC-Schleife
  //              verhindern einer Rekursion über
  //              C_ENTER, C_PAGEUP, C_PAGEDOWN
  isReadSfl = bTrue;

  R#IsCmdErr = IsCmdErr;

  //  Mindestens 1 Eintrag verarbeitet ...
  IsReadC = bFalse;

  if (*in80 = *off);
  //           Keine Einträge vorhanden
  else;

    dou (queryUser = *allx'00');

      queryUser = *allx'00';

      //  Lesen, solange bis keine zu verarbeitenden
      //  Sätze mehr da sind, oder bis durch einen
      //  Kurzbefehl (SFPAU) die Subfile neu auf-
      //  gebaut worden ist.
      dow (IsPBINIT = bFalse);

        if (*in88 = bFalse);
          readc pbsfl132;
        else;
          readc pbsfl080;
        endif;

        if (%eof());
          leave;
        endif;

        //  Cursorpositionierung ...
        if (*in88 = bFalse);
          SflCsr = SflRec132;
        else;
          SflCsr = SflRec080;
        endif;

        //  Linksbündig setzen ...
        sfpau = %triml(sfpau);

        //  Prompt ...
        if (%trim(sfpau) = set0008.set_prmt);
          exsr Pmt_Sfpau;
        endif;

        //  Zuordnung AUSWAHL => Befehl ...
        peek21('#' + sfpau: sds.pgmName
              : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
        if (YMsgID <> *blanks);
          //  Fehlermeldung ...
          p_sndPgmMg('USR8110': sfpau: sds.pgmName);

          exsr pbSflChain;
          if (%found());
            *in84 = '1';
            *in85 = '1';
            exsr pbSflUpdate;
          endif;
          iter;
        endif;

        //----------------------------*
        //  Ausführen SFL-Befehl ...  *
        //----------------------------*

        Sfl_Cmd = YPgmCmd;

        //  Vorrangig Blockverarbeitung (F22)
        //  verarbeiten ...
        if (queryUser <> *allx'00' and Sfl_Cmd <> queryUser);
          exsr pbSflChain;
          if (%found());
            *in84 = '1';
            exsr pbSflUpdate;
          endif;
          iter;
        endif;

        //  Verarbeiten der Befehle ...
        exsr doSflCmd;
        if (IsCmdErr = bTrue);
          exsr pbSflChain;
          if (%found());
            *in84 = '1';
            *in85 = '1';
            exsr pbSflUpdate;
          endif;
          if (isCancel = bTrue);
            leave;
          else;
            iter;
          endif;
        endif;

        //  Mindestens ein Eintrag verarbeitet ...
        //  (ignorieren leere Auswahlen)
        if (YPgmCmd <> '*NONE');
          IsReadC = bTrue;
        endif;

        //  Verarbeitung auswerten ...
        exsr pbSflChain;
        if (%found());
          //  ... Abbruch mit F3/F12
          if (YMsgID = 'USR8100'); // Verarbeitung abgebrochen
            *in84 = '1';
          else;
            //  ... Verarbeitung durchgeführt
            *in84 = '0';
            *in85 = '0';
            sfpau = '';
          endif;
          exsr pbSflUpdate;
          if (YMsgID = 'USR8100'); // Verarbeitung abgebrochen
            leave;
          endif;
        endif;

      enddo;

    enddo;

  endif;

  IsCmdErr = R#IsCmdErr;
  isReadSfl = bFalse;

  if (IsReadC = bTrue);
    exsr GetObjAttr;
    exsr GetMbrAttr;
  endif;

endsr;

//============================================================*
//    PBSflChain    CHAIN auf PBSFL                           *
//============================================================*

begsr pbSflChain;

  if (*in88 = *off);
    chain SflRec132 pbsfl132;
  endif;
  if (*in88 = *on);
    chain SflRec080 pbsfl080;
  endif;

  if (%found());
  //  ... alles in Ordnung
  else;
    //  ... letzte Nachricht löschen
    p_rmvPgmMg(sds.pgmName);
  endif;

endsr;

//============================================================*
//    PBSflWrite    WRITE auf PBSFL                           *
//============================================================*

begsr PBSflWrite;

  if (*in88 = bFalse);
    write pbsfl132;
  else;
    write pbsfl080;
  endif;

endsr;

//============================================================*
//    PBSflUpdat    UPDATE auf PBSFL                          *
//============================================================*

begsr pbSflUpdate;

  if (*in88 = bFalse);
    update pbsfl132;
  else;
    update pbsfl080;
  endif;

endsr;

//============================================================*
//    C_PageUp      PgUp - Vorwärts blättern                  *
//============================================================*

begsr c_pageUp;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    //  Verarbeiten der Subfile-Auswahlen
    if (isReadSfl = bTrue);
    //       verhindern einer Rekursion
    else;
      exsr c_readSfl;
    endif;

    //  Blättern
    exsr PBInit;
    exsr pbPinRcd;
    exsr PBReadUp;

    //  Keine weiteren Einträge gefunden ...
    if (*in80 = *off);
      //  ... Ende der Liste anzeigen
      exsr C_Bot;
    endif;

  endif;

endsr;

//============================================================*
//    C_PageDown    PgDn - Rückwärts blättern                 *
//============================================================*

begsr c_pageDown;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    //  Verarbeiten der Subfile-Auswahlen
    if (isReadSfl = bTrue);
    //       verhindern einer Rekursion
    else;
      exsr c_readSfl;
    endif;

    //  Blättern
    SflCsr = nbrPinRcd + 1;
    exsr PBReadCsr;
    exsr pbReadDown;

    exsr PBInit;
    exsr pbPinRcd;
    exsr PBReadUp;

  endif;

endsr;

//============================================================*
//    C_EndPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr C_EndPgm;

  // - Speichern der Arbeitsumgebung
  if (i_envSave = bTrue);
    YIsAutoSave = bTrue;
    exsr SaveEnv;
  endif;

  exsr CloseFile;
  if (IsOpen = bFalse);

    // - Benutzervoreinstellungen
    exsr SetUsrSetg;

    // - Endenachricht
    p_rmvPgmMg(sds.pgmName);

    clear usr8100; // Verarbeitung abgebrochen
    usr8100.var1 = YPgmCmd;
    exitMsg = f_msgText('USR8100': usr8100);

    clear usr9999;
    usr9999.var1 = exitMsg;
    usr9999.var2 = '';
    p_sndPgmMg('USR9999': usr9999: sds.pgmName);
    p_movPgmMg(sds.pgmName);

  else;
    //  Fehlermeldung ...
    p_sndPgmMg('USR8103': '': sds.pgmName);
  endif;

endsr;

//============================================================*
//    C_Prompt      F4  - Prompt                              *
//============================================================*

begsr C_Prompt;

  if (IsOpen = bFalse);

    select;
    when ((ScnFld   = '##FILE'  ) or
       (##File   = set0008.set_prmt  ) or
       (f_endsWith('*': %trim(##File))));
      exsr Pmt_File;
    when ((ScnFld   = '##MEMBER') or
       (##Member = set0008.set_prmt  ));
      exsr Pmt_Mbr;
    other;
      //      Nix tun, keine Datei vorhanden
      exsr MsgNoFile;
    endsl;

  else;

    select;
    when ((ScnFld   = '##FIELD ') or
       (##Field  = set0008.set_prmt  ));
      exsr Pmt_Field;
    when ((ScnFld   = '##FILE'  ) or
       (##File   = set0008.set_prmt  ) or
       (f_endsWith('*': %trim(##File))));
      exsr Pmt_File;
    when ((ScnFld   = '##MEMBER') or
       (##Member = set0008.set_prmt  ));
      exsr Pmt_Mbr;
    when ((ScnFld   = '##FORMAT') or
       (##Format = set0008.set_prmt  ));
      exsr Pmt_Fmt;
    when ((ScnFld   = 'SFPAU'   ) or
       (sfpau    = set0008.set_prmt  ));
      exsr Pmt_Sfpau;
    other;
      p_sndPgmMg('USR8179': '': sds.pgmName);
    endsl;

  endif;

  exsr KeepCsrPos;

endsr;

//============================================================*
//    Pmt_Field     Prompt - Field                            *
//============================================================*

begsr Pmt_Field;

  peek37(set0001.SET_Dsp80: COPYRIGHT: YField
        : YMsgID: YMsgDta);

  if (YMsgID = *blanks);
    ##Field = YField;
    *in93 = '1';
  else;
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    *in93 = '0';
  endif;

endsr;

//============================================================*
//    Pmt_File      Prompt - File                             *
//============================================================*

begsr Pmt_File;

  //  Wenn das Feld gesperrt ist, ...
  if (*in75 = *on);
    //  ... dann
    //      ausgeben Meldung
    p_sndPgmMg('USR8179': '': sds.pgmName);
  else;
    //  ... sonst
    //      aufrufen "Auswahl Datei"
    if (##File = *blanks
        or ##File = set0008.set_prmt);
      YFile = '*ALL';
    else;
      YFile = ##File;
    endif;

    if (##Library = *blanks);
      yLibrary = '*LIBL';
    else;
      yLibrary = ##Library;
    endif;

    peek69(set0001.SET_Dsp80: COPYRIGHT: YQFile
          : YMsgID: YMsgDta);

    if (YMsgID = *blanks);
      ##File = YFile;
      ##Library = yLibrary;
      *in93 = '1';
    else;
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
      *in93 = '0';
    endif;

  endif;

endsr;

//============================================================*
//    Pmt_Mbr       Prompt - Member                           *
//============================================================*

begsr Pmt_Mbr;

  //  Wenn das Feld gesperrt ist, ...
  if (*in77 = *on);
    //  ... dann
    //      ausgeben Meldung
    p_sndPgmMg('USR8179': '': sds.pgmName);
  else;
    //  ... sonst
    //      aufrufen "Auswahl Teildatei"
    YFile = ##File;

    if (##Library = *blanks);
      yLibrary = '*LIBL';
    else;
      yLibrary = ##Library;
    endif;

    peek47(set0001.SET_Dsp80: COPYRIGHT
          : YQFile: yMember: YMsgID: YMsgDta);

    if (YMsgID = *blanks);
      ##Member = yMember;
      *in93 = '1';
    else;
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
      *in93 = '0';
    endif;

  endif;

endsr;

//============================================================*
//    Pmt_Fmt       Prompt - Format                           *
//============================================================*

begsr Pmt_Fmt;

  peek12(set0001.SET_Dsp80: COPYRIGHT: ##Format
        : MODE_INTER
        : rcdl0200: YFmtNbr: YMsgID: YMsgDta);

  if (YMsgID = *blanks);
    ##fmtnbr = YFmtNbr;
    ##Format = rcdl0200.R2FmtName;
    $$Length = rcdl0200.R2RcdLen;
    *in93 = '1';
  else;
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    *in93 = '0';
  endif;

endsr;

//============================================================*
//    Pmt_Sfpau     Prompt - Subfileauswahl                   *
//============================================================*

begsr Pmt_Sfpau;

  peek68(set0001.SET_Dsp80: sds.pgmName: COPYRIGHT
        : ySflOpt: YMsgID: YMsgDta);

  //  Einlesen Subfiledatensatz
  SflRec132 = SflCsr;
  SflRec080 = SflCsr;
  exsr pbSflChain;

  //  Abbruch mit F3/F12
  if (YMsgID = 'USR8100'); // Verarbeitung abgebrochen
    sfpau = '';
    *in84 = '1'; // SFLNXTCHG
    *in85 = '0'; // SFPAU(RI)
  else;
    sfpau = ySflOpt;
    *in84 = '1'; // SFLNXTCHG
    *in85 = '0'; // SFPAU(RI)
  endif;

  //  Aktualisieren Subfiledatensatz
  exsr pbSflUpdate;

  if (YMsgID = 'USR8100'); // Verarbeitung abgebrochen
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
  else;
    if (*in88 = bFalse);
      write pbctl132;
    else;
      write pbctl080;
    endif;
  endif;

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr C_Refresh;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    //      ... aktualisieren "offene Datei"
    exsr GetOpnFile;

    //      ... aktualisieren Subfile
    exsr PBRefresh;

    //      ... abrufen der Objektattribute
    exsr GetObjAttr;

    //      ... abrufen der Anzahl Teildateien
    exsr GetNbrMbr;

    //      ... abrufen Objektattribute
    exsr GetObjAttr;

    //      ... abrufen der Teildateiattribute
    exsr GetMbrAttr;
  endif;

  //      ... positionieren Cursor
  if (SflCsr = 0);
    exsr C_PosCsr;
  endif;

endsr;

//============================================================*
//    C_Add         F6  - Neuanlage eines Datensatz           *
//============================================================*

begsr C_Add;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    if (isUpdMod = bFalse);
      //      Neuanlage nicht möglich, da INPUT-Modus
      clear usr0007;
      usr0007.var1 = ##File;
      usr0007.var2 = ##Library;
      p_sndPgmMg('USR0007': usr0007: sds.pgmName);
    else;

      yFunction = '*ADD';
      exsr callUpdPgm;

      //  Ermitteln Objektattribute
      exsr GetObjAttr;

      //  Ermitteln der Teildateiattribute (Anzahl Sätze)
      exsr GetMbrAttr;

    endif;
  endif;

endsr;

//============================================================*
//    C_ChgHead     F7  - Umschalten der Überschrift          *
//============================================================*

begsr C_ChgHead;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    set0001.SET_HedTyp = f_nextHeaderType(set0001.SET_HedTyp);

    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    C_TgMrkCol    F8  - Spalte markieren ein/aus            *
//============================================================*

begsr C_TgMrkCol;

  if (IsOpen = bFalse);
    // Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr GetFldTMrk;

    if (Wrk#Field <> '');
      isSflDirty = bTrue;

      // Umschalten der Farbe im Datensatz ...
      clear f_key;
      f_key.F_Field = Col_Field(x);
      chain(n) %kds(f_key) fpeekfld;
      if (%found(peekfld));
        if (F_MarkCol = bFalse);
          exsr C_MrkCol;
        else;
          exsr C_UnMrkCol;
        endif;
      else;
      // Datensatz nicht gefunden
      endif;
    endif;

    // Beibehalten der Cursorposition ...
    exsr KeepCsrPos;
  endif;

endsr;

//============================================================*
//    C_MrkCol      F8  - Spalte markieren ein                *
//============================================================*

begsr C_MrkCol;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr GetFldTMrk;

    if (Wrk#Field <> '');
      isSflDirty = bTrue;

      //  Einschalten der Farbe im Datensatz ...
      clear f_key;
      f_key.F_Field = Col_Field(x);
      chain %kds(f_key) fpeekfld;
      if (%found(peekfld));
        F_MarkCol = bTrue;
        update fpeekfld;
      else;
      //        Datensatz nicht gefunden
      endif;
    endif;

    //  Beibehalten der Cursorposition ...
    exsr KeepCsrPos;
  endif;

endsr;

//============================================================*
//    C_UnMrkCol    F8  - Spalte markieren aus                *
//============================================================*

begsr C_UnMrkCol;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr GetFldTMrk;

    if (Wrk#Field <> '');
      isSflDirty = bTrue;

      //  Ausschalten der Farbe im Datensatz ...
      clear f_key;
      f_key.F_Field = Col_Field(x);
      chain %kds(f_key) fpeekfld;
      if (%found(peekfld));
        F_MarkCol = bFalse;
        update fpeekfld;
      else;
      //        Datensatz nicht gefunden
      endif;
    endif;

    //  Beibehalten der Cursorposition ...
    exsr KeepCsrPos;
  endif;

endsr;

//============================================================*
//    C_MoveTop     F9  - Selektieren Datensatz               *
//============================================================*

begsr C_MoveTop;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr getSflRcd;

    if (SflCsr > 0);

      exsr PBReadCsr;
      exsr PBInit;
      exsr pbPinRcd;
      exsr PBReadUp;
      sfsanr = nbrPinRcd + 1;

    else;
      //  Fehlermeldung ...
      p_sndPgmMg('USR8102': '': sds.pgmName);
    endif;

  endif;

endsr;

//============================================================*
//    C_PosCsr      F10    - Cursor auf Keyeingabe pos.       *
//============================================================*

begsr C_PosCsr;

  *in87 = '1';

endsr;

//============================================================*
//    C_UserSetg    F11    - Benutzervoreinstellugnen         *
//============================================================*

begsr C_UserSetg;

  monitor;
    peek24(set0001.SET_Dsp80: COPYRIGHT: set0001
          : YMsgID: YMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = *on);
  //            Fehler aufgetreten
  else;
    if (YMsgID = 'USR8112'); // Verarbeitung bestätigt.
      p_updUsrSg('*DSPATTR' : set0001);
      exsr C_Refresh;
    else;
    //            Verrabeitung durch Benutzer
    //            abgebrochen
    endif;
  endif;

endsr;

//============================================================*
//    C_Repeat      F13 - Wiederholen der Subfileauswahl      *
//============================================================*

begsr C_Repeat;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    //  "Keine Sätze ..."
    if (SflNbrRcd = 0);
    //  Keine Datensätze vorhanden.
    else;

      //  Ermitteln der letzten Subfile-Auswahl ...
      exsr GetLastOpt;
      if (IsError = bTrue);
        //  Fehlermeldung ...
        p_sndPgmMg('USR8165': '': sds.pgmName);
      else;

        //  "Reaktivieren" der letzten Subfileauswahl ...
        SflRec132 = Wrk#Recno;
        SflRec080 = Wrk#Recno;
        exsr pbSflChain;
        *in84 = '1'; // SFLNXTCHG
        exsr pbSflUpdate;
        //  Verarbeitung ...
        Wrk#Recno = Wrk#Recno + 1;
        exsr RepeatOpt;
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    C_Layout      F15    - Layout                           *
//============================================================*

begsr C_Layout;

  monitor;
    peek34(set0001.SET_Dsp80: COPYRIGHT: '*DISPLAY'
          : YMsgID: YMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (YMsgID = 'USR8112'); // Verarbeitung bestätigt.
    //  Beenden und Speichern ...
    //  Merker für aktualisieren der Subfile
    isSflDirty = bTrue;
  else;
  //  Abbruch durch Benutzer ...
  endif;

endsr;

//============================================================*
//    C_Search      F16    - Suchfunktion                     *
//============================================================*

begsr C_Search;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    select;
    when (SrchMode = '*NEW');
      monitor;
        peek17(set0001.SET_Dsp80: COPYRIGHT
              : YQFile: ##Member
              : YField: YOperation: YArgument
              : YSign: YSrchNbrs: YSrchType
              : YSrchCase: YMsgID: YMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

      if (*in99 = *off);
        if (YMsgID = 'USR8112'); // Verarbeitung bestätigt.
          exsr SrchStart;
        else;
          p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
          YMsgID = '';
          YMsgDta = '';
        endif;
      else;
      //  Fehler beim Aufruf von PEEK17 ...
      endif;

    when (SrchMode = '*FOUND');
      exsr SrchCont;

    when (SrchMode = '*MAXIMUM');
      exsr SrchContM;

    when (SrchMode = '*EOF');
      exsr SrchEOF;

    other;
    //               ???????????
    endsl;

    //  Gefunden?
    if (SrchMode = '*FOUND');
      SrchFndRcd = File#X.RcdNbr;
      exsr PBReadP;
    else;
      exsr pbReadDown;
    endif;

    //  Anzeigen der Subfile
    exsr PBInit;
    exsr pbPinRcd;
    exsr PBReadUp;

    //  Meldung
    select;
    when (SrchMode = '*FOUND');
      p_sndPgmMg('USR8130': '': sds.pgmName);
    when (SrchMode = '*EOF');
      p_sndPgmMg('USR8131': '': sds.pgmName);
    when (SrchMode = '*MAXIMUM');
      p_sndPgmMg('USR8132': '': sds.pgmName);
    other;
    endsl;

  endif;

endsr;

//============================================================*
//    C_Top         F17 - Anfang der Datei                    *
//============================================================*

begsr C_Top;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr PBMoveTop;
    exsr PBInit;
    exsr pbPinRcd;
    exsr PBReadUp;

    sfsanr = nbrPinRcd + 1;
  endif;

endsr;

//============================================================*
//    C_Bot         F18 - Ende der Datei                      *
//============================================================*

begsr C_Bot;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr PBMoveBot;
    exsr PBInit;
    exsr pbPinRcd;
    exsr pbReadDown;
    exsr PBReadUp;

    sfsanr = SflNbrRcd;
  endif;

endsr;

//============================================================*
//    C_MoveL       F19 - Nach links verschieben              *
//============================================================*

begsr C_MoveL;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    if (##StrPage > 1);
      if (set0010.set_scroll = '*BOTH'
          or set0010.set_scroll = '*LEFT');
        ##StrPage = ##StrPage - 1;
      else;
        ##StrPage = 1;
        ##WndNbr = ##WndNbr - 1;
      endif;
    else;
      ##WndNbr = ##WndNbr - 1;
      if (set0010.set_scroll = '*BOTH'
          or set0010.set_scroll = '*LEFT');
        ##StrPage = *hival;
      else;
        ##StrPage = 1;
      endif;
    endif;

    exsr ChkSeqRnge;

    exsr PBRefresh;
  endif;

endsr;

//============================================================*
//    C_MoveR       F20 - Nach rechts verschieben             *
//============================================================*

begsr C_MoveR;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    if ((cp = 1) and
        (Col_Error(cp) = bTrue));
      if ((set0010.set_scroll = '*BOTH') or
         (set0010.set_scroll = '*RIGHT'));
        ##StrPage = ##StrPage + 1;
      else;
        ##WndNbr = ##WndNbr + 1;
        ##StrPage = 1;
      endif;
    else;
      ##WndNbr = ##WndNbr + 1;
      ##StrPage = 1;
    endif;

    exsr ChkSeqRnge;
    exsr PBRefresh;
  endif;

endsr;

//============================================================*
//    C_PageL       F19 - Nach links verschieben,             *
//                  ganze Seite                               *
//============================================================*

begsr c_pageLeft;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
    leavesr;
  endif;

  //  Prüfen "Seite innerhalb des Feldes"
  if (##StrPage > 1);
    ##StrPage = ##StrPage - 1;
  else;

    //  Bereits am Anfang
    if (##WndNbr = L#MinSeq
        and ##StrPage = 1);
    else;

      //  Ermitteln der Feldnummer des 1. angezeigten
      //  Feldes ...
      x = NbrPinCol + 1;
      Wrk#Field = Col_Field(x);
      exsr GetSeqNbr;
      if (isSeqNbrOK = bFalse and L#MinSeq > 0);
        Wrk#SeqNbr = L#MinSeq;
        isSeqNbrOK = bTrue;
      endif;

      if (isSeqNbrOK = bTrue);
        exsr GetPrvSeq;
        ##WndNbr = Wrk#SeqNbr;
        if (set0010.set_scroll = '*BOTH'
           or set0010.set_scroll = '*LEFT');
          ##StrPage = *hival;
        else;
          ##StrPage = 1;
        endif;
      else;
        ##WndNbr = L#MinSeq;
        ##StrPage = 1;
      endif;

      //  Füllen einer Dummy-Zeile von rechts nach
      //  links zur Ermittlung des 1. anzuzeigenden
      //  Feldes ...
      if (##WndNbr > L#MinSeq);
        exsr pbFillDataRow_Left;
        //  ... kein Feld gefunden
        if (cp <= 0);
          ##WndNbr = L#MinSeq;
          ##StrPage = 1;
        else;
          //  ... Felder gefunden
          if (cp = 1);
            //      ... aber nur 1 Feld
            Wrk#Field = Col_Field(cp);
          else;
            //      ... mehrere Felder
            if (Col_Error(cp) = bFalse);
              //          ... komplett sichtbar
              Wrk#Field = Col_Field(cp);
            else;
              //          ... nicht komplett sichtbar,
              //              nächstes Feld als Startfeld nehmen
              x = cp - 1;
              Wrk#Field = Col_Field(x);
              ##StrPage = 1;
            endif;
            //      ... umrechnen in Feldnummer
            exsr GetSeqNbr;
            if (isSeqNbrOK = bTrue);
              ##WndNbr = Wrk#SeqNbr;
            else;
              ##WndNbr = *loval;
              ##StrPage = 1;
            endif;
          endif;
        endif;
      endif;
    endif;
  endif;

  exsr ChkSeqRnge;
  exsr PBRefresh;

endsr;

//============================================================*
//    C_PageR       F20 - Nach rechts verschieben,            *
//                  ganze Seite                               *
//============================================================*

begsr c_pageRight;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    Wrk#Field = Col_Field(cp);
    exsr GetSeqNbr;
    if (isSeqNbrOK = bTrue);

      if (Col_Error(cp) = bTrue);
        if (cp - NbrPinCol = 1);

          if (set0010.set_scroll = '*BOTH'
              or set0010.set_scroll = '*RIGHT');
            ##WndNbr = Wrk#SeqNbr;
            ##StrPage = ##StrPage + 1;
          else;
            ##WndNbr = Wrk#SeqNbr + 1;
            ##StrPage = 1;
          endif;

        else;
          ##WndNbr = Wrk#SeqNbr;
          ##StrPage = 1;
        endif;
      else;
        ##WndNbr = Wrk#SeqNbr + 1;
        ##StrPage = 1;
      endif;

    else;
      ##WndNbr = *hival;
      ##StrPage = 1;
    endif;

    exsr ChkSeqRnge;
    exsr PBRefresh;
  endif;

endsr;

//============================================================*
//    C_CmdLine     F21 - Befehlszeile                        *
//============================================================*

begsr C_CmdLine;

  if (f_cmdLine = bTrue);
    callp(e) quscmdln();
    *in99 = %error;
  endif;

endsr;

//============================================================*
//    C_ChgScn      F22 - Umschalten der Bildschirmauflösung  *
//============================================================*

begsr C_ChgScn;

  Wrk#ReadDn = SflPage;
  exsr ChgScreen;
  Wrk#ReadDn = Wrk#ReadDn - SflPage;

  exsr PBRefresh;

endsr;

//============================================================*
//    C_MoreOpt     F23 - Weitere Auswahlen                   *
//============================================================*

begsr C_MoreOpt;

  SFTop = SFTop + 1;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    C_NextMark    Fxx - Nächste Markierung ansteueren       *
//============================================================*

begsr C_NextMark;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr GetFrstFld;

    Wrk#SeqNbr = ##WndNbr;
    exsr GetNxtMark;
    if (Wrk#SeqNbr > 0);
      ##WndNbr = Wrk#SeqNbr;
      ##StrPage = 1;
    else;
      Wrk#SeqNbr = *loval;
      exsr GetNxtMark;
      if (Wrk#SeqNbr > 0);
        ##WndNbr = Wrk#SeqNbr;
        ##StrPage = 1;
      else;
      //    ... keine Markierung gefunden
      endif;
    endif;

    exsr ChkSeqRnge;

    exsr PBRefresh;
  endif;

endsr;

//============================================================*
//    C_PrevMark    Fxx - Vorherige Markierung ansteueren     *
//============================================================*

begsr C_PrevMark;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr GetFrstFld;

    Wrk#SeqNbr = ##WndNbr;
    exsr GetPrvMark;
    if (Wrk#SeqNbr > 0);
      ##WndNbr = Wrk#SeqNbr;
      ##StrPage = 1;
    else;
      Wrk#SeqNbr = *hival;
      exsr GetPrvMark;
      if (Wrk#SeqNbr > 0);
        ##WndNbr = Wrk#SeqNbr;
        ##StrPage = 1;
      else;
      //    ... keine Markierung gefunden
      endif;
    endif;

    exsr ChkSeqRnge;

    exsr PBRefresh;
  endif;

endsr;

//============================================================*
//    C_BuildPgm    Erstellen Update Programm                 *
//============================================================*

begsr C_BuildPgm;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    peek52(set0001.SET_Dsp80: COPYRIGHT
          : YAlwLc: YCase: YRcdLock: YNullDft
          : YKeepCrs: YMsgID: YMsgDta: bFalse);

    if (YMsgID = 'USR8112'); // Verarbeitung bestätigt.

      //  Rekursiver CALL auf sich selbst (= PEEK05),
      //  um die alte Referenz auf das Update-Programm zu löschen
      monitor;
        UPDPGM_NAME = f_pgmCallN(sds.pgmName);
        yHeaderType = set0001.SET_HedTyp;
        UPDPGM(YDsp80
               : yHeaderType
               : yCopyright
               : yRcdNbr
               : YFile
               : yLibrary
               : yMember
               : yFunction
               : yCommitLvl
               : yIsUpdKey
               : yScreenNbr
               : yIsLower
               : yCursorPosition.row
               : yCursorPosition.column
               : YMsgID
               : YMsgDta);
      on-error;
      endmon;

      monitor;
        //  Initialisierung
        p_rmvPgmMg(sds.pgmName);

        exsr getPgmName;

        //  Generierung
        peek08(YQFile: peekPgm: rcdl0200.R2FmtName
              : rcdl0200.R2FmtID
              : YAlwLc: YCase: YRcdLock: YNullDft
              : YKeepCrs: sds.PgmLib: YRtnCode);

        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;
    endif;

    peek52(set0001.SET_Dsp80: COPYRIGHT
          : YAlwLc: YCase: YRcdLock: YNullDft
          : YKeepCrs: YMsgID: YMsgDta: bTrue);
  endif;

endsr;

//============================================================*
//    C_Register    Prüfen der Registrierungsdaten            *
//============================================================*

begsr C_Register;

  monitor;
    peek30(set0001.SET_Dsp80: yCopyright
          : YFlag: YMsgID: YMsgDta);
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = *on);
    //  Fehler beim Programmaufruf ...
    p_movPgmMg(sds.pgmName);
    isLicenceError = bTrue;
    leavesr;
  else;
    if (YFlag <> -55
        and YFlag <> 66
        and YFlag <> 243);
      //  Fehler im Wertebereich ...
      isLicenceError = bTrue;
      leavesr;
    else;
      //  Datum ist abgelaufen ...
      if (YFlag = -55);
        isLicenceError = bTrue;
        leavesr;
      else;
      //  Registrierung ist OK ...
      endif;
    endif;
  endif;

  //  "Nachschießen" SPLASH-Screen
  if (YFlag = 243 and set0005.set_spla = bFalse);
    exsr S_SplashOn;
    exsr ShowSplash;
  endif;

  isLicenceError = bFalse;

endsr;

//============================================================*
//    C_ClrPinRw    Löschen der Pin-Tabelle für Zeilen        *
//============================================================*

begsr C_ClrPinRw;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr ClrPinRow;

    //  Merker für aktualisieren der Subfile
    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    C_ClrPinCl    Löschen der Pin-Tabelle für Spalten       *
//============================================================*

begsr C_ClrPinCl;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr ClrPinCol;

    //  Merker für aktualisieren der Subfile
    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    C_DspDbr      Anzeigen der Datenbankrelationen          *
//============================================================*

begsr C_DspDbr;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    monitor;
      peek40(set0001.SET_Dsp80: COPYRIGHT
            : ##File: ##Library: ##Member
            : ##Format: bTrue
            : yRetFile.name: yRetFile.lib
            : YMsgID: YMsgDta);
      *in99 = bFalse;
    on-error;
      *in99 = bTrue;
    endmon;

    if (yRetFile.name = '' or *in99);
    //  ... keine Auswahl getroffen oder Fehler aufgetreten
    else;
      //  ... prüfen auf neue Dateiauswahl
      ##File = yRetFile.name;
      ##Library = yRetFile.lib;

      newAccessMode = i_access;
      exsr changeFile;

      if (IsFileChg = bTrue);
        exsr C_Top;
      else;
      endif;
    endif;
  endif;

endsr;

//============================================================*
//    C_SortBKey    Anzeigen der Sätze in Schlüsselfolge      *
//============================================================*

begsr C_SortBKey;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;
    if (AccessMode = KEY_SEQ);
    //    ... Sortierung stimmt bereits
    else;

      //  Umschalten der Sortierung
      newAccessMode = KEY_SEQ;
      exsr ChangeSort;

    endif;
  endif;

endsr;

//============================================================*
//    C_SortBRrn    Anzeigen der Sätze in Satzfolge           *
//============================================================*

begsr C_SortBRrn;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;
    if (AccessMode = RRN_SEQ);
    //    ... Sortierung stimmt bereits
    else;

      if (f_numBased(##File    :
                  ##Library :
                  ##Member  ) = 1);
        newAccessMode = RRN_SEQ;
        exsr ChangeSort;
      else;
        clear usr8217;
        p_sndPgmMg('USR8217': usr8217: sds.pgmName);
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    C_SortTgl     Umschalten der Sortierfolge               *
//============================================================*

begsr C_SortTgl;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;
    if (AccessMode = RRN_SEQ);
      exsr C_SortBKey;
    else;
      exsr C_SortBRrn;
    endif;
  endif;

endsr;

//============================================================*
//    S_TglKeyLC_UC Umschalten Eingabe der Schlüsselfelder    *
//============================================================*

begsr S_TglKeyLC_UC;

  if (isKeyLower = bFalse);
    isKeyLower = bTrue;
    clear usr8223;
    p_sndPgmMg('USR8223': usr8223: sds.pgmName);
  else;
    isKeyLower = bFalse;
    clear usr8224;
    p_sndPgmMg('USR8224': usr8224: sds.pgmName);
  endif;

endsr;

//============================================================*
//    C_PinCDlg     Pin-Dialog                                *
//============================================================*

begsr C_PinCDlg;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    monitor;
      yPinTabCol = pinTabCol;
      peek50(set0001.SET_Dsp80: COPYRIGHT: yPinTabCol
            : YMsgID: YMsgDta);
      *in99 = bFalse;
    on-error;
      *in99 = bTrue;
    endmon;

    if (*in99 = *off);
      if (YMsgID = 'USR8112'); // Verarbeitung bestätigt.

        exsr ClrPinCol;

        for y = 1 to max_pin_col;
          if (yPinTabCol(y) <> ' ');
            Wrk#Field = yPinTabCol(y);
            exsr PinCol;
          endif;
        endfor;

      endif;
    endif;

  endif;

endsr;

//============================================================*
//    C_Sql         SQL-Auswahl                               *
//============================================================*

begsr C_Sql;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
    leavesr;
  endif;

  if (fild0100.atfila <> '*PHY');

    select;
    when (fild0100.atnofm = 1);
      //  Wenn es sich um eine "single-format logical file" handelt, ...
      //  ... dann prüfen, ob diese Datei über mehere Member geht.
      //      Sortierung nach SQL wird für "multi-member logical files"
      //      (noch) nicht unterstützt ...
      if (fild0100.atjoin = 'N' and
          f_numBased(##File: ##Library: ##Member) > 1);

        clear usr8235;
        p_sndPgmMg('USR8235': usr8235: sds.pgmName);
        leavesr;
      endif;

    when (fild0100.atnofm > 1);
      //  Wenn es sich um eine "multi-format logical file" handelt, ...
      //  ... dann fragen, welches physiche Datei göffnet werden soll:
      peek59(set0001.SET_Dsp80: '*QUESTION'
            : 'USR8212': '': 'YN'
            : YMsgID: YMsgDta);
      usr8190 = YMsgDta;
      if (usr8190.var1 = '*YES');
        f_basedPF(##File     :
                 ##Library  :
                 ##Member   :
                 ##Format   :
                 ##fmtnbr   :
                 ##File     :
                 ##Library  :
                 ##Member   :
                 ##Format   );
      else;
        leavesr;
      endif;

    endsl;

  endif;

  // Let the user enter the SQL WHERE and ORDER BY clauses:
  monitor;
    YFile = ##File;
    yLibrary = ##Library;
    yMember = ##Member;
    YFormat = ##Format;
    YSqlWhere = sqlWhere;
    YSqlOrder = sqlOrder;
    peek48(set0001.SET_Dsp80: COPYRIGHT
          : YFile: yLibrary: yMember
          : YFormat
          : AccessMode: YSqlWhere: YSqlOrder
          : auth.isChgSQLWhereAlw: auth.isChgSQLOrderByAlw
          : YMsgID: YMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 <> *off);
    leavesr;
  endif;

  if (YMsgID <> 'USR8112'); // Verarbeitung bestätigt.
    leavesr;
  endif;

  isPinToClr = bFalse;

  exsr CloseFile;

  ##File = YFile;
  ##Library = yLibrary;
  ##Member = yMember;
  ##Format = YFormat;

  if ((YSqlWhere  <> ' ') or
      (YSqlOrder  <> ' '));
    if (AccessMode <> SQL_SEQ);
      oldAccMode = AccessMode;
    endif;
    AccessMode = SQL_SEQ;
    sqlWhere   = YSqlWhere;
    sqlOrder   = YSqlOrder;
  else;
    AccessMode = oldAccMode;
    sqlWhere   = ' ';
    sqlOrder   = ' ';
  endif;

  exsr OpenFile;

  isPinToClr = bTrue;

endsr;

//============================================================*
//    S_Change      02 - Ändern Einzelsatz                    *
//============================================================*

begsr S_Change;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    if (isUpdMod = bFalse);
      //      Ändern nicht möglich, da INPUT-Modus
      clear usr0007;
      usr0007.var1 = ##File;
      usr0007.var2 = ##Library;
      p_sndPgmMg('USR0007': usr0007: sds.pgmName);
    else;

      exsr getSflRcd;

      if (SflCsr > 0);
        yFunction = '*CHANGE';
        exsr callUpdPgm;
        exsr ReloadUsrStg;
      else;
      //        kein Datensatz verfügbar
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    S_Copy        03 - Kopieren Einzelsatz                  *
//============================================================*

begsr S_Copy;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    if (isUpdMod = bFalse);
      //      Ändern nicht möglich, da INPUT-Modus
      clear usr0007;
      usr0007.var1 = ##File;
      usr0007.var2 = ##Library;
      p_sndPgmMg('USR0007': usr0007: sds.pgmName);
    else;

      exsr getSflRcd;

      if (SflCsr > 0);
        yFunction = '*COPY';
        exsr callUpdPgm;
      else;
      //        kein Datensatz verfügbar
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    S_CopyExt     09 - Kopieren Einzelsatz in externe Datei *
//============================================================*

begsr S_CopyExt;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    if (auth.isUpdAlw = bFalse);
    //      Nachricht "Keine Berechtigung" ausgeben.
    else;

      exsr getSflRcd;

      if (SflCsr > 0);

        if (queryUser <> YPgmCmd);

          //  Abfragen der Zielangaben ...
          exsr pbGetTarget;

          //  Verarbeitung OK ...
          if (isTargetOK = bTrue);
            //  Fragen Benutzer pro Datensatz ...
            exsr pbQueryUser;
          endif;

        else;
          //  Kopieren ohne Sicherheitsabfrage ...
          YMsgID = 'USR8112'; // Verarbeitung bestätigt.
          YMsgDta = '';
        endif;

        //  Datensatz kopieren ...
        if (YMsgID = 'USR8112'); // Verarbeitung bestätigt.
          exsr copyExtRcd;
        endif;

      else;
      //        kein Datensatz verfügbar
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    S_Delete      04 - Löschen Einzelsatz                   *
//============================================================*

begsr S_Delete;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    if (isUpdMod = bFalse);
      //      Löschen nicht möglich, da INPUT-Modus
      clear usr0007;
      usr0007.var1 = ##File;
      usr0007.var2 = ##Library;
      p_sndPgmMg('USR0007': usr0007: sds.pgmName);
    else;

      exsr getSflRcd;

      if (SflCsr > 0);

        if (queryUser <> YPgmCmd);

          //  Fragen Benutzer ...
          exsr pbQueryUser;

        else;
          //  Löschen ohne Sicherheitsabfrage ...
          YMsgID = 'USR8112'; // Verarbeitung bestätigt.
          YMsgDta = '';
        endif;

        //  Datensatz löschen ...
        if (YMsgID = 'USR8112'); // Verarbeitung bestätigt.
          exsr delRecord;
        endif;

      else;
      //        kein Datensatz verfügbar
      endif;
    endif;
  endif;

endsr;

//============================================================*
//    S_Display     05 - Anzeigen Einzelsatz                  *
//============================================================*

begsr S_Display;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr getSflRcd;

    if (SflCsr > 0);

      monitor;
        yHeaderType = set0001.SET_HedTyp;
        PEEK14(set0001.SET_Dsp80: yHeaderType: COPYRIGHT
              : Wrk#RcdNbr: h_file: h_lib: h_mbr
              : h_rcdfmt: '*DISPLAY': commitLvl
              : yScreenNbr: YMsgID: YMsgDta);
        if (YMsgID = 'USR8100'); // Verarbeitung abgebrochen
          p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
          YMsgID = '';
          YMsgDta = '';
        else;
          if (set0001.SET_HedTyp <> yHeaderType);
            set0001.SET_HedTyp = yHeaderType;
            exsr pbHeadline;
          endif;
        endif;
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

    else;
    //        kein Datensatz verfügbar
    endif;
  endif;

endsr;

//============================================================*
//    S_Print       06 - Drucken Datensatz                    *
//============================================================*

begsr S_Print;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr getSflRcd;

    if (SflCsr > 0);

      monitor;
        peek65(Wrk#RcdNbr: h_file: h_lib: h_mbr: ''
              : YMsgID: YMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

      if (YMsgID <> '');
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID  = '';
        YMsgDta = '';
      endif;

    else;
    //        kein Datensatz verfügbar
    endif;
  endif;

endsr;

//============================================================*
//    S_PinRcd      P  - Pin Datensatz                        *
//============================================================*

begsr S_PinRcd;

  if (IsOpen = bFalse);
    //**  F4Open        OREQ      '0'
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    if (f_numBased(##File: ##Library: ##Member) > 1);
      clear usr8218;
      p_sndPgmMg('USR8218': usr8218: sds.pgmName);
      IsCmdErr = bTrue;
      isCancel = bTrue;
    else;

      exsr getSflRcd;

      if (SflCsr > 0);

        if (f_chain04(Wrk#RcdNbr:
                   h_file   :
                   h_lib    :
                   h_mbr    :
                   h_rcdfmt ) = '0');
          exsr PinRecord;

        else;
          //  Datensatz nicht gefunden ...
          p_sndPgmMg('USR8120': '': sds.pgmName);
        endif;

      else;
      //        kein Datensatz verfügbar
      endif;
    endif;
  endif;

endsr;

//============================================================*
//    S_UnPinRcd    UP - UnPin Datensatz                      *
//============================================================*

begsr S_UnPinRcd;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr getSflRcd;

    if (SflCsr > 0);

      exsr ChkPinRcd;
      if (IsPinned = bFalse);
        //  Datensatz ist nicht gepinned ...
        p_sndPgmMg('USR8121': '': sds.pgmName);
      else;
        //  Datensatz ist gepinned ...
        exsr RmvPinRcd;
      endif;

    else;
    //        kein Datensatz verfügbar
    endif;
  endif;

endsr;

//============================================================*
//    S_TgTblPap    Toggeln Tabellierpapierfunktion           *
//============================================================*

begsr S_TgTblPap;

  if (set0001.SET_TblMde = bTrue);
    exsr S_TblPapOf;
  else;
    exsr S_TblPapOn;
  endif;

endsr;

//============================================================*
//    S_TblPapOn    Einschalten Tabellierpapier               *
//============================================================*

begsr S_TblPapOn;

  if (set0001.SET_TblMde = bTrue);
    //  Fehlermeldung ...
    p_sndPgmMg('USR8149': '': sds.pgmName);
  else;
    set0001.SET_TblMde = bTrue;
    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    S_TblPapOf    Ausschalten Tabellierpapier               *
//============================================================*

begsr S_TblPapOf;

  if (set0001.SET_TblMde = bFalse);
    //  Fehlermeldung ...
    p_sndPgmMg('USR8150': '': sds.pgmName);
  else;
    set0001.SET_TblMde = bFalse;
    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    S_TgPinCol    PC - Pin Spalte                           *
//============================================================*

begsr S_TgPinCol;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr GetFldTMrk;

    if (Wrk#Field <> '');
      Pin#Field = Wrk#Field;
      exsr ChkPinCol;
      if (IsPinned = bFalse);
        //  Datensatz ist noch nicht gepinned ...
        //  Spalte pinnen ...
        exsr PinCol;
      else;
        exsr rmvPincolumn;
      endif;
    endif;
  endif;

  //  Beibehalten der Cursorposition ...
  exsr KeepCsrPos;

endsr;

//============================================================*
//    S_PinCol      PC - Pin Spalte                           *
//============================================================*

begsr S_PinCol;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr GetFldTMrk;

    if (Wrk#Field <> '');
      //  Spalte pinnen ...
      exsr PinCol;
    endif;
  endif;

  //  Beibehalten der Cursorposition ...
  exsr KeepCsrPos;

endsr;

//============================================================*
//    S_UnPinCol    UC - UnPin Spalte                         *
//============================================================*

begsr S_UnPinCol;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr GetFldTMrk;

    if (Wrk#Field <> '');
      Pin#Field = Wrk#Field;
      exsr ChkPinCol;
      if (IsPinned = bFalse);
        //  Spalte ist nicht gepinned ...
        clear usr8147;
        usr8147.var1 = Wrk#Field;
        p_sndPgmMg('USR8147': usr8147: sds.pgmName);
      else;
        //  Spalte ist gepinned ...
        exsr rmvPincolumn;
      endif;
    endif;
  endif;

  //  Beibehalten der Cursorposition ...
  exsr KeepCsrPos;

endsr;

//============================================================*
//    S_SplashOn    Einschalten Splash-Screen                 *
//============================================================*

begsr S_SplashOn;

  set0005.set_spla = bTrue;

  p_sndPgmMg('USR8161': '': sds.pgmName);

endsr;

//============================================================*
//    S_SplashOf    Ausschalten Splash-Screen                 *
//============================================================*

begsr S_SplashOf;

  set0005.set_spla = bFalse;

  p_sndPgmMg('USR8162': '': sds.pgmName);

endsr;

//============================================================*
//    S_ShortCmd    Ausführen Kurzbefehl                      *
//============================================================*

begsr S_ShortCmd;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    exsr getSflRcd;

    if (SflCsr > 0);

      clear ShortCmd;
      ShortCmd.SC_Action = '*CMD';
      ShortCmd.SC_Cmd = YCmdDta;

      monitor;
        peek42(h_file: h_lib: h_mbr: h_rcdfmt
              : ShortCmd: Wrk#RcdNbr: YExecCmd
              : YMsgID: YMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

      select;
      when (*in99 = *on);
      //           Program error
      when (YMsgID <> *blanks);
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';

      when (YExecCmd = *blanks);
      //           No command to excute
      other;
        f_execute(YExecCmd: YMsgID: YMsgDta);
        if (YMsgID <> '');
          p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
          YMsgID = '';
          YMsgDta = '';
        endif;
      endsl;

    else;
    //        kein Datensatz verfügbar
    endif;
  endif;

endsr;

//============================================================*
//    S_About        A - Über Peek/400                        *
//============================================================*

begsr S_About;

  peek49(set0001.SET_Dsp80: COPYRIGHT
        : RELEASE: VERSION
        : YMsgID: YMsgDta);

endsr;

//============================================================*
//    S_DspNrm      Normale Anzeige                           *
//============================================================*

begsr S_DspNrm;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;
    if (set0001.SET_DspMde = '*DSPNRM');
    //    ... Anzeige stimmt bereits
    else;

      //  Umschalten der Anzeige
      set0001.SET_DspMde = '*DSPNRM';
      isSflDirty = bTrue;

    endif;
  endif;

endsr;

//============================================================*
//    S_DspHex      Hexadezimale Anzeige                      *
//============================================================*

begsr S_DspHex;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;
    if (set0001.SET_DspMde = '*DSPHEX');
    //    ... Anzeige stimmt bereits
    else;

      if (File#X.RcdLen > RCD_BUFF_LEN);
        clear usr8206;
        usr8206.var1   = RCD_BUFF_LEN;
        p_sndPgmMg('USR8206': usr8206: sds.pgmName);
      else;
        set0001.SET_DspMde = '*DSPHEX';
        isSflDirty = bTrue;
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    S_DspTgl      Umschalten der Anzeige                    *
//============================================================*

begsr S_DspTgl;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;
    if (set0001.SET_DspMde = '*DSPNRM');
      exsr S_DspHex;
    else;
      exsr S_DspNrm;
    endif;

    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    S_SaveEnv     Sichern Arbeitsumgebung                   *
//============================================================*

begsr S_SaveEnv;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    peek56(set0001.SET_Dsp80: COPYRIGHT: '*SAVE'
          : YEnvFile: YEnvLib: YEnvMbr
          : $$rcdfmtid
          : YQFile: yMember: YText: YOption
          : YMsgID: YMsgDta);

    if (YMsgID <> ' ');
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
    else;

      YEnvFile = YFile;
      YEnvLib  = yLibrary;
      YEnvMbr  = yMember;
      YIsAutoSave = bFalse;
      exsr SaveEnv;

      if (YMsgID <> ' ');
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
      endif;

    endif;

  endif;

endsr;

//============================================================*
//    S_LoadEnv     Laden Arbeitsumgebung                     *
//============================================================*

begsr S_LoadEnv;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    peek56(set0001.SET_Dsp80: COPYRIGHT: '*LOAD'
          : YEnvFile: YEnvLib: YEnvMbr
          : $$rcdfmtid
          : YQFile: yMember: YText: YOption
          : YMsgID: YMsgDta);

    if (YMsgID <> ' ');
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
    else;

      YEnvFile = YFile;
      YEnvLib  = yLibrary;
      YEnvMbr  = yMember;
      exsr LoadEnv;
      if (YMsgID <> ' ');
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
      endif;

      isSflDirty = bTrue;
    endif;
  endif;

endsr;

//============================================================*
//    LoadEnv       Laden Arbeitsumgebung                     *
//============================================================*

begsr LoadEnv;

  isPinToClr = bFalse;

  if (##Member = '*NONE');
    leavesr;
  endif;

  clear rtn;
  rtn.file = ##File;
  rtn.library = ##Library;
  rtn.member = ##Member;
  rtn.format = ##Format;
  rtn.AccessMode = AccessMode;
  rtn.sqlWhere = sqlWhere;
  rtn.sqlOrder = sqlOrder;

  peek55(##File: ##Library: ##Member: ##Format
        : $$rcdfmtid
        : YEnvFile: YEnvLib: YEnvMbr
        : YOption
        : PinTabRcd: nbrPinRcd
        : pinTabCol: NbrPinCol
        : rtn.file: rtn.library: rtn.member
        : rtn.format
        : rtn.AccessMode: rtn.sqlWhere
        : rtn.sqlOrder
        : isKeyLower
        : YMsgID: YMsgDta);

  if (YMsgID <> ' ');
  // TODO: remove code
  // p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
  // yMsgID = '';
  // yMsgDta = '';
  else;

    if (##File     <> rtn.file or
       ##Library  <> rtn.library or
       ##Member   <> rtn.member or
       ##Format   <> rtn.format or
       AccessMode <> rtn.AccessMode or
       sqlWhere   <> rtn.sqlWhere or
       sqlOrder   <> rtn.sqlOrder);
      exsr CloseFile;
      ##File     = rtn.file;
      ##Library  = rtn.library;
      ##Member   = rtn.member;
      ##Format   = rtn.format;
      AccessMode = rtn.AccessMode;
      sqlWhere   = rtn.sqlWhere;
      sqlOrder   = rtn.sqlOrder;
      exsr OpenFile;
      peek55(##File: ##Library: ##Member: ##Format
            : $$rcdfmtid
            : YEnvFile: YEnvLib: YEnvMbr
            : YOption
            : PinTabRcd: nbrPinRcd
            : pinTabCol: NbrPinCol
            : rtn.file: rtn.library: rtn.member
            : rtn.format
            : rtn.AccessMode: rtn.sqlWhere
            : rtn.sqlOrder
            : isKeyLower
            :YMsgID: YMsgDta);
    endif;

    isKeyLower = yIsKeyLower;
  endif;

  isPinToClr = bTrue;

endsr;

//============================================================*
//    SaveEnv       Speichern Arbeitsumgebung                 *
//============================================================*

begsr SaveEnv;

  peek54(##File: ##Library: ##Member: ##Format
        : $$rcdfmtid
        : YEnvFile: YEnvLib: YEnvMbr
        : YIsAutoSave
        : PinTabRcd: nbrPinRcd
        : pinTabCol: NbrPinCol
        : AccessMode: sqlWhere
        : sqlOrder: isKeyLower
        : YMsgID: YMsgDta);

endsr;

//============================================================*
//    S_DelEnv      Löschen Arbeitsumgebung                   *
//============================================================*

begsr S_DelEnv;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    for do_x2 = 1 to *hival;

      peek56(set0001.SET_Dsp80: COPYRIGHT: '*DELETE'
            : YEnvFile: YEnvLib: YEnvMbr
            : ''
            : YQFile: yMember: YText: YOption
            : YMsgID: YMsgDta);

      if (YMsgID <> ' ');
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
        leave;
      else;

        peek57(set0001.SET_Dsp80: COPYRIGHT
              : YFile: yLibrary: yMember: YText
              : YMsgID: YMsgDta);

        if (YMsgID <> ' ');
          if (YMsgDta = '*CANCEL');
            iter;
          else;
            p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
            YMsgID = '';
            YMsgDta = '';
            leave;
          endif;
        endif;

      endif;

    endfor;

  endif;

endsr;

//============================================================*
//    MsgNoFile     Nachricht: Keine Datei geöffnet           *
//============================================================*

begsr MsgNoFile;

  clear usr9996;
  p_sndPgmMg('USR9996': usr9996: sds.pgmName);

endsr;

//============================================================*
//    msgInvSqlFile Nachricht: Keine Datei geöffnet           *
//============================================================*

begsr msgInvSqlFile;

  clear usr9993;
  p_sndPgmMg('USR9993': usr9993: sds.pgmName);

endsr;

//============================================================*
//    ClrPinRow     Löschen der Pin-Tabelle für Zeilen        *
//============================================================*

begsr ClrPinRow;

  if (isPinToClr = bTrue);
    nbrPinRcd = 0;
    exsr clrPinTabR;
    isSflDirty = bTrue;
  else;
  //    ... wird nicht gelöscht
  endif;

endsr;

//============================================================*
//    ClrPinCol     Löschen der Pin-Tabelle für Spalten       *
//============================================================*

begsr ClrPinCol;

  if (isPinToClr = bTrue);
    NbrPinCol = 0;
    clear pinTabCol;
    isSflDirty = bTrue;
  else;
  //    ... wird nicht gelöscht
  endif;

endsr;

//============================================================*
//    PBGetTargt    Abffragen der Zieldatei                   *
//============================================================*

begsr pbGetTarget;

  if (isTargetOK);
    YMsgID = 'USR8112'; // Verarbeitung bestätigt.
    YMsgDta = '';
    leavesr;
  endif;

  monitor;
    peek26(set0001.SET_Dsp80: YQFile: h_mbr
          : copyExternal.file: copyExternal.lib: copyExternal.toMbr
          : copyExternal.mbrOpt: copyExternal.crtFile: YMsgID: YMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = *on);
    IsError = bTrue;
    isTargetOK = bFalse;
  else;
    IsError = bFalse;
    //  Abbruch mit F3/F12 (USR8100): kein Ziel, nichts kopieren
    if (YMsgID = 'USR8112'); // Verarbeitung bestätigt.
      isTargetOK = bTrue;
    else;
      isTargetOK = bFalse;
    endif;
  endif;

endsr;

//============================================================*
//    PBQueryUsr    Fragen Benutzer                           *
//============================================================*

begsr pbQueryUser;

  monitor;
    yHeaderType = set0001.SET_HedTyp;
    PEEK14(set0001.SET_Dsp80: yHeaderType: COPYRIGHT
          : Wrk#RcdNbr: h_file: h_lib: h_mbr
          : h_rcdfmt: YPgmCmd: commitLvl
          : yScreenNbr: YMsgID: YMsgDta);
    if (YMsgID = 'USR8100'); // Verarbeitung abgebrochen
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
    else;
      if (set0001.SET_HedTyp <> yHeaderType);
        set0001.SET_HedTyp = yHeaderType;
        exsr pbHeadline;
      endif;
    endif;
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = *on);
  //            Fehler beim Programmaufruf
  else;

    select;
    when (YMsgID = 'USR8100'); // Verarbeitung abgebrochen. (F3/F12)

    when (YMsgID = 'USR8111'); // Alle Datensätze verarbeiten.
      queryUser = YPgmCmd;
      YMsgID = 'USR8112'; // Verarbeitung bestätigt.
      YMsgDta = '';
      p_sndPgmMg('USR8112': '': sds.pgmName); // Verarbeitung bestätigt.

    when (YMsgID = 'USR8112'); // Verarbeitung bestätigt.

    //  Unerwartete Nachrichten-ID ...
    other;
      clear usr9998;
      usr9998.var1 = YMsgID;
      usr9998.var2 = 'PEEK14';
      p_sndPgmMg('USR9998': usr9998: sds.pgmName);
    endsl;

  endif;

endsr;

//============================================================*
//    PinRecord     Datensatz pinnen                          *
//============================================================*

begsr PinRecord;

  IsPinOK = bFalse;

  exsr ChkPinRcd;
  if (IsPinned = bFalse);
    //  Datensatz ist noch nicht gepinned ...
    clear pinTabRcdE;
    x = %lookup(pinTabRcdE: PinTabRcd: x);
    if (x > 0);
      //  ... Datensatz pinnen
      pinTabRcdE.RcdNbr = Wrk#RcdNbr;
      pinTabRcdE.file = h_file;
      pinTabRcdE.lib = h_lib;
      pinTabRcdE.mbr = h_mbr;
      pinTabRcdE.rcdFmt = h_rcdfmt;
      pinTabRcdE.mbrNbr = h_mbrnbr;
      PinTabRcd(x) = pinTabRcdE;

      nbrPinRcd = x;
      isSflDirty = bTrue;
      IsPinOK = bTrue;
    else;
      //  Kein Platz mehr vorhanden ...
      p_sndPgmMg('USR8118': '': sds.pgmName);
    endif;

  else;
    //  Datensatz ist schon gepinned
    p_sndPgmMg('USR8119': '': sds.pgmName);
  endif;

endsr;

//============================================================*
//    PinCol        Spalte pinnen                             *
//============================================================*

begsr PinCol;

  IsPinOK = bFalse;

  Pin#Field = Wrk#Field;
  exsr ChkPinCol;
  if (IsPinned = bFalse);
    //  Datensatz ist noch nicht gepinned ...
    x = 1;
    Pin#Field = '';
    x = %lookup(Pin#Field: pinTabCol: x);
    if (x > 0);
      //  ... Datensatz pinnen
      pinTabCol(x) = Wrk#Field;
      NbrPinCol = x;
      isSflDirty = bTrue;
      IsPinOK = bTrue;
    else;
      //  Kein Platz mehr vorhanden ...
      p_sndPgmMg('USR8118': '': sds.pgmName);
    endif;

  else;
    //  Datensatz ist schon gepinned
    p_sndPgmMg('USR8119': '': sds.pgmName);
  endif;

endsr;

//============================================================*
//    DelRecord     Löschen Datensatz                         *
//============================================================*

begsr delRecord;

  if (f_chain00(Wrk#RcdNbr: h_file: h_lib: h_mbr: '') = bTrue);

    //  Fehler bei Zugriff auf Datensatz ...
    usr8200.var1 = Wrk#RcdNbr;
    p_sndPgmMg('USR8200': usr8200: sds.pgmName);

  else;

    if (CIO_delete(hFile00) = bTrue);
      *in99 = '0';
    else;
      *in99 = '1';
    endif;
    exsr F0toFx;

    if (*in99 = *on);
      if (*in55 = bTrue);
        rolbk;
      else;
        CIO_unlock(hFile00);
      endif;
      exsr F0toFx;

      usr8200.var1 = Wrk#RcdNbr;
      p_sndPgmMg('USR8200': usr8200: sds.pgmName);
    else;
      if (*in55 = bTrue);
        commit;
      else;
        CIO_unlock(hFile00);
      endif;
      exsr F0toFx;
      exsr callExit04;

      usr8201.var1 = Wrk#RcdNbr;
      p_sndPgmMg('USR8201': usr8201: sds.pgmName);
      isSflDirty = bTrue;
    endif;

  endif;

endsr;

//============================================================*
//  Call EXIT04. The exit program must not exist.             *
//  The exit program is optional.
//============================================================*

begsr callExit04;

  if (f_exist('EXIT04': '*LIBL': '*PGM') = bTrue);
    callp EXIT04(File#X.file: File#X.library: File#X.member
                 : '*DELETE': sds.user: %timestamp()
                 : Wrk#RcdNbr: File#X.RcdLen: %addr(IO_Buff): *null);
  endif;

endsr;

//============================================================*
//    CopyExtRcd    Kopieren Datensatz in externe Datei       *
//============================================================*

begsr copyExtRcd;

  if (f_chain04(Wrk#RcdNbr:
             h_file   :
             h_lib    :
             h_mbr    :
             h_rcdfmt ) = '0');

    rcdNbr# = CIO_getRRN(hFile04);

    f_execute(
      'CPYF ' +
        'FROMFILE(' +
          %trim(CIO_getLibrary(hFile04)) +
        '/' +
          %trim(CIO_getFile(hFile04)) +
        ') ' +
        'TOFILE(' +
          %trim(copyExternal.lib) +
        '/' +
          %trim(copyExternal.file) +
        ') ' +
        'FROMMBR(' +
          %trim(CIO_getMember(hFile04)) +
        ') ' +
        'TOMBR(' +
          %trim(copyExternal.toMbr) +
        ') ' +
        'MBROPT(' +
          %trim(copyExternal.mbrOpt) +
        ') ' +
        'CRTFILE(' +
          %trim(copyExternal.crtFile) +
        ') ' +
        'FROMRCD(' +
          rcdNbr$ +
        ') ' +
        'TORCD(' +
          rcdNbr$ +
        ') ' +
        'FMTOPT(' +
          '*MAP *DROP' +
        ') ' +
        'RCDFMT(' +
          %trim(CIO_getRecordFormat(hFile04)) +
           ')'
      : YMsgID: YMsgDta);

    if (YMsgID <> '');
      IsCmdErr = bTrue;
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
      if (*in55 = bTrue);
        rolbk;
      endif;
      exsr F0toFx;

      usr8202.var1 = Wrk#RcdNbr;
      p_sndPgmMg('USR8202': usr8202: sds.pgmName);
    else;
      if (*in55 = bTrue);
        commit;
      endif;
      exsr F0toFx;

      usr8203.var1 = Wrk#RcdNbr;
      p_sndPgmMg('USR8203': usr8203: sds.pgmName);
    endif;

  endif;

  //  Alles weitere mit ...
  copyExternal.mbrOpt = '*ADD';

endsr;

//============================================================*
//    SrchStart     Aufsetzen mit neuer Suche                 *
//============================================================*

begsr SrchStart;

  //  Übertragen der Übergabeparameter ...
  SrchField = YField;
  SrchOP = YOperation;
  SrchArg = %trimr(YArgument);
  SrchSign = YSign;

  //  ... Anpassungen für LIKE/NLIKE ...
  if (SrchOP = 'LIKE'
      or SrchOP = 'NLIKE');
    //      ... führendes %-Zeichen
    a1 = %subst(SrchArg:1:1);
    if (a1 = set0002.set_wldcd);
      SrchArg = %subst(SrchArg:2);
      SrchLikeTp = 1;
    else;
      SrchArg = SrchArg;
      SrchLikeTp = 0;
    endif;

    //      ... nachgestelltes %-Zeichen
    x = %checkr(' ': SrchArg);
    if (x > 0);
      a1 = %subst(SrchArg: x: 1);

      if (a1 = set0002.set_wldcd);
        x = x - 1;
        if (x > 0);
          SrchArg = %subst(SrchArg: 1: x);
        else;
          SrchArg = *blanks;
        endif;
        SrchLikeTp = SrchLikeTp + 2;
      endif;

    endif;

    //      ... Länge von SrchArg
    SrchLikeLn = %checkr(' ': SrchArg);
  else;
    //  ... keine Anpassungen erforderlich
    SrchLikeTp = 0;
    SrchLikeLn = 0;
  endif;

  SrchNbrs = YSrchNbrs;
  SrchType = YSrchType;
  SrchCase = YSrchCase;

  //  Ermitteln der Feldattribute
  exsr srchFldAtr;

  if (SrchField = '*RECORD');
    SrchIsNum = bFalse;
  else;
    if (f_isNumFld(fldl0100) = bTrue);
      SrchIsNum = bTrue;
    else;
      SrchIsNum = bFalse;
    endif;
  endif;

  //  Nicht Case-Sensitive suchen ...
  if (YSrchCase = bFalse and SrchIsNum = bFalse);
    SrchArg = %xlate(C_LOWER: C_UPPER: SrchArg);
  else;
  //      keine Konvertierung erforderlich
  endif;

  //  Numerische Suche ...
  if (SrchIsNum = bTrue);
    if (f_isFloatFld(fldl0100) = bTrue);
      SrchArgFloat = %float(SrchArg);
      SrchArgVal   = 0;
      SrchArgIsFloat = bTrue;
    else;
      SrchArgVal   = %dec(SrchArg
                         : cSRCHARG_DIGITS
                         : cSRCHARG_DECPOS);
      SrchArgFloat = 0;
      SrchArgIsFloat = bFalse;
    endif;
    if (SrchSign = set0003.SET_SignM);
      //  ... negativen Wert erzeugen
      SrchArgVal = SrchArgVal * -1;
      SrchArgFloat = SrchArgFloat * -1;
    else;
    //  ... positiven Wert belassen
    endif;
  else;
    SrchArgVal = 0;
    SrchArgFloat = 0;
  endif;

  //  Ermitteln des Startdatensatzes
  exsr SrchStrRcd;

  //  Suchen ...
  exsr SrchUp;

endsr;

//============================================================*
//    SrchCont      Fortsetzen der Suche nach "gefunden"      *
//============================================================*

begsr SrchCont;

  //  Ermitteln der Feldattribute
  exsr srchFldAtr;

  //  Ermitteln des Startdatensatzes
  exsr SrchStrRcd;

  //  Suchen ...
  exsr SrchUp;

endsr;

//============================================================*
//    SrchContM     Fortsetzen der Suche nach "MAXIMUM"       *
//============================================================*

begsr SrchContM;

  //  Ermitteln der Feldattribute
  exsr srchFldAtr;

  //  Suchen ...
  exsr SrchUp;

endsr;

//============================================================*
//    SrchEOF       Fortsetzen der Suche nach Dateiende       *
//============================================================*

begsr SrchEOF;

  //  Ermitteln der Feldattribute
  exsr srchFldAtr;

  //  Ermitteln des Startdatensatzes
  exsr PBMoveTop;

  //  Suchen ...
  exsr SrchUp;

endsr;

//============================================================*
//    SrchStrRcd    Positionieren auf Startdatensatz          *
//============================================================*

begsr SrchStrRcd;

  //---------------------------------------*
  //  Cursor im Subfilebereich ...
  //---------------------------------------*
  if (SflCsr <> 0
      and SflCsr > nbrPinRcd);

    //  ... übersetzen in Satznummer
    exsr pbCsrToRcd;
    //  ... Fortsetzen der Suche
    if (Wrk#RcdNbr = SrchFndRcd);
      exsr PBReadCsrA;
    else;
      //  ... oder neu anfangen
      exsr PBReadCsr;
    endif;
  else;

    //---------------------------------------*
    //  Cursor nicht im Subfilebereich ...   *
    //---------------------------------------*
    x = SflFirstRw + nbrPinRcd;
    if (cursorPosition.row < x);
      //  ... oberhalb der Subfile
      exsr pbReadDown;
    else;
    //  ... unterhalb der Subfile
    //             einfach weitersuchen
    endif;
  endif;

endsr;

//============================================================*
//    SrchFldAtr    Ermitteln der Feldattribute des           *
//                  Suchfeldes                                *
//============================================================*

begsr srchFldAtr;

  clear f_key;
  f_key.F_Field = SrchField;
  chain(n) %kds(f_key) fpeekfld;
  if (not %found());
    clear fldl0100;
  else;
    fldl0100 = f_ffd;
  endif;

endsr;

//============================================================*
//    SrchUp        Suchen ab einer gegebenen Satznummer      *
//============================================================*

begsr SrchUp;

  //  Suche läuft ...
  p_sndStsMg('USR8127': ' ');

  SrchCount = 0;
  SrchCount2 = 0;

  for do_x3 = 1 to *hival;
    exsr PBRead;
    if (IsEOF = bTrue);
      SrchMode = '*EOF';
      leave;
    endif;

    SrchCount = SrchCount + 1;
    if (SrchCount >= SrchNbrs);
      SrchMode = '*MAXIMUM';
      leave;
    endif;

    exsr srchCompare;
    if (IsFound = bTrue);
      SrchMode = '*FOUND';
      //  ... suchen & pinnen
      if (SrchType = '*PINROW');
        Wrk#RcdNbr = File#X.RcdNbr;
        exsr PinRecord;
        if (IsPinOK = bFalse);
          leave;
        else;
        //        weiter suchen und pinnen
        endif;
      else;
        //  ... sonstige Suchfunktionen
        leave;
      endif;
    endif;

    SrchCount2 = SrchCount2 + 1;
    if (SrchCount2 >= SrchDspMsg);
      SrchCount2 = 0;

      clear usr8128;
      usr8128.var1 = SrchCount;
      usr8128.var2 = SrchNbrs;
      p_sndStsMg('USR8128': usr8128);
    endif;

  endfor;

  //  Statuszeile löschen ...
  p_sndStsMg('USR9999': ' ');

endsr;

//============================================================*
//    SrchComp      Vergleichen der Suchauswahl               *
//============================================================*

begsr srchCompare;

  IsFound = bFalse;

  //  Im ganzen Datensatz suchen ...
  if (SrchField = '*RECORD');
    SrchCmpRcd = IO_Buff;
  else;
    exsr SrchGetCmp;
  endif;

  //  Im ganzen Datensatz suchen ...
  if (SrchField = '*RECORD');
    exsr SrchComp_R;
  else;
    //  Im Datenfeld suchen ...
    exsr SrchComp_F;
  endif;

endsr;

//============================================================*
//    SrchGetCmp    Dateninhalt aus Datensatz extrahieren     *
//                  für Vergleich der Suchfunktion            *
//============================================================*

begsr SrchGetCmp;

  if (SrchIsNum = bTrue);
    f_rtvFld(YBuffer  :
            IO_Buff  :
            fldl0100 :
            bTrue    );

    YTgtValue  = ' ';

    if (SrchArgIsFloat = bTrue);
      peek18(fldl0100: 'FLDL0100': YBuffer:
            '*FLOAT': '': YOutBuffer: YOutBuffLn
            : YMsgID: YMsgDta);

      SrchCmpFloat = %float(YOutBuffer);
      SrchCmpVal   = 0;
    else;
      peek18(fldl0100: 'FLDL0100': YBuffer:
            '*ZONED': '': YOutBuffer: YOutBuffLn
            : YMsgID: YMsgDta);

      SrchCmpStr =
       %subst(YOutBuffer
              : YOutBuffLn - %len(SrchCmpStr) + 1
              : YOutBuffLn);
      SrchCmpVal = %dec(SrchCmpStr
                       : srch_cmp_val_length
                       : srch_cmp_val_decpos);
      SrchCmpFloat = 0;
    endif;

  else;
    f_rtvFld(SrchCmpStr:
            IO_Buff   :
            fldl0100  );
  endif;

endsr;

//============================================================*
//    SrchComp_R    Suchen im Datensatz                       *
//============================================================*

begsr SrchComp_R;

  //  Nicht Case-Sensitive suchen ...
  if (SrchCase = bFalse);
    SrchCmpRcd = %xlate(C_LOWER: C_UPPER: SrchCmpRcd);
  //  Case-Sensitive suchen ...
  endif;

  x = %checkr(' ': SrchArg);
  if (x <> 0);
    x = %scan(%subst(SrchArg: 1: x): SrchCmpRcd: 1);
  else;
    x = %scan(SrchArg: SrchCmpRcd: 1);
  endif;

  //  Gleich ...
  if (SrchOP = 'LIKE');
    //  ... nicht gefunden
    if (x = 0);
      IsFound = bFalse;
    else;
      //  ... gefunden
      IsFound = bTrue;
    endif;
  else;
    //  UnGleich ...
    //  ... nicht gefunden
    if (x = 0);
      IsFound = bTrue;
    else;
      //  ... gefunden
      IsFound = bFalse;
    endif;
  endif;

endsr;

//============================================================*
//    SrchComp_F    Suchen im Feld                            *
//============================================================*

begsr SrchComp_F;

  //  Nicht Case-Sensitive suchen ...
  //  (nur bei nicht numerischer Suche beachten)
  if (SrchCase = bFalse and SrchIsNum = bFalse);
    SrchCmpStr = %xlate(C_LOWER: C_UPPER: SrchCmpStr);
  //  Case-Sensitive suchen ...
  endif;

  //-----------------------*
  //  Vergleichen ...      *
  //-----------------------*
  select;
  //  Gleich ...
  when (SrchOP = 'EQ');
    if (SrchIsNum = bFalse);
      if (SrchCmpStr = SrchArg);
        IsFound = bTrue;
      endif;
    else;
      if ((SrchArgIsFloat = bFalse and
          SrchCmpVal = SrchArgVal) or
          (SrchArgIsFloat = bTrue  and
          SrchCmpFloat = SrchArgFloat));
        IsFound = bTrue;
      endif;
    endif;
  //  UnGleich ...
  when (SrchOP = 'NE');
    if (SrchIsNum = bFalse);
      if (SrchCmpStr <> SrchArg);
        IsFound = bTrue;
      endif;
    else;
      if ((SrchArgIsFloat = bFalse and
          SrchCmpVal <> SrchArgVal) or
          (SrchArgIsFloat = bTrue  and
          SrchCmpFloat <> SrchArgFloat));
        IsFound = bTrue;
      endif;
    endif;
  //  Größer ...
  when (SrchOP = 'GT');
    if (SrchIsNum = bFalse);
      if (SrchCmpStr > SrchArg);
        IsFound = bTrue;
      endif;
    else;
      if ((SrchArgIsFloat = bFalse and
          SrchCmpVal > SrchArgVal) or
          (SrchArgIsFloat = bTrue  and
          SrchCmpFloat > SrchArgFloat));
        IsFound = bTrue;
      endif;
    endif;
  //  Kleiner ...
  when (SrchOP = 'LT');
    if (SrchIsNum = bFalse);
      if (SrchCmpStr < SrchArg);
        IsFound = bTrue;
      endif;
    else;
      if ((SrchArgIsFloat = bFalse and
          SrchCmpVal < SrchArgVal) or
          (SrchArgIsFloat = bTrue  and
          SrchCmpFloat < SrchArgFloat));
        IsFound = bTrue;
      endif;
    endif;
  //  Größer/Gleich ...
  when (SrchOP = 'GE');
    if (SrchIsNum = bFalse);
      if (SrchCmpStr >= SrchArg);
        IsFound = bTrue;
      endif;
    else;
      if ((SrchArgIsFloat = bFalse and
          SrchCmpVal >= SrchArgVal) or
          (SrchArgIsFloat = bTrue  and
          SrchCmpFloat >= SrchArgFloat));
        IsFound = bTrue;
      endif;
    endif;
  //  Kleiner/Gleich ...
  when (SrchOP = 'LE');
    if (SrchIsNum = bFalse);
      if (SrchCmpStr <= SrchArg);
        IsFound = bTrue;
      endif;
    else;
      if ((SrchArgIsFloat = bFalse and
          SrchCmpVal <= SrchArgVal) or
          (SrchArgIsFloat = bTrue  and
          SrchCmpFloat <= SrchArgFloat));
        IsFound = bTrue;
      endif;
    endif;
  //  Ähnlich ...
  when (SrchOP = 'LIKE'
     or SrchOP = 'NLIKE');

    select;
    //  ...   ('%ABCD')
    when (SrchLikeTp = 1);
      x = %checkr(' ': SrchCmpStr);
      x = x - SrchLikeLn;
      x = x + 1;
      if (x > 0);
        SrchCmpStr= %subst(SrchCmpStr: x: SrchLikeLn);
        if (SrchCmpStr = SrchArg);
          IsFound = bTrue;
        endif;
      endif;

    //  ...   ('ABCD%')
    when (SrchLikeTp = 2);
      SrchCmpStr= %subst(SrchCmpStr: 1: SrchLikeLn);
      if (SrchCmpStr = SrchArg);
        IsFound = bTrue;
      endif;

    //  ...   ('%ABCD%')
    other;
      x = SrchLikeLn;
      x = %scan(%subst(SrchArg: 1: x): SrchCmpStr: 1);
      if (x > 0);
        IsFound = bTrue;
      endif;

    endsl;

    //  ... auswerten IsFound für LIKE/NLIKE
    if (SrchOP = 'LIKE');
    //        ... IsFound ist bereits richtig gesetzt.
    else;
      //        ... IsFound muß negiert werden ...
      if (IsFound = bTrue);
        IsFound = bFalse;
      else;
        IsFound = bTrue;
      endif;
    endif;

  other;
  endsl;

endsr;

//============================================================*
//    SrchInz       Initialisieren der Suchfunktion           *
//============================================================*

begsr SrchInz;

  SrchMode = '*NEW';
  SrchFndRcd = 0;

  SrchField = *blanks;
  SrchOP = *blanks;
  SrchArg = *blanks;
  SrchSign = *blanks;
  SrchNbrs = 0;
  SrchType = *blanks;

  SrchCmpStr = *blanks;
  SrchCount = 0;

  SrchCount = 0;
  SrchCount2 = 0;
  SrchDspMsg = 1000;

endsr;

//============================================================*
//    CallUpdPgm    Aufrufen Updateprogramm für F6, 2, 3      *
//============================================================*

begsr callUpdPgm;

  isTryed = bFalse;

  dou (*in99 = *off);

    exsr getPgmName;
    exsr getDspName;


    if (yFunction = '*ADD');
      yRcdNbr = 0;
    else;
      yRcdNbr = Wrk#RcdNbr;
    endif;

    if (not f_exist(peekDspF: '*LIBL': '*FILE'));
      *in99 = bTrue;
    else;
      monitor;
        UPDPGM_NAME = f_pgmCallN(peekPgm);
        yHeaderType = set0001.SET_HedTyp;
        UPDPGM(set0001.SET_Dsp80
               : yHeaderType
               : COPYRIGHT
               : yRcdNbr
               : File#X.file
               : File#X.library
               : File#X.member
               : yFunction
               : commitLvl
               : isUpdKey
               : yScreenNbr
               : yIsLower
               : yCursorPosition.row
               : yCursorPosition.column
               : YMsgID
               : YMsgDta);
        if (YMsgID = 'USR8100'); // Verarbeitung abgebrochen
          p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
          YMsgID = '';
          YMsgDta = '';
        else;
          isSflDirty = bTrue;
          if (set0001.SET_HedTyp <> yHeaderType);
            set0001.SET_HedTyp = yHeaderType;
            exsr pbHeadline;
          endif;
        endif;
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;
    endif;

    // Wenn der Programmaufruf
    // fehlgeschlagen ist, ...
    if (*in99 = *on);
      // ... und kein REBUILD stattgefunden hat, ...
      if (isTryed = bFalse);
        // ... dann versuchen, das Programm neu zu serstellen
        exsr C_BuildPgm;
        isTryed = bTrue;
        if (*in99 = *off);
          // Wenn das Programm neu erstellt werden konnte,
          // dann einen neuen Versuch unternehmen ...
          *in99 = '1';
          iter;
        else;
          // ... ansonsten abbrechen
          IsCmdErr = bTrue;
          isCancel = bTrue;
          leave;
        endif;
      else;
        // kein weiterer Versuch möglich ...
        leave;
      endif;
    else;
    // Der Programmaufruf hat funktioniert
    endif;

  enddo;

endsr;

//============================================================*
//    ReloadUsrStg  Aktualisieren Benutzereinstellungen       *
//============================================================*

begsr ReloadUsrStg;

  if (YMsgID = 'USR8100'); // Verarbeitung abgebrochen
    leavesr;
  endif;

  if (##Format <> 'FPEEKUSR');
    leavesr;
  endif;

  if (##File <> sds.user);
    leavesr;
  endif;

  //  *SPLASH
  set0005 = f_getUsrSg('*SPLASH'   );

endsr;

//============================================================*
//    PBInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr PBInit;

  //  Merker für: Subfile gelöscht setzen
  IsPBINIT = bTrue;

  *in80 = '0';
  *in81 = '1';
  *in82 = '1';
  *in83 = '1';
  if (*in88 = bFalse);
    write pbctl132;
  else;
    write pbctl080;
  endif;

  *in82 = '0';

  SflRec132 = 0;
  SflRec080 = 0;

  SflNbrRcd = 0;

  ##RcdNbr = 0;
  ##Key = '';

  $$Head132 = set0001.SET_HedCol;
  $$Head080 = set0001.SET_HedCol;

  //  Aufbereiten der Überschrift
  exsr pbHeadline;

  //  Logischer Schalter für Tabellierung
  IsTblCol = bFalse;

  //  Konvertieren nicht darstellbarer Zeichen
  IsCvtChar = bFalse;

endsr;

//============================================================*
//    PBCsrTRcd     Übersetzen SflCsr ==> rel. Satznummer     *
//============================================================*

begsr pbCsrToRcd;

  if (SflCsr <= 0);
    Wrk#RcdNbr = 0;
  else;
    if (*in88 = *off);
      SflRec132 = SflCsr;
      chain SflRec132 pbsfl132;
    else;
      SflRec080 = SflCsr;
      chain SflRec080 pbsfl080;
    endif;

    if (not %found());
      Wrk#RcdNbr = 0;
    else;
      Wrk#RcdNbr = recordnbr;
    endif;
  endif;

endsr;

//============================================================*
//    InitSCmd      Initialisieren Kurzbefehl                 *
//============================================================*

begsr InitSCmd;

  clear ShortCmd;
  ShortCmd.SC_Action = '*INIT';
  ShortCmd.SC_File = ##File;
  ShortCmd.SC_Lib = ##Library;
  ShortCmd.SC_Mbr = ##Member;
  peek42(h_file: h_lib: h_mbr: h_rcdfmt
        : ShortCmd: Wrk#RcdNbr: YExecCmd
        : YMsgID: YMsgDta);

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr PBReadUp;

  if (IsOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    //  Erster Datensatz in Subfile ...
    IsFirstSfl = bTrue;

    for do_x4 = 1 to *hival;
      exsr PBRead;
      if (IsEOF = bTrue);
        *in83 = '1';
        leave;
      else;
        *in83 = '0';
      endif;

      if (*in88 = bFalse);
        SflRec132 = SflRec132 + 1;
      else;
        SflRec080 = SflRec080 + 1;
      endif;

      if (SflRec132 > 9999
          or SflRec080 > 9999);
        *in83 = '1';
        exsr PBReadP;
        leave;
      endif;

      if (SflRec132 > SflPage
          or SflRec080 > SflPage);
        exsr PBReadP;
        leave;
      endif;

      exsr pbFillDataRow_Right;

      exsr PBSflWrite;

      if (*in88 = bFalse);
        SflNbrRcd = SflRec132;
      else;
        SflNbrRcd = SflRec080;
      endif;

      //  Setzen Cursor auf gefundenen Datensatz
      if (SrchFndRcd = recordnbr);
        if (*in88 = bFalse);
          sfsanr = SflRec132;
        else;
          sfsanr = SflRec080;
        endif;
      endif;

      //  Aufbereiten Aufsetzkey bei 1. geschriebendem Datensatz
      if (IsFirstSfl = bTrue);
        exsr PBGenKey;
      endif;

      //  Tabellierpapierfarben umschalten ...
      if (set0001.SET_TblMde = bFalse);
      //         Modus ist ausgeschaltet
      else;
        if (IsTblCol = bFalse);
          IsTblCol = bTrue;
        else;
          IsTblCol = bFalse;
        endif;
      endif;

      //  ... 1. Datensatz ist fertig
      IsFirstSfl = bFalse;

    endfor;

  endif;

endsr;

//============================================================*
//    PBReadDn      1 Bildschirmseite rückwärts lesen         *
//============================================================*

begsr pbReadDown;

  if (IsOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    Wrk#ReadDn = Wrk#ReadDn + SflPage;
    Wrk#ReadDn = Wrk#ReadDn - nbrPinRcd;

    for do_x5 = 1 to Wrk#ReadDn;
      exsr PBReadP;
      if (IsEOF = bTrue);
        leave;
      endif;

    endfor;

  endif;

  Wrk#ReadDn = 0;

endsr;

//============================================================*
//    PBReadCsr     Setzen Dateizeiger auf aktuelle           *
//                  Cursor-Position  (SflCsr)                 *
//============================================================*

begsr PBReadCsr;

  if (IsOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;
    if (SflCsr = 0);
    //      Nix tun, keine Datei vorhanden
    else;

      Wrk#ReadDn = SflNbrRcd - SflCsr;
      Wrk#ReadDn = Wrk#ReadDn + 1;
      exsr PBMoveCsrD;

    endif;
  endif;

endsr;

//============================================================*
//    PBReadCsrA    Read to Cursor, after                     *
//                  Setzen Dateizeiger auf aktuelle           *
//                  Cursor-Position  +1  (SflCsr+1)           *
//============================================================*

begsr PBReadCsrA;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;
    if (SflCsr = 0);
    //      Nix tun, keine Datei vorhanden
    else;

      Wrk#ReadDn = SflNbrRcd - SflCsr;
      exsr PBMoveCsrD;

    endif;
  endif;

endsr;

//============================================================*
//    PBMoveCsrD    Verschieben Dateizeiger (Richtung BOF)    *
//============================================================*

begsr PBMoveCsrD;

  if (IsOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    for do_x6 = 1 to Wrk#ReadDn;
      exsr PBReadP;
      if (IsEOF = bTrue);
        leave;
      endif;

    endfor;

  endif;

  Wrk#ReadDn = 0;

endsr;

//============================================================*
//    PBPinCol      Füllen Subfile mit pinned Spalten         *
//============================================================*

begsr pbPinColumn;

  isPinModeC = bTrue;

  //  Eintragen der gepinnten Spalten ...
  for PinCol_X = 1 to NbrPinCol;
    if (sflRowDataStr > sfl_row_size or sflRowDataStr > sflMaxRowLen);
      leave;
    endif;

    if (sflRowDataStr > SflPinRnge);
      p_sndPgmMg('USR8148' : pinTabCol(PinCol_X): sds.pgmName);
      exsr rmvPincolumn;
      if (IsPinRmv = bTrue);
        PinCol_X = PinCol_X - 1;
      endif;
      iter;
    endif;

    //  ... einlesen der Felddaten
    clear f_key;
    f_key.F_Field = pinTabCol(PinCol_X);
    chain(n) %kds(f_key) fpeekfld;
    if (not %found());
      // Eintrag austragen
      exsr rmvPincolumn;
      if (IsPinRmv = bTrue);
        PinCol_X = PinCol_X - 1;
      endif;
      iter;
    endif;

    //  ... Feld nicht anzeigen
    if (F_Hidden = bTrue);
      iter;
    endif;

    exsr pbReadFld1;
    if (IsError = bTrue);
      leave;
    endif;

  endfor;

  isPinModeC = bFalse;

endsr;

//============================================================*
//    PBPinRcd      Füllen Subfile mit pinned Datensätzen     *
//============================================================*

begsr pbPinRcd;

  IsPinModeR = bTrue;

  if (IsOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    for PinRcd_X = 1 to max_pin_rcd;
      pinTabRcdE = PinTabRcd(PinRcd_X);
      if (pinTabRcdE.RcdNbr = 0);
        leave;
      endif;

      if (f_chain04(pinTabRcdE.RcdNbr :
                 pinTabRcdE.file   :
                 pinTabRcdE.lib    :
                 pinTabRcdE.mbr    :
                 pinTabRcdE.rcdFmt ) = '1');
        //           Eintrag austragen
        exsr RmvPinRcd;
        if (IsPinRmv = bTrue);
          PinRcd_X = PinRcd_X - 1;
        endif;
        iter;
      endif;

      exsr pbFillDataRow_Right;

      SflRec132 = SflRec132 + 1;
      SflRec080 = SflRec080 + 1;

      exsr PBSflWrite;

      if (*in88 = bFalse);
        SflNbrRcd = SflRec132;
      else;
        SflNbrRcd = SflRec080;
      endif;

    endfor;

  endif;

  IsPinModeR = bFalse;

endsr;

//============================================================*
//    ChkPinRcd     Prüfen, ob Datensatz gepinned ist         *
//============================================================*

begsr ChkPinRcd;

  PinRcd_X = 1;
  pinTabRcdE.RcdNbr = Wrk#RcdNbr;
  pinTabRcdE.file = h_file;
  pinTabRcdE.lib = h_lib;
  pinTabRcdE.mbr = h_mbr;
  pinTabRcdE.rcdFmt = h_rcdfmt;
  pinTabRcdE.mbrNbr = h_mbrnbr;
  PinRcd_X = %lookup(
           pinTabRcdE: PinTabRcd: PinRcd_X);
  if (PinRcd_X > 0);
    IsPinned = bTrue;
  else;
    IsPinned = bFalse;
  endif;

endsr;

//============================================================*
//    ChkPinCol     Prüfen, ob Spalte gepinned ist            *
//============================================================*

begsr ChkPinCol;

  PinCol_X = 1;
  PinCol_X = %lookup(
           Pin#Field: pinTabCol: PinCol_X);
  if (PinCol_X > 0);
    IsPinned = bTrue;
  else;
    IsPinned = bFalse;
  endif;

endsr;

//============================================================*
//    RmvPinRcd     Austragen Datensatz aus PinTabR           *
//============================================================*

begsr RmvPinRcd;

  IsPinRmv = bFalse;

  //  Remove pinned record from table
  for y = PinRcd_X to max_pin_rcd;
    z = y + 1;
    clear pinTabRcdE;
    if (z <= max_pin_rcd);
      PinTabRcd(y) = PinTabRcd(z);
      PinTabRcd(z) = pinTabRcdE;
    else;
      PinTabRcd(y) = pinTabRcdE;
    endif;
    isSflDirty = bTrue;
    IsPinRmv = bTrue;
  endfor;

  //  Detrmine number of pinned records
  //  (find first free record)
  x = 1;
  clear pinTabRcdE;
  x = %lookup(pinTabRcdE: PinTabRcd: x);
  if (x > 0);
    nbrPinRcd = x - 1;
  else;
    nbrPinRcd = max_pin_rcd;
  endif;

endsr;

//============================================================*
//    RmvPinCol     Austragen Feld aus PinTabC                *
//============================================================*

begsr rmvPincolumn;

  IsPinRmv = bFalse;

  for y = PinCol_X to max_pin_col;
    z = y + 1;
    if (z <= max_pin_col);
      pinTabCol(y) = pinTabCol(z);
      pinTabCol(z) = *blanks;
    else;
      pinTabCol(y) = *blanks;
    endif;
    isSflDirty = bTrue;
    IsPinRmv = bTrue;
  endfor;

  x = 1;
  Pin#Field = *blanks;
  x = %lookup(Pin#Field: pinTabCol: x);
  if (x > 0);
    NbrPinCol = x - 1;
  else;
    NbrPinCol = max_pin_col;
  endif;

endsr;

//============================================================*
//    PBRefresh     Aktualisieren der Subfile                 *
//============================================================*

begsr PBRefresh;

  Wrk#ReadDn = SflNbrRcd - SflPage;
  exsr pbReadDown;
  exsr PBInit;
  exsr pbPinRcd;
  exsr PBReadUp;

  //  Evtl. ist die Subfile doch nicht leer ...
  //  (letzter Satz in der Liste wurde gelöscht oder
  //   der Schlüssel wurde geändert)
  if (*in80 = *off);
    exsr C_Bot;
  endif;

endsr;

//============================================================*
//    PBHeadLine    Aufbereiten der Überschriftenzeile        *
//                  und füllen Tabelle mit anzuzeigenden      *
//                  Feldern                                   *
//============================================================*

begsr pbHeadline;

  //  Löschen der Überschrift
  $$Head132 = '';
  $$Head080 = '';

  if (not %open(peekfldl1));
    //  Keine Datei geöffnet
    leavesr;
  endif;

  //  Löschen Tabelle mit Feldpositionen ...
  exsr clrFldPosArray;

  //  Aufbereiten Pseudo-Datensatz
  peek20('*PHIVAL': IO_Buff: YMsgID: YMsgDta);

  if (YMsgID = '');

    //  Füllen der Überschriftenzeile ...
    SflMode = '*HEADLINE';
    Wrk#SeqNbr = ##WndNbr;
    exsr pbFillHeadline_Right;

    //  Übertragen der Überschriftenzeile
    //  in Bildschirmfeld ...
    $$Head132 = sflDataRow;
    $$Head080 = sflDataRow;
  endif;

endsr;

//============================================================*
//    PBFillLeft    Füllen einer Datenzeile von rechts        *
//                  nach links.                               *
//============================================================*

begsr pbFillDataRow_Left;

  if (IsOpen = bFalse);
  //  Keine Datei geöffnet
  else;

    //  Löschen Tabelle mit Feldpositionen ...
    exsr clrFldPosArray;

    //  Aufbereiten Pseudo-Datensatz
    peek20('*PHIVAL': IO_Buff: YMsgID: YMsgDta);

    if (YMsgID = '');

      //  Füllen der Überschriftenzeile ...
      SflMode = '*HEADLINE';
      Wrk#SeqNbr = ##WndNbr;
      exsr pbFillHeadline_Left;
    endif;
  endif;

endsr;

//============================================================*
//    PBFillRigh    Füllen einer Datenzeile von rechts        *
//                  nach links.                               *
//============================================================*

begsr pbFillDataRow_Right;

  f_basedPF(File#X.file   :
           File#X.library:
           File#X.member :
           File#X.rcdFmt :
           File#X.mbrNbr :
           h_file        :
           h_lib         :
           h_mbr         :
           h_rcdfmt      );

  sfpau = *blanks;
  h_mbrnbr = File#X.mbrNbr;
  recordnbr = File#X.RcdNbr;

  //  Prüfen auf Suchfunktion:
  //  *NORMAL/*REVERSE
  IsFound = bFalse;

  if (SrchField <> *blanks);
    if (SrchType = '*REVERSE' or SrchType = '*UNDERLINE');
      exsr srchFldAtr;
      exsr srchCompare;
    endif;
  endif;

  //  Füllen der Datenzeile ...
  SflMode = '*DATA';
  Wrk#SeqNbr = ##WndNbr;
  exsr pbFillHeadline_Right;

  //  Übertragen der Datenzeile in
  //  Bildschirmfeld ...
  Data132 = sflDataRow;
  Data080 = sflDataRow;

  //  ... anzeigen der Subfile
  *in80 = '1';

  //  ... Subfile-Satz nicht auswählen
  *in84 = '0';
  *in85 = '0';

endsr;

//============================================================*
//    PBFill_R      Lesen der anzuzeigenden Felder und        *
//                  aufbereiten der Überschrift oder der      *
//                  Datenzeile, von links nach rechts         *
//============================================================*

begsr pbFillHeadline_Right;

  //  Löschen Datentabelle ...
  clear sflDataRow;
  sflRowDataStr = 1;

  //  Eintragen gepinnter Spalten ...
  exsr pbPinColumn;

  //  Eintragen der Feldinhalte ...
  clear f1key_l1;
  f1key_l1.F_Seq = Wrk#SeqNbr;
  setll %kds(f1key_l1) fpeekfldl1;

  dow (sflRowDataStr <= sfl_row_size and sflRowDataStr <= sflMaxRowLen);
    read fpeekfldl1;
    if (%eof());
      leave;
    endif;

    //  ... Feld anzeigen?
    Wrk#Field = F_Field;
    exsr chkVisible;
    if (isVisible = bFalse);
      iter;
    endif;

    exsr pbReadFld1;
    if (IsError = bTrue);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PBFill_L      Lesen der anzuzeigenden Felder und        *
//                  aufbereiten der Überschrift oder der      *
//                  Datenzeile, von rechts nach links         *
//============================================================*

begsr pbFillHeadline_Left;

  //  Löschen Datentabelle ...
  clear sflDataRow;
  sflRowDataStr = 1;

  //  Eintragen gepinnter Spalten ...
  exsr pbPinColumn;

  //  Eintragen der Feldinhalte ...
  clear f1key_l1;
  f1key_l1.F_Seq = Wrk#SeqNbr;
  setgt %kds(f1key_l1) fpeekfldl1;

  dow (sflRowDataStr <= sfl_row_size and
     sflRowDataStr <= sflMaxRowLen);
    readp fpeekfldl1;
    if (%eof());
      leave;
    endif;

    //  ... Feld anzeigen?
    Wrk#Field = F_Field;
    exsr chkVisible;
    if (isVisible = bFalse);
      iter;
    endif;

    exsr pbReadFld1;
    if (IsError = bTrue);
      leave;
    endif;

    if (##StrPage > 1);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PBReadFld1    Hilfsroutine für PBReadFld                *
//============================================================*

begsr pbReadFld1;

  //  umsetzen der Daten in die Job CCSID
  if (SflMode = '*HEADLINE');
    YCvtCcsid = bFalse;
  else;
    YCvtCcsid = bTrue;
  endif;

  //  löschen Ausnahmebedingung für Spalte
  isColumnException = bFalse;

  //  merken Position für Farbattribut
  if (sflRowDataStr <= sfl_row_size);
    ColrOfs = sflRowDataStr;
    sflRowDataStr = sflRowDataStr + 1;
  else;
    ColrOfs = 0;
  endif;

  //  aufbereiten des Feldinhaltes
  //  für Anzeigeformat gemäß EDITCODE ...
  fldl0100 = f_ffd;
  if (F_EdtCde <> *blanks);
    fldl0100.f1edtc = F_EdtCde;
  else;
  //  ... Original EDITCODE verwenden
  endif;

  monitor;
    //  umsetzen Datensatzpuffer in Bildschirmdarstellung ...
    if (set0001.SET_DspMde = '*DSPNRM');
      //  ... für Normale Anzeige
      if (IO_NullMap(fldl0100.f1seq) = 1);
        peek06(fldl0100: 'FLDL0100': *allx'00'
              : bFalse: YCvtCcsid
              : YOutBuffer: YOutBuffLn
              : YMsgID: YMsgDta);
        if (f_isNumFld(fldl0100) = bTrue);
          if (YOutBuffLn > 1);
            %subst(YOutBuffer: 1: YOutBuffLn - 1) = '';
          endif;
          %subst(YOutBuffer
                : YOutBuffLn
                : %len(HEX_CHAR)) = HEX_CHAR;
        else;
          YOutBuffer = HEX_CHAR;
        endif;
      else;
        peek06(fldl0100: 'FLDL0100': IO_Buff
              : bFalse: YCvtCcsid
              : YOutBuffer: YOutBuffLn
              : YMsgID: YMsgDta);
      endif;

    else;
      //  ... für Hex-Anzeige
      if (IO_NullMap(fldl0100.f1seq) = 1);
        YHexString = HEX_CHAR;
        YStringLen = f_buffLn(fldl0100);
      else;
        YStringLen = f_rtvFld(YString  :
                             IO_Buff  :
                             fldl0100 );
        YHexString = ' ';
        p_hexToChr(YHexString    :
                  YString       :
                  YStringLen * 2);
      endif;

      YOutBuffLn = YStringLen * 2;
    endif;
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  //  Fehler bei der Aufbereitung ...
  if (*in99 = *on);
    //  ... ja
    IsError = bTrue;
  else;
    //  ... nein
    IsError = bFalse;

    //  ermitteln der Spaltenbreite
    //  anhand der Überschrift und
    //  der Feldlänge, sowie der
    //  maximalen Spaltenbreite ...
    fldl0100 = f_ffd;
    ColumnLen = 0;
    FieldLen = YOutBuffLn;
    MaxColLen = F_MaxSize;

    //  Konvertierung nicht darstellbarer Zeichen ...
    if (SflMode = '*HEADLINE' or set0001.SET_DspMde = '*DSPHEX');
    //  ... keine Konvertierung bei der
    //      Aufbereitung der Überschriftenzeile
    else;
      //  ... sonst konvertieren
      monitor;
        peek32(YOutBuffer: YOutBuffLn: 0
              : YMsgID: YMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

      if (*in99 = *off);
        if (IsCvtChar = bFalse);
          if (YMsgID <> *blanks);
            IsCvtChar = bTrue;
            p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
            YMsgID = '';
            YMsgDta = '';
          else;
          //         keine Nachricht anstehend
          endif;
        else;
        //         Nachricht bereits gesendet
        endif;
      else;
      //         Fehler bei Programmaufruf
      endif;
    endif;

    //  Bestimmen Länge der Überschrift
    //  und aufbereiten Überschrift ...
    colHeading = f_headline(set0001.SET_HedTyp: fldl0100);
    HeadLen = %checkr(' ': colHeading);

    if (SflMode = '*HEADLINE');
      YHexString = colHeading;
    endif;

    colHeading = '';

    //  ... Bestimmen der Spaltenbreite
    if (HeadLen > FieldLen);
      ColumnLen = HeadLen;
    else;
      ColumnLen = FieldLen;
    endif;

    if (ColumnLen > MaxColLen);
      ColumnLen = MaxColLen;
    endif;

    //  ... numerische Werte rechtsbündig setzen,
    //      wenn Spaltenbereite kleiner als Feldlänge
    if (SflMode   = '*HEADLINE');

      //      ... für die Überschrift
      if ((ColumnLen < HeadLen ) or
          (ColumnLen < FieldLen));

        select;
        when ((HeadLen + 3) <= ColumnLen);
          %subst(YHexString: HeadLen + 1: 3)
          = %subst('...': 1: 3);
        other;
          %subst(YHexString: ColumnLen - 2 + 1: 2)
          = %subst('...': 1: 2);
        endsl;

      endif;

    else;

      //      ... für die Datenzeile
      if ((SflMode   <> '*HEADLINE') and
          (ColumnLen <  FieldLen   ));
        if (f_isNumFld(fldl0100) = bTrue);
          //          ... numerische Werte
          if ((set0001.SET_EnExc = bTrue) and
              (%subst(YHexString          :
                   1                   :
                   FieldLen - ColumnLen) <> *blanks));
            isColumnException = bTrue;
          endif;
          YHexString = %subst(YHexString              :
                             1 + FieldLen - ColumnLen:
                             ColumnLen               );
        else;
          //          ... alphanumerische Werte
          if ((set0001.SET_EnExc = bTrue) and
              (%subst(YHexString              :
                   ColumnLen + 1           :
                   1 + FieldLen - ColumnLen) <> *blanks));
            isColumnException = bTrue;
          endif;
        endif;

      endif;
    endif;

    //  ... Berechnen der Startposition im Puffer
    SflDataLenFree =
     sflMaxRowLen - sflRowDataStr + 1;

    if (##WndNbr = F_Seq);

      if ((##StrPage * SflDataLenFree) > ColumnLen);

        if ((ColumnLen / SflDataLenFree) =
            f_int(ColumnLen / SflDataLenFree));
          ##StrPage = (ColumnLen / SflDataLenFree);
        else;
          ##StrPage = (ColumnLen / SflDataLenFree) + 1;
        endif;

      endif;

      FldStrPos = (##StrPage -1) * SflDataLenFree
                 + 1;
    else;
      FldStrPos = 1;
    endif;

    //  ... Berechnen der zu extrahierenden Länge
    BuffIdx = FldStrPos;
    sflRowDataEnd = sflRowDataStr + ColumnLen;
    sflRowDataEnd = sflRowDataEnd - FldStrPos;

    if (sflRowDataEnd > sfl_row_size);
      sflRowDataEnd = sfl_row_size;
    endif;

    sflRowDataLen =
     sflRowDataEnd - sflRowDataStr + 1;

    //  ... übertragen aufbereitetes Feld in Subfile
    %subst(sflDataRow: sflRowDataStr) =
    %subst(YHexString: BuffIdx: sflRowDataLen);

    //  ... pflegen der Tabelle mit den Werten der
    //      Spaltenaufteilung ...
    if (sflRowDataEnd >= sflRowDataStr);
      //      ... pflegen der Feldpositionstabelle
      if (SflMode = '*HEADLINE');
        cp = cp + 1;
        Col_Field(cp) = fldl0100.f1fnme;
        Col_ScnStr(cp) = sflRowDataStr;
        Col_ScnEnd(cp) = sflRowDataEnd;
        //          ... ist das Feld komplett sichtbar?
        if (Col_ScnEnd(cp) <= sflMaxRowLen);
          //              ... ja, kein Fehler
          Col_Error(cp) = bFalse;
        else;
          //              ... nein, Fehler!
          Col_Error(cp) = bTrue;
        endif;
      endif;

      sflRowDataStr = sflRowDataEnd + 1;

      //      ... Löschen von "überstehendem" Datenmüll
      if (ColumnLen = MaxColLen and
         sflRowDataStr <= sfl_row_size);
        sflDataRow.chars(sflRowDataStr) = '';
      endif;

      //      ... umschalten auf "normale" Farbdarstellung
      if (sflRowDataStr <= sfl_row_size);
        Wrk#Ofs = sflRowDataStr;
        exsr PBStdCol;
      endif;

      //      ... "nachziehen" der Spaltenfarbe
      if (ColrOfs <= 0);
      //          ... Pech gehabt
      else;
        if (SflMode = '*HEADLINE');
          if ((F_KSeq = 0) or
              (AccessMode = RRN_SEQ));
            sflDataRow.chars(ColrOfs) = set0001.SET_HedCol;
          else;
            sflDataRow.chars(ColrOfs) = set0001.SET_KeyCol;
          endif;
        else;
          exsr PBColor;
        endif;
      endif;
    endif;

  endif;

endsr;

//============================================================*
//    PBStdCol      Setzen der "normalen" Datensatzfarbe      *
//============================================================*

begsr PBStdCol;

  if (IsTblCol = bFalse);
    sflDataRow.chars(Wrk#Ofs) = set0001.SET_StdCol;
  else;
    sflDataRow.chars(Wrk#Ofs) = set0001.SET_TblCol;
  endif;

endsr;

//============================================================*
//    PBGenKey      Generieren Aufsetzkey                     *
//                  für die Anzeige auf dem Bildschirm        *
//============================================================*

begsr PBGenKey;

  if (AccessMode = KEY_SEQ);
    exsr PBBuildKey;
  else;
    exsr PBBuildRrn;
  endif;

endsr;

//============================================================*
//    PBBuildRrn    Generieren Aufsetzkey: RRN                *
//============================================================*

begsr PBBuildRrn;

  ##RcdNbr = recordnbr;

endsr;

//============================================================*
//    PBBuildKey    Generieren Aufsetzkey                     *
//============================================================*

begsr PBBuildKey;

  monitor;
    peek19(IO_Buff: YKeyVal: YMsgID: YMsgDta);

    //  ... Konvertieren nicht darstellbarer Zeichen
    YOutBuffer = YKeyVal;
    YOutBuffLn = 132;

    peek32(YOutBuffer: YOutBuffLn: 0
          : YMsgID: YMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  ##Key = YOutBuffer;

endsr;

//============================================================*
//    PBGenIntKy    Generieren internen Aufsetzkey            *
//                  für einen Dateizugriff                    *
//============================================================*

begsr PBGenIntKy;

  if (AccessMode = KEY_SEQ);
    exsr PBIntKey;
  else;
    exsr PBIntRrn;
  endif;

endsr;

//============================================================*
//    PBIntRrn      Generieren interne Satznummer             *
//============================================================*

begsr PBIntRrn;

  Wrk#RcdNbr = Wrk#RcdNbr;

endsr;

//============================================================*
//    PBIntKey      Generieren internen Aufsetzschlüssel      *
//============================================================*

begsr PBIntKey;

  peek20(Wrk#KeyVal: YBuffer
        : YMsgID: YMsgDta);
  Wrk#KeyVal = YBuffer;

endsr;

//============================================================*
//    PBColor       Setzen der Spaltenfarbe                   *
//                  für Datenzeilen                           *
//                  a) für gepinnte Datensätze                *
//                  b) für normale Datensätze                 *
//============================================================*

begsr PBColor;

  if (ColrOfs = 0);
  //                 Nix tun
  else;

    if (isColumnException = bTrue);
      sflDataRow.chars(ColrOfs) = set0001.SET_ExcCol;
    else;

      //---------------------------------------*
      //  Berücksichtigen des Aufrufs von:     *
      //  a) anzeigen "normaler" Datensätze    *
      //  b) anzeigen "gepinnter" Datensätze   *
      //---------------------------------------*
      if (IsPinModeR = bFalse);
        if (isPinModeC = bFalse);
          //      ... nix ist gepinnt
          IsPinned = bFalse;
        else;
          //      ... prüfen auf gepinnte Spalten
          Pin#Field = fldl0100.f1fnme;
          exsr ChkPinCol;
        endif;
      else;
        //      ... prüfen auf gepinnte Zeilen (=Datensätze)
        Wrk#RcdNbr = recordnbr;
        exsr ChkPinRcd;
      endif;

      //---------------------------------------*
      //  ... setzen der Datenfarbe            *
      //---------------------------------------*
      //  Spaltenmarkierung ...
      if (F_MarkCol = bTrue);
        sflDataRow.chars(ColrOfs) = F_Color;
      else;
        //  Keine Spaltenmarkierung ...
        if (IsPinned = bTrue);
          //      ... pinned Datensatz
          sflDataRow.chars(ColrOfs) = set0001.SET_PinCol;
        else;
          //      ... normaler Datensatz
          Wrk#Ofs = ColrOfs;
          exsr PBStdCol;
        endif;
      endif;

      //---------------------------------------*
      //  ... Datensatz gefunden               *
      //---------------------------------------*
      if (IsPinned = bFalse);
        select;
        //      ... Suchfunktionen: *REVERSE
        when (SrchType = '*REVERSE');
          if (IsFound = bTrue);
            sflDataRow.chars(ColrOfs) = set0001.SET_RevCol;
          endif;

        //      ... Suchfunktionen: *UNDERLINE
        when (SrchType = '*UNDERLINE');
          if (IsFound = bTrue);
            sflDataRow.chars(ColrOfs) = set0001.SET_UndCol;
          endif;

        //      ... Suchfunktionen: *NORMAL
        when (SrchType = '*NORMAL');
          if (SrchFndRcd = recordnbr);
            sflDataRow.chars(ColrOfs) = set0001.SET_NmlCol;
          endif;

        other;
        //       Andere Suchtypen gibt's nicht
        endsl;
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger RRN/KEY                *
//============================================================*

begsr PBSetLL;

  if (IsOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    select;
    when (AccessMode = KEY_SEQ);
      CIO_setllWithKey(hFile02: Wrk#KeyVal);
      exsr F2toFx;
    when (AccessMode = RRN_SEQ);
      CIO_setllWithRRN(hFile01: Wrk#RcdNbr);
      exsr F1toFx;
    when (AccessMode = SQL_SEQ);
    other;
    endsl;

  endif;

endsr;

//============================================================*
//    PBSetGT       Setzen Dateizeiger RRN/KEY                *
//============================================================*

begsr PBSetGT;

  if (IsOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    select;
    when (AccessMode = KEY_SEQ);
      CIO_setgtWithKey(hFile02: Wrk#KeyVal);
      exsr F2toFx;
    when (AccessMode = RRN_SEQ);
      CIO_setgtWithRRN(hFile01: Wrk#RcdNbr);
      exsr F1toFx;
    when (AccessMode = SQL_SEQ);
    other;
    endsl;

  endif;

endsr;

//============================================================*
//    PBMoveTop     Setzen Dateizeiger auf BOF                *
//============================================================*

begsr PBMoveTop;

  if (IsOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    if (AccessMode = SQL_SEQ);
      SQL_gotoTop(YMsgID: YMsgDta);
      if (YMsgID <> '');
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
      endif;
    else;
      Wrk#KeyVal = '*LOVAL';
      Wrk#RcdNbr = LOW_RCD_NBR;

      exsr PBGenIntKy;
      exsr PBSetLL;
    endif;

  endif;

endsr;

//============================================================*
//    PBMoveBot     Setzen Dateizeiger auf EOF                *
//============================================================*

begsr PBMoveBot;

  if (IsOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    if (AccessMode = SQL_SEQ);
      SQL_gotoBottom(YMsgID: YMsgDta);
      if (YMsgID <> '');
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
      endif;
    else;
      Wrk#KeyVal = '*HIVAL';
      Wrk#RcdNbr = HIGH_RCD_NBR;

      exsr PBGenIntKy;
      exsr PBSetGT;
      exsr PBReadP;
    endif;

  endif;

endsr;

//============================================================*
//    clrFldArray   Löschen Felder Array                      *
//============================================================*

begsr clrFldPosArray;

  Col_Field(*) = '';
  Col_ScnStr(*) = 0;
  Col_ScnEnd(*) = 0;
  Col_Error(*) = bFalse;
  cp = 0;

endsr;

//============================================================*
//    ChangeFile    Prüfen, ob die Datei gewechselt hat       *
//============================================================*

begsr changeFile;

  IsFileChg = bFalse;

  if (L#File <> ##File
      or L#Library <> ##Library
      or L#Member <> ##Member
      or L#Format <> ##Format);

    IsFileChg = bTrue;
    //  ... Änderungen prüfen
    if (##Member = L#Member);
      ##Member = *blanks;
    endif;

    if (##Format = L#Format);
      ##Format = *blanks;
    endif;

    exsr CloseFile;

    if (##File <> *blanks);
      AccessMode = newAccessMode;
      exsr OpenFile;
    endif;
  endif;

  exsr GetOpnFile;
  exsr GetMaxSeq;

endsr;

//============================================================*
//    ChangeWnd     Prüfen, ob Fenster gewechselt hat         *
//============================================================*

begsr ChangeWnd;

  if (IsOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr MsgNoFile;
  else;

    if (##Field <> *blanks);
      Wrk#Field = ##Field;
      exsr GetSeqNbr;
      if (isSeqNbrOK = bTrue);
        ##WndNbr = Wrk#SeqNbr;
        ##StrPage = 1;
      else;
        //  Fehlermeldung ...
        clear usr8108;
        usr8108.var1 = ##Field;
        usr8108.var2 = ##File;
        usr8108.var3 = ##Library;
        p_sndPgmMg('USR8108': usr8108: sds.pgmName);
      endif;

      ##Field = *blanks;
    endif;

  endif;

endsr;

//============================================================*
//    ChangeKey     Prüfen, ob der Aufsetzkey gewechselt hat  *
//                  Auslösen über *IN93                       *
//============================================================*

begsr ChangeKey;

  if (##RcdNbr <> R#RcdNbr
      or ##Key <> R#KeyVal);
    IsKeyChg = bTrue;
  else;
    IsKeyChg = bFalse;
  endif;

  select;
  when (##RcdNbr < LOW_RCD_NBR);
    ##RcdNbr = LOW_RCD_NBR;
  when (##RcdNbr > HIGH_RCD_NBR);
    ##RcdNbr = HIGH_RCD_NBR;
  other;
  //    Im gültigen Bereich ...
  endsl;

endsr;

//============================================================*
//    ChangeSort    Wechseln der Sortierfolge                 *
//============================================================*

begsr ChangeSort;

  L#File = *blanks;
  L#Library = *blanks;
  L#Member = *blanks;
  L#Format = *blanks;

  //  Merken der letzten Cursorposition
  select;
  //    ... außerhalb der Subfile
  when (SflCsr <= *zeros);
    //        ... wird später anhand der
    //            Cursorposition auf dem Bildschirm entschieden
    SflCsr = *zeros;

  //    ... innerhalb der Subfile
  when (SflCsr > nbrPinRcd);
  //        ... wird genau dort positioniert

  //    ... innerhalb der gepinnten Datensätze
  other;
    //        ... auf 1. angezeigten Datensatz positionieren
    SflCsr = 1 + nbrPinRcd;
  endsl;

  //  Umsetzen Cursorposition in Satznummer
  exsr pbCsrToRcd;
  if (Wrk#RcdNbr > *zeros);
    //**  File#04.Open  ANDEQ     '1'
    Last#RcdNr = Wrk#RcdNbr;
  else;
    Last#RcdNr = *zeros;
  endif;

  //  Wechsel der Datei ...
  isPinToClr = bFalse;
  exsr changeFile;
  isPinToClr = bTrue;

  //  Prüfen Seq-Bereich (##WndNbr) ...
  exsr ChkSeqRnge;

  //  Wechsel des Fenster (##Field) ...
  exsr ChangeWnd;

  clear ##RcdNbr;
  clear ##Key;
  clear R#RcdNbr;
  clear R#KeyVal;

  YMsgID = *blanks;
  YMsgDta = *blanks;

  if (Last#RcdNr = *zeros);
  //    Alter Datensatz ist nicht bekannt ...
  else;
    //    ... Einlesen letzten Datensatz
    recordnbr = Last#RcdNr;

    if (f_chain04(recordnbr:
               h_file   :
               h_lib    :
               h_mbr    :
               h_rcdfmt ) = '1');
    //    ... Zugriff fehlgeschlagen
    else;
      //    ... Generieren Aufsetzkey
      exsr PBGenKey;
    endif;
  endif;

  //  Wechsel des Aufsetzkeys ...
  exsr ChangeKey;

  //  Füllen der Subfile ...
  if (IsKeyChg = bFalse);
    if (cursorPosition.row > SflLastRw);
      //    ... unterhalb der Subfile
      exsr C_Bot;
    else;
      //    ... oberhalb der Subfile,
      //        bzw. kein Wechsel des Aufsetzkeys
      exsr C_Top;
    endif;
  else;
    //    ... neuer Aufsetzkey innerhalb der Subfile
    exsr KeyHasChg;
  endif;

endsr;

//============================================================*
//    OpenFile      Datei öffnen                              *
//============================================================*

begsr OpenFile;

  //  Wenn eine Datei bereits geöffnet ist ...
  if (IsOpen = bTrue);
    //  ... dann geöffnet lassen
    leavesr;
  endif;

  yCursorPosition.row = 0;
  yCursorPosition.column = 0;

  exsr ChkPrvFile;

  //  ... erst die Plausi prüfen, dann ...
  if (##Library = *blanks);
    ##Library = '*LIBL';
  endif;

  if (##Member = *blanks);
    ##Member = '*FIRST';
  endif;

  //  ... Objektbeschreibung
  //      ... abrufen der Objektattribute (auflösen *LIBL, *CURLIB)
  exsr GetObjAttr;
  if (IsError = bTrue);
    //  Fehler aufgetreten, Öffnen abbrechen.
    exsr MsgNoFile;
    leavesr;
  endif;

  //  ... Teildateien
  if (##Member = '*NONE');
    $$nomb = 0;
  else;
    //      ... abrufen der Anzahl Teildateien
    exsr GetNbrMbr;
    if ($$nomb = 0);
      //  Keine Teildateien vorhanden.
      ##Member = '*NONE';
    endif;
  endif;

  //      ... prüfen auf phys. Datei bei Zugriff über SQL
  //** %SQL%          IF        (AccessMode = SQL_SEQ and ATFILA <> '*PHY')
  //**                Exsr      MsgInvSqlFile
  //**                Leavesr
  //**                ENDIF

  //      ... prüfen Name der Teildatei
  exsr CheckMbrName;
  if (IsError = bTrue);
    //  Fehler aufgetreten, Öffnen abbrechen.
    exsr MsgNoFile;
    leavesr;
  endif;

  //  ... Satzformate
  //      ... abrufen der Satzformate
  exsr GetFmtList;
  if (YMsgID <> '');
    //  Satzformate konnten nicht abgerufen werden (USR0002),
    //  Öffnen abbrechen.
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    exsr MsgNoFile;
    leavesr;
  endif;
  //      ... auswählen Satzformat
  exsr GetRcdFrmt;

  //  ... prüfen auf Schlüsselfelder
  //      und initialisieren von PEEK41 (= Dateiinformationen)
  exsr GetNbrKeyF;
  //      ... wenn keine Schlüsselinformationen
  //          vorhanden sind, ...
  if (IsKeyAvail = bFalse
      and AccessMode = KEY_SEQ);
    //          ... dann über RRN zugreifen
    AccessMode = RRN_SEQ;
  else;
  //          ... sonst Modus beibehalten
  endif;

  //  Ermitteln Sortierung bei Zugriff über SQL ...
  if (AccessMode = SQL_SEQ);
    if (sqlOrder = '*KEY');
      peek38(##File: ##Library: sqlOrder);
    else;
      sqlOrder = SQL_quote(f_ucase(sqlOrder));
    endif;
  endif;

  // -------------------------------------------------
  //  Prüfen Zugriffsrechte
  // -------------------------------------------------

  //      ... prüfen Zugriffsrechte
  exsr s_EXIT01;

  //      ... Zugriff nicht erlaubt
  if (auth.isAccessAlw <> bTrue);
    exsr CloseFile;
    p_rmvPgmMg(sds.pgmName);
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    leavesr;
  endif;

  // -------------------------------------------------
  //  Datei öffnen für Einzelzugriff (Aktualisierung)
  // -------------------------------------------------

  if (##Member = '*NONE');
    clear hFile00;
    File#X.IsOpen = bFalse;
    File#X.file = ##File;
    File#X.library = ##Library;
    File#X.RcdLen = 0;
    File#X.member = ##Member;
    File#X.rcdFmt = ##Format;
    File#X.mbrNbr = 0;
    File#X.RcdNbr = 0;
    IsOpen = bFalse;
  else;

    f_execute('OVRDBF ' +
               'FILE(' + %trim(##File) + ') ' +
               'TOFILE(' +
                 %trim(##Library) + '/' +
                 %trim(##File) + ') ' +
               'MBR(' + %trim(##Member) + ') ' +
               'OVRSCOPE(*ACTGRPDFN) ' +
               'SHARE(*NO) ' +
               'SEQONLY(*NO) SECURE(*YES)'
             : YMsgID: YMsgDta);
    YMsgID = '';
    YMsgDta = '';

    //      ... Änderungen erlaubt
    if (auth.isUpdAlw = bTrue);
      commitLvl = '1';
      //          ... mit Commit-Steuerung
      if CIO_open(hFile00
               : ##File
               : ##Library
               : ##Member
               : ##Format
               : 'rr+, arrseq=Y, commit=Y, +
                  nullcap=Y, riofb=Y, +
                  secure=N, ccsid=65535') = bTrue;
        exsr F0toFx;
        isUpdMod = bTrue;
      else;
        //          ... ohne Commit-Steuerung
        commitLvl = '0';
        if CIO_open(hFile00
                 : ##File
                 : ##Library
                 : ##Member
                 : ##Format
                 : 'rr+ , arrseq=Y, commit=N +
                    nullcap=Y, riofb=Y, +
                    secure=N, ccsid=65535') = bTrue;

          exsr F0toFx;
          isUpdMod = bTrue;
        else;
          //              ... Datei für Einzelsatzzugriff konnte nicht geöffnet werden.
          //                  evtl. handelt es sich um eine JOIN-Datei oder aber
          //                  es könnte auch Referenzielle Integrität definiert sein und
          //                  die läßt sich ohne Journalisierungn nicht anwenden!
          isUpdMod = bFalse;
          *in99 = '0';
        endif;
      endif;
    else;
      //      ... keine Änderungen erlaubt
      isUpdMod = bFalse;
      *in99 = '0';
    endif;

    if ((isUpdMod = bTrue) and (auth.isUpdKeyAlw = bTrue));
      isUpdKey = bTrue;
    else;
      isUpdKey = bFalse;
    endif;

    // -------------------------------------------------
    //  Datei öffnen für Sortierfolge
    // -------------------------------------------------

    //  Sortierung 2 nach Schlüsselfelder
    if (AccessMode = KEY_SEQ);
      if CIO_open(hFile02
               : ##File
               : ##Library
               : ##Member
               : ##Format
               : 'rr, arrseq=N, commit=N, +
                  nullcap=Y, riofb=Y, +
                  secure=N, ccsid=65535') = bTrue;
        *in99 = *off;
      else;
        *in99 = *on;
        CIO_getErrorMsg(hFile02: YMsgID: YMsgDta);
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
      endif;
      exsr F2toFx;
    endif;

    //  Sortierung 1 nach Satzfolge
    if (AccessMode = RRN_SEQ);
      if CIO_open(hFile01
               : ##File
               : ##Library
               : ##Member
               : ##Format
               : 'rr, arrseq=Y, commit=N, +
                  nullcap=Y, riofb=Y, +
                  secure=N, ccsid=65535') = bTrue;
        *in99 = *off;
      else;
        *in99 = *on;
        CIO_getErrorMsg(hFile01: YMsgID: YMsgDta);
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
      endif;
      exsr F1toFx;
    endif;

    //  Sortierung 3 nach Sql
    if (AccessMode = SQL_SEQ);
      clear usr0013;
      p_sndStsMg('USR0013': usr0013);
      if (SQL_prepareStatement(
                  '0'       :
                  ##File    :
                  ##Library :
                  ##Member  :
                  ##Format  :
                  sqlWhere  :
                  sqlOrder  :
                YMsgID      :
                YMsgDta     ) = bTrue);
        if (SQL_open(hFile03     :
                  YMsgID      :
                  YMsgDta     ) = bTrue);
          *in99 = *off;
          YMsgID = '';
          YMsgDta = '';
        else;
          *in99 = *on;
          CIO_getErrorMsg(hFile03: YMsgID: YMsgDta);
          p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
          YMsgID = '';
          YMsgDta = '';
        endif;
        exsr F3toFx;
      else;
        *in99 = *on;
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
      endif;
    endif;

    f_execute('DLTOVR ' +
               'FILE(' + %trim(##File) + ') ' +
               'LVL(*ACTGRPDFN) '
             : YMsgID: YMsgDta);
    YMsgID = '';
    YMsgDta = '';

    if (*in99 = *on);
      leavesr;
    endif;
    //      Datei geöffnet ...
    //      ... OPEN-Flag
    IsOpen = bTrue;

  endif;

  //      ... aber Satzlänge größer 32766
  if (File#X.RcdLen > RCD_BUFF_LEN);
    exsr CloseFile;
    p_rmvPgmMg(sds.pgmName);
    clear usr8207;
    usr8207.var1 = RCD_BUFF_LEN;
    p_sndPgmMg('USR8207': usr8207: sds.pgmName);
  else;

    // ... löschen Pin-Funktion
    exsr ClrPinCol;
    exsr ClrPinRow;
    // ... auswerten Rückkehrcode
    if (YMsgID = 'USR8100'); // Verarbeitung abgebrochen
      // ... Abbruch mit F3/F12
      exsr CloseFile;
    else;
      // ... weiter
      // ... abrufen der Feldliste
      exsr GetFldList;
      // ... abrufen der Schlüsselfelder
      exsr GetKeyList;
      // ... Sortieren der Schlüsselfelder
      exsr FloatKeys;
      // ... Fensterposition
      ##WndNbr = 0;
      ##StrPage = 0;
      // ... Suchmodus
      exsr SrchInz;
      // ... Blätternfunktion Einzelsatz
      yScreenNbr = 0;
      // ... abrufen der Teildateiattribute
      exsr GetMbrAttr;
      // ... initialisieren Kurzbefehl
      exsr InitSCmd;
      // ... Nachrichten entfernen
      p_rmvPgmMg(sds.pgmName);
      // ... einblenden Aufsetzkey
      if (AccessMode = KEY_SEQ);
        *in70 = '1';
      else;
        *in70 = '0';
      endif;
      // ... Cursor auf Keyeingabezeile setzen
      exsr C_PosCsr;

      // ... Hexmode nicht bei Satzlänge größer 32766
      if (File#X.RcdLen > RCD_BUFF_LEN and
          set0001.SET_DspMde = '*DSPHEX');
        clear usr8206;
        usr8206.var1  = RCD_BUFF_LEN;
        p_sndPgmMg('USR8206': usr8206: sds.pgmName);
        exsr S_DspNrm;
      endif;

      // ... Felder, welche nicht erlaubt sind
      clear f_key;
      f_key.F_Field = *blanks;
      setll %kds(f_key) fpeekfld;
      dow ('1');
        read fpeekfld;
        if (%eof());
          leave;
        endif;
        if (f_isNotAlw(f_ffd) = bTrue);
          p_sndPgmMg('USR8196': F_Field: sds.pgmName);
        endif;
      enddo;

      // ... Prüfen der Registrierung
      exsr C_Register;
      if (isLicenceError = bTrue);
        exsr CloseFile;
      endif;

      // ... Datei geöffnet ...
      if (IsOpen = bTrue);
        if (commitLvl = '0');
          // ... ohne Commit
          *in55 = bFalse;
          p_sndPgmMg('USR0004': '': sds.pgmName);
        else;
          // ... mit Commit
          *in55 = bTrue;
          p_sndPgmMg('USR0003': '': sds.pgmName);
        endif;

        // ... Datei für ...
        if (isUpdMod = bFalse);
          // ... Input geöffnet
          usr0007.var1 = ##File;
          usr0007.var2 = ##Library;
          p_sndPgmMg('USR0007': usr0007: sds.pgmName);
        else;
        // ... Update geöffnet
        endif;
      endif;
    endif;
  endif;

  isSflDirty = bTrue;

  yIsLower = bNotDef;

  isKeyLower = bFalse;

endsr;

//============================================================*
//    PBRead        Lesen in Satz- oder Schlüsselfolge        *
//============================================================*

begsr PBRead;

  isFileError = bFalse;

  dou ((File#X.rcdFmt = ##Format) or (*in99 = *on));

    select;
    when (AccessMode = KEY_SEQ);
      if (CIO_read(hFile02: bFalse
                : IO_Buff: IO_NullMap) = bEOF);
        *in99 = *on;
      else;
        *in99 = *off;
      endif;
      exsr F2toFx;
      isFileError = CIO_isError(hFile02);
    when (AccessMode = RRN_SEQ);
      if (CIO_read(hFile01: bFalse
                : IO_Buff: IO_NullMap) = bEOF);
        *in99 = *on;
      else;
        *in99 = *off;
      endif;
      exsr F1toFx;
      isFileError = CIO_isError(hFile01);
    when (AccessMode = SQL_SEQ);
      if (SQL_nextRow(IO_Buff: IO_NullMap: hFile03:
                   YMsgID : YMsgDta)  = bEOF);
        *in99 = *on;
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
      else;
        *in99 = *off;
        YMsgID = '';
        YMsgDta = '';
      endif;
      exsr F3toFx;
      isFileError = CIO_isError(hFile03);
    other;
    endsl;

  enddo;

  if (isFileError = bTrue);
    IsEOF = bTrue;
  else;
    if (*in99 = *on);
      exsr PBMoveBot;
      IsEOF = bTrue;
    else;
      IsEOF = bFalse;
    endif;
  endif;

endsr;

//============================================================*
//    PBReadP       Rückwärts lesen in Satz- oder             *
//                  Schlüsselfolge                            *
//============================================================*

begsr PBReadP;

  dou ((File#X.rcdFmt = ##Format) or (*in99 = *on));

    select;
    when (AccessMode = KEY_SEQ);
      if (CIO_readp(hFile02: bFalse
                 : IO_Buff: IO_NullMap) = bEOF);
        *in99 = *on;
      else;
        *in99 = *off;
      endif;
      exsr F2toFx;
    when (AccessMode = RRN_SEQ);
      if (CIO_readp(hFile01: bFalse
                 : IO_Buff: IO_NullMap) = bEOF);
        *in99 = *on;
      else;
        *in99 = *off;
      endif;
      exsr F1toFx;
    when (AccessMode = SQL_SEQ);
      if (SQL_previousRow(IO_Buff: IO_NullMap: hFile03:
                       YMsgID : YMsgDta) = bEOF);
        *in99 = *on;
        if (YMsgID <> '');
          p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
          YMsgID = '';
          YMsgDta = '';
        endif;
      else;
        *in99 = *off;
        YMsgID = '';
        YMsgDta = '';
      endif;
      exsr F3toFx;
      isFileError = CIO_isError(hFile03);
    other;
    endsl;

  enddo;

  if (*in99 = *on);
    exsr PBMoveTop;
    IsEOF = bTrue;
  else;
    IsEOF = bFalse;
  endif;

endsr;

//============================================================*
//    F0toFx        Übertragen der Dateiinformationen         *
//                  (Status usw.) der Datei 00 in die         *
//                  "globalen Felder Fx                       *
//============================================================*

begsr F0toFx;

  File#X = CIO_getInfDS(hFile00);

endsr;

//============================================================*
//    F1toFx        Übertragen der Dateiinformationen         *
//                  (Status usw.) der Datei 01 in die         *
//                  "globalen Felder Fx                       *
//============================================================*

begsr F1toFx;

  File#X = CIO_getInfDS(hFile01);

endsr;

//============================================================*
//    F2toFx        Übertragen der Dateiinformationen         *
//                  (Status usw.) der Datei 02 in die         *
//                  "globalen Felder Fx                       *
//============================================================*

begsr F2toFx;

  File#X = CIO_getInfDS(hFile02);

endsr;

//============================================================*
//    F3toFx        Übertragen der Dateiinformationen         *
//                  (Status usw.) der Datei 03 in die         *
//                  "globalen Felder Fx                       *
//============================================================*

begsr F3toFx;

  File#X = CIO_getInfDS(hFile03);

endsr;

//============================================================*
//    RepeatOpt     Wiederholen der Subfileauswahl            *
//============================================================*

begsr RepeatOpt;

  //  "Keine Sätze vorhanden"
  if (*in80 = *off);
  //  ... nix zu tun
  else;

    //  Lese alle Sätze der Subfile ab Wrk#Recno ...
    for x = Wrk#Recno to SflNbrRcd;

      SflRec132 = x;
      SflRec080 = x;
      exsr pbSflChain;

      //  ... höre auf, bei Dateiende oder Fehler
      if (not %found());
        leave;
      else;
        //  ... Wenn SFPAU bereits gefüllt ist,
        //      dann beende die Verarbeitung ...
        if (sfpau <> '');
          *in84 = '1'; // SFLNXTCHG
          exsr pbSflUpdate;
          leave;
        else;
          //  ... ansonsten wiederhole die Auswahl
          sfpau = Wrk#SFPAU;
          *in84 = '1'; // SFLNXTCHG
          exsr pbSflUpdate;
        endif;
      endif;

    endfor;

  endif;

endsr;

//============================================================*
//    GetFrstFld    Ermitteln der Feldnummer des ersten       *
//                  sichtbaren Feldes                         *
//============================================================*

begsr GetFrstFld;

  if (IsOpen = bFalse);
    ##WndNbr = 0;
  else;

    ##WndNbr = 0;

    for x = 1 to cp;

      Wrk#Field = Col_Field(x);
      exsr chkVisible;
      if (isVisible = bFalse);
        //  ... nicht sichtbar
        iter;
      else;
        //  ... sichtbar
        //      ... ermitteln der Sequenznummer
        clear f_key;
        f_key.F_Field = Col_Field(x);
        chain(n) %kds(f_key) fpeekfld;
        if (%found(peekfld));
          // ... ermittelt
          ##WndNbr = F_Seq;
          leave;
        else;
          // ... kann eigentlich nicht sein
          iter;
        endif;
      endif;

    endfor;

  endif;

  //  Merken letzte Feldposition
  L#WndNbr = ##WndNbr;

  exsr ChkSeqRnge;

endsr;

//============================================================*
//    GetPgmName    Berechnen Programmname                    *
//============================================================*

begsr getPgmName;

  peekPgm = 'P' +
             %subst(rcdl0200.R2FmtID: 1: 2) +
             %subst(rcdl0200.R2FmtID: 7: 7);

endsr;

//============================================================*
//    GetDSpName    Berechnen Name Displayfile                *
//============================================================*

begsr getDspName;

  peekDspF = 'F' +
             %subst(rcdl0200.R2FmtID: 1: 2) +
             %subst(rcdl0200.R2FmtID: 7: 7);

endsr;

//============================================================*
//    GetFldTMrk    Holen des zu markierenden Feldnamens      *
//============================================================*

begsr GetFldTMrk;

  Wrk#Field = '';

  if (cp <= 0);
    //  Funktion bei leerer Feldtabelle möglich ...
    p_sndPgmMg('USR8145': '': sds.pgmName);
  else;

    for x = 1 to cp;
      y = cursorPosition.column - SflLeftOfs;
      if (y >= Col_ScnStr(x) and y <= Col_ScnEnd(x));
        Wrk#Field = Col_Field(x);
        leave;
      endif;
    endfor;

    if (Wrk#Field = '');
      p_sndPgmMg('USR8117': '': sds.pgmName);
    endif;

  endif;

endsr;

//============================================================*
//    GetSflRcd     Einlesen Subfilesatz an aktueller         *
//                  Cursorposition                            *
//============================================================*

begsr getSflRcd;

  if (SflCsr > 0);
    exsr pbCsrToRcd;
  else;
    SflCsr = 0;
    p_sndPgmMg('USR8102': '': sds.pgmName);
  endif;

endsr;

//============================================================*
//    GetNbrKeyF    Ermitteln Anzahl Schlüsselfelder          *
//============================================================*

begsr GetNbrKeyF;

  peek04(YQFile: ##Format: YMsgID: YMsgDta);
  if (YMsgID = 'USR0006');
    IsKeyAvail = bFalse;
  else;
    IsKeyAvail = bTrue;
  endif;

endsr;

//============================================================*
//    GetNbrMbr     Ermitteln Anzahl Teildateien              *
//============================================================*

begsr GetNbrMbr;

  peek41(YQFile: ##Format
        : '*CREATE': YNbrOfEnt: YData);
  if (YNbrOfEnt > *zeros);
    fild0100 = YData;
  else;
    clear fild0100;
  endif;

  $$nomb = fild0100.atnomb;

endsr;

//============================================================*
//    GetFmtList    Abrufrufen der Satzformatliste            *
//============================================================*

begsr GetFmtList;

  YFile = ##File;
  yLibrary = ##Library;
  peek10(YQFile: YMsgID: YMsgDta);

endsr;

//============================================================*
//    GetFldList    Abrufrufen der Feldliste                  *
//============================================================*

begsr GetFldList;

  YFile = ##File;
  yLibrary = ##Library;
  peek01(YQFile: ##Format: $$rcdfmtid
        : YMsgID: YMsgDta);

  open peekfld;
  open peekfldl1;

endsr;

//============================================================*
//    GetKeyList    Abrufrufen der Schlüsselfelder            *
//============================================================*

begsr GetKeyList;

  peek03(YQFile: ##Format: AccessMode: sqlOrder
        : YMsgID: YMsgDta);

endsr;

//============================================================*
//    GetRcdFrmt    Auswählen des Satzformates                *
//============================================================*

begsr GetRcdFrmt;

  peek12(set0001.SET_Dsp80: COPYRIGHT: ##Format
        : MODE_BATCH
        : rcdl0200: YFmtNbr: YMsgID: YMsgDta);

  if (YMsgID <> 'USR8100'); // Verarbeitung abgebrochen
    ##fmtnbr = YFmtNbr;
    ##Format = rcdl0200.R2FmtName;
    $$Length = rcdl0200.R2RcdLen;
  else;
  //         Abbruch über F3/F12
  endif;

endsr;

//============================================================*
//    GetObjAttr    Abrufrufen und anzeigen der               *
//                  Objektattribute                           *
//============================================================*

begsr GetObjAttr;

  monitor;
    YFile = ##File;
    yLibrary = ##Library;
    peek09(YQFile: objd0400: YMsgID: YMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = *on);
    IsError = bTrue;
  else;
    IsError = bFalse;
    if (YMsgID <> '');
      IsError = bTrue;
      //  Objekt nicht gefunden ...
      select;
      when (YMsgID = 'CPF9812');
        usr0008.var1 = ##File;
        usr0008.var2 = ##Library;
        p_sndPgmMg('USR0008': usr0008: sds.pgmName);
      when (YMsgID = 'CPF9810');
        usr0010.var1 = ##Library;
        p_sndPgmMg('USR0010': usr0010: sds.pgmName);
      other;
        usr0009.var1 = ##File;
        usr0009.var2 = ##Library;
        p_sndPgmMg('USR0009': usr0009: sds.pgmName);
      endsl;
    else;

      IsError = bFalse;
      //  Übertragen der Objektbezeichnung
      ##File = objd0400.O4ObjName;
      ##Library = objd0400.O4RetLib;

      //  Übertragen der Objektbeschreibung
      $$text40 = objd0400.O4Text;
      $$text50 = objd0400.O4Text;

      //  Wenn die Objektgröße kleiner als 999 ist,
      if (objd0400.O4ObjSize <= 999);
        //  ... dann in der Einheit "Byte" anzeigen ...
        R#Size = 0;
        $$unit = 'Byt';
      else;
        //  ... ansonsten solange durch 1024 teilen,
        //      bis das die nächste passende Einheit
        //      gefunden werden konnte.
        R#Size = 0;

        dow (objd0400.O4ObjSize > 999);
          objd0400.O4ObjSize =
           %dech(objd0400.O4ObjSize / 1024: 10: 0);
          R#Size = R#Size + 1;
        enddo;

        //  Multiplikator aus der Objektbeschreibung
        //  berücksichtigen und ...
        if (objd0400.O4ObjSizeM = 1024);
          R#Size = R#Size + 1;
        else;
        //       keine Korrektur erforderlich
        endif;

        //  ... und passende Einheit wählen ...
        select;
        when (R#Size = 1);
          $$unit = 'K';
        when (R#Size = 2);
          $$unit = 'MByt';
        when (R#Size = 3);
          $$unit = 'GByt';
        other;
          $$unit = 'TByt';
        endsl;
      endif;

      //  ... sowie Restgröße zur Anzeige bringen
      $$size = objd0400.O4ObjSize;
    endif;
  endif;

endsr;

//============================================================*
//    GetMbrAttr    Abrufen der Attribute der Teildatei       *
//============================================================*

begsr GetMbrAttr;

  //  Beschreibung der Teildatei
  if (IsOpen = bFalse);
    $$Records = 0;
    leavesr;
  endif;

  if (##Member = '*NONE');
    clear mbrd0200;
    $$Records = 0;
    $$LmtCnt = '';
    $$Records = 0;
    leavesr;
  endif;

  YFile = ##File;
  yLibrary = ##Library;
  peek13(YQFile: ##Member: mbrd0200);

  if (mbrd0200.m2bytAvl > 0);
    if (mbrd0200.M2NbrRcdOn <= 2147483647);
      $$Records = mbrd0200.M2NbrRcdOn;
      *in79 = *on;
      $$LmtCnt = '';
    else;
      $$Records = 0;
      *in79 = *off;
      $$LmtCnt = '*OVERFLOW';
    endif;
  else;
    $$Records = 0;
    *in79 = *off;
    $$LmtCnt = '*ERROR';
  endif;

  if (AccessMode = SQL_SEQ);
    if ($$Records > set0016.set_maxrcds);
      $$Records = 0;
      *in79 = *off;
      $$LmtCnt = '*SQLLMTCNT';
    else;
      clear usr0014;
      p_sndStsMg('USR0014': usr0014);
      $$Records = SQL_count();
      *in79 = *on;
      $$LmtCnt = *blanks;
    endif;
  endif;

endsr;

//============================================================*
//    CheckMbrName  Prüfen Name der Teildatei                 *
//============================================================*

begsr CheckMbrName;

  if (##Member = '*NONE');
    clear mbrd0200;
    IsError = bFalse;
    leavesr;
  endif;

  YFile = ##File;
  yLibrary = ##Library;
  peek13(YQFile: ##Member: mbrd0200);
  if (mbrd0200.m2bytAvl <> 0);
    ##Member = mbrd0200.M2Member;
    IsError = bFalse;
  else;
    IsError = bTrue;
  endif;

endsr;

//============================================================*
//    GetMaxSeq     Ermitteln der Anzahl Felder               *
//============================================================*

begsr GetMaxSeq;

  if (IsOpen = bFalse);
    L#MaxSeq = 0;
    L#MinSeq = 0;
  else;

    //  Ermitteln Anzahl Felder ...
    clear f1key_l1;
    f1key_l1.F_Seq = *hival;
    setgt %kds(f1key_l1) fpeekfldl1;

    dow ('1');
      readp fpeekfldl1;
      if (%eof());
        L#MaxSeq = 0;
        leave;
      endif;

      //  ... Prüfen, ob Feld angezeigt wird
      Wrk#Field = F_Field;
      exsr chkVisible;
      if (isVisible = bFalse);
        iter;
      endif;

      L#MaxSeq = F_Seq;
      leave;
    enddo;

    //  Ermitteln Erstes Feld ...
    clear f1key_l1;
    f1key_l1.F_Seq = 0;
    setll %kds(f1key_l1) fpeekfldl1;

    dow ('1');
      read fpeekfldl1;
      if (%eof());
        L#MinSeq = 0;
        leave;
      endif;

      //  ... Prüfen, ob Feld angezeigt wird
      Wrk#Field = F_Field;
      exsr chkVisible;
      if (isVisible = bFalse);
        iter;
      endif;

      L#MinSeq = F_Seq;
      leave;
    enddo;

  endif;

endsr;

//============================================================*
//    GetMaxSeq     Ermitteln vorhergehendes sichtabres Feld  *
//============================================================*

begsr GetPrvSeq;

  if (IsOpen = bFalse);
    Wrk#SeqNbr = -1;
    leavesr;
  endif;

  clear f1key_l1;
  f1key_l1.F_Seq = Wrk#SeqNbr;
  chain %kds(f1key_l1) fpeekfldl1;
  if (not %found());
    Wrk#SeqNbr = L#MinSeq;
    leavesr;
  endif;

  for do_x10 = 1 to *hival;
    readp fpeekfldl1;
    if (%eof());
      Wrk#SeqNbr = L#MinSeq;
      leave;
    endif;

    //  ... Prüfen, ob Feld angezeigt wird
    Wrk#Field = F_Field;
    exsr chkVisible;
    if (isVisible = bFalse);
      iter;
    endif;

    Wrk#SeqNbr = F_Seq;
    leave;
  endfor;

endsr;

//============================================================*
//    CloseFile     Datei schließen                           *
//============================================================*

begsr CloseFile;

  if (IsOpen = bTrue);

    yCursorPosition.row = 0;
    yCursorPosition.column = 0;

    //  Datei 04 für Einzelsatzzugriff
    if (CIO_isOpen(hFile04) = bTrue);
      CIO_close(hFile04);
    endif;

    select;
    when (AccessMode = KEY_SEQ);
      //  Sortierung 2 für Schlüsselfolge
      if (CIO_close(hFile02) = bTrue);
        *in99 = '0';
      else;
        *in99 = '1';
      endif;
      exsr F2toFx;
    when (AccessMode = RRN_SEQ);
      //  Sortierung 1 für Satzfolge
      if (CIO_close(hFile01) = bTrue);
        *in99 = '0';
      else;
        *in99 = '1';
      endif;
      exsr F1toFx;
    when (AccessMode = SQL_SEQ);
      if (SQL_close(hFile03:YMsgID :YMsgDta)
          = bTrue);
        *in99 = *off;
        YMsgID = '';
        YMsgDta = '';
      else;
        *in99 = *on;
        if (YMsgID <> '');
          p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
          YMsgID = '';
          YMsgDta = '';
        endif;
      endif;
      exsr F3toFx;
    other;
    endsl;

  else;
    *in99 = '0';
  endif;

  //  Sortierung 0 für Einzelzugriff
  if (CIO_isOpen(hFile00) = bTrue);
    if (CIO_close(hFile00) = bTrue);
      *in99 = '0';
    else;
      *in99 = '1';
    endif;
    exsr F0toFx;
  endif;

  if (*in99 = *off);
    IsOpen = bFalse;
    //  Löschen Satzaufbau
    if (%open(peekfld));
      clear f_key;
      f_key.F_Field = *blanks;
      setll %kds(f_key) fpeekfld;
      dow ('1');
        read fpeekfld;
        if (%eof());
          leave;
        endif;
        delete fpeekfld;
      enddo;
      close peekfldl1;
      close peekfld;
    endif;
    //      ... Satzformat
    $$text40 = *blanks;
    $$text50 = *blanks;
    $$Length = 0;
    $$Records = 0;
    $$size = 0;
    $$rcdfmtid = *blanks;
    $$unit = *blanks;
    $$nomb = 0;
    ##Key = *blanks;
    ##RcdNbr = 0;
    //      ... Fensterposition
    ##WndNbr = 0;
    ##StrPage = 0;

    //      ... SQL-Selektion
    sqlWhere  = ' ';
    sqlOrder  = ' ';

  else;
  //             Weiss noch nicht!
  endif;

  //  Entfernen Update Programm aus Arbeitsspeicher
  f_execute('RCLACTGRP +
              ACTGRP(PEEKUPD) +
              OPTION(*NORMAL)'
           : YMsgID: YMsgDta);
  YMsgID = '';
  YMsgDta = '';

  //  Subfile initialisieren
  exsr PBInit;

endsr;

//============================================================*
//    GetOpnFile    Ermitteln der geöffneten Datei            *
//============================================================*

begsr GetOpnFile;

  if (IsOpen = bTrue);
    ##File = File#X.file;
    ##Library = File#X.library;
    ##Member = File#X.member;
  else;
    //**                MOVEL (P) *BLANKS       ##File
    //**                MOVEL (P) *BLANKS       ##Library
    //**                MOVEL (P) *BLANKS       ##Member
    $$text40 = *blanks;
    $$text50 = *blanks;
    $$size = 0;
    $$rcdfmtid = *blanks;
    $$unit = *blanks;
  endif;

  L#File = ##File;
  L#Library = ##Library;
  L#Member = ##Member;
  L#Format = ##Format;

endsr;

//============================================================*
//    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr GetUsrSetg;

  //  *DSPATR
  set0001 = f_getUsrSg('*DSPATTR'  );

  //  *SEARCH
  set0002 = f_getUsrSg('*SEARCH'   );

  //  *ACCESSKEY
  set0003 = f_getUsrSg('*ACCESSKEY');

  //  *SPLASH
  set0005 = f_getUsrSg('*SPLASH'   );

  //  *CVTCHR
  set0006 = f_getUsrSg('*CVTCHR'   );

  //  *VERSION
  set0007 = f_getUsrSg('*VERSION'  );

  //  *PROMPT
  set0008 = f_getUsrSg('*PROMPT'   );

  //  *FLOATKEYS
  set0009 = f_getUsrSg('*FLOATKEYS');

  //  *SCROLL
  set0010 = f_getUsrSg('*SCROLL'   );

  //  *DFTDSPMDE
  set0011 = f_getUsrSg('*DFTDSPMDE');

  if (set0011.SET_DftMde = '*LAST');
  //    ... Modus belassen
  else;
    set0001.SET_DspMde = set0011.SET_DftMde;
  endif;

  select;
  when (set0001.SET_DspMde = '*DSPNRM');
    exsr S_DspNrm;
  when (set0001.SET_DspMde = '*DSPHEX');
    exsr S_DspHex;
  other;
    exsr S_DspNrm;
  endsl;

  // - Löschen Programmnachricht "keine Datei geöffnet"
  p_rmvPgmMg(sds.pgmName);

  //  *SECATR ...
  set0013 = f_getUsrSg('*SECATRDFT'   );

  //  ... Verknüpfen *SECATRDFT mit Eingabeparametern ...
  //      ... ##Library
  if (i_chgLib = '*');
    if (set0013.SET_ChgLib = '1');
      auth.isChgLibAlw = bTrue;
    else;
      auth.isChgLibAlw = bFalse;
    endif;
  else;
    if (i_chgLib = '1');
      auth.isChgLibAlw = bTrue;
    else;
      auth.isChgLibAlw = bFalse;
    endif;
  endif;

  //      ... ##File
  if (i_chgFile = '*');
    if (set0013.SET_ChgFil  = '1');
      auth.isChgFileAlw = bTrue;
    else;
      auth.isChgFileAlw = bFalse;
    endif;
  else;
    if (i_chgFile = '1');
      auth.isChgFileAlw = bTrue;
    else;
      auth.isChgFileAlw = bFalse;
    endif;
  endif;

  //      ... ##Member
  if (i_chgMbr = '*');
    if (set0013.SET_ChgMbr = '1');
      auth.isChgMbrAlw = bTrue;
    else;
      auth.isChgMbrAlw = bFalse;
    endif;
  else;
    if (i_chgMbr = '1');
      auth.isChgMbrAlw = bTrue;
    else;
      auth.isChgMbrAlw = bFalse;
    endif;
  endif;

  //      ... updMod
  if (i_updModKey = UPD_M_DFT);
    if (set0013.SET_UpdMod = '1');
      auth.isUpdAlw = bTrue;
    else;
      auth.isUpdAlw = bFalse;
    endif;
  else;
    if (i_updModKey = UPD_M_YES or
        i_updModKey = UPD_M_NOKEY);
      auth.isUpdAlw = bTrue;
    else;
      auth.isUpdAlw = bFalse;
    endif;
  endif;

  //      ... keyUpd
  if (i_updModKey = UPD_M_DFT or
      i_updModKey = UPD_M_YES);
    auth.isUpdKeyAlw = bTrue;
  else;
    auth.isUpdKeyAlw = bFalse;
  endif;

  //      ... chgSqlW
  if (i_chgSqlW = UPD_M_DFT or
      i_chgSqlW = UPD_M_YES);
    auth.isChgSQLWhereAlw = bTrue;
  else;
    auth.isChgSQLWhereAlw = bFalse;
  endif;

  //      ... chgSqlO
  if (i_chgSqlO = UPD_M_DFT or
      i_chgSqlO = UPD_M_YES);
    auth.isChgSQLOrderByAlw = bTrue;
  else;
    auth.isChgSQLOrderByAlw = bFalse;
  endif;

  //      ... accAut
  if (set0013.SET_AccAut = '1');
    auth.isAccessAlw = bTrue;
  else;
    auth.isAccessAlw = bFalse;
  endif;

  //  *PRVFILE
  set0014 = f_getUsrSg('*PRVFILE');

  //  *ENVFILE
  set0015 = f_getUsrSg('*ENVFILE');

  //  *SQLLMTCNT
  set0016 = f_getUsrSg('*SQLLMTCNT');

endsr;

//============================================================*
//    GetSeqNbr     Übersetzen Field Name in Sequence Nbr     *
//============================================================*

begsr GetSeqNbr;

  clear f_key;
  f_key.F_Field = Wrk#Field;
  chain(n) %kds(f_key) fpeekfld;
  if (%found());
    isSeqNbrOK = bTrue;
    Wrk#SeqNbr = F_Seq;
  else;
    isSeqNbrOK = bFalse;
    Wrk#SeqNbr = 0;
  endif;

endsr;

//============================================================*
//    GetLastOpt    Ermitteln der letzten Subfileauswahl      *
//============================================================*

begsr GetLastOpt;

  //  "Keine Sätze vorhanden"
  if (*in80 = *off);
    IsError = bTrue;
    Wrk#SFPAU = *blanks;
    Wrk#Recno = 0;
  else;

    for x = 1 to SflNbrRcd;

      y = SflNbrRcd - x;
      y = y + 1;

      if (*in88 = *off);
        SflRec132 = y;
        chain SflRec132 pbsfl132;
      else;
        SflRec080 = y;
        chain SflRec080 pbsfl080;
      endif;

      if (not %found());
        IsError = bTrue;
        Wrk#SFPAU = '';
        Wrk#Recno = 0;
        leave;
      else;
        if (sfpau <> '');
          Wrk#SFPAU = sfpau;
          if (*in88 = bFalse);
            Wrk#Recno = SflRec132;
          else;
            Wrk#Recno = SflRec080;
          endif;
          IsError = bFalse;
          leave;
        else;
        //  Bitte weitersuchen ...
        endif;
      endif;

    endfor;

  endif;

endsr;

//============================================================*
//    GetNxtMark    Ermtteln des nächsten markierten Feldes   *
//============================================================*

begsr GetNxtMark;

  //  Suchen des nächsten markierten Feldes ...
  clear f1key_l1;
  f1key_l1.F_Seq = Wrk#SeqNbr;
  setgt %kds(f1key_l1) fpeekfldl1;

  dow ('1');
    read fpeekfldl1;
    if (%eof());
      Wrk#SeqNbr = *zeros;
      leave;
    endif;

    exsr chkVisible;
    if (isVisible = bFalse);
    // ... Feld ist nicht sichtbar
    else;
      // ... Feld ist sichtbar
      if (F_MarkCol = bTrue);
        // ... und markiert
        Wrk#SeqNbr = F_Seq;
        leave;
      else;
      // ... leider nicht markiert
      endif;
    endif;

  enddo;

endsr;

//============================================================*
//    GetPrvMark    Ermtteln des vorherigen markierten Feldes *
//============================================================*

begsr GetPrvMark;

  //  Suchen des nächsten markierten Feldes ...
  clear f1key_l1;
  f1key_l1.F_Seq = Wrk#SeqNbr;
  setll %kds(f1key_l1) fpeekfldl1;

  dow ('1');
    readp fpeekfldl1;
    if (%eof());
      Wrk#SeqNbr = 0;
      leave;
    endif;

    exsr chkVisible;
    if (isVisible = bFalse);
    // ... Feld ist nicht sichtbar
    else;
      // ... Feld ist sichtbar
      if (F_MarkCol = bTrue);
        // ... und markiert
        Wrk#SeqNbr = F_Seq;
        leave;
      else;
      // ... leider nicht markiert
      endif;
    endif;

  enddo;

endsr;

//============================================================*
//    KeyHasChg     Aufsetzkey hat gewechselt                 *
//============================================================*

begsr KeyHasChg;

  Wrk#KeyVal = ##Key;
  Wrk#RcdNbr = ##RcdNbr;
  exsr PBGenIntKy;
  if (YMsgID <> *blanks);
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    p_sndPgmMg('USR8139': '': sds.pgmName);
  else;
    exsr PBSetLL;
    exsr PBInit;
    exsr pbPinRcd;
    exsr PBReadUp;
    //  Aufsetzkey überschreitet Dateiende
    if (*in80 = *off);
      exsr C_Bot;
    endif;
  endif;

endsr;

//============================================================*
//    FloatKeys     Keyfelder an den Anfang sortieren         *
//============================================================*

begsr FloatKeys;

  if ((set0009.set_float  = bTrue) and
      ((AccessMode = KEY_SEQ) or
       (AccessMode = SQL_SEQ)));

    monitor;
      peek34(set0001.SET_Dsp80: COPYRIGHT: '*FLOATKEYS'
            : YMsgID: YMsgDta);
      *in99 = bFalse;
    on-error;
      *in99 = bTrue;
    endmon;

  else;
  //    Es werden keine Schlüsselfeldinformationen benötigt
  endif;

endsr;

//============================================================*
//    KeepCsrPos    Beibehalten der Cursorposition            *
//============================================================*

begsr KeepCsrPos;

  //  Beibehalten der Cursorosition
  CsrRow = cursorPosition.row;
  CsrCol = cursorPosition.column;

endsr;

//============================================================*
//    DltCsrPos     Löschen der Cursorposition                *
//============================================================*

begsr DltCsrPos;

  //  Löschen der Cursorosition
  CsrRow = *zeros;
  CsrCol = *zeros;

endsr;

//============================================================*
//    SetUsrSetg    Speichern der Benutzervoreinstellungen    *
//============================================================*

begsr SetUsrSetg;

  //  Splash-Screen
  p_updUsrSg('*SPLASH' : set0005);

endsr;

//============================================================*
//    ChkVisible    Prüfen, ob Feld angezeigt wird            *
//============================================================*

begsr chkVisible;

  isVisible = bTrue;

  for do_x14 = 1 to 1;

    //  ... Feld nicht anzeigen
    if (F_Hidden = bTrue);
      isVisible = bFalse;
      leave;
    endif;

    //  ... gepinnte Spalten überlesen
    Pin#Field = Wrk#Field;
    exsr ChkPinCol;
    if (IsPinned = bTrue);
      isVisible = bFalse;
      leave;
    endif;

  endfor;

endsr;

//============================================================*
//    ChkSeqRnge    Prüfen der Fensternummer                  *
//============================================================*

begsr ChkSeqRnge;

  if (IsOpen = bFalse);
  //            keine Datei geöffnet
  else;

    if (##WndNbr < L#MinSeq);
      ##WndNbr = L#MinSeq;
      p_sndPgmMg('USR8115': '': sds.pgmName);
      ##StrPage = 1;
    endif;

    if (##WndNbr > L#MaxSeq);
      ##WndNbr = L#MaxSeq;
      p_sndPgmMg('USR8116': '': sds.pgmName);
      if (set0010.set_scroll = '*BOTH'
          or set0010.set_scroll = '*RIGHT');
        ##StrPage = *hival;
      else;
        ##StrPage = 1;
      endif;
    endif;

    if (##StrPage < 1);
      ##StrPage = 1;
    endif;

  endif;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

  //    Wenn der Bildschirm keine 132-Zeichen
  //    darstellen kann, ...
  if (workstn.numRows < 27);
    //    ... dann auf 80-Zeichen umschalten.
    set0001.SET_Dsp80 = '1';
  else;
  //    ... sonst die Auflösung 80/132 beibehalten.
  endif;

  if (set0001.SET_Dsp80 = '1');
    //    80-Zeichen Anzeige
    *in88 = '1';
    SflPage = 14;
    sflMaxRowLen = 64;
    SflHeadLRw = 6;
    SflFirstRw = 7;
    SflLastRw = 20;
    SflLeftOfs = 15;
  else;
    //   132-Zeichen Anzeige
    *in88 = '0';
    SflPage = 16;
    sflMaxRowLen = 116;
    SflHeadLRw = 6;
    SflFirstRw = 8;
    SflLastRw = 23;
    SflLeftOfs = 15;
  endif;

  //  Bereich für gepinnte Spalten
  SflPinRnge = (sflMaxRowLen / 3) * 2;

  //  Prompt-Felder anzeigen ...
  if (set0008.SET_DspPmt = bTrue
     and *in77 = *off);
    *in71 = '1';
  else;
    *in71 = '0';
  endif;

  //  Subfileauswahlfeld öffnen ...
  *in76 = '0';

endsr;

//============================================================*
//    ChgScreen     Wechseln 132/80-Zeichen Auflösung         *
//============================================================*

begsr ChgScreen;

  if (set0001.SET_Dsp80 = '1');
    //   132-Zeichen Anzeige
    set0001.SET_Dsp80 = '0';
  else;
    //    80-Zeichen Anzeige
    set0001.SET_Dsp80 = '1';
  endif;

  exsr SetScreen;

endsr;

//============================================================*
//    ShowSplash    Anzeigen SPLASH-Screen                    *
//============================================================*

begsr ShowSplash;

  if (set0005.set_spla = bFalse);
  //            kein Splash-Screen
  else;
    write splash01;
  endif;

endsr;

//============================================================*
//    ChkVersion    Prüfen der Versionsnummer                 *
//============================================================*

begsr ChkVersion;

  if (set0007.set_vsn <> VERSION);
    peek33(VERSION: YMsgID: YMsgDta);
  else;
  //  Kein Abgleich erforderlich ...
  endif;

endsr;

//============================================================*
//    ChkPrvFile    Prüfen vorherige Datei                    *
//============================================================*

begsr ChkPrvFile;

  //  Datei ...
  if (##File = '*PRV');
    if (set0014.SET_PrvFil  <> '*NONE');
      ##File = set0014.SET_PrvFil;
    endif;
    //  Bibliothek ...
    if (set0014.SET_PrvLib  <> '*NONE');
      ##Library = set0014.SET_PrvLib;
    else;
      ##Library = ' ';
    endif;
    //  Teildatei ...
    if (set0014.SET_PrvMbr  <> '*NONE');
      ##Member = set0014.SET_PrvMbr;
    else;
      ##Member = ' ';
    endif;
  endif;

endsr;

//============================================================*
//  Call EXIT01. The exit program must exist.                 *
//============================================================*

begsr s_EXIT01;

  clear YQFile;
  YFile = ##File;
  yLibrary = ##Library;

  callp EXIT01(YQFile: ##Member: AccessMode
               : auth.isChgLibAlw: auth.isChgFileAlw: auth.isChgMbrAlw
               : auth.isUpdAlw: auth.isUpdKeyAlw
               : auth.isChgSQLWhereAlw: auth.isChgSQLOrderByAlw
               : auth.isAccessAlw
               : YMsgID: YMsgDta);

  if (YMsgID <> '');
    p_rmvPgmMg(sds.pgmName);
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
  endif;

endsr;

//============================================================*
//    clrPinTabR    Löschen PinTabR                           *
//============================================================*

begsr clrPinTabR;

  clear pinTabRcdE;
  for PinRcd_X = 1 to max_pin_rcd;
    PinTabRcd(PinRcd_X) = pinTabRcdE;
  endfor;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Zeichenumsetzung neu beginnen: Die Job-CCSID kann sich seit dem
  //   letzten Aufruf geändert haben (CHGJOB CCSID).
  transcoder_reset();

  // - Einlesen der Benutzervoreinstellungen
  exsr GetUsrSetg;

  // - Prüfen auf generischen Dateinamen
  if (f_endsWith('*': %trimr(io_qFile.name)));
    if (*in75 = *off); // Feld ist nicht gesperrt
      ##File = io_qFile.name;
      ##Library = io_qFile.lib;
      exsr Pmt_File;
      if (*in93 = bTrue);
        io_qFile.name = ##File;
        io_qFile.lib = ##Library;
      endif;
      ##File = '';
      ##Library = '';
    endif;
  endif;

  // - Öffnen Bildschirmdatei
  open peek05fm;

  // - Initialisieren Bildschirm
  ##File = io_qFile.name;
  ##Library = io_qFile.lib;
  ##Member = i_member;
  exsr GetObjAttr;

  exsr ChkPrvFile;
  ##RcdNbr = 0;
  ##Key = *blanks;
  ##WndNbr = 0;
  ##StrPage = 0;
  ##Field = *blanks;

  exsr clrFldPosArray;

  $$System = *blanks;
  $$text40 = *blanks;
  $$text50 = *blanks;
  ##Format = *blanks;
  $$Length = 0;
  $$Records = 0;
  $$size = 0;
  $$rcdfmtid = *blanks;
  $$unit = *blanks;

  $$Head132 = *blanks;
  $$Head080 = *blanks;

  //  Last opened file
  L#File = *blanks;
  L#Library = *blanks;
  L#Member = *blanks;
  L#Format = *blanks;
  L#MaxSeq = 0;
  L#MinSeq = 0;
  L#WndNbr = 0;

  //  SQL-Selektion
  sqlWhere  = ' ';
  sqlOrder  = ' ';

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr SetScreen;

  // - SPLASH-Screen
  exsr ShowSplash;

  // -  Darstellung der Auswahlen/Funktionstasten
  SFTop = 1;
  sfbot = 1;

  // -  Netzwerkattribute (ohne Statusmeldung)
  peek07('SYSNAME': bTrue
        : YAttrLen: YAttrTyp: YValue);
  if (YAttrLen > 0);
    $$System = %subst(YValue: 1: YAttrLen);
  else;
    $$System = *blanks;
  endif;

  // - Öffnen der Datei
  if (IsOpen = bFalse);
    AccessMode = i_access;
    if (AccessMode = SQL_SEQ);
      sqlWhere  = i_sqlWhere;
      sqlOrder  = i_sqlOrder;
    endif;
    exsr OpenFile;
  endif;

  // - laden Arbeitsumgebung / öffnen Datei
  if (i_qEnvFile.name = '*NONE');
    YEnvFile = set0015.set_envfil;
    YEnvLib  = set0015.set_envlib;
    YEnvMbr  = '*FILE';
  else;
    if (i_qEnvFile.name = '*ENVFILE');
      YEnvFile = set0015.set_envfil;
      YEnvLib  = set0015.set_envlib;
      YEnvMbr  = '*FILE';
    else;
      YEnvFile = i_qEnvFile.name;
      YEnvLib  = i_qEnvFile.lib;
      YEnvMbr  = i_envMbr;
    endif;
    if (i_envLayout = bTrue);
      YOption = '*SLCLAYOUT';
    else;
      YOption = '*SLCENV';
    endif;
    exsr LoadEnv;
    if (YMsgID = 'CPF9815'); // Teildatei nicht gefunden
      YMsgID = '';
      YMsgDta = '';
    endif;
  endif;

  // - Ermitteln der Attribute der geöffneten Datei
  exsr GetOpnFile;
  exsr GetMaxSeq;

  //  Wenn eine Datei geöffnet werden konnte, ...
  if (IsOpen = bTrue);
    //  ... dann
    //      abspeichern *PRVFILE
    set0014.SET_PrvFil  = ##File;
    set0014.SET_PrvLib  = ##Library;
    set0014.SET_PrvMbr  = ##Member;
    p_updUsrSg('*PRVFILE' : set0014);
  endif;

  // - Subfile füllen
  exsr PBInit;
  exsr C_Top;

  // - Copyright
  clear usr9999;
  usr9999.var1 = COPYRIGHT;
  usr9999.var2 = RELEASE;
  p_sndPgmMg('USR9999': usr9999: sds.pgmName);

endsr;

//============================================================*
//    InzSr        Programminitialisierung                    *
//============================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  PGMQ = '*';

  peek01_name = f_pgmCallN('PEEK01');
  peek03_name = f_pgmCallN('PEEK03');
  peek04_name = f_pgmCallN('PEEK04');
  peek06_name = f_pgmCallN('PEEK06');
  peek07_name = f_pgmCallN('PEEK07');
  peek08_name = f_pgmCallN('PEEK08');
  peek09_name = f_pgmCallN('PEEK09');
  peek10_name = f_pgmCallN('PEEK10');
  peek12_name = f_pgmCallN('PEEK12');
  peek13_name = f_pgmCallN('PEEK13');
  peek14_name = f_pgmCallN('PEEK14');
  peek17_name = f_pgmCallN('PEEK17');
  peek18_name = f_pgmCallN('PEEK18');
  peek19_name = f_pgmCallN('PEEK19');
  peek20_name = f_pgmCallN('PEEK20');
  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');
  peek24_name = f_pgmCallN('PEEK24');
  peek26_name = f_pgmCallN('PEEK26');
  peek27_name = f_pgmCallN('PEEK27');
  peek30_name = f_pgmCallN('PEEK30');
  peek32_name = f_pgmCallN('PEEK32');
  peek33_name = f_pgmCallN('PEEK33');
  peek34_name = f_pgmCallN('PEEK34');
  peek37_name = f_pgmCallN('PEEK37');
  peek38_name = f_pgmCallN('PEEK38');
  peek40_name = f_pgmCallN('PEEK40');
  peek41_name = f_pgmCallN('PEEK41');
  peek42_name = f_pgmCallN('PEEK42');
  peek47_name = f_pgmCallN('PEEK47');
  peek48_name = f_pgmCallN('PEEK48');
  peek49_name = f_pgmCallN('PEEK49');
  peek50_name = f_pgmCallN('PEEK50');
  peek52_name = f_pgmCallN('PEEK52');
  peek54_name = f_pgmCallN('PEEK54');
  peek55_name = f_pgmCallN('PEEK55');
  peek56_name = f_pgmCallN('PEEK56');
  peek57_name = f_pgmCallN('PEEK57');
  peek59_name = f_pgmCallN('PEEK59');
  peek65_name = f_pgmCallN('PEEK65');
  peek68_name = f_pgmCallN('PEEK68');
  peek69_name = f_pgmCallN('PEEK69');
  exit01_name = f_pgmCallN('EXIT01');
  exit04_name = f_pgmCallN('EXIT04': '*LIBL');

  // - PinTabR clearen
  exsr clrPinTabR;

  // - Versionsabgleich durchführen
  exsr ChkVersion;

  peek23(sds.pgmName: '*ALL': 8: yFKeys: yNbrOfKeys);
  ScrnFKeys = %subarr(yFKeys: 1);

  peek27(sds.pgmName: YChoice: YNbrOfCh);

endsr;

//============================================================*
//    f_int         Integer Wert                              *
//============================================================*

dcl-proc f_int;
  dcl-pi *n zoned(20);
    inpValue zoned(25: 5) value;
  end-pi;

  dcl-s integerVal zoned(20);

  integerVal = inpValue;

  return integerVal;

end-proc;

//============================================================*
//    f_chain00                                               *
//============================================================*

dcl-proc f_chain00;
  dcl-pi *n char(1);
    i_rrn    like(rcdNbr_t) value;
    i_file   like(file_t) value;
    i_lib    like(lib_t) value;
    i_mbr    like(mbr_t) value;
    i_rcdFmt char(10) value;
  end-pi;

  dcl-s IsFound like(bool_t) inz(bFalse);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if ((CIO_getFile(hFile00)    <> i_file ) or
      (CIO_getLibrary(hFile00) <> i_lib  ) or
      (CIO_getMember(hFile00)  <> i_mbr  ));
    if (CIO_isOpen(hFile00) = bTrue);
      CIO_close(hFile00);
    endif;
  endif;

  f_execute('OVRDBF ' +
             'FILE(' + %trim(##File) + ') ' +
             'TOFILE(' +
               %trim(##Library) + '/' +
               %trim(##File) + ') ' +
             'MBR(' + %trim(##Member) + ') ' +
             'OVRSCOPE(*ACTGRPDFN) ' +
             'SHARE(*NO) ' +
             'SEQONLY(*NO) SECURE(*YES)'
           : YMsgID: YMsgDta);
  YMsgID = '';
  YMsgDta = '';

  if (CIO_isOpen(hFile00) = bFalse);
    if (commitLvl = '1');
      CIO_open(hFile00
              : i_file
              : i_lib
              : i_mbr
              : i_rcdFmt
              : 'rr+ , arrseq=Y, commit=Y +
                 nullcap=Y, riofb=Y, +
                 secure=N, ccsid=65535');
    else;
      CIO_open(hFile00
              : i_file
              : i_lib
              : i_mbr
              : i_rcdFmt
              : 'rr+ , arrseq=Y, commit=N +
                 nullcap=Y, riofb=Y, +
                 secure=N, ccsid=65535');
    endif;
  endif;

  f_execute('DLTOVR ' +
             'FILE(' + %trim(##File) + ') ' +
             'LVL(*ACTGRPDFN) '
           : YMsgID: YMsgDta);
  YMsgID = '';
  YMsgDta = '';

  if (CIO_chainWithRRN(hFile00
                    : i_rrn
                    : bTrue
                    : IO_Buff
                    : IO_NullMap) = bFalse);
    IsFound = bTrue;
  else;
    IsFound = bFalse;
  endif;

  File#X = CIO_getInfDS(hFile00);

  return IsFound;

end-proc;

//============================================================*
//    f_chain04                                               *
//============================================================*

dcl-proc f_chain04;
  dcl-pi *n char(1);
    i_rrn    like(rcdNbr_t) value;
    i_file   like(file_t) value;
    i_lib    like(lib_t) value;
    i_mbr    like(mbr_t) value;
    i_rcdFmt char(10) value;
  end-pi;

  dcl-s IsFound like(bool_t) inz(bFalse);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if ((CIO_getFile(hFile04)    <> i_file ) or
      (CIO_getLibrary(hFile04) <> i_lib  ) or
      (CIO_getMember(hFile04)  <> i_mbr  ));
    if (CIO_isOpen(hFile04) = bTrue);
      CIO_close(hFile04);
    endif;
  endif;

  if (CIO_isOpen(hFile04) = bFalse);
    CIO_open(hFile04
            : i_file
            : i_lib
            : i_mbr
            : i_rcdFmt
            : 'rr , arrseq=Y, +
               nullcap=Y, riofb=Y, ccsid=65535');
  endif;

  if (CIO_chainWithRRN(hFile04
                    : i_rrn
                    : bFalse
                    : IO_Buff
                    : IO_NullMap) = bFalse);
    IsFound = bTrue;
  else;
    IsFound = bFalse;
  endif;

  File#X = CIO_getInfDS(hFile04);

  return IsFound;

end-proc;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorHandler;
  dcl-pi *n;
    i_condToken    likeds(cee_fc_t) value;
    i_pCommArea    int(10) value;
    o_action       int(10);
    o_newCondToken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

