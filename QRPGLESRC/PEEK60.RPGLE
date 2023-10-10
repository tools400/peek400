**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.3.2                               *
//  Programm : PEEK60                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 08.03.2006  Thomas Raddatz                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Ermitteln Aufwand für Pgm-Generieren              *
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
/COPY QCOPYLE,CEECNDHDLR

/define internal_prototype
/COPY QCOPYLE,PPEEK60
/undefine internal_prototype

dcl-c cnumpasses_peek08 4;
dcl-c cnumpasses_peek15 2;
dcl-c cnumpasses_peek16 7;

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

  dcl-pi peek60;
  i_alwlc         const like(bool_t);
o_numpasses     like(int4_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

//  Steuerung: Generieren Display File und RPG Programm
o_numpasses = cnumpasses_peek08;

//  1. Aufruf PEEK15 (generieren Display File)
o_numpasses = o_numpasses + cnumpasses_peek15;

//  2. Aufruf PEEK15 (generieren Display File, lower cases)
  if (i_alwlc = bTrue);
o_numpasses = o_numpasses + cnumpasses_peek15;
endif;

//  3. Aufruf PEEK16 (generieren RPG Programm)
o_numpasses = o_numpasses + cnumpasses_peek16;

return;

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

