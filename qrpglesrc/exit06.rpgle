**free
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
//  Bleibt der Feldtext leer, ersetzt Peek/400 ihn danach        *
//  durch die Spaltenüberschriften.                              *
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
//  In diesem Beispielprogramm werden die Spaltenüberschriften   *
//  aus dem Feldtext gebildet, wenn das Feld keine eigenen       *
//  Spaltenüberschriften hat, die Überschrift also nur der       *
//  Feldname ist (z.B. bei SQL Tabellen ohne LABEL ON). Der      *
//  Feldtext wird dazu auf bis zu drei Zeilen mit je 20 Zeichen  *
//  umgebrochen. Alle anderen Werte bleiben unverändert.         *
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

dcl-pr main extproc('main');
  i_file  like(gi_file) const;
  i_lib   like(gi_lib) const;
  i_user  like(gi_user) const;
  i_field like(gi_field) const;
  io_col1 like(gio_col1);
  io_col2 like(gio_col2);
  io_col3 like(gio_col3);
  io_text like(gio_text);
end-pr;

//===============================================================*
//    Program Entry Point                                        *
//===============================================================*
dcl-pi exit06;
  gi_file  char(10) const;
  gi_lib   char(10) const;
  gi_user  char(10) const;
  gi_field char(10) const;
  gio_col1 char(20);
  gio_col2 char(20);
  gio_col3 char(20);
  gio_text char(50);
end-pi;

main(gi_file: gi_lib: gi_user: gi_field
   : gio_col1: gio_col2: gio_col3: gio_text);

return;

//===============================================================*
//    Main Procedure (local fields)                              *
//===============================================================*
dcl-proc main;
  dcl-pi *n;
    i_file  like(gi_file) const;
    i_lib   like(gi_lib) const;
    i_user  like(gi_user) const;
    i_field like(gi_field) const;
    io_col1 like(gio_col1);
    io_col2 like(gio_col2);
    io_col3 like(gio_col3);
    io_text like(gio_text);
  end-pi;

  //  lokale Arbeitsfelder
  dcl-s text varchar(50);
  dcl-s word varchar(50);
  dcl-s p int(10);
  dcl-s line int(10);
  dcl-s lines char(20) dim(3);
  //---------------------------------------------------------------*

  //  Build the column headings from the field text, if the field
  //  has no column headings of its own (heading = field name).
  if (%trim(io_col1) = %trim(i_field) and
      io_col2 = ' ' and io_col3 = ' ' and io_text <> ' ');

    //  Wrap the field text into lines of 20 characters.
    text = %trim(io_text);
    line = 1;
    dow (text <> '' and line <= %elem(lines));
      p = %scan(' ': text);
      if (p = 0);
        word = text;
        text = '';
      else;
        word = %subst(text: 1: p - 1);
        text = %triml(%subst(text: p));
      endif;
      select;
      when (lines(line) = ' ');
        lines(line) = word;
      when (%len(%trimr(lines(line))) + 1 + %len(word)
            <= %len(lines(line)));
        lines(line) = %trimr(lines(line)) + ' ' + word;
      other;
        line = line + 1;
        if (line <= %elem(lines));
          lines(line) = word;
        endif;
      endsl;
    enddo;

    io_col1 = lines(1);
    io_col2 = lines(2);
    io_col3 = lines(3);
  endif;

end-proc;
