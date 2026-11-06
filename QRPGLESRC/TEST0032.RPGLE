**free
//===============================================================*
//                                                               *
//  erstellt : 27.03.2012                                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Rahmentestprogramm mit Protokollausgabe                      *
//  Thema:                                                       *
//     Test: GRAPHIC Felder                                      *
//                                                               *
//===============================================================*
// >>PRE-COMPILER<<                                              *
//                                                               *
//   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                   *
//                           SRCFILE(&SL/&SF) +                  *
//                           SRCMBR(&SM);                        *
//                                                               *
//   >>COMPILE<<                                                 *
//     >>PARM<< TRUNCNBR(*NO);                                   *
//     >>PARM<< DBGVIEW(*LIST);                                  *
//     >>PARM<< ALWNULL(*USRCTL);                                *
//   >>END-COMPILE<<                                             *
//                                                               *
//   >>EXECUTE<<                                                 *
//                                                               *
//   >>CMD<<    CRTPGM       PGM(&LI/&OB) +                      *
//                           MODULE(&LI/&OB          +           *
//                                          ) +                  *
//                           BNDSRVPGM(*LIBL/BASICS1      +      *
//                                     *LIBL/PRTLOG       +      *
//                                          ) +                  *
//                           BNDDIR(*LIBL/QC2LE) +               *
//                           DETAIL(*BASIC) +                    *
//                           ACTGRP(*NEW);                       *
//                                                               *
// >>END-PRE-COMPILER<<                                          *
//===============================================================*
ctl-opt debug option(*srcstmt: *nodebugio);
ctl-opt decedit('0,') datedit(*DMY.);
ctl-opt datfmt(*iso) timfmt(*iso);
ctl-opt expropts(*resdecpos);
ctl-opt extbinint(*yes);
//===============================================================*
dcl-f TEST0032FM workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn qualified;
  status zoned(5) pos(11);
  Offset int(5) pos(241);
  AID    char(1) pos(369);
  csrPos int(5);
end-ds;

/copy QCOPYLE,D_WORKSTN

// ------------------------------------
//  Type definitions
// ------------------------------------
//
// ------------------------------------
//  External Prototypes
// ------------------------------------
//
// ------------------------------------
//  Global Fields
// ------------------------------------
//
// ------------------------------------
//  Globale Konstanten
// ------------------------------------
//
// ------------------------------------
//  Prototypes
// ------------------------------------

dcl-pr PGM_ENTRY_POINT extpgm('TEST0032');
end-pr;

dcl-pr main extproc('main');
end-pr;

//===============================================================*
//  Program Entry Point
//===============================================================*
dcl-pi PGM_ENTRY_POINT;
end-pi;

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main();

*inlr = *on;

return;


//===============================================================*
//  Main procedure
//===============================================================*
dcl-proc main;
  dcl-pi *n;
  end-pi;
  // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  open TEST0032FM;

  dow ('1');

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


end-proc main;

