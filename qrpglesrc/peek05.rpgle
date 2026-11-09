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
dcl-f peek05fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbsfl132: sflRec132)
  sfile(pbsfl080: sflRec080);

dcl-f peekFldL1 keyed rename(fpeekfld: fpeekfldl1) prefix(f_) usropn infds(peek#L1);

dcl-f peekFld usage(*update: *delete) keyed prefix(f_) usropn infds(peek#00);

dcl-ds workstn likeds(workstn_t);
dcl-ds cursorPosition likeds(cursorPosition_t) inz;

dcl-ds peek#L1 likeds(infds_t);
dcl-ds peek#00 likeds(infds_t);
dcl-ds file#X likeds(infds_t);

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

dcl-ds set0001 likeds(set0001_t) inz;
dcl-ds set0002 likeds(set0002_t) inz;
dcl-ds set0003 likeds(set0003_t) inz;
dcl-ds set0005 likeds(set0005_t) inz;
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

dcl-ds objd0400 likeds(objd0400_t) inz;
dcl-ds rcdl0200 likeds(rcdl0200_t) inz;
dcl-ds fldl0100 likeds(fldl0100_t) inz;
dcl-ds mbrd0200 likeds(mbrd0200_t) inz;
dcl-ds fild0100 likeds(fild0100_t) inz;

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

dcl-ds io_buff;
  io_buffFld like(rcdBuf_t);
end-ds;

dcl-s io_nullMap like(nullMap_t) dim(NULL_MAP_SIZE);

dcl-ds rtn qualified inz;
  file       like(##file);
  library    like(##library);
  member     like(##member);
  format     like(##format);
  accessMode like(accessMode);
  sqlWhere   like(sqlWhere);
  sqlOrder   like(sqlOrder);
end-ds;

dcl-ds yQFile inz;
  yFile    like(file_t);
  yLibrary like(lib_t);
end-ds;

dcl-s isLicenceError like(bool_t) inz(bTrue);
dcl-s yFormat like(rcdFmt_t) inz;
dcl-s yMsgID char(7) inz;
dcl-s yMsgDta char(512) inz;

dcl-s yMember like(mbr_t) inz;

dcl-s yAttrLen like(int4_t) inz;
dcl-s yAttrTyp char(1) inz;
dcl-s yValue char(512) inz;

dcl-s yDsp80 like(set0001_t.set_dsp80) inz;
dcl-s yCopyright like(copyright_t) inz(copyright);

dcl-s yFmtNbr int(5) inz;

dcl-s yHeaderType char(10) inz;
dcl-s yRcdNbr inz(0) like(rcdNbr_t);
dcl-s yFunction char(10) inz;
dcl-s yCommitLvl like(commitLvl) inz('0');
dcl-s yIsUpdKey inz(bFalse) like(isUpdKey);
dcl-s yScreenNbr like(int4_t) inz;
dcl-s yIsLower char(1) inz(bFalse);

dcl-ds yCursorPosition likeds(cursorPosition_t) inz;

dcl-s yCvtCcsid char(1) inz(bTrue);
dcl-s yData char(512) inz;

dcl-ds yRetFile likeds(qObj_t);

dcl-s yRtnCode char(1) inz;

dcl-s yField like(srchField) inz;
dcl-s yOperation like(srchOP) inz;
dcl-s yArgument like(srchArg) inz;
dcl-s ySign like(srchSign) inz;
dcl-s ySrchNbrs like(srchNbrs) inz(0);
dcl-s ySrchType like(srchType) inz;
dcl-s ySrchCase like(srchCase) inz(bFalse);

dcl-s yBuffer like(rcdBuf_t) inz;
dcl-ds *n;
  yHexString like(hexBuf_t);
  yOutBuffer like(rcdBuf_t) overlay(yHexString: 1);
end-ds;

dcl-s yOutBuffLn like(int4_t) inz;
dcl-s yTgtValue char(10) inz;

dcl-s yKeyVal like(keyBuf_t) inz;

dcl-s yPgmCmd char(10) inz;
dcl-s yCmdDta like(pgmCmdDt_t) inz;

dcl-s yFKeys char(18) dim(32) inz;
dcl-s yNbrOfKeys like(int4_t) inz;

dcl-s yChoice like(choice_t) dim(32) inz;
dcl-s yNbrOfCh like(int4_t) inz;

dcl-s yFlag inz(*zeros) like(int4_t);

dcl-s buffIdx like(int4_t) inz;

dcl-ds shortCmd likeds(shortCmd_t) inz;
dcl-s yExecCmd like(cmdBuffer_t) inz;
dcl-s yNbrOfEnt like(int4_t) inz;
dcl-s ySqlWhere like(sqlWhere_t) inz;
dcl-s ySqlOrder like(sqlOrder_t) inz;
dcl-s yAlwLc char(1) inz;
dcl-s yCase char(1) inz;
dcl-s yRcdLock char(1) inz;
dcl-s yNullDft char(1) inz;
dcl-s yKeepCrs char(1) inz;
dcl-s yEnvFile like(file_t) inz;
dcl-s yEnvLib like(lib_t) inz;
dcl-s yEnvMbr like(mbr_t) inz;
dcl-s yIsAutoSave like(bool_t) inz(bFalse);
dcl-s yOption like(option_t) inz;
dcl-s yText like(text_t);
dcl-s ySflOpt char(2);
dcl-s yString like(rcdBuf_t) inz;
dcl-s yStringLen like(int4_t) inz;

dcl-c HEX_CHAR '-';

dcl-s isReadSfl like(bool_t) inz(bFalse);
dcl-s isPBINIT char(1) inz(bFalse);
dcl-s isFirstSfl char(1) inz(bFalse);
dcl-s isFileChg char(1) inz(bFalse);
dcl-s isTblCol char(1) inz(bFalse);
dcl-s isTargetOK like(bool_t) inz(bFalse);
dcl-s isSeqNbrOK like(bool_t) inz(bFalse);
dcl-s isOpen like(bool_t) inz(bFalse);
dcl-s isUpdMod like(bool_t) inz(bFalse);
dcl-s isUpdKey like(bool_t) inz(bFalse);
dcl-s isVisible like(bool_t) inz(bFalse);
dcl-s isError like(bool_t) inz(bFalse);
dcl-s isFileError char(1) inz(bFalse);
dcl-s isKeyAvail char(1) inz(bFalse);
dcl-s isKeyChg char(1) inz(bFalse);
dcl-s isSflDirty char(1) inz(bFalse);
dcl-s isTryed char(1) inz(bFalse);
dcl-s isPinned char(1) inz(bFalse);
dcl-s isPinModeR char(1) inz(bFalse);
dcl-s isPinModeC char(1) inz(bFalse);
dcl-s isPinOK char(1) inz(bFalse);
dcl-s isPinRmv char(1) inz(bFalse);
dcl-s isEOF char(1) inz(bFalse);
dcl-s queryUser like(sfl_cmd) inz(*allx'00');
dcl-s isFound char(1) inz(bFalse);
dcl-s isCmdErr char(1) inz(bFalse);
dcl-s isCancel char(1) inz(bFalse);
dcl-s r#IsCmdErr char(1) inz(bFalse);
dcl-s isCvtChar char(1) inz(bFalse);
dcl-s isPinToClr char(1) inz(bTrue);
dcl-s isReadC char(1) inz(bFalse);
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

dcl-s sflPage like(int4_t) inz;
dcl-s sflRec080 inz(0) like(sflPage);
dcl-s sflRec132 inz(0) like(sflPage);
dcl-s sflNbrRcd inz(0) like(sflPage);
//  Anzahl gepinnter Zeilen in der Subfile (pbPinRcd)
dcl-s sflPinRows inz(0) like(sflPage);
dcl-s sflMaxRowLen like(int4_t) inz;
dcl-s sflDataLenFree like(int4_t) inz;
dcl-s sfTop like(int4_t) inz;
dcl-s sfBot like(int4_t) inz;
dcl-s sfl_cmd char(10) inz;
dcl-s sflHeadLRw inz(0) like(sflPage);
dcl-s sflFirstRw inz(0) like(sflPage);
dcl-s sflLastRw inz(0) like(sflPage);
dcl-s sflLeftOfs like(int4_t) inz;
dcl-s sflMode char(10) inz;
dcl-s sflPinRnge like(int4_t) inz;

dcl-c COPYRIGHT '1997-2026, Thomas Raddatz - PEEK v4.1.2';
dcl-c RELEASE 'Stand: 09.11.2026';
dcl-c Version 'V04R01M02';

dcl-s l#File like(##file) inz;
dcl-s l#Library like(##library) inz;
dcl-s l#Member like(##member) inz;
dcl-s l#Format like(##format) inz;
dcl-s l#MaxSeq like(f_seq) inz(0);
dcl-s l#MinSeq like(f_seq) inz(0);
dcl-s l#WndNbr like(##wndNbr) inz(0);

dcl-s r#Size like(int4_t) inz;

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

dcl-s colrOfs like(int4_t);
dcl-s col_field char(10) dim(60);
dcl-s col_scnStr like(int4_t) dim(60);
dcl-s col_scnEnd like(int4_t) dim(60);
dcl-s col_error like(bool_t) dim(60) inz(bFalse);
dcl-s cp like(int4_t);
dcl-s fldStrPos like(int4_t);

dcl-s headLen like(int4_t);
dcl-s fieldLen like(int4_t);
dcl-s maxColLen like(int4_t);
dcl-s columnLen like(int4_t);

dcl-s pinCol_x like(int4_t);
dcl-c max_pin_col %elem(pinTabCol);
dcl-s pinTabCol like(fieldNme_t) dim(12);
//  Rückgabe des Pin-Dialogs (PEEK50): clrpincol löscht pinTabCol
dcl-s yPinTabCol like(fieldNme_t) dim(12);
dcl-s nbrPinCol like(int4_t);
//  Anzahl der angezeigten gepinnten Spalten (cntPinShown)
dcl-s nbrPinShown like(int4_t);

dcl-s pinRcd_x like(int4_t);
//  Schleifenindex von pbPinRcd (pinRcd_x setzt auch chkPinRcd)
dcl-s pinShow_x like(int4_t);
dcl-c max_pin_rcd %elem(pinTabRcd);
dcl-s pinTabRcd like(pinTabR_t) dim(12);
dcl-s nbrPinRcd like(int4_t);

dcl-ds pinTabRcdE likeds(pinTabR_t);

//  Letzte Satzkennung von setRcdId: f_basedPF ruft PEEK41 auf
//  und wird nur bei einer geänderten Satzkennung aufgerufen
dcl-ds rcdIdCache qualified;
  file    like(file_t);
  lib     like(lib_t);
  mbr     like(mbr_t);
  rcdFmt  like(rcdFmt_t);
  mbrNbr  like(mbrNbr_t);
  pFile   like(file_t);
  pLib    like(lib_t);
  pMbr    like(mbr_t);
  pRcdFmt like(rcdFmt_t);
end-ds;

//  Arbeitsfelder
dcl-s x like(int4_t);
dcl-s y like(int4_t);
dcl-s z like(int4_t);
dcl-s a1 char(1) inz;

//  Arbeitsfeld für Sortierfolge: Satzfolge/Schlüsselfolge
//  .. aktuelle Sortierung
dcl-s accessMode char(1) inz(RRN_SEQ);
//  .. neue Sortierung für ChangeFile
dcl-s newAccessMode char(1) inz(RRN_SEQ);
//  .. Sortierung vor SQl-Mode
dcl-s oldAccMode char(1) inz(RRN_SEQ);
//  Arbeitsfeld für Befehlsverarbeitung, Verhinderung von Rekursionen
dcl-s r#PgmCmd like(yPgmCmd) inz;
//  Arbeitsfeld für Eingabe Aufsetzkey
dcl-s r#RcdNbr like(##rcdNbr) inz(0);
dcl-s r#KeyVal like(##key) inz;
//  Arbeitsfeld für PIN-Funktion
dcl-s pin#Field char(10) inz;
//  Datensatz-Nr für SETLL und SETGG zum füllen der Subfile
dcl-s wrk#ReadDn like(sflPage) inz(0);
dcl-s wrk#RcdNbr like(rcdNbr_t) inz(0);
dcl-ds *n;
  wrk#KeyVal like(keyBuf_t) inz;
end-ds;
//  ...
dcl-s wrk#Field inz like(f_field);
dcl-s wrk#SeqNbr inz(0) like(f_seq);
dcl-s wrk#Recno inz(0) like(sflRec132);
dcl-s wrk#SFPAU inz like(sfpau);
//  Umschalten der Sortierung
dcl-s last#RcdNr like(rcdNbr_t) inz(0);
//  Farbattribute einsetzen
dcl-s wrk#Ofs like(int4_t) inz;
//  Felder für Suchfunktion
dcl-s srchMode char(10) inz('*NEW');
dcl-s srchFndRcd like(rcdNbr_t) inz(0);
dcl-s srchField char(10) inz;
dcl-s srchOP char(10) inz;
dcl-s srchArg char(63) inz;
dcl-s srchSign char(1) inz;
dcl-s srchArgFloat float(8) inz;
dcl-s srchArgVal zoned(63) inz;
dcl-c cSRCHARG_DIGITS %len(srchArgVal);

dcl-c cSRCHARG_DECPOS %decpos(srchArgVal);

dcl-s srchLikeTp like(int4_t) inz;
dcl-s srchLikeLn like(int4_t) inz;
dcl-s srchNbrs packed(10) inz(0);
dcl-s srchType char(10) inz;
dcl-s srchCase char(1) inz(bFalse);
dcl-s srchCmpStr like(srchArg) inz;
dcl-s srchCmpVal like(srchArgVal) inz(0);
dcl-c srch_cmp_val_length %len(srchCmpVal);

dcl-c srch_cmp_val_decpos %decpos(srchCmpVal);

dcl-s srchCmpFloat float(8) inz(0);
dcl-s srchCmpRcd like(rcdBuf_t) inz;
dcl-s srchCount like(srchNbrs) inz(0);
dcl-s srchCount2 like(srchNbrs) inz(0);
dcl-s srchDspMsg like(srchNbrs) inz(0);
dcl-s srchIsNum char(1) inz(bFalse);
dcl-s srchArgIsFloat char(1) inz(bFalse);

//  Felder für Kopierfunktion
dcl-ds copyExternal qualified;
  file    char(10) inz;
  lib     char(10) inz;
  toMbr   char(10) inz;
  mbrOpt  char(10) inz;
  crtFile char(10) inz;
end-ds;

//  Überlagern von ##key132uc mit ##key80uc
dcl-s ##key like(##key132uc) inz;
dcl-ds *n;
  ##key132uc char(116);
  ##key80uc  char(67) overlay(##key132uc: 1);
end-ds;
dcl-ds *n;
  ##key132Lc char(116);
  ##key80Lc  char(67) overlay(##key132Lc: 1);
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
  wndNbr  like(##wndNbr);
  strPage like(##strPage);
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

exsr first;

dow ('1');

  //  Ermitteln der Feldnummer des ersten
  //  sichtbaren Feldes
  exsr getFrstFld;

  //  Öffnen/Schützen "Feldseite"
  if (set0010.set_fldpge = '1');
    *in72 = '0';
  else;
    *in72 = '1';
  endif;

  //  Öffnen/Schützen "Aufsetzschlüssel/Satznummer"
  if (accessMode = SQL_SEQ);
    *in73 = '1';
  else;
    *in73 = '0';
  endif;

  //  Öffnen/Schützen Dateiauswahlfelder ...
  //  ... ##library
  if (auth.isChgLibAlw = bTrue);
    *in74 = *off;
  else;
    *in74 = *on;
  endif;
  //  ... ##file
  if (auth.isChgFileAlw = bTrue);
    *in75 = *off;
  else;
    *in75 = *on;
  endif;
  //  ... ##member
  if (auth.isChgMbrAlw = bTrue);
    *in77 = *off;
  else;
    *in77 = *on;
  endif;

  //  Eingabe der Schlüsselfelder in Gross- oder Kleinbuchstaben
  if (isKeyLower = bFalse);
    *in78 = *off;
    ##key132uc = ##key;
  else;
    *in78 = *on;
    ##key132Lc = ##key;
  endif;

  //  Prüfen Positionierung der Subfile
  if (sfsanr <= 0);
    sfsanr = nbrPinRcd + 1;
  endif;
  if (sfsanr > sflNbrRcd);
    sfsanr = sflNbrRcd;
  endif;

  //  Für Prüfung: Eingabe neuer Aufsetzkey
  r#RcdNbr = ##rcdNbr;
  r#KeyVal = ##key;

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgCtl;

  //  "Keine Sätze ..."
  if (*in80 = *off);
    write pbleer;
  endif;

  //  Anzeigen der Einzelauswahlen
  if (sfTop > 32
      or sfTop > yNbrOfCh);
    sfTop = 1;
  endif;
  $$choice = yChoice(sfTop);

  //  Anzeigen der Befehlstasten
  select;
  when (sfBot = 2 and yNbrOfKeys > 8);
    if (*in88 = bFalse);
      write pbbot132#2;
    else;
      write pbbot080#2;
    endif;
  when (sfBot = 3 and yNbrOfKeys > 16);
    if (*in88 = bFalse);
      write pbbot132#3;
    else;
      write pbbot080#3;
    endif;
  when (sfBot = 4 and yNbrOfKeys > 24);
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
    sfBot = 1;
  endsl;

  //  Merken Startseite innerhalb des Feldes
  b4.wndNbr = ##wndNbr;
  b4.strPage = ##strPage;

  //  Anzeige der Subfile
  if (*in88 = bFalse);
    exfmt pbctl132;
  else;
    exfmt pbctl080;
  endif;

  //  Übernehmen Schlüsselfelder
  if (isKeyLower = bFalse);
    ##key = ##key132uc;
  else;
    ##key = ##key132Lc;
  endif;

  //  Berechnen Zeile/Spalte
  cursorPosition.row = workstn.csrPos / 256;
  cursorPosition.column = %rem(workstn.csrPos: 256);

  //  Löschen der Cursorposition
  csrRow = 0;
  csrCol = 0;

  //  Merker für aktualisieren der Subfile
  isSflDirty = bFalse;

  //  Merker für abfragen der Zieldatei
  isTargetOK = bFalse;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Cursor-Pos. löschen
  *in87 = '0';

  //  Aktuelle Satz-Nr.
  sfsanr = sflCsr;

  //  Suchmodus
  if (yPgmCmd <> '*SEARCH');
    srchMode = '*NEW';
    srchFndRcd = 0;
  endif;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
  if (yMsgID <> *blanks);
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
  else;
    //  Abfragen der Programmbefehle
    exsr doScreenCmd;
    if (yPgmCmd = '*EXIT' or yPgmCmd = '*CANCEL');
      leave;
    endif;
    if (isCmdErr = bTrue);
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
    endif;
  endif;

  //  ... Subfile aktualisieren
  if (isSflDirty = bTrue);
    exsr pbRefresh;
  endif;

  //  ... Offene Datei aktualisieren
  exsr getOpnFile;

enddo;

*inlr = '1';

//============================================================*
//    DoScrnCmd     Ausführen Bildschirmbefehl                *
//============================================================*

begsr doScreenCmd;

  //  Sicherstellen, dass die Startseite innerhalb eines Feldes
  //  immer gefüllt ist:

  //  Verwenden der alten Werte bei F5
  if (yPgmCmd = '*REFRESH');
    ##wndNbr = b4.wndNbr;
    ##strPage = b4.strPage;
  else;

    //  Positionieren auf Feldanfang bei Wechsel des Startfeldes
    if (##wndNbr <> b4.wndNbr
        and ##strPage = b4.strPage);
      ##strPage = 1;
    endif;

  endif;

  //  Verwenden der alten Startposition von vor der Bildschirmausgabe
  if (##strPage = *zeros);
    ##strPage = b4.strPage;
  endif;

  //  Sicherstellen, dass das Feld gefüllt ist
  if (##strPage = *zeros);
    ##strPage = 1;
  endif;

  //  Verarbeiten Bildschirmereignis
  r#PgmCmd = yPgmCmd;
  //   exsr doPgmCmd;
/copy QCOPYLE,DOPGMCMD
  r#PgmCmd = '';

endsr;

//============================================================*
//    DoSflCmd      Ausführen Subfilebefehl                   *
//============================================================*

begsr doSflCmd;

  if (yPgmCmd = r#PgmCmd);
    isCmdErr = bTrue;
    clear usr8144;
    usr8144.var1 = yPgmCmd;
    p_sndPgmMg('USR8144': usr8144: sds.pgmName);
  else;
  //      exsr doPgmCmd;
/copy QCOPYLE,DOPGMCMD
  endif;

endsr;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  //  Löschen der Cursor-Position ...
  exsr dltCsrPos;

  //  Datei hat gewechselt ...
  if (((##file    <> l#File) and
      (not f_endsWith('*': %trim(##file))) and
      (%trim(##file  ) <> set0008.set_prmt)) or
      (##library  <> l#Library      ) or
      ((##member  <> l#Member) and
      (%trim(##member) <> set0008.set_prmt)) or
      ((##format  <> l#Format) and
      (%trim(##format) <> set0008.set_prmt)));
    *in93 = '1';
  else;

    //  Abfragen Prompt?
    //  ... ##file
    if (%trim(##file) = set0008.set_prmt or
        f_endsWith('*': %trim(##file)));
      exsr c_prompt;
      if (*in93 = '0');
        leavesr;
      endif;
    endif;
    //  ... ##member
    if (%trim(##member) = set0008.set_prmt);
      exsr c_prompt;
      if (*in93 = '0');
        leavesr;
      endif;
    endif;
    //  ... ##format
    if (%trim(##format) = set0008.set_prmt);
      exsr c_prompt;
      if (*in93 = '0');
        leavesr;
      endif;
    endif;
    //  ... ##field
    if (%trim(##field ) = set0008.set_prmt);
      exsr c_prompt;
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

    //  Prüfen Seq-Bereich (##wndNbr) ...
    exsr chkSeqRnge;

    //  Wechsel des Fenster (##field) ...
    exsr changeWnd;

    //  Wechsel des Aufsetzkeys ...
    exsr changeKey;

    //  Füllen der Subfile ...
    if (isFileChg = bTrue);
      exsr dltCsrPos;
      exsr c_top;
    else;
      if (isKeyChg = bFalse);
        exsr pbRefresh;
      else;
        exsr dltCsrPos;
        exsr keyHasChg;
      endif;
    endif;

  endif;

endsr;

//============================================================*
//    c_readSfl     Lesen & Verarbeiten der Subfile-Auswahlen *
//============================================================*

begsr c_readSfl;

  //  Merker für: Subfile gelöscht zurück setzen
  //              abbrechen READC, wenn Subfileinhalt
  //              gelöscht worden ist über PBINIT
  isPBINIT = bFalse;
  //  Merker für: Programmablauf innerhalb der READC-Schleife
  //              verhindern einer Rekursion über
  //              C_ENTER, C_PAGEUP, C_PAGEDOWN
  isReadSfl = bTrue;

  r#IsCmdErr = isCmdErr;

  //  Mindestens 1 Eintrag verarbeitet ...
  isReadC = bFalse;

  if (*in80 = *off);
  //           Keine Einträge vorhanden
  else;

    dou (queryUser = *allx'00');

      queryUser = *allx'00';

      //  Lesen, solange bis keine zu verarbeitenden
      //  Sätze mehr da sind, oder bis durch einen
      //  Kurzbefehl (SFPAU) die Subfile neu auf-
      //  gebaut worden ist.
      dow (isPBINIT = bFalse);

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
          sflCsr = sflRec132;
        else;
          sflCsr = sflRec080;
        endif;

        //  Linksbündig setzen ...
        sfpau = %triml(sfpau);

        //  Prompt ...
        if (%trim(sfpau) = set0008.set_prmt);
          exsr pmt_sfpau;
        endif;

        //  Zuordnung AUSWAHL => Befehl ...
        peek21('#' + sfpau: sds.pgmName
              : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
        if (yMsgID <> *blanks);
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

        sfl_cmd = yPgmCmd;

        //  Vorrangig Blockverarbeitung (F22)
        //  verarbeiten ...
        if (queryUser <> *allx'00' and sfl_cmd <> queryUser);
          exsr pbSflChain;
          if (%found());
            *in84 = '1';
            exsr pbSflUpdate;
          endif;
          iter;
        endif;

        //  Verarbeiten der Befehle ...
        exsr doSflCmd;
        if (isCmdErr = bTrue);
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
        if (yPgmCmd <> '*NONE');
          isReadC = bTrue;
        endif;

        //  Verarbeitung auswerten ...
        exsr pbSflChain;
        if (%found());
          //  ... Abbruch mit F3/F12
          if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
            *in84 = '1';
          else;
            //  ... Verarbeitung durchgeführt
            *in84 = '0';
            *in85 = '0';
            sfpau = '';
          endif;
          exsr pbSflUpdate;
          if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
            leave;
          endif;
        endif;

      enddo;

    enddo;

  endif;

  isCmdErr = r#IsCmdErr;
  isReadSfl = bFalse;

  if (isReadC = bTrue);
    exsr getObjAttr;
    exsr getMbrAttr;
  endif;

endsr;

//============================================================*
//    PBSflChain    CHAIN auf PBSFL                           *
//============================================================*

begsr pbSflChain;

  if (*in88 = *off);
    chain sflRec132 pbsfl132;
  endif;
  if (*in88 = *on);
    chain sflRec080 pbsfl080;
  endif;

  if (%found());
  //  ... alles in Ordnung
  else;
    //  ... letzte Nachricht löschen
    p_rmvPgmMg(sds.pgmName);
  endif;

endsr;

//============================================================*
//    pbSflWrite    WRITE auf PBSFL                           *
//============================================================*

begsr pbSflWrite;

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
//    c_pageUp      PgUp - Vorwärts blättern                  *
//============================================================*

begsr c_pageUp;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    //  Verarbeiten der Subfile-Auswahlen
    if (isReadSfl = bTrue);
    //       verhindern einer Rekursion
    else;
      exsr c_readSfl;
    endif;

    //  Blättern
    exsr pbInit;
    exsr pbPinRcd;
    exsr pbReadUp;

    //  Keine weiteren Einträge gefunden ...
    if (*in80 = *off);
      //  ... Ende der Liste anzeigen
      exsr c_bot;
    endif;

  endif;

endsr;

//============================================================*
//    c_pageDown    PgDn - Rückwärts blättern                 *
//============================================================*

begsr c_pageDown;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    //  Verarbeiten der Subfile-Auswahlen
    if (isReadSfl = bTrue);
    //       verhindern einer Rekursion
    else;
      exsr c_readSfl;
    endif;

    //  Blättern
    sflCsr = nbrPinRcd + 1;
    exsr pbReadCsr;
    exsr pbReadDown;

    exsr pbInit;
    exsr pbPinRcd;
    exsr pbReadUp;

  endif;

endsr;

//============================================================*
//    c_endPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endPgm;

  // - Speichern der Arbeitsumgebung
  if (i_envSave = bTrue);
    yIsAutoSave = bTrue;
    exsr saveEnv;
  endif;

  exsr closeFile;
  if (isOpen = bFalse);

    // - Benutzervoreinstellungen
    exsr setUsrSetg;

    // - Endenachricht
    p_rmvPgmMg(sds.pgmName);

    clear usr8100; // Verarbeitung abgebrochen
    usr8100.var1 = yPgmCmd;
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
//    c_prompt      F4  - Prompt                              *
//============================================================*

begsr c_prompt;

  if (isOpen = bFalse);

    select;
    when ((scnFld   = '##FILE'  ) or
       (##file   = set0008.set_prmt  ) or
       (f_endsWith('*': %trim(##file))));
      exsr pmt_file;
    when ((scnFld   = '##MEMBER') or
       (##member = set0008.set_prmt  ));
      exsr pmt_mbr;
    other;
      //      Nix tun, keine Datei vorhanden
      exsr msgNoFile;
    endsl;

  else;

    select;
    when ((scnFld   = '##FIELD ') or
       (##field  = set0008.set_prmt  ));
      exsr pmt_field;
    when ((scnFld   = '##FILE'  ) or
       (##file   = set0008.set_prmt  ) or
       (f_endsWith('*': %trim(##file))));
      exsr pmt_file;
    when ((scnFld   = '##MEMBER') or
       (##member = set0008.set_prmt  ));
      exsr pmt_mbr;
    when ((scnFld   = '##FORMAT') or
       (##format = set0008.set_prmt  ));
      exsr pmt_fmt;
    when ((scnFld   = 'SFPAU'   ) or
       (sfpau    = set0008.set_prmt  ));
      exsr pmt_sfpau;
    other;
      p_sndPgmMg('USR8179': '': sds.pgmName);
    endsl;

  endif;

  exsr keepCsrPos;

endsr;

//============================================================*
//    pmt_field     Prompt - Field                            *
//============================================================*

begsr pmt_field;

  peek37(set0001.set_dsp80: COPYRIGHT: yField
        : yMsgID: yMsgDta);

  if (yMsgID = *blanks);
    ##field = yField;
    *in93 = '1';
  else;
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    *in93 = '0';
  endif;

endsr;

//============================================================*
//    pmt_file      Prompt - File                             *
//============================================================*

begsr pmt_file;

  //  Wenn das Feld gesperrt ist, ...
  if (*in75 = *on);
    //  ... dann
    //      ausgeben Meldung
    p_sndPgmMg('USR8179': '': sds.pgmName);
  else;
    //  ... sonst
    //      aufrufen "Auswahl Datei"
    if (##file = *blanks
        or ##file = set0008.set_prmt);
      yFile = '*ALL';
    else;
      yFile = ##file;
    endif;

    if (##library = *blanks);
      yLibrary = '*LIBL';
    else;
      yLibrary = ##library;
    endif;

    peek69(set0001.set_dsp80: COPYRIGHT: yQFile
          : yMsgID: yMsgDta);

    if (yMsgID = *blanks);
      ##file = yFile;
      ##library = yLibrary;
      *in93 = '1';
    else;
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
      *in93 = '0';
    endif;

  endif;

endsr;

//============================================================*
//    pmt_mbr       Prompt - Member                           *
//============================================================*

begsr pmt_mbr;

  //  Wenn das Feld gesperrt ist, ...
  if (*in77 = *on);
    //  ... dann
    //      ausgeben Meldung
    p_sndPgmMg('USR8179': '': sds.pgmName);
  else;
    //  ... sonst
    //      aufrufen "Auswahl Teildatei"
    yFile = ##file;

    if (##library = *blanks);
      yLibrary = '*LIBL';
    else;
      yLibrary = ##library;
    endif;

    peek47(set0001.set_dsp80: COPYRIGHT
          : yQFile: yMember: yMsgID: yMsgDta);

    if (yMsgID = *blanks);
      ##member = yMember;
      *in93 = '1';
    else;
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
      *in93 = '0';
    endif;

  endif;

endsr;

//============================================================*
//    pmt_fmt       Prompt - Format                           *
//============================================================*

begsr pmt_fmt;

  peek12(set0001.set_dsp80: COPYRIGHT: ##format
        : MODE_INTER
        : rcdl0200: yFmtNbr: yMsgID: yMsgDta);

  if (yMsgID = *blanks);
    ##fmtNbr = yFmtNbr;
    ##format = rcdl0200.r2FmtName;
    $$length = rcdl0200.r2RcdLen;
    *in93 = '1';
  else;
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    *in93 = '0';
  endif;

endsr;

//============================================================*
//    pmt_sfpau     Prompt - Subfileauswahl                   *
//============================================================*

begsr pmt_sfpau;

  peek68(set0001.set_dsp80: sds.pgmName: COPYRIGHT
        : ySflOpt: yMsgID: yMsgDta);

  //  Einlesen Subfiledatensatz
  sflRec132 = sflCsr;
  sflRec080 = sflCsr;
  exsr pbSflChain;

  //  Abbruch mit F3/F12
  if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
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

  if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
  else;
    if (*in88 = bFalse);
      write pbctl132;
    else;
      write pbctl080;
    endif;
  endif;

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    //      ... aktualisieren "offene Datei"
    exsr getOpnFile;

    //      ... aktualisieren Subfile
    exsr pbRefresh;

    //      ... abrufen der Objektattribute
    exsr getObjAttr;

    //      ... abrufen der Anzahl Teildateien
    exsr getNbrMbr;

    //      ... abrufen der Teildateiattribute
    exsr getMbrAttr;
  endif;

  //      ... positionieren Cursor
  if (sflCsr = 0);
    exsr c_posCsr;
  endif;

endsr;

//============================================================*
//    c_add         F6  - Neuanlage eines Datensatz           *
//============================================================*

begsr c_add;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    if (isUpdMod = bFalse);
      //      Neuanlage nicht möglich, da INPUT-Modus
      clear usr0007;
      usr0007.var1 = ##file;
      usr0007.var2 = ##library;
      p_sndPgmMg('USR0007': usr0007: sds.pgmName);
    else;

      yFunction = '*ADD';
      exsr callUpdPgm;

      //  Ermitteln Objektattribute
      exsr getObjAttr;

      //  Ermitteln der Teildateiattribute (Anzahl Sätze)
      exsr getMbrAttr;

    endif;
  endif;

endsr;

//============================================================*
//    c_chgHead     F7  - Umschalten der Überschrift          *
//============================================================*

begsr c_chgHead;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    set0001.set_hedTyp = f_nextHeaderType(set0001.set_hedTyp);

    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    c_tgMrkCol    F8  - Spalte markieren ein/aus            *
//============================================================*

begsr c_tgMrkCol;

  if (isOpen = bFalse);
    // Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getFldTMrk;

    if (wrk#Field <> '');
      isSflDirty = bTrue;

      // Umschalten der Farbe im Datensatz ...
      clear f_key;
      f_key.f_field = col_field(x);
      chain(n) %kds(f_key) fpeekfld;
      if (%found(peekFld));
        if (f_markCol = bFalse);
          exsr c_mrkCol;
        else;
          exsr c_unMrkCol;
        endif;
      else;
      // Datensatz nicht gefunden
      endif;
    endif;

    // Beibehalten der Cursorposition ...
    exsr keepCsrPos;
  endif;

endsr;

//============================================================*
//    c_mrkCol      F8  - Spalte markieren ein                *
//============================================================*

begsr c_mrkCol;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getFldTMrk;

    if (wrk#Field <> '');
      isSflDirty = bTrue;

      //  Einschalten der Farbe im Datensatz ...
      clear f_key;
      f_key.f_field = col_field(x);
      chain %kds(f_key) fpeekfld;
      if (%found(peekFld));
        f_markCol = bTrue;
        update fpeekfld;
      else;
      //        Datensatz nicht gefunden
      endif;
    endif;

    //  Beibehalten der Cursorposition ...
    exsr keepCsrPos;
  endif;

endsr;

//============================================================*
//    c_unMrkCol    F8  - Spalte markieren aus                *
//============================================================*

begsr c_unMrkCol;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getFldTMrk;

    if (wrk#Field <> '');
      isSflDirty = bTrue;

      //  Ausschalten der Farbe im Datensatz ...
      clear f_key;
      f_key.f_field = col_field(x);
      chain %kds(f_key) fpeekfld;
      if (%found(peekFld));
        f_markCol = bFalse;
        update fpeekfld;
      else;
      //        Datensatz nicht gefunden
      endif;
    endif;

    //  Beibehalten der Cursorposition ...
    exsr keepCsrPos;
  endif;

endsr;

//============================================================*
//    c_moveTop     F9  - Selektieren Datensatz               *
//============================================================*

begsr c_moveTop;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getSflRcd;

    if (sflCsr > 0);

      exsr pbReadCsr;
      exsr pbInit;
      exsr pbPinRcd;
      exsr pbReadUp;
      sfsanr = nbrPinRcd + 1;

    else;
      //  Fehlermeldung ...
      p_sndPgmMg('USR8102': '': sds.pgmName);
    endif;

  endif;

endsr;

//============================================================*
//    c_posCsr      F10    - Cursor auf Keyeingabe pos.       *
//============================================================*

begsr c_posCsr;

  *in87 = '1';

endsr;

//============================================================*
//    c_userSetg    F11    - Benutzervoreinstellugnen         *
//============================================================*

begsr c_userSetg;

  monitor;
    peek24(set0001.set_dsp80: COPYRIGHT: set0001
          : yMsgID: yMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = *on);
  //            Fehler aufgetreten
  else;
    if (yMsgID = 'USR8112'); // Verarbeitung bestätigt.
      p_updUsrSg('*DSPATTR' : set0001);
      exsr c_refresh;
    else;
    //            Verrabeitung durch Benutzer
    //            abgebrochen
    endif;
  endif;

endsr;

//============================================================*
//    c_repeat      F13 - Wiederholen der Subfileauswahl      *
//============================================================*

begsr c_repeat;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    //  "Keine Sätze ..."
    if (sflNbrRcd = 0);
    //  Keine Datensätze vorhanden.
    else;

      //  Ermitteln der letzten Subfile-Auswahl ...
      exsr getLastOpt;
      if (isError = bTrue);
        //  Fehlermeldung ...
        p_sndPgmMg('USR8165': '': sds.pgmName);
      else;

        //  "Reaktivieren" der letzten Subfileauswahl ...
        sflRec132 = wrk#Recno;
        sflRec080 = wrk#Recno;
        exsr pbSflChain;
        *in84 = '1'; // SFLNXTCHG
        exsr pbSflUpdate;
        //  Verarbeitung ...
        wrk#Recno = wrk#Recno + 1;
        exsr repeatOpt;
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    c_layout      F15    - Layout                           *
//============================================================*

begsr c_layout;

  monitor;
    peek34(set0001.set_dsp80: COPYRIGHT: '*DISPLAY'
          : yMsgID: yMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (yMsgID = 'USR8112'); // Verarbeitung bestätigt.
    //  Beenden und Speichern ...
    //  Merker für aktualisieren der Subfile
    isSflDirty = bTrue;
  else;
  //  Abbruch durch Benutzer ...
  endif;

endsr;

//============================================================*
//    c_search      F16    - Suchfunktion                     *
//============================================================*

begsr c_search;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    select;
    when (srchMode = '*NEW');
      monitor;
        peek17(set0001.set_dsp80: COPYRIGHT
              : yQFile: ##member
              : yField: yOperation: yArgument
              : ySign: ySrchNbrs: ySrchType
              : ySrchCase: yMsgID: yMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

      if (*in99 = *off);
        if (yMsgID = 'USR8112'); // Verarbeitung bestätigt.
          //  Suchen & pinnen nur bei Dateien mit einer Basisdatei
          //  (wie Auswahl P in s_pinRcd)
          if (ySrchType = '*PINROW' and
              f_numBased(##file: ##library: ##member) > 1);
            clear usr8218;
            p_sndPgmMg('USR8218': usr8218: sds.pgmName);
          else;
            exsr srchStart;
          endif;
        else;
          p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
          yMsgID = '';
          yMsgDta = '';
        endif;
      else;
      //  Fehler beim Aufruf von PEEK17 ...
      endif;

    when (srchMode = '*FOUND');
      exsr srchCont;

    when (srchMode = '*MAXIMUM');
      exsr srchContM;

    when (srchMode = '*EOF');
      exsr srchEOF;

    other;
    //               ???????????
    endsl;

    //  Gefunden?
    if (srchMode = '*FOUND');
      srchFndRcd = file#X.rcdNbr;
      exsr pbReadP;
    else;
      exsr pbReadDown;
    endif;

    //  Anzeigen der Subfile
    exsr pbInit;
    exsr pbPinRcd;
    exsr pbReadUp;

    //  Meldung
    select;
    when (srchMode = '*FOUND');
      p_sndPgmMg('USR8130': '': sds.pgmName);
    when (srchMode = '*EOF');
      p_sndPgmMg('USR8131': '': sds.pgmName);
    when (srchMode = '*MAXIMUM');
      p_sndPgmMg('USR8132': '': sds.pgmName);
    other;
    endsl;

  endif;

endsr;

//============================================================*
//    c_top         F17 - Anfang der Datei                    *
//============================================================*

begsr c_top;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr pbMoveTop;
    exsr pbInit;
    exsr pbPinRcd;
    exsr pbReadUp;

    sfsanr = nbrPinRcd + 1;
  endif;

endsr;

//============================================================*
//    c_bot         F18 - Ende der Datei                      *
//============================================================*

begsr c_bot;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr pbMoveBot;
    exsr pbInit;
    exsr pbPinRcd;
    exsr pbReadDown;
    exsr pbReadUp;

    sfsanr = sflNbrRcd;
  endif;

endsr;

//============================================================*
//    c_moveL       F19 - Nach links verschieben              *
//============================================================*

begsr c_moveL;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    if (##strPage > 1);
      if (set0010.set_scroll = '*BOTH'
          or set0010.set_scroll = '*LEFT');
        ##strPage = ##strPage - 1;
      else;
        ##strPage = 1;
        exsr prvWndNbr;
      endif;
    else;
      exsr prvWndNbr;
      if (set0010.set_scroll = '*BOTH'
          or set0010.set_scroll = '*LEFT');
        ##strPage = *hival;
      else;
        ##strPage = 1;
      endif;
    endif;

    exsr chkSeqRnge;

    exsr pbRefresh;
  endif;

endsr;

//============================================================*
//    c_moveR       F20 - Nach rechts verschieben             *
//============================================================*

begsr c_moveR;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    //  Nur eine verschiebbare Spalte angezeigt, die nicht ganz
    //  sichtbar ist? (gepinnte Spalten stehen vorn in col_field)
    exsr cntPinShown;
    if ((cp - nbrPinShown = 1) and
        (col_error(cp) = bTrue));
      if ((set0010.set_scroll = '*BOTH') or
         (set0010.set_scroll = '*RIGHT'));
        ##strPage = ##strPage + 1;
      else;
        ##wndNbr = ##wndNbr + 1;
        ##strPage = 1;
      endif;
    else;
      ##wndNbr = ##wndNbr + 1;
      ##strPage = 1;
    endif;

    exsr chkSeqRnge;
    exsr pbRefresh;
  endif;

endsr;

//============================================================*
//    C_PageL       F19 - Nach links verschieben,             *
//                  ganze Seite                               *
//============================================================*

begsr c_pageLeft;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
    leavesr;
  endif;

  //  Prüfen "Seite innerhalb des Feldes"
  if (##strPage > 1);
    ##strPage = ##strPage - 1;
  else;

    //  Bereits am Anfang
    if (##wndNbr = l#MinSeq
        and ##strPage = 1);
    else;

      //  Ermitteln der Feldnummer des 1. angezeigten
      //  Feldes ...
      exsr cntPinShown;
      x = nbrPinShown + 1;
      wrk#Field = col_field(x);
      exsr getSeqNbr;
      if (isSeqNbrOK = bFalse and l#MinSeq > 0);
        wrk#SeqNbr = l#MinSeq;
        isSeqNbrOK = bTrue;
      endif;

      if (isSeqNbrOK = bTrue);
        exsr getPrvSeq;
        ##wndNbr = wrk#SeqNbr;
        if (set0010.set_scroll = '*BOTH'
           or set0010.set_scroll = '*LEFT');
          ##strPage = *hival;
        else;
          ##strPage = 1;
        endif;
      else;
        ##wndNbr = l#MinSeq;
        ##strPage = 1;
      endif;

      //  Füllen einer Dummy-Zeile von rechts nach
      //  links zur Ermittlung des 1. anzuzeigenden
      //  Feldes ...
      if (##wndNbr > l#MinSeq);
        exsr pbFillDataRow_left;
        //  ... kein Feld gefunden
        if (cp <= 0);
          ##wndNbr = l#MinSeq;
          ##strPage = 1;
        else;
          //  ... Felder gefunden
          if (cp = 1);
            //      ... aber nur 1 Feld
            wrk#Field = col_field(cp);
          else;
            //      ... mehrere Felder
            if (col_error(cp) = bFalse);
              //          ... komplett sichtbar
              wrk#Field = col_field(cp);
            else;
              //          ... nicht komplett sichtbar,
              //              nächstes Feld als Startfeld nehmen
              x = cp - 1;
              wrk#Field = col_field(x);
              ##strPage = 1;
            endif;
            //      ... umrechnen in Feldnummer
            exsr getSeqNbr;
            if (isSeqNbrOK = bTrue);
              ##wndNbr = wrk#SeqNbr;
            else;
              ##wndNbr = *loval;
              ##strPage = 1;
            endif;
          endif;
        endif;
      endif;
    endif;
  endif;

  exsr chkSeqRnge;
  exsr pbRefresh;

endsr;

//============================================================*
//    C_PageR       F20 - Nach rechts verschieben,            *
//                  ganze Seite                               *
//============================================================*

begsr c_pageRight;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr cntPinShown;

    //  Letzte angezeigte Spalte ermitteln
    //  (keine Spalte angezeigt: ans Ende positionieren)
    if (cp > 0);
      wrk#Field = col_field(cp);
      exsr getSeqNbr;
    else;
      isSeqNbrOK = bFalse;
    endif;
    if (isSeqNbrOK = bTrue);

      if (col_error(cp) = bTrue);
        if (cp - nbrPinShown = 1);

          if (set0010.set_scroll = '*BOTH'
              or set0010.set_scroll = '*RIGHT');
            ##wndNbr = wrk#SeqNbr;
            ##strPage = ##strPage + 1;
          else;
            ##wndNbr = wrk#SeqNbr + 1;
            ##strPage = 1;
          endif;

        else;
          ##wndNbr = wrk#SeqNbr;
          ##strPage = 1;
        endif;
      else;
        ##wndNbr = wrk#SeqNbr + 1;
        ##strPage = 1;
      endif;

    else;
      ##wndNbr = *hival;
      ##strPage = 1;
    endif;

    exsr chkSeqRnge;
    exsr pbRefresh;
  endif;

endsr;

//============================================================*
//    c_cmdLine     F21 - Befehlszeile                        *
//============================================================*

begsr c_cmdLine;

  if (f_cmdLine = bTrue);
    callp(e) quscmdln();
    *in99 = %error;
  endif;

endsr;

//============================================================*
//    c_chgScn      F22 - Umschalten der Bildschirmauflösung  *
//============================================================*

begsr c_chgScn;

  exsr chgScreen;

  //  pbRefresh liest die angezeigten Sätze mit der neuen
  //  Seitengröße (sflPage) wieder ein
  exsr pbRefresh;

endsr;

//============================================================*
//    c_moreOpt     F23 - Weitere Auswahlen                   *
//============================================================*

begsr c_moreOpt;

  sfTop = sfTop + 1;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    c_nextMark    Fxx - Nächste Markierung ansteueren       *
//============================================================*

begsr c_nextMark;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getFrstFld;

    wrk#SeqNbr = ##wndNbr;
    exsr getNxtMark;
    if (wrk#SeqNbr > 0);
      ##wndNbr = wrk#SeqNbr;
      ##strPage = 1;
    else;
      wrk#SeqNbr = *loval;
      exsr getNxtMark;
      if (wrk#SeqNbr > 0);
        ##wndNbr = wrk#SeqNbr;
        ##strPage = 1;
      else;
      //    ... keine Markierung gefunden
      endif;
    endif;

    exsr chkSeqRnge;

    exsr pbRefresh;
  endif;

endsr;

//============================================================*
//    c_prevMark    Fxx - Vorherige Markierung ansteueren     *
//============================================================*

begsr c_prevMark;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getFrstFld;

    wrk#SeqNbr = ##wndNbr;
    exsr getPrvMark;
    if (wrk#SeqNbr > 0);
      ##wndNbr = wrk#SeqNbr;
      ##strPage = 1;
    else;
      wrk#SeqNbr = *hival;
      exsr getPrvMark;
      if (wrk#SeqNbr > 0);
        ##wndNbr = wrk#SeqNbr;
        ##strPage = 1;
      else;
      //    ... keine Markierung gefunden
      endif;
    endif;

    exsr chkSeqRnge;

    exsr pbRefresh;
  endif;

endsr;

//============================================================*
//    c_buildPgm    Erstellen Update Programm                 *
//============================================================*

begsr c_buildPgm;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    peek52(set0001.set_dsp80: COPYRIGHT
          : yAlwLc: yCase: yRcdLock: yNullDft
          : yKeepCrs: yMsgID: yMsgDta: bFalse);

    if (yMsgID = 'USR8112'); // Verarbeitung bestätigt.

      //  Rekursiver CALL auf sich selbst (= PEEK05),
      //  um die alte Referenz auf das Update-Programm zu löschen
      monitor;
        UPDPGM_NAME = f_pgmCallN(sds.pgmName);
        yHeaderType = set0001.set_hedTyp;
        UPDPGM(yDsp80
               : yHeaderType
               : yCopyright
               : yRcdNbr
               : yFile
               : yLibrary
               : yMember
               : yFunction
               : yCommitLvl
               : yIsUpdKey
               : yScreenNbr
               : yIsLower
               : yCursorPosition.row
               : yCursorPosition.column
               : yMsgID
               : yMsgDta);
      on-error;
      endmon;

      monitor;
        //  Initialisierung
        p_rmvPgmMg(sds.pgmName);

        exsr getPgmName;

        //  Generierung
        peek08(yQFile: peekPgm: rcdl0200.r2FmtName
              : rcdl0200.r2FmtID
              : yAlwLc: yCase: yRcdLock: yNullDft
              : yKeepCrs: sds.pgmLib: yRtnCode);

        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;
    endif;

    peek52(set0001.set_dsp80: COPYRIGHT
          : yAlwLc: yCase: yRcdLock: yNullDft
          : yKeepCrs: yMsgID: yMsgDta: bTrue);
  endif;

endsr;

//============================================================*
//    c_register    Prüfen der Registrierungsdaten            *
//============================================================*

begsr c_register;

  monitor;
    peek30(set0001.set_dsp80: yCopyright
          : yFlag: yMsgID: yMsgDta);
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
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
    if (yFlag <> -55
        and yFlag <> 66
        and yFlag <> 243);
      //  Fehler im Wertebereich ...
      isLicenceError = bTrue;
      leavesr;
    else;
      //  Datum ist abgelaufen ...
      if (yFlag = -55);
        isLicenceError = bTrue;
        leavesr;
      else;
      //  Registrierung ist OK ...
      endif;
    endif;
  endif;

  //  "Nachschießen" SPLASH-Screen
  if (yFlag = 243 and set0005.set_spla = bFalse);
    exsr s_splashOn;
    exsr showSplash;
  endif;

  isLicenceError = bFalse;

endsr;

//============================================================*
//    c_clrPinRw    Löschen der Pin-Tabelle für Zeilen        *
//============================================================*

begsr c_clrPinRw;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr clrPinRow;

    //  Merker für aktualisieren der Subfile
    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    c_clrPinCl    Löschen der Pin-Tabelle für Spalten       *
//============================================================*

begsr c_clrPinCl;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr clrPinCol;

    //  Merker für aktualisieren der Subfile
    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    c_dspDbr      Anzeigen der Datenbankrelationen          *
//============================================================*

begsr c_dspDbr;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    monitor;
      peek40(set0001.set_dsp80: COPYRIGHT
            : ##file: ##library: ##member
            : ##format: bTrue
            : yRetFile.name: yRetFile.lib
            : yMsgID: yMsgDta);
      *in99 = bFalse;
    on-error;
      *in99 = bTrue;
    endmon;

    if (yRetFile.name = '' or *in99);
    //  ... keine Auswahl getroffen oder Fehler aufgetreten
    else;
      //  ... prüfen auf neue Dateiauswahl
      ##file = yRetFile.name;
      ##library = yRetFile.lib;

      newAccessMode = i_access;
      exsr changeFile;

      if (isFileChg = bTrue);
        exsr c_top;
      else;
      endif;
    endif;
  endif;

endsr;

//============================================================*
//    c_sortBKey    Anzeigen der Sätze in Schlüsselfolge      *
//============================================================*

begsr c_sortBKey;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;
    if (accessMode = KEY_SEQ);
    //    ... Sortierung stimmt bereits
    else;

      //  Umschalten der Sortierung
      newAccessMode = KEY_SEQ;
      exsr changeSort;

    endif;
  endif;

endsr;

//============================================================*
//    c_sortBRrn    Anzeigen der Sätze in Satzfolge           *
//============================================================*

begsr c_sortBRrn;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;
    if (accessMode = RRN_SEQ);
    //    ... Sortierung stimmt bereits
    else;

      if (f_numBased(##file    :
                  ##library :
                  ##member  ) = 1);
        newAccessMode = RRN_SEQ;
        exsr changeSort;
      else;
        clear usr8217;
        p_sndPgmMg('USR8217': usr8217: sds.pgmName);
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    c_sortTgl     Umschalten der Sortierfolge               *
//============================================================*

begsr c_sortTgl;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;
    if (accessMode = RRN_SEQ);
      exsr c_sortBKey;
    else;
      exsr c_sortBRrn;
    endif;
  endif;

endsr;

//============================================================*
//    s_tglKeyLC_uc Umschalten Eingabe der Schlüsselfelder    *
//============================================================*

begsr s_tglKeyLC_uc;

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
//    c_pinCDlg     Pin-Dialog                                *
//============================================================*

begsr c_pinCDlg;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    monitor;
      yPinTabCol = pinTabCol;
      peek50(set0001.set_dsp80: COPYRIGHT: yPinTabCol
            : yMsgID: yMsgDta);
      *in99 = bFalse;
    on-error;
      *in99 = bTrue;
    endmon;

    if (*in99 = *off);
      if (yMsgID = 'USR8112'); // Verarbeitung bestätigt.

        exsr clrPinCol;

        for y = 1 to max_pin_col;
          if (yPinTabCol(y) <> ' ');
            wrk#Field = yPinTabCol(y);
            exsr pinCol;
          endif;
        endfor;

      endif;
    endif;

  endif;

endsr;

//============================================================*
//    c_sql         SQL-Auswahl                               *
//============================================================*

begsr c_sql;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
    leavesr;
  endif;

  //  Datei für den SQL-Dialog; ##file usw. werden erst nach
  //  der Bestätigung geändert
  yFile = ##file;
  yLibrary = ##library;
  yMember = ##member;
  yFormat = ##format;

  if (fild0100.atfila <> '*PHY');

    select;
    when (fild0100.atnofm = 1);
      //  Wenn es sich um eine "single-format logical file" handelt, ...
      //  ... dann prüfen, ob diese Datei über mehere Member geht.
      //      Sortierung nach SQL wird für "multi-member logical files"
      //      (noch) nicht unterstützt ...
      if (fild0100.atJoin = 'N' and
          f_numBased(##file: ##library: ##member) > 1);

        clear usr8235;
        p_sndPgmMg('USR8235': usr8235: sds.pgmName);
        leavesr;
      endif;

    when (fild0100.atnofm > 1);
      //  Wenn es sich um eine "multi-format logical file" handelt, ...
      //  ... dann fragen, welches physiche Datei göffnet werden soll:
      peek59(set0001.set_dsp80: '*QUESTION'
            : 'USR8212': '': 'YN'
            : yMsgID: yMsgDta);
      usr8190 = yMsgDta;
      if (usr8190.var1 = '*YES');
        f_basedPF(##file     :
                 ##library  :
                 ##member   :
                 ##format   :
                 ##fmtNbr   :
                 yFile      :
                 yLibrary   :
                 yMember    :
                 yFormat    );
      else;
        leavesr;
      endif;

    endsl;

  endif;

  // Let the user enter the SQL WHERE and ORDER BY clauses:
  monitor;
    ySqlWhere = sqlWhere;
    ySqlOrder = sqlOrder;
    peek48(set0001.set_dsp80: COPYRIGHT
          : yFile: yLibrary: yMember
          : yFormat
          : accessMode: ySqlWhere: ySqlOrder
          : auth.isChgSQLWhereAlw: auth.isChgSQLOrderByAlw
          : yMsgID: yMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 <> *off);
    leavesr;
  endif;

  if (yMsgID <> 'USR8112'); // Verarbeitung bestätigt.
    leavesr;
  endif;

  //  Leere Klauseln außerhalb des SQL-Modus: nichts zu tun. Die
  //  angezeigte Datei bleibt geöffnet, auch wenn PEEK48 für eine
  //  logische Datei die Basisdatei zurückgegeben hat.
  if (accessMode <> SQL_SEQ and
      ySqlWhere = ' ' and
      ySqlOrder = ' ');
    leavesr;
  endif;

  isPinToClr = bFalse;

  exsr closeFile;

  ##file = yFile;
  ##library = yLibrary;
  ##member = yMember;
  ##format = yFormat;

  if ((ySqlWhere  <> ' ') or
      (ySqlOrder  <> ' '));
    if (accessMode <> SQL_SEQ);
      oldAccMode = accessMode;
    endif;
    accessMode = SQL_SEQ;
    sqlWhere   = ySqlWhere;
    sqlOrder   = ySqlOrder;
  else;
    //  SQL-Modus verlassen: vorherige Sortierung wiederherstellen
    //  (außerhalb des SQL-Modus endet die Routine schon oben)
    accessMode = oldAccMode;
    sqlWhere   = ' ';
    sqlOrder   = ' ';
  endif;

  exsr openFile;

  isPinToClr = bTrue;

endsr;

//============================================================*
//    s_change      02 - Ändern Einzelsatz                    *
//============================================================*

begsr s_change;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    if (isUpdMod = bFalse);
      //      Ändern nicht möglich, da INPUT-Modus
      clear usr0007;
      usr0007.var1 = ##file;
      usr0007.var2 = ##library;
      p_sndPgmMg('USR0007': usr0007: sds.pgmName);
    else;

      exsr getSflRcd;

      if (sflCsr > 0);
        yFunction = '*CHANGE';
        exsr callUpdPgm;
        exsr reloadUsrStg;
      else;
      //        kein Datensatz verfügbar
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    s_copy        03 - Kopieren Einzelsatz                  *
//============================================================*

begsr s_copy;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    if (isUpdMod = bFalse);
      //      Ändern nicht möglich, da INPUT-Modus
      clear usr0007;
      usr0007.var1 = ##file;
      usr0007.var2 = ##library;
      p_sndPgmMg('USR0007': usr0007: sds.pgmName);
    else;

      exsr getSflRcd;

      if (sflCsr > 0);
        yFunction = '*COPY';
        exsr callUpdPgm;
      else;
      //        kein Datensatz verfügbar
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    s_copyExt     09 - Kopieren Einzelsatz in externe Datei *
//============================================================*

begsr s_copyExt;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    if (auth.isUpdAlw = bFalse);
      //      Kopieren nicht möglich, da keine Änderungen erlaubt
      //      (wie bei den Auswahlen 2, 3 und 4)
      clear usr0007;
      usr0007.var1 = ##file;
      usr0007.var2 = ##library;
      p_sndPgmMg('USR0007': usr0007: sds.pgmName);
    else;

      exsr getSflRcd;

      if (sflCsr > 0);

        if (queryUser <> yPgmCmd);

          //  Abfragen der Zielangaben ...
          exsr pbGetTarget;

          //  Verarbeitung OK ...
          if (isTargetOK = bTrue);
            //  Fragen Benutzer pro Datensatz ...
            exsr pbQueryUser;
          endif;

        else;
          //  Kopieren ohne Sicherheitsabfrage ...
          yMsgID = 'USR8112'; // Verarbeitung bestätigt.
          yMsgDta = '';
        endif;

        //  Datensatz kopieren ...
        if (yMsgID = 'USR8112'); // Verarbeitung bestätigt.
          exsr copyExtRcd;
        endif;

      else;
      //        kein Datensatz verfügbar
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    s_delete      04 - Löschen Einzelsatz                   *
//============================================================*

begsr s_delete;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    if (isUpdMod = bFalse);
      //      Löschen nicht möglich, da INPUT-Modus
      clear usr0007;
      usr0007.var1 = ##file;
      usr0007.var2 = ##library;
      p_sndPgmMg('USR0007': usr0007: sds.pgmName);
    else;

      exsr getSflRcd;

      if (sflCsr > 0);

        if (queryUser <> yPgmCmd);

          //  Fragen Benutzer ...
          exsr pbQueryUser;

        else;
          //  Löschen ohne Sicherheitsabfrage ...
          yMsgID = 'USR8112'; // Verarbeitung bestätigt.
          yMsgDta = '';
        endif;

        //  Datensatz löschen ...
        if (yMsgID = 'USR8112'); // Verarbeitung bestätigt.
          exsr delRecord;
        endif;

      else;
      //        kein Datensatz verfügbar
      endif;
    endif;
  endif;

endsr;

//============================================================*
//    s_display     05 - Anzeigen Einzelsatz                  *
//============================================================*

begsr s_display;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getSflRcd;

    if (sflCsr > 0);

      monitor;
        yHeaderType = set0001.set_hedTyp;
        PEEK14(set0001.set_dsp80: yHeaderType: COPYRIGHT
              : wrk#RcdNbr: h_file: h_lib: h_mbr
              : h_rcdFmt: '*DISPLAY': commitLvl
              : yScreenNbr: yMsgID: yMsgDta);
        if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
          p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
          yMsgID = '';
          yMsgDta = '';
        else;
          if (set0001.set_hedTyp <> yHeaderType);
            set0001.set_hedTyp = yHeaderType;
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
//    s_print       06 - Drucken Datensatz                    *
//============================================================*

begsr s_print;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getSflRcd;

    if (sflCsr > 0);

      monitor;
        peek65(wrk#RcdNbr: h_file: h_lib: h_mbr: ''
              : yMsgID: yMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

      if (yMsgID <> '');
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID  = '';
        yMsgDta = '';
      endif;

    else;
    //        kein Datensatz verfügbar
    endif;
  endif;

endsr;

//============================================================*
//    s_pinRcd      P  - Pin Datensatz                        *
//============================================================*

begsr s_pinRcd;

  if (isOpen = bFalse);
    //**  F4Open        OREQ      '0'
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    if (f_numBased(##file: ##library: ##member) > 1);
      clear usr8218;
      p_sndPgmMg('USR8218': usr8218: sds.pgmName);
      isCmdErr = bTrue;
      isCancel = bTrue;
    else;

      exsr getSflRcd;

      if (sflCsr > 0);

        if (f_chain04(wrk#RcdNbr:
                   h_file   :
                   h_lib    :
                   h_mbr    :
                   h_rcdFmt ) = '0');
          exsr pinRecord;

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
//    s_unPinRcd    UP - UnPin Datensatz                      *
//============================================================*

begsr s_unPinRcd;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getSflRcd;

    if (sflCsr > 0);

      exsr chkPinRcd;
      if (isPinned = bFalse);
        //  Datensatz ist nicht gepinned ...
        p_sndPgmMg('USR8121': '': sds.pgmName);
      else;
        //  Datensatz ist gepinned ...
        exsr rmvPinRcd;
      endif;

    else;
    //        kein Datensatz verfügbar
    endif;
  endif;

endsr;

//============================================================*
//    s_tgTblPap    Toggeln Tabellierpapierfunktion           *
//============================================================*

begsr s_tgTblPap;

  if (set0001.set_tblMde = bTrue);
    exsr s_tblPapOf;
  else;
    exsr s_tblPapOn;
  endif;

endsr;

//============================================================*
//    s_tblPapOn    Einschalten Tabellierpapier               *
//============================================================*

begsr s_tblPapOn;

  if (set0001.set_tblMde = bTrue);
    //  Fehlermeldung ...
    p_sndPgmMg('USR8149': '': sds.pgmName);
  else;
    set0001.set_tblMde = bTrue;
    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    s_tblPapOf    Ausschalten Tabellierpapier               *
//============================================================*

begsr s_tblPapOf;

  if (set0001.set_tblMde = bFalse);
    //  Fehlermeldung ...
    p_sndPgmMg('USR8150': '': sds.pgmName);
  else;
    set0001.set_tblMde = bFalse;
    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    s_tgPinCol    PC - Pin Spalte                           *
//============================================================*

begsr s_tgPinCol;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getFldTMrk;

    if (wrk#Field <> '');
      pin#Field = wrk#Field;
      exsr chkPinCol;
      if (isPinned = bFalse);
        //  Datensatz ist noch nicht gepinned ...
        //  Spalte pinnen ...
        exsr pinCol;
      else;
        exsr rmvPincolumn;
      endif;
    endif;
  endif;

  //  Beibehalten der Cursorposition ...
  exsr keepCsrPos;

endsr;

//============================================================*
//    s_pinCol      PC - Pin Spalte                           *
//============================================================*

begsr s_pinCol;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getFldTMrk;

    if (wrk#Field <> '');
      //  Spalte pinnen ...
      exsr pinCol;
    endif;
  endif;

  //  Beibehalten der Cursorposition ...
  exsr keepCsrPos;

endsr;

//============================================================*
//    s_unPinCol    UC - UnPin Spalte                         *
//============================================================*

begsr s_unPinCol;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getFldTMrk;

    if (wrk#Field <> '');
      pin#Field = wrk#Field;
      exsr chkPinCol;
      if (isPinned = bFalse);
        //  Spalte ist nicht gepinned ...
        clear usr8147;
        usr8147.var1 = wrk#Field;
        p_sndPgmMg('USR8147': usr8147: sds.pgmName);
      else;
        //  Spalte ist gepinned ...
        exsr rmvPincolumn;
      endif;
    endif;
  endif;

  //  Beibehalten der Cursorposition ...
  exsr keepCsrPos;

endsr;

//============================================================*
//    s_splashOn    Einschalten Splash-Screen                 *
//============================================================*

begsr s_splashOn;

  set0005.set_spla = bTrue;

  p_sndPgmMg('USR8161': '': sds.pgmName);

endsr;

//============================================================*
//    s_splashOf    Ausschalten Splash-Screen                 *
//============================================================*

begsr s_splashOf;

  set0005.set_spla = bFalse;

  p_sndPgmMg('USR8162': '': sds.pgmName);

endsr;

//============================================================*
//    s_shortCmd    Ausführen Kurzbefehl                      *
//============================================================*

begsr s_shortCmd;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    exsr getSflRcd;

    if (sflCsr > 0);

      clear shortCmd;
      shortCmd.sc_action = '*CMD';
      shortCmd.sc_cmd = yCmdDta;

      monitor;
        peek42(h_file: h_lib: h_mbr: h_rcdFmt
              : shortCmd: wrk#RcdNbr: yExecCmd
              : yMsgID: yMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

      select;
      when (*in99 = *on);
      //           Program error
      when (yMsgID <> *blanks);
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';

      when (yExecCmd = *blanks);
      //           No command to excute
      other;
        f_execute(yExecCmd: yMsgID: yMsgDta);
        if (yMsgID <> '');
          p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
          yMsgID = '';
          yMsgDta = '';
        endif;
      endsl;

    else;
    //        kein Datensatz verfügbar
    endif;
  endif;

endsr;

//============================================================*
//    s_about        A - Über Peek/400                        *
//============================================================*

begsr s_about;

  peek49(set0001.set_dsp80: COPYRIGHT
        : RELEASE: Version
        : yMsgID: yMsgDta);

endsr;

//============================================================*
//    s_dspNrm      Normale Anzeige                           *
//============================================================*

begsr s_dspNrm;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;
    if (set0001.set_dspMde = '*DSPNRM');
    //    ... Anzeige stimmt bereits
    else;

      //  Umschalten der Anzeige
      set0001.set_dspMde = '*DSPNRM';
      isSflDirty = bTrue;

    endif;
  endif;

endsr;

//============================================================*
//    s_dspHex      Hexadezimale Anzeige                      *
//============================================================*

begsr s_dspHex;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;
    if (set0001.set_dspMde = '*DSPHEX');
    //    ... Anzeige stimmt bereits
    else;

      if (file#X.rcdLen > RCD_BUFF_LEN);
        clear usr8206;
        usr8206.var1   = RCD_BUFF_LEN;
        p_sndPgmMg('USR8206': usr8206: sds.pgmName);
      else;
        set0001.set_dspMde = '*DSPHEX';
        isSflDirty = bTrue;
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    s_dspTgl      Umschalten der Anzeige                    *
//============================================================*

begsr s_dspTgl;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;
    if (set0001.set_dspMde = '*DSPNRM');
      exsr s_dspHex;
    else;
      exsr s_dspNrm;
    endif;

    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    s_saveEnv     Sichern Arbeitsumgebung                   *
//============================================================*

begsr s_saveEnv;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    peek56(set0001.set_dsp80: COPYRIGHT: '*SAVE'
          : yEnvFile: yEnvLib: yEnvMbr
          : $$rcdFmtID
          : yQFile: yMember: yText: yOption
          : yMsgID: yMsgDta);

    if (yMsgID <> ' ');
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
    else;

      yEnvFile = yFile;
      yEnvLib  = yLibrary;
      yEnvMbr  = yMember;
      yIsAutoSave = bFalse;
      exsr saveEnv;

      if (yMsgID <> ' ');
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
      endif;

    endif;

  endif;

endsr;

//============================================================*
//    s_loadEnv     Laden Arbeitsumgebung                     *
//============================================================*

begsr s_loadEnv;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    peek56(set0001.set_dsp80: COPYRIGHT: '*LOAD'
          : yEnvFile: yEnvLib: yEnvMbr
          : $$rcdFmtID
          : yQFile: yMember: yText: yOption
          : yMsgID: yMsgDta);

    if (yMsgID <> ' ');
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
    else;

      yEnvFile = yFile;
      yEnvLib  = yLibrary;
      yEnvMbr  = yMember;
      exsr loadEnv;
      if (yMsgID <> ' ');
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
      endif;

      isSflDirty = bTrue;
    endif;
  endif;

endsr;

//============================================================*
//    loadEnv       Laden Arbeitsumgebung                     *
//============================================================*

begsr loadEnv;

  if (##member = '*NONE');
    leavesr;
  endif;

  isPinToClr = bFalse;

  clear rtn;
  rtn.file = ##file;
  rtn.library = ##library;
  rtn.member = ##member;
  rtn.format = ##format;
  rtn.accessMode = accessMode;
  rtn.sqlWhere = sqlWhere;
  rtn.sqlOrder = sqlOrder;

  peek55(##file: ##library: ##member: ##format
        : $$rcdFmtID
        : yEnvFile: yEnvLib: yEnvMbr
        : yOption
        : pinTabRcd: nbrPinRcd
        : pinTabCol: nbrPinCol
        : rtn.file: rtn.library: rtn.member
        : rtn.format
        : rtn.accessMode: rtn.sqlWhere
        : rtn.sqlOrder
        : isKeyLower
        : yMsgID: yMsgDta);

  if (yMsgID <> ' ');
  // TODO: remove code
  // p_sndPgmMg(yMsgID: yMsgDta: sds.pgmname);
  // yMsgID = '';
  // yMsgDta = '';
  else;

    if (##file     <> rtn.file or
       ##library  <> rtn.library or
       ##member   <> rtn.member or
       ##format   <> rtn.format or
       accessMode <> rtn.accessMode or
       sqlWhere   <> rtn.sqlWhere or
       sqlOrder   <> rtn.sqlOrder);
      exsr closeFile;
      ##file     = rtn.file;
      ##library  = rtn.library;
      ##member   = rtn.member;
      ##format   = rtn.format;
      accessMode = rtn.accessMode;
      sqlWhere   = rtn.sqlWhere;
      sqlOrder   = rtn.sqlOrder;
      exsr openFile;
      peek55(##file: ##library: ##member: ##format
            : $$rcdFmtID
            : yEnvFile: yEnvLib: yEnvMbr
            : yOption
            : pinTabRcd: nbrPinRcd
            : pinTabCol: nbrPinCol
            : rtn.file: rtn.library: rtn.member
            : rtn.format
            : rtn.accessMode: rtn.sqlWhere
            : rtn.sqlOrder
            : isKeyLower
            :yMsgID: yMsgDta);
    endif;
  endif;

  isPinToClr = bTrue;

endsr;

//============================================================*
//    saveEnv       Speichern Arbeitsumgebung                 *
//============================================================*

begsr saveEnv;

  peek54(##file: ##library: ##member: ##format
        : $$rcdFmtID
        : yEnvFile: yEnvLib: yEnvMbr
        : yIsAutoSave
        : pinTabRcd: nbrPinRcd
        : pinTabCol: nbrPinCol
        : accessMode: sqlWhere
        : sqlOrder: isKeyLower
        : yMsgID: yMsgDta);

endsr;

//============================================================*
//    s_delEnv      Löschen Arbeitsumgebung                   *
//============================================================*

begsr s_delEnv;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    for do_x2 = 1 to *hival;

      peek56(set0001.set_dsp80: COPYRIGHT: '*DELETE'
            : yEnvFile: yEnvLib: yEnvMbr
            : ''
            : yQFile: yMember: yText: yOption
            : yMsgID: yMsgDta);

      if (yMsgID <> ' ');
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
        leave;
      else;

        peek57(set0001.set_dsp80: COPYRIGHT
              : yFile: yLibrary: yMember: yText
              : yMsgID: yMsgDta);

        if (yMsgID <> ' ');
          if (yMsgDta = '*CANCEL');
            iter;
          else;
            p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
            yMsgID = '';
            yMsgDta = '';
            leave;
          endif;
        endif;

      endif;

    endfor;

  endif;

endsr;

//============================================================*
//    msgNoFile     Nachricht: Keine Datei geöffnet           *
//============================================================*

begsr msgNoFile;

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
//    clrPinRow     Löschen der Pin-Tabelle für Zeilen        *
//============================================================*

begsr clrPinRow;

  if (isPinToClr = bTrue);
    nbrPinRcd = 0;
    exsr clrPinTabR;
    isSflDirty = bTrue;
  else;
  //    ... wird nicht gelöscht
  endif;

endsr;

//============================================================*
//    clrPinCol     Löschen der Pin-Tabelle für Spalten       *
//============================================================*

begsr clrPinCol;

  if (isPinToClr = bTrue);
    nbrPinCol = 0;
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
    yMsgID = 'USR8112'; // Verarbeitung bestätigt.
    yMsgDta = '';
    leavesr;
  endif;

  monitor;
    peek26(set0001.set_dsp80: yQFile: h_mbr
          : copyExternal.file: copyExternal.lib: copyExternal.toMbr
          : copyExternal.mbrOpt: copyExternal.crtFile: yMsgID: yMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = *on);
    isError = bTrue;
    isTargetOK = bFalse;
  else;
    isError = bFalse;
    //  Abbruch mit F3/F12 (USR8100): kein Ziel, nichts kopieren
    if (yMsgID = 'USR8112'); // Verarbeitung bestätigt.
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
    yHeaderType = set0001.set_hedTyp;
    PEEK14(set0001.set_dsp80: yHeaderType: COPYRIGHT
          : wrk#RcdNbr: h_file: h_lib: h_mbr
          : h_rcdFmt: yPgmCmd: commitLvl
          : yScreenNbr: yMsgID: yMsgDta);
    if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
    else;
      if (set0001.set_hedTyp <> yHeaderType);
        set0001.set_hedTyp = yHeaderType;
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
    when (yMsgID = 'USR8100'); // Verarbeitung abgebrochen. (F3/F12)

    when (yMsgID = 'USR8111'); // Alle Datensätze verarbeiten.
      queryUser = yPgmCmd;
      yMsgID = 'USR8112'; // Verarbeitung bestätigt.
      yMsgDta = '';
      p_sndPgmMg('USR8112': '': sds.pgmName); // Verarbeitung bestätigt.

    when (yMsgID = 'USR8112'); // Verarbeitung bestätigt.

    //  Unerwartete Nachrichten-ID ...
    other;
      clear usr9998;
      usr9998.var1 = yMsgID;
      usr9998.var2 = 'PEEK14';
      p_sndPgmMg('USR9998': usr9998: sds.pgmName);
    endsl;

  endif;

endsr;

//============================================================*
//    pinRecord     Datensatz pinnen                          *
//============================================================*

begsr pinRecord;

  isPinOK = bFalse;

  exsr chkPinRcd;
  if (isPinned = bFalse);
    //  Datensatz ist noch nicht gepinned ...
    clear pinTabRcdE;
    x = 1;
    x = %lookup(pinTabRcdE: pinTabRcd: x);
    if (x > 0);
      //  ... Datensatz pinnen
      pinTabRcdE.rcdNbr = wrk#RcdNbr;
      pinTabRcdE.file = h_file;
      pinTabRcdE.lib = h_lib;
      pinTabRcdE.mbr = h_mbr;
      pinTabRcdE.rcdFmt = h_rcdFmt;
      pinTabRcdE.mbrNbr = h_mbrNbr;
      pinTabRcd(x) = pinTabRcdE;

      nbrPinRcd = x;
      isSflDirty = bTrue;
      isPinOK = bTrue;
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
//    pinCol        Spalte pinnen                             *
//============================================================*

begsr pinCol;

  isPinOK = bFalse;

  pin#Field = wrk#Field;
  exsr chkPinCol;
  if (isPinned = bFalse);
    //  Datensatz ist noch nicht gepinned ...
    x = 1;
    pin#Field = '';
    x = %lookup(pin#Field: pinTabCol: x);
    if (x > 0);
      //  ... Datensatz pinnen
      pinTabCol(x) = wrk#Field;
      nbrPinCol = x;
      isSflDirty = bTrue;
      isPinOK = bTrue;
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

  if (f_chain00(wrk#RcdNbr: h_file: h_lib: h_mbr: '') = bTrue);

    //  Fehler bei Zugriff auf Datensatz ...
    usr8200.var1 = wrk#RcdNbr;
    p_sndPgmMg('USR8200': usr8200: sds.pgmName);

  else;

    if (CIO_delete(hFile00) = bTrue);
      *in99 = '0';
    else;
      *in99 = '1';
    endif;
    exsr f0toFx;

    if (*in99 = *on);
      if (*in55 = bTrue);
        rolbk;
      else;
        CIO_unlock(hFile00);
      endif;
      exsr f0toFx;

      usr8200.var1 = wrk#RcdNbr;
      p_sndPgmMg('USR8200': usr8200: sds.pgmName);
    else;
      if (*in55 = bTrue);
        commit;
      else;
        CIO_unlock(hFile00);
      endif;
      exsr f0toFx;
      exsr callExit04;

      usr8201.var1 = wrk#RcdNbr;
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
    callp EXIT04(file#X.file: file#X.library: file#X.member
                 : '*DELETE': sds.user: %timestamp()
                 : wrk#RcdNbr: file#X.rcdLen: %addr(io_buff): *null);
  endif;

endsr;

//============================================================*
//    CopyExtRcd    Kopieren Datensatz in externe Datei       *
//============================================================*

begsr copyExtRcd;

  if (f_chain04(wrk#RcdNbr:
             h_file   :
             h_lib    :
             h_mbr    :
             h_rcdFmt ) = '0');

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
      : yMsgID: yMsgDta);

    if (yMsgID <> '');
      isCmdErr = bTrue;
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
      if (*in55 = bTrue);
        rolbk;
      endif;
      exsr f0toFx;

      usr8202.var1 = wrk#RcdNbr;
      p_sndPgmMg('USR8202': usr8202: sds.pgmName);
    else;
      if (*in55 = bTrue);
        commit;
      endif;
      exsr f0toFx;

      usr8203.var1 = wrk#RcdNbr;
      p_sndPgmMg('USR8203': usr8203: sds.pgmName);
    endif;

  endif;

  //  Alles weitere mit ...
  copyExternal.mbrOpt = '*ADD';

endsr;

//============================================================*
//    srchStart     Aufsetzen mit neuer Suche                 *
//============================================================*

begsr srchStart;

  //  Übertragen der Übergabeparameter ...
  srchField = yField;
  srchOP = yOperation;
  srchArg = %trimr(yArgument);
  srchSign = ySign;

  //  ... Anpassungen für LIKE/NLIKE ...
  if (srchOP = 'LIKE'
      or srchOP = 'NLIKE');
    //      ... führendes %-Zeichen
    a1 = %subst(srchArg:1:1);
    if (a1 = set0002.set_wldCd);
      srchArg = %subst(srchArg:2);
      srchLikeTp = 1;
    else;
      srchArg = srchArg;
      srchLikeTp = 0;
    endif;

    //      ... nachgestelltes %-Zeichen
    x = %checkr(' ': srchArg);
    if (x > 0);
      a1 = %subst(srchArg: x: 1);

      if (a1 = set0002.set_wldCd);
        x = x - 1;
        if (x > 0);
          srchArg = %subst(srchArg: 1: x);
        else;
          srchArg = *blanks;
        endif;
        srchLikeTp = srchLikeTp + 2;
      endif;

    endif;

    //      ... Länge von srchArg
    srchLikeLn = %checkr(' ': srchArg);
  else;
    //  ... keine Anpassungen erforderlich
    srchLikeTp = 0;
    srchLikeLn = 0;
  endif;

  srchNbrs = ySrchNbrs;
  srchType = ySrchType;
  srchCase = ySrchCase;

  //  Ermitteln der Feldattribute
  exsr srchFldAtr;

  if (srchField = '*RECORD');
    srchIsNum = bFalse;
  else;
    if (f_isNumFld(fldl0100) = bTrue);
      srchIsNum = bTrue;
    else;
      srchIsNum = bFalse;
    endif;
  endif;

  //  Nicht Case-Sensitive suchen ...
  if (ySrchCase = bFalse and srchIsNum = bFalse);
    srchArg = %xlate(C_LOWER: C_UPPER: srchArg);
  else;
  //      keine Konvertierung erforderlich
  endif;

  //  Numerische Suche ...
  if (srchIsNum = bTrue);
    if (f_isFloatFld(fldl0100) = bTrue);
      srchArgFloat = %float(srchArg);
      srchArgVal   = 0;
      srchArgIsFloat = bTrue;
    else;
      srchArgVal   = %dec(srchArg
                         : cSRCHARG_DIGITS
                         : cSRCHARG_DECPOS);
      srchArgFloat = 0;
      srchArgIsFloat = bFalse;
    endif;
    if (srchSign = set0003.set_signM);
      //  ... negativen Wert erzeugen
      srchArgVal = srchArgVal * -1;
      srchArgFloat = srchArgFloat * -1;
    else;
    //  ... positiven Wert belassen
    endif;
  else;
    srchArgVal = 0;
    srchArgFloat = 0;
  endif;

  //  Ermitteln des Startdatensatzes
  exsr srchStrRcd;

  //  Suchen ...
  exsr srchUp;

endsr;

//============================================================*
//    srchCont      Fortsetzen der Suche nach "gefunden"      *
//============================================================*

begsr srchCont;

  //  Ermitteln der Feldattribute
  exsr srchFldAtr;

  //  Ermitteln des Startdatensatzes
  exsr srchStrRcd;

  //  Suchen ...
  exsr srchUp;

endsr;

//============================================================*
//    srchContM     Fortsetzen der Suche nach "MAXIMUM"       *
//============================================================*

begsr srchContM;

  //  Ermitteln der Feldattribute
  exsr srchFldAtr;

  //  Suchen ...
  exsr srchUp;

endsr;

//============================================================*
//    srchEOF       Fortsetzen der Suche nach Dateiende       *
//============================================================*

begsr srchEOF;

  //  Ermitteln der Feldattribute
  exsr srchFldAtr;

  //  Ermitteln des Startdatensatzes
  exsr pbMoveTop;

  //  Suchen ...
  exsr srchUp;

endsr;

//============================================================*
//    srchStrRcd    Positionieren auf Startdatensatz          *
//============================================================*

begsr srchStrRcd;

  //---------------------------------------*
  //  Cursor im Subfilebereich ...
  //---------------------------------------*
  if (sflCsr <> 0
      and sflCsr > nbrPinRcd);

    //  ... übersetzen in Satznummer
    exsr pbCsrToRcd;
    //  ... Fortsetzen der Suche
    if (wrk#RcdNbr = srchFndRcd);
      exsr pbReadCsrA;
    else;
      //  ... oder neu anfangen
      exsr pbReadCsr;
    endif;
  else;

    //---------------------------------------*
    //  Cursor nicht im Subfilebereich ...   *
    //---------------------------------------*
    x = sflFirstRw + nbrPinRcd;
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
  f_key.f_field = srchField;
  chain(n) %kds(f_key) fpeekfld;
  if (not %found());
    clear fldl0100;
  else;
    fldl0100 = f_ffd;
  endif;

endsr;

//============================================================*
//    srchUp        Suchen ab einer gegebenen Satznummer      *
//============================================================*

begsr srchUp;

  //  Suche läuft ...
  p_sndStsMg('USR8127': ' ');

  srchCount = 0;
  srchCount2 = 0;

  for do_x3 = 1 to *hival;
    exsr pbRead;
    if (isEOF = bTrue);
      srchMode = '*EOF';
      leave;
    endif;

    srchCount = srchCount + 1;

    exsr srchCompare;
    if (isFound = bTrue);
      srchMode = '*FOUND';
      //  ... suchen & pinnen
      if (srchType = '*PINROW');
        wrk#RcdNbr = file#X.rcdNbr;
        //  Satzkennung des gefundenen Satzes, nicht die der
        //  zuletzt angezeigten Zeile
        exsr setRcdId;
        exsr pinRecord;
        if (isPinOK = bFalse);
          leave;
        else;
        //        weiter suchen und pinnen
        endif;
      else;
        //  ... sonstige Suchfunktionen
        leave;
      endif;
    endif;

    //  Höchstzahl der zu durchsuchenden Sätze erreicht ...
    //  (erst nach dem Vergleich, sonst wird dieser Satz nie geprüft)
    if (srchCount >= srchNbrs);
      srchMode = '*MAXIMUM';
      leave;
    endif;

    srchCount2 = srchCount2 + 1;
    if (srchCount2 >= srchDspMsg);
      srchCount2 = 0;

      clear usr8128;
      usr8128.var1 = srchCount;
      usr8128.var2 = srchNbrs;
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

  isFound = bFalse;

  //  Im ganzen Datensatz suchen ...
  if (srchField = '*RECORD');
    srchCmpRcd = io_buff;
  else;
    exsr srchGetCmp;
  endif;

  //  Im ganzen Datensatz suchen ...
  if (srchField = '*RECORD');
    exsr srchComp_r;
  else;
    //  Im Datenfeld suchen ...
    exsr srchComp_f;
  endif;

endsr;

//============================================================*
//    srchGetCmp    Dateninhalt aus Datensatz extrahieren     *
//                  für Vergleich der Suchfunktion            *
//============================================================*

begsr srchGetCmp;

  if (srchIsNum = bTrue);
    f_rtvFld(yBuffer  :
            io_buff  :
            fldl0100 :
            bTrue    );

    yTgtValue  = ' ';

    if (srchArgIsFloat = bTrue);
      peek18(fldl0100: 'FLDL0100': yBuffer:
            '*FLOAT': '': yOutBuffer: yOutBuffLn
            : yMsgID: yMsgDta);

      srchCmpFloat = %float(yOutBuffer);
      srchCmpVal   = 0;
    else;
      peek18(fldl0100: 'FLDL0100': yBuffer:
            '*ZONED': '': yOutBuffer: yOutBuffLn
            : yMsgID: yMsgDta);

      srchCmpStr =
       %subst(yOutBuffer
              : yOutBuffLn - %len(srchCmpStr) + 1
              : yOutBuffLn);
      srchCmpVal = %dec(srchCmpStr
                       : srch_cmp_val_length
                       : srch_cmp_val_decpos);
      srchCmpFloat = 0;
    endif;

  else;
    f_rtvFld(srchCmpStr:
            io_buff   :
            fldl0100  );
  endif;

endsr;

//============================================================*
//    srchComp_r    Suchen im Datensatz                       *
//============================================================*

begsr srchComp_r;

  //  Nicht Case-Sensitive suchen ...
  if (srchCase = bFalse);
    srchCmpRcd = %xlate(C_LOWER: C_UPPER: srchCmpRcd);
  //  Case-Sensitive suchen ...
  endif;

  x = %checkr(' ': srchArg);
  if (x <> 0);
    x = %scan(%subst(srchArg: 1: x): srchCmpRcd: 1);
  else;
    x = %scan(srchArg: srchCmpRcd: 1);
  endif;

  //  Gleich ...
  if (srchOP = 'LIKE');
    //  ... nicht gefunden
    if (x = 0);
      isFound = bFalse;
    else;
      //  ... gefunden
      isFound = bTrue;
    endif;
  else;
    //  UnGleich ...
    //  ... nicht gefunden
    if (x = 0);
      isFound = bTrue;
    else;
      //  ... gefunden
      isFound = bFalse;
    endif;
  endif;

endsr;

//============================================================*
//    srchComp_f    Suchen im Feld                            *
//============================================================*

begsr srchComp_f;

  //  Nicht Case-Sensitive suchen ...
  //  (nur bei nicht numerischer Suche beachten)
  if (srchCase = bFalse and srchIsNum = bFalse);
    srchCmpStr = %xlate(C_LOWER: C_UPPER: srchCmpStr);
  //  Case-Sensitive suchen ...
  endif;

  //-----------------------*
  //  Vergleichen ...      *
  //-----------------------*
  select;
  //  Gleich ...
  when (srchOP = 'EQ');
    if (srchIsNum = bFalse);
      if (srchCmpStr = srchArg);
        isFound = bTrue;
      endif;
    else;
      if ((srchArgIsFloat = bFalse and
          srchCmpVal = srchArgVal) or
          (srchArgIsFloat = bTrue  and
          srchCmpFloat = srchArgFloat));
        isFound = bTrue;
      endif;
    endif;
  //  UnGleich ...
  when (srchOP = 'NE');
    if (srchIsNum = bFalse);
      if (srchCmpStr <> srchArg);
        isFound = bTrue;
      endif;
    else;
      if ((srchArgIsFloat = bFalse and
          srchCmpVal <> srchArgVal) or
          (srchArgIsFloat = bTrue  and
          srchCmpFloat <> srchArgFloat));
        isFound = bTrue;
      endif;
    endif;
  //  Größer ...
  when (srchOP = 'GT');
    if (srchIsNum = bFalse);
      if (srchCmpStr > srchArg);
        isFound = bTrue;
      endif;
    else;
      if ((srchArgIsFloat = bFalse and
          srchCmpVal > srchArgVal) or
          (srchArgIsFloat = bTrue  and
          srchCmpFloat > srchArgFloat));
        isFound = bTrue;
      endif;
    endif;
  //  Kleiner ...
  when (srchOP = 'LT');
    if (srchIsNum = bFalse);
      if (srchCmpStr < srchArg);
        isFound = bTrue;
      endif;
    else;
      if ((srchArgIsFloat = bFalse and
          srchCmpVal < srchArgVal) or
          (srchArgIsFloat = bTrue  and
          srchCmpFloat < srchArgFloat));
        isFound = bTrue;
      endif;
    endif;
  //  Größer/Gleich ...
  when (srchOP = 'GE');
    if (srchIsNum = bFalse);
      if (srchCmpStr >= srchArg);
        isFound = bTrue;
      endif;
    else;
      if ((srchArgIsFloat = bFalse and
          srchCmpVal >= srchArgVal) or
          (srchArgIsFloat = bTrue  and
          srchCmpFloat >= srchArgFloat));
        isFound = bTrue;
      endif;
    endif;
  //  Kleiner/Gleich ...
  when (srchOP = 'LE');
    if (srchIsNum = bFalse);
      if (srchCmpStr <= srchArg);
        isFound = bTrue;
      endif;
    else;
      if ((srchArgIsFloat = bFalse and
          srchCmpVal <= srchArgVal) or
          (srchArgIsFloat = bTrue  and
          srchCmpFloat <= srchArgFloat));
        isFound = bTrue;
      endif;
    endif;
  //  Ähnlich ...
  when (srchOP = 'LIKE'
     or srchOP = 'NLIKE');

    select;
    //  ...   ('%ABCD')
    when (srchLikeTp = 1);
      x = %checkr(' ': srchCmpStr);
      x = x - srchLikeLn;
      x = x + 1;
      if (x > 0);
        srchCmpStr= %subst(srchCmpStr: x: srchLikeLn);
        if (srchCmpStr = srchArg);
          isFound = bTrue;
        endif;
      endif;

    //  ...   ('ABCD%')
    when (srchLikeTp = 2);
      srchCmpStr= %subst(srchCmpStr: 1: srchLikeLn);
      if (srchCmpStr = srchArg);
        isFound = bTrue;
      endif;

    //  ...   ('%ABCD%')
    other;
      x = srchLikeLn;
      x = %scan(%subst(srchArg: 1: x): srchCmpStr: 1);
      if (x > 0);
        isFound = bTrue;
      endif;

    endsl;

    //  ... auswerten isFound für LIKE/NLIKE
    if (srchOP = 'LIKE');
    //        ... isFound ist bereits richtig gesetzt.
    else;
      //        ... isFound muß negiert werden ...
      if (isFound = bTrue);
        isFound = bFalse;
      else;
        isFound = bTrue;
      endif;
    endif;

  other;
  endsl;

endsr;

//============================================================*
//    srchInz       Initialisieren der Suchfunktion           *
//============================================================*

begsr srchInz;

  srchMode = '*NEW';
  srchFndRcd = 0;

  srchField = *blanks;
  srchOP = *blanks;
  srchArg = *blanks;
  srchSign = *blanks;
  srchNbrs = 0;
  srchType = *blanks;

  srchCmpStr = *blanks;
  srchCount = 0;

  srchCount = 0;
  srchCount2 = 0;
  srchDspMsg = 1000;

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
      yRcdNbr = wrk#RcdNbr;
    endif;

    if (not f_exist(peekDspF: '*LIBL': '*FILE'));
      *in99 = bTrue;
    else;
      monitor;
        UPDPGM_NAME = f_pgmCallN(peekPgm);
        yHeaderType = set0001.set_hedTyp;
        UPDPGM(set0001.set_dsp80
               : yHeaderType
               : COPYRIGHT
               : yRcdNbr
               : file#X.file
               : file#X.library
               : file#X.member
               : yFunction
               : commitLvl
               : isUpdKey
               : yScreenNbr
               : yIsLower
               : yCursorPosition.row
               : yCursorPosition.column
               : yMsgID
               : yMsgDta);
        if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
          p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
          yMsgID = '';
          yMsgDta = '';
        else;
          isSflDirty = bTrue;
          if (set0001.set_hedTyp <> yHeaderType);
            set0001.set_hedTyp = yHeaderType;
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
        exsr c_buildPgm;
        isTryed = bTrue;
        if (*in99 = *off);
          // Wenn das Programm neu erstellt werden konnte,
          // dann einen neuen Versuch unternehmen ...
          *in99 = '1';
          iter;
        else;
          // ... ansonsten abbrechen
          isCmdErr = bTrue;
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
//    reloadUsrStg  Aktualisieren Benutzereinstellungen       *
//============================================================*

begsr reloadUsrStg;

  if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
    leavesr;
  endif;

  if (##format <> 'FPEEKUSR');
    leavesr;
  endif;

  if (##file <> sds.user);
    leavesr;
  endif;

  //  *SPLASH
  set0005 = f_getUsrSg('*SPLASH'   );

endsr;

//============================================================*
//    pbInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr pbInit;

  //  Merker für: Subfile gelöscht setzen
  isPBINIT = bTrue;

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

  sflRec132 = 0;
  sflRec080 = 0;

  sflNbrRcd = 0;
  sflPinRows = 0;

  ##rcdNbr = 0;
  ##key = '';

  $$head132 = set0001.set_hedCol;
  $$head080 = set0001.set_hedCol;

  //  Aufbereiten der Überschrift
  exsr pbHeadline;

  //  Logischer Schalter für Tabellierung
  isTblCol = bFalse;

  //  Konvertieren nicht darstellbarer Zeichen
  isCvtChar = bFalse;

endsr;

//============================================================*
//    PBCsrTRcd     Übersetzen sflCsr ==> rel. Satznummer     *
//============================================================*

begsr pbCsrToRcd;

  if (sflCsr <= 0);
    wrk#RcdNbr = 0;
  else;
    if (*in88 = *off);
      sflRec132 = sflCsr;
      chain sflRec132 pbsfl132;
    else;
      sflRec080 = sflCsr;
      chain sflRec080 pbsfl080;
    endif;

    if (not %found());
      wrk#RcdNbr = 0;
    else;
      wrk#RcdNbr = recordNbr;
    endif;
  endif;

endsr;

//============================================================*
//    initSCmd      Initialisieren Kurzbefehl                 *
//============================================================*

begsr initSCmd;

  clear shortCmd;
  shortCmd.sc_action = '*INIT';
  shortCmd.sc_file = ##file;
  shortCmd.sc_lib = ##library;
  shortCmd.sc_mbr = ##member;
  peek42(h_file: h_lib: h_mbr: h_rcdFmt
        : shortCmd: wrk#RcdNbr: yExecCmd
        : yMsgID: yMsgDta);

endsr;

//============================================================*
//    pbReadUp      Vorwärts füllen der Subfile               *
//============================================================*

begsr pbReadUp;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    //  Erster Datensatz in Subfile ...
    isFirstSfl = bTrue;

    for do_x4 = 1 to *hival;
      exsr pbRead;
      if (isEOF = bTrue);
        *in83 = '1';
        leave;
      else;
        *in83 = '0';
      endif;

      if (*in88 = bFalse);
        sflRec132 = sflRec132 + 1;
      else;
        sflRec080 = sflRec080 + 1;
      endif;

      if (sflRec132 > 9999
          or sflRec080 > 9999);
        *in83 = '1';
        exsr pbReadP;
        leave;
      endif;

      if (sflRec132 > sflPage
          or sflRec080 > sflPage);
        exsr pbReadP;
        leave;
      endif;

      exsr pbFillDataRow_right;

      exsr pbSflWrite;

      if (*in88 = bFalse);
        sflNbrRcd = sflRec132;
      else;
        sflNbrRcd = sflRec080;
      endif;

      //  Setzen Cursor auf gefundenen Datensatz
      if (srchFndRcd = recordNbr);
        if (*in88 = bFalse);
          sfsanr = sflRec132;
        else;
          sfsanr = sflRec080;
        endif;
      endif;

      //  Aufbereiten Aufsetzkey bei 1. geschriebendem Datensatz
      if (isFirstSfl = bTrue);
        exsr pbGenKey;
      endif;

      //  Tabellierpapierfarben umschalten ...
      if (set0001.set_tblMde = bFalse);
      //         Modus ist ausgeschaltet
      else;
        if (isTblCol = bFalse);
          isTblCol = bTrue;
        else;
          isTblCol = bFalse;
        endif;
      endif;

      //  ... 1. Datensatz ist fertig
      isFirstSfl = bFalse;

    endfor;

  endif;

endsr;

//============================================================*
//    PBReadDn      1 Bildschirmseite rückwärts lesen         *
//============================================================*

begsr pbReadDown;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    wrk#ReadDn = wrk#ReadDn + sflPage;
    wrk#ReadDn = wrk#ReadDn - nbrPinRcd;

    for do_x5 = 1 to wrk#ReadDn;
      exsr pbReadP;
      if (isEOF = bTrue);
        leave;
      endif;

    endfor;

  endif;

  wrk#ReadDn = 0;

endsr;

//============================================================*
//    pbReadCsr     Setzen Dateizeiger auf aktuelle           *
//                  Cursor-Position  (sflCsr)                 *
//============================================================*

begsr pbReadCsr;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;
    if (sflCsr = 0);
    //      Nix tun, keine Datei vorhanden
    else;

      wrk#ReadDn = sflNbrRcd - sflCsr;
      wrk#ReadDn = wrk#ReadDn + 1;
      exsr pbMoveCsrD;

    endif;
  endif;

endsr;

//============================================================*
//    pbReadCsrA    Read to Cursor, after                     *
//                  Setzen Dateizeiger auf aktuelle           *
//                  Cursor-Position  +1  (sflCsr+1)           *
//============================================================*

begsr pbReadCsrA;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;
    if (sflCsr = 0);
    //      Nix tun, keine Datei vorhanden
    else;

      wrk#ReadDn = sflNbrRcd - sflCsr;
      exsr pbMoveCsrD;

    endif;
  endif;

endsr;

//============================================================*
//    pbMoveCsrD    Verschieben Dateizeiger (Richtung BOF)    *
//============================================================*

begsr pbMoveCsrD;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    for do_x6 = 1 to wrk#ReadDn;
      exsr pbReadP;
      if (isEOF = bTrue);
        leave;
      endif;

    endfor;

  endif;

  wrk#ReadDn = 0;

endsr;

//============================================================*
//    PBPinCol      Füllen Subfile mit pinned Spalten         *
//============================================================*

begsr pbPinColumn;

  isPinModeC = bTrue;

  //  Eintragen der gepinnten Spalten ...
  for pinCol_x = 1 to nbrPinCol;
    if (sflRowDataStr > sfl_row_size or sflRowDataStr > sflMaxRowLen);
      leave;
    endif;

    if (sflRowDataStr > sflPinRnge);
      p_sndPgmMg('USR8148' : pinTabCol(pinCol_x): sds.pgmName);
      exsr rmvPincolumn;
      if (isPinRmv = bTrue);
        pinCol_x = pinCol_x - 1;
      endif;
      iter;
    endif;

    //  ... einlesen der Felddaten
    clear f_key;
    f_key.f_field = pinTabCol(pinCol_x);
    chain(n) %kds(f_key) fpeekfld;
    if (not %found());
      // Eintrag austragen
      exsr rmvPincolumn;
      if (isPinRmv = bTrue);
        pinCol_x = pinCol_x - 1;
      endif;
      iter;
    endif;

    //  ... Feld nicht anzeigen
    if (f_hidden = bTrue);
      iter;
    endif;

    exsr pbReadFld1;
    if (isError = bTrue);
      leave;
    endif;

  endfor;

  isPinModeC = bFalse;

endsr;

//============================================================*
//    PBPinRcd      Füllen Subfile mit pinned Datensätzen     *
//============================================================*

begsr pbPinRcd;

  isPinModeR = bTrue;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    //  Eigener Schleifenindex: pbFillDataRow_right ruft über
    //  pbColor chkPinRcd auf, das pinRcd_x überschreibt
    for pinShow_x = 1 to max_pin_rcd;
      pinTabRcdE = pinTabRcd(pinShow_x);
      if (pinTabRcdE.rcdNbr = 0);
        leave;
      endif;

      if (f_chain04(pinTabRcdE.rcdNbr :
                 pinTabRcdE.file   :
                 pinTabRcdE.lib    :
                 pinTabRcdE.mbr    :
                 pinTabRcdE.rcdFmt ) = '1');
        //           Eintrag austragen
        pinRcd_x = pinShow_x;
        exsr rmvPinRcd;
        if (isPinRmv = bTrue);
          pinShow_x = pinShow_x - 1;
        endif;
        iter;
      endif;

      exsr pbFillDataRow_right;

      sflRec132 = sflRec132 + 1;
      sflRec080 = sflRec080 + 1;

      exsr pbSflWrite;
      sflPinRows = sflPinRows + 1;

      if (*in88 = bFalse);
        sflNbrRcd = sflRec132;
      else;
        sflNbrRcd = sflRec080;
      endif;

    endfor;

  endif;

  isPinModeR = bFalse;

endsr;

//============================================================*
//    chkPinRcd     Prüfen, ob Datensatz gepinned ist         *
//============================================================*

begsr chkPinRcd;

  pinRcd_x = 1;
  pinTabRcdE.rcdNbr = wrk#RcdNbr;
  pinTabRcdE.file = h_file;
  pinTabRcdE.lib = h_lib;
  pinTabRcdE.mbr = h_mbr;
  pinTabRcdE.rcdFmt = h_rcdFmt;
  pinTabRcdE.mbrNbr = h_mbrNbr;
  pinRcd_x = %lookup(
           pinTabRcdE: pinTabRcd: pinRcd_x);
  if (pinRcd_x > 0);
    isPinned = bTrue;
  else;
    isPinned = bFalse;
  endif;

endsr;

//============================================================*
//    chkPinCol     Prüfen, ob Spalte gepinned ist            *
//============================================================*

begsr chkPinCol;

  pinCol_x = 1;
  pinCol_x = %lookup(
           pin#Field: pinTabCol: pinCol_x);
  if (pinCol_x > 0);
    isPinned = bTrue;
  else;
    isPinned = bFalse;
  endif;

endsr;

//============================================================*
//    rmvPinRcd     Austragen Datensatz aus pIntAbr           *
//============================================================*

begsr rmvPinRcd;

  isPinRmv = bFalse;

  //  Remove pinned record from table
  for y = pinRcd_x to max_pin_rcd;
    z = y + 1;
    clear pinTabRcdE;
    if (z <= max_pin_rcd);
      pinTabRcd(y) = pinTabRcd(z);
      pinTabRcd(z) = pinTabRcdE;
    else;
      pinTabRcd(y) = pinTabRcdE;
    endif;
    isSflDirty = bTrue;
    isPinRmv = bTrue;
  endfor;

  //  Detrmine number of pinned records
  //  (find first free record)
  x = 1;
  clear pinTabRcdE;
  x = %lookup(pinTabRcdE: pinTabRcd: x);
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

  isPinRmv = bFalse;

  for y = pinCol_x to max_pin_col;
    z = y + 1;
    if (z <= max_pin_col);
      pinTabCol(y) = pinTabCol(z);
      pinTabCol(z) = *blanks;
    else;
      pinTabCol(y) = *blanks;
    endif;
    isSflDirty = bTrue;
    isPinRmv = bTrue;
  endfor;

  x = 1;
  pin#Field = *blanks;
  x = %lookup(pin#Field: pinTabCol: x);
  if (x > 0);
    nbrPinCol = x - 1;
  else;
    nbrPinCol = max_pin_col;
  endif;

endsr;

//============================================================*
//    pbRefresh     Aktualisieren der Subfile                 *
//============================================================*

begsr pbRefresh;

  //  Dateizeiger vor den ersten angezeigten Datensatz setzen:
  //  so viele Sätze zurücklesen, wie die Subfile ohne ihre
  //  gepinnten Zeilen enthält (nbrPinRcd kann sich seit dem
  //  Aufbau geändert haben, z.B. durch Auswahl P oder U)
  wrk#ReadDn = sflNbrRcd - sflPinRows;
  exsr pbMoveCsrD;
  exsr pbInit;
  exsr pbPinRcd;
  exsr pbReadUp;

  //  Evtl. ist die Subfile doch nicht leer ...
  //  (letzter Satz in der Liste wurde gelöscht oder
  //   der Schlüssel wurde geändert)
  if (*in80 = *off);
    exsr c_bot;
  endif;

endsr;

//============================================================*
//    PBHeadLine    Aufbereiten der Überschriftenzeile        *
//                  und füllen Tabelle mit anzuzeigenden      *
//                  Feldern                                   *
//============================================================*

begsr pbHeadline;

  //  Löschen der Überschrift
  $$head132 = '';
  $$head080 = '';

  if (not %open(peekFldL1));
    //  Keine Datei geöffnet
    leavesr;
  endif;

  //  Löschen Tabelle mit Feldpositionen ...
  exsr clrFldPosArray;

  //  Aufbereiten Pseudo-Datensatz
  peek20('*PHIVAL': io_buff: yMsgID: yMsgDta);

  if (yMsgID = '');

    //  Füllen der Überschriftenzeile ...
    sflMode = '*HEADLINE';
    wrk#SeqNbr = ##wndNbr;
    exsr pbFillHeadline_right;

    //  Übertragen der Überschriftenzeile
    //  in Bildschirmfeld ...
    $$head132 = sflDataRow;
    $$head080 = sflDataRow;
  endif;

endsr;

//============================================================*
//    PBFillLeft    Füllen einer Datenzeile von rechts        *
//                  nach links.                               *
//============================================================*

begsr pbFillDataRow_left;

  if (isOpen = bFalse);
  //  Keine Datei geöffnet
  else;

    //  Löschen Tabelle mit Feldpositionen ...
    exsr clrFldPosArray;

    //  Aufbereiten Pseudo-Datensatz
    peek20('*PHIVAL': io_buff: yMsgID: yMsgDta);

    if (yMsgID = '');

      //  Füllen der Überschriftenzeile ...
      sflMode = '*HEADLINE';
      wrk#SeqNbr = ##wndNbr;
      exsr pbFillHeadline_left;
    endif;
  endif;

endsr;

//============================================================*
//    PBFillRigh    Füllen einer Datenzeile von rechts        *
//                  nach links.                               *
//============================================================*

begsr pbFillDataRow_right;

  exsr setRcdId;

  sfpau = *blanks;
  recordNbr = file#X.rcdNbr;

  //  Prüfen auf Suchfunktion:
  //  *NORMAL/*REVERSE
  isFound = bFalse;

  if (srchField <> *blanks);
    if (srchType = '*REVERSE' or srchType = '*UNDERLINE');
      exsr srchFldAtr;
      exsr srchCompare;
    endif;
  endif;

  //  Füllen der Datenzeile ...
  sflMode = '*DATA';
  wrk#SeqNbr = ##wndNbr;
  exsr pbFillHeadline_right;

  //  Übertragen der Datenzeile in
  //  Bildschirmfeld ...
  data132 = sflDataRow;
  data080 = sflDataRow;

  //  ... anzeigen der Subfile
  *in80 = '1';

  //  ... Subfile-Satz nicht auswählen
  *in84 = '0';
  *in85 = '0';

endsr;

//============================================================*
//    setRcdId      Satzkennung des aktuellen Satzes setzen   *
//                  (Basisdatei, Bibliothek, Teildatei,       *
//                  Format und Teildatei-Nummer)              *
//============================================================*

begsr setRcdId;

  //  Basisdatei nur bei geänderter Satzkennung neu ermitteln
  if (file#X.file    <> rcdIdCache.file or
      file#X.library <> rcdIdCache.lib or
      file#X.member  <> rcdIdCache.mbr or
      file#X.rcdFmt  <> rcdIdCache.rcdFmt or
      file#X.mbrNbr  <> rcdIdCache.mbrNbr);
    f_basedPF(file#X.file      :
             file#X.library   :
             file#X.member    :
             file#X.rcdFmt    :
             file#X.mbrNbr    :
             rcdIdCache.pFile :
             rcdIdCache.pLib  :
             rcdIdCache.pMbr  :
             rcdIdCache.pRcdFmt);
    rcdIdCache.file = file#X.file;
    rcdIdCache.lib = file#X.library;
    rcdIdCache.mbr = file#X.member;
    rcdIdCache.rcdFmt = file#X.rcdFmt;
    rcdIdCache.mbrNbr = file#X.mbrNbr;
  endif;

  h_file = rcdIdCache.pFile;
  h_lib = rcdIdCache.pLib;
  h_mbr = rcdIdCache.pMbr;
  h_rcdFmt = rcdIdCache.pRcdFmt;
  h_mbrNbr = file#X.mbrNbr;

endsr;

//============================================================*
//    PBFill_R      Lesen der anzuzeigenden Felder und        *
//                  aufbereiten der Überschrift oder der      *
//                  Datenzeile, von links nach rechts         *
//============================================================*

begsr pbFillHeadline_right;

  //  Löschen Datentabelle ...
  clear sflDataRow;
  sflRowDataStr = 1;

  //  Eintragen gepinnter Spalten ...
  exsr pbPinColumn;

  //  Eintragen der Feldinhalte ...
  clear f1key_l1;
  f1key_l1.f_seq = wrk#SeqNbr;
  setll %kds(f1key_l1) fpeekfldl1;

  dow (sflRowDataStr <= sfl_row_size and sflRowDataStr <= sflMaxRowLen);
    read fpeekfldl1;
    if (%eof());
      leave;
    endif;

    //  ... Feld anzeigen?
    wrk#Field = f_field;
    exsr chkVisible;
    if (isVisible = bFalse);
      iter;
    endif;

    exsr pbReadFld1;
    if (isError = bTrue);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PBFill_L      Lesen der anzuzeigenden Felder und        *
//                  aufbereiten der Überschrift oder der      *
//                  Datenzeile, von rechts nach links         *
//============================================================*

begsr pbFillHeadline_left;

  //  Löschen Datentabelle ...
  clear sflDataRow;
  sflRowDataStr = 1;

  //  Eintragen gepinnter Spalten ...
  exsr pbPinColumn;

  //  Eintragen der Feldinhalte ...
  clear f1key_l1;
  f1key_l1.f_seq = wrk#SeqNbr;
  setgt %kds(f1key_l1) fpeekfldl1;

  dow (sflRowDataStr <= sfl_row_size and
     sflRowDataStr <= sflMaxRowLen);
    readp fpeekfldl1;
    if (%eof());
      leave;
    endif;

    //  ... Feld anzeigen?
    wrk#Field = f_field;
    exsr chkVisible;
    if (isVisible = bFalse);
      iter;
    endif;

    exsr pbReadFld1;
    if (isError = bTrue);
      leave;
    endif;

    if (##strPage > 1);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PBReadFld1    Hilfsroutine für PBReadFld                *
//============================================================*

begsr pbReadFld1;

  //  umsetzen der Daten in die Job CCSID
  if (sflMode = '*HEADLINE');
    yCvtCcsid = bFalse;
  else;
    yCvtCcsid = bTrue;
  endif;

  //  löschen Ausnahmebedingung für Spalte
  isColumnException = bFalse;

  //  merken Position für Farbattribut
  if (sflRowDataStr <= sfl_row_size);
    colrOfs = sflRowDataStr;
    sflRowDataStr = sflRowDataStr + 1;
  else;
    colrOfs = 0;
  endif;

  //  aufbereiten des Feldinhaltes
  //  für Anzeigeformat gemäß EDITCODE ...
  fldl0100 = f_ffd;
  if (f_edtCde <> *blanks);
    fldl0100.f1EdtC = f_edtCde;
  else;
  //  ... Original EDITCODE verwenden
  endif;

  monitor;
    //  umsetzen Datensatzpuffer in Bildschirmdarstellung ...
    if (set0001.set_dspMde = '*DSPNRM');
      //  ... für Normale Anzeige
      if (io_nullMap(fldl0100.f1seq) = 1);
        peek06(fldl0100: 'FLDL0100': *allx'00'
              : bFalse: yCvtCcsid
              : yOutBuffer: yOutBuffLn
              : yMsgID: yMsgDta);
        if (f_isNumFld(fldl0100) = bTrue);
          if (yOutBuffLn > 1);
            %subst(yOutBuffer: 1: yOutBuffLn - 1) = '';
          endif;
          %subst(yOutBuffer
                : yOutBuffLn
                : %len(HEX_CHAR)) = HEX_CHAR;
        else;
          yOutBuffer = HEX_CHAR;
        endif;
      else;
        peek06(fldl0100: 'FLDL0100': io_buff
              : bFalse: yCvtCcsid
              : yOutBuffer: yOutBuffLn
              : yMsgID: yMsgDta);
      endif;

    else;
      //  ... für Hex-Anzeige
      if (io_nullMap(fldl0100.f1seq) = 1);
        yHexString = HEX_CHAR;
        yStringLen = f_buffLn(fldl0100);
      else;
        yStringLen = f_rtvFld(yString  :
                             io_buff  :
                             fldl0100 );
        yHexString = ' ';
        p_hexToChr(yHexString    :
                  yString       :
                  yStringLen * 2);
      endif;

      yOutBuffLn = yStringLen * 2;
    endif;
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  //  Fehler bei der Aufbereitung ...
  if (*in99 = *on);
    //  ... ja
    isError = bTrue;
  else;
    //  ... nein
    isError = bFalse;

    //  ermitteln der Spaltenbreite
    //  anhand der Überschrift und
    //  der Feldlänge, sowie der
    //  maximalen Spaltenbreite ...
    fldl0100 = f_ffd;
    columnLen = 0;
    fieldLen = yOutBuffLn;
    maxColLen = f_maxSize;

    //  Konvertierung nicht darstellbarer Zeichen ...
    if (sflMode = '*HEADLINE' or set0001.set_dspMde = '*DSPHEX');
    //  ... keine Konvertierung bei der
    //      Aufbereitung der Überschriftenzeile
    else;
      //  ... sonst konvertieren
      monitor;
        peek32(yOutBuffer: yOutBuffLn: 0
              : yMsgID: yMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

      if (*in99 = *off);
        if (isCvtChar = bFalse);
          if (yMsgID <> *blanks);
            isCvtChar = bTrue;
            p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
            yMsgID = '';
            yMsgDta = '';
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
    colHeading = f_headline(set0001.set_hedTyp: fldl0100);
    headLen = %checkr(' ': colHeading);

    if (sflMode = '*HEADLINE');
      yHexString = colHeading;
    endif;

    colHeading = '';

    //  ... Bestimmen der Spaltenbreite
    if (headLen > fieldLen);
      columnLen = headLen;
    else;
      columnLen = fieldLen;
    endif;

    if (columnLen > maxColLen);
      columnLen = maxColLen;
    endif;

    //  ... numerische Werte rechtsbündig setzen,
    //      wenn Spaltenbereite kleiner als Feldlänge
    if (sflMode   = '*HEADLINE');

      //      ... für die Überschrift
      if ((columnLen < headLen ) or
          (columnLen < fieldLen));

        select;
        when ((headLen + 3) <= columnLen);
          %subst(yHexString: headLen + 1: 3)
          = %subst('...': 1: 3);
        other;
          %subst(yHexString: columnLen - 2 + 1: 2)
          = %subst('...': 1: 2);
        endsl;

      endif;

    else;

      //      ... für die Datenzeile
      if ((sflMode   <> '*HEADLINE') and
          (columnLen <  fieldLen   ));
        if (f_isNumFld(fldl0100) = bTrue);
          //          ... numerische Werte
          if ((set0001.set_enExc = bTrue) and
              (%subst(yHexString          :
                   1                   :
                   fieldLen - columnLen) <> *blanks));
            isColumnException = bTrue;
          endif;
          yHexString = %subst(yHexString              :
                             1 + fieldLen - columnLen:
                             columnLen               );
        else;
          //          ... alphanumerische Werte
          if ((set0001.set_enExc = bTrue) and
              (%subst(yHexString              :
                   columnLen + 1           :
                   1 + fieldLen - columnLen) <> *blanks));
            isColumnException = bTrue;
          endif;
        endif;

      endif;
    endif;

    //  ... Berechnen der Startposition im Puffer
    sflDataLenFree =
     sflMaxRowLen - sflRowDataStr + 1;

    if (##wndNbr = f_seq);

      if ((##strPage * sflDataLenFree) > columnLen);

        if ((columnLen / sflDataLenFree) =
            f_int(columnLen / sflDataLenFree));
          ##strPage = (columnLen / sflDataLenFree);
        else;
          ##strPage = (columnLen / sflDataLenFree) + 1;
        endif;

      endif;

      fldStrPos = (##strPage -1) * sflDataLenFree
                 + 1;
    else;
      fldStrPos = 1;
    endif;

    //  ... Berechnen der zu extrahierenden Länge
    buffIdx = fldStrPos;
    sflRowDataEnd = sflRowDataStr + columnLen;
    sflRowDataEnd = sflRowDataEnd - fldStrPos;

    if (sflRowDataEnd > sfl_row_size);
      sflRowDataEnd = sfl_row_size;
    endif;

    sflRowDataLen =
     sflRowDataEnd - sflRowDataStr + 1;

    //  ... übertragen aufbereitetes Feld in Subfile
    %subst(sflDataRow: sflRowDataStr) =
    %subst(yHexString: buffIdx: sflRowDataLen);

    //  ... pflegen der Tabelle mit den Werten der
    //      Spaltenaufteilung ...
    if (sflRowDataEnd >= sflRowDataStr);
      //      ... pflegen der Feldpositionstabelle
      if (sflMode = '*HEADLINE');
        cp = cp + 1;
        col_field(cp) = fldl0100.f1FNme;
        col_scnStr(cp) = sflRowDataStr;
        col_scnEnd(cp) = sflRowDataEnd;
        //          ... ist das Feld komplett sichtbar?
        if (col_scnEnd(cp) <= sflMaxRowLen);
          //              ... ja, kein Fehler
          col_error(cp) = bFalse;
        else;
          //              ... nein, Fehler!
          col_error(cp) = bTrue;
        endif;
      endif;

      sflRowDataStr = sflRowDataEnd + 1;

      //      ... Löschen von "überstehendem" Datenmüll
      if (columnLen = maxColLen and
         sflRowDataStr <= sfl_row_size);
        sflDataRow.chars(sflRowDataStr) = '';
      endif;

      //      ... umschalten auf "normale" Farbdarstellung
      if (sflRowDataStr <= sfl_row_size);
        wrk#Ofs = sflRowDataStr;
        exsr pbStdCol;
      endif;

      //      ... "nachziehen" der Spaltenfarbe
      if (colrOfs <= 0);
      //          ... Pech gehabt
      else;
        if (sflMode = '*HEADLINE');
          if ((f_kSeq = 0) or
              (accessMode = RRN_SEQ));
            sflDataRow.chars(colrOfs) = set0001.set_hedCol;
          else;
            sflDataRow.chars(colrOfs) = set0001.set_keyCol;
          endif;
        else;
          exsr pbColor;
        endif;
      endif;
    endif;

  endif;

endsr;

//============================================================*
//    pbStdCol      Setzen der "normalen" Datensatzfarbe      *
//============================================================*

begsr pbStdCol;

  if (isTblCol = bFalse);
    sflDataRow.chars(wrk#Ofs) = set0001.set_stdCol;
  else;
    sflDataRow.chars(wrk#Ofs) = set0001.set_tblCol;
  endif;

endsr;

//============================================================*
//    pbGenKey      Generieren Aufsetzkey                     *
//                  für die Anzeige auf dem Bildschirm        *
//============================================================*

begsr pbGenKey;

  if (accessMode = KEY_SEQ);
    exsr pbBuildKey;
  else;
    exsr pbBuildRrn;
  endif;

endsr;

//============================================================*
//    pbBuildRrn    Generieren Aufsetzkey: RRN                *
//============================================================*

begsr pbBuildRrn;

  ##rcdNbr = recordNbr;

endsr;

//============================================================*
//    pbBuildKey    Generieren Aufsetzkey                     *
//============================================================*

begsr pbBuildKey;

  monitor;
    peek19(io_buff: yKeyVal: yMsgID: yMsgDta);

    //  ... Konvertieren nicht darstellbarer Zeichen
    yOutBuffer = yKeyVal;
    yOutBuffLn = 132;

    peek32(yOutBuffer: yOutBuffLn: 0
          : yMsgID: yMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  ##key = yOutBuffer;

endsr;

//============================================================*
//    pbGenIntKy    Generieren internen Aufsetzkey            *
//                  für einen Dateizugriff                    *
//============================================================*

begsr pbGenIntKy;

  if (accessMode = KEY_SEQ);
    exsr pbIntKey;
  else;
    exsr pbIntRrn;
  endif;

endsr;

//============================================================*
//    pbIntRrn      Generieren interne Satznummer             *
//============================================================*

begsr pbIntRrn;

  wrk#RcdNbr = wrk#RcdNbr;

endsr;

//============================================================*
//    pbIntKey      Generieren internen Aufsetzschlüssel      *
//============================================================*

begsr pbIntKey;

  peek20(wrk#KeyVal: yBuffer
        : yMsgID: yMsgDta);
  wrk#KeyVal = yBuffer;

endsr;

//============================================================*
//    pbColor       Setzen der Spaltenfarbe                   *
//                  für Datenzeilen                           *
//                  a) für gepinnte Datensätze                *
//                  b) für normale Datensätze                 *
//============================================================*

begsr pbColor;

  if (colrOfs = 0);
  //                 Nix tun
  else;

    if (isColumnException = bTrue);
      sflDataRow.chars(colrOfs) = set0001.set_excCol;
    else;

      //---------------------------------------*
      //  Berücksichtigen des Aufrufs von:     *
      //  a) anzeigen "normaler" Datensätze    *
      //  b) anzeigen "gepinnter" Datensätze   *
      //---------------------------------------*
      if (isPinModeR = bFalse);
        if (isPinModeC = bFalse);
          //      ... nix ist gepinnt
          isPinned = bFalse;
        else;
          //      ... prüfen auf gepinnte Spalten
          pin#Field = fldl0100.f1FNme;
          exsr chkPinCol;
        endif;
      else;
        //      ... prüfen auf gepinnte Zeilen (=Datensätze)
        wrk#RcdNbr = recordNbr;
        exsr chkPinRcd;
      endif;

      //---------------------------------------*
      //  ... setzen der Datenfarbe            *
      //---------------------------------------*
      //  Spaltenmarkierung ...
      if (f_markCol = bTrue);
        sflDataRow.chars(colrOfs) = f_color;
      else;
        //  Keine Spaltenmarkierung ...
        if (isPinned = bTrue);
          //      ... pinned Datensatz
          sflDataRow.chars(colrOfs) = set0001.set_pinCol;
        else;
          //      ... normaler Datensatz
          wrk#Ofs = colrOfs;
          exsr pbStdCol;
        endif;
      endif;

      //---------------------------------------*
      //  ... Datensatz gefunden               *
      //---------------------------------------*
      if (isPinned = bFalse);
        select;
        //      ... Suchfunktionen: *REVERSE
        when (srchType = '*REVERSE');
          if (isFound = bTrue);
            sflDataRow.chars(colrOfs) = set0001.set_revCol;
          endif;

        //      ... Suchfunktionen: *UNDERLINE
        when (srchType = '*UNDERLINE');
          if (isFound = bTrue);
            sflDataRow.chars(colrOfs) = set0001.set_undCol;
          endif;

        //      ... Suchfunktionen: *NORMAL
        when (srchType = '*NORMAL');
          if (srchFndRcd = recordNbr);
            sflDataRow.chars(colrOfs) = set0001.set_nmlCol;
          endif;

        other;
        //       Andere Suchtypen gibt's nicht
        endsl;
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    pbSetLL       Setzen Dateizeiger RRN/KEY                *
//============================================================*

begsr pbSetLL;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    select;
    when (accessMode = KEY_SEQ);
      CIO_setllWithKey(hFile02: wrk#KeyVal);
      exsr f2toFx;
    when (accessMode = RRN_SEQ);
      CIO_setllWithRRN(hFile01: wrk#RcdNbr);
      exsr f1toFx;
    when (accessMode = SQL_SEQ);
    other;
    endsl;

  endif;

endsr;

//============================================================*
//    pbSetGT       Setzen Dateizeiger RRN/KEY                *
//============================================================*

begsr pbSetGT;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    select;
    when (accessMode = KEY_SEQ);
      CIO_setgtWithKey(hFile02: wrk#KeyVal);
      exsr f2toFx;
    when (accessMode = RRN_SEQ);
      CIO_setgtWithRRN(hFile01: wrk#RcdNbr);
      exsr f1toFx;
    when (accessMode = SQL_SEQ);
    other;
    endsl;

  endif;

endsr;

//============================================================*
//    pbMoveTop     Setzen Dateizeiger auf BOF                *
//============================================================*

begsr pbMoveTop;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    if (accessMode = SQL_SEQ);
      SQL_gotoTop(yMsgID: yMsgDta);
      if (yMsgID <> '');
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
      endif;
    else;
      wrk#KeyVal = '*LOVAL';
      wrk#RcdNbr = LOW_RCD_NBR;

      exsr pbGenIntKy;
      exsr pbSetLL;
    endif;

  endif;

endsr;

//============================================================*
//    pbMoveBot     Setzen Dateizeiger auf EOF                *
//============================================================*

begsr pbMoveBot;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    if (accessMode = SQL_SEQ);
      SQL_gotoBottom(yMsgID: yMsgDta);
      if (yMsgID <> '');
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
      endif;
    else;
      wrk#KeyVal = '*HIVAL';
      wrk#RcdNbr = HIGH_RCD_NBR;

      exsr pbGenIntKy;
      exsr pbSetGT;
      exsr pbReadP;
    endif;

  endif;

endsr;

//============================================================*
//    clrFldArray   Löschen Felder Array                      *
//============================================================*

begsr clrFldPosArray;

  col_field(*) = '';
  col_scnStr(*) = 0;
  col_scnEnd(*) = 0;
  col_error(*) = bFalse;
  cp = 0;

endsr;

//============================================================*
//    ChangeFile    Prüfen, ob die Datei gewechselt hat       *
//============================================================*

begsr changeFile;

  isFileChg = bFalse;

  if (l#File <> ##file
      or l#Library <> ##library
      or l#Member <> ##member
      or l#Format <> ##format);

    isFileChg = bTrue;
    //  ... Änderungen prüfen
    if (##member = l#Member);
      ##member = *blanks;
    endif;

    if (##format = l#Format);
      ##format = *blanks;
    endif;

    exsr closeFile;

    if (##file <> *blanks);
      accessMode = newAccessMode;
      exsr openFile;
    endif;
  endif;

  exsr getOpnFile;
  exsr getMaxSeq;

endsr;

//============================================================*
//    changeWnd     Prüfen, ob Fenster gewechselt hat         *
//============================================================*

begsr changeWnd;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgNoFile;
  else;

    if (##field <> *blanks);
      wrk#Field = ##field;
      exsr getSeqNbr;
      if (isSeqNbrOK = bTrue);
        ##wndNbr = wrk#SeqNbr;
        ##strPage = 1;
      else;
        //  Fehlermeldung ...
        clear usr8108;
        usr8108.var1 = ##field;
        usr8108.var2 = ##file;
        usr8108.var3 = ##library;
        p_sndPgmMg('USR8108': usr8108: sds.pgmName);
      endif;

      ##field = *blanks;
    endif;

  endif;

endsr;

//============================================================*
//    changeKey     Prüfen, ob der Aufsetzkey gewechselt hat  *
//                  Auslösen über *IN93                       *
//============================================================*

begsr changeKey;

  if (##rcdNbr <> r#RcdNbr
      or ##key <> r#KeyVal);
    isKeyChg = bTrue;
  else;
    isKeyChg = bFalse;
  endif;

  select;
  when (##rcdNbr < LOW_RCD_NBR);
    ##rcdNbr = LOW_RCD_NBR;
  when (##rcdNbr > HIGH_RCD_NBR);
    ##rcdNbr = HIGH_RCD_NBR;
  other;
  //    Im gültigen Bereich ...
  endsl;

endsr;

//============================================================*
//    changeSort    Wechseln der Sortierfolge                 *
//============================================================*

begsr changeSort;

  l#File = *blanks;
  l#Library = *blanks;
  l#Member = *blanks;
  l#Format = *blanks;

  //  Merken der letzten Cursorposition
  select;
  //    ... außerhalb der Subfile
  when (sflCsr <= *zeros);
    //        ... wird später anhand der
    //            Cursorposition auf dem Bildschirm entschieden
    sflCsr = *zeros;

  //    ... innerhalb der Subfile
  when (sflCsr > nbrPinRcd);
  //        ... wird genau dort positioniert

  //    ... innerhalb der gepinnten Datensätze
  other;
    //        ... auf 1. angezeigten Datensatz positionieren
    sflCsr = 1 + nbrPinRcd;
  endsl;

  //  Umsetzen Cursorposition in Satznummer
  exsr pbCsrToRcd;
  if (wrk#RcdNbr > *zeros);
    //**  File#04.Open  ANDEQ     '1'
    last#RcdNr = wrk#RcdNbr;
  else;
    last#RcdNr = *zeros;
  endif;

  //  Wechsel der Datei ...
  isPinToClr = bFalse;
  exsr changeFile;
  isPinToClr = bTrue;

  //  Prüfen Seq-Bereich (##wndNbr) ...
  exsr chkSeqRnge;

  //  Wechsel des Fenster (##field) ...
  exsr changeWnd;

  clear ##rcdNbr;
  clear ##key;
  clear r#RcdNbr;
  clear r#KeyVal;

  yMsgID = *blanks;
  yMsgDta = *blanks;

  if (last#RcdNr = *zeros);
  //    Alter Datensatz ist nicht bekannt ...
  else;
    //    ... Einlesen letzten Datensatz
    recordNbr = last#RcdNr;

    if (f_chain04(recordNbr:
               h_file   :
               h_lib    :
               h_mbr    :
               h_rcdFmt ) = '1');
    //    ... Zugriff fehlgeschlagen
    else;
      //    ... Generieren Aufsetzkey
      exsr pbGenKey;
    endif;
  endif;

  //  Wechsel des Aufsetzkeys ...
  exsr changeKey;

  //  Füllen der Subfile ...
  if (isKeyChg = bFalse);
    if (cursorPosition.row > sflLastRw);
      //    ... unterhalb der Subfile
      exsr c_bot;
    else;
      //    ... oberhalb der Subfile,
      //        bzw. kein Wechsel des Aufsetzkeys
      exsr c_top;
    endif;
  else;
    //    ... neuer Aufsetzkey innerhalb der Subfile
    exsr keyHasChg;
  endif;

endsr;

//============================================================*
//    openFile      Datei öffnen                              *
//============================================================*

begsr openFile;

  //  Wenn eine Datei bereits geöffnet ist ...
  if (isOpen = bTrue);
    //  ... dann geöffnet lassen
    leavesr;
  endif;

  yCursorPosition.row = 0;
  yCursorPosition.column = 0;

  exsr chkPrvFile;

  //  ... erst die Plausi prüfen, dann ...
  if (##library = *blanks);
    ##library = '*LIBL';
  endif;

  if (##member = *blanks);
    ##member = '*FIRST';
  endif;

  //  ... Objektbeschreibung
  //      ... abrufen der Objektattribute (auflösen *LIBL, *CURLIB)
  exsr getObjAttr;
  if (isError = bTrue);
    //  Fehler aufgetreten, Öffnen abbrechen.
    exsr msgNoFile;
    leavesr;
  endif;

  //  ... Teildateien
  if (##member = '*NONE');
    $$noMb = 0;
  else;
    //      ... abrufen der Anzahl Teildateien
    exsr getNbrMbr;
    if ($$noMb = 0);
      //  Keine Teildateien vorhanden.
      ##member = '*NONE';
    endif;
  endif;

  //      ... prüfen auf phys. Datei bei Zugriff über SQL
  //** %SQL%          IF        (accessMode = SQL_SEQ and ATFILA <> '*PHY')
  //**                Exsr      MsgInvSqlFile
  //**                Leavesr
  //**                ENDIF

  //      ... prüfen Name der Teildatei
  exsr checkMbrName;
  if (isError = bTrue);
    //  Fehler aufgetreten, Öffnen abbrechen.
    exsr msgNoFile;
    leavesr;
  endif;

  //  ... Satzformate
  //      ... abrufen der Satzformate
  exsr getFmtList;
  if (yMsgID <> '');
    //  Satzformate konnten nicht abgerufen werden (USR0002),
    //  Öffnen abbrechen.
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    exsr msgNoFile;
    leavesr;
  endif;
  //      ... auswählen Satzformat
  exsr getRcdFrmt;

  //  ... prüfen auf Schlüsselfelder
  //      und initialisieren von PEEK41 (= Dateiinformationen)
  exsr getNbrKeyF;
  //      ... wenn keine Schlüsselinformationen
  //          vorhanden sind, ...
  if (isKeyAvail = bFalse
      and accessMode = KEY_SEQ);
    //          ... dann über RRN zugreifen
    accessMode = RRN_SEQ;
  else;
  //          ... sonst Modus beibehalten
  endif;

  //  Ermitteln Sortierung bei Zugriff über SQL ...
  if (accessMode = SQL_SEQ);
    if (sqlOrder = '*KEY');
      peek38(##file: ##library: sqlOrder);
    else;
      sqlOrder = SQL_quote(f_ucase(sqlOrder));
    endif;
  endif;

  // -------------------------------------------------
  //  Prüfen Zugriffsrechte
  // -------------------------------------------------

  //      ... prüfen Zugriffsrechte
  exsr s_exit01;

  //      ... Zugriff nicht erlaubt
  if (auth.isAccessAlw <> bTrue);
    exsr closeFile;
    p_rmvPgmMg(sds.pgmName);
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    leavesr;
  endif;

  // -------------------------------------------------
  //  Datei öffnen für Einzelzugriff (Aktualisierung)
  // -------------------------------------------------

  if (##member = '*NONE');
    clear hFile00;
    file#X.isOpen = bFalse;
    file#X.file = ##file;
    file#X.library = ##library;
    file#X.rcdLen = 0;
    file#X.member = ##member;
    file#X.rcdFmt = ##format;
    file#X.mbrNbr = 0;
    file#X.rcdNbr = 0;
    isOpen = bFalse;
  else;

    f_execute('OVRDBF ' +
               'FILE(' + %trim(##file) + ') ' +
               'TOFILE(' +
                 %trim(##library) + '/' +
                 %trim(##file) + ') ' +
               'MBR(' + %trim(##member) + ') ' +
               'OVRSCOPE(*ACTGRPDFN) ' +
               'SHARE(*NO) ' +
               'SEQONLY(*NO) SECURE(*YES)'
             : yMsgID: yMsgDta);
    yMsgID = '';
    yMsgDta = '';

    //      ... Änderungen erlaubt
    if (auth.isUpdAlw = bTrue);
      commitLvl = '1';
      //          ... mit Commit-Steuerung
      if CIO_open(hFile00
               : ##file
               : ##library
               : ##member
               : ##format
               : 'rr+, arrseq=Y, commit=Y, +
                  nullcap=Y, riofb=Y, +
                  secure=N, ccsid=65535') = bTrue;
        exsr f0toFx;
        isUpdMod = bTrue;
      else;
        //          ... ohne Commit-Steuerung
        commitLvl = '0';
        if CIO_open(hFile00
                 : ##file
                 : ##library
                 : ##member
                 : ##format
                 : 'rr+ , arrseq=Y, commit=N, +
                    nullcap=Y, riofb=Y, +
                    secure=N, ccsid=65535') = bTrue;

          exsr f0toFx;
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
    if (accessMode = KEY_SEQ);
      if CIO_open(hFile02
               : ##file
               : ##library
               : ##member
               : ##format
               : 'rr, arrseq=N, commit=N, +
                  nullcap=Y, riofb=Y, +
                  secure=N, ccsid=65535') = bTrue;
        *in99 = *off;
      else;
        *in99 = *on;
        CIO_getErrorMsg(hFile02: yMsgID: yMsgDta);
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
      endif;
      exsr f2toFx;
    endif;

    //  Sortierung 1 nach Satzfolge
    if (accessMode = RRN_SEQ);
      if CIO_open(hFile01
               : ##file
               : ##library
               : ##member
               : ##format
               : 'rr, arrseq=Y, commit=N, +
                  nullcap=Y, riofb=Y, +
                  secure=N, ccsid=65535') = bTrue;
        *in99 = *off;
      else;
        *in99 = *on;
        CIO_getErrorMsg(hFile01: yMsgID: yMsgDta);
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
      endif;
      exsr f1toFx;
    endif;

    //  Sortierung 3 nach Sql
    if (accessMode = SQL_SEQ);
      clear usr0013;
      p_sndStsMg('USR0013': usr0013);
      if (SQL_prepareStatement(
                  '0'       :
                  ##file    :
                  ##library :
                  ##member  :
                  ##format  :
                  sqlWhere  :
                  sqlOrder  :
                yMsgID      :
                yMsgDta     ) = bTrue);
        if (SQL_open(hFile03     :
                  yMsgID      :
                  yMsgDta     ) = bTrue);
          *in99 = *off;
          yMsgID = '';
          yMsgDta = '';
        else;
          *in99 = *on;
          CIO_getErrorMsg(hFile03: yMsgID: yMsgDta);
          p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
          yMsgID = '';
          yMsgDta = '';
        endif;
        exsr f3toFx;
      else;
        *in99 = *on;
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
      endif;
    endif;

    f_execute('DLTOVR ' +
               'FILE(' + %trim(##file) + ') ' +
               'LVL(*ACTGRPDFN) '
             : yMsgID: yMsgDta);
    yMsgID = '';
    yMsgDta = '';

    if (*in99 = *on);
      leavesr;
    endif;
    //      Datei geöffnet ...
    //      ... OPEN-Flag
    isOpen = bTrue;

  endif;

  //      ... aber Satzlänge größer 32766
  if (file#X.rcdLen > RCD_BUFF_LEN);
    exsr closeFile;
    p_rmvPgmMg(sds.pgmName);
    clear usr8207;
    usr8207.var1 = RCD_BUFF_LEN;
    p_sndPgmMg('USR8207': usr8207: sds.pgmName);
  else;

    // ... löschen Pin-Funktion
    exsr clrPinCol;
    exsr clrPinRow;
    // ... auswerten Rückkehrcode
    if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
      // ... Abbruch mit F3/F12
      exsr closeFile;
    else;
      // ... weiter
      // ... abrufen der Feldliste
      exsr getFldList;
      // ... abrufen der Schlüsselfelder
      exsr getKeyList;
      // ... Sortieren der Schlüsselfelder
      exsr floatKeys;
      // ... Fensterposition
      ##wndNbr = 0;
      ##strPage = 0;
      // ... Suchmodus
      exsr srchInz;
      // ... Blätternfunktion Einzelsatz
      yScreenNbr = 0;
      // ... abrufen der Teildateiattribute
      exsr getMbrAttr;
      // ... initialisieren Kurzbefehl
      exsr initSCmd;
      // ... Nachrichten entfernen
      p_rmvPgmMg(sds.pgmName);
      // ... einblenden Aufsetzkey
      if (accessMode = KEY_SEQ);
        *in70 = '1';
      else;
        *in70 = '0';
      endif;
      // ... Cursor auf Keyeingabezeile setzen
      exsr c_posCsr;

      // ... Felder, welche nicht erlaubt sind
      clear f_key;
      f_key.f_field = *blanks;
      setll %kds(f_key) fpeekfld;
      dow ('1');
        read fpeekfld;
        if (%eof());
          leave;
        endif;
        if (f_isNotAlw(f_ffd) = bTrue);
          p_sndPgmMg('USR8196': f_field: sds.pgmName);
        endif;
      enddo;

      // ... Prüfen der Registrierung
      exsr c_register;
      if (isLicenceError = bTrue);
        exsr closeFile;
      endif;

      // ... Datei geöffnet ...
      if (isOpen = bTrue);
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
          usr0007.var1 = ##file;
          usr0007.var2 = ##library;
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
//    pbRead        Lesen in Satz- oder Schlüsselfolge        *
//============================================================*

begsr pbRead;

  isFileError = bFalse;

  dou ((file#X.rcdFmt = ##format) or (*in99 = *on));

    select;
    when (accessMode = KEY_SEQ);
      if (CIO_read(hFile02: bFalse
                : io_buff: io_nullMap) = bEOF);
        *in99 = *on;
      else;
        *in99 = *off;
      endif;
      exsr f2toFx;
      isFileError = CIO_isError(hFile02);
    when (accessMode = RRN_SEQ);
      if (CIO_read(hFile01: bFalse
                : io_buff: io_nullMap) = bEOF);
        *in99 = *on;
      else;
        *in99 = *off;
      endif;
      exsr f1toFx;
      isFileError = CIO_isError(hFile01);
    when (accessMode = SQL_SEQ);
      if (SQL_nextRow(io_buff: io_nullMap: hFile03:
                   yMsgID : yMsgDta)  = bEOF);
        *in99 = *on;
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
      else;
        *in99 = *off;
        yMsgID = '';
        yMsgDta = '';
      endif;
      exsr f3toFx;
      isFileError = CIO_isError(hFile03);
    other;
    endsl;

  enddo;

  if (isFileError = bTrue);
    isEOF = bTrue;
  else;
    if (*in99 = *on);
      exsr pbMoveBot;
      isEOF = bTrue;
    else;
      isEOF = bFalse;
    endif;
  endif;

endsr;

//============================================================*
//    pbReadP       Rückwärts lesen in Satz- oder             *
//                  Schlüsselfolge                            *
//============================================================*

begsr pbReadP;

  dou ((file#X.rcdFmt = ##format) or (*in99 = *on));

    select;
    when (accessMode = KEY_SEQ);
      if (CIO_readp(hFile02: bFalse
                 : io_buff: io_nullMap) = bEOF);
        *in99 = *on;
      else;
        *in99 = *off;
      endif;
      exsr f2toFx;
    when (accessMode = RRN_SEQ);
      if (CIO_readp(hFile01: bFalse
                 : io_buff: io_nullMap) = bEOF);
        *in99 = *on;
      else;
        *in99 = *off;
      endif;
      exsr f1toFx;
    when (accessMode = SQL_SEQ);
      if (SQL_previousRow(io_buff: io_nullMap: hFile03:
                       yMsgID : yMsgDta) = bEOF);
        *in99 = *on;
        if (yMsgID <> '');
          p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
          yMsgID = '';
          yMsgDta = '';
        endif;
      else;
        *in99 = *off;
        yMsgID = '';
        yMsgDta = '';
      endif;
      exsr f3toFx;
      isFileError = CIO_isError(hFile03);
    other;
    endsl;

  enddo;

  if (*in99 = *on);
    exsr pbMoveTop;
    isEOF = bTrue;
  else;
    isEOF = bFalse;
  endif;

endsr;

//============================================================*
//    f0toFx        Übertragen der Dateiinformationen         *
//                  (Status usw.) der Datei 00 in die         *
//                  "globalen Felder Fx                       *
//============================================================*

begsr f0toFx;

  file#X = CIO_getInfDS(hFile00);

endsr;

//============================================================*
//    f1toFx        Übertragen der Dateiinformationen         *
//                  (Status usw.) der Datei 01 in die         *
//                  "globalen Felder Fx                       *
//============================================================*

begsr f1toFx;

  file#X = CIO_getInfDS(hFile01);

endsr;

//============================================================*
//    f2toFx        Übertragen der Dateiinformationen         *
//                  (Status usw.) der Datei 02 in die         *
//                  "globalen Felder Fx                       *
//============================================================*

begsr f2toFx;

  file#X = CIO_getInfDS(hFile02);

endsr;

//============================================================*
//    f3toFx        Übertragen der Dateiinformationen         *
//                  (Status usw.) der Datei 03 in die         *
//                  "globalen Felder Fx                       *
//============================================================*

begsr f3toFx;

  file#X = CIO_getInfDS(hFile03);

endsr;

//============================================================*
//    repeatOpt     Wiederholen der Subfileauswahl            *
//============================================================*

begsr repeatOpt;

  //  "Keine Sätze vorhanden"
  if (*in80 = *off);
  //  ... nix zu tun
  else;

    //  Lese alle Sätze der Subfile ab wrk#Recno ...
    for x = wrk#Recno to sflNbrRcd;

      sflRec132 = x;
      sflRec080 = x;
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
          sfpau = wrk#SFPAU;
          *in84 = '1'; // SFLNXTCHG
          exsr pbSflUpdate;
        endif;
      endif;

    endfor;

  endif;

endsr;

//============================================================*
//    getFrstFld    Ermitteln der Feldnummer des ersten       *
//                  sichtbaren Feldes                         *
//============================================================*

begsr getFrstFld;

  if (isOpen = bFalse);
    ##wndNbr = 0;
  else;

    ##wndNbr = 0;

    for x = 1 to cp;

      //  ... Feldsatz zuerst lesen: chkVisible prüft f_hidden des
      //      gelesenen Satzes (sonst gilt der zuletzt gelesene Satz,
      //      z.B. ein ausgeblendetes letztes Feld)
      clear f_key;
      f_key.f_field = col_field(x);
      chain(n) %kds(f_key) fpeekfld;
      if (not %found(peekFld));
        // ... kann eigentlich nicht sein
        iter;
      endif;

      wrk#Field = col_field(x);
      exsr chkVisible;
      if (isVisible = bTrue);
        //  ... sichtbar: Sequenznummer übernehmen
        ##wndNbr = f_seq;
        leave;
      endif;

    endfor;

  endif;

  //  Merken letzte Feldposition
  l#WndNbr = ##wndNbr;

  exsr chkSeqRnge;

endsr;

//============================================================*
//    GetPgmName    Berechnen Programmname                    *
//============================================================*

begsr getPgmName;

  peekPgm = 'P' +
             %subst(rcdl0200.r2FmtID: 1: 2) +
             %subst(rcdl0200.r2FmtID: 7: 7);

endsr;

//============================================================*
//    GetDSpName    Berechnen Name Displayfile                *
//============================================================*

begsr getDspName;

  peekDspF = 'F' +
             %subst(rcdl0200.r2FmtID: 1: 2) +
             %subst(rcdl0200.r2FmtID: 7: 7);

endsr;

//============================================================*
//    getFldTMrk    Holen des zu markierenden Feldnamens      *
//============================================================*

begsr getFldTMrk;

  wrk#Field = '';

  if (cp <= 0);
    //  Funktion bei leerer Feldtabelle möglich ...
    p_sndPgmMg('USR8145': '': sds.pgmName);
  else;

    for x = 1 to cp;
      y = cursorPosition.column - sflLeftOfs;
      if (y >= col_scnStr(x) and y <= col_scnEnd(x));
        wrk#Field = col_field(x);
        leave;
      endif;
    endfor;

    if (wrk#Field = '');
      p_sndPgmMg('USR8117': '': sds.pgmName);
    endif;

  endif;

endsr;

//============================================================*
//    GetSflRcd     Einlesen Subfilesatz an aktueller         *
//                  Cursorposition                            *
//============================================================*

begsr getSflRcd;

  if (sflCsr > 0);
    exsr pbCsrToRcd;
  else;
    sflCsr = 0;
    p_sndPgmMg('USR8102': '': sds.pgmName);
  endif;

endsr;

//============================================================*
//    getNbrKeyF    Ermitteln Anzahl Schlüsselfelder          *
//============================================================*

begsr getNbrKeyF;

  peek04(yQFile: ##format: yMsgID: yMsgDta);
  if (yMsgID = 'USR0006');
    isKeyAvail = bFalse;
  else;
    isKeyAvail = bTrue;
  endif;

endsr;

//============================================================*
//    getNbrMbr     Ermitteln Anzahl Teildateien              *
//============================================================*

begsr getNbrMbr;

  peek41(yQFile: ##format
        : '*CREATE': yNbrOfEnt: yData);
  if (yNbrOfEnt > *zeros);
    fild0100 = yData;
  else;
    clear fild0100;
  endif;

  $$noMb = fild0100.atnomb;

endsr;

//============================================================*
//    getFmtList    Abrufrufen der Satzformatliste            *
//============================================================*

begsr getFmtList;

  yFile = ##file;
  yLibrary = ##library;
  peek10(yQFile: yMsgID: yMsgDta);

endsr;

//============================================================*
//    getFldList    Abrufrufen der Feldliste                  *
//============================================================*

begsr getFldList;

  yFile = ##file;
  yLibrary = ##library;
  peek01(yQFile: ##format: $$rcdFmtID
        : yMsgID: yMsgDta);

  open peekFld;
  open peekFldL1;

endsr;

//============================================================*
//    getKeyList    Abrufrufen der Schlüsselfelder            *
//============================================================*

begsr getKeyList;

  peek03(yQFile: ##format: accessMode: sqlOrder
        : yMsgID: yMsgDta);

endsr;

//============================================================*
//    getRcdFrmt    Auswählen des Satzformates                *
//============================================================*

begsr getRcdFrmt;

  peek12(set0001.set_dsp80: COPYRIGHT: ##format
        : MODE_BATCH
        : rcdl0200: yFmtNbr: yMsgID: yMsgDta);

  if (yMsgID <> 'USR8100'); // Verarbeitung abgebrochen
    ##fmtNbr = yFmtNbr;
    ##format = rcdl0200.r2FmtName;
    $$length = rcdl0200.r2RcdLen;
  else;
  //         Abbruch über F3/F12
  endif;

endsr;

//============================================================*
//    getObjAttr    Abrufrufen und anzeigen der               *
//                  Objektattribute                           *
//============================================================*

begsr getObjAttr;

  monitor;
    yFile = ##file;
    yLibrary = ##library;
    peek09(yQFile: objd0400: yMsgID: yMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = *on);
    isError = bTrue;
  else;
    isError = bFalse;
    if (yMsgID <> '');
      isError = bTrue;
      //  Objekt nicht gefunden ...
      select;
      when (yMsgID = 'CPF9812');
        usr0008.var1 = ##file;
        usr0008.var2 = ##library;
        p_sndPgmMg('USR0008': usr0008: sds.pgmName);
      when (yMsgID = 'CPF9810');
        usr0010.var1 = ##library;
        p_sndPgmMg('USR0010': usr0010: sds.pgmName);
      other;
        usr0009.var1 = ##file;
        usr0009.var2 = ##library;
        p_sndPgmMg('USR0009': usr0009: sds.pgmName);
      endsl;
    else;

      isError = bFalse;
      //  Übertragen der Objektbezeichnung
      ##file = objd0400.o4ObjName;
      ##library = objd0400.o4RetLib;

      //  Übertragen der Objektbeschreibung
      $$text40 = objd0400.o4Text;
      $$text50 = objd0400.o4Text;

      //  Wenn die Objektgröße kleiner als 999 ist,
      if (objd0400.o4ObjSize <= 999);
        //  ... dann in der Einheit "Byte" anzeigen ...
        r#Size = 0;
        $$unit = 'Byt';
      else;
        //  ... ansonsten solange durch 1024 teilen,
        //      bis das die nächste passende Einheit
        //      gefunden werden konnte.
        r#Size = 0;

        dow (objd0400.o4ObjSize > 999);
          objd0400.o4ObjSize =
           %dech(objd0400.o4ObjSize / 1024: 10: 0);
          r#Size = r#Size + 1;
        enddo;

        //  Multiplikator aus der Objektbeschreibung
        //  berücksichtigen und ...
        if (objd0400.o4ObjSizeM = 1024);
          r#Size = r#Size + 1;
        else;
        //       keine Korrektur erforderlich
        endif;

        //  ... und passende Einheit wählen ...
        select;
        when (r#Size = 1);
          $$unit = 'K';
        when (r#Size = 2);
          $$unit = 'MByt';
        when (r#Size = 3);
          $$unit = 'GByt';
        other;
          $$unit = 'TByt';
        endsl;
      endif;

      //  ... sowie Restgröße zur Anzeige bringen
      $$size = objd0400.o4ObjSize;
    endif;
  endif;

endsr;

//============================================================*
//    getMbrAttr    Abrufen der Attribute der Teildatei       *
//============================================================*

begsr getMbrAttr;

  //  Beschreibung der Teildatei
  if (isOpen = bFalse);
    $$records = 0;
    leavesr;
  endif;

  if (##member = '*NONE');
    clear mbrd0200;
    $$records = 0;
    $$lmtCnt = '';
    $$records = 0;
    leavesr;
  endif;

  yFile = ##file;
  yLibrary = ##library;
  peek13(yQFile: ##member: mbrd0200);

  if (mbrd0200.m2bytAvl > 0);
    if (mbrd0200.m2NbrRcdOn <= 2147483647);
      $$records = mbrd0200.m2NbrRcdOn;
      *in79 = *on;
      $$lmtCnt = '';
    else;
      $$records = 0;
      *in79 = *off;
      $$lmtCnt = '*OVERFLOW';
    endif;
  else;
    $$records = 0;
    *in79 = *off;
    $$lmtCnt = '*ERROR';
  endif;

  //  ... nur, wenn die Anzahl Sätze der Teildatei bekannt ist (*IN79)
  if (accessMode = SQL_SEQ and *in79 = *on);
    if ($$records > set0016.set_maxRcds);
      $$records = 0;
      *in79 = *off;
      $$lmtCnt = '*SQLLMTCNT';
    else;
      clear usr0014;
      p_sndStsMg('USR0014': usr0014);
      $$records = SQL_count();
      *in79 = *on;
      $$lmtCnt = *blanks;
    endif;
  endif;

endsr;

//============================================================*
//    checkMbrName  Prüfen Name der Teildatei                 *
//============================================================*

begsr checkMbrName;

  if (##member = '*NONE');
    clear mbrd0200;
    isError = bFalse;
    leavesr;
  endif;

  yFile = ##file;
  yLibrary = ##library;
  peek13(yQFile: ##member: mbrd0200);
  if (mbrd0200.m2bytAvl <> 0);
    ##member = mbrd0200.m2Member;
    isError = bFalse;
  else;
    isError = bTrue;
  endif;

endsr;

//============================================================*
//    getMaxSeq     Ermitteln der Anzahl Felder               *
//============================================================*

begsr getMaxSeq;

  if (isOpen = bFalse);
    l#MaxSeq = 0;
    l#MinSeq = 0;
  else;

    //  Ermitteln Anzahl Felder ...
    clear f1key_l1;
    f1key_l1.f_seq = *hival;
    setgt %kds(f1key_l1) fpeekfldl1;

    dow ('1');
      readp fpeekfldl1;
      if (%eof());
        l#MaxSeq = 0;
        leave;
      endif;

      //  ... Prüfen, ob Feld angezeigt wird
      wrk#Field = f_field;
      exsr chkVisible;
      if (isVisible = bFalse);
        iter;
      endif;

      l#MaxSeq = f_seq;
      leave;
    enddo;

    //  Ermitteln Erstes Feld ...
    clear f1key_l1;
    f1key_l1.f_seq = 0;
    setll %kds(f1key_l1) fpeekfldl1;

    dow ('1');
      read fpeekfldl1;
      if (%eof());
        l#MinSeq = 0;
        leave;
      endif;

      //  ... Prüfen, ob Feld angezeigt wird
      wrk#Field = f_field;
      exsr chkVisible;
      if (isVisible = bFalse);
        iter;
      endif;

      l#MinSeq = f_seq;
      leave;
    enddo;

  endif;

endsr;

//============================================================*
//    getMaxSeq     Ermitteln vorhergehendes sichtabres Feld  *
//============================================================*

begsr getPrvSeq;

  if (isOpen = bFalse);
    wrk#SeqNbr = -1;
    leavesr;
  endif;

  clear f1key_l1;
  f1key_l1.f_seq = wrk#SeqNbr;
  chain %kds(f1key_l1) fpeekfldl1;
  if (not %found());
    wrk#SeqNbr = l#MinSeq;
    leavesr;
  endif;

  for do_x10 = 1 to *hival;
    readp fpeekfldl1;
    if (%eof());
      wrk#SeqNbr = l#MinSeq;
      leave;
    endif;

    //  ... Prüfen, ob Feld angezeigt wird
    wrk#Field = f_field;
    exsr chkVisible;
    if (isVisible = bFalse);
      iter;
    endif;

    wrk#SeqNbr = f_seq;
    leave;
  endfor;

endsr;

//============================================================*
//    prvWndNbr     Vorheriges sichtbares Feld als Startfeld  *
//                  (gepinnte und ausgeblendete Felder        *
//                  überspringen)                             *
//============================================================*

begsr prvWndNbr;

  wrk#SeqNbr = ##wndNbr;
  exsr getPrvSeq;
  if (wrk#SeqNbr > 0 and wrk#SeqNbr < ##wndNbr);
    ##wndNbr = wrk#SeqNbr;
  else;
    //  ... kein vorheriges Feld: chkSeqRnge meldet den Anfang
    ##wndNbr = ##wndNbr - 1;
  endif;

endsr;

//============================================================*
//    cntPinShown   Anzahl der angezeigten gepinnten Spalten  *
//                  (sie stehen vorn in col_field)            *
//============================================================*

begsr cntPinShown;

  nbrPinShown = 0;
  for x = 1 to cp;
    pin#Field = col_field(x);
    exsr chkPinCol;
    if (isPinned = bFalse);
      leave;
    endif;
    nbrPinShown = nbrPinShown + 1;
  endfor;

endsr;

//============================================================*
//    closeFile     Datei schließen                           *
//============================================================*

begsr closeFile;

  //  Satzkennungen der nächsten Datei neu ermitteln (setRcdId)
  clear rcdIdCache;

  if (isOpen = bTrue);

    yCursorPosition.row = 0;
    yCursorPosition.column = 0;

    //  Datei 04 für Einzelsatzzugriff
    if (CIO_isOpen(hFile04) = bTrue);
      CIO_close(hFile04);
    endif;

    select;
    when (accessMode = KEY_SEQ);
      //  Sortierung 2 für Schlüsselfolge
      if (CIO_close(hFile02) = bTrue);
        *in99 = '0';
      else;
        *in99 = '1';
      endif;
      exsr f2toFx;
    when (accessMode = RRN_SEQ);
      //  Sortierung 1 für Satzfolge
      if (CIO_close(hFile01) = bTrue);
        *in99 = '0';
      else;
        *in99 = '1';
      endif;
      exsr f1toFx;
    when (accessMode = SQL_SEQ);
      if (SQL_close(hFile03:yMsgID :yMsgDta)
          = bTrue);
        *in99 = *off;
        yMsgID = '';
        yMsgDta = '';
      else;
        *in99 = *on;
        if (yMsgID <> '');
          p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
          yMsgID = '';
          yMsgDta = '';
        endif;
      endif;
      exsr f3toFx;
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
    exsr f0toFx;
  endif;

  if (*in99 = *off);
    isOpen = bFalse;
    //  Löschen Satzaufbau
    if (%open(peekFld));
      clear f_key;
      f_key.f_field = *blanks;
      setll %kds(f_key) fpeekfld;
      dow ('1');
        read fpeekfld;
        if (%eof());
          leave;
        endif;
        delete fpeekfld;
      enddo;
      close peekFldL1;
      close peekFld;
    endif;
    //      ... Satzformat
    $$text40 = *blanks;
    $$text50 = *blanks;
    $$length = 0;
    $$records = 0;
    $$size = 0;
    $$rcdFmtID = *blanks;
    $$unit = *blanks;
    $$noMb = 0;
    ##key = *blanks;
    ##rcdNbr = 0;
    //      ... Fensterposition
    ##wndNbr = 0;
    ##strPage = 0;

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
           : yMsgID: yMsgDta);
  yMsgID = '';
  yMsgDta = '';

  //  Subfile initialisieren
  exsr pbInit;

endsr;

//============================================================*
//    getOpnFile    Ermitteln der geöffneten Datei            *
//============================================================*

begsr getOpnFile;

  if (isOpen = bTrue);
    ##file = file#X.file;
    ##library = file#X.library;
    ##member = file#X.member;
  else;
    //**                MOVEL (P) *BLANKS       ##file
    //**                MOVEL (P) *BLANKS       ##library
    //**                MOVEL (P) *BLANKS       ##member
    $$text40 = *blanks;
    $$text50 = *blanks;
    $$size = 0;
    $$rcdFmtID = *blanks;
    $$unit = *blanks;
  endif;

  l#File = ##file;
  l#Library = ##library;
  l#Member = ##member;
  l#Format = ##format;

endsr;

//============================================================*
//    getUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getUsrSetg;

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

  if (set0011.set_dftMde = '*LAST');
  //    ... Modus belassen
  else;
    set0001.set_dspMde = set0011.set_dftMde;
  endif;

  select;
  when (set0001.set_dspMde = '*DSPNRM');
    exsr s_dspNrm;
  when (set0001.set_dspMde = '*DSPHEX');
    exsr s_dspHex;
  other;
    exsr s_dspNrm;
  endsl;

  // - Löschen Programmnachricht "keine Datei geöffnet"
  p_rmvPgmMg(sds.pgmName);

  //  *SECATR ...
  set0013 = f_getUsrSg('*SECATRDFT'   );

  //  ... Verknüpfen *SECATRDFT mit Eingabeparametern ...
  //      ... ##library
  if (i_chgLib = '*');
    if (set0013.set_chgLib = '1');
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

  //      ... ##file
  if (i_chgFile = '*');
    if (set0013.set_chgFil  = '1');
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

  //      ... ##member
  if (i_chgMbr = '*');
    if (set0013.set_chgMbr = '1');
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
    if (set0013.set_updMod = '1');
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
  if (set0013.set_accAut = '1');
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
//    getSeqNbr     Übersetzen Field Name in Sequence Nbr     *
//============================================================*

begsr getSeqNbr;

  clear f_key;
  f_key.f_field = wrk#Field;
  chain(n) %kds(f_key) fpeekfld;
  if (%found());
    isSeqNbrOK = bTrue;
    wrk#SeqNbr = f_seq;
  else;
    isSeqNbrOK = bFalse;
    wrk#SeqNbr = 0;
  endif;

endsr;

//============================================================*
//    getLastOpt    Ermitteln der letzten Subfileauswahl      *
//============================================================*

begsr getLastOpt;

  //  "Keine Sätze vorhanden"
  if (*in80 = *off);
    isError = bTrue;
    wrk#SFPAU = *blanks;
    wrk#Recno = 0;
  else;

    for x = 1 to sflNbrRcd;

      y = sflNbrRcd - x;
      y = y + 1;

      if (*in88 = *off);
        sflRec132 = y;
        chain sflRec132 pbsfl132;
      else;
        sflRec080 = y;
        chain sflRec080 pbsfl080;
      endif;

      if (not %found());
        isError = bTrue;
        wrk#SFPAU = '';
        wrk#Recno = 0;
        leave;
      else;
        if (sfpau <> '');
          wrk#SFPAU = sfpau;
          if (*in88 = bFalse);
            wrk#Recno = sflRec132;
          else;
            wrk#Recno = sflRec080;
          endif;
          isError = bFalse;
          leave;
        else;
        //  Bitte weitersuchen ...
        endif;
      endif;

    endfor;

  endif;

endsr;

//============================================================*
//    getNxtMark    Ermtteln des nächsten markierten Feldes   *
//============================================================*

begsr getNxtMark;

  //  Suchen des nächsten markierten Feldes ...
  clear f1key_l1;
  f1key_l1.f_seq = wrk#SeqNbr;
  setgt %kds(f1key_l1) fpeekfldl1;

  dow ('1');
    read fpeekfldl1;
    if (%eof());
      wrk#SeqNbr = *zeros;
      leave;
    endif;

    wrk#Field = f_field;
    exsr chkVisible;
    if (isVisible = bFalse);
    // ... Feld ist nicht sichtbar
    else;
      // ... Feld ist sichtbar
      if (f_markCol = bTrue);
        // ... und markiert
        wrk#SeqNbr = f_seq;
        leave;
      else;
      // ... leider nicht markiert
      endif;
    endif;

  enddo;

endsr;

//============================================================*
//    getPrvMark    Ermtteln des vorherigen markierten Feldes *
//============================================================*

begsr getPrvMark;

  //  Suchen des nächsten markierten Feldes ...
  clear f1key_l1;
  f1key_l1.f_seq = wrk#SeqNbr;
  setll %kds(f1key_l1) fpeekfldl1;

  dow ('1');
    readp fpeekfldl1;
    if (%eof());
      wrk#SeqNbr = 0;
      leave;
    endif;

    wrk#Field = f_field;
    exsr chkVisible;
    if (isVisible = bFalse);
    // ... Feld ist nicht sichtbar
    else;
      // ... Feld ist sichtbar
      if (f_markCol = bTrue);
        // ... und markiert
        wrk#SeqNbr = f_seq;
        leave;
      else;
      // ... leider nicht markiert
      endif;
    endif;

  enddo;

endsr;

//============================================================*
//    keyHasChg     Aufsetzkey hat gewechselt                 *
//============================================================*

begsr keyHasChg;

  wrk#KeyVal = ##key;
  wrk#RcdNbr = ##rcdNbr;
  exsr pbGenIntKy;
  if (yMsgID <> *blanks);
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    p_sndPgmMg('USR8139': '': sds.pgmName);
  else;
    exsr pbSetLL;
    exsr pbInit;
    exsr pbPinRcd;
    exsr pbReadUp;
    //  Aufsetzkey überschreitet Dateiende
    if (*in80 = *off);
      exsr c_bot;
    endif;
  endif;

endsr;

//============================================================*
//    floatKeys     Keyfelder an den Anfang sortieren         *
//============================================================*

begsr floatKeys;

  if ((set0009.set_float  = bTrue) and
      ((accessMode = KEY_SEQ) or
       (accessMode = SQL_SEQ)));

    monitor;
      peek34(set0001.set_dsp80: COPYRIGHT: '*FLOATKEYS'
            : yMsgID: yMsgDta);
      *in99 = bFalse;
    on-error;
      *in99 = bTrue;
    endmon;

  else;
  //    Es werden keine Schlüsselfeldinformationen benötigt
  endif;

endsr;

//============================================================*
//    keepCsrPos    Beibehalten der Cursorposition            *
//============================================================*

begsr keepCsrPos;

  //  Beibehalten der Cursorosition
  csrRow = cursorPosition.row;
  csrCol = cursorPosition.column;

endsr;

//============================================================*
//    dltCsrPos     Löschen der Cursorposition                *
//============================================================*

begsr dltCsrPos;

  //  Löschen der Cursorosition
  csrRow = *zeros;
  csrCol = *zeros;

endsr;

//============================================================*
//    setUsrSetg    Speichern der Benutzervoreinstellungen    *
//============================================================*

begsr setUsrSetg;

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
    if (f_hidden = bTrue);
      isVisible = bFalse;
      leave;
    endif;

    //  ... gepinnte Spalten überlesen
    pin#Field = wrk#Field;
    exsr chkPinCol;
    if (isPinned = bTrue);
      isVisible = bFalse;
      leave;
    endif;

  endfor;

endsr;

//============================================================*
//    chkSeqRnge    Prüfen der Fensternummer                  *
//============================================================*

begsr chkSeqRnge;

  if (isOpen = bFalse);
  //            keine Datei geöffnet
  else;

    if (##wndNbr < l#MinSeq);
      ##wndNbr = l#MinSeq;
      p_sndPgmMg('USR8115': '': sds.pgmName);
      ##strPage = 1;
    endif;

    if (##wndNbr > l#MaxSeq);
      ##wndNbr = l#MaxSeq;
      p_sndPgmMg('USR8116': '': sds.pgmName);
      if (set0010.set_scroll = '*BOTH'
          or set0010.set_scroll = '*RIGHT');
        ##strPage = *hival;
      else;
        ##strPage = 1;
      endif;
    endif;

    if (##strPage < 1);
      ##strPage = 1;
    endif;

  endif;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  //    Wenn der Bildschirm keine 132-Zeichen
  //    darstellen kann, ...
  if (workstn.numRows < 27);
    //    ... dann auf 80-Zeichen umschalten.
    set0001.set_dsp80 = '1';
  else;
  //    ... sonst die Auflösung 80/132 beibehalten.
  endif;

  if (set0001.set_dsp80 = '1');
    //    80-Zeichen Anzeige
    *in88 = '1';
    sflPage = 14;
    sflMaxRowLen = 64;
    sflHeadLRw = 6;
    sflFirstRw = 7;
    sflLastRw = 20;
    sflLeftOfs = 15;
  else;
    //   132-Zeichen Anzeige
    *in88 = '0';
    sflPage = 16;
    sflMaxRowLen = 116;
    sflHeadLRw = 6;
    sflFirstRw = 8;
    sflLastRw = 23;
    sflLeftOfs = 15;
  endif;

  //  Bereich für gepinnte Spalten
  sflPinRnge = (sflMaxRowLen / 3) * 2;

  //  Prompt-Felder anzeigen ...
  if (set0008.set_dspPmt = bTrue
     and *in77 = *off);
    *in71 = '1';
  else;
    *in71 = '0';
  endif;

  //  Subfileauswahlfeld öffnen ...
  *in76 = '0';

endsr;

//============================================================*
//    chgScreen     Wechseln 132/80-Zeichen Auflösung         *
//============================================================*

begsr chgScreen;

  if (set0001.set_dsp80 = '1');
    //   132-Zeichen Anzeige
    set0001.set_dsp80 = '0';
  else;
    //    80-Zeichen Anzeige
    set0001.set_dsp80 = '1';
  endif;

  exsr setScreen;

endsr;

//============================================================*
//    showSplash    Anzeigen SPLASH-Screen                    *
//============================================================*

begsr showSplash;

  if (set0005.set_spla = bFalse);
  //            kein Splash-Screen
  else;
    write splash01;
  endif;

endsr;

//============================================================*
//    chkVersion    Prüfen der Versionsnummer                 *
//============================================================*

begsr chkVersion;

  if (set0007.set_vsn <> Version);
    peek33(Version: yMsgID: yMsgDta);
  else;
  //  Kein Abgleich erforderlich ...
  endif;

endsr;

//============================================================*
//    chkPrvFile    Prüfen vorherige Datei                    *
//============================================================*

begsr chkPrvFile;

  //  Datei ...
  if (##file = '*PRV');
    if (set0014.set_prvFil  <> '*NONE');
      ##file = set0014.set_prvFil;
    endif;
    //  Bibliothek ...
    if (set0014.set_prvLib  <> '*NONE');
      ##library = set0014.set_prvLib;
    else;
      ##library = ' ';
    endif;
    //  Teildatei ...
    if (set0014.set_prvMbr  <> '*NONE');
      ##member = set0014.set_prvMbr;
    else;
      ##member = ' ';
    endif;
  endif;

endsr;

//============================================================*
//  Call EXIT01. The exit program must exist.                 *
//============================================================*

begsr s_exit01;

  clear yQFile;
  yFile = ##file;
  yLibrary = ##library;

  callp EXIT01(yQFile: ##member: accessMode
               : auth.isChgLibAlw: auth.isChgFileAlw: auth.isChgMbrAlw
               : auth.isUpdAlw: auth.isUpdKeyAlw
               : auth.isChgSQLWhereAlw: auth.isChgSQLOrderByAlw
               : auth.isAccessAlw
               : yMsgID: yMsgDta);

  if (yMsgID <> '');
    p_rmvPgmMg(sds.pgmName);
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
  endif;

endsr;

//============================================================*
//    clrPinTabR    Löschen pIntAbr                           *
//============================================================*

begsr clrPinTabR;

  clear pinTabRcdE;
  for pinRcd_x = 1 to max_pin_rcd;
    pinTabRcd(pinRcd_x) = pinTabRcdE;
  endfor;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Zeichenumsetzung neu beginnen: Die Job-CCSID kann sich seit dem
  //   letzten Aufruf geändert haben (CHGJOB CCSID).
  Transcoder_reset();

  // - Einlesen der Benutzervoreinstellungen
  exsr getUsrSetg;

  // - Prüfen auf generischen Dateinamen
  if (f_endsWith('*': %trimr(io_qFile.name)));
    if (*in75 = *off); // Feld ist nicht gesperrt
      ##file = io_qFile.name;
      ##library = io_qFile.lib;
      exsr pmt_file;
      if (*in93 = bTrue);
        io_qFile.name = ##file;
        io_qFile.lib = ##library;
      endif;
      ##file = '';
      ##library = '';
    endif;
  endif;

  // - Öffnen Bildschirmdatei
  open peek05fm;

  // - Initialisieren Bildschirm
  ##file = io_qFile.name;
  ##library = io_qFile.lib;
  ##member = i_member;
  exsr getObjAttr;

  exsr chkPrvFile;
  ##rcdNbr = 0;
  ##key = *blanks;
  ##wndNbr = 0;
  ##strPage = 0;
  ##field = *blanks;

  exsr clrFldPosArray;

  $$system = *blanks;
  $$text40 = *blanks;
  $$text50 = *blanks;
  ##format = *blanks;
  $$length = 0;
  $$records = 0;
  $$size = 0;
  $$rcdFmtID = *blanks;
  $$unit = *blanks;

  $$head132 = *blanks;
  $$head080 = *blanks;

  //  Last opened file
  l#File = *blanks;
  l#Library = *blanks;
  l#Member = *blanks;
  l#Format = *blanks;
  l#MaxSeq = 0;
  l#MinSeq = 0;
  l#WndNbr = 0;

  //  SQL-Selektion
  sqlWhere  = ' ';
  sqlOrder  = ' ';

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setScreen;

  // - SPLASH-Screen
  exsr showSplash;

  // -  Darstellung der Auswahlen/Funktionstasten
  sfTop = 1;
  sfBot = 1;

  // -  Netzwerkattribute (ohne Statusmeldung)
  peek07('SYSNAME': bTrue
        : yAttrLen: yAttrTyp: yValue);
  if (yAttrLen > 0);
    $$system = %subst(yValue: 1: yAttrLen);
  else;
    $$system = *blanks;
  endif;

  // - Öffnen der Datei
  if (isOpen = bFalse);
    accessMode = i_access;
    if (accessMode = SQL_SEQ);
      sqlWhere  = i_sqlWhere;
      sqlOrder  = i_sqlOrder;
    endif;
    exsr openFile;
  endif;

  // - laden Arbeitsumgebung / öffnen Datei
  if (i_qEnvFile.name = '*NONE');
    yEnvFile = set0015.set_envFil;
    yEnvLib  = set0015.set_envLib;
    yEnvMbr  = '*FILE';
  else;
    if (i_qEnvFile.name = '*ENVFILE');
      yEnvFile = set0015.set_envFil;
      yEnvLib  = set0015.set_envLib;
      yEnvMbr  = '*FILE';
    else;
      yEnvFile = i_qEnvFile.name;
      yEnvLib  = i_qEnvFile.lib;
      yEnvMbr  = i_envMbr;
    endif;
    if (i_envLayout = bTrue);
      yOption = '*SLCLAYOUT';
    else;
      yOption = '*SLCENV';
    endif;
    exsr loadEnv;
    if (yMsgID = 'CPF9815'); // Teildatei nicht gefunden
      yMsgID = '';
      yMsgDta = '';
    endif;
  endif;

  // - Ermitteln der Attribute der geöffneten Datei
  exsr getOpnFile;
  exsr getMaxSeq;

  //  Wenn eine Datei geöffnet werden konnte, ...
  if (isOpen = bTrue);
    //  ... dann
    //      abspeichern *PRVFILE
    set0014.set_prvFil  = ##file;
    set0014.set_prvLib  = ##library;
    set0014.set_prvMbr  = ##member;
    p_updUsrSg('*PRVFILE' : set0014);
  endif;

  // - Subfile füllen
  exsr pbInit;
  exsr c_top;

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

  pgmQ = '*';

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

  // - pIntAbr clearen
  exsr clrPinTabR;

  // - Versionsabgleich durchführen
  exsr chkVersion;

  peek23(sds.pgmName: '*ALL': 8: yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

  peek27(sds.pgmName: yChoice: yNbrOfCh);

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
//    f_chain00     Satz über hFile00 mit Sperre lesen        *
//                  Rückgabe: '1' = nicht gefunden oder       *
//                  Datei nicht geöffnet, '0' = gefunden      *
//============================================================*

dcl-proc f_chain00;
  dcl-pi *n char(1);
    i_rrn    like(rcdNbr_t) value;
    i_file   like(file_t) value;
    i_lib    like(lib_t) value;
    i_mbr    like(mbr_t) value;
    i_rcdFmt char(10) value;
  end-pi;

  dcl-s isNotFound like(bool_t) inz(bTrue);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if ((CIO_getFile(hFile00)    <> i_file ) or
      (CIO_getLibrary(hFile00) <> i_lib  ) or
      (CIO_getMember(hFile00)  <> i_mbr  ));
    if (CIO_isOpen(hFile00) = bTrue);
      CIO_close(hFile00);
    endif;
  endif;

  f_execute('OVRDBF ' +
             'FILE(' + %trim(##file) + ') ' +
             'TOFILE(' +
               %trim(##library) + '/' +
               %trim(##file) + ') ' +
             'MBR(' + %trim(##member) + ') ' +
             'OVRSCOPE(*ACTGRPDFN) ' +
             'SHARE(*NO) ' +
             'SEQONLY(*NO) SECURE(*YES)'
           : yMsgID: yMsgDta);
  yMsgID = '';
  yMsgDta = '';

  if (CIO_isOpen(hFile00) = bFalse);
    if (commitLvl = '1');
      CIO_open(hFile00
              : i_file
              : i_lib
              : i_mbr
              : i_rcdFmt
              : 'rr+ , arrseq=Y, commit=Y, +
                 nullcap=Y, riofb=Y, +
                 secure=N, ccsid=65535');
    else;
      CIO_open(hFile00
              : i_file
              : i_lib
              : i_mbr
              : i_rcdFmt
              : 'rr+ , arrseq=Y, commit=N, +
                 nullcap=Y, riofb=Y, +
                 secure=N, ccsid=65535');
    endif;
  endif;

  f_execute('DLTOVR ' +
             'FILE(' + %trim(##file) + ') ' +
             'LVL(*ACTGRPDFN) '
           : yMsgID: yMsgDta);
  yMsgID = '';
  yMsgDta = '';

  //  Datei konnte nicht geöffnet werden:
  //  wie "Satz nicht gefunden" behandeln
  if (CIO_isOpen(hFile00) = bFalse);
    return isNotFound;
  endif;

  if (CIO_chainWithRRN(hFile00
                    : i_rrn
                    : bTrue
                    : io_buff
                    : io_nullMap) = bTrue);
    isNotFound = bFalse;
  endif;

  file#X = CIO_getInfDS(hFile00);

  return isNotFound;

end-proc;

//============================================================*
//    f_chain04     Satz über hFile04 ohne Sperre lesen       *
//                  Rückgabe: '1' = nicht gefunden oder       *
//                  Datei nicht geöffnet, '0' = gefunden      *
//============================================================*

dcl-proc f_chain04;
  dcl-pi *n char(1);
    i_rrn    like(rcdNbr_t) value;
    i_file   like(file_t) value;
    i_lib    like(lib_t) value;
    i_mbr    like(mbr_t) value;
    i_rcdFmt char(10) value;
  end-pi;

  dcl-s isNotFound like(bool_t) inz(bTrue);
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

  //  Datei konnte nicht geöffnet werden:
  //  wie "Satz nicht gefunden" behandeln
  if (CIO_isOpen(hFile04) = bFalse);
    return isNotFound;
  endif;

  if (CIO_chainWithRRN(hFile04
                    : i_rrn
                    : bFalse
                    : io_buff
                    : io_nullMap) = bTrue);
    isNotFound = bFalse;
  endif;

  file#X = CIO_getInfDS(hFile04);

  return isNotFound;

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

