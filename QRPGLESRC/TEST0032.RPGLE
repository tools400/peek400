      *===============================================================*
      *                                                               *
      *  erstellt : 27.03.2012                                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Rahmentestprogramm mit Protokollausgabe                      *
      *  Thema:                                                       *
      *     Test: GRAPHIC Felder                                      *
      *                                                               *
      *===============================================================*
      * >>PRE-COMPILER<<                                              *
      *                                                               *
      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                   *
      *                           SRCFILE(&SL/&SF) +                  *
      *                           SRCMBR(&SM);                        *
      *                                                               *
      *   >>COMPILE<<                                                 *
      *     >>PARM<< TRUNCNBR(*NO);                                   *
      *     >>PARM<< DBGVIEW(*LIST);                                  *
      *     >>PARM<< ALWNULL(*USRCTL);                                *
      *   >>END-COMPILE<<                                             *
      *                                                               *
      *   >>EXECUTE<<                                                 *
      *                                                               *
      *   >>CMD<<    CRTPGM       PGM(&LI/&OB) +                      *
      *                           MODULE(&LI/&OB          +           *
      *                                          ) +                  *
      *                           BNDSRVPGM(*LIBL/BASICS1      +      *
      *                                     *LIBL/PRTLOG       +      *
      *                                          ) +                  *
      *                           BNDDIR(*LIBL/QC2LE) +               *
      *                           DETAIL(*BASIC) +                    *
      *                           ACTGRP(*NEW);                       *
      *                                                               *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
     H DEBUG
     H OPTION(*SRCSTMT : *NODEBUGIO)
     H DECEDIT('0,') DATEDIT(*DMY.)
     H DATFMT(*ISO )  TIMFMT(*ISO )
     H EXPROPTS(*RESDECPOS)
     H EXTBININT(*YES)
      *===============================================================*
     FTEST0032FMCF   E             WORKSTN usropn
     F                                     infds(workStn)
      *
     D workstn         DS                  qualified
     D  status                11     15S 0
     D  offset               241    242I 0
     D  AID                  369    369A
     D  csrPos               370    371I 0
      *
      /COPY QCOPYLE,DS_WORKSTN
      *
      * ------------------------------------
      *  Type definitions
      * ------------------------------------
      *
      * ------------------------------------
      *  External Prototypes
      * ------------------------------------
      *
      * ------------------------------------
      *  Global Fields
      * ------------------------------------
      *
      * ------------------------------------
      *  Globale Konstanten
      * ------------------------------------
      *
      * ------------------------------------
      *  Prototypes
      * ------------------------------------
      *
     D PGM_ENTRY_POINT...
     D                 PR                  extpgm('TEST0032')
      *
     D main...
     D                 PR                         extproc('main')
      *
      *===============================================================*
      *  Program Entry Point
      *===============================================================*
     D PGM_ENTRY_POINT...
     D                 PI
      *
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         main();

         *inlr = *on;

         return;

      /END-FREE
      *
      *===============================================================*
      *  Main procedure
      *===============================================================*
     P main...
     P                 B
      *
     D main...
     D                 PI
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         open TEST0032FM;

         dow '1';

            exfmt SCREEN01;

            select;
            when (workstn.AID = K_ENTER);
               leave;
            when (workstn.AID = K_F3);
               leave;
            when (workstn.AID = K_F12);
               leave;
            endsl;

         enddo;

         if (%open(TEST0032FM));
            close TEST0032FM;
         endif;

         return;

      /END-FREE
      *
     P main...
     P                 E
      *
