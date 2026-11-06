**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK19                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 27.10.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Erstellen externen Aufsetzschlüssel                          *
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

dcl-f peekfldl2 keyed usropn rename(fpeekfld: fpeekfldl2) prefix(f2) infds(peek_l2_ds);

dcl-ds peek_l2_ds likeds(infds_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,SDS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK19
/undefine internal_prototype

/copy QCOPYLE,PPEEK18
/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s ybuffer like(rcdbuf_t) inz;
dcl-s youtbuffer like(rcdbuf_t) inz;
dcl-s youtbuffln like(int4_t) inz;
dcl-s ymsgid like(msgid_t) inz;
dcl-s ymsgdta like(msgdta_t) inz;

dcl-s x like(int4_t) inz;
dcl-s y like(int4_t) inz;
dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-s peek18_name like(pgmcalln_t) inz;

dcl-s isinzsr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek19;
  i_rcdbuffer like(rcdbuf_t) const;
  o_keyval    like(keybuf_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pi;

dcl-s do_x1 packed(7);

dcl-ds f2key_l2 likerec(fpeekfldl2: *key);

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

o_keyval = *blanks;
x = 1;

clear f2key_l2;
f2key_l2.f2kseq = 1;
setll %kds(f2key_l2) fpeekfldl2;

for do_x1 = 1 to *hival;
  read fpeekfldl2;
  if (%eof());
    leave;
  endif;

  fldl0100 = f2ffd;

  f_rtvfld(ybuffer   :
          i_rcdbuffer:
          fldl0100  :
          bTrue     );

  peek18(fldl0100: f2format: ybuffer
        : '*EXTERN': '*CURRENT'
        : youtbuffer: youtbuffln
        : ymsgid: ymsgdta);

  //  Wert ...
  for y = 1 to youtbuffln;
    %subst(o_keyval: x: 1) =
      %subst(youtbuffer: y: 1);
    x = x + 1;
    if (x > KEY_BUFF_LEN);
      leave;
    endif;
  endfor;

  if (x > KEY_BUFF_LEN);
    leave;
  endif;

endfor;

return;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  o_msgid = *blanks;
  o_msgdta = *blanks;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isinzsr = bTrue);
    leavesr;
  endif;

  isinzsr = bTrue;

  peek18_name = f_pgmcalln('PEEK18');

  open peekfldl2;

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

