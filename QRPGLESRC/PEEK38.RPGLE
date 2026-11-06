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

dcl-ds YQFile likeds(qObj_t) inz;
dcl-s YData char(512);

dcl-s peek41_name like(pgmCallN_t);

dcl-s rc like(int4_t);
dcl-s nbrOfKey like(int4_t);
dcl-s tempField like(o_sqlOrder);
dcl-s keypart varchar(32);
dcl-ds keyl0100 likeds(KEYL0100_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek38;
  i_file     like(file_t) const;
  i_lib      like(lib_t) const;
  o_sqlOrder like(sqlOrder_t);
end-pi;

dcl-s do_x1 packed(7);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

//  Einlesen der Dateiinformationen ...
YQFile.name = i_file;
YQFile.lib = i_lib;
peek41(YQFile: '*FIRST': '*CREATE'
      : rc: YData);

//  Einlesen der Schlüsselinformationen ...
peek41(YQFile: '*FIRST': '*KEY'
      : nbrOfKey: YData);

tempField = '';

for do_x1 = 1 to nbrOfKey;
  peek41(YQFile: '*FIRST': '*READKEY'
        : rc: YData);
  keyl0100 = YData;

  keypart = '"' + %trim(keyl0100.apkeyf) + '"';

  select;
  when (keyl0100.apkseq = 'A');
    keypart += ' ASC';
  when (keyl0100.apkseq = 'D');
    keypart += ' DESC';
  other;
  //          keine Schlüsselangaben gefunden
  endsl;

  if (tempField <> '');
    keypart = ', ' + keypart;
  endif;

  //  Nur vollständige Schlüsselfelder übernehmen: Ein abgeschnittener
  //  Name ergäbe ungültiges SQL. Dann wird nach den ersten Feldern sortiert.
  if (%len(tempField) + %len(keypart) > %len(tempField: *max));
    leave;
  endif;

  tempField += keypart;
endfor;

o_sqlOrder = tempField;

return;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  peek41_name = f_pgmCallN('PEEK41');

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

