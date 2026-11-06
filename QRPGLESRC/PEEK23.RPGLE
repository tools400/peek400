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

dcl-s r_msgid char(4) inz(*blanks);
dcl-s r_key like(key_t) inz(*blanks);
dcl-s r_posf24 like(i_posf24) inz(*zeros);

dcl-s wrk_msgid like(msgid_t) inz;
dcl-s wrk_msgtxt like(msgdta_t) inz;
dcl-s wrk_key like(key_t) inz;
dcl-s wrk_sectn like(section_t) inz;
dcl-s data like(set0000_t) inz;

dcl-s lastkey like(key_t) inz;

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

/copy QCOPYLE,CEECNDHDLR

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek23;
  i_pgm       like(pgm_t) const;
  i_key       like(key_t) const;
  i_posf24    like(int4_t) const;
  o_fkeys     like(fkeydsp_t) dim(32);
  o_nbrofkeys like(int4_t);
  i_exclKeys  like(pgmcmd_t) dim(25) options(*nopass) const;
end-pi;

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

o_fkeys(*) = *blanks;
o_nbrofkeys = *zeros;

exsr getKeyMap;

return;

//============================================================*
//    GetKeyMap     Einlesen der F-Tastenbelegung             *
//============================================================*

begsr getKeyMap;

  x = 1;
  r_msgid = *blanks;
  r_key = *blanks;
  r_posf24 = i_posf24;

  //  Plätze für "F24=Weitere Tasten" nur reservieren, wenn der
  //  Befehl *MOREKEYS einer Taste zugeordnet ist.
  if (i_posf24 > 0);
    exsr chkMoreKeys;
    if (r_msgid = '');
      r_posf24 = 0;
    endif;
  endif;

  //  Hilfetaste
  if (i_key = '*HELP' or i_key = '*ALL');
    wrk_sectn = '*' + i_pgm;
    p_setllusr(wrk_sectn: '*HELP');
    lastkey = '*HELP';
    exsr readKeyMap;
  endif;

  //  Funktionstasten F1-F24
  if (i_key = '*ALL' or i_key <> '*HELP');
    wrk_sectn = '*' + i_pgm;
    if (i_key =  '*ALL' );
      p_setllusr(wrk_sectn: '*F01');
      lastkey = '*F24';
    else;
      p_setllusr(wrk_sectn: '*');
      lastkey = *all'Z';
    endif;

    exsr readKeyMap;

    //  *MOREKEYS
    if (r_msgid = '' or i_posf24 = 0);
    // Pech gehabt ...
    else;

      //  Anzahl Seiten berechnen
      y = o_nbrofkeys / i_posf24;
      x = y * i_posf24;
      if (o_nbrofkeys <> x);
        y = y + 1;
      endif;
      y = y * i_posf24;

      for x = i_posf24 by i_posF24 to y;
        //  Der Platz der letzten Seite kann hinter der Liste liegen
        if (x > %elem(o_fkeys));
          leave;
        endif;
        wrk_msgid = r_msgid;
        wrk_key = r_key;
        exsr fillfield;
      endfor;

    endif;
  endif;

endsr;

//============================================================*
//    ReadKeyMap    Einlesen der F-Tastenbelegung             *
//============================================================*

begsr readKeyMap;

  dow ('1');
    if (f_readeusr(wrk_sectn: wrk_key: data) = '1');
      leave;
    endif;

    if (wrk_key > lastkey);
      leave;
    endif;

    if (i_key <> '*ALL' and i_key <> data);
      iter;
    endif;

    if (%parms() >= %parmnum(i_exclKeys));
      if (f_iskeyexc(data: i_exclKeys) = bTrue);
        iter;
      endif;
    endif;

    wrk_msgid = f_mapCmdToMsg(data: wrk_sectn);
    if (data = '*MOREKEYS');
      r_msgid = wrk_msgid;
      r_key = wrk_key;
    else;
      exsr fillfield;
      x = x + 1;
      o_nbrofkeys = o_nbrofkeys + 1;
    endif;

    //  *MOREKEYS
    if (x = r_posf24 and x <= %elem(o_fkeys));
      //  ... Platz reservieren
      x = x + 1;
      o_nbrofkeys = o_nbrofkeys + 1;
      r_posf24 = r_posf24 + i_posf24;
    endif;

    if (x > %elem(o_fkeys));
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    ChkMoreKeys   Suchen der Taste für *MOREKEYS            *
//============================================================*

begsr chkMoreKeys;

  wrk_sectn = '*' + i_pgm;
  p_setllusr(wrk_sectn: '*F01');

  dow (f_readeusr(wrk_sectn: wrk_key: data) = '0');
    if (wrk_key > '*F24');
      leave;
    endif;

    if (data = '*MOREKEYS');
      if (%parms() >= %parmnum(i_exclKeys));
        if (f_iskeyexc(data: i_exclKeys) = bTrue);
          iter;
        endif;
      endif;
      r_msgid = f_mapCmdToMsg(data: wrk_sectn);
      r_key = wrk_key;
      leave;
    endif;
  enddo;

endsr;

//============================================================*
//    FillField                                               *
//============================================================*

begsr fillfield;

  if (wrk_msgid = '');
    wrk_msgtxt = *all'?';
  else;
    wrk_msgid = 'KEY' + %trim(wrk_msgid);
    wrk_msgtxt = f_msgtext(wrk_msgid: ' ');
  endif;

  select;
  when (wrk_key   = '*HELP');
    o_fkeys(x) = 'F1';
  when (%subst(wrk_key: 1: 3) = '*F0');
    //  '*F01' bis '*F09' -> 'F1' bis 'F9'
    o_fkeys(x) = 'F' + %subst(wrk_key: 4: 1);
  when (%subst(wrk_key: 1: 1) = '*');
    //  '*F10' bis '*F24' -> 'F10' bis 'F24', '*ENTER' -> 'ENTER'
    o_fkeys(x) = %subst(wrk_key: 2);
  other;
    //  Auswahl, z.B. 'A'
    o_fkeys(x) = wrk_key;
  endsl;

  o_fkeys(x) = %trimr(o_fkeys(x)) + '=' + %trim(wrk_msgtxt);

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

