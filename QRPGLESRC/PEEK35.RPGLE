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
  o_fldname like(fieldnme_t);
  o_msgid   like(msgid_t);
  o_msgdta  like(msgdta_t);
end-pi;

//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);
exsr first;

exsr prfb1;

return;

//============================================================*
//    PrfB1         Prüfen Datensatz                          *
//============================================================*

begsr prfb1;

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
      o_msgid = 'USR8168';
      usr8168.var1 = wrk0001.wrk_hidden;
      o_msgdta = usr8168;
      leave;
    endsl;

  enddo;

  if (isError = bTrue);
    o_fldname = 'HIDDEN';
  endif;

endsr;

//============================================================*
//    Prf22         Prüfen des Attributs: Farbe               *
//============================================================*

begsr prf22;

  if (isError = bTrue);
    o_fldname = 'COLOR';
  endif;

endsr;

//============================================================*
//    Prf23         Prüfen des Attributs: Spaltenmarkierung   *
//============================================================*

begsr prf23;

  dou ('1');

    select;
    when (wrk0001.wrk_mrkcol = bTrue);
    //  ist zulässig
    when (wrk0001.wrk_mrkcol = bFalse);
    //  ist zulässig
    other;
      isError = bTrue;
      o_msgid = 'USR8169';
      usr8169.var1 = wrk0001.wrk_mrkcol;
      o_msgdta = usr8169;
      leave;
    endsl;

  enddo;

  if (isError = bTrue);
    o_fldname = 'MARKCOL';
  endif;

endsr;

//============================================================*
//    Prf24         Prüfen des Attributs: Max. Breite         *
//============================================================*

begsr prf24;

  dou ('1');

    if (wrk0001.wrk_maxsiz > 0);
    //  ist zulässig
    else;
      isError = bTrue;
      o_msgid = 'USR8170';
      usr8170.var1 = wrk0001.wrk_maxsiz;
      o_msgdta = usr8170;
      leave;
    endif;

  enddo;

  if (isError = bTrue);
    o_fldname = 'MAXSIZE';
  endif;

endsr;

//============================================================*
//    Prf25         Prüfen des Attributs: Editiercode         *
//============================================================*

begsr prf25;

  dou ('1');

    //  Edit-Codes wie in PEEK06
    select;
    when (wrk0001.wrk_edtcde = ' ');
    //  kein Edit-Code
    when (wrk0001.wrk_edtcde >= 'A' and wrk0001.wrk_edtcde <= 'D');
    when (wrk0001.wrk_edtcde >= 'J' and wrk0001.wrk_edtcde <= 'Q');
    when (wrk0001.wrk_edtcde >= 'X' and wrk0001.wrk_edtcde <= 'Z');
    when (wrk0001.wrk_edtcde >= '1' and wrk0001.wrk_edtcde <= '9');
    other;
      isError = bTrue;
      o_msgid = 'USR8243';
      usr8243.var1 = wrk0001.wrk_edtcde;
      o_msgdta = usr8243;
      leave;
    endsl;

  enddo;

  if (isError = bTrue);
    o_fldname = 'EDTCDE';
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  wrk0001 = i_buffer;

  // - Rückkehrcode
  o_fldname = '';
  o_msgid = '';
  o_msgdta = '';

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

