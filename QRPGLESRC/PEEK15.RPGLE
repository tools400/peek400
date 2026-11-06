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

dcl-f peekSrc usropn rename(peekSrc: finput);

dcl-f peekFld usropn prefix(f_);

dcl-pr p_wrtDspF extproc(*dclcase);
  i_srcDta like(srcDta) const;
end-pr;

dcl-pr p_wrtCopy1 extproc(*dclcase);
  i_srcDta like(srcDta) const;
end-pr;

dcl-pr p_wrtCopy2 extproc(*dclcase);
  i_srcDta like(srcDta) const;
end-pr;

dcl-pr p_wrtCopy3 extproc(*dclcase);
  i_srcDta like(srcDta) const;
end-pr;

dcl-pr p_wrtCopy4 extproc(*dclcase);
  i_srcDta like(srcDta) const;
end-pr;

dcl-pr p_wrtCopy5 extproc(*dclcase);
  i_srcDta like(srcDta) const;
end-pr;

dcl-pr p_wrtCopy6 extproc(*dclcase);
  i_srcDta like(srcDta) const;
end-pr;

dcl-pr f_readFld like(bool_t) extproc(*dclcase);
end-pr;

//===============================================================*
//  Datenstrukturen für die Codegenerierung
//===============================================================*

dcl-ds ds_rcdFmt len(112);
  $rcdFm_spc char(1) inz('A') pos(6);
  $rcdFm_typ char(1) inz('R') pos(17);
  $rcdFm_nme char(5) inz pos(19);
end-ds;

dcl-ds ds_overlay len(112);
  $ovl_spc  char(1) inz('A') pos(6);
  $ovl_kWrd char(36) inz('OVERLAY   ') pos(45);
end-ds;

dcl-ds ds_window len(112);
  $wdw_spc  char(1) inz('A') pos(6);
  $wdw_mode char(4) inz pos(9);
  $wdw_kWrd char(36) inz('WINDOW(MSGCTL) ') pos(45);
end-ds;

dcl-ds ds_dspMode len(112);
  $dspM_spc  char(1) inz('A') pos(6);
  $dspM_neg  char(1) inz('N') pos(8);
  $dspM_ind  char(2) inz('88');
  $dspM_kWrd char(36) inz('DSPMOD(*DS4)   ') pos(45);
end-ds;

dcl-ds ds_csrLoc len(112);
  $csrL_spc  char(1) inz('A') pos(6);
  $csrL_kWrd char(36) inz('CSRLOC(CSRROW     CSRCOL)') pos(45);
end-ds;

dcl-ds ds_fldDef len(112);
  $fldD_spc   char(1) inz('A') pos(6);
  $fldD_neg   char(1) inz pos(8);
  $fldD_ind40 char(2) inz pos(9);
  $fldD_ind50 char(2) inz pos(12);
  $fldD_fldN  char(10) inz pos(19);
  $fldD_ref   char(1) inz pos(29);
  $fldD_len   char(5) inz pos(30);
  $fldD_dTyp  char(1) inz pos(35);
  $fldD_decP  char(2) inz pos(36);
  $fldD_io    char(1) inz pos(38);
  $fldD_row   zoned(2) pos(40);
  $fldD_row$  char(2) inz overlay($fldD_row: 1);
  $fldD_col   zoned(2) pos(43);
  $fldD_col$  char(2) inz overlay($fldD_col: 1);
  $fldD_kWrd  char(36) inz pos(45);
end-ds;

dcl-ds ds_alias len(112);
  $alias_spc  char(1) inz('A') pos(6);
  $alias_kWrd char(36) inz pos(45);
end-ds;

dcl-ds ds_fldCnt len(112);
  $fldC_spc  char(1) inz('A') pos(6);
  $fldC_kWrd char(36) inz pos(45);
end-ds;

dcl-ds ds_literal len(112);
  $lit_spc   char(1) inz('A') pos(6);
  $lit_neg_1 char(1) inz pos(8);
  $lit_ind_1 char(2) inz;
  $lit_neg_2 char(1) inz;
  $lit_ind_2 char(2) inz;
  $lit_row   zoned(2) inz pos(40);
  $lit_col   zoned(1) inz pos(44);
  $lit_kWrd  char(36) inz;
end-ds;

dcl-ds ds_dspAtr len(112);
  $dspA_spc char(1) inz('A') pos(6);
  $dspA_neg char(1) inz pos(8);
  $dspA_ind char(2) inz;
  $dspA_atr char(36) inz pos(45);
end-ds;

//  Message: Invalid Charcaters
dcl-ds ds_msgChar len(112);
  $msgC_spc    char(1) inz('A') pos(6);
  $msgC_op     char(1) inz pos(7);
  $msgC_neg    char(1) inz('N') pos(8);
  $msgC_ind    char(2) inz pos(9);
  $msgC_fldN   char(10) inz pos(19);
  $msgC_len    char(2) inz('30') pos(33);
  $msgC_dTyp   char(1) inz('A') pos(35);
  $msgC_io     char(1) inz('O') pos(38);
  $msgC_row    zoned(2) pos(40);
  $msgC_row$   char(2) inz overlay($msgC_row: 1);
  $msgC_col    zoned(2) pos(43);
  $msgC_col$   char(2) inz overlay($msgC_col: 1);
  $msgC_kWrd   char(36) inz('MSGID(TXT &MSG        PEEKGER)') pos(45);
  $msgC_fldNum char(7) inz pos(59);
end-ds;

//  Message: Hidden field
dcl-ds ds_msgHidden len(112);
  $msgH_spc  char(1) inz('A') pos(6);
  $msgH_fldN char(10) inz pos(19);
  $msgH_len  char(1) inz('4') pos(34);
  $msgH_dTyp char(1) inz('A');
  $msgH_io   char(1) inz('H') pos(38);
end-ds;

dcl-s isExit03 ind inz(bFalse);
dcl-s exit03 like(pgmCallN_t) inz;
dcl-ds qPgm qualified;
  name char(10);
  lib  char(10);
end-ds;

dcl-pr cvtEditCode extpgm(exit03);
  gi_file    char(10) const;
  gi_lib     char(10) const;
  gi_user    char(10) const;
  gi_field   char(10) const;
  gio_edtCde char(1);
end-pr;

/copy QCOPYLE,SDS

dcl-s dotLine char(40) inz(*all'.');

dcl-s #srcSeq like(srcSeq) inz;
dcl-c #Increment 0,01;

dcl-c max_rows 18;

dcl-c REM_LINE '====================================================*';

dcl-s totLin like(int4_t) inz;
dcl-s curLin zoned(2) inz;
dcl-s dspLen int(10) inz;

dcl-s totFields like(int4_t) inz;
dcl-s curField zoned(2) inz;

dcl-ds *n;
  newLen#  zoned(5) inz;
  newLen#a char(5) overlay(newLen#: 1);
end-ds;

//  Satzformatzähler
dcl-ds *n;
  scn#  zoned(3) inz;
  scn#a char(3) overlay(scn#: 1);
end-ds;
//  Feldzähler pro Satzformat
dcl-ds *n;
  fieldCount zoned(5) inz(*zeros);
  a#fldCount char(5) overlay(fieldCount: 1);
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
dcl-s hasRefFld like(bool_t) inz(bFalse);
dcl-s isutf8 like(bool_t) inz(bFalse);
dcl-s newScn like(bool_t) inz(bTrue);
dcl-s x like(int4_t) inz;
dcl-s y like(int4_t) inz;
dcl-s z like(int4_t) inz;
dcl-s p like(int4_t) inz;
dcl-s numQuote like(int4_t) inz;
dcl-s baseFldName like(fieldNme_t) inz;
dcl-s fieldName like(fieldNme_t) inz;
dcl-s r$ftxt like(fldl0100_t.f1FTxt) inz;
dcl-s r$text like(colHeading_t) inz;
dcl-s refFile like(file_t) inz;
dcl-s refLib like(lib_t) inz;
dcl-s fldToLong like(bool_t) inz;
dcl-s line varchar(200) inz;
dcl-s fldNme varchar(40) inz;
dcl-s exprOpen varchar(40) inz;
dcl-s exprClose varchar(4) inz;
dcl-s headerType varchar(20) inz;
dcl-s edtWrd varchar(140) inz;

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,CEECNDHDLR

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
  i_qFile     likeds(qObj_t) const;
  io_scnNbrs  like(int2_t);
  i_alwLC     like(bool_t) const;
  io_stage    like(int4_t);
  i_numPasses like(int4_t) const;
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
open peekFld;

p = %scan('/': exit03);
if (p > 1);
  qPgm.lib = %subst(exit03: 1: p-1);
  if (p < %len(exit03));
    qPgm.name = %subst(exit03: p+1);
    isExit03  = f_exist(qPgm.name
                       : qPgm.lib
                       : '*PGM');
  endif;
endif;

scn#    = 0;
newScn  = bTrue;

//  Der zweite Durchlauf (Kleinbuchstaben) schreibt in dieselbe
//  Teildatei weiter: Folgenummern dort ab 5000, damit sie aufsteigend
//  bleiben (sonst CPD9805 und Fehlermarken an falschen Zeilen).
if (i_alwLC = bFalse);
  #srcSeq = 0;
else;
  #srcSeq = 5000;
endif;

if (i_alwLC = bFalse);
  //  "Vorspann" nur kopieren, bei XAlwLC = FALSE
  exsr copyHead;
else;
//  "Vorspann" nicht kopieren, da schon kopiert
endif;

refFile = %subst(i_qFile:  1: 10);
refLib = %subst(i_qFile: 11: 10);

fieldCount = 0;

//  Abarbeiten der Feldliste ...
setll 1 peekFld;

dow (f_readFld() <> bEOF);

  //**                Clear                   USR8188
  //**                Eval      USR8188.var1 = xStage
  //**                Eval      USR8188.var2 = FLDL0100.F1FNME
  //**                Callp     p_sndStsMg('USR8188': USR8188)

  //  ... erhöhen lfd. Feldnummer
  fieldCount = fieldCount + 1;

  //  ... prüfen, ob das Feld erlaubt ist
  if (f_isNotAlw(fldl0100) = bTrue);
    iter;
  endif;

  //  ... ausgeben Feld
  exsr wrtField;
enddo;

io_stage = io_stage + 1;
p_showProgressMeter(io_stage);

//-------------------------------------------*
//  Abschließen Copy-Book 1:                 *
//  Inhalt:   chkCharXXX                     *
//-------------------------------------------*

p_wrtCopy1('endsr;');
p_wrtCopy1('');

//-------------------------------------------*
//  Abschließen Copy-Book 2:                 *
//  Inhalt:   c_fldHexEd                     *
//-------------------------------------------*

p_wrtCopy2('  endsl;');
p_wrtCopy2('');
p_wrtCopy2('endsr;');
p_wrtCopy2('');

//-------------------------------------------*
//  Abschließen Copy-Book 6:                 *
//  Inhalt:   c_fldStrEd                     *
//-------------------------------------------*

p_wrtCopy6('  endsl;');
p_wrtCopy6('');
p_wrtCopy6('endsr;');
p_wrtCopy6('');

//-------------------------------------------*
//  Zufügen Copy-Book 1:                     *
//  Inhalt:   EnableEdit                     *
//-------------------------------------------*

//  Ausgeben COPY-Strecke: EnableEdit
p_wrtCopy1('//' + REM_LINE);
p_wrtCopy1('//  Alle Felder freischalten');
p_wrtCopy1('//' + REM_LINE);
p_wrtCopy1('');
p_wrtCopy1('begsr EnableEdit;');
p_wrtCopy1('');

fieldCount = 0;

//  Abarbeiten der Feldliste ...
setll 1 peekFld;

dow (f_readFld <> bEOF);

  //  ... erhöhen lfd. Feldnummer
  fieldCount = fieldCount + 1;

  //  ... prüfen, ob das Feld erlaubt ist
  if (f_isNotAlw(fldl0100) = bTrue);
    iter;
  endif;

  //  ... ausgeben Initialisierung des log. Merkers
  //  EDT00001 = '1';
  p_wrtCopy1('  EDT' + a#fldCount + ' = ''1'';');
enddo;

io_stage = io_stage + 1;
p_showProgressMeter(io_stage);

p_wrtCopy1('');
p_wrtCopy1('endsr;');
p_wrtCopy1('');

close qcopyle1;
close qcopyle2;
close qcopyle3;
close qcopyle4;
close qcopyle5;
close qcopyle6;
close qpeekgen;
close peekFld;

io_scnNbrs = scn#;

*inlr = *on;

//============================================================*
//    copyHead      Kopieren Vorspann                         *
//============================================================*

begsr copyHead;

  open peekSrc;

  dow ('1');
    read finput;
    if (%eof());
      leave;
    endif;

    //  Nur kopieren ...
    p_wrtDspF(srcDta);
  enddo;

  close peekSrc;

  //-------------------------------------------*
  //  Initialisieren Copy-Book 2:              *
  //  Inhalt:   c_fldHexEd                     *
  //-------------------------------------------*

  //  Remark
  p_wrtCopy2('');
  p_wrtCopy2('begsr c_fldHexEd;');
  p_wrtCopy2('');

  //  füllen Parameter für PEEK45/PEEK64
  p_wrtCopy2('  yDsp80     = i_dsp80;');
  p_wrtCopy2('  yHeaderTyp = io_headerType;');
  p_wrtCopy2('  yCopyRight = i_copyright;');
  p_wrtCopy2('  yProtect   = ''0'';');
  p_wrtCopy2('  yMsgID     = '' '';');
  p_wrtCopy2('  yMsgDta    = '' '';');
  p_wrtCopy2('');
  p_wrtCopy2('  xScnCsrRow = wScnCsrRow - WndTopRow;');
  p_wrtCopy2('');
  p_wrtCopy2('  select;');

  //-------------------------------------------*
  //  Initialisieren Copy-Book 6:              *
  //  Inhalt:   c_fldStrEd                     *
  //-------------------------------------------*

  //  Remark
  p_wrtCopy6('');
  p_wrtCopy6('begsr c_fldStrEd;');
  p_wrtCopy6('');

  //  füllen Parameter für PEEK45/PEEK64
  p_wrtCopy6('  yDsp80     = i_dsp80;');
  p_wrtCopy6('  yHeaderTyp = io_headerType;');
  p_wrtCopy6('  yCopyRight = i_copyright;');
  p_wrtCopy6('  yProtect   = ''0'';');
  p_wrtCopy6('  yMsgID     = '' '';');
  p_wrtCopy6('  yMsgDta    = '' '';');
  p_wrtCopy6('');
  p_wrtCopy6('  xScnCsrRow = wScnCsrRow - WndTopRow;');
  p_wrtCopy6('');
  p_wrtCopy6('  select;');

endsr;

//============================================================*

//============================================================*

begsr wrtField;

  //   Berechnen Anzahl benötigter Zeilen ...
  totLin = f_nbrDspRw(fldl0100);
  curLin = 1;
  dspLen = 0;

  // ---------------------------*
  //   Ausgeben Kopfsatz
  // ---------------------------*
  if ((row# + totLin - 1) > max_rows);
    newScn = bTrue;
  endif;

  if (newScn = bTrue);
    exsr inzScreen;
  endif;

  // ---------------------------*
  //   Ausgeben Felddefinition
  // ---------------------------*
  if (fieldCount < 99999);
    baseFldName = 'FLD' + a#fldCount;
  else;
    baseFldName = '*CNT_ERROR';
  endif;

  dou (curLin > totLin);

    //  Generieren ALPHA Felder als GRAPHIC für CCSIDs 1200 und 1208.
    //**                If         FLDL0100.F1DTYP = 'A' and
    //**                           (FLDL0100.F1FDCC = 1200 or FLDL0100.F1FDCC = 1208)
    //**                Eval       FLDL0100.F1DTYP = 'G'
    //**                Endif

    //  Generieren Felder für mehrzeilige GRAPHIC Felder, weil das
    //  Schlüsselwort 'CNTFLD()' für GRAPHIC Felder nicht zulässig ist.
    if (baseFldName <> '*CNT_ERROR' and
       fldl0100.f1DTyp = 'G' and totLin > 1);
      fieldName = %trimr(baseFldName) +
                 %editc(curLin: 'X');
    else;
      fieldName = baseFldName;
    endif;

    //  ... ausgeben Text
    if (curLin = 1);
      //      ... Feldname
      headerType = '*FIELDNAME';
      reset ds_literal;
      $lit_neg_1 = 'N';
      $lit_ind_1 = '70';
      $lit_neg_2 = 'N';
      $lit_ind_2 = '75';
      exsr #text;

      //      ... Feldtext
      headerType = '*FIELDTEXT';
      reset ds_literal;
      $lit_neg_1 = ' ';
      $lit_ind_1 = '70';
      $lit_neg_2 = 'N';
      $lit_ind_2 = '75';
      exsr #text;

      //      ... Feldtyp
      headerType = '*FIELDTYPE';
      reset ds_literal;
      $lit_neg_1 = 'N';
      $lit_ind_1 = '70';
      $lit_neg_2 = ' ';
      $lit_ind_2 = '75';
      exsr #text;

      //      ... Spaltenüberschrift
      headerType = '*COLHDG';
      reset ds_literal;
      $lit_neg_1 = ' ';
      $lit_ind_1 = '70';
      $lit_neg_2 = ' ';
      $lit_ind_2 = '75';
      exsr #text;
    endif;

    //  ... ausgeben Feld für Schlüsselanzeiger
    if (curLin = 1);
      reset ds_fldDef;
      $fldD_fldN = 'KEY' + a#fldCount;
      $fldD_len  = '    1';
      $fldD_dTyp = 'A';
      $fldD_decP = '  ';
      $fldD_io   = 'O';
      $fldD_row  = row#;
      $fldD_col  = 26;
      p_wrtDspF(ds_fldDef);
    endif;

    //  ... ausgeben "hidden field" für Nachrichtennummer TXT...
    if (curLin = 1);
      reset ds_msgHidden;
      $msgH_fldN = 'MSG' + a#fldCount;
      p_wrtDspF(ds_msgHidden);
    endif;

    //  ... ausgeben Hinweis "Unzulässige Zeichen"
    if (curLin = 1);
      reset ds_msgChar;
      $msgC_ind  = ind40#a;
      $msgC_len  = '';
      $msgC_dTyp = '';
      $msgC_io   = '';
      $msgC_row$ = '';
      $msgC_col$ = '';
      $msgC_kWrd = '';
      p_wrtDspF(ds_msgChar);

      reset ds_msgChar;
      $msgC_op     = 'O';
      $msgC_ind    = ind50#a;
      $msgC_fldN = 'TXT' + a#fldCount;
      $msgC_fldNum = a#fldCount;
      $msgC_row    = row#;
      $msgC_col    = 29;
      p_wrtDspF(ds_msgChar);
    endif;

    //  ... Farbe: weiß
    if (curLin = 1);
      reset ds_dspAtr;
      $dspA_atr = 'COLOR(WHT)';
      p_wrtDspF(ds_dspAtr);
    endif;

    //  ... ausgeben Felddefinition
    reset ds_fldDef;
    $fldD_fldN = fieldName;

    //      ... Referenzierung - Zeile 1
    $fldD_row  = row# + (curLin - 1);
    $fldD_col  = 29;

    //  CHAR-Felder mit CCSID 1208 (UTF-8) nicht referenzieren: REFFLD
    //  übernimmt die CCSID, die eine Bildschirmdatei nicht kennt
    //  (CPD5112), und CCSID() ist nur für GRAPHIC-Felder zulässig
    //  (CPD7554). Das Feld wird als CHAR-Feld in Feldlänge erzeugt;
    //  beim Lesen und Schreiben des Satzes setzt die Datenbank zwischen
    //  UTF-8 und der Job-CCSID um.
    if (fldl0100.f1DTyp = 'A' and
       (fldl0100.f1fdcc = 1200 or
       fldl0100.f1fdcc = 1208));
      isutf8 = bTrue;
    else;
      isutf8 = bFalse;
    endif;

    //          ... Referenzfeld
    if (fldl0100.f1DTyp <> 'G' and fldl0100.f1DTyp <> '8' and // = Graphic/Boolean
       isutf8 = bFalse);
      $fldD_ref  = 'R';
      $fldD_kWrd = 'REFFLD(' +
                  %trimr(fldl0100.f1FNme) + ' -';
      hasRefFld = bTrue;
    else;
      hasRefFld = bFalse;
    endif;

    //          ... Datentyp
    select;
    when ((fldl0100.f1DTyp = 'L') or // = Date
       (fldl0100.f1DTyp = 'T') or   // = Time
       (fldl0100.f1DTyp = 'Z') or   // = Boolean
       (fldl0100.f1DTyp = '8'));     // = Timestamp
      $fldD_dTyp = 'A';
    when (fldl0100.f1DTyp = 'G');   // = Graphic
      $fldD_dTyp = 'G';
    when (isutf8 = bTrue);          // = UTF-8, ohne REFFLD
      $fldD_dTyp = 'A';
    other;
      $fldD_dTyp = ' ';
    endsl;

    //          ... Feldlänge
    if ((f_isToLong(fldl0100) = bTrue) or
        (fldl0100.f1DTyp = 'G' and totLin > 1));
      if (fldl0100.f1DTyp = 'G'); // = Graphic
        if (curLin < totLin);
          newLen# = f_cntFldLn(fldl0100);
        else;
          newLen# = f_dsplyLn(fldl0100) - dspLen;
          if (newLen# > f_cntFldLn(fldl0100));
            newLen# = f_cntFldLn(fldl0100);
          endif;
        endif;
        dspLen = dspLen + newLen#;
      else;
        newLen# = f_maxDspLn(fldl0100);
      endif;
    else;
      newLen# = f_dsplyLn(fldl0100);
    endif;

    select;
    when (fldl0100.f1DTyp = '8');        // = Boolean
      $fldD_len  = newLen#a;
    when (fldl0100.f1DTyp = 'G' or       // = Graphic
          f_isToLong(fldl0100) = bTrue or
          isutf8 = bTrue);               // = UTF-8, ohne REFFLD
      $fldD_len  = newLen#a;
    other;
      $fldD_len  = '';
    endsl;

    //          ... Bezugszahl
    $fldD_neg  = '  ';
    $fldD_ind40= ind40#a;
    $fldD_ind50= ind50#a;
    //          ... Input Feld
    if (fldl0100.f1use = 'I');
      $fldD_io   = 'O';
    else;
      $fldD_io   = 'B';
    endif;

    $fldD_decP = '  ';
    p_wrtDspF(ds_fldDef);

    //      ... Referenzierung - Zeile 2
    if (hasRefFld = bTrue);
      reset ds_fldCnt;
      $fldC_kWrd =
      %trimr(refLib) + '/' + %trimr(refFile) + ')';
      p_wrtDspF(ds_fldCnt);
    endif;

    //  ... Feld über mehrere Zeilen verteilen
    if (fldl0100.f1DTyp <> 'G'); // = Graphic
      if (totLin > 1);
        reset ds_dspAtr;
        $dspA_atr = 'CNTFLD(35)';
        p_wrtDspF(ds_dspAtr);
      endif;
    else;
    //       // TODO: Feld über mehrere Zeilen splitten
    endif;

    //  ... CCSID und Feldlänge für GRAPHIC Felder
    if (fldl0100.f1DTyp = 'G'); // = Graphic
      reset ds_dspAtr;
      $dspA_atr = 'CCSID(13488 ' +
                  %char(%int((newLen# / 2) + .5))
                  + ')';
      p_wrtDspF(ds_dspAtr);
    endif;

    //  Alias Feldname überschreiben, weil:
    //   - Aliasnamen in Groß-/Kleinbuchstaben sind nicht zulässig.
    //   - Einige Sonderzeichen wie zum Beispiel '#' oder '.' sind
    //     in einer Display File nicht zulässig.
    //  Der tatsächliche Alias Name spielt keine Rolle und wird daher
    //  auf den generierten Namen 'ALSnnnnn' gesetzt. Es könnte auch
    //  jeder andere eindeutige Name sein.
    if (fldl0100.f1afnl > 0 and hasRefFld = bTrue);
      reset ds_alias;
      $alias_kWrd = 'ALIAS(' +
                   'ALS' + a#fldCount
                   + ')';
      p_wrtDspF(ds_alias);
    endif;

    //  Auf INPUT-Only-Felder prüfen ...
    if (fldl0100.f1use <> 'I');
      //  .. Farbe = weiß
      reset ds_dspAtr;
      $dspA_atr = 'COLOR(WHT)';
      p_wrtDspF(ds_dspAtr);
    else;
      //  .. Farbe = grün
      reset ds_dspAtr;
      $dspA_atr = 'COLOR(GRN)';
      p_wrtDspF(ds_dspAtr);
    endif;

    //  Feld schützen, wenn größer als 512-Zeichen ...
    if ((f_isToLong(fldl0100) = bTrue) or
        (f_isNotAlw(fldl0100) = bTrue));
      if (fldl0100.f1use <> 'I');
        reset ds_dspAtr;
        $dspA_atr = 'DSPATR(PR)';
        p_wrtDspF(ds_dspAtr);

        reset ds_dspAtr;
        $dspA_ind = '72';
        $dspA_atr = 'DSPATR(UL)';
        p_wrtDspF(ds_dspAtr);
      endif;
      fldToLong = '1';
    else;
      //  Schlüsselfelder schützen/freigeben ...
      if (f_isKeyFld(fldl0100) = bTrue);
        if (fldl0100.f1use <> 'I');
          reset ds_dspAtr;
          $dspA_neg = 'N';
          $dspA_ind = '73';
          $dspA_atr = 'DSPATR(PR)';
          p_wrtDspF(ds_dspAtr);

          reset ds_dspAtr;
          $dspA_ind = '73';
          $dspA_atr = 'DSPATR(UL)';
          p_wrtDspF(ds_dspAtr);
        endif;
      endif;
      fldToLong = '0';
    endif;

    //  EXIT03 kann den Edit Code aus PEEKFLD überschreiben. Nur bei
    //  numerischen Feldern, denn EDTCDE ist bei Zeichenfeldern nicht
    //  zulässig.
    if (isExit03 and
        f_isNumFld(fldl0100)   = bTrue and
        f_isFloatFld(fldl0100) = bFalse);
      callp(e) cvtEditCode(
        refFile: refLib
        : sds.user: fldl0100.f1FNme: f_edtCde);
      if (%error());
        isExit03 = bFalse;
      endif;
    endif;

    //  EDTWRD/EDTCDE ausgeben ...
    select;
    //  EDTWRD prüfen ...
    when (fldl0100.f1EdWd <> ' '); // Edit word
      //  Hochkommas verdoppeln und das Schlüsselwort auf Folgezeilen
      //  verteilen ('-' in Stelle 80): Der Schlüsselwortbereich hat 36
      //  Stellen, ein Editierwort bis zu 64 Zeichen.
      if (fldl0100.f1EdWl > 0 and
          fldl0100.f1EdWl <= %len(fldl0100.f1EdWd));
        edtWrd = %subst(fldl0100.f1EdWd: 1: fldl0100.f1EdWl);
      else;
        edtWrd = %trimr(fldl0100.f1EdWd);
      endif;
      edtWrd = 'EDTWRD(''' + %scanrpl('''': '''''': edtWrd) + ''')';
      dow (%len(edtWrd) > %len($dspA_atr));
        reset ds_dspAtr;
        $dspA_atr = %subst(edtWrd: 1: %len($dspA_atr) - 1) + '-';
        p_wrtDspF(ds_dspAtr);
        edtWrd = %subst(edtWrd: %len($dspA_atr));
      enddo;
      reset ds_dspAtr;
      $dspA_atr = edtWrd;
      p_wrtDspF(ds_dspAtr);

    //  Abfragen Feld-EDTCDE aus PEEKFLD ...
    when (f_edtCde <> ' '           // Edit code
       and f_isFloatFld(fldl0100) = bFalse);
      reset ds_dspAtr;
      $dspA_atr = 'EDTCDE(' + f_edtCde + ')';
      p_wrtDspF(ds_dspAtr);

    other;
      //  Kein EDTWRD / kein EDTCDE
      if ((f_isNumFld(fldl0100)   = bTrue ) and
          (f_isFloatFld(fldl0100) = bFalse) and
          (fldl0100.f1DecP > 0            ));
        reset ds_dspAtr;
        $dspA_atr = 'EDTCDE(' + 'P' + ')';
        p_wrtDspF(ds_dspAtr);
      endif;
    endsl;

    //  Lower case Attribut
    //  bei Alpha-Feldern ...
    if ((fldl0100.f1DTyp = 'A' or
        fldl0100.f1DTyp = 'G') and
        (i_alwLC =  bTrue) and
        (fldl0100.f1use <> 'I'));
      reset ds_dspAtr;
      $dspA_atr = 'CHECK(LC) ';
      p_wrtDspF(ds_dspAtr);
    endif;

    if (fldl0100.f1DTyp = 'G');
      curLin = curLin + 1;
    else;
      curLin = curLin + totLin;
    endif;

  enddo;

  // ---------------------------*
  //  Copy-Strecken ausgeben
  // ---------------------------*
  exsr wrtCopy1;
  exsr wrtCopy2;
  exsr wrtCopy3;
  exsr wrtCopy4;
  exsr wrtCopy5;
  exsr wrtCopy6;

  // ---------------------------*
  //  erhöhen Zeilenzähler
  // ---------------------------*
  row# = row# + totLin;

  // ---------------------------*
  //  erhöhen Bezugszahlenzähler
  // ---------------------------*
  ind40# = ind40# + 1;
  ind50# = ind50# + 1;

endsr;

//============================================================*
//    inzScreen     Initialisieren neuen Bildschirm           *
//============================================================*

begsr inzScreen;

  //  Wenn die laufende Bildschirm-Nr. = 0 ist,
  //  dann ...
  if (scn# = 0);
  //    ... ist keine abzuschließende
  //        Subroutine vorhanden
  else;
    //    ... ansonsten Subroutine abschließen  (Copy-Book 1)
    p_wrtCopy1('endsr;');
    p_wrtCopy1('');
  endif;

  //  Eine neue Subroutine beginnen (Copy-Book 1) ...
  ind40# = 30;
  ind50# = 50;
  scn# = scn# + 1;

  p_wrtCopy1('//' + REM_LINE);
  p_wrtCopy1('//  Prüfung auf ungültige Feldinhalte, Seite ' + scn#a);
  p_wrtCopy1('//' + REM_LINE);
  p_wrtCopy1('');
  p_wrtCopy1('begsr chkChar' + scn#a + ';');
  p_wrtCopy1('');

  //  Einen neuen Record im DspF anfangen ...
  reset ds_rcdFmt;

  if (i_alwLC = bFalse);
    $rcdFm_nme = 'UC' + scn#a;
  else;
    $rcdFm_nme = 'LC' + scn#a;
  endif;

  p_wrtDspF(ds_rcdFmt);

  //  OVERLAY
  reset ds_overlay;
  p_wrtDspF(ds_overlay);
  //  WINDOW-Definition für *DS3
  reset ds_window;
  $wdw_mode = '*DS3';
  p_wrtDspF(ds_window);
  //  WINDOW-Definition für *DS4
  reset ds_window;
  $wdw_mode = '*DS4';
  p_wrtDspF(ds_window);
  //  Anzeigemodus
  reset ds_dspMode;
  p_wrtDspF(ds_dspMode);
  //  Cursor Position
  reset ds_csrLoc;
  p_wrtDspF(ds_csrLoc);
  //  Cursor Position, Variable CSRROW
  reset ds_fldDef;
  $fldD_fldN = 'CSRROW';
  $fldD_len  = '    3';
  $fldD_dTyp = 'S';
  $fldD_decP = ' 0';
  $fldD_io   = 'H';
  $fldD_row$ = ' ';
  $fldD_col$ = ' ';
  p_wrtDspF(ds_fldDef);
  //  Cursor Position, Variable CSRCOL
  reset ds_fldDef;
  $fldD_fldN = 'CSRCOL';
  $fldD_len  = '    3';
  $fldD_dTyp = 'S';
  $fldD_decP = ' 0';
  $fldD_io   = 'H';
  $fldD_row$ = ' ';
  $fldD_col$ = ' ';
  p_wrtDspF(ds_fldDef);

  //  Initialisierung Feldausgabe
  row#   = 4;

  newScn = bFalse;

endsr;

//============================================================*
//    wrtCopy1      Ausgeben Copy-Book 1 pro Feld             *
//                  Prüfung auf nicht darstellbare Zeichen    *
//============================================================*

begsr wrtCopy1;

  //  Feld: TEST#
  p_wrtCopy1('  // Feld: ' + %trimr(fldl0100.f1FNme));

  //  if (EDT00001 = '1');
  p_wrtCopy1('  if (EDT' + a#fldCount + ' = ''1'');');

  //    F_FIELD = 'TEST#';
  p_wrtCopy1('    F_FIELD = ''' + %trimr(fldl0100.f1FNme) + ''';');

  if (fldl0100.f1DTyp =  'G');
    totFields = f_nbrDspRw(fldl0100);
  else;
    totFields = 1;
  endif;

  //    yOutBuffer = FLD00001;
  if (f_isCharFld(fldl0100) = bTrue and
     f_isVarLen(fldl0100) = bTrue);
    exprOpen = 'yOutBuffer = %trimR(';
    exprClose = ')';
  else;
    exprOpen = 'yOutBuffer = ';
    exprClose = '';
  endif;

  for curField = 1 to totFields;

    if (f_isNumFld(fldl0100) = bTrue);
      if (fldl0100.f1DTyp = 'F');
        fldNme = '%editflt(FLD' + a#fldCount;
      else;
        fldNme = '%char(FLD' + a#fldCount;
      endif;
    else;
      fldNme = 'FLD' + a#fldCount;
    endif;

    if (totFields > 1);
      fldNme = fldNme + %editc(curField: 'X');
    endif;

    if (f_isNumFld(fldl0100) = bTrue);
      fldNme = fldNme + ')';
    endif;

    exsr wrtExpr1;

  endfor;

  //    yOutBuffLn = ...;
  if (f_isCharFld(fldl0100) = bFalse);
    p_wrtCopy1('    yOutBuffLn = 0;');
  else;

    if (f_isVarLen(fldl0100) = bTrue);
      exprOpen = 'yOutBuffLn = %len(%trimR(';
      exprClose = '))';
    else;
      exprOpen = 'yOutBuffLn = %len(';
      exprClose = ')';
    endif;

    for curField = 1 to totFields;

      fldNme = 'FLD' + a#fldCount;
      if (totFields > 1);
        fldNme = fldNme + %editc(curField: 'X');
      endif;

      exsr wrtExpr1;

    endfor;

  endif;

  //    exsr chkChar;
  p_wrtCopy1('    exsr chkChar;');

  //    *IN40 = isVisible;
  p_wrtCopy1('    *IN' + ind40#a + ' = isVisible;');

  //    EDT00001 = *IN40;
  p_wrtCopy1('    EDT' + a#fldCount + ' = *IN' + ind40#a + ';');

  //    KEY00001 = keyChar;
  p_wrtCopy1('    KEY' + a#fldCount + ' = keyChar;');

  //    if (isVisible = bFalse);
  //      MSG00001 = '0076';
  //    endif;
  p_wrtCopy1('    if (isVisible = bFalse);');
  p_wrtCopy1('      MSG' + a#fldCount + ' = ''0076'';');
  p_wrtCopy1('    endif;');

  //  else;
  //    isCvtChar = bTrue;
  //    *IN40 = EDT00001;
  //  endif;
  p_wrtCopy1('  else;');
  p_wrtCopy1('    isCvtChar = bTrue;');
  p_wrtCopy1('    *IN' + ind40#a + ' = EDT' + a#fldCount + ';');
  p_wrtCopy1('  endif;');
  p_wrtCopy1('');

  if (fldl0100.f1nalw = '1');
    //  if (%nullind(P_00000001));
    //    *IN50 = '0';
    //    MSG00001 = '0127';
    //  else;
    //    *IN50 = '1';
    //  endif;
    p_wrtCopy1('  if (%nullind(' + %trimr(fldl0100.f1vfld) + '));');
    p_wrtCopy1('    *IN' + ind50#a + ' = ''0'';');
    p_wrtCopy1('    MSG' + a#fldCount + ' = ''0127'';');
    p_wrtCopy1('  else;');
    p_wrtCopy1('    *IN' + ind50#a + ' = ''1'';');
    p_wrtCopy1('  endif;');

  else;

    //  *IN50 = '1';
    p_wrtCopy1('  *IN' + ind50#a + ' = ''1'';');

  endif;

  p_wrtCopy1('');

endsr;

//============================================================*
//    wrtExpr1      Ausgeben Zeile curField des Ausdrucks     *
//                  exprOpen + fldNme ... + exprClose         *
//                  in Copy-Book 1                            *
//============================================================*

begsr wrtExpr1;

  if (curField = 1);
    line = '    ' + exprOpen + fldNme;
  else;
    line = '      ' + fldNme;
  endif;

  if (curField < totFields);
    line = line + ' +';
  else;
    line = line + exprClose + ';';
  endif;

  p_wrtCopy1(line);

endsr;

//============================================================*
//    wrtCopy2      Ausgeben Copy-Book 2 pro Feld             *
//                  Aufrufen Hex-Editor                       *
//============================================================*

begsr wrtCopy2;

  //  Feld: TEST#
  p_wrtCopy2('  // Feld: ' + %trimr(fldl0100.f1FNme));

  //  when ((xScnCsrRow >= 04) and
  //        (xScnCsrRow <= 04) and
  //        (scnNbr      = 001));
  num# = row# + totLin - 1;
  p_wrtCopy2('  when ((xScnCsrRow >= ' + row#a + ') and');
  p_wrtCopy2('        (xScnCsrRow <= ' + num#a + ') and');
  p_wrtCopy2('        (scnNbr      = ' + scn#a + '));');

  //  Input-Only Feld?
  if (fldl0100.f1use = 'I');
    //  ... JA
    p_wrtCopy2('    exsr MSG8208;');
  else;
    //  ... NEIN
    //      if ((EDT00001 = '1') and
    //          not (LNG00001 = '1'));
    //        exsr f_P_00000001;
    //      endif;
    p_wrtCopy2('    if ((EDT' + a#fldCount + ' = ''1'') and');
    p_wrtCopy2('        not (LNG' + a#fldCount + ' = ''1''));');
    p_wrtCopy2('      exsr f_' + %trim(fldl0100.f1vfld) + ';');
    p_wrtCopy2('    endif;');

    //      yFldName = 'TEST#V    ';
    p_wrtCopy2('    yFldName = ''' + fldl0100.f1FNme + ''';');

    //      Editor = cEDITOR_HEX;
    p_wrtCopy2('    Editor = cEDITOR_HEX;');

    //      exsr fromBuffer;
    p_wrtCopy2('    exsr fromBuffer;');

    //      if (yMsgID = 'USR8112');
    //        exsr s_P_00000001;
    //        EDT00001 = '1';
    //        %nullind(P_00000001) = *OFF;
    //      endif;
    p_wrtCopy2('    if (yMsgID = ''USR8112'');');
    p_wrtCopy2('      exsr s_' + %trim(fldl0100.f1vfld) + ';');
    p_wrtCopy2('      EDT' + a#fldCount + ' = ''1'';');
    if (fldl0100.f1nalw = '1');
      p_wrtCopy2('      %nullind(' + %trimr(fldl0100.f1vfld) +
                 ') = *OFF;');
    endif;
    p_wrtCopy2('    endif;');

    p_wrtCopy2('');

  endif;

endsr;

//============================================================*
//    wrtCopy3      Ausgeben Copy-Book 3 pro Feld             *
//                  Felder für Feldsperre                     *
//============================================================*

begsr wrtCopy3;

  //  dcl-s EDT00001 char(1) inz;
  p_wrtCopy3('dcl-s EDT' + a#fldCount + ' char(1) inz;');

endsr;

//============================================================*
//    wrtCopy4      Ausgeben Copy-Book 4 pro Feld             *
//                  Konstanten für "Feld zu lang"             *
//============================================================*

begsr wrtCopy4;

  //  dcl-c LNG00001 '0'; / dcl-c LNG00001 '1';
  p_wrtCopy4('dcl-c LNG' + a#fldCount + ' ''' + fldToLong + ''';');

endsr;

//============================================================*
//    wrtCopy5      Ausgeben Copy-Book 5 pro Feld             *
//                  Setzen NULL Indicator                     *
//============================================================*

begsr wrtCopy5;

  //  Feld: TEST#
  p_wrtCopy5('// Feld: ' + %trimr(fldl0100.f1FNme));

  //  when ((xScnCsrRow >= 04) and
  //        (xScnCsrRow <= 04) and
  //        (scnNbr      = 001));
  num# = row# + totLin - 1;
  p_wrtCopy5('when ((xScnCsrRow >= ' + row#a + ') and');
  p_wrtCopy5('      (xScnCsrRow <= ' + num#a + ') and');
  p_wrtCopy5('      (scnNbr      = ' + scn#a + '));');

  // %nullind(P_00000001) =
  //   not %nullind(P_00000001);
  if (fldl0100.f1nalw = '1');

    p_wrtCopy5('  %nullind(' + %trimr(fldl0100.f1vfld) + ') =');
    p_wrtCopy5('    not %nullind(' + %trimr(fldl0100.f1vfld) + ');');

  else;

    //  Setzen Fehlerflag: Feld ist nicht NULL-fähig
    p_wrtCopy5('  pgmMsgID = ''USR8191'';');
    p_wrtCopy5('  pgmMsgDta = FLDL0100.F1FNME;');
    p_wrtCopy5('  p_sndPgmMg(pgmMsgID: pgmMsgDta: psPgmName);');

  endif;

  p_wrtCopy5('');

endsr;

//============================================================*
//    wrtCopy6      Ausgeben Copy-Book 6 pro Feld             *
//                  Aufrufen String-Editor  (c_fldStrEd)      *
//============================================================*

begsr wrtCopy6;

  //  Feld: TEST#
  p_wrtCopy6('  // Feld: ' + %trimr(fldl0100.f1FNme));

  //  when ((xScnCsrRow >= 04) and
  //        (xScnCsrRow <= 04) and
  //        (scnNbr      = 001));
  num# = row# + totLin - 1;
  p_wrtCopy6('  when ((xScnCsrRow >= ' + row#a + ') and');
  p_wrtCopy6('        (xScnCsrRow <= ' + num#a + ') and');
  p_wrtCopy6('        (scnNbr      = ' + scn#a + '));');

  //    yFldName = 'TEST#V    ';
  p_wrtCopy6('    yFldName = ''' + fldl0100.f1FNme + ''';');

  //  Input-Only Feld?
  if (fldl0100.f1use = 'I');
    p_wrtCopy6('    exsr MSG8208;');
    leavesr;
  endif;

  //  Not a character Feld? => Error message
  if (f_isCharFld(fldl0100) <> bTrue);
    p_wrtCopy6('    exsr MSG8221;');
    leavesr;
  endif;

  //    if (EDT00001 <> '1');
  //      exsr USR8193;
  //      leavesr;
  //    endif;
  p_wrtCopy6('    if (EDT' + a#fldCount + ' <> ''1'');');
  p_wrtCopy6('      exsr USR8193;');
  p_wrtCopy6('      leavesr;');
  p_wrtCopy6('    endif;');

  //    if (not (LNG00001 = '1'));
  //      exsr f_P_00000001;
  //    endif;
  p_wrtCopy6('    if (not (LNG' + a#fldCount + ' = ''1''));');
  p_wrtCopy6('      exsr f_' + %trim(fldl0100.f1vfld) + ';');
  p_wrtCopy6('    endif;');

  //    Editor = cEDITOR_STRING;
  p_wrtCopy6('    Editor = cEDITOR_STRING;');

  //    yLength = %len(P_00000001);
  p_wrtCopy6('    yLength = %len(' + %trimr(fldl0100.f1vfld) + ');');

  //    exsr fromBuffer;
  p_wrtCopy6('    exsr fromBuffer;');

  //    if (yMsgID = 'USR8112');
  //      exsr s_P_00000001;
  //      EDT00001 = '1';
  //      %nullind(P_00000001) = *OFF;
  //    endif;
  p_wrtCopy6('    if (yMsgID = ''USR8112'');');
  p_wrtCopy6('      exsr s_' + %trim(fldl0100.f1vfld) + ';');
  p_wrtCopy6('      EDT' + a#fldCount + ' = ''1'';');
  if (fldl0100.f1nalw = '1');
    p_wrtCopy6('      %nullind(' + %trimr(fldl0100.f1vfld) +
               ') = *OFF;');
  endif;
  p_wrtCopy6('    endif;');

  p_wrtCopy6('');

endsr;

//============================================================*
//    #TEXT         Aufbereiten Feldbezeichner                *
//============================================================*

begsr #text;

  $lit_kWrd = '''';

  // Feldtyp
  // Feldname
  select;
  when (headerType = '*FIELDNAME');
    $lit_kWrd =
     %trimr($lit_kWrd) + fldl0100.f1FNme;
    x = %len(%trimr($lit_kWrd));
    y = x;
  // Feldtyp
  when (headerType = '*FIELDTYPE');
    $lit_kWrd = %trimr($lit_kWrd) +
               f_headline(headerType: fldl0100);
    x = %len(%trimr($lit_kWrd));
    y = x;
  // Feldtext oder Spaltenüberschrift
  other;
    //  Bezeichnung auf ' prüfen ...
    r$text = f_headline(headerType: fldl0100);
    r$ftxt = '';
    x = 1;
    y = 1;
    dow ((x <= %len(%trimr(r$text))) and
       (y <= %len(r$ftxt)));
      %subst(r$ftxt: y: 1) =
       %subst(r$text: x: 1);

      if ((%subst(r$text: x: 1) = '''') and
          (y < %len(r$ftxt)));
        y = y + 1;
        %subst(r$ftxt: y: 1) = '''';
      endif;

      x = x + 1;
      y = y + 1;
    enddo;

    $lit_kWrd = %trimr($lit_kWrd) + r$ftxt;
  endsl;

  //  Hinzufügen '........'
  $lit_kWrd = %trimr($lit_kWrd) + dotLine;

  //  Begrenzen Textlänge auf max. mögliche Anzahl Zeichen
  if (26 + y - x <= %len($lit_kWrd));
    %subst($lit_kWrd: 25 + y - x: 1) = '''';
    %subst($lit_kWrd: 26 + y - x   ) = ' ';
  endif;

  //  Prüfen auf ungerade Anzahl ' (Hochkommata)
  numQuote = 0;

  z = 0;
  dow (z < %len(%trimr($lit_kWrd)));
    z = z + 1;
    if (%subst($lit_kWrd: z: 1) = '''');
      numQuote = numQuote + 1;
    endif;
  enddo;

  //  Bei einer ungeraden Anzahl von Hochkommata ...
  if (%rem(numQuote : 2) <> 0);
    //  ... suchen letztes Hochkomma
    dow (%subst($lit_kWrd: z: 1) <> '''');
      z = z - 1;
    enddo;
    //  ... ersetzen letztes Hochkomma durch Leerzeichen
    if (z < %len($lit_kWrd));
      %subst($lit_kWrd: %len($lit_kWrd): 1) = '''';
    else;
      %subst($lit_kWrd: z: 1) = ' ';
      //  ... suchen letztes Hochkomma
      dow (%subst($lit_kWrd: z: 1) <> '''');
        z = z - 1;
      enddo;
      //      und löschen ales hinter dem letzten Hochkomma
      %subst($lit_kWrd: z + 1) = '';
    endif;
  endif;

  //  Ausgeben Textfeld
  $lit_row = row#;
  $lit_col = 2;
  p_wrtDspF(ds_literal);

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  exit03 = f_pgmCallN('EXIT03');

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
//    wrtDspF       Ausgeben Copy-Book 1    'Cxxxxxxxxx'      *
//============================================================*
dcl-proc p_wrtDspF;
  dcl-pi *n;
    i_srcDta like(srcDta) const;
  end-pi;

  #srcSeq = #srcSeq + #Increment;

  srcSeq  = #srcSeq;
  srcDat = 0;
  srcDta  = i_srcDta;
  write foutput;

  return;

end-proc;

//============================================================*
//    wrtCopy1      Ausgeben Copy-Book 1    'Axxxxxxxxx'      *
//                  Prüfung auf ungültige Feldinhalte         *
//============================================================*
dcl-proc p_wrtCopy1;
  dcl-pi *n;
    i_srcDta like(srcDta) const;
  end-pi;

  if (i_alwLC = bFalse);
    //  Nur einmal ausgeben, bei XAlwLC = FALSE
    srcSeq = 0;
    srcDat = 0;
    srcDta  = i_srcDta;
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
dcl-proc p_wrtCopy2;
  dcl-pi *n;
    i_srcDta like(srcDta) const;
  end-pi;

  if (i_alwLC = bFalse);
    //  Nur einmal ausgeben, bei XAlwLC = FALSE
    srcSeq = 0;
    srcDat = 0;
    srcDta  = i_srcDta;
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
dcl-proc p_wrtCopy3;
  dcl-pi *n;
    i_srcDta like(srcDta) const;
  end-pi;

  if (i_alwLC = bFalse);
    //  Nur einmal ausgeben, bei XAlwLC = FALSE
    srcSeq = 0;
    srcDat = 0;
    srcDta  = i_srcDta;
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
dcl-proc p_wrtCopy4;
  dcl-pi *n;
    i_srcDta like(srcDta) const;
  end-pi;

  if (i_alwLC = bFalse);
    //  Nur einmal ausgeben, bei XAlwLC = FALSE
    srcSeq = 0;
    srcDat = 0;
    srcDta  = i_srcDta;
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
dcl-proc p_wrtCopy5;
  dcl-pi *n;
    i_srcDta like(srcDta) const;
  end-pi;

  if (i_alwLC = bFalse);
    //  Nur einmal ausgeben, bei XAlwLC = FALSE
    srcSeq = 0;
    srcDat = 0;
    srcDta  = i_srcDta;
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
dcl-proc p_wrtCopy6;
  dcl-pi *n;
    i_srcDta like(srcDta) const;
  end-pi;

  if (i_alwLC = bFalse);
    //  Nur einmal ausgeben, bei XAlwLC = FALSE
    srcSeq = 0;
    srcDat = 0;
    srcDta  = i_srcDta;
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
dcl-proc f_readFld;
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

