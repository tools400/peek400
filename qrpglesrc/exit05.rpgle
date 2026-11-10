**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - EXIT-Programm: Benutzerauswahl               *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 3.4.4                               *
//  Programm : EXIT05                                            *
//  Typ      : RPGLE                                             *
//                                                               *
//  erstellt : 02.07.2013  Thomas Raddatz                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//  ===================                                          *
//  EXIT-Programm zur Anpassung von Benutzereingaben.            *
//                                                               *
//  Parameterliste:                                              *
//  ===============                                              *
//     In :  gi_file      - Name of the user settings file.      *
//                                                               *
//     In :  gi_lib       - Name of the library that contains    *
//                          the user settings file.              *
//     In :  gi_user      - Name of the user who produced the    *
//                          action event.                        *
//     In :  gi_pgm       - Name of the program that generated   *
//                          the user action event.               *
//     In :  gi_type      - Type of the data passed in           *
//                          gio_value.                           *
//                          *CMDKEY = cmd key pressed            *
//                          *OPTION = subfile option entered     *
//                          *EVENT  = mapped action event        *
//                          *USROPT = user defined option        *
//     I/O:  gio_value    - Action event as produced by the      *
//                          user.                                *
//                                                               *
//                                                               *
//  Beispiel:                                                    *
//  =========                                                    *
//  Typische Aufrufreihenfolge am Beispiel der Auswahl '5'       *
//  im Programm PEEK05:                                          *
//                                                               *
//     1. Aufruf:         type  = '*CMDKEY'  --+                 *
//                        value = '*ENTER'     |   Datenfreigabe *
//     2. Aufruf:         type  = '*EVENT'     |                 *
//                        value = '*ENTER'   --+                 *
//     3. Aufruf:         type  = '*OPTION'  --+                 *
//                        value = '5'          |   Auswahl '5'   *
//     4. Aufruf:         type  = '*EVENT'     |                 *
//                        value = '*DISPLAY' --+                 *
//                                                               *
//                                                               *
//  Erstellen des Programms:                                     *
//  ========================                                     *
//  CRTRPGMOD MODULE(PEEK/EXIT05) DBGVIEW(*ALL) TRUNCNBR(*NO)    *
//  SRCFILE(PEEK/QRPGLESRC) SRCMBR(EXIT05)                       *
//  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V5R3M0)                 *
//                                                               *
//  CRTPGM PGM(PEEK/EXIT05) MODULE(PEEK/EXIT05*)                 *
//  REPLACE(*YES)                                                *
//  TEXT('Peek/400 - EXIT-Programm: Benutzerauswahl         ')   *
//  TGTRLS(V5R3M0) DETAIL(*BASIC) ACTGRP(PEEK)                   *
//                                                               *
// ============================================================= *
/include QCOPYLE,H_SPEC
/include QCOPYLE,COPYRIGHT

/define internal_prototype
/include QCOPYLE,PEXIT05
/undefine internal_prototype

dcl-pr main extproc('main');
  i_file   like(gi_file) const;
  i_lib    like(gi_lib) const;
  i_user   like(gi_user) const;
  i_pgm    like(gi_pgm) const;
  i_type   like(gi_type) const;
  io_value like(gio_value);
end-pr;

//===============================================================*
//    Program Entry Point                                        *
//===============================================================*
dcl-pi exit05;
  gi_file   char(10) const;
  gi_lib    char(10) const;
  gi_user   char(10) const;
  gi_pgm    char(10) const;
  gi_type   char(10) const;
  gio_value char(10);
end-pi;

main(gi_file: gi_lib: gi_user: gi_pgm: gi_type: gio_value);

return;

//===============================================================*
//    Main Procedure (local fields)                              *
//===============================================================*
dcl-proc main;
  dcl-pi *n;
    i_file   like(gi_file) const;
    i_lib    like(gi_lib) const;
    i_user   like(gi_user) const;
    i_pgm    like(gi_pgm) const;
    i_type   like(gi_type) const;
    io_value like(gio_value);
  end-pi;
  //---------------------------------------------------------------*

  select;
  // Command key before it is mapped into the
  // action event.
  when (i_type = '*CMDKEY');

  // Subfile option before it is mapped into the
  // action event.
  when (i_type = '*OPTION');
    // Remove leading '0' from subfile option.
    io_value = %triml(io_value: '0');

  // User defined option before it is retrieved
  // from the user settings file
  when (i_type = '*USROPT');

  // Final action event that triggers the
  // requested action.
  when (i_type = '*EVENT');

  endsl;

  return;

end-proc main;

