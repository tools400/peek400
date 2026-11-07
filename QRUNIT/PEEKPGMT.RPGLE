**free
// ==========================================================================
//  Peek/400 - Unit-Tests der Programme PEEK01, PEEK02, PEEK03, PEEK04,
//  PEEK06, PEEK07, PEEK10, PEEK11, PEEK15, PEEK18, PEEK19, PEEK20, PEEK22,
//  PEEK23, PEEK27, PEEK31, PEEK32, PEEK33, PEEK36, PEEK38, PEEK54, PEEK55,
//  PEEK62, PEEK65, PEEK66 und PEEK70, der Serviceprogramme PEEK61 und
//  PEEK71 und der Datei PEEKFMT (iRPGUnit).
//
//  Zum Erstellen und Ausführen muss die Peek-Bibliothek (QCOPYLE,
//  Bindeverzeichnis PEEK, PEEKUSR, PEEKFLD, PEEKFMT, Nachrichtendatei
//  PEEKGER) in der Bibliotheksliste stehen.
//
//  Die Tests legen ihre Testdateien in QTEMP an und überschreiben PEEKFLD
//  mit seinen logischen Dateien und PEEKFMT mit den Kopien in QTEMP. Die
//  Peek-Bibliothek ist die Bibliothek, in der die Datei PEEKUSR in der
//  Bibliotheksliste steht.
// ==========================================================================
//    >>PRE-COMPILER<<
//      >>CRTCMD<<  RUCRTRPG    TSTPGM(&LI/&OB) +
//                              SRCFILE(&SL/&SF) SRCMBR(&SM);
//      >>IMPORTANT<<
//        >>PARM<< BNDDIR(PEEK);
//        >>PARM<< DBGVIEW(*LIST);
//      >>END-IMPORTANT<<
//      >>EXECUTE<<
//    >>END-PRE-COMPILER<<
// ==========================================================================
ctl-opt nomain;
/copy QCOPYLE,H_SPEC

/copy QCOPYLE,D_CLIB
/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,OBJL0200
/copy QCOPYLE,RCDL0200
/copy QCOPYLE,MBRD0200
/copy QCOPYLE,OBJD0100
/copy QCOPYLE,QUSROBJD
/copy QCOPYLE,QUSRJOBI
/copy QCOPYLE,SET0003
/copy QCOPYLE,SET0004
/copy QCOPYLE,SET0007

/define internal_prototype
/copy QCOPYLE,PPEEK01
/copy QCOPYLE,PPEEK02
/copy QCOPYLE,PPEEK03
/copy QCOPYLE,PPEEK04
/copy QCOPYLE,PPEEK06
/copy QCOPYLE,PPEEK07
/copy QCOPYLE,PPEEK10
/copy QCOPYLE,PPEEK11
/copy QCOPYLE,PPEEK13
/copy QCOPYLE,PPEEK15
/copy QCOPYLE,PPEEK18
/copy QCOPYLE,PPEEK19
/copy QCOPYLE,PPEEK20
/copy QCOPYLE,PPEEK22
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK27
/copy QCOPYLE,PPEEK31
/copy QCOPYLE,PPEEK32
/copy QCOPYLE,PPEEK33
/copy QCOPYLE,PPEEK36
/copy QCOPYLE,PPEEK38
/copy QCOPYLE,PPEEK54
/copy QCOPYLE,PPEEK55
/copy QCOPYLE,PPEEK62
/copy QCOPYLE,PPEEK65
/copy QCOPYLE,PPEEK66
/copy QCOPYLE,PPEEK70
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK71
/copy QCOPYLE,PPEEK61

dcl-f peekFld disk keyed usropn extfile('QTEMP/PEEKFLD') prefix(k_) rename(fpeekfld: rpeekfld);

//  Beliebige Datei, nur für die Satzlänge (PEEK62)
dcl-f anyfile disk(32766) usropn infds(anyfile_ds) extfile(g_anyfile);
dcl-ds anyfile_ds likeds(infds_t);
dcl-s g_anyfile char(21);

// --------------------------------------------------------------------------
//  iRPGUnit API. Nicht per QINCLUDE,TESTCASE, weil dessen TEMPLATES
//  ebenso wie D_VARDEF den Typ dataType_t definiert.
// --------------------------------------------------------------------------
dcl-pr aEqual extproc('aEqual') opdesc;
  expected  char(32565) options(*varsize) const;
  actual    char(32565) options(*varsize) const;
  fieldName varchar(64) options(*nopass: *omit) const;
end-pr;

dcl-pr iEqual extproc('iEqual') opdesc;
  expected  zoned(31: 0) const;
  actual    zoned(31: 0) const;
  fieldName varchar(64) options(*nopass: *omit) const;
end-pr;

dcl-pr assert extproc('assert') opdesc;
  condition  ind const;
  msgIfFalse varchar(16384) options(*varsize: *nopass) const;
end-pr;

dcl-pr fail extproc('fail') opdesc;
  msg varchar(16384) options(*varsize: *nopass) const;
end-pr;

dcl-ds rtnMsgInfo_t qualified template;
  id     char(7);
  txt    varchar(256);
  pgm    char(10);
  mod    char(10);
  proc   varchar(256);
  specNb char(10);
end-ds;

dcl-pr getMonitoredMessage likeds(rtnMsgInfo_t) extproc('getMonitoredMessage') opdesc;
  doRmvMsg ind options(*nopass) const;
end-pr;

// --------------------------------------------------------------------------
//  Testumgebung
// --------------------------------------------------------------------------
dcl-c TST_LIB 'QTEMP';
dcl-c TST_FILE 'PEEKKEYS'; // Tabelle mit langem SQL-Spaltennamen
dcl-c TST_CCSID 'PEEKCCSID'; // Tabelle mit nicht umsetzbarer CCSID
dcl-c TST_FLOAT 'PEEKFLOAT'; // Tabelle mit REAL und DOUBLE
dcl-c TST_UTF8 'PEEKUTF8'; // Tabelle mit CHAR CCSID 1208
dcl-c TST_MDY 'PEEKMDY'; // DDS-Datei mit *MDY-Datum, *USA-Zeit
dcl-c TST_EDW 'PEEKEDW'; // DDS-Datei mit langem Editierwort
dcl-c TST_KEY35 'PEEKKEY35'; // Tabelle mit 35 Spalten
dcl-c TST_KEY35I 'PEEKKEY35I'; // Index über alle 35 Spalten
dcl-c TST_ENVF 'PEEKENVT'; // Kopie von PEEKENV (Arbeitsumgebung)
dcl-c TST_ENVM 'PEEKKEYS'; // Teildatei der Arbeitsumgebung
dcl-c TST_FMTID 'PEEKKEYS00001'; // Satzformat-ID für die Umgebung
dcl-c TST_OLDU1 'PEEKOLDU1'; // Einstellungsdatei mit DATA 128
dcl-c TST_OLDU2 'PEEKOLDU2'; // Einstellungsdatei mit KEY 12
dcl-c TST_PRT 'PEEK65T'; // Tabelle für PEEK65, Satz 2 gelöscht
dcl-c TST_LST 'PEEKLST'; // PEEKLST1..3 für die Dateiliste (PEEK70)
dcl-c PEEKUSR_LEN 286; // Satzlänge von PEEKUSR
dcl-c TST_USRF 'PEEKTSTUSR'; // Kopie von PEEKUSR
dcl-c TST_USER 'TESTUSER';

dcl-pr qcmdexc extpgm('QCMDEXC');
  i_cmd    char(32702) options(*varsize) const;
  i_length packed(15: 5) const;
end-pr;

// ==========================================================================
//  Setup
// ==========================================================================

dcl-proc setUpSuite export;
  dcl-s peekLib like(lib_t);

  peekLib = getPeekLib();
  p_setPrdLb(peekLib);

  //  Die Dateien bleiben in QTEMP stehen, wenn die Tests im selben Job
  //  wiederholt werden.
  monitor;
    runCmd('CRTDUPOBJ OBJ(PEEKUSR) FROMLIB(' + %trim(peekLib) + ') +
            OBJTYPE(*FILE) TOLIB(QTEMP) NEWOBJ(PEEKTSTUSR) DATA(*NO)');
  on-error;
  endmon;
  p_setUsr(TST_USER: TST_USRF: TST_LIB);

  //  PEEK01 löscht und schreibt PEEKFLD. PEEK19 und PEEK20 lesen es über
  //  die logischen Dateien, deren Kopien auf QTEMP/PEEKFLD verweisen.
  dupAndOverride(peekLib: 'PEEKFLD');
  dupAndOverride(peekLib: 'PEEKFLDL0');
  dupAndOverride(peekLib: 'PEEKFLDL1');
  dupAndOverride(peekLib: 'PEEKFLDL2');

  //  PEEK10 löscht und schreibt PEEKFMT.
  dupAndOverride(peekLib: 'PEEKFMT');

  monitor;
    runSql('CREATE TABLE QTEMP/PEEKKEYS (KEY CHAR(10) NOT NULL, +
            SEQ NUMERIC(5, 0) NOT NULL, +
            CUSTOMER_NUMBER FOR COLUMN CUSTNBR DECIMAL(7, 0) NOT NULL)');
  on-error;
  endmon;

  monitor;
    runSql('CREATE TABLE QTEMP/PEEKFLOAT (F REAL NOT NULL, +
            D DOUBLE NOT NULL, C CHAR(5) NOT NULL)');
  on-error;
  endmon;

  monitor;
    runSql('CREATE TABLE QTEMP/PEEKUTF8 (U CHAR(10) CCSID 1208 NOT NULL, +
            C CHAR(5) NOT NULL)');
  on-error;
  endmon;

  monitor;
    crtKey35();
  on-error;
  endmon;

  //  Tabelle für PEEK65 mit den Sätzen 1 und 3; Satz 2 ist gelöscht
  monitor;
    runSql('CREATE TABLE QTEMP/' + TST_PRT + ' (ID INTEGER NOT NULL, +
            NAME CHAR(10) NOT NULL, AMOUNT DECIMAL(7, 2) NOT NULL)');
    runSql('INSERT INTO QTEMP/' + TST_PRT + ' VALUES(1, ''EINS'', 1.50), +
            (2, ''ZWEI'', 2.50), (3, ''DREI'', 3.50)');
    runSql('DELETE FROM QTEMP/' + TST_PRT + ' WHERE ID = 2');
  on-error;
  endmon;

  //  Dateien für die Dateiliste von PEEK70
  monitor;
    runSql('CREATE TABLE QTEMP/' + TST_LST + '1 (C CHAR(1))');
    runSql('CREATE TABLE QTEMP/' + TST_LST + '2 (C CHAR(1))');
    runSql('CREATE TABLE QTEMP/' + TST_LST + '3 (C CHAR(1))');
  on-error;
  endmon;

  //  Arbeitsumgebung für PEEK54 und PEEK55
  monitor;
    runCmd('CRTDUPOBJ OBJ(PEEKENV) FROMLIB(' + %trim(peekLib) + ') +
            OBJTYPE(*FILE) TOLIB(QTEMP) NEWOBJ(' + TST_ENVF + ') +
            DATA(*NO)');
  on-error;
  endmon;
  monitor;
    runCmd('ADDPFM FILE(QTEMP/' + TST_ENVF + ') MBR(' + TST_ENVM + ')');
  on-error;
  endmon;
end-proc;

// ==========================================================================
//  PEEK01: Ein Feld, dessen CCSID nicht in die Job-CCSID umgesetzt werden
//  kann (GRAPHIC CCSID 835), darf die Feldliste nicht verhindern.
// ==========================================================================

dcl-proc test01_peek01_unconvertibleCcsid export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-s fmtId like(fmtId_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);
  dcl-s ccsid int(10);

  ccsid = findUnconvertibleCcsid(*on);
  if (ccsid = 0);
    fail('Keine GRAPHIC-CCSID gefunden, die nicht in die Job-CCSID '
         + %char(getJobCcsid()) + ' umgesetzt werden kann.');
  endif;

  qFile.name = TST_CCSID;
  qFile.lib = TST_LIB;

  monitor;
    peek01(qFile: TST_CCSID: fmtId: msgID: msgDta);
  on-error;
    fail('PEEK01 bricht bei GRAPHIC CCSID ' + %char(ccsid) + ' ab: '
         + lastMsg());
  endmon;

  aEqual('': msgID: 'PEEK01 msgid (GRAPHIC CCSID ' + %char(ccsid) + ')');
  aEqual('0': isTranscOf('G'): 'PEEKFLD ISTRANSC des Feldes G');
end-proc;

// ==========================================================================
//  PEEK02: Ein QUSLFLD-Fehler (Satzformat nicht vorhanden) ergibt 0 Felder,
//  ohne Escape-Nachricht und ohne DUMP. Ein weiteres *READ liefert nichts.
// ==========================================================================

dcl-proc test02_peek02_unknownFormat export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds fldl0100 likeds(fldl0100_t) inz;
  dcl-s fmtId like(fmtId_t);
  dcl-s numE like(int4_t);

  qFile.name = TST_FILE;
  qFile.lib = TST_LIB;

  monitor;
    peek02(qFile: 'NOFMT': '*CREATE': numE: fldl0100: fmtId);
    iEqual(0: numE: 'PEEK02 *CREATE mit unbekanntem Satzformat, Anzahl');

    peek02(qFile: 'NOFMT': '*READ': numE: fldl0100: fmtId);
    iEqual(0: numE: 'PEEK02 *READ nach gescheitertem *CREATE, Anzahl');
    aEqual('': fldl0100.f1FNme: 'PEEK02 *READ nach gescheitertem *CREATE');
  on-error;
    fail('PEEK02 bricht ab: ' + lastMsg());
  endmon;
end-proc;

// ==========================================================================
//  PEEK03: SQL-Sortierung über vorhandene Felder. Die Felder werden als
//  Schlüssel markiert und es kommt keine Nachricht USR0006.
// ==========================================================================

dcl-proc test03_peek03_sqlOrder_noUsr0006 export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  qFile.name = TST_FILE;
  qFile.lib = TST_LIB;
  loadFields(qFile);

  peek03(qFile: TST_FILE: SQL_SEQ: '"KEY" DESC, "SEQ"': msgID: msgDta);

  iEqual(1: kseqOf('KEY'): 'KSEQ von KEY');
  iEqual(2: kseqOf('SEQ'): 'KSEQ von SEQ');
  aEqual('': msgID: 'PEEK03 msgid bei ORDER BY "KEY" DESC, "SEQ"');
end-proc;

// ==========================================================================
//  PEEK03: SQL-Sortierung über den langen SQL-Namen einer Spalte. Das Feld
//  ist in PEEKFLD unter dem Systemnamen CUSTNBR gespeichert.
// ==========================================================================

dcl-proc test04_peek03_sqlOrder_longName export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  qFile.name = TST_FILE;
  qFile.lib = TST_LIB;
  loadFields(qFile);

  peek03(qFile: TST_FILE: SQL_SEQ: '"CUSTOMER_NUMBER", "KEY"'
         : msgID: msgDta);

  iEqual(1: kseqOf('CUSTNBR')
         : 'KSEQ von CUSTNBR nach ORDER BY "CUSTOMER_NUMBER"');
  iEqual(2: kseqOf('KEY'): 'KSEQ von KEY');
  aEqual('': msgID: 'PEEK03 msgid');
end-proc;

// ==========================================================================
//  PEEK04: Datei nicht vorhanden. Ohne Nachricht nimmt PEEK05 an, dass es
//  Schlüsselfelder gibt.
// ==========================================================================

dcl-proc test05_peek04_fileNotFound export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  qFile.name = 'NOFILE';
  qFile.lib = TST_LIB;

  monitor;
    peek04(qFile: 'NOFILE': msgID: msgDta);
  on-error;
    fail('PEEK04 bricht ab: ' + lastMsg());
  endmon;

  aEqual('USR0006': msgID
         : 'PEEK04 msgid für eine nicht vorhandene Datei');
end-proc;

// ==========================================================================
//  PEEK06: Gleitkommawerte mit 4 Nachkommastellen nur, wenn dabei keine
//  Ziffern verloren gehen, sonst mit Exponent.
// ==========================================================================

dcl-proc test06_peek06_float export;
  dcl-s f4 float(4);
  dcl-s f8 float(8);
  dcl-s small4 varchar(64);
  dcl-s long8 varchar(64);

  f4 = 1.2345E-5;
  small4 = editFloat(%addr(f4): 4);

  f8 = 1.23456789;
  long8 = editFloat(%addr(f8): 8);

  assert(%scan('12345': digitsOf(small4)) > 0
         : 'REAL 1.2345E-5 -> ''' + small4 + '''');
  assert(%scan('123456789': digitsOf(long8)) > 0
         : 'DOUBLE 1.23456789 -> ''' + long8 + '''');

  //  Unverändert: Werte, die mit 4 Nachkommastellen exakt sind
  f4 = 1.5;
  aEqual('1,5000': %trim(editFloat(%addr(f4): 4)): 'REAL 1.5');
  f8 = 1234.56;
  aEqual('1234,5600': %trim(editFloat(%addr(f8): 8)): 'DOUBLE 1234.56');
  f8 = -0.25;
  aEqual('-0,2500': %trim(editFloat(%addr(f8): 8)): 'DOUBLE -0.25');
end-proc;

// ==========================================================================
//  PEEK06: Sonderwerte Inf und NaN mit beliebigem Vorzeichen und beliebiger
//  Mantisse.
// ==========================================================================

dcl-proc test07_peek06_specialValues export;
  dcl-s buf4 char(4);
  dcl-s buf8 char(8);

  buf4 = x'7F800000';
  aEqual('*Inf': editFloat(%addr(buf4): 4): '+Inf (REAL)');
  buf4 = x'FF800000';
  aEqual('-*Inf': editFloat(%addr(buf4): 4): '-Inf (REAL)');
  buf4 = x'7FC00000';
  aEqual('*NaN': editFloat(%addr(buf4): 4): 'NaN (REAL)');
  buf4 = x'FFC00000';
  aEqual('*NaN': editFloat(%addr(buf4): 4): '-NaN (REAL)');
  buf4 = x'7F800001';
  aEqual('*NaN': editFloat(%addr(buf4): 4): 'sNaN (REAL)');

  buf8 = x'7FF0000000000000';
  aEqual('*Inf': editFloat(%addr(buf8): 8): '+Inf (DOUBLE)');
  buf8 = x'FFF0000000000000';
  aEqual('-*Inf': editFloat(%addr(buf8): 8): '-Inf (DOUBLE)');
  buf8 = x'7FF8000000000000';
  aEqual('*NaN': editFloat(%addr(buf8): 8): 'NaN (DOUBLE)');
  buf8 = x'FFF0000000000001';
  aEqual('*NaN': editFloat(%addr(buf8): 8): '-sNaN (DOUBLE)');
end-proc;

// ==========================================================================
//  PEEK06: Passen Edit-Code oder Edit-Wort nicht zum Feld, wird der Wert
//  mit Edit-Code L angezeigt, nicht als x'00' in der Länge des vorherigen
//  Feldes.
// ==========================================================================

dcl-proc test08_peek06_invalidEditCode export;
  dcl-s p5 packed(5: 0);
  dcl-s p15 packed(15: 0);
  dcl-s result varchar(64);

  //  Zuerst ein gültiger Aufruf (5 Stellen, Edit-Code J).
  p5 = 12345;
  result = editPacked(%addr(p5): 5: 'J': '');
  aEqual('12.345': %trim(result): 'Edit-Code J, 5 Stellen ' + hexOf(result));

  //  15 Stellen mit Edit-Code Y.
  p15 = 123456789012345;
  result = editPacked(%addr(p15): 15: 'Y': '');
  aEqual('123456789012345': %trim(result)
         : 'Edit-Code Y, 15 Stellen ' + hexOf(result));

  //  15 Stellen mit einem Edit-Wort für 3 Stellen.
  result = editPacked(%addr(p15): 15: ' ': '  0 ');
  aEqual('123456789012345': %trim(result)
         : 'Edit-Wort ''  0 '', 15 Stellen ' + hexOf(result));
end-proc;

// ==========================================================================
//  PEEK07: unbekanntes Netzwerkattribut. Länge 0, kein Abbruch, kein DUMP.
// ==========================================================================

dcl-proc test09_peek07_invalidAttribute export;
  dcl-s attrLen like(int4_t);
  dcl-s attrTyp like(attrType_t);
  dcl-s attrVal like(attrValue_t);

  monitor;
    peek07('NOTEXIST': bTrue: attrLen: attrTyp: attrVal);
  on-error;
    fail('PEEK07 bricht bei einem unbekannten Attribut ab: ' + lastMsg());
  endmon;

  iEqual(0: attrLen: 'PEEK07 Länge bei unbekanntem Attribut');

  peek07('SYSNAME': bTrue: attrLen: attrTyp: attrVal);
  iEqual(8: attrLen: 'PEEK07 Länge von SYSNAME');
end-proc;

// ==========================================================================
//  PEEK71: Ein gescheitertes Transcoder_new() darf keinen Platz in der
//  Transcoder-Liste belegen, sonst lässt sich nach 64 gescheiterten
//  Versuchen kein Transcoder mehr anlegen.
// ==========================================================================

dcl-proc test10_peek71_failedTranscoderUsesSlot export;
  dcl-s ccsid int(10);
  dcl-s i int(10);
  dcl-s failures int(10);
  dcl-s hTranscoder like(hTranscoder_t);
  dcl-ds msg likeds(rtnMsgInfo_t);

  ccsid = findUnconvertibleCcsid(*off);
  if (ccsid = 0);
    fail('Keine CCSID gefunden, die nicht in die Job-CCSID '
         + %char(getJobCcsid()) + ' umgesetzt werden kann.');
  endif;

  for i = 1 to 70;
    monitor;
      hTranscoder = Transcoder_toJobCcsid(ccsid);
    on-error;
      msg = getMonitoredMessage(*on);
      if (%scan('Maximum number': msg.txt) = 1);
        leave;
      endif;
      failures += 1;
    endmon;
  endfor;

  monitor;
    hTranscoder = Transcoder_toJobCcsid(37);
  on-error;
    fail('transcoder_tojobccsid(37) scheitert nach ' + %char(failures)
         + ' gescheiterten Aufrufen mit CCSID ' + %char(ccsid) + ': '
         + lastMsg());
  endmon;

  iEqual(70: failures: 'Aufrufe mit CCSID ' + %char(ccsid)
         + ', die ohne "Maximum number of transcoders reached." scheitern');
end-proc;

// ==========================================================================
//  PEEK11: Ein gescheitertes *CREATE (Datei nicht vorhanden) ergibt 0
//  Satzformate ohne Escape-Nachricht und ohne DUMP. Ein *READ danach darf
//  nicht die vorherige Liste weiterlesen.
// ==========================================================================

dcl-proc test11_peek11_failedCreate export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds rcdl0200 likeds(rcdl0200_t) inz;
  dcl-s numE like(int4_t);

  qFile.name = TST_FILE;
  qFile.lib = TST_LIB;
  peek11(qFile: '*CREATE': numE: rcdl0200);
  iEqual(1: numE: 'PEEK11 *CREATE für ' + TST_FILE + ', Anzahl');

  qFile.name = 'NOFILE';
  monitor;
    peek11(qFile: '*CREATE': numE: rcdl0200);
  on-error;
    fail('PEEK11 *CREATE für NOFILE bricht ab: ' + lastMsg());
  endmon;
  iEqual(0: numE: 'PEEK11 *CREATE für NOFILE, Anzahl');

  peek11(qFile: '*READ': numE: rcdl0200);
  aEqual('': rcdl0200.r2FmtName
         : 'PEEK11 *READ nach gescheitertem *CREATE, Satzformat');
end-proc;

// ==========================================================================
//  PEEK10: Datei nicht vorhanden. PEEK10 meldet USR0002 ("Liste der
//  Satzformate ... konnte nicht abgerufen werden"), PEEK05 bricht dann
//  das Öffnen ab.
// ==========================================================================

dcl-proc test12_peek10_unknownFile export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  qFile.name = 'NOFILE';
  qFile.lib = TST_LIB;

  monitor;
    peek10(qFile: msgID: msgDta);
  on-error;
    fail('PEEK10 bricht ab: ' + lastMsg());
  endmon;

  aEqual('USR0002': msgID: 'PEEK10 msgid für NOFILE');
end-proc;

// ==========================================================================
//  PEEKFMT: PEEK10 leert PEEKFMT bei jedem Aufruf und schreibt die
//  Satzformate neu. Mit REUSEDLT(*YES) (CRTPEEKOBJ) sammeln sich dabei
//  keine gelöschten Sätze an.
// ==========================================================================

dcl-proc test13_peekfmt_reuseDeletedRecords export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds qfmt likeds(qObj_t) inz;
  dcl-ds mbrd0200 likeds(mbrd0200_t) inz;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);
  dcl-s i int(10);

  qFile.name = TST_FILE;
  qFile.lib = TST_LIB;
  for i = 1 to 3;
    peek10(qFile: msgID: msgDta);
  endfor;

  qfmt.name = 'PEEKFMT';
  qfmt.lib = TST_LIB;
  peek13(qfmt: '*FIRST': mbrd0200);

  iEqual(1: mbrd0200.m2NbrRcdOn: 'Sätze in PEEKFMT nach 3 x PEEK10');
  iEqual(0: mbrd0200.m2NbrRcdDl
         : 'Gelöschte Sätze in PEEKFMT nach 3 x PEEK10 (REUSEDLT(*YES)?)');
end-proc;

// ==========================================================================
//  PEEK18: Ein Schlüsselfeld, dessen CCSID nicht in die Job-CCSID umgesetzt
//  werden kann (GRAPHIC CCSID 835), darf PEEK18 und damit PEEK19, PEEK20
//  und PEEK05 nicht abbrechen. Die Längen bleiben die, mit denen PEEK20
//  rechnet: extern ein Zeichen je Grafikzeichen, intern die Feldlänge.
// ==========================================================================

dcl-proc test14_peek18_unconvertibleCcsid export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds fldl0100 likeds(fldl0100_t) inz;
  dcl-ds set0003 likeds(set0003_t) inz;
  dcl-s buffer like(rcdBuf_t);
  dcl-s outBuf like(rcdBuf_t);
  dcl-s outLen like(int4_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);
  dcl-s ccsid int(10);

  ccsid = findUnconvertibleCcsid(*on);
  if (ccsid = 0);
    fail('Keine GRAPHIC-CCSID gefunden, die nicht in die Job-CCSID '
         + %char(getJobCcsid()) + ' umgesetzt werden kann.');
  endif;

  qFile.name = TST_CCSID;
  qFile.lib = TST_LIB;
  setKeys(qFile: '"G"');
  fldl0100 = fieldOf('G');
  set0003 = f_getUsrSg('*ACCESSKEY');

  buffer = *allx'40';
  monitor;
    peek18(fldl0100: TST_CCSID: buffer: '*EXTERN': '*CURRENT'
           : outBuf: outLen: msgID: msgDta);
  on-error;
    fail('PEEK18 *EXTERN bricht bei GRAPHIC CCSID ' + %char(ccsid)
         + ' ab: ' + lastMsg());
  endmon;
  iEqual(5 + %len(%trimr(set0003.set_dlmtr)): outLen
         : 'PEEK18 *EXTERN Länge von GRAPHIC(5) mit Trennzeichen');

  buffer = *allx'40';
  monitor;
    peek18(fldl0100: TST_CCSID: buffer: '*INTERN': '*CURRENT'
           : outBuf: outLen: msgID: msgDta);
  on-error;
    fail('PEEK18 *INTERN bricht bei GRAPHIC CCSID ' + %char(ccsid)
         + ' ab: ' + lastMsg());
  endmon;
  iEqual(10: outLen: 'PEEK18 *INTERN Länge von GRAPHIC(5)');
end-proc;

// ==========================================================================
//  PEEK19 und PEEK20: Hinter einem REAL- oder DOUBLE-Schlüsselfeld liest
//  PEEK20 das nächste Feld dort, wo PEEK19 es abgelegt hat (Breite von
//  %editflt, nicht die Feldlänge 4 oder 8).
// ==========================================================================

dcl-proc test15_peek20_floatKey export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds rcd qualified inz;
    f float(4);
    d float(8);
    c char(5);
  end-ds;
  dcl-s buffer like(rcdBuf_t);
  dcl-s keyVal like(keyBuf_t);
  dcl-s keyBuf like(rcdBuf_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  qFile.name = TST_FLOAT;
  qFile.lib = TST_LIB;
  setKeys(qFile: '"F", "D", "C"');

  rcd.f = 1.5;
  rcd.d = -2.25;
  rcd.c = 'ABCDE';
  buffer = rcd;

  peek19(buffer: keyVal: msgID: msgDta);
  peek20(keyVal: keyBuf: msgID: msgDta);
  aEqual('': msgID: 'PEEK20 msgid');

  rcd = keyBuf;
  assert(rcd.f = 1.5: 'F nach PEEK19/PEEK20 ist ' + %char(rcd.f)
         + ', Schlüssel ''' + %trimr(keyVal) + '''');
  assert(rcd.d = -2.25: 'D nach PEEK19/PEEK20 ist ' + %char(rcd.d)
         + ', Schlüssel ''' + %trimr(keyVal) + '''');
  aEqual('ABCDE': rcd.c: 'C nach PEEK19/PEEK20 (REAL und DOUBLE davor)');
end-proc;

// ==========================================================================
//  PEEK19 und PEEK20 mit CHAR(10) CCSID 1208 = 'ÄÖÜ': Der externe Teil ist
//  10 Zeichen breit, obwohl 'ÄÖÜ' in UTF-8 nur 6 Bytes belegt, und PEEK20
//  macht daraus wieder genau 10 Bytes.
// ==========================================================================

dcl-proc test16_peek20_utf8Key export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds set0003 likeds(set0003_t) inz;
  dcl-s buffer like(rcdBuf_t);
  dcl-s keyVal like(keyBuf_t);
  dcl-s keyBuf like(rcdBuf_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  qFile.name = TST_UTF8;
  qFile.lib = TST_LIB;
  setKeys(qFile: '"U", "C"');
  set0003 = f_getUsrSg('*ACCESSKEY');

  //  U = 'ÄÖÜ' in UTF-8 und 4 Leerzeichen, C = 'ABCDE'
  buffer = x'C384C396C39C20202020' + 'ABCDE';

  peek19(buffer: keyVal: msgID: msgDta);
  iEqual(10 + %len(%trimr(set0003.set_dlmtr)) + 1: %scan('ABCDE': keyVal)
         : 'Position von C im externen Schlüssel');

  peek20(keyVal: keyBuf: msgID: msgDta);
  aEqual(hexOf(%subst(buffer: 1: 15)): hexOf(%subst(keyBuf: 1: 15))
         : 'Schlüssel nach PEEK19/PEEK20');
end-proc;

// ==========================================================================
//  PEEK18 und PEEK20 lesen *ACCESSKEY bei jedem Aufruf: Nach einer
//  Änderung (ohne Vorzeichen, Trennzeichen |) passen PEEK19 und PEEK20
//  sofort zusammen.
// ==========================================================================

dcl-proc test17_peek18_accessKeyChanged export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds rcd qualified inz;
    f float(4);
    d float(8);
    c char(5);
  end-ds;
  dcl-ds orig likeds(set0003_t) inz;
  dcl-ds chg likeds(set0003_t) inz;
  dcl-s buffer like(rcdBuf_t);
  dcl-s keyVal like(keyBuf_t);
  dcl-s keyBuf like(rcdBuf_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);
  dcl-s expected varchar(64);

  qFile.name = TST_FLOAT;
  qFile.lib = TST_LIB;
  setKeys(qFile: '"F", "D", "C"');

  rcd.f = 1.5;
  rcd.d = 2.25;
  rcd.c = 'ABCDE';
  buffer = rcd;

  //  Erst mit der bisherigen Einstellung, damit PEEK18 und PEEK20 sie
  //  schon einmal gelesen haben.
  orig = f_getUsrSg('*ACCESSKEY');
  peek19(buffer: keyVal: msgID: msgDta);
  peek20(keyVal: keyBuf: msgID: msgDta);

  chg = orig;
  chg.set_signX = bFalse;
  chg.set_dlmtr = '|';
  p_updUsrSg('*ACCESSKEY': chg);
  monitor;
    peek19(buffer: keyVal: msgID: msgDta);
    peek20(keyVal: keyBuf: msgID: msgDta);
  on-error;
    p_updUsrSg('*ACCESSKEY': orig);
    fail('PEEK19/PEEK20 brechen nach Änderung von *ACCESSKEY ab: '
         + lastMsg());
  endmon;
  p_updUsrSg('*ACCESSKEY': orig);

  //  %editflt ohne führendes Vorzeichen (PEEK18 f_to_extern)
  expected = %subst(%editflt(rcd.f): 2) + '|'
           + %subst(%editflt(rcd.d): 2) + '|ABCDE|';
  aEqual(expected: %trimr(keyVal): 'PEEK19 ohne Vorzeichen, Trennzeichen |');

  rcd = keyBuf;
  aEqual('ABCDE': rcd.c: 'C nach PEEK20 ohne Vorzeichen, Trennzeichen |');
end-proc;

// ==========================================================================
//  PEEK36: Datums- und Zeitwerte in allen Formaten werden angenommen, ein
//  ungültiger Wert ergibt USR8242 statt eines Abbruchs (RNQ0112).
// ==========================================================================

dcl-proc test18_peek36_dateTimeFormats export;
  chkPeek36('L': '*ISO': '-': '2026-11-04': '');
  chkPeek36('L': '*EUR': '.': '04.11.2026': '');
  chkPeek36('L': '*USA': '/': '11/04/2026': '');
  chkPeek36('L': '*JIS': '-': '2026-11-04': '');
  chkPeek36('L': '*MDY': '/': '11/04/26': '');
  chkPeek36('L': '*DMY': '.': '04.11.26': '');
  chkPeek36('L': '*YMD': '-': '26-11-04': '');
  chkPeek36('L': '*JUL': '/': '26/308': '');
  chkPeek36('T': '*ISO': '.': '13.45.00': '');
  chkPeek36('T': '*EUR': '.': '13.45.00': '');
  chkPeek36('T': '*HMS': ':': '13:45:00': '');
  chkPeek36('T': '*USA': ':': '01:45 PM': '');
  chkPeek36('T': '*JIS': ':': '13:45:00': '');

  chkPeek36('L': '*MDY': '/': '13/45/26': 'USR8242');
  chkPeek36('L': '*MDY': '/': '9999-12-': 'USR8242');
  chkPeek36('T': '*USA': ':': '13:45:00': 'USR8242');
end-proc;

// ==========================================================================
//  PEEK20/PEEK18: Der Pseudo-Datensatz für die Überschrift (PEEK05 beim
//  Öffnen der Datei) enthält *HIVAL/*LOVAL im Format der Felder. Bisher
//  brach PEEK36 bei einem *MDY-Datum mit RNQ0112 ab.
// ==========================================================================

dcl-proc test19_peek20_mdyDatePseudoRecord export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-s buffer like(rcdBuf_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  crtDdsFile(TST_MDY
             : '     A          R PEEKMDY'
             : '     A            ID             5S 0'
             : '     A            DMDY            L         +
DATFMT(*MDY) DATSEP(''/'')'
             : '     A            TUSA            T         TIMFMT(*USA)'
             : '     A          K ID');

  qFile.name = TST_MDY;
  qFile.lib = TST_LIB;
  loadFields(qFile);

  monitor;
    peek20('*PHIVAL': buffer: msgID: msgDta);
  on-error;
    fail('PEEK20 *PHIVAL bricht bei *MDY/*USA ab: ' + lastMsg());
  endmon;
  aEqual('': msgID: 'PEEK20 *PHIVAL msgid');
  chkMdyUsa(buffer: '*PHIVAL');

  monitor;
    peek20('*PLOVAL': buffer: msgID: msgDta);
  on-error;
    fail('PEEK20 *PLOVAL bricht bei *MDY/*USA ab: ' + lastMsg());
  endmon;
  aEqual('': msgID: 'PEEK20 *PLOVAL msgid');
  chkMdyUsa(buffer: '*PLOVAL');
end-proc;

//  Felder ohne Schlüssel gelten in PEEK18 als absteigend, *HIVAL und
//  *LOVAL tauschen dort. Geprüft wird deshalb nur, dass DMDY und TUSA
//  einen der beiden Grenzwerte im Format des Feldes enthalten.
dcl-proc chkMdyUsa;
  dcl-pi *n;
    i_buffer like(rcdBuf_t) const;
    i_value  varchar(7) const;
  end-pi;

  dcl-ds rcd qualified inz;
    id   zoned(5: 0);
    dmdy char(8);
    tusa char(8);
  end-ds;
  //  Zur Laufzeit umsetzen wie PEEK18: 00.00.00 ist dann '12:00 AM'
  dcl-s timeLo time(*iso) inz(T'00.00.00');
  dcl-s timeHi time(*iso) inz(T'23.59.59');

  rcd = i_buffer;
  assert(rcd.dmdy = '12/31/39' or rcd.dmdy = '01/01/40'
         : 'DMDY bei ' + i_value + ' ist ''' + rcd.dmdy
         + ''', erwartet 12/31/39 oder 01/01/40');
  assert(rcd.tusa = %char(timeHi: *usa) or
         rcd.tusa = %char(timeLo: *usa)
         : 'TUSA bei ' + i_value + ' ist ''' + rcd.tusa + ''', erwartet '''
         + %char(timeHi: *usa) + ''' oder ''' + %char(timeLo: *usa) + '''');
end-proc;

// ==========================================================================
//  PEEK15: Ein Editierwort mit mehr als 26 Zeichen passt nicht in eine
//  Zeile des Schlüsselwortbereichs (36 Stellen). PEEK15 verteilt es auf
//  Folgezeilen, statt mit RNX0100 abzubrechen, und CRTDSPF nimmt die
//  erzeugte Bildschirmdatei an.
// ==========================================================================

dcl-proc test20_peek15_longEditWord export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-s scnNbrs like(int2_t);
  dcl-s stage like(int4_t);
  dcl-s peekLib like(lib_t);
  dcl-s mbr char(10);
  dcl-s i int(10);
  dcl-s prefixes char(7) inz('FABCDEG');

  //  AMOUNT 21P 2 mit einem Editierwort von 29 Zeichen
  crtDdsFile(TST_EDW
             : '     A          R PEEKEDW'
             : '     A            ID             5S 0'
             : '     A            AMOUNT        21P 2       +
EDTWRD('' .   .   .   .   .   .  0, -'
             : '     A                                       -'')');

  qFile.name = TST_EDW;
  qFile.lib = TST_LIB;
  loadFields(qFile);

  //  Quellteildateien und Overrides wie PEEK08
  monitor;
    runCmd('CRTSRCPF FILE(QTEMP/QPEEKGEN) RCDLEN(112) MBR(*NONE)');
  on-error;
  endmon;
  for i = 1 to 7;
    mbr = %subst(prefixes: i: 1) + 'EDW';
    monitor;
      runCmd('ADDPFM FILE(QTEMP/QPEEKGEN) MBR(' + %trim(mbr) + ')');
    on-error;
    endmon;
    runCmd('CLRPFM FILE(QTEMP/QPEEKGEN) MBR(' + %trim(mbr) + ')');
  endfor;

  peekLib = getPeekLib();
  runCmd('OVRDBF FILE(QPEEKGEN) TOFILE(QTEMP/QPEEKGEN) MBR(FEDW) +
          OVRSCOPE(*JOB) SHARE(*NO)');
  for i = 1 to 6;
    runCmd('OVRDBF FILE(QCOPYLE' + %char(i) + ') TOFILE(QTEMP/QPEEKGEN) +
            MBR(' + %subst(prefixes: i + 1: 1) + 'EDW) +
            OVRSCOPE(*JOB) SHARE(*NO)');
  endfor;
  runCmd('OVRDBF FILE(PEEKSRC) TOFILE(' + %trim(peekLib) + '/PEEKSRC) +
          MBR(DSPF) OVRSCOPE(*JOB) SHARE(*NO)');

  scnNbrs = 0;
  stage = 0;
  monitor;
    peek15(qFile: scnNbrs: bFalse: stage: 10);
  on-error;
    dltOvrPeek15();
    fail('PEEK15 bricht beim Editierwort mit 29 Zeichen ab: ' + lastMsg());
  endmon;
  dltOvrPeek15();

  monitor;
    runCmd('CRTDSPF FILE(QTEMP/FEDW) SRCFILE(QTEMP/QPEEKGEN) +
            SRCMBR(FEDW) REPLACE(*YES)');
  on-error;
    fail('CRTDSPF der von PEEK15 erzeugten DDS scheitert: ' + lastMsg());
  endmon;

  iEqual(1: scnNbrs: 'PEEK15 Anzahl Bildschirme');
end-proc;

// ==========================================================================
//  PEEK22: *REPLACE ersetzt alle Schlüssel eines Bereichs, auch '*ENTER'
//  und die *PGM-Einstellungen, die vor '*F01' sortiert werden.
// ==========================================================================

dcl-proc test21_peek22_replaceResetsAll export;
  dcl-s errors varchar(1024) inz;

  setUsrData('*PEEK05': '*ENTER': '*CHANGED');
  setUsrData('*PEEK05': '*F05': '*CHANGED');
  setUsrData('*PGM': '*DSPATTR': '*CHANGED');
  setUsrData('*PGM': '*LANGUAGE': '*CHANGED');

  peek22('*REPLACE': '*ALL');

  errors += chkUsrReset('*PEEK05': '*ENTER');
  errors += chkUsrReset('*PEEK05': '*F05');
  errors += chkUsrReset('*PGM': '*DSPATTR');
  errors += chkUsrReset('*PGM': '*LANGUAGE');

  assert(errors = '': 'Von *REPLACE nicht zurückgesetzt:' + errors);
end-proc;

// ==========================================================================
//  PEEK23: Tasten außer F1 bis F24 werden mit ihrem Namen beschriftet
//  ('*ENTER' ergab 'ETER').
// ==========================================================================

dcl-proc test22_peek23_enterLabel export;
  dcl-s fkeys like(fKeyDsp_t) dim(32);
  dcl-s n like(int4_t);

  //  PEEK59: *OK liegt standardmäßig auf Enter
  peek22('*REPLACE': '*PEEK59');

  peek23('PEEK59': '*OK': 0: fkeys: n);

  iEqual(1: n: 'Anzahl Tasten für *OK');
  aEqual('ENTER=': %subst(fkeys(1): 1: 6): 'Beschriftung für *OK');
end-proc;

// ==========================================================================
//  PEEK23: Ohne Taste für *MOREKEYS werden keine Plätze für
//  "F24=Weitere Tasten" reserviert.
// ==========================================================================

dcl-proc test23_peek23_noGapWithoutMoreKeys export;
  dcl-s fkeys like(fKeyDsp_t) dim(32);
  dcl-s n like(int4_t);
  dcl-s i like(int4_t);
  dcl-s gaps varchar(256) inz;

  peek22('*REPLACE': '*PEEK14');
  f_deletUsr('*PEEK14': '*F24');

  peek23('PEEK14': '*ALL': 3: fkeys: n);

  for i = 1 to n;
    if (fkeys(i) = '');
      gaps += ' ' + %char(i);
    endif;
  endfor;

  assert(n > 0: 'Keine Tasten für PEEK14.');
  assert(gaps = '': 'Leere Plätze in der Tastenleiste:' + gaps);
end-proc;

// ==========================================================================
//  PEEK23: Bei 3 Tasten pro Seite, 21 Tasten und F24 läge der F24-Platz
//  der letzten Seite hinter der Liste (Platz 33, MCH0603).
// ==========================================================================

dcl-proc test24_peek23_manyKeysNoOverflow export;
  dcl-s fkeys like(fKeyDsp_t) dim(32);
  dcl-s n like(int4_t);
  dcl-s i like(int4_t);
  dcl-s key like(key_t);
  dcl-s data like(set0000_t);

  peek22('*REPLACE': '*PEEK14');
  for i = 1 to 24;
    key = '*F' + %editc(%dec(i: 2: 0): 'X');
    f_deletUsr('*PEEK14': key);
  endfor;

  for i = 1 to 21;
    key = '*F' + %editc(%dec(i: 2: 0): 'X');
    data = '*REFRESH';
    f_writeUsr('*PEEK14': key: data);
  endfor;
  data = '*MOREKEYS';
  f_writeUsr('*PEEK14': '*F24': data);

  monitor;
    peek23('PEEK14': '*ALL': 3: fkeys: n);
  on-error;
    fail('PEEK23 bricht bei 21 Tasten und F24 ab: ' + lastMsg());
  endmon;

  assert(n <= %elem(fkeys): 'Anzahl Tasten > 32: ' + %char(n));
end-proc;

// ==========================================================================
//  PEEK23: Mit F24=*MOREKEYS steht auf jedem 3. Platz "F24=...".
// ==========================================================================

dcl-proc test25_peek23_moreKeysEveryThird export;
  dcl-s fkeys like(fKeyDsp_t) dim(32);
  dcl-s n like(int4_t);
  dcl-s i like(int4_t);
  dcl-s errors varchar(1024) inz;

  peek22('*REPLACE': '*PEEK14');

  peek23('PEEK14': '*ALL': 3: fkeys: n);

  for i = 1 to n;
    if (fkeys(i) = '');
      errors += ' leer:' + %char(i);
    elseif (%rem(i: 3) = 0 and %subst(fkeys(i): 1: 4) <> 'F24=');
      errors += ' kein F24:' + %char(i);
    endif;
  endfor;

  assert(n > 0: 'Keine Tasten für PEEK14.');
  assert(errors = '': 'Tastenleiste PEEK14:' + errors);
end-proc;

// ==========================================================================
//  PEEK27: Ein Befehl ohne Nachrichtentext zeigt '???' statt des Textes
//  der Auswahl davor.
// ==========================================================================

dcl-proc test26_peek27_textOfCmdWithoutMsg export;
  dcl-s choices like(choice_t) dim(32);
  dcl-s n like(int4_t);
  dcl-s data like(set0000_t);

  peek22('*REPLACE': '*PEEK37');
  data = '*NOTEXT';
  f_writeUsr('*PEEK37': '2': data);

  peek27('PEEK37': choices: n);

  assert(%scan('  2=???': choices(1)) > 0
         : 'Option 2 ohne Text: ''' + %trimr(choices(1)) + '''');
end-proc;

// ==========================================================================
//  PEEK27: Ausschlüsse gelten auch für Auswahlen mit Buchstaben.
// ==========================================================================

dcl-proc test27_peek27_exclusionLetterOption export;
  dcl-s choices like(choice_t) dim(32);
  dcl-s n like(int4_t);
  dcl-s excl like(pgmCmd_t) dim(25);
  dcl-s data like(set0000_t);
  dcl-s all varchar(2500) inz;
  dcl-s i like(int4_t);

  //  PEEK56: Option 2 und zusätzlich L mit *SLCLAYOUT
  peek22('*REPLACE': '*PEEK56');
  data = '*SLCLAYOUT';
  f_writeUsr('*PEEK56': 'L': data);
  excl(1) = '*SLCLAYOUT';

  peek27('PEEK56': choices: n: excl);

  for i = 1 to n;
    all += ' ' + %trimr(choices(i));
  endfor;

  assert(%scan(' 1=': all) > 0: 'Option 1 fehlt:' + all);
  assert(%scan(' 2=': all) = 0: 'Ausgeschlossene Option 2 angezeigt:' + all);
  assert(%scan(' L=': all) = 0: 'Ausgeschlossene Option L angezeigt:' + all);
end-proc;

// ==========================================================================
//  PEEK27: Die Auswahlzeilen passen in die Breite des Aufrufers (PEEK68FM:
//  29 Zeichen), statt bis 63 Zeichen gefüllt zu werden.
// ==========================================================================

dcl-proc test28_peek27_lineWidth export;
  dcl-s choices like(choice_t) dim(32);
  dcl-s n like(int4_t);
  dcl-s data like(set0000_t);
  dcl-s all varchar(2500) inz;
  dcl-s i like(int4_t);
  dcl-s len like(int4_t);

  peek22('*REPLACE': '*PEEK68');
  data = '*CHANGE';
  f_writeUsr('*PEEK68': '2': data);
  data = '*COPY';
  f_writeUsr('*PEEK68': '3': data);
  data = '*DELETE';
  f_writeUsr('*PEEK68': '4': data);
  data = '*DISPLAY';
  f_writeUsr('*PEEK68': '5': data);

  peek27('PEEK68': choices: n: *omit: 29);

  for i = 1 to n;
    len = %len(%trimr(choices(i)));
    assert(len <= 29: 'Zeile ' + %char(i) + ' hat ' + %char(len)
           + ' Zeichen: ''' + %trimr(choices(i)) + '''');
    all += ' ' + %trimr(choices(i));
  endfor;

  assert(n > 1: 'Nur eine Zeile:' + all);
  assert(%scan(' 5=': all) > 0: 'Option 5 fehlt:' + all);
end-proc;

// ==========================================================================
//  PEEK31: Fehlt die Nachrichtendatei der eingestellten Sprache, gilt GER
//  nur für diesen Aufruf; die Einstellung bleibt erhalten.
// ==========================================================================

dcl-proc test29_peek31_fallbackNotSaved export;
  dcl-ds set0004 likeds(set0004_t);
  dcl-ds orig likeds(set0004_t);
  dcl-s lang like(language_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  orig = f_getUsrSg('*LANGUAGE');
  set0004 = orig;
  set0004.set_lang = 'XYZ';
  p_updUsrSg('*LANGUAGE': set0004);

  lang = '*DFT';
  monitor;
    peek31(lang: 'PEEK': msgID: msgDta);
  on-error;
    p_updUsrSg('*LANGUAGE': orig);
    fail('PEEK31 bricht ab: ' + lastMsg());
  endmon;

  set0004 = f_getUsrSg('*LANGUAGE');
  p_updUsrSg('*LANGUAGE': orig);

  aEqual('': msgID: 'Nachricht');
  aEqual('GER': lang: 'Verwendete Sprache');
  aEqual('XYZ': set0004.set_lang: 'Gespeicherte Sprache');
end-proc;

// ==========================================================================
//  PEEK31: Eine ausdrücklich angegebene Sprache wird gespeichert.
// ==========================================================================

dcl-proc test30_peek31_explicitSaved export;
  dcl-ds set0004 likeds(set0004_t);
  dcl-ds orig likeds(set0004_t);
  dcl-s lang like(language_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  orig = f_getUsrSg('*LANGUAGE');
  set0004 = orig;
  set0004.set_lang = 'XYZ';
  p_updUsrSg('*LANGUAGE': set0004);

  lang = 'GER';
  peek31(lang: 'PEEK': msgID: msgDta);

  set0004 = f_getUsrSg('*LANGUAGE');
  p_updUsrSg('*LANGUAGE': orig);

  aEqual('': msgID: 'Nachricht');
  aEqual('GER': lang: 'Verwendete Sprache');
  aEqual('GER': set0004.set_lang: 'Gespeicherte Sprache');
end-proc;

// ==========================================================================
//  PEEK31: Fehlt auch die Nachrichtendatei für GER, kommt CPF2407 mit
//  Datei und Bibliothek statt eines deutschen Textes.
// ==========================================================================

dcl-proc test31_peek31_missingMsgf export;
  dcl-s lang like(language_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  lang = 'GER';
  peek31(lang: 'XXXX': msgID: msgDta);

  aEqual('CPF2407': msgID: 'Nachricht');
  aEqual('XXXXGER   ' + getPeekLib(): %subst(msgDta: 1: 20): 'Daten');
  aEqual('': lang: 'Sprache');
end-proc;

// ==========================================================================
//  PEEK33: Nach dem letzten Migrationsschritt wird die aktuelle Version
//  gespeichert.
// ==========================================================================

dcl-proc test32_peek33_versionRaised export;
  dcl-ds set0007 likeds(set0007_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  set0007 = f_getUsrSg('*VERSION');
  set0007.set_vsn = 'V04R01M00';
  p_updUsrSg('*VERSION': set0007);

  peek33('V04R01M01': msgID: msgDta);

  set0007 = f_getUsrSg('*VERSION');
  aEqual('V04R01M01': set0007.set_vsn: 'Gespeicherte Version');
end-proc;

// ==========================================================================
//  PEEK36: Zeitstempel mit 0 bis 12 Nachkommastellen werden angenommen.
//  Bisher ergaben TIMESTAMP(7) bis TIMESTAMP(12) USR8242.
// ==========================================================================

dcl-proc test33_peek36_timestampLengths export;
  chkPeek36('Z': '': '': '2026-11-05-10.00.00': '');
  chkPeek36('Z': '': '': '2026-11-05-10.00.00.1': '');
  chkPeek36('Z': '': '': '2026-11-05-10.00.00.123456': '');
  chkPeek36('Z': '': '': '2026-11-05-10.00.00.123456789012': '');
end-proc;

// ==========================================================================
//  PEEK36: Ungültige Zeitstempel ergeben USR8242.
// ==========================================================================

dcl-proc test34_peek36_invalidTimestamps export;
  chkPeek36('Z': '': '': '2026-11-05-10.00.00.1234567890123': 'USR8242');
  chkPeek36('Z': '': '': '2026-11-05-10.00.00.123456 X': 'USR8242');
  chkPeek36('Z': '': '': '2026-11-05-10.00.00.': 'USR8242');
  chkPeek36('Z': '': '': '2026-13-05-10.00.00.000000': 'USR8242');
end-proc;

// ==========================================================================
//  PEEK38: Bei 35 Schlüsselfeldern endet ORDER BY mit einem vollständigen
//  Schlüsselfeld. Bisher wurde die Klausel nach 512 Zeichen mitten im
//  Spaltennamen abgeschnitten.
// ==========================================================================

dcl-proc test35_peek38_manyKeys export;
  dcl-s order like(sqlOrder_t);
  dcl-s tail varchar(32);

  peek38(TST_KEY35I: TST_LIB: order);

  tail = '" ASC';
  assert(%len(order) > 20
         and %subst(order: %len(order) - %len(tail) + 1) = tail
         and %subst(order: %len(order) - 15: 9) = '"KEYFIELD'
         : 'ORDER BY (' + %char(%len(order)) + ' Zeichen) endet mit '''
         + %subst(order: %max(1: %len(order) - 40)) + '''');
end-proc;

// ==========================================================================
//  PEEK54/PEEK55: Ein WHERE, das kürzer als ein Stück (64 Zeichen) ist,
//  wird gesichert und unverändert geladen. Bisher brach PEEK54 mit
//  RNX0100 ab.
// ==========================================================================

dcl-proc test36_peek54_saveShortWhere export;
  dcl-s loaded like(sqlWhere_t);
  dcl-s msgID like(msgId_t);

  monitor;
    msgID = saveEnv('ID = 1');
  on-error;
    fail('PEEK54 bricht ab: ' + lastMsg());
  endmon;
  aEqual('': msgID: 'Sichern');

  monitor;
    msgID = loadEnv('*SLCENV': TST_FMTID: loaded);
  on-error;
    fail('PEEK55 bricht ab: ' + lastMsg());
  endmon;
  aEqual('': msgID: 'Laden');
  aEqual('ID = 1': loaded: 'WHERE nach dem Laden');
end-proc;

// ==========================================================================
//  PEEK55: Ein Leerzeichen am Ende eines Stücks bleibt erhalten. Bisher
//  wurde jedes Stück mit %trimr gekürzt.
// ==========================================================================

dcl-proc test37_peek55_blankAtChunkEnd export;
  dcl-s where like(sqlWhere_t);
  dcl-s loaded like(sqlWhere_t);
  dcl-s msgID like(msgId_t);
  dcl-s i like(int4_t);

  where = '';
  for i = 1 to 63;
    where += 'A';
  endfor;
  where += ' ';
  for i = 1 to 64;
    where += 'B';
  endfor;

  monitor;
    msgID = saveEnv(where);
  on-error;
    fail('PEEK54 bricht ab: ' + lastMsg());
  endmon;
  aEqual('': msgID: 'Sichern');

  monitor;
    msgID = loadEnv('*SLCENV': TST_FMTID: loaded);
  on-error;
    fail('PEEK55 bricht ab: ' + lastMsg());
  endmon;
  aEqual('': msgID: 'Laden');
  aEqual(where: loaded: 'WHERE nach dem Laden');
end-proc;

// ==========================================================================
//  PEEK55: Nach USR8234 (Layout eines anderen Satzformats) lässt sich die
//  Umgebung wieder laden. Bisher blieb PEEKENV offen (RNX1215).
// ==========================================================================

dcl-proc test38_peek55_loadAfterUsr8234 export;
  dcl-s loaded like(sqlWhere_t);
  dcl-s msgID like(msgId_t);

  monitor;
    msgID = saveEnv('');
  on-error;
    fail('PEEK54 bricht ab: ' + lastMsg());
  endmon;
  aEqual('': msgID: 'Sichern');

  msgID = loadEnv('*SLCLAYOUT': 'XXXXXXXXXXXXX': loaded);
  aEqual('USR8234': msgID: 'Anderes Satzformat');

  monitor;
    msgID = loadEnv('*SLCENV': TST_FMTID: loaded);
  on-error;
    fail('Zweites Laden bricht ab: ' + lastMsg());
  endmon;
  aEqual('': msgID: 'Zweites Laden');
end-proc;

// ==========================================================================
//  PEEK62: Eine Einstellungsdatei mit DATA 128 wird auf die Satzlänge von
//  PEEKUSR umgestellt.
// ==========================================================================

dcl-proc test39_peek62_convertsOldFile export;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  crtOldUsr(TST_OLDU1: 10: 128);

  monitor;
    peek62(TST_OLDU1: TST_LIB: msgID: msgDta);
  on-error;
    fail('PEEK62 bricht ab: ' + lastMsg());
  endmon;
  aEqual('': msgID: 'Nachricht');
  iEqual(PEEKUSR_LEN: rcdLen(TST_OLDU1): 'Satzlänge');
end-proc;

// ==========================================================================
//  PEEK62: Weicht eine andere Spalte als DATA ab, bleibt die Satzlänge
//  falsch; PEEK62 meldet USR9989. Bisher kehrte es still zurück.
// ==========================================================================

dcl-proc test40_peek62_otherColumnDiffers export;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  crtOldUsr(TST_OLDU2: 12: 256);

  monitor;
    peek62(TST_OLDU2: TST_LIB: msgID: msgDta);
  on-error;
    fail('PEEK62 bricht ab: ' + lastMsg());
  endmon;
  aEqual('USR9989': msgID: 'Nachricht');
  aEqual(TST_OLDU2 + ' ' + TST_LIB: %subst(msgDta: 1: 15): 'Daten');
end-proc;

// ==========================================================================
//  PEEK61: Fortschrittsanzeige mit Höchstwert 0. Bisher teilte sie durch
//  null (MCH1211).
// ==========================================================================

dcl-proc test41_peek61_maxValueZero export;
  monitor;
    p_inzProgressMeter('Test': 0);
    p_showProgressMeter(0);
  on-error;
    fail('PEEK61 bricht ab: ' + lastMsg());
  endmon;
end-proc;

// ==========================================================================
//  PEEK65: Ein vorhandener Satz wird gedruckt (USR8226).
// ==========================================================================

dcl-proc test42_peek65_printsRecord export;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  loadPrtFields();

  monitor;
    peek65(1: TST_PRT: TST_LIB: TST_PRT: '': msgID: msgDta);
  on-error;
    fail('PEEK65 bricht ab: ' + lastMsg());
  endmon;
  dltPrtSplf();
  aEqual('USR8226': msgID: 'Nachricht');
end-proc;

// ==========================================================================
//  PEEK65: Ein gelöschter Satz wird nicht gedruckt (USR8120). Bisher wurde
//  ein leerer Satz gedruckt und USR8226 gemeldet.
// ==========================================================================

dcl-proc test43_peek65_deletedRecord export;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  loadPrtFields();

  monitor;
    peek65(2: TST_PRT: TST_LIB: TST_PRT: '': msgID: msgDta);
  on-error;
    fail('PEEK65 bricht ab: ' + lastMsg());
  endmon;
  dltPrtSplf();
  aEqual('USR8120': msgID: 'Nachricht');
end-proc;

// ==========================================================================
//  PEEK65: Ein Satz, den es nicht gibt, wird nicht gedruckt (USR8120).
// ==========================================================================

dcl-proc test44_peek65_rrnNotExists export;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  loadPrtFields();

  monitor;
    peek65(99: TST_PRT: TST_LIB: TST_PRT: '': msgID: msgDta);
  on-error;
    fail('PEEK65 bricht ab: ' + lastMsg());
  endmon;
  dltPrtSplf();
  aEqual('USR8120': msgID: 'Nachricht');
end-proc;

// ==========================================================================
//  PEEK65: Lässt sich die Datei nicht öffnen, meldet PEEK65 USR0005. Bisher
//  brach es mit MCH3601 ab.
// ==========================================================================

dcl-proc test45_peek65_fileNotFound export;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  monitor;
    peek65(1: 'NOSUCHF': TST_LIB: 'NOSUCHF': '': msgID: msgDta);
  on-error;
    fail('PEEK65 bricht ab: ' + lastMsg());
  endmon;
  aEqual('USR0005': msgID: 'Nachricht');
  aEqual('NOSUCHF': %subst(msgDta: 1: 7): 'Daten');
end-proc;

// ==========================================================================
//  PEEK66: 123 passt in gepackt 3,0.
// ==========================================================================

dcl-proc test46_peek66_valueFits export;
  dcl-s buffer like(cmdBuffer_t);
  dcl-s length int(10);
  dcl-ds inFmt likeds(fldl0100_t) inz;
  dcl-ds outFmt likeds(fldl0100_t) inz;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  numFmt(inFmt: 'P': 9: 0);
  numFmt(outFmt: 'P': 3: 0);
  buffer = '123';
  length = 3;

  monitor;
    peek66(buffer: length: inFmt: outFmt: msgID: msgDta);
  on-error;
    fail('PEEK66 bricht ab: ' + lastMsg());
  endmon;
  aEqual('': msgID: 'Nachricht');
  aEqual('x''123F''': %subst(buffer: 1: length): 'Puffer');
end-proc;

// ==========================================================================
//  PEEK66: 12345 passt nicht in gepackt 3,0 - PEEK66 meldet USR8227 und
//  lässt den Puffer unverändert. Bisher kam MCH1210 aus CPYNV.
// ==========================================================================

dcl-proc test47_peek66_overflow export;
  dcl-s buffer like(cmdBuffer_t);
  dcl-s length int(10);
  dcl-ds inFmt likeds(fldl0100_t) inz;
  dcl-ds outFmt likeds(fldl0100_t) inz;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  numFmt(inFmt: 'P': 9: 0);
  numFmt(outFmt: 'P': 3: 0);
  buffer = '12345';
  length = 5;

  monitor;
    peek66(buffer: length: inFmt: outFmt: msgID: msgDta);
  on-error;
    fail('PEEK66 bricht ab: ' + lastMsg());
  endmon;
  aEqual('USR8227': msgID: 'Nachricht');
  aEqual('12345': %subst(buffer: 1: length): 'Puffer');
  aEqual('P': %subst(msgDta: 257: 1): 'Datentyp');
end-proc;

// ==========================================================================
//  PEEK66: Die Zeichenkette 12345 passt nicht in gezont 3,0 (USR8227).
// ==========================================================================

dcl-proc test48_peek66_overflowFromChar export;
  dcl-s buffer like(cmdBuffer_t);
  dcl-s length int(10);
  dcl-ds inFmt likeds(fldl0100_t) inz;
  dcl-ds outFmt likeds(fldl0100_t) inz;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  inFmt.f1DTyp = 'A';
  inFmt.f1FLen = 10;
  numFmt(outFmt: 'S': 3: 0);
  buffer = '12345';
  length = 5;

  monitor;
    peek66(buffer: length: inFmt: outFmt: msgID: msgDta);
  on-error;
    fail('PEEK66 bricht ab: ' + lastMsg());
  endmon;
  aEqual('USR8227': msgID: 'Nachricht');
  aEqual('S': %subst(msgDta: 257: 1): 'Datentyp');
end-proc;

// ==========================================================================
//  PEEK71: Ein leerer Puffer wird nicht umgesetzt. Bisher brach PEEK71 mit
//  RNX0425 ab (%alloc(0)), z.B. im Editor für ein leeres VARCHAR-Feld.
// ==========================================================================

dcl-proc test49_peek71_emptyBuffer export;
  dcl-s hTranscoder like(hTranscoder_t);
  dcl-s buffer char(10) inz;
  dcl-s length int(10);

  monitor;
    hTranscoder = Transcoder_toJobCcsid(1208);
    length = Transcoder_xlateBuffer(hTranscoder: %addr(buffer): 0
                                    : %size(buffer));
  on-error;
    fail('PEEK71 bricht ab: ' + lastMsg());
  endmon;
  iEqual(0: length: 'Länge');
end-proc;

// ==========================================================================
//  PEEK71: Eine leere Zeichenkette ergibt eine leere Zeichenkette.
// ==========================================================================

dcl-proc test50_peek71_emptyString export;
  dcl-s hTranscoder like(hTranscoder_t);
  dcl-s result varchar(100);

  monitor;
    hTranscoder = Transcoder_toJobCcsid(1208);
    result = Transcoder_xlateString(hTranscoder: '');
  on-error;
    fail('PEEK71 bricht ab: ' + lastMsg());
  endmon;
  iEqual(0: %len(result): 'Länge');
end-proc;

// ==========================================================================
//  PEEK71: Nach CHGJOB CCSID und Transcoder_reset() (PEEK05 beim Start)
//  wird in die neue Job-CCSID umgesetzt. Bisher blieb die alte CCSID bis
//  zum Ende der Aktivierungsgruppe gespeichert.
// ==========================================================================

dcl-proc test51_peek71_jobCcsidChanged export;
  dcl-ds jobi0400 likeds(jobi0400_t) inz;
  dcl-s hTranscoder like(hTranscoder_t);
  dcl-s oldCcsid int(10);
  dcl-s newCcsid int(10);
  dcl-s toCcsid int(10);

  qusrjobi(jobi0400: %size(jobi0400): 'JOBI0400': '*': '');
  oldCcsid = jobi0400.ccsid;
  if (getJobCcsid() = 37);
    newCcsid = 1141;
  else;
    newCcsid = 37;
  endif;

  runCmd('CHGJOB CCSID(' + %char(newCcsid) + ')');
  monitor;
    Transcoder_reset();
    hTranscoder = Transcoder_toJobCcsid(1252);
    toCcsid = Transcoder_getToCcsid(hTranscoder);
  on-error;
    runCmd('CHGJOB CCSID(' + %char(oldCcsid) + ')');
    Transcoder_reset();
    fail('PEEK71 bricht ab: ' + lastMsg());
  endmon;
  runCmd('CHGJOB CCSID(' + %char(oldCcsid) + ')');
  Transcoder_reset();

  iEqual(newCcsid: toCcsid: 'Ziel-CCSID nach CHGJOB');
end-proc;

// ==========================================================================
//  PEEK71: Transcoder_delete() entfernt einen Umsetzer auch aus der Liste
//  der erstellten Umsetzer. Bisher lieferte Transcoder_toJobCcsid() danach
//  den gelöschten (geleerten) Umsetzer mit von-CCSID 0. Die Adresse des
//  neuen Umsetzers kann dieselbe sein (%alloc nach dealloc).
// ==========================================================================

dcl-proc test52_peek71_deleteCachedHandle export;
  dcl-s hTranscoder like(hTranscoder_t);
  dcl-s fromCcsid int(10);

  hTranscoder = Transcoder_toJobCcsid(500);
  Transcoder_delete(hTranscoder);

  monitor;
    hTranscoder = Transcoder_toJobCcsid(500);
    fromCcsid = Transcoder_getFromCcsid(hTranscoder);
  on-error;
    fail('PEEK71 bricht ab: ' + lastMsg());
  endmon;
  iEqual(500: fromCcsid: 'Von-CCSID');
end-proc;

// ==========================================================================
//  PEEK71: Ein ungültiger Umsetzer wird mit CPF9897 gemeldet. Bisher kam
//  MCH3601.
// ==========================================================================

dcl-proc test53_peek71_nullHandle export;
  dcl-ds msg likeds(rtnMsgInfo_t);
  dcl-s ccsid int(10);

  monitor;
    ccsid = Transcoder_getFromCcsid(Transcoder_null());
  on-error;
    msg = getMonitoredMessage(*on);
    aEqual('CPF9897': msg.id: 'Nachricht');
    return;
  endmon;
  fail('Keine Ausnahme, von-CCSID ' + %char(ccsid));
end-proc;

// ==========================================================================
//  PEEK71: 32765 x 'a' und ein Sonderzeichen (32766 Bytes) ergeben in
//  UTF-8 32767 Bytes. Bisher war die Ausgabe auf 32765 Bytes begrenzt.
// ==========================================================================

dcl-proc test54_peek71_longStringExpand export;
  dcl-s hTranscoder like(hTranscoder_t);
  dcl-s input varchar(32767);
  dcl-s result varchar(32767);
  dcl-s aaa char(32765) inz(*all'a');

  //  x'4A' ist in allen EBCDIC-Job-CCSIDs ein Zeichen außerhalb von ASCII
  //  (CCSID 37: Cent, CCSID 273/1141: Ä), also 2 Bytes in UTF-8.
  input = aaa + x'4A';

  monitor;
    hTranscoder = Transcoder_toFieldCcsid(1208);
    result = Transcoder_xlateString(hTranscoder: input);
  on-error;
    fail('PEEK71 bricht ab: ' + lastMsg());
  endmon;
  iEqual(32767: %len(result): 'Länge in UTF-8');
end-proc;

// ==========================================================================
//  PEEK71: Ist die Liste der Umsetzer voll (64), schafft Transcoder_reset()
//  wieder Platz. PEEK05 ruft es bei jedem Start von Peek auf.
// ==========================================================================

dcl-proc test55_peek71_resetFreesCache export;
  dcl-c CCSIDS '37 273 277 278 280 284 285 297 500 871 1140 1141 1142 1143 +
    1144 1145 1146 1147 1148 1149 1047 870 1153 1025 1154 1026 +
    1155 875 1112 1122 819 850 1252 437 852 1250 1251 1254 367 +
    912 ';
  dcl-s hTranscoder like(hTranscoder_t);
  dcl-s pos int(10) inz(1);
  dcl-s nxt int(10);
  dcl-s ccsid int(10);
  dcl-s isFull ind inz(*off);
  dcl-ds msg likeds(rtnMsgInfo_t);

  dow (pos < %len(CCSIDS) and not isFull);
    nxt = %scan(' ': CCSIDS: pos);
    ccsid = %int(%subst(CCSIDS: pos: nxt - pos));
    pos = nxt + 1;
    monitor;
      hTranscoder = Transcoder_toJobCcsid(ccsid);
      hTranscoder = Transcoder_toFieldCcsid(ccsid);
    on-error;
      msg = getMonitoredMessage(*on);
      isFull = (%scan('Maximum number': msg.txt) > 0);
    endmon;
  enddo;
  assert(isFull: 'Die Liste der Umsetzer wurde nicht voll');

  Transcoder_reset();
  monitor;
    hTranscoder = Transcoder_toJobCcsid(37);
  on-error;
    fail('Nach transcoder_reset(): ' + lastMsg());
  endmon;
  Transcoder_reset();
end-proc;

// ==========================================================================
//  PEEK70: Unbekannte Bibliothek - 0 Einträge ohne Ausnahme, und ein *READ
//  danach liest keine alte Liste weiter.
// ==========================================================================

dcl-proc test56_peek70_unknownLib export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds objl0200 likeds(objl0200_t) inz;
  dcl-s numE int(10);

  qFile.name = TST_LST + '*';
  qFile.lib = TST_LIB;
  peek70(qFile: '*CREATE': numE: objl0200);
  iEqual(3: numE: 'Anzahl ' + TST_LST + '*');

  qFile.lib = 'NOSUCHLIB';
  monitor;
    peek70(qFile: '*CREATE': numE: objl0200);
  on-error;
    fail('PEEK70 bricht ab: ' + lastMsg());
  endmon;
  iEqual(0: numE: 'Anzahl NOSUCHLIB');

  peek70(qFile: '*READ': numE: objl0200);
  aEqual('': objl0200.o2ONme: '*READ nach gescheitertem *CREATE');
end-proc;

// ==========================================================================
//  PEEK70: Eigener Benutzerbereich - PEEK11 zwischen *CREATE und *READ
//  ändert die Dateiliste nicht. Bisher benutzten beide QTEMP/§PEEK§.
// ==========================================================================

dcl-proc test57_peek70_ownUserSpace export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds objl0200 likeds(objl0200_t) inz;
  dcl-ds rcdl0200 likeds(rcdl0200_t) inz;
  dcl-s numE int(10);
  dcl-s nrcd int(10);

  qFile.name = TST_LST + '*';
  qFile.lib = TST_LIB;
  peek70(qFile: '*CREATE': numE: objl0200);
  peek70(qFile: '*READ': numE: objl0200);
  aEqual(TST_LST + '1': objl0200.o2ONme: 'Erster Eintrag');

  qFile.name = TST_FILE;
  peek11(qFile: '*CREATE': nrcd: rcdl0200);

  qFile.name = TST_LST + '*';
  peek70(qFile: '*READ': numE: objl0200);
  aEqual(TST_LST + '2': objl0200.o2ONme: 'Zweiter Eintrag nach PEEK11');
end-proc;

// ==========================================================================
//  PEEK70: Eine unbekannte Funktion ergibt 0 Einträge. Bisher blieb der
//  Wert des Aufrufers stehen.
// ==========================================================================

dcl-proc test58_peek70_unknownFunction export;
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds objl0200 likeds(objl0200_t) inz;
  dcl-s numE int(10);

  qFile.name = TST_LST + '*';
  qFile.lib = TST_LIB;
  numE = 7;
  peek70(qFile: '*FOO': numE: objl0200);
  iEqual(0: numE: 'Anzahl');
end-proc;

// ==========================================================================
//  PEEK32: GRAPHIC-Felder (CCSID ungleich 0) stehen als UCS-2 im Puffer.
//  Steuerzeichen (U+0000 bis U+001F, U+007F bis U+009F) sind nicht
//  darstellbar. Bisher prüfte PEEK32 nur SBCS-Zeichen.
// ==========================================================================

dcl-proc test59_peek32_ucs2ControlChar export;
  dcl-ds buffer likeds(rcdBuffer_t) inz;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  %subst(buffer.ucs2: 1: 3) = u'00410007009F';
  peek32(buffer: 3: 13488: msgID: msgDta);
  aEqual('USR8163': msgID: 'msgID bei U+0007 und U+009F');
end-proc;

dcl-proc test60_peek32_ucs2Text export;
  dcl-ds buffer likeds(rcdBuffer_t) inz;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  //  A, Leerzeichen, Ä, geschütztes Leerzeichen, chinesisches Zeichen
  %subst(buffer.ucs2: 1: 5) = u'0041002000C400A04E2D';
  peek32(buffer: 5: 1200: msgID: msgDta);
  aEqual('': msgID: 'msgID bei darstellbaren Zeichen');
end-proc;

// ==========================================================================
//  Hilfsprozeduren
// ==========================================================================

//  Loads the fields of QTEMP/PEEK65T into PEEKFLD (other tests load other
//  files into PEEKFLD).
dcl-proc loadPrtFields;
  dcl-ds qFile likeds(qObj_t) inz;

  qFile.name = TST_PRT;
  qFile.lib = TST_LIB;
  loadFields(qFile);
end-proc;

//  Deletes the last spooled file PEEK65T of this job (if any).
dcl-proc dltPrtSplf;
  monitor;
    runCmd('DLTSPLF FILE(' + TST_PRT + ') JOB(*) SPLNBR(*LAST)');
  on-error;
  endmon;
end-proc;

//  Sets the numeric format of a FLDL0100 entry (PEEK66).
dcl-proc numFmt;
  dcl-pi *n;
    io_fmt likeds(fldl0100_t);
    i_type char(1) const;
    i_digt int(10) const;
    i_decp int(10) const;
  end-pi;

  io_fmt.f1DTyp = i_type;
  io_fmt.f1Digt = i_digt;
  io_fmt.f1DecP = i_decp;
  if (i_type = 'P');
    io_fmt.f1FLen = %int(i_digt / 2) + 1;
  else;
    io_fmt.f1FLen = i_digt;
  endif;
end-proc;

//  Creates the settings file QTEMP/<i_file> in an old layout with the
//  given lengths of KEY and DATA (any existing file is replaced).
dcl-proc crtOldUsr;
  dcl-pi *n;
    i_file    varchar(10) const;
    i_keyLen  int(10) const;
    i_dataLen int(10) const;
  end-pi;

  monitor;
    runSql('DROP TABLE ' + TST_LIB + '/' + i_file);
  on-error;
  endmon;
  runSql('CREATE TABLE ' + TST_LIB + '/' + i_file + ' (+
          "USER" CHAR(10) NOT NULL WITH DEFAULT, +
          "SECTION" CHAR(10) NOT NULL WITH DEFAULT, +
          "KEY" CHAR(' + %char(i_keyLen) + ') NOT NULL WITH DEFAULT, +
          "DATA" CHAR(' + %char(i_dataLen) + ') NOT NULL WITH DEFAULT)');
end-proc;

//  Returns the record length of QTEMP/<i_file> (0 if it cannot be opened).
dcl-proc rcdLen;
  dcl-pi *n int(10);
    i_file varchar(10) const;
  end-pi;

  dcl-s len int(10) inz(0);

  g_anyfile = TST_LIB + '/' + i_file;
  monitor;
    open anyfile;
    len = anyfile_ds.rcdLen;
    close anyfile;
  on-error;
    len = 0;
  endmon;

  return len;
end-proc;

//  Saves the environment of QTEMP/PEEKKEYS with the given WHERE into
//  QTEMP/PEEKENVT(PEEKKEYS) and returns the message ID.
dcl-proc saveEnv;
  dcl-pi *n like(msgId_t);
    i_where varchar(512) const;
  end-pi;

  dcl-ds pIntAbr likeds(pinTabR_t) dim(12) inz;
  dcl-s pinTabC like(fieldNme_t) dim(12) inz;
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  peek54(TST_FILE: TST_LIB: TST_FILE: TST_FILE: TST_FMTID
        : TST_ENVF: TST_LIB: TST_ENVM: bFalse
        : pIntAbr: 0: pinTabC: 0
        : SQL_SEQ: i_where: '': KEY_MODE_UPPER
        : msgID: msgDta);

  return msgID;
end-proc;

//  Loads the environment of QTEMP/PEEKKEYS and returns the message ID.
dcl-proc loadEnv;
  dcl-pi *n like(msgId_t);
    i_option like(option_t) const;
    i_fmtId  like(fmtId_t) const;
    o_where  like(sqlWhere_t);
  end-pi;

  dcl-ds pIntAbr likeds(pinTabR_t) dim(12) inz;
  dcl-s pinTabC like(fieldNme_t) dim(12) inz;
  dcl-s nbrPinR like(int4_t);
  dcl-s nbrPinC like(int4_t);
  dcl-s file like(file_t);
  dcl-s lib like(lib_t);
  dcl-s mbr like(mbr_t);
  dcl-s fmt like(fmt_t);
  dcl-s accMode like(accessMode_t);
  dcl-s order like(sqlOrder_t);
  dcl-s keyLower like(bool_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  peek55(TST_FILE: TST_LIB: TST_FILE: TST_FILE: i_fmtId
        : TST_ENVF: TST_LIB: TST_ENVM: i_option
        : pIntAbr: nbrPinR: pinTabC: nbrPinC
        : file: lib: mbr: fmt: accMode: o_where: order: keyLower
        : msgID: msgDta);

  return msgID;
end-proc;

//  Creates the table QTEMP/PEEKKEY35 with 35 columns KEYFIELD01..35 and
//  the index QTEMP/PEEKKEY35I over all of them.
dcl-proc crtKey35;
  dcl-s cols varchar(2000) inz;
  dcl-s keys varchar(2000) inz;
  dcl-s name varchar(10);
  dcl-s i like(int4_t);

  for i = 1 to 35;
    name = 'KEYFIELD' + %editc(%dec(i: 2: 0): 'X');
    if (i > 1);
      cols += ', ';
      keys += ', ';
    endif;
    cols += name + ' CHAR(1)';
    keys += name;
  endfor;

  runSql('CREATE TABLE ' + TST_LIB + '/' + TST_KEY35 + ' (' + cols + ')');
  runSql('CREATE INDEX ' + TST_LIB + '/' + TST_KEY35I + ' ON '
         + TST_LIB + '/' + TST_KEY35 + ' (' + keys + ')');
end-proc;

//  Sets the data of a key in the user settings (TESTUSER).
dcl-proc setUsrData;
  dcl-pi *n;
    i_section like(section_t) const;
    i_key     like(key_t) const;
    i_data    varchar(256) const;
  end-pi;

  dcl-s data like(set0000_t);

  data = i_data;
  if (f_updatUsr(i_section: i_key: data) = bTrue);
    f_writeUsr(i_section: i_key: data);
  endif;
end-proc;

//  Returns ' <section>/<key>' if the key is missing or still '*CHANGED'.
dcl-proc chkUsrReset;
  dcl-pi *n varchar(100);
    i_section like(section_t) const;
    i_key     like(key_t) const;
  end-pi;

  dcl-s data like(set0000_t);

  if (f_chainUsr(i_section: i_key: data) = bTrue);
    return ' ' + %trim(i_section) + '/' + %trim(i_key) + '=fehlt';
  endif;

  if (%subst(data: 1: 8) = '*CHANGED');
    return ' ' + %trim(i_section) + '/' + %trim(i_key);
  endif;

  return '';
end-proc;

//  Calls PEEK36 and compares the message ID (blank = value accepted).
dcl-proc chkPeek36;
  dcl-pi *n;
    i_type      char(1) const;
    i_format    char(4) const;
    i_separator char(1) const;
    i_value     varchar(40) const;
    i_msgID     char(7) const;
  end-pi;

  dcl-s buffer like(smallBuffer_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  buffer = i_value;
  monitor;
    peek36(buffer: i_type: i_format: i_separator: msgID: msgDta);
  on-error;
    fail('PEEK36 bricht bei ' + i_type + ' ' + i_format + ' '''
         + i_value + ''' ab: ' + lastMsg());
  endmon;

  aEqual(i_msgID: msgID: 'PEEK36 ' + i_type + ' ' + i_format + ' '''
         + i_value + '''');
end-proc;

//  Creates the physical file QTEMP/<i_file> from DDS lines, using a source
//  file QTEMP/Q<i_file> (any existing file is replaced).
dcl-proc crtDdsFile;
  dcl-pi *n;
    i_file  char(9) const;
    i_line1 varchar(80) const;
    i_line2 varchar(80) const;
    i_line3 varchar(80) const;
    i_line4 varchar(80) const;
    i_line5 varchar(80) options(*nopass) const;
  end-pi;

  dcl-s srcFile varchar(10);

  srcFile = 'Q' + %trim(i_file);

  monitor;
    runCmd('DLTF FILE(QTEMP/' + %trim(i_file) + ')');
  on-error;
  endmon;
  monitor;
    runCmd('DLTF FILE(QTEMP/' + srcFile + ')');
  on-error;
  endmon;
  runCmd('CRTSRCPF FILE(QTEMP/' + srcFile + ') RCDLEN(92) +
          MBR(' + %trim(i_file) + ')');

  addDdsLine(srcFile: 1: i_line1);
  addDdsLine(srcFile: 2: i_line2);
  addDdsLine(srcFile: 3: i_line3);
  addDdsLine(srcFile: 4: i_line4);
  if (%parms() >= %parmnum(i_line5));
    addDdsLine(srcFile: 5: i_line5);
  endif;

  runCmd('CRTPF FILE(QTEMP/' + %trim(i_file) + ') +
          SRCFILE(QTEMP/' + srcFile + ') SRCMBR(' + %trim(i_file) + ')');
end-proc;

dcl-proc addDdsLine;
  dcl-pi *n;
    i_srcFile varchar(10) const;
    i_seq     int(10) const;
    i_line    varchar(80) const;
  end-pi;

  runSql('INSERT INTO QTEMP/' + i_srcFile +
         ' (SRCSEQ, SRCDAT, SRCDTA) VALUES(' + %char(i_seq) + ', 0, ''' +
         %scanrpl('''': '''''': i_line) + ''')');
end-proc;

dcl-proc dltOvrPeek15;
  monitor;
    runCmd('DLTOVR FILE(QPEEKGEN QCOPYLE1 QCOPYLE2 QCOPYLE3 QCOPYLE4 +
            QCOPYLE5 QCOPYLE6 PEEKSRC) LVL(*JOB)');
  on-error;
  endmon;
end-proc;

//  Returns the first candidate CCSID that cannot be converted to the job
//  CCSID. With i_createTable = *on, also creates table QTEMP/PEEKCCSID
//  with an INTEGER column ID and a GRAPHIC column G of that CCSID.
dcl-proc findUnconvertibleCcsid;
  dcl-pi *n int(10);
    i_createTable ind const;
  end-pi;

  dcl-s candidates int(10) dim(9);
  dcl-s i int(10);
  dcl-s hTranscoder like(hTranscoder_t);
  dcl-s isConvertible ind;

  candidates(1) = 835;
  candidates(2) = 300;
  candidates(3) = 834;
  candidates(4) = 837;
  candidates(5) = 4396;
  candidates(6) = 16684;
  candidates(7) = 4930;
  candidates(8) = 1362;
  candidates(9) = 28709;

  for i = 1 to %elem(candidates);
    //  Transcoder_new() does not add the transcoder to the list.
    isConvertible = *on;
    monitor;
      hTranscoder = Transcoder_new(getJobCcsid(): candidates(i));
      Transcoder_delete(hTranscoder);
    on-error;
      isConvertible = *off;
      getMonitoredMessage(*on);
    endmon;

    if (isConvertible);
      iter;
    endif;

    if (not i_createTable);
      return candidates(i);
    endif;

    monitor;
      runSql('DROP TABLE QTEMP/PEEKCCSID');
    on-error;
    endmon;
    monitor;
      runSql('CREATE TABLE QTEMP/PEEKCCSID (ID INTEGER NOT NULL, +
              G GRAPHIC(5) CCSID ' + %char(candidates(i)) + ' NOT NULL)');
      return candidates(i);
    on-error;
    endmon;
  endfor;

  return 0;
end-proc;

//  Returns the CCSID of the job like PEEK71.
dcl-proc getJobCcsid;
  dcl-pi *n int(10);
  end-pi;

  dcl-ds jobi0400 likeds(jobi0400_t) inz;

  qusrjobi(jobi0400: %size(jobi0400): 'JOBI0400': '*': '');
  if (jobi0400.ccsid = 65535);
    return jobi0400.dftCcsid;
  endif;

  return jobi0400.ccsid;
end-proc;

//  Fills PEEKFLD with the fields of the file (PEEK01).
dcl-proc loadFields;
  dcl-pi *n;
    i_qFile likeds(qObj_t) const;
  end-pi;

  dcl-s fmtId like(fmtId_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  peek01(i_qFile: i_qFile.name: fmtId: msgID: msgDta);
  if (msgID <> '');
    fail('PEEK01 für ' + %trim(i_qFile.name) + ': ' + msgID);
  endif;
end-proc;

//  Fills PEEKFLD with the fields of the file and marks the fields of
//  i_order as key fields (PEEK01, PEEK03).
dcl-proc setKeys;
  dcl-pi *n;
    i_qFile likeds(qObj_t) const;
    i_order varchar(256) const;
  end-pi;

  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);

  loadFields(i_qFile);
  peek03(i_qFile: i_qFile.name: SQL_SEQ: i_order: msgID: msgDta);
  if (msgID <> '');
    fail('PEEK03 für ' + %trim(i_qFile.name) + ': ' + msgID);
  endif;
end-proc;

//  Returns the field description of a field in QTEMP/PEEKFLD.
dcl-proc fieldOf;
  dcl-pi *n likeds(fldl0100_t);
    i_field char(10) const;
  end-pi;

  dcl-ds fldl0100 likeds(fldl0100_t) inz;
  dcl-s isFound ind;

  open peekFld;
  chain i_field rpeekfld;
  isFound = %found(peekFld);
  if (isFound);
    fldl0100 = k_ffd;
  endif;
  close peekFld;

  if (not isFound);
    fail('Feld ' + %trim(i_field) + ' nicht in QTEMP/PEEKFLD.');
  endif;

  return fldl0100;
end-proc;

//  Copies a file of the Peek library without data to QTEMP (unless it is
//  already there) and overrides the file with the copy for the job.
dcl-proc dupAndOverride;
  dcl-pi *n;
    i_peekLib like(lib_t) const;
    i_file    char(10) const;
  end-pi;

  monitor;
    runCmd('CRTDUPOBJ OBJ(' + %trim(i_file) + ') FROMLIB('
           + %trim(i_peekLib) + ') OBJTYPE(*FILE) TOLIB(QTEMP) DATA(*NO)');
  on-error;
  endmon;
  runCmd('OVRDBF FILE(' + %trim(i_file) + ') TOFILE(QTEMP/'
         + %trim(i_file) + ') OVRSCOPE(*JOB)');
end-proc;

//  Returns KSEQ of a field in QTEMP/PEEKFLD, -1 if not found.
dcl-proc kseqOf;
  dcl-pi *n int(10);
    i_field char(10) const;
  end-pi;

  dcl-s kseq int(10);

  open peekFld;
  chain i_field rpeekfld;
  if (%found(peekFld));
    kseq = k_kseq;
  else;
    kseq = -1;
  endif;
  close peekFld;

  return kseq;
end-proc;

//  Returns ISTRANSC of a field in QTEMP/PEEKFLD, '?' if not found.
dcl-proc isTranscOf;
  dcl-pi *n char(1);
    i_field char(10) const;
  end-pi;

  dcl-s isTransc char(1);

  open peekFld;
  chain i_field rpeekfld;
  if (%found(peekFld));
    isTransc = k_isTransc;
  else;
    isTransc = '?';
  endif;
  close peekFld;

  return isTransc;
end-proc;

//  Formats a REAL or DOUBLE value with PEEK06.
dcl-proc editFloat;
  dcl-pi *n varchar(64);
    i_pValue pointer value;
    i_length int(10) const;
  end-pi;

  dcl-ds fldl0100 likeds(fldl0100_t) inz;
  dcl-s srcVar like(rcdBuf_t);
  dcl-s string like(rcdBuf_t);
  dcl-s strlen like(int4_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);
  dcl-s value char(8) based(i_pValue);

  fldl0100.f1FNme = 'FLOAT';
  fldl0100.f1DTyp = 'F';
  fldl0100.f1IBuf = 1;
  fldl0100.f1obuf = 1;
  fldl0100.f1FLen = i_length;
  fldl0100.f1vfmi = '0';

  srcVar = %subst(value: 1: i_length);
  peek06(fldl0100: 'FLDL0100': srcVar: bFalse: bTrue
         : string: strlen: msgID: msgDta);

  return %trimr(%subst(string: 1: 64));
end-proc;

//  Formats a packed value with PEEK06.
dcl-proc editPacked;
  dcl-pi *n varchar(64);
    i_pValue pointer value;
    i_digits int(10) const;
    i_edtCde char(1) const;
    i_edtWrd varchar(64) const;
  end-pi;

  dcl-ds fldl0100 likeds(fldl0100_t) inz;
  dcl-s srcVar like(rcdBuf_t);
  dcl-s string like(rcdBuf_t);
  dcl-s strlen like(int4_t);
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);
  dcl-s value char(16) based(i_pValue);

  fldl0100.f1FNme = 'PACKED';
  fldl0100.f1DTyp = 'P';
  fldl0100.f1IBuf = 1;
  fldl0100.f1obuf = 1;
  fldl0100.f1FLen = %div(i_digits: 2) + 1;
  fldl0100.f1Digt = i_digits;
  fldl0100.f1DecP = 0;
  fldl0100.f1vfmi = '0';
  fldl0100.f1EdtC = i_edtCde;
  fldl0100.f1EdWd = i_edtWrd;
  fldl0100.f1EdWl = %len(i_edtWrd);

  srcVar = %subst(value: 1: fldl0100.f1FLen);
  peek06(fldl0100: 'FLDL0100': srcVar: bFalse: bTrue
         : string: strlen: msgID: msgDta);

  if (strlen <= 0);
    return '';
  endif;
  if (strlen > 64);
    strlen = 64;
  endif;

  return %subst(string: 1: strlen);
end-proc;

dcl-proc digitsOf;
  dcl-pi *n varchar(64);
    i_string varchar(64) const;
  end-pi;

  return %scanrpl('.': '': %scanrpl(',': '': i_string));
end-proc;

dcl-proc hexOf;
  dcl-pi *n varchar(140);
    i_string varchar(64) const;
  end-pi;

  dcl-c HEX '0123456789ABCDEF';
  dcl-s result varchar(140);
  dcl-s i int(10);
  dcl-ds conv;
    c char(1) pos(1);
    u uns(3) pos(1);
  end-ds;

  result = 'x''';
  for i = 1 to %len(i_string);
    c = %subst(i_string: i: 1);
    result += %subst(HEX: %div(u: 16) + 1: 1)
            + %subst(HEX: %rem(u: 16) + 1: 1);
  endfor;
  result += '''';

  return result;
end-proc;

//  Returns the library of file PEEKUSR in the library list.
dcl-proc getPeekLib;
  dcl-pi *n like(lib_t);
  end-pi;

  dcl-ds objd0100 likeds(objd0100_t) inz;
  dcl-ds qObj likeds(qObj_t) inz;
  dcl-ds errCode likeds(errCode_t) inz;

  qObj.name = 'PEEKUSR';
  qObj.lib = '*LIBL';
  errCode.bytPrv = %size(errCode);

  qusrobjd(objd0100: %size(objd0100): 'OBJD0100': qObj: '*FILE': errCode);
  if (errCode.bytAvl > 0);
    fail('Datei PEEKUSR nicht in der Bibliotheksliste gefunden.');
  endif;

  return objd0100.rtnLib;
end-proc;

dcl-proc runSql;
  dcl-pi *n;
    i_stmt varchar(1024) const;
  end-pi;

  runCmd('RUNSQL SQL(''' + %scanrpl('''': '''''': i_stmt) + ''') +
          COMMIT(*NONE)');
end-proc;

dcl-proc runCmd;
  dcl-pi *n;
    i_cmd varchar(2048) const;
  end-pi;

  qcmdexc(i_cmd: %len(i_cmd));
end-proc;

dcl-proc lastMsg;
  dcl-pi *n varchar(300);
  end-pi;

  dcl-ds msg likeds(rtnMsgInfo_t);

  msg = getMonitoredMessage(*on);

  return msg.id + ': ' + msg.txt;
end-proc;
