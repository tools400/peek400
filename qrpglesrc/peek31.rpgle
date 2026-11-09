**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Ermitteln der Benutzersprache                *
      //%EMETADATA                                                     *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/copy 'qcopyle/set0004.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek31.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek31;
  io_language like(language_t);
  i_prefix    like(prefix_t) const;
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-s do_x1 packed(7);
dcl-ds set0004 likeds(set0004_t) inz;
dcl-s isFallback like(bool_t) inz(bFalse);
dcl-s msgF like(file_t);
//----------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

o_msgID = *blanks;
o_msgDta = *blanks;
isFallback = bFalse;

//  Ermitteln der zu verwendenden Sprache ...
if (io_language = '*DFT');
  //  ... Standardsprache
  set0004 = f_getUsrSg('*LANGUAGE':  o_msgID: o_msgDta);
else;
  //  ... Benutzen der übergebenen Sprache
  set0004.set_lang = io_language;
endif;

if (o_msgID = '');
  //  ... Prüfen der Nachrichtendatei
  for do_x1 = 1 to 2;

    if (f_exist(%trimr(i_prefix) + set0004.set_lang
       : sds.pgmLib : '*MSGF'));
      //  ... kein Fehler
      leave;
    else;
      //  ... Fehler aufgetreten
      if (set0004.set_lang = 'GER');
        //  ... Standardsprache: CPF2407 Nachrichtendatei &1 in &2
        //      nicht gefunden (aus QCPFMSG, in der Systemsprache)
        msgF = %trimr(i_prefix) + set0004.set_lang;
        o_msgID  = 'CPF2407';
        o_msgDta = msgF + sds.pgmLib;
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

if (o_msgID = '');
  //  Nur eine gefundene Sprache speichern. Das Ausweichen auf GER gilt
  //  nur für diesen Aufruf, die eingestellte Sprache bleibt erhalten.
  if (isFallback = bFalse);
    p_updUsrSg('*LANGUAGE': set0004);
  endif;
  io_language = set0004.set_lang;
else;
  io_language = '';
endif;

return;

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

