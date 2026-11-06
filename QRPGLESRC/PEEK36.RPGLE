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

dcl-s r_dateISO date(*iso) inz(*loval);
dcl-s r_timeISO time(*iso) inz(*loval);
dcl-s r_timeStmp timestamp(12) inz(*loval);
dcl-s r_fldLen like(int4_t);
dcl-s r_pos like(int4_t);
dcl-s r_buffer like(i_buffer);
dcl-s r_value varchar(32);
dcl-s r_dftsep char(1);
dcl-c r_buffLen %size(i_buffer);

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
exsr first;

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
r_pos = r_fldLen + 1;
if (r_pos <= r_buffLen);
  r_buffer = %subst(i_buffer: r_pos);
else;
  r_buffer = '';
endif;

if (r_buffer <> '');
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
    r_fldLen = 10;
  when (i_datTimFmt = '*USA');
    r_dftsep = '/';
    r_fldLen = 10;
  when (i_datTimFmt = '*JIS');
    r_dftsep = '-';
    r_fldLen = 10;
  when (i_datTimFmt = '*MDY' or i_datTimFmt = '*DMY' or
        i_datTimFmt = '*YMD');
    r_dftsep = '/';
    r_fldLen = 8;
  when (i_datTimFmt = '*JUL');
    r_dftsep = '/';
    r_fldLen = 6;
  other;
    r_dftsep = '-';
    r_fldLen = 10;
  endsl;

  exsr getvalue;

  select;
  when (i_datTimFmt = '*EUR');
    r_dateISO = %date(r_value: *eur);
  when (i_datTimFmt = '*USA');
    r_dateISO = %date(r_value: *usa);
  when (i_datTimFmt = '*JIS');
    r_dateISO = %date(r_value: *jis);
  when (i_datTimFmt = '*MDY');
    r_dateISO = %date(r_value: *mdy);
  when (i_datTimFmt = '*DMY');
    r_dateISO = %date(r_value: *dmy);
  when (i_datTimFmt = '*YMD');
    r_dateISO = %date(r_value: *ymd);
  when (i_datTimFmt = '*JUL');
    r_dateISO = %date(r_value: *jul);
  other;
    r_dateISO = %date(r_value: *iso);
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
  r_fldLen = 8;

  exsr getvalue;

  select;
  when (i_datTimFmt = '*HMS');
    r_timeISO = %time(r_value: *hms);
  when (i_datTimFmt = '*EUR');
    r_timeISO = %time(r_value: *eur);
  when (i_datTimFmt = '*USA');
    r_timeISO = %time(r_value: *usa);
  when (i_datTimFmt = '*JIS');
    r_timeISO = %time(r_value: *jis);
  other;
    r_timeISO = %time(r_value: *iso);
  endsl;

endsr;

//============================================================*
//    ChkTimestamp  Prüfen Zeitstempel                        *
//============================================================*

begsr chktimestamp;

  //  yyyy-mm-dd-hh.mm.ss ohne oder mit 1 bis 12 Nachkommastellen
  //  (TIMESTAMP(0) bis TIMESTAMP(12)): Die Länge ergibt sich aus
  //  dem Wert.
  r_fldLen = %scan(' ': i_buffer) - 1;
  if (r_fldLen < 0);
    r_fldLen = r_buffLen;
  endif;

  //  Andere Längen wie bisher mit 26 Stellen prüfen, damit der Wert
  //  oder das, was dahinter steht, zu USR8242 führt.
  if (r_fldLen <> 19 and (r_fldLen < 21 or r_fldLen > 32));
    r_fldLen = 26;
  endif;

  //  %timestamp(...: *iso: 12) erwartet genau 12 Nachkommastellen:
  //  fehlende Stellen mit Nullen auffüllen.
  if (r_fldLen = 19);
    r_value = %subst(i_buffer: 1: 19) + '.';
  else;
    r_value = %subst(i_buffer: 1: r_fldLen);
  endif;
  if (%len(r_value) < 32);
    r_value += %subst('000000000000': 1: 32 - %len(r_value));
  endif;

  r_timeStmp = %timestamp(r_value: *iso: 12);

endsr;

//============================================================*
//    GetValue      Wert mit dem Standardtrennzeichen des     *
//                  Formats, damit %date/%time ihn lesen kann *
//============================================================*

begsr getvalue;

  r_value = %subst(i_buffer: 1: r_fldLen);
  if (i_separator <> ' ' and i_separator <> r_dftsep);
    r_value = %xlate(i_separator: r_dftsep: r_value);
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

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

