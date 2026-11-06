**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.2.0                               *
//  Programm : PEEK15                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 14.10.97  Raddatz                                 *
//  geändert : 21.07.99  Raddatz für Version 2.2                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Generieren RPG-LE Displayfile                                *
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

dcl-f qcopyle1 extdesc('QPEEKGEN') usage(*output) usropn rename(qpeekgen: fcopy1) block(*no);

dcl-f qcopyle2 extdesc('QPEEKGEN') usage(*output) usropn rename(qpeekgen: fcopy2) block(*no);

dcl-f qcopyle3 extdesc('QPEEKGEN') usage(*output) usropn rename(qpeekgen: fcopy3) block(*no);

dcl-f qcopyle4 extdesc('QPEEKGEN') usage(*output) usropn rename(qpeekgen: fcopy4) block(*no);

dcl-f qcopyle5 extdesc('QPEEKGEN') usage(*output) usropn rename(qpeekgen: fcopy5) block(*no);

dcl-f qcopyle6 extdesc('QPEEKGEN') usage(*output) usropn rename(qpeekgen: fcopy6) block(*no);

dcl-f peeksrc usropn rename(peeksrc: finput);

dcl-f peekfld usropn prefix(f_);

dcl-pr p_wrtdspf extproc(*dclcase);
  i_srcdta like(srcdta) const;
end-pr;

dcl-pr p_wrtcopy1 extproc(*dclcase);
  i_srcdta like(srcdta) const;
end-pr;

dcl-pr p_wrtcopy2 extproc(*dclcase);
  i_srcdta like(srcdta) const;
end-pr;

dcl-pr p_wrtcopy3 extproc(*dclcase);
  i_srcdta like(srcdta) const;
end-pr;

dcl-pr p_wrtcopy4 extproc(*dclcase);
  i_srcdta like(srcdta) const;
end-pr;

dcl-pr p_wrtcopy5 extproc(*dclcase);
  i_srcdta like(srcdta) const;
end-pr;

dcl-pr p_wrtcopy6 extproc(*dclcase);
  i_srcdta like(srcdta) const;
end-pr;

dcl-pr f_readfld like(bool_t) extproc(*dclcase);
end-pr;

//===============================================================*
//  Datenstrukturen für die Codegenerierung
//===============================================================*

dcl-ds ds_rcdfmt len(112);
  $rcdfm_spc char(1) inz('A') pos(6);
  $rcdfm_typ char(1) inz('R') pos(17);
  $rcdfm_nme char(5) inz pos(19);
end-ds;

dcl-ds ds_overlay len(112);
  $ovl_spc  char(1) inz('A') pos(6);
  $ovl_kwrd char(36) inz('OVERLAY   ') pos(45);
end-ds;

dcl-ds ds_window len(112);
  $wdw_spc  char(1) inz('A') pos(6);
  $wdw_mode char(4) inz pos(9);
  $wdw_kwrd char(36) inz('WINDOW(MSGCTL) ') pos(45);
end-ds;

dcl-ds ds_dspmode len(112);
  $dspm_spc  char(1) inz('A') pos(6);
  $dspm_neg  char(1) inz('N') pos(8);
  $dspm_ind  char(2) inz('88');
  $dspm_kwrd char(36) inz('DSPMOD(*DS4)   ') pos(45);
end-ds;

dcl-ds ds_csrloc len(112);
  $csrl_spc  char(1) inz('A') pos(6);
  $csrl_kwrd char(36) inz('CSRLOC(CSRROW     CSRCOL)') pos(45);
end-ds;

dcl-ds ds_flddef len(112);
  $fldd_spc   char(1) inz('A') pos(6);
  $fldd_neg   char(1) inz pos(8);
  $fldd_ind40 char(2) inz pos(9);
  $fldd_ind50 char(2) inz pos(12);
  $fldd_fldn  char(10) inz pos(19);
  $fldd_ref   char(1) inz pos(29);
  $fldd_len   char(5) inz pos(30);
  $fldd_dtyp  char(1) inz pos(35);
  $fldd_decp  char(2) inz pos(36);
  $fldd_io    char(1) inz pos(38);
  $fldd_row   zoned(2) pos(40);
  $fldd_row$  char(2) inz overlay($fldd_row: 1);
  $fldd_col   zoned(2) pos(43);
  $fldd_col$  char(2) inz overlay($fldd_col: 1);
  $fldd_kwrd  char(36) inz pos(45);
end-ds;

dcl-ds ds_alias len(112);
  $alias_spc  char(1) inz('A') pos(6);
  $alias_kwrd char(36) inz pos(45);
end-ds;

dcl-ds ds_fldcnt len(112);
  $fldc_spc  char(1) inz('A') pos(6);
  $fldc_kwrd char(36) inz pos(45);
end-ds;

dcl-ds ds_literal len(112);
  $lit_spc   char(1) inz('A') pos(6);
  $lit_neg_1 char(1) inz pos(8);
  $lit_ind_1 char(2) inz;
  $lit_neg_2 char(1) inz;
  $lit_ind_2 char(2) inz;
  $lit_row   zoned(2) inz pos(40);
  $lit_col   zoned(1) inz pos(44);
  $lit_kwrd  char(36) inz;
end-ds;

dcl-ds ds_dspatr len(112);
  $dspa_spc char(1) inz('A') pos(6);
  $dspa_neg char(1) inz pos(8);
  $dspa_ind char(2) inz;
  $dspa_atr char(36) inz pos(45);
end-ds;

//  Message: Invalid Charcaters
dcl-ds ds_msgchar len(112);
  $msgc_spc    char(1) inz('A') pos(6);
  $msgc_op     char(1) inz pos(7);
  $msgc_neg    char(1) inz('N') pos(8);
  $msgc_ind    char(2) inz pos(9);
  $msgc_fldn   char(10) inz pos(19);
  $msgc_len    char(2) inz('30') pos(33);
  $msgc_dtyp   char(1) inz('A') pos(35);
  $msgc_io     char(1) inz('O') pos(38);
  $msgc_row    zoned(2) pos(40);
  $msgc_row$   char(2) inz overlay($msgc_row: 1);
  $msgc_col    zoned(2) pos(43);
  $msgc_col$   char(2) inz overlay($msgc_col: 1);
  $msgc_kwrd   char(36) inz('MSGID(TXT &MSG        PEEKGER)') pos(45);
  $msgc_fldnum char(7) inz pos(59);
end-ds;

//  Message: Hidden field
dcl-ds ds_msghidden len(112);
  $msgh_spc  char(1) inz('A') pos(6);
  $msgh_fldn char(10) inz pos(19);
  $msgh_len  char(1) inz('4') pos(34);
  $msgh_dtyp char(1) inz('A');
  $msgh_io   char(1) inz('H') pos(38);
end-ds;

dcl-ds ds_eval len(112);
  $eval_spc  char(1) inz('C') pos(6);
  $eval_opc  char(6) inz('Eval') pos(26);
  $eval_fct2 char(45) inz pos(36);
end-ds;

dcl-ds ds_callp len(112);
  $callp_spc  char(1) inz('C') pos(6);
  $callp_opc  char(6) inz('Callp') pos(26);
  $callp_fct2 char(45) inz pos(36);
end-ds;

dcl-ds ds_begsr len(112);
  $begsr_spc char(1) inz('C') pos(6);
  $begsr_f1  char(14) inz pos(12);
  $begsr_opc char(10) inz('Begsr');
end-ds;

dcl-ds ds_exsr len(112);
  $exsr_spc  char(1) inz('C') pos(6);
  $exsr_opc  char(10) inz('Exsr') pos(26);
  $exsr_fct2 char(14) inz;
end-ds;

dcl-ds ds_if len(112);
  $if_spc  char(1) inz('C') pos(6);
  $if_opc  char(10) inz('If') pos(26);
  $if_fct2 char(45) inz;
end-ds;

dcl-ds ds_endif len(112);
  $endif_spc char(1) inz('C') pos(6);
  $endif_opc char(10) inz('Endif') pos(26);
end-ds;

dcl-ds ds_endsr len(112);
  $endsr_spc char(1) inz('C') pos(6);
  $endsr_opc char(10) inz('Endsr') pos(26);
end-ds;

dcl-ds ds_leavesr len(112);
  $leavesr_spc char(1) inz('C') pos(6);
  $leavesr_opc char(10) inz('Leavesr') pos(26);
end-ds;

dcl-ds ds_else len(112);
  $else_spc char(1) inz('C') pos(6);
  $else_opc char(10) inz('Else') pos(26);
end-ds;

dcl-ds ds_when len(112);
  $when_spc  char(1) inz('C') pos(6);
  $when_opc  char(10) inz('When') pos(26);
  $when_fct2 char(45) inz;
end-ds;

dcl-ds ds_cont len(112);
  $cont_spc  char(1) inz('C') pos(6);
  $cont_fct2 char(45) inz pos(36);
end-ds;

dcl-ds ds_selec len(112);
  $selec_spc char(1) inz('C') pos(6);
  $selec_opc char(10) inz('Select') pos(26);
end-ds;

dcl-ds ds_endsl len(112);
  $endsl_spc char(1) inz('C') pos(6);
  $endsl_opc char(10) inz('Endsl') pos(26);
end-ds;

dcl-ds ds_remark len(112);
  $rem_atrb char(1) inz(COLOR_white);
  $rem_rem  char(1) inz('*') pos(7);
  $rem_txt  char(105) inz;
  $rem_info char(103) inz overlay($rem_txt: 3);
end-ds;

dcl-ds ds_defn len(112);
  $defn_spc  char(1) inz('D') pos(6);
  $defn_fldn char(15) inz;
  $defn_type char(2) inz pos(24);
  $defn_len  char(7) inz pos(33);
  $defn_dtyp char(1) inz;
  $defn_decp char(2) inz;
  $defn_keyw char(37) inz pos(44);
end-ds;

dcl-ds ds_movel len(112);
  $movel_spc char(1) inz('C') pos(6);
  $movel_opc char(6) inz('Movel') pos(26);
  $movel_ext char(4) inz('(P)');
  $movel_f2  char(14) inz;
  $movel_r   char(14) inz;
end-ds;

dcl-s isExit03 ind inz(bFalse);
dcl-s exit03 like(pgmcalln_t) inz;
dcl-ds qpgm qualified;
  name char(10);
  lib  char(10);
end-ds;

dcl-pr cvteditcode extpgm(exit03);
  gi_file    char(10) const;
  gi_lib     char(10) const;
  gi_user    char(10) const;
  gi_field   char(10) const;
  gio_edtcde char(1);
end-pr;

/copy QCOPYLE,SDS

dcl-s dotline char(40) inz(*all'.');

dcl-s #srcseq like(srcseq) inz;
dcl-c #increment 0,01;

dcl-c max_rows 18;

dcl-c REM_LINE '====================================================*';

dcl-s totlin like(int4_t) inz;
dcl-s curlin zoned(2) inz;
dcl-s dsplen int(10) inz;

dcl-s totfields like(int4_t) inz;
dcl-s curfield zoned(2) inz;

dcl-ds *n;
  newlen#  zoned(5) inz;
  newlen#a char(5) overlay(newlen#: 1);
end-ds;

//  Satzformatzähler
dcl-ds *n;
  scn#  zoned(3) inz;
  scn#a char(3) overlay(scn#: 1);
end-ds;
//  Feldzähler pro Satzformat
dcl-ds *n;
  fieldcount zoned(5) inz(*zeros);
  a#fdcount  char(5) overlay(fieldcount: 1);
end-ds;
//  Bezugszahlenzähler pro Satzformat für Felder mit unzulässigen Zeichen
dcl-ds *n;
  ind40#  zoned(2) inz;
  ind40#a char(2) overlay(ind40#: 1);
end-ds;
//  Bezugszahlenzähler pro Satzformat für Felder mit NULL Werten
dcl-ds *n;
  ind50#  zoned(2) inz;
  ind50#a char(2) overlay(ind50#: 1);
end-ds;
//  Zeilenzähler im Satzformat
dcl-ds *n;
  row#  zoned(2) inz;
  row#a char(2) overlay(row#: 1);
end-ds;
//  Umsetzung numerisch/alphanumerisch
dcl-ds *n;
  num#  zoned(2) inz;
  num#a char(2) overlay(num#: 1);
end-ds;

//  Arbeitsfelder
dcl-s hasreffld like(bool_t) inz(bFalse);
dcl-s isutf8 like(bool_t) inz(bFalse);
dcl-s newscn like(bool_t) inz(bTrue);
dcl-s x like(int4_t) inz;
dcl-s y like(int4_t) inz;
dcl-s z like(int4_t) inz;
dcl-s p like(int4_t) inz;
dcl-s numquote like(int4_t) inz;
dcl-s basefldname like(fieldnme_t) inz;
dcl-s fieldname like(fieldnme_t) inz;
dcl-s r$ftxt like(fldl0100_t.f1ftxt) inz;
dcl-s r$text like(colheading_t) inz;
dcl-s reffile like(file_t) inz;
dcl-s reflib like(lib_t) inz;
dcl-s fldtolong like(bool_t) inz;
dcl-s fldtolongmax like(bool_t) inz;
dcl-s closechar1 varchar(1) inz;
dcl-s closechar2 varchar(1) inz;
dcl-s headertype varchar(20) inz;
dcl-s edtwrd varchar(140) inz;

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,CEECNDHDLR
/copy QCOPYLE,D_COLORATR

/copy QCOPYLE,USR8188

/define internal_prototype
/copy QCOPYLE,PPEEK15
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK61

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//====================================================*
//  Steuerleiste
//====================================================*
dcl-pi peek15;
  i_qfile     likeds(qobj_t) const;
  io_scnnbrs  like(int2_t);
  i_alwlc     like(bool_t) const;
  io_stage    like(int4_t);
  i_numpasses like(int4_t) const;
end-pi;

//----------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

open qcopyle1;
open qcopyle2;
open qcopyle3;
open qcopyle4;
open qcopyle5;
open qcopyle6;
open qpeekgen;
open peekfld;

p = %scan('/': exit03);
if (p > 1);
  qpgm.lib = %subst(exit03: 1: p-1);
  if p < %len(exit03);
    qpgm.name = %subst(exit03: p+1);
    isExit03  = f_exist(qpgm.name
                       : qpgm.lib
                       : '*PGM');
  endif;
endif;

scn#    = 0;
newscn  = bTrue;

//  Der zweite Durchlauf (Kleinbuchstaben) schreibt in dieselbe
//  Teildatei weiter: Folgenummern dort ab 5000, damit sie aufsteigend
//  bleiben (sonst CPD9805 und Fehlermarken an falschen Zeilen).
if (i_alwlc = bFalse);
  #srcseq = 0;
else;
  #srcseq = 5000;
endif;

if (i_alwlc = bFalse);
  //  "Vorspann" nur kopieren, bei XAlwLC = FALSE
  exsr copyhead;
else;
//  "Vorspann" nicht kopieren, da schon kopiert
endif;

reffile = %subst(i_qfile:  1: 10);
reflib = %subst(i_qfile: 11: 10);

fieldcount = 0;

//  Abarbeiten der Feldliste ...
setll 1 peekfld;

dow (f_readfld() <> bEOF);

  //**                Clear                   USR8188
  //**                Eval      USR8188.var1 = xStage
  //**                Eval      USR8188.var2 = FLDL0100.F1FNME
  //**                Callp     p_sndStsMg('USR8188': USR8188)

  //  ... erhöhen lfd. Feldnummer
  fieldcount = fieldcount + 1;

  //  ... prüfen, ob das Feld erlaubt ist
  if (f_isnotalw(fldl0100) = bTrue);
    iter;
  endif;

  //  ... ausgeben Feld
  exsr wrtfield;
enddo;

io_stage = io_stage + 1;
p_showprogressmeter(io_stage);

//-------------------------------------------*
//  Abschließen Copy-Book 1:                 *
//  Inhalt:   chkCharXXX                     *
//-------------------------------------------*

//  Endsr
reset ds_endsr;
p_wrtcopy1(ds_endsr);
//  Remark
reset ds_remark;
p_wrtcopy1(ds_remark);

//-------------------------------------------*
//  Abschließen Copy-Book 2:                 *
//  Inhalt:   c_fldHexEd                     *
//-------------------------------------------*

//  Endsl
reset ds_endsl;
p_wrtcopy2(ds_endsl);
//  Remark
reset ds_remark;
p_wrtcopy2(ds_remark);
//  Endsr
reset ds_endsr;
p_wrtcopy2(ds_endsr);
//  Remark
reset ds_remark;
p_wrtcopy2(ds_remark);

//-------------------------------------------*
//  Abschließen Copy-Book 6:                 *
//  Inhalt:   c_fldStrEd                     *
//-------------------------------------------*

//  Endsl
reset ds_endsl;
p_wrtcopy6(ds_endsl);
//  Remark
reset ds_remark;
p_wrtcopy6(ds_remark);
//  Endsr
reset ds_endsr;
p_wrtcopy6(ds_endsr);
//  Remark
reset ds_remark;
p_wrtcopy6(ds_remark);

//-------------------------------------------*
//  Zufügen Copy-Book 1:                     *
//  Inhalt:   EnableEdit                     *
//-------------------------------------------*

//  Ausgeben COPY-Strecke: EnableEdit

//  Remark
reset ds_remark;
$rem_txt  = REM_LINE;
p_wrtcopy1(ds_remark);

//  Remark
reset ds_remark;
$rem_info = 'Alle Felder freischalten';
p_wrtcopy1(ds_remark);

//  Remark
reset ds_remark;
$rem_txt  = REM_LINE;
p_wrtcopy1(ds_remark);

//  Remark
reset ds_remark;
p_wrtcopy1(ds_remark);

//  Begsr
reset ds_begsr;
$begsr_f1 = 'EnableEdit';
p_wrtcopy1(ds_begsr);
//  Remark
reset ds_remark;
p_wrtcopy1(ds_remark);

fieldcount = 0;

//  Abarbeiten der Feldliste ...
setll 1 peekfld;

dow f_readfld <> bEOF;

  //**                Clear                   USR8188
  //**                Eval      USR8188.var1 = xStage
  //**                Eval      USR8188.var2 = FLDL0100.F1FNME
  //**                Callp     p_sndStsMg('USR8188': USR8188)

  //  ... erhöhen lfd. Feldnummer
  fieldcount = fieldcount + 1;

  //  ... prüfen, ob das Feld erlaubt ist
  if (f_isnotalw(fldl0100) = bTrue);
    iter;
  endif;

  //  ... ausgeben Initialisierung des log. Merkers

  //  Eval      EDT0000001 = '1'
  reset ds_eval;
  $eval_fct2 = 'EDT' + a#fdcount + ' = ''1''';
  p_wrtcopy1(ds_eval);
enddo;

io_stage = io_stage + 1;
p_showprogressmeter(io_stage);

//  Remark
reset ds_remark;
p_wrtcopy1(ds_remark);
//  Endsr
reset ds_endsr;
p_wrtcopy1(ds_endsr);
//  Remark
reset ds_remark;
p_wrtcopy1(ds_remark);

close qcopyle1;
close qcopyle2;
close qcopyle3;
close qcopyle4;
close qcopyle5;
close qcopyle6;
close qpeekgen;
close peekfld;

io_scnnbrs = scn#;

*inlr = *on;

//============================================================*
//    copyHead      Kopieren Vorspann                         *
//============================================================*

begsr copyhead;

  open peeksrc;

  dow ('1');
    read finput;
    if (%eof());
      leave;
    endif;

    //  Nur kopieren ...
    p_wrtdspf(srcdta);
  enddo;

  close peeksrc;

  //-------------------------------------------*
  //  Initialisieren Copy-Book 2:              *
  //  Inhalt:   c_fldHexEd                     *
  //-------------------------------------------*

  //  Remark
  reset ds_remark;
  p_wrtcopy2(ds_remark);

  //  Begsr
  reset ds_begsr;
  $begsr_f1 = 'c_fldHexEd';
  p_wrtcopy2(ds_begsr);

  //  Remark
  reset ds_remark;
  p_wrtcopy2(ds_remark);

  //  füllen Parameter für PEEK45
  //  Eval      yDsp80     = i_dsp80
  reset ds_eval;
  $eval_fct2 = 'yDsp80     = i_dsp80';
  p_wrtcopy2(ds_eval);

  //  Eval      yHeaderTyp = io_headerType
  reset ds_eval;
  $eval_fct2 = 'yHeaderTyp = io_headerType';
  p_wrtcopy2(ds_eval);

  //  Eval      yCopyRight = i_copyright
  reset ds_eval;
  $eval_fct2 = 'yCopyRight = i_copyright';
  p_wrtcopy2(ds_eval);

  //  Eval      yProtect   = '0'
  reset ds_eval;
  $eval_fct2 = 'yProtect   = ''0''';
  p_wrtcopy2(ds_eval);

  //  Eval      yMsgID     = ' '
  reset ds_eval;
  $eval_fct2 = 'yMsgID     = '' ''';
  p_wrtcopy2(ds_eval);

  //  Eval      yMsgDta    = ' '
  reset ds_eval;
  $eval_fct2 = 'yMsgDta    = '' ''';
  p_wrtcopy2(ds_eval);

  //  Remark
  reset ds_remark;
  p_wrtcopy2(ds_remark);

  //  Eval      xScnCsrRow = wScnCsrRow - WndTopRow
  reset ds_eval;
  $eval_fct2 =
    'xScnCsrRow = wScnCsrRow - WndTopRow';
  p_wrtcopy2(ds_eval);

  //  Remark
  reset ds_remark;
  p_wrtcopy2(ds_remark);

  //  Select
  reset ds_selec;
  p_wrtcopy2(ds_selec);

  //-------------------------------------------*
  //  Initialisieren Copy-Book 6:              *
  //  Inhalt:   c_fldStrEd                     *
  //-------------------------------------------*

  //  Remark
  reset ds_remark;
  p_wrtcopy6(ds_remark);

  //  Begsr
  reset ds_begsr;
  $begsr_f1 = 'c_fldStrEd';
  p_wrtcopy6(ds_begsr);

  //  Remark
  reset ds_remark;
  p_wrtcopy6(ds_remark);

  //  füllen Parameter für PEEK45
  //  Eval      yDsp80     = i_dsp80
  reset ds_eval;
  $eval_fct2 = 'yDsp80     = i_dsp80';
  p_wrtcopy6(ds_eval);

  //  Eval      yHeaderTyp = io_headerType
  reset ds_eval;
  $eval_fct2 = 'yHeaderTyp = io_headerType';
  p_wrtcopy6(ds_eval);

  //  Eval      yCopyRight = i_copyright
  reset ds_eval;
  $eval_fct2 = 'yCopyRight = i_copyright';
  p_wrtcopy6(ds_eval);

  //  Eval      yProtect   = '0'
  reset ds_eval;
  $eval_fct2 = 'yProtect   = ''0''';
  p_wrtcopy6(ds_eval);

  //  Eval      yMsgID     = ' '
  reset ds_eval;
  $eval_fct2 = 'yMsgID     = '' ''';
  p_wrtcopy6(ds_eval);

  //  Eval      yMsgDta    = ' '
  reset ds_eval;
  $eval_fct2 = 'yMsgDta    = '' ''';
  p_wrtcopy6(ds_eval);

  //  Remark
  reset ds_remark;
  p_wrtcopy6(ds_remark);

  //  Eval      xScnCsrRow = wScnCsrRow - WndTopRow
  reset ds_eval;
  $eval_fct2 =
    'xScnCsrRow = wScnCsrRow - WndTopRow';
  p_wrtcopy6(ds_eval);

  //  Remark
  reset ds_remark;
  p_wrtcopy6(ds_remark);

  //  Select
  reset ds_selec;
  p_wrtcopy6(ds_selec);

endsr;

//============================================================*

//============================================================*

begsr wrtfield;

  //   Berechnen Anzahl benötigter Zeilen ...
  totlin = f_nbrdsprw(fldl0100);
  curlin = 1;
  dsplen = 0;

  // ---------------------------*
  //   Ausgeben Kopfsatz
  // ---------------------------*
  if (row# + totlin - 1) > max_rows;
    newscn = bTrue;
  endif;

  if (newscn = bTrue);
    exsr inzscreen;
  endif;

  // ---------------------------*
  //   Ausgeben Felddefinition
  // ---------------------------*
  if (fieldcount < 99999);
    basefldname = 'FLD' + a#fdcount;
  else;
    basefldname = '*CNT_ERROR';
  endif;

  dou curlin > totlin;

    //  Generieren ALPHA Felder als GRAPHIC für CCSIDs 1200 und 1208.
    //**                If         FLDL0100.F1DTYP = 'A' and
    //**                           (FLDL0100.F1FDCC = 1200 or FLDL0100.F1FDCC = 1208)
    //**                Eval       FLDL0100.F1DTYP = 'G'
    //**                Endif

    //  Generieren Felder für mehrzeilige GRAPHIC Felder, weil das
    //  Schlüsselwort 'CNTFLD()' für GRAPHIC Felder nicht zulässig ist.
    if (basefldname <> '*CNT_ERROR' and
       fldl0100.f1dtyp = 'G' and totlin > 1);
      fieldname = %trimr(basefldname) +
                 %editc(curlin: 'X');
    else;
      fieldname = basefldname;
    endif;

    //  ... ausgeben Text
    if (curlin = 1);
      //      ... Feldname
      headertype = '*FIELDNAME';
      reset ds_literal;
      $lit_neg_1 = 'N';
      $lit_ind_1 = '70';
      $lit_neg_2 = 'N';
      $lit_ind_2 = '75';
      exsr #text;

      //      ... Feldtext
      headertype = '*FIELDTEXT';
      reset ds_literal;
      $lit_neg_1 = ' ';
      $lit_ind_1 = '70';
      $lit_neg_2 = 'N';
      $lit_ind_2 = '75';
      exsr #text;

      //      ... Feldtyp
      headertype = '*FIELDTYPE';
      reset ds_literal;
      $lit_neg_1 = 'N';
      $lit_ind_1 = '70';
      $lit_neg_2 = ' ';
      $lit_ind_2 = '75';
      exsr #text;

      //      ... Spaltenüberschrift
      headertype = '*COLHDG';
      reset ds_literal;
      $lit_neg_1 = ' ';
      $lit_ind_1 = '70';
      $lit_neg_2 = ' ';
      $lit_ind_2 = '75';
      exsr #text;
    endif;

    //  ... ausgeben Feld für Schlüsselanzeiger
    if (curlin = 1);
      reset ds_flddef;
      $fldd_fldn = 'KEY' + a#fdcount;
      $fldd_len  = '    1';
      $fldd_dtyp = 'A';
      $fldd_decp = '  ';
      $fldd_io   = 'O';
      $fldd_row  = row#;
      $fldd_col  = 26;
      p_wrtdspf(ds_flddef);
    endif;

    //  ... ausgeben "hidden field" für Nachrichtennummer TXT...
    if (curlin = 1);
      reset ds_msghidden;
      $msgh_fldn = 'MSG' + a#fdcount;
      p_wrtdspf(ds_msghidden);
    endif;

    //  ... ausgeben Hinweis "Unzulässige Zeichen"
    if (curlin = 1);
      reset ds_msgchar;
      $msgc_ind  = ind40#a;
      $msgc_len  = '';
      $msgc_dtyp = '';
      $msgc_io   = '';
      $msgc_row$ = '';
      $msgc_col$ = '';
      $msgc_kwrd = '';
      p_wrtdspf(ds_msgchar);

      reset ds_msgchar;
      $msgc_op     = 'O';
      $msgc_ind    = ind50#a;
      $msgc_fldn = 'TXT' + a#fdcount;
      $msgc_fldnum = a#fdcount;
      $msgc_row    = row#;
      $msgc_col    = 29;
      p_wrtdspf(ds_msgchar);
    endif;

    //  ... Farbe: weiß
    if (curlin = 1);
      reset ds_dspatr;
      $dspa_atr = 'COLOR(WHT)';
      p_wrtdspf(ds_dspatr);
    endif;

    //  ... ausgeben Felddefinition
    reset ds_flddef;
    $fldd_fldn = fieldname;

    //      ... Referenzierung - Zeile 1
    $fldd_row  = row# + (curlin - 1);
    $fldd_col  = 29;

    //  CHAR-Felder mit CCSID 1208 (UTF-8) nicht referenzieren: REFFLD
    //  übernimmt die CCSID, die eine Bildschirmdatei nicht kennt
    //  (CPD5112), und CCSID() ist nur für GRAPHIC-Felder zulässig
    //  (CPD7554). Das Feld wird als CHAR-Feld in Feldlänge erzeugt;
    //  beim Lesen und Schreiben des Satzes setzt die Datenbank zwischen
    //  UTF-8 und der Job-CCSID um.
    if (fldl0100.f1dtyp = 'A' and
       (fldl0100.f1fdcc = 1200 or
       fldl0100.f1fdcc = 1208));
      isutf8 = bTrue;
    else;
      isutf8 = bFalse;
    endif;

    //          ... Referenzfeld
    if (fldl0100.f1dtyp <> 'G' and fldl0100.f1dtyp <> '8' and // = Graphic/Boolean
       isutf8 = bFalse);
      $fldd_ref  = 'R';
      $fldd_kwrd = 'REFFLD(' +
                  %trimr(fldl0100.f1fnme) + ' -';
      hasreffld = bTrue;
    else;
      hasreffld = bFalse;
    endif;

    //          ... Datentyp
    select;
    when (fldl0100.f1dtyp = 'L') or // = Date
       (fldl0100.f1dtyp = 'T') or   // = Time
       (fldl0100.f1dtyp = 'Z') or   // = Boolean
       (fldl0100.f1dtyp = '8');     // = Timestamp
      $fldd_dtyp = 'A';
    when (fldl0100.f1dtyp = 'G');   // = Graphic
      $fldd_dtyp = 'G';
    when (isutf8 = bTrue);          // = UTF-8, ohne REFFLD
      $fldd_dtyp = 'A';
    other;
      $fldd_dtyp = ' ';
    endsl;

    //          ... Feldlänge
    if (f_istolong(fldl0100) = bTrue) or
       (fldl0100.f1dtyp = 'G' and totlin > 1);
      if (fldl0100.f1dtyp = 'G'); // = Graphic
        if (curlin < totlin);
          newlen# = f_cntfldln(fldl0100);
        else;
          newlen# = f_dsplyln(fldl0100) - dsplen;
          if newlen# > f_cntfldln(fldl0100);
            newlen# = f_cntfldln(fldl0100);
          endif;
        endif;
        dsplen = dsplen + newlen#;
      else;
        newlen# = f_maxdspln(fldl0100);
      endif;
    else;
      newlen# = f_dsplyln(fldl0100);
    endif;

    select;
    when (fldl0100.f1dtyp = '8');        // = Boolean
      $fldd_len  = newlen#a;
    when (fldl0100.f1dtyp = 'G' or       // = Graphic
          f_istolong(fldl0100) = bTrue or
          isutf8 = bTrue);               // = UTF-8, ohne REFFLD
      $fldd_len  = newlen#a;
    other;
      $fldd_len  = '';
    endsl;

    //          ... Bezugszahl
    $fldd_neg  = '  ';
    $fldd_ind40= ind40#a;
    $fldd_ind50= ind50#a;
    //          ... Input Feld
    if (fldl0100.f1use = 'I');
      $fldd_io   = 'O';
    else;
      $fldd_io   = 'B';
    endif;

    $fldd_decp = '  ';
    p_wrtdspf(ds_flddef);

    //      ... Referenzierung - Zeile 2
    if (hasreffld = bTrue);
      reset ds_fldcnt;
      $fldc_kwrd =
      %trimr(reflib) + '/' + %trimr(reffile) + ')';
      p_wrtdspf(ds_fldcnt);
    endif;

    //  ... Feld über mehrere Zeilen verteilen
    if (fldl0100.f1dtyp <> 'G'); // = Graphic
      if (totlin > 1);
        reset ds_dspatr;
        $dspa_atr = 'CNTFLD(35)';
        p_wrtdspf(ds_dspatr);
      endif;
    else;
    //       // TODO: Feld über mehrere Zeilen splitten
    endif;

    //  ... CCSID und Feldlänge für GRAPHIC Felder
    if (fldl0100.f1dtyp = 'G'); // = Graphic
      reset ds_dspatr;
      $dspa_atr = 'CCSID(13488 ' +
                  %char(%int((newlen# / 2) + .5))
                  + ')';
      p_wrtdspf(ds_dspatr);
    endif;

    //  Alias Feldname überschreiben, weil:
    //   - Aliasnamen in Groß-/Kleinbuchstaben sind nicht zulässig.
    //   - Einige Sonderzeichen wie zum Beispiel '#' oder '.' sind
    //     in einer Display File nicht zulässig.
    //  Der tatsächliche Alias Name spielt keine Rolle und wird daher
    //  auf den generierten Namen 'ALSnnnnn' gesetzt. Es könnte auch
    //  jeder andere eindeutige Name sein.
    if (fldl0100.f1afnl > 0 and hasreffld = bTrue);
      reset ds_alias;
      $alias_kwrd = 'ALIAS(' +
                   'ALS' + a#fdcount
                   + ')';
      p_wrtdspf(ds_alias);
    endif;

    //  Auf INPUT-Only-Felder prüfen ...
    if (fldl0100.f1use <> 'I');
      //  .. Farbe = weiß
      reset ds_dspatr;
      $dspa_atr = 'COLOR(WHT)';
      p_wrtdspf(ds_dspatr);
    else;
      //  .. Farbe = grün
      reset ds_dspatr;
      $dspa_atr = 'COLOR(GRN)';
      p_wrtdspf(ds_dspatr);
    endif;

    //  Feld schützen, wenn größer als 512-Zeichen ...
    if (f_istolongmax(fldl0100) = bTrue);
      fldtolongmax = '1';
    else;
      fldtolongmax = '0';
    endif;

    //  Feld schützen, wenn größer als 512-Zeichen ...
    if (f_istolong(fldl0100) = bTrue) or
       (f_isnotalw(fldl0100) = bTrue);
      if (fldl0100.f1use <> 'I');
        reset ds_dspatr;
        $dspa_atr = 'DSPATR(PR)';
        p_wrtdspf(ds_dspatr);

        reset ds_dspatr;
        $dspa_ind = '72';
        $dspa_atr = 'DSPATR(UL)';
        p_wrtdspf(ds_dspatr);
      endif;
      fldtolong = '1';
    else;
      //  Schlüsselfelder schützen/freigeben ...
      if (f_iskeyfld(fldl0100) = bTrue);
        if (fldl0100.f1use <> 'I');
          reset ds_dspatr;
          $dspa_neg = 'N';
          $dspa_ind = '73';
          $dspa_atr = 'DSPATR(PR)';
          p_wrtdspf(ds_dspatr);

          reset ds_dspatr;
          $dspa_ind = '73';
          $dspa_atr = 'DSPATR(UL)';
          p_wrtdspf(ds_dspatr);
        endif;
      endif;
      fldtolong = '0';
    endif;

    //  EXIT03 kann den Edit Code aus PEEKFLD überschreiben. Nur bei
    //  numerischen Feldern, denn EDTCDE ist bei Zeichenfeldern nicht
    //  zulässig.
    if (isExit03 and
        f_isnumfld(fldl0100)   = bTrue and
        f_isfloatfld(fldl0100) = bFalse);
      callp(e) cvteditcode(
        reffile: reflib
        : sds.user: fldl0100.f1fnme: f_edtcde);
      if (%error());
        isExit03 = bFalse;
      endif;
    endif;

    //  EDTWRD/EDTCDE ausgeben ...
    select;
    //  EDTWRD prüfen ...
    when (fldl0100.f1edwd <> ' '); // Edit word
      //  Hochkommas verdoppeln und das Schlüsselwort auf Folgezeilen
      //  verteilen ('-' in Stelle 80): Der Schlüsselwortbereich hat 36
      //  Stellen, ein Editierwort bis zu 64 Zeichen.
      if (fldl0100.f1edwl > 0 and
          fldl0100.f1edwl <= %len(fldl0100.f1edwd));
        edtwrd = %subst(fldl0100.f1edwd: 1: fldl0100.f1edwl);
      else;
        edtwrd = %trimr(fldl0100.f1edwd);
      endif;
      edtwrd = 'EDTWRD(''' + %scanrpl('''': '''''': edtwrd) + ''')';
      dow (%len(edtwrd) > %len($dspa_atr));
        reset ds_dspatr;
        $dspa_atr = %subst(edtwrd: 1: %len($dspa_atr) - 1) + '-';
        p_wrtdspf(ds_dspatr);
        edtwrd = %subst(edtwrd: %len($dspa_atr));
      enddo;
      reset ds_dspatr;
      $dspa_atr = edtwrd;
      p_wrtdspf(ds_dspatr);

    //  Abfragen Feld-EDTCDE aus PEEKFLD ...
    when f_edtcde <> ' '           // Edit code
       and f_isfloatfld(fldl0100) = bFalse;
      reset ds_dspatr;
      $dspa_atr = 'EDTCDE(' + f_edtcde + ')';
      p_wrtdspf(ds_dspatr);

    other;
      //  Kein EDTWRD / kein EDTCDE
      if (f_isnumfld(fldl0100)   = bTrue ) and
         (f_isfloatfld(fldl0100) = bFalse) and
         (fldl0100.f1decp > 0            );
        reset ds_dspatr;
        $dspa_atr = 'EDTCDE(' + 'P' + ')';
        p_wrtdspf(ds_dspatr);
      endif;
    endsl;

    //  Lower case Attribut
    //  bei Alpha-Feldern ...
    if (fldl0100.f1dtyp = 'A' or
       fldl0100.f1dtyp = 'G') and
       (i_alwlc =  bTrue) and
       (fldl0100.f1use <> 'I');
      reset ds_dspatr;
      $dspa_atr = 'CHECK(LC) ';
      p_wrtdspf(ds_dspatr);
    endif;

    if (fldl0100.f1dtyp = 'G');
      curlin = curlin + 1;
    else;
      curlin = curlin + totlin;
    endif;

  enddo;

  // ---------------------------*
  //  Copy-Strecken ausgeben
  // ---------------------------*
  exsr wrtcopy1;
  exsr wrtcopy2;
  exsr wrtcopy3;
  exsr wrtcopy4;
  exsr wrtcopy5;
  exsr wrtcopy6;

  // ---------------------------*
  //  erhöhen Zeilenzähler
  // ---------------------------*
  row# = row# + totlin;

  // ---------------------------*
  //  erhöhen Bezugszahlenzähler
  // ---------------------------*
  ind40# = ind40# + 1;
  ind50# = ind50# + 1;

endsr;

//============================================================*
//    inzScreen     Initialisieren neuen Bildschirm           *
//============================================================*

begsr inzscreen;

  //  Wenn die laufende Bildschirm-Nr. = 0 ist,
  //  dann ...
  if (scn# = 0);
  //    ... ist keine abzuschließende
  //        Subroutine vorhanden
  else;
    //    ... ansonsten Subroutine abschließen  (Copy-Book 1)
    //           Endsr
    reset ds_endsr;
    p_wrtcopy1(ds_endsr);
    //           Remark
    reset ds_remark;
    p_wrtcopy1(ds_remark);
  endif;

  //  Eine neue Subroutine beginnen (Copy-Book 1) ...
  ind40# = 30;
  ind50# = 50;
  scn# = scn# + 1;

  //           Remark
  reset ds_remark;
  $rem_txt  = REM_LINE;
  p_wrtcopy1(ds_remark);

  //           Remark
  reset ds_remark;
  $rem_info = 'Prüfung auf ungültige Feldinhalte, Seite ' + scn#a;
  p_wrtcopy1(ds_remark);

  //           Remark
  reset ds_remark;
  $rem_txt  = REM_LINE;
  p_wrtcopy1(ds_remark);

  //           Remark
  reset ds_remark;
  p_wrtcopy1(ds_remark);

  //           Begsr
  reset ds_begsr;
  $begsr_f1  = 'chkChar' + scn#a;
  p_wrtcopy1(ds_begsr);

  //           Remark
  reset ds_remark;
  p_wrtcopy1(ds_remark);

  //  Einen neuen Record im DspF anfangen ...
  reset ds_rcdfmt;

  if (i_alwlc = bFalse);
    $rcdfm_nme = 'UC' + scn#a;
  else;
    $rcdfm_nme = 'LC' + scn#a;
  endif;

  p_wrtdspf(ds_rcdfmt);

  //  OVERLAY
  reset ds_overlay;
  p_wrtdspf(ds_overlay);
  //  WINDOW-Definition für *DS3
  reset ds_window;
  $wdw_mode = '*DS3';
  p_wrtdspf(ds_window);
  //  WINDOW-Definition für *DS4
  reset ds_window;
  $wdw_mode = '*DS4';
  p_wrtdspf(ds_window);
  //  Anzeigemodus
  reset ds_dspmode;
  p_wrtdspf(ds_dspmode);
  //  Cursor Position
  reset ds_csrloc;
  p_wrtdspf(ds_csrloc);
  //  Cursor Position, Variable CSRROW
  reset ds_flddef;
  $fldd_fldn = 'CSRROW';
  $fldd_len  = '    3';
  $fldd_dtyp = 'S';
  $fldd_decp = ' 0';
  $fldd_io   = 'H';
  $fldd_row$ = ' ';
  $fldd_col$ = ' ';
  p_wrtdspf(ds_flddef);
  //  Cursor Position, Variable CSRCOL
  reset ds_flddef;
  $fldd_fldn = 'CSRCOL';
  $fldd_len  = '    3';
  $fldd_dtyp = 'S';
  $fldd_decp = ' 0';
  $fldd_io   = 'H';
  $fldd_row$ = ' ';
  $fldd_col$ = ' ';
  p_wrtdspf(ds_flddef);

  //  Initialisierung Feldausgabe
  row#   = 4;

  newscn = bFalse;

endsr;

//============================================================*
//    wrtCopy1      Ausgeben Copy-Book 1 pro Feld             *
//                  Prüfung auf nicht darstellbare Zeichen    *
//============================================================*

begsr wrtcopy1;

  //  Remark
  reset ds_remark;
  $rem_info = 'Feld: ' + fldl0100.f1fnme;
  p_wrtcopy1(ds_remark);

  //  If        EDT0000001 = '1'
  reset ds_if;
  $if_fct2 = 'EDT' + a#fdcount + ' = ''1''';
  p_wrtcopy1(ds_if);

  //  Eval      F_FIELD = 'TEST#'
  reset ds_eval;
  $eval_fct2 =
   'F_FIELD = ' +
   '''' + %trimr(fldl0100.f1fnme) + '''';
  p_wrtcopy1(ds_eval);

  closechar1 = '';

  reset ds_eval;
  $eval_fct2 = 'yOutBuffer =';

  if (f_ischarfld(fldl0100) = bTrue and
     f_isvarlen(fldl0100) = bTrue);
    $eval_fct2 = %trimr($eval_fct2) +
                '%trimR(';
    closechar1 = ')';
  endif;

  p_wrtcopy1(ds_eval);

  if (fldl0100.f1dtyp =  'G');
    totfields = f_nbrdsprw(fldl0100);
  else;
    totfields = 1;
  endif;

  for curfield = 1 to totfields;

    closechar2 = '';

    reset ds_eval;
    clear $eval_opc;

    if (f_isnumfld(fldl0100) = bTrue);
      if (fldl0100.f1dtyp = 'F');
        $eval_fct2 = '%editflt(FLD' + a#fdcount;
        closechar2 = ')';
      else;
        $eval_fct2 = '%char(FLD' + a#fdcount;
        closechar2 = ')';
      endif;
    else;
      $eval_fct2 = 'FLD' + a#fdcount;
    endif;

    if (totfields > 1);
      $eval_fct2 = %trimr($eval_fct2) +
                  %editc(curfield: 'X');
    endif;

    $eval_fct2 = %trimr($eval_fct2) + closechar2;

    if (curfield < totfields);
      $eval_fct2 = %trimr($eval_fct2) + ' +';
    endif;

    p_wrtcopy1(ds_eval);

  endfor;

  if (closechar1 <> '');
    reset ds_eval;
    clear $eval_opc;
    $eval_fct2 = closechar1;
    p_wrtcopy1(ds_eval);
  endif;

  //  Eval      yOutBuffLn = ??

  if (f_ischarfld(fldl0100) = bFalse);
    reset ds_eval;
    $eval_fct2 = 'yOutBuffLn = 0';
    p_wrtcopy1(ds_eval);
  else;

    reset ds_eval;
    $eval_fct2 = 'yOutBuffLn = %len(';
    if (f_isvarlen(fldl0100) = bTrue);
      $eval_fct2 = %trimr($eval_fct2) + '%trimR(';
    endif;
    p_wrtcopy1(ds_eval);

    for curfield = 1 to totfields;

      reset ds_eval;
      clear $eval_opc;

      $eval_fct2 = %trimr($eval_fct2) +
                  'FLD' + a#fdcount;
      if (totfields > 1);
        $eval_fct2 = %trimr($eval_fct2) +
                    %editc(curfield: 'X');
      endif;

      if (curfield < totfields);
        $eval_fct2 = %trimr($eval_fct2) + ' +';
      endif;

      p_wrtcopy1(ds_eval);
    endfor;

    reset ds_eval;
    clear $eval_opc;
    $eval_fct2 = ')';
    if (f_isvarlen(fldl0100) = bTrue);
      $eval_fct2 = %trimr($eval_fct2) + ')';
    endif;
    p_wrtcopy1(ds_eval);

  endif;

  //  Exsr      chkChar
  reset ds_exsr;
  $exsr_fct2 = 'chkChar';
  p_wrtcopy1(ds_exsr);

  //  Eval      *IN40 = isVisible
  reset ds_eval;
  $eval_fct2 = '*IN' + ind40#a + ' = isVisible';
  p_wrtcopy1(ds_eval);

  //  Eval      EDT0000001 = *IN40
  reset ds_eval;
  $eval_fct2 =  'EDT' + a#fdcount +
               ' = *IN' + ind40#a;
  p_wrtcopy1(ds_eval);

  //  Eval      KEY0000001 = keyChar
  reset ds_eval;
  $eval_fct2 = 'KEY' + a#fdcount + ' = keyChar';
  p_wrtcopy1(ds_eval);

  //  If        (isVisible = bFalse)
  reset ds_if;
  $if_fct2 = '(isVisible = bFalse)';
  p_wrtcopy1(ds_if);

  //  Eval      MSG00001 = '0076'
  reset ds_eval;
  $eval_fct2 = 'MSG' + a#fdcount
                    + ' = ''0076''';
  p_wrtcopy1(ds_eval);

  //  Endif (reset ds_endif);
  p_wrtcopy1(ds_endif);

  //  Else
  reset ds_else;
  p_wrtcopy1(ds_else);

  //  Eval      isCvtChar = bTrue
  reset ds_eval;
  $eval_fct2 = 'isCvtChar = bTrue';
  p_wrtcopy1(ds_eval);

  //  Eval      *IN40 = EDT0000001
  reset ds_eval;
  $eval_fct2 = '*IN' + ind40#a +
              ' = EDT' + a#fdcount;
  p_wrtcopy1(ds_eval);

  //  Endif (reset ds_endif);
  p_wrtcopy1(ds_endif);

  //  Remark
  reset ds_remark;
  p_wrtcopy1(ds_remark);

  if (fldl0100.f1nalw = '1');
    //  If        %nullind(P_0000001)
    reset ds_if;
    $if_fct2 =
     '%nullind(' + %trimr(fldl0100.f1vfld) + ')';
    p_wrtcopy1(ds_if);
    //  Eval      *IN50 = '0'
    reset ds_eval;
    $eval_fct2 = '*IN' + ind50#a + ' = ''0''';
    p_wrtcopy1(ds_eval);
    //  Eval      &MSG0000001 = 'TXT0127'
    reset ds_eval;
    $eval_fct2 = 'MSG' + a#fdcount
                      + ' = ''0127''';
    p_wrtcopy1(ds_eval);
    //  Else
    reset ds_else;
    p_wrtcopy1(ds_else);
    //  Eval      *IN50 = '1'
    reset ds_eval;
    $eval_fct2 = '*IN' + ind50#a + ' = ''1''';
    p_wrtcopy1(ds_eval);
    //  Endif (reset ds_endif);
    p_wrtcopy1(ds_endif);

  else;

    //  Eval      *IN50 = '1'
    reset ds_eval;
    $eval_fct2 = '*IN' + ind50#a + ' = ''1''';
    p_wrtcopy1(ds_eval);

  endif;

  //  Remark
  reset ds_remark;
  p_wrtcopy1(ds_remark);

endsr;

//============================================================*
//    wrtCopy2      Ausgeben Copy-Book 2 pro Feld             *
//                  Aufrufen Hex-Editor                       *
//============================================================*

begsr wrtcopy2;

  //  Remark
  reset ds_remark;
  $rem_info = 'Feld: ' + fldl0100.f1fnme;
  p_wrtcopy2(ds_remark);

  //  When      (xScnCsrRow >= 04) and
  reset ds_when;
  $when_fct2 =
           '(xScnCsrRow >= ' + row#a + ') and';
  p_wrtcopy2(ds_when);

  //            (xScnCsrRow <= 04) and
  reset ds_cont;
  num# = row# + totlin - 1;
  $cont_fct2 =
           '(xScnCsrRow <= ' + num#a + ') and';
  p_wrtcopy2(ds_cont);

  //            (scnNbr      = 001)
  reset ds_cont;
  $cont_fct2 =
           '(scnNbr      = ' + scn#a + ')';
  p_wrtcopy2(ds_cont);

  //  Input-Only Feld?
  if (fldl0100.f1use = 'I');
    //  ... JA
    reset ds_exsr;
    $exsr_fct2 = 'MSG8208';
    p_wrtcopy2(ds_exsr);
  else;
    //  ... NEIN
    //      If        (EDT0000001 = '1') and
    reset ds_if;
    $if_fct2='(EDT' + a#fdcount + ' = ''1'') and';
    p_wrtcopy2(ds_if);

    //                not (LNG0000001 = '1')
    reset ds_if;
    $if_opc  = ' ';
    $if_fct2='not (LNG' + a#fdcount + ' = ''1'')';
    p_wrtcopy2(ds_if);

    //      Eval      P_00000001 = FLD0000001
    reset ds_exsr;
    $exsr_fct2 = 'f_' + %trim(fldl0100.f1vfld);
    p_wrtcopy2(ds_exsr);

    //  Endif (reset ds_endif);
    p_wrtcopy2(ds_endif);

    //  Eval      yFldName = 'TEST#V    '
    reset ds_eval;
    $eval_fct2 = 'yFldName = ' +
                '''' + fldl0100.f1fnme + '''';
    p_wrtcopy2(ds_eval);

    //  Eval      Editor = cEDITOR_HEX
    reset ds_eval;
    $eval_fct2 = 'Editor = cEDITOR_HEX';
    p_wrtcopy2(ds_eval);

    //*                 If        f_isCharFld(FLDL0100) = bTrue
    //*                 Reset                   ds_eval
    //*                 Eval      $eval_fct2 = 'trimLen = %len(' + FLDL0100.F1VFLD + ')'
    //*                 Callp     p_wrtCopy2(ds_eval)
    //*                 Reset                   ds_eval
    //*                 Eval      $eval_fct2 = 'isCharFld = bTrue'
    //*                 Callp     p_wrtCopy2(ds_eval)
    //*                 Else
    //*                 Reset                   ds_eval
    //*                 Eval      $eval_fct2 = 'trimLen = -1'
    //*                 Callp     p_wrtCopy2(ds_eval)
    //*                 Reset                   ds_eval
    //*                 Eval      $eval_fct2 = 'isCharFld = bFalse'
    //*                 Callp     p_wrtCopy2(ds_eval)
    //*                 Endif

    //  Exsr      fromBuffer
    reset ds_exsr;
    $exsr_fct2 = 'fromBuffer';
    p_wrtcopy2(ds_exsr);

    //  If        yMsgID = 'USR8112'
    reset ds_if;
    $if_fct2 = 'yMsgID = ''USR8112''';
    p_wrtcopy2(ds_if);

    reset ds_exsr;
    $exsr_fct2 = 's_' + %trim(fldl0100.f1vfld);
    p_wrtcopy2(ds_exsr);

    //  Eval      EDT0000006 = '1'
    reset ds_eval;
    $eval_fct2 = 'EDT' + a#fdcount + ' = ''1''';
    p_wrtcopy2(ds_eval);

    //  Eval      %NULLIND() = *OFF
    if (fldl0100.f1nalw = '1');
      reset ds_eval;
      $eval_fct2 =
       '%nullind(' +
       %trimr(fldl0100.f1vfld) + ') = *OFF';
      p_wrtcopy2(ds_eval);
    endif;

    //  Endif (reset ds_endif);
    p_wrtcopy2(ds_endif);

    //  Remark
    reset ds_remark;
    p_wrtcopy2(ds_remark);

  endif;

endsr;

//============================================================*
//    wrtCopy3      Ausgeben Copy-Book 3 pro Feld             *
//                  Felder für Feldsperre                     *
//============================================================*

begsr wrtcopy3;

  //  EDT0000001      S              1A   inz
  reset ds_defn;
  $defn_fldn = ' EDT' + a#fdcount;
  $defn_type = 'S';
  $defn_len  = '      1';
  $defn_dtyp = 'A';
  $defn_decp = ' ';
  $defn_keyw = 'inz';
  p_wrtcopy3(ds_defn);

endsr;

//============================================================*
//    wrtCopy4      Ausgeben Copy-Book 4 pro Feld             *
//                  Konstanten für "Feld zu lang"             *
//============================================================*

begsr wrtcopy4;

  //  LNG0000001      C                   const('0') / const('1')
  reset ds_defn;
  $defn_fldn = ' LNG' + a#fdcount;
  $defn_type = 'C';
  $defn_len  = ' ';
  $defn_dtyp = ' ';
  $defn_decp = ' ';
  $defn_keyw = 'const(''' + fldtolong + ''')';
  p_wrtcopy4(ds_defn);

  //  MAX0000001      C                   const('0') / const('1')
  reset ds_defn;
  $defn_fldn = ' MAX' + a#fdcount;
  $defn_type = 'C';
  $defn_len  = ' ';
  $defn_dtyp = ' ';
  $defn_decp = ' ';
  $defn_keyw = 'const(''' + fldtolongmax +''')';
  p_wrtcopy4(ds_defn);

endsr;

//============================================================*
//    wrtCopy5      Ausgeben Copy-Book 5 pro Feld             *
//                  Setzen NULL Indicator                     *
//============================================================*

begsr wrtcopy5;

  //  Remark
  reset ds_remark;
  $rem_info = 'Feld: ' + fldl0100.f1fnme;
  p_wrtcopy5(ds_remark);

  //  When      (xScnCsrRow >= 04) and
  reset ds_when;
  $when_fct2 =
           '(xScnCsrRow >= ' + row#a + ') and';
  p_wrtcopy5(ds_when);

  //            (xScnCsrRow <= 04) and
  reset ds_cont;
  num# = row# + totlin - 1;
  $cont_fct2 =
           '(xScnCsrRow <= ' + num#a + ') and';
  p_wrtcopy5(ds_cont);

  //            (scnNbr      = 001)
  reset ds_cont;
  $cont_fct2 =
           '(scnNbr      = ' + scn#a + ')';
  p_wrtcopy5(ds_cont);

  // Eval      %nullind(P_00000001) =
  //              not %nullind(P_00000001)
  if (fldl0100.f1nalw = '1');

    reset ds_eval;
    $eval_fct2 =
     '%nullind(' +
     %trimr(fldl0100.f1vfld) + ') = ';
    p_wrtcopy5(ds_eval);
    reset ds_eval;
    clear $eval_opc;
    $eval_fct2 = 'not %nullind(' +
                %trimr(fldl0100.f1vfld) + ')';
    p_wrtcopy5(ds_eval);

  else;

    //  Setzen Fehlerflag: Feld ist nicht NULL-fähig
    reset ds_eval;
    $eval_fct2 = 'pgmMsgID = ''USR8191''';

    p_wrtcopy5(ds_eval);
    reset ds_eval;
    $eval_fct2 = 'pgmMsgDta = FLDL0100.F1FNME';
    p_wrtcopy5(ds_eval);
    reset ds_callp;
    $callp_fct2 = 'p_sndPgmMg(pgmMsgID: +
                             pgmMsgDta: +
                             psPgmName)';
    p_wrtcopy5(ds_callp);

  endif;

  //  Remark
  reset ds_remark;
  p_wrtcopy5(ds_remark);

endsr;

//============================================================*
//    wrtCopy6      Ausgeben Copy-Book 6 pro Feld             *
//                  Aufrufen String-Editor  (c_fldStrEd)      *
//============================================================*

begsr wrtcopy6;

  //  Remark
  reset ds_remark;
  $rem_info = 'Feld: ' + fldl0100.f1fnme;
  p_wrtcopy6(ds_remark);

  //  When      (xScnCsrRow >= 04) and
  reset ds_when;
  $when_fct2 =
           '(xScnCsrRow >= ' + row#a + ') and';
  p_wrtcopy6(ds_when);

  //            (xScnCsrRow <= 04) and
  reset ds_cont;
  num# = row# + totlin - 1;
  $cont_fct2 =
           '(xScnCsrRow <= ' + num#a + ') and';
  p_wrtcopy6(ds_cont);

  //            (scnNbr      = 001)
  reset ds_cont;
  $cont_fct2 =
           '(scnNbr      = ' + scn#a + ')';
  p_wrtcopy6(ds_cont);

  //  Eval      yFldName = 'TEST#V    '
  reset ds_eval;
  $eval_fct2 = 'yFldName = ' +
              '''' + fldl0100.f1fnme + '''';
  p_wrtcopy6(ds_eval);

  //  Input-Only Feld?
  if (fldl0100.f1use = 'I');
    reset ds_exsr;
    $exsr_fct2 = 'MSG8208';
    p_wrtcopy6(ds_exsr);
    leavesr;
  endif;

  //  Not a character Feld? => Error message
  if (f_ischarfld(fldl0100) <> bTrue);
    reset ds_exsr;
    $exsr_fct2 = 'MSG8221';
    p_wrtcopy6(ds_exsr);
    leavesr;
  endif;

  //      If        (EDT0000001 <> '1') or
  reset ds_if;
  $if_fct2='(EDT' + a#fdcount + ' <> ''1'')';
  p_wrtcopy6(ds_if);

  //      Exsr USR8193
  reset ds_exsr;
  $exsr_fct2 = 'USR8193';
  p_wrtcopy6(ds_exsr);

  //      Leavesr
  reset ds_leavesr;
  p_wrtcopy6(ds_leavesr);

  //      Endif (reset ds_endif);
  p_wrtcopy6(ds_endif);

  //      If        (LNG0000001 = '1')
  reset ds_if;
  $if_fct2='not (LNG' + a#fdcount + ' = ''1'')';
  p_wrtcopy6(ds_if);

  //      Eval      P_00000001 = FLD0000001
  reset ds_exsr;
  $exsr_fct2 = 'f_' + %trim(fldl0100.f1vfld);
  p_wrtcopy6(ds_exsr);

  //  Endif (reset ds_endif);
  p_wrtcopy6(ds_endif);

  //  Eval      Editor = cEDITOR_STRING
  reset ds_eval;
  $eval_fct2 = 'Editor = cEDITOR_STRING';
  p_wrtcopy6(ds_eval);

  reset ds_eval;
  $eval_fct2 =
   'yLength = %len(' + fldl0100.f1vfld + ')';
  p_wrtcopy6(ds_eval);

  //  Exsr      fromBuffer
  reset ds_exsr;
  $exsr_fct2 = 'fromBuffer';
  p_wrtcopy6(ds_exsr);

  //  If        yMsgID = 'USR8112'
  reset ds_if;
  $if_fct2 = 'yMsgID = ''USR8112''';
  p_wrtcopy6(ds_if);

  //  Eval      FLD0000006 = P_00000006
  reset ds_exsr;
  $exsr_fct2 = 's_' + %trim(fldl0100.f1vfld);
  p_wrtcopy6(ds_exsr);

  //  Eval      EDT0000006 = '1'
  reset ds_eval;
  $eval_fct2 = 'EDT' + a#fdcount + ' = ''1''';
  p_wrtcopy6(ds_eval);

  //  Eval      %NULLIND() = *OFF
  if (fldl0100.f1nalw = '1');
    reset ds_eval;
    $eval_fct2 =
     '%nullind(' +
     %trimr(fldl0100.f1vfld) + ') = *OFF';
    p_wrtcopy6(ds_eval);
  endif;

  //  Endif (reset ds_endif);
  p_wrtcopy6(ds_endif);

  //  Remark
  reset ds_remark;
  p_wrtcopy6(ds_remark);

endsr;

//============================================================*
//    #TEXT         Aufbereiten Feldbezeichner                *
//============================================================*

begsr #text;

  $lit_kwrd = '''';

  // Feldtyp
  // Feldname
  select;
  when (headertype = '*FIELDNAME');
    $lit_kwrd =
     %trimr($lit_kwrd) + fldl0100.f1fnme;
    x = %len(%trimr($lit_kwrd));
    y = x;
  // Feldtyp
  when (headertype = '*FIELDTYPE');
    $lit_kwrd = %trimr($lit_kwrd) +
               f_headline(headertype: fldl0100);
    x = %len(%trimr($lit_kwrd));
    y = x;
  // Feldtext oder Spaltenüberschrift
  other;
    //  Bezeichnung auf ' prüfen ...
    r$text = f_headline(headertype: fldl0100);
    r$ftxt = '';
    x = 1;
    y = 1;
    dow (x <= %len(%trimr(r$text))) and
       (y <= %len(r$ftxt));
      %subst(r$ftxt: y: 1) =
       %subst(r$text: x: 1);

      if (%subst(r$text: x: 1) = '''') and
         (y < %len(r$ftxt));
        y = y + 1;
        %subst(r$ftxt: y: 1) = '''';
      endif;

      x = x + 1;
      y = y + 1;
    enddo;

    $lit_kwrd = %trimr($lit_kwrd) + r$ftxt;
  endsl;

  //  Hinzufügen '........'
  $lit_kwrd = %trimr($lit_kwrd) + dotline;

  //  Begrenzen Textlänge auf max. mögliche Anzahl Zeichen
  if (26 + y - x <= %len($lit_kwrd));
    %subst($lit_kwrd: 25 + y - x: 1) = '''';
    %subst($lit_kwrd: 26 + y - x   ) = ' ';
  endif;

  //  Prüfen auf ungerade Anzahl ' (Hochkommata)
  numquote = 0;

  z = 0;
  dow z < %len(%trimr($lit_kwrd));
    z = z + 1;
    if (%subst($lit_kwrd: z: 1) = '''');
      numquote = numquote + 1;
    endif;
  enddo;

  //  Bei einer ungeraden Anzahl von Hochkommata ...
  if (%rem(numquote : 2) <> 0);
    //  ... suchen letztes Hochkomma
    dow %subst($lit_kwrd: z: 1) <> '''';
      z = z - 1;
    enddo;
    //  ... ersetzen letztes Hochkomma durch Leerzeichen
    if (z < %len($lit_kwrd));
      %subst($lit_kwrd: %len($lit_kwrd): 1) = '''';
    else;
      %subst($lit_kwrd: z: 1) = ' ';
      //  ... suchen letztes Hochkomma
      dow %subst($lit_kwrd: z: 1) <> '''';
        z = z - 1;
      enddo;
      //      und löschen ales hinter dem letzten Hochkomma
      %subst($lit_kwrd: z + 1) = '';
    endif;
  endif;

  //  Ausgeben Textfeld
  $lit_row = row#;
  $lit_col = 2;
  p_wrtdspf(ds_literal);

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  exit03 = f_pgmcalln('EXIT03');

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorhandler;
  dcl-pi *n;
    i_condtoken    likeds(cee_fc_t) value;
    i_pcommarea    int(10) value;
    o_action       int(10);
    o_newcondtoken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

//============================================================*
//    wrtDspF       Ausgeben Copy-Book 1    'Cxxxxxxxxx'      *
//============================================================*
dcl-proc p_wrtdspf;
  dcl-pi *n;
    i_srcdta like(srcdta) const;
  end-pi;

  #srcseq = #srcseq + #increment;

  srcseq  = #srcseq;
  srcdat = 0;
  srcdta  = i_srcdta;
  write foutput;

  return;

end-proc;

//============================================================*
//    wrtCopy1      Ausgeben Copy-Book 1    'Axxxxxxxxx'      *
//                  Prüfung auf ungültige Feldinhalte         *
//============================================================*
dcl-proc p_wrtcopy1;
  dcl-pi *n;
    i_srcdta like(srcdta) const;
  end-pi;

  if (i_alwlc = bFalse);
    //  Nur einmal ausgeben, bei XAlwLC = FALSE
    srcseq = 0;
    srcdat = 0;
    srcdta  = i_srcdta;
    write fcopy1;
  else;
  //  kein zweites Mal ausgeben
  endif;

  return;

end-proc;

//============================================================*
//    wrtCopy2      Ausgeben Copy-Book 2    'Bxxxxxxxxx'      *
//                  Starten Hex-Editor                        *
//============================================================*
dcl-proc p_wrtcopy2;
  dcl-pi *n;
    i_srcdta like(srcdta) const;
  end-pi;

  if (i_alwlc = bFalse);
    //  Nur einmal ausgeben, bei XAlwLC = FALSE
    srcseq = 0;
    srcdat = 0;
    srcdta  = i_srcdta;
    write fcopy2;
  else;
  //  kein zweites Mal ausgeben
  endif;

  return;

end-proc;

//============================================================*
//    wrtCopy3      Ausgeben Copy-Book 3    'Cxxxxxxxxx'      *
//                  Felddefinitionen                          *
//============================================================*
dcl-proc p_wrtcopy3;
  dcl-pi *n;
    i_srcdta like(srcdta) const;
  end-pi;

  if (i_alwlc = bFalse);
    //  Nur einmal ausgeben, bei XAlwLC = FALSE
    srcseq = 0;
    srcdat = 0;
    srcdta  = i_srcdta;
    write fcopy3;
  else;
  //  kein zweites Mal ausgeben
  endif;

  return;

end-proc;

//============================================================*
//    wrtCopy4      Ausgeben Copy-Book 4    'Dxxxxxxxxx'      *
//                  Konstanten für "Feld zu lang"             *
//============================================================*
dcl-proc p_wrtcopy4;
  dcl-pi *n;
    i_srcdta like(srcdta) const;
  end-pi;

  if (i_alwlc = bFalse);
    //  Nur einmal ausgeben, bei XAlwLC = FALSE
    srcseq = 0;
    srcdat = 0;
    srcdta  = i_srcdta;
    write fcopy4;
  else;
  //  kein zweites Mal ausgeben
  endif;

  return;

end-proc;

//============================================================*
//    wrtCopy5      Ausgeben Copy-Book 5    'Exxxxxxxxx'      *
//                  Umsetzen NULL-Indicator                   *
//============================================================*
dcl-proc p_wrtcopy5;
  dcl-pi *n;
    i_srcdta like(srcdta) const;
  end-pi;

  if (i_alwlc = bFalse);
    //  Nur einmal ausgeben, bei XAlwLC = FALSE
    srcseq = 0;
    srcdat = 0;
    srcdta  = i_srcdta;
    write fcopy5;
  else;
  //  kein zweites Mal ausgeben
  endif;

  return;

end-proc;

//============================================================*
//    wrtCopy6      Ausgeben Copy-Book 6    'Gxxxxxxxxx'      *
//                  Starten String-Editor                     *
//============================================================*
dcl-proc p_wrtcopy6;
  dcl-pi *n;
    i_srcdta like(srcdta) const;
  end-pi;

  if (i_alwlc = bFalse);
    //  Nur einmal ausgeben, bei XAlwLC = FALSE
    srcseq = 0;
    srcdat = 0;
    srcdta  = i_srcdta;
    write fcopy6;
  else;
  //  kein zweites Mal ausgeben
  endif;

  return;

end-proc;

//============================================================*
//    readFld       Lesen nächstes Feld aus PEEKFLD           *
// Returns bTrue on end-of-file, else bFalse.                 *
//============================================================*
dcl-proc f_readfld;
  dcl-pi *n like(bool_t);
  end-pi;
  //------------------------------------------------------------

  read fpeekfld;
  if (%eof());
    return bTrue;
  else;
    fldl0100 = f_ffd;
    return bFalse;
  endif;

end-proc;

