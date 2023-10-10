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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,SDS
/COPY QCOPYLE,KEYL0100
/COPY QCOPYLE,CEECNDHDLR

/define internal_prototype
/COPY QCOPYLE,PPEEK38
/undefine internal_prototype

/COPY QCOPYLE,PPEEK41

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-ds yqfile     likeds(qobj_t) inz;
dcl-s ydata       char(512);

dcl-s peek41_name like(pgmcalln_t);

dcl-s rc          like(int4_t);
dcl-s nbrofkey    like(int4_t);
dcl-s tempfield   like(o_sqlorder );
dcl-ds keyl0100   likeds(keyl0100_t) inz;

dcl-s isinzsr         like(bool_t) inz(bfalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek38;
  i_file          const like(file_t);
  i_lib           const like(lib_t);
  o_sqlorder      like(sqlorder_t);
end-pi;

dcl-s do_x1           packed(7);
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

tempfield = ' ';

for do_x1 = 1 to nbrofkey;
  peek41(yqfile: '*FIRST': '*READKEY'
        : rc: ydata);
  keyl0100 = ydata;

  if (tempfield = *blanks);
    tempfield =
     %trim(tempfield) +
     '"' + %trim(keyl0100.apkeyf) + '"';
  else;
    tempfield =
     %trim(tempfield) +
     ', "' + %trim(keyl0100.apkeyf) + '"';
  endif;

  select;
  when (keyl0100.apkseq = 'A');
    tempfield = %trim(tempfield) + ' ASC';
  when (keyl0100.apkseq = 'D');
    tempfield = %trim(tempfield) + ' DESC';
  other;
  //          keine Schlüsselangaben gefunden
  endsl;

endfor;

o_sqlorder = tempfield;

return;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isinzsr = btrue);
    leavesr;
  endif;

  isinzsr = btrue;

  peek41_name = f_pgmcalln('PEEK41');

endsr;

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

