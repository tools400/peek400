**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Ermitteln Teildateibeschreibung              *
      //%EMETADATA                                                     *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/qusrmbrd.rpgleinc'
/copy 'qcopyle/mbrd0200.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek13.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-ds mbrd0200 likeds(mbrd0200_t) inz;
dcl-ds errCode likeds(errCode_t) inz;

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************
dcl-pi peek13;
  i_qFile    likeds(qObj_t) const;
  i_mbr      like(mbr_t) const;
  o_mbrd0200 likeds(mbrd0200_t);
end-pi;

//---------------------------------------------------*

// - Meldung
p_sndStsMg('USR8109': i_qFile + i_mbr);

clear errCode;
errCode.bytPrv = %size(errCode);

qusrmbrd(mbrd0200: %size(mbrd0200)
        : 'MBRD0200'
        : i_qFile: i_mbr: '0': errCode);

if (errCode.bytAvl > 0);
  clear o_mbrd0200;
else;
  o_mbrd0200 = mbrd0200;
endif;

return;

