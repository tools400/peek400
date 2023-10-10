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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

dcl-f qpeekgen usage(*output) usropn rename(qpeekgen :foutput);

dcl-f qcopyle1 usropn rename(qpeekgen :fcopy1 );

dcl-f qcopyle2 usropn rename(qpeekgen :fcopy2 );

dcl-f qcopyle3 usropn rename(qpeekgen :fcopy3 );

dcl-f qcopyle4 usropn rename(qpeekgen :fcopy4 );

dcl-f qcopyle5 usropn rename(qpeekgen :fcopy5 );

dcl-f qcopyle6 usropn rename(qpeekgen :fcopy6 );

dcl-f peeksrc usropn rename(peeksrc:finput);

dcl-f peekfld usropn;

//===============================================================*
//  Datenstrukturen für die Codegenerierung
//===============================================================*

dcl-ds ds_page len(112);
  $page_spc       char(1) inz('C') pos(6);
  $page_f2a       char(19) inz('When      scnNbr = ') pos(26);
  $page_f2b       zoned(3) inz;
end-ds;

dcl-ds ds_chkch len(112);
  $chkch_spc      char(1) inz('C') pos(6);
  $chkch_opc      char(6) inz('Exsr') pos(26);
  $chkch_f2a      char(7) inz('chkChar') pos(36);
  $chkch_f2b      zoned(3) inz;
end-ds;

dcl-ds ds_exfmt len(112);
  $exfmt_spc      char(1) inz('C') pos(6);
  $exfmt_neg      char(1) inz('N') pos(9);
  $exfmt_ind      char(2) inz('71');
  $exfmt_opc      char(6) inz('Exfmt') pos(26);
  $exfmt_ext      char(4) inz;
  $exfmt_sc       char(2) inz('UC');
  $exfmt_scn      zoned(3) inz;
end-ds;

dcl-ds ds_more len(112);
  $more_scnn      zoned(3) inz pos(46);
end-ds;

dcl-ds ds_fmtnme len(112);
  $fmtnm_xnm      char(10) inz pos(51);
end-ds;

dcl-ds ds_rnmbuf len(112);
  $rnmbf_spc      char(1) inz('I') pos(6);
  $rnmbf_xfd      char(10) inz pos(21);
  $rnmbf_ifd      char(14) inz pos(49);
end-ds;

dcl-ds ds_rnmex len(112);
  $rnmex_spc      char(1) inz('D') pos(6);
  $rnmex_ifd      char(15) inz;
  $rnmex_ext      char(1) inz('E');
  $rnmex_xfd      char(37) inz pos(44);
end-ds;

dcl-ds ds_ovlex len(112);
  $ovlex_spc      char(1) inz('D') pos(6);
  $ovlex_ifd      char(15) inz;
  $ovlex_typ      char(5) inz pos(38);
  $ovlex_xfd      char(37) inz pos(44);
end-ds;

dcl-ds ds_lcas len(112);
  $lcas_inz       char(6) inz pos(65);
end-ds;

dcl-ds ds_rcdlock len(112);
  $rcdlock_inz    char(6) inz pos(65);
end-ds;

dcl-ds ds_alwl len(112);
  $alwl_inz       char(6) inz pos(65);
end-ds;

dcl-ds ds_keepcrs len(112);
  $keepcrs_inz    char(4) inz pos(44);
end-ds;

dcl-ds ds_ucs2 len(112);
  $ucs2_value     char(14) inz pos(46);
end-ds;

dcl-ds ds_buflen len(112);
  $bufln_ln       zoned(5) inz pos(35);
end-ds;

dcl-ds ds_eval len(112);
  $eval_spc       char(1) inz('C') pos(6);
  $eval_code      char(6) inz('Eval') pos(26);
  $eval_fct2      char(45) inz pos(36);
end-ds;

dcl-ds ds_for len(112);
  $for_spc        char(1) inz('C') pos(6);
  $for_code       char(6) inz('For') pos(26);
  $for_fct2       char(45) inz pos(36);
end-ds;

dcl-ds ds_endfor len(112);
  $endfor_spc     char(1) inz('C') pos(6);
  $endfor_oper    char(6) inz('Endfor') pos(26);
end-ds;

dcl-ds ds_select len(112);
  $select_spc     char(1) inz('C') pos(6);
  $select_code    char(6) inz('Select') pos(26);
  $select_fct2    char(45) inz pos(36);
end-ds;

dcl-ds ds_when len(112);
  $when_spc       char(1) inz('C') pos(6);
  $when_code      char(6) inz('When') pos(26);
  $when_fct2      char(45) inz pos(36);
end-ds;

dcl-ds ds_endsl len(112);
  $endsl_spc      char(1) inz('C') pos(6);
  $endsl_oper     char(6) inz('Endsl') pos(26);
end-ds;

dcl-ds ds_if len(112);
  $if_spc         char(1) inz('C') pos(6);
  $if_if          char(6) inz('If') pos(26);
  $if_fct2        char(45) inz pos(36);
end-ds;

dcl-ds ds_cont len(112);
  $cont_spc       char(1) inz('C') pos(6);
  $cont_fct2      char(45) inz pos(36);
end-ds;

dcl-ds ds_else len(112);
  $else_spc       char(1) inz('C') pos(6);
  $else_oper      char(6) inz('Else') pos(26);
end-ds;

dcl-ds ds_endif len(112);
  $endif_spc      char(1) inz('C') pos(6);
  $endif_oper     char(6) inz('Endif') pos(26);
end-ds;

dcl-ds ds_clear len(112);
  $clear_spc      char(1) inz('C') pos(6);
  $clear_oper     char(6) inz('Clear') pos(26);
  $clear_field    char(14) inz pos(50);
end-ds;

dcl-ds ds_remark len(112);
  $rem_atrb       char(1) inz(COLOR_white);
  $rem_rem        char(1) inz('*') pos(7);
  $rem_txt        char(103) inz pos(10);
end-ds;

dcl-ds ds_begsr len(112);
  $begsr_spc      char(1) inz('C') pos(6);
  $begsr_f1       char(14) inz pos(12);
  $begsr_opc      char(10) inz('Begsr');
end-ds;

dcl-ds ds_endsr len(112);
  $endsr_spc      char(1) inz('C') pos(6);
  $endsr_opc      char(10) inz('Endsr') pos(26);
end-ds;

dcl-ds ds_exsr len(112);
  $exsr_spc       char(1) inz('C') pos(6);
  $exsr_opc       char(10) inz('Exsr') pos(26);
  $exsr_fct2      char(14) inz;
end-ds;

dcl-s #srcseq         like(srcseq);
dcl-c #increment const(0,01);

dcl-ds *N;
  fieldcount      zoned(5) inz(*zeros);
  a#fdcount       char(5) overlay(fieldcount:1);
end-ds;

dcl-s cmd             char(4) inz;
dcl-s scnnbr          like(int4_t) inz;

dcl-c UNKNOWN_FIELD_TYPE const(': Unknown field type');

dcl-s pos             int(10) inz;
dcl-s totlin          int(10) inz;

dcl-s totfields       int(10) inz;
dcl-s curfield        zoned(2) inz;

dcl-s nulldft         char(4) inz;

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,D_COLORATR

/define internal_prototype
/COPY QCOPYLE,PPEEK16
/undefine internal_prototype

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-pr p_wrtout;
  i_srcdta        const like(srcdta);
end-pr;

dcl-pr f_readfld       like(bool_t);
end-pr;

//====================================================*
//  Steuerleiste
//====================================================*

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58
/COPY QCOPYLE,PPEEK61

/COPY QCOPYLE,CEECNDHDLR

dcl-pi peek16;
  i_prodlib       const like(lib_t);
  i_filename      const likeds(qobj_t);
  i_rcdfmt        const like(rcdfmt_t);
  i_scnnbrs       const like(int2_t);
  i_alwlc         const like(bool_t);
  i_case          const like(bool_t);
  i_rcdlock       const like(bool_t);
  i_nulldft       const like(bool_t);
  i_keepcrs       const like(bool_t);
  io_stage              like(int4_t);
  i_numpasses     const like(int4_t);
end-pi;

dcl-s do_x1           packed(7);
dcl-s do_x2           packed(7);
dcl-s do_x3           packed(7);
dcl-s do_x4           packed(7);
dcl-s do_x5           packed(7);
dcl-s do_x6           packed(7);
dcl-s do_x7           packed(7);

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);
open qpeekgen;
open peeksrc;

#srcseq = 0;

for do_x1 = 1 to *hival;
  read finput;
  *in11 = %eof;
  if (*in11 = beof);
    leave;
  endif;

  cmd = %subst(srcdta: 1: 4);

  select;

  //  File 1
  when (cmd = 'FMT1');
    ds_fmtnme = srcdta;
    $fmtnm_xnm = i_rcdfmt;
    p_wrtout(ds_fmtnme);

  //  Felddefinitionen
  when (cmd = 'DEF1');
    p_wrtout(srcdta);
    exsr sub014;

  //  Umbenennen /copy Anweisungen
  when (cmd = 'COPY');
    exsr sub025;
    p_wrtout(srcdta);

  //  Konstanten für "Feld zu lang"
  when (cmd = 'DEF2');
    p_wrtout(srcdta);
    exsr sub016;

  //  Prüfen ...
  when (cmd = 'CHKS');
    p_wrtout(srcdta);
    exsr sub015;

  //  Blättern ...
  when (cmd = 'SCRN');
    p_wrtout(srcdta);
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
    p_wrtout(srcdta);
    exsr sub004;

  //  Übertragen Felder > 512 in Dateifelder
  when (cmd = 'FSCN');
    p_wrtout(srcdta);
    exsr sub007;
    exsr sub005;

  //  Prüfung ungültige Zeichen
  when (cmd = 'CHKC');
    p_wrtout(srcdta);
    exsr sub006;

  //  Setzen NULL Indicator
  when (cmd = 'NULL');
    p_wrtout(srcdta);
    exsr sub017;

  //  Hex-Editierung
  when (cmd = 'HEX');
    p_wrtout(srcdta);
    exsr sub008;

  //  Text-Editierung
  when (cmd = 'TXT');
    p_wrtout(srcdta);
    exsr sub018;

  //  Rename-Struktur
  when (cmd = 'RNM2');
    p_wrtout(srcdta);
    exsr sub009;

  //  Rename-Struktur
  when (cmd = 'RNM1');
    ds_buflen = srcdta;
    $bufln_ln = rcd_buff_len;
    p_wrtout(ds_buflen);
    exsr sub010;

  //  initialisieren ISO-Felder
  when (cmd = 'ISO ');
    p_wrtout(srcdta);
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

  other;
    //  Nur kopieren ...
    p_wrtout(srcdta);
  endsl;

endfor;

close qpeekgen;
close peeksrc;

*inlr = *on;

//============================================================*
//    SUB001        Umschalten: Weitere ... / Ende            *
//============================================================*

begsr sub001;

  ds_more    = srcdta;
  $more_scnn = i_scnnbrs;
  p_wrtout(ds_more);

endsr;

//============================================================*
//    SUB002        isLower                                   *
//============================================================*

begsr sub002;

  ds_lcas = srcdta;

  if (i_case = btrue);
    $lcas_inz = 'bTrue';
  else;
    $lcas_inz = 'bFalse';
  endif;

  p_wrtout(ds_lcas);

endsr;

//============================================================*
//    SUB003        Blättern                                  *
//============================================================*

begsr sub003;

  for scnnbr = 1 to i_scnnbrs;

    //  When      scnNbr = 001
    reset ds_page;
    $page_f2b = scnnbr;
    p_wrtout(ds_page);

    //  Exfmt     LC001
    if (i_alwlc = btrue);
      reset ds_exfmt;
      $exfmt_neg = ' ';
      $exfmt_sc  = 'LC';
      $exfmt_scn = scnnbr;
      p_wrtout(ds_exfmt);
    endif;

    //  Exfmt     UC001
    reset ds_exfmt;
    $exfmt_neg = 'N';
    $exfmt_sc  = 'UC';
    $exfmt_scn = scnnbr;
    p_wrtout(ds_exfmt);

  endfor;

endsr;

//============================================================*
//    SUB004        Dateifelder ==> Bildschirmfelder          *
//============================================================*

begsr sub004;

  open peekfld;

  fieldcount = 0;

  setll 1 fpeekfld;

  dow f_readfld <> beof;

    fieldcount = fieldcount + 1;

    if (f_isnotalw(fldl0100) = btrue);
      reset ds_remark;
      $rem_txt = fldl0100.f1vfld + UNKNOWN_FIELD_TYPE;
      p_wrtout(ds_remark);
      iter;
    endif;

    if (fldl0100.f1dtyp = 'G'); // = Graphic
      totlin = f_nbrdsprw(fldl0100);
    else;
      totlin = 1;
    endif;

    reset ds_exsr;
    $exsr_fct2 = 's_' + %trim(fldl0100.f1vfld);
    p_wrtout(ds_exsr);


  enddo;

  close peekfld;

  io_stage = io_stage + 1;
  p_showprogressmeter(io_stage);

endsr;

//============================================================*
//    SUB005        Bildschirmfelder ==> Dateifelder          *
//============================================================*

begsr sub005;

  open peekfld;

  fieldcount = 0;

  setll 1 fpeekfld;

  dow f_readfld <> beof;

    //  Feldzähler ...
    fieldcount = fieldcount + 1;

    //  Keine Felder größer als 512-Zeichen oder
    //  nicht erlaubte Feldtypen ...
    if (f_isnotalw(fldl0100) = btrue);

      reset ds_remark;
      $rem_txt = fldl0100.f1vfld + UNKNOWN_FIELD_TYPE;
      p_wrtout(ds_remark);

      iter;
    endif;

    if (fldl0100.f1dtyp = 'G'); // = Graphic
      totlin = f_nbrdsprw(fldl0100);
    else;
      totlin = 1;
    endif;

    //  If        (EDT00002 = '1') and
    reset ds_if;
    $if_fct2='(EDT' + a#fdcount + ' = ''1'') and';
    p_wrtout(ds_if);

    //            not (LNG0000001 = '1')
    reset ds_if;
    $if_if (= ' ');
    $if_fct2='not (LNG' + a#fdcount + ' = ''1'')';
    p_wrtout(ds_if);

    //  Übertragen BS-Feld in Dateifeld ...
    if (fldl0100.f1nalw = '1');
      reset ds_if;
      $if_if (= '');
      $if_fct2 = 'and not %nullind(' +
                   %trimr(fldl0100.f1vfld) + ')';
      p_wrtout(ds_if);
    endif;

    reset ds_exsr;
    $exsr_fct2 = 'f_' + %trim(fldl0100.f1vfld);
    p_wrtout(ds_exsr);

    //  ENDIF (reset ds_endif);
    p_wrtout(ds_endif);

  enddo;

  close peekfld;

  io_stage = io_stage + 1;
  p_showprogressmeter(io_stage);

endsr;

//============================================================*
//    SUB006        Prüfung ungültige Zeichen kopieren        *
//============================================================*

begsr sub006;

  open qcopyle1;

  setll 1 fcopy1;

  for do_x2 = 1 to *hival;
    read fcopy1;
    *in11 = %eof;
    if (*in11 = beof);
      leave;
    endif;

    p_wrtout(srcdta);
  endfor;

  close qcopyle1;

endsr;

//============================================================*
//    SUB007        Alle Felder prüfen                        *
//============================================================*

begsr sub007;

  for scnnbr = 1 to i_scnnbrs;

    reset ds_chkch;
    $chkch_f2b = scnnbr;
    p_wrtout(ds_chkch);

  endfor;

  //   Remark einfügen ...
  reset ds_remark;
  p_wrtout(ds_remark);

endsr;

//============================================================*
//    SUB008        Hex-Editierung                            *
//============================================================*

begsr sub008;

  open qcopyle2;

  setll 1 fcopy2;

  for do_x3 = 1 to *hival;
    read fcopy2;
    *in11 = %eof;
    if (*in11 = beof);
      leave;
    endif;

    p_wrtout(srcdta);
  endfor;

  close qcopyle2;

endsr;

//============================================================*
//    SUB009        Umbenennen Dateifelder                    *
//============================================================*

begsr sub009;

  open peekfld;

  setll 1 fpeekfld;

  dow f_readfld <> beof;

    //  Rename
    reset ds_rnmbuf;
    $rnmbf_xfd = fldl0100.f1fnme;
    $rnmbf_ifd = fldl0100.f1vfld;
    p_wrtout(ds_rnmbuf);

  enddo;

  close peekfld;

  io_stage = io_stage + 1;
  p_showprogressmeter(io_stage);

endsr;

//============================================================*
//    SUB010        Umbenennen Dateifelder (Input Buffer)     *
//============================================================*

begsr sub010;

  open peekfld;

  setll 1 fpeekfld;

  dow f_readfld <> beof;

    //  Rename
    reset ds_rnmex;
    $rnmex_xfd =
     'extfld(' + %trim(fldl0100.f1fnme) + ')';
    $rnmex_ifd = ' ' + fldl0100.f1vfld;
    p_wrtout(ds_rnmex);

  enddo;

  io_stage = io_stage + 1;
  p_showprogressmeter(io_stage);

  close peekfld;

  io_stage = io_stage + 1;
  p_showprogressmeter(io_stage);

endsr;

//============================================================*
//    SUB011        Initialisieren ISO-Felder                 *
//============================================================*

begsr sub011;

  open peekfld;

  fieldcount = 0;

  setll 1 fpeekfld;

  dow f_readfld <> beof;

    //  Feldzähler ...
    fieldcount = fieldcount + 1;

    //  Keine Felder größer als 512-Zeichen
    if (f_istolong(fldl0100) = btrue) or
       (f_isnotalw(fldl0100) = btrue);
      iter;
    endif;

    //  Kein ISO Feld
    if (fldl0100.f1dtyp <> 'T') and
       (fldl0100.f1dtyp <> 'L') and
       (fldl0100.f1dtyp <> 'Z');
      iter;
    endif;

    //  If        FLD0000011= ' '
    reset ds_if;
    $if_fct2 = 'FLD' + a#fdcount + '= '' ''';
    p_wrtout(ds_if);

    //  Eval      FLD0000011 = ISOT
    reset ds_eval;

    $eval_fct2 = 'FLD' + a#fdcount;

    //  Initialisieren ...
    select;
    //  ... Zeitfeld
    when (fldl0100.f1dtyp = 'T');
      select;
      //      ... *EUR
      when (fldl0100.f1dtfm = '*EUR');
        $eval_fct2  = %trimr($eval_fct2) + ' = EURT';
      //      ... *JIS
      when (fldl0100.f1dtfm = '*JIS');
        $eval_fct2  = %trimr($eval_fct2) + ' = JIST';
      //      ... *HMS
      when (fldl0100.f1dtfm = '*HMS');
        $eval_fct2  = %trimr($eval_fct2) + ' = HMST';
      //      ... *ISO
      other;
        $eval_fct2  = %trimr($eval_fct2) + ' = ISOT';
      endsl;
    //  ... Datumsfeld
    when (fldl0100.f1dtyp = 'L');
      select;
      //      ... *EUR
      when (fldl0100.f1dtfm = '*EUR');
        $eval_fct2  = %trimr($eval_fct2) + ' = EURL';
      //      ... *JIS
      when (fldl0100.f1dtfm = '*JIS');
        $eval_fct2  = %trimr($eval_fct2) + ' = JISL';
      //      ... *ISO
      other;
        $eval_fct2  = %trimr($eval_fct2) + ' = ISOL';
      endsl;
    //  ... Zeitstempelfeld
    when (fldl0100.f1dtyp = 'Z');
      $eval_fct2  = %trimr($eval_fct2) + ' = ISOZ';
    endsl;

    p_wrtout(ds_eval);
    //  Endif (reset ds_endif);
    p_wrtout(ds_endif);
    //  Remark
    reset ds_remark;
    p_wrtout(ds_remark);

  enddo;

  close peekfld;

  io_stage = io_stage + 1;
  p_showprogressmeter(io_stage);

endsr;

//============================================================*
//    SUB012        isAlwLower                                *
//============================================================*

begsr sub012;

  ds_alwl = srcdta;

  if (i_alwlc = btrue);
    $alwl_inz = 'bTrue';
  else;
    $alwl_inz = 'bFalse';
  endif;

  p_wrtout(ds_alwl);

endsr;

//============================================================*
//    SUB013        Seite 1                                   *
//============================================================*

begsr sub013;

  if (i_alwlc = btrue);
    reset ds_exfmt;
    $exfmt_neg = ' ';
    $exfmt_sc  = 'LC';
    $exfmt_scn = 1;
    p_wrtout(ds_exfmt);
  endif;

  reset ds_exfmt;
  $exfmt_neg = 'N';
  $exfmt_sc  = 'UC';
  $exfmt_scn = 1;
  p_wrtout(ds_exfmt);

endsr;

//============================================================*
//    SUB014        Felddefinitionen                          *
//============================================================*

begsr sub014;

  open qcopyle3;

  setll 1 fcopy3;

  for do_x4 = 1 to *hival;
    read fcopy3;
    *in11 = %eof;
    if (*in11 = beof);
      leave;
    endif;

    p_wrtout(srcdta);
  endfor;

  close qcopyle3;

endsr;

//============================================================*
//    SUB015        Prüfen Feldinhalte                        *
//============================================================*

begsr sub015;

  for scnnbr = 1 to i_scnnbrs;

    //  When      scnNbr = 001
    reset ds_page;
    $page_f2b = scnnbr;
    p_wrtout(ds_page);

    //  Exsr      chkChar001
    reset ds_chkch;
    $chkch_f2b = scnnbr;
    p_wrtout(ds_chkch);

  endfor;

endsr;

//============================================================*
//    SUB016        Felddefinitionen                          *
//============================================================*

begsr sub016;

  open qcopyle4;

  setll 1 fcopy4;

  for do_x5 = 1 to *hival;
    read fcopy4;
    *in11 = %eof;
    if (*in11 = beof);
      leave;
    endif;

    p_wrtout(srcdta);
  endfor;

  close qcopyle4;

endsr;

//============================================================*
//    SUB017        Umschalten NULL-Indicator                 *
//============================================================*

begsr sub017;

  open qcopyle5;

  setll 1 fcopy5;

  for do_x6 = 1 to *hival;
    read fcopy5;
    *in11 = %eof;
    if (*in11 = beof);
      leave;
    endif;

    p_wrtout(srcdta);
  endfor;

  close qcopyle5;

endsr;

//============================================================*
//    SUB018        Text-Editor                               *
//============================================================*

begsr sub018;

  open qcopyle6;

  setll 1 fcopy6;

  for do_x7 = 1 to *hival;
    read fcopy6;
    *in11 = %eof;
    if (*in11 = beof);
      leave;
    endif;

    p_wrtout(srcdta);
  endfor;

  close qcopyle6;

endsr;

//============================================================*
//    SUB019        isRcdLock                                 *
//============================================================*

begsr sub019;

  ds_rcdlock = srcdta;

  if (i_rcdlock = btrue);
    $rcdlock_inz = 'bTrue';
  else;
    $rcdlock_inz = 'bFalse';
  endif;

  p_wrtout(ds_rcdlock);

endsr;

//============================================================*
//    SUB020        Übertragen Dateifelder in Bildschirmfelder*
//============================================================*

begsr sub020;

  open peekfld;

  fieldcount = 0;

  setll 1 fpeekfld;

  dow f_readfld <> beof;

    fieldcount = fieldcount + 1;

    if (f_isnotalw(fldl0100) = btrue);
      iter;
    endif;

    if (fldl0100.f1dtyp = 'G'); // = Graphic
      totfields = f_nbrdsprw(fldl0100);
    else;
      totfields = 1;
    endif;

    reset ds_remark;
    $rem_txt = fldl0100.f1fnme;
    p_wrtout(ds_remark);

    //  Generieren BEGSR
    reset ds_begsr;
    $begsr_f1 = 's_' + %trim(fldl0100.f1vfld);
    p_wrtout(ds_begsr);
    reset ds_remark;
    p_wrtout(ds_remark);

    pos = 1;

    //  Löschen Felder, wenn NULL-fähig oder VARLEN
    if fldl0100.f1nalw = '1' or
       f_isvarlen(fldl0100) = btrue;

      for curfield = 1 to totfields;
        reset ds_clear;
        if (totfields = 1);
          $clear_field = 'FLD' + a#fdcount;
        else;
          $clear_field = 'FLD' + a#fdcount
                              + %editc(curfield: 'X');
        endif;
        p_wrtout(ds_clear);
      endfor;

      reset ds_remark;
      p_wrtout(ds_remark);

    endif;

    //  Generieren Abfrage auf NULL-Indicator
    if (fldl0100.f1nalw = '1');

      reset ds_if;
      $if_fct2 = 'not %nullind(' +
                   %trimr(fldl0100.f1vfld) + ')';
      p_wrtout(ds_if);

    endif;

    if (totfields > 1);

      //  Generieren:    offs = 0
      reset ds_remark;
      p_wrtout(ds_remark);

      reset ds_eval;
      $eval_fct2 = 'offs = 0';
      p_wrtout(ds_eval);

      reset ds_remark;
      p_wrtout(ds_remark);

      //  Generieren:    For x = 1 to 8           (8 = totFields)
      reset ds_for;
      $for_fct2 = 'x = 1 to ' + %char(totfields);
      p_wrtout(ds_for);

      //  Generieren:    rem  = L_00000013
      reset ds_eval;
      $eval_fct2 =
       'rem = %len(' + fldl0100.f1vfld +
       ') - offs';

      p_wrtout(ds_eval);

      //  Generieren:    If (rem > 18)            (18 = f_cntFldLn(..))
      reset ds_if;
      $if_fct2 = '(rem > ' +
                 %char(f_cntfldln(fldl0100)) + ')';
      p_wrtout(ds_if);

      reset ds_eval;
      $eval_fct2 = 'len = ' +
                  %char(f_cntfldln(fldl0100));
      p_wrtout(ds_eval);

      reset ds_else;
      p_wrtout(ds_else);

      reset ds_eval;
      $eval_fct2 = 'len = rem';
      p_wrtout(ds_eval);

      reset ds_endif;
      p_wrtout(ds_endif);

      //  Generieren:    Select
      reset ds_select;
      p_wrtout(ds_select);

    endif;

    //  Übertragen Dateifeld --> Bildschirmfeld
    for curfield = 1 to totfields;

      //  Generieren:    When (x = 1)
      if (totfields > 1);
        reset ds_when;
        $when_fct2 = '(x = ' + %char(curfield) +
                    ' and len > 0)';
        p_wrtout(ds_when);
      endif;

      if (totfields = 1);
        reset ds_eval;
        $eval_fct2 = 'FLD' + a#fdcount +
                    ' = ' + fldl0100.f1vfld;
        p_wrtout(ds_eval);
      else;

        //    Generieren:    FLD0001301 = %subst(P_00000013: offs+1: len)
        reset ds_eval;
        $eval_fct2 =
        'FLD' + a#fdcount + %editc(curfield: 'X') +
        ' = ' +
        '%subst(' + %trimr(fldl0100.f1vfld) +
        ': offs+1: len)';
        p_wrtout(ds_eval);

      endif;

    endfor;

    //  Generieren:    Endsl
    if (totfields > 1);
      reset ds_endsl;
      p_wrtout(ds_endsl);

      //  Generieren:    offs = offs + len
      reset ds_eval;
      $eval_fct2 = 'offs = offs + len';
      p_wrtout(ds_eval);

      //  ENDFOR von:  For-Schleife über Feldsegmente
      reset ds_endfor;
      p_wrtout(ds_endfor);
    endif;

    //  ENDIF von:   Generieren Abfrage auf NULL-Indicator
    if (fldl0100.f1nalw = '1');

      reset ds_endif;
      p_wrtout(ds_endif);

    endif;

    //  Generieren ENDSR
    reset ds_remark;
    p_wrtout(ds_remark);

    reset ds_endsr;
    p_wrtout(ds_endsr);

  enddo;

  close peekfld;

endsr;

//============================================================*
//    SUB021        Übertragen Bildschirmfelder in Dateifelder*
//============================================================*

begsr sub021;

  open peekfld;

  fieldcount = 0;

  setll 1 fpeekfld;

  dow f_readfld <> beof;

    fieldcount = fieldcount + 1;

    if (f_isnotalw(fldl0100) = btrue);
      iter;
    endif;

    if (fldl0100.f1dtyp = 'G'); // = Graphic
      totfields = f_nbrdsprw(fldl0100);
    else;
      totfields = 1;
    endif;

    reset ds_begsr;
    $begsr_f1 = 'f_' + %trim(fldl0100.f1vfld);
    p_wrtout(ds_begsr);

    if (f_ischarfld(fldl0100) = btrue);
      reset ds_eval;
      $eval_fct2 =
       %trim(fldl0100.f1vfld) + ' = %trimR(';
      p_wrtout(ds_eval);
    else;
      reset ds_eval;
      $eval_fct2 = %trim(fldl0100.f1vfld) + ' =';
      p_wrtout(ds_eval);
    endif;

    for curfield = 1 to totfields;

      reset ds_eval;
      clear $eval_code;
      $eval_fct2 = %trim('FLD' + a#fdcount);
      if (totfields > 1);
        $eval_fct2 = %trimr($eval_fct2) +
                    %editc(curfield: 'X');
        if (curfield < totfields);
          $eval_fct2 = %trimr($eval_fct2) + ' +';
        endif;
      endif;

      p_wrtout(ds_eval);
    endfor;

    if (f_ischarfld(fldl0100) = btrue);
      reset ds_eval;
      $eval_code = '';
      $eval_fct2 = ')';
      p_wrtout(ds_eval);
    endif;

    reset ds_endsr;
    p_wrtout(ds_endsr);

  enddo;

  close peekfld;

endsr;

//============================================================*
//    SUB022        Löschen Felder im Datensatz               *
//============================================================*

begsr sub022;

  if (i_nulldft = bfalse);
    nulldft = '*ON';
  else;
    nulldft = '*OFF';
  endif;

  open peekfld;

  fieldcount = 0;

  setll 1 fpeekfld;

  dow f_readfld <> beof;

    fieldcount = fieldcount + 1;

    if (f_isnotalw(fldl0100) = btrue);
      iter;
    endif;

    //  Setzen NULL-Indicator
    if (fldl0100.f1nalw = '1');

      reset ds_eval;
      $eval_fct2 =
       '%nullind(' +
       %trimr(fldl0100.f1vfld) + ') = ';
      $eval_fct2 = %trimr($eval_fct2) + nulldft;
      p_wrtout(ds_eval);

    endif;


  enddo;

  close peekfld;

endsr;

//============================================================*
//    SUB023        Beibehalten Cursor Position               *
//============================================================*

begsr sub023;

  ds_keepcrs = srcdta;

  if (i_keepcrs = btrue);
    $keepcrs_inz = '''1''';
  else;
    $keepcrs_inz = '''0''';
  endif;

  p_wrtout(ds_keepcrs);

endsr;

//============================================================*
//    SUB024        UCS2-Feld für String/Hex Editor           *
//============================================================*

begsr sub024;

  ds_ucs2 = srcdta;

  $ucs2_value = '(FLDL0100.F1UCS2 = ''1'')';

  p_wrtout(ds_ucs2);

endsr;

//============================================================*
//    SUB025        Umbenennen /copy Anweisungen              *
//============================================================*

begsr sub025;

  srcdta = %scanrpl('LIBRARY_NAME'
                   : %trim(i_prodlib)
                   :srcdta);

endsr;

//============================================================*
//    wrtOut        Ausgeben Quellenzeile                     *
//============================================================*
dcl-proc p_wrtout;
  dcl-pi *N;
    i_srcdta        const like(srcdta);
  end-pi;

  #srcseq = #srcseq + #increment;

  srcseq  = #srcseq;
  srcdta  = i_srcdta;
  write foutput;

  return;

end-proc;

//============================================================*
//    readFld       Lesen nächstes Feld aus PEEKFLD           *
//============================================================*
dcl-proc f_readfld;
  dcl-pi *N       like(bool_t);
  end-pi;
  //------------------------------------------------------------

  dou *in20 = beof;

    read fpeekfld;
    *in20 = %eof;

    if (*in20 <> beof);
      fldl0100 = ffd;
      leave;
    endif;

  enddo;

  return *in20;

end-proc;

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

