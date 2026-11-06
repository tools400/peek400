**free
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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

dcl-f peek45fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-f peekfld keyed usropn prefix(f_) infds(Peek_01_DS);

dcl-ds workstn likeds(workstn_t);

dcl-ds Peek_01_DS likeds(infds_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,SDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK45
/undefine internal_prototype

/copy QCOPYLE,SET0006

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8136

dcl-ds fldl0100 likeds(fldl0100_t) inz;
dcl-ds set0006 likeds(set0006_t) inz;

//  Peek21
dcl-s YPgmCmd like(pgmCmd_t) inz;
dcl-s YCmdDta like(pgmCmdDt_t) inz;
dcl-s YMsgID like(msgId_t) inz;
dcl-s YMsgDta like(msgDta_t) inz;

//  Peek23:
dcl-s yFKeys like(fKeyDsp_t) inz dim(32);
dcl-s yNbrOfKeys like(int4_t) inz;

//  Peek32
dcl-s YBuffer like(rcdBuf_t) inz;
dcl-s yBuffLen like(int4_t) inz;

dcl-s sfbot like(int4_t) inz;
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
dcl-s pStartPos like(#StartPos) inz;
dcl-ds *n;
  pFldInhaltSbcs like(rcdBuf_t) inz;
  pFldInhaltUcs2 like(rcdBufUcs2_t) inz overlay(pFldInhaltSbcs);
end-ds;
dcl-s pLength like(int4_t) inz;
dcl-s pTmpNewLen like(int4_t) inz;
dcl-s pTmpHexLen like(int4_t) inz;
dcl-s pTmpHexBin like(#HexString) inz;

dcl-s warning_1 like(bool_t) inz(bFalse);
dcl-s warning_2 like(bool_t) inz(bFalse);

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK32

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK71

dcl-s $OfsVal zoned(4) dim(8) inz;

dcl-ds #HexString;
  #HexVal char(8) dim(32) inz;
end-ds;

dcl-ds $expstring;
  $StrVal char(16) dim(8) inz;
end-ds;

dcl-s idx int(10) inz;
dcl-s ofs int(10) inz;
dcl-s hTranscoder like(hTranscoder_t) inz;

//  Der Wert steht schon in der Job-CCSID (Änderungsprogramm, PGM)
dcl-s isjobccsid like(bool_t) inz(bFalse);

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
  io_Length    like(int4_t);
  i_protect    like(bool_t) const;
  i_isUcs2     like(int4_t) const;
  o_msgID      like(msgId_t);
  o_msgDta     like(msgDta_t);
  i_isjobccsid like(bool_t) options(*nopass) const;
end-pi;

dcl-ds f_key likerec(fpeekfld: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr First;

//---------------------------------------------------*
//  Schleife für Programmbearbeitung

dow ('1');

  //  Nachrichten anzeigen
  *in89 = *off;
  write msgctl;

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
  when ((sfbot = 7) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#7;
  when ((sfbot = 8) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#8;
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Füllen "Offset" Angaben
  idx = 0;
  ofs = pStartPos - 1;
  for idx = 1 to %elem($OfsVal);
    $OfsVal(idx) = ofs;
    ofs = ofs + %len($StrVal(1));
  endfor;

  //  Anzeigen Bildschirm
  exsr ToScreen;
  exfmt bild01;
  exsr FromScreen;

  //  Daten geändert
  isDataChg = *in93;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Bezugszahlen löschen
  exsr bzoff1;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
  if (YMsgID <> ' ');
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    iter;
  endif;

  //  Abfragen der Programmbefehle
  select;
  //  F3  - Ende
  when (YPgmCmd = '*EXIT');
    exsr C_EndPgm;
    leave;

  //  F5  - Aktualisieren
  when (YPgmCmd = '*REFRESH');
    exsr C_Refresh;
    iter;

  //  F7  - Umschalten der Eingabe
  when (YPgmCmd = '*TGLINPUT');
    exsr C_Enter;
    exsr c_tgInput;
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

  //  F19 - nach rechts verschieben (ein Feld)
  when (YPgmCmd = '*LEFT');
    exsr C_MoveL;

  //  F20 - nach links verschieben  (ein Feld)
  when (YPgmCmd = '*RIGHT');
    exsr C_MoveR;

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
  when (YPgmCmd = '*ENTER');
    exsr C_Enter;
    if (isPgmError = bFalse);
      o_msgID  = 'USR8112';
      o_msgDta = ' ';

      if (i_isUcs2 = 0);
        io_fldInhalt.sbcs = pFldInhaltSbcs;
      else;
        io_fldInhalt.ucs2 = pFldInhaltUcs2;
      endif;

      io_Length = pLength;
      leave;
    endif;

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

if (%open(peekfld));
  close peekfld;
endif;

if (%open(peekfld));
  close peekfld;
endif;

close peek45fm;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  if (isPgmError = bTrue);

  //    ---------------------------------
  //    *** Genereller Programmfehler ***
  //    ***    keine Verarbeitung     ***
  //    ***          möglich          ***
  //    ---------------------------------

  else;

    //  Prüfen der Eingaben
    exsr prfb1;

    if (isPgmError = bFalse);


      if (isDataChg = bTrue);

        if (isStringInp = bFalse);
          //  Einsetzen geänderten Hex-String ...
          //  ... umwandeln HexString (Bildschirmanzeige) nach HexWert (Pufferinhalt)
          pTmpHexBin = ' ';
          p_ChrToHex(pTmpHexBin               :
                    #HexString               :
                    %len(%trimr(#HexString)));
          //      (Länge_Hex_Nibble / 2 = Länge_Hex_Bin)
          x = %len(%trimr(#HexString)) / 2;
        else;
          pTmpHexBin = %subst(pFldInhaltSbcs:pStartPos);
          for x = 1 to %len($expstring);
            if (%subst($expstring: x: 1) <> set0006.set_cvtc);
              %subst(pTmpHexBin: x: 1) =
                   %subst($expstring: x: 1);
            endif;
          endfor;
          //      (Länge = Feldlänge)
          x = %len($expstring);
        endif;

        //  ... einsetzen in Zwischenfeld für Rückgabewert
        %subst(pFldInhaltSbcs: pStartPos: x) =
          %subst(pTmpHexBin: 1: x);

        if (i_isUcs2 = 0);
          pLength = %len(%trimr(pFldInhaltSbcs));
        else;
          pLength = %len(%trimr(pFldInhaltUcs2));
        endif;

        //  Füllen #HexString und $ExpString
        exsr fill##2;

        //  Merken der neuen Startposition
        pStartPos = #StartPos;

        isPgmError = bTrue;
      endif;
    endif;

  endif;

endsr;

//============================================================*
//    c_pageUp      "Page Up"                                 *
//============================================================*

begsr c_pageUp;

  #StartPos = #StartPos + 128;
  if (#StartPos > $BufLaenge);
    #StartPos = $BufLaenge - 128 + 1;
  endif;

  *in93 = *on;
  isDataChg = *in93;

  exsr C_Enter;

endsr;

//============================================================*
//    c_pageDown    "Page Down"                               *
//============================================================*

begsr c_pageDown;

  #StartPos = #StartPos - 128;
  if (#StartPos < 1);
    #StartPos = 1;
  endif;

  *in93 = *on;
  isDataChg = *in93;

  exsr C_Enter;

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

begsr prfb1;

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
    x = %check(HEX_DIGITS: #HexString);
    if (x > 0  and x <= %len(%trimr(#HexString)));
      p_sndPgmMg('USR8174'
                : %subst(#HexString: x: 1)
                : sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

    //  Zeichenkette zu lang
    if (%len(%trimr(#HexString))/2 + pStartPos - 1 >
        f_buffLn(fldl0100));
      if (warning_2 = bTrue);
        #HexString = %subst(#HexString :
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
    x = %len(%trimr(#HexString));
    x = %rem(x: 2);
    if (x <> 0);
      p_sndPgmMg('USR8175': '': sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

    //  Zeichenkette zu kurz
    if (%len(%trimr(#HexString))/2 + pStartPos -1 <
        f_buffLn(fldl0100)
        and
        (%len(%trimr(#HexString)) < %len(#HexString)));
      if (warning_1 = bTrue);
        dow ((%len(%trimr(#HexString))/2 + pStartPos -1 <
             f_buffLn(fldl0100))
           and
           (%len(%trimr(#HexString)) < %len(#HexString)));

          if (i_isUcs2 = 0);
            #HexString = %trimr(#HexString) + '40';
          else;
            #HexString = %trimr(#HexString) + '0020';
          endif;

          pFldInhaltSbcs = %subst(pFldInhaltSbcs: 1:
          pStartPos - 1 + %len(%trimr(#HexString)));
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
    #StartPos = pStartPos;
  endif;

endsr;

//============================================================*
//    prf21         Prüfen:  Startposition                    *
//============================================================*

begsr prf21;

  dou ('1');

    if (#StartPos <= *zeros);
      p_sndPgmMg('USR8178': '': sds.pgmName);
      isPgmError = bTrue;
      leave;
    endif;

    if (#StartPos > $BufLaenge);
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
//    c_firstPos    Erste Position anzeigen                   *
//============================================================*

begsr c_firstPos;

  #StartPos = 1;

  isDataChg = bTrue;
  exsr C_Enter;

endsr;

//============================================================*
//    c_lastPos     Letzte Position anzeigen                  *
//============================================================*

begsr c_lastPos;

  #StartPos = $BufLaenge            -
             %len(#HexString) / 2 +
             1;
  if (#StartPos < 0);
    #StartPos = 1;
  endif;

  isDataChg = bTrue;
  exsr C_Enter;

endsr;

//============================================================*
//    c_moveL       Nach links verschieben                    *
//============================================================*

begsr C_MoveL;

  if (#StartPos - %len(#HexString)/2 > 0);
    #StartPos = #StartPos - %len(#HexString)/2;
  else;
    #StartPos = 1;
  endif;

  isDataChg = bTrue;
  exsr C_Enter;

endsr;

//============================================================*
//    c_moveR       Nach rechts verschieben                   *
//============================================================*

begsr C_MoveR;

  if (#StartPos + %len(#HexString)/2 < $BufLaenge);
    #StartPos = #StartPos + %len(#HexString)/2;
  else;
    #StartPos = $BufLaenge - %len(#HexString)/2
               + 1;
    if (#StartPos < 0);
      #StartPos = 1;
    endif;
  endif;

  isDataChg = bTrue;
  exsr C_Enter;

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr C_Refresh;

  pStartPos  = 1;
  exsr GetParameters;

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

begsr C_MoreKeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    fill##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  //  anzeigen Feldüberschrift
  $FldName = f_headline(i_headType: fldl0100);

  //  anzeigen alphanumerisches oder numerisches Feld
  if ((f_isNumFld(fldl0100) = bTrue) and
      (f_isFloatFld(fldl0100) = bFalse));
    *in60 = *on;
    $FldLaenge = fldl0100.f1digt;
    $FldDezSt  = fldl0100.f1decp;
  else;
    *in60 = *off;
    $FldLaenge = f_buffLn(fldl0100);
    $FldDezSt  = 0;
  endif;

  //  anzeigen Pufferlänge
  if (f_isVarLen(fldl0100) = bTrue);
    *in61 = *on;
  else;
    *in61 = *off;
  endif;

  $BufLaenge = f_buffLn(fldl0100);

  #StartPos = pStartPos;

  exsr fill##2;

endsr;

//=========================================================*
//    fill##2    - füllen Felder:  #HexString             *
//                                 $ExpString             *
//                 aus pFldInhalt                         *
//=========================================================*

begsr fill##2;

  //  berechnen der Länge der aus dem Puffer zu
  //  entnehmenden Binärzeichenkette
  pTmpHexLen = $BufLaenge - #StartPos + 1;

  if (pTmpHexLen > %len(#HexString) / 2);
    pTmpHexLen = %len(#HexString) / 2;
  endif;

  //  entnehmen der Binärzeichenkette aus dem Puffer
  %subst(pTmpHexBin: 1) =
  %subst(pFldInhaltSbcs: #StartPos: pTmpHexLen);

  //  umwandeln einer Binärzeichenkette in eine
  //  lesbare Hex-Zeichenkette zur Editierung
  //  durch den Benutzer
  #HexString = ' ';
  p_hexToChr(#HexString    :
            pTmpHexBin    :
            pTmpHexLen * 2);

  //  Umsetzen Zeichensatz (nicht, wenn die Datenbank CHAR-Felder schon
  //  in die Job-CCSID umgesetzt hat; UCS-2 setzt sie nicht um)
  if (f_hasCcsid(fldl0100) = bTrue and
      (isjobccsid = bFalse or i_isUcs2 <> 0));
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
  YBuffer    = pTmpHexBin;
  yBuffLen   = pTmpHexLen;
  peek32(YBuffer: yBuffLen: 0: YMsgID: YMsgDta);
  $expstring = YBuffer;

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
    zei = 3;
    pos = 4;
  endif;

endsr;

//============================================================*
//    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr GetUsrSetg;

  //  *CVTCHR
  set0006 = f_getUsrSg('*CVTCHR');

endsr;

//============================================================*
//    GetParameters Laden der Programmparameter               *
//============================================================*

begsr GetParameters;

  if (i_isUcs2 = 0);
    clear pFldInhaltSbcs;
    %subst(pFldInhaltSbcs: 1: io_Length) =
          io_fldInhalt.sbcs;
  else;
    clear pFldInhaltUcs2;
    %subst(pFldInhaltUcs2: 1: io_Length) =
          io_fldInhalt.ucs2;
  endif;

  pLength = io_Length;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Steht der Wert schon in der Job-CCSID?
  if (%parms() >= %parmnum(i_isjobccsid));
    isjobccsid = i_isjobccsid;
  else;
    isjobccsid = bFalse;
  endif;

  // - Öffnen der Dateien
  open peekfld;

  open peek45fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Genereller Programmfehler
  isPgmError = bFalse;

  // - Ermitteln der Feldeigenschaften
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

  // - Übernehmen der Programmparameter
  pStartPos  = 1;
  exsr GetParameters;

  if (isPgmError = bTrue);
    *in70 = '1';
  else;
    *in70 = i_protect;
  endif;

  o_msgID  = '';
  o_msgDta = '';

  // - Benutzervoreinstellungen
  exsr GetUsrSetg;

  // - Sperren Felder für Offset-Anzeige
  *in50 = '0';

  // - Sperren Felder für String-Eingabe
  isStringInp = bFalse;
  *in51 = isStringInp;

  // - Füllen der Bildschirmfelder
  exsr bzoff1;
  exsr fill##;

  // - Darstellung der Befehlstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr SetScreen;

  // - Copyright
  p_sndPgmMg('USR9999': i_copyright: sds.pgmName);

endsr;

//====================================================*
//  Copy program fields to screen.                    *
//====================================================*

begsr ToScreen;

  $ofs1 = $OfsVal( 1);
  $ofs2 = $OfsVal( 2);
  $ofs3 = $OfsVal( 3);
  $ofs4 = $OfsVal( 4);
  $ofs5 = $OfsVal( 5);
  $ofs6 = $OfsVal( 6);
  $ofs7 = $OfsVal( 7);
  $ofs8 = $OfsVal( 8);

  #hex11 = #HexVal( 1);
  #hex12 = #HexVal( 2);
  #hex13 = #HexVal( 3);
  #hex14 = #HexVal( 4);

  #hex21 = #HexVal( 5);
  #hex22 = #HexVal( 6);
  #hex23 = #HexVal( 7);
  #hex24 = #HexVal( 8);

  #hex31 = #HexVal( 9);
  #hex32 = #HexVal(10);
  #hex33 = #HexVal(11);
  #hex34 = #HexVal(12);

  #hex41 = #HexVal(13);
  #hex42 = #HexVal(14);
  #hex43 = #HexVal(15);
  #hex44 = #HexVal(16);

  #hex51 = #HexVal(17);
  #hex52 = #HexVal(18);
  #hex53 = #HexVal(19);
  #hex54 = #HexVal(20);

  #hex61 = #HexVal(21);
  #hex62 = #HexVal(22);
  #hex63 = #HexVal(23);
  #hex64 = #HexVal(24);

  #hex71 = #HexVal(25);
  #hex72 = #HexVal(26);
  #hex73 = #HexVal(27);
  #hex74 = #HexVal(28);

  #hex81 = #HexVal(29);
  #hex82 = #HexVal(30);
  #hex83 = #HexVal(31);
  #hex84 = #HexVal(32);

  $str1 = $StrVal( 1);
  $str2 = $StrVal( 2);
  $str3 = $StrVal( 3);
  $str4 = $StrVal( 4);
  $str5 = $StrVal( 5);
  $str6 = $StrVal( 6);
  $str7 = $StrVal( 7);
  $str8 = $StrVal( 8);

endsr;

//====================================================*
//  Copy screen to program fields.                    *
//====================================================*

begsr FromScreen;

  $OfsVal( 1) = $ofs1;
  $OfsVal( 2) = $ofs2;
  $OfsVal( 3) = $ofs3;
  $OfsVal( 4) = $ofs4;
  $OfsVal( 5) = $ofs5;
  $OfsVal( 6) = $ofs6;
  $OfsVal( 7) = $ofs7;
  $OfsVal( 8) = $ofs8;

  #HexVal( 1) = #hex11;
  #HexVal( 2) = #hex12;
  #HexVal( 3) = #hex13;
  #HexVal( 4) = #hex14;

  #HexVal( 5) = #hex21;
  #HexVal( 6) = #hex22;
  #HexVal( 7) = #hex23;
  #HexVal( 8) = #hex24;

  #HexVal( 9) = #hex31;
  #HexVal(10) = #hex32;
  #HexVal(11) = #hex33;
  #HexVal(12) = #hex34;

  #HexVal(13) = #hex41;
  #HexVal(14) = #hex42;
  #HexVal(15) = #hex43;
  #HexVal(16) = #hex44;

  #HexVal(17) = #hex51;
  #HexVal(18) = #hex52;
  #HexVal(19) = #hex53;
  #HexVal(20) = #hex54;

  #HexVal(21) = #hex61;
  #HexVal(22) = #hex62;
  #HexVal(23) = #hex63;
  #HexVal(24) = #hex64;

  #HexVal(25) = #hex71;
  #HexVal(26) = #hex72;
  #HexVal(27) = #hex73;
  #HexVal(28) = #hex74;

  #HexVal(29) = #hex81;
  #HexVal(30) = #hex82;
  #HexVal(31) = #hex83;
  #HexVal(32) = #hex84;

  $StrVal( 1) = $str1;
  $StrVal( 2) = $str2;
  $StrVal( 3) = $str3;
  $StrVal( 4) = $str4;
  $StrVal( 5) = $str5;
  $StrVal( 6) = $str6;
  $StrVal( 7) = $str7;
  $StrVal( 8) = $str8;

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
  peek32_name = f_pgmCallN('PEEK32');

  peek23(sds.pgmName: '*ALL': 0
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

