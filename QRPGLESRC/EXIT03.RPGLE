      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 3.2.4                               *
      *  Programm : EXIT03                                            *
      *  Typ      : RPGLE                                             *
      *                                                               *
      *  erstellt : 12.08.2010  Thomas Raddatz                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                          *
      *  EXIT-Programm zur Ermittlung der der Edit Codes              *
      *  für die generierten Update Programme.                        *
      *                                                               *
      *  Parameterliste:                                              *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                              *
      *     In :  gi_file    - Name der Datei, für die das Update     *
      *                        Programm erzeugt wird.                 *
      *     In :  gi_lib     - Name der Bilbiothek, in der gi_file    *
      *                        Enthalten ist.                         *
      *     In :  gi_user    - Name des Benutzer, der das Programm    *
      *                        gerade ausführt.                       *
      *     In :  gi_field   - Name des Feldes, für das gerade der    *
      *                        Programmcode erzeugt wird.             *
      *     I/O:  gio_edtCde - Edit Code von i_field. Kann in diesem  *
      *                        Programm überschrieben werden.         *
      *                                                               *
      *  Berechnen der Rückgabewerte:                                 *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                 *
      *  In diesem Beispielprogramm werden unabhängig der zu          *
      *  zu ändernden Datei (gi_file/gi_lib) und des aktuellen        *
      *  Feldes (gi_field) Edit Codes ohne Vorzeichen in Edit Codes   *
      *  mit Vorzeichen und ohne Tausenderpunkt geändert.             *
      *                                                               *
      *  Erstellen des Programms:                                     *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                     *
      *  CRTRPGMOD MODULE(PEEK/EXIT03) DBGVIEW(*ALL) TRUNCNBR(*NO)    *
      *  SRCFILE(PEEK/QRPGLESRC) SRCMBR(EXIT03)                       *
      *  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V5R2M0)                 *
      *                                                               *
      *  CRTPGM PGM(PEEK/EXIT03) MODULE(PEEK/EXIT03*)                 *
      *  REPLACE(*YES)                                                *
      *  TEXT('Peek/400 - EXIT-Programm: Ermitteln EDIT CODE     ')   *
      *  TGTRLS(V5R2M0) DETAIL(*BASIC) ACTGRP(PEEK)                   *
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
      /include QCOPYLE,H_SPEC
      /include QCOPYLE,COPYRIGHT
      *
      *  *ENTRY-Liste
     D EXIT03          PR                         extpgm('EXIT03')
     D  gi_file                      10A   const
     D  gi_lib                       10A   const
     D  gi_user                      10A   const
     D  gi_field                     10A   const
     D  gio_edtCde                    1A
      *
     D main            PR                         extproc('main')
     D  i_file                             const  like(gi_file   )
     D  i_lib                              const  like(gi_lib    )
     D  i_user                             const  like(gi_user   )
     D  i_field                            const  like(gi_field  )
     D  io_edtCde                                 like(gio_edtCde)
      *
     D in              PR              N          extproc('in')
     D  i_arg                         1A   const
     D  i_list                       32A   const  varying
      *
      *===============================================================*
      *    Programmeintrittspunkt                                     *
      *===============================================================*
     D EXIT03          PI
     D  gi_file                      10A   const
     D  gi_lib                       10A   const
     D  gi_user                      10A   const
     D  gi_field                     10A   const
     D  gio_edtCde                    1A
      *
      *---------------------------------------------------------------*
      /FREE

         main(gi_file: gi_lib: gi_user: gi_field: gio_edtCde);

         return;

      /END-FREE
      *
      *===============================================================*
      *    Hauptprozedur (wegen lokaler Variablen)                    *
      *===============================================================*
     P main            B
      *
     D main            PI
     D  i_file                             const  like(gi_file   )
     D  i_lib                              const  like(gi_lib    )
     D  i_user                             const  like(gi_user   )
     D  i_field                            const  like(gi_field  )
     D  io_edtCde                                 like(gio_edtCde)
      *
      *  lokale Arbeitsfelder
      *---------------------------------------------------------------*
      /FREE

         select;
         when (in(io_edtCde: '24BDKMOQ'));
            io_edtCde = 'M';           // Minus-Zeichen, Nullenunterdrückung
         when (io_edtCde = 'Z');
            io_edtCde = 'M';           // Minus-Zeichen, Nullenunterdrückung
         when (in(io_edtCde: '13ACJLNP'));
            io_edtCde = 'L';           // Minus-Zeichen, keine Nullenunterdrückung
         when (io_edtCde = ' ');
            io_edtCde = 'L';           // Minus-Zeichen, keine Nullenunterdrückung
         endsl;

         return;

      /END-FREE
      *
     P main            E
      *
      *===============================================================*
      *    Liefert TRUE, wenn i_arg in i_list enthalten ist,          *
      *    sonst FALSE.                                               *
      *===============================================================*
     P in              B
      *
     D in              PI              N
     D  i_arg                         1A   const
     D  i_list                       32A   const  varying
      *
      *  lokale Arbeitsfelder
      *---------------------------------------------------------------*
      /FREE

         if (%scan(i_arg: i_list) > 0);
            return *ON;
         else;
            return *OFF;
         endif;

      /END-FREE
      *
     P in              E
      *
