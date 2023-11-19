000100000000**free
000200000000/if not defined(SDS)
000300000000/define SDS
000400000000
000500000000dcl-ds sds qualified psds;
000600000000  pgmName         char(10)   pos(1);
000700000000  pgmStat         zoned(5)   pos(11);
000800000000  prevStat        zoned(5)   pos(16);
000900000000  lastSeq         char(8)    pos(21);
001000000000  lastSubr        char(8)    pos(29);
001100000000  nbrParm         zoned(3)   pos(37);
001200000000  excType         char(3)    pos(40);
001300000000  excNbr          char(4)    pos(43);
001400000000  miInstruction   char(4)    pos(47);
001500000000  workArea        char(30)   pos(51);
001600000000  /if defined(SDS_EXTENDED)
001700000000  pgmLib          char(10)   pos(81);
001800000000  excData         char(80)   pos(91);
001900000000  rnx9001Exc      char(4)    pos(171);
002000000000  lastFileLong    char(10)   pos(175);
002100000000  unused_1        char(6)    pos(185);
002200000000  datFmt          char(8)    pos(191);
002300000000  year            zoned(2:0) pos(199);
002400000000  lastFileShort   char(8)    pos(201);
002500000000  fileStat        char(35)   pos(209);
002600000000  job             char(10)   pos(244);
002700000000  user            char(10)   pos(254);
002800000000  nbr             zoned(6:0) pos(264);
002900000000  startDate       zoned(6:0) pos(270);
003000000000  runDate         zoned(6:0) pos(276);
003100000000  runTime         zoned(6:0) pos(282);
003200000000  compDate        char(6)    pos(288);
003300000000  compTime        char(10)   pos(294);
003400000000  compLevel       char(4)    pos(300);
003500000000  srcFile         char(10)   pos(304);
003600000000  srcLib          char(10)   pos(314);
003700000000  srcMbr          char(10)   pos(324);
003800000000  pgmContProc     char(10)   pos(334);
003900000000  modContProc     char(10)   pos(344);
004000000000  sourceID1       int(5)     pos(354);
004100000000  sourceID2       int(5)     pos(356);
004200000000  currUser        char(10)   pos(358);
004300000000  extErrCode      int(10)    pos(368);
004400000000  xmlElem_INTO    int(20)    pos(372); // Since 5.4
004500000000  intJobID        char(16)   pos(380); // Since 7.3
004600000000  sysName         char(6)    pos(396);
004700000000  unused          char(50)   pos(404);
004800000000end-ds;
004900000000/endif
005000000000/endif
