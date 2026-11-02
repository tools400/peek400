       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 4.0.8                               *
       //  Programm : EXIT06                                            *
       //  Typ      : RPGLE                                             *
       //                                                               *
       //  erstellt : 02.11.2026  Thomas Raddatz                        *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //  ===================                                          *
       //  EXIT-Programm zum Überschreiben der Spaltenüberschriften     *
       //  und des Feldtexts der Felder einer Datei.                    *
       //                                                               *
       //  Peek/400 ruft das Programm nach dem Lesen der Feldliste      *
       //  einmal für jedes Feld auf, wenn es in der Produkt-           *
       //  bibliothek vorhanden ist. Die zurückgegebenen Werte          *
       //  werden anstelle der Werte aus der Datei angezeigt.           *
       //                                                               *
       //  Parameterliste:                                              *
       //  ===============                                              *
       //     In :  gi_file    - Name der angezeigten Datei.            *
       //     In :  gi_lib     - Name der Bibliothek, in der gi_file    *
       //                        enthalten ist.                         *
       //     In :  gi_user    - Name des Benutzers, der Peek/400       *
       //                        gerade ausführt.                       *
       //     In :  gi_field   - Name des Feldes.                       *
       //     I/O:  gio_col1   - Spaltenüberschrift 1 (COLHDG).         *
       //     I/O:  gio_col2   - Spaltenüberschrift 2 (COLHDG).         *
       //     I/O:  gio_col3   - Spaltenüberschrift 3 (COLHDG).         *
       //     I/O:  gio_text   - Feldtext (TEXT).                       *
       //                                                               *
       //  Berechnen der Rückgabewerte:                                 *
       //  ============================                                 *
       //  In diesem Beispielprogramm wird der Feldtext aus den         *
       //  Spaltenüberschriften gebildet, wenn das Feld keinen          *
       //  Feldtext hat. Alle anderen Werte bleiben unverändert.        *
       //                                                               *
       //  Natürlich könnten die Werte auch aus einer eigenen Tabelle   *
       //  mit Feldbeschreibungen ermittelt werden.                     *
       //                                                               *
       //  Erstellen des Programms:                                     *
       //  ========================                                     *
       //  CRTRPGMOD MODULE(PEEK/EXIT06) DBGVIEW(*ALL) TRUNCNBR(*NO)    *
       //  SRCFILE(PEEK/QEXAMPLE) SRCMBR(EXIT06)                        *
       //  REPLACE(*YES) LANGID(*JOBRUN)                                *
       //                                                               *
       //  CRTPGM PGM(PEEK/EXIT06) MODULE(PEEK/EXIT06*)                 *
       //  REPLACE(*YES)                                                *
       //  TEXT('Peek/400 - EXIT-Programm: Spaltenüberschriften')       *
       //  DETAIL(*BASIC) ACTGRP(PEEK)                                  *
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
      /include QCOPYLE,H_SPEC
      /include QCOPYLE,COPYRIGHT

      /define internal_prototype
      /include QCOPYLE,PEXIT06
      /undefine internal_prototype

       dcl-pr main        extproc('main');
         i_file          const  like(gi_file   );
         i_lib           const  like(gi_lib    );
         i_user          const  like(gi_user   );
         i_field         const  like(gi_field  );
         io_col1         like(gio_col1  );
         io_col2         like(gio_col2  );
         io_col3         like(gio_col3  );
         io_text         like(gio_text  );
       end-pr;

       //===============================================================*
       //    Program Entry Point                                        *
       //===============================================================*
       dcl-pi exit06;
         gi_file         char(10) const;
         gi_lib          char(10) const;
         gi_user         char(10) const;
         gi_field        char(10) const;
         gio_col1        char(20);
         gio_col2        char(20);
         gio_col3        char(20);
         gio_text        char(50);
       end-pi;

       main(gi_file: gi_lib: gi_user: gi_field
          : gio_col1: gio_col2: gio_col3: gio_text);

       return;

       //===============================================================*
       //    Main Procedure (local fields)                              *
       //===============================================================*
       dcl-proc main;

       dcl-pi main;
         i_file          const  like(gi_file   );
         i_lib           const  like(gi_lib    );
         i_user          const  like(gi_user   );
         i_field         const  like(gi_field  );
         io_col1         like(gio_col1  );
         io_col2         like(gio_col2  );
         io_col3         like(gio_col3  );
         io_text         like(gio_text  );
       end-pi;

       //  Build the field text from the column headings, if the field
       //  has no field text.
       if (io_text = ' ');
          io_text = %trim(io_col1);
          if (io_col2 <> ' ');
             io_text = %trimr(io_text) + ' ' + %trim(io_col2);
          endif;
          if (io_col3 <> ' ');
             io_text = %trimr(io_text) + ' ' + %trim(io_col3);
          endif;
       endif;

       return;

       end-proc main;
