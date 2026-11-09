**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Ermitteln Netzwerkattribute                  *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK07                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 01.10.96  RADDATZ                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Ermitteln der Netzwerkattribute                              *
//                                                               *
//===============================================================*
//                                                               *
//  INPUT-Parameter:                                             *
//  ================                                             *
//                                                               *
//  XAttr   - Attributname                                       *
//          ALRBCKFP   (CHAR    16) Alert backup focal oint      *
//          ALRCTLD    (CHAR    10) Alert controller             *
//          ALRDFTFP   (CHAR    10) Alert focal point            *
//          ALRFTR     (CHAR    20) Alert filter                 *
//          ALRHLDCNT  (BINARY   4) Alert hold count             *
//          ALRLOGSTS  (CHAR     7) Alert logging status         *
//          ALRPRIFP   (CHAR    10) Alert primary focal point    *
//          ALRRQSFP   (CHAR    18) Alert focal point to request *
//          ALRSTS     (CHAR    10) Alert status                 *
//                                                               *
//          DDMACC     (CHAR    20) DDM request access           *
//          DFTCNNLST  (CHAR    10) PC default ISDN              *
//                                  connection list              *
//          DFTMODE    (CHAR     8) Default mode                 *
//          DFTNETTYPE (CHAR    10) ISDN network type            *
//          DTACPR     (BINARY   4) Data compression             *
//          DTACPRINM  (BINARY   4) Intermediate data            *
//                                  compression                  *
//          JOBACN     (CHAR    10) Job action                   *
//          LCLCPNAME  (CHAR     8) Local control point          *
//          LCLLOCNAME (CHAR     8) Local location name          *
//          LCLNETID   (CHAR     8) Local network ID             *
//          MAXINTSSN  (BINARY   4) Maximum sessions             *
//          MAXHOP     (BINARY   4) Maximum hop count            *
//          MSGQ       (CHAR    20) Message queue                *
//          NETSERVER  (CHAR    85) Server network ID            *
//          NODETYPE   (CHAR     8) APPN node type               *
//          OUTQ       (CHAR    20) Output queue                 *
//          PNDSYSNAME (CHAR     8) Pending system name          *
//          PCSACC     (CHAR    20) PC Support access            *
//          RAR        (BINARY   4) Addition resistance          *
//          SYSNAME    (CHAR     8) Current system name          *
//                                                               *
//  OUTPUT-Parameter:                                            *
//  =================                                            *
//                                                               *
//  XAttrLen- Länge des Wertes                                   *
//  XAttrTyp- Typ des Wertes                                     *
//  XValue  - Attributwert                                       *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/qwcrneta.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek07.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

//  declarations for QUSRTVUS
dcl-ds rcvVar qualified;
  nbrRetAttr int(10) inz;
  offsToTble int(10) inz;
  rcvVarDta  char(256) inz;
end-ds;

dcl-ds netAttr qualified;
  nme     char(10) inz;
  dtaType char(1) inz;
  infStat char(1) inz;
  dtaLen  int(10) inz;
  dta     char(256) inz;
end-ds;

dcl-s x like(int4_t);
dcl-ds errCode likeds(errCode_t) inz;

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************
dcl-pi peek07;
  i_attr    like(attr_t) const;
  i_noMsg   like(bool_t) const;
  o_attrLen like(int4_t);
  o_attrTyp like(attrType_t);
  o_alue    like(attrValue_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

// - Meldung
if (i_noMsg = bFalse);
  p_sndStsMg('USR8106': ' ');
else;
//        keine Statusmeldung ausgeben
endif;

//  Fehler als Rückgabewert, nicht als Escape-Nachricht, z.B.
//  CPF1860 bei einem unbekannten Attribut
clear errCode;
errCode.bytPrv = %size(errCode);
qwcrneta(rcvVar: %size(rcvVar): 1: i_attr: errCode);

if (errCode.bytAvl = 0);
  exsr getAttr;
else;
  o_attrLen = 0;
  o_attrTyp = '';
  o_alue = '';
endif;

return;

//====================================================*
//  getAttr -  Abrufen der Attributwertes             *
//====================================================*

begsr getAttr;

  x = rcvVar.offsToTble + 1;

  if (x >= 1 and x <= 256);
    netAttr = %subst(rcvVar: x);
    o_alue = netAttr.dta;
    o_attrLen = netAttr.dtaLen;
    o_attrTyp = netAttr.dtaType;
  else;
    o_attrLen = 0;
    o_attrTyp = '';
    o_alue = '';
  endif;

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

