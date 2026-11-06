**free
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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

dcl-f peek14fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbsfl: SflRec);
dcl-f peekfldl0 keyed usropn rename(fpeekfld: fpeekfldl0) infds(Peek#00) prefix(f_);
dcl-f peekfld keyed usropn infds(Peek#) prefix(f_);

dcl-ds workstn likeds(workstn_t);
dcl-ds cursorPosition likeds(cursorPosition_t) inz;

dcl-ds Peek#00 likeds(infds_t);
dcl-ds Peek# likeds(infds_t);

dcl-ds hFile04 likeds(hFile_t);

dcl-ds IO_Buff;
  IO_BuffFld like(rcdBuf_t);
end-ds;

dcl-s IO_NullMap like(nullMap_t) dim(NULL_MAP_SIZE);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,SDS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK14
/undefine internal_prototype

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8206
/copy QCOPYLE,USR8220
/copy QCOPYLE,USR8221
/copy QCOPYLE,USR8222

/copy QCOPYLE,PPEEK06
/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK32
/copy QCOPYLE,PPEEK45
/copy QCOPYLE,PPEEK64
/copy QCOPYLE,PPEEK65

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK63
/copy QCOPYLE,PPEEK71

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s YMsgID char(7);
dcl-s YMsgDta char(512);

dcl-s YPgmCmd char(10);
dcl-s YCmdDta like(pgmCmdDt_t);

dcl-s YString like(rcdBuf_t);
dcl-s YStrLen like(int4_t);

dcl-s YDsp80 char(1) inz(*blanks);
dcl-s yHeaderType char(10) inz(*blanks);
dcl-s yCopyright char(512) inz(*blanks);
dcl-s yFldName like(fieldNme_t) inz;
dcl-s yFldInhalt like(rcdBuf_t) inz(*blanks);
dcl-s yLength like(int4_t) inz;
dcl-s yProtect like(bool_t) inz(bTrue);
dcl-s yIsUcs2 like(int4_t) inz;
dcl-s hTranscoder like(hTranscoder_t) inz;
dcl-s cvtlength like(int4_t) inz;

dcl-s SflPage like(int4_t) inz;
dcl-s SflPageDDS like(SflPage) inz;
dcl-s SflRec like(SflPage) inz;
dcl-s SflLastRcd like(SflPage) inz;
dcl-c NBR_F_KEYS 3;

dcl-s sfbot like(int4_t) inz;

dcl-s IsRecord like(bool_t) inz(bFalse);

//  Zuletzt gelesener Satz: Fehlt der Satz beim Aktualisieren (F5),
//  werden dessen Schlüsselfelder weiter angezeigt.
dcl-s hasprevrcd like(bool_t) inz(bFalse);
dcl-s prevbuff like(rcdBuf_t);
dcl-s prevnullmap like(nullMap_t) dim(NULL_MAP_SIZE);
dcl-s IsCvtChar like(bool_t) inz(bFalse);

dcl-s peek06_name like(pgmCallN_t) inz;
dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek32_name like(pgmCallN_t) inz;
dcl-s peek45_name like(pgmCallN_t) inz;
dcl-s peek64_name like(pgmCallN_t) inz;
dcl-s peek65_name like(pgmCallN_t) inz;

dcl-s DotLine char(40) inz(*all'.');

dcl-s x like(int4_t) inz;

dcl-s totLin like(int4_t) inz;
dcl-s rowCnt like(int4_t) inz;

dcl-s Editor char(10) inz;

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

dcl-ds f1key_l0 likerec(fpeekfldl0: *key);
dcl-ds F1Key likerec(fpeekfld: *key);

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr First;

dow ('1');

  //  Prüfen Positionierung der Subfile
  if ((sfsanr <= 0)  or
      (sfsanr > SflLastRcd));
    sfsanr = 1;
  endif;

  //  Modus: DROP/FOLD
  *in86 = sflmde;

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgctl;

  //  "Keine Sätze ..."
  if (*in80 = *off);
    write pbleer;
  endif;

  //  Anzeigen der Befehlstasten
  select;
  when ((sfbot = 2) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#2;
  when ((sfbot = 3) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#3;
  when ((sfbot = 4) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#4;
  when ((sfbot = 5) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#5;
  when ((sfbot = 6) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#6;
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Anzeige der Subfile
  exfmt pbctl;

  // - Berechnen Zeile/Spalte
  cursorPosition.row = workstn.csrPos / 256;
  cursorPosition.column = %rem(workstn.csrPos: 256);

  // - Löschen der Cursorposition
  CsrRow = *zeros;
  CsrCol = *zeros;

  //  Seitennummer  berechnen
  io_screenNbr = SflCsr / SflPageDDS;
  if (SflCsr = (SflPageDDS * io_screenNbr));
  // keine Korrektur erforderlich
  else;
    io_screenNbr = io_screenNbr + 1;
  endif;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Aktuelle Satz-Nr.
  sfsanr = SflCsr;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
  if (YMsgID <> *blanks);
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    iter;
  endif;

  //  Abfragen der Befehlstasten
  select;
  //  F3  - Ende
  when (YPgmCmd = '*EXIT');
    exsr C_EndPgm;
    leave;

  //  F5  - Aktualisieren
  when (YPgmCmd = '*REFRESH');
    exsr ReadRcd;
    exsr C_Refresh;
    iter;

  //  F7  - Überschrift
  when (YPgmCmd = '*HEADLINE');
    exsr C_ChgHead;
    iter;

  //  F9  - Hexeditor
  when (YPgmCmd = '*HEXEDIT');
    exsr C_FldHexEd;
    exsr KeepCsrPos;
    iter;

  //  F10 - Feldeditor
  when (YPgmCmd = '*STREDIT');
    exsr C_FldStrEd;
    exsr KeepCsrPos;
    iter;

  //  F12 - Ende
  when (YPgmCmd = '*CANCEL');
    exsr C_EndPgm;
    leave;

  //   F17 - Anfang Datensatz
  when (YPgmCmd = '*TOP');
    exsr C_Top;
    iter;
  //   F18 - Ende Datensatz
  when (YPgmCmd = '*BOT');
    exsr C_Bot;
    iter;

  //   F21 - Drucken Datensatz
  when (YPgmCmd = '*PRINT');
    exsr C_Print;
    iter;

  //  F22 - Alle Datensätze verarbeiten
  when (YPgmCmd = '*YESTOALL');
    exsr C_AllRcds;
    leave;

  //  F24 - Weitere Tasten
  when (YPgmCmd = '*MOREKEYS');
    exsr C_MoreKeys;

  //  Datenfreigabe
  when (YPgmCmd = '*ENTER');
    exsr C_Enter;
    leave;
  //  Page up
  when (YPgmCmd = '*PAGEUP');
  //  Page down
  when (YPgmCmd = '*PAGEDOWN');

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peek14fm;
close peekfld;
close peekfldl0;
CIO_close(hFile04);

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  o_msgID = 'USR8112';
  o_msgDta = *blanks;

endsr;

//============================================================*
//    C_FldHexEd    F9 - Hexeditor                            *
//============================================================*

begsr C_FldHexEd;

  //  Error: Record not found (empty record, see readrcd).
  if (IsRecord = bFalse);
    p_sndPgmMg('USR8120': '': sds.pgmName);
    leavesr;
  endif;

  //  Error: No valid subfile record.
  if (SflCsr = *zeros);
    p_sndPgmMg('USR8204': '': sds.pgmName);
    leavesr;
  endif;

  chain SflCsr pbsfl;
  *in01 = not %found;
  if (*in01 = *on);
    //  Error: Unable to find record.
    p_sndPgmMg('USR8120': '': sds.pgmName);
    leavesr;
  endif;

  clear F1Key;
  F1Key.F_Field = r$fnme;
  chain %kds(F1Key) fpeekfld;
  *in11 = not %found;
  if (*in11 = *on);
    //  Error: Unable to find record.
    p_sndPgmMg('USR8120': '': sds.pgmName);
    leavesr;
  endif;

  fldl0100 = f_ffd;

  //  Error: Editor not allowed. Field &1 is NULL.
  if (fldl0100.f1nalw = '1' and
      IO_NullMap(fldl0100.f1seq) = 1);
    clear usr8220;
    usr8220.var1 = fldl0100.f1fnme;
    p_sndPgmMg('USR8220': usr8220: sds.pgmName);
    leavesr;
  endif;

  YDsp80 = i_dsp80;
  yHeaderType = io_headerType;
  yCopyright = i_copyright;
  yFldName = r$fnme;
  yProtect = bTrue;
  YMsgID = '';
  YMsgDta = '';

  Editor = '*HEX';
  exsr fromBuffer;

endsr;

//============================================================*
//    C_FldStrEd    F10 - String-Editor                       *
//============================================================*

begsr C_FldStrEd;

  //  Error: Record not found (empty record, see readrcd).
  if (IsRecord = bFalse);
    p_sndPgmMg('USR8120': '': sds.pgmName);
    leavesr;
  endif;

  //  Error: No valid subfile record.
  if (SflCsr = *zeros);
    p_sndPgmMg('USR8204': '': sds.pgmName);
    leavesr;
  endif;

  chain SflCsr pbsfl;
  *in01 = not %found;
  if (*in01 = *on);
    //  Error: Unable to find record.
    p_sndPgmMg('USR8120': '': sds.pgmName);
    leavesr;
  endif;

  clear F1Key;
  F1Key.F_Field = r$fnme;
  chain %kds(F1Key) fpeekfld;
  *in11 = not %found;
  if (*in11 = *on);
    //  Error: Unable to find record.
    p_sndPgmMg('USR8120': '': sds.pgmName);
    leavesr;
  endif;

  fldl0100 = f_ffd;

  //  Error: Editor does not support data type of field &1.
  if (fldl0100.F1DTyp <> 'A' and
      fldl0100.F1DTyp <> 'G');
    clear usr8221;
    usr8221.var1 = fldl0100.f1fnme;
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
      IO_NullMap(fldl0100.f1seq) = 1);
    clear usr8220;
    usr8220.var1 = fldl0100.f1fnme;
    p_sndPgmMg('USR8220': usr8220: sds.pgmName);
    leavesr;
  endif;

  YDsp80 = i_dsp80;
  yHeaderType = io_headerType;
  yCopyright = i_copyright;
  yFldName = r$fnme;
  yProtect = bTrue;
  YMsgID = '';
  YMsgDta = '';

  Editor = '*STRING';
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
    f_rtvFld(yFldInhalt: IO_Buff:
            fldl0100: bFalse);

    yLength = f_curFldLn(IO_Buff: fldl0100);

    if (fldl0100.f1ucs2 = '1');
      yIsUcs2 = fldl0100.f1fdcc;
    else;
      yIsUcs2 = 0;
    endif;

    //  Der Texteditor zeigt die Zeichen in der Job-CCSID an: CHAR-Felder
    //  mit eigener CCSID (z.B. UTF-8) wie in der Liste (PEEK06) umsetzen.
    //  Der Editor wird nur zur Anzeige aufgerufen, deshalb wird nicht
    //  zurückgesetzt. Wird der Wert kürzer, bleibt die Feldlänge.
    if (Editor = '*STRING' and yIsUcs2 = 0 and
        f_hasCcsid(fldl0100) = bTrue);
      monitor;
        hTranscoder = Transcoder_toJobCcsid(fldl0100.f1fdcc);
        cvtlength = Transcoder_xlateBuffer(hTranscoder
                                          : %addr(yFldInhalt)
                                          : yLength
                                          : %size(yFldInhalt));
      on-error;
        //  Error: Editor not allowed (CCSID cannot be converted).
        clear usr8221;
        usr8221.var1 = fldl0100.f1fnme;
        p_sndPgmMg('USR8221': usr8221: sds.pgmName);
        leavesr;
      endmon;
      if (cvtlength < yLength);
        %subst(yFldInhalt: cvtlength + 1: yLength - cvtlength) = '';
      else;
        yLength = cvtlength;
      endif;
    endif;

    if (Editor = '*HEX');
      peek45(i_dsp80: io_headerType: i_copyright
            : r$fnme: yFldInhalt: yLength
            : bTrue: yIsUcs2
            : YMsgID: YMsgDta);
    else;
      peek64(i_dsp80: io_headerType: i_copyright
            : r$fnme: yFldInhalt: yLength
            : bTrue: yIsUcs2
            : YMsgID: YMsgDta);
    endif;
  endif;

endsr;

//============================================================*
//    C_EndPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr C_EndPgm;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8100';
  usr8100.var1 = YPgmCmd;
  o_msgDta = usr8100;

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr C_Refresh;

  clear f1key_l0;
  f1key_l0.f_fldseq = 0;

  exsr PBInit;
  exsr PBSetLL;
  exsr PBReadUp;

endsr;

//============================================================*
//    C_ChgHead     F7  - Umschalten der Überschrift          *
//============================================================*

begsr C_ChgHead;

  io_headerType =
   f_nextHeaderType(io_headerType);

  exsr C_Refresh;

endsr;

//============================================================*
//    C_Top         F17 - Anfang der Subfile                  *
//============================================================*

begsr C_Top;

  sfsanr = 1;

endsr;

//============================================================*
//    C_Bot         F18 - Ende der Subfile                    *
//============================================================*

begsr C_Bot;

  sfsanr = SflLastRcd;

endsr;

//============================================================*
//    C_Print       F21 - Drucken Datensatz                   *
//============================================================*

begsr C_Print;

  monitor;
    peek65(i_rcdNbr
          : i_file: i_lib: i_mbr: i_rcdFmt
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

endsr;

//============================================================*
//    C_AllRcds     F22 - Alle Datensätze verarbeiten         *
//============================================================*

begsr C_AllRcds;

  o_msgID = 'USR8111';
  o_msgDta = *blanks;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    PBInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr PBInit;

  *in89 = '0';
  write msgctl;

  *in80 = '0';                                                          // SFLDSP
  *in81 = '1';                                                          // SFLDSPCTL
  *in82 = '1';                                                          // SFLCLR
  *in83 = '1';                                                          // SFLEND
  write pbctl;

  *in82 = '0';                                                          // SFLCLR

  SflRec = *zeros;

  SflLastRcd = *zeros;

  //  Konvertieren nicht darstellbarer Zeichen
  IsCvtChar = bFalse;

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr PBReadUp;

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
    exsr PBFill;
    *in60 = '0'; // DSPATR(ND)

    dow (x <= YStrLen
       and x <= 512);

      SflRec = SflRec + 1;
      if (SflRec > 9999);
        *in83 = '1';
        leave;
      endif;

      //*                 SUBST (P) YString:X     $$DATA
      $$data = %subst(YString: x);
      exsr wrtPbSfl;
      x = x + 35;
    enddo;

    rowCnt = rowCnt + totLin;

    if (SflRec >= SflPage);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    wrtPbSfl      Schreiben Subfilesatz                     *
//============================================================*

begsr wrtPbSfl;

  write pbsfl;
  SflLastRcd = SflRec;
  *in60 = '1';                                                          // DSPATR(ND)

  if (SflRec = io_screenNbr * SflPageDDS +
                 1 - SflPageDDS);
    sfsanr = SflRec;
  endif;

endsr;

//============================================================*
//    synCline      Synchronisieren wie Änderungsbildschirm   *
//============================================================*

begsr syncLine;

  if ((rowCnt + totLin - 1) > 18);

    for do_x3 = rowCnt to 18;
      clear pbsfl;
      SflRec = SflRec + 1;
      if (SflRec > 9999);
        *in83 = '1';
        leave;
      endif;

      exsr wrtPbSfl;
    endfor;

    rowCnt = 4;
  endif;

endsr;

//============================================================*
//    PBFill        Füllen Subfilesatz                        *
//============================================================*

begsr PBFill;

  //      ... Feldname
  r$fnme = fldl0100.f1fnme;

  //      ... Überschreiben EDTCDE
  if (F_EdtCde <> *blanks);
    fldl0100.f1edtc = F_EdtCde;
  else;
  //       Original EDITCODE verwenden
  endif;

  //      ... eintragen Überschrift
  $$text =
   %trimr(f_headline(
     io_headerType: fldl0100)) + ' ' + DotLine;

  //      ... Markieren Schlüsselfelder
  if (F_KSeq <> 0);
    %subst($$text: %len($$text) - 1: 2) = ' >';
  else;
    %subst($$text: %len($$text) - 1: 2) = ' :';
  endif;

  //  ... Satz nicht gefunden: leer, außer den Schlüsselfeldern des
  //      zuletzt angezeigten Satzes (siehe readrcd)
  if (IsRecord = bFalse and
      (F_KSeq = 0 or hasprevrcd = bFalse));
    YString = '';
    YStrLen = f_dsplyLn(fldl0100);

  //  ... NULL erlaubt?
  elseif (fldl0100.f1nalw = '1' and
     IO_NullMap(fldl0100.f1seq) = 1);
    YString = f_msgText('TXT0127': '');
    YStrLen = %len(%trimr(YString));
  else;

    monitor;
      //  ... aufbereiten des Feldinhaltes
      peek06(fldl0100: 'FLDL0100': IO_Buff
            : bFalse: bTrue
            : YString: YStrLen: YMsgID: YMsgDta);

      //  ... Konvertieren nicht darstellbarer Zeichen
      peek32(YString: YStrLen: 0
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
    YMsgID  = '';
    YMsgDta = '';
  endif;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr PBSetLL;

  setll %kds(f1key_l0) fpeekfldl0;

endsr;

//============================================================*
//    KeepCsrPos    Beibehalten der Cursorposition            *
//============================================================*

begsr KeepCsrPos;

  //  Beibehalten der Cursorosition (nach EXFMT PBCTL berechnet)
  CsrRow = cursorPosition.row;
  CsrCol = cursorPosition.column;

  CsrCol = CsrCol - pos;
  CsrCol = CsrCol - 1;
  CsrRow = CsrRow - zei;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

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

  SflPage = *hival;
  SflPageDDS = 15;

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
//    ReadRcd       Einlesen des anzuzeigenden Satzes         *
//============================================================*

begsr ReadRcd;

  if (IsRecord = bTrue);
    prevbuff = IO_BuffFld;
    prevnullmap = IO_NullMap;
    hasprevrcd = bTrue;
  endif;

  IsRecord = bFalse;
  if (CIO_isOpen(hFile04) = bTrue);
    if (CIO_chainWithRRN(hFile04
                      : i_rcdNbr
                      : bFalse
                      : IO_Buff
                      : IO_NullMap) = bTrue);
      IsRecord = bTrue;
    endif;
  endif;

  //  Satz nicht mehr vorhanden (z.B. inzwischen gelöscht): Meldung
  //  "Datensatz nicht gefunden." und leerer Satz, nur die Schlüssel-
  //  felder aus dem zuletzt angezeigten Satz (siehe pbfill). Der von
  //  cio_chainwithrrn geleerte Puffer enthält keine gültigen Werte.
  if (IsRecord = bFalse);
    if (hasprevrcd = bTrue);
      IO_BuffFld = prevbuff;
      IO_NullMap = prevnullmap;
    endif;
    p_sndPgmMg('USR8120': '': sds.pgmName);
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Öffnen der Dateien
  open peek14fm;
  open peekfld;
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
  sflmde = '1';

  // - Darstellung der Befehlstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr SetScreen;

  // - Einlesen des anzuzeigenden Satzes
  exsr ReadRcd;

  // - Subfile füllen
  clear f1key_l0;
  f1key_l0.f_fldseq = 0;

  exsr PBInit;
  exsr PBSetLL;
  exsr PBReadUp;

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

  peek06_name = f_pgmCallN('PEEK06');
  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');
  peek32_name = f_pgmCallN('PEEK32');
  peek45_name = f_pgmCallN('PEEK45');
  peek64_name = f_pgmCallN('PEEK64');
  peek65_name = f_pgmCallN('PEEK65');

  peek23(sds.pgmName: '*ALL': NBR_F_KEYS
        : yFKeys: yNbrOfKeys);
  ScrnFKeys = %subarr(yFKeys: 1);

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

