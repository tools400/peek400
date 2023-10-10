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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,D_MI
/COPY QCOPYLE,QECEDT
/COPY QCOPYLE,QECCVTEW
/COPY QCOPYLE,QECCVTEC

/define internal_prototype
/COPY QCOPYLE,PPEEK06
/undefine internal_prototype

//  declarations for Convert Edit Code: QECCVTEC
dcl-s editmask        char(256) inz(*blanks);
dcl-s editmaskln      inz(*zeros)  like(int4_t);
dcl-s rcvvarlen       inz(*zeros)  like(int4_t);
dcl-s zerobalanc      char(1) inz(*blanks);
dcl-s editcode        char(1) inz(*blanks);
dcl-s currind         char(1) inz(*blanks);
dcl-s precision       inz(*zeros)  like(int4_t);
dcl-s binlength       inz(*zeros)  like(int4_t);
dcl-s decimal         inz(*zeros)  like(int4_t);

//  additional
//  declarations for Convert Edit Word: QECCVTEW
dcl-s editword        char(256) inz(*blanks);
dcl-s editwordln      inz(*zeros)  like(int4_t);

//  additional
//  declarations for Edit: QECEDT
dcl-s cvtvar          char(256) inz(*blanks);
dcl-s cvtvarlen       inz(256)     like(int4_t);
dcl-s srcvar          inz(*blanks) like(i_srcvar);
dcl-s srcvarcls       char(10) inz(*blanks);
dcl-s float4          float(4) based(pfloat);
dcl-s float8          float(8) based(pfloat);
dcl-s float4buf       char(4) based(pfloat);
dcl-s float8buf       char(8) based(pfloat);
dcl-s maxfloat4       packed(12:4) inz(*hival);
dcl-s maxfloat8       packed(21:4) inz(*hival);
dcl-s len             int(10) inz;

dcl-s tempstrlen      int(10) inz;

dcl-s htranscoder     like(htranscoder_t ) inz;

//  helper fields to convert 3I0 and 20I0 fields
dcl-ds zonedbuffer;
  zoned3          zoned(3) inz   POS(1);
  zoned5          zoned(5) inz   POS(1);
  zoned10         zoned(10) inz   POS(1);
  zoned20         zoned(20) inz   POS(1);
end-ds;

dcl-s hex_null        like(rcdbuf_t) inz(*allx'00');

dcl-c spcval_nan_4 x'7FC00000';
dcl-c spcval_nan_8 x'7FF8000000000000';
dcl-c spcval_inf_4 x'7F800000';
dcl-c spcval_inf_8 x'7FF0000000000000';

dcl-c spcval_nan '*NaN';
dcl-c spcval_inf '*Inf';

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58
/COPY QCOPYLE,PPEEK71
//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************

dcl-pi peek06;
  i_fldl0100      const likeds(fldl0100_t);
  i_rcdfmt        const like(fmt_t);
  i_srcvar        const like(rcdbuf_t);
  i_qcmdexc       const like(bool_t);
  i_cvtccsid      const like(bool_t);
  o_string              like(rcdbuf_t);
  o_strlen              like(int4_t);
  o_msgid               like(msgid_t);
  o_msgdta              like(msgdta_t);
end-pi;

dcl-ds fldl0100 likeds(fldl0100_t) inz;
dcl-ds errcode likeds(errcode_t) inz;
//---------------------------------------------------*

o_string = '';
o_strlen = 0;

monitor;

  select;
  when (i_rcdfmt = 'FLDL0100');
    exsr w_fldl0100;
  endsl;

on-error;
  o_string = '';
  o_strlen = 0;
endmon;

return;

//====================================================*
//  W_FLDL0100 -    Work with FLDL0100                *
//====================================================*

begsr w_fldl0100;

  fldl0100 = i_fldl0100;

  //  Erzwingen Edit Code, wenn die Aufbereitung für eine über
  //  QCMDEXC auszuführende Befehlszeile erfolgt.
  if (i_qcmdexc = bTrue) and
     (f_isnumfld(fldl0100) = bTrue) and
     (f_isfloatfld(fldl0100) = bFalse);
    fldl0100.f1edtc = 'P';
    fldl0100.f1edwl = 0;
    fldl0100.f1edwd = '';
  endif;

  editcode = fldl0100.f1edtc;
  editword = fldl0100.f1edwd;
  currind = '';
  editwordln = fldl0100.f1edwl;
  srcvarcls = fldl0100.f1dtyp;

  if (srcvarcls = 'B');

    select;
    when (f_buffln(fldl0100) = 1);
      precision = 3;
      binlength = 1;
    when (f_buffln(fldl0100) = 2);
      precision = 5;
      binlength = 2;
    when (f_buffln(fldl0100) = 4);
      precision = 10;
      binlength = 4;
    other;
      precision = 20;
      binlength = 8;
    endsl;

  else;

    precision = fldl0100.f1digt;
  endif;

  decimal = fldl0100.f1decp;

  select;
  when (srcvarcls = 'F');
    len = f_rtvfld(srcvar: i_srcvar: fldl0100);
    pfloat = %addr(srcvar);
    //         Float 4
    if (len = 4);
      select;
      when (float4buf = spcval_nan_4);
        o_string = spcval_nan;
      when (float4buf = spcval_inf_4);
        o_string = spcval_inf;
      other;
        maxfloat4 = *hival;
        if (%abs(float4) <= maxfloat4);
          maxfloat4 = float4;
          o_string = %editc(maxfloat4: 'P');
        else;
          o_string = %editflt(float4);
        endif;
      endsl;
      o_strlen = 14;
    else;
      //         Float 8
      select;
      when (float8buf = spcval_nan_8);
        o_string = spcval_nan;
      when (float8buf = spcval_inf_8);
        o_string = spcval_inf;
      other;
        maxfloat8 = *hival;
        if (%abs(float8) <= maxfloat8);
          maxfloat8 = float8;
          o_string = %editc(maxfloat8: 'P');
        else;
          o_string = %editflt(float8);
        endif;
      endsl;
      o_strlen = 23;
    endif;

  when (srcvarcls = 'A' or srcvarcls = 'G');
    tempstrlen =
      f_rtvfld(o_string: i_srcvar: fldl0100);
    //  Do not convert if we prepare the *HEADLINE (see: PEEK05, yCvtCcsid)
    if f_hasccsid(fldl0100) = bTrue and
       i_cvtccsid = bTrue;
      htranscoder =
       transcoder_tojobccsid(fldl0100.f1fdcc);
      o_strlen =
        transcoder_xlatebuffer(htranscoder
                               : %addr(o_string)
                               : tempstrlen
                               : %size(o_string));
      if (tempstrlen > o_strlen);
        %subst(o_string: o_strlen+1
              : tempstrlen - o_strlen) = '';
      endif;
    else;
      if (fldl0100.f1ndbc > 0);
        o_strlen = fldl0100.f1ndbc;
      else;
        o_strlen = tempstrlen;
      endif;
    endif;

  when (srcvarcls = 'B');
    f_rtvfld(srcvar: i_srcvar: fldl0100);
    cpynv(f_num_descr(t_zoned: precision: 0)
         : %addr(zonedbuffer)
         : f_num_descr(t_signed: binlength: 0)
         : %addr(srcvar));
    srcvar = zonedbuffer;
    srcvarcls = 'S';
    exsr convert;
  when (srcvarcls = 'P');
    f_rtvfld(srcvar: i_srcvar: fldl0100);
    exsr convert;
  when (srcvarcls = 'S');
    f_rtvfld(srcvar: i_srcvar: fldl0100);
    exsr convert;
  other;
    o_strlen =
      f_rtvfld(o_string: i_srcvar: fldl0100);
  endsl;

endsr;

//====================================================*
//  Convert--  Convert to String                      *
//====================================================*

begsr convert;

  select;
  when (srcvarcls = 'B');
    srcvarcls = '*BINARY';
  when (srcvarcls = 'P');
    srcvarcls = '*PACKED';
  when (srcvarcls = 'S');
    srcvarcls = '*ZONED';
  endsl;

  if (editword <> '');
    exsr cvtedtword;
  else;
    exsr cvtedtcode;
  endif;

  cvtvarlen = rcvvarlen;

  clear errcode;
  errcode.bytprv = %size(errcode);

  qecedt(cvtvar
        : cvtvarlen
        : srcvar
        : srcvarcls
        : precision
        : editmask
        : editmaskln
        : zerobalanc
        : errcode);

  if (errcode.bytavl = 0);
    o_string = %subst(cvtvar: 1: cvtvarlen);
  else;
    o_string = %subst(hex_null: 1: cvtvarlen);
  endif;

  o_strlen = cvtvarlen;

endsr;

//====================================================*
//  CvtEdtWord                                        *
//====================================================*

begsr cvtedtword;

  clear errcode;
  errcode.bytprv = %size(errcode);

  clear editmask;
  clear editmaskln;

  qeccvtew(editmask
          : editmaskln
          : rcvvarlen
          : editword
          : editwordln
          : errcode);

endsr;

//====================================================*
//  CvtEdtCode                                        *
//====================================================*

begsr cvtedtcode;

  select;
  // A-D
  when (editcode >= 'A' and editcode <= 'D');
  // J-Q
  when (editcode >= 'J' and editcode <= 'Q');
  // Y-Z
  when (editcode >= 'Y' and editcode <= 'Z');
  // 1-9
  when (editcode >= '1' and editcode <= '9');
  // X
  when (editcode = 'X');
    editcode = 'Z';
  other;
    editcode = 'L';
  endsl;

  clear errcode;
  errcode.bytprv = %size(errcode);

  clear editmask;
  clear editmaskln;

  qeccvtec(editmask
          : editmaskln
          : rcvvarlen
          : zerobalanc
          : editcode
          : currind
          : precision
          : decimal
          : errcode);

endsr;

