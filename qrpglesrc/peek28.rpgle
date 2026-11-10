**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Ermitteln Systemwerte                        *
      //%EMETADATA                                                     *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/qwcrsval.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek28.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-ds yRcvVar len(128) inz;
  rcvNbrRet int(10);
  rcvOffset int(10);
  rcvData   char(120);
end-ds;

dcl-ds ySystemVal len(128) inz;
  systemVal  char(10);
  typeOfData char(1);
  infStatus  char(1);
  lenOfData  int(10);
  sysValData char(112);
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

qwcrsval(yRcvVar: %size(yRcvVar): 1
        : i_attr: errCode);

if (errCode.bytAvl = 0);
  exsr getAttr;
else;
  o_attrLen = 0;
  o_attrType = '';
  o_attrValue = '';
endif;

return;

//====================================================*
//  getAttr -  Abrufen der Attributwertes             *
//====================================================*

begsr getAttr;

  x = rcvOffset + 1;
  ySystemVal = %subst(yRcvVar: x);

  o_attrLen = lenOfData;
  o_attrType = typeOfData;

  x = 1;
  o_attrValue =
   %subst(sysValData: x: o_attrLen);

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

