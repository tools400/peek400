**free
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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,QWCRNETA
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK07
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

//  declarations for QUSRTVUS
dcl-ds RcvVar qualified;
  NbrRetAttr int(10) inz;
  OffsToTble int(10) inz;
  RcvVarDta  char(256) inz;
end-ds;

dcl-ds NetAttr qualified;
  Nme     char(10) inz;
  DtaType char(1) inz;
  InfStat char(1) inz;
  DtaLen  int(10) inz;
  Dta     char(256) inz;
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
qwcrneta(RcvVar: %size(RcvVar): 1: i_attr: errCode);

if (errCode.bytAvl = 0);
  exsr GetAttr;
else;
  o_attrLen = 0;
  o_attrTyp = '';
  o_alue = '';
endif;

return;

//====================================================*
//  GetAttr -  Abrufen der Attributwertes             *
//====================================================*

begsr GetAttr;

  x = RcvVar.OffsToTble + 1;

  if (x >= 1 and x <= 256);
    NetAttr = %subst(RcvVar: x);
    o_alue = NetAttr.Dta;
    o_attrLen = NetAttr.DtaLen;
    o_attrTyp = NetAttr.DtaType;
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

