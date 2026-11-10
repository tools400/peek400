**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - EXIT-Programm: Protokollierung               *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 3.4.4                               *
//  Programm : EXIT04                                            *
//  Typ      : RPGLE                                             *
//                                                               *
//  erstellt : 08.02.2013  Thomas Raddatz                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//  ===================                                          *
//  EXIT-Programm zur Protokollierung von Datensatzänderungen.   *
//                                                               *
//  Das Exit-Programm ist optional.                              *
//                                                               *
//  Parameterliste:                                              *
//  ===============                                              *
//     In :  gi_file      - Name of the file.                    *
//                                                               *
//     In :  gi_lib       - Name of the library that contains    *
//                          the file.                            *
//     In :  gi_mbr       - Name of the member that contains     *
//                          the record.                          *
//     In :  gi_event     - Event that triggered the exit the    *
//                          exit program:                        *
//                             *ADD, *CHANGE, *COPY or *DELETE   *
//     In :  gi_user      - Name of the user who chanegd         *
//                          the record.                          *
//     In :  gi_timestamp - Current timestamp.                   *
//                                                               *
//     In :  gi_rcdNbr    - Record number.                       *
//                                                               *
//     In :  gi_size      - Size of the before and after         *
//                          images.                              *
//     In :  gi_bImage    - Before-Image of the record.          *
//                                                               *
//     In :  gi_aImage    - After-Image of the record.           *
//                                                               *
//  Erstellen des Datei EXIT04 (Beispiel):                       *
//  ======================================                       *
//  CREATE TABLE PEEK.EXIT04LOG (                                *
//     "FILE"      CHARACTER ( 10) NOT NULL WITH DEFAULT,        *
//     LIB         CHARACTER ( 10) NOT NULL WITH DEFAULT,        *
//     MBR         CHARACTER ( 10) NOT NULL WITH DEFAULT,        *
//     EVENT       CHARACTER ( 10) NOT NULL WITH DEFAULT,        *
//     "USER"      CHARACTER ( 10) NOT NULL WITH DEFAULT,        *
//     "TIMESTAMP" TIMESTAMP       NOT NULL WITH DEFAULT,        *
//     RCDNBR      INT             NOT NULL WITH DEFAULT,        *
//     SIZE        INT             NOT NULL WITH DEFAULT,        *
//     BIMAGE      CHARACTER (500) NOT NULL WITH DEFAULT,        *
//     AIMAGE      CHARACTER (500) NOT NULL WITH DEFAULT)        *
//                                                               *
//  Erstellen des Programms (CRTRPGMOD + CRTPGM)                 *
//  ============================================                 *
//  CRTRPGMOD MODULE(PEEK/EXIT04) DBGVIEW(*ALL) TRUNCNBR(*NO)    *
//  SRCFILE(PEEK/QEXAMPLE) SRCMBR(EXIT04)                        *
//  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V5R3M0)                 *
//                                                               *
//  CRTPGM PGM(PEEK/EXIT04) MODULE(PEEK/EXIT04*)                 *
//  REPLACE(*YES)                                                *
//  TGTRLS(V5R3M0) DETAIL(*BASIC) ACTGRP(PEEK)                   *
//  TEXT('Peek/400 - EXIT-Programm: Protokollierung         ')   *
//                                                               *
//  Erstellen des Programms (CRTBNDRPG):                         *
//  ====================================                         *
//  CRTBNDRPG PGM(PEEK/EXIT04) DBGVIEW(*ALL) TRUNCNBR(*NO)       *
//  SRCFILE(PEEK/QEXAMPLE) SRCMBR(EXIT04)                        *
//  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V5R3M0)                 *
//  TEXT('Peek/400 - EXIT-Programm: Protokollierung         ')   *
//                                                               *
// ============================================================= *
/include QCOPYLE,H_SPEC
/include QCOPYLE,COPYRIGHT

/if defined(*CRTBNDRPG)
ctl-opt dftactgrp(*no) actgrp(*caller);
/endif

dcl-f exit04Log usage(*update: *delete: *output) keyed usropn rename(exit04Log: fexit04log)
  prefix(log_);

/define internal_prototype
/include QCOPYLE,PEXIT04
/undefine internal_prototype

dcl-pr main extproc('main');
  i_file      like(gi_file) const;
  i_lib       like(gi_lib) const;
  i_mbr       like(gi_mbr) const;
  i_event     like(gi_event) const;
  i_user      like(gi_user) const;
  i_timestamp like(gi_timestamp) const;
  i_rcdNbr    like(gi_rcdNbr) const;
  i_size      like(gi_size) const;
  i_bImage    like(gi_bImage) const;
  i_aImage    like(gi_aImage) const;
end-pr;

//===============================================================*
//    Program Entry Point                                        *
//===============================================================*
dcl-pi exit04;
  gi_file      char(10) const;
  gi_lib       char(10) const;
  gi_mbr       char(10) const;
  gi_event     char(10) const;
  gi_user      char(10) const;
  gi_timestamp timestamp const;
  gi_rcdNbr    int(10) const;
  gi_size      int(10) const;
  gi_bImage    pointer const;
  gi_aImage    pointer const;
end-pi;

main(gi_file: gi_lib: gi_mbr: gi_event: gi_user: gi_timestamp
     : gi_rcdNbr: gi_size: gi_bImage: gi_aImage);

return;

//===============================================================*
//    Main Procedure (local fields)                              *
//===============================================================*
dcl-proc main;
  dcl-pi *n;
    i_file      like(gi_file) const;
    i_lib       like(gi_lib) const;
    i_mbr       like(gi_mbr) const;
    i_event     like(gi_event) const;
    i_user      like(gi_user) const;
    i_timestamp like(gi_timestamp) const;
    i_rcdNbr    like(gi_rcdNbr) const;
    i_size      like(gi_size) const;
    i_bImage    like(gi_bImage) const;
    i_aImage    like(gi_aImage) const;
  end-pi;

  dcl-s bImage char(32767) based(i_bImage);
  dcl-s aImage char(32767) based(i_aImage);
  //---------------------------------------------------------------*

  open(e) exit04Log;
  if (%error());
    return;
  endif;

  monitor;
    clear fexit04log;
    log_file      = i_file;
    log_lib       = i_lib;
    log_mbr       = i_mbr;
    log_event     = i_event;
    log_user      = i_user;
    log_timestamp = i_timestamp;
    log_rcdNbr    = i_rcdNbr;
    log_size      = i_size;
    if (i_bImage <> *null); // *CHANGE, *COPY or *DELETE
      log_bimage = %subst(bImage: 1: i_size);
    else;
      log_bimage = '*N';
    endif;
    if (i_aImage <> *null); // *ADD, *CHANGE, *COPY
      log_aimage = %subst(aImage: 1: i_size);
    else;
      log_aimage = '*N';
    endif;
    write fexit04log;
  on-error;
  endmon;

  close exit04Log;


end-proc main;

