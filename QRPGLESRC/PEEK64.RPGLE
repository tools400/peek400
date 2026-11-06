**free
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

dcl-f peek64fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-f peekfld keyed usropn prefix(f_) infds(Peek_01_DS);

dcl-ds workstn likeds(workstn_t);

dcl-ds Peek_01_DS likeds(infds_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,D_COLORATR
/copy QCOPYLE,SDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8123
/copy QCOPYLE,USR8136
/copy QCOPYLE,USR8240
/copy QCOPYLE,USR8241

/define internal_prototype
/copy QCOPYLE,PPEEK64
/undefine internal_prototype

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK71

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-s YPgmCmd like(pgmCmd_t);
dcl-s YCmdDta like(pgmCmdDt_t);
dcl-s YMsgID like(msgId_t);
dcl-s YMsgDta like(msgDta_t);

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

dcl-ds Buffer qualified;
  Offset         int(10) inz;
  maxLength      int(10) inz;
  trimLength     int(10) inz;
  pFldInhaltSbcs like(rcdBuf_t) inz;
  pFldInhaltUcs2 like(rcdBufUcs2_t) overlay(pFldInhaltSbcs) inz;
end-ds;

dcl-s maxEditLength int(10);

dcl-ds *n;
  #ucs2str ucs2(704) pos(1);
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
  io_Length    like(int4_t);
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

exsr First;
if (isPgmError = bFalse);

  dow ('1');

    //  Nachrichten anzeigen
    *in89 = *off;
    write msgctl;

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
      $CSRPOS = H_CSRPOS + Buffer.Offset;
    else;
      $CSRPOS = 0;
    endif;

    //  Anzeigen Bildschirm
    exfmt bild01;

    //  Übertragen Bildschirmfelder in Buffer
    exsr screenToBuffer;

    //  Berechnen Zeile/Spalte
    cursorPosition.row = workstn.csrPos / 256;
    cursorPosition.column = %rem(workstn.csrPos: 256);

    // Löschen Cursorposition
    H_CSRROW = 0;
    H_CSRCOL = 0;

    // Erzwingen Prüfung der Eingabedaten ...
    select;
    when (isPgmError);
      isDataChg = bTrue;
    when (isCursorDataField() and H_CSRPOS <> 0 and $CSRPOS <> H_CSRPOS);
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
    peek21(workstn.aid: sds.pgmName: YPgmCmd: YCmdDta: YMsgID: YMsgDta
          : yExclKeys);
    if (YMsgID <> ' ');
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
      iter;
    endif;

    //  Abfragen der Programmbefehle
    select;
    //  F3  - Ende
    when (YPgmCmd = '*EXIT' or YPgmCmd = '*NO');
      exsr C_EndPgm;
      leave;

    //  F5  - Aktualisieren
    when (YPgmCmd = '*REFRESH');
      exsr C_Refresh;
      iter;

    //  F7  - Startposition
    when (YPgmCmd = '*INSERT' and not i_protect);
      exsr c_insert;
      iter;

    //  F8  - Endposition
    when (YPgmCmd = '*DELETE' and not i_protect);
      exsr c_delete;
      iter;

    //  F12 - Ende
    when (YPgmCmd = '*CANCEL');
      exsr C_EndPgm;
      leave;

    //  F17 - an den Afang gehen
    when (YPgmCmd = '*FIRSTPOS');
      exsr c_firstPos;

    //  F18 - ans Ende gehen
    when (YPgmCmd = '*LASTPOS');
      exsr c_lastPos;

    //  F19 - nach rechts verschieben
    when (YPgmCmd = '*LEFT');
      exsr c_moveLeft;

    //  F20 - nach links verschieben
    when (YPgmCmd = '*RIGHT');
      exsr c_moveRight;

    //  F24 - Weitere Tasten
    when (YPgmCmd = '*MOREKEYS');
      exsr C_MoreKeys;

    //  Page up
    when (YPgmCmd = '*PAGEUP');
      exsr c_pageUp;

    //  Page down
    when (YPgmCmd = '*PAGEDOWN');
      exsr c_pageDown;

    //  Datenfreigabe
    when (YPgmCmd = '*ENTER' or YPgmCmd = '*OK');
      exsr C_Enter;
      if (isPgmError = bFalse and not isDataChg);
        o_msgID  = 'USR8112';
        o_msgDta = ' ';

        if (i_isUcs2 = 0);
          io_fldInhalt.sbcs = Buffer.pFldInhaltSbcs;
        else;
          io_fldInhalt.ucs2 = Buffer.pFldInhaltUcs2;
        endif;

        io_Length = Buffer.maxLength;
        leave;
      endif;

    other;
      //  Falsche Taste gedrückt
      p_wrongKey(workstn.aid: sds.pgmName);
      iter;
    endsl;

  enddo;

endif;

if (%open(peekfld));
  close peekfld;
endif;

close peek64fm;

return;

//============================================================*
//    KeepCsrPos    Beibehalten der Cursorposition            *
//============================================================*

begsr KeepCsrPos;

  //  Beibehalten der Cursorosition
  H_CSRROW = cursorPosition.row - zei;
  H_CSRCOL = cursorPosition.column - pos - 1;

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

begsr C_Enter;

  //  Prüfen der Eingaben
  exsr prfb1;

  if (not isPgmError);

    // Verarbeiten der Optionen Einfügen/Löschen
    if (#selStart <> insDel.startPos);
      insDel.startPos = #selStart;
      select;
      when (insDel.mode = MODE_INSERT and insDel.endPos > 0);
      // p_sndpgmmg('USR8237': '': sds.pgmname);
      when (insDel.mode = MODE_DELETE and insDel.endPos > 0);
      // p_sndpgmmg('USR8239': '': sds.pgmname);
      endsl;
    endif;

    if (#selLength + insDel.startPos - 1 <> insDel.endPos);
      insDel.endPos = #selLength + insDel.startPos - 1;
      select;
      when (insDel.mode = MODE_INSERT and insDel.endPos > 0);
      // p_sndpgmmg('USR8237': '': sds.pgmname);
      when (insDel.mode = MODE_DELETE and insDel.endPos > 0);
      // p_sndpgmmg('USR8239': '': sds.pgmname);
      endsl;
    endif;

    if (#selStart = 0 and #selLength = 0 and insDel.mode <> MODE_OFF);
      exsr endInsDel;
    endif;

    if (insDel.mode <> MODE_OFF);
      //  Cursor auf die Startposition setzen, wenn sie angezeigt wird.
      //  Das Textfeld beginnt im Fenster (zei/pos) in Zeile 8, Spalte 4
      //  und hat %len(#ucs2_1) Zeichen je Zeile.
      relPos = insDel.startPos - Buffer.Offset;
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
    Buffer.Offset = #StartPos - 1;
    exsr fill##;
  endif;

  if (not isPgmError and cursorPosition.row > 0);
    exsr KeepCsrPos;
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
    %subst(Buffer.pFldInhaltSbcs: start) = %subst(Buffer.pFldInhaltSbcs: insDel.startPos);
    %subst(Buffer.pFldInhaltSbcs: insDel.startPos: length) = '';
  else;
    %subst(Buffer.pFldInhaltUcs2: start) = %subst(Buffer.pFldInhaltUcs2: insDel.startPos);
    %subst(Buffer.pFldInhaltUcs2: insDel.startPos: length) = '';
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
    %subst(Buffer.pFldInhaltSbcs: insDel.startPos) = %subst(Buffer.pFldInhaltSbcs: start);
    %subst(Buffer.pFldInhaltSbcs: Buffer.maxLength - length + 1: length) = '';
  else;
    %subst(Buffer.pFldInhaltUcs2: insDel.startPos) = %subst(Buffer.pFldInhaltUcs2: start);
    %subst(Buffer.pFldInhaltUcs2: Buffer.maxLength - length + 1: length) = '';
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

    start = Buffer.Offset + 1;
    if (Buffer.Offset + maxEditLength > Buffer.maxLength);
      length = Buffer.maxLength - Buffer.Offset;
    else;
      length = maxEditLength;
    endif;

    //  ... aktualisieren Buffer
    if (i_isUcs2 = 0);
      %subst(Buffer.pFldInhaltSbcs: start: length) = %subst(#string: 1: length);
    else;
      %subst(Buffer.pFldInhaltUcs2: start: length) = %subst(#ucs2str: 1: length);
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

begsr prfb1;

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

    if (#StartPos <= 0);
      p_sndPgmMg('USR8178': '': sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

    if (#StartPos > Buffer.maxLength);
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

    if (Buffer.Offset + maxEditLength > Buffer.maxLength);
      start = Buffer.maxLength - Buffer.Offset + 1;
      if (i_isUcs2 = 0);
        isPgmError = %subst(#string: start) <> '';
      else;
        isPgmError = %subst(#ucs2str: start) <> '';
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

    if (#selStart > Buffer.maxLength);
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
      if (#selStart + #selLength - 1 > Buffer.maxLength);
        clear usr8241;
        usr8241.var1 = (#selStart + #selLength - 1) - Buffer.maxLength;
        p_sndPgmMg('USR8241': usr8241: sds.pgmName);
        isPgmError = bTrue;
        leave;
      endif;
    else;
      // Einfügen von Leerzeichen
      if (Buffer.trimLength + #selLength > Buffer.maxLength);
        clear usr8241;
        usr8241.var1 = (Buffer.trimLength + #selLength) - Buffer.maxLength;
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

begsr C_EndPgm;

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
  when (insDel.mode = MODE_INSERT and insDel.endPos <> H_CSRPOS + Buffer.Offset);
  // nichts zu tun
  other;
    exsr endInsDel;
  endsl;

  if (insDel.mode = MODE_INSERT);
    if (isCursorDataField());
      if (insDel.startPos = 0);
        insDel.startPos = H_CSRPOS + Buffer.Offset;
      else;
        insDel.endPos = H_CSRPOS + Buffer.Offset;
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
    exsr KeepCsrPos;
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
  when (insDel.mode = MODE_DELETE and insDel.endPos <> H_CSRPOS + Buffer.Offset);
  // nichts zu tun
  other;
    exsr endInsDel;
  endsl;

  if (insDel.mode = MODE_DELETE);
    if (isCursorDataField());
      if (insDel.startPos = 0);
        insDel.startPos = H_CSRPOS + Buffer.Offset;
      else;
        insDel.endPos = H_CSRPOS + Buffer.Offset;
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
    exsr KeepCsrPos;
  other;
    exsr KeepCsrPos;
  endsl;

endsr;

//============================================================*
//    c_firstPos    Erste Position anzeigen                   *
//============================================================*

begsr c_firstPos;

  Buffer.Offset = 0;
  isDataChg = bTrue;

  exsr KeepCsrPos;

endsr;

//============================================================*
//    c_lastPos     Letzte Position anzeigen                  *
//============================================================*

begsr c_lastPos;

  Buffer.Offset = Buffer.maxLength - maxEditLength;
  if (Buffer.Offset < 0);
    Buffer.Offset = 0;
  endif;

  isDataChg = bTrue;

  exsr KeepCsrPos;

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

begsr C_Refresh;

  exsr GetParameters;

  exsr endInsDel;

  exsr bzoff1;
  *in22 = bTrue; // Cursor auf Textfeld setzen

  exsr fill##;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    c_pageUp      "Page Up"                                 *
//============================================================*

begsr c_pageUp;

  Buffer.Offset = Buffer.Offset + maxEditLength;

  if (Buffer.Offset >= Buffer.maxLength);
    exsr c_lastPos;
    leavesr;
  endif;

  isDataChg = bTrue;

  exsr KeepCsrPos;

endsr;

//============================================================*
//    c_pageDown    "Page Down"                               *
//============================================================*

begsr c_pageDown;

  Buffer.Offset = Buffer.Offset - maxEditLength;
  if (Buffer.Offset < 0);
    exsr c_firstPos;
    leavesr;
  endif;

  isDataChg = bTrue;

  exsr KeepCsrPos;

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
    #SelLength = 0;
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
  #StartPos = Buffer.Offset + 1;

  if (Buffer.Offset + maxEditLength > Buffer.maxLength);
    length = Buffer.maxLength - Buffer.Offset;
  else;
    length = maxEditLength;
  endif;

  if (i_isUcs2 = 0);

    #string = %subst(Buffer.pFldInhaltSbcs: Buffer.Offset + 1: length);

  else;

    #ucs2str = %subst(Buffer.pFldInhaltUcs2: Buffer.Offset + 1: length);

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
  if (Buffer.Offset + maxEditLength >= Buffer.maxLength);
    *in83 = bTrue;
  else;
    *in83 = bFalse;
  endif;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

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
//    GetParameters Laden der Programmparameter               *
//============================================================*

begsr GetParameters;

  if (i_isUcs2 = 0);
    clear Buffer.pFldInhaltSbcs;
    %subst(Buffer.pFldInhaltSbcs: 1: io_Length) = io_fldInhalt.sbcs;
    maxEditLength = %len(#string);
  else;
    clear Buffer.pFldInhaltUcs2;
    %subst(Buffer.pFldInhaltUcs2: 1: io_Length) = io_fldInhalt.ucs2;
    maxEditLength = %len(#ucs2str);
  endif;

  Buffer.maxLength = io_Length;

  exsr setTrimLength;

endsr;

//============================================================*
//    Setzen der getrimmten Länge des Buffers.                *
//============================================================*

begsr setTrimLength;

  if (i_isUcs2 = 0);
    Buffer.trimLength = %len(%trimr(Buffer.pFldInhaltSbcs));
  else;
    Buffer.trimLength = %len(%trimr(Buffer.pFldInhaltUcs2));
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // Einlesen Funktionstasten
  clear yExclKeys;
  if (i_protect);
    yExclKeys(1) = '*INSERT';
    yExclKeys(2) = '*DELETE';
  endif;

  peek23(sds.pgmName: '*ALL': NBR_F_KEYS: yFKeys: yNbrOfKeys: yExclKeys);
  ScrnFKeys = %subarr(yFKeys: 1);

  // - Öffnen der Dateien
  open peekfld;

  open peek64fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  //  ermitteln der Feldeigenschaften
  clear f_key;
  f_key.F_Field = i_fldName;
  chain %kds(f_key) fpeekfld;
  if (not %found(peekfld));
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

  clear Buffer;
  Buffer.Offset = 0;

  exsr GetParameters;

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
  // p_sndpgmmg('USR8123': usr8123: sds.pgmname);

  // - Einfügen/Löschen
  insDel.mode = MODE_OFF;
  insDel.startPos = 0;
  insDel.endPos = 0;

  // - Füllen der Bildschirmfelder
  exsr bzoff1;
  *in22 = bTrue; // Cursor auf Textfeld setzen
  H_CSRPOS = 1;
  H_CSRROW = 0;
  H_CSRCOL = 0;

  if (i_isUcs2 = 0);
    H_CSRFLD = '#STRING';
  else;
    H_CSRFLD = '#UCS2_1';
  endif;

  $FldName = i_fldName;
  $FldLaenge = Buffer.maxLength;

  exsr fill##;

  // - Darstellung der Befehlstasten
  sfBot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr SetScreen;

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

  PGMQ = '*';

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');

endsr;

//============================================================*
//  Prüft, ob der Cursor im Datenfeld (#STRING oder #UCS*) ist*
//============================================================*

dcl-proc isCursorDataField;
  dcl-pi *n ind;
  end-pi;

  if (H_CSRFLD = '#STRING' or f_startsWith('#UCS2_': H_CSRFLD));
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
  o_action = CEE_PERCOLATE;

end-proc;

