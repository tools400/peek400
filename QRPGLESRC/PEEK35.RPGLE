**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK35                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 29.12.1997  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Prüfen Datensatz PEEKWRK für WRK0001 auf Plausibilität       *
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
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,SDS
/copy QCOPYLE,D_COLORATR
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,WRK0001

/copy QCOPYLE,USR8168
/copy QCOPYLE,USR8169
/copy QCOPYLE,USR8170
/copy QCOPYLE,USR8243

/define internal_prototype
/copy QCOPYLE,PPEEK35
/undefine internal_prototype

dcl-ds wrk0001 likeds(wrk0001_t) inz(*likeds);

dcl-s isError char(1) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek35;
  i_rcdNbr  like(rcdNbr_t) const;
  i_buffer  like(buffer_t) const;
  o_fldName like(fieldNme_t);
  o_msgID   like(msgId_t);
  o_msgDta  like(msgDta_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);
exsr first;

exsr prfB1;

return;

//============================================================*
//    prfB1         Prüfen Datensatz                          *
//============================================================*

begsr prfB1;

  isError = bFalse;

  //  Doppelte Folgenummern (SEQ) prüft PEEK34 nach allen Änderungen,
  //  damit zwei Felder ihre Nummern tauschen können.

  exsr prf21;           // = HIDDEN
  if (isError = bTrue);
    leavesr;
  endif;

  exsr prf22;           // = COLOR
  if (isError = bTrue);
    leavesr;
  endif;

  exsr prf23;           // = MARKCOL
  if (isError = bTrue);
    leavesr;
  endif;

  exsr prf24;           // = MAXSIZE
  if (isError = bTrue);
    leavesr;
  endif;

  exsr prf25;           // = EDTCDE
  if (isError = bTrue);
    leavesr;
  endif;

endsr;

//============================================================*
//    Prf21         Prüfen des Attributs: Sichtbar            *
//============================================================*

begsr prf21;

  dou ('1');

    select;
    when (wrk0001.wrk_hidden = bTrue);
    //  ist zulässig
    when (wrk0001.wrk_hidden = bFalse);
    //  ist zulässig
    other;
      isError = bTrue;
      o_msgID = 'USR8168';
      usr8168.var1 = wrk0001.wrk_hidden;
      o_msgDta = usr8168;
      leave;
    endsl;

  enddo;

  if (isError = bTrue);
    o_fldName = 'HIDDEN';
  endif;

endsr;

//============================================================*
//    Prf22         Prüfen des Attributs: Farbe               *
//============================================================*

begsr prf22;

  if (isError = bTrue);
    o_fldName = 'COLOR';
  endif;

endsr;

//============================================================*
//    Prf23         Prüfen des Attributs: Spaltenmarkierung   *
//============================================================*

begsr prf23;

  dou ('1');

    select;
    when (wrk0001.wrk_mrkCol = bTrue);
    //  ist zulässig
    when (wrk0001.wrk_mrkCol = bFalse);
    //  ist zulässig
    other;
      isError = bTrue;
      o_msgID = 'USR8169';
      usr8169.var1 = wrk0001.wrk_mrkCol;
      o_msgDta = usr8169;
      leave;
    endsl;

  enddo;

  if (isError = bTrue);
    o_fldName = 'MARKCOL';
  endif;

endsr;

//============================================================*
//    Prf24         Prüfen des Attributs: Max. Breite         *
//============================================================*

begsr prf24;

  dou ('1');

    if (wrk0001.wrk_maxSiz > 0);
    //  ist zulässig
    else;
      isError = bTrue;
      o_msgID = 'USR8170';
      usr8170.var1 = wrk0001.wrk_maxSiz;
      o_msgDta = usr8170;
      leave;
    endif;

  enddo;

  if (isError = bTrue);
    o_fldName = 'MAXSIZE';
  endif;

endsr;

//============================================================*
//    Prf25         Prüfen des Attributs: Editiercode         *
//============================================================*

begsr prf25;

  dou ('1');

    //  Edit-Codes wie in PEEK06
    select;
    when (wrk0001.wrk_edtCde = ' ');
    //  kein Edit-Code
    when (wrk0001.wrk_edtCde >= 'A' and wrk0001.wrk_edtCde <= 'D');
    when (wrk0001.wrk_edtCde >= 'J' and wrk0001.wrk_edtCde <= 'Q');
    when (wrk0001.wrk_edtCde >= 'X' and wrk0001.wrk_edtCde <= 'Z');
    when (wrk0001.wrk_edtCde >= '1' and wrk0001.wrk_edtCde <= '9');
    other;
      isError = bTrue;
      o_msgID = 'USR8243';
      usr8243.var1 = wrk0001.wrk_edtCde;
      o_msgDta = usr8243;
      leave;
    endsl;

  enddo;

  if (isError = bTrue);
    o_fldName = 'EDTCDE';
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  wrk0001 = i_buffer;

  // - Rückkehrcode
  o_fldName = '';
  o_msgID = '';
  o_msgDta = '';

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

