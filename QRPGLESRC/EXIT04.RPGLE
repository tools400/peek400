      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 3.4.4                               *
      *  Programm : EXIT04                                            *
      *  Typ      : RPGLE                                             *
      *                                                               *
      *  erstellt : 08.02.2013  Thomas Raddatz                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                          *
      *  EXIT-Programm zur Protokollierung von Datensatzänderungen.   *
      *                                                               *
      *  Parameterliste:                                              *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                              *
      *     In :  gi_file      - Name of the file.                    *
      *                                                               *
      *     In :  gi_lib       - Name of the library that contains    *
      *                          the file.                            *
      *     In :  gi_mbr       - Name of the member that contains     *
      *                          the record.                          *
      *     In :  gi_event     - Event that triggered the exit the    *
      *                          exit program:                        *
      *                             *ADD, *CHANGE, *COPY or *DELETE   *
      *     In :  gi_user      - Name of the user who chanegd         *
      *                          the record.                          *
      *     In :  gi_timestamp - Current timestamp.                   *
      *                                                               *
      *     In :  gi_rcdNbr    - Record number.                       *
      *                                                               *
      *     In :  gi_size      - Size of the before and after         *
      *                          images.                              *
      *     In :  gi_bImage    - Before-Image of the record.          *
      *                                                               *
      *     In :  gi_aImage    - After-Image of the record.           *
      *                                                               *
      *  Erstellen des Datei EXIT04 (Beispiel):                       *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                       *
      *  CREATE TABLE PEEK.EXIT04LOG (                                *
      *     "FILE"      CHARACTER ( 10) NOT NULL WITH DEFAULT,        *
      *     LIB         CHARACTER ( 10) NOT NULL WITH DEFAULT,        *
      *     MBR         CHARACTER ( 10) NOT NULL WITH DEFAULT,        *
      *     EVENT       CHARACTER ( 10) NOT NULL WITH DEFAULT,        *
      *     "USER"      CHARACTER ( 10) NOT NULL WITH DEFAULT,        *
      *     "TIMESTAMP" TIMESTAMP       NOT NULL WITH DEFAULT,        *
      *     RCDNBR      INT             NOT NULL WITH DEFAULT,        *
      *     SIZE        INT             NOT NULL WITH DEFAULT,        *
      *     BIMAGE      CHARACTER (500) NOT NULL WITH DEFAULT,        *
      *     AIMAGE      CHARACTER (500) NOT NULL WITH DEFAULT)        *
      *                                                               *
      *  Erstellen des Programms (CRTRPGMOD + CRTPGM)                 *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                 *
      *  CRTRPGMOD MODULE(PEEK/EXIT04) DBGVIEW(*ALL) TRUNCNBR(*NO)    *
      *  SRCFILE(PEEK/QEXAMPLE) SRCMBR(EXIT04)                        *
      *  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V5R3M0)                 *
      *                                                               *
      *  CRTPGM PGM(PEEK/EXIT04) MODULE(PEEK/EXIT04*)                 *
      *  REPLACE(*YES)                                                *
      *  TGTRLS(V5R3M0) DETAIL(*BASIC) ACTGRP(PEEK)                   *
      *  TEXT('Peek/400 - EXIT-Programm: Protokollierung         ')   *
      *                                                               *
      *  Erstellen des Programms (CRTBNDRPG):                         *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                         *
      *  CRTBNDRPG PGM(PEEK/EXIT04) DBGVIEW(*ALL) TRUNCNBR(*NO)       *
      *  SRCFILE(PEEK/QEXAMPLE) SRCMBR(EXIT04)                        *
      *  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V5R3M0)                 *
      *  TEXT('Peek/400 - EXIT-Programm: Protokollierung         ')   *
      *                                                               *
      *===============================================================*
     H OPTION(*SRCSTMT : *NODEBUGIO)
     H EXTBININT(*YES)
     H DATFMT(*ISO) TIMFMT(*ISO)
      /if defined(*CRTBNDRPG)
     H DFTACTGRP(*NO) ACTGRP(*CALLER)
      /endif
      *===============================================================*
     FEXIT04LOG UF A E           K DISK    usropn
     F                                     rename(EXIT04LOG: FEXIT04LOG)
     F                                     prefix(log_)
      *
      *  *ENTRY-Liste
     D EXIT04          PR                         extpgm('EXIT04')
     D  gi_file                      10A   const
     D  gi_lib                       10A   const
     D  gi_mbr                       10A   const
     D  gi_event                     10A   const
     D  gi_user                      10A   const
     D  gi_timestamp                   Z   const
     D  gi_rcdNbr                    10I 0 const
     D  gi_size                      10I 0 const
     D  gi_bImage                      *   const
     D  gi_aImage                      *   const
      *
     D main            PR                         extproc('main')
     D  i_file                             const  like(gi_file      )
     D  i_lib                              const  like(gi_lib       )
     D  i_mbr                              const  like(gi_mbr       )
     D  i_event                            const  like(gi_event     )
     D  i_user                             const  like(gi_user      )
     D  i_timestamp                        const  like(gi_timestamp )
     D  i_rcdNbr                           const  like(gi_rcdNbr    )
     D  i_size                             const  like(gi_size      )
     D  i_bImage                           const  like(gi_bImage    )
     D  i_aImage                           const  like(gi_aImage    )
      *
      *===============================================================*
      *    Programmeintrittspunkt                                     *
      *===============================================================*
     D EXIT04          PI
     D  gi_file                      10A   const
     D  gi_lib                       10A   const
     D  gi_mbr                       10A   const
     D  gi_event                     10A   const
     D  gi_user                      10A   const
     D  gi_timestamp                   Z   const
     D  gi_rcdNbr                    10I 0 const
     D  gi_size                      10I 0 const
     D  gi_bImage                      *   const
     D  gi_aImage                      *   const
      *
      *---------------------------------------------------------------*
      /FREE

         main(gi_file: gi_lib: gi_mbr: gi_event: gi_user: gi_timestamp
              : gi_rcdNbr: gi_size: gi_bImage: gi_aImage);

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
     D  i_mbr                              const  like(gi_mbr       )
     D  i_event                            const  like(gi_event     )
     D  i_user                             const  like(gi_user      )
     D  i_timestamp                        const  like(gi_timestamp )
     D  i_rcdNbr                           const  like(gi_rcdNbr    )
     D  i_size                             const  like(gi_size      )
     D  i_bImage                           const  like(gi_bImage    )
     D  i_aImage                           const  like(gi_aImage    )
      *
     D bImage          s          32767a   based(i_bImage)
     D aImage          s          32767a   based(i_aImage)
      *---------------------------------------------------------------*
      /FREE

         open(E) EXIT04LOG;
         if (%error());
            return;
         endif;

         monitor;
            clear FEXIT04LOG;
            LOG_FILE      = i_file;
            LOG_LIB       = i_lib;
            LOG_MBR       = i_mbr;
            LOG_EVENT     = i_event;
            LOG_USER      = i_user;
            LOG_TIMESTAMP = i_timestamp;
            LOG_RCDNBR    = i_rcdNbr;
            LOG_SIZE      = i_size;
            if (i_bImage <> *NULL); // *CHANGE, *COPY or *DELETE
               LOG_BIMAGE = %subst(bImage: 1: i_size);
            else;
               LOG_BIMAGE = '*N';
            endif;
            if (i_aImage <> *NULL); // *ADD, *CHANGE, *COPY
               LOG_AIMAGE = %subst(aImage: 1: i_size);
            else;
               LOG_AIMAGE = '*N';
            endif;
            write FEXIT04LOG;
         on-error;
         endmon;

         close EXIT04LOG;

      /END-FREE
      *
     P main            E
      *
