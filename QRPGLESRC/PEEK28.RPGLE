**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK28                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 03.11.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Ermitteln Systemwerte                                        *
//                                                               *
//===============================================================*
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
/copy QCOPYLE,QWCRSVAL
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK28
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-ds YRcvVar len(128) inz;
  RcvNbrRet int(10);
  RcvOffset int(10);
  RcvData   char(120);
end-ds;

dcl-ds YSystemVal len(128) inz;
  SystemVal  char(10);
  TypeOfData char(1);
  infStatus  char(1);
  LenOfData  int(10);
  SysValData char(112);
end-ds;

dcl-s x like(int4_t) inz;
dcl-ds errCode likeds(errCode_t) inz;

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek28;
  i_attr      like(attr_t) const;
  i_noMsg     like(bool_t) const;
  o_attrLen   like(int4_t);
  o_attrType  like(attrType_t);
  o_attrValue like(attrValue_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

// - Meldung
if (i_noMsg = bTrue);
  p_sndStsMg('USR8157': ' ');
else;
//        keine Statusmeldung ausgeben
endif;

clear errCode;
errCode.bytPrv = %size(errCode);

qwcrsval(YRcvVar: %size(YRcvVar): 1
        : i_attr: errCode);

if (errCode.bytAvl = 0);
  exsr GetAttr;
else;
  o_attrLen = 0;
  o_attrType = '';
  o_attrValue = '';
endif;

return;

//====================================================*
//  GetAttr -  Abrufen der Attributwertes             *
//====================================================*

begsr GetAttr;

  x = RcvOffset + 1;
  YSystemVal = %subst(YRcvVar: x);

  o_attrLen = LenOfData;
  o_attrType = TypeOfData;

  x = 1;
  o_attrValue =
   %subst(SysValData: x: o_attrLen);

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

