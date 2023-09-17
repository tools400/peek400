      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 3.4.1                               *
      *  Programm : PEEKINIT3                                         *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 01.08.2012  Raddatz                               *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Initialisieren PEEKUSR.                                      *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEKUSR   UF   E           K DISK    usropn
     F                                     extfile(g_file)
     F                                     prefix(S_)
      *
     D g_file          S             21A   inz
      *
     D XLib            S             10A
     D XLang4          S              4A
      *
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,SET0004                        Spracheinstellungen
      /COPY QCOPYLE,F_PEEK53
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D key             DS                  qualified
     D  user                         10A
     D  section                      10A
     D  key                          10A
      *
     C     *ENTRY        PLIST
      *  Input
     C                   PARM                    XLib
     C                   PARM                    XLang4
      *---------------------------------------------------*
      /FREE

         g_file = %trim(XLib) + '/PEEKUSR';

         open PEEKUSR;

         key.user    = '*NONE';
         key.section = '*PGM';
         key.key     = '*LANGUAGE';

         chain %kds(key) FPEEKUSR;
         if (%found(PEEKUSR));
            SET0004 = S_DATA;
            SET_LANG = XLang4;
            S_DATA = SET0004;
            update FPEEKUSR;
         endif;

         close PEEKUSR;

         *inlr = *ON;
      /END-FREE
      *
