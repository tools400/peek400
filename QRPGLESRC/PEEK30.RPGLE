**free
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

dcl-f peek30fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,D_COLORATR
/copy QCOPYLE,SDS
/copy QCOPYLE,QUSCRTUS
/copy QCOPYLE,QUSPTRUS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK30
/undefine internal_prototype

/copy QCOPYLE,USR8158
/copy QCOPYLE,USR9997

/copy QCOPYLE,PPEEK07
/copy QCOPYLE,PPEEK28
/copy QCOPYLE,PPEEK29

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s UsrSpcDta char(64) based(pSpcPtr);
dcl-s YSrlNbrExt like(R_SrlNbr);
dcl-s YDateExt like(R_SrlDate);

dcl-s YAttrLen like(int4_t);
dcl-s YAttrTyp char(1);
dcl-s YValue char(512);

dcl-s YSysName char(8);
dcl-s YSysVers char(6);
dcl-s YSysSrlNbr char(8);
dcl-s YSrlNbrInt like(R_SrlNbr);
dcl-s YDateInt like(R_SrlDate);

dcl-s R_SrlData char(20);
dcl-s R_SrlNbr char(20);
dcl-s R_SrlDate char(20);

//  Konvertierung HEX ==> DEC
dcl-s R_Dec packed(30);
dcl-s R_Hex like(R_SrlNbr);
dcl-s hex char(1) dim(16);
dcl-s zw1 packed(30);
dcl-s Exp like(int4_t);
dcl-s a1 char(1);
dcl-s x like(int4_t);
dcl-s y like(int4_t);

//  DeadDate
dcl-s ZWInt packed(30);
dcl-s ZWExt packed(30);
dcl-s DeadDate packed(8);

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
  CurrDateRv zoned(8);
  CurrYearRv zoned(4) overlay(CurrDateRv) inz;
  CurrMonRv  zoned(2) overlay(CurrDateRv: 5) inz;
  CurrDayRv  zoned(2) overlay(CurrDateRv: 7) inz;
end-ds;

dcl-c bTrueext 66;
dcl-c bFalseext -55;
dcl-c bShareExt 243;

dcl-s IsCompOK char(1) inz(bFalse);
dcl-s IsDateErr char(1) inz(bFalse);
dcl-s IsWriteOK char(1) inz(bFalse);

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

exsr First;

if (IsCompOK = bFalse);
  //     Fehler in der Lizenz-Nr. ...
  if (IsDateErr = bTrue);
    //     ... Datum abgelaufen
    //         ... Abfragen einer neuen LizenzNr.
    exsr GetLicInf;
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
    exsr GetLicInf;
  endif;
else;
  //     Lizenznummer ist OK ...
  o_flag = bTrueext;
endif;

return;

//============================================================*
//    GetLicInf     Abfragen der Lizenznummer                 *
//============================================================*

begsr GetLicInf;

  // - Öffnen der Dateien
  open peek30fm;

  //  Löschen Lizenznummer
  ##LicData = *blanks;

  for do_x1 = 1 to *hival;

    //  Nachrichten anzeigen
    *in89 = '0';
    write msgctl;

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
      exsr C_EndPgm;
      o_flag = bShareExt;
      o_msgID = 'USR9997';
      usr9997.var1 = COLOR_yellow_r;
      usr9997.var2 = COLOR_white;
      o_msgDta = usr9997;
      leave;

    //  Datenfreigabe
    when (workstn.aid = k_enter);
      exsr C_Enter;
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
//    C_EndPgm      Programm beenden                          *
//============================================================*

begsr C_EndPgm;

  p_rmvPgmMg(sds.pgmName);

endsr;

//============================================================*
//    C_Enter       Datenfreigabe                             *
//============================================================*

begsr C_Enter;

  exsr prfb1;

  if (*in99 = *off);
    exsr WrtLicData;
    if (IsWriteOK = bFalse);
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

begsr prfb1;

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

    if (##LicData = *blanks);
      clear usr8158;
      *in99 = '1';
      clear usr8158;
      usr8158.var1 = ##LicData;                                              // Liz.Nr.
      p_sndPgmMg('USR8158': usr8158: sds.pgmName);
      leave;
    endif;

    R_SrlData = ##LicData;
    exsr SplittLic;
    YSrlNbrExt = R_SrlNbr;
    YDateExt = R_SrlDate;

    exsr CompLicNbr;
    if (IsCompOK = bFalse);
      clear usr8158;
      *in99 = '1';
      clear usr8158;
      usr8158.var1 = ##LicData;                                              // Liz.Nr.
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

  IsCompOK = bTrue;
  leavesr;

  //------------------------------------------*
  //  ... Existenzprüfung  UserSpace          *
  //------------------------------------------*
  if (not f_exist(
     qUsrSpc.name: qUsrSpc.lib: '*USRSPC'));
    exsr CrtUsrSpc;
  endif;

  //------------------------------------------*
  //  ... einlesen der aktuellen Daten        *
  //      ( = YSrlNbrExt)                     *
  //------------------------------------------*
  exsr RtvUsrSpc;

  //------------------------------------------*
  //  ... vergleichen der Lizenzdaten         *
  //------------------------------------------*
  exsr CompLicNbr;

endsr;

//============================================================*
//    CompLicNbr    Vergleichen der Lizenzdaten               *
//============================================================*

begsr CompLicNbr;

  //------------------------------------------*
  //  ... berechnen der Vergleichsserien-Nr.  *
  //      ( = YSrlNbrInt)                     *
  //      für normale Lizenznummer            *
  //------------------------------------------*
  IsCompOK = bFalse;
  IsDateErr = bTrue;

  exsr clcintnbr;
  exsr CompLicNb2;

  //------------------------------------------*
  //  ... berechnen der Vergleichsserien-Nr.  *
  //      ( = YSrlNbrInt)                     *
  //      für Firmenlizenznummer              *
  //------------------------------------------*
  if (IsCompOK = bFalse);
    IsCompOK = bFalse;
    IsDateErr = bTrue;

    exsr clcintnbrf;
    exsr CompLicNb2;
  else;
  //    ... die Lizenznummer stimmt bereits
  endif;

endsr;

//============================================================*
//    CompLicNb2    Vergleichen der Lizenzdaten 2             *
//============================================================*

begsr CompLicNb2;

  // -  interne Nummer umsetzen in Dezimalwert
  R_Hex = YSrlNbrInt;
  exsr HexToDec;
  ZWInt = R_Dec;

  // -  externe Nummer umsetzen in Dezimalwert
  R_Hex = YSrlNbrExt;
  exsr HexToDec;
  ZWExt = R_Dec;

  // -  externes Datum umsetzen in Dezimalwert
  R_Hex = YDateExt;
  exsr HexToDec;
  DeadDate = DeadDate - R_Dec + 99999999;

  // -  Angleichen externe Nummer
  ZWExt = ZWExt - R_Dec;
  ZWExt = ZWExt + 99999999;

  //------------------------------------------*
  //  ... vergleichen interne & externe       *
  //      Seriennummer                        *
  //------------------------------------------*
  currTime = %dec(%char(%time(): *HMS0): 6: 0);
  currDateFW = %dec(%char(%date(): *EUR0): 8: 0);
  CurrDayRv = currDayFW;
  CurrMonRv = currMonFW;
  CurrYearRv = currYearFW;

  if (ZWExt <> ZWInt);
    IsCompOK = bFalse;
    IsDateErr = bFalse;
  else;
    if (DeadDate < CurrDateRv);
      IsCompOK = bFalse;
      IsDateErr = bTrue;
    else;
      IsCompOK = bTrue;
      IsDateErr = bFalse;
    endif;
  endif;

endsr;

//============================================================*
//    CrtUsrSpc     Anlegen UserSpace                         *
//============================================================*

begsr CrtUsrSpc;

  quscrtus(qUsrSpc: 'USRSPC': 64: x'00': '*ALL'
          : 'Peek/400 Lizenzdaten');

endsr;

//============================================================*
//    RtvUsrSpc     Einlesen UserSpace                        *
//============================================================*

begsr RtvUsrSpc;

  qusptrus(qUsrSpc: pSpcPtr);

  R_SrlData = UsrSpcDta;
  exsr SplittLic;
  YSrlNbrExt = R_SrlNbr;
  YDateExt = R_SrlDate;

endsr;

//============================================================*
//    SplittLic     Splitten der Lizenzdaten                  *
//============================================================*

begsr SplittLic;

  x = %scan('-': R_SrlData);
  if (x > *zeros);
    x = x - 1;
    if (x > *zeros);
      R_SrlNbr = %subst(R_SrlData: 1: x);
    else;
      R_SrlNbr = *blanks;
    endif;

    x = x + 2;
    if (x <= 64);
      R_SrlDate = %subst(R_SrlData: x);
    else;
      R_SrlDate = *blanks;
    endif;
  else;
    R_SrlNbr = *blanks;
    R_SrlDate = *blanks;
  endif;

endsr;

//============================================================*
//    ClcIntNbr     Berechnen der internen Serien-Nr.         *
//============================================================*

begsr clcintnbr;

  // -  Netzwerkattribute (ohne Statusmeldung)
  peek07('SYSNAME': bTrue
        : YAttrLen: YAttrTyp: YValue);
  if (YAttrLen > *zeros);
    YSysName = %subst(YValue: 1: YAttrLen);
  else;
    YSysName = *blanks;
  endif;

  // -  Version
  YSysVers = '010000';

  // -  Seriennummer
  peek28('QSRLNBR': bFalse
        : YAttrLen: YAttrTyp: YValue);
  if (YAttrLen > *zeros);
    YSysSrlNbr = %subst(YValue: 1: YAttrLen);
  else;
    YSysSrlNbr = *blanks;
  endif;

  peek29(YSysName: '010000'
        : YSysSrlNbr: 0: R_SrlData);

  exsr SplittLic;
  YSrlNbrInt = R_SrlNbr;
  YDateInt = R_SrlDate;

endsr;

//============================================================*
//    ClcIntNbrF    Berechnen der internen Serien-Nr.         *
//                  für eine Firmenlizenz                     *
//============================================================*

begsr clcintnbrf;

  peek29('*COMPANY': '999999'
        : '*LICENSE': 0: R_SrlData);

  exsr SplittLic;
  YSrlNbrInt = R_SrlNbr;
  YDateInt = R_SrlDate;

endsr;

//============================================================*
//    WrtLicData    Schreiben der Lizenzdaten                 *
//============================================================*

begsr WrtLicData;

  UsrSpcDta = ##LicData;

endsr;

//============================================================*
//    HexToDec      Konvertieren HEX ==> DEC                  *
//============================================================*

begsr HexToDec;

  R_Dec = *zeros;
  x = %checkr(' ':R_Hex);

  for y = 1 to x;
    a1 = %subst(R_Hex: y: 1);
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

    Exp = x - y;
    if (Exp > *zeros);
      //      ... Exponenten größer 0
      dou (Exp = *zeros);
        zw1 = zw1 * 16;
        Exp = Exp - 1;
      enddo;

      R_Dec = R_Dec + zw1;
    else;
      //      ... Exponent = 0
      R_Dec = R_Dec + zw1;
    endif;

  endfor;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

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

begsr First;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Rückgabewerte
  o_flag = bFalseext;
  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Einlesen und prüfen der Lizenzdaten
  exsr fill##;

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

