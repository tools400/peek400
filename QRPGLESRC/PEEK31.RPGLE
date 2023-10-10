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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,SDS
/COPY QCOPYLE,CEECNDHDLR

/COPY QCOPYLE,SET0004

/define internal_prototype
/COPY QCOPYLE,PPEEK31
/undefine internal_prototype

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek31;
  io_language           like(language_t);
  i_prefix        const like(prefix_t);
  o_msgid               like(msgid_t);
  o_msgdta              like(msgdta_t);
end-pi;

dcl-s do_x1     packed(7);
dcl-ds set0004  likeds(set0004_t) inz;
//----------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

o_msgid = *blanks;
o_msgdta = *blanks;

//  Ermitteln der zu verwendenden Sprache ...
if io_language = '*DFT';
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
        //  ... Standardsprache
        o_msgid  = 'CPF9897';
        o_msgdta = 'Sprachendefinition ''' +
                   %trim(io_language) +
                   ''' nicht gefunden.';
        leave;
      else;
        //  ... Benutzersprache
        set0004.set_lang = 'GER';
        iter;
      endif;
    endif;

  endfor;
endif;

if (o_msgid = '');
  p_updusrsg('*LANGUAGE': set0004);
  io_language = set0004.set_lang;
else;
  io_language = '';
endif;

return;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorhandler;
  dcl-pi *N;
    i_condtoken     value likeds(cee_fc_t);
    i_pcommarea     int(10) value;
    o_action        int(10);
    o_newcondtoken  likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

