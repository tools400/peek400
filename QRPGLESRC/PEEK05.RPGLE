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
dcl-f peek05fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbsfl132: sflrec132)
  sfile(pbsfl080: sflrec080);

dcl-f peekfldl1 keyed rename(fpeekfld: fpeekfldl1) prefix(f_) usropn infds(peek#l1);

dcl-f peekfld usage(*update: *delete) keyed prefix(f_) usropn infds(peek#00);

dcl-ds workstn likeds(workstn_t);
dcl-ds cursorPosition likeds(cursorPosition_t) inz;

dcl-ds peek#l1 likeds(infds_t);
dcl-ds peek#00 likeds(infds_t);
dcl-ds file#x likeds(infds_t);

// Für Einzelsatzzugriff zum Löschen von Datensätzen
dcl-ds hfile00 likeds(hfile_t);

// Für Sortierung nach relativer Satznummer
dcl-ds hfile01 likeds(hfile_t);

// Für Sortierung nach Schlüsselfolge
dcl-ds hfile02 likeds(hfile_t);

// Für SQL Zugriff
dcl-ds hfile03 likeds(hfile_t);

// Für Einzelsatzzugriff zum reinen Lesen von Datensätzen
dcl-ds hfile04 likeds(hfile_t);

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
  inpvalue zoned(25: 5) value;
end-pr;

dcl-pr f_chain00 char(1);
  i_rrn    like(rcdNbr_t) value;
  i_file   like(file_t) value;
  i_lib    like(lib_t) value;
  i_mbr    like(mbr_t) value;
  i_rcdfmt char(10) value;
end-pr;

dcl-pr f_chain04 char(1);
  i_rrn    like(rcdNbr_t) value;
  i_file   like(file_t) value;
  i_lib    like(lib_t) value;
  i_mbr    like(mbr_t) value;
  i_rcdfmt char(10) value;
end-pr;

//----------------------------------------------------*
//  I N F D S - D E F I N I T I O N E N               *
//----------------------------------------------------*

dcl-ds io_buff;
  io_bufffld like(rcdbuf_t);
end-ds;

dcl-s io_nullmap like(nullmap_t) dim(NULL_MAP_SIZE);

dcl-ds rtn qualified inz;
  file       like(##file);
  library    like(##library);
  member     like(##member);
  format     like(##format);
  accessmode like(accessMode);
  sqlwhere   like(sqlWhere);
  sqlorder   like(sqlOrder);
end-ds;

dcl-ds yQFile inz;
  yFile    like(file_t);
  yLibrary like(lib_t);
end-ds;

dcl-s isLicenceError like(bool_t) inz(bTrue);
dcl-s yformat like(rcdfmt_t) inz;
dcl-s yMsgID char(7) inz;
dcl-s yMsgDta char(512) inz;

dcl-s yMember like(mbr_t) inz;

dcl-s yattrlen like(int4_t) inz;
dcl-s yattrtyp char(1) inz;
dcl-s yvalue char(512) inz;

dcl-s ydsp80 like(set0001_t.set_dsp80) inz;
dcl-s yCopyright like(copyrght_t) inz(copyright);

dcl-s yfmtnbr int(5) inz;

dcl-s yHeaderType char(10) inz;
dcl-s yRcdNbr inz(0) like(rcdNbr_t);
dcl-s yFunction char(10) inz;
dcl-s yCommitLvl like(commitLvl) inz('0');
dcl-s yIsUpdKey inz(bFalse) like(isUpdKey);
dcl-s yScreenNbr like(int4_t) inz;
dcl-s yIsLower char(1) inz(bFalse);

dcl-ds yCursorPosition likeds(cursorPosition_t) inz;

dcl-s ycvtccsid char(1) inz(bTrue);
dcl-s ydata char(512) inz;

dcl-ds yRetFile likeds(qObj_t);

dcl-s yrtncode char(1) inz;

dcl-s yfield like(srchfield) inz;
dcl-s yoperation like(srchop) inz;
dcl-s yargument like(srcharg) inz;
dcl-s ysign like(srchsign) inz;
dcl-s ysrchnbrs like(srchnbrs) inz(0);
dcl-s ysrchtype like(srchtype) inz;
dcl-s ysrchcase like(srchcase) inz(bFalse);

dcl-s ybuffer like(rcdbuf_t) inz;
dcl-ds *n;
  yhexstring like(hexbuf_t);
  youtbuffer like(rcdbuf_t) overlay(yhexstring: 1);
end-ds;

dcl-s youtbuffln like(int4_t) inz;
dcl-s ytgtvalue char(10) inz;

dcl-s ykeyval like(keybuf_t) inz;

dcl-s yPgmCmd char(10) inz;
dcl-s ycmddta like(pgmcmddt_t) inz;

dcl-s yFKeys char(18) dim(32) inz;
dcl-s yNbrOFKeys like(int4_t) inz;

dcl-s ychoice like(choice_t) dim(32) inz;
dcl-s ynbrofch like(int4_t) inz;

dcl-s yflag inz(*zeros) like(int4_t);

dcl-s buffidx like(int4_t) inz;

dcl-ds shortcmd likeds(shortcmd_t) inz;
dcl-s yexeccmd like(cmdbuffer_t) inz;
dcl-s ynbrofent like(int4_t) inz;
dcl-s ysqlwhere like(sqlwhere_t) inz;
dcl-s ysqlorder like(sqlorder_t) inz;
dcl-s yalwlc char(1) inz;
dcl-s ycase char(1) inz;
dcl-s yrcdlock char(1) inz;
dcl-s ynulldft char(1) inz;
dcl-s ykeepcrs char(1) inz;
dcl-s yenvfile like(file_t) inz;
dcl-s yenvlib like(lib_t) inz;
dcl-s yenvmbr like(mbr_t) inz;
dcl-s yisautosave like(bool_t) inz(bFalse);
dcl-s yIsKeyLower like(bool_t) inz;
dcl-s yoption like(option_t) inz;
dcl-s ytext like(text_t);
dcl-s ysflopt char(2);
dcl-s ystring like(rcdbuf_t) inz;
dcl-s ystringlen like(int4_t) inz;

dcl-c HEX_CHAR '-';

dcl-s isReadSfl like(bool_t) inz(bFalse);
dcl-s ispbinit char(1) inz(bFalse);
dcl-s isfirstsfl char(1) inz(bFalse);
dcl-s isfilechg char(1) inz(bFalse);
dcl-s istblcol char(1) inz(bFalse);
dcl-s isTargetOK like(bool_t) inz(bFalse);
dcl-s isSeqNbrOK like(bool_t) inz(bFalse);
dcl-s isOpen like(bool_t) inz(bFalse);
dcl-s isUpdMod like(bool_t) inz(bFalse);
dcl-s isUpdKey like(bool_t) inz(bFalse);
dcl-s isVisible like(bool_t) inz(bFalse);
dcl-s isError like(bool_t) inz(bFalse);
dcl-s isfileerror char(1) inz(bFalse);
dcl-s iskeyavail char(1) inz(bFalse);
dcl-s iskeychg char(1) inz(bFalse);
dcl-s isSflDirty char(1) inz(bFalse);
dcl-s isTryed char(1) inz(bFalse);
dcl-s ispinned char(1) inz(bFalse);
dcl-s ispinmoder char(1) inz(bFalse);
dcl-s isPinModeC char(1) inz(bFalse);
dcl-s ispinok char(1) inz(bFalse);
dcl-s ispinrmv char(1) inz(bFalse);
dcl-s iseof char(1) inz(bFalse);
dcl-s queryUser like(sfl_cmd) inz(*allx'00');
dcl-s isfound char(1) inz(bFalse);
dcl-s isCmdErr char(1) inz(bFalse);
dcl-s isCancel char(1) inz(bFalse);
dcl-s r#iscmderr char(1) inz(bFalse);
dcl-s iscvtchar char(1) inz(bFalse);
dcl-s isPinToClr char(1) inz(bTrue);
dcl-s isreadc char(1) inz(bFalse);
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

dcl-s sflpage like(int4_t) inz;
dcl-s sflrec080 inz(0) like(sflpage);
dcl-s sflrec132 inz(0) like(sflpage);
dcl-s sflnbrrcd inz(0) like(sflpage);
dcl-s sflMaxRowLen like(int4_t) inz;
dcl-s sfldatalenfree like(int4_t) inz;
dcl-s sftop like(int4_t) inz;
dcl-s sfbot like(int4_t) inz;
dcl-s sfl_cmd char(10) inz;
dcl-s sflheadlrw inz(0) like(sflpage);
dcl-s sflfirstrw inz(0) like(sflpage);
dcl-s sfllastrw inz(0) like(sflpage);
dcl-s sflleftofs like(int4_t) inz;
dcl-s sflmode char(10) inz;
dcl-s sflpinrnge like(int4_t) inz;

dcl-c COPYRIGHT '1997-2026, Thomas Raddatz - PEEK v4.0.8';
dcl-c RELEASE 'Stand: 02.11.2026';
dcl-c VERSION 'V04R00M08';

dcl-s l#file like(##file) inz;
dcl-s l#library like(##library) inz;
dcl-s l#member like(##member) inz;
dcl-s l#format like(##format) inz;
dcl-s l#maxseq like(f_seq) inz(0);
dcl-s l#minseq like(f_seq) inz(0);
dcl-s l#wndnbr like(##wndnbr) inz(0);

dcl-s r#size like(int4_t) inz;

dcl-s UPDPGM_NAME like(pgmcalln_t) inz;

dcl-s peek01_name like(pgmcalln_t) inz;
dcl-s peek03_name like(pgmcalln_t) inz;
dcl-s peek04_name like(pgmcalln_t) inz;
dcl-s peek06_name like(pgmcalln_t) inz;
dcl-s peek07_name like(pgmcalln_t) inz;
dcl-s peek08_name like(pgmcalln_t) inz;
dcl-s peek09_name like(pgmcalln_t) inz;
dcl-s peek10_name like(pgmcalln_t) inz;
dcl-s peek12_name like(pgmcalln_t) inz;
dcl-s peek13_name like(pgmcalln_t) inz;
dcl-s peek14_name like(pgmcalln_t) inz;
dcl-s peek17_name like(pgmcalln_t) inz;
dcl-s peek18_name like(pgmcalln_t) inz;
dcl-s peek19_name like(pgmcalln_t) inz;
dcl-s peek20_name like(pgmcalln_t) inz;
dcl-s peek21_name like(pgmcalln_t) inz;
dcl-s peek23_name like(pgmcalln_t) inz;
dcl-s peek24_name like(pgmcalln_t) inz;
dcl-s peek26_name like(pgmcalln_t) inz;
dcl-s peek27_name like(pgmcalln_t) inz;
dcl-s peek30_name like(pgmcalln_t) inz;
dcl-s peek32_name like(pgmcalln_t) inz;
dcl-s peek33_name like(pgmcalln_t) inz;
dcl-s peek34_name like(pgmcalln_t) inz;
dcl-s peek37_name like(pgmcalln_t) inz;
dcl-s peek38_name like(pgmcalln_t) inz;
dcl-s peek40_name like(pgmcalln_t) inz;
dcl-s peek41_name like(pgmcalln_t) inz;
dcl-s peek42_name like(pgmcalln_t) inz;
dcl-s peek47_name like(pgmcalln_t) inz;
dcl-s peek48_name like(pgmcalln_t) inz;
dcl-s peek49_name like(pgmcalln_t) inz;
dcl-s peek50_name like(pgmcalln_t) inz;
dcl-s peek52_name like(pgmcalln_t) inz;
dcl-s peek54_name like(pgmcalln_t) inz;
dcl-s peek55_name like(pgmcalln_t) inz;
dcl-s peek56_name like(pgmcalln_t) inz;
dcl-s peek57_name like(pgmcalln_t) inz;
dcl-s peek59_name like(pgmcalln_t) inz;
dcl-s peek65_name like(pgmcalln_t) inz;
dcl-s peek68_name like(pgmcalln_t) inz;
dcl-s peek69_name like(pgmcalln_t) inz;
dcl-s exit01_name like(pgmcalln_t) inz;
dcl-s exit04_name like(pgmcalln_t) inz;

dcl-s peekPgm like(pgm_t) inz;
dcl-s peekDspF like(file_t) inz;

dcl-ds sflDataRow qualified;
  chars char(1) dim(256) inz;
end-ds;

dcl-c sfl_row_size %elem(sflDataRow.chars);

dcl-s sflRowDataStr like(int4_t);
dcl-s sflrowdataend like(int4_t);
dcl-s sflrowdatalen like(int4_t);

dcl-s colrofs like(int4_t);
dcl-s col_field char(10) dim(60);
dcl-s col_scnstr like(int4_t) dim(60);
dcl-s col_scnend like(int4_t) dim(60);
dcl-s col_error like(bool_t) dim(60) inz(bFalse);
dcl-s cp like(int4_t);
dcl-s fldstrpos like(int4_t);

dcl-s headlen like(int4_t);
dcl-s fieldlen like(int4_t);
dcl-s maxcollen like(int4_t);
dcl-s columnlen like(int4_t);

dcl-s pincol_x like(int4_t);
dcl-c max_pin_col %elem(pinTabCol);
dcl-s pinTabCol like(fieldnme_t) dim(12);
//  Rückgabe des Pin-Dialogs (PEEK50): clrpincol löscht pinTabCol
dcl-s yPinTabCol like(fieldnme_t) dim(12);
dcl-s nbrPinCol like(int4_t);

dcl-s pinrcd_x like(int4_t);
dcl-c max_pin_rcd %elem(pintabrcd);
dcl-s pinTabRcd like(pintabr_t) dim(12);
dcl-s nbrPinRcd like(int4_t);

dcl-ds pinTabRcdE likeds(pintabr_t);

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
dcl-s oldaccmode char(1) inz(RRN_SEQ);
//  Arbeitsfeld für Befehlsverarbeitung, Verhinderung von Rekursionen
dcl-s r#pgmcmd like(yPgmCmd) inz;
//  Arbeitsfeld für Eingabe Aufsetzkey
dcl-s r#rcdnbr like(##rcdnbr) inz(0);
dcl-s r#keyval like(##key) inz;
//  Arbeitsfeld für PIN-Funktion
dcl-s pin#field char(10) inz;
//  Datensatz-Nr für SETLL und SETGG zum füllen der Subfile
dcl-s wrk#readdn like(sflpage) inz(0);
dcl-s wrk#rcdnbr like(rcdNbr_t) inz(0);
dcl-ds *n;
  wrk#keyval like(keybuf_t) inz;
end-ds;
//  ...
dcl-s wrk#field inz like(f_field);
dcl-s wrk#seqnbr inz(0) like(f_seq);
dcl-s wrk#recno inz(0) like(sflrec132);
dcl-s wrk#sfpau inz like(sfpau);
//  Umschalten der Sortierung
dcl-s last#rcdnr like(rcdNbr_t) inz(0);
//  Farbattribute einsetzen
dcl-s wrk#ofs like(int4_t) inz;
//  Felder für Suchfunktion
dcl-s srchmode char(10) inz('*NEW');
dcl-s srchfndrcd like(rcdNbr_t) inz(0);
dcl-s srchfield char(10) inz;
dcl-s srchop char(10) inz;
dcl-s srcharg char(63) inz;
dcl-s srchsign char(1) inz;
dcl-s srchargfloat float(8) inz;
dcl-s srchargval zoned(63) inz;
dcl-c csrcharg_digits %len(srchargval);

dcl-c csrcharg_decpos %decpos(srchargval);

dcl-s srchliketp like(int4_t) inz;
dcl-s srchlikeln like(int4_t) inz;
dcl-s srchnbrs packed(10) inz(0);
dcl-s srchtype char(10) inz;
dcl-s srchcase char(1) inz(bFalse);
dcl-s srchcmpstr like(srcharg) inz;
dcl-s srchcmpval like(srchargval) inz(0);
dcl-c srch_cmp_val_length %len(srchcmpval);

dcl-c srch_cmp_val_decpos %decpos(srchcmpval);

dcl-s srchcmpfloat float(8) inz(0);
dcl-s srchcmprcd like(rcdbuf_t) inz;
dcl-s srchcount like(srchnbrs) inz(0);
dcl-s srchcount2 like(srchnbrs) inz(0);
dcl-s srchdspmsg like(srchnbrs) inz(0);
dcl-s srchisnum char(1) inz(bFalse);
dcl-s srchargisfloat char(1) inz(bFalse);

//  Felder für Kopierfunktion
dcl-ds copyExternal qualified;
  file    char(10) inz;
  lib     char(10) inz;
  toMbr   char(10) inz;
  mbrOpt  char(10) inz;
  crtFile char(10) inz;
end-ds;

//  Überlagern von ##Key132uc mit ##Key80uc
dcl-s ##key like(##key132uc) inz;
dcl-ds *n;
  ##key132uc char(116);
  ##key80uc  char(67) overlay(##key132uc: 1);
end-ds;
dcl-ds *n;
  ##key132lc char(116);
  ##key80lc  char(67) overlay(##key132lc: 1);
  sqlWhere   like(sqlWhere_t) inz;
  sqlOrder   like(sqlOrder_t) inz;
end-ds;
dcl-ds *n;
  rcdnbr# zoned(10);
  rcdnbr$ char(10) overlay(rcdnbr#: 1);
end-ds;

dcl-s exitmsg varchar(512) inz;
dcl-s colheading like(colheading_t);

//  Feldinhalte vor der Bildschirmausgabe
dcl-ds b4 qualified;
  wndnbr  like(##wndnbr);
  strpage like(##strpage);
end-ds;

/copy QCOPYLE,CEECNDHDLR

dcl-s isinzsr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek05;
  io_qfile    likeds(qobj_t);
  i_member    like(mbr_t) const;
  i_access    like(accessmode_t) const;
  i_prodlib   like(lib_t) const;
  i_chglib    like(bool_t) const;
  i_chgfile   like(bool_t) const;
  i_chgmbr    like(bool_t) const;
  i_updmodkey like(bool_t) const;
  i_chgsqlw   like(bool_t) const;
  i_chgsqlo   like(bool_t) const;
  i_qenvfile  likeds(qobj_t) const;
  i_envmbr    like(mbr_t) const;
  i_envsave   like(bool_t) const;
  i_envlayout like(bool_t) const;
  i_sqlwhere  like(sqlwhere_t) const;
  i_sqlorder  like(sqlorder_t) const;
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
  exsr getfrstfld;

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
    ##key132uc = ##key;
  else;
    *in78 = *on;
    ##key132lc = ##key;
  endif;

  //  Prüfen Positionierung der Subfile
  if (sfsanr <= 0);
    sfsanr = nbrPinRcd + 1;
  endif;
  if (sfsanr > sflnbrrcd);
    sfsanr = sflnbrrcd;
  endif;

  //  Für Prüfung: Eingabe neuer Aufsetzkey
  r#rcdnbr = ##rcdnbr;
  r#keyval = ##key;

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgctl;

  //  "Keine Sätze ..."
  if (*in80 = *off);
    write pbleer;
  endif;

  //  Anzeigen der Einzelauswahlen
  if sftop > 32
     or sftop > ynbrofch;
    sftop = 1;
  endif;
  $$choice = ychoice(sftop);

  //  Anzeigen der Befehlstasten
  select;
  when (sfbot = 2 and yNbrOFKeys > 8);
    if (*in88 = bFalse);
      write pbbot132#2;
    else;
      write pbbot080#2;
    endif;
  when (sfbot = 3 and yNbrOFKeys > 16);
    if (*in88 = bFalse);
      write pbbot132#3;
    else;
      write pbbot080#3;
    endif;
  when (sfbot = 4 and yNbrOFKeys > 24);
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
  b4.wndnbr = ##wndnbr;
  b4.strpage = ##strpage;

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
    ##key = ##key132lc;
  endif;

  //  Berechnen Zeile/Spalte
  cursorposition.row = workstn.csrpos / 256;
  cursorposition.column = %rem(workstn.csrpos: 256);

  //  Löschen der Cursorposition
  csrrow = 0;
  csrcol = 0;

  //  Merker für aktualisieren der Subfile
  isSflDirty = bFalse;

  //  Merker für abfragen der Zieldatei
  isTargetOK = bFalse;

  //  Nachrichten löschen
  p_rmvpgmmg(sds.pgmname);

  //  Cursor-Pos. löschen
  *in87 = '0';

  //  Aktuelle Satz-Nr.
  sfsanr = sflCsr;

  //  Suchmodus
  if (yPgmCmd <> '*SEARCH');
    srchmode = '*NEW';
    srchfndrcd = 0;
  endif;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmname
        : yPgmCmd: ycmddta: yMsgID: yMsgDta);
  if (yMsgID <> *blanks);
    p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
    yMsgID = '';
    yMsgDta = '';
  else;
    //  Abfragen der Programmbefehle
    exsr doScreenCmd;
    if (yPgmCmd = '*EXIT' or yPgmCmd = '*CANCEL');
      leave;
    endif;
    if (isCmdErr = bTrue);
      p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
      yMsgID = '';
      yMsgDta = '';
    endif;
  endif;

  //  ... Subfile aktualisieren
  if (isSflDirty = bTrue);
    exsr pbrefresh;
  endif;

  //  ... Offene Datei aktualisieren
  exsr getopnfile;

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
    ##wndnbr = b4.wndnbr;
    ##strpage = b4.strpage;
  else;

    //  Positionieren auf Feldanfang bei Wechsel des Startfeldes
    if ##wndnbr <> b4.wndnbr
       and ##strpage = b4.strpage;
      ##strpage = 1;
    endif;

  endif;

  //  Verwenden der alten Startposition von vor der Bildschirmausgabe
  if (##strpage = *zeros);
    ##strpage = b4.strpage;
  endif;

  //  Sicherstellen, dass das Feld gefüllt ist
  if (##strpage = *zeros);
    ##strpage = 1;
  endif;

  //  Verarbeiten Bildschirmereignis
  r#pgmcmd = yPgmCmd;
  //   exsr doPgmCmd;
/copy QCOPYLE,DOPGMCMD
  r#pgmcmd = '';

endsr;

//============================================================*
//    DoSflCmd      Ausführen Subfilebefehl                   *
//============================================================*

begsr doSflCmd;

  if (yPgmCmd = r#pgmcmd);
    isCmdErr = bTrue;
    clear usr8144;
    usr8144.var1 = yPgmCmd;
    p_sndpgmmg('USR8144': usr8144: sds.pgmname);
  else;
  //      exsr doPgmCmd;
/copy QCOPYLE,DOPGMCMD
  endif;

endsr;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  //  Löschen der Cursor-Position ...
  exsr dltcsrpos;

  //  Datei hat gewechselt ...
  if ((##file    <> l#file) and
     (not f_endswith('*': %trim(##file))) and
     (%trim(##file  ) <> set0008.set_prmt)) or
     (##library  <> l#library      ) or
     ((##member  <> l#member) and
     (%trim(##member) <> set0008.set_prmt)) or
     ((##format  <> l#format) and
     (%trim(##format) <> set0008.set_prmt));
    *in93 = '1';
  else;

    //  Abfragen Prompt?
    //  ... ##File
    if %trim(##file) = set0008.set_prmt or
       f_endswith('*': %trim(##file));
      exsr c_prompt;
      if (*in93 = '0');
        leavesr;
      endif;
    endif;
    //  ... ##Member
    if (%trim(##member) = set0008.set_prmt);
      exsr c_prompt;
      if (*in93 = '0');
        leavesr;
      endif;
    endif;
    //  ... ##Format
    if (%trim(##format) = set0008.set_prmt);
      exsr c_prompt;
      if (*in93 = '0');
        leavesr;
      endif;
    endif;
    //  ... ##Field
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

    //  Prüfen Seq-Bereich (##WndNbr) ...
    exsr chkseqrnge;

    //  Wechsel des Fenster (##Field) ...
    exsr changewnd;

    //  Wechsel des Aufsetzkeys ...
    exsr changekey;

    //  Füllen der Subfile ...
    if (isfilechg = bTrue);
      exsr dltcsrpos;
      exsr c_top;
    else;
      if (iskeychg = bFalse);
        exsr pbrefresh;
      else;
        exsr dltcsrpos;
        exsr keyhaschg;
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
  ispbinit = bFalse;
  //  Merker für: Programmablauf innerhalb der READC-Schleife
  //              verhindern einer Rekursion über
  //              C_ENTER, C_PAGEUP, C_PAGEDOWN
  isReadSfl = bTrue;

  r#iscmderr = isCmdErr;

  //  Mindestens 1 Eintrag verarbeitet ...
  isreadc = bFalse;

  if (*in80 = *off);
  //           Keine Einträge vorhanden
  else;

    dou queryUser = *allx'00';

      queryUser = *allx'00';

      //  Lesen, solange bis keine zu verarbeitenden
      //  Sätze mehr da sind, oder bis durch einen
      //  Kurzbefehl (SFPAU) die Subfile neu auf-
      //  gebaut worden ist.
      dow ispbinit = bFalse;

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
          sflCsr = sflrec132;
        else;
          sflCsr = sflrec080;
        endif;

        //  Linksbündig setzen ...
        sfpau = %triml(sfpau);

        //  Prompt ...
        if (%trim(sfpau) = set0008.set_prmt);
          exsr pmt_sfpau;
        endif;

        //  Zuordnung AUSWAHL => Befehl ...
        peek21('#' + sfpau: sds.pgmname
              : yPgmCmd: ycmddta: yMsgID: yMsgDta);
        if (yMsgID <> *blanks);
          //  Fehlermeldung ...
          p_sndpgmmg('USR8110': sfpau: sds.pgmname);

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
          isreadc = bTrue;
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

  isCmdErr = r#iscmderr;
  isReadSfl = bFalse;

  if (isreadc = bTrue);
    exsr getobjattr;
    exsr getmbrattr;
  endif;

endsr;

//============================================================*
//    PBSflChain    CHAIN auf PBSFL                           *
//============================================================*

begsr pbSflChain;

  if (*in88 = *off);
    chain sflrec132 pbsfl132;
  endif;
  if (*in88 = *on);
    chain sflrec080 pbsfl080;
  endif;

  if (%found());
  //  ... alles in Ordnung
  else;
    //  ... letzte Nachricht löschen
    p_rmvpgmmg(sds.pgmname);
  endif;

endsr;

//============================================================*
//    PBSflWrite    WRITE auf PBSFL                           *
//============================================================*

begsr pbsflwrite;

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

begsr c_pageup;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
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
//    C_PageDown    PgDn - Rückwärts blättern                 *
//============================================================*

begsr c_pagedown;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    //  Verarbeiten der Subfile-Auswahlen
    if (isReadSfl = bTrue);
    //       verhindern einer Rekursion
    else;
      exsr c_readSfl;
    endif;

    //  Blättern
    sflCsr = nbrPinRcd + 1;
    exsr pbreadcsr;
    exsr pbReadDown;

    exsr pbInit;
    exsr pbPinRcd;
    exsr pbReadUp;

  endif;

endsr;

//============================================================*
//    C_EndPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endpgm;

  // - Speichern der Arbeitsumgebung
  if (i_envsave = bTrue);
    yisautosave = bTrue;
    exsr saveenv;
  endif;

  exsr closefile;
  if (isOpen = bFalse);

    // - Benutzervoreinstellungen
    exsr setusrsetg;

    // - Endenachricht
    p_rmvpgmmg(sds.pgmname);

    clear usr8100; // Verarbeitung abgebrochen
    usr8100.var1 = yPgmCmd;
    exitmsg = f_msgtext('USR8100': usr8100);

    clear usr9999;
    usr9999.var1 = exitmsg;
    usr9999.var2 = '';
    p_sndpgmmg('USR9999': usr9999: sds.pgmname);
    p_movpgmmg(sds.pgmname);

  else;
    //  Fehlermeldung ...
    p_sndpgmmg('USR8103': '': sds.pgmname);
  endif;

endsr;

//============================================================*
//    C_Prompt      F4  - Prompt                              *
//============================================================*

begsr c_prompt;

  if (isOpen = bFalse);

    select;
    when ((scnfld   = '##FILE'  ) or
       (##file   = set0008.set_prmt  ) or
       (f_endswith('*': %trim(##file))));
      exsr pmt_file;
    when ((scnfld   = '##MEMBER') or
       (##member = set0008.set_prmt  ));
      exsr pmt_mbr;
    other;
      //      Nix tun, keine Datei vorhanden
      exsr msgnofile;
    endsl;

  else;

    select;
    when ((scnfld   = '##FIELD ') or
       (##field  = set0008.set_prmt  ));
      exsr pmt_field;
    when ((scnfld   = '##FILE'  ) or
       (##file   = set0008.set_prmt  ) or
       (f_endswith('*': %trim(##file))));
      exsr pmt_file;
    when ((scnfld   = '##MEMBER') or
       (##member = set0008.set_prmt  ));
      exsr pmt_mbr;
    when ((scnfld   = '##FORMAT') or
       (##format = set0008.set_prmt  ));
      exsr pmt_fmt;
    when ((scnfld   = 'SFPAU'   ) or
       (sfpau    = set0008.set_prmt  ));
      exsr pmt_sfpau;
    other;
      p_sndpgmmg('USR8179': '': sds.pgmname);
    endsl;

  endif;

  exsr keepCsrPos;

endsr;

//============================================================*
//    Pmt_Field     Prompt - Field                            *
//============================================================*

begsr pmt_field;

  peek37(set0001.set_dsp80: COPYRIGHT: yfield
        : yMsgID: yMsgDta);

  if (yMsgID = *blanks);
    ##field = yfield;
    *in93 = '1';
  else;
    p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
    yMsgID = '';
    yMsgDta = '';
    *in93 = '0';
  endif;

endsr;

//============================================================*
//    Pmt_File      Prompt - File                             *
//============================================================*

begsr pmt_file;

  //  Wenn das Feld gesperrt ist, ...
  if (*in75 = *on);
    //  ... dann
    //      ausgeben Meldung
    p_sndpgmmg('USR8179': '': sds.pgmname);
  else;
    //  ... sonst
    //      aufrufen "Auswahl Datei"
    if ##file = *blanks
       or ##file = set0008.set_prmt;
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
      p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
      yMsgID = '';
      yMsgDta = '';
      *in93 = '0';
    endif;

  endif;

endsr;

//============================================================*
//    Pmt_Mbr       Prompt - Member                           *
//============================================================*

begsr pmt_mbr;

  //  Wenn das Feld gesperrt ist, ...
  if (*in77 = *on);
    //  ... dann
    //      ausgeben Meldung
    p_sndpgmmg('USR8179': '': sds.pgmname);
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
      p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
      yMsgID = '';
      yMsgDta = '';
      *in93 = '0';
    endif;

  endif;

endsr;

//============================================================*
//    Pmt_Fmt       Prompt - Format                           *
//============================================================*

begsr pmt_fmt;

  peek12(set0001.set_dsp80: COPYRIGHT: ##format
        : MODE_INTER
        : rcdl0200: yfmtnbr: yMsgID: yMsgDta);

  if (yMsgID = *blanks);
    ##fmtnbr = yfmtnbr;
    ##format = rcdl0200.r2fmtname;
    $$length = rcdl0200.r2rcdlen;
    *in93 = '1';
  else;
    p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
    yMsgID = '';
    yMsgDta = '';
    *in93 = '0';
  endif;

endsr;

//============================================================*
//    Pmt_Sfpau     Prompt - Subfileauswahl                   *
//============================================================*

begsr pmt_sfpau;

  peek68(set0001.set_dsp80: sds.pgmname: COPYRIGHT
        : ysflopt: yMsgID: yMsgDta);

  //  Einlesen Subfiledatensatz
  sflrec132 = sflCsr;
  sflrec080 = sflCsr;
  exsr pbSflChain;

  //  Abbruch mit F3/F12
  if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
    sfpau = '';
    *in84 = '1'; // SFLNXTCHG
    *in85 = '0'; // SFPAU(RI)
  else;
    sfpau = ysflopt;
    *in84 = '1'; // SFLNXTCHG
    *in85 = '0'; // SFPAU(RI)
  endif;

  //  Aktualisieren Subfiledatensatz
  exsr pbSflUpdate;

  if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
    p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
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
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    //      ... aktualisieren "offene Datei"
    exsr getopnfile;

    //      ... aktualisieren Subfile
    exsr pbrefresh;

    //      ... abrufen der Objektattribute
    exsr getobjattr;

    //      ... abrufen der Anzahl Teildateien
    exsr getnbrmbr;

    //      ... abrufen Objektattribute
    exsr getobjattr;

    //      ... abrufen der Teildateiattribute
    exsr getmbrattr;
  endif;

  //      ... positionieren Cursor
  if (sflCsr = 0);
    exsr c_poscsr;
  endif;

endsr;

//============================================================*
//    C_Add         F6  - Neuanlage eines Datensatz           *
//============================================================*

begsr c_add;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    if (isUpdMod = bFalse);
      //      Neuanlage nicht möglich, da INPUT-Modus
      clear usr0007;
      usr0007.var1 = ##file;
      usr0007.var2 = ##library;
      p_sndpgmmg('USR0007': usr0007: sds.pgmname);
    else;

      yFunction = '*ADD';
      exsr callUpdPgm;

      //  Ermitteln Objektattribute
      exsr getobjattr;

      //  Ermitteln der Teildateiattribute (Anzahl Sätze)
      exsr getmbrattr;

    endif;
  endif;

endsr;

//============================================================*
//    C_ChgHead     F7  - Umschalten der Überschrift          *
//============================================================*

begsr c_chghead;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    set0001.set_hedtyp = f_nextheadertype(set0001.set_hedtyp);

    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    C_TgMrkCol    F8  - Spalte markieren ein/aus            *
//============================================================*

begsr c_tgmrkcol;

  if (isOpen = bFalse);
    // Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getfldtmrk;

    if (wrk#field <> '');
      isSflDirty = bTrue;

      // Umschalten der Farbe im Datensatz ...
      clear f_key;
      f_key.f_field = col_field(x);
      chain(n) %kds(f_key) fpeekfld;
      if (%found(peekfld));
        if (f_markcol = bFalse);
          exsr c_mrkcol;
        else;
          exsr c_unmrkcol;
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
//    C_MrkCol      F8  - Spalte markieren ein                *
//============================================================*

begsr c_mrkcol;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getfldtmrk;

    if (wrk#field <> '');
      isSflDirty = bTrue;

      //  Einschalten der Farbe im Datensatz ...
      clear f_key;
      f_key.f_field = col_field(x);
      chain %kds(f_key) fpeekfld;
      if (%found(peekfld));
        f_markcol = bTrue;
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
//    C_UnMrkCol    F8  - Spalte markieren aus                *
//============================================================*

begsr c_unmrkcol;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getfldtmrk;

    if (wrk#field <> '');
      isSflDirty = bTrue;

      //  Ausschalten der Farbe im Datensatz ...
      clear f_key;
      f_key.f_field = col_field(x);
      chain %kds(f_key) fpeekfld;
      if (%found(peekfld));
        f_markcol = bFalse;
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
//    C_MoveTop     F9  - Selektieren Datensatz               *
//============================================================*

begsr c_movetop;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getSflRcd;

    if (sflCsr > 0);

      exsr pbreadcsr;
      exsr pbInit;
      exsr pbPinRcd;
      exsr pbReadUp;
      sfsanr = nbrPinRcd + 1;

    else;
      //  Fehlermeldung ...
      p_sndpgmmg('USR8102': '': sds.pgmname);
    endif;

  endif;

endsr;

//============================================================*
//    C_PosCsr      F10    - Cursor auf Keyeingabe pos.       *
//============================================================*

begsr c_poscsr;

  *in87 = '1';

endsr;

//============================================================*
//    C_UserSetg    F11    - Benutzervoreinstellugnen         *
//============================================================*

begsr c_usersetg;

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
      p_updusrsg('*DSPATTR' : set0001);
      exsr c_refresh;
    else;
    //            Verrabeitung durch Benutzer
    //            abgebrochen
    endif;
  endif;

endsr;

//============================================================*
//    C_Repeat      F13 - Wiederholen der Subfileauswahl      *
//============================================================*

begsr c_repeat;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    //  "Keine Sätze ..."
    if (sflnbrrcd = 0);
    //  Keine Datensätze vorhanden.
    else;

      //  Ermitteln der letzten Subfile-Auswahl ...
      exsr getlastopt;
      if (isError = bTrue);
        //  Fehlermeldung ...
        p_sndpgmmg('USR8165': '': sds.pgmname);
      else;

        //  "Reaktivieren" der letzten Subfileauswahl ...
        sflrec132 = wrk#recno;
        sflrec080 = wrk#recno;
        exsr pbSflChain;
        *in84 = '1'; // SFLNXTCHG
        exsr pbSflUpdate;
        //  Verarbeitung ...
        wrk#recno = wrk#recno + 1;
        exsr repeatopt;
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    C_Layout      F15    - Layout                           *
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
//    C_Search      F16    - Suchfunktion                     *
//============================================================*

begsr c_search;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    select;
    when (srchmode = '*NEW');
      monitor;
        peek17(set0001.set_dsp80: COPYRIGHT
              : yQFile: ##member
              : yfield: yoperation: yargument
              : ysign: ysrchnbrs: ysrchtype
              : ysrchcase: yMsgID: yMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

      if (*in99 = *off);
        if (yMsgID = 'USR8112'); // Verarbeitung bestätigt.
          exsr srchstart;
        else;
          p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
          yMsgID = '';
          yMsgDta = '';
        endif;
      else;
      //  Fehler beim Aufruf von PEEK17 ...
      endif;

    when (srchmode = '*FOUND');
      exsr srchcont;

    when (srchmode = '*MAXIMUM');
      exsr srchcontm;

    when (srchmode = '*EOF');
      exsr srcheof;

    other;
    //               ???????????
    endsl;

    //  Gefunden?
    if (srchmode = '*FOUND');
      srchfndrcd = file#x.rcdnbr;
      exsr pbreadp;
    else;
      exsr pbReadDown;
    endif;

    //  Anzeigen der Subfile
    exsr pbInit;
    exsr pbPinRcd;
    exsr pbReadUp;

    //  Meldung
    select;
    when (srchmode = '*FOUND');
      p_sndpgmmg('USR8130': '': sds.pgmname);
    when (srchmode = '*EOF');
      p_sndpgmmg('USR8131': '': sds.pgmname);
    when (srchmode = '*MAXIMUM');
      p_sndpgmmg('USR8132': '': sds.pgmname);
    other;
    endsl;

  endif;

endsr;

//============================================================*
//    C_Top         F17 - Anfang der Datei                    *
//============================================================*

begsr c_top;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr pbmovetop;
    exsr pbInit;
    exsr pbPinRcd;
    exsr pbReadUp;

    sfsanr = nbrPinRcd + 1;
  endif;

endsr;

//============================================================*
//    C_Bot         F18 - Ende der Datei                      *
//============================================================*

begsr c_bot;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr pbmovebot;
    exsr pbInit;
    exsr pbPinRcd;
    exsr pbReadDown;
    exsr pbReadUp;

    sfsanr = sflnbrrcd;
  endif;

endsr;

//============================================================*
//    C_MoveL       F19 - Nach links verschieben              *
//============================================================*

begsr c_movel;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    if (##strpage > 1);
      if (set0010.set_scroll = '*BOTH'
          or set0010.set_scroll = '*LEFT');
        ##strpage = ##strpage - 1;
      else;
        ##strpage = 1;
        ##wndnbr = ##wndnbr - 1;
      endif;
    else;
      ##wndnbr = ##wndnbr - 1;
      if (set0010.set_scroll = '*BOTH'
          or set0010.set_scroll = '*LEFT');
        ##strpage = *hival;
      else;
        ##strpage = 1;
      endif;
    endif;

    exsr chkseqrnge;

    exsr pbrefresh;
  endif;

endsr;

//============================================================*
//    C_MoveR       F20 - Nach rechts verschieben             *
//============================================================*

begsr c_mover;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    if (cp = 1) and
       (col_error(cp) = bTrue);
      if ((set0010.set_scroll = '*BOTH') or
         (set0010.set_scroll = '*RIGHT'));
        ##strpage = ##strpage + 1;
      else;
        ##wndnbr = ##wndnbr + 1;
        ##strpage = 1;
      endif;
    else;
      ##wndnbr = ##wndnbr + 1;
      ##strpage = 1;
    endif;

    exsr chkseqrnge;
    exsr pbrefresh;
  endif;

endsr;

//============================================================*
//    C_PageL       F19 - Nach links verschieben,             *
//                  ganze Seite                               *
//============================================================*

begsr c_pageLeft;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
    leavesr;
  endif;

  //  Prüfen "Seite innerhalb des Feldes"
  if (##strpage > 1);
    ##strpage = ##strpage - 1;
  else;

    //  Bereits am Anfang
    if ##wndnbr = l#minseq
       and ##strpage = 1;
    else;

      //  Ermitteln der Feldnummer des 1. angezeigten
      //  Feldes ...
      x = nbrPinCol + 1;
      wrk#field = col_field(x);
      exsr getseqnbr;
      if (isSeqNbrOK = bFalse and l#minseq > 0);
        wrk#seqnbr = l#minseq;
        isSeqNbrOK = bTrue;
      endif;

      if (isSeqNbrOK = bTrue);
        exsr getprvseq;
        ##wndnbr = wrk#seqnbr;
        if (set0010.set_scroll = '*BOTH'
           or set0010.set_scroll = '*LEFT');
          ##strpage = *hival;
        else;
          ##strpage = 1;
        endif;
      else;
        ##wndnbr = l#minseq;
        ##strpage = 1;
      endif;

      //  Füllen einer Dummy-Zeile von rechts nach
      //  links zur Ermittlung des 1. anzuzeigenden
      //  Feldes ...
      if (##wndnbr > l#minseq);
        exsr pbFillDataRow_Left;
        //  ... kein Feld gefunden
        if (cp <= 0);
          ##wndnbr = l#minseq;
          ##strpage = 1;
        else;
          //  ... Felder gefunden
          if (cp = 1);
            //      ... aber nur 1 Feld
            wrk#field = col_field(cp);
          else;
            //      ... mehrere Felder
            if (col_error(cp) = bFalse);
              //          ... komplett sichtbar
              wrk#field = col_field(cp);
            else;
              //          ... nicht komplett sichtbar,
              //              nächstes Feld als Startfeld nehmen
              x = cp - 1;
              wrk#field = col_field(x);
              ##strpage = 1;
            endif;
            //      ... umrechnen in Feldnummer
            exsr getseqnbr;
            if (isSeqNbrOK = bTrue);
              ##wndnbr = wrk#seqnbr;
            else;
              ##wndnbr = *loval;
              ##strpage = 1;
            endif;
          endif;
        endif;
      endif;
    endif;
  endif;

  exsr chkseqrnge;
  exsr pbrefresh;

endsr;

//============================================================*
//    C_PageR       F20 - Nach rechts verschieben,            *
//                  ganze Seite                               *
//============================================================*

begsr c_pageRight;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    wrk#field = col_field(cp);
    exsr getseqnbr;
    if (isSeqNbrOK = bTrue);

      if (col_error(cp) = bTrue);
        if (cp - nbrPinCol = 1);

          if (set0010.set_scroll = '*BOTH'
              or set0010.set_scroll = '*RIGHT');
            ##wndnbr = wrk#seqnbr;
            ##strpage = ##strpage + 1;
          else;
            ##wndnbr = wrk#seqnbr + 1;
            ##strpage = 1;
          endif;

        else;
          ##wndnbr = wrk#seqnbr;
          ##strpage = 1;
        endif;
      else;
        ##wndnbr = wrk#seqnbr + 1;
        ##strpage = 1;
      endif;

    else;
      ##wndnbr = *hival;
      ##strpage = 1;
    endif;

    exsr chkseqrnge;
    exsr pbrefresh;
  endif;

endsr;

//============================================================*
//    C_CmdLine     F21 - Befehlszeile                        *
//============================================================*

begsr c_cmdline;

  if (f_cmdline = bTrue);
    callp(e) quscmdln();
    *in99 = %error;
  endif;

endsr;

//============================================================*
//    C_ChgScn      F22 - Umschalten der Bildschirmauflösung  *
//============================================================*

begsr c_chgscn;

  wrk#readdn = sflpage;
  exsr chgscreen;
  wrk#readdn = wrk#readdn - sflpage;

  exsr pbrefresh;

endsr;

//============================================================*
//    C_MoreOpt     F23 - Weitere Auswahlen                   *
//============================================================*

begsr c_moreopt;

  sftop = sftop + 1;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_morekeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    C_NextMark    Fxx - Nächste Markierung ansteueren       *
//============================================================*

begsr c_nextmark;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getfrstfld;

    wrk#seqnbr = ##wndnbr;
    exsr getnxtmark;
    if (wrk#seqnbr > 0);
      ##wndnbr = wrk#seqnbr;
      ##strpage = 1;
    else;
      wrk#seqnbr = *loval;
      exsr getnxtmark;
      if (wrk#seqnbr > 0);
        ##wndnbr = wrk#seqnbr;
        ##strpage = 1;
      else;
      //    ... keine Markierung gefunden
      endif;
    endif;

    exsr chkseqrnge;

    exsr pbrefresh;
  endif;

endsr;

//============================================================*
//    C_PrevMark    Fxx - Vorherige Markierung ansteueren     *
//============================================================*

begsr c_prevmark;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getfrstfld;

    wrk#seqnbr = ##wndnbr;
    exsr getprvmark;
    if (wrk#seqnbr > 0);
      ##wndnbr = wrk#seqnbr;
      ##strpage = 1;
    else;
      wrk#seqnbr = *hival;
      exsr getprvmark;
      if (wrk#seqnbr > 0);
        ##wndnbr = wrk#seqnbr;
        ##strpage = 1;
      else;
      //    ... keine Markierung gefunden
      endif;
    endif;

    exsr chkseqrnge;

    exsr pbrefresh;
  endif;

endsr;

//============================================================*
//    C_BuildPgm    Erstellen Update Programm                 *
//============================================================*

begsr c_buildpgm;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    peek52(set0001.set_dsp80: COPYRIGHT
          : yalwlc: ycase: yrcdlock: ynulldft
          : ykeepcrs: yMsgID: yMsgDta: bFalse);

    if (yMsgID = 'USR8112'); // Verarbeitung bestätigt.

      //  Rekursiver CALL auf sich selbst (= PEEK05),
      //  um die alte Referenz auf das Update-Programm zu löschen
      monitor;
        UPDPGM_NAME = f_pgmcalln(sds.pgmname);
        yHeaderType = set0001.SET_HedTyp;
        UPDPGM(ydsp80
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
        p_rmvpgmmg(sds.pgmname);

        exsr getPgmName;

        //  Generierung
        peek08(yQFile: peekPgm: rcdl0200.r2fmtname
              : rcdl0200.r2fmtid
              : yalwlc: ycase: yrcdlock: ynulldft
              : ykeepcrs: sds.pgmlib: yrtncode);

        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;
    endif;

    peek52(set0001.set_dsp80: COPYRIGHT
          : yalwlc: ycase: yrcdlock: ynulldft
          : ykeepcrs: yMsgID: yMsgDta: bTrue);
  endif;

endsr;

//============================================================*
//    C_Register    Prüfen der Registrierungsdaten            *
//============================================================*

begsr c_register;

  monitor;
    peek30(set0001.set_dsp80: yCopyright
          : yflag: yMsgID: yMsgDta);
    p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
    yMsgID = '';
    yMsgDta = '';
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = *on);
    //  Fehler beim Programmaufruf ...
    p_movpgmmg(sds.pgmname);
    isLicenceError = bTrue;
    leavesr;
  else;
    if yflag <> -55
       and yflag <> 66
       and yflag <> 243;
      //  Fehler im Wertebereich ...
      isLicenceError = bTrue;
      leavesr;
    else;
      //  Datum ist abgelaufen ...
      if (yflag = -55);
        isLicenceError = bTrue;
        leavesr;
      else;
      //  Registrierung ist OK ...
      endif;
    endif;
  endif;

  //  "Nachschießen" SPLASH-Screen
  if (yflag = 243 and set0005.set_spla = bFalse);
    exsr s_splashon;
    exsr showsplash;
  endif;

  isLicenceError = bFalse;

endsr;

//============================================================*
//    C_ClrPinRw    Löschen der Pin-Tabelle für Zeilen        *
//============================================================*

begsr c_clrpinrw;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr clrpinrow;

    //  Merker für aktualisieren der Subfile
    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    C_ClrPinCl    Löschen der Pin-Tabelle für Spalten       *
//============================================================*

begsr c_clrpincl;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr clrpincol;

    //  Merker für aktualisieren der Subfile
    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    C_DspDbr      Anzeigen der Datenbankrelationen          *
//============================================================*

begsr c_dspdbr;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
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

      if (isfilechg = bTrue);
        exsr c_top;
      else;
      endif;
    endif;
  endif;

endsr;

//============================================================*
//    C_SortBKey    Anzeigen der Sätze in Schlüsselfolge      *
//============================================================*

begsr c_sortbkey;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;
    if (accessMode = KEY_SEQ);
    //    ... Sortierung stimmt bereits
    else;

      //  Umschalten der Sortierung
      newAccessMode = KEY_SEQ;
      exsr changesort;

    endif;
  endif;

endsr;

//============================================================*
//    C_SortBRrn    Anzeigen der Sätze in Satzfolge           *
//============================================================*

begsr c_sortbrrn;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;
    if (accessMode = RRN_SEQ);
    //    ... Sortierung stimmt bereits
    else;

      if f_numbased(##file    :
                 ##library :
                 ##member  ) = 1;
        newAccessMode = RRN_SEQ;
        exsr changesort;
      else;
        clear usr8217;
        p_sndpgmmg('USR8217': usr8217: sds.pgmname);
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    C_SortTgl     Umschalten der Sortierfolge               *
//============================================================*

begsr c_sorttgl;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;
    if (accessMode = RRN_SEQ);
      exsr c_sortbkey;
    else;
      exsr c_sortbrrn;
    endif;
  endif;

endsr;

//============================================================*
//    S_TglKeyLC_UC Umschalten Eingabe der Schlüsselfelder    *
//============================================================*

begsr s_tglkeylc_uc;

  if (isKeyLower = bFalse);
    isKeyLower = bTrue;
    clear usr8223;
    p_sndpgmmg('USR8223': usr8223: sds.pgmname);
  else;
    isKeyLower = bFalse;
    clear usr8224;
    p_sndpgmmg('USR8224': usr8224: sds.pgmname);
  endif;

endsr;

//============================================================*
//    C_PinCDlg     Pin-Dialog                                *
//============================================================*

begsr c_pincdlg;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
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

        exsr clrpincol;

        for y = 1 to max_pin_col;
          if (yPinTabCol(y) <> ' ');
            wrk#field = yPinTabCol(y);
            exsr pincol;
          endif;
        endfor;

      endif;
    endif;

  endif;

endsr;

//============================================================*
//    C_Sql         SQL-Auswahl                               *
//============================================================*

begsr c_sql;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
    leavesr;
  endif;

  if (fild0100.atfila <> '*PHY');

    select;
    when (fild0100.atnofm = 1);
      //  Wenn es sich um eine "single-format logical file" handelt, ...
      //  ... dann prüfen, ob diese Datei über mehere Member geht.
      //      Sortierung nach SQL wird für "multi-member logical files"
      //      (noch) nicht unterstützt ...
      if fild0100.atjoin = 'N' and
         f_numbased(##file: ##library: ##member) > 1;

        clear usr8235;
        p_sndpgmmg('USR8235': usr8235: sds.pgmname);
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
        f_basedpf(##file     :
                 ##library  :
                 ##member   :
                 ##format   :
                 ##fmtnbr   :
                 ##file     :
                 ##library  :
                 ##member   :
                 ##format   );
      else;
        leavesr;
      endif;

    endsl;

  endif;

  // Let the user enter the SQL WHERE and ORDER BY clauses:
  monitor;
    yFile = ##file;
    yLibrary = ##library;
    yMember = ##member;
    yformat = ##format;
    ysqlwhere = sqlWhere;
    ysqlorder = sqlOrder;
    peek48(set0001.set_dsp80: COPYRIGHT
          : yFile: yLibrary: yMember
          : yformat
          : accessMode: ysqlwhere: ysqlorder
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

  isPinToClr = bFalse;

  exsr closefile;

  ##file = yFile;
  ##library = yLibrary;
  ##member = yMember;
  ##format = yformat;

  if (ysqlwhere  <> ' ') or
     (ysqlorder  <> ' ');
    if (accessMode <> SQL_SEQ);
      oldaccmode = accessMode;
    endif;
    accessMode = SQL_SEQ;
    sqlWhere   = ysqlwhere;
    sqlOrder   = ysqlorder;
  else;
    accessMode = oldaccmode;
    sqlWhere   = ' ';
    sqlOrder   = ' ';
  endif;

  exsr openfile;

  isPinToClr = bTrue;

endsr;

//============================================================*
//    S_Change      02 - Ändern Einzelsatz                    *
//============================================================*

begsr s_change;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    if (isUpdMod = bFalse);
      //      Ändern nicht möglich, da INPUT-Modus
      clear usr0007;
      usr0007.var1 = ##file;
      usr0007.var2 = ##library;
      p_sndpgmmg('USR0007': usr0007: sds.pgmname);
    else;

      exsr getSflRcd;

      if (sflCsr > 0);
        yFunction = '*CHANGE';
        exsr callUpdPgm;
        exsr reloadusrstg;
      else;
      //        kein Datensatz verfügbar
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    S_Copy        03 - Kopieren Einzelsatz                  *
//============================================================*

begsr s_copy;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    if (isUpdMod = bFalse);
      //      Ändern nicht möglich, da INPUT-Modus
      clear usr0007;
      usr0007.var1 = ##file;
      usr0007.var2 = ##library;
      p_sndpgmmg('USR0007': usr0007: sds.pgmname);
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
//    S_CopyExt     09 - Kopieren Einzelsatz in externe Datei *
//============================================================*

begsr s_copyExt;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    if (auth.isUpdAlw = bFalse);
    //      Nachricht "Keine Berechtigung" ausgeben.
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
//    S_Delete      04 - Löschen Einzelsatz                   *
//============================================================*

begsr s_delete;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    if (isUpdMod = bFalse);
      //      Löschen nicht möglich, da INPUT-Modus
      clear usr0007;
      usr0007.var1 = ##file;
      usr0007.var2 = ##library;
      p_sndpgmmg('USR0007': usr0007: sds.pgmname);
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
//    S_Display     05 - Anzeigen Einzelsatz                  *
//============================================================*

begsr s_display;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getSflRcd;

    if (sflCsr > 0);

      monitor;
        yHeaderType = set0001.set_hedtyp;
        PEEK14(set0001.set_dsp80: yHeaderType: COPYRIGHT
              : wrk#rcdnbr: h_file: h_lib: h_mbr
              : h_rcdfmt: '*DISPLAY': commitLvl
              : yScreenNbr: yMsgID: yMsgDta);
        if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
          p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
          yMsgID = '';
          yMsgDta = '';
        else;
          if (set0001.set_hedtyp <> yHeaderType);
            set0001.set_hedtyp = yHeaderType;
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

begsr s_print;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getSflRcd;

    if (sflCsr > 0);

      monitor;
        peek65(wrk#rcdnbr: h_file: h_lib: h_mbr: ''
              : yMsgID: yMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

      if (yMsgID <> '');
        p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
        yMsgID  = '';
        yMsgDta = '';
      endif;

    else;
    //        kein Datensatz verfügbar
    endif;
  endif;

endsr;

//============================================================*
//    S_PinRcd      P  - Pin Datensatz                        *
//============================================================*

begsr s_pinrcd;

  if (isOpen = bFalse);
    //**  F4Open        OREQ      '0'
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    if (f_numbased(##file: ##library: ##member) > 1);
      clear usr8218;
      p_sndpgmmg('USR8218': usr8218: sds.pgmname);
      isCmdErr = bTrue;
      isCancel = bTrue;
    else;

      exsr getSflRcd;

      if (sflCsr > 0);

        if f_chain04(wrk#rcdnbr:
                  h_file   :
                  h_lib    :
                  h_mbr    :
                  h_rcdfmt ) = '0';
          exsr pinrecord;

        else;
          //  Datensatz nicht gefunden ...
          p_sndpgmmg('USR8120': '': sds.pgmname);
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

begsr s_unpinrcd;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getSflRcd;

    if (sflCsr > 0);

      exsr chkpinrcd;
      if (ispinned = bFalse);
        //  Datensatz ist nicht gepinned ...
        p_sndpgmmg('USR8121': '': sds.pgmname);
      else;
        //  Datensatz ist gepinned ...
        exsr rmvpinrcd;
      endif;

    else;
    //        kein Datensatz verfügbar
    endif;
  endif;

endsr;

//============================================================*
//    S_TgTblPap    Toggeln Tabellierpapierfunktion           *
//============================================================*

begsr s_tgtblpap;

  if (set0001.set_tblmde = bTrue);
    exsr s_tblpapof;
  else;
    exsr s_tblpapon;
  endif;

endsr;

//============================================================*
//    S_TblPapOn    Einschalten Tabellierpapier               *
//============================================================*

begsr s_tblpapon;

  if (set0001.set_tblmde = bTrue);
    //  Fehlermeldung ...
    p_sndpgmmg('USR8149': '': sds.pgmname);
  else;
    set0001.set_tblmde = bTrue;
    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    S_TblPapOf    Ausschalten Tabellierpapier               *
//============================================================*

begsr s_tblpapof;

  if (set0001.set_tblmde = bFalse);
    //  Fehlermeldung ...
    p_sndpgmmg('USR8150': '': sds.pgmname);
  else;
    set0001.set_tblmde = bFalse;
    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    S_TgPinCol    PC - Pin Spalte                           *
//============================================================*

begsr s_tgpincol;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getfldtmrk;

    if (wrk#field <> '');
      pin#field = wrk#field;
      exsr chkpincol;
      if (ispinned = bFalse);
        //  Datensatz ist noch nicht gepinned ...
        //  Spalte pinnen ...
        exsr pincol;
      else;
        exsr rmvPincolumn;
      endif;
    endif;
  endif;

  //  Beibehalten der Cursorposition ...
  exsr keepCsrPos;

endsr;

//============================================================*
//    S_PinCol      PC - Pin Spalte                           *
//============================================================*

begsr s_pincol;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getfldtmrk;

    if (wrk#field <> '');
      //  Spalte pinnen ...
      exsr pincol;
    endif;
  endif;

  //  Beibehalten der Cursorposition ...
  exsr keepCsrPos;

endsr;

//============================================================*
//    S_UnPinCol    UC - UnPin Spalte                         *
//============================================================*

begsr s_unpincol;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getfldtmrk;

    if (wrk#field <> '');
      pin#field = wrk#field;
      exsr chkpincol;
      if (ispinned = bFalse);
        //  Spalte ist nicht gepinned ...
        clear usr8147;
        usr8147.var1 = wrk#field;
        p_sndpgmmg('USR8147': usr8147: sds.pgmname);
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
//    S_SplashOn    Einschalten Splash-Screen                 *
//============================================================*

begsr s_splashon;

  set0005.set_spla = bTrue;

  p_sndpgmmg('USR8161': '': sds.pgmname);

endsr;

//============================================================*
//    S_SplashOf    Ausschalten Splash-Screen                 *
//============================================================*

begsr s_splashof;

  set0005.set_spla = bFalse;

  p_sndpgmmg('USR8162': '': sds.pgmname);

endsr;

//============================================================*
//    S_ShortCmd    Ausführen Kurzbefehl                      *
//============================================================*

begsr s_shortcmd;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    exsr getSflRcd;

    if (sflCsr > 0);

      clear shortcmd;
      shortcmd.sc_action = '*CMD';
      shortcmd.sc_cmd = ycmddta;

      monitor;
        peek42(h_file: h_lib: h_mbr: h_rcdfmt
              : shortcmd: wrk#rcdnbr: yexeccmd
              : yMsgID: yMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

      select;
      when (*in99 = *on);
      //           Program error
      when (yMsgID <> *blanks);
        p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
        yMsgID = '';
        yMsgDta = '';

      when (yexeccmd = *blanks);
      //           No command to excute
      other;
        f_execute(yexeccmd: yMsgID: yMsgDta);
        if (yMsgID <> '');
          p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
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
//    S_About        A - Über Peek/400                        *
//============================================================*

begsr s_about;

  peek49(set0001.set_dsp80: COPYRIGHT
        : RELEASE: VERSION
        : yMsgID: yMsgDta);

endsr;

//============================================================*
//    S_DspNrm      Normale Anzeige                           *
//============================================================*

begsr s_dspnrm;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;
    if (set0001.set_dspmde = '*DSPNRM');
    //    ... Anzeige stimmt bereits
    else;

      //  Umschalten der Anzeige
      set0001.set_dspmde = '*DSPNRM';
      isSflDirty = bTrue;

    endif;
  endif;

endsr;

//============================================================*
//    S_DspHex      Hexadezimale Anzeige                      *
//============================================================*

begsr s_dsphex;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;
    if (set0001.set_dspmde = '*DSPHEX');
    //    ... Anzeige stimmt bereits
    else;

      if (file#x.rcdlen > RCD_BUFF_LEN);
        clear usr8206;
        usr8206.var1   = RCD_BUFF_LEN;
        p_sndpgmmg('USR8206': usr8206: sds.pgmname);
      else;
        set0001.set_dspmde = '*DSPHEX';
        isSflDirty = bTrue;
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    S_DspTgl      Umschalten der Anzeige                    *
//============================================================*

begsr s_dsptgl;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;
    if (set0001.set_dspmde = '*DSPNRM');
      exsr s_dsphex;
    else;
      exsr s_dspnrm;
    endif;

    isSflDirty = bTrue;
  endif;

endsr;

//============================================================*
//    S_SaveEnv     Sichern Arbeitsumgebung                   *
//============================================================*

begsr s_saveenv;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    peek56(set0001.set_dsp80: COPYRIGHT: '*SAVE'
          : yenvfile: yenvlib: yenvmbr
          : $$rcdfmtid
          : yQFile: yMember: ytext: yoption
          : yMsgID: yMsgDta);

    if (yMsgID <> ' ');
      p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
      yMsgID = '';
      yMsgDta = '';
    else;

      yenvfile = yFile;
      yenvlib  = yLibrary;
      yenvmbr  = yMember;
      yisautosave = bFalse;
      exsr saveenv;

      if (yMsgID <> ' ');
        p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
        yMsgID = '';
        yMsgDta = '';
      endif;

    endif;

  endif;

endsr;

//============================================================*
//    S_LoadEnv     Laden Arbeitsumgebung                     *
//============================================================*

begsr s_loadenv;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    peek56(set0001.set_dsp80: COPYRIGHT: '*LOAD'
          : yenvfile: yenvlib: yenvmbr
          : $$rcdfmtid
          : yQFile: yMember: ytext: yoption
          : yMsgID: yMsgDta);

    if (yMsgID <> ' ');
      p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
      yMsgID = '';
      yMsgDta = '';
    else;

      yenvfile = yFile;
      yenvlib  = yLibrary;
      yenvmbr  = yMember;
      exsr loadenv;
      if (yMsgID <> ' ');
        p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
        yMsgID = '';
        yMsgDta = '';
      endif;

      isSflDirty = bTrue;
    endif;
  endif;

endsr;

//============================================================*
//    LoadEnv       Laden Arbeitsumgebung                     *
//============================================================*

begsr loadenv;

  isPinToClr = bFalse;

  if (##member = '*NONE');
    leavesr;
  endif;

  clear rtn;
  rtn.file = ##file;
  rtn.library = ##library;
  rtn.member = ##member;
  rtn.format = ##format;
  rtn.accessmode = accessMode;
  rtn.sqlwhere = sqlWhere;
  rtn.sqlorder = sqlOrder;

  peek55(##file: ##library: ##member: ##format
        : $$rcdfmtid
        : yenvfile: yenvlib: yenvmbr
        : yoption
        : pinTabRcd: nbrPinRcd
        : pinTabCol: nbrPinCol
        : rtn.file: rtn.library: rtn.member
        : rtn.format
        : rtn.accessmode: rtn.sqlwhere
        : rtn.sqlorder
        : isKeyLower
        : yMsgID: yMsgDta);

  if (yMsgID <> ' ');
  // TODO: remove code
  // p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
  // yMsgID = '';
  // yMsgDta = '';
  else;

    if (##file     <> rtn.file or
       ##library  <> rtn.library or
       ##member   <> rtn.member or
       ##format   <> rtn.format or
       accessMode <> rtn.accessmode or
       sqlWhere   <> rtn.sqlwhere or
       sqlOrder   <> rtn.sqlorder);
      exsr closefile;
      ##file     = rtn.file;
      ##library  = rtn.library;
      ##member   = rtn.member;
      ##format   = rtn.format;
      accessMode = rtn.accessmode;
      sqlWhere   = rtn.sqlwhere;
      sqlOrder   = rtn.sqlorder;
      exsr openfile;
      peek55(##file: ##library: ##member: ##format
            : $$rcdfmtid
            : yenvfile: yenvlib: yenvmbr
            : yoption
            : pinTabRcd: nbrPinRcd
            : pinTabCol: nbrPinCol
            : rtn.file: rtn.library: rtn.member
            : rtn.format
            : rtn.accessmode: rtn.sqlwhere
            : rtn.sqlorder
            : isKeyLower
            :yMsgID: yMsgDta);
    endif;

    isKeyLower = yIsKeyLower;
  endif;

  isPinToClr = bTrue;

endsr;

//============================================================*
//    SaveEnv       Speichern Arbeitsumgebung                 *
//============================================================*

begsr saveenv;

  peek54(##file: ##library: ##member: ##format
        : $$rcdfmtid
        : yenvfile: yenvlib: yenvmbr
        : yisautosave
        : pinTabRcd: nbrPinRcd
        : pinTabCol: nbrPinCol
        : accessMode: sqlWhere
        : sqlOrder: isKeyLower
        : yMsgID: yMsgDta);

endsr;

//============================================================*
//    S_DelEnv      Löschen Arbeitsumgebung                   *
//============================================================*

begsr s_delenv;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    for do_x2 = 1 to *hival;

      peek56(set0001.set_dsp80: COPYRIGHT: '*DELETE'
            : yenvfile: yenvlib: yenvmbr
            : ''
            : yQFile: yMember: ytext: yoption
            : yMsgID: yMsgDta);

      if (yMsgID <> ' ');
        p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
        yMsgID = '';
        yMsgDta = '';
        leave;
      else;

        peek57(set0001.set_dsp80: COPYRIGHT
              : yFile: yLibrary: yMember: ytext
              : yMsgID: yMsgDta);

        if (yMsgID <> ' ');
          if (yMsgDta = '*CANCEL');
            iter;
          else;
            p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
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
//    MsgNoFile     Nachricht: Keine Datei geöffnet           *
//============================================================*

begsr msgnofile;

  clear usr9996;
  p_sndpgmmg('USR9996': usr9996: sds.pgmname);

endsr;

//============================================================*
//    msgInvSqlFile Nachricht: Keine Datei geöffnet           *
//============================================================*

begsr msgInvSqlFile;

  clear usr9993;
  p_sndpgmmg('USR9993': usr9993: sds.pgmname);

endsr;

//============================================================*
//    ClrPinRow     Löschen der Pin-Tabelle für Zeilen        *
//============================================================*

begsr clrpinrow;

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

begsr clrpincol;

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
    yHeaderType = set0001.set_hedtyp;
    PEEK14(set0001.set_dsp80: yHeaderType: COPYRIGHT
          : wrk#rcdnbr: h_file: h_lib: h_mbr
          : h_rcdfmt: yPgmCmd: commitLvl
          : yScreenNbr: yMsgID: yMsgDta);
    if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
      p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
      yMsgID = '';
      yMsgDta = '';
    else;
      if (set0001.set_hedtyp <> yHeaderType);
        set0001.set_hedtyp = yHeaderType;
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
      yMsgId = 'USR8112'; // Verarbeitung bestätigt.
      yMsgDta = '';
      p_sndpgmmg('USR8112': '': sds.pgmname); // Verarbeitung bestätigt.

    when (yMsgID = 'USR8112'); // Verarbeitung bestätigt.

    //  Unerwartete Nachrichten-ID ...
    other;
      clear usr9998;
      usr9998.var1 = yMsgID;
      usr9998.var2 = 'PEEK14';
      p_sndpgmmg('USR9998': usr9998: sds.pgmname);
    endsl;

  endif;

endsr;

//============================================================*
//    PinRecord     Datensatz pinnen                          *
//============================================================*

begsr pinrecord;

  ispinok = bFalse;

  exsr chkpinrcd;
  if (ispinned = bFalse);
    //  Datensatz ist noch nicht gepinned ...
    clear pinTabRcdE;
    x = %lookup(pinTabRcdE: pinTabRcd: x);
    if (x > 0);
      //  ... Datensatz pinnen
      pinTabRcdE.rcdnbr = wrk#rcdnbr;
      pinTabRcdE.file = h_file;
      pinTabRcdE.lib = h_lib;
      pinTabRcdE.mbr = h_mbr;
      pinTabRcdE.rcdfmt = h_rcdfmt;
      pinTabRcdE.mbrnbr = h_mbrnbr;
      pinTabRcd(x) = pinTabRcdE;

      nbrPinRcd = x;
      isSflDirty = bTrue;
      ispinok = bTrue;
    else;
      //  Kein Platz mehr vorhanden ...
      p_sndpgmmg('USR8118': '': sds.pgmname);
    endif;

  else;
    //  Datensatz ist schon gepinned
    p_sndpgmmg('USR8119': '': sds.pgmname);
  endif;

endsr;

//============================================================*
//    PinCol        Spalte pinnen                             *
//============================================================*

begsr pincol;

  ispinok = bFalse;

  pin#field = wrk#field;
  exsr chkpincol;
  if (ispinned = bFalse);
    //  Datensatz ist noch nicht gepinned ...
    x = 1;
    pin#field = '';
    x = %lookup(pin#field: pinTabCol: x);
    if (x > 0);
      //  ... Datensatz pinnen
      pinTabCol(x) = wrk#field;
      nbrPinCol = x;
      isSflDirty = bTrue;
      ispinok = bTrue;
    else;
      //  Kein Platz mehr vorhanden ...
      p_sndpgmmg('USR8118': '': sds.pgmname);
    endif;

  else;
    //  Datensatz ist schon gepinned
    p_sndpgmmg('USR8119': '': sds.pgmname);
  endif;

endsr;

//============================================================*
//    DelRecord     Löschen Datensatz                         *
//============================================================*

begsr delRecord;

  if (f_chain00(wrk#rcdnbr: h_file: h_lib: h_mbr: '') = bTrue);

    //  Fehler bei Zugriff auf Datensatz ...
    usr8200.var1 = wrk#rcdnbr;
    p_sndpgmmg('USR8200': usr8200: sds.pgmname);

  else;

    if (cio_delete(hfile00) = bTrue);
      *in99 = '0';
    else;
      *in99 = '1';
    endif;
    exsr f0tofx;

    if (*in99 = *on);
      if (*in55 = bTrue);
        rolbk;
      else;
        cio_unlock(hfile00);
      endif;
      exsr f0tofx;

      usr8200.var1 = wrk#rcdnbr;
      p_sndpgmmg('USR8200': usr8200: sds.pgmname);
    else;
      if (*in55 = bTrue);
        commit;
      else;
        cio_unlock(hfile00);
      endif;
      exsr f0tofx;
      exsr callExit04;

      usr8201.var1 = wrk#rcdnbr;
      p_sndpgmmg('USR8201': usr8201: sds.pgmname);
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
    callp EXIT04(file#x.file: file#x.library: file#x.member
                 : '*DELETE': sds.user: %timestamp()
                 : wrk#rcdnbr: file#x.rcdlen: %addr(io_buff): *null);
  endif;

endsr;

//============================================================*
//    CopyExtRcd    Kopieren Datensatz in externe Datei       *
//============================================================*

begsr copyExtRcd;

  if f_chain04(wrk#rcdnbr:
            h_file   :
            h_lib    :
            h_mbr    :
            h_rcdfmt ) = '0';

    rcdnbr# = cio_getrrn(hfile04);

    f_execute(
      'CPYF ' +
        'FROMFILE(' +
          %trim(cio_getlibrary(hfile04)) +
        '/' +
          %trim(cio_getfile(hfile04)) +
        ') ' +
        'TOFILE(' +
          %trim(copyExternal.lib) +
        '/' +
          %trim(copyExternal.file) +
        ') ' +
        'FROMMBR(' +
          %trim(cio_getmember(hfile04)) +
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
          rcdnbr$ +
        ') ' +
        'TORCD(' +
          rcdnbr$ +
        ') ' +
        'FMTOPT(' +
          '*MAP *DROP' +
        ') ' +
        'RCDFMT(' +
          %trim(cio_getrecordformat(hfile04)) +
           ')'
      : yMsgID: yMsgDta);

    if (yMsgID <> '');
      isCmdErr = bTrue;
      p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
      yMsgID = '';
      yMsgDta = '';
      if (*in55 = bTrue);
        rolbk;
      endif;
      exsr f0tofx;

      usr8202.var1 = wrk#rcdnbr;
      p_sndpgmmg('USR8202': usr8202: sds.pgmname);
    else;
      if (*in55 = bTrue);
        commit;
      endif;
      exsr f0tofx;

      usr8203.var1 = wrk#rcdnbr;
      p_sndpgmmg('USR8203': usr8203: sds.pgmname);
    endif;

  endif;

  //  Alles weitere mit ...
  copyExternal.mbrOpt = '*ADD';

endsr;

//============================================================*
//    SrchStart     Aufsetzen mit neuer Suche                 *
//============================================================*

begsr srchstart;

  //  Übertragen der Übergabeparameter ...
  srchfield = yfield;
  srchop = yoperation;
  srcharg = %trimr(yargument);
  srchsign = ysign;

  //  ... Anpassungen für LIKE/NLIKE ...
  if srchop = 'LIKE'
     or srchop = 'NLIKE';
    //      ... führendes %-Zeichen
    a1 = %subst(srcharg:1:1);
    if (a1 = set0002.set_wldcd);
      srcharg = %subst(srcharg:2);
      srchliketp = 1;
    else;
      srcharg = srcharg;
      srchliketp = 0;
    endif;

    //      ... nachgestelltes %-Zeichen
    x = %checkr(' ': srcharg);
    if (x > 0);
      a1 = %subst(srcharg: x: 1);

      if (a1 = set0002.set_wldcd);
        x = x - 1;
        if (x > 0);
          srcharg = %subst(srcharg: 1: x);
        else;
          srcharg = *blanks;
        endif;
        srchliketp = srchliketp + 2;
      endif;

    endif;

    //      ... Länge von SrchArg
    srchlikeln = %checkr(' ': srcharg);
  else;
    //  ... keine Anpassungen erforderlich
    srchliketp = 0;
    srchlikeln = 0;
  endif;

  srchnbrs = ysrchnbrs;
  srchtype = ysrchtype;
  srchcase = ysrchcase;

  //  Ermitteln der Feldattribute
  exsr srchFldAtr;

  if (srchfield = '*RECORD');
    srchisnum = bFalse;
  else;
    if (f_isnumfld(fldl0100) = bTrue);
      srchisnum = bTrue;
    else;
      srchisnum = bFalse;
    endif;
  endif;

  //  Nicht Case-Sensitive suchen ...
  if (ysrchcase = bFalse and srchisnum = bFalse);
    srcharg = %xlate(C_LOWER: C_UPPER: srcharg);
  else;
  //      keine Konvertierung erforderlich
  endif;

  //  Numerische Suche ...
  if (srchisnum = bTrue);
    if (f_isfloatfld(fldl0100) = bTrue);
      srchargfloat = %float(srcharg);
      srchargval   = 0;
      srchargisfloat = bTrue;
    else;
      srchargval   = %dec(srcharg
                         : csrcharg_digits
                         : csrcharg_decpos);
      srchargfloat = 0;
      srchargisfloat = bFalse;
    endif;
    if (srchsign = set0003.set_signm);
      //  ... negativen Wert erzeugen
      srchargval = srchargval * -1;
      srchargfloat = srchargfloat * -1;
    else;
    //  ... positiven Wert belassen
    endif;
  else;
    srchargval = 0;
    srchargfloat = 0;
  endif;

  //  Ermitteln des Startdatensatzes
  exsr srchstrrcd;

  //  Suchen ...
  exsr srchup;

endsr;

//============================================================*
//    SrchCont      Fortsetzen der Suche nach "gefunden"      *
//============================================================*

begsr srchcont;

  //  Ermitteln der Feldattribute
  exsr srchFldAtr;

  //  Ermitteln des Startdatensatzes
  exsr srchstrrcd;

  //  Suchen ...
  exsr srchup;

endsr;

//============================================================*
//    SrchContM     Fortsetzen der Suche nach "MAXIMUM"       *
//============================================================*

begsr srchcontm;

  //  Ermitteln der Feldattribute
  exsr srchFldAtr;

  //  Suchen ...
  exsr srchup;

endsr;

//============================================================*
//    SrchEOF       Fortsetzen der Suche nach Dateiende       *
//============================================================*

begsr srcheof;

  //  Ermitteln der Feldattribute
  exsr srchFldAtr;

  //  Ermitteln des Startdatensatzes
  exsr pbmovetop;

  //  Suchen ...
  exsr srchup;

endsr;

//============================================================*
//    SrchStrRcd    Positionieren auf Startdatensatz          *
//============================================================*

begsr srchstrrcd;

  //---------------------------------------*
  //  Cursor im Subfilebereich ...
  //---------------------------------------*
  if sflCsr <> 0
     and sflCsr > nbrPinRcd;

    //  ... übersetzen in Satznummer
    exsr pbCsrToRcd;
    //  ... Fortsetzen der Suche
    if (wrk#rcdnbr = srchfndrcd);
      exsr pbreadcsra;
    else;
      //  ... oder neu anfangen
      exsr pbreadcsr;
    endif;
  else;

    //---------------------------------------*
    //  Cursor nicht im Subfilebereich ...   *
    //---------------------------------------*
    x = sflfirstrw + nbrPinRcd;
    if (cursorposition.row < x);
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
  f_key.f_field = srchfield;
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

begsr srchup;

  //  Suche läuft ...
  p_sndstsmg('USR8127': ' ');

  srchcount = 0;
  srchcount2 = 0;

  for do_x3 = 1 to *hival;
    exsr pbread;
    if (iseof = bTrue);
      srchmode = '*EOF';
      leave;
    endif;

    srchcount = srchcount + 1;
    if (srchcount >= srchnbrs);
      srchmode = '*MAXIMUM';
      leave;
    endif;

    exsr srchCompare;
    if (isfound = bTrue);
      srchmode = '*FOUND';
      //  ... suchen & pinnen
      if (srchtype = '*PINROW');
        wrk#rcdnbr = file#x.rcdnbr;
        exsr pinrecord;
        if (ispinok = bFalse);
          leave;
        else;
        //        weiter suchen und pinnen
        endif;
      else;
        //  ... sonstige Suchfunktionen
        leave;
      endif;
    endif;

    srchcount2 = srchcount2 + 1;
    if (srchcount2 >= srchdspmsg);
      srchcount2 = 0;

      clear usr8128;
      usr8128.var1 = srchcount;
      usr8128.var2 = srchnbrs;
      p_sndstsmg('USR8128': usr8128);
    endif;

  endfor;

  //  Statuszeile löschen ...
  p_sndstsmg('USR9999': ' ');

endsr;

//============================================================*
//    SrchComp      Vergleichen der Suchauswahl               *
//============================================================*

begsr srchCompare;

  isfound = bFalse;

  //  Im ganzen Datensatz suchen ...
  if (srchfield = '*RECORD');
    srchcmprcd = io_buff;
  else;
    exsr srchgetcmp;
  endif;

  //  Im ganzen Datensatz suchen ...
  if (srchfield = '*RECORD');
    exsr srchcomp_r;
  else;
    //  Im Datenfeld suchen ...
    exsr srchcomp_f;
  endif;

endsr;

//============================================================*
//    SrchGetCmp    Dateninhalt aus Datensatz extrahieren     *
//                  für Vergleich der Suchfunktion            *
//============================================================*

begsr srchgetcmp;

  if (srchisnum = bTrue);
    f_rtvfld(ybuffer  :
            io_buff  :
            fldl0100 :
            bTrue    );

    ytgtvalue  = ' ';

    if (srchargisfloat = bTrue);
      peek18(fldl0100: 'FLDL0100': ybuffer:
            '*FLOAT': '': youtbuffer: youtbuffln
            : yMsgID: yMsgDta);

      srchcmpfloat = %float(youtbuffer);
      srchcmpval   = 0;
    else;
      peek18(fldl0100: 'FLDL0100': ybuffer:
            '*ZONED': '': youtbuffer: youtbuffln
            : yMsgID: yMsgDta);

      srchcmpstr =
       %subst(youtbuffer
              : youtbuffln - %len(srchcmpstr) + 1
              : youtbuffln);
      srchcmpval = %dec(srchcmpstr
                       : srch_cmp_val_length
                       : srch_cmp_val_decpos);
      srchcmpfloat = 0;
    endif;

  else;
    f_rtvfld(srchcmpstr:
            io_buff   :
            fldl0100  );
  endif;

endsr;

//============================================================*
//    SrchComp_R    Suchen im Datensatz                       *
//============================================================*

begsr srchcomp_r;

  //  Nicht Case-Sensitive suchen ...
  if (srchcase = bFalse);
    srchcmprcd = %xlate(C_LOWER: C_UPPER: srchcmprcd);
  //  Case-Sensitive suchen ...
  endif;

  x = %checkr(' ': srcharg);
  if (x <> 0);
    x = %scan(%subst(srcharg: 1: x): SrchCmpRcd: 1);
  else;
    x = %scan(srcharg: SrchCmpRcd: 1);
  endif;

  //  Gleich ...
  if (srchop = 'LIKE');
    //  ... nicht gefunden
    if (x = 0);
      isfound = bFalse;
    else;
      //  ... gefunden
      isfound = bTrue;
    endif;
  else;
    //  UnGleich ...
    //  ... nicht gefunden
    if (x = 0);
      isfound = bTrue;
    else;
      //  ... gefunden
      isfound = bFalse;
    endif;
  endif;

endsr;

//============================================================*
//    SrchComp_F    Suchen im Feld                            *
//============================================================*

begsr srchcomp_f;

  //  Nicht Case-Sensitive suchen ...
  //  (nur bei nicht numerischer Suche beachten)
  if (srchcase = bFalse and srchisnum = bFalse);
    srchcmpstr = %xlate(C_LOWER: C_UPPER: srchcmpstr);
  //  Case-Sensitive suchen ...
  endif;

  //-----------------------*
  //  Vergleichen ...      *
  //-----------------------*
  select;
  //  Gleich ...
  when (srchop = 'EQ');
    if (srchisnum = bFalse);
      if (srchcmpstr = srcharg);
        isfound = bTrue;
      endif;
    else;
      if (srchargisfloat = bFalse and
         srchcmpval = srchargval) or
         (srchargisfloat = bTrue  and
         srchcmpfloat = srchargfloat);
        isfound = bTrue;
      endif;
    endif;
  //  UnGleich ...
  when (srchop = 'NE');
    if (srchisnum = bFalse);
      if (srchcmpstr <> srcharg);
        isfound = bTrue;
      endif;
    else;
      if (srchargisfloat = bFalse and
         srchcmpval <> srchargval) or
         (srchargisfloat = bTrue  and
         srchcmpfloat <> srchargfloat);
        isfound = bTrue;
      endif;
    endif;
  //  Größer ...
  when (srchop = 'GT');
    if (srchisnum = bFalse);
      if (srchcmpstr > srcharg);
        isfound = bTrue;
      endif;
    else;
      if (srchargisfloat = bFalse and
         srchcmpval > srchargval) or
         (srchargisfloat = bTrue  and
         srchcmpfloat > srchargfloat);
        isfound = bTrue;
      endif;
    endif;
  //  Kleiner ...
  when (srchop = 'LT');
    if (srchisnum = bFalse);
      if (srchcmpstr < srcharg);
        isfound = bTrue;
      endif;
    else;
      if (srchargisfloat = bFalse and
         srchcmpval < srchargval) or
         (srchargisfloat = bTrue  and
         srchcmpfloat < srchargfloat);
        isfound = bTrue;
      endif;
    endif;
  //  Größer/Gleich ...
  when (srchop = 'GE');
    if (srchisnum = bFalse);
      if (srchcmpstr >= srcharg);
        isfound = bTrue;
      endif;
    else;
      if (srchargisfloat = bFalse and
         srchcmpval >= srchargval) or
         (srchargisfloat = bTrue  and
         srchcmpfloat >= srchargfloat);
        isfound = bTrue;
      endif;
    endif;
  //  Kleiner/Gleich ...
  when (srchop = 'LE');
    if (srchisnum = bFalse);
      if (srchcmpstr <= srcharg);
        isfound = bTrue;
      endif;
    else;
      if (srchargisfloat = bFalse and
         srchcmpval <= srchargval) or
         (srchargisfloat = bTrue  and
         srchcmpfloat <= srchargfloat);
        isfound = bTrue;
      endif;
    endif;
  //  Ähnlich ...
  when srchop = 'LIKE'
     or srchop = 'NLIKE';

    select;
    //  ...   ('%ABCD')
    when (srchliketp = 1);
      x = %checkr(' ': srchcmpstr);
      x = x - srchlikeln;
      x = x + 1;
      if (x > 0);
        srchcmpstr= %subst(srchcmpstr: x: srchlikeln);
        if (srchcmpstr = srcharg);
          isfound = bTrue;
        endif;
      endif;

    //  ...   ('ABCD%')
    when (srchliketp = 2);
      srchcmpstr= %subst(srchcmpstr: 1: srchlikeln);
      if (srchcmpstr = srcharg);
        isfound = bTrue;
      endif;

    //  ...   ('%ABCD%')
    other;
      x = srchlikeln;
      x = %scan(%subst(srcharg: 1: x): srchcmpstr: 1);
      if (x > 0);
        isfound = bTrue;
      endif;

    endsl;

    //  ... auswerten IsFound für LIKE/NLIKE
    if (srchop = 'LIKE');
    //        ... IsFound ist bereits richtig gesetzt.
    else;
      //        ... IsFound muß negiert werden ...
      if (isfound = bTrue);
        isfound = bFalse;
      else;
        isfound = bTrue;
      endif;
    endif;

  other;
  endsl;

endsr;

//============================================================*
//    SrchInz       Initialisieren der Suchfunktion           *
//============================================================*

begsr srchinz;

  srchmode = '*NEW';
  srchfndrcd = 0;

  srchfield = *blanks;
  srchop = *blanks;
  srcharg = *blanks;
  srchsign = *blanks;
  srchnbrs = 0;
  srchtype = *blanks;

  srchcmpstr = *blanks;
  srchcount = 0;

  srchcount = 0;
  srchcount2 = 0;
  srchdspmsg = 1000;

endsr;

//============================================================*
//    CallUpdPgm    Aufrufen Updateprogramm für F6, 2, 3      *
//============================================================*

begsr callUpdPgm;

  isTryed = bFalse;

  dou *in99 = *off;

    exsr getPgmName;
    exsr getDspName;


    if (yFunction = '*ADD');
      yRcdNbr = 0;
    else;
      yRcdNbr = wrk#rcdnbr;
    endif;

    if (not f_exist(peekDspF: '*LIBL': '*FILE'));
      *in99 = bTrue;
    else;
      monitor;
        UPDPGM_NAME = f_pgmcalln(peekPgm);
        yHeaderType = set0001.set_hedtyp;
        UPDPGM(set0001.set_dsp80
               : yHeaderType
               : COPYRIGHT
               : yRcdNbr
               : file#x.file
               : file#x.library
               : file#x.member
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
          p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
          yMsgID = '';
          yMsgDta = '';
        else;
          isSflDirty = bTrue;
          if (set0001.set_hedtyp <> yHeaderType);
            set0001.set_hedtyp = yHeaderType;
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
        exsr c_buildpgm;
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
//    ReloadUsrStg  Aktualisieren Benutzereinstellungen       *
//============================================================*

begsr reloadusrstg;

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
  set0005 = f_getusrsg('*SPLASH'   );

endsr;

//============================================================*
//    PBInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr pbInit;

  //  Merker für: Subfile gelöscht setzen
  ispbinit = bTrue;

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

  sflrec132 = 0;
  sflrec080 = 0;

  sflnbrrcd = 0;

  ##rcdnbr = 0;
  ##key = '';

  $$head132 = set0001.set_hedcol;
  $$head080 = set0001.set_hedcol;

  //  Aufbereiten der Überschrift
  exsr pbHeadline;

  //  Logischer Schalter für Tabellierung
  istblcol = bFalse;

  //  Konvertieren nicht darstellbarer Zeichen
  iscvtchar = bFalse;

endsr;

//============================================================*
//    PBCsrTRcd     Übersetzen SflCsr ==> rel. Satznummer     *
//============================================================*

begsr pbCsrToRcd;

  if (sflCsr <= 0);
    wrk#rcdnbr = 0;
  else;
    if (*in88 = *off);
      sflrec132 = sflCsr;
      chain sflrec132 pbsfl132;
    else;
      sflrec080 = sflCsr;
      chain sflrec080 pbsfl080;
    endif;

    if (not %found());
      wrk#rcdnbr = 0;
    else;
      wrk#rcdnbr = recordnbr;
    endif;
  endif;

endsr;

//============================================================*
//    InitSCmd      Initialisieren Kurzbefehl                 *
//============================================================*

begsr initscmd;

  clear shortcmd;
  shortcmd.sc_action = '*INIT';
  shortcmd.sc_file = ##file;
  shortcmd.sc_lib = ##library;
  shortcmd.sc_mbr = ##member;
  peek42(h_file: h_lib: h_mbr: h_rcdfmt
        : shortcmd: wrk#rcdnbr: yexeccmd
        : yMsgID: yMsgDta);

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr pbReadUp;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    //  Erster Datensatz in Subfile ...
    isfirstsfl = bTrue;

    for do_x4 = 1 to *hival;
      exsr pbread;
      if (iseof = bTrue);
        *in83 = '1';
        leave;
      else;
        *in83 = '0';
      endif;

      if (*in88 = bFalse);
        sflrec132 = sflrec132 + 1;
      else;
        sflrec080 = sflrec080 + 1;
      endif;

      if sflrec132 > 9999
         or sflrec080 > 9999;
        *in83 = '1';
        exsr pbreadp;
        leave;
      endif;

      if sflrec132 > sflpage
         or sflrec080 > sflpage;
        exsr pbreadp;
        leave;
      endif;

      exsr pbFillDataRow_Right;

      exsr pbsflwrite;

      if (*in88 = bFalse);
        sflnbrrcd = sflrec132;
      else;
        sflnbrrcd = sflrec080;
      endif;

      //  Setzen Cursor auf gefundenen Datensatz
      if (srchfndrcd = recordnbr);
        if (*in88 = bFalse);
          sfsanr = sflrec132;
        else;
          sfsanr = sflrec080;
        endif;
      endif;

      //  Aufbereiten Aufsetzkey bei 1. geschriebendem Datensatz
      if (isfirstsfl = bTrue);
        exsr pbgenkey;
      endif;

      //  Tabellierpapierfarben umschalten ...
      if (set0001.set_tblmde = bFalse);
      //         Modus ist ausgeschaltet
      else;
        if (istblcol = bFalse);
          istblcol = bTrue;
        else;
          istblcol = bFalse;
        endif;
      endif;

      //  ... 1. Datensatz ist fertig
      isfirstsfl = bFalse;

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

    wrk#readdn = wrk#readdn + sflpage;
    wrk#readdn = wrk#readdn - nbrPinRcd;

    for do_x5 = 1 to wrk#readdn;
      exsr pbreadp;
      if (iseof = bTrue);
        leave;
      endif;

    endfor;

  endif;

  wrk#readdn = 0;

endsr;

//============================================================*
//    PBReadCsr     Setzen Dateizeiger auf aktuelle           *
//                  Cursor-Position  (SflCsr)                 *
//============================================================*

begsr pbreadcsr;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;
    if (sflCsr = 0);
    //      Nix tun, keine Datei vorhanden
    else;

      wrk#readdn = sflnbrrcd - sflCsr;
      wrk#readdn = wrk#readdn + 1;
      exsr pbmovecsrd;

    endif;
  endif;

endsr;

//============================================================*
//    PBReadCsrA    Read to Cursor, after                     *
//                  Setzen Dateizeiger auf aktuelle           *
//                  Cursor-Position  +1  (SflCsr+1)           *
//============================================================*

begsr pbreadcsra;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;
    if (sflCsr = 0);
    //      Nix tun, keine Datei vorhanden
    else;

      wrk#readdn = sflnbrrcd - sflCsr;
      exsr pbmovecsrd;

    endif;
  endif;

endsr;

//============================================================*
//    PBMoveCsrD    Verschieben Dateizeiger (Richtung BOF)    *
//============================================================*

begsr pbmovecsrd;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    for do_x6 = 1 to wrk#readdn;
      exsr pbreadp;
      if (iseof = bTrue);
        leave;
      endif;

    endfor;

  endif;

  wrk#readdn = 0;

endsr;

//============================================================*
//    PBPinCol      Füllen Subfile mit pinned Spalten         *
//============================================================*

begsr pbPinColumn;

  isPinModeC = bTrue;

  //  Eintragen der gepinnten Spalten ...
  for pincol_x = 1 to nbrPinCol;
    if (sflRowDataStr > sfl_row_size or sflRowDataStr > sflMaxRowLen);
      leave;
    endif;

    if (sflRowDataStr > sflpinrnge);
      p_sndpgmmg('USR8148' : pinTabCol(pincol_x): sds.pgmname);
      exsr rmvPincolumn;
      if (ispinrmv = bTrue);
        pincol_x = pincol_x - 1;
      endif;
      iter;
    endif;

    //  ... einlesen der Felddaten
    clear f_key;
    f_key.f_field = pinTabCol(pincol_x);
    chain(n) %kds(f_key) fpeekfld;
    if (not %found());
      // Eintrag austragen
      exsr rmvPincolumn;
      if (ispinrmv = bTrue);
        pincol_x = pincol_x - 1;
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

  ispinmoder = bTrue;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    for pinrcd_x = 1 to max_pin_rcd;
      pinTabRcdE = pinTabRcd(pinrcd_x);
      if (pinTabRcdE.rcdnbr = 0);
        leave;
      endif;

      if f_chain04(pinTabRcdE.rcdnbr :
                pinTabRcdE.file   :
                pinTabRcdE.lib    :
                pinTabRcdE.mbr    :
                pinTabRcdE.rcdfmt ) = '1';
        //           Eintrag austragen
        exsr rmvpinrcd;
        if (ispinrmv = bTrue);
          pinrcd_x = pinrcd_x - 1;
        endif;
        iter;
      endif;

      exsr pbFillDataRow_Right;

      sflrec132 = sflrec132 + 1;
      sflrec080 = sflrec080 + 1;

      exsr pbsflwrite;

      if (*in88 = bFalse);
        sflnbrrcd = sflrec132;
      else;
        sflnbrrcd = sflrec080;
      endif;

    endfor;

  endif;

  ispinmoder = bFalse;

endsr;

//============================================================*
//    ChkPinRcd     Prüfen, ob Datensatz gepinned ist         *
//============================================================*

begsr chkpinrcd;

  pinrcd_x = 1;
  pinTabRcdE.rcdnbr = wrk#rcdnbr;
  pinTabRcdE.file = h_file;
  pinTabRcdE.lib = h_lib;
  pinTabRcdE.mbr = h_mbr;
  pinTabRcdE.rcdfmt = h_rcdfmt;
  pinTabRcdE.mbrnbr = h_mbrnbr;
  pinrcd_x = %lookup(
           pinTabRcdE: pinTabRcd: pinrcd_x);
  if (pinrcd_x > 0);
    ispinned = bTrue;
  else;
    ispinned = bFalse;
  endif;

endsr;

//============================================================*
//    ChkPinCol     Prüfen, ob Spalte gepinned ist            *
//============================================================*

begsr chkpincol;

  pincol_x = 1;
  pincol_x = %lookup(
           pin#field: pinTabCol: pincol_x);
  if (pincol_x > 0);
    ispinned = bTrue;
  else;
    ispinned = bFalse;
  endif;

endsr;

//============================================================*
//    RmvPinRcd     Austragen Datensatz aus PinTabR           *
//============================================================*

begsr rmvpinrcd;

  ispinrmv = bFalse;

  //  Remove pinned record from table
  for y = pinrcd_x to max_pin_rcd;
    z = y + 1;
    clear pinTabRcdE;
    if (z <= max_pin_rcd);
      pinTabRcd(y) = pinTabRcd(z);
      pinTabRcd(z) = pinTabRcdE;
    else;
      pinTabRcd(y) = pinTabRcdE;
    endif;
    isSflDirty = bTrue;
    ispinrmv = bTrue;
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

  ispinrmv = bFalse;

  for y = pincol_x to max_pin_col;
    z = y + 1;
    if (z <= max_pin_col);
      pinTabCol(y) = pinTabCol(z);
      pinTabCol(z) = *blanks;
    else;
      pinTabCol(y) = *blanks;
    endif;
    isSflDirty = bTrue;
    ispinrmv = bTrue;
  endfor;

  x = 1;
  pin#field = *blanks;
  x = %lookup(pin#field: pinTabCol: x);
  if (x > 0);
    nbrPinCol = x - 1;
  else;
    nbrPinCol = max_pin_col;
  endif;

endsr;

//============================================================*
//    PBRefresh     Aktualisieren der Subfile                 *
//============================================================*

begsr pbrefresh;

  wrk#readdn = sflnbrrcd - sflpage;
  exsr pbReadDown;
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

  if (not %open(peekfldl1));
    //  Keine Datei geöffnet
    leavesr;
  endif;

  //  Löschen Tabelle mit Feldpositionen ...
  exsr clrFldPosArray;

  //  Aufbereiten Pseudo-Datensatz
  peek20('*PHIVAL': io_buff: yMsgID: yMsgDta);

  if (yMsgID = '');

    //  Füllen der Überschriftenzeile ...
    sflmode = '*HEADLINE';
    wrk#seqnbr = ##wndnbr;
    exsr pbFillHeadline_Right;

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

begsr pbFillDataRow_Left;

  if (isOpen = bFalse);
  //  Keine Datei geöffnet
  else;

    //  Löschen Tabelle mit Feldpositionen ...
    exsr clrFldPosArray;

    //  Aufbereiten Pseudo-Datensatz
    peek20('*PHIVAL': io_buff: yMsgID: yMsgDta);

    if (yMsgID = '');

      //  Füllen der Überschriftenzeile ...
      sflmode = '*HEADLINE';
      wrk#seqnbr = ##wndnbr;
      exsr pbFillHeadline_Left;
    endif;
  endif;

endsr;

//============================================================*
//    PBFillRigh    Füllen einer Datenzeile von rechts        *
//                  nach links.                               *
//============================================================*

begsr pbFillDataRow_Right;

  f_basedpf(file#x.file   :
           file#x.library:
           file#x.member :
           file#x.rcdfmt :
           file#x.mbrnbr :
           h_file        :
           h_lib         :
           h_mbr         :
           h_rcdfmt      );

  sfpau = *blanks;
  h_mbrnbr = file#x.mbrnbr;
  recordnbr = file#x.rcdnbr;

  //  Prüfen auf Suchfunktion:
  //  *NORMAL/*REVERSE
  isfound = bFalse;

  if (srchfield <> *blanks);
    if (srchtype = '*REVERSE' or srchtype = '*UNDERLINE');
      exsr srchFldAtr;
      exsr srchCompare;
    endif;
  endif;

  //  Füllen der Datenzeile ...
  sflmode = '*DATA';
  wrk#seqnbr = ##wndnbr;
  exsr pbFillHeadline_Right;

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
  f1key_l1.f_seq = wrk#seqnbr;
  setll %kds(f1key_l1) fpeekfldl1;

  dow (sflRowDataStr <= sfl_row_size and sflRowDataStr <= sflMaxRowLen);
    read fpeekfldl1;
    if (%eof());
      leave;
    endif;

    //  ... Feld anzeigen?
    wrk#field = f_field;
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

begsr pbFillHeadline_Left;

  //  Löschen Datentabelle ...
  clear sflDataRow;
  sflRowDataStr = 1;

  //  Eintragen gepinnter Spalten ...
  exsr pbPinColumn;

  //  Eintragen der Feldinhalte ...
  clear f1key_l1;
  f1key_l1.f_seq = wrk#seqnbr;
  setgt %kds(f1key_l1) fpeekfldl1;

  dow (sflRowDataStr <= sfl_row_size and
     sflRowDataStr <= sflMaxRowLen);
    readp fpeekfldl1;
    if (%eof());
      leave;
    endif;

    //  ... Feld anzeigen?
    wrk#field = f_field;
    exsr chkVisible;
    if (isVisible = bFalse);
      iter;
    endif;

    exsr pbReadFld1;
    if (isError = bTrue);
      leave;
    endif;

    if (##strpage > 1);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PBReadFld1    Hilfsroutine für PBReadFld                *
//============================================================*

begsr pbReadFld1;

  //  umsetzen der Daten in die Job CCSID
  if (sflmode = '*HEADLINE');
    ycvtccsid = bFalse;
  else;
    ycvtccsid = bTrue;
  endif;

  //  löschen Ausnahmebedingung für Spalte
  isColumnException = bFalse;

  //  merken Position für Farbattribut
  if (sflRowDataStr <= sfl_row_size);
    colrofs = sflRowDataStr;
    sflRowDataStr = sflRowDataStr + 1;
  else;
    colrofs = 0;
  endif;

  //  aufbereiten des Feldinhaltes
  //  für Anzeigeformat gemäß EDITCODE ...
  fldl0100 = f_ffd;
  if (f_edtcde <> *blanks);
    fldl0100.f1edtc = f_edtcde;
  else;
  //  ... Original EDITCODE verwenden
  endif;

  monitor;
    //  umsetzen Datensatzpuffer in Bildschirmdarstellung ...
    if (set0001.set_dspmde = '*DSPNRM');
      //  ... für Normale Anzeige
      if (io_nullmap(fldl0100.f1seq) = 1);
        peek06(fldl0100: 'FLDL0100': *allx'00'
              : bFalse: ycvtccsid
              : youtbuffer: youtbuffln
              : yMsgID: yMsgDta);
        if (f_isnumfld(fldl0100) = bTrue);
          if (youtbuffln > 1);
            %subst(youtbuffer: 1: youtbuffln - 1) = '';
          endif;
          %subst(youtbuffer
                : youtbuffln
                : %len(HEX_CHAR)) = HEX_CHAR;
        else;
          youtbuffer = HEX_CHAR;
        endif;
      else;
        peek06(fldl0100: 'FLDL0100': io_buff
              : bFalse: ycvtccsid
              : youtbuffer: youtbuffln
              : yMsgID: yMsgDta);
      endif;

    else;
      //  ... für Hex-Anzeige
      if (io_nullmap(fldl0100.f1seq) = 1);
        yhexstring = HEX_CHAR;
        ystringlen = f_buffln(fldl0100);
      else;
        ystringlen = f_rtvfld(ystring  :
                             io_buff  :
                             fldl0100 );
        yhexstring = ' ';
        p_hextochr(yhexstring    :
                  ystring       :
                  ystringlen * 2);
      endif;

      youtbuffln = ystringlen * 2;
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
    columnlen = 0;
    fieldlen = youtbuffln;
    maxcollen = f_maxsize;

    //  Konvertierung nicht darstellbarer Zeichen ...
    if (sflmode = '*HEADLINE' or set0001.set_dspmde = '*DSPHEX');
    //  ... keine Konvertierung bei der
    //      Aufbereitung der Überschriftenzeile
    else;
      //  ... sonst konvertieren
      monitor;
        peek32(youtbuffer: youtbuffln: 0
              : yMsgID: yMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;

      if (*in99 = *off);
        if (iscvtchar = bFalse);
          if (yMsgID <> *blanks);
            iscvtchar = bTrue;
            p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
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
    colheading = f_headline(set0001.set_hedtyp: fldl0100);
    headlen = %checkr(' ': colheading);

    if (sflmode = '*HEADLINE');
      yhexstring = colheading;
    endif;

    colheading = '';

    //  ... Bestimmen der Spaltenbreite
    if (headlen > fieldlen);
      columnlen = headlen;
    else;
      columnlen = fieldlen;
    endif;

    if (columnlen > maxcollen);
      columnlen = maxcollen;
    endif;

    //  ... numerische Werte rechtsbündig setzen,
    //      wenn Spaltenbereite kleiner als Feldlänge
    if (sflmode   = '*HEADLINE');

      //      ... für die Überschrift
      if (columnlen < headlen ) or
         (columnlen < fieldlen);

        select;
        when (headlen + 3) <= columnlen;
          %subst(yhexstring: headlen + 1: 3)
          = %subst('...': 1: 3);
        other;
          %subst(yhexstring: columnlen - 2 + 1: 2)
          = %subst('...': 1: 2);
        endsl;

      endif;

    else;

      //      ... für die Datenzeile
      if (sflmode   <> '*HEADLINE') and
         (columnlen <  fieldlen   );
        if (f_isnumfld(fldl0100) = bTrue);
          //          ... numerische Werte
          if (set0001.set_enexc = bTrue) and
             (%subst(yhexstring          :
                  1                   :
                  fieldlen - columnlen) <> *blanks);
            isColumnException = bTrue;
          endif;
          yhexstring = %subst(yhexstring              :
                             1 + fieldlen - columnlen:
                             columnlen               );
        else;
          //          ... alphanumerische Werte
          if (set0001.set_enexc = bTrue) and
             (%subst(yhexstring              :
                  columnlen + 1           :
                  1 + fieldlen - columnlen) <> *blanks);
            isColumnException = bTrue;
          endif;
        endif;

      endif;
    endif;

    //  ... Berechnen der Startposition im Puffer
    sfldatalenfree =
     sflMaxRowLen - sflRowDataStr + 1;

    if (##wndnbr = f_seq);

      if (##strpage * sfldatalenfree) > columnlen;

        if (columnlen / sfldatalenfree) =
           f_int(columnlen / sfldatalenfree);
          ##strpage = (columnlen / sfldatalenfree);
        else;
          ##strpage = (columnlen / sfldatalenfree) + 1;
        endif;

      endif;

      fldstrpos = (##strpage -1) * sfldatalenfree
                 + 1;
    else;
      fldstrpos = 1;
    endif;

    //  ... Berechnen der zu extrahierenden Länge
    buffidx = fldstrpos;
    sflrowdataend = sflRowDataStr + columnlen;
    sflrowdataend = sflrowdataend - fldstrpos;

    if (sflrowdataend > sfl_row_size);
      sflrowdataend = sfl_row_size;
    endif;

    sflrowdatalen =
     sflrowdataend - sflRowDataStr + 1;

    //  ... übertragen aufbereitetes Feld in Subfile
    %subst(sflDataRow: sflRowDataStr) =
    %subst(yhexstring: buffidx: sflrowdatalen);

    //  ... pflegen der Tabelle mit den Werten der
    //      Spaltenaufteilung ...
    if (sflrowdataend >= sflRowDataStr);
      //      ... pflegen der Feldpositionstabelle
      if (sflmode = '*HEADLINE');
        cp = cp + 1;
        col_field(cp) = fldl0100.f1fnme;
        col_scnstr(cp) = sflRowDataStr;
        col_scnend(cp) = sflrowdataend;
        //          ... ist das Feld komplett sichtbar?
        if (col_scnend(cp) <= sflMaxRowLen);
          //              ... ja, kein Fehler
          col_error(cp) = bFalse;
        else;
          //              ... nein, Fehler!
          col_error(cp) = bTrue;
        endif;
      endif;

      sflRowDataStr = sflrowdataend + 1;

      //      ... Löschen von "überstehendem" Datenmüll
      if (columnlen = maxcollen and
         sflRowDataStr <= sfl_row_size);
        sflDataRow.chars(sflRowDataStr) = '';
      endif;

      //      ... umschalten auf "normale" Farbdarstellung
      if (sflRowDataStr <= sfl_row_size);
        wrk#ofs = sflRowDataStr;
        exsr pbstdcol;
      endif;

      //      ... "nachziehen" der Spaltenfarbe
      if (colrofs <= 0);
      //          ... Pech gehabt
      else;
        if (sflmode = '*HEADLINE');
          if (f_kseq = 0) or
             (accessMode = RRN_SEQ);
            sflDataRow.chars(colrofs) = set0001.set_hedcol;
          else;
            sflDataRow.chars(colrofs) = set0001.set_keycol;
          endif;
        else;
          exsr pbcolor;
        endif;
      endif;
    endif;

  endif;

endsr;

//============================================================*
//    PBStdCol      Setzen der "normalen" Datensatzfarbe      *
//============================================================*

begsr pbstdcol;

  if (istblcol = bFalse);
    sflDataRow.chars(wrk#ofs) = set0001.set_stdcol;
  else;
    sflDataRow.chars(wrk#ofs) = set0001.set_tblcol;
  endif;

endsr;

//============================================================*
//    PBGenKey      Generieren Aufsetzkey                     *
//                  für die Anzeige auf dem Bildschirm        *
//============================================================*

begsr pbgenkey;

  if (accessMode = KEY_SEQ);
    exsr pbbuildkey;
  else;
    exsr pbbuildrrn;
  endif;

endsr;

//============================================================*
//    PBBuildRrn    Generieren Aufsetzkey: RRN                *
//============================================================*

begsr pbbuildrrn;

  ##rcdnbr = recordnbr;

endsr;

//============================================================*
//    PBBuildKey    Generieren Aufsetzkey                     *
//============================================================*

begsr pbbuildkey;

  monitor;
    peek19(io_buff: ykeyval: yMsgID: yMsgDta);

    //  ... Konvertieren nicht darstellbarer Zeichen
    youtbuffer = ykeyval;
    youtbuffln = 132;

    peek32(youtbuffer: youtbuffln: 0
          : yMsgID: yMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  ##key = youtbuffer;

endsr;

//============================================================*
//    PBGenIntKy    Generieren internen Aufsetzkey            *
//                  für einen Dateizugriff                    *
//============================================================*

begsr pbgenintky;

  if (accessMode = KEY_SEQ);
    exsr pbintkey;
  else;
    exsr pbintrrn;
  endif;

endsr;

//============================================================*
//    PBIntRrn      Generieren interne Satznummer             *
//============================================================*

begsr pbintrrn;

  wrk#rcdnbr = wrk#rcdnbr;

endsr;

//============================================================*
//    PBIntKey      Generieren internen Aufsetzschlüssel      *
//============================================================*

begsr pbintkey;

  peek20(wrk#keyval: ybuffer
        : yMsgID: yMsgDta);
  wrk#keyval = ybuffer;

endsr;

//============================================================*
//    PBColor       Setzen der Spaltenfarbe                   *
//                  für Datenzeilen                           *
//                  a) für gepinnte Datensätze                *
//                  b) für normale Datensätze                 *
//============================================================*

begsr pbcolor;

  if (colrofs = 0);
  //                 Nix tun
  else;

    if (isColumnException = bTrue);
      sflDataRow.chars(colrofs) = set0001.set_exccol;
    else;

      //---------------------------------------*
      //  Berücksichtigen des Aufrufs von:     *
      //  a) anzeigen "normaler" Datensätze    *
      //  b) anzeigen "gepinnter" Datensätze   *
      //---------------------------------------*
      if (ispinmoder = bFalse);
        if (isPinModeC = bFalse);
          //      ... nix ist gepinnt
          ispinned = bFalse;
        else;
          //      ... prüfen auf gepinnte Spalten
          pin#field = fldl0100.f1fnme;
          exsr chkpincol;
        endif;
      else;
        //      ... prüfen auf gepinnte Zeilen (=Datensätze)
        wrk#rcdnbr = recordnbr;
        exsr chkpinrcd;
      endif;

      //---------------------------------------*
      //  ... setzen der Datenfarbe            *
      //---------------------------------------*
      //  Spaltenmarkierung ...
      if (f_markcol = bTrue);
        sflDataRow.chars(colrofs) = f_color;
      else;
        //  Keine Spaltenmarkierung ...
        if (ispinned = bTrue);
          //      ... pinned Datensatz
          sflDataRow.chars(colrofs) = set0001.set_pincol;
        else;
          //      ... normaler Datensatz
          wrk#ofs = colrofs;
          exsr pbstdcol;
        endif;
      endif;

      //---------------------------------------*
      //  ... Datensatz gefunden               *
      //---------------------------------------*
      if (ispinned = bFalse);
        select;
        //      ... Suchfunktionen: *REVERSE
        when (srchtype = '*REVERSE');
          if (isfound = bTrue);
            sflDataRow.chars(colrofs) = set0001.set_revcol;
          endif;

        //      ... Suchfunktionen: *UNDERLINE
        when (srchtype = '*UNDERLINE');
          if (isfound = bTrue);
            sflDataRow.chars(colrofs) = set0001.set_undcol;
          endif;

        //      ... Suchfunktionen: *NORMAL
        when (srchtype = '*NORMAL');
          if (srchfndrcd = recordnbr);
            sflDataRow.chars(colrofs) = set0001.set_nmlcol;
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

begsr pbsetll;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    select;
    when (accessMode = KEY_SEQ);
      cio_setllwithkey(hfile02: wrk#keyval);
      exsr f2tofx;
    when (accessMode = RRN_SEQ);
      cio_setllwithrrn(hfile01: wrk#rcdnbr);
      exsr f1tofx;
    when (accessMode = SQL_SEQ);
    other;
    endsl;

  endif;

endsr;

//============================================================*
//    PBSetGT       Setzen Dateizeiger RRN/KEY                *
//============================================================*

begsr pbsetgt;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    select;
    when (accessMode = KEY_SEQ);
      cio_setgtwithkey(hfile02: wrk#keyval);
      exsr f2tofx;
    when (accessMode = RRN_SEQ);
      cio_setgtwithrrn(hfile01: wrk#rcdnbr);
      exsr f1tofx;
    when (accessMode = SQL_SEQ);
    other;
    endsl;

  endif;

endsr;

//============================================================*
//    PBMoveTop     Setzen Dateizeiger auf BOF                *
//============================================================*

begsr pbmovetop;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    if (accessMode = SQL_SEQ);
      sql_gototop(yMsgID: yMsgDta);
      if (yMsgID <> '');
        p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
        yMsgID = '';
        yMsgDta = '';
      endif;
    else;
      wrk#keyval = '*LOVAL';
      wrk#rcdnbr = LOW_RCD_NBR;

      exsr pbgenintky;
      exsr pbsetll;
    endif;

  endif;

endsr;

//============================================================*
//    PBMoveBot     Setzen Dateizeiger auf EOF                *
//============================================================*

begsr pbmovebot;

  if (isOpen = bFalse);
  //      Nix tun, keine Datei vorhanden
  else;

    if (accessMode = SQL_SEQ);
      sql_gotobottom(yMsgID: yMsgDta);
      if (yMsgID <> '');
        p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
        yMsgID = '';
        yMsgDta = '';
      endif;
    else;
      wrk#keyval = '*HIVAL';
      wrk#rcdnbr = HIGH_RCD_NBR;

      exsr pbgenintky;
      exsr pbsetgt;
      exsr pbreadp;
    endif;

  endif;

endsr;

//============================================================*
//    clrFldArray   Löschen Felder Array                      *
//============================================================*

begsr clrFldPosArray;

  col_field(*) = '';
  col_scnstr(*) = 0;
  col_scnend(*) = 0;
  col_error(*) = bFalse;
  cp = 0;

endsr;

//============================================================*
//    ChangeFile    Prüfen, ob die Datei gewechselt hat       *
//============================================================*

begsr changeFile;

  isfilechg = bFalse;

  if l#file <> ##file
     or l#library <> ##library
     or l#member <> ##member
     or l#format <> ##format;

    isfilechg = bTrue;
    //  ... Änderungen prüfen
    if (##member = l#member);
      ##member = *blanks;
    endif;

    if (##format = l#format);
      ##format = *blanks;
    endif;

    exsr closefile;

    if (##file <> *blanks);
      accessMode = newAccessMode;
      exsr openfile;
    endif;
  endif;

  exsr getopnfile;
  exsr getmaxseq;

endsr;

//============================================================*
//    ChangeWnd     Prüfen, ob Fenster gewechselt hat         *
//============================================================*

begsr changewnd;

  if (isOpen = bFalse);
    //      Nix tun, keine Datei vorhanden
    exsr msgnofile;
  else;

    if (##field <> *blanks);
      wrk#field = ##field;
      exsr getseqnbr;
      if (isSeqNbrOK = bTrue);
        ##wndnbr = wrk#seqnbr;
        ##strpage = 1;
      else;
        //  Fehlermeldung ...
        clear usr8108;
        usr8108.var1 = ##field;
        usr8108.var2 = ##file;
        usr8108.var3 = ##library;
        p_sndpgmmg('USR8108': usr8108: sds.pgmname);
      endif;

      ##field = *blanks;
    endif;

  endif;

endsr;

//============================================================*
//    ChangeKey     Prüfen, ob der Aufsetzkey gewechselt hat  *
//                  Auslösen über *IN93                       *
//============================================================*

begsr changekey;

  if ##rcdnbr <> r#rcdnbr
     or ##key <> r#keyval;
    iskeychg = bTrue;
  else;
    iskeychg = bFalse;
  endif;

  select;
  when (##rcdnbr < LOW_RCD_NBR);
    ##rcdnbr = LOW_RCD_NBR;
  when (##rcdnbr > HIGH_RCD_NBR);
    ##rcdnbr = HIGH_RCD_NBR;
  other;
  //    Im gültigen Bereich ...
  endsl;

endsr;

//============================================================*
//    ChangeSort    Wechseln der Sortierfolge                 *
//============================================================*

begsr changesort;

  l#file = *blanks;
  l#library = *blanks;
  l#member = *blanks;
  l#format = *blanks;

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
  if (wrk#rcdnbr > *zeros);
    //**  File#04.Open  ANDEQ     '1'
    last#rcdnr = wrk#rcdnbr;
  else;
    last#rcdnr = *zeros;
  endif;

  //  Wechsel der Datei ...
  isPinToClr = bFalse;
  exsr changeFile;
  isPinToClr = bTrue;

  //  Prüfen Seq-Bereich (##WndNbr) ...
  exsr chkseqrnge;

  //  Wechsel des Fenster (##Field) ...
  exsr changewnd;

  clear ##rcdnbr;
  clear ##key;
  clear r#rcdnbr;
  clear r#keyval;

  yMsgID = *blanks;
  yMsgDta = *blanks;

  if (last#rcdnr = *zeros);
  //    Alter Datensatz ist nicht bekannt ...
  else;
    //    ... Einlesen letzten Datensatz
    recordnbr = last#rcdnr;

    if f_chain04(recordnbr:
              h_file   :
              h_lib    :
              h_mbr    :
              h_rcdfmt ) = '1';
    //    ... Zugriff fehlgeschlagen
    else;
      //    ... Generieren Aufsetzkey
      exsr pbgenkey;
    endif;
  endif;

  //  Wechsel des Aufsetzkeys ...
  exsr changekey;

  //  Füllen der Subfile ...
  if (iskeychg = bFalse);
    if (cursorposition.row > sfllastrw);
      //    ... unterhalb der Subfile
      exsr c_bot;
    else;
      //    ... oberhalb der Subfile,
      //        bzw. kein Wechsel des Aufsetzkeys
      exsr c_top;
    endif;
  else;
    //    ... neuer Aufsetzkey innerhalb der Subfile
    exsr keyhaschg;
  endif;

endsr;

//============================================================*
//    OpenFile      Datei öffnen                              *
//============================================================*

begsr openfile;

  //  Wenn eine Datei bereits geöffnet ist ...
  if (isOpen = bTrue);
    //  ... dann geöffnet lassen
    leavesr;
  endif;

  yCursorPosition.row = 0;
  yCursorPosition.column = 0;

  exsr chkprvfile;

  //  ... erst die Plausi prüfen, dann ...
  if (##library = *blanks);
    ##library = '*LIBL';
  endif;

  if (##member = *blanks);
    ##member = '*FIRST';
  endif;

  //  ... Objektbeschreibung
  //      ... abrufen der Objektattribute (auflösen *LIBL, *CURLIB)
  exsr getobjattr;
  if (isError = bTrue);
    //  Fehler aufgetreten, Öffnen abbrechen.
    exsr msgnofile;
    leavesr;
  endif;

  //  ... Teildateien
  if (##member = '*NONE');
    $$nomb = 0;
  else;
    //      ... abrufen der Anzahl Teildateien
    exsr getnbrmbr;
    if ($$nomb = 0);
      //  Keine Teildateien vorhanden.
      ##member = '*NONE';
    endif;
  endif;

  //      ... prüfen auf phys. Datei bei Zugriff über SQL
  //** %SQL%          IF        (AccessMode = SQL_SEQ and ATFILA <> '*PHY')
  //**                Exsr      MsgInvSqlFile
  //**                Leavesr
  //**                ENDIF

  //      ... prüfen Name der Teildatei
  exsr checkmbrname;
  if (isError = bTrue);
    //  Fehler aufgetreten, Öffnen abbrechen.
    exsr msgnofile;
    leavesr;
  endif;

  //  ... Satzformate
  //      ... abrufen der Satzformate
  exsr getfmtlist;
  if (yMsgID <> '');
    //  Satzformate konnten nicht abgerufen werden (USR0002),
    //  Öffnen abbrechen.
    p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
    yMsgID = '';
    yMsgDta = '';
    exsr msgnofile;
    leavesr;
  endif;
  //      ... auswählen Satzformat
  exsr getrcdfrmt;

  //  ... prüfen auf Schlüsselfelder
  //      und initialisieren von PEEK41 (= Dateiinformationen)
  exsr getnbrkeyf;
  //      ... wenn keine Schlüsselinformationen
  //          vorhanden sind, ...
  if iskeyavail = bFalse
     and accessMode = KEY_SEQ;
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
      sqlOrder = sql_quote(f_ucase(sqlOrder));
    endif;
  endif;

  // -------------------------------------------------
  //  Prüfen Zugriffsrechte
  // -------------------------------------------------

  //      ... prüfen Zugriffsrechte
  exsr s_exit01;

  //      ... Zugriff nicht erlaubt
  if (auth.isAccessAlw <> bTrue);
    exsr closefile;
    p_rmvpgmmg(sds.pgmname);
    p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
    yMsgID = '';
    yMsgDta = '';
    leavesr;
  endif;

  // -------------------------------------------------
  //  Datei öffnen für Einzelzugriff (Aktualisierung)
  // -------------------------------------------------

  if (##member = '*NONE');
    clear hfile00;
    file#x.isOpen = bFalse;
    file#x.file = ##file;
    file#x.library = ##library;
    file#x.rcdlen = 0;
    file#x.member = ##member;
    file#x.rcdfmt = ##format;
    file#x.mbrnbr = 0;
    file#x.rcdnbr = 0;
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
      if cio_open(hfile00
               : ##file
               : ##library
               : ##member
               : ##format
               : 'rr+, arrseq=Y, commit=Y, +
                  nullcap=Y, riofb=Y, +
                  secure=N, ccsid=65535') = bTrue;
        exsr f0tofx;
        isUpdMod = bTrue;
      else;
        //          ... ohne Commit-Steuerung
        commitLvl = '0';
        if cio_open(hfile00
                 : ##file
                 : ##library
                 : ##member
                 : ##format
                 : 'rr+ , arrseq=Y, commit=N +
                    nullcap=Y, riofb=Y, +
                    secure=N, ccsid=65535') = bTrue;

          exsr f0tofx;
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

    if (isUpdMod = bTrue) and (auth.isUpdKeyAlw = bTrue);
      isUpdKey = bTrue;
    else;
      isUpdKey = bFalse;
    endif;

    // -------------------------------------------------
    //  Datei öffnen für Sortierfolge
    // -------------------------------------------------

    //  Sortierung 2 nach Schlüsselfelder
    if (accessMode = KEY_SEQ);
      if cio_open(hfile02
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
        cio_geterrormsg(hfile02: yMsgID: yMsgDta);
        p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
        yMsgID = '';
        yMsgDta = '';
      endif;
      exsr f2tofx;
    endif;

    //  Sortierung 1 nach Satzfolge
    if (accessMode = RRN_SEQ);
      if cio_open(hfile01
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
        cio_geterrormsg(hfile01: yMsgID: yMsgDta);
        p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
        yMsgID = '';
        yMsgDta = '';
      endif;
      exsr f1tofx;
    endif;

    //  Sortierung 3 nach Sql
    if (accessMode = SQL_SEQ);
      clear usr0013;
      p_sndstsmg('USR0013': usr0013);
      if sql_preparestatement(
                 '0'       :
                 ##file    :
                 ##library :
                 ##member  :
                 ##format  :
                 sqlWhere  :
                 sqlOrder  :
               yMsgID      :
               yMsgDta     ) = bTrue;
        if sql_open(hfile03     :
                 yMsgID      :
                 yMsgDta     ) = bTrue;
          *in99 = *off;
          yMsgID = '';
          yMsgDta = '';
        else;
          *in99 = *on;
          cio_geterrormsg(hfile03: yMsgID: yMsgDta);
          p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
          yMsgID = '';
          yMsgDta = '';
        endif;
        exsr f3tofx;
      else;
        *in99 = *on;
        p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
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
  if (file#x.rcdlen > RCD_BUFF_LEN);
    exsr closefile;
    p_rmvpgmmg(sds.pgmname);
    clear usr8207;
    usr8207.var1 = RCD_BUFF_LEN;
    p_sndpgmmg('USR8207': usr8207: sds.pgmname);
  else;

    // ... löschen Pin-Funktion
    exsr clrpincol;
    exsr clrpinrow;
    // ... auswerten Rückkehrcode
    if (yMsgID = 'USR8100'); // Verarbeitung abgebrochen
      // ... Abbruch mit F3/F12
      exsr closefile;
    else;
      // ... weiter
      // ... abrufen der Feldliste
      exsr getfldlist;
      // ... abrufen der Schlüsselfelder
      exsr getkeylist;
      // ... Sortieren der Schlüsselfelder
      exsr floatkeys;
      // ... Fensterposition
      ##wndnbr = 0;
      ##strpage = 0;
      // ... Suchmodus
      exsr srchinz;
      // ... Blätternfunktion Einzelsatz
      yScreenNbr = 0;
      // ... abrufen der Teildateiattribute
      exsr getmbrattr;
      // ... initialisieren Kurzbefehl
      exsr initscmd;
      // ... Nachrichten entfernen
      p_rmvpgmmg(sds.pgmname);
      // ... einblenden Aufsetzkey
      if (accessMode = KEY_SEQ);
        *in70 = '1';
      else;
        *in70 = '0';
      endif;
      // ... Cursor auf Keyeingabezeile setzen
      exsr c_poscsr;

      // ... Hexmode nicht bei Satzlänge größer 32766
      if (file#x.rcdlen > RCD_BUFF_LEN and
          set0001.set_dspmde = '*DSPHEX');
        clear usr8206;
        usr8206.var1  = RCD_BUFF_LEN;
        p_sndpgmmg('USR8206': usr8206: sds.pgmname);
        exsr s_dspnrm;
      endif;

      // ... Felder, welche nicht erlaubt sind
      clear f_key;
      f_key.f_field = *blanks;
      setll %kds(f_key) fpeekfld;
      dow ('1');
        read fpeekfld;
        if (%eof());
          leave;
        endif;
        if (f_isnotalw(f_ffd) = bTrue);
          p_sndpgmmg('USR8196': f_field: sds.pgmname);
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
          p_sndpgmmg('USR0004': '': sds.pgmname);
        else;
          // ... mit Commit
          *in55 = bTrue;
          p_sndpgmmg('USR0003': '': sds.pgmname);
        endif;

        // ... Datei für ...
        if (isUpdMod = bFalse);
          // ... Input geöffnet
          usr0007.var1 = ##file;
          usr0007.var2 = ##library;
          p_sndpgmmg('USR0007': usr0007: sds.pgmname);
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

begsr pbread;

  isfileerror = bFalse;

  dou (file#x.rcdfmt = ##format) or (*in99 = *on);

    select;
    when (accessMode = KEY_SEQ);
      if cio_read(hfile02: bFalse
               : io_buff: io_nullmap) = bEOF;
        *in99 = *on;
      else;
        *in99 = *off;
      endif;
      exsr f2tofx;
      isfileerror = cio_iserror(hfile02);
    when (accessMode = RRN_SEQ);
      if cio_read(hfile01: bFalse
               : io_buff: io_nullmap) = bEOF;
        *in99 = *on;
      else;
        *in99 = *off;
      endif;
      exsr f1tofx;
      isfileerror = cio_iserror(hfile01);
    when (accessMode = SQL_SEQ);
      if sql_nextrow(io_buff: io_nullmap: hfile03:
                  yMsgID : yMsgDta)  = bEOF;
        *in99 = *on;
        p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
        yMsgID = '';
        yMsgDta = '';
      else;
        *in99 = *off;
        yMsgID = '';
        yMsgDta = '';
      endif;
      exsr f3tofx;
      isfileerror = cio_iserror(hfile03);
    other;
    endsl;

  enddo;

  if (isfileerror = bTrue);
    iseof = bTrue;
  else;
    if (*in99 = *on);
      exsr pbmovebot;
      iseof = bTrue;
    else;
      iseof = bFalse;
    endif;
  endif;

endsr;

//============================================================*
//    PBReadP       Rückwärts lesen in Satz- oder             *
//                  Schlüsselfolge                            *
//============================================================*

begsr pbreadp;

  dou (file#x.rcdfmt = ##format) or (*in99 = *on);

    select;
    when (accessMode = KEY_SEQ);
      if cio_readp(hfile02: bFalse
                : io_buff: io_nullmap) = bEOF;
        *in99 = *on;
      else;
        *in99 = *off;
      endif;
      exsr f2tofx;
    when (accessMode = RRN_SEQ);
      if cio_readp(hfile01: bFalse
                : io_buff: io_nullmap) = bEOF;
        *in99 = *on;
      else;
        *in99 = *off;
      endif;
      exsr f1tofx;
    when (accessMode = SQL_SEQ);
      if sql_previousrow(io_buff: io_nullmap: hfile03:
                      yMsgID : yMsgDta) = bEOF;
        *in99 = *on;
        if (yMsgID <> '');
          p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
          yMsgID = '';
          yMsgDta = '';
        endif;
      else;
        *in99 = *off;
        yMsgID = '';
        yMsgDta = '';
      endif;
      exsr f3tofx;
      isfileerror = cio_iserror(hfile03);
    other;
    endsl;

  enddo;

  if (*in99 = *on);
    exsr pbmovetop;
    iseof = bTrue;
  else;
    iseof = bFalse;
  endif;

endsr;

//============================================================*
//    F0toFx        Übertragen der Dateiinformationen         *
//                  (Status usw.) der Datei 00 in die         *
//                  "globalen Felder Fx                       *
//============================================================*

begsr f0tofx;

  file#x = cio_getinfds(hfile00);

endsr;

//============================================================*
//    F1toFx        Übertragen der Dateiinformationen         *
//                  (Status usw.) der Datei 01 in die         *
//                  "globalen Felder Fx                       *
//============================================================*

begsr f1tofx;

  file#x = cio_getinfds(hfile01);

endsr;

//============================================================*
//    F2toFx        Übertragen der Dateiinformationen         *
//                  (Status usw.) der Datei 02 in die         *
//                  "globalen Felder Fx                       *
//============================================================*

begsr f2tofx;

  file#x = cio_getinfds(hfile02);

endsr;

//============================================================*
//    F3toFx        Übertragen der Dateiinformationen         *
//                  (Status usw.) der Datei 03 in die         *
//                  "globalen Felder Fx                       *
//============================================================*

begsr f3tofx;

  file#x = cio_getinfds(hfile03);

endsr;

//============================================================*
//    RepeatOpt     Wiederholen der Subfileauswahl            *
//============================================================*

begsr repeatopt;

  //  "Keine Sätze vorhanden"
  if (*in80 = *off);
  //  ... nix zu tun
  else;

    //  Lese alle Sätze der Subfile ab Wrk#Recno ...
    for x = wrk#recno to sflnbrrcd;

      sflrec132 = x;
      sflrec080 = x;
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
          sfpau = wrk#sfpau;
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

begsr getfrstfld;

  if (isOpen = bFalse);
    ##wndnbr = 0;
  else;

    ##wndnbr = 0;

    for x = 1 to cp;

      wrk#field = col_field(x);
      exsr chkVisible;
      if (isVisible = bFalse);
        //  ... nicht sichtbar
        iter;
      else;
        //  ... sichtbar
        //      ... ermitteln der Sequenznummer
        clear f_key;
        f_key.f_field = col_field(x);
        chain(n) %kds(f_key) fpeekfld;
        if (%found(peekfld));
          // ... ermittelt
          ##wndnbr = f_seq;
          leave;
        else;
          // ... kann eigentlich nicht sein
          iter;
        endif;
      endif;

    endfor;

  endif;

  //  Merken letzte Feldposition
  l#wndnbr = ##wndnbr;

  exsr chkseqrnge;

endsr;

//============================================================*
//    GetPgmName    Berechnen Programmname                    *
//============================================================*

begsr getPgmName;

  peekPgm = 'P' +
             %subst(rcdl0200.r2fmtid: 1: 2) +
             %subst(rcdl0200.r2fmtid: 7: 7);

endsr;

//============================================================*
//    GetDSpName    Berechnen Name Displayfile                *
//============================================================*

begsr getDspName;

  peekDspF = 'F' +
             %subst(rcdl0200.r2fmtid: 1: 2) +
             %subst(rcdl0200.r2fmtid: 7: 7);

endsr;

//============================================================*
//    GetFldTMrk    Holen des zu markierenden Feldnamens      *
//============================================================*

begsr getfldtmrk;

  wrk#field = '';

  if (cp <= 0);
    //  Funktion bei leerer Feldtabelle möglich ...
    p_sndpgmmg('USR8145': '': sds.pgmname);
  else;

    for x = 1 to cp;
      y = cursorposition.column - sflleftofs;
      if (y >= col_scnstr(x) and y <= col_scnend(x));
        wrk#field = col_field(x);
        leave;
      endif;
    endfor;

    if (wrk#field = '');
      p_sndpgmmg('USR8117': '': sds.pgmname);
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
    p_sndpgmmg('USR8102': '': sds.pgmname);
  endif;

endsr;

//============================================================*
//    GetNbrKeyF    Ermitteln Anzahl Schlüsselfelder          *
//============================================================*

begsr getnbrkeyf;

  peek04(yQFile: ##format: yMsgID: yMsgDta);
  if (yMsgID = 'USR0006');
    iskeyavail = bFalse;
  else;
    iskeyavail = bTrue;
  endif;

endsr;

//============================================================*
//    GetNbrMbr     Ermitteln Anzahl Teildateien              *
//============================================================*

begsr getnbrmbr;

  peek41(yQFile: ##format
        : '*CREATE': ynbrofent: ydata);
  if (ynbrofent > *zeros);
    fild0100 = ydata;
  else;
    clear fild0100;
  endif;

  $$nomb = fild0100.atnomb;

endsr;

//============================================================*
//    GetFmtList    Abrufrufen der Satzformatliste            *
//============================================================*

begsr getfmtlist;

  yFile = ##file;
  yLibrary = ##library;
  peek10(yQFile: yMsgID: yMsgDta);

endsr;

//============================================================*
//    GetFldList    Abrufrufen der Feldliste                  *
//============================================================*

begsr getfldlist;

  yFile = ##file;
  yLibrary = ##library;
  peek01(yQFile: ##format: $$rcdfmtid
        : yMsgID: yMsgDta);

  open peekfld;
  open peekfldl1;

endsr;

//============================================================*
//    GetKeyList    Abrufrufen der Schlüsselfelder            *
//============================================================*

begsr getkeylist;

  peek03(yQFile: ##format: accessMode: sqlOrder
        : yMsgID: yMsgDta);

endsr;

//============================================================*
//    GetRcdFrmt    Auswählen des Satzformates                *
//============================================================*

begsr getrcdfrmt;

  peek12(set0001.set_dsp80: COPYRIGHT: ##format
        : MODE_BATCH
        : rcdl0200: yfmtnbr: yMsgID: yMsgDta);

  if (yMsgID <> 'USR8100'); // Verarbeitung abgebrochen
    ##fmtnbr = yfmtnbr;
    ##format = rcdl0200.r2fmtname;
    $$length = rcdl0200.r2rcdlen;
  else;
  //         Abbruch über F3/F12
  endif;

endsr;

//============================================================*
//    GetObjAttr    Abrufrufen und anzeigen der               *
//                  Objektattribute                           *
//============================================================*

begsr getobjattr;

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
        p_sndpgmmg('USR0008': usr0008: sds.pgmname);
      when (yMsgID = 'CPF9810');
        usr0010.var1 = ##library;
        p_sndpgmmg('USR0010': usr0010: sds.pgmname);
      other;
        usr0009.var1 = ##file;
        usr0009.var2 = ##library;
        p_sndpgmmg('USR0009': usr0009: sds.pgmname);
      endsl;
    else;

      isError = bFalse;
      //  Übertragen der Objektbezeichnung
      ##file = objd0400.o4objname;
      ##library = objd0400.o4retlib;

      //  Übertragen der Objektbeschreibung
      $$text40 = objd0400.o4text;
      $$text50 = objd0400.o4text;

      //  Wenn die Objektgröße kleiner als 999 ist,
      if (objd0400.o4objsize <= 999);
        //  ... dann in der Einheit "Byte" anzeigen ...
        r#size = 0;
        $$unit = 'Byt';
      else;
        //  ... ansonsten solange durch 1024 teilen,
        //      bis das die nächste passende Einheit
        //      gefunden werden konnte.
        r#size = 0;

        dow (objd0400.o4objsize > 999);
          objd0400.o4objsize =
           %dech(objd0400.o4objsize / 1024: 10: 0);
          r#size = r#size + 1;
        enddo;

        //  Multiplikator aus der Objektbeschreibung
        //  berücksichtigen und ...
        if (objd0400.o4objsizem = 1024);
          r#size = r#size + 1;
        else;
        //       keine Korrektur erforderlich
        endif;

        //  ... und passende Einheit wählen ...
        select;
        when (r#size = 1);
          $$unit = 'K';
        when (r#size = 2);
          $$unit = 'MByt';
        when (r#size = 3);
          $$unit = 'GByt';
        other;
          $$unit = 'TByt';
        endsl;
      endif;

      //  ... sowie Restgröße zur Anzeige bringen
      $$size = objd0400.o4objsize;
    endif;
  endif;

endsr;

//============================================================*
//    GetMbrAttr    Abrufen der Attribute der Teildatei       *
//============================================================*

begsr getmbrattr;

  //  Beschreibung der Teildatei
  if (isOpen = bFalse);
    $$records = 0;
    leavesr;
  endif;

  if (##member = '*NONE');
    clear mbrd0200;
    $$records = 0;
    $$lmtcnt = '';
    $$records = 0;
    leavesr;
  endif;

  yFile = ##file;
  yLibrary = ##library;
  peek13(yQFile: ##member: mbrd0200);

  if (mbrd0200.m2bytAvl > 0);
    if (mbrd0200.m2nbrrcdon <= 2147483647);
      $$records = mbrd0200.m2nbrrcdon;
      *in79 = *on;
      $$lmtcnt = '';
    else;
      $$records = 0;
      *in79 = *off;
      $$lmtcnt = '*OVERFLOW';
    endif;
  else;
    $$records = 0;
    *in79 = *off;
    $$lmtcnt = '*ERROR';
  endif;

  if (accessMode = SQL_SEQ);
    if ($$records > set0016.set_maxrcds);
      $$records = 0;
      *in79 = *off;
      $$lmtcnt = '*SQLLMTCNT';
    else;
      clear usr0014;
      p_sndstsmg('USR0014': usr0014);
      $$records = sql_count();
      *in79 = *on;
      $$lmtcnt = *blanks;
    endif;
  endif;

endsr;

//============================================================*
//    CheckMbrName  Prüfen Name der Teildatei                 *
//============================================================*

begsr checkmbrname;

  if (##member = '*NONE');
    clear mbrd0200;
    isError = bFalse;
    leavesr;
  endif;

  yFile = ##file;
  yLibrary = ##library;
  peek13(yQFile: ##member: mbrd0200);
  if (mbrd0200.m2bytAvl <> 0);
    ##member = mbrd0200.m2member;
    isError = bFalse;
  else;
    isError = bTrue;
  endif;

endsr;

//============================================================*
//    GetMaxSeq     Ermitteln der Anzahl Felder               *
//============================================================*

begsr getmaxseq;

  if (isOpen = bFalse);
    l#maxseq = 0;
    l#minseq = 0;
  else;

    //  Ermitteln Anzahl Felder ...
    clear f1key_l1;
    f1key_l1.f_seq = *hival;
    setgt %kds(f1key_l1) fpeekfldl1;

    dow ('1');
      readp fpeekfldl1;
      if (%eof());
        l#maxseq = 0;
        leave;
      endif;

      //  ... Prüfen, ob Feld angezeigt wird
      wrk#field = f_field;
      exsr chkVisible;
      if (isVisible = bFalse);
        iter;
      endif;

      l#maxseq = f_seq;
      leave;
    enddo;

    //  Ermitteln Erstes Feld ...
    clear f1key_l1;
    f1key_l1.f_seq = 0;
    setll %kds(f1key_l1) fpeekfldl1;

    dow ('1');
      read fpeekfldl1;
      if (%eof());
        l#minseq = 0;
        leave;
      endif;

      //  ... Prüfen, ob Feld angezeigt wird
      wrk#field = f_field;
      exsr chkVisible;
      if (isVisible = bFalse);
        iter;
      endif;

      l#minseq = f_seq;
      leave;
    enddo;

  endif;

endsr;

//============================================================*
//    GetMaxSeq     Ermitteln vorhergehendes sichtabres Feld  *
//============================================================*

begsr getprvseq;

  if (isOpen = bFalse);
    wrk#seqnbr = -1;
    leavesr;
  endif;

  clear f1key_l1;
  f1key_l1.f_seq = wrk#seqnbr;
  chain %kds(f1key_l1) fpeekfldl1;
  if not %found();
    wrk#seqnbr = l#minseq;
    leavesr;
  endif;

  for do_x10 = 1 to *hival;
    readp fpeekfldl1;
    if %eof();
      wrk#seqnbr = l#minseq;
      leave;
    endif;

    //  ... Prüfen, ob Feld angezeigt wird
    wrk#field = f_field;
    exsr chkVisible;
    if (isVisible = bFalse);
      iter;
    endif;

    wrk#seqnbr = f_seq;
    leave;
  endfor;

endsr;

//============================================================*
//    CloseFile     Datei schließen                           *
//============================================================*

begsr closefile;

  if (isOpen = bTrue);

    yCursorPosition.row = 0;
    yCursorPosition.column = 0;

    //  Datei 04 für Einzelsatzzugriff
    if (cio_isopen(hfile04) = bTrue);
      cio_close(hfile04);
    endif;

    select;
    when (accessMode = KEY_SEQ);
      //  Sortierung 2 für Schlüsselfolge
      if (cio_close(hfile02) = bTrue);
        *in99 = '0';
      else;
        *in99 = '1';
      endif;
      exsr f2tofx;
    when (accessMode = RRN_SEQ);
      //  Sortierung 1 für Satzfolge
      if (cio_close(hfile01) = bTrue);
        *in99 = '0';
      else;
        *in99 = '1';
      endif;
      exsr f1tofx;
    when (accessMode = SQL_SEQ);
      if sql_close(hfile03:yMsgID :yMsgDta)
         = bTrue;
        *in99 = *off;
        yMsgID = '';
        yMsgDta = '';
      else;
        *in99 = *on;
        if (yMsgID <> '');
          p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
          yMsgID = '';
          yMsgDta = '';
        endif;
      endif;
      exsr f3tofx;
    other;
    endsl;

  else;
    *in99 = '0';
  endif;

  //  Sortierung 0 für Einzelzugriff
  if (cio_isopen(hfile00) = bTrue);
    if (cio_close(hfile00) = bTrue);
      *in99 = '0';
    else;
      *in99 = '1';
    endif;
    exsr f0tofx;
  endif;

  if (*in99 = *off);
    isOpen = bFalse;
    //  Löschen Satzaufbau
    if %open(peekfld);
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
      close peekfldl1;
      close peekfld;
    endif;
    //      ... Satzformat
    $$text40 = *blanks;
    $$text50 = *blanks;
    $$length = 0;
    $$records = 0;
    $$size = 0;
    $$rcdfmtid = *blanks;
    $$unit = *blanks;
    $$nomb = 0;
    ##key = *blanks;
    ##rcdnbr = 0;
    //      ... Fensterposition
    ##wndnbr = 0;
    ##strpage = 0;

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
//    GetOpnFile    Ermitteln der geöffneten Datei            *
//============================================================*

begsr getopnfile;

  if (isOpen = bTrue);
    ##file = file#x.file;
    ##library = file#x.library;
    ##member = file#x.member;
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

  l#file = ##file;
  l#library = ##library;
  l#member = ##member;
  l#format = ##format;

endsr;

//============================================================*
//    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getusrsetg;

  //  *DSPATR
  set0001 = f_getusrsg('*DSPATTR'  );

  //  *SEARCH
  set0002 = f_getusrsg('*SEARCH'   );

  //  *ACCESSKEY
  set0003 = f_getusrsg('*ACCESSKEY');

  //  *SPLASH
  set0005 = f_getusrsg('*SPLASH'   );

  //  *CVTCHR
  set0006 = f_getusrsg('*CVTCHR'   );

  //  *VERSION
  set0007 = f_getusrsg('*VERSION'  );

  //  *PROMPT
  set0008 = f_getusrsg('*PROMPT'   );

  //  *FLOATKEYS
  set0009 = f_getusrsg('*FLOATKEYS');

  //  *SCROLL
  set0010 = f_getusrsg('*SCROLL'   );

  //  *DFTDSPMDE
  set0011 = f_getusrsg('*DFTDSPMDE');

  if (set0011.set_dftmde = '*LAST');
  //    ... Modus belassen
  else;
    set0001.set_dspmde = set0011.set_dftmde;
  endif;

  select;
  when (set0001.set_dspmde = '*DSPNRM');
    exsr s_dspnrm;
  when (set0001.set_dspmde = '*DSPHEX');
    exsr s_dsphex;
  other;
    exsr s_dspnrm;
  endsl;

  // - Löschen Programmnachricht "keine Datei geöffnet"
  p_rmvpgmmg(sds.pgmname);

  //  *SECATR ...
  set0013 = f_getusrsg('*SECATRDFT'   );

  //  ... Verknüpfen *SECATRDFT mit Eingabeparametern ...
  //      ... ##Library
  if (i_chglib = '*');
    if (set0013.set_chglib = '1');
      auth.isChgLibAlw = bTrue;
    else;
      auth.isChgLibAlw = bFalse;
    endif;
  else;
    if (i_chglib = '1');
      auth.isChgLibAlw = bTrue;
    else;
      auth.isChgLibAlw = bFalse;
    endif;
  endif;

  //      ... ##File
  if (i_chgfile = '*');
    if (set0013.set_chgfil  = '1');
      auth.isChgFileAlw = bTrue;
    else;
      auth.isChgFileAlw = bFalse;
    endif;
  else;
    if (i_chgfile = '1');
      auth.isChgFileAlw = bTrue;
    else;
      auth.isChgFileAlw = bFalse;
    endif;
  endif;

  //      ... ##Member
  if (i_chgmbr = '*');
    if (set0013.set_chgmbr = '1');
      auth.isChgMbrAlw = bTrue;
    else;
      auth.isChgMbrAlw = bFalse;
    endif;
  else;
    if (i_chgmbr = '1');
      auth.isChgMbrAlw = bTrue;
    else;
      auth.isChgMbrAlw = bFalse;
    endif;
  endif;

  //      ... updMod
  if (i_updmodkey = UPD_M_DFT);
    if (set0013.set_updmod = '1');
      auth.isUpdAlw = bTrue;
    else;
      auth.isUpdAlw = bFalse;
    endif;
  else;
    if (i_updmodkey = UPD_M_YES or
        i_updmodkey = UPD_M_NOKEY);
      auth.isUpdAlw = bTrue;
    else;
      auth.isUpdAlw = bFalse;
    endif;
  endif;

  //      ... keyUpd
  if (i_updmodkey = UPD_M_DFT or
      i_updmodkey = UPD_M_YES);
    auth.isUpdKeyAlw = bTrue;
  else;
    auth.isUpdKeyAlw = bFalse;
  endif;

  //      ... chgSqlW
  if (i_chgsqlw = UPD_M_DFT or
      i_chgsqlw = UPD_M_YES);
    auth.isChgSQLWhereAlw = bTrue;
  else;
    auth.isChgSQLWhereAlw = bFalse;
  endif;

  //      ... chgSqlO
  if (i_chgsqlo = UPD_M_DFT or
      i_chgsqlo = UPD_M_YES);
    auth.isChgSQLOrderByAlw = bTrue;
  else;
    auth.isChgSQLOrderByAlw = bFalse;
  endif;

  //      ... accAut
  if (set0013.set_accaut = '1');
    auth.isAccessAlw = bTrue;
  else;
    auth.isAccessAlw = bFalse;
  endif;

  //  *PRVFILE
  set0014 = f_getusrsg('*PRVFILE');

  //  *ENVFILE
  set0015 = f_getusrsg('*ENVFILE');

  //  *SQLLMTCNT
  set0016 = f_getusrsg('*SQLLMTCNT');

endsr;

//============================================================*
//    GetSeqNbr     Übersetzen Field Name in Sequence Nbr     *
//============================================================*

begsr getseqnbr;

  clear f_key;
  f_key.f_field = wrk#field;
  chain(n) %kds(f_key) fpeekfld;
  if (%found());
    isSeqNbrOK = bTrue;
    wrk#seqnbr = f_seq;
  else;
    isSeqNbrOK = bFalse;
    wrk#seqnbr = 0;
  endif;

endsr;

//============================================================*
//    GetLastOpt    Ermitteln der letzten Subfileauswahl      *
//============================================================*

begsr getlastopt;

  //  "Keine Sätze vorhanden"
  if (*in80 = *off);
    isError = bTrue;
    wrk#sfpau = *blanks;
    wrk#recno = 0;
  else;

    for x = 1 to sflnbrrcd;

      y = sflnbrrcd - x;
      y = y + 1;

      if (*in88 = *off);
        sflrec132 = y;
        chain sflrec132 pbsfl132;
      else;
        sflrec080 = y;
        chain sflrec080 pbsfl080;
      endif;

      if (not %found());
        isError = bTrue;
        wrk#sfpau = '';
        wrk#recno = 0;
        leave;
      else;
        if (sfpau <> '');
          wrk#sfpau = sfpau;
          if (*in88 = bFalse);
            wrk#recno = sflrec132;
          else;
            wrk#recno = sflrec080;
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
//    GetNxtMark    Ermtteln des nächsten markierten Feldes   *
//============================================================*

begsr getnxtmark;

  //  Suchen des nächsten markierten Feldes ...
  clear f1key_l1;
  f1key_l1.f_seq = wrk#seqnbr;
  setgt %kds(f1key_l1) fpeekfldl1;

  dow ('1');
    read fpeekfldl1;
    if (%eof());
      wrk#seqnbr = *zeros;
      leave;
    endif;

    exsr chkVisible;
    if (isVisible = bFalse);
    // ... Feld ist nicht sichtbar
    else;
      // ... Feld ist sichtbar
      if (f_markcol = bTrue);
        // ... und markiert
        wrk#seqnbr = f_seq;
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

begsr getprvmark;

  //  Suchen des nächsten markierten Feldes ...
  clear f1key_l1;
  f1key_l1.f_seq = wrk#seqnbr;
  setll %kds(f1key_l1) fpeekfldl1;

  dow ('1');
    readp fpeekfldl1;
    if (%eof());
      wrk#seqnbr = 0;
      leave;
    endif;

    exsr chkVisible;
    if (isVisible = bFalse);
    // ... Feld ist nicht sichtbar
    else;
      // ... Feld ist sichtbar
      if (f_markcol = bTrue);
        // ... und markiert
        wrk#seqnbr = f_seq;
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

begsr keyhaschg;

  wrk#keyval = ##key;
  wrk#rcdnbr = ##rcdnbr;
  exsr pbgenintky;
  if (yMsgID <> *blanks);
    p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
    yMsgID = '';
    yMsgDta = '';
    p_sndpgmmg('USR8139': '': sds.pgmname);
  else;
    exsr pbsetll;
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
//    FloatKeys     Keyfelder an den Anfang sortieren         *
//============================================================*

begsr floatkeys;

  if (set0009.set_float  = bTrue) and
     ((accessMode = KEY_SEQ) or
      (accessMode = SQL_SEQ));

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
//    KeepCsrPos    Beibehalten der Cursorposition            *
//============================================================*

begsr keepCsrPos;

  //  Beibehalten der Cursorosition
  csrrow = cursorposition.row;
  csrcol = cursorposition.column;

endsr;

//============================================================*
//    DltCsrPos     Löschen der Cursorposition                *
//============================================================*

begsr dltcsrpos;

  //  Löschen der Cursorosition
  csrrow = *zeros;
  csrcol = *zeros;

endsr;

//============================================================*
//    SetUsrSetg    Speichern der Benutzervoreinstellungen    *
//============================================================*

begsr setusrsetg;

  //  Splash-Screen
  p_updusrsg('*SPLASH' : set0005);

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
    pin#field = wrk#field;
    exsr chkpincol;
    if (ispinned = bTrue);
      isVisible = bFalse;
      leave;
    endif;

  endfor;

endsr;

//============================================================*
//    ChkSeqRnge    Prüfen der Fensternummer                  *
//============================================================*

begsr chkseqrnge;

  if (isOpen = bFalse);
  //            keine Datei geöffnet
  else;

    if (##wndnbr < l#minseq);
      ##wndnbr = l#minseq;
      p_sndpgmmg('USR8115': '': sds.pgmname);
      ##strpage = 1;
    endif;

    if (##wndnbr > l#maxseq);
      ##wndnbr = l#maxseq;
      p_sndpgmmg('USR8116': '': sds.pgmname);
      if (set0010.set_scroll = '*BOTH'
          or set0010.set_scroll = '*RIGHT');
        ##strpage = *hival;
      else;
        ##strpage = 1;
      endif;
    endif;

    if (##strpage < 1);
      ##strpage = 1;
    endif;

  endif;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setscreen;

  //    Wenn der Bildschirm keine 132-Zeichen
  //    darstellen kann, ...
  if (workstn.numrows < 27);
    //    ... dann auf 80-Zeichen umschalten.
    set0001.set_dsp80 = '1';
  else;
  //    ... sonst die Auflösung 80/132 beibehalten.
  endif;

  if (set0001.set_dsp80 = '1');
    //    80-Zeichen Anzeige
    *in88 = '1';
    sflpage = 14;
    sflMaxRowLen = 64;
    sflheadlrw = 6;
    sflfirstrw = 7;
    sfllastrw = 20;
    sflleftofs = 15;
  else;
    //   132-Zeichen Anzeige
    *in88 = '0';
    sflpage = 16;
    sflMaxRowLen = 116;
    sflheadlrw = 6;
    sflfirstrw = 8;
    sfllastrw = 23;
    sflleftofs = 15;
  endif;

  //  Bereich für gepinnte Spalten
  sflpinrnge = (sflMaxRowLen / 3) * 2;

  //  Prompt-Felder anzeigen ...
  if (set0008.set_dsppmt = bTrue
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

begsr chgscreen;

  if (set0001.set_dsp80 = '1');
    //   132-Zeichen Anzeige
    set0001.set_dsp80 = '0';
  else;
    //    80-Zeichen Anzeige
    set0001.set_dsp80 = '1';
  endif;

  exsr setscreen;

endsr;

//============================================================*
//    ShowSplash    Anzeigen SPLASH-Screen                    *
//============================================================*

begsr showsplash;

  if (set0005.set_spla = bFalse);
  //            kein Splash-Screen
  else;
    write splash01;
  endif;

endsr;

//============================================================*
//    ChkVersion    Prüfen der Versionsnummer                 *
//============================================================*

begsr chkversion;

  if (set0007.set_vsn <> VERSION);
    peek33(VERSION: yMsgID: yMsgDta);
  else;
  //  Kein Abgleich erforderlich ...
  endif;

endsr;

//============================================================*
//    ChkPrvFile    Prüfen vorherige Datei                    *
//============================================================*

begsr chkprvfile;

  //  Datei ...
  if (##file = '*PRV');
    if (set0014.set_prvfil  <> '*NONE');
      ##file = set0014.set_prvfil;
    endif;
    //  Bibliothek ...
    if (set0014.set_prvlib  <> '*NONE');
      ##library = set0014.set_prvlib;
    else;
      ##library = ' ';
    endif;
    //  Teildatei ...
    if (set0014.set_prvmbr  <> '*NONE');
      ##member = set0014.set_prvmbr;
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
    p_rmvpgmmg(sds.pgmname);
    p_sndpgmmg(yMsgID: yMsgDta: sds.pgmname);
    yMsgID = '';
    yMsgDta = '';
  endif;

endsr;

//============================================================*
//    clrPinTabR    Löschen PinTabR                           *
//============================================================*

begsr clrPinTabR;

  clear pinTabRcdE;
  for pinrcd_x = 1 to max_pin_rcd;
    pinTabRcd(pinrcd_x) = pinTabRcdE;
  endfor;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Programm initialisieren
  p_rmvpgmmg(sds.pgmname);

  // - Zeichenumsetzung neu beginnen: Die Job-CCSID kann sich seit dem
  //   letzten Aufruf geändert haben (CHGJOB CCSID).
  transcoder_reset();

  // - Einlesen der Benutzervoreinstellungen
  exsr getusrsetg;

  // - Prüfen auf generischen Dateinamen
  if (f_endswith('*': %trimr(io_qfile.name)));
    if (*in75 = *off); // Feld ist nicht gesperrt
      ##file = io_qfile.name;
      ##library = io_qfile.lib;
      exsr pmt_file;
      if (*in93 = bTrue);
        io_qfile.name = ##file;
        io_qfile.lib = ##library;
      endif;
      ##file = '';
      ##library = '';
    endif;
  endif;

  // - Öffnen Bildschirmdatei
  open peek05fm;

  // - Initialisieren Bildschirm
  ##file = io_qfile.name;
  ##library = io_qfile.lib;
  ##member = i_member;
  exsr getobjattr;

  exsr chkprvfile;
  ##rcdnbr = 0;
  ##key = *blanks;
  ##wndnbr = 0;
  ##strpage = 0;
  ##field = *blanks;

  exsr clrFldPosArray;

  $$system = *blanks;
  $$text40 = *blanks;
  $$text50 = *blanks;
  ##format = *blanks;
  $$length = 0;
  $$records = 0;
  $$size = 0;
  $$rcdfmtid = *blanks;
  $$unit = *blanks;

  $$head132 = *blanks;
  $$head080 = *blanks;

  //  Last opened file
  l#file = *blanks;
  l#library = *blanks;
  l#member = *blanks;
  l#format = *blanks;
  l#maxseq = 0;
  l#minseq = 0;
  l#wndnbr = 0;

  //  SQL-Selektion
  sqlWhere  = ' ';
  sqlOrder  = ' ';

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setscreen;

  // - SPLASH-Screen
  exsr showsplash;

  // -  Darstellung der Auswahlen/Funktionstasten
  sftop = 1;
  sfbot = 1;

  // -  Netzwerkattribute (ohne Statusmeldung)
  peek07('SYSNAME': bTrue
        : yattrlen: yattrtyp: yvalue);
  if (yattrlen > 0);
    $$system = %subst(yvalue: 1: yattrlen);
  else;
    $$system = *blanks;
  endif;

  // - Öffnen der Datei
  if (isOpen = bFalse);
    accessMode = i_access;
    if (accessMode = SQL_SEQ);
      sqlWhere  = i_sqlwhere;
      sqlOrder  = i_sqlorder;
    endif;
    exsr openfile;
  endif;

  // - laden Arbeitsumgebung / öffnen Datei
  if (i_qenvfile.name = '*NONE');
    yenvfile = set0015.set_envfil;
    yenvlib  = set0015.set_envlib;
    yenvmbr  = '*FILE';
  else;
    if (i_qenvfile.name = '*ENVFILE');
      yenvfile = set0015.set_envfil;
      yenvlib  = set0015.set_envlib;
      yenvmbr  = '*FILE';
    else;
      yenvfile = i_qenvfile.name;
      yenvlib  = i_qenvfile.lib;
      yenvmbr  = i_envmbr;
    endif;
    if (i_envlayout = bTrue);
      yoption = '*SLCLAYOUT';
    else;
      yoption = '*SLCENV';
    endif;
    exsr loadenv;
    if (yMsgId = 'CPF9815'); // Teildatei nicht gefunden
      yMsgID = '';
      yMsgDta = '';
    endif;
  endif;

  // - Ermitteln der Attribute der geöffneten Datei
  exsr getopnfile;
  exsr getmaxseq;

  //  Wenn eine Datei geöffnet werden konnte, ...
  if (isOpen = bTrue);
    //  ... dann
    //      abspeichern *PRVFILE
    set0014.set_prvfil  = ##file;
    set0014.set_prvlib  = ##library;
    set0014.set_prvmbr  = ##member;
    p_updusrsg('*PRVFILE' : set0014);
  endif;

  // - Subfile füllen
  exsr pbInit;
  exsr c_top;

  // - Copyright
  clear usr9999;
  usr9999.var1 = COPYRIGHT;
  usr9999.var2 = RELEASE;
  p_sndpgmmg('USR9999': usr9999: sds.pgmname);

endsr;

//============================================================*
//    InzSr        Programminitialisierung                    *
//============================================================*

begsr inzsr;

  if (isinzsr = bTrue);
    leavesr;
  endif;

  isinzsr = bTrue;

  PGMQ = '*';

  peek01_name = f_pgmcalln('PEEK01');
  peek03_name = f_pgmcalln('PEEK03');
  peek04_name = f_pgmcalln('PEEK04');
  peek06_name = f_pgmcalln('PEEK06');
  peek07_name = f_pgmcalln('PEEK07');
  peek08_name = f_pgmcalln('PEEK08');
  peek09_name = f_pgmcalln('PEEK09');
  peek10_name = f_pgmcalln('PEEK10');
  peek12_name = f_pgmcalln('PEEK12');
  peek13_name = f_pgmcalln('PEEK13');
  peek14_name = f_pgmcalln('PEEK14');
  peek17_name = f_pgmcalln('PEEK17');
  peek18_name = f_pgmcalln('PEEK18');
  peek19_name = f_pgmcalln('PEEK19');
  peek20_name = f_pgmcalln('PEEK20');
  peek21_name = f_pgmcalln('PEEK21');
  peek23_name = f_pgmcalln('PEEK23');
  peek24_name = f_pgmcalln('PEEK24');
  peek26_name = f_pgmcalln('PEEK26');
  peek27_name = f_pgmcalln('PEEK27');
  peek30_name = f_pgmcalln('PEEK30');
  peek32_name = f_pgmcalln('PEEK32');
  peek33_name = f_pgmcalln('PEEK33');
  peek34_name = f_pgmcalln('PEEK34');
  peek37_name = f_pgmcalln('PEEK37');
  peek38_name = f_pgmcalln('PEEK38');
  peek40_name = f_pgmcalln('PEEK40');
  peek41_name = f_pgmcalln('PEEK41');
  peek42_name = f_pgmcalln('PEEK42');
  peek47_name = f_pgmcalln('PEEK47');
  peek48_name = f_pgmcalln('PEEK48');
  peek49_name = f_pgmcalln('PEEK49');
  peek50_name = f_pgmcalln('PEEK50');
  peek52_name = f_pgmcalln('PEEK52');
  peek54_name = f_pgmcalln('PEEK54');
  peek55_name = f_pgmcalln('PEEK55');
  peek56_name = f_pgmcalln('PEEK56');
  peek57_name = f_pgmcalln('PEEK57');
  peek59_name = f_pgmcalln('PEEK59');
  peek65_name = f_pgmcalln('PEEK65');
  peek68_name = f_pgmcalln('PEEK68');
  peek69_name = f_pgmcalln('PEEK69');
  exit01_name = f_pgmcalln('EXIT01');
  exit04_name = f_pgmcalln('EXIT04': '*LIBL');

  // - PinTabR clearen
  exsr clrPinTabR;

  // - Versionsabgleich durchführen
  exsr chkversion;

  peek23(sds.pgmname: '*ALL': 8: yFKeys: yNbrOFKeys);
  scrnFKeys = %subarr(yFKeys: 1);

  peek27(sds.pgmname: ychoice: ynbrofch);

endsr;

//============================================================*
//    f_int         Integer Wert                              *
//============================================================*

dcl-proc f_int;
  dcl-pi *n zoned(20);
    inpvalue zoned(25: 5) value;
  end-pi;

  dcl-s integerval zoned(20);

  integerval = inpvalue;

  return integerval;

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
    i_rcdfmt char(10) value;
  end-pi;

  dcl-s isFound like(bool_t) inz(bFalse);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (cio_getfile(hfile00)    <> i_file ) or
     (cio_getlibrary(hfile00) <> i_lib  ) or
     (cio_getmember(hfile00)  <> i_mbr  );
    if (cio_isopen(hfile00) = bTrue);
      cio_close(hfile00);
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

  if (cio_isopen(hfile00) = bFalse);
    if (commitLvl = '1');
      cio_open(hfile00
              : i_file
              : i_lib
              : i_mbr
              : i_rcdfmt
              : 'rr+ , arrseq=Y, commit=Y +
                 nullcap=Y, riofb=Y, +
                 secure=N, ccsid=65535');
    else;
      cio_open(hfile00
              : i_file
              : i_lib
              : i_mbr
              : i_rcdfmt
              : 'rr+ , arrseq=Y, commit=N +
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

  if cio_chainwithrrn(hfile00
                   : i_rrn
                   : bTrue
                   : io_buff
                   : io_nullmap) = bFalse;
    isFound = bTrue;
  else;
    isFound = bFalse;
  endif;

  file#x = cio_getinfds(hfile00);

  return isFound;

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
    i_rcdfmt char(10) value;
  end-pi;

  dcl-s isFound like(bool_t) inz(bFalse);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (cio_getfile(hfile04)    <> i_file ) or
     (cio_getlibrary(hfile04) <> i_lib  ) or
     (cio_getmember(hfile04)  <> i_mbr  );
    if (cio_isopen(hfile04) = bTrue);
      cio_close(hfile04);
    endif;
  endif;

  if (cio_isopen(hfile04) = bFalse);
    cio_open(hfile04
            : i_file
            : i_lib
            : i_mbr
            : i_rcdfmt
            : 'rr , arrseq=Y, +
               nullcap=Y, riofb=Y, ccsid=65535');
  endif;

  if cio_chainwithrrn(hfile04
                   : i_rrn
                   : bFalse
                   : io_buff
                   : io_nullmap) = bFalse;
    isFound = bTrue;
  else;
    isFound = bFalse;
  endif;

  file#x = cio_getinfds(hfile04);

  return isFound;

end-proc;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorHandler;
  dcl-pi *n;
    i_condtoken    likeds(cee_fc_t) value;
    i_pcommarea    int(10) value;
    o_action       int(10);
    o_newcondtoken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

