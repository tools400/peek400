**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK13                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 07.10.96  RADDATZ                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Ermitteln der Teildateibeschreibung                          *
//                                                               *
//===============================================================*
//                                                               *
//  INPUT-Parameter:                                             *
//  ================                                             *
//                                                               *
//  XQFile  - Qualifizierter Dateiname                           *
//  XMbr    - Name der Teildatei                                 *
//                                                               *
//  OUTPUT-Parameter:                                            *
//  =================                                            *
//                                                               *
//  XValue  - Objektinformationen im Format MBRD0200             *
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
/copy QCOPYLE,QUSRMBRD
/copy QCOPYLE,MBRD0200

/define internal_prototype
/copy QCOPYLE,PPEEK13
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-ds mbrd0200 likeds(mbrd0200_t) inz;
dcl-ds errcode likeds(errcode_t) inz;

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************
dcl-pi peek13;
  i_qfile    likeds(qobj_t) const;
  i_mbr      like(mbr_t) const;
  o_mbrd0200 likeds(mbrd0200_t);
end-pi;

//---------------------------------------------------*

// - Meldung
p_sndstsmg('USR8109': i_qfile + i_mbr);

clear errcode;
errcode.bytprv = %size(errcode);

qusrmbrd(mbrd0200: %size(mbrd0200)
        : 'MBRD0200'
        : i_qfile: i_mbr: '0': errcode);

if (errcode.bytavl > 0);
  clear o_mbrd0200;
else;
  o_mbrd0200 = mbrd0200;
endif;

return;

