**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Konvertieren intern ==> extern m. Edit       *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK06                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 26.09.97  RADDATZ                                 *
//                                                               *
//  geändert : 11.10.06  für Version 2.4.1                       *
//                       added support for  3I0 fields           *
//                       added support for 20I0 fields           *
//                                                               *
//             29.07.20  Anzeigen Float Sonderwerte 'NaN' und    *
//                       'Inf' eingebaut.                        *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Peek/400 - Konvertieren intern ==> extern m. Edit            *
//                                                               *
//===============================================================*
//                                                               *
//  INPUT-Parameter:                                             *
//  ================                                             *
//                                                               *
//  XData     - Data of FLDL0100                                 *
//  XFormat   - Format name                                      *
//  XSrcVar   - Source variable                                  *
//  XQcmdexc  - Convert numeric data for QCMDEXC                 *
//  XCvtCcsid - Convert string CCSID                             *
//                                                               *
//  OUTPUT-Parameter:                                            *
//  =================                                            *
//                                                               *
//  XString   - Output string                                    *
//  XStrLen   - Output string length                             *
//  XMsgID    - msgID                                            *
//  XMsgDta   - Msg data                                         *
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

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_mi.rpgleinc'
/copy 'qcopyle/qecedt.rpgleinc'
/copy 'qcopyle/qeccvtew.rpgleinc'
/copy 'qcopyle/qeccvtec.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek06.rpgleinc'
/undefine internal_prototype

//  declarations for Convert Edit Code: QECCVTEC
dcl-s editMask char(256) inz(*blanks);
dcl-s editMaskLn inz(*zeros) like(int4_t);
dcl-s rcvVarLen inz(*zeros) like(int4_t);
dcl-s zeroBalanc char(1) inz(*blanks);
dcl-s editCode char(1) inz(*blanks);
dcl-s currInd char(1) inz(*blanks);
dcl-s precision inz(*zeros) like(int4_t);
dcl-s binLength inz(*zeros) like(int4_t);
dcl-s decimal inz(*zeros) like(int4_t);

//  additional
//  declarations for Convert Edit Word: QECCVTEW
dcl-s editWord char(256) inz(*blanks);
dcl-s editWordLn inz(*zeros) like(int4_t);

//  additional
//  declarations for Edit: QECEDT
dcl-s cvtVar char(256) inz(*blanks);
dcl-s cvtVarLen inz(256) like(int4_t);
dcl-s srcVar inz(*blanks) like(i_srcVar);
dcl-s srcVarCls char(10) inz(*blanks);
dcl-s float4 float(4) based(pFloat);
dcl-s float8 float(8) based(pFloat);
dcl-s float4Buf char(4) based(pFloat);
dcl-s float8Buf char(8) based(pFloat);
dcl-s maxFloat4 packed(12: 4) inz(*hival);
dcl-s maxFloat8 packed(21: 4) inz(*hival);
dcl-s tmpfloat4 float(4) inz;
dcl-s tmpfloat8 float(8) inz;
dcl-s isExact ind inz;
dcl-s len int(10) inz;

dcl-s tempStrLen int(10) inz;

dcl-s hTranscoder like(hTranscoder_t) inz;

//  helper fields to convert 3I0 and 20I0 fields
dcl-ds zonedBuffer;
  zoned3  zoned(3) inz pos(1);
  zoned5  zoned(5) inz pos(1);
  zoned10 zoned(10) inz pos(1);
  zoned20 zoned(20) inz pos(1);
end-ds;

//  Sonderwerte: alle Bits des Exponenten gesetzt. Mantisse = 0: Inf,
//  sonst NaN, jeweils mit beliebigem Vorzeichen.
dcl-c fltmask_exp_4 x'7F800000';
dcl-c fltmask_man_4 x'007FFFFF';
dcl-c fltmask_exp_8 x'7FF0000000000000';
dcl-c fltmask_man_8 x'000FFFFFFFFFFFFF';
dcl-c fltmask_sign x'80';

dcl-c spcval_nan '*NaN';
dcl-c spcval_inf '*Inf';
dcl-c spcval_neginf '-*Inf';

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'
/copy 'qcopyle/ppeek71.rpgleinc'
//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************
dcl-pi peek06;
  i_fldl0100 likeds(fldl0100_t) const;
  i_rcdFmt   like(fmt_t) const;
  i_srcVar   like(rcdBuf_t) const;
  i_qcmdexc  like(bool_t) const;
  i_cvtCcsid like(bool_t) const;
  o_string   like(rcdBuf_t);
  o_strLen   like(int4_t);
  o_msgID    like(msgId_t);
  o_msgDta   like(msgDta_t);
end-pi;

dcl-ds fldl0100 likeds(fldl0100_t) inz;
dcl-ds errCode likeds(errCode_t) inz;
//---------------------------------------------------*

o_string = '';
o_strLen = 0;

monitor;

  select;
  when (i_rcdFmt = 'FLDL0100');
    exsr w_fldl0100;
  endsl;

on-error;
  o_string = '';
  o_strLen = 0;
endmon;

return;

//====================================================*
//  W_FLDL0100 -    Work with FLDL0100                *
//====================================================*

begsr w_fldl0100;

  fldl0100 = i_fldl0100;

  //  Erzwingen Edit Code, wenn die Aufbereitung für eine über
  //  QCMDEXC auszuführende Befehlszeile erfolgt.
  if ((i_qcmdexc = bTrue) and
      (f_isNumFld(fldl0100) = bTrue) and
      (f_isFloatFld(fldl0100) = bFalse));
    fldl0100.f1EdtC = 'P';
    fldl0100.f1EdWl = 0;
    fldl0100.f1EdWd = '';
  endif;

  editCode = fldl0100.f1EdtC;
  editWord = fldl0100.f1EdWd;
  currInd = '';
  editWordLn = fldl0100.f1EdWl;
  srcVarCls = fldl0100.f1DTyp;

  if (srcVarCls = 'B');

    select;
    when (f_buffLn(fldl0100) = 1);
      precision = 3;
      binLength = 1;
    when (f_buffLn(fldl0100) = 2);
      precision = 5;
      binLength = 2;
    when (f_buffLn(fldl0100) = 4);
      precision = 10;
      binLength = 4;
    other;
      precision = 20;
      binLength = 8;
    endsl;

  else;

    precision = fldl0100.f1Digt;
  endif;

  decimal = fldl0100.f1DecP;

  select;
  when (srcVarCls = 'F');
    len = f_rtvFld(srcVar: i_srcVar: fldl0100);
    pFloat = %addr(srcVar);
    //         Float 4
    if (len = 4);
      select;
      when (%bitand(float4Buf: fltmask_exp_4) = fltmask_exp_4);
        if (%bitand(float4Buf: fltmask_man_4) <> *allx'00');
          o_string = spcval_nan;
        elseif (%bitand(%subst(float4Buf: 1: 1): fltmask_sign)
                = fltmask_sign);
          o_string = spcval_neginf;
        else;
          o_string = spcval_inf;
        endif;
      other;
        //  Mit 4 Nachkommastellen nur, wenn dabei keine Ziffern
        //  verloren gehen (z.B. 1,2345E-5), sonst mit Exponent.
        maxFloat4 = *hival;
        isExact = *off;
        if (%abs(float4) <= maxFloat4);
          eval(h) maxFloat4 = float4;
          tmpfloat4 = maxFloat4;
          isExact = (tmpfloat4 = float4);
        endif;
        if (isExact);
          o_string = %editc(maxFloat4: 'P');
        else;
          o_string = %editflt(float4);
        endif;
      endsl;
      o_strLen = 14;
    else;
      //         Float 8
      select;
      when (%bitand(float8Buf: fltmask_exp_8) = fltmask_exp_8);
        if (%bitand(float8Buf: fltmask_man_8) <> *allx'00');
          o_string = spcval_nan;
        elseif (%bitand(%subst(float8Buf: 1: 1): fltmask_sign)
                = fltmask_sign);
          o_string = spcval_neginf;
        else;
          o_string = spcval_inf;
        endif;
      other;
        maxFloat8 = *hival;
        isExact = *off;
        if (%abs(float8) <= maxFloat8);
          eval(h) maxFloat8 = float8;
          tmpfloat8 = maxFloat8;
          isExact = (tmpfloat8 = float8);
        endif;
        if (isExact);
          o_string = %editc(maxFloat8: 'P');
        else;
          o_string = %editflt(float8);
        endif;
      endsl;
      o_strLen = 23;
    endif;

  when (srcVarCls = 'A' or srcVarCls = 'G');
    tempStrLen =
      f_rtvFld(o_string: i_srcVar: fldl0100);
    //  Do not convert if we prepare the *HEADLINE (see: PEEK05, yCvtCcsid)
    if (f_hasCcsid(fldl0100) = bTrue and
        i_cvtCcsid = bTrue);
      hTranscoder =
       Transcoder_toJobCcsid(fldl0100.f1fdcc);
      o_strLen =
        Transcoder_xlateBuffer(hTranscoder
                               : %addr(o_string)
                               : tempStrLen
                               : %size(o_string));
      if (tempStrLen > o_strLen);
        %subst(o_string: o_strLen+1
              : tempStrLen - o_strLen) = '';
      endif;
    else;
      if (fldl0100.f1ndbc > 0);
        o_strLen = fldl0100.f1ndbc;
      else;
        o_strLen = tempStrLen;
      endif;
    endif;

  when (srcVarCls = 'B');
    f_rtvFld(srcVar: i_srcVar: fldl0100);
    cpynv(f_num_descr(T_Zoned: precision: 0)
         : %addr(zonedBuffer)
         : f_num_descr(T_Signed: binLength: 0)
         : %addr(srcVar));
    srcVar = zonedBuffer;
    srcVarCls = 'S';
    exsr convert;
  when (srcVarCls = 'P');
    f_rtvFld(srcVar: i_srcVar: fldl0100);
    exsr convert;
  when (srcVarCls = 'S');
    f_rtvFld(srcVar: i_srcVar: fldl0100);
    exsr convert;
  other;
    o_strLen =
      f_rtvFld(o_string: i_srcVar: fldl0100);
  endsl;

endsr;

//====================================================*
//  Convert--  Convert to String                      *
//====================================================*

begsr convert;

  select;
  when (srcVarCls = 'B');
    srcVarCls = '*BINARY';
  when (srcVarCls = 'P');
    srcVarCls = '*PACKED';
  when (srcVarCls = 'S');
    srcVarCls = '*ZONED';
  endsl;

  if (editWord <> '');
    exsr cvtEdtWord;
    if (errCode.bytAvl = 0);
      exsr edit;
    endif;
  endif;

  //  Edit-Code, wenn kein Edit-Wort angegeben ist oder das Edit-Wort
  //  nicht zum Feld passt
  if (editWord = '' or errCode.bytAvl > 0);
    exsr cvtEdtCode;
    if (errCode.bytAvl = 0);
      exsr edit;
    endif;
  endif;

  //  Edit-Code passt nicht zum Feld (z.B. Y bei mehr als 9 Stellen):
  //  Standard-Edit-Code L
  if (errCode.bytAvl > 0 and editCode <> 'L');
    editCode = 'L';
    exsr cvtEdtCode;
    if (errCode.bytAvl = 0);
      exsr edit;
    endif;
  endif;

  if (errCode.bytAvl > 0);
    o_string = '';
    o_strLen = 0;
  endif;

endsr;

//====================================================*
//  Edit  --  Edit the value with the edit mask       *
//====================================================*

begsr edit;

  cvtVarLen = rcvVarLen;

  clear errCode;
  errCode.bytPrv = %size(errCode);

  qecedt(cvtVar
        : cvtVarLen
        : srcVar
        : srcVarCls
        : precision
        : editMask
        : editMaskLn
        : zeroBalanc
        : errCode);

  if (errCode.bytAvl = 0);
    o_string = %subst(cvtVar: 1: cvtVarLen);
    o_strLen = cvtVarLen;
  endif;

endsr;

//====================================================*
//  cvtEdtWord                                        *
//====================================================*

begsr cvtEdtWord;

  clear errCode;
  errCode.bytPrv = %size(errCode);

  clear editMask;
  clear editMaskLn;

  qeccvtew(editMask
          : editMaskLn
          : rcvVarLen
          : editWord
          : editWordLn
          : errCode);

endsr;

//====================================================*
//  cvtEdtCode                                        *
//====================================================*

begsr cvtEdtCode;

  select;
  // A-D
  when (editCode >= 'A' and editCode <= 'D');
  // J-Q
  when (editCode >= 'J' and editCode <= 'Q');
  // Y-Z
  when (editCode >= 'Y' and editCode <= 'Z');
  // 1-9
  when (editCode >= '1' and editCode <= '9');
  // X
  when (editCode = 'X');
    editCode = 'Z';
  other;
    editCode = 'L';
  endsl;

  clear errCode;
  errCode.bytPrv = %size(errCode);

  clear editMask;
  clear editMaskLn;

  qeccvtec(editMask
          : editMaskLn
          : rcvVarLen
          : zeroBalanc
          : editCode
          : currInd
          : precision
          : decimal
          : errCode);

endsr;

