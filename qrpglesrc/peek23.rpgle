**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Einlesen der Funktionstastenbelegung         *
      //%EMETADATA                                                     *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek23.rpgleinc'
/undefine internal_prototype

dcl-s x like(int4_t) inz;
dcl-s y like(int4_t) inz;

dcl-s r_msgID char(4) inz(*blanks);
dcl-s r_key like(key_t) inz(*blanks);
dcl-s r_posF24 like(i_posF24) inz(*zeros);

dcl-s wrk_msgID like(msgId_t) inz;
dcl-s wrk_msgTxt like(msgDta_t) inz;
dcl-s wrk_key like(key_t) inz;
dcl-s wrk_sectn like(section_t) inz;
dcl-s data like(set0000_t) inz;

dcl-s lastKey like(key_t) inz;

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

/copy 'qcopyle/ceecndhdlr.rpgleinc'

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek23;
  i_pgm       like(pgm_t) const;
  i_key       like(key_t) const;
  i_posF24    like(int4_t) const;
  o_fKeys     like(fKeyDsp_t) dim(32);
  o_nbrOfKeys like(int4_t);
  i_exclKeys  like(pgmCmd_t) dim(25) options(*nopass) const;
end-pi;

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

o_fKeys(*) = *blanks;
o_nbrOfKeys = *zeros;

exsr getKeyMap;

return;

//============================================================*
//    GetKeyMap     Einlesen der F-Tastenbelegung             *
//============================================================*

begsr getKeyMap;

  x = 1;
  r_msgID = *blanks;
  r_key = *blanks;
  r_posF24 = i_posF24;

  //  Plätze für "F24=Weitere Tasten" nur reservieren, wenn der
  //  Befehl *MOREKEYS einer Taste zugeordnet ist.
  if (i_posF24 > 0);
    exsr chkMoreKeys;
    if (r_msgID = '');
      r_posF24 = 0;
    endif;
  endif;

  //  Hilfetaste
  if (i_key = '*HELP' or i_key = '*ALL');
    wrk_sectn = '*' + i_pgm;
    p_setllUsr(wrk_sectn: '*HELP');
    lastKey = '*HELP';
    exsr readKeyMap;
  endif;

  //  Funktionstasten F1-F24
  if (i_key = '*ALL' or i_key <> '*HELP');
    wrk_sectn = '*' + i_pgm;
    if (i_key =  '*ALL' );
      p_setllUsr(wrk_sectn: '*F01');
      lastKey = '*F24';
    else;
      p_setllUsr(wrk_sectn: '*');
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
        if (x > %elem(o_fKeys));
          leave;
        endif;
        wrk_msgID = r_msgID;
        wrk_key = r_key;
        exsr fillField;
      endfor;

    endif;
  endif;

endsr;

//============================================================*
//    ReadKeyMap    Einlesen der F-Tastenbelegung             *
//============================================================*

begsr readKeyMap;

  dow ('1');
    if (f_readeUsr(wrk_sectn: wrk_key: data) = '1');
      leave;
    endif;

    if (wrk_key > lastKey);
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

    wrk_msgID = f_mapCmdToMsg(data: wrk_sectn);
    if (data = '*MOREKEYS');
      r_msgID = wrk_msgID;
      r_key = wrk_key;
    else;
      exsr fillField;
      x = x + 1;
      o_nbrOfKeys = o_nbrOfKeys + 1;
    endif;

    //  *MOREKEYS
    if (x = r_posF24 and x <= %elem(o_fKeys));
      //  ... Platz reservieren
      x = x + 1;
      o_nbrOfKeys = o_nbrOfKeys + 1;
      r_posF24 = r_posF24 + i_posF24;
    endif;

    if (x > %elem(o_fKeys));
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    ChkMoreKeys   Suchen der Taste für *MOREKEYS            *
//============================================================*

begsr chkMoreKeys;

  wrk_sectn = '*' + i_pgm;
  p_setllUsr(wrk_sectn: '*F01');

  dow (f_readeUsr(wrk_sectn: wrk_key: data) = '0');
    if (wrk_key > '*F24');
      leave;
    endif;

    if (data = '*MOREKEYS');
      if (%parms() >= %parmnum(i_exclKeys));
        if (f_isKeyExc(data: i_exclKeys) = bTrue);
          iter;
        endif;
      endif;
      r_msgID = f_mapCmdToMsg(data: wrk_sectn);
      r_key = wrk_key;
      leave;
    endif;
  enddo;

endsr;

//============================================================*
//    fillField                                               *
//============================================================*

begsr fillField;

  if (wrk_msgID = '');
    wrk_msgTxt = *all'?';
  else;
    wrk_msgID = 'KEY' + %trim(wrk_msgID);
    wrk_msgTxt = f_msgText(wrk_msgID: ' ');
  endif;

  select;
  when (wrk_key   = '*HELP');
    o_fKeys(x) = 'F1';
  when (%subst(wrk_key: 1: 3) = '*F0');
    //  '*F01' bis '*F09' -> 'F1' bis 'F9'
    o_fKeys(x) = 'F' + %subst(wrk_key: 4: 1);
  when (%subst(wrk_key: 1: 1) = '*');
    //  '*F10' bis '*F24' -> 'F10' bis 'F24', '*ENTER' -> 'ENTER'
    o_fKeys(x) = %subst(wrk_key: 2);
  other;
    //  Auswahl, z.B. 'A'
    o_fKeys(x) = wrk_key;
  endsl;

  o_fKeys(x) = %trimr(o_fKeys(x)) + '=' + %trim(wrk_msgTxt);

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

