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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK60
/undefine internal_prototype

//  Anzahl der Schritte der Fortschrittsanzeige je Programm. Sie muss zu
//  den Aufrufen von p_showProgressMeter() passen: PEEK08 4, PEEK15 2 und
//  PEEK16 7 (je Marke der Vorlage PEEKSRC/PGM: RNM1 zwei, RNM2, TSCN,
//  FSCN und ISO je einen; ISO steht zweimal in der Vorlage).
dcl-c cNumPasses_PEEK08 4;
dcl-c cNumPasses_PEEK15 2;
dcl-c cNumPasses_PEEK16 7;

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek60;
  i_alwLC     like(bool_t) const;
  o_numPasses like(int4_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

//  Steuerung: Generieren Display File und RPG Programm
o_numPasses = cNumPasses_PEEK08;

//  1. Aufruf PEEK15 (generieren Display File)
o_numPasses = o_numPasses + cNumPasses_PEEK15;

//  2. Aufruf PEEK15 (generieren Display File, lower cases)
if (i_alwLC = bTrue);
  o_numPasses = o_numPasses + cNumPasses_PEEK15;
endif;

//  3. Aufruf PEEK16 (generieren RPG Programm)
o_numPasses = o_numPasses + cNumPasses_PEEK16;

return;

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

