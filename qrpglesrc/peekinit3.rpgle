**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Initialisieren Peek/400 - PEEKUSR            *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 3.4.1                               *
//  Programm : PEEKINIT3                                         *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 01.08.2012  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Initialisieren PEEKUSR.                                      *
//                                                               *
//===============================================================*
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f PEEKUSR usage(*update: *delete) keyed usropn extfile(g_file) prefix(S_);

dcl-s g_file char(21) inz;

dcl-ds set0004 likeds(set0004_t) inz;

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/set0004.rpgleinc' // Spracheinstellungen
/copy 'qcopyle/ppeek53.rpgleinc'

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-ds key qualified;
  user    char(10);
  section char(10);
  key     char(10);
end-ds;

//  Input
dcl-pi *n;
  xLib   char(10);
  xLang4 char(4);
end-pi;
//---------------------------------------------------*

g_file = %trim(xLib) + '/PEEKUSR';

open PEEKUSR;

key.user    = '*NONE';
key.section = '*PGM';
key.key     = '*LANGUAGE';

chain %kds(key) FPEEKUSR;
if (%found(PEEKUSR));
  SET0004 = S_DATA;
  set0004.SET_LANG = xLang4;
  S_DATA = SET0004;
  update FPEEKUSR;
endif;

close PEEKUSR;

*inlr = *on;

