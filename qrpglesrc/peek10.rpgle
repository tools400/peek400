**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Übertragen Satzformat in DB2/400-Format      *
      //%EMETADATA                                                     *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peekFmt usage(*update: *delete: *output) usropn prefix(f_);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/rcdl0200.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'

/copy 'qcopyle/usr0002.rpgleinc'
/copy 'qcopyle/usr8105.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek10.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek11.rpgleinc'
/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-ds rcdl0200 likeds(rcdl0200_t) inz;

dcl-s sortSeq like(f_sortSeq) inz(0);

dcl-s peek11_name like(pgmCallN_t) inz;

dcl-s nbrOfFmt like(int4_t) inz;
dcl-s fmtCnt like(int4_t) inz;
dcl-s rc like(int4_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek10;
  i_qFile  likeds(qObj_t) const;
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pi;
// --------------------------------------------------------------------
// Stand Alone Fields - TOP
// --------------------------------------------------------------------
dcl-s do_x1 packed(7);
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
peek11(i_qFile:
      '*CREATE': nbrOfFmt: rcdl0200);

sortSeq = *zeros;
//  read each entry
for fmtCnt = 1 to nbrOfFmt;

  peek11(i_qFile: '*READ': rc: rcdl0200);

  clear fpeekfmt;

  f_format = 'RCDL0200';
  f_fmt = rcdl0200;
  sortSeq = sortSeq + 10;
  f_sortSeq = sortSeq;
  f_fmtNbr = fmtCnt;
  write fpeekfmt;

endfor;

//  delete list
//**                MOVEL(P)  '*DELETE'     YFUNK
//**                CALL      PEEK11
//**                PARM                    YQFILE
//**                PARM                    YFUNK
//**                PARM                    YANZ
//**                PARM                    YLIST

if (nbrOfFmt = *zeros);
  o_msgID = 'USR0002';
  usr0002.var1 = i_qFile.name;
  usr0002.var2 = i_qFile.lib;
  o_msgDta = usr0002;
else;
  o_msgID = *blanks;
  o_msgDta = *blanks;
endif;

*inlr = '1';

//====================================================*
//  First  --  Initialize program                     *
//====================================================*

begsr first;

  // - Meldung
  p_sndStsMg('USR8105': i_qFile);

  // - Los gehts'
  o_msgID = *blanks;
  o_msgDta = *blanks;

  setll 1 fpeekfmt;

  for do_x1 = 1 to *hival;
    read fpeekfmt;
    *in11 = %eof;
    if (*in11 = *on);
      leave;
    endif;

    delete fpeekfmt;
  endfor;

  nbrOfFmt = *zeros;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  peek11_name = f_pgmCallN('PEEK11');

  open peekFmt;

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

