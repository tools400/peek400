**free
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
//  XMsgID    - MsgID                                            *
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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_MI
/copy QCOPYLE,QECEDT
/copy QCOPYLE,QECCVTEW
/copy QCOPYLE,QECCVTEC

/define internal_prototype
/copy QCOPYLE,PPEEK06
/undefine internal_prototype

//  declarations for Convert Edit Code: QECCVTEC
dcl-s EditMask char(256) inz(*blanks);
dcl-s EditMaskLn inz(*zeros) like(int4_t);
dcl-s rcvVarLen inz(*zeros) like(int4_t);
dcl-s ZeroBalanc char(1) inz(*blanks);
dcl-s EditCode char(1) inz(*blanks);
dcl-s CurrInd char(1) inz(*blanks);
dcl-s Precision inz(*zeros) like(int4_t);
dcl-s BinLength inz(*zeros) like(int4_t);
dcl-s Decimal inz(*zeros) like(int4_t);

//  additional
//  declarations for Convert Edit Word: QECCVTEW
dcl-s EditWord char(256) inz(*blanks);
dcl-s EditWordLn inz(*zeros) like(int4_t);

//  additional
//  declarations for Edit: QECEDT
dcl-s CvtVar char(256) inz(*blanks);
dcl-s CvtVarLen inz(256) like(int4_t);
dcl-s srcVar inz(*blanks) like(i_srcVar);
dcl-s SrcVarCls char(10) inz(*blanks);
dcl-s Float4 float(4) based(pFloat);
dcl-s Float8 float(8) based(pFloat);
dcl-s Float4Buf char(4) based(pFloat);
dcl-s Float8Buf char(8) based(pFloat);
dcl-s MaxFloat4 packed(12: 4) inz(*hival);
dcl-s MaxFloat8 packed(21: 4) inz(*hival);
dcl-s tmpfloat4 float(4) inz;
dcl-s tmpfloat8 float(8) inz;
dcl-s isexact ind inz;
dcl-s len int(10) inz;

dcl-s TempStrLen int(10) inz;

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

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK71
//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************
dcl-pi peek06;
  i_FLDL0100 likeds(fldl0100_t) const;
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

  fldl0100 = i_FLDL0100;

  //  Erzwingen Edit Code, wenn die Aufbereitung für eine über
  //  QCMDEXC auszuführende Befehlszeile erfolgt.
  if ((i_qcmdexc = bTrue) and
      (f_isNumFld(fldl0100) = bTrue) and
      (f_isFloatFld(fldl0100) = bFalse));
    fldl0100.f1edtc = 'P';
    fldl0100.f1edwl = 0;
    fldl0100.f1edwd = '';
  endif;

  EditCode = fldl0100.f1edtc;
  EditWord = fldl0100.f1edwd;
  CurrInd = '';
  EditWordLn = fldl0100.f1edwl;
  SrcVarCls = fldl0100.F1DTyp;

  if (SrcVarCls = 'B');

    select;
    when (f_buffLn(fldl0100) = 1);
      Precision = 3;
      BinLength = 1;
    when (f_buffLn(fldl0100) = 2);
      Precision = 5;
      BinLength = 2;
    when (f_buffLn(fldl0100) = 4);
      Precision = 10;
      BinLength = 4;
    other;
      Precision = 20;
      BinLength = 8;
    endsl;

  else;

    Precision = fldl0100.f1digt;
  endif;

  Decimal = fldl0100.f1decp;

  select;
  when (SrcVarCls = 'F');
    len = f_rtvFld(srcVar: i_srcVar: fldl0100);
    pFloat = %addr(srcVar);
    //         Float 4
    if (len = 4);
      select;
      when (%bitand(Float4Buf: fltmask_exp_4) = fltmask_exp_4);
        if (%bitand(Float4Buf: fltmask_man_4) <> *allx'00');
          o_string = spcval_nan;
        elseif (%bitand(%subst(Float4Buf: 1: 1): fltmask_sign)
                = fltmask_sign);
          o_string = spcval_neginf;
        else;
          o_string = spcval_inf;
        endif;
      other;
        //  Mit 4 Nachkommastellen nur, wenn dabei keine Ziffern
        //  verloren gehen (z.B. 1,2345E-5), sonst mit Exponent.
        MaxFloat4 = *hival;
        isexact = *off;
        if (%abs(Float4) <= MaxFloat4);
          eval(h) MaxFloat4 = Float4;
          tmpfloat4 = MaxFloat4;
          isexact = (tmpfloat4 = Float4);
        endif;
        if (isexact);
          o_string = %editc(MaxFloat4: 'P');
        else;
          o_string = %editflt(Float4);
        endif;
      endsl;
      o_strLen = 14;
    else;
      //         Float 8
      select;
      when (%bitand(Float8Buf: fltmask_exp_8) = fltmask_exp_8);
        if (%bitand(Float8Buf: fltmask_man_8) <> *allx'00');
          o_string = spcval_nan;
        elseif (%bitand(%subst(Float8Buf: 1: 1): fltmask_sign)
                = fltmask_sign);
          o_string = spcval_neginf;
        else;
          o_string = spcval_inf;
        endif;
      other;
        MaxFloat8 = *hival;
        isexact = *off;
        if (%abs(Float8) <= MaxFloat8);
          eval(h) MaxFloat8 = Float8;
          tmpfloat8 = MaxFloat8;
          isexact = (tmpfloat8 = Float8);
        endif;
        if (isexact);
          o_string = %editc(MaxFloat8: 'P');
        else;
          o_string = %editflt(Float8);
        endif;
      endsl;
      o_strLen = 23;
    endif;

  when (SrcVarCls = 'A' or SrcVarCls = 'G');
    TempStrLen =
      f_rtvFld(o_string: i_srcVar: fldl0100);
    //  Do not convert if we prepare the *HEADLINE (see: PEEK05, yCvtCcsid)
    if (f_hasCcsid(fldl0100) = bTrue and
        i_cvtCcsid = bTrue);
      hTranscoder =
       Transcoder_toJobCcsid(fldl0100.f1fdcc);
      o_strLen =
        Transcoder_xlateBuffer(hTranscoder
                               : %addr(o_string)
                               : TempStrLen
                               : %size(o_string));
      if (TempStrLen > o_strLen);
        %subst(o_string: o_strLen+1
              : TempStrLen - o_strLen) = '';
      endif;
    else;
      if (fldl0100.f1ndbc > 0);
        o_strLen = fldl0100.f1ndbc;
      else;
        o_strLen = TempStrLen;
      endif;
    endif;

  when (SrcVarCls = 'B');
    f_rtvFld(srcVar: i_srcVar: fldl0100);
    cpynv(f_NUM_Descr(T_Zoned: Precision: 0)
         : %addr(zonedBuffer)
         : f_NUM_Descr(T_Signed: BinLength: 0)
         : %addr(srcVar));
    srcVar = zonedBuffer;
    SrcVarCls = 'S';
    exsr Convert;
  when (SrcVarCls = 'P');
    f_rtvFld(srcVar: i_srcVar: fldl0100);
    exsr Convert;
  when (SrcVarCls = 'S');
    f_rtvFld(srcVar: i_srcVar: fldl0100);
    exsr Convert;
  other;
    o_strLen =
      f_rtvFld(o_string: i_srcVar: fldl0100);
  endsl;

endsr;

//====================================================*
//  Convert--  Convert to String                      *
//====================================================*

begsr Convert;

  select;
  when (SrcVarCls = 'B');
    SrcVarCls = '*BINARY';
  when (SrcVarCls = 'P');
    SrcVarCls = '*PACKED';
  when (SrcVarCls = 'S');
    SrcVarCls = '*ZONED';
  endsl;

  if (EditWord <> '');
    exsr CvtEdtWord;
    if (errCode.bytAvl = 0);
      exsr edit;
    endif;
  endif;

  //  Edit-Code, wenn kein Edit-Wort angegeben ist oder das Edit-Wort
  //  nicht zum Feld passt
  if (EditWord = '' or errCode.bytAvl > 0);
    exsr CvtEdtCode;
    if (errCode.bytAvl = 0);
      exsr edit;
    endif;
  endif;

  //  Edit-Code passt nicht zum Feld (z.B. Y bei mehr als 9 Stellen):
  //  Standard-Edit-Code L
  if (errCode.bytAvl > 0 and EditCode <> 'L');
    EditCode = 'L';
    exsr CvtEdtCode;
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

  CvtVarLen = rcvVarLen;

  clear errCode;
  errCode.bytPrv = %size(errCode);

  qecedt(CvtVar
        : CvtVarLen
        : srcVar
        : SrcVarCls
        : Precision
        : EditMask
        : EditMaskLn
        : ZeroBalanc
        : errCode);

  if (errCode.bytAvl = 0);
    o_string = %subst(CvtVar: 1: CvtVarLen);
    o_strLen = CvtVarLen;
  endif;

endsr;

//====================================================*
//  CvtEdtWord                                        *
//====================================================*

begsr CvtEdtWord;

  clear errCode;
  errCode.bytPrv = %size(errCode);

  clear EditMask;
  clear EditMaskLn;

  qeccvtew(EditMask
          : EditMaskLn
          : rcvVarLen
          : EditWord
          : EditWordLn
          : errCode);

endsr;

//====================================================*
//  CvtEdtCode                                        *
//====================================================*

begsr CvtEdtCode;

  select;
  // A-D
  when (EditCode >= 'A' and EditCode <= 'D');
  // J-Q
  when (EditCode >= 'J' and EditCode <= 'Q');
  // Y-Z
  when (EditCode >= 'Y' and EditCode <= 'Z');
  // 1-9
  when (EditCode >= '1' and EditCode <= '9');
  // X
  when (EditCode = 'X');
    EditCode = 'Z';
  other;
    EditCode = 'L';
  endsl;

  clear errCode;
  errCode.bytPrv = %size(errCode);

  clear EditMask;
  clear EditMaskLn;

  qeccvtec(EditMask
          : EditMaskLn
          : rcvVarLen
          : ZeroBalanc
          : EditCode
          : CurrInd
          : Precision
          : Decimal
          : errCode);

endsr;

