**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK20                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 27.10.97    Raddatz                               *
//  geändert : 27.04.99    2.1.0                                 *
//  geändert : 01.04.2004  2.2.2   Fixed problem that ybuffer    *
//                                 was not cleared correclty     *
//                                 for data/time/timestamp       *
//                                 fields.                       *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Erstellen internen Aufsetzschlüssel                          *
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

dcl-f peekfldl2 keyed usropn rename(fpeekfld: fpeekfldl2) prefix(f2) infds(Peek_L2_DS);

dcl-f peekfldl0 keyed usropn rename(fpeekfld: fpeekfldl0) prefix(f2) infds(Peek_L0_DS);

dcl-ds Peek_L0_DS likeds(infds_t);
dcl-ds Peek_L2_DS likeds(infds_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,CEECNDHDLR
/copy QCOPYLE,SDS

/define internal_prototype
/copy QCOPYLE,PPEEK20
/undefine internal_prototype

/copy QCOPYLE,SET0003

/copy QCOPYLE,PPEEK18
/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

//----------------------------------------------------*
//  F E L D - D E F I N I T I O N E N                 *
//----------------------------------------------------*

dcl-ds yIO_Buff;
  yIO_BuffTb char(1) dim(RCD_BUFF_LEN) inz;
end-ds;

dcl-s YBuffer like(rcdBuf_t) inz;
dcl-s YTgtValue char(10) inz(*blanks);
dcl-s YOutBuffer like(rcdBuf_t) inz;
dcl-s YOutBuffLn like(int4_t) inz;
dcl-s YMsgID char(7) inz(*blanks);
dcl-s YMsgDta char(512) inz(*blanks);

dcl-s x like(int4_t) inz;
dcl-s y like(int4_t) inz;
dcl-s inpKeyLen int(10) inz(-1);

dcl-s bp like(int4_t) inz;
dcl-s kp like(int4_t) inz;

dcl-s peek18_name like(pgmCallN_t) inz;

dcl-s Wrk_KeyVal like(i_keyVal) inz(*blanks);

dcl-s DftVal char(30) inz(*blanks);
dcl-s DftValLen like(int4_t) inz;
dcl-s idx like(int4_t) inz;

dcl-c TIMESTMP_A '0001-01-01-00.00.00.000000';
dcl-c TIMESTAMP_D '9999-12-31-23.59.59.999999';

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-ds set0003 likeds(SET0003_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek20;
  i_keyVal    like(keyBuf_t) const;
  o_rcdBuffer like(rcdBuf_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-ds f2key_l2 likerec(fpeekfldl2: *key);
dcl-ds f1key_l0 likerec(fpeekfldl0: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr First;

yIO_BuffTb(*) = '';
bp = 1;
kp = 1;

select;
when (i_keyVal = '*PHIVAL');
  Wrk_KeyVal = '*HIVAL';
  exsr buildPseudoKey;

when (i_keyVal = '*PLOVAL');
  Wrk_KeyVal = '*LOVAL';
  exsr buildPseudoKey;

when (i_keyVal = '*HIVAL');
  Wrk_KeyVal = '*HIVAL';
  exsr buildKey;

when (i_keyVal = '*LOVAL');
  Wrk_KeyVal = '*LOVAL';
  exsr buildKey;

other;
  inpKeyLen = %len(%trimr(i_keyVal));
  Wrk_KeyVal = i_keyVal;
  exsr buildKey;

endsl;

if (o_msgID = '');
  o_rcdBuffer = yIO_Buff;
endif;

return;

//============================================================*
//    BuildKey      Erstellen internen Aufsetzschlüssel       *
//============================================================*

begsr buildKey;

  clear f2key_l2;
  f2key_l2.f2kseq = 1;
  setll %kds(f2key_l2) fpeekfldl2;

  dow ('1');
    read fpeekfldl2;
    if (%eof());
      leave;
    endif;

    exsr Intern;
    if (o_msgID <> '');
      leavesr;
    endif;

    if (bp > RCD_BUFF_LEN);
      leave;
    endif;

    if (inpKeyLen > 0 and kp > inpKeyLen);
      Wrk_KeyVal = '*LOVAL';
      inpKeyLen = -1;
    endif;

  enddo;

endsr;

//============================================================*
//    BuildPseud    Erstellen internes Satzformat             *
//============================================================*

begsr buildPseudoKey;

  clear f1key_l0;
  f1key_l0.f2fldseq = *zeros;
  setll %kds(f1key_l0) fpeekfldl0;

  dow ('1');
    read fpeekfldl0;
    if (%eof());
      leave;
    endif;

    exsr Intern;
    if (o_msgID <> '');
      leavesr;
    endif;

    if (bp > RCD_BUFF_LEN);
      leave;
    endif;
  enddo;

endsr;

//============================================================*
//    Intern        Formataufbereitung                        *
//============================================================*

begsr Intern;

  fldl0100 = f2ffd;

  if (Wrk_KeyVal = '*LOVAL' or Wrk_KeyVal = '*HIVAL');
    YTgtValue = Wrk_KeyVal;
    clear YBuffer;
  else;
    YTgtValue = '*CURRENT';

    select;
    when (fldl0100.F1DTyp = 'S' or  // Zoned
    fldl0100.F1DTyp = 'B' or    // Binary
    fldl0100.F1DTyp = 'P');      // Packed
      y = fldl0100.f1digt;
    when (fldl0100.F1DTyp = 'F');    // Float
      if (fldl0100.f1flen = 4);
        y = 14;
      else;
        y = 23;
      endif;
    other;
      if (fldl0100.F1DTyp = 'G');
        y = fldl0100.f1ndbc;
      else;
        y = fldl0100.f1flen;
      endif;
    endsl;

    //  ... Länge +1 wegen nachgestelltem Vorzeichen
    //      grundsätzlich, ob mit oder ohne Vorzeichen
    //      Vorzeichen wird in PEEK18 ausgewertet
    if (f_isNumFld(fldl0100) = bTrue);
      y = y + 1;
    endif;

    x = kp + y;
    x = x - 1;
    if (f_isVarLen(fldl0100) = bTrue);
      x = x + 2;
      y = y - 2;
    endif;

    if (x <= KEY_BUFF_LEN);
      YBuffer = %subst(Wrk_KeyVal:kp:y);
    else;
      YBuffer = %subst(Wrk_KeyVal:kp);
    endif;

  endif;

  // ... Aufbereiten Datums-, Zeit- und
  //     Zeitstempelfelder
  select;
  // ... Time (im Format des Feldes, QCOPYLE,DATTIMFMT)
  when (fldl0100.F1DTyp = 'T');
    if (F2Desc = 'D');
      DftVal = f_extTime(fldl0100: T'23.59.59');
    else;
      DftVal = f_extTime(fldl0100: T'00.00.00');
    endif;
    DftValLen = %len(%trimr(DftVal));
    exsr ChkValue;
  // ... Date (im Format des Feldes, QCOPYLE,DATTIMFMT)
  when (fldl0100.F1DTyp = 'L');
    if (F2Desc = 'D');
      DftVal = f_extDate(fldl0100: D'9999-12-31');
    else;
      DftVal = f_extDate(fldl0100: D'0001-01-01');
    endif;
    DftValLen = %len(%trimr(DftVal));
    exsr ChkValue;
  // ... Timestamp
  when (fldl0100.F1DTyp = 'Z');
    if (F2Desc = 'D');
      DftVal = TIMESTAMP_D;
      DftValLen = %len(TIMESTAMP_D);
    else;
      DftVal = TIMESTMP_A;
      DftValLen = %len(TIMESTMP_A);
    endif;
    exsr ChkValue;
  // ... alle anderen Datentypen
  other;
  // werden nicht vorgeprüft
  // und vervollständigt
  endsl;

  peek18(fldl0100: F2Format: YBuffer
  : '*INTERN': YTgtValue
  : YOutBuffer: YOutBuffLn
  : YMsgID: YMsgDta);
  if (YMsgID <> '');
    o_msgID = YMsgID;
    o_msgDta = YMsgDta;
    leavesr;
  endif;

  if (f_isVarLen(fldl0100) = bTrue);
    YOutBuffLn = YOutBuffLn + 2;
  endif;

  for y = 1 to YOutBuffLn;
    yIO_BuffTb(bp) = %subst(YOutBuffer:y:1);
    bp = bp + 1;
    if (bp > RCD_BUFF_LEN);
      leave;
    endif;
  endfor;

  if (bp > RCD_BUFF_LEN);
  // Puffer zu Ende
  else;
    //  Neue Startposition in Wrk_KeyVal
    if ((f_isNumFld(fldl0100) = bTrue) and
    (f_isFloatFld(fldl0100) = bFalse));
      // ... bei numerischen Werten
      kp = kp + fldl0100.f1digt;
      // ... wegen nachgestelltem Vorzeichen
      if (set0003.SET_SignX <> bFalse);
        kp = kp + 1;
      else;
      // keine Korrektur erforderlich
      endif;
    elseif (f_isFloatFld(fldl0100) = bTrue);
      // ... bei Gleitkommawerten: %editflt ohne führendes
      //     Vorzeichen (PEEK18 F_to_extern), nicht f1flen
      if (fldl0100.f1flen = 4);
        kp = kp + 13;
      else;
        kp = kp + 22;
      endif;
      if (set0003.SET_SignX <> bFalse);
        kp = kp + 1;
      endif;
    else;
      // ... bei alpha-numerischen Werten
      if (fldl0100.F1DTyp = 'G');
        kp = kp + fldl0100.f1ndbc;
      else;
        kp = kp + fldl0100.f1flen;
      endif;
    endif;
    if (f_isVarLen(fldl0100) = bTrue);
      kp = kp - 2;
    endif;
  endif;

  // Delimeter ...
  if (set0003.SET_Dlmtr <> '');
    kp = kp + 1;
  else;
  // keine Korrektur erforderlich
  endif;

endsr;

//============================================================*
//    ChkValue      Prüfen und vervollständigen Datums-,      *
//                  Zeit- und Zeitstempelfelder               *
//============================================================*

begsr ChkValue;

  for idx = 1 to DftValLen;

    if (%subst(YBuffer: idx: 1) = ' ');
      %subst(YBuffer: idx: 1) = %subst(DftVal: idx: 1);
    endif;

  endfor;

endsr;

//============================================================*
//    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr GetUsrSetg;

  //  *ACCESSKEY
  set0003 = f_getUsrSg('*ACCESSKEY');

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  o_rcdBuffer = '';
  o_msgID = '';
  o_msgDta = '';

  //  *ACCESSKEY bei jedem Aufruf lesen, damit eine Änderung sofort
  //  wirkt (wie in PEEK05 und PEEK18)
  exsr GetUsrSetg;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  peek18_name = f_pgmCallN('PEEK18');

  open peekfldl0;
  open peekfldl2;

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

//============================================================*
//  Datum und Zeit im Format des Feldes (f_extDate, f_extTime)*
//============================================================*
/copy QCOPYLE,DATTIMFMT

