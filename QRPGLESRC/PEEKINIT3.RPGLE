**FREE
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
//
dcl-f PEEKUSR usage(*update:*delete) keyed usropn extfile(g_file)
      prefix(S_);
//
dcl-s g_file          char(21) inz;
//
dcl-ds set0004 likeds(SET0004_t) inz;
//
/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,SET0004                        Spracheinstellungen
/COPY QCOPYLE,PPEEK53
//
//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
//
dcl-ds key qualified;
  user            char(10);
  section         char(10);
  key             char(10);
end-ds;
//
//  Input
dcl-pi *n;
  XLib            char(10);
  XLang4          char(4);
end-pi;
//---------------------------------------------------*

g_file = %trim(XLib) + '/PEEKUSR';

open PEEKUSR;

key.user    = '*NONE';
key.section = '*PGM';
key.key     = '*LANGUAGE';

chain %kds(key) FPEEKUSR;
if (%found(PEEKUSR));
   SET0004 = S_DATA;
   set0004.SET_LANG = XLang4;
   S_DATA = SET0004;
   update FPEEKUSR;
endif;

close PEEKUSR;

*inlr = *ON;
//
