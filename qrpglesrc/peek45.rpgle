**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Hex-Feldeditierung                           *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK45                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 15.08.98  Raddatz                                 *
//  geändert : 27.04.99  2.1.0                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Hexadezimale Feldeditierung                                  *
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

dcl-f peek45fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-f peekFld keyed usropn prefix(f_) infds(peek_01_ds);

dcl-ds workstn likeds(workstn_t);

dcl-ds peek_01_ds likeds(infds_t);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/d_infds.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek45.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/set0006.rpgleinc'

/copy 'qcopyle/usr8100.rpgleinc'
/copy 'qcopyle/usr8136.rpgleinc'

dcl-ds fldl0100 likeds(fldl0100_t) inz;
dcl-ds set0006 likeds(set0006_t) inz;

//  Peek21
dcl-s yPgmCmd like(pgmCmd_t) inz;
dcl-s yCmdDta like(pgmCmdDt_t) inz;
dcl-s yMsgID like(msgId_t) inz;
dcl-s yMsgDta like(msgDta_t) inz;

//  Peek23:
dcl-s yFKeys like(fKeyDsp_t) inz dim(32);
dcl-s yNbrOfKeys like(int4_t) inz;

//  Peek32
dcl-s yBuffer like(rcdBuf_t) inz;
dcl-s yBuffLen like(int4_t) inz;

dcl-s sfBot like(int4_t) inz;
dcl-c NBR_F_KEYS 3;

dcl-s x like(int4_t) inz;
dcl-s i like(int4_t) inz;

dcl-s isStringInp like(bool_t) inz(bFalse);
dcl-s isPgmError like(bool_t) inz(bFalse);
dcl-s isDataChg like(bool_t) inz(bFalse);

dcl-c HEX_DIGITS '0123456789ABCDEF';

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek32_name like(pgmCallN_t) inz;


// Arbeitsfelder
dcl-s pStartPos like(#startPos) inz;
dcl-ds *n;
  pFldInhaltSbcs like(rcdBuf_t) inz;
  pFldInhaltUcs2 like(rcdBufUcs2_t) inz overlay(pFldInhaltSbcs);
end-ds;
dcl-s pLength like(int4_t) inz;
dcl-s pTmpNewLen like(int4_t) inz;
dcl-s pTmpHexLen like(int4_t) inz;
dcl-s pTmpHexBin like(#hexString) inz;

dcl-s warning_1 like(bool_t) inz(bFalse);
dcl-s warning_2 like(bool_t) inz(bFalse);

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'
/copy 'qcopyle/ppeek32.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'
/copy 'qcopyle/ppeek71.rpgleinc'

dcl-s $ofsVal zoned(4) dim(8) inz;

dcl-ds #hexString;
  #hexVal char(8) dim(32) inz;
end-ds;

dcl-ds $expString;
  $strVal char(16) dim(8) inz;
end-ds;

dcl-s idx int(10) inz;
dcl-s ofs int(10) inz;
dcl-s hTranscoder like(hTranscoder_t) inz;

//  Der Wert steht schon in der Job-CCSID (Änderungsprogramm, PGM)
dcl-s isJobCcsid like(bool_t) inz(bFalse);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek45;
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
  i_isJobCcsid like(bool_t) options(*nopass) const;
end-pi;

dcl-ds f_key likerec(fpeekfld: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

//---------------------------------------------------*
//  Schleife für Programmbearbeitung

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

  //  Füllen "Offset" Angaben
  idx = 0;
  ofs = pStartPos - 1;
  for idx = 1 to %elem($ofsVal);
    $ofsVal(idx) = ofs;
    ofs = ofs + %len($strVal(1));
  endfor;

  //  Anzeigen Bildschirm
  exsr toScreen;
  exfmt bild01;
  exsr fromScreen;

  //  Daten geändert
  isDataChg = *in93;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Bezugszahlen löschen
  exsr bzoff1;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
  if (yMsgID <> ' ');
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    iter;
  endif;

  //  Abfragen der Programmbefehle
  select;
  //  F3  - Ende
  when (yPgmCmd = '*EXIT');
    exsr c_endPgm;
    leave;

  //  F5  - Aktualisieren
  when (yPgmCmd = '*REFRESH');
    exsr c_refresh;
    iter;

  //  F7  - Umschalten der Eingabe
  when (yPgmCmd = '*TGLINPUT');
    exsr c_enter;
    exsr c_tgInput;
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

  //  F19 - nach rechts verschieben (ein Feld)
  when (yPgmCmd = '*LEFT');
    exsr c_moveL;

  //  F20 - nach links verschieben  (ein Feld)
  when (yPgmCmd = '*RIGHT');
    exsr c_moveR;

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
  when (yPgmCmd = '*ENTER');
    exsr c_enter;
    if (isPgmError = bFalse);
      o_msgID  = 'USR8112';
      o_msgDta = ' ';

      if (i_isUcs2 = 0);
        io_fldInhalt.sbcs = pFldInhaltSbcs;
      else;
        io_fldInhalt.ucs2 = pFldInhaltUcs2;
      endif;

      io_length = pLength;
      leave;
    endif;

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

if (%open(peekFld));
  close peekFld;
endif;

if (%open(peekFld));
  close peekFld;
endif;

close peek45fm;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  if (isPgmError = bTrue);

  //    ---------------------------------
  //    *** Genereller Programmfehler ***
  //    ***    keine Verarbeitung     ***
  //    ***          möglich          ***
  //    ---------------------------------

  else;

    //  Prüfen der Eingaben
    exsr prfB1;

    if (isPgmError = bFalse);


      if (isDataChg = bTrue);

        if (isStringInp = bFalse);
          //  Einsetzen geänderten Hex-String ...
          //  ... umwandeln HexString (Bildschirmanzeige) nach HexWert (Pufferinhalt)
          pTmpHexBin = ' ';
          p_chrToHex(pTmpHexBin               :
                    #hexString               :
                    %len(%trimr(#hexString)));
          //      (Länge_Hex_Nibble / 2 = Länge_Hex_Bin)
          x = %len(%trimr(#hexString)) / 2;
        else;
          pTmpHexBin = %subst(pFldInhaltSbcs:pStartPos);
          for x = 1 to %len($expString);
            if (%subst($expString: x: 1) <> set0006.set_cvtc);
              %subst(pTmpHexBin: x: 1) =
                   %subst($expString: x: 1);
            endif;
          endfor;
          //      (Länge = Feldlänge)
          x = %len($expString);
        endif;

        //  ... einsetzen in Zwischenfeld für Rückgabewert
        %subst(pFldInhaltSbcs: pStartPos: x) =
          %subst(pTmpHexBin: 1: x);

        if (i_isUcs2 = 0);
          pLength = %len(%trimr(pFldInhaltSbcs));
        else;
          pLength = %len(%trimr(pFldInhaltUcs2));
        endif;

        //  Füllen #hexString und $expString
        exsr fill##2;

        //  Merken der neuen Startposition
        pStartPos = #startPos;

        isPgmError = bTrue;
      endif;
    endif;

  endif;

endsr;

//============================================================*
//    c_pageUp      "Page Up"                                 *
//============================================================*

begsr c_pageUp;

  #startPos = #startPos + 128;
  if (#startPos > $bufLaenge);
    #startPos = $bufLaenge - 128 + 1;
  endif;

  *in93 = *on;
  isDataChg = *in93;

  exsr c_enter;

endsr;

//============================================================*
//    c_pageDown    "Page Down"                               *
//============================================================*

begsr c_pageDown;

  #startPos = #startPos - 128;
  if (#startPos < 1);
    #startPos = 1;
  endif;

  *in93 = *on;
  isDataChg = *in93;

  exsr c_enter;

endsr;

//============================================================*
//    bzoff1        Ausschalten aller Fehlerbezugszahlen      *
//============================================================*

begsr bzoff1;

  //  DSPATR(PC)
  *in20 = *off; // ##FIELD
  *in21 = *off; // ##FIELD

  //  DSPATR(RI)
  *in30 = *off; // ##FIELD
  *in31 = *off; // ##FIELD

  //  Fehler
  isPgmError = bFalse;

  //  Warnungen
  if (isDataChg = bTrue);
    warning_1 = bFalse;
    warning_2 = bFalse;
  endif;

endsr;

//============================================================*
//    prfb1         Prüfen der Eingaben                       *
//============================================================*

begsr prfB1;

  //  Länge und Zeichen des Hex-Strings
  exsr prf20;
  if (isPgmError = bTrue);
    leavesr;
  endif;

  //  Startposition
  exsr prf21;
  if (isPgmError = bTrue);
    leavesr;
  endif;

endsr;

//============================================================*
//    prf20         Prüfen:  Hex-String                       *
//============================================================*

begsr prf20;

  dou ('1');

    //  prüfen auf unzulässige Zeichen
    x = %check(HEX_DIGITS: #hexString);
    if (x > 0  and x <= %len(%trimr(#hexString)));
      p_sndPgmMg('USR8174'
                : %subst(#hexString: x: 1)
                : sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

    //  Zeichenkette zu lang
    if (%len(%trimr(#hexString))/2 + pStartPos - 1 >
        f_buffLn(fldl0100));
      if (warning_2 = bTrue);
        #hexString = %subst(#hexString :
                           1          :
                           f_buffLn(fldl0100) * 2);
        isDataChg = bTrue;
      else;
        p_sndPgmMg('USR8176': '': sds.pgmName);
        warning_2 = bTrue;
        isPgmError = bTrue;
        leave;
      endif;
    endif;

    //  Ungerade Anzahl Zeichen
    x = %len(%trimr(#hexString));
    x = %rem(x: 2);
    if (x <> 0);
      p_sndPgmMg('USR8175': '': sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

    //  Zeichenkette zu kurz
    if (%len(%trimr(#hexString))/2 + pStartPos -1 <
        f_buffLn(fldl0100)
        and
        (%len(%trimr(#hexString)) < %len(#hexString)));
      if (warning_1 = bTrue);
        dow ((%len(%trimr(#hexString))/2 + pStartPos -1 <
             f_buffLn(fldl0100))
           and
           (%len(%trimr(#hexString)) < %len(#hexString)));

          if (i_isUcs2 = 0);
            #hexString = %trimr(#hexString) + '40';
          else;
            #hexString = %trimr(#hexString) + '0020';
          endif;

          pFldInhaltSbcs = %subst(pFldInhaltSbcs: 1:
          pStartPos - 1 + %len(%trimr(#hexString)));
          isDataChg = bTrue;
        enddo;
      else;
        p_sndPgmMg('USR8186': '': sds.pgmName);
        warning_1  = bTrue;
        isPgmError = bTrue;
        leave;
      endif;
    endif;

  enddo;

  if (isPgmError = bTrue);
    *in20 = *on;
    *in30 = *on;
    #startPos = pStartPos;
  endif;

endsr;

//============================================================*
//    prf21         Prüfen:  Startposition                    *
//============================================================*

begsr prf21;

  dou ('1');

    if (#startPos <= *zeros);
      p_sndPgmMg('USR8178': '': sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

    if (#startPos > $bufLaenge);
      p_sndPgmMg('USR8177': '': sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

  enddo;

  if (isPgmError = bTrue);
    *in21 = *on;
    *in31 = *on;
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
//    c_firstPos    Erste Position anzeigen                   *
//============================================================*

begsr c_firstPos;

  #startPos = 1;

  isDataChg = bTrue;
  exsr c_enter;

endsr;

//============================================================*
//    c_lastPos     Letzte Position anzeigen                  *
//============================================================*

begsr c_lastPos;

  #startPos = $bufLaenge            -
             %len(#hexString) / 2 +
             1;
  if (#startPos < 0);
    #startPos = 1;
  endif;

  isDataChg = bTrue;
  exsr c_enter;

endsr;

//============================================================*
//    c_moveL       Nach links verschieben                    *
//============================================================*

begsr c_moveL;

  if (#startPos - %len(#hexString)/2 > 0);
    #startPos = #startPos - %len(#hexString)/2;
  else;
    #startPos = 1;
  endif;

  isDataChg = bTrue;
  exsr c_enter;

endsr;

//============================================================*
//    c_moveR       Nach rechts verschieben                   *
//============================================================*

begsr c_moveR;

  if (#startPos + %len(#hexString)/2 < $bufLaenge);
    #startPos = #startPos + %len(#hexString)/2;
  else;
    #startPos = $bufLaenge - %len(#hexString)/2
               + 1;
    if (#startPos < 0);
      #startPos = 1;
    endif;
  endif;

  isDataChg = bTrue;
  exsr c_enter;

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  pStartPos  = 1;
  exsr getParameters;

  exsr bzoff1;
  exsr fill##;

endsr;

//============================================================*
//    c_tgInput     F7  - Umschalten Eingabe                  *
//============================================================*

begsr c_tgInput;

  if (isStringInp = bTrue);
    isStringInp = bFalse;
  else;
    isStringInp = bTrue;
  endif;

  *in51 = isStringInp;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    fill##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  //  anzeigen Feldüberschrift
  $fldName = f_headline(i_headType: fldl0100);

  //  anzeigen alphanumerisches oder numerisches Feld
  if ((f_isNumFld(fldl0100) = bTrue) and
      (f_isFloatFld(fldl0100) = bFalse));
    *in60 = *on;
    $fldLaenge = fldl0100.f1Digt;
    $fldDezSt  = fldl0100.f1DecP;
  else;
    *in60 = *off;
    $fldLaenge = f_buffLn(fldl0100);
    $fldDezSt  = 0;
  endif;

  //  anzeigen Pufferlänge
  if (f_isVarLen(fldl0100) = bTrue);
    *in61 = *on;
  else;
    *in61 = *off;
  endif;

  $bufLaenge = f_buffLn(fldl0100);

  #startPos = pStartPos;

  exsr fill##2;

endsr;

//=========================================================*
//    fill##2    - füllen Felder:  #hexString             *
//                                 $expString             *
//                 aus pFldInhalt                         *
//=========================================================*

begsr fill##2;

  //  berechnen der Länge der aus dem Puffer zu
  //  entnehmenden Binärzeichenkette
  pTmpHexLen = $bufLaenge - #startPos + 1;

  if (pTmpHexLen > %len(#hexString) / 2);
    pTmpHexLen = %len(#hexString) / 2;
  endif;

  //  entnehmen der Binärzeichenkette aus dem Puffer
  %subst(pTmpHexBin: 1) =
  %subst(pFldInhaltSbcs: #startPos: pTmpHexLen);

  //  umwandeln einer Binärzeichenkette in eine
  //  lesbare Hex-Zeichenkette zur Editierung
  //  durch den Benutzer
  #hexString = ' ';
  p_hexToChr(#hexString    :
            pTmpHexBin    :
            pTmpHexLen * 2);

  //  Umsetzen Zeichensatz (nicht, wenn die Datenbank CHAR-Felder schon
  //  in die Job-CCSID umgesetzt hat; UCS-2 setzt sie nicht um)
  if (f_hasCcsid(fldl0100) = bTrue and
      (isJobCcsid = bFalse or i_isUcs2 <> 0));
    monitor;
      hTranscoder =
       Transcoder_toJobCcsid(fldl0100.f1fdcc);
      pTmpNewLen =
       Transcoder_xlateBuffer(hTranscoder
                              : %addr(pTmpHexBin)
                              : pTmpHexLen
                              : %size(pTmpHexBin));
    on-error;
      //  Umsetzung gescheitert (Escape-Nachricht CPF9897 von PEEK71):
      //  Zeichen unverändert anzeigen. PEEK71 ändert den Puffer im
      //  Fehlerfall nicht.
      pTmpNewLen = pTmpHexLen;
    endmon;
    if (pTmpHexLen = pTmpNewLen * 2);
      for i = pTmpNewLen downto 1;
        %subst(pTmpHexBin: (2*i)-1: 1) =
        %subst(pTmpHexBin: i: 1);
        %subst(pTmpHexBin: (2*i)  : 1) = ' ';
      endfor;
    elseif (pTmpNewLen < pTmpHexLen);
      //  Kürzer, aber nicht halb so lang (UTF-8: 'Ä' 2 Bytes -> 1 Zeichen):
      //  Rest mit Leerzeichen füllen, sonst erscheinen dort die
      //  restlichen, nicht umgesetzten Bytes.
      %subst(pTmpHexBin: pTmpNewLen + 1: pTmpHexLen - pTmpNewLen) = '';
    endif;
  endif;

  //  anzeigen expandierte Zeichenkette aus dem Puffer ...
  //  ... konvertieren nicht darstellbarer Zeichen
  yBuffer    = pTmpHexBin;
  yBuffLen   = pTmpHexLen;
  peek32(yBuffer: yBuffLen: 0: yMsgID: yMsgDta);
  $expString = yBuffer;

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
    zei = 3;
    pos = 4;
  endif;

endsr;

//============================================================*
//    getUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getUsrSetg;

  //  *CVTCHR
  set0006 = f_getUsrSg('*CVTCHR');

endsr;

//============================================================*
//    getParameters Laden der Programmparameter               *
//============================================================*

begsr getParameters;

  if (i_isUcs2 = 0);
    clear pFldInhaltSbcs;
    %subst(pFldInhaltSbcs: 1: io_length) =
          io_fldInhalt.sbcs;
  else;
    clear pFldInhaltUcs2;
    %subst(pFldInhaltUcs2: 1: io_length) =
          io_fldInhalt.ucs2;
  endif;

  pLength = io_length;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Steht der Wert schon in der Job-CCSID?
  if (%parms() >= %parmnum(i_isJobCcsid));
    isJobCcsid = i_isJobCcsid;
  else;
    isJobCcsid = bFalse;
  endif;

  // - Öffnen der Dateien
  open peekFld;

  open peek45fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Genereller Programmfehler
  isPgmError = bFalse;

  // - Ermitteln der Feldeigenschaften
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

  // - Übernehmen der Programmparameter
  pStartPos  = 1;
  exsr getParameters;

  if (isPgmError = bTrue);
    *in70 = '1';
  else;
    *in70 = i_protect;
  endif;

  o_msgID  = '';
  o_msgDta = '';

  // - Benutzervoreinstellungen
  exsr getUsrSetg;

  // - Sperren Felder für Offset-Anzeige
  *in50 = '0';

  // - Sperren Felder für String-Eingabe
  isStringInp = bFalse;
  *in51 = isStringInp;

  // - Füllen der Bildschirmfelder
  exsr bzoff1;
  exsr fill##;

  // - Darstellung der Befehlstasten
  sfBot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setScreen;

  // - Copyright
  p_sndPgmMg('USR9999': i_copyright: sds.pgmName);

endsr;

//====================================================*
//  Copy program fields to screen.                    *
//====================================================*

begsr toScreen;

  $ofs1 = $ofsVal( 1);
  $ofs2 = $ofsVal( 2);
  $ofs3 = $ofsVal( 3);
  $ofs4 = $ofsVal( 4);
  $ofs5 = $ofsVal( 5);
  $ofs6 = $ofsVal( 6);
  $ofs7 = $ofsVal( 7);
  $ofs8 = $ofsVal( 8);

  #hex11 = #hexVal( 1);
  #hex12 = #hexVal( 2);
  #hex13 = #hexVal( 3);
  #hex14 = #hexVal( 4);

  #hex21 = #hexVal( 5);
  #hex22 = #hexVal( 6);
  #hex23 = #hexVal( 7);
  #hex24 = #hexVal( 8);

  #hex31 = #hexVal( 9);
  #hex32 = #hexVal(10);
  #hex33 = #hexVal(11);
  #hex34 = #hexVal(12);

  #hex41 = #hexVal(13);
  #hex42 = #hexVal(14);
  #hex43 = #hexVal(15);
  #hex44 = #hexVal(16);

  #hex51 = #hexVal(17);
  #hex52 = #hexVal(18);
  #hex53 = #hexVal(19);
  #hex54 = #hexVal(20);

  #hex61 = #hexVal(21);
  #hex62 = #hexVal(22);
  #hex63 = #hexVal(23);
  #hex64 = #hexVal(24);

  #hex71 = #hexVal(25);
  #hex72 = #hexVal(26);
  #hex73 = #hexVal(27);
  #hex74 = #hexVal(28);

  #hex81 = #hexVal(29);
  #hex82 = #hexVal(30);
  #hex83 = #hexVal(31);
  #hex84 = #hexVal(32);

  $str1 = $strVal( 1);
  $str2 = $strVal( 2);
  $str3 = $strVal( 3);
  $str4 = $strVal( 4);
  $str5 = $strVal( 5);
  $str6 = $strVal( 6);
  $str7 = $strVal( 7);
  $str8 = $strVal( 8);

endsr;

//====================================================*
//  Copy screen to program fields.                    *
//====================================================*

begsr fromScreen;

  $ofsVal( 1) = $ofs1;
  $ofsVal( 2) = $ofs2;
  $ofsVal( 3) = $ofs3;
  $ofsVal( 4) = $ofs4;
  $ofsVal( 5) = $ofs5;
  $ofsVal( 6) = $ofs6;
  $ofsVal( 7) = $ofs7;
  $ofsVal( 8) = $ofs8;

  #hexVal( 1) = #hex11;
  #hexVal( 2) = #hex12;
  #hexVal( 3) = #hex13;
  #hexVal( 4) = #hex14;

  #hexVal( 5) = #hex21;
  #hexVal( 6) = #hex22;
  #hexVal( 7) = #hex23;
  #hexVal( 8) = #hex24;

  #hexVal( 9) = #hex31;
  #hexVal(10) = #hex32;
  #hexVal(11) = #hex33;
  #hexVal(12) = #hex34;

  #hexVal(13) = #hex41;
  #hexVal(14) = #hex42;
  #hexVal(15) = #hex43;
  #hexVal(16) = #hex44;

  #hexVal(17) = #hex51;
  #hexVal(18) = #hex52;
  #hexVal(19) = #hex53;
  #hexVal(20) = #hex54;

  #hexVal(21) = #hex61;
  #hexVal(22) = #hex62;
  #hexVal(23) = #hex63;
  #hexVal(24) = #hex64;

  #hexVal(25) = #hex71;
  #hexVal(26) = #hex72;
  #hexVal(27) = #hex73;
  #hexVal(28) = #hex74;

  #hexVal(29) = #hex81;
  #hexVal(30) = #hex82;
  #hexVal(31) = #hex83;
  #hexVal(32) = #hex84;

  $strVal( 1) = $str1;
  $strVal( 2) = $str2;
  $strVal( 3) = $str3;
  $strVal( 4) = $str4;
  $strVal( 5) = $str5;
  $strVal( 6) = $str6;
  $strVal( 7) = $str7;
  $strVal( 8) = $str8;

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
  peek32_name = f_pgmCallN('PEEK32');

  peek23(sds.pgmName: '*ALL': 0
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

