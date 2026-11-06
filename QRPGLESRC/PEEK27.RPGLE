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

dcl-s wrk_msgid like(msgid_t) inz;
dcl-s wrk_msgtxt like(msgdta_t) inz;
dcl-s wrk_key like(key_t) inz;
dcl-s wrk_sectn like(section_t) inz;
dcl-s data like(set0000_t) inz;

//  Breite der Auswahlzeile und Ausschlüsse des Aufrufers
dcl-s width like(int4_t) inz(63);
dcl-s isExclKeys like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek27;
  i_pgm        like(pgm_t) const;
  o_choices    like(choice_t) dim(32);
  o_numchoices like(int4_t);
  i_exclkeys   like(pgmcmd_t) dim(25) options(*nopass: *omit) const;
  i_width      like(int4_t) options(*nopass) const;
end-pi;

dcl-s do_x1 packed(7);
dcl-s do_x2 packed(7);

//----------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

o_choices(*) = *blanks;
o_numchoices = *zeros;

isExclKeys = bFalse;
if (%parms() >= %parmnum(i_exclkeys));
  if (%addr(i_exclkeys) <> *null);
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
  o_numchoices = 1;

  //  Numerische-Auswahlen ...
  wrk_sectn = '*' + %trim(i_pgm);
  wrk_key = *blanks;
  wrk_key = '0' + wrk_key;
  p_setllusr(wrk_sectn: wrk_key);

  for do_x1 = 1 to *hival;
    if (f_readeusr(wrk_sectn: wrk_key: data)= '1');
      leave;
    endif;

    //  Überprüfen Ausschlüsse
    if (isExclKeys);
      if (f_iskeyexc(data: i_exclkeys) = bTrue);
        iter;
      endif;
    endif;

    exsr buildstr;
    if (x > 32);
      //          Fertig, Tabelle ist voll
      leave;
    endif;

  endfor;

  //  String-Auswahlen ...
  wrk_sectn = '*' + %trim(i_pgm);
  wrk_key = *allx'FF';
  wrk_key = '*' + wrk_key;
  p_setllusr(wrk_sectn: wrk_key);

  for do_x2 = 1 to *hival;
    if (f_readeusr(wrk_sectn: wrk_key: data)= '1');
      leave;
    endif;

    //  Numerische-Auswahlen, siehe oben ...
    if (wrk_key > '0');
      leave;
    endif;

    //  Überprüfen Ausschlüsse
    if (isExclKeys);
      if (f_iskeyexc(data: i_exclkeys) = bTrue);
        iter;
      endif;
    endif;

    exsr buildstr;
    if (x > 32);
      //          Fertig, Tabelle ist voll
      leave;
    endif;

  endfor;

endsr;

//============================================================*
//    BuildStr      String zusammenbauen                      *
//============================================================*

begsr buildstr;

  wrk_msgid = f_mapCmdToMsg(data: wrk_sectn);
  if (wrk_msgid <> '');
    wrk_msgid = 'KEY' + %trim(wrk_msgid);
    wrk_msgtxt = f_msgtext(wrk_msgid: ' ');
  else;
    //  Befehl ohne Nachrichtentext
    wrk_msgtxt = '???';
  endif;

  //  Stringlänge
  z = %checkr(' ': wrk_msgtxt);
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
    o_numchoices = o_numchoices + 1;
  endif;

  if (x > 32);
  //               Nix tun, Tabelle ist voll
  else;
    if (o_choices(x) = *blanks);
      o_choices(x) = %trimr(wrk_key);
    else;
      o_choices(x) = %trimr(o_choices(x)) +
                 '  ' + %trimr(wrk_key);
    endif;
    o_choices(x) = %trimr(o_choices(x)) +
               '=' + %trim(wrk_msgtxt);
  endif;

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

