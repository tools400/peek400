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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

dcl-f peekfldl2 keyed usropn rename(fpeekfld:fpeekfldl2) prefix(f2)
      infds(peek_l2_ds);

dcl-f peekfldl0 keyed usropn rename(fpeekfld:fpeekfldl0) prefix(f2)
      infds(peek_l0_ds);

dcl-ds peek_l0_ds likeds(infds_t);
dcl-ds peek_l2_ds likeds(infds_t);

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,D_INFDS
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,CEECNDHDLR
/COPY QCOPYLE,SDS

/define internal_prototype
/COPY QCOPYLE,PPEEK20
/undefine internal_prototype

/COPY QCOPYLE,SET0003

/COPY QCOPYLE,PPEEK18
/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

//----------------------------------------------------*
//  F E L D - D E F I N I T I O N E N                 *
//----------------------------------------------------*

  dcl-ds yio_buff;
yio_bufftb      char(1) dim(RCD_BUFF_LEN) inz;
end-ds;

dcl-s ybuffer         like(rcdbuf_t) inz;
dcl-s ytgtvalue       char(10) inz(*blanks);
dcl-s youtbuffer      like(rcdbuf_t) inz;
dcl-s youtbuffln      like(int4_t) inz;
dcl-s yMsgID          char(7) inz(*blanks);
dcl-s yMsgDta         char(512) inz(*blanks);

dcl-s x               like(int4_t) inz;
dcl-s y               like(int4_t) inz;
dcl-s inpkeylen       int(10) inz(-1);

dcl-s bp              like(int4_t) inz;
dcl-s kp              like(int4_t) inz;

dcl-s peek18_name     like(pgmcalln_t) inz;

dcl-s wrk_keyval      like(i_keyval) inz(*blanks);

dcl-s dftval          char(30) inz(*blanks);
dcl-s dftvallen       like(int4_t) inz;
dcl-s idx             like(int4_t) inz;

dcl-c TIMESTMP_A  '0001-01-01-00.00.00.000000';
dcl-c TIMESTAMP_D  '9999-12-31-23.59.59.999999';

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-ds set0003  likeds(set0003_t) inz;

dcl-s isInzSr   like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

  dcl-pi peek20;
  i_keyval        const like(keybuf_t);
  o_rcdbuffer     like(rcdbuf_t);
  o_msgid         like(msgid_t);
o_msgdta        like(msgdta_t);
end-pi;

dcl-ds f2key_l2 likerec(fpeekfldl2: *key);
dcl-ds f1key_l0 likerec(fpeekfldl0: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

yio_bufftb(*) = '';
bp = 1;
kp = 1;

select;
when (i_keyval = '*PHIVAL');
  wrk_keyval = '*HIVAL';
  exsr buildPseudoKey;

  when (i_keyval = '*PLOVAL');
  wrk_keyval = '*LOVAL';
exsr buildPseudoKey;

  when (i_keyval = '*HIVAL');
  wrk_keyval = '*HIVAL';
exsr buildKey;

  when (i_keyval = '*LOVAL');
  wrk_keyval = '*LOVAL';
exsr buildKey;

  other;
  inpkeylen = %len(%trimr(i_keyval));
  wrk_keyval = i_keyval;
exsr buildKey;

endsl;

  if (o_msgid = '');
o_rcdbuffer = yio_buff;
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

    exsr intern;
      if (o_msgid <> '');
    leavesr;
    endif;

      if (bp > RCD_BUFF_LEN);
    leave;
    endif;

      if (inpkeylen > 0 and kp > inpkeylen);
      wrk_keyval = '*LOVAL';
    inpkeylen = -1;
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

    exsr intern;
      if (o_msgid <> '');
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

  begsr intern;

  fldl0100 = f2ffd;

    if (wrk_keyval = '*LOVAL' or wrk_keyval = '*HIVAL');
    ytgtvalue = wrk_keyval;
  clear ybuffer;
    else;
    ytgtvalue = '*CURRENT';

    select;
      when fldl0100.f1dtyp = 'S' or  // Zoned
      fldl0100.f1dtyp = 'B' or    // Binary
      fldl0100.f1dtyp = 'P';      // Packed
    y = fldl0100.f1digt;
      when (fldl0100.f1dtyp = 'F');    // Float
        if (fldl0100.f1flen = 4);
      y = 14;
        else;
      y = 23;
    endif;
      other;
        if (fldl0100.f1dtyp = 'G');
      y = fldl0100.f1ndbc;
        else;
      y = fldl0100.f1flen;
    endif;
    endsl;

    //  ... Länge +1 wegen nachgestelltem Vorzeichen
    //      grundsätzlich, ob mit oder ohne Vorzeichen
    //      Vorzeichen wird in PEEK18 ausgewertet
      if (f_isnumfld(fldl0100) = bTrue);
    y = y + 1;
    endif;

    x = kp + y;
    x = x - 1;
      if (f_isvarlen(fldl0100) = bTrue);
      x = x + 2;
    y = y - 2;
    endif;

      if (x <= KEY_BUFF_LEN);
    ybuffer = %subst(wrk_keyval:kp:y);
      else;
    ybuffer = %subst(wrk_keyval:kp);
  endif;

  endif;

  // ... Aufbereiten Datums-, Zeit- und
  //     Zeitstempelfelder
  select;
  // ... Time (im Format des Feldes, QCOPYLE,DATTIMFMT)
    when (fldl0100.f1dtyp = 'T');
      if (f2desc = 'D');
      dftval = f_extTime(fldl0100: T'23.59.59');
      else;
      dftval = f_extTime(fldl0100: T'00.00.00');
    endif;
    dftvallen = %len(%trimr(dftval));
  exsr chkvalue;
  // ... Date (im Format des Feldes, QCOPYLE,DATTIMFMT)
    when (fldl0100.f1dtyp = 'L');
      if (f2desc = 'D');
      dftval = f_extDate(fldl0100: D'9999-12-31');
      else;
      dftval = f_extDate(fldl0100: D'0001-01-01');
    endif;
    dftvallen = %len(%trimr(dftval));
  exsr chkvalue;
  // ... Timestamp
    when (fldl0100.f1dtyp = 'Z');
      if (f2desc = 'D');
      dftval = TIMESTAMP_D;
    dftvallen = %len(TIMESTAMP_D);
      else;
      dftval = TIMESTMP_A;
    dftvallen = %len(TIMESTMP_A);
    endif;
  exsr chkvalue;
  // ... alle anderen Datentypen
  other;
  // werden nicht vorgeprüft
  // und vervollständigt
  endsl;

  peek18(fldl0100: f2format: ybuffer
  : '*INTERN': ytgtvalue
  : youtbuffer: youtbuffln
  : yMsgID: yMsgDta);
    if (yMsgID <> '');
    o_msgid = yMsgID;
    o_msgdta = yMsgDta;
  leavesr;
  endif;

    if (f_isvarlen(fldl0100) = bTrue);
  youtbuffln = youtbuffln + 2;
  endif;

    for y = 1 to youtbuffln;
    yio_bufftb(bp) = %subst(youtbuffer:y:1);
    bp = bp + 1;
      if (bp > RCD_BUFF_LEN);
    leave;
  endif;
  endfor;

  if (bp > RCD_BUFF_LEN);
  // Puffer zu Ende
    else;
    //  Neue Startposition in Wrk_KeyVal
      if (f_isnumfld(fldl0100) = bTrue) and
      (f_isfloatfld(fldl0100) = bFalse);
      // ... bei numerischen Werten
      kp = kp + fldl0100.f1digt;
      // ... wegen nachgestelltem Vorzeichen
        if (set0003.set_signx <> bFalse);
      kp = kp + 1;
      else;
      // keine Korrektur erforderlich
    endif;
      elseif (f_isfloatfld(fldl0100) = bTrue);
      // ... bei Gleitkommawerten: %editflt ohne führendes
      //     Vorzeichen (PEEK18 F_to_extern), nicht f1flen
        if (fldl0100.f1flen = 4);
      kp = kp + 13;
        else;
      kp = kp + 22;
    endif;
        if (set0003.set_signx <> bFalse);
      kp = kp + 1;
    endif;
      else;
      // ... bei alpha-numerischen Werten
        if (fldl0100.f1dtyp = 'G');
      kp = kp + fldl0100.f1ndbc;
        else;
      kp = kp + fldl0100.f1flen;
    endif;
    endif;
      if (f_isvarlen(fldl0100) = bTrue);
    kp = kp - 2;
  endif;
  endif;

  // Delimeter ...
    if (set0003.set_dlmtr <> '');
  kp = kp + 1;
  else;
  // keine Korrektur erforderlich
endif;

endsr;

//============================================================*
//    ChkValue      Prüfen und vervollständigen Datums-,      *
//                  Zeit- und Zeitstempelfelder               *
//============================================================*

  begsr chkvalue;

    for idx = 1 to dftvallen;

      if (%subst(ybuffer: idx: 1) = ' ');
    %subst(ybuffer: idx: 1) = %subst(dftval: idx: 1);
  endif;

endfor;

endsr;

//============================================================*
//    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

  begsr getusrsetg;

  //  *ACCESSKEY
set0003 = f_getusrsg('*ACCESSKEY');

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

  begsr first;

  o_rcdbuffer = '';
  o_msgid = '';
o_msgdta = '';

  //  *ACCESSKEY bei jedem Aufruf lesen, damit eine Änderung sofort
  //  wirkt (wie in PEEK05 und PEEK18)
  exsr getusrsetg;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

  begsr inzsr;

    if (isInzSr = bTrue);
  leavesr;
  endif;

  isInzSr = bTrue;

  peek18_name = f_pgmcalln('PEEK18');

  open peekfldl0;
  open peekfldl2;

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

//============================================================*
//  Datum und Zeit im Format des Feldes (f_extDate, f_extTime)*
//============================================================*
/COPY QCOPYLE,DATTIMFMT

