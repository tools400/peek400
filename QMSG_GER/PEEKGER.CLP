000001000000     /*-----------------------------------------------------------------------*/
000002000000     /* STRPREPRC Compile Options:                                            */
000003000000     /* >>PRE-COMPILER<<                                                      */
000004000000     /*   >>CRTCMD<<  CALL       PGM(QTEMP/&OB) PARM(&LI &OB);                */
000005000000     /*   >>CMD<<     CRTCLPGM   PGM(QTEMP/&OB) +                             */
000006000000     /*                          SRCFILE(&SL/&SF) SRCMBR(&SM) +               */
000007000000     /*               TEXT('Peek/400 - Deutsche Übersetzung');                */
000008000000     /*   >>EXECUTE<<                                                         */
000009000000     /*   >>CMD<<     DLTPGM PGM(QTEMP/&OB);                                  */
000010000000     /* >>END-PRE-COMPILER<<                                                  */
000011000000     /*-----------------------------------------------------------------------*/
000012000000             PGM        PARM(&I_LIB &I_OBJ)
000013000000
000014000000             DCL        VAR(&I_LIB     ) TYPE(*CHAR) LEN(10)
000015000000             DCL        VAR(&I_OBJ     ) TYPE(*CHAR) LEN(10)
000016000000             DCL        VAR(&LIB       ) TYPE(*CHAR) LEN(10)
000017000000             DCL        VAR(&OBJ       ) TYPE(*CHAR) LEN(10)
000018000000
000019000000             CHGVAR     VAR(&LIB       ) VALUE(&I_LIB)
000020000000             MONMSG     MSGID(MCH3601) EXEC(DO)
000021000000               RMVMSG     PGMQ(*SAME (*)) CLEAR(*ALL)
000022000000               SNDPGMMSG  MSGID(CPF9898) MSGF(*LIBL/QCPFMSG) +
000023000000                            MSGDTA('Usage: CALL PGM(PEEKGER) +
000024000000                                    PARM(libName [msgFName)') +
000025000000                            TOPGMQ(*PRV (*PGMBDY)) MSGTYPE(*ESCAPE)
000026000000             ENDDO
000027000000
000028000000             CHGVAR     VAR(&OBJ       ) VALUE(&I_OBJ)
000029000000             MONMSG     MSGID(MCH3601) EXEC(DO)
000030000000               RMVMSG     PGMQ(*SAME (*)) CLEAR(*ALL)
000031000000               CHGVAR     VAR(&OBJ) VALUE('PEEKGER   ')
000032000000             ENDDO
000033000000
000034000000     /*-------------------------------------------------------------*/
000035000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BA                    */
000036000000     /* Funktionstaste F22 nicht gültig.                            */
000037000000     /*-------------------------------------------------------------*/
000038000000
000039000000             RMVMSGD MSGID(AID00BA) MSGF(&LIB/&OBJ)
000040000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000041000000
000042000000             ADDMSGD +
000043000000                MSGID(AID00BA) +
000044000000                MSGF(&LIB/&OBJ) +
000045000000                MSG( +
000046000000'Funktionstaste F22 nicht gültig.'                                    +
000047000000                ) +
000048000000                SEV(0) +
000049000000     /*   No replacement variables defined!                         */ +
000050000000                ALROPT(*NO) +
000051000000                CCSID(65535) +
000052000000                /*  -EOF-  */
000053000000
000054000000     /*-------------------------------------------------------------*/
000055000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BB                    */
000056000000     /* Funktionstaste F23 nicht gültig.                            */
000057000000     /*-------------------------------------------------------------*/
000058000000
000059000000             RMVMSGD MSGID(AID00BB) MSGF(&LIB/&OBJ)
000060000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000061000000
000062000000             ADDMSGD +
000063000000                MSGID(AID00BB) +
000064000000                MSGF(&LIB/&OBJ) +
000065000000                MSG( +
000066000000'Funktionstaste F23 nicht gültig.'                                    +
000067000000                ) +
000068000000                SEV(0) +
000069000000     /*   No replacement variables defined!                         */ +
000070000000                ALROPT(*NO) +
000071000000                CCSID(65535) +
000072000000                /*  -EOF-  */
000073000000
000074000000     /*-------------------------------------------------------------*/
000075000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BC                    */
000076000000     /* Funktionstaste F24 nicht gültig.                            */
000077000000     /*-------------------------------------------------------------*/
000078000000
000079000000             RMVMSGD MSGID(AID00BC) MSGF(&LIB/&OBJ)
000080000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000081000000
000082000000             ADDMSGD +
000083000000                MSGID(AID00BC) +
000084000000                MSGF(&LIB/&OBJ) +
000085000000                MSG( +
000086000000'Funktionstaste F24 nicht gültig.'                                    +
000087000000                ) +
000088000000                SEV(0) +
000089000000     /*   No replacement variables defined!                         */ +
000090000000                ALROPT(*NO) +
000091000000                CCSID(65535) +
000092000000                /*  -EOF-  */
000093000000
000094000000     /*-------------------------------------------------------------*/
000095000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BD                    */
000096000000     /* Taste 'LÖSCHEN' nicht gültig                                */
000097000000     /*-------------------------------------------------------------*/
000098000000
000099000000             RMVMSGD MSGID(AID00BD) MSGF(&LIB/&OBJ)
000100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000101000000
000102000000             ADDMSGD +
000103000000                MSGID(AID00BD) +
000104000000                MSGF(&LIB/&OBJ) +
000105000000                MSG( +
000106000000'Taste ''LÖSCHEN'' nicht gültig'                                      +
000107000000                ) +
000108000000                SEV(0) +
000109000000     /*   No replacement variables defined!                         */ +
000110000000                ALROPT(*NO) +
000111000000                CCSID(65535) +
000112000000                /*  -EOF-  */
000113000000
000114000000     /*-------------------------------------------------------------*/
000115000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B1                    */
000116000000     /* Funktionstaste F13 nicht gültig.                            */
000117000000     /*-------------------------------------------------------------*/
000118000000
000119000000             RMVMSGD MSGID(AID00B1) MSGF(&LIB/&OBJ)
000120000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000121000000
000122000000             ADDMSGD +
000123000000                MSGID(AID00B1) +
000124000000                MSGF(&LIB/&OBJ) +
000125000000                MSG( +
000126000000'Funktionstaste F13 nicht gültig.'                                    +
000127000000                ) +
000128000000                SEV(0) +
000129000000     /*   No replacement variables defined!                         */ +
000130000000                ALROPT(*NO) +
000131000000                CCSID(65535) +
000132000000                /*  -EOF-  */
000133000000
000134000000     /*-------------------------------------------------------------*/
000135000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B2                    */
000136000000     /* Funktionstaste F14 nicht gültig.                            */
000137000000     /*-------------------------------------------------------------*/
000138000000
000139000000             RMVMSGD MSGID(AID00B2) MSGF(&LIB/&OBJ)
000140000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000141000000
000142000000             ADDMSGD +
000143000000                MSGID(AID00B2) +
000144000000                MSGF(&LIB/&OBJ) +
000145000000                MSG( +
000146000000'Funktionstaste F14 nicht gültig.'                                    +
000147000000                ) +
000148000000                SEV(0) +
000149000000     /*   No replacement variables defined!                         */ +
000150000000                ALROPT(*NO) +
000151000000                CCSID(65535) +
000152000000                /*  -EOF-  */
000153000000
000154000000     /*-------------------------------------------------------------*/
000155000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B3                    */
000156000000     /* Funktionstaste F15 nicht gültig.                            */
000157000000     /*-------------------------------------------------------------*/
000158000000
000159000000             RMVMSGD MSGID(AID00B3) MSGF(&LIB/&OBJ)
000160000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000161000000
000162000000             ADDMSGD +
000163000000                MSGID(AID00B3) +
000164000000                MSGF(&LIB/&OBJ) +
000165000000                MSG( +
000166000000'Funktionstaste F15 nicht gültig.'                                    +
000167000000                ) +
000168000000                SEV(0) +
000169000000     /*   No replacement variables defined!                         */ +
000170000000                ALROPT(*NO) +
000171000000                CCSID(65535) +
000172000000                /*  -EOF-  */
000173000000
000174000000     /*-------------------------------------------------------------*/
000175000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B4                    */
000176000000     /* Funktionstaste F16 nicht gültig.                            */
000177000000     /*-------------------------------------------------------------*/
000178000000
000179000000             RMVMSGD MSGID(AID00B4) MSGF(&LIB/&OBJ)
000180000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000181000000
000182000000             ADDMSGD +
000183000000                MSGID(AID00B4) +
000184000000                MSGF(&LIB/&OBJ) +
000185000000                MSG( +
000186000000'Funktionstaste F16 nicht gültig.'                                    +
000187000000                ) +
000188000000                SEV(0) +
000189000000     /*   No replacement variables defined!                         */ +
000190000000                ALROPT(*NO) +
000191000000                CCSID(65535) +
000192000000                /*  -EOF-  */
000193000000
000194000000     /*-------------------------------------------------------------*/
000195000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B5                    */
000196000000     /* Funktionstaste F17 nicht gültig.                            */
000197000000     /*-------------------------------------------------------------*/
000198000000
000199000000             RMVMSGD MSGID(AID00B5) MSGF(&LIB/&OBJ)
000200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000201000000
000202000000             ADDMSGD +
000203000000                MSGID(AID00B5) +
000204000000                MSGF(&LIB/&OBJ) +
000205000000                MSG( +
000206000000'Funktionstaste F17 nicht gültig.'                                    +
000207000000                ) +
000208000000                SEV(0) +
000209000000     /*   No replacement variables defined!                         */ +
000210000000                ALROPT(*NO) +
000211000000                CCSID(65535) +
000212000000                /*  -EOF-  */
000213000000
000214000000     /*-------------------------------------------------------------*/
000215000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B6                    */
000216000000     /* Funktionstaste F18 nicht gültig.                            */
000217000000     /*-------------------------------------------------------------*/
000218000000
000219000000             RMVMSGD MSGID(AID00B6) MSGF(&LIB/&OBJ)
000220000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000221000000
000222000000             ADDMSGD +
000223000000                MSGID(AID00B6) +
000224000000                MSGF(&LIB/&OBJ) +
000225000000                MSG( +
000226000000'Funktionstaste F18 nicht gültig.'                                    +
000227000000                ) +
000228000000                SEV(0) +
000229000000     /*   No replacement variables defined!                         */ +
000230000000                ALROPT(*NO) +
000231000000                CCSID(65535) +
000232000000                /*  -EOF-  */
000233000000
000234000000     /*-------------------------------------------------------------*/
000235000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B7                    */
000236000000     /* Funktionstaste F19 nicht gültig.                            */
000237000000     /*-------------------------------------------------------------*/
000238000000
000239000000             RMVMSGD MSGID(AID00B7) MSGF(&LIB/&OBJ)
000240000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000241000000
000242000000             ADDMSGD +
000243000000                MSGID(AID00B7) +
000244000000                MSGF(&LIB/&OBJ) +
000245000000                MSG( +
000246000000'Funktionstaste F19 nicht gültig.'                                    +
000247000000                ) +
000248000000                SEV(0) +
000249000000     /*   No replacement variables defined!                         */ +
000250000000                ALROPT(*NO) +
000251000000                CCSID(65535) +
000252000000                /*  -EOF-  */
000253000000
000254000000     /*-------------------------------------------------------------*/
000255000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B8                    */
000256000000     /* Funktionstaste F20 nicht gültig.                            */
000257000000     /*-------------------------------------------------------------*/
000258000000
000259000000             RMVMSGD MSGID(AID00B8) MSGF(&LIB/&OBJ)
000260000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000261000000
000262000000             ADDMSGD +
000263000000                MSGID(AID00B8) +
000264000000                MSGF(&LIB/&OBJ) +
000265000000                MSG( +
000266000000'Funktionstaste F20 nicht gültig.'                                    +
000267000000                ) +
000268000000                SEV(0) +
000269000000     /*   No replacement variables defined!                         */ +
000270000000                ALROPT(*NO) +
000271000000                CCSID(65535) +
000272000000                /*  -EOF-  */
000273000000
000274000000     /*-------------------------------------------------------------*/
000275000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B9                    */
000276000000     /* Funktionstaste F21 nicht gültig.                            */
000277000000     /*-------------------------------------------------------------*/
000278000000
000279000000             RMVMSGD MSGID(AID00B9) MSGF(&LIB/&OBJ)
000280000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000281000000
000282000000             ADDMSGD +
000283000000                MSGID(AID00B9) +
000284000000                MSGF(&LIB/&OBJ) +
000285000000                MSG( +
000286000000'Funktionstaste F21 nicht gültig.'                                    +
000287000000                ) +
000288000000                SEV(0) +
000289000000     /*   No replacement variables defined!                         */ +
000290000000                ALROPT(*NO) +
000291000000                CCSID(65535) +
000292000000                /*  -EOF-  */
000293000000
000294000000     /*-------------------------------------------------------------*/
000295000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F1                    */
000296000000     /* Taste 'DATENFREIGABE' nicht gültig                          */
000297000000     /*-------------------------------------------------------------*/
000298000000
000299000000             RMVMSGD MSGID(AID00F1) MSGF(&LIB/&OBJ)
000300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000301000000
000302000000             ADDMSGD +
000303000000                MSGID(AID00F1) +
000304000000                MSGF(&LIB/&OBJ) +
000305000000                MSG( +
000306000000'Taste ''DATENFREIGABE'' nicht gültig'                                +
000307000000                ) +
000308000000                SEV(0) +
000309000000     /*   No replacement variables defined!                         */ +
000310000000                ALROPT(*NO) +
000311000000                CCSID(65535) +
000312000000                /*  -EOF-  */
000313000000
000314000000     /*-------------------------------------------------------------*/
000315000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F3                    */
000316000000     /* Taste 'HILFE' nicht gültig                                  */
000317000000     /*-------------------------------------------------------------*/
000318000000
000319000000             RMVMSGD MSGID(AID00F3) MSGF(&LIB/&OBJ)
000320000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000321000000
000322000000             ADDMSGD +
000323000000                MSGID(AID00F3) +
000324000000                MSGF(&LIB/&OBJ) +
000325000000                MSG( +
000326000000'Taste ''HILFE'' nicht gültig'                                        +
000327000000                ) +
000328000000                SEV(0) +
000329000000     /*   No replacement variables defined!                         */ +
000330000000                ALROPT(*NO) +
000331000000                CCSID(65535) +
000332000000                /*  -EOF-  */
000333000000
000334000000     /*-------------------------------------------------------------*/
000335000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F4                    */
000336000000     /* Taste 'BILD RUNTER' nicht gültig                            */
000337000000     /*-------------------------------------------------------------*/
000338000000
000339000000             RMVMSGD MSGID(AID00F4) MSGF(&LIB/&OBJ)
000340000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000341000000
000342000000             ADDMSGD +
000343000000                MSGID(AID00F4) +
000344000000                MSGF(&LIB/&OBJ) +
000345000000                MSG( +
000346000000'Taste ''BILD RUNTER'' nicht gültig'                                  +
000347000000                ) +
000348000000                SEV(0) +
000349000000     /*   No replacement variables defined!                         */ +
000350000000                ALROPT(*NO) +
000351000000                CCSID(65535) +
000352000000                /*  -EOF-  */
000353000000
000354000000     /*-------------------------------------------------------------*/
000355000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F5                    */
000356000000     /* Taste 'BILD HOCH' nicht gültig                              */
000357000000     /*-------------------------------------------------------------*/
000358000000
000359000000             RMVMSGD MSGID(AID00F5) MSGF(&LIB/&OBJ)
000360000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000361000000
000362000000             ADDMSGD +
000363000000                MSGID(AID00F5) +
000364000000                MSGF(&LIB/&OBJ) +
000365000000                MSG( +
000366000000'Taste ''BILD HOCH'' nicht gültig'                                    +
000367000000                ) +
000368000000                SEV(0) +
000369000000     /*   No replacement variables defined!                         */ +
000370000000                ALROPT(*NO) +
000371000000                CCSID(65535) +
000372000000                /*  -EOF-  */
000373000000
000374000000     /*-------------------------------------------------------------*/
000375000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F6                    */
000376000000     /* Taste 'DRUCKEN' nicht gültig                                */
000377000000     /*-------------------------------------------------------------*/
000378000000
000379000000             RMVMSGD MSGID(AID00F6) MSGF(&LIB/&OBJ)
000380000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000381000000
000382000000             ADDMSGD +
000383000000                MSGID(AID00F6) +
000384000000                MSGF(&LIB/&OBJ) +
000385000000                MSG( +
000386000000'Taste ''DRUCKEN'' nicht gültig'                                      +
000387000000                ) +
000388000000                SEV(0) +
000389000000     /*   No replacement variables defined!                         */ +
000390000000                ALROPT(*NO) +
000391000000                CCSID(65535) +
000392000000                /*  -EOF-  */
000393000000
000394000000     /*-------------------------------------------------------------*/
000395000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F8                    */
000396000000     /* Taste 'GRUNDSTELLUNG' nicht gültig                          */
000397000000     /*-------------------------------------------------------------*/
000398000000
000399000000             RMVMSGD MSGID(AID00F8) MSGF(&LIB/&OBJ)
000400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000401000000
000402000000             ADDMSGD +
000403000000                MSGID(AID00F8) +
000404000000                MSGF(&LIB/&OBJ) +
000405000000                MSG( +
000406000000'Taste ''GRUNDSTELLUNG'' nicht gültig'                                +
000407000000                ) +
000408000000                SEV(0) +
000409000000     /*   No replacement variables defined!                         */ +
000410000000                ALROPT(*NO) +
000411000000                CCSID(65535) +
000412000000                /*  -EOF-  */
000413000000
000414000000     /*-------------------------------------------------------------*/
000415000000     /*   Cmd-ADDMSGD für Message-ID :   AID003A                    */
000416000000     /* Funktionstaste F10 nicht gültig.                            */
000417000000     /*-------------------------------------------------------------*/
000418000000
000419000000             RMVMSGD MSGID(AID003A) MSGF(&LIB/&OBJ)
000420000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000421000000
000422000000             ADDMSGD +
000423000000                MSGID(AID003A) +
000424000000                MSGF(&LIB/&OBJ) +
000425000000                MSG( +
000426000000'Funktionstaste F10 nicht gültig.'                                    +
000427000000                ) +
000428000000                SEV(0) +
000429000000     /*   No replacement variables defined!                         */ +
000430000000                ALROPT(*NO) +
000431000000                CCSID(65535) +
000432000000                /*  -EOF-  */
000433000000
000434000000     /*-------------------------------------------------------------*/
000435000000     /*   Cmd-ADDMSGD für Message-ID :   AID003B                    */
000436000000     /* Funktionstaste F11 nicht gültig.                            */
000437000000     /*-------------------------------------------------------------*/
000438000000
000439000000             RMVMSGD MSGID(AID003B) MSGF(&LIB/&OBJ)
000440000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000441000000
000442000000             ADDMSGD +
000443000000                MSGID(AID003B) +
000444000000                MSGF(&LIB/&OBJ) +
000445000000                MSG( +
000446000000'Funktionstaste F11 nicht gültig.'                                    +
000447000000                ) +
000448000000                SEV(0) +
000449000000     /*   No replacement variables defined!                         */ +
000450000000                ALROPT(*NO) +
000451000000                CCSID(65535) +
000452000000                /*  -EOF-  */
000453000000
000454000000     /*-------------------------------------------------------------*/
000455000000     /*   Cmd-ADDMSGD für Message-ID :   AID003C                    */
000456000000     /* Funktionstaste F12 nicht gültig.                            */
000457000000     /*-------------------------------------------------------------*/
000458000000
000459000000             RMVMSGD MSGID(AID003C) MSGF(&LIB/&OBJ)
000460000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000461000000
000462000000             ADDMSGD +
000463000000                MSGID(AID003C) +
000464000000                MSGF(&LIB/&OBJ) +
000465000000                MSG( +
000466000000'Funktionstaste F12 nicht gültig.'                                    +
000467000000                ) +
000468000000                SEV(0) +
000469000000     /*   No replacement variables defined!                         */ +
000470000000                ALROPT(*NO) +
000471000000                CCSID(65535) +
000472000000                /*  -EOF-  */
000473000000
000474000000     /*-------------------------------------------------------------*/
000475000000     /*   Cmd-ADDMSGD für Message-ID :   AID003F                    */
000476000000     /* Taste 'LICHTGRIFFEL' nicht gültig                           */
000477000000     /*-------------------------------------------------------------*/
000478000000
000479000000             RMVMSGD MSGID(AID003F) MSGF(&LIB/&OBJ)
000480000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000481000000
000482000000             ADDMSGD +
000483000000                MSGID(AID003F) +
000484000000                MSGF(&LIB/&OBJ) +
000485000000                MSG( +
000486000000'Taste ''LICHTGRIFFEL'' nicht gültig'                                 +
000487000000                ) +
000488000000                SEV(0) +
000489000000     /*   No replacement variables defined!                         */ +
000490000000                ALROPT(*NO) +
000491000000                CCSID(65535) +
000492000000                /*  -EOF-  */
000493000000
000494000000     /*-------------------------------------------------------------*/
000495000000     /*   Cmd-ADDMSGD für Message-ID :   AID0031                    */
000496000000     /* Funktionstaste F1 nicht gültig.                             */
000497000000     /*-------------------------------------------------------------*/
000498000000
000499000000             RMVMSGD MSGID(AID0031) MSGF(&LIB/&OBJ)
000500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000501000000
000502000000             ADDMSGD +
000503000000                MSGID(AID0031) +
000504000000                MSGF(&LIB/&OBJ) +
000505000000                MSG( +
000506000000'Funktionstaste F1 nicht gültig.'                                     +
000507000000                ) +
000508000000                SEV(0) +
000509000000     /*   No replacement variables defined!                         */ +
000510000000                ALROPT(*NO) +
000511000000                CCSID(65535) +
000512000000                /*  -EOF-  */
000513000000
000514000000     /*-------------------------------------------------------------*/
000515000000     /*   Cmd-ADDMSGD für Message-ID :   AID0032                    */
000516000000     /* Funktionstaste F2 nicht gültig.                             */
000517000000     /*-------------------------------------------------------------*/
000518000000
000519000000             RMVMSGD MSGID(AID0032) MSGF(&LIB/&OBJ)
000520000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000521000000
000522000000             ADDMSGD +
000523000000                MSGID(AID0032) +
000524000000                MSGF(&LIB/&OBJ) +
000525000000                MSG( +
000526000000'Funktionstaste F2 nicht gültig.'                                     +
000527000000                ) +
000528000000                SEV(0) +
000529000000     /*   No replacement variables defined!                         */ +
000530000000                ALROPT(*NO) +
000531000000                CCSID(65535) +
000532000000                /*  -EOF-  */
000533000000
000534000000     /*-------------------------------------------------------------*/
000535000000     /*   Cmd-ADDMSGD für Message-ID :   AID0033                    */
000536000000     /* Funktionstaste F3 nicht gültig.                             */
000537000000     /*-------------------------------------------------------------*/
000538000000
000539000000             RMVMSGD MSGID(AID0033) MSGF(&LIB/&OBJ)
000540000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000541000000
000542000000             ADDMSGD +
000543000000                MSGID(AID0033) +
000544000000                MSGF(&LIB/&OBJ) +
000545000000                MSG( +
000546000000'Funktionstaste F3 nicht gültig.'                                     +
000547000000                ) +
000548000000                SEV(0) +
000549000000     /*   No replacement variables defined!                         */ +
000550000000                ALROPT(*NO) +
000551000000                CCSID(65535) +
000552000000                /*  -EOF-  */
000553000000
000554000000     /*-------------------------------------------------------------*/
000555000000     /*   Cmd-ADDMSGD für Message-ID :   AID0034                    */
000556000000     /* Funktionstaste F4 nicht gültig.                             */
000557000000     /*-------------------------------------------------------------*/
000558000000
000559000000             RMVMSGD MSGID(AID0034) MSGF(&LIB/&OBJ)
000560000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000561000000
000562000000             ADDMSGD +
000563000000                MSGID(AID0034) +
000564000000                MSGF(&LIB/&OBJ) +
000565000000                MSG( +
000566000000'Funktionstaste F4 nicht gültig.'                                     +
000567000000                ) +
000568000000                SEV(0) +
000569000000     /*   No replacement variables defined!                         */ +
000570000000                ALROPT(*NO) +
000571000000                CCSID(65535) +
000572000000                /*  -EOF-  */
000573000000
000574000000     /*-------------------------------------------------------------*/
000575000000     /*   Cmd-ADDMSGD für Message-ID :   AID0035                    */
000576000000     /* Funktionstaste F5 nicht gültig.                             */
000577000000     /*-------------------------------------------------------------*/
000578000000
000579000000             RMVMSGD MSGID(AID0035) MSGF(&LIB/&OBJ)
000580000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000581000000
000582000000             ADDMSGD +
000583000000                MSGID(AID0035) +
000584000000                MSGF(&LIB/&OBJ) +
000585000000                MSG( +
000586000000'Funktionstaste F5 nicht gültig.'                                     +
000587000000                ) +
000588000000                SEV(0) +
000589000000     /*   No replacement variables defined!                         */ +
000590000000                ALROPT(*NO) +
000591000000                CCSID(65535) +
000592000000                /*  -EOF-  */
000593000000
000594000000     /*-------------------------------------------------------------*/
000595000000     /*   Cmd-ADDMSGD für Message-ID :   AID0036                    */
000596000000     /* Funktionstaste F6 nicht gültig.                             */
000597000000     /*-------------------------------------------------------------*/
000598000000
000599000000             RMVMSGD MSGID(AID0036) MSGF(&LIB/&OBJ)
000600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000601000000
000602000000             ADDMSGD +
000603000000                MSGID(AID0036) +
000604000000                MSGF(&LIB/&OBJ) +
000605000000                MSG( +
000606000000'Funktionstaste F6 nicht gültig.'                                     +
000607000000                ) +
000608000000                SEV(0) +
000609000000     /*   No replacement variables defined!                         */ +
000610000000                ALROPT(*NO) +
000611000000                CCSID(65535) +
000612000000                /*  -EOF-  */
000613000000
000614000000     /*-------------------------------------------------------------*/
000615000000     /*   Cmd-ADDMSGD für Message-ID :   AID0037                    */
000616000000     /* Funktionstaste F7 nicht gültig.                             */
000617000000     /*-------------------------------------------------------------*/
000618000000
000619000000             RMVMSGD MSGID(AID0037) MSGF(&LIB/&OBJ)
000620000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000621000000
000622000000             ADDMSGD +
000623000000                MSGID(AID0037) +
000624000000                MSGF(&LIB/&OBJ) +
000625000000                MSG( +
000626000000'Funktionstaste F7 nicht gültig.'                                     +
000627000000                ) +
000628000000                SEV(0) +
000629000000     /*   No replacement variables defined!                         */ +
000630000000                ALROPT(*NO) +
000631000000                CCSID(65535) +
000632000000                /*  -EOF-  */
000633000000
000634000000     /*-------------------------------------------------------------*/
000635000000     /*   Cmd-ADDMSGD für Message-ID :   AID0038                    */
000636000000     /* Funktionstaste F8 nicht gültig.                             */
000637000000     /*-------------------------------------------------------------*/
000638000000
000639000000             RMVMSGD MSGID(AID0038) MSGF(&LIB/&OBJ)
000640000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000641000000
000642000000             ADDMSGD +
000643000000                MSGID(AID0038) +
000644000000                MSGF(&LIB/&OBJ) +
000645000000                MSG( +
000646000000'Funktionstaste F8 nicht gültig.'                                     +
000647000000                ) +
000648000000                SEV(0) +
000649000000     /*   No replacement variables defined!                         */ +
000650000000                ALROPT(*NO) +
000651000000                CCSID(65535) +
000652000000                /*  -EOF-  */
000653000000
000654000000     /*-------------------------------------------------------------*/
000655000000     /*   Cmd-ADDMSGD für Message-ID :   AID0039                    */
000656000000     /* Funktionstaste F9 nicht gültig.                             */
000657000000     /*-------------------------------------------------------------*/
000658000000
000659000000             RMVMSGD MSGID(AID0039) MSGF(&LIB/&OBJ)
000660000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000661000000
000662000000             ADDMSGD +
000663000000                MSGID(AID0039) +
000664000000                MSGF(&LIB/&OBJ) +
000665000000                MSG( +
000666000000'Funktionstaste F9 nicht gültig.'                                     +
000667000000                ) +
000668000000                SEV(0) +
000669000000     /*   No replacement variables defined!                         */ +
000670000000                ALROPT(*NO) +
000671000000                CCSID(65535) +
000672000000                /*  -EOF-  */
000673000000
000674000000     /*-------------------------------------------------------------*/
000675000000     /*   Cmd-ADDMSGD für Message-ID :   AID0100                    */
000676000000     /* Unbekannte und nicht zulässige Taste                        */
000677000000     /*-------------------------------------------------------------*/
000678000000
000679000000             RMVMSGD MSGID(AID0100) MSGF(&LIB/&OBJ)
000680000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000681000000
000682000000             ADDMSGD +
000683000000                MSGID(AID0100) +
000684000000                MSGF(&LIB/&OBJ) +
000685000000                MSG( +
000686000000'Unbekannte und nicht zulässige Taste'                                +
000687000000                ) +
000688000000                SEV(0) +
000689000000     /*   No replacement variables defined!                         */ +
000690000000                ALROPT(*NO) +
000691000000                CCSID(65535) +
000692000000                /*  -EOF-  */
000693000000
000694000000     /*-------------------------------------------------------------*/
000695000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0001                    */
000696000000     /* Datenfreigabe                                               */
000697000000     /*-------------------------------------------------------------*/
000698000000
000699000000             RMVMSGD MSGID(KEY0001) MSGF(&LIB/&OBJ)
000700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000701000000
000702000000             ADDMSGD +
000703000000                MSGID(KEY0001) +
000704000000                MSGF(&LIB/&OBJ) +
000705000000                MSG( +
000706000000'Datenfreigabe     '                                                  +
000707000000                ) +
000708000000                SEV(0) +
000709000000     /*   No replacement variables defined!                         */ +
000710000000                ALROPT(*NO) +
000711000000                CCSID(65535) +
000712000000                /*  -EOF-  */
000713000000
000714000000     /*-------------------------------------------------------------*/
000715000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0002                    */
000716000000     /* Beenden                                                     */
000717000000     /*-------------------------------------------------------------*/
000718000000
000719000000             RMVMSGD MSGID(KEY0002) MSGF(&LIB/&OBJ)
000720000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000721000000
000722000000             ADDMSGD +
000723000000                MSGID(KEY0002) +
000724000000                MSGF(&LIB/&OBJ) +
000725000000                MSG( +
000726000000'Beenden           '                                                  +
000727000000                ) +
000728000000                SEV(0) +
000729000000     /*   No replacement variables defined!                         */ +
000730000000                ALROPT(*NO) +
000731000000                CCSID(65535) +
000732000000                /*  -EOF-  */
000733000000
000734000000     /*-------------------------------------------------------------*/
000735000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0003                    */
000736000000     /* Aktualisieren                                               */
000737000000     /*-------------------------------------------------------------*/
000738000000
000739000000             RMVMSGD MSGID(KEY0003) MSGF(&LIB/&OBJ)
000740000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000741000000
000742000000             ADDMSGD +
000743000000                MSGID(KEY0003) +
000744000000                MSGF(&LIB/&OBJ) +
000745000000                MSG( +
000746000000'Aktualisieren     '                                                  +
000747000000                ) +
000748000000                SEV(0) +
000749000000     /*   No replacement variables defined!                         */ +
000750000000                ALROPT(*NO) +
000751000000                CCSID(65535) +
000752000000                /*  -EOF-  */
000753000000
000754000000     /*-------------------------------------------------------------*/
000755000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0004                    */
000756000000     /* Neuanlage                                                   */
000757000000     /*-------------------------------------------------------------*/
000758000000
000759000000             RMVMSGD MSGID(KEY0004) MSGF(&LIB/&OBJ)
000760000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000761000000
000762000000             ADDMSGD +
000763000000                MSGID(KEY0004) +
000764000000                MSGF(&LIB/&OBJ) +
000765000000                MSG( +
000766000000'Neuanlage         '                                                  +
000767000000                ) +
000768000000                SEV(0) +
000769000000     /*   No replacement variables defined!                         */ +
000770000000                ALROPT(*NO) +
000771000000                CCSID(65535) +
000772000000                /*  -EOF-  */
000773000000
000774000000     /*-------------------------------------------------------------*/
000775000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0005                    */
000776000000     /* Überschrift                                                 */
000777000000     /*-------------------------------------------------------------*/
000778000000
000779000000             RMVMSGD MSGID(KEY0005) MSGF(&LIB/&OBJ)
000780000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000781000000
000782000000             ADDMSGD +
000783000000                MSGID(KEY0005) +
000784000000                MSGF(&LIB/&OBJ) +
000785000000                MSG( +
000786000000'Überschrift       '                                                  +
000787000000                ) +
000788000000                SEV(0) +
000789000000     /*   No replacement variables defined!                         */ +
000790000000                ALROPT(*NO) +
000791000000                CCSID(65535) +
000792000000                /*  -EOF-  */
000793000000
000794000000     /*-------------------------------------------------------------*/
000795000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0006                    */
000796000000     /* Spalte mark.+/-                                             */
000797000000     /*-------------------------------------------------------------*/
000798000000
000799000000             RMVMSGD MSGID(KEY0006) MSGF(&LIB/&OBJ)
000800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000801000000
000802000000             ADDMSGD +
000803000000                MSGID(KEY0006) +
000804000000                MSGF(&LIB/&OBJ) +
000805000000                MSG( +
000806000000'Spalte mark.+/-   '                                                  +
000807000000                ) +
000808000000                SEV(0) +
000809000000     /*   No replacement variables defined!                         */ +
000810000000                ALROPT(*NO) +
000811000000                CCSID(65535) +
000812000000                /*  -EOF-  */
000813000000
000814000000     /*-------------------------------------------------------------*/
000815000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0007                    */
000816000000     /* Nach oben zieh.                                             */
000817000000     /*-------------------------------------------------------------*/
000818000000
000819000000             RMVMSGD MSGID(KEY0007) MSGF(&LIB/&OBJ)
000820000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000821000000
000822000000             ADDMSGD +
000823000000                MSGID(KEY0007) +
000824000000                MSGF(&LIB/&OBJ) +
000825000000                MSG( +
000826000000'Nach oben zieh.   '                                                  +
000827000000                ) +
000828000000                SEV(0) +
000829000000     /*   No replacement variables defined!                         */ +
000830000000                ALROPT(*NO) +
000831000000                CCSID(65535) +
000832000000                /*  -EOF-  */
000833000000
000834000000     /*-------------------------------------------------------------*/
000835000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0008                    */
000836000000     /* Cursor pos.                                                 */
000837000000     /*-------------------------------------------------------------*/
000838000000
000839000000             RMVMSGD MSGID(KEY0008) MSGF(&LIB/&OBJ)
000840000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000841000000
000842000000             ADDMSGD +
000843000000                MSGID(KEY0008) +
000844000000                MSGF(&LIB/&OBJ) +
000845000000                MSG( +
000846000000'Cursor pos.       '                                                  +
000847000000                ) +
000848000000                SEV(0) +
000849000000     /*   No replacement variables defined!                         */ +
000850000000                ALROPT(*NO) +
000851000000                CCSID(65535) +
000852000000                /*  -EOF-  */
000853000000
000854000000     /*-------------------------------------------------------------*/
000855000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0009                    */
000856000000     /* Suchen                                                      */
000857000000     /*-------------------------------------------------------------*/
000858000000
000859000000             RMVMSGD MSGID(KEY0009) MSGF(&LIB/&OBJ)
000860000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000861000000
000862000000             ADDMSGD +
000863000000                MSGID(KEY0009) +
000864000000                MSGF(&LIB/&OBJ) +
000865000000                MSG( +
000866000000'Suchen            '                                                  +
000867000000                ) +
000868000000                SEV(0) +
000869000000     /*   No replacement variables defined!                         */ +
000870000000                ALROPT(*NO) +
000871000000                CCSID(65535) +
000872000000                /*  -EOF-  */
000873000000
000874000000     /*-------------------------------------------------------------*/
000875000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0010                    */
000876000000     /* Anfang                                                      */
000877000000     /*-------------------------------------------------------------*/
000878000000
000879000000             RMVMSGD MSGID(KEY0010) MSGF(&LIB/&OBJ)
000880000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000881000000
000882000000             ADDMSGD +
000883000000                MSGID(KEY0010) +
000884000000                MSGF(&LIB/&OBJ) +
000885000000                MSG( +
000886000000'Anfang            '                                                  +
000887000000                ) +
000888000000                SEV(0) +
000889000000     /*   No replacement variables defined!                         */ +
000890000000                ALROPT(*NO) +
000891000000                CCSID(65535) +
000892000000                /*  -EOF-  */
000893000000
000894000000     /*-------------------------------------------------------------*/
000895000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0011                    */
000896000000     /* Ende                                                        */
000897000000     /*-------------------------------------------------------------*/
000898000000
000899000000             RMVMSGD MSGID(KEY0011) MSGF(&LIB/&OBJ)
000900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000901000000
000902000000             ADDMSGD +
000903000000                MSGID(KEY0011) +
000904000000                MSGF(&LIB/&OBJ) +
000905000000                MSG( +
000906000000'Ende              '                                                  +
000907000000                ) +
000908000000                SEV(0) +
000909000000     /*   No replacement variables defined!                         */ +
000910000000                ALROPT(*NO) +
000911000000                CCSID(65535) +
000912000000                /*  -EOF-  */
000913000000
000914000000     /*-------------------------------------------------------------*/
000915000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0012                    */
000916000000     /* Links                                                       */
000917000000     /*-------------------------------------------------------------*/
000918000000
000919000000             RMVMSGD MSGID(KEY0012) MSGF(&LIB/&OBJ)
000920000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000921000000
000922000000             ADDMSGD +
000923000000                MSGID(KEY0012) +
000924000000                MSGF(&LIB/&OBJ) +
000925000000                MSG( +
000926000000'Links             '                                                  +
000927000000                ) +
000928000000                SEV(0) +
000929000000     /*   No replacement variables defined!                         */ +
000930000000                ALROPT(*NO) +
000931000000                CCSID(65535) +
000932000000                /*  -EOF-  */
000933000000
000934000000     /*-------------------------------------------------------------*/
000935000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0013                    */
000936000000     /* Rechts                                                      */
000937000000     /*-------------------------------------------------------------*/
000938000000
000939000000             RMVMSGD MSGID(KEY0013) MSGF(&LIB/&OBJ)
000940000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000941000000
000942000000             ADDMSGD +
000943000000                MSGID(KEY0013) +
000944000000                MSGF(&LIB/&OBJ) +
000945000000                MSG( +
000946000000'Rechts            '                                                  +
000947000000                ) +
000948000000                SEV(0) +
000949000000     /*   No replacement variables defined!                         */ +
000950000000                ALROPT(*NO) +
000951000000                CCSID(65535) +
000952000000                /*  -EOF-  */
000953000000
000954000000     /*-------------------------------------------------------------*/
000955000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0014                    */
000956000000     /* Befehlszeile                                                */
000957000000     /*-------------------------------------------------------------*/
000958000000
000959000000             RMVMSGD MSGID(KEY0014) MSGF(&LIB/&OBJ)
000960000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000961000000
000962000000             ADDMSGD +
000963000000                MSGID(KEY0014) +
000964000000                MSGF(&LIB/&OBJ) +
000965000000                MSG( +
000966000000'Befehlszeile      '                                                  +
000967000000                ) +
000968000000                SEV(0) +
000969000000     /*   No replacement variables defined!                         */ +
000970000000                ALROPT(*NO) +
000971000000                CCSID(65535) +
000972000000                /*  -EOF-  */
000973000000
000974000000     /*-------------------------------------------------------------*/
000975000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0015                    */
000976000000     /* 80/132 Zeichen                                              */
000977000000     /*-------------------------------------------------------------*/
000978000000
000979000000             RMVMSGD MSGID(KEY0015) MSGF(&LIB/&OBJ)
000980000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000981000000
000982000000             ADDMSGD +
000983000000                MSGID(KEY0015) +
000984000000                MSGF(&LIB/&OBJ) +
000985000000                MSG( +
000986000000'80/132 Zeichen    '                                                  +
000987000000                ) +
000988000000                SEV(0) +
000989000000     /*   No replacement variables defined!                         */ +
000990000000                ALROPT(*NO) +
000991000000                CCSID(65535) +
000992000000                /*  -EOF-  */
000993000000
000994000000     /*-------------------------------------------------------------*/
000995000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0016                    */
000996000000     /* Weitere Tasten                                              */
000997000000     /*-------------------------------------------------------------*/
000998000000
000999000000             RMVMSGD MSGID(KEY0016) MSGF(&LIB/&OBJ)
001000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001001000000
001002000000             ADDMSGD +
001003000000                MSGID(KEY0016) +
001004000000                MSGF(&LIB/&OBJ) +
001005000000                MSG( +
001006000000'Weitere Tasten    '                                                  +
001007000000                ) +
001008000000                SEV(0) +
001009000000     /*   No replacement variables defined!                         */ +
001010000000                ALROPT(*NO) +
001011000000                CCSID(65535) +
001012000000                /*  -EOF-  */
001013000000
001014000000     /*-------------------------------------------------------------*/
001015000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0017                    */
001016000000     /* Bild runter                                                 */
001017000000     /*-------------------------------------------------------------*/
001018000000
001019000000             RMVMSGD MSGID(KEY0017) MSGF(&LIB/&OBJ)
001020000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001021000000
001022000000             ADDMSGD +
001023000000                MSGID(KEY0017) +
001024000000                MSGF(&LIB/&OBJ) +
001025000000                MSG( +
001026000000'Bild runter       '                                                  +
001027000000                ) +
001028000000                SEV(0) +
001029000000     /*   No replacement variables defined!                         */ +
001030000000                ALROPT(*NO) +
001031000000                CCSID(65535) +
001032000000                /*  -EOF-  */
001033000000
001034000000     /*-------------------------------------------------------------*/
001035000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0018                    */
001036000000     /* Bild hoch                                                   */
001037000000     /*-------------------------------------------------------------*/
001038000000
001039000000             RMVMSGD MSGID(KEY0018) MSGF(&LIB/&OBJ)
001040000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001041000000
001042000000             ADDMSGD +
001043000000                MSGID(KEY0018) +
001044000000                MSGF(&LIB/&OBJ) +
001045000000                MSG( +
001046000000'Bild hoch         '                                                  +
001047000000                ) +
001048000000                SEV(0) +
001049000000     /*   No replacement variables defined!                         */ +
001050000000                ALROPT(*NO) +
001051000000                CCSID(65535) +
001052000000                /*  -EOF-  */
001053000000
001054000000     /*-------------------------------------------------------------*/
001055000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0019                    */
001056000000     /* Pin-Zeile                                                   */
001057000000     /*-------------------------------------------------------------*/
001058000000
001059000000             RMVMSGD MSGID(KEY0019) MSGF(&LIB/&OBJ)
001060000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001061000000
001062000000             ADDMSGD +
001063000000                MSGID(KEY0019) +
001064000000                MSGF(&LIB/&OBJ) +
001065000000                MSG( +
001066000000'Pin-Zeile         '                                                  +
001067000000                ) +
001068000000                SEV(0) +
001069000000     /*   No replacement variables defined!                         */ +
001070000000                ALROPT(*NO) +
001071000000                CCSID(65535) +
001072000000                /*  -EOF-  */
001073000000
001074000000     /*-------------------------------------------------------------*/
001075000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0020                    */
001076000000     /* UnPin-Zeile                                                 */
001077000000     /*-------------------------------------------------------------*/
001078000000
001079000000             RMVMSGD MSGID(KEY0020) MSGF(&LIB/&OBJ)
001080000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001081000000
001082000000             ADDMSGD +
001083000000                MSGID(KEY0020) +
001084000000                MSGF(&LIB/&OBJ) +
001085000000                MSG( +
001086000000'UnPin-Zeile       '                                                  +
001087000000                ) +
001088000000                SEV(0) +
001089000000     /*   No replacement variables defined!                         */ +
001090000000                ALROPT(*NO) +
001091000000                CCSID(65535) +
001092000000                /*  -EOF-  */
001093000000
001094000000     /*-------------------------------------------------------------*/
001095000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0021                    */
001096000000     /* Ändern                                                      */
001097000000     /*-------------------------------------------------------------*/
001098000000
001099000000             RMVMSGD MSGID(KEY0021) MSGF(&LIB/&OBJ)
001100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001101000000
001102000000             ADDMSGD +
001103000000                MSGID(KEY0021) +
001104000000                MSGF(&LIB/&OBJ) +
001105000000                MSG( +
001106000000'Ändern            '                                                  +
001107000000                ) +
001108000000                SEV(0) +
001109000000     /*   No replacement variables defined!                         */ +
001110000000                ALROPT(*NO) +
001111000000                CCSID(65535) +
001112000000                /*  -EOF-  */
001113000000
001114000000     /*-------------------------------------------------------------*/
001115000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0022                    */
001116000000     /* Kopieren                                                    */
001117000000     /*-------------------------------------------------------------*/
001118000000
001119000000             RMVMSGD MSGID(KEY0022) MSGF(&LIB/&OBJ)
001120000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001121000000
001122000000             ADDMSGD +
001123000000                MSGID(KEY0022) +
001124000000                MSGF(&LIB/&OBJ) +
001125000000                MSG( +
001126000000'Kopieren          '                                                  +
001127000000                ) +
001128000000                SEV(0) +
001129000000     /*   No replacement variables defined!                         */ +
001130000000                ALROPT(*NO) +
001131000000                CCSID(65535) +
001132000000                /*  -EOF-  */
001133000000
001134000000     /*-------------------------------------------------------------*/
001135000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0023                    */
001136000000     /* Löschen                                                     */
001137000000     /*-------------------------------------------------------------*/
001138000000
001139000000             RMVMSGD MSGID(KEY0023) MSGF(&LIB/&OBJ)
001140000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001141000000
001142000000             ADDMSGD +
001143000000                MSGID(KEY0023) +
001144000000                MSGF(&LIB/&OBJ) +
001145000000                MSG( +
001146000000'Löschen           '                                                  +
001147000000                ) +
001148000000                SEV(0) +
001149000000     /*   No replacement variables defined!                         */ +
001150000000                ALROPT(*NO) +
001151000000                CCSID(65535) +
001152000000                /*  -EOF-  */
001153000000
001154000000     /*-------------------------------------------------------------*/
001155000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0024                    */
001156000000     /* Anzeigen                                                    */
001157000000     /*-------------------------------------------------------------*/
001158000000
001159000000             RMVMSGD MSGID(KEY0024) MSGF(&LIB/&OBJ)
001160000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001161000000
001162000000             ADDMSGD +
001163000000                MSGID(KEY0024) +
001164000000                MSGF(&LIB/&OBJ) +
001165000000                MSG( +
001166000000'Anzeigen          '                                                  +
001167000000                ) +
001168000000                SEV(0) +
001169000000     /*   No replacement variables defined!                         */ +
001170000000                ALROPT(*NO) +
001171000000                CCSID(65535) +
001172000000                /*  -EOF-  */
001173000000
001174000000     /*-------------------------------------------------------------*/
001175000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0025                    */
001176000000     /* Einstellungen                                               */
001177000000     /*-------------------------------------------------------------*/
001178000000
001179000000             RMVMSGD MSGID(KEY0025) MSGF(&LIB/&OBJ)
001180000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001181000000
001182000000             ADDMSGD +
001183000000                MSGID(KEY0025) +
001184000000                MSGF(&LIB/&OBJ) +
001185000000                MSG( +
001186000000'Einstellungen'                                                       +
001187000000                ) +
001188000000                SEV(0) +
001189000000     /*   No replacement variables defined!                         */ +
001190000000                ALROPT(*NO) +
001191000000                CCSID(65535) +
001192000000                /*  -EOF-  */
001193000000
001194000000     /*-------------------------------------------------------------*/
001195000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0026                    */
001196000000     /* Abbrechen                                                   */
001197000000     /*-------------------------------------------------------------*/
001198000000
001199000000             RMVMSGD MSGID(KEY0026) MSGF(&LIB/&OBJ)
001200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001201000000
001202000000             ADDMSGD +
001203000000                MSGID(KEY0026) +
001204000000                MSGF(&LIB/&OBJ) +
001205000000                MSG( +
001206000000'Abbrechen'                                                           +
001207000000                ) +
001208000000                SEV(0) +
001209000000     /*   No replacement variables defined!                         */ +
001210000000                ALROPT(*NO) +
001211000000                CCSID(65535) +
001212000000                /*  -EOF-  */
001213000000
001214000000     /*-------------------------------------------------------------*/
001215000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0027                    */
001216000000     /* Sich. & Ende                                                */
001217000000     /*-------------------------------------------------------------*/
001218000000
001219000000             RMVMSGD MSGID(KEY0027) MSGF(&LIB/&OBJ)
001220000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001221000000
001222000000             ADDMSGD +
001223000000                MSGID(KEY0027) +
001224000000                MSGF(&LIB/&OBJ) +
001225000000                MSG( +
001226000000'Sich. & Ende'                                                        +
001227000000                ) +
001228000000                SEV(0) +
001229000000     /*   No replacement variables defined!                         */ +
001230000000                ALROPT(*NO) +
001231000000                CCSID(65535) +
001232000000                /*  -EOF-  */
001233000000
001234000000     /*-------------------------------------------------------------*/
001235000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0028                    */
001236000000     /* Pin-Spalte                                                  */
001237000000     /*-------------------------------------------------------------*/
001238000000
001239000000             RMVMSGD MSGID(KEY0028) MSGF(&LIB/&OBJ)
001240000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001241000000
001242000000             ADDMSGD +
001243000000                MSGID(KEY0028) +
001244000000                MSGF(&LIB/&OBJ) +
001245000000                MSG( +
001246000000'Pin-Spalte'                                                          +
001247000000                ) +
001248000000                SEV(0) +
001249000000     /*   No replacement variables defined!                         */ +
001250000000                ALROPT(*NO) +
001251000000                CCSID(65535) +
001252000000                /*  -EOF-  */
001253000000
001254000000     /*-------------------------------------------------------------*/
001255000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0029                    */
001256000000     /* UnPin-Spalte                                                */
001257000000     /*-------------------------------------------------------------*/
001258000000
001259000000             RMVMSGD MSGID(KEY0029) MSGF(&LIB/&OBJ)
001260000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001261000000
001262000000             ADDMSGD +
001263000000                MSGID(KEY0029) +
001264000000                MSGF(&LIB/&OBJ) +
001265000000                MSG( +
001266000000'UnPin-Spalte'                                                        +
001267000000                ) +
001268000000                SEV(0) +
001269000000     /*   No replacement variables defined!                         */ +
001270000000                ALROPT(*NO) +
001271000000                CCSID(65535) +
001272000000                /*  -EOF-  */
001273000000
001274000000     /*-------------------------------------------------------------*/
001275000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0030                    */
001276000000     /* Pin-Spalte +/-                                              */
001277000000     /*-------------------------------------------------------------*/
001278000000
001279000000             RMVMSGD MSGID(KEY0030) MSGF(&LIB/&OBJ)
001280000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001281000000
001282000000             ADDMSGD +
001283000000                MSGID(KEY0030) +
001284000000                MSGF(&LIB/&OBJ) +
001285000000                MSG( +
001286000000'Pin-Spalte +/-'                                                      +
001287000000                ) +
001288000000                SEV(0) +
001289000000     /*   No replacement variables defined!                         */ +
001290000000                ALROPT(*NO) +
001291000000                CCSID(65535) +
001292000000                /*  -EOF-  */
001293000000
001294000000     /*-------------------------------------------------------------*/
001295000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0031                    */
001296000000     /* Tab.Papier Ein                                              */
001297000000     /*-------------------------------------------------------------*/
001298000000
001299000000             RMVMSGD MSGID(KEY0031) MSGF(&LIB/&OBJ)
001300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001301000000
001302000000             ADDMSGD +
001303000000                MSGID(KEY0031) +
001304000000                MSGF(&LIB/&OBJ) +
001305000000                MSG( +
001306000000'Tab.Papier Ein'                                                      +
001307000000                ) +
001308000000                SEV(0) +
001309000000     /*   No replacement variables defined!                         */ +
001310000000                ALROPT(*NO) +
001311000000                CCSID(65535) +
001312000000                /*  -EOF-  */
001313000000
001314000000     /*-------------------------------------------------------------*/
001315000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0032                    */
001316000000     /* Tab.Papier aus                                              */
001317000000     /*-------------------------------------------------------------*/
001318000000
001319000000             RMVMSGD MSGID(KEY0032) MSGF(&LIB/&OBJ)
001320000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001321000000
001322000000             ADDMSGD +
001323000000                MSGID(KEY0032) +
001324000000                MSGF(&LIB/&OBJ) +
001325000000                MSG( +
001326000000'Tab.Papier aus'                                                      +
001327000000                ) +
001328000000                SEV(0) +
001329000000     /*   No replacement variables defined!                         */ +
001330000000                ALROPT(*NO) +
001331000000                CCSID(65535) +
001332000000                /*  -EOF-  */
001333000000
001334000000     /*-------------------------------------------------------------*/
001335000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0033                    */
001336000000     /* Tab.Papier +/-                                              */
001337000000     /*-------------------------------------------------------------*/
001338000000
001339000000             RMVMSGD MSGID(KEY0033) MSGF(&LIB/&OBJ)
001340000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001341000000
001342000000             ADDMSGD +
001343000000                MSGID(KEY0033) +
001344000000                MSGF(&LIB/&OBJ) +
001345000000                MSG( +
001346000000'Tab.Papier +/-'                                                      +
001347000000                ) +
001348000000                SEV(0) +
001349000000     /*   No replacement variables defined!                         */ +
001350000000                ALROPT(*NO) +
001351000000                CCSID(65535) +
001352000000                /*  -EOF-  */
001353000000
001354000000     /*-------------------------------------------------------------*/
001355000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0034                    */
001356000000     /* Alle Datensätze                                             */
001357000000     /*-------------------------------------------------------------*/
001358000000
001359000000             RMVMSGD MSGID(KEY0034) MSGF(&LIB/&OBJ)
001360000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001361000000
001362000000             ADDMSGD +
001363000000                MSGID(KEY0034) +
001364000000                MSGF(&LIB/&OBJ) +
001365000000                MSG( +
001366000000'Alle Datensätze'                                                     +
001367000000                ) +
001368000000                SEV(0) +
001369000000     /*   No replacement variables defined!                         */ +
001370000000                ALROPT(*NO) +
001371000000                CCSID(65535) +
001372000000                /*  -EOF-  */
001373000000
001374000000     /*-------------------------------------------------------------*/
001375000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0035                    */
001376000000     /* Weitere Ausw.                                               */
001377000000     /*-------------------------------------------------------------*/
001378000000
001379000000             RMVMSGD MSGID(KEY0035) MSGF(&LIB/&OBJ)
001380000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001381000000
001382000000             ADDMSGD +
001383000000                MSGID(KEY0035) +
001384000000                MSGF(&LIB/&OBJ) +
001385000000                MSG( +
001386000000'Weitere Ausw.'                                                       +
001387000000                ) +
001388000000                SEV(0) +
001389000000     /*   No replacement variables defined!                         */ +
001390000000                ALROPT(*NO) +
001391000000                CCSID(65535) +
001392000000                /*  -EOF-  */
001393000000
001394000000     /*-------------------------------------------------------------*/
001395000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0036                    */
001396000000     /* ext. Kopieren                                               */
001397000000     /*-------------------------------------------------------------*/
001398000000
001399000000             RMVMSGD MSGID(KEY0036) MSGF(&LIB/&OBJ)
001400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001401000000
001402000000             ADDMSGD +
001403000000                MSGID(KEY0036) +
001404000000                MSGF(&LIB/&OBJ) +
001405000000                MSG( +
001406000000'ext. Kopieren'                                                       +
001407000000                ) +
001408000000                SEV(0) +
001409000000     /*   No replacement variables defined!                         */ +
001410000000                ALROPT(*NO) +
001411000000                CCSID(65535) +
001412000000                /*  -EOF-  */
001413000000
001414000000     /*-------------------------------------------------------------*/
001415000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0037                    */
001416000000     /* Spalte mark.                                                */
001417000000     /*-------------------------------------------------------------*/
001418000000
001419000000             RMVMSGD MSGID(KEY0037) MSGF(&LIB/&OBJ)
001420000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001421000000
001422000000             ADDMSGD +
001423000000                MSGID(KEY0037) +
001424000000                MSGF(&LIB/&OBJ) +
001425000000                MSG( +
001426000000'Spalte mark.'                                                        +
001427000000                ) +
001428000000                SEV(0) +
001429000000     /*   No replacement variables defined!                         */ +
001430000000                ALROPT(*NO) +
001431000000                CCSID(65535) +
001432000000                /*  -EOF-  */
001433000000
001434000000     /*-------------------------------------------------------------*/
001435000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0038                    */
001436000000     /* Splt.Mark.aufh.                                             */
001437000000     /*-------------------------------------------------------------*/
001438000000
001439000000             RMVMSGD MSGID(KEY0038) MSGF(&LIB/&OBJ)
001440000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001441000000
001442000000             ADDMSGD +
001443000000                MSGID(KEY0038) +
001444000000                MSGF(&LIB/&OBJ) +
001445000000                MSG( +
001446000000'Splt.Mark.aufh.'                                                     +
001447000000                ) +
001448000000                SEV(0) +
001449000000     /*   No replacement variables defined!                         */ +
001450000000                ALROPT(*NO) +
001451000000                CCSID(65535) +
001452000000                /*  -EOF-  */
001453000000
001454000000     /*-------------------------------------------------------------*/
001455000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0039                    */
001456000000     /* Kleinbuchstaben                                             */
001457000000     /*-------------------------------------------------------------*/
001458000000
001459000000             RMVMSGD MSGID(KEY0039) MSGF(&LIB/&OBJ)
001460000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001461000000
001462000000             ADDMSGD +
001463000000                MSGID(KEY0039) +
001464000000                MSGF(&LIB/&OBJ) +
001465000000                MSG( +
001466000000'Kleinbuchstaben'                                                     +
001467000000                ) +
001468000000                SEV(0) +
001469000000     /*   No replacement variables defined!                         */ +
001470000000                ALROPT(*NO) +
001471000000                CCSID(65535) +
001472000000                /*  -EOF-  */
001473000000
001474000000     /*-------------------------------------------------------------*/
001475000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0040                    */
001476000000     /* Großbuchstaben                                              */
001477000000     /*-------------------------------------------------------------*/
001478000000
001479000000             RMVMSGD MSGID(KEY0040) MSGF(&LIB/&OBJ)
001480000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001481000000
001482000000             ADDMSGD +
001483000000                MSGID(KEY0040) +
001484000000                MSGF(&LIB/&OBJ) +
001485000000                MSG( +
001486000000'Großbuchstaben'                                                      +
001487000000                ) +
001488000000                SEV(0) +
001489000000     /*   No replacement variables defined!                         */ +
001490000000                ALROPT(*NO) +
001491000000                CCSID(65535) +
001492000000                /*  -EOF-  */
001493000000
001494000000     /*-------------------------------------------------------------*/
001495000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0041                    */
001496000000     /* Klein/Großb.+/-                                             */
001497000000     /*-------------------------------------------------------------*/
001498000000
001499000000             RMVMSGD MSGID(KEY0041) MSGF(&LIB/&OBJ)
001500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001501000000
001502000000             ADDMSGD +
001503000000                MSGID(KEY0041) +
001504000000                MSGF(&LIB/&OBJ) +
001505000000                MSG( +
001506000000'Klein/Großb.+/-'                                                     +
001507000000                ) +
001508000000                SEV(0) +
001509000000     /*   No replacement variables defined!                         */ +
001510000000                ALROPT(*NO) +
001511000000                CCSID(65535) +
001512000000                /*  -EOF-  */
001513000000
001514000000     /*-------------------------------------------------------------*/
001515000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0042                    */
001516000000     /* Splash-Ein                                                  */
001517000000     /*-------------------------------------------------------------*/
001518000000
001519000000             RMVMSGD MSGID(KEY0042) MSGF(&LIB/&OBJ)
001520000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001521000000
001522000000             ADDMSGD +
001523000000                MSGID(KEY0042) +
001524000000                MSGF(&LIB/&OBJ) +
001525000000                MSG( +
001526000000'Splash-Ein'                                                          +
001527000000                ) +
001528000000                SEV(0) +
001529000000     /*   No replacement variables defined!                         */ +
001530000000                ALROPT(*NO) +
001531000000                CCSID(65535) +
001532000000                /*  -EOF-  */
001533000000
001534000000     /*-------------------------------------------------------------*/
001535000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0043                    */
001536000000     /* Splash-Aus                                                  */
001537000000     /*-------------------------------------------------------------*/
001538000000
001539000000             RMVMSGD MSGID(KEY0043) MSGF(&LIB/&OBJ)
001540000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001541000000
001542000000             ADDMSGD +
001543000000                MSGID(KEY0043) +
001544000000                MSGF(&LIB/&OBJ) +
001545000000                MSG( +
001546000000'Splash-Aus'                                                          +
001547000000                ) +
001548000000                SEV(0) +
001549000000     /*   No replacement variables defined!                         */ +
001550000000                ALROPT(*NO) +
001551000000                CCSID(65535) +
001552000000                /*  -EOF-  */
001553000000
001554000000     /*-------------------------------------------------------------*/
001555000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0044                    */
001556000000     /* Seite links                                                 */
001557000000     /*-------------------------------------------------------------*/
001558000000
001559000000             RMVMSGD MSGID(KEY0044) MSGF(&LIB/&OBJ)
001560000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001561000000
001562000000             ADDMSGD +
001563000000                MSGID(KEY0044) +
001564000000                MSGF(&LIB/&OBJ) +
001565000000                MSG( +
001566000000'Seite links'                                                         +
001567000000                ) +
001568000000                SEV(0) +
001569000000     /*   No replacement variables defined!                         */ +
001570000000                ALROPT(*NO) +
001571000000                CCSID(65535) +
001572000000                /*  -EOF-  */
001573000000
001574000000     /*-------------------------------------------------------------*/
001575000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0045                    */
001576000000     /* Seite rechts                                                */
001577000000     /*-------------------------------------------------------------*/
001578000000
001579000000             RMVMSGD MSGID(KEY0045) MSGF(&LIB/&OBJ)
001580000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001581000000
001582000000             ADDMSGD +
001583000000                MSGID(KEY0045) +
001584000000                MSGF(&LIB/&OBJ) +
001585000000                MSG( +
001586000000'Seite rechts'                                                        +
001587000000                ) +
001588000000                SEV(0) +
001589000000     /*   No replacement variables defined!                         */ +
001590000000                ALROPT(*NO) +
001591000000                CCSID(65535) +
001592000000                /*  -EOF-  */
001593000000
001594000000     /*-------------------------------------------------------------*/
001595000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0046                    */
001596000000     /* Wiederholen                                                 */
001597000000     /*-------------------------------------------------------------*/
001598000000
001599000000             RMVMSGD MSGID(KEY0046) MSGF(&LIB/&OBJ)
001600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001601000000
001602000000             ADDMSGD +
001603000000                MSGID(KEY0046) +
001604000000                MSGF(&LIB/&OBJ) +
001605000000                MSG( +
001606000000'Wiederholen'                                                         +
001607000000                ) +
001608000000                SEV(0) +
001609000000     /*   No replacement variables defined!                         */ +
001610000000                ALROPT(*NO) +
001611000000                CCSID(65535) +
001612000000                /*  -EOF-  */
001613000000
001614000000     /*-------------------------------------------------------------*/
001615000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0047                    */
001616000000     /* Neuerstellung                                               */
001617000000     /*-------------------------------------------------------------*/
001618000000
001619000000             RMVMSGD MSGID(KEY0047) MSGF(&LIB/&OBJ)
001620000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001621000000
001622000000             ADDMSGD +
001623000000                MSGID(KEY0047) +
001624000000                MSGF(&LIB/&OBJ) +
001625000000                MSG( +
001626000000'Neuerstellung'                                                       +
001627000000                ) +
001628000000                SEV(0) +
001629000000     /*   No replacement variables defined!                         */ +
001630000000                ALROPT(*NO) +
001631000000                CCSID(65535) +
001632000000                /*  -EOF-  */
001633000000
001634000000     /*-------------------------------------------------------------*/
001635000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0048                    */
001636000000     /* UnPin Zeilen                                                */
001637000000     /*-------------------------------------------------------------*/
001638000000
001639000000             RMVMSGD MSGID(KEY0048) MSGF(&LIB/&OBJ)
001640000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001641000000
001642000000             ADDMSGD +
001643000000                MSGID(KEY0048) +
001644000000                MSGF(&LIB/&OBJ) +
001645000000                MSG( +
001646000000'UnPin Zeilen'                                                        +
001647000000                ) +
001648000000                SEV(0) +
001649000000     /*   No replacement variables defined!                         */ +
001650000000                ALROPT(*NO) +
001651000000                CCSID(65535) +
001652000000                /*  -EOF-  */
001653000000
001654000000     /*-------------------------------------------------------------*/
001655000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0049                    */
001656000000     /* UnPin Spalten                                               */
001657000000     /*-------------------------------------------------------------*/
001658000000
001659000000             RMVMSGD MSGID(KEY0049) MSGF(&LIB/&OBJ)
001660000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001661000000
001662000000             ADDMSGD +
001663000000                MSGID(KEY0049) +
001664000000                MSGF(&LIB/&OBJ) +
001665000000                MSG( +
001666000000'UnPin Spalten'                                                       +
001667000000                ) +
001668000000                SEV(0) +
001669000000     /*   No replacement variables defined!                         */ +
001670000000                ALROPT(*NO) +
001671000000                CCSID(65535) +
001672000000                /*  -EOF-  */
001673000000
001674000000     /*-------------------------------------------------------------*/
001675000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0050                    */
001676000000     /* Layout                                                      */
001677000000     /*-------------------------------------------------------------*/
001678000000
001679000000             RMVMSGD MSGID(KEY0050) MSGF(&LIB/&OBJ)
001680000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001681000000
001682000000             ADDMSGD +
001683000000                MSGID(KEY0050) +
001684000000                MSGF(&LIB/&OBJ) +
001685000000                MSG( +
001686000000'Layout'                                                              +
001687000000                ) +
001688000000                SEV(0) +
001689000000     /*   No replacement variables defined!                         */ +
001690000000                ALROPT(*NO) +
001691000000                CCSID(65535) +
001692000000                /*  -EOF-  */
001693000000
001694000000     /*-------------------------------------------------------------*/
001695000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0051                    */
001696000000     /* Key-Felder                                                  */
001697000000     /*-------------------------------------------------------------*/
001698000000
001699000000             RMVMSGD MSGID(KEY0051) MSGF(&LIB/&OBJ)
001700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001701000000
001702000000             ADDMSGD +
001703000000                MSGID(KEY0051) +
001704000000                MSGF(&LIB/&OBJ) +
001705000000                MSG( +
001706000000'Key-Felder'                                                          +
001707000000                ) +
001708000000                SEV(0) +
001709000000     /*   No replacement variables defined!                         */ +
001710000000                ALROPT(*NO) +
001711000000                CCSID(65535) +
001712000000                /*  -EOF-  */
001713000000
001714000000     /*-------------------------------------------------------------*/
001715000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0052                    */
001716000000     /* Auswahl                                                     */
001717000000     /*-------------------------------------------------------------*/
001718000000
001719000000             RMVMSGD MSGID(KEY0052) MSGF(&LIB/&OBJ)
001720000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001721000000
001722000000             ADDMSGD +
001723000000                MSGID(KEY0052) +
001724000000                MSGF(&LIB/&OBJ) +
001725000000                MSG( +
001726000000'Auswahl'                                                             +
001727000000                ) +
001728000000                SEV(0) +
001729000000     /*   No replacement variables defined!                         */ +
001730000000                ALROPT(*NO) +
001731000000                CCSID(65535) +
001732000000                /*  -EOF-  */
001733000000
001734000000     /*-------------------------------------------------------------*/
001735000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0053                    */
001736000000     /* Nächste Mark.                                               */
001737000000     /*-------------------------------------------------------------*/
001738000000
001739000000             RMVMSGD MSGID(KEY0053) MSGF(&LIB/&OBJ)
001740000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001741000000
001742000000             ADDMSGD +
001743000000                MSGID(KEY0053) +
001744000000                MSGF(&LIB/&OBJ) +
001745000000                MSG( +
001746000000'Nächste Mark.'                                                       +
001747000000                ) +
001748000000                SEV(0) +
001749000000     /*   No replacement variables defined!                         */ +
001750000000                ALROPT(*NO) +
001751000000                CCSID(65535) +
001752000000                /*  -EOF-  */
001753000000
001754000000     /*-------------------------------------------------------------*/
001755000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0054                    */
001756000000     /* Vorherige Mark.                                             */
001757000000     /*-------------------------------------------------------------*/
001758000000
001759000000             RMVMSGD MSGID(KEY0054) MSGF(&LIB/&OBJ)
001760000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001761000000
001762000000             ADDMSGD +
001763000000                MSGID(KEY0054) +
001764000000                MSGF(&LIB/&OBJ) +
001765000000                MSG( +
001766000000'Vorherige Mark.'                                                     +
001767000000                ) +
001768000000                SEV(0) +
001769000000     /*   No replacement variables defined!                         */ +
001770000000                ALROPT(*NO) +
001771000000                CCSID(65535) +
001772000000                /*  -EOF-  */
001773000000
001774000000     /*-------------------------------------------------------------*/
001775000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0055                    */
001776000000     /* Relationen                                                  */
001777000000     /*-------------------------------------------------------------*/
001778000000
001779000000             RMVMSGD MSGID(KEY0055) MSGF(&LIB/&OBJ)
001780000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001781000000
001782000000             ADDMSGD +
001783000000                MSGID(KEY0055) +
001784000000                MSGF(&LIB/&OBJ) +
001785000000                MSG( +
001786000000'Relationen'                                                          +
001787000000                ) +
001788000000                SEV(0) +
001789000000     /*   No replacement variables defined!                         */ +
001790000000                ALROPT(*NO) +
001791000000                CCSID(65535) +
001792000000                /*  -EOF-  */
001793000000
001794000000     /*-------------------------------------------------------------*/
001795000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0056                    */
001796000000     /* Bedienerführung                                             */
001797000000     /*-------------------------------------------------------------*/
001798000000
001799000000             RMVMSGD MSGID(KEY0056) MSGF(&LIB/&OBJ)
001800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001801000000
001802000000             ADDMSGD +
001803000000                MSGID(KEY0056) +
001804000000                MSGF(&LIB/&OBJ) +
001805000000                MSG( +
001806000000'Bedienerführung'                                                     +
001807000000                ) +
001808000000                SEV(0) +
001809000000     /*   No replacement variables defined!                         */ +
001810000000                ALROPT(*NO) +
001811000000                CCSID(65535) +
001812000000                /*  -EOF-  */
001813000000
001814000000     /*-------------------------------------------------------------*/
001815000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0057                    */
001816000000     /* Schlüsselfolge                                              */
001817000000     /*-------------------------------------------------------------*/
001818000000
001819000000             RMVMSGD MSGID(KEY0057) MSGF(&LIB/&OBJ)
001820000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001821000000
001822000000             ADDMSGD +
001823000000                MSGID(KEY0057) +
001824000000                MSGF(&LIB/&OBJ) +
001825000000                MSG( +
001826000000'Schlüsselfolge'                                                      +
001827000000                ) +
001828000000                SEV(0) +
001829000000     /*   No replacement variables defined!                         */ +
001830000000                ALROPT(*NO) +
001831000000                CCSID(65535) +
001832000000                /*  -EOF-  */
001833000000
001834000000     /*-------------------------------------------------------------*/
001835000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0058                    */
001836000000     /* Satzfolge                                                   */
001837000000     /*-------------------------------------------------------------*/
001838000000
001839000000             RMVMSGD MSGID(KEY0058) MSGF(&LIB/&OBJ)
001840000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001841000000
001842000000             ADDMSGD +
001843000000                MSGID(KEY0058) +
001844000000                MSGF(&LIB/&OBJ) +
001845000000                MSG( +
001846000000'Satzfolge'                                                           +
001847000000                ) +
001848000000                SEV(0) +
001849000000     /*   No replacement variables defined!                         */ +
001850000000                ALROPT(*NO) +
001851000000                CCSID(65535) +
001852000000                /*  -EOF-  */
001853000000
001854000000     /*-------------------------------------------------------------*/
001855000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0059                    */
001856000000     /* Key/RRN                                                     */
001857000000     /*-------------------------------------------------------------*/
001858000000
001859000000             RMVMSGD MSGID(KEY0059) MSGF(&LIB/&OBJ)
001860000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001861000000
001862000000             ADDMSGD +
001863000000                MSGID(KEY0059) +
001864000000                MSGF(&LIB/&OBJ) +
001865000000                MSG( +
001866000000'Key/RRN'                                                             +
001867000000                ) +
001868000000                SEV(0) +
001869000000     /*   No replacement variables defined!                         */ +
001870000000                ALROPT(*NO) +
001871000000                CCSID(65535) +
001872000000                /*  -EOF-  */
001873000000
001874000000     /*-------------------------------------------------------------*/
001875000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0060                    */
001876000000     /* Hex-Edit                                                    */
001877000000     /*-------------------------------------------------------------*/
001878000000
001879000000             RMVMSGD MSGID(KEY0060) MSGF(&LIB/&OBJ)
001880000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001881000000
001882000000             ADDMSGD +
001883000000                MSGID(KEY0060) +
001884000000                MSGF(&LIB/&OBJ) +
001885000000                MSG( +
001886000000'Hex-Edit'                                                            +
001887000000                ) +
001888000000                SEV(0) +
001889000000     /*   No replacement variables defined!                         */ +
001890000000                ALROPT(*NO) +
001891000000                CCSID(65535) +
001892000000                /*  -EOF-  */
001893000000
001894000000     /*-------------------------------------------------------------*/
001895000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0061                    */
001896000000     /* Info                                                        */
001897000000     /*-------------------------------------------------------------*/
001898000000
001899000000             RMVMSGD MSGID(KEY0061) MSGF(&LIB/&OBJ)
001900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001901000000
001902000000             ADDMSGD +
001903000000                MSGID(KEY0061) +
001904000000                MSGF(&LIB/&OBJ) +
001905000000                MSG( +
001906000000'Info'                                                                +
001907000000                ) +
001908000000                SEV(0) +
001909000000     /*   No replacement variables defined!                         */ +
001910000000                ALROPT(*NO) +
001911000000                CCSID(65535) +
001912000000                /*  -EOF-  */
001913000000
001914000000     /*-------------------------------------------------------------*/
001915000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0062                    */
001916000000     /* Spalten pinnen                                              */
001917000000     /*-------------------------------------------------------------*/
001918000000
001919000000             RMVMSGD MSGID(KEY0062) MSGF(&LIB/&OBJ)
001920000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001921000000
001922000000             ADDMSGD +
001923000000                MSGID(KEY0062) +
001924000000                MSGF(&LIB/&OBJ) +
001925000000                MSG( +
001926000000'Spalten pinnen'                                                      +
001927000000                ) +
001928000000                SEV(0) +
001929000000     /*   No replacement variables defined!                         */ +
001930000000                ALROPT(*NO) +
001931000000                CCSID(65535) +
001932000000                /*  -EOF-  */
001933000000
001934000000     /*-------------------------------------------------------------*/
001935000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0063                    */
001936000000     /* Alles Löschen                                               */
001937000000     /*-------------------------------------------------------------*/
001938000000
001939000000             RMVMSGD MSGID(KEY0063) MSGF(&LIB/&OBJ)
001940000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001941000000
001942000000             ADDMSGD +
001943000000                MSGID(KEY0063) +
001944000000                MSGF(&LIB/&OBJ) +
001945000000                MSG( +
001946000000'Alles Löschen'                                                       +
001947000000                ) +
001948000000                SEV(0) +
001949000000     /*   No replacement variables defined!                         */ +
001950000000                ALROPT(*NO) +
001951000000                CCSID(65535) +
001952000000                /*  -EOF-  */
001953000000
001954000000     /*-------------------------------------------------------------*/
001955000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0064                    */
001956000000     /* Norm. Anzeige                                               */
001957000000     /*-------------------------------------------------------------*/
001958000000
001959000000             RMVMSGD MSGID(KEY0064) MSGF(&LIB/&OBJ)
001960000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001961000000
001962000000             ADDMSGD +
001963000000                MSGID(KEY0064) +
001964000000                MSGF(&LIB/&OBJ) +
001965000000                MSG( +
001966000000'Norm. Anzeige'                                                       +
001967000000                ) +
001968000000                SEV(0) +
001969000000     /*   No replacement variables defined!                         */ +
001970000000                ALROPT(*NO) +
001971000000                CCSID(65535) +
001972000000                /*  -EOF-  */
001973000000
001974000000     /*-------------------------------------------------------------*/
001975000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0065                    */
001976000000     /* Hex-Anzeige                                                 */
001977000000     /*-------------------------------------------------------------*/
001978000000
001979000000             RMVMSGD MSGID(KEY0065) MSGF(&LIB/&OBJ)
001980000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001981000000
001982000000             ADDMSGD +
001983000000                MSGID(KEY0065) +
001984000000                MSGF(&LIB/&OBJ) +
001985000000                MSG( +
001986000000'Hex-Anzeige'                                                         +
001987000000                ) +
001988000000                SEV(0) +
001989000000     /*   No replacement variables defined!                         */ +
001990000000                ALROPT(*NO) +
001991000000                CCSID(65535) +
001992000000                /*  -EOF-  */
001993000000
001994000000     /*-------------------------------------------------------------*/
001995000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0066                    */
001996000000     /* Umsch.Anzeige                                               */
001997000000     /*-------------------------------------------------------------*/
001998000000
001999000000             RMVMSGD MSGID(KEY0066) MSGF(&LIB/&OBJ)
002000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002001000000
002002000000             ADDMSGD +
002003000000                MSGID(KEY0066) +
002004000000                MSGF(&LIB/&OBJ) +
002005000000                MSG( +
002006000000'Umsch.Anzeige'                                                       +
002007000000                ) +
002008000000                SEV(0) +
002009000000     /*   No replacement variables defined!                         */ +
002010000000                ALROPT(*NO) +
002011000000                CCSID(65535) +
002012000000                /*  -EOF-  */
002013000000
002014000000     /*-------------------------------------------------------------*/
002015000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0067                    */
002016000000     /* SQL-Auswahl                                                 */
002017000000     /*-------------------------------------------------------------*/
002018000000
002019000000             RMVMSGD MSGID(KEY0067) MSGF(&LIB/&OBJ)
002020000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002021000000
002022000000             ADDMSGD +
002023000000                MSGID(KEY0067) +
002024000000                MSGF(&LIB/&OBJ) +
002025000000                MSG( +
002026000000'SQL-Auswahl'                                                         +
002027000000                ) +
002028000000                SEV(0) +
002029000000     /*   No replacement variables defined!                         */ +
002030000000                ALROPT(*NO) +
002031000000                CCSID(65535) +
002032000000                /*  -EOF-  */
002033000000
002034000000     /*-------------------------------------------------------------*/
002035000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0068                    */
002036000000     /* Einf.Schl.Fld.                                              */
002037000000     /*-------------------------------------------------------------*/
002038000000
002039000000             RMVMSGD MSGID(KEY0068) MSGF(&LIB/&OBJ)
002040000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002041000000
002042000000             ADDMSGD +
002043000000                MSGID(KEY0068) +
002044000000                MSGF(&LIB/&OBJ) +
002045000000                MSG( +
002046000000'Einf.Schl.Fld.'                                                      +
002047000000                ) +
002048000000                SEV(0) +
002049000000     /*   No replacement variables defined!                         */ +
002050000000                ALROPT(*NO) +
002051000000                CCSID(65535) +
002052000000                /*  -EOF-  */
002053000000
002054000000     /*-------------------------------------------------------------*/
002055000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0069                    */
002056000000     /* Sichern Arbeitsumgebung                                     */
002057000000     /*-------------------------------------------------------------*/
002058000000
002059000000             RMVMSGD MSGID(KEY0069) MSGF(&LIB/&OBJ)
002060000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002061000000
002062000000             ADDMSGD +
002063000000                MSGID(KEY0069) +
002064000000                MSGF(&LIB/&OBJ) +
002065000000                MSG( +
002066000000'Sichern Arbeitsumgebung'                                             +
002067000000                ) +
002068000000                SEV(0) +
002069000000     /*   No replacement variables defined!                         */ +
002070000000                ALROPT(*NO) +
002071000000                CCSID(65535) +
002072000000                /*  -EOF-  */
002073000000
002074000000     /*-------------------------------------------------------------*/
002075000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0070                    */
002076000000     /* Laden Arbeitsumgebung                                       */
002077000000     /*-------------------------------------------------------------*/
002078000000
002079000000             RMVMSGD MSGID(KEY0070) MSGF(&LIB/&OBJ)
002080000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002081000000
002082000000             ADDMSGD +
002083000000                MSGID(KEY0070) +
002084000000                MSGF(&LIB/&OBJ) +
002085000000                MSG( +
002086000000'Laden Arbeitsumgebung'                                               +
002087000000                ) +
002088000000                SEV(0) +
002089000000     /*   No replacement variables defined!                         */ +
002090000000                ALROPT(*NO) +
002091000000                CCSID(65535) +
002092000000                /*  -EOF-  */
002093000000
002094000000     /*-------------------------------------------------------------*/
002095000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0071                    */
002096000000     /* Löschen Arb.Umg                                             */
002097000000     /*-------------------------------------------------------------*/
002098000000
002099000000             RMVMSGD MSGID(KEY0071) MSGF(&LIB/&OBJ)
002100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002101000000
002102000000             ADDMSGD +
002103000000                MSGID(KEY0071) +
002104000000                MSGF(&LIB/&OBJ) +
002105000000                MSG( +
002106000000'Löschen Arb.Umg'                                                     +
002107000000                ) +
002108000000                SEV(0) +
002109000000     /*   No replacement variables defined!                         */ +
002110000000                ALROPT(*NO) +
002111000000                CCSID(65535) +
002112000000                /*  -EOF-  */
002113000000
002114000000     /*-------------------------------------------------------------*/
002115000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0072                    */
002116000000     /* Sortierfolge                                                */
002117000000     /*-------------------------------------------------------------*/
002118000000
002119000000             RMVMSGD MSGID(KEY0072) MSGF(&LIB/&OBJ)
002120000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002121000000
002122000000             ADDMSGD +
002123000000                MSGID(KEY0072) +
002124000000                MSGF(&LIB/&OBJ) +
002125000000                MSG( +
002126000000'Sortierfolge'                                                        +
002127000000                ) +
002128000000                SEV(0) +
002129000000     /*   No replacement variables defined!                         */ +
002130000000                ALROPT(*NO) +
002131000000                CCSID(65535) +
002132000000                /*  -EOF-  */
002133000000
002134000000     /*-------------------------------------------------------------*/
002135000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0073                    */
002136000000     /* Ja                                                          */
002137000000     /*-------------------------------------------------------------*/
002138000000
002139000000             RMVMSGD MSGID(KEY0073) MSGF(&LIB/&OBJ)
002140000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002141000000
002142000000             ADDMSGD +
002143000000                MSGID(KEY0073) +
002144000000                MSGF(&LIB/&OBJ) +
002145000000                MSG( +
002146000000'Ja'                                                                  +
002147000000                ) +
002148000000                SEV(0) +
002149000000     /*   No replacement variables defined!                         */ +
002150000000                ALROPT(*NO) +
002151000000                CCSID(65535) +
002152000000                /*  -EOF-  */
002153000000
002154000000     /*-------------------------------------------------------------*/
002155000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0074                    */
002156000000     /* Nein                                                        */
002157000000     /*-------------------------------------------------------------*/
002158000000
002159000000             RMVMSGD MSGID(KEY0074) MSGF(&LIB/&OBJ)
002160000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002161000000
002162000000             ADDMSGD +
002163000000                MSGID(KEY0074) +
002164000000                MSGF(&LIB/&OBJ) +
002165000000                MSG( +
002166000000'Nein'                                                                +
002167000000                ) +
002168000000                SEV(0) +
002169000000     /*   No replacement variables defined!                         */ +
002170000000                ALROPT(*NO) +
002171000000                CCSID(65535) +
002172000000                /*  -EOF-  */
002173000000
002174000000     /*-------------------------------------------------------------*/
002175000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0075                    */
002176000000     /* OK                                                          */
002177000000     /*-------------------------------------------------------------*/
002178000000
002179000000             RMVMSGD MSGID(KEY0075) MSGF(&LIB/&OBJ)
002180000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002181000000
002182000000             ADDMSGD +
002183000000                MSGID(KEY0075) +
002184000000                MSGF(&LIB/&OBJ) +
002185000000                MSG( +
002186000000'OK'                                                                  +
002187000000                ) +
002188000000                SEV(0) +
002189000000     /*   No replacement variables defined!                         */ +
002190000000                ALROPT(*NO) +
002191000000                CCSID(65535) +
002192000000                /*  -EOF-  */
002193000000
002194000000     /*-------------------------------------------------------------*/
002195000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0076                    */
002196000000     /* Anfang                                                      */
002197000000     /*-------------------------------------------------------------*/
002198000000
002199000000             RMVMSGD MSGID(KEY0076) MSGF(&LIB/&OBJ)
002200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002201000000
002202000000             ADDMSGD +
002203000000                MSGID(KEY0076) +
002204000000                MSGF(&LIB/&OBJ) +
002205000000                MSG( +
002206000000'Anfang'                                                              +
002207000000                ) +
002208000000                SEV(0) +
002209000000     /*   No replacement variables defined!                         */ +
002210000000                ALROPT(*NO) +
002211000000                CCSID(65535) +
002212000000                /*  -EOF-  */
002213000000
002214000000     /*-------------------------------------------------------------*/
002215000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0077                    */
002216000000     /* Ende                                                        */
002217000000     /*-------------------------------------------------------------*/
002218000000
002219000000             RMVMSGD MSGID(KEY0077) MSGF(&LIB/&OBJ)
002220000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002221000000
002222000000             ADDMSGD +
002223000000                MSGID(KEY0077) +
002224000000                MSGF(&LIB/&OBJ) +
002225000000                MSG( +
002226000000'Ende'                                                                +
002227000000                ) +
002228000000                SEV(0) +
002229000000     /*   No replacement variables defined!                         */ +
002230000000                ALROPT(*NO) +
002231000000                CCSID(65535) +
002232000000                /*  -EOF-  */
002233000000
002234000000     /*-------------------------------------------------------------*/
002235000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0078                    */
002236000000     /* Umgebung                                                    */
002237000000     /*-------------------------------------------------------------*/
002238000000
002239000000             RMVMSGD MSGID(KEY0078) MSGF(&LIB/&OBJ)
002240000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002241000000
002242000000             ADDMSGD +
002243000000                MSGID(KEY0078) +
002244000000                MSGF(&LIB/&OBJ) +
002245000000                MSG( +
002246000000'Umgebung'                                                            +
002247000000                ) +
002248000000                SEV(0) +
002249000000     /*   No replacement variables defined!                         */ +
002250000000                ALROPT(*NO) +
002251000000                CCSID(65535) +
002252000000                /*  -EOF-  */
002253000000
002254000000     /*-------------------------------------------------------------*/
002255000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0079                    */
002256000000     /* nur Layout                                                  */
002257000000     /*-------------------------------------------------------------*/
002258000000
002259000000             RMVMSGD MSGID(KEY0079) MSGF(&LIB/&OBJ)
002260000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002261000000
002262000000             ADDMSGD +
002263000000                MSGID(KEY0079) +
002264000000                MSGF(&LIB/&OBJ) +
002265000000                MSG( +
002266000000'nur Layout'                                                          +
002267000000                ) +
002268000000                SEV(0) +
002269000000     /*   No replacement variables defined!                         */ +
002270000000                ALROPT(*NO) +
002271000000                CCSID(65535) +
002272000000                /*  -EOF-  */
002273000000
002274000000     /*-------------------------------------------------------------*/
002275000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0080                    */
002276000000     /* Umsch. NULL-Ind.                                            */
002277000000     /*-------------------------------------------------------------*/
002278000000
002279000000             RMVMSGD MSGID(KEY0080) MSGF(&LIB/&OBJ)
002280000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002281000000
002282000000             ADDMSGD +
002283000000                MSGID(KEY0080) +
002284000000                MSGF(&LIB/&OBJ) +
002285000000                MSG( +
002286000000'Umsch. NULL-Ind.'                                                    +
002287000000                ) +
002288000000                SEV(0) +
002289000000     /*   No replacement variables defined!                         */ +
002290000000                ALROPT(*NO) +
002291000000                CCSID(65535) +
002292000000                /*  -EOF-  */
002293000000
002294000000     /*-------------------------------------------------------------*/
002295000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0081                    */
002296000000     /* Umsch. Eingabe                                              */
002297000000     /*-------------------------------------------------------------*/
002298000000
002299000000             RMVMSGD MSGID(KEY0081) MSGF(&LIB/&OBJ)
002300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002301000000
002302000000             ADDMSGD +
002303000000                MSGID(KEY0081) +
002304000000                MSGF(&LIB/&OBJ) +
002305000000                MSG( +
002306000000'Umsch. Eingabe'                                                      +
002307000000                ) +
002308000000                SEV(0) +
002309000000     /*   No replacement variables defined!                         */ +
002310000000                ALROPT(*NO) +
002311000000                CCSID(65535) +
002312000000                /*  -EOF-  */
002313000000
002314000000     /*-------------------------------------------------------------*/
002315000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0082                    */
002316000000     /* String-Edit                                                 */
002317000000     /*-------------------------------------------------------------*/
002318000000
002319000000             RMVMSGD MSGID(KEY0082) MSGF(&LIB/&OBJ)
002320000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002321000000
002322000000             ADDMSGD +
002323000000                MSGID(KEY0082) +
002324000000                MSGF(&LIB/&OBJ) +
002325000000                MSG( +
002326000000'String-Edit'                                                         +
002327000000                ) +
002328000000                SEV(0) +
002329000000     /*   No replacement variables defined!                         */ +
002330000000                ALROPT(*NO) +
002331000000                CCSID(65535) +
002332000000                /*  -EOF-  */
002333000000
002334000000     /*-------------------------------------------------------------*/
002335000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0083                    */
002336000000     /* Satzsperre                                                  */
002337000000     /*-------------------------------------------------------------*/
002338000000
002339000000             RMVMSGD MSGID(KEY0083) MSGF(&LIB/&OBJ)
002340000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002341000000
002342000000             ADDMSGD +
002343000000                MSGID(KEY0083) +
002344000000                MSGF(&LIB/&OBJ) +
002345000000                MSG( +
002346000000'Satzsperre'                                                          +
002347000000                ) +
002348000000                SEV(0) +
002349000000     /*   No replacement variables defined!                         */ +
002350000000                ALROPT(*NO) +
002351000000                CCSID(65535) +
002352000000                /*  -EOF-  */
002353000000
002354000000     /*-------------------------------------------------------------*/
002355000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0084                    */
002356000000     /* Aufsetzen Kleinb.                                           */
002357000000     /*-------------------------------------------------------------*/
002358000000
002359000000             RMVMSGD MSGID(KEY0084) MSGF(&LIB/&OBJ)
002360000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002361000000
002362000000             ADDMSGD +
002363000000                MSGID(KEY0084) +
002364000000                MSGF(&LIB/&OBJ) +
002365000000                MSG( +
002366000000'Aufsetzen Kleinb.'                                                   +
002367000000                ) +
002368000000                SEV(0) +
002369000000     /*   No replacement variables defined!                         */ +
002370000000                ALROPT(*NO) +
002371000000                CCSID(65535) +
002372000000                /*  -EOF-  */
002373000000
002374000000     /*-------------------------------------------------------------*/
002375000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0085                    */
002376000000     /* Drucken                                                     */
002377000000     /*-------------------------------------------------------------*/
002378000000
002379000000             RMVMSGD MSGID(KEY0085) MSGF(&LIB/&OBJ)
002380000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002381000000
002382000000             ADDMSGD +
002383000000                MSGID(KEY0085) +
002384000000                MSGF(&LIB/&OBJ) +
002385000000                MSG( +
002386000000'Drucken'                                                             +
002387000000                ) +
002388000000                SEV(0) +
002389000000     /*   No replacement variables defined!                         */ +
002390000000                ALROPT(*NO) +
002391000000                CCSID(65535) +
002392000000                /*  -EOF-  */
002393000000
002394000000     /*-------------------------------------------------------------*/
002395000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0086                    */
002396000000     /* Einfügen                                                    */
002397000000     /*-------------------------------------------------------------*/
002398000000
002399000000             RMVMSGD MSGID(KEY0086) MSGF(&LIB/&OBJ)
002400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002401000000
002402000000             ADDMSGD +
002403000000                MSGID(KEY0086) +
002404000000                MSGF(&LIB/&OBJ) +
002405000000                MSG( +
002406000000'Einfügen'                                                            +
002407000000                ) +
002408000000                SEV(0) +
002409000000     /*   No replacement variables defined!                         */ +
002410000000                ALROPT(*NO) +
002411000000                CCSID(65535) +
002412000000                /*  -EOF-  */
002413000000
002414000000     /*-------------------------------------------------------------*/
002415000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0087                    */
002416000000     /* Löschen                                                     */
002417000000     /*-------------------------------------------------------------*/
002418000000
002419000000             RMVMSGD MSGID(KEY0087) MSGF(&LIB/&OBJ)
002420000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002421000000
002422000000             ADDMSGD +
002423000000                MSGID(KEY0087) +
002424000000                MSGF(&LIB/&OBJ) +
002425000000                MSG( +
002426000000'Löschen'                                                             +
002427000000                ) +
002428000000                SEV(0) +
002429000000     /*   No replacement variables defined!                         */ +
002430000000                ALROPT(*NO) +
002431000000                CCSID(65535) +
002432000000                /*  -EOF-  */
002433000000
002434000000     /*-------------------------------------------------------------*/
002435000000     /*   Cmd-ADDMSGD für Message-ID :   MBX0001                    */
002436000000     /* Information                                                 */
002437000000     /*-------------------------------------------------------------*/
002438000000
002439000000             RMVMSGD MSGID(MBX0001) MSGF(&LIB/&OBJ)
002440000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002441000000
002442000000             ADDMSGD +
002443000000                MSGID(MBX0001) +
002444000000                MSGF(&LIB/&OBJ) +
002445000000                MSG( +
002446000000'Information'                                                         +
002447000000                ) +
002448000000                SEV(0) +
002449000000     /*   No replacement variables defined!                         */ +
002450000000                ALROPT(*NO) +
002451000000                CCSID(65535) +
002452000000                /*  -EOF-  */
002453000000
002454000000     /*-------------------------------------------------------------*/
002455000000     /*   Cmd-ADDMSGD für Message-ID :   MBX0002                    */
002456000000     /* Frage                                                       */
002457000000     /*-------------------------------------------------------------*/
002458000000
002459000000             RMVMSGD MSGID(MBX0002) MSGF(&LIB/&OBJ)
002460000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002461000000
002462000000             ADDMSGD +
002463000000                MSGID(MBX0002) +
002464000000                MSGF(&LIB/&OBJ) +
002465000000                MSG( +
002466000000'Frage'                                                               +
002467000000                ) +
002468000000                SEV(0) +
002469000000     /*   No replacement variables defined!                         */ +
002470000000                ALROPT(*NO) +
002471000000                CCSID(65535) +
002472000000                /*  -EOF-  */
002473000000
002474000000     /*-------------------------------------------------------------*/
002475000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0001                    */
002476000000     /* Datei                                                       */
002477000000     /*-------------------------------------------------------------*/
002478000000
002479000000             RMVMSGD MSGID(PMT0001) MSGF(&LIB/&OBJ)
002480000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002481000000
002482000000             ADDMSGD +
002483000000                MSGID(PMT0001) +
002484000000                MSGF(&LIB/&OBJ) +
002485000000                MSG( +
002486000000'Datei'                                                               +
002487000000                ) +
002488000000                SEV(0) +
002489000000     /*   No replacement variables defined!                         */ +
002490000000                ALROPT(*NO) +
002491000000                CCSID(65535) +
002492000000                /*  -EOF-  */
002493000000
002494000000     /*-------------------------------------------------------------*/
002495000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0002                    */
002496000000     /* Teildatei                                                   */
002497000000     /*-------------------------------------------------------------*/
002498000000
002499000000             RMVMSGD MSGID(PMT0002) MSGF(&LIB/&OBJ)
002500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002501000000
002502000000             ADDMSGD +
002503000000                MSGID(PMT0002) +
002504000000                MSGF(&LIB/&OBJ) +
002505000000                MSG( +
002506000000'Teildatei'                                                           +
002507000000                ) +
002508000000                SEV(0) +
002509000000     /*   No replacement variables defined!                         */ +
002510000000                ALROPT(*NO) +
002511000000                CCSID(65535) +
002512000000                /*  -EOF-  */
002513000000
002514000000     /*-------------------------------------------------------------*/
002515000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0003                    */
002516000000     /* Zugriffsart                                                 */
002517000000     /*-------------------------------------------------------------*/
002518000000
002519000000             RMVMSGD MSGID(PMT0003) MSGF(&LIB/&OBJ)
002520000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002521000000
002522000000             ADDMSGD +
002523000000                MSGID(PMT0003) +
002524000000                MSGF(&LIB/&OBJ) +
002525000000                MSG( +
002526000000'Zugriffsart'                                                         +
002527000000                ) +
002528000000                SEV(0) +
002529000000     /*   No replacement variables defined!                         */ +
002530000000                ALROPT(*NO) +
002531000000                CCSID(65535) +
002532000000                /*  -EOF-  */
002533000000
002534000000     /*-------------------------------------------------------------*/
002535000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0004                    */
002536000000     /* Sprache                                                     */
002537000000     /*-------------------------------------------------------------*/
002538000000
002539000000             RMVMSGD MSGID(PMT0004) MSGF(&LIB/&OBJ)
002540000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002541000000
002542000000             ADDMSGD +
002543000000                MSGID(PMT0004) +
002544000000                MSGF(&LIB/&OBJ) +
002545000000                MSG( +
002546000000'Sprache'                                                             +
002547000000                ) +
002548000000                SEV(0) +
002549000000     /*   No replacement variables defined!                         */ +
002550000000                ALROPT(*NO) +
002551000000                CCSID(65535) +
002552000000                /*  -EOF-  */
002553000000
002554000000     /*-------------------------------------------------------------*/
002555000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0005                    */
002556000000     /* Ändern Bibliothek erlaubt                                   */
002557000000     /*-------------------------------------------------------------*/
002558000000
002559000000             RMVMSGD MSGID(PMT0005) MSGF(&LIB/&OBJ)
002560000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002561000000
002562000000             ADDMSGD +
002563000000                MSGID(PMT0005) +
002564000000                MSGF(&LIB/&OBJ) +
002565000000                MSG( +
002566000000'Ändern Bibliothek erlaubt'                                           +
002567000000                ) +
002568000000                SEV(0) +
002569000000     /*   No replacement variables defined!                         */ +
002570000000                ALROPT(*NO) +
002571000000                CCSID(65535) +
002572000000                /*  -EOF-  */
002573000000
002574000000     /*-------------------------------------------------------------*/
002575000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0006                    */
002576000000     /* Ändern Datei erlaubt                                        */
002577000000     /*-------------------------------------------------------------*/
002578000000
002579000000             RMVMSGD MSGID(PMT0006) MSGF(&LIB/&OBJ)
002580000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002581000000
002582000000             ADDMSGD +
002583000000                MSGID(PMT0006) +
002584000000                MSGF(&LIB/&OBJ) +
002585000000                MSG( +
002586000000'Ändern Datei erlaubt'                                                +
002587000000                ) +
002588000000                SEV(0) +
002589000000     /*   No replacement variables defined!                         */ +
002590000000                ALROPT(*NO) +
002591000000                CCSID(65535) +
002592000000                /*  -EOF-  */
002593000000
002594000000     /*-------------------------------------------------------------*/
002595000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0007                    */
002596000000     /* Ändern Teildatei erlaubt                                    */
002597000000     /*-------------------------------------------------------------*/
002598000000
002599000000             RMVMSGD MSGID(PMT0007) MSGF(&LIB/&OBJ)
002600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002601000000
002602000000             ADDMSGD +
002603000000                MSGID(PMT0007) +
002604000000                MSGF(&LIB/&OBJ) +
002605000000                MSG( +
002606000000'Ändern Teildatei erlaubt'                                            +
002607000000                ) +
002608000000                SEV(0) +
002609000000     /*   No replacement variables defined!                         */ +
002610000000                ALROPT(*NO) +
002611000000                CCSID(65535) +
002612000000                /*  -EOF-  */
002613000000
002614000000     /*-------------------------------------------------------------*/
002615000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0008                    */
002616000000     /* Ändern Datensätze erlaubt                                   */
002617000000     /*-------------------------------------------------------------*/
002618000000
002619000000             RMVMSGD MSGID(PMT0008) MSGF(&LIB/&OBJ)
002620000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002621000000
002622000000             ADDMSGD +
002623000000                MSGID(PMT0008) +
002624000000                MSGF(&LIB/&OBJ) +
002625000000                MSG( +
002626000000'Ändern Datensätze erlaubt'                                           +
002627000000                ) +
002628000000                SEV(0) +
002629000000     /*   No replacement variables defined!                         */ +
002630000000                ALROPT(*NO) +
002631000000                CCSID(65535) +
002632000000                /*  -EOF-  */
002633000000
002634000000     /*-------------------------------------------------------------*/
002635000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0009                    */
002636000000     /* Ändern SQL WHERE erlaubt                                    */
002637000000     /*-------------------------------------------------------------*/
002638000000
002639000000             RMVMSGD MSGID(PMT0009) MSGF(&LIB/&OBJ)
002640000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002641000000
002642000000             ADDMSGD +
002643000000                MSGID(PMT0009) +
002644000000                MSGF(&LIB/&OBJ) +
002645000000                MSG( +
002646000000'Ändern SQL WHERE erlaubt'                                            +
002647000000                ) +
002648000000                SEV(0) +
002649000000     /*   No replacement variables defined!                         */ +
002650000000                ALROPT(*NO) +
002651000000                CCSID(65535) +
002652000000                /*  -EOF-  */
002653000000
002654000000     /*-------------------------------------------------------------*/
002655000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0010                    */
002656000000     /* Ändern SQL ORDER BY erlaubt                                 */
002657000000     /*-------------------------------------------------------------*/
002658000000
002659000000             RMVMSGD MSGID(PMT0010) MSGF(&LIB/&OBJ)
002660000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002661000000
002662000000             ADDMSGD +
002663000000                MSGID(PMT0010) +
002664000000                MSGF(&LIB/&OBJ) +
002665000000                MSG( +
002666000000'Ändern SQL ORDER BY erlaubt'                                         +
002667000000                ) +
002668000000                SEV(0) +
002669000000     /*   No replacement variables defined!                         */ +
002670000000                ALROPT(*NO) +
002671000000                CCSID(65535) +
002672000000                /*  -EOF-  */
002673000000
002674000000     /*-------------------------------------------------------------*/
002675000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0011                    */
002676000000     /* Arbeitsumgebung                                             */
002677000000     /*-------------------------------------------------------------*/
002678000000
002679000000             RMVMSGD MSGID(PMT0011) MSGF(&LIB/&OBJ)
002680000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002681000000
002682000000             ADDMSGD +
002683000000                MSGID(PMT0011) +
002684000000                MSGF(&LIB/&OBJ) +
002685000000                MSG( +
002686000000'Arbeitsumgebung'                                                     +
002687000000                ) +
002688000000                SEV(0) +
002689000000     /*   No replacement variables defined!                         */ +
002690000000                ALROPT(*NO) +
002691000000                CCSID(65535) +
002692000000                /*  -EOF-  */
002693000000
002694000000     /*-------------------------------------------------------------*/
002695000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0012                    */
002696000000     /*   Teildatei                                                 */
002697000000     /*-------------------------------------------------------------*/
002698000000
002699000000             RMVMSGD MSGID(PMT0012) MSGF(&LIB/&OBJ)
002700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002701000000
002702000000             ADDMSGD +
002703000000                MSGID(PMT0012) +
002704000000                MSGF(&LIB/&OBJ) +
002705000000                MSG( +
002706000000'  Teildatei'                                                         +
002707000000                ) +
002708000000                SEV(0) +
002709000000     /*   No replacement variables defined!                         */ +
002710000000                ALROPT(*NO) +
002711000000                CCSID(65535) +
002712000000                /*  -EOF-  */
002713000000
002714000000     /*-------------------------------------------------------------*/
002715000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0013                    */
002716000000     /* SQL WHERE                                                   */
002717000000     /*-------------------------------------------------------------*/
002718000000
002719000000             RMVMSGD MSGID(PMT0013) MSGF(&LIB/&OBJ)
002720000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002721000000
002722000000             ADDMSGD +
002723000000                MSGID(PMT0013) +
002724000000                MSGF(&LIB/&OBJ) +
002725000000                MSG( +
002726000000'SQL WHERE'                                                           +
002727000000                ) +
002728000000                SEV(0) +
002729000000     /*   No replacement variables defined!                         */ +
002730000000                ALROPT(*NO) +
002731000000                CCSID(65535) +
002732000000                /*  -EOF-  */
002733000000
002734000000     /*-------------------------------------------------------------*/
002735000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0014                    */
002736000000     /* SQL ORDER BY                                                */
002737000000     /*-------------------------------------------------------------*/
002738000000
002739000000             RMVMSGD MSGID(PMT0014) MSGF(&LIB/&OBJ)
002740000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002741000000
002742000000             ADDMSGD +
002743000000                MSGID(PMT0014) +
002744000000                MSGF(&LIB/&OBJ) +
002745000000                MSG( +
002746000000'SQL ORDER BY'                                                        +
002747000000                ) +
002748000000                SEV(0) +
002749000000     /*   No replacement variables defined!                         */ +
002750000000                ALROPT(*NO) +
002751000000                CCSID(65535) +
002752000000                /*  -EOF-  */
002753000000
002754000000     /*-------------------------------------------------------------*/
002755000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0015                    */
002756000000     /* Bibliothek                                                  */
002757000000     /*-------------------------------------------------------------*/
002758000000
002759000000             RMVMSGD MSGID(PMT0015) MSGF(&LIB/&OBJ)
002760000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002761000000
002762000000             ADDMSGD +
002763000000                MSGID(PMT0015) +
002764000000                MSGF(&LIB/&OBJ) +
002765000000                MSG( +
002766000000'Bibliothek'                                                          +
002767000000                ) +
002768000000                SEV(0) +
002769000000     /*   No replacement variables defined!                         */ +
002770000000                ALROPT(*NO) +
002771000000                CCSID(65535) +
002772000000                /*  -EOF-  */
002773000000
002774000000     /*-------------------------------------------------------------*/
002775000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0016                    */
002776000000     /* Benutzereinstellungen                                       */
002777000000     /*-------------------------------------------------------------*/
002778000000
002779000000             RMVMSGD MSGID(PMT0016) MSGF(&LIB/&OBJ)
002780000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002781000000
002782000000             ADDMSGD +
002783000000                MSGID(PMT0016) +
002784000000                MSGF(&LIB/&OBJ) +
002785000000                MSG( +
002786000000'Benutzereinstellungen'                                               +
002787000000                ) +
002788000000                SEV(0) +
002789000000     /*   No replacement variables defined!                         */ +
002790000000                ALROPT(*NO) +
002791000000                CCSID(65535) +
002792000000                /*  -EOF-  */
002793000000
002794000000     /*-------------------------------------------------------------*/
002795000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0017                    */
002796000000     /* Benutzerprofil                                              */
002797000000     /*-------------------------------------------------------------*/
002798000000
002799000000             RMVMSGD MSGID(PMT0017) MSGF(&LIB/&OBJ)
002800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002801000000
002802000000             ADDMSGD +
002803000000                MSGID(PMT0017) +
002804000000                MSGF(&LIB/&OBJ) +
002805000000                MSG( +
002806000000'Benutzerprofil'                                                      +
002807000000                ) +
002808000000                SEV(0) +
002809000000     /*   No replacement variables defined!                         */ +
002810000000                ALROPT(*NO) +
002811000000                CCSID(65535) +
002812000000                /*  -EOF-  */
002813000000
002814000000     /*-------------------------------------------------------------*/
002815000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0018                    */
002816000000     /* Speichern beim Verlassen                                    */
002817000000     /*-------------------------------------------------------------*/
002818000000
002819000000             RMVMSGD MSGID(PMT0018) MSGF(&LIB/&OBJ)
002820000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002821000000
002822000000             ADDMSGD +
002823000000                MSGID(PMT0018) +
002824000000                MSGF(&LIB/&OBJ) +
002825000000                MSG( +
002826000000'Speichern beim Verlassen'                                            +
002827000000                ) +
002828000000                SEV(0) +
002829000000     /*   No replacement variables defined!                         */ +
002830000000                ALROPT(*NO) +
002831000000                CCSID(65535) +
002832000000                /*  -EOF-  */
002833000000
002834000000     /*-------------------------------------------------------------*/
002835000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0019                    */
002836000000     /* Nur Layout laden                                            */
002837000000     /*-------------------------------------------------------------*/
002838000000
002839000000             RMVMSGD MSGID(PMT0019) MSGF(&LIB/&OBJ)
002840000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002841000000
002842000000             ADDMSGD +
002843000000                MSGID(PMT0019) +
002844000000                MSGF(&LIB/&OBJ) +
002845000000                MSG( +
002846000000'Nur Layout laden'                                                    +
002847000000                ) +
002848000000                SEV(0) +
002849000000     /*   No replacement variables defined!                         */ +
002850000000                ALROPT(*NO) +
002851000000                CCSID(65535) +
002852000000                /*  -EOF-  */
002853000000
002854000000     /*-------------------------------------------------------------*/
002855000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0100                    */
002856000000     /* Datenbankbrowser - Peek/400                                 */
002857000000     /*-------------------------------------------------------------*/
002858000000
002859000000             RMVMSGD MSGID(PMT0100) MSGF(&LIB/&OBJ)
002860000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002861000000
002862000000             ADDMSGD +
002863000000                MSGID(PMT0100) +
002864000000                MSGF(&LIB/&OBJ) +
002865000000                MSG( +
002866000000'Datenbankbrowser - Peek/400'                                         +
002867000000                ) +
002868000000                SEV(0) +
002869000000     /*   No replacement variables defined!                         */ +
002870000000                ALROPT(*NO) +
002871000000                CCSID(65535) +
002872000000                /*  -EOF-  */
002873000000
002874000000     /*-------------------------------------------------------------*/
002875000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0101                    */
002876000000     /* Anzeigen Datenbankrelationen                                */
002877000000     /*-------------------------------------------------------------*/
002878000000
002879000000             RMVMSGD MSGID(PMT0101) MSGF(&LIB/&OBJ)
002880000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002881000000
002882000000             ADDMSGD +
002883000000                MSGID(PMT0101) +
002884000000                MSGF(&LIB/&OBJ) +
002885000000                MSG( +
002886000000'Anzeigen Datenbankrelationen'                                        +
002887000000                ) +
002888000000                SEV(0) +
002889000000     /*   No replacement variables defined!                         */ +
002890000000                ALROPT(*NO) +
002891000000                CCSID(65535) +
002892000000                /*  -EOF-  */
002893000000
002894000000     /*-------------------------------------------------------------*/
002895000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0001                    */
002896000000     /* Datei:                                                      */
002897000000     /*-------------------------------------------------------------*/
002898000000
002899000000             RMVMSGD MSGID(TXT0001) MSGF(&LIB/&OBJ)
002900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002901000000
002902000000             ADDMSGD +
002903000000                MSGID(TXT0001) +
002904000000                MSGF(&LIB/&OBJ) +
002905000000                MSG( +
002906000000'Datei:'                                                              +
002907000000                ) +
002908000000                SEV(0) +
002909000000     /*   No replacement variables defined!                         */ +
002910000000                ALROPT(*NO) +
002911000000                CCSID(65535) +
002912000000                /*  -EOF-  */
002913000000
002914000000     /*-------------------------------------------------------------*/
002915000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0002                    */
002916000000     /* Bibliothek:                                                 */
002917000000     /*-------------------------------------------------------------*/
002918000000
002919000000             RMVMSGD MSGID(TXT0002) MSGF(&LIB/&OBJ)
002920000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002921000000
002922000000             ADDMSGD +
002923000000                MSGID(TXT0002) +
002924000000                MSGF(&LIB/&OBJ) +
002925000000                MSG( +
002926000000'Bibliothek:'                                                         +
002927000000                ) +
002928000000                SEV(0) +
002929000000     /*   No replacement variables defined!                         */ +
002930000000                ALROPT(*NO) +
002931000000                CCSID(65535) +
002932000000                /*  -EOF-  */
002933000000
002934000000     /*-------------------------------------------------------------*/
002935000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0003                    */
002936000000     /* Teildatei:                                                  */
002937000000     /*-------------------------------------------------------------*/
002938000000
002939000000             RMVMSGD MSGID(TXT0003) MSGF(&LIB/&OBJ)
002940000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002941000000
002942000000             ADDMSGD +
002943000000                MSGID(TXT0003) +
002944000000                MSGF(&LIB/&OBJ) +
002945000000                MSG( +
002946000000'Teildatei:'                                                          +
002947000000                ) +
002948000000                SEV(0) +
002949000000     /*   No replacement variables defined!                         */ +
002950000000                ALROPT(*NO) +
002951000000                CCSID(65535) +
002952000000                /*  -EOF-  */
002953000000
002954000000     /*-------------------------------------------------------------*/
002955000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0004                    */
002956000000     /* Satzlänge :                                                 */
002957000000     /*-------------------------------------------------------------*/
002958000000
002959000000             RMVMSGD MSGID(TXT0004) MSGF(&LIB/&OBJ)
002960000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002961000000
002962000000             ADDMSGD +
002963000000                MSGID(TXT0004) +
002964000000                MSGF(&LIB/&OBJ) +
002965000000                MSG( +
002966000000'Satzlänge :'                                                         +
002967000000                ) +
002968000000                SEV(0) +
002969000000     /*   No replacement variables defined!                         */ +
002970000000                ALROPT(*NO) +
002971000000                CCSID(65535) +
002972000000                /*  -EOF-  */
002973000000
002974000000     /*-------------------------------------------------------------*/
002975000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0005                    */
002976000000     /* Anz. Sätze:                                                 */
002977000000     /*-------------------------------------------------------------*/
002978000000
002979000000             RMVMSGD MSGID(TXT0005) MSGF(&LIB/&OBJ)
002980000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002981000000
002982000000             ADDMSGD +
002983000000                MSGID(TXT0005) +
002984000000                MSGF(&LIB/&OBJ) +
002985000000                MSG( +
002986000000'Anz. Sätze:'                                                         +
002987000000                ) +
002988000000                SEV(0) +
002989000000     /*   No replacement variables defined!                         */ +
002990000000                ALROPT(*NO) +
002991000000                CCSID(65535) +
002992000000                /*  -EOF-  */
002993000000
002994000000     /*-------------------------------------------------------------*/
002995000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0006                    */
002996000000     /* Feld-Nummer:                                                */
002997000000     /*-------------------------------------------------------------*/
002998000000
002999000000             RMVMSGD MSGID(TXT0006) MSGF(&LIB/&OBJ)
003000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003001000000
003002000000             ADDMSGD +
003003000000                MSGID(TXT0006) +
003004000000                MSGF(&LIB/&OBJ) +
003005000000                MSG( +
003006000000'Feld-Nummer:'                                                        +
003007000000                ) +
003008000000                SEV(0) +
003009000000     /*   No replacement variables defined!                         */ +
003010000000                ALROPT(*NO) +
003011000000                CCSID(65535) +
003012000000                /*  -EOF-  */
003013000000
003014000000     /*-------------------------------------------------------------*/
003015000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0007                    */
003016000000     /*         Feld:                                               */
003017000000     /*-------------------------------------------------------------*/
003018000000
003019000000             RMVMSGD MSGID(TXT0007) MSGF(&LIB/&OBJ)
003020000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003021000000
003022000000             ADDMSGD +
003023000000                MSGID(TXT0007) +
003024000000                MSGF(&LIB/&OBJ) +
003025000000                MSG( +
003026000000'        Feld:'                                                       +
003027000000                ) +
003028000000                SEV(0) +
003029000000     /*   No replacement variables defined!                         */ +
003030000000                ALROPT(*NO) +
003031000000                CCSID(65535) +
003032000000                /*  -EOF-  */
003033000000
003034000000     /*-------------------------------------------------------------*/
003035000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0008                    */
003036000000     /*    Format:                                                  */
003037000000     /*-------------------------------------------------------------*/
003038000000
003039000000             RMVMSGD MSGID(TXT0008) MSGF(&LIB/&OBJ)
003040000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003041000000
003042000000             ADDMSGD +
003043000000                MSGID(TXT0008) +
003044000000                MSGF(&LIB/&OBJ) +
003045000000                MSG( +
003046000000'   Format:'                                                          +
003047000000                ) +
003048000000                SEV(0) +
003049000000     /*   No replacement variables defined!                         */ +
003050000000                ALROPT(*NO) +
003051000000                CCSID(65535) +
003052000000                /*  -EOF-  */
003053000000
003054000000     /*-------------------------------------------------------------*/
003055000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0009                    */
003056000000     /* Dateigröße:                                                 */
003057000000     /*-------------------------------------------------------------*/
003058000000
003059000000             RMVMSGD MSGID(TXT0009) MSGF(&LIB/&OBJ)
003060000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003061000000
003062000000             ADDMSGD +
003063000000                MSGID(TXT0009) +
003064000000                MSGF(&LIB/&OBJ) +
003065000000                MSG( +
003066000000'Dateigröße:'                                                         +
003067000000                ) +
003068000000                SEV(0) +
003069000000     /*   No replacement variables defined!                         */ +
003070000000                ALROPT(*NO) +
003071000000                CCSID(65535) +
003072000000                /*  -EOF-  */
003073000000
003074000000     /*-------------------------------------------------------------*/
003075000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0010                    */
003076000000     /* Satz-Nr. ..:                                                */
003077000000     /*-------------------------------------------------------------*/
003078000000
003079000000             RMVMSGD MSGID(TXT0010) MSGF(&LIB/&OBJ)
003080000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003081000000
003082000000             ADDMSGD +
003083000000                MSGID(TXT0010) +
003084000000                MSGF(&LIB/&OBJ) +
003085000000                MSG( +
003086000000'Satz-Nr. ..:'                                                        +
003087000000                ) +
003088000000                SEV(0) +
003089000000     /*   No replacement variables defined!                         */ +
003090000000                ALROPT(*NO) +
003091000000                CCSID(65535) +
003092000000                /*  -EOF-  */
003093000000
003094000000     /*-------------------------------------------------------------*/
003095000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0011                    */
003096000000     /* Schlüssel  :                                                */
003097000000     /*-------------------------------------------------------------*/
003098000000
003099000000             RMVMSGD MSGID(TXT0011) MSGF(&LIB/&OBJ)
003100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003101000000
003102000000             ADDMSGD +
003103000000                MSGID(TXT0011) +
003104000000                MSGF(&LIB/&OBJ) +
003105000000                MSG( +
003106000000'Schlüssel  :'                                                        +
003107000000                ) +
003108000000                SEV(0) +
003109000000     /*   No replacement variables defined!                         */ +
003110000000                ALROPT(*NO) +
003111000000                CCSID(65535) +
003112000000                /*  -EOF-  */
003113000000
003114000000     /*-------------------------------------------------------------*/
003115000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0012                    */
003116000000     /*     Auswahl:                                                */
003117000000     /*-------------------------------------------------------------*/
003118000000
003119000000             RMVMSGD MSGID(TXT0012) MSGF(&LIB/&OBJ)
003120000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003121000000
003122000000             ADDMSGD +
003123000000                MSGID(TXT0012) +
003124000000                MSGF(&LIB/&OBJ) +
003125000000                MSG( +
003126000000'    Auswahl:'                                                        +
003127000000                ) +
003128000000                SEV(0) +
003129000000     /*   No replacement variables defined!                         */ +
003130000000                ALROPT(*NO) +
003131000000                CCSID(65535) +
003132000000                /*  -EOF-  */
003133000000
003134000000     /*-------------------------------------------------------------*/
003135000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0013                    */
003136000000     /* Datei:                                                      */
003137000000     /*-------------------------------------------------------------*/
003138000000
003139000000             RMVMSGD MSGID(TXT0013) MSGF(&LIB/&OBJ)
003140000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003141000000
003142000000             ADDMSGD +
003143000000                MSGID(TXT0013) +
003144000000                MSGF(&LIB/&OBJ) +
003145000000                MSG( +
003146000000'Datei:'                                                              +
003147000000                ) +
003148000000                SEV(0) +
003149000000     /*   No replacement variables defined!                         */ +
003150000000                ALROPT(*NO) +
003151000000                CCSID(65535) +
003152000000                /*  -EOF-  */
003153000000
003154000000     /*-------------------------------------------------------------*/
003155000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0014                    */
003156000000     /* Bib:                                                        */
003157000000     /*-------------------------------------------------------------*/
003158000000
003159000000             RMVMSGD MSGID(TXT0014) MSGF(&LIB/&OBJ)
003160000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003161000000
003162000000             ADDMSGD +
003163000000                MSGID(TXT0014) +
003164000000                MSGF(&LIB/&OBJ) +
003165000000                MSG( +
003166000000'Bib:'                                                                +
003167000000                ) +
003168000000                SEV(0) +
003169000000     /*   No replacement variables defined!                         */ +
003170000000                ALROPT(*NO) +
003171000000                CCSID(65535) +
003172000000                /*  -EOF-  */
003173000000
003174000000     /*-------------------------------------------------------------*/
003175000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0015                    */
003176000000     /* Mbr:                                                        */
003177000000     /*-------------------------------------------------------------*/
003178000000
003179000000             RMVMSGD MSGID(TXT0015) MSGF(&LIB/&OBJ)
003180000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003181000000
003182000000             ADDMSGD +
003183000000                MSGID(TXT0015) +
003184000000                MSGF(&LIB/&OBJ) +
003185000000                MSG( +
003186000000'Mbr:'                                                                +
003187000000                ) +
003188000000                SEV(0) +
003189000000     /*   No replacement variables defined!                         */ +
003190000000                ALROPT(*NO) +
003191000000                CCSID(65535) +
003192000000                /*  -EOF-  */
003193000000
003194000000     /*-------------------------------------------------------------*/
003195000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0016                    */
003196000000     /*  Länge:                                                     */
003197000000     /*-------------------------------------------------------------*/
003198000000
003199000000             RMVMSGD MSGID(TXT0016) MSGF(&LIB/&OBJ)
003200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003201000000
003202000000             ADDMSGD +
003203000000                MSGID(TXT0016) +
003204000000                MSGF(&LIB/&OBJ) +
003205000000                MSG( +
003206000000' Länge:'                                                             +
003207000000                ) +
003208000000                SEV(0) +
003209000000     /*   No replacement variables defined!                         */ +
003210000000                ALROPT(*NO) +
003211000000                CCSID(65535) +
003212000000                /*  -EOF-  */
003213000000
003214000000     /*-------------------------------------------------------------*/
003215000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0017                    */
003216000000     /*  Sätze:                                                     */
003217000000     /*-------------------------------------------------------------*/
003218000000
003219000000             RMVMSGD MSGID(TXT0017) MSGF(&LIB/&OBJ)
003220000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003221000000
003222000000             ADDMSGD +
003223000000                MSGID(TXT0017) +
003224000000                MSGF(&LIB/&OBJ) +
003225000000                MSG( +
003226000000' Sätze:'                                                             +
003227000000                ) +
003228000000                SEV(0) +
003229000000     /*   No replacement variables defined!                         */ +
003230000000                ALROPT(*NO) +
003231000000                CCSID(65535) +
003232000000                /*  -EOF-  */
003233000000
003234000000     /*-------------------------------------------------------------*/
003235000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0018                    */
003236000000     /* Feld-Nr. :                                                  */
003237000000     /*-------------------------------------------------------------*/
003238000000
003239000000             RMVMSGD MSGID(TXT0018) MSGF(&LIB/&OBJ)
003240000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003241000000
003242000000             ADDMSGD +
003243000000                MSGID(TXT0018) +
003244000000                MSGF(&LIB/&OBJ) +
003245000000                MSG( +
003246000000'Feld-Nr. :'                                                          +
003247000000                ) +
003248000000                SEV(0) +
003249000000     /*   No replacement variables defined!                         */ +
003250000000                ALROPT(*NO) +
003251000000                CCSID(65535) +
003252000000                /*  -EOF-  */
003253000000
003254000000     /*-------------------------------------------------------------*/
003255000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0019                    */
003256000000     /*     Feldname:                                               */
003257000000     /*-------------------------------------------------------------*/
003258000000
003259000000             RMVMSGD MSGID(TXT0019) MSGF(&LIB/&OBJ)
003260000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003261000000
003262000000             ADDMSGD +
003263000000                MSGID(TXT0019) +
003264000000                MSGF(&LIB/&OBJ) +
003265000000                MSG( +
003266000000'    Feldname:'                                                       +
003267000000                ) +
003268000000                SEV(0) +
003269000000     /*   No replacement variables defined!                         */ +
003270000000                ALROPT(*NO) +
003271000000                CCSID(65535) +
003272000000                /*  -EOF-  */
003273000000
003274000000     /*-------------------------------------------------------------*/
003275000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0020                    */
003276000000     /* Format:                                                     */
003277000000     /*-------------------------------------------------------------*/
003278000000
003279000000             RMVMSGD MSGID(TXT0020) MSGF(&LIB/&OBJ)
003280000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003281000000
003282000000             ADDMSGD +
003283000000                MSGID(TXT0020) +
003284000000                MSGF(&LIB/&OBJ) +
003285000000                MSG( +
003286000000'Format:'                                                             +
003287000000                ) +
003288000000                SEV(0) +
003289000000     /*   No replacement variables defined!                         */ +
003290000000                ALROPT(*NO) +
003291000000                CCSID(65535) +
003292000000                /*  -EOF-  */
003293000000
003294000000     /*-------------------------------------------------------------*/
003295000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0021                    */
003296000000     /*  Größe:                                                     */
003297000000     /*-------------------------------------------------------------*/
003298000000
003299000000             RMVMSGD MSGID(TXT0021) MSGF(&LIB/&OBJ)
003300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003301000000
003302000000             ADDMSGD +
003303000000                MSGID(TXT0021) +
003304000000                MSGF(&LIB/&OBJ) +
003305000000                MSG( +
003306000000' Größe:'                                                             +
003307000000                ) +
003308000000                SEV(0) +
003309000000     /*   No replacement variables defined!                         */ +
003310000000                ALROPT(*NO) +
003311000000                CCSID(65535) +
003312000000                /*  -EOF-  */
003313000000
003314000000     /*-------------------------------------------------------------*/
003315000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0022                    */
003316000000     /* Satz-Nr. :                                                  */
003317000000     /*-------------------------------------------------------------*/
003318000000
003319000000             RMVMSGD MSGID(TXT0022) MSGF(&LIB/&OBJ)
003320000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003321000000
003322000000             ADDMSGD +
003323000000                MSGID(TXT0022) +
003324000000                MSGF(&LIB/&OBJ) +
003325000000                MSG( +
003326000000'Satz-Nr. :'                                                          +
003327000000                ) +
003328000000                SEV(0) +
003329000000     /*   No replacement variables defined!                         */ +
003330000000                ALROPT(*NO) +
003331000000                CCSID(65535) +
003332000000                /*  -EOF-  */
003333000000
003334000000     /*-------------------------------------------------------------*/
003335000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0023                    */
003336000000     /* Schlüssel:                                                  */
003337000000     /*-------------------------------------------------------------*/
003338000000
003339000000             RMVMSGD MSGID(TXT0023) MSGF(&LIB/&OBJ)
003340000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003341000000
003342000000             ADDMSGD +
003343000000                MSGID(TXT0023) +
003344000000                MSGF(&LIB/&OBJ) +
003345000000                MSG( +
003346000000'Schlüssel:'                                                          +
003347000000                ) +
003348000000                SEV(0) +
003349000000     /*   No replacement variables defined!                         */ +
003350000000                ALROPT(*NO) +
003351000000                CCSID(65535) +
003352000000                /*  -EOF-  */
003353000000
003354000000     /*-------------------------------------------------------------*/
003355000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0024                    */
003356000000     /* Auswahl:                                                    */
003357000000     /*-------------------------------------------------------------*/
003358000000
003359000000             RMVMSGD MSGID(TXT0024) MSGF(&LIB/&OBJ)
003360000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003361000000
003362000000             ADDMSGD +
003363000000                MSGID(TXT0024) +
003364000000                MSGF(&LIB/&OBJ) +
003365000000                MSG( +
003366000000'Auswahl:'                                                            +
003367000000                ) +
003368000000                SEV(0) +
003369000000     /*   No replacement variables defined!                         */ +
003370000000                ALROPT(*NO) +
003371000000                CCSID(65535) +
003372000000                /*  -EOF-  */
003373000000
003374000000     /*-------------------------------------------------------------*/
003375000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0025                    */
003376000000     /* (Keine Datensätze gefunden)                                 */
003377000000     /*-------------------------------------------------------------*/
003378000000
003379000000             RMVMSGD MSGID(TXT0025) MSGF(&LIB/&OBJ)
003380000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003381000000
003382000000             ADDMSGD +
003383000000                MSGID(TXT0025) +
003384000000                MSGF(&LIB/&OBJ) +
003385000000                MSG( +
003386000000'(Keine Datensätze gefunden)'                                         +
003387000000                ) +
003388000000                SEV(0) +
003389000000     /*   No replacement variables defined!                         */ +
003390000000                ALROPT(*NO) +
003391000000                CCSID(65535) +
003392000000                /*  -EOF-  */
003393000000
003394000000     /*-------------------------------------------------------------*/
003395000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0026                    */
003396000000     /* 'ENTER' = Löschen ...                                       */
003397000000     /*-------------------------------------------------------------*/
003398000000
003399000000             RMVMSGD MSGID(TXT0026) MSGF(&LIB/&OBJ)
003400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003401000000
003402000000             ADDMSGD +
003403000000                MSGID(TXT0026) +
003404000000                MSGF(&LIB/&OBJ) +
003405000000                MSG( +
003406000000'''ENTER'' = Löschen ...'                                             +
003407000000                ) +
003408000000                SEV(0) +
003409000000     /*   No replacement variables defined!                         */ +
003410000000                ALROPT(*NO) +
003411000000                CCSID(65535) +
003412000000                /*  -EOF-  */
003413000000
003414000000     /*-------------------------------------------------------------*/
003415000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0027                    */
003416000000     /* Datensatzanzeige ...                                        */
003417000000     /*-------------------------------------------------------------*/
003418000000
003419000000             RMVMSGD MSGID(TXT0027) MSGF(&LIB/&OBJ)
003420000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003421000000
003422000000             ADDMSGD +
003423000000                MSGID(TXT0027) +
003424000000                MSGF(&LIB/&OBJ) +
003425000000                MSG( +
003426000000'Datensatzanzeige ...'                                                +
003427000000                ) +
003428000000                SEV(0) +
003429000000     /*   No replacement variables defined!                         */ +
003430000000                ALROPT(*NO) +
003431000000                CCSID(65535) +
003432000000                /*  -EOF-  */
003433000000
003434000000     /*-------------------------------------------------------------*/
003435000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0028                    */
003436000000     /* 'ENTER' = Kopieren ...                                      */
003437000000     /*-------------------------------------------------------------*/
003438000000
003439000000             RMVMSGD MSGID(TXT0028) MSGF(&LIB/&OBJ)
003440000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003441000000
003442000000             ADDMSGD +
003443000000                MSGID(TXT0028) +
003444000000                MSGF(&LIB/&OBJ) +
003445000000                MSG( +
003446000000'''ENTER'' = Kopieren ...'                                            +
003447000000                ) +
003448000000                SEV(0) +
003449000000     /*   No replacement variables defined!                         */ +
003450000000                ALROPT(*NO) +
003451000000                CCSID(65535) +
003452000000                /*  -EOF-  */
003453000000
003454000000     /*-------------------------------------------------------------*/
003455000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0029                    */
003456000000     /* Satz-Nr:                                                    */
003457000000     /*-------------------------------------------------------------*/
003458000000
003459000000             RMVMSGD MSGID(TXT0029) MSGF(&LIB/&OBJ)
003460000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003461000000
003462000000             ADDMSGD +
003463000000                MSGID(TXT0029) +
003464000000                MSGF(&LIB/&OBJ) +
003465000000                MSG( +
003466000000'Satz-Nr:'                                                            +
003467000000                ) +
003468000000                SEV(0) +
003469000000     /*   No replacement variables defined!                         */ +
003470000000                ALROPT(*NO) +
003471000000                CCSID(65535) +
003472000000                /*  -EOF-  */
003473000000
003474000000     /*-------------------------------------------------------------*/
003475000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0030                    */
003476000000     /* Commit-Steuerung                                            */
003477000000     /*-------------------------------------------------------------*/
003478000000
003479000000             RMVMSGD MSGID(TXT0030) MSGF(&LIB/&OBJ)
003480000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003481000000
003482000000             ADDMSGD +
003483000000                MSGID(TXT0030) +
003484000000                MSGF(&LIB/&OBJ) +
003485000000                MSG( +
003486000000'Commit-Steuerung  '                                                  +
003487000000                ) +
003488000000                SEV(0) +
003489000000     /*   No replacement variables defined!                         */ +
003490000000                ALROPT(*NO) +
003491000000                CCSID(65535) +
003492000000                /*  -EOF-  */
003493000000
003494000000     /*-------------------------------------------------------------*/
003495000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0031                    */
003496000000     /* ohne Commitsteuer.                                          */
003497000000     /*-------------------------------------------------------------*/
003498000000
003499000000             RMVMSGD MSGID(TXT0031) MSGF(&LIB/&OBJ)
003500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003501000000
003502000000             ADDMSGD +
003503000000                MSGID(TXT0031) +
003504000000                MSGF(&LIB/&OBJ) +
003505000000                MSG( +
003506000000'ohne Commitsteuer.'                                                  +
003507000000                ) +
003508000000                SEV(0) +
003509000000     /*   No replacement variables defined!                         */ +
003510000000                ALROPT(*NO) +
003511000000                CCSID(65535) +
003512000000                /*  -EOF-  */
003513000000
003514000000     /*-------------------------------------------------------------*/
003515000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0032                    */
003516000000     /* (keine Datensätze gefunden)                                 */
003517000000     /*-------------------------------------------------------------*/
003518000000
003519000000             RMVMSGD MSGID(TXT0032) MSGF(&LIB/&OBJ)
003520000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003521000000
003522000000             ADDMSGD +
003523000000                MSGID(TXT0032) +
003524000000                MSGF(&LIB/&OBJ) +
003525000000                MSG( +
003526000000'(keine Datensätze gefunden)'                                         +
003527000000                ) +
003528000000                SEV(0) +
003529000000     /*   No replacement variables defined!                         */ +
003530000000                ALROPT(*NO) +
003531000000                CCSID(65535) +
003532000000                /*  -EOF-  */
003533000000
003534000000     /*-------------------------------------------------------------*/
003535000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0033                    */
003536000000     /*      - Suchen -                                             */
003537000000     /*-------------------------------------------------------------*/
003538000000
003539000000             RMVMSGD MSGID(TXT0033) MSGF(&LIB/&OBJ)
003540000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003541000000
003542000000             ADDMSGD +
003543000000                MSGID(TXT0033) +
003544000000                MSGF(&LIB/&OBJ) +
003545000000                MSG( +
003546000000'     - Suchen -'                                                     +
003547000000                ) +
003548000000                SEV(0) +
003549000000     /*   No replacement variables defined!                         */ +
003550000000                ALROPT(*NO) +
003551000000                CCSID(65535) +
003552000000                /*  -EOF-  */
003553000000
003554000000     /*-------------------------------------------------------------*/
003555000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0034                    */
003556000000     /*  Feld                                                       */
003557000000     /*-------------------------------------------------------------*/
003558000000
003559000000             RMVMSGD MSGID(TXT0034) MSGF(&LIB/&OBJ)
003560000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003561000000
003562000000             ADDMSGD +
003563000000                MSGID(TXT0034) +
003564000000                MSGF(&LIB/&OBJ) +
003565000000                MSG( +
003566000000' Feld'                                                               +
003567000000                ) +
003568000000                SEV(0) +
003569000000     /*   No replacement variables defined!                         */ +
003570000000                ALROPT(*NO) +
003571000000                CCSID(65535) +
003572000000                /*  -EOF-  */
003573000000
003574000000     /*-------------------------------------------------------------*/
003575000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0035                    */
003576000000     /* Oper.                                                       */
003577000000     /*-------------------------------------------------------------*/
003578000000
003579000000             RMVMSGD MSGID(TXT0035) MSGF(&LIB/&OBJ)
003580000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003581000000
003582000000             ADDMSGD +
003583000000                MSGID(TXT0035) +
003584000000                MSGF(&LIB/&OBJ) +
003585000000                MSG( +
003586000000'Oper.'                                                               +
003587000000                ) +
003588000000                SEV(0) +
003589000000     /*   No replacement variables defined!                         */ +
003590000000                ALROPT(*NO) +
003591000000                CCSID(65535) +
003592000000                /*  -EOF-  */
003593000000
003594000000     /*-------------------------------------------------------------*/
003595000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0036                    */
003596000000     /* Wert (ohne Hochkomma)                                       */
003597000000     /*-------------------------------------------------------------*/
003598000000
003599000000             RMVMSGD MSGID(TXT0036) MSGF(&LIB/&OBJ)
003600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003601000000
003602000000             ADDMSGD +
003603000000                MSGID(TXT0036) +
003604000000                MSGF(&LIB/&OBJ) +
003605000000                MSG( +
003606000000'Wert (ohne Hochkomma)'                                               +
003607000000                ) +
003608000000                SEV(0) +
003609000000     /*   No replacement variables defined!                         */ +
003610000000                ALROPT(*NO) +
003611000000                CCSID(65535) +
003612000000                /*  -EOF-  */
003613000000
003614000000     /*-------------------------------------------------------------*/
003615000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0037                    */
003616000000     /* generische Suche)                                           */
003617000000     /*-------------------------------------------------------------*/
003618000000
003619000000             RMVMSGD MSGID(TXT0037) MSGF(&LIB/&OBJ)
003620000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003621000000
003622000000             ADDMSGD +
003623000000                MSGID(TXT0037) +
003624000000                MSGF(&LIB/&OBJ) +
003625000000                MSG( +
003626000000'generische Suche)'                                                   +
003627000000                ) +
003628000000                SEV(0) +
003629000000     /*   No replacement variables defined!                         */ +
003630000000                ALROPT(*NO) +
003631000000                CCSID(65535) +
003632000000                /*  -EOF-  */
003633000000
003634000000     /*-------------------------------------------------------------*/
003635000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0038                    */
003636000000     /* Max.Anz. Sätze:                                             */
003637000000     /*-------------------------------------------------------------*/
003638000000
003639000000             RMVMSGD MSGID(TXT0038) MSGF(&LIB/&OBJ)
003640000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003641000000
003642000000             ADDMSGD +
003643000000                MSGID(TXT0038) +
003644000000                MSGF(&LIB/&OBJ) +
003645000000                MSG( +
003646000000'Max.Anz. Sätze:'                                                     +
003647000000                ) +
003648000000                SEV(0) +
003649000000     /*   No replacement variables defined!                         */ +
003650000000                ALROPT(*NO) +
003651000000                CCSID(65535) +
003652000000                /*  -EOF-  */
003653000000
003654000000     /*-------------------------------------------------------------*/
003655000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0039                    */
003656000000     /* Art der Suche :                                             */
003657000000     /*-------------------------------------------------------------*/
003658000000
003659000000             RMVMSGD MSGID(TXT0039) MSGF(&LIB/&OBJ)
003660000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003661000000
003662000000             ADDMSGD +
003663000000                MSGID(TXT0039) +
003664000000                MSGF(&LIB/&OBJ) +
003665000000                MSG( +
003666000000'Art der Suche :'                                                     +
003667000000                ) +
003668000000                SEV(0) +
003669000000     /*   No replacement variables defined!                         */ +
003670000000                ALROPT(*NO) +
003671000000                CCSID(65535) +
003672000000                /*  -EOF-  */
003673000000
003674000000     /*-------------------------------------------------------------*/
003675000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0040                    */
003676000000     /* (Normal/Underline/Reverse/Pin)                              */
003677000000     /*-------------------------------------------------------------*/
003678000000
003679000000             RMVMSGD MSGID(TXT0040) MSGF(&LIB/&OBJ)
003680000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003681000000
003682000000             ADDMSGD +
003683000000                MSGID(TXT0040) +
003684000000                MSGF(&LIB/&OBJ) +
003685000000                MSG( +
003686000000'(Normal/Underline/Reverse/Pin)'                                      +
003687000000                ) +
003688000000                SEV(0) +
003689000000     /*   No replacement variables defined!                         */ +
003690000000                ALROPT(*NO) +
003691000000                CCSID(65535) +
003692000000                /*  -EOF-  */
003693000000
003694000000     /*-------------------------------------------------------------*/
003695000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0041                    */
003696000000     /* Groß-/Klein ..:                                             */
003697000000     /*-------------------------------------------------------------*/
003698000000
003699000000             RMVMSGD MSGID(TXT0041) MSGF(&LIB/&OBJ)
003700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003701000000
003702000000             ADDMSGD +
003703000000                MSGID(TXT0041) +
003704000000                MSGF(&LIB/&OBJ) +
003705000000                MSG( +
003706000000'Groß-/Klein ..:'                                                     +
003707000000                ) +
003708000000                SEV(0) +
003709000000     /*   No replacement variables defined!                         */ +
003710000000                ALROPT(*NO) +
003711000000                CCSID(65535) +
003712000000                /*  -EOF-  */
003713000000
003714000000     /*-------------------------------------------------------------*/
003715000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0042                    */
003716000000     /* (1=Ja; 0=Nein)                                              */
003717000000     /*-------------------------------------------------------------*/
003718000000
003719000000             RMVMSGD MSGID(TXT0042) MSGF(&LIB/&OBJ)
003720000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003721000000
003722000000             ADDMSGD +
003723000000                MSGID(TXT0042) +
003724000000                MSGF(&LIB/&OBJ) +
003725000000                MSG( +
003726000000'(1=Ja; 0=Nein)'                                                      +
003727000000                ) +
003728000000                SEV(0) +
003729000000     /*   No replacement variables defined!                         */ +
003730000000                ALROPT(*NO) +
003731000000                CCSID(65535) +
003732000000                /*  -EOF-  */
003733000000
003734000000     /*-------------------------------------------------------------*/
003735000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0043                    */
003736000000     /* - Farbeinstellung -                                         */
003737000000     /*-------------------------------------------------------------*/
003738000000
003739000000             RMVMSGD MSGID(TXT0043) MSGF(&LIB/&OBJ)
003740000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003741000000
003742000000             ADDMSGD +
003743000000                MSGID(TXT0043) +
003744000000                MSGF(&LIB/&OBJ) +
003745000000                MSG( +
003746000000'- Farbeinstellung -'                                                 +
003747000000                ) +
003748000000                SEV(0) +
003749000000     /*   No replacement variables defined!                         */ +
003750000000                ALROPT(*NO) +
003751000000                CCSID(65535) +
003752000000                /*  -EOF-  */
003753000000
003754000000     /*-------------------------------------------------------------*/
003755000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0044                    */
003756000000     /*   - Farbauswahl -                                           */
003757000000     /*-------------------------------------------------------------*/
003758000000
003759000000             RMVMSGD MSGID(TXT0044) MSGF(&LIB/&OBJ)
003760000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003761000000
003762000000             ADDMSGD +
003763000000                MSGID(TXT0044) +
003764000000                MSGF(&LIB/&OBJ) +
003765000000                MSG( +
003766000000'  - Farbauswahl -'                                                   +
003767000000                ) +
003768000000                SEV(0) +
003769000000     /*   No replacement variables defined!                         */ +
003770000000                ALROPT(*NO) +
003771000000                CCSID(65535) +
003772000000                /*  -EOF-  */
003773000000
003774000000     /*-------------------------------------------------------------*/
003775000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0045                    */
003776000000     /* Grün                                                        */
003777000000     /*-------------------------------------------------------------*/
003778000000
003779000000             RMVMSGD MSGID(TXT0045) MSGF(&LIB/&OBJ)
003780000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003781000000
003782000000             ADDMSGD +
003783000000                MSGID(TXT0045) +
003784000000                MSGF(&LIB/&OBJ) +
003785000000                MSG( +
003786000000'Grün     '                                                           +
003787000000                ) +
003788000000                SEV(0) +
003789000000     /*   No replacement variables defined!                         */ +
003790000000                ALROPT(*NO) +
003791000000                CCSID(65535) +
003792000000                /*  -EOF-  */
003793000000
003794000000     /*-------------------------------------------------------------*/
003795000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0046                    */
003796000000     /* Weiß                                                        */
003797000000     /*-------------------------------------------------------------*/
003798000000
003799000000             RMVMSGD MSGID(TXT0046) MSGF(&LIB/&OBJ)
003800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003801000000
003802000000             ADDMSGD +
003803000000                MSGID(TXT0046) +
003804000000                MSGF(&LIB/&OBJ) +
003805000000                MSG( +
003806000000'Weiß     '                                                           +
003807000000                ) +
003808000000                SEV(0) +
003809000000     /*   No replacement variables defined!                         */ +
003810000000                ALROPT(*NO) +
003811000000                CCSID(65535) +
003812000000                /*  -EOF-  */
003813000000
003814000000     /*-------------------------------------------------------------*/
003815000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0047                    */
003816000000     /* Rot                                                         */
003817000000     /*-------------------------------------------------------------*/
003818000000
003819000000             RMVMSGD MSGID(TXT0047) MSGF(&LIB/&OBJ)
003820000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003821000000
003822000000             ADDMSGD +
003823000000                MSGID(TXT0047) +
003824000000                MSGF(&LIB/&OBJ) +
003825000000                MSG( +
003826000000'Rot      '                                                           +
003827000000                ) +
003828000000                SEV(0) +
003829000000     /*   No replacement variables defined!                         */ +
003830000000                ALROPT(*NO) +
003831000000                CCSID(65535) +
003832000000                /*  -EOF-  */
003833000000
003834000000     /*-------------------------------------------------------------*/
003835000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0048                    */
003836000000     /* Türkis                                                      */
003837000000     /*-------------------------------------------------------------*/
003838000000
003839000000             RMVMSGD MSGID(TXT0048) MSGF(&LIB/&OBJ)
003840000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003841000000
003842000000             ADDMSGD +
003843000000                MSGID(TXT0048) +
003844000000                MSGF(&LIB/&OBJ) +
003845000000                MSG( +
003846000000'Türkis   '                                                           +
003847000000                ) +
003848000000                SEV(0) +
003849000000     /*   No replacement variables defined!                         */ +
003850000000                ALROPT(*NO) +
003851000000                CCSID(65535) +
003852000000                /*  -EOF-  */
003853000000
003854000000     /*-------------------------------------------------------------*/
003855000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0049                    */
003856000000     /* Gelb                                                        */
003857000000     /*-------------------------------------------------------------*/
003858000000
003859000000             RMVMSGD MSGID(TXT0049) MSGF(&LIB/&OBJ)
003860000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003861000000
003862000000             ADDMSGD +
003863000000                MSGID(TXT0049) +
003864000000                MSGF(&LIB/&OBJ) +
003865000000                MSG( +
003866000000'Gelb     '                                                           +
003867000000                ) +
003868000000                SEV(0) +
003869000000     /*   No replacement variables defined!                         */ +
003870000000                ALROPT(*NO) +
003871000000                CCSID(65535) +
003872000000                /*  -EOF-  */
003873000000
003874000000     /*-------------------------------------------------------------*/
003875000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0050                    */
003876000000     /* Rosa                                                        */
003877000000     /*-------------------------------------------------------------*/
003878000000
003879000000             RMVMSGD MSGID(TXT0050) MSGF(&LIB/&OBJ)
003880000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003881000000
003882000000             ADDMSGD +
003883000000                MSGID(TXT0050) +
003884000000                MSGF(&LIB/&OBJ) +
003885000000                MSG( +
003886000000'Rosa     '                                                           +
003887000000                ) +
003888000000                SEV(0) +
003889000000     /*   No replacement variables defined!                         */ +
003890000000                ALROPT(*NO) +
003891000000                CCSID(65535) +
003892000000                /*  -EOF-  */
003893000000
003894000000     /*-------------------------------------------------------------*/
003895000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0051                    */
003896000000     /* Blau                                                        */
003897000000     /*-------------------------------------------------------------*/
003898000000
003899000000             RMVMSGD MSGID(TXT0051) MSGF(&LIB/&OBJ)
003900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003901000000
003902000000             ADDMSGD +
003903000000                MSGID(TXT0051) +
003904000000                MSGF(&LIB/&OBJ) +
003905000000                MSG( +
003906000000'Blau     '                                                           +
003907000000                ) +
003908000000                SEV(0) +
003909000000     /*   No replacement variables defined!                         */ +
003910000000                ALROPT(*NO) +
003911000000                CCSID(65535) +
003912000000                /*  -EOF-  */
003913000000
003914000000     /*-------------------------------------------------------------*/
003915000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0052                    */
003916000000     /*  - ext. Kopieren -                                          */
003917000000     /*-------------------------------------------------------------*/
003918000000
003919000000             RMVMSGD MSGID(TXT0052) MSGF(&LIB/&OBJ)
003920000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003921000000
003922000000             ADDMSGD +
003923000000                MSGID(TXT0052) +
003924000000                MSGF(&LIB/&OBJ) +
003925000000                MSG( +
003926000000' - ext. Kopieren -'                                                  +
003927000000                ) +
003928000000                SEV(0) +
003929000000     /*   No replacement variables defined!                         */ +
003930000000                ALROPT(*NO) +
003931000000                CCSID(65535) +
003932000000                /*  -EOF-  */
003933000000
003934000000     /*-------------------------------------------------------------*/
003935000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0053                    */
003936000000     /* Datei ...........:                                          */
003937000000     /*-------------------------------------------------------------*/
003938000000
003939000000             RMVMSGD MSGID(TXT0053) MSGF(&LIB/&OBJ)
003940000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003941000000
003942000000             ADDMSGD +
003943000000                MSGID(TXT0053) +
003944000000                MSGF(&LIB/&OBJ) +
003945000000                MSG( +
003946000000'Datei ...........:'                                                  +
003947000000                ) +
003948000000                SEV(0) +
003949000000     /*   No replacement variables defined!                         */ +
003950000000                ALROPT(*NO) +
003951000000                CCSID(65535) +
003952000000                /*  -EOF-  */
003953000000
003954000000     /*-------------------------------------------------------------*/
003955000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0054                    */
003956000000     /* Bibliothek ......:                                          */
003957000000     /*-------------------------------------------------------------*/
003958000000
003959000000             RMVMSGD MSGID(TXT0054) MSGF(&LIB/&OBJ)
003960000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003961000000
003962000000             ADDMSGD +
003963000000                MSGID(TXT0054) +
003964000000                MSGF(&LIB/&OBJ) +
003965000000                MSG( +
003966000000'Bibliothek ......:'                                                  +
003967000000                ) +
003968000000                SEV(0) +
003969000000     /*   No replacement variables defined!                         */ +
003970000000                ALROPT(*NO) +
003971000000                CCSID(65535) +
003972000000                /*  -EOF-  */
003973000000
003974000000     /*-------------------------------------------------------------*/
003975000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0055                    */
003976000000     /* Teildatei .......:                                          */
003977000000     /*-------------------------------------------------------------*/
003978000000
003979000000             RMVMSGD MSGID(TXT0055) MSGF(&LIB/&OBJ)
003980000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003981000000
003982000000             ADDMSGD +
003983000000                MSGID(TXT0055) +
003984000000                MSGF(&LIB/&OBJ) +
003985000000                MSG( +
003986000000'Teildatei .......:'                                                  +
003987000000                ) +
003988000000                SEV(0) +
003989000000     /*   No replacement variables defined!                         */ +
003990000000                ALROPT(*NO) +
003991000000                CCSID(65535) +
003992000000                /*  -EOF-  */
003993000000
003994000000     /*-------------------------------------------------------------*/
003995000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0056                    */
003996000000     /* Sätze ersetzen ..:                                          */
003997000000     /*-------------------------------------------------------------*/
003998000000
003999000000             RMVMSGD MSGID(TXT0056) MSGF(&LIB/&OBJ)
004000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004001000000
004002000000             ADDMSGD +
004003000000                MSGID(TXT0056) +
004004000000                MSGF(&LIB/&OBJ) +
004005000000                MSG( +
004006000000'Sätze ersetzen ..:'                                                  +
004007000000                ) +
004008000000                SEV(0) +
004009000000     /*   No replacement variables defined!                         */ +
004010000000                ALROPT(*NO) +
004011000000                CCSID(65535) +
004012000000                /*  -EOF-  */
004013000000
004014000000     /*-------------------------------------------------------------*/
004015000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0057                    */
004016000000     /* Datei erstellen .:                                          */
004017000000     /*-------------------------------------------------------------*/
004018000000
004019000000             RMVMSGD MSGID(TXT0057) MSGF(&LIB/&OBJ)
004020000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004021000000
004022000000             ADDMSGD +
004023000000                MSGID(TXT0057) +
004024000000                MSGF(&LIB/&OBJ) +
004025000000                MSG( +
004026000000'Datei erstellen .:'                                                  +
004027000000                ) +
004028000000                SEV(0) +
004029000000     /*   No replacement variables defined!                         */ +
004030000000                ALROPT(*NO) +
004031000000                CCSID(65535) +
004032000000                /*  -EOF-  */
004033000000
004034000000     /*-------------------------------------------------------------*/
004035000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0058                    */
004036000000     /*   - Lizenzdaten -                                           */
004037000000     /*-------------------------------------------------------------*/
004038000000
004039000000             RMVMSGD MSGID(TXT0058) MSGF(&LIB/&OBJ)
004040000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004041000000
004042000000             ADDMSGD +
004043000000                MSGID(TXT0058) +
004044000000                MSGF(&LIB/&OBJ) +
004045000000                MSG( +
004046000000'  - Lizenzdaten -'                                                   +
004047000000                ) +
004048000000                SEV(0) +
004049000000     /*   No replacement variables defined!                         */ +
004050000000                ALROPT(*NO) +
004051000000                CCSID(65535) +
004052000000                /*  -EOF-  */
004053000000
004054000000     /*-------------------------------------------------------------*/
004055000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0059                    */
004056000000     /*  Lizenz-Nr:                                                 */
004057000000     /*-------------------------------------------------------------*/
004058000000
004059000000             RMVMSGD MSGID(TXT0059) MSGF(&LIB/&OBJ)
004060000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004061000000
004062000000             ADDMSGD +
004063000000                MSGID(TXT0059) +
004064000000                MSGF(&LIB/&OBJ) +
004065000000                MSG( +
004066000000' Lizenz-Nr:'                                                         +
004067000000                ) +
004068000000                SEV(0) +
004069000000     /*   No replacement variables defined!                         */ +
004070000000                ALROPT(*NO) +
004071000000                CCSID(65535) +
004072000000                /*  -EOF-  */
004073000000
004074000000     /*-------------------------------------------------------------*/
004075000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0060                    */
004076000000     /* F9=Testen                                                   */
004077000000     /*-------------------------------------------------------------*/
004078000000
004079000000             RMVMSGD MSGID(TXT0060) MSGF(&LIB/&OBJ)
004080000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004081000000
004082000000             ADDMSGD +
004083000000                MSGID(TXT0060) +
004084000000                MSGF(&LIB/&OBJ) +
004085000000                MSG( +
004086000000'F9=Testen'                                                           +
004087000000                ) +
004088000000                SEV(0) +
004089000000     /*   No replacement variables defined!                         */ +
004090000000                ALROPT(*NO) +
004091000000                CCSID(65535) +
004092000000                /*  -EOF-  */
004093000000
004094000000     /*-------------------------------------------------------------*/
004095000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0061                    */
004096000000     /* Lizenzdaten wurden gesichert!                               */
004097000000     /*-------------------------------------------------------------*/
004098000000
004099000000             RMVMSGD MSGID(TXT0061) MSGF(&LIB/&OBJ)
004100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004101000000
004102000000             ADDMSGD +
004103000000                MSGID(TXT0061) +
004104000000                MSGF(&LIB/&OBJ) +
004105000000                MSG( +
004106000000'Lizenzdaten wurden gesichert!'                                       +
004107000000                ) +
004108000000                SEV(0) +
004109000000     /*   No replacement variables defined!                         */ +
004110000000                ALROPT(*NO) +
004111000000                CCSID(65535) +
004112000000                /*  -EOF-  */
004113000000
004114000000     /*-------------------------------------------------------------*/
004115000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0062                    */
004116000000     /* Sorry, der Testzeitraum ist abgelaufen.                     */
004117000000     /*-------------------------------------------------------------*/
004118000000
004119000000             RMVMSGD MSGID(TXT0062) MSGF(&LIB/&OBJ)
004120000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004121000000
004122000000             ADDMSGD +
004123000000                MSGID(TXT0062) +
004124000000                MSGF(&LIB/&OBJ) +
004125000000                MSG( +
004126000000'Sorry, der Testzeitraum ist abgelaufen.'                             +
004127000000                ) +
004128000000                SEV(0) +
004129000000     /*   No replacement variables defined!                         */ +
004130000000                ALROPT(*NO) +
004131000000                CCSID(65535) +
004132000000                /*  -EOF-  */
004133000000
004134000000     /*-------------------------------------------------------------*/
004135000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0063                    */
004136000000     /* 'ENTER' = Ändern ...                                        */
004137000000     /*-------------------------------------------------------------*/
004138000000
004139000000             RMVMSGD MSGID(TXT0063) MSGF(&LIB/&OBJ)
004140000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004141000000
004142000000             ADDMSGD +
004143000000                MSGID(TXT0063) +
004144000000                MSGF(&LIB/&OBJ) +
004145000000                MSG( +
004146000000'''ENTER'' = Ändern ...'                                              +
004147000000                ) +
004148000000                SEV(0) +
004149000000     /*   No replacement variables defined!                         */ +
004150000000                ALROPT(*NO) +
004151000000                CCSID(65535) +
004152000000                /*  -EOF-  */
004153000000
004154000000     /*-------------------------------------------------------------*/
004155000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0064                    */
004156000000     /* 'ENTER' = Kopieren ...                                      */
004157000000     /*-------------------------------------------------------------*/
004158000000
004159000000             RMVMSGD MSGID(TXT0064) MSGF(&LIB/&OBJ)
004160000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004161000000
004162000000             ADDMSGD +
004163000000                MSGID(TXT0064) +
004164000000                MSGF(&LIB/&OBJ) +
004165000000                MSG( +
004166000000'''ENTER'' = Kopieren ...'                                            +
004167000000                ) +
004168000000                SEV(0) +
004169000000     /*   No replacement variables defined!                         */ +
004170000000                ALROPT(*NO) +
004171000000                CCSID(65535) +
004172000000                /*  -EOF-  */
004173000000
004174000000     /*-------------------------------------------------------------*/
004175000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0065                    */
004176000000     /* 'ENTER' = Einfügen ...                                      */
004177000000     /*-------------------------------------------------------------*/
004178000000
004179000000             RMVMSGD MSGID(TXT0065) MSGF(&LIB/&OBJ)
004180000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004181000000
004182000000             ADDMSGD +
004183000000                MSGID(TXT0065) +
004184000000                MSGF(&LIB/&OBJ) +
004185000000                MSG( +
004186000000'''ENTER'' = Einfügen ...'                                            +
004187000000                ) +
004188000000                SEV(0) +
004189000000     /*   No replacement variables defined!                         */ +
004190000000                ALROPT(*NO) +
004191000000                CCSID(65535) +
004192000000                /*  -EOF-  */
004193000000
004194000000     /*-------------------------------------------------------------*/
004195000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0066                    */
004196000000     /* Weitere ...                                                 */
004197000000     /*-------------------------------------------------------------*/
004198000000
004199000000             RMVMSGD MSGID(TXT0066) MSGF(&LIB/&OBJ)
004200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004201000000
004202000000             ADDMSGD +
004203000000                MSGID(TXT0066) +
004204000000                MSGF(&LIB/&OBJ) +
004205000000                MSG( +
004206000000'Weitere ...'                                                         +
004207000000                ) +
004208000000                SEV(0) +
004209000000     /*   No replacement variables defined!                         */ +
004210000000                ALROPT(*NO) +
004211000000                CCSID(65535) +
004212000000                /*  -EOF-  */
004213000000
004214000000     /*-------------------------------------------------------------*/
004215000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0067                    */
004216000000     /*        Ende                                                 */
004217000000     /*-------------------------------------------------------------*/
004218000000
004219000000             RMVMSGD MSGID(TXT0067) MSGF(&LIB/&OBJ)
004220000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004221000000
004222000000             ADDMSGD +
004223000000                MSGID(TXT0067) +
004224000000                MSGF(&LIB/&OBJ) +
004225000000                MSG( +
004226000000'       Ende'                                                         +
004227000000                ) +
004228000000                SEV(0) +
004229000000     /*   No replacement variables defined!                         */ +
004230000000                ALROPT(*NO) +
004231000000                CCSID(65535) +
004232000000                /*  -EOF-  */
004233000000
004234000000     /*-------------------------------------------------------------*/
004235000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0068                    */
004236000000     /* Commit & Rollback                                           */
004237000000     /*-------------------------------------------------------------*/
004238000000
004239000000             RMVMSGD MSGID(TXT0068) MSGF(&LIB/&OBJ)
004240000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004241000000
004242000000             ADDMSGD +
004243000000                MSGID(TXT0068) +
004244000000                MSGF(&LIB/&OBJ) +
004245000000                MSG( +
004246000000'Commit & Rollback'                                                   +
004247000000                ) +
004248000000                SEV(0) +
004249000000     /*   No replacement variables defined!                         */ +
004250000000                ALROPT(*NO) +
004251000000                CCSID(65535) +
004252000000                /*  -EOF-  */
004253000000
004254000000     /*-------------------------------------------------------------*/
004255000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0069                    */
004256000000     /* 80-/132- Zeichen Modus                                      */
004257000000     /*-------------------------------------------------------------*/
004258000000
004259000000             RMVMSGD MSGID(TXT0069) MSGF(&LIB/&OBJ)
004260000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004261000000
004262000000             ADDMSGD +
004263000000                MSGID(TXT0069) +
004264000000                MSGF(&LIB/&OBJ) +
004265000000                MSG( +
004266000000'80-/132- Zeichen Modus'                                              +
004267000000                ) +
004268000000                SEV(0) +
004269000000     /*   No replacement variables defined!                         */ +
004270000000                ALROPT(*NO) +
004271000000                CCSID(65535) +
004272000000                /*  -EOF-  */
004273000000
004274000000     /*-------------------------------------------------------------*/
004275000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0070                    */
004276000000     /* Flexible Suchfunktionen                                     */
004277000000     /*-------------------------------------------------------------*/
004278000000
004279000000             RMVMSGD MSGID(TXT0070) MSGF(&LIB/&OBJ)
004280000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004281000000
004282000000             ADDMSGD +
004283000000                MSGID(TXT0070) +
004284000000                MSGF(&LIB/&OBJ) +
004285000000                MSG( +
004286000000'Flexible Suchfunktionen'                                             +
004287000000                ) +
004288000000                SEV(0) +
004289000000     /*   No replacement variables defined!                         */ +
004290000000                ALROPT(*NO) +
004291000000                CCSID(65535) +
004292000000                /*  -EOF-  */
004293000000
004294000000     /*-------------------------------------------------------------*/
004295000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0071                    */
004296000000     /* Indiv. Tastaturbelegung                                     */
004297000000     /*-------------------------------------------------------------*/
004298000000
004299000000             RMVMSGD MSGID(TXT0071) MSGF(&LIB/&OBJ)
004300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004301000000
004302000000             ADDMSGD +
004303000000                MSGID(TXT0071) +
004304000000                MSGF(&LIB/&OBJ) +
004305000000                MSG( +
004306000000'Indiv. Tastaturbelegung'                                             +
004307000000                ) +
004308000000                SEV(0) +
004309000000     /*   No replacement variables defined!                         */ +
004310000000                ALROPT(*NO) +
004311000000                CCSID(65535) +
004312000000                /*  -EOF-  */
004313000000
004314000000     /*-------------------------------------------------------------*/
004315000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0072                    */
004316000000     /* Indiv. Spracherweiterungen                                  */
004317000000     /*-------------------------------------------------------------*/
004318000000
004319000000             RMVMSGD MSGID(TXT0072) MSGF(&LIB/&OBJ)
004320000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004321000000
004322000000             ADDMSGD +
004323000000                MSGID(TXT0072) +
004324000000                MSGF(&LIB/&OBJ) +
004325000000                MSG( +
004326000000'Indiv. Spracherweiterungen'                                          +
004327000000                ) +
004328000000                SEV(0) +
004329000000     /*   No replacement variables defined!                         */ +
004330000000                ALROPT(*NO) +
004331000000                CCSID(65535) +
004332000000                /*  -EOF-  */
004333000000
004334000000     /*-------------------------------------------------------------*/
004335000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0073                    */
004336000000     /*  Der ultimative                                             */
004337000000     /*-------------------------------------------------------------*/
004338000000
004339000000             RMVMSGD MSGID(TXT0073) MSGF(&LIB/&OBJ)
004340000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004341000000
004342000000             ADDMSGD +
004343000000                MSGID(TXT0073) +
004344000000                MSGF(&LIB/&OBJ) +
004345000000                MSG( +
004346000000' Der ultimative'                                                     +
004347000000                ) +
004348000000                SEV(0) +
004349000000     /*   No replacement variables defined!                         */ +
004350000000                ALROPT(*NO) +
004351000000                CCSID(65535) +
004352000000                /*  -EOF-  */
004353000000
004354000000     /*-------------------------------------------------------------*/
004355000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0074                    */
004356000000     /* Datenbankbrowser                                            */
004357000000     /*-------------------------------------------------------------*/
004358000000
004359000000             RMVMSGD MSGID(TXT0074) MSGF(&LIB/&OBJ)
004360000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004361000000
004362000000             ADDMSGD +
004363000000                MSGID(TXT0074) +
004364000000                MSGF(&LIB/&OBJ) +
004365000000                MSG( +
004366000000'Datenbankbrowser'                                                    +
004367000000                ) +
004368000000                SEV(0) +
004369000000     /*   No replacement variables defined!                         */ +
004370000000                ALROPT(*NO) +
004371000000                CCSID(65535) +
004372000000                /*  -EOF-  */
004373000000
004374000000     /*-------------------------------------------------------------*/
004375000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0075                    */
004376000000     /*         * Highlights *                                      */
004377000000     /*-------------------------------------------------------------*/
004378000000
004379000000             RMVMSGD MSGID(TXT0075) MSGF(&LIB/&OBJ)
004380000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004381000000
004382000000             ADDMSGD +
004383000000                MSGID(TXT0075) +
004384000000                MSGF(&LIB/&OBJ) +
004385000000                MSG( +
004386000000'        * Highlights *        '                                      +
004387000000                ) +
004388000000                SEV(0) +
004389000000     /*   No replacement variables defined!                         */ +
004390000000                ALROPT(*NO) +
004391000000                CCSID(65535) +
004392000000                /*  -EOF-  */
004393000000
004394000000     /*-------------------------------------------------------------*/
004395000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0076                    */
004396000000     /* Unzulässige Zeichen                                         */
004397000000     /*-------------------------------------------------------------*/
004398000000
004399000000             RMVMSGD MSGID(TXT0076) MSGF(&LIB/&OBJ)
004400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004401000000
004402000000             ADDMSGD +
004403000000                MSGID(TXT0076) +
004404000000                MSGF(&LIB/&OBJ) +
004405000000                MSG( +
004406000000'Unzulässige Zeichen'                                                 +
004407000000                ) +
004408000000                SEV(0) +
004409000000     /*   No replacement variables defined!                         */ +
004410000000                ALROPT(*NO) +
004411000000                CCSID(65535) +
004412000000                /*  -EOF-  */
004413000000
004414000000     /*-------------------------------------------------------------*/
004415000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0077                    */
004416000000     /* - Layout -                                                  */
004417000000     /*-------------------------------------------------------------*/
004418000000
004419000000             RMVMSGD MSGID(TXT0077) MSGF(&LIB/&OBJ)
004420000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004421000000
004422000000             ADDMSGD +
004423000000                MSGID(TXT0077) +
004424000000                MSGF(&LIB/&OBJ) +
004425000000                MSG( +
004426000000'- Layout -'                                                          +
004427000000                ) +
004428000000                SEV(0) +
004429000000     /*   No replacement variables defined!                         */ +
004430000000                ALROPT(*NO) +
004431000000                CCSID(65535) +
004432000000                /*  -EOF-  */
004433000000
004434000000     /*-------------------------------------------------------------*/
004435000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0078                    */
004436000000     /* Suchen:                                                     */
004437000000     /*-------------------------------------------------------------*/
004438000000
004439000000             RMVMSGD MSGID(TXT0078) MSGF(&LIB/&OBJ)
004440000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004441000000
004442000000             ADDMSGD +
004443000000                MSGID(TXT0078) +
004444000000                MSGF(&LIB/&OBJ) +
004445000000                MSG( +
004446000000'Suchen:'                                                             +
004447000000                ) +
004448000000                SEV(0) +
004449000000     /*   No replacement variables defined!                         */ +
004450000000                ALROPT(*NO) +
004451000000                CCSID(65535) +
004452000000                /*  -EOF-  */
004453000000
004454000000     /*-------------------------------------------------------------*/
004455000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0079                    */
004456000000     /*  A   Folge  Feld        Bezeichnung                     Typ */
004457000000     /*-------------------------------------------------------------*/
004458000000
004459000000             RMVMSGD MSGID(TXT0079) MSGF(&LIB/&OBJ)
004460000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004461000000
004462000000             ADDMSGD +
004463000000                MSGID(TXT0079) +
004464000000                MSGF(&LIB/&OBJ) +
004465000000                MSG( +
004466000000' A   Folge  Feld        Bezeichnung                     Typ        St-
004467000000rPos '                                                                +
004468000000                ) +
004469000000                SEV(0) +
004470000000     /*   No replacement variables defined!                         */ +
004471000000                ALROPT(*NO) +
004472000000                CCSID(65535) +
004473000000                /*  -EOF-  */
004474000000
004475000000     /*-------------------------------------------------------------*/
004476000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0080                    */
004477000000     /* Sichtbar .:                                                 */
004478000000     /*-------------------------------------------------------------*/
004479000000
004480000000             RMVMSGD MSGID(TXT0080) MSGF(&LIB/&OBJ)
004481000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004482000000
004483000000             ADDMSGD +
004484000000                MSGID(TXT0080) +
004485000000                MSGF(&LIB/&OBJ) +
004486000000                MSG( +
004487000000'Sichtbar .:'                                                         +
004488000000                ) +
004489000000                SEV(0) +
004490000000     /*   No replacement variables defined!                         */ +
004491000000                ALROPT(*NO) +
004492000000                CCSID(65535) +
004493000000                /*  -EOF-  */
004494000000
004495000000     /*-------------------------------------------------------------*/
004496000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0081                    */
004497000000     /* Farbe ..:                                                   */
004498000000     /*-------------------------------------------------------------*/
004499000000
004500000000             RMVMSGD MSGID(TXT0081) MSGF(&LIB/&OBJ)
004501000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004502000000
004503000000             ADDMSGD +
004504000000                MSGID(TXT0081) +
004505000000                MSGF(&LIB/&OBJ) +
004506000000                MSG( +
004507000000'Farbe ..:'                                                           +
004508000000                ) +
004509000000                SEV(0) +
004510000000     /*   No replacement variables defined!                         */ +
004511000000                ALROPT(*NO) +
004512000000                CCSID(65535) +
004513000000                /*  -EOF-  */
004514000000
004515000000     /*-------------------------------------------------------------*/
004516000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0082                    */
004517000000     /* Markierung:                                                 */
004518000000     /*-------------------------------------------------------------*/
004519000000
004520000000             RMVMSGD MSGID(TXT0082) MSGF(&LIB/&OBJ)
004521000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004522000000
004523000000             ADDMSGD +
004524000000                MSGID(TXT0082) +
004525000000                MSGF(&LIB/&OBJ) +
004526000000                MSG( +
004527000000'Markierung:'                                                         +
004528000000                ) +
004529000000                SEV(0) +
004530000000     /*   No replacement variables defined!                         */ +
004531000000                ALROPT(*NO) +
004532000000                CCSID(65535) +
004533000000                /*  -EOF-  */
004534000000
004535000000     /*-------------------------------------------------------------*/
004536000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0083                    */
004537000000     /* Max.Breite:                                                 */
004538000000     /*-------------------------------------------------------------*/
004539000000
004540000000             RMVMSGD MSGID(TXT0083) MSGF(&LIB/&OBJ)
004541000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004542000000
004543000000             ADDMSGD +
004544000000                MSGID(TXT0083) +
004545000000                MSGF(&LIB/&OBJ) +
004546000000                MSG( +
004547000000'Max.Breite:'                                                         +
004548000000                ) +
004549000000                SEV(0) +
004550000000     /*   No replacement variables defined!                         */ +
004551000000                ALROPT(*NO) +
004552000000                CCSID(65535) +
004553000000                /*  -EOF-  */
004554000000
004555000000     /*-------------------------------------------------------------*/
004556000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0084                    */
004557000000     /* Editcode:                                                   */
004558000000     /*-------------------------------------------------------------*/
004559000000
004560000000             RMVMSGD MSGID(TXT0084) MSGF(&LIB/&OBJ)
004561000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004562000000
004563000000             ADDMSGD +
004564000000                MSGID(TXT0084) +
004565000000                MSGF(&LIB/&OBJ) +
004566000000                MSG( +
004567000000'Editcode:'                                                           +
004568000000                ) +
004569000000                SEV(0) +
004570000000     /*   No replacement variables defined!                         */ +
004571000000                ALROPT(*NO) +
004572000000                CCSID(65535) +
004573000000                /*  -EOF-  */
004574000000
004575000000     /*-------------------------------------------------------------*/
004576000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0085                    */
004577000000     /* - Feldauswahl -                                             */
004578000000     /*-------------------------------------------------------------*/
004579000000
004580000000             RMVMSGD MSGID(TXT0085) MSGF(&LIB/&OBJ)
004581000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004582000000
004583000000             ADDMSGD +
004584000000                MSGID(TXT0085) +
004585000000                MSGF(&LIB/&OBJ) +
004586000000                MSG( +
004587000000'- Feldauswahl -'                                                     +
004588000000                ) +
004589000000                SEV(0) +
004590000000     /*   No replacement variables defined!                         */ +
004591000000                ALROPT(*NO) +
004592000000                CCSID(65535) +
004593000000                /*  -EOF-  */
004594000000
004595000000     /*-------------------------------------------------------------*/
004596000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0086                    */
004597000000     /*  A   Feld        Bezeichnung                                */
004598000000     /*-------------------------------------------------------------*/
004599000000
004600000000             RMVMSGD MSGID(TXT0086) MSGF(&LIB/&OBJ)
004601000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004602000000
004603000000             ADDMSGD +
004604000000                MSGID(TXT0086) +
004605000000                MSGF(&LIB/&OBJ) +
004606000000                MSG( +
004607000000' A   Feld        Bezeichnung                    '                    +
004608000000                ) +
004609000000                SEV(0) +
004610000000     /*   No replacement variables defined!                         */ +
004611000000                ALROPT(*NO) +
004612000000                CCSID(65535) +
004613000000                /*  -EOF-  */
004614000000
004615000000     /*-------------------------------------------------------------*/
004616000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0087                    */
004617000000     /*  A  Datei                  Beschreibung                     */
004618000000     /*-------------------------------------------------------------*/
004619000000
004620000000             RMVMSGD MSGID(TXT0087) MSGF(&LIB/&OBJ)
004621000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004622000000
004623000000             ADDMSGD +
004624000000                MSGID(TXT0087) +
004625000000                MSGF(&LIB/&OBJ) +
004626000000                MSG( +
004627000000' A  Datei                  Beschreibung                              -
004628000000   '                                                                  +
004629000000                ) +
004630000000                SEV(0) +
004631000000     /*   No replacement variables defined!                         */ +
004632000000                ALROPT(*NO) +
004633000000                CCSID(65535) +
004634000000                /*  -EOF-  */
004635000000
004636000000     /*-------------------------------------------------------------*/
004637000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0088                    */
004638000000     /* - Anz. Datenbankrelationen   -                              */
004639000000     /*-------------------------------------------------------------*/
004640000000
004641000000             RMVMSGD MSGID(TXT0088) MSGF(&LIB/&OBJ)
004642000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004643000000
004644000000             ADDMSGD +
004645000000                MSGID(TXT0088) +
004646000000                MSGF(&LIB/&OBJ) +
004647000000                MSG( +
004648000000'- Anz. Datenbankrelationen   -'                                      +
004649000000                ) +
004650000000                SEV(0) +
004651000000     /*   No replacement variables defined!                         */ +
004652000000                ALROPT(*NO) +
004653000000                CCSID(65535) +
004654000000                /*  -EOF-  */
004655000000
004656000000     /*-------------------------------------------------------------*/
004657000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0089                    */
004658000000     /* Log. Sichten:                                               */
004659000000     /*-------------------------------------------------------------*/
004660000000
004661000000             RMVMSGD MSGID(TXT0089) MSGF(&LIB/&OBJ)
004662000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004663000000
004664000000             ADDMSGD +
004665000000                MSGID(TXT0089) +
004666000000                MSGF(&LIB/&OBJ) +
004667000000                MSG( +
004668000000'Log. Sichten:'                                                       +
004669000000                ) +
004670000000                SEV(0) +
004671000000     /*   No replacement variables defined!                         */ +
004672000000                ALROPT(*NO) +
004673000000                CCSID(65535) +
004674000000                /*  -EOF-  */
004675000000
004676000000     /*-------------------------------------------------------------*/
004677000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0090                    */
004678000000     /* Hex-Eingabe                                                 */
004679000000     /*-------------------------------------------------------------*/
004680000000
004681000000             RMVMSGD MSGID(TXT0090) MSGF(&LIB/&OBJ)
004682000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004683000000
004684000000             ADDMSGD +
004685000000                MSGID(TXT0090) +
004686000000                MSGF(&LIB/&OBJ) +
004687000000                MSG( +
004688000000'Hex-Eingabe'                                                         +
004689000000                ) +
004690000000                SEV(0) +
004691000000     /*   No replacement variables defined!                         */ +
004692000000                ALROPT(*NO) +
004693000000                CCSID(65535) +
004694000000                /*  -EOF-  */
004695000000
004696000000     /*-------------------------------------------------------------*/
004697000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0091                    */
004698000000     /* Feld ........:                                              */
004699000000     /*-------------------------------------------------------------*/
004700000000
004701000000             RMVMSGD MSGID(TXT0091) MSGF(&LIB/&OBJ)
004702000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004703000000
004704000000             ADDMSGD +
004705000000                MSGID(TXT0091) +
004706000000                MSGF(&LIB/&OBJ) +
004707000000                MSG( +
004708000000'Feld ........:'                                                      +
004709000000                ) +
004710000000                SEV(0) +
004711000000     /*   No replacement variables defined!                         */ +
004712000000                ALROPT(*NO) +
004713000000                CCSID(65535) +
004714000000                /*  -EOF-  */
004715000000
004716000000     /*-------------------------------------------------------------*/
004717000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0092                    */
004718000000     /* Feldlänge ...:                                              */
004719000000     /*-------------------------------------------------------------*/
004720000000
004721000000             RMVMSGD MSGID(TXT0092) MSGF(&LIB/&OBJ)
004722000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004723000000
004724000000             ADDMSGD +
004725000000                MSGID(TXT0092) +
004726000000                MSGF(&LIB/&OBJ) +
004727000000                MSG( +
004728000000'Feldlänge ...:'                                                      +
004729000000                ) +
004730000000                SEV(0) +
004731000000     /*   No replacement variables defined!                         */ +
004732000000                ALROPT(*NO) +
004733000000                CCSID(65535) +
004734000000                /*  -EOF-  */
004735000000
004736000000     /*-------------------------------------------------------------*/
004737000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0093                    */
004738000000     /* Inhalt ....:                                                */
004739000000     /*-------------------------------------------------------------*/
004740000000
004741000000             RMVMSGD MSGID(TXT0093) MSGF(&LIB/&OBJ)
004742000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004743000000
004744000000             ADDMSGD +
004745000000                MSGID(TXT0093) +
004746000000                MSGF(&LIB/&OBJ) +
004747000000                MSG( +
004748000000'Inhalt ....:'                                                        +
004749000000                ) +
004750000000                SEV(0) +
004751000000     /*   No replacement variables defined!                         */ +
004752000000                ALROPT(*NO) +
004753000000                CCSID(65535) +
004754000000                /*  -EOF-  */
004755000000
004756000000     /*-------------------------------------------------------------*/
004757000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0094                    */
004758000000     /* Hex .......:                                                */
004759000000     /*-------------------------------------------------------------*/
004760000000
004761000000             RMVMSGD MSGID(TXT0094) MSGF(&LIB/&OBJ)
004762000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004763000000
004764000000             ADDMSGD +
004765000000                MSGID(TXT0094) +
004766000000                MSGF(&LIB/&OBJ) +
004767000000                MSG( +
004768000000'Hex .......:'                                                        +
004769000000                ) +
004770000000                SEV(0) +
004771000000     /*   No replacement variables defined!                         */ +
004772000000                ALROPT(*NO) +
004773000000                CCSID(65535) +
004774000000                /*  -EOF-  */
004775000000
004776000000     /*-------------------------------------------------------------*/
004777000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0095                    */
004778000000     /* Startposition:                                              */
004779000000     /*-------------------------------------------------------------*/
004780000000
004781000000             RMVMSGD MSGID(TXT0095) MSGF(&LIB/&OBJ)
004782000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004783000000
004784000000             ADDMSGD +
004785000000                MSGID(TXT0095) +
004786000000                MSGF(&LIB/&OBJ) +
004787000000                MSG( +
004788000000'Startposition:'                                                      +
004789000000                ) +
004790000000                SEV(0) +
004791000000     /*   No replacement variables defined!                         */ +
004792000000                ALROPT(*NO) +
004793000000                CCSID(65535) +
004794000000                /*  -EOF-  */
004795000000
004796000000     /*-------------------------------------------------------------*/
004797000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0096                    */
004798000000     /* Pufferlänge:                                                */
004799000000     /*-------------------------------------------------------------*/
004800000000
004801000000             RMVMSGD MSGID(TXT0096) MSGF(&LIB/&OBJ)
004802000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004803000000
004804000000             ADDMSGD +
004805000000                MSGID(TXT0096) +
004806000000                MSGF(&LIB/&OBJ) +
004807000000                MSG( +
004808000000'Pufferlänge:'                                                        +
004809000000                ) +
004810000000                SEV(0) +
004811000000     /*   No replacement variables defined!                         */ +
004812000000                ALROPT(*NO) +
004813000000                CCSID(65535) +
004814000000                /*  -EOF-  */
004815000000
004816000000     /*-------------------------------------------------------------*/
004817000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0097                    */
004818000000     /*  A   Teildatei   Bezeichnung                                */
004819000000     /*-------------------------------------------------------------*/
004820000000
004821000000             RMVMSGD MSGID(TXT0097) MSGF(&LIB/&OBJ)
004822000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004823000000
004824000000             ADDMSGD +
004825000000                MSGID(TXT0097) +
004826000000                MSGF(&LIB/&OBJ) +
004827000000                MSG( +
004828000000' A   Teildatei   Bezeichnung                                        '+
004829000000                ) +
004830000000                SEV(0) +
004831000000     /*   No replacement variables defined!                         */ +
004832000000                ALROPT(*NO) +
004833000000                CCSID(65535) +
004834000000                /*  -EOF-  */
004835000000
004836000000     /*-------------------------------------------------------------*/
004837000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0098                    */
004838000000     /* - Auswahl Teildatei -                                       */
004839000000     /*-------------------------------------------------------------*/
004840000000
004841000000             RMVMSGD MSGID(TXT0098) MSGF(&LIB/&OBJ)
004842000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004843000000
004844000000             ADDMSGD +
004845000000                MSGID(TXT0098) +
004846000000                MSGF(&LIB/&OBJ) +
004847000000                MSG( +
004848000000'- Auswahl Teildatei - '                                              +
004849000000                ) +
004850000000                SEV(0) +
004851000000     /*   No replacement variables defined!                         */ +
004852000000                ALROPT(*NO) +
004853000000                CCSID(65535) +
004854000000                /*  -EOF-  */
004855000000
004856000000     /*-------------------------------------------------------------*/
004857000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0099                    */
004858000000     /* Anz. Teild:                                                 */
004859000000     /*-------------------------------------------------------------*/
004860000000
004861000000             RMVMSGD MSGID(TXT0099) MSGF(&LIB/&OBJ)
004862000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004863000000
004864000000             ADDMSGD +
004865000000                MSGID(TXT0099) +
004866000000                MSGF(&LIB/&OBJ) +
004867000000                MSG( +
004868000000'Anz. Teild:'                                                         +
004869000000                ) +
004870000000                SEV(0) +
004871000000     /*   No replacement variables defined!                         */ +
004872000000                ALROPT(*NO) +
004873000000                CCSID(65535) +
004874000000                /*  -EOF-  */
004875000000
004876000000     /*-------------------------------------------------------------*/
004877000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0100                    */
004878000000     /*  Teild:                                                     */
004879000000     /*-------------------------------------------------------------*/
004880000000
004881000000             RMVMSGD MSGID(TXT0100) MSGF(&LIB/&OBJ)
004882000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004883000000
004884000000             ADDMSGD +
004885000000                MSGID(TXT0100) +
004886000000                MSGF(&LIB/&OBJ) +
004887000000                MSG( +
004888000000' Teild:'                                                             +
004889000000                ) +
004890000000                SEV(0) +
004891000000     /*   No replacement variables defined!                         */ +
004892000000                ALROPT(*NO) +
004893000000                CCSID(65535) +
004894000000                /*  -EOF-  */
004895000000
004896000000     /*-------------------------------------------------------------*/
004897000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0101                    */
004898000000     /* - Über Peek/400 -                                           */
004899000000     /*-------------------------------------------------------------*/
004900000000
004901000000             RMVMSGD MSGID(TXT0101) MSGF(&LIB/&OBJ)
004902000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004903000000
004904000000             ADDMSGD +
004905000000                MSGID(TXT0101) +
004906000000                MSGF(&LIB/&OBJ) +
004907000000                MSG( +
004908000000'- Über Peek/400 - '                                                  +
004909000000                ) +
004910000000                SEV(0) +
004911000000     /*   No replacement variables defined!                         */ +
004912000000                ALROPT(*NO) +
004913000000                CCSID(65535) +
004914000000                /*  -EOF-  */
004915000000
004916000000     /*-------------------------------------------------------------*/
004917000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0102                    */
004918000000     /* Datum . . .                                                 */
004919000000     /*-------------------------------------------------------------*/
004920000000
004921000000             RMVMSGD MSGID(TXT0102) MSGF(&LIB/&OBJ)
004922000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004923000000
004924000000             ADDMSGD +
004925000000                MSGID(TXT0102) +
004926000000                MSGF(&LIB/&OBJ) +
004927000000                MSG( +
004928000000'Datum . . .'                                                         +
004929000000                ) +
004930000000                SEV(0) +
004931000000     /*   No replacement variables defined!                         */ +
004932000000                ALROPT(*NO) +
004933000000                CCSID(65535) +
004934000000                /*  -EOF-  */
004935000000
004936000000     /*-------------------------------------------------------------*/
004937000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0103                    */
004938000000     /* Version . .                                                 */
004939000000     /*-------------------------------------------------------------*/
004940000000
004941000000             RMVMSGD MSGID(TXT0103) MSGF(&LIB/&OBJ)
004942000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004943000000
004944000000             ADDMSGD +
004945000000                MSGID(TXT0103) +
004946000000                MSGF(&LIB/&OBJ) +
004947000000                MSG( +
004948000000'Version . .'                                                         +
004949000000                ) +
004950000000                SEV(0) +
004951000000     /*   No replacement variables defined!                         */ +
004952000000                ALROPT(*NO) +
004953000000                CCSID(65535) +
004954000000                /*  -EOF-  */
004955000000
004956000000     /*-------------------------------------------------------------*/
004957000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0104                    */
004958000000     /* E-mail  . .                                                 */
004959000000     /*-------------------------------------------------------------*/
004960000000
004961000000             RMVMSGD MSGID(TXT0104) MSGF(&LIB/&OBJ)
004962000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004963000000
004964000000             ADDMSGD +
004965000000                MSGID(TXT0104) +
004966000000                MSGF(&LIB/&OBJ) +
004967000000                MSG( +
004968000000'E-mail  . .'                                                         +
004969000000                ) +
004970000000                SEV(0) +
004971000000     /*   No replacement variables defined!                         */ +
004972000000                ALROPT(*NO) +
004973000000                CCSID(65535) +
004974000000                /*  -EOF-  */
004975000000
004976000000     /*-------------------------------------------------------------*/
004977000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0105                    */
004978000000     /* Homepage  .                                                 */
004979000000     /*-------------------------------------------------------------*/
004980000000
004981000000             RMVMSGD MSGID(TXT0105) MSGF(&LIB/&OBJ)
004982000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004983000000
004984000000             ADDMSGD +
004985000000                MSGID(TXT0105) +
004986000000                MSGF(&LIB/&OBJ) +
004987000000                MSG( +
004988000000'Homepage  .'                                                         +
004989000000                ) +
004990000000                SEV(0) +
004991000000     /*   No replacement variables defined!                         */ +
004992000000                ALROPT(*NO) +
004993000000                CCSID(65535) +
004994000000                /*  -EOF-  */
004995000000
004996000000     /*-------------------------------------------------------------*/
004997000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0106                    */
004998000000     /* Spalten Pinnen                                              */
004999000000     /*-------------------------------------------------------------*/
005000000000
005001000000             RMVMSGD MSGID(TXT0106) MSGF(&LIB/&OBJ)
005002000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005003000000
005004000000             ADDMSGD +
005005000000                MSGID(TXT0106) +
005006000000                MSGF(&LIB/&OBJ) +
005007000000                MSG( +
005008000000'Spalten Pinnen'                                                      +
005009000000                ) +
005010000000                SEV(0) +
005011000000     /*   No replacement variables defined!                         */ +
005012000000                ALROPT(*NO) +
005013000000                CCSID(65535) +
005014000000                /*  -EOF-  */
005015000000
005016000000     /*-------------------------------------------------------------*/
005017000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0107                    */
005018000000     /*  Folge  Feld        Bezeichnung                      Schl.F */
005019000000     /*-------------------------------------------------------------*/
005020000000
005021000000             RMVMSGD MSGID(TXT0107) MSGF(&LIB/&OBJ)
005022000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005023000000
005024000000             ADDMSGD +
005025000000                MSGID(TXT0107) +
005026000000                MSGF(&LIB/&OBJ) +
005027000000                MSG( +
005028000000' Folge  Feld        Bezeichnung                      Schl.Feld'      +
005029000000                ) +
005030000000                SEV(0) +
005031000000     /*   No replacement variables defined!                         */ +
005032000000                ALROPT(*NO) +
005033000000                CCSID(65535) +
005034000000                /*  -EOF-  */
005035000000
005036000000     /*-------------------------------------------------------------*/
005037000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0108                    */
005038000000     /*  - SQL  Auswahl -                                           */
005039000000     /*-------------------------------------------------------------*/
005040000000
005041000000             RMVMSGD MSGID(TXT0108) MSGF(&LIB/&OBJ)
005042000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005043000000
005044000000             ADDMSGD +
005045000000                MSGID(TXT0108) +
005046000000                MSGF(&LIB/&OBJ) +
005047000000                MSG( +
005048000000' - SQL  Auswahl - '                                                  +
005049000000                ) +
005050000000                SEV(0) +
005051000000     /*   No replacement variables defined!                         */ +
005052000000                ALROPT(*NO) +
005053000000                CCSID(65535) +
005054000000                /*  -EOF-  */
005055000000
005056000000     /*-------------------------------------------------------------*/
005057000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0109                    */
005058000000     /* WHERE  ....:                                                */
005059000000     /*-------------------------------------------------------------*/
005060000000
005061000000             RMVMSGD MSGID(TXT0109) MSGF(&LIB/&OBJ)
005062000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005063000000
005064000000             ADDMSGD +
005065000000                MSGID(TXT0109) +
005066000000                MSGF(&LIB/&OBJ) +
005067000000                MSG( +
005068000000'WHERE  ....:'                                                        +
005069000000                ) +
005070000000                SEV(0) +
005071000000     /*   No replacement variables defined!                         */ +
005072000000                ALROPT(*NO) +
005073000000                CCSID(65535) +
005074000000                /*  -EOF-  */
005075000000
005076000000     /*-------------------------------------------------------------*/
005077000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0110                    */
005078000000     /* ORDER BY  .:                                                */
005079000000     /*-------------------------------------------------------------*/
005080000000
005081000000             RMVMSGD MSGID(TXT0110) MSGF(&LIB/&OBJ)
005082000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005083000000
005084000000             ADDMSGD +
005085000000                MSGID(TXT0110) +
005086000000                MSGF(&LIB/&OBJ) +
005087000000                MSG( +
005088000000'ORDER BY  .:'                                                        +
005089000000                ) +
005090000000                SEV(0) +
005091000000     /*   No replacement variables defined!                         */ +
005092000000                ALROPT(*NO) +
005093000000                CCSID(65535) +
005094000000                /*  -EOF-  */
005095000000
005096000000     /*-------------------------------------------------------------*/
005097000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0111                    */
005098000000     /* - Programm erstellen -                                      */
005099000000     /*-------------------------------------------------------------*/
005100000000
005101000000             RMVMSGD MSGID(TXT0111) MSGF(&LIB/&OBJ)
005102000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005103000000
005104000000             ADDMSGD +
005105000000                MSGID(TXT0111) +
005106000000                MSGF(&LIB/&OBJ) +
005107000000                MSG( +
005108000000'- Programm erstellen -'                                              +
005109000000                ) +
005110000000                SEV(0) +
005111000000     /*   No replacement variables defined!                         */ +
005112000000                ALROPT(*NO) +
005113000000                CCSID(65535) +
005114000000                /*  -EOF-  */
005115000000
005116000000     /*-------------------------------------------------------------*/
005117000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0112                    */
005118000000     /* Kleinbuchst. erlaubt?                                       */
005119000000     /*-------------------------------------------------------------*/
005120000000
005121000000             RMVMSGD MSGID(TXT0112) MSGF(&LIB/&OBJ)
005122000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005123000000
005124000000             ADDMSGD +
005125000000                MSGID(TXT0112) +
005126000000                MSGF(&LIB/&OBJ) +
005127000000                MSG( +
005128000000'Kleinbuchst. erlaubt? '                                              +
005129000000                ) +
005130000000                SEV(0) +
005131000000     /*   No replacement variables defined!                         */ +
005132000000                ALROPT(*NO) +
005133000000                CCSID(65535) +
005134000000                /*  -EOF-  */
005135000000
005136000000     /*-------------------------------------------------------------*/
005137000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0113                    */
005138000000     /* Default Groß-/Kleinb.?                                      */
005139000000     /*-------------------------------------------------------------*/
005140000000
005141000000             RMVMSGD MSGID(TXT0113) MSGF(&LIB/&OBJ)
005142000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005143000000
005144000000             ADDMSGD +
005145000000                MSGID(TXT0113) +
005146000000                MSGF(&LIB/&OBJ) +
005147000000                MSG( +
005148000000'Default Groß-/Kleinb.?'                                              +
005149000000                ) +
005150000000                SEV(0) +
005151000000     /*   No replacement variables defined!                         */ +
005152000000                ALROPT(*NO) +
005153000000                CCSID(65535) +
005154000000                /*  -EOF-  */
005155000000
005156000000     /*-------------------------------------------------------------*/
005157000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0114                    */
005158000000     /* Als Default speichern?                                      */
005159000000     /*-------------------------------------------------------------*/
005160000000
005161000000             RMVMSGD MSGID(TXT0114) MSGF(&LIB/&OBJ)
005162000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005163000000
005164000000             ADDMSGD +
005165000000                MSGID(TXT0114) +
005166000000                MSGF(&LIB/&OBJ) +
005167000000                MSG( +
005168000000'Als Default speichern?'                                              +
005169000000                ) +
005170000000                SEV(0) +
005171000000     /*   No replacement variables defined!                         */ +
005172000000                ALROPT(*NO) +
005173000000                CCSID(65535) +
005174000000                /*  -EOF-  */
005175000000
005176000000     /*-------------------------------------------------------------*/
005177000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0115                    */
005178000000     /* SQL-Auswahl                                                 */
005179000000     /*-------------------------------------------------------------*/
005180000000
005181000000             RMVMSGD MSGID(TXT0115) MSGF(&LIB/&OBJ)
005182000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005183000000
005184000000             ADDMSGD +
005185000000                MSGID(TXT0115) +
005186000000                MSGF(&LIB/&OBJ) +
005187000000                MSG( +
005188000000'SQL-Auswahl  '                                                       +
005189000000                ) +
005190000000                SEV(0) +
005191000000     /*   No replacement variables defined!                         */ +
005192000000                ALROPT(*NO) +
005193000000                CCSID(65535) +
005194000000                /*  -EOF-  */
005195000000
005196000000     /*-------------------------------------------------------------*/
005197000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0116                    */
005198000000     /* Auswählen Arbeitsumgebung                                   */
005199000000     /*-------------------------------------------------------------*/
005200000000
005201000000             RMVMSGD MSGID(TXT0116) MSGF(&LIB/&OBJ)
005202000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005203000000
005204000000             ADDMSGD +
005205000000                MSGID(TXT0116) +
005206000000                MSGF(&LIB/&OBJ) +
005207000000                MSG( +
005208000000'Auswählen Arbeitsumgebung'                                           +
005209000000                ) +
005210000000                SEV(0) +
005211000000     /*   No replacement variables defined!                         */ +
005212000000                ALROPT(*NO) +
005213000000                CCSID(65535) +
005214000000                /*  -EOF-  */
005215000000
005216000000     /*-------------------------------------------------------------*/
005217000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0117                    */
005218000000     /* Datei:                                                      */
005219000000     /*-------------------------------------------------------------*/
005220000000
005221000000             RMVMSGD MSGID(TXT0117) MSGF(&LIB/&OBJ)
005222000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005223000000
005224000000             ADDMSGD +
005225000000                MSGID(TXT0117) +
005226000000                MSGF(&LIB/&OBJ) +
005227000000                MSG( +
005228000000'Datei:'                                                              +
005229000000                ) +
005230000000                SEV(0) +
005231000000     /*   No replacement variables defined!                         */ +
005232000000                ALROPT(*NO) +
005233000000                CCSID(65535) +
005234000000                /*  -EOF-  */
005235000000
005236000000     /*-------------------------------------------------------------*/
005237000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0118                    */
005238000000     /* Bibliothek:                                                 */
005239000000     /*-------------------------------------------------------------*/
005240000000
005241000000             RMVMSGD MSGID(TXT0118) MSGF(&LIB/&OBJ)
005242000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005243000000
005244000000             ADDMSGD +
005245000000                MSGID(TXT0118) +
005246000000                MSGF(&LIB/&OBJ) +
005247000000                MSG( +
005248000000'Bibliothek:'                                                         +
005249000000                ) +
005250000000                SEV(0) +
005251000000     /*   No replacement variables defined!                         */ +
005252000000                ALROPT(*NO) +
005253000000                CCSID(65535) +
005254000000                /*  -EOF-  */
005255000000
005256000000     /*-------------------------------------------------------------*/
005257000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0119                    */
005258000000     /*  A   Umgebung    Bezeichnung                                */
005259000000     /*-------------------------------------------------------------*/
005260000000
005261000000             RMVMSGD MSGID(TXT0119) MSGF(&LIB/&OBJ)
005262000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005263000000
005264000000             ADDMSGD +
005265000000                MSGID(TXT0119) +
005266000000                MSGF(&LIB/&OBJ) +
005267000000                MSG( +
005268000000' A   Umgebung    Bezeichnung'                                        +
005269000000                ) +
005270000000                SEV(0) +
005271000000     /*   No replacement variables defined!                         */ +
005272000000                ALROPT(*NO) +
005273000000                CCSID(65535) +
005274000000                /*  -EOF-  */
005275000000
005276000000     /*-------------------------------------------------------------*/
005277000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0120                    */
005278000000     /* Löschen Arbeitsumgebung                                     */
005279000000     /*-------------------------------------------------------------*/
005280000000
005281000000             RMVMSGD MSGID(TXT0120) MSGF(&LIB/&OBJ)
005282000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005283000000
005284000000             ADDMSGD +
005285000000                MSGID(TXT0120) +
005286000000                MSGF(&LIB/&OBJ) +
005287000000                MSG( +
005288000000'Löschen Arbeitsumgebung'                                             +
005289000000                ) +
005290000000                SEV(0) +
005291000000     /*   No replacement variables defined!                         */ +
005292000000                ALROPT(*NO) +
005293000000                CCSID(65535) +
005294000000                /*  -EOF-  */
005295000000
005296000000     /*-------------------------------------------------------------*/
005297000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0121                    */
005298000000     /* Datei . . . :                                               */
005299000000     /*-------------------------------------------------------------*/
005300000000
005301000000             RMVMSGD MSGID(TXT0121) MSGF(&LIB/&OBJ)
005302000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005303000000
005304000000             ADDMSGD +
005305000000                MSGID(TXT0121) +
005306000000                MSGF(&LIB/&OBJ) +
005307000000                MSG( +
005308000000'Datei . . . :'                                                       +
005309000000                ) +
005310000000                SEV(0) +
005311000000     /*   No replacement variables defined!                         */ +
005312000000                ALROPT(*NO) +
005313000000                CCSID(65535) +
005314000000                /*  -EOF-  */
005315000000
005316000000     /*-------------------------------------------------------------*/
005317000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0122                    */
005318000000     /* Bibliothek:                                                 */
005319000000     /*-------------------------------------------------------------*/
005320000000
005321000000             RMVMSGD MSGID(TXT0122) MSGF(&LIB/&OBJ)
005322000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005323000000
005324000000             ADDMSGD +
005325000000                MSGID(TXT0122) +
005326000000                MSGF(&LIB/&OBJ) +
005327000000                MSG( +
005328000000'Bibliothek:'                                                         +
005329000000                ) +
005330000000                SEV(0) +
005331000000     /*   No replacement variables defined!                         */ +
005332000000                ALROPT(*NO) +
005333000000                CCSID(65535) +
005334000000                /*  -EOF-  */
005335000000
005336000000     /*-------------------------------------------------------------*/
005337000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0123                    */
005338000000     /* Teildatei . :                                               */
005339000000     /*-------------------------------------------------------------*/
005340000000
005341000000             RMVMSGD MSGID(TXT0123) MSGF(&LIB/&OBJ)
005342000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005343000000
005344000000             ADDMSGD +
005345000000                MSGID(TXT0123) +
005346000000                MSGF(&LIB/&OBJ) +
005347000000                MSG( +
005348000000'Teildatei . :'                                                       +
005349000000                ) +
005350000000                SEV(0) +
005351000000     /*   No replacement variables defined!                         */ +
005352000000                ALROPT(*NO) +
005353000000                CCSID(65535) +
005354000000                /*  -EOF-  */
005355000000
005356000000     /*-------------------------------------------------------------*/
005357000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0124                    */
005358000000     /* Beschreibung:                                               */
005359000000     /*-------------------------------------------------------------*/
005360000000
005361000000             RMVMSGD MSGID(TXT0124) MSGF(&LIB/&OBJ)
005362000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005363000000
005364000000             ADDMSGD +
005365000000                MSGID(TXT0124) +
005366000000                MSGF(&LIB/&OBJ) +
005367000000                MSG( +
005368000000'Beschreibung:'                                                       +
005369000000                ) +
005370000000                SEV(0) +
005371000000     /*   No replacement variables defined!                         */ +
005372000000                ALROPT(*NO) +
005373000000                CCSID(65535) +
005374000000                /*  -EOF-  */
005375000000
005376000000     /*-------------------------------------------------------------*/
005377000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0125                    */
005378000000     /* Akt.Länge .:                                                */
005379000000     /*-------------------------------------------------------------*/
005380000000
005381000000             RMVMSGD MSGID(TXT0125) MSGF(&LIB/&OBJ)
005382000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005383000000
005384000000             ADDMSGD +
005385000000                MSGID(TXT0125) +
005386000000                MSGF(&LIB/&OBJ) +
005387000000                MSG( +
005388000000'Akt.Länge .:'                                                        +
005389000000                ) +
005390000000                SEV(0) +
005391000000     /*   No replacement variables defined!                         */ +
005392000000                ALROPT(*NO) +
005393000000                CCSID(65535) +
005394000000                /*  -EOF-  */
005395000000
005396000000     /*-------------------------------------------------------------*/
005397000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0126                    */
005398000000     /*  - Auswahl Satzformat -                                     */
005399000000     /*-------------------------------------------------------------*/
005400000000
005401000000             RMVMSGD MSGID(TXT0126) MSGF(&LIB/&OBJ)
005402000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005403000000
005404000000             ADDMSGD +
005405000000                MSGID(TXT0126) +
005406000000                MSGF(&LIB/&OBJ) +
005407000000                MSG( +
005408000000' - Auswahl Satzformat - '                                            +
005409000000                ) +
005410000000                SEV(0) +
005411000000     /*   No replacement variables defined!                         */ +
005412000000                ALROPT(*NO) +
005413000000                CCSID(65535) +
005414000000                /*  -EOF-  */
005415000000
005416000000     /*-------------------------------------------------------------*/
005417000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0127                    */
005418000000     /* NULL Wert                                                   */
005419000000     /*-------------------------------------------------------------*/
005420000000
005421000000             RMVMSGD MSGID(TXT0127) MSGF(&LIB/&OBJ)
005422000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005423000000
005424000000             ADDMSGD +
005425000000                MSGID(TXT0127) +
005426000000                MSGF(&LIB/&OBJ) +
005427000000                MSG( +
005428000000'NULL Wert'                                                           +
005429000000                ) +
005430000000                SEV(0) +
005431000000     /*   No replacement variables defined!                         */ +
005432000000                ALROPT(*NO) +
005433000000                CCSID(65535) +
005434000000                /*  -EOF-  */
005435000000
005436000000     /*-------------------------------------------------------------*/
005437000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0128                    */
005438000000     /* Text-Editor                                                 */
005439000000     /*-------------------------------------------------------------*/
005440000000
005441000000             RMVMSGD MSGID(TXT0128) MSGF(&LIB/&OBJ)
005442000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005443000000
005444000000             ADDMSGD +
005445000000                MSGID(TXT0128) +
005446000000                MSGF(&LIB/&OBJ) +
005447000000                MSG( +
005448000000'Text-Editor'                                                         +
005449000000                ) +
005450000000                SEV(0) +
005451000000     /*   No replacement variables defined!                         */ +
005452000000                ALROPT(*NO) +
005453000000                CCSID(65535) +
005454000000                /*  -EOF-  */
005455000000
005456000000     /*-------------------------------------------------------------*/
005457000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0129                    */
005458000000     /* *** Datensatz gesperrt ***                                  */
005459000000     /*-------------------------------------------------------------*/
005460000000
005461000000             RMVMSGD MSGID(TXT0129) MSGF(&LIB/&OBJ)
005462000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005463000000
005464000000             ADDMSGD +
005465000000                MSGID(TXT0129) +
005466000000                MSGF(&LIB/&OBJ) +
005467000000                MSG( +
005468000000'*** Datensatz gesperrt ***'                                          +
005469000000                ) +
005470000000                SEV(0) +
005471000000     /*   No replacement variables defined!                         */ +
005472000000                ALROPT(*NO) +
005473000000                CCSID(65535) +
005474000000                /*  -EOF-  */
005475000000
005476000000     /*-------------------------------------------------------------*/
005477000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0130                    */
005478000000     /* Datensatz nicht gesperrt                                    */
005479000000     /*-------------------------------------------------------------*/
005480000000
005481000000             RMVMSGD MSGID(TXT0130) MSGF(&LIB/&OBJ)
005482000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005483000000
005484000000             ADDMSGD +
005485000000                MSGID(TXT0130) +
005486000000                MSGF(&LIB/&OBJ) +
005487000000                MSG( +
005488000000'Datensatz nicht gesperrt'                                            +
005489000000                ) +
005490000000                SEV(0) +
005491000000     /*   No replacement variables defined!                         */ +
005492000000                ALROPT(*NO) +
005493000000                CCSID(65535) +
005494000000                /*  -EOF-  */
005495000000
005496000000     /*-------------------------------------------------------------*/
005497000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0131                    */
005498000000     /* Satz gesperrt lesen?                                        */
005499000000     /*-------------------------------------------------------------*/
005500000000
005501000000             RMVMSGD MSGID(TXT0131) MSGF(&LIB/&OBJ)
005502000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005503000000
005504000000             ADDMSGD +
005505000000                MSGID(TXT0131) +
005506000000                MSGF(&LIB/&OBJ) +
005507000000                MSG( +
005508000000'Satz gesperrt lesen?'                                                +
005509000000                ) +
005510000000                SEV(0) +
005511000000     /*   No replacement variables defined!                         */ +
005512000000                ALROPT(*NO) +
005513000000                CCSID(65535) +
005514000000                /*  -EOF-  */
005515000000
005516000000     /*-------------------------------------------------------------*/
005517000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0132                    */
005518000000     /* Datei:                                                      */
005519000000     /*-------------------------------------------------------------*/
005520000000
005521000000             RMVMSGD MSGID(TXT0132) MSGF(&LIB/&OBJ)
005522000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005523000000
005524000000             ADDMSGD +
005525000000                MSGID(TXT0132) +
005526000000                MSGF(&LIB/&OBJ) +
005527000000                MSG( +
005528000000'Datei:'                                                              +
005529000000                ) +
005530000000                SEV(0) +
005531000000     /*   No replacement variables defined!                         */ +
005532000000                ALROPT(*NO) +
005533000000                CCSID(65535) +
005534000000                /*  -EOF-  */
005535000000
005536000000     /*-------------------------------------------------------------*/
005537000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0133                    */
005538000000     /* Bibliothek:                                                 */
005539000000     /*-------------------------------------------------------------*/
005540000000
005541000000             RMVMSGD MSGID(TXT0133) MSGF(&LIB/&OBJ)
005542000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005543000000
005544000000             ADDMSGD +
005545000000                MSGID(TXT0133) +
005546000000                MSGF(&LIB/&OBJ) +
005547000000                MSG( +
005548000000'Bibliothek:'                                                         +
005549000000                ) +
005550000000                SEV(0) +
005551000000     /*   No replacement variables defined!                         */ +
005552000000                ALROPT(*NO) +
005553000000                CCSID(65535) +
005554000000                /*  -EOF-  */
005555000000
005556000000     /*-------------------------------------------------------------*/
005557000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0134                    */
005558000000     /* RRN:                                                        */
005559000000     /*-------------------------------------------------------------*/
005560000000
005561000000             RMVMSGD MSGID(TXT0134) MSGF(&LIB/&OBJ)
005562000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005563000000
005564000000             ADDMSGD +
005565000000                MSGID(TXT0134) +
005566000000                MSGF(&LIB/&OBJ) +
005567000000                MSG( +
005568000000'RRN:'                                                                +
005569000000                ) +
005570000000                SEV(0) +
005571000000     /*   No replacement variables defined!                         */ +
005572000000                ALROPT(*NO) +
005573000000                CCSID(65535) +
005574000000                /*  -EOF-  */
005575000000
005576000000     /*-------------------------------------------------------------*/
005577000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0135                    */
005578000000     /* Seite:                                                      */
005579000000     /*-------------------------------------------------------------*/
005580000000
005581000000             RMVMSGD MSGID(TXT0135) MSGF(&LIB/&OBJ)
005582000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005583000000
005584000000             ADDMSGD +
005585000000                MSGID(TXT0135) +
005586000000                MSGF(&LIB/&OBJ) +
005587000000                MSG( +
005588000000'Seite:'                                                              +
005589000000                ) +
005590000000                SEV(0) +
005591000000     /*   No replacement variables defined!                         */ +
005592000000                ALROPT(*NO) +
005593000000                CCSID(65535) +
005594000000                /*  -EOF-  */
005595000000
005596000000     /*-------------------------------------------------------------*/
005597000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0136                    */
005598000000     /* Feldname                                                    */
005599000000     /*-------------------------------------------------------------*/
005600000000
005601000000             RMVMSGD MSGID(TXT0136) MSGF(&LIB/&OBJ)
005602000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005603000000
005604000000             ADDMSGD +
005605000000                MSGID(TXT0136) +
005606000000                MSGF(&LIB/&OBJ) +
005607000000                MSG( +
005608000000'Feldname'                                                            +
005609000000                ) +
005610000000                SEV(0) +
005611000000     /*   No replacement variables defined!                         */ +
005612000000                ALROPT(*NO) +
005613000000                CCSID(65535) +
005614000000                /*  -EOF-  */
005615000000
005616000000     /*-------------------------------------------------------------*/
005617000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0137                    */
005618000000     /* Feldbeschreibung                                            */
005619000000     /*-------------------------------------------------------------*/
005620000000
005621000000             RMVMSGD MSGID(TXT0137) MSGF(&LIB/&OBJ)
005622000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005623000000
005624000000             ADDMSGD +
005625000000                MSGID(TXT0137) +
005626000000                MSGF(&LIB/&OBJ) +
005627000000                MSG( +
005628000000'Feldbeschreibung'                                                    +
005629000000                ) +
005630000000                SEV(0) +
005631000000     /*   No replacement variables defined!                         */ +
005632000000                ALROPT(*NO) +
005633000000                CCSID(65535) +
005634000000                /*  -EOF-  */
005635000000
005636000000     /*-------------------------------------------------------------*/
005637000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0138                    */
005638000000     /* Feldinhalt                                                  */
005639000000     /*-------------------------------------------------------------*/
005640000000
005641000000             RMVMSGD MSGID(TXT0138) MSGF(&LIB/&OBJ)
005642000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005643000000
005644000000             ADDMSGD +
005645000000                MSGID(TXT0138) +
005646000000                MSGF(&LIB/&OBJ) +
005647000000                MSG( +
005648000000'Feldinhalt'                                                          +
005649000000                ) +
005650000000                SEV(0) +
005651000000     /*   No replacement variables defined!                         */ +
005652000000                ALROPT(*NO) +
005653000000                CCSID(65535) +
005654000000                /*  -EOF-  */
005655000000
005656000000     /*-------------------------------------------------------------*/
005657000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0139                    */
005658000000     /* Text:                                                       */
005659000000     /*-------------------------------------------------------------*/
005660000000
005661000000             RMVMSGD MSGID(TXT0139) MSGF(&LIB/&OBJ)
005662000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005663000000
005664000000             ADDMSGD +
005665000000                MSGID(TXT0139) +
005666000000                MSGF(&LIB/&OBJ) +
005667000000                MSG( +
005668000000'Text:'                                                               +
005669000000                ) +
005670000000                SEV(0) +
005671000000     /*   No replacement variables defined!                         */ +
005672000000                ALROPT(*NO) +
005673000000                CCSID(65535) +
005674000000                /*  -EOF-  */
005675000000
005676000000     /*-------------------------------------------------------------*/
005677000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0140                    */
005678000000     /*  A   Opt  Bezeichnung                                       */
005679000000     /*-------------------------------------------------------------*/
005680000000
005681000000             RMVMSGD MSGID(TXT0140) MSGF(&LIB/&OBJ)
005682000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005683000000
005684000000             ADDMSGD +
005685000000                MSGID(TXT0140) +
005686000000                MSGF(&LIB/&OBJ) +
005687000000                MSG( +
005688000000' A   Opt  Bezeichnung                 '                              +
005689000000                ) +
005690000000                SEV(0) +
005691000000     /*   No replacement variables defined!                         */ +
005692000000                ALROPT(*NO) +
005693000000                CCSID(65535) +
005694000000                /*  -EOF-  */
005695000000
005696000000     /*-------------------------------------------------------------*/
005697000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0141                    */
005698000000     /* --------- Kurzbefehle ---------                             */
005699000000     /*-------------------------------------------------------------*/
005700000000
005701000000             RMVMSGD MSGID(TXT0141) MSGF(&LIB/&OBJ)
005702000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005703000000
005704000000             ADDMSGD +
005705000000                MSGID(TXT0141) +
005706000000                MSGF(&LIB/&OBJ) +
005707000000                MSG( +
005708000000'--------- Kurzbefehle ---------'                                     +
005709000000                ) +
005710000000                SEV(0) +
005711000000     /*   No replacement variables defined!                         */ +
005712000000                ALROPT(*NO) +
005713000000                CCSID(65535) +
005714000000                /*  -EOF-  */
005715000000
005716000000     /*-------------------------------------------------------------*/
005717000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0142                    */
005718000000     /*  A   Datei       Bibliothek   Bezeichnung                   */
005719000000     /*-------------------------------------------------------------*/
005720000000
005721000000             RMVMSGD MSGID(TXT0142) MSGF(&LIB/&OBJ)
005722000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005723000000
005724000000             ADDMSGD +
005725000000                MSGID(TXT0142) +
005726000000                MSGF(&LIB/&OBJ) +
005727000000                MSG( +
005728000000' A   Datei       Bibliothek   Bezeichnung'                           +
005729000000                ) +
005730000000                SEV(0) +
005731000000     /*   No replacement variables defined!                         */ +
005732000000                ALROPT(*NO) +
005733000000                CCSID(65535) +
005734000000                /*  -EOF-  */
005735000000
005736000000     /*-------------------------------------------------------------*/
005737000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0143                    */
005738000000     /* - Auswahl Datei -                                           */
005739000000     /*-------------------------------------------------------------*/
005740000000
005741000000             RMVMSGD MSGID(TXT0143) MSGF(&LIB/&OBJ)
005742000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005743000000
005744000000             ADDMSGD +
005745000000                MSGID(TXT0143) +
005746000000                MSGF(&LIB/&OBJ) +
005747000000                MSG( +
005748000000'- Auswahl Datei -'                                                   +
005749000000                ) +
005750000000                SEV(0) +
005751000000     /*   No replacement variables defined!                         */ +
005752000000                ALROPT(*NO) +
005753000000                CCSID(65535) +
005754000000                /*  -EOF-  */
005755000000
005756000000     /*-------------------------------------------------------------*/
005757000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0144                    */
005758000000     /* Init. NULL-Felder?                                          */
005759000000     /*-------------------------------------------------------------*/
005760000000
005761000000             RMVMSGD MSGID(TXT0144) MSGF(&LIB/&OBJ)
005762000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005763000000
005764000000             ADDMSGD +
005765000000                MSGID(TXT0144) +
005766000000                MSGF(&LIB/&OBJ) +
005767000000                MSG( +
005768000000'Init. NULL-Felder?'                                                  +
005769000000                ) +
005770000000                SEV(0) +
005771000000     /*   No replacement variables defined!                         */ +
005772000000                ALROPT(*NO) +
005773000000                CCSID(65535) +
005774000000                /*  -EOF-  */
005775000000
005776000000     /*-------------------------------------------------------------*/
005777000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0145                    */
005778000000     /* Cursorposition merken?                                      */
005779000000     /*-------------------------------------------------------------*/
005780000000
005781000000             RMVMSGD MSGID(TXT0145) MSGF(&LIB/&OBJ)
005782000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005783000000
005784000000             ADDMSGD +
005785000000                MSGID(TXT0145) +
005786000000                MSGF(&LIB/&OBJ) +
005787000000                MSG( +
005788000000'Cursorposition merken?'                                              +
005789000000                ) +
005790000000                SEV(0) +
005791000000     /*   No replacement variables defined!                         */ +
005792000000                ALROPT(*NO) +
005793000000                CCSID(65535) +
005794000000                /*  -EOF-  */
005795000000
005796000000     /*-------------------------------------------------------------*/
005797000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0146                    */
005798000000     /* Einfügen                                                    */
005799000000     /*-------------------------------------------------------------*/
005800000000
005801000000             RMVMSGD MSGID(TXT0146) MSGF(&LIB/&OBJ)
005802000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005803000000
005804000000             ADDMSGD +
005805000000                MSGID(TXT0146) +
005806000000                MSGF(&LIB/&OBJ) +
005807000000                MSG( +
005808000000'Einfügen'                                                            +
005809000000                ) +
005810000000                SEV(0) +
005811000000     /*   No replacement variables defined!                         */ +
005812000000                ALROPT(*NO) +
005813000000                CCSID(65535) +
005814000000                /*  -EOF-  */
005815000000
005816000000     /*-------------------------------------------------------------*/
005817000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0147                    */
005818000000     /* Löschen                                                     */
005819000000     /*-------------------------------------------------------------*/
005820000000
005821000000             RMVMSGD MSGID(TXT0147) MSGF(&LIB/&OBJ)
005822000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005823000000
005824000000             ADDMSGD +
005825000000                MSGID(TXT0147) +
005826000000                MSGF(&LIB/&OBJ) +
005827000000                MSG( +
005828000000'Löschen'                                                             +
005829000000                ) +
005830000000                SEV(0) +
005831000000     /*   No replacement variables defined!                         */ +
005832000000                ALROPT(*NO) +
005833000000                CCSID(65535) +
005834000000                /*  -EOF-  */
005835000000
005836000000     /*-------------------------------------------------------------*/
005837000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0148                    */
005838000000     /* von:                                                        */
005839000000     /*-------------------------------------------------------------*/
005840000000
005841000000             RMVMSGD MSGID(TXT0148) MSGF(&LIB/&OBJ)
005842000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005843000000
005844000000             ADDMSGD +
005845000000                MSGID(TXT0148) +
005846000000                MSGF(&LIB/&OBJ) +
005847000000                MSG( +
005848000000'von:   '                                                             +
005849000000                ) +
005850000000                SEV(0) +
005851000000     /*   No replacement variables defined!                         */ +
005852000000                ALROPT(*NO) +
005853000000                CCSID(65535) +
005854000000                /*  -EOF-  */
005855000000
005856000000     /*-------------------------------------------------------------*/
005857000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0149                    */
005858000000     /* Länge:                                                      */
005859000000     /*-------------------------------------------------------------*/
005860000000
005861000000             RMVMSGD MSGID(TXT0149) MSGF(&LIB/&OBJ)
005862000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005863000000
005864000000             ADDMSGD +
005865000000                MSGID(TXT0149) +
005866000000                MSGF(&LIB/&OBJ) +
005867000000                MSG( +
005868000000'Länge: '                                                             +
005869000000                ) +
005870000000                SEV(0) +
005871000000     /*   No replacement variables defined!                         */ +
005872000000                ALROPT(*NO) +
005873000000                CCSID(65535) +
005874000000                /*  -EOF-  */
005875000000
005876000000     /*-------------------------------------------------------------*/
005877000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0150                    */
005878000000     /* bis:                                                        */
005879000000     /*-------------------------------------------------------------*/
005880000000
005881000000             RMVMSGD MSGID(TXT0150) MSGF(&LIB/&OBJ)
005882000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005883000000
005884000000             ADDMSGD +
005885000000                MSGID(TXT0150) +
005886000000                MSGF(&LIB/&OBJ) +
005887000000                MSG( +
005888000000'bis:   '                                                             +
005889000000                ) +
005890000000                SEV(0) +
005891000000     /*   No replacement variables defined!                         */ +
005892000000                ALROPT(*NO) +
005893000000                CCSID(65535) +
005894000000                /*  -EOF-  */
005895000000
005896000000     /*-------------------------------------------------------------*/
005897000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0151                    */
005898000000     /* Cursor Pos. .:                                              */
005899000000     /*-------------------------------------------------------------*/
005900000000
005901000000             RMVMSGD MSGID(TXT0151) MSGF(&LIB/&OBJ)
005902000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005903000000
005904000000             ADDMSGD +
005905000000                MSGID(TXT0151) +
005906000000                MSGF(&LIB/&OBJ) +
005907000000                MSG( +
005908000000'Cursor Pos. .:'                                                      +
005909000000                ) +
005910000000                SEV(0) +
005911000000     /*   No replacement variables defined!                         */ +
005912000000                ALROPT(*NO) +
005913000000                CCSID(65535) +
005914000000                /*  -EOF-  */
005915000000
005916000000     /*-------------------------------------------------------------*/
005917000000     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
005918000000     /* Satzformat &3 für Datei &2/&1 konnte nicht abgerufen werden */
005919000000     /*-------------------------------------------------------------*/
005920000000
005921000000             RMVMSGD MSGID(USR0001) MSGF(&LIB/&OBJ)
005922000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005923000000
005924000000             ADDMSGD +
005925000000                MSGID(USR0001) +
005926000000                MSGF(&LIB/&OBJ) +
005927000000                MSG( +
005928000000'Satzformat &3 für Datei &2/&1 konnte nicht abgerufen werden.'        +
005929000000                ) +
005930000000                SEV(0) +
005931000000                FMT( +
005932000000                    (*CHAR 10) +
005933000000                    (*CHAR 10) +
005934000000                    (*CHAR 10) +
005935000000                ) +
005936000000                ALROPT(*NO) +
005937000000                CCSID(65535) +
005938000000                /*  -EOF-  */
005939000000
005940000000     /*-------------------------------------------------------------*/
005941000000     /*   Cmd-ADDMSGD für Message-ID :   USR0002                    */
005942000000     /* Liste der Satzformate für Datei &2/&1 konnte nicht abgerufe */
005943000000     /*-------------------------------------------------------------*/
005944000000
005945000000             RMVMSGD MSGID(USR0002) MSGF(&LIB/&OBJ)
005946000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005947000000
005948000000             ADDMSGD +
005949000000                MSGID(USR0002) +
005950000000                MSGF(&LIB/&OBJ) +
005951000000                MSG( +
005952000000'Liste der Satzformate für Datei &2/&1 konnte nicht abgerufen werden.'+
005953000000                ) +
005954000000                SEV(0) +
005955000000                FMT( +
005956000000                    (*CHAR 10) +
005957000000                    (*CHAR 10) +
005958000000                ) +
005959000000                ALROPT(*NO) +
005960000000                CCSID(65535) +
005961000000                /*  -EOF-  */
005962000000
005963000000     /*-------------------------------------------------------------*/
005964000000     /*   Cmd-ADDMSGD für Message-ID :   USR0003                    */
005965000000     /* Datei mit Commitment-Kontrolle geöffnet.                    */
005966000000     /*-------------------------------------------------------------*/
005967000000
005968000000             RMVMSGD MSGID(USR0003) MSGF(&LIB/&OBJ)
005969000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005970000000
005971000000             ADDMSGD +
005972000000                MSGID(USR0003) +
005973000000                MSGF(&LIB/&OBJ) +
005974000000                MSG( +
005975000000'Datei mit Commitment-Kontrolle geöffnet.'                            +
005976000000                ) +
005977000000                SEV(0) +
005978000000     /*   No replacement variables defined!                         */ +
005979000000                ALROPT(*NO) +
005980000000                CCSID(65535) +
005981000000                /*  -EOF-  */
005982000000
005983000000     /*-------------------------------------------------------------*/
005984000000     /*   Cmd-ADDMSGD für Message-ID :   USR0004                    */
005985000000     /* Datei OHNE Commitment-Kontrolle geöffnet!                   */
005986000000     /*-------------------------------------------------------------*/
005987000000
005988000000             RMVMSGD MSGID(USR0004) MSGF(&LIB/&OBJ)
005989000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005990000000
005991000000             ADDMSGD +
005992000000                MSGID(USR0004) +
005993000000                MSGF(&LIB/&OBJ) +
005994000000                MSG( +
005995000000'Datei OHNE Commitment-Kontrolle geöffnet!'                           +
005996000000                ) +
005997000000                SEV(0) +
005998000000     /*   No replacement variables defined!                         */ +
005999000000                ALROPT(*NO) +
006000000000                CCSID(65535) +
006001000000                /*  -EOF-  */
006002000000
006003000000     /*-------------------------------------------------------------*/
006004000000     /*   Cmd-ADDMSGD für Message-ID :   USR0005                    */
006005000000     /* Datei &1 konnte nicht geöffnet werden. Siehe Jobprotokoll.  */
006006000000     /*-------------------------------------------------------------*/
006007000000
006008000000             RMVMSGD MSGID(USR0005) MSGF(&LIB/&OBJ)
006009000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006010000000
006011000000             ADDMSGD +
006012000000                MSGID(USR0005) +
006013000000                MSGF(&LIB/&OBJ) +
006014000000                MSG( +
006015000000'Datei &1 konnte nicht geöffnet werden. Siehe Jobprotokoll.'          +
006016000000                ) +
006017000000                SEV(0) +
006018000000                FMT( +
006019000000                    (*CHAR 10) +
006020000000                ) +
006021000000                ALROPT(*NO) +
006022000000                CCSID(65535) +
006023000000                /*  -EOF-  */
006024000000
006025000000     /*-------------------------------------------------------------*/
006026000000     /*   Cmd-ADDMSGD für Message-ID :   USR0006                    */
006027000000     /* Keine Schlüsselinformationen in Datei &1 in Bibliothek &2.  */
006028000000     /*-------------------------------------------------------------*/
006029000000
006030000000             RMVMSGD MSGID(USR0006) MSGF(&LIB/&OBJ)
006031000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006032000000
006033000000             ADDMSGD +
006034000000                MSGID(USR0006) +
006035000000                MSGF(&LIB/&OBJ) +
006036000000                MSG( +
006037000000'Keine Schlüsselinformationen in Datei &1 in Bibliothek &2.'          +
006038000000                ) +
006039000000                SEV(0) +
006040000000                FMT( +
006041000000                    (*CHAR 10) +
006042000000                    (*CHAR 10) +
006043000000                ) +
006044000000                ALROPT(*NO) +
006045000000                CCSID(65535) +
006046000000                /*  -EOF-  */
006047000000
006048000000     /*-------------------------------------------------------------*/
006049000000     /*   Cmd-ADDMSGD für Message-ID :   USR0007                    */
006050000000     /* Die Datei &2/&1 konnte nur für INPUT geöffnet werden. Änder */
006051000000     /*-------------------------------------------------------------*/
006052000000
006053000000             RMVMSGD MSGID(USR0007) MSGF(&LIB/&OBJ)
006054000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006055000000
006056000000             ADDMSGD +
006057000000                MSGID(USR0007) +
006058000000                MSGF(&LIB/&OBJ) +
006059000000                MSG( +
006060000000'Die Datei &2/&1 konnte nur für INPUT geöffnet werden. Änderungen sind-
006061000000 nicht möglich.'                                                      +
006062000000                ) +
006063000000                SECLVL( +
006064000000'&N &N Mögliche Ursachen: &N &B 1. Der Debugger ist mit dem Parameter -
006065000000UPDPROD(*NO) gestartet worden. &B 2. Es handelt sich um eine JOIN-Date-
006066000000i &B 3. Es gibt referenzielle Integritätsregeln und die Datei wird nic-
006067000000ht journalisiert. &B 4. Es gibt Triggerdefinitionen und die Triggerpro-
006068000000gramme befinden sich nicht in der Bibliotheksliste &B 5. Es handelt si-
006069000000ch um eine logische Datei, die auf mehreren Teildateien basiert.'     +
006070000000                ) +
006071000000                SEV(0) +
006072000000                FMT( +
006073000000                    (*CHAR 10) +
006074000000                    (*CHAR 10) +
006075000000                ) +
006076000000                ALROPT(*NO) +
006077000000                CCSID(65535) +
006078000000                /*  -EOF-  */
006079000000
006080000000     /*-------------------------------------------------------------*/
006081000000     /*   Cmd-ADDMSGD für Message-ID :   USR0008                    */
006082000000     /* Die Datei &2/&1 konnte nicht gefunden werden.               */
006083000000     /*-------------------------------------------------------------*/
006084000000
006085000000             RMVMSGD MSGID(USR0008) MSGF(&LIB/&OBJ)
006086000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006087000000
006088000000             ADDMSGD +
006089000000                MSGID(USR0008) +
006090000000                MSGF(&LIB/&OBJ) +
006091000000                MSG( +
006092000000'Die Datei &2/&1 konnte nicht gefunden werden.'                       +
006093000000                ) +
006094000000                SEV(0) +
006095000000                FMT( +
006096000000                    (*CHAR 10) +
006097000000                    (*CHAR 10) +
006098000000                ) +
006099000000                ALROPT(*NO) +
006100000000                CCSID(65535) +
006101000000                /*  -EOF-  */
006102000000
006103000000     /*-------------------------------------------------------------*/
006104000000     /*   Cmd-ADDMSGD für Message-ID :   USR0009                    */
006105000000     /* Fehler beim Abrufen der Objektbeschreibung für Datei &2/&1. */
006106000000     /*-------------------------------------------------------------*/
006107000000
006108000000             RMVMSGD MSGID(USR0009) MSGF(&LIB/&OBJ)
006109000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006110000000
006111000000             ADDMSGD +
006112000000                MSGID(USR0009) +
006113000000                MSGF(&LIB/&OBJ) +
006114000000                MSG( +
006115000000'Fehler beim Abrufen der Objektbeschreibung für Datei &2/&1.'         +
006116000000                ) +
006117000000                SEV(0) +
006118000000                FMT( +
006119000000                    (*CHAR 10) +
006120000000                    (*CHAR 10) +
006121000000                ) +
006122000000                ALROPT(*NO) +
006123000000                CCSID(65535) +
006124000000                /*  -EOF-  */
006125000000
006126000000     /*-------------------------------------------------------------*/
006127000000     /*   Cmd-ADDMSGD für Message-ID :   USR0010                    */
006128000000     /* Bibliothek &1 nicht gefunden.                               */
006129000000     /*-------------------------------------------------------------*/
006130000000
006131000000             RMVMSGD MSGID(USR0010) MSGF(&LIB/&OBJ)
006132000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006133000000
006134000000             ADDMSGD +
006135000000                MSGID(USR0010) +
006136000000                MSGF(&LIB/&OBJ) +
006137000000                MSG( +
006138000000'Bibliothek &1 nicht gefunden.'                                       +
006139000000                ) +
006140000000                SEV(0) +
006141000000                FMT( +
006142000000                    (*CHAR 10) +
006143000000                ) +
006144000000                ALROPT(*NO) +
006145000000                CCSID(65535) +
006146000000                /*  -EOF-  */
006147000000
006148000000     /*-------------------------------------------------------------*/
006149000000     /*   Cmd-ADDMSGD für Message-ID :   USR0011                    */
006150000000     /* Datei konnte nicht geöffnet werden. Weitere Informationen i */
006151000000     /*-------------------------------------------------------------*/
006152000000
006153000000             RMVMSGD MSGID(USR0011) MSGF(&LIB/&OBJ)
006154000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006155000000
006156000000             ADDMSGD +
006157000000                MSGID(USR0011) +
006158000000                MSGF(&LIB/&OBJ) +
006159000000                MSG( +
006160000000'Datei konnte nicht geöffnet werden. Weitere Informationen im erweiter-
006161000000ten Hilfetext oder im Jobprotokoll.'                                  +
006162000000                ) +
006163000000                SECLVL( +
006164000000'&N &N Fehlertext  . . :   &1'                                        +
006165000000                ) +
006166000000                SEV(0) +
006167000000                FMT( +
006168000000                    (*CHAR 256) +
006169000000                ) +
006170000000                ALROPT(*NO) +
006171000000                CCSID(65535) +
006172000000                /*  -EOF-  */
006173000000
006174000000     /*-------------------------------------------------------------*/
006175000000     /*   Cmd-ADDMSGD für Message-ID :   USR0012                    */
006176000000     /* C-IO Fehler &2: &1                                          */
006177000000     /*-------------------------------------------------------------*/
006178000000
006179000000             RMVMSGD MSGID(USR0012) MSGF(&LIB/&OBJ)
006180000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006181000000
006182000000             ADDMSGD +
006183000000                MSGID(USR0012) +
006184000000                MSGF(&LIB/&OBJ) +
006185000000                MSG( +
006186000000'C-IO Fehler &2: &1'                                                  +
006187000000                ) +
006188000000                SEV(0) +
006189000000                FMT( +
006190000000                    (*CHAR 256) +
006191000000                    (*DEC 5 0) +
006192000000                ) +
006193000000                ALROPT(*NO) +
006194000000                CCSID(65535) +
006195000000                /*  -EOF-  */
006196000000
006197000000     /*-------------------------------------------------------------*/
006198000000     /*   Cmd-ADDMSGD für Message-ID :   USR0013                    */
006199000000     /* Ausführen SQL Abfrage ...                                   */
006200000000     /*-------------------------------------------------------------*/
006201000000
006202000000             RMVMSGD MSGID(USR0013) MSGF(&LIB/&OBJ)
006203000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006204000000
006205000000             ADDMSGD +
006206000000                MSGID(USR0013) +
006207000000                MSGF(&LIB/&OBJ) +
006208000000                MSG( +
006209000000'Ausführen SQL Abfrage ...'                                           +
006210000000                ) +
006211000000                SEV(0) +
006212000000     /*   No replacement variables defined!                         */ +
006213000000                ALROPT(*NO) +
006214000000                CCSID(65535) +
006215000000                /*  -EOF-  */
006216000000
006217000000     /*-------------------------------------------------------------*/
006218000000     /*   Cmd-ADDMSGD für Message-ID :   USR0014                    */
006219000000     /* Bestimmen Anzahl ausgewählter Datensätze ...                */
006220000000     /*-------------------------------------------------------------*/
006221000000
006222000000             RMVMSGD MSGID(USR0014) MSGF(&LIB/&OBJ)
006223000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006224000000
006225000000             ADDMSGD +
006226000000                MSGID(USR0014) +
006227000000                MSGF(&LIB/&OBJ) +
006228000000                MSG( +
006229000000'Bestimmen Anzahl ausgewählter Datensätze ...'                        +
006230000000                ) +
006231000000                SEV(0) +
006232000000     /*   No replacement variables defined!                         */ +
006233000000                ALROPT(*NO) +
006234000000                CCSID(65535) +
006235000000                /*  -EOF-  */
006236000000
006237000000     /*-------------------------------------------------------------*/
006238000000     /*   Cmd-ADDMSGD für Message-ID :   USR0143                    */
006239000000     /* - Auswahl Teildatei -                                       */
006240000000     /*-------------------------------------------------------------*/
006241000000
006242000000             RMVMSGD MSGID(USR0143) MSGF(&LIB/&OBJ)
006243000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006244000000
006245000000             ADDMSGD +
006246000000                MSGID(USR0143) +
006247000000                MSGF(&LIB/&OBJ) +
006248000000                MSG( +
006249000000'- Auswahl Teildatei -'                                               +
006250000000                ) +
006251000000                SEV(0) +
006252000000     /*   No replacement variables defined!                         */ +
006253000000                ALROPT(*NO) +
006254000000                CCSID(65535) +
006255000000                /*  -EOF-  */
006256000000
006257000000     /*-------------------------------------------------------------*/
006258000000     /*   Cmd-ADDMSGD für Message-ID :   USR1000                    */
006259000000     /* Keine Berechtigung für Datei &2/&1, Teildatei &3.           */
006260000000     /*-------------------------------------------------------------*/
006261000000
006262000000             RMVMSGD MSGID(USR1000) MSGF(&LIB/&OBJ)
006263000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006264000000
006265000000             ADDMSGD +
006266000000                MSGID(USR1000) +
006267000000                MSGF(&LIB/&OBJ) +
006268000000                MSG( +
006269000000'Keine Berechtigung für Datei &2/&1, Teildatei &3.'                   +
006270000000                ) +
006271000000                SEV(0) +
006272000000                FMT( +
006273000000                    (*CHAR 10) +
006274000000                    (*CHAR 10) +
006275000000                    (*CHAR 10) +
006276000000                ) +
006277000000                ALROPT(*NO) +
006278000000                CCSID(65535) +
006279000000                /*  -EOF-  */
006280000000
006281000000     /*-------------------------------------------------------------*/
006282000000     /*   Cmd-ADDMSGD für Message-ID :   USR8100                    */
006283000000     /* Verarbeitung mit &1 abgebrochen.                            */
006284000000     /*-------------------------------------------------------------*/
006285000000
006286000000             RMVMSGD MSGID(USR8100) MSGF(&LIB/&OBJ)
006287000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006288000000
006289000000             ADDMSGD +
006290000000                MSGID(USR8100) +
006291000000                MSGF(&LIB/&OBJ) +
006292000000                MSG( +
006293000000'Verarbeitung mit &1 abgebrochen.'                                    +
006294000000                ) +
006295000000                SEV(0) +
006296000000                FMT( +
006297000000                    (*CHAR 10) +
006298000000                ) +
006299000000                ALROPT(*NO) +
006300000000                CCSID(65535) +
006301000000                /*  -EOF-  */
006302000000
006303000000     /*-------------------------------------------------------------*/
006304000000     /*   Cmd-ADDMSGD für Message-ID :   USR8101                    */
006305000000     /* Initialisierung läuft ...                                   */
006306000000     /*-------------------------------------------------------------*/
006307000000
006308000000             RMVMSGD MSGID(USR8101) MSGF(&LIB/&OBJ)
006309000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006310000000
006311000000             ADDMSGD +
006312000000                MSGID(USR8101) +
006313000000                MSGF(&LIB/&OBJ) +
006314000000                MSG( +
006315000000'Initialisierung läuft ...'                                           +
006316000000                ) +
006317000000                SEV(0) +
006318000000     /*   No replacement variables defined!                         */ +
006319000000                ALROPT(*NO) +
006320000000                CCSID(65535) +
006321000000                /*  -EOF-  */
006322000000
006323000000     /*-------------------------------------------------------------*/
006324000000     /*   Cmd-ADDMSGD für Message-ID :   USR8102                    */
006325000000     /* Bitte mit dem Cursor auf den Datensatz zeigen und die Anfor */
006326000000     /*-------------------------------------------------------------*/
006327000000
006328000000             RMVMSGD MSGID(USR8102) MSGF(&LIB/&OBJ)
006329000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006330000000
006331000000             ADDMSGD +
006332000000                MSGID(USR8102) +
006333000000                MSGF(&LIB/&OBJ) +
006334000000                MSG( +
006335000000'Bitte mit dem Cursor auf den Datensatz zeigen und die Anforderung wie-
006336000000derholen.'                                                            +
006337000000                ) +
006338000000                SEV(0) +
006339000000     /*   No replacement variables defined!                         */ +
006340000000                ALROPT(*NO) +
006341000000                CCSID(65535) +
006342000000                /*  -EOF-  */
006343000000
006344000000     /*-------------------------------------------------------------*/
006345000000     /*   Cmd-ADDMSGD für Message-ID :   USR8103                    */
006346000000     /* Datei kann nicht geschlossen werden.                        */
006347000000     /*-------------------------------------------------------------*/
006348000000
006349000000             RMVMSGD MSGID(USR8103) MSGF(&LIB/&OBJ)
006350000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006351000000
006352000000             ADDMSGD +
006353000000                MSGID(USR8103) +
006354000000                MSGF(&LIB/&OBJ) +
006355000000                MSG( +
006356000000'Datei kann nicht geschlossen werden.'                                +
006357000000                ) +
006358000000                SEV(0) +
006359000000     /*   No replacement variables defined!                         */ +
006360000000                ALROPT(*NO) +
006361000000                CCSID(65535) +
006362000000                /*  -EOF-  */
006363000000
006364000000     /*-------------------------------------------------------------*/
006365000000     /*   Cmd-ADDMSGD für Message-ID :   USR8104                    */
006366000000     /* Abrufen der Feldbeschreibung für Datei &1 in Bibliothek &2. */
006367000000     /*-------------------------------------------------------------*/
006368000000
006369000000             RMVMSGD MSGID(USR8104) MSGF(&LIB/&OBJ)
006370000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006371000000
006372000000             ADDMSGD +
006373000000                MSGID(USR8104) +
006374000000                MSGF(&LIB/&OBJ) +
006375000000                MSG( +
006376000000'Abrufen der Feldbeschreibung für Datei &1 in Bibliothek &2.'         +
006377000000                ) +
006378000000                SEV(0) +
006379000000                FMT( +
006380000000                    (*CHAR 10) +
006381000000                    (*CHAR 10) +
006382000000                ) +
006383000000                ALROPT(*NO) +
006384000000                CCSID(65535) +
006385000000                /*  -EOF-  */
006386000000
006387000000     /*-------------------------------------------------------------*/
006388000000     /*   Cmd-ADDMSGD für Message-ID :   USR8105                    */
006389000000     /* Abrufen der Satzformate für Datei &1 in Bibliothek &2.      */
006390000000     /*-------------------------------------------------------------*/
006391000000
006392000000             RMVMSGD MSGID(USR8105) MSGF(&LIB/&OBJ)
006393000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006394000000
006395000000             ADDMSGD +
006396000000                MSGID(USR8105) +
006397000000                MSGF(&LIB/&OBJ) +
006398000000                MSG( +
006399000000'Abrufen der Satzformate für Datei &1 in Bibliothek &2.'              +
006400000000                ) +
006401000000                SEV(0) +
006402000000                FMT( +
006403000000                    (*CHAR 10) +
006404000000                    (*CHAR 10) +
006405000000                ) +
006406000000                ALROPT(*NO) +
006407000000                CCSID(65535) +
006408000000                /*  -EOF-  */
006409000000
006410000000     /*-------------------------------------------------------------*/
006411000000     /*   Cmd-ADDMSGD für Message-ID :   USR8106                    */
006412000000     /* Abrufen von Netzwerkattributen.                             */
006413000000     /*-------------------------------------------------------------*/
006414000000
006415000000             RMVMSGD MSGID(USR8106) MSGF(&LIB/&OBJ)
006416000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006417000000
006418000000             ADDMSGD +
006419000000                MSGID(USR8106) +
006420000000                MSGF(&LIB/&OBJ) +
006421000000                MSG( +
006422000000'Abrufen von Netzwerkattributen.'                                     +
006423000000                ) +
006424000000                SEV(0) +
006425000000     /*   No replacement variables defined!                         */ +
006426000000                ALROPT(*NO) +
006427000000                CCSID(65535) +
006428000000                /*  -EOF-  */
006429000000
006430000000     /*-------------------------------------------------------------*/
006431000000     /*   Cmd-ADDMSGD für Message-ID :   USR8107                    */
006432000000     /* Abrufen von Objektattributen für Objekt &1 in Bibliothek &2 */
006433000000     /*-------------------------------------------------------------*/
006434000000
006435000000             RMVMSGD MSGID(USR8107) MSGF(&LIB/&OBJ)
006436000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006437000000
006438000000             ADDMSGD +
006439000000                MSGID(USR8107) +
006440000000                MSGF(&LIB/&OBJ) +
006441000000                MSG( +
006442000000'Abrufen von Objektattributen für Objekt &1 in Bibliothek &2.'        +
006443000000                ) +
006444000000                SEV(0) +
006445000000                FMT( +
006446000000                    (*CHAR 10) +
006447000000                    (*CHAR 10) +
006448000000                    (*CHAR 10) +
006449000000                ) +
006450000000                ALROPT(*NO) +
006451000000                CCSID(65535) +
006452000000                /*  -EOF-  */
006453000000
006454000000     /*-------------------------------------------------------------*/
006455000000     /*   Cmd-ADDMSGD für Message-ID :   USR8108                    */
006456000000     /* Feld '&1' in Datei &2 in Bibliothek &3 nicht gefunden.      */
006457000000     /*-------------------------------------------------------------*/
006458000000
006459000000             RMVMSGD MSGID(USR8108) MSGF(&LIB/&OBJ)
006460000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006461000000
006462000000             ADDMSGD +
006463000000                MSGID(USR8108) +
006464000000                MSGF(&LIB/&OBJ) +
006465000000                MSG( +
006466000000'Feld ''&1'' in Datei &2 in Bibliothek &3 nicht gefunden.'            +
006467000000                ) +
006468000000                SEV(0) +
006469000000                FMT( +
006470000000                    (*CHAR 10) +
006471000000                    (*CHAR 10) +
006472000000                    (*CHAR 10) +
006473000000                ) +
006474000000                ALROPT(*NO) +
006475000000                CCSID(65535) +
006476000000                /*  -EOF-  */
006477000000
006478000000     /*-------------------------------------------------------------*/
006479000000     /*   Cmd-ADDMSGD für Message-ID :   USR8109                    */
006480000000     /* Abrufen der Teildateibeschreibung für Teildatei &3 in Datei */
006481000000     /*-------------------------------------------------------------*/
006482000000
006483000000             RMVMSGD MSGID(USR8109) MSGF(&LIB/&OBJ)
006484000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006485000000
006486000000             ADDMSGD +
006487000000                MSGID(USR8109) +
006488000000                MSGF(&LIB/&OBJ) +
006489000000                MSG( +
006490000000'Abrufen der Teildateibeschreibung für Teildatei &3 in Datei &1 in Bib-
006491000000liothek &2.'                                                          +
006492000000                ) +
006493000000                SEV(0) +
006494000000                FMT( +
006495000000                    (*CHAR 10) +
006496000000                    (*CHAR 10) +
006497000000                    (*CHAR 10) +
006498000000                ) +
006499000000                ALROPT(*NO) +
006500000000                CCSID(65535) +
006501000000                /*  -EOF-  */
006502000000
006503000000     /*-------------------------------------------------------------*/
006504000000     /*   Cmd-ADDMSGD für Message-ID :   USR8110                    */
006505000000     /* Auswahl '&1' nicht gültig.                                  */
006506000000     /*-------------------------------------------------------------*/
006507000000
006508000000             RMVMSGD MSGID(USR8110) MSGF(&LIB/&OBJ)
006509000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006510000000
006511000000             ADDMSGD +
006512000000                MSGID(USR8110) +
006513000000                MSGF(&LIB/&OBJ) +
006514000000                MSG( +
006515000000'Auswahl ''&1'' nicht gültig.'                                        +
006516000000                ) +
006517000000                SEV(0) +
006518000000                FMT( +
006519000000                    (*CHAR 10) +
006520000000                ) +
006521000000                ALROPT(*NO) +
006522000000                CCSID(65535) +
006523000000                /*  -EOF-  */
006524000000
006525000000     /*-------------------------------------------------------------*/
006526000000     /*   Cmd-ADDMSGD für Message-ID :   USR8111                    */
006527000000     /* Alle Datensätze verarbeiten.                                */
006528000000     /*-------------------------------------------------------------*/
006529000000
006530000000             RMVMSGD MSGID(USR8111) MSGF(&LIB/&OBJ)
006531000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006532000000
006533000000             ADDMSGD +
006534000000                MSGID(USR8111) +
006535000000                MSGF(&LIB/&OBJ) +
006536000000                MSG( +
006537000000'Alle Datensätze verarbeiten.'                                        +
006538000000                ) +
006539000000                SEV(0) +
006540000000     /*   No replacement variables defined!                         */ +
006541000000                ALROPT(*NO) +
006542000000                CCSID(65535) +
006543000000                /*  -EOF-  */
006544000000
006545000000     /*-------------------------------------------------------------*/
006546000000     /*   Cmd-ADDMSGD für Message-ID :   USR8112                    */
006547000000     /* Verarbeitung bestätigt.                                     */
006548000000     /*-------------------------------------------------------------*/
006549000000
006550000000             RMVMSGD MSGID(USR8112) MSGF(&LIB/&OBJ)
006551000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006552000000
006553000000             ADDMSGD +
006554000000                MSGID(USR8112) +
006555000000                MSGF(&LIB/&OBJ) +
006556000000                MSG( +
006557000000'Verarbeitung bestätigt.'                                             +
006558000000                ) +
006559000000                SEV(0) +
006560000000     /*   No replacement variables defined!                         */ +
006561000000                ALROPT(*NO) +
006562000000                CCSID(65535) +
006563000000                /*  -EOF-  */
006564000000
006565000000     /*-------------------------------------------------------------*/
006566000000     /*   Cmd-ADDMSGD für Message-ID :   USR8113                    */
006567000000     /* Interner Befehl &1 nicht gültig.                            */
006568000000     /*-------------------------------------------------------------*/
006569000000
006570000000             RMVMSGD MSGID(USR8113) MSGF(&LIB/&OBJ)
006571000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006572000000
006573000000             ADDMSGD +
006574000000                MSGID(USR8113) +
006575000000                MSGF(&LIB/&OBJ) +
006576000000                MSG( +
006577000000'Interner Befehl &1 nicht gültig.'                                    +
006578000000                ) +
006579000000                SEV(0) +
006580000000                FMT( +
006581000000                    (*CHAR 10) +
006582000000                ) +
006583000000                ALROPT(*NO) +
006584000000                CCSID(65535) +
006585000000                /*  -EOF-  */
006586000000
006587000000     /*-------------------------------------------------------------*/
006588000000     /*   Cmd-ADDMSGD für Message-ID :   USR8114                    */
006589000000     /* RPG-Programm wird erstellt ...                              */
006590000000     /*-------------------------------------------------------------*/
006591000000
006592000000             RMVMSGD MSGID(USR8114) MSGF(&LIB/&OBJ)
006593000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006594000000
006595000000             ADDMSGD +
006596000000                MSGID(USR8114) +
006597000000                MSGF(&LIB/&OBJ) +
006598000000                MSG( +
006599000000'RPG-Programm wird erstellt ...'                                      +
006600000000                ) +
006601000000                SEV(0) +
006602000000     /*   No replacement variables defined!                         */ +
006603000000                ALROPT(*NO) +
006604000000                CCSID(65535) +
006605000000                /*  -EOF-  */
006606000000
006607000000     /*-------------------------------------------------------------*/
006608000000     /*   Cmd-ADDMSGD für Message-ID :   USR8115                    */
006609000000     /* Anfang des Datensatzes angezeigt.                           */
006610000000     /*-------------------------------------------------------------*/
006611000000
006612000000             RMVMSGD MSGID(USR8115) MSGF(&LIB/&OBJ)
006613000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006614000000
006615000000             ADDMSGD +
006616000000                MSGID(USR8115) +
006617000000                MSGF(&LIB/&OBJ) +
006618000000                MSG( +
006619000000'Anfang des Datensatzes angezeigt.'                                   +
006620000000                ) +
006621000000                SEV(0) +
006622000000     /*   No replacement variables defined!                         */ +
006623000000                ALROPT(*NO) +
006624000000                CCSID(65535) +
006625000000                /*  -EOF-  */
006626000000
006627000000     /*-------------------------------------------------------------*/
006628000000     /*   Cmd-ADDMSGD für Message-ID :   USR8116                    */
006629000000     /* Ende des Datensatzes angezeigt.                             */
006630000000     /*-------------------------------------------------------------*/
006631000000
006632000000             RMVMSGD MSGID(USR8116) MSGF(&LIB/&OBJ)
006633000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006634000000
006635000000             ADDMSGD +
006636000000                MSGID(USR8116) +
006637000000                MSGF(&LIB/&OBJ) +
006638000000                MSG( +
006639000000'Ende des Datensatzes angezeigt.'                                     +
006640000000                ) +
006641000000                SEV(0) +
006642000000     /*   No replacement variables defined!                         */ +
006643000000                ALROPT(*NO) +
006644000000                CCSID(65535) +
006645000000                /*  -EOF-  */
006646000000
006647000000     /*-------------------------------------------------------------*/
006648000000     /*   Cmd-ADDMSGD für Message-ID :   USR8117                    */
006649000000     /* Bitte mit dem Cursor auf eine Spalte zeigen und die Anforde */
006650000000     /*-------------------------------------------------------------*/
006651000000
006652000000             RMVMSGD MSGID(USR8117) MSGF(&LIB/&OBJ)
006653000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006654000000
006655000000             ADDMSGD +
006656000000                MSGID(USR8117) +
006657000000                MSGF(&LIB/&OBJ) +
006658000000                MSG( +
006659000000'Bitte mit dem Cursor auf eine Spalte zeigen und die Anforderung wiede-
006660000000rholen.'                                                              +
006661000000                ) +
006662000000                SEV(0) +
006663000000     /*   No replacement variables defined!                         */ +
006664000000                ALROPT(*NO) +
006665000000                CCSID(65535) +
006666000000                /*  -EOF-  */
006667000000
006668000000     /*-------------------------------------------------------------*/
006669000000     /*   Cmd-ADDMSGD für Message-ID :   USR8118                    */
006670000000     /* Tabelle für PIN ist voll.                                   */
006671000000     /*-------------------------------------------------------------*/
006672000000
006673000000             RMVMSGD MSGID(USR8118) MSGF(&LIB/&OBJ)
006674000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006675000000
006676000000             ADDMSGD +
006677000000                MSGID(USR8118) +
006678000000                MSGF(&LIB/&OBJ) +
006679000000                MSG( +
006680000000'Tabelle für PIN ist voll.'                                           +
006681000000                ) +
006682000000                SEV(0) +
006683000000     /*   No replacement variables defined!                         */ +
006684000000                ALROPT(*NO) +
006685000000                CCSID(65535) +
006686000000                /*  -EOF-  */
006687000000
006688000000     /*-------------------------------------------------------------*/
006689000000     /*   Cmd-ADDMSGD für Message-ID :   USR8119                    */
006690000000     /* Datensatz bereits gepinned.                                 */
006691000000     /*-------------------------------------------------------------*/
006692000000
006693000000             RMVMSGD MSGID(USR8119) MSGF(&LIB/&OBJ)
006694000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006695000000
006696000000             ADDMSGD +
006697000000                MSGID(USR8119) +
006698000000                MSGF(&LIB/&OBJ) +
006699000000                MSG( +
006700000000'Datensatz bereits gepinned.'                                         +
006701000000                ) +
006702000000                SEV(0) +
006703000000     /*   No replacement variables defined!                         */ +
006704000000                ALROPT(*NO) +
006705000000                CCSID(65535) +
006706000000                /*  -EOF-  */
006707000000
006708000000     /*-------------------------------------------------------------*/
006709000000     /*   Cmd-ADDMSGD für Message-ID :   USR8120                    */
006710000000     /* Datensatz nicht gefunden.                                   */
006711000000     /*-------------------------------------------------------------*/
006712000000
006713000000             RMVMSGD MSGID(USR8120) MSGF(&LIB/&OBJ)
006714000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006715000000
006716000000             ADDMSGD +
006717000000                MSGID(USR8120) +
006718000000                MSGF(&LIB/&OBJ) +
006719000000                MSG( +
006720000000'Datensatz nicht gefunden.'                                           +
006721000000                ) +
006722000000                SEV(0) +
006723000000     /*   No replacement variables defined!                         */ +
006724000000                ALROPT(*NO) +
006725000000                CCSID(65535) +
006726000000                /*  -EOF-  */
006727000000
006728000000     /*-------------------------------------------------------------*/
006729000000     /*   Cmd-ADDMSGD für Message-ID :   USR8121                    */
006730000000     /* Datensatz ist nicht gepinned.                               */
006731000000     /*-------------------------------------------------------------*/
006732000000
006733000000             RMVMSGD MSGID(USR8121) MSGF(&LIB/&OBJ)
006734000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006735000000
006736000000             ADDMSGD +
006737000000                MSGID(USR8121) +
006738000000                MSGF(&LIB/&OBJ) +
006739000000                MSG( +
006740000000'Datensatz ist nicht gepinned.'                                       +
006741000000                ) +
006742000000                SEV(0) +
006743000000     /*   No replacement variables defined!                         */ +
006744000000                ALROPT(*NO) +
006745000000                CCSID(65535) +
006746000000                /*  -EOF-  */
006747000000
006748000000     /*-------------------------------------------------------------*/
006749000000     /*   Cmd-ADDMSGD für Message-ID :   USR8122                    */
006750000000     /* Funktionstaste nicht zulässig.                              */
006751000000     /*-------------------------------------------------------------*/
006752000000
006753000000             RMVMSGD MSGID(USR8122) MSGF(&LIB/&OBJ)
006754000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006755000000
006756000000             ADDMSGD +
006757000000                MSGID(USR8122) +
006758000000                MSGF(&LIB/&OBJ) +
006759000000                MSG( +
006760000000'Funktionstaste nicht zulässig.'                                      +
006761000000                ) +
006762000000                SEV(0) +
006763000000     /*   No replacement variables defined!                         */ +
006764000000                ALROPT(*NO) +
006765000000                CCSID(65535) +
006766000000                /*  -EOF-  */
006767000000
006768000000     /*-------------------------------------------------------------*/
006769000000     /*   Cmd-ADDMSGD für Message-ID :   USR8123                    */
006770000000     /* Felder mit mehr als 1024-Zeichen können&1nicht&2geändert we */
006771000000     /*-------------------------------------------------------------*/
006772000000
006773000000             RMVMSGD MSGID(USR8123) MSGF(&LIB/&OBJ)
006774000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006775000000
006776000000             ADDMSGD +
006777000000                MSGID(USR8123) +
006778000000                MSGF(&LIB/&OBJ) +
006779000000                MSG( +
006780000000'Felder mit mehr als 1024-Zeichen können&1nicht&2geändert werden.'    +
006781000000                ) +
006782000000                SEV(0) +
006783000000                FMT( +
006784000000                    (*CHAR 1) +
006785000000                    (*CHAR 1) +
006786000000                ) +
006787000000                ALROPT(*NO) +
006788000000                CCSID(65535) +
006789000000                /*  -EOF-  */
006790000000
006791000000     /*-------------------------------------------------------------*/
006792000000     /*   Cmd-ADDMSGD für Message-ID :   USR8124                    */
006793000000     /* Vergleichsoperand '&1' nicht zulässig.                      */
006794000000     /*-------------------------------------------------------------*/
006795000000
006796000000             RMVMSGD MSGID(USR8124) MSGF(&LIB/&OBJ)
006797000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006798000000
006799000000             ADDMSGD +
006800000000                MSGID(USR8124) +
006801000000                MSGF(&LIB/&OBJ) +
006802000000                MSG( +
006803000000'Vergleichsoperand ''&1'' nicht zulässig.'                            +
006804000000                ) +
006805000000                SECLVL( +
006806000000'&N &B Zulässige Operanden sind: &N &P EQ   - Gleich &P NE   - Ungleic-
006807000000h &P LT   - Kleiner &P GT   - Größer &P LE   - Kleiner/Gleich &P GE   -
006808000000- Größer/Gleich &P LIKE - Ähnlich'                                    +
006809000000                ) +
006810000000                SEV(0) +
006811000000                FMT( +
006812000000                    (*CHAR 10) +
006813000000                ) +
006814000000                ALROPT(*NO) +
006815000000                CCSID(65535) +
006816000000                /*  -EOF-  */
006817000000
006818000000     /*-------------------------------------------------------------*/
006819000000     /*   Cmd-ADDMSGD für Message-ID :   USR8125                    */
006820000000     /* Keine Anzahl der max. zu durchsuchenden Datensätze angegebe */
006821000000     /*-------------------------------------------------------------*/
006822000000
006823000000             RMVMSGD MSGID(USR8125) MSGF(&LIB/&OBJ)
006824000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006825000000
006826000000             ADDMSGD +
006827000000                MSGID(USR8125) +
006828000000                MSGF(&LIB/&OBJ) +
006829000000                MSG( +
006830000000'Keine Anzahl der max. zu durchsuchenden Datensätze angegeben.'       +
006831000000                ) +
006832000000                SEV(0) +
006833000000     /*   No replacement variables defined!                         */ +
006834000000                ALROPT(*NO) +
006835000000                CCSID(65535) +
006836000000                /*  -EOF-  */
006837000000
006838000000     /*-------------------------------------------------------------*/
006839000000     /*   Cmd-ADDMSGD für Message-ID :   USR8126                    */
006840000000     /* Vergleichsoperand '&1' nicht zulässig.                      */
006841000000     /*-------------------------------------------------------------*/
006842000000
006843000000             RMVMSGD MSGID(USR8126) MSGF(&LIB/&OBJ)
006844000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006845000000
006846000000             ADDMSGD +
006847000000                MSGID(USR8126) +
006848000000                MSGF(&LIB/&OBJ) +
006849000000                MSG( +
006850000000'Vergleichsoperand ''&1'' nicht zulässig.'                            +
006851000000                ) +
006852000000                SEV(0) +
006853000000                FMT( +
006854000000                    (*CHAR 10) +
006855000000                ) +
006856000000                ALROPT(*NO) +
006857000000                CCSID(65535) +
006858000000                /*  -EOF-  */
006859000000
006860000000     /*-------------------------------------------------------------*/
006861000000     /*   Cmd-ADDMSGD für Message-ID :   USR8127                    */
006862000000     /* Suche läuft ...                                             */
006863000000     /*-------------------------------------------------------------*/
006864000000
006865000000             RMVMSGD MSGID(USR8127) MSGF(&LIB/&OBJ)
006866000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006867000000
006868000000             ADDMSGD +
006869000000                MSGID(USR8127) +
006870000000                MSGF(&LIB/&OBJ) +
006871000000                MSG( +
006872000000'Suche läuft ...'                                                     +
006873000000                ) +
006874000000                SEV(0) +
006875000000     /*   No replacement variables defined!                         */ +
006876000000                ALROPT(*NO) +
006877000000                CCSID(65535) +
006878000000                /*  -EOF-  */
006879000000
006880000000     /*-------------------------------------------------------------*/
006881000000     /*   Cmd-ADDMSGD für Message-ID :   USR8128                    */
006882000000     /* Suche läuft. &1 von max. &2 Datensätzen durchsucht ...      */
006883000000     /*-------------------------------------------------------------*/
006884000000
006885000000             RMVMSGD MSGID(USR8128) MSGF(&LIB/&OBJ)
006886000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006887000000
006888000000             ADDMSGD +
006889000000                MSGID(USR8128) +
006890000000                MSGF(&LIB/&OBJ) +
006891000000                MSG( +
006892000000'Suche läuft. &1 von max. &2 Datensätzen durchsucht ...'              +
006893000000                ) +
006894000000                SEV(0) +
006895000000                FMT( +
006896000000                    (*DEC 10 0) +
006897000000                    (*DEC 10 0) +
006898000000                ) +
006899000000                ALROPT(*NO) +
006900000000                CCSID(65535) +
006901000000                /*  -EOF-  */
006902000000
006903000000     /*-------------------------------------------------------------*/
006904000000     /*   Cmd-ADDMSGD für Message-ID :   USR8129                    */
006905000000     /* Feld '&1' mit Datentyp '&2' nicht zulässig.                 */
006906000000     /*-------------------------------------------------------------*/
006907000000
006908000000             RMVMSGD MSGID(USR8129) MSGF(&LIB/&OBJ)
006909000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006910000000
006911000000             ADDMSGD +
006912000000                MSGID(USR8129) +
006913000000                MSGF(&LIB/&OBJ) +
006914000000                MSG( +
006915000000'Feld ''&1'' mit Datentyp ''&2'' nicht zulässig.'                     +
006916000000                ) +
006917000000                SEV(0) +
006918000000                FMT( +
006919000000                    (*CHAR 10) +
006920000000                    (*CHAR 10) +
006921000000                ) +
006922000000                ALROPT(*NO) +
006923000000                CCSID(65535) +
006924000000                /*  -EOF-  */
006925000000
006926000000     /*-------------------------------------------------------------*/
006927000000     /*   Cmd-ADDMSGD für Message-ID :   USR8130                    */
006928000000     /* Datensatz gefunden. 'SUCHEN'=Weitersuchen/'ENTER'=Ende.     */
006929000000     /*-------------------------------------------------------------*/
006930000000
006931000000             RMVMSGD MSGID(USR8130) MSGF(&LIB/&OBJ)
006932000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006933000000
006934000000             ADDMSGD +
006935000000                MSGID(USR8130) +
006936000000                MSGF(&LIB/&OBJ) +
006937000000                MSG( +
006938000000'Datensatz gefunden. ''SUCHEN''=Weitersuchen/''ENTER''=Ende.'         +
006939000000                ) +
006940000000                SEV(0) +
006941000000     /*   No replacement variables defined!                         */ +
006942000000                ALROPT(*NO) +
006943000000                CCSID(65535) +
006944000000                /*  -EOF-  */
006945000000
006946000000     /*-------------------------------------------------------------*/
006947000000     /*   Cmd-ADDMSGD für Message-ID :   USR8131                    */
006948000000     /* Dateiende erreicht. Zeichenfolge nicht gefunden. 'SUCHEN'=W */
006949000000     /*-------------------------------------------------------------*/
006950000000
006951000000             RMVMSGD MSGID(USR8131) MSGF(&LIB/&OBJ)
006952000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006953000000
006954000000             ADDMSGD +
006955000000                MSGID(USR8131) +
006956000000                MSGF(&LIB/&OBJ) +
006957000000                MSG( +
006958000000'Dateiende erreicht. Zeichenfolge nicht gefunden. ''SUCHEN''=Weitersuc-
006959000000hen/''ENTER''=Ende.'                                                  +
006960000000                ) +
006961000000                SEV(0) +
006962000000     /*   No replacement variables defined!                         */ +
006963000000                ALROPT(*NO) +
006964000000                CCSID(65535) +
006965000000                /*  -EOF-  */
006966000000
006967000000     /*-------------------------------------------------------------*/
006968000000     /*   Cmd-ADDMSGD für Message-ID :   USR8132                    */
006969000000     /* Maximale Anzahl Datensätze durchsucht. 'SUCHEN'=Weitersuche */
006970000000     /*-------------------------------------------------------------*/
006971000000
006972000000             RMVMSGD MSGID(USR8132) MSGF(&LIB/&OBJ)
006973000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006974000000
006975000000             ADDMSGD +
006976000000                MSGID(USR8132) +
006977000000                MSGF(&LIB/&OBJ) +
006978000000                MSG( +
006979000000'Maximale Anzahl Datensätze durchsucht. ''SUCHEN''=Weitersuchen/''ENTE-
006980000000R''=Ende.'                                                            +
006981000000                ) +
006982000000                SEV(0) +
006983000000     /*   No replacement variables defined!                         */ +
006984000000                ALROPT(*NO) +
006985000000                CCSID(65535) +
006986000000                /*  -EOF-  */
006987000000
006988000000     /*-------------------------------------------------------------*/
006989000000     /*   Cmd-ADDMSGD für Message-ID :   USR8133                    */
006990000000     /* 1=case-sensitive; 0=nicht case-sensitive                    */
006991000000     /*-------------------------------------------------------------*/
006992000000
006993000000             RMVMSGD MSGID(USR8133) MSGF(&LIB/&OBJ)
006994000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006995000000
006996000000             ADDMSGD +
006997000000                MSGID(USR8133) +
006998000000                MSGF(&LIB/&OBJ) +
006999000000                MSG( +
007000000000'1=case-sensitive; 0=nicht case-sensitive'                            +
007001000000                ) +
007002000000                SEV(0) +
007003000000     /*   No replacement variables defined!                         */ +
007004000000                ALROPT(*NO) +
007005000000                CCSID(65535) +
007006000000                /*  -EOF-  */
007007000000
007008000000     /*-------------------------------------------------------------*/
007009000000     /*   Cmd-ADDMSGD für Message-ID :   USR8134                    */
007010000000     /* Operand &1 bei &2 nicht erlaubt.                            */
007011000000     /*-------------------------------------------------------------*/
007012000000
007013000000             RMVMSGD MSGID(USR8134) MSGF(&LIB/&OBJ)
007014000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007015000000
007016000000             ADDMSGD +
007017000000                MSGID(USR8134) +
007018000000                MSGF(&LIB/&OBJ) +
007019000000                MSG( +
007020000000'Operand &1 bei &2 nicht erlaubt.'                                    +
007021000000                ) +
007022000000                SEV(0) +
007023000000                FMT( +
007024000000                    (*CHAR 10) +
007025000000                    (*CHAR 10) +
007026000000                ) +
007027000000                ALROPT(*NO) +
007028000000                CCSID(65535) +
007029000000                /*  -EOF-  */
007030000000
007031000000     /*-------------------------------------------------------------*/
007032000000     /*   Cmd-ADDMSGD für Message-ID :   USR8135                    */
007033000000     /* Operand &1 ist bei Datentyp &2 nicht erlaubt.               */
007034000000     /*-------------------------------------------------------------*/
007035000000
007036000000             RMVMSGD MSGID(USR8135) MSGF(&LIB/&OBJ)
007037000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007038000000
007039000000             ADDMSGD +
007040000000                MSGID(USR8135) +
007041000000                MSGF(&LIB/&OBJ) +
007042000000                MSG( +
007043000000'Operand &1 ist bei Datentyp &2 nicht erlaubt.'                       +
007044000000                ) +
007045000000                SEV(0) +
007046000000                FMT( +
007047000000                    (*CHAR 10) +
007048000000                    (*CHAR 10) +
007049000000                ) +
007050000000                ALROPT(*NO) +
007051000000                CCSID(65535) +
007052000000                /*  -EOF-  */
007053000000
007054000000     /*-------------------------------------------------------------*/
007055000000     /*   Cmd-ADDMSGD für Message-ID :   USR8136                    */
007056000000     /* Feld '&1' nicht gefunden.                                   */
007057000000     /*-------------------------------------------------------------*/
007058000000
007059000000             RMVMSGD MSGID(USR8136) MSGF(&LIB/&OBJ)
007060000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007061000000
007062000000             ADDMSGD +
007063000000                MSGID(USR8136) +
007064000000                MSGF(&LIB/&OBJ) +
007065000000                MSG( +
007066000000'Feld ''&1'' nicht gefunden.'                                         +
007067000000                ) +
007068000000                SECLVL( +
007069000000'&N &B Sonderwerte: &N &P *RECORD - Im ganzen Datensatz suchen, nur mi-
007070000000t EQ/NE möglich.'                                                     +
007071000000                ) +
007072000000                SEV(0) +
007073000000                FMT( +
007074000000                    (*CHAR 10) +
007075000000                ) +
007076000000                ALROPT(*NO) +
007077000000                CCSID(65535) +
007078000000                /*  -EOF-  */
007079000000
007080000000     /*-------------------------------------------------------------*/
007081000000     /*   Cmd-ADDMSGD für Message-ID :   USR8137                    */
007082000000     /* Abrufen der Schlüsselfelder für Datei &1 in Bibliothek &2.  */
007083000000     /*-------------------------------------------------------------*/
007084000000
007085000000             RMVMSGD MSGID(USR8137) MSGF(&LIB/&OBJ)
007086000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007087000000
007088000000             ADDMSGD +
007089000000                MSGID(USR8137) +
007090000000                MSGF(&LIB/&OBJ) +
007091000000                MSG( +
007092000000'Abrufen der Schlüsselfelder für Datei &1 in Bibliothek &2.'          +
007093000000                ) +
007094000000                SEV(0) +
007095000000                FMT( +
007096000000                    (*CHAR 10) +
007097000000                    (*CHAR 10) +
007098000000                ) +
007099000000                ALROPT(*NO) +
007100000000                CCSID(65535) +
007101000000                /*  -EOF-  */
007102000000
007103000000     /*-------------------------------------------------------------*/
007104000000     /*   Cmd-ADDMSGD für Message-ID :   USR8138                    */
007105000000     /* Ungültige numerische Werte im Feld &1 gefunden.             */
007106000000     /*-------------------------------------------------------------*/
007107000000
007108000000             RMVMSGD MSGID(USR8138) MSGF(&LIB/&OBJ)
007109000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007110000000
007111000000             ADDMSGD +
007112000000                MSGID(USR8138) +
007113000000                MSGF(&LIB/&OBJ) +
007114000000                MSG( +
007115000000'Ungültige numerische Werte im Feld &1 gefunden.'                     +
007116000000                ) +
007117000000                SEV(0) +
007118000000                FMT( +
007119000000                    (*CHAR 10) +
007120000000                ) +
007121000000                ALROPT(*NO) +
007122000000                CCSID(65535) +
007123000000                /*  -EOF-  */
007124000000
007125000000     /*-------------------------------------------------------------*/
007126000000     /*   Cmd-ADDMSGD für Message-ID :   USR8139                    */
007127000000     /* Positionierung fehlgeschlagen.                              */
007128000000     /*-------------------------------------------------------------*/
007129000000
007130000000             RMVMSGD MSGID(USR8139) MSGF(&LIB/&OBJ)
007131000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007132000000
007133000000             ADDMSGD +
007134000000                MSGID(USR8139) +
007135000000                MSGF(&LIB/&OBJ) +
007136000000                MSG( +
007137000000'Positionierung fehlgeschlagen.'                                      +
007138000000                ) +
007139000000                SEV(0) +
007140000000     /*   No replacement variables defined!                         */ +
007141000000                ALROPT(*NO) +
007142000000                CCSID(65535) +
007143000000                /*  -EOF-  */
007144000000
007145000000     /*-------------------------------------------------------------*/
007146000000     /*   Cmd-ADDMSGD für Message-ID :   USR8140                    */
007147000000     /* Bitte geben Sie eine Suchargument ein.                      */
007148000000     /*-------------------------------------------------------------*/
007149000000
007150000000             RMVMSGD MSGID(USR8140) MSGF(&LIB/&OBJ)
007151000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007152000000
007153000000             ADDMSGD +
007154000000                MSGID(USR8140) +
007155000000                MSGF(&LIB/&OBJ) +
007156000000                MSG( +
007157000000'Bitte geben Sie eine Suchargument ein.'                              +
007158000000                ) +
007159000000                SEV(0) +
007160000000                FMT( +
007161000000                    (*CHAR 10) +
007162000000                ) +
007163000000                ALROPT(*NO) +
007164000000                CCSID(65535) +
007165000000                /*  -EOF-  */
007166000000
007167000000     /*-------------------------------------------------------------*/
007168000000     /*   Cmd-ADDMSGD für Message-ID :   USR8141                    */
007169000000     /* Nur '&1' für positive und '&2' für negative Zahlen als Vorz */
007170000000     /*-------------------------------------------------------------*/
007171000000
007172000000             RMVMSGD MSGID(USR8141) MSGF(&LIB/&OBJ)
007173000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007174000000
007175000000             ADDMSGD +
007176000000                MSGID(USR8141) +
007177000000                MSGF(&LIB/&OBJ) +
007178000000                MSG( +
007179000000'Nur ''&1'' für positive und ''&2'' für negative Zahlen als Vorzeichen-
007180000000 gültig.'                                                             +
007181000000                ) +
007182000000                SEV(0) +
007183000000                FMT( +
007184000000                    (*CHAR 10) +
007185000000                    (*CHAR 10) +
007186000000                ) +
007187000000                ALROPT(*NO) +
007188000000                CCSID(65535) +
007189000000                /*  -EOF-  */
007190000000
007191000000     /*-------------------------------------------------------------*/
007192000000     /*   Cmd-ADDMSGD für Message-ID :   USR8142                    */
007193000000     /* Die Stelle &1 ist bei numerischen Werten für das Vorzeichen */
007194000000     /*-------------------------------------------------------------*/
007195000000
007196000000             RMVMSGD MSGID(USR8142) MSGF(&LIB/&OBJ)
007197000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007198000000
007199000000             ADDMSGD +
007200000000                MSGID(USR8142) +
007201000000                MSGF(&LIB/&OBJ) +
007202000000                MSG( +
007203000000'Die Stelle &1 ist bei numerischen Werten für das Vorzeichen reservier-
007204000000t.'                                                                   +
007205000000                ) +
007206000000                SEV(0) +
007207000000                FMT( +
007208000000                    (*DEC 10 0) +
007209000000                ) +
007210000000                ALROPT(*NO) +
007211000000                CCSID(65535) +
007212000000                /*  -EOF-  */
007213000000
007214000000     /*-------------------------------------------------------------*/
007215000000     /*   Cmd-ADDMSGD für Message-ID :   USR8143                    */
007216000000     /* Der Taste &1 ist keine Programmfunktion zugeordnet.         */
007217000000     /*-------------------------------------------------------------*/
007218000000
007219000000             RMVMSGD MSGID(USR8143) MSGF(&LIB/&OBJ)
007220000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007221000000
007222000000             ADDMSGD +
007223000000                MSGID(USR8143) +
007224000000                MSGF(&LIB/&OBJ) +
007225000000                MSG( +
007226000000'Der Taste &1 ist keine Programmfunktion zugeordnet.'                 +
007227000000                ) +
007228000000                SEV(0) +
007229000000                FMT( +
007230000000                    (*CHAR 10) +
007231000000                ) +
007232000000                ALROPT(*NO) +
007233000000                CCSID(65535) +
007234000000                /*  -EOF-  */
007235000000
007236000000     /*-------------------------------------------------------------*/
007237000000     /*   Cmd-ADDMSGD für Message-ID :   USR8144                    */
007238000000     /* Rekursive Befehlsausführung für Befehl &1 nicht zulässig.   */
007239000000     /*-------------------------------------------------------------*/
007240000000
007241000000             RMVMSGD MSGID(USR8144) MSGF(&LIB/&OBJ)
007242000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007243000000
007244000000             ADDMSGD +
007245000000                MSGID(USR8144) +
007246000000                MSGF(&LIB/&OBJ) +
007247000000                MSG( +
007248000000'Rekursive Befehlsausführung für Befehl &1 nicht zulässig.'           +
007249000000                ) +
007250000000                SEV(0) +
007251000000                FMT( +
007252000000                    (*CHAR 10) +
007253000000                ) +
007254000000                ALROPT(*NO) +
007255000000                CCSID(65535) +
007256000000                /*  -EOF-  */
007257000000
007258000000     /*-------------------------------------------------------------*/
007259000000     /*   Cmd-ADDMSGD für Message-ID :   USR8145                    */
007260000000     /* Funktion kann bei leerer Subfile nicht ausgeführt werden.   */
007261000000     /*-------------------------------------------------------------*/
007262000000
007263000000             RMVMSGD MSGID(USR8145) MSGF(&LIB/&OBJ)
007264000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007265000000
007266000000             ADDMSGD +
007267000000                MSGID(USR8145) +
007268000000                MSGF(&LIB/&OBJ) +
007269000000                MSG( +
007270000000'Funktion kann bei leerer Subfile nicht ausgeführt werden.'           +
007271000000                ) +
007272000000                SEV(0) +
007273000000     /*   No replacement variables defined!                         */ +
007274000000                ALROPT(*NO) +
007275000000                CCSID(65535) +
007276000000                /*  -EOF-  */
007277000000
007278000000     /*-------------------------------------------------------------*/
007279000000     /*   Cmd-ADDMSGD für Message-ID :   USR8146                    */
007280000000     /* Kein gültiges Feld für Farbauswahl.                         */
007281000000     /*-------------------------------------------------------------*/
007282000000
007283000000             RMVMSGD MSGID(USR8146) MSGF(&LIB/&OBJ)
007284000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007285000000
007286000000             ADDMSGD +
007287000000                MSGID(USR8146) +
007288000000                MSGF(&LIB/&OBJ) +
007289000000                MSG( +
007290000000'Kein gültiges Feld für Farbauswahl.'                                 +
007291000000                ) +
007292000000                SEV(0) +
007293000000     /*   No replacement variables defined!                         */ +
007294000000                ALROPT(*NO) +
007295000000                CCSID(65535) +
007296000000                /*  -EOF-  */
007297000000
007298000000     /*-------------------------------------------------------------*/
007299000000     /*   Cmd-ADDMSGD für Message-ID :   USR8147                    */
007300000000     /* Spalte &1 ist nicht gepinned.                               */
007301000000     /*-------------------------------------------------------------*/
007302000000
007303000000             RMVMSGD MSGID(USR8147) MSGF(&LIB/&OBJ)
007304000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007305000000
007306000000             ADDMSGD +
007307000000                MSGID(USR8147) +
007308000000                MSGF(&LIB/&OBJ) +
007309000000                MSG( +
007310000000'Spalte &1 ist nicht gepinned.'                                       +
007311000000                ) +
007312000000                SEV(0) +
007313000000                FMT( +
007314000000                    (*CHAR 10) +
007315000000                ) +
007316000000                ALROPT(*NO) +
007317000000                CCSID(65535) +
007318000000                /*  -EOF-  */
007319000000
007320000000     /*-------------------------------------------------------------*/
007321000000     /*   Cmd-ADDMSGD für Message-ID :   USR8148                    */
007322000000     /* Kein Platz mehr für Spalte '&1'!                            */
007323000000     /*-------------------------------------------------------------*/
007324000000
007325000000             RMVMSGD MSGID(USR8148) MSGF(&LIB/&OBJ)
007326000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007327000000
007328000000             ADDMSGD +
007329000000                MSGID(USR8148) +
007330000000                MSGF(&LIB/&OBJ) +
007331000000                MSG( +
007332000000'Kein Platz mehr für Spalte ''&1''!'                                  +
007333000000                ) +
007334000000                SEV(0) +
007335000000                FMT( +
007336000000                    (*CHAR 10) +
007337000000                ) +
007338000000                ALROPT(*NO) +
007339000000                CCSID(65535) +
007340000000                /*  -EOF-  */
007341000000
007342000000     /*-------------------------------------------------------------*/
007343000000     /*   Cmd-ADDMSGD für Message-ID :   USR8149                    */
007344000000     /* Tabellierpapier ist bereits eingeschaltet.                  */
007345000000     /*-------------------------------------------------------------*/
007346000000
007347000000             RMVMSGD MSGID(USR8149) MSGF(&LIB/&OBJ)
007348000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007349000000
007350000000             ADDMSGD +
007351000000                MSGID(USR8149) +
007352000000                MSGF(&LIB/&OBJ) +
007353000000                MSG( +
007354000000'Tabellierpapier ist bereits eingeschaltet.'                          +
007355000000                ) +
007356000000                SEV(0) +
007357000000     /*   No replacement variables defined!                         */ +
007358000000                ALROPT(*NO) +
007359000000                CCSID(65535) +
007360000000                /*  -EOF-  */
007361000000
007362000000     /*-------------------------------------------------------------*/
007363000000     /*   Cmd-ADDMSGD für Message-ID :   USR8150                    */
007364000000     /* Tabellierpapier ist bereits ausgeschaltet.                  */
007365000000     /*-------------------------------------------------------------*/
007366000000
007367000000             RMVMSGD MSGID(USR8150) MSGF(&LIB/&OBJ)
007368000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007369000000
007370000000             ADDMSGD +
007371000000                MSGID(USR8150) +
007372000000                MSGF(&LIB/&OBJ) +
007373000000                MSG( +
007374000000'Tabellierpapier ist bereits ausgeschaltet.'                          +
007375000000                ) +
007376000000                SEV(0) +
007377000000     /*   No replacement variables defined!                         */ +
007378000000                ALROPT(*NO) +
007379000000                CCSID(65535) +
007380000000                /*  -EOF-  */
007381000000
007382000000     /*-------------------------------------------------------------*/
007383000000     /*   Cmd-ADDMSGD für Message-ID :   USR8151                    */
007384000000     /* Ungültige Name '&1' für Zieldatei.                          */
007385000000     /*-------------------------------------------------------------*/
007386000000
007387000000             RMVMSGD MSGID(USR8151) MSGF(&LIB/&OBJ)
007388000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007389000000
007390000000             ADDMSGD +
007391000000                MSGID(USR8151) +
007392000000                MSGF(&LIB/&OBJ) +
007393000000                MSG( +
007394000000'Ungültige Name ''&1'' für Zieldatei.'                                +
007395000000                ) +
007396000000                SEV(0) +
007397000000                FMT( +
007398000000                    (*CHAR 10) +
007399000000                ) +
007400000000                ALROPT(*NO) +
007401000000                CCSID(65535) +
007402000000                /*  -EOF-  */
007403000000
007404000000     /*-------------------------------------------------------------*/
007405000000     /*   Cmd-ADDMSGD für Message-ID :   USR8152                    */
007406000000     /* Ungültige Bibliothek '&1' für Zieldatei.                    */
007407000000     /*-------------------------------------------------------------*/
007408000000
007409000000             RMVMSGD MSGID(USR8152) MSGF(&LIB/&OBJ)
007410000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007411000000
007412000000             ADDMSGD +
007413000000                MSGID(USR8152) +
007414000000                MSGF(&LIB/&OBJ) +
007415000000                MSG( +
007416000000'Ungültige Bibliothek ''&1'' für Zieldatei.'                          +
007417000000                ) +
007418000000                SEV(0) +
007419000000                FMT( +
007420000000                    (*CHAR 10) +
007421000000                ) +
007422000000                ALROPT(*NO) +
007423000000                CCSID(65535) +
007424000000                /*  -EOF-  */
007425000000
007426000000     /*-------------------------------------------------------------*/
007427000000     /*   Cmd-ADDMSGD für Message-ID :   USR8153                    */
007428000000     /* Ungültige Teildatei '&1' für Zieldatei.                     */
007429000000     /*-------------------------------------------------------------*/
007430000000
007431000000             RMVMSGD MSGID(USR8153) MSGF(&LIB/&OBJ)
007432000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007433000000
007434000000             ADDMSGD +
007435000000                MSGID(USR8153) +
007436000000                MSGF(&LIB/&OBJ) +
007437000000                MSG( +
007438000000'Ungültige Teildatei ''&1'' für Zieldatei.'                           +
007439000000                ) +
007440000000                SEV(0) +
007441000000                FMT( +
007442000000                    (*CHAR 10) +
007443000000                ) +
007444000000                ALROPT(*NO) +
007445000000                CCSID(65535) +
007446000000                /*  -EOF-  */
007447000000
007448000000     /*-------------------------------------------------------------*/
007449000000     /*   Cmd-ADDMSGD für Message-ID :   USR8154                    */
007450000000     /* Ungültiger Parameter für ERSETZEN/HINZUFÜGEN '&1' für Zield */
007451000000     /*-------------------------------------------------------------*/
007452000000
007453000000             RMVMSGD MSGID(USR8154) MSGF(&LIB/&OBJ)
007454000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007455000000
007456000000             ADDMSGD +
007457000000                MSGID(USR8154) +
007458000000                MSGF(&LIB/&OBJ) +
007459000000                MSG( +
007460000000'Ungültiger Parameter für ERSETZEN/HINZUFÜGEN ''&1'' für Zieldatei.'  +
007461000000                ) +
007462000000                SEV(0) +
007463000000                FMT( +
007464000000                    (*CHAR 10) +
007465000000                ) +
007466000000                ALROPT(*NO) +
007467000000                CCSID(65535) +
007468000000                /*  -EOF-  */
007469000000
007470000000     /*-------------------------------------------------------------*/
007471000000     /*   Cmd-ADDMSGD für Message-ID :   USR8155                    */
007472000000     /* Ungültiger Parameter für DATEI ERSTELLEN '&1' für Zieldatei */
007473000000     /*-------------------------------------------------------------*/
007474000000
007475000000             RMVMSGD MSGID(USR8155) MSGF(&LIB/&OBJ)
007476000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007477000000
007478000000             ADDMSGD +
007479000000                MSGID(USR8155) +
007480000000                MSGF(&LIB/&OBJ) +
007481000000                MSG( +
007482000000'Ungültiger Parameter für DATEI ERSTELLEN ''&1'' für Zieldatei.'      +
007483000000                ) +
007484000000                SEV(0) +
007485000000                FMT( +
007486000000                    (*CHAR 10) +
007487000000                ) +
007488000000                ALROPT(*NO) +
007489000000                CCSID(65535) +
007490000000                /*  -EOF-  */
007491000000
007492000000     /*-------------------------------------------------------------*/
007493000000     /*   Cmd-ADDMSGD für Message-ID :   USR8156                    */
007494000000     /* Verarbeitung fehlerhaft beendet.                            */
007495000000     /*-------------------------------------------------------------*/
007496000000
007497000000             RMVMSGD MSGID(USR8156) MSGF(&LIB/&OBJ)
007498000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007499000000
007500000000             ADDMSGD +
007501000000                MSGID(USR8156) +
007502000000                MSGF(&LIB/&OBJ) +
007503000000                MSG( +
007504000000'Verarbeitung fehlerhaft beendet.'                                    +
007505000000                ) +
007506000000                SEV(0) +
007507000000     /*   No replacement variables defined!                         */ +
007508000000                ALROPT(*NO) +
007509000000                CCSID(65535) +
007510000000                /*  -EOF-  */
007511000000
007512000000     /*-------------------------------------------------------------*/
007513000000     /*   Cmd-ADDMSGD für Message-ID :   USR8157                    */
007514000000     /* Abrufen von Systemwerten.                                   */
007515000000     /*-------------------------------------------------------------*/
007516000000
007517000000             RMVMSGD MSGID(USR8157) MSGF(&LIB/&OBJ)
007518000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007519000000
007520000000             ADDMSGD +
007521000000                MSGID(USR8157) +
007522000000                MSGF(&LIB/&OBJ) +
007523000000                MSG( +
007524000000'Abrufen von Systemwerten.'                                           +
007525000000                ) +
007526000000                SEV(0) +
007527000000     /*   No replacement variables defined!                         */ +
007528000000                ALROPT(*NO) +
007529000000                CCSID(65535) +
007530000000                /*  -EOF-  */
007531000000
007532000000     /*-------------------------------------------------------------*/
007533000000     /*   Cmd-ADDMSGD für Message-ID :   USR8158                    */
007534000000     /* Ungültige Lizenznummer '&1' eingetragen.                    */
007535000000     /*-------------------------------------------------------------*/
007536000000
007537000000             RMVMSGD MSGID(USR8158) MSGF(&LIB/&OBJ)
007538000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007539000000
007540000000             ADDMSGD +
007541000000                MSGID(USR8158) +
007542000000                MSGF(&LIB/&OBJ) +
007543000000                MSG( +
007544000000'Ungültige Lizenznummer ''&1'' eingetragen.'                          +
007545000000                ) +
007546000000                SEV(0) +
007547000000                FMT( +
007548000000                    (*CHAR 20) +
007549000000                ) +
007550000000                ALROPT(*NO) +
007551000000                CCSID(65535) +
007552000000                /*  -EOF-  */
007553000000
007554000000     /*-------------------------------------------------------------*/
007555000000     /*   Cmd-ADDMSGD für Message-ID :   USR8159                    */
007556000000     /* Lizenzdaten konnten nicht gesichert werden.                 */
007557000000     /*-------------------------------------------------------------*/
007558000000
007559000000             RMVMSGD MSGID(USR8159) MSGF(&LIB/&OBJ)
007560000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007561000000
007562000000             ADDMSGD +
007563000000                MSGID(USR8159) +
007564000000                MSGF(&LIB/&OBJ) +
007565000000                MSG( +
007566000000'Lizenzdaten konnten nicht gesichert werden.'                         +
007567000000                ) +
007568000000                SEV(0) +
007569000000     /*   No replacement variables defined!                         */ +
007570000000                ALROPT(*NO) +
007571000000                CCSID(65535) +
007572000000                /*  -EOF-  */
007573000000
007574000000     /*-------------------------------------------------------------*/
007575000000     /*   Cmd-ADDMSGD für Message-ID :   USR8160                    */
007576000000     /* Srachendefinition für Sprache &1 nicht verfügbar.           */
007577000000     /*-------------------------------------------------------------*/
007578000000
007579000000             RMVMSGD MSGID(USR8160) MSGF(&LIB/&OBJ)
007580000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007581000000
007582000000             ADDMSGD +
007583000000                MSGID(USR8160) +
007584000000                MSGF(&LIB/&OBJ) +
007585000000                MSG( +
007586000000'Srachendefinition für Sprache &1 nicht verfügbar.'                   +
007587000000                ) +
007588000000                SEV(0) +
007589000000                FMT( +
007590000000                    (*CHAR 10) +
007591000000                ) +
007592000000                ALROPT(*NO) +
007593000000                CCSID(65535) +
007594000000                /*  -EOF-  */
007595000000
007596000000     /*-------------------------------------------------------------*/
007597000000     /*   Cmd-ADDMSGD für Message-ID :   USR8161                    */
007598000000     /* SPLASH-Screen eingeschaltet.                                */
007599000000     /*-------------------------------------------------------------*/
007600000000
007601000000             RMVMSGD MSGID(USR8161) MSGF(&LIB/&OBJ)
007602000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007603000000
007604000000             ADDMSGD +
007605000000                MSGID(USR8161) +
007606000000                MSGF(&LIB/&OBJ) +
007607000000                MSG( +
007608000000'SPLASH-Screen eingeschaltet.'                                        +
007609000000                ) +
007610000000                SEV(0) +
007611000000     /*   No replacement variables defined!                         */ +
007612000000                ALROPT(*NO) +
007613000000                CCSID(65535) +
007614000000                /*  -EOF-  */
007615000000
007616000000     /*-------------------------------------------------------------*/
007617000000     /*   Cmd-ADDMSGD für Message-ID :   USR8162                    */
007618000000     /* SPLASH-Screen ausgeschaltet.                                */
007619000000     /*-------------------------------------------------------------*/
007620000000
007621000000             RMVMSGD MSGID(USR8162) MSGF(&LIB/&OBJ)
007622000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007623000000
007624000000             ADDMSGD +
007625000000                MSGID(USR8162) +
007626000000                MSGF(&LIB/&OBJ) +
007627000000                MSG( +
007628000000'SPLASH-Screen ausgeschaltet.'                                        +
007629000000                ) +
007630000000                SEV(0) +
007631000000     /*   No replacement variables defined!                         */ +
007632000000                ALROPT(*NO) +
007633000000                CCSID(65535) +
007634000000                /*  -EOF-  */
007635000000
007636000000     /*-------------------------------------------------------------*/
007637000000     /*   Cmd-ADDMSGD für Message-ID :   USR8163                    */
007638000000     /* Zeichenkette enthält nicht darstellbare Zeichen. Ersetzungs */
007639000000     /*-------------------------------------------------------------*/
007640000000
007641000000             RMVMSGD MSGID(USR8163) MSGF(&LIB/&OBJ)
007642000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007643000000
007644000000             ADDMSGD +
007645000000                MSGID(USR8163) +
007646000000                MSGF(&LIB/&OBJ) +
007647000000                MSG( +
007648000000'Zeichenkette enthält nicht darstellbare Zeichen. Ersetzungszeichen: &-
0076490000001'                                                                    +
007650000000                ) +
007651000000                SEV(0) +
007652000000                FMT( +
007653000000                    (*CHAR 1) +
007654000000                ) +
007655000000                ALROPT(*NO) +
007656000000                CCSID(65535) +
007657000000                /*  -EOF-  */
007658000000
007659000000     /*-------------------------------------------------------------*/
007660000000     /*   Cmd-ADDMSGD für Message-ID :   USR8164                    */
007661000000     /* Felder mit nicht darstellbaren Zeichen wurden ausgeblendet. */
007662000000     /*-------------------------------------------------------------*/
007663000000
007664000000             RMVMSGD MSGID(USR8164) MSGF(&LIB/&OBJ)
007665000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007666000000
007667000000             ADDMSGD +
007668000000                MSGID(USR8164) +
007669000000                MSGF(&LIB/&OBJ) +
007670000000                MSG( +
007671000000'Felder mit nicht darstellbaren Zeichen wurden ausgeblendet.'         +
007672000000                ) +
007673000000                SEV(0) +
007674000000     /*   No replacement variables defined!                         */ +
007675000000                ALROPT(*NO) +
007676000000                CCSID(65535) +
007677000000                /*  -EOF-  */
007678000000
007679000000     /*-------------------------------------------------------------*/
007680000000     /*   Cmd-ADDMSGD für Message-ID :   USR8165                    */
007681000000     /* "WIEDERHOLEN" kann erst gedrückt werden, wenn auf dieser Se */
007682000000     /*-------------------------------------------------------------*/
007683000000
007684000000             RMVMSGD MSGID(USR8165) MSGF(&LIB/&OBJ)
007685000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007686000000
007687000000             ADDMSGD +
007688000000                MSGID(USR8165) +
007689000000                MSGF(&LIB/&OBJ) +
007690000000                MSG( +
007691000000'"WIEDERHOLEN" kann erst gedrückt werden, wenn auf dieser Seite eine A-
007692000000uswahl eingegeben wurde.'                                             +
007693000000                ) +
007694000000                SECLVL( +
007695000000'Ursache . . . . . : F13 (Wiederholen) wurde gedrückt, es wurde jedoch-
007696000000 auf dieser Seite keine Funktion zur Wiederholung ausgewählt. &N Fehle-
007697000000rbeseitigung : Eine Auswahl in die Auswahlspalte auf dieser Seite eing-
007698000000eben und "WIEDERHOLEN" ernaut auslösen.'                              +
007699000000                ) +
007700000000                SEV(0) +
007701000000     /*   No replacement variables defined!                         */ +
007702000000                ALROPT(*NO) +
007703000000                CCSID(65535) +
007704000000                /*  -EOF-  */
007705000000
007706000000     /*-------------------------------------------------------------*/
007707000000     /*   Cmd-ADDMSGD für Message-ID :   USR8166                    */
007708000000     /* Funktion nicht möglich. Keine Datei geöffnet!               */
007709000000     /*-------------------------------------------------------------*/
007710000000
007711000000             RMVMSGD MSGID(USR8166) MSGF(&LIB/&OBJ)
007712000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007713000000
007714000000             ADDMSGD +
007715000000                MSGID(USR8166) +
007716000000                MSGF(&LIB/&OBJ) +
007717000000                MSG( +
007718000000'Funktion nicht möglich. Keine Datei geöffnet!'                       +
007719000000                ) +
007720000000                SEV(0) +
007721000000     /*   No replacement variables defined!                         */ +
007722000000                ALROPT(*NO) +
007723000000                CCSID(65535) +
007724000000                /*  -EOF-  */
007725000000
007726000000     /*-------------------------------------------------------------*/
007727000000     /*   Cmd-ADDMSGD für Message-ID :   USR8167                    */
007728000000     /* Identische Folgenummern nicht zulässig.                     */
007729000000     /*-------------------------------------------------------------*/
007730000000
007731000000             RMVMSGD MSGID(USR8167) MSGF(&LIB/&OBJ)
007732000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007733000000
007734000000             ADDMSGD +
007735000000                MSGID(USR8167) +
007736000000                MSGF(&LIB/&OBJ) +
007737000000                MSG( +
007738000000'Identische Folgenummern nicht zulässig.'                             +
007739000000                ) +
007740000000                SEV(0) +
007741000000     /*   No replacement variables defined!                         */ +
007742000000                ALROPT(*NO) +
007743000000                CCSID(65535) +
007744000000                /*  -EOF-  */
007745000000
007746000000     /*-------------------------------------------------------------*/
007747000000     /*   Cmd-ADDMSGD für Message-ID :   USR8168                    */
007748000000     /* Wert &1 für Attribut "Sichtbar/Unsichtbar" nicht zulässig.  */
007749000000     /*-------------------------------------------------------------*/
007750000000
007751000000             RMVMSGD MSGID(USR8168) MSGF(&LIB/&OBJ)
007752000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007753000000
007754000000             ADDMSGD +
007755000000                MSGID(USR8168) +
007756000000                MSGF(&LIB/&OBJ) +
007757000000                MSG( +
007758000000'Wert &1 für Attribut "Sichtbar/Unsichtbar" nicht zulässig.'          +
007759000000                ) +
007760000000                SEV(0) +
007761000000                FMT( +
007762000000                    (*CHAR 10) +
007763000000                ) +
007764000000                ALROPT(*NO) +
007765000000                CCSID(65535) +
007766000000                /*  -EOF-  */
007767000000
007768000000     /*-------------------------------------------------------------*/
007769000000     /*   Cmd-ADDMSGD für Message-ID :   USR8169                    */
007770000000     /* Wert &1 für Attribut "Spaltenmarkierung" nicht zulässig.    */
007771000000     /*-------------------------------------------------------------*/
007772000000
007773000000             RMVMSGD MSGID(USR8169) MSGF(&LIB/&OBJ)
007774000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007775000000
007776000000             ADDMSGD +
007777000000                MSGID(USR8169) +
007778000000                MSGF(&LIB/&OBJ) +
007779000000                MSG( +
007780000000'Wert &1 für Attribut "Spaltenmarkierung" nicht zulässig.'            +
007781000000                ) +
007782000000                SEV(0) +
007783000000                FMT( +
007784000000                    (*CHAR 10) +
007785000000                ) +
007786000000                ALROPT(*NO) +
007787000000                CCSID(65535) +
007788000000                /*  -EOF-  */
007789000000
007790000000     /*-------------------------------------------------------------*/
007791000000     /*   Cmd-ADDMSGD für Message-ID :   USR8170                    */
007792000000     /* Wert &1 für Attribut "Max. Größe" nicht zulässig.           */
007793000000     /*-------------------------------------------------------------*/
007794000000
007795000000             RMVMSGD MSGID(USR8170) MSGF(&LIB/&OBJ)
007796000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007797000000
007798000000             ADDMSGD +
007799000000                MSGID(USR8170) +
007800000000                MSGF(&LIB/&OBJ) +
007801000000                MSG( +
007802000000'Wert &1 für Attribut "Max. Größe" nicht zulässig.'                   +
007803000000                ) +
007804000000                SEV(0) +
007805000000                FMT( +
007806000000                    (*DEC 10 0) +
007807000000                ) +
007808000000                ALROPT(*NO) +
007809000000                CCSID(65535) +
007810000000                /*  -EOF-  */
007811000000
007812000000     /*-------------------------------------------------------------*/
007813000000     /*   Cmd-ADDMSGD für Message-ID :   USR8171                    */
007814000000     /* Ungültiger Wert '&1' für Zeit-, Datum- oder Zeitmarkenfeld  */
007815000000     /*-------------------------------------------------------------*/
007816000000
007817000000             RMVMSGD MSGID(USR8171) MSGF(&LIB/&OBJ)
007818000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007819000000
007820000000             ADDMSGD +
007821000000                MSGID(USR8171) +
007822000000                MSGF(&LIB/&OBJ) +
007823000000                MSG( +
007824000000'Ungültiger Wert ''&1'' für Zeit-, Datum- oder Zeitmarkenfeld'        +
007825000000                ) +
007826000000                SEV(0) +
007827000000                FMT( +
007828000000                    (*CHAR 26) +
007829000000                ) +
007830000000                ALROPT(*NO) +
007831000000                CCSID(65535) +
007832000000                /*  -EOF-  */
007833000000
007834000000     /*-------------------------------------------------------------*/
007835000000     /*   Cmd-ADDMSGD für Message-ID :   USR8172                    */
007836000000     /* Bearbeite: &1                                               */
007837000000     /*-------------------------------------------------------------*/
007838000000
007839000000             RMVMSGD MSGID(USR8172) MSGF(&LIB/&OBJ)
007840000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007841000000
007842000000             ADDMSGD +
007843000000                MSGID(USR8172) +
007844000000                MSGF(&LIB/&OBJ) +
007845000000                MSG( +
007846000000'Bearbeite: &1'                                                       +
007847000000                ) +
007848000000                SEV(0) +
007849000000                FMT( +
007850000000                    (*CHAR 50) +
007851000000                ) +
007852000000                ALROPT(*NO) +
007853000000                CCSID(65535) +
007854000000                /*  -EOF-  */
007855000000
007856000000     /*-------------------------------------------------------------*/
007857000000     /*   Cmd-ADDMSGD für Message-ID :   USR8173                    */
007858000000     /* Peek/400 kann nicht rekursiv aufgerufen werden.             */
007859000000     /*-------------------------------------------------------------*/
007860000000
007861000000             RMVMSGD MSGID(USR8173) MSGF(&LIB/&OBJ)
007862000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007863000000
007864000000             ADDMSGD +
007865000000                MSGID(USR8173) +
007866000000                MSGF(&LIB/&OBJ) +
007867000000                MSG( +
007868000000'Peek/400 kann nicht rekursiv aufgerufen werden.'                     +
007869000000                ) +
007870000000                SEV(0) +
007871000000     /*   No replacement variables defined!                         */ +
007872000000                ALROPT(*NO) +
007873000000                CCSID(65535) +
007874000000                /*  -EOF-  */
007875000000
007876000000     /*-------------------------------------------------------------*/
007877000000     /*   Cmd-ADDMSGD für Message-ID :   USR8174                    */
007878000000     /* Unzulässige Zeichen (&1) im Hex-String.                     */
007879000000     /*-------------------------------------------------------------*/
007880000000
007881000000             RMVMSGD MSGID(USR8174) MSGF(&LIB/&OBJ)
007882000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007883000000
007884000000             ADDMSGD +
007885000000                MSGID(USR8174) +
007886000000                MSGF(&LIB/&OBJ) +
007887000000                MSG( +
007888000000'Unzulässige Zeichen (&1) im Hex-String.'                             +
007889000000                ) +
007890000000                SEV(0) +
007891000000                FMT( +
007892000000                    (*CHAR 1) +
007893000000                ) +
007894000000                ALROPT(*NO) +
007895000000                CCSID(65535) +
007896000000                /*  -EOF-  */
007897000000
007898000000     /*-------------------------------------------------------------*/
007899000000     /*   Cmd-ADDMSGD für Message-ID :   USR8175                    */
007900000000     /* Ungerade Anzahl Zeichen nicht zulässig.                     */
007901000000     /*-------------------------------------------------------------*/
007902000000
007903000000             RMVMSGD MSGID(USR8175) MSGF(&LIB/&OBJ)
007904000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007905000000
007906000000             ADDMSGD +
007907000000                MSGID(USR8175) +
007908000000                MSGF(&LIB/&OBJ) +
007909000000                MSG( +
007910000000'Ungerade Anzahl Zeichen nicht zulässig.'                             +
007911000000                ) +
007912000000                SEV(0) +
007913000000                FMT( +
007914000000                    (*CHAR 1) +
007915000000                ) +
007916000000                ALROPT(*NO) +
007917000000                CCSID(65535) +
007918000000                /*  -EOF-  */
007919000000
007920000000     /*-------------------------------------------------------------*/
007921000000     /*   Cmd-ADDMSGD für Message-ID :   USR8176                    */
007922000000     /* Warnung: Zeichenkette zu lang.                              */
007923000000     /*-------------------------------------------------------------*/
007924000000
007925000000             RMVMSGD MSGID(USR8176) MSGF(&LIB/&OBJ)
007926000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007927000000
007928000000             ADDMSGD +
007929000000                MSGID(USR8176) +
007930000000                MSGF(&LIB/&OBJ) +
007931000000                MSG( +
007932000000'Warnung: Zeichenkette zu lang.'                                      +
007933000000                ) +
007934000000                SEV(0) +
007935000000                FMT( +
007936000000                    (*CHAR 1) +
007937000000                ) +
007938000000                ALROPT(*NO) +
007939000000                CCSID(65535) +
007940000000                /*  -EOF-  */
007941000000
007942000000     /*-------------------------------------------------------------*/
007943000000     /*   Cmd-ADDMSGD für Message-ID :   USR8177                    */
007944000000     /* Startposition darf nicht größer als Feldlänge sein.         */
007945000000     /*-------------------------------------------------------------*/
007946000000
007947000000             RMVMSGD MSGID(USR8177) MSGF(&LIB/&OBJ)
007948000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007949000000
007950000000             ADDMSGD +
007951000000                MSGID(USR8177) +
007952000000                MSGF(&LIB/&OBJ) +
007953000000                MSG( +
007954000000'Startposition darf nicht größer als Feldlänge sein.'                 +
007955000000                ) +
007956000000                SEV(0) +
007957000000                FMT( +
007958000000                    (*CHAR 1) +
007959000000                ) +
007960000000                ALROPT(*NO) +
007961000000                CCSID(65535) +
007962000000                /*  -EOF-  */
007963000000
007964000000     /*-------------------------------------------------------------*/
007965000000     /*   Cmd-ADDMSGD für Message-ID :   USR8178                    */
007966000000     /* Startposition darf nicht kleiner/gleich Null sein.          */
007967000000     /*-------------------------------------------------------------*/
007968000000
007969000000             RMVMSGD MSGID(USR8178) MSGF(&LIB/&OBJ)
007970000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007971000000
007972000000             ADDMSGD +
007973000000                MSGID(USR8178) +
007974000000                MSGF(&LIB/&OBJ) +
007975000000                MSG( +
007976000000'Startposition darf nicht kleiner/gleich Null sein.'                  +
007977000000                ) +
007978000000                SEV(0) +
007979000000     /*   No replacement variables defined!                         */ +
007980000000                ALROPT(*NO) +
007981000000                CCSID(65535) +
007982000000                /*  -EOF-  */
007983000000
007984000000     /*-------------------------------------------------------------*/
007985000000     /*   Cmd-ADDMSGD für Message-ID :   USR8179                    */
007986000000     /* Keine Bedienerführung verfügbar.                            */
007987000000     /*-------------------------------------------------------------*/
007988000000
007989000000             RMVMSGD MSGID(USR8179) MSGF(&LIB/&OBJ)
007990000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007991000000
007992000000             ADDMSGD +
007993000000                MSGID(USR8179) +
007994000000                MSGF(&LIB/&OBJ) +
007995000000                MSG( +
007996000000'Keine Bedienerführung verfügbar.'                                    +
007997000000                ) +
007998000000                SEV(0) +
007999000000     /*   No replacement variables defined!                         */ +
008000000000                ALROPT(*NO) +
008001000000                CCSID(65535) +
008002000000                /*  -EOF-  */
008003000000
008004000000     /*-------------------------------------------------------------*/
008005000000     /*   Cmd-ADDMSGD für Message-ID :   USR8180                    */
008006000000     /* Teildatei '&1' nicht gefunden.                              */
008007000000     /*-------------------------------------------------------------*/
008008000000
008009000000             RMVMSGD MSGID(USR8180) MSGF(&LIB/&OBJ)
008010000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008011000000
008012000000             ADDMSGD +
008013000000                MSGID(USR8180) +
008014000000                MSGF(&LIB/&OBJ) +
008015000000                MSG( +
008016000000'Teildatei ''&1'' nicht gefunden.'                                    +
008017000000                ) +
008018000000                SEV(0) +
008019000000                FMT( +
008020000000                    (*CHAR 10) +
008021000000                ) +
008022000000                ALROPT(*NO) +
008023000000                CCSID(65535) +
008024000000                /*  -EOF-  */
008025000000
008026000000     /*-------------------------------------------------------------*/
008027000000     /*   Cmd-ADDMSGD für Message-ID :   USR8181                    */
008028000000     /* Keine Datei zur Speicherung der Arbeitsumgebung angegeben.  */
008029000000     /*-------------------------------------------------------------*/
008030000000
008031000000             RMVMSGD MSGID(USR8181) MSGF(&LIB/&OBJ)
008032000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008033000000
008034000000             ADDMSGD +
008035000000                MSGID(USR8181) +
008036000000                MSGF(&LIB/&OBJ) +
008037000000                MSG( +
008038000000'Keine Datei zur Speicherung der Arbeitsumgebung angegeben.'          +
008039000000                ) +
008040000000                SEV(0) +
008041000000     /*   No replacement variables defined!                         */ +
008042000000                ALROPT(*NO) +
008043000000                CCSID(65535) +
008044000000                /*  -EOF-  */
008045000000
008046000000     /*-------------------------------------------------------------*/
008047000000     /*   Cmd-ADDMSGD für Message-ID :   USR8182                    */
008048000000     /* Wert &1 als Name für ein AS/400 Objekt ungültig.            */
008049000000     /*-------------------------------------------------------------*/
008050000000
008051000000             RMVMSGD MSGID(USR8182) MSGF(&LIB/&OBJ)
008052000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008053000000
008054000000             ADDMSGD +
008055000000                MSGID(USR8182) +
008056000000                MSGF(&LIB/&OBJ) +
008057000000                MSG( +
008058000000'Wert &1 als Name für ein AS/400 Objekt ungültig.'                    +
008059000000                ) +
008060000000                SEV(0) +
008061000000                FMT( +
008062000000                    (*CHAR 10) +
008063000000                ) +
008064000000                ALROPT(*NO) +
008065000000                CCSID(65535) +
008066000000                /*  -EOF-  */
008067000000
008068000000     /*-------------------------------------------------------------*/
008069000000     /*   Cmd-ADDMSGD für Message-ID :   USR8183                    */
008070000000     /* Unvollständige Auswahl.                                     */
008071000000     /*-------------------------------------------------------------*/
008072000000
008073000000             RMVMSGD MSGID(USR8183) MSGF(&LIB/&OBJ)
008074000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008075000000
008076000000             ADDMSGD +
008077000000                MSGID(USR8183) +
008078000000                MSGF(&LIB/&OBJ) +
008079000000                MSG( +
008080000000'Unvollständige Auswahl.'                                             +
008081000000                ) +
008082000000                SEV(0) +
008083000000     /*   No replacement variables defined!                         */ +
008084000000                ALROPT(*NO) +
008085000000                CCSID(65535) +
008086000000                /*  -EOF-  */
008087000000
008088000000     /*-------------------------------------------------------------*/
008089000000     /*   Cmd-ADDMSGD für Message-ID :   USR8184                    */
008090000000     /* Diese Funktion ist nicht freigeschaltet. Bitte wenden Sie s */
008091000000     /*-------------------------------------------------------------*/
008092000000
008093000000             RMVMSGD MSGID(USR8184) MSGF(&LIB/&OBJ)
008094000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008095000000
008096000000             ADDMSGD +
008097000000                MSGID(USR8184) +
008098000000                MSGF(&LIB/&OBJ) +
008099000000                MSG( +
008100000000'Diese Funktion ist nicht freigeschaltet. Bitte wenden Sie sich an Ihr-
008101000000en Administrator.'                                                    +
008102000000                ) +
008103000000                SEV(0) +
008104000000     /*   No replacement variables defined!                         */ +
008105000000                ALROPT(*NO) +
008106000000                CCSID(65535) +
008107000000                /*  -EOF-  */
008108000000
008109000000     /*-------------------------------------------------------------*/
008110000000     /*   Cmd-ADDMSGD für Message-ID :   USR8185                    */
008111000000     /* Keine Arbeitsumgebung angegeben. Arbeitsumgebung nicht geöf */
008112000000     /*-------------------------------------------------------------*/
008113000000
008114000000             RMVMSGD MSGID(USR8185) MSGF(&LIB/&OBJ)
008115000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008116000000
008117000000             ADDMSGD +
008118000000                MSGID(USR8185) +
008119000000                MSGF(&LIB/&OBJ) +
008120000000                MSG( +
008121000000'Keine Arbeitsumgebung angegeben. Arbeitsumgebung nicht geöffnet.'    +
008122000000                ) +
008123000000                SEV(0) +
008124000000     /*   No replacement variables defined!                         */ +
008125000000                ALROPT(*NO) +
008126000000                CCSID(65535) +
008127000000                /*  -EOF-  */
008128000000
008129000000     /*-------------------------------------------------------------*/
008130000000     /*   Cmd-ADDMSGD für Message-ID :   USR8186                    */
008131000000     /* Warnung: Zeichenkette zu kurz.                              */
008132000000     /*-------------------------------------------------------------*/
008133000000
008134000000             RMVMSGD MSGID(USR8186) MSGF(&LIB/&OBJ)
008135000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008136000000
008137000000             ADDMSGD +
008138000000                MSGID(USR8186) +
008139000000                MSGF(&LIB/&OBJ) +
008140000000                MSG( +
008141000000'Warnung: Zeichenkette zu kurz.'                                      +
008142000000                ) +
008143000000                SEV(0) +
008144000000     /*   No replacement variables defined!                         */ +
008145000000                ALROPT(*NO) +
008146000000                CCSID(65535) +
008147000000                /*  -EOF-  */
008148000000
008149000000     /*-------------------------------------------------------------*/
008150000000     /*   Cmd-ADDMSGD für Message-ID :   USR8187                    */
008151000000     /* Feldlänge ist größer als Dateipuffer.                       */
008152000000     /*-------------------------------------------------------------*/
008153000000
008154000000             RMVMSGD MSGID(USR8187) MSGF(&LIB/&OBJ)
008155000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008156000000
008157000000             ADDMSGD +
008158000000                MSGID(USR8187) +
008159000000                MSGF(&LIB/&OBJ) +
008160000000                MSG( +
008161000000'Feldlänge ist größer als Dateipuffer.'                               +
008162000000                ) +
008163000000                SEV(0) +
008164000000     /*   No replacement variables defined!                         */ +
008165000000                ALROPT(*NO) +
008166000000                CCSID(65535) +
008167000000                /*  -EOF-  */
008168000000
008169000000     /*-------------------------------------------------------------*/
008170000000     /*   Cmd-ADDMSGD für Message-ID :   USR8188                    */
008171000000     /* Generieren Bildschirmdatei. Lauf: &1, Feld: &2              */
008172000000     /*-------------------------------------------------------------*/
008173000000
008174000000             RMVMSGD MSGID(USR8188) MSGF(&LIB/&OBJ)
008175000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008176000000
008177000000             ADDMSGD +
008178000000                MSGID(USR8188) +
008179000000                MSGF(&LIB/&OBJ) +
008180000000                MSG( +
008181000000'Generieren Bildschirmdatei. Lauf: &1, Feld: &2'                      +
008182000000                ) +
008183000000                SEV(0) +
008184000000                FMT( +
008185000000                    (*DEC 5 0) +
008186000000                    (*CHAR 10) +
008187000000                ) +
008188000000                ALROPT(*NO) +
008189000000                CCSID(65535) +
008190000000                /*  -EOF-  */
008191000000
008192000000     /*-------------------------------------------------------------*/
008193000000     /*   Cmd-ADDMSGD für Message-ID :   USR8189                    */
008194000000     /* Generieren RPG-Programm. Lauf: &1, Feld: &2                 */
008195000000     /*-------------------------------------------------------------*/
008196000000
008197000000             RMVMSGD MSGID(USR8189) MSGF(&LIB/&OBJ)
008198000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008199000000
008200000000             ADDMSGD +
008201000000                MSGID(USR8189) +
008202000000                MSGF(&LIB/&OBJ) +
008203000000                MSG( +
008204000000'Generieren RPG-Programm. Lauf: &1, Feld: &2'                         +
008205000000                ) +
008206000000                SEV(0) +
008207000000                FMT( +
008208000000                    (*DEC 5 0) +
008209000000                    (*CHAR 10) +
008210000000                ) +
008211000000                ALROPT(*NO) +
008212000000                CCSID(65535) +
008213000000                /*  -EOF-  */
008214000000
008215000000     /*-------------------------------------------------------------*/
008216000000     /*   Cmd-ADDMSGD für Message-ID :   USR8190                    */
008217000000     /* Verarbeitung beendet mit &1.                                */
008218000000     /*-------------------------------------------------------------*/
008219000000
008220000000             RMVMSGD MSGID(USR8190) MSGF(&LIB/&OBJ)
008221000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008222000000
008223000000             ADDMSGD +
008224000000                MSGID(USR8190) +
008225000000                MSGF(&LIB/&OBJ) +
008226000000                MSG( +
008227000000'Verarbeitung beendet mit &1.'                                        +
008228000000                ) +
008229000000                SEV(0) +
008230000000                FMT( +
008231000000                    (*CHAR 10) +
008232000000                ) +
008233000000                ALROPT(*NO) +
008234000000                CCSID(65535) +
008235000000                /*  -EOF-  */
008236000000
008237000000     /*-------------------------------------------------------------*/
008238000000     /*   Cmd-ADDMSGD für Message-ID :   USR8191                    */
008239000000     /* Feld &1 ist nicht NULL-fähig.                               */
008240000000     /*-------------------------------------------------------------*/
008241000000
008242000000             RMVMSGD MSGID(USR8191) MSGF(&LIB/&OBJ)
008243000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008244000000
008245000000             ADDMSGD +
008246000000                MSGID(USR8191) +
008247000000                MSGF(&LIB/&OBJ) +
008248000000                MSG( +
008249000000'Feld &1 ist nicht NULL-fähig.'                                       +
008250000000                ) +
008251000000                SEV(0) +
008252000000                FMT( +
008253000000                    (*CHAR 10) +
008254000000                ) +
008255000000                ALROPT(*NO) +
008256000000                CCSID(65535) +
008257000000                /*  -EOF-  */
008258000000
008259000000     /*-------------------------------------------------------------*/
008260000000     /*   Cmd-ADDMSGD für Message-ID :   USR8192                    */
008261000000     /* Ungültigen Float Wert in &1 gefunden.                       */
008262000000     /*-------------------------------------------------------------*/
008263000000
008264000000             RMVMSGD MSGID(USR8192) MSGF(&LIB/&OBJ)
008265000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008266000000
008267000000             ADDMSGD +
008268000000                MSGID(USR8192) +
008269000000                MSGF(&LIB/&OBJ) +
008270000000                MSG( +
008271000000'Ungültigen Float Wert in &1 gefunden.'                               +
008272000000                ) +
008273000000                SEV(0) +
008274000000                FMT( +
008275000000                    (*CHAR 10) +
008276000000                ) +
008277000000                ALROPT(*NO) +
008278000000                CCSID(65535) +
008279000000                /*  -EOF-  */
008280000000
008281000000     /*-------------------------------------------------------------*/
008282000000     /*   Cmd-ADDMSGD für Message-ID :   USR8193                    */
008283000000     /* Felder '&1' enthält nicht darstellbaren Zeichen und kann da */
008284000000     /*-------------------------------------------------------------*/
008285000000
008286000000             RMVMSGD MSGID(USR8193) MSGF(&LIB/&OBJ)
008287000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008288000000
008289000000             ADDMSGD +
008290000000                MSGID(USR8193) +
008291000000                MSGF(&LIB/&OBJ) +
008292000000                MSG( +
008293000000'Felder ''&1'' enthält nicht darstellbaren Zeichen und kann daher nich-
008294000000t mit dem Texteditor bearbeitet werden.'                              +
008295000000                ) +
008296000000                SEV(0) +
008297000000                FMT( +
008298000000                    (*CHAR 10) +
008299000000                ) +
008300000000                ALROPT(*NO) +
008301000000                CCSID(65535) +
008302000000                /*  -EOF-  */
008303000000
008304000000     /*-------------------------------------------------------------*/
008305000000     /*   Cmd-ADDMSGD für Message-ID :   USR8194                    */
008306000000     /* Datei '&1' nicht gefunden.                                  */
008307000000     /*-------------------------------------------------------------*/
008308000000
008309000000             RMVMSGD MSGID(USR8194) MSGF(&LIB/&OBJ)
008310000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008311000000
008312000000             ADDMSGD +
008313000000                MSGID(USR8194) +
008314000000                MSGF(&LIB/&OBJ) +
008315000000                MSG( +
008316000000'Datei ''&1'' nicht gefunden.'                                        +
008317000000                ) +
008318000000                SEV(0) +
008319000000                FMT( +
008320000000                    (*CHAR 10) +
008321000000                ) +
008322000000                ALROPT(*NO) +
008323000000                CCSID(65535) +
008324000000                /*  -EOF-  */
008325000000
008326000000     /*-------------------------------------------------------------*/
008327000000     /*   Cmd-ADDMSGD für Message-ID :   USR8195                    */
008328000000     /* Unzulässige Anforderung. Feld ist für Änderungen gesperrt.  */
008329000000     /*-------------------------------------------------------------*/
008330000000
008331000000             RMVMSGD MSGID(USR8195) MSGF(&LIB/&OBJ)
008332000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008333000000
008334000000             ADDMSGD +
008335000000                MSGID(USR8195) +
008336000000                MSGF(&LIB/&OBJ) +
008337000000                MSG( +
008338000000'Unzulässige Anforderung. Feld ist für Änderungen gesperrt.'          +
008339000000                ) +
008340000000                SEV(0) +
008341000000     /*   No replacement variables defined!                         */ +
008342000000                ALROPT(*NO) +
008343000000                CCSID(65535) +
008344000000                /*  -EOF-  */
008345000000
008346000000     /*-------------------------------------------------------------*/
008347000000     /*   Cmd-ADDMSGD für Message-ID :   USR8196                    */
008348000000     /* Feld &1 kann nicht angezeigt und geändert werden.           */
008349000000     /*-------------------------------------------------------------*/
008350000000
008351000000             RMVMSGD MSGID(USR8196) MSGF(&LIB/&OBJ)
008352000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008353000000
008354000000             ADDMSGD +
008355000000                MSGID(USR8196) +
008356000000                MSGF(&LIB/&OBJ) +
008357000000                MSG( +
008358000000'Feld &1 kann nicht angezeigt und geändert werden.'                   +
008359000000                ) +
008360000000                SECLVL( +
008361000000'&N &N Mögliche Ursachen: &N &B 1. Unbekannter Datentyp. &B 2. Datenty-
008362000000p Graphic ohne CCSID. &B 3. Datentyp Packed oder Zoned mit mehr als 30-
008363000000 Stellen. &B 4. Feld variabler Länge mit unbekanntem Datentyp.'       +
008364000000                ) +
008365000000                SEV(0) +
008366000000                FMT( +
008367000000                    (*CHAR 10) +
008368000000                ) +
008369000000                ALROPT(*NO) +
008370000000                CCSID(65535) +
008371000000                /*  -EOF-  */
008372000000
008373000000     /*-------------------------------------------------------------*/
008374000000     /*   Cmd-ADDMSGD für Message-ID :   USR8200                    */
008375000000     /* Datensatz &1 konnte nicht gelöscht werden.                  */
008376000000     /*-------------------------------------------------------------*/
008377000000
008378000000             RMVMSGD MSGID(USR8200) MSGF(&LIB/&OBJ)
008379000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008380000000
008381000000             ADDMSGD +
008382000000                MSGID(USR8200) +
008383000000                MSGF(&LIB/&OBJ) +
008384000000                MSG( +
008385000000'Datensatz &1 konnte nicht gelöscht werden.'                          +
008386000000                ) +
008387000000                SEV(0) +
008388000000                FMT( +
008389000000                    (*DEC 10 0) +
008390000000                ) +
008391000000                ALROPT(*NO) +
008392000000                CCSID(65535) +
008393000000                /*  -EOF-  */
008394000000
008395000000     /*-------------------------------------------------------------*/
008396000000     /*   Cmd-ADDMSGD für Message-ID :   USR8201                    */
008397000000     /* Datensatz &1 wurde gelöscht.                                */
008398000000     /*-------------------------------------------------------------*/
008399000000
008400000000             RMVMSGD MSGID(USR8201) MSGF(&LIB/&OBJ)
008401000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008402000000
008403000000             ADDMSGD +
008404000000                MSGID(USR8201) +
008405000000                MSGF(&LIB/&OBJ) +
008406000000                MSG( +
008407000000'Datensatz &1 wurde gelöscht.'                                        +
008408000000                ) +
008409000000                SEV(0) +
008410000000                FMT( +
008411000000                    (*DEC 10 0) +
008412000000                ) +
008413000000                ALROPT(*NO) +
008414000000                CCSID(65535) +
008415000000                /*  -EOF-  */
008416000000
008417000000     /*-------------------------------------------------------------*/
008418000000     /*   Cmd-ADDMSGD für Message-ID :   USR8202                    */
008419000000     /* Datensatz &1 konnte nicht kopiert werden.                   */
008420000000     /*-------------------------------------------------------------*/
008421000000
008422000000             RMVMSGD MSGID(USR8202) MSGF(&LIB/&OBJ)
008423000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008424000000
008425000000             ADDMSGD +
008426000000                MSGID(USR8202) +
008427000000                MSGF(&LIB/&OBJ) +
008428000000                MSG( +
008429000000'Datensatz &1 konnte nicht kopiert werden.'                           +
008430000000                ) +
008431000000                SEV(0) +
008432000000                FMT( +
008433000000                    (*DEC 10 0) +
008434000000                ) +
008435000000                ALROPT(*NO) +
008436000000                CCSID(65535) +
008437000000                /*  -EOF-  */
008438000000
008439000000     /*-------------------------------------------------------------*/
008440000000     /*   Cmd-ADDMSGD für Message-ID :   USR8203                    */
008441000000     /* Datensatz &1 wurde kopiert.                                 */
008442000000     /*-------------------------------------------------------------*/
008443000000
008444000000             RMVMSGD MSGID(USR8203) MSGF(&LIB/&OBJ)
008445000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008446000000
008447000000             ADDMSGD +
008448000000                MSGID(USR8203) +
008449000000                MSGF(&LIB/&OBJ) +
008450000000                MSG( +
008451000000'Datensatz &1 wurde kopiert.'                                         +
008452000000                ) +
008453000000                SEV(0) +
008454000000                FMT( +
008455000000                    (*DEC 10 0) +
008456000000                ) +
008457000000                ALROPT(*NO) +
008458000000                CCSID(65535) +
008459000000                /*  -EOF-  */
008460000000
008461000000     /*-------------------------------------------------------------*/
008462000000     /*   Cmd-ADDMSGD für Message-ID :   USR8204                    */
008463000000     /* Keine gültige Satzauswahl getroffen.                        */
008464000000     /*-------------------------------------------------------------*/
008465000000
008466000000             RMVMSGD MSGID(USR8204) MSGF(&LIB/&OBJ)
008467000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008468000000
008469000000             ADDMSGD +
008470000000                MSGID(USR8204) +
008471000000                MSGF(&LIB/&OBJ) +
008472000000                MSG( +
008473000000'Keine gültige Satzauswahl getroffen.'                                +
008474000000                ) +
008475000000                SECLVL( +
008476000000'&N &N Zeigen Sie mit dem Cursor auf einen Datensatz der Subfile und w-
008477000000iederholen Sie die Anforderung.'                                      +
008478000000                ) +
008479000000                SEV(0) +
008480000000     /*   No replacement variables defined!                         */ +
008481000000                ALROPT(*NO) +
008482000000                CCSID(65535) +
008483000000                /*  -EOF-  */
008484000000
008485000000     /*-------------------------------------------------------------*/
008486000000     /*   Cmd-ADDMSGD für Message-ID :   USR8205                    */
008487000000     /* Warnung: Es können nicht mehr als &1 Spalten gepinnt werden */
008488000000     /*-------------------------------------------------------------*/
008489000000
008490000000             RMVMSGD MSGID(USR8205) MSGF(&LIB/&OBJ)
008491000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008492000000
008493000000             ADDMSGD +
008494000000                MSGID(USR8205) +
008495000000                MSGF(&LIB/&OBJ) +
008496000000                MSG( +
008497000000'Warnung: Es können nicht mehr als &1 Spalten gepinnt werden!'        +
008498000000                ) +
008499000000                SEV(0) +
008500000000                FMT( +
008501000000                    (*DEC 5 0) +
008502000000                ) +
008503000000                ALROPT(*NO) +
008504000000                CCSID(65535) +
008505000000                /*  -EOF-  */
008506000000
008507000000     /*-------------------------------------------------------------*/
008508000000     /*   Cmd-ADDMSGD für Message-ID :   USR8206                    */
008509000000     /* Anzeige nicht möglich. Die Satzlänge ist größer als &1 Zeic */
008510000000     /*-------------------------------------------------------------*/
008511000000
008512000000             RMVMSGD MSGID(USR8206) MSGF(&LIB/&OBJ)
008513000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008514000000
008515000000             ADDMSGD +
008516000000                MSGID(USR8206) +
008517000000                MSGF(&LIB/&OBJ) +
008518000000                MSG( +
008519000000'Anzeige nicht möglich. Die Satzlänge ist größer als &1 Zeichen.'     +
008520000000                ) +
008521000000                SEV(0) +
008522000000                FMT( +
008523000000                    (*DEC 5 0) +
008524000000                ) +
008525000000                ALROPT(*NO) +
008526000000                CCSID(65535) +
008527000000                /*  -EOF-  */
008528000000
008529000000     /*-------------------------------------------------------------*/
008530000000     /*   Cmd-ADDMSGD für Message-ID :   USR8207                    */
008531000000     /* Datei konnte nicht geöffnet werden. Die Satzlänge ist größe */
008532000000     /*-------------------------------------------------------------*/
008533000000
008534000000             RMVMSGD MSGID(USR8207) MSGF(&LIB/&OBJ)
008535000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008536000000
008537000000             ADDMSGD +
008538000000                MSGID(USR8207) +
008539000000                MSGF(&LIB/&OBJ) +
008540000000                MSG( +
008541000000'Datei konnte nicht geöffnet werden. Die Satzlänge ist größer als &1 Z-
008542000000eichen.'                                                              +
008543000000                ) +
008544000000                SEV(0) +
008545000000                FMT( +
008546000000                    (*DEC 5 0) +
008547000000                ) +
008548000000                ALROPT(*NO) +
008549000000                CCSID(65535) +
008550000000                /*  -EOF-  */
008551000000
008552000000     /*-------------------------------------------------------------*/
008553000000     /*   Cmd-ADDMSGD für Message-ID :   USR8208                    */
008554000000     /* Nur INPUT-Felder können nicht geändert werden.              */
008555000000     /*-------------------------------------------------------------*/
008556000000
008557000000             RMVMSGD MSGID(USR8208) MSGF(&LIB/&OBJ)
008558000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008559000000
008560000000             ADDMSGD +
008561000000                MSGID(USR8208) +
008562000000                MSGF(&LIB/&OBJ) +
008563000000                MSG( +
008564000000'Nur INPUT-Felder können nicht geändert werden.'                      +
008565000000                ) +
008566000000                SEV(0) +
008567000000     /*   No replacement variables defined!                         */ +
008568000000                ALROPT(*NO) +
008569000000                CCSID(65535) +
008570000000                /*  -EOF-  */
008571000000
008572000000     /*-------------------------------------------------------------*/
008573000000     /*   Cmd-ADDMSGD für Message-ID :   USR8209                    */
008574000000     /* Bitte geben Sie in Suchargument ein.                        */
008575000000     /*-------------------------------------------------------------*/
008576000000
008577000000             RMVMSGD MSGID(USR8209) MSGF(&LIB/&OBJ)
008578000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008579000000
008580000000             ADDMSGD +
008581000000                MSGID(USR8209) +
008582000000                MSGF(&LIB/&OBJ) +
008583000000                MSG( +
008584000000'Bitte geben Sie in Suchargument ein.'                                +
008585000000                ) +
008586000000                SEV(0) +
008587000000     /*   No replacement variables defined!                         */ +
008588000000                ALROPT(*NO) +
008589000000                CCSID(65535) +
008590000000                /*  -EOF-  */
008591000000
008592000000     /*-------------------------------------------------------------*/
008593000000     /*   Cmd-ADDMSGD für Message-ID :   USR8210                    */
008594000000     /* SQL-Fehler &1 aufgetreten. &2                               */
008595000000     /*-------------------------------------------------------------*/
008596000000
008597000000             RMVMSGD MSGID(USR8210) MSGF(&LIB/&OBJ)
008598000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008599000000
008600000000             ADDMSGD +
008601000000                MSGID(USR8210) +
008602000000                MSGF(&LIB/&OBJ) +
008603000000                MSG( +
008604000000'SQL-Fehler &1 aufgetreten. &2'                                       +
008605000000                ) +
008606000000                SECLVL( +
008607000000'&N &N Hinweis . . . . :   &2 &N &B Weitere Informationen enthält des -
008608000000SQL Programmierhandbuch oder die Nachrichtendatei QSYS/QSQLMSG.'      +
008609000000                ) +
008610000000                SEV(0) +
008611000000                FMT( +
008612000000                    (*CHAR 7) +
008613000000                    (*CHAR 512) +
008614000000                ) +
008615000000                ALROPT(*NO) +
008616000000                CCSID(65535) +
008617000000                /*  -EOF-  */
008618000000
008619000000     /*-------------------------------------------------------------*/
008620000000     /*   Cmd-ADDMSGD für Message-ID :   USR8211                    */
008621000000     /* Bitte mit dem Cursor auf ein Feld zeigen und die Anforderun */
008622000000     /*-------------------------------------------------------------*/
008623000000
008624000000             RMVMSGD MSGID(USR8211) MSGF(&LIB/&OBJ)
008625000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008626000000
008627000000             ADDMSGD +
008628000000                MSGID(USR8211) +
008629000000                MSGF(&LIB/&OBJ) +
008630000000                MSG( +
008631000000'Bitte mit dem Cursor auf ein Feld zeigen und die Anforderung wiederho-
008632000000len.'                                                                 +
008633000000                ) +
008634000000                SECLVL( +
008635000000'Ursache . . . . :   Der Cursor steht nicht in einem Feld oder das Fel-
008636000000d ist für die Anforderung nicht zulässig.'                            +
008637000000                ) +
008638000000                SEV(0) +
008639000000     /*   No replacement variables defined!                         */ +
008640000000                ALROPT(*NO) +
008641000000                CCSID(65535) +
008642000000                /*  -EOF-  */
008643000000
008644000000     /*-------------------------------------------------------------*/
008645000000     /*   Cmd-ADDMSGD für Message-ID :   USR8212                    */
008646000000     /* Die SQL-Auswahl kann nur auf physischen Dateien angewendet  */
008647000000     /*-------------------------------------------------------------*/
008648000000
008649000000             RMVMSGD MSGID(USR8212) MSGF(&LIB/&OBJ)
008650000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008651000000
008652000000             ADDMSGD +
008653000000                MSGID(USR8212) +
008654000000                MSGF(&LIB/&OBJ) +
008655000000                MSG( +
008656000000'Die SQL-Auswahl kann nur auf physischen Dateien angewendet werden. So-
008657000000ll die physische Datei geöffnet werden?'                              +
008658000000                ) +
008659000000                SEV(0) +
008660000000     /*   No replacement variables defined!                         */ +
008661000000                ALROPT(*NO) +
008662000000                CCSID(65535) +
008663000000                /*  -EOF-  */
008664000000
008665000000     /*-------------------------------------------------------------*/
008666000000     /*   Cmd-ADDMSGD für Message-ID :   USR8213                    */
008667000000     /* 1=speichern; 0=nicht speichern                              */
008668000000     /*-------------------------------------------------------------*/
008669000000
008670000000             RMVMSGD MSGID(USR8213) MSGF(&LIB/&OBJ)
008671000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008672000000
008673000000             ADDMSGD +
008674000000                MSGID(USR8213) +
008675000000                MSGF(&LIB/&OBJ) +
008676000000                MSG( +
008677000000'1=speichern; 0=nicht speichern'                                      +
008678000000                ) +
008679000000                SEV(0) +
008680000000     /*   No replacement variables defined!                         */ +
008681000000                ALROPT(*NO) +
008682000000                CCSID(65535) +
008683000000                /*  -EOF-  */
008684000000
008685000000     /*-------------------------------------------------------------*/
008686000000     /*   Cmd-ADDMSGD für Message-ID :   USR8214                    */
008687000000     /* 1=Kleinbuchstaben erlaubt; 0=nur Großbuchstaben             */
008688000000     /*-------------------------------------------------------------*/
008689000000
008690000000             RMVMSGD MSGID(USR8214) MSGF(&LIB/&OBJ)
008691000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008692000000
008693000000             ADDMSGD +
008694000000                MSGID(USR8214) +
008695000000                MSGF(&LIB/&OBJ) +
008696000000                MSG( +
008697000000'1=Kleinbuchstaben erlaubt; 0=nur Großbuchstaben'                     +
008698000000                ) +
008699000000                SEV(0) +
008700000000     /*   No replacement variables defined!                         */ +
008701000000                ALROPT(*NO) +
008702000000                CCSID(65535) +
008703000000                /*  -EOF-  */
008704000000
008705000000     /*-------------------------------------------------------------*/
008706000000     /*   Cmd-ADDMSGD für Message-ID :   USR8215                    */
008707000000     /* Eingabe in Kleinbuchstaben nicht erlaubt.                   */
008708000000     /*-------------------------------------------------------------*/
008709000000
008710000000             RMVMSGD MSGID(USR8215) MSGF(&LIB/&OBJ)
008711000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008712000000
008713000000             ADDMSGD +
008714000000                MSGID(USR8215) +
008715000000                MSGF(&LIB/&OBJ) +
008716000000                MSG( +
008717000000'Eingabe in Kleinbuchstaben nicht erlaubt.'                           +
008718000000                ) +
008719000000                SEV(0) +
008720000000     /*   No replacement variables defined!                         */ +
008721000000                ALROPT(*NO) +
008722000000                CCSID(65535) +
008723000000                /*  -EOF-  */
008724000000
008725000000     /*-------------------------------------------------------------*/
008726000000     /*   Cmd-ADDMSGD für Message-ID :   USR8216                    */
008727000000     /* Diese Eingabekombination ist nicht erlaubt.                 */
008728000000     /*-------------------------------------------------------------*/
008729000000
008730000000             RMVMSGD MSGID(USR8216) MSGF(&LIB/&OBJ)
008731000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008732000000
008733000000             ADDMSGD +
008734000000                MSGID(USR8216) +
008735000000                MSGF(&LIB/&OBJ) +
008736000000                MSG( +
008737000000'Diese Eingabekombination ist nicht erlaubt.'                         +
008738000000                ) +
008739000000                SECLVL( +
008740000000'Wenn die Eingabe von Kleinbuchstaben nicht erlaubt ist, dann kann die-
008741000000s auch nicht als Standardwert vorbesetzt werden.'                     +
008742000000                ) +
008743000000                SEV(0) +
008744000000     /*   No replacement variables defined!                         */ +
008745000000                ALROPT(*NO) +
008746000000                CCSID(65535) +
008747000000                /*  -EOF-  */
008748000000
008749000000     /*-------------------------------------------------------------*/
008750000000     /*   Cmd-ADDMSGD für Message-ID :   USR8217                    */
008751000000     /* Sortierung nach relativer Satznummer nicht möglich.         */
008752000000     /*-------------------------------------------------------------*/
008753000000
008754000000             RMVMSGD MSGID(USR8217) MSGF(&LIB/&OBJ)
008755000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008756000000
008757000000             ADDMSGD +
008758000000                MSGID(USR8217) +
008759000000                MSGF(&LIB/&OBJ) +
008760000000                MSG( +
008761000000'Sortierung nach relativer Satznummer nicht möglich.'                 +
008762000000                ) +
008763000000                SECLVL( +
008764000000'Eine Sortierung nach relativer Satznummer ist nicht möglich, weil die-
008765000000 geöffnete Datei auf mehrenen Teildateien basiert.'                   +
008766000000                ) +
008767000000                SEV(0) +
008768000000     /*   No replacement variables defined!                         */ +
008769000000                ALROPT(*NO) +
008770000000                CCSID(65535) +
008771000000                /*  -EOF-  */
008772000000
008773000000     /*-------------------------------------------------------------*/
008774000000     /*   Cmd-ADDMSGD für Message-ID :   USR8218                    */
008775000000     /* Datensatz kann nicht gepinnt werden, wenn die logische Date */
008776000000     /*-------------------------------------------------------------*/
008777000000
008778000000             RMVMSGD MSGID(USR8218) MSGF(&LIB/&OBJ)
008779000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008780000000
008781000000             ADDMSGD +
008782000000                MSGID(USR8218) +
008783000000                MSGF(&LIB/&OBJ) +
008784000000                MSG( +
008785000000'Datensatz kann nicht gepinnt werden, wenn die logische Datei auf mehr-
008786000000eren physischen Teildateien basiert.'                                 +
008787000000                ) +
008788000000                SECLVL( +
008789000000'&N &N Ursache . . . . :   Der Datensatz kann nicht gepinnt werden, we-
008790000000il die relative Satznummer nicht eindeutig ist und nicht ermittelt wer-
008791000000den kann, aus welcher physischen Teildatei der Satz kommt.'           +
008792000000                ) +
008793000000                SEV(0) +
008794000000     /*   No replacement variables defined!                         */ +
008795000000                ALROPT(*NO) +
008796000000                CCSID(65535) +
008797000000                /*  -EOF-  */
008798000000
008799000000     /*-------------------------------------------------------------*/
008800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8219                    */
008801000000     /* Wert '&1' für Auswahl Ja/Nein nicht zulässig.               */
008802000000     /*-------------------------------------------------------------*/
008803000000
008804000000             RMVMSGD MSGID(USR8219) MSGF(&LIB/&OBJ)
008805000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008806000000
008807000000             ADDMSGD +
008808000000                MSGID(USR8219) +
008809000000                MSGF(&LIB/&OBJ) +
008810000000                MSG( +
008811000000'Wert ''&1'' für Auswahl Ja/Nein nicht zulässig.'                     +
008812000000                ) +
008813000000                SEV(0) +
008814000000                FMT( +
008815000000                    (*CHAR 1) +
008816000000                ) +
008817000000                ALROPT(*NO) +
008818000000                CCSID(65535) +
008819000000                /*  -EOF-  */
008820000000
008821000000     /*-------------------------------------------------------------*/
008822000000     /*   Cmd-ADDMSGD für Message-ID :   USR8220                    */
008823000000     /* Editor nicht zulässig. Feld &1 enthält NULL Wert.           */
008824000000     /*-------------------------------------------------------------*/
008825000000
008826000000             RMVMSGD MSGID(USR8220) MSGF(&LIB/&OBJ)
008827000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008828000000
008829000000             ADDMSGD +
008830000000                MSGID(USR8220) +
008831000000                MSGF(&LIB/&OBJ) +
008832000000                MSG( +
008833000000'Editor nicht zulässig. Feld &1 enthält NULL Wert.'                   +
008834000000                ) +
008835000000                SEV(0) +
008836000000                FMT( +
008837000000                    (*CHAR 10) +
008838000000                ) +
008839000000                ALROPT(*NO) +
008840000000                CCSID(65535) +
008841000000                /*  -EOF-  */
008842000000
008843000000     /*-------------------------------------------------------------*/
008844000000     /*   Cmd-ADDMSGD für Message-ID :   USR8221                    */
008845000000     /* Editor nicht zulässig. Feld &1 hat ungültigen Datentyp.     */
008846000000     /*-------------------------------------------------------------*/
008847000000
008848000000             RMVMSGD MSGID(USR8221) MSGF(&LIB/&OBJ)
008849000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008850000000
008851000000             ADDMSGD +
008852000000                MSGID(USR8221) +
008853000000                MSGF(&LIB/&OBJ) +
008854000000                MSG( +
008855000000'Editor nicht zulässig. Feld &1 hat ungültigen Datentyp.'             +
008856000000                ) +
008857000000                SEV(0) +
008858000000                FMT( +
008859000000                    (*CHAR 10) +
008860000000                ) +
008861000000                ALROPT(*NO) +
008862000000                CCSID(65535) +
008863000000                /*  -EOF-  */
008864000000
008865000000     /*-------------------------------------------------------------*/
008866000000     /*   Cmd-ADDMSGD für Message-ID :   USR8222                    */
008867000000     /* Feld &1 zu lang für Editor.                                 */
008868000000     /*-------------------------------------------------------------*/
008869000000
008870000000             RMVMSGD MSGID(USR8222) MSGF(&LIB/&OBJ)
008871000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008872000000
008873000000             ADDMSGD +
008874000000                MSGID(USR8222) +
008875000000                MSGF(&LIB/&OBJ) +
008876000000                MSG( +
008877000000'Feld &1 zu lang für Editor.'                                         +
008878000000                ) +
008879000000                SEV(0) +
008880000000                FMT( +
008881000000                    (*CHAR 10) +
008882000000                ) +
008883000000                ALROPT(*NO) +
008884000000                CCSID(65535) +
008885000000                /*  -EOF-  */
008886000000
008887000000     /*-------------------------------------------------------------*/
008888000000     /*   Cmd-ADDMSGD für Message-ID :   USR8223                    */
008889000000     /* Eingabe der Schlüsselfelder auf Kleinbuchstaben geschaltet. */
008890000000     /*-------------------------------------------------------------*/
008891000000
008892000000             RMVMSGD MSGID(USR8223) MSGF(&LIB/&OBJ)
008893000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008894000000
008895000000             ADDMSGD +
008896000000                MSGID(USR8223) +
008897000000                MSGF(&LIB/&OBJ) +
008898000000                MSG( +
008899000000'Eingabe der Schlüsselfelder auf Kleinbuchstaben geschaltet.'         +
008900000000                ) +
008901000000                SEV(0) +
008902000000     /*   No replacement variables defined!                         */ +
008903000000                ALROPT(*NO) +
008904000000                CCSID(65535) +
008905000000                /*  -EOF-  */
008906000000
008907000000     /*-------------------------------------------------------------*/
008908000000     /*   Cmd-ADDMSGD für Message-ID :   USR8224                    */
008909000000     /* Eingabe der Schlüsselfelder auf Grossbuchstaben geschaltet. */
008910000000     /*-------------------------------------------------------------*/
008911000000
008912000000             RMVMSGD MSGID(USR8224) MSGF(&LIB/&OBJ)
008913000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008914000000
008915000000             ADDMSGD +
008916000000                MSGID(USR8224) +
008917000000                MSGF(&LIB/&OBJ) +
008918000000                MSG( +
008919000000'Eingabe der Schlüsselfelder auf Grossbuchstaben geschaltet.'         +
008920000000                ) +
008921000000                SEV(0) +
008922000000     /*   No replacement variables defined!                         */ +
008923000000                ALROPT(*NO) +
008924000000                CCSID(65535) +
008925000000                /*  -EOF-  */
008926000000
008927000000     /*-------------------------------------------------------------*/
008928000000     /*   Cmd-ADDMSGD für Message-ID :   USR8225                    */
008929000000     /* Datensatz wurde zwischenzeitlich von einem anderem Job geän */
008930000000     /*-------------------------------------------------------------*/
008931000000
008932000000             RMVMSGD MSGID(USR8225) MSGF(&LIB/&OBJ)
008933000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008934000000
008935000000             ADDMSGD +
008936000000                MSGID(USR8225) +
008937000000                MSGF(&LIB/&OBJ) +
008938000000                MSG( +
008939000000'Datensatz wurde zwischenzeitlich von einem anderem Job geändert.°°Tro-
008940000000tzdem ändern?'                                                        +
008941000000                ) +
008942000000                SEV(0) +
008943000000     /*   No replacement variables defined!                         */ +
008944000000                ALROPT(*NO) +
008945000000                CCSID(65535) +
008946000000                /*  -EOF-  */
008947000000
008948000000     /*-------------------------------------------------------------*/
008949000000     /*   Cmd-ADDMSGD für Message-ID :   USR8226                    */
008950000000     /* Druckvorgang erfolgreich beendet.                           */
008951000000     /*-------------------------------------------------------------*/
008952000000
008953000000             RMVMSGD MSGID(USR8226) MSGF(&LIB/&OBJ)
008954000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008955000000
008956000000             ADDMSGD +
008957000000                MSGID(USR8226) +
008958000000                MSGF(&LIB/&OBJ) +
008959000000                MSG( +
008960000000'Druckvorgang erfolgreich beendet.'                                   +
008961000000                ) +
008962000000                SEV(0) +
008963000000     /*   No replacement variables defined!                         */ +
008964000000                ALROPT(*NO) +
008965000000                CCSID(65535) +
008966000000                /*  -EOF-  */
008967000000
008968000000     /*-------------------------------------------------------------*/
008969000000     /*   Cmd-ADDMSGD für Message-ID :   USR8227                    */
008970000000     /* Die Zeichenkette '&1' konnte nicht in einen numerischen Wer */
008971000000     /*-------------------------------------------------------------*/
008972000000
008973000000             RMVMSGD MSGID(USR8227) MSGF(&LIB/&OBJ)
008974000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008975000000
008976000000             ADDMSGD +
008977000000                MSGID(USR8227) +
008978000000                MSGF(&LIB/&OBJ) +
008979000000                MSG( +
008980000000'Die Zeichenkette ''&1'' konnte nicht in einen numerischen Wert umgese-
008981000000tzt werden.'                                                          +
008982000000                ) +
008983000000                SECLVL( +
008984000000'&N &N Information . . :   Bei der Umwandlung der Zeichenkette ''&1'' -
008985000000ist ein Fehler aufgetreten. Die Zeichenkette konnte nicht in einen num-
008986000000erischen Wert vom Typ &2(&3,&4) umgesetzt werden.'                    +
008987000000                ) +
008988000000                SEV(0) +
008989000000                FMT( +
008990000000                    (*CHAR 256) +
008991000000                    (*CHAR 1) +
008992000000                    (*DEC 5 0) +
008993000000                    (*DEC 5 0) +
008994000000                ) +
008995000000                ALROPT(*NO) +
008996000000                CCSID(65535) +
008997000000                /*  -EOF-  */
008998000000
008999000000     /*-------------------------------------------------------------*/
009000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8228                    */
009001000000     /* Datentyp '&1' ist ungültig.                                 */
009002000000     /*-------------------------------------------------------------*/
009003000000
009004000000             RMVMSGD MSGID(USR8228) MSGF(&LIB/&OBJ)
009005000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009006000000
009007000000             ADDMSGD +
009008000000                MSGID(USR8228) +
009009000000                MSGF(&LIB/&OBJ) +
009010000000                MSG( +
009011000000'Datentyp ''&1'' ist ungültig.'                                       +
009012000000                ) +
009013000000                SECLVL( +
009014000000'&N &N Information . . :   Der angegebene Datentyp ''&1'' wird nicht u-
009015000000nterstützt. Bitte geben Sie einen gültigen RPG Datentyp an und wiederh-
009016000000olen Sie die Anforderung.'                                            +
009017000000                ) +
009018000000                SEV(0) +
009019000000                FMT( +
009020000000                    (*CHAR 256) +
009021000000                ) +
009022000000                ALROPT(*NO) +
009023000000                CCSID(65535) +
009024000000                /*  -EOF-  */
009025000000
009026000000     /*-------------------------------------------------------------*/
009027000000     /*   Cmd-ADDMSGD für Message-ID :   USR8229                    */
009028000000     /* Wert '&1' für die Feldlänge ist ungültig.                   */
009029000000     /*-------------------------------------------------------------*/
009030000000
009031000000             RMVMSGD MSGID(USR8229) MSGF(&LIB/&OBJ)
009032000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009033000000
009034000000             ADDMSGD +
009035000000                MSGID(USR8229) +
009036000000                MSGF(&LIB/&OBJ) +
009037000000                MSG( +
009038000000'Wert ''&1'' für die Feldlänge ist ungültig.'                         +
009039000000                ) +
009040000000                SECLVL( +
009041000000'&N &N Information . . :   Der angegebene Wert ''&1'' für die Feldläng-
009042000000e ist ungültig. Bitte korrigieren Sie die Feldlänge und wiederholen Si-
009043000000e die Anforderung.'                                                   +
009044000000                ) +
009045000000                SEV(0) +
009046000000                FMT( +
009047000000                    (*CHAR 256) +
009048000000                ) +
009049000000                ALROPT(*NO) +
009050000000                CCSID(65535) +
009051000000                /*  -EOF-  */
009052000000
009053000000     /*-------------------------------------------------------------*/
009054000000     /*   Cmd-ADDMSGD für Message-ID :   USR8230                    */
009055000000     /* Wert '&1' für die Anzahl Nachkommastellen ist ungültig.     */
009056000000     /*-------------------------------------------------------------*/
009057000000
009058000000             RMVMSGD MSGID(USR8230) MSGF(&LIB/&OBJ)
009059000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009060000000
009061000000             ADDMSGD +
009062000000                MSGID(USR8230) +
009063000000                MSGF(&LIB/&OBJ) +
009064000000                MSG( +
009065000000'Wert ''&1'' für die Anzahl Nachkommastellen ist ungültig.'           +
009066000000                ) +
009067000000                SECLVL( +
009068000000'&N &N Information . . :   Der angegebene Wert ''&1'' für die Anzahl N-
009069000000achkommastellen ist ungültig. Bitte korrigieren Sie die Anzahl Nachkom-
009070000000mastellen und wiederholen Sie die Anforderung. Beachten Sie, dass nich-
009071000000t alle Datentypen, z.B. ''A'' für Zeichenketten, Nachkommastellen erfo-
009072000000rdern.'                                                               +
009073000000                ) +
009074000000                SEV(0) +
009075000000                FMT( +
009076000000                    (*CHAR 256) +
009077000000                ) +
009078000000                ALROPT(*NO) +
009079000000                CCSID(65535) +
009080000000                /*  -EOF-  */
009081000000
009082000000     /*-------------------------------------------------------------*/
009083000000     /*   Cmd-ADDMSGD für Message-ID :   USR8231                    */
009084000000     /* Eine Änderung der Satzsperre ist nur im Änderungsmodus mögl */
009085000000     /*-------------------------------------------------------------*/
009086000000
009087000000             RMVMSGD MSGID(USR8231) MSGF(&LIB/&OBJ)
009088000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009089000000
009090000000             ADDMSGD +
009091000000                MSGID(USR8231) +
009092000000                MSGF(&LIB/&OBJ) +
009093000000                MSG( +
009094000000'Eine Änderung der Satzsperre ist nur im Änderungsmodus möglich.'     +
009095000000                ) +
009096000000                SECLVL( +
009097000000'&N &N Information . . :   Die Satzsperre kann nur im Änderungsmodus a-
009098000000ngefordert oder freigegeben werden. Beim Kopieren oder bei der Neuanla-
009099000000ge von Datensätzen ist dies nicht möglich.'                           +
009100000000                ) +
009101000000                SEV(0) +
009102000000     /*   No replacement variables defined!                         */ +
009103000000                ALROPT(*NO) +
009104000000                CCSID(65535) +
009105000000                /*  -EOF-  */
009106000000
009107000000     /*-------------------------------------------------------------*/
009108000000     /*   Cmd-ADDMSGD für Message-ID :   USR8232                    */
009109000000     /* Datensatz wurde zwischenzeitlich von einem anderem Job geän */
009110000000     /*-------------------------------------------------------------*/
009111000000
009112000000             RMVMSGD MSGID(USR8232) MSGF(&LIB/&OBJ)
009113000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009114000000
009115000000             ADDMSGD +
009116000000                MSGID(USR8232) +
009117000000                MSGF(&LIB/&OBJ) +
009118000000                MSG( +
009119000000'Datensatz wurde zwischenzeitlich von einem anderem Job geändert.°°Tro-
009120000000tzdem sperren?'                                                       +
009121000000                ) +
009122000000                SEV(0) +
009123000000     /*   No replacement variables defined!                         */ +
009124000000                ALROPT(*NO) +
009125000000                CCSID(65535) +
009126000000                /*  -EOF-  */
009127000000
009128000000     /*-------------------------------------------------------------*/
009129000000     /*   Cmd-ADDMSGD für Message-ID :   USR8233                    */
009130000000     /* Fehler: Ungültiges Layout aufgrund abweichender Satzformat- */
009131000000     /*-------------------------------------------------------------*/
009132000000
009133000000             RMVMSGD MSGID(USR8233) MSGF(&LIB/&OBJ)
009134000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009135000000
009136000000             ADDMSGD +
009137000000                MSGID(USR8233) +
009138000000                MSGF(&LIB/&OBJ) +
009139000000                MSG( +
009140000000'Fehler: Ungültiges Layout aufgrund abweichender Satzformat-ID.'      +
009141000000                ) +
009142000000                SECLVL( +
009143000000'&N &N Fehlerkorrektur :   Versuchsweise kann der Eintrag *RCDFMTID au-
009144000000s der Datei &2/&1, Teildatei &3 gelöscht werden, um die Prüfung der Sa-
009145000000tzformat_ID ausser Kraft zu setzen. Kann das Layout danach geladen wer-
009146000000den, muss es erneut gespeichert werden, um die Satzformat ID wieder hi-
009147000000nzuzufügen.'                                                          +
009148000000                ) +
009149000000                SEV(0) +
009150000000                FMT( +
009151000000                    (*CHAR 10) +
009152000000                    (*CHAR 10) +
009153000000                    (*CHAR 10) +
009154000000                ) +
009155000000                ALROPT(*NO) +
009156000000                CCSID(65535) +
009157000000                /*  -EOF-  */
009158000000
009159000000     /*-------------------------------------------------------------*/
009160000000     /*   Cmd-ADDMSGD für Message-ID :   USR8234                    */
009161000000     /* Layout konnte aufgrund abweichender Satzformat-IDs nicht ge */
009162000000     /*-------------------------------------------------------------*/
009163000000
009164000000             RMVMSGD MSGID(USR8234) MSGF(&LIB/&OBJ)
009165000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009166000000
009167000000             ADDMSGD +
009168000000                MSGID(USR8234) +
009169000000                MSGF(&LIB/&OBJ) +
009170000000                MSG( +
009171000000'Layout konnte aufgrund abweichender Satzformat-IDs nicht geladen werd-
009172000000en.'                                                                  +
009173000000                ) +
009174000000                SECLVL( +
009175000000'&N &N Ursache . . . . :   Das angegebene Layout konnte nicht geladen -
009176000000werden, weil die im Layout gespeicherte Formatebenen-ID von der Format-
009177000000ebenen-ID der anzuzeigenden Datei abweicht.&N Fehlerkorrektur : Versuc-
009178000000hsweise kann der Eintrag *RCDFMTID aus der Datei &2/&1, Teildatei &3 g-
009179000000elöscht werden, um die Prüfung der Satzformat_ID ausser Kraft zu setze-
009180000000n. Kann das Layout danach geladen werden, muss es erneut gespeichert w-
009181000000erden, um die Satzformat ID wieder hinzuzufügen.'                     +
009182000000                ) +
009183000000                SEV(0) +
009184000000                FMT( +
009185000000                    (*CHAR 10) +
009186000000                    (*CHAR 10) +
009187000000                    (*CHAR 10) +
009188000000                ) +
009189000000                ALROPT(*NO) +
009190000000                CCSID(65535) +
009191000000                /*  -EOF-  */
009192000000
009193000000     /*-------------------------------------------------------------*/
009194000000     /*   Cmd-ADDMSGD für Message-ID :   USR8235                    */
009195000000     /* SQL-Auswahl wird für Multi-Member logische Dateien nicht un */
009196000000     /*-------------------------------------------------------------*/
009197000000
009198000000             RMVMSGD MSGID(USR8235) MSGF(&LIB/&OBJ)
009199000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009200000000
009201000000             ADDMSGD +
009202000000                MSGID(USR8235) +
009203000000                MSGF(&LIB/&OBJ) +
009204000000                MSG( +
009205000000'SQL-Auswahl wird für Multi-Member logische Dateien nicht unterstützt.-
009206000000'                                                                     +
009207000000                ) +
009208000000                SEV(0) +
009209000000     /*   No replacement variables defined!                         */ +
009210000000                ALROPT(*NO) +
009211000000                CCSID(65535) +
009212000000                /*  -EOF-  */
009213000000
009214000000     /*-------------------------------------------------------------*/
009215000000     /*   Cmd-ADDMSGD für Message-ID :   USR8236                    */
009216000000     /* Einfügemodus aktiviert. Positionieren Cursor, dann F7 drück */
009217000000     /*-------------------------------------------------------------*/
009218000000
009219000000             RMVMSGD MSGID(USR8236) MSGF(&LIB/&OBJ)
009220000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009221000000
009222000000             ADDMSGD +
009223000000                MSGID(USR8236) +
009224000000                MSGF(&LIB/&OBJ) +
009225000000                MSG( +
009226000000'Einfügemodus aktiviert. Positionieren Cursor, dann F7 drücken.'      +
009227000000                ) +
009228000000                SEV(0) +
009229000000     /*   No replacement variables defined!                         */ +
009230000000                ALROPT(*NO) +
009231000000                CCSID(65535) +
009232000000                /*  -EOF-  */
009233000000
009234000000     /*-------------------------------------------------------------*/
009235000000     /*   Cmd-ADDMSGD für Message-ID :   USR8237                    */
009236000000     /* Eingabetaste drücken, um die angegebenen Anzahl Leerzeichen */
009237000000     /*-------------------------------------------------------------*/
009238000000
009239000000             RMVMSGD MSGID(USR8237) MSGF(&LIB/&OBJ)
009240000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009241000000
009242000000             ADDMSGD +
009243000000                MSGID(USR8237) +
009244000000                MSGF(&LIB/&OBJ) +
009245000000                MSG( +
009246000000'Eingabetaste drücken, um die angegebenen Anzahl Leerzeichen einzufüge-
009247000000n.'                                                                   +
009248000000                ) +
009249000000                SEV(0) +
009250000000     /*   No replacement variables defined!                         */ +
009251000000                ALROPT(*NO) +
009252000000                CCSID(65535) +
009253000000                /*  -EOF-  */
009254000000
009255000000     /*-------------------------------------------------------------*/
009256000000     /*   Cmd-ADDMSGD für Message-ID :   USR8238                    */
009257000000     /* Löschmodus aktiviert. Positionieren Cursor, dann F8 drücken */
009258000000     /*-------------------------------------------------------------*/
009259000000
009260000000             RMVMSGD MSGID(USR8238) MSGF(&LIB/&OBJ)
009261000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009262000000
009263000000             ADDMSGD +
009264000000                MSGID(USR8238) +
009265000000                MSGF(&LIB/&OBJ) +
009266000000                MSG( +
009267000000'Löschmodus aktiviert. Positionieren Cursor, dann F8 drücken.'        +
009268000000                ) +
009269000000                SEV(0) +
009270000000     /*   No replacement variables defined!                         */ +
009271000000                ALROPT(*NO) +
009272000000                CCSID(65535) +
009273000000                /*  -EOF-  */
009274000000
009275000000     /*-------------------------------------------------------------*/
009276000000     /*   Cmd-ADDMSGD für Message-ID :   USR8239                    */
009277000000     /* Eingabetaste drücken, um den angegebenen Bereich von Zeiche */
009278000000     /*-------------------------------------------------------------*/
009279000000
009280000000             RMVMSGD MSGID(USR8239) MSGF(&LIB/&OBJ)
009281000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009282000000
009283000000             ADDMSGD +
009284000000                MSGID(USR8239) +
009285000000                MSGF(&LIB/&OBJ) +
009286000000                MSG( +
009287000000'Eingabetaste drücken, um den angegebenen Bereich von Zeichen zu lösch-
009288000000en.'                                                                  +
009289000000                ) +
009290000000                SEV(0) +
009291000000     /*   No replacement variables defined!                         */ +
009292000000                ALROPT(*NO) +
009293000000                CCSID(65535) +
009294000000                /*  -EOF-  */
009295000000
009296000000     /*-------------------------------------------------------------*/
009297000000     /*   Cmd-ADDMSGD für Message-ID :   USR8240                    */
009298000000     /* Wert darf nicht kleiner &1 sein.                            */
009299000000     /*-------------------------------------------------------------*/
009300000000
009301000000             RMVMSGD MSGID(USR8240) MSGF(&LIB/&OBJ)
009302000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009303000000
009304000000             ADDMSGD +
009305000000                MSGID(USR8240) +
009306000000                MSGF(&LIB/&OBJ) +
009307000000                MSG( +
009308000000'Wert darf nicht kleiner &1 sein.'                                    +
009309000000                ) +
009310000000                SEV(0) +
009311000000                FMT( +
009312000000                    (*DEC 5 0) +
009313000000                ) +
009314000000                ALROPT(*NO) +
009315000000                CCSID(65535) +
009316000000                /*  -EOF-  */
009317000000
009318000000     /*-------------------------------------------------------------*/
009319000000     /*   Cmd-ADDMSGD für Message-ID :   USR8241                    */
009320000000     /* Feldlänge überschritten. Der Wert ist um &1 Zeichen zu groß */
009321000000     /*-------------------------------------------------------------*/
009322000000
009323000000             RMVMSGD MSGID(USR8241) MSGF(&LIB/&OBJ)
009324000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009325000000
009326000000             ADDMSGD +
009327000000                MSGID(USR8241) +
009328000000                MSGF(&LIB/&OBJ) +
009329000000                MSG( +
009330000000'Feldlänge überschritten. Der Wert ist um &1 Zeichen zu groß.'        +
009331000000                ) +
009332000000                SEV(0) +
009333000000                FMT( +
009334000000                    (*DEC 5 0) +
009335000000                ) +
009336000000                ALROPT(*NO) +
009337000000                CCSID(65535) +
009338000000                /*  -EOF-  */
009339000000
009340000000     /*-------------------------------------------------------------*/
009341000000     /*   Cmd-ADDMSGD für Message-ID :   USR9992                    */
009342000000     /* Benutzereinstellungen konnten nicht gespeichert werden.     */
009343000000     /*-------------------------------------------------------------*/
009344000000
009345000000             RMVMSGD MSGID(USR9992) MSGF(&LIB/&OBJ)
009346000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009347000000
009348000000             ADDMSGD +
009349000000                MSGID(USR9992) +
009350000000                MSGF(&LIB/&OBJ) +
009351000000                MSG( +
009352000000'Benutzereinstellungen konnten nicht gespeichert werden.'             +
009353000000                ) +
009354000000                SECLVL( +
009355000000'&N &N Ursache . . . . :   Die Benutzereinstellungen konnten aufgrund -
009356000000von Ursachencode &1 nicht gespeichert werden. &N &N Die möglichen Ursa-
009357000000chencodes sind: &N &B 1 - Name der Datei (&2) stimmt nicht mit der geö-
009358000000ffneten Datei überein. &B 2 - Name der Bibliothek (&2) stimmt nicht mi-
009359000000t der Bibliothek der geöfneten Datei überein. &B 3 - Datei für Benutze-
009360000000reinstellungen &3/&2 mit Teildatei &4 konnte nicht geöffnet werden.'  +
009361000000                ) +
009362000000                SEV(0) +
009363000000                FMT( +
009364000000                    (*DEC 10 0) +
009365000000                    (*CHAR 10) +
009366000000                    (*CHAR 10) +
009367000000                    (*CHAR 10) +
009368000000                ) +
009369000000                ALROPT(*NO) +
009370000000                CCSID(65535) +
009371000000                /*  -EOF-  */
009372000000
009373000000     /*-------------------------------------------------------------*/
009374000000     /*   Cmd-ADDMSGD für Message-ID :   USR9993                    */
009375000000     /* Keine Datei geöffnet. Der Zugriff über SQL kann nur auf phy */
009376000000     /*-------------------------------------------------------------*/
009377000000
009378000000             RMVMSGD MSGID(USR9993) MSGF(&LIB/&OBJ)
009379000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009380000000
009381000000             ADDMSGD +
009382000000                MSGID(USR9993) +
009383000000                MSGF(&LIB/&OBJ) +
009384000000                MSG( +
009385000000'Keine Datei geöffnet. Der Zugriff über SQL kann nur auf physische Dat-
009386000000eien angewendet werden.'                                              +
009387000000                ) +
009388000000                SEV(0) +
009389000000                FMT( +
009390000000                    (*DEC 5 0) +
009391000000                    (*CHAR 32) +
009392000000                    (*CHAR 256) +
009393000000                ) +
009394000000                ALROPT(*NO) +
009395000000                CCSID(65535) +
009396000000                /*  -EOF-  */
009397000000
009398000000     /*-------------------------------------------------------------*/
009399000000     /*   Cmd-ADDMSGD für Message-ID :   USR9994                    */
009400000000     /* Unerwarteter Fehler &1 in C Funktion &2 aufgetreten.        */
009401000000     /*-------------------------------------------------------------*/
009402000000
009403000000             RMVMSGD MSGID(USR9994) MSGF(&LIB/&OBJ)
009404000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009405000000
009406000000             ADDMSGD +
009407000000                MSGID(USR9994) +
009408000000                MSGF(&LIB/&OBJ) +
009409000000                MSG( +
009410000000'Unerwarteter Fehler &1 in C Funktion &2 aufgetreten.'                +
009411000000                ) +
009412000000                SECLVL( +
009413000000'&N &N Fehlertext  . . :   &3'                                        +
009414000000                ) +
009415000000                SEV(0) +
009416000000                FMT( +
009417000000                    (*DEC 5 0) +
009418000000                    (*CHAR 32) +
009419000000                    (*CHAR 256) +
009420000000                ) +
009421000000                ALROPT(*NO) +
009422000000                CCSID(65535) +
009423000000                /*  -EOF-  */
009424000000
009425000000     /*-------------------------------------------------------------*/
009426000000     /*   Cmd-ADDMSGD für Message-ID :   USR9995                    */
009427000000     /* Struktur der Einstellungsdatei wird angepasst ...           */
009428000000     /*-------------------------------------------------------------*/
009429000000
009430000000             RMVMSGD MSGID(USR9995) MSGF(&LIB/&OBJ)
009431000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009432000000
009433000000             ADDMSGD +
009434000000                MSGID(USR9995) +
009435000000                MSGF(&LIB/&OBJ) +
009436000000                MSG( +
009437000000'Struktur der Einstellungsdatei wird angepasst ...'                   +
009438000000                ) +
009439000000                SEV(0) +
009440000000     /*   No replacement variables defined!                         */ +
009441000000                ALROPT(*NO) +
009442000000                CCSID(65535) +
009443000000                /*  -EOF-  */
009444000000
009445000000     /*-------------------------------------------------------------*/
009446000000     /*   Cmd-ADDMSGD für Message-ID :   USR9996                    */
009447000000     /* Keine Datei geöffnet.                                       */
009448000000     /*-------------------------------------------------------------*/
009449000000
009450000000             RMVMSGD MSGID(USR9996) MSGF(&LIB/&OBJ)
009451000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009452000000
009453000000             ADDMSGD +
009454000000                MSGID(USR9996) +
009455000000                MSGF(&LIB/&OBJ) +
009456000000                MSG( +
009457000000'Keine Datei geöffnet.'                                               +
009458000000                ) +
009459000000                SEV(0) +
009460000000     /*   No replacement variables defined!                         */ +
009461000000                ALROPT(*NO) +
009462000000                CCSID(65535) +
009463000000                /*  -EOF-  */
009464000000
009465000000     /*-------------------------------------------------------------*/
009466000000     /*   Cmd-ADDMSGD für Message-ID :   USR9997                    */
009467000000     /* &2PEEK/400 ist&1 Shareware. &2Bitte lassen Sie sich registr */
009468000000     /*-------------------------------------------------------------*/
009469000000
009470000000             RMVMSGD MSGID(USR9997) MSGF(&LIB/&OBJ)
009471000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009472000000
009473000000             ADDMSGD +
009474000000                MSGID(USR9997) +
009475000000                MSGF(&LIB/&OBJ) +
009476000000                MSG( +
009477000000'&2PEEK/400 ist&1 Shareware. &2Bitte lassen Sie sich registrieren!'   +
009478000000                ) +
009479000000                SEV(0) +
009480000000                FMT( +
009481000000                    (*CHAR 1) +
009482000000                    (*CHAR 1) +
009483000000                ) +
009484000000                ALROPT(*NO) +
009485000000                CCSID(65535) +
009486000000                /*  -EOF-  */
009487000000
009488000000     /*-------------------------------------------------------------*/
009489000000     /*   Cmd-ADDMSGD für Message-ID :   USR9998                    */
009490000000     /* Unerwartete Nachrichten-ID &1 von Programm &2.              */
009491000000     /*-------------------------------------------------------------*/
009492000000
009493000000             RMVMSGD MSGID(USR9998) MSGF(&LIB/&OBJ)
009494000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009495000000
009496000000             ADDMSGD +
009497000000                MSGID(USR9998) +
009498000000                MSGF(&LIB/&OBJ) +
009499000000                MSG( +
009500000000'Unerwartete Nachrichten-ID &1 von Programm &2.'                      +
009501000000                ) +
009502000000                SEV(0) +
009503000000                FMT( +
009504000000                    (*CHAR 7) +
009505000000                    (*CHAR 10) +
009506000000                ) +
009507000000                ALROPT(*NO) +
009508000000                CCSID(65535) +
009509000000                /*  -EOF-  */
009510000000
009511000000     /*-------------------------------------------------------------*/
009512000000     /*   Cmd-ADDMSGD für Message-ID :   USR9999                    */
009513000000     /* &1                                                          */
009514000000     /*-------------------------------------------------------------*/
009515000000
009516000000             RMVMSGD MSGID(USR9999) MSGF(&LIB/&OBJ)
009517000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009518000000
009519000000             ADDMSGD +
009520000000                MSGID(USR9999) +
009521000000                MSGF(&LIB/&OBJ) +
009522000000                MSG( +
009523000000'&1'                                                                  +
009524000000                ) +
009525000000                SECLVL( +
009526000000'&2'                                                                  +
009527000000                ) +
009528000000                SEV(0) +
009529000000                FMT( +
009530000000                    (*CHAR 128) +
009531000000                    (*CHAR 128) +
009532000000                ) +
009533000000                ALROPT(*NO) +
009534000000                CCSID(65535) +
009535000000                /*  -EOF-  */
009536000000
009537000000             RCLRSC LVL(*)
009538000000
009539000000             ENDPGM
