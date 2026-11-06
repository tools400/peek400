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
dcl-ds rcvvar qualified;
  nbrretattr int(10) inz;
  offstotble int(10) inz;
  rcvvardta  char(256) inz;
end-ds;

dcl-ds netattr qualified;
  nme     char(10) inz;
  dtatype char(1) inz;
  infstat char(1) inz;
  dtalen  int(10) inz;
  dta     char(256) inz;
end-ds;

dcl-s x like(int4_t);
dcl-ds errcode likeds(errcode_t) inz;

//*******************************************************************
//           Main  Control block                                    *
//*******************************************************************
dcl-pi peek07;
  i_attr    like(attr_t) const;
  i_nomsg   like(bool_t) const;
  o_attrlen like(int4_t);
  o_attrtyp like(attrtype_t);
  o_alue    like(attrvalue_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

// - Meldung
if (i_nomsg = bFalse);
  p_sndstsmg('USR8106': ' ');
else;
//        keine Statusmeldung ausgeben
endif;

//  Fehler als Rückgabewert, nicht als Escape-Nachricht, z.B.
//  CPF1860 bei einem unbekannten Attribut
clear errcode;
errcode.bytprv = %size(errcode);
qwcrneta(rcvvar: %size(rcvvar): 1: i_attr: errcode);

if (errcode.bytavl = 0);
  exsr getattr;
else;
  o_attrlen = 0;
  o_attrtyp = '';
  o_alue = '';
endif;

return;

//====================================================*
//  GetAttr -  Abrufen der Attributwertes             *
//====================================================*

begsr getattr;

  x = rcvvar.offstotble + 1;

  if (x >= 1 and x <= 256);
    netattr = %subst(rcvvar: x);
    o_alue = netattr.dta;
    o_attrlen = netattr.dtalen;
    o_attrtyp = netattr.dtatype;
  else;
    o_attrlen = 0;
    o_attrtyp = '';
    o_alue = '';
  endif;

endsr;

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

