**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK10                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 02.10.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Dokumentation:                                               *
//                                                               *
//  Erstellen einer Liste aller verfügbaren Satzformate          *
//  einer Datei.                                                 *
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

dcl-f peekfmt usage(*update:*delete:*output) usropn prefix(f_);

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,RCDL0200
/COPY QCOPYLE,CEECNDHDLR
/COPY QCOPYLE,SDS

/COPY QCOPYLE,USR0002
/COPY QCOPYLE,USR8105

/define internal_prototype
/COPY QCOPYLE,PPEEK10
/undefine internal_prototype

/COPY QCOPYLE,PPEEK11
/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-ds rcdl0200 likeds(rcdl0200_t) inz;

dcl-s sortseq         like(f_sortseq) inz(0);

dcl-s peek11_name     like(pgmcalln_t) inz;

dcl-s nbroffmt        like(int4_t) inz;
dcl-s fmtcnt          like(int4_t) inz;
dcl-s rc              like(int4_t) inz;

dcl-s isinzsr         like(bool_t) inz(bfalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek10;
  i_qfile         const likeds(qobj_t);
  o_msgid         like(msgid_t);
  o_msgdta        like(msgdta_t);
end-pi;
// --------------------------------------------------------------------
// Stand Alone Fields - TOP
// --------------------------------------------------------------------
dcl-s do_x1           packed(7);
// --------------------------------------------------------------------
// Stand Alone Fields - BOTTOM
// --------------------------------------------------------------------

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

//  create list of record formats
peek11(i_qfile:
      '*CREATE': nbroffmt: rcdl0200);

sortseq = *zeros;
//  read each entry
for fmtcnt = 1 to nbroffmt;

  peek11(i_qfile: '*READ': rc: rcdl0200);

  clear fpeekfmt;

  f_format = 'RCDL0200';
  f_fmt = rcdl0200;
  sortseq = sortseq + 10;
  f_sortseq = sortseq;
  f_fmtnbr = fmtcnt;
  write fpeekfmt;

endfor;

//  delete list
//**                MOVEL(P)  '*DELETE'     YFUNK
//**                CALL      PEEK11
//**                PARM                    YQFILE
//**                PARM                    YFUNK
//**                PARM                    YANZ
//**                PARM                    YLIST

if (nbroffmt = *zeros);
  o_msgid = 'USR0002';
  usr0002.var1 = i_qfile.name;
  usr0002.var2 = i_qfile.lib;
  o_msgdta = usr0002;
else;
  o_msgid = *blanks;
  o_msgdta = *blanks;
endif;

*inlr = '1';

//====================================================*
//  First  --  Initialize program                     *
//====================================================*

begsr first;

  // - Meldung
  p_sndstsmg('USR8105': i_qfile);

  // - Los gehts'
  o_msgid = *blanks;
  o_msgdta = *blanks;

  setll 1 fpeekfmt;

  for do_x1 = 1 to *hival;
    read fpeekfmt;
    *in11 = %eof;
    if (*in11 = *on);
      leave;
    endif;

    delete fpeekfmt;
  endfor;

  nbroffmt = *zeros;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isinzsr = btrue);
    leavesr;
  endif;

  isinzsr = btrue;

  peek11_name = f_pgmcalln('PEEK11');

  open peekfmt;

endsr;

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

