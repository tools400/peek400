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

dcl-ds objd0400 likeds(objd0400_t) inz;
dcl-ds errcode likeds(errcode_t) inz;

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************
dcl-pi peek09;
  i_qfile  likeds(qobj_t) const;
  o_data   likeds(objd0400_t);
  o_msgid  like(msgid_t);
  o_msgdta like(msgdta_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

p_sndstsmg('USR8107': i_qfile);

clear errcode;
errcode.bytprv = %size(errcode);

qusrobjd(objd0400: %size(objd0400)
        : 'OBJD0400'
        : i_qfile: '*FILE'
        : errcode);

if (errcode.bytavl = 0);
  o_data = objd0400;
  o_msgid = *blanks;
  o_msgdta = *blanks;
else;
  clear objd0400;
  o_data = objd0400;
  o_msgid = errcode.excid;
  o_msgdta = errcode.excdta;
endif;

return;

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

