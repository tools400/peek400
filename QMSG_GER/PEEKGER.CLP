000100000000     /*-----------------------------------------------------------------------*/
000200000000     /* STRPREPRC Compile Options:                                            */
000300000000     /* >>PRE-COMPILER<<                                                      */
000400000000     /*   >>CRTCMD<<  CALL       PGM(QTEMP/&OB) PARM(&LI &OB);                */
000500000000     /*   >>CMD<<     CRTCLPGM   PGM(QTEMP/&OB) +                             */
000600000000     /*                          SRCFILE(&SL/&SF) SRCMBR(&SM) +               */
000700000000     /*               TEXT('Peek/400 - Deutsche Übersetzung');                */
000800000000     /*   >>EXECUTE<<                                                         */
000900000000     /*   >>CMD<<     DLTPGM PGM(QTEMP/&OB);                                  */
001000000000     /* >>END-PRE-COMPILER<<                                                  */
001100000000     /*-----------------------------------------------------------------------*/
001200000000             PGM        PARM(&I_LIB &I_OBJ)
001300000000
001400000000             DCL        VAR(&I_LIB     ) TYPE(*CHAR) LEN(10)
001500000000             DCL        VAR(&I_OBJ     ) TYPE(*CHAR) LEN(10)
001600000000             DCL        VAR(&LIB       ) TYPE(*CHAR) LEN(10)
001700000000             DCL        VAR(&OBJ       ) TYPE(*CHAR) LEN(10)
001800000000
001900000000             CHGVAR     VAR(&LIB       ) VALUE(&I_LIB)
002000000000             MONMSG     MSGID(MCH3601) EXEC(DO)
002100000000               RMVMSG     PGMQ(*SAME (*)) CLEAR(*ALL)
002200000000               SNDPGMMSG  MSGID(CPF9898) MSGF(*LIBL/QCPFMSG) +
002300000000                            MSGDTA('Usage: CALL PGM(PEEKGER) +
002400000000                                    PARM(libName [msgFName)') +
002500000000                            TOPGMQ(*PRV (*PGMBDY)) MSGTYPE(*ESCAPE)
002600000000             ENDDO
002700000000
002800000000             CHGVAR     VAR(&OBJ       ) VALUE(&I_OBJ)
002900000000             MONMSG     MSGID(MCH3601) EXEC(DO)
003000000000               RMVMSG     PGMQ(*SAME (*)) CLEAR(*ALL)
003100000000               CHGVAR     VAR(&OBJ) VALUE('PEEKGER   ')
003200000000             ENDDO
003300000000
003400000000     /*-------------------------------------------------------------*/
003500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BA                    */
003600000000     /* Funktionstaste F22 nicht gültig.                            */
003700000000     /*-------------------------------------------------------------*/
003800000000
003900000000             RMVMSGD MSGID(AID00BA) MSGF(&LIB/&OBJ)
004000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004100000000
004200000000             ADDMSGD +
004300000000                MSGID(AID00BA) +
004400000000                MSGF(&LIB/&OBJ) +
004500000000                MSG( +
004600000000'Funktionstaste F22 nicht gültig.'                                    +
004700000000                ) +
004800000000                SEV(0) +
004900000000     /*   No replacement variables defined!                         */ +
005000000000                ALROPT(*NO) +
005100000000                CCSID(65535) +
005200000000                /*  -EOF-  */
005300000000
005400000000     /*-------------------------------------------------------------*/
005500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BB                    */
005600000000     /* Funktionstaste F23 nicht gültig.                            */
005700000000     /*-------------------------------------------------------------*/
005800000000
005900000000             RMVMSGD MSGID(AID00BB) MSGF(&LIB/&OBJ)
006000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006100000000
006200000000             ADDMSGD +
006300000000                MSGID(AID00BB) +
006400000000                MSGF(&LIB/&OBJ) +
006500000000                MSG( +
006600000000'Funktionstaste F23 nicht gültig.'                                    +
006700000000                ) +
006800000000                SEV(0) +
006900000000     /*   No replacement variables defined!                         */ +
007000000000                ALROPT(*NO) +
007100000000                CCSID(65535) +
007200000000                /*  -EOF-  */
007300000000
007400000000     /*-------------------------------------------------------------*/
007500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BC                    */
007600000000     /* Funktionstaste F24 nicht gültig.                            */
007700000000     /*-------------------------------------------------------------*/
007800000000
007900000000             RMVMSGD MSGID(AID00BC) MSGF(&LIB/&OBJ)
008000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008100000000
008200000000             ADDMSGD +
008300000000                MSGID(AID00BC) +
008400000000                MSGF(&LIB/&OBJ) +
008500000000                MSG( +
008600000000'Funktionstaste F24 nicht gültig.'                                    +
008700000000                ) +
008800000000                SEV(0) +
008900000000     /*   No replacement variables defined!                         */ +
009000000000                ALROPT(*NO) +
009100000000                CCSID(65535) +
009200000000                /*  -EOF-  */
009300000000
009400000000     /*-------------------------------------------------------------*/
009500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BD                    */
009600000000     /* Taste 'LÖSCHEN' nicht gültig                                */
009700000000     /*-------------------------------------------------------------*/
009800000000
009900000000             RMVMSGD MSGID(AID00BD) MSGF(&LIB/&OBJ)
010000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
010100000000
010200000000             ADDMSGD +
010300000000                MSGID(AID00BD) +
010400000000                MSGF(&LIB/&OBJ) +
010500000000                MSG( +
010600000000'Taste ''LÖSCHEN'' nicht gültig'                                      +
010700000000                ) +
010800000000                SEV(0) +
010900000000     /*   No replacement variables defined!                         */ +
011000000000                ALROPT(*NO) +
011100000000                CCSID(65535) +
011200000000                /*  -EOF-  */
011300000000
011400000000     /*-------------------------------------------------------------*/
011500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B1                    */
011600000000     /* Funktionstaste F13 nicht gültig.                            */
011700000000     /*-------------------------------------------------------------*/
011800000000
011900000000             RMVMSGD MSGID(AID00B1) MSGF(&LIB/&OBJ)
012000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
012100000000
012200000000             ADDMSGD +
012300000000                MSGID(AID00B1) +
012400000000                MSGF(&LIB/&OBJ) +
012500000000                MSG( +
012600000000'Funktionstaste F13 nicht gültig.'                                    +
012700000000                ) +
012800000000                SEV(0) +
012900000000     /*   No replacement variables defined!                         */ +
013000000000                ALROPT(*NO) +
013100000000                CCSID(65535) +
013200000000                /*  -EOF-  */
013300000000
013400000000     /*-------------------------------------------------------------*/
013500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B2                    */
013600000000     /* Funktionstaste F14 nicht gültig.                            */
013700000000     /*-------------------------------------------------------------*/
013800000000
013900000000             RMVMSGD MSGID(AID00B2) MSGF(&LIB/&OBJ)
014000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
014100000000
014200000000             ADDMSGD +
014300000000                MSGID(AID00B2) +
014400000000                MSGF(&LIB/&OBJ) +
014500000000                MSG( +
014600000000'Funktionstaste F14 nicht gültig.'                                    +
014700000000                ) +
014800000000                SEV(0) +
014900000000     /*   No replacement variables defined!                         */ +
015000000000                ALROPT(*NO) +
015100000000                CCSID(65535) +
015200000000                /*  -EOF-  */
015300000000
015400000000     /*-------------------------------------------------------------*/
015500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B3                    */
015600000000     /* Funktionstaste F15 nicht gültig.                            */
015700000000     /*-------------------------------------------------------------*/
015800000000
015900000000             RMVMSGD MSGID(AID00B3) MSGF(&LIB/&OBJ)
016000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
016100000000
016200000000             ADDMSGD +
016300000000                MSGID(AID00B3) +
016400000000                MSGF(&LIB/&OBJ) +
016500000000                MSG( +
016600000000'Funktionstaste F15 nicht gültig.'                                    +
016700000000                ) +
016800000000                SEV(0) +
016900000000     /*   No replacement variables defined!                         */ +
017000000000                ALROPT(*NO) +
017100000000                CCSID(65535) +
017200000000                /*  -EOF-  */
017300000000
017400000000     /*-------------------------------------------------------------*/
017500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B4                    */
017600000000     /* Funktionstaste F16 nicht gültig.                            */
017700000000     /*-------------------------------------------------------------*/
017800000000
017900000000             RMVMSGD MSGID(AID00B4) MSGF(&LIB/&OBJ)
018000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
018100000000
018200000000             ADDMSGD +
018300000000                MSGID(AID00B4) +
018400000000                MSGF(&LIB/&OBJ) +
018500000000                MSG( +
018600000000'Funktionstaste F16 nicht gültig.'                                    +
018700000000                ) +
018800000000                SEV(0) +
018900000000     /*   No replacement variables defined!                         */ +
019000000000                ALROPT(*NO) +
019100000000                CCSID(65535) +
019200000000                /*  -EOF-  */
019300000000
019400000000     /*-------------------------------------------------------------*/
019500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B5                    */
019600000000     /* Funktionstaste F17 nicht gültig.                            */
019700000000     /*-------------------------------------------------------------*/
019800000000
019900000000             RMVMSGD MSGID(AID00B5) MSGF(&LIB/&OBJ)
020000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
020100000000
020200000000             ADDMSGD +
020300000000                MSGID(AID00B5) +
020400000000                MSGF(&LIB/&OBJ) +
020500000000                MSG( +
020600000000'Funktionstaste F17 nicht gültig.'                                    +
020700000000                ) +
020800000000                SEV(0) +
020900000000     /*   No replacement variables defined!                         */ +
021000000000                ALROPT(*NO) +
021100000000                CCSID(65535) +
021200000000                /*  -EOF-  */
021300000000
021400000000     /*-------------------------------------------------------------*/
021500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B6                    */
021600000000     /* Funktionstaste F18 nicht gültig.                            */
021700000000     /*-------------------------------------------------------------*/
021800000000
021900000000             RMVMSGD MSGID(AID00B6) MSGF(&LIB/&OBJ)
022000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
022100000000
022200000000             ADDMSGD +
022300000000                MSGID(AID00B6) +
022400000000                MSGF(&LIB/&OBJ) +
022500000000                MSG( +
022600000000'Funktionstaste F18 nicht gültig.'                                    +
022700000000                ) +
022800000000                SEV(0) +
022900000000     /*   No replacement variables defined!                         */ +
023000000000                ALROPT(*NO) +
023100000000                CCSID(65535) +
023200000000                /*  -EOF-  */
023300000000
023400000000     /*-------------------------------------------------------------*/
023500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B7                    */
023600000000     /* Funktionstaste F19 nicht gültig.                            */
023700000000     /*-------------------------------------------------------------*/
023800000000
023900000000             RMVMSGD MSGID(AID00B7) MSGF(&LIB/&OBJ)
024000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
024100000000
024200000000             ADDMSGD +
024300000000                MSGID(AID00B7) +
024400000000                MSGF(&LIB/&OBJ) +
024500000000                MSG( +
024600000000'Funktionstaste F19 nicht gültig.'                                    +
024700000000                ) +
024800000000                SEV(0) +
024900000000     /*   No replacement variables defined!                         */ +
025000000000                ALROPT(*NO) +
025100000000                CCSID(65535) +
025200000000                /*  -EOF-  */
025300000000
025400000000     /*-------------------------------------------------------------*/
025500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B8                    */
025600000000     /* Funktionstaste F20 nicht gültig.                            */
025700000000     /*-------------------------------------------------------------*/
025800000000
025900000000             RMVMSGD MSGID(AID00B8) MSGF(&LIB/&OBJ)
026000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
026100000000
026200000000             ADDMSGD +
026300000000                MSGID(AID00B8) +
026400000000                MSGF(&LIB/&OBJ) +
026500000000                MSG( +
026600000000'Funktionstaste F20 nicht gültig.'                                    +
026700000000                ) +
026800000000                SEV(0) +
026900000000     /*   No replacement variables defined!                         */ +
027000000000                ALROPT(*NO) +
027100000000                CCSID(65535) +
027200000000                /*  -EOF-  */
027300000000
027400000000     /*-------------------------------------------------------------*/
027500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B9                    */
027600000000     /* Funktionstaste F21 nicht gültig.                            */
027700000000     /*-------------------------------------------------------------*/
027800000000
027900000000             RMVMSGD MSGID(AID00B9) MSGF(&LIB/&OBJ)
028000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
028100000000
028200000000             ADDMSGD +
028300000000                MSGID(AID00B9) +
028400000000                MSGF(&LIB/&OBJ) +
028500000000                MSG( +
028600000000'Funktionstaste F21 nicht gültig.'                                    +
028700000000                ) +
028800000000                SEV(0) +
028900000000     /*   No replacement variables defined!                         */ +
029000000000                ALROPT(*NO) +
029100000000                CCSID(65535) +
029200000000                /*  -EOF-  */
029300000000
029400000000     /*-------------------------------------------------------------*/
029500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F1                    */
029600000000     /* Taste 'DATENFREIGABE' nicht gültig                          */
029700000000     /*-------------------------------------------------------------*/
029800000000
029900000000             RMVMSGD MSGID(AID00F1) MSGF(&LIB/&OBJ)
030000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
030100000000
030200000000             ADDMSGD +
030300000000                MSGID(AID00F1) +
030400000000                MSGF(&LIB/&OBJ) +
030500000000                MSG( +
030600000000'Taste ''DATENFREIGABE'' nicht gültig'                                +
030700000000                ) +
030800000000                SEV(0) +
030900000000     /*   No replacement variables defined!                         */ +
031000000000                ALROPT(*NO) +
031100000000                CCSID(65535) +
031200000000                /*  -EOF-  */
031300000000
031400000000     /*-------------------------------------------------------------*/
031500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F3                    */
031600000000     /* Taste 'HILFE' nicht gültig                                  */
031700000000     /*-------------------------------------------------------------*/
031800000000
031900000000             RMVMSGD MSGID(AID00F3) MSGF(&LIB/&OBJ)
032000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
032100000000
032200000000             ADDMSGD +
032300000000                MSGID(AID00F3) +
032400000000                MSGF(&LIB/&OBJ) +
032500000000                MSG( +
032600000000'Taste ''HILFE'' nicht gültig'                                        +
032700000000                ) +
032800000000                SEV(0) +
032900000000     /*   No replacement variables defined!                         */ +
033000000000                ALROPT(*NO) +
033100000000                CCSID(65535) +
033200000000                /*  -EOF-  */
033300000000
033400000000     /*-------------------------------------------------------------*/
033500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F4                    */
033600000000     /* Taste 'BILD RUNTER' nicht gültig                            */
033700000000     /*-------------------------------------------------------------*/
033800000000
033900000000             RMVMSGD MSGID(AID00F4) MSGF(&LIB/&OBJ)
034000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
034100000000
034200000000             ADDMSGD +
034300000000                MSGID(AID00F4) +
034400000000                MSGF(&LIB/&OBJ) +
034500000000                MSG( +
034600000000'Taste ''BILD RUNTER'' nicht gültig'                                  +
034700000000                ) +
034800000000                SEV(0) +
034900000000     /*   No replacement variables defined!                         */ +
035000000000                ALROPT(*NO) +
035100000000                CCSID(65535) +
035200000000                /*  -EOF-  */
035300000000
035400000000     /*-------------------------------------------------------------*/
035500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F5                    */
035600000000     /* Taste 'BILD HOCH' nicht gültig                              */
035700000000     /*-------------------------------------------------------------*/
035800000000
035900000000             RMVMSGD MSGID(AID00F5) MSGF(&LIB/&OBJ)
036000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
036100000000
036200000000             ADDMSGD +
036300000000                MSGID(AID00F5) +
036400000000                MSGF(&LIB/&OBJ) +
036500000000                MSG( +
036600000000'Taste ''BILD HOCH'' nicht gültig'                                    +
036700000000                ) +
036800000000                SEV(0) +
036900000000     /*   No replacement variables defined!                         */ +
037000000000                ALROPT(*NO) +
037100000000                CCSID(65535) +
037200000000                /*  -EOF-  */
037300000000
037400000000     /*-------------------------------------------------------------*/
037500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F6                    */
037600000000     /* Taste 'DRUCKEN' nicht gültig                                */
037700000000     /*-------------------------------------------------------------*/
037800000000
037900000000             RMVMSGD MSGID(AID00F6) MSGF(&LIB/&OBJ)
038000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
038100000000
038200000000             ADDMSGD +
038300000000                MSGID(AID00F6) +
038400000000                MSGF(&LIB/&OBJ) +
038500000000                MSG( +
038600000000'Taste ''DRUCKEN'' nicht gültig'                                      +
038700000000                ) +
038800000000                SEV(0) +
038900000000     /*   No replacement variables defined!                         */ +
039000000000                ALROPT(*NO) +
039100000000                CCSID(65535) +
039200000000                /*  -EOF-  */
039300000000
039400000000     /*-------------------------------------------------------------*/
039500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F8                    */
039600000000     /* Taste 'GRUNDSTELLUNG' nicht gültig                          */
039700000000     /*-------------------------------------------------------------*/
039800000000
039900000000             RMVMSGD MSGID(AID00F8) MSGF(&LIB/&OBJ)
040000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
040100000000
040200000000             ADDMSGD +
040300000000                MSGID(AID00F8) +
040400000000                MSGF(&LIB/&OBJ) +
040500000000                MSG( +
040600000000'Taste ''GRUNDSTELLUNG'' nicht gültig'                                +
040700000000                ) +
040800000000                SEV(0) +
040900000000     /*   No replacement variables defined!                         */ +
041000000000                ALROPT(*NO) +
041100000000                CCSID(65535) +
041200000000                /*  -EOF-  */
041300000000
041400000000     /*-------------------------------------------------------------*/
041500000000     /*   Cmd-ADDMSGD für Message-ID :   AID003A                    */
041600000000     /* Funktionstaste F10 nicht gültig.                            */
041700000000     /*-------------------------------------------------------------*/
041800000000
041900000000             RMVMSGD MSGID(AID003A) MSGF(&LIB/&OBJ)
042000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
042100000000
042200000000             ADDMSGD +
042300000000                MSGID(AID003A) +
042400000000                MSGF(&LIB/&OBJ) +
042500000000                MSG( +
042600000000'Funktionstaste F10 nicht gültig.'                                    +
042700000000                ) +
042800000000                SEV(0) +
042900000000     /*   No replacement variables defined!                         */ +
043000000000                ALROPT(*NO) +
043100000000                CCSID(65535) +
043200000000                /*  -EOF-  */
043300000000
043400000000     /*-------------------------------------------------------------*/
043500000000     /*   Cmd-ADDMSGD für Message-ID :   AID003B                    */
043600000000     /* Funktionstaste F11 nicht gültig.                            */
043700000000     /*-------------------------------------------------------------*/
043800000000
043900000000             RMVMSGD MSGID(AID003B) MSGF(&LIB/&OBJ)
044000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
044100000000
044200000000             ADDMSGD +
044300000000                MSGID(AID003B) +
044400000000                MSGF(&LIB/&OBJ) +
044500000000                MSG( +
044600000000'Funktionstaste F11 nicht gültig.'                                    +
044700000000                ) +
044800000000                SEV(0) +
044900000000     /*   No replacement variables defined!                         */ +
045000000000                ALROPT(*NO) +
045100000000                CCSID(65535) +
045200000000                /*  -EOF-  */
045300000000
045400000000     /*-------------------------------------------------------------*/
045500000000     /*   Cmd-ADDMSGD für Message-ID :   AID003C                    */
045600000000     /* Funktionstaste F12 nicht gültig.                            */
045700000000     /*-------------------------------------------------------------*/
045800000000
045900000000             RMVMSGD MSGID(AID003C) MSGF(&LIB/&OBJ)
046000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
046100000000
046200000000             ADDMSGD +
046300000000                MSGID(AID003C) +
046400000000                MSGF(&LIB/&OBJ) +
046500000000                MSG( +
046600000000'Funktionstaste F12 nicht gültig.'                                    +
046700000000                ) +
046800000000                SEV(0) +
046900000000     /*   No replacement variables defined!                         */ +
047000000000                ALROPT(*NO) +
047100000000                CCSID(65535) +
047200000000                /*  -EOF-  */
047300000000
047400000000     /*-------------------------------------------------------------*/
047500000000     /*   Cmd-ADDMSGD für Message-ID :   AID003F                    */
047600000000     /* Taste 'LICHTGRIFFEL' nicht gültig                           */
047700000000     /*-------------------------------------------------------------*/
047800000000
047900000000             RMVMSGD MSGID(AID003F) MSGF(&LIB/&OBJ)
048000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
048100000000
048200000000             ADDMSGD +
048300000000                MSGID(AID003F) +
048400000000                MSGF(&LIB/&OBJ) +
048500000000                MSG( +
048600000000'Taste ''LICHTGRIFFEL'' nicht gültig'                                 +
048700000000                ) +
048800000000                SEV(0) +
048900000000     /*   No replacement variables defined!                         */ +
049000000000                ALROPT(*NO) +
049100000000                CCSID(65535) +
049200000000                /*  -EOF-  */
049300000000
049400000000     /*-------------------------------------------------------------*/
049500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0031                    */
049600000000     /* Funktionstaste F1 nicht gültig.                             */
049700000000     /*-------------------------------------------------------------*/
049800000000
049900000000             RMVMSGD MSGID(AID0031) MSGF(&LIB/&OBJ)
050000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
050100000000
050200000000             ADDMSGD +
050300000000                MSGID(AID0031) +
050400000000                MSGF(&LIB/&OBJ) +
050500000000                MSG( +
050600000000'Funktionstaste F1 nicht gültig.'                                     +
050700000000                ) +
050800000000                SEV(0) +
050900000000     /*   No replacement variables defined!                         */ +
051000000000                ALROPT(*NO) +
051100000000                CCSID(65535) +
051200000000                /*  -EOF-  */
051300000000
051400000000     /*-------------------------------------------------------------*/
051500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0032                    */
051600000000     /* Funktionstaste F2 nicht gültig.                             */
051700000000     /*-------------------------------------------------------------*/
051800000000
051900000000             RMVMSGD MSGID(AID0032) MSGF(&LIB/&OBJ)
052000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
052100000000
052200000000             ADDMSGD +
052300000000                MSGID(AID0032) +
052400000000                MSGF(&LIB/&OBJ) +
052500000000                MSG( +
052600000000'Funktionstaste F2 nicht gültig.'                                     +
052700000000                ) +
052800000000                SEV(0) +
052900000000     /*   No replacement variables defined!                         */ +
053000000000                ALROPT(*NO) +
053100000000                CCSID(65535) +
053200000000                /*  -EOF-  */
053300000000
053400000000     /*-------------------------------------------------------------*/
053500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0033                    */
053600000000     /* Funktionstaste F3 nicht gültig.                             */
053700000000     /*-------------------------------------------------------------*/
053800000000
053900000000             RMVMSGD MSGID(AID0033) MSGF(&LIB/&OBJ)
054000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
054100000000
054200000000             ADDMSGD +
054300000000                MSGID(AID0033) +
054400000000                MSGF(&LIB/&OBJ) +
054500000000                MSG( +
054600000000'Funktionstaste F3 nicht gültig.'                                     +
054700000000                ) +
054800000000                SEV(0) +
054900000000     /*   No replacement variables defined!                         */ +
055000000000                ALROPT(*NO) +
055100000000                CCSID(65535) +
055200000000                /*  -EOF-  */
055300000000
055400000000     /*-------------------------------------------------------------*/
055500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0034                    */
055600000000     /* Funktionstaste F4 nicht gültig.                             */
055700000000     /*-------------------------------------------------------------*/
055800000000
055900000000             RMVMSGD MSGID(AID0034) MSGF(&LIB/&OBJ)
056000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
056100000000
056200000000             ADDMSGD +
056300000000                MSGID(AID0034) +
056400000000                MSGF(&LIB/&OBJ) +
056500000000                MSG( +
056600000000'Funktionstaste F4 nicht gültig.'                                     +
056700000000                ) +
056800000000                SEV(0) +
056900000000     /*   No replacement variables defined!                         */ +
057000000000                ALROPT(*NO) +
057100000000                CCSID(65535) +
057200000000                /*  -EOF-  */
057300000000
057400000000     /*-------------------------------------------------------------*/
057500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0035                    */
057600000000     /* Funktionstaste F5 nicht gültig.                             */
057700000000     /*-------------------------------------------------------------*/
057800000000
057900000000             RMVMSGD MSGID(AID0035) MSGF(&LIB/&OBJ)
058000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
058100000000
058200000000             ADDMSGD +
058300000000                MSGID(AID0035) +
058400000000                MSGF(&LIB/&OBJ) +
058500000000                MSG( +
058600000000'Funktionstaste F5 nicht gültig.'                                     +
058700000000                ) +
058800000000                SEV(0) +
058900000000     /*   No replacement variables defined!                         */ +
059000000000                ALROPT(*NO) +
059100000000                CCSID(65535) +
059200000000                /*  -EOF-  */
059300000000
059400000000     /*-------------------------------------------------------------*/
059500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0036                    */
059600000000     /* Funktionstaste F6 nicht gültig.                             */
059700000000     /*-------------------------------------------------------------*/
059800000000
059900000000             RMVMSGD MSGID(AID0036) MSGF(&LIB/&OBJ)
060000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
060100000000
060200000000             ADDMSGD +
060300000000                MSGID(AID0036) +
060400000000                MSGF(&LIB/&OBJ) +
060500000000                MSG( +
060600000000'Funktionstaste F6 nicht gültig.'                                     +
060700000000                ) +
060800000000                SEV(0) +
060900000000     /*   No replacement variables defined!                         */ +
061000000000                ALROPT(*NO) +
061100000000                CCSID(65535) +
061200000000                /*  -EOF-  */
061300000000
061400000000     /*-------------------------------------------------------------*/
061500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0037                    */
061600000000     /* Funktionstaste F7 nicht gültig.                             */
061700000000     /*-------------------------------------------------------------*/
061800000000
061900000000             RMVMSGD MSGID(AID0037) MSGF(&LIB/&OBJ)
062000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
062100000000
062200000000             ADDMSGD +
062300000000                MSGID(AID0037) +
062400000000                MSGF(&LIB/&OBJ) +
062500000000                MSG( +
062600000000'Funktionstaste F7 nicht gültig.'                                     +
062700000000                ) +
062800000000                SEV(0) +
062900000000     /*   No replacement variables defined!                         */ +
063000000000                ALROPT(*NO) +
063100000000                CCSID(65535) +
063200000000                /*  -EOF-  */
063300000000
063400000000     /*-------------------------------------------------------------*/
063500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0038                    */
063600000000     /* Funktionstaste F8 nicht gültig.                             */
063700000000     /*-------------------------------------------------------------*/
063800000000
063900000000             RMVMSGD MSGID(AID0038) MSGF(&LIB/&OBJ)
064000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
064100000000
064200000000             ADDMSGD +
064300000000                MSGID(AID0038) +
064400000000                MSGF(&LIB/&OBJ) +
064500000000                MSG( +
064600000000'Funktionstaste F8 nicht gültig.'                                     +
064700000000                ) +
064800000000                SEV(0) +
064900000000     /*   No replacement variables defined!                         */ +
065000000000                ALROPT(*NO) +
065100000000                CCSID(65535) +
065200000000                /*  -EOF-  */
065300000000
065400000000     /*-------------------------------------------------------------*/
065500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0039                    */
065600000000     /* Funktionstaste F9 nicht gültig.                             */
065700000000     /*-------------------------------------------------------------*/
065800000000
065900000000             RMVMSGD MSGID(AID0039) MSGF(&LIB/&OBJ)
066000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
066100000000
066200000000             ADDMSGD +
066300000000                MSGID(AID0039) +
066400000000                MSGF(&LIB/&OBJ) +
066500000000                MSG( +
066600000000'Funktionstaste F9 nicht gültig.'                                     +
066700000000                ) +
066800000000                SEV(0) +
066900000000     /*   No replacement variables defined!                         */ +
067000000000                ALROPT(*NO) +
067100000000                CCSID(65535) +
067200000000                /*  -EOF-  */
067300000000
067400000000     /*-------------------------------------------------------------*/
067500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0100                    */
067600000000     /* Unbekannte und nicht zulässige Taste                        */
067700000000     /*-------------------------------------------------------------*/
067800000000
067900000000             RMVMSGD MSGID(AID0100) MSGF(&LIB/&OBJ)
068000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
068100000000
068200000000             ADDMSGD +
068300000000                MSGID(AID0100) +
068400000000                MSGF(&LIB/&OBJ) +
068500000000                MSG( +
068600000000'Unbekannte und nicht zulässige Taste'                                +
068700000000                ) +
068800000000                SEV(0) +
068900000000     /*   No replacement variables defined!                         */ +
069000000000                ALROPT(*NO) +
069100000000                CCSID(65535) +
069200000000                /*  -EOF-  */
069300000000
069400000000     /*-------------------------------------------------------------*/
069500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0001                    */
069600000000     /* Datenfreigabe                                               */
069700000000     /*-------------------------------------------------------------*/
069800000000
069900000000             RMVMSGD MSGID(KEY0001) MSGF(&LIB/&OBJ)
070000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
070100000000
070200000000             ADDMSGD +
070300000000                MSGID(KEY0001) +
070400000000                MSGF(&LIB/&OBJ) +
070500000000                MSG( +
070600000000'Datenfreigabe     '                                                  +
070700000000                ) +
070800000000                SEV(0) +
070900000000     /*   No replacement variables defined!                         */ +
071000000000                ALROPT(*NO) +
071100000000                CCSID(65535) +
071200000000                /*  -EOF-  */
071300000000
071400000000     /*-------------------------------------------------------------*/
071500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0002                    */
071600000000     /* Beenden                                                     */
071700000000     /*-------------------------------------------------------------*/
071800000000
071900000000             RMVMSGD MSGID(KEY0002) MSGF(&LIB/&OBJ)
072000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
072100000000
072200000000             ADDMSGD +
072300000000                MSGID(KEY0002) +
072400000000                MSGF(&LIB/&OBJ) +
072500000000                MSG( +
072600000000'Beenden           '                                                  +
072700000000                ) +
072800000000                SEV(0) +
072900000000     /*   No replacement variables defined!                         */ +
073000000000                ALROPT(*NO) +
073100000000                CCSID(65535) +
073200000000                /*  -EOF-  */
073300000000
073400000000     /*-------------------------------------------------------------*/
073500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0003                    */
073600000000     /* Aktualisieren                                               */
073700000000     /*-------------------------------------------------------------*/
073800000000
073900000000             RMVMSGD MSGID(KEY0003) MSGF(&LIB/&OBJ)
074000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
074100000000
074200000000             ADDMSGD +
074300000000                MSGID(KEY0003) +
074400000000                MSGF(&LIB/&OBJ) +
074500000000                MSG( +
074600000000'Aktualisieren     '                                                  +
074700000000                ) +
074800000000                SEV(0) +
074900000000     /*   No replacement variables defined!                         */ +
075000000000                ALROPT(*NO) +
075100000000                CCSID(65535) +
075200000000                /*  -EOF-  */
075300000000
075400000000     /*-------------------------------------------------------------*/
075500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0004                    */
075600000000     /* Neuanlage                                                   */
075700000000     /*-------------------------------------------------------------*/
075800000000
075900000000             RMVMSGD MSGID(KEY0004) MSGF(&LIB/&OBJ)
076000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
076100000000
076200000000             ADDMSGD +
076300000000                MSGID(KEY0004) +
076400000000                MSGF(&LIB/&OBJ) +
076500000000                MSG( +
076600000000'Neuanlage         '                                                  +
076700000000                ) +
076800000000                SEV(0) +
076900000000     /*   No replacement variables defined!                         */ +
077000000000                ALROPT(*NO) +
077100000000                CCSID(65535) +
077200000000                /*  -EOF-  */
077300000000
077400000000     /*-------------------------------------------------------------*/
077500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0005                    */
077600000000     /* Überschrift                                                 */
077700000000     /*-------------------------------------------------------------*/
077800000000
077900000000             RMVMSGD MSGID(KEY0005) MSGF(&LIB/&OBJ)
078000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
078100000000
078200000000             ADDMSGD +
078300000000                MSGID(KEY0005) +
078400000000                MSGF(&LIB/&OBJ) +
078500000000                MSG( +
078600000000'Überschrift       '                                                  +
078700000000                ) +
078800000000                SEV(0) +
078900000000     /*   No replacement variables defined!                         */ +
079000000000                ALROPT(*NO) +
079100000000                CCSID(65535) +
079200000000                /*  -EOF-  */
079300000000
079400000000     /*-------------------------------------------------------------*/
079500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0006                    */
079600000000     /* Spalte mark.+/-                                             */
079700000000     /*-------------------------------------------------------------*/
079800000000
079900000000             RMVMSGD MSGID(KEY0006) MSGF(&LIB/&OBJ)
080000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
080100000000
080200000000             ADDMSGD +
080300000000                MSGID(KEY0006) +
080400000000                MSGF(&LIB/&OBJ) +
080500000000                MSG( +
080600000000'Spalte mark.+/-   '                                                  +
080700000000                ) +
080800000000                SEV(0) +
080900000000     /*   No replacement variables defined!                         */ +
081000000000                ALROPT(*NO) +
081100000000                CCSID(65535) +
081200000000                /*  -EOF-  */
081300000000
081400000000     /*-------------------------------------------------------------*/
081500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0007                    */
081600000000     /* Nach oben zieh.                                             */
081700000000     /*-------------------------------------------------------------*/
081800000000
081900000000             RMVMSGD MSGID(KEY0007) MSGF(&LIB/&OBJ)
082000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
082100000000
082200000000             ADDMSGD +
082300000000                MSGID(KEY0007) +
082400000000                MSGF(&LIB/&OBJ) +
082500000000                MSG( +
082600000000'Nach oben zieh.   '                                                  +
082700000000                ) +
082800000000                SEV(0) +
082900000000     /*   No replacement variables defined!                         */ +
083000000000                ALROPT(*NO) +
083100000000                CCSID(65535) +
083200000000                /*  -EOF-  */
083300000000
083400000000     /*-------------------------------------------------------------*/
083500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0008                    */
083600000000     /* Cursor pos.                                                 */
083700000000     /*-------------------------------------------------------------*/
083800000000
083900000000             RMVMSGD MSGID(KEY0008) MSGF(&LIB/&OBJ)
084000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
084100000000
084200000000             ADDMSGD +
084300000000                MSGID(KEY0008) +
084400000000                MSGF(&LIB/&OBJ) +
084500000000                MSG( +
084600000000'Cursor pos.       '                                                  +
084700000000                ) +
084800000000                SEV(0) +
084900000000     /*   No replacement variables defined!                         */ +
085000000000                ALROPT(*NO) +
085100000000                CCSID(65535) +
085200000000                /*  -EOF-  */
085300000000
085400000000     /*-------------------------------------------------------------*/
085500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0009                    */
085600000000     /* Suchen                                                      */
085700000000     /*-------------------------------------------------------------*/
085800000000
085900000000             RMVMSGD MSGID(KEY0009) MSGF(&LIB/&OBJ)
086000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
086100000000
086200000000             ADDMSGD +
086300000000                MSGID(KEY0009) +
086400000000                MSGF(&LIB/&OBJ) +
086500000000                MSG( +
086600000000'Suchen            '                                                  +
086700000000                ) +
086800000000                SEV(0) +
086900000000     /*   No replacement variables defined!                         */ +
087000000000                ALROPT(*NO) +
087100000000                CCSID(65535) +
087200000000                /*  -EOF-  */
087300000000
087400000000     /*-------------------------------------------------------------*/
087500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0010                    */
087600000000     /* Anfang                                                      */
087700000000     /*-------------------------------------------------------------*/
087800000000
087900000000             RMVMSGD MSGID(KEY0010) MSGF(&LIB/&OBJ)
088000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
088100000000
088200000000             ADDMSGD +
088300000000                MSGID(KEY0010) +
088400000000                MSGF(&LIB/&OBJ) +
088500000000                MSG( +
088600000000'Anfang            '                                                  +
088700000000                ) +
088800000000                SEV(0) +
088900000000     /*   No replacement variables defined!                         */ +
089000000000                ALROPT(*NO) +
089100000000                CCSID(65535) +
089200000000                /*  -EOF-  */
089300000000
089400000000     /*-------------------------------------------------------------*/
089500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0011                    */
089600000000     /* Ende                                                        */
089700000000     /*-------------------------------------------------------------*/
089800000000
089900000000             RMVMSGD MSGID(KEY0011) MSGF(&LIB/&OBJ)
090000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
090100000000
090200000000             ADDMSGD +
090300000000                MSGID(KEY0011) +
090400000000                MSGF(&LIB/&OBJ) +
090500000000                MSG( +
090600000000'Ende              '                                                  +
090700000000                ) +
090800000000                SEV(0) +
090900000000     /*   No replacement variables defined!                         */ +
091000000000                ALROPT(*NO) +
091100000000                CCSID(65535) +
091200000000                /*  -EOF-  */
091300000000
091400000000     /*-------------------------------------------------------------*/
091500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0012                    */
091600000000     /* Links                                                       */
091700000000     /*-------------------------------------------------------------*/
091800000000
091900000000             RMVMSGD MSGID(KEY0012) MSGF(&LIB/&OBJ)
092000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
092100000000
092200000000             ADDMSGD +
092300000000                MSGID(KEY0012) +
092400000000                MSGF(&LIB/&OBJ) +
092500000000                MSG( +
092600000000'Links             '                                                  +
092700000000                ) +
092800000000                SEV(0) +
092900000000     /*   No replacement variables defined!                         */ +
093000000000                ALROPT(*NO) +
093100000000                CCSID(65535) +
093200000000                /*  -EOF-  */
093300000000
093400000000     /*-------------------------------------------------------------*/
093500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0013                    */
093600000000     /* Rechts                                                      */
093700000000     /*-------------------------------------------------------------*/
093800000000
093900000000             RMVMSGD MSGID(KEY0013) MSGF(&LIB/&OBJ)
094000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
094100000000
094200000000             ADDMSGD +
094300000000                MSGID(KEY0013) +
094400000000                MSGF(&LIB/&OBJ) +
094500000000                MSG( +
094600000000'Rechts            '                                                  +
094700000000                ) +
094800000000                SEV(0) +
094900000000     /*   No replacement variables defined!                         */ +
095000000000                ALROPT(*NO) +
095100000000                CCSID(65535) +
095200000000                /*  -EOF-  */
095300000000
095400000000     /*-------------------------------------------------------------*/
095500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0014                    */
095600000000     /* Befehlszeile                                                */
095700000000     /*-------------------------------------------------------------*/
095800000000
095900000000             RMVMSGD MSGID(KEY0014) MSGF(&LIB/&OBJ)
096000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
096100000000
096200000000             ADDMSGD +
096300000000                MSGID(KEY0014) +
096400000000                MSGF(&LIB/&OBJ) +
096500000000                MSG( +
096600000000'Befehlszeile      '                                                  +
096700000000                ) +
096800000000                SEV(0) +
096900000000     /*   No replacement variables defined!                         */ +
097000000000                ALROPT(*NO) +
097100000000                CCSID(65535) +
097200000000                /*  -EOF-  */
097300000000
097400000000     /*-------------------------------------------------------------*/
097500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0015                    */
097600000000     /* 80/132 Zeichen                                              */
097700000000     /*-------------------------------------------------------------*/
097800000000
097900000000             RMVMSGD MSGID(KEY0015) MSGF(&LIB/&OBJ)
098000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
098100000000
098200000000             ADDMSGD +
098300000000                MSGID(KEY0015) +
098400000000                MSGF(&LIB/&OBJ) +
098500000000                MSG( +
098600000000'80/132 Zeichen    '                                                  +
098700000000                ) +
098800000000                SEV(0) +
098900000000     /*   No replacement variables defined!                         */ +
099000000000                ALROPT(*NO) +
099100000000                CCSID(65535) +
099200000000                /*  -EOF-  */
099300000000
099400000000     /*-------------------------------------------------------------*/
099500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0016                    */
099600000000     /* Weitere Tasten                                              */
099700000000     /*-------------------------------------------------------------*/
099800000000
099900000000             RMVMSGD MSGID(KEY0016) MSGF(&LIB/&OBJ)
100000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
100100000000
100200000000             ADDMSGD +
100300000000                MSGID(KEY0016) +
100400000000                MSGF(&LIB/&OBJ) +
100500000000                MSG( +
100600000000'Weitere Tasten    '                                                  +
100700000000                ) +
100800000000                SEV(0) +
100900000000     /*   No replacement variables defined!                         */ +
101000000000                ALROPT(*NO) +
101100000000                CCSID(65535) +
101200000000                /*  -EOF-  */
101300000000
101400000000     /*-------------------------------------------------------------*/
101500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0017                    */
101600000000     /* Bild runter                                                 */
101700000000     /*-------------------------------------------------------------*/
101800000000
101900000000             RMVMSGD MSGID(KEY0017) MSGF(&LIB/&OBJ)
102000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
102100000000
102200000000             ADDMSGD +
102300000000                MSGID(KEY0017) +
102400000000                MSGF(&LIB/&OBJ) +
102500000000                MSG( +
102600000000'Bild runter       '                                                  +
102700000000                ) +
102800000000                SEV(0) +
102900000000     /*   No replacement variables defined!                         */ +
103000000000                ALROPT(*NO) +
103100000000                CCSID(65535) +
103200000000                /*  -EOF-  */
103300000000
103400000000     /*-------------------------------------------------------------*/
103500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0018                    */
103600000000     /* Bild hoch                                                   */
103700000000     /*-------------------------------------------------------------*/
103800000000
103900000000             RMVMSGD MSGID(KEY0018) MSGF(&LIB/&OBJ)
104000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
104100000000
104200000000             ADDMSGD +
104300000000                MSGID(KEY0018) +
104400000000                MSGF(&LIB/&OBJ) +
104500000000                MSG( +
104600000000'Bild hoch         '                                                  +
104700000000                ) +
104800000000                SEV(0) +
104900000000     /*   No replacement variables defined!                         */ +
105000000000                ALROPT(*NO) +
105100000000                CCSID(65535) +
105200000000                /*  -EOF-  */
105300000000
105400000000     /*-------------------------------------------------------------*/
105500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0019                    */
105600000000     /* Pin-Zeile                                                   */
105700000000     /*-------------------------------------------------------------*/
105800000000
105900000000             RMVMSGD MSGID(KEY0019) MSGF(&LIB/&OBJ)
106000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
106100000000
106200000000             ADDMSGD +
106300000000                MSGID(KEY0019) +
106400000000                MSGF(&LIB/&OBJ) +
106500000000                MSG( +
106600000000'Pin-Zeile         '                                                  +
106700000000                ) +
106800000000                SEV(0) +
106900000000     /*   No replacement variables defined!                         */ +
107000000000                ALROPT(*NO) +
107100000000                CCSID(65535) +
107200000000                /*  -EOF-  */
107300000000
107400000000     /*-------------------------------------------------------------*/
107500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0020                    */
107600000000     /* UnPin-Zeile                                                 */
107700000000     /*-------------------------------------------------------------*/
107800000000
107900000000             RMVMSGD MSGID(KEY0020) MSGF(&LIB/&OBJ)
108000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
108100000000
108200000000             ADDMSGD +
108300000000                MSGID(KEY0020) +
108400000000                MSGF(&LIB/&OBJ) +
108500000000                MSG( +
108600000000'UnPin-Zeile       '                                                  +
108700000000                ) +
108800000000                SEV(0) +
108900000000     /*   No replacement variables defined!                         */ +
109000000000                ALROPT(*NO) +
109100000000                CCSID(65535) +
109200000000                /*  -EOF-  */
109300000000
109400000000     /*-------------------------------------------------------------*/
109500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0021                    */
109600000000     /* Ändern                                                      */
109700000000     /*-------------------------------------------------------------*/
109800000000
109900000000             RMVMSGD MSGID(KEY0021) MSGF(&LIB/&OBJ)
110000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
110100000000
110200000000             ADDMSGD +
110300000000                MSGID(KEY0021) +
110400000000                MSGF(&LIB/&OBJ) +
110500000000                MSG( +
110600000000'Ändern            '                                                  +
110700000000                ) +
110800000000                SEV(0) +
110900000000     /*   No replacement variables defined!                         */ +
111000000000                ALROPT(*NO) +
111100000000                CCSID(65535) +
111200000000                /*  -EOF-  */
111300000000
111400000000     /*-------------------------------------------------------------*/
111500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0022                    */
111600000000     /* Kopieren                                                    */
111700000000     /*-------------------------------------------------------------*/
111800000000
111900000000             RMVMSGD MSGID(KEY0022) MSGF(&LIB/&OBJ)
112000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
112100000000
112200000000             ADDMSGD +
112300000000                MSGID(KEY0022) +
112400000000                MSGF(&LIB/&OBJ) +
112500000000                MSG( +
112600000000'Kopieren          '                                                  +
112700000000                ) +
112800000000                SEV(0) +
112900000000     /*   No replacement variables defined!                         */ +
113000000000                ALROPT(*NO) +
113100000000                CCSID(65535) +
113200000000                /*  -EOF-  */
113300000000
113400000000     /*-------------------------------------------------------------*/
113500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0023                    */
113600000000     /* Löschen                                                     */
113700000000     /*-------------------------------------------------------------*/
113800000000
113900000000             RMVMSGD MSGID(KEY0023) MSGF(&LIB/&OBJ)
114000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
114100000000
114200000000             ADDMSGD +
114300000000                MSGID(KEY0023) +
114400000000                MSGF(&LIB/&OBJ) +
114500000000                MSG( +
114600000000'Löschen           '                                                  +
114700000000                ) +
114800000000                SEV(0) +
114900000000     /*   No replacement variables defined!                         */ +
115000000000                ALROPT(*NO) +
115100000000                CCSID(65535) +
115200000000                /*  -EOF-  */
115300000000
115400000000     /*-------------------------------------------------------------*/
115500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0024                    */
115600000000     /* Anzeigen                                                    */
115700000000     /*-------------------------------------------------------------*/
115800000000
115900000000             RMVMSGD MSGID(KEY0024) MSGF(&LIB/&OBJ)
116000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
116100000000
116200000000             ADDMSGD +
116300000000                MSGID(KEY0024) +
116400000000                MSGF(&LIB/&OBJ) +
116500000000                MSG( +
116600000000'Anzeigen          '                                                  +
116700000000                ) +
116800000000                SEV(0) +
116900000000     /*   No replacement variables defined!                         */ +
117000000000                ALROPT(*NO) +
117100000000                CCSID(65535) +
117200000000                /*  -EOF-  */
117300000000
117400000000     /*-------------------------------------------------------------*/
117500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0025                    */
117600000000     /* Einstellungen                                               */
117700000000     /*-------------------------------------------------------------*/
117800000000
117900000000             RMVMSGD MSGID(KEY0025) MSGF(&LIB/&OBJ)
118000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
118100000000
118200000000             ADDMSGD +
118300000000                MSGID(KEY0025) +
118400000000                MSGF(&LIB/&OBJ) +
118500000000                MSG( +
118600000000'Einstellungen'                                                       +
118700000000                ) +
118800000000                SEV(0) +
118900000000     /*   No replacement variables defined!                         */ +
119000000000                ALROPT(*NO) +
119100000000                CCSID(65535) +
119200000000                /*  -EOF-  */
119300000000
119400000000     /*-------------------------------------------------------------*/
119500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0026                    */
119600000000     /* Abbrechen                                                   */
119700000000     /*-------------------------------------------------------------*/
119800000000
119900000000             RMVMSGD MSGID(KEY0026) MSGF(&LIB/&OBJ)
120000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
120100000000
120200000000             ADDMSGD +
120300000000                MSGID(KEY0026) +
120400000000                MSGF(&LIB/&OBJ) +
120500000000                MSG( +
120600000000'Abbrechen'                                                           +
120700000000                ) +
120800000000                SEV(0) +
120900000000     /*   No replacement variables defined!                         */ +
121000000000                ALROPT(*NO) +
121100000000                CCSID(65535) +
121200000000                /*  -EOF-  */
121300000000
121400000000     /*-------------------------------------------------------------*/
121500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0027                    */
121600000000     /* Sich. & Ende                                                */
121700000000     /*-------------------------------------------------------------*/
121800000000
121900000000             RMVMSGD MSGID(KEY0027) MSGF(&LIB/&OBJ)
122000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
122100000000
122200000000             ADDMSGD +
122300000000                MSGID(KEY0027) +
122400000000                MSGF(&LIB/&OBJ) +
122500000000                MSG( +
122600000000'Sich. & Ende'                                                        +
122700000000                ) +
122800000000                SEV(0) +
122900000000     /*   No replacement variables defined!                         */ +
123000000000                ALROPT(*NO) +
123100000000                CCSID(65535) +
123200000000                /*  -EOF-  */
123300000000
123400000000     /*-------------------------------------------------------------*/
123500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0028                    */
123600000000     /* Pin-Spalte                                                  */
123700000000     /*-------------------------------------------------------------*/
123800000000
123900000000             RMVMSGD MSGID(KEY0028) MSGF(&LIB/&OBJ)
124000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
124100000000
124200000000             ADDMSGD +
124300000000                MSGID(KEY0028) +
124400000000                MSGF(&LIB/&OBJ) +
124500000000                MSG( +
124600000000'Pin-Spalte'                                                          +
124700000000                ) +
124800000000                SEV(0) +
124900000000     /*   No replacement variables defined!                         */ +
125000000000                ALROPT(*NO) +
125100000000                CCSID(65535) +
125200000000                /*  -EOF-  */
125300000000
125400000000     /*-------------------------------------------------------------*/
125500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0029                    */
125600000000     /* UnPin-Spalte                                                */
125700000000     /*-------------------------------------------------------------*/
125800000000
125900000000             RMVMSGD MSGID(KEY0029) MSGF(&LIB/&OBJ)
126000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
126100000000
126200000000             ADDMSGD +
126300000000                MSGID(KEY0029) +
126400000000                MSGF(&LIB/&OBJ) +
126500000000                MSG( +
126600000000'UnPin-Spalte'                                                        +
126700000000                ) +
126800000000                SEV(0) +
126900000000     /*   No replacement variables defined!                         */ +
127000000000                ALROPT(*NO) +
127100000000                CCSID(65535) +
127200000000                /*  -EOF-  */
127300000000
127400000000     /*-------------------------------------------------------------*/
127500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0030                    */
127600000000     /* Pin-Spalte +/-                                              */
127700000000     /*-------------------------------------------------------------*/
127800000000
127900000000             RMVMSGD MSGID(KEY0030) MSGF(&LIB/&OBJ)
128000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
128100000000
128200000000             ADDMSGD +
128300000000                MSGID(KEY0030) +
128400000000                MSGF(&LIB/&OBJ) +
128500000000                MSG( +
128600000000'Pin-Spalte +/-'                                                      +
128700000000                ) +
128800000000                SEV(0) +
128900000000     /*   No replacement variables defined!                         */ +
129000000000                ALROPT(*NO) +
129100000000                CCSID(65535) +
129200000000                /*  -EOF-  */
129300000000
129400000000     /*-------------------------------------------------------------*/
129500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0031                    */
129600000000     /* Tab.Papier Ein                                              */
129700000000     /*-------------------------------------------------------------*/
129800000000
129900000000             RMVMSGD MSGID(KEY0031) MSGF(&LIB/&OBJ)
130000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
130100000000
130200000000             ADDMSGD +
130300000000                MSGID(KEY0031) +
130400000000                MSGF(&LIB/&OBJ) +
130500000000                MSG( +
130600000000'Tab.Papier Ein'                                                      +
130700000000                ) +
130800000000                SEV(0) +
130900000000     /*   No replacement variables defined!                         */ +
131000000000                ALROPT(*NO) +
131100000000                CCSID(65535) +
131200000000                /*  -EOF-  */
131300000000
131400000000     /*-------------------------------------------------------------*/
131500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0032                    */
131600000000     /* Tab.Papier aus                                              */
131700000000     /*-------------------------------------------------------------*/
131800000000
131900000000             RMVMSGD MSGID(KEY0032) MSGF(&LIB/&OBJ)
132000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
132100000000
132200000000             ADDMSGD +
132300000000                MSGID(KEY0032) +
132400000000                MSGF(&LIB/&OBJ) +
132500000000                MSG( +
132600000000'Tab.Papier aus'                                                      +
132700000000                ) +
132800000000                SEV(0) +
132900000000     /*   No replacement variables defined!                         */ +
133000000000                ALROPT(*NO) +
133100000000                CCSID(65535) +
133200000000                /*  -EOF-  */
133300000000
133400000000     /*-------------------------------------------------------------*/
133500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0033                    */
133600000000     /* Tab.Papier +/-                                              */
133700000000     /*-------------------------------------------------------------*/
133800000000
133900000000             RMVMSGD MSGID(KEY0033) MSGF(&LIB/&OBJ)
134000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
134100000000
134200000000             ADDMSGD +
134300000000                MSGID(KEY0033) +
134400000000                MSGF(&LIB/&OBJ) +
134500000000                MSG( +
134600000000'Tab.Papier +/-'                                                      +
134700000000                ) +
134800000000                SEV(0) +
134900000000     /*   No replacement variables defined!                         */ +
135000000000                ALROPT(*NO) +
135100000000                CCSID(65535) +
135200000000                /*  -EOF-  */
135300000000
135400000000     /*-------------------------------------------------------------*/
135500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0034                    */
135600000000     /* Alle Datensätze                                             */
135700000000     /*-------------------------------------------------------------*/
135800000000
135900000000             RMVMSGD MSGID(KEY0034) MSGF(&LIB/&OBJ)
136000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
136100000000
136200000000             ADDMSGD +
136300000000                MSGID(KEY0034) +
136400000000                MSGF(&LIB/&OBJ) +
136500000000                MSG( +
136600000000'Alle Datensätze'                                                     +
136700000000                ) +
136800000000                SEV(0) +
136900000000     /*   No replacement variables defined!                         */ +
137000000000                ALROPT(*NO) +
137100000000                CCSID(65535) +
137200000000                /*  -EOF-  */
137300000000
137400000000     /*-------------------------------------------------------------*/
137500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0035                    */
137600000000     /* Weitere Ausw.                                               */
137700000000     /*-------------------------------------------------------------*/
137800000000
137900000000             RMVMSGD MSGID(KEY0035) MSGF(&LIB/&OBJ)
138000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
138100000000
138200000000             ADDMSGD +
138300000000                MSGID(KEY0035) +
138400000000                MSGF(&LIB/&OBJ) +
138500000000                MSG( +
138600000000'Weitere Ausw.'                                                       +
138700000000                ) +
138800000000                SEV(0) +
138900000000     /*   No replacement variables defined!                         */ +
139000000000                ALROPT(*NO) +
139100000000                CCSID(65535) +
139200000000                /*  -EOF-  */
139300000000
139400000000     /*-------------------------------------------------------------*/
139500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0036                    */
139600000000     /* ext. Kopieren                                               */
139700000000     /*-------------------------------------------------------------*/
139800000000
139900000000             RMVMSGD MSGID(KEY0036) MSGF(&LIB/&OBJ)
140000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
140100000000
140200000000             ADDMSGD +
140300000000                MSGID(KEY0036) +
140400000000                MSGF(&LIB/&OBJ) +
140500000000                MSG( +
140600000000'ext. Kopieren'                                                       +
140700000000                ) +
140800000000                SEV(0) +
140900000000     /*   No replacement variables defined!                         */ +
141000000000                ALROPT(*NO) +
141100000000                CCSID(65535) +
141200000000                /*  -EOF-  */
141300000000
141400000000     /*-------------------------------------------------------------*/
141500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0037                    */
141600000000     /* Spalte mark.                                                */
141700000000     /*-------------------------------------------------------------*/
141800000000
141900000000             RMVMSGD MSGID(KEY0037) MSGF(&LIB/&OBJ)
142000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
142100000000
142200000000             ADDMSGD +
142300000000                MSGID(KEY0037) +
142400000000                MSGF(&LIB/&OBJ) +
142500000000                MSG( +
142600000000'Spalte mark.'                                                        +
142700000000                ) +
142800000000                SEV(0) +
142900000000     /*   No replacement variables defined!                         */ +
143000000000                ALROPT(*NO) +
143100000000                CCSID(65535) +
143200000000                /*  -EOF-  */
143300000000
143400000000     /*-------------------------------------------------------------*/
143500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0038                    */
143600000000     /* Splt.Mark.aufh.                                             */
143700000000     /*-------------------------------------------------------------*/
143800000000
143900000000             RMVMSGD MSGID(KEY0038) MSGF(&LIB/&OBJ)
144000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
144100000000
144200000000             ADDMSGD +
144300000000                MSGID(KEY0038) +
144400000000                MSGF(&LIB/&OBJ) +
144500000000                MSG( +
144600000000'Splt.Mark.aufh.'                                                     +
144700000000                ) +
144800000000                SEV(0) +
144900000000     /*   No replacement variables defined!                         */ +
145000000000                ALROPT(*NO) +
145100000000                CCSID(65535) +
145200000000                /*  -EOF-  */
145300000000
145400000000     /*-------------------------------------------------------------*/
145500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0039                    */
145600000000     /* Kleinbuchstaben                                             */
145700000000     /*-------------------------------------------------------------*/
145800000000
145900000000             RMVMSGD MSGID(KEY0039) MSGF(&LIB/&OBJ)
146000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
146100000000
146200000000             ADDMSGD +
146300000000                MSGID(KEY0039) +
146400000000                MSGF(&LIB/&OBJ) +
146500000000                MSG( +
146600000000'Kleinbuchstaben'                                                     +
146700000000                ) +
146800000000                SEV(0) +
146900000000     /*   No replacement variables defined!                         */ +
147000000000                ALROPT(*NO) +
147100000000                CCSID(65535) +
147200000000                /*  -EOF-  */
147300000000
147400000000     /*-------------------------------------------------------------*/
147500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0040                    */
147600000000     /* Großbuchstaben                                              */
147700000000     /*-------------------------------------------------------------*/
147800000000
147900000000             RMVMSGD MSGID(KEY0040) MSGF(&LIB/&OBJ)
148000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
148100000000
148200000000             ADDMSGD +
148300000000                MSGID(KEY0040) +
148400000000                MSGF(&LIB/&OBJ) +
148500000000                MSG( +
148600000000'Großbuchstaben'                                                      +
148700000000                ) +
148800000000                SEV(0) +
148900000000     /*   No replacement variables defined!                         */ +
149000000000                ALROPT(*NO) +
149100000000                CCSID(65535) +
149200000000                /*  -EOF-  */
149300000000
149400000000     /*-------------------------------------------------------------*/
149500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0041                    */
149600000000     /* Klein/Großb.+/-                                             */
149700000000     /*-------------------------------------------------------------*/
149800000000
149900000000             RMVMSGD MSGID(KEY0041) MSGF(&LIB/&OBJ)
150000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
150100000000
150200000000             ADDMSGD +
150300000000                MSGID(KEY0041) +
150400000000                MSGF(&LIB/&OBJ) +
150500000000                MSG( +
150600000000'Klein/Großb.+/-'                                                     +
150700000000                ) +
150800000000                SEV(0) +
150900000000     /*   No replacement variables defined!                         */ +
151000000000                ALROPT(*NO) +
151100000000                CCSID(65535) +
151200000000                /*  -EOF-  */
151300000000
151400000000     /*-------------------------------------------------------------*/
151500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0042                    */
151600000000     /* Splash-Ein                                                  */
151700000000     /*-------------------------------------------------------------*/
151800000000
151900000000             RMVMSGD MSGID(KEY0042) MSGF(&LIB/&OBJ)
152000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
152100000000
152200000000             ADDMSGD +
152300000000                MSGID(KEY0042) +
152400000000                MSGF(&LIB/&OBJ) +
152500000000                MSG( +
152600000000'Splash-Ein'                                                          +
152700000000                ) +
152800000000                SEV(0) +
152900000000     /*   No replacement variables defined!                         */ +
153000000000                ALROPT(*NO) +
153100000000                CCSID(65535) +
153200000000                /*  -EOF-  */
153300000000
153400000000     /*-------------------------------------------------------------*/
153500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0043                    */
153600000000     /* Splash-Aus                                                  */
153700000000     /*-------------------------------------------------------------*/
153800000000
153900000000             RMVMSGD MSGID(KEY0043) MSGF(&LIB/&OBJ)
154000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
154100000000
154200000000             ADDMSGD +
154300000000                MSGID(KEY0043) +
154400000000                MSGF(&LIB/&OBJ) +
154500000000                MSG( +
154600000000'Splash-Aus'                                                          +
154700000000                ) +
154800000000                SEV(0) +
154900000000     /*   No replacement variables defined!                         */ +
155000000000                ALROPT(*NO) +
155100000000                CCSID(65535) +
155200000000                /*  -EOF-  */
155300000000
155400000000     /*-------------------------------------------------------------*/
155500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0044                    */
155600000000     /* Seite links                                                 */
155700000000     /*-------------------------------------------------------------*/
155800000000
155900000000             RMVMSGD MSGID(KEY0044) MSGF(&LIB/&OBJ)
156000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
156100000000
156200000000             ADDMSGD +
156300000000                MSGID(KEY0044) +
156400000000                MSGF(&LIB/&OBJ) +
156500000000                MSG( +
156600000000'Seite links'                                                         +
156700000000                ) +
156800000000                SEV(0) +
156900000000     /*   No replacement variables defined!                         */ +
157000000000                ALROPT(*NO) +
157100000000                CCSID(65535) +
157200000000                /*  -EOF-  */
157300000000
157400000000     /*-------------------------------------------------------------*/
157500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0045                    */
157600000000     /* Seite rechts                                                */
157700000000     /*-------------------------------------------------------------*/
157800000000
157900000000             RMVMSGD MSGID(KEY0045) MSGF(&LIB/&OBJ)
158000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
158100000000
158200000000             ADDMSGD +
158300000000                MSGID(KEY0045) +
158400000000                MSGF(&LIB/&OBJ) +
158500000000                MSG( +
158600000000'Seite rechts'                                                        +
158700000000                ) +
158800000000                SEV(0) +
158900000000     /*   No replacement variables defined!                         */ +
159000000000                ALROPT(*NO) +
159100000000                CCSID(65535) +
159200000000                /*  -EOF-  */
159300000000
159400000000     /*-------------------------------------------------------------*/
159500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0046                    */
159600000000     /* Wiederholen                                                 */
159700000000     /*-------------------------------------------------------------*/
159800000000
159900000000             RMVMSGD MSGID(KEY0046) MSGF(&LIB/&OBJ)
160000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
160100000000
160200000000             ADDMSGD +
160300000000                MSGID(KEY0046) +
160400000000                MSGF(&LIB/&OBJ) +
160500000000                MSG( +
160600000000'Wiederholen'                                                         +
160700000000                ) +
160800000000                SEV(0) +
160900000000     /*   No replacement variables defined!                         */ +
161000000000                ALROPT(*NO) +
161100000000                CCSID(65535) +
161200000000                /*  -EOF-  */
161300000000
161400000000     /*-------------------------------------------------------------*/
161500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0047                    */
161600000000     /* Neuerstellung                                               */
161700000000     /*-------------------------------------------------------------*/
161800000000
161900000000             RMVMSGD MSGID(KEY0047) MSGF(&LIB/&OBJ)
162000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
162100000000
162200000000             ADDMSGD +
162300000000                MSGID(KEY0047) +
162400000000                MSGF(&LIB/&OBJ) +
162500000000                MSG( +
162600000000'Neuerstellung'                                                       +
162700000000                ) +
162800000000                SEV(0) +
162900000000     /*   No replacement variables defined!                         */ +
163000000000                ALROPT(*NO) +
163100000000                CCSID(65535) +
163200000000                /*  -EOF-  */
163300000000
163400000000     /*-------------------------------------------------------------*/
163500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0048                    */
163600000000     /* UnPin Zeilen                                                */
163700000000     /*-------------------------------------------------------------*/
163800000000
163900000000             RMVMSGD MSGID(KEY0048) MSGF(&LIB/&OBJ)
164000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
164100000000
164200000000             ADDMSGD +
164300000000                MSGID(KEY0048) +
164400000000                MSGF(&LIB/&OBJ) +
164500000000                MSG( +
164600000000'UnPin Zeilen'                                                        +
164700000000                ) +
164800000000                SEV(0) +
164900000000     /*   No replacement variables defined!                         */ +
165000000000                ALROPT(*NO) +
165100000000                CCSID(65535) +
165200000000                /*  -EOF-  */
165300000000
165400000000     /*-------------------------------------------------------------*/
165500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0049                    */
165600000000     /* UnPin Spalten                                               */
165700000000     /*-------------------------------------------------------------*/
165800000000
165900000000             RMVMSGD MSGID(KEY0049) MSGF(&LIB/&OBJ)
166000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
166100000000
166200000000             ADDMSGD +
166300000000                MSGID(KEY0049) +
166400000000                MSGF(&LIB/&OBJ) +
166500000000                MSG( +
166600000000'UnPin Spalten'                                                       +
166700000000                ) +
166800000000                SEV(0) +
166900000000     /*   No replacement variables defined!                         */ +
167000000000                ALROPT(*NO) +
167100000000                CCSID(65535) +
167200000000                /*  -EOF-  */
167300000000
167400000000     /*-------------------------------------------------------------*/
167500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0050                    */
167600000000     /* Layout                                                      */
167700000000     /*-------------------------------------------------------------*/
167800000000
167900000000             RMVMSGD MSGID(KEY0050) MSGF(&LIB/&OBJ)
168000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
168100000000
168200000000             ADDMSGD +
168300000000                MSGID(KEY0050) +
168400000000                MSGF(&LIB/&OBJ) +
168500000000                MSG( +
168600000000'Layout'                                                              +
168700000000                ) +
168800000000                SEV(0) +
168900000000     /*   No replacement variables defined!                         */ +
169000000000                ALROPT(*NO) +
169100000000                CCSID(65535) +
169200000000                /*  -EOF-  */
169300000000
169400000000     /*-------------------------------------------------------------*/
169500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0051                    */
169600000000     /* Key-Felder                                                  */
169700000000     /*-------------------------------------------------------------*/
169800000000
169900000000             RMVMSGD MSGID(KEY0051) MSGF(&LIB/&OBJ)
170000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
170100000000
170200000000             ADDMSGD +
170300000000                MSGID(KEY0051) +
170400000000                MSGF(&LIB/&OBJ) +
170500000000                MSG( +
170600000000'Key-Felder'                                                          +
170700000000                ) +
170800000000                SEV(0) +
170900000000     /*   No replacement variables defined!                         */ +
171000000000                ALROPT(*NO) +
171100000000                CCSID(65535) +
171200000000                /*  -EOF-  */
171300000000
171400000000     /*-------------------------------------------------------------*/
171500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0052                    */
171600000000     /* Auswahl                                                     */
171700000000     /*-------------------------------------------------------------*/
171800000000
171900000000             RMVMSGD MSGID(KEY0052) MSGF(&LIB/&OBJ)
172000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
172100000000
172200000000             ADDMSGD +
172300000000                MSGID(KEY0052) +
172400000000                MSGF(&LIB/&OBJ) +
172500000000                MSG( +
172600000000'Auswahl'                                                             +
172700000000                ) +
172800000000                SEV(0) +
172900000000     /*   No replacement variables defined!                         */ +
173000000000                ALROPT(*NO) +
173100000000                CCSID(65535) +
173200000000                /*  -EOF-  */
173300000000
173400000000     /*-------------------------------------------------------------*/
173500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0053                    */
173600000000     /* Nächste Mark.                                               */
173700000000     /*-------------------------------------------------------------*/
173800000000
173900000000             RMVMSGD MSGID(KEY0053) MSGF(&LIB/&OBJ)
174000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
174100000000
174200000000             ADDMSGD +
174300000000                MSGID(KEY0053) +
174400000000                MSGF(&LIB/&OBJ) +
174500000000                MSG( +
174600000000'Nächste Mark.'                                                       +
174700000000                ) +
174800000000                SEV(0) +
174900000000     /*   No replacement variables defined!                         */ +
175000000000                ALROPT(*NO) +
175100000000                CCSID(65535) +
175200000000                /*  -EOF-  */
175300000000
175400000000     /*-------------------------------------------------------------*/
175500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0054                    */
175600000000     /* Vorherige Mark.                                             */
175700000000     /*-------------------------------------------------------------*/
175800000000
175900000000             RMVMSGD MSGID(KEY0054) MSGF(&LIB/&OBJ)
176000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
176100000000
176200000000             ADDMSGD +
176300000000                MSGID(KEY0054) +
176400000000                MSGF(&LIB/&OBJ) +
176500000000                MSG( +
176600000000'Vorherige Mark.'                                                     +
176700000000                ) +
176800000000                SEV(0) +
176900000000     /*   No replacement variables defined!                         */ +
177000000000                ALROPT(*NO) +
177100000000                CCSID(65535) +
177200000000                /*  -EOF-  */
177300000000
177400000000     /*-------------------------------------------------------------*/
177500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0055                    */
177600000000     /* Relationen                                                  */
177700000000     /*-------------------------------------------------------------*/
177800000000
177900000000             RMVMSGD MSGID(KEY0055) MSGF(&LIB/&OBJ)
178000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
178100000000
178200000000             ADDMSGD +
178300000000                MSGID(KEY0055) +
178400000000                MSGF(&LIB/&OBJ) +
178500000000                MSG( +
178600000000'Relationen'                                                          +
178700000000                ) +
178800000000                SEV(0) +
178900000000     /*   No replacement variables defined!                         */ +
179000000000                ALROPT(*NO) +
179100000000                CCSID(65535) +
179200000000                /*  -EOF-  */
179300000000
179400000000     /*-------------------------------------------------------------*/
179500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0056                    */
179600000000     /* Bedienerführung                                             */
179700000000     /*-------------------------------------------------------------*/
179800000000
179900000000             RMVMSGD MSGID(KEY0056) MSGF(&LIB/&OBJ)
180000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
180100000000
180200000000             ADDMSGD +
180300000000                MSGID(KEY0056) +
180400000000                MSGF(&LIB/&OBJ) +
180500000000                MSG( +
180600000000'Bedienerführung'                                                     +
180700000000                ) +
180800000000                SEV(0) +
180900000000     /*   No replacement variables defined!                         */ +
181000000000                ALROPT(*NO) +
181100000000                CCSID(65535) +
181200000000                /*  -EOF-  */
181300000000
181400000000     /*-------------------------------------------------------------*/
181500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0057                    */
181600000000     /* Schlüsselfolge                                              */
181700000000     /*-------------------------------------------------------------*/
181800000000
181900000000             RMVMSGD MSGID(KEY0057) MSGF(&LIB/&OBJ)
182000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
182100000000
182200000000             ADDMSGD +
182300000000                MSGID(KEY0057) +
182400000000                MSGF(&LIB/&OBJ) +
182500000000                MSG( +
182600000000'Schlüsselfolge'                                                      +
182700000000                ) +
182800000000                SEV(0) +
182900000000     /*   No replacement variables defined!                         */ +
183000000000                ALROPT(*NO) +
183100000000                CCSID(65535) +
183200000000                /*  -EOF-  */
183300000000
183400000000     /*-------------------------------------------------------------*/
183500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0058                    */
183600000000     /* Satzfolge                                                   */
183700000000     /*-------------------------------------------------------------*/
183800000000
183900000000             RMVMSGD MSGID(KEY0058) MSGF(&LIB/&OBJ)
184000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
184100000000
184200000000             ADDMSGD +
184300000000                MSGID(KEY0058) +
184400000000                MSGF(&LIB/&OBJ) +
184500000000                MSG( +
184600000000'Satzfolge'                                                           +
184700000000                ) +
184800000000                SEV(0) +
184900000000     /*   No replacement variables defined!                         */ +
185000000000                ALROPT(*NO) +
185100000000                CCSID(65535) +
185200000000                /*  -EOF-  */
185300000000
185400000000     /*-------------------------------------------------------------*/
185500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0059                    */
185600000000     /* Key/RRN                                                     */
185700000000     /*-------------------------------------------------------------*/
185800000000
185900000000             RMVMSGD MSGID(KEY0059) MSGF(&LIB/&OBJ)
186000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
186100000000
186200000000             ADDMSGD +
186300000000                MSGID(KEY0059) +
186400000000                MSGF(&LIB/&OBJ) +
186500000000                MSG( +
186600000000'Key/RRN'                                                             +
186700000000                ) +
186800000000                SEV(0) +
186900000000     /*   No replacement variables defined!                         */ +
187000000000                ALROPT(*NO) +
187100000000                CCSID(65535) +
187200000000                /*  -EOF-  */
187300000000
187400000000     /*-------------------------------------------------------------*/
187500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0060                    */
187600000000     /* Hex-Edit                                                    */
187700000000     /*-------------------------------------------------------------*/
187800000000
187900000000             RMVMSGD MSGID(KEY0060) MSGF(&LIB/&OBJ)
188000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
188100000000
188200000000             ADDMSGD +
188300000000                MSGID(KEY0060) +
188400000000                MSGF(&LIB/&OBJ) +
188500000000                MSG( +
188600000000'Hex-Edit'                                                            +
188700000000                ) +
188800000000                SEV(0) +
188900000000     /*   No replacement variables defined!                         */ +
189000000000                ALROPT(*NO) +
189100000000                CCSID(65535) +
189200000000                /*  -EOF-  */
189300000000
189400000000     /*-------------------------------------------------------------*/
189500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0061                    */
189600000000     /* Info                                                        */
189700000000     /*-------------------------------------------------------------*/
189800000000
189900000000             RMVMSGD MSGID(KEY0061) MSGF(&LIB/&OBJ)
190000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
190100000000
190200000000             ADDMSGD +
190300000000                MSGID(KEY0061) +
190400000000                MSGF(&LIB/&OBJ) +
190500000000                MSG( +
190600000000'Info'                                                                +
190700000000                ) +
190800000000                SEV(0) +
190900000000     /*   No replacement variables defined!                         */ +
191000000000                ALROPT(*NO) +
191100000000                CCSID(65535) +
191200000000                /*  -EOF-  */
191300000000
191400000000     /*-------------------------------------------------------------*/
191500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0062                    */
191600000000     /* Spalten pinnen                                              */
191700000000     /*-------------------------------------------------------------*/
191800000000
191900000000             RMVMSGD MSGID(KEY0062) MSGF(&LIB/&OBJ)
192000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
192100000000
192200000000             ADDMSGD +
192300000000                MSGID(KEY0062) +
192400000000                MSGF(&LIB/&OBJ) +
192500000000                MSG( +
192600000000'Spalten pinnen'                                                      +
192700000000                ) +
192800000000                SEV(0) +
192900000000     /*   No replacement variables defined!                         */ +
193000000000                ALROPT(*NO) +
193100000000                CCSID(65535) +
193200000000                /*  -EOF-  */
193300000000
193400000000     /*-------------------------------------------------------------*/
193500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0063                    */
193600000000     /* Alles Löschen                                               */
193700000000     /*-------------------------------------------------------------*/
193800000000
193900000000             RMVMSGD MSGID(KEY0063) MSGF(&LIB/&OBJ)
194000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
194100000000
194200000000             ADDMSGD +
194300000000                MSGID(KEY0063) +
194400000000                MSGF(&LIB/&OBJ) +
194500000000                MSG( +
194600000000'Alles Löschen'                                                       +
194700000000                ) +
194800000000                SEV(0) +
194900000000     /*   No replacement variables defined!                         */ +
195000000000                ALROPT(*NO) +
195100000000                CCSID(65535) +
195200000000                /*  -EOF-  */
195300000000
195400000000     /*-------------------------------------------------------------*/
195500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0064                    */
195600000000     /* Norm. Anzeige                                               */
195700000000     /*-------------------------------------------------------------*/
195800000000
195900000000             RMVMSGD MSGID(KEY0064) MSGF(&LIB/&OBJ)
196000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
196100000000
196200000000             ADDMSGD +
196300000000                MSGID(KEY0064) +
196400000000                MSGF(&LIB/&OBJ) +
196500000000                MSG( +
196600000000'Norm. Anzeige'                                                       +
196700000000                ) +
196800000000                SEV(0) +
196900000000     /*   No replacement variables defined!                         */ +
197000000000                ALROPT(*NO) +
197100000000                CCSID(65535) +
197200000000                /*  -EOF-  */
197300000000
197400000000     /*-------------------------------------------------------------*/
197500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0065                    */
197600000000     /* Hex-Anzeige                                                 */
197700000000     /*-------------------------------------------------------------*/
197800000000
197900000000             RMVMSGD MSGID(KEY0065) MSGF(&LIB/&OBJ)
198000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
198100000000
198200000000             ADDMSGD +
198300000000                MSGID(KEY0065) +
198400000000                MSGF(&LIB/&OBJ) +
198500000000                MSG( +
198600000000'Hex-Anzeige'                                                         +
198700000000                ) +
198800000000                SEV(0) +
198900000000     /*   No replacement variables defined!                         */ +
199000000000                ALROPT(*NO) +
199100000000                CCSID(65535) +
199200000000                /*  -EOF-  */
199300000000
199400000000     /*-------------------------------------------------------------*/
199500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0066                    */
199600000000     /* Umsch.Anzeige                                               */
199700000000     /*-------------------------------------------------------------*/
199800000000
199900000000             RMVMSGD MSGID(KEY0066) MSGF(&LIB/&OBJ)
200000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
200100000000
200200000000             ADDMSGD +
200300000000                MSGID(KEY0066) +
200400000000                MSGF(&LIB/&OBJ) +
200500000000                MSG( +
200600000000'Umsch.Anzeige'                                                       +
200700000000                ) +
200800000000                SEV(0) +
200900000000     /*   No replacement variables defined!                         */ +
201000000000                ALROPT(*NO) +
201100000000                CCSID(65535) +
201200000000                /*  -EOF-  */
201300000000
201400000000     /*-------------------------------------------------------------*/
201500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0067                    */
201600000000     /* SQL-Auswahl                                                 */
201700000000     /*-------------------------------------------------------------*/
201800000000
201900000000             RMVMSGD MSGID(KEY0067) MSGF(&LIB/&OBJ)
202000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
202100000000
202200000000             ADDMSGD +
202300000000                MSGID(KEY0067) +
202400000000                MSGF(&LIB/&OBJ) +
202500000000                MSG( +
202600000000'SQL-Auswahl'                                                         +
202700000000                ) +
202800000000                SEV(0) +
202900000000     /*   No replacement variables defined!                         */ +
203000000000                ALROPT(*NO) +
203100000000                CCSID(65535) +
203200000000                /*  -EOF-  */
203300000000
203400000000     /*-------------------------------------------------------------*/
203500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0068                    */
203600000000     /* Einf.Schl.Fld.                                              */
203700000000     /*-------------------------------------------------------------*/
203800000000
203900000000             RMVMSGD MSGID(KEY0068) MSGF(&LIB/&OBJ)
204000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
204100000000
204200000000             ADDMSGD +
204300000000                MSGID(KEY0068) +
204400000000                MSGF(&LIB/&OBJ) +
204500000000                MSG( +
204600000000'Einf.Schl.Fld.'                                                      +
204700000000                ) +
204800000000                SEV(0) +
204900000000     /*   No replacement variables defined!                         */ +
205000000000                ALROPT(*NO) +
205100000000                CCSID(65535) +
205200000000                /*  -EOF-  */
205300000000
205400000000     /*-------------------------------------------------------------*/
205500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0069                    */
205600000000     /* Sichern Arbeitsumgebung                                     */
205700000000     /*-------------------------------------------------------------*/
205800000000
205900000000             RMVMSGD MSGID(KEY0069) MSGF(&LIB/&OBJ)
206000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
206100000000
206200000000             ADDMSGD +
206300000000                MSGID(KEY0069) +
206400000000                MSGF(&LIB/&OBJ) +
206500000000                MSG( +
206600000000'Sichern Arbeitsumgebung'                                             +
206700000000                ) +
206800000000                SEV(0) +
206900000000     /*   No replacement variables defined!                         */ +
207000000000                ALROPT(*NO) +
207100000000                CCSID(65535) +
207200000000                /*  -EOF-  */
207300000000
207400000000     /*-------------------------------------------------------------*/
207500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0070                    */
207600000000     /* Laden Arbeitsumgebung                                       */
207700000000     /*-------------------------------------------------------------*/
207800000000
207900000000             RMVMSGD MSGID(KEY0070) MSGF(&LIB/&OBJ)
208000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
208100000000
208200000000             ADDMSGD +
208300000000                MSGID(KEY0070) +
208400000000                MSGF(&LIB/&OBJ) +
208500000000                MSG( +
208600000000'Laden Arbeitsumgebung'                                               +
208700000000                ) +
208800000000                SEV(0) +
208900000000     /*   No replacement variables defined!                         */ +
209000000000                ALROPT(*NO) +
209100000000                CCSID(65535) +
209200000000                /*  -EOF-  */
209300000000
209400000000     /*-------------------------------------------------------------*/
209500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0071                    */
209600000000     /* Löschen Arb.Umg                                             */
209700000000     /*-------------------------------------------------------------*/
209800000000
209900000000             RMVMSGD MSGID(KEY0071) MSGF(&LIB/&OBJ)
210000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
210100000000
210200000000             ADDMSGD +
210300000000                MSGID(KEY0071) +
210400000000                MSGF(&LIB/&OBJ) +
210500000000                MSG( +
210600000000'Löschen Arb.Umg'                                                     +
210700000000                ) +
210800000000                SEV(0) +
210900000000     /*   No replacement variables defined!                         */ +
211000000000                ALROPT(*NO) +
211100000000                CCSID(65535) +
211200000000                /*  -EOF-  */
211300000000
211400000000     /*-------------------------------------------------------------*/
211500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0072                    */
211600000000     /* Sortierfolge                                                */
211700000000     /*-------------------------------------------------------------*/
211800000000
211900000000             RMVMSGD MSGID(KEY0072) MSGF(&LIB/&OBJ)
212000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
212100000000
212200000000             ADDMSGD +
212300000000                MSGID(KEY0072) +
212400000000                MSGF(&LIB/&OBJ) +
212500000000                MSG( +
212600000000'Sortierfolge'                                                        +
212700000000                ) +
212800000000                SEV(0) +
212900000000     /*   No replacement variables defined!                         */ +
213000000000                ALROPT(*NO) +
213100000000                CCSID(65535) +
213200000000                /*  -EOF-  */
213300000000
213400000000     /*-------------------------------------------------------------*/
213500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0073                    */
213600000000     /* Ja                                                          */
213700000000     /*-------------------------------------------------------------*/
213800000000
213900000000             RMVMSGD MSGID(KEY0073) MSGF(&LIB/&OBJ)
214000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
214100000000
214200000000             ADDMSGD +
214300000000                MSGID(KEY0073) +
214400000000                MSGF(&LIB/&OBJ) +
214500000000                MSG( +
214600000000'Ja'                                                                  +
214700000000                ) +
214800000000                SEV(0) +
214900000000     /*   No replacement variables defined!                         */ +
215000000000                ALROPT(*NO) +
215100000000                CCSID(65535) +
215200000000                /*  -EOF-  */
215300000000
215400000000     /*-------------------------------------------------------------*/
215500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0074                    */
215600000000     /* Nein                                                        */
215700000000     /*-------------------------------------------------------------*/
215800000000
215900000000             RMVMSGD MSGID(KEY0074) MSGF(&LIB/&OBJ)
216000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
216100000000
216200000000             ADDMSGD +
216300000000                MSGID(KEY0074) +
216400000000                MSGF(&LIB/&OBJ) +
216500000000                MSG( +
216600000000'Nein'                                                                +
216700000000                ) +
216800000000                SEV(0) +
216900000000     /*   No replacement variables defined!                         */ +
217000000000                ALROPT(*NO) +
217100000000                CCSID(65535) +
217200000000                /*  -EOF-  */
217300000000
217400000000     /*-------------------------------------------------------------*/
217500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0075                    */
217600000000     /* OK                                                          */
217700000000     /*-------------------------------------------------------------*/
217800000000
217900000000             RMVMSGD MSGID(KEY0075) MSGF(&LIB/&OBJ)
218000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
218100000000
218200000000             ADDMSGD +
218300000000                MSGID(KEY0075) +
218400000000                MSGF(&LIB/&OBJ) +
218500000000                MSG( +
218600000000'OK'                                                                  +
218700000000                ) +
218800000000                SEV(0) +
218900000000     /*   No replacement variables defined!                         */ +
219000000000                ALROPT(*NO) +
219100000000                CCSID(65535) +
219200000000                /*  -EOF-  */
219300000000
219400000000     /*-------------------------------------------------------------*/
219500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0076                    */
219600000000     /* Anfang                                                      */
219700000000     /*-------------------------------------------------------------*/
219800000000
219900000000             RMVMSGD MSGID(KEY0076) MSGF(&LIB/&OBJ)
220000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
220100000000
220200000000             ADDMSGD +
220300000000                MSGID(KEY0076) +
220400000000                MSGF(&LIB/&OBJ) +
220500000000                MSG( +
220600000000'Anfang'                                                              +
220700000000                ) +
220800000000                SEV(0) +
220900000000     /*   No replacement variables defined!                         */ +
221000000000                ALROPT(*NO) +
221100000000                CCSID(65535) +
221200000000                /*  -EOF-  */
221300000000
221400000000     /*-------------------------------------------------------------*/
221500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0077                    */
221600000000     /* Ende                                                        */
221700000000     /*-------------------------------------------------------------*/
221800000000
221900000000             RMVMSGD MSGID(KEY0077) MSGF(&LIB/&OBJ)
222000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
222100000000
222200000000             ADDMSGD +
222300000000                MSGID(KEY0077) +
222400000000                MSGF(&LIB/&OBJ) +
222500000000                MSG( +
222600000000'Ende'                                                                +
222700000000                ) +
222800000000                SEV(0) +
222900000000     /*   No replacement variables defined!                         */ +
223000000000                ALROPT(*NO) +
223100000000                CCSID(65535) +
223200000000                /*  -EOF-  */
223300000000
223400000000     /*-------------------------------------------------------------*/
223500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0078                    */
223600000000     /* Umgebung                                                    */
223700000000     /*-------------------------------------------------------------*/
223800000000
223900000000             RMVMSGD MSGID(KEY0078) MSGF(&LIB/&OBJ)
224000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
224100000000
224200000000             ADDMSGD +
224300000000                MSGID(KEY0078) +
224400000000                MSGF(&LIB/&OBJ) +
224500000000                MSG( +
224600000000'Umgebung'                                                            +
224700000000                ) +
224800000000                SEV(0) +
224900000000     /*   No replacement variables defined!                         */ +
225000000000                ALROPT(*NO) +
225100000000                CCSID(65535) +
225200000000                /*  -EOF-  */
225300000000
225400000000     /*-------------------------------------------------------------*/
225500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0079                    */
225600000000     /* nur Layout                                                  */
225700000000     /*-------------------------------------------------------------*/
225800000000
225900000000             RMVMSGD MSGID(KEY0079) MSGF(&LIB/&OBJ)
226000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
226100000000
226200000000             ADDMSGD +
226300000000                MSGID(KEY0079) +
226400000000                MSGF(&LIB/&OBJ) +
226500000000                MSG( +
226600000000'nur Layout'                                                          +
226700000000                ) +
226800000000                SEV(0) +
226900000000     /*   No replacement variables defined!                         */ +
227000000000                ALROPT(*NO) +
227100000000                CCSID(65535) +
227200000000                /*  -EOF-  */
227300000000
227400000000     /*-------------------------------------------------------------*/
227500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0080                    */
227600000000     /* Umsch. NULL-Ind.                                            */
227700000000     /*-------------------------------------------------------------*/
227800000000
227900000000             RMVMSGD MSGID(KEY0080) MSGF(&LIB/&OBJ)
228000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
228100000000
228200000000             ADDMSGD +
228300000000                MSGID(KEY0080) +
228400000000                MSGF(&LIB/&OBJ) +
228500000000                MSG( +
228600000000'Umsch. NULL-Ind.'                                                    +
228700000000                ) +
228800000000                SEV(0) +
228900000000     /*   No replacement variables defined!                         */ +
229000000000                ALROPT(*NO) +
229100000000                CCSID(65535) +
229200000000                /*  -EOF-  */
229300000000
229400000000     /*-------------------------------------------------------------*/
229500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0081                    */
229600000000     /* Umsch. Eingabe                                              */
229700000000     /*-------------------------------------------------------------*/
229800000000
229900000000             RMVMSGD MSGID(KEY0081) MSGF(&LIB/&OBJ)
230000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
230100000000
230200000000             ADDMSGD +
230300000000                MSGID(KEY0081) +
230400000000                MSGF(&LIB/&OBJ) +
230500000000                MSG( +
230600000000'Umsch. Eingabe'                                                      +
230700000000                ) +
230800000000                SEV(0) +
230900000000     /*   No replacement variables defined!                         */ +
231000000000                ALROPT(*NO) +
231100000000                CCSID(65535) +
231200000000                /*  -EOF-  */
231300000000
231400000000     /*-------------------------------------------------------------*/
231500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0082                    */
231600000000     /* String-Edit                                                 */
231700000000     /*-------------------------------------------------------------*/
231800000000
231900000000             RMVMSGD MSGID(KEY0082) MSGF(&LIB/&OBJ)
232000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
232100000000
232200000000             ADDMSGD +
232300000000                MSGID(KEY0082) +
232400000000                MSGF(&LIB/&OBJ) +
232500000000                MSG( +
232600000000'String-Edit'                                                         +
232700000000                ) +
232800000000                SEV(0) +
232900000000     /*   No replacement variables defined!                         */ +
233000000000                ALROPT(*NO) +
233100000000                CCSID(65535) +
233200000000                /*  -EOF-  */
233300000000
233400000000     /*-------------------------------------------------------------*/
233500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0083                    */
233600000000     /* Satzsperre                                                  */
233700000000     /*-------------------------------------------------------------*/
233800000000
233900000000             RMVMSGD MSGID(KEY0083) MSGF(&LIB/&OBJ)
234000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
234100000000
234200000000             ADDMSGD +
234300000000                MSGID(KEY0083) +
234400000000                MSGF(&LIB/&OBJ) +
234500000000                MSG( +
234600000000'Satzsperre'                                                          +
234700000000                ) +
234800000000                SEV(0) +
234900000000     /*   No replacement variables defined!                         */ +
235000000000                ALROPT(*NO) +
235100000000                CCSID(65535) +
235200000000                /*  -EOF-  */
235300000000
235400000000     /*-------------------------------------------------------------*/
235500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0084                    */
235600000000     /* Aufsetzen Kleinb.                                           */
235700000000     /*-------------------------------------------------------------*/
235800000000
235900000000             RMVMSGD MSGID(KEY0084) MSGF(&LIB/&OBJ)
236000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
236100000000
236200000000             ADDMSGD +
236300000000                MSGID(KEY0084) +
236400000000                MSGF(&LIB/&OBJ) +
236500000000                MSG( +
236600000000'Aufsetzen Kleinb.'                                                   +
236700000000                ) +
236800000000                SEV(0) +
236900000000     /*   No replacement variables defined!                         */ +
237000000000                ALROPT(*NO) +
237100000000                CCSID(65535) +
237200000000                /*  -EOF-  */
237300000000
237400000000     /*-------------------------------------------------------------*/
237500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0085                    */
237600000000     /* Drucken                                                     */
237700000000     /*-------------------------------------------------------------*/
237800000000
237900000000             RMVMSGD MSGID(KEY0085) MSGF(&LIB/&OBJ)
238000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
238100000000
238200000000             ADDMSGD +
238300000000                MSGID(KEY0085) +
238400000000                MSGF(&LIB/&OBJ) +
238500000000                MSG( +
238600000000'Drucken'                                                             +
238700000000                ) +
238800000000                SEV(0) +
238900000000     /*   No replacement variables defined!                         */ +
239000000000                ALROPT(*NO) +
239100000000                CCSID(65535) +
239200000000                /*  -EOF-  */
239300000000
239400000000     /*-------------------------------------------------------------*/
239500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0086                    */
239600000000     /* Einfügen                                                    */
239700000000     /*-------------------------------------------------------------*/
239800000000
239900000000             RMVMSGD MSGID(KEY0086) MSGF(&LIB/&OBJ)
240000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
240100000000
240200000000             ADDMSGD +
240300000000                MSGID(KEY0086) +
240400000000                MSGF(&LIB/&OBJ) +
240500000000                MSG( +
240600000000'Einfügen'                                                            +
240700000000                ) +
240800000000                SEV(0) +
240900000000     /*   No replacement variables defined!                         */ +
241000000000                ALROPT(*NO) +
241100000000                CCSID(65535) +
241200000000                /*  -EOF-  */
241300000000
241400000000     /*-------------------------------------------------------------*/
241500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0087                    */
241600000000     /* Löschen                                                     */
241700000000     /*-------------------------------------------------------------*/
241800000000
241900000000             RMVMSGD MSGID(KEY0087) MSGF(&LIB/&OBJ)
242000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
242100000000
242200000000             ADDMSGD +
242300000000                MSGID(KEY0087) +
242400000000                MSGF(&LIB/&OBJ) +
242500000000                MSG( +
242600000000'Löschen'                                                             +
242700000000                ) +
242800000000                SEV(0) +
242900000000     /*   No replacement variables defined!                         */ +
243000000000                ALROPT(*NO) +
243100000000                CCSID(65535) +
243200000000                /*  -EOF-  */
243300000000
243400000000     /*-------------------------------------------------------------*/
243500000000     /*   Cmd-ADDMSGD für Message-ID :   MBX0001                    */
243600000000     /* Information                                                 */
243700000000     /*-------------------------------------------------------------*/
243800000000
243900000000             RMVMSGD MSGID(MBX0001) MSGF(&LIB/&OBJ)
244000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
244100000000
244200000000             ADDMSGD +
244300000000                MSGID(MBX0001) +
244400000000                MSGF(&LIB/&OBJ) +
244500000000                MSG( +
244600000000'Information'                                                         +
244700000000                ) +
244800000000                SEV(0) +
244900000000     /*   No replacement variables defined!                         */ +
245000000000                ALROPT(*NO) +
245100000000                CCSID(65535) +
245200000000                /*  -EOF-  */
245300000000
245400000000     /*-------------------------------------------------------------*/
245500000000     /*   Cmd-ADDMSGD für Message-ID :   MBX0002                    */
245600000000     /* Frage                                                       */
245700000000     /*-------------------------------------------------------------*/
245800000000
245900000000             RMVMSGD MSGID(MBX0002) MSGF(&LIB/&OBJ)
246000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
246100000000
246200000000             ADDMSGD +
246300000000                MSGID(MBX0002) +
246400000000                MSGF(&LIB/&OBJ) +
246500000000                MSG( +
246600000000'Frage'                                                               +
246700000000                ) +
246800000000                SEV(0) +
246900000000     /*   No replacement variables defined!                         */ +
247000000000                ALROPT(*NO) +
247100000000                CCSID(65535) +
247200000000                /*  -EOF-  */
247300000000
247400000000     /*-------------------------------------------------------------*/
247500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0001                    */
247600000000     /* Datei                                                       */
247700000000     /*-------------------------------------------------------------*/
247800000000
247900000000             RMVMSGD MSGID(PMT0001) MSGF(&LIB/&OBJ)
248000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
248100000000
248200000000             ADDMSGD +
248300000000                MSGID(PMT0001) +
248400000000                MSGF(&LIB/&OBJ) +
248500000000                MSG( +
248600000000'Datei'                                                               +
248700000000                ) +
248800000000                SEV(0) +
248900000000     /*   No replacement variables defined!                         */ +
249000000000                ALROPT(*NO) +
249100000000                CCSID(65535) +
249200000000                /*  -EOF-  */
249300000000
249400000000     /*-------------------------------------------------------------*/
249500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0002                    */
249600000000     /* Teildatei                                                   */
249700000000     /*-------------------------------------------------------------*/
249800000000
249900000000             RMVMSGD MSGID(PMT0002) MSGF(&LIB/&OBJ)
250000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
250100000000
250200000000             ADDMSGD +
250300000000                MSGID(PMT0002) +
250400000000                MSGF(&LIB/&OBJ) +
250500000000                MSG( +
250600000000'Teildatei'                                                           +
250700000000                ) +
250800000000                SEV(0) +
250900000000     /*   No replacement variables defined!                         */ +
251000000000                ALROPT(*NO) +
251100000000                CCSID(65535) +
251200000000                /*  -EOF-  */
251300000000
251400000000     /*-------------------------------------------------------------*/
251500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0003                    */
251600000000     /* Zugriffsart                                                 */
251700000000     /*-------------------------------------------------------------*/
251800000000
251900000000             RMVMSGD MSGID(PMT0003) MSGF(&LIB/&OBJ)
252000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
252100000000
252200000000             ADDMSGD +
252300000000                MSGID(PMT0003) +
252400000000                MSGF(&LIB/&OBJ) +
252500000000                MSG( +
252600000000'Zugriffsart'                                                         +
252700000000                ) +
252800000000                SEV(0) +
252900000000     /*   No replacement variables defined!                         */ +
253000000000                ALROPT(*NO) +
253100000000                CCSID(65535) +
253200000000                /*  -EOF-  */
253300000000
253400000000     /*-------------------------------------------------------------*/
253500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0004                    */
253600000000     /* Sprache                                                     */
253700000000     /*-------------------------------------------------------------*/
253800000000
253900000000             RMVMSGD MSGID(PMT0004) MSGF(&LIB/&OBJ)
254000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
254100000000
254200000000             ADDMSGD +
254300000000                MSGID(PMT0004) +
254400000000                MSGF(&LIB/&OBJ) +
254500000000                MSG( +
254600000000'Sprache'                                                             +
254700000000                ) +
254800000000                SEV(0) +
254900000000     /*   No replacement variables defined!                         */ +
255000000000                ALROPT(*NO) +
255100000000                CCSID(65535) +
255200000000                /*  -EOF-  */
255300000000
255400000000     /*-------------------------------------------------------------*/
255500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0005                    */
255600000000     /* Ändern Bibliothek erlaubt                                   */
255700000000     /*-------------------------------------------------------------*/
255800000000
255900000000             RMVMSGD MSGID(PMT0005) MSGF(&LIB/&OBJ)
256000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
256100000000
256200000000             ADDMSGD +
256300000000                MSGID(PMT0005) +
256400000000                MSGF(&LIB/&OBJ) +
256500000000                MSG( +
256600000000'Ändern Bibliothek erlaubt'                                           +
256700000000                ) +
256800000000                SEV(0) +
256900000000     /*   No replacement variables defined!                         */ +
257000000000                ALROPT(*NO) +
257100000000                CCSID(65535) +
257200000000                /*  -EOF-  */
257300000000
257400000000     /*-------------------------------------------------------------*/
257500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0006                    */
257600000000     /* Ändern Datei erlaubt                                        */
257700000000     /*-------------------------------------------------------------*/
257800000000
257900000000             RMVMSGD MSGID(PMT0006) MSGF(&LIB/&OBJ)
258000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
258100000000
258200000000             ADDMSGD +
258300000000                MSGID(PMT0006) +
258400000000                MSGF(&LIB/&OBJ) +
258500000000                MSG( +
258600000000'Ändern Datei erlaubt'                                                +
258700000000                ) +
258800000000                SEV(0) +
258900000000     /*   No replacement variables defined!                         */ +
259000000000                ALROPT(*NO) +
259100000000                CCSID(65535) +
259200000000                /*  -EOF-  */
259300000000
259400000000     /*-------------------------------------------------------------*/
259500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0007                    */
259600000000     /* Ändern Teildatei erlaubt                                    */
259700000000     /*-------------------------------------------------------------*/
259800000000
259900000000             RMVMSGD MSGID(PMT0007) MSGF(&LIB/&OBJ)
260000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
260100000000
260200000000             ADDMSGD +
260300000000                MSGID(PMT0007) +
260400000000                MSGF(&LIB/&OBJ) +
260500000000                MSG( +
260600000000'Ändern Teildatei erlaubt'                                            +
260700000000                ) +
260800000000                SEV(0) +
260900000000     /*   No replacement variables defined!                         */ +
261000000000                ALROPT(*NO) +
261100000000                CCSID(65535) +
261200000000                /*  -EOF-  */
261300000000
261400000000     /*-------------------------------------------------------------*/
261500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0008                    */
261600000000     /* Ändern Datensätze erlaubt                                   */
261700000000     /*-------------------------------------------------------------*/
261800000000
261900000000             RMVMSGD MSGID(PMT0008) MSGF(&LIB/&OBJ)
262000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
262100000000
262200000000             ADDMSGD +
262300000000                MSGID(PMT0008) +
262400000000                MSGF(&LIB/&OBJ) +
262500000000                MSG( +
262600000000'Ändern Datensätze erlaubt'                                           +
262700000000                ) +
262800000000                SEV(0) +
262900000000     /*   No replacement variables defined!                         */ +
263000000000                ALROPT(*NO) +
263100000000                CCSID(65535) +
263200000000                /*  -EOF-  */
263300000000
263400000000     /*-------------------------------------------------------------*/
263500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0009                    */
263600000000     /* Ändern SQL WHERE erlaubt                                    */
263700000000     /*-------------------------------------------------------------*/
263800000000
263900000000             RMVMSGD MSGID(PMT0009) MSGF(&LIB/&OBJ)
264000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
264100000000
264200000000             ADDMSGD +
264300000000                MSGID(PMT0009) +
264400000000                MSGF(&LIB/&OBJ) +
264500000000                MSG( +
264600000000'Ändern SQL WHERE erlaubt'                                            +
264700000000                ) +
264800000000                SEV(0) +
264900000000     /*   No replacement variables defined!                         */ +
265000000000                ALROPT(*NO) +
265100000000                CCSID(65535) +
265200000000                /*  -EOF-  */
265300000000
265400000000     /*-------------------------------------------------------------*/
265500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0010                    */
265600000000     /* Ändern SQL ORDER BY erlaubt                                 */
265700000000     /*-------------------------------------------------------------*/
265800000000
265900000000             RMVMSGD MSGID(PMT0010) MSGF(&LIB/&OBJ)
266000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
266100000000
266200000000             ADDMSGD +
266300000000                MSGID(PMT0010) +
266400000000                MSGF(&LIB/&OBJ) +
266500000000                MSG( +
266600000000'Ändern SQL ORDER BY erlaubt'                                         +
266700000000                ) +
266800000000                SEV(0) +
266900000000     /*   No replacement variables defined!                         */ +
267000000000                ALROPT(*NO) +
267100000000                CCSID(65535) +
267200000000                /*  -EOF-  */
267300000000
267400000000     /*-------------------------------------------------------------*/
267500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0011                    */
267600000000     /* Arbeitsumgebung                                             */
267700000000     /*-------------------------------------------------------------*/
267800000000
267900000000             RMVMSGD MSGID(PMT0011) MSGF(&LIB/&OBJ)
268000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
268100000000
268200000000             ADDMSGD +
268300000000                MSGID(PMT0011) +
268400000000                MSGF(&LIB/&OBJ) +
268500000000                MSG( +
268600000000'Arbeitsumgebung'                                                     +
268700000000                ) +
268800000000                SEV(0) +
268900000000     /*   No replacement variables defined!                         */ +
269000000000                ALROPT(*NO) +
269100000000                CCSID(65535) +
269200000000                /*  -EOF-  */
269300000000
269400000000     /*-------------------------------------------------------------*/
269500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0012                    */
269600000000     /*   Teildatei                                                 */
269700000000     /*-------------------------------------------------------------*/
269800000000
269900000000             RMVMSGD MSGID(PMT0012) MSGF(&LIB/&OBJ)
270000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
270100000000
270200000000             ADDMSGD +
270300000000                MSGID(PMT0012) +
270400000000                MSGF(&LIB/&OBJ) +
270500000000                MSG( +
270600000000'  Teildatei'                                                         +
270700000000                ) +
270800000000                SEV(0) +
270900000000     /*   No replacement variables defined!                         */ +
271000000000                ALROPT(*NO) +
271100000000                CCSID(65535) +
271200000000                /*  -EOF-  */
271300000000
271400000000     /*-------------------------------------------------------------*/
271500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0013                    */
271600000000     /* SQL WHERE                                                   */
271700000000     /*-------------------------------------------------------------*/
271800000000
271900000000             RMVMSGD MSGID(PMT0013) MSGF(&LIB/&OBJ)
272000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
272100000000
272200000000             ADDMSGD +
272300000000                MSGID(PMT0013) +
272400000000                MSGF(&LIB/&OBJ) +
272500000000                MSG( +
272600000000'SQL WHERE'                                                           +
272700000000                ) +
272800000000                SEV(0) +
272900000000     /*   No replacement variables defined!                         */ +
273000000000                ALROPT(*NO) +
273100000000                CCSID(65535) +
273200000000                /*  -EOF-  */
273300000000
273400000000     /*-------------------------------------------------------------*/
273500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0014                    */
273600000000     /* SQL ORDER BY                                                */
273700000000     /*-------------------------------------------------------------*/
273800000000
273900000000             RMVMSGD MSGID(PMT0014) MSGF(&LIB/&OBJ)
274000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
274100000000
274200000000             ADDMSGD +
274300000000                MSGID(PMT0014) +
274400000000                MSGF(&LIB/&OBJ) +
274500000000                MSG( +
274600000000'SQL ORDER BY'                                                        +
274700000000                ) +
274800000000                SEV(0) +
274900000000     /*   No replacement variables defined!                         */ +
275000000000                ALROPT(*NO) +
275100000000                CCSID(65535) +
275200000000                /*  -EOF-  */
275300000000
275400000000     /*-------------------------------------------------------------*/
275500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0015                    */
275600000000     /* Bibliothek                                                  */
275700000000     /*-------------------------------------------------------------*/
275800000000
275900000000             RMVMSGD MSGID(PMT0015) MSGF(&LIB/&OBJ)
276000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
276100000000
276200000000             ADDMSGD +
276300000000                MSGID(PMT0015) +
276400000000                MSGF(&LIB/&OBJ) +
276500000000                MSG( +
276600000000'Bibliothek'                                                          +
276700000000                ) +
276800000000                SEV(0) +
276900000000     /*   No replacement variables defined!                         */ +
277000000000                ALROPT(*NO) +
277100000000                CCSID(65535) +
277200000000                /*  -EOF-  */
277300000000
277400000000     /*-------------------------------------------------------------*/
277500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0016                    */
277600000000     /* Benutzereinstellungen                                       */
277700000000     /*-------------------------------------------------------------*/
277800000000
277900000000             RMVMSGD MSGID(PMT0016) MSGF(&LIB/&OBJ)
278000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
278100000000
278200000000             ADDMSGD +
278300000000                MSGID(PMT0016) +
278400000000                MSGF(&LIB/&OBJ) +
278500000000                MSG( +
278600000000'Benutzereinstellungen'                                               +
278700000000                ) +
278800000000                SEV(0) +
278900000000     /*   No replacement variables defined!                         */ +
279000000000                ALROPT(*NO) +
279100000000                CCSID(65535) +
279200000000                /*  -EOF-  */
279300000000
279400000000     /*-------------------------------------------------------------*/
279500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0017                    */
279600000000     /* Benutzerprofil                                              */
279700000000     /*-------------------------------------------------------------*/
279800000000
279900000000             RMVMSGD MSGID(PMT0017) MSGF(&LIB/&OBJ)
280000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
280100000000
280200000000             ADDMSGD +
280300000000                MSGID(PMT0017) +
280400000000                MSGF(&LIB/&OBJ) +
280500000000                MSG( +
280600000000'Benutzerprofil'                                                      +
280700000000                ) +
280800000000                SEV(0) +
280900000000     /*   No replacement variables defined!                         */ +
281000000000                ALROPT(*NO) +
281100000000                CCSID(65535) +
281200000000                /*  -EOF-  */
281300000000
281400000000     /*-------------------------------------------------------------*/
281500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0018                    */
281600000000     /* Speichern beim Verlassen                                    */
281700000000     /*-------------------------------------------------------------*/
281800000000
281900000000             RMVMSGD MSGID(PMT0018) MSGF(&LIB/&OBJ)
282000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
282100000000
282200000000             ADDMSGD +
282300000000                MSGID(PMT0018) +
282400000000                MSGF(&LIB/&OBJ) +
282500000000                MSG( +
282600000000'Speichern beim Verlassen'                                            +
282700000000                ) +
282800000000                SEV(0) +
282900000000     /*   No replacement variables defined!                         */ +
283000000000                ALROPT(*NO) +
283100000000                CCSID(65535) +
283200000000                /*  -EOF-  */
283300000000
283400000000     /*-------------------------------------------------------------*/
283500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0019                    */
283600000000     /* Nur Layout laden                                            */
283700000000     /*-------------------------------------------------------------*/
283800000000
283900000000             RMVMSGD MSGID(PMT0019) MSGF(&LIB/&OBJ)
284000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
284100000000
284200000000             ADDMSGD +
284300000000                MSGID(PMT0019) +
284400000000                MSGF(&LIB/&OBJ) +
284500000000                MSG( +
284600000000'Nur Layout laden'                                                    +
284700000000                ) +
284800000000                SEV(0) +
284900000000     /*   No replacement variables defined!                         */ +
285000000000                ALROPT(*NO) +
285100000000                CCSID(65535) +
285200000000                /*  -EOF-  */
285300000000
285400000000     /*-------------------------------------------------------------*/
285500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0100                    */
285600000000     /* Datenbankbrowser - Peek/400                                 */
285700000000     /*-------------------------------------------------------------*/
285800000000
285900000000             RMVMSGD MSGID(PMT0100) MSGF(&LIB/&OBJ)
286000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
286100000000
286200000000             ADDMSGD +
286300000000                MSGID(PMT0100) +
286400000000                MSGF(&LIB/&OBJ) +
286500000000                MSG( +
286600000000'Datenbankbrowser - Peek/400'                                         +
286700000000                ) +
286800000000                SEV(0) +
286900000000     /*   No replacement variables defined!                         */ +
287000000000                ALROPT(*NO) +
287100000000                CCSID(65535) +
287200000000                /*  -EOF-  */
287300000000
287400000000     /*-------------------------------------------------------------*/
287500000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0101                    */
287600000000     /* Anzeigen Datenbankrelationen                                */
287700000000     /*-------------------------------------------------------------*/
287800000000
287900000000             RMVMSGD MSGID(PMT0101) MSGF(&LIB/&OBJ)
288000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
288100000000
288200000000             ADDMSGD +
288300000000                MSGID(PMT0101) +
288400000000                MSGF(&LIB/&OBJ) +
288500000000                MSG( +
288600000000'Anzeigen Datenbankrelationen'                                        +
288700000000                ) +
288800000000                SEV(0) +
288900000000     /*   No replacement variables defined!                         */ +
289000000000                ALROPT(*NO) +
289100000000                CCSID(65535) +
289200000000                /*  -EOF-  */
289300000000
289400000000     /*-------------------------------------------------------------*/
289500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0001                    */
289600000000     /* Datei:                                                      */
289700000000     /*-------------------------------------------------------------*/
289800000000
289900000000             RMVMSGD MSGID(TXT0001) MSGF(&LIB/&OBJ)
290000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
290100000000
290200000000             ADDMSGD +
290300000000                MSGID(TXT0001) +
290400000000                MSGF(&LIB/&OBJ) +
290500000000                MSG( +
290600000000'Datei:'                                                              +
290700000000                ) +
290800000000                SEV(0) +
290900000000     /*   No replacement variables defined!                         */ +
291000000000                ALROPT(*NO) +
291100000000                CCSID(65535) +
291200000000                /*  -EOF-  */
291300000000
291400000000     /*-------------------------------------------------------------*/
291500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0002                    */
291600000000     /* Bibliothek:                                                 */
291700000000     /*-------------------------------------------------------------*/
291800000000
291900000000             RMVMSGD MSGID(TXT0002) MSGF(&LIB/&OBJ)
292000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
292100000000
292200000000             ADDMSGD +
292300000000                MSGID(TXT0002) +
292400000000                MSGF(&LIB/&OBJ) +
292500000000                MSG( +
292600000000'Bibliothek:'                                                         +
292700000000                ) +
292800000000                SEV(0) +
292900000000     /*   No replacement variables defined!                         */ +
293000000000                ALROPT(*NO) +
293100000000                CCSID(65535) +
293200000000                /*  -EOF-  */
293300000000
293400000000     /*-------------------------------------------------------------*/
293500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0003                    */
293600000000     /* Teildatei:                                                  */
293700000000     /*-------------------------------------------------------------*/
293800000000
293900000000             RMVMSGD MSGID(TXT0003) MSGF(&LIB/&OBJ)
294000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
294100000000
294200000000             ADDMSGD +
294300000000                MSGID(TXT0003) +
294400000000                MSGF(&LIB/&OBJ) +
294500000000                MSG( +
294600000000'Teildatei:'                                                          +
294700000000                ) +
294800000000                SEV(0) +
294900000000     /*   No replacement variables defined!                         */ +
295000000000                ALROPT(*NO) +
295100000000                CCSID(65535) +
295200000000                /*  -EOF-  */
295300000000
295400000000     /*-------------------------------------------------------------*/
295500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0004                    */
295600000000     /* Satzlänge :                                                 */
295700000000     /*-------------------------------------------------------------*/
295800000000
295900000000             RMVMSGD MSGID(TXT0004) MSGF(&LIB/&OBJ)
296000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
296100000000
296200000000             ADDMSGD +
296300000000                MSGID(TXT0004) +
296400000000                MSGF(&LIB/&OBJ) +
296500000000                MSG( +
296600000000'Satzlänge :'                                                         +
296700000000                ) +
296800000000                SEV(0) +
296900000000     /*   No replacement variables defined!                         */ +
297000000000                ALROPT(*NO) +
297100000000                CCSID(65535) +
297200000000                /*  -EOF-  */
297300000000
297400000000     /*-------------------------------------------------------------*/
297500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0005                    */
297600000000     /* Anz. Sätze:                                                 */
297700000000     /*-------------------------------------------------------------*/
297800000000
297900000000             RMVMSGD MSGID(TXT0005) MSGF(&LIB/&OBJ)
298000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
298100000000
298200000000             ADDMSGD +
298300000000                MSGID(TXT0005) +
298400000000                MSGF(&LIB/&OBJ) +
298500000000                MSG( +
298600000000'Anz. Sätze:'                                                         +
298700000000                ) +
298800000000                SEV(0) +
298900000000     /*   No replacement variables defined!                         */ +
299000000000                ALROPT(*NO) +
299100000000                CCSID(65535) +
299200000000                /*  -EOF-  */
299300000000
299400000000     /*-------------------------------------------------------------*/
299500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0006                    */
299600000000     /* Feld-Nummer:                                                */
299700000000     /*-------------------------------------------------------------*/
299800000000
299900000000             RMVMSGD MSGID(TXT0006) MSGF(&LIB/&OBJ)
300000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
300100000000
300200000000             ADDMSGD +
300300000000                MSGID(TXT0006) +
300400000000                MSGF(&LIB/&OBJ) +
300500000000                MSG( +
300600000000'Feld-Nummer:'                                                        +
300700000000                ) +
300800000000                SEV(0) +
300900000000     /*   No replacement variables defined!                         */ +
301000000000                ALROPT(*NO) +
301100000000                CCSID(65535) +
301200000000                /*  -EOF-  */
301300000000
301400000000     /*-------------------------------------------------------------*/
301500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0007                    */
301600000000     /*         Feld:                                               */
301700000000     /*-------------------------------------------------------------*/
301800000000
301900000000             RMVMSGD MSGID(TXT0007) MSGF(&LIB/&OBJ)
302000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
302100000000
302200000000             ADDMSGD +
302300000000                MSGID(TXT0007) +
302400000000                MSGF(&LIB/&OBJ) +
302500000000                MSG( +
302600000000'        Feld:'                                                       +
302700000000                ) +
302800000000                SEV(0) +
302900000000     /*   No replacement variables defined!                         */ +
303000000000                ALROPT(*NO) +
303100000000                CCSID(65535) +
303200000000                /*  -EOF-  */
303300000000
303400000000     /*-------------------------------------------------------------*/
303500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0008                    */
303600000000     /*    Format:                                                  */
303700000000     /*-------------------------------------------------------------*/
303800000000
303900000000             RMVMSGD MSGID(TXT0008) MSGF(&LIB/&OBJ)
304000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
304100000000
304200000000             ADDMSGD +
304300000000                MSGID(TXT0008) +
304400000000                MSGF(&LIB/&OBJ) +
304500000000                MSG( +
304600000000'   Format:'                                                          +
304700000000                ) +
304800000000                SEV(0) +
304900000000     /*   No replacement variables defined!                         */ +
305000000000                ALROPT(*NO) +
305100000000                CCSID(65535) +
305200000000                /*  -EOF-  */
305300000000
305400000000     /*-------------------------------------------------------------*/
305500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0009                    */
305600000000     /* Dateigröße:                                                 */
305700000000     /*-------------------------------------------------------------*/
305800000000
305900000000             RMVMSGD MSGID(TXT0009) MSGF(&LIB/&OBJ)
306000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
306100000000
306200000000             ADDMSGD +
306300000000                MSGID(TXT0009) +
306400000000                MSGF(&LIB/&OBJ) +
306500000000                MSG( +
306600000000'Dateigröße:'                                                         +
306700000000                ) +
306800000000                SEV(0) +
306900000000     /*   No replacement variables defined!                         */ +
307000000000                ALROPT(*NO) +
307100000000                CCSID(65535) +
307200000000                /*  -EOF-  */
307300000000
307400000000     /*-------------------------------------------------------------*/
307500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0010                    */
307600000000     /* Satz-Nr. ..:                                                */
307700000000     /*-------------------------------------------------------------*/
307800000000
307900000000             RMVMSGD MSGID(TXT0010) MSGF(&LIB/&OBJ)
308000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
308100000000
308200000000             ADDMSGD +
308300000000                MSGID(TXT0010) +
308400000000                MSGF(&LIB/&OBJ) +
308500000000                MSG( +
308600000000'Satz-Nr. ..:'                                                        +
308700000000                ) +
308800000000                SEV(0) +
308900000000     /*   No replacement variables defined!                         */ +
309000000000                ALROPT(*NO) +
309100000000                CCSID(65535) +
309200000000                /*  -EOF-  */
309300000000
309400000000     /*-------------------------------------------------------------*/
309500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0011                    */
309600000000     /* Schlüssel  :                                                */
309700000000     /*-------------------------------------------------------------*/
309800000000
309900000000             RMVMSGD MSGID(TXT0011) MSGF(&LIB/&OBJ)
310000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
310100000000
310200000000             ADDMSGD +
310300000000                MSGID(TXT0011) +
310400000000                MSGF(&LIB/&OBJ) +
310500000000                MSG( +
310600000000'Schlüssel  :'                                                        +
310700000000                ) +
310800000000                SEV(0) +
310900000000     /*   No replacement variables defined!                         */ +
311000000000                ALROPT(*NO) +
311100000000                CCSID(65535) +
311200000000                /*  -EOF-  */
311300000000
311400000000     /*-------------------------------------------------------------*/
311500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0012                    */
311600000000     /*     Auswahl:                                                */
311700000000     /*-------------------------------------------------------------*/
311800000000
311900000000             RMVMSGD MSGID(TXT0012) MSGF(&LIB/&OBJ)
312000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
312100000000
312200000000             ADDMSGD +
312300000000                MSGID(TXT0012) +
312400000000                MSGF(&LIB/&OBJ) +
312500000000                MSG( +
312600000000'    Auswahl:'                                                        +
312700000000                ) +
312800000000                SEV(0) +
312900000000     /*   No replacement variables defined!                         */ +
313000000000                ALROPT(*NO) +
313100000000                CCSID(65535) +
313200000000                /*  -EOF-  */
313300000000
313400000000     /*-------------------------------------------------------------*/
313500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0013                    */
313600000000     /* Datei:                                                      */
313700000000     /*-------------------------------------------------------------*/
313800000000
313900000000             RMVMSGD MSGID(TXT0013) MSGF(&LIB/&OBJ)
314000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
314100000000
314200000000             ADDMSGD +
314300000000                MSGID(TXT0013) +
314400000000                MSGF(&LIB/&OBJ) +
314500000000                MSG( +
314600000000'Datei:'                                                              +
314700000000                ) +
314800000000                SEV(0) +
314900000000     /*   No replacement variables defined!                         */ +
315000000000                ALROPT(*NO) +
315100000000                CCSID(65535) +
315200000000                /*  -EOF-  */
315300000000
315400000000     /*-------------------------------------------------------------*/
315500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0014                    */
315600000000     /* Bib:                                                        */
315700000000     /*-------------------------------------------------------------*/
315800000000
315900000000             RMVMSGD MSGID(TXT0014) MSGF(&LIB/&OBJ)
316000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
316100000000
316200000000             ADDMSGD +
316300000000                MSGID(TXT0014) +
316400000000                MSGF(&LIB/&OBJ) +
316500000000                MSG( +
316600000000'Bib:'                                                                +
316700000000                ) +
316800000000                SEV(0) +
316900000000     /*   No replacement variables defined!                         */ +
317000000000                ALROPT(*NO) +
317100000000                CCSID(65535) +
317200000000                /*  -EOF-  */
317300000000
317400000000     /*-------------------------------------------------------------*/
317500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0015                    */
317600000000     /* Mbr:                                                        */
317700000000     /*-------------------------------------------------------------*/
317800000000
317900000000             RMVMSGD MSGID(TXT0015) MSGF(&LIB/&OBJ)
318000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
318100000000
318200000000             ADDMSGD +
318300000000                MSGID(TXT0015) +
318400000000                MSGF(&LIB/&OBJ) +
318500000000                MSG( +
318600000000'Mbr:'                                                                +
318700000000                ) +
318800000000                SEV(0) +
318900000000     /*   No replacement variables defined!                         */ +
319000000000                ALROPT(*NO) +
319100000000                CCSID(65535) +
319200000000                /*  -EOF-  */
319300000000
319400000000     /*-------------------------------------------------------------*/
319500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0016                    */
319600000000     /*  Länge:                                                     */
319700000000     /*-------------------------------------------------------------*/
319800000000
319900000000             RMVMSGD MSGID(TXT0016) MSGF(&LIB/&OBJ)
320000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
320100000000
320200000000             ADDMSGD +
320300000000                MSGID(TXT0016) +
320400000000                MSGF(&LIB/&OBJ) +
320500000000                MSG( +
320600000000' Länge:'                                                             +
320700000000                ) +
320800000000                SEV(0) +
320900000000     /*   No replacement variables defined!                         */ +
321000000000                ALROPT(*NO) +
321100000000                CCSID(65535) +
321200000000                /*  -EOF-  */
321300000000
321400000000     /*-------------------------------------------------------------*/
321500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0017                    */
321600000000     /*  Sätze:                                                     */
321700000000     /*-------------------------------------------------------------*/
321800000000
321900000000             RMVMSGD MSGID(TXT0017) MSGF(&LIB/&OBJ)
322000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
322100000000
322200000000             ADDMSGD +
322300000000                MSGID(TXT0017) +
322400000000                MSGF(&LIB/&OBJ) +
322500000000                MSG( +
322600000000' Sätze:'                                                             +
322700000000                ) +
322800000000                SEV(0) +
322900000000     /*   No replacement variables defined!                         */ +
323000000000                ALROPT(*NO) +
323100000000                CCSID(65535) +
323200000000                /*  -EOF-  */
323300000000
323400000000     /*-------------------------------------------------------------*/
323500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0018                    */
323600000000     /* Feld-Nr. :                                                  */
323700000000     /*-------------------------------------------------------------*/
323800000000
323900000000             RMVMSGD MSGID(TXT0018) MSGF(&LIB/&OBJ)
324000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
324100000000
324200000000             ADDMSGD +
324300000000                MSGID(TXT0018) +
324400000000                MSGF(&LIB/&OBJ) +
324500000000                MSG( +
324600000000'Feld-Nr. :'                                                          +
324700000000                ) +
324800000000                SEV(0) +
324900000000     /*   No replacement variables defined!                         */ +
325000000000                ALROPT(*NO) +
325100000000                CCSID(65535) +
325200000000                /*  -EOF-  */
325300000000
325400000000     /*-------------------------------------------------------------*/
325500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0019                    */
325600000000     /*     Feldname:                                               */
325700000000     /*-------------------------------------------------------------*/
325800000000
325900000000             RMVMSGD MSGID(TXT0019) MSGF(&LIB/&OBJ)
326000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
326100000000
326200000000             ADDMSGD +
326300000000                MSGID(TXT0019) +
326400000000                MSGF(&LIB/&OBJ) +
326500000000                MSG( +
326600000000'    Feldname:'                                                       +
326700000000                ) +
326800000000                SEV(0) +
326900000000     /*   No replacement variables defined!                         */ +
327000000000                ALROPT(*NO) +
327100000000                CCSID(65535) +
327200000000                /*  -EOF-  */
327300000000
327400000000     /*-------------------------------------------------------------*/
327500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0020                    */
327600000000     /* Format:                                                     */
327700000000     /*-------------------------------------------------------------*/
327800000000
327900000000             RMVMSGD MSGID(TXT0020) MSGF(&LIB/&OBJ)
328000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
328100000000
328200000000             ADDMSGD +
328300000000                MSGID(TXT0020) +
328400000000                MSGF(&LIB/&OBJ) +
328500000000                MSG( +
328600000000'Format:'                                                             +
328700000000                ) +
328800000000                SEV(0) +
328900000000     /*   No replacement variables defined!                         */ +
329000000000                ALROPT(*NO) +
329100000000                CCSID(65535) +
329200000000                /*  -EOF-  */
329300000000
329400000000     /*-------------------------------------------------------------*/
329500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0021                    */
329600000000     /*  Größe:                                                     */
329700000000     /*-------------------------------------------------------------*/
329800000000
329900000000             RMVMSGD MSGID(TXT0021) MSGF(&LIB/&OBJ)
330000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
330100000000
330200000000             ADDMSGD +
330300000000                MSGID(TXT0021) +
330400000000                MSGF(&LIB/&OBJ) +
330500000000                MSG( +
330600000000' Größe:'                                                             +
330700000000                ) +
330800000000                SEV(0) +
330900000000     /*   No replacement variables defined!                         */ +
331000000000                ALROPT(*NO) +
331100000000                CCSID(65535) +
331200000000                /*  -EOF-  */
331300000000
331400000000     /*-------------------------------------------------------------*/
331500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0022                    */
331600000000     /* Satz-Nr. :                                                  */
331700000000     /*-------------------------------------------------------------*/
331800000000
331900000000             RMVMSGD MSGID(TXT0022) MSGF(&LIB/&OBJ)
332000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
332100000000
332200000000             ADDMSGD +
332300000000                MSGID(TXT0022) +
332400000000                MSGF(&LIB/&OBJ) +
332500000000                MSG( +
332600000000'Satz-Nr. :'                                                          +
332700000000                ) +
332800000000                SEV(0) +
332900000000     /*   No replacement variables defined!                         */ +
333000000000                ALROPT(*NO) +
333100000000                CCSID(65535) +
333200000000                /*  -EOF-  */
333300000000
333400000000     /*-------------------------------------------------------------*/
333500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0023                    */
333600000000     /* Schlüssel:                                                  */
333700000000     /*-------------------------------------------------------------*/
333800000000
333900000000             RMVMSGD MSGID(TXT0023) MSGF(&LIB/&OBJ)
334000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
334100000000
334200000000             ADDMSGD +
334300000000                MSGID(TXT0023) +
334400000000                MSGF(&LIB/&OBJ) +
334500000000                MSG( +
334600000000'Schlüssel:'                                                          +
334700000000                ) +
334800000000                SEV(0) +
334900000000     /*   No replacement variables defined!                         */ +
335000000000                ALROPT(*NO) +
335100000000                CCSID(65535) +
335200000000                /*  -EOF-  */
335300000000
335400000000     /*-------------------------------------------------------------*/
335500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0024                    */
335600000000     /* Auswahl:                                                    */
335700000000     /*-------------------------------------------------------------*/
335800000000
335900000000             RMVMSGD MSGID(TXT0024) MSGF(&LIB/&OBJ)
336000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
336100000000
336200000000             ADDMSGD +
336300000000                MSGID(TXT0024) +
336400000000                MSGF(&LIB/&OBJ) +
336500000000                MSG( +
336600000000'Auswahl:'                                                            +
336700000000                ) +
336800000000                SEV(0) +
336900000000     /*   No replacement variables defined!                         */ +
337000000000                ALROPT(*NO) +
337100000000                CCSID(65535) +
337200000000                /*  -EOF-  */
337300000000
337400000000     /*-------------------------------------------------------------*/
337500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0025                    */
337600000000     /* (Keine Datensätze gefunden)                                 */
337700000000     /*-------------------------------------------------------------*/
337800000000
337900000000             RMVMSGD MSGID(TXT0025) MSGF(&LIB/&OBJ)
338000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
338100000000
338200000000             ADDMSGD +
338300000000                MSGID(TXT0025) +
338400000000                MSGF(&LIB/&OBJ) +
338500000000                MSG( +
338600000000'(Keine Datensätze gefunden)'                                         +
338700000000                ) +
338800000000                SEV(0) +
338900000000     /*   No replacement variables defined!                         */ +
339000000000                ALROPT(*NO) +
339100000000                CCSID(65535) +
339200000000                /*  -EOF-  */
339300000000
339400000000     /*-------------------------------------------------------------*/
339500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0026                    */
339600000000     /* 'ENTER' = Löschen ...                                       */
339700000000     /*-------------------------------------------------------------*/
339800000000
339900000000             RMVMSGD MSGID(TXT0026) MSGF(&LIB/&OBJ)
340000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
340100000000
340200000000             ADDMSGD +
340300000000                MSGID(TXT0026) +
340400000000                MSGF(&LIB/&OBJ) +
340500000000                MSG( +
340600000000'''ENTER'' = Löschen ...'                                             +
340700000000                ) +
340800000000                SEV(0) +
340900000000     /*   No replacement variables defined!                         */ +
341000000000                ALROPT(*NO) +
341100000000                CCSID(65535) +
341200000000                /*  -EOF-  */
341300000000
341400000000     /*-------------------------------------------------------------*/
341500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0027                    */
341600000000     /* Datensatzanzeige ...                                        */
341700000000     /*-------------------------------------------------------------*/
341800000000
341900000000             RMVMSGD MSGID(TXT0027) MSGF(&LIB/&OBJ)
342000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
342100000000
342200000000             ADDMSGD +
342300000000                MSGID(TXT0027) +
342400000000                MSGF(&LIB/&OBJ) +
342500000000                MSG( +
342600000000'Datensatzanzeige ...'                                                +
342700000000                ) +
342800000000                SEV(0) +
342900000000     /*   No replacement variables defined!                         */ +
343000000000                ALROPT(*NO) +
343100000000                CCSID(65535) +
343200000000                /*  -EOF-  */
343300000000
343400000000     /*-------------------------------------------------------------*/
343500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0028                    */
343600000000     /* 'ENTER' = Kopieren ...                                      */
343700000000     /*-------------------------------------------------------------*/
343800000000
343900000000             RMVMSGD MSGID(TXT0028) MSGF(&LIB/&OBJ)
344000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
344100000000
344200000000             ADDMSGD +
344300000000                MSGID(TXT0028) +
344400000000                MSGF(&LIB/&OBJ) +
344500000000                MSG( +
344600000000'''ENTER'' = Kopieren ...'                                            +
344700000000                ) +
344800000000                SEV(0) +
344900000000     /*   No replacement variables defined!                         */ +
345000000000                ALROPT(*NO) +
345100000000                CCSID(65535) +
345200000000                /*  -EOF-  */
345300000000
345400000000     /*-------------------------------------------------------------*/
345500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0029                    */
345600000000     /* Satz-Nr:                                                    */
345700000000     /*-------------------------------------------------------------*/
345800000000
345900000000             RMVMSGD MSGID(TXT0029) MSGF(&LIB/&OBJ)
346000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
346100000000
346200000000             ADDMSGD +
346300000000                MSGID(TXT0029) +
346400000000                MSGF(&LIB/&OBJ) +
346500000000                MSG( +
346600000000'Satz-Nr:'                                                            +
346700000000                ) +
346800000000                SEV(0) +
346900000000     /*   No replacement variables defined!                         */ +
347000000000                ALROPT(*NO) +
347100000000                CCSID(65535) +
347200000000                /*  -EOF-  */
347300000000
347400000000     /*-------------------------------------------------------------*/
347500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0030                    */
347600000000     /* Commit-Steuerung                                            */
347700000000     /*-------------------------------------------------------------*/
347800000000
347900000000             RMVMSGD MSGID(TXT0030) MSGF(&LIB/&OBJ)
348000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
348100000000
348200000000             ADDMSGD +
348300000000                MSGID(TXT0030) +
348400000000                MSGF(&LIB/&OBJ) +
348500000000                MSG( +
348600000000'Commit-Steuerung  '                                                  +
348700000000                ) +
348800000000                SEV(0) +
348900000000     /*   No replacement variables defined!                         */ +
349000000000                ALROPT(*NO) +
349100000000                CCSID(65535) +
349200000000                /*  -EOF-  */
349300000000
349400000000     /*-------------------------------------------------------------*/
349500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0031                    */
349600000000     /* ohne Commitsteuer.                                          */
349700000000     /*-------------------------------------------------------------*/
349800000000
349900000000             RMVMSGD MSGID(TXT0031) MSGF(&LIB/&OBJ)
350000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
350100000000
350200000000             ADDMSGD +
350300000000                MSGID(TXT0031) +
350400000000                MSGF(&LIB/&OBJ) +
350500000000                MSG( +
350600000000'ohne Commitsteuer.'                                                  +
350700000000                ) +
350800000000                SEV(0) +
350900000000     /*   No replacement variables defined!                         */ +
351000000000                ALROPT(*NO) +
351100000000                CCSID(65535) +
351200000000                /*  -EOF-  */
351300000000
351400000000     /*-------------------------------------------------------------*/
351500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0032                    */
351600000000     /* (keine Datensätze gefunden)                                 */
351700000000     /*-------------------------------------------------------------*/
351800000000
351900000000             RMVMSGD MSGID(TXT0032) MSGF(&LIB/&OBJ)
352000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
352100000000
352200000000             ADDMSGD +
352300000000                MSGID(TXT0032) +
352400000000                MSGF(&LIB/&OBJ) +
352500000000                MSG( +
352600000000'(keine Datensätze gefunden)'                                         +
352700000000                ) +
352800000000                SEV(0) +
352900000000     /*   No replacement variables defined!                         */ +
353000000000                ALROPT(*NO) +
353100000000                CCSID(65535) +
353200000000                /*  -EOF-  */
353300000000
353400000000     /*-------------------------------------------------------------*/
353500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0033                    */
353600000000     /*      - Suchen -                                             */
353700000000     /*-------------------------------------------------------------*/
353800000000
353900000000             RMVMSGD MSGID(TXT0033) MSGF(&LIB/&OBJ)
354000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
354100000000
354200000000             ADDMSGD +
354300000000                MSGID(TXT0033) +
354400000000                MSGF(&LIB/&OBJ) +
354500000000                MSG( +
354600000000'     - Suchen -'                                                     +
354700000000                ) +
354800000000                SEV(0) +
354900000000     /*   No replacement variables defined!                         */ +
355000000000                ALROPT(*NO) +
355100000000                CCSID(65535) +
355200000000                /*  -EOF-  */
355300000000
355400000000     /*-------------------------------------------------------------*/
355500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0034                    */
355600000000     /*  Feld                                                       */
355700000000     /*-------------------------------------------------------------*/
355800000000
355900000000             RMVMSGD MSGID(TXT0034) MSGF(&LIB/&OBJ)
356000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
356100000000
356200000000             ADDMSGD +
356300000000                MSGID(TXT0034) +
356400000000                MSGF(&LIB/&OBJ) +
356500000000                MSG( +
356600000000' Feld'                                                               +
356700000000                ) +
356800000000                SEV(0) +
356900000000     /*   No replacement variables defined!                         */ +
357000000000                ALROPT(*NO) +
357100000000                CCSID(65535) +
357200000000                /*  -EOF-  */
357300000000
357400000000     /*-------------------------------------------------------------*/
357500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0035                    */
357600000000     /* Oper.                                                       */
357700000000     /*-------------------------------------------------------------*/
357800000000
357900000000             RMVMSGD MSGID(TXT0035) MSGF(&LIB/&OBJ)
358000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
358100000000
358200000000             ADDMSGD +
358300000000                MSGID(TXT0035) +
358400000000                MSGF(&LIB/&OBJ) +
358500000000                MSG( +
358600000000'Oper.'                                                               +
358700000000                ) +
358800000000                SEV(0) +
358900000000     /*   No replacement variables defined!                         */ +
359000000000                ALROPT(*NO) +
359100000000                CCSID(65535) +
359200000000                /*  -EOF-  */
359300000000
359400000000     /*-------------------------------------------------------------*/
359500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0036                    */
359600000000     /* Wert (ohne Hochkomma)                                       */
359700000000     /*-------------------------------------------------------------*/
359800000000
359900000000             RMVMSGD MSGID(TXT0036) MSGF(&LIB/&OBJ)
360000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
360100000000
360200000000             ADDMSGD +
360300000000                MSGID(TXT0036) +
360400000000                MSGF(&LIB/&OBJ) +
360500000000                MSG( +
360600000000'Wert (ohne Hochkomma)'                                               +
360700000000                ) +
360800000000                SEV(0) +
360900000000     /*   No replacement variables defined!                         */ +
361000000000                ALROPT(*NO) +
361100000000                CCSID(65535) +
361200000000                /*  -EOF-  */
361300000000
361400000000     /*-------------------------------------------------------------*/
361500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0037                    */
361600000000     /* generische Suche)                                           */
361700000000     /*-------------------------------------------------------------*/
361800000000
361900000000             RMVMSGD MSGID(TXT0037) MSGF(&LIB/&OBJ)
362000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
362100000000
362200000000             ADDMSGD +
362300000000                MSGID(TXT0037) +
362400000000                MSGF(&LIB/&OBJ) +
362500000000                MSG( +
362600000000'generische Suche)'                                                   +
362700000000                ) +
362800000000                SEV(0) +
362900000000     /*   No replacement variables defined!                         */ +
363000000000                ALROPT(*NO) +
363100000000                CCSID(65535) +
363200000000                /*  -EOF-  */
363300000000
363400000000     /*-------------------------------------------------------------*/
363500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0038                    */
363600000000     /* Max.Anz. Sätze:                                             */
363700000000     /*-------------------------------------------------------------*/
363800000000
363900000000             RMVMSGD MSGID(TXT0038) MSGF(&LIB/&OBJ)
364000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
364100000000
364200000000             ADDMSGD +
364300000000                MSGID(TXT0038) +
364400000000                MSGF(&LIB/&OBJ) +
364500000000                MSG( +
364600000000'Max.Anz. Sätze:'                                                     +
364700000000                ) +
364800000000                SEV(0) +
364900000000     /*   No replacement variables defined!                         */ +
365000000000                ALROPT(*NO) +
365100000000                CCSID(65535) +
365200000000                /*  -EOF-  */
365300000000
365400000000     /*-------------------------------------------------------------*/
365500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0039                    */
365600000000     /* Art der Suche :                                             */
365700000000     /*-------------------------------------------------------------*/
365800000000
365900000000             RMVMSGD MSGID(TXT0039) MSGF(&LIB/&OBJ)
366000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
366100000000
366200000000             ADDMSGD +
366300000000                MSGID(TXT0039) +
366400000000                MSGF(&LIB/&OBJ) +
366500000000                MSG( +
366600000000'Art der Suche :'                                                     +
366700000000                ) +
366800000000                SEV(0) +
366900000000     /*   No replacement variables defined!                         */ +
367000000000                ALROPT(*NO) +
367100000000                CCSID(65535) +
367200000000                /*  -EOF-  */
367300000000
367400000000     /*-------------------------------------------------------------*/
367500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0040                    */
367600000000     /* (Normal/Underline/Reverse/Pin)                              */
367700000000     /*-------------------------------------------------------------*/
367800000000
367900000000             RMVMSGD MSGID(TXT0040) MSGF(&LIB/&OBJ)
368000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
368100000000
368200000000             ADDMSGD +
368300000000                MSGID(TXT0040) +
368400000000                MSGF(&LIB/&OBJ) +
368500000000                MSG( +
368600000000'(Normal/Underline/Reverse/Pin)'                                      +
368700000000                ) +
368800000000                SEV(0) +
368900000000     /*   No replacement variables defined!                         */ +
369000000000                ALROPT(*NO) +
369100000000                CCSID(65535) +
369200000000                /*  -EOF-  */
369300000000
369400000000     /*-------------------------------------------------------------*/
369500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0041                    */
369600000000     /* Groß-/Klein ..:                                             */
369700000000     /*-------------------------------------------------------------*/
369800000000
369900000000             RMVMSGD MSGID(TXT0041) MSGF(&LIB/&OBJ)
370000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
370100000000
370200000000             ADDMSGD +
370300000000                MSGID(TXT0041) +
370400000000                MSGF(&LIB/&OBJ) +
370500000000                MSG( +
370600000000'Groß-/Klein ..:'                                                     +
370700000000                ) +
370800000000                SEV(0) +
370900000000     /*   No replacement variables defined!                         */ +
371000000000                ALROPT(*NO) +
371100000000                CCSID(65535) +
371200000000                /*  -EOF-  */
371300000000
371400000000     /*-------------------------------------------------------------*/
371500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0042                    */
371600000000     /* (1=Ja; 0=Nein)                                              */
371700000000     /*-------------------------------------------------------------*/
371800000000
371900000000             RMVMSGD MSGID(TXT0042) MSGF(&LIB/&OBJ)
372000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
372100000000
372200000000             ADDMSGD +
372300000000                MSGID(TXT0042) +
372400000000                MSGF(&LIB/&OBJ) +
372500000000                MSG( +
372600000000'(1=Ja; 0=Nein)'                                                      +
372700000000                ) +
372800000000                SEV(0) +
372900000000     /*   No replacement variables defined!                         */ +
373000000000                ALROPT(*NO) +
373100000000                CCSID(65535) +
373200000000                /*  -EOF-  */
373300000000
373400000000     /*-------------------------------------------------------------*/
373500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0043                    */
373600000000     /* - Farbeinstellung -                                         */
373700000000     /*-------------------------------------------------------------*/
373800000000
373900000000             RMVMSGD MSGID(TXT0043) MSGF(&LIB/&OBJ)
374000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
374100000000
374200000000             ADDMSGD +
374300000000                MSGID(TXT0043) +
374400000000                MSGF(&LIB/&OBJ) +
374500000000                MSG( +
374600000000'- Farbeinstellung -'                                                 +
374700000000                ) +
374800000000                SEV(0) +
374900000000     /*   No replacement variables defined!                         */ +
375000000000                ALROPT(*NO) +
375100000000                CCSID(65535) +
375200000000                /*  -EOF-  */
375300000000
375400000000     /*-------------------------------------------------------------*/
375500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0044                    */
375600000000     /*   - Farbauswahl -                                           */
375700000000     /*-------------------------------------------------------------*/
375800000000
375900000000             RMVMSGD MSGID(TXT0044) MSGF(&LIB/&OBJ)
376000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
376100000000
376200000000             ADDMSGD +
376300000000                MSGID(TXT0044) +
376400000000                MSGF(&LIB/&OBJ) +
376500000000                MSG( +
376600000000'  - Farbauswahl -'                                                   +
376700000000                ) +
376800000000                SEV(0) +
376900000000     /*   No replacement variables defined!                         */ +
377000000000                ALROPT(*NO) +
377100000000                CCSID(65535) +
377200000000                /*  -EOF-  */
377300000000
377400000000     /*-------------------------------------------------------------*/
377500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0045                    */
377600000000     /* Grün                                                        */
377700000000     /*-------------------------------------------------------------*/
377800000000
377900000000             RMVMSGD MSGID(TXT0045) MSGF(&LIB/&OBJ)
378000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
378100000000
378200000000             ADDMSGD +
378300000000                MSGID(TXT0045) +
378400000000                MSGF(&LIB/&OBJ) +
378500000000                MSG( +
378600000000'Grün     '                                                           +
378700000000                ) +
378800000000                SEV(0) +
378900000000     /*   No replacement variables defined!                         */ +
379000000000                ALROPT(*NO) +
379100000000                CCSID(65535) +
379200000000                /*  -EOF-  */
379300000000
379400000000     /*-------------------------------------------------------------*/
379500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0046                    */
379600000000     /* Weiß                                                        */
379700000000     /*-------------------------------------------------------------*/
379800000000
379900000000             RMVMSGD MSGID(TXT0046) MSGF(&LIB/&OBJ)
380000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
380100000000
380200000000             ADDMSGD +
380300000000                MSGID(TXT0046) +
380400000000                MSGF(&LIB/&OBJ) +
380500000000                MSG( +
380600000000'Weiß     '                                                           +
380700000000                ) +
380800000000                SEV(0) +
380900000000     /*   No replacement variables defined!                         */ +
381000000000                ALROPT(*NO) +
381100000000                CCSID(65535) +
381200000000                /*  -EOF-  */
381300000000
381400000000     /*-------------------------------------------------------------*/
381500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0047                    */
381600000000     /* Rot                                                         */
381700000000     /*-------------------------------------------------------------*/
381800000000
381900000000             RMVMSGD MSGID(TXT0047) MSGF(&LIB/&OBJ)
382000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
382100000000
382200000000             ADDMSGD +
382300000000                MSGID(TXT0047) +
382400000000                MSGF(&LIB/&OBJ) +
382500000000                MSG( +
382600000000'Rot      '                                                           +
382700000000                ) +
382800000000                SEV(0) +
382900000000     /*   No replacement variables defined!                         */ +
383000000000                ALROPT(*NO) +
383100000000                CCSID(65535) +
383200000000                /*  -EOF-  */
383300000000
383400000000     /*-------------------------------------------------------------*/
383500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0048                    */
383600000000     /* Türkis                                                      */
383700000000     /*-------------------------------------------------------------*/
383800000000
383900000000             RMVMSGD MSGID(TXT0048) MSGF(&LIB/&OBJ)
384000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
384100000000
384200000000             ADDMSGD +
384300000000                MSGID(TXT0048) +
384400000000                MSGF(&LIB/&OBJ) +
384500000000                MSG( +
384600000000'Türkis   '                                                           +
384700000000                ) +
384800000000                SEV(0) +
384900000000     /*   No replacement variables defined!                         */ +
385000000000                ALROPT(*NO) +
385100000000                CCSID(65535) +
385200000000                /*  -EOF-  */
385300000000
385400000000     /*-------------------------------------------------------------*/
385500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0049                    */
385600000000     /* Gelb                                                        */
385700000000     /*-------------------------------------------------------------*/
385800000000
385900000000             RMVMSGD MSGID(TXT0049) MSGF(&LIB/&OBJ)
386000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
386100000000
386200000000             ADDMSGD +
386300000000                MSGID(TXT0049) +
386400000000                MSGF(&LIB/&OBJ) +
386500000000                MSG( +
386600000000'Gelb     '                                                           +
386700000000                ) +
386800000000                SEV(0) +
386900000000     /*   No replacement variables defined!                         */ +
387000000000                ALROPT(*NO) +
387100000000                CCSID(65535) +
387200000000                /*  -EOF-  */
387300000000
387400000000     /*-------------------------------------------------------------*/
387500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0050                    */
387600000000     /* Rosa                                                        */
387700000000     /*-------------------------------------------------------------*/
387800000000
387900000000             RMVMSGD MSGID(TXT0050) MSGF(&LIB/&OBJ)
388000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
388100000000
388200000000             ADDMSGD +
388300000000                MSGID(TXT0050) +
388400000000                MSGF(&LIB/&OBJ) +
388500000000                MSG( +
388600000000'Rosa     '                                                           +
388700000000                ) +
388800000000                SEV(0) +
388900000000     /*   No replacement variables defined!                         */ +
389000000000                ALROPT(*NO) +
389100000000                CCSID(65535) +
389200000000                /*  -EOF-  */
389300000000
389400000000     /*-------------------------------------------------------------*/
389500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0051                    */
389600000000     /* Blau                                                        */
389700000000     /*-------------------------------------------------------------*/
389800000000
389900000000             RMVMSGD MSGID(TXT0051) MSGF(&LIB/&OBJ)
390000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
390100000000
390200000000             ADDMSGD +
390300000000                MSGID(TXT0051) +
390400000000                MSGF(&LIB/&OBJ) +
390500000000                MSG( +
390600000000'Blau     '                                                           +
390700000000                ) +
390800000000                SEV(0) +
390900000000     /*   No replacement variables defined!                         */ +
391000000000                ALROPT(*NO) +
391100000000                CCSID(65535) +
391200000000                /*  -EOF-  */
391300000000
391400000000     /*-------------------------------------------------------------*/
391500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0052                    */
391600000000     /*  - ext. Kopieren -                                          */
391700000000     /*-------------------------------------------------------------*/
391800000000
391900000000             RMVMSGD MSGID(TXT0052) MSGF(&LIB/&OBJ)
392000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
392100000000
392200000000             ADDMSGD +
392300000000                MSGID(TXT0052) +
392400000000                MSGF(&LIB/&OBJ) +
392500000000                MSG( +
392600000000' - ext. Kopieren -'                                                  +
392700000000                ) +
392800000000                SEV(0) +
392900000000     /*   No replacement variables defined!                         */ +
393000000000                ALROPT(*NO) +
393100000000                CCSID(65535) +
393200000000                /*  -EOF-  */
393300000000
393400000000     /*-------------------------------------------------------------*/
393500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0053                    */
393600000000     /* Datei ...........:                                          */
393700000000     /*-------------------------------------------------------------*/
393800000000
393900000000             RMVMSGD MSGID(TXT0053) MSGF(&LIB/&OBJ)
394000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
394100000000
394200000000             ADDMSGD +
394300000000                MSGID(TXT0053) +
394400000000                MSGF(&LIB/&OBJ) +
394500000000                MSG( +
394600000000'Datei ...........:'                                                  +
394700000000                ) +
394800000000                SEV(0) +
394900000000     /*   No replacement variables defined!                         */ +
395000000000                ALROPT(*NO) +
395100000000                CCSID(65535) +
395200000000                /*  -EOF-  */
395300000000
395400000000     /*-------------------------------------------------------------*/
395500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0054                    */
395600000000     /* Bibliothek ......:                                          */
395700000000     /*-------------------------------------------------------------*/
395800000000
395900000000             RMVMSGD MSGID(TXT0054) MSGF(&LIB/&OBJ)
396000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
396100000000
396200000000             ADDMSGD +
396300000000                MSGID(TXT0054) +
396400000000                MSGF(&LIB/&OBJ) +
396500000000                MSG( +
396600000000'Bibliothek ......:'                                                  +
396700000000                ) +
396800000000                SEV(0) +
396900000000     /*   No replacement variables defined!                         */ +
397000000000                ALROPT(*NO) +
397100000000                CCSID(65535) +
397200000000                /*  -EOF-  */
397300000000
397400000000     /*-------------------------------------------------------------*/
397500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0055                    */
397600000000     /* Teildatei .......:                                          */
397700000000     /*-------------------------------------------------------------*/
397800000000
397900000000             RMVMSGD MSGID(TXT0055) MSGF(&LIB/&OBJ)
398000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
398100000000
398200000000             ADDMSGD +
398300000000                MSGID(TXT0055) +
398400000000                MSGF(&LIB/&OBJ) +
398500000000                MSG( +
398600000000'Teildatei .......:'                                                  +
398700000000                ) +
398800000000                SEV(0) +
398900000000     /*   No replacement variables defined!                         */ +
399000000000                ALROPT(*NO) +
399100000000                CCSID(65535) +
399200000000                /*  -EOF-  */
399300000000
399400000000     /*-------------------------------------------------------------*/
399500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0056                    */
399600000000     /* Sätze ersetzen ..:                                          */
399700000000     /*-------------------------------------------------------------*/
399800000000
399900000000             RMVMSGD MSGID(TXT0056) MSGF(&LIB/&OBJ)
400000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
400100000000
400200000000             ADDMSGD +
400300000000                MSGID(TXT0056) +
400400000000                MSGF(&LIB/&OBJ) +
400500000000                MSG( +
400600000000'Sätze ersetzen ..:'                                                  +
400700000000                ) +
400800000000                SEV(0) +
400900000000     /*   No replacement variables defined!                         */ +
401000000000                ALROPT(*NO) +
401100000000                CCSID(65535) +
401200000000                /*  -EOF-  */
401300000000
401400000000     /*-------------------------------------------------------------*/
401500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0057                    */
401600000000     /* Datei erstellen .:                                          */
401700000000     /*-------------------------------------------------------------*/
401800000000
401900000000             RMVMSGD MSGID(TXT0057) MSGF(&LIB/&OBJ)
402000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
402100000000
402200000000             ADDMSGD +
402300000000                MSGID(TXT0057) +
402400000000                MSGF(&LIB/&OBJ) +
402500000000                MSG( +
402600000000'Datei erstellen .:'                                                  +
402700000000                ) +
402800000000                SEV(0) +
402900000000     /*   No replacement variables defined!                         */ +
403000000000                ALROPT(*NO) +
403100000000                CCSID(65535) +
403200000000                /*  -EOF-  */
403300000000
403400000000     /*-------------------------------------------------------------*/
403500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0058                    */
403600000000     /*   - Lizenzdaten -                                           */
403700000000     /*-------------------------------------------------------------*/
403800000000
403900000000             RMVMSGD MSGID(TXT0058) MSGF(&LIB/&OBJ)
404000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
404100000000
404200000000             ADDMSGD +
404300000000                MSGID(TXT0058) +
404400000000                MSGF(&LIB/&OBJ) +
404500000000                MSG( +
404600000000'  - Lizenzdaten -'                                                   +
404700000000                ) +
404800000000                SEV(0) +
404900000000     /*   No replacement variables defined!                         */ +
405000000000                ALROPT(*NO) +
405100000000                CCSID(65535) +
405200000000                /*  -EOF-  */
405300000000
405400000000     /*-------------------------------------------------------------*/
405500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0059                    */
405600000000     /*  Lizenz-Nr:                                                 */
405700000000     /*-------------------------------------------------------------*/
405800000000
405900000000             RMVMSGD MSGID(TXT0059) MSGF(&LIB/&OBJ)
406000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
406100000000
406200000000             ADDMSGD +
406300000000                MSGID(TXT0059) +
406400000000                MSGF(&LIB/&OBJ) +
406500000000                MSG( +
406600000000' Lizenz-Nr:'                                                         +
406700000000                ) +
406800000000                SEV(0) +
406900000000     /*   No replacement variables defined!                         */ +
407000000000                ALROPT(*NO) +
407100000000                CCSID(65535) +
407200000000                /*  -EOF-  */
407300000000
407400000000     /*-------------------------------------------------------------*/
407500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0060                    */
407600000000     /* F9=Testen                                                   */
407700000000     /*-------------------------------------------------------------*/
407800000000
407900000000             RMVMSGD MSGID(TXT0060) MSGF(&LIB/&OBJ)
408000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
408100000000
408200000000             ADDMSGD +
408300000000                MSGID(TXT0060) +
408400000000                MSGF(&LIB/&OBJ) +
408500000000                MSG( +
408600000000'F9=Testen'                                                           +
408700000000                ) +
408800000000                SEV(0) +
408900000000     /*   No replacement variables defined!                         */ +
409000000000                ALROPT(*NO) +
409100000000                CCSID(65535) +
409200000000                /*  -EOF-  */
409300000000
409400000000     /*-------------------------------------------------------------*/
409500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0061                    */
409600000000     /* Lizenzdaten wurden gesichert!                               */
409700000000     /*-------------------------------------------------------------*/
409800000000
409900000000             RMVMSGD MSGID(TXT0061) MSGF(&LIB/&OBJ)
410000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
410100000000
410200000000             ADDMSGD +
410300000000                MSGID(TXT0061) +
410400000000                MSGF(&LIB/&OBJ) +
410500000000                MSG( +
410600000000'Lizenzdaten wurden gesichert!'                                       +
410700000000                ) +
410800000000                SEV(0) +
410900000000     /*   No replacement variables defined!                         */ +
411000000000                ALROPT(*NO) +
411100000000                CCSID(65535) +
411200000000                /*  -EOF-  */
411300000000
411400000000     /*-------------------------------------------------------------*/
411500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0062                    */
411600000000     /* Sorry, der Testzeitraum ist abgelaufen.                     */
411700000000     /*-------------------------------------------------------------*/
411800000000
411900000000             RMVMSGD MSGID(TXT0062) MSGF(&LIB/&OBJ)
412000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
412100000000
412200000000             ADDMSGD +
412300000000                MSGID(TXT0062) +
412400000000                MSGF(&LIB/&OBJ) +
412500000000                MSG( +
412600000000'Sorry, der Testzeitraum ist abgelaufen.'                             +
412700000000                ) +
412800000000                SEV(0) +
412900000000     /*   No replacement variables defined!                         */ +
413000000000                ALROPT(*NO) +
413100000000                CCSID(65535) +
413200000000                /*  -EOF-  */
413300000000
413400000000     /*-------------------------------------------------------------*/
413500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0063                    */
413600000000     /* 'ENTER' = Ändern ...                                        */
413700000000     /*-------------------------------------------------------------*/
413800000000
413900000000             RMVMSGD MSGID(TXT0063) MSGF(&LIB/&OBJ)
414000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
414100000000
414200000000             ADDMSGD +
414300000000                MSGID(TXT0063) +
414400000000                MSGF(&LIB/&OBJ) +
414500000000                MSG( +
414600000000'''ENTER'' = Ändern ...'                                              +
414700000000                ) +
414800000000                SEV(0) +
414900000000     /*   No replacement variables defined!                         */ +
415000000000                ALROPT(*NO) +
415100000000                CCSID(65535) +
415200000000                /*  -EOF-  */
415300000000
415400000000     /*-------------------------------------------------------------*/
415500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0064                    */
415600000000     /* 'ENTER' = Kopieren ...                                      */
415700000000     /*-------------------------------------------------------------*/
415800000000
415900000000             RMVMSGD MSGID(TXT0064) MSGF(&LIB/&OBJ)
416000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
416100000000
416200000000             ADDMSGD +
416300000000                MSGID(TXT0064) +
416400000000                MSGF(&LIB/&OBJ) +
416500000000                MSG( +
416600000000'''ENTER'' = Kopieren ...'                                            +
416700000000                ) +
416800000000                SEV(0) +
416900000000     /*   No replacement variables defined!                         */ +
417000000000                ALROPT(*NO) +
417100000000                CCSID(65535) +
417200000000                /*  -EOF-  */
417300000000
417400000000     /*-------------------------------------------------------------*/
417500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0065                    */
417600000000     /* 'ENTER' = Einfügen ...                                      */
417700000000     /*-------------------------------------------------------------*/
417800000000
417900000000             RMVMSGD MSGID(TXT0065) MSGF(&LIB/&OBJ)
418000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
418100000000
418200000000             ADDMSGD +
418300000000                MSGID(TXT0065) +
418400000000                MSGF(&LIB/&OBJ) +
418500000000                MSG( +
418600000000'''ENTER'' = Einfügen ...'                                            +
418700000000                ) +
418800000000                SEV(0) +
418900000000     /*   No replacement variables defined!                         */ +
419000000000                ALROPT(*NO) +
419100000000                CCSID(65535) +
419200000000                /*  -EOF-  */
419300000000
419400000000     /*-------------------------------------------------------------*/
419500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0066                    */
419600000000     /* Weitere ...                                                 */
419700000000     /*-------------------------------------------------------------*/
419800000000
419900000000             RMVMSGD MSGID(TXT0066) MSGF(&LIB/&OBJ)
420000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
420100000000
420200000000             ADDMSGD +
420300000000                MSGID(TXT0066) +
420400000000                MSGF(&LIB/&OBJ) +
420500000000                MSG( +
420600000000'Weitere ...'                                                         +
420700000000                ) +
420800000000                SEV(0) +
420900000000     /*   No replacement variables defined!                         */ +
421000000000                ALROPT(*NO) +
421100000000                CCSID(65535) +
421200000000                /*  -EOF-  */
421300000000
421400000000     /*-------------------------------------------------------------*/
421500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0067                    */
421600000000     /*        Ende                                                 */
421700000000     /*-------------------------------------------------------------*/
421800000000
421900000000             RMVMSGD MSGID(TXT0067) MSGF(&LIB/&OBJ)
422000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
422100000000
422200000000             ADDMSGD +
422300000000                MSGID(TXT0067) +
422400000000                MSGF(&LIB/&OBJ) +
422500000000                MSG( +
422600000000'       Ende'                                                         +
422700000000                ) +
422800000000                SEV(0) +
422900000000     /*   No replacement variables defined!                         */ +
423000000000                ALROPT(*NO) +
423100000000                CCSID(65535) +
423200000000                /*  -EOF-  */
423300000000
423400000000     /*-------------------------------------------------------------*/
423500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0068                    */
423600000000     /* Commit & Rollback                                           */
423700000000     /*-------------------------------------------------------------*/
423800000000
423900000000             RMVMSGD MSGID(TXT0068) MSGF(&LIB/&OBJ)
424000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
424100000000
424200000000             ADDMSGD +
424300000000                MSGID(TXT0068) +
424400000000                MSGF(&LIB/&OBJ) +
424500000000                MSG( +
424600000000'Commit & Rollback'                                                   +
424700000000                ) +
424800000000                SEV(0) +
424900000000     /*   No replacement variables defined!                         */ +
425000000000                ALROPT(*NO) +
425100000000                CCSID(65535) +
425200000000                /*  -EOF-  */
425300000000
425400000000     /*-------------------------------------------------------------*/
425500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0069                    */
425600000000     /* 80-/132- Zeichen Modus                                      */
425700000000     /*-------------------------------------------------------------*/
425800000000
425900000000             RMVMSGD MSGID(TXT0069) MSGF(&LIB/&OBJ)
426000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
426100000000
426200000000             ADDMSGD +
426300000000                MSGID(TXT0069) +
426400000000                MSGF(&LIB/&OBJ) +
426500000000                MSG( +
426600000000'80-/132- Zeichen Modus'                                              +
426700000000                ) +
426800000000                SEV(0) +
426900000000     /*   No replacement variables defined!                         */ +
427000000000                ALROPT(*NO) +
427100000000                CCSID(65535) +
427200000000                /*  -EOF-  */
427300000000
427400000000     /*-------------------------------------------------------------*/
427500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0070                    */
427600000000     /* Flexible Suchfunktionen                                     */
427700000000     /*-------------------------------------------------------------*/
427800000000
427900000000             RMVMSGD MSGID(TXT0070) MSGF(&LIB/&OBJ)
428000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
428100000000
428200000000             ADDMSGD +
428300000000                MSGID(TXT0070) +
428400000000                MSGF(&LIB/&OBJ) +
428500000000                MSG( +
428600000000'Flexible Suchfunktionen'                                             +
428700000000                ) +
428800000000                SEV(0) +
428900000000     /*   No replacement variables defined!                         */ +
429000000000                ALROPT(*NO) +
429100000000                CCSID(65535) +
429200000000                /*  -EOF-  */
429300000000
429400000000     /*-------------------------------------------------------------*/
429500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0071                    */
429600000000     /* Indiv. Tastaturbelegung                                     */
429700000000     /*-------------------------------------------------------------*/
429800000000
429900000000             RMVMSGD MSGID(TXT0071) MSGF(&LIB/&OBJ)
430000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
430100000000
430200000000             ADDMSGD +
430300000000                MSGID(TXT0071) +
430400000000                MSGF(&LIB/&OBJ) +
430500000000                MSG( +
430600000000'Indiv. Tastaturbelegung'                                             +
430700000000                ) +
430800000000                SEV(0) +
430900000000     /*   No replacement variables defined!                         */ +
431000000000                ALROPT(*NO) +
431100000000                CCSID(65535) +
431200000000                /*  -EOF-  */
431300000000
431400000000     /*-------------------------------------------------------------*/
431500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0072                    */
431600000000     /* Indiv. Spracherweiterungen                                  */
431700000000     /*-------------------------------------------------------------*/
431800000000
431900000000             RMVMSGD MSGID(TXT0072) MSGF(&LIB/&OBJ)
432000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
432100000000
432200000000             ADDMSGD +
432300000000                MSGID(TXT0072) +
432400000000                MSGF(&LIB/&OBJ) +
432500000000                MSG( +
432600000000'Indiv. Spracherweiterungen'                                          +
432700000000                ) +
432800000000                SEV(0) +
432900000000     /*   No replacement variables defined!                         */ +
433000000000                ALROPT(*NO) +
433100000000                CCSID(65535) +
433200000000                /*  -EOF-  */
433300000000
433400000000     /*-------------------------------------------------------------*/
433500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0073                    */
433600000000     /*  Der ultimative                                             */
433700000000     /*-------------------------------------------------------------*/
433800000000
433900000000             RMVMSGD MSGID(TXT0073) MSGF(&LIB/&OBJ)
434000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
434100000000
434200000000             ADDMSGD +
434300000000                MSGID(TXT0073) +
434400000000                MSGF(&LIB/&OBJ) +
434500000000                MSG( +
434600000000' Der ultimative'                                                     +
434700000000                ) +
434800000000                SEV(0) +
434900000000     /*   No replacement variables defined!                         */ +
435000000000                ALROPT(*NO) +
435100000000                CCSID(65535) +
435200000000                /*  -EOF-  */
435300000000
435400000000     /*-------------------------------------------------------------*/
435500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0074                    */
435600000000     /* Datenbankbrowser                                            */
435700000000     /*-------------------------------------------------------------*/
435800000000
435900000000             RMVMSGD MSGID(TXT0074) MSGF(&LIB/&OBJ)
436000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
436100000000
436200000000             ADDMSGD +
436300000000                MSGID(TXT0074) +
436400000000                MSGF(&LIB/&OBJ) +
436500000000                MSG( +
436600000000'Datenbankbrowser'                                                    +
436700000000                ) +
436800000000                SEV(0) +
436900000000     /*   No replacement variables defined!                         */ +
437000000000                ALROPT(*NO) +
437100000000                CCSID(65535) +
437200000000                /*  -EOF-  */
437300000000
437400000000     /*-------------------------------------------------------------*/
437500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0075                    */
437600000000     /*         * Highlights *                                      */
437700000000     /*-------------------------------------------------------------*/
437800000000
437900000000             RMVMSGD MSGID(TXT0075) MSGF(&LIB/&OBJ)
438000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
438100000000
438200000000             ADDMSGD +
438300000000                MSGID(TXT0075) +
438400000000                MSGF(&LIB/&OBJ) +
438500000000                MSG( +
438600000000'        * Highlights *        '                                      +
438700000000                ) +
438800000000                SEV(0) +
438900000000     /*   No replacement variables defined!                         */ +
439000000000                ALROPT(*NO) +
439100000000                CCSID(65535) +
439200000000                /*  -EOF-  */
439300000000
439400000000     /*-------------------------------------------------------------*/
439500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0076                    */
439600000000     /* Unzulässige Zeichen                                         */
439700000000     /*-------------------------------------------------------------*/
439800000000
439900000000             RMVMSGD MSGID(TXT0076) MSGF(&LIB/&OBJ)
440000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
440100000000
440200000000             ADDMSGD +
440300000000                MSGID(TXT0076) +
440400000000                MSGF(&LIB/&OBJ) +
440500000000                MSG( +
440600000000'Unzulässige Zeichen'                                                 +
440700000000                ) +
440800000000                SEV(0) +
440900000000     /*   No replacement variables defined!                         */ +
441000000000                ALROPT(*NO) +
441100000000                CCSID(65535) +
441200000000                /*  -EOF-  */
441300000000
441400000000     /*-------------------------------------------------------------*/
441500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0077                    */
441600000000     /* - Layout -                                                  */
441700000000     /*-------------------------------------------------------------*/
441800000000
441900000000             RMVMSGD MSGID(TXT0077) MSGF(&LIB/&OBJ)
442000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
442100000000
442200000000             ADDMSGD +
442300000000                MSGID(TXT0077) +
442400000000                MSGF(&LIB/&OBJ) +
442500000000                MSG( +
442600000000'- Layout -'                                                          +
442700000000                ) +
442800000000                SEV(0) +
442900000000     /*   No replacement variables defined!                         */ +
443000000000                ALROPT(*NO) +
443100000000                CCSID(65535) +
443200000000                /*  -EOF-  */
443300000000
443400000000     /*-------------------------------------------------------------*/
443500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0078                    */
443600000000     /* Suchen:                                                     */
443700000000     /*-------------------------------------------------------------*/
443800000000
443900000000             RMVMSGD MSGID(TXT0078) MSGF(&LIB/&OBJ)
444000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
444100000000
444200000000             ADDMSGD +
444300000000                MSGID(TXT0078) +
444400000000                MSGF(&LIB/&OBJ) +
444500000000                MSG( +
444600000000'Suchen:'                                                             +
444700000000                ) +
444800000000                SEV(0) +
444900000000     /*   No replacement variables defined!                         */ +
445000000000                ALROPT(*NO) +
445100000000                CCSID(65535) +
445200000000                /*  -EOF-  */
445300000000
445400000000     /*-------------------------------------------------------------*/
445500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0079                    */
445600000000     /*  A   Folge  Feld        Bezeichnung                     Typ */
445700000000     /*-------------------------------------------------------------*/
445800000000
445900000000             RMVMSGD MSGID(TXT0079) MSGF(&LIB/&OBJ)
446000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
446100000000
446200000000             ADDMSGD +
446300000000                MSGID(TXT0079) +
446400000000                MSGF(&LIB/&OBJ) +
446500000000                MSG( +
446600000000' A   Folge  Feld        Bezeichnung                     Typ        St-
446700000000rPos '                                                                +
446800000000                ) +
446900000000                SEV(0) +
447000000000     /*   No replacement variables defined!                         */ +
447100000000                ALROPT(*NO) +
447200000000                CCSID(65535) +
447300000000                /*  -EOF-  */
447400000000
447500000000     /*-------------------------------------------------------------*/
447600000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0080                    */
447700000000     /* Sichtbar .:                                                 */
447800000000     /*-------------------------------------------------------------*/
447900000000
448000000000             RMVMSGD MSGID(TXT0080) MSGF(&LIB/&OBJ)
448100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
448200000000
448300000000             ADDMSGD +
448400000000                MSGID(TXT0080) +
448500000000                MSGF(&LIB/&OBJ) +
448600000000                MSG( +
448700000000'Sichtbar .:'                                                         +
448800000000                ) +
448900000000                SEV(0) +
449000000000     /*   No replacement variables defined!                         */ +
449100000000                ALROPT(*NO) +
449200000000                CCSID(65535) +
449300000000                /*  -EOF-  */
449400000000
449500000000     /*-------------------------------------------------------------*/
449600000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0081                    */
449700000000     /* Farbe ..:                                                   */
449800000000     /*-------------------------------------------------------------*/
449900000000
450000000000             RMVMSGD MSGID(TXT0081) MSGF(&LIB/&OBJ)
450100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
450200000000
450300000000             ADDMSGD +
450400000000                MSGID(TXT0081) +
450500000000                MSGF(&LIB/&OBJ) +
450600000000                MSG( +
450700000000'Farbe ..:'                                                           +
450800000000                ) +
450900000000                SEV(0) +
451000000000     /*   No replacement variables defined!                         */ +
451100000000                ALROPT(*NO) +
451200000000                CCSID(65535) +
451300000000                /*  -EOF-  */
451400000000
451500000000     /*-------------------------------------------------------------*/
451600000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0082                    */
451700000000     /* Markierung:                                                 */
451800000000     /*-------------------------------------------------------------*/
451900000000
452000000000             RMVMSGD MSGID(TXT0082) MSGF(&LIB/&OBJ)
452100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
452200000000
452300000000             ADDMSGD +
452400000000                MSGID(TXT0082) +
452500000000                MSGF(&LIB/&OBJ) +
452600000000                MSG( +
452700000000'Markierung:'                                                         +
452800000000                ) +
452900000000                SEV(0) +
453000000000     /*   No replacement variables defined!                         */ +
453100000000                ALROPT(*NO) +
453200000000                CCSID(65535) +
453300000000                /*  -EOF-  */
453400000000
453500000000     /*-------------------------------------------------------------*/
453600000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0083                    */
453700000000     /* Max.Breite:                                                 */
453800000000     /*-------------------------------------------------------------*/
453900000000
454000000000             RMVMSGD MSGID(TXT0083) MSGF(&LIB/&OBJ)
454100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
454200000000
454300000000             ADDMSGD +
454400000000                MSGID(TXT0083) +
454500000000                MSGF(&LIB/&OBJ) +
454600000000                MSG( +
454700000000'Max.Breite:'                                                         +
454800000000                ) +
454900000000                SEV(0) +
455000000000     /*   No replacement variables defined!                         */ +
455100000000                ALROPT(*NO) +
455200000000                CCSID(65535) +
455300000000                /*  -EOF-  */
455400000000
455500000000     /*-------------------------------------------------------------*/
455600000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0084                    */
455700000000     /* Editcode:                                                   */
455800000000     /*-------------------------------------------------------------*/
455900000000
456000000000             RMVMSGD MSGID(TXT0084) MSGF(&LIB/&OBJ)
456100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
456200000000
456300000000             ADDMSGD +
456400000000                MSGID(TXT0084) +
456500000000                MSGF(&LIB/&OBJ) +
456600000000                MSG( +
456700000000'Editcode:'                                                           +
456800000000                ) +
456900000000                SEV(0) +
457000000000     /*   No replacement variables defined!                         */ +
457100000000                ALROPT(*NO) +
457200000000                CCSID(65535) +
457300000000                /*  -EOF-  */
457400000000
457500000000     /*-------------------------------------------------------------*/
457600000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0085                    */
457700000000     /* - Feldauswahl -                                             */
457800000000     /*-------------------------------------------------------------*/
457900000000
458000000000             RMVMSGD MSGID(TXT0085) MSGF(&LIB/&OBJ)
458100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
458200000000
458300000000             ADDMSGD +
458400000000                MSGID(TXT0085) +
458500000000                MSGF(&LIB/&OBJ) +
458600000000                MSG( +
458700000000'- Feldauswahl -'                                                     +
458800000000                ) +
458900000000                SEV(0) +
459000000000     /*   No replacement variables defined!                         */ +
459100000000                ALROPT(*NO) +
459200000000                CCSID(65535) +
459300000000                /*  -EOF-  */
459400000000
459500000000     /*-------------------------------------------------------------*/
459600000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0086                    */
459700000000     /*  A   Feld        Bezeichnung                                */
459800000000     /*-------------------------------------------------------------*/
459900000000
460000000000             RMVMSGD MSGID(TXT0086) MSGF(&LIB/&OBJ)
460100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
460200000000
460300000000             ADDMSGD +
460400000000                MSGID(TXT0086) +
460500000000                MSGF(&LIB/&OBJ) +
460600000000                MSG( +
460700000000' A   Feld        Bezeichnung                    '                    +
460800000000                ) +
460900000000                SEV(0) +
461000000000     /*   No replacement variables defined!                         */ +
461100000000                ALROPT(*NO) +
461200000000                CCSID(65535) +
461300000000                /*  -EOF-  */
461400000000
461500000000     /*-------------------------------------------------------------*/
461600000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0087                    */
461700000000     /*  A  Datei                  Beschreibung                     */
461800000000     /*-------------------------------------------------------------*/
461900000000
462000000000             RMVMSGD MSGID(TXT0087) MSGF(&LIB/&OBJ)
462100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
462200000000
462300000000             ADDMSGD +
462400000000                MSGID(TXT0087) +
462500000000                MSGF(&LIB/&OBJ) +
462600000000                MSG( +
462700000000' A  Datei                  Beschreibung                              -
462800000000   '                                                                  +
462900000000                ) +
463000000000                SEV(0) +
463100000000     /*   No replacement variables defined!                         */ +
463200000000                ALROPT(*NO) +
463300000000                CCSID(65535) +
463400000000                /*  -EOF-  */
463500000000
463600000000     /*-------------------------------------------------------------*/
463700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0088                    */
463800000000     /* - Anz. Datenbankrelationen   -                              */
463900000000     /*-------------------------------------------------------------*/
464000000000
464100000000             RMVMSGD MSGID(TXT0088) MSGF(&LIB/&OBJ)
464200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
464300000000
464400000000             ADDMSGD +
464500000000                MSGID(TXT0088) +
464600000000                MSGF(&LIB/&OBJ) +
464700000000                MSG( +
464800000000'- Anz. Datenbankrelationen   -'                                      +
464900000000                ) +
465000000000                SEV(0) +
465100000000     /*   No replacement variables defined!                         */ +
465200000000                ALROPT(*NO) +
465300000000                CCSID(65535) +
465400000000                /*  -EOF-  */
465500000000
465600000000     /*-------------------------------------------------------------*/
465700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0089                    */
465800000000     /* Log. Sichten:                                               */
465900000000     /*-------------------------------------------------------------*/
466000000000
466100000000             RMVMSGD MSGID(TXT0089) MSGF(&LIB/&OBJ)
466200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
466300000000
466400000000             ADDMSGD +
466500000000                MSGID(TXT0089) +
466600000000                MSGF(&LIB/&OBJ) +
466700000000                MSG( +
466800000000'Log. Sichten:'                                                       +
466900000000                ) +
467000000000                SEV(0) +
467100000000     /*   No replacement variables defined!                         */ +
467200000000                ALROPT(*NO) +
467300000000                CCSID(65535) +
467400000000                /*  -EOF-  */
467500000000
467600000000     /*-------------------------------------------------------------*/
467700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0090                    */
467800000000     /* Hex-Eingabe                                                 */
467900000000     /*-------------------------------------------------------------*/
468000000000
468100000000             RMVMSGD MSGID(TXT0090) MSGF(&LIB/&OBJ)
468200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
468300000000
468400000000             ADDMSGD +
468500000000                MSGID(TXT0090) +
468600000000                MSGF(&LIB/&OBJ) +
468700000000                MSG( +
468800000000'Hex-Eingabe'                                                         +
468900000000                ) +
469000000000                SEV(0) +
469100000000     /*   No replacement variables defined!                         */ +
469200000000                ALROPT(*NO) +
469300000000                CCSID(65535) +
469400000000                /*  -EOF-  */
469500000000
469600000000     /*-------------------------------------------------------------*/
469700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0091                    */
469800000000     /* Feld ......:                                                */
469900000000     /*-------------------------------------------------------------*/
470000000000
470100000000             RMVMSGD MSGID(TXT0091) MSGF(&LIB/&OBJ)
470200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
470300000000
470400000000             ADDMSGD +
470500000000                MSGID(TXT0091) +
470600000000                MSGF(&LIB/&OBJ) +
470700000000                MSG( +
470800000000'Feld ......:'                                                        +
470900000000                ) +
471000000000                SEV(0) +
471100000000     /*   No replacement variables defined!                         */ +
471200000000                ALROPT(*NO) +
471300000000                CCSID(65535) +
471400000000                /*  -EOF-  */
471500000000
471600000000     /*-------------------------------------------------------------*/
471700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0092                    */
471800000000     /* Feldlänge .:                                                */
471900000000     /*-------------------------------------------------------------*/
472000000000
472100000000             RMVMSGD MSGID(TXT0092) MSGF(&LIB/&OBJ)
472200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
472300000000
472400000000             ADDMSGD +
472500000000                MSGID(TXT0092) +
472600000000                MSGF(&LIB/&OBJ) +
472700000000                MSG( +
472800000000'Feldlänge .:'                                                        +
472900000000                ) +
473000000000                SEV(0) +
473100000000     /*   No replacement variables defined!                         */ +
473200000000                ALROPT(*NO) +
473300000000                CCSID(65535) +
473400000000                /*  -EOF-  */
473500000000
473600000000     /*-------------------------------------------------------------*/
473700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0093                    */
473800000000     /* Inhalt ....:                                                */
473900000000     /*-------------------------------------------------------------*/
474000000000
474100000000             RMVMSGD MSGID(TXT0093) MSGF(&LIB/&OBJ)
474200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
474300000000
474400000000             ADDMSGD +
474500000000                MSGID(TXT0093) +
474600000000                MSGF(&LIB/&OBJ) +
474700000000                MSG( +
474800000000'Inhalt ....:'                                                        +
474900000000                ) +
475000000000                SEV(0) +
475100000000     /*   No replacement variables defined!                         */ +
475200000000                ALROPT(*NO) +
475300000000                CCSID(65535) +
475400000000                /*  -EOF-  */
475500000000
475600000000     /*-------------------------------------------------------------*/
475700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0094                    */
475800000000     /* Hex .......:                                                */
475900000000     /*-------------------------------------------------------------*/
476000000000
476100000000             RMVMSGD MSGID(TXT0094) MSGF(&LIB/&OBJ)
476200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
476300000000
476400000000             ADDMSGD +
476500000000                MSGID(TXT0094) +
476600000000                MSGF(&LIB/&OBJ) +
476700000000                MSG( +
476800000000'Hex .......:'                                                        +
476900000000                ) +
477000000000                SEV(0) +
477100000000     /*   No replacement variables defined!                         */ +
477200000000                ALROPT(*NO) +
477300000000                CCSID(65535) +
477400000000                /*  -EOF-  */
477500000000
477600000000     /*-------------------------------------------------------------*/
477700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0095                    */
477800000000     /* Startposition:                                              */
477900000000     /*-------------------------------------------------------------*/
478000000000
478100000000             RMVMSGD MSGID(TXT0095) MSGF(&LIB/&OBJ)
478200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
478300000000
478400000000             ADDMSGD +
478500000000                MSGID(TXT0095) +
478600000000                MSGF(&LIB/&OBJ) +
478700000000                MSG( +
478800000000'Startposition:'                                                      +
478900000000                ) +
479000000000                SEV(0) +
479100000000     /*   No replacement variables defined!                         */ +
479200000000                ALROPT(*NO) +
479300000000                CCSID(65535) +
479400000000                /*  -EOF-  */
479500000000
479600000000     /*-------------------------------------------------------------*/
479700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0096                    */
479800000000     /* Pufferlänge:                                                */
479900000000     /*-------------------------------------------------------------*/
480000000000
480100000000             RMVMSGD MSGID(TXT0096) MSGF(&LIB/&OBJ)
480200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
480300000000
480400000000             ADDMSGD +
480500000000                MSGID(TXT0096) +
480600000000                MSGF(&LIB/&OBJ) +
480700000000                MSG( +
480800000000'Pufferlänge:'                                                        +
480900000000                ) +
481000000000                SEV(0) +
481100000000     /*   No replacement variables defined!                         */ +
481200000000                ALROPT(*NO) +
481300000000                CCSID(65535) +
481400000000                /*  -EOF-  */
481500000000
481600000000     /*-------------------------------------------------------------*/
481700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0097                    */
481800000000     /*  A   Teildatei   Bezeichnung                                */
481900000000     /*-------------------------------------------------------------*/
482000000000
482100000000             RMVMSGD MSGID(TXT0097) MSGF(&LIB/&OBJ)
482200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
482300000000
482400000000             ADDMSGD +
482500000000                MSGID(TXT0097) +
482600000000                MSGF(&LIB/&OBJ) +
482700000000                MSG( +
482800000000' A   Teildatei   Bezeichnung                                        '+
482900000000                ) +
483000000000                SEV(0) +
483100000000     /*   No replacement variables defined!                         */ +
483200000000                ALROPT(*NO) +
483300000000                CCSID(65535) +
483400000000                /*  -EOF-  */
483500000000
483600000000     /*-------------------------------------------------------------*/
483700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0098                    */
483800000000     /* - Auswahl Teildatei -                                       */
483900000000     /*-------------------------------------------------------------*/
484000000000
484100000000             RMVMSGD MSGID(TXT0098) MSGF(&LIB/&OBJ)
484200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
484300000000
484400000000             ADDMSGD +
484500000000                MSGID(TXT0098) +
484600000000                MSGF(&LIB/&OBJ) +
484700000000                MSG( +
484800000000'- Auswahl Teildatei - '                                              +
484900000000                ) +
485000000000                SEV(0) +
485100000000     /*   No replacement variables defined!                         */ +
485200000000                ALROPT(*NO) +
485300000000                CCSID(65535) +
485400000000                /*  -EOF-  */
485500000000
485600000000     /*-------------------------------------------------------------*/
485700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0099                    */
485800000000     /* Anz. Teild:                                                 */
485900000000     /*-------------------------------------------------------------*/
486000000000
486100000000             RMVMSGD MSGID(TXT0099) MSGF(&LIB/&OBJ)
486200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
486300000000
486400000000             ADDMSGD +
486500000000                MSGID(TXT0099) +
486600000000                MSGF(&LIB/&OBJ) +
486700000000                MSG( +
486800000000'Anz. Teild:'                                                         +
486900000000                ) +
487000000000                SEV(0) +
487100000000     /*   No replacement variables defined!                         */ +
487200000000                ALROPT(*NO) +
487300000000                CCSID(65535) +
487400000000                /*  -EOF-  */
487500000000
487600000000     /*-------------------------------------------------------------*/
487700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0100                    */
487800000000     /*  Teild:                                                     */
487900000000     /*-------------------------------------------------------------*/
488000000000
488100000000             RMVMSGD MSGID(TXT0100) MSGF(&LIB/&OBJ)
488200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
488300000000
488400000000             ADDMSGD +
488500000000                MSGID(TXT0100) +
488600000000                MSGF(&LIB/&OBJ) +
488700000000                MSG( +
488800000000' Teild:'                                                             +
488900000000                ) +
489000000000                SEV(0) +
489100000000     /*   No replacement variables defined!                         */ +
489200000000                ALROPT(*NO) +
489300000000                CCSID(65535) +
489400000000                /*  -EOF-  */
489500000000
489600000000     /*-------------------------------------------------------------*/
489700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0101                    */
489800000000     /* - Über Peek/400 -                                           */
489900000000     /*-------------------------------------------------------------*/
490000000000
490100000000             RMVMSGD MSGID(TXT0101) MSGF(&LIB/&OBJ)
490200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
490300000000
490400000000             ADDMSGD +
490500000000                MSGID(TXT0101) +
490600000000                MSGF(&LIB/&OBJ) +
490700000000                MSG( +
490800000000'- Über Peek/400 - '                                                  +
490900000000                ) +
491000000000                SEV(0) +
491100000000     /*   No replacement variables defined!                         */ +
491200000000                ALROPT(*NO) +
491300000000                CCSID(65535) +
491400000000                /*  -EOF-  */
491500000000
491600000000     /*-------------------------------------------------------------*/
491700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0102                    */
491800000000     /* Datum . . .                                                 */
491900000000     /*-------------------------------------------------------------*/
492000000000
492100000000             RMVMSGD MSGID(TXT0102) MSGF(&LIB/&OBJ)
492200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
492300000000
492400000000             ADDMSGD +
492500000000                MSGID(TXT0102) +
492600000000                MSGF(&LIB/&OBJ) +
492700000000                MSG( +
492800000000'Datum . . .'                                                         +
492900000000                ) +
493000000000                SEV(0) +
493100000000     /*   No replacement variables defined!                         */ +
493200000000                ALROPT(*NO) +
493300000000                CCSID(65535) +
493400000000                /*  -EOF-  */
493500000000
493600000000     /*-------------------------------------------------------------*/
493700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0103                    */
493800000000     /* Version . .                                                 */
493900000000     /*-------------------------------------------------------------*/
494000000000
494100000000             RMVMSGD MSGID(TXT0103) MSGF(&LIB/&OBJ)
494200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
494300000000
494400000000             ADDMSGD +
494500000000                MSGID(TXT0103) +
494600000000                MSGF(&LIB/&OBJ) +
494700000000                MSG( +
494800000000'Version . .'                                                         +
494900000000                ) +
495000000000                SEV(0) +
495100000000     /*   No replacement variables defined!                         */ +
495200000000                ALROPT(*NO) +
495300000000                CCSID(65535) +
495400000000                /*  -EOF-  */
495500000000
495600000000     /*-------------------------------------------------------------*/
495700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0104                    */
495800000000     /* E-mail  . .                                                 */
495900000000     /*-------------------------------------------------------------*/
496000000000
496100000000             RMVMSGD MSGID(TXT0104) MSGF(&LIB/&OBJ)
496200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
496300000000
496400000000             ADDMSGD +
496500000000                MSGID(TXT0104) +
496600000000                MSGF(&LIB/&OBJ) +
496700000000                MSG( +
496800000000'E-mail  . .'                                                         +
496900000000                ) +
497000000000                SEV(0) +
497100000000     /*   No replacement variables defined!                         */ +
497200000000                ALROPT(*NO) +
497300000000                CCSID(65535) +
497400000000                /*  -EOF-  */
497500000000
497600000000     /*-------------------------------------------------------------*/
497700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0105                    */
497800000000     /* Homepage  .                                                 */
497900000000     /*-------------------------------------------------------------*/
498000000000
498100000000             RMVMSGD MSGID(TXT0105) MSGF(&LIB/&OBJ)
498200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
498300000000
498400000000             ADDMSGD +
498500000000                MSGID(TXT0105) +
498600000000                MSGF(&LIB/&OBJ) +
498700000000                MSG( +
498800000000'Homepage  .'                                                         +
498900000000                ) +
499000000000                SEV(0) +
499100000000     /*   No replacement variables defined!                         */ +
499200000000                ALROPT(*NO) +
499300000000                CCSID(65535) +
499400000000                /*  -EOF-  */
499500000000
499600000000     /*-------------------------------------------------------------*/
499700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0106                    */
499800000000     /* Spalten Pinnen                                              */
499900000000     /*-------------------------------------------------------------*/
500000000000
500100000000             RMVMSGD MSGID(TXT0106) MSGF(&LIB/&OBJ)
500200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
500300000000
500400000000             ADDMSGD +
500500000000                MSGID(TXT0106) +
500600000000                MSGF(&LIB/&OBJ) +
500700000000                MSG( +
500800000000'Spalten Pinnen'                                                      +
500900000000                ) +
501000000000                SEV(0) +
501100000000     /*   No replacement variables defined!                         */ +
501200000000                ALROPT(*NO) +
501300000000                CCSID(65535) +
501400000000                /*  -EOF-  */
501500000000
501600000000     /*-------------------------------------------------------------*/
501700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0107                    */
501800000000     /*  Folge  Feld        Bezeichnung                      Schl.F */
501900000000     /*-------------------------------------------------------------*/
502000000000
502100000000             RMVMSGD MSGID(TXT0107) MSGF(&LIB/&OBJ)
502200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
502300000000
502400000000             ADDMSGD +
502500000000                MSGID(TXT0107) +
502600000000                MSGF(&LIB/&OBJ) +
502700000000                MSG( +
502800000000' Folge  Feld        Bezeichnung                      Schl.Feld'      +
502900000000                ) +
503000000000                SEV(0) +
503100000000     /*   No replacement variables defined!                         */ +
503200000000                ALROPT(*NO) +
503300000000                CCSID(65535) +
503400000000                /*  -EOF-  */
503500000000
503600000000     /*-------------------------------------------------------------*/
503700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0108                    */
503800000000     /*  - SQL  Auswahl -                                           */
503900000000     /*-------------------------------------------------------------*/
504000000000
504100000000             RMVMSGD MSGID(TXT0108) MSGF(&LIB/&OBJ)
504200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
504300000000
504400000000             ADDMSGD +
504500000000                MSGID(TXT0108) +
504600000000                MSGF(&LIB/&OBJ) +
504700000000                MSG( +
504800000000' - SQL  Auswahl - '                                                  +
504900000000                ) +
505000000000                SEV(0) +
505100000000     /*   No replacement variables defined!                         */ +
505200000000                ALROPT(*NO) +
505300000000                CCSID(65535) +
505400000000                /*  -EOF-  */
505500000000
505600000000     /*-------------------------------------------------------------*/
505700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0109                    */
505800000000     /* WHERE  ....:                                                */
505900000000     /*-------------------------------------------------------------*/
506000000000
506100000000             RMVMSGD MSGID(TXT0109) MSGF(&LIB/&OBJ)
506200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
506300000000
506400000000             ADDMSGD +
506500000000                MSGID(TXT0109) +
506600000000                MSGF(&LIB/&OBJ) +
506700000000                MSG( +
506800000000'WHERE  ....:'                                                        +
506900000000                ) +
507000000000                SEV(0) +
507100000000     /*   No replacement variables defined!                         */ +
507200000000                ALROPT(*NO) +
507300000000                CCSID(65535) +
507400000000                /*  -EOF-  */
507500000000
507600000000     /*-------------------------------------------------------------*/
507700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0110                    */
507800000000     /* ORDER BY  .:                                                */
507900000000     /*-------------------------------------------------------------*/
508000000000
508100000000             RMVMSGD MSGID(TXT0110) MSGF(&LIB/&OBJ)
508200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
508300000000
508400000000             ADDMSGD +
508500000000                MSGID(TXT0110) +
508600000000                MSGF(&LIB/&OBJ) +
508700000000                MSG( +
508800000000'ORDER BY  .:'                                                        +
508900000000                ) +
509000000000                SEV(0) +
509100000000     /*   No replacement variables defined!                         */ +
509200000000                ALROPT(*NO) +
509300000000                CCSID(65535) +
509400000000                /*  -EOF-  */
509500000000
509600000000     /*-------------------------------------------------------------*/
509700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0111                    */
509800000000     /* - Programm erstellen -                                      */
509900000000     /*-------------------------------------------------------------*/
510000000000
510100000000             RMVMSGD MSGID(TXT0111) MSGF(&LIB/&OBJ)
510200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
510300000000
510400000000             ADDMSGD +
510500000000                MSGID(TXT0111) +
510600000000                MSGF(&LIB/&OBJ) +
510700000000                MSG( +
510800000000'- Programm erstellen -'                                              +
510900000000                ) +
511000000000                SEV(0) +
511100000000     /*   No replacement variables defined!                         */ +
511200000000                ALROPT(*NO) +
511300000000                CCSID(65535) +
511400000000                /*  -EOF-  */
511500000000
511600000000     /*-------------------------------------------------------------*/
511700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0112                    */
511800000000     /* Kleinbuchst. erlaubt?                                       */
511900000000     /*-------------------------------------------------------------*/
512000000000
512100000000             RMVMSGD MSGID(TXT0112) MSGF(&LIB/&OBJ)
512200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
512300000000
512400000000             ADDMSGD +
512500000000                MSGID(TXT0112) +
512600000000                MSGF(&LIB/&OBJ) +
512700000000                MSG( +
512800000000'Kleinbuchst. erlaubt? '                                              +
512900000000                ) +
513000000000                SEV(0) +
513100000000     /*   No replacement variables defined!                         */ +
513200000000                ALROPT(*NO) +
513300000000                CCSID(65535) +
513400000000                /*  -EOF-  */
513500000000
513600000000     /*-------------------------------------------------------------*/
513700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0113                    */
513800000000     /* Default Groß-/Kleinb.?                                      */
513900000000     /*-------------------------------------------------------------*/
514000000000
514100000000             RMVMSGD MSGID(TXT0113) MSGF(&LIB/&OBJ)
514200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
514300000000
514400000000             ADDMSGD +
514500000000                MSGID(TXT0113) +
514600000000                MSGF(&LIB/&OBJ) +
514700000000                MSG( +
514800000000'Default Groß-/Kleinb.?'                                              +
514900000000                ) +
515000000000                SEV(0) +
515100000000     /*   No replacement variables defined!                         */ +
515200000000                ALROPT(*NO) +
515300000000                CCSID(65535) +
515400000000                /*  -EOF-  */
515500000000
515600000000     /*-------------------------------------------------------------*/
515700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0114                    */
515800000000     /* Als Default speichern?                                      */
515900000000     /*-------------------------------------------------------------*/
516000000000
516100000000             RMVMSGD MSGID(TXT0114) MSGF(&LIB/&OBJ)
516200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
516300000000
516400000000             ADDMSGD +
516500000000                MSGID(TXT0114) +
516600000000                MSGF(&LIB/&OBJ) +
516700000000                MSG( +
516800000000'Als Default speichern?'                                              +
516900000000                ) +
517000000000                SEV(0) +
517100000000     /*   No replacement variables defined!                         */ +
517200000000                ALROPT(*NO) +
517300000000                CCSID(65535) +
517400000000                /*  -EOF-  */
517500000000
517600000000     /*-------------------------------------------------------------*/
517700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0115                    */
517800000000     /* SQL-Auswahl                                                 */
517900000000     /*-------------------------------------------------------------*/
518000000000
518100000000             RMVMSGD MSGID(TXT0115) MSGF(&LIB/&OBJ)
518200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
518300000000
518400000000             ADDMSGD +
518500000000                MSGID(TXT0115) +
518600000000                MSGF(&LIB/&OBJ) +
518700000000                MSG( +
518800000000'SQL-Auswahl  '                                                       +
518900000000                ) +
519000000000                SEV(0) +
519100000000     /*   No replacement variables defined!                         */ +
519200000000                ALROPT(*NO) +
519300000000                CCSID(65535) +
519400000000                /*  -EOF-  */
519500000000
519600000000     /*-------------------------------------------------------------*/
519700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0116                    */
519800000000     /* Auswählen Arbeitsumgebung                                   */
519900000000     /*-------------------------------------------------------------*/
520000000000
520100000000             RMVMSGD MSGID(TXT0116) MSGF(&LIB/&OBJ)
520200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
520300000000
520400000000             ADDMSGD +
520500000000                MSGID(TXT0116) +
520600000000                MSGF(&LIB/&OBJ) +
520700000000                MSG( +
520800000000'Auswählen Arbeitsumgebung'                                           +
520900000000                ) +
521000000000                SEV(0) +
521100000000     /*   No replacement variables defined!                         */ +
521200000000                ALROPT(*NO) +
521300000000                CCSID(65535) +
521400000000                /*  -EOF-  */
521500000000
521600000000     /*-------------------------------------------------------------*/
521700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0117                    */
521800000000     /* Datei:                                                      */
521900000000     /*-------------------------------------------------------------*/
522000000000
522100000000             RMVMSGD MSGID(TXT0117) MSGF(&LIB/&OBJ)
522200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
522300000000
522400000000             ADDMSGD +
522500000000                MSGID(TXT0117) +
522600000000                MSGF(&LIB/&OBJ) +
522700000000                MSG( +
522800000000'Datei:'                                                              +
522900000000                ) +
523000000000                SEV(0) +
523100000000     /*   No replacement variables defined!                         */ +
523200000000                ALROPT(*NO) +
523300000000                CCSID(65535) +
523400000000                /*  -EOF-  */
523500000000
523600000000     /*-------------------------------------------------------------*/
523700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0118                    */
523800000000     /* Bibliothek:                                                 */
523900000000     /*-------------------------------------------------------------*/
524000000000
524100000000             RMVMSGD MSGID(TXT0118) MSGF(&LIB/&OBJ)
524200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
524300000000
524400000000             ADDMSGD +
524500000000                MSGID(TXT0118) +
524600000000                MSGF(&LIB/&OBJ) +
524700000000                MSG( +
524800000000'Bibliothek:'                                                         +
524900000000                ) +
525000000000                SEV(0) +
525100000000     /*   No replacement variables defined!                         */ +
525200000000                ALROPT(*NO) +
525300000000                CCSID(65535) +
525400000000                /*  -EOF-  */
525500000000
525600000000     /*-------------------------------------------------------------*/
525700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0119                    */
525800000000     /*  A   Umgebung    Bezeichnung                                */
525900000000     /*-------------------------------------------------------------*/
526000000000
526100000000             RMVMSGD MSGID(TXT0119) MSGF(&LIB/&OBJ)
526200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
526300000000
526400000000             ADDMSGD +
526500000000                MSGID(TXT0119) +
526600000000                MSGF(&LIB/&OBJ) +
526700000000                MSG( +
526800000000' A   Umgebung    Bezeichnung'                                        +
526900000000                ) +
527000000000                SEV(0) +
527100000000     /*   No replacement variables defined!                         */ +
527200000000                ALROPT(*NO) +
527300000000                CCSID(65535) +
527400000000                /*  -EOF-  */
527500000000
527600000000     /*-------------------------------------------------------------*/
527700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0120                    */
527800000000     /* Löschen Arbeitsumgebung                                     */
527900000000     /*-------------------------------------------------------------*/
528000000000
528100000000             RMVMSGD MSGID(TXT0120) MSGF(&LIB/&OBJ)
528200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
528300000000
528400000000             ADDMSGD +
528500000000                MSGID(TXT0120) +
528600000000                MSGF(&LIB/&OBJ) +
528700000000                MSG( +
528800000000'Löschen Arbeitsumgebung'                                             +
528900000000                ) +
529000000000                SEV(0) +
529100000000     /*   No replacement variables defined!                         */ +
529200000000                ALROPT(*NO) +
529300000000                CCSID(65535) +
529400000000                /*  -EOF-  */
529500000000
529600000000     /*-------------------------------------------------------------*/
529700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0121                    */
529800000000     /* Datei . . . :                                               */
529900000000     /*-------------------------------------------------------------*/
530000000000
530100000000             RMVMSGD MSGID(TXT0121) MSGF(&LIB/&OBJ)
530200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
530300000000
530400000000             ADDMSGD +
530500000000                MSGID(TXT0121) +
530600000000                MSGF(&LIB/&OBJ) +
530700000000                MSG( +
530800000000'Datei . . . :'                                                       +
530900000000                ) +
531000000000                SEV(0) +
531100000000     /*   No replacement variables defined!                         */ +
531200000000                ALROPT(*NO) +
531300000000                CCSID(65535) +
531400000000                /*  -EOF-  */
531500000000
531600000000     /*-------------------------------------------------------------*/
531700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0122                    */
531800000000     /* Bibliothek:                                                 */
531900000000     /*-------------------------------------------------------------*/
532000000000
532100000000             RMVMSGD MSGID(TXT0122) MSGF(&LIB/&OBJ)
532200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
532300000000
532400000000             ADDMSGD +
532500000000                MSGID(TXT0122) +
532600000000                MSGF(&LIB/&OBJ) +
532700000000                MSG( +
532800000000'Bibliothek:'                                                         +
532900000000                ) +
533000000000                SEV(0) +
533100000000     /*   No replacement variables defined!                         */ +
533200000000                ALROPT(*NO) +
533300000000                CCSID(65535) +
533400000000                /*  -EOF-  */
533500000000
533600000000     /*-------------------------------------------------------------*/
533700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0123                    */
533800000000     /* Teildatei . :                                               */
533900000000     /*-------------------------------------------------------------*/
534000000000
534100000000             RMVMSGD MSGID(TXT0123) MSGF(&LIB/&OBJ)
534200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
534300000000
534400000000             ADDMSGD +
534500000000                MSGID(TXT0123) +
534600000000                MSGF(&LIB/&OBJ) +
534700000000                MSG( +
534800000000'Teildatei . :'                                                       +
534900000000                ) +
535000000000                SEV(0) +
535100000000     /*   No replacement variables defined!                         */ +
535200000000                ALROPT(*NO) +
535300000000                CCSID(65535) +
535400000000                /*  -EOF-  */
535500000000
535600000000     /*-------------------------------------------------------------*/
535700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0124                    */
535800000000     /* Beschreibung:                                               */
535900000000     /*-------------------------------------------------------------*/
536000000000
536100000000             RMVMSGD MSGID(TXT0124) MSGF(&LIB/&OBJ)
536200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
536300000000
536400000000             ADDMSGD +
536500000000                MSGID(TXT0124) +
536600000000                MSGF(&LIB/&OBJ) +
536700000000                MSG( +
536800000000'Beschreibung:'                                                       +
536900000000                ) +
537000000000                SEV(0) +
537100000000     /*   No replacement variables defined!                         */ +
537200000000                ALROPT(*NO) +
537300000000                CCSID(65535) +
537400000000                /*  -EOF-  */
537500000000
537600000000     /*-------------------------------------------------------------*/
537700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0125                    */
537800000000     /* Akt.Länge .:                                                */
537900000000     /*-------------------------------------------------------------*/
538000000000
538100000000             RMVMSGD MSGID(TXT0125) MSGF(&LIB/&OBJ)
538200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
538300000000
538400000000             ADDMSGD +
538500000000                MSGID(TXT0125) +
538600000000                MSGF(&LIB/&OBJ) +
538700000000                MSG( +
538800000000'Akt.Länge .:'                                                        +
538900000000                ) +
539000000000                SEV(0) +
539100000000     /*   No replacement variables defined!                         */ +
539200000000                ALROPT(*NO) +
539300000000                CCSID(65535) +
539400000000                /*  -EOF-  */
539500000000
539600000000     /*-------------------------------------------------------------*/
539700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0126                    */
539800000000     /*  - Auswahl Satzformat -                                     */
539900000000     /*-------------------------------------------------------------*/
540000000000
540100000000             RMVMSGD MSGID(TXT0126) MSGF(&LIB/&OBJ)
540200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
540300000000
540400000000             ADDMSGD +
540500000000                MSGID(TXT0126) +
540600000000                MSGF(&LIB/&OBJ) +
540700000000                MSG( +
540800000000' - Auswahl Satzformat - '                                            +
540900000000                ) +
541000000000                SEV(0) +
541100000000     /*   No replacement variables defined!                         */ +
541200000000                ALROPT(*NO) +
541300000000                CCSID(65535) +
541400000000                /*  -EOF-  */
541500000000
541600000000     /*-------------------------------------------------------------*/
541700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0127                    */
541800000000     /* NULL Wert                                                   */
541900000000     /*-------------------------------------------------------------*/
542000000000
542100000000             RMVMSGD MSGID(TXT0127) MSGF(&LIB/&OBJ)
542200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
542300000000
542400000000             ADDMSGD +
542500000000                MSGID(TXT0127) +
542600000000                MSGF(&LIB/&OBJ) +
542700000000                MSG( +
542800000000'NULL Wert'                                                           +
542900000000                ) +
543000000000                SEV(0) +
543100000000     /*   No replacement variables defined!                         */ +
543200000000                ALROPT(*NO) +
543300000000                CCSID(65535) +
543400000000                /*  -EOF-  */
543500000000
543600000000     /*-------------------------------------------------------------*/
543700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0128                    */
543800000000     /* Text-Editor                                                 */
543900000000     /*-------------------------------------------------------------*/
544000000000
544100000000             RMVMSGD MSGID(TXT0128) MSGF(&LIB/&OBJ)
544200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
544300000000
544400000000             ADDMSGD +
544500000000                MSGID(TXT0128) +
544600000000                MSGF(&LIB/&OBJ) +
544700000000                MSG( +
544800000000'Text-Editor'                                                         +
544900000000                ) +
545000000000                SEV(0) +
545100000000     /*   No replacement variables defined!                         */ +
545200000000                ALROPT(*NO) +
545300000000                CCSID(65535) +
545400000000                /*  -EOF-  */
545500000000
545600000000     /*-------------------------------------------------------------*/
545700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0129                    */
545800000000     /* *** Datensatz gesperrt ***                                  */
545900000000     /*-------------------------------------------------------------*/
546000000000
546100000000             RMVMSGD MSGID(TXT0129) MSGF(&LIB/&OBJ)
546200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
546300000000
546400000000             ADDMSGD +
546500000000                MSGID(TXT0129) +
546600000000                MSGF(&LIB/&OBJ) +
546700000000                MSG( +
546800000000'*** Datensatz gesperrt ***'                                          +
546900000000                ) +
547000000000                SEV(0) +
547100000000     /*   No replacement variables defined!                         */ +
547200000000                ALROPT(*NO) +
547300000000                CCSID(65535) +
547400000000                /*  -EOF-  */
547500000000
547600000000     /*-------------------------------------------------------------*/
547700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0130                    */
547800000000     /* Datensatz nicht gesperrt                                    */
547900000000     /*-------------------------------------------------------------*/
548000000000
548100000000             RMVMSGD MSGID(TXT0130) MSGF(&LIB/&OBJ)
548200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
548300000000
548400000000             ADDMSGD +
548500000000                MSGID(TXT0130) +
548600000000                MSGF(&LIB/&OBJ) +
548700000000                MSG( +
548800000000'Datensatz nicht gesperrt'                                            +
548900000000                ) +
549000000000                SEV(0) +
549100000000     /*   No replacement variables defined!                         */ +
549200000000                ALROPT(*NO) +
549300000000                CCSID(65535) +
549400000000                /*  -EOF-  */
549500000000
549600000000     /*-------------------------------------------------------------*/
549700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0131                    */
549800000000     /* Satz gesperrt lesen?                                        */
549900000000     /*-------------------------------------------------------------*/
550000000000
550100000000             RMVMSGD MSGID(TXT0131) MSGF(&LIB/&OBJ)
550200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
550300000000
550400000000             ADDMSGD +
550500000000                MSGID(TXT0131) +
550600000000                MSGF(&LIB/&OBJ) +
550700000000                MSG( +
550800000000'Satz gesperrt lesen?'                                                +
550900000000                ) +
551000000000                SEV(0) +
551100000000     /*   No replacement variables defined!                         */ +
551200000000                ALROPT(*NO) +
551300000000                CCSID(65535) +
551400000000                /*  -EOF-  */
551500000000
551600000000     /*-------------------------------------------------------------*/
551700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0132                    */
551800000000     /* Datei:                                                      */
551900000000     /*-------------------------------------------------------------*/
552000000000
552100000000             RMVMSGD MSGID(TXT0132) MSGF(&LIB/&OBJ)
552200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
552300000000
552400000000             ADDMSGD +
552500000000                MSGID(TXT0132) +
552600000000                MSGF(&LIB/&OBJ) +
552700000000                MSG( +
552800000000'Datei:'                                                              +
552900000000                ) +
553000000000                SEV(0) +
553100000000     /*   No replacement variables defined!                         */ +
553200000000                ALROPT(*NO) +
553300000000                CCSID(65535) +
553400000000                /*  -EOF-  */
553500000000
553600000000     /*-------------------------------------------------------------*/
553700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0133                    */
553800000000     /* Bibliothek:                                                 */
553900000000     /*-------------------------------------------------------------*/
554000000000
554100000000             RMVMSGD MSGID(TXT0133) MSGF(&LIB/&OBJ)
554200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
554300000000
554400000000             ADDMSGD +
554500000000                MSGID(TXT0133) +
554600000000                MSGF(&LIB/&OBJ) +
554700000000                MSG( +
554800000000'Bibliothek:'                                                         +
554900000000                ) +
555000000000                SEV(0) +
555100000000     /*   No replacement variables defined!                         */ +
555200000000                ALROPT(*NO) +
555300000000                CCSID(65535) +
555400000000                /*  -EOF-  */
555500000000
555600000000     /*-------------------------------------------------------------*/
555700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0134                    */
555800000000     /* RRN:                                                        */
555900000000     /*-------------------------------------------------------------*/
556000000000
556100000000             RMVMSGD MSGID(TXT0134) MSGF(&LIB/&OBJ)
556200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
556300000000
556400000000             ADDMSGD +
556500000000                MSGID(TXT0134) +
556600000000                MSGF(&LIB/&OBJ) +
556700000000                MSG( +
556800000000'RRN:'                                                                +
556900000000                ) +
557000000000                SEV(0) +
557100000000     /*   No replacement variables defined!                         */ +
557200000000                ALROPT(*NO) +
557300000000                CCSID(65535) +
557400000000                /*  -EOF-  */
557500000000
557600000000     /*-------------------------------------------------------------*/
557700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0135                    */
557800000000     /* Seite:                                                      */
557900000000     /*-------------------------------------------------------------*/
558000000000
558100000000             RMVMSGD MSGID(TXT0135) MSGF(&LIB/&OBJ)
558200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
558300000000
558400000000             ADDMSGD +
558500000000                MSGID(TXT0135) +
558600000000                MSGF(&LIB/&OBJ) +
558700000000                MSG( +
558800000000'Seite:'                                                              +
558900000000                ) +
559000000000                SEV(0) +
559100000000     /*   No replacement variables defined!                         */ +
559200000000                ALROPT(*NO) +
559300000000                CCSID(65535) +
559400000000                /*  -EOF-  */
559500000000
559600000000     /*-------------------------------------------------------------*/
559700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0136                    */
559800000000     /* Feldname                                                    */
559900000000     /*-------------------------------------------------------------*/
560000000000
560100000000             RMVMSGD MSGID(TXT0136) MSGF(&LIB/&OBJ)
560200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
560300000000
560400000000             ADDMSGD +
560500000000                MSGID(TXT0136) +
560600000000                MSGF(&LIB/&OBJ) +
560700000000                MSG( +
560800000000'Feldname'                                                            +
560900000000                ) +
561000000000                SEV(0) +
561100000000     /*   No replacement variables defined!                         */ +
561200000000                ALROPT(*NO) +
561300000000                CCSID(65535) +
561400000000                /*  -EOF-  */
561500000000
561600000000     /*-------------------------------------------------------------*/
561700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0137                    */
561800000000     /* Feldbeschreibung                                            */
561900000000     /*-------------------------------------------------------------*/
562000000000
562100000000             RMVMSGD MSGID(TXT0137) MSGF(&LIB/&OBJ)
562200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
562300000000
562400000000             ADDMSGD +
562500000000                MSGID(TXT0137) +
562600000000                MSGF(&LIB/&OBJ) +
562700000000                MSG( +
562800000000'Feldbeschreibung'                                                    +
562900000000                ) +
563000000000                SEV(0) +
563100000000     /*   No replacement variables defined!                         */ +
563200000000                ALROPT(*NO) +
563300000000                CCSID(65535) +
563400000000                /*  -EOF-  */
563500000000
563600000000     /*-------------------------------------------------------------*/
563700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0138                    */
563800000000     /* Feldinhalt                                                  */
563900000000     /*-------------------------------------------------------------*/
564000000000
564100000000             RMVMSGD MSGID(TXT0138) MSGF(&LIB/&OBJ)
564200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
564300000000
564400000000             ADDMSGD +
564500000000                MSGID(TXT0138) +
564600000000                MSGF(&LIB/&OBJ) +
564700000000                MSG( +
564800000000'Feldinhalt'                                                          +
564900000000                ) +
565000000000                SEV(0) +
565100000000     /*   No replacement variables defined!                         */ +
565200000000                ALROPT(*NO) +
565300000000                CCSID(65535) +
565400000000                /*  -EOF-  */
565500000000
565600000000     /*-------------------------------------------------------------*/
565700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0139                    */
565800000000     /* Text:                                                       */
565900000000     /*-------------------------------------------------------------*/
566000000000
566100000000             RMVMSGD MSGID(TXT0139) MSGF(&LIB/&OBJ)
566200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
566300000000
566400000000             ADDMSGD +
566500000000                MSGID(TXT0139) +
566600000000                MSGF(&LIB/&OBJ) +
566700000000                MSG( +
566800000000'Text:'                                                               +
566900000000                ) +
567000000000                SEV(0) +
567100000000     /*   No replacement variables defined!                         */ +
567200000000                ALROPT(*NO) +
567300000000                CCSID(65535) +
567400000000                /*  -EOF-  */
567500000000
567600000000     /*-------------------------------------------------------------*/
567700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0140                    */
567800000000     /*  A   Opt  Bezeichnung                                       */
567900000000     /*-------------------------------------------------------------*/
568000000000
568100000000             RMVMSGD MSGID(TXT0140) MSGF(&LIB/&OBJ)
568200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
568300000000
568400000000             ADDMSGD +
568500000000                MSGID(TXT0140) +
568600000000                MSGF(&LIB/&OBJ) +
568700000000                MSG( +
568800000000' A   Opt  Bezeichnung                 '                              +
568900000000                ) +
569000000000                SEV(0) +
569100000000     /*   No replacement variables defined!                         */ +
569200000000                ALROPT(*NO) +
569300000000                CCSID(65535) +
569400000000                /*  -EOF-  */
569500000000
569600000000     /*-------------------------------------------------------------*/
569700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0141                    */
569800000000     /* --------- Kurzbefehle ---------                             */
569900000000     /*-------------------------------------------------------------*/
570000000000
570100000000             RMVMSGD MSGID(TXT0141) MSGF(&LIB/&OBJ)
570200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
570300000000
570400000000             ADDMSGD +
570500000000                MSGID(TXT0141) +
570600000000                MSGF(&LIB/&OBJ) +
570700000000                MSG( +
570800000000'--------- Kurzbefehle ---------'                                     +
570900000000                ) +
571000000000                SEV(0) +
571100000000     /*   No replacement variables defined!                         */ +
571200000000                ALROPT(*NO) +
571300000000                CCSID(65535) +
571400000000                /*  -EOF-  */
571500000000
571600000000     /*-------------------------------------------------------------*/
571700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0142                    */
571800000000     /*  A   Datei       Bibliothek   Bezeichnung                   */
571900000000     /*-------------------------------------------------------------*/
572000000000
572100000000             RMVMSGD MSGID(TXT0142) MSGF(&LIB/&OBJ)
572200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
572300000000
572400000000             ADDMSGD +
572500000000                MSGID(TXT0142) +
572600000000                MSGF(&LIB/&OBJ) +
572700000000                MSG( +
572800000000' A   Datei       Bibliothek   Bezeichnung'                           +
572900000000                ) +
573000000000                SEV(0) +
573100000000     /*   No replacement variables defined!                         */ +
573200000000                ALROPT(*NO) +
573300000000                CCSID(65535) +
573400000000                /*  -EOF-  */
573500000000
573600000000     /*-------------------------------------------------------------*/
573700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0143                    */
573800000000     /* - Auswahl Datei -                                           */
573900000000     /*-------------------------------------------------------------*/
574000000000
574100000000             RMVMSGD MSGID(TXT0143) MSGF(&LIB/&OBJ)
574200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
574300000000
574400000000             ADDMSGD +
574500000000                MSGID(TXT0143) +
574600000000                MSGF(&LIB/&OBJ) +
574700000000                MSG( +
574800000000'- Auswahl Datei -'                                                   +
574900000000                ) +
575000000000                SEV(0) +
575100000000     /*   No replacement variables defined!                         */ +
575200000000                ALROPT(*NO) +
575300000000                CCSID(65535) +
575400000000                /*  -EOF-  */
575500000000
575600000000     /*-------------------------------------------------------------*/
575700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0144                    */
575800000000     /* Init. NULL-Felder?                                          */
575900000000     /*-------------------------------------------------------------*/
576000000000
576100000000             RMVMSGD MSGID(TXT0144) MSGF(&LIB/&OBJ)
576200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
576300000000
576400000000             ADDMSGD +
576500000000                MSGID(TXT0144) +
576600000000                MSGF(&LIB/&OBJ) +
576700000000                MSG( +
576800000000'Init. NULL-Felder?'                                                  +
576900000000                ) +
577000000000                SEV(0) +
577100000000     /*   No replacement variables defined!                         */ +
577200000000                ALROPT(*NO) +
577300000000                CCSID(65535) +
577400000000                /*  -EOF-  */
577500000000
577600000000     /*-------------------------------------------------------------*/
577700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0145                    */
577800000000     /* Cursorposition merken?                                      */
577900000000     /*-------------------------------------------------------------*/
578000000000
578100000000             RMVMSGD MSGID(TXT0145) MSGF(&LIB/&OBJ)
578200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
578300000000
578400000000             ADDMSGD +
578500000000                MSGID(TXT0145) +
578600000000                MSGF(&LIB/&OBJ) +
578700000000                MSG( +
578800000000'Cursorposition merken?'                                              +
578900000000                ) +
579000000000                SEV(0) +
579100000000     /*   No replacement variables defined!                         */ +
579200000000                ALROPT(*NO) +
579300000000                CCSID(65535) +
579400000000                /*  -EOF-  */
579500000000
579600000000     /*-------------------------------------------------------------*/
579700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0146                    */
579800000000     /* Einfügen                                                    */
579900000000     /*-------------------------------------------------------------*/
580000000000
580100000000             RMVMSGD MSGID(TXT0146) MSGF(&LIB/&OBJ)
580200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
580300000000
580400000000             ADDMSGD +
580500000000                MSGID(TXT0146) +
580600000000                MSGF(&LIB/&OBJ) +
580700000000                MSG( +
580800000000'Einfügen'                                                            +
580900000000                ) +
581000000000                SEV(0) +
581100000000     /*   No replacement variables defined!                         */ +
581200000000                ALROPT(*NO) +
581300000000                CCSID(65535) +
581400000000                /*  -EOF-  */
581500000000
581600000000     /*-------------------------------------------------------------*/
581700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0147                    */
581800000000     /* Löschen                                                     */
581900000000     /*-------------------------------------------------------------*/
582000000000
582100000000             RMVMSGD MSGID(TXT0147) MSGF(&LIB/&OBJ)
582200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
582300000000
582400000000             ADDMSGD +
582500000000                MSGID(TXT0147) +
582600000000                MSGF(&LIB/&OBJ) +
582700000000                MSG( +
582800000000'Löschen'                                                             +
582900000000                ) +
583000000000                SEV(0) +
583100000000     /*   No replacement variables defined!                         */ +
583200000000                ALROPT(*NO) +
583300000000                CCSID(65535) +
583400000000                /*  -EOF-  */
583500000000
583600000000     /*-------------------------------------------------------------*/
583700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0148                    */
583800000000     /* von:                                                        */
583900000000     /*-------------------------------------------------------------*/
584000000000
584100000000             RMVMSGD MSGID(TXT0148) MSGF(&LIB/&OBJ)
584200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
584300000000
584400000000             ADDMSGD +
584500000000                MSGID(TXT0148) +
584600000000                MSGF(&LIB/&OBJ) +
584700000000                MSG( +
584800000000'von:   '                                                             +
584900000000                ) +
585000000000                SEV(0) +
585100000000     /*   No replacement variables defined!                         */ +
585200000000                ALROPT(*NO) +
585300000000                CCSID(65535) +
585400000000                /*  -EOF-  */
585500000000
585600000000     /*-------------------------------------------------------------*/
585700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0149                    */
585800000000     /* Länge:                                                      */
585900000000     /*-------------------------------------------------------------*/
586000000000
586100000000             RMVMSGD MSGID(TXT0149) MSGF(&LIB/&OBJ)
586200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
586300000000
586400000000             ADDMSGD +
586500000000                MSGID(TXT0149) +
586600000000                MSGF(&LIB/&OBJ) +
586700000000                MSG( +
586800000000'Länge: '                                                             +
586900000000                ) +
587000000000                SEV(0) +
587100000000     /*   No replacement variables defined!                         */ +
587200000000                ALROPT(*NO) +
587300000000                CCSID(65535) +
587400000000                /*  -EOF-  */
587500000000
587600000000     /*-------------------------------------------------------------*/
587700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0150                    */
587800000000     /* bis:                                                        */
587900000000     /*-------------------------------------------------------------*/
588000000000
588100000000             RMVMSGD MSGID(TXT0150) MSGF(&LIB/&OBJ)
588200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
588300000000
588400000000             ADDMSGD +
588500000000                MSGID(TXT0150) +
588600000000                MSGF(&LIB/&OBJ) +
588700000000                MSG( +
588800000000'bis:   '                                                             +
588900000000                ) +
589000000000                SEV(0) +
589100000000     /*   No replacement variables defined!                         */ +
589200000000                ALROPT(*NO) +
589300000000                CCSID(65535) +
589400000000                /*  -EOF-  */
589500000000
589600000000     /*-------------------------------------------------------------*/
589700000000     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
589800000000     /* Satzformat &3 für Datei &2/&1 konnte nicht abgerufen werden */
589900000000     /*-------------------------------------------------------------*/
590000000000
590100000000             RMVMSGD MSGID(USR0001) MSGF(&LIB/&OBJ)
590200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
590300000000
590400000000             ADDMSGD +
590500000000                MSGID(USR0001) +
590600000000                MSGF(&LIB/&OBJ) +
590700000000                MSG( +
590800000000'Satzformat &3 für Datei &2/&1 konnte nicht abgerufen werden.'        +
590900000000                ) +
591000000000                SEV(0) +
591100000000                FMT( +
591200000000                    (*CHAR 10) +
591300000000                    (*CHAR 10) +
591400000000                    (*CHAR 10) +
591500000000                ) +
591600000000                ALROPT(*NO) +
591700000000                CCSID(65535) +
591800000000                /*  -EOF-  */
591900000000
592000000000     /*-------------------------------------------------------------*/
592100000000     /*   Cmd-ADDMSGD für Message-ID :   USR0002                    */
592200000000     /* Liste der Satzformate für Datei &2/&1 konnte nicht abgerufe */
592300000000     /*-------------------------------------------------------------*/
592400000000
592500000000             RMVMSGD MSGID(USR0002) MSGF(&LIB/&OBJ)
592600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
592700000000
592800000000             ADDMSGD +
592900000000                MSGID(USR0002) +
593000000000                MSGF(&LIB/&OBJ) +
593100000000                MSG( +
593200000000'Liste der Satzformate für Datei &2/&1 konnte nicht abgerufen werden.'+
593300000000                ) +
593400000000                SEV(0) +
593500000000                FMT( +
593600000000                    (*CHAR 10) +
593700000000                    (*CHAR 10) +
593800000000                ) +
593900000000                ALROPT(*NO) +
594000000000                CCSID(65535) +
594100000000                /*  -EOF-  */
594200000000
594300000000     /*-------------------------------------------------------------*/
594400000000     /*   Cmd-ADDMSGD für Message-ID :   USR0003                    */
594500000000     /* Datei mit Commitment-Kontrolle geöffnet.                    */
594600000000     /*-------------------------------------------------------------*/
594700000000
594800000000             RMVMSGD MSGID(USR0003) MSGF(&LIB/&OBJ)
594900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
595000000000
595100000000             ADDMSGD +
595200000000                MSGID(USR0003) +
595300000000                MSGF(&LIB/&OBJ) +
595400000000                MSG( +
595500000000'Datei mit Commitment-Kontrolle geöffnet.'                            +
595600000000                ) +
595700000000                SEV(0) +
595800000000     /*   No replacement variables defined!                         */ +
595900000000                ALROPT(*NO) +
596000000000                CCSID(65535) +
596100000000                /*  -EOF-  */
596200000000
596300000000     /*-------------------------------------------------------------*/
596400000000     /*   Cmd-ADDMSGD für Message-ID :   USR0004                    */
596500000000     /* Datei OHNE Commitment-Kontrolle geöffnet!                   */
596600000000     /*-------------------------------------------------------------*/
596700000000
596800000000             RMVMSGD MSGID(USR0004) MSGF(&LIB/&OBJ)
596900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
597000000000
597100000000             ADDMSGD +
597200000000                MSGID(USR0004) +
597300000000                MSGF(&LIB/&OBJ) +
597400000000                MSG( +
597500000000'Datei OHNE Commitment-Kontrolle geöffnet!'                           +
597600000000                ) +
597700000000                SEV(0) +
597800000000     /*   No replacement variables defined!                         */ +
597900000000                ALROPT(*NO) +
598000000000                CCSID(65535) +
598100000000                /*  -EOF-  */
598200000000
598300000000     /*-------------------------------------------------------------*/
598400000000     /*   Cmd-ADDMSGD für Message-ID :   USR0005                    */
598500000000     /* Datei &1 konnte nicht geöffnet werden. Siehe Jobprotokoll.  */
598600000000     /*-------------------------------------------------------------*/
598700000000
598800000000             RMVMSGD MSGID(USR0005) MSGF(&LIB/&OBJ)
598900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
599000000000
599100000000             ADDMSGD +
599200000000                MSGID(USR0005) +
599300000000                MSGF(&LIB/&OBJ) +
599400000000                MSG( +
599500000000'Datei &1 konnte nicht geöffnet werden. Siehe Jobprotokoll.'          +
599600000000                ) +
599700000000                SEV(0) +
599800000000                FMT( +
599900000000                    (*CHAR 10) +
600000000000                ) +
600100000000                ALROPT(*NO) +
600200000000                CCSID(65535) +
600300000000                /*  -EOF-  */
600400000000
600500000000     /*-------------------------------------------------------------*/
600600000000     /*   Cmd-ADDMSGD für Message-ID :   USR0006                    */
600700000000     /* Keine Schlüsselinformationen in Datei &1 in Bibliothek &2.  */
600800000000     /*-------------------------------------------------------------*/
600900000000
601000000000             RMVMSGD MSGID(USR0006) MSGF(&LIB/&OBJ)
601100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
601200000000
601300000000             ADDMSGD +
601400000000                MSGID(USR0006) +
601500000000                MSGF(&LIB/&OBJ) +
601600000000                MSG( +
601700000000'Keine Schlüsselinformationen in Datei &1 in Bibliothek &2.'          +
601800000000                ) +
601900000000                SEV(0) +
602000000000                FMT( +
602100000000                    (*CHAR 10) +
602200000000                    (*CHAR 10) +
602300000000                ) +
602400000000                ALROPT(*NO) +
602500000000                CCSID(65535) +
602600000000                /*  -EOF-  */
602700000000
602800000000     /*-------------------------------------------------------------*/
602900000000     /*   Cmd-ADDMSGD für Message-ID :   USR0007                    */
603000000000     /* Die Datei &2/&1 konnte nur für INPUT geöffnet werden. Änder */
603100000000     /*-------------------------------------------------------------*/
603200000000
603300000000             RMVMSGD MSGID(USR0007) MSGF(&LIB/&OBJ)
603400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
603500000000
603600000000             ADDMSGD +
603700000000                MSGID(USR0007) +
603800000000                MSGF(&LIB/&OBJ) +
603900000000                MSG( +
604000000000'Die Datei &2/&1 konnte nur für INPUT geöffnet werden. Änderungen sind-
604100000000 nicht möglich.'                                                      +
604200000000                ) +
604300000000                SECLVL( +
604400000000'&N &N Mögliche Ursachen: &N &B 1. Der Debugger ist mit dem Parameter -
604500000000UPDPROD(*NO) gestartet worden. &B 2. Es handelt sich um eine JOIN-Date-
604600000000i &B 3. Es gibt referenzielle Integritätsregeln und die Datei wird nic-
604700000000ht journalisiert. &B 4. Es gibt Triggerdefinitionen und die Triggerpro-
604800000000gramme befinden sich nicht in der Bibliotheksliste &B 5. Es handelt si-
604900000000ch um eine logische Datei, die auf mehreren Teildateien basiert.'     +
605000000000                ) +
605100000000                SEV(0) +
605200000000                FMT( +
605300000000                    (*CHAR 10) +
605400000000                    (*CHAR 10) +
605500000000                ) +
605600000000                ALROPT(*NO) +
605700000000                CCSID(65535) +
605800000000                /*  -EOF-  */
605900000000
606000000000     /*-------------------------------------------------------------*/
606100000000     /*   Cmd-ADDMSGD für Message-ID :   USR0008                    */
606200000000     /* Die Datei &2/&1 konnte nicht gefunden werden.               */
606300000000     /*-------------------------------------------------------------*/
606400000000
606500000000             RMVMSGD MSGID(USR0008) MSGF(&LIB/&OBJ)
606600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
606700000000
606800000000             ADDMSGD +
606900000000                MSGID(USR0008) +
607000000000                MSGF(&LIB/&OBJ) +
607100000000                MSG( +
607200000000'Die Datei &2/&1 konnte nicht gefunden werden.'                       +
607300000000                ) +
607400000000                SEV(0) +
607500000000                FMT( +
607600000000                    (*CHAR 10) +
607700000000                    (*CHAR 10) +
607800000000                ) +
607900000000                ALROPT(*NO) +
608000000000                CCSID(65535) +
608100000000                /*  -EOF-  */
608200000000
608300000000     /*-------------------------------------------------------------*/
608400000000     /*   Cmd-ADDMSGD für Message-ID :   USR0009                    */
608500000000     /* Fehler beim Abrufen der Objektbeschreibung für Datei &2/&1. */
608600000000     /*-------------------------------------------------------------*/
608700000000
608800000000             RMVMSGD MSGID(USR0009) MSGF(&LIB/&OBJ)
608900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
609000000000
609100000000             ADDMSGD +
609200000000                MSGID(USR0009) +
609300000000                MSGF(&LIB/&OBJ) +
609400000000                MSG( +
609500000000'Fehler beim Abrufen der Objektbeschreibung für Datei &2/&1.'         +
609600000000                ) +
609700000000                SEV(0) +
609800000000                FMT( +
609900000000                    (*CHAR 10) +
610000000000                    (*CHAR 10) +
610100000000                ) +
610200000000                ALROPT(*NO) +
610300000000                CCSID(65535) +
610400000000                /*  -EOF-  */
610500000000
610600000000     /*-------------------------------------------------------------*/
610700000000     /*   Cmd-ADDMSGD für Message-ID :   USR0010                    */
610800000000     /* Bibliothek &1 nicht gefunden.                               */
610900000000     /*-------------------------------------------------------------*/
611000000000
611100000000             RMVMSGD MSGID(USR0010) MSGF(&LIB/&OBJ)
611200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
611300000000
611400000000             ADDMSGD +
611500000000                MSGID(USR0010) +
611600000000                MSGF(&LIB/&OBJ) +
611700000000                MSG( +
611800000000'Bibliothek &1 nicht gefunden.'                                       +
611900000000                ) +
612000000000                SEV(0) +
612100000000                FMT( +
612200000000                    (*CHAR 10) +
612300000000                ) +
612400000000                ALROPT(*NO) +
612500000000                CCSID(65535) +
612600000000                /*  -EOF-  */
612700000000
612800000000     /*-------------------------------------------------------------*/
612900000000     /*   Cmd-ADDMSGD für Message-ID :   USR0011                    */
613000000000     /* Datei konnte nicht geöffnet werden. Weitere Informationen i */
613100000000     /*-------------------------------------------------------------*/
613200000000
613300000000             RMVMSGD MSGID(USR0011) MSGF(&LIB/&OBJ)
613400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
613500000000
613600000000             ADDMSGD +
613700000000                MSGID(USR0011) +
613800000000                MSGF(&LIB/&OBJ) +
613900000000                MSG( +
614000000000'Datei konnte nicht geöffnet werden. Weitere Informationen im erweiter-
614100000000ten Hilfetext oder im Jobprotokoll.'                                  +
614200000000                ) +
614300000000                SECLVL( +
614400000000'&N &N Fehlertext  . . :   &1'                                        +
614500000000                ) +
614600000000                SEV(0) +
614700000000                FMT( +
614800000000                    (*CHAR 256) +
614900000000                ) +
615000000000                ALROPT(*NO) +
615100000000                CCSID(65535) +
615200000000                /*  -EOF-  */
615300000000
615400000000     /*-------------------------------------------------------------*/
615500000000     /*   Cmd-ADDMSGD für Message-ID :   USR0012                    */
615600000000     /* C-IO Fehler &2: &1                                          */
615700000000     /*-------------------------------------------------------------*/
615800000000
615900000000             RMVMSGD MSGID(USR0012) MSGF(&LIB/&OBJ)
616000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
616100000000
616200000000             ADDMSGD +
616300000000                MSGID(USR0012) +
616400000000                MSGF(&LIB/&OBJ) +
616500000000                MSG( +
616600000000'C-IO Fehler &2: &1'                                                  +
616700000000                ) +
616800000000                SEV(0) +
616900000000                FMT( +
617000000000                    (*CHAR 256) +
617100000000                    (*DEC 5 0) +
617200000000                ) +
617300000000                ALROPT(*NO) +
617400000000                CCSID(65535) +
617500000000                /*  -EOF-  */
617600000000
617700000000     /*-------------------------------------------------------------*/
617800000000     /*   Cmd-ADDMSGD für Message-ID :   USR0013                    */
617900000000     /* Ausführen SQL Abfrage ...                                   */
618000000000     /*-------------------------------------------------------------*/
618100000000
618200000000             RMVMSGD MSGID(USR0013) MSGF(&LIB/&OBJ)
618300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
618400000000
618500000000             ADDMSGD +
618600000000                MSGID(USR0013) +
618700000000                MSGF(&LIB/&OBJ) +
618800000000                MSG( +
618900000000'Ausführen SQL Abfrage ...'                                           +
619000000000                ) +
619100000000                SEV(0) +
619200000000     /*   No replacement variables defined!                         */ +
619300000000                ALROPT(*NO) +
619400000000                CCSID(65535) +
619500000000                /*  -EOF-  */
619600000000
619700000000     /*-------------------------------------------------------------*/
619800000000     /*   Cmd-ADDMSGD für Message-ID :   USR0014                    */
619900000000     /* Bestimmen Anzahl ausgewählter Datensätze ...                */
620000000000     /*-------------------------------------------------------------*/
620100000000
620200000000             RMVMSGD MSGID(USR0014) MSGF(&LIB/&OBJ)
620300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
620400000000
620500000000             ADDMSGD +
620600000000                MSGID(USR0014) +
620700000000                MSGF(&LIB/&OBJ) +
620800000000                MSG( +
620900000000'Bestimmen Anzahl ausgewählter Datensätze ...'                        +
621000000000                ) +
621100000000                SEV(0) +
621200000000     /*   No replacement variables defined!                         */ +
621300000000                ALROPT(*NO) +
621400000000                CCSID(65535) +
621500000000                /*  -EOF-  */
621600000000
621700000000     /*-------------------------------------------------------------*/
621800000000     /*   Cmd-ADDMSGD für Message-ID :   USR0143                    */
621900000000     /* - Auswahl Teildatei -                                       */
622000000000     /*-------------------------------------------------------------*/
622100000000
622200000000             RMVMSGD MSGID(USR0143) MSGF(&LIB/&OBJ)
622300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
622400000000
622500000000             ADDMSGD +
622600000000                MSGID(USR0143) +
622700000000                MSGF(&LIB/&OBJ) +
622800000000                MSG( +
622900000000'- Auswahl Teildatei -'                                               +
623000000000                ) +
623100000000                SEV(0) +
623200000000     /*   No replacement variables defined!                         */ +
623300000000                ALROPT(*NO) +
623400000000                CCSID(65535) +
623500000000                /*  -EOF-  */
623600000000
623700000000     /*-------------------------------------------------------------*/
623800000000     /*   Cmd-ADDMSGD für Message-ID :   USR1000                    */
623900000000     /* Keine Berechtigung für Datei &2/&1, Teildatei &3.           */
624000000000     /*-------------------------------------------------------------*/
624100000000
624200000000             RMVMSGD MSGID(USR1000) MSGF(&LIB/&OBJ)
624300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
624400000000
624500000000             ADDMSGD +
624600000000                MSGID(USR1000) +
624700000000                MSGF(&LIB/&OBJ) +
624800000000                MSG( +
624900000000'Keine Berechtigung für Datei &2/&1, Teildatei &3.'                   +
625000000000                ) +
625100000000                SEV(0) +
625200000000                FMT( +
625300000000                    (*CHAR 10) +
625400000000                    (*CHAR 10) +
625500000000                    (*CHAR 10) +
625600000000                ) +
625700000000                ALROPT(*NO) +
625800000000                CCSID(65535) +
625900000000                /*  -EOF-  */
626000000000
626100000000     /*-------------------------------------------------------------*/
626200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8100                    */
626300000000     /* Verarbeitung mit &1 abgebrochen.                            */
626400000000     /*-------------------------------------------------------------*/
626500000000
626600000000             RMVMSGD MSGID(USR8100) MSGF(&LIB/&OBJ)
626700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
626800000000
626900000000             ADDMSGD +
627000000000                MSGID(USR8100) +
627100000000                MSGF(&LIB/&OBJ) +
627200000000                MSG( +
627300000000'Verarbeitung mit &1 abgebrochen.'                                    +
627400000000                ) +
627500000000                SEV(0) +
627600000000                FMT( +
627700000000                    (*CHAR 10) +
627800000000                ) +
627900000000                ALROPT(*NO) +
628000000000                CCSID(65535) +
628100000000                /*  -EOF-  */
628200000000
628300000000     /*-------------------------------------------------------------*/
628400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8101                    */
628500000000     /* Initialisierung läuft ...                                   */
628600000000     /*-------------------------------------------------------------*/
628700000000
628800000000             RMVMSGD MSGID(USR8101) MSGF(&LIB/&OBJ)
628900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
629000000000
629100000000             ADDMSGD +
629200000000                MSGID(USR8101) +
629300000000                MSGF(&LIB/&OBJ) +
629400000000                MSG( +
629500000000'Initialisierung läuft ...'                                           +
629600000000                ) +
629700000000                SEV(0) +
629800000000     /*   No replacement variables defined!                         */ +
629900000000                ALROPT(*NO) +
630000000000                CCSID(65535) +
630100000000                /*  -EOF-  */
630200000000
630300000000     /*-------------------------------------------------------------*/
630400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8102                    */
630500000000     /* Bitte mit dem Cursor auf den Datensatz zeigen und die Anfor */
630600000000     /*-------------------------------------------------------------*/
630700000000
630800000000             RMVMSGD MSGID(USR8102) MSGF(&LIB/&OBJ)
630900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
631000000000
631100000000             ADDMSGD +
631200000000                MSGID(USR8102) +
631300000000                MSGF(&LIB/&OBJ) +
631400000000                MSG( +
631500000000'Bitte mit dem Cursor auf den Datensatz zeigen und die Anforderung wie-
631600000000derholen.'                                                            +
631700000000                ) +
631800000000                SEV(0) +
631900000000     /*   No replacement variables defined!                         */ +
632000000000                ALROPT(*NO) +
632100000000                CCSID(65535) +
632200000000                /*  -EOF-  */
632300000000
632400000000     /*-------------------------------------------------------------*/
632500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8103                    */
632600000000     /* Datei kann nicht geschlossen werden.                        */
632700000000     /*-------------------------------------------------------------*/
632800000000
632900000000             RMVMSGD MSGID(USR8103) MSGF(&LIB/&OBJ)
633000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
633100000000
633200000000             ADDMSGD +
633300000000                MSGID(USR8103) +
633400000000                MSGF(&LIB/&OBJ) +
633500000000                MSG( +
633600000000'Datei kann nicht geschlossen werden.'                                +
633700000000                ) +
633800000000                SEV(0) +
633900000000     /*   No replacement variables defined!                         */ +
634000000000                ALROPT(*NO) +
634100000000                CCSID(65535) +
634200000000                /*  -EOF-  */
634300000000
634400000000     /*-------------------------------------------------------------*/
634500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8104                    */
634600000000     /* Abrufen der Feldbeschreibung für Datei &1 in Bibliothek &2. */
634700000000     /*-------------------------------------------------------------*/
634800000000
634900000000             RMVMSGD MSGID(USR8104) MSGF(&LIB/&OBJ)
635000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
635100000000
635200000000             ADDMSGD +
635300000000                MSGID(USR8104) +
635400000000                MSGF(&LIB/&OBJ) +
635500000000                MSG( +
635600000000'Abrufen der Feldbeschreibung für Datei &1 in Bibliothek &2.'         +
635700000000                ) +
635800000000                SEV(0) +
635900000000                FMT( +
636000000000                    (*CHAR 10) +
636100000000                    (*CHAR 10) +
636200000000                ) +
636300000000                ALROPT(*NO) +
636400000000                CCSID(65535) +
636500000000                /*  -EOF-  */
636600000000
636700000000     /*-------------------------------------------------------------*/
636800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8105                    */
636900000000     /* Abrufen der Satzformate für Datei &1 in Bibliothek &2.      */
637000000000     /*-------------------------------------------------------------*/
637100000000
637200000000             RMVMSGD MSGID(USR8105) MSGF(&LIB/&OBJ)
637300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
637400000000
637500000000             ADDMSGD +
637600000000                MSGID(USR8105) +
637700000000                MSGF(&LIB/&OBJ) +
637800000000                MSG( +
637900000000'Abrufen der Satzformate für Datei &1 in Bibliothek &2.'              +
638000000000                ) +
638100000000                SEV(0) +
638200000000                FMT( +
638300000000                    (*CHAR 10) +
638400000000                    (*CHAR 10) +
638500000000                ) +
638600000000                ALROPT(*NO) +
638700000000                CCSID(65535) +
638800000000                /*  -EOF-  */
638900000000
639000000000     /*-------------------------------------------------------------*/
639100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8106                    */
639200000000     /* Abrufen von Netzwerkattributen.                             */
639300000000     /*-------------------------------------------------------------*/
639400000000
639500000000             RMVMSGD MSGID(USR8106) MSGF(&LIB/&OBJ)
639600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
639700000000
639800000000             ADDMSGD +
639900000000                MSGID(USR8106) +
640000000000                MSGF(&LIB/&OBJ) +
640100000000                MSG( +
640200000000'Abrufen von Netzwerkattributen.'                                     +
640300000000                ) +
640400000000                SEV(0) +
640500000000     /*   No replacement variables defined!                         */ +
640600000000                ALROPT(*NO) +
640700000000                CCSID(65535) +
640800000000                /*  -EOF-  */
640900000000
641000000000     /*-------------------------------------------------------------*/
641100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8107                    */
641200000000     /* Abrufen von Objektattributen für Objekt &1 in Bibliothek &2 */
641300000000     /*-------------------------------------------------------------*/
641400000000
641500000000             RMVMSGD MSGID(USR8107) MSGF(&LIB/&OBJ)
641600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
641700000000
641800000000             ADDMSGD +
641900000000                MSGID(USR8107) +
642000000000                MSGF(&LIB/&OBJ) +
642100000000                MSG( +
642200000000'Abrufen von Objektattributen für Objekt &1 in Bibliothek &2.'        +
642300000000                ) +
642400000000                SEV(0) +
642500000000                FMT( +
642600000000                    (*CHAR 10) +
642700000000                    (*CHAR 10) +
642800000000                    (*CHAR 10) +
642900000000                ) +
643000000000                ALROPT(*NO) +
643100000000                CCSID(65535) +
643200000000                /*  -EOF-  */
643300000000
643400000000     /*-------------------------------------------------------------*/
643500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8108                    */
643600000000     /* Feld '&1' in Datei &2 in Bibliothek &3 nicht gefunden.      */
643700000000     /*-------------------------------------------------------------*/
643800000000
643900000000             RMVMSGD MSGID(USR8108) MSGF(&LIB/&OBJ)
644000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
644100000000
644200000000             ADDMSGD +
644300000000                MSGID(USR8108) +
644400000000                MSGF(&LIB/&OBJ) +
644500000000                MSG( +
644600000000'Feld ''&1'' in Datei &2 in Bibliothek &3 nicht gefunden.'            +
644700000000                ) +
644800000000                SEV(0) +
644900000000                FMT( +
645000000000                    (*CHAR 10) +
645100000000                    (*CHAR 10) +
645200000000                    (*CHAR 10) +
645300000000                ) +
645400000000                ALROPT(*NO) +
645500000000                CCSID(65535) +
645600000000                /*  -EOF-  */
645700000000
645800000000     /*-------------------------------------------------------------*/
645900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8109                    */
646000000000     /* Abrufen der Teildateibeschreibung für Teildatei &3 in Datei */
646100000000     /*-------------------------------------------------------------*/
646200000000
646300000000             RMVMSGD MSGID(USR8109) MSGF(&LIB/&OBJ)
646400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
646500000000
646600000000             ADDMSGD +
646700000000                MSGID(USR8109) +
646800000000                MSGF(&LIB/&OBJ) +
646900000000                MSG( +
647000000000'Abrufen der Teildateibeschreibung für Teildatei &3 in Datei &1 in Bib-
647100000000liothek &2.'                                                          +
647200000000                ) +
647300000000                SEV(0) +
647400000000                FMT( +
647500000000                    (*CHAR 10) +
647600000000                    (*CHAR 10) +
647700000000                    (*CHAR 10) +
647800000000                ) +
647900000000                ALROPT(*NO) +
648000000000                CCSID(65535) +
648100000000                /*  -EOF-  */
648200000000
648300000000     /*-------------------------------------------------------------*/
648400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8110                    */
648500000000     /* Auswahl '&1' nicht gültig.                                  */
648600000000     /*-------------------------------------------------------------*/
648700000000
648800000000             RMVMSGD MSGID(USR8110) MSGF(&LIB/&OBJ)
648900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
649000000000
649100000000             ADDMSGD +
649200000000                MSGID(USR8110) +
649300000000                MSGF(&LIB/&OBJ) +
649400000000                MSG( +
649500000000'Auswahl ''&1'' nicht gültig.'                                        +
649600000000                ) +
649700000000                SEV(0) +
649800000000                FMT( +
649900000000                    (*CHAR 10) +
650000000000                ) +
650100000000                ALROPT(*NO) +
650200000000                CCSID(65535) +
650300000000                /*  -EOF-  */
650400000000
650500000000     /*-------------------------------------------------------------*/
650600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8111                    */
650700000000     /* Alle Datensätze verarbeiten.                                */
650800000000     /*-------------------------------------------------------------*/
650900000000
651000000000             RMVMSGD MSGID(USR8111) MSGF(&LIB/&OBJ)
651100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
651200000000
651300000000             ADDMSGD +
651400000000                MSGID(USR8111) +
651500000000                MSGF(&LIB/&OBJ) +
651600000000                MSG( +
651700000000'Alle Datensätze verarbeiten.'                                        +
651800000000                ) +
651900000000                SEV(0) +
652000000000     /*   No replacement variables defined!                         */ +
652100000000                ALROPT(*NO) +
652200000000                CCSID(65535) +
652300000000                /*  -EOF-  */
652400000000
652500000000     /*-------------------------------------------------------------*/
652600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8112                    */
652700000000     /* Verarbeitung bestätigt.                                     */
652800000000     /*-------------------------------------------------------------*/
652900000000
653000000000             RMVMSGD MSGID(USR8112) MSGF(&LIB/&OBJ)
653100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
653200000000
653300000000             ADDMSGD +
653400000000                MSGID(USR8112) +
653500000000                MSGF(&LIB/&OBJ) +
653600000000                MSG( +
653700000000'Verarbeitung bestätigt.'                                             +
653800000000                ) +
653900000000                SEV(0) +
654000000000     /*   No replacement variables defined!                         */ +
654100000000                ALROPT(*NO) +
654200000000                CCSID(65535) +
654300000000                /*  -EOF-  */
654400000000
654500000000     /*-------------------------------------------------------------*/
654600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8113                    */
654700000000     /* Interner Befehl &1 nicht gültig.                            */
654800000000     /*-------------------------------------------------------------*/
654900000000
655000000000             RMVMSGD MSGID(USR8113) MSGF(&LIB/&OBJ)
655100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
655200000000
655300000000             ADDMSGD +
655400000000                MSGID(USR8113) +
655500000000                MSGF(&LIB/&OBJ) +
655600000000                MSG( +
655700000000'Interner Befehl &1 nicht gültig.'                                    +
655800000000                ) +
655900000000                SEV(0) +
656000000000                FMT( +
656100000000                    (*CHAR 10) +
656200000000                ) +
656300000000                ALROPT(*NO) +
656400000000                CCSID(65535) +
656500000000                /*  -EOF-  */
656600000000
656700000000     /*-------------------------------------------------------------*/
656800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8114                    */
656900000000     /* RPG-Programm wird erstellt ...                              */
657000000000     /*-------------------------------------------------------------*/
657100000000
657200000000             RMVMSGD MSGID(USR8114) MSGF(&LIB/&OBJ)
657300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
657400000000
657500000000             ADDMSGD +
657600000000                MSGID(USR8114) +
657700000000                MSGF(&LIB/&OBJ) +
657800000000                MSG( +
657900000000'RPG-Programm wird erstellt ...'                                      +
658000000000                ) +
658100000000                SEV(0) +
658200000000     /*   No replacement variables defined!                         */ +
658300000000                ALROPT(*NO) +
658400000000                CCSID(65535) +
658500000000                /*  -EOF-  */
658600000000
658700000000     /*-------------------------------------------------------------*/
658800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8115                    */
658900000000     /* Anfang des Datensatzes angezeigt.                           */
659000000000     /*-------------------------------------------------------------*/
659100000000
659200000000             RMVMSGD MSGID(USR8115) MSGF(&LIB/&OBJ)
659300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
659400000000
659500000000             ADDMSGD +
659600000000                MSGID(USR8115) +
659700000000                MSGF(&LIB/&OBJ) +
659800000000                MSG( +
659900000000'Anfang des Datensatzes angezeigt.'                                   +
660000000000                ) +
660100000000                SEV(0) +
660200000000     /*   No replacement variables defined!                         */ +
660300000000                ALROPT(*NO) +
660400000000                CCSID(65535) +
660500000000                /*  -EOF-  */
660600000000
660700000000     /*-------------------------------------------------------------*/
660800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8116                    */
660900000000     /* Ende des Datensatzes angezeigt.                             */
661000000000     /*-------------------------------------------------------------*/
661100000000
661200000000             RMVMSGD MSGID(USR8116) MSGF(&LIB/&OBJ)
661300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
661400000000
661500000000             ADDMSGD +
661600000000                MSGID(USR8116) +
661700000000                MSGF(&LIB/&OBJ) +
661800000000                MSG( +
661900000000'Ende des Datensatzes angezeigt.'                                     +
662000000000                ) +
662100000000                SEV(0) +
662200000000     /*   No replacement variables defined!                         */ +
662300000000                ALROPT(*NO) +
662400000000                CCSID(65535) +
662500000000                /*  -EOF-  */
662600000000
662700000000     /*-------------------------------------------------------------*/
662800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8117                    */
662900000000     /* Bitte mit dem Cursor auf eine Spalte zeigen und die Anforde */
663000000000     /*-------------------------------------------------------------*/
663100000000
663200000000             RMVMSGD MSGID(USR8117) MSGF(&LIB/&OBJ)
663300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
663400000000
663500000000             ADDMSGD +
663600000000                MSGID(USR8117) +
663700000000                MSGF(&LIB/&OBJ) +
663800000000                MSG( +
663900000000'Bitte mit dem Cursor auf eine Spalte zeigen und die Anforderung wiede-
664000000000rholen.'                                                              +
664100000000                ) +
664200000000                SEV(0) +
664300000000     /*   No replacement variables defined!                         */ +
664400000000                ALROPT(*NO) +
664500000000                CCSID(65535) +
664600000000                /*  -EOF-  */
664700000000
664800000000     /*-------------------------------------------------------------*/
664900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8118                    */
665000000000     /* Tabelle für PIN ist voll.                                   */
665100000000     /*-------------------------------------------------------------*/
665200000000
665300000000             RMVMSGD MSGID(USR8118) MSGF(&LIB/&OBJ)
665400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
665500000000
665600000000             ADDMSGD +
665700000000                MSGID(USR8118) +
665800000000                MSGF(&LIB/&OBJ) +
665900000000                MSG( +
666000000000'Tabelle für PIN ist voll.'                                           +
666100000000                ) +
666200000000                SEV(0) +
666300000000     /*   No replacement variables defined!                         */ +
666400000000                ALROPT(*NO) +
666500000000                CCSID(65535) +
666600000000                /*  -EOF-  */
666700000000
666800000000     /*-------------------------------------------------------------*/
666900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8119                    */
667000000000     /* Datensatz bereits gepinned.                                 */
667100000000     /*-------------------------------------------------------------*/
667200000000
667300000000             RMVMSGD MSGID(USR8119) MSGF(&LIB/&OBJ)
667400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
667500000000
667600000000             ADDMSGD +
667700000000                MSGID(USR8119) +
667800000000                MSGF(&LIB/&OBJ) +
667900000000                MSG( +
668000000000'Datensatz bereits gepinned.'                                         +
668100000000                ) +
668200000000                SEV(0) +
668300000000     /*   No replacement variables defined!                         */ +
668400000000                ALROPT(*NO) +
668500000000                CCSID(65535) +
668600000000                /*  -EOF-  */
668700000000
668800000000     /*-------------------------------------------------------------*/
668900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8120                    */
669000000000     /* Datensatz nicht gefunden.                                   */
669100000000     /*-------------------------------------------------------------*/
669200000000
669300000000             RMVMSGD MSGID(USR8120) MSGF(&LIB/&OBJ)
669400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
669500000000
669600000000             ADDMSGD +
669700000000                MSGID(USR8120) +
669800000000                MSGF(&LIB/&OBJ) +
669900000000                MSG( +
670000000000'Datensatz nicht gefunden.'                                           +
670100000000                ) +
670200000000                SEV(0) +
670300000000     /*   No replacement variables defined!                         */ +
670400000000                ALROPT(*NO) +
670500000000                CCSID(65535) +
670600000000                /*  -EOF-  */
670700000000
670800000000     /*-------------------------------------------------------------*/
670900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8121                    */
671000000000     /* Datensatz ist nicht gepinned.                               */
671100000000     /*-------------------------------------------------------------*/
671200000000
671300000000             RMVMSGD MSGID(USR8121) MSGF(&LIB/&OBJ)
671400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
671500000000
671600000000             ADDMSGD +
671700000000                MSGID(USR8121) +
671800000000                MSGF(&LIB/&OBJ) +
671900000000                MSG( +
672000000000'Datensatz ist nicht gepinned.'                                       +
672100000000                ) +
672200000000                SEV(0) +
672300000000     /*   No replacement variables defined!                         */ +
672400000000                ALROPT(*NO) +
672500000000                CCSID(65535) +
672600000000                /*  -EOF-  */
672700000000
672800000000     /*-------------------------------------------------------------*/
672900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8122                    */
673000000000     /* Funktionstaste nicht zulässig.                              */
673100000000     /*-------------------------------------------------------------*/
673200000000
673300000000             RMVMSGD MSGID(USR8122) MSGF(&LIB/&OBJ)
673400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
673500000000
673600000000             ADDMSGD +
673700000000                MSGID(USR8122) +
673800000000                MSGF(&LIB/&OBJ) +
673900000000                MSG( +
674000000000'Funktionstaste nicht zulässig.'                                      +
674100000000                ) +
674200000000                SEV(0) +
674300000000     /*   No replacement variables defined!                         */ +
674400000000                ALROPT(*NO) +
674500000000                CCSID(65535) +
674600000000                /*  -EOF-  */
674700000000
674800000000     /*-------------------------------------------------------------*/
674900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8123                    */
675000000000     /* Felder mit mehr als 1024-Zeichen können&1nicht&2geändert we */
675100000000     /*-------------------------------------------------------------*/
675200000000
675300000000             RMVMSGD MSGID(USR8123) MSGF(&LIB/&OBJ)
675400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
675500000000
675600000000             ADDMSGD +
675700000000                MSGID(USR8123) +
675800000000                MSGF(&LIB/&OBJ) +
675900000000                MSG( +
676000000000'Felder mit mehr als 1024-Zeichen können&1nicht&2geändert werden.'    +
676100000000                ) +
676200000000                SEV(0) +
676300000000                FMT( +
676400000000                    (*CHAR 1) +
676500000000                    (*CHAR 1) +
676600000000                ) +
676700000000                ALROPT(*NO) +
676800000000                CCSID(65535) +
676900000000                /*  -EOF-  */
677000000000
677100000000     /*-------------------------------------------------------------*/
677200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8124                    */
677300000000     /* Vergleichsoperand '&1' nicht zulässig.                      */
677400000000     /*-------------------------------------------------------------*/
677500000000
677600000000             RMVMSGD MSGID(USR8124) MSGF(&LIB/&OBJ)
677700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
677800000000
677900000000             ADDMSGD +
678000000000                MSGID(USR8124) +
678100000000                MSGF(&LIB/&OBJ) +
678200000000                MSG( +
678300000000'Vergleichsoperand ''&1'' nicht zulässig.'                            +
678400000000                ) +
678500000000                SECLVL( +
678600000000'&N &B Zulässige Operanden sind: &N &P EQ   - Gleich &P NE   - Ungleic-
678700000000h &P LT   - Kleiner &P GT   - Größer &P LE   - Kleiner/Gleich &P GE   -
678800000000- Größer/Gleich &P LIKE - Ähnlich'                                    +
678900000000                ) +
679000000000                SEV(0) +
679100000000                FMT( +
679200000000                    (*CHAR 10) +
679300000000                ) +
679400000000                ALROPT(*NO) +
679500000000                CCSID(65535) +
679600000000                /*  -EOF-  */
679700000000
679800000000     /*-------------------------------------------------------------*/
679900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8125                    */
680000000000     /* Keine Anzahl der max. zu durchsuchenden Datensätze angegebe */
680100000000     /*-------------------------------------------------------------*/
680200000000
680300000000             RMVMSGD MSGID(USR8125) MSGF(&LIB/&OBJ)
680400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
680500000000
680600000000             ADDMSGD +
680700000000                MSGID(USR8125) +
680800000000                MSGF(&LIB/&OBJ) +
680900000000                MSG( +
681000000000'Keine Anzahl der max. zu durchsuchenden Datensätze angegeben.'       +
681100000000                ) +
681200000000                SEV(0) +
681300000000     /*   No replacement variables defined!                         */ +
681400000000                ALROPT(*NO) +
681500000000                CCSID(65535) +
681600000000                /*  -EOF-  */
681700000000
681800000000     /*-------------------------------------------------------------*/
681900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8126                    */
682000000000     /* Vergleichsoperand '&1' nicht zulässig.                      */
682100000000     /*-------------------------------------------------------------*/
682200000000
682300000000             RMVMSGD MSGID(USR8126) MSGF(&LIB/&OBJ)
682400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
682500000000
682600000000             ADDMSGD +
682700000000                MSGID(USR8126) +
682800000000                MSGF(&LIB/&OBJ) +
682900000000                MSG( +
683000000000'Vergleichsoperand ''&1'' nicht zulässig.'                            +
683100000000                ) +
683200000000                SEV(0) +
683300000000                FMT( +
683400000000                    (*CHAR 10) +
683500000000                ) +
683600000000                ALROPT(*NO) +
683700000000                CCSID(65535) +
683800000000                /*  -EOF-  */
683900000000
684000000000     /*-------------------------------------------------------------*/
684100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8127                    */
684200000000     /* Suche läuft ...                                             */
684300000000     /*-------------------------------------------------------------*/
684400000000
684500000000             RMVMSGD MSGID(USR8127) MSGF(&LIB/&OBJ)
684600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
684700000000
684800000000             ADDMSGD +
684900000000                MSGID(USR8127) +
685000000000                MSGF(&LIB/&OBJ) +
685100000000                MSG( +
685200000000'Suche läuft ...'                                                     +
685300000000                ) +
685400000000                SEV(0) +
685500000000     /*   No replacement variables defined!                         */ +
685600000000                ALROPT(*NO) +
685700000000                CCSID(65535) +
685800000000                /*  -EOF-  */
685900000000
686000000000     /*-------------------------------------------------------------*/
686100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8128                    */
686200000000     /* Suche läuft. &1 von max. &2 Datensätzen durchsucht ...      */
686300000000     /*-------------------------------------------------------------*/
686400000000
686500000000             RMVMSGD MSGID(USR8128) MSGF(&LIB/&OBJ)
686600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
686700000000
686800000000             ADDMSGD +
686900000000                MSGID(USR8128) +
687000000000                MSGF(&LIB/&OBJ) +
687100000000                MSG( +
687200000000'Suche läuft. &1 von max. &2 Datensätzen durchsucht ...'              +
687300000000                ) +
687400000000                SEV(0) +
687500000000                FMT( +
687600000000                    (*DEC 10 0) +
687700000000                    (*DEC 10 0) +
687800000000                ) +
687900000000                ALROPT(*NO) +
688000000000                CCSID(65535) +
688100000000                /*  -EOF-  */
688200000000
688300000000     /*-------------------------------------------------------------*/
688400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8129                    */
688500000000     /* Feld '&1' mit Datentyp '&2' nicht zulässig.                 */
688600000000     /*-------------------------------------------------------------*/
688700000000
688800000000             RMVMSGD MSGID(USR8129) MSGF(&LIB/&OBJ)
688900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
689000000000
689100000000             ADDMSGD +
689200000000                MSGID(USR8129) +
689300000000                MSGF(&LIB/&OBJ) +
689400000000                MSG( +
689500000000'Feld ''&1'' mit Datentyp ''&2'' nicht zulässig.'                     +
689600000000                ) +
689700000000                SEV(0) +
689800000000                FMT( +
689900000000                    (*CHAR 10) +
690000000000                    (*CHAR 10) +
690100000000                ) +
690200000000                ALROPT(*NO) +
690300000000                CCSID(65535) +
690400000000                /*  -EOF-  */
690500000000
690600000000     /*-------------------------------------------------------------*/
690700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8130                    */
690800000000     /* Datensatz gefunden. 'SUCHEN'=Weitersuchen/'ENTER'=Ende.     */
690900000000     /*-------------------------------------------------------------*/
691000000000
691100000000             RMVMSGD MSGID(USR8130) MSGF(&LIB/&OBJ)
691200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
691300000000
691400000000             ADDMSGD +
691500000000                MSGID(USR8130) +
691600000000                MSGF(&LIB/&OBJ) +
691700000000                MSG( +
691800000000'Datensatz gefunden. ''SUCHEN''=Weitersuchen/''ENTER''=Ende.'         +
691900000000                ) +
692000000000                SEV(0) +
692100000000     /*   No replacement variables defined!                         */ +
692200000000                ALROPT(*NO) +
692300000000                CCSID(65535) +
692400000000                /*  -EOF-  */
692500000000
692600000000     /*-------------------------------------------------------------*/
692700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8131                    */
692800000000     /* Dateiende erreicht. Zeichenfolge nicht gefunden. 'SUCHEN'=W */
692900000000     /*-------------------------------------------------------------*/
693000000000
693100000000             RMVMSGD MSGID(USR8131) MSGF(&LIB/&OBJ)
693200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
693300000000
693400000000             ADDMSGD +
693500000000                MSGID(USR8131) +
693600000000                MSGF(&LIB/&OBJ) +
693700000000                MSG( +
693800000000'Dateiende erreicht. Zeichenfolge nicht gefunden. ''SUCHEN''=Weitersuc-
693900000000hen/''ENTER''=Ende.'                                                  +
694000000000                ) +
694100000000                SEV(0) +
694200000000     /*   No replacement variables defined!                         */ +
694300000000                ALROPT(*NO) +
694400000000                CCSID(65535) +
694500000000                /*  -EOF-  */
694600000000
694700000000     /*-------------------------------------------------------------*/
694800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8132                    */
694900000000     /* Maximale Anzahl Datensätze durchsucht. 'SUCHEN'=Weitersuche */
695000000000     /*-------------------------------------------------------------*/
695100000000
695200000000             RMVMSGD MSGID(USR8132) MSGF(&LIB/&OBJ)
695300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
695400000000
695500000000             ADDMSGD +
695600000000                MSGID(USR8132) +
695700000000                MSGF(&LIB/&OBJ) +
695800000000                MSG( +
695900000000'Maximale Anzahl Datensätze durchsucht. ''SUCHEN''=Weitersuchen/''ENTE-
696000000000R''=Ende.'                                                            +
696100000000                ) +
696200000000                SEV(0) +
696300000000     /*   No replacement variables defined!                         */ +
696400000000                ALROPT(*NO) +
696500000000                CCSID(65535) +
696600000000                /*  -EOF-  */
696700000000
696800000000     /*-------------------------------------------------------------*/
696900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8133                    */
697000000000     /* 1=case-sensitive; 0=nicht case-sensitive                    */
697100000000     /*-------------------------------------------------------------*/
697200000000
697300000000             RMVMSGD MSGID(USR8133) MSGF(&LIB/&OBJ)
697400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
697500000000
697600000000             ADDMSGD +
697700000000                MSGID(USR8133) +
697800000000                MSGF(&LIB/&OBJ) +
697900000000                MSG( +
698000000000'1=case-sensitive; 0=nicht case-sensitive'                            +
698100000000                ) +
698200000000                SEV(0) +
698300000000     /*   No replacement variables defined!                         */ +
698400000000                ALROPT(*NO) +
698500000000                CCSID(65535) +
698600000000                /*  -EOF-  */
698700000000
698800000000     /*-------------------------------------------------------------*/
698900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8134                    */
699000000000     /* Operand &1 bei &2 nicht erlaubt.                            */
699100000000     /*-------------------------------------------------------------*/
699200000000
699300000000             RMVMSGD MSGID(USR8134) MSGF(&LIB/&OBJ)
699400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
699500000000
699600000000             ADDMSGD +
699700000000                MSGID(USR8134) +
699800000000                MSGF(&LIB/&OBJ) +
699900000000                MSG( +
700000000000'Operand &1 bei &2 nicht erlaubt.'                                    +
700100000000                ) +
700200000000                SEV(0) +
700300000000                FMT( +
700400000000                    (*CHAR 10) +
700500000000                    (*CHAR 10) +
700600000000                ) +
700700000000                ALROPT(*NO) +
700800000000                CCSID(65535) +
700900000000                /*  -EOF-  */
701000000000
701100000000     /*-------------------------------------------------------------*/
701200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8135                    */
701300000000     /* Operand &1 ist bei Datentyp &2 nicht erlaubt.               */
701400000000     /*-------------------------------------------------------------*/
701500000000
701600000000             RMVMSGD MSGID(USR8135) MSGF(&LIB/&OBJ)
701700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
701800000000
701900000000             ADDMSGD +
702000000000                MSGID(USR8135) +
702100000000                MSGF(&LIB/&OBJ) +
702200000000                MSG( +
702300000000'Operand &1 ist bei Datentyp &2 nicht erlaubt.'                       +
702400000000                ) +
702500000000                SEV(0) +
702600000000                FMT( +
702700000000                    (*CHAR 10) +
702800000000                    (*CHAR 10) +
702900000000                ) +
703000000000                ALROPT(*NO) +
703100000000                CCSID(65535) +
703200000000                /*  -EOF-  */
703300000000
703400000000     /*-------------------------------------------------------------*/
703500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8136                    */
703600000000     /* Feld '&1' nicht gefunden.                                   */
703700000000     /*-------------------------------------------------------------*/
703800000000
703900000000             RMVMSGD MSGID(USR8136) MSGF(&LIB/&OBJ)
704000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
704100000000
704200000000             ADDMSGD +
704300000000                MSGID(USR8136) +
704400000000                MSGF(&LIB/&OBJ) +
704500000000                MSG( +
704600000000'Feld ''&1'' nicht gefunden.'                                         +
704700000000                ) +
704800000000                SECLVL( +
704900000000'&N &B Sonderwerte: &N &P *RECORD - Im ganzen Datensatz suchen, nur mi-
705000000000t EQ/NE möglich.'                                                     +
705100000000                ) +
705200000000                SEV(0) +
705300000000                FMT( +
705400000000                    (*CHAR 10) +
705500000000                ) +
705600000000                ALROPT(*NO) +
705700000000                CCSID(65535) +
705800000000                /*  -EOF-  */
705900000000
706000000000     /*-------------------------------------------------------------*/
706100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8137                    */
706200000000     /* Abrufen der Schlüsselfelder für Datei &1 in Bibliothek &2.  */
706300000000     /*-------------------------------------------------------------*/
706400000000
706500000000             RMVMSGD MSGID(USR8137) MSGF(&LIB/&OBJ)
706600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
706700000000
706800000000             ADDMSGD +
706900000000                MSGID(USR8137) +
707000000000                MSGF(&LIB/&OBJ) +
707100000000                MSG( +
707200000000'Abrufen der Schlüsselfelder für Datei &1 in Bibliothek &2.'          +
707300000000                ) +
707400000000                SEV(0) +
707500000000                FMT( +
707600000000                    (*CHAR 10) +
707700000000                    (*CHAR 10) +
707800000000                ) +
707900000000                ALROPT(*NO) +
708000000000                CCSID(65535) +
708100000000                /*  -EOF-  */
708200000000
708300000000     /*-------------------------------------------------------------*/
708400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8138                    */
708500000000     /* Ungültige numerische Werte im Feld &1 gefunden.             */
708600000000     /*-------------------------------------------------------------*/
708700000000
708800000000             RMVMSGD MSGID(USR8138) MSGF(&LIB/&OBJ)
708900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
709000000000
709100000000             ADDMSGD +
709200000000                MSGID(USR8138) +
709300000000                MSGF(&LIB/&OBJ) +
709400000000                MSG( +
709500000000'Ungültige numerische Werte im Feld &1 gefunden.'                     +
709600000000                ) +
709700000000                SEV(0) +
709800000000                FMT( +
709900000000                    (*CHAR 10) +
710000000000                ) +
710100000000                ALROPT(*NO) +
710200000000                CCSID(65535) +
710300000000                /*  -EOF-  */
710400000000
710500000000     /*-------------------------------------------------------------*/
710600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8139                    */
710700000000     /* Positionierung fehlgeschlagen.                              */
710800000000     /*-------------------------------------------------------------*/
710900000000
711000000000             RMVMSGD MSGID(USR8139) MSGF(&LIB/&OBJ)
711100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
711200000000
711300000000             ADDMSGD +
711400000000                MSGID(USR8139) +
711500000000                MSGF(&LIB/&OBJ) +
711600000000                MSG( +
711700000000'Positionierung fehlgeschlagen.'                                      +
711800000000                ) +
711900000000                SEV(0) +
712000000000     /*   No replacement variables defined!                         */ +
712100000000                ALROPT(*NO) +
712200000000                CCSID(65535) +
712300000000                /*  -EOF-  */
712400000000
712500000000     /*-------------------------------------------------------------*/
712600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8140                    */
712700000000     /* Bitte geben Sie eine Suchargument ein.                      */
712800000000     /*-------------------------------------------------------------*/
712900000000
713000000000             RMVMSGD MSGID(USR8140) MSGF(&LIB/&OBJ)
713100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
713200000000
713300000000             ADDMSGD +
713400000000                MSGID(USR8140) +
713500000000                MSGF(&LIB/&OBJ) +
713600000000                MSG( +
713700000000'Bitte geben Sie eine Suchargument ein.'                              +
713800000000                ) +
713900000000                SEV(0) +
714000000000                FMT( +
714100000000                    (*CHAR 10) +
714200000000                ) +
714300000000                ALROPT(*NO) +
714400000000                CCSID(65535) +
714500000000                /*  -EOF-  */
714600000000
714700000000     /*-------------------------------------------------------------*/
714800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8141                    */
714900000000     /* Nur '&1' für positive und '&2' für negative Zahlen als Vorz */
715000000000     /*-------------------------------------------------------------*/
715100000000
715200000000             RMVMSGD MSGID(USR8141) MSGF(&LIB/&OBJ)
715300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
715400000000
715500000000             ADDMSGD +
715600000000                MSGID(USR8141) +
715700000000                MSGF(&LIB/&OBJ) +
715800000000                MSG( +
715900000000'Nur ''&1'' für positive und ''&2'' für negative Zahlen als Vorzeichen-
716000000000 gültig.'                                                             +
716100000000                ) +
716200000000                SEV(0) +
716300000000                FMT( +
716400000000                    (*CHAR 10) +
716500000000                    (*CHAR 10) +
716600000000                ) +
716700000000                ALROPT(*NO) +
716800000000                CCSID(65535) +
716900000000                /*  -EOF-  */
717000000000
717100000000     /*-------------------------------------------------------------*/
717200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8142                    */
717300000000     /* Die Stelle &1 ist bei numerischen Werten für das Vorzeichen */
717400000000     /*-------------------------------------------------------------*/
717500000000
717600000000             RMVMSGD MSGID(USR8142) MSGF(&LIB/&OBJ)
717700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
717800000000
717900000000             ADDMSGD +
718000000000                MSGID(USR8142) +
718100000000                MSGF(&LIB/&OBJ) +
718200000000                MSG( +
718300000000'Die Stelle &1 ist bei numerischen Werten für das Vorzeichen reservier-
718400000000t.'                                                                   +
718500000000                ) +
718600000000                SEV(0) +
718700000000                FMT( +
718800000000                    (*DEC 10 0) +
718900000000                ) +
719000000000                ALROPT(*NO) +
719100000000                CCSID(65535) +
719200000000                /*  -EOF-  */
719300000000
719400000000     /*-------------------------------------------------------------*/
719500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8143                    */
719600000000     /* Der Taste &1 ist keine Programmfunktion zugeordnet.         */
719700000000     /*-------------------------------------------------------------*/
719800000000
719900000000             RMVMSGD MSGID(USR8143) MSGF(&LIB/&OBJ)
720000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
720100000000
720200000000             ADDMSGD +
720300000000                MSGID(USR8143) +
720400000000                MSGF(&LIB/&OBJ) +
720500000000                MSG( +
720600000000'Der Taste &1 ist keine Programmfunktion zugeordnet.'                 +
720700000000                ) +
720800000000                SEV(0) +
720900000000                FMT( +
721000000000                    (*CHAR 10) +
721100000000                ) +
721200000000                ALROPT(*NO) +
721300000000                CCSID(65535) +
721400000000                /*  -EOF-  */
721500000000
721600000000     /*-------------------------------------------------------------*/
721700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8144                    */
721800000000     /* Rekursive Befehlsausführung für Befehl &1 nicht zulässig.   */
721900000000     /*-------------------------------------------------------------*/
722000000000
722100000000             RMVMSGD MSGID(USR8144) MSGF(&LIB/&OBJ)
722200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
722300000000
722400000000             ADDMSGD +
722500000000                MSGID(USR8144) +
722600000000                MSGF(&LIB/&OBJ) +
722700000000                MSG( +
722800000000'Rekursive Befehlsausführung für Befehl &1 nicht zulässig.'           +
722900000000                ) +
723000000000                SEV(0) +
723100000000                FMT( +
723200000000                    (*CHAR 10) +
723300000000                ) +
723400000000                ALROPT(*NO) +
723500000000                CCSID(65535) +
723600000000                /*  -EOF-  */
723700000000
723800000000     /*-------------------------------------------------------------*/
723900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8145                    */
724000000000     /* Funktion kann bei leerer Subfile nicht ausgeführt werden.   */
724100000000     /*-------------------------------------------------------------*/
724200000000
724300000000             RMVMSGD MSGID(USR8145) MSGF(&LIB/&OBJ)
724400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
724500000000
724600000000             ADDMSGD +
724700000000                MSGID(USR8145) +
724800000000                MSGF(&LIB/&OBJ) +
724900000000                MSG( +
725000000000'Funktion kann bei leerer Subfile nicht ausgeführt werden.'           +
725100000000                ) +
725200000000                SEV(0) +
725300000000     /*   No replacement variables defined!                         */ +
725400000000                ALROPT(*NO) +
725500000000                CCSID(65535) +
725600000000                /*  -EOF-  */
725700000000
725800000000     /*-------------------------------------------------------------*/
725900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8146                    */
726000000000     /* Kein gültiges Feld für Farbauswahl.                         */
726100000000     /*-------------------------------------------------------------*/
726200000000
726300000000             RMVMSGD MSGID(USR8146) MSGF(&LIB/&OBJ)
726400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
726500000000
726600000000             ADDMSGD +
726700000000                MSGID(USR8146) +
726800000000                MSGF(&LIB/&OBJ) +
726900000000                MSG( +
727000000000'Kein gültiges Feld für Farbauswahl.'                                 +
727100000000                ) +
727200000000                SEV(0) +
727300000000     /*   No replacement variables defined!                         */ +
727400000000                ALROPT(*NO) +
727500000000                CCSID(65535) +
727600000000                /*  -EOF-  */
727700000000
727800000000     /*-------------------------------------------------------------*/
727900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8147                    */
728000000000     /* Spalte &1 ist nicht gepinned.                               */
728100000000     /*-------------------------------------------------------------*/
728200000000
728300000000             RMVMSGD MSGID(USR8147) MSGF(&LIB/&OBJ)
728400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
728500000000
728600000000             ADDMSGD +
728700000000                MSGID(USR8147) +
728800000000                MSGF(&LIB/&OBJ) +
728900000000                MSG( +
729000000000'Spalte &1 ist nicht gepinned.'                                       +
729100000000                ) +
729200000000                SEV(0) +
729300000000                FMT( +
729400000000                    (*CHAR 10) +
729500000000                ) +
729600000000                ALROPT(*NO) +
729700000000                CCSID(65535) +
729800000000                /*  -EOF-  */
729900000000
730000000000     /*-------------------------------------------------------------*/
730100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8148                    */
730200000000     /* Kein Platz mehr für Spalte '&1'!                            */
730300000000     /*-------------------------------------------------------------*/
730400000000
730500000000             RMVMSGD MSGID(USR8148) MSGF(&LIB/&OBJ)
730600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
730700000000
730800000000             ADDMSGD +
730900000000                MSGID(USR8148) +
731000000000                MSGF(&LIB/&OBJ) +
731100000000                MSG( +
731200000000'Kein Platz mehr für Spalte ''&1''!'                                  +
731300000000                ) +
731400000000                SEV(0) +
731500000000                FMT( +
731600000000                    (*CHAR 10) +
731700000000                ) +
731800000000                ALROPT(*NO) +
731900000000                CCSID(65535) +
732000000000                /*  -EOF-  */
732100000000
732200000000     /*-------------------------------------------------------------*/
732300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8149                    */
732400000000     /* Tabellierpapier ist bereits eingeschaltet.                  */
732500000000     /*-------------------------------------------------------------*/
732600000000
732700000000             RMVMSGD MSGID(USR8149) MSGF(&LIB/&OBJ)
732800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
732900000000
733000000000             ADDMSGD +
733100000000                MSGID(USR8149) +
733200000000                MSGF(&LIB/&OBJ) +
733300000000                MSG( +
733400000000'Tabellierpapier ist bereits eingeschaltet.'                          +
733500000000                ) +
733600000000                SEV(0) +
733700000000     /*   No replacement variables defined!                         */ +
733800000000                ALROPT(*NO) +
733900000000                CCSID(65535) +
734000000000                /*  -EOF-  */
734100000000
734200000000     /*-------------------------------------------------------------*/
734300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8150                    */
734400000000     /* Tabellierpapier ist bereits ausgeschaltet.                  */
734500000000     /*-------------------------------------------------------------*/
734600000000
734700000000             RMVMSGD MSGID(USR8150) MSGF(&LIB/&OBJ)
734800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
734900000000
735000000000             ADDMSGD +
735100000000                MSGID(USR8150) +
735200000000                MSGF(&LIB/&OBJ) +
735300000000                MSG( +
735400000000'Tabellierpapier ist bereits ausgeschaltet.'                          +
735500000000                ) +
735600000000                SEV(0) +
735700000000     /*   No replacement variables defined!                         */ +
735800000000                ALROPT(*NO) +
735900000000                CCSID(65535) +
736000000000                /*  -EOF-  */
736100000000
736200000000     /*-------------------------------------------------------------*/
736300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8151                    */
736400000000     /* Ungültige Name '&1' für Zieldatei.                          */
736500000000     /*-------------------------------------------------------------*/
736600000000
736700000000             RMVMSGD MSGID(USR8151) MSGF(&LIB/&OBJ)
736800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
736900000000
737000000000             ADDMSGD +
737100000000                MSGID(USR8151) +
737200000000                MSGF(&LIB/&OBJ) +
737300000000                MSG( +
737400000000'Ungültige Name ''&1'' für Zieldatei.'                                +
737500000000                ) +
737600000000                SEV(0) +
737700000000                FMT( +
737800000000                    (*CHAR 10) +
737900000000                ) +
738000000000                ALROPT(*NO) +
738100000000                CCSID(65535) +
738200000000                /*  -EOF-  */
738300000000
738400000000     /*-------------------------------------------------------------*/
738500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8152                    */
738600000000     /* Ungültige Bibliothek '&1' für Zieldatei.                    */
738700000000     /*-------------------------------------------------------------*/
738800000000
738900000000             RMVMSGD MSGID(USR8152) MSGF(&LIB/&OBJ)
739000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
739100000000
739200000000             ADDMSGD +
739300000000                MSGID(USR8152) +
739400000000                MSGF(&LIB/&OBJ) +
739500000000                MSG( +
739600000000'Ungültige Bibliothek ''&1'' für Zieldatei.'                          +
739700000000                ) +
739800000000                SEV(0) +
739900000000                FMT( +
740000000000                    (*CHAR 10) +
740100000000                ) +
740200000000                ALROPT(*NO) +
740300000000                CCSID(65535) +
740400000000                /*  -EOF-  */
740500000000
740600000000     /*-------------------------------------------------------------*/
740700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8153                    */
740800000000     /* Ungültige Teildatei '&1' für Zieldatei.                     */
740900000000     /*-------------------------------------------------------------*/
741000000000
741100000000             RMVMSGD MSGID(USR8153) MSGF(&LIB/&OBJ)
741200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
741300000000
741400000000             ADDMSGD +
741500000000                MSGID(USR8153) +
741600000000                MSGF(&LIB/&OBJ) +
741700000000                MSG( +
741800000000'Ungültige Teildatei ''&1'' für Zieldatei.'                           +
741900000000                ) +
742000000000                SEV(0) +
742100000000                FMT( +
742200000000                    (*CHAR 10) +
742300000000                ) +
742400000000                ALROPT(*NO) +
742500000000                CCSID(65535) +
742600000000                /*  -EOF-  */
742700000000
742800000000     /*-------------------------------------------------------------*/
742900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8154                    */
743000000000     /* Ungültiger Parameter für ERSETZEN/HINZUFÜGEN '&1' für Zield */
743100000000     /*-------------------------------------------------------------*/
743200000000
743300000000             RMVMSGD MSGID(USR8154) MSGF(&LIB/&OBJ)
743400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
743500000000
743600000000             ADDMSGD +
743700000000                MSGID(USR8154) +
743800000000                MSGF(&LIB/&OBJ) +
743900000000                MSG( +
744000000000'Ungültiger Parameter für ERSETZEN/HINZUFÜGEN ''&1'' für Zieldatei.'  +
744100000000                ) +
744200000000                SEV(0) +
744300000000                FMT( +
744400000000                    (*CHAR 10) +
744500000000                ) +
744600000000                ALROPT(*NO) +
744700000000                CCSID(65535) +
744800000000                /*  -EOF-  */
744900000000
745000000000     /*-------------------------------------------------------------*/
745100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8155                    */
745200000000     /* Ungültiger Parameter für DATEI ERSTELLEN '&1' für Zieldatei */
745300000000     /*-------------------------------------------------------------*/
745400000000
745500000000             RMVMSGD MSGID(USR8155) MSGF(&LIB/&OBJ)
745600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
745700000000
745800000000             ADDMSGD +
745900000000                MSGID(USR8155) +
746000000000                MSGF(&LIB/&OBJ) +
746100000000                MSG( +
746200000000'Ungültiger Parameter für DATEI ERSTELLEN ''&1'' für Zieldatei.'      +
746300000000                ) +
746400000000                SEV(0) +
746500000000                FMT( +
746600000000                    (*CHAR 10) +
746700000000                ) +
746800000000                ALROPT(*NO) +
746900000000                CCSID(65535) +
747000000000                /*  -EOF-  */
747100000000
747200000000     /*-------------------------------------------------------------*/
747300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8156                    */
747400000000     /* Verarbeitung fehlerhaft beendet.                            */
747500000000     /*-------------------------------------------------------------*/
747600000000
747700000000             RMVMSGD MSGID(USR8156) MSGF(&LIB/&OBJ)
747800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
747900000000
748000000000             ADDMSGD +
748100000000                MSGID(USR8156) +
748200000000                MSGF(&LIB/&OBJ) +
748300000000                MSG( +
748400000000'Verarbeitung fehlerhaft beendet.'                                    +
748500000000                ) +
748600000000                SEV(0) +
748700000000     /*   No replacement variables defined!                         */ +
748800000000                ALROPT(*NO) +
748900000000                CCSID(65535) +
749000000000                /*  -EOF-  */
749100000000
749200000000     /*-------------------------------------------------------------*/
749300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8157                    */
749400000000     /* Abrufen von Systemwerten.                                   */
749500000000     /*-------------------------------------------------------------*/
749600000000
749700000000             RMVMSGD MSGID(USR8157) MSGF(&LIB/&OBJ)
749800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
749900000000
750000000000             ADDMSGD +
750100000000                MSGID(USR8157) +
750200000000                MSGF(&LIB/&OBJ) +
750300000000                MSG( +
750400000000'Abrufen von Systemwerten.'                                           +
750500000000                ) +
750600000000                SEV(0) +
750700000000     /*   No replacement variables defined!                         */ +
750800000000                ALROPT(*NO) +
750900000000                CCSID(65535) +
751000000000                /*  -EOF-  */
751100000000
751200000000     /*-------------------------------------------------------------*/
751300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8158                    */
751400000000     /* Ungültige Lizenznummer '&1' eingetragen.                    */
751500000000     /*-------------------------------------------------------------*/
751600000000
751700000000             RMVMSGD MSGID(USR8158) MSGF(&LIB/&OBJ)
751800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
751900000000
752000000000             ADDMSGD +
752100000000                MSGID(USR8158) +
752200000000                MSGF(&LIB/&OBJ) +
752300000000                MSG( +
752400000000'Ungültige Lizenznummer ''&1'' eingetragen.'                          +
752500000000                ) +
752600000000                SEV(0) +
752700000000                FMT( +
752800000000                    (*CHAR 20) +
752900000000                ) +
753000000000                ALROPT(*NO) +
753100000000                CCSID(65535) +
753200000000                /*  -EOF-  */
753300000000
753400000000     /*-------------------------------------------------------------*/
753500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8159                    */
753600000000     /* Lizenzdaten konnten nicht gesichert werden.                 */
753700000000     /*-------------------------------------------------------------*/
753800000000
753900000000             RMVMSGD MSGID(USR8159) MSGF(&LIB/&OBJ)
754000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
754100000000
754200000000             ADDMSGD +
754300000000                MSGID(USR8159) +
754400000000                MSGF(&LIB/&OBJ) +
754500000000                MSG( +
754600000000'Lizenzdaten konnten nicht gesichert werden.'                         +
754700000000                ) +
754800000000                SEV(0) +
754900000000     /*   No replacement variables defined!                         */ +
755000000000                ALROPT(*NO) +
755100000000                CCSID(65535) +
755200000000                /*  -EOF-  */
755300000000
755400000000     /*-------------------------------------------------------------*/
755500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8160                    */
755600000000     /* Srachendefinition für Sprache &1 nicht verfügbar.           */
755700000000     /*-------------------------------------------------------------*/
755800000000
755900000000             RMVMSGD MSGID(USR8160) MSGF(&LIB/&OBJ)
756000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
756100000000
756200000000             ADDMSGD +
756300000000                MSGID(USR8160) +
756400000000                MSGF(&LIB/&OBJ) +
756500000000                MSG( +
756600000000'Srachendefinition für Sprache &1 nicht verfügbar.'                   +
756700000000                ) +
756800000000                SEV(0) +
756900000000                FMT( +
757000000000                    (*CHAR 10) +
757100000000                ) +
757200000000                ALROPT(*NO) +
757300000000                CCSID(65535) +
757400000000                /*  -EOF-  */
757500000000
757600000000     /*-------------------------------------------------------------*/
757700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8161                    */
757800000000     /* SPLASH-Screen eingeschaltet.                                */
757900000000     /*-------------------------------------------------------------*/
758000000000
758100000000             RMVMSGD MSGID(USR8161) MSGF(&LIB/&OBJ)
758200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
758300000000
758400000000             ADDMSGD +
758500000000                MSGID(USR8161) +
758600000000                MSGF(&LIB/&OBJ) +
758700000000                MSG( +
758800000000'SPLASH-Screen eingeschaltet.'                                        +
758900000000                ) +
759000000000                SEV(0) +
759100000000     /*   No replacement variables defined!                         */ +
759200000000                ALROPT(*NO) +
759300000000                CCSID(65535) +
759400000000                /*  -EOF-  */
759500000000
759600000000     /*-------------------------------------------------------------*/
759700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8162                    */
759800000000     /* SPLASH-Screen ausgeschaltet.                                */
759900000000     /*-------------------------------------------------------------*/
760000000000
760100000000             RMVMSGD MSGID(USR8162) MSGF(&LIB/&OBJ)
760200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
760300000000
760400000000             ADDMSGD +
760500000000                MSGID(USR8162) +
760600000000                MSGF(&LIB/&OBJ) +
760700000000                MSG( +
760800000000'SPLASH-Screen ausgeschaltet.'                                        +
760900000000                ) +
761000000000                SEV(0) +
761100000000     /*   No replacement variables defined!                         */ +
761200000000                ALROPT(*NO) +
761300000000                CCSID(65535) +
761400000000                /*  -EOF-  */
761500000000
761600000000     /*-------------------------------------------------------------*/
761700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8163                    */
761800000000     /* Zeichenkette enthält nicht darstellbare Zeichen. Ersetzungs */
761900000000     /*-------------------------------------------------------------*/
762000000000
762100000000             RMVMSGD MSGID(USR8163) MSGF(&LIB/&OBJ)
762200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
762300000000
762400000000             ADDMSGD +
762500000000                MSGID(USR8163) +
762600000000                MSGF(&LIB/&OBJ) +
762700000000                MSG( +
762800000000'Zeichenkette enthält nicht darstellbare Zeichen. Ersetzungszeichen: &-
7629000000001'                                                                    +
763000000000                ) +
763100000000                SEV(0) +
763200000000                FMT( +
763300000000                    (*CHAR 1) +
763400000000                ) +
763500000000                ALROPT(*NO) +
763600000000                CCSID(65535) +
763700000000                /*  -EOF-  */
763800000000
763900000000     /*-------------------------------------------------------------*/
764000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8164                    */
764100000000     /* Felder mit nicht darstellbaren Zeichen wurden ausgeblendet. */
764200000000     /*-------------------------------------------------------------*/
764300000000
764400000000             RMVMSGD MSGID(USR8164) MSGF(&LIB/&OBJ)
764500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
764600000000
764700000000             ADDMSGD +
764800000000                MSGID(USR8164) +
764900000000                MSGF(&LIB/&OBJ) +
765000000000                MSG( +
765100000000'Felder mit nicht darstellbaren Zeichen wurden ausgeblendet.'         +
765200000000                ) +
765300000000                SEV(0) +
765400000000     /*   No replacement variables defined!                         */ +
765500000000                ALROPT(*NO) +
765600000000                CCSID(65535) +
765700000000                /*  -EOF-  */
765800000000
765900000000     /*-------------------------------------------------------------*/
766000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8165                    */
766100000000     /* "WIEDERHOLEN" kann erst gedrückt werden, wenn auf dieser Se */
766200000000     /*-------------------------------------------------------------*/
766300000000
766400000000             RMVMSGD MSGID(USR8165) MSGF(&LIB/&OBJ)
766500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
766600000000
766700000000             ADDMSGD +
766800000000                MSGID(USR8165) +
766900000000                MSGF(&LIB/&OBJ) +
767000000000                MSG( +
767100000000'"WIEDERHOLEN" kann erst gedrückt werden, wenn auf dieser Seite eine A-
767200000000uswahl eingegeben wurde.'                                             +
767300000000                ) +
767400000000                SECLVL( +
767500000000'Ursache . . . . . : F13 (Wiederholen) wurde gedrückt, es wurde jedoch-
767600000000 auf dieser Seite keine Funktion zur Wiederholung ausgewählt. &N Fehle-
767700000000rbeseitigung : Eine Auswahl in die Auswahlspalte auf dieser Seite eing-
767800000000eben und "WIEDERHOLEN" ernaut auslösen.'                              +
767900000000                ) +
768000000000                SEV(0) +
768100000000     /*   No replacement variables defined!                         */ +
768200000000                ALROPT(*NO) +
768300000000                CCSID(65535) +
768400000000                /*  -EOF-  */
768500000000
768600000000     /*-------------------------------------------------------------*/
768700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8166                    */
768800000000     /* Funktion nicht möglich. Keine Datei geöffnet!               */
768900000000     /*-------------------------------------------------------------*/
769000000000
769100000000             RMVMSGD MSGID(USR8166) MSGF(&LIB/&OBJ)
769200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
769300000000
769400000000             ADDMSGD +
769500000000                MSGID(USR8166) +
769600000000                MSGF(&LIB/&OBJ) +
769700000000                MSG( +
769800000000'Funktion nicht möglich. Keine Datei geöffnet!'                       +
769900000000                ) +
770000000000                SEV(0) +
770100000000     /*   No replacement variables defined!                         */ +
770200000000                ALROPT(*NO) +
770300000000                CCSID(65535) +
770400000000                /*  -EOF-  */
770500000000
770600000000     /*-------------------------------------------------------------*/
770700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8167                    */
770800000000     /* Identische Folgenummern nicht zulässig.                     */
770900000000     /*-------------------------------------------------------------*/
771000000000
771100000000             RMVMSGD MSGID(USR8167) MSGF(&LIB/&OBJ)
771200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
771300000000
771400000000             ADDMSGD +
771500000000                MSGID(USR8167) +
771600000000                MSGF(&LIB/&OBJ) +
771700000000                MSG( +
771800000000'Identische Folgenummern nicht zulässig.'                             +
771900000000                ) +
772000000000                SEV(0) +
772100000000     /*   No replacement variables defined!                         */ +
772200000000                ALROPT(*NO) +
772300000000                CCSID(65535) +
772400000000                /*  -EOF-  */
772500000000
772600000000     /*-------------------------------------------------------------*/
772700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8168                    */
772800000000     /* Wert &1 für Attribut "Sichtbar/Unsichtbar" nicht zulässig.  */
772900000000     /*-------------------------------------------------------------*/
773000000000
773100000000             RMVMSGD MSGID(USR8168) MSGF(&LIB/&OBJ)
773200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
773300000000
773400000000             ADDMSGD +
773500000000                MSGID(USR8168) +
773600000000                MSGF(&LIB/&OBJ) +
773700000000                MSG( +
773800000000'Wert &1 für Attribut "Sichtbar/Unsichtbar" nicht zulässig.'          +
773900000000                ) +
774000000000                SEV(0) +
774100000000                FMT( +
774200000000                    (*CHAR 10) +
774300000000                ) +
774400000000                ALROPT(*NO) +
774500000000                CCSID(65535) +
774600000000                /*  -EOF-  */
774700000000
774800000000     /*-------------------------------------------------------------*/
774900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8169                    */
775000000000     /* Wert &1 für Attribut "Spaltenmarkierung" nicht zulässig.    */
775100000000     /*-------------------------------------------------------------*/
775200000000
775300000000             RMVMSGD MSGID(USR8169) MSGF(&LIB/&OBJ)
775400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
775500000000
775600000000             ADDMSGD +
775700000000                MSGID(USR8169) +
775800000000                MSGF(&LIB/&OBJ) +
775900000000                MSG( +
776000000000'Wert &1 für Attribut "Spaltenmarkierung" nicht zulässig.'            +
776100000000                ) +
776200000000                SEV(0) +
776300000000                FMT( +
776400000000                    (*CHAR 10) +
776500000000                ) +
776600000000                ALROPT(*NO) +
776700000000                CCSID(65535) +
776800000000                /*  -EOF-  */
776900000000
777000000000     /*-------------------------------------------------------------*/
777100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8170                    */
777200000000     /* Wert &1 für Attribut "Max. Größe" nicht zulässig.           */
777300000000     /*-------------------------------------------------------------*/
777400000000
777500000000             RMVMSGD MSGID(USR8170) MSGF(&LIB/&OBJ)
777600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
777700000000
777800000000             ADDMSGD +
777900000000                MSGID(USR8170) +
778000000000                MSGF(&LIB/&OBJ) +
778100000000                MSG( +
778200000000'Wert &1 für Attribut "Max. Größe" nicht zulässig.'                   +
778300000000                ) +
778400000000                SEV(0) +
778500000000                FMT( +
778600000000                    (*DEC 10 0) +
778700000000                ) +
778800000000                ALROPT(*NO) +
778900000000                CCSID(65535) +
779000000000                /*  -EOF-  */
779100000000
779200000000     /*-------------------------------------------------------------*/
779300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8171                    */
779400000000     /* Ungültiger Wert '&1' für Zeit-, Datum- oder Zeitmarkenfeld  */
779500000000     /*-------------------------------------------------------------*/
779600000000
779700000000             RMVMSGD MSGID(USR8171) MSGF(&LIB/&OBJ)
779800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
779900000000
780000000000             ADDMSGD +
780100000000                MSGID(USR8171) +
780200000000                MSGF(&LIB/&OBJ) +
780300000000                MSG( +
780400000000'Ungültiger Wert ''&1'' für Zeit-, Datum- oder Zeitmarkenfeld'        +
780500000000                ) +
780600000000                SEV(0) +
780700000000                FMT( +
780800000000                    (*CHAR 26) +
780900000000                ) +
781000000000                ALROPT(*NO) +
781100000000                CCSID(65535) +
781200000000                /*  -EOF-  */
781300000000
781400000000     /*-------------------------------------------------------------*/
781500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8172                    */
781600000000     /* Bearbeite: &1                                               */
781700000000     /*-------------------------------------------------------------*/
781800000000
781900000000             RMVMSGD MSGID(USR8172) MSGF(&LIB/&OBJ)
782000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
782100000000
782200000000             ADDMSGD +
782300000000                MSGID(USR8172) +
782400000000                MSGF(&LIB/&OBJ) +
782500000000                MSG( +
782600000000'Bearbeite: &1'                                                       +
782700000000                ) +
782800000000                SEV(0) +
782900000000                FMT( +
783000000000                    (*CHAR 50) +
783100000000                ) +
783200000000                ALROPT(*NO) +
783300000000                CCSID(65535) +
783400000000                /*  -EOF-  */
783500000000
783600000000     /*-------------------------------------------------------------*/
783700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8173                    */
783800000000     /* Peek/400 kann nicht rekursiv aufgerufen werden.             */
783900000000     /*-------------------------------------------------------------*/
784000000000
784100000000             RMVMSGD MSGID(USR8173) MSGF(&LIB/&OBJ)
784200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
784300000000
784400000000             ADDMSGD +
784500000000                MSGID(USR8173) +
784600000000                MSGF(&LIB/&OBJ) +
784700000000                MSG( +
784800000000'Peek/400 kann nicht rekursiv aufgerufen werden.'                     +
784900000000                ) +
785000000000                SEV(0) +
785100000000     /*   No replacement variables defined!                         */ +
785200000000                ALROPT(*NO) +
785300000000                CCSID(65535) +
785400000000                /*  -EOF-  */
785500000000
785600000000     /*-------------------------------------------------------------*/
785700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8174                    */
785800000000     /* Unzulässige Zeichen (&1) im Hex-String.                     */
785900000000     /*-------------------------------------------------------------*/
786000000000
786100000000             RMVMSGD MSGID(USR8174) MSGF(&LIB/&OBJ)
786200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
786300000000
786400000000             ADDMSGD +
786500000000                MSGID(USR8174) +
786600000000                MSGF(&LIB/&OBJ) +
786700000000                MSG( +
786800000000'Unzulässige Zeichen (&1) im Hex-String.'                             +
786900000000                ) +
787000000000                SEV(0) +
787100000000                FMT( +
787200000000                    (*CHAR 1) +
787300000000                ) +
787400000000                ALROPT(*NO) +
787500000000                CCSID(65535) +
787600000000                /*  -EOF-  */
787700000000
787800000000     /*-------------------------------------------------------------*/
787900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8175                    */
788000000000     /* Ungerade Anzahl Zeichen nicht zulässig.                     */
788100000000     /*-------------------------------------------------------------*/
788200000000
788300000000             RMVMSGD MSGID(USR8175) MSGF(&LIB/&OBJ)
788400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
788500000000
788600000000             ADDMSGD +
788700000000                MSGID(USR8175) +
788800000000                MSGF(&LIB/&OBJ) +
788900000000                MSG( +
789000000000'Ungerade Anzahl Zeichen nicht zulässig.'                             +
789100000000                ) +
789200000000                SEV(0) +
789300000000                FMT( +
789400000000                    (*CHAR 1) +
789500000000                ) +
789600000000                ALROPT(*NO) +
789700000000                CCSID(65535) +
789800000000                /*  -EOF-  */
789900000000
790000000000     /*-------------------------------------------------------------*/
790100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8176                    */
790200000000     /* Warnung: Zeichenkette zu lang.                              */
790300000000     /*-------------------------------------------------------------*/
790400000000
790500000000             RMVMSGD MSGID(USR8176) MSGF(&LIB/&OBJ)
790600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
790700000000
790800000000             ADDMSGD +
790900000000                MSGID(USR8176) +
791000000000                MSGF(&LIB/&OBJ) +
791100000000                MSG( +
791200000000'Warnung: Zeichenkette zu lang.'                                      +
791300000000                ) +
791400000000                SEV(0) +
791500000000                FMT( +
791600000000                    (*CHAR 1) +
791700000000                ) +
791800000000                ALROPT(*NO) +
791900000000                CCSID(65535) +
792000000000                /*  -EOF-  */
792100000000
792200000000     /*-------------------------------------------------------------*/
792300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8177                    */
792400000000     /* Startposition darf nicht größer als Feldlänge sein.         */
792500000000     /*-------------------------------------------------------------*/
792600000000
792700000000             RMVMSGD MSGID(USR8177) MSGF(&LIB/&OBJ)
792800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
792900000000
793000000000             ADDMSGD +
793100000000                MSGID(USR8177) +
793200000000                MSGF(&LIB/&OBJ) +
793300000000                MSG( +
793400000000'Startposition darf nicht größer als Feldlänge sein.'                 +
793500000000                ) +
793600000000                SEV(0) +
793700000000                FMT( +
793800000000                    (*CHAR 1) +
793900000000                ) +
794000000000                ALROPT(*NO) +
794100000000                CCSID(65535) +
794200000000                /*  -EOF-  */
794300000000
794400000000     /*-------------------------------------------------------------*/
794500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8178                    */
794600000000     /* Startposition darf nicht kleiner/gleich Null sein.          */
794700000000     /*-------------------------------------------------------------*/
794800000000
794900000000             RMVMSGD MSGID(USR8178) MSGF(&LIB/&OBJ)
795000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
795100000000
795200000000             ADDMSGD +
795300000000                MSGID(USR8178) +
795400000000                MSGF(&LIB/&OBJ) +
795500000000                MSG( +
795600000000'Startposition darf nicht kleiner/gleich Null sein.'                  +
795700000000                ) +
795800000000                SEV(0) +
795900000000     /*   No replacement variables defined!                         */ +
796000000000                ALROPT(*NO) +
796100000000                CCSID(65535) +
796200000000                /*  -EOF-  */
796300000000
796400000000     /*-------------------------------------------------------------*/
796500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8179                    */
796600000000     /* Keine Bedienerführung verfügbar.                            */
796700000000     /*-------------------------------------------------------------*/
796800000000
796900000000             RMVMSGD MSGID(USR8179) MSGF(&LIB/&OBJ)
797000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
797100000000
797200000000             ADDMSGD +
797300000000                MSGID(USR8179) +
797400000000                MSGF(&LIB/&OBJ) +
797500000000                MSG( +
797600000000'Keine Bedienerführung verfügbar.'                                    +
797700000000                ) +
797800000000                SEV(0) +
797900000000     /*   No replacement variables defined!                         */ +
798000000000                ALROPT(*NO) +
798100000000                CCSID(65535) +
798200000000                /*  -EOF-  */
798300000000
798400000000     /*-------------------------------------------------------------*/
798500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8180                    */
798600000000     /* Teildatei '&1' nicht gefunden.                              */
798700000000     /*-------------------------------------------------------------*/
798800000000
798900000000             RMVMSGD MSGID(USR8180) MSGF(&LIB/&OBJ)
799000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
799100000000
799200000000             ADDMSGD +
799300000000                MSGID(USR8180) +
799400000000                MSGF(&LIB/&OBJ) +
799500000000                MSG( +
799600000000'Teildatei ''&1'' nicht gefunden.'                                    +
799700000000                ) +
799800000000                SEV(0) +
799900000000                FMT( +
800000000000                    (*CHAR 10) +
800100000000                ) +
800200000000                ALROPT(*NO) +
800300000000                CCSID(65535) +
800400000000                /*  -EOF-  */
800500000000
800600000000     /*-------------------------------------------------------------*/
800700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8181                    */
800800000000     /* Keine Datei zur Speicherung der Arbeitsumgebung angegeben.  */
800900000000     /*-------------------------------------------------------------*/
801000000000
801100000000             RMVMSGD MSGID(USR8181) MSGF(&LIB/&OBJ)
801200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
801300000000
801400000000             ADDMSGD +
801500000000                MSGID(USR8181) +
801600000000                MSGF(&LIB/&OBJ) +
801700000000                MSG( +
801800000000'Keine Datei zur Speicherung der Arbeitsumgebung angegeben.'          +
801900000000                ) +
802000000000                SEV(0) +
802100000000     /*   No replacement variables defined!                         */ +
802200000000                ALROPT(*NO) +
802300000000                CCSID(65535) +
802400000000                /*  -EOF-  */
802500000000
802600000000     /*-------------------------------------------------------------*/
802700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8182                    */
802800000000     /* Wert &1 als Name für ein AS/400 Objekt ungültig.            */
802900000000     /*-------------------------------------------------------------*/
803000000000
803100000000             RMVMSGD MSGID(USR8182) MSGF(&LIB/&OBJ)
803200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
803300000000
803400000000             ADDMSGD +
803500000000                MSGID(USR8182) +
803600000000                MSGF(&LIB/&OBJ) +
803700000000                MSG( +
803800000000'Wert &1 als Name für ein AS/400 Objekt ungültig.'                    +
803900000000                ) +
804000000000                SEV(0) +
804100000000                FMT( +
804200000000                    (*CHAR 10) +
804300000000                ) +
804400000000                ALROPT(*NO) +
804500000000                CCSID(65535) +
804600000000                /*  -EOF-  */
804700000000
804800000000     /*-------------------------------------------------------------*/
804900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8183                    */
805000000000     /* Unvollständige Auswahl.                                     */
805100000000     /*-------------------------------------------------------------*/
805200000000
805300000000             RMVMSGD MSGID(USR8183) MSGF(&LIB/&OBJ)
805400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
805500000000
805600000000             ADDMSGD +
805700000000                MSGID(USR8183) +
805800000000                MSGF(&LIB/&OBJ) +
805900000000                MSG( +
806000000000'Unvollständige Auswahl.'                                             +
806100000000                ) +
806200000000                SEV(0) +
806300000000     /*   No replacement variables defined!                         */ +
806400000000                ALROPT(*NO) +
806500000000                CCSID(65535) +
806600000000                /*  -EOF-  */
806700000000
806800000000     /*-------------------------------------------------------------*/
806900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8184                    */
807000000000     /* Diese Funktion ist nicht freigeschaltet. Bitte wenden Sie s */
807100000000     /*-------------------------------------------------------------*/
807200000000
807300000000             RMVMSGD MSGID(USR8184) MSGF(&LIB/&OBJ)
807400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
807500000000
807600000000             ADDMSGD +
807700000000                MSGID(USR8184) +
807800000000                MSGF(&LIB/&OBJ) +
807900000000                MSG( +
808000000000'Diese Funktion ist nicht freigeschaltet. Bitte wenden Sie sich an Ihr-
808100000000en Administrator.'                                                    +
808200000000                ) +
808300000000                SEV(0) +
808400000000     /*   No replacement variables defined!                         */ +
808500000000                ALROPT(*NO) +
808600000000                CCSID(65535) +
808700000000                /*  -EOF-  */
808800000000
808900000000     /*-------------------------------------------------------------*/
809000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8185                    */
809100000000     /* Keine Arbeitsumgebung angegeben. Arbeitsumgebung nicht geöf */
809200000000     /*-------------------------------------------------------------*/
809300000000
809400000000             RMVMSGD MSGID(USR8185) MSGF(&LIB/&OBJ)
809500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
809600000000
809700000000             ADDMSGD +
809800000000                MSGID(USR8185) +
809900000000                MSGF(&LIB/&OBJ) +
810000000000                MSG( +
810100000000'Keine Arbeitsumgebung angegeben. Arbeitsumgebung nicht geöffnet.'    +
810200000000                ) +
810300000000                SEV(0) +
810400000000     /*   No replacement variables defined!                         */ +
810500000000                ALROPT(*NO) +
810600000000                CCSID(65535) +
810700000000                /*  -EOF-  */
810800000000
810900000000     /*-------------------------------------------------------------*/
811000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8186                    */
811100000000     /* Warnung: Zeichenkette zu kurz.                              */
811200000000     /*-------------------------------------------------------------*/
811300000000
811400000000             RMVMSGD MSGID(USR8186) MSGF(&LIB/&OBJ)
811500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
811600000000
811700000000             ADDMSGD +
811800000000                MSGID(USR8186) +
811900000000                MSGF(&LIB/&OBJ) +
812000000000                MSG( +
812100000000'Warnung: Zeichenkette zu kurz.'                                      +
812200000000                ) +
812300000000                SEV(0) +
812400000000     /*   No replacement variables defined!                         */ +
812500000000                ALROPT(*NO) +
812600000000                CCSID(65535) +
812700000000                /*  -EOF-  */
812800000000
812900000000     /*-------------------------------------------------------------*/
813000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8187                    */
813100000000     /* Feldlänge ist größer als Dateipuffer.                       */
813200000000     /*-------------------------------------------------------------*/
813300000000
813400000000             RMVMSGD MSGID(USR8187) MSGF(&LIB/&OBJ)
813500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
813600000000
813700000000             ADDMSGD +
813800000000                MSGID(USR8187) +
813900000000                MSGF(&LIB/&OBJ) +
814000000000                MSG( +
814100000000'Feldlänge ist größer als Dateipuffer.'                               +
814200000000                ) +
814300000000                SEV(0) +
814400000000     /*   No replacement variables defined!                         */ +
814500000000                ALROPT(*NO) +
814600000000                CCSID(65535) +
814700000000                /*  -EOF-  */
814800000000
814900000000     /*-------------------------------------------------------------*/
815000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8188                    */
815100000000     /* Generieren Bildschirmdatei. Lauf: &1, Feld: &2              */
815200000000     /*-------------------------------------------------------------*/
815300000000
815400000000             RMVMSGD MSGID(USR8188) MSGF(&LIB/&OBJ)
815500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
815600000000
815700000000             ADDMSGD +
815800000000                MSGID(USR8188) +
815900000000                MSGF(&LIB/&OBJ) +
816000000000                MSG( +
816100000000'Generieren Bildschirmdatei. Lauf: &1, Feld: &2'                      +
816200000000                ) +
816300000000                SEV(0) +
816400000000                FMT( +
816500000000                    (*DEC 5 0) +
816600000000                    (*CHAR 10) +
816700000000                ) +
816800000000                ALROPT(*NO) +
816900000000                CCSID(65535) +
817000000000                /*  -EOF-  */
817100000000
817200000000     /*-------------------------------------------------------------*/
817300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8189                    */
817400000000     /* Generieren RPG-Programm. Lauf: &1, Feld: &2                 */
817500000000     /*-------------------------------------------------------------*/
817600000000
817700000000             RMVMSGD MSGID(USR8189) MSGF(&LIB/&OBJ)
817800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
817900000000
818000000000             ADDMSGD +
818100000000                MSGID(USR8189) +
818200000000                MSGF(&LIB/&OBJ) +
818300000000                MSG( +
818400000000'Generieren RPG-Programm. Lauf: &1, Feld: &2'                         +
818500000000                ) +
818600000000                SEV(0) +
818700000000                FMT( +
818800000000                    (*DEC 5 0) +
818900000000                    (*CHAR 10) +
819000000000                ) +
819100000000                ALROPT(*NO) +
819200000000                CCSID(65535) +
819300000000                /*  -EOF-  */
819400000000
819500000000     /*-------------------------------------------------------------*/
819600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8190                    */
819700000000     /* Verarbeitung beendet mit &1.                                */
819800000000     /*-------------------------------------------------------------*/
819900000000
820000000000             RMVMSGD MSGID(USR8190) MSGF(&LIB/&OBJ)
820100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
820200000000
820300000000             ADDMSGD +
820400000000                MSGID(USR8190) +
820500000000                MSGF(&LIB/&OBJ) +
820600000000                MSG( +
820700000000'Verarbeitung beendet mit &1.'                                        +
820800000000                ) +
820900000000                SEV(0) +
821000000000                FMT( +
821100000000                    (*CHAR 10) +
821200000000                ) +
821300000000                ALROPT(*NO) +
821400000000                CCSID(65535) +
821500000000                /*  -EOF-  */
821600000000
821700000000     /*-------------------------------------------------------------*/
821800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8191                    */
821900000000     /* Feld &1 ist nicht NULL-fähig.                               */
822000000000     /*-------------------------------------------------------------*/
822100000000
822200000000             RMVMSGD MSGID(USR8191) MSGF(&LIB/&OBJ)
822300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
822400000000
822500000000             ADDMSGD +
822600000000                MSGID(USR8191) +
822700000000                MSGF(&LIB/&OBJ) +
822800000000                MSG( +
822900000000'Feld &1 ist nicht NULL-fähig.'                                       +
823000000000                ) +
823100000000                SEV(0) +
823200000000                FMT( +
823300000000                    (*CHAR 10) +
823400000000                ) +
823500000000                ALROPT(*NO) +
823600000000                CCSID(65535) +
823700000000                /*  -EOF-  */
823800000000
823900000000     /*-------------------------------------------------------------*/
824000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8192                    */
824100000000     /* Ungültigen Float Wert in &1 gefunden.                       */
824200000000     /*-------------------------------------------------------------*/
824300000000
824400000000             RMVMSGD MSGID(USR8192) MSGF(&LIB/&OBJ)
824500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
824600000000
824700000000             ADDMSGD +
824800000000                MSGID(USR8192) +
824900000000                MSGF(&LIB/&OBJ) +
825000000000                MSG( +
825100000000'Ungültigen Float Wert in &1 gefunden.'                               +
825200000000                ) +
825300000000                SEV(0) +
825400000000                FMT( +
825500000000                    (*CHAR 10) +
825600000000                ) +
825700000000                ALROPT(*NO) +
825800000000                CCSID(65535) +
825900000000                /*  -EOF-  */
826000000000
826100000000     /*-------------------------------------------------------------*/
826200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8193                    */
826300000000     /* Felder '&1' enthält nicht darstellbaren Zeichen und kann da */
826400000000     /*-------------------------------------------------------------*/
826500000000
826600000000             RMVMSGD MSGID(USR8193) MSGF(&LIB/&OBJ)
826700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
826800000000
826900000000             ADDMSGD +
827000000000                MSGID(USR8193) +
827100000000                MSGF(&LIB/&OBJ) +
827200000000                MSG( +
827300000000'Felder ''&1'' enthält nicht darstellbaren Zeichen und kann daher nich-
827400000000t mit dem Texteditor bearbeitet werden.'                              +
827500000000                ) +
827600000000                SEV(0) +
827700000000                FMT( +
827800000000                    (*CHAR 10) +
827900000000                ) +
828000000000                ALROPT(*NO) +
828100000000                CCSID(65535) +
828200000000                /*  -EOF-  */
828300000000
828400000000     /*-------------------------------------------------------------*/
828500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8194                    */
828600000000     /* Datei '&1' nicht gefunden.                                  */
828700000000     /*-------------------------------------------------------------*/
828800000000
828900000000             RMVMSGD MSGID(USR8194) MSGF(&LIB/&OBJ)
829000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
829100000000
829200000000             ADDMSGD +
829300000000                MSGID(USR8194) +
829400000000                MSGF(&LIB/&OBJ) +
829500000000                MSG( +
829600000000'Datei ''&1'' nicht gefunden.'                                        +
829700000000                ) +
829800000000                SEV(0) +
829900000000                FMT( +
830000000000                    (*CHAR 10) +
830100000000                ) +
830200000000                ALROPT(*NO) +
830300000000                CCSID(65535) +
830400000000                /*  -EOF-  */
830500000000
830600000000     /*-------------------------------------------------------------*/
830700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8195                    */
830800000000     /* Unzulässige Anforderung. Feld ist für Änderungen gesperrt.  */
830900000000     /*-------------------------------------------------------------*/
831000000000
831100000000             RMVMSGD MSGID(USR8195) MSGF(&LIB/&OBJ)
831200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
831300000000
831400000000             ADDMSGD +
831500000000                MSGID(USR8195) +
831600000000                MSGF(&LIB/&OBJ) +
831700000000                MSG( +
831800000000'Unzulässige Anforderung. Feld ist für Änderungen gesperrt.'          +
831900000000                ) +
832000000000                SEV(0) +
832100000000     /*   No replacement variables defined!                         */ +
832200000000                ALROPT(*NO) +
832300000000                CCSID(65535) +
832400000000                /*  -EOF-  */
832500000000
832600000000     /*-------------------------------------------------------------*/
832700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8196                    */
832800000000     /* Feld &1 kann nicht angezeigt und geändert werden.           */
832900000000     /*-------------------------------------------------------------*/
833000000000
833100000000             RMVMSGD MSGID(USR8196) MSGF(&LIB/&OBJ)
833200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
833300000000
833400000000             ADDMSGD +
833500000000                MSGID(USR8196) +
833600000000                MSGF(&LIB/&OBJ) +
833700000000                MSG( +
833800000000'Feld &1 kann nicht angezeigt und geändert werden.'                   +
833900000000                ) +
834000000000                SECLVL( +
834100000000'&N &N Mögliche Ursachen: &N &B 1. Unbekannter Datentyp. &B 2. Datenty-
834200000000p Graphic ohne CCSID. &B 3. Datentyp Packed oder Zoned mit mehr als 30-
834300000000 Stellen. &B 4. Feld variabler Länge mit unbekanntem Datentyp.'       +
834400000000                ) +
834500000000                SEV(0) +
834600000000                FMT( +
834700000000                    (*CHAR 10) +
834800000000                ) +
834900000000                ALROPT(*NO) +
835000000000                CCSID(65535) +
835100000000                /*  -EOF-  */
835200000000
835300000000     /*-------------------------------------------------------------*/
835400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8200                    */
835500000000     /* Datensatz &1 konnte nicht gelöscht werden.                  */
835600000000     /*-------------------------------------------------------------*/
835700000000
835800000000             RMVMSGD MSGID(USR8200) MSGF(&LIB/&OBJ)
835900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
836000000000
836100000000             ADDMSGD +
836200000000                MSGID(USR8200) +
836300000000                MSGF(&LIB/&OBJ) +
836400000000                MSG( +
836500000000'Datensatz &1 konnte nicht gelöscht werden.'                          +
836600000000                ) +
836700000000                SEV(0) +
836800000000                FMT( +
836900000000                    (*DEC 10 0) +
837000000000                ) +
837100000000                ALROPT(*NO) +
837200000000                CCSID(65535) +
837300000000                /*  -EOF-  */
837400000000
837500000000     /*-------------------------------------------------------------*/
837600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8201                    */
837700000000     /* Datensatz &1 wurde gelöscht.                                */
837800000000     /*-------------------------------------------------------------*/
837900000000
838000000000             RMVMSGD MSGID(USR8201) MSGF(&LIB/&OBJ)
838100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
838200000000
838300000000             ADDMSGD +
838400000000                MSGID(USR8201) +
838500000000                MSGF(&LIB/&OBJ) +
838600000000                MSG( +
838700000000'Datensatz &1 wurde gelöscht.'                                        +
838800000000                ) +
838900000000                SEV(0) +
839000000000                FMT( +
839100000000                    (*DEC 10 0) +
839200000000                ) +
839300000000                ALROPT(*NO) +
839400000000                CCSID(65535) +
839500000000                /*  -EOF-  */
839600000000
839700000000     /*-------------------------------------------------------------*/
839800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8202                    */
839900000000     /* Datensatz &1 konnte nicht kopiert werden.                   */
840000000000     /*-------------------------------------------------------------*/
840100000000
840200000000             RMVMSGD MSGID(USR8202) MSGF(&LIB/&OBJ)
840300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
840400000000
840500000000             ADDMSGD +
840600000000                MSGID(USR8202) +
840700000000                MSGF(&LIB/&OBJ) +
840800000000                MSG( +
840900000000'Datensatz &1 konnte nicht kopiert werden.'                           +
841000000000                ) +
841100000000                SEV(0) +
841200000000                FMT( +
841300000000                    (*DEC 10 0) +
841400000000                ) +
841500000000                ALROPT(*NO) +
841600000000                CCSID(65535) +
841700000000                /*  -EOF-  */
841800000000
841900000000     /*-------------------------------------------------------------*/
842000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8203                    */
842100000000     /* Datensatz &1 wurde kopiert.                                 */
842200000000     /*-------------------------------------------------------------*/
842300000000
842400000000             RMVMSGD MSGID(USR8203) MSGF(&LIB/&OBJ)
842500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
842600000000
842700000000             ADDMSGD +
842800000000                MSGID(USR8203) +
842900000000                MSGF(&LIB/&OBJ) +
843000000000                MSG( +
843100000000'Datensatz &1 wurde kopiert.'                                         +
843200000000                ) +
843300000000                SEV(0) +
843400000000                FMT( +
843500000000                    (*DEC 10 0) +
843600000000                ) +
843700000000                ALROPT(*NO) +
843800000000                CCSID(65535) +
843900000000                /*  -EOF-  */
844000000000
844100000000     /*-------------------------------------------------------------*/
844200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8204                    */
844300000000     /* Keine gültige Satzauswahl getroffen.                        */
844400000000     /*-------------------------------------------------------------*/
844500000000
844600000000             RMVMSGD MSGID(USR8204) MSGF(&LIB/&OBJ)
844700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
844800000000
844900000000             ADDMSGD +
845000000000                MSGID(USR8204) +
845100000000                MSGF(&LIB/&OBJ) +
845200000000                MSG( +
845300000000'Keine gültige Satzauswahl getroffen.'                                +
845400000000                ) +
845500000000                SECLVL( +
845600000000'&N &N Zeigen Sie mit dem Cursor auf einen Datensatz der Subfile und w-
845700000000iederholen Sie die Anforderung.'                                      +
845800000000                ) +
845900000000                SEV(0) +
846000000000     /*   No replacement variables defined!                         */ +
846100000000                ALROPT(*NO) +
846200000000                CCSID(65535) +
846300000000                /*  -EOF-  */
846400000000
846500000000     /*-------------------------------------------------------------*/
846600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8205                    */
846700000000     /* Warnung: Es können nicht mehr als &1 Spalten gepinnt werden */
846800000000     /*-------------------------------------------------------------*/
846900000000
847000000000             RMVMSGD MSGID(USR8205) MSGF(&LIB/&OBJ)
847100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
847200000000
847300000000             ADDMSGD +
847400000000                MSGID(USR8205) +
847500000000                MSGF(&LIB/&OBJ) +
847600000000                MSG( +
847700000000'Warnung: Es können nicht mehr als &1 Spalten gepinnt werden!'        +
847800000000                ) +
847900000000                SEV(0) +
848000000000                FMT( +
848100000000                    (*DEC 5 0) +
848200000000                ) +
848300000000                ALROPT(*NO) +
848400000000                CCSID(65535) +
848500000000                /*  -EOF-  */
848600000000
848700000000     /*-------------------------------------------------------------*/
848800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8206                    */
848900000000     /* Anzeige nicht möglich. Die Satzlänge ist größer als &1 Zeic */
849000000000     /*-------------------------------------------------------------*/
849100000000
849200000000             RMVMSGD MSGID(USR8206) MSGF(&LIB/&OBJ)
849300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
849400000000
849500000000             ADDMSGD +
849600000000                MSGID(USR8206) +
849700000000                MSGF(&LIB/&OBJ) +
849800000000                MSG( +
849900000000'Anzeige nicht möglich. Die Satzlänge ist größer als &1 Zeichen.'     +
850000000000                ) +
850100000000                SEV(0) +
850200000000                FMT( +
850300000000                    (*DEC 5 0) +
850400000000                ) +
850500000000                ALROPT(*NO) +
850600000000                CCSID(65535) +
850700000000                /*  -EOF-  */
850800000000
850900000000     /*-------------------------------------------------------------*/
851000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8207                    */
851100000000     /* Datei konnte nicht geöffnet werden. Die Satzlänge ist größe */
851200000000     /*-------------------------------------------------------------*/
851300000000
851400000000             RMVMSGD MSGID(USR8207) MSGF(&LIB/&OBJ)
851500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
851600000000
851700000000             ADDMSGD +
851800000000                MSGID(USR8207) +
851900000000                MSGF(&LIB/&OBJ) +
852000000000                MSG( +
852100000000'Datei konnte nicht geöffnet werden. Die Satzlänge ist größer als &1 Z-
852200000000eichen.'                                                              +
852300000000                ) +
852400000000                SEV(0) +
852500000000                FMT( +
852600000000                    (*DEC 5 0) +
852700000000                ) +
852800000000                ALROPT(*NO) +
852900000000                CCSID(65535) +
853000000000                /*  -EOF-  */
853100000000
853200000000     /*-------------------------------------------------------------*/
853300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8208                    */
853400000000     /* Nur INPUT-Felder können nicht geändert werden.              */
853500000000     /*-------------------------------------------------------------*/
853600000000
853700000000             RMVMSGD MSGID(USR8208) MSGF(&LIB/&OBJ)
853800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
853900000000
854000000000             ADDMSGD +
854100000000                MSGID(USR8208) +
854200000000                MSGF(&LIB/&OBJ) +
854300000000                MSG( +
854400000000'Nur INPUT-Felder können nicht geändert werden.'                      +
854500000000                ) +
854600000000                SEV(0) +
854700000000     /*   No replacement variables defined!                         */ +
854800000000                ALROPT(*NO) +
854900000000                CCSID(65535) +
855000000000                /*  -EOF-  */
855100000000
855200000000     /*-------------------------------------------------------------*/
855300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8209                    */
855400000000     /* Bitte geben Sie in Suchargument ein.                        */
855500000000     /*-------------------------------------------------------------*/
855600000000
855700000000             RMVMSGD MSGID(USR8209) MSGF(&LIB/&OBJ)
855800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
855900000000
856000000000             ADDMSGD +
856100000000                MSGID(USR8209) +
856200000000                MSGF(&LIB/&OBJ) +
856300000000                MSG( +
856400000000'Bitte geben Sie in Suchargument ein.'                                +
856500000000                ) +
856600000000                SEV(0) +
856700000000     /*   No replacement variables defined!                         */ +
856800000000                ALROPT(*NO) +
856900000000                CCSID(65535) +
857000000000                /*  -EOF-  */
857100000000
857200000000     /*-------------------------------------------------------------*/
857300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8210                    */
857400000000     /* SQL-Fehler &1 aufgetreten. &2                               */
857500000000     /*-------------------------------------------------------------*/
857600000000
857700000000             RMVMSGD MSGID(USR8210) MSGF(&LIB/&OBJ)
857800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
857900000000
858000000000             ADDMSGD +
858100000000                MSGID(USR8210) +
858200000000                MSGF(&LIB/&OBJ) +
858300000000                MSG( +
858400000000'SQL-Fehler &1 aufgetreten. &2'                                       +
858500000000                ) +
858600000000                SECLVL( +
858700000000'&N &N Hinweis . . . . :   &2 &N &B Weitere Informationen enthält des -
858800000000SQL Programmierhandbuch oder die Nachrichtendatei QSYS/QSQLMSG.'      +
858900000000                ) +
859000000000                SEV(0) +
859100000000                FMT( +
859200000000                    (*CHAR 7) +
859300000000                    (*CHAR 512) +
859400000000                ) +
859500000000                ALROPT(*NO) +
859600000000                CCSID(65535) +
859700000000                /*  -EOF-  */
859800000000
859900000000     /*-------------------------------------------------------------*/
860000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8211                    */
860100000000     /* Bitte mit dem Cursor auf ein Feld zeigen und die Anforderun */
860200000000     /*-------------------------------------------------------------*/
860300000000
860400000000             RMVMSGD MSGID(USR8211) MSGF(&LIB/&OBJ)
860500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
860600000000
860700000000             ADDMSGD +
860800000000                MSGID(USR8211) +
860900000000                MSGF(&LIB/&OBJ) +
861000000000                MSG( +
861100000000'Bitte mit dem Cursor auf ein Feld zeigen und die Anforderung wiederho-
861200000000len.'                                                                 +
861300000000                ) +
861400000000                SECLVL( +
861500000000'Ursache . . . . :   Der Cursor steht nicht in einem Feld oder das Fel-
861600000000d ist für die Anforderung nicht zulässig.'                            +
861700000000                ) +
861800000000                SEV(0) +
861900000000     /*   No replacement variables defined!                         */ +
862000000000                ALROPT(*NO) +
862100000000                CCSID(65535) +
862200000000                /*  -EOF-  */
862300000000
862400000000     /*-------------------------------------------------------------*/
862500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8212                    */
862600000000     /* Die SQL-Auswahl kann nur auf physischen Dateien angewendet  */
862700000000     /*-------------------------------------------------------------*/
862800000000
862900000000             RMVMSGD MSGID(USR8212) MSGF(&LIB/&OBJ)
863000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
863100000000
863200000000             ADDMSGD +
863300000000                MSGID(USR8212) +
863400000000                MSGF(&LIB/&OBJ) +
863500000000                MSG( +
863600000000'Die SQL-Auswahl kann nur auf physischen Dateien angewendet werden. So-
863700000000ll die physische Datei geöffnet werden?'                              +
863800000000                ) +
863900000000                SEV(0) +
864000000000     /*   No replacement variables defined!                         */ +
864100000000                ALROPT(*NO) +
864200000000                CCSID(65535) +
864300000000                /*  -EOF-  */
864400000000
864500000000     /*-------------------------------------------------------------*/
864600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8213                    */
864700000000     /* 1=speichern; 0=nicht speichern                              */
864800000000     /*-------------------------------------------------------------*/
864900000000
865000000000             RMVMSGD MSGID(USR8213) MSGF(&LIB/&OBJ)
865100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
865200000000
865300000000             ADDMSGD +
865400000000                MSGID(USR8213) +
865500000000                MSGF(&LIB/&OBJ) +
865600000000                MSG( +
865700000000'1=speichern; 0=nicht speichern'                                      +
865800000000                ) +
865900000000                SEV(0) +
866000000000     /*   No replacement variables defined!                         */ +
866100000000                ALROPT(*NO) +
866200000000                CCSID(65535) +
866300000000                /*  -EOF-  */
866400000000
866500000000     /*-------------------------------------------------------------*/
866600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8214                    */
866700000000     /* 1=Kleinbuchstaben erlaubt; 0=nur Großbuchstaben             */
866800000000     /*-------------------------------------------------------------*/
866900000000
867000000000             RMVMSGD MSGID(USR8214) MSGF(&LIB/&OBJ)
867100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
867200000000
867300000000             ADDMSGD +
867400000000                MSGID(USR8214) +
867500000000                MSGF(&LIB/&OBJ) +
867600000000                MSG( +
867700000000'1=Kleinbuchstaben erlaubt; 0=nur Großbuchstaben'                     +
867800000000                ) +
867900000000                SEV(0) +
868000000000     /*   No replacement variables defined!                         */ +
868100000000                ALROPT(*NO) +
868200000000                CCSID(65535) +
868300000000                /*  -EOF-  */
868400000000
868500000000     /*-------------------------------------------------------------*/
868600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8215                    */
868700000000     /* Eingabe in Kleinbuchstaben nicht erlaubt.                   */
868800000000     /*-------------------------------------------------------------*/
868900000000
869000000000             RMVMSGD MSGID(USR8215) MSGF(&LIB/&OBJ)
869100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
869200000000
869300000000             ADDMSGD +
869400000000                MSGID(USR8215) +
869500000000                MSGF(&LIB/&OBJ) +
869600000000                MSG( +
869700000000'Eingabe in Kleinbuchstaben nicht erlaubt.'                           +
869800000000                ) +
869900000000                SEV(0) +
870000000000     /*   No replacement variables defined!                         */ +
870100000000                ALROPT(*NO) +
870200000000                CCSID(65535) +
870300000000                /*  -EOF-  */
870400000000
870500000000     /*-------------------------------------------------------------*/
870600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8216                    */
870700000000     /* Diese Eingabekombination ist nicht erlaubt.                 */
870800000000     /*-------------------------------------------------------------*/
870900000000
871000000000             RMVMSGD MSGID(USR8216) MSGF(&LIB/&OBJ)
871100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
871200000000
871300000000             ADDMSGD +
871400000000                MSGID(USR8216) +
871500000000                MSGF(&LIB/&OBJ) +
871600000000                MSG( +
871700000000'Diese Eingabekombination ist nicht erlaubt.'                         +
871800000000                ) +
871900000000                SECLVL( +
872000000000'Wenn die Eingabe von Kleinbuchstaben nicht erlaubt ist, dann kann die-
872100000000s auch nicht als Standardwert vorbesetzt werden.'                     +
872200000000                ) +
872300000000                SEV(0) +
872400000000     /*   No replacement variables defined!                         */ +
872500000000                ALROPT(*NO) +
872600000000                CCSID(65535) +
872700000000                /*  -EOF-  */
872800000000
872900000000     /*-------------------------------------------------------------*/
873000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8217                    */
873100000000     /* Sortierung nach relativer Satznummer nicht möglich.         */
873200000000     /*-------------------------------------------------------------*/
873300000000
873400000000             RMVMSGD MSGID(USR8217) MSGF(&LIB/&OBJ)
873500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
873600000000
873700000000             ADDMSGD +
873800000000                MSGID(USR8217) +
873900000000                MSGF(&LIB/&OBJ) +
874000000000                MSG( +
874100000000'Sortierung nach relativer Satznummer nicht möglich.'                 +
874200000000                ) +
874300000000                SECLVL( +
874400000000'Eine Sortierung nach relativer Satznummer ist nicht möglich, weil die-
874500000000 geöffnete Datei auf mehrenen Teildateien basiert.'                   +
874600000000                ) +
874700000000                SEV(0) +
874800000000     /*   No replacement variables defined!                         */ +
874900000000                ALROPT(*NO) +
875000000000                CCSID(65535) +
875100000000                /*  -EOF-  */
875200000000
875300000000     /*-------------------------------------------------------------*/
875400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8218                    */
875500000000     /* Datensatz kann nicht gepinnt werden, wenn die logische Date */
875600000000     /*-------------------------------------------------------------*/
875700000000
875800000000             RMVMSGD MSGID(USR8218) MSGF(&LIB/&OBJ)
875900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
876000000000
876100000000             ADDMSGD +
876200000000                MSGID(USR8218) +
876300000000                MSGF(&LIB/&OBJ) +
876400000000                MSG( +
876500000000'Datensatz kann nicht gepinnt werden, wenn die logische Datei auf mehr-
876600000000eren physischen Teildateien basiert.'                                 +
876700000000                ) +
876800000000                SECLVL( +
876900000000'&N &N Ursache . . . . :   Der Datensatz kann nicht gepinnt werden, we-
877000000000il die relative Satznummer nicht eindeutig ist und nicht ermittelt wer-
877100000000den kann, aus welcher physischen Teildatei der Satz kommt.'           +
877200000000                ) +
877300000000                SEV(0) +
877400000000     /*   No replacement variables defined!                         */ +
877500000000                ALROPT(*NO) +
877600000000                CCSID(65535) +
877700000000                /*  -EOF-  */
877800000000
877900000000     /*-------------------------------------------------------------*/
878000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8219                    */
878100000000     /* Wert '&1' für Auswahl Ja/Nein nicht zulässig.               */
878200000000     /*-------------------------------------------------------------*/
878300000000
878400000000             RMVMSGD MSGID(USR8219) MSGF(&LIB/&OBJ)
878500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
878600000000
878700000000             ADDMSGD +
878800000000                MSGID(USR8219) +
878900000000                MSGF(&LIB/&OBJ) +
879000000000                MSG( +
879100000000'Wert ''&1'' für Auswahl Ja/Nein nicht zulässig.'                     +
879200000000                ) +
879300000000                SEV(0) +
879400000000                FMT( +
879500000000                    (*CHAR 1) +
879600000000                ) +
879700000000                ALROPT(*NO) +
879800000000                CCSID(65535) +
879900000000                /*  -EOF-  */
880000000000
880100000000     /*-------------------------------------------------------------*/
880200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8220                    */
880300000000     /* Editor nicht zulässig. Feld &1 enthält NULL Wert.           */
880400000000     /*-------------------------------------------------------------*/
880500000000
880600000000             RMVMSGD MSGID(USR8220) MSGF(&LIB/&OBJ)
880700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
880800000000
880900000000             ADDMSGD +
881000000000                MSGID(USR8220) +
881100000000                MSGF(&LIB/&OBJ) +
881200000000                MSG( +
881300000000'Editor nicht zulässig. Feld &1 enthält NULL Wert.'                   +
881400000000                ) +
881500000000                SEV(0) +
881600000000                FMT( +
881700000000                    (*CHAR 10) +
881800000000                ) +
881900000000                ALROPT(*NO) +
882000000000                CCSID(65535) +
882100000000                /*  -EOF-  */
882200000000
882300000000     /*-------------------------------------------------------------*/
882400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8221                    */
882500000000     /* Editor nicht zulässig. Feld &1 hat ungültigen Datentyp.     */
882600000000     /*-------------------------------------------------------------*/
882700000000
882800000000             RMVMSGD MSGID(USR8221) MSGF(&LIB/&OBJ)
882900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
883000000000
883100000000             ADDMSGD +
883200000000                MSGID(USR8221) +
883300000000                MSGF(&LIB/&OBJ) +
883400000000                MSG( +
883500000000'Editor nicht zulässig. Feld &1 hat ungültigen Datentyp.'             +
883600000000                ) +
883700000000                SEV(0) +
883800000000                FMT( +
883900000000                    (*CHAR 10) +
884000000000                ) +
884100000000                ALROPT(*NO) +
884200000000                CCSID(65535) +
884300000000                /*  -EOF-  */
884400000000
884500000000     /*-------------------------------------------------------------*/
884600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8222                    */
884700000000     /* Feld &1 zu lang für Editor.                                 */
884800000000     /*-------------------------------------------------------------*/
884900000000
885000000000             RMVMSGD MSGID(USR8222) MSGF(&LIB/&OBJ)
885100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
885200000000
885300000000             ADDMSGD +
885400000000                MSGID(USR8222) +
885500000000                MSGF(&LIB/&OBJ) +
885600000000                MSG( +
885700000000'Feld &1 zu lang für Editor.'                                         +
885800000000                ) +
885900000000                SEV(0) +
886000000000                FMT( +
886100000000                    (*CHAR 10) +
886200000000                ) +
886300000000                ALROPT(*NO) +
886400000000                CCSID(65535) +
886500000000                /*  -EOF-  */
886600000000
886700000000     /*-------------------------------------------------------------*/
886800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8223                    */
886900000000     /* Eingabe der Schlüsselfelder auf Kleinbuchstaben geschaltet. */
887000000000     /*-------------------------------------------------------------*/
887100000000
887200000000             RMVMSGD MSGID(USR8223) MSGF(&LIB/&OBJ)
887300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
887400000000
887500000000             ADDMSGD +
887600000000                MSGID(USR8223) +
887700000000                MSGF(&LIB/&OBJ) +
887800000000                MSG( +
887900000000'Eingabe der Schlüsselfelder auf Kleinbuchstaben geschaltet.'         +
888000000000                ) +
888100000000                SEV(0) +
888200000000     /*   No replacement variables defined!                         */ +
888300000000                ALROPT(*NO) +
888400000000                CCSID(65535) +
888500000000                /*  -EOF-  */
888600000000
888700000000     /*-------------------------------------------------------------*/
888800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8224                    */
888900000000     /* Eingabe der Schlüsselfelder auf Grossbuchstaben geschaltet. */
889000000000     /*-------------------------------------------------------------*/
889100000000
889200000000             RMVMSGD MSGID(USR8224) MSGF(&LIB/&OBJ)
889300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
889400000000
889500000000             ADDMSGD +
889600000000                MSGID(USR8224) +
889700000000                MSGF(&LIB/&OBJ) +
889800000000                MSG( +
889900000000'Eingabe der Schlüsselfelder auf Grossbuchstaben geschaltet.'         +
890000000000                ) +
890100000000                SEV(0) +
890200000000     /*   No replacement variables defined!                         */ +
890300000000                ALROPT(*NO) +
890400000000                CCSID(65535) +
890500000000                /*  -EOF-  */
890600000000
890700000000     /*-------------------------------------------------------------*/
890800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8225                    */
890900000000     /* Datensatz wurde zwischenzeitlich von einem anderem Job geän */
891000000000     /*-------------------------------------------------------------*/
891100000000
891200000000             RMVMSGD MSGID(USR8225) MSGF(&LIB/&OBJ)
891300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
891400000000
891500000000             ADDMSGD +
891600000000                MSGID(USR8225) +
891700000000                MSGF(&LIB/&OBJ) +
891800000000                MSG( +
891900000000'Datensatz wurde zwischenzeitlich von einem anderem Job geändert.°°Tro-
892000000000tzdem ändern?'                                                        +
892100000000                ) +
892200000000                SEV(0) +
892300000000     /*   No replacement variables defined!                         */ +
892400000000                ALROPT(*NO) +
892500000000                CCSID(65535) +
892600000000                /*  -EOF-  */
892700000000
892800000000     /*-------------------------------------------------------------*/
892900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8226                    */
893000000000     /* Druckvorgang erfolgreich beendet.                           */
893100000000     /*-------------------------------------------------------------*/
893200000000
893300000000             RMVMSGD MSGID(USR8226) MSGF(&LIB/&OBJ)
893400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
893500000000
893600000000             ADDMSGD +
893700000000                MSGID(USR8226) +
893800000000                MSGF(&LIB/&OBJ) +
893900000000                MSG( +
894000000000'Druckvorgang erfolgreich beendet.'                                   +
894100000000                ) +
894200000000                SEV(0) +
894300000000     /*   No replacement variables defined!                         */ +
894400000000                ALROPT(*NO) +
894500000000                CCSID(65535) +
894600000000                /*  -EOF-  */
894700000000
894800000000     /*-------------------------------------------------------------*/
894900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8227                    */
895000000000     /* Die Zeichenkette '&1' konnte nicht in einen numerischen Wer */
895100000000     /*-------------------------------------------------------------*/
895200000000
895300000000             RMVMSGD MSGID(USR8227) MSGF(&LIB/&OBJ)
895400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
895500000000
895600000000             ADDMSGD +
895700000000                MSGID(USR8227) +
895800000000                MSGF(&LIB/&OBJ) +
895900000000                MSG( +
896000000000'Die Zeichenkette ''&1'' konnte nicht in einen numerischen Wert umgese-
896100000000tzt werden.'                                                          +
896200000000                ) +
896300000000                SECLVL( +
896400000000'&N &N Information . . :   Bei der Umwandlung der Zeichenkette ''&1'' -
896500000000ist ein Fehler aufgetreten. Die Zeichenkette konnte nicht in einen num-
896600000000erischen Wert vom Typ &2(&3,&4) umgesetzt werden.'                    +
896700000000                ) +
896800000000                SEV(0) +
896900000000                FMT( +
897000000000                    (*CHAR 256) +
897100000000                    (*CHAR 1) +
897200000000                    (*DEC 5 0) +
897300000000                    (*DEC 5 0) +
897400000000                ) +
897500000000                ALROPT(*NO) +
897600000000                CCSID(65535) +
897700000000                /*  -EOF-  */
897800000000
897900000000     /*-------------------------------------------------------------*/
898000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8228                    */
898100000000     /* Datentyp '&1' ist ungültig.                                 */
898200000000     /*-------------------------------------------------------------*/
898300000000
898400000000             RMVMSGD MSGID(USR8228) MSGF(&LIB/&OBJ)
898500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
898600000000
898700000000             ADDMSGD +
898800000000                MSGID(USR8228) +
898900000000                MSGF(&LIB/&OBJ) +
899000000000                MSG( +
899100000000'Datentyp ''&1'' ist ungültig.'                                       +
899200000000                ) +
899300000000                SECLVL( +
899400000000'&N &N Information . . :   Der angegebene Datentyp ''&1'' wird nicht u-
899500000000nterstützt. Bitte geben Sie einen gültigen RPG Datentyp an und wiederh-
899600000000olen Sie die Anforderung.'                                            +
899700000000                ) +
899800000000                SEV(0) +
899900000000                FMT( +
900000000000                    (*CHAR 256) +
900100000000                ) +
900200000000                ALROPT(*NO) +
900300000000                CCSID(65535) +
900400000000                /*  -EOF-  */
900500000000
900600000000     /*-------------------------------------------------------------*/
900700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8229                    */
900800000000     /* Wert '&1' für die Feldlänge ist ungültig.                   */
900900000000     /*-------------------------------------------------------------*/
901000000000
901100000000             RMVMSGD MSGID(USR8229) MSGF(&LIB/&OBJ)
901200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
901300000000
901400000000             ADDMSGD +
901500000000                MSGID(USR8229) +
901600000000                MSGF(&LIB/&OBJ) +
901700000000                MSG( +
901800000000'Wert ''&1'' für die Feldlänge ist ungültig.'                         +
901900000000                ) +
902000000000                SECLVL( +
902100000000'&N &N Information . . :   Der angegebene Wert ''&1'' für die Feldläng-
902200000000e ist ungültig. Bitte korrigieren Sie die Feldlänge und wiederholen Si-
902300000000e die Anforderung.'                                                   +
902400000000                ) +
902500000000                SEV(0) +
902600000000                FMT( +
902700000000                    (*CHAR 256) +
902800000000                ) +
902900000000                ALROPT(*NO) +
903000000000                CCSID(65535) +
903100000000                /*  -EOF-  */
903200000000
903300000000     /*-------------------------------------------------------------*/
903400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8230                    */
903500000000     /* Wert '&1' für die Anzahl Nachkommastellen ist ungültig.     */
903600000000     /*-------------------------------------------------------------*/
903700000000
903800000000             RMVMSGD MSGID(USR8230) MSGF(&LIB/&OBJ)
903900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
904000000000
904100000000             ADDMSGD +
904200000000                MSGID(USR8230) +
904300000000                MSGF(&LIB/&OBJ) +
904400000000                MSG( +
904500000000'Wert ''&1'' für die Anzahl Nachkommastellen ist ungültig.'           +
904600000000                ) +
904700000000                SECLVL( +
904800000000'&N &N Information . . :   Der angegebene Wert ''&1'' für die Anzahl N-
904900000000achkommastellen ist ungültig. Bitte korrigieren Sie die Anzahl Nachkom-
905000000000mastellen und wiederholen Sie die Anforderung. Beachten Sie, dass nich-
905100000000t alle Datentypen, z.B. ''A'' für Zeichenketten, Nachkommastellen erfo-
905200000000rdern.'                                                               +
905300000000                ) +
905400000000                SEV(0) +
905500000000                FMT( +
905600000000                    (*CHAR 256) +
905700000000                ) +
905800000000                ALROPT(*NO) +
905900000000                CCSID(65535) +
906000000000                /*  -EOF-  */
906100000000
906200000000     /*-------------------------------------------------------------*/
906300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8231                    */
906400000000     /* Eine Änderung der Satzsperre ist nur im Änderungsmodus mögl */
906500000000     /*-------------------------------------------------------------*/
906600000000
906700000000             RMVMSGD MSGID(USR8231) MSGF(&LIB/&OBJ)
906800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
906900000000
907000000000             ADDMSGD +
907100000000                MSGID(USR8231) +
907200000000                MSGF(&LIB/&OBJ) +
907300000000                MSG( +
907400000000'Eine Änderung der Satzsperre ist nur im Änderungsmodus möglich.'     +
907500000000                ) +
907600000000                SECLVL( +
907700000000'&N &N Information . . :   Die Satzsperre kann nur im Änderungsmodus a-
907800000000ngefordert oder freigegeben werden. Beim Kopieren oder bei der Neuanla-
907900000000ge von Datensätzen ist dies nicht möglich.'                           +
908000000000                ) +
908100000000                SEV(0) +
908200000000     /*   No replacement variables defined!                         */ +
908300000000                ALROPT(*NO) +
908400000000                CCSID(65535) +
908500000000                /*  -EOF-  */
908600000000
908700000000     /*-------------------------------------------------------------*/
908800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8232                    */
908900000000     /* Datensatz wurde zwischenzeitlich von einem anderem Job geän */
909000000000     /*-------------------------------------------------------------*/
909100000000
909200000000             RMVMSGD MSGID(USR8232) MSGF(&LIB/&OBJ)
909300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
909400000000
909500000000             ADDMSGD +
909600000000                MSGID(USR8232) +
909700000000                MSGF(&LIB/&OBJ) +
909800000000                MSG( +
909900000000'Datensatz wurde zwischenzeitlich von einem anderem Job geändert.°°Tro-
910000000000tzdem sperren?'                                                       +
910100000000                ) +
910200000000                SEV(0) +
910300000000     /*   No replacement variables defined!                         */ +
910400000000                ALROPT(*NO) +
910500000000                CCSID(65535) +
910600000000                /*  -EOF-  */
910700000000
910800000000     /*-------------------------------------------------------------*/
910900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8233                    */
911000000000     /* Fehler: Ungültiges Layout aufgrund abweichender Satzformat- */
911100000000     /*-------------------------------------------------------------*/
911200000000
911300000000             RMVMSGD MSGID(USR8233) MSGF(&LIB/&OBJ)
911400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
911500000000
911600000000             ADDMSGD +
911700000000                MSGID(USR8233) +
911800000000                MSGF(&LIB/&OBJ) +
911900000000                MSG( +
912000000000'Fehler: Ungültiges Layout aufgrund abweichender Satzformat-ID.'      +
912100000000                ) +
912200000000                SECLVL( +
912300000000'&N &N Fehlerkorrektur :   Versuchsweise kann der Eintrag *RCDFMTID au-
912400000000s der Datei &2/&1, Teildatei &3 gelöscht werden, um die Prüfung der Sa-
912500000000tzformat_ID ausser Kraft zu setzen. Kann das Layout danach geladen wer-
912600000000den, muss es erneut gespeichert werden, um die Satzformat ID wieder hi-
912700000000nzuzufügen.'                                                          +
912800000000                ) +
912900000000                SEV(0) +
913000000000                FMT( +
913100000000                    (*CHAR 10) +
913200000000                    (*CHAR 10) +
913300000000                    (*CHAR 10) +
913400000000                ) +
913500000000                ALROPT(*NO) +
913600000000                CCSID(65535) +
913700000000                /*  -EOF-  */
913800000000
913900000000     /*-------------------------------------------------------------*/
914000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8234                    */
914100000000     /* Layout konnte aufgrund abweichender Satzformat-IDs nicht ge */
914200000000     /*-------------------------------------------------------------*/
914300000000
914400000000             RMVMSGD MSGID(USR8234) MSGF(&LIB/&OBJ)
914500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
914600000000
914700000000             ADDMSGD +
914800000000                MSGID(USR8234) +
914900000000                MSGF(&LIB/&OBJ) +
915000000000                MSG( +
915100000000'Layout konnte aufgrund abweichender Satzformat-IDs nicht geladen werd-
915200000000en.'                                                                  +
915300000000                ) +
915400000000                SECLVL( +
915500000000'&N &N Ursache . . . . :   Das angegebene Layout konnte nicht geladen -
915600000000werden, weil die im Layout gespeicherte Formatebenen-ID von der Format-
915700000000ebenen-ID der anzuzeigenden Datei abweicht.&N Fehlerkorrektur : Versuc-
915800000000hsweise kann der Eintrag *RCDFMTID aus der Datei &2/&1, Teildatei &3 g-
915900000000elöscht werden, um die Prüfung der Satzformat_ID ausser Kraft zu setze-
916000000000n. Kann das Layout danach geladen werden, muss es erneut gespeichert w-
916100000000erden, um die Satzformat ID wieder hinzuzufügen.'                     +
916200000000                ) +
916300000000                SEV(0) +
916400000000                FMT( +
916500000000                    (*CHAR 10) +
916600000000                    (*CHAR 10) +
916700000000                    (*CHAR 10) +
916800000000                ) +
916900000000                ALROPT(*NO) +
917000000000                CCSID(65535) +
917100000000                /*  -EOF-  */
917200000000
917300000000     /*-------------------------------------------------------------*/
917400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8235                    */
917500000000     /* SQL-Auswahl wird für Multi-Member logische Dateien nicht un */
917600000000     /*-------------------------------------------------------------*/
917700000000
917800000000             RMVMSGD MSGID(USR8235) MSGF(&LIB/&OBJ)
917900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
918000000000
918100000000             ADDMSGD +
918200000000                MSGID(USR8235) +
918300000000                MSGF(&LIB/&OBJ) +
918400000000                MSG( +
918500000000'SQL-Auswahl wird für Multi-Member logische Dateien nicht unterstützt.-
918600000000'                                                                     +
918700000000                ) +
918800000000                SEV(0) +
918900000000     /*   No replacement variables defined!                         */ +
919000000000                ALROPT(*NO) +
919100000000                CCSID(65535) +
919200000000                /*  -EOF-  */
919300000000
919400000000     /*-------------------------------------------------------------*/
919500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8236                    */
919600000000     /* Einfügemodus aktiviert.                                     */
919700000000     /*-------------------------------------------------------------*/
919800000000
919900000000             RMVMSGD MSGID(USR8236) MSGF(&LIB/&OBJ)
920000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
920100000000
920200000000             ADDMSGD +
920300000000                MSGID(USR8236) +
920400000000                MSGF(&LIB/&OBJ) +
920500000000                MSG( +
920600231113'Einfügemodus aktiviert. Positionieren Cursor, dann F7 drücken.'      +
920700000000                ) +
920800000000                SEV(0) +
920900000000     /*   No replacement variables defined!                         */ +
921000000000                ALROPT(*NO) +
921100000000                CCSID(65535) +
921200000000                /*  -EOF-  */
921300000000
921400000000     /*-------------------------------------------------------------*/
921500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8237                    */
921600000000     /* Eingabetaste drücken, um die angegebenen Anzahl Leerzeichen */
921700000000     /*-------------------------------------------------------------*/
921800000000
921900000000             RMVMSGD MSGID(USR8237) MSGF(&LIB/&OBJ)
922000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
922100000000
922200000000             ADDMSGD +
922300000000                MSGID(USR8237) +
922400000000                MSGF(&LIB/&OBJ) +
922500000000                MSG( +
922600000000'Eingabetaste drücken, um die angegebenen Anzahl Leerzeichen einzufüge-
922700000000n.'                                                                   +
922800000000                ) +
922900000000                SEV(0) +
923000000000     /*   No replacement variables defined!                         */ +
923100000000                ALROPT(*NO) +
923200000000                CCSID(65535) +
923300000000                /*  -EOF-  */
923400000000
923500000000     /*-------------------------------------------------------------*/
923600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8238                    */
923700000000     /* Löschmodus aktiviert.                                       */
923800000000     /*-------------------------------------------------------------*/
923900000000
924000000000             RMVMSGD MSGID(USR8238) MSGF(&LIB/&OBJ)
924100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
924200000000
924300000000             ADDMSGD +
924400000000                MSGID(USR8238) +
924500000000                MSGF(&LIB/&OBJ) +
924600000000                MSG( +
924700231113'Löschmodus aktiviert. Positionieren Cursor, dann F8 drücken.'        +
924800000000                ) +
924900000000                SEV(0) +
925000000000     /*   No replacement variables defined!                         */ +
925100000000                ALROPT(*NO) +
925200000000                CCSID(65535) +
925300000000                /*  -EOF-  */
925400000000
925500000000     /*-------------------------------------------------------------*/
925600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8239                    */
925700000000     /* Eingabetaste drücken, um den angegebenen Bereich von Zeiche */
925800000000     /*-------------------------------------------------------------*/
925900000000
926000000000             RMVMSGD MSGID(USR8239) MSGF(&LIB/&OBJ)
926100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
926200000000
926300000000             ADDMSGD +
926400000000                MSGID(USR8239) +
926500000000                MSGF(&LIB/&OBJ) +
926600000000                MSG( +
926700000000'Eingabetaste drücken, um den angegebenen Bereich von Zeichen zu lösch-
926800000000en.'                                                                  +
926900000000                ) +
927000000000                SEV(0) +
927100000000     /*   No replacement variables defined!                         */ +
927200000000                ALROPT(*NO) +
927300000000                CCSID(65535) +
927400000000                /*  -EOF-  */
927500000000
927600000000     /*-------------------------------------------------------------*/
927700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8240                    */
927800000000     /* Wert darf nicht kleiner 1 sein.                             */
927900000000     /*-------------------------------------------------------------*/
928000000000
928100000000             RMVMSGD MSGID(USR8240) MSGF(&LIB/&OBJ)
928200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
928300000000
928400000000             ADDMSGD +
928500000000                MSGID(USR8240) +
928600000000                MSGF(&LIB/&OBJ) +
928700000000                MSG( +
928800231113'Wert darf nicht kleiner &1 sein.'                                    +
928900000000                ) +
929000000000                SEV(0) +
929100231113                FMT( +
929200231113                    (*DEC 5 0) +
929300231113                ) +
929400231113                ALROPT(*NO) +
929500000000                CCSID(65535) +
929600000000                /*  -EOF-  */
929700000000
929800000000     /*-------------------------------------------------------------*/
929900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8241                    */
930000000000     /* Wert darf darf die Feldlänge nicht überschreiten.           */
930100000000     /*-------------------------------------------------------------*/
930200000000
930300000000             RMVMSGD MSGID(USR8241) MSGF(&LIB/&OBJ)
930400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
930500000000
930600000000             ADDMSGD +
930700000000                MSGID(USR8241) +
930800000000                MSGF(&LIB/&OBJ) +
930900000000                MSG( +
931000231113'Feldlänge überschritten. Der Wert ist um &1 Zeichen zu groß.'        +
931100000000                ) +
931200000000                SEV(0) +
931300231113                FMT( +
931400231113                    (*DEC 5 0) +
931500231113                ) +
931600231113                ALROPT(*NO) +
931700000000                CCSID(65535) +
931800000000                /*  -EOF-  */
931900000000
932000000000     /*-------------------------------------------------------------*/
932100000000     /*   Cmd-ADDMSGD für Message-ID :   USR9992                    */
932200000000     /* Benutzereinstellungen konnten nicht gespeichert werden.     */
932300000000     /*-------------------------------------------------------------*/
932400000000
932500000000             RMVMSGD MSGID(USR9992) MSGF(&LIB/&OBJ)
932600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
932700000000
932800000000             ADDMSGD +
932900000000                MSGID(USR9992) +
933000000000                MSGF(&LIB/&OBJ) +
933100000000                MSG( +
933200000000'Benutzereinstellungen konnten nicht gespeichert werden.'             +
933300000000                ) +
933400000000                SECLVL( +
933500000000'&N &N Ursache . . . . :   Die Benutzereinstellungen konnten aufgrund -
933600000000von Ursachencode &1 nicht gespeichert werden. &N &N Die möglichen Ursa-
933700000000chencodes sind: &N &B 1 - Name der Datei (&2) stimmt nicht mit der geö-
933800000000ffneten Datei überein. &B 2 - Name der Bibliothek (&2) stimmt nicht mi-
933900000000t der Bibliothek der geöfneten Datei überein. &B 3 - Datei für Benutze-
934000000000reinstellungen &3/&2 mit Teildatei &4 konnte nicht geöffnet werden.'  +
934100000000                ) +
934200000000                SEV(0) +
934300000000                FMT( +
934400000000                    (*DEC 10 0) +
934500000000                    (*CHAR 10) +
934600000000                    (*CHAR 10) +
934700000000                    (*CHAR 10) +
934800000000                ) +
934900000000                ALROPT(*NO) +
935000000000                CCSID(65535) +
935100000000                /*  -EOF-  */
935200000000
935300000000     /*-------------------------------------------------------------*/
935400000000     /*   Cmd-ADDMSGD für Message-ID :   USR9993                    */
935500000000     /* Keine Datei geöffnet. Der Zugriff über SQL kann nur auf phy */
935600000000     /*-------------------------------------------------------------*/
935700000000
935800000000             RMVMSGD MSGID(USR9993) MSGF(&LIB/&OBJ)
935900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
936000000000
936100000000             ADDMSGD +
936200000000                MSGID(USR9993) +
936300000000                MSGF(&LIB/&OBJ) +
936400000000                MSG( +
936500000000'Keine Datei geöffnet. Der Zugriff über SQL kann nur auf physische Dat-
936600000000eien angewendet werden.'                                              +
936700000000                ) +
936800000000                SEV(0) +
936900000000                FMT( +
937000000000                    (*DEC 5 0) +
937100000000                    (*CHAR 32) +
937200000000                    (*CHAR 256) +
937300000000                ) +
937400000000                ALROPT(*NO) +
937500000000                CCSID(65535) +
937600000000                /*  -EOF-  */
937700000000
937800000000     /*-------------------------------------------------------------*/
937900000000     /*   Cmd-ADDMSGD für Message-ID :   USR9994                    */
938000000000     /* Unerwarteter Fehler &1 in C Funktion &2 aufgetreten.        */
938100000000     /*-------------------------------------------------------------*/
938200000000
938300000000             RMVMSGD MSGID(USR9994) MSGF(&LIB/&OBJ)
938400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
938500000000
938600000000             ADDMSGD +
938700000000                MSGID(USR9994) +
938800000000                MSGF(&LIB/&OBJ) +
938900000000                MSG( +
939000000000'Unerwarteter Fehler &1 in C Funktion &2 aufgetreten.'                +
939100000000                ) +
939200000000                SECLVL( +
939300000000'&N &N Fehlertext  . . :   &3'                                        +
939400000000                ) +
939500000000                SEV(0) +
939600000000                FMT( +
939700000000                    (*DEC 5 0) +
939800000000                    (*CHAR 32) +
939900000000                    (*CHAR 256) +
940000000000                ) +
940100000000                ALROPT(*NO) +
940200000000                CCSID(65535) +
940300000000                /*  -EOF-  */
940400000000
940500000000     /*-------------------------------------------------------------*/
940600000000     /*   Cmd-ADDMSGD für Message-ID :   USR9995                    */
940700000000     /* Struktur der Einstellungsdatei wird angepasst ...           */
940800000000     /*-------------------------------------------------------------*/
940900000000
941000000000             RMVMSGD MSGID(USR9995) MSGF(&LIB/&OBJ)
941100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
941200000000
941300000000             ADDMSGD +
941400000000                MSGID(USR9995) +
941500000000                MSGF(&LIB/&OBJ) +
941600000000                MSG( +
941700000000'Struktur der Einstellungsdatei wird angepasst ...'                   +
941800000000                ) +
941900000000                SEV(0) +
942000000000     /*   No replacement variables defined!                         */ +
942100000000                ALROPT(*NO) +
942200000000                CCSID(65535) +
942300000000                /*  -EOF-  */
942400000000
942500000000     /*-------------------------------------------------------------*/
942600000000     /*   Cmd-ADDMSGD für Message-ID :   USR9996                    */
942700000000     /* Keine Datei geöffnet.                                       */
942800000000     /*-------------------------------------------------------------*/
942900000000
943000000000             RMVMSGD MSGID(USR9996) MSGF(&LIB/&OBJ)
943100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
943200000000
943300000000             ADDMSGD +
943400000000                MSGID(USR9996) +
943500000000                MSGF(&LIB/&OBJ) +
943600000000                MSG( +
943700000000'Keine Datei geöffnet.'                                               +
943800000000                ) +
943900000000                SEV(0) +
944000000000     /*   No replacement variables defined!                         */ +
944100000000                ALROPT(*NO) +
944200000000                CCSID(65535) +
944300000000                /*  -EOF-  */
944400000000
944500000000     /*-------------------------------------------------------------*/
944600000000     /*   Cmd-ADDMSGD für Message-ID :   USR9997                    */
944700000000     /* &2PEEK/400 ist&1 Shareware. &2Bitte lassen Sie sich registr */
944800000000     /*-------------------------------------------------------------*/
944900000000
945000000000             RMVMSGD MSGID(USR9997) MSGF(&LIB/&OBJ)
945100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
945200000000
945300000000             ADDMSGD +
945400000000                MSGID(USR9997) +
945500000000                MSGF(&LIB/&OBJ) +
945600000000                MSG( +
945700000000'&2PEEK/400 ist&1 Shareware. &2Bitte lassen Sie sich registrieren!'   +
945800000000                ) +
945900000000                SEV(0) +
946000000000                FMT( +
946100000000                    (*CHAR 1) +
946200000000                    (*CHAR 1) +
946300000000                ) +
946400000000                ALROPT(*NO) +
946500000000                CCSID(65535) +
946600000000                /*  -EOF-  */
946700000000
946800000000     /*-------------------------------------------------------------*/
946900000000     /*   Cmd-ADDMSGD für Message-ID :   USR9998                    */
947000000000     /* Unerwartete Nachrichten-ID &1 von Programm &2.              */
947100000000     /*-------------------------------------------------------------*/
947200000000
947300000000             RMVMSGD MSGID(USR9998) MSGF(&LIB/&OBJ)
947400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
947500000000
947600000000             ADDMSGD +
947700000000                MSGID(USR9998) +
947800000000                MSGF(&LIB/&OBJ) +
947900000000                MSG( +
948000000000'Unerwartete Nachrichten-ID &1 von Programm &2.'                      +
948100000000                ) +
948200000000                SEV(0) +
948300000000                FMT( +
948400000000                    (*CHAR 7) +
948500000000                    (*CHAR 10) +
948600000000                ) +
948700000000                ALROPT(*NO) +
948800000000                CCSID(65535) +
948900000000                /*  -EOF-  */
949000000000
949100000000     /*-------------------------------------------------------------*/
949200000000     /*   Cmd-ADDMSGD für Message-ID :   USR9999                    */
949300000000     /* &1                                                          */
949400000000     /*-------------------------------------------------------------*/
949500000000
949600000000             RMVMSGD MSGID(USR9999) MSGF(&LIB/&OBJ)
949700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
949800000000
949900000000             ADDMSGD +
950000000000                MSGID(USR9999) +
950100000000                MSGF(&LIB/&OBJ) +
950200000000                MSG( +
950300000000'&1'                                                                  +
950400000000                ) +
950500000000                SECLVL( +
950600000000'&2'                                                                  +
950700000000                ) +
950800000000                SEV(0) +
950900000000                FMT( +
951000000000                    (*CHAR 128) +
951100000000                    (*CHAR 128) +
951200000000                ) +
951300000000                ALROPT(*NO) +
951400000000                CCSID(65535) +
951500000000                /*  -EOF-  */
951600000000
951700000000             RCLRSC LVL(*)
951800000000
951900000000             ENDPGM
