**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK32                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 26.11.97  Raddatz                                 *
//  geändert : 27.04.99  2.1.0                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Konvertieren nicht darstellbarer Zeichen                     *
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
/copy QCOPYLE,SDS
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,SET0006

/copy QCOPYLE,USR8163

/define internal_prototype
/copy QCOPYLE,PPEEK32
/undefine internal_prototype

/copy QCOPYLE,PPEEK53

dcl-ds set0006 likeds(set0006_t) inz;

dcl-s x like(int4_t);
dcl-s pBuffer pointer;
dcl-s char char(1) based(pChar);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek32;
  io_buffer likeds(rcdBuffer_t);
  i_buffLen like(int4_t) const;
  i_ccsid   like(int4_t) const;
  o_msgID   like(msgId_t);
  o_msgDta  like(msgDta_t);
end-pi;
//----------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

o_msgID = '';
o_msgDta = '';

//    Zeichen mit einer DOUBLE BYTE CCSID, wie 1200 oder 13488
//    können zur Zeit nicht geprüft werden.
if (i_ccsid <> 0);
  exsr check_ucs2;
else;
  exsr check_sbcs;
endif;

return;

//============================================================*
//    Prüfen UCS2 Zeichenkette auf ungültige Zeichen          *
//============================================================*

begsr check_ucs2;

//      DBCS Zeichen lassen sich zur Zeit nicht prüfen.

endsr;

//============================================================*
//    Prüfen SBCS Zeichenkette auf ungültige Zeichen          *
//============================================================*

begsr check_sbcs;

  pBuffer = %addr(io_buffer);

  for x = 1 to i_buffLen;
    pChar = pBuffer + (x-1);
    if (char < x'40' or char = x'FF');
      char = set0006.set_cvtc;
      o_msgID = 'USR8163';
      usr8163.var1 = set0006.set_cvtc;
      o_msgDta = usr8163;
    else;
    // Zeichen beibehalten
    endif;
  endfor;

endsr;

//============================================================*
//    getUsrSetg    Ermitteln der Standardsprache             *
//============================================================*

begsr getUsrSetg;

  set0006 = f_getUsrSg('*CVTCHR');

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  exsr getUsrSetg;

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

