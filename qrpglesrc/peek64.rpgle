**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Feldeditor                                   *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 3.0.0                               *
//  Programm : PEEK64                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 26.04.2007                                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Feldeditor                                        *
//                                                               *
// ============================================================= *
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peek64fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-f peekFld keyed usropn prefix(f_) infds(peek_01_ds);

dcl-ds workstn likeds(workstn_t);

dcl-ds peek_01_ds likeds(infds_t);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/d_infds.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/d_coloratr.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/copy 'qcopyle/usr8100.rpgleinc'
/copy 'qcopyle/usr8123.rpgleinc'
/copy 'qcopyle/usr8136.rpgleinc'
/copy 'qcopyle/usr8240.rpgleinc'
/copy 'qcopyle/usr8241.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek64.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'
/copy 'qcopyle/ppeek71.rpgleinc'

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-s yPgmCmd like(pgmCmd_t);
dcl-s yCmdDta like(pgmCmdDt_t);
dcl-s yMsgID like(msgId_t);
dcl-s yMsgDta like(msgDta_t);

dcl-s yFKeys like(fKeyDsp_t) dim(32);
dcl-s yNbrOfKeys like(int4_t) inz;
dcl-s yExclKeys like(pgmCmd_t) dim(25);

dcl-s sfBot like(int4_t);
dcl-c NBR_F_KEYS 3;

dcl-s peek21_name like(pgmCallN_t);
dcl-s peek23_name like(pgmCallN_t);

// Arbeitsfelder
dcl-s isPgmError like(bool_t) inz(bFalse);
dcl-s isDataChg like(bool_t) inz(bFalse);

dcl-ds buffer qualified;
  offset         int(10) inz;
  maxLength      int(10) inz;
  trimLength     int(10) inz;
  pFldInhaltSbcs like(rcdBuf_t) inz;
  pFldInhaltUcs2 like(rcdBufUcs2_t) overlay(pFldInhaltSbcs) inz;
end-ds;

dcl-s maxEditLength int(10);

dcl-ds *n;
  #ucs2Str ucs2(704) pos(1);
  #ucs2    ucs2(64) ccsid(13488) dim(11) pos(1);
end-ds;

dcl-ds cursorPosition likeds(cursorPosition_t) inz;

dcl-c MODE_OFF '*N';
dcl-c MODE_INSERT '*INSERT';
dcl-c MODE_DELETE '*DELETE';

dcl-ds insDel qualified inz;
  mode     char(10);
  startPos int(10);
  endPos   int(10);
end-ds;

dcl-s start int(10);
dcl-s length int(10);
dcl-s relPos int(10);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek64;
  i_dsp80      like(dsp80_t) const;
  i_headType   like(headTyp_t) const;
  i_copyright  like(copyright_t) const;
  i_fldName    like(fieldNme_t) const;
  io_fldInhalt likeds(fldInhalt_t);
  io_length    like(int4_t);
  i_protect    like(bool_t) const;
  i_isUcs2     like(int4_t) const;
  o_msgID      like(msgId_t);
  o_msgDta     like(msgDta_t);
end-pi;

dcl-ds f_key likerec(fpeekfld: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler'): *null: *omit);

exsr inzsr;

exsr first;
if (isPgmError = bFalse);

  dow ('1');

    //  Nachrichten anzeigen
    *in89 = *off;
    write msgCtl;

    //  Anzeigen der Befehlstasten
    select;
    when ((sfBot = 2) and
       (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
      write pbbot#2;
    when ((sfBot = 3) and
       (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
      write pbbot#3;
    when ((sfBot = 4) and
       (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
      write pbbot#4;
    when ((sfBot = 5) and
       (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
      write pbbot#5;
    when ((sfBot = 6) and
       (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
      write pbbot#6;
    when ((sfBot = 7) and
       (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
      write pbbot#7;
    when ((sfBot = 8) and
       (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
      write pbbot#8;
    other;
      write pbbot#1;
      sfBot = 1;
    endsl;

    // Übertragen Buffer in Bildschirmfelder
    exsr bufferToScreen;

    // Anzeigen Cursorposition im Feld #STRING/
    if (isCursorDataField());
      $csrPos = h_csrPos + buffer.offset;
    else;
      $csrPos = 0;
    endif;

    //  Anzeigen Bildschirm
    exfmt bild01;

    //  Übertragen Bildschirmfelder in Buffer
    exsr screenToBuffer;

    //  Berechnen Zeile/Spalte
    cursorPosition.row = workstn.csrPos / 256;
    cursorPosition.column = %rem(workstn.csrPos: 256);

    // Löschen Cursorposition
    h_csrRow = 0;
    h_csrCol = 0;

    // Erzwingen Prüfung der Eingabedaten ...
    select;
    when (isPgmError);
      isDataChg = bTrue;
    when (isCursorDataField() and h_csrPos <> 0 and $csrPos <> h_csrPos);
      isDataChg = bTrue;
    other;
      isDataChg = *in93;
    endsl;

    //  Nachrichten löschen
    p_rmvPgmMg(sds.pgmName);

    //  Bezugszahlen löschen
    exsr bzoff1;

    //  Mappen der gedrückten Taste
    //  in Programmbefehl
    peek21(workstn.aid: sds.pgmName: yPgmCmd: yCmdDta: yMsgID: yMsgDta
          : yExclKeys);
    if (yMsgID <> ' ');
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
      iter;
    endif;

    //  Abfragen der Programmbefehle
    select;
    //  F3  - Ende
    when (yPgmCmd = '*EXIT' or yPgmCmd = '*NO');
      exsr c_endPgm;
      leave;

    //  F5  - Aktualisieren
    when (yPgmCmd = '*REFRESH');
      exsr c_refresh;
      iter;

    //  F7  - Startposition
    when (yPgmCmd = '*INSERT' and not i_protect);
      exsr c_insert;
      iter;

    //  F8  - Endposition
    when (yPgmCmd = '*DELETE' and not i_protect);
      exsr c_delete;
      iter;

    //  F12 - Ende
    when (yPgmCmd = '*CANCEL');
      exsr c_endPgm;
      leave;

    //  F17 - an den Afang gehen
    when (yPgmCmd = '*FIRSTPOS');
      exsr c_firstPos;

    //  F18 - ans Ende gehen
    when (yPgmCmd = '*LASTPOS');
      exsr c_lastPos;

    //  F19 - nach rechts verschieben
    when (yPgmCmd = '*LEFT');
      exsr c_moveLeft;

    //  F20 - nach links verschieben
    when (yPgmCmd = '*RIGHT');
      exsr c_moveRight;

    //  F24 - Weitere Tasten
    when (yPgmCmd = '*MOREKEYS');
      exsr c_moreKeys;

    //  Page up
    when (yPgmCmd = '*PAGEUP');
      exsr c_pageUp;

    //  Page down
    when (yPgmCmd = '*PAGEDOWN');
      exsr c_pageDown;

    //  Datenfreigabe
    when (yPgmCmd = '*ENTER' or yPgmCmd = '*OK');
      exsr c_enter;
      if (isPgmError = bFalse and not isDataChg);
        o_msgID  = 'USR8112';
        o_msgDta = ' ';

        if (i_isUcs2 = 0);
          io_fldInhalt.sbcs = buffer.pFldInhaltSbcs;
        else;
          io_fldInhalt.ucs2 = buffer.pFldInhaltUcs2;
        endif;

        io_length = buffer.maxLength;
        leave;
      endif;

    other;
      //  Falsche Taste gedrückt
      p_wrongKey(workstn.aid: sds.pgmName);
      iter;
    endsl;

  enddo;

endif;

if (%open(peekFld));
  close peekFld;
endif;

close peek64fm;

return;

//============================================================*
//    keepCsrPos    Beibehalten der Cursorposition            *
//============================================================*

begsr keepCsrPos;

  //  Beibehalten der Cursorosition
  h_csrRow = cursorPosition.row - zei;
  h_csrCol = cursorPosition.column - pos - 1;

endsr;

//============================================================*
//    Beenden Funktion Einfügen/Löschen                       *
//============================================================*

begsr endInsDel;

  insDel.mode = MODE_OFF;
  insDel.startPos = 0;
  insDel.endPos = 0;
  *in61 = bFalse;
  *in62 = bFalse;

endsr;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  //  Prüfen der Eingaben
  exsr prfB1;

  if (not isPgmError);

    // Verarbeiten der Optionen Einfügen/Löschen
    if (#selStart <> insDel.startPos);
      insDel.startPos = #selStart;
      select;
      when (insDel.mode = MODE_INSERT and insDel.endPos > 0);
      // p_sndPgmMg('USR8237': '': sds.pgmname);
      when (insDel.mode = MODE_DELETE and insDel.endPos > 0);
      // p_sndPgmMg('USR8239': '': sds.pgmname);
      endsl;
    endif;

    if (#selLength + insDel.startPos - 1 <> insDel.endPos);
      insDel.endPos = #selLength + insDel.startPos - 1;
      select;
      when (insDel.mode = MODE_INSERT and insDel.endPos > 0);
      // p_sndPgmMg('USR8237': '': sds.pgmname);
      when (insDel.mode = MODE_DELETE and insDel.endPos > 0);
      // p_sndPgmMg('USR8239': '': sds.pgmname);
      endsl;
    endif;

    if (#selStart = 0 and #selLength = 0 and insDel.mode <> MODE_OFF);
      exsr endInsDel;
    endif;

    if (insDel.mode <> MODE_OFF);
      //  Cursor auf die Startposition setzen, wenn sie angezeigt wird.
      //  Das Textfeld beginnt im Fenster (zei/pos) in Zeile 8, Spalte 4
      //  und hat %len(#ucs2_1) Zeichen je Zeile.
      relPos = insDel.startPos - buffer.offset;
      if (relPos >= 1 and relPos <= maxEditLength);
        cursorPosition.row = zei + 8 + %div(relPos - 1: %len(#ucs2_1));
        cursorPosition.column = pos + 5 + %rem(relPos - 1: %len(#ucs2_1));
      else;
        clear cursorPosition;
      endif;

      select;
      when (insDel.MODE = MODE_INSERT);
        exsr doInsert;
      when (insDel.MODE = MODE_DELETE);
        exsr doDelete;
      endsl;
      isDataChg = bTrue;
    endif;

  endif;

  // Bildschirm neu aufbauen
  if (not isPgmError);
    buffer.offset = #startPos - 1;
    exsr fill##;
  endif;

  if (not isPgmError and cursorPosition.row > 0);
    exsr keepCsrPos;
  endif;

endsr;

//============================================================*
//    Einfügen Leerzeichen                                    *
//============================================================*

begsr doInsert;

  if (insDel.startPos = 0 or insDel.endPos = 0);
    leavesr;
  endif;

  length = insDel.endPos - insDel.startPos + 1;
  start = insDel.startPos + length;

  if (i_isUcs2 = 0);
    %subst(buffer.pFldInhaltSbcs: start) = %subst(buffer.pFldInhaltSbcs: insDel.startPos);
    %subst(buffer.pFldInhaltSbcs: insDel.startPos: length) = '';
  else;
    %subst(buffer.pFldInhaltUcs2: start) = %subst(buffer.pFldInhaltUcs2: insDel.startPos);
    %subst(buffer.pFldInhaltUcs2: insDel.startPos: length) = '';
  endif;

  exsr setTrimLength;

  exsr endInsDel;

  isDataChg = bTrue;

endsr;

//============================================================*
//    Löschen ausgewählten Bereich                            *
//============================================================*

begsr doDelete;

  if (insDel.startPos = 0 or insDel.endPos = 0);
    leavesr;
  endif;

  length = insDel.endPos - insDel.startPos + 1;
  start = insDel.startPos + length;

  if (i_isUcs2 = 0);
    %subst(buffer.pFldInhaltSbcs: insDel.startPos) = %subst(buffer.pFldInhaltSbcs: start);
    %subst(buffer.pFldInhaltSbcs: buffer.maxLength - length + 1: length) = '';
  else;
    %subst(buffer.pFldInhaltUcs2: insDel.startPos) = %subst(buffer.pFldInhaltUcs2: start);
    %subst(buffer.pFldInhaltUcs2: buffer.maxLength - length + 1: length) = '';
  endif;

  exsr setTrimLength;

  exsr endInsDel;

  isDataChg = bTrue;

endsr;

//============================================================*
//    Aktualisieren Buffer                                    *
//============================================================*

begsr screenToBuffer;

  //  isDataChg ist hier noch der Stand des vorherigen Durchlaufs; eine
  //  Änderung auf dem gerade gelesenen Bildschirm meldet *IN93.
  if (isDataChg or *in93 = *on);

    if (i_isUcs2 = 0);
    //    Nothing to do here
    else;
      #ucs2(1) = #ucs2_1;
      #ucs2(2) = #ucs2_2;
      #ucs2(3) = #ucs2_3;
      #ucs2(4) = #ucs2_4;
      #ucs2(5) = #ucs2_5;
      #ucs2(6) = #ucs2_6;
      #ucs2(7) = #ucs2_7;
      #ucs2(8) = #ucs2_8;
      #ucs2(9) = #ucs2_9;
      #ucs2(10) = #ucs2_10;
      #ucs2(11) = #ucs2_11;
    endif;

    start = buffer.offset + 1;
    if (buffer.offset + maxEditLength > buffer.maxLength);
      length = buffer.maxLength - buffer.offset;
    else;
      length = maxEditLength;
    endif;

    //  ... aktualisieren Buffer
    if (i_isUcs2 = 0);
      %subst(buffer.pFldInhaltSbcs: start: length) = %subst(#string: 1: length);
    else;
      %subst(buffer.pFldInhaltUcs2: start: length) = %subst(#ucs2Str: 1: length);
    endif;

    exsr setTrimLength;

  endif;

endsr;

//============================================================*
//    bzoff1        Ausschalten aller Fehlerbezugszahlen      *
//============================================================*

begsr bzoff1;

  //  DSPATR(PC)
  *in20 = *off; // #STARTPOS
  *in21 = *off; // #LENGTH
  *in22 = *off; // #STRING/#UCS2
  *in23 = *off; // #SELSTART
  *in24 = *off; // #SELLENGTH

  //  DSPATR(RI)
  *in30 = *off; // #STRING/#UCS2
  *in31 = *off; // #LENGTH
  *in32 = *off; // #STRING/#UCS2
  *in33 = *off; // #SELSTART
  *in34 = *off; // #SELLENGTH

endsr;

//============================================================*
//    prfb1         Prüfen der Eingaben                       *
//============================================================*

begsr prfB1;

  isPgmError = bFalse;

  //  Startposition
  exsr prf20;
  if (isPgmError = bTrue);
    leavesr;
  endif;

  //  Feldlänge und Dateninhalt
  exsr prf22;
  if (isPgmError = bTrue);
    leavesr;
  endif;

  //  Startposition (Einfügen/Löschen)
  exsr prf23;
  if (isPgmError = bTrue);
    leavesr;
  endif;

  //  Länge/bis (Einfügen/Löschen)
  exsr prf24;
  if (isPgmError = bTrue);
    leavesr;
  endif;

endsr;

//============================================================*
//    Prüfen:  Startposition                                  *
//============================================================*

begsr prf20;

  dou ('1');

    if (#startPos <= 0);
      p_sndPgmMg('USR8178': '': sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

    if (#startPos > buffer.maxLength);
      p_sndPgmMg('USR8177': '': sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

  enddo;

  if (isPgmError = bTrue);
    *in20 = *on;
    *in30 = *on;
  endif;

endsr;

//============================================================*
//    Feldlänge und Dateninhalt                               *
//============================================================*

begsr prf22;

  dou ('1');

    if (buffer.offset + maxEditLength > buffer.maxLength);
      start = buffer.maxLength - buffer.offset + 1;
      if (i_isUcs2 = 0);
        isPgmError = %subst(#string: start) <> '';
      else;
        isPgmError = %subst(#ucs2Str: start) <> '';
      endif;

      if (isPgmError);
        p_sndPgmMg('USR8176': '': sds.pgmName); // Warning: String too long.
        leave;
      endif;
    endif;

  enddo;

  if (isPgmError = bTrue);
    *in22 = *on;
    *in32 = *on;
  endif;

endsr;

//============================================================*
//    Kopieren/Löschen: Startposition                         *
//============================================================*

begsr prf23;

  if (insDel.mode = MODE_OFF);
    leavesr;
  endif;

  dou ('1');

    if (#selStart <= 0);
      p_sndPgmMg('USR8178': '': sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

    if (#selStart > buffer.maxLength);
      p_sndPgmMg('USR8177': '': sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

  enddo;

  if (isPgmError);
    *in23 = *on;
    *in33 = *on;
  endif;

endsr;

//============================================================*
//    Kopieren/Löschen: Länge                                 *
//============================================================*

begsr prf24;

  if (insDel.mode = MODE_OFF);
    leavesr;
  endif;

  dou ('1');

    if (#selLength <= 0);
      clear usr8240;
      usr8240.var1 = 1;
      p_sndPgmMg('USR8240': usr8240: sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

    if (insDel.mode = MODE_DELETE);
      // Löschen von Zeichen
      if (#selStart + #selLength - 1 > buffer.maxLength);
        clear usr8241;
        usr8241.var1 = (#selStart + #selLength - 1) - buffer.maxLength;
        p_sndPgmMg('USR8241': usr8241: sds.pgmName);
        isPgmError = bTrue;
        leave;
      endif;
    else;
      // Einfügen von Leerzeichen
      if (buffer.trimLength + #selLength > buffer.maxLength);
        clear usr8241;
        usr8241.var1 = (buffer.trimLength + #selLength) - buffer.maxLength;
        p_sndPgmMg('USR8241': usr8241: sds.pgmName);
        isPgmError = bTrue;
        leave;
      endif;
    endif;

  enddo;

  if (isPgmError);
    *in24 = *on;
    *in34 = *on;
  endif;

endsr;

//============================================================*
//    c_endPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endPgm;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8100';

  select;
  when (workstn.aid = k_f3);
    usr8100.var1 = 'F3';
  when (workstn.aid = k_f12);
    usr8100.var1 = 'F12';
  other;
    usr8100.var1 = 'Fxx';
  endsl;

  o_msgDta = usr8100;

endsr;

//============================================================*
//    Setzen Startposition für Kopieren/Löschen               *
//============================================================*

begsr c_insert;

  select;
  when (insDel.mode <> MODE_INSERT);
    exsr endInsDel;
    insDel.mode = MODE_INSERT;
    *in61 = bTrue;
    *in62 = bFalse;
    p_sndPgmMg('USR8236': '': sds.pgmName);
  when (insDel.mode = MODE_INSERT and insDel.endPos <> h_csrPos + buffer.offset);
  // nichts zu tun
  other;
    exsr endInsDel;
  endsl;

  if (insDel.mode = MODE_INSERT);
    if (isCursorDataField());
      if (insDel.startPos = 0);
        insDel.startPos = h_csrPos + buffer.offset;
      else;
        insDel.endPos = h_csrPos + buffer.offset;
      endif;
    else;
      insDel.startPos = #selStart;
      if (#selLength > 0);
        insDel.endPos = #selStart + #selLength - 1;
      else;
        insDel.endPos=0;
      endif;
    endif;
  endif;

  if (insDel.startPos > 0 and insDel.endPos > 0);
    p_sndPgmMg('USR8237': '': sds.pgmName);
  endif;

  exsr fill##;

  select;
  when (#selStart = 0);
    *in23 = bTrue;
  when (#selLength = 0);
    *in24 = bTrue;
  other;
    exsr keepCsrPos;
  endsl;

endsr;

//============================================================*
//    Setzen Endposition für Kopieren/Löschen                 *
//============================================================*

begsr c_delete;

  select;
  when (insDel.mode <> MODE_DELETE);
    exsr endInsDel;
    insDel.mode = MODE_DELETE;
    *in61 = bFalse;
    *in62 = bTrue;
    p_sndPgmMg('USR8238': '': sds.pgmName);
  when (insDel.mode = MODE_DELETE and insDel.endPos <> h_csrPos + buffer.offset);
  // nichts zu tun
  other;
    exsr endInsDel;
  endsl;

  if (insDel.mode = MODE_DELETE);
    if (isCursorDataField());
      if (insDel.startPos = 0);
        insDel.startPos = h_csrPos + buffer.offset;
      else;
        insDel.endPos = h_csrPos + buffer.offset;
      endif;
    else;
      insDel.startPos = #selStart;
      if (#selLength > 0);
        insDel.endPos = #selStart + #selLength - 1;
      else;
        insDel.endPos=0;
      endif;
    endif;
  endif;

  if (insDel.startPos > 0 and insDel.endPos > 0);
    p_sndPgmMg('USR8239': '': sds.pgmName);
  endif;

  exsr fill##;

  select;
  when (#selStart = 0);
    *in23 = bTrue;
  when (#selLength = 0);
    exsr keepCsrPos;
  other;
    exsr keepCsrPos;
  endsl;

endsr;

//============================================================*
//    c_firstPos    Erste Position anzeigen                   *
//============================================================*

begsr c_firstPos;

  buffer.offset = 0;
  isDataChg = bTrue;

  exsr keepCsrPos;

endsr;

//============================================================*
//    c_lastPos     Letzte Position anzeigen                  *
//============================================================*

begsr c_lastPos;

  buffer.offset = buffer.maxLength - maxEditLength;
  if (buffer.offset < 0);
    buffer.offset = 0;
  endif;

  isDataChg = bTrue;

  exsr keepCsrPos;

endsr;

//============================================================*
//    c_moveL       Nach links verschieben                    *
//============================================================*

begsr c_moveLeft;

  exsr c_pageDown;

endsr;

//============================================================*
//    c_moveR       Nach rechts verschieben                   *
//============================================================*

begsr c_moveRight;

  exsr c_pageUp;

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr getParameters;

  exsr endInsDel;

  exsr bzoff1;
  *in22 = bTrue; // Cursor auf Textfeld setzen

  exsr fill##;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    c_pageUp      "Page Up"                                 *
//============================================================*

begsr c_pageUp;

  buffer.offset = buffer.offset + maxEditLength;

  if (buffer.offset >= buffer.maxLength);
    exsr c_lastPos;
    leavesr;
  endif;

  isDataChg = bTrue;

  exsr keepCsrPos;

endsr;

//============================================================*
//    c_pageDown    "Page Down"                               *
//============================================================*

begsr c_pageDown;

  buffer.offset = buffer.offset - maxEditLength;
  if (buffer.offset < 0);
    exsr c_firstPos;
    leavesr;
  endif;

  isDataChg = bTrue;

  exsr keepCsrPos;

endsr;

//============================================================*
//    fill##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  //  anzeigen Modus "kopieren" oder "löschen"
  select;
  when (insDel.mode = MODE_INSERT);
    *in61 = bTrue;
    *in62 = bFalse;
  when (insDel.mode = MODE_DELETE);
    *in61 = bFalse;
    *in62 = bTrue;
  other;
    *in61 = bFalse;
    *in62 = bFalse;
  endsl;

  if (insDel.mode = MODE_OFF);
    #selStart = 0;
    #selLength = 0;
  else;
    #selStart = insDel.startPos;
    if (insDel.startPos > 0);
      if (insDel.endPos - insDel.startPos >= 0);
        #selLength = insDel.endPos - insDel.startPos + 1;
      else;
        #selLength = 0;
      endif;
    endif;
  endif;

endsr;

//============================================================*
//    Anzeigen Buffer auf dem Bildschirm.                     *
//============================================================*

begsr bufferToScreen;

  //  Anzeigen Feldinhalt
  #startPos = buffer.offset + 1;

  if (buffer.offset + maxEditLength > buffer.maxLength);
    length = buffer.maxLength - buffer.offset;
  else;
    length = maxEditLength;
  endif;

  if (i_isUcs2 = 0);

    #string = %subst(buffer.pFldInhaltSbcs: buffer.offset + 1: length);

  else;

    #ucs2Str = %subst(buffer.pFldInhaltUcs2: buffer.offset + 1: length);

    #ucs2_1 = #ucs2(1);
    #ucs2_2 = #ucs2(2);
    #ucs2_3 = #ucs2(3);
    #ucs2_4 = #ucs2(4);
    #ucs2_5 = #ucs2(5);
    #ucs2_6 = #ucs2(6);
    #ucs2_7 = #ucs2(7);
    #ucs2_8 = #ucs2(8);
    #ucs2_9 = #ucs2(9);
    #ucs2_10 = #ucs2(10);
    #ucs2_11 = #ucs2(11);

  endif;

  // Anzeigen: Weitere/Ende
  if (buffer.offset + maxEditLength >= buffer.maxLength);
    *in83 = bTrue;
  else;
    *in83 = bFalse;
  endif;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  if (i_dsp80 = *off);
    //   132-Zeichen Anzeige
    *in88 = *off;
    zei = 4;
    pos = 43;
  else;
    //    80-Zeichen Anzeige
    *in88 = *on;
    zei = 1;
    pos = 4;
  endif;

endsr;

//============================================================*
//    getParameters Laden der Programmparameter               *
//============================================================*

begsr getParameters;

  if (i_isUcs2 = 0);
    clear buffer.pFldInhaltSbcs;
    %subst(buffer.pFldInhaltSbcs: 1: io_length) = io_fldInhalt.sbcs;
    maxEditLength = %len(#string);
  else;
    clear buffer.pFldInhaltUcs2;
    %subst(buffer.pFldInhaltUcs2: 1: io_length) = io_fldInhalt.ucs2;
    maxEditLength = %len(#ucs2Str);
  endif;

  buffer.maxLength = io_length;

  exsr setTrimLength;

endsr;

//============================================================*
//    Setzen der getrimmten Länge des Buffers.                *
//============================================================*

begsr setTrimLength;

  if (i_isUcs2 = 0);
    buffer.trimLength = %len(%trimr(buffer.pFldInhaltSbcs));
  else;
    buffer.trimLength = %len(%trimr(buffer.pFldInhaltUcs2));
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // Einlesen Funktionstasten
  clear yExclKeys;
  if (i_protect);
    yExclKeys(1) = '*INSERT';
    yExclKeys(2) = '*DELETE';
  endif;

  peek23(sds.pgmName: '*ALL': NBR_F_KEYS: yFKeys: yNbrOfKeys: yExclKeys);
  scrnFKeys = %subarr(yFKeys: 1);

  // - Öffnen der Dateien
  open peekFld;

  open peek64fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  //  ermitteln der Feldeigenschaften
  clear f_key;
  f_key.f_field = i_fldName;
  chain %kds(f_key) fpeekfld;
  if (not %found(peekFld));
    isPgmError = bTrue;
    clear fldl0100;
    clear usr8136;
    usr8136.var1   = i_fldName;
    p_sndPgmMg('USR8136': usr8136: sds.pgmName);
  else;
    isPgmError = bFalse;
    fldl0100   = f_ffd;
  endif;

  if (isPgmError = bTrue);
    leavesr;
  endif;

  clear buffer;
  buffer.offset = 0;

  exsr getParameters;

  o_msgID  = ' ';
  o_msgDta = ' ';

  *in70 = i_protect;

  if (i_isUcs2 = 0);
    *in71 = '0';
  else;
    *in71 = '1';
  endif;

  // - Feld zu groß Hinweis ausgeben
  // TODO: remove code and /copy statement
  // clear usr8123;
  // usr8123.var1 = COLOR_white_u;
  // usr8123.var2 = COLOR_white;
  // p_sndPgmMg('USR8123': usr8123: sds.pgmname);

  // - Einfügen/Löschen
  insDel.mode = MODE_OFF;
  insDel.startPos = 0;
  insDel.endPos = 0;

  // - Füllen der Bildschirmfelder
  exsr bzoff1;
  *in22 = bTrue; // Cursor auf Textfeld setzen
  h_csrPos = 1;
  h_csrRow = 0;
  h_csrCol = 0;

  if (i_isUcs2 = 0);
    h_csrFld = '#STRING';
  else;
    h_csrFld = '#UCS2_1';
  endif;

  $fldName = i_fldName;
  $fldLaenge = buffer.maxLength;

  exsr fill##;

  // - Darstellung der Befehlstasten
  sfBot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setScreen;

  // - Copyright
  p_sndPgmMg('USR9999': i_copyright: sds.pgmName);

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  pgmQ = '*';

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');

endsr;

//============================================================*
//  Prüft, ob der Cursor im Datenfeld (#STRING oder #UCS*) ist*
//============================================================*

dcl-proc isCursorDataField;
  dcl-pi *n ind;
  end-pi;

  if (h_csrFld = '#STRING' or f_startsWith('#UCS2_': h_csrFld));
    return bTrue;
  else;
    return bFalse;
  endif;

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

