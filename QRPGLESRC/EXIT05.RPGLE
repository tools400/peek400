      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 3.4.4                               *
      *  Programm : EXIT05                                            *
      *  Typ      : RPGLE                                             *
      *                                                               *
      *  erstellt : 02.07.2013  Thomas Raddatz                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                          *
      *  EXIT-Programm zur Anpassung von Benutzereingaben.            *
      *                                                               *
      *  Parameterliste:                                              *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                              *
      *     In :  gi_file      - Name of the user settings file.      *
      *                                                               *
      *     In :  gi_lib       - Name of the library that contains    *
      *                          the user settings file.              *
      *     In :  gi_user      - Name of the user who produced the    *
      *                          action event.                        *
      *     In :  gi_pgm       - Name of the program that generated   *
      *                          the user action event.               *
      *     In :  gi_type      - Type of the data passed in           *
      *                          gio_value.                           *
      *                          *CMDKEY = cmd key pressed            *
      *                          *OPTION = subfile option entered     *
      *                          *EVENT  = mapped action event        *
      *                          *USROPT = user defined option        *
      *     I/O:  gio_value    - Action event as produced by the      *
      *                          user.                                *
      *                                                               *
      *                                                               *
      *  Beispiel:                                                    *
      *  ¯¯¯¯¯¯¯¯¯                                                    *
      *  Typische Aufrufreihenfolge am Beispiel der Auswahl '5'       *
      *  im Programm PEEK05:                                          *
      *                                                               *
      *     1. Aufruf:         type  = '*CMDKEY'  --+                 *
      *                        value = '*ENTER'     |   Datenfreigabe *
      *     2. Aufruf:         type  = '*EVENT'     |                 *
      *                        value = '*ENTER'   --+                 *
      *     3. Aufruf:         type  = '*OPTION'  --+                 *
      *                        value = '5'          |   Auswahl '5'   *
      *     4. Aufruf:         type  = '*EVENT'     |                 *
      *                        value = '*DISPLAY' --+                 *
      *                                                               *
      *                                                               *
      *  Erstellen des Programms:                                     *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                     *
      *  CRTRPGMOD MODULE(PEEK/EXIT05) DBGVIEW(*ALL) TRUNCNBR(*NO)    *
      *  SRCFILE(PEEK/QRPGLESRC) SRCMBR(EXIT05)                       *
      *  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V5R3M0)                 *
      *                                                               *
      *  CRTPGM PGM(PEEK/EXIT05) MODULE(PEEK/EXIT05*)                 *
      *  REPLACE(*YES)                                                *
      *  TEXT('Peek/400 - EXIT-Programm: Benutzerauswahl         ')   *
      *  TGTRLS(V5R3M0) DETAIL(*BASIC) ACTGRP(PEEK)                   *
      *                                                               *
      * ============================================================= *
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
      *                           OBJLIB(&LI) DEVLIB(&LI) +           *
      *                           SBMJOB(*NO) BNDDIR(PEEK) +          *
      *                           INSTALL(*NO);                       *
      *   >>EXECUTE<<                                                 *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
     H DEBUG
     H OPTION(*SRCSTMT : *NODEBUGIO)
     H DECEDIT('0,') DATEDIT(*DMY.)
     H DATFMT(*ISO ) TIMFMT(*ISO )
     H EXPROPTS(*RESDECPOS) EXTBININT(*YES)
     H CCSID(*CHAR: *JOBRUN)
      *===============================================================*
      *
      *  *ENTRY-Liste
     D EXIT05          PR                         extpgm('EXIT05')
     D  gi_file                      10A   const
     D  gi_lib                       10A   const
     D  gi_user                      10A   const
     D  gi_pgm                       10A   const
     D  gi_type                      10A   const
     D  gio_value                    10A
      *
     D main            PR                         extproc('main')
     D  i_file                             const  like(gi_file      )
     D  i_lib                              const  like(gi_lib       )
     D  i_user                             const  like(gi_user      )
     D  i_pgm                              const  like(gi_pgm       )
     D  i_type                             const  like(gi_type      )
     D  io_value                                  like(gio_value    )
      *
      *===============================================================*
      *    Programmeintrittspunkt                                     *
      *===============================================================*
     D EXIT05          PI
     D  gi_file                      10A   const
     D  gi_lib                       10A   const
     D  gi_user                      10A   const
     D  gi_pgm                       10A   const
     D  gi_type                      10A   const
     D  gio_value                    10A
      *
      *---------------------------------------------------------------*
      /FREE

         main(gi_file: gi_lib: gi_user: gi_pgm: gi_type: gio_value);

         return;

      /END-FREE
      *
      *===============================================================*
      *    Hauptprozedur (wegen lokaler Variablen)                    *
      *===============================================================*
     P main            B
      *
     D main            PI
     D  i_file                             const  like(gi_file      )
     D  i_lib                              const  like(gi_lib       )
     D  i_user                             const  like(gi_user      )
     D  i_pgm                              const  like(gi_pgm       )
     D  i_type                             const  like(gi_type      )
     D  io_value                                  like(gio_value    )
      *---------------------------------------------------------------*
      /FREE

         select;
         // Command key before it is mapped into the
         // action event.
         when (i_type = '*CMDKEY');

         // Subfile option before it is mapped into the
         // action event.
         when (i_type = '*OPTION');
            // Remove leading '0' from subfile option.
            io_value = %trimL(io_value: '0');

         // User defined option before it is retrieved
         // from the user settings file
         when (i_type = '*USROPT');

         // Final action event that triggers the
         // requested action.
         when (i_type = '*EVENT');

         endsl;

         return;

      /END-FREE
      *
     P main            E
      *
