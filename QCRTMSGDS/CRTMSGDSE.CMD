000100231110/* =================================================================== */
000200231110/*                                                                     */
000300231110/*  Kurzdokumentation :                                                */
000400231110/*                                                                     */
000500231110/*  Bereich . . . : CRTMSGDS                                           */
000600231110/*  Objekt  . . . : CRTMSGDS                                           */
000700231110/*  Beschreibung  : Tool: CRTMSGDS   (Create Message DS  ) Eng         */
000800231110/*  Author  . . . : Thomas Raddatz   <thomas.raddatz@tools400.de>      */
000900231110/*  Datum . . . . : 01.06.2002                                         */
001000231110/*                                                                     */
001100231110/* =================================================================== */
001200231110/*                                                                     */
001300231110/*  This software is free software, you can redistribute it and/or     */
001400231110/*  modify it under the terms of the GNU General Public License (GPL)  */
001500231110/*  as published by the Free Software Foundation.                      */
001600231110/*                                                                     */
001700231110/*  See GNU General Public License for details.                        */
001800231110/*          http://www.opensource.org                                  */
001900231110/*          http://www.opensource.org/licenses/gpl-license.html        */
002000231110/*                                                                     */
002100231110/* =================================================================== */
002200231110/*  History:                                                           */
002300231110/*                                                                     */
002400231110/*  Datum       Name          Änderung                                 */
002500231110/*  ----------  ------------  ---------------------------------------  */
002600231110/*                                                                     */
002700231110/* =================================================================== */
002800231110/* >>PRE-COMPILER<<                                                    */
002900231110/*                                                                     */
003000231110/*   >>CRTCMD<< CRTCMD       CMD(&LI/&OB) +                            */
003100231110/*                           SRCFILE(&SL/&SF) +                        */
003200231110/*                           SRCMBR(&SM);                              */
003300231110/*                                                                     */
003400231110/*   >>COMPILE<<                                                       */
003500231110/*     >>PARM<< PGM(*LIBL/CRTMSGDSC);                                  */
003600231110/*     >>PARM<< HLPPNLGRP(*LIBL/CRTMSGDSPE);                           */
003700231110/*     >>PARM<< HLPID(CRTMSGDS);                                       */
003800231110/*     >>PARM<< PRDLIB(&LI);                                           */
003900231110/*   >>END-COMPILE<<                                                   */
004000231110/*                                                                     */
004100231110/*   >>EXECUTE<<                                                       */
004200231110/*                                                                     */
004300231110/* >>END-PRE-COMPILER<<                                                */
004400231110/* =================================================================== */
004500231110
004600231110             CMD        PROMPT('Create Message Data Structure')
004700231110
004800231110             PARM       KWD(RANGE)                                  +
004900231110                          TYPE(QMSGR)                               +
005000231110                          SNGVAL(                                   +
005100231110                            (*ALL ))                                +
005200231110                          PROMPT('Range of message identifiers')
005300231110
005400231110             PARM       KWD(MSGF)                                   +
005500231110                          TYPE(QMSGF)                               +
005600231110                          CHOICE(*NONE)                             +
005700231110                          PROMPT('Message file')
005800231110
005900231110             PARM       KWD(FILE)                                   +
006000231110                          TYPE(QCPYF)                               +
006100231110                          PROMPT('File')
006200231110
006300231110             PARM       KWD(MBR)                                    +
006400231110                          TYPE(*NAME)                               +
006500231110                          DFT(*GEN)                                 +
006600231110                          SPCVAL((*GEN))                            +
006700231110                          PROMPT('Member')
006800231110
006900231110             PARM       KWD(REPLACE)                                +
007000231110                          TYPE(*CHAR)                               +
007100231110                          LEN(1)                                    +
007200231110                          RSTD(*YES)                                +
007300231110                          DFT(*NO)                                  +
007400231110                          SPCVAL((*NO     N)                        +
007500231110                                 (*YES    Y))                       +
007600231110                          MIN(0)                                    +
007700231110                          PROMPT('Replace member')
007800231110
007900231110             PARM       KWD(TYPE)                                   +
008000231110                          TYPE(*CHAR)                               +
008100231110                          LEN(1)                                    +
008200231110                          RSTD(*YES)                                +
008300231110                          DFT(*ILERPG)                              +
008400231110                          SPCVAL(                                   +
008500231110                                 (*ILERPG 4)                        +
008600231110                                 (*RPG    3)                        +
008700231110                                 (*C      5)                        +
008800231110                                 (*CLP    1)                        +
008900231110                                 (*CLLE   6)                        +
009000231110                                 (*SCRIPT 2)                        +
009100231110                                            )                       +
009200231110                          MIN(0)                                    +
009300231110                          PROMPT('Source type')
009400231110
009500231110             PARM       KWD(DEFINE)                                 +
009600231110                          TYPE(*CHAR)                               +
009700231110                          LEN(1)                                    +
009800231110                          RSTD(*YES)                                +
009900231110                          DFT(*NO )                                 +
010000231110                          SPCVAL((*YES    1)                        +
010100231110                                 (*NO     0))                       +
010200231110                          MIN(0)                                    +
010300231110                          PMTCTL(PMTCTL1)                           +
010400231110                          PROMPT('Create DEFINE specifications')
010500231110
010600231110             PARM       KWD(MSGFLNG   ) TYPE(*CHAR)        +
010700231110                          LEN(10)                          +
010800231110                          CONSTANT(CRTMSGDSE)
010900231110
011000231110QMSGF:       QUAL       TYPE(*NAME)                                 +
011100231110                          LEN(10)                                   +
011200231110                          DFT(QCPFMSG)                              +
011300231110                          EXPR(*YES)
011400231110             QUAL       TYPE(*NAME)                                 +
011500231110                          LEN(10)                                   +
011600231110                          DFT(*LIBL)                                +
011700231110                          SPCVAL((*LIBL    )                        +
011800231110                                 (*CURLIB  ))                       +
011900231110                          EXPR(*YES)                                +
012000231110                          PROMPT('Library')
012100231110
012200231110QCPYF:       QUAL       TYPE(*NAME)                                 +
012300231110                          LEN(10)                                   +
012400231110                          DFT(QCOPYLE)                              +
012500231110                          EXPR(*YES)
012600231110             QUAL       TYPE(*NAME)                                 +
012700231110                          LEN(10)                                   +
012800231110                          DFT(*LIBL)                                +
012900231110                          SPCVAL((*LIBL    )                        +
013000231110                                 (*CURLIB  ))                       +
013100231110                          EXPR(*YES)                                +
013200231110                          PROMPT('Library')
013300231110
013400231110QMSGR:       ELEM       TYPE(*NAME)                                 +
013500231110                          LEN(7)                                    +
013600231110                          DFT(*FIRST)                               +
013700231110                          SPCVAL((*FIRST   ))                       +
013800231110                          FULL(*YES)                                +
013900231110                          EXPR(*YES)                                +
014000231110                          PROMPT('Lower value')
014100231110             ELEM       TYPE(*NAME)                                 +
014200231110                          LEN(7)                                    +
014300231110                          DFT(*ONLY)                                +
014400231110                          SPCVAL((*ONLY    )                        +
014500231110                                 (*LAST    ))                       +
014600231110                          FULL(*YES)                                +
014700231110                          EXPR(*YES)                                +
014800231110                          PROMPT('Upper value')
014900231110
015000231110 /* Einblenden DEFINE         */
015100231110 PMTCTL1:    PMTCTL     CTL(TYPE)                                   +
015200231110                          COND((*EQ 4)                              +
015300231110                               (*EQ 5))                             +
015400231110                          NBRTRUE(*EQ 1)
015500231110
