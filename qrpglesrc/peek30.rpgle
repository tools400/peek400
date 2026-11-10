**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Prüfen der Lizenzdaten                       *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.5.0                               *
//  Programm : PEEK30                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 03.11.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Lizenzprüfung                                                *
//                                                               *
//===============================================================*
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peek30fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/d_coloratr.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/quscrtus.rpgleinc'
/copy 'qcopyle/qusptrus.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek30.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/usr8158.rpgleinc'
/copy 'qcopyle/usr9997.rpgleinc'

/copy 'qcopyle/ppeek07.rpgleinc'
/copy 'qcopyle/ppeek28.rpgleinc'
/copy 'qcopyle/ppeek29.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-s usrSpcDta char(64) based(pSpcPtr);
dcl-s ySrlNbrExt like(r_srlNbr);
dcl-s yDateExt like(r_srlDate);

dcl-s yAttrLen like(int4_t);
dcl-s yAttrTyp char(1);
dcl-s yValue char(512);

dcl-s ySysName char(8);
dcl-s ySysVers char(6);
dcl-s ySysSrlNbr char(8);
dcl-s ySrlNbrInt like(r_srlNbr);
dcl-s yDateInt like(r_srlDate);

dcl-s r_srlData char(20);
dcl-s r_srlNbr char(20);
dcl-s r_srlDate char(20);

//  Konvertierung HEX ==> DEC
dcl-s r_dec packed(30);
dcl-s r_hex like(r_srlNbr);
dcl-s hex char(1) dim(16);
dcl-s zw1 packed(30);
dcl-s exp like(int4_t);
dcl-s a1 char(1);
dcl-s x like(int4_t);
dcl-s y like(int4_t);

//  deadDate
dcl-s zwInt packed(30);
dcl-s zwExt packed(30);
dcl-s deadDate packed(8);

//  Aktuelle Datum und Uhrzeit
dcl-ds *n;
  currDatTim zoned(14);
  currTime   zoned(6) overlay(currDatTim) inz;
  currDateFW zoned(8) overlay(currDatTim: 7) inz;
  currDayFW  zoned(2) overlay(currDateFW) inz;
  currMonFW  zoned(2) overlay(currDateFW: 3) inz;
  currYearFW zoned(4) overlay(currDateFW: 5) inz;
end-ds;

dcl-ds *n;
  currDateRv zoned(8);
  currYearRv zoned(4) overlay(currDateRv) inz;
  currMonRv  zoned(2) overlay(currDateRv: 5) inz;
  currDayRv  zoned(2) overlay(currDateRv: 7) inz;
end-ds;

dcl-c bTrueext 66;
dcl-c bFalseext -55;
dcl-c bShareExt 243;

dcl-s isCompOK char(1) inz(bFalse);
dcl-s isDateErr char(1) inz(bFalse);
dcl-s isWriteOK char(1) inz(bFalse);

//  declarations for QUSCRTUS
dcl-ds qUsrSpc likeds(qObj_t) inz;

//  Programme
dcl-s peek07_name like(pgmCallN_t) inz;
dcl-s peek28_name like(pgmCallN_t) inz;
dcl-s peek29_name like(pgmCallN_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek30;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  o_flag      like(int4_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-s do_x1 packed(7);

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

if (isCompOK = bFalse);
  //     Fehler in der Lizenz-Nr. ...
  if (isDateErr = bTrue);
    //     ... Datum abgelaufen
    //         ... Abfragen einer neuen LizenzNr.
    exsr getLicInf;
    if (o_flag <> bTrueext);
      //         ... wenn keine neue LizenzNr eingetragen
      //             worden ist, dann bFalse zurückliefern,
      //             damit kein weiterer Test möglich ist.
      open peek30fm;
      zei = zei + 4;
      pos = pos + 4;
      exfmt bild03;
      close peek30fm;
      o_flag = bFalseext;
    else;
    //         ... neue LizenzNr. wurde eingetragen
    //             Rückkehrcode in XFLag ist OK
    endif;
  else;
    //     ... Lizenzdaten abfragen
    exsr getLicInf;
  endif;
else;
  //     Lizenznummer ist OK ...
  o_flag = bTrueext;
endif;

return;

//============================================================*
//    getLicInf     Abfragen der Lizenznummer                 *
//============================================================*

begsr getLicInf;

  // - Öffnen der Dateien
  open peek30fm;

  //  Löschen Lizenznummer
  ##licData = *blanks;

  for do_x1 = 1 to *hival;

    //  Nachrichten anzeigen
    *in89 = '0';
    write msgCtl;

    //  Anzeigen Bildschirm
    exfmt bild01;

    //  Nachrichten löschen
    p_rmvPgmMg(sds.pgmName);

    //  Bezugszahlen löschen
    exsr bzoff1;

    //  Abfragen der Befehlstasten
    select;
    //  F9  - Ende
    when (workstn.aid = k_f9);
      exsr c_endPgm;
      o_flag = bShareExt;
      o_msgID = 'USR9997';
      usr9997.var1 = COLOR_yellow_r;
      usr9997.var2 = COLOR_white;
      o_msgDta = usr9997;
      leave;

    //  Datenfreigabe
    when (workstn.aid = k_enter);
      exsr c_enter;
      if (*in99 = *off);
        o_flag = bTrueext;
        leave;
      endif;

    other;
      //  Falsche Taste gedrückt
      p_wrongKey(workstn.aid: sds.pgmName);
      iter;
    endsl;

  endfor;

  // - Schließen der Dateien
  close peek30fm;

endsr;

//============================================================*
//    c_endPgm      Programm beenden                          *
//============================================================*

begsr c_endPgm;

  p_rmvPgmMg(sds.pgmName);

endsr;

//============================================================*
//    c_enter       Datenfreigabe                             *
//============================================================*

begsr c_enter;

  exsr prfB1;

  if (*in99 = *off);
    exsr wrtLicData;
    if (isWriteOK = bFalse);
      *in99 = '1';
      p_sndPgmMg('USR8159': '': sds.pgmName);
    else;
      zei = zei + 4;
      pos = pos + 4;
      exfmt bild02;
    endif;
  endif;

endsr;

//============================================================*
//    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
//============================================================*

begsr bzoff1;

  //  DSPATR(PC)
  *in20 = '0';

  //  DSPATR(RI)
  *in30 = '0';

  //  Fehler
  *in99 = '0';

endsr;

//============================================================*
//    PRFB1         Prüfen der Eingaben                       *
//============================================================*

begsr prfB1;

  dou ('1');

    exsr prf20;
    if (*in99 = bTrue);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PRF20         Prüfen:  Lizenznummer                     *
//============================================================*

begsr prf20;

  dou ('1');

    if (##licData = *blanks);
      clear usr8158;
      *in99 = '1';
      clear usr8158;
      usr8158.var1 = ##licData;                                              // Liz.Nr.
      p_sndPgmMg('USR8158': usr8158: sds.pgmName);
      leave;
    endif;

    r_srlData = ##licData;
    exsr splittLic;
    ySrlNbrExt = r_srlNbr;
    yDateExt = r_srlDate;

    exsr compLicNbr;
    if (isCompOK = bFalse);
      clear usr8158;
      *in99 = '1';
      clear usr8158;
      usr8158.var1 = ##licData;                                              // Liz.Nr.
      p_sndPgmMg('USR8158': usr8158: sds.pgmName);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in20 = '1';
    *in30 = '1';
  endif;

endsr;

//============================================================*
//    Fill##        Abrufen der Lizenzdaten und füllen der    *
//                  BIldschirmfelder                          *
//============================================================*

begsr fill##;

  isCompOK = bTrue;
  leavesr;

  //------------------------------------------*
  //  ... Existenzprüfung  UserSpace          *
  //------------------------------------------*
  if (not f_exist(
     qUsrSpc.name: qUsrSpc.lib: '*USRSPC'));
    exsr crtUsrSpc;
  endif;

  //------------------------------------------*
  //  ... einlesen der aktuellen Daten        *
  //      ( = ySrlNbrExt)                     *
  //------------------------------------------*
  exsr rtvUsrSpc;

  //------------------------------------------*
  //  ... vergleichen der Lizenzdaten         *
  //------------------------------------------*
  exsr compLicNbr;

endsr;

//============================================================*
//    compLicNbr    Vergleichen der Lizenzdaten               *
//============================================================*

begsr compLicNbr;

  //------------------------------------------*
  //  ... berechnen der Vergleichsserien-Nr.  *
  //      ( = ySrlNbrInt)                     *
  //      für normale Lizenznummer            *
  //------------------------------------------*
  isCompOK = bFalse;
  isDateErr = bTrue;

  exsr clcIntNbr;
  exsr compLicNb2;

  //------------------------------------------*
  //  ... berechnen der Vergleichsserien-Nr.  *
  //      ( = ySrlNbrInt)                     *
  //      für Firmenlizenznummer              *
  //------------------------------------------*
  if (isCompOK = bFalse);
    isCompOK = bFalse;
    isDateErr = bTrue;

    exsr clcIntNbrF;
    exsr compLicNb2;
  else;
  //    ... die Lizenznummer stimmt bereits
  endif;

endsr;

//============================================================*
//    compLicNb2    Vergleichen der Lizenzdaten 2             *
//============================================================*

begsr compLicNb2;

  // -  interne Nummer umsetzen in Dezimalwert
  r_hex = ySrlNbrInt;
  exsr hexToDec;
  zwInt = r_dec;

  // -  externe Nummer umsetzen in Dezimalwert
  r_hex = ySrlNbrExt;
  exsr hexToDec;
  zwExt = r_dec;

  // -  externes Datum umsetzen in Dezimalwert
  r_hex = yDateExt;
  exsr hexToDec;
  deadDate = deadDate - r_dec + 99999999;

  // -  Angleichen externe Nummer
  zwExt = zwExt - r_dec;
  zwExt = zwExt + 99999999;

  //------------------------------------------*
  //  ... vergleichen interne & externe       *
  //      Seriennummer                        *
  //------------------------------------------*
  currTime = %dec(%char(%time(): *HMS0): 6: 0);
  currDateFW = %dec(%char(%date(): *EUR0): 8: 0);
  currDayRv = currDayFW;
  currMonRv = currMonFW;
  currYearRv = currYearFW;

  if (zwExt <> zwInt);
    isCompOK = bFalse;
    isDateErr = bFalse;
  else;
    if (deadDate < currDateRv);
      isCompOK = bFalse;
      isDateErr = bTrue;
    else;
      isCompOK = bTrue;
      isDateErr = bFalse;
    endif;
  endif;

endsr;

//============================================================*
//    crtUsrSpc     Anlegen UserSpace                         *
//============================================================*

begsr crtUsrSpc;

  quscrtus(qUsrSpc: 'USRSPC': 64: x'00': '*ALL'
          : 'Peek/400 Lizenzdaten');

endsr;

//============================================================*
//    rtvUsrSpc     Einlesen UserSpace                        *
//============================================================*

begsr rtvUsrSpc;

  qusptrus(qUsrSpc: pSpcPtr);

  r_srlData = usrSpcDta;
  exsr splittLic;
  ySrlNbrExt = r_srlNbr;
  yDateExt = r_srlDate;

endsr;

//============================================================*
//    splittLic     Splitten der Lizenzdaten                  *
//============================================================*

begsr splittLic;

  x = %scan('-': r_srlData);
  if (x > *zeros);
    x = x - 1;
    if (x > *zeros);
      r_srlNbr = %subst(r_srlData: 1: x);
    else;
      r_srlNbr = *blanks;
    endif;

    x = x + 2;
    if (x <= 64);
      r_srlDate = %subst(r_srlData: x);
    else;
      r_srlDate = *blanks;
    endif;
  else;
    r_srlNbr = *blanks;
    r_srlDate = *blanks;
  endif;

endsr;

//============================================================*
//    clcIntNbr     Berechnen der internen Serien-Nr.         *
//============================================================*

begsr clcIntNbr;

  // -  Netzwerkattribute (ohne Statusmeldung)
  peek07('SYSNAME': bTrue
        : yAttrLen: yAttrTyp: yValue);
  if (yAttrLen > *zeros);
    ySysName = %subst(yValue: 1: yAttrLen);
  else;
    ySysName = *blanks;
  endif;

  // -  Version
  ySysVers = '010000';

  // -  Seriennummer
  peek28('QSRLNBR': bFalse
        : yAttrLen: yAttrTyp: yValue);
  if (yAttrLen > *zeros);
    ySysSrlNbr = %subst(yValue: 1: yAttrLen);
  else;
    ySysSrlNbr = *blanks;
  endif;

  peek29(ySysName: '010000'
        : ySysSrlNbr: 0: r_srlData);

  exsr splittLic;
  ySrlNbrInt = r_srlNbr;
  yDateInt = r_srlDate;

endsr;

//============================================================*
//    clcIntNbrF    Berechnen der internen Serien-Nr.         *
//                  für eine Firmenlizenz                     *
//============================================================*

begsr clcIntNbrF;

  peek29('*COMPANY': '999999'
        : '*LICENSE': 0: r_srlData);

  exsr splittLic;
  ySrlNbrInt = r_srlNbr;
  yDateInt = r_srlDate;

endsr;

//============================================================*
//    wrtLicData    Schreiben der Lizenzdaten                 *
//============================================================*

begsr wrtLicData;

  usrSpcDta = ##licData;

endsr;

//============================================================*
//    hexToDec      Konvertieren HEX ==> DEC                  *
//============================================================*

begsr hexToDec;

  r_dec = *zeros;
  x = %checkr(' ':r_hex);

  for y = 1 to x;
    a1 = %subst(r_hex: y: 1);
    if (a1 = *blanks);
      leave;
    endif;

    zw1 = 1;
    zw1 = %lookup(a1: hex);
    if (zw1 = 0);
      //      ... Umsetzung in Dezimalwert nicht gelungen
      iter;
    endif;

    zw1 = zw1 - 1;

    exp = x - y;
    if (exp > *zeros);
      //      ... Exponenten größer 0
      dou (exp = *zeros);
        zw1 = zw1 * 16;
        exp = exp - 1;
      enddo;

      r_dec = r_dec + zw1;
    else;
      //      ... Exponent = 0
      r_dec = r_dec + zw1;
    endif;

  endfor;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 2;
    pos = 26;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 1;
    pos = 4;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Rückgabewerte
  o_flag = bFalseext;
  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Einlesen und prüfen der Lizenzdaten
  exsr fill##;

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

  peek07_name = f_pgmCallN('PEEK07');
  peek28_name = f_pgmCallN('PEEK28');
  peek29_name = f_pgmCallN('PEEK29');

  qUsrSpc.name = 'PEEKSRL';
  qUsrSpc.lib  = f_getPrdLb();

  hex(1) = '0';
  hex(2) = '1';
  hex(3) = '2';
  hex(4) = '3';
  hex(5) = '4';
  hex(6) = '5';
  hex(7) = '6';
  hex(8) = '7';
  hex(9) = '8';
  hex(10) = '9';
  hex(11) = 'A';
  hex(12) = 'B';
  hex(13) = 'C';
  hex(14) = 'D';
  hex(15) = 'E';
  hex(16) = 'F';

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

