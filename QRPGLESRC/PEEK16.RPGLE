**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.2.0                               *
//  Programm : PEEK16                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 14.10.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Generieren RPG-LE Programm                                   *
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

dcl-f qpeekgen extdesc('QPEEKGEN') usage(*output) usropn rename(qpeekgen: foutput) block(*no);

dcl-f qcopyle1 extdesc('QPEEKGEN') usropn rename(qpeekgen: fcopy1);

dcl-f qcopyle2 extdesc('QPEEKGEN') usropn rename(qpeekgen: fcopy2);

dcl-f qcopyle3 extdesc('QPEEKGEN') usropn rename(qpeekgen: fcopy3);

dcl-f qcopyle4 extdesc('QPEEKGEN') usropn rename(qpeekgen: fcopy4);

dcl-f qcopyle5 extdesc('QPEEKGEN') usropn rename(qpeekgen: fcopy5);

dcl-f qcopyle6 extdesc('QPEEKGEN') usropn rename(qpeekgen: fcopy6);

dcl-f peekSrc usropn rename(peekSrc: finput);

dcl-f peekFld usropn;

//===============================================================*
//  Datenstrukturen für die Codegenerierung
//===============================================================*

dcl-ds ds_page len(112);
  $page_spc char(1) inz('C') pos(6);
  $page_f2a char(19) inz('When      scnNbr = ') pos(26);
  $page_f2b zoned(3) inz;
end-ds;

dcl-ds ds_chkCh len(112);
  $chkCh_spc char(1) inz('C') pos(6);
  $chkCh_opC char(6) inz('Exsr') pos(26);
  $chkCh_f2a char(7) inz('chkChar') pos(36);
  $chkCh_f2b zoned(3) inz;
end-ds;

dcl-ds ds_exfmt len(112);
  $exfmt_spc char(1) inz('C') pos(6);
  $exfmt_neg char(1) inz('N') pos(9);
  $exfmt_ind char(2) inz('71');
  $exfmt_opC char(6) inz('Exfmt') pos(26);
  $exfmt_ext char(4) inz;
  $exfmt_sc  char(2) inz('UC');
  $exfmt_scN zoned(3) inz;
end-ds;

dcl-ds ds_more len(112);
  $more_scnN zoned(3) inz pos(46);
end-ds;

dcl-ds ds_fmtNme len(112);
  $fmtNm_xNm char(10) inz pos(51);
end-ds;

dcl-ds ds_rnmBuf len(112);
  $rnmBf_spc char(1) inz('I') pos(6);
  $rnmBf_xFd char(10) inz pos(21);
  $rnmBf_iFd char(14) inz pos(49);
end-ds;

dcl-ds ds_rnmEx len(112);
  $rnmEx_spc char(1) inz('D') pos(6);
  $rnmEx_iFd char(15) inz;
  $rnmEx_ext char(1) inz('E');
  $rnmEx_xFd char(37) inz pos(44);
end-ds;

dcl-ds ds_ovlEx len(112);
  $ovlEx_spc char(1) inz('D') pos(6);
  $ovlEx_iFd char(15) inz;
  $ovlEx_typ char(5) inz pos(38);
  $ovlEx_xFd char(37) inz pos(44);
end-ds;

dcl-ds ds_lcas len(112);
  $lcas_inz char(6) inz pos(65);
end-ds;

dcl-ds ds_rcdLock len(112);
  $rcdLock_inz char(6) inz pos(65);
end-ds;

dcl-ds ds_alwl len(112);
  $alwl_inz char(6) inz pos(65);
end-ds;

dcl-ds ds_keepCrs len(112);
  $keepCrs_inz char(4) inz pos(44);
end-ds;

dcl-ds ds_ucs2 len(112);
  $ucs2_value char(14) inz pos(46);
end-ds;

dcl-ds ds_bufLen len(112);
  $bufLn_ln zoned(5) inz pos(35);
end-ds;

dcl-ds ds_eval len(112);
  $eval_spc  char(1) inz('C') pos(6);
  $eval_code char(6) inz('Eval') pos(26);
  $eval_fct2 char(45) inz pos(36);
end-ds;

dcl-ds ds_for len(112);
  $for_spc  char(1) inz('C') pos(6);
  $for_code char(6) inz('For') pos(26);
  $for_fct2 char(45) inz pos(36);
end-ds;

dcl-ds ds_endfor len(112);
  $endFor_spc  char(1) inz('C') pos(6);
  $endFor_oper char(6) inz('Endfor') pos(26);
end-ds;

dcl-ds ds_select len(112);
  $select_spc  char(1) inz('C') pos(6);
  $select_code char(6) inz('Select') pos(26);
  $select_fct2 char(45) inz pos(36);
end-ds;

dcl-ds ds_when len(112);
  $when_spc  char(1) inz('C') pos(6);
  $when_code char(6) inz('When') pos(26);
  $when_fct2 char(45) inz pos(36);
end-ds;

dcl-ds ds_endsl len(112);
  $endSl_spc  char(1) inz('C') pos(6);
  $endSl_oper char(6) inz('Endsl') pos(26);
end-ds;

dcl-ds ds_if len(112);
  $if_spc  char(1) inz('C') pos(6);
  $if_if   char(6) inz('If') pos(26);
  $if_fct2 char(45) inz pos(36);
end-ds;

dcl-ds ds_cont len(112);
  $cont_spc  char(1) inz('C') pos(6);
  $cont_fct2 char(45) inz pos(36);
end-ds;

dcl-ds ds_else len(112);
  $else_spc  char(1) inz('C') pos(6);
  $else_oper char(6) inz('Else') pos(26);
end-ds;

dcl-ds ds_endif len(112);
  $endif_spc  char(1) inz('C') pos(6);
  $endif_oper char(6) inz('Endif') pos(26);
end-ds;

dcl-ds ds_clear len(112);
  $clear_spc   char(1) inz('C') pos(6);
  $clear_oper  char(6) inz('Clear') pos(26);
  $clear_field char(14) inz pos(50);
end-ds;

dcl-ds ds_remark len(112);
  $rem_atrB char(1) inz(COLOR_white);
  $rem_rem  char(1) inz('*') pos(7);
  $rem_txt  char(103) inz pos(10);
end-ds;

dcl-ds ds_begsr len(112);
  $begsr_spc char(1) inz('C') pos(6);
  $begsr_f1  char(14) inz pos(12);
  $begsr_opC char(10) inz('Begsr');
end-ds;

dcl-ds ds_endsr len(112);
  $endsr_spc char(1) inz('C') pos(6);
  $endsr_opC char(10) inz('Endsr') pos(26);
end-ds;

dcl-ds ds_exsr len(112);
  $exsr_spc  char(1) inz('C') pos(6);
  $exsr_opC  char(10) inz('Exsr') pos(26);
  $exsr_fct2 char(14) inz;
end-ds;

dcl-s #srcSeq like(srcSeq);
dcl-c #Increment 0,01;

dcl-ds *n;
  fieldCount zoned(5) inz(*zeros);
  a#fldCount char(5) overlay(fieldCount: 1);
end-ds;

/copy QCOPYLE,SDS

dcl-s cmd char(4) inz;
dcl-s scnNbr like(int4_t) inz;

dcl-c UNKNOWN_FIELD_TYPE ': Unknown field type';

dcl-s pos int(10) inz;

dcl-s totFields int(10) inz;
dcl-s curField zoned(2) inz;

dcl-s nullDft char(4) inz;

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_COLORATR

/define internal_prototype
/copy QCOPYLE,PPEEK16
/undefine internal_prototype

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-pr p_wrtOut extproc(*dclcase);
  i_srcDta like(srcDta) const;
end-pr;

dcl-pr f_readFld like(bool_t) extproc(*dclcase);
end-pr;

//====================================================*
//  Steuerleiste
//====================================================*

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK61

/copy QCOPYLE,CEECNDHDLR
dcl-pi peek16;
  i_prodLib   like(lib_t) const;
  i_fileName  likeds(qObj_t) const;
  i_rcdFmt    like(rcdFmt_t) const;
  i_scnNbrs   like(int2_t) const;
  i_alwLC     like(bool_t) const;
  i_case      like(bool_t) const;
  i_rcdLock   like(bool_t) const;
  i_nullDft   like(bool_t) const;
  i_keepCrs   like(bool_t) const;
  io_stage    like(int4_t);
  i_numPasses like(int4_t) const;
end-pi;

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

open qpeekgen;
open peekSrc;

#srcSeq = 0;

dow ('1');
  read finput;
  if (%eof());
    leave;
  endif;

  cmd = %subst(srcDta: 1: 4);

  select;

  //  File 1
  when (cmd = 'FMT1');
    ds_fmtNme = srcDta;
    $fmtNm_xNm = i_rcdFmt;
    p_wrtOut(ds_fmtNme);

  //  Felddefinitionen
  when (cmd = 'DEF1');
    p_wrtOut(srcDta);
    exsr sub014;

  //  Umbenennen /copy Anweisungen
  when (cmd = 'COPY');
    exsr sub025;
    p_wrtOut(srcDta);

  //  Konstanten für "Feld zu lang"
  when (cmd = 'DEF2');
    p_wrtOut(srcDta);
    exsr sub016;

  //  Prüfen ...
  when (cmd = 'CHKS');
    p_wrtOut(srcDta);
    exsr sub015;

  //  Blättern ...
  when (cmd = 'SCRN');
    p_wrtOut(srcDta);
    exsr sub003;

  //  Letzte Seite ...
  when (cmd = 'LSCN');
    exsr sub001;

  //  isLower ...
  when (cmd = 'LCAS');
    exsr sub002;

  //  isRcdLock...
  when (cmd = 'RLCK');
    exsr sub019;

  //  Übertragen Dateifelder in Bildschirmfelder
  when (cmd = 'TSCN');
    p_wrtOut(srcDta);
    exsr sub004;

  //  Übertragen Felder > 512 in Dateifelder
  when (cmd = 'FSCN');
    p_wrtOut(srcDta);
    exsr sub007;
    exsr sub005;

  //  Prüfung ungültige Zeichen
  when (cmd = 'CHKC');
    p_wrtOut(srcDta);
    exsr sub006;

  //  Setzen NULL Indicator
  when (cmd = 'NULL');
    p_wrtOut(srcDta);
    exsr sub017;

  //  Hex-Editierung
  when (cmd = 'HEX');
    p_wrtOut(srcDta);
    exsr sub008;

  //  Text-Editierung
  when (cmd = 'TXT');
    p_wrtOut(srcDta);
    exsr sub018;

  //  Rename-Struktur
  when (cmd = 'RNM2');
    p_wrtOut(srcDta);
    exsr sub009;

  //  Rename-Struktur
  when (cmd = 'RNM1');
    ds_bufLen = srcDta;
    $bufLn_ln = RCD_BUFF_LEN;
    p_wrtOut(ds_bufLen);
    exsr sub010;

  //  initialisieren ISO-Felder
  when (cmd = 'ISO ');
    p_wrtOut(srcDta);
    exsr sub011;

  //  isAlwLower ...
  when (cmd = 'ALWL');
    exsr sub012;

  //  1. Seite ...
  when (cmd = 'SCN1');
    exsr sub013;

  //  Übertragen Dateifelder in Bildschirmfelder
  when (cmd = 'TOS');
    exsr sub020;

  //  Übertragen Bildschirmfelder in Dateifelder
  when (cmd = 'TOF');
    exsr sub021;

  //  Löschen Felder im Datensatz
  when (cmd = 'CLR');
    exsr sub022;

  //  Beibehalten Cursor Position
  when (cmd = 'KEEP');
    exsr sub023;

  //  UCS-2 Feld für String/Hex Editor
  when (cmd = 'UCS2');
  //**                Exsr      SUB024

  //  Sichern NULL-Indikatoren
  when (cmd = 'NSAV');
    p_wrtOut(srcDta);
    exsr sub026;

  //  Zurückschreiben NULL-Indikatoren
  when (cmd = 'NRST');
    p_wrtOut(srcDta);
    exsr sub027;

  other;
    //  Nur kopieren ...
    p_wrtOut(srcDta);
  endsl;

enddo;

close qpeekgen;
close peekSrc;

*inlr = *on;

//============================================================*
//    SUB001        Umschalten: Weitere ... / Ende            *
//============================================================*

begsr sub001;

  ds_more    = srcDta;
  $more_scnN = i_scnNbrs;
  p_wrtOut(ds_more);

endsr;

//============================================================*
//    SUB002        isLower                                   *
//============================================================*

begsr sub002;

  ds_lcas = srcDta;

  if (i_case = bTrue);
    $lcas_inz = 'bTrue';
  else;
    $lcas_inz = 'bFalse';
  endif;

  p_wrtOut(ds_lcas);

endsr;

//============================================================*
//    SUB003        Blättern                                  *
//============================================================*

begsr sub003;

  for scnNbr = 1 to i_scnNbrs;

    //  When      scnNbr = 001
    reset ds_page;
    $page_f2b = scnNbr;
    p_wrtOut(ds_page);

    //  Exfmt     LC001
    if (i_alwLC = bTrue);
      reset ds_exfmt;
      $exfmt_neg = ' ';
      $exfmt_sc  = 'LC';
      $exfmt_scN = scnNbr;
      p_wrtOut(ds_exfmt);
    endif;

    //  Exfmt     UC001
    reset ds_exfmt;
    $exfmt_neg = 'N';
    $exfmt_sc  = 'UC';
    $exfmt_scN = scnNbr;
    p_wrtOut(ds_exfmt);

  endfor;

endsr;

//============================================================*
//    SUB004        Dateifelder ==> Bildschirmfelder          *
//============================================================*

begsr sub004;

  open peekFld;

  fieldCount = 0;

  setll 1 fpeekfld;

  dow (f_readFld <> bEOF);

    fieldCount = fieldCount + 1;

    if (f_isNotAlw(fldl0100) = bTrue);
      reset ds_remark;
      $rem_txt = fldl0100.f1vfld + UNKNOWN_FIELD_TYPE;
      p_wrtOut(ds_remark);
      iter;
    endif;

    reset ds_exsr;
    $exsr_fct2 = 's_' + %trim(fldl0100.f1vfld);
    p_wrtOut(ds_exsr);


  enddo;

  close peekFld;

  io_stage = io_stage + 1;
  p_showProgressMeter(io_stage);

endsr;

//============================================================*
//    SUB005        Bildschirmfelder ==> Dateifelder          *
//============================================================*

begsr sub005;

  open peekFld;

  fieldCount = 0;

  setll 1 fpeekfld;

  dow (f_readFld <> bEOF);

    //  Feldzähler ...
    fieldCount = fieldCount + 1;

    //  Keine Felder größer als 512-Zeichen oder
    //  nicht erlaubte Feldtypen ...
    if (f_isNotAlw(fldl0100) = bTrue);

      reset ds_remark;
      $rem_txt = fldl0100.f1vfld + UNKNOWN_FIELD_TYPE;
      p_wrtOut(ds_remark);

      iter;
    endif;

    //  If        (EDT00002 = '1') and
    reset ds_if;
    $if_fct2='(EDT' + a#fldCount + ' = ''1'') and';
    p_wrtOut(ds_if);

    //            not (LNG0000001 = '1')
    reset ds_if;
    $if_if  = ' ';
    $if_fct2='not (LNG' + a#fldCount + ' = ''1'')';
    p_wrtOut(ds_if);

    //  Übertragen BS-Feld in Dateifeld ...
    if (fldl0100.f1nalw = '1');
      reset ds_if;
      $if_if   = '';
      $if_fct2 = 'and not %nullind(' +
                   %trimr(fldl0100.f1vfld) + ')';
      p_wrtOut(ds_if);
    endif;

    reset ds_exsr;
    $exsr_fct2 = 'f_' + %trim(fldl0100.f1vfld);
    p_wrtOut(ds_exsr);

    //  ENDIF
    reset ds_endif;
    p_wrtOut(ds_endif);

  enddo;

  close peekFld;

  io_stage = io_stage + 1;
  p_showProgressMeter(io_stage);

endsr;

//============================================================*
//    SUB006        Prüfung ungültige Zeichen kopieren        *
//============================================================*

begsr sub006;

  open qcopyle1;

  setll 1 fcopy1;

  dow ('1');
    read fcopy1;
    if (%eof());
      leave;
    endif;

    p_wrtOut(srcDta);
  enddo;

  close qcopyle1;

endsr;

//============================================================*
//    SUB007        Alle Felder prüfen                        *
//============================================================*

begsr sub007;

  for scnNbr = 1 to i_scnNbrs;

    reset ds_chkCh;
    $chkCh_f2b = scnNbr;
    p_wrtOut(ds_chkCh);

  endfor;

  //   Remark einfügen ...
  reset ds_remark;
  p_wrtOut(ds_remark);

endsr;

//============================================================*
//    SUB008        Hex-Editierung                            *
//============================================================*

begsr sub008;

  open qcopyle2;

  setll 1 fcopy2;

  dow ('1');
    read fcopy2;
    if (%eof());
      leave;
    endif;

    p_wrtOut(srcDta);
  enddo;

  close qcopyle2;

endsr;

//============================================================*
//    SUB009        Umbenennen Dateifelder                    *
//============================================================*

begsr sub009;

  open peekFld;

  setll 1 fpeekfld;

  dow (f_readFld <> bEOF);

    //  Rename
    reset ds_rnmBuf;
    $rnmBf_xFd = fldl0100.f1FNme;
    $rnmBf_iFd = fldl0100.f1vfld;
    p_wrtOut(ds_rnmBuf);

  enddo;

  close peekFld;

  io_stage = io_stage + 1;
  p_showProgressMeter(io_stage);

endsr;

//============================================================*
//    SUB010        Umbenennen Dateifelder (Input Buffer)     *
//============================================================*

begsr sub010;

  open peekFld;

  setll 1 fpeekfld;

  dow (f_readFld <> bEOF);

    //  Rename
    reset ds_rnmEx;
    $rnmEx_xFd =
     'extfld(' + %trim(fldl0100.f1FNme) + ')';
    $rnmEx_iFd = ' ' + fldl0100.f1vfld;
    p_wrtOut(ds_rnmEx);

  enddo;

  io_stage = io_stage + 1;
  p_showProgressMeter(io_stage);

  close peekFld;

  io_stage = io_stage + 1;
  p_showProgressMeter(io_stage);

endsr;

//============================================================*
//    SUB011        Initialisieren ISO-Felder                 *
//============================================================*

begsr sub011;

  open peekFld;

  fieldCount = 0;

  setll 1 fpeekfld;

  dow (f_readFld <> bEOF);

    //  Feldzähler ...
    fieldCount = fieldCount + 1;

    //  Keine Felder größer als 512-Zeichen
    if ((f_isToLong(fldl0100) = bTrue) or
        (f_isNotAlw(fldl0100) = bTrue));
      iter;
    endif;

    //  Kein ISO Feld
    if ((fldl0100.f1DTyp <> 'T') and
        (fldl0100.f1DTyp <> 'L') and
        (fldl0100.f1DTyp <> 'Z'));
      iter;
    endif;

    //  If        FLD0000011= ' '
    reset ds_if;
    $if_fct2 = 'FLD' + a#fldCount + '= '' ''';
    p_wrtOut(ds_if);

    //  Eval      FLD0000011 = ISOT
    reset ds_eval;

    $eval_fct2 = 'FLD' + a#fldCount;

    //  Initialisieren mit dem kleinsten Wert im Format des Feldes
    //  (alle Formate, z.B. '01/01/40' für *MDY; QCOPYLE,DATTIMFMT)
    select;
    //  ... Zeitfeld
    when (fldl0100.f1DTyp = 'T');
      $eval_fct2  = %trimr($eval_fct2) + ' = ''' +
                    f_extTime(fldl0100: T'00.00.00') + '''';
    //  ... Datumsfeld
    when (fldl0100.f1DTyp = 'L');
      $eval_fct2  = %trimr($eval_fct2) + ' = ''' +
                    f_extDate(fldl0100: D'0001-01-01') + '''';
    //  ... Zeitstempelfeld
    when (fldl0100.f1DTyp = 'Z');
      $eval_fct2  = %trimr($eval_fct2) + ' = ISOZ';
    endsl;

    p_wrtOut(ds_eval);
    //  Endif (reset ds_endif);
    p_wrtOut(ds_endif);
    //  Remark
    reset ds_remark;
    p_wrtOut(ds_remark);

  enddo;

  close peekFld;

  io_stage = io_stage + 1;
  p_showProgressMeter(io_stage);

endsr;

//============================================================*
//    SUB012        isAlwLower                                *
//============================================================*

begsr sub012;

  ds_alwl = srcDta;

  if (i_alwLC = bTrue);
    $alwl_inz = 'bTrue';
  else;
    $alwl_inz = 'bFalse';
  endif;

  p_wrtOut(ds_alwl);

endsr;

//============================================================*
//    SUB013        Seite 1                                   *
//============================================================*

begsr sub013;

  if (i_alwLC = bTrue);
    reset ds_exfmt;
    $exfmt_neg = ' ';
    $exfmt_sc  = 'LC';
    $exfmt_scN = 1;
    p_wrtOut(ds_exfmt);
  endif;

  reset ds_exfmt;
  $exfmt_neg = 'N';
  $exfmt_sc  = 'UC';
  $exfmt_scN = 1;
  p_wrtOut(ds_exfmt);

endsr;

//============================================================*
//    SUB014        Felddefinitionen                          *
//============================================================*

begsr sub014;

  open qcopyle3;

  setll 1 fcopy3;

  dow ('1');
    read fcopy3;
    if (%eof());
      leave;
    endif;

    p_wrtOut(srcDta);
  enddo;

  close qcopyle3;

endsr;

//============================================================*
//    SUB015        Prüfen Feldinhalte                        *
//============================================================*

begsr sub015;

  for scnNbr = 1 to i_scnNbrs;

    //  When      scnNbr = 001
    reset ds_page;
    $page_f2b = scnNbr;
    p_wrtOut(ds_page);

    //  Exsr      chkChar001
    reset ds_chkCh;
    $chkCh_f2b = scnNbr;
    p_wrtOut(ds_chkCh);

  endfor;

endsr;

//============================================================*
//    SUB016        Felddefinitionen                          *
//============================================================*

begsr sub016;

  open qcopyle4;

  setll 1 fcopy4;

  dow ('1');
    read fcopy4;
    if (%eof());
      leave;
    endif;

    p_wrtOut(srcDta);
  enddo;

  close qcopyle4;

endsr;

//============================================================*
//    SUB017        Umschalten NULL-Indicator                 *
//============================================================*

begsr sub017;

  open qcopyle5;

  setll 1 fcopy5;

  dow ('1');
    read fcopy5;
    if (%eof());
      leave;
    endif;

    p_wrtOut(srcDta);
  enddo;

  close qcopyle5;

endsr;

//============================================================*
//    SUB018        Text-Editor                               *
//============================================================*

begsr sub018;

  open qcopyle6;

  setll 1 fcopy6;

  dow ('1');
    read fcopy6;
    if (%eof());
      leave;
    endif;

    p_wrtOut(srcDta);
  enddo;

  close qcopyle6;

endsr;

//============================================================*
//    SUB019        isRcdLock                                 *
//============================================================*

begsr sub019;

  ds_rcdLock = srcDta;

  if (i_rcdLock = bTrue);
    $rcdLock_inz = 'bTrue';
  else;
    $rcdLock_inz = 'bFalse';
  endif;

  p_wrtOut(ds_rcdLock);

endsr;

//============================================================*
//    SUB020        Übertragen Dateifelder in Bildschirmfelder*
//============================================================*

begsr sub020;

  open peekFld;

  fieldCount = 0;

  setll 1 fpeekfld;

  dow (f_readFld <> bEOF);

    fieldCount = fieldCount + 1;

    if (f_isNotAlw(fldl0100) = bTrue);
      iter;
    endif;

    if (fldl0100.f1DTyp = 'G'); // = Graphic
      totFields = f_nbrDspRw(fldl0100);
    else;
      totFields = 1;
    endif;

    reset ds_remark;
    $rem_txt = fldl0100.f1FNme;
    p_wrtOut(ds_remark);

    //  Generieren BEGSR
    reset ds_begsr;
    $begsr_f1 = 's_' + %trim(fldl0100.f1vfld);
    p_wrtOut(ds_begsr);
    reset ds_remark;
    p_wrtOut(ds_remark);

    pos = 1;

    //  Löschen Felder, wenn NULL-fähig oder VARLEN
    if (fldl0100.f1nalw = '1' or
        f_isVarLen(fldl0100) = bTrue);

      for curField = 1 to totFields;
        reset ds_clear;
        if (totFields = 1);
          $clear_field = 'FLD' + a#fldCount;
        else;
          $clear_field = 'FLD' + a#fldCount
                              + %editc(curField: 'X');
        endif;
        p_wrtOut(ds_clear);
      endfor;

      reset ds_remark;
      p_wrtOut(ds_remark);

    endif;

    //  Generieren Abfrage auf NULL-Indicator
    if (fldl0100.f1nalw = '1');

      reset ds_if;
      $if_fct2 = 'not %nullind(' +
                   %trimr(fldl0100.f1vfld) + ')';
      p_wrtOut(ds_if);

    endif;

    if (totFields > 1);

      //  Generieren:    offs = 0
      reset ds_remark;
      p_wrtOut(ds_remark);

      reset ds_eval;
      $eval_fct2 = 'offs = 0';
      p_wrtOut(ds_eval);

      reset ds_remark;
      p_wrtOut(ds_remark);

      //  Generieren:    For x = 1 to 8           (8 = totFields)
      reset ds_for;
      $for_fct2 = 'x = 1 to ' + %char(totFields);
      p_wrtOut(ds_for);

      //  Generieren:    rem  = L_00000013
      reset ds_eval;
      $eval_fct2 =
       'rem = %len(' + fldl0100.f1vfld +
       ') - offs';

      p_wrtOut(ds_eval);

      //  Generieren:    If (rem > 18)            (18 = f_cntFldLn(..))
      reset ds_if;
      $if_fct2 = '(rem > ' +
                 %char(f_cntFldLn(fldl0100)) + ')';
      p_wrtOut(ds_if);

      reset ds_eval;
      $eval_fct2 = 'len = ' +
                  %char(f_cntFldLn(fldl0100));
      p_wrtOut(ds_eval);

      reset ds_else;
      p_wrtOut(ds_else);

      reset ds_eval;
      $eval_fct2 = 'len = rem';
      p_wrtOut(ds_eval);

      reset ds_endif;
      p_wrtOut(ds_endif);

      //  Generieren:    Select
      reset ds_select;
      p_wrtOut(ds_select);

    endif;

    //  Übertragen Dateifeld --> Bildschirmfeld
    for curField = 1 to totFields;

      //  Generieren:    When (x = 1)
      if (totFields > 1);
        reset ds_when;
        $when_fct2 = '(x = ' + %char(curField) +
                    ' and len > 0)';
        p_wrtOut(ds_when);
      endif;

      if (totFields = 1);
        reset ds_eval;
        $eval_fct2 = 'FLD' + a#fldCount +
                    ' = ' + fldl0100.f1vfld;
        p_wrtOut(ds_eval);
      else;

        //    Generieren:    FLD0001301 = %subst(P_00000013: offs+1: len)
        reset ds_eval;
        $eval_fct2 =
        'FLD' + a#fldCount + %editc(curField: 'X') +
        ' = ' +
        '%subst(' + %trimr(fldl0100.f1vfld) +
        ': offs+1: len)';
        p_wrtOut(ds_eval);

      endif;

    endfor;

    //  Generieren:    Endsl
    if (totFields > 1);
      reset ds_endsl;
      p_wrtOut(ds_endsl);

      //  Generieren:    offs = offs + len
      reset ds_eval;
      $eval_fct2 = 'offs = offs + len';
      p_wrtOut(ds_eval);

      //  ENDFOR von:  For-Schleife über Feldsegmente
      reset ds_endfor;
      p_wrtOut(ds_endfor);
    endif;

    //  ENDIF von:   Generieren Abfrage auf NULL-Indicator
    if (fldl0100.f1nalw = '1');

      reset ds_endif;
      p_wrtOut(ds_endif);

    endif;

    //  Generieren ENDSR
    reset ds_remark;
    p_wrtOut(ds_remark);

    reset ds_endsr;
    p_wrtOut(ds_endsr);

  enddo;

  close peekFld;

endsr;

//============================================================*
//    SUB021        Übertragen Bildschirmfelder in Dateifelder*
//============================================================*

begsr sub021;

  open peekFld;

  fieldCount = 0;

  setll 1 fpeekfld;

  dow (f_readFld <> bEOF);

    fieldCount = fieldCount + 1;

    if (f_isNotAlw(fldl0100) = bTrue);
      iter;
    endif;

    if (fldl0100.f1DTyp = 'G'); // = Graphic
      totFields = f_nbrDspRw(fldl0100);
    else;
      totFields = 1;
    endif;

    reset ds_begsr;
    $begsr_f1 = 'f_' + %trim(fldl0100.f1vfld);
    p_wrtOut(ds_begsr);

    //  Felder variabler Länge nur bei einer Änderung übernehmen: Das
    //  Bildschirmfeld hat feste Länge, %trimR entfernt sonst auch die
    //  nachgestellten Leerzeichen eines unveränderten Wertes.
    //    If        %trimR(FLD00005) <> %trimR(P_00000005)
    //    Eval      P_00000005 = %trimR(FLD00005)
    //    Endif
    if (f_isCharFld(fldl0100) = bTrue and
        f_isVarLen(fldl0100) = bTrue and totFields = 1);
      reset ds_if;
      $if_fct2 = '%trimR(FLD' + a#fldCount + ') <> %trimR(' +
                 %trim(fldl0100.f1vfld) + ')';
      p_wrtOut(ds_if);
      reset ds_eval;
      $eval_fct2 = %trim(fldl0100.f1vfld) +
                   ' = %trimR(FLD' + a#fldCount + ')';
      p_wrtOut(ds_eval);
      reset ds_endif;
      p_wrtOut(ds_endif);
      reset ds_endsr;
      p_wrtOut(ds_endsr);
      iter;
    endif;

    if (f_isCharFld(fldl0100) = bTrue);
      reset ds_eval;
      $eval_fct2 =
       %trim(fldl0100.f1vfld) + ' = %trimR(';
      p_wrtOut(ds_eval);
    else;
      reset ds_eval;
      $eval_fct2 = %trim(fldl0100.f1vfld) + ' =';
      p_wrtOut(ds_eval);
    endif;

    for curField = 1 to totFields;

      reset ds_eval;
      clear $eval_code;
      $eval_fct2 = %trim('FLD' + a#fldCount);
      if (totFields > 1);
        $eval_fct2 = %trimr($eval_fct2) +
                    %editc(curField: 'X');
        if (curField < totFields);
          $eval_fct2 = %trimr($eval_fct2) + ' +';
        endif;
      endif;

      p_wrtOut(ds_eval);
    endfor;

    if (f_isCharFld(fldl0100) = bTrue);
      reset ds_eval;
      $eval_code = '';
      $eval_fct2 = ')';
      p_wrtOut(ds_eval);
    endif;

    reset ds_endsr;
    p_wrtOut(ds_endsr);

  enddo;

  close peekFld;

endsr;

//============================================================*
//    SUB022        Löschen Felder im Datensatz               *
//============================================================*

begsr sub022;

  if (i_nullDft = bFalse);
    nullDft = '*ON';
  else;
    nullDft = '*OFF';
  endif;

  open peekFld;

  fieldCount = 0;

  setll 1 fpeekfld;

  dow (f_readFld <> bEOF);

    fieldCount = fieldCount + 1;

    if (f_isNotAlw(fldl0100) = bTrue);
      iter;
    endif;

    //  Setzen NULL-Indicator
    if (fldl0100.f1nalw = '1');

      reset ds_eval;
      $eval_fct2 =
       '%nullind(' +
       %trimr(fldl0100.f1vfld) + ') = ';
      $eval_fct2 = %trimr($eval_fct2) + nullDft;
      p_wrtOut(ds_eval);

    endif;


  enddo;

  close peekFld;

endsr;

//============================================================*
//    SUB023        Beibehalten Cursor Position               *
//============================================================*

begsr sub023;

  ds_keepCrs = srcDta;

  if (i_keepCrs = bTrue);
    $keepCrs_inz = '''1''';
  else;
    $keepCrs_inz = '''0''';
  endif;

  p_wrtOut(ds_keepCrs);

endsr;

//============================================================*
//    SUB024        UCS2-Feld für String/Hex Editor           *
//============================================================*

begsr sub024;

  ds_ucs2 = srcDta;

  $ucs2_value = '(FLDL0100.F1UCS2 = ''1'')';

  p_wrtOut(ds_ucs2);

endsr;

//============================================================*
//    SUB026        Sichern NULL-Indikatoren                  *
//                  nullSave(00005) = %nullind(P_00000005)    *
//============================================================*

begsr sub026;

  open peekFld;

  fieldCount = 0;

  setll 1 fpeekfld;

  dow (f_readFld <> bEOF);

    fieldCount = fieldCount + 1;

    if (f_isNotAlw(fldl0100) = bTrue or fldl0100.f1nalw <> '1');
      iter;
    endif;

    reset ds_eval;
    $eval_fct2 = 'nullSave(' + a#fldCount + ') = %nullind(' +
                 %trim(fldl0100.f1vfld) + ')';
    p_wrtOut(ds_eval);

  enddo;

  close peekFld;

endsr;

//============================================================*
//    SUB027        Zurückschreiben NULL-Indikatoren          *
//                  %nullind(P_00000005) = nullSave(00005)    *
//============================================================*

begsr sub027;

  open peekFld;

  fieldCount = 0;

  setll 1 fpeekfld;

  dow (f_readFld <> bEOF);

    fieldCount = fieldCount + 1;

    if (f_isNotAlw(fldl0100) = bTrue or fldl0100.f1nalw <> '1');
      iter;
    endif;

    reset ds_eval;
    $eval_fct2 = '%nullind(' + %trim(fldl0100.f1vfld) +
                 ') = nullSave(' + a#fldCount + ')';
    p_wrtOut(ds_eval);

  enddo;

  close peekFld;

endsr;

//============================================================*
//    SUB025        Umbenennen /copy Anweisungen              *
//============================================================*

begsr sub025;

  srcDta = %scanrpl('LIBRARY_NAME'
                   : %trim(i_prodLib)
                   :srcDta);

endsr;

//============================================================*
//    wrtOut        Ausgeben Quellenzeile                     *
//============================================================*
dcl-proc p_wrtOut;
  dcl-pi *n;
    i_srcDta like(srcDta) const;
  end-pi;

  #srcSeq = #srcSeq + #Increment;

  srcSeq  = #srcSeq;
  srcDta  = i_srcDta;
  write foutput;

  return;

end-proc;

//============================================================*
//    readFld       Lesen nächstes Feld aus PEEKFLD           *
// Returns bTrue on end-of-file, else bFalse.                 *
//============================================================*
dcl-proc f_readFld;
  dcl-pi *n like(bool_t);
  end-pi;
  //------------------------------------------------------------

  read fpeekfld;
  if (%eof());
    return bTrue;
  else;
    fldl0100 = ffd;
    return bFalse;
  endif;

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

