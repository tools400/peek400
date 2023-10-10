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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,QUSROBJD
/COPY QCOPYLE,OBJD0400

/COPY QCOPYLE,CEECNDHDLR

/define internal_prototype
/COPY QCOPYLE,PPEEK09
/undefine internal_prototype

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-ds objd0400 likeds(objd0400_t) inz;
dcl-ds errcode likeds(errcode_t) inz;

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************

  dcl-pi peek09;
  i_qfile         const likeds(qobj_t);
  o_data          likeds(objd0400_t);
  o_msgid         like(msgid_t);
o_msgdta        like(msgdta_t);
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
    dcl-pi *N;
    i_condtoken     value likeds(cee_fc_t);
    i_pcommarea     int(10) value;
    o_action        int(10);
  o_newcondtoken  likeds(cee_fc_t);
  end-pi;

  dump;
o_action = cee_percolate;

end-proc;

