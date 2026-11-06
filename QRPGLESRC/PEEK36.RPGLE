**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK36                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 29.01.1998  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Prüfen Datum-, Zeit, Zeitstempelfelder            *
//                                                               *
//  geändert : 01.04.04  für Version 2.2.2                       *
//                     added support for time format *HMS, *EUR  *
//                     added support for date format *EUR        *
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

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,USR8171

/define internal_prototype
/copy QCOPYLE,PPEEK36
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s R_DateISO date(*iso) inz(*loval);
dcl-s R_TimeISO time(*iso) inz(*loval);
dcl-s R_TimeStmp timestamp(12) inz(*loval);
dcl-s R_FldLen like(int4_t);
dcl-s R_Pos like(int4_t);
dcl-s R_Buffer like(i_buffer);
dcl-s R_Value varchar(32);
dcl-s r_dftsep char(1);
dcl-c R_BuffLen %size(i_buffer);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek36;
  i_buffer    like(smallBuffer_t) const;
  i_type      like(dataType_t) const;
  i_datTimFmt like(fldl0100_t.f1dtfm) const;
  i_separator like(fldl0100_t.f1dtsp) const;
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);
exsr First;

if (i_type <> 'L' and i_type <> 'T' and i_type <> 'Z');
  p_kill('Incorrect data type: ' + i_type);
endif;

//  Prüfen Format für ...
//  Ein ungültiger Wert ergibt die Meldung USR8242 statt eines
//  Abbruchs (RNQ0112); das Feld setzt PEEK18 in die Meldungsdaten.
monitor;
  select;
  // ... Datum
  when (i_type = 'L');
    exsr chkdate;
  // ... Zeit
  when (i_type = 'T');
    exsr chktime;
  // ... Zeitstempel
  other;
    exsr chktimestamp;
  endsl;
on-error;
  o_msgID = 'USR8242';
  return;
endmon;

//  Hinter dem Wert darf nichts mehr stehen
R_Pos = R_FldLen + 1;
if (R_Pos <= R_BuffLen);
  R_Buffer = %subst(i_buffer: R_Pos);
else;
  R_Buffer = '';
endif;

if (R_Buffer <> '');
  o_msgID = 'USR8242';
endif;

return;

//============================================================*
//    ChkDate       Prüfen Datum in allen Formaten            *
//============================================================*

begsr chkdate;

  select;
  when (i_datTimFmt = '*EUR');
    r_dftsep = '.';
    R_FldLen = 10;
  when (i_datTimFmt = '*USA');
    r_dftsep = '/';
    R_FldLen = 10;
  when (i_datTimFmt = '*JIS');
    r_dftsep = '-';
    R_FldLen = 10;
  when (i_datTimFmt = '*MDY' or i_datTimFmt = '*DMY' or
        i_datTimFmt = '*YMD');
    r_dftsep = '/';
    R_FldLen = 8;
  when (i_datTimFmt = '*JUL');
    r_dftsep = '/';
    R_FldLen = 6;
  other;
    r_dftsep = '-';
    R_FldLen = 10;
  endsl;

  exsr getvalue;

  select;
  when (i_datTimFmt = '*EUR');
    R_DateISO = %date(R_Value: *eur);
  when (i_datTimFmt = '*USA');
    R_DateISO = %date(R_Value: *usa);
  when (i_datTimFmt = '*JIS');
    R_DateISO = %date(R_Value: *jis);
  when (i_datTimFmt = '*MDY');
    R_DateISO = %date(R_Value: *mdy);
  when (i_datTimFmt = '*DMY');
    R_DateISO = %date(R_Value: *dmy);
  when (i_datTimFmt = '*YMD');
    R_DateISO = %date(R_Value: *ymd);
  when (i_datTimFmt = '*JUL');
    R_DateISO = %date(R_Value: *jul);
  other;
    R_DateISO = %date(R_Value: *iso);
  endsl;

endsr;

//============================================================*
//    ChkTime       Prüfen Zeit in allen Formaten             *
//============================================================*

begsr chktime;

  select;
  when (i_datTimFmt = '*HMS' or i_datTimFmt = '*USA' or
        i_datTimFmt = '*JIS');
    r_dftsep = ':';
  other;
    r_dftsep = '.';
  endsl;
  R_FldLen = 8;

  exsr getvalue;

  select;
  when (i_datTimFmt = '*HMS');
    R_TimeISO = %time(R_Value: *hms);
  when (i_datTimFmt = '*EUR');
    R_TimeISO = %time(R_Value: *eur);
  when (i_datTimFmt = '*USA');
    R_TimeISO = %time(R_Value: *usa);
  when (i_datTimFmt = '*JIS');
    R_TimeISO = %time(R_Value: *jis);
  other;
    R_TimeISO = %time(R_Value: *iso);
  endsl;

endsr;

//============================================================*
//    ChkTimestamp  Prüfen Zeitstempel                        *
//============================================================*

begsr chktimestamp;

  //  yyyy-mm-dd-hh.mm.ss ohne oder mit 1 bis 12 Nachkommastellen
  //  (TIMESTAMP(0) bis TIMESTAMP(12)): Die Länge ergibt sich aus
  //  dem Wert.
  R_FldLen = %scan(' ': i_buffer) - 1;
  if (R_FldLen < 0);
    R_FldLen = R_BuffLen;
  endif;

  //  Andere Längen wie bisher mit 26 Stellen prüfen, damit der Wert
  //  oder das, was dahinter steht, zu USR8242 führt.
  if (R_FldLen <> 19 and (R_FldLen < 21 or R_FldLen > 32));
    R_FldLen = 26;
  endif;

  //  %timestamp(...: *iso: 12) erwartet genau 12 Nachkommastellen:
  //  fehlende Stellen mit Nullen auffüllen.
  if (R_FldLen = 19);
    R_Value = %subst(i_buffer: 1: 19) + '.';
  else;
    R_Value = %subst(i_buffer: 1: R_FldLen);
  endif;
  if (%len(R_Value) < 32);
    R_Value += %subst('000000000000': 1: 32 - %len(R_Value));
  endif;

  R_TimeStmp = %timestamp(R_Value: *iso: 12);

endsr;

//============================================================*
//    GetValue      Wert mit dem Standardtrennzeichen des     *
//                  Formats, damit %date/%time ihn lesen kann *
//============================================================*

begsr getvalue;

  R_Value = %subst(i_buffer: 1: R_FldLen);
  if (i_separator <> ' ' and i_separator <> r_dftsep);
    R_Value = %xlate(i_separator: r_dftsep: R_Value);
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  o_msgID = '';
  o_msgDta = '';

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

