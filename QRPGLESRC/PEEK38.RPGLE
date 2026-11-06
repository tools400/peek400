**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 3.2.6                               *
//  Programm : PEEK38                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 05.04.2011  Thomas Raddatz                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Erstellen SQL ORDER BY                            *
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
/copy QCOPYLE,SDS
/copy QCOPYLE,KEYL0100
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK38
/undefine internal_prototype

/copy QCOPYLE,PPEEK41

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-ds yqfile likeds(qobj_t) inz;
dcl-s ydata char(512);

dcl-s peek41_name like(pgmcalln_t);

dcl-s rc like(int4_t);
dcl-s nbrofkey like(int4_t);
dcl-s tempfield like(o_sqlorder);
dcl-s keypart varchar(32);
dcl-ds keyl0100 likeds(keyl0100_t) inz;

dcl-s isinzsr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek38;
  i_file     like(file_t) const;
  i_lib      like(lib_t) const;
  o_sqlorder like(sqlorder_t);
end-pi;

dcl-s do_x1 packed(7);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

//  Einlesen der Dateiinformationen ...
yqfile.name = i_file;
yqfile.lib = i_lib;
peek41(yqfile: '*FIRST': '*CREATE'
      : rc: ydata);

//  Einlesen der Schlüsselinformationen ...
peek41(yqfile: '*FIRST': '*KEY'
      : nbrofkey: ydata);

tempfield = '';

for do_x1 = 1 to nbrofkey;
  peek41(yqfile: '*FIRST': '*READKEY'
        : rc: ydata);
  keyl0100 = ydata;

  keypart = '"' + %trim(keyl0100.apkeyf) + '"';

  select;
  when (keyl0100.apkseq = 'A');
    keypart += ' ASC';
  when (keyl0100.apkseq = 'D');
    keypart += ' DESC';
  other;
  //          keine Schlüsselangaben gefunden
  endsl;

  if (tempfield <> '');
    keypart = ', ' + keypart;
  endif;

  //  Nur vollständige Schlüsselfelder übernehmen: Ein abgeschnittener
  //  Name ergäbe ungültiges SQL. Dann wird nach den ersten Feldern sortiert.
  if (%len(tempfield) + %len(keypart) > %len(tempfield: *max));
    leave;
  endif;

  tempfield += keypart;
endfor;

o_sqlorder = tempfield;

return;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isinzsr = bTrue);
    leavesr;
  endif;

  isinzsr = bTrue;

  peek41_name = f_pgmcalln('PEEK41');

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

