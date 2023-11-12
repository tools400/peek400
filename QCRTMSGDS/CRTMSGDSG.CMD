000100000000/* =================================================================== */
000200000000/*                                                                     */
000300000000/*  Kurzdokumentation :                                                */
000400000000/*                                                                     */
000500000000/*  Bereich . . . : CRTMSGDS                                           */
000600000000/*  Objekt  . . . : CRTMSGDS                                           */
000700000000/*  Beschreibung  : Create Message Data Structure - Ger                */
000800000000/*  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      */
000900000000/*  Datum . . . . : ?                                                  */
001000000000/*                                                                     */
001100000000/* =================================================================== */
001200000000/*                                                                     */
001300000000/*  This software is free software, you can redistribute it and/or     */
001400000000/*  modify it under the terms of the GNU General Public License (GPL)  */
001500000000/*  as published by the Free Software Foundation.                      */
001600000000/*                                                                     */
001700000000/*  See GNU General Public License for details.                        */
001800000000/*          http://www.opensource.org                                  */
001900000000/*          http://www.opensource.org/licenses/gpl-license.html        */
002000000000/*                                                                     */
002100000000/* =================================================================== */
002200000000/*  History:                                                           */
002300000000/*                                                                     */
002400000000/*  Datum       Name          Änderung                                 */
002500000000/*  ----------  ------------  ---------------------------------------  */
002600000000/*                                                                     */
002700000000/* =================================================================== */
002800000000/* >>PRE-COMPILER<<                                                    */
002900000000/*                                                                     */
003000000000/*   >>CRTCMD<< CRTCMD       CMD(&LI/CRTMSGDS) +                       */
003100000000/*                           SRCFILE(&SL/&SF) +                        */
003200000000/*                           SRCMBR(&SM);                              */
003300000000/*                                                                     */
003400000000/*   >>COMPILE<<                                                       */
003500000000/*     >>PARM<< PGM(&LI/CRTMSGDSC);                                    */
003600000000/*     >>PARM<< HLPPNLGRP(&LI/CRTMSGDSP);                              */
003700000000/*     >>PARM<< HLPID(CRTMSGDS);                                       */
003800000000/*   >>END-COMPILE<<                                                   */
003900000000/*                                                                     */
004000000000/*   >>EXECUTE<<                                                       */
004100000000/*                                                                     */
004200000000/* >>END-PRE-COMPILER<<                                                */
004300000000/* =================================================================== */
004400000000
004500000000             CMD        PROMPT('Nachrichten-DS erstellen')
004600000000
004700000000             PARM       KWD(RANGE)                                  +
004800000000                          TYPE(QMSGR)                               +
004900000000                          SNGVAL(                                   +
005000000000                            (*ALL ))                                +
005100000000                          PROMPT('Bereich der Nachrichten-IDs')
005200000000
005300000000             PARM       KWD(MSGF)                                   +
005400000000                          TYPE(QMSGF)                               +
005500000000                          CHOICE(*NONE)                             +
005600000000                          PROMPT('Nachrichtendatei')
005700000000
005800000000             PARM       KWD(FILE)                                   +
005900000000                          TYPE(QCPYF)                               +
006000000000                          PROMPT('Datei')
006100000000
006200000000             PARM       KWD(MBR)                                    +
006300000000                          TYPE(*NAME)                               +
006400000000                          DFT(*GEN)                                 +
006500000000                          SPCVAL((*GEN))                            +
006600000000                          PROMPT('Teildatei')
006700000000
006800000000             PARM       KWD(REPLACE)                                +
006900000000                          TYPE(*CHAR)                               +
007000000000                          LEN(1)                                    +
007100000000                          RSTD(*YES)                                +
007200000000                          DFT(*NO)                                  +
007300000000                          SPCVAL((*NO     N)                        +
007400000000                                 (*YES    Y))                       +
007500000000                          MIN(0)                                    +
007600000000                          PROMPT('Bestehende Teildatei ersetzen')
007700000000
007800000000             PARM       KWD(TYPE)                                   +
007900000000                          TYPE(*CHAR)                               +
008000000000                          LEN(1)                                    +
008100000000                          RSTD(*YES)                                +
008200000000                          DFT(*ILERPG)                              +
008300000000                          SPCVAL(                                   +
008400000000                                 (*FREE   7)                        +
008500000000                                 (*ILERPG 4)                        +
008600000000                                 (*RPG    3)                        +
008700000000                                 (*C      5)                        +
008800000000                                 (*CLP    1)                        +
008900000000                                 (*CLLE   6)                        +
009000000000                                 (*SCRIPT 2)                        +
009100000000                                            )                       +
009200000000                          MIN(0)                                    +
009300000000                          PROMPT('Zu generierende Sourceart')
009400000000
009500000000             PARM       KWD(DEFINE)                                 +
009600000000                          TYPE(*CHAR)                               +
009700000000                          LEN(1)                                    +
009800000000                          RSTD(*YES)                                +
009900000000                          DFT(*NO )                                 +
010000000000                          SPCVAL((*YES    1)                        +
010100000000                                 (*NO     0))                       +
010200000000                          MIN(0)                                    +
010300000000                          PMTCTL(PMTCTL1)                           +
010400000000                          PROMPT('DEFINE-Bestimmungen generieren')
010500000000
010600000000             PARM       KWD(CRTMSGF)                                +
010700000000                          TYPE(*CHAR)                               +
010800000000                          LEN(1)                                    +
010900000000                          RSTD(*YES)                                +
011000000000                          DFT(*NO )                                 +
011100000000                          SPCVAL((*YES    1)                        +
011200000000                                 (*NO     0))                       +
011300000000                          MIN(0)                                    +
011400000000                          PMTCTL(PMTCTL2)                           +
011500000000                          PROMPT('CRTMSGF-Befehl generieren')
011600000000
011700000000QMSGF:       QUAL       TYPE(*NAME)                                 +
011800000000                          LEN(10)                                   +
011900000000                          DFT(QCPFMSG)                              +
012000000000                          EXPR(*YES)
012100000000             QUAL       TYPE(*NAME)                                 +
012200000000                          LEN(10)                                   +
012300000000                          DFT(*LIBL)                                +
012400000000                          SPCVAL((*LIBL    )                        +
012500000000                                 (*CURLIB  ))                       +
012600000000                          EXPR(*YES)                                +
012700000000                          PROMPT('Bibliothek')
012800000000
012900000000QCPYF:       QUAL       TYPE(*NAME)                                 +
013000000000                          LEN(10)                                   +
013100000000                          DFT(QCOPYLE)                              +
013200000000                          EXPR(*YES)
013300000000             QUAL       TYPE(*NAME)                                 +
013400000000                          LEN(10)                                   +
013500000000                          DFT(*LIBL)                                +
013600000000                          SPCVAL((*LIBL    )                        +
013700000000                                 (*CURLIB  ))                       +
013800000000                          EXPR(*YES) PROMPT('Bibliothek')
013900000000
014000000000QMSGR:       ELEM       TYPE(*NAME)                                 +
014100000000                          LEN(7)                                    +
014200000000                          DFT(*FIRST)                               +
014300000000                          SPCVAL((*FIRST   ))                       +
014400000000                          FULL(*YES)                                +
014500000000                          EXPR(*YES)                                +
014600000000                          PROMPT('Unterer Wert')
014700000000             ELEM       TYPE(*NAME)                                 +
014800000000                          LEN(7)                                    +
014900000000                          DFT(*ONLY)                                +
015000000000                          SPCVAL((*ONLY    )                        +
015100000000                                 (*LAST    ))                       +
015200000000                          FULL(*YES)                                +
015300000000                          EXPR(*YES)                                +
015400000000                          PROMPT('Oberer Wert')
015500000000
015600000000 /* Einblenden DEFINE         */
015700000000 PMTCTL1:    PMTCTL     CTL(TYPE)                                   +
015800000000                          COND((*EQ 4)                              +
015900000000                               (*EQ 5))                             +
016000000000                          NBRTRUE(*EQ 1)
016100000000
016200000000/* Einblenden CRTMSGF        */
016300000000 PMTCTL2:    PMTCTL     CTL(TYPE)                                   +
016400000000                          COND((*EQ 1)                              +
016500000000                               (*EQ 6))                             +
016600000000                          NBRTRUE(*EQ 1)
016700000000
