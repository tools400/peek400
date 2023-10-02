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
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                          *
       //  EXIT-Programm zur Protokollierung von Datensatzänderungen.   *
       //                                                               *
       //  Parameterliste:                                              *
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                              *
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
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                       *
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
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                 *
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
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                         *
       //  CRTBNDRPG PGM(PEEK/EXIT04) DBGVIEW(*ALL) TRUNCNBR(*NO)       *
       //  SRCFILE(PEEK/QEXAMPLE) SRCMBR(EXIT04)                        *
       //  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V5R3M0)                 *
       //  TEXT('Peek/400 - EXIT-Programm: Protokollierung         ')   *
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

      /if defined(*CRTBNDRPG)
       ctl-opt dftactgrp(*no) actgrp(*caller);
      /endif
       //===============================================================*
       dcl-f exit04log usage(*update:*delete:*output)
             keyed usropn rename(exit04log: fexit04log) prefix(log_);

       dcl-pr exit04        extpgm('EXIT04');
         gi_file         char(10) const;
         gi_lib          char(10) const;
         gi_mbr          char(10) const;
         gi_event        char(10) const;
         gi_user         char(10) const;
         gi_timestamp    timestamp const;
         gi_rcdnbr       int(10) const;
         gi_size         int(10) const;
         gi_bimage       pointer const;
         gi_aimage       pointer const;
       end-pr;

       dcl-pr main        extproc('main');
         i_file          const  like(gi_file      );
         i_lib           const  like(gi_lib       );
         i_mbr           const  like(gi_mbr       );
         i_event         const  like(gi_event     );
         i_user          const  like(gi_user      );
         i_timestamp     const  like(gi_timestamp );
         i_rcdnbr        const  like(gi_rcdnbr    );
         i_size          const  like(gi_size      );
         i_bimage        const  like(gi_bimage    );
         i_aimage        const  like(gi_aimage    );
       end-pr;

       //===============================================================*
       //    Program Entry Point                                        *
       //===============================================================*
       dcl-pi exit04;
         gi_file         char(10) const;
         gi_lib          char(10) const;
         gi_mbr          char(10) const;
         gi_event        char(10) const;
         gi_user         char(10) const;
         gi_timestamp    timestamp const;
         gi_rcdnbr       int(10) const;
         gi_size         int(10) const;
         gi_bimage       pointer const;
         gi_aimage       pointer const;
       end-pi;

       main(gi_file: gi_lib: gi_mbr: gi_event: gi_user: gi_timestamp
            : gi_rcdnbr: gi_size: gi_bimage: gi_aimage);

       return;

       //===============================================================*
       //    Main Procedure (local fields)                              *
       //===============================================================*
       dcl-proc main;

       dcl-pi main;
         i_file          const  like(gi_file      );
         i_lib           const  like(gi_lib       );
         i_mbr           const  like(gi_mbr       );
         i_event         const  like(gi_event     );
         i_user          const  like(gi_user      );
         i_timestamp     const  like(gi_timestamp );
         i_rcdnbr        const  like(gi_rcdnbr    );
         i_size          const  like(gi_size      );
         i_bimage        const  like(gi_bimage    );
         i_aimage        const  like(gi_aimage    );
       end-pi;

       dcl-s bimage          char(32767) based(i_bimage);
       dcl-s aimage          char(32767) based(i_aimage);
       //---------------------------------------------------------------*

       open(e) exit04log;
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
          log_rcdnbr    = i_rcdnbr;
          log_size      = i_size;
          if (i_bimage <> *null); // *CHANGE, *COPY or *DELETE
             log_bimage = %subst(bimage: 1: i_size);
          else;
             log_bimage = '*N';
          endif;
          if (i_aimage <> *null); // *ADD, *CHANGE, *COPY
             log_aimage = %subst(aimage: 1: i_size);
          else;
             log_aimage = '*N';
          endif;
          write fexit04log;
       on-error;
       endmon;

       close exit04log;


       end-proc main;

