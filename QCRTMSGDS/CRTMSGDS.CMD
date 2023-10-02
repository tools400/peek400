/* =================================================================== */
/*                                                                     */
/*  Kurzdokumentation :                                                */
/*                                                                     */
/*  Bereich . . . : CRTMSGDS                                           */
/*  Objekt  . . . : CRTMSGDS                                           */
/*  Beschreibung  : Tool: CRTMSGDS   (Create Message DS  ) Ger         */
/*  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      */
/*  Datum . . . . : ?                                                  */
/*                                                                     */
/* =================================================================== */
/*                                                                     */
/*  This software is free software, you can redistribute it and/or     */
/*  modify it under the terms of the GNU General Public License (GPL)  */
/*  as published by the Free Software Foundation.                      */
/*                                                                     */
/*  See GNU General Public License for details.                        */
/*          http://www.opensource.org                                  */
/*          http://www.opensource.org/licenses/gpl-license.html        */
/*                                                                     */
/* =================================================================== */
/*  History:                                                           */
/*                                                                     */
/*  Datum       Name          Änderung                                 */
/*  ----------  ------------  ---------------------------------------  */
/*                                                                     */
/* =================================================================== */
/* >>PRE-COMPILER<<                                                    */
/*                                                                     */
/*   >>CRTCMD<< CRTCMD       CMD(&LI/&OB) +                            */
/*                           SRCFILE(&SL/&SF) +                        */
/*                           SRCMBR(&SM);                              */
/*                                                                     */
/*   >>COMPILE<<                                                       */
/*     >>PARM<< PGM(*LIBL/CRTMSGDSC);                                  */
/*     >>PARM<< HLPPNLGRP(*LIBL/CRTMSGDSP);                            */
/*     >>PARM<< HLPID(CRTMSGDS);                                       */
/*     >>PARM<< PRDLIB(&LI);                                           */
/*   >>END-COMPILE<<                                                   */
/*                                                                     */
/*   >>EXECUTE<<                                                       */
/*                                                                     */
/* >>END-PRE-COMPILER<<                                                */
/* =================================================================== */

             CMD        PROMPT('Nachrichten-DS erstellen')

             PARM       KWD(RANGE)                                  +
                          TYPE(QMSGR)                               +
                          SNGVAL(                                   +
                            (*ALL ))                                +
                          PROMPT('Bereich der Nachrichten-IDs')

             PARM       KWD(MSGF)                                   +
                          TYPE(QMSGF)                               +
                          CHOICE(*NONE)                             +
                          PROMPT('Nachrichtendatei')

             PARM       KWD(FILE)                                   +
                          TYPE(QCPYF)                               +
                          PROMPT('Datei')

             PARM       KWD(MBR)                                    +
                          TYPE(*NAME)                               +
                          DFT(*GEN)                                 +
                          SPCVAL((*GEN))                            +
                          PROMPT('Teildatei')

             PARM       KWD(REPLACE)                                +
                          TYPE(*CHAR)                               +
                          LEN(1)                                    +
                          RSTD(*YES)                                +
                          DFT(*NO)                                  +
                          SPCVAL((*NO     N)                        +
                                 (*YES    Y))                       +
                          MIN(0)                                    +
                          PROMPT('Bestehende Teildatei ersetzen')

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
                          PROMPT('Zu generierende Sourceart')

             PARM       KWD(DEFINE)                                 +
                          TYPE(*CHAR)                               +
                          LEN(1)                                    +
                          RSTD(*YES)                                +
                          DFT(*NO )                                 +
                          SPCVAL((*YES    1)                        +
                                 (*NO     0))                       +
                          MIN(0)                                    +
                          PMTCTL(PMTCTL1)                           +
                          PROMPT('DEFINE-Bestimmungen generieren')

             PARM       KWD(MSGFLNG   ) TYPE(*CHAR)        +
                          LEN(10)                          +
                          CONSTANT(CRTMSGDS )

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
                          PROMPT('Bibliothek')

QCPYF:       QUAL       TYPE(*NAME)                                 +
                          LEN(10)                                   +
                          DFT(QCOPYLE)                              +
                          EXPR(*YES)
             QUAL       TYPE(*NAME)                                 +
                          LEN(10)                                   +
                          DFT(*LIBL)                                +
                          SPCVAL((*LIBL    )                        +
                                 (*CURLIB  ))                       +
                          EXPR(*YES) PROMPT('Bibliothek')

QMSGR:       ELEM       TYPE(*NAME)                                 +
                          LEN(7)                                    +
                          DFT(*FIRST)                               +
                          SPCVAL((*FIRST   ))                       +
                          FULL(*YES)                                +
                          EXPR(*YES)                                +
                          PROMPT('Unterer Wert')
             ELEM       TYPE(*NAME)                                 +
                          LEN(7)                                    +
                          DFT(*ONLY)                                +
                          SPCVAL((*ONLY    )                        +
                                 (*LAST    ))                       +
                          FULL(*YES)                                +
                          EXPR(*YES)                                +
                          PROMPT('Oberer Wert')

 /* Einblenden DEFINE         */
 PMTCTL1:    PMTCTL     CTL(TYPE)                                   +
                          COND((*EQ 4)                              +
                               (*EQ 5))                             +
                          NBRTRUE(*EQ 1)

