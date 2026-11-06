**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK23                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 29.10.97  Raddatz                                 *
//  geändert : 27.04.99  2.1.0                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Einlesen der F-Tastenbelegung                                *
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
/copy QCOPYLE,SDS

/define internal_prototype
/copy QCOPYLE,PPEEK23
/undefine internal_prototype

dcl-s x like(int4_t) inz;
dcl-s y like(int4_t) inz;

dcl-s r_msgID char(4) inz(*blanks);
dcl-s R_Key like(KEY_t) inz(*blanks);
dcl-s R_PosF24 like(i_posF24) inz(*zeros);

dcl-s wrk_MsgID like(msgId_t) inz;
dcl-s wrk_MsgTxt like(msgDta_t) inz;
dcl-s Wrk_Key like(KEY_t) inz;
dcl-s Wrk_Sectn like(SECTION_t) inz;
dcl-s data like(SET0000_t) inz;

dcl-s lastKey like(KEY_t) inz;

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

/copy QCOPYLE,CEECNDHDLR

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek23;
  i_pgm       like(pgm_t) const;
  i_key       like(KEY_t) const;
  i_posF24    like(int4_t) const;
  o_FKeys     like(fKeyDsp_t) dim(32);
  o_nbrOfKeys like(int4_t);
  i_exclKeys  like(pgmCmd_t) dim(25) options(*nopass) const;
end-pi;

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

o_FKeys(*) = *blanks;
o_nbrOfKeys = *zeros;

exsr getKeyMap;

return;

//============================================================*
//    GetKeyMap     Einlesen der F-Tastenbelegung             *
//============================================================*

begsr getKeyMap;

  x = 1;
  r_msgID = *blanks;
  R_Key = *blanks;
  R_PosF24 = i_posF24;

  //  Plätze für "F24=Weitere Tasten" nur reservieren, wenn der
  //  Befehl *MOREKEYS einer Taste zugeordnet ist.
  if (i_posF24 > 0);
    exsr chkMoreKeys;
    if (r_msgID = '');
      R_PosF24 = 0;
    endif;
  endif;

  //  Hilfetaste
  if (i_key = '*HELP' or i_key = '*ALL');
    Wrk_Sectn = '*' + i_pgm;
    p_setllUsr(Wrk_Sectn: '*HELP');
    lastKey = '*HELP';
    exsr readKeyMap;
  endif;

  //  Funktionstasten F1-F24
  if (i_key = '*ALL' or i_key <> '*HELP');
    Wrk_Sectn = '*' + i_pgm;
    if (i_key =  '*ALL' );
      p_setllUsr(Wrk_Sectn: '*F01');
      lastKey = '*F24';
    else;
      p_setllUsr(Wrk_Sectn: '*');
      lastKey = *all'Z';
    endif;

    exsr readKeyMap;

    //  *MOREKEYS
    if (r_msgID = '' or i_posF24 = 0);
    // Pech gehabt ...
    else;

      //  Anzahl Seiten berechnen
      y = o_nbrOfKeys / i_posF24;
      x = y * i_posF24;
      if (o_nbrOfKeys <> x);
        y = y + 1;
      endif;
      y = y * i_posF24;

      for x = i_posF24 by i_posF24 to y;
        //  Der Platz der letzten Seite kann hinter der Liste liegen
        if (x > %elem(o_FKeys));
          leave;
        endif;
        wrk_MsgID = r_msgID;
        Wrk_Key = R_Key;
        exsr FillField;
      endfor;

    endif;
  endif;

endsr;

//============================================================*
//    ReadKeyMap    Einlesen der F-Tastenbelegung             *
//============================================================*

begsr readKeyMap;

  dow ('1');
    if (f_readeUsr(Wrk_Sectn: Wrk_Key: data) = '1');
      leave;
    endif;

    if (Wrk_Key > lastKey);
      leave;
    endif;

    if (i_key <> '*ALL' and i_key <> data);
      iter;
    endif;

    if (%parms() >= %parmnum(i_exclKeys));
      if (f_isKeyExc(data: i_exclKeys) = bTrue);
        iter;
      endif;
    endif;

    wrk_MsgID = f_mapCmdToMsg(data: Wrk_Sectn);
    if (data = '*MOREKEYS');
      r_msgID = wrk_MsgID;
      R_Key = Wrk_Key;
    else;
      exsr FillField;
      x = x + 1;
      o_nbrOfKeys = o_nbrOfKeys + 1;
    endif;

    //  *MOREKEYS
    if (x = R_PosF24 and x <= %elem(o_FKeys));
      //  ... Platz reservieren
      x = x + 1;
      o_nbrOfKeys = o_nbrOfKeys + 1;
      R_PosF24 = R_PosF24 + i_posF24;
    endif;

    if (x > %elem(o_FKeys));
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    ChkMoreKeys   Suchen der Taste für *MOREKEYS            *
//============================================================*

begsr chkMoreKeys;

  Wrk_Sectn = '*' + i_pgm;
  p_setllUsr(Wrk_Sectn: '*F01');

  dow (f_readeUsr(Wrk_Sectn: Wrk_Key: data) = '0');
    if (Wrk_Key > '*F24');
      leave;
    endif;

    if (data = '*MOREKEYS');
      if (%parms() >= %parmnum(i_exclKeys));
        if (f_isKeyExc(data: i_exclKeys) = bTrue);
          iter;
        endif;
      endif;
      r_msgID = f_mapCmdToMsg(data: Wrk_Sectn);
      R_Key = Wrk_Key;
      leave;
    endif;
  enddo;

endsr;

//============================================================*
//    FillField                                               *
//============================================================*

begsr FillField;

  if (wrk_MsgID = '');
    wrk_MsgTxt = *all'?';
  else;
    wrk_MsgID = 'KEY' + %trim(wrk_MsgID);
    wrk_MsgTxt = f_msgText(wrk_MsgID: ' ');
  endif;

  select;
  when (Wrk_Key   = '*HELP');
    o_FKeys(x) = 'F1';
  when (%subst(Wrk_Key: 1: 3) = '*F0');
    //  '*F01' bis '*F09' -> 'F1' bis 'F9'
    o_FKeys(x) = 'F' + %subst(Wrk_Key: 4: 1);
  when (%subst(Wrk_Key: 1: 1) = '*');
    //  '*F10' bis '*F24' -> 'F10' bis 'F24', '*ENTER' -> 'ENTER'
    o_FKeys(x) = %subst(Wrk_Key: 2);
  other;
    //  Auswahl, z.B. 'A'
    o_FKeys(x) = Wrk_Key;
  endsl;

  o_FKeys(x) = %trimr(o_FKeys(x)) + '=' + %trim(wrk_MsgTxt);

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

