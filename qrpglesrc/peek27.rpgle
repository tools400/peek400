**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Einlesen der Subfile-Auswahlen               *
      //%EMETADATA                                                     *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek27.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-s x like(int4_t) inz;
dcl-s y like(int4_t) inz;
dcl-s z like(int4_t) inz;

dcl-s wrk_msgID like(msgId_t) inz;
dcl-s wrk_msgTxt like(msgDta_t) inz;
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
  wrk_sectn = '*' + %trim(i_pgm);
  wrk_key = *blanks;
  wrk_key = '0' + wrk_key;
  p_setllUsr(wrk_sectn: wrk_key);

  for do_x1 = 1 to *hival;
    if (f_readeUsr(wrk_sectn: wrk_key: data)= '1');
      leave;
    endif;

    //  Überprüfen Ausschlüsse
    if (isExclKeys);
      if (f_isKeyExc(data: i_exclKeys) = bTrue);
        iter;
      endif;
    endif;

    exsr buildStr;
    if (x > 32);
      //          Fertig, Tabelle ist voll
      leave;
    endif;

  endfor;

  //  String-Auswahlen ...
  wrk_sectn = '*' + %trim(i_pgm);
  wrk_key = *allx'FF';
  wrk_key = '*' + wrk_key;
  p_setllUsr(wrk_sectn: wrk_key);

  for do_x2 = 1 to *hival;
    if (f_readeUsr(wrk_sectn: wrk_key: data)= '1');
      leave;
    endif;

    //  Numerische-Auswahlen, siehe oben ...
    if (wrk_key > '0');
      leave;
    endif;

    //  Überprüfen Ausschlüsse
    if (isExclKeys);
      if (f_isKeyExc(data: i_exclKeys) = bTrue);
        iter;
      endif;
    endif;

    exsr buildStr;
    if (x > 32);
      //          Fertig, Tabelle ist voll
      leave;
    endif;

  endfor;

endsr;

//============================================================*
//    buildStr      String zusammenbauen                      *
//============================================================*

begsr buildStr;

  wrk_msgID = f_mapCmdToMsg(data: wrk_sectn);
  if (wrk_msgID <> '');
    wrk_msgID = 'KEY' + %trim(wrk_msgID);
    wrk_msgTxt = f_msgText(wrk_msgID: ' ');
  else;
    //  Befehl ohne Nachrichtentext
    wrk_msgTxt = '???';
  endif;

  //  Stringlänge
  z = %checkr(' ': wrk_msgTxt);
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
      o_choices(x) = %trimr(wrk_key);
    else;
      o_choices(x) = %trimr(o_choices(x)) +
                 '  ' + %trimr(wrk_key);
    endif;
    o_choices(x) = %trimr(o_choices(x)) +
               '=' + %trim(wrk_msgTxt);
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

