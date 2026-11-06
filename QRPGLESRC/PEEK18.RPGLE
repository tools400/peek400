**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK18                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 24.10.97  Raddatz                                 *
//  geändert : 27.04.99  für Version 2.1.0                       *
//  geändert : 23.05.02  für Version 2.2.0                       *
//                       fixed problem with 2B0 fields           *
//  geändert : 23.03.04  für Version 2.2.2                       *
//                       added support for  3I0 fields           *
//                       added support for 20I0 fields           *
//  geändert : 01.04.04  für Version 2.2.2                       *
//                     added support for time format *HMS, *EUR  *
//                     added support for date format *EUR        *
//  geändert : 11.10.06  für Version 2.4.1                       *
//                       added support for  3I0 key fields       *
//                       added support for 20I0 key fields       *
//  geändert:  29.07.20  RNX0100: Length or start position is    *
//                       out of range ...                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Konvertieren: interne <==> externe Darstellung               *
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

dcl-f peekFld keyed usropn prefix(f_);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,SDS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK18
/undefine internal_prototype

/copy QCOPYLE,SET0003

/copy QCOPYLE,USR8138

/copy QCOPYLE,PPEEK36

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK71

dcl-ds set0003 likeds(set0003_t) inz;

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-s yMsgID char(7);
dcl-s yMsgDta char(512);
dcl-s isMinus char(1) inz(bFalse);
dcl-s x like(int4_t) inz;
dcl-s a1 char(1) inz(*blanks);

// Maximale Feldlänge liegt bei 30 Stellen wegen Bildschirmgroesse.
// Siehe PEEK58, f_isNotAlw().
dcl-ds *n;
  zoned   zoned(63) inz;
  zoned_a char(63) overlay(zoned: 1);
end-ds;

dcl-ds *n;
  packed   packed(63) inz;
  packed_a char(32) overlay(packed: 1);
end-ds;

dcl-ds *n;
  binary1   int(3) inz pos(1);
  binary1_a char(1) overlay(binary1: 1);
end-ds;

dcl-ds *n;
  binary2   int(5) inz pos(1);
  binary2_a char(2) overlay(binary2: 1);
end-ds;

dcl-ds *n;
  binary4   int(10) inz pos(1);
  binary4_a char(4) overlay(binary4: 1);
end-ds;

dcl-ds *n;
  binary8   int(20) inz pos(1);
  binary8_a char(8) overlay(binary8: 1);
end-ds;

dcl-s float float(8) inz;
dcl-s float4 float(4) based(pFloat);
dcl-s float8 float(8) based(pFloat);

dcl-ds dsFloat qualified inz;
  float8 float(8);
  float4 float(4) overlay(float8);
end-ds;

dcl-s hTranscoder like(hTranscoder_t) inz;

dcl-s SET_SIGN_PLUS like(set0003.set_signP) inz('+');
dcl-s SET_SIGN_MINUS like(set0003.set_signM) inz('-');

dcl-s r_tgtValue like(i_tgtValue) inz(*blanks);
dcl-s r_dateISO date(*iso) inz(*loval);
dcl-s r_timeISO time(*iso) inz(*loval);
dcl-s r_timeStmp timestamp inz(*loval);

dcl-s strPos like(int4_t) inz;

dcl-s peek36_name like(pgmCallN_t) inz;

//    Converts a given buffer into the Job ccsid.
dcl-pr cvtToJobCcsid int(10) extproc('cvtToJobCcsid');
  io_buffer like(rcdBuf_t);
  i_length  int(10) value;
  i_ccsid   int(10) value;
end-pr;

//    Converts a given buffer into the File ccsid.
dcl-pr cvtToFileCcsid int(10) extproc('cvtToFileCcsid');
  io_buffer like(rcdBuf_t);
  i_length  int(10) value;
  i_ccsid   int(10) value;
end-pr;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek18;
  i_fldl0100  likeds(fldl0100_t) const;
  i_rcdFmt    like(fmt_t) const;
  i_buffer    like(rcdBuf_t);
  i_tgtFormat like(format_t) const;
  i_tgtValue  like(format_t) const;
  o_buffer    like(rcdBuf_t);
  o_buffLen   like(int4_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-ds f_key likerec(fpeekfld: *key);

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

fldl0100 = i_fldl0100;

o_buffer = *blanks;
o_buffLen = *zeros;

select;
when (i_tgtFormat = '*EXTERN');
  //  *ACCESSKEY bei jedem Aufruf lesen, damit eine Änderung sofort
  //  wirkt (PEEK05 und PEEK20 lesen die Einstellung ebenfalls neu)
  exsr getUsrSetg;
  exsr toExtern;
when (i_tgtFormat = '*INTERN');
  exsr getUsrSetg;
  exsr toIntern;
when (i_tgtFormat = '*ZONED');
  exsr toZoned;
when (i_tgtFormat = '*FLOAT');
  exsr toFloat;
other;
endsl;

return;

//============================================================*
//    toExtern      Zielformat:  externe Darstellung          *
//============================================================*

begsr toExtern;

  select;
  when (fldl0100.f1DTyp = 'A');
    exsr a_to_extern;
  when (fldl0100.f1DTyp = 'G');
    exsr g_to_extern;
  when (fldl0100.f1DTyp = 'S');
    exsr s_to_extern;
  when (fldl0100.f1DTyp = 'B');
    exsr b_to_extern;
  when (fldl0100.f1DTyp = 'P');
    exsr p_to_extern;
  when (fldl0100.f1DTyp = 'F');
    exsr f_to_extern;

  other;
    exsr a_to_extern;
  endsl;

endsr;

//============================================================*
//    ToIntern      Zielformat:  interne Darstellung          *
//============================================================*

begsr toIntern;

  //  Art des Schlüssel ermitteln ...
  exsr getKeyType;
  //  Ascending key ...
  if (f_desc = 'A');
    //  ... Keine Umsetzung erforderlich
    r_tgtValue = i_tgtValue;
  else;
    //  Descending key ...
    if (i_tgtValue = '*HIVAL'
        or i_tgtValue = '*LOVAL');
      //  ... *HIVAL ==> *LOVAL und umgekehrt
      if (i_tgtValue = '*HIVAL');
        r_tgtValue = '*LOVAL';
      else;
        r_tgtValue = '*HIVAL';
      endif;
    else;
      //  ... Keine Umsetzung erforderlich
      r_tgtValue = i_tgtValue;
    endif;
  endif;

  select;
  when (fldl0100.f1DTyp = 'A');
    exsr a_to_intern;
  when (fldl0100.f1DTyp = 'G');
    exsr g_to_intern;
  when (fldl0100.f1DTyp = 'S');
    exsr s_to_intern;
  when (fldl0100.f1DTyp = 'B');
    exsr b_to_intern;
  when (fldl0100.f1DTyp = 'P');
    exsr p_to_intern;
  when (fldl0100.f1DTyp = 'L');
    exsr l_to_intern;
  when (fldl0100.f1DTyp = 'T');
    exsr t_to_intern;
  when (fldl0100.f1DTyp = 'Z');
    exsr z_to_intern;
  when (fldl0100.f1DTyp = 'F');
    exsr f_to_intern;

  other;
    exsr a_to_intern;
  endsl;

endsr;

//============================================================*
//    ToZoned       Zielformat:  Zoned-Format                 *
//============================================================*

begsr toZoned;

  fldl0100.f1Digt = %len(zoned_a);

  select;
  when (fldl0100.f1DTyp = 'A');
    exsr a_to_zoned;
  when (fldl0100.f1DTyp = 'S');
    exsr s_to_zoned;
  when (fldl0100.f1DTyp = 'B');
    exsr b_to_zoned;
  when (fldl0100.f1DTyp = 'P');
    exsr p_to_zoned;

  other;
    exsr a_to_zoned;
  endsl;

endsr;

//============================================================*
//    ToFloat       Zielformat:  Float-Format                 *
//============================================================*

begsr toFloat;

  select;
  when (fldl0100.f1DTyp = 'F');
    exsr f_to_float;

  other;
  endsl;

endsr;

//============================================================*
//    A_to_Ext      alpha ==> externe Darstellung             *
//============================================================*

begsr a_to_extern;

  if (f_isVarLen(fldl0100) = bTrue);
    strPos = 3;
  else;
    strPos = 1;
  endif;

  o_buffer =
   %subst(i_buffer
          : strPos: f_buffLn(fldl0100));

  o_buffLen = f_buffLn(fldl0100);

  //  Die Länge bleibt die Feldlänge, weil PEEK20 den externen Teil so
  //  breit liest. Wird der Wert kürzer (UTF-8: 'Ä' 2 Bytes -> 1 Zeichen),
  //  füllt cvtToJobCcsid mit Leerzeichen auf.
  if (f_hasCcsid(fldl0100) = bTrue);
    cvtToJobCcsid(o_buffer: o_buffLen: fldl0100.f1fdcc);
  endif;

  exsr addDelimiter;

endsr;

//============================================================*
//    G_to_Ext      graphic => externe Darstellung            *
//============================================================*

begsr g_to_extern;

  if (f_isVarLen(fldl0100) = bTrue);
    strPos = 3;
  else;
    strPos = 1;
  endif;

  o_buffer =
   %subst(i_buffer
          : strPos: f_buffLn(fldl0100));

  o_buffLen = f_buffLn(fldl0100);

  if (f_hasCcsid(fldl0100) = bTrue);
    o_buffLen =
    cvtToJobCcsid(
     o_buffer: o_buffLen: fldl0100.f1fdcc);
  endif;

  //  So breit, wie PEEK20 den externen Teil liest (Anzahl Zeichen),
  //  auch wenn die CCSID nicht umsetzbar ist (z.B. GRAPHIC 835)
  if (fldl0100.f1ndbc > 0);
    o_buffLen = fldl0100.f1ndbc;
    if (f_isVarLen(fldl0100) = bTrue);
      o_buffLen = o_buffLen - 2;
    endif;
  endif;

  exsr addDelimiter;

endsr;

//============================================================*
//    S_to_Ext      Zoned ==> externe Darstellung             *
//============================================================*

begsr s_to_extern;

  exsr getZoned;
  exsr chgSign;
  exsr zonedToOutBuf;
  exsr addSign;
  exsr addDelimiter;

endsr;

//============================================================*
//    B_to_Ext      Binary ==> externe Darstellung            *
//============================================================*

begsr b_to_extern;

  exsr getBinary;
  exsr chgSign;
  exsr zonedToOutBuf;
  exsr addSign;
  exsr addDelimiter;

endsr;

//============================================================*
//    P_to_Ext      Packed ==> externe Darstellung            *
//============================================================*

begsr p_to_extern;

  exsr getPacked;
  exsr chgSign;
  exsr zonedToOutBuf;
  exsr addSign;
  exsr addDelimiter;

endsr;

//============================================================*
//    F_to_Ext      Float  ==> externe Darstellung            *
//============================================================*

begsr f_to_extern;

  pFloat = %addr(i_buffer);

  if (f_buffLn(fldl0100) = 4);
    float = float4;
    exsr chgSignFloat;
    float4 = float;
    o_buffer = %editflt(float4);
    o_buffLen = 14;
  else;
    float = float8;
    exsr chgSignFloat;
    float8 = float;
    o_buffer = %editflt(float8);
    o_buffLen = 23;
  endif;

  //  Entfernen führendes Vorzeichen
  o_buffer = %subst(o_buffer: 2);
  o_buffLen = o_buffLen - 1;

  exsr addSign;
  exsr addDelimiter;

endsr;

//============================================================*
//    a_to_zoned    alpha ==> Zoned-Format                    *
//============================================================*

begsr a_to_zoned;

  zoned = *zeros;
  exsr zonedToOutBuf;

endsr;

//============================================================*
//    s_to_zoned    Zoned ==> Zoned-Format                    *
//============================================================*

begsr s_to_zoned;

  exsr getZoned;
  exsr zonedToOutBuf;

endsr;

//============================================================*
//    b_to_zoned    Binary ==> Zoned-Format                   *
//============================================================*

begsr b_to_zoned;

  exsr getBinary;
  exsr zonedToOutBuf;

endsr;

//============================================================*
//    p_to_zoned    Packed ==> Zoned-Format                   *
//============================================================*

begsr p_to_zoned;

  exsr getPacked;
  exsr zonedToOutBuf;

endsr;

//============================================================*
//    ZonedToOutBuf Move zoned value to output buffer         *
//============================================================*

begsr zonedToOutBuf;

  x = %len(zoned_a) - fldl0100.f1Digt + 1;

  o_buffLen = fldl0100.f1Digt;
  %subst(o_buffer: 1: o_buffLen) =
    %subst(zoned_a: x);

endsr;

//============================================================*
//    f_to_float    float ==> Float-Format                    *
//============================================================*

begsr f_to_float;

  float = *zeros;
  exsr extractFloat;

endsr;

//============================================================*
//    ExtrFloat                                               *
//============================================================*

begsr extractFloat;

  pFloat = %addr(i_buffer);

  if (f_buffLn(fldl0100) = 4);
    float = float4;
  else;
    float = float8;
  endif;

  o_buffer = %editflt(float);
  o_buffLen = 23;

endsr;

//============================================================*
//    ChgSign       Prüfen auf negatives Vorzeichen           *
//============================================================*

begsr chgSign;

  if (set0003.set_signX = bFalse);
    // ohne Vorzeichen ausgeben
    isMinus = bFalse;
  else;
    if (zoned < 0);
      isMinus = bTrue;
    else;
      isMinus = bFalse;
    endif;
  endif;

  if (isMinus = bTrue);
    zoned = zoned * -1;
  endif;

endsr;

//============================================================*
//    ChgSignFloat  Prüfen auf negatives Vorzeichen           *
//============================================================*

begsr chgSignFloat;

  if (set0003.set_signX = bFalse);
    // ohne Vorzeichen ausgeben
    isMinus = bFalse;
  else;
    if (float < 0);
      isMinus = bTrue;
    else;
      isMinus = bFalse;
    endif;
  endif;

  if (isMinus = bTrue);
    float = float * -1;
  endif;

endsr;

//============================================================*
//    AddSign       hinzufügen von Vorzeichen                 *
//============================================================*

begsr addSign;

  if (set0003.set_signX = bFalse);
  // ohne Vorzeichen ausgeben
  else;
    if (isMinus = bTrue);
      if (SET_SIGN_MINUS = '');
        o_buffer = %trimr(o_buffer) + ' ';
      else;
        o_buffer = %trimr(o_buffer) + SET_SIGN_MINUS;
      endif;
      o_buffLen = o_buffLen + 1;
    else;
      if (SET_SIGN_PLUS = '');
        o_buffer = %trimr(o_buffer) + ' ';
      else;
        o_buffer = %trimr(o_buffer) + SET_SIGN_PLUS;
      endif;
      o_buffLen = o_buffLen + 1;
    endif;
  endif;

endsr;

//============================================================*
//    AddDlmtr      hinzufügen des Delimeters                 *
//============================================================*

begsr addDelimiter;

  if (set0003.set_dlmtr = '');
  // ohne Delimeter ausgeben
  else;
    if (o_buffLen < RCD_BUFF_LEN);
      o_buffLen = o_buffLen + 1;
      %subst(
       o_buffer: o_buffLen: 1) = set0003.set_dlmtr;
    else;
    // Pufferbereich zu klein ...
    endif;
  endif;

endsr;

//============================================================*
//    A_to_Int      alpha ==> interne Darstellung             *
//============================================================*

begsr a_to_intern;

  if (f_isVarLen(fldl0100) = bTrue);
    strPos = 3;
  else;
    strPos = 1;
  endif;

  o_buffLen = f_buffLn(fldl0100);

  select;
  //  kleinester Wert ...
  when (r_tgtValue = '*LOVAL');
    %subst(o_buffer: strPos: o_buffLen)
      = *allx'00';
  //  größter Wert ...
  when (r_tgtValue = '*HIVAL');
    %subst(o_buffer: strPos: o_buffLen)
      = *allx'FF';
  //  aktueller Wert ...
  when (r_tgtValue = '*CURRENT');
    if (f_hasCcsid(fldl0100) = bTrue);
      if (fldl0100.f1ndbc > 0);
        o_buffLen = fldl0100.f1ndbc;
      endif;
      o_buffLen =
       cvtToFileCcsid(i_buffer: o_buffLen: fldl0100.f1fdcc);
    endif;
    %subst(o_buffer: strPos: o_buffLen)
      = %subst(i_buffer: 1: o_buffLen);
  other;
  endsl;

  //  Immer genau so lang wie das Feld, sonst verschieben sich die
  //  folgenden Schlüsselfelder: UTF-8 wird länger ('Ä' braucht 2 Bytes)
  //  und wird abgeschnitten, ein kürzerer Wert behält die Leerzeichen
  //  aus o_buffer.
  o_buffLen = f_buffLn(fldl0100);

  //  einfügen Längenangabe bei Feldern variabler Länge                                   R
  if (f_isVarLen(fldl0100) = bTrue);
    p_decToBin(o_buffer: 1: 2: o_buffLen);
  endif;

endsr;

//============================================================*
//    G_to_Int      graphic => interne Darstellung            *
//============================================================*

begsr g_to_intern;

  if (f_isVarLen(fldl0100) = bTrue);
    strPos = 3;
  else;
    strPos = 1;
  endif;

  o_buffLen = f_buffLn(fldl0100);

  select;
  //  kleinester Wert ...
  when (r_tgtValue = '*LOVAL');
    %subst(o_buffer: strPos: o_buffLen)
      = *allx'00';
  //  größter Wert ...
  when (r_tgtValue = '*HIVAL');
    %subst(o_buffer: strPos: o_buffLen)
      = *allx'FF';
  //  aktueller Wert ...
  when (r_tgtValue = '*CURRENT');
    if (f_hasCcsid(fldl0100) = bTrue);
      if (fldl0100.f1ndbc > 0);
        o_buffLen = fldl0100.f1ndbc;
      endif;
      o_buffLen =
       cvtToFileCcsid(
         i_buffer: o_buffLen: fldl0100.f1fdcc);
    endif;
    %subst(o_buffer: strPos: o_buffLen)
      = %subst(i_buffer: 1: o_buffLen);
  other;
  endsl;

  //  Immer genau so lang wie das Feld (siehe a_to_intern), z.B. wenn
  //  die CCSID nicht umsetzbar ist (GRAPHIC 835)
  o_buffLen = f_buffLn(fldl0100);

  //  einfügen Längenangabe bei Feldern variabler Länge
  if (f_isVarLen(fldl0100) = bTrue);
    p_decToBin(o_buffer: 1: 2: o_buffLen);
  endif;

endsr;

//============================================================*
//    S_to_Int      Zoned ==> interne Darstellung             *
//============================================================*

begsr s_to_intern;

  //  umsetzen in gezonten Wert ...
  exsr cvtToZoned;

  //  umsetzen gezont -> gezont ...
  zoned = zoned;

  //  extrahieren gezonten Wert ...
  o_buffLen = f_buffLn(fldl0100);
  x = %len(zoned_a) - o_buffLen + 1;
  o_buffer = %subst(zoned_a: x: o_buffLen);

endsr;

//============================================================*
//    B_to_Int      Binary ==> interne Darstellung            *
//============================================================*

begsr b_to_intern;

  select;
  when (f_buffLn(fldl0100) = 1);
    exsr b_to_intern_1;
  when (f_buffLn(fldl0100) = 2);
    exsr b_to_intern_2;
  when (f_buffLn(fldl0100) = 4);
    exsr b_to_intern_4;
  when (f_buffLn(fldl0100) = 8);
    exsr b_to_intern_8;
  other;
    p_kill('Illegal buffer length: ' +
          %char(f_buffLn(fldl0100)));
  endsl;

endsr;

//============================================================*
//    B_to_Int1     Binary ==> interne Darstellung 1-Byte     *
//============================================================*

begsr b_to_intern_1;

  select;
  when (r_tgtValue = '*LOVAL');
    binary1 = *loval;
  when (r_tgtValue = '*HIVAL');
    binary1 = *hival;
  when (r_tgtValue = '*CURRENT');
    //  ... umsetzen in gezonten Wert
    exsr cvtToZoned;
    binary1 = zoned;
  other;
  endsl;

  //  extrahieren Binärwert ...
  o_buffLen = f_buffLn(fldl0100);
  o_buffer = %subst(binary1_a: 1: o_buffLen);

endsr;

//============================================================*
//    B_to_Int2     Binary ==> interne Darstellung 2-Byte     *
//============================================================*

begsr b_to_intern_2;

  select;
  when (r_tgtValue = '*LOVAL');
    binary2 = *loval;
  when (r_tgtValue = '*HIVAL');
    binary2 = *hival;
  when (r_tgtValue = '*CURRENT');
    //  ... umsetzen in gezonten Wert
    exsr cvtToZoned;
    binary2 = zoned;
  other;
  endsl;

  //  extrahieren Binärwert ...
  o_buffLen = f_buffLn(fldl0100);
  o_buffer = %subst(binary2_a: 1: o_buffLen);

endsr;

//============================================================*
//    B_to_Int4     Binary ==> interne Darstellung 4-Byte     *
//============================================================*

begsr b_to_intern_4;

  select;
  when (r_tgtValue = '*LOVAL');
    binary4 = *loval;
  when (r_tgtValue = '*HIVAL');
    binary4 = *hival;
  when (r_tgtValue = '*CURRENT');
    //  ... umsetzen in gezonten Wert
    exsr cvtToZoned;
    binary4 = zoned;
  other;
  endsl;

  //  extrahieren Binärwert ...
  o_buffLen = f_buffLn(fldl0100);
  o_buffer = %subst(binary4_a: 1: o_buffLen);

endsr;

//============================================================*
//    B_to_Int8     Binary ==> interne Darstellung 8-Byte     *
//============================================================*

begsr b_to_intern_8;

  select;
  when (r_tgtValue = '*LOVAL');
    binary8 = *loval;
  when (r_tgtValue = '*HIVAL');
    binary8 = *hival;
  when (r_tgtValue = '*CURRENT');
    //  ... umsetzen in gezonten Wert
    exsr cvtToZoned;
    binary8 = zoned;
  other;
  endsl;

  //  extrahieren Binärwert ...
  o_buffLen = f_buffLn(fldl0100);
  o_buffer = %subst(binary8_a: 1: o_buffLen);

endsr;

//============================================================*
//    P_to_Int      Packed ==> interne Darstellung            *
//============================================================*

begsr p_to_intern;

  //  umsetzen in gezonten Wert ...
  exsr cvtToZoned;

  //  umsetzen gezont -> gepacked ...
  packed = zoned;

  //  extrahieren Binärwert ...
  x = %len(packed_a) - f_buffLn(fldl0100) + 1;

  o_buffLen = f_buffLn(fldl0100);
  o_buffer = %subst(packed_a: x: o_buffLen);

endsr;

//============================================================*
//    F_to_Int      Float  ==> interne Darstellung            *
//============================================================*

begsr f_to_intern;

  exsr cvtToFloat;

  o_buffLen = f_buffLn(fldl0100);
  o_buffer = dsFloat;

endsr;

//============================================================*
//    L_to_Int      Datum ==> interne Darstellung             *
//============================================================*

begsr l_to_intern;

  select;
  //  kleinester Wert ...
  when (r_tgtValue = '*LOVAL');
    r_dateISO = *loval;
    exsr dateToBuffer;
  //  größter Wert ...
  when (r_tgtValue = '*HIVAL');
    r_dateISO = *hival;
    exsr dateToBuffer;
  //  aktueller Wert ...
  when (r_tgtValue = '*CURRENT');
    o_buffer = i_buffer;
  other;
  endsl;

  o_buffLen = f_buffLn(fldl0100);
  o_buffer = %subst(o_buffer:1:o_buffLen);

  //  Wert überprüfen über PEEK36 ...
  exsr chkValue;

endsr;

//============================================================*
//    dateToBuffer  Übertragen und konvertieren Datumsfeld    *
//                  nach Ausgabepuffer.                       *
//============================================================*

begsr dateToBuffer;

  //  Übertragen Datum gemäß Format und Trennzeichen des Feldes
  //  (alle Formate, bisher nur *EUR und *ISO; QCOPYLE,DATTIMFMT)
  o_buffer = f_extDate(fldl0100: r_dateISO);

endsr;

//============================================================*
//    T_to_Int      Zeit  ==> interne Darstellung             *
//============================================================*

begsr t_to_intern;

  select;
  //  kleinester Wert ...
  when (r_tgtValue = '*LOVAL');
    r_timeISO = *loval;
    exsr timeToBuffer;
  //  größter Wert ...
  when (r_tgtValue = '*HIVAL');
    r_timeISO = *hival;
    exsr timeToBuffer;
  //  aktueller Wert ...
  when (r_tgtValue = '*CURRENT');
    o_buffer = i_buffer;
  other;
  endsl;

  o_buffLen = f_buffLn(fldl0100);
  o_buffer = %subst(o_buffer:1:o_buffLen);

  //  Wert überprüfen über PEEK36 ...
  exsr chkValue;

endsr;

//============================================================*
//    timeToBuffer  Übertragen und konvertieren Zeitfeld      *
//                  nach Ausgabepuffer.                       *
//============================================================*

begsr timeToBuffer;

  //  Übertragen Zeit gemäß Format und Trennzeichen des Feldes
  //  (alle Formate, bisher ohne *USA und *JIS; QCOPYLE,DATTIMFMT)
  o_buffer = f_extTime(fldl0100: r_timeISO);

endsr;

//============================================================*
//    Z_to_Int      Zeitstempel=> interne Darstellung         *
//============================================================*

begsr z_to_intern;

  select;
  //  kleinester Wert ...
  when (r_tgtValue = '*LOVAL');
    r_timeStmp = *loval;
    o_buffer = %char(r_timeStmp: *iso);
  //  größter Wert ...
  when (r_tgtValue = '*HIVAL');
    r_timeStmp = *hival;
    o_buffer = %char(r_timeStmp: *iso);
  //  aktueller Wert ...
  when (r_tgtValue = '*CURRENT');
    o_buffer = i_buffer;
  other;
  endsl;

  o_buffLen = f_buffLn(fldl0100);
  o_buffer = %subst(o_buffer:1:o_buffLen);

  //  Wert überprüfen über PEEK36 ...
  exsr chkValue;

endsr;

//============================================================*
//    chkValue      Prüfen Wert im Zeit-, Datums-,            *
//                  oder Zeitstempelfeld                      *
//============================================================*

begsr chkValue;

  peek36(o_buffer
         : fldl0100.f1DTyp
         : fldl0100.f1dtfm
         : fldl0100.f1dtsp
         : yMsgID: yMsgDta);
  if (yMsgID = '');
  //   Alles in Ordnung ...
  else;
    //  USR8242: Ungültiger Datums-, Zeit- oder Zeitstempelwert im
    //  Feld &1
    o_msgID = yMsgID;
    o_msgDta = fldl0100.f1FNme;
    leavesr;
  endif;

endsr;

//============================================================*
//    CvtToZoned                                              *
//============================================================*

begsr cvtToZoned;

  zoned = *zeros;

  select;
  //  kleinester Wert ...
  when (r_tgtValue = '*LOVAL');
    zoned = *loval;
  //  größter Wert ...
  when (r_tgtValue = '*HIVAL');
    zoned = *hival;
  //  aktueller Wert ...
  when (r_tgtValue = '*CURRENT');

    //  ... Vorzeichen
    if (set0003.set_signX = bFalse);
    // ohne Vorzeichen
    else;
      // mit Vorzeichen
      // ... Vorzeichen extrahieren
      x = fldl0100.f1Digt + 1;
      if (x <= RCD_BUFF_LEN);
        a1 = %subst(i_buffer: x: 1);
      else;
        a1 = *blanks;
      endif;
      // ... auf definiertes Minus-Zeichen prüfen
      if (a1 = SET_SIGN_MINUS);
        isMinus = bTrue;
      else;
        isMinus = bFalse;
      endif;
    endif;

    //  ... Wert
    x = %len(zoned_a) - fldl0100.f1Digt + 1;
    %subst(zoned_a: x) =
      %subst(i_buffer: 1: fldl0100.f1Digt);
    zoned_a = %xlate(' ':'0' : zoned_a);

    //  ... gültige numerische Daten prüfen
    if (%check(NUMERIC_DIGITS: zoned_a) > 0);
      o_msgID = 'USR8138';
      usr8138.var1 = fldl0100.f1FNme;
      o_msgDta = usr8138;
      leavesr;
    else;
    // Alles klar
    endif;

    //  ... negativer Wert
    if (isMinus = bTrue);
      zoned = zoned * -1;
    else;
    // positiver Wert
    endif;

  other;
  endsl;

endsr;

//============================================================*
//    CvtToFloat                                              *
//============================================================*

begsr cvtToFloat;

  float = *zeros;

  select;
  //  kleinester Wert ...
  when (r_tgtValue = '*LOVAL');
    if (f_buffLn(fldl0100) = 4);
      dsFloat.float4 = *loval;
    else;
      dsFloat.float8 = *loval;
    endif;
  //  größter Wert ...
  when (r_tgtValue = '*HIVAL');
    if (f_buffLn(fldl0100) = 4);
      dsFloat.float4 = *hival;
    else;
      dsFloat.float8 = *hival;
    endif;
  //  aktueller Wert ...
  when (r_tgtValue = '*CURRENT');
    if (f_buffLn(fldl0100) = 4);
      x = 14;
    else;
      x = 23;
    endif;

    //  ... Vorzeichen
    if (set0003.set_signX = bFalse);
    // ohne Vorzeichen
    else;
      // mit Vorzeichen
      // ... Vorzeichen extrahieren
      if (x <= RCD_BUFF_LEN);
        a1 = %subst(i_buffer: x: 1);
      else;
        a1 = *blanks;
      endif;
      // ... auf definiertes Minus-Zeichen prüfen
      if (a1 = SET_SIGN_MINUS);
        isMinus = bTrue;
      else;
        isMinus = bFalse;
      endif;
    endif;

    //  ... gültige numerische Daten prüfen
    if (f_vldFloat(%subst(i_buffer: 1: x-1)) = bFalse);
      o_msgID = 'USR8138';
      usr8138.var1 = fldl0100.f1FNme;
      o_msgDta = usr8138;
      leavesr;
    else;
    // Alles klar
    endif;

    //  ... Wert
    float = %float(%subst(i_buffer: 1: x-1));

    //  ... negativer Wert
    if (isMinus = bTrue);
      float = float * -1;
    else;
    // positiver Wert
    endif;

    if (f_buffLn(fldl0100) = 4);
      dsFloat.float4 = float;
    else;
      dsFloat.float8 = float;
    endif;

  other;
  endsl;

endsr;

//============================================================*
//    GetZoned      Umsetzen ZONED to ZONED                   *
//============================================================*

begsr getZoned;

  zoned = 0;

  x = %len(zoned_a) - f_buffLn(fldl0100) + 1;

  %subst(zoned_a: x) =
    %subst(i_buffer: 1: f_buffLn(fldl0100));

  zoned = zoned;

endsr;

//============================================================*
//    GetBinary     Umsetzen BINARY to ZONED                  *
//============================================================*

begsr getBinary;

  select;
  when (f_buffLn(fldl0100) = 1);
    exsr getBinary_1;
  when (f_buffLn(fldl0100) = 2);
    exsr getBinary_2;
  when (f_buffLn(fldl0100) = 4);
    exsr getBinary_4;
  when (f_buffLn(fldl0100) = 8);
    exsr getBinary_8;
  other;
    p_kill('Illegal buffer length: ' +
          %char(f_buffLn(fldl0100)));
  endsl;

endsr;

//============================================================*
//    GetBinary1    Umsetzen BINARY to ZONED    1-Byte        *
//============================================================*

begsr getBinary_1;

  binary1 = 0;

  binary1_a =
    %subst(i_buffer: 1: f_buffLn(fldl0100));

  zoned = binary1;

endsr;

//============================================================*
//    GetBinary2    Umsetzen BINARY to ZONED    2-Byte        *
//============================================================*

begsr getBinary_2;

  binary2 = 0;

  binary2_a =
    %subst(i_buffer: 1: f_buffLn(fldl0100));

  zoned = binary2;

endsr;

//============================================================*
//    GetBinary4    Umsetzen BINARY to ZONED    4-Byte        *
//============================================================*

begsr getBinary_4;

  binary4 = 0;

  binary4_a =
    %subst(i_buffer: 1: f_buffLn(fldl0100));

  zoned = binary4;

endsr;

//============================================================*
//    GetBinary8    Umsetzen BINARY to ZONED    8-Byte        *
//============================================================*

begsr getBinary_8;

  binary8 = 0;

  binary8_a =
    %subst(i_buffer: 1: f_buffLn(fldl0100));

  zoned = binary8;

endsr;

//============================================================*
//    GetPacked     Umsetzen PACKED to ZONED                  *
//============================================================*

begsr getPacked;

  packed = 0;

  x = %len(packed_a) - f_buffLn(fldl0100) + 1;

  %subst(packed_a: x) =
    %subst(i_buffer: 1: f_buffLn(fldl0100));

  zoned = packed;

endsr;

//============================================================*
//    getUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getUsrSetg;

  //  *ACCESSKEY
  set0003 = f_getUsrSg('*ACCESSKEY');

  if (set0003.set_signP = '');
    SET_SIGN_PLUS = '';
  else;
    SET_SIGN_PLUS = set0003.set_signP;
  endif;

  if (set0003.set_signM = '');
    SET_SIGN_MINUS = '-';
  else;
    SET_SIGN_MINUS = set0003.set_signM;
  endif;

endsr;

//============================================================*
//    GetKeyType    Ermitteln, ob Schlüsselfeld und ob        *
//                  Descending oder Ascending                 *
//============================================================*

begsr getKeyType;

  clear f_key;
  f_key.f_field = fldl0100.f1FNme;
  chain %kds(f_key) fpeekfld;
  if (not %found());
    clear fpeekfld;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  o_msgID = '';
  o_msgDta = '';

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  peek36_name = f_pgmCallN('PEEK36');

  open peekFld;

endsr;

//============================================================*
//    Converts a given buffer intot he Job ccsid.             *
//============================================================*
dcl-proc cvtToJobCcsid;
  dcl-pi *n int(10);
    io_buffer like(rcdBuf_t);
    i_length  int(10) value;
    i_ccsid   int(10) value;
  end-pi;

  dcl-s tLength int(10);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  //  Nicht umsetzbare CCSID (z.B. GRAPHIC 835): Puffer unverändert
  //  lassen statt abzubrechen (PEEK71 sendet CPF9897)
  monitor;
    hTranscoder = transcoder_toJobCcsid(i_ccsid);
    tLength =
      transcoder_xlateBuffer(hTranscoder
                             : %addr(io_buffer)
                             : i_length
                             :%size(io_buffer));
  on-error;
    return i_length;
  endmon;
  if (i_length > tLength);
    %subst(io_buffer
          : tLength+1
          : i_length-tLength) = '';
  endif;

  return tLength;

end-proc;

//============================================================*
//    Converts a given buffer into the File ccsid.            *
//============================================================*
dcl-proc cvtToFileCcsid;
  dcl-pi *n int(10);
    io_buffer like(rcdBuf_t);
    i_length  int(10) value;
    i_ccsid   int(10) value;
  end-pi;

  dcl-s tLength int(10);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  //  Nicht umsetzbare CCSID: Puffer unverändert lassen
  monitor;
    hTranscoder =
      transcoder_toFieldCcsid(i_ccsid);
    tLength =
      transcoder_xlateBuffer(hTranscoder
                             : %addr(io_buffer)
                             : i_length
                             :%size(io_buffer));
  on-error;
    return i_length;
  endmon;
  if (i_length > tLength);
    %subst(io_buffer
          : tLength+1
          : i_length-tLength) = *allx'00';
  endif;

  return tLength;

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
  o_action = cee_percolate;

end-proc;

//============================================================*
//  Datum und Zeit im Format des Feldes (f_extDate, f_extTime)*
//============================================================*
/copy QCOPYLE,DATTIMFMT

