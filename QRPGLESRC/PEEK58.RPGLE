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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FILD0100
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,MBRD0100
/COPY QCOPYLE,MBRD0300
/COPY QCOPYLE,BSPF0100
/COPY QCOPYLE,OBJD0100
/COPY QCOPYLE,USRI0200
/COPY QCOPYLE,D_CLib
/COPY QCOPYLE,D_WORKSTN
/COPY QCOPYLE,D_MI
/COPY QCOPYLE,QDBRTVFD
/COPY QCOPYLE,QUSRJOBI
/COPY QCOPYLE,QUSROBJD
/COPY QCOPYLE,QUSRMBRD
/COPY QCOPYLE,QCAPCMD
/COPY QCOPYLE,QSYRUSRI
/COPY QCOPYLE,QMHRMVPM
/COPY QCOPYLE,QMHSNDPM
/COPY QCOPYLE,QMHRTVM
/COPY QCOPYLE,QMHMOVPM
/COPY QCOPYLE,QLGCNVCS
/COPY QCOPYLE,SDS

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58
/COPY QCOPYLE,PPEEK41

dcl-s peek41_name     like(pgmcalln_t);

//  Performs word wrapping on a given string without respect to
//  end-of-paragraph markers.
dcl-pr lf_wordwrap varchar(4096);
  i_string        varchar(4096) const;
  i_width         uns(10) const;
  io_startpos     uns(10);
end-pr;

//  Tests for one or more bits.
dcl-pr isBitOn ind;
  i_testbit       uns(10) value;
  i_value         uns(10) value;
end-pr;

dcl-s g_prdlib        like(lib_t) inz;

dcl-s g_jobccsid      uns(10) inz(0);

dcl-s do_x1           packed(7);

//===================================================================*
//  Funktion:  f_dsplyLn                                  (Body)     *
//===================================================================*

dcl-proc f_dsplyln export;
  dcl-pi *N        like(int4_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s fldlen          like(int4_t);
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1dtyp = 'G' and
  i_fldl0100.f1ndbc > 0);
    return i_fldl0100.f1ndbc;
  endif;

  fldlen = i_fldl0100.f1flen;

  if i_fldl0100.f1vfmi = '1';
    //  Variable Feldlänge ...
    fldlen = fldlen - 2;
  endif;

  return fldlen;

end-proc;

//===================================================================*
//  Funktion:  f_buffLn                                   (Body)     *
//===================================================================*

dcl-proc f_buffln export;
  dcl-pi *N        like(int4_t);
    i_fldl0100      const  likeds(fldl0100_t);
    i_withlen       const  like(bool_t)
         options(*nopass);
  end-pi;

  //  Parameterpositionen optionaler Parameter
  dcl-c p_withlen const(2);

  //  Funktionswert
  dcl-s fldlen          like(int4_t) inz;

  //  Arbeitsfelder
  dcl-s withlen         like(i_withlen) inz;
  // ------------------------------------------------------------------------

  if %parms >= p_withlen;
    withlen  = i_withlen;
  else;
    withlen  = bfalse;
  endif;

  if i_fldl0100.f1vfmi = '1';
    //  Variable Feldlänge ...
    if withlen = btrue;
      //  ... incl. Längenbyte
      fldlen = i_fldl0100.f1flen;
    else;
      //  ... ohne Längenbyte
      fldlen = i_fldl0100.f1flen - 2;
    endif;
  else;
    //  Felder fester Länge
    fldlen = i_fldl0100.f1flen;
  endif;

  return fldlen;

end-proc;

//===================================================================*
//  Funktion:  f_curFldLn                                 (Body)     *
//===================================================================*

dcl-proc f_curfldln export;
  dcl-pi *N        like(int4_t);
    i_buffer        const  like(rcdbuf_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s curfldln        like(int4_t) inz;
  // ------------------------------------------------------------------------

  if i_fldl0100.f1vfmi = '1';
    curfldln = f_bintodec(i_buffer: i_fldl0100.f1ibuf: 2);
  else;
    if (i_fldl0100.f1ndbc > 0);
      curfldln = i_fldl0100.f1ndbc;
    else;
      curfldln = i_fldl0100.f1flen;
    endif;
  endif;

  return curfldln;

end-proc;

//===================================================================*
//  Funktion:  f_rtvFld                                   (Body)     *
//===================================================================*

dcl-proc f_rtvfld export;
  dcl-pi *N opdesc like(int4_t);
    o_buffer        like(rcdbuf_t)
         options(*varsize);
    i_buffer        const  like(rcdbuf_t);
    i_fldl0100      const  likeds(fldl0100_t);
    i_withlen       const  like(bool_t)
         options(*nopass);
  end-pi;

  //  Parameterpositionen optionaler Parameter
  dcl-c p_withlen const(4);

  //  Funktionswert
  dcl-s rtnlen          like(int4_t) inz;

  // Parameters passed to CEEDOD
  dcl-s desctype        int(10);
  dcl-s datatype        int(10);
  dcl-s descinfo1       int(10);
  dcl-s descinfo2       int(10);
  dcl-s parmlen         int(10);

  //  Arbeitsfelder
  dcl-s withlen         like(i_withlen) inz;
  // ------------------------------------------------------------------------

  ceedod(1         : desctype : datatype :
  descinfo1 : descinfo2: parmlen  :
  *omit);

  if %parms >= p_withlen;
    withlen  = i_withlen;
  else;
    withlen  = bfalse;
  endif;

  rtnlen = f_buffln(i_fldl0100: withlen);
  if rtnlen > parmlen;
    rtnlen = parmlen;
  endif;

  if i_fldl0100.f1vfmi = '1';
    if withlen = bfalse;
      %subst(o_buffer: 1: parmlen) =
      %subst(i_buffer: i_fldl0100.f1ibuf+2: rtnlen);
    else;
      %subst(o_buffer: 1: parmlen) =
      %subst(i_buffer: i_fldl0100.f1ibuf  : rtnlen);
    endif;
  else;
    %subst(o_buffer: 1: parmlen) =
    %subst(i_buffer: i_fldl0100.f1ibuf  : rtnlen);
  endif;

  return rtnlen;

end-proc;

//===================================================================*
//  Prozedur:  p_fldToBuf                                 (Body)     *
//===================================================================*

dcl-proc p_fldtobuf export;
  dcl-pi *N;
    io_buffer       like(rcdbuf_t);
    i_fielddta      like(rcdbuf_t);
    i_fldl0100      const  likeds(fldl0100_t);
    i_withlen       const  like(bool_t)
         options(*nopass);
  end-pi;

  //  Parameterpositionen optionaler Parameter
  dcl-c p_withlen const(4);

  //  Arbeitsfelder
  dcl-s withlen         like(i_withlen) inz;

  dcl-s fielddta        like(rcdbuf_t) based(pfielddta);
  dcl-s fielddtaucs2    like(rcdbufucs2_t) based(pfielddta);

  dcl-ds *N;
    buffln          like(int2_t);
    bufflna         char(2) overlay(buffln:  1);
  end-ds;
  // ------------------------------------------------------------------------
  pfielddta = %addr(i_fielddta);

  if %parms >= p_withlen;
    withlen = i_withlen;
  else;
    withlen = bfalse;
  endif;

  if i_fldl0100.f1vfmi = '1';
    //  Felder variabler Länge ...
    if withlen = bfalse;
      //  ... ohne Längenangabe
      //      (einfügen Längenangabe)

      if (i_fldl0100.f1dtyp = 'G');
        buffln = %len(%trimr(
                     %subst(fielddtaucs2
                            : 1
                            : f_dsplyln(i_fldl0100))
                            )) * 2;
      else;
        buffln = %len(%trimr(
                     fielddta));
      endif;

      %subst(io_buffer  :
            i_fldl0100.f1ibuf+2 :
            f_buffln(i_fldl0100: withlen))
               = i_fielddta;

      if (i_fldl0100.f1dtyp = 'G' and
         i_fldl0100.f1ndbc > 0);
        buffln = buffln / 2;
      endif;

      %subst(io_buffer  :
            i_fldl0100.f1ibuf   :
            2          )
               = bufflna;
    else;
      //  ... incl. Längenangabe
      %subst(io_buffer  :
            i_fldl0100.f1ibuf   :
            f_buffln(i_fldl0100: withlen))
               = i_fielddta;
    endif;
  else;
    //  Felder fester Länge ...
    %subst(io_buffer  :
          i_fldl0100.f1ibuf   :
          f_buffln(i_fldl0100))
             = i_fielddta;
  endif;

end-proc;

//===================================================================*
//  Funktion:  f_isVarLen                                 (Body)     *
//===================================================================*

dcl-proc f_isvarlen export;
  dcl-pi *N        like(bool_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;
  // ------------------------------------------------------------------------

  if i_fldl0100.f1vfmi = '1';
    return btrue;
  else;
    return bfalse;
  endif;

end-proc;

//===================================================================*
//  Funktion:  f_binToDec                                 (Body)     *
//===================================================================*

dcl-proc f_bintodec export;
  dcl-pi *N opdesc like(int4_t);
    i_string        const  like(varString_t) options(*varsize);
    i_startPos      const  like(int4_t);
    i_length        const  like(int4_t);
  end-pi;

  // Funktionswert
  dcl-ds *N;
    intValue        like(int4_t) inz;
    alpha2          char(2) overlay(intValue: 3);
    alpha4          char(2) overlay(intValue: 1);
  end-ds;
  // ------------------------------------------------------------------------

  if (i_startPos + i_length - 1) > %len(i_string);
    p_kill('Start position and length outside range.');
  else;
    select;
    when i_length = 2;
      alpha2 = %subst(i_string: i_startPos: i_length);
    when i_length = 4;
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

dcl-proc f_len_DEPRECATED export;
  dcl-pi *N opdesc like(int4_t);
    i_string        const like(varString_t) options(*varsize);
  end-pi;

  // Parameters passed to CEEDOD
  dcl-s desctype        int(10);
  dcl-s datatype        int(10);
  dcl-s descinfo1       int(10);
  dcl-s descinfo2       int(10);
  dcl-s parmlen         int(10);
  // ------------------------------------------------------------------------

  p_kill('Deprecated procedure: f_len()');

  ceedod(1         : desctype : datatype :
  descinfo1 : descinfo2: parmlen  :
  *omit);

  return parmlen;

end-proc;

//===================================================================*
//  Funktion:  f_scan                                     (Body)     *
//===================================================================*

dcl-proc f_scan export;
  dcl-pi *N opdesc like(int4_t);
    srcharg         char(100) const  options(*varsize);
    string          char(100) const;
  end-pi;

  dcl-s posfound        like(int4_t) inz;

  // Parameters passed to CEEDOD
  dcl-s desctype        like(int4_t) inz;
  dcl-s datatype        like(int4_t) inz;
  dcl-s descinfo1       like(int4_t) inz;
  dcl-s descinfo2       like(int4_t) inz;
  dcl-s plen            like(int4_t) inz;
  //------------------------------------------------------------*

  ceedod(1         : desctype : datatype :
  descinfo1 : descinfo2: plen     :
  *omit);

  posfound = %scan(%subst(srcharg: 1: plen): string);

  return posfound;

end-proc;

//===================================================================*
//  Funktion:  f_vldNme                                   (Body)     *
//===================================================================*

dcl-proc f_vldname export;
  dcl-pi *N        like(bool_t);
    i_name          const  like(fieldNme_t);
    o_msgid                like(msgid_t);
    o_msgdta               like(msgdta_t);
  end-pi;

  //  Funktionswert
  dcl-s isValid         like(bool_t) inz(bFalse);

  //  Arbeitsfelder
  dcl-s idx             like(int4_t) inz;
  dcl-s chr             char(1) inz;
  dcl-s startString       like(bool_t) inz(bFalse);
  dcl-s endString       like(bool_t) inz(bFalse);

  dcl-c VALID_FIRST_CHAR '§$#ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  dcl-c VALID_CHAR '§$#ABCDEFGHIJKLMNOPQRSTUVWXYZ_.1234567890';

  /COPY QCOPYLE,USR8182
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
        o_msgid = 'USR8182';
        o_msgdta = usr8182;
        isValid = bFalse;
        leave;
      endif;
      iter;
    endif;

    //  Prüfen Ende des Strings ...
    if (startString =  bTrue )  and
       (endString =  bFalse)  and
       (chr       =  ' '   );
      endString = bTrue;
      iter;
    endif;

    //  Prüfen Zeichen des Strings ...
    if (startString =  bTrue and endString = bFalse);
      if (%check(VALID_CHAR: chr) > 0);
        clear usr8182;
        usr8182.var1 = chr;
        o_msgid = 'USR8182';
        o_msgdta = usr8182;
        isValid = bFalse;
        leave;
      endif;
    endif;

    //  Prüfen Zeichen hinter dem Ende des Strings ...
    if (startString =  bTrue and endString =  bTrue);
      if (chr <> '');
        clear usr8182;
        usr8182.var1 = chr;
        o_msgid  = 'USR8182';
        o_msgdta = usr8182;
        isValid  = bFalse;
        leave;
      endif;
    endif;

  endfor;

  if (startString = bFalse);
    clear usr8182;
    usr8182.var1 = chr;
    o_msgid  = 'USR8182';
    o_msgdta = usr8182;
    isValid  = bFalse;
  endif;

  return isValid;

end-proc;

//===================================================================*
//  Funktion:  f_vldFloat                                 (Body)     *
//===================================================================*

dcl-proc f_vldfloat export;
  dcl-pi *N        like(bool_t);
    i_buffer        varchar(64) const;
  end-pi;

  //  Arbeitsfelder
  dcl-s i               int(10) inz;
  dcl-s c               char(1) inz;
  dcl-s dummy           float(8) inz;
  dcl-s hasexponent     like(bool_t) inz(bfalse);
  dcl-c cdigits '0123456789';
  //-------------------------------------------------------------------*

  monitor;

    if (%len(i_buffer) = 0);
      return bfalse;
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
        if (%check(cdigits: c) <> 0);
          return bfalse;
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
        if (%check(cdigits: c) <> 0);
          return bfalse;
        endif;
      endif;
      i = i + 1;
    enddo;

    if (c = 'e' or c = 'E');
      // Prüfen auf Vorzeichen des Exponenten
      i = i + 1;
      if (i > %len(i_buffer));
        return bfalse;
      endif;
      c = %subst(i_buffer: i: 1);
      if (c <> '+' and c <> '-' and c <> ' ');
        return bfalse;
      endif;

      i = i + 1;
      hasexponent = bfalse;

      // Prüfen auf nummerische Ziffern des Exponenten
      dow (i <= %len(i_buffer));
        c = %subst(i_buffer: i: 1);
        if (c <> ' ');
          if (%check(cdigits: c) <> 0);
            return bfalse;
          endif;
          hasexponent = btrue;
        endif;
        i = i + 1;
      enddo;

      if (hasexponent <> btrue);
        return bfalse;
      endif;
    endif;

    dummy = %float(i_buffer);

    return btrue;
  on-error;
    p_rmvpgmmg('*');
    return bfalse;
  endmon;


end-proc;

//===================================================================*
//  Funktion:  f_execute                                  (Body)     *
//===================================================================*

dcl-proc f_execute export;
  dcl-pi *N opdesc like(bool_t);
    i_cmd           const like(cmdBuffer_t) options(*varsize);
    o_msgid               like(msgid_t);
    o_msgdta              like(msgdta_t);
  end-pi;

  //  Definieren Funktionswert
  dcl-s isok            like(bool_t) inz(bfalse);

  //  Definieren Parameter für p_getOpDesc
  dcl-s desctype        int(10) inz;
  dcl-s datatype        int(10) inz;
  dcl-s descinf1        int(10) inz;
  dcl-s descinf2        int(10) inz;
  dcl-s datalen         int(10) inz;
  dcl-s feedback        char(12) inz;

  //  Definitionen für QCAPCMD
  dcl-s cmdlen          int(10) inz;

  dcl-ds optctrl;
    typ_cmdprc      int(10) inz(0);                                        // like QCMDEXC
    dbcs_data       char(1) inz('0');                                      // ignore DBCS
    prmt_act        char(1) inz('0');                                      // never prompt
    cmdstrsntx      char(1) inz('0');                                      // AS/400 Syntax
    msgrtvkey       char(4) inz(*blanks);                                  // no retrieve ke
    res_01          char(9) inz(*allx'00');
  end-ds;

  dcl-s optctrllen      int(10) inz;
  dcl-s optctrlfmt      char(8) inz('CPOP0100');
  dcl-s cmd             like(i_cmd) inz;
  dcl-s lenavl          int(10) inz;
  dcl-s lenavlrtn       int(10) inz;

  dcl-ds errcode likeds(errcode_t ) inz;
  //-------------------------------------------------------------------

  reset errcode;
  errcode.bytprv = %size(errcode);

  ceedod(1: desctype: datatype:
  descinf1: descinf2:
  datalen:  feedback);

  cmd        = %subst(i_cmd: 1: datalen);
  cmdlen     = %len(cmd);
  lenavl     = %len(cmd);

  optctrllen = %len(optctrl);
  reset errcode;
  errcode.bytprv = %size(errcode);

  qcapcmd ( cmd : cmdlen : optctrl :
  optctrllen : optctrlfmt : cmd : lenavl :
  lenavlrtn : errcode );

  if errcode.bytavl <> 0;
    o_msgid  = errcode.excid;
    o_msgdta = errcode.excdta;
    isok     = bfalse;
  else;
    o_msgid  = ' ';
    o_msgdta = ' ';
    isok     = btrue;
  endif;

  return isok;

end-proc;

//===================================================================*
//  Funktion:  f_basedPF                                  (Body)     *
//===================================================================*

dcl-proc f_basedpf export;
  dcl-pi *N        like(bool_t);
    i_file          value  like(file_t);
    i_lib           value  like(lib_t);
    i_mbr           value  like(mbr_t);
    i_rcdfmt        value  like(rcdfmt_t);
    i_rcdmbrnbr     value  like(mbrnbr_t);
    o_pfile         like(file_t);
    o_plib          like(lib_t);
    o_pmbr          like(mbr_t);
    o_prcdfmt       like(rcdfmt_t);
  end-pi;

  //  Definieren Funktionswert ...
  dcl-s isbasedonpf     like(bool_t) inz(bfalse);

  dcl-s tfile           like(i_file);
  dcl-s tlib            like(i_lib);
  dcl-s tmbr            like(i_mbr);
  dcl-s trcdfmt         like(i_rcdfmt);
  dcl-ds fild0100 likeds(fild0100_t) inz;

  dcl-ds yqfile likeds(qobj_t) inz;
  dcl-s ynbrofent       like(int4_t);
  dcl-s ydata           char(512);
  //------------------------------------------------------------*

  peek41_name = f_pgmcalln('PEEK41');

  o_pfile  = '*ERROR';
  o_plib   = '*ERROR';
  o_pmbr   = '*ERROR';
  o_prcdfmt = '*ERROR';

  //  Einlesen der Dateiinformationen ...
  yqfile.name = i_file;
  yqfile.lib = i_lib;
  peek41(yqfile: i_rcdfmt
  : '*CREATE': ynbrofent: ydata);

  if ynbrofent = 0;
    return bfalse;
  endif;

  //      prüfen auf logische Datei
  fild0100 = ydata;

  if fild0100.atfila = '*LGL';
    //      ... logical file
    select;
    when fild0100.atnomb > 1;
      //          ... multi-based-member logical file
      if f_basedmbr(i_file: i_lib: i_mbr
                 : i_rcdmbrnbr: i_rcdfmt
                 : tfile: tlib: tmbr: trcdfmt
                 ) = bfalse;
        return bfalse;
      endif;

    when fild0100.atnofm > 1;
      //          ... multi-format logical file
      if f_basedmbr(i_file: i_lib: i_mbr
                 : i_rcdmbrnbr: i_rcdfmt
                 : tfile: tlib: tmbr: trcdfmt
                 ) = bfalse;
        return bfalse;
      endif;

    other;
      //          ... single-format logical file
      if f_basedmbr(i_file: i_lib: i_mbr
                 : i_rcdmbrnbr: i_rcdfmt
                 : tfile: tlib: tmbr: trcdfmt
                 ) = bfalse;
        return bfalse;
      endif;
    endsl;


    isbasedonpf = btrue;
    o_pfile   = tfile;
    o_plib    = tlib;
    o_pmbr    = tmbr;
    o_prcdfmt = trcdfmt;

  else;
    //      ... physical file
    if f_basedmbr(i_file: i_lib: i_mbr
               : i_rcdmbrnbr: i_rcdfmt
               : tfile: tlib: tmbr: trcdfmt
               ) = bfalse;
      return bfalse;
    endif;

    isbasedonpf = bfalse;
    o_pfile   = tfile;
    o_plib    = tlib;
    o_pmbr    = tmbr;
    o_prcdfmt = trcdfmt;
  endif;

  return isbasedonpf;

end-proc;

//===================================================================*
//  Funktion:  f_basedMbr                                 (Body)     *
//===================================================================*

dcl-proc f_basedmbr export;
  dcl-pi *N        like(bool_t);
    i_file          value  like(file_t);
    i_lib           value  like(lib_t);
    i_mbr           value  like(mbr_t);
    i_mbrnbr        value  like(int4_t);
    i_rcdfmt        value  like(rcdfmt_t);
    o_pFile         like(file_t);
    o_pLib          like(lib_t);
    o_pmbr          like(mbr_t);
    o_rcdfmt        like(rcdfmt_t);
  end-pi;

  //  Definieren Funktionswert ...
  dcl-s isMbrFound  like(bool_t) inz(bfalse);

  dcl-s mbrNbr      like(i_mbrnbr);

  //  Arbeitsfelder
  dcl-ds qFile likeds(qObj_t) inz;
  dcl-ds errcode likeds(errcode_t) inz;

  dcl-ds bspf0100 likeds(bspf0100_t) inz;

  dcl-s pMbrd0300 pointer inz static;
  dcl-ds mbrd0300 likeds(mbrd0300_t) based(pMbrd0300);

  dcl-ds basedOnE likeds(MBRD0300_basedOnE_t) based(pBasedOnE);

  dcl-s offset          int(10) inz;
  dcl-ds fild0100 likeds(fild0100_t) inz;

  dcl-s nbrOfEnt       like(int4_t);
  dcl-s ydata           char(512);
  //------------------------------------------------------------*

  peek41_name = f_pgmcalln('PEEK41');

  o_pFile = ' ';
  o_pLib  = ' ';
  o_pmbr  = ' ';

  //  Ermitteln Speicherbedarf
  reset errcode;
  errcode.bytprv = %size(errcode);

  qFile.name = i_file;
  qFile.lib = i_lib;
  pMbrd0300 = malloc(%size(mbrd0300));
  qusrmbrd(mbrd0300: %size(mbrd0300): 'MBRD0300'
  : qFile: i_mbr: '0': errcode);
  if errcode.bytavl <> 0;
    isMbrFound = bfalse;
    return isMbrFound;
  endif;

  //  Zuordnen Speicher
  pMbrd0300 = realloc(pMbrd0300: mbrd0300.m3bytavl);

  //  Abrufen Beschreibung der Teildatei
  qusrmbrd(mbrd0300: mbrd0300.m3bytavl: 'MBRD0300'
  : qFile: i_mbr: '0': errcode);
  if errcode.bytavl <> 0;
    isMbrFound = bfalse;
    return isMbrFound;
  endif;

  select;
  //  Wenn es sich um eine Join Datei oder SQL VIEW handelt, ...
  when (mbrd0300.m3joinmbr = '1' or
  mbrd0300.m3sqlfiletype = 'VIEW');
    //  ... dann
    //      zurückgeben der Eingangsmemberdaten, wegen Join Datei
    o_pFile   = i_file;
    o_pLib    = i_lib;
    o_pmbr    = i_mbr;
    o_rcdfmt  = i_rcdfmt;
    isMbrFound = bTrue;

  //  Wenn es keine basierenden physischen Member gibt, ...
  when (mbrd0300.m3numBasedOnMbr = 0);
    //  ... dann
    //      zurückgeben der Eingangsmemberdaten
    o_pFile   = i_file;
    o_pLib    = i_lib;
    o_pmbr    = i_mbr;
    o_rcdfmt  = i_rcdfmt;
    isMbrFound = bTrue;
  other;
    //  ... sonst
    //      zurückgeben des basierenden physischen Members
    if (i_mbrnbr > 0);
      mbrNbr = i_mbrnbr;
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
      pBasedOnE  = f_addptr(pMbrd0300: offset);
      o_pFile    = basedOnE.basedOnFile;
      o_pLib     = basedOnE.basedOnLib;
      o_pmbr     = basedOnE.basedOnMbr;
      o_rcdfmt   = '*FIRST';
      isMbrFound = bTrue;
    else;
      o_pFile    = '*ERROR';
      o_pLib     = '*ERROR';
      o_pmbr     = '*ERROR';
      o_rcdfmt   = '*ERROR';
      isMbrFound = bfalse;
    endif;
  endsl;

  //  Freigeben Speicher ...
  free(pMbrd0300);

  if (o_rcdfmt = '*FIRST');

    //  Einlesen der Dateiinformationen ...
    qfile.name = o_pFile;
    qfile.lib = o_pLib;
    peek41(qfile: o_rcdfmt: '*CREATE': nbrOfEnt: ydata);
    fild0100 = ydata;

    peek41(qfile: o_rcdfmt: '*BASED-ON': nbrOfEnt: ydata);
    bspf0100 = ydata;

    if (nbrOfEnt = 1);
      o_rcdfmt = bspf0100.bfrcdfmt;
    endif;

  endif;

  return isMbrFound;

end-proc;

//===================================================================*
//  Funktion:  f_numBased                                 (Body)     *
//===================================================================*

dcl-proc f_numbased export;
  dcl-pi *N        like(int4_t);
    i_file          const  like(file_t);
    i_lib           const  like(lib_t);
    i_mbr           const  like(mbr_t);
  end-pi;

  //  Definieren Funktionswert ...
  dcl-s f_numbased      like(int4_t) inz;

  //  Arbeitsfelder
  dcl-ds errcode likeds(errcode_t) inz;

  dcl-ds mbrd0300 inz;
    m3bytprv        int(10);
    m3bytavl        int(10);
    m3fileattr      char(10) pos(39);
    m3nbrmbr        int(10) pos(157);
  end-ds;
  //------------------------------------------------------------*

  //  Ermitteln Anzahl basierender Teildateien
  reset errcode;
  errcode.bytprv = %size(errcode);

  qusrmbrd(mbrd0300       :
  %size(mbrd0300):
  'MBRD0300'     :
  i_file + i_lib :
  i_mbr          :
  '0'            :
  errcode        );
  if errcode.bytavl <> 0;
    f_numbased = -1;
  else;
    if m3fileattr = 'PF';
      f_numbased = 1;
    else;
      f_numbased = m3nbrmbr;
    endif;
  endif;

  return f_numbased;

end-proc;

//===================================================================*
//  Prozedur:  p_setPrdLb                                 (Body)     *
//===================================================================*

dcl-proc p_setprdlb export;
  dcl-pi *N;
    i_lib           const  like(lib_t);
  end-pi;
  //------------------------------------------------------------*

  g_prdlib = i_lib;

end-proc;

//===================================================================*
//  Funktion:  f_getPrdLb                                 (Body)     *
//===================================================================*

dcl-proc f_getprdlb export;
  dcl-pi *N        like(lib_t);
  end-pi;
  //------------------------------------------------------------*

  return g_prdlib;

end-proc;

//===================================================================*
//  Funktion:  f_cmdLine                                  (Body)     *
//===================================================================*

dcl-proc f_cmdline export;
  dcl-pi *N        like(bool_t);
  end-pi;
  //------------------------------------------------------------*

  //  Definieren Funktionswert ...
  dcl-s f_cmdline       like(bool_t) inz;

  dcl-ds usri0200 likeds(usri0200_t) inz;
  dcl-ds errcode likeds(errcode_t ) inz;
  //------------------------------------------------------------*

  clear usri0200;

  reset errcode;
  errcode.bytprv = %size(errcode);

  qsyrusri (usri0200: %size(usri0200): 'USRI0200': sds.user: errcode);

  if (errcode.bytavl <> 0 or usri0200.lmtCap = '*YES');
    f_cmdline = bfalse;
  else;
    f_cmdline = btrue;
  endif;

  return f_cmdline;


end-proc;

//===================================================================*
//  Prozedur:  Expands a string by inserting spaces.      (Body)     *
//===================================================================*

dcl-proc p_expstr export;
  dcl-pi *N opdesc;
    o_string               like(varString_t) options(*varsize);
    i_string        const  like(varString_t) options(*varsize);
    i_stepVal       const  like(int4_t) options(*nopass);
  end-pi;

  dcl-s ostrlen         int(10);
  dcl-s istrlen         int(10);

  //  Arbeitsfelder
  dcl-s stepval         int(10) inz;
  dcl-s iidx            int(10) inz;
  dcl-s oidx            int(10) inz;
  // ------------------------------------------------------------------------

  if (%parms() >= %parmnum(i_stepVal));
    stepval = i_stepVal;
  else;
    stepval = 1;
  endif;

  iidx = 1;
  oidx = 1;

  dow (iidx <= istrlen and oidx <= ostrlen);

    %subst(o_string: oidx: 1) = %subst(i_string: iidx: 1);

    iidx = iidx + 1;
    oidx = oidx + 1;

    for do_x1 = 1 to stepval;
      %subst(o_string: oidx: 1) = '';
      oidx = oidx + 1;
    endfor;
  enddo;

end-proc;

//===================================================================*
//  Funktion:  f_headline                                 (Body)     *
//===================================================================*

dcl-proc f_headline export;
  dcl-pi *N like(colheading_t);
    i_headtyp       const  like(type_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s heading         like(colheading_t);
  // ------------------------------------------------------------------------

  //  Überschrift ...
  select;
  //  ... Feldtext
  when i_headtyp = '*FIELDTEXT';
    if i_fldl0100.f1ftxt = ' ';
      heading = '?' + i_fldl0100.f1fnme;
    else;
      heading = i_fldl0100.f1ftxt;
    endif;
  //  ... Feldtyp
  when i_headtyp = '*FIELDTYPE';
    heading = f_fieldtypeasstring(i_fldl0100);
  //  ... Feldname
  other;
    heading = i_fldl0100.f1fnme;
  endsl;

  return heading;

end-proc;

//===================================================================*
//  Funktion:  f_isNumFld                                 (Body)     *
//===================================================================*

dcl-proc f_isnumfld export;
  dcl-pi *N        like(bool_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s isnumfld        like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1dtyp = 'S') or                                          // Zoned
  (i_fldl0100.f1dtyp = 'B') or                                          // Binary
  (i_fldl0100.f1dtyp = 'P') or                                          // Packed
  (i_fldl0100.f1dtyp = 'F');                                            // Float
    isnumfld = btrue;
  else;
    isnumfld = bfalse;
  endif;

  return isnumfld;

end-proc;

//===================================================================*
//  Funktion:  f_isFloatFld                               (Body)     *
//===================================================================*

dcl-proc f_isfloatfld export;
  dcl-pi *N        like(bool_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s isfloat         like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1dtyp = 'F');                                            // Float
    isfloat = btrue;
  else;
    isfloat = bfalse;
  endif;

  return isfloat;

end-proc;

//===================================================================*
//  Funktion:  f_isCharFld                                (Body)     *
//===================================================================*

dcl-proc f_ischarfld export;
  dcl-pi *N        like(bool_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s ischarfld       like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1dtyp = 'A' or                                           // Alpha
  i_fldl0100.f1dtyp = 'G');                                             // Graphic
    ischarfld = btrue;
  else;
    ischarfld = bfalse;
  endif;

  return ischarfld;

end-proc;

//===================================================================*
//  Funktion:  f_hasCcsid                                 (Body)     *
//===================================================================*

dcl-proc f_hasccsid export;
  dcl-pi *N        like(bool_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s hasccsid        like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1fdcc > 0 and
  i_fldl0100.f1fdcc <> 65535);
    hasccsid = btrue;
  else;
    hasccsid = bfalse;
  endif;

  return hasccsid;

end-proc;

//===================================================================*
//  Funktion:  f_appMsgF                                  (Body)     *
//===================================================================*

dcl-proc f_appmsgf export;
  dcl-pi *N        like(file_t);
  end-pi;
  //------------------------------------------------------------*

  return 'PEEKGER';

end-proc;

//===================================================================*
//  Funktion:  f_appMsgFL                                 (Body)     *
//===================================================================*

dcl-proc f_appmsgfl export;
  dcl-pi *N        like(lib_t);
  end-pi;
  //------------------------------------------------------------*

  return '*LIBL';

end-proc;

//===================================================================*
//  Prozedur:  p_rmvPgmMg                                 (Body)     *
//===================================================================*

dcl-proc p_rmvpgmmg export;
  dcl-pi *N;
    i_pgm        const  like(pgm_t);
  end-pi;

  //  Parameter für QMHRMVPM API
  dcl-s stackCount         like(int4_t) inz;
  dcl-s msgKey         char(4) inz;

  dcl-ds errCode likeds(errcode_t ) inz;

  dcl-ds qStackE qualified inz;
    mod        like(mod_t);
    pgm        like(pgm_t);
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
  errCode.bytprv = %size(errCode);

  qmhrmvpm(i_pgm: stackCount: msgKey: '*ALL': errCode
           : %size(i_pgm): qStackE: '*NO');

end-proc;

//===================================================================*
//  Prozedur:  p_sndPgmMg                                 (Body)     *
//===================================================================*

dcl-proc p_sndpgmmg export;
  dcl-pi *N;
    i_msgid         const  like(msgid_t);
    i_msgDta        const  like(msgdta_t);
    i_pgmName       const  like(pgm_t);
    i_msgType       const  like(msgtype_t) options(*nopass);
  end-pi;

  dcl-ds qMsgF      likeds(qObj_t) inz;

  dcl-s msgType     char(10) inz;
  dcl-s stackE      like(proc_t) inz;
  dcl-s stackCount  like(int4_t) inz;
  dcl-s msgKey      char(4) inz;

  dcl-ds qStackE qualified;
    module     like(mod_t) inz;
    pgm        like(pgm_t) inz;
  end-ds;

  dcl-ds errCode likeds(errcode_t) inz;
  //------------------------------------------------------------*

  if (i_msgid <> '');

    if (%subst(i_msgid: 1: 3) = 'AID' or
        %subst(i_msgid: 1: 3) = 'KEY' or
        %subst(i_msgid: 1: 3) = 'MBX' or
        %subst(i_msgid: 1: 3) = 'TXT' or
        %subst(i_msgid: 1: 3) = 'USR');
      qMsgF.name = f_appmsgf;
      qMsgF.lib = f_appmsgfl;
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
    errCode.bytprv = %size(errCode);

    msgKey = '';
    qStackE.pgm = i_pgmName;
    qStackE.module = i_pgmName;

    qmhsndpm(i_msgid: qMsgF
             : i_msgDta: %size(i_msgDta): msgType: stackE: stackCount
             : msgKey: errCode: %size(stackE): qStackE
             : -1);

  endif;

end-proc;

//===================================================================*
//  Funktion:  f_canUseRefFld                             (Body)     *
//===================================================================*

dcl-proc f_canusereffld export;
  dcl-pi *N        like(bool_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s canusereffld    like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1dtyp = 'G' or
  (i_fldl0100.f1dtyp = 'A' and
  (i_fldl0100.f1fdcc = 1200 or
  i_fldl0100.f1fdcc = 1208)));
    canusereffld = bfalse;
  else;
    canusereffld = btrue;
  endif;

  return canusereffld;

end-proc;

//===================================================================*
//  Funktion:  f_canUseCntFld                             (Body)     *
//===================================================================*

dcl-proc f_canusecntfld export;
  dcl-pi *N        like(bool_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s canusecntfld    like(bool_t) inz;
  // ------------------------------------------------------------------------

  if (i_fldl0100.f1dtyp = 'G' or
  (i_fldl0100.f1dtyp = 'A' and
  (i_fldl0100.f1fdcc = 1200 or
  i_fldl0100.f1fdcc = 1208)));
    canusecntfld = bfalse;
  else;
    canusecntfld = btrue;
  endif;

  return canusecntfld;

end-proc;

//===================================================================*
//  Funktion:  f_mustCvtCcsid                             (Body)     *
//===================================================================*

dcl-proc f_mustcvtccsid export;
  dcl-pi *N        like(bool_t);
  end-pi;

  dcl-ds jobi0400 likeds(jobi0400_t);
  // ----------------------------------------------------------------------

  if (g_jobccsid = 0);
    qusrjobi(jobi0400: %size(jobi0400): 'JOBI0400': '*': '');
    g_jobccsid = jobi0400.ccsid;
  endif;

  if (g_jobccsid = 65535); // Job CCSID = *HEX
    return btrue;
  endif;

  return bfalse;

end-proc;

//===================================================================*
//  Funktion:  f_isToLong                                 (Body)     *
//===================================================================*

dcl-proc f_istolong export;
  dcl-pi *N        like(bool_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s tolong          like(bool_t) inz;
  // ------------------------------------------------------------------------

  if f_dsplyln(i_fldl0100)>f_maxdspln(i_fldl0100);
    tolong = btrue;
  else;
    tolong = bfalse;
  endif;

  return tolong;

end-proc;

//===================================================================*
//  Funktion:  f_isToLongMax                              (Body)     *
//===================================================================*

dcl-proc f_istolongmax export;
  dcl-pi *N        like(bool_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s tolong          like(bool_t) inz;
  // ------------------------------------------------------------------------

  if f_buffln(i_fldl0100) > 1024;
    tolong = btrue;
  else;
    tolong = bfalse;
  endif;

  return tolong;

end-proc;

//===================================================================*
//  Funktion:  f_maxDspLn                                 (Body)     *
//===================================================================*

dcl-proc f_maxdspln export;
  dcl-pi *N        like(int4_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  dcl-s maxlen          int(10) inz;
  //------------------------------------------------------------*

  maxlen =  %int(f_cntfldln(i_fldl0100) * 15);
  if maxlen > 512;
    maxlen = 512;
  endif;

  return maxlen;

end-proc;

//===================================================================*
//  Funktion:  f_cntFldLn                                 (Body)     *
//===================================================================*

dcl-proc f_cntfldln export;
  dcl-pi *N        like(int4_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;
  //------------------------------------------------------------*

  if (i_fldl0100.f1dtyp = 'G');
    return 34;                                                            // TODO:18
  else;
    return 35;
  endif;

end-proc;

//===================================================================*
//  Funktion:  f_nbrDspRw                                 (Body)     *
//===================================================================*

dcl-proc f_nbrdsprw export;
  dcl-pi *N        like(int4_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  // Funktionswert
  dcl-s nbrdsprow       like(int4_t) inz;

  // Arbeitsfelder
  dcl-s dsplylen        like(int4_t);
  //------------------------------------------------------------*

  if f_istolong(i_fldl0100) = btrue;
    dsplylen = f_maxdspln(i_fldl0100);
  else;
    dsplylen = f_dsplyln(i_fldl0100);
  endif;

  nbrdsprow = dsplylen / f_cntfldln(i_fldl0100);

  if dsplylen <>
  (nbrdsprow * f_cntfldln(i_fldl0100));
    nbrdsprow = nbrdsprow + 1;
  endif;

  return nbrdsprow;

end-proc;

//===================================================================*
//  Prozedur:  p_decToBin                                 (Body)     *
//===================================================================*

dcl-proc p_dectobin export;
  dcl-pi *N opdesc;
    io_string       char(32767) options(*varsize);
    i_startpos      const  like(int4_t);
    i_length        const  like(int4_t);
    i_value         const  like(int4_t);
  end-pi;

  // Parameters passed to CEEDOD
  dcl-s desctype        int(10);
  dcl-s datatype        int(10);
  dcl-s descinfo1       int(10);
  dcl-s descinfo2       int(10);
  dcl-s parmlen         int(10);

  // Arbeitsfelder
  dcl-ds *N;
    intvalue        like(int4_t) inz;
    alpha2          char(2) overlay(intvalue: 3);
    alpha4          char(2) overlay(intvalue: 1);
  end-ds;
  // ------------------------------------------------------------------------

  ceedod(1         : desctype : datatype :
  descinfo1 : descinfo2: parmlen  :
  *omit);

  if (i_startpos + i_length - 1) > parmlen;
    p_kill('Start position and length outside range.');
  else;
    intvalue = i_value;
    select;
    when i_length = 2;
      %subst(io_string  :
            i_startpos :
            i_length   ) = alpha2;
    when i_length = 4;
      %subst(io_string  :
            i_startpos :
            i_length   ) = alpha4;
    other;
      p_kill('Incorrect length: ' + %char(i_length));
    endsl;
  endif;

end-proc;

//===================================================================*
//  Funktion:  f_isNotAlw                                 (Body)     *
//===================================================================*

dcl-proc f_isnotalw export;
  dcl-pi *N        like(bool_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  // Funktionswert
  dcl-s notAllowed      like(bool_t) inz(btrue);
  // ------------------------------------------------------------------------

  //  Wenn es sich um einen der folgenden Feldtypen handelt, ...
  if (i_fldl0100.f1dtyp = 'A' or    // = Alpha
      i_fldl0100.f1dtyp = 'B' or    // = Binary
      i_fldl0100.f1dtyp = 'P' or    // = Packed
      i_fldl0100.f1dtyp = 'S' or    // = Zoned
      i_fldl0100.f1dtyp = 'L' or    // = Date
      i_fldl0100.f1dtyp = 'T' or    // = Time
      i_fldl0100.f1dtyp = 'Z' or    // = Timestamp
      i_fldl0100.f1dtyp = 'J' or    // = DBCS-Only
      i_fldl0100.f1dtyp = 'O' or    // = DBCS-Open
      i_fldl0100.f1dtyp = 'E' or    // = DBCS-Either
      i_fldl0100.f1dtyp = 'F' or    // = Float
      i_fldl0100.f1dtyp = 'G');     // = Graphic
    //  ... dann
    //      prüfen, ob es sich um ein GRAPHIC Feld ohne CCSID handelt
    if (i_fldl0100.f1dtyp = 'G' and f_hasccsid(i_fldl0100) = bfalse);
      notAllowed = btrue;
      return notAllowed;
    endif;

    //      prüfen, ob es sich um ein Packed oder Zoned Feld mit mehr als
    //      30 Stellen handelt.
    if (i_fldl0100.f1dtyp = 'P' or i_fldl0100.f1dtyp = 'S');
      if (i_fldl0100.f1digt > 30);
        notAllowed = btrue;
        return notAllowed;
      endif;
    endif;

    //      prüfen, ob es sich um ein Feld variabler Länge handelt.

    //      Wenn es sich um ein Feld variabler Länge handelt, ...
    if (f_isvarlen(i_fldl0100) = btrue);
      //      ... dann
      //          prüfen, ob es sich um alpha-numerisches Feld handelt.
      if i_fldl0100.f1dtyp = 'A' or                                      // = Alpha
         i_fldl0100.f1dtyp = 'G';                                        // = Graphic
        notAllowed = bfalse;
      else;
        notAllowed = btrue;
      endif;
    else;
      //      ... sonst
      //          ist alles klar.
      notAllowed = bfalse;
    endif;
  else;
    //  ... sonst
    //      setzen Markierung für unbekannten Feldtyp
    notAllowed = btrue;
  endif;

  return notAllowed;

end-proc;

//===================================================================*
//  Funktion:  f_isKeyFld                                 (Body)     *
//===================================================================*

dcl-proc f_iskeyfld export;
  dcl-pi *N        like(bool_t);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  // Funktionswert
  dcl-s iskeyfld        like(bool_t) inz(bfalse);
  // ------------------------------------------------------------------------

  //  Wenn es sich um ein Schlüsselfeld handelt, ...
  if (i_fldl0100.f1keyf = '1');
    //  ... dann
    iskeyfld = btrue;
  else;
    //  ... sonst
    iskeyfld = bfalse;
  endif;

  return iskeyfld;

end-proc;

//===================================================================*
//  Prozedur:  f_pgmCallN                                 (Body)     *
//===================================================================*

dcl-proc f_pgmcalln export;
  dcl-pi *N        like(pgmcalln_t);
    i_pgmnme        const  like(pgm_t);
    i_lib           const  like(lib_t) options(*nopass);
  end-pi;
  //------------------------------------------------------------*

  if (%parms() >= %parmnum(i_lib));
    return %trimr(i_lib) + '/' + i_pgmnme;
  else;
    return %trimr(f_getprdlb()) + '/' + i_pgmnme;
  endif;

end-proc;

//===================================================================*
//  Prozedur:  p_sndStsMg                                 (Body)     *
//===================================================================*

dcl-proc p_sndstsmg export;
  dcl-pi *N;
    i_msgid         const like(msgid_t);
    i_msgdta        const like(msgdta_t);
  end-pi;

  dcl-s ymsgid          like(msgid_t) inz;

  dcl-ds yqmsgf likeds(qObj_t) inz;

  dcl-s msgKey         char(4) inz;

  dcl-ds errCode likeds(errcode_t ) inz;
  //------------------------------------------------------------*

  if (i_msgid <> '');

    yqmsgf.name = f_appmsgf();
    yqmsgf.lib = f_appmsgfl();

    msgKey = '';

    reset errCode;
    errCode.bytprv = %size(errCode);

    qmhsndpm(i_msgid: yqmsgf
             : i_msgdta: %size(i_msgdta): '*STATUS' : '*EXT'
             : 0 : msgKey : errCode );

  endif;

end-proc;

//===================================================================*
//  Prozedur:  f_rtvMsgD                                  (Body)     *
//===================================================================*

dcl-proc f_rtvmsgd export;
  dcl-pi *N              char(2048);
    i_msgid         value  like(msgid_t);
    i_msgdta        value  like(msgdta_t);
    i_rplcsubv      const  like(bool_t)
         options(*nopass);
    i_rtnfmtcc      const  like(bool_t)
         options(*nopass);
    i_msgf          value  like(file_t)
         options(*nopass);
    i_msgfl         value  like(lib_t)
         options(*nopass);
  end-pi;

  //  Parameterpositionen optionaler Parameter
  dcl-c p_rplcsubv const(3);
  dcl-c p_rtnfmtcc const(4);
  dcl-c p_msgf const(5);
  dcl-c p_msgfl const(6);

  //  Funktionswert
  /COPY QCOPYLE,RTVM0100

  //  Parameter für QMHSNDPM
  dcl-s msgdlen         int(10) inz;
  dcl-s format          char(8) inz;
  dcl-ds qmsgf;
    msgf            like(file_t)  inz;
    msgfl           like(lib_t)  inz;
  end-ds;
  dcl-s msgdtaln        int(10) inz;
  dcl-s rplcsubv        char(10) inz;
  dcl-s rtnfmtcc        char(10) inz;
  dcl-ds errcode likeds(errcode_t ) inz;

  //------------------------------------------------------------*

  clear rtvm0100;
  msgdlen  = %len(rtvm0100);
  format   = 'RTVM0100';

  if %parms >= p_msgf;
    msgf  = i_msgf;
  else;
    msgf  = f_appmsgf;
  endif;

  if %parms >= p_msgfl;
    msgfl = i_msgfl;
  else;
    msgfl = f_appmsgfl;
  endif;

  msgdtaln = %len(i_msgdta);

  //  Replace substitution variables
  if %parms >= p_rplcsubv;
    if i_rplcsubv = btrue;
      rplcsubv = '*YES';
    else;
      rplcsubv = '*NO';
    endif;
  else;
    rplcsubv = '*NO';
  endif;

  //  Return format control characters
  if %parms >= p_rtnfmtcc;
    if i_rtnfmtcc = btrue;
      rtnfmtcc = '*YES';
    else;
      rtnfmtcc = '*NO';
    endif;
  else;
    rtnfmtcc = '*NO';
  endif;

  reset errcode;
  errcode.bytprv = %size(errcode);

  qmhrtvm ( rtvm0100 : msgdlen : format :
  i_msgid : qmsgf : i_msgdta : msgdtaln :
  rplcsubv : rtnfmtcc : errcode );

  return rtvm0100;

end-proc;

//===================================================================*
//  Prozedur:  f_msgText                                  (Body)     *
//===================================================================*

dcl-proc f_msgtext export;
  dcl-pi *N              char(512);
    i_msgid         value  like(msgid_t);
    i_msgdta        value  like(msgdta_t);
    i_msgf          value  like(file_t)
         options(*nopass);
    i_msgfl         value  like(lib_t)
         options(*nopass);
  end-pi;

  //  Parameterpositionen optionaler Parameter
  dcl-c p_msgf const(3);
  dcl-c p_msgfl const(4);

  //  Funktionswert
  dcl-s msgtext         char(512) inz;

  /COPY QCOPYLE,RTVM0100
  //------------------------------------------------------------*

  select;
  when %parms =  p_msgf;
    rtvm0100 = f_rtvmsgd(i_msgid :i_msgdta:
                        btrue   :bfalse  :
                        i_msgf           );
  when %parms =  p_msgfl;
    rtvm0100 = f_rtvmsgd(i_msgid :i_msgdta:
                        btrue   :bfalse  :
                        i_msgf  :i_msgfl );
  other;
    rtvm0100 = f_rtvmsgd(i_msgid :i_msgdta:
                        btrue   :bfalse  );
  endsl;

  if rt1_lnmgrt > 0;
    msgtext = %subst(rt1_data: 1: rt1_lnmgrt);
  else;
    msgtext = ' ';
  endif;

  return msgtext;

end-proc;

//===================================================================*
//  Prozedur:  p_movPgmMg                                 (Body)     *
//===================================================================*

dcl-proc p_movpgmmg export;
  dcl-pi *N;
    i_pgmnme        const  like(pgm_t);
  end-pi;

  dcl-s msgKey      char(4) inz;
  dcl-s typesToMove char(10) dim(4);

  dcl-ds errCode likeds(errcode_t ) inz;

  dcl-ds toQStackE qualified;
    module       like(mod_t) inz;
    pgm       like(pgm_t) inz;
  end-ds;
  //------------------------------------------------------------*

  toQStackE.module = i_pgmnme;
  toQStackE.pgm = i_pgmnme;

  typesToMove(1) = '*COMP';
  typesToMove(2) = '*DIAG';
  typesToMove(3) = '*INFO';
  typesToMove(4) = '*ESCAPE';

  qmhmovpm(msgKey: typesToMove
           : %elem(typesToMove) : i_pgmnme : 2 : errCode
           : %len(%trimr(i_pgmnme)) : toQStackE : '*CHAR' : *null: 1);

end-proc;

//===================================================================*
//  Prozedur:  p_wrongKey                                 (Body)     *
//===================================================================*

dcl-proc p_wrongkey export;
  dcl-pi *N;
    i_scnaid        const  like(scnaid_t);
    i_pgmnme        const  like(pgm_t);
  end-pi;

  //  Arbeitsfelder
  dcl-ds *N;
    msgid           like(msgid_t) inz('AID');
    msgnbr          char(4) overlay(msgid: 4);
  end-ds;
  dcl-s msgdta      like(msgdta_t) inz;
  //------------------------------------------------------------*

  p_keytomsg(i_scnaid: msgid: msgdta);
  p_sndpgmmg(msgid: msgdta: i_pgmnme);

end-proc;

//===================================================================*
//  Prozedur:  p_keyToMsg                                 (Body)     *
//===================================================================*

dcl-proc p_keytomsg export;
  dcl-pi *N;
    i_scnaid        const  like(scnaid_t);
    o_msgid         like(msgid_t);
    o_msgdta        like(msgdta_t);
  end-pi;

  //  Arbeitsfelder
  dcl-ds *N;
    msgid           like(msgid_t) inz;
    msgnbr          char(4) overlay(msgid: 4);
  end-ds;
  dcl-s msgdta          like(msgdta_t) inz;
  //------------------------------------------------------------*

  msgid  = 'AID';
  msgdta = ' ';

  select;
  when i_scnaid = k_f1;
    msgnbr   = '0031';
  when i_scnaid = k_f2;
    msgnbr   = '0032';
  when i_scnaid = k_f3;
    msgnbr   = '0033';
  when i_scnaid = k_f4;
    msgnbr   = '0034';
  when i_scnaid = k_f5;
    msgnbr   = '0035';
  when i_scnaid = k_f6;
    msgnbr   = '0036';
  when i_scnaid = k_f7;
    msgnbr   = '0037';
  when i_scnaid = k_f8;
    msgnbr   = '0038';
  when i_scnaid = k_f9;
    msgnbr   = '0039';
  when i_scnaid = k_f10;
    msgnbr   = '003A';
  when i_scnaid = k_f11;
    msgnbr   = '003B';
  when i_scnaid = k_f12;
    msgnbr   = '003C';
  when i_scnaid = k_f13;
    msgnbr   = '00B1';
  when i_scnaid = k_f14;
    msgnbr   = '00B2';
  when i_scnaid = k_f15;
    msgnbr   = '00B3';
  when i_scnaid = k_f16;
    msgnbr   = '00B4';
  when i_scnaid = k_f17;
    msgnbr   = '00B5';
  when i_scnaid = k_f18;
    msgnbr   = '00B6';
  when i_scnaid = k_f19;
    msgnbr   = '00B7';
  when i_scnaid = k_f20;
    msgnbr   = '00B8';
  when i_scnaid = k_f21;
    msgnbr   = '00B9';
  when i_scnaid = k_f22;
    msgnbr   = '00BA';
  when i_scnaid = k_f23;
    msgnbr   = '00BB';
  when i_scnaid = k_f24;
    msgnbr   = '00BC';
  when i_scnaid = k_delete;
    msgnbr   = '00BD';
  when i_scnaid = k_enter;
    msgnbr   = '00F1';
  when i_scnaid = k_help;
    msgnbr   = '00F3';
  when i_scnaid = k_page_down;
    msgnbr   = '00F4';
  when i_scnaid = k_page_up;
    msgnbr   = '00F5';
  when i_scnaid = k_print_screen;
    msgnbr   = '00F6';
  when i_scnaid = k_reset;
    msgnbr   = '00F8';
  when i_scnaid = k_light_pen;
    msgnbr   = '003F';
  other;
    msgnbr   = '0100';
  endsl;

  o_msgid  = msgid;
  o_msgdta = msgdta;

end-proc;

//===================================================================*
//  Prozedur:  f_spltTxt                                  (Body)     *
//===================================================================*

dcl-proc f_splttxt_DEPRECATED export;
  dcl-pi *N opdesc like(int4_t);
    i_text          const  like(varString_t) options(*varsize);
    i_strPos        const  like(int4_t);
    i_len           const  like(int4_t);
    o_text                 like(string_t) options(*varsize);
  end-pi;

  //  Funktionswert
  dcl-s rtnLen          like(int4_t) inz;

  //  Arbeitsfelder
  dcl-s pNewLine        like(int4_t) inz;
  dcl-s nextChar        char(1) inz;
  dcl-s trimLen         like(int4_t) inz;
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
    if (i_strPos + i_len - 1) <= %len(i_text);
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
    if rtnLen = trimLen;
      // ... dann
      //     Folgezeichen im Eingabestring prüfen
      if (%len(i_text) > rtnLen);
        nextChar = %subst(i_text: rtnLen + 1: 1);

        // Wenn das Folgezeichen <> ' ' ist, d.h.
        // wir befinden uns mitten in der Zeichenkette, ...
        if (nextChar <> ' ') and (nextChar <> '°');
          // ... dann
          //     rückwärts nach einer Lücke für
          //     den Zeilenumbruch suchen
          dow trimLen > 0;
            if %subst(o_text: trimLen: 1) = ' ';
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
  dcl-pi *N like(varString_t) opdesc;
    i_text          const  like(varString_t) options(*varsize);
  end-pi;

  // Funktionswert
  dcl-s text like(varString_t);

  //  Arbeitsfelder
  dcl-s numSpaces       like(int4_t) inz;
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

dcl-proc f_addptr export;
  dcl-pi *N pointer;
    i_pointer       pointer value;
    i_offset        int(5)  value;
  end-pi;

  //  Arbeitsfelder
  dcl-s ofsary          char(1) dim(32767) based(pofsary);
  //------------------------------------------------------------*

  dow i_offset > 0;

    pofsary = i_pointer;

    if i_offset <= %elem(ofsary) - 1;
      i_pointer = %addr(ofsary(i_offset + 1));
      i_offset = 0;
    else;
      i_pointer = %addr(ofsary(%elem(ofsary)));
      i_offset = i_offset - %elem(ofsary) + 1;
    endif;

  enddo;

  return i_pointer;

end-proc;

//===================================================================*
//  Prozedur:  f_isKeyExc                                 (Body)     *
//===================================================================*

dcl-proc f_iskeyexc export;
  dcl-pi *N       like(bool_t);
    i_data          value like(set0000_t);
    i_exclkeys      value like(pgmcmd_t) dim(25);
  end-pi;

  //  Funktionswert
  dcl-s isExcluded      like(bool_t) inz;

  //  Arbeitsfelder
  dcl-s pgmCmd          like(pgmcmd_t) inz;
  dcl-s in01            like(*in01     ) inz;
  //------------------------------------------------------------*

  in01 = *in01;

  pgmCmd = i_data;
  if (%lookup(pgmCmd: i_exclkeys) > 0);
    isExcluded = btrue;
  else;
    isExcluded = bfalse;
  endif;

  *in01 = in01;

  return isExcluded;

end-proc;

//===============================================================*
//  Prepare NUM_Descr - RPG-IV implementation of NUM_DESCR macro
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
  dcl-pi *N like(int4_t);
    i_type          value  like(int1_t);
    i_length        value  like(int1_t);
    i_fraction      value  like(int1_t);
  end-pi;

  dcl-ds *N;
    num_descr       int(10) inz;
    num_descr_type
    int(3) overlay(num_descr: 1);
    num_descr_fraction
    int(3) overlay(num_descr: 2);
    num_descr_length
    int(3) overlay(num_descr: 3);
  end-ds;

  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  num_descr_type     = i_type;
  num_descr_fraction = i_fraction;
  num_descr_length   = i_length;

  return num_descr;

end-proc;

//========================================================================*
//  f_NUM_Descr2
//========================================================================*
dcl-proc f_num_descr2 export;
  dcl-pi *N like(int4_t);
    i_type          value  like(dataType_t);
    i_length        value  like(int1_t);
    i_fractional    value  like(int1_t);
  end-pi;

  //  Parameter positions

  //  Return value
  dcl-ds *N;
    num_descr       int(10) inz;
    num_descr_24    int(3) overlay(num_descr: 1);
    num_descr_16    int(3) overlay(num_descr: *next);
    num_descr_8     int(3) overlay(num_descr: *next);
    num_descr_0     int(3) overlay(num_descr: *next);
  end-ds;

  //  Arbeitsfelder
  dcl-s type            int(3) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  // Convert RPG type ...
  select;
  // ... zoned
  when (i_type = 'S');
    type = t_zoned;
  // ... packed
  when (i_type = 'P');
    type = t_packed;
  // ... binary
  when (i_type = 'B');
    type = t_signed;
    i_length = f_rpgtointlength(i_length);
  // ... integer
  when (i_type = 'I');
    type = t_signed;
    i_length = f_rpgtointlength(i_length);
  // ... unsigned integer
  when (i_type = 'U');
    type = t_signed;
    i_length = f_rpgtointlength(i_length);
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
dcl-proc f_rpgtointlength export;
  dcl-pi *N              int(10);
    i_length        int(10) value;
  end-pi;

  //  Return value
  dcl-s intlength       int(10) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  select;
  when (i_length <= 3);
    intlength = 1;
  when (i_length <= 5);
    intlength = 2;
  when (i_length <= 10);
    intlength = 4;
  when (i_length <= 20);
    intlength = 8;
  other;
    intlength = -1;
  endsl;

  return intlength;


end-proc;

//===============================================================*
//  Clears C error code.
//===============================================================*

dcl-proc p_clrerrno export;
  dcl-pi *N;
  end-pi;

  dcl-s runtimeerror    int(10) based(pruntimeerror);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  pruntimeerror = errno();
  runtimeerror = 0;

end-proc;

//===============================================================*
//  Returns C runtime error code.
//===============================================================*

dcl-proc f_errno export;
  dcl-pi *N              int(10);
  end-pi;

  dcl-s runtimeerror    int(10) based(pruntimeerror);
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  pruntimeerror = errno();

  return runtimeerror;

end-proc;

//===============================================================*
//  Returns the description of a given C runtime error code.
//===============================================================*

dcl-proc f_strerror export;
  dcl-pi *N        like(msgdta_t);
    i_errno         int(10) const;
  end-pi;

  //  Funktionswert
  dcl-s errtext         like(msgdta_t) inz;

  dcl-s perrtext        pointer inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  perrtext = strerror(i_errno);
  if   perrtext = *null;
    errtext = '';
  else;
    errtext = %str(perrtext);
  endif;

  return errtext;

end-proc;

//===============================================================*
//  Returns the bit-wise ORing of the bits of all the arguments.
//===============================================================*

dcl-proc f_bitor export;
  dcl-pi *N              uns(10);
    i_arg1          uns(10) value;
    i_arg2          uns(10) value;
    i_arg3          uns(10) value  options(*nopass);
    i_arg4          uns(10) value  options(*nopass);
    i_arg5          uns(10) value  options(*nopass);
  end-pi;

  //  Parameterpositionen optionaler Parameter
  dcl-c p_arg3 const(3);
  dcl-c p_arg4 const(4);
  dcl-c p_arg5 const(5);

  //  Funktionswert
  dcl-s result          uns(10) inz;

  //  OR String (ORSTR)
  dcl-pr orstr extproc('_ORSTR');
    i_preceiver     pointer value;
    i_pfirstsrc     pointer value  options(*string);
    i_psecondsrc    pointer value  options(*string);
    i_length        uns(10) value;
  end-pr;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  orstr(%addr(result): %addr(i_arg1): %addr(i_arg2): %size(result));

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
  dcl-pi *N              ind;
    i_obj           char(10) const;
    i_lib           char(10) const  options(*omit);
    i_type          char(10) const;
    i_mbr           char(10) const  options(*nopass);
  end-pi;

  //  Return value
  dcl-s doesexist       ind inz(bfalse);

  //  Parameter positions
  dcl-c p_lib const(2);
  dcl-c p_mbr const(4);

  //  Optional parameter fields
  dcl-s lib             like(i_lib       ) inz;
  dcl-s mbr             like(i_mbr       ) inz;

  //  Local fields
  dcl-ds objd0100 likeds(objd0100_t) inz;
  dcl-ds mbrd0100 likeds(mbrd0100_t) inz;
  dcl-ds qobj likeds(qobj_t) inz;
  dcl-ds errcode likeds(errcode_t ) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  // Process optional parameter values ...
  // ... i_lib
  if (%parms() >= p_lib and %addr(i_lib) <> *null);
    lib = i_lib;
  else;
    lib = '*LIBL';
  endif;

  // ... i_mbr
  if (%parms() >= p_mbr);
    mbr = i_mbr;
  else;
    mbr = '*NONE';
  endif;

  // Retrieve the object description
  qobj.name = i_obj;
  qobj.lib  = lib;
  reset errcode;
  errcode.bytprv = %size(errcode);
  qusrobjd(objd0100: %size(objd0100): 'OBJD0100'
  : qobj: i_type: errcode);

  // Retrieve member description if object is a file
  // and a member name was given
  if (errcode.bytavl = 0) and (mbr <> '*NONE');
    reset errcode;
    errcode.bytprv = %size(errcode);
    qusrmbrd(mbrd0100: %size(mbrd0100): 'MBRD0100'
    : qobj: mbr: '0': errcode);
  endif;

  // Set return value
  if (errcode.bytavl = 0);
    doesexist = btrue;
  else;
    doesexist = bfalse;
  endif;

  return doesexist;

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
//                   Default:        cWORDWRAP_PARAGRAPH_NONE +
//                                   cWORDWRAP_PARAGRAPH_TRIMR
//                   cWORDWRAP_PARAGRAPH_NONE   Do not respect
//                                              end-of-paragraph markers.
//                   cWORDWRAP_PARAGRAPH_MSGD   Respect end-of-paragraph
//                                              markers of message descriptions:
//                                              &N, &B and &P.
//                   cWORDWRAP_PARAGRAPH_TEXT   Respect standard text
//                                              end-of-paragraph markers: \n
//                   cWORDWRAP_PARAGRAPH_TRIMR  Remove trailing blanks from
//                                              result string.

//  Returns:
//   text          - The next line of i_string.
//=========================================================================

dcl-proc f_wordwrap export;
  dcl-pi *N              varchar(4096);
    i_string        varchar(4096) const;
    i_width         uns(10) const;
    io_startpos     uns(10);
    i_options       uns(10) const  options(*nopass);
  end-pi;

  //  Return value
  dcl-s text            varchar(4096) inz;

  //  Parameter positions
  dcl-c p_options const(4);

  //  Optional parameter fields
  dcl-s options         like(i_options) inz;

  //  Local fields
  dcl-ds theeop qualified;
    isfound         ind inz(bfalse);
    position        int(10);
    string          varchar(2);
  end-ds;
  dcl-s x               int(10) inz;
  dcl-s tmpeop          varchar(2) inz;
  dcl-s numeop          int(10) inz;
  dcl-s eop             like(tmpeop) dim(3) inz;
  dcl-s esc             char(1);
  dcl-s startpos        like(io_startpos  ) inz;
  dcl-s string          like(i_string     ) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  // Process optional parameter values ...
  // ... options
  if %parms >= p_options;
    options = i_options;
  else;
    options = cwordwrap_paragraph_none +
    cwordwrap_paragraph_trimr;
  endif;

  // TRIM trailing blanks
  string = %trimr(i_string);

  // Determine how to treat end-of-paragraph markers:
  select;
  // ... do not respect end-of-paragraph marker
  when isBitOn(cwordwrap_paragraph_none: options);
    clear eop;
    clear esc;
    numeop = 0;
  // ... respect end-of-paragraph marker of message descriptions: &N, &P, &B
  when isBitOn(cwordwrap_paragraph_msgd: options);
    clear eop;
    eop(1) = '&N';
    eop(2) = '&P';
    eop(3) = '&B';
    esc    = '&';
    numeop = 3;
  // ... respect end-of-paragraph marker of text: \n
  when isBitOn(cwordwrap_paragraph_text: options);
    clear eop;
    eop(1) = '\N';
    esc    = '\';
    numeop = 1;
  endsl;

  // ---------------------------------------------------
  //  Perform word-wrap with no respect to
  //  end-of-paragraph markers.
  // ---------------------------------------------------
  if numeop = 0;
    text = lf_wordwrap(string: i_width: io_startpos);
  else;
    // ---------------------------------------------------
    //  Perform word-wrap with respect to
    //  end-of-paragraph markers.
    // ---------------------------------------------------

    // Find next end-of-paragraph marker
    reset theeop;
    theeop.isfound = bfalse;
    theeop.position = %scan(esc: string: io_startpos);
    dow not theeop.isfound and theeop.position > 0;
      // If there is an escape character, ...
      if %subst(string: theeop.position: 1) = esc;
        // ... then check it against the list of EOP marker
        for x = 1 to numeop;
          // If there is enough space for a EOP after the escape character
          // and if it is a known EOP, ...
          if theeop.position <= %len(string) - %len(eop(x)) + 1;
            tmpeop = %subst(string: theeop.position: %len(eop(x)));
            if f_ucase(tmpeop) = f_ucase(eop(x));
              // ... then set flag "EOP found"
              theeop.string  = eop(x);
              theeop.isfound = btrue;
              leave;
            endif;
          endif;
        endfor;
      endif;

      if (not theeop.isfound);
        if (theeop.position < %len(string));
          theeop.position = %scan(esc: string: theeop.position + 1);
        else;
          theeop.position = 0;
        endif;
      endif;
    enddo;

    // If no end-of-paragraph marker is found, ...
    if not theeop.isfound;
      // ... then perform standard word wrap with no respect to EOP
      text = lf_wordwrap(string: i_width: io_startpos);
    else;
      // ... else perform word wrap for text portion
      //     before end-of-paragraph marker
      if (theeop.position - io_startpos) > 0;
        string   = %subst(string: io_startpos:
          theeop.position - io_startpos);
        startpos = 1;
        text = lf_wordwrap(string: i_width: startpos);
      else;
        text = '';
      endif;

      // If all we got is a EOP, ...
      if (%len(text)    = %len(theeop.string)   ) and
         (f_ucase(text) = f_ucase(theeop.string));
        // ... then delete it
        text = '';
      endif;
      // Set new start position. Skip EOP if EOP
      // caused new line.
      io_startpos = io_startpos + %len(text);
      if theeop.position = io_startpos;
        io_startpos = io_startpos + %len(theeop.string);
      endif;
      // Set start position to 0 if new start position
      // exceeds maximum length of text.
      if io_startpos > %len(i_string);
        io_startpos = 0;
      endif;
    endif;

  endif;

  // If the user requested to remove BLANKS, ...
  if isBitOn(cwordwrap_paragraph_trimr: options);
    // ... then remove BLANKS.
    text = %trimr(text);
  endif;

  return   text;

end-proc;

//=========================================================================
//  Performs word wrapping on a given string without respect to
//  end-of-paragraph markers.
//=========================================================================

dcl-proc lf_wordwrap;
  dcl-pi *N              varchar(4096);
    i_string        varchar(4096) const;
    i_width         uns(10) const;
    io_startpos     uns(10);
  end-pi;

  //  Return value
  dcl-s text            varchar(4096) inz;

  //  Local fields
  dcl-s spos            int(10) inz;
  dcl-s epos            int(10) inz;
  dcl-s eposconst       int(10) inz;
  dcl-s length          int(10) inz;
  dcl-s char            char(1) inz;
  dcl-s x               int(10) inz;

  //  Valid separater characters
  dcl-c cdelimiter const(' -/\.:');
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  // Initialise helper fields
  text   = '';
  spos   = io_startpos;
  epos   = 0;
  length = 0;

  // Set range
  epos      = spos + i_width;
  eposconst = epos;

  // If the end position is out of range ...
  if   epos > %len(i_string);
    // ... then
    //     assume the last character to be the delimiter
    epos = %len(i_string);
  else;
    // ... else
    //     look backwards for a deliniter.
    dow   epos >= spos;
      char = %subst(i_string: epos: 1);
      // At position width + 1 ...
      if   epos = eposconst;
        // ... only BLANKS are allowed
        x = %check(' ': char);
      else;
        // ... else every delimiter is allowed
        x = %check(cdelimiter: char);
      endif;
      // If there is a delimiter, ...
      if (x = 0 or char < x'40');
        // ... then stop searching
        x = 0;
        leave;
      endif;

      epos = epos - 1;
    enddo;
  endif;

  // If there is no delimiter, ...
  if   epos < spos;
    // ... then assume the last character to be the delimiter.
    epos = spos + i_width - 1;
  endif;

  // Retrieve text (incl. delimiter) ...
  length = epos - spos + 1;
  text = %subst(i_string: spos: length);

  // ... and set new start position.
  spos = spos + length;
  if spos <= %len(i_string);
    io_startpos = %check(' ': i_string: spos);
  else;
    io_startpos = 0;
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
  dcl-pi *N ind;
    i_testbit       uns(10) value;
    i_value         uns(10) value;
  end-pi;

  //  Return value
  dcl-s ison            ind inz(btrue);

  //  Helper fields
  dcl-s x               int(3) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  ison = btrue;

  for   x = (%size(i_value) * 8) - 1 downto 0 ;
    if   tstbts(%addr(i_testbit): x) <> 0;
      if   tstbts(%addr(i_value): x) = 0;
        ison = bfalse;
        leave;
      endif;
    endif;
  endfor;

  if (%bitand(i_value: i_testbit) = i_testbit);
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
  dcl-pi *N              varchar(4096);
    i_string        varchar(4096) const;
  end-pi;

  //  Return value
  dcl-s string          varchar(4096) inz;

  //  Fields for QlgConvertCase API
  dcl-s stringbuf       char(4096) inz;
  dcl-ds errcode likeds(errcode_t ) inz;

  dcl-ds reqctrlblk likeds(QLGCNVCS_reqCtrlBlk_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


  if   i_string <> '';
    reqctrlblk.type = CVTCASE_TYPE_CCSID;
    reqctrlblk.ccsid = CVTCASE_CCSID_Job;
    reqctrlblk.case = CVTCASE_TO_UPPER;
    reqctrlblk.reserved = *allx'00';

    reset errcode;

    qlgconvertcase(reqctrlblk
                   : i_string: stringbuf: %len(i_string): errcode);
    string = %subst(stringbuf: 1: %len(i_string));
  else;
    string = i_string;
  endif;

  return   string;

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

dcl-proc f_endswith export;
  dcl-pi *N              ind;
    i_suffix        varchar(4096) const;
    i_string        varchar(4096) const;
  end-pi;

  //  Return value
  dcl-s endswith        ind inz(bfalse);

  //  Local fields
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  if %len(i_string) = 0  or
  %len(i_suffix) = 0  or
  %len(i_string) < %len(i_suffix);
    return endswith;
  endif;

  if %subst(i_string
  : %len(i_string) - %len(i_suffix) + 1) = i_suffix;
    endswith = btrue;
  endif;

  return   endswith;


end-proc;

//=========================================================================
//  Sends a message to the command line.
//=========================================================================
//  Parameters:
//   i_msg         - The message.

//  Returns:
//   void
//=========================================================================
dcl-proc f_sndmsgtocmdline export;
  dcl-pi *N;
    i_msgid         char(7) const;
    i_msgdta        char(512) const;
  end-pi;

  //  Local fields
  dcl-s msgkey          char(4) inz;

  dcl-ds qmsgf qualified            inz;
    name            char(10);
    lib             char(10);
  end-ds;

  dcl-ds errcode qualified            inz;
    bytprv          int(10);
    bytavl          int(10);
    excid           char(7);
    reserved        char(1);
    excdta          char(256);
  end-ds;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  clear qmsgf;
  qmsgf.name = f_appmsgf;
  qmsgf.lib  = f_appmsgfl;

  clear errcode;
  errcode.bytprv = %size(errcode);

  qmhsndpm(i_msgid: qmsgf: i_msgdta: %size(i_msgdta): '*DIAG'
           : 'PEEK': 2: msgkey: errcode);

end-proc;

//===================================================================*
//  Funktion:  f_fieldTypeAsString                        (Body)     *
//===================================================================*

dcl-proc f_fieldtypeasstring export;
  dcl-pi *N              varchar(128);
    i_fldl0100      const  likeds(fldl0100_t);
  end-pi;

  //  Funktionswert
  dcl-s type            varchar(128) inz;

  //  Arbeitsfelder
  dcl-s length          zoned(5) inz;
  dcl-s decpos          zoned(2) inz;
  dcl-s lengtha         varchar(16) inz;
  dcl-s decposa         varchar(16) inz;
  // ------------------------------------------------------------------------

  if (f_isnumfld(i_fldl0100) = btrue);
    length = i_fldl0100.f1digt;
    decpos = i_fldl0100.f1decp;
    lengtha = %editc(length: '3');
    decposa = %editc(decpos: '3');
  else;
    length = i_fldl0100.f1flen;
    decpos = -1;
    lengtha = %editc(length: '3');
    decposa = '  ';
  endif;

  type = i_fldl0100.f1fnme +
  '  ' + x'41'      +
  lengtha           +
  i_fldl0100.f1dtyp +
  ' '               +
  decposa           +
  x'41';

  return type;


end-proc;

//===================================================================*
//  Funktion:  f_nextHeaderType                           (Body)     *
//===================================================================*

dcl-proc f_nextheadertype export;
  dcl-pi *N              char(10);
    i_headertype    char(10) value;
  end-pi;

  //  Funktionswert
  dcl-s type            char(10) inz;
  // ------------------------------------------------------------------------

  select;
  when (i_headertype = '*FIELDNAME');
    type = '*FIELDTEXT';
  when (i_headertype = '*FIELDTEXT');
    type = '*FIELDTYPE';
  other;
    type = '*FIELDNAME';
  endsl;

  return type;


end-proc;

//===================================================================*
//  Funktion:  f_getRecordFormatID                        (Body)     *
//===================================================================*

dcl-proc f_getrecordformatinf export;
  dcl-pi *N likeds(rcdfmtinf_t);
    i_file          value  like(file_t);
    i_lib           value  like(lib_t);
    i_rcdfmt        value  like(fmtid_t);
  end-pi;

  //  Funktionswert
  dcl-ds rcdfmtinf likeds(rcdfmtinf_t);

  dcl-ds qfile likeds(qobj_t);
  dcl-ds qfilertn likeds(qfile);
  dcl-ds qdb_qddfmt likeds(qdb_qddfmt_t)
  based(pqdb_qddfmt);
  dcl-s size            int(10);
  dcl-ds errcode likeds(errcode_t) inz;
  // ----------------------------------------------------------------------

  clear rcdfmtinf;

  qfile.name = i_file;
  qfile.lib = i_lib;

  size = (8);
  pqdb_qddfmt = %alloc(size);

  monitor;
    qdbrtvfd(qdb_qddfmt: size: qfilertn: 'FILD0200': qfile
    :'*FIRST' :'0' :'*LCL' :'*EXT' : errcode);

    size = (qdb_qddfmt.bytavl);
    pqdb_qddfmt = %realloc(pqdb_qddfmt: size);
    qdbrtvfd(qdb_qddfmt: size: qfilertn: 'FILD0200': qfile
    :'*FIRST' :'0' :'*LCL' :'*EXT' : errcode);

    rcdfmtinf.name = qdb_qddfmt.qddfname;
    rcdfmtinf.id = qdb_qddfmt.qddfseq;
  on-error;
  endmon;

  dealloc(n) pqdb_qddfmt;

  return rcdfmtinf;

end-proc;

//===================================================================*
//  Funktion:  f_space                                    (Body)     *
//===================================================================*

dcl-proc f_space export;
  dcl-pi *N like(varString_t);
    i_length        int(10) value;
  end-pi;

  //  Funktionswert
  dcl-s spaces          varchar(4096);

  dcl-s x               int(10);
  // ------------------------------------------------------------------------

  x = i_length;
  dow x > 0;
    spaces = spaces + ' ';
    x = x - 1;
  enddo;

  return spaces;

end-proc;

//===================================================================*
//  Funktion:  Kills the program, sending an *ESCAPE message.        *
//===================================================================*
dcl-proc p_kill export;
  dcl-pi *N;
    i_text          varchar(128) value;
  end-pi;

  //  Local fields
  dcl-s msgKey          char(4) inz;

  //  Qualified message file name
  dcl-ds qMsgF likeds(qObj_t) inz;

  //  API error code
  dcl-ds errCode likeds(errCode_t) inz;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  clear qMsgF;
  qMsgF.name = 'QCPFMSG';
  qMsgF.lib  = '*LIBL';

  clear errCode;
  errCode.bytprv = %size(errCode);

  qmhsndpm('CPF9897': qMsgF: i_text: %len(i_text): '*ESCAPE'
           : '*PGMBDY': 1: msgKey: errCode);

end-proc;

//===================================================================*
//  Map command to message ID.                            (Body)     *
//===================================================================*

dcl-proc f_mapcmdtomsg export;
  dcl-pi *N like(msgid_t);
    i_command       char(256) const;
  end-pi;

  //  Funktionswert
  dcl-s msgid           like(msgid_t);
  // ------------------------------------------------------------------------

  select;
  when i_command = '*ENTER';
    msgid = '0001';
  when i_command = '*EXIT';
    msgid = '0002';
  when i_command = '*REFRESH';
    msgid = '0003';
  when i_command = '*ADD';
    msgid = '0004';
  when i_command = '*HEADLINE';
    msgid = '0005';
  when i_command = '*TGLMRKCOL';
    msgid = '0006';
  when i_command = '*MOVETOP';
    msgid = '0007';
  when i_command = '*POSCSR';
    msgid = '0008';
  when i_command = '*SEARCH';
    msgid = '0009';
  when i_command = '*TOP';
    msgid = '0010';
  when i_command = '*BOT';
    msgid = '0011';
  when i_command = '*LEFT';
    msgid = '0012';
  when i_command = '*RIGHT';
    msgid = '0013';
  when i_command = '*CMDLINE';
    msgid = '0014';
  when i_command = '*132/80';
    msgid = '0015';
  when i_command = '*MOREKEYS';
    msgid = '0016';
  when i_command = '*PAGEDOWN';
    msgid = '0017';
  when i_command = '*PAGEUP';
    msgid = '0018';
  when i_command = '*PINROW';
    msgid = '0019';
  when i_command = '*UNPINROW';
    msgid = '0020';
  when i_command = '*CHANGE';
    msgid = '0021';
  when i_command = '*COPY';
    msgid = '0022';
  when i_command = '*DELETE';
    msgid = '0023';
  when i_command = '*DISPLAY';
    msgid = '0024';
  when i_command = '*USERSETG';
    msgid = '0025';
  when i_command = '*CANCEL';
    msgid = '0026';
  when i_command = '*SAVE_EXIT';
    msgid = '0027';
  when i_command = '*PINCOL';
    msgid = '0028';
  when i_command = '*UNPINCOL';
    msgid = '0029';
  when i_command = '*TGLPINCOL';
    msgid = '0030';
  when i_command = '*TBLPAPON';
    msgid = '0031';
  when i_command = '*TBLPAPOFF';
    msgid = '0032';
  when i_command = '*TGLTBLPAP';
    msgid = '0033';
  when i_command = '*YESTOALL';
    msgid = '0034';
  when i_command = '*MOREOPT';
    msgid = '0035';
  when i_command = '*COPYEXT';
    msgid = '0036';
  when i_command = '*MRKCOL';
    msgid = '0037';
  when i_command = '*UNMRKCOL';
    msgid = '0038';
  when i_command = '*LOWERCASE';
    msgid = '0039';
  when i_command = '*UPPERCASE';
    msgid = '0040';
  when i_command = '*TGLLUCASE';
    msgid = '0041';
  when i_command = '*SPLASHON';
    msgid = '0042';
  when i_command = '*SPLASHOFF';
    msgid = '0043';
  when i_command = '*PAGELEFT';
    msgid = '0044';
  when i_command = '*PAGERIGHT';
    msgid = '0045';
  when i_command = '*REPEAT';
    msgid = '0046';
  when i_command = '*REBUILD';
    msgid = '0047';
  when i_command = '*CLRPINROW';
    msgid = '0048';
  when i_command = '*CLRPINCOL';
    msgid = '0049';
  when i_command = '*LAYOUT';
    msgid = '0050';
  when i_command = '*FLOATKEYS';
    msgid = '0051';
  when i_command = '*SELECT';
    msgid = '0052';
  when i_command = '*NEXTMARK';
    msgid = '0053';
  when i_command = '*PREVMARK';
    msgid = '0054';
  when i_command = '*DSPDBR';
    msgid = '0055';
  when i_command = '*PROMPT';
    msgid = '0056';
  when i_command = '*KEY';
    msgid = '0057';
  when i_command = '*RRN';
    msgid = '0058';
  when i_command = '*TGLACCESS';
    msgid = '0059';
  when i_command = '*HEXEDIT';
    msgid = '0060';
  when i_command = '*ABOUT';
    msgid = '0061';
  when i_command = '*PINCOLDLG';
    msgid = '0062';
  when i_command = '*CLRALL';
    msgid = '0063';
  when i_command = '*DSPNRM';
    msgid = '0064';
  when i_command = '*DSPHEX';
    msgid = '0065';
  when i_command = '*TGLDSP';
    msgid = '0066';
  when i_command = '*SQL';
    msgid = '0067';
  when i_command = '*INSKEYFLD';
    msgid = '0068';
  when i_command = '*SAVEENV';
    msgid = '0069';
  when i_command = '*LOADENV';
    msgid = '0070';
  when i_command = '*DELETEENV';
    msgid = '0071';
  when i_command = '*TGLSORT';
    msgid = '0072';
  when i_command = '*YES';
    msgid = '0073';
  when i_command = '*NO';
    msgid = '0074';
  when i_command = '*OK';
    msgid = '0075';
  when i_command = '*FIRSTPOS';
    msgid = '0076';
  when i_command = '*LASTPOS';
    msgid = '0077';
  when i_command = '*SLCENV';
    msgid = '0078';
  when i_command = '*SLCLAYOUT';
    msgid = '0079';
  when i_command = '*TGLNULL';
    msgid = '0080';
  when i_command = '*TGLINPUT';
    msgid = '0081';
  when i_command = '*STREDIT';
    msgid = '0082';
  when i_command = '*TGLRCDLCK';
    msgid = '0083';
  when i_command = '*TGLKEYLUC';
    msgid = '0084';
  when i_command = '*PRINT';
    msgid = '0085';
  other;
    msgid = '';
  endsl;

  return msgid;

end-proc;

