**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 3.2.4                               *
//  Programm : EXIT03                                            *
//  Typ      : RPGLE                                             *
//                                                               *
//  erstellt : 12.08.2010  Thomas Raddatz                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//  ===================                                          *
//  EXIT-Programm zur Ermittlung der der Edit Codes              *
//  für die generierten Update Programme.                        *
//                                                               *
//  Parameterliste:                                              *
//  ===============                                              *
//     In :  gi_file    - Name der Datei, für die das Update     *
//                        Programm erzeugt wird.                 *
//     In :  gi_lib     - Name der Bilbiothek, in der gi_file    *
//                        Enthalten ist.                         *
//     In :  gi_user    - Name des Benutzer, der das Programm    *
//                        gerade ausführt.                       *
//     In :  gi_field   - Name des Feldes, für das gerade der    *
//                        Programmcode erzeugt wird.             *
//     I/O:  gio_edtCde - Edit Code von i_field. Kann in diesem  *
//                        Programm überschrieben werden.         *
//                                                               *
//  Berechnen der Rückgabewerte:                                 *
//  ============================                                 *
//  In diesem Beispielprogramm werden unabhängig der zu          *
//  zu ändernden Datei (gi_file/gi_lib) und des aktuellen        *
//  Feldes (gi_field) Edit Codes ohne Vorzeichen in Edit Codes   *
//  mit Vorzeichen und ohne Tausenderpunkt geändert.             *
//                                                               *
//  Erstellen des Programms:                                     *
//  ========================                                     *
//  CRTRPGMOD MODULE(PEEK/EXIT03) DBGVIEW(*ALL) TRUNCNBR(*NO)    *
//  SRCFILE(PEEK/QRPGLESRC) SRCMBR(EXIT03)                       *
//  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V5R2M0)                 *
//                                                               *
//  CRTPGM PGM(PEEK/EXIT03) MODULE(PEEK/EXIT03*)                 *
//  REPLACE(*YES)                                                *
//  TEXT('Peek/400 - EXIT-Programm: Ermitteln EDIT CODE     ')   *
//  TGTRLS(V5R2M0) DETAIL(*BASIC) ACTGRP(PEEK)                   *
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
/include QCOPYLE,PEXIT03
/undefine internal_prototype

dcl-pr main extproc('main');
  i_file    like(gi_file) const;
  i_lib     like(gi_lib) const;
  i_user    like(gi_user) const;
  i_field   like(gi_field) const;
  io_edtcde like(gio_edtcde);
end-pr;

dcl-pr in ind extproc('in');
  i_arg  char(1) const;
  i_list varchar(32) const;
end-pr;

//===============================================================*
//    Program Entry Point                                        *
//===============================================================*
dcl-pi exit03;
  gi_file    char(10) const;
  gi_lib     char(10) const;
  gi_user    char(10) const;
  gi_field   char(10) const;
  gio_edtcde char(1);
end-pi;

main(gi_file: gi_lib: gi_user: gi_field: gio_edtcde);

return;

//===============================================================*
//    Main Procedure (local fields)                              *
//===============================================================*
dcl-proc main;
  dcl-pi *n;
    i_file    like(gi_file) const;
    i_lib     like(gi_lib) const;
    i_user    like(gi_user) const;
    i_field   like(gi_field) const;
    io_edtcde like(gio_edtcde);
  end-pi;

  //  lokale Arbeitsfelder
  //---------------------------------------------------------------*

  select;
  when (in(io_edtcde: '24BDKMOQ'));
    io_edtcde = 'M';           // Minus-Zeichen, Nullenunterdrückung
  when (io_edtcde = 'Z');
    io_edtcde = 'M';           // Minus-Zeichen, Nullenunterdrückung
  when (in(io_edtcde: '13ACJLNP'));
    io_edtcde = 'L';           // Minus-Zeichen, keine Nullenunterdrückung
  when (io_edtcde = ' ');
    io_edtcde = 'L';           // Minus-Zeichen, keine Nullenunterdrückung
  endsl;

  return;


end-proc main;

//===============================================================*
//    Liefert TRUE, wenn i_arg in i_list enthalten ist,          *
//    sonst FALSE.                                               *
//===============================================================*
dcl-proc in;
  dcl-pi *n ind;
    i_arg  char(1) const;
    i_list varchar(32) const;
  end-pi;

  //  lokale Arbeitsfelder
  //---------------------------------------------------------------*

  if (%scan(i_arg: i_list) > 0);
    return *on;
  else;
    return *off;
  endif;


end-proc;

