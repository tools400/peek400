**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Anzeigen Datensatz                           *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.2.0                               *
//  Programm : PEEK14                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 08.10.97  Raddatz                                 *
//  geändert : 21.07.99  Raddatz für Version 2.2                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Anzeigen Datensatz                                           *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peek14fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbSfl: sflRec);
dcl-f peekfldl0 keyed usropn rename(fpeekfld: fpeekfldl0) infds(peek#00) prefix(f_);
dcl-f peekFld keyed usropn infds(peek#) prefix(f_);

dcl-ds workstn likeds(workstn_t);
dcl-ds cursorPosition likeds(cursorPosition_t) inz;

dcl-ds peek#00 likeds(infds_t);
dcl-ds peek# likeds(infds_t);

dcl-ds hFile04 likeds(hFile_t);

dcl-ds io_buff;
  io_buffFld like(rcdBuf_t);
end-ds;

dcl-s io_nullMap like(nullMap_t) dim(NULL_MAP_SIZE);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/shortcmd_d.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek14.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/usr8100.rpgleinc'
/copy 'qcopyle/usr8206.rpgleinc'
/copy 'qcopyle/usr8220.rpgleinc'
/copy 'qcopyle/usr8221.rpgleinc'
/copy 'qcopyle/usr8222.rpgleinc'

/copy 'qcopyle/ppeek06.rpgleinc'
/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'
/copy 'qcopyle/ppeek32.rpgleinc'
/copy 'qcopyle/ppeek45.rpgleinc'
/copy 'qcopyle/ppeek64.rpgleinc'
/copy 'qcopyle/ppeek65.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'
/copy 'qcopyle/ppeek63.rpgleinc'
/copy 'qcopyle/ppeek71.rpgleinc'

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s yMsgID char(7);
dcl-s yMsgDta char(512);

dcl-s yPgmCmd char(10);
dcl-s yCmdDta like(pgmCmdDt_t);

dcl-s yString like(rcdBuf_t);
dcl-s yStrLen like(int4_t);

dcl-s yDsp80 char(1) inz(*blanks);
dcl-s yHeaderType char(10) inz(*blanks);
dcl-s yCopyright char(512) inz(*blanks);
dcl-s yFldName like(fieldNme_t) inz;
dcl-s yFldInhalt like(rcdBuf_t) inz(*blanks);
dcl-s yLength like(int4_t) inz;
dcl-s yProtect like(bool_t) inz(bTrue);
dcl-s yIsUcs2 like(int4_t) inz;
dcl-s hTranscoder like(hTranscoder_t) inz;
dcl-s cvtLength like(int4_t) inz;

dcl-s sflPage like(int4_t) inz;
dcl-s sflPageDDS like(sflPage) inz;
dcl-s sflRec like(sflPage) inz;
dcl-s sflLastRcd like(sflPage) inz;
dcl-c NBR_F_KEYS 3;

dcl-s sfBot like(int4_t) inz;

dcl-s isRecord like(bool_t) inz(bFalse);

//  Zuletzt gelesener Satz: Fehlt der Satz beim Aktualisieren (F5),
//  werden dessen Schlüsselfelder weiter angezeigt.
dcl-s hasPrevRcd like(bool_t) inz(bFalse);
dcl-s prevBuff like(rcdBuf_t);
dcl-s prevNullMap like(nullMap_t) dim(NULL_MAP_SIZE);
dcl-s isCvtChar like(bool_t) inz(bFalse);

dcl-s peek06_name like(pgmCallN_t) inz;
dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek32_name like(pgmCallN_t) inz;
dcl-s peek45_name like(pgmCallN_t) inz;
dcl-s peek64_name like(pgmCallN_t) inz;
dcl-s peek65_name like(pgmCallN_t) inz;

dcl-s dotLine char(40) inz(*all'.');

dcl-s x like(int4_t) inz;

dcl-s totLin like(int4_t) inz;
dcl-s rowCnt like(int4_t) inz;

dcl-s editor char(10) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek14;
  i_dsp80       like(dsp80_t) const;
  io_headerType like(headerType_t);
  i_copyright   like(copyright_t) const;
  i_rcdNbr      like(rcdNbr_t) const;
  i_file        like(file_t) const;
  i_lib         like(lib_t) const;
  i_mbr         like(mbr_t) const;
  i_rcdFmt      like(fmt_t) const;
  i_function    like(function_t) const;
  i_commitLVL   like(bool_t) const;
  io_screenNbr  like(int4_t);
  o_msgID       like(msgId_t);
  o_msgDta      like(msgDta_t);
end-pi;

dcl-s do_x3 packed(7);

dcl-ds f1Key_l0 likerec(fpeekfldl0: *key);
dcl-ds f1Key likerec(fpeekfld: *key);

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

dow ('1');

  //  Prüfen Positionierung der Subfile
  if ((sfsanr <= 0)  or
      (sfsanr > sflLastRcd));
    sfsanr = 1;
  endif;

  //  Modus: DROP/FOLD
  *in86 = sflMde;

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgCtl;

  //  "Keine Sätze ..."
  if (*in80 = *off);
    write pbleer;
  endif;

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
  other;
    write pbbot#1;
    sfBot = 1;
  endsl;

  //  Anzeige der Subfile
  exfmt pbCtl;

  // - Berechnen Zeile/Spalte
  cursorPosition.row = workstn.csrPos / 256;
  cursorPosition.column = %rem(workstn.csrPos: 256);

  // - Löschen der Cursorposition
  csrRow = *zeros;
  csrCol = *zeros;

  //  Seitennummer  berechnen
  io_screenNbr = sflCsr / sflPageDDS;
  if (sflCsr = (sflPageDDS * io_screenNbr));
  // keine Korrektur erforderlich
  else;
    io_screenNbr = io_screenNbr + 1;
  endif;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Aktuelle Satz-Nr.
  sfsanr = sflCsr;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
  if (yMsgID <> *blanks);
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    iter;
  endif;

  //  Abfragen der Befehlstasten
  select;
  //  F3  - Ende
  when (yPgmCmd = '*EXIT');
    exsr c_endPgm;
    leave;

  //  F5  - Aktualisieren
  when (yPgmCmd = '*REFRESH');
    exsr readRcd;
    exsr c_refresh;
    iter;

  //  F7  - Überschrift
  when (yPgmCmd = '*HEADLINE');
    exsr c_chgHead;
    iter;

  //  F9  - Hexeditor
  when (yPgmCmd = '*HEXEDIT');
    exsr c_fldHexEd;
    exsr keepCsrPos;
    iter;

  //  F10 - Feldeditor
  when (yPgmCmd = '*STREDIT');
    exsr c_fldStrEd;
    exsr keepCsrPos;
    iter;

  //  F12 - Ende
  when (yPgmCmd = '*CANCEL');
    exsr c_endPgm;
    leave;

  //   F17 - Anfang Datensatz
  when (yPgmCmd = '*TOP');
    exsr c_top;
    iter;
  //   F18 - Ende Datensatz
  when (yPgmCmd = '*BOT');
    exsr c_bot;
    iter;

  //   F21 - Drucken Datensatz
  when (yPgmCmd = '*PRINT');
    exsr c_print;
    iter;

  //  F22 - Alle Datensätze verarbeiten
  when (yPgmCmd = '*YESTOALL');
    exsr c_allRcds;
    leave;

  //  F24 - Weitere Tasten
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;

  //  Datenfreigabe
  when (yPgmCmd = '*ENTER');
    exsr c_enter;
    leave;
  //  Page up
  when (yPgmCmd = '*PAGEUP');
  //  Page down
  when (yPgmCmd = '*PAGEDOWN');

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peek14fm;
close peekFld;
close peekfldl0;
CIO_close(hFile04);

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  o_msgID = 'USR8112';
  o_msgDta = *blanks;

endsr;

//============================================================*
//    c_fldHexEd    F9 - Hexeditor                            *
//============================================================*

begsr c_fldHexEd;

  //  Error: Record not found (empty record, see readrcd).
  if (isRecord = bFalse);
    p_sndPgmMg('USR8120': '': sds.pgmName);
    leavesr;
  endif;

  //  Error: No valid subfile record.
  if (sflCsr = *zeros);
    p_sndPgmMg('USR8204': '': sds.pgmName);
    leavesr;
  endif;

  chain sflCsr pbSfl;
  *in01 = not %found;
  if (*in01 = *on);
    //  Error: Unable to find record.
    p_sndPgmMg('USR8120': '': sds.pgmName);
    leavesr;
  endif;

  clear f1Key;
  f1Key.f_field = r$FNme;
  chain %kds(f1Key) fpeekfld;
  *in11 = not %found;
  if (*in11 = *on);
    //  Error: Unable to find record.
    p_sndPgmMg('USR8120': '': sds.pgmName);
    leavesr;
  endif;

  fldl0100 = f_ffd;

  //  Error: Editor not allowed. Field &1 is NULL.
  if (fldl0100.f1nalw = '1' and
      io_nullMap(fldl0100.f1seq) = 1);
    clear usr8220;
    usr8220.var1 = fldl0100.f1FNme;
    p_sndPgmMg('USR8220': usr8220: sds.pgmName);
    leavesr;
  endif;

  yDsp80 = i_dsp80;
  yHeaderType = io_headerType;
  yCopyright = i_copyright;
  yFldName = r$FNme;
  yProtect = bTrue;
  yMsgID = '';
  yMsgDta = '';

  editor = '*HEX';
  exsr fromBuffer;

endsr;

//============================================================*
//    c_fldStrEd    F10 - String-Editor                       *
//============================================================*

begsr c_fldStrEd;

  //  Error: Record not found (empty record, see readrcd).
  if (isRecord = bFalse);
    p_sndPgmMg('USR8120': '': sds.pgmName);
    leavesr;
  endif;

  //  Error: No valid subfile record.
  if (sflCsr = *zeros);
    p_sndPgmMg('USR8204': '': sds.pgmName);
    leavesr;
  endif;

  chain sflCsr pbSfl;
  *in01 = not %found;
  if (*in01 = *on);
    //  Error: Unable to find record.
    p_sndPgmMg('USR8120': '': sds.pgmName);
    leavesr;
  endif;

  clear f1Key;
  f1Key.f_field = r$FNme;
  chain %kds(f1Key) fpeekfld;
  *in11 = not %found;
  if (*in11 = *on);
    //  Error: Unable to find record.
    p_sndPgmMg('USR8120': '': sds.pgmName);
    leavesr;
  endif;

  fldl0100 = f_ffd;

  //  Error: Editor does not support data type of field &1.
  if (fldl0100.f1DTyp <> 'A' and
      fldl0100.f1DTyp <> 'G');
    clear usr8221;
    usr8221.var1 = fldl0100.f1FNme;
    p_sndPgmMg('USR8221': usr8221: sds.pgmName);
    leavesr;
  endif;

  //  Error: Field &1 exceeds maximum length allowed for editor.
  //*                 IF        f_buffLn(FLDL0100) > 1024
  //*                 CLEAR                   USR8222
  //*                 Eval      USR8222.var1 = FLDL0100.F1FNME
  //*                 CALLP     p_sndPgmMg('USR8222': USR8222: sds.pgmName)
  //*                 LEAVESR
  //*                 ENDIF

  //  Error: Editor not allowed. Field &1 is NULL.
  if (fldl0100.f1nalw = '1' and
      io_nullMap(fldl0100.f1seq) = 1);
    clear usr8220;
    usr8220.var1 = fldl0100.f1FNme;
    p_sndPgmMg('USR8220': usr8220: sds.pgmName);
    leavesr;
  endif;

  yDsp80 = i_dsp80;
  yHeaderType = io_headerType;
  yCopyright = i_copyright;
  yFldName = r$FNme;
  yProtect = bTrue;
  yMsgID = '';
  yMsgDta = '';

  editor = '*STRING';
  exsr fromBuffer;

endsr;

//====================================================*
//  FromBuffer - Übertragen Rohdaten aus IO-Puffer    *
//====================================================*

begsr fromBuffer;

  if (f_buffLn(fldl0100) > RCD_BUFF_LEN);
    clear usr8206;
    usr8206.var1 = RCD_BUFF_LEN;
    p_sndPgmMg('USR8206': usr8206: sds.pgmName);
  else;
    f_rtvFld(yFldInhalt: io_buff:
            fldl0100: bFalse);

    yLength = f_curFldLn(io_buff: fldl0100);

    if (fldl0100.f1ucs2 = '1');
      yIsUcs2 = fldl0100.f1fdcc;
    else;
      yIsUcs2 = 0;
    endif;

    //  Der Texteditor zeigt die Zeichen in der Job-CCSID an: CHAR-Felder
    //  mit eigener CCSID (z.B. UTF-8) wie in der Liste (PEEK06) umsetzen.
    //  Der Editor wird nur zur Anzeige aufgerufen, deshalb wird nicht
    //  zurückgesetzt. Wird der Wert kürzer, bleibt die Feldlänge.
    if (editor = '*STRING' and yIsUcs2 = 0 and
        f_hasCcsid(fldl0100) = bTrue);
      monitor;
        hTranscoder = Transcoder_toJobCcsid(fldl0100.f1fdcc);
        cvtLength = Transcoder_xlateBuffer(hTranscoder
                                          : %addr(yFldInhalt)
                                          : yLength
                                          : %size(yFldInhalt));
      on-error;
        //  Error: Editor not allowed (CCSID cannot be converted).
        clear usr8221;
        usr8221.var1 = fldl0100.f1FNme;
        p_sndPgmMg('USR8221': usr8221: sds.pgmName);
        leavesr;
      endmon;
      if (cvtLength < yLength);
        %subst(yFldInhalt: cvtLength + 1: yLength - cvtLength) = '';
      else;
        yLength = cvtLength;
      endif;
    endif;

    if (editor = '*HEX');
      peek45(i_dsp80: io_headerType: i_copyright
            : r$FNme: yFldInhalt: yLength
            : bTrue: yIsUcs2
            : yMsgID: yMsgDta);
    else;
      peek64(i_dsp80: io_headerType: i_copyright
            : r$FNme: yFldInhalt: yLength
            : bTrue: yIsUcs2
            : yMsgID: yMsgDta);
    endif;
  endif;

endsr;

//============================================================*
//    c_endPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endPgm;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8100';
  usr8100.var1 = yPgmCmd;
  o_msgDta = usr8100;

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  clear f1Key_l0;
  f1Key_l0.f_fldSeq = 0;

  exsr pbInit;
  exsr pbSetLL;
  exsr pbReadUp;

endsr;

//============================================================*
//    c_chgHead     F7  - Umschalten der Überschrift          *
//============================================================*

begsr c_chgHead;

  io_headerType =
   f_nextHeaderType(io_headerType);

  exsr c_refresh;

endsr;

//============================================================*
//    c_top         F17 - Anfang der Subfile                  *
//============================================================*

begsr c_top;

  sfsanr = 1;

endsr;

//============================================================*
//    c_bot         F18 - Ende der Subfile                    *
//============================================================*

begsr c_bot;

  sfsanr = sflLastRcd;

endsr;

//============================================================*
//    c_print       F21 - Drucken Datensatz                   *
//============================================================*

begsr c_print;

  monitor;
    peek65(i_rcdNbr
          : i_file: i_lib: i_mbr: i_rcdFmt
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

endsr;

//============================================================*
//    c_allRcds     F22 - Alle Datensätze verarbeiten         *
//============================================================*

begsr c_allRcds;

  o_msgID = 'USR8111';
  o_msgDta = *blanks;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    pbInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr pbInit;

  *in89 = '0';
  write msgCtl;

  *in80 = '0';                                                          // SFLDSP
  *in81 = '1';                                                          // SFLDSPCTL
  *in82 = '1';                                                          // SFLCLR
  *in83 = '1';                                                          // SFLEND
  write pbCtl;

  *in82 = '0';                                                          // SFLCLR

  sflRec = *zeros;

  sflLastRcd = *zeros;

  //  Konvertieren nicht darstellbarer Zeichen
  isCvtChar = bFalse;

endsr;

//============================================================*
//    pbReadUp      Vorwärts füllen der Subfile               *
//============================================================*

begsr pbReadUp;

  rowCnt  = 4;
  sfsanr  = 0;

  dow ('1');
    read fpeekfldl0;
    if (%eof());
      *in83 = *on;
      leave;
    endif;

    //  Feldattribute
    fldl0100 = f_ffd;

    //  nicht erlaubte Feldtypen
    if (f_isNotAlw(fldl0100) = bTrue);
      iter;
    endif;

    //  Berechnen Anzahl Zeilen
    totLin = f_nbrDspRw(fldl0100);

    exsr syncLine;

    //  Ausgeben Feld
    x = 1;
    exsr pbFill;
    *in60 = '0'; // DSPATR(ND)

    dow (x <= yStrLen
       and x <= 512);

      sflRec = sflRec + 1;
      if (sflRec > 9999);
        *in83 = '1';
        leave;
      endif;

      //*                 SUBST (P) yString:X     $$DATA
      $$data = %subst(yString: x);
      exsr wrtPbSfl;
      x = x + 35;
    enddo;

    rowCnt = rowCnt + totLin;

    if (sflRec >= sflPage);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    wrtPbSfl      Schreiben Subfilesatz                     *
//============================================================*

begsr wrtPbSfl;

  write pbSfl;
  sflLastRcd = sflRec;
  *in60 = '1';                                                          // DSPATR(ND)

  if (sflRec = io_screenNbr * sflPageDDS +
                 1 - sflPageDDS);
    sfsanr = sflRec;
  endif;

endsr;

//============================================================*
//    syncLine      Synchronisieren wie Änderungsbildschirm   *
//============================================================*

begsr syncLine;

  if ((rowCnt + totLin - 1) > 18);

    for do_x3 = rowCnt to 18;
      clear pbSfl;
      sflRec = sflRec + 1;
      if (sflRec > 9999);
        *in83 = '1';
        leave;
      endif;

      exsr wrtPbSfl;
    endfor;

    rowCnt = 4;
  endif;

endsr;

//============================================================*
//    pbFill        Füllen Subfilesatz                        *
//============================================================*

begsr pbFill;

  //      ... Feldname
  r$FNme = fldl0100.f1FNme;

  //      ... Überschreiben EDTCDE
  if (f_edtCde <> *blanks);
    fldl0100.f1EdtC = f_edtCde;
  else;
  //       Original EDITCODE verwenden
  endif;

  //      ... eintragen Überschrift
  $$text =
   %trimr(f_headline(
     io_headerType: fldl0100)) + ' ' + dotLine;

  //      ... Markieren Schlüsselfelder
  if (f_kSeq <> 0);
    %subst($$text: %len($$text) - 1: 2) = ' >';
  else;
    %subst($$text: %len($$text) - 1: 2) = ' :';
  endif;

  //  ... Satz nicht gefunden: leer, außer den Schlüsselfeldern des
  //      zuletzt angezeigten Satzes (siehe readrcd)
  if (isRecord = bFalse and
      (f_kSeq = 0 or hasPrevRcd = bFalse));
    yString = '';
    yStrLen = f_dsplyLn(fldl0100);

  //  ... NULL erlaubt?
  elseif (fldl0100.f1nalw = '1' and
     io_nullMap(fldl0100.f1seq) = 1);
    yString = f_msgText('TXT0127': '');
    yStrLen = %len(%trimr(yString));
  else;

    monitor;
      //  ... aufbereiten des Feldinhaltes
      peek06(fldl0100: 'FLDL0100': io_buff
            : bFalse: bTrue
            : yString: yStrLen: yMsgID: yMsgDta);

      //  ... Konvertieren nicht darstellbarer Zeichen
      peek32(yString: yStrLen: 0
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
        else;
        //         keine Nachricht anstehend
        endif;
      else;
      //         Nachricht bereits gesendet
      endif;
    else;
    //         Fehler bei Programmaufruf
    endif;

    //  Ende: F1NALW
    yMsgID  = '';
    yMsgDta = '';
  endif;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

endsr;

//============================================================*
//    pbSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr pbSetLL;

  setll %kds(f1Key_l0) fpeekfldl0;

endsr;

//============================================================*
//    keepCsrPos    Beibehalten der Cursorposition            *
//============================================================*

begsr keepCsrPos;

  //  Beibehalten der Cursorosition (nach EXFMT PBCTL berechnet)
  csrRow = cursorPosition.row;
  csrCol = cursorPosition.column;

  csrCol = csrCol - pos;
  csrCol = csrCol - 1;
  csrRow = csrRow - zei;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 1;
    pos = 40;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 1;
    pos = 7;
  endif;

  sflPage = *hival;
  sflPageDDS = 15;

  %subarr(*in: 70: 10) = '0';

  select;
  when (i_function = '*DELETE');
    *in70 = '1';
  when (i_function = '*DISPLAY');
    *in75 = '1';
  when (i_function = '*COPYEXT');
    *in79 = '1';
  other;
  //              ????????????
  endsl;

endsr;

//============================================================*
//    readRcd       Einlesen des anzuzeigenden Satzes         *
//============================================================*

begsr readRcd;

  if (isRecord = bTrue);
    prevBuff = io_buffFld;
    prevNullMap = io_nullMap;
    hasPrevRcd = bTrue;
  endif;

  isRecord = bFalse;
  if (CIO_isOpen(hFile04) = bTrue);
    if (CIO_chainWithRRN(hFile04
                      : i_rcdNbr
                      : bFalse
                      : io_buff
                      : io_nullMap) = bTrue);
      isRecord = bTrue;
    endif;
  endif;

  //  Satz nicht mehr vorhanden (z.B. inzwischen gelöscht): Meldung
  //  "Datensatz nicht gefunden." und leerer Satz, nur die Schlüssel-
  //  felder aus dem zuletzt angezeigten Satz (siehe pbfill). Der von
  //  CIO_chainWithRRN geleerte Puffer enthält keine gültigen Werte.
  if (isRecord = bFalse);
    if (hasPrevRcd = bTrue);
      io_buffFld = prevBuff;
      io_nullMap = prevNullMap;
    endif;
    p_sndPgmMg('USR8120': '': sds.pgmName);
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek14fm;
  open peekFld;
  open peekfldl0;
  CIO_open(hFile04
          : i_file
          : i_lib
          : i_mbr
          : i_rcdFmt
          : 'rr, arrseq=Y, commit=N, +
             nullcap=Y, riofb=Y, secure=N, +
             ccsid=65535');
  //**                                      nullcap=Y, riofb=Y, secure=N')
  //**                                   : 'rr,arrseq=Y,nullcap=Y,riofb=Y')

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Kopffelder
  $$rcdn = i_rcdNbr;

  // - Darstellung der Subfile
  sflMde = '1';

  // - Darstellung der Befehlstasten
  sfBot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setScreen;

  // - Einlesen des anzuzeigenden Satzes
  exsr readRcd;

  // - Subfile füllen
  clear f1Key_l0;
  f1Key_l0.f_fldSeq = 0;

  exsr pbInit;
  exsr pbSetLL;
  exsr pbReadUp;

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

  peek06_name = f_pgmCallN('PEEK06');
  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');
  peek32_name = f_pgmCallN('PEEK32');
  peek45_name = f_pgmCallN('PEEK45');
  peek64_name = f_pgmCallN('PEEK64');
  peek65_name = f_pgmCallN('PEEK65');

  peek23(sds.pgmName: '*ALL': NBR_F_KEYS
        : yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

endsr;

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

