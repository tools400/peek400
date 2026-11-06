**free
// ==========================================================================
//  Peek/400 - Unit-Tests der Service-Programme PEEK51, PEEK53, PEEK58,
//  PEEK63 und PEEK71 (iRPGUnit).
//
//  Zum Erstellen und Ausführen muss die Peek-Bibliothek (QCOPYLE,
//  Bindeverzeichnis PEEK, PEEKUSR, Nachrichtendatei PEEKGER) in der
//  Bibliotheksliste stehen.
//
//  Die Tests legen ihre Testdateien in QTEMP an. Die Peek-Bibliothek ist
//  die Bibliothek, in der die Datei PEEKUSR in der Bibliotheksliste steht.
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
/copy QCOPYLE,OBJD0100
/copy QCOPYLE,QUSROBJD

/copy QCOPYLE,PPEEK51
/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK63
/copy QCOPYLE,PPEEK71

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
dcl-c TST_FILE 'PEEKTSTPF'; // Tabelle mit den Sätzen B, D, F
dcl-c TST_INDEX 'PEEKTSTI'; // Index über KEY für die CIO-Tests
dcl-c TST_FILE2 'PEEKTST2'; // Tabelle mit 5 Sätzen
dcl-c TST_FMT 'FTST';
dcl-c TST_USRF 'PEEKTSTUSR'; // Kopie von PEEKUSR
dcl-c TST_USER 'TESTUSER';
dcl-c MODE_RR 'rr, arrseq=N, commit=N, nullcap=Y, riofb=Y, secure=Y';

dcl-pr qcmdexc extpgm('QCMDEXC');
  i_cmd    char(32702) options(*varsize) const;
  i_length packed(15: 5) const;
end-pr;

//  Leaves non-pointer data in the second slot of the argument area.
dcl-pr fillArgArea;
  i_a char(10) const;
  i_b char(16) value;
end-pr;

dcl-ds g_hfile likeds(hfile_t) inz;
dcl-s g_lastMsg varchar(600);

// ==========================================================================
//  Setup und Teardown
// ==========================================================================

dcl-proc setUpSuite export;
  dcl-s peekLib like(lib_t);

  peekLib = getPeekLib();
  p_setprdlb(peekLib);

  //  Die Dateien bleiben in QTEMP stehen, wenn die Tests im selben Job
  //  wiederholt werden.
  monitor;
    runSql('CREATE TABLE QTEMP/PEEKTSTPF (KEY CHAR(10) NOT NULL, +
            SEQ NUMERIC(5, 0) NOT NULL, TEXT CHAR(20) NOT NULL) +
            RCDFMT FTST');
    runSql('CREATE INDEX QTEMP/PEEKTSTI ON QTEMP/PEEKTSTPF (KEY)');
  on-error;
  endmon;

  monitor;
    runSql('CREATE TABLE QTEMP/PEEKTST2 (KEY CHAR(10) NOT NULL, +
            SEQ NUMERIC(5, 0) NOT NULL, TEXT CHAR(20) NOT NULL) +
            RCDFMT FTST');
  on-error;
  endmon;

  monitor;
    runCmd('CRTDUPOBJ OBJ(PEEKUSR) FROMLIB(' + %trim(peekLib) + ') +
            OBJTYPE(*FILE) TOLIB(QTEMP) NEWOBJ(PEEKTSTUSR) DATA(*NO)');
  on-error;
  endmon;

  p_setusr(TST_USER: TST_USRF: TST_LIB);
end-proc;

dcl-proc setUp export;
  runSql('DELETE FROM QTEMP/PEEKTSTPF');
  runSql('INSERT INTO QTEMP/PEEKTSTPF VALUES +
          (''B'', 1, ''Bravo''), (''D'', 2, ''Delta''), +
          (''F'', 3, ''Foxtrot'')');
  runSql('DELETE FROM QTEMP/PEEKTST2');
  runSql('INSERT INTO QTEMP/PEEKTST2 VALUES +
          (''A'', 1, ''a''), (''C'', 2, ''c''), (''E'', 3, ''e''), +
          (''G'', 4, ''g''), (''I'', 5, ''i'')');
  runSql('DELETE FROM QTEMP/PEEKTSTUSR');
  runSql('INSERT INTO QTEMP/PEEKTSTUSR VALUES +
          (''TESTUSER'', ''*PGM'', ''*VERSION'', ''x'')');
  g_lastMsg = '';
end-proc;

dcl-proc tearDown export;
  dcl-ds hfile likeds(hfile_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  if (cio_isopen(g_hfile) = bTrue);
    cio_close(g_hfile);
  endif;
  clear g_hfile;

  //  SQL-Cursor von PEEK51 schließen. SQL_close liefert einen Fehler,
  //  wenn kein Cursor offen ist.
  monitor;
    sql_close(hfile: msgid: msgdta);
  on-error;
  endmon;
end-proc;

// ==========================================================================
//  SQL_quote(): Feldnamen in Anführungszeichen einschließen, auch den
//  letzten Feldnamen ohne nachfolgendes Leerzeichen.
// ==========================================================================

dcl-proc test01_sqlQuote_singleField export;
  aEqual('"CUSTNO"': sql_quote('CUSTNO'));
end-proc;

dcl-proc test02_sqlQuote_fieldList export;
  aEqual('"A", "B"': sql_quote('A, B'));
end-proc;

dcl-proc test03_sqlQuote_prepareOrderBy export;
  dcl-s order varchar(512);

  order = sql_quote('KEY');
  assert(prepare(bTrue: TST_FILE: TST_FMT: '': order)
         : 'PREPARE mit ORDER BY ' + order + ' fehlgeschlagen: ' + g_lastMsg);
end-proc;

// ==========================================================================
//  f_bitor(): alle übergebenen Argumente verodern.
// ==========================================================================

dcl-proc test04_fBitOr_threeArguments export;
  iEqual(7: f_bitor(1: 2: 4): 'f_bitor(1: 2: 4)');
end-proc;

// ==========================================================================
//  p_setlldft(): den optionalen Parameter i_key nicht lesen, wenn er
//  nicht übergeben wurde.
// ==========================================================================

dcl-proc test05_pSetllDft_withoutKey export;
  dcl-s key like(key_t);
  dcl-s data like(set0000_t);

  monitor;
    p_setlldft('*PGM');
  on-error;
    fail('p_setlldft(section) ohne i_key bricht ab: ' + lastMsg());
  endmon;

  aEqual('0': f_readedft('*PGM': key: data)
         : 'f_readedft nach p_setlldft(*PGM), 0 = Satz gefunden');
end-proc;

dcl-proc test06_pSetllDft_withoutKey_afterOtherCall export;
  dcl-s key like(key_t);
  dcl-s data like(set0000_t);

  fillArgArea('*PGM': *allx'00');
  monitor;
    p_setlldft('*PGM');
  on-error;
    fail('p_setlldft(section) ohne i_key bricht ab: ' + lastMsg());
  endmon;

  aEqual('0': f_readedft('*PGM': key: data)
         : 'f_readedft nach p_setlldft(*PGM), 0 = Satz gefunden');
end-proc;

// ==========================================================================
//  Transcoder_new(): eine Escape-Nachricht senden, wenn iconv_open()
//  scheitert, statt einen unbrauchbaren Transcoder zu liefern.
// ==========================================================================

dcl-proc test07_transcoderNew_invalidCcsid export;
  dcl-s htranscoder like(htranscoder_t);
  dcl-s buffer char(10) inz('ABC');
  dcl-s length int(10);
  dcl-s result varchar(300);
  dcl-ds msg likeds(rtnMsgInfo_t);

  monitor;
    htranscoder = transcoder_new(37: 99999);
  on-error;
    //  Erwartet: Escape-Nachricht
    msg = getMonitoredMessage(*on);
    aEqual('CPF9897': msg.id: 'Escape-Nachricht von transcoder_new: '
           + msg.txt);
    assert(%scan('Failed to initialize character conversion (errno ': msg.txt)
           = 1: 'Fehlernummer in der Nachricht: ' + msg.txt);
    return;
  endmon;

  monitor;
    length = transcoder_xlatebuffer(htranscoder: %addr(buffer): 3
                                    : %size(buffer));
    result = 'transcoder_xlateBuffer liefert ' + %char(length);
  on-error;
    result = 'transcoder_xlateBuffer bricht ab: ' + lastMsg();
  endmon;

  fail('transcoder_new(37: 99999) kehrt ohne Escape-Nachricht zurück, '
       + result);
end-proc;

// ==========================================================================
//  Transcoder_xlateBuffer(): eine Escape-Nachricht senden, wenn die
//  Umsetzung scheitert, weil die Aufrufer (PEEK06, PEEK18, PEEK45) den
//  Rückgabewert -1 nicht prüfen.
// ==========================================================================

dcl-proc test08_transcoderXlateBuffer_bufferTooSmall export;
  dcl-s htranscoder like(htranscoder_t);
  dcl-s buffer char(3) inz('ABC');
  dcl-s length int(10);
  dcl-ds msg likeds(rtnMsgInfo_t);

  //  'ABC' braucht in UTF-16 sechs Bytes, der Puffer hat nur drei.
  htranscoder = transcoder_new(1200: 37);

  monitor;
    length = transcoder_xlatebuffer(htranscoder: %addr(buffer)
                                    : %size(buffer): %size(buffer));
  on-error;
    //  Erwartet: Escape-Nachricht
    msg = getMonitoredMessage(*on);
    aEqual('CPF9897': msg.id: 'Escape-Nachricht von transcoder_xlateBuffer: '
           + msg.txt);
    assert(%scan('Target buffer too small to hold result (errno '
                  + %char(e2big_c) + '): ': msg.txt) = 1
           : 'Fehlernummer in der Nachricht: ' + msg.txt);
    return;
  endmon;

  fail('transcoder_xlateBuffer kehrt bei zu kleinem Puffer ohne '
       + 'Escape-Nachricht zurück, Rückgabewert ' + %char(length));
end-proc;

// ==========================================================================
//  CIO_setllWithKey() und CIO_setgtWithKey(): Positionieren wie SETLL
//  und SETGT in RPG, auch vor dem ersten und hinter dem letzten Satz.
//  Testdaten: B, D, F
// ==========================================================================

dcl-proc test09_setllBehindLastKey_read export;
  aEqual('*EOF': positionAndRead('SETLL': 'Z': bFalse));
end-proc;

dcl-proc test10_setllBeforeFirstKey_read export;
  aEqual('B': positionAndRead('SETLL': 'A': bFalse));
end-proc;

dcl-proc test11_setllExistingKey_read export;
  aEqual('D': positionAndRead('SETLL': 'D': bFalse));
end-proc;

dcl-proc test12_setllBetweenKeys_read export;
  aEqual('D': positionAndRead('SETLL': 'C': bFalse));
end-proc;

dcl-proc test13_setllBehindLastKey_readp export;
  aEqual('F': positionAndRead('SETLL': 'Z': bTrue));
end-proc;

dcl-proc test14_setllBeforeFirstKey_readp export;
  aEqual('*EOF': positionAndRead('SETLL': 'A': bTrue));
end-proc;

dcl-proc test15_setgtBeforeFirstKey_read export;
  aEqual('B': positionAndRead('SETGT': 'A': bFalse));
end-proc;

dcl-proc test16_setgtExistingKey_read export;
  aEqual('F': positionAndRead('SETGT': 'D': bFalse));
end-proc;

dcl-proc test17_setgtBehindLastKey_read export;
  aEqual('*EOF': positionAndRead('SETGT': 'Z': bFalse));
end-proc;

dcl-proc test18_setgtBeforeFirstKey_readp export;
  aEqual('*EOF': positionAndRead('SETGT': 'A': bTrue));
end-proc;

// ==========================================================================
//  CIO_close(): nach einem gescheiterten CIO_open() einen Fehler
//  liefern, aber nicht abbrechen.
// ==========================================================================

dcl-proc test19_cioClose_afterFailedOpen export;
  dcl-ds hfile likeds(hfile_t);

  assert(not cio_open(hfile: 'NOTEXIST': TST_LIB: 'NOTEXIST': '': MODE_RR)
         : 'Vorbedingung: CIO_open einer nicht vorhandenen Datei war '
         + 'erfolgreich');

  monitor;
    cio_close(hfile);
  on-error;
    fail('CIO_close nach gescheitertem CIO_open bricht ab: ' + lastMsg());
  endmon;
end-proc;

// ==========================================================================
//  SQL_prepareStatement(): Eine Prüfung (i_check = '1') ändert den
//  Zustand des offenen Cursors nicht.
// ==========================================================================

dcl-proc test20_sqlPrepare_checkKeepsCursor export;
  dcl-ds hfile likeds(hfile_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  assert(prepare(bFalse: TST_FILE: TST_FMT: '': '')
         : 'Vorbedingung: PREPARE fehlgeschlagen: ' + g_lastMsg);
  assert(sql_open(hfile: msgid: msgdta)
         : 'Vorbedingung: SQL_open fehlgeschlagen: ' + msgText(msgid: msgdta));

  //  Prüfung einer anderen Datei, wie in PEEK48
  assert(prepare(bTrue: TST_FILE2: TST_FMT: '': '')
         : 'Vorbedingung: Prüfung von PEEKTST2 fehlgeschlagen: ' + g_lastMsg);

  iEqual(3: sql_count()
         : 'SQL_count des offenen Cursors nach Prüfung von PEEKTST2');
end-proc;

dcl-proc test21_sqlOpen_afterFailedCheck export;
  dcl-ds hfile likeds(hfile_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  assert(prepare(bFalse: TST_FILE: TST_FMT: '': '')
         : 'Vorbedingung: PREPARE fehlgeschlagen: ' + g_lastMsg);
  assert(not prepare(bTrue: TST_FILE: TST_FMT: 'NOCOL = 1': '')
         : 'Vorbedingung: Prüfung mit unbekannter Spalte war erfolgreich');

  assert(sql_open(hfile: msgid: msgdta)
         : 'SQL_open nach gescheiterter Prüfung: ' + msgText(msgid: msgdta));
end-proc;

// ==========================================================================
//  SQL_nextRow(): Sätze überlesen, die nach dem Öffnen des Cursors
//  gelöscht wurden.
// ==========================================================================

dcl-proc test22_sqlNextRow_deletedRow export;
  dcl-ds hfile likeds(hfile_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);
  dcl-s buffer like(rcdbuf_t);
  dcl-s nullmap like(nullmap_t) dim(NULL_MAP_SIZE);
  dcl-s isEof like(bool_t);

  //  ORDER BY TEXT erzwingt eine Sortierung (kein Zugriffspfad)
  assert(prepare(bFalse: TST_FILE: TST_FMT: '': '"TEXT" DESC')
         : 'Vorbedingung: PREPARE fehlgeschlagen: ' + g_lastMsg);
  assert(sql_open(hfile: msgid: msgdta)
         : 'Vorbedingung: SQL_open fehlgeschlagen: ' + msgText(msgid: msgdta));

  isEof = sql_nextrow(buffer: nullmap: hfile: msgid: msgdta);
  assert(not isEof: 'Vorbedingung: erster FETCH liefert EOF');
  aEqual('F': %trimr(%subst(buffer: 1: 10)): 'Vorbedingung: erster Satz');

  runSql('DELETE FROM QTEMP/PEEKTSTPF WHERE KEY = ''D''');

  isEof = sql_nextrow(buffer: nullmap: hfile: msgid: msgdta);
  assert(not isEof: 'SQL_nextRow meldet nach dem gelöschten Satz D das '
                    + 'Dateiende (' + msgText(msgid: msgdta) + ')');
  aEqual('B': %trimr(%subst(buffer: 1: 10)): 'Satz nach dem gelöschten Satz D');
end-proc;

// ==========================================================================
//  f_updatusr(): '0' bei Erfolg, '1' bei Fehler, wie f_writeusr().
// ==========================================================================

dcl-proc test23_fUpdatUsr_returnValue export;
  dcl-s data like(set0000_t);

  data = 'first';
  aEqual('0': f_writeusr('CLAUDE': 'KEY1': data)
         : 'Vorbedingung: f_writeusr, 0 = Erfolg');
  aEqual('0': f_updatusr('CLAUDE': 'KEY1': 'second')
         : 'f_updatusr bei vorhandenem Satz, 0 = Erfolg');
  aEqual('1': f_updatusr('CLAUDE': 'NOKEY': 'x')
         : 'f_updatusr bei fehlendem Satz, 1 = Fehler');
end-proc;

// ==========================================================================
//  p_expstr(): Zeichenkette mit Leerzeichen erweitern.
// ==========================================================================

dcl-proc test24_pExpStr_expandsString export;
  dcl-s string like(varString_t);

  string = 'XXXXXXXXXX';
  p_expstr(string: 'ABC': 1);
  aEqual('A B C XXXX': string: 'p_expstr(string: ABC: 1)');
end-proc;

// ==========================================================================
//  f_mapcmdtomsg(): *DELETE bedeutet im Text-Editor PEEK64 'Löschen'
//  (0087), sonst 'Satz löschen' (0023).
// ==========================================================================

dcl-proc test25_fMapCmdToMsg_deleteRecord export;
  aEqual('0023': f_mapcmdtomsg('*DELETE'));
end-proc;

dcl-proc test26_fMapCmdToMsg_deleteInTextEditor export;
  aEqual('0087': f_mapcmdtomsg('*DELETE': '*PEEK64'));
end-proc;

dcl-proc test27_fMapCmdToMsg_insertInTextEditor export;
  aEqual('0086': f_mapcmdtomsg('*INSERT': '*PEEK64'));
end-proc;

// ==========================================================================
//  SQL_count(): Cursor auch nach einem FETCH-Fehler schließen.
//  Letzter Test, weil ein offener Cursor alle folgenden Aufrufe von
//  SQL_count() scheitern ließe.
// ==========================================================================

dcl-proc test28_sqlCount_afterFetchError export;
  assert(prepare(bFalse: TST_FILE: TST_FMT: '1/(SEQ-2) > 0': '')
         : 'Vorbedingung: PREPARE fehlgeschlagen: ' + g_lastMsg);
  iEqual(-1: sql_count(): 'Vorbedingung: SQL_count mit Division durch 0');

  assert(prepare(bFalse: TST_FILE: TST_FMT: '': '')
         : 'PREPARE nach dem Fehler in SQL_count: ' + g_lastMsg);
  iEqual(3: sql_count(): 'SQL_count nach dem Fehler in SQL_count');
end-proc;

// ==========================================================================
//  Hilfsprozeduren
// ==========================================================================

//  Positions the test index with SETLL or SETGT and returns the key of
//  the record read next (READ or READP) or '*EOF'.
dcl-proc positionAndRead;
  dcl-pi *n varchar(10);
    i_operation char(5) const;
    i_key       char(10) const;
    i_readPrv   ind const;
  end-pi;

  dcl-s buffer like(rcdbuf_t);
  dcl-s nullmap like(nullmap_t) dim(NULL_MAP_SIZE);
  dcl-s isEof like(bool_t);

  if (not cio_isopen(g_hfile));
    assert(cio_open(g_hfile: TST_INDEX: TST_LIB: TST_INDEX: '': MODE_RR)
           : 'Vorbedingung: CIO_open fehlgeschlagen');
  endif;

  if (i_operation = 'SETLL');
    cio_setllwithkey(g_hfile: i_key);
  else;
    cio_setgtwithkey(g_hfile: i_key);
  endif;

  if (i_readPrv);
    isEof = cio_readp(g_hfile: bFalse: buffer: nullmap);
  else;
    isEof = cio_read(g_hfile: bFalse: buffer: nullmap);
  endif;

  if (isEof);
    return '*EOF';
  endif;

  return %trimr(%subst(buffer: 1: 10));
end-proc;

//  Prepares an SQL statement for a test file. Returns bTrue on success,
//  else bFalse and the message in g_lastMsg.
dcl-proc prepare;
  dcl-pi *n like(bool_t);
    i_check like(bool_t) const;
    i_file  like(file_t) const;
    i_fmt   like(rcdfmt_t) const;
    i_where varchar(512) const;
    i_order varchar(512) const;
  end-pi;

  dcl-s isOk like(bool_t);
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);

  isOk = sql_preparestatement(i_check: i_file: TST_LIB: i_file: i_fmt
                              : i_where: i_order: msgid: msgdta);
  if (not isOk);
    g_lastMsg = msgText(msgid: msgdta);
  endif;

  return isOk;
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

dcl-proc msgText;
  dcl-pi *n varchar(600);
    i_msgid  like(msgid_t) const;
    i_msgdta like(msgdta_t) const;
  end-pi;

  if (i_msgid = '');
    return '(keine Nachricht)';
  endif;

  return i_msgid + ': ' + %trim(f_msgtext(i_msgid: i_msgdta));
end-proc;

dcl-proc lastMsg;
  dcl-pi *n varchar(300);
  end-pi;

  dcl-ds msg likeds(rtnMsgInfo_t);

  msg = getMonitoredMessage(*on);

  return msg.id + ': ' + msg.txt;
end-proc;

dcl-proc fillArgArea;
  dcl-pi *n;
    i_a char(10) const;
    i_b char(16) value;
  end-pi;
end-proc;
