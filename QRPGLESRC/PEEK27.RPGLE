**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK27                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 03.11.97  Raddatz                                 *
//  geändert : 27.04.99  2.1.0                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Einlesen der Einzelauswahlen                                 *
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
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK27
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s x like(int4_t) inz;
dcl-s y like(int4_t) inz;
dcl-s z like(int4_t) inz;

dcl-s wrk_MsgID like(msgId_t) inz;
dcl-s wrk_MsgTxt like(msgDta_t) inz;
dcl-s Wrk_Key like(KEY_t) inz;
dcl-s Wrk_Sectn like(SECTION_t) inz;
dcl-s data like(SET0000_t) inz;

//  Breite der Auswahlzeile und Ausschlüsse des Aufrufers
dcl-s width like(int4_t) inz(63);
dcl-s isExclKeys like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek27;
  i_pgm        like(pgm_t) const;
  o_choices    like(choice_t) dim(32);
  o_numChoices like(int4_t);
  i_exclKeys   like(pgmCmd_t) dim(25) options(*nopass: *omit) const;
  i_width      like(int4_t) options(*nopass) const;
end-pi;

dcl-s do_x1 packed(7);
dcl-s do_x2 packed(7);

//----------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

o_choices(*) = *blanks;
o_numChoices = *zeros;

isExclKeys = bFalse;
if (%parms() >= %parmnum(i_exclKeys));
  if (%addr(i_exclKeys) <> *null);
    isExclKeys = bTrue;
  endif;
endif;

width = 63;
if (%parms() >= %parmnum(i_width));
  if (i_width > 0 and i_width <= %len(o_choices(1)));
    width = i_width;
  endif;
endif;

exsr getKeyMap;

*inlr = '1';

//============================================================*
//    GetKeyMap     Einlesen der F-Tastenbelegung             *
//============================================================*

begsr getKeyMap;

  x = 1;
  o_numChoices = 1;

  //  Numerische-Auswahlen ...
  Wrk_Sectn = '*' + %trim(i_pgm);
  Wrk_Key = *blanks;
  Wrk_Key = '0' + Wrk_Key;
  p_setllUsr(Wrk_Sectn: Wrk_Key);

  for do_x1 = 1 to *hival;
    if (f_readeUsr(Wrk_Sectn: Wrk_Key: data)= '1');
      leave;
    endif;

    //  Überprüfen Ausschlüsse
    if (isExclKeys);
      if (f_isKeyExc(data: i_exclKeys) = bTrue);
        iter;
      endif;
    endif;

    exsr BuildStr;
    if (x > 32);
      //          Fertig, Tabelle ist voll
      leave;
    endif;

  endfor;

  //  String-Auswahlen ...
  Wrk_Sectn = '*' + %trim(i_pgm);
  Wrk_Key = *allx'FF';
  Wrk_Key = '*' + Wrk_Key;
  p_setllUsr(Wrk_Sectn: Wrk_Key);

  for do_x2 = 1 to *hival;
    if (f_readeUsr(Wrk_Sectn: Wrk_Key: data)= '1');
      leave;
    endif;

    //  Numerische-Auswahlen, siehe oben ...
    if (Wrk_Key > '0');
      leave;
    endif;

    //  Überprüfen Ausschlüsse
    if (isExclKeys);
      if (f_isKeyExc(data: i_exclKeys) = bTrue);
        iter;
      endif;
    endif;

    exsr BuildStr;
    if (x > 32);
      //          Fertig, Tabelle ist voll
      leave;
    endif;

  endfor;

endsr;

//============================================================*
//    BuildStr      String zusammenbauen                      *
//============================================================*

begsr BuildStr;

  wrk_MsgID = f_mapCmdToMsg(data: Wrk_Sectn);
  if (wrk_MsgID <> '');
    wrk_MsgID = 'KEY' + %trim(wrk_MsgID);
    wrk_MsgTxt = f_msgText(wrk_MsgID: ' ');
  else;
    //  Befehl ohne Nachrichtentext
    wrk_MsgTxt = '???';
  endif;

  //  Stringlänge
  z = %checkr(' ': wrk_MsgTxt);
  //  Für Auswahl und "="-Zeichen
  z = z + 3;
  //  Für Trennleerraum ...
  if (o_choices(x) <> *blanks);
    z = z + 2;
  endif;

  //  Freie Länge
  y = %checkr(' ': o_choices(x));
  y = width - y;
  if (y < z);
    x = x + 1;
    o_numChoices = o_numChoices + 1;
  endif;

  if (x > 32);
  //               Nix tun, Tabelle ist voll
  else;
    if (o_choices(x) = *blanks);
      o_choices(x) = %trimr(Wrk_Key);
    else;
      o_choices(x) = %trimr(o_choices(x)) +
                 '  ' + %trimr(Wrk_Key);
    endif;
    o_choices(x) = %trimr(o_choices(x)) +
               '=' + %trim(wrk_MsgTxt);
  endif;

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

