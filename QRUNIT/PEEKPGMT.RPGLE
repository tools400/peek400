**FREE
// ==========================================================================
//  Peek/400 - Unit-Tests der Programme PEEK01, PEEK02, PEEK03, PEEK04,
//  PEEK06, PEEK07, PEEK10, PEEK11, PEEK15, PEEK18, PEEK19, PEEK20, PEEK22,
//  PEEK23, PEEK27, PEEK31, PEEK33 und PEEK36 sowie der Transcoder-Liste von
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
/copy QCOPYLE,PPEEK33
/copy QCOPYLE,PPEEK36
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK71

dcl-f peekfld disk keyed usropn extfile('QTEMP/PEEKFLD') prefix(k_)
      rename(fpeekfld: rpeekfld);

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
  msg        varchar(16384) options(*varsize: *nopass) const;
end-pr;

dcl-ds rtnMsgInfo_t qualified template;
  id      char(7);
  txt     varchar(256);
  pgm     char(10);
  mod     char(10);
  proc    varchar(256);
  specNb  char(10);
end-ds;

dcl-pr getMonitoredMessage likeds(rtnMsgInfo_t)
       extproc('getMonitoredMessage') opdesc;
  doRmvMsg ind options(*nopass) const;
end-pr;

// --------------------------------------------------------------------------
//  Testumgebung
// --------------------------------------------------------------------------
dcl-c TST_LIB    'QTEMP';
dcl-c TST_FILE   'PEEKKEYS';     // Tabelle mit langem SQL-Spaltennamen
dcl-c TST_CCSID  'PEEKCCSID';    // Tabelle mit nicht umsetzbarer CCSID
dcl-c TST_FLOAT  'PEEKFLOAT';    // Tabelle mit REAL und DOUBLE
dcl-c TST_UTF8   'PEEKUTF8';     // Tabelle mit CHAR CCSID 1208
dcl-c TST_MDY    'PEEKMDY';      // DDS-Datei mit *MDY-Datum, *USA-Zeit
dcl-c TST_EDW    'PEEKEDW';      // DDS-Datei mit langem Editierwort
dcl-c TST_USRF   'PEEKTSTUSR';   // Kopie von PEEKUSR
dcl-c TST_USER   'TESTUSER';

dcl-pr qcmdexc extpgm('QCMDEXC');
  i_cmd    char(32702) const options(*varsize);
  i_length packed(15: 5) const;
end-pr;

// ==========================================================================
//  Setup
// ==========================================================================

dcl-proc setUpSuite export;
  dcl-s peekLib like(lib_t);

  peekLib = getPeekLib();
  p_setprdlb(peekLib);

  //  Die Dateien bleiben in QTEMP stehen, wenn die Tests im selben Job
  //  wiederholt werden.
  monitor;
    runCmd('CRTDUPOBJ OBJ(PEEKUSR) FROMLIB(' + %trim(peekLib) + ') +
            OBJTYPE(*FILE) TOLIB(QTEMP) NEWOBJ(PEEKTSTUSR) DATA(*NO)');
  on-error;
  endmon;
  p_setusr(TST_USER: TST_USRF: TST_LIB);

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
end-proc;

// ==========================================================================
//  PEEK01: Ein Feld, dessen CCSID nicht in die Job-CCSID umgesetzt werden
//  kann (GRAPHIC CCSID 835), darf die Feldliste nicht verhindern.
// ==========================================================================

dcl-proc test01_peek01_unconvertibleCcsid export;
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-s fmtid like(fmtid_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);
  dcl-s ccsid int(10);

  ccsid = findUnconvertibleCcsid(*on);
  if (ccsid = 0);
    fail('Keine GRAPHIC-CCSID gefunden, die nicht in die Job-CCSID '
         + %char(getJobCcsid()) + ' umgesetzt werden kann.');
  endif;

  qfile.name = TST_CCSID;
  qfile.lib = TST_LIB;

  monitor;
    peek01(qfile: TST_CCSID: fmtid: msgid: msgdta);
  on-error;
    fail('PEEK01 bricht bei GRAPHIC CCSID ' + %char(ccsid) + ' ab: '
         + lastMsg());
  endmon;

  aEqual('': msgid: 'PEEK01 msgid (GRAPHIC CCSID ' + %char(ccsid) + ')');
  aEqual('0': isTranscOf('G'): 'PEEKFLD ISTRANSC des Feldes G');
end-proc;

// ==========================================================================
//  PEEK02: Ein QUSLFLD-Fehler (Satzformat nicht vorhanden) ergibt 0 Felder,
//  ohne Escape-Nachricht und ohne DUMP. Ein weiteres *READ liefert nichts.
// ==========================================================================

dcl-proc test02_peek02_unknownFormat export;
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-ds fldl0100 likeds(fldl0100_t) inz;
  dcl-s fmtid like(fmtid_t);
  dcl-s nume like(int4_t);

  qfile.name = TST_FILE;
  qfile.lib = TST_LIB;

  monitor;
    peek02(qfile: 'NOFMT': '*CREATE': nume: fldl0100: fmtid);
    iEqual(0: nume: 'PEEK02 *CREATE mit unbekanntem Satzformat, Anzahl');

    peek02(qfile: 'NOFMT': '*READ': nume: fldl0100: fmtid);
    iEqual(0: nume: 'PEEK02 *READ nach gescheitertem *CREATE, Anzahl');
    aEqual('': fldl0100.f1fnme: 'PEEK02 *READ nach gescheitertem *CREATE');
  on-error;
    fail('PEEK02 bricht ab: ' + lastMsg());
  endmon;
end-proc;

// ==========================================================================
//  PEEK03: SQL-Sortierung über vorhandene Felder. Die Felder werden als
//  Schlüssel markiert und es kommt keine Nachricht USR0006.
// ==========================================================================

dcl-proc test03_peek03_sqlOrder_noUsr0006 export;
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  qfile.name = TST_FILE;
  qfile.lib = TST_LIB;
  loadFields(qfile);

  peek03(qfile: TST_FILE: SQL_SEQ: '"KEY" DESC, "SEQ"': msgid: msgdta);

  iEqual(1: kseqOf('KEY'): 'KSEQ von KEY');
  iEqual(2: kseqOf('SEQ'): 'KSEQ von SEQ');
  aEqual('': msgid: 'PEEK03 msgid bei ORDER BY "KEY" DESC, "SEQ"');
end-proc;

// ==========================================================================
//  PEEK03: SQL-Sortierung über den langen SQL-Namen einer Spalte. Das Feld
//  ist in PEEKFLD unter dem Systemnamen CUSTNBR gespeichert.
// ==========================================================================

dcl-proc test04_peek03_sqlOrder_longName export;
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  qfile.name = TST_FILE;
  qfile.lib = TST_LIB;
  loadFields(qfile);

  peek03(qfile: TST_FILE: SQL_SEQ: '"CUSTOMER_NUMBER", "KEY"'
         : msgid: msgdta);

  iEqual(1: kseqOf('CUSTNBR')
         : 'KSEQ von CUSTNBR nach ORDER BY "CUSTOMER_NUMBER"');
  iEqual(2: kseqOf('KEY'): 'KSEQ von KEY');
  aEqual('': msgid: 'PEEK03 msgid');
end-proc;

// ==========================================================================
//  PEEK04: Datei nicht vorhanden. Ohne Nachricht nimmt PEEK05 an, dass es
//  Schlüsselfelder gibt.
// ==========================================================================

dcl-proc test05_peek04_fileNotFound export;
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  qfile.name = 'NOFILE';
  qfile.lib = TST_LIB;

  monitor;
    peek04(qfile: 'NOFILE': msgid: msgdta);
  on-error;
    fail('PEEK04 bricht ab: ' + lastMsg());
  endmon;

  aEqual('USR0006': msgid
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
  dcl-s attrlen like(int4_t);
  dcl-s attrtyp like(attrtype_t);
  dcl-s attrval like(attrvalue_t);

  monitor;
    peek07('NOTEXIST': bTrue: attrlen: attrtyp: attrval);
  on-error;
    fail('PEEK07 bricht bei einem unbekannten Attribut ab: ' + lastMsg());
  endmon;

  iEqual(0: attrlen: 'PEEK07 Länge bei unbekanntem Attribut');

  peek07('SYSNAME': bTrue: attrlen: attrtyp: attrval);
  iEqual(8: attrlen: 'PEEK07 Länge von SYSNAME');
end-proc;

// ==========================================================================
//  PEEK71: Ein gescheitertes transcoder_new() darf keinen Platz in der
//  Transcoder-Liste belegen, sonst lässt sich nach 64 gescheiterten
//  Versuchen kein Transcoder mehr anlegen.
// ==========================================================================

dcl-proc test10_peek71_failedTranscoderUsesSlot export;
  dcl-s ccsid int(10);
  dcl-s i int(10);
  dcl-s failures int(10);
  dcl-s htranscoder like(htranscoder_t);
  dcl-ds msg likeds(rtnMsgInfo_t);

  ccsid = findUnconvertibleCcsid(*off);
  if (ccsid = 0);
    fail('Keine CCSID gefunden, die nicht in die Job-CCSID '
         + %char(getJobCcsid()) + ' umgesetzt werden kann.');
  endif;

  for i = 1 to 70;
    monitor;
      htranscoder = transcoder_tojobccsid(ccsid);
    on-error;
      msg = getMonitoredMessage(*on);
      if (%scan('Maximum number': msg.txt) = 1);
        leave;
      endif;
      failures += 1;
    endmon;
  endfor;

  monitor;
    htranscoder = transcoder_tojobccsid(37);
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
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-ds rcdl0200 likeds(rcdl0200_t) inz;
  dcl-s nume like(int4_t);

  qfile.name = TST_FILE;
  qfile.lib = TST_LIB;
  peek11(qfile: '*CREATE': nume: rcdl0200);
  iEqual(1: nume: 'PEEK11 *CREATE für ' + TST_FILE + ', Anzahl');

  qfile.name = 'NOFILE';
  monitor;
    peek11(qfile: '*CREATE': nume: rcdl0200);
  on-error;
    fail('PEEK11 *CREATE für NOFILE bricht ab: ' + lastMsg());
  endmon;
  iEqual(0: nume: 'PEEK11 *CREATE für NOFILE, Anzahl');

  peek11(qfile: '*READ': nume: rcdl0200);
  aEqual('': rcdl0200.r2fmtname
         : 'PEEK11 *READ nach gescheitertem *CREATE, Satzformat');
end-proc;

// ==========================================================================
//  PEEK10: Datei nicht vorhanden. PEEK10 meldet USR0002 ("Liste der
//  Satzformate ... konnte nicht abgerufen werden"), PEEK05 bricht dann
//  das Öffnen ab.
// ==========================================================================

dcl-proc test12_peek10_unknownFile export;
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  qfile.name = 'NOFILE';
  qfile.lib = TST_LIB;

  monitor;
    peek10(qfile: msgid: msgdta);
  on-error;
    fail('PEEK10 bricht ab: ' + lastMsg());
  endmon;

  aEqual('USR0002': msgid: 'PEEK10 msgid für NOFILE');
end-proc;

// ==========================================================================
//  PEEKFMT: PEEK10 leert PEEKFMT bei jedem Aufruf und schreibt die
//  Satzformate neu. Mit REUSEDLT(*YES) (CRTPEEKOBJ) sammeln sich dabei
//  keine gelöschten Sätze an.
// ==========================================================================

dcl-proc test13_peekfmt_reuseDeletedRecords export;
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-ds qfmt likeds(qobj_t) inz;
  dcl-ds mbrd0200 likeds(mbrd0200_t) inz;
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);
  dcl-s i int(10);

  qfile.name = TST_FILE;
  qfile.lib = TST_LIB;
  for i = 1 to 3;
    peek10(qfile: msgid: msgdta);
  endfor;

  qfmt.name = 'PEEKFMT';
  qfmt.lib = TST_LIB;
  peek13(qfmt: '*FIRST': mbrd0200);

  iEqual(1: mbrd0200.m2nbrrcdon: 'Sätze in PEEKFMT nach 3 x PEEK10');
  iEqual(0: mbrd0200.m2nbrrcddl
         : 'Gelöschte Sätze in PEEKFMT nach 3 x PEEK10 (REUSEDLT(*YES)?)');
end-proc;

// ==========================================================================
//  PEEK18: Ein Schlüsselfeld, dessen CCSID nicht in die Job-CCSID umgesetzt
//  werden kann (GRAPHIC CCSID 835), darf PEEK18 und damit PEEK19, PEEK20
//  und PEEK05 nicht abbrechen. Die Längen bleiben die, mit denen PEEK20
//  rechnet: extern ein Zeichen je Grafikzeichen, intern die Feldlänge.
// ==========================================================================

dcl-proc test14_peek18_unconvertibleCcsid export;
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-ds fldl0100 likeds(fldl0100_t) inz;
  dcl-ds set0003 likeds(set0003_t) inz;
  dcl-s buffer like(rcdbuf_t);
  dcl-s outbuf like(rcdbuf_t);
  dcl-s outlen like(int4_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);
  dcl-s ccsid int(10);

  ccsid = findUnconvertibleCcsid(*on);
  if (ccsid = 0);
    fail('Keine GRAPHIC-CCSID gefunden, die nicht in die Job-CCSID '
         + %char(getJobCcsid()) + ' umgesetzt werden kann.');
  endif;

  qfile.name = TST_CCSID;
  qfile.lib = TST_LIB;
  setKeys(qfile: '"G"');
  fldl0100 = fieldOf('G');
  set0003 = f_getusrsg('*ACCESSKEY');

  buffer = *allx'40';
  monitor;
    peek18(fldl0100: TST_CCSID: buffer: '*EXTERN': '*CURRENT'
           : outbuf: outlen: msgid: msgdta);
  on-error;
    fail('PEEK18 *EXTERN bricht bei GRAPHIC CCSID ' + %char(ccsid)
         + ' ab: ' + lastMsg());
  endmon;
  iEqual(5 + %len(%trimr(set0003.set_dlmtr)): outlen
         : 'PEEK18 *EXTERN Länge von GRAPHIC(5) mit Trennzeichen');

  buffer = *allx'40';
  monitor;
    peek18(fldl0100: TST_CCSID: buffer: '*INTERN': '*CURRENT'
           : outbuf: outlen: msgid: msgdta);
  on-error;
    fail('PEEK18 *INTERN bricht bei GRAPHIC CCSID ' + %char(ccsid)
         + ' ab: ' + lastMsg());
  endmon;
  iEqual(10: outlen: 'PEEK18 *INTERN Länge von GRAPHIC(5)');
end-proc;

// ==========================================================================
//  PEEK19 und PEEK20: Hinter einem REAL- oder DOUBLE-Schlüsselfeld liest
//  PEEK20 das nächste Feld dort, wo PEEK19 es abgelegt hat (Breite von
//  %editflt, nicht die Feldlänge 4 oder 8).
// ==========================================================================

dcl-proc test15_peek20_floatKey export;
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-ds rcd qualified inz;
    f float(4);
    d float(8);
    c char(5);
  end-ds;
  dcl-s buffer like(rcdbuf_t);
  dcl-s keyval like(keybuf_t);
  dcl-s keybuf like(rcdbuf_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  qfile.name = TST_FLOAT;
  qfile.lib = TST_LIB;
  setKeys(qfile: '"F", "D", "C"');

  rcd.f = 1.5;
  rcd.d = -2.25;
  rcd.c = 'ABCDE';
  buffer = rcd;

  peek19(buffer: keyval: msgid: msgdta);
  peek20(keyval: keybuf: msgid: msgdta);
  aEqual('': msgid: 'PEEK20 msgid');

  rcd = keybuf;
  assert(rcd.f = 1.5: 'F nach PEEK19/PEEK20 ist ' + %char(rcd.f)
         + ', Schlüssel ''' + %trimr(keyval) + '''');
  assert(rcd.d = -2.25: 'D nach PEEK19/PEEK20 ist ' + %char(rcd.d)
         + ', Schlüssel ''' + %trimr(keyval) + '''');
  aEqual('ABCDE': rcd.c: 'C nach PEEK19/PEEK20 (REAL und DOUBLE davor)');
end-proc;

// ==========================================================================
//  PEEK19 und PEEK20 mit CHAR(10) CCSID 1208 = 'ÄÖÜ': Der externe Teil ist
//  10 Zeichen breit, obwohl 'ÄÖÜ' in UTF-8 nur 6 Bytes belegt, und PEEK20
//  macht daraus wieder genau 10 Bytes.
// ==========================================================================

dcl-proc test16_peek20_utf8Key export;
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-ds set0003 likeds(set0003_t) inz;
  dcl-s buffer like(rcdbuf_t);
  dcl-s keyval like(keybuf_t);
  dcl-s keybuf like(rcdbuf_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  qfile.name = TST_UTF8;
  qfile.lib = TST_LIB;
  setKeys(qfile: '"U", "C"');
  set0003 = f_getusrsg('*ACCESSKEY');

  //  U = 'ÄÖÜ' in UTF-8 und 4 Leerzeichen, C = 'ABCDE'
  buffer = x'C384C396C39C20202020' + 'ABCDE';

  peek19(buffer: keyval: msgid: msgdta);
  iEqual(10 + %len(%trimr(set0003.set_dlmtr)) + 1: %scan('ABCDE': keyval)
         : 'Position von C im externen Schlüssel');

  peek20(keyval: keybuf: msgid: msgdta);
  aEqual(hexOf(%subst(buffer: 1: 15)): hexOf(%subst(keybuf: 1: 15))
         : 'Schlüssel nach PEEK19/PEEK20');
end-proc;

// ==========================================================================
//  PEEK18 und PEEK20 lesen *ACCESSKEY bei jedem Aufruf: Nach einer
//  Änderung (ohne Vorzeichen, Trennzeichen |) passen PEEK19 und PEEK20
//  sofort zusammen.
// ==========================================================================

dcl-proc test17_peek18_accessKeyChanged export;
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-ds rcd qualified inz;
    f float(4);
    d float(8);
    c char(5);
  end-ds;
  dcl-ds orig likeds(set0003_t) inz;
  dcl-ds chg likeds(set0003_t) inz;
  dcl-s buffer like(rcdbuf_t);
  dcl-s keyval like(keybuf_t);
  dcl-s keybuf like(rcdbuf_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);
  dcl-s expected varchar(64);

  qfile.name = TST_FLOAT;
  qfile.lib = TST_LIB;
  setKeys(qfile: '"F", "D", "C"');

  rcd.f = 1.5;
  rcd.d = 2.25;
  rcd.c = 'ABCDE';
  buffer = rcd;

  //  Erst mit der bisherigen Einstellung, damit PEEK18 und PEEK20 sie
  //  schon einmal gelesen haben.
  orig = f_getusrsg('*ACCESSKEY');
  peek19(buffer: keyval: msgid: msgdta);
  peek20(keyval: keybuf: msgid: msgdta);

  chg = orig;
  chg.set_signx = bFalse;
  chg.set_dlmtr = '|';
  p_updusrsg('*ACCESSKEY': chg);
  monitor;
    peek19(buffer: keyval: msgid: msgdta);
    peek20(keyval: keybuf: msgid: msgdta);
  on-error;
    p_updusrsg('*ACCESSKEY': orig);
    fail('PEEK19/PEEK20 brechen nach Änderung von *ACCESSKEY ab: '
         + lastMsg());
  endmon;
  p_updusrsg('*ACCESSKEY': orig);

  //  %editflt ohne führendes Vorzeichen (PEEK18 F_to_extern)
  expected = %subst(%editflt(rcd.f): 2) + '|'
           + %subst(%editflt(rcd.d): 2) + '|ABCDE|';
  aEqual(expected: %trimr(keyval): 'PEEK19 ohne Vorzeichen, Trennzeichen |');

  rcd = keybuf;
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
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-s buffer like(rcdbuf_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  crtDdsFile(TST_MDY
             : '     A          R PEEKMDY'
             : '     A            ID             5S 0'
             : '     A            DMDY            L         +
DATFMT(*MDY) DATSEP(''/'')'
             : '     A            TUSA            T         TIMFMT(*USA)'
             : '     A          K ID');

  qfile.name = TST_MDY;
  qfile.lib = TST_LIB;
  loadFields(qfile);

  monitor;
    peek20('*PHIVAL': buffer: msgid: msgdta);
  on-error;
    fail('PEEK20 *PHIVAL bricht bei *MDY/*USA ab: ' + lastMsg());
  endmon;
  aEqual('': msgid: 'PEEK20 *PHIVAL msgid');
  chkMdyUsa(buffer: '*PHIVAL');

  monitor;
    peek20('*PLOVAL': buffer: msgid: msgdta);
  on-error;
    fail('PEEK20 *PLOVAL bricht bei *MDY/*USA ab: ' + lastMsg());
  endmon;
  aEqual('': msgid: 'PEEK20 *PLOVAL msgid');
  chkMdyUsa(buffer: '*PLOVAL');
end-proc;

//  Felder ohne Schlüssel gelten in PEEK18 als absteigend, *HIVAL und
//  *LOVAL tauschen dort. Geprüft wird deshalb nur, dass DMDY und TUSA
//  einen der beiden Grenzwerte im Format des Feldes enthalten.
dcl-proc chkMdyUsa;
  dcl-pi *n;
    i_buffer like(rcdbuf_t) const;
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
  dcl-ds qfile likeds(qobj_t) inz;
  dcl-s scnnbrs like(int2_t);
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

  qfile.name = TST_EDW;
  qfile.lib = TST_LIB;
  loadFields(qfile);

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

  scnnbrs = 0;
  stage = 0;
  monitor;
    peek15(qfile: scnnbrs: bFalse: stage: 10);
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

  iEqual(1: scnnbrs: 'PEEK15 Anzahl Bildschirme');
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
  dcl-s fkeys like(fkeydsp_t) dim(32);
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
  dcl-s fkeys like(fkeydsp_t) dim(32);
  dcl-s n like(int4_t);
  dcl-s i like(int4_t);
  dcl-s gaps varchar(256) inz;

  peek22('*REPLACE': '*PEEK14');
  f_deletusr('*PEEK14': '*F24');

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
  dcl-s fkeys like(fkeydsp_t) dim(32);
  dcl-s n like(int4_t);
  dcl-s i like(int4_t);
  dcl-s key like(key_t);
  dcl-s data like(set0000_t);

  peek22('*REPLACE': '*PEEK14');
  for i = 1 to 24;
    key = '*F' + %editc(%dec(i: 2: 0): 'X');
    f_deletusr('*PEEK14': key);
  endfor;

  for i = 1 to 21;
    key = '*F' + %editc(%dec(i: 2: 0): 'X');
    data = '*REFRESH';
    f_writeusr('*PEEK14': key: data);
  endfor;
  data = '*MOREKEYS';
  f_writeusr('*PEEK14': '*F24': data);

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
  dcl-s fkeys like(fkeydsp_t) dim(32);
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
  f_writeusr('*PEEK37': '2': data);

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
  dcl-s excl like(pgmcmd_t) dim(25);
  dcl-s data like(set0000_t);
  dcl-s all varchar(2500) inz;
  dcl-s i like(int4_t);

  //  PEEK56: Option 2 und zusätzlich L mit *SLCLAYOUT
  peek22('*REPLACE': '*PEEK56');
  data = '*SLCLAYOUT';
  f_writeusr('*PEEK56': 'L': data);
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
  f_writeusr('*PEEK68': '2': data);
  data = '*COPY';
  f_writeusr('*PEEK68': '3': data);
  data = '*DELETE';
  f_writeusr('*PEEK68': '4': data);
  data = '*DISPLAY';
  f_writeusr('*PEEK68': '5': data);

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
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  orig = f_getusrsg('*LANGUAGE');
  set0004 = orig;
  set0004.set_lang = 'XYZ';
  p_updusrsg('*LANGUAGE': set0004);

  lang = '*DFT';
  monitor;
    peek31(lang: 'PEEK': msgid: msgdta);
  on-error;
    p_updusrsg('*LANGUAGE': orig);
    fail('PEEK31 bricht ab: ' + lastMsg());
  endmon;

  set0004 = f_getusrsg('*LANGUAGE');
  p_updusrsg('*LANGUAGE': orig);

  aEqual('': msgid: 'Nachricht');
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
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  orig = f_getusrsg('*LANGUAGE');
  set0004 = orig;
  set0004.set_lang = 'XYZ';
  p_updusrsg('*LANGUAGE': set0004);

  lang = 'GER';
  peek31(lang: 'PEEK': msgid: msgdta);

  set0004 = f_getusrsg('*LANGUAGE');
  p_updusrsg('*LANGUAGE': orig);

  aEqual('': msgid: 'Nachricht');
  aEqual('GER': lang: 'Verwendete Sprache');
  aEqual('GER': set0004.set_lang: 'Gespeicherte Sprache');
end-proc;

// ==========================================================================
//  PEEK31: Fehlt auch die Nachrichtendatei für GER, kommt CPF2407 mit
//  Datei und Bibliothek statt eines deutschen Textes.
// ==========================================================================

dcl-proc test31_peek31_missingMsgf export;
  dcl-s lang like(language_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  lang = 'GER';
  peek31(lang: 'XXXX': msgid: msgdta);

  aEqual('CPF2407': msgid: 'Nachricht');
  aEqual('XXXXGER   ' + getPeekLib(): %subst(msgdta: 1: 20): 'Daten');
  aEqual('': lang: 'Sprache');
end-proc;

// ==========================================================================
//  PEEK33: Nach dem letzten Migrationsschritt wird die aktuelle Version
//  gespeichert.
// ==========================================================================

dcl-proc test32_peek33_versionRaised export;
  dcl-ds set0007 likeds(set0007_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  set0007 = f_getusrsg('*VERSION');
  set0007.set_vsn = 'V04R00M08';
  p_updusrsg('*VERSION': set0007);

  peek33('V04R00M09': msgid: msgdta);

  set0007 = f_getusrsg('*VERSION');
  aEqual('V04R00M09': set0007.set_vsn: 'Gespeicherte Version');
end-proc;

// ==========================================================================
//  Hilfsprozeduren
// ==========================================================================

//  Sets the data of a key in the user settings (TESTUSER).
dcl-proc setUsrData;
  dcl-pi *n;
    i_section like(section_t) const;
    i_key     like(key_t) const;
    i_data    varchar(256) const;
  end-pi;

  dcl-s data like(set0000_t);

  data = i_data;
  if (f_updatusr(i_section: i_key: data) = bTrue);
    f_writeusr(i_section: i_key: data);
  endif;
end-proc;

//  Returns ' <section>/<key>' if the key is missing or still '*CHANGED'.
dcl-proc chkUsrReset;
  dcl-pi *n varchar(100);
    i_section like(section_t) const;
    i_key     like(key_t) const;
  end-pi;

  dcl-s data like(set0000_t);

  if (f_chainusr(i_section: i_key: data) = bTrue);
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
    i_value     varchar(26) const;
    i_msgid     char(7) const;
  end-pi;

  dcl-s buffer like(smallBuffer_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  buffer = i_value;
  monitor;
    peek36(buffer: i_type: i_format: i_separator: msgid: msgdta);
  on-error;
    fail('PEEK36 bricht bei ' + i_type + ' ' + i_format + ' '''
         + i_value + ''' ab: ' + lastMsg());
  endmon;

  aEqual(i_msgid: msgid: 'PEEK36 ' + i_type + ' ' + i_format + ' '''
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
    i_line5 varchar(80) const options(*nopass);
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
  dcl-s htranscoder like(htranscoder_t);
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
    //  transcoder_new() does not add the transcoder to the list.
    isConvertible = *on;
    monitor;
      htranscoder = transcoder_new(getJobCcsid(): candidates(i));
      transcoder_delete(htranscoder);
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
    return jobi0400.dftccsid;
  endif;

  return jobi0400.ccsid;
end-proc;

//  Fills PEEKFLD with the fields of the file (PEEK01).
dcl-proc loadFields;
  dcl-pi *n;
    i_qfile likeds(qobj_t) const;
  end-pi;

  dcl-s fmtid like(fmtid_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  peek01(i_qfile: i_qfile.name: fmtid: msgid: msgdta);
  if (msgid <> '');
    fail('PEEK01 für ' + %trim(i_qfile.name) + ': ' + msgid);
  endif;
end-proc;

//  Fills PEEKFLD with the fields of the file and marks the fields of
//  i_order as key fields (PEEK01, PEEK03).
dcl-proc setKeys;
  dcl-pi *n;
    i_qfile likeds(qobj_t) const;
    i_order varchar(256) const;
  end-pi;

  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  loadFields(i_qfile);
  peek03(i_qfile: i_qfile.name: SQL_SEQ: i_order: msgid: msgdta);
  if (msgid <> '');
    fail('PEEK03 für ' + %trim(i_qfile.name) + ': ' + msgid);
  endif;
end-proc;

//  Returns the field description of a field in QTEMP/PEEKFLD.
dcl-proc fieldOf;
  dcl-pi *n likeds(fldl0100_t);
    i_field char(10) const;
  end-pi;

  dcl-ds fldl0100 likeds(fldl0100_t) inz;
  dcl-s isFound ind;

  open peekfld;
  chain i_field rpeekfld;
  isFound = %found(peekfld);
  if (isFound);
    fldl0100 = k_ffd;
  endif;
  close peekfld;

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

  open peekfld;
  chain i_field rpeekfld;
  if (%found(peekfld));
    kseq = k_kseq;
  else;
    kseq = -1;
  endif;
  close peekfld;

  return kseq;
end-proc;

//  Returns ISTRANSC of a field in QTEMP/PEEKFLD, '?' if not found.
dcl-proc isTranscOf;
  dcl-pi *n char(1);
    i_field char(10) const;
  end-pi;

  dcl-s isTransc char(1);

  open peekfld;
  chain i_field rpeekfld;
  if (%found(peekfld));
    isTransc = k_istransc;
  else;
    isTransc = '?';
  endif;
  close peekfld;

  return isTransc;
end-proc;

//  Formats a REAL or DOUBLE value with PEEK06.
dcl-proc editFloat;
  dcl-pi *n varchar(64);
    i_pValue pointer value;
    i_length int(10) const;
  end-pi;

  dcl-ds fldl0100 likeds(fldl0100_t) inz;
  dcl-s srcvar like(rcdbuf_t);
  dcl-s string like(rcdbuf_t);
  dcl-s strlen like(int4_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);
  dcl-s value char(8) based(i_pValue);

  fldl0100.f1fnme = 'FLOAT';
  fldl0100.f1dtyp = 'F';
  fldl0100.f1ibuf = 1;
  fldl0100.f1obuf = 1;
  fldl0100.f1flen = i_length;
  fldl0100.f1vfmi = '0';

  srcvar = %subst(value: 1: i_length);
  peek06(fldl0100: 'FLDL0100': srcvar: bFalse: bTrue
         : string: strlen: msgid: msgdta);

  return %trimr(%subst(string: 1: 64));
end-proc;

//  Formats a packed value with PEEK06.
dcl-proc editPacked;
  dcl-pi *n varchar(64);
    i_pValue  pointer value;
    i_digits  int(10) const;
    i_edtcde  char(1) const;
    i_edtwrd  varchar(64) const;
  end-pi;

  dcl-ds fldl0100 likeds(fldl0100_t) inz;
  dcl-s srcvar like(rcdbuf_t);
  dcl-s string like(rcdbuf_t);
  dcl-s strlen like(int4_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);
  dcl-s value char(16) based(i_pValue);

  fldl0100.f1fnme = 'PACKED';
  fldl0100.f1dtyp = 'P';
  fldl0100.f1ibuf = 1;
  fldl0100.f1obuf = 1;
  fldl0100.f1flen = %div(i_digits: 2) + 1;
  fldl0100.f1digt = i_digits;
  fldl0100.f1decp = 0;
  fldl0100.f1vfmi = '0';
  fldl0100.f1edtc = i_edtcde;
  fldl0100.f1edwd = i_edtwrd;
  fldl0100.f1edwl = %len(i_edtwrd);

  srcvar = %subst(value: 1: fldl0100.f1flen);
  peek06(fldl0100: 'FLDL0100': srcvar: bFalse: bTrue
         : string: strlen: msgid: msgdta);

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
  dcl-ds qobj likeds(qobj_t) inz;
  dcl-ds errCode likeds(errCode_t) inz;

  qobj.name = 'PEEKUSR';
  qobj.lib = '*LIBL';
  errCode.bytprv = %size(errCode);

  qusrobjd(objd0100: %size(objd0100): 'OBJD0100': qobj: '*FILE': errCode);
  if (errCode.bytavl > 0);
    fail('Datei PEEKUSR nicht in der Bibliotheksliste gefunden.');
  endif;

  return objd0100.rtnlib;
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
