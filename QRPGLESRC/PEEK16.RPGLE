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
//  Die Vorlage PEEKSRC/PGM ist ein **FREE-Quelltext mit Marken: *
//    //@TAG     Kommentarzeile, hinter der PEEK16 den Code des  *
//               Tags einfügt, eingerückt wie die Marke.         *
//    X_TAG_X    Platzhalter, den PEEK16 in jeder Zeile ersetzt. *
//    LIBRARY_NAME  Produktbibliothek in /include-Anweisungen.   *
//  Die Eingabebestimmungen für das Umbenennen der Datenbank-    *
//  felder (RNM2) schreibt PEEK16 in die Teildatei von QCOPYLE7, *
//  die das generierte Programm mit /include einbindet.          *
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

dcl-f qcopyle7 extdesc('QPEEKGEN') usage(*output) usropn rename(qpeekgen: fcopy7) block(*no)
               infds(copy7Infds);

dcl-f peekSrc usropn rename(peekSrc: finput);

dcl-f peekFld usropn;

//  Geöffnete Teildatei von QCOPYLE7 (für die /include-Anweisung)
dcl-ds copy7Infds qualified;
  file char(10) pos(83);
  lib  char(10) pos(93);
  mbr  char(10) pos(129);
end-ds;

//===============================================================*
//  Datenstrukturen für die Codegenerierung
//===============================================================*

//  Eingabebestimmung (Fixed-Form) für das Umbenennen eines Feldes
dcl-ds ds_rnmBuf len(112);
  $rnmBf_spc char(1) inz('I') pos(6);
  $rnmBf_xFd char(10) inz pos(21);
  $rnmBf_iFd char(14) inz pos(49);
end-ds;

dcl-s #srcSeq like(srcSeq);
dcl-s #srcSeq7 like(srcSeq);
dcl-c #Increment 0,01;

dcl-ds *n;
  fieldCount zoned(5) inz(*zeros);
  a#fldCount char(5) overlay(fieldCount: 1);
end-ds;

dcl-ds *n;
  scn#  zoned(3) inz;
  scn#a char(3) overlay(scn#: 1);
end-ds;

/copy QCOPYLE,SDS

dcl-s tag char(4) inz;
dcl-s indent varchar(100) inz;
dcl-s lvl varchar(20) inz;
dcl-s line varchar(200) inz;
dcl-s fldNme varchar(20) inz;
dcl-s exprOpen varchar(40) inz;
dcl-s exprClose varchar(4) inz;
dcl-s scnNbr like(int4_t) inz;
dcl-s p int(10) inz;
dcl-s q int(10) inz;
dcl-s e int(10) inz;

dcl-c UNKNOWN_FIELD_TYPE ': Unknown field type';

dcl-s totFields int(10) inz;
dcl-s curField zoned(2) inz;

dcl-s nullDft char(4) inz;

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100

/define internal_prototype
/copy QCOPYLE,PPEEK16
/undefine internal_prototype

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-pr p_wrtOut extproc(*dclcase);
  i_srcDta like(srcDta) const;
end-pr;

dcl-pr p_wrtCode extproc(*dclcase);
  i_code varchar(200) const;
end-pr;

dcl-pr p_wrtCopy7 extproc(*dclcase);
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
open qcopyle7;
open peekSrc;

#srcSeq = 0;
#srcSeq7 = 0;

dow ('1');
  read finput;
  if (%eof());
    leave;
  endif;

  exsr getMarker;

  //  Keine Marke: Platzhalter ersetzen und kopieren ...
  if (tag = '');
    exsr rplPlaceholders;
    p_wrtOut(srcDta);
    iter;
  endif;

  //  Marke kopieren und den Code des Tags einfügen
  p_wrtOut(srcDta);

  select;

  //  Felddefinitionen
  when (tag = 'DEF1');
    exsr sub014;

  //  Konstanten für "Feld zu lang"
  when (tag = 'DEF2');
    exsr sub016;

  //  Prüfen ...
  when (tag = 'CHKS');
    exsr sub015;

  //  Blättern ...
  when (tag = 'SCRN');
    exsr sub003;

  //  1. Seite ...
  when (tag = 'SCN1');
    exsr sub013;

  //  Übertragen Dateifelder in Bildschirmfelder
  when (tag = 'TSCN');
    exsr sub004;

  //  Übertragen Bildschirmfelder in Dateifelder
  when (tag = 'FSCN');
    exsr sub007;
    exsr sub005;

  //  Prüfung ungültige Zeichen
  when (tag = 'CHKC');
    exsr sub006;

  //  Setzen NULL Indicator
  when (tag = 'NULL');
    exsr sub017;

  //  Hex-Editierung
  when (tag = 'HEX');
    exsr sub008;

  //  Text-Editierung
  when (tag = 'TXT');
    exsr sub018;

  //  Rename-Struktur: Unterfelder
  when (tag = 'RNM1');
    exsr sub010;

  //  Umbenennen Dateifelder: /include der Eingabebestimmungen
  when (tag = 'RNM2');
    exsr sub009;

  //  initialisieren ISO-Felder
  when (tag = 'ISO');
    exsr sub011;

  //  Unterroutinen Dateifelder ==> Bildschirmfelder
  when (tag = 'TOS');
    exsr sub020;

  //  Unterroutinen Bildschirmfelder ==> Dateifelder
  when (tag = 'TOF');
    exsr sub021;

  //  Löschen Felder im Datensatz
  when (tag = 'CLR');
    exsr sub022;

  //  Sichern NULL-Indikatoren
  when (tag = 'NSAV');
    exsr sub026;

  //  Zurückschreiben NULL-Indikatoren
  when (tag = 'NRST');
    exsr sub027;

  other;
  //  Unbekannte Marke: nur kopieren ...
  endsl;

enddo;

close qpeekgen;
close qcopyle7;
close peekSrc;

*inlr = *on;

//============================================================*
//    getMarker     Erkennen einer Marke '//@TAG'             *
//                  Liefert tag (leer: keine Marke) und       *
//                  indent (Einrückung der Marke).            *
//============================================================*

begsr getMarker;

  tag = '';
  indent = '';

  p = %check(' ': srcDta);
  if (p = 0 or p >= %len(srcDta));
    leavesr;
  endif;

  if (%subst(srcDta: p: 2) <> '//');
    leavesr;
  endif;

  if (p + 2 > %len(srcDta));
    leavesr;
  endif;

  q = %check(' ': srcDta: p + 2);
  if (q = 0 or q >= %len(srcDta));
    leavesr;
  endif;

  if (%subst(srcDta: q: 1) <> '@');
    leavesr;
  endif;

  e = %scan(' ': srcDta: q + 1);
  if (e = 0);
    e = %len(srcDta) + 1;
  endif;

  if ((e - q - 1) < 1 or (e - q - 1) > %len(tag));
    leavesr;
  endif;

  tag = %subst(srcDta: q + 1: e - q - 1);

  if (p > 1);
    indent = %subst(srcDta: 1: p - 1);
  endif;

endsr;

//============================================================*
//    rplPlaceholders  Ersetzen der Platzhalter X_TAG_X und   *
//                     LIBRARY_NAME in srcDta                 *
//============================================================*

begsr rplPlaceholders;

  if (%scan('X_': srcDta) = 0 and
      %scan('LIBRARY_NAME': srcDta) = 0);
    leavesr;
  endif;

  line = %trimr(srcDta);

  //  Satzformat der Datei
  line = %scanrpl('X_FMT1_X': %trim(i_rcdFmt): line);

  //  Anzahl Bildschirmseiten
  line = %scanrpl('X_LSCN_X': %char(i_scnNbrs): line);

  //  isLower
  if (i_case = bTrue);
    line = %scanrpl('X_LCAS_X': 'bTrue': line);
  else;
    line = %scanrpl('X_LCAS_X': 'bFalse': line);
  endif;

  //  isRcdLockDft
  if (i_rcdLock = bTrue);
    line = %scanrpl('X_RLCK_X': 'bTrue': line);
  else;
    line = %scanrpl('X_RLCK_X': 'bFalse': line);
  endif;

  //  isAlwLower
  if (i_alwLC = bTrue);
    line = %scanrpl('X_ALWL_X': 'bTrue': line);
  else;
    line = %scanrpl('X_ALWL_X': 'bFalse': line);
  endif;

  //  Beibehalten Cursor Position
  if (i_keepCrs = bTrue);
    line = %scanrpl('X_KEEP_X': '*on': line);
  else;
    line = %scanrpl('X_KEEP_X': '*off': line);
  endif;

  //  Länge der Rename-Struktur RCD_DS
  line = %scanrpl('X_RNM1_X': %char(RCD_BUFF_LEN): line);

  //  Produktbibliothek in /include- und /copy-Anweisungen
  if (%subst(%triml(line): 1: 1) = '/' and
      %subst(%triml(line) + ' ': 2: 1) <> '/');
    line = %scanrpl('LIBRARY_NAME': %trim(i_prodLib): line);
  endif;

  srcDta = line;

endsr;

//============================================================*
//    wrtExfmt      Anzeigen Bildschirmseite scn#a            *
//                  (Einrückung lvl)                          *
//============================================================*

begsr wrtExfmt;

  if (i_alwLC = bTrue);
    p_wrtCode(lvl + 'if (*in71);');
    p_wrtCode(lvl + '  exfmt LC' + scn#a + ';');
    p_wrtCode(lvl + 'else;');
    p_wrtCode(lvl + '  exfmt UC' + scn#a + ';');
    p_wrtCode(lvl + 'endif;');
  else;
    p_wrtCode(lvl + 'if (not *in71);');
    p_wrtCode(lvl + '  exfmt UC' + scn#a + ';');
    p_wrtCode(lvl + 'endif;');
  endif;

endsr;

//============================================================*
//    SUB003        Blättern                                  *
//============================================================*

begsr sub003;

  for scnNbr = 1 to i_scnNbrs;

    scn# = scnNbr;

    //  when (scnNbr = 001);
    p_wrtCode('when (scnNbr = ' + scn#a + ');');

    //    exfmt LC001 / UC001
    lvl = '  ';
    exsr wrtExfmt;

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
      p_wrtCode('// ' + %trimr(fldl0100.f1vfld) + UNKNOWN_FIELD_TYPE);
      iter;
    endif;

    p_wrtCode('exsr s_' + %trim(fldl0100.f1vfld) + ';');

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
      p_wrtCode('// ' + %trimr(fldl0100.f1vfld) + UNKNOWN_FIELD_TYPE);
      iter;
    endif;

    //  if ((EDT00002 = '1') and
    //      not (LNG00002 = '1')
    //      [and not %nullind(P_00000002)]);
    p_wrtCode('if ((EDT' + a#fldCount + ' = ''1'') and');
    if (fldl0100.f1nalw = '1');
      p_wrtCode('    not (LNG' + a#fldCount + ' = ''1'') and');
      p_wrtCode('    not %nullind(' + %trimr(fldl0100.f1vfld) + '));');
    else;
      p_wrtCode('    not (LNG' + a#fldCount + ' = ''1''));');
    endif;

    //  Übertragen BS-Feld in Dateifeld ...
    p_wrtCode('  exsr f_' + %trim(fldl0100.f1vfld) + ';');

    p_wrtCode('endif;');

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

    p_wrtCode(%trimr(srcDta));
  enddo;

  close qcopyle1;

endsr;

//============================================================*
//    SUB007        Alle Felder prüfen                        *
//============================================================*

begsr sub007;

  for scnNbr = 1 to i_scnNbrs;

    scn# = scnNbr;
    p_wrtCode('exsr chkChar' + scn#a + ';');

  endfor;

  p_wrtCode('');

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

    p_wrtCode(%trimr(srcDta));
  enddo;

  close qcopyle2;

endsr;

//============================================================*
//    SUB009        Umbenennen Dateifelder                    *
//                  Eingabebestimmungen in die Teildatei von  *
//                  QCOPYLE7, /include im Programm            *
//============================================================*

begsr sub009;

  //  /include der Eingabebestimmungen (Fixed-Form)
  p_wrtOut('/include ' + %trim(copy7Infds.lib) + '/' +
           %trim(copy7Infds.file) + ',' + %trim(copy7Infds.mbr));

  p_wrtCopy7('      *  Peek/400 - Umbenennen der Dateifelder (PEEK16)');
  p_wrtCopy7('     IFFILE00');

  open peekFld;

  setll 1 fpeekfld;

  dow (f_readFld <> bEOF);

    //  Rename
    reset ds_rnmBuf;
    $rnmBf_xFd = fldl0100.f1FNme;
    $rnmBf_iFd = fldl0100.f1vfld;
    p_wrtCopy7(ds_rnmBuf);

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

    //  P_00000001 extfld('FIELD');
    p_wrtCode(%trim(fldl0100.f1vfld) + ' extfld(''' +
              %trim(fldl0100.f1FNme) + ''');');

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

    //  if (FLD00011 = ' ');
    p_wrtCode('if (FLD' + a#fldCount + ' = '' '');');

    //  Initialisieren mit dem kleinsten Wert im Format des Feldes
    //  (alle Formate, z.B. '01/01/40' für *MDY; QCOPYLE,DATTIMFMT)
    line = '  FLD' + a#fldCount + ' = ';
    select;
    //  ... Zeitfeld
    when (fldl0100.f1DTyp = 'T');
      line = line + '''' + f_extTime(fldl0100: T'00.00.00') + '''';
    //  ... Datumsfeld
    when (fldl0100.f1DTyp = 'L');
      line = line + '''' + f_extDate(fldl0100: D'0001-01-01') + '''';
    //  ... Zeitstempelfeld
    when (fldl0100.f1DTyp = 'Z');
      line = line + 'ISOZ';
    endsl;
    p_wrtCode(line + ';');

    p_wrtCode('endif;');
    p_wrtCode('');

  enddo;

  close peekFld;

  io_stage = io_stage + 1;
  p_showProgressMeter(io_stage);

endsr;

//============================================================*
//    SUB013        Seite 1                                   *
//============================================================*

begsr sub013;

  scn# = 1;
  lvl = '';
  exsr wrtExfmt;

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

    p_wrtCode(%trimr(srcDta));
  enddo;

  close qcopyle3;

endsr;

//============================================================*
//    SUB015        Prüfen Feldinhalte                        *
//============================================================*

begsr sub015;

  for scnNbr = 1 to i_scnNbrs;

    scn# = scnNbr;

    //  when (scnNbr = 001);
    p_wrtCode('when (scnNbr = ' + scn#a + ');');

    //    exsr chkChar001;
    p_wrtCode('  exsr chkChar' + scn#a + ';');

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

    p_wrtCode(%trimr(srcDta));
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

    p_wrtCode(%trimr(srcDta));
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

    p_wrtCode(%trimr(srcDta));
  enddo;

  close qcopyle6;

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

    //  Generieren BEGSR
    p_wrtCode('// ' + %trimr(fldl0100.f1FNme));
    p_wrtCode('begsr s_' + %trim(fldl0100.f1vfld) + ';');
    p_wrtCode('');

    lvl = '  ';

    //  Löschen Felder, wenn NULL-fähig oder VARLEN
    if (fldl0100.f1nalw = '1' or
        f_isVarLen(fldl0100) = bTrue);

      for curField = 1 to totFields;
        if (totFields = 1);
          p_wrtCode(lvl + 'clear FLD' + a#fldCount + ';');
        else;
          p_wrtCode(lvl + 'clear FLD' + a#fldCount +
                    %editc(curField: 'X') + ';');
        endif;
      endfor;

      p_wrtCode('');

    endif;

    //  Generieren Abfrage auf NULL-Indicator
    if (fldl0100.f1nalw = '1');

      p_wrtCode(lvl + 'if (not %nullind(' +
                %trimr(fldl0100.f1vfld) + '));');
      lvl = lvl + '  ';

    endif;

    if (totFields > 1);

      //  Generieren:    offs = 0;
      if (fldl0100.f1nalw = '1');
        p_wrtCode('');
      endif;
      p_wrtCode(lvl + 'offs = 0;');
      p_wrtCode('');

      //  Generieren:    for x = 1 to 8;      (8 = totFields)
      p_wrtCode(lvl + 'for x = 1 to ' + %char(totFields) + ';');

      //  Generieren:      rem = %len(V_00000013) - offs;
      p_wrtCode(lvl + '  rem = %len(' + %trimr(fldl0100.f1vfld) +
                ') - offs;');

      //  Generieren:      if (rem > 18);  (18 = f_cntFldLn(..))
      p_wrtCode(lvl + '  if (rem > ' +
                %char(f_cntFldLn(fldl0100)) + ');');
      p_wrtCode(lvl + '    len = ' +
                %char(f_cntFldLn(fldl0100)) + ';');
      p_wrtCode(lvl + '  else;');
      p_wrtCode(lvl + '    len = rem;');
      p_wrtCode(lvl + '  endif;');

      //  Generieren:      select;
      p_wrtCode(lvl + '  select;');

      //  Übertragen Dateifeld --> Bildschirmfeld
      for curField = 1 to totFields;

        //  Generieren:    when (x = 1 and len > 0);
        p_wrtCode(lvl + '  when (x = ' + %char(curField) +
                  ' and len > 0);');

        //  Generieren:      FLD0001301 = %subst(V_00000013: offs+1: len);
        p_wrtCode(lvl + '    FLD' + a#fldCount +
                  %editc(curField: 'X') + ' = %subst(' +
                  %trimr(fldl0100.f1vfld) + ': offs+1: len);');

      endfor;

      //  Generieren:      endsl;
      p_wrtCode(lvl + '  endsl;');

      //  Generieren:      offs = offs + len;
      p_wrtCode(lvl + '  offs = offs + len;');

      //  Generieren:    endfor;
      p_wrtCode(lvl + 'endfor;');

    else;

      //  Übertragen Dateifeld --> Bildschirmfeld
      p_wrtCode(lvl + 'FLD' + a#fldCount + ' = ' +
                %trimr(fldl0100.f1vfld) + ';');

    endif;

    //  ENDIF von:   Generieren Abfrage auf NULL-Indicator
    if (fldl0100.f1nalw = '1');
      p_wrtCode('  endif;');
    endif;

    //  Generieren ENDSR
    p_wrtCode('');
    p_wrtCode('endsr;');
    p_wrtCode('');

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

    p_wrtCode('begsr f_' + %trim(fldl0100.f1vfld) + ';');

    //  Felder variabler Länge nur bei einer Änderung übernehmen: Das
    //  Bildschirmfeld hat feste Länge, %trimR entfernt sonst auch die
    //  nachgestellten Leerzeichen eines unveränderten Wertes.
    //    if (%trimR(FLD00005) <> %trimR(V_00000005));
    //      V_00000005 = %trimR(FLD00005);
    //    endif;
    if (f_isCharFld(fldl0100) = bTrue and
        f_isVarLen(fldl0100) = bTrue and totFields = 1);
      p_wrtCode('  if (%trimR(FLD' + a#fldCount + ') <> %trimR(' +
                %trim(fldl0100.f1vfld) + '));');
      p_wrtCode('    ' + %trim(fldl0100.f1vfld) +
                ' = %trimR(FLD' + a#fldCount + ');');
      p_wrtCode('  endif;');
      p_wrtCode('endsr;');
      p_wrtCode('');
      iter;
    endif;

    //  P_00000005 = %trimR(FLD00005);    (Zeichenfelder)
    //  P_00000005 = FLD00005;            (sonstige Felder)
    if (f_isCharFld(fldl0100) = bTrue);
      exprOpen = %trim(fldl0100.f1vfld) + ' = %trimR(';
      exprClose = ')';
    else;
      exprOpen = %trim(fldl0100.f1vfld) + ' = ';
      exprClose = '';
    endif;

    for curField = 1 to totFields;

      fldNme = 'FLD' + a#fldCount;
      if (totFields > 1);
        fldNme = fldNme + %editc(curField: 'X');
      endif;

      if (curField = 1);
        line = '  ' + exprOpen + fldNme;
      else;
        line = '    ' + fldNme;
      endif;

      if (curField < totFields);
        line = line + ' +';
      else;
        line = line + exprClose + ';';
      endif;

      p_wrtCode(line);
    endfor;

    p_wrtCode('endsr;');
    p_wrtCode('');

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
      p_wrtCode('%nullind(' + %trimr(fldl0100.f1vfld) + ') = ' +
                %trimr(nullDft) + ';');
    endif;

  enddo;

  close peekFld;

endsr;

//============================================================*
//    SUB026        Sichern NULL-Indikatoren                  *
//                  nullSave(00005) = %nullind(P_00000005);   *
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

    p_wrtCode('nullSave(' + a#fldCount + ') = %nullind(' +
              %trim(fldl0100.f1vfld) + ');');

  enddo;

  close peekFld;

endsr;

//============================================================*
//    SUB027        Zurückschreiben NULL-Indikatoren          *
//                  %nullind(P_00000005) = nullSave(00005);   *
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

    p_wrtCode('%nullind(' + %trim(fldl0100.f1vfld) +
              ') = nullSave(' + a#fldCount + ');');

  enddo;

  close peekFld;

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
//    wrtCode       Ausgeben generierte Codezeile, eingerückt *
//                  wie die Marke (indent)                    *
//============================================================*
dcl-proc p_wrtCode;
  dcl-pi *n;
    i_code varchar(200) const;
  end-pi;

  p_wrtOut(indent + i_code);

  return;

end-proc;

//============================================================*
//    wrtCopy7      Ausgeben Zeile der Teildatei von QCOPYLE7 *
//                  (Eingabebestimmungen für RNM2)            *
//============================================================*
dcl-proc p_wrtCopy7;
  dcl-pi *n;
    i_srcDta like(srcDta) const;
  end-pi;

  #srcSeq7 = #srcSeq7 + #Increment;

  srcSeq  = #srcSeq7;
  srcDta  = i_srcDta;
  write fcopy7;

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
