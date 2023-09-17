/* =================================================================== */                 /* RADD */
/*                                                                     */                 /* RADD */
/*  Kurzdokumentation :                                                */                 /* RADD */
/*                                                                     */                 /* RADD */
/*  Bereich . . . : CRTMSGDS                                           */                 /* RADD */
/*  Objekt  . . . : CRTMSGDS                                           */                 /* RADD */
/*  Beschreibung  : Tool: CRTMSGDS   (Create Message DS  ) Eng         */                 /* RADD */
/*  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      */                 /* RADD */
/*  Datum . . . . : 01.06.2002                                         */                 /* RADD */
/*                                                                     */                 /* RADD */
/* =================================================================== */                 /* RADD */
/*                                                                     */                 /* RADD */
/*  This software is free software, you can redistribute it and/or     */                 /* RADD */
/*  modify it under the terms of the GNU General Public License (GPL)  */                 /* RADD */
/*  as published by the Free Software Foundation.                      */                 /* RADD */
/*                                                                     */                 /* RADD */
/*  See GNU General Public License for details.                        */                 /* RADD */
/*          http://www.opensource.org                                  */                 /* RADD */
/*          http://www.opensource.org/licenses/gpl-license.html        */                 /* RADD */
/*                                                                     */                 /* RADD */
/* =================================================================== */                 /* RADD */
/*  History:                                                           */                 /* RADD */
/*                                                                     */                 /* RADD */
/*  Datum       Name          Änderung                                 */                 /* RADD */
/*  ----------  ------------  ---------------------------------------  */                 /* RADD */
/*                                                                     */                 /* RADD */
/* =================================================================== */                 /* RADD */
/* >>PRE-COMPILER<<                                                    */                 /* RADD */
/*                                                                     */                 /* RADD */
/*   >>CRTCMD<< CRTCMD       CMD(&LI/&OB) +                            */                 /* RADD */
/*                           SRCFILE(&SL/&SF) +                        */                 /* RADD */
/*                           SRCMBR(&SM);                              */                 /* RADD */
/*                                                                     */                 /* RADD */
/*   >>COMPILE<<                                                       */                 /* RADD */
/*     >>PARM<< PGM(*LIBL/CRTMSGDSC);                                  */                 /* RADD */
/*     >>PARM<< HLPPNLGRP(*LIBL/CRTMSGDSPE);                           */                 /* RADD */
/*     >>PARM<< HLPID(CRTMSGDS);                                       */                 /* RADD */
/*     >>PARM<< PRDLIB(&LI);                                           */                 /* RADD */
/*   >>END-COMPILE<<                                                   */                 /* RADD */
/*                                                                     */                 /* RADD */
/*   >>EXECUTE<<                                                       */                 /* RADD */
/*                                                                     */                 /* RADD */
/* >>END-PRE-COMPILER<<                                                */                 /* RADD */
/* =================================================================== */                 /* RADD */

             CMD        PROMPT('Create Message Data Structure')                           /* RADD */

             PARM       KWD(RANGE)                                  +
                          TYPE(QMSGR)                               +
                          SNGVAL(                                   +
                            (*ALL ))                                +
                          PROMPT('Range of message identifiers')                          /* RADD */

             PARM       KWD(MSGF)                                   +
                          TYPE(QMSGF)                               +
                          CHOICE(*NONE)                             +
                          PROMPT('Message file')                                          /* RADD */

             PARM       KWD(FILE)                                   +
                          TYPE(QCPYF)                               +
                          PROMPT('File')                                                  /* RADD */

             PARM       KWD(MBR)                                    +
                          TYPE(*NAME)                               +
                          DFT(*GEN)                                 +
                          SPCVAL((*GEN))                            +
                          PROMPT('Member')                                                /* RADD */

             PARM       KWD(REPLACE)                                +
                          TYPE(*CHAR)                               +
                          LEN(1)                                    +
                          RSTD(*YES)                                +
                          DFT(*NO)                                  +
                          SPCVAL((*NO     N)                        +
                                 (*YES    Y))                       +
                          MIN(0)                                    +
                          PROMPT('Replace member')                                        /* RADD */

             PARM       KWD(TYPE)                                   +
                          TYPE(*CHAR)                               +
                          LEN(1)                                    +
                          RSTD(*YES)                                +
                          DFT(*ILERPG)                              +
                          SPCVAL(                                   +
                                 (*ILERPG 4)                        +
                                 (*RPG    3)                        +
                                 (*C      5)                        +
                                 (*CLP    1)                        +
                                 (*CLLE   6)                        +
                                 (*SCRIPT 2)                        +
                                            )                       +
                          MIN(0)                                    +
                          PROMPT('Source type')                                       /* RADD */

             PARM       KWD(DEFINE)                                 +
                          TYPE(*CHAR)                               +
                          LEN(1)                                    +
                          RSTD(*YES)                                +
                          DFT(*NO )                                 +
                          SPCVAL((*YES    1)                        +
                                 (*NO     0))                       +
                          MIN(0)                                    +
                          PMTCTL(PMTCTL1)                           +
                          PROMPT('Create DEFINE specifications')                          /* RADD */
                                                                                          /* RADD */
             PARM       KWD(MSGFLNG   ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          CONSTANT(CRTMSGDSE)                                             /* RADD */

QMSGF:       QUAL       TYPE(*NAME)                                 +
                          LEN(10)                                   +
                          DFT(QCPFMSG)                              +
                          EXPR(*YES)
             QUAL       TYPE(*NAME)                                 +
                          LEN(10)                                   +
                          DFT(*LIBL)                                +
                          SPCVAL((*LIBL    )                        +
                                 (*CURLIB  ))                       +
                          EXPR(*YES)                                +
                          PROMPT('Library')                                               /* RADD */

QCPYF:       QUAL       TYPE(*NAME)                                 +
                          LEN(10)                                   +
                          DFT(QCOPYLE)                              +
                          EXPR(*YES)                                                      /* RADD */
             QUAL       TYPE(*NAME)                                 +
                          LEN(10)                                   +
                          DFT(*LIBL)                                +
                          SPCVAL((*LIBL    )                        +
                                 (*CURLIB  ))                       +
                          EXPR(*YES)                                +
                          PROMPT('Library')                                               /* RADD */

QMSGR:       ELEM       TYPE(*NAME)                                 +
                          LEN(7)                                    +
                          DFT(*FIRST)                               +
                          SPCVAL((*FIRST   ))                       +
                          FULL(*YES)                                +
                          EXPR(*YES)                                +
                          PROMPT('Lower value')                                           /* RADD */
             ELEM       TYPE(*NAME)                                 +
                          LEN(7)                                    +
                          DFT(*ONLY)                                +
                          SPCVAL((*ONLY    )                        +
                                 (*LAST    ))                       +
                          FULL(*YES)                                +
                          EXPR(*YES)                                +
                          PROMPT('Upper value')                                           /* RADD */

 /* Einblenden DEFINE         */
 PMTCTL1:    PMTCTL     CTL(TYPE)                                   +
                          COND((*EQ 4)                              +
                               (*EQ 5))                             +
                          NBRTRUE(*EQ 1)                                                  /* RADD */

