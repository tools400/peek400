**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK09                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 02.10.96  RADDATZ                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Ermitteln der Objektattribute                                *
//                                                               *
//===============================================================*
//                                                               *
//  INPUT-Parameter:                                             *
//  ================                                             *
//                                                               *
//  XQObj   - Qualifizierter Objektname                          *
//                                                               *
//  OUTPUT-Parameter:                                            *
//  =================                                            *
//                                                               *
//  XValue  - Objektinformationen im Format OBJD0400             *
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
/copy QCOPYLE,QUSROBJD
/copy QCOPYLE,OBJD0400

/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK09
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-ds objd0400 likeds(OBJD0400_t) inz;
dcl-ds errCode likeds(errCode_t) inz;

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************
dcl-pi peek09;
  i_qFile  likeds(qObj_t) const;
  o_data   likeds(OBJD0400_t);
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

p_sndStsMg('USR8107': i_qFile);

clear errCode;
errCode.bytPrv = %size(errCode);

qusrobjd(objd0400: %size(objd0400)
        : 'OBJD0400'
        : i_qFile: '*FILE'
        : errCode);

if (errCode.bytAvl = 0);
  o_data = objd0400;
  o_msgID = *blanks;
  o_msgDta = *blanks;
else;
  clear objd0400;
  o_data = objd0400;
  o_msgID = errCode.excID;
  o_msgDta = errCode.excDta;
endif;

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

