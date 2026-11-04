**FREE
// ==========================================================================
//  Peek/400 - Unit-Tests der Programme PEEK01, PEEK02, PEEK03, PEEK04,
//  PEEK06, PEEK07, PEEK10 und PEEK11 sowie der Transcoder-Liste von
//  PEEK71 und der Datei PEEKFMT (iRPGUnit).
//
//  Zum Erstellen und Ausführen muss die Peek-Bibliothek (QCOPYLE,
//  Bindeverzeichnis PEEK, PEEKUSR, PEEKFLD, PEEKFMT, Nachrichtendatei
//  PEEKGER) in der Bibliotheksliste stehen.
//
//  Die Tests legen ihre Testdateien in QTEMP an und überschreiben PEEKFLD
//  und PEEKFMT mit QTEMP/PEEKFLD und QTEMP/PEEKFMT. Die Peek-Bibliothek
//  ist die Bibliothek, in der die Datei PEEKUSR in der Bibliotheksliste
//  steht.
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

  //  PEEK01 löscht und schreibt PEEKFLD.
  monitor;
    runCmd('CRTDUPOBJ OBJ(PEEKFLD) FROMLIB(' + %trim(peekLib) + ') +
            OBJTYPE(*FILE) TOLIB(QTEMP) DATA(*NO)');
  on-error;
  endmon;
  runCmd('OVRDBF FILE(PEEKFLD) TOFILE(QTEMP/PEEKFLD) OVRSCOPE(*JOB)');

  //  PEEK10 löscht und schreibt PEEKFMT.
  monitor;
    runCmd('CRTDUPOBJ OBJ(PEEKFMT) FROMLIB(' + %trim(peekLib) + ') +
            OBJTYPE(*FILE) TOLIB(QTEMP) DATA(*NO)');
  on-error;
  endmon;
  runCmd('OVRDBF FILE(PEEKFMT) TOFILE(QTEMP/PEEKFMT) OVRSCOPE(*JOB)');

  monitor;
    runSql('CREATE TABLE QTEMP/PEEKKEYS (KEY CHAR(10) NOT NULL, +
            SEQ NUMERIC(5, 0) NOT NULL, +
            CUSTOMER_NUMBER FOR COLUMN CUSTNBR DECIMAL(7, 0) NOT NULL)');
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
//  Hilfsprozeduren
// ==========================================================================

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
