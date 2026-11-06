**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK31                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 13.11.97  Raddatz                                 *
//  geändert : 27.04.99  2.1.0                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Ermitteln der Benutzersprache                                *
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

/copy QCOPYLE,SET0004

/define internal_prototype
/copy QCOPYLE,PPEEK31
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek31;
  io_language like(language_t);
  i_prefix    like(prefix_t) const;
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
end-pi;

dcl-s do_x1 packed(7);
dcl-ds set0004 likeds(set0004_t) inz;
dcl-s isFallback like(bool_t) inz(bFalse);
dcl-s msgf like(file_t);
//----------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

o_msgid = *blanks;
o_msgdta = *blanks;
isFallback = bFalse;

//  Ermitteln der zu verwendenden Sprache ...
if (io_language = '*DFT');
  //  ... Standardsprache
  set0004 = f_getusrsg('*LANGUAGE':  o_msgid: o_msgdta);
else;
  //  ... Benutzen der übergebenen Sprache
  set0004.set_lang = io_language;
endif;

if (o_msgid = '');
  //  ... Prüfen der Nachrichtendatei
  for do_x1 = 1 to 2;

    if (f_exist(%trimr(i_prefix) + set0004.set_lang
       : sds.pgmlib : '*MSGF'));
      //  ... kein Fehler
      leave;
    else;
      //  ... Fehler aufgetreten
      if (set0004.set_lang = 'GER');
        //  ... Standardsprache: CPF2407 Nachrichtendatei &1 in &2
        //      nicht gefunden (aus QCPFMSG, in der Systemsprache)
        msgf = %trimr(i_prefix) + set0004.set_lang;
        o_msgid  = 'CPF2407';
        o_msgdta = msgf + sds.pgmlib;
        leave;
      else;
        //  ... Benutzersprache
        set0004.set_lang = 'GER';
        isFallback = bTrue;
        iter;
      endif;
    endif;

  endfor;
endif;

if (o_msgid = '');
  //  Nur eine gefundene Sprache speichern. Das Ausweichen auf GER gilt
  //  nur für diesen Aufruf, die eingestellte Sprache bleibt erhalten.
  if (isFallback = bFalse);
    p_updusrsg('*LANGUAGE': set0004);
  endif;
  io_language = set0004.set_lang;
else;
  io_language = '';
endif;

return;

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

