**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.2.0                               *
//  Programm : PEEK058                                           *
//  Typ      : RPGLE                                             *
//                                                               *
//  erstellt : 21.07.99  Raddatz                                 *
//  geändert :                                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Allgemeine Routinen                               *
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
ctl-opt nomain;
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FILD0100
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,MBRD0100
/copy QCOPYLE,MBRD0300
/copy QCOPYLE,BSPF0100
/copy QCOPYLE,OBJD0100
/copy QCOPYLE,USRI0200
/copy QCOPYLE,D_CLib
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,D_MI
/copy QCOPYLE,QDBRTVFD
/copy QCOPYLE,QUSRJOBI
/copy QCOPYLE,QUSROBJD
/copy QCOPYLE,QUSRMBRD
/copy QCOPYLE,QCAPCMD
/copy QCOPYLE,QSYRUSRI
/copy QCOPYLE,QMHRMVPM
/copy QCOPYLE,QMHSNDPM
/copy QCOPYLE,QMHRTVM
/copy QCOPYLE,QMHMOVPM
/copy QCOPYLE,QLGCNVCS
/copy QCOPYLE,SDS

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK41

dcl-s peek41_name like(pgmCallN_t);

//  Performs word wrapping on a given string without respect to
//  end-of-paragraph markers.
dcl-pr lf_wordWrap varchar(4096);
  i_string    varchar(4096) const;
  i_width     uns(10) const;
  io_startPos uns(10);
end-pr;

//  Tests for one or more bits.
dcl-pr isBitOn ind;
  i_testBit uns(10) value;
  i_value   uns(10) value;
end-pr;

//  Appends a line of the column heading to a heading.
dcl-pr lf_appendColHdg like(colHeading_t);
  i_heading like(colHeading_t) const;
  i_line    char(20) const;
end-pr;

dcl-s g_prdLib like(lib_t) inz;

dcl-s g_jobCcsid uns(10) inz(0);

//===================================================================*
//  Funktion:  f_dsplyLn                                  (Body)     *
//===================================================================*

dcl-proc f_dsplyLn export;
  dcl-pi *n like(int4_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  //  Funktionswert
  dcl-s fldLen like(int4_t);
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1DTyp = 'G' and
  i_fldl0100.f1ndbc > 0);
    return i_fldl0100.f1ndbc;
  endif;

  fldLen = i_fldl0100.f1FLen;

  if (i_fldl0100.f1vfmi = '1');
    //  Variable Feldlänge ...
    fldLen = fldLen - 2;
  endif;

  return fldLen;

end-proc;

//===================================================================*
//  Funktion:  f_buffLn                                   (Body)     *
//===================================================================*

dcl-proc f_buffLn export;
  dcl-pi *n like(int4_t);
    i_fldl0100 likeds(fldl0100_t) const;
    i_withLen  like(bool_t) options(*nopass) const;
  end-pi;

  //  Funktionswert
  dcl-s fldLen like(int4_t) inz;

  //  Arbeitsfelder
  dcl-s withLen like(i_withLen) inz;
  // ------------------------------------------------------------------------

  if (%parms() >= %parmnum(i_withLen));
    withLen  = i_withLen;
  else;
    withLen  = bFalse;
  endif;

  if (i_fldl0100.f1vfmi = '1');
    //  Variable Feldlänge ...
    if (withLen = bTrue);
      //  ... incl. Längenbyte
      fldLen = i_fldl0100.f1FLen;
    else;
      //  ... ohne Längenbyte
      fldLen = i_fldl0100.f1FLen - 2;
    endif;
  else;
    //  Felder fester Länge
    fldLen = i_fldl0100.f1FLen;
  endif;

  return fldLen;

end-proc;

//===================================================================*
//  Funktion:  f_curFldLn                                 (Body)     *
//===================================================================*

dcl-proc f_curFldLn export;
  dcl-pi *n like(int4_t);
    i_buffer   like(rcdBuf_t) const;
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  //  Funktionswert
  dcl-s curFldLn like(int4_t) inz;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1vfmi = '1');
    curFldLn = f_binToDec(i_buffer: i_fldl0100.f1IBuf: 2);
  else;
    if (i_fldl0100.f1ndbc > 0);
      curFldLn = i_fldl0100.f1ndbc;
    else;
      curFldLn = i_fldl0100.f1FLen;
    endif;
  endif;

  return curFldLn;

end-proc;

//===================================================================*
//  Funktion:  f_rtvFld                                   (Body)     *
//===================================================================*

dcl-proc f_rtvFld export;
  dcl-pi *n opdesc like(int4_t);
    o_buffer   like(rcdBuf_t) options(*varsize);
    i_buffer   like(rcdBuf_t) const;
    i_fldl0100 likeds(fldl0100_t) const;
    i_withLen  like(bool_t) options(*nopass) const;
  end-pi;

  //  Funktionswert
  dcl-s rtnLen like(int4_t) inz;

  // Parameters passed to CEEDOD
  dcl-s descType int(10);
  dcl-s dataType int(10);
  dcl-s descInfo1 int(10);
  dcl-s descInfo2 int(10);
  dcl-s parmLen int(10);

  //  Arbeitsfelder
  dcl-s withLen like(i_withLen) inz;
  // ------------------------------------------------------------------------

  ceedod(1         : descType : dataType :
  descInfo1 : descInfo2: parmLen  :
  *omit);

  if (%parms() >= %parmnum(i_withLen));
    withLen  = i_withLen;
  else;
    withLen  = bFalse;
  endif;

  rtnLen = f_buffLn(i_fldl0100: withLen);
  if (rtnLen > parmLen);
    rtnLen = parmLen;
  endif;

  if (i_fldl0100.f1vfmi = '1');
    if (withLen = bFalse);
      %subst(o_buffer: 1: parmLen) =
      %subst(i_buffer: i_fldl0100.f1IBuf+2: rtnLen);
    else;
      %subst(o_buffer: 1: parmLen) =
      %subst(i_buffer: i_fldl0100.f1IBuf  : rtnLen);
    endif;
  else;
    %subst(o_buffer: 1: parmLen) =
    %subst(i_buffer: i_fldl0100.f1IBuf  : rtnLen);
  endif;

  return rtnLen;

end-proc;

//===================================================================*
//  Prozedur:  p_fldToBuf                                 (Body)     *
//===================================================================*

dcl-proc p_fldToBuf export;
  dcl-pi *n;
    io_buffer  like(rcdBuf_t);
    i_fieldDta like(rcdBuf_t);
    i_fldl0100 likeds(fldl0100_t) const;
    i_withLen  like(bool_t) options(*nopass) const;
  end-pi;

  //  Arbeitsfelder
  dcl-s withLen like(i_withLen) inz;

  dcl-s fieldDta like(rcdBuf_t) based(pFieldDta);
  dcl-s fieldDtaUcs2 like(rcdBufUcs2_t) based(pFieldDta);

  dcl-ds *n;
    buffLn  like(int2_t);
    buffLnA char(2) overlay(buffLn: 1);
  end-ds;
  // ------------------------------------------------------------------------
  pFieldDta = %addr(i_fieldDta);

  if (%parms() >= %parmnum(i_withLen));
    withLen = i_withLen;
  else;
    withLen = bFalse;
  endif;

  if (i_fldl0100.f1vfmi = '1');
    //  Felder variabler Länge ...
    if (withLen = bFalse);
      //  ... ohne Längenangabe
      //      (einfügen Längenangabe)

      if (i_fldl0100.f1DTyp = 'G');
        buffLn = %len(%trimr(
                     %subst(fieldDtaUcs2
                            : 1
                            : f_dsplyLn(i_fldl0100))
                            )) * 2;
      else;
        buffLn = %len(%trimr(
                     fieldDta));
      endif;

      %subst(io_buffer  :
            i_fldl0100.f1IBuf+2 :
            f_buffLn(i_fldl0100: withLen))
               = i_fieldDta;

      if (i_fldl0100.f1DTyp = 'G' and
         i_fldl0100.f1ndbc > 0);
        buffLn = buffLn / 2;
      endif;

      %subst(io_buffer  :
            i_fldl0100.f1IBuf   :
            2          )
               = buffLnA;
    else;
      //  ... incl. Längenangabe
      %subst(io_buffer  :
            i_fldl0100.f1IBuf   :
            f_buffLn(i_fldl0100: withLen))
               = i_fieldDta;
    endif;
  else;
    //  Felder fester Länge ...
    %subst(io_buffer  :
          i_fldl0100.f1IBuf   :
          f_buffLn(i_fldl0100))
             = i_fieldDta;
  endif;

end-proc;

//===================================================================*
//  Funktion:  f_isVarLen                                 (Body)     *
//===================================================================*

dcl-proc f_isVarLen export;
  dcl-pi *n like(bool_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1vfmi = '1');
    return bTrue;
  else;
    return bFalse;
  endif;

end-proc;

//===================================================================*
//  Funktion:  f_binToDec                                 (Body)     *
//===================================================================*

dcl-proc f_binToDec export;
  dcl-pi *n opdesc like(int4_t);
    i_string   like(varString_t) options(*varsize) const;
    i_startPos like(int4_t) const;
    i_length   like(int4_t) const;
  end-pi;

  // Funktionswert
  dcl-ds *n;
    intValue like(int4_t) inz;
    alpha2   char(2) overlay(intValue: 3);
    alpha4   char(2) overlay(intValue: 1);
  end-ds;
  // ------------------------------------------------------------------------

  if ((i_startPos + i_length - 1) > %len(i_string));
    p_kill('Start position and length outside range.');
  else;
    select;
    when (i_length = 2);
      alpha2 = %subst(i_string: i_startPos: i_length);
    when (i_length = 4);
      alpha4 = %subst(i_string: i_startPos: i_length);
    other;
      p_kill('Incorrect length: ' + %char(i_length));
    endsl;
  endif;

  return intValue;

end-proc;

//===================================================================*
//  Funktion:  f_len                                      (Body)     *
//===================================================================*

dcl-proc f_len_deprecated export;
  dcl-pi *n opdesc like(int4_t);
    i_string like(varString_t) options(*varsize) const;
  end-pi;

  // Parameters passed to CEEDOD
  dcl-s descType int(10);
  dcl-s dataType int(10);
  dcl-s descInfo1 int(10);
  dcl-s descInfo2 int(10);
  dcl-s parmLen int(10);
  // ------------------------------------------------------------------------

  p_kill('Deprecated procedure: f_len()');

  ceedod(1         : descType : dataType :
  descInfo1 : descInfo2: parmLen  :
  *omit);

  return parmLen;

end-proc;

//===================================================================*
//  Funktion:  f_scan                                     (Body)     *
//===================================================================*

dcl-proc f_scan export;
  dcl-pi *n opdesc like(int4_t);
    srchArg char(100) options(*varsize) const;
    string  char(100) const;
  end-pi;

  dcl-s posFound like(int4_t) inz;

  // Parameters passed to CEEDOD
  dcl-s descType like(int4_t) inz;
  dcl-s dataType like(int4_t) inz;
  dcl-s descInfo1 like(int4_t) inz;
  dcl-s descInfo2 like(int4_t) inz;
  dcl-s pLen like(int4_t) inz;
  //------------------------------------------------------------*

  ceedod(1         : descType : dataType :
  descInfo1 : descInfo2: pLen     :
  *omit);

  posFound = %scan(%subst(srchArg: 1: pLen): string);

  return posFound;

end-proc;

//===================================================================*
//  Funktion:  f_vldNme                                   (Body)     *
//===================================================================*

dcl-proc f_vldName export;
  dcl-pi *n like(bool_t);
    i_name   like(fieldNme_t) const;
    o_msgID  like(msgId_t);
    o_msgDta like(msgDta_t);
  end-pi;

  //  Funktionswert
  dcl-s isValid like(bool_t) inz(bFalse);

  //  Arbeitsfelder
  dcl-s idx like(int4_t) inz;
  dcl-s chr char(1) inz;
  dcl-s startString like(bool_t) inz(bFalse);
  dcl-s endString like(bool_t) inz(bFalse);

  dcl-c VALID_FIRST_CHAR '§$#ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  dcl-c VALID_CHAR '§$#ABCDEFGHIJKLMNOPQRSTUVWXYZ_.1234567890';

/copy QCOPYLE,USR8182
  //-------------------------------------------------------------------*

  isValid = bTrue;
  startString = bFalse;
  endString = bFalse;

  for idx = 1 to 10;

    chr = %subst(i_name: idx: 1);

    //  Prüfen Start des Strings und 1. Zeichen ...
    if (startString =  bFalse and endString =  bFalse and chr <> '');
      startString = bTrue;
      if (%check(VALID_FIRST_CHAR: chr) > 0);
        clear usr8182;
        usr8182.var1 = chr;
        o_msgID = 'USR8182';
        o_msgDta = usr8182;
        isValid = bFalse;
        leave;
      endif;
      iter;
    endif;

    //  Prüfen Ende des Strings ...
    if ((startString =  bTrue )  and
        (endString =  bFalse)  and
        (chr       =  ' '   ));
      endString = bTrue;
      iter;
    endif;

    //  Prüfen Zeichen des Strings ...
    if (startString =  bTrue and endString = bFalse);
      if (%check(VALID_CHAR: chr) > 0);
        clear usr8182;
        usr8182.var1 = chr;
        o_msgID = 'USR8182';
        o_msgDta = usr8182;
        isValid = bFalse;
        leave;
      endif;
    endif;

    //  Prüfen Zeichen hinter dem Ende des Strings ...
    if (startString =  bTrue and endString =  bTrue);
      if (chr <> '');
        clear usr8182;
        usr8182.var1 = chr;
        o_msgID  = 'USR8182';
        o_msgDta = usr8182;
        isValid  = bFalse;
        leave;
      endif;
    endif;

  endfor;

  if (startString = bFalse);
    clear usr8182;
    usr8182.var1 = chr;
    o_msgID  = 'USR8182';
    o_msgDta = usr8182;
    isValid  = bFalse;
  endif;

  return isValid;

end-proc;

//===================================================================*
//  Funktion:  f_vldFloat                                 (Body)     *
//===================================================================*

dcl-proc f_vldFloat export;
  dcl-pi *n like(bool_t);
    i_buffer varchar(64) const;
  end-pi;

  //  Arbeitsfelder
  dcl-s i int(10) inz;
  dcl-s c char(1) inz;
  dcl-s dummy float(8) inz;
  dcl-s hasExponent like(bool_t) inz(bFalse);
  dcl-c cDIGITS '0123456789';
  //-------------------------------------------------------------------*

  monitor;

    if (%len(i_buffer) = 0);
      return bFalse;
    endif;

    i = %check(' ': i_buffer);

    // Prüfen auf führendes Vorzeichen
    c = %subst(i_buffer: i: 1);
    if (c = '+' or c = '-');   // Überspringen Vorzeichen
      i = i + 1;
    endif;

    // Prüfen auf nummerische Ziffern vor dem Komma
    dow (i <= %len(i_buffer));
      c = %subst(i_buffer: i: 1);
      if (c <> ' ');
        if (c = ',' or c = '.');
          i = i + 1;   // Überspringen Komma
          leave;
        endif;
        if (%check(cDIGITS: c) <> 0);
          return bFalse;
        endif;
      endif;
      i = i + 1;
    enddo;

    // Prüfen auf nummerische Ziffern hinter dem Komma
    dow (i <= %len(i_buffer));
      c = %subst(i_buffer: i: 1);
      if (c <> ' ');
        if (c = 'e' or c = 'E');
          leave;
        endif;
        if (%check(cDIGITS: c) <> 0);
          return bFalse;
        endif;
      endif;
      i = i + 1;
    enddo;

    if (c = 'e' or c = 'E');
      // Prüfen auf Vorzeichen des Exponenten
      i = i + 1;
      if (i > %len(i_buffer));
        return bFalse;
      endif;
      c = %subst(i_buffer: i: 1);
      if (c <> '+' and c <> '-' and c <> ' ');
        return bFalse;
      endif;

      i = i + 1;
      hasExponent = bFalse;

      // Prüfen auf nummerische Ziffern des Exponenten
      dow (i <= %len(i_buffer));
        c = %subst(i_buffer: i: 1);
        if (c <> ' ');
          if (%check(cDIGITS: c) <> 0);
            return bFalse;
          endif;
          hasExponent = bTrue;
        endif;
        i = i + 1;
      enddo;

      if (hasExponent <> bTrue);
        return bFalse;
      endif;
    endif;

    dummy = %float(i_buffer);

    return bTrue;
  on-error;
    p_rmvPgmMg('*');
    return bFalse;
  endmon;


end-proc;

//===================================================================*
//  Funktion:  f_execute                                  (Body)     *
//===================================================================*

dcl-proc f_execute export;
  dcl-pi *n opdesc like(bool_t);
    i_cmd    like(cmdBuffer_t) options(*varsize) const;
    o_msgID  like(msgId_t);
    o_msgDta like(msgDta_t);
  end-pi;

  //  Definieren Funktionswert
  dcl-s isOK like(bool_t) inz(bFalse);

  //  Definieren Parameter für p_getOpDesc
  dcl-s descType int(10) inz;
  dcl-s dataType int(10) inz;
  dcl-s descInf1 int(10) inz;
  dcl-s descInf2 int(10) inz;
  dcl-s dataLen int(10) inz;
  dcl-s feedBack char(12) inz;

  //  Definitionen für QCAPCMD
  dcl-s cmdLen int(10) inz;

  dcl-ds optCtrl;
    typ_cmdPrc int(10) inz(0); // like QCMDEXC
    dbcs_data  char(1) inz('0'); // ignore DBCS
    prmt_act   char(1) inz('0'); // never prompt
    cmdStrSntx char(1) inz('0'); // AS/400 Syntax
    msgRtvKey  char(4) inz(*blanks); // no retrieve ke
    res_01     char(9) inz(*allx'00');
  end-ds;

  dcl-s optCtrlLen int(10) inz;
  dcl-s optCtrlFmt char(8) inz('CPOP0100');
  dcl-s cmd like(i_cmd) inz;
  dcl-s lenAvl int(10) inz;
  dcl-s lenAvlRtn int(10) inz;

  dcl-ds errCode likeds(errCode_t) inz;
  //-------------------------------------------------------------------

  reset errCode;
  errCode.bytPrv = %size(errCode);

  ceedod(1: descType: dataType:
  descInf1: descInf2:
  dataLen:  feedBack);

  cmd        = %subst(i_cmd: 1: dataLen);
  cmdLen     = %len(cmd);
  lenAvl     = %len(cmd);

  optCtrlLen = %len(optCtrl);
  reset errCode;
  errCode.bytPrv = %size(errCode);

  qcapcmd (cmd: cmdLen: optCtrl :optCtrlLen: optCtrlFmt: cmd: lenAvl: lenAvlRtn: errCode);

  if (errCode.bytAvl <> 0);
    o_msgID  = errCode.excID;
    o_msgDta = errCode.excDta;
    isOK     = bFalse;
  else;
    o_msgID  = ' ';
    o_msgDta = ' ';
    isOK     = bTrue;
  endif;

  return isOK;

end-proc;

//===================================================================*
//  Funktion:  f_basedPF                                  (Body)     *
//===================================================================*

dcl-proc f_basedPF export;
  dcl-pi *n like(bool_t);
    i_file      like(file_t) value;
    i_lib       like(lib_t) value;
    i_mbr       like(mbr_t) value;
    i_rcdFmt    like(rcdFmt_t) value;
    i_rcdMbrNbr like(mbrNbr_t) value;
    o_pFile     like(file_t);
    o_pLib      like(lib_t);
    o_pMbr      like(mbr_t);
    o_pRcdFmt   like(rcdFmt_t);
  end-pi;

  //  Definieren Funktionswert ...
  dcl-s isBasedOnPF like(bool_t) inz(bFalse);

  dcl-s tFile like(i_file);
  dcl-s tLib like(i_lib);
  dcl-s tMbr like(i_mbr);
  dcl-s tRcdFmt like(i_rcdFmt);
  dcl-ds fild0100 likeds(fild0100_t) inz;

  dcl-ds yQFile likeds(qObj_t) inz;
  dcl-s yNbrOfEnt like(int4_t);
  dcl-s yData char(512);
  //------------------------------------------------------------*

  peek41_name = f_pgmCallN('PEEK41');

  o_pFile  = '*ERROR';
  o_pLib   = '*ERROR';
  o_pMbr   = '*ERROR';
  o_pRcdFmt = '*ERROR';

  //  Einlesen der Dateiinformationen ...
  yQFile.name = i_file;
  yQFile.lib = i_lib;
  peek41(yQFile: i_rcdFmt: '*CREATE': yNbrOfEnt: yData);

  if (yNbrOfEnt = 0);
    return bFalse;
  endif;

  //      prüfen auf logische Datei
  fild0100 = yData;

  if (fild0100.atfila = '*LGL');
    //      ... logical file
    select;
    when (fild0100.atnomb > 1);
      // ... multi-based-member logical file
      if (f_basedMbr(i_file: i_lib: i_mbr
                     : i_rcdMbrNbr: i_rcdFmt
                     : tFile: tLib: tMbr: tRcdFmt) = bFalse);
        return bFalse;
      endif;

    when (fild0100.atnofm > 1);
      // ... multi-format logical file
      if (f_basedMbr(i_file: i_lib: i_mbr
                     : i_rcdMbrNbr: i_rcdFmt
                     : tFile: tLib: tMbr: tRcdFmt) = bFalse);
        return bFalse;
      endif;

    other;
      // ... single-format logical file
      if (f_basedMbr(i_file: i_lib: i_mbr
                     : i_rcdMbrNbr: i_rcdFmt
                     : tFile: tLib: tMbr: tRcdFmt) = bFalse);
        return bFalse;
      endif;
    endsl;


    isBasedOnPF = bTrue;
    o_pFile   = tFile;
    o_pLib    = tLib;
    o_pMbr    = tMbr;
    o_pRcdFmt = tRcdFmt;

  else;
    // ... physical file
    if (f_basedMbr(i_file: i_lib: i_mbr
                   : i_rcdMbrNbr: i_rcdFmt
                   : tFile: tLib: tMbr: tRcdFmt) = bFalse);
      return bFalse;
    endif;

    isBasedOnPF = bFalse;
    o_pFile   = tFile;
    o_pLib    = tLib;
    o_pMbr    = tMbr;
    o_pRcdFmt = tRcdFmt;
  endif;

  return isBasedOnPF;

end-proc;

//===================================================================*
//  Funktion:  f_basedMbr                                 (Body)     *
//===================================================================*

dcl-proc f_basedMbr export;
  dcl-pi *n like(bool_t);
    i_file   like(file_t) value;
    i_lib    like(lib_t) value;
    i_mbr    like(mbr_t) value;
    i_mbrNbr like(int4_t) value;
    i_rcdFmt like(rcdFmt_t) value;
    o_pFile  like(file_t);
    o_pLib   like(lib_t);
    o_pMbr   like(mbr_t);
    o_rcdFmt like(rcdFmt_t);
  end-pi;

  //  Definieren Funktionswert ...
  dcl-s isMbrFound like(bool_t) inz(bFalse);

  dcl-s mbrNbr like(i_mbrNbr);

  //  Arbeitsfelder
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds errCode likeds(errCode_t) inz;

  dcl-ds bspf0100 likeds(bspf0100_t) inz;

  dcl-s pMbrd0300 pointer inz;
  dcl-ds mbrd0300 likeds(mbrd0300_t) based(pMbrd0300);

  dcl-ds basedOnE likeds(mbrd0300_basedOnE_t) based(pBasedOnE);

  dcl-s offset int(10) inz;
  dcl-ds fild0100 likeds(fild0100_t) inz;

  dcl-s nbrOfEnt like(int4_t);
  dcl-s yData char(512);
  //------------------------------------------------------------*

  peek41_name = f_pgmCallN('PEEK41');

  o_pFile = ' ';
  o_pLib  = ' ';
  o_pMbr  = ' ';

  //  Ermitteln Speicherbedarf
  reset errCode;
  errCode.bytPrv = %size(errCode);

  qFile.name = i_file;
  qFile.lib = i_lib;
  pMbrd0300 = malloc(%size(mbrd0300));
  qusrmbrd(mbrd0300: %size(mbrd0300): 'MBRD0300': qFile: i_mbr: '0': errCode);
  if (errCode.bytAvl <> 0);
    isMbrFound = bFalse;
    return isMbrFound;
  endif;

  //  Zuordnen Speicher
  pMbrd0300 = realloc(pMbrd0300: mbrd0300.m3bytAvl);

  //  Abrufen Beschreibung der Teildatei
  qusrmbrd(mbrd0300: mbrd0300.m3bytAvl: 'MBRD0300': qFile: i_mbr: '0': errCode);
  if (errCode.bytAvl <> 0);
    isMbrFound = bFalse;
    return isMbrFound;
  endif;

  select;
  //  Wenn es sich um eine Join Datei oder SQL VIEW handelt, ...
  when (mbrd0300.m3joinMbr = '1' or
  mbrd0300.m3SQLFileType = 'VIEW');
    //  ... dann
    //      zurückgeben der Eingangsmemberdaten, wegen Join Datei
    o_pFile   = i_file;
    o_pLib    = i_lib;
    o_pMbr    = i_mbr;
    o_rcdFmt  = i_rcdFmt;
    isMbrFound = bTrue;

  //  Wenn es keine basierenden physischen Member gibt, ...
  when (mbrd0300.m3numBasedOnMbr = 0);
    //  ... dann
    //      zurückgeben der Eingangsmemberdaten
    o_pFile   = i_file;
    o_pLib    = i_lib;
    o_pMbr    = i_mbr;
    o_rcdFmt  = i_rcdFmt;
    isMbrFound = bTrue;
  other;
    //  ... sonst
    //      zurückgeben des basierenden physischen Members
    if (i_mbrNbr > 0);
      mbrNbr = i_mbrNbr;
    else;
      if (mbrd0300.m3numBasedOnMbr = 1);
        mbrNbr = 1;
      else;
        mbrNbr = -1;
      endif;
    endif;

    if (mbrNbr > 0);
      offset = %size(mbrd0300) +
        (mbrNbr - 1) * %size(basedOnE);
      pBasedOnE  = f_addPtr(pMbrd0300: offset);
      o_pFile    = basedOnE.basedOnFile;
      o_pLib     = basedOnE.basedOnLib;
      o_pMbr     = basedOnE.basedOnMbr;
      o_rcdFmt   = '*FIRST';
      isMbrFound = bTrue;
    else;
      o_pFile    = '*ERROR';
      o_pLib     = '*ERROR';
      o_pMbr     = '*ERROR';
      o_rcdFmt   = '*ERROR';
      isMbrFound = bFalse;
    endif;
  endsl;

  if (o_rcdFmt = '*FIRST');

    //  Einlesen der Dateiinformationen ...
    qFile.name = o_pFile;
    qFile.lib = o_pLib;
    peek41(qFile: o_rcdFmt: '*CREATE': nbrOfEnt: yData);
    fild0100 = yData;

    peek41(qFile: o_rcdFmt: '*BASED-ON': nbrOfEnt: yData);
    bspf0100 = yData;

    if (nbrOfEnt = 1);
      o_rcdFmt = bspf0100.bfrcdfmt;
    endif;

  endif;

  return isMbrFound;

on-exit;
  if (pMbrd0300 <> *null);
    free(pMbrd0300);
  endif;

end-proc;

//===================================================================*
//  Funktion:  f_numBased                                 (Body)     *
//===================================================================*

dcl-proc f_numBased export;
  dcl-pi *n like(int4_t);
    i_file like(file_t) const;
    i_lib  like(lib_t) const;
    i_mbr  like(mbr_t) const;
  end-pi;

  //  Definieren Funktionswert ...
  dcl-s f_numBased like(int4_t) inz;

  //  Arbeitsfelder
  dcl-ds errCode likeds(errCode_t) inz;

  dcl-ds mbrd0300 inz;
    m3bytPrv   int(10);
    m3bytAvl   int(10);
    m3FileAttr char(10) pos(39);
    m3NbrMbr   int(10) pos(157);
  end-ds;
  //------------------------------------------------------------*

  //  Ermitteln Anzahl basierender Teildateien
  reset errCode;
  errCode.bytPrv = %size(errCode);

  qusrmbrd(mbrd0300: %size(mbrd0300): 'MBRD0300': i_file + i_lib: i_mbr: '0': errCode);
  if (errCode.bytAvl <> 0);
    f_numBased = -1;
  else;
    if (m3FileAttr = 'PF');
      f_numBased = 1;
    else;
      f_numBased = m3NbrMbr;
    endif;
  endif;

  return f_numBased;

end-proc;

//===================================================================*
//  Prozedur:  p_setPrdLb                                 (Body)     *
//===================================================================*

dcl-proc p_setPrdLb export;
  dcl-pi *n;
    i_lib like(lib_t) const;
  end-pi;
  //------------------------------------------------------------*

  g_prdLib = i_lib;

end-proc;

//===================================================================*
//  Funktion:  f_getPrdLb                                 (Body)     *
//===================================================================*

dcl-proc f_getPrdLb export;
  dcl-pi *n like(lib_t);
  end-pi;
  //------------------------------------------------------------*

  return g_prdLib;

end-proc;

//===================================================================*
//  Funktion:  f_cmdLine                                  (Body)     *
//===================================================================*

dcl-proc f_cmdLine export;
  dcl-pi *n like(bool_t);
  end-pi;
  //------------------------------------------------------------*

  //  Definieren Funktionswert ...
  dcl-s f_cmdLine like(bool_t) inz;

  dcl-ds usri0200 likeds(usri0200_t) inz;
  dcl-ds errCode likeds(errCode_t) inz;
  //------------------------------------------------------------*

  clear usri0200;

  reset errCode;
  errCode.bytPrv = %size(errCode);

  qsyrusri (usri0200: %size(usri0200): 'USRI0200': sds.user: errCode);

  if (errCode.bytAvl <> 0 or usri0200.lmtCap = '*YES');
    f_cmdLine = bFalse;
  else;
    f_cmdLine = bTrue;
  endif;

  return f_cmdLine;


end-proc;

//===================================================================*
//  Prozedur:  Expands a string by inserting spaces.      (Body)     *
//===================================================================*

dcl-proc p_expStr export;
  dcl-pi *n opdesc;
    o_string  like(varString_t) options(*varsize);
    i_string  like(varString_t) options(*varsize) const;
    i_stepVal like(int4_t) options(*nopass) const;
  end-pi;

  dcl-s oStrLen int(10);
  dcl-s iStrLen int(10);

  //  Arbeitsfelder
  dcl-s stepVal int(10) inz;
  dcl-s iIdx int(10) inz;
  dcl-s oIdx int(10) inz;
  dcl-s x int(10) inz;
  // ------------------------------------------------------------------------

  if (%parms() >= %parmnum(i_stepVal));
    stepVal = i_stepVal;
  else;
    stepVal = 1;
  endif;

  oStrLen = %len(o_string);
  iStrLen = %len(i_string);

  iIdx = 1;
  oIdx = 1;

  dow (iIdx <= iStrLen and oIdx <= oStrLen);

    %subst(o_string: oIdx: 1) = %subst(i_string: iIdx: 1);

    iIdx = iIdx + 1;
    oIdx = oIdx + 1;

    for x = 1 to stepVal;
      if (oIdx > oStrLen);
        leave;
      endif;
      %subst(o_string: oIdx: 1) = '';
      oIdx = oIdx + 1;
    endfor;
  enddo;

end-proc;

//===================================================================*
//  Funktion:  f_headline                                 (Body)     *
//===================================================================*

dcl-proc f_headline export;
  dcl-pi *n like(colHeading_t);
    i_headTyp  like(type_t) const;
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  //  Funktionswert
  dcl-s heading like(colHeading_t);
  // ------------------------------------------------------------------------

  //  Überschrift ...
  select;
  //  ... Feldtext
  when (i_headTyp = '*FIELDTEXT');
    if (i_fldl0100.f1FTxt = ' ');
      heading = '?' + i_fldl0100.f1FNme;
    else;
      heading = i_fldl0100.f1FTxt;
    endif;
  //  ... Spaltenüberschrift
  when (i_headTyp = '*COLHDG');
    heading = lf_appendColHdg('': i_fldl0100.f1col1);
    heading = lf_appendColHdg(heading: i_fldl0100.f1col2);
    heading = lf_appendColHdg(heading: i_fldl0100.f1col3);
    if (heading = '');
      heading = '?' + i_fldl0100.f1FNme;
    endif;
  //  ... Feldtyp
  when (i_headTyp = '*FIELDTYPE');
    heading = f_fieldTypeAsString(i_fldl0100);
  //  ... Feldname
  other;
    heading = i_fldl0100.f1FNme;
  endsl;

  return heading;

end-proc;

//=========================================================================
//  Appends a line of the column heading to a heading. A heading that
//  ends with a hyphen is continued without a blank. The hyphen is
//  removed, if the line starts with a lowercase letter.
//=========================================================================

dcl-proc lf_appendColHdg;
  dcl-pi *n like(colHeading_t);
    i_heading like(colHeading_t) const;
    i_line    char(20) const;
  end-pi;

  dcl-c LOWERCASE 'abcdefghijklmnopqrstuvwxyzäöüßàâçéèêëîïôùûáíóúñìò';

  //  Return value
  dcl-s heading like(colHeading_t) inz;

  //  Local fields
  dcl-s line varchar(20) inz;
  // ------------------------------------------------------------------------

  heading = i_heading;
  line = %trim(i_line);

  select;
  when (line = '');
  when (heading = '');
    heading = line;
  when (%subst(heading: %len(heading): 1) <> '-');
    heading = heading + ' ' + line;
  when (%scan(%subst(line: 1: 1): LOWERCASE) > 0);
    heading = %subst(heading: 1: %len(heading) - 1) + line;
  other;
    heading = heading + line;
  endsl;

  return heading;

end-proc;

//===================================================================*
//  Funktion:  f_isNumFld                                 (Body)     *
//===================================================================*

dcl-proc f_isNumFld export;
  dcl-pi *n like(bool_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  //  Funktionswert
  dcl-s isNumFld like(bool_t) inz;
  // ------------------------------------------------------------------------

  if ((i_fldl0100.f1DTyp = 'S') or                                          // Zoned
  (i_fldl0100.f1DTyp = 'B') or                                          // Binary
  (i_fldl0100.f1DTyp = 'P') or                                          // Packed
  (i_fldl0100.f1DTyp = 'F'));                                            // Float
    isNumFld = bTrue;
  else;
    isNumFld = bFalse;
  endif;

  return isNumFld;

end-proc;

//===================================================================*
//  Funktion:  f_isFloatFld                               (Body)     *
//===================================================================*

dcl-proc f_isFloatFld export;
  dcl-pi *n like(bool_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  //  Funktionswert
  dcl-s isFloat like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1DTyp = 'F');                                            // Float
    isFloat = bTrue;
  else;
    isFloat = bFalse;
  endif;

  return isFloat;

end-proc;

//===================================================================*
//  Funktion:  f_isCharFld                                (Body)     *
//===================================================================*

dcl-proc f_isCharFld export;
  dcl-pi *n like(bool_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  //  Funktionswert
  dcl-s isCharFld like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1DTyp = 'A' or                                           // Alpha
  i_fldl0100.f1DTyp = 'G');                                             // Graphic
    isCharFld = bTrue;
  else;
    isCharFld = bFalse;
  endif;

  return isCharFld;

end-proc;

//===================================================================*
//  Funktion:  f_hasCcsid                                 (Body)     *
//===================================================================*

dcl-proc f_hasCcsid export;
  dcl-pi *n like(bool_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  //  Funktionswert
  dcl-s hasCcsid like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1fdcc > 0 and
  i_fldl0100.f1fdcc <> 65535);
    hasCcsid = bTrue;
  else;
    hasCcsid = bFalse;
  endif;

  return hasCcsid;

end-proc;

//===================================================================*
//  Funktion:  f_appMsgF                                  (Body)     *
//===================================================================*

dcl-proc f_appMsgF export;
  dcl-pi *n like(file_t);
  end-pi;
  //------------------------------------------------------------*

  return 'PEEKGER';

end-proc;

//===================================================================*
//  Funktion:  f_appMsgFL                                 (Body)     *
//===================================================================*

dcl-proc f_appMsgFL export;
  dcl-pi *n like(lib_t);
  end-pi;
  //------------------------------------------------------------*

  return '*LIBL';

end-proc;

//===================================================================*
//  Prozedur:  p_rmvPgmMg                                 (Body)     *
//===================================================================*

dcl-proc p_rmvPgmMg export;
  dcl-pi *n;
    i_pgm like(pgm_t) const;
  end-pi;

  //  Parameter für QMHRMVPM API
  dcl-s stackCount like(int4_t) inz;
  dcl-s msgKey char(4) inz;

  dcl-ds errCode likeds(errCode_t) inz;

  dcl-ds qStackE qualified inz;
    mod like(mod_t);
    pgm like(pgm_t);
  end-ds;
  //------------------------------------------------------------*

  if (i_pgm = '*');
    stackCount = 1;
    qStackE.mod   = '*NONE';
    qStackE.pgm   = '*NONE';
  else;
    stackCount = 0;
    qStackE.mod   = i_pgm;
    qStackE.pgm   = i_pgm;
  endif;

  msgKey = '';

  reset errCode;
  errCode.bytPrv = %size(errCode);

  qmhrmvpm(i_pgm: stackCount: msgKey: '*ALL': errCode: %size(i_pgm): qStackE: '*NO');

end-proc;

//===================================================================*
//  Prozedur:  p_sndPgmMg                                 (Body)     *
//===================================================================*

dcl-proc p_sndPgmMg export;
  dcl-pi *n;
    i_msgID   like(msgId_t) const;
    i_msgDta  like(msgDta_t) const;
    i_pgmName like(pgm_t) const;
    i_msgType like(msgType_t) options(*nopass) const;
  end-pi;

  dcl-ds qMsgF likeds(qObj_t) inz;

  dcl-s msgType char(10) inz;
  dcl-s stackE like(proc_t) inz;
  dcl-s stackCount like(int4_t) inz;
  dcl-s msgKey char(4) inz;

  dcl-ds qStackE qualified;
    module like(mod_t) inz;
    pgm    like(pgm_t) inz;
  end-ds;

  dcl-ds errCode likeds(errCode_t) inz;
  //------------------------------------------------------------*

  if (i_msgID <> '');

    if (%subst(i_msgID: 1: 3) = 'AID' or
    %subst(i_msgID: 1: 3) = 'KEY' or
    %subst(i_msgID: 1: 3) = 'MBX' or
    %subst(i_msgID: 1: 3) = 'TXT' or
    %subst(i_msgID: 1: 3) = 'USR');
      qMsgF.name = f_appMsgF;
      qMsgF.lib = f_appMsgFL;
    else;
      qMsgF.name = 'QCPFMSG';
      qMsgF.lib = '*LIBL';
    endif;

    if (%parms() >= %parmnum(i_msgType));
      msgType = i_msgType;
    else;
      msgType = '*INFO';
    endif;

    select;
    when (i_pgmName = '*');
      stackE = i_pgmName;
      stackCount = 1;
    other;
      stackE = i_pgmName;
      stackCount = 0;
    endsl;

    reset errCode;
    errCode.bytPrv = %size(errCode);

    msgKey = '';
    qStackE.pgm = i_pgmName;
    qStackE.module = i_pgmName;

    qmhsndpm(i_msgID: qMsgF
    : i_msgDta: %size(i_msgDta): msgType: stackE: stackCount
    : msgKey: errCode: %size(stackE): qStackE
    : -1);

  endif;

end-proc;

//===================================================================*
//  Funktion:  f_canUseRefFld                             (Body)     *
//===================================================================*

dcl-proc f_canUseRefFld export;
  dcl-pi *n like(bool_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  //  Funktionswert
  dcl-s canUseRefFld like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1DTyp = 'G' or
  (i_fldl0100.f1DTyp = 'A' and
  (i_fldl0100.f1fdcc = 1200 or
  i_fldl0100.f1fdcc = 1208)));
    canUseRefFld = bFalse;
  else;
    canUseRefFld = bTrue;
  endif;

  return canUseRefFld;

end-proc;

//===================================================================*
//  Funktion:  f_canUseCntFld                             (Body)     *
//===================================================================*

dcl-proc f_canUseCntFld export;
  dcl-pi *n like(bool_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  //  Funktionswert
  dcl-s canUseCntFld like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1DTyp = 'G' or
  (i_fldl0100.f1DTyp = 'A' and
  (i_fldl0100.f1fdcc = 1200 or
  i_fldl0100.f1fdcc = 1208)));
    canUseCntFld = bFalse;
  else;
    canUseCntFld = bTrue;
  endif;

  return canUseCntFld;

end-proc;

//===================================================================*
//  Funktion:  f_mustCvtCcsid                             (Body)     *
//===================================================================*

dcl-proc f_mustCvtCcsid export;
  dcl-pi *n like(bool_t);
  end-pi;

  dcl-ds jobi0400 likeds(jobi0400_t);
  // ----------------------------------------------------------------------

  if (g_jobCcsid = 0);
    qusrjobi(jobi0400: %size(jobi0400): 'JOBI0400': '*': '');
    g_jobCcsid = jobi0400.ccsid;
  endif;

  if (g_jobCcsid = 65535); // Job CCSID = *HEX
    return bTrue;
  endif;

  return bFalse;

end-proc;

//===================================================================*
//  Funktion:  f_isToLong                                 (Body)     *
//===================================================================*

dcl-proc f_isToLong export;
  dcl-pi *n like(bool_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  //  Funktionswert
  dcl-s toLong like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (f_dsplyLn(i_fldl0100)>f_maxDspLn(i_fldl0100));
    toLong = bTrue;
  else;
    toLong = bFalse;
  endif;

  return toLong;

end-proc;

//===================================================================*
//  Funktion:  f_isToLongMax                              (Body)     *
//===================================================================*

dcl-proc f_isToLongMax export;
  dcl-pi *n like(bool_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  //  Funktionswert
  dcl-s toLong like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (f_buffLn(i_fldl0100) > 1024);
    toLong = bTrue;
  else;
    toLong = bFalse;
  endif;

  return toLong;

end-proc;

//===================================================================*
//  Funktion:  f_maxDspLn                                 (Body)     *
//===================================================================*

dcl-proc f_maxDspLn export;
  dcl-pi *n like(int4_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  dcl-s maxLen int(10) inz;
  //------------------------------------------------------------*

  maxLen =  %int(f_cntFldLn(i_fldl0100) * 15);
  if (maxLen > 512);
    maxLen = 512;
  endif;

  return maxLen;

end-proc;

//===================================================================*
//  Funktion:  f_cntFldLn                                 (Body)     *
//===================================================================*

dcl-proc f_cntFldLn export;
  dcl-pi *n like(int4_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;
  //------------------------------------------------------------*

  if (i_fldl0100.f1DTyp = 'G');
    return 34;
  else;
    return 35;
  endif;

end-proc;

//===================================================================*
//  Funktion:  f_nbrDspRw                                 (Body)     *
//===================================================================*

dcl-proc f_nbrDspRw export;
  dcl-pi *n like(int4_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  // Funktionswert
  dcl-s nbrDspRow like(int4_t) inz;

  // Arbeitsfelder
  dcl-s dsplyLen like(int4_t);
  //------------------------------------------------------------*

  if (f_isToLong(i_fldl0100) = bTrue);
    dsplyLen = f_maxDspLn(i_fldl0100);
  else;
    dsplyLen = f_dsplyLn(i_fldl0100);
  endif;

  nbrDspRow = dsplyLen / f_cntFldLn(i_fldl0100);

  if (dsplyLen <>
  (nbrDspRow * f_cntFldLn(i_fldl0100)));
    nbrDspRow = nbrDspRow + 1;
  endif;

  return nbrDspRow;

end-proc;

//===================================================================*
//  Prozedur:  p_decToBin                                 (Body)     *
//===================================================================*

dcl-proc p_decToBin export;
  dcl-pi *n opdesc;
    io_string  char(32767) options(*varsize);
    i_startPos like(int4_t) const;
    i_length   like(int4_t) const;
    i_value    like(int4_t) const;
  end-pi;

  // Parameters passed to CEEDOD
  dcl-s descType int(10);
  dcl-s dataType int(10);
  dcl-s descInfo1 int(10);
  dcl-s descInfo2 int(10);
  dcl-s parmLen int(10);

  // Arbeitsfelder
  dcl-ds *n;
    intValue like(int4_t) inz;
    alpha2   char(2) overlay(intValue: 3);
    alpha4   char(2) overlay(intValue: 1);
  end-ds;
  // ------------------------------------------------------------------------

  ceedod(1         : descType : dataType :
  descInfo1 : descInfo2: parmLen  :
  *omit);

  if ((i_startPos + i_length - 1) > parmLen);
    p_kill('Start position and length outside range.');
  else;
    intValue = i_value;
    select;
    when (i_length = 2);
      %subst(io_string  :
        i_startPos :
        i_length   ) = alpha2;
    when (i_length = 4);
      %subst(io_string  :
        i_startPos :
        i_length   ) = alpha4;
    other;
      p_kill('Incorrect length: ' + %char(i_length));
    endsl;
  endif;

end-proc;

//===================================================================*
//  Funktion:  f_isNotAlw                                 (Body)     *
//===================================================================*

dcl-proc f_isNotAlw export;
  dcl-pi *n like(bool_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  // Funktionswert
  dcl-s notAllowed like(bool_t) inz(bTrue);
  // ------------------------------------------------------------------------

  //  Wenn es sich um einen der folgenden Feldtypen handelt, ...
  if (i_fldl0100.f1DTyp = 'A' or    // = Alpha
  i_fldl0100.f1DTyp = 'B' or    // = Binary
  i_fldl0100.f1DTyp = 'P' or    // = Packed
  i_fldl0100.f1DTyp = 'S' or    // = Zoned
  i_fldl0100.f1DTyp = 'L' or    // = Date
  i_fldl0100.f1DTyp = 'T' or    // = Time
  i_fldl0100.f1DTyp = 'Z' or    // = Timestamp
  i_fldl0100.f1DTyp = 'J' or    // = DBCS-Only
  i_fldl0100.f1DTyp = 'O' or    // = DBCS-Open
  i_fldl0100.f1DTyp = 'E' or    // = DBCS-Either
  i_fldl0100.f1DTyp = 'F' or    // = Float
  i_fldl0100.f1DTyp = 'G' or    // = Graphic
  i_fldl0100.f1DTyp = '8');     // = Boolean

    //  ... dann
    //      prüfen, ob es sich um ein GRAPHIC Feld ohne CCSID handelt
    if (i_fldl0100.f1DTyp = 'G' and f_hasCcsid(i_fldl0100) = bFalse);
      notAllowed = bTrue;
      return notAllowed;
    endif;

    //      prüfen, ob es sich um ein Packed oder Zoned Feld mit mehr als
    //      30 Stellen handelt.
    if (i_fldl0100.f1DTyp = 'P' or i_fldl0100.f1DTyp = 'S');
      if (i_fldl0100.f1Digt > 30);
        notAllowed = bTrue;
        return notAllowed;
      endif;
    endif;

    //      prüfen, ob es sich um ein Feld variabler Länge handelt.
    //      Wenn es sich um ein Feld variabler Länge handelt, ...
    if (f_isVarLen(i_fldl0100) = bTrue);
      //      ... dann
      //          prüfen, ob es sich um alpha-numerisches Feld handelt.
      if (i_fldl0100.f1DTyp = 'A' or                                      // = Alpha
      i_fldl0100.f1DTyp = 'G');                                        // = Graphic
        notAllowed = bFalse;
      else;
        notAllowed = bTrue;
      endif;
    else;
      //      ... sonst
      //          ist alles klar.
      notAllowed = bFalse;
    endif;
  else;
    //  ... sonst
    //      setzen Markierung für unbekannten Feldtyp
    notAllowed = bTrue;
  endif;

  return notAllowed;

end-proc;

//===================================================================*
//  Funktion:  f_isKeyFld                                 (Body)     *
//===================================================================*

dcl-proc f_isKeyFld export;
  dcl-pi *n like(bool_t);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  // Funktionswert
  dcl-s isKeyFld like(bool_t) inz(bFalse);
  // ------------------------------------------------------------------------

  //  Wenn es sich um ein Schlüsselfeld handelt, ...
  if (i_fldl0100.f1KeyF = '1');
    //  ... dann
    isKeyFld = bTrue;
  else;
    //  ... sonst
    isKeyFld = bFalse;
  endif;

  return isKeyFld;

end-proc;

//===================================================================*
//  Prozedur:  f_pgmCallN                                 (Body)     *
//===================================================================*

dcl-proc f_pgmCallN export;
  dcl-pi *n like(pgmCallN_t);
    i_pgmNme like(pgm_t) const;
    i_lib    like(lib_t) options(*nopass) const;
  end-pi;
  //------------------------------------------------------------*

  if (%parms() >= %parmnum(i_lib));
    return %trimr(i_lib) + '/' + i_pgmNme;
  else;
    return %trimr(f_getPrdLb()) + '/' + i_pgmNme;
  endif;

end-proc;

//===================================================================*
//  Prozedur:  p_sndStsMg                                 (Body)     *
//===================================================================*

dcl-proc p_sndStsMg export;
  dcl-pi *n;
    i_msgID  like(msgId_t) const;
    i_msgDta like(msgDta_t) const;
  end-pi;

  dcl-ds yQMsgF likeds(qObj_t) inz;

  dcl-s msgKey char(4) inz;

  dcl-ds errCode likeds(errCode_t) inz;
  //------------------------------------------------------------*

  if (i_msgID <> '');

    yQMsgF.name = f_appMsgF();
    yQMsgF.lib = f_appMsgFL();

    msgKey = '';

    reset errCode;
    errCode.bytPrv = %size(errCode);

    qmhsndpm(i_msgID: yQMsgF
    : i_msgDta: %size(i_msgDta): '*STATUS' : '*EXT'
    : 0 : msgKey : errCode );

  endif;

end-proc;

//===================================================================*
//  Prozedur:  f_rtvMsgD                                  (Body)     *
//===================================================================*

dcl-proc f_rtvMsgD export;
  dcl-pi *n char(2048);
    i_msgID    like(msgId_t) value;
    i_msgDta   like(msgDta_t) value;
    i_rplcSubV like(bool_t) options(*nopass) const;
    i_rtnFmtCC like(bool_t) options(*nopass) const;
    i_msgF     like(file_t) options(*nopass) value;
    i_msgFL    like(lib_t) options(*nopass) value;
  end-pi;

  //  Funktionswert
/copy QCOPYLE,RTVM0100

  //  Parameter für QMHSNDPM
  dcl-s msgDLen int(10) inz;
  dcl-s format char(8) inz;
  dcl-ds qMsgF;
    msgF  like(file_t) inz;
    msgFL like(lib_t) inz;
  end-ds;
  dcl-s msgDtaLn int(10) inz;
  dcl-s rplcSubV char(10) inz;
  dcl-s rtnFmtCC char(10) inz;
  dcl-ds errCode likeds(errCode_t) inz;

  //------------------------------------------------------------*

  clear rtvm0100;
  msgDLen  = %len(rtvm0100);
  format   = 'RTVM0100';

  if (%parms() >= %parmnum(i_msgF));
    msgF  = i_msgF;
  else;
    msgF  = f_appMsgF;
  endif;

  if (%parms() >= %parmnum(i_msgFL));
    msgFL = i_msgFL;
  else;
    msgFL = f_appMsgFL;
  endif;

  msgDtaLn = %len(i_msgDta);

  //  Replace substitution variables
  if (%parms() >= %parmnum(i_rplcSubV));
    if (i_rplcSubV = bTrue);
      rplcSubV = '*YES';
    else;
      rplcSubV = '*NO';
    endif;
  else;
    rplcSubV = '*NO';
  endif;

  //  Return format control characters
  if (%parms() >= %parmnum(i_rtnFmtCC));
    if (i_rtnFmtCC = bTrue);
      rtnFmtCC = '*YES';
    else;
      rtnFmtCC = '*NO';
    endif;
  else;
    rtnFmtCC = '*NO';
  endif;

  reset errCode;
  errCode.bytPrv = %size(errCode);

  qmhrtvm ( rtvm0100 : msgDLen : format :
  i_msgID : qMsgF : i_msgDta : msgDtaLn :
  rplcSubV : rtnFmtCC : errCode );

  return rtvm0100;

end-proc;

//===================================================================*
//  Prozedur:  f_msgText                                  (Body)     *
//===================================================================*

dcl-proc f_msgText export;
  dcl-pi *n char(512);
    i_msgID  like(msgId_t) value;
    i_msgDta like(msgDta_t) value;
    i_msgF   like(file_t) options(*nopass) value;
    i_msgFL  like(lib_t) options(*nopass) value;
  end-pi;

  //  Funktionswert
  dcl-s msgText char(512) inz;

/copy QCOPYLE,RTVM0100
  //------------------------------------------------------------*

  select;
  when (%parms() = %parmnum(i_msgF));
    rtvm0100 = f_rtvMsgD(i_msgID: i_msgDta: bTrue: bFalse: i_msgF);
  when (%parms() =  %parmnum(i_msgFL));
    rtvm0100 = f_rtvMsgD(i_msgID: i_msgDta: bTrue: bFalse: i_msgF: i_msgFL);
  other;
    rtvm0100 = f_rtvMsgD(i_msgID: i_msgDta: bTrue: bFalse);
  endsl;

  if (rt1_lnMgRt > 0);
    msgText = %subst(rt1_data: 1: rt1_lnMgRt);
  else;
    msgText = ' ';
  endif;

  return msgText;

end-proc;

//===================================================================*
//  Prozedur:  p_movPgmMg                                 (Body)     *
//===================================================================*

dcl-proc p_movPgmMg export;
  dcl-pi *n;
    i_pgmNme like(pgm_t) const;
  end-pi;

  dcl-s msgKey char(4) inz;
  dcl-s typesToMove char(10) dim(4);

  dcl-ds errCode likeds(errCode_t) inz;

  dcl-ds toQStackE qualified;
    module like(mod_t) inz;
    pgm    like(pgm_t) inz;
  end-ds;
  //------------------------------------------------------------*

  toQStackE.module = i_pgmNme;
  toQStackE.pgm = i_pgmNme;

  typesToMove(1) = '*COMP';
  typesToMove(2) = '*DIAG';
  typesToMove(3) = '*INFO';
  typesToMove(4) = '*ESCAPE';

  qmhmovpm(msgKey: typesToMove
  : %elem(typesToMove) : i_pgmNme : 2 : errCode
  : %len(%trimr(i_pgmNme)) : toQStackE : '*CHAR' : *null: 1);

end-proc;

//===================================================================*
//  Prozedur:  p_wrongKey                                 (Body)     *
//===================================================================*

dcl-proc p_wrongKey export;
  dcl-pi *n;
    i_scnAID like(scnAID_t) const;
    i_pgmNme like(pgm_t) const;
  end-pi;

  //  Arbeitsfelder
  dcl-ds *n;
    msgID  like(msgId_t) inz('AID');
    msgNbr char(4) overlay(msgID: 4);
  end-ds;
  dcl-s msgDta like(msgDta_t) inz;
  //------------------------------------------------------------*

  p_keyToMsg(i_scnAID: msgID: msgDta);
  p_sndPgmMg(msgID: msgDta: i_pgmNme);

end-proc;

//===================================================================*
//  Prozedur:  p_keyToMsg                                 (Body)     *
//===================================================================*

dcl-proc p_keyToMsg export;
  dcl-pi *n;
    i_scnAID like(scnAID_t) const;
    o_msgID  like(msgId_t);
    o_msgDta like(msgDta_t);
  end-pi;

  //  Arbeitsfelder
  dcl-ds *n;
    msgID  like(msgId_t) inz;
    msgNbr char(4) overlay(msgID: 4);
  end-ds;
  dcl-s msgDta like(msgDta_t) inz;
  //------------------------------------------------------------*

  msgID  = 'AID';
  msgDta = ' ';

  select;
  when (i_scnAID = k_f1);
    msgNbr   = '0031';
  when (i_scnAID = k_f2);
    msgNbr   = '0032';
  when (i_scnAID = k_f3);
    msgNbr   = '0033';
  when (i_scnAID = k_f4);
    msgNbr   = '0034';
  when (i_scnAID = k_f5);
    msgNbr   = '0035';
  when (i_scnAID = k_f6);
    msgNbr   = '0036';
  when (i_scnAID = k_f7);
    msgNbr   = '0037';
  when (i_scnAID = k_f8);
    msgNbr   = '0038';
  when (i_scnAID = k_f9);
    msgNbr   = '0039';
  when (i_scnAID = k_f10);
    msgNbr   = '003A';
  when (i_scnAID = k_f11);
    msgNbr   = '003B';
  when (i_scnAID = k_f12);
    msgNbr   = '003C';
  when (i_scnAID = k_f13);
    msgNbr   = '00B1';
  when (i_scnAID = k_f14);
    msgNbr   = '00B2';
  when (i_scnAID = k_f15);
    msgNbr   = '00B3';
  when (i_scnAID = k_f16);
    msgNbr   = '00B4';
  when (i_scnAID = k_f17);
    msgNbr   = '00B5';
  when (i_scnAID = k_f18);
    msgNbr   = '00B6';
  when (i_scnAID = k_f19);
    msgNbr   = '00B7';
  when (i_scnAID = k_f20);
    msgNbr   = '00B8';
  when (i_scnAID = k_f21);
    msgNbr   = '00B9';
  when (i_scnAID = k_f22);
    msgNbr   = '00BA';
  when (i_scnAID = k_f23);
    msgNbr   = '00BB';
  when (i_scnAID = k_f24);
    msgNbr   = '00BC';
  when (i_scnAID = k_delete);
    msgNbr   = '00BD';
  when (i_scnAID = k_enter);
    msgNbr   = '00F1';
  when (i_scnAID = k_help);
    msgNbr   = '00F3';
  when (i_scnAID = k_page_down);
    msgNbr   = '00F4';
  when (i_scnAID = k_page_up);
    msgNbr   = '00F5';
  when (i_scnAID = k_print_screen);
    msgNbr   = '00F6';
  when (i_scnAID = k_reset);
    msgNbr   = '00F8';
  when (i_scnAID = k_light_pen);
    msgNbr   = '003F';
  other;
    msgNbr   = '0100';
  endsl;

  o_msgID  = msgID;
  o_msgDta = msgDta;

end-proc;

//===================================================================*
//  Prozedur:  f_spltTxt                                  (Body)     *
//===================================================================*

dcl-proc f_splttxt_deprecated export;
  dcl-pi *n opdesc like(int4_t);
    i_text   like(varString_t) options(*varsize) const;
    i_strPos like(int4_t) const;
    i_len    like(int4_t) const;
    o_text   like(string_t) options(*varsize);
  end-pi;

  //  Funktionswert
  dcl-s rtnLen like(int4_t) inz;

  //  Arbeitsfelder
  dcl-s pNewLine like(int4_t) inz;
  dcl-s nextChar char(1) inz;
  dcl-s trimLen like(int4_t) inz;
  //------------------------------------------------------------*

  //  Wenn die Startposition außerhalb des gültigen
  //  Bereichs liegt, ...
  if (i_strPos > %len(i_text));
    //  ... dann
    //      einen Leerstring zurück geben
    %subst(o_text: 1: %len(o_text)) = ' ';
    rtnLen = 0;
  else;
    //  ... sonst
    //      prüfen zu entnehmende Länge
    if ((i_strPos + i_len - 1) <= %len(i_text));
      rtnLen = i_len;
    else;
      rtnLen = %len(i_text) - i_strPos + 1;
    endif;

    if (rtnLen > %len(o_text));
      rtnLen = %len(o_text);
    endif;

    //      Zeichenkette entnehmen
    %subst(o_text: 1: %len(o_text)) =
    %subst(i_text: i_strPos: rtnLen);

    //      Auf Zeilenwechsel prüfen
    pNewLine = %scan('°': %subst(o_text: 1: %len(o_text)));
    if (pNewLine > 0);
      rtnLen = pNewLine;
      %subst(o_text: rtnLen: %len(o_text) - rtnLen + 1) = '';
    endif;

    //      Bestimmen Länge ohne nachgestellte Leezeichen
    trimLen = %len(%trimr(%subst(o_text: 1: rtnLen)));

    // Wenn keine nachgestellten Leezeichen
    // vorhanden sind, ...
    if (rtnLen = trimLen);
      // ... dann
      //     Folgezeichen im Eingabestring prüfen
      if (%len(i_text) > rtnLen);
        nextChar = %subst(i_text: rtnLen + 1: 1);

        // Wenn das Folgezeichen <> ' ' ist, d.h.
        // wir befinden uns mitten in der Zeichenkette, ...
        if ((nextChar <> ' ') and (nextChar <> '°'));
          // ... dann
          //     rückwärts nach einer Lücke für
          //     den Zeilenumbruch suchen
          dow (trimLen > 0);
            if (%subst(o_text: trimLen: 1) = ' ');
              rtnLen = trimLen;
              %subst(o_text: 1: %len(o_text)) =
              %subst(o_text: 1: rtnLen);
              leave;
            endif;
            trimLen = trimLen - 1;
          enddo;

        endif;
      endif;
    endif;
  endif;

  return rtnLen;

end-proc;

//===================================================================*
//  Prozedur:  f_center                                   (Body)     *
//===================================================================*

dcl-proc f_center export;
  dcl-pi *n like(varString_t) opdesc;
    i_text like(varString_t) options(*varsize) const;
  end-pi;

  // Funktionswert
  dcl-s text like(varString_t);

  //  Arbeitsfelder
  dcl-s numSpaces like(int4_t) inz;
  //------------------------------------------------------------*

  text = %triml(i_text);
  numSpaces = %int((%len(i_text) - %len(%trimr(i_text))) / 2);

  if (numSpaces > 0);
    text = f_space(numSpaces) + text;
  endif;

  return text;

end-proc;

//===================================================================*
//  Prozedur:  f_addPtr                                   (Body)     *
//===================================================================*

dcl-proc f_addPtr export;
  dcl-pi *n pointer;
    i_pointer pointer value;
    i_offset  int(5) value;
  end-pi;

  //  Arbeitsfelder
  dcl-s ofsAry char(1) dim(32767) based(pOfsAry);
  //------------------------------------------------------------*

  dow (i_offset > 0);

    pOfsAry = i_pointer;

    if (i_offset <= %elem(ofsAry) - 1);
      i_pointer = %addr(ofsAry(i_offset + 1));
      i_offset = 0;
    else;
      i_pointer = %addr(ofsAry(%elem(ofsAry)));
      i_offset = i_offset - %elem(ofsAry) + 1;
    endif;

  enddo;

  return i_pointer;

end-proc;

//===================================================================*
//  Prozedur:  f_isKeyExc                                 (Body)     *
//===================================================================*

dcl-proc f_isKeyExc export;
  dcl-pi *n like(bool_t);
    i_data     like(set0000_t) value;
    i_exclKeys like(pgmCmd_t) dim(25) value;
  end-pi;

  //  Funktionswert
  dcl-s isExcluded like(bool_t) inz;

  //  Arbeitsfelder
  dcl-s pgmCmd like(pgmCmd_t) inz;
  dcl-s in01 like(*in01) inz;
  //------------------------------------------------------------*

  in01 = *in01;

  pgmCmd = i_data;
  if (%lookup(pgmCmd: i_exclKeys) > 0);
    isExcluded = bTrue;
  else;
    isExcluded = bFalse;
  endif;

  *in01 = in01;

  return isExcluded;

end-proc;

//===============================================================*
//  Prepare num_descr - RPG-IV implementation of NUM_DESCR macro
//  V4R4 and above                Refer to: QSYSINC/MIH.MICPTCOM
//===============================================================*
// The following macro is used to prepare the numeric descriptor
// (_NUM_Descr_T), used in the cpynv and edit functions. Can also
// be used to set the type and length fields of _DPA_Template_T.
// The valid values for the parameters are:
//    type         length             fractional
//    -----------  -----------------  -------------------------
//    _T_Signed    2 or 4             0
//    _T_Float     4 or 8             0
//    _T_Zoned     1 <= length <= 31  0 <= fractional <= length
//    _T_Packed    1 <= length <= 31  0 <= fractional <= length
//    _T_Unsigned  2 or 4             0

//===============================================================*

dcl-proc f_num_descr export;
  dcl-pi *n like(int4_t);
    i_type     like(int1_t) value;
    i_length   like(int1_t) value;
    i_fraction like(int1_t) value;
  end-pi;

  dcl-ds *n;
    num_descr          int(10) inz;
    num_descr_type     int(3) overlay(num_descr: 1);
    num_descr_fraction int(3) overlay(num_descr: 2);
    num_descr_length   int(3) overlay(num_descr: 3);
  end-ds;

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  num_descr_type     = i_type;
  num_descr_fraction = i_fraction;
  num_descr_length   = i_length;

  return num_descr;

end-proc;

//========================================================================*
//  f_num_descr2
//========================================================================*
dcl-proc f_num_descr2 export;
  dcl-pi *n like(int4_t);
    i_type       like(dataType_t) value;
    i_length     like(int1_t) value;
    i_fractional like(int1_t) value;
  end-pi;

  //  Parameter positions

  //  Return value
  dcl-ds *n;
    num_descr    int(10) inz;
    num_descr_24 int(3) overlay(num_descr: 1);
    num_descr_16 int(3) overlay(num_descr: *next);
    num_descr_8  int(3) overlay(num_descr: *next);
    num_descr_0  int(3) overlay(num_descr: *next);
  end-ds;

  //  Arbeitsfelder
  dcl-s type int(3) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  // Convert RPG type ...
  select;
  // ... zoned
  when (i_type = 'S');
    type = T_Zoned;
  // ... packed
  when (i_type = 'P');
    type = t_packed;
  // ... binary
  when (i_type = 'B');
    type = T_Signed;
    i_length = f_rpgToIntLength(i_length);
  // ... integer
  when (i_type = 'I');
    type = T_Signed;
    i_length = f_rpgToIntLength(i_length);
  // ... unsigned integer
  when (i_type = 'U');
    type = T_Signed;
    i_length = f_rpgToIntLength(i_length);
  // ... float
  when (i_type = 'F');
    type = t_float;
  endsl;

  num_descr = f_num_descr(type: i_length: i_fractional);

  return num_descr;


end-proc;

//========================================================================*
//  Converts a given RPG numeric field length to an integer length.
//========================================================================*
dcl-proc f_rpgToIntLength export;
  dcl-pi *n int(10);
    i_length int(10) value;
  end-pi;

  //  Return value
  dcl-s intLength int(10) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  select;
  when (i_length <= 3);
    intLength = 1;
  when (i_length <= 5);
    intLength = 2;
  when (i_length <= 10);
    intLength = 4;
  when (i_length <= 20);
    intLength = 8;
  other;
    intLength = -1;
  endsl;

  return intLength;


end-proc;

//===============================================================*
//  Clears C error code.
//===============================================================*

dcl-proc p_clrErrno export;
  dcl-pi *n;
  end-pi;

  dcl-s runTimeError int(10) based(pRunTimeError);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  pRunTimeError = errno();
  runTimeError = 0;

end-proc;

//===============================================================*
//  Returns C runtime error code.
//===============================================================*

dcl-proc f_errno export;
  dcl-pi *n int(10);
  end-pi;

  dcl-s runTimeError int(10) based(pRunTimeError);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  pRunTimeError = errno();

  return runTimeError;

end-proc;

//===============================================================*
//  Returns the description of a given C runtime error code.
//===============================================================*

dcl-proc f_strError export;
  dcl-pi *n like(msgDta_t);
    i_errno int(10) const;
  end-pi;

  //  Funktionswert
  dcl-s errText like(msgDta_t) inz;

  dcl-s pErrText pointer inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  pErrText = strerror(i_errno);
  if (pErrText = *null);
    errText = '';
  else;
    errText = %str(pErrText);
  endif;

  return errText;

end-proc;

//===============================================================*
//  Returns the bit-wise ORing of the bits of all the arguments.
//===============================================================*

dcl-proc f_bitor export;
  dcl-pi *n uns(10);
    i_arg1 uns(10) value;
    i_arg2 uns(10) value;
    i_arg3 uns(10) options(*nopass) value;
    i_arg4 uns(10) options(*nopass) value;
    i_arg5 uns(10) options(*nopass) value;
  end-pi;

  //  Funktionswert
  dcl-s result uns(10) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  result = %bitor(i_arg1: i_arg2);

  if (%parms() >= %parmnum(i_arg3));
    result = %bitor(result: i_arg3);
  endif;

  if (%parms() >= %parmnum(i_arg4));
    result = %bitor(result: i_arg4);
  endif;

  if (%parms() >= %parmnum(i_arg5));
    result = %bitor(result: i_arg5);
  endif;

  return result;

end-proc;

//=========================================================================
//  Checks object existance.
//=========================================================================
//  Parameters:
//   i_obj         - The object to check for existance.
//   i_lib         - The library that contains the object.
//                   Default:        *LIBL
//   i_type        - The type of the object.
//   i_mbr         - The member that is checked in case of that
//                   the object is a file.
//                   Default:        *NONE

//  Returns:
//   doesExists    - Returns bTrue when the object exists.
//=========================================================================
dcl-proc f_exist export;
  dcl-pi *n ind;
    i_obj    char(10) const;
    i_lib    char(10) options(*omit) const;
    i_type   char(10) const;
    i_mbr    char(10) options(*omit: *nopass) const;
    o_msgID  like(msgId_t) options(*omit: *nopass);
    o_msgDta like(msgDta_t) options(*omit: *nopass);
  end-pi;

  //  Return value
  dcl-s doesExist ind inz(bFalse);

  //  Optional parameter fields
  dcl-s lib like(i_lib) inz;
  dcl-s mbr like(i_mbr) inz;
  dcl-s msgID like(o_msgID);
  dcl-s msgDta like(o_msgDta);

  //  Local fields
  dcl-ds objd0100 likeds(objd0100_t) inz;
  dcl-ds mbrd0100 likeds(mbrd0100_t) inz;
  dcl-ds qObj likeds(qObj_t) inz;
  dcl-ds errCode likeds(errCode_t) inz;

/include QCOPYLE,CPF9801
/include QCOPYLE,CPF9815
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  // Process optional parameter values ...
  // ... i_lib
  if (%parms() >= %parmnum(i_lib) and %addr(i_lib) <> *null);
    lib = i_lib;
  else;
    lib = '*LIBL';
  endif;

  // ... i_mbr
  if (%parms() >= %parmnum(i_mbr) and %addr(i_mbr) <> *null);
    mbr = i_mbr;
  else;
    mbr = '*NONE';
  endif;

  msgID = '';
  msgDta = '';

  dou (*on);

    // Retrieve the object description
    qObj.name = i_obj;
    qObj.lib  = lib;
    reset errCode;
    errCode.bytPrv = %size(errCode);

    qusrobjd(objd0100: %size(objd0100): 'OBJD0100': qObj: i_type: errCode);
    if (errCode.bytAvl > 0);
      clear CPF9801; // Object &2 in library &3 not found.
      CPF9801.var2 = qObj.name;
      CPF9801.var3 = qObj.lib;
      CPF9801.var5 = i_type;
      msgID = 'CPF9801';
      msgDta = CPF9801;
      leave;
    endif;

    // Retrieve member description if object is a file
    // and a member name was given
    if ((errCode.bytAvl = 0) and (mbr <> '*NONE'));
      reset errCode;
      errCode.bytPrv = %size(errCode);
      qusrmbrd(mbrd0100: %size(mbrd0100): 'MBRD0100': qObj: mbr: '0': errCode);
      if (errCode.bytAvl > 0);
        clear CPF9815; // Object &2 in library &3 not found.
        CPF9815.var2 = qObj.name;
        CPF9815.var3 = qObj.lib;
        CPF9815.var5 = mbr;
        msgID = 'CPF9815';
        msgDta = CPF9815;
        leave;
      endif;
    endif;

  enddo;

  // Set return value
  if (errCode.bytAvl = 0);
    doesExist = bTrue;
  else;
    doesExist = bFalse;
  endif;

  if (%parms() >= %parmnum(o_msgID) and %addr(o_msgID) <> *null);
    o_msgID = msgID;
  endif;

  if (%parms() >= %parmnum(o_msgDta) and %addr(o_msgDta) <> *null);
    o_msgDta = msgDta;
  endif;

  return doesExist;

end-proc;

//=========================================================================
//  Performs word wrapping on a given string.
//  Returns the next line of i_string with each call to f_wordWrap().
//=========================================================================
//  Parameters:
//   i_string      - The string to be word wrapped.
//   i_width       - Line length.
//   io_startPos   - The position to start from.
//                   (Should not be changed between calls.)
//   i_option      - Options to set.
//                   Default:        cWORDWRAP_paragraph_none +
//                                   cWORDWRAP_paragraph_trimr
//                   cWORDWRAP_paragraph_none   Do not respect
//                                              end-of-paragraph markers.
//                   cWORDWRAP_paragraph_msgd   Respect end-of-paragraph
//                                              markers of message descriptions:
//                                              &N, &B and &P.
//                   cWORDWRAP_paragraph_text   Respect standard text
//                                              end-of-paragraph markers: \n
//                   cWORDWRAP_paragraph_trimr  Remove trailing blanks from
//                                              result string.

//  Returns:
//   text          - The next line of i_string.
//=========================================================================

dcl-proc f_wordWrap export;
  dcl-pi *n varchar(4096);
    i_string    varchar(4096) const;
    i_width     uns(10) const;
    io_startPos uns(10);
    i_options   uns(10) options(*nopass) const;
  end-pi;

  //  Return value
  dcl-s text varchar(4096) inz;

  //  Optional parameter fields
  dcl-s options like(i_options) inz;

  //  Local fields
  dcl-ds theEOP qualified;
    isFound  ind inz(bFalse);
    position int(10);
    string   varchar(2);
  end-ds;
  dcl-s x int(10) inz;
  dcl-s tmpEOP varchar(2) inz;
  dcl-s numEOP int(10) inz;
  dcl-s eop like(tmpEOP) dim(3) inz;
  dcl-s esc char(1);
  dcl-s startPos like(io_startPos) inz;
  dcl-s string like(i_string) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  // Process optional parameter values ...
  // ... options
  if (%parms() >= %parmnum(i_options));
    options = i_options;
  else;
    options = cWORDWRAP_PARAGRAPH_NONE +
      cWORDWRAP_PARAGRAPH_TRIMR;
  endif;

  // TRIM trailing blanks
  string = %trimr(i_string);

  // Determine how to treat end-of-paragraph markers:
  select;
  // ... do not respect end-of-paragraph marker
  when (isBitOn(cWORDWRAP_PARAGRAPH_NONE: options));
    clear eop;
    clear esc;
    numEOP = 0;
  // ... respect end-of-paragraph marker of message descriptions: &N, &P, &B
  when (isBitOn(cWORDWRAP_PARAGRAPH_MSGD: options));
    clear eop;
    eop(1) = '&N';
    eop(2) = '&P';
    eop(3) = '&B';
    esc    = '&';
    numEOP = 3;
  // ... respect end-of-paragraph marker of text: \n
  when (isBitOn(cWORDWRAP_PARAGRAPH_TEXT: options));
    clear eop;
    eop(1) = '\N';
    esc    = '\';
    numEOP = 1;
  endsl;

  // ---------------------------------------------------
  //  Perform word-wrap with no respect to
  //  end-of-paragraph markers.
  // ---------------------------------------------------
  if (numEOP = 0);
    text = lf_wordWrap(string: i_width: io_startPos);
  else;
    // ---------------------------------------------------
    //  Perform word-wrap with respect to
    //  end-of-paragraph markers.
    // ---------------------------------------------------

    // Find next end-of-paragraph marker
    reset theEOP;
    theEOP.isFound = bFalse;
    theEOP.position = %scan(esc: string: io_startPos);
    dow (not theEOP.isFound and theEOP.position > 0);
      // If there is an escape character, ...
      if (%subst(string: theEOP.position: 1) = esc);
        // ... then check it against the list of EOP marker
        for x = 1 to numEOP;
          // If there is enough space for a EOP after the escape character
          // and if it is a known EOP, ...
          if (theEOP.position <= %len(string) - %len(eop(x)) + 1);
            tmpEOP = %subst(string: theEOP.position: %len(eop(x)));
            if (f_ucase(tmpEOP) = f_ucase(eop(x)));
              // ... then set flag "EOP found"
              theEOP.string  = eop(x);
              theEOP.isFound = bTrue;
              leave;
            endif;
          endif;
        endfor;
      endif;

      if (not theEOP.isFound);
        if (theEOP.position < %len(string));
          theEOP.position = %scan(esc: string: theEOP.position + 1);
        else;
          theEOP.position = 0;
        endif;
      endif;
    enddo;

    // If no end-of-paragraph marker is found, ...
    if (not theEOP.isFound);
      // ... then perform standard word wrap with no respect to EOP
      text = lf_wordWrap(string: i_width: io_startPos);
    else;
      // ... else perform word wrap for text portion
      //     before end-of-paragraph marker
      if ((theEOP.position - io_startPos) > 0);
        string   = %subst(string: io_startPos:
          theEOP.position - io_startPos);
        startPos = 1;
        text = lf_wordWrap(string: i_width: startPos);
      else;
        text = '';
      endif;

      // If all we got is a EOP, ...
      if ((%len(text)    = %len(theEOP.string)   ) and
      (f_ucase(text) = f_ucase(theEOP.string)));
        // ... then delete it
        text = '';
      endif;
      // Set new start position. Skip EOP if EOP
      // caused new line.
      io_startPos = io_startPos + %len(text);
      if (theEOP.position = io_startPos);
        io_startPos = io_startPos + %len(theEOP.string);
      endif;
      // Set start position to 0 if new start position
      // exceeds maximum length of text.
      if (io_startPos > %len(i_string));
        io_startPos = 0;
      endif;
    endif;

  endif;

  // If the user requested to remove BLANKS, ...
  if (isBitOn(cWORDWRAP_PARAGRAPH_TRIMR: options));
    // ... then remove BLANKS.
    text = %trimr(text);
  endif;

  return   text;

end-proc;

//=========================================================================
//  Performs word wrapping on a given string without respect to
//  end-of-paragraph markers.
//=========================================================================

dcl-proc lf_wordWrap;
  dcl-pi *n varchar(4096);
    i_string    varchar(4096) const;
    i_width     uns(10) const;
    io_startPos uns(10);
  end-pi;

  //  Return value
  dcl-s text varchar(4096) inz;

  //  Local fields
  dcl-s sPos int(10) inz;
  dcl-s ePos int(10) inz;
  dcl-s ePosConst int(10) inz;
  dcl-s length int(10) inz;
  dcl-s char char(1) inz;
  dcl-s x int(10) inz;

  //  Valid separater characters
  dcl-c cDELIMITER ' -/\.:';
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  // Initialise helper fields
  text   = '';
  sPos   = io_startPos;
  ePos   = 0;
  length = 0;

  // Set range
  ePos      = sPos + i_width;
  ePosConst = ePos;

  // If the end position is out of range ...
  if   (ePos > %len(i_string));
    // ... then
    //     assume the last character to be the delimiter
    ePos = %len(i_string);
  else;
    // ... else
    //     look backwards for a deliniter.
    dow   (ePos >= sPos);
      char = %subst(i_string: ePos: 1);
      // At position width + 1 ...
      if (ePos = ePosConst);
        // ... only BLANKS are allowed
        x = %check(' ': char);
      else;
        // ... else every delimiter is allowed
        x = %check(cDELIMITER: char);
      endif;
      // If there is a delimiter, ...
      if (x = 0 or char < x'40');
        // ... then stop searching
        x = 0;
        leave;
      endif;

      ePos = ePos - 1;
    enddo;
  endif;

  // If there is no delimiter, ...
  if (ePos < sPos);
    // ... then assume the last character to be the delimiter.
    ePos = sPos + i_width - 1;
  endif;

  // Retrieve text (incl. delimiter) ...
  length = ePos - sPos + 1;
  text = %subst(i_string: sPos: length);

  // ... and set new start position.
  sPos = sPos + length;
  if (sPos <= %len(i_string));
    io_startPos = %check(' ': i_string: sPos);
  else;
    io_startPos = 0;
  endif;

  return   text;

end-proc;

//=========================================================================
//  Tests for one or more bits.
//=========================================================================
//  Parameters:
//   i_testBit     - The bits that are tested.
//   i_value       - The numeric value that is tested for the bits.

//  Returns:
//   isOn          - Returns bTrue when the bits specified at i_testBit
//                   are set.
//=========================================================================

dcl-proc isBitOn export;
  dcl-pi *n ind;
    i_testBit uns(10) value;
    i_value   uns(10) value;
  end-pi;

  //  Return value
  dcl-s isOn ind inz(bTrue);

  //  Helper fields
  dcl-s x int(3) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  isOn = bTrue;

  for   x = (%size(i_value) * 8) - 1 downto 0 ;
    if (tstbts(%addr(i_testBit): x) <> 0);
      if (tstbts(%addr(i_value): x) = 0);
        isOn = bFalse;
        leave;
      endif;
    endif;
  endfor;

  if (%bitand(i_value: i_testBit) = i_testBit);
    return bTrue;
  else;
    return bFalse;
  endif;

end-proc;

//=========================================================================
//  Converts a given string to upper case.
//=========================================================================
//  Parameters:
//   i_string      - The string to convert to upper case.

//  Returns:
//   string        - The string converted to upper case.
//=========================================================================

dcl-proc f_ucase export;
  dcl-pi *n varchar(4096);
    i_string varchar(4096) const;
  end-pi;

  //  Return value
  dcl-s string varchar(4096) inz;

  //  Fields for QlgConvertCase API
  dcl-s stringBuf char(4096) inz;
  dcl-ds errCode likeds(errCode_t) inz;

  dcl-ds reqCtrlBlk likeds(QLGCNVCS_reqCtrlBlk_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


  if (i_string <> '');
    reqCtrlBlk.type = cvtcase_type_ccsid;
    reqCtrlBlk.ccsid = CVTCASE_CCSID_Job;
    reqCtrlBlk.case = cvtcase_to_upper;
    reqCtrlBlk.reserved = *allx'00';

    reset errCode;

    QlgConvertCase(reqCtrlBlk
    : i_string: stringBuf: %len(i_string): errCode);
    string = %subst(stringBuf: 1: %len(i_string));
  else;
    string = i_string;
  endif;

  return   string;

end-proc;

//=========================================================================
//  Tests if the specified string starts with the specified prefix.
//=========================================================================
//  Parameters:
//   i_suffix      - The prefix.
//   i_string      - The string that is tested.

//  Returns:
//   startsWith    - Returns TRUE if the string starts with the prefix,
//                   else FALSE.
//=========================================================================

dcl-proc f_startsWith export;
  dcl-pi *n ind;
    i_prefix varchar(4096) const;
    i_string varchar(4096) const;
  end-pi;

  //  Return value
  dcl-s startsWith ind inz(bFalse);

  //  Local fields
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (%len(i_string) = 0  or %len(i_prefix) = 0  or %len(i_string) < %len(i_prefix));
    return startsWith;
  endif;

  if (%subst(i_string: 1: %len(i_prefix)) = i_prefix);
    startsWith = bTrue;
  endif;

  return startsWith;

end-proc;

//=========================================================================
//  Tests if the specified string ends with the specified suffix.
//=========================================================================
//  Parameters:
//   i_suffix      - The suffix.
//   i_string      - The string that is tested.

//  Returns:
//   endsWith      - Returns TRUE if the string ends with the suffix,
//                   else FALSE.
//=========================================================================

dcl-proc f_endsWith export;
  dcl-pi *n ind;
    i_suffix varchar(4096) const;
    i_string varchar(4096) const;
  end-pi;

  //  Return value
  dcl-s endsWith ind inz(bFalse);

  //  Local fields
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if (%len(i_string) = 0  or %len(i_suffix) = 0  or %len(i_string) < %len(i_suffix));
    return endsWith;
  endif;

  if (%subst(i_string: %len(i_string) - %len(i_suffix) + 1) = i_suffix);
    endsWith = bTrue;
  endif;

  return endsWith;


end-proc;

//=========================================================================
//  Sends a message to the command line.
//=========================================================================
//  Parameters:
//   i_msg         - The message.

//  Returns:
//   void
//=========================================================================
dcl-proc f_sndMsgToCmdLine export;
  dcl-pi *n;
    i_msgID  char(7) const;
    i_msgDta char(512) const;
  end-pi;

  //  Local fields
  dcl-s msgKey char(4) inz;

  dcl-ds qMsgF qualified inz;
    name char(10);
    lib  char(10);
  end-ds;

  dcl-ds errCode likeds(errCode_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  clear qMsgF;
  qMsgF.name = f_appMsgF;
  qMsgF.lib  = f_appMsgFL;

  clear errCode;
  errCode.bytPrv = %size(errCode);

  qmhsndpm(i_msgID: qMsgF: i_msgDta: %size(i_msgDta): '*DIAG'
  : 'PEEK': 2: msgKey: errCode);

end-proc;

//===================================================================*
//  Funktion:  f_fieldTypeAsString                        (Body)     *
//===================================================================*

dcl-proc f_fieldTypeAsString export;
  dcl-pi *n varchar(128);
    i_fldl0100 likeds(fldl0100_t) const;
  end-pi;

  //  Funktionswert
  dcl-s type varchar(128) inz;

  //  Arbeitsfelder
  dcl-s length zoned(5) inz;
  dcl-s decpos zoned(2) inz;
  dcl-s lengthA varchar(16) inz;
  dcl-s decPosA varchar(16) inz;
  // ------------------------------------------------------------------------

  if (f_isNumFld(i_fldl0100) = bTrue);
    length = i_fldl0100.f1Digt;
    decpos = i_fldl0100.f1DecP;
    lengthA = %editc(length: '3');
    decPosA = %editc(decpos: '3');
  else;
    length = i_fldl0100.f1FLen;
    decpos = -1;
    lengthA = %editc(length: '3');
    decPosA = '  ';
  endif;

  type = i_fldl0100.f1FNme +
  '  ' + x'41'      +
  lengthA           +
  i_fldl0100.f1DTyp +
  ' '               +
  decPosA           +
  x'41';

  return type;


end-proc;

//===================================================================*
//  Funktion:  f_nextHeaderType                           (Body)     *
//===================================================================*

dcl-proc f_nextHeaderType export;
  dcl-pi *n char(10);
    i_headerType char(10) value;
  end-pi;

  //  Funktionswert
  dcl-s type char(10) inz;
  // ------------------------------------------------------------------------

  select;
  when (i_headerType = '*FIELDNAME');
    type = '*FIELDTEXT';
  when (i_headerType = '*FIELDTEXT');
    type = '*COLHDG';
  when (i_headerType = '*COLHDG');
    type = '*FIELDTYPE';
  other;
    type = '*FIELDNAME';
  endsl;

  return type;


end-proc;

//===================================================================*
//  Funktion:  f_getRecordFormatID                        (Body)     *
//===================================================================*

dcl-proc f_getRecordFormatInf export;
  dcl-pi *n likeds(rcdFmtInf_t);
    i_file   like(file_t) value;
    i_lib    like(lib_t) value;
    i_rcdFmt like(fmtId_t) value;
  end-pi;

  //  Funktionswert
  dcl-ds rcdFmtInf likeds(rcdFmtInf_t);

  dcl-ds qFile likeds(qObj_t);
  dcl-ds qFileRtn likeds(qFile);
  dcl-ds Qdb_Qddfmt likeds(Qdb_Qddfmt_t) based(pQdb_qddfmt);
  dcl-s size int(10);
  dcl-ds errCode likeds(errCode_t) inz;
  // ----------------------------------------------------------------------

  clear rcdFmtInf;

  qFile.name = i_file;
  qFile.lib = i_lib;

  size = (8);
  pQdb_qddfmt = %alloc(size);

  monitor;
    qdbrtvfd(Qdb_Qddfmt: size: qFileRtn: 'FILD0200': qFile
      :'*FIRST' :'0' :'*LCL' :'*EXT' : errCode);

    size = (Qdb_Qddfmt.bytAvl);
    pQdb_qddfmt = %realloc(pQdb_qddfmt: size);
    qdbrtvfd(Qdb_Qddfmt: size: qFileRtn: 'FILD0200': qFile
    :'*FIRST' :'0' :'*LCL' :'*EXT' : errCode);

    rcdFmtInf.name = Qdb_Qddfmt.Qddfname;
    rcdFmtInf.id = Qdb_Qddfmt.Qddfseq;
  on-error;
  endmon;

  dealloc(n) pQdb_qddfmt;

  return rcdFmtInf;

end-proc;

//===================================================================*
//  Funktion:  f_space                                    (Body)     *
//===================================================================*

dcl-proc f_space export;
  dcl-pi *n like(varString_t);
    i_length int(10) value;
  end-pi;

  //  Funktionswert
  dcl-s spaces varchar(4096);

  dcl-s x int(10);
  // ------------------------------------------------------------------------

  x = i_length;
  dow (x > 0);
    spaces = spaces + ' ';
    x = x - 1;
  enddo;

  return spaces;

end-proc;

//===================================================================*
//  Funktion:  Kills the program, sending an *ESCAPE message.        *
//===================================================================*
dcl-proc p_kill export;
  dcl-pi *n;
    i_text varchar(128) value;
  end-pi;

  //  Local fields
  dcl-s msgKey char(4) inz;

  //  Qualified message file name
  dcl-ds qMsgF likeds(qObj_t) inz;

  //  API error code
  dcl-ds errCode likeds(errCode_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  clear qMsgF;
  qMsgF.name = 'QCPFMSG';
  qMsgF.lib  = '*LIBL';

  clear errCode;
  errCode.bytPrv = %size(errCode);

  qmhsndpm('CPF9897': qMsgF: i_text: %len(i_text): '*ESCAPE'
  : '*PGMBDY': 1: msgKey: errCode);

end-proc;

//===================================================================*
//  Map command to message ID.                            (Body)     *
//  i_section is the section of the user settings, the command was  *
//  read from, e.g. '*PEEK64'. It distinguishes commands that have   *
//  different meanings in different programs.                        *
//===================================================================*

dcl-proc f_mapCmdToMsg export;
  dcl-pi *n like(msgId_t);
    i_command char(256) const;
    i_section like(section_t) options(*nopass) const;
  end-pi;

  //  Funktionswert
  dcl-s msgID like(msgId_t);

  //  Optionale Parameter
  dcl-s section like(section_t) inz;
  // ------------------------------------------------------------------------

  if (%parms() >= %parmnum(i_section));
    section = i_section;
  else;
    section = '';
  endif;

  select;
  when (i_command = '*ENTER');
    msgID = '0001';
  when (i_command = '*EXIT');
    msgID = '0002';
  when (i_command = '*REFRESH');
    msgID = '0003';
  when (i_command = '*ADD');
    msgID = '0004';
  when (i_command = '*HEADLINE');
    msgID = '0005';
  when (i_command = '*TGLMRKCOL');
    msgID = '0006';
  when (i_command = '*MOVETOP');
    msgID = '0007';
  when (i_command = '*POSCSR');
    msgID = '0008';
  when (i_command = '*SEARCH');
    msgID = '0009';
  when (i_command = '*TOP');
    msgID = '0010';
  when (i_command = '*BOT');
    msgID = '0011';
  when (i_command = '*LEFT');
    msgID = '0012';
  when (i_command = '*RIGHT');
    msgID = '0013';
  when (i_command = '*CMDLINE');
    msgID = '0014';
  when (i_command = '*132/80');
    msgID = '0015';
  when (i_command = '*MOREKEYS');
    msgID = '0016';
  when (i_command = '*PAGEDOWN');
    msgID = '0017';
  when (i_command = '*PAGEUP');
    msgID = '0018';
  when (i_command = '*PINROW');
    msgID = '0019';
  when (i_command = '*UNPINROW');
    msgID = '0020';
  when (i_command = '*CHANGE');
    msgID = '0021';
  when (i_command = '*COPY');
    msgID = '0022';
  when (i_command = '*DELETE' and section = '*PEEK64');
    msgID = '0087';   // Text editor: Delete
  when (i_command = '*DELETE');
    msgID = '0023';   // Delete record
  when (i_command = '*DISPLAY');
    msgID = '0024';
  when (i_command = '*USERSETG');
    msgID = '0025';
  when (i_command = '*CANCEL');
    msgID = '0026';
  when (i_command = '*SAVE_EXIT');
    msgID = '0027';
  when (i_command = '*PINCOL');
    msgID = '0028';
  when (i_command = '*UNPINCOL');
    msgID = '0029';
  when (i_command = '*TGLPINCOL');
    msgID = '0030';
  when (i_command = '*TBLPAPON');
    msgID = '0031';
  when (i_command = '*TBLPAPOFF');
    msgID = '0032';
  when (i_command = '*TGLTBLPAP');
    msgID = '0033';
  when (i_command = '*YESTOALL');
    msgID = '0034';
  when (i_command = '*MOREOPT');
    msgID = '0035';
  when (i_command = '*COPYEXT');
    msgID = '0036';
  when (i_command = '*MRKCOL');
    msgID = '0037';
  when (i_command = '*UNMRKCOL');
    msgID = '0038';
  when (i_command = '*LOWERCASE');
    msgID = '0039';
  when (i_command = '*UPPERCASE');
    msgID = '0040';
  when (i_command = '*TGLLUCASE');
    msgID = '0041';
  when (i_command = '*SPLASHON');
    msgID = '0042';
  when (i_command = '*SPLASHOFF');
    msgID = '0043';
  when (i_command = '*PAGELEFT');
    msgID = '0044';
  when (i_command = '*PAGERIGHT');
    msgID = '0045';
  when (i_command = '*REPEAT');
    msgID = '0046';
  when (i_command = '*REBUILD');
    msgID = '0047';
  when (i_command = '*CLRPINROW');
    msgID = '0048';
  when (i_command = '*CLRPINCOL');
    msgID = '0049';
  when (i_command = '*LAYOUT');
    msgID = '0050';
  when (i_command = '*FLOATKEYS');
    msgID = '0051';
  when (i_command = '*SELECT');
    msgID = '0052';
  when (i_command = '*NEXTMARK');
    msgID = '0053';
  when (i_command = '*PREVMARK');
    msgID = '0054';
  when (i_command = '*DSPDBR');
    msgID = '0055';
  when (i_command = '*PROMPT');
    msgID = '0056';
  when (i_command = '*KEY');
    msgID = '0057';
  when (i_command = '*RRN');
    msgID = '0058';
  when (i_command = '*TGLACCESS');
    msgID = '0059';
  when (i_command = '*HEXEDIT');
    msgID = '0060';
  when (i_command = '*ABOUT');
    msgID = '0061';
  when (i_command = '*PINCOLDLG');
    msgID = '0062';
  when (i_command = '*CLRALL');
    msgID = '0063';
  when (i_command = '*DSPNRM');
    msgID = '0064';
  when (i_command = '*DSPHEX');
    msgID = '0065';
  when (i_command = '*TGLDSP');
    msgID = '0066';
  when (i_command = '*SQL');
    msgID = '0067';
  when (i_command = '*INSKEYFLD');
    msgID = '0068';
  when (i_command = '*SAVEENV');
    msgID = '0069';
  when (i_command = '*LOADENV');
    msgID = '0070';
  when (i_command = '*DELETEENV');
    msgID = '0071';
  when (i_command = '*TGLSORT');
    msgID = '0072';
  when (i_command = '*YES');
    msgID = '0073';
  when (i_command = '*NO');
    msgID = '0074';
  when (i_command = '*OK');
    msgID = '0075';
  when (i_command = '*FIRSTPOS');
    msgID = '0076';
  when (i_command = '*LASTPOS');
    msgID = '0077';
  when (i_command = '*SLCENV');
    msgID = '0078';
  when (i_command = '*SLCLAYOUT');
    msgID = '0079';
  when (i_command = '*TGLNULL');
    msgID = '0080';
  when (i_command = '*TGLINPUT');
    msgID = '0081';
  when (i_command = '*STREDIT');
    msgID = '0082';
  when (i_command = '*TGLRCDLCK');
    msgID = '0083';
  when (i_command = '*TGLKEYLUC');
    msgID = '0084';
  when (i_command = '*PRINT');
    msgID = '0085';
  when (i_command = '*INSERT');
    msgID = '0086';
  other;
    msgID = '';
  endsl;

  return msgID;

end-proc;

//===================================================================*
//  Funktion:  f_extDate                                  (Body)     *
//  Datum im externen Format eines Feldes, so wie es im Satzpuffer   *
//  steht: im Format DATFMT und mit dem Trennzeichen DATSEP des      *
//  Feldes (FLDL0100.F1DTFM, FLDL0100.F1DTSP). Formate mit           *
//  2-stelligem Jahr (*MDY, *DMY, *YMD, *JUL) umfassen nur 1940 bis  *
//  2039, kleinere und größere Werte werden auf diesen Bereich       *
//  begrenzt (*LOVAL, *HIVAL).                                       *
//===================================================================*

dcl-proc f_extDate export;
  dcl-pi *n varchar(10);
    i_fldl0100 likeds(fldl0100_t) const;
    i_date     date(*iso) value;
  end-pi;

  //  Funktionswert
  dcl-s text varchar(10);

  //  Arbeitsfelder
  dcl-s dftSep char(1);
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1dtfm = '*MDY' or i_fldl0100.f1dtfm = '*DMY' or
      i_fldl0100.f1dtfm = '*YMD' or i_fldl0100.f1dtfm = '*JUL');
    if (i_date < D'1940-01-01');
      i_date = D'1940-01-01';
    elseif (i_date > D'2039-12-31');
      i_date = D'2039-12-31';
    endif;
  endif;

  select;
  when (i_fldl0100.f1dtfm = '*EUR');
    text = %char(i_date: *eur);
    dftSep = '.';
  when (i_fldl0100.f1dtfm = '*USA');
    text = %char(i_date: *usa);
    dftSep = '/';
  when (i_fldl0100.f1dtfm = '*JIS');
    text = %char(i_date: *jis);
    dftSep = '-';
  when (i_fldl0100.f1dtfm = '*MDY');
    text = %char(i_date: *mdy);
    dftSep = '/';
  when (i_fldl0100.f1dtfm = '*DMY');
    text = %char(i_date: *dmy);
    dftSep = '/';
  when (i_fldl0100.f1dtfm = '*YMD');
    text = %char(i_date: *ymd);
    dftSep = '/';
  when (i_fldl0100.f1dtfm = '*JUL');
    text = %char(i_date: *jul);
    dftSep = '/';
  other;
    text = %char(i_date: *iso);
    dftSep = '-';
  endsl;

  if (i_fldl0100.f1dtsp <> ' ' and i_fldl0100.f1dtsp <> dftSep);
    text = %xlate(dftSep: i_fldl0100.f1dtsp: text);
  endif;

  return text;

end-proc;

//===================================================================*
//  Funktion:  f_extTime                                  (Body)     *
//  Zeit im externen Format eines Feldes, so wie sie im Satzpuffer   *
//  steht: im Format TIMFMT und mit dem Trennzeichen TIMSEP des      *
//  Feldes (FLDL0100.F1DTFM, FLDL0100.F1DTSP).                       *
//===================================================================*

dcl-proc f_extTime export;
  dcl-pi *n varchar(8);
    i_fldl0100 likeds(fldl0100_t) const;
    i_time     time(*iso) value;
  end-pi;

  //  Funktionswert
  dcl-s text varchar(8);

  //  Arbeitsfelder
  dcl-s dftSep char(1);
  // ------------------------------------------------------------------------

  //  *HIVAL ist 24.00.00. Im Format *USA wäre das '12:00 AM' und damit
  //  wieder Mitternacht am Tagesanfang; größter *USA-Wert ist 11:59 PM.
  if (i_fldl0100.f1dtfm = '*USA' and i_time > T'23.59.59');
    i_time = T'23.59.59';
  endif;

  select;
  when (i_fldl0100.f1dtfm = '*HMS');
    text = %char(i_time: *hms);
    dftSep = ':';
  when (i_fldl0100.f1dtfm = '*EUR');
    text = %char(i_time: *eur);
    dftSep = '.';
  when (i_fldl0100.f1dtfm = '*USA');
    text = %char(i_time: *usa);
    dftSep = ':';
  when (i_fldl0100.f1dtfm = '*JIS');
    text = %char(i_time: *jis);
    dftSep = ':';
  other;
    text = %char(i_time: *iso);
    dftSep = '.';
  endsl;

  if (i_fldl0100.f1dtsp <> ' ' and i_fldl0100.f1dtsp <> dftSep);
    text = %xlate(dftSep: i_fldl0100.f1dtsp: text);
  endif;

  return text;

end-proc;

