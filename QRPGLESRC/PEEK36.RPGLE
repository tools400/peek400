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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,CEECNDHDLR

/COPY QCOPYLE,USR8171

/define internal_prototype
/COPY QCOPYLE,PPEEK36
/undefine internal_prototype

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-s r_dateiso       date(*iso) inz(*loval );
dcl-s r_timeiso       time(*iso) inz(*loval );
dcl-s r_timestmp      timestamp inz(*loval );
dcl-s r_fldlen        like(int4_t);
dcl-s r_pos           like(int4_t);
dcl-s r_buffer        like(i_buffer);
dcl-s r_value         varchar(26);
dcl-s r_dftsep        char(1);
dcl-c r_bufflen       const(%size(i_buffer));

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek36;
  i_buffer        const like(smallBuffer_t);
  i_type          const like(dataType_t);
  i_dattimfmt     const like(fldl0100_t.f1dtfm);
  i_separator     const like(fldl0100_t.f1dtsp);
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
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
    r_timestmp = %timestamp(i_buffer);
    r_fldlen = 26;
  endsl;
on-error;
  o_msgid = 'USR8242';
  return;
endmon;

//  Hinter dem Wert darf nichts mehr stehen
r_pos = r_fldlen + 1;
if (r_pos <= r_bufflen);
  r_buffer = %subst(i_buffer: r_pos);
else;
  r_buffer = '';
endif;

if (r_buffer <> '');
  o_msgid = 'USR8242';
endif;

return;

//============================================================*
//    ChkDate       Prüfen Datum in allen Formaten            *
//============================================================*

begsr chkdate;

  select;
  when (i_dattimfmt = '*EUR');
    r_dftsep = '.';
    r_fldlen = 10;
  when (i_dattimfmt = '*USA');
    r_dftsep = '/';
    r_fldlen = 10;
  when (i_dattimfmt = '*JIS');
    r_dftsep = '-';
    r_fldlen = 10;
  when (i_dattimfmt = '*MDY' or i_dattimfmt = '*DMY' or
        i_dattimfmt = '*YMD');
    r_dftsep = '/';
    r_fldlen = 8;
  when (i_dattimfmt = '*JUL');
    r_dftsep = '/';
    r_fldlen = 6;
  other;
    r_dftsep = '-';
    r_fldlen = 10;
  endsl;

  exsr getvalue;

  select;
  when (i_dattimfmt = '*EUR');
    r_dateiso = %date(r_value: *eur);
  when (i_dattimfmt = '*USA');
    r_dateiso = %date(r_value: *usa);
  when (i_dattimfmt = '*JIS');
    r_dateiso = %date(r_value: *jis);
  when (i_dattimfmt = '*MDY');
    r_dateiso = %date(r_value: *mdy);
  when (i_dattimfmt = '*DMY');
    r_dateiso = %date(r_value: *dmy);
  when (i_dattimfmt = '*YMD');
    r_dateiso = %date(r_value: *ymd);
  when (i_dattimfmt = '*JUL');
    r_dateiso = %date(r_value: *jul);
  other;
    r_dateiso = %date(r_value: *iso);
  endsl;

endsr;

//============================================================*
//    ChkTime       Prüfen Zeit in allen Formaten             *
//============================================================*

begsr chktime;

  select;
  when (i_dattimfmt = '*HMS' or i_dattimfmt = '*USA' or
        i_dattimfmt = '*JIS');
    r_dftsep = ':';
  other;
    r_dftsep = '.';
  endsl;
  r_fldlen = 8;

  exsr getvalue;

  select;
  when (i_dattimfmt = '*HMS');
    r_timeiso = %time(r_value: *hms);
  when (i_dattimfmt = '*EUR');
    r_timeiso = %time(r_value: *eur);
  when (i_dattimfmt = '*USA');
    r_timeiso = %time(r_value: *usa);
  when (i_dattimfmt = '*JIS');
    r_timeiso = %time(r_value: *jis);
  other;
    r_timeiso = %time(r_value: *iso);
  endsl;

endsr;

//============================================================*
//    GetValue      Wert mit dem Standardtrennzeichen des     *
//                  Formats, damit %date/%time ihn lesen kann *
//============================================================*

begsr getvalue;

  r_value = %subst(i_buffer: 1: r_fldlen);
  if (i_separator <> ' ' and i_separator <> r_dftsep);
    r_value = %xlate(i_separator: r_dftsep: r_value);
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  o_msgid = '';
  o_msgdta = '';

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorhandler;
  dcl-pi *N;
    i_condtoken     value likeds(cee_fc_t);
    i_pcommarea     int(10) value;
    o_action        int(10);
    o_newcondtoken  likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

