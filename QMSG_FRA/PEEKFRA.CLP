000001000000     /*-----------------------------------------------------------------------*/
000002000000     /* STRPREPRC Compile Options:                                            */
000003000000     /* >>PRE-COMPILER<<                                                      */
000004000000     /*   >>CRTCMD<<  CALL       PGM(QTEMP/&OB) PARM(&LI &OB);                */
000005000000     /*   >>CMD<<     CRTCLPGM   PGM(QTEMP/&OB) +                             */
000006000000     /*                          SRCFILE(&SL/&SF) SRCMBR(&SM) +               */
000007000000     /*               TEXT('Peek/400 - Französische Übersetzung');            */
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
000023000000                            MSGDTA('Usage: CALL PGM(PEEKFRA) +
000024000000                                    PARM(libName [msgFName)') +
000025000000                            TOPGMQ(*PRV (*PGMBDY)) MSGTYPE(*ESCAPE)
000026000000             ENDDO
000027000000
000028000000             CHGVAR     VAR(&OBJ       ) VALUE(&I_OBJ)
000029000000             MONMSG     MSGID(MCH3601) EXEC(DO)
000030000000               RMVMSG     PGMQ(*SAME (*)) CLEAR(*ALL)
000031000000               CHGVAR     VAR(&OBJ) VALUE('PEEKFRA   ')
000032000000             ENDDO
000033000000
000034000000     /*-------------------------------------------------------------*/
000035000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BA                    */
000036000000     /* Touche F22 non valide                                       */
000037000000     /*-------------------------------------------------------------*/
000038000000
000039000000             RMVMSGD MSGID(AID00BA) MSGF(&LIB/&OBJ)
000040000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000041000000
000042000000             ADDMSGD +
000043000000                MSGID(AID00BA) +
000044000000                MSGF(&LIB/&OBJ) +
000045000000                MSG( +
000046000000'Touche F22 non valide'                                               +
000047000000                ) +
000048000000                SEV(0) +
000049000000     /*   No replacement variables defined!                         */ +
000050000000                ALROPT(*NO) +
000051000000                CCSID(65535) +
000052000000                /*  -EOF-  */
000053000000
000054000000     /*-------------------------------------------------------------*/
000055000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BB                    */
000056000000     /* Touche F23 non valide                                       */
000057000000     /*-------------------------------------------------------------*/
000058000000
000059000000             RMVMSGD MSGID(AID00BB) MSGF(&LIB/&OBJ)
000060000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000061000000
000062000000             ADDMSGD +
000063000000                MSGID(AID00BB) +
000064000000                MSGF(&LIB/&OBJ) +
000065000000                MSG( +
000066000000'Touche F23 non valide'                                               +
000067000000                ) +
000068000000                SEV(0) +
000069000000     /*   No replacement variables defined!                         */ +
000070000000                ALROPT(*NO) +
000071000000                CCSID(65535) +
000072000000                /*  -EOF-  */
000073000000
000074000000     /*-------------------------------------------------------------*/
000075000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BC                    */
000076000000     /* Touche F24 non valide                                       */
000077000000     /*-------------------------------------------------------------*/
000078000000
000079000000             RMVMSGD MSGID(AID00BC) MSGF(&LIB/&OBJ)
000080000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000081000000
000082000000             ADDMSGD +
000083000000                MSGID(AID00BC) +
000084000000                MSGF(&LIB/&OBJ) +
000085000000                MSG( +
000086000000'Touche F24 non valide'                                               +
000087000000                ) +
000088000000                SEV(0) +
000089000000     /*   No replacement variables defined!                         */ +
000090000000                ALROPT(*NO) +
000091000000                CCSID(65535) +
000092000000                /*  -EOF-  */
000093000000
000094000000     /*-------------------------------------------------------------*/
000095000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BD                    */
000096000000     /* Touche 'SUPPR' invalide                                     */
000097000000     /*-------------------------------------------------------------*/
000098000000
000099000000             RMVMSGD MSGID(AID00BD) MSGF(&LIB/&OBJ)
000100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000101000000
000102000000             ADDMSGD +
000103000000                MSGID(AID00BD) +
000104000000                MSGF(&LIB/&OBJ) +
000105000000                MSG( +
000106000000'Touche ''SUPPR'' invalide'                                           +
000107000000                ) +
000108000000                SEV(0) +
000109000000     /*   No replacement variables defined!                         */ +
000110000000                ALROPT(*NO) +
000111000000                CCSID(65535) +
000112000000                /*  -EOF-  */
000113000000
000114000000     /*-------------------------------------------------------------*/
000115000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B1                    */
000116000000     /* Touche F13 non valide                                       */
000117000000     /*-------------------------------------------------------------*/
000118000000
000119000000             RMVMSGD MSGID(AID00B1) MSGF(&LIB/&OBJ)
000120000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000121000000
000122000000             ADDMSGD +
000123000000                MSGID(AID00B1) +
000124000000                MSGF(&LIB/&OBJ) +
000125000000                MSG( +
000126000000'Touche F13 non valide'                                               +
000127000000                ) +
000128000000                SEV(0) +
000129000000     /*   No replacement variables defined!                         */ +
000130000000                ALROPT(*NO) +
000131000000                CCSID(65535) +
000132000000                /*  -EOF-  */
000133000000
000134000000     /*-------------------------------------------------------------*/
000135000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B2                    */
000136000000     /* Touche F14 non valide                                       */
000137000000     /*-------------------------------------------------------------*/
000138000000
000139000000             RMVMSGD MSGID(AID00B2) MSGF(&LIB/&OBJ)
000140000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000141000000
000142000000             ADDMSGD +
000143000000                MSGID(AID00B2) +
000144000000                MSGF(&LIB/&OBJ) +
000145000000                MSG( +
000146000000'Touche F14 non valide'                                               +
000147000000                ) +
000148000000                SEV(0) +
000149000000     /*   No replacement variables defined!                         */ +
000150000000                ALROPT(*NO) +
000151000000                CCSID(65535) +
000152000000                /*  -EOF-  */
000153000000
000154000000     /*-------------------------------------------------------------*/
000155000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B3                    */
000156000000     /* Touche F15 non valide                                       */
000157000000     /*-------------------------------------------------------------*/
000158000000
000159000000             RMVMSGD MSGID(AID00B3) MSGF(&LIB/&OBJ)
000160000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000161000000
000162000000             ADDMSGD +
000163000000                MSGID(AID00B3) +
000164000000                MSGF(&LIB/&OBJ) +
000165000000                MSG( +
000166000000'Touche F15 non valide'                                               +
000167000000                ) +
000168000000                SEV(0) +
000169000000     /*   No replacement variables defined!                         */ +
000170000000                ALROPT(*NO) +
000171000000                CCSID(65535) +
000172000000                /*  -EOF-  */
000173000000
000174000000     /*-------------------------------------------------------------*/
000175000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B4                    */
000176000000     /* Touche F16 non valide                                       */
000177000000     /*-------------------------------------------------------------*/
000178000000
000179000000             RMVMSGD MSGID(AID00B4) MSGF(&LIB/&OBJ)
000180000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000181000000
000182000000             ADDMSGD +
000183000000                MSGID(AID00B4) +
000184000000                MSGF(&LIB/&OBJ) +
000185000000                MSG( +
000186000000'Touche F16 non valide'                                               +
000187000000                ) +
000188000000                SEV(0) +
000189000000     /*   No replacement variables defined!                         */ +
000190000000                ALROPT(*NO) +
000191000000                CCSID(65535) +
000192000000                /*  -EOF-  */
000193000000
000194000000     /*-------------------------------------------------------------*/
000195000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B5                    */
000196000000     /* Touche F17 non valide                                       */
000197000000     /*-------------------------------------------------------------*/
000198000000
000199000000             RMVMSGD MSGID(AID00B5) MSGF(&LIB/&OBJ)
000200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000201000000
000202000000             ADDMSGD +
000203000000                MSGID(AID00B5) +
000204000000                MSGF(&LIB/&OBJ) +
000205000000                MSG( +
000206000000'Touche F17 non valide'                                               +
000207000000                ) +
000208000000                SEV(0) +
000209000000     /*   No replacement variables defined!                         */ +
000210000000                ALROPT(*NO) +
000211000000                CCSID(65535) +
000212000000                /*  -EOF-  */
000213000000
000214000000     /*-------------------------------------------------------------*/
000215000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B6                    */
000216000000     /* Touche F18 non valide                                       */
000217000000     /*-------------------------------------------------------------*/
000218000000
000219000000             RMVMSGD MSGID(AID00B6) MSGF(&LIB/&OBJ)
000220000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000221000000
000222000000             ADDMSGD +
000223000000                MSGID(AID00B6) +
000224000000                MSGF(&LIB/&OBJ) +
000225000000                MSG( +
000226000000'Touche F18 non valide'                                               +
000227000000                ) +
000228000000                SEV(0) +
000229000000     /*   No replacement variables defined!                         */ +
000230000000                ALROPT(*NO) +
000231000000                CCSID(65535) +
000232000000                /*  -EOF-  */
000233000000
000234000000     /*-------------------------------------------------------------*/
000235000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B7                    */
000236000000     /* Touche F19 non valide                                       */
000237000000     /*-------------------------------------------------------------*/
000238000000
000239000000             RMVMSGD MSGID(AID00B7) MSGF(&LIB/&OBJ)
000240000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000241000000
000242000000             ADDMSGD +
000243000000                MSGID(AID00B7) +
000244000000                MSGF(&LIB/&OBJ) +
000245000000                MSG( +
000246000000'Touche F19 non valide'                                               +
000247000000                ) +
000248000000                SEV(0) +
000249000000     /*   No replacement variables defined!                         */ +
000250000000                ALROPT(*NO) +
000251000000                CCSID(65535) +
000252000000                /*  -EOF-  */
000253000000
000254000000     /*-------------------------------------------------------------*/
000255000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B8                    */
000256000000     /* Touche F20 non valide                                       */
000257000000     /*-------------------------------------------------------------*/
000258000000
000259000000             RMVMSGD MSGID(AID00B8) MSGF(&LIB/&OBJ)
000260000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000261000000
000262000000             ADDMSGD +
000263000000                MSGID(AID00B8) +
000264000000                MSGF(&LIB/&OBJ) +
000265000000                MSG( +
000266000000'Touche F20 non valide'                                               +
000267000000                ) +
000268000000                SEV(0) +
000269000000     /*   No replacement variables defined!                         */ +
000270000000                ALROPT(*NO) +
000271000000                CCSID(65535) +
000272000000                /*  -EOF-  */
000273000000
000274000000     /*-------------------------------------------------------------*/
000275000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B9                    */
000276000000     /* Touche F21 non valide                                       */
000277000000     /*-------------------------------------------------------------*/
000278000000
000279000000             RMVMSGD MSGID(AID00B9) MSGF(&LIB/&OBJ)
000280000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000281000000
000282000000             ADDMSGD +
000283000000                MSGID(AID00B9) +
000284000000                MSGF(&LIB/&OBJ) +
000285000000                MSG( +
000286000000'Touche F21 non valide'                                               +
000287000000                ) +
000288000000                SEV(0) +
000289000000     /*   No replacement variables defined!                         */ +
000290000000                ALROPT(*NO) +
000291000000                CCSID(65535) +
000292000000                /*  -EOF-  */
000293000000
000294000000     /*-------------------------------------------------------------*/
000295000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F1                    */
000296000000     /* Touche 'ENTREE' non valide                                  */
000297000000     /*-------------------------------------------------------------*/
000298000000
000299000000             RMVMSGD MSGID(AID00F1) MSGF(&LIB/&OBJ)
000300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000301000000
000302000000             ADDMSGD +
000303000000                MSGID(AID00F1) +
000304000000                MSGF(&LIB/&OBJ) +
000305000000                MSG( +
000306000000'Touche ''ENTREE'' non valide'                                        +
000307000000                ) +
000308000000                SEV(0) +
000309000000     /*   No replacement variables defined!                         */ +
000310000000                ALROPT(*NO) +
000311000000                CCSID(65535) +
000312000000                /*  -EOF-  */
000313000000
000314000000     /*-------------------------------------------------------------*/
000315000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F3                    */
000316000000     /* Touche 'AIDE' non valide                                    */
000317000000     /*-------------------------------------------------------------*/
000318000000
000319000000             RMVMSGD MSGID(AID00F3) MSGF(&LIB/&OBJ)
000320000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000321000000
000322000000             ADDMSGD +
000323000000                MSGID(AID00F3) +
000324000000                MSGF(&LIB/&OBJ) +
000325000000                MSG( +
000326000000'Touche ''AIDE'' non valide'                                          +
000327000000                ) +
000328000000                SEV(0) +
000329000000     /*   No replacement variables defined!                         */ +
000330000000                ALROPT(*NO) +
000331000000                CCSID(65535) +
000332000000                /*  -EOF-  */
000333000000
000334000000     /*-------------------------------------------------------------*/
000335000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F4                    */
000336000000     /* Touche 'PAGE PREC' non valide                               */
000337000000     /*-------------------------------------------------------------*/
000338000000
000339000000             RMVMSGD MSGID(AID00F4) MSGF(&LIB/&OBJ)
000340000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000341000000
000342000000             ADDMSGD +
000343000000                MSGID(AID00F4) +
000344000000                MSGF(&LIB/&OBJ) +
000345000000                MSG( +
000346000000'Touche ''PAGE PREC'' non valide'                                     +
000347000000                ) +
000348000000                SEV(0) +
000349000000     /*   No replacement variables defined!                         */ +
000350000000                ALROPT(*NO) +
000351000000                CCSID(65535) +
000352000000                /*  -EOF-  */
000353000000
000354000000     /*-------------------------------------------------------------*/
000355000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F5                    */
000356000000     /* Touche 'PAGE SUIV' non valide                               */
000357000000     /*-------------------------------------------------------------*/
000358000000
000359000000             RMVMSGD MSGID(AID00F5) MSGF(&LIB/&OBJ)
000360000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000361000000
000362000000             ADDMSGD +
000363000000                MSGID(AID00F5) +
000364000000                MSGF(&LIB/&OBJ) +
000365000000                MSG( +
000366000000'Touche ''PAGE SUIV'' non valide'                                     +
000367000000                ) +
000368000000                SEV(0) +
000369000000     /*   No replacement variables defined!                         */ +
000370000000                ALROPT(*NO) +
000371000000                CCSID(65535) +
000372000000                /*  -EOF-  */
000373000000
000374000000     /*-------------------------------------------------------------*/
000375000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F6                    */
000376000000     /* Touche 'IMPR' non valide                                    */
000377000000     /*-------------------------------------------------------------*/
000378000000
000379000000             RMVMSGD MSGID(AID00F6) MSGF(&LIB/&OBJ)
000380000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000381000000
000382000000             ADDMSGD +
000383000000                MSGID(AID00F6) +
000384000000                MSGF(&LIB/&OBJ) +
000385000000                MSG( +
000386000000'Touche ''IMPR'' non valide'                                          +
000387000000                ) +
000388000000                SEV(0) +
000389000000     /*   No replacement variables defined!                         */ +
000390000000                ALROPT(*NO) +
000391000000                CCSID(65535) +
000392000000                /*  -EOF-  */
000393000000
000394000000     /*-------------------------------------------------------------*/
000395000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F8                    */
000396000000     /* Touche 'RESET' non valide                                   */
000397000000     /*-------------------------------------------------------------*/
000398000000
000399000000             RMVMSGD MSGID(AID00F8) MSGF(&LIB/&OBJ)
000400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000401000000
000402000000             ADDMSGD +
000403000000                MSGID(AID00F8) +
000404000000                MSGF(&LIB/&OBJ) +
000405000000                MSG( +
000406000000'Touche ''RESET'' non valide'                                         +
000407000000                ) +
000408000000                SEV(0) +
000409000000     /*   No replacement variables defined!                         */ +
000410000000                ALROPT(*NO) +
000411000000                CCSID(65535) +
000412000000                /*  -EOF-  */
000413000000
000414000000     /*-------------------------------------------------------------*/
000415000000     /*   Cmd-ADDMSGD für Message-ID :   AID003A                    */
000416000000     /* Touche F10 non valide                                       */
000417000000     /*-------------------------------------------------------------*/
000418000000
000419000000             RMVMSGD MSGID(AID003A) MSGF(&LIB/&OBJ)
000420000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000421000000
000422000000             ADDMSGD +
000423000000                MSGID(AID003A) +
000424000000                MSGF(&LIB/&OBJ) +
000425000000                MSG( +
000426000000'Touche F10 non valide'                                               +
000427000000                ) +
000428000000                SEV(0) +
000429000000     /*   No replacement variables defined!                         */ +
000430000000                ALROPT(*NO) +
000431000000                CCSID(65535) +
000432000000                /*  -EOF-  */
000433000000
000434000000     /*-------------------------------------------------------------*/
000435000000     /*   Cmd-ADDMSGD für Message-ID :   AID003B                    */
000436000000     /* Touche F11 non valide                                       */
000437000000     /*-------------------------------------------------------------*/
000438000000
000439000000             RMVMSGD MSGID(AID003B) MSGF(&LIB/&OBJ)
000440000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000441000000
000442000000             ADDMSGD +
000443000000                MSGID(AID003B) +
000444000000                MSGF(&LIB/&OBJ) +
000445000000                MSG( +
000446000000'Touche F11 non valide'                                               +
000447000000                ) +
000448000000                SEV(0) +
000449000000     /*   No replacement variables defined!                         */ +
000450000000                ALROPT(*NO) +
000451000000                CCSID(65535) +
000452000000                /*  -EOF-  */
000453000000
000454000000     /*-------------------------------------------------------------*/
000455000000     /*   Cmd-ADDMSGD für Message-ID :   AID003C                    */
000456000000     /* Touche F12 non valide                                       */
000457000000     /*-------------------------------------------------------------*/
000458000000
000459000000             RMVMSGD MSGID(AID003C) MSGF(&LIB/&OBJ)
000460000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000461000000
000462000000             ADDMSGD +
000463000000                MSGID(AID003C) +
000464000000                MSGF(&LIB/&OBJ) +
000465000000                MSG( +
000466000000'Touche F12 non valide'                                               +
000467000000                ) +
000468000000                SEV(0) +
000469000000     /*   No replacement variables defined!                         */ +
000470000000                ALROPT(*NO) +
000471000000                CCSID(65535) +
000472000000                /*  -EOF-  */
000473000000
000474000000     /*-------------------------------------------------------------*/
000475000000     /*   Cmd-ADDMSGD für Message-ID :   AID003F                    */
000476000000     /* Touche 'CRAYON OPTIQUE' non valide                          */
000477000000     /*-------------------------------------------------------------*/
000478000000
000479000000             RMVMSGD MSGID(AID003F) MSGF(&LIB/&OBJ)
000480000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000481000000
000482000000             ADDMSGD +
000483000000                MSGID(AID003F) +
000484000000                MSGF(&LIB/&OBJ) +
000485000000                MSG( +
000486000000'Touche ''CRAYON OPTIQUE'' non valide'                                +
000487000000                ) +
000488000000                SEV(0) +
000489000000     /*   No replacement variables defined!                         */ +
000490000000                ALROPT(*NO) +
000491000000                CCSID(65535) +
000492000000                /*  -EOF-  */
000493000000
000494000000     /*-------------------------------------------------------------*/
000495000000     /*   Cmd-ADDMSGD für Message-ID :   AID0031                    */
000496000000     /* Touche F1 non valide                                        */
000497000000     /*-------------------------------------------------------------*/
000498000000
000499000000             RMVMSGD MSGID(AID0031) MSGF(&LIB/&OBJ)
000500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000501000000
000502000000             ADDMSGD +
000503000000                MSGID(AID0031) +
000504000000                MSGF(&LIB/&OBJ) +
000505000000                MSG( +
000506000000'Touche F1 non valide'                                                +
000507000000                ) +
000508000000                SEV(0) +
000509000000     /*   No replacement variables defined!                         */ +
000510000000                ALROPT(*NO) +
000511000000                CCSID(65535) +
000512000000                /*  -EOF-  */
000513000000
000514000000     /*-------------------------------------------------------------*/
000515000000     /*   Cmd-ADDMSGD für Message-ID :   AID0032                    */
000516000000     /* Touche F2 non valide                                        */
000517000000     /*-------------------------------------------------------------*/
000518000000
000519000000             RMVMSGD MSGID(AID0032) MSGF(&LIB/&OBJ)
000520000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000521000000
000522000000             ADDMSGD +
000523000000                MSGID(AID0032) +
000524000000                MSGF(&LIB/&OBJ) +
000525000000                MSG( +
000526000000'Touche F2 non valide'                                                +
000527000000                ) +
000528000000                SEV(0) +
000529000000     /*   No replacement variables defined!                         */ +
000530000000                ALROPT(*NO) +
000531000000                CCSID(65535) +
000532000000                /*  -EOF-  */
000533000000
000534000000     /*-------------------------------------------------------------*/
000535000000     /*   Cmd-ADDMSGD für Message-ID :   AID0033                    */
000536000000     /* Touche F3 non valide                                        */
000537000000     /*-------------------------------------------------------------*/
000538000000
000539000000             RMVMSGD MSGID(AID0033) MSGF(&LIB/&OBJ)
000540000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000541000000
000542000000             ADDMSGD +
000543000000                MSGID(AID0033) +
000544000000                MSGF(&LIB/&OBJ) +
000545000000                MSG( +
000546000000'Touche F3 non valide'                                                +
000547000000                ) +
000548000000                SEV(0) +
000549000000     /*   No replacement variables defined!                         */ +
000550000000                ALROPT(*NO) +
000551000000                CCSID(65535) +
000552000000                /*  -EOF-  */
000553000000
000554000000     /*-------------------------------------------------------------*/
000555000000     /*   Cmd-ADDMSGD für Message-ID :   AID0034                    */
000556000000     /* Touche F4 non valide                                        */
000557000000     /*-------------------------------------------------------------*/
000558000000
000559000000             RMVMSGD MSGID(AID0034) MSGF(&LIB/&OBJ)
000560000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000561000000
000562000000             ADDMSGD +
000563000000                MSGID(AID0034) +
000564000000                MSGF(&LIB/&OBJ) +
000565000000                MSG( +
000566000000'Touche F4 non valide'                                                +
000567000000                ) +
000568000000                SEV(0) +
000569000000     /*   No replacement variables defined!                         */ +
000570000000                ALROPT(*NO) +
000571000000                CCSID(65535) +
000572000000                /*  -EOF-  */
000573000000
000574000000     /*-------------------------------------------------------------*/
000575000000     /*   Cmd-ADDMSGD für Message-ID :   AID0035                    */
000576000000     /* Touche F5 non valide                                        */
000577000000     /*-------------------------------------------------------------*/
000578000000
000579000000             RMVMSGD MSGID(AID0035) MSGF(&LIB/&OBJ)
000580000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000581000000
000582000000             ADDMSGD +
000583000000                MSGID(AID0035) +
000584000000                MSGF(&LIB/&OBJ) +
000585000000                MSG( +
000586000000'Touche F5 non valide'                                                +
000587000000                ) +
000588000000                SEV(0) +
000589000000     /*   No replacement variables defined!                         */ +
000590000000                ALROPT(*NO) +
000591000000                CCSID(65535) +
000592000000                /*  -EOF-  */
000593000000
000594000000     /*-------------------------------------------------------------*/
000595000000     /*   Cmd-ADDMSGD für Message-ID :   AID0036                    */
000596000000     /* Touche F6 non valide                                        */
000597000000     /*-------------------------------------------------------------*/
000598000000
000599000000             RMVMSGD MSGID(AID0036) MSGF(&LIB/&OBJ)
000600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000601000000
000602000000             ADDMSGD +
000603000000                MSGID(AID0036) +
000604000000                MSGF(&LIB/&OBJ) +
000605000000                MSG( +
000606000000'Touche F6 non valide'                                                +
000607000000                ) +
000608000000                SEV(0) +
000609000000     /*   No replacement variables defined!                         */ +
000610000000                ALROPT(*NO) +
000611000000                CCSID(65535) +
000612000000                /*  -EOF-  */
000613000000
000614000000     /*-------------------------------------------------------------*/
000615000000     /*   Cmd-ADDMSGD für Message-ID :   AID0037                    */
000616000000     /* Touche F7 non valide                                        */
000617000000     /*-------------------------------------------------------------*/
000618000000
000619000000             RMVMSGD MSGID(AID0037) MSGF(&LIB/&OBJ)
000620000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000621000000
000622000000             ADDMSGD +
000623000000                MSGID(AID0037) +
000624000000                MSGF(&LIB/&OBJ) +
000625000000                MSG( +
000626000000'Touche F7 non valide'                                                +
000627000000                ) +
000628000000                SEV(0) +
000629000000     /*   No replacement variables defined!                         */ +
000630000000                ALROPT(*NO) +
000631000000                CCSID(65535) +
000632000000                /*  -EOF-  */
000633000000
000634000000     /*-------------------------------------------------------------*/
000635000000     /*   Cmd-ADDMSGD für Message-ID :   AID0038                    */
000636000000     /* Touche F8 non valide                                        */
000637000000     /*-------------------------------------------------------------*/
000638000000
000639000000             RMVMSGD MSGID(AID0038) MSGF(&LIB/&OBJ)
000640000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000641000000
000642000000             ADDMSGD +
000643000000                MSGID(AID0038) +
000644000000                MSGF(&LIB/&OBJ) +
000645000000                MSG( +
000646000000'Touche F8 non valide'                                                +
000647000000                ) +
000648000000                SEV(0) +
000649000000     /*   No replacement variables defined!                         */ +
000650000000                ALROPT(*NO) +
000651000000                CCSID(65535) +
000652000000                /*  -EOF-  */
000653000000
000654000000     /*-------------------------------------------------------------*/
000655000000     /*   Cmd-ADDMSGD für Message-ID :   AID0039                    */
000656000000     /* Touche F9 non valide                                        */
000657000000     /*-------------------------------------------------------------*/
000658000000
000659000000             RMVMSGD MSGID(AID0039) MSGF(&LIB/&OBJ)
000660000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000661000000
000662000000             ADDMSGD +
000663000000                MSGID(AID0039) +
000664000000                MSGF(&LIB/&OBJ) +
000665000000                MSG( +
000666000000'Touche F9 non valide'                                                +
000667000000                ) +
000668000000                SEV(0) +
000669000000     /*   No replacement variables defined!                         */ +
000670000000                ALROPT(*NO) +
000671000000                CCSID(65535) +
000672000000                /*  -EOF-  */
000673000000
000674000000     /*-------------------------------------------------------------*/
000675000000     /*   Cmd-ADDMSGD für Message-ID :   AID0100                    */
000676000000     /* Touche invalide                                             */
000677000000     /*-------------------------------------------------------------*/
000678000000
000679000000             RMVMSGD MSGID(AID0100) MSGF(&LIB/&OBJ)
000680000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000681000000
000682000000             ADDMSGD +
000683000000                MSGID(AID0100) +
000684000000                MSGF(&LIB/&OBJ) +
000685000000                MSG( +
000686000000'Touche invalide'                                                     +
000687000000                ) +
000688000000                SEV(0) +
000689000000     /*   No replacement variables defined!                         */ +
000690000000                ALROPT(*NO) +
000691000000                CCSID(65535) +
000692000000                /*  -EOF-  */
000693000000
000694000000     /*-------------------------------------------------------------*/
000695000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0001                    */
000696000000     /* Enträe                                                      */
000697000000     /*-------------------------------------------------------------*/
000698000000
000699000000             RMVMSGD MSGID(KEY0001) MSGF(&LIB/&OBJ)
000700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000701000000
000702000000             ADDMSGD +
000703000000                MSGID(KEY0001) +
000704000000                MSGF(&LIB/&OBJ) +
000705000000                MSG( +
000706000000'Enträe        '                                                      +
000707000000                ) +
000708000000                SEV(0) +
000709000000     /*   No replacement variables defined!                         */ +
000710000000                ALROPT(*NO) +
000711000000                CCSID(65535) +
000712000000                /*  -EOF-  */
000713000000
000714000000     /*-------------------------------------------------------------*/
000715000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0002                    */
000716000000     /* Fin                                                         */
000717000000     /*-------------------------------------------------------------*/
000718000000
000719000000             RMVMSGD MSGID(KEY0002) MSGF(&LIB/&OBJ)
000720000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000721000000
000722000000             ADDMSGD +
000723000000                MSGID(KEY0002) +
000724000000                MSGF(&LIB/&OBJ) +
000725000000                MSG( +
000726000000'Fin           '                                                      +
000727000000                ) +
000728000000                SEV(0) +
000729000000     /*   No replacement variables defined!                         */ +
000730000000                ALROPT(*NO) +
000731000000                CCSID(65535) +
000732000000                /*  -EOF-  */
000733000000
000734000000     /*-------------------------------------------------------------*/
000735000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0003                    */
000736000000     /* Rafraîchir                                                  */
000737000000     /*-------------------------------------------------------------*/
000738000000
000739000000             RMVMSGD MSGID(KEY0003) MSGF(&LIB/&OBJ)
000740000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000741000000
000742000000             ADDMSGD +
000743000000                MSGID(KEY0003) +
000744000000                MSGF(&LIB/&OBJ) +
000745000000                MSG( +
000746000000'Rafraîchir    '                                                      +
000747000000                ) +
000748000000                SEV(0) +
000749000000     /*   No replacement variables defined!                         */ +
000750000000                ALROPT(*NO) +
000751000000                CCSID(65535) +
000752000000                /*  -EOF-  */
000753000000
000754000000     /*-------------------------------------------------------------*/
000755000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0004                    */
000756000000     /* Ajouter                                                     */
000757000000     /*-------------------------------------------------------------*/
000758000000
000759000000             RMVMSGD MSGID(KEY0004) MSGF(&LIB/&OBJ)
000760000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000761000000
000762000000             ADDMSGD +
000763000000                MSGID(KEY0004) +
000764000000                MSGF(&LIB/&OBJ) +
000765000000                MSG( +
000766000000'Ajouter  '                                                           +
000767000000                ) +
000768000000                SEV(0) +
000769000000     /*   No replacement variables defined!                         */ +
000770000000                ALROPT(*NO) +
000771000000                CCSID(65535) +
000772000000                /*  -EOF-  */
000773000000
000774000000     /*-------------------------------------------------------------*/
000775000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0005                    */
000776000000     /* Nom/lib. champ                                              */
000777000000     /*-------------------------------------------------------------*/
000778000000
000779000000             RMVMSGD MSGID(KEY0005) MSGF(&LIB/&OBJ)
000780000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000781000000
000782000000             ADDMSGD +
000783000000                MSGID(KEY0005) +
000784000000                MSGF(&LIB/&OBJ) +
000785000000                MSG( +
000786000000'Nom/lib. champ'                                                      +
000787000000                ) +
000788000000                SEV(0) +
000789000000     /*   No replacement variables defined!                         */ +
000790000000                ALROPT(*NO) +
000791000000                CCSID(65535) +
000792000000                /*  -EOF-  */
000793000000
000794000000     /*-------------------------------------------------------------*/
000795000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0006                    */
000796000000     /* Sälec.col. +/-                                              */
000797000000     /*-------------------------------------------------------------*/
000798000000
000799000000             RMVMSGD MSGID(KEY0006) MSGF(&LIB/&OBJ)
000800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000801000000
000802000000             ADDMSGD +
000803000000                MSGID(KEY0006) +
000804000000                MSGF(&LIB/&OBJ) +
000805000000                MSG( +
000806000000'Sälec.col. +/-'                                                      +
000807000000                ) +
000808000000                SEV(0) +
000809000000     /*   No replacement variables defined!                         */ +
000810000000                ALROPT(*NO) +
000811000000                CCSID(65535) +
000812000000                /*  -EOF-  */
000813000000
000814000000     /*-------------------------------------------------------------*/
000815000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0007                    */
000816000000     /* Haut de page                                                */
000817000000     /*-------------------------------------------------------------*/
000818000000
000819000000             RMVMSGD MSGID(KEY0007) MSGF(&LIB/&OBJ)
000820000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000821000000
000822000000             ADDMSGD +
000823000000                MSGID(KEY0007) +
000824000000                MSGF(&LIB/&OBJ) +
000825000000                MSG( +
000826000000'Haut de page'                                                        +
000827000000                ) +
000828000000                SEV(0) +
000829000000     /*   No replacement variables defined!                         */ +
000830000000                ALROPT(*NO) +
000831000000                CCSID(65535) +
000832000000                /*  -EOF-  */
000833000000
000834000000     /*-------------------------------------------------------------*/
000835000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0008                    */
000836000000     /* Pos. Curseur                                                */
000837000000     /*-------------------------------------------------------------*/
000838000000
000839000000             RMVMSGD MSGID(KEY0008) MSGF(&LIB/&OBJ)
000840000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000841000000
000842000000             ADDMSGD +
000843000000                MSGID(KEY0008) +
000844000000                MSGF(&LIB/&OBJ) +
000845000000                MSG( +
000846000000'Pos. Curseur  '                                                      +
000847000000                ) +
000848000000                SEV(0) +
000849000000     /*   No replacement variables defined!                         */ +
000850000000                ALROPT(*NO) +
000851000000                CCSID(65535) +
000852000000                /*  -EOF-  */
000853000000
000854000000     /*-------------------------------------------------------------*/
000855000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0009                    */
000856000000     /* Recherche                                                   */
000857000000     /*-------------------------------------------------------------*/
000858000000
000859000000             RMVMSGD MSGID(KEY0009) MSGF(&LIB/&OBJ)
000860000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000861000000
000862000000             ADDMSGD +
000863000000                MSGID(KEY0009) +
000864000000                MSGF(&LIB/&OBJ) +
000865000000                MSG( +
000866000000'Recherche     '                                                      +
000867000000                ) +
000868000000                SEV(0) +
000869000000     /*   No replacement variables defined!                         */ +
000870000000                ALROPT(*NO) +
000871000000                CCSID(65535) +
000872000000                /*  -EOF-  */
000873000000
000874000000     /*-------------------------------------------------------------*/
000875000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0010                    */
000876000000     /* Däbut                                                       */
000877000000     /*-------------------------------------------------------------*/
000878000000
000879000000             RMVMSGD MSGID(KEY0010) MSGF(&LIB/&OBJ)
000880000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000881000000
000882000000             ADDMSGD +
000883000000                MSGID(KEY0010) +
000884000000                MSGF(&LIB/&OBJ) +
000885000000                MSG( +
000886000000'Däbut         '                                                      +
000887000000                ) +
000888000000                SEV(0) +
000889000000     /*   No replacement variables defined!                         */ +
000890000000                ALROPT(*NO) +
000891000000                CCSID(65535) +
000892000000                /*  -EOF-  */
000893000000
000894000000     /*-------------------------------------------------------------*/
000895000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0011                    */
000896000000     /* Fin                                                         */
000897000000     /*-------------------------------------------------------------*/
000898000000
000899000000             RMVMSGD MSGID(KEY0011) MSGF(&LIB/&OBJ)
000900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000901000000
000902000000             ADDMSGD +
000903000000                MSGID(KEY0011) +
000904000000                MSGF(&LIB/&OBJ) +
000905000000                MSG( +
000906000000'Fin           '                                                      +
000907000000                ) +
000908000000                SEV(0) +
000909000000     /*   No replacement variables defined!                         */ +
000910000000                ALROPT(*NO) +
000911000000                CCSID(65535) +
000912000000                /*  -EOF-  */
000913000000
000914000000     /*-------------------------------------------------------------*/
000915000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0012                    */
000916000000     /* Gauche                                                      */
000917000000     /*-------------------------------------------------------------*/
000918000000
000919000000             RMVMSGD MSGID(KEY0012) MSGF(&LIB/&OBJ)
000920000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000921000000
000922000000             ADDMSGD +
000923000000                MSGID(KEY0012) +
000924000000                MSGF(&LIB/&OBJ) +
000925000000                MSG( +
000926000000'Gauche        '                                                      +
000927000000                ) +
000928000000                SEV(0) +
000929000000     /*   No replacement variables defined!                         */ +
000930000000                ALROPT(*NO) +
000931000000                CCSID(65535) +
000932000000                /*  -EOF-  */
000933000000
000934000000     /*-------------------------------------------------------------*/
000935000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0013                    */
000936000000     /* Droite                                                      */
000937000000     /*-------------------------------------------------------------*/
000938000000
000939000000             RMVMSGD MSGID(KEY0013) MSGF(&LIB/&OBJ)
000940000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000941000000
000942000000             ADDMSGD +
000943000000                MSGID(KEY0013) +
000944000000                MSGF(&LIB/&OBJ) +
000945000000                MSG( +
000946000000'Droite        '                                                      +
000947000000                ) +
000948000000                SEV(0) +
000949000000     /*   No replacement variables defined!                         */ +
000950000000                ALROPT(*NO) +
000951000000                CCSID(65535) +
000952000000                /*  -EOF-  */
000953000000
000954000000     /*-------------------------------------------------------------*/
000955000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0014                    */
000956000000     /* Ligne commande                                              */
000957000000     /*-------------------------------------------------------------*/
000958000000
000959000000             RMVMSGD MSGID(KEY0014) MSGF(&LIB/&OBJ)
000960000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000961000000
000962000000             ADDMSGD +
000963000000                MSGID(KEY0014) +
000964000000                MSGF(&LIB/&OBJ) +
000965000000                MSG( +
000966000000'Ligne commande'                                                      +
000967000000                ) +
000968000000                SEV(0) +
000969000000     /*   No replacement variables defined!                         */ +
000970000000                ALROPT(*NO) +
000971000000                CCSID(65535) +
000972000000                /*  -EOF-  */
000973000000
000974000000     /*-------------------------------------------------------------*/
000975000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0015                    */
000976000000     /* 80/132 colonne                                              */
000977000000     /*-------------------------------------------------------------*/
000978000000
000979000000             RMVMSGD MSGID(KEY0015) MSGF(&LIB/&OBJ)
000980000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
000981000000
000982000000             ADDMSGD +
000983000000                MSGID(KEY0015) +
000984000000                MSGF(&LIB/&OBJ) +
000985000000                MSG( +
000986000000'80/132 colonne'                                                      +
000987000000                ) +
000988000000                SEV(0) +
000989000000     /*   No replacement variables defined!                         */ +
000990000000                ALROPT(*NO) +
000991000000                CCSID(65535) +
000992000000                /*  -EOF-  */
000993000000
000994000000     /*-------------------------------------------------------------*/
000995000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0016                    */
000996000000     /* Autres touches                                              */
000997000000     /*-------------------------------------------------------------*/
000998000000
000999000000             RMVMSGD MSGID(KEY0016) MSGF(&LIB/&OBJ)
001000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001001000000
001002000000             ADDMSGD +
001003000000                MSGID(KEY0016) +
001004000000                MSGF(&LIB/&OBJ) +
001005000000                MSG( +
001006000000'Autres touches'                                                      +
001007000000                ) +
001008000000                SEV(0) +
001009000000     /*   No replacement variables defined!                         */ +
001010000000                ALROPT(*NO) +
001011000000                CCSID(65535) +
001012000000                /*  -EOF-  */
001013000000
001014000000     /*-------------------------------------------------------------*/
001015000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0017                    */
001016000000     /* Page avant                                                  */
001017000000     /*-------------------------------------------------------------*/
001018000000
001019000000             RMVMSGD MSGID(KEY0017) MSGF(&LIB/&OBJ)
001020000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001021000000
001022000000             ADDMSGD +
001023000000                MSGID(KEY0017) +
001024000000                MSGF(&LIB/&OBJ) +
001025000000                MSG( +
001026000000'Page avant    '                                                      +
001027000000                ) +
001028000000                SEV(0) +
001029000000     /*   No replacement variables defined!                         */ +
001030000000                ALROPT(*NO) +
001031000000                CCSID(65535) +
001032000000                /*  -EOF-  */
001033000000
001034000000     /*-------------------------------------------------------------*/
001035000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0018                    */
001036000000     /* Page arriüre                                                */
001037000000     /*-------------------------------------------------------------*/
001038000000
001039000000             RMVMSGD MSGID(KEY0018) MSGF(&LIB/&OBJ)
001040000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001041000000
001042000000             ADDMSGD +
001043000000                MSGID(KEY0018) +
001044000000                MSGF(&LIB/&OBJ) +
001045000000                MSG( +
001046000000'Page arriüre  '                                                      +
001047000000                ) +
001048000000                SEV(0) +
001049000000     /*   No replacement variables defined!                         */ +
001050000000                ALROPT(*NO) +
001051000000                CCSID(65535) +
001052000000                /*  -EOF-  */
001053000000
001054000000     /*-------------------------------------------------------------*/
001055000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0019                    */
001056000000     /* Fixer ligne                                                 */
001057000000     /*-------------------------------------------------------------*/
001058000000
001059000000             RMVMSGD MSGID(KEY0019) MSGF(&LIB/&OBJ)
001060000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001061000000
001062000000             ADDMSGD +
001063000000                MSGID(KEY0019) +
001064000000                MSGF(&LIB/&OBJ) +
001065000000                MSG( +
001066000000'Fixer ligne'                                                         +
001067000000                ) +
001068000000                SEV(0) +
001069000000     /*   No replacement variables defined!                         */ +
001070000000                ALROPT(*NO) +
001071000000                CCSID(65535) +
001072000000                /*  -EOF-  */
001073000000
001074000000     /*-------------------------------------------------------------*/
001075000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0020                    */
001076000000     /* Däfixer ligne                                               */
001077000000     /*-------------------------------------------------------------*/
001078000000
001079000000             RMVMSGD MSGID(KEY0020) MSGF(&LIB/&OBJ)
001080000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001081000000
001082000000             ADDMSGD +
001083000000                MSGID(KEY0020) +
001084000000                MSGF(&LIB/&OBJ) +
001085000000                MSG( +
001086000000'Däfixer ligne'                                                       +
001087000000                ) +
001088000000                SEV(0) +
001089000000     /*   No replacement variables defined!                         */ +
001090000000                ALROPT(*NO) +
001091000000                CCSID(65535) +
001092000000                /*  -EOF-  */
001093000000
001094000000     /*-------------------------------------------------------------*/
001095000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0021                    */
001096000000     /* Modifier                                                    */
001097000000     /*-------------------------------------------------------------*/
001098000000
001099000000             RMVMSGD MSGID(KEY0021) MSGF(&LIB/&OBJ)
001100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001101000000
001102000000             ADDMSGD +
001103000000                MSGID(KEY0021) +
001104000000                MSGF(&LIB/&OBJ) +
001105000000                MSG( +
001106000000'Modifier      '                                                      +
001107000000                ) +
001108000000                SEV(0) +
001109000000     /*   No replacement variables defined!                         */ +
001110000000                ALROPT(*NO) +
001111000000                CCSID(65535) +
001112000000                /*  -EOF-  */
001113000000
001114000000     /*-------------------------------------------------------------*/
001115000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0022                    */
001116000000     /* Dupliquer                                                   */
001117000000     /*-------------------------------------------------------------*/
001118000000
001119000000             RMVMSGD MSGID(KEY0022) MSGF(&LIB/&OBJ)
001120000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001121000000
001122000000             ADDMSGD +
001123000000                MSGID(KEY0022) +
001124000000                MSGF(&LIB/&OBJ) +
001125000000                MSG( +
001126000000'Dupliquer     '                                                      +
001127000000                ) +
001128000000                SEV(0) +
001129000000     /*   No replacement variables defined!                         */ +
001130000000                ALROPT(*NO) +
001131000000                CCSID(65535) +
001132000000                /*  -EOF-  */
001133000000
001134000000     /*-------------------------------------------------------------*/
001135000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0023                    */
001136000000     /* Supprimer                                                   */
001137000000     /*-------------------------------------------------------------*/
001138000000
001139000000             RMVMSGD MSGID(KEY0023) MSGF(&LIB/&OBJ)
001140000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001141000000
001142000000             ADDMSGD +
001143000000                MSGID(KEY0023) +
001144000000                MSGF(&LIB/&OBJ) +
001145000000                MSG( +
001146000000'Supprimer     '                                                      +
001147000000                ) +
001148000000                SEV(0) +
001149000000     /*   No replacement variables defined!                         */ +
001150000000                ALROPT(*NO) +
001151000000                CCSID(65535) +
001152000000                /*  -EOF-  */
001153000000
001154000000     /*-------------------------------------------------------------*/
001155000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0024                    */
001156000000     /* Afficher                                                    */
001157000000     /*-------------------------------------------------------------*/
001158000000
001159000000             RMVMSGD MSGID(KEY0024) MSGF(&LIB/&OBJ)
001160000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001161000000
001162000000             ADDMSGD +
001163000000                MSGID(KEY0024) +
001164000000                MSGF(&LIB/&OBJ) +
001165000000                MSG( +
001166000000'Afficher      '                                                      +
001167000000                ) +
001168000000                SEV(0) +
001169000000     /*   No replacement variables defined!                         */ +
001170000000                ALROPT(*NO) +
001171000000                CCSID(65535) +
001172000000                /*  -EOF-  */
001173000000
001174000000     /*-------------------------------------------------------------*/
001175000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0025                    */
001176000000     /* Paramätrages                                                */
001177000000     /*-------------------------------------------------------------*/
001178000000
001179000000             RMVMSGD MSGID(KEY0025) MSGF(&LIB/&OBJ)
001180000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001181000000
001182000000             ADDMSGD +
001183000000                MSGID(KEY0025) +
001184000000                MSGF(&LIB/&OBJ) +
001185000000                MSG( +
001186000000'Paramätrages  '                                                      +
001187000000                ) +
001188000000                SEV(0) +
001189000000     /*   No replacement variables defined!                         */ +
001190000000                ALROPT(*NO) +
001191000000                CCSID(65535) +
001192000000                /*  -EOF-  */
001193000000
001194000000     /*-------------------------------------------------------------*/
001195000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0026                    */
001196000000     /* Abandonner                                                  */
001197000000     /*-------------------------------------------------------------*/
001198000000
001199000000             RMVMSGD MSGID(KEY0026) MSGF(&LIB/&OBJ)
001200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001201000000
001202000000             ADDMSGD +
001203000000                MSGID(KEY0026) +
001204000000                MSGF(&LIB/&OBJ) +
001205000000                MSG( +
001206000000'Abandonner    '                                                      +
001207000000                ) +
001208000000                SEV(0) +
001209000000     /*   No replacement variables defined!                         */ +
001210000000                ALROPT(*NO) +
001211000000                CCSID(65535) +
001212000000                /*  -EOF-  */
001213000000
001214000000     /*-------------------------------------------------------------*/
001215000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0027                    */
001216000000     /* Enreg. & quitter                                            */
001217000000     /*-------------------------------------------------------------*/
001218000000
001219000000             RMVMSGD MSGID(KEY0027) MSGF(&LIB/&OBJ)
001220000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001221000000
001222000000             ADDMSGD +
001223000000                MSGID(KEY0027) +
001224000000                MSGF(&LIB/&OBJ) +
001225000000                MSG( +
001226000000'Enreg. & quitter'                                                    +
001227000000                ) +
001228000000                SEV(0) +
001229000000     /*   No replacement variables defined!                         */ +
001230000000                ALROPT(*NO) +
001231000000                CCSID(65535) +
001232000000                /*  -EOF-  */
001233000000
001234000000     /*-------------------------------------------------------------*/
001235000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0028                    */
001236000000     /* Fixer col.                                                  */
001237000000     /*-------------------------------------------------------------*/
001238000000
001239000000             RMVMSGD MSGID(KEY0028) MSGF(&LIB/&OBJ)
001240000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001241000000
001242000000             ADDMSGD +
001243000000                MSGID(KEY0028) +
001244000000                MSGF(&LIB/&OBJ) +
001245000000                MSG( +
001246000000'Fixer col.'                                                          +
001247000000                ) +
001248000000                SEV(0) +
001249000000     /*   No replacement variables defined!                         */ +
001250000000                ALROPT(*NO) +
001251000000                CCSID(65535) +
001252000000                /*  -EOF-  */
001253000000
001254000000     /*-------------------------------------------------------------*/
001255000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0029                    */
001256000000     /* Däfixer col.                                                */
001257000000     /*-------------------------------------------------------------*/
001258000000
001259000000             RMVMSGD MSGID(KEY0029) MSGF(&LIB/&OBJ)
001260000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001261000000
001262000000             ADDMSGD +
001263000000                MSGID(KEY0029) +
001264000000                MSGF(&LIB/&OBJ) +
001265000000                MSG( +
001266000000'Däfixer col.'                                                        +
001267000000                ) +
001268000000                SEV(0) +
001269000000     /*   No replacement variables defined!                         */ +
001270000000                ALROPT(*NO) +
001271000000                CCSID(65535) +
001272000000                /*  -EOF-  */
001273000000
001274000000     /*-------------------------------------------------------------*/
001275000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0030                    */
001276000000     /* Fixer col. +/-                                              */
001277000000     /*-------------------------------------------------------------*/
001278000000
001279000000             RMVMSGD MSGID(KEY0030) MSGF(&LIB/&OBJ)
001280000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001281000000
001282000000             ADDMSGD +
001283000000                MSGID(KEY0030) +
001284000000                MSGF(&LIB/&OBJ) +
001285000000                MSG( +
001286000000'Fixer col. +/-'                                                      +
001287000000                ) +
001288000000                SEV(0) +
001289000000     /*   No replacement variables defined!                         */ +
001290000000                ALROPT(*NO) +
001291000000                CCSID(65535) +
001292000000                /*  -EOF-  */
001293000000
001294000000     /*-------------------------------------------------------------*/
001295000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0031                    */
001296000000     /* Lig. en couleur                                             */
001297000000     /*-------------------------------------------------------------*/
001298000000
001299000000             RMVMSGD MSGID(KEY0031) MSGF(&LIB/&OBJ)
001300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001301000000
001302000000             ADDMSGD +
001303000000                MSGID(KEY0031) +
001304000000                MSGF(&LIB/&OBJ) +
001305000000                MSG( +
001306000000'Lig. en couleur'                                                     +
001307000000                ) +
001308000000                SEV(0) +
001309000000     /*   No replacement variables defined!                         */ +
001310000000                ALROPT(*NO) +
001311000000                CCSID(65535) +
001312000000                /*  -EOF-  */
001313000000
001314000000     /*-------------------------------------------------------------*/
001315000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0032                    */
001316000000     /* Lig. monochrome                                             */
001317000000     /*-------------------------------------------------------------*/
001318000000
001319000000             RMVMSGD MSGID(KEY0032) MSGF(&LIB/&OBJ)
001320000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001321000000
001322000000             ADDMSGD +
001323000000                MSGID(KEY0032) +
001324000000                MSGF(&LIB/&OBJ) +
001325000000                MSG( +
001326000000'Lig. monochrome'                                                     +
001327000000                ) +
001328000000                SEV(0) +
001329000000     /*   No replacement variables defined!                         */ +
001330000000                ALROPT(*NO) +
001331000000                CCSID(65535) +
001332000000                /*  -EOF-  */
001333000000
001334000000     /*-------------------------------------------------------------*/
001335000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0033                    */
001336000000     /* Couleur/mono.                                               */
001337000000     /*-------------------------------------------------------------*/
001338000000
001339000000             RMVMSGD MSGID(KEY0033) MSGF(&LIB/&OBJ)
001340000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001341000000
001342000000             ADDMSGD +
001343000000                MSGID(KEY0033) +
001344000000                MSGF(&LIB/&OBJ) +
001345000000                MSG( +
001346000000'Couleur/mono.'                                                       +
001347000000                ) +
001348000000                SEV(0) +
001349000000     /*   No replacement variables defined!                         */ +
001350000000                ALROPT(*NO) +
001351000000                CCSID(65535) +
001352000000                /*  -EOF-  */
001353000000
001354000000     /*-------------------------------------------------------------*/
001355000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0034                    */
001356000000     /* Tous                                                        */
001357000000     /*-------------------------------------------------------------*/
001358000000
001359000000             RMVMSGD MSGID(KEY0034) MSGF(&LIB/&OBJ)
001360000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001361000000
001362000000             ADDMSGD +
001363000000                MSGID(KEY0034) +
001364000000                MSGF(&LIB/&OBJ) +
001365000000                MSG( +
001366000000'Tous          '                                                      +
001367000000                ) +
001368000000                SEV(0) +
001369000000     /*   No replacement variables defined!                         */ +
001370000000                ALROPT(*NO) +
001371000000                CCSID(65535) +
001372000000                /*  -EOF-  */
001373000000
001374000000     /*-------------------------------------------------------------*/
001375000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0035                    */
001376000000     /* Plus d'options                                              */
001377000000     /*-------------------------------------------------------------*/
001378000000
001379000000             RMVMSGD MSGID(KEY0035) MSGF(&LIB/&OBJ)
001380000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001381000000
001382000000             ADDMSGD +
001383000000                MSGID(KEY0035) +
001384000000                MSGF(&LIB/&OBJ) +
001385000000                MSG( +
001386000000'Plus d''options'                                                     +
001387000000                ) +
001388000000                SEV(0) +
001389000000     /*   No replacement variables defined!                         */ +
001390000000                ALROPT(*NO) +
001391000000                CCSID(65535) +
001392000000                /*  -EOF-  */
001393000000
001394000000     /*-------------------------------------------------------------*/
001395000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0036                    */
001396000000     /* Copier vers                                                 */
001397000000     /*-------------------------------------------------------------*/
001398000000
001399000000             RMVMSGD MSGID(KEY0036) MSGF(&LIB/&OBJ)
001400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001401000000
001402000000             ADDMSGD +
001403000000                MSGID(KEY0036) +
001404000000                MSGF(&LIB/&OBJ) +
001405000000                MSG( +
001406000000'Copier vers   '                                                      +
001407000000                ) +
001408000000                SEV(0) +
001409000000     /*   No replacement variables defined!                         */ +
001410000000                ALROPT(*NO) +
001411000000                CCSID(65535) +
001412000000                /*  -EOF-  */
001413000000
001414000000     /*-------------------------------------------------------------*/
001415000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0037                    */
001416000000     /* Sälect. champ                                               */
001417000000     /*-------------------------------------------------------------*/
001418000000
001419000000             RMVMSGD MSGID(KEY0037) MSGF(&LIB/&OBJ)
001420000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001421000000
001422000000             ADDMSGD +
001423000000                MSGID(KEY0037) +
001424000000                MSGF(&LIB/&OBJ) +
001425000000                MSG( +
001426000000'Sälect. champ'                                                       +
001427000000                ) +
001428000000                SEV(0) +
001429000000     /*   No replacement variables defined!                         */ +
001430000000                ALROPT(*NO) +
001431000000                CCSID(65535) +
001432000000                /*  -EOF-  */
001433000000
001434000000     /*-------------------------------------------------------------*/
001435000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0038                    */
001436000000     /* Libärer champ                                               */
001437000000     /*-------------------------------------------------------------*/
001438000000
001439000000             RMVMSGD MSGID(KEY0038) MSGF(&LIB/&OBJ)
001440000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001441000000
001442000000             ADDMSGD +
001443000000                MSGID(KEY0038) +
001444000000                MSGF(&LIB/&OBJ) +
001445000000                MSG( +
001446000000'Libärer champ'                                                       +
001447000000                ) +
001448000000                SEV(0) +
001449000000     /*   No replacement variables defined!                         */ +
001450000000                ALROPT(*NO) +
001451000000                CCSID(65535) +
001452000000                /*  -EOF-  */
001453000000
001454000000     /*-------------------------------------------------------------*/
001455000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0039                    */
001456000000     /* Minuscule                                                   */
001457000000     /*-------------------------------------------------------------*/
001458000000
001459000000             RMVMSGD MSGID(KEY0039) MSGF(&LIB/&OBJ)
001460000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001461000000
001462000000             ADDMSGD +
001463000000                MSGID(KEY0039) +
001464000000                MSGF(&LIB/&OBJ) +
001465000000                MSG( +
001466000000'Minuscule '                                                          +
001467000000                ) +
001468000000                SEV(0) +
001469000000     /*   No replacement variables defined!                         */ +
001470000000                ALROPT(*NO) +
001471000000                CCSID(65535) +
001472000000                /*  -EOF-  */
001473000000
001474000000     /*-------------------------------------------------------------*/
001475000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0040                    */
001476000000     /* Majuscule                                                   */
001477000000     /*-------------------------------------------------------------*/
001478000000
001479000000             RMVMSGD MSGID(KEY0040) MSGF(&LIB/&OBJ)
001480000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001481000000
001482000000             ADDMSGD +
001483000000                MSGID(KEY0040) +
001484000000                MSGF(&LIB/&OBJ) +
001485000000                MSG( +
001486000000'Majuscule '                                                          +
001487000000                ) +
001488000000                SEV(0) +
001489000000     /*   No replacement variables defined!                         */ +
001490000000                ALROPT(*NO) +
001491000000                CCSID(65535) +
001492000000                /*  -EOF-  */
001493000000
001494000000     /*-------------------------------------------------------------*/
001495000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0041                    */
001496000000     /* Maj. / Min.                                                 */
001497000000     /*-------------------------------------------------------------*/
001498000000
001499000000             RMVMSGD MSGID(KEY0041) MSGF(&LIB/&OBJ)
001500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001501000000
001502000000             ADDMSGD +
001503000000                MSGID(KEY0041) +
001504000000                MSGF(&LIB/&OBJ) +
001505000000                MSG( +
001506000000'Maj. / Min.'                                                         +
001507000000                ) +
001508000000                SEV(0) +
001509000000     /*   No replacement variables defined!                         */ +
001510000000                ALROPT(*NO) +
001511000000                CCSID(65535) +
001512000000                /*  -EOF-  */
001513000000
001514000000     /*-------------------------------------------------------------*/
001515000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0042                    */
001516000000     /* Page d'accueil                                              */
001517000000     /*-------------------------------------------------------------*/
001518000000
001519000000             RMVMSGD MSGID(KEY0042) MSGF(&LIB/&OBJ)
001520000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001521000000
001522000000             ADDMSGD +
001523000000                MSGID(KEY0042) +
001524000000                MSGF(&LIB/&OBJ) +
001525000000                MSG( +
001526000000'Page d''accueil'                                                     +
001527000000                ) +
001528000000                SEV(0) +
001529000000     /*   No replacement variables defined!                         */ +
001530000000                ALROPT(*NO) +
001531000000                CCSID(65535) +
001532000000                /*  -EOF-  */
001533000000
001534000000     /*-------------------------------------------------------------*/
001535000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0043                    */
001536000000     /* Pas de page                                                 */
001537000000     /*-------------------------------------------------------------*/
001538000000
001539000000             RMVMSGD MSGID(KEY0043) MSGF(&LIB/&OBJ)
001540000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001541000000
001542000000             ADDMSGD +
001543000000                MSGID(KEY0043) +
001544000000                MSGF(&LIB/&OBJ) +
001545000000                MSG( +
001546000000'Pas de page'                                                         +
001547000000                ) +
001548000000                SEV(0) +
001549000000     /*   No replacement variables defined!                         */ +
001550000000                ALROPT(*NO) +
001551000000                CCSID(65535) +
001552000000                /*  -EOF-  */
001553000000
001554000000     /*-------------------------------------------------------------*/
001555000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0044                    */
001556000000     /* Page gauche                                                 */
001557000000     /*-------------------------------------------------------------*/
001558000000
001559000000             RMVMSGD MSGID(KEY0044) MSGF(&LIB/&OBJ)
001560000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001561000000
001562000000             ADDMSGD +
001563000000                MSGID(KEY0044) +
001564000000                MSGF(&LIB/&OBJ) +
001565000000                MSG( +
001566000000'Page gauche'                                                         +
001567000000                ) +
001568000000                SEV(0) +
001569000000     /*   No replacement variables defined!                         */ +
001570000000                ALROPT(*NO) +
001571000000                CCSID(65535) +
001572000000                /*  -EOF-  */
001573000000
001574000000     /*-------------------------------------------------------------*/
001575000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0045                    */
001576000000     /* Page droite                                                 */
001577000000     /*-------------------------------------------------------------*/
001578000000
001579000000             RMVMSGD MSGID(KEY0045) MSGF(&LIB/&OBJ)
001580000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001581000000
001582000000             ADDMSGD +
001583000000                MSGID(KEY0045) +
001584000000                MSGF(&LIB/&OBJ) +
001585000000                MSG( +
001586000000'Page droite'                                                         +
001587000000                ) +
001588000000                SEV(0) +
001589000000     /*   No replacement variables defined!                         */ +
001590000000                ALROPT(*NO) +
001591000000                CCSID(65535) +
001592000000                /*  -EOF-  */
001593000000
001594000000     /*-------------------------------------------------------------*/
001595000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0046                    */
001596000000     /* Repäter                                                     */
001597000000     /*-------------------------------------------------------------*/
001598000000
001599000000             RMVMSGD MSGID(KEY0046) MSGF(&LIB/&OBJ)
001600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001601000000
001602000000             ADDMSGD +
001603000000                MSGID(KEY0046) +
001604000000                MSGF(&LIB/&OBJ) +
001605000000                MSG( +
001606000000'Repäter'                                                             +
001607000000                ) +
001608000000                SEV(0) +
001609000000     /*   No replacement variables defined!                         */ +
001610000000                ALROPT(*NO) +
001611000000                CCSID(65535) +
001612000000                /*  -EOF-  */
001613000000
001614000000     /*-------------------------------------------------------------*/
001615000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0047                    */
001616000000     /* Reconstruire                                                */
001617000000     /*-------------------------------------------------------------*/
001618000000
001619000000             RMVMSGD MSGID(KEY0047) MSGF(&LIB/&OBJ)
001620000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001621000000
001622000000             ADDMSGD +
001623000000                MSGID(KEY0047) +
001624000000                MSGF(&LIB/&OBJ) +
001625000000                MSG( +
001626000000'Reconstruire'                                                        +
001627000000                ) +
001628000000                SEV(0) +
001629000000     /*   No replacement variables defined!                         */ +
001630000000                ALROPT(*NO) +
001631000000                CCSID(65535) +
001632000000                /*  -EOF-  */
001633000000
001634000000     /*-------------------------------------------------------------*/
001635000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0048                    */
001636000000     /* Däfixer toutes les lignes                                   */
001637000000     /*-------------------------------------------------------------*/
001638000000
001639000000             RMVMSGD MSGID(KEY0048) MSGF(&LIB/&OBJ)
001640000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001641000000
001642000000             ADDMSGD +
001643000000                MSGID(KEY0048) +
001644000000                MSGF(&LIB/&OBJ) +
001645000000                MSG( +
001646000000'Däfixer toutes les lignes'                                           +
001647000000                ) +
001648000000                SEV(0) +
001649000000     /*   No replacement variables defined!                         */ +
001650000000                ALROPT(*NO) +
001651000000                CCSID(65535) +
001652000000                /*  -EOF-  */
001653000000
001654000000     /*-------------------------------------------------------------*/
001655000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0049                    */
001656000000     /* Däfixer toutes les colonnes                                 */
001657000000     /*-------------------------------------------------------------*/
001658000000
001659000000             RMVMSGD MSGID(KEY0049) MSGF(&LIB/&OBJ)
001660000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001661000000
001662000000             ADDMSGD +
001663000000                MSGID(KEY0049) +
001664000000                MSGF(&LIB/&OBJ) +
001665000000                MSG( +
001666000000'Däfixer toutes les colonnes'                                         +
001667000000                ) +
001668000000                SEV(0) +
001669000000     /*   No replacement variables defined!                         */ +
001670000000                ALROPT(*NO) +
001671000000                CCSID(65535) +
001672000000                /*  -EOF-  */
001673000000
001674000000     /*-------------------------------------------------------------*/
001675000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0050                    */
001676000000     /* Maquette                                                    */
001677000000     /*-------------------------------------------------------------*/
001678000000
001679000000             RMVMSGD MSGID(KEY0050) MSGF(&LIB/&OBJ)
001680000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001681000000
001682000000             ADDMSGD +
001683000000                MSGID(KEY0050) +
001684000000                MSGF(&LIB/&OBJ) +
001685000000                MSG( +
001686000000'Maquette'                                                            +
001687000000                ) +
001688000000                SEV(0) +
001689000000     /*   No replacement variables defined!                         */ +
001690000000                ALROPT(*NO) +
001691000000                CCSID(65535) +
001692000000                /*  -EOF-  */
001693000000
001694000000     /*-------------------------------------------------------------*/
001695000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0051                    */
001696000000     /* Touches flott.                                              */
001697000000     /*-------------------------------------------------------------*/
001698000000
001699000000             RMVMSGD MSGID(KEY0051) MSGF(&LIB/&OBJ)
001700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001701000000
001702000000             ADDMSGD +
001703000000                MSGID(KEY0051) +
001704000000                MSGF(&LIB/&OBJ) +
001705000000                MSG( +
001706000000'Touches flott.'                                                      +
001707000000                ) +
001708000000                SEV(0) +
001709000000     /*   No replacement variables defined!                         */ +
001710000000                ALROPT(*NO) +
001711000000                CCSID(65535) +
001712000000                /*  -EOF-  */
001713000000
001714000000     /*-------------------------------------------------------------*/
001715000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0052                    */
001716000000     /* Sälectionner                                                */
001717000000     /*-------------------------------------------------------------*/
001718000000
001719000000             RMVMSGD MSGID(KEY0052) MSGF(&LIB/&OBJ)
001720000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001721000000
001722000000             ADDMSGD +
001723000000                MSGID(KEY0052) +
001724000000                MSGF(&LIB/&OBJ) +
001725000000                MSG( +
001726000000'Sälectionner'                                                        +
001727000000                ) +
001728000000                SEV(0) +
001729000000     /*   No replacement variables defined!                         */ +
001730000000                ALROPT(*NO) +
001731000000                CCSID(65535) +
001732000000                /*  -EOF-  */
001733000000
001734000000     /*-------------------------------------------------------------*/
001735000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0053                    */
001736000000     /* Sälection suivante                                          */
001737000000     /*-------------------------------------------------------------*/
001738000000
001739000000             RMVMSGD MSGID(KEY0053) MSGF(&LIB/&OBJ)
001740000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001741000000
001742000000             ADDMSGD +
001743000000                MSGID(KEY0053) +
001744000000                MSGF(&LIB/&OBJ) +
001745000000                MSG( +
001746000000'Sälection suivante'                                                  +
001747000000                ) +
001748000000                SEV(0) +
001749000000     /*   No replacement variables defined!                         */ +
001750000000                ALROPT(*NO) +
001751000000                CCSID(65535) +
001752000000                /*  -EOF-  */
001753000000
001754000000     /*-------------------------------------------------------------*/
001755000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0054                    */
001756000000     /* Sälection präcädente                                        */
001757000000     /*-------------------------------------------------------------*/
001758000000
001759000000             RMVMSGD MSGID(KEY0054) MSGF(&LIB/&OBJ)
001760000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001761000000
001762000000             ADDMSGD +
001763000000                MSGID(KEY0054) +
001764000000                MSGF(&LIB/&OBJ) +
001765000000                MSG( +
001766000000'Sälection präcädente'                                                +
001767000000                ) +
001768000000                SEV(0) +
001769000000     /*   No replacement variables defined!                         */ +
001770000000                ALROPT(*NO) +
001771000000                CCSID(65535) +
001772000000                /*  -EOF-  */
001773000000
001774000000     /*-------------------------------------------------------------*/
001775000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0055                    */
001776000000     /* Relations                                                   */
001777000000     /*-------------------------------------------------------------*/
001778000000
001779000000             RMVMSGD MSGID(KEY0055) MSGF(&LIB/&OBJ)
001780000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001781000000
001782000000             ADDMSGD +
001783000000                MSGID(KEY0055) +
001784000000                MSGF(&LIB/&OBJ) +
001785000000                MSG( +
001786000000'Relations'                                                           +
001787000000                ) +
001788000000                SEV(0) +
001789000000     /*   No replacement variables defined!                         */ +
001790000000                ALROPT(*NO) +
001791000000                CCSID(65535) +
001792000000                /*  -EOF-  */
001793000000
001794000000     /*-------------------------------------------------------------*/
001795000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0056                    */
001796000000     /* Guide                                                       */
001797000000     /*-------------------------------------------------------------*/
001798000000
001799000000             RMVMSGD MSGID(KEY0056) MSGF(&LIB/&OBJ)
001800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001801000000
001802000000             ADDMSGD +
001803000000                MSGID(KEY0056) +
001804000000                MSGF(&LIB/&OBJ) +
001805000000                MSG( +
001806000000'Guide '                                                              +
001807000000                ) +
001808000000                SEV(0) +
001809000000     /*   No replacement variables defined!                         */ +
001810000000                ALROPT(*NO) +
001811000000                CCSID(65535) +
001812000000                /*  -EOF-  */
001813000000
001814000000     /*-------------------------------------------------------------*/
001815000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0057                    */
001816000000     /* Ordre clä                                                   */
001817000000     /*-------------------------------------------------------------*/
001818000000
001819000000             RMVMSGD MSGID(KEY0057) MSGF(&LIB/&OBJ)
001820000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001821000000
001822000000             ADDMSGD +
001823000000                MSGID(KEY0057) +
001824000000                MSGF(&LIB/&OBJ) +
001825000000                MSG( +
001826000000'Ordre clä'                                                           +
001827000000                ) +
001828000000                SEV(0) +
001829000000     /*   No replacement variables defined!                         */ +
001830000000                ALROPT(*NO) +
001831000000                CCSID(65535) +
001832000000                /*  -EOF-  */
001833000000
001834000000     /*-------------------------------------------------------------*/
001835000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0058                    */
001836000000     /* Ordre enreg.                                                */
001837000000     /*-------------------------------------------------------------*/
001838000000
001839000000             RMVMSGD MSGID(KEY0058) MSGF(&LIB/&OBJ)
001840000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001841000000
001842000000             ADDMSGD +
001843000000                MSGID(KEY0058) +
001844000000                MSGF(&LIB/&OBJ) +
001845000000                MSG( +
001846000000'Ordre enreg.'                                                        +
001847000000                ) +
001848000000                SEV(0) +
001849000000     /*   No replacement variables defined!                         */ +
001850000000                ALROPT(*NO) +
001851000000                CCSID(65535) +
001852000000                /*  -EOF-  */
001853000000
001854000000     /*-------------------------------------------------------------*/
001855000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0059                    */
001856000000     /* Tri Clef/NÄenregistrement                                   */
001857000000     /*-------------------------------------------------------------*/
001858000000
001859000000             RMVMSGD MSGID(KEY0059) MSGF(&LIB/&OBJ)
001860000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001861000000
001862000000             ADDMSGD +
001863000000                MSGID(KEY0059) +
001864000000                MSGF(&LIB/&OBJ) +
001865000000                MSG( +
001866000000'Tri Clef/NÄenregistrement'                                           +
001867000000                ) +
001868000000                SEV(0) +
001869000000     /*   No replacement variables defined!                         */ +
001870000000                ALROPT(*NO) +
001871000000                CCSID(65535) +
001872000000                /*  -EOF-  */
001873000000
001874000000     /*-------------------------------------------------------------*/
001875000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0060                    */
001876000000     /* Editeur Hexa                                                */
001877000000     /*-------------------------------------------------------------*/
001878000000
001879000000             RMVMSGD MSGID(KEY0060) MSGF(&LIB/&OBJ)
001880000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001881000000
001882000000             ADDMSGD +
001883000000                MSGID(KEY0060) +
001884000000                MSGF(&LIB/&OBJ) +
001885000000                MSG( +
001886000000'Editeur Hexa'                                                        +
001887000000                ) +
001888000000                SEV(0) +
001889000000     /*   No replacement variables defined!                         */ +
001890000000                ALROPT(*NO) +
001891000000                CCSID(65535) +
001892000000                /*  -EOF-  */
001893000000
001894000000     /*-------------------------------------------------------------*/
001895000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0061                    */
001896000000     /* Infos                                                       */
001897000000     /*-------------------------------------------------------------*/
001898000000
001899000000             RMVMSGD MSGID(KEY0061) MSGF(&LIB/&OBJ)
001900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001901000000
001902000000             ADDMSGD +
001903000000                MSGID(KEY0061) +
001904000000                MSGF(&LIB/&OBJ) +
001905000000                MSG( +
001906000000'Infos'                                                               +
001907000000                ) +
001908000000                SECLVL( +
001909000000'À propos de'                                                         +
001910000000                ) +
001911000000                SEV(0) +
001912000000     /*   No replacement variables defined!                         */ +
001913000000                ALROPT(*NO) +
001914000000                CCSID(65535) +
001915000000                /*  -EOF-  */
001916000000
001917000000     /*-------------------------------------------------------------*/
001918000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0062                    */
001919000000     /* Fixer champs                                                */
001920000000     /*-------------------------------------------------------------*/
001921000000
001922000000             RMVMSGD MSGID(KEY0062) MSGF(&LIB/&OBJ)
001923000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001924000000
001925000000             ADDMSGD +
001926000000                MSGID(KEY0062) +
001927000000                MSGF(&LIB/&OBJ) +
001928000000                MSG( +
001929000000'Fixer champs'                                                        +
001930000000                ) +
001931000000                SEV(0) +
001932000000     /*   No replacement variables defined!                         */ +
001933000000                ALROPT(*NO) +
001934000000                CCSID(65535) +
001935000000                /*  -EOF-  */
001936000000
001937000000     /*-------------------------------------------------------------*/
001938000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0063                    */
001939000000     /* Efface tout                                                 */
001940000000     /*-------------------------------------------------------------*/
001941000000
001942000000             RMVMSGD MSGID(KEY0063) MSGF(&LIB/&OBJ)
001943000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001944000000
001945000000             ADDMSGD +
001946000000                MSGID(KEY0063) +
001947000000                MSGF(&LIB/&OBJ) +
001948000000                MSG( +
001949000000'Efface tout'                                                         +
001950000000                ) +
001951000000                SEV(0) +
001952000000     /*   No replacement variables defined!                         */ +
001953000000                ALROPT(*NO) +
001954000000                CCSID(65535) +
001955000000                /*  -EOF-  */
001956000000
001957000000     /*-------------------------------------------------------------*/
001958000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0064                    */
001959000000     /* Affichage normal                                            */
001960000000     /*-------------------------------------------------------------*/
001961000000
001962000000             RMVMSGD MSGID(KEY0064) MSGF(&LIB/&OBJ)
001963000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001964000000
001965000000             ADDMSGD +
001966000000                MSGID(KEY0064) +
001967000000                MSGF(&LIB/&OBJ) +
001968000000                MSG( +
001969000000'Affichage normal'                                                    +
001970000000                ) +
001971000000                SEV(0) +
001972000000     /*   No replacement variables defined!                         */ +
001973000000                ALROPT(*NO) +
001974000000                CCSID(65535) +
001975000000                /*  -EOF-  */
001976000000
001977000000     /*-------------------------------------------------------------*/
001978000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0065                    */
001979000000     /* Affichage hexa                                              */
001980000000     /*-------------------------------------------------------------*/
001981000000
001982000000             RMVMSGD MSGID(KEY0065) MSGF(&LIB/&OBJ)
001983000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
001984000000
001985000000             ADDMSGD +
001986000000                MSGID(KEY0065) +
001987000000                MSGF(&LIB/&OBJ) +
001988000000                MSG( +
001989000000'Affichage hexa'                                                      +
001990000000                ) +
001991000000                SEV(0) +
001992000000     /*   No replacement variables defined!                         */ +
001993000000                ALROPT(*NO) +
001994000000                CCSID(65535) +
001995000000                /*  -EOF-  */
001996000000
001997000000     /*-------------------------------------------------------------*/
001998000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0066                    */
001999000000     /* Hexa/car.                                                   */
002000000000     /*-------------------------------------------------------------*/
002001000000
002002000000             RMVMSGD MSGID(KEY0066) MSGF(&LIB/&OBJ)
002003000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002004000000
002005000000             ADDMSGD +
002006000000                MSGID(KEY0066) +
002007000000                MSGF(&LIB/&OBJ) +
002008000000                MSG( +
002009000000'Hexa/car.'                                                           +
002010000000                ) +
002011000000                SEV(0) +
002012000000     /*   No replacement variables defined!                         */ +
002013000000                ALROPT(*NO) +
002014000000                CCSID(65535) +
002015000000                /*  -EOF-  */
002016000000
002017000000     /*-------------------------------------------------------------*/
002018000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0067                    */
002019000000     /* Sälection SQL                                               */
002020000000     /*-------------------------------------------------------------*/
002021000000
002022000000             RMVMSGD MSGID(KEY0067) MSGF(&LIB/&OBJ)
002023000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002024000000
002025000000             ADDMSGD +
002026000000                MSGID(KEY0067) +
002027000000                MSGF(&LIB/&OBJ) +
002028000000                MSG( +
002029000000'Sälection SQL'                                                       +
002030000000                ) +
002031000000                SEV(0) +
002032000000     /*   No replacement variables defined!                         */ +
002033000000                ALROPT(*NO) +
002034000000                CCSID(65535) +
002035000000                /*  -EOF-  */
002036000000
002037000000     /*-------------------------------------------------------------*/
002038000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0068                    */
002039000000     /* Ins.champs clef                                             */
002040000000     /*-------------------------------------------------------------*/
002041000000
002042000000             RMVMSGD MSGID(KEY0068) MSGF(&LIB/&OBJ)
002043000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002044000000
002045000000             ADDMSGD +
002046000000                MSGID(KEY0068) +
002047000000                MSGF(&LIB/&OBJ) +
002048000000                MSG( +
002049000000'Ins.champs clef'                                                     +
002050000000                ) +
002051000000                SEV(0) +
002052000000     /*   No replacement variables defined!                         */ +
002053000000                ALROPT(*NO) +
002054000000                CCSID(65535) +
002055000000                /*  -EOF-  */
002056000000
002057000000     /*-------------------------------------------------------------*/
002058000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0069                    */
002059000000     /* Sauvegarde environnement                                    */
002060000000     /*-------------------------------------------------------------*/
002061000000
002062000000             RMVMSGD MSGID(KEY0069) MSGF(&LIB/&OBJ)
002063000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002064000000
002065000000             ADDMSGD +
002066000000                MSGID(KEY0069) +
002067000000                MSGF(&LIB/&OBJ) +
002068000000                MSG( +
002069000000'Sauvegarde environnement'                                            +
002070000000                ) +
002071000000                SEV(0) +
002072000000     /*   No replacement variables defined!                         */ +
002073000000                ALROPT(*NO) +
002074000000                CCSID(65535) +
002075000000                /*  -EOF-  */
002076000000
002077000000     /*-------------------------------------------------------------*/
002078000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0070                    */
002079000000     /* Charge environnement                                        */
002080000000     /*-------------------------------------------------------------*/
002081000000
002082000000             RMVMSGD MSGID(KEY0070) MSGF(&LIB/&OBJ)
002083000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002084000000
002085000000             ADDMSGD +
002086000000                MSGID(KEY0070) +
002087000000                MSGF(&LIB/&OBJ) +
002088000000                MSG( +
002089000000'Charge environnement'                                                +
002090000000                ) +
002091000000                SEV(0) +
002092000000     /*   No replacement variables defined!                         */ +
002093000000                ALROPT(*NO) +
002094000000                CCSID(65535) +
002095000000                /*  -EOF-  */
002096000000
002097000000     /*-------------------------------------------------------------*/
002098000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0071                    */
002099000000     /* Supprime environnement                                      */
002100000000     /*-------------------------------------------------------------*/
002101000000
002102000000             RMVMSGD MSGID(KEY0071) MSGF(&LIB/&OBJ)
002103000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002104000000
002105000000             ADDMSGD +
002106000000                MSGID(KEY0071) +
002107000000                MSGF(&LIB/&OBJ) +
002108000000                MSG( +
002109000000'Supprime environnement'                                              +
002110000000                ) +
002111000000                SEV(0) +
002112000000     /*   No replacement variables defined!                         */ +
002113000000                ALROPT(*NO) +
002114000000                CCSID(65535) +
002115000000                /*  -EOF-  */
002116000000
002117000000     /*-------------------------------------------------------------*/
002118000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0072                    */
002119000000     /* Säquence de tri                                             */
002120000000     /*-------------------------------------------------------------*/
002121000000
002122000000             RMVMSGD MSGID(KEY0072) MSGF(&LIB/&OBJ)
002123000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002124000000
002125000000             ADDMSGD +
002126000000                MSGID(KEY0072) +
002127000000                MSGF(&LIB/&OBJ) +
002128000000                MSG( +
002129000000'Säquence de tri'                                                     +
002130000000                ) +
002131000000                SEV(0) +
002132000000     /*   No replacement variables defined!                         */ +
002133000000                ALROPT(*NO) +
002134000000                CCSID(65535) +
002135000000                /*  -EOF-  */
002136000000
002137000000     /*-------------------------------------------------------------*/
002138000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0073                    */
002139000000     /* Oui                                                         */
002140000000     /*-------------------------------------------------------------*/
002141000000
002142000000             RMVMSGD MSGID(KEY0073) MSGF(&LIB/&OBJ)
002143000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002144000000
002145000000             ADDMSGD +
002146000000                MSGID(KEY0073) +
002147000000                MSGF(&LIB/&OBJ) +
002148000000                MSG( +
002149000000'Oui'                                                                 +
002150000000                ) +
002151000000                SEV(0) +
002152000000     /*   No replacement variables defined!                         */ +
002153000000                ALROPT(*NO) +
002154000000                CCSID(65535) +
002155000000                /*  -EOF-  */
002156000000
002157000000     /*-------------------------------------------------------------*/
002158000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0074                    */
002159000000     /* Non                                                         */
002160000000     /*-------------------------------------------------------------*/
002161000000
002162000000             RMVMSGD MSGID(KEY0074) MSGF(&LIB/&OBJ)
002163000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002164000000
002165000000             ADDMSGD +
002166000000                MSGID(KEY0074) +
002167000000                MSGF(&LIB/&OBJ) +
002168000000                MSG( +
002169000000'Non'                                                                 +
002170000000                ) +
002171000000                SEV(0) +
002172000000     /*   No replacement variables defined!                         */ +
002173000000                ALROPT(*NO) +
002174000000                CCSID(65535) +
002175000000                /*  -EOF-  */
002176000000
002177000000     /*-------------------------------------------------------------*/
002178000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0075                    */
002179000000     /* OK                                                          */
002180000000     /*-------------------------------------------------------------*/
002181000000
002182000000             RMVMSGD MSGID(KEY0075) MSGF(&LIB/&OBJ)
002183000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002184000000
002185000000             ADDMSGD +
002186000000                MSGID(KEY0075) +
002187000000                MSGF(&LIB/&OBJ) +
002188000000                MSG( +
002189000000'OK'                                                                  +
002190000000                ) +
002191000000                SEV(0) +
002192000000     /*   No replacement variables defined!                         */ +
002193000000                ALROPT(*NO) +
002194000000                CCSID(65535) +
002195000000                /*  -EOF-  */
002196000000
002197000000     /*-------------------------------------------------------------*/
002198000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0076                    */
002199000000     /* Prem. Pos.                                                  */
002200000000     /*-------------------------------------------------------------*/
002201000000
002202000000             RMVMSGD MSGID(KEY0076) MSGF(&LIB/&OBJ)
002203000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002204000000
002205000000             ADDMSGD +
002206000000                MSGID(KEY0076) +
002207000000                MSGF(&LIB/&OBJ) +
002208000000                MSG( +
002209000000'Prem. Pos.'                                                          +
002210000000                ) +
002211000000                SEV(0) +
002212000000     /*   No replacement variables defined!                         */ +
002213000000                ALROPT(*NO) +
002214000000                CCSID(65535) +
002215000000                /*  -EOF-  */
002216000000
002217000000     /*-------------------------------------------------------------*/
002218000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0077                    */
002219000000     /* Dern. Pos.                                                  */
002220000000     /*-------------------------------------------------------------*/
002221000000
002222000000             RMVMSGD MSGID(KEY0077) MSGF(&LIB/&OBJ)
002223000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002224000000
002225000000             ADDMSGD +
002226000000                MSGID(KEY0077) +
002227000000                MSGF(&LIB/&OBJ) +
002228000000                MSG( +
002229000000'Dern. Pos.'                                                          +
002230000000                ) +
002231000000                SEV(0) +
002232000000     /*   No replacement variables defined!                         */ +
002233000000                ALROPT(*NO) +
002234000000                CCSID(65535) +
002235000000                /*  -EOF-  */
002236000000
002237000000     /*-------------------------------------------------------------*/
002238000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0078                    */
002239000000     /* Environnement                                               */
002240000000     /*-------------------------------------------------------------*/
002241000000
002242000000             RMVMSGD MSGID(KEY0078) MSGF(&LIB/&OBJ)
002243000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002244000000
002245000000             ADDMSGD +
002246000000                MSGID(KEY0078) +
002247000000                MSGF(&LIB/&OBJ) +
002248000000                MSG( +
002249000000'Environnement'                                                       +
002250000000                ) +
002251000000                SEV(0) +
002252000000     /*   No replacement variables defined!                         */ +
002253000000                ALROPT(*NO) +
002254000000                CCSID(65535) +
002255000000                /*  -EOF-  */
002256000000
002257000000     /*-------------------------------------------------------------*/
002258000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0079                    */
002259000000     /* Maquette seule                                              */
002260000000     /*-------------------------------------------------------------*/
002261000000
002262000000             RMVMSGD MSGID(KEY0079) MSGF(&LIB/&OBJ)
002263000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002264000000
002265000000             ADDMSGD +
002266000000                MSGID(KEY0079) +
002267000000                MSGF(&LIB/&OBJ) +
002268000000                MSG( +
002269000000'Maquette seule'                                                      +
002270000000                ) +
002271000000                SEV(0) +
002272000000     /*   No replacement variables defined!                         */ +
002273000000                ALROPT(*NO) +
002274000000                CCSID(65535) +
002275000000                /*  -EOF-  */
002276000000
002277000000     /*-------------------------------------------------------------*/
002278000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0080                    */
002279000000     /* NULL acceptä                                                */
002280000000     /*-------------------------------------------------------------*/
002281000000
002282000000             RMVMSGD MSGID(KEY0080) MSGF(&LIB/&OBJ)
002283000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002284000000
002285000000             ADDMSGD +
002286000000                MSGID(KEY0080) +
002287000000                MSGF(&LIB/&OBJ) +
002288000000                MSG( +
002289000000'NULL acceptä'                                                        +
002290000000                ) +
002291000000                SEV(0) +
002292000000     /*   No replacement variables defined!                         */ +
002293000000                ALROPT(*NO) +
002294000000                CCSID(65535) +
002295000000                /*  -EOF-  */
002296000000
002297000000     /*-------------------------------------------------------------*/
002298000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0081                    */
002299000000     /* Chg mode enträe                                             */
002300000000     /*-------------------------------------------------------------*/
002301000000
002302000000             RMVMSGD MSGID(KEY0081) MSGF(&LIB/&OBJ)
002303000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002304000000
002305000000             ADDMSGD +
002306000000                MSGID(KEY0081) +
002307000000                MSGF(&LIB/&OBJ) +
002308000000                MSG( +
002309000000'Chg mode enträe'                                                     +
002310000000                ) +
002311000000                SEV(0) +
002312000000     /*   No replacement variables defined!                         */ +
002313000000                ALROPT(*NO) +
002314000000                CCSID(65535) +
002315000000                /*  -EOF-  */
002316000000
002317000000     /*-------------------------------------------------------------*/
002318000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0082                    */
002319000000     /* Edite chaine                                                */
002320000000     /*-------------------------------------------------------------*/
002321000000
002322000000             RMVMSGD MSGID(KEY0082) MSGF(&LIB/&OBJ)
002323000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002324000000
002325000000             ADDMSGD +
002326000000                MSGID(KEY0082) +
002327000000                MSGF(&LIB/&OBJ) +
002328000000                MSG( +
002329000000'Edite chaine'                                                        +
002330000000                ) +
002331000000                SEV(0) +
002332000000     /*   No replacement variables defined!                         */ +
002333000000                ALROPT(*NO) +
002334000000                CCSID(65535) +
002335000000                /*  -EOF-  */
002336000000
002337000000     /*-------------------------------------------------------------*/
002338000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0083                    */
002339000000     /* Verrouillage                                                */
002340000000     /*-------------------------------------------------------------*/
002341000000
002342000000             RMVMSGD MSGID(KEY0083) MSGF(&LIB/&OBJ)
002343000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002344000000
002345000000             ADDMSGD +
002346000000                MSGID(KEY0083) +
002347000000                MSGF(&LIB/&OBJ) +
002348000000                MSG( +
002349000000'Verrouillage'                                                        +
002350000000                ) +
002351000000                SEV(0) +
002352000000     /*   No replacement variables defined!                         */ +
002353000000                ALROPT(*NO) +
002354000000                CCSID(65535) +
002355000000                /*  -EOF-  */
002356000000
002357000000     /*-------------------------------------------------------------*/
002358000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0084                    */
002359000000     /* Min./maj.                                                   */
002360000000     /*-------------------------------------------------------------*/
002361000000
002362000000             RMVMSGD MSGID(KEY0084) MSGF(&LIB/&OBJ)
002363000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002364000000
002365000000             ADDMSGD +
002366000000                MSGID(KEY0084) +
002367000000                MSGF(&LIB/&OBJ) +
002368000000                MSG( +
002369000000'Min./maj.'                                                           +
002370000000                ) +
002371000000                SEV(0) +
002372000000     /*   No replacement variables defined!                         */ +
002373000000                ALROPT(*NO) +
002374000000                CCSID(65535) +
002375000000                /*  -EOF-  */
002376000000
002377000000     /*-------------------------------------------------------------*/
002378000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0085                    */
002379000000     /* Imprimer                                                    */
002380000000     /*-------------------------------------------------------------*/
002381000000
002382000000             RMVMSGD MSGID(KEY0085) MSGF(&LIB/&OBJ)
002383000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002384000000
002385000000             ADDMSGD +
002386000000                MSGID(KEY0085) +
002387000000                MSGF(&LIB/&OBJ) +
002388000000                MSG( +
002389000000'Imprimer'                                                            +
002390000000                ) +
002391000000                SEV(0) +
002392000000     /*   No replacement variables defined!                         */ +
002393000000                ALROPT(*NO) +
002394000000                CCSID(65535) +
002395000000                /*  -EOF-  */
002396000000
002397000000     /*-------------------------------------------------------------*/
002398000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0086                    */
002399000000     /* Insärer                                                     */
002400000000     /*-------------------------------------------------------------*/
002401000000
002402000000             RMVMSGD MSGID(KEY0086) MSGF(&LIB/&OBJ)
002403000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002404000000
002405000000             ADDMSGD +
002406000000                MSGID(KEY0086) +
002407000000                MSGF(&LIB/&OBJ) +
002408000000                MSG( +
002409000000'Insärer'                                                             +
002410000000                ) +
002411000000                SEV(0) +
002412000000     /*   No replacement variables defined!                         */ +
002413000000                ALROPT(*NO) +
002414000000                CCSID(65535) +
002415000000                /*  -EOF-  */
002416000000
002417000000     /*-------------------------------------------------------------*/
002418000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0087                    */
002419000000     /* Supprimer                                                   */
002420000000     /*-------------------------------------------------------------*/
002421000000
002422000000             RMVMSGD MSGID(KEY0087) MSGF(&LIB/&OBJ)
002423000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002424000000
002425000000             ADDMSGD +
002426000000                MSGID(KEY0087) +
002427000000                MSGF(&LIB/&OBJ) +
002428000000                MSG( +
002429000000'Supprimer'                                                           +
002430000000                ) +
002431000000                SEV(0) +
002432000000     /*   No replacement variables defined!                         */ +
002433000000                ALROPT(*NO) +
002434000000                CCSID(65535) +
002435000000                /*  -EOF-  */
002436000000
002437000000     /*-------------------------------------------------------------*/
002438000000     /*   Cmd-ADDMSGD für Message-ID :   MBX0001                    */
002439000000     /* Information                                                 */
002440000000     /*-------------------------------------------------------------*/
002441000000
002442000000             RMVMSGD MSGID(MBX0001) MSGF(&LIB/&OBJ)
002443000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002444000000
002445000000             ADDMSGD +
002446000000                MSGID(MBX0001) +
002447000000                MSGF(&LIB/&OBJ) +
002448000000                MSG( +
002449000000'Information'                                                         +
002450000000                ) +
002451000000                SEV(0) +
002452000000     /*   No replacement variables defined!                         */ +
002453000000                ALROPT(*NO) +
002454000000                CCSID(65535) +
002455000000                /*  -EOF-  */
002456000000
002457000000     /*-------------------------------------------------------------*/
002458000000     /*   Cmd-ADDMSGD für Message-ID :   MBX0002                    */
002459000000     /* Questions                                                   */
002460000000     /*-------------------------------------------------------------*/
002461000000
002462000000             RMVMSGD MSGID(MBX0002) MSGF(&LIB/&OBJ)
002463000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002464000000
002465000000             ADDMSGD +
002466000000                MSGID(MBX0002) +
002467000000                MSGF(&LIB/&OBJ) +
002468000000                MSG( +
002469000000'Questions'                                                           +
002470000000                ) +
002471000000                SEV(0) +
002472000000     /*   No replacement variables defined!                         */ +
002473000000                ALROPT(*NO) +
002474000000                CCSID(65535) +
002475000000                /*  -EOF-  */
002476000000
002477000000     /*-------------------------------------------------------------*/
002478000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0001                    */
002479000000     /* Fichier                                                     */
002480000000     /*-------------------------------------------------------------*/
002481000000
002482000000             RMVMSGD MSGID(PMT0001) MSGF(&LIB/&OBJ)
002483000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002484000000
002485000000             ADDMSGD +
002486000000                MSGID(PMT0001) +
002487000000                MSGF(&LIB/&OBJ) +
002488000000                MSG( +
002489000000'Fichier'                                                             +
002490000000                ) +
002491000000                SEV(0) +
002492000000     /*   No replacement variables defined!                         */ +
002493000000                ALROPT(*NO) +
002494000000                CCSID(65535) +
002495000000                /*  -EOF-  */
002496000000
002497000000     /*-------------------------------------------------------------*/
002498000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0002                    */
002499000000     /* Membre                                                      */
002500000000     /*-------------------------------------------------------------*/
002501000000
002502000000             RMVMSGD MSGID(PMT0002) MSGF(&LIB/&OBJ)
002503000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002504000000
002505000000             ADDMSGD +
002506000000                MSGID(PMT0002) +
002507000000                MSGF(&LIB/&OBJ) +
002508000000                MSG( +
002509000000'Membre'                                                              +
002510000000                ) +
002511000000                SEV(0) +
002512000000     /*   No replacement variables defined!                         */ +
002513000000                ALROPT(*NO) +
002514000000                CCSID(65535) +
002515000000                /*  -EOF-  */
002516000000
002517000000     /*-------------------------------------------------------------*/
002518000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0003                    */
002519000000     /* Type d'accüs                                                */
002520000000     /*-------------------------------------------------------------*/
002521000000
002522000000             RMVMSGD MSGID(PMT0003) MSGF(&LIB/&OBJ)
002523000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002524000000
002525000000             ADDMSGD +
002526000000                MSGID(PMT0003) +
002527000000                MSGF(&LIB/&OBJ) +
002528000000                MSG( +
002529000000'Type d''accüs'                                                       +
002530000000                ) +
002531000000                SEV(0) +
002532000000     /*   No replacement variables defined!                         */ +
002533000000                ALROPT(*NO) +
002534000000                CCSID(65535) +
002535000000                /*  -EOF-  */
002536000000
002537000000     /*-------------------------------------------------------------*/
002538000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0004                    */
002539000000     /* Langue                                                      */
002540000000     /*-------------------------------------------------------------*/
002541000000
002542000000             RMVMSGD MSGID(PMT0004) MSGF(&LIB/&OBJ)
002543000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002544000000
002545000000             ADDMSGD +
002546000000                MSGID(PMT0004) +
002547000000                MSGF(&LIB/&OBJ) +
002548000000                MSG( +
002549000000'Langue'                                                              +
002550000000                ) +
002551000000                SEV(0) +
002552000000     /*   No replacement variables defined!                         */ +
002553000000                ALROPT(*NO) +
002554000000                CCSID(65535) +
002555000000                /*  -EOF-  */
002556000000
002557000000     /*-------------------------------------------------------------*/
002558000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0005                    */
002559000000     /* Droit de changer bibliothüque                               */
002560000000     /*-------------------------------------------------------------*/
002561000000
002562000000             RMVMSGD MSGID(PMT0005) MSGF(&LIB/&OBJ)
002563000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002564000000
002565000000             ADDMSGD +
002566000000                MSGID(PMT0005) +
002567000000                MSGF(&LIB/&OBJ) +
002568000000                MSG( +
002569000000'Droit de changer bibliothüque'                                       +
002570000000                ) +
002571000000                SEV(0) +
002572000000     /*   No replacement variables defined!                         */ +
002573000000                ALROPT(*NO) +
002574000000                CCSID(65535) +
002575000000                /*  -EOF-  */
002576000000
002577000000     /*-------------------------------------------------------------*/
002578000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0006                    */
002579000000     /* Droit de changer de fichier                                 */
002580000000     /*-------------------------------------------------------------*/
002581000000
002582000000             RMVMSGD MSGID(PMT0006) MSGF(&LIB/&OBJ)
002583000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002584000000
002585000000             ADDMSGD +
002586000000                MSGID(PMT0006) +
002587000000                MSGF(&LIB/&OBJ) +
002588000000                MSG( +
002589000000'Droit de changer de fichier'                                         +
002590000000                ) +
002591000000                SEV(0) +
002592000000     /*   No replacement variables defined!                         */ +
002593000000                ALROPT(*NO) +
002594000000                CCSID(65535) +
002595000000                /*  -EOF-  */
002596000000
002597000000     /*-------------------------------------------------------------*/
002598000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0007                    */
002599000000     /* Droit de changer de membre                                  */
002600000000     /*-------------------------------------------------------------*/
002601000000
002602000000             RMVMSGD MSGID(PMT0007) MSGF(&LIB/&OBJ)
002603000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002604000000
002605000000             ADDMSGD +
002606000000                MSGID(PMT0007) +
002607000000                MSGF(&LIB/&OBJ) +
002608000000                MSG( +
002609000000'Droit de changer de membre'                                          +
002610000000                ) +
002611000000                SEV(0) +
002612000000     /*   No replacement variables defined!                         */ +
002613000000                ALROPT(*NO) +
002614000000                CCSID(65535) +
002615000000                /*  -EOF-  */
002616000000
002617000000     /*-------------------------------------------------------------*/
002618000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0008                    */
002619000000     /* Droit modifier enregistrement                               */
002620000000     /*-------------------------------------------------------------*/
002621000000
002622000000             RMVMSGD MSGID(PMT0008) MSGF(&LIB/&OBJ)
002623000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002624000000
002625000000             ADDMSGD +
002626000000                MSGID(PMT0008) +
002627000000                MSGF(&LIB/&OBJ) +
002628000000                MSG( +
002629000000'Droit modifier enregistrement'                                       +
002630000000                ) +
002631000000                SEV(0) +
002632000000     /*   No replacement variables defined!                         */ +
002633000000                ALROPT(*NO) +
002634000000                CCSID(65535) +
002635000000                /*  -EOF-  */
002636000000
002637000000     /*-------------------------------------------------------------*/
002638000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0009                    */
002639000000     /* Droit de modifier SQL WHERE                                 */
002640000000     /*-------------------------------------------------------------*/
002641000000
002642000000             RMVMSGD MSGID(PMT0009) MSGF(&LIB/&OBJ)
002643000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002644000000
002645000000             ADDMSGD +
002646000000                MSGID(PMT0009) +
002647000000                MSGF(&LIB/&OBJ) +
002648000000                MSG( +
002649000000'Droit de modifier SQL WHERE'                                         +
002650000000                ) +
002651000000                SEV(0) +
002652000000     /*   No replacement variables defined!                         */ +
002653000000                ALROPT(*NO) +
002654000000                CCSID(65535) +
002655000000                /*  -EOF-  */
002656000000
002657000000     /*-------------------------------------------------------------*/
002658000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0010                    */
002659000000     /* Droit de modifier ORDER BY                                  */
002660000000     /*-------------------------------------------------------------*/
002661000000
002662000000             RMVMSGD MSGID(PMT0010) MSGF(&LIB/&OBJ)
002663000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002664000000
002665000000             ADDMSGD +
002666000000                MSGID(PMT0010) +
002667000000                MSGF(&LIB/&OBJ) +
002668000000                MSG( +
002669000000'Droit de modifier ORDER BY'                                          +
002670000000                ) +
002671000000                SEV(0) +
002672000000     /*   No replacement variables defined!                         */ +
002673000000                ALROPT(*NO) +
002674000000                CCSID(65535) +
002675000000                /*  -EOF-  */
002676000000
002677000000     /*-------------------------------------------------------------*/
002678000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0011                    */
002679000000     /* Environnement                                               */
002680000000     /*-------------------------------------------------------------*/
002681000000
002682000000             RMVMSGD MSGID(PMT0011) MSGF(&LIB/&OBJ)
002683000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002684000000
002685000000             ADDMSGD +
002686000000                MSGID(PMT0011) +
002687000000                MSGF(&LIB/&OBJ) +
002688000000                MSG( +
002689000000'Environnement'                                                       +
002690000000                ) +
002691000000                SEV(0) +
002692000000     /*   No replacement variables defined!                         */ +
002693000000                ALROPT(*NO) +
002694000000                CCSID(65535) +
002695000000                /*  -EOF-  */
002696000000
002697000000     /*-------------------------------------------------------------*/
002698000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0012                    */
002699000000     /*   Membre                                                    */
002700000000     /*-------------------------------------------------------------*/
002701000000
002702000000             RMVMSGD MSGID(PMT0012) MSGF(&LIB/&OBJ)
002703000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002704000000
002705000000             ADDMSGD +
002706000000                MSGID(PMT0012) +
002707000000                MSGF(&LIB/&OBJ) +
002708000000                MSG( +
002709000000'  Membre'                                                            +
002710000000                ) +
002711000000                SEV(0) +
002712000000     /*   No replacement variables defined!                         */ +
002713000000                ALROPT(*NO) +
002714000000                CCSID(65535) +
002715000000                /*  -EOF-  */
002716000000
002717000000     /*-------------------------------------------------------------*/
002718000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0013                    */
002719000000     /* Clause SQL WHERE                                            */
002720000000     /*-------------------------------------------------------------*/
002721000000
002722000000             RMVMSGD MSGID(PMT0013) MSGF(&LIB/&OBJ)
002723000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002724000000
002725000000             ADDMSGD +
002726000000                MSGID(PMT0013) +
002727000000                MSGF(&LIB/&OBJ) +
002728000000                MSG( +
002729000000'Clause SQL WHERE'                                                    +
002730000000                ) +
002731000000                SEV(0) +
002732000000     /*   No replacement variables defined!                         */ +
002733000000                ALROPT(*NO) +
002734000000                CCSID(65535) +
002735000000                /*  -EOF-  */
002736000000
002737000000     /*-------------------------------------------------------------*/
002738000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0014                    */
002739000000     /* Clause SQL ORDER BY                                         */
002740000000     /*-------------------------------------------------------------*/
002741000000
002742000000             RMVMSGD MSGID(PMT0014) MSGF(&LIB/&OBJ)
002743000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002744000000
002745000000             ADDMSGD +
002746000000                MSGID(PMT0014) +
002747000000                MSGF(&LIB/&OBJ) +
002748000000                MSG( +
002749000000'Clause SQL ORDER BY'                                                 +
002750000000                ) +
002751000000                SEV(0) +
002752000000     /*   No replacement variables defined!                         */ +
002753000000                ALROPT(*NO) +
002754000000                CCSID(65535) +
002755000000                /*  -EOF-  */
002756000000
002757000000     /*-------------------------------------------------------------*/
002758000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0015                    */
002759000000     /* Bibliothüque                                                */
002760000000     /*-------------------------------------------------------------*/
002761000000
002762000000             RMVMSGD MSGID(PMT0015) MSGF(&LIB/&OBJ)
002763000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002764000000
002765000000             ADDMSGD +
002766000000                MSGID(PMT0015) +
002767000000                MSGF(&LIB/&OBJ) +
002768000000                MSG( +
002769000000'Bibliothüque'                                                        +
002770000000                ) +
002771000000                SEV(0) +
002772000000     /*   No replacement variables defined!                         */ +
002773000000                ALROPT(*NO) +
002774000000                CCSID(65535) +
002775000000                /*  -EOF-  */
002776000000
002777000000     /*-------------------------------------------------------------*/
002778000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0016                    */
002779000000     /* Präfärences utilisateur                                     */
002780000000     /*-------------------------------------------------------------*/
002781000000
002782000000             RMVMSGD MSGID(PMT0016) MSGF(&LIB/&OBJ)
002783000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002784000000
002785000000             ADDMSGD +
002786000000                MSGID(PMT0016) +
002787000000                MSGF(&LIB/&OBJ) +
002788000000                MSG( +
002789000000'Präfärences utilisateur'                                             +
002790000000                ) +
002791000000                SEV(0) +
002792000000     /*   No replacement variables defined!                         */ +
002793000000                ALROPT(*NO) +
002794000000                CCSID(65535) +
002795000000                /*  -EOF-  */
002796000000
002797000000     /*-------------------------------------------------------------*/
002798000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0017                    */
002799000000     /* Profil utilisateur                                          */
002800000000     /*-------------------------------------------------------------*/
002801000000
002802000000             RMVMSGD MSGID(PMT0017) MSGF(&LIB/&OBJ)
002803000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002804000000
002805000000             ADDMSGD +
002806000000                MSGID(PMT0017) +
002807000000                MSGF(&LIB/&OBJ) +
002808000000                MSG( +
002809000000'Profil utilisateur'                                                  +
002810000000                ) +
002811000000                SEV(0) +
002812000000     /*   No replacement variables defined!                         */ +
002813000000                ALROPT(*NO) +
002814000000                CCSID(65535) +
002815000000                /*  -EOF-  */
002816000000
002817000000     /*-------------------------------------------------------------*/
002818000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0018                    */
002819000000     /* Sauvegarder en quittant                                     */
002820000000     /*-------------------------------------------------------------*/
002821000000
002822000000             RMVMSGD MSGID(PMT0018) MSGF(&LIB/&OBJ)
002823000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002824000000
002825000000             ADDMSGD +
002826000000                MSGID(PMT0018) +
002827000000                MSGF(&LIB/&OBJ) +
002828000000                MSG( +
002829000000'Sauvegarder en quittant'                                             +
002830000000                ) +
002831000000                SEV(0) +
002832000000     /*   No replacement variables defined!                         */ +
002833000000                ALROPT(*NO) +
002834000000                CCSID(65535) +
002835000000                /*  -EOF-  */
002836000000
002837000000     /*-------------------------------------------------------------*/
002838000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0019                    */
002839000000     /* Charger seulement la maquette                               */
002840000000     /*-------------------------------------------------------------*/
002841000000
002842000000             RMVMSGD MSGID(PMT0019) MSGF(&LIB/&OBJ)
002843000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002844000000
002845000000             ADDMSGD +
002846000000                MSGID(PMT0019) +
002847000000                MSGF(&LIB/&OBJ) +
002848000000                MSG( +
002849000000'Charger seulement la maquette'                                       +
002850000000                ) +
002851000000                SEV(0) +
002852000000     /*   No replacement variables defined!                         */ +
002853000000                ALROPT(*NO) +
002854000000                CCSID(65535) +
002855000000                /*  -EOF-  */
002856000000
002857000000     /*-------------------------------------------------------------*/
002858000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0100                    */
002859000000     /* Editeur B.D.D Peek/400                                      */
002860000000     /*-------------------------------------------------------------*/
002861000000
002862000000             RMVMSGD MSGID(PMT0100) MSGF(&LIB/&OBJ)
002863000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002864000000
002865000000             ADDMSGD +
002866000000                MSGID(PMT0100) +
002867000000                MSGF(&LIB/&OBJ) +
002868000000                MSG( +
002869000000'Editeur B.D.D Peek/400'                                              +
002870000000                ) +
002871000000                SEV(0) +
002872000000     /*   No replacement variables defined!                         */ +
002873000000                ALROPT(*NO) +
002874000000                CCSID(65535) +
002875000000                /*  -EOF-  */
002876000000
002877000000     /*-------------------------------------------------------------*/
002878000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0101                    */
002879000000     /* Afficher relations logiques                                 */
002880000000     /*-------------------------------------------------------------*/
002881000000
002882000000             RMVMSGD MSGID(PMT0101) MSGF(&LIB/&OBJ)
002883000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002884000000
002885000000             ADDMSGD +
002886000000                MSGID(PMT0101) +
002887000000                MSGF(&LIB/&OBJ) +
002888000000                MSG( +
002889000000'Afficher relations logiques'                                         +
002890000000                ) +
002891000000                SEV(0) +
002892000000     /*   No replacement variables defined!                         */ +
002893000000                ALROPT(*NO) +
002894000000                CCSID(65535) +
002895000000                /*  -EOF-  */
002896000000
002897000000     /*-------------------------------------------------------------*/
002898000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0001                    */
002899000000     /* Fich.:                                                      */
002900000000     /*-------------------------------------------------------------*/
002901000000
002902000000             RMVMSGD MSGID(TXT0001) MSGF(&LIB/&OBJ)
002903000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002904000000
002905000000             ADDMSGD +
002906000000                MSGID(TXT0001) +
002907000000                MSGF(&LIB/&OBJ) +
002908000000                MSG( +
002909000000'Fich.:'                                                              +
002910000000                ) +
002911000000                SEV(0) +
002912000000     /*   No replacement variables defined!                         */ +
002913000000                ALROPT(*NO) +
002914000000                CCSID(65535) +
002915000000                /*  -EOF-  */
002916000000
002917000000     /*-------------------------------------------------------------*/
002918000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0002                    */
002919000000     /* Bibliothü.:                                                 */
002920000000     /*-------------------------------------------------------------*/
002921000000
002922000000             RMVMSGD MSGID(TXT0002) MSGF(&LIB/&OBJ)
002923000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002924000000
002925000000             ADDMSGD +
002926000000                MSGID(TXT0002) +
002927000000                MSGF(&LIB/&OBJ) +
002928000000                MSG( +
002929000000'Bibliothü.:'                                                         +
002930000000                ) +
002931000000                SEV(0) +
002932000000     /*   No replacement variables defined!                         */ +
002933000000                ALROPT(*NO) +
002934000000                CCSID(65535) +
002935000000                /*  -EOF-  */
002936000000
002937000000     /*-------------------------------------------------------------*/
002938000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0003                    */
002939000000     /*   Membre :                                                  */
002940000000     /*-------------------------------------------------------------*/
002941000000
002942000000             RMVMSGD MSGID(TXT0003) MSGF(&LIB/&OBJ)
002943000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002944000000
002945000000             ADDMSGD +
002946000000                MSGID(TXT0003) +
002947000000                MSGF(&LIB/&OBJ) +
002948000000                MSG( +
002949000000'  Membre :'                                                          +
002950000000                ) +
002951000000                SEV(0) +
002952000000     /*   No replacement variables defined!                         */ +
002953000000                ALROPT(*NO) +
002954000000                CCSID(65535) +
002955000000                /*  -EOF-  */
002956000000
002957000000     /*-------------------------------------------------------------*/
002958000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0004                    */
002959000000     /* Longueur....:                                               */
002960000000     /*-------------------------------------------------------------*/
002961000000
002962000000             RMVMSGD MSGID(TXT0004) MSGF(&LIB/&OBJ)
002963000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002964000000
002965000000             ADDMSGD +
002966000000                MSGID(TXT0004) +
002967000000                MSGF(&LIB/&OBJ) +
002968000000                MSG( +
002969000000'Longueur....:'                                                       +
002970000000                ) +
002971000000                SEV(0) +
002972000000     /*   No replacement variables defined!                         */ +
002973000000                ALROPT(*NO) +
002974000000                CCSID(65535) +
002975000000                /*  -EOF-  */
002976000000
002977000000     /*-------------------------------------------------------------*/
002978000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0005                    */
002979000000     /* Nbre enreg..:                                               */
002980000000     /*-------------------------------------------------------------*/
002981000000
002982000000             RMVMSGD MSGID(TXT0005) MSGF(&LIB/&OBJ)
002983000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
002984000000
002985000000             ADDMSGD +
002986000000                MSGID(TXT0005) +
002987000000                MSGF(&LIB/&OBJ) +
002988000000                MSG( +
002989000000'Nbre enreg..:'                                                       +
002990000000                ) +
002991000000                SEV(0) +
002992000000     /*   No replacement variables defined!                         */ +
002993000000                ALROPT(*NO) +
002994000000                CCSID(65535) +
002995000000                /*  -EOF-  */
002996000000
002997000000     /*-------------------------------------------------------------*/
002998000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0006                    */
002999000000     /* NÄ champ....:                                               */
003000000000     /*-------------------------------------------------------------*/
003001000000
003002000000             RMVMSGD MSGID(TXT0006) MSGF(&LIB/&OBJ)
003003000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003004000000
003005000000             ADDMSGD +
003006000000                MSGID(TXT0006) +
003007000000                MSGF(&LIB/&OBJ) +
003008000000                MSG( +
003009000000'NÄ champ....:'                                                       +
003010000000                ) +
003011000000                SEV(0) +
003012000000     /*   No replacement variables defined!                         */ +
003013000000                ALROPT(*NO) +
003014000000                CCSID(65535) +
003015000000                /*  -EOF-  */
003016000000
003017000000     /*-------------------------------------------------------------*/
003018000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0007                    */
003019000000     /* Nom du champ:                                               */
003020000000     /*-------------------------------------------------------------*/
003021000000
003022000000             RMVMSGD MSGID(TXT0007) MSGF(&LIB/&OBJ)
003023000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003024000000
003025000000             ADDMSGD +
003026000000                MSGID(TXT0007) +
003027000000                MSGF(&LIB/&OBJ) +
003028000000                MSG( +
003029000000'Nom du champ:'                                                       +
003030000000                ) +
003031000000                SEV(0) +
003032000000     /*   No replacement variables defined!                         */ +
003033000000                ALROPT(*NO) +
003034000000                CCSID(65535) +
003035000000                /*  -EOF-  */
003036000000
003037000000     /*-------------------------------------------------------------*/
003038000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0008                    */
003039000000     /*   Format :                                                  */
003040000000     /*-------------------------------------------------------------*/
003041000000
003042000000             RMVMSGD MSGID(TXT0008) MSGF(&LIB/&OBJ)
003043000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003044000000
003045000000             ADDMSGD +
003046000000                MSGID(TXT0008) +
003047000000                MSGF(&LIB/&OBJ) +
003048000000                MSG( +
003049000000'  Format :'                                                          +
003050000000                ) +
003051000000                SEV(0) +
003052000000     /*   No replacement variables defined!                         */ +
003053000000                ALROPT(*NO) +
003054000000                CCSID(65535) +
003055000000                /*  -EOF-  */
003056000000
003057000000     /*-------------------------------------------------------------*/
003058000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0009                    */
003059000000     /* Taille fich.:                                               */
003060000000     /*-------------------------------------------------------------*/
003061000000
003062000000             RMVMSGD MSGID(TXT0009) MSGF(&LIB/&OBJ)
003063000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003064000000
003065000000             ADDMSGD +
003066000000                MSGID(TXT0009) +
003067000000                MSGF(&LIB/&OBJ) +
003068000000                MSG( +
003069000000'Taille fich.:'                                                       +
003070000000                ) +
003071000000                SEV(0) +
003072000000     /*   No replacement variables defined!                         */ +
003073000000                ALROPT(*NO) +
003074000000                CCSID(65535) +
003075000000                /*  -EOF-  */
003076000000
003077000000     /*-------------------------------------------------------------*/
003078000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0010                    */
003079000000     /* NÄ enregist.:                                               */
003080000000     /*-------------------------------------------------------------*/
003081000000
003082000000             RMVMSGD MSGID(TXT0010) MSGF(&LIB/&OBJ)
003083000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003084000000
003085000000             ADDMSGD +
003086000000                MSGID(TXT0010) +
003087000000                MSGF(&LIB/&OBJ) +
003088000000                MSG( +
003089000000'NÄ enregist.:'                                                       +
003090000000                ) +
003091000000                SEV(0) +
003092000000     /*   No replacement variables defined!                         */ +
003093000000                ALROPT(*NO) +
003094000000                CCSID(65535) +
003095000000                /*  -EOF-  */
003096000000
003097000000     /*-------------------------------------------------------------*/
003098000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0011                    */
003099000000     /* Valeur clefs:                                               */
003100000000     /*-------------------------------------------------------------*/
003101000000
003102000000             RMVMSGD MSGID(TXT0011) MSGF(&LIB/&OBJ)
003103000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003104000000
003105000000             ADDMSGD +
003106000000                MSGID(TXT0011) +
003107000000                MSGF(&LIB/&OBJ) +
003108000000                MSG( +
003109000000'Valeur clefs:'                                                       +
003110000000                ) +
003111000000                SEV(0) +
003112000000     /*   No replacement variables defined!                         */ +
003113000000                ALROPT(*NO) +
003114000000                CCSID(65535) +
003115000000                /*  -EOF-  */
003116000000
003117000000     /*-------------------------------------------------------------*/
003118000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0012                    */
003119000000     /*  Options :                                                  */
003120000000     /*-------------------------------------------------------------*/
003121000000
003122000000             RMVMSGD MSGID(TXT0012) MSGF(&LIB/&OBJ)
003123000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003124000000
003125000000             ADDMSGD +
003126000000                MSGID(TXT0012) +
003127000000                MSGF(&LIB/&OBJ) +
003128000000                MSG( +
003129000000' Options :'                                                          +
003130000000                ) +
003131000000                SEV(0) +
003132000000     /*   No replacement variables defined!                         */ +
003133000000                ALROPT(*NO) +
003134000000                CCSID(65535) +
003135000000                /*  -EOF-  */
003136000000
003137000000     /*-------------------------------------------------------------*/
003138000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0013                    */
003139000000     /*  Fich.:                                                     */
003140000000     /*-------------------------------------------------------------*/
003141000000
003142000000             RMVMSGD MSGID(TXT0013) MSGF(&LIB/&OBJ)
003143000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003144000000
003145000000             ADDMSGD +
003146000000                MSGID(TXT0013) +
003147000000                MSGF(&LIB/&OBJ) +
003148000000                MSG( +
003149000000' Fich.:'                                                             +
003150000000                ) +
003151000000                SEV(0) +
003152000000     /*   No replacement variables defined!                         */ +
003153000000                ALROPT(*NO) +
003154000000                CCSID(65535) +
003155000000                /*  -EOF-  */
003156000000
003157000000     /*-------------------------------------------------------------*/
003158000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0014                    */
003159000000     /* Bib:                                                        */
003160000000     /*-------------------------------------------------------------*/
003161000000
003162000000             RMVMSGD MSGID(TXT0014) MSGF(&LIB/&OBJ)
003163000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003164000000
003165000000             ADDMSGD +
003166000000                MSGID(TXT0014) +
003167000000                MSGF(&LIB/&OBJ) +
003168000000                MSG( +
003169000000'Bib:'                                                                +
003170000000                ) +
003171000000                SEV(0) +
003172000000     /*   No replacement variables defined!                         */ +
003173000000                ALROPT(*NO) +
003174000000                CCSID(65535) +
003175000000                /*  -EOF-  */
003176000000
003177000000     /*-------------------------------------------------------------*/
003178000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0015                    */
003179000000     /* Mbr:                                                        */
003180000000     /*-------------------------------------------------------------*/
003181000000
003182000000             RMVMSGD MSGID(TXT0015) MSGF(&LIB/&OBJ)
003183000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003184000000
003185000000             ADDMSGD +
003186000000                MSGID(TXT0015) +
003187000000                MSGF(&LIB/&OBJ) +
003188000000                MSG( +
003189000000'Mbr:'                                                                +
003190000000                ) +
003191000000                SEV(0) +
003192000000     /*   No replacement variables defined!                         */ +
003193000000                ALROPT(*NO) +
003194000000                CCSID(65535) +
003195000000                /*  -EOF-  */
003196000000
003197000000     /*-------------------------------------------------------------*/
003198000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0016                    */
003199000000     /* Taille:                                                     */
003200000000     /*-------------------------------------------------------------*/
003201000000
003202000000             RMVMSGD MSGID(TXT0016) MSGF(&LIB/&OBJ)
003203000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003204000000
003205000000             ADDMSGD +
003206000000                MSGID(TXT0016) +
003207000000                MSGF(&LIB/&OBJ) +
003208000000                MSG( +
003209000000'Taille:'                                                             +
003210000000                ) +
003211000000                SEV(0) +
003212000000     /*   No replacement variables defined!                         */ +
003213000000                ALROPT(*NO) +
003214000000                CCSID(65535) +
003215000000                /*  -EOF-  */
003216000000
003217000000     /*-------------------------------------------------------------*/
003218000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0017                    */
003219000000     /* Enreg.:                                                     */
003220000000     /*-------------------------------------------------------------*/
003221000000
003222000000             RMVMSGD MSGID(TXT0017) MSGF(&LIB/&OBJ)
003223000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003224000000
003225000000             ADDMSGD +
003226000000                MSGID(TXT0017) +
003227000000                MSGF(&LIB/&OBJ) +
003228000000                MSG( +
003229000000'Enreg.:'                                                             +
003230000000                ) +
003231000000                SEV(0) +
003232000000     /*   No replacement variables defined!                         */ +
003233000000                ALROPT(*NO) +
003234000000                CCSID(65535) +
003235000000                /*  -EOF-  */
003236000000
003237000000     /*-------------------------------------------------------------*/
003238000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0018                    */
003239000000     /* NÄchamp.:                                                   */
003240000000     /*-------------------------------------------------------------*/
003241000000
003242000000             RMVMSGD MSGID(TXT0018) MSGF(&LIB/&OBJ)
003243000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003244000000
003245000000             ADDMSGD +
003246000000                MSGID(TXT0018) +
003247000000                MSGF(&LIB/&OBJ) +
003248000000                MSG( +
003249000000'NÄchamp.:'                                                           +
003250000000                ) +
003251000000                SEV(0) +
003252000000     /*   No replacement variables defined!                         */ +
003253000000                ALROPT(*NO) +
003254000000                CCSID(65535) +
003255000000                /*  -EOF-  */
003256000000
003257000000     /*-------------------------------------------------------------*/
003258000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0019                    */
003259000000     /* Nom champ:                                                  */
003260000000     /*-------------------------------------------------------------*/
003261000000
003262000000             RMVMSGD MSGID(TXT0019) MSGF(&LIB/&OBJ)
003263000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003264000000
003265000000             ADDMSGD +
003266000000                MSGID(TXT0019) +
003267000000                MSGF(&LIB/&OBJ) +
003268000000                MSG( +
003269000000'Nom champ:'                                                          +
003270000000                ) +
003271000000                SEV(0) +
003272000000     /*   No replacement variables defined!                         */ +
003273000000                ALROPT(*NO) +
003274000000                CCSID(65535) +
003275000000                /*  -EOF-  */
003276000000
003277000000     /*-------------------------------------------------------------*/
003278000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0020                    */
003279000000     /* Format:                                                     */
003280000000     /*-------------------------------------------------------------*/
003281000000
003282000000             RMVMSGD MSGID(TXT0020) MSGF(&LIB/&OBJ)
003283000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003284000000
003285000000             ADDMSGD +
003286000000                MSGID(TXT0020) +
003287000000                MSGF(&LIB/&OBJ) +
003288000000                MSG( +
003289000000'Format:'                                                             +
003290000000                ) +
003291000000                SEV(0) +
003292000000     /*   No replacement variables defined!                         */ +
003293000000                ALROPT(*NO) +
003294000000                CCSID(65535) +
003295000000                /*  -EOF-  */
003296000000
003297000000     /*-------------------------------------------------------------*/
003298000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0021                    */
003299000000     /* Taille:                                                     */
003300000000     /*-------------------------------------------------------------*/
003301000000
003302000000             RMVMSGD MSGID(TXT0021) MSGF(&LIB/&OBJ)
003303000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003304000000
003305000000             ADDMSGD +
003306000000                MSGID(TXT0021) +
003307000000                MSGF(&LIB/&OBJ) +
003308000000                MSG( +
003309000000'Taille:'                                                             +
003310000000                ) +
003311000000                SEV(0) +
003312000000     /*   No replacement variables defined!                         */ +
003313000000                ALROPT(*NO) +
003314000000                CCSID(65535) +
003315000000                /*  -EOF-  */
003316000000
003317000000     /*-------------------------------------------------------------*/
003318000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0022                    */
003319000000     /* NÄ enreg.:                                                  */
003320000000     /*-------------------------------------------------------------*/
003321000000
003322000000             RMVMSGD MSGID(TXT0022) MSGF(&LIB/&OBJ)
003323000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003324000000
003325000000             ADDMSGD +
003326000000                MSGID(TXT0022) +
003327000000                MSGF(&LIB/&OBJ) +
003328000000                MSG( +
003329000000'NÄ enreg.:'                                                          +
003330000000                ) +
003331000000                SEV(0) +
003332000000     /*   No replacement variables defined!                         */ +
003333000000                ALROPT(*NO) +
003334000000                CCSID(65535) +
003335000000                /*  -EOF-  */
003336000000
003337000000     /*-------------------------------------------------------------*/
003338000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0023                    */
003339000000     /* Valeur clefs:                                               */
003340000000     /*-------------------------------------------------------------*/
003341000000
003342000000             RMVMSGD MSGID(TXT0023) MSGF(&LIB/&OBJ)
003343000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003344000000
003345000000             ADDMSGD +
003346000000                MSGID(TXT0023) +
003347000000                MSGF(&LIB/&OBJ) +
003348000000                MSG( +
003349000000'Valeur clefs:'                                                       +
003350000000                ) +
003351000000                SEV(0) +
003352000000     /*   No replacement variables defined!                         */ +
003353000000                ALROPT(*NO) +
003354000000                CCSID(65535) +
003355000000                /*  -EOF-  */
003356000000
003357000000     /*-------------------------------------------------------------*/
003358000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0024                    */
003359000000     /* Options:                                                    */
003360000000     /*-------------------------------------------------------------*/
003361000000
003362000000             RMVMSGD MSGID(TXT0024) MSGF(&LIB/&OBJ)
003363000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003364000000
003365000000             ADDMSGD +
003366000000                MSGID(TXT0024) +
003367000000                MSGF(&LIB/&OBJ) +
003368000000                MSG( +
003369000000'Options:'                                                            +
003370000000                ) +
003371000000                SEV(0) +
003372000000     /*   No replacement variables defined!                         */ +
003373000000                ALROPT(*NO) +
003374000000                CCSID(65535) +
003375000000                /*  -EOF-  */
003376000000
003377000000     /*-------------------------------------------------------------*/
003378000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0025                    */
003379000000     /* (Pas d'enregistrement)                                      */
003380000000     /*-------------------------------------------------------------*/
003381000000
003382000000             RMVMSGD MSGID(TXT0025) MSGF(&LIB/&OBJ)
003383000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003384000000
003385000000             ADDMSGD +
003386000000                MSGID(TXT0025) +
003387000000                MSGF(&LIB/&OBJ) +
003388000000                MSG( +
003389000000'(Pas d''enregistrement)'                                             +
003390000000                ) +
003391000000                SEV(0) +
003392000000     /*   No replacement variables defined!                         */ +
003393000000                ALROPT(*NO) +
003394000000                CCSID(65535) +
003395000000                /*  -EOF-  */
003396000000
003397000000     /*-------------------------------------------------------------*/
003398000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0026                    */
003399000000     /* Tapez ENTREE pour supprimer.                                */
003400000000     /*-------------------------------------------------------------*/
003401000000
003402000000             RMVMSGD MSGID(TXT0026) MSGF(&LIB/&OBJ)
003403000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003404000000
003405000000             ADDMSGD +
003406000000                MSGID(TXT0026) +
003407000000                MSGF(&LIB/&OBJ) +
003408000000                MSG( +
003409000000'Tapez ENTREE pour supprimer.'                                        +
003410000000                ) +
003411000000                SEV(0) +
003412000000     /*   No replacement variables defined!                         */ +
003413000000                ALROPT(*NO) +
003414000000                CCSID(65535) +
003415000000                /*  -EOF-  */
003416000000
003417000000     /*-------------------------------------------------------------*/
003418000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0027                    */
003419000000     /* Dätail enregistrement                                       */
003420000000     /*-------------------------------------------------------------*/
003421000000
003422000000             RMVMSGD MSGID(TXT0027) MSGF(&LIB/&OBJ)
003423000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003424000000
003425000000             ADDMSGD +
003426000000                MSGID(TXT0027) +
003427000000                MSGF(&LIB/&OBJ) +
003428000000                MSG( +
003429000000'Dätail enregistrement'                                               +
003430000000                ) +
003431000000                SEV(0) +
003432000000     /*   No replacement variables defined!                         */ +
003433000000                ALROPT(*NO) +
003434000000                CCSID(65535) +
003435000000                /*  -EOF-  */
003436000000
003437000000     /*-------------------------------------------------------------*/
003438000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0028                    */
003439000000     /* Tapez ENTREE pour copier.                                   */
003440000000     /*-------------------------------------------------------------*/
003441000000
003442000000             RMVMSGD MSGID(TXT0028) MSGF(&LIB/&OBJ)
003443000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003444000000
003445000000             ADDMSGD +
003446000000                MSGID(TXT0028) +
003447000000                MSGF(&LIB/&OBJ) +
003448000000                MSG( +
003449000000'Tapez ENTREE pour copier.'                                           +
003450000000                ) +
003451000000                SEV(0) +
003452000000     /*   No replacement variables defined!                         */ +
003453000000                ALROPT(*NO) +
003454000000                CCSID(65535) +
003455000000                /*  -EOF-  */
003456000000
003457000000     /*-------------------------------------------------------------*/
003458000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0029                    */
003459000000     /* Enreg.:                                                     */
003460000000     /*-------------------------------------------------------------*/
003461000000
003462000000             RMVMSGD MSGID(TXT0029) MSGF(&LIB/&OBJ)
003463000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003464000000
003465000000             ADDMSGD +
003466000000                MSGID(TXT0029) +
003467000000                MSGF(&LIB/&OBJ) +
003468000000                MSG( +
003469000000'Enreg.:'                                                             +
003470000000                ) +
003471000000                SEV(0) +
003472000000     /*   No replacement variables defined!                         */ +
003473000000                ALROPT(*NO) +
003474000000                CCSID(65535) +
003475000000                /*  -EOF-  */
003476000000
003477000000     /*-------------------------------------------------------------*/
003478000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0030                    */
003479000000     /* Journalisation                                              */
003480000000     /*-------------------------------------------------------------*/
003481000000
003482000000             RMVMSGD MSGID(TXT0030) MSGF(&LIB/&OBJ)
003483000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003484000000
003485000000             ADDMSGD +
003486000000                MSGID(TXT0030) +
003487000000                MSGF(&LIB/&OBJ) +
003488000000                MSG( +
003489000000'Journalisation'                                                      +
003490000000                ) +
003491000000                SEV(0) +
003492000000     /*   No replacement variables defined!                         */ +
003493000000                ALROPT(*NO) +
003494000000                CCSID(65535) +
003495000000                /*  -EOF-  */
003496000000
003497000000     /*-------------------------------------------------------------*/
003498000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0031                    */
003499000000     /* Non journalisä                                              */
003500000000     /*-------------------------------------------------------------*/
003501000000
003502000000             RMVMSGD MSGID(TXT0031) MSGF(&LIB/&OBJ)
003503000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003504000000
003505000000             ADDMSGD +
003506000000                MSGID(TXT0031) +
003507000000                MSGF(&LIB/&OBJ) +
003508000000                MSG( +
003509000000'Non journalisä'                                                      +
003510000000                ) +
003511000000                SEV(0) +
003512000000     /*   No replacement variables defined!                         */ +
003513000000                ALROPT(*NO) +
003514000000                CCSID(65535) +
003515000000                /*  -EOF-  */
003516000000
003517000000     /*-------------------------------------------------------------*/
003518000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0032                    */
003519000000     /* (Pas d'enregistrement)                                      */
003520000000     /*-------------------------------------------------------------*/
003521000000
003522000000             RMVMSGD MSGID(TXT0032) MSGF(&LIB/&OBJ)
003523000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003524000000
003525000000             ADDMSGD +
003526000000                MSGID(TXT0032) +
003527000000                MSGF(&LIB/&OBJ) +
003528000000                MSG( +
003529000000'(Pas d''enregistrement)'                                             +
003530000000                ) +
003531000000                SEV(0) +
003532000000     /*   No replacement variables defined!                         */ +
003533000000                ALROPT(*NO) +
003534000000                CCSID(65535) +
003535000000                /*  -EOF-  */
003536000000
003537000000     /*-------------------------------------------------------------*/
003538000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0033                    */
003539000000     /*     - Recherche -                                           */
003540000000     /*-------------------------------------------------------------*/
003541000000
003542000000             RMVMSGD MSGID(TXT0033) MSGF(&LIB/&OBJ)
003543000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003544000000
003545000000             ADDMSGD +
003546000000                MSGID(TXT0033) +
003547000000                MSGF(&LIB/&OBJ) +
003548000000                MSG( +
003549000000'    - Recherche -'                                                   +
003550000000                ) +
003551000000                SEV(0) +
003552000000     /*   No replacement variables defined!                         */ +
003553000000                ALROPT(*NO) +
003554000000                CCSID(65535) +
003555000000                /*  -EOF-  */
003556000000
003557000000     /*-------------------------------------------------------------*/
003558000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0034                    */
003559000000     /* Champ                                                       */
003560000000     /*-------------------------------------------------------------*/
003561000000
003562000000             RMVMSGD MSGID(TXT0034) MSGF(&LIB/&OBJ)
003563000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003564000000
003565000000             ADDMSGD +
003566000000                MSGID(TXT0034) +
003567000000                MSGF(&LIB/&OBJ) +
003568000000                MSG( +
003569000000'Champ'                                                               +
003570000000                ) +
003571000000                SEV(0) +
003572000000     /*   No replacement variables defined!                         */ +
003573000000                ALROPT(*NO) +
003574000000                CCSID(65535) +
003575000000                /*  -EOF-  */
003576000000
003577000000     /*-------------------------------------------------------------*/
003578000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0035                    */
003579000000     /* Op.                                                         */
003580000000     /*-------------------------------------------------------------*/
003581000000
003582000000             RMVMSGD MSGID(TXT0035) MSGF(&LIB/&OBJ)
003583000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003584000000
003585000000             ADDMSGD +
003586000000                MSGID(TXT0035) +
003587000000                MSGF(&LIB/&OBJ) +
003588000000                MSG( +
003589000000'Op.'                                                                 +
003590000000                ) +
003591000000                SEV(0) +
003592000000     /*   No replacement variables defined!                         */ +
003593000000                ALROPT(*NO) +
003594000000                CCSID(65535) +
003595000000                /*  -EOF-  */
003596000000
003597000000     /*-------------------------------------------------------------*/
003598000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0036                    */
003599000000     /* Valeur (sans quotes)                                        */
003600000000     /*-------------------------------------------------------------*/
003601000000
003602000000             RMVMSGD MSGID(TXT0036) MSGF(&LIB/&OBJ)
003603000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003604000000
003605000000             ADDMSGD +
003606000000                MSGID(TXT0036) +
003607000000                MSGF(&LIB/&OBJ) +
003608000000                MSG( +
003609000000'Valeur (sans quotes)'                                                +
003610000000                ) +
003611000000                SEV(0) +
003612000000     /*   No replacement variables defined!                         */ +
003613000000                ALROPT(*NO) +
003614000000                CCSID(65535) +
003615000000                /*  -EOF-  */
003616000000
003617000000     /*-------------------------------------------------------------*/
003618000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0037                    */
003619000000     /* pour recherche gän)                                         */
003620000000     /*-------------------------------------------------------------*/
003621000000
003622000000             RMVMSGD MSGID(TXT0037) MSGF(&LIB/&OBJ)
003623000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003624000000
003625000000             ADDMSGD +
003626000000                MSGID(TXT0037) +
003627000000                MSGF(&LIB/&OBJ) +
003628000000                MSG( +
003629000000'pour recherche gän)'                                                 +
003630000000                ) +
003631000000                SEV(0) +
003632000000     /*   No replacement variables defined!                         */ +
003633000000                ALROPT(*NO) +
003634000000                CCSID(65535) +
003635000000                /*  -EOF-  */
003636000000
003637000000     /*-------------------------------------------------------------*/
003638000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0038                    */
003639000000     /* Nb.lignes maxi:                                             */
003640000000     /*-------------------------------------------------------------*/
003641000000
003642000000             RMVMSGD MSGID(TXT0038) MSGF(&LIB/&OBJ)
003643000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003644000000
003645000000             ADDMSGD +
003646000000                MSGID(TXT0038) +
003647000000                MSGF(&LIB/&OBJ) +
003648000000                MSG( +
003649000000'Nb.lignes maxi:'                                                     +
003650000000                ) +
003651000000                SEV(0) +
003652000000     /*   No replacement variables defined!                         */ +
003653000000                ALROPT(*NO) +
003654000000                CCSID(65535) +
003655000000                /*  -EOF-  */
003656000000
003657000000     /*-------------------------------------------------------------*/
003658000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0039                    */
003659000000     /* Type recherche:                                             */
003660000000     /*-------------------------------------------------------------*/
003661000000
003662000000             RMVMSGD MSGID(TXT0039) MSGF(&LIB/&OBJ)
003663000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003664000000
003665000000             ADDMSGD +
003666000000                MSGID(TXT0039) +
003667000000                MSGF(&LIB/&OBJ) +
003668000000                MSG( +
003669000000'Type recherche:'                                                     +
003670000000                ) +
003671000000                SEV(0) +
003672000000     /*   No replacement variables defined!                         */ +
003673000000                ALROPT(*NO) +
003674000000                CCSID(65535) +
003675000000                /*  -EOF-  */
003676000000
003677000000     /*-------------------------------------------------------------*/
003678000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0040                    */
003679000000     /* (Normal/Underline/Reverse/Pin)                              */
003680000000     /*-------------------------------------------------------------*/
003681000000
003682000000             RMVMSGD MSGID(TXT0040) MSGF(&LIB/&OBJ)
003683000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003684000000
003685000000             ADDMSGD +
003686000000                MSGID(TXT0040) +
003687000000                MSGF(&LIB/&OBJ) +
003688000000                MSG( +
003689000000'(Normal/Underline/Reverse/Pin)'                                      +
003690000000                ) +
003691000000                SEV(0) +
003692000000     /*   No replacement variables defined!                         */ +
003693000000                ALROPT(*NO) +
003694000000                CCSID(65535) +
003695000000                /*  -EOF-  */
003696000000
003697000000     /*-------------------------------------------------------------*/
003698000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0041                    */
003699000000     /* Respect casse :                                             */
003700000000     /*-------------------------------------------------------------*/
003701000000
003702000000             RMVMSGD MSGID(TXT0041) MSGF(&LIB/&OBJ)
003703000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003704000000
003705000000             ADDMSGD +
003706000000                MSGID(TXT0041) +
003707000000                MSGF(&LIB/&OBJ) +
003708000000                MSG( +
003709000000'Respect casse :'                                                     +
003710000000                ) +
003711000000                SEV(0) +
003712000000     /*   No replacement variables defined!                         */ +
003713000000                ALROPT(*NO) +
003714000000                CCSID(65535) +
003715000000                /*  -EOF-  */
003716000000
003717000000     /*-------------------------------------------------------------*/
003718000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0042                    */
003719000000     /* (1=Oui, 0=Non)                                              */
003720000000     /*-------------------------------------------------------------*/
003721000000
003722000000             RMVMSGD MSGID(TXT0042) MSGF(&LIB/&OBJ)
003723000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003724000000
003725000000             ADDMSGD +
003726000000                MSGID(TXT0042) +
003727000000                MSGF(&LIB/&OBJ) +
003728000000                MSG( +
003729000000'(1=Oui, 0=Non)'                                                      +
003730000000                ) +
003731000000                SEV(0) +
003732000000     /*   No replacement variables defined!                         */ +
003733000000                ALROPT(*NO) +
003734000000                CCSID(65535) +
003735000000                /*  -EOF-  */
003736000000
003737000000     /*-------------------------------------------------------------*/
003738000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0043                    */
003739000000     /*    - Couleur -                                              */
003740000000     /*-------------------------------------------------------------*/
003741000000
003742000000             RMVMSGD MSGID(TXT0043) MSGF(&LIB/&OBJ)
003743000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003744000000
003745000000             ADDMSGD +
003746000000                MSGID(TXT0043) +
003747000000                MSGF(&LIB/&OBJ) +
003748000000                MSG( +
003749000000'   - Couleur -'                                                      +
003750000000                ) +
003751000000                SEV(0) +
003752000000     /*   No replacement variables defined!                         */ +
003753000000                ALROPT(*NO) +
003754000000                CCSID(65535) +
003755000000                /*  -EOF-  */
003756000000
003757000000     /*-------------------------------------------------------------*/
003758000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0044                    */
003759000000     /* -  Choix Couleur  -                                         */
003760000000     /*-------------------------------------------------------------*/
003761000000
003762000000             RMVMSGD MSGID(TXT0044) MSGF(&LIB/&OBJ)
003763000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003764000000
003765000000             ADDMSGD +
003766000000                MSGID(TXT0044) +
003767000000                MSGF(&LIB/&OBJ) +
003768000000                MSG( +
003769000000'-  Choix Couleur  -'                                                 +
003770000000                ) +
003771000000                SEV(0) +
003772000000     /*   No replacement variables defined!                         */ +
003773000000                ALROPT(*NO) +
003774000000                CCSID(65535) +
003775000000                /*  -EOF-  */
003776000000
003777000000     /*-------------------------------------------------------------*/
003778000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0045                    */
003779000000     /* Vert                                                        */
003780000000     /*-------------------------------------------------------------*/
003781000000
003782000000             RMVMSGD MSGID(TXT0045) MSGF(&LIB/&OBJ)
003783000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003784000000
003785000000             ADDMSGD +
003786000000                MSGID(TXT0045) +
003787000000                MSGF(&LIB/&OBJ) +
003788000000                MSG( +
003789000000'Vert     '                                                           +
003790000000                ) +
003791000000                SEV(0) +
003792000000     /*   No replacement variables defined!                         */ +
003793000000                ALROPT(*NO) +
003794000000                CCSID(65535) +
003795000000                /*  -EOF-  */
003796000000
003797000000     /*-------------------------------------------------------------*/
003798000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0046                    */
003799000000     /* Blanc                                                       */
003800000000     /*-------------------------------------------------------------*/
003801000000
003802000000             RMVMSGD MSGID(TXT0046) MSGF(&LIB/&OBJ)
003803000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003804000000
003805000000             ADDMSGD +
003806000000                MSGID(TXT0046) +
003807000000                MSGF(&LIB/&OBJ) +
003808000000                MSG( +
003809000000'Blanc    '                                                           +
003810000000                ) +
003811000000                SEV(0) +
003812000000     /*   No replacement variables defined!                         */ +
003813000000                ALROPT(*NO) +
003814000000                CCSID(65535) +
003815000000                /*  -EOF-  */
003816000000
003817000000     /*-------------------------------------------------------------*/
003818000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0047                    */
003819000000     /* Rouge                                                       */
003820000000     /*-------------------------------------------------------------*/
003821000000
003822000000             RMVMSGD MSGID(TXT0047) MSGF(&LIB/&OBJ)
003823000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003824000000
003825000000             ADDMSGD +
003826000000                MSGID(TXT0047) +
003827000000                MSGF(&LIB/&OBJ) +
003828000000                MSG( +
003829000000'Rouge    '                                                           +
003830000000                ) +
003831000000                SEV(0) +
003832000000     /*   No replacement variables defined!                         */ +
003833000000                ALROPT(*NO) +
003834000000                CCSID(65535) +
003835000000                /*  -EOF-  */
003836000000
003837000000     /*-------------------------------------------------------------*/
003838000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0048                    */
003839000000     /* Turquoise                                                   */
003840000000     /*-------------------------------------------------------------*/
003841000000
003842000000             RMVMSGD MSGID(TXT0048) MSGF(&LIB/&OBJ)
003843000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003844000000
003845000000             ADDMSGD +
003846000000                MSGID(TXT0048) +
003847000000                MSGF(&LIB/&OBJ) +
003848000000                MSG( +
003849000000'Turquoise'                                                           +
003850000000                ) +
003851000000                SEV(0) +
003852000000     /*   No replacement variables defined!                         */ +
003853000000                ALROPT(*NO) +
003854000000                CCSID(65535) +
003855000000                /*  -EOF-  */
003856000000
003857000000     /*-------------------------------------------------------------*/
003858000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0049                    */
003859000000     /* Jaune                                                       */
003860000000     /*-------------------------------------------------------------*/
003861000000
003862000000             RMVMSGD MSGID(TXT0049) MSGF(&LIB/&OBJ)
003863000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003864000000
003865000000             ADDMSGD +
003866000000                MSGID(TXT0049) +
003867000000                MSGF(&LIB/&OBJ) +
003868000000                MSG( +
003869000000'Jaune    '                                                           +
003870000000                ) +
003871000000                SEV(0) +
003872000000     /*   No replacement variables defined!                         */ +
003873000000                ALROPT(*NO) +
003874000000                CCSID(65535) +
003875000000                /*  -EOF-  */
003876000000
003877000000     /*-------------------------------------------------------------*/
003878000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0050                    */
003879000000     /* Rose                                                        */
003880000000     /*-------------------------------------------------------------*/
003881000000
003882000000             RMVMSGD MSGID(TXT0050) MSGF(&LIB/&OBJ)
003883000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003884000000
003885000000             ADDMSGD +
003886000000                MSGID(TXT0050) +
003887000000                MSGF(&LIB/&OBJ) +
003888000000                MSG( +
003889000000'Rose     '                                                           +
003890000000                ) +
003891000000                SEV(0) +
003892000000     /*   No replacement variables defined!                         */ +
003893000000                ALROPT(*NO) +
003894000000                CCSID(65535) +
003895000000                /*  -EOF-  */
003896000000
003897000000     /*-------------------------------------------------------------*/
003898000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0051                    */
003899000000     /* Bleu                                                        */
003900000000     /*-------------------------------------------------------------*/
003901000000
003902000000             RMVMSGD MSGID(TXT0051) MSGF(&LIB/&OBJ)
003903000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003904000000
003905000000             ADDMSGD +
003906000000                MSGID(TXT0051) +
003907000000                MSGF(&LIB/&OBJ) +
003908000000                MSG( +
003909000000'Bleu     '                                                           +
003910000000                ) +
003911000000                SEV(0) +
003912000000     /*   No replacement variables defined!                         */ +
003913000000                ALROPT(*NO) +
003914000000                CCSID(65535) +
003915000000                /*  -EOF-  */
003916000000
003917000000     /*-------------------------------------------------------------*/
003918000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0052                    */
003919000000     /* - Copier vers fic.-                                         */
003920000000     /*-------------------------------------------------------------*/
003921000000
003922000000             RMVMSGD MSGID(TXT0052) MSGF(&LIB/&OBJ)
003923000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003924000000
003925000000             ADDMSGD +
003926000000                MSGID(TXT0052) +
003927000000                MSGF(&LIB/&OBJ) +
003928000000                MSG( +
003929000000'- Copier vers fic.-'                                                 +
003930000000                ) +
003931000000                SEV(0) +
003932000000     /*   No replacement variables defined!                         */ +
003933000000                ALROPT(*NO) +
003934000000                CCSID(65535) +
003935000000                /*  -EOF-  */
003936000000
003937000000     /*-------------------------------------------------------------*/
003938000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0053                    */
003939000000     /* Fichier..........:                                          */
003940000000     /*-------------------------------------------------------------*/
003941000000
003942000000             RMVMSGD MSGID(TXT0053) MSGF(&LIB/&OBJ)
003943000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003944000000
003945000000             ADDMSGD +
003946000000                MSGID(TXT0053) +
003947000000                MSGF(&LIB/&OBJ) +
003948000000                MSG( +
003949000000'Fichier..........:'                                                  +
003950000000                ) +
003951000000                SEV(0) +
003952000000     /*   No replacement variables defined!                         */ +
003953000000                ALROPT(*NO) +
003954000000                CCSID(65535) +
003955000000                /*  -EOF-  */
003956000000
003957000000     /*-------------------------------------------------------------*/
003958000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0054                    */
003959000000     /* Bibliothüque.....:                                          */
003960000000     /*-------------------------------------------------------------*/
003961000000
003962000000             RMVMSGD MSGID(TXT0054) MSGF(&LIB/&OBJ)
003963000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003964000000
003965000000             ADDMSGD +
003966000000                MSGID(TXT0054) +
003967000000                MSGF(&LIB/&OBJ) +
003968000000                MSG( +
003969000000'Bibliothüque.....:'                                                  +
003970000000                ) +
003971000000                SEV(0) +
003972000000     /*   No replacement variables defined!                         */ +
003973000000                ALROPT(*NO) +
003974000000                CCSID(65535) +
003975000000                /*  -EOF-  */
003976000000
003977000000     /*-------------------------------------------------------------*/
003978000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0055                    */
003979000000     /* Membre ..........:                                          */
003980000000     /*-------------------------------------------------------------*/
003981000000
003982000000             RMVMSGD MSGID(TXT0055) MSGF(&LIB/&OBJ)
003983000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
003984000000
003985000000             ADDMSGD +
003986000000                MSGID(TXT0055) +
003987000000                MSGF(&LIB/&OBJ) +
003988000000                MSG( +
003989000000'Membre ..........:'                                                  +
003990000000                ) +
003991000000                SEV(0) +
003992000000     /*   No replacement variables defined!                         */ +
003993000000                ALROPT(*NO) +
003994000000                CCSID(65535) +
003995000000                /*  -EOF-  */
003996000000
003997000000     /*-------------------------------------------------------------*/
003998000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0056                    */
003999000000     /* Remplacer enreg..:                                          */
004000000000     /*-------------------------------------------------------------*/
004001000000
004002000000             RMVMSGD MSGID(TXT0056) MSGF(&LIB/&OBJ)
004003000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004004000000
004005000000             ADDMSGD +
004006000000                MSGID(TXT0056) +
004007000000                MSGF(&LIB/&OBJ) +
004008000000                MSG( +
004009000000'Remplacer enreg..:'                                                  +
004010000000                ) +
004011000000                SEV(0) +
004012000000     /*   No replacement variables defined!                         */ +
004013000000                ALROPT(*NO) +
004014000000                CCSID(65535) +
004015000000                /*  -EOF-  */
004016000000
004017000000     /*-------------------------------------------------------------*/
004018000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0057                    */
004019000000     /* Cräer Fichier....:                                          */
004020000000     /*-------------------------------------------------------------*/
004021000000
004022000000             RMVMSGD MSGID(TXT0057) MSGF(&LIB/&OBJ)
004023000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004024000000
004025000000             ADDMSGD +
004026000000                MSGID(TXT0057) +
004027000000                MSGF(&LIB/&OBJ) +
004028000000                MSG( +
004029000000'Cräer Fichier....:'                                                  +
004030000000                ) +
004031000000                SEV(0) +
004032000000     /*   No replacement variables defined!                         */ +
004033000000                ALROPT(*NO) +
004034000000                CCSID(65535) +
004035000000                /*  -EOF-  */
004036000000
004037000000     /*-------------------------------------------------------------*/
004038000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0058                    */
004039000000     /* - Donnäes Licence -                                         */
004040000000     /*-------------------------------------------------------------*/
004041000000
004042000000             RMVMSGD MSGID(TXT0058) MSGF(&LIB/&OBJ)
004043000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004044000000
004045000000             ADDMSGD +
004046000000                MSGID(TXT0058) +
004047000000                MSGF(&LIB/&OBJ) +
004048000000                MSG( +
004049000000'- Donnäes Licence -'                                                 +
004050000000                ) +
004051000000                SEV(0) +
004052000000     /*   No replacement variables defined!                         */ +
004053000000                ALROPT(*NO) +
004054000000                CCSID(65535) +
004055000000                /*  -EOF-  */
004056000000
004057000000     /*-------------------------------------------------------------*/
004058000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0059                    */
004059000000     /* Licence-No:                                                 */
004060000000     /*-------------------------------------------------------------*/
004061000000
004062000000             RMVMSGD MSGID(TXT0059) MSGF(&LIB/&OBJ)
004063000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004064000000
004065000000             ADDMSGD +
004066000000                MSGID(TXT0059) +
004067000000                MSGF(&LIB/&OBJ) +
004068000000                MSG( +
004069000000'Licence-No:'                                                         +
004070000000                ) +
004071000000                SEV(0) +
004072000000     /*   No replacement variables defined!                         */ +
004073000000                ALROPT(*NO) +
004074000000                CCSID(65535) +
004075000000                /*  -EOF-  */
004076000000
004077000000     /*-------------------------------------------------------------*/
004078000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0060                    */
004079000000     /* F9=Testez!                                                  */
004080000000     /*-------------------------------------------------------------*/
004081000000
004082000000             RMVMSGD MSGID(TXT0060) MSGF(&LIB/&OBJ)
004083000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004084000000
004085000000             ADDMSGD +
004086000000                MSGID(TXT0060) +
004087000000                MSGF(&LIB/&OBJ) +
004088000000                MSG( +
004089000000'F9=Testez!'                                                          +
004090000000                ) +
004091000000                SEV(0) +
004092000000     /*   No replacement variables defined!                         */ +
004093000000                ALROPT(*NO) +
004094000000                CCSID(65535) +
004095000000                /*  -EOF-  */
004096000000
004097000000     /*-------------------------------------------------------------*/
004098000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0061                    */
004099000000     /* Les donnäes de la licence ont ätä sauvegardäes              */
004100000000     /*-------------------------------------------------------------*/
004101000000
004102000000             RMVMSGD MSGID(TXT0061) MSGF(&LIB/&OBJ)
004103000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004104000000
004105000000             ADDMSGD +
004106000000                MSGID(TXT0061) +
004107000000                MSGF(&LIB/&OBJ) +
004108000000                MSG( +
004109000000'Les donnäes de la licence ont ätä sauvegardäes'                      +
004110000000                ) +
004111000000                SEV(0) +
004112000000     /*   No replacement variables defined!                         */ +
004113000000                ALROPT(*NO) +
004114000000                CCSID(65535) +
004115000000                /*  -EOF-  */
004116000000
004117000000     /*-------------------------------------------------------------*/
004118000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0062                    */
004119000000     /* Däsolä, fin de la päriode ...........                       */
004120000000     /*-------------------------------------------------------------*/
004121000000
004122000000             RMVMSGD MSGID(TXT0062) MSGF(&LIB/&OBJ)
004123000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004124000000
004125000000             ADDMSGD +
004126000000                MSGID(TXT0062) +
004127000000                MSGF(&LIB/&OBJ) +
004128000000                MSG( +
004129000000'Däsolä, fin de la päriode ...........'                               +
004130000000                ) +
004131000000                SEV(0) +
004132000000     /*   No replacement variables defined!                         */ +
004133000000                ALROPT(*NO) +
004134000000                CCSID(65535) +
004135000000                /*  -EOF-  */
004136000000
004137000000     /*-------------------------------------------------------------*/
004138000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0063                    */
004139000000     /* ENTREE pour modif.                                          */
004140000000     /*-------------------------------------------------------------*/
004141000000
004142000000             RMVMSGD MSGID(TXT0063) MSGF(&LIB/&OBJ)
004143000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004144000000
004145000000             ADDMSGD +
004146000000                MSGID(TXT0063) +
004147000000                MSGF(&LIB/&OBJ) +
004148000000                MSG( +
004149000000'ENTREE pour modif.'                                                  +
004150000000                ) +
004151000000                SEV(0) +
004152000000     /*   No replacement variables defined!                         */ +
004153000000                ALROPT(*NO) +
004154000000                CCSID(65535) +
004155000000                /*  -EOF-  */
004156000000
004157000000     /*-------------------------------------------------------------*/
004158000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0064                    */
004159000000     /* ENTREE pour copie                                           */
004160000000     /*-------------------------------------------------------------*/
004161000000
004162000000             RMVMSGD MSGID(TXT0064) MSGF(&LIB/&OBJ)
004163000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004164000000
004165000000             ADDMSGD +
004166000000                MSGID(TXT0064) +
004167000000                MSGF(&LIB/&OBJ) +
004168000000                MSG( +
004169000000'ENTREE pour copie'                                                   +
004170000000                ) +
004171000000                SEV(0) +
004172000000     /*   No replacement variables defined!                         */ +
004173000000                ALROPT(*NO) +
004174000000                CCSID(65535) +
004175000000                /*  -EOF-  */
004176000000
004177000000     /*-------------------------------------------------------------*/
004178000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0065                    */
004179000000     /* ENTREE pour ajout                                           */
004180000000     /*-------------------------------------------------------------*/
004181000000
004182000000             RMVMSGD MSGID(TXT0065) MSGF(&LIB/&OBJ)
004183000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004184000000
004185000000             ADDMSGD +
004186000000                MSGID(TXT0065) +
004187000000                MSGF(&LIB/&OBJ) +
004188000000                MSG( +
004189000000'ENTREE pour ajout'                                                   +
004190000000                ) +
004191000000                SEV(0) +
004192000000     /*   No replacement variables defined!                         */ +
004193000000                ALROPT(*NO) +
004194000000                CCSID(65535) +
004195000000                /*  -EOF-  */
004196000000
004197000000     /*-------------------------------------------------------------*/
004198000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0066                    */
004199000000     /* A suivre...                                                 */
004200000000     /*-------------------------------------------------------------*/
004201000000
004202000000             RMVMSGD MSGID(TXT0066) MSGF(&LIB/&OBJ)
004203000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004204000000
004205000000             ADDMSGD +
004206000000                MSGID(TXT0066) +
004207000000                MSGF(&LIB/&OBJ) +
004208000000                MSG( +
004209000000'A suivre...'                                                         +
004210000000                ) +
004211000000                SEV(0) +
004212000000     /*   No replacement variables defined!                         */ +
004213000000                ALROPT(*NO) +
004214000000                CCSID(65535) +
004215000000                /*  -EOF-  */
004216000000
004217000000     /*-------------------------------------------------------------*/
004218000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0067                    */
004219000000     /*         Fin                                                 */
004220000000     /*-------------------------------------------------------------*/
004221000000
004222000000             RMVMSGD MSGID(TXT0067) MSGF(&LIB/&OBJ)
004223000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004224000000
004225000000             ADDMSGD +
004226000000                MSGID(TXT0067) +
004227000000                MSGF(&LIB/&OBJ) +
004228000000                MSG( +
004229000000'        Fin'                                                         +
004230000000                ) +
004231000000                SEV(0) +
004232000000     /*   No replacement variables defined!                         */ +
004233000000                ALROPT(*NO) +
004234000000                CCSID(65535) +
004235000000                /*  -EOF-  */
004236000000
004237000000     /*-------------------------------------------------------------*/
004238000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0068                    */
004239000000     /* Journalisation                                              */
004240000000     /*-------------------------------------------------------------*/
004241000000
004242000000             RMVMSGD MSGID(TXT0068) MSGF(&LIB/&OBJ)
004243000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004244000000
004245000000             ADDMSGD +
004246000000                MSGID(TXT0068) +
004247000000                MSGF(&LIB/&OBJ) +
004248000000                MSG( +
004249000000'Journalisation'                                                      +
004250000000                ) +
004251000000                SEV(0) +
004252000000     /*   No replacement variables defined!                         */ +
004253000000                ALROPT(*NO) +
004254000000                CCSID(65535) +
004255000000                /*  -EOF-  */
004256000000
004257000000     /*-------------------------------------------------------------*/
004258000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0069                    */
004259000000     /* Mode äcran 80/132 car.                                      */
004260000000     /*-------------------------------------------------------------*/
004261000000
004262000000             RMVMSGD MSGID(TXT0069) MSGF(&LIB/&OBJ)
004263000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004264000000
004265000000             ADDMSGD +
004266000000                MSGID(TXT0069) +
004267000000                MSGF(&LIB/&OBJ) +
004268000000                MSG( +
004269000000'Mode äcran 80/132 car.'                                              +
004270000000                ) +
004271000000                SEV(0) +
004272000000     /*   No replacement variables defined!                         */ +
004273000000                ALROPT(*NO) +
004274000000                CCSID(65535) +
004275000000                /*  -EOF-  */
004276000000
004277000000     /*-------------------------------------------------------------*/
004278000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0070                    */
004279000000     /* Moteur de recherche puissant                                */
004280000000     /*-------------------------------------------------------------*/
004281000000
004282000000             RMVMSGD MSGID(TXT0070) MSGF(&LIB/&OBJ)
004283000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004284000000
004285000000             ADDMSGD +
004286000000                MSGID(TXT0070) +
004287000000                MSGF(&LIB/&OBJ) +
004288000000                MSG( +
004289000000'Moteur de recherche puissant'                                        +
004290000000                ) +
004291000000                SEV(0) +
004292000000     /*   No replacement variables defined!                         */ +
004293000000                ALROPT(*NO) +
004294000000                CCSID(65535) +
004295000000                /*  -EOF-  */
004296000000
004297000000     /*-------------------------------------------------------------*/
004298000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0071                    */
004299000000     /* Touches de fonction personnalisables                        */
004300000000     /*-------------------------------------------------------------*/
004301000000
004302000000             RMVMSGD MSGID(TXT0071) MSGF(&LIB/&OBJ)
004303000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004304000000
004305000000             ADDMSGD +
004306000000                MSGID(TXT0071) +
004307000000                MSGF(&LIB/&OBJ) +
004308000000                MSG( +
004309000000'Touches de fonction personnalisables'                                +
004310000000                ) +
004311000000                SEV(0) +
004312000000     /*   No replacement variables defined!                         */ +
004313000000                ALROPT(*NO) +
004314000000                CCSID(65535) +
004315000000                /*  -EOF-  */
004316000000
004317000000     /*-------------------------------------------------------------*/
004318000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0072                    */
004319000000     /* Choix de la langue                                          */
004320000000     /*-------------------------------------------------------------*/
004321000000
004322000000             RMVMSGD MSGID(TXT0072) MSGF(&LIB/&OBJ)
004323000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004324000000
004325000000             ADDMSGD +
004326000000                MSGID(TXT0072) +
004327000000                MSGF(&LIB/&OBJ) +
004328000000                MSG( +
004329000000'Choix de la langue'                                                  +
004330000000                ) +
004331000000                SEV(0) +
004332000000     /*   No replacement variables defined!                         */ +
004333000000                ALROPT(*NO) +
004334000000                CCSID(65535) +
004335000000                /*  -EOF-  */
004336000000
004337000000     /*-------------------------------------------------------------*/
004338000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0073                    */
004339000000     /*   L'ultime                                                  */
004340000000     /*-------------------------------------------------------------*/
004341000000
004342000000             RMVMSGD MSGID(TXT0073) MSGF(&LIB/&OBJ)
004343000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004344000000
004345000000             ADDMSGD +
004346000000                MSGID(TXT0073) +
004347000000                MSGF(&LIB/&OBJ) +
004348000000                MSG( +
004349000000'  L''ultime'                                                         +
004350000000                ) +
004351000000                SEV(0) +
004352000000     /*   No replacement variables defined!                         */ +
004353000000                ALROPT(*NO) +
004354000000                CCSID(65535) +
004355000000                /*  -EOF-  */
004356000000
004357000000     /*-------------------------------------------------------------*/
004358000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0074                    */
004359000000     /* navigateur de base de donnäes                               */
004360000000     /*-------------------------------------------------------------*/
004361000000
004362000000             RMVMSGD MSGID(TXT0074) MSGF(&LIB/&OBJ)
004363000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004364000000
004365000000             ADDMSGD +
004366000000                MSGID(TXT0074) +
004367000000                MSGF(&LIB/&OBJ) +
004368000000                MSG( +
004369000000'navigateur de base de donnäes'                                       +
004370000000                ) +
004371000000                SEV(0) +
004372000000     /*   No replacement variables defined!                         */ +
004373000000                ALROPT(*NO) +
004374000000                CCSID(65535) +
004375000000                /*  -EOF-  */
004376000000
004377000000     /*-------------------------------------------------------------*/
004378000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0075                    */
004379000000     /*       * Points forts *                                      */
004380000000     /*-------------------------------------------------------------*/
004381000000
004382000000             RMVMSGD MSGID(TXT0075) MSGF(&LIB/&OBJ)
004383000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004384000000
004385000000             ADDMSGD +
004386000000                MSGID(TXT0075) +
004387000000                MSGF(&LIB/&OBJ) +
004388000000                MSG( +
004389000000'      * Points forts *      '                                        +
004390000000                ) +
004391000000                SEV(0) +
004392000000     /*   No replacement variables defined!                         */ +
004393000000                ALROPT(*NO) +
004394000000                CCSID(65535) +
004395000000                /*  -EOF-  */
004396000000
004397000000     /*-------------------------------------------------------------*/
004398000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0076                    */
004399000000     /* Caractüre non imprimable                                    */
004400000000     /*-------------------------------------------------------------*/
004401000000
004402000000             RMVMSGD MSGID(TXT0076) MSGF(&LIB/&OBJ)
004403000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004404000000
004405000000             ADDMSGD +
004406000000                MSGID(TXT0076) +
004407000000                MSGF(&LIB/&OBJ) +
004408000000                MSG( +
004409000000'Caractüre non imprimable'                                            +
004410000000                ) +
004411000000                SEV(0) +
004412000000     /*   No replacement variables defined!                         */ +
004413000000                ALROPT(*NO) +
004414000000                CCSID(65535) +
004415000000                /*  -EOF-  */
004416000000
004417000000     /*-------------------------------------------------------------*/
004418000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0077                    */
004419000000     /* -Maquette-                                                  */
004420000000     /*-------------------------------------------------------------*/
004421000000
004422000000             RMVMSGD MSGID(TXT0077) MSGF(&LIB/&OBJ)
004423000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004424000000
004425000000             ADDMSGD +
004426000000                MSGID(TXT0077) +
004427000000                MSGF(&LIB/&OBJ) +
004428000000                MSG( +
004429000000'-Maquette-'                                                          +
004430000000                ) +
004431000000                SEV(0) +
004432000000     /*   No replacement variables defined!                         */ +
004433000000                ALROPT(*NO) +
004434000000                CCSID(65535) +
004435000000                /*  -EOF-  */
004436000000
004437000000     /*-------------------------------------------------------------*/
004438000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0078                    */
004439000000     /* Rech.:                                                      */
004440000000     /*-------------------------------------------------------------*/
004441000000
004442000000             RMVMSGD MSGID(TXT0078) MSGF(&LIB/&OBJ)
004443000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004444000000
004445000000             ADDMSGD +
004446000000                MSGID(TXT0078) +
004447000000                MSGF(&LIB/&OBJ) +
004448000000                MSG( +
004449000000'Rech.:'                                                              +
004450000000                ) +
004451000000                SEV(0) +
004452000000     /*   No replacement variables defined!                         */ +
004453000000                ALROPT(*NO) +
004454000000                CCSID(65535) +
004455000000                /*  -EOF-  */
004456000000
004457000000     /*-------------------------------------------------------------*/
004458000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0079                    */
004459000000     /*  O   Enr.   Champ       Description                     Typ */
004460000000     /*-------------------------------------------------------------*/
004461000000
004462000000             RMVMSGD MSGID(TXT0079) MSGF(&LIB/&OBJ)
004463000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004464000000
004465000000             ADDMSGD +
004466000000                MSGID(TXT0079) +
004467000000                MSGF(&LIB/&OBJ) +
004468000000                MSG( +
004469000000' O   Enr.   Champ       Description                     Type      Pos-
004470000000.däb '                                                                +
004471000000                ) +
004472000000                SEV(0) +
004473000000     /*   No replacement variables defined!                         */ +
004474000000                ALROPT(*NO) +
004475000000                CCSID(65535) +
004476000000                /*  -EOF-  */
004477000000
004478000000     /*-------------------------------------------------------------*/
004479000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0080                    */
004480000000     /* Visible ..:                                                 */
004481000000     /*-------------------------------------------------------------*/
004482000000
004483000000             RMVMSGD MSGID(TXT0080) MSGF(&LIB/&OBJ)
004484000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004485000000
004486000000             ADDMSGD +
004487000000                MSGID(TXT0080) +
004488000000                MSGF(&LIB/&OBJ) +
004489000000                MSG( +
004490000000'Visible ..:'                                                         +
004491000000                ) +
004492000000                SEV(0) +
004493000000     /*   No replacement variables defined!                         */ +
004494000000                ALROPT(*NO) +
004495000000                CCSID(65535) +
004496000000                /*  -EOF-  */
004497000000
004498000000     /*-------------------------------------------------------------*/
004499000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0081                    */
004500000000     /* Couleur.:                                                   */
004501000000     /*-------------------------------------------------------------*/
004502000000
004503000000             RMVMSGD MSGID(TXT0081) MSGF(&LIB/&OBJ)
004504000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004505000000
004506000000             ADDMSGD +
004507000000                MSGID(TXT0081) +
004508000000                MSGF(&LIB/&OBJ) +
004509000000                MSG( +
004510000000'Couleur.:'                                                           +
004511000000                ) +
004512000000                SEV(0) +
004513000000     /*   No replacement variables defined!                         */ +
004514000000                ALROPT(*NO) +
004515000000                CCSID(65535) +
004516000000                /*  -EOF-  */
004517000000
004518000000     /*-------------------------------------------------------------*/
004519000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0082                    */
004520000000     /* Sälection :                                                 */
004521000000     /*-------------------------------------------------------------*/
004522000000
004523000000             RMVMSGD MSGID(TXT0082) MSGF(&LIB/&OBJ)
004524000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004525000000
004526000000             ADDMSGD +
004527000000                MSGID(TXT0082) +
004528000000                MSGF(&LIB/&OBJ) +
004529000000                MSG( +
004530000000'Sälection :'                                                         +
004531000000                ) +
004532000000                SEV(0) +
004533000000     /*   No replacement variables defined!                         */ +
004534000000                ALROPT(*NO) +
004535000000                CCSID(65535) +
004536000000                /*  -EOF-  */
004537000000
004538000000     /*-------------------------------------------------------------*/
004539000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0083                    */
004540000000     /* Largeur max                                                 */
004541000000     /*-------------------------------------------------------------*/
004542000000
004543000000             RMVMSGD MSGID(TXT0083) MSGF(&LIB/&OBJ)
004544000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004545000000
004546000000             ADDMSGD +
004547000000                MSGID(TXT0083) +
004548000000                MSGF(&LIB/&OBJ) +
004549000000                MSG( +
004550000000'Largeur max'                                                         +
004551000000                ) +
004552000000                SEV(0) +
004553000000     /*   No replacement variables defined!                         */ +
004554000000                ALROPT(*NO) +
004555000000                CCSID(65535) +
004556000000                /*  -EOF-  */
004557000000
004558000000     /*-------------------------------------------------------------*/
004559000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0084                    */
004560000000     /* Code Edi:                                                   */
004561000000     /*-------------------------------------------------------------*/
004562000000
004563000000             RMVMSGD MSGID(TXT0084) MSGF(&LIB/&OBJ)
004564000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004565000000
004566000000             ADDMSGD +
004567000000                MSGID(TXT0084) +
004568000000                MSGF(&LIB/&OBJ) +
004569000000                MSG( +
004570000000'Code Edi:'                                                           +
004571000000                ) +
004572000000                SEV(0) +
004573000000     /*   No replacement variables defined!                         */ +
004574000000                ALROPT(*NO) +
004575000000                CCSID(65535) +
004576000000                /*  -EOF-  */
004577000000
004578000000     /*-------------------------------------------------------------*/
004579000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0085                    */
004580000000     /* - Choix champ -                                             */
004581000000     /*-------------------------------------------------------------*/
004582000000
004583000000             RMVMSGD MSGID(TXT0085) MSGF(&LIB/&OBJ)
004584000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004585000000
004586000000             ADDMSGD +
004587000000                MSGID(TXT0085) +
004588000000                MSGF(&LIB/&OBJ) +
004589000000                MSG( +
004590000000'- Choix champ -'                                                     +
004591000000                ) +
004592000000                SEV(0) +
004593000000     /*   No replacement variables defined!                         */ +
004594000000                ALROPT(*NO) +
004595000000                CCSID(65535) +
004596000000                /*  -EOF-  */
004597000000
004598000000     /*-------------------------------------------------------------*/
004599000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0086                    */
004600000000     /*  O   Champ       Description                                */
004601000000     /*-------------------------------------------------------------*/
004602000000
004603000000             RMVMSGD MSGID(TXT0086) MSGF(&LIB/&OBJ)
004604000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004605000000
004606000000             ADDMSGD +
004607000000                MSGID(TXT0086) +
004608000000                MSGF(&LIB/&OBJ) +
004609000000                MSG( +
004610000000' O   Champ       Description                    '                    +
004611000000                ) +
004612000000                SEV(0) +
004613000000     /*   No replacement variables defined!                         */ +
004614000000                ALROPT(*NO) +
004615000000                CCSID(65535) +
004616000000                /*  -EOF-  */
004617000000
004618000000     /*-------------------------------------------------------------*/
004619000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0087                    */
004620000000     /*  O  Fichier                Description                      */
004621000000     /*-------------------------------------------------------------*/
004622000000
004623000000             RMVMSGD MSGID(TXT0087) MSGF(&LIB/&OBJ)
004624000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004625000000
004626000000             ADDMSGD +
004627000000                MSGID(TXT0087) +
004628000000                MSGF(&LIB/&OBJ) +
004629000000                MSG( +
004630000000' O  Fichier                Description                               -
004631000000   '                                                                  +
004632000000                ) +
004633000000                SEV(0) +
004634000000     /*   No replacement variables defined!                         */ +
004635000000                ALROPT(*NO) +
004636000000                CCSID(65535) +
004637000000                /*  -EOF-  */
004638000000
004639000000     /*-------------------------------------------------------------*/
004640000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0088                    */
004641000000     /* -Afficher relations fichiers-                               */
004642000000     /*-------------------------------------------------------------*/
004643000000
004644000000             RMVMSGD MSGID(TXT0088) MSGF(&LIB/&OBJ)
004645000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004646000000
004647000000             ADDMSGD +
004648000000                MSGID(TXT0088) +
004649000000                MSGF(&LIB/&OBJ) +
004650000000                MSG( +
004651000000'-Afficher relations fichiers-'                                       +
004652000000                ) +
004653000000                SEV(0) +
004654000000     /*   No replacement variables defined!                         */ +
004655000000                ALROPT(*NO) +
004656000000                CCSID(65535) +
004657000000                /*  -EOF-  */
004658000000
004659000000     /*-------------------------------------------------------------*/
004660000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0089                    */
004661000000     /* Däpendances:                                                */
004662000000     /*-------------------------------------------------------------*/
004663000000
004664000000             RMVMSGD MSGID(TXT0089) MSGF(&LIB/&OBJ)
004665000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004666000000
004667000000             ADDMSGD +
004668000000                MSGID(TXT0089) +
004669000000                MSGF(&LIB/&OBJ) +
004670000000                MSG( +
004671000000'Däpendances:'                                                        +
004672000000                ) +
004673000000                SEV(0) +
004674000000     /*   No replacement variables defined!                         */ +
004675000000                ALROPT(*NO) +
004676000000                CCSID(65535) +
004677000000                /*  -EOF-  */
004678000000
004679000000     /*-------------------------------------------------------------*/
004680000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0090                    */
004681000000     /* Editeur Hexa                                                */
004682000000     /*-------------------------------------------------------------*/
004683000000
004684000000             RMVMSGD MSGID(TXT0090) MSGF(&LIB/&OBJ)
004685000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004686000000
004687000000             ADDMSGD +
004688000000                MSGID(TXT0090) +
004689000000                MSGF(&LIB/&OBJ) +
004690000000                MSG( +
004691000000'Editeur Hexa'                                                        +
004692000000                ) +
004693000000                SEV(0) +
004694000000     /*   No replacement variables defined!                         */ +
004695000000                ALROPT(*NO) +
004696000000                CCSID(65535) +
004697000000                /*  -EOF-  */
004698000000
004699000000     /*-------------------------------------------------------------*/
004700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0091                    */
004701000000     /* Champ .....:                                                */
004702000000     /*-------------------------------------------------------------*/
004703000000
004704000000             RMVMSGD MSGID(TXT0091) MSGF(&LIB/&OBJ)
004705000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004706000000
004707000000             ADDMSGD +
004708000000                MSGID(TXT0091) +
004709000000                MSGF(&LIB/&OBJ) +
004710000000                MSG( +
004711000000'Champ .....:'                                                        +
004712000000                ) +
004713000000                SEV(0) +
004714000000     /*   No replacement variables defined!                         */ +
004715000000                ALROPT(*NO) +
004716000000                CCSID(65535) +
004717000000                /*  -EOF-  */
004718000000
004719000000     /*-------------------------------------------------------------*/
004720000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0092                    */
004721000000     /* Longueur...:                                                */
004722000000     /*-------------------------------------------------------------*/
004723000000
004724000000             RMVMSGD MSGID(TXT0092) MSGF(&LIB/&OBJ)
004725000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004726000000
004727000000             ADDMSGD +
004728000000                MSGID(TXT0092) +
004729000000                MSGF(&LIB/&OBJ) +
004730000000                MSG( +
004731000000'Longueur...:'                                                        +
004732000000                ) +
004733000000                SEV(0) +
004734000000     /*   No replacement variables defined!                         */ +
004735000000                ALROPT(*NO) +
004736000000                CCSID(65535) +
004737000000                /*  -EOF-  */
004738000000
004739000000     /*-------------------------------------------------------------*/
004740000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0093                    */
004741000000     /* Contenu ...:                                                */
004742000000     /*-------------------------------------------------------------*/
004743000000
004744000000             RMVMSGD MSGID(TXT0093) MSGF(&LIB/&OBJ)
004745000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004746000000
004747000000             ADDMSGD +
004748000000                MSGID(TXT0093) +
004749000000                MSGF(&LIB/&OBJ) +
004750000000                MSG( +
004751000000'Contenu ...:'                                                        +
004752000000                ) +
004753000000                SEV(0) +
004754000000     /*   No replacement variables defined!                         */ +
004755000000                ALROPT(*NO) +
004756000000                CCSID(65535) +
004757000000                /*  -EOF-  */
004758000000
004759000000     /*-------------------------------------------------------------*/
004760000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0094                    */
004761000000     /* Hexa ......:                                                */
004762000000     /*-------------------------------------------------------------*/
004763000000
004764000000             RMVMSGD MSGID(TXT0094) MSGF(&LIB/&OBJ)
004765000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004766000000
004767000000             ADDMSGD +
004768000000                MSGID(TXT0094) +
004769000000                MSGF(&LIB/&OBJ) +
004770000000                MSG( +
004771000000'Hexa ......:'                                                        +
004772000000                ) +
004773000000                SEV(0) +
004774000000     /*   No replacement variables defined!                         */ +
004775000000                ALROPT(*NO) +
004776000000                CCSID(65535) +
004777000000                /*  -EOF-  */
004778000000
004779000000     /*-------------------------------------------------------------*/
004780000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0095                    */
004781000000     /* Position däb.:                                              */
004782000000     /*-------------------------------------------------------------*/
004783000000
004784000000             RMVMSGD MSGID(TXT0095) MSGF(&LIB/&OBJ)
004785000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004786000000
004787000000             ADDMSGD +
004788000000                MSGID(TXT0095) +
004789000000                MSGF(&LIB/&OBJ) +
004790000000                MSG( +
004791000000'Position däb.:'                                                      +
004792000000                ) +
004793000000                SEV(0) +
004794000000     /*   No replacement variables defined!                         */ +
004795000000                ALROPT(*NO) +
004796000000                CCSID(65535) +
004797000000                /*  -EOF-  */
004798000000
004799000000     /*-------------------------------------------------------------*/
004800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0096                    */
004801000000     /* Tail. Tampon                                                */
004802000000     /*-------------------------------------------------------------*/
004803000000
004804000000             RMVMSGD MSGID(TXT0096) MSGF(&LIB/&OBJ)
004805000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004806000000
004807000000             ADDMSGD +
004808000000                MSGID(TXT0096) +
004809000000                MSGF(&LIB/&OBJ) +
004810000000                MSG( +
004811000000'Tail. Tampon'                                                        +
004812000000                ) +
004813000000                SEV(0) +
004814000000     /*   No replacement variables defined!                         */ +
004815000000                ALROPT(*NO) +
004816000000                CCSID(65535) +
004817000000                /*  -EOF-  */
004818000000
004819000000     /*-------------------------------------------------------------*/
004820000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0097                    */
004821000000     /*  A   Membre      Description                                */
004822000000     /*-------------------------------------------------------------*/
004823000000
004824000000             RMVMSGD MSGID(TXT0097) MSGF(&LIB/&OBJ)
004825000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004826000000
004827000000             ADDMSGD +
004828000000                MSGID(TXT0097) +
004829000000                MSGF(&LIB/&OBJ) +
004830000000                MSG( +
004831000000' A   Membre      Description                                        '+
004832000000                ) +
004833000000                SEV(0) +
004834000000     /*   No replacement variables defined!                         */ +
004835000000                ALROPT(*NO) +
004836000000                CCSID(65535) +
004837000000                /*  -EOF-  */
004838000000
004839000000     /*-------------------------------------------------------------*/
004840000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0098                    */
004841000000     /*   - Choix Membre -                                          */
004842000000     /*-------------------------------------------------------------*/
004843000000
004844000000             RMVMSGD MSGID(TXT0098) MSGF(&LIB/&OBJ)
004845000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004846000000
004847000000             ADDMSGD +
004848000000                MSGID(TXT0098) +
004849000000                MSGF(&LIB/&OBJ) +
004850000000                MSG( +
004851000000'  - Choix Membre -   '                                               +
004852000000                ) +
004853000000                SEV(0) +
004854000000     /*   No replacement variables defined!                         */ +
004855000000                ALROPT(*NO) +
004856000000                CCSID(65535) +
004857000000                /*  -EOF-  */
004858000000
004859000000     /*-------------------------------------------------------------*/
004860000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0099                    */
004861000000     /*  NÄ membre :                                                */
004862000000     /*-------------------------------------------------------------*/
004863000000
004864000000             RMVMSGD MSGID(TXT0099) MSGF(&LIB/&OBJ)
004865000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004866000000
004867000000             ADDMSGD +
004868000000                MSGID(TXT0099) +
004869000000                MSGF(&LIB/&OBJ) +
004870000000                MSG( +
004871000000' NÄ membre :'                                                        +
004872000000                ) +
004873000000                SEV(0) +
004874000000     /*   No replacement variables defined!                         */ +
004875000000                ALROPT(*NO) +
004876000000                CCSID(65535) +
004877000000                /*  -EOF-  */
004878000000
004879000000     /*-------------------------------------------------------------*/
004880000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0100                    */
004881000000     /* Mbr   :                                                     */
004882000000     /*-------------------------------------------------------------*/
004883000000
004884000000             RMVMSGD MSGID(TXT0100) MSGF(&LIB/&OBJ)
004885000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004886000000
004887000000             ADDMSGD +
004888000000                MSGID(TXT0100) +
004889000000                MSGF(&LIB/&OBJ) +
004890000000                MSG( +
004891000000'Mbr   :'                                                             +
004892000000                ) +
004893000000                SEV(0) +
004894000000     /*   No replacement variables defined!                         */ +
004895000000                ALROPT(*NO) +
004896000000                CCSID(65535) +
004897000000                /*  -EOF-  */
004898000000
004899000000     /*-------------------------------------------------------------*/
004900000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0101                    */
004901000000     /* - Peek/400 -                                                */
004902000000     /*-------------------------------------------------------------*/
004903000000
004904000000             RMVMSGD MSGID(TXT0101) MSGF(&LIB/&OBJ)
004905000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004906000000
004907000000             ADDMSGD +
004908000000                MSGID(TXT0101) +
004909000000                MSGF(&LIB/&OBJ) +
004910000000                MSG( +
004911000000'- Peek/400 -'                                                        +
004912000000                ) +
004913000000                SEV(0) +
004914000000     /*   No replacement variables defined!                         */ +
004915000000                ALROPT(*NO) +
004916000000                CCSID(65535) +
004917000000                /*  -EOF-  */
004918000000
004919000000     /*-------------------------------------------------------------*/
004920000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0102                    */
004921000000     /* Date  . . .                                                 */
004922000000     /*-------------------------------------------------------------*/
004923000000
004924000000             RMVMSGD MSGID(TXT0102) MSGF(&LIB/&OBJ)
004925000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004926000000
004927000000             ADDMSGD +
004928000000                MSGID(TXT0102) +
004929000000                MSGF(&LIB/&OBJ) +
004930000000                MSG( +
004931000000'Date  . . .'                                                         +
004932000000                ) +
004933000000                SEV(0) +
004934000000     /*   No replacement variables defined!                         */ +
004935000000                ALROPT(*NO) +
004936000000                CCSID(65535) +
004937000000                /*  -EOF-  */
004938000000
004939000000     /*-------------------------------------------------------------*/
004940000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0103                    */
004941000000     /* Version . .                                                 */
004942000000     /*-------------------------------------------------------------*/
004943000000
004944000000             RMVMSGD MSGID(TXT0103) MSGF(&LIB/&OBJ)
004945000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004946000000
004947000000             ADDMSGD +
004948000000                MSGID(TXT0103) +
004949000000                MSGF(&LIB/&OBJ) +
004950000000                MSG( +
004951000000'Version . .'                                                         +
004952000000                ) +
004953000000                SEV(0) +
004954000000     /*   No replacement variables defined!                         */ +
004955000000                ALROPT(*NO) +
004956000000                CCSID(65535) +
004957000000                /*  -EOF-  */
004958000000
004959000000     /*-------------------------------------------------------------*/
004960000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0104                    */
004961000000     /* E-mail  . .                                                 */
004962000000     /*-------------------------------------------------------------*/
004963000000
004964000000             RMVMSGD MSGID(TXT0104) MSGF(&LIB/&OBJ)
004965000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004966000000
004967000000             ADDMSGD +
004968000000                MSGID(TXT0104) +
004969000000                MSGF(&LIB/&OBJ) +
004970000000                MSG( +
004971000000'E-mail  . .'                                                         +
004972000000                ) +
004973000000                SEV(0) +
004974000000     /*   No replacement variables defined!                         */ +
004975000000                ALROPT(*NO) +
004976000000                CCSID(65535) +
004977000000                /*  -EOF-  */
004978000000
004979000000     /*-------------------------------------------------------------*/
004980000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0105                    */
004981000000     /* Homepage  .                                                 */
004982000000     /*-------------------------------------------------------------*/
004983000000
004984000000             RMVMSGD MSGID(TXT0105) MSGF(&LIB/&OBJ)
004985000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004986000000
004987000000             ADDMSGD +
004988000000                MSGID(TXT0105) +
004989000000                MSGF(&LIB/&OBJ) +
004990000000                MSG( +
004991000000'Homepage  .'                                                         +
004992000000                ) +
004993000000                SEV(0) +
004994000000     /*   No replacement variables defined!                         */ +
004995000000                ALROPT(*NO) +
004996000000                CCSID(65535) +
004997000000                /*  -EOF-  */
004998000000
004999000000     /*-------------------------------------------------------------*/
005000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0106                    */
005001000000     /* Fixer champs                                                */
005002000000     /*-------------------------------------------------------------*/
005003000000
005004000000             RMVMSGD MSGID(TXT0106) MSGF(&LIB/&OBJ)
005005000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005006000000
005007000000             ADDMSGD +
005008000000                MSGID(TXT0106) +
005009000000                MSGF(&LIB/&OBJ) +
005010000000                MSG( +
005011000000'Fixer champs'                                                        +
005012000000                ) +
005013000000                SEV(0) +
005014000000     /*   No replacement variables defined!                         */ +
005015000000                ALROPT(*NO) +
005016000000                CCSID(65535) +
005017000000                /*  -EOF-  */
005018000000
005019000000     /*-------------------------------------------------------------*/
005020000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0107                    */
005021000000     /*  NÄEnr. Champ       Description                      Champ  */
005022000000     /*-------------------------------------------------------------*/
005023000000
005024000000             RMVMSGD MSGID(TXT0107) MSGF(&LIB/&OBJ)
005025000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005026000000
005027000000             ADDMSGD +
005028000000                MSGID(TXT0107) +
005029000000                MSGF(&LIB/&OBJ) +
005030000000                MSG( +
005031000000' NÄEnr. Champ       Description                      Champ clä'      +
005032000000                ) +
005033000000                SEV(0) +
005034000000     /*   No replacement variables defined!                         */ +
005035000000                ALROPT(*NO) +
005036000000                CCSID(65535) +
005037000000                /*  -EOF-  */
005038000000
005039000000     /*-------------------------------------------------------------*/
005040000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0108                    */
005041000000     /* - Sälection SQL -                                           */
005042000000     /*-------------------------------------------------------------*/
005043000000
005044000000             RMVMSGD MSGID(TXT0108) MSGF(&LIB/&OBJ)
005045000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005046000000
005047000000             ADDMSGD +
005048000000                MSGID(TXT0108) +
005049000000                MSGF(&LIB/&OBJ) +
005050000000                MSG( +
005051000000'- Sälection SQL -'                                                   +
005052000000                ) +
005053000000                SEV(0) +
005054000000     /*   No replacement variables defined!                         */ +
005055000000                ALROPT(*NO) +
005056000000                CCSID(65535) +
005057000000                /*  -EOF-  */
005058000000
005059000000     /*-------------------------------------------------------------*/
005060000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0109                    */
005061000000     /* WHERE  ....:                                                */
005062000000     /*-------------------------------------------------------------*/
005063000000
005064000000             RMVMSGD MSGID(TXT0109) MSGF(&LIB/&OBJ)
005065000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005066000000
005067000000             ADDMSGD +
005068000000                MSGID(TXT0109) +
005069000000                MSGF(&LIB/&OBJ) +
005070000000                MSG( +
005071000000'WHERE  ....:'                                                        +
005072000000                ) +
005073000000                SEV(0) +
005074000000     /*   No replacement variables defined!                         */ +
005075000000                ALROPT(*NO) +
005076000000                CCSID(65535) +
005077000000                /*  -EOF-  */
005078000000
005079000000     /*-------------------------------------------------------------*/
005080000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0110                    */
005081000000     /* ORDER BY  .:                                                */
005082000000     /*-------------------------------------------------------------*/
005083000000
005084000000             RMVMSGD MSGID(TXT0110) MSGF(&LIB/&OBJ)
005085000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005086000000
005087000000             ADDMSGD +
005088000000                MSGID(TXT0110) +
005089000000                MSGF(&LIB/&OBJ) +
005090000000                MSG( +
005091000000'ORDER BY  .:'                                                        +
005092000000                ) +
005093000000                SEV(0) +
005094000000     /*   No replacement variables defined!                         */ +
005095000000                ALROPT(*NO) +
005096000000                CCSID(65535) +
005097000000                /*  -EOF-  */
005098000000
005099000000     /*-------------------------------------------------------------*/
005100000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0111                    */
005101000000     /* -Cräer Programme M§j-                                       */
005102000000     /*-------------------------------------------------------------*/
005103000000
005104000000             RMVMSGD MSGID(TXT0111) MSGF(&LIB/&OBJ)
005105000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005106000000
005107000000             ADDMSGD +
005108000000                MSGID(TXT0111) +
005109000000                MSGF(&LIB/&OBJ) +
005110000000                MSG( +
005111000000'-Cräer Programme M§j-'                                               +
005112000000                ) +
005113000000                SEV(0) +
005114000000     /*   No replacement variables defined!                         */ +
005115000000                ALROPT(*NO) +
005116000000                CCSID(65535) +
005117000000                /*  -EOF-  */
005118000000
005119000000     /*-------------------------------------------------------------*/
005120000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0112                    */
005121000000     /* Minuscules admises.... ?                                    */
005122000000     /*-------------------------------------------------------------*/
005123000000
005124000000             RMVMSGD MSGID(TXT0112) MSGF(&LIB/&OBJ)
005125000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005126000000
005127000000             ADDMSGD +
005128000000                MSGID(TXT0112) +
005129000000                MSGF(&LIB/&OBJ) +
005130000000                MSG( +
005131000000'Minuscules admises.... ?'                                            +
005132000000                ) +
005133000000                SEV(0) +
005134000000     /*   No replacement variables defined!                         */ +
005135000000                ALROPT(*NO) +
005136000000                CCSID(65535) +
005137000000                /*  -EOF-  */
005138000000
005139000000     /*-------------------------------------------------------------*/
005140000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0113                    */
005141000000     /* Minuscules par däfaut. ?                                    */
005142000000     /*-------------------------------------------------------------*/
005143000000
005144000000             RMVMSGD MSGID(TXT0113) MSGF(&LIB/&OBJ)
005145000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005146000000
005147000000             ADDMSGD +
005148000000                MSGID(TXT0113) +
005149000000                MSGF(&LIB/&OBJ) +
005150000000                MSG( +
005151000000'Minuscules par däfaut. ?'                                            +
005152000000                ) +
005153000000                SEV(0) +
005154000000     /*   No replacement variables defined!                         */ +
005155000000                ALROPT(*NO) +
005156000000                CCSID(65535) +
005157000000                /*  -EOF-  */
005158000000
005159000000     /*-------------------------------------------------------------*/
005160000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0114                    */
005161000000     /* Sauvegarder par däfaut ?                                    */
005162000000     /*-------------------------------------------------------------*/
005163000000
005164000000             RMVMSGD MSGID(TXT0114) MSGF(&LIB/&OBJ)
005165000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005166000000
005167000000             ADDMSGD +
005168000000                MSGID(TXT0114) +
005169000000                MSGF(&LIB/&OBJ) +
005170000000                MSG( +
005171000000'Sauvegarder par däfaut ?'                                            +
005172000000                ) +
005173000000                SEV(0) +
005174000000     /*   No replacement variables defined!                         */ +
005175000000                ALROPT(*NO) +
005176000000                CCSID(65535) +
005177000000                /*  -EOF-  */
005178000000
005179000000     /*-------------------------------------------------------------*/
005180000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0115                    */
005181000000     /* Sälection SQL                                               */
005182000000     /*-------------------------------------------------------------*/
005183000000
005184000000             RMVMSGD MSGID(TXT0115) MSGF(&LIB/&OBJ)
005185000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005186000000
005187000000             ADDMSGD +
005188000000                MSGID(TXT0115) +
005189000000                MSGF(&LIB/&OBJ) +
005190000000                MSG( +
005191000000'Sälection SQL'                                                       +
005192000000                ) +
005193000000                SEV(0) +
005194000000     /*   No replacement variables defined!                         */ +
005195000000                ALROPT(*NO) +
005196000000                CCSID(65535) +
005197000000                /*  -EOF-  */
005198000000
005199000000     /*-------------------------------------------------------------*/
005200000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0116                    */
005201000000     /*    Choix Environment                                        */
005202000000     /*-------------------------------------------------------------*/
005203000000
005204000000             RMVMSGD MSGID(TXT0116) MSGF(&LIB/&OBJ)
005205000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005206000000
005207000000             ADDMSGD +
005208000000                MSGID(TXT0116) +
005209000000                MSGF(&LIB/&OBJ) +
005210000000                MSG( +
005211000000'   Choix Environment    '                                            +
005212000000                ) +
005213000000                SEV(0) +
005214000000     /*   No replacement variables defined!                         */ +
005215000000                ALROPT(*NO) +
005216000000                CCSID(65535) +
005217000000                /*  -EOF-  */
005218000000
005219000000     /*-------------------------------------------------------------*/
005220000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0117                    */
005221000000     /* Fich.:                                                      */
005222000000     /*-------------------------------------------------------------*/
005223000000
005224000000             RMVMSGD MSGID(TXT0117) MSGF(&LIB/&OBJ)
005225000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005226000000
005227000000             ADDMSGD +
005228000000                MSGID(TXT0117) +
005229000000                MSGF(&LIB/&OBJ) +
005230000000                MSG( +
005231000000'Fich.:'                                                              +
005232000000                ) +
005233000000                SEV(0) +
005234000000     /*   No replacement variables defined!                         */ +
005235000000                ALROPT(*NO) +
005236000000                CCSID(65535) +
005237000000                /*  -EOF-  */
005238000000
005239000000     /*-------------------------------------------------------------*/
005240000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0118                    */
005241000000     /* Biblioth..:                                                 */
005242000000     /*-------------------------------------------------------------*/
005243000000
005244000000             RMVMSGD MSGID(TXT0118) MSGF(&LIB/&OBJ)
005245000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005246000000
005247000000             ADDMSGD +
005248000000                MSGID(TXT0118) +
005249000000                MSGF(&LIB/&OBJ) +
005250000000                MSG( +
005251000000'Biblioth..:'                                                         +
005252000000                ) +
005253000000                SEV(0) +
005254000000     /*   No replacement variables defined!                         */ +
005255000000                ALROPT(*NO) +
005256000000                CCSID(65535) +
005257000000                /*  -EOF-  */
005258000000
005259000000     /*-------------------------------------------------------------*/
005260000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0119                    */
005261000000     /*  A   Description  environnement                             */
005262000000     /*-------------------------------------------------------------*/
005263000000
005264000000             RMVMSGD MSGID(TXT0119) MSGF(&LIB/&OBJ)
005265000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005266000000
005267000000             ADDMSGD +
005268000000                MSGID(TXT0119) +
005269000000                MSGF(&LIB/&OBJ) +
005270000000                MSG( +
005271000000' A   Description  environnement'                                     +
005272000000                ) +
005273000000                SEV(0) +
005274000000     /*   No replacement variables defined!                         */ +
005275000000                ALROPT(*NO) +
005276000000                CCSID(65535) +
005277000000                /*  -EOF-  */
005278000000
005279000000     /*-------------------------------------------------------------*/
005280000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0120                    */
005281000000     /* Supprimer environnement                                     */
005282000000     /*-------------------------------------------------------------*/
005283000000
005284000000             RMVMSGD MSGID(TXT0120) MSGF(&LIB/&OBJ)
005285000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005286000000
005287000000             ADDMSGD +
005288000000                MSGID(TXT0120) +
005289000000                MSGF(&LIB/&OBJ) +
005290000000                MSG( +
005291000000'Supprimer environnement'                                             +
005292000000                ) +
005293000000                SEV(0) +
005294000000     /*   No replacement variables defined!                         */ +
005295000000                ALROPT(*NO) +
005296000000                CCSID(65535) +
005297000000                /*  -EOF-  */
005298000000
005299000000     /*-------------------------------------------------------------*/
005300000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0121                    */
005301000000     /* Fichier . . :                                               */
005302000000     /*-------------------------------------------------------------*/
005303000000
005304000000             RMVMSGD MSGID(TXT0121) MSGF(&LIB/&OBJ)
005305000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005306000000
005307000000             ADDMSGD +
005308000000                MSGID(TXT0121) +
005309000000                MSGF(&LIB/&OBJ) +
005310000000                MSG( +
005311000000'Fichier . . :'                                                       +
005312000000                ) +
005313000000                SEV(0) +
005314000000     /*   No replacement variables defined!                         */ +
005315000000                ALROPT(*NO) +
005316000000                CCSID(65535) +
005317000000                /*  -EOF-  */
005318000000
005319000000     /*-------------------------------------------------------------*/
005320000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0122                    */
005321000000     /* Biblioth. :                                                 */
005322000000     /*-------------------------------------------------------------*/
005323000000
005324000000             RMVMSGD MSGID(TXT0122) MSGF(&LIB/&OBJ)
005325000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005326000000
005327000000             ADDMSGD +
005328000000                MSGID(TXT0122) +
005329000000                MSGF(&LIB/&OBJ) +
005330000000                MSG( +
005331000000'Biblioth. :'                                                         +
005332000000                ) +
005333000000                SEV(0) +
005334000000     /*   No replacement variables defined!                         */ +
005335000000                ALROPT(*NO) +
005336000000                CCSID(65535) +
005337000000                /*  -EOF-  */
005338000000
005339000000     /*-------------------------------------------------------------*/
005340000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0123                    */
005341000000     /* Membre  . . :                                               */
005342000000     /*-------------------------------------------------------------*/
005343000000
005344000000             RMVMSGD MSGID(TXT0123) MSGF(&LIB/&OBJ)
005345000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005346000000
005347000000             ADDMSGD +
005348000000                MSGID(TXT0123) +
005349000000                MSGF(&LIB/&OBJ) +
005350000000                MSG( +
005351000000'Membre  . . :'                                                       +
005352000000                ) +
005353000000                SEV(0) +
005354000000     /*   No replacement variables defined!                         */ +
005355000000                ALROPT(*NO) +
005356000000                CCSID(65535) +
005357000000                /*  -EOF-  */
005358000000
005359000000     /*-------------------------------------------------------------*/
005360000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0124                    */
005361000000     /* Description :                                               */
005362000000     /*-------------------------------------------------------------*/
005363000000
005364000000             RMVMSGD MSGID(TXT0124) MSGF(&LIB/&OBJ)
005365000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005366000000
005367000000             ADDMSGD +
005368000000                MSGID(TXT0124) +
005369000000                MSGF(&LIB/&OBJ) +
005370000000                MSG( +
005371000000'Description :'                                                       +
005372000000                ) +
005373000000                SEV(0) +
005374000000     /*   No replacement variables defined!                         */ +
005375000000                ALROPT(*NO) +
005376000000                CCSID(65535) +
005377000000                /*  -EOF-  */
005378000000
005379000000     /*-------------------------------------------------------------*/
005380000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0125                    */
005381000000     /* Long.variable:                                              */
005382000000     /*-------------------------------------------------------------*/
005383000000
005384000000             RMVMSGD MSGID(TXT0125) MSGF(&LIB/&OBJ)
005385000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005386000000
005387000000             ADDMSGD +
005388000000                MSGID(TXT0125) +
005389000000                MSGF(&LIB/&OBJ) +
005390000000                MSG( +
005391000000'Long.variable:'                                                      +
005392000000                ) +
005393000000                SEV(0) +
005394000000     /*   No replacement variables defined!                         */ +
005395000000                ALROPT(*NO) +
005396000000                CCSID(65535) +
005397000000                /*  -EOF-  */
005398000000
005399000000     /*-------------------------------------------------------------*/
005400000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0126                    */
005401000000     /* - Sälect. Format Enreg. -                                   */
005402000000     /*-------------------------------------------------------------*/
005403000000
005404000000             RMVMSGD MSGID(TXT0126) MSGF(&LIB/&OBJ)
005405000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005406000000
005407000000             ADDMSGD +
005408000000                MSGID(TXT0126) +
005409000000                MSGF(&LIB/&OBJ) +
005410000000                MSG( +
005411000000'- Sälect. Format Enreg. -'                                           +
005412000000                ) +
005413000000                SEV(0) +
005414000000     /*   No replacement variables defined!                         */ +
005415000000                ALROPT(*NO) +
005416000000                CCSID(65535) +
005417000000                /*  -EOF-  */
005418000000
005419000000     /*-------------------------------------------------------------*/
005420000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0127                    */
005421000000     /* NULL value                                                  */
005422000000     /*-------------------------------------------------------------*/
005423000000
005424000000             RMVMSGD MSGID(TXT0127) MSGF(&LIB/&OBJ)
005425000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005426000000
005427000000             ADDMSGD +
005428000000                MSGID(TXT0127) +
005429000000                MSGF(&LIB/&OBJ) +
005430000000                MSG( +
005431000000'NULL value'                                                          +
005432000000                ) +
005433000000                SEV(0) +
005434000000     /*   No replacement variables defined!                         */ +
005435000000                ALROPT(*NO) +
005436000000                CCSID(65535) +
005437000000                /*  -EOF-  */
005438000000
005439000000     /*-------------------------------------------------------------*/
005440000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0128                    */
005441000000     /* Editeur                                                     */
005442000000     /*-------------------------------------------------------------*/
005443000000
005444000000             RMVMSGD MSGID(TXT0128) MSGF(&LIB/&OBJ)
005445000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005446000000
005447000000             ADDMSGD +
005448000000                MSGID(TXT0128) +
005449000000                MSGF(&LIB/&OBJ) +
005450000000                MSG( +
005451000000'Editeur'                                                             +
005452000000                ) +
005453000000                SEV(0) +
005454000000     /*   No replacement variables defined!                         */ +
005455000000                ALROPT(*NO) +
005456000000                CCSID(65535) +
005457000000                /*  -EOF-  */
005458000000
005459000000     /*-------------------------------------------------------------*/
005460000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0129                    */
005461000000     /* ***Enreg.verouillä***                                       */
005462000000     /*-------------------------------------------------------------*/
005463000000
005464000000             RMVMSGD MSGID(TXT0129) MSGF(&LIB/&OBJ)
005465000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005466000000
005467000000             ADDMSGD +
005468000000                MSGID(TXT0129) +
005469000000                MSGF(&LIB/&OBJ) +
005470000000                MSG( +
005471000000'***Enreg.verouillä***'                                               +
005472000000                ) +
005473000000                SEV(0) +
005474000000     /*   No replacement variables defined!                         */ +
005475000000                ALROPT(*NO) +
005476000000                CCSID(65535) +
005477000000                /*  -EOF-  */
005478000000
005479000000     /*-------------------------------------------------------------*/
005480000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0130                    */
005481000000     /* Enreg. däverouillä                                          */
005482000000     /*-------------------------------------------------------------*/
005483000000
005484000000             RMVMSGD MSGID(TXT0130) MSGF(&LIB/&OBJ)
005485000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005486000000
005487000000             ADDMSGD +
005488000000                MSGID(TXT0130) +
005489000000                MSGF(&LIB/&OBJ) +
005490000000                MSG( +
005491000000'Enreg. däverouillä'                                                  +
005492000000                ) +
005493000000                SEV(0) +
005494000000     /*   No replacement variables defined!                         */ +
005495000000                ALROPT(*NO) +
005496000000                CCSID(65535) +
005497000000                /*  -EOF-  */
005498000000
005499000000     /*-------------------------------------------------------------*/
005500000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0131                    */
005501000000     /* Verrouiller enregistr. ?                                    */
005502000000     /*-------------------------------------------------------------*/
005503000000
005504000000             RMVMSGD MSGID(TXT0131) MSGF(&LIB/&OBJ)
005505000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005506000000
005507000000             ADDMSGD +
005508000000                MSGID(TXT0131) +
005509000000                MSGF(&LIB/&OBJ) +
005510000000                MSG( +
005511000000'Verrouiller enregistr. ?'                                            +
005512000000                ) +
005513000000                SEV(0) +
005514000000     /*   No replacement variables defined!                         */ +
005515000000                ALROPT(*NO) +
005516000000                CCSID(65535) +
005517000000                /*  -EOF-  */
005518000000
005519000000     /*-------------------------------------------------------------*/
005520000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0132                    */
005521000000     /* Fich.:                                                      */
005522000000     /*-------------------------------------------------------------*/
005523000000
005524000000             RMVMSGD MSGID(TXT0132) MSGF(&LIB/&OBJ)
005525000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005526000000
005527000000             ADDMSGD +
005528000000                MSGID(TXT0132) +
005529000000                MSGF(&LIB/&OBJ) +
005530000000                MSG( +
005531000000'Fich.:'                                                              +
005532000000                ) +
005533000000                SEV(0) +
005534000000     /*   No replacement variables defined!                         */ +
005535000000                ALROPT(*NO) +
005536000000                CCSID(65535) +
005537000000                /*  -EOF-  */
005538000000
005539000000     /*-------------------------------------------------------------*/
005540000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0133                    */
005541000000     /*   Biblioth:                                                 */
005542000000     /*-------------------------------------------------------------*/
005543000000
005544000000             RMVMSGD MSGID(TXT0133) MSGF(&LIB/&OBJ)
005545000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005546000000
005547000000             ADDMSGD +
005548000000                MSGID(TXT0133) +
005549000000                MSGF(&LIB/&OBJ) +
005550000000                MSG( +
005551000000'  Biblioth:'                                                         +
005552000000                ) +
005553000000                SEV(0) +
005554000000     /*   No replacement variables defined!                         */ +
005555000000                ALROPT(*NO) +
005556000000                CCSID(65535) +
005557000000                /*  -EOF-  */
005558000000
005559000000     /*-------------------------------------------------------------*/
005560000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0134                    */
005561000000     /* Enr:                                                        */
005562000000     /*-------------------------------------------------------------*/
005563000000
005564000000             RMVMSGD MSGID(TXT0134) MSGF(&LIB/&OBJ)
005565000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005566000000
005567000000             ADDMSGD +
005568000000                MSGID(TXT0134) +
005569000000                MSGF(&LIB/&OBJ) +
005570000000                MSG( +
005571000000'Enr:'                                                                +
005572000000                ) +
005573000000                SEV(0) +
005574000000     /*   No replacement variables defined!                         */ +
005575000000                ALROPT(*NO) +
005576000000                CCSID(65535) +
005577000000                /*  -EOF-  */
005578000000
005579000000     /*-------------------------------------------------------------*/
005580000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0135                    */
005581000000     /*  Page:                                                      */
005582000000     /*-------------------------------------------------------------*/
005583000000
005584000000             RMVMSGD MSGID(TXT0135) MSGF(&LIB/&OBJ)
005585000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005586000000
005587000000             ADDMSGD +
005588000000                MSGID(TXT0135) +
005589000000                MSGF(&LIB/&OBJ) +
005590000000                MSG( +
005591000000' Page:'                                                              +
005592000000                ) +
005593000000                SEV(0) +
005594000000     /*   No replacement variables defined!                         */ +
005595000000                ALROPT(*NO) +
005596000000                CCSID(65535) +
005597000000                /*  -EOF-  */
005598000000
005599000000     /*-------------------------------------------------------------*/
005600000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0136                    */
005601000000     /* Nom champ                                                   */
005602000000     /*-------------------------------------------------------------*/
005603000000
005604000000             RMVMSGD MSGID(TXT0136) MSGF(&LIB/&OBJ)
005605000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005606000000
005607000000             ADDMSGD +
005608000000                MSGID(TXT0136) +
005609000000                MSGF(&LIB/&OBJ) +
005610000000                MSG( +
005611000000'Nom champ'                                                           +
005612000000                ) +
005613000000                SEV(0) +
005614000000     /*   No replacement variables defined!                         */ +
005615000000                ALROPT(*NO) +
005616000000                CCSID(65535) +
005617000000                /*  -EOF-  */
005618000000
005619000000     /*-------------------------------------------------------------*/
005620000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0137                    */
005621000000     /* Description champ                                           */
005622000000     /*-------------------------------------------------------------*/
005623000000
005624000000             RMVMSGD MSGID(TXT0137) MSGF(&LIB/&OBJ)
005625000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005626000000
005627000000             ADDMSGD +
005628000000                MSGID(TXT0137) +
005629000000                MSGF(&LIB/&OBJ) +
005630000000                MSG( +
005631000000'Description champ'                                                   +
005632000000                ) +
005633000000                SEV(0) +
005634000000     /*   No replacement variables defined!                         */ +
005635000000                ALROPT(*NO) +
005636000000                CCSID(65535) +
005637000000                /*  -EOF-  */
005638000000
005639000000     /*-------------------------------------------------------------*/
005640000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0138                    */
005641000000     /* Valeur champ                                                */
005642000000     /*-------------------------------------------------------------*/
005643000000
005644000000             RMVMSGD MSGID(TXT0138) MSGF(&LIB/&OBJ)
005645000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005646000000
005647000000             ADDMSGD +
005648000000                MSGID(TXT0138) +
005649000000                MSGF(&LIB/&OBJ) +
005650000000                MSG( +
005651000000'Valeur champ'                                                        +
005652000000                ) +
005653000000                SEV(0) +
005654000000     /*   No replacement variables defined!                         */ +
005655000000                ALROPT(*NO) +
005656000000                CCSID(65535) +
005657000000                /*  -EOF-  */
005658000000
005659000000     /*-------------------------------------------------------------*/
005660000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0139                    */
005661000000     /* Texte                                                       */
005662000000     /*-------------------------------------------------------------*/
005663000000
005664000000             RMVMSGD MSGID(TXT0139) MSGF(&LIB/&OBJ)
005665000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005666000000
005667000000             ADDMSGD +
005668000000                MSGID(TXT0139) +
005669000000                MSGF(&LIB/&OBJ) +
005670000000                MSG( +
005671000000'Texte'                                                               +
005672000000                ) +
005673000000                SEV(0) +
005674000000     /*   No replacement variables defined!                         */ +
005675000000                ALROPT(*NO) +
005676000000                CCSID(65535) +
005677000000                /*  -EOF-  */
005678000000
005679000000     /*-------------------------------------------------------------*/
005680000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0140                    */
005681000000     /*  O   Opt  Description                                       */
005682000000     /*-------------------------------------------------------------*/
005683000000
005684000000             RMVMSGD MSGID(TXT0140) MSGF(&LIB/&OBJ)
005685000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005686000000
005687000000             ADDMSGD +
005688000000                MSGID(TXT0140) +
005689000000                MSGF(&LIB/&OBJ) +
005690000000                MSG( +
005691000000' O   Opt  Description                 '                              +
005692000000                ) +
005693000000                SEV(0) +
005694000000     /*   No replacement variables defined!                         */ +
005695000000                ALROPT(*NO) +
005696000000                CCSID(65535) +
005697000000                /*  -EOF-  */
005698000000
005699000000     /*-------------------------------------------------------------*/
005700000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0141                    */
005701000000     /* ----- Options utilisateur  -----                            */
005702000000     /*-------------------------------------------------------------*/
005703000000
005704000000             RMVMSGD MSGID(TXT0141) MSGF(&LIB/&OBJ)
005705000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005706000000
005707000000             ADDMSGD +
005708000000                MSGID(TXT0141) +
005709000000                MSGF(&LIB/&OBJ) +
005710000000                MSG( +
005711000000'----- Options utilisateur  ----- '                                   +
005712000000                ) +
005713000000                SEV(0) +
005714000000     /*   No replacement variables defined!                         */ +
005715000000                ALROPT(*NO) +
005716000000                CCSID(65535) +
005717000000                /*  -EOF-  */
005718000000
005719000000     /*-------------------------------------------------------------*/
005720000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0142                    */
005721000000     /*  O   Fichier     Bibliothüque Description                   */
005722000000     /*-------------------------------------------------------------*/
005723000000
005724000000             RMVMSGD MSGID(TXT0142) MSGF(&LIB/&OBJ)
005725000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005726000000
005727000000             ADDMSGD +
005728000000                MSGID(TXT0142) +
005729000000                MSGF(&LIB/&OBJ) +
005730000000                MSG( +
005731000000' O   Fichier     Bibliothüque Description'                           +
005732000000                ) +
005733000000                SEV(0) +
005734000000     /*   No replacement variables defined!                         */ +
005735000000                ALROPT(*NO) +
005736000000                CCSID(65535) +
005737000000                /*  -EOF-  */
005738000000
005739000000     /*-------------------------------------------------------------*/
005740000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0143                    */
005741000000     /*  -Fichier sälec.-                                           */
005742000000     /*-------------------------------------------------------------*/
005743000000
005744000000             RMVMSGD MSGID(TXT0143) MSGF(&LIB/&OBJ)
005745000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005746000000
005747000000             ADDMSGD +
005748000000                MSGID(TXT0143) +
005749000000                MSGF(&LIB/&OBJ) +
005750000000                MSG( +
005751000000' -Fichier sälec.-'                                                   +
005752000000                ) +
005753000000                SEV(0) +
005754000000     /*   No replacement variables defined!                         */ +
005755000000                ALROPT(*NO) +
005756000000                CCSID(65535) +
005757000000                /*  -EOF-  */
005758000000
005759000000     /*-------------------------------------------------------------*/
005760000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0144                    */
005761000000     /* Initialise champs NULL ?                                    */
005762000000     /*-------------------------------------------------------------*/
005763000000
005764000000             RMVMSGD MSGID(TXT0144) MSGF(&LIB/&OBJ)
005765000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005766000000
005767000000             ADDMSGD +
005768000000                MSGID(TXT0144) +
005769000000                MSGF(&LIB/&OBJ) +
005770000000                MSG( +
005771000000'Initialise champs NULL ?'                                            +
005772000000                ) +
005773000000                SEV(0) +
005774000000     /*   No replacement variables defined!                         */ +
005775000000                ALROPT(*NO) +
005776000000                CCSID(65535) +
005777000000                /*  -EOF-  */
005778000000
005779000000     /*-------------------------------------------------------------*/
005780000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0145                    */
005781000000     /* Conserve pos. curseur. ?                                    */
005782000000     /*-------------------------------------------------------------*/
005783000000
005784000000             RMVMSGD MSGID(TXT0145) MSGF(&LIB/&OBJ)
005785000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005786000000
005787000000             ADDMSGD +
005788000000                MSGID(TXT0145) +
005789000000                MSGF(&LIB/&OBJ) +
005790000000                MSG( +
005791000000'Conserve pos. curseur. ?'                                            +
005792000000                ) +
005793000000                SEV(0) +
005794000000     /*   No replacement variables defined!                         */ +
005795000000                ALROPT(*NO) +
005796000000                CCSID(65535) +
005797000000                /*  -EOF-  */
005798000000
005799000000     /*-------------------------------------------------------------*/
005800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0146                    */
005801000000     /* Insärer                                                     */
005802000000     /*-------------------------------------------------------------*/
005803000000
005804000000             RMVMSGD MSGID(TXT0146) MSGF(&LIB/&OBJ)
005805000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005806000000
005807000000             ADDMSGD +
005808000000                MSGID(TXT0146) +
005809000000                MSGF(&LIB/&OBJ) +
005810000000                MSG( +
005811000000'Insärer'                                                             +
005812000000                ) +
005813000000                SEV(0) +
005814000000     /*   No replacement variables defined!                         */ +
005815000000                ALROPT(*NO) +
005816000000                CCSID(65535) +
005817000000                /*  -EOF-  */
005818000000
005819000000     /*-------------------------------------------------------------*/
005820000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0147                    */
005821000000     /* Supprimer                                                   */
005822000000     /*-------------------------------------------------------------*/
005823000000
005824000000             RMVMSGD MSGID(TXT0147) MSGF(&LIB/&OBJ)
005825000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005826000000
005827000000             ADDMSGD +
005828000000                MSGID(TXT0147) +
005829000000                MSGF(&LIB/&OBJ) +
005830000000                MSG( +
005831000000'Supprimer'                                                           +
005832000000                ) +
005833000000                SEV(0) +
005834000000     /*   No replacement variables defined!                         */ +
005835000000                ALROPT(*NO) +
005836000000                CCSID(65535) +
005837000000                /*  -EOF-  */
005838000000
005839000000     /*-------------------------------------------------------------*/
005840000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0148                    */
005841000000     /* de:                                                         */
005842000000     /*-------------------------------------------------------------*/
005843000000
005844000000             RMVMSGD MSGID(TXT0148) MSGF(&LIB/&OBJ)
005845000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005846000000
005847000000             ADDMSGD +
005848000000                MSGID(TXT0148) +
005849000000                MSGF(&LIB/&OBJ) +
005850000000                MSG( +
005851000000'de:'                                                                 +
005852000000                ) +
005853000000                SEV(0) +
005854000000     /*   No replacement variables defined!                         */ +
005855000000                ALROPT(*NO) +
005856000000                CCSID(65535) +
005857000000                /*  -EOF-  */
005858000000
005859000000     /*-------------------------------------------------------------*/
005860000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0149                    */
005861000000     /* Longueur:                                                   */
005862000000     /*-------------------------------------------------------------*/
005863000000
005864000000             RMVMSGD MSGID(TXT0149) MSGF(&LIB/&OBJ)
005865000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005866000000
005867000000             ADDMSGD +
005868000000                MSGID(TXT0149) +
005869000000                MSGF(&LIB/&OBJ) +
005870000000                MSG( +
005871000000'Longueur:'                                                           +
005872000000                ) +
005873000000                SEV(0) +
005874000000     /*   No replacement variables defined!                         */ +
005875000000                ALROPT(*NO) +
005876000000                CCSID(65535) +
005877000000                /*  -EOF-  */
005878000000
005879000000     /*-------------------------------------------------------------*/
005880000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0150                    */
005881000000     /* §:                                                          */
005882000000     /*-------------------------------------------------------------*/
005883000000
005884000000             RMVMSGD MSGID(TXT0150) MSGF(&LIB/&OBJ)
005885000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005886000000
005887000000             ADDMSGD +
005888000000                MSGID(TXT0150) +
005889000000                MSGF(&LIB/&OBJ) +
005890000000                MSG( +
005891000000'§:'                                                                  +
005892000000                ) +
005893000000                SEV(0) +
005894000000     /*   No replacement variables defined!                         */ +
005895000000                ALROPT(*NO) +
005896000000                CCSID(65535) +
005897000000                /*  -EOF-  */
005898000000
005899000000     /*-------------------------------------------------------------*/
005900000000     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
005901000000     /* Enregistrement du format &3 du fichier &2/&1 inaccessible   */
005902000000     /*-------------------------------------------------------------*/
005903000000
005904000000             RMVMSGD MSGID(USR0001) MSGF(&LIB/&OBJ)
005905000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005906000000
005907000000             ADDMSGD +
005908000000                MSGID(USR0001) +
005909000000                MSGF(&LIB/&OBJ) +
005910000000                MSG( +
005911000000'Enregistrement du format &3 du fichier &2/&1 inaccessible'           +
005912000000                ) +
005913000000                SEV(0) +
005914000000                FMT( +
005915000000                    (*CHAR 10) +
005916000000                    (*CHAR 10) +
005917000000                    (*CHAR 10) +
005918000000                ) +
005919000000                ALROPT(*NO) +
005920000000                CCSID(65535) +
005921000000                /*  -EOF-  */
005922000000
005923000000     /*-------------------------------------------------------------*/
005924000000     /*   Cmd-ADDMSGD für Message-ID :   USR0002                    */
005925000000     /* Extraction impossible de la liste des formats du fichier &2 */
005926000000     /*-------------------------------------------------------------*/
005927000000
005928000000             RMVMSGD MSGID(USR0002) MSGF(&LIB/&OBJ)
005929000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005930000000
005931000000             ADDMSGD +
005932000000                MSGID(USR0002) +
005933000000                MSGF(&LIB/&OBJ) +
005934000000                MSG( +
005935000000'Extraction impossible de la liste des formats du fichier &2/&1.'     +
005936000000                ) +
005937000000                SEV(0) +
005938000000                FMT( +
005939000000                    (*CHAR 10) +
005940000000                    (*CHAR 10) +
005941000000                ) +
005942000000                ALROPT(*NO) +
005943000000                CCSID(65535) +
005944000000                /*  -EOF-  */
005945000000
005946000000     /*-------------------------------------------------------------*/
005947000000     /*   Cmd-ADDMSGD für Message-ID :   USR0003                    */
005948000000     /* Journalisation active sur ce fichier                        */
005949000000     /*-------------------------------------------------------------*/
005950000000
005951000000             RMVMSGD MSGID(USR0003) MSGF(&LIB/&OBJ)
005952000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005953000000
005954000000             ADDMSGD +
005955000000                MSGID(USR0003) +
005956000000                MSGF(&LIB/&OBJ) +
005957000000                MSG( +
005958000000'Journalisation active sur ce fichier'                                +
005959000000                ) +
005960000000                SEV(0) +
005961000000     /*   No replacement variables defined!                         */ +
005962000000                ALROPT(*NO) +
005963000000                CCSID(65535) +
005964000000                /*  -EOF-  */
005965000000
005966000000     /*-------------------------------------------------------------*/
005967000000     /*   Cmd-ADDMSGD für Message-ID :   USR0004                    */
005968000000     /* Pas de journalisation sur ce fichier                        */
005969000000     /*-------------------------------------------------------------*/
005970000000
005971000000             RMVMSGD MSGID(USR0004) MSGF(&LIB/&OBJ)
005972000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005973000000
005974000000             ADDMSGD +
005975000000                MSGID(USR0004) +
005976000000                MSGF(&LIB/&OBJ) +
005977000000                MSG( +
005978000000'Pas de journalisation sur ce fichier'                                +
005979000000                ) +
005980000000                SEV(0) +
005981000000     /*   No replacement variables defined!                         */ +
005982000000                ALROPT(*NO) +
005983000000                CCSID(65535) +
005984000000                /*  -EOF-  */
005985000000
005986000000     /*-------------------------------------------------------------*/
005987000000     /*   Cmd-ADDMSGD für Message-ID :   USR0005                    */
005988000000     /* Fichier &1 non ouvert. Voir journal.                        */
005989000000     /*-------------------------------------------------------------*/
005990000000
005991000000             RMVMSGD MSGID(USR0005) MSGF(&LIB/&OBJ)
005992000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
005993000000
005994000000             ADDMSGD +
005995000000                MSGID(USR0005) +
005996000000                MSGF(&LIB/&OBJ) +
005997000000                MSG( +
005998000000'Fichier &1 non ouvert. Voir journal.'                                +
005999000000                ) +
006000000000                SEV(0) +
006001000000                FMT( +
006002000000                    (*CHAR 10) +
006003000000                ) +
006004000000                ALROPT(*NO) +
006005000000                CCSID(65535) +
006006000000                /*  -EOF-  */
006007000000
006008000000     /*-------------------------------------------------------------*/
006009000000     /*   Cmd-ADDMSGD für Message-ID :   USR0006                    */
006010000000     /* Pas d'information clef sur fichier &2/&1.                   */
006011000000     /*-------------------------------------------------------------*/
006012000000
006013000000             RMVMSGD MSGID(USR0006) MSGF(&LIB/&OBJ)
006014000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006015000000
006016000000             ADDMSGD +
006017000000                MSGID(USR0006) +
006018000000                MSGF(&LIB/&OBJ) +
006019000000                MSG( +
006020000000'Pas d''information clef sur fichier &2/&1.'                          +
006021000000                ) +
006022000000                SEV(0) +
006023000000                FMT( +
006024000000                    (*CHAR 10) +
006025000000                    (*CHAR 10) +
006026000000                ) +
006027000000                ALROPT(*NO) +
006028000000                CCSID(65535) +
006029000000                /*  -EOF-  */
006030000000
006031000000     /*-------------------------------------------------------------*/
006032000000     /*   Cmd-ADDMSGD für Message-ID :   USR0007                    */
006033000000     /* Ouverture impossible du fichier &2/&1 en mode M§J. Modifica */
006034000000     /*-------------------------------------------------------------*/
006035000000
006036000000             RMVMSGD MSGID(USR0007) MSGF(&LIB/&OBJ)
006037000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006038000000
006039000000             ADDMSGD +
006040000000                MSGID(USR0007) +
006041000000                MSGF(&LIB/&OBJ) +
006042000000                MSG( +
006043000000'Ouverture impossible du fichier &2/&1 en mode M§J. Modifications impo-
006044000000ossibles.'                                                            +
006045000000                ) +
006046000000                SECLVL( +
006047000000'&N &N Causes possibles: &N &B 1. Le debugger a ätä dämarrä en UPDPROD-
006048000000(*NO). &B 2. Le fichier est un logique joint &B 3. Le fichier a des rü-
006049000000gles d''intägritä mais n''est pas journalisä. &B 4. Le fichier possüde-
006050000000 des däclencheurs introuvables. &B 5. Le fichier est un logique multi--
006051000000membre.'                                                              +
006052000000                ) +
006053000000                SEV(0) +
006054000000                FMT( +
006055000000                    (*CHAR 10) +
006056000000                    (*CHAR 10) +
006057000000                ) +
006058000000                ALROPT(*NO) +
006059000000                CCSID(65535) +
006060000000                /*  -EOF-  */
006061000000
006062000000     /*-------------------------------------------------------------*/
006063000000     /*   Cmd-ADDMSGD für Message-ID :   USR0008                    */
006064000000     /* Fichier &2/&1 introuvable                                   */
006065000000     /*-------------------------------------------------------------*/
006066000000
006067000000             RMVMSGD MSGID(USR0008) MSGF(&LIB/&OBJ)
006068000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006069000000
006070000000             ADDMSGD +
006071000000                MSGID(USR0008) +
006072000000                MSGF(&LIB/&OBJ) +
006073000000                MSG( +
006074000000'Fichier &2/&1 introuvable'                                           +
006075000000                ) +
006076000000                SEV(0) +
006077000000                FMT( +
006078000000                    (*CHAR 10) +
006079000000                    (*CHAR 10) +
006080000000                ) +
006081000000                ALROPT(*NO) +
006082000000                CCSID(65535) +
006083000000                /*  -EOF-  */
006084000000
006085000000     /*-------------------------------------------------------------*/
006086000000     /*   Cmd-ADDMSGD für Message-ID :   USR0009                    */
006087000000     /* Extraction impossible de la description du fichier &2/&1.   */
006088000000     /*-------------------------------------------------------------*/
006089000000
006090000000             RMVMSGD MSGID(USR0009) MSGF(&LIB/&OBJ)
006091000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006092000000
006093000000             ADDMSGD +
006094000000                MSGID(USR0009) +
006095000000                MSGF(&LIB/&OBJ) +
006096000000                MSG( +
006097000000'Extraction impossible de la description du fichier &2/&1.'           +
006098000000                ) +
006099000000                SEV(0) +
006100000000                FMT( +
006101000000                    (*CHAR 10) +
006102000000                    (*CHAR 10) +
006103000000                ) +
006104000000                ALROPT(*NO) +
006105000000                CCSID(65535) +
006106000000                /*  -EOF-  */
006107000000
006108000000     /*-------------------------------------------------------------*/
006109000000     /*   Cmd-ADDMSGD für Message-ID :   USR0010                    */
006110000000     /* Bibliothüque &1 inexistante                                 */
006111000000     /*-------------------------------------------------------------*/
006112000000
006113000000             RMVMSGD MSGID(USR0010) MSGF(&LIB/&OBJ)
006114000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006115000000
006116000000             ADDMSGD +
006117000000                MSGID(USR0010) +
006118000000                MSGF(&LIB/&OBJ) +
006119000000                MSG( +
006120000000'Bibliothüque &1 inexistante'                                         +
006121000000                ) +
006122000000                SEV(0) +
006123000000                FMT( +
006124000000                    (*CHAR 10) +
006125000000                ) +
006126000000                ALROPT(*NO) +
006127000000                CCSID(65535) +
006128000000                /*  -EOF-  */
006129000000
006130000000     /*-------------------------------------------------------------*/
006131000000     /*   Cmd-ADDMSGD für Message-ID :   USR0011                    */
006132000000     /* Fichier non ouvert. Voir message de second niveau ou la log */
006133000000     /*-------------------------------------------------------------*/
006134000000
006135000000             RMVMSGD MSGID(USR0011) MSGF(&LIB/&OBJ)
006136000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006137000000
006138000000             ADDMSGD +
006139000000                MSGID(USR0011) +
006140000000                MSGF(&LIB/&OBJ) +
006141000000                MSG( +
006142000000'Fichier non ouvert. Voir message de second niveau ou la log pour plus-
006143000000 d''informations.'                                                    +
006144000000                ) +
006145000000                SECLVL( +
006146000000'&N &N Erreur . .  . . :   &1'                                        +
006147000000                ) +
006148000000                SEV(0) +
006149000000                FMT( +
006150000000                    (*CHAR 256) +
006151000000                ) +
006152000000                ALROPT(*NO) +
006153000000                CCSID(65535) +
006154000000                /*  -EOF-  */
006155000000
006156000000     /*-------------------------------------------------------------*/
006157000000     /*   Cmd-ADDMSGD für Message-ID :   USR0012                    */
006158000000     /* Erreur E/S &2: &1                                           */
006159000000     /*-------------------------------------------------------------*/
006160000000
006161000000             RMVMSGD MSGID(USR0012) MSGF(&LIB/&OBJ)
006162000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006163000000
006164000000             ADDMSGD +
006165000000                MSGID(USR0012) +
006166000000                MSGF(&LIB/&OBJ) +
006167000000                MSG( +
006168000000'Erreur E/S &2: &1'                                                   +
006169000000                ) +
006170000000                SEV(0) +
006171000000                FMT( +
006172000000                    (*CHAR 256) +
006173000000                    (*DEC 5 0) +
006174000000                ) +
006175000000                ALROPT(*NO) +
006176000000                CCSID(65535) +
006177000000                /*  -EOF-  */
006178000000
006179000000     /*-------------------------------------------------------------*/
006180000000     /*   Cmd-ADDMSGD für Message-ID :   USR0013                    */
006181000000     /* Exäcution de la requête.                                    */
006182000000     /*-------------------------------------------------------------*/
006183000000
006184000000             RMVMSGD MSGID(USR0013) MSGF(&LIB/&OBJ)
006185000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006186000000
006187000000             ADDMSGD +
006188000000                MSGID(USR0013) +
006189000000                MSGF(&LIB/&OBJ) +
006190000000                MSG( +
006191000000'Exäcution de la requête.'                                            +
006192000000                ) +
006193000000                SEV(0) +
006194000000     /*   No replacement variables defined!                         */ +
006195000000                ALROPT(*NO) +
006196000000                CCSID(65535) +
006197000000                /*  -EOF-  */
006198000000
006199000000     /*-------------------------------------------------------------*/
006200000000     /*   Cmd-ADDMSGD für Message-ID :   USR0014                    */
006201000000     /* Calcule nombre d'enregistrements selectionnäs.              */
006202000000     /*-------------------------------------------------------------*/
006203000000
006204000000             RMVMSGD MSGID(USR0014) MSGF(&LIB/&OBJ)
006205000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006206000000
006207000000             ADDMSGD +
006208000000                MSGID(USR0014) +
006209000000                MSGF(&LIB/&OBJ) +
006210000000                MSG( +
006211000000'Calcule nombre d''enregistrements selectionnäs.'                     +
006212000000                ) +
006213000000                SEV(0) +
006214000000     /*   No replacement variables defined!                         */ +
006215000000                ALROPT(*NO) +
006216000000                CCSID(65535) +
006217000000                /*  -EOF-  */
006218000000
006219000000     /*-------------------------------------------------------------*/
006220000000     /*   Cmd-ADDMSGD für Message-ID :   USR0143                    */
006221000000     /* Extraction impossible de l'enregistrement format &3 du fich */
006222000000     /*-------------------------------------------------------------*/
006223000000
006224000000             RMVMSGD MSGID(USR0143) MSGF(&LIB/&OBJ)
006225000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006226000000
006227000000             ADDMSGD +
006228000000                MSGID(USR0143) +
006229000000                MSGF(&LIB/&OBJ) +
006230000000                MSG( +
006231000000'Extraction impossible de l''enregistrement format &3 du fichier &2/&1-
006232000000.'                                                                    +
006233000000                ) +
006234000000                SEV(0) +
006235000000                FMT( +
006236000000                    (*CHAR 10) +
006237000000                    (*CHAR 10) +
006238000000                    (*CHAR 10) +
006239000000                ) +
006240000000                ALROPT(*NO) +
006241000000                CCSID(65535) +
006242000000                /*  -EOF-  */
006243000000
006244000000     /*-------------------------------------------------------------*/
006245000000     /*   Cmd-ADDMSGD für Message-ID :   USR1000                    */
006246000000     /* Accüs non autorisä pour le fichier &2/&1, membre &3.        */
006247000000     /*-------------------------------------------------------------*/
006248000000
006249000000             RMVMSGD MSGID(USR1000) MSGF(&LIB/&OBJ)
006250000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006251000000
006252000000             ADDMSGD +
006253000000                MSGID(USR1000) +
006254000000                MSGF(&LIB/&OBJ) +
006255000000                MSG( +
006256000000'Accüs non autorisä pour le fichier &2/&1, membre &3.'                +
006257000000                ) +
006258000000                SEV(0) +
006259000000                FMT( +
006260000000                    (*CHAR 10) +
006261000000                    (*CHAR 10) +
006262000000                    (*CHAR 10) +
006263000000                ) +
006264000000                ALROPT(*NO) +
006265000000                CCSID(65535) +
006266000000                /*  -EOF-  */
006267000000
006268000000     /*-------------------------------------------------------------*/
006269000000     /*   Cmd-ADDMSGD für Message-ID :   USR8100                    */
006270000000     /* Abandon par utilisateur avec &1                             */
006271000000     /*-------------------------------------------------------------*/
006272000000
006273000000             RMVMSGD MSGID(USR8100) MSGF(&LIB/&OBJ)
006274000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006275000000
006276000000             ADDMSGD +
006277000000                MSGID(USR8100) +
006278000000                MSGF(&LIB/&OBJ) +
006279000000                MSG( +
006280000000'Abandon par utilisateur avec &1'                                     +
006281000000                ) +
006282000000                SEV(0) +
006283000000                FMT( +
006284000000                    (*CHAR 10) +
006285000000                ) +
006286000000                ALROPT(*NO) +
006287000000                CCSID(65535) +
006288000000                /*  -EOF-  */
006289000000
006290000000     /*-------------------------------------------------------------*/
006291000000     /*   Cmd-ADDMSGD für Message-ID :   USR8101                    */
006292000000     /* Veuillez patienter un moment  ...                           */
006293000000     /*-------------------------------------------------------------*/
006294000000
006295000000             RMVMSGD MSGID(USR8101) MSGF(&LIB/&OBJ)
006296000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006297000000
006298000000             ADDMSGD +
006299000000                MSGID(USR8101) +
006300000000                MSGF(&LIB/&OBJ) +
006301000000                MSG( +
006302000000'Veuillez patienter un moment  ...'                                   +
006303000000                ) +
006304000000                SEV(0) +
006305000000     /*   No replacement variables defined!                         */ +
006306000000                ALROPT(*NO) +
006307000000                CCSID(65535) +
006308000000                /*  -EOF-  */
006309000000
006310000000     /*-------------------------------------------------------------*/
006311000000     /*   Cmd-ADDMSGD für Message-ID :   USR8102                    */
006312000000     /* Pointez sur un enregistement et räessayez                   */
006313000000     /*-------------------------------------------------------------*/
006314000000
006315000000             RMVMSGD MSGID(USR8102) MSGF(&LIB/&OBJ)
006316000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006317000000
006318000000             ADDMSGD +
006319000000                MSGID(USR8102) +
006320000000                MSGF(&LIB/&OBJ) +
006321000000                MSG( +
006322000000'Pointez sur un enregistement et räessayez'                           +
006323000000                ) +
006324000000                SEV(0) +
006325000000     /*   No replacement variables defined!                         */ +
006326000000                ALROPT(*NO) +
006327000000                CCSID(65535) +
006328000000                /*  -EOF-  */
006329000000
006330000000     /*-------------------------------------------------------------*/
006331000000     /*   Cmd-ADDMSGD für Message-ID :   USR8103                    */
006332000000     /* Impossible de fermer le fichier.                            */
006333000000     /*-------------------------------------------------------------*/
006334000000
006335000000             RMVMSGD MSGID(USR8103) MSGF(&LIB/&OBJ)
006336000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006337000000
006338000000             ADDMSGD +
006339000000                MSGID(USR8103) +
006340000000                MSGF(&LIB/&OBJ) +
006341000000                MSG( +
006342000000'Impossible de fermer le fichier.'                                    +
006343000000                ) +
006344000000                SEV(0) +
006345000000     /*   No replacement variables defined!                         */ +
006346000000                ALROPT(*NO) +
006347000000                CCSID(65535) +
006348000000                /*  -EOF-  */
006349000000
006350000000     /*-------------------------------------------------------------*/
006351000000     /*   Cmd-ADDMSGD für Message-ID :   USR8104                    */
006352000000     /* Extraction de la description du fichier &2/&1.              */
006353000000     /*-------------------------------------------------------------*/
006354000000
006355000000             RMVMSGD MSGID(USR8104) MSGF(&LIB/&OBJ)
006356000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006357000000
006358000000             ADDMSGD +
006359000000                MSGID(USR8104) +
006360000000                MSGF(&LIB/&OBJ) +
006361000000                MSG( +
006362000000'Extraction de la description du fichier &2/&1.'                      +
006363000000                ) +
006364000000                SEV(0) +
006365000000                FMT( +
006366000000                    (*CHAR 10) +
006367000000                    (*CHAR 10) +
006368000000                ) +
006369000000                ALROPT(*NO) +
006370000000                CCSID(65535) +
006371000000                /*  -EOF-  */
006372000000
006373000000     /*-------------------------------------------------------------*/
006374000000     /*   Cmd-ADDMSGD für Message-ID :   USR8105                    */
006375000000     /* Extraction de la liste des formats du fichier &2/&1.        */
006376000000     /*-------------------------------------------------------------*/
006377000000
006378000000             RMVMSGD MSGID(USR8105) MSGF(&LIB/&OBJ)
006379000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006380000000
006381000000             ADDMSGD +
006382000000                MSGID(USR8105) +
006383000000                MSGF(&LIB/&OBJ) +
006384000000                MSG( +
006385000000'Extraction de la liste des formats du fichier &2/&1.'                +
006386000000                ) +
006387000000                SEV(0) +
006388000000                FMT( +
006389000000                    (*CHAR 10) +
006390000000                    (*CHAR 10) +
006391000000                ) +
006392000000                ALROPT(*NO) +
006393000000                CCSID(65535) +
006394000000                /*  -EOF-  */
006395000000
006396000000     /*-------------------------------------------------------------*/
006397000000     /*   Cmd-ADDMSGD für Message-ID :   USR8106                    */
006398000000     /* Extraction des attributs räseau.                            */
006399000000     /*-------------------------------------------------------------*/
006400000000
006401000000             RMVMSGD MSGID(USR8106) MSGF(&LIB/&OBJ)
006402000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006403000000
006404000000             ADDMSGD +
006405000000                MSGID(USR8106) +
006406000000                MSGF(&LIB/&OBJ) +
006407000000                MSG( +
006408000000'Extraction des attributs räseau.'                                    +
006409000000                ) +
006410000000                SEV(0) +
006411000000     /*   No replacement variables defined!                         */ +
006412000000                ALROPT(*NO) +
006413000000                CCSID(65535) +
006414000000                /*  -EOF-  */
006415000000
006416000000     /*-------------------------------------------------------------*/
006417000000     /*   Cmd-ADDMSGD für Message-ID :   USR8107                    */
006418000000     /* Extraction des attributs de l'objet &2/&1.                  */
006419000000     /*-------------------------------------------------------------*/
006420000000
006421000000             RMVMSGD MSGID(USR8107) MSGF(&LIB/&OBJ)
006422000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006423000000
006424000000             ADDMSGD +
006425000000                MSGID(USR8107) +
006426000000                MSGF(&LIB/&OBJ) +
006427000000                MSG( +
006428000000'Extraction des attributs de l''objet &2/&1.'                         +
006429000000                ) +
006430000000                SEV(0) +
006431000000                FMT( +
006432000000                    (*CHAR 10) +
006433000000                    (*CHAR 10) +
006434000000                    (*CHAR 10) +
006435000000                ) +
006436000000                ALROPT(*NO) +
006437000000                CCSID(65535) +
006438000000                /*  -EOF-  */
006439000000
006440000000     /*-------------------------------------------------------------*/
006441000000     /*   Cmd-ADDMSGD für Message-ID :   USR8108                    */
006442000000     /* Champ '&1' non trouvä dans fichier &3/&2.                   */
006443000000     /*-------------------------------------------------------------*/
006444000000
006445000000             RMVMSGD MSGID(USR8108) MSGF(&LIB/&OBJ)
006446000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006447000000
006448000000             ADDMSGD +
006449000000                MSGID(USR8108) +
006450000000                MSGF(&LIB/&OBJ) +
006451000000                MSG( +
006452000000'Champ ''&1'' non trouvä dans fichier &3/&2.'                         +
006453000000                ) +
006454000000                SEV(0) +
006455000000                FMT( +
006456000000                    (*CHAR 10) +
006457000000                    (*CHAR 10) +
006458000000                    (*CHAR 10) +
006459000000                ) +
006460000000                ALROPT(*NO) +
006461000000                CCSID(65535) +
006462000000                /*  -EOF-  */
006463000000
006464000000     /*-------------------------------------------------------------*/
006465000000     /*   Cmd-ADDMSGD für Message-ID :   USR8109                    */
006466000000     /* Extraction de la description du membre &3 du fichier &2/&1. */
006467000000     /*-------------------------------------------------------------*/
006468000000
006469000000             RMVMSGD MSGID(USR8109) MSGF(&LIB/&OBJ)
006470000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006471000000
006472000000             ADDMSGD +
006473000000                MSGID(USR8109) +
006474000000                MSGF(&LIB/&OBJ) +
006475000000                MSG( +
006476000000'Extraction de la description du membre &3 du fichier &2/&1.'         +
006477000000                ) +
006478000000                SEV(0) +
006479000000                FMT( +
006480000000                    (*CHAR 10) +
006481000000                    (*CHAR 10) +
006482000000                    (*CHAR 10) +
006483000000                ) +
006484000000                ALROPT(*NO) +
006485000000                CCSID(65535) +
006486000000                /*  -EOF-  */
006487000000
006488000000     /*-------------------------------------------------------------*/
006489000000     /*   Cmd-ADDMSGD für Message-ID :   USR8110                    */
006490000000     /* Option '&1' non valide                                      */
006491000000     /*-------------------------------------------------------------*/
006492000000
006493000000             RMVMSGD MSGID(USR8110) MSGF(&LIB/&OBJ)
006494000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006495000000
006496000000             ADDMSGD +
006497000000                MSGID(USR8110) +
006498000000                MSGF(&LIB/&OBJ) +
006499000000                MSG( +
006500000000'Option ''&1'' non valide'                                            +
006501000000                ) +
006502000000                SEV(0) +
006503000000                FMT( +
006504000000                    (*CHAR 10) +
006505000000                ) +
006506000000                ALROPT(*NO) +
006507000000                CCSID(65535) +
006508000000                /*  -EOF-  */
006509000000
006510000000     /*-------------------------------------------------------------*/
006511000000     /*   Cmd-ADDMSGD für Message-ID :   USR8111                    */
006512000000     /* Oui § tout                                                  */
006513000000     /*-------------------------------------------------------------*/
006514000000
006515000000             RMVMSGD MSGID(USR8111) MSGF(&LIB/&OBJ)
006516000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006517000000
006518000000             ADDMSGD +
006519000000                MSGID(USR8111) +
006520000000                MSGF(&LIB/&OBJ) +
006521000000                MSG( +
006522000000'Oui § tout'                                                          +
006523000000                ) +
006524000000                SEV(0) +
006525000000     /*   No replacement variables defined!                         */ +
006526000000                ALROPT(*NO) +
006527000000                CCSID(65535) +
006528000000                /*  -EOF-  */
006529000000
006530000000     /*-------------------------------------------------------------*/
006531000000     /*   Cmd-ADDMSGD für Message-ID :   USR8112                    */
006532000000     /* Commande acceptäe                                           */
006533000000     /*-------------------------------------------------------------*/
006534000000
006535000000             RMVMSGD MSGID(USR8112) MSGF(&LIB/&OBJ)
006536000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006537000000
006538000000             ADDMSGD +
006539000000                MSGID(USR8112) +
006540000000                MSGF(&LIB/&OBJ) +
006541000000                MSG( +
006542000000'Commande acceptäe'                                                   +
006543000000                ) +
006544000000                SEV(0) +
006545000000     /*   No replacement variables defined!                         */ +
006546000000                ALROPT(*NO) +
006547000000                CCSID(65535) +
006548000000                /*  -EOF-  */
006549000000
006550000000     /*-------------------------------------------------------------*/
006551000000     /*   Cmd-ADDMSGD für Message-ID :   USR8113                    */
006552000000     /* Commande interne &1 invalide                                */
006553000000     /*-------------------------------------------------------------*/
006554000000
006555000000             RMVMSGD MSGID(USR8113) MSGF(&LIB/&OBJ)
006556000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006557000000
006558000000             ADDMSGD +
006559000000                MSGID(USR8113) +
006560000000                MSGF(&LIB/&OBJ) +
006561000000                MSG( +
006562000000'Commande interne &1 invalide'                                        +
006563000000                ) +
006564000000                SEV(0) +
006565000000                FMT( +
006566000000                    (*CHAR 10) +
006567000000                ) +
006568000000                ALROPT(*NO) +
006569000000                CCSID(65535) +
006570000000                /*  -EOF-  */
006571000000
006572000000     /*-------------------------------------------------------------*/
006573000000     /*   Cmd-ADDMSGD für Message-ID :   USR8114                    */
006574000000     /* Cräation du programme RPG ..                                */
006575000000     /*-------------------------------------------------------------*/
006576000000
006577000000             RMVMSGD MSGID(USR8114) MSGF(&LIB/&OBJ)
006578000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006579000000
006580000000             ADDMSGD +
006581000000                MSGID(USR8114) +
006582000000                MSGF(&LIB/&OBJ) +
006583000000                MSG( +
006584000000'Cräation du programme RPG ..'                                        +
006585000000                ) +
006586000000                SEV(0) +
006587000000     /*   No replacement variables defined!                         */ +
006588000000                ALROPT(*NO) +
006589000000                CCSID(65535) +
006590000000                /*  -EOF-  */
006591000000
006592000000     /*-------------------------------------------------------------*/
006593000000     /*   Cmd-ADDMSGD für Message-ID :   USR8115                    */
006594000000     /* Däbut des enregistrements                                   */
006595000000     /*-------------------------------------------------------------*/
006596000000
006597000000             RMVMSGD MSGID(USR8115) MSGF(&LIB/&OBJ)
006598000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006599000000
006600000000             ADDMSGD +
006601000000                MSGID(USR8115) +
006602000000                MSGF(&LIB/&OBJ) +
006603000000                MSG( +
006604000000'Däbut des enregistrements'                                           +
006605000000                ) +
006606000000                SEV(0) +
006607000000     /*   No replacement variables defined!                         */ +
006608000000                ALROPT(*NO) +
006609000000                CCSID(65535) +
006610000000                /*  -EOF-  */
006611000000
006612000000     /*-------------------------------------------------------------*/
006613000000     /*   Cmd-ADDMSGD für Message-ID :   USR8116                    */
006614000000     /* Derniüre colonne                                            */
006615000000     /*-------------------------------------------------------------*/
006616000000
006617000000             RMVMSGD MSGID(USR8116) MSGF(&LIB/&OBJ)
006618000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006619000000
006620000000             ADDMSGD +
006621000000                MSGID(USR8116) +
006622000000                MSGF(&LIB/&OBJ) +
006623000000                MSG( +
006624000000'Derniüre colonne'                                                    +
006625000000                ) +
006626000000                SEV(0) +
006627000000     /*   No replacement variables defined!                         */ +
006628000000                ALROPT(*NO) +
006629000000                CCSID(65535) +
006630000000                /*  -EOF-  */
006631000000
006632000000     /*-------------------------------------------------------------*/
006633000000     /*   Cmd-ADDMSGD für Message-ID :   USR8117                    */
006634000000     /* Pointez un champ et räessayez                               */
006635000000     /*-------------------------------------------------------------*/
006636000000
006637000000             RMVMSGD MSGID(USR8117) MSGF(&LIB/&OBJ)
006638000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006639000000
006640000000             ADDMSGD +
006641000000                MSGID(USR8117) +
006642000000                MSGF(&LIB/&OBJ) +
006643000000                MSG( +
006644000000'Pointez un champ et räessayez'                                       +
006645000000                ) +
006646000000                SEV(0) +
006647000000     /*   No replacement variables defined!                         */ +
006648000000                ALROPT(*NO) +
006649000000                CCSID(65535) +
006650000000                /*  -EOF-  */
006651000000
006652000000     /*-------------------------------------------------------------*/
006653000000     /*   Cmd-ADDMSGD für Message-ID :   USR8118                    */
006654000000     /* Tableau plein                                               */
006655000000     /*-------------------------------------------------------------*/
006656000000
006657000000             RMVMSGD MSGID(USR8118) MSGF(&LIB/&OBJ)
006658000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006659000000
006660000000             ADDMSGD +
006661000000                MSGID(USR8118) +
006662000000                MSGF(&LIB/&OBJ) +
006663000000                MSG( +
006664000000'Tableau plein'                                                       +
006665000000                ) +
006666000000                SEV(0) +
006667000000     /*   No replacement variables defined!                         */ +
006668000000                ALROPT(*NO) +
006669000000                CCSID(65535) +
006670000000                /*  -EOF-  */
006671000000
006672000000     /*-------------------------------------------------------------*/
006673000000     /*   Cmd-ADDMSGD für Message-ID :   USR8119                    */
006674000000     /* Enregistrement däj§ fixä                                    */
006675000000     /*-------------------------------------------------------------*/
006676000000
006677000000             RMVMSGD MSGID(USR8119) MSGF(&LIB/&OBJ)
006678000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006679000000
006680000000             ADDMSGD +
006681000000                MSGID(USR8119) +
006682000000                MSGF(&LIB/&OBJ) +
006683000000                MSG( +
006684000000'Enregistrement däj§ fixä'                                            +
006685000000                ) +
006686000000                SEV(0) +
006687000000     /*   No replacement variables defined!                         */ +
006688000000                ALROPT(*NO) +
006689000000                CCSID(65535) +
006690000000                /*  -EOF-  */
006691000000
006692000000     /*-------------------------------------------------------------*/
006693000000     /*   Cmd-ADDMSGD für Message-ID :   USR8120                    */
006694000000     /* Enregistrement non trouvä                                   */
006695000000     /*-------------------------------------------------------------*/
006696000000
006697000000             RMVMSGD MSGID(USR8120) MSGF(&LIB/&OBJ)
006698000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006699000000
006700000000             ADDMSGD +
006701000000                MSGID(USR8120) +
006702000000                MSGF(&LIB/&OBJ) +
006703000000                MSG( +
006704000000'Enregistrement non trouvä'                                           +
006705000000                ) +
006706000000                SEV(0) +
006707000000     /*   No replacement variables defined!                         */ +
006708000000                ALROPT(*NO) +
006709000000                CCSID(65535) +
006710000000                /*  -EOF-  */
006711000000
006712000000     /*-------------------------------------------------------------*/
006713000000     /*   Cmd-ADDMSGD für Message-ID :   USR8121                    */
006714000000     /* Enregistrement non fixä                                     */
006715000000     /*-------------------------------------------------------------*/
006716000000
006717000000             RMVMSGD MSGID(USR8121) MSGF(&LIB/&OBJ)
006718000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006719000000
006720000000             ADDMSGD +
006721000000                MSGID(USR8121) +
006722000000                MSGF(&LIB/&OBJ) +
006723000000                MSG( +
006724000000'Enregistrement non fixä'                                             +
006725000000                ) +
006726000000                SEV(0) +
006727000000     /*   No replacement variables defined!                         */ +
006728000000                ALROPT(*NO) +
006729000000                CCSID(65535) +
006730000000                /*  -EOF-  */
006731000000
006732000000     /*-------------------------------------------------------------*/
006733000000     /*   Cmd-ADDMSGD für Message-ID :   USR8122                    */
006734000000     /* Touche incorrecte                                           */
006735000000     /*-------------------------------------------------------------*/
006736000000
006737000000             RMVMSGD MSGID(USR8122) MSGF(&LIB/&OBJ)
006738000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006739000000
006740000000             ADDMSGD +
006741000000                MSGID(USR8122) +
006742000000                MSGF(&LIB/&OBJ) +
006743000000                MSG( +
006744000000'Touche incorrecte'                                                   +
006745000000                ) +
006746000000                SEV(0) +
006747000000     /*   No replacement variables defined!                         */ +
006748000000                ALROPT(*NO) +
006749000000                CCSID(65535) +
006750000000                /*  -EOF-  */
006751000000
006752000000     /*-------------------------------------------------------------*/
006753000000     /*   Cmd-ADDMSGD für Message-ID :   USR8123                    */
006754000000     /* Les champs supärieurs § 1024 car. ne peuvent être &1modifiä */
006755000000     /*-------------------------------------------------------------*/
006756000000
006757000000             RMVMSGD MSGID(USR8123) MSGF(&LIB/&OBJ)
006758000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006759000000
006760000000             ADDMSGD +
006761000000                MSGID(USR8123) +
006762000000                MSGF(&LIB/&OBJ) +
006763000000                MSG( +
006764000000'Les champs supärieurs § 1024 car. ne peuvent être &1modifiäs&2.'     +
006765000000                ) +
006766000000                SEV(0) +
006767000000                FMT( +
006768000000                    (*CHAR 1) +
006769000000                    (*CHAR 1) +
006770000000                ) +
006771000000                ALROPT(*NO) +
006772000000                CCSID(65535) +
006773000000                /*  -EOF-  */
006774000000
006775000000     /*-------------------------------------------------------------*/
006776000000     /*   Cmd-ADDMSGD für Message-ID :   USR8124                    */
006777000000     /* Opärande '&1' invalide                                      */
006778000000     /*-------------------------------------------------------------*/
006779000000
006780000000             RMVMSGD MSGID(USR8124) MSGF(&LIB/&OBJ)
006781000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006782000000
006783000000             ADDMSGD +
006784000000                MSGID(USR8124) +
006785000000                MSGF(&LIB/&OBJ) +
006786000000                MSG( +
006787000000'Opärande ''&1'' invalide'                                            +
006788000000                ) +
006789000000                SECLVL( +
006790000000'&N &B Opärandes valides: &N &P EQ   - &gal § &P NE   - diffärent de &-
006791000000P LT   - plus petit que &P GT   - plus grand que &P LE   - plus petit -
006792000000ou ägal § &P GE   - plus grand ou ägal § &P LIKE - comme'             +
006793000000                ) +
006794000000                SEV(0) +
006795000000                FMT( +
006796000000                    (*CHAR 10) +
006797000000                ) +
006798000000                ALROPT(*NO) +
006799000000                CCSID(65535) +
006800000000                /*  -EOF-  */
006801000000
006802000000     /*-------------------------------------------------------------*/
006803000000     /*   Cmd-ADDMSGD für Message-ID :   USR8125                    */
006804000000     /* Valeur incorrecte pour le nombre d'enregistrements § recher */
006805000000     /*-------------------------------------------------------------*/
006806000000
006807000000             RMVMSGD MSGID(USR8125) MSGF(&LIB/&OBJ)
006808000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006809000000
006810000000             ADDMSGD +
006811000000                MSGID(USR8125) +
006812000000                MSGF(&LIB/&OBJ) +
006813000000                MSG( +
006814000000'Valeur incorrecte pour le nombre d''enregistrements § rechercher'    +
006815000000                ) +
006816000000                SEV(0) +
006817000000     /*   No replacement variables defined!                         */ +
006818000000                ALROPT(*NO) +
006819000000                CCSID(65535) +
006820000000                /*  -EOF-  */
006821000000
006822000000     /*-------------------------------------------------------------*/
006823000000     /*   Cmd-ADDMSGD für Message-ID :   USR8126                    */
006824000000     /* Type de recherche '&1' non valide                           */
006825000000     /*-------------------------------------------------------------*/
006826000000
006827000000             RMVMSGD MSGID(USR8126) MSGF(&LIB/&OBJ)
006828000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006829000000
006830000000             ADDMSGD +
006831000000                MSGID(USR8126) +
006832000000                MSGF(&LIB/&OBJ) +
006833000000                MSG( +
006834000000'Type de recherche ''&1'' non valide'                                 +
006835000000                ) +
006836000000                SEV(0) +
006837000000                FMT( +
006838000000                    (*CHAR 10) +
006839000000                ) +
006840000000                ALROPT(*NO) +
006841000000                CCSID(65535) +
006842000000                /*  -EOF-  */
006843000000
006844000000     /*-------------------------------------------------------------*/
006845000000     /*   Cmd-ADDMSGD für Message-ID :   USR8127                    */
006846000000     /* Recherche en cours                                          */
006847000000     /*-------------------------------------------------------------*/
006848000000
006849000000             RMVMSGD MSGID(USR8127) MSGF(&LIB/&OBJ)
006850000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006851000000
006852000000             ADDMSGD +
006853000000                MSGID(USR8127) +
006854000000                MSGF(&LIB/&OBJ) +
006855000000                MSG( +
006856000000'Recherche en cours'                                                  +
006857000000                ) +
006858000000                SEV(0) +
006859000000     /*   No replacement variables defined!                         */ +
006860000000                ALROPT(*NO) +
006861000000                CCSID(65535) +
006862000000                /*  -EOF-  */
006863000000
006864000000     /*-------------------------------------------------------------*/
006865000000     /*   Cmd-ADDMSGD für Message-ID :   USR8128                    */
006866000000     /* Recherche en cours. &1 de &2 enregistrements recherchäs     */
006867000000     /*-------------------------------------------------------------*/
006868000000
006869000000             RMVMSGD MSGID(USR8128) MSGF(&LIB/&OBJ)
006870000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006871000000
006872000000             ADDMSGD +
006873000000                MSGID(USR8128) +
006874000000                MSGF(&LIB/&OBJ) +
006875000000                MSG( +
006876000000'Recherche en cours. &1 de &2 enregistrements recherchäs'             +
006877000000                ) +
006878000000                SEV(0) +
006879000000                FMT( +
006880000000                    (*DEC 10 0) +
006881000000                    (*DEC 10 0) +
006882000000                ) +
006883000000                ALROPT(*NO) +
006884000000                CCSID(65535) +
006885000000                /*  -EOF-  */
006886000000
006887000000     /*-------------------------------------------------------------*/
006888000000     /*   Cmd-ADDMSGD für Message-ID :   USR8129                    */
006889000000     /* Champ '&1' de type '&2' non valide                          */
006890000000     /*-------------------------------------------------------------*/
006891000000
006892000000             RMVMSGD MSGID(USR8129) MSGF(&LIB/&OBJ)
006893000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006894000000
006895000000             ADDMSGD +
006896000000                MSGID(USR8129) +
006897000000                MSGF(&LIB/&OBJ) +
006898000000                MSG( +
006899000000'Champ ''&1'' de type ''&2'' non valide'                              +
006900000000                ) +
006901000000                SEV(0) +
006902000000                FMT( +
006903000000                    (*CHAR 10) +
006904000000                    (*CHAR 10) +
006905000000                ) +
006906000000                ALROPT(*NO) +
006907000000                CCSID(65535) +
006908000000                /*  -EOF-  */
006909000000
006910000000     /*-------------------------------------------------------------*/
006911000000     /*   Cmd-ADDMSGD für Message-ID :   USR8130                    */
006912000000     /* Enregistrement trouvä. 'F16'=continuer/'ENTREE'=Fin.        */
006913000000     /*-------------------------------------------------------------*/
006914000000
006915000000             RMVMSGD MSGID(USR8130) MSGF(&LIB/&OBJ)
006916000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006917000000
006918000000             ADDMSGD +
006919000000                MSGID(USR8130) +
006920000000                MSGF(&LIB/&OBJ) +
006921000000                MSG( +
006922000000'Enregistrement trouvä. ''F16''=continuer/''ENTREE''=Fin.'            +
006923000000                ) +
006924000000                SEV(0) +
006925000000     /*   No replacement variables defined!                         */ +
006926000000                ALROPT(*NO) +
006927000000                CCSID(65535) +
006928000000                /*  -EOF-  */
006929000000
006930000000     /*-------------------------------------------------------------*/
006931000000     /*   Cmd-ADDMSGD für Message-ID :   USR8131                    */
006932000000     /* Fin de fichier - aucun räsultat. 'F16'=continuer / 'ENTREE' */
006933000000     /*-------------------------------------------------------------*/
006934000000
006935000000             RMVMSGD MSGID(USR8131) MSGF(&LIB/&OBJ)
006936000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006937000000
006938000000             ADDMSGD +
006939000000                MSGID(USR8131) +
006940000000                MSGF(&LIB/&OBJ) +
006941000000                MSG( +
006942000000'Fin de fichier - aucun räsultat. ''F16''=continuer / ''ENTREE''=Fin.'+
006943000000                ) +
006944000000                SEV(0) +
006945000000     /*   No replacement variables defined!                         */ +
006946000000                ALROPT(*NO) +
006947000000                CCSID(65535) +
006948000000                /*  -EOF-  */
006949000000
006950000000     /*-------------------------------------------------------------*/
006951000000     /*   Cmd-ADDMSGD für Message-ID :   USR8132                    */
006952000000     /* Nbre maximum de lignes atteint 'F16'=Continuer 'ENTREE'=Aba */
006953000000     /*-------------------------------------------------------------*/
006954000000
006955000000             RMVMSGD MSGID(USR8132) MSGF(&LIB/&OBJ)
006956000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006957000000
006958000000             ADDMSGD +
006959000000                MSGID(USR8132) +
006960000000                MSGF(&LIB/&OBJ) +
006961000000                MSG( +
006962000000'Nbre maximum de lignes atteint ''F16''=Continuer ''ENTREE''=Abandon' +
006963000000                ) +
006964000000                SEV(0) +
006965000000     /*   No replacement variables defined!                         */ +
006966000000                ALROPT(*NO) +
006967000000                CCSID(65535) +
006968000000                /*  -EOF-  */
006969000000
006970000000     /*-------------------------------------------------------------*/
006971000000     /*   Cmd-ADDMSGD für Message-ID :   USR8133                    */
006972000000     /* 1=Respect casse; 0=non respect casse                        */
006973000000     /*-------------------------------------------------------------*/
006974000000
006975000000             RMVMSGD MSGID(USR8133) MSGF(&LIB/&OBJ)
006976000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006977000000
006978000000             ADDMSGD +
006979000000                MSGID(USR8133) +
006980000000                MSGF(&LIB/&OBJ) +
006981000000                MSG( +
006982000000'1=Respect casse; 0=non respect casse'                                +
006983000000                ) +
006984000000                SEV(0) +
006985000000     /*   No replacement variables defined!                         */ +
006986000000                ALROPT(*NO) +
006987000000                CCSID(65535) +
006988000000                /*  -EOF-  */
006989000000
006990000000     /*-------------------------------------------------------------*/
006991000000     /*   Cmd-ADDMSGD für Message-ID :   USR8134                    */
006992000000     /* La combinaison de l'opärande &1 avec le champ &2 est invali */
006993000000     /*-------------------------------------------------------------*/
006994000000
006995000000             RMVMSGD MSGID(USR8134) MSGF(&LIB/&OBJ)
006996000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006997000000
006998000000             ADDMSGD +
006999000000                MSGID(USR8134) +
007000000000                MSGF(&LIB/&OBJ) +
007001000000                MSG( +
007002000000'La combinaison de l''opärande &1 avec le champ &2 est invalide.'     +
007003000000                ) +
007004000000                SEV(0) +
007005000000                FMT( +
007006000000                    (*CHAR 10) +
007007000000                    (*CHAR 10) +
007008000000                ) +
007009000000                ALROPT(*NO) +
007010000000                CCSID(65535) +
007011000000                /*  -EOF-  */
007012000000
007013000000     /*-------------------------------------------------------------*/
007014000000     /*   Cmd-ADDMSGD für Message-ID :   USR8135                    */
007015000000     /* Opärande &1 invalide avec champ de type &2.                 */
007016000000     /*-------------------------------------------------------------*/
007017000000
007018000000             RMVMSGD MSGID(USR8135) MSGF(&LIB/&OBJ)
007019000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007020000000
007021000000             ADDMSGD +
007022000000                MSGID(USR8135) +
007023000000                MSGF(&LIB/&OBJ) +
007024000000                MSG( +
007025000000'Opärande &1 invalide avec champ de type &2.'                         +
007026000000                ) +
007027000000                SEV(0) +
007028000000                FMT( +
007029000000                    (*CHAR 10) +
007030000000                    (*CHAR 10) +
007031000000                ) +
007032000000                ALROPT(*NO) +
007033000000                CCSID(65535) +
007034000000                /*  -EOF-  */
007035000000
007036000000     /*-------------------------------------------------------------*/
007037000000     /*   Cmd-ADDMSGD für Message-ID :   USR8136                    */
007038000000     /* Champ '&1' introuvable                                      */
007039000000     /*-------------------------------------------------------------*/
007040000000
007041000000             RMVMSGD MSGID(USR8136) MSGF(&LIB/&OBJ)
007042000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007043000000
007044000000             ADDMSGD +
007045000000                MSGID(USR8136) +
007046000000                MSGF(&LIB/&OBJ) +
007047000000                MSG( +
007048000000'Champ ''&1'' introuvable'                                            +
007049000000                ) +
007050000000                SECLVL( +
007051000000'&N &B Valeurs possibles: &N &P *RECORD - Recherchez dans tout l''enre-
007052000000gistrement'                                                           +
007053000000                ) +
007054000000                SEV(0) +
007055000000                FMT( +
007056000000                    (*CHAR 10) +
007057000000                ) +
007058000000                ALROPT(*NO) +
007059000000                CCSID(65535) +
007060000000                /*  -EOF-  */
007061000000
007062000000     /*-------------------------------------------------------------*/
007063000000     /*   Cmd-ADDMSGD für Message-ID :   USR8137                    */
007064000000     /* Extraction information clef de &2/&1.                       */
007065000000     /*-------------------------------------------------------------*/
007066000000
007067000000             RMVMSGD MSGID(USR8137) MSGF(&LIB/&OBJ)
007068000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007069000000
007070000000             ADDMSGD +
007071000000                MSGID(USR8137) +
007072000000                MSGF(&LIB/&OBJ) +
007073000000                MSG( +
007074000000'Extraction information clef de &2/&1.'                               +
007075000000                ) +
007076000000                SEV(0) +
007077000000                FMT( +
007078000000                    (*CHAR 10) +
007079000000                    (*CHAR 10) +
007080000000                ) +
007081000000                ALROPT(*NO) +
007082000000                CCSID(65535) +
007083000000                /*  -EOF-  */
007084000000
007085000000     /*-------------------------------------------------------------*/
007086000000     /*   Cmd-ADDMSGD für Message-ID :   USR8138                    */
007087000000     /* Champ &1 contient des donnäes däcimales invalides           */
007088000000     /*-------------------------------------------------------------*/
007089000000
007090000000             RMVMSGD MSGID(USR8138) MSGF(&LIB/&OBJ)
007091000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007092000000
007093000000             ADDMSGD +
007094000000                MSGID(USR8138) +
007095000000                MSGF(&LIB/&OBJ) +
007096000000                MSG( +
007097000000'Champ &1 contient des donnäes däcimales invalides'                   +
007098000000                ) +
007099000000                SEV(0) +
007100000000                FMT( +
007101000000                    (*CHAR 10) +
007102000000                ) +
007103000000                ALROPT(*NO) +
007104000000                CCSID(65535) +
007105000000                /*  -EOF-  */
007106000000
007107000000     /*-------------------------------------------------------------*/
007108000000     /*   Cmd-ADDMSGD für Message-ID :   USR8139                    */
007109000000     /* Impossible de positionner le sous-fichier                   */
007110000000     /*-------------------------------------------------------------*/
007111000000
007112000000             RMVMSGD MSGID(USR8139) MSGF(&LIB/&OBJ)
007113000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007114000000
007115000000             ADDMSGD +
007116000000                MSGID(USR8139) +
007117000000                MSGF(&LIB/&OBJ) +
007118000000                MSG( +
007119000000'Impossible de positionner le sous-fichier'                           +
007120000000                ) +
007121000000                SEV(0) +
007122000000     /*   No replacement variables defined!                         */ +
007123000000                ALROPT(*NO) +
007124000000                CCSID(65535) +
007125000000                /*  -EOF-  */
007126000000
007127000000     /*-------------------------------------------------------------*/
007128000000     /*   Cmd-ADDMSGD für Message-ID :   USR8140                    */
007129000000     /* Veuillez saisir un argument de recherche                    */
007130000000     /*-------------------------------------------------------------*/
007131000000
007132000000             RMVMSGD MSGID(USR8140) MSGF(&LIB/&OBJ)
007133000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007134000000
007135000000             ADDMSGD +
007136000000                MSGID(USR8140) +
007137000000                MSGF(&LIB/&OBJ) +
007138000000                MSG( +
007139000000'Veuillez saisir un argument de recherche'                            +
007140000000                ) +
007141000000                SEV(0) +
007142000000                FMT( +
007143000000                    (*CHAR 10) +
007144000000                ) +
007145000000                ALROPT(*NO) +
007146000000                CCSID(65535) +
007147000000                /*  -EOF-  */
007148000000
007149000000     /*-------------------------------------------------------------*/
007150000000     /*   Cmd-ADDMSGD für Message-ID :   USR8141                    */
007151000000     /* Utiliser '&1' pour les valeurs positives et '&2' pour les n */
007152000000     /*-------------------------------------------------------------*/
007153000000
007154000000             RMVMSGD MSGID(USR8141) MSGF(&LIB/&OBJ)
007155000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007156000000
007157000000             ADDMSGD +
007158000000                MSGID(USR8141) +
007159000000                MSGF(&LIB/&OBJ) +
007160000000                MSG( +
007161000000'Utiliser ''&1'' pour les valeurs positives et ''&2'' pour les nägativ-
007162000000es.'                                                                  +
007163000000                ) +
007164000000                SEV(0) +
007165000000                FMT( +
007166000000                    (*CHAR 10) +
007167000000                    (*CHAR 10) +
007168000000                ) +
007169000000                ALROPT(*NO) +
007170000000                CCSID(65535) +
007171000000                /*  -EOF-  */
007172000000
007173000000     /*-------------------------------------------------------------*/
007174000000     /*   Cmd-ADDMSGD für Message-ID :   USR8142                    */
007175000000     /* Position &1 est räserväe au signe des valeurs numäriques.   */
007176000000     /*-------------------------------------------------------------*/
007177000000
007178000000             RMVMSGD MSGID(USR8142) MSGF(&LIB/&OBJ)
007179000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007180000000
007181000000             ADDMSGD +
007182000000                MSGID(USR8142) +
007183000000                MSGF(&LIB/&OBJ) +
007184000000                MSG( +
007185000000'Position &1 est räserväe au signe des valeurs numäriques.'           +
007186000000                ) +
007187000000                SEV(0) +
007188000000                FMT( +
007189000000                    (*DEC 10 0) +
007190000000                ) +
007191000000                ALROPT(*NO) +
007192000000                CCSID(65535) +
007193000000                /*  -EOF-  */
007194000000
007195000000     /*-------------------------------------------------------------*/
007196000000     /*   Cmd-ADDMSGD für Message-ID :   USR8143                    */
007197000000     /* Pas de programme associä § la touche &1.                    */
007198000000     /*-------------------------------------------------------------*/
007199000000
007200000000             RMVMSGD MSGID(USR8143) MSGF(&LIB/&OBJ)
007201000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007202000000
007203000000             ADDMSGD +
007204000000                MSGID(USR8143) +
007205000000                MSGF(&LIB/&OBJ) +
007206000000                MSG( +
007207000000'Pas de programme associä § la touche &1.'                            +
007208000000                ) +
007209000000                SEV(0) +
007210000000                FMT( +
007211000000                    (*CHAR 10) +
007212000000                ) +
007213000000                ALROPT(*NO) +
007214000000                CCSID(65535) +
007215000000                /*  -EOF-  */
007216000000
007217000000     /*-------------------------------------------------------------*/
007218000000     /*   Cmd-ADDMSGD für Message-ID :   USR8144                    */
007219000000     /* Exäcution räcursive impossible pour commande &1.            */
007220000000     /*-------------------------------------------------------------*/
007221000000
007222000000             RMVMSGD MSGID(USR8144) MSGF(&LIB/&OBJ)
007223000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007224000000
007225000000             ADDMSGD +
007226000000                MSGID(USR8144) +
007227000000                MSGF(&LIB/&OBJ) +
007228000000                MSG( +
007229000000'Exäcution räcursive impossible pour commande &1.'                    +
007230000000                ) +
007231000000                SEV(0) +
007232000000                FMT( +
007233000000                    (*CHAR 10) +
007234000000                ) +
007235000000                ALROPT(*NO) +
007236000000                CCSID(65535) +
007237000000                /*  -EOF-  */
007238000000
007239000000     /*-------------------------------------------------------------*/
007240000000     /*   Cmd-ADDMSGD für Message-ID :   USR8145                    */
007241000000     /* Impossible d'exäcuter une commande - sous-fichier vide.     */
007242000000     /*-------------------------------------------------------------*/
007243000000
007244000000             RMVMSGD MSGID(USR8145) MSGF(&LIB/&OBJ)
007245000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007246000000
007247000000             ADDMSGD +
007248000000                MSGID(USR8145) +
007249000000                MSGF(&LIB/&OBJ) +
007250000000                MSG( +
007251000000'Impossible d''exäcuter une commande - sous-fichier vide.'            +
007252000000                ) +
007253000000                SEV(0) +
007254000000     /*   No replacement variables defined!                         */ +
007255000000                ALROPT(*NO) +
007256000000                CCSID(65535) +
007257000000                /*  -EOF-  */
007258000000
007259000000     /*-------------------------------------------------------------*/
007260000000     /*   Cmd-ADDMSGD für Message-ID :   USR8146                    */
007261000000     /* Positionnez le curseur sur un champ puis Enträe.            */
007262000000     /*-------------------------------------------------------------*/
007263000000
007264000000             RMVMSGD MSGID(USR8146) MSGF(&LIB/&OBJ)
007265000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007266000000
007267000000             ADDMSGD +
007268000000                MSGID(USR8146) +
007269000000                MSGF(&LIB/&OBJ) +
007270000000                MSG( +
007271000000'Positionnez le curseur sur un champ puis Enträe.'                    +
007272000000                ) +
007273000000                SEV(0) +
007274000000     /*   No replacement variables defined!                         */ +
007275000000                ALROPT(*NO) +
007276000000                CCSID(65535) +
007277000000                /*  -EOF-  */
007278000000
007279000000     /*-------------------------------------------------------------*/
007280000000     /*   Cmd-ADDMSGD für Message-ID :   USR8147                    */
007281000000     /* Le champ &1 n'a pas ätä pointä                              */
007282000000     /*-------------------------------------------------------------*/
007283000000
007284000000             RMVMSGD MSGID(USR8147) MSGF(&LIB/&OBJ)
007285000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007286000000
007287000000             ADDMSGD +
007288000000                MSGID(USR8147) +
007289000000                MSGF(&LIB/&OBJ) +
007290000000                MSG( +
007291000000'Le champ &1 n''a pas ätä pointä'                                     +
007292000000                ) +
007293000000                SEV(0) +
007294000000                FMT( +
007295000000                    (*CHAR 10) +
007296000000                ) +
007297000000                ALROPT(*NO) +
007298000000                CCSID(65535) +
007299000000                /*  -EOF-  */
007300000000
007301000000     /*-------------------------------------------------------------*/
007302000000     /*   Cmd-ADDMSGD für Message-ID :   USR8148                    */
007303000000     /* Plus de place pour le champ '&1'.                           */
007304000000     /*-------------------------------------------------------------*/
007305000000
007306000000             RMVMSGD MSGID(USR8148) MSGF(&LIB/&OBJ)
007307000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007308000000
007309000000             ADDMSGD +
007310000000                MSGID(USR8148) +
007311000000                MSGF(&LIB/&OBJ) +
007312000000                MSG( +
007313000000'Plus de place pour le champ ''&1''.'                                 +
007314000000                ) +
007315000000                SEV(0) +
007316000000                FMT( +
007317000000                    (*CHAR 10) +
007318000000                ) +
007319000000                ALROPT(*NO) +
007320000000                CCSID(65535) +
007321000000                /*  -EOF-  */
007322000000
007323000000     /*-------------------------------------------------------------*/
007324000000     /*   Cmd-ADDMSGD für Message-ID :   USR8149                    */
007325000000     /* Mode couleur däj§ activä pour les lignes.                   */
007326000000     /*-------------------------------------------------------------*/
007327000000
007328000000             RMVMSGD MSGID(USR8149) MSGF(&LIB/&OBJ)
007329000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007330000000
007331000000             ADDMSGD +
007332000000                MSGID(USR8149) +
007333000000                MSGF(&LIB/&OBJ) +
007334000000                MSG( +
007335000000'Mode couleur däj§ activä pour les lignes.'                           +
007336000000                ) +
007337000000                SEV(0) +
007338000000     /*   No replacement variables defined!                         */ +
007339000000                ALROPT(*NO) +
007340000000                CCSID(65535) +
007341000000                /*  -EOF-  */
007342000000
007343000000     /*-------------------------------------------------------------*/
007344000000     /*   Cmd-ADDMSGD für Message-ID :   USR8150                    */
007345000000     /* Mode monochrome däj§ activä pour les lignes.                */
007346000000     /*-------------------------------------------------------------*/
007347000000
007348000000             RMVMSGD MSGID(USR8150) MSGF(&LIB/&OBJ)
007349000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007350000000
007351000000             ADDMSGD +
007352000000                MSGID(USR8150) +
007353000000                MSGF(&LIB/&OBJ) +
007354000000                MSG( +
007355000000'Mode monochrome däj§ activä pour les lignes.'                        +
007356000000                ) +
007357000000                SEV(0) +
007358000000     /*   No replacement variables defined!                         */ +
007359000000                ALROPT(*NO) +
007360000000                CCSID(65535) +
007361000000                /*  -EOF-  */
007362000000
007363000000     /*-------------------------------------------------------------*/
007364000000     /*   Cmd-ADDMSGD für Message-ID :   USR8151                    */
007365000000     /* Nom invalide pour fichier cible '&1'.                       */
007366000000     /*-------------------------------------------------------------*/
007367000000
007368000000             RMVMSGD MSGID(USR8151) MSGF(&LIB/&OBJ)
007369000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007370000000
007371000000             ADDMSGD +
007372000000                MSGID(USR8151) +
007373000000                MSGF(&LIB/&OBJ) +
007374000000                MSG( +
007375000000'Nom invalide pour fichier cible ''&1''.'                             +
007376000000                ) +
007377000000                SEV(0) +
007378000000                FMT( +
007379000000                    (*CHAR 10) +
007380000000                ) +
007381000000                ALROPT(*NO) +
007382000000                CCSID(65535) +
007383000000                /*  -EOF-  */
007384000000
007385000000     /*-------------------------------------------------------------*/
007386000000     /*   Cmd-ADDMSGD für Message-ID :   USR8152                    */
007387000000     /* Nom invalide pour bibliothüque cible '&1'.                  */
007388000000     /*-------------------------------------------------------------*/
007389000000
007390000000             RMVMSGD MSGID(USR8152) MSGF(&LIB/&OBJ)
007391000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007392000000
007393000000             ADDMSGD +
007394000000                MSGID(USR8152) +
007395000000                MSGF(&LIB/&OBJ) +
007396000000                MSG( +
007397000000'Nom invalide pour bibliothüque cible ''&1''.'                        +
007398000000                ) +
007399000000                SEV(0) +
007400000000                FMT( +
007401000000                    (*CHAR 10) +
007402000000                ) +
007403000000                ALROPT(*NO) +
007404000000                CCSID(65535) +
007405000000                /*  -EOF-  */
007406000000
007407000000     /*-------------------------------------------------------------*/
007408000000     /*   Cmd-ADDMSGD für Message-ID :   USR8153                    */
007409000000     /* Nom invalide pour membre cible '&1'.                        */
007410000000     /*-------------------------------------------------------------*/
007411000000
007412000000             RMVMSGD MSGID(USR8153) MSGF(&LIB/&OBJ)
007413000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007414000000
007415000000             ADDMSGD +
007416000000                MSGID(USR8153) +
007417000000                MSGF(&LIB/&OBJ) +
007418000000                MSG( +
007419000000'Nom invalide pour membre cible ''&1''.'                              +
007420000000                ) +
007421000000                SEV(0) +
007422000000                FMT( +
007423000000                    (*CHAR 10) +
007424000000                ) +
007425000000                ALROPT(*NO) +
007426000000                CCSID(65535) +
007427000000                /*  -EOF-  */
007428000000
007429000000     /*-------------------------------------------------------------*/
007430000000     /*   Cmd-ADDMSGD für Message-ID :   USR8154                    */
007431000000     /* Paramütre invalide '&1' pour ajout/remplacement.            */
007432000000     /*-------------------------------------------------------------*/
007433000000
007434000000             RMVMSGD MSGID(USR8154) MSGF(&LIB/&OBJ)
007435000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007436000000
007437000000             ADDMSGD +
007438000000                MSGID(USR8154) +
007439000000                MSGF(&LIB/&OBJ) +
007440000000                MSG( +
007441000000'Paramütre invalide ''&1'' pour ajout/remplacement.'                  +
007442000000                ) +
007443000000                SEV(0) +
007444000000                FMT( +
007445000000                    (*CHAR 10) +
007446000000                ) +
007447000000                ALROPT(*NO) +
007448000000                CCSID(65535) +
007449000000                /*  -EOF-  */
007450000000
007451000000     /*-------------------------------------------------------------*/
007452000000     /*   Cmd-ADDMSGD für Message-ID :   USR8155                    */
007453000000     /* Paramütre invalide '&1' pour cräation de fichier.           */
007454000000     /*-------------------------------------------------------------*/
007455000000
007456000000             RMVMSGD MSGID(USR8155) MSGF(&LIB/&OBJ)
007457000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007458000000
007459000000             ADDMSGD +
007460000000                MSGID(USR8155) +
007461000000                MSGF(&LIB/&OBJ) +
007462000000                MSG( +
007463000000'Paramütre invalide ''&1'' pour cräation de fichier.'                 +
007464000000                ) +
007465000000                SEV(0) +
007466000000                FMT( +
007467000000                    (*CHAR 10) +
007468000000                ) +
007469000000                ALROPT(*NO) +
007470000000                CCSID(65535) +
007471000000                /*  -EOF-  */
007472000000
007473000000     /*-------------------------------------------------------------*/
007474000000     /*   Cmd-ADDMSGD für Message-ID :   USR8156                    */
007475000000     /* Execution en ächec                                          */
007476000000     /*-------------------------------------------------------------*/
007477000000
007478000000             RMVMSGD MSGID(USR8156) MSGF(&LIB/&OBJ)
007479000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007480000000
007481000000             ADDMSGD +
007482000000                MSGID(USR8156) +
007483000000                MSGF(&LIB/&OBJ) +
007484000000                MSG( +
007485000000'Execution en ächec'                                                  +
007486000000                ) +
007487000000                SEV(0) +
007488000000     /*   No replacement variables defined!                         */ +
007489000000                ALROPT(*NO) +
007490000000                CCSID(65535) +
007491000000                /*  -EOF-  */
007492000000
007493000000     /*-------------------------------------------------------------*/
007494000000     /*   Cmd-ADDMSGD für Message-ID :   USR8157                    */
007495000000     /* Extraction des valeurs systüme                              */
007496000000     /*-------------------------------------------------------------*/
007497000000
007498000000             RMVMSGD MSGID(USR8157) MSGF(&LIB/&OBJ)
007499000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007500000000
007501000000             ADDMSGD +
007502000000                MSGID(USR8157) +
007503000000                MSGF(&LIB/&OBJ) +
007504000000                MSG( +
007505000000'Extraction des valeurs systüme'                                      +
007506000000                ) +
007507000000                SEV(0) +
007508000000     /*   No replacement variables defined!                         */ +
007509000000                ALROPT(*NO) +
007510000000                CCSID(65535) +
007511000000                /*  -EOF-  */
007512000000
007513000000     /*-------------------------------------------------------------*/
007514000000     /*   Cmd-ADDMSGD für Message-ID :   USR8158                    */
007515000000     /* Licence invalide NÄ. '&1'.                                  */
007516000000     /*-------------------------------------------------------------*/
007517000000
007518000000             RMVMSGD MSGID(USR8158) MSGF(&LIB/&OBJ)
007519000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007520000000
007521000000             ADDMSGD +
007522000000                MSGID(USR8158) +
007523000000                MSGF(&LIB/&OBJ) +
007524000000                MSG( +
007525000000'Licence invalide NÄ. ''&1''.'                                        +
007526000000                ) +
007527000000                SEV(0) +
007528000000                FMT( +
007529000000                    (*CHAR 20) +
007530000000                ) +
007531000000                ALROPT(*NO) +
007532000000                CCSID(65535) +
007533000000                /*  -EOF-  */
007534000000
007535000000     /*-------------------------------------------------------------*/
007536000000     /*   Cmd-ADDMSGD für Message-ID :   USR8159                    */
007537000000     /* Impossible de sauvegarder les donnäes de licence.           */
007538000000     /*-------------------------------------------------------------*/
007539000000
007540000000             RMVMSGD MSGID(USR8159) MSGF(&LIB/&OBJ)
007541000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007542000000
007543000000             ADDMSGD +
007544000000                MSGID(USR8159) +
007545000000                MSGF(&LIB/&OBJ) +
007546000000                MSG( +
007547000000'Impossible de sauvegarder les donnäes de licence.'                   +
007548000000                ) +
007549000000                SEV(0) +
007550000000     /*   No replacement variables defined!                         */ +
007551000000                ALROPT(*NO) +
007552000000                CCSID(65535) +
007553000000                /*  -EOF-  */
007554000000
007555000000     /*-------------------------------------------------------------*/
007556000000     /*   Cmd-ADDMSGD für Message-ID :   USR8160                    */
007557000000     /* Fichier des däfinitions inexistant pour la langue &1.       */
007558000000     /*-------------------------------------------------------------*/
007559000000
007560000000             RMVMSGD MSGID(USR8160) MSGF(&LIB/&OBJ)
007561000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007562000000
007563000000             ADDMSGD +
007564000000                MSGID(USR8160) +
007565000000                MSGF(&LIB/&OBJ) +
007566000000                MSG( +
007567000000'Fichier des däfinitions inexistant pour la langue &1.'               +
007568000000                ) +
007569000000                SEV(0) +
007570000000                FMT( +
007571000000                    (*CHAR 10) +
007572000000                ) +
007573000000                ALROPT(*NO) +
007574000000                CCSID(65535) +
007575000000                /*  -EOF-  */
007576000000
007577000000     /*-------------------------------------------------------------*/
007578000000     /*   Cmd-ADDMSGD für Message-ID :   USR8161                    */
007579000000     /* Ecran d'accueil activä                                      */
007580000000     /*-------------------------------------------------------------*/
007581000000
007582000000             RMVMSGD MSGID(USR8161) MSGF(&LIB/&OBJ)
007583000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007584000000
007585000000             ADDMSGD +
007586000000                MSGID(USR8161) +
007587000000                MSGF(&LIB/&OBJ) +
007588000000                MSG( +
007589000000'Ecran d''accueil activä'                                             +
007590000000                ) +
007591000000                SEV(0) +
007592000000     /*   No replacement variables defined!                         */ +
007593000000                ALROPT(*NO) +
007594000000                CCSID(65535) +
007595000000                /*  -EOF-  */
007596000000
007597000000     /*-------------------------------------------------------------*/
007598000000     /*   Cmd-ADDMSGD für Message-ID :   USR8162                    */
007599000000     /* Ecran d'accueil däsactivä                                   */
007600000000     /*-------------------------------------------------------------*/
007601000000
007602000000             RMVMSGD MSGID(USR8162) MSGF(&LIB/&OBJ)
007603000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007604000000
007605000000             ADDMSGD +
007606000000                MSGID(USR8162) +
007607000000                MSGF(&LIB/&OBJ) +
007608000000                MSG( +
007609000000'Ecran d''accueil däsactivä'                                          +
007610000000                ) +
007611000000                SEV(0) +
007612000000     /*   No replacement variables defined!                         */ +
007613000000                ALROPT(*NO) +
007614000000                CCSID(65535) +
007615000000                /*  -EOF-  */
007616000000
007617000000     /*-------------------------------------------------------------*/
007618000000     /*   Cmd-ADDMSGD für Message-ID :   USR8163                    */
007619000000     /* La chaîne contient des caractüres <  x''40'' ou = x''FF''.  */
007620000000     /*-------------------------------------------------------------*/
007621000000
007622000000             RMVMSGD MSGID(USR8163) MSGF(&LIB/&OBJ)
007623000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007624000000
007625000000             ADDMSGD +
007626000000                MSGID(USR8163) +
007627000000                MSGF(&LIB/&OBJ) +
007628000000                MSG( +
007629000000'La chaîne contient des caractüres <  x''''40'''' ou = x''''FF''''. Re-
007630000000mplacäs par: &1'''                                                    +
007631000000                ) +
007632000000                SEV(0) +
007633000000                FMT( +
007634000000                    (*CHAR 1) +
007635000000                ) +
007636000000                ALROPT(*NO) +
007637000000                CCSID(65535) +
007638000000                /*  -EOF-  */
007639000000
007640000000     /*-------------------------------------------------------------*/
007641000000     /*   Cmd-ADDMSGD für Message-ID :   USR8164                    */
007642000000     /* Les champs contenant des caractüres non äditables sont igno */
007643000000     /*-------------------------------------------------------------*/
007644000000
007645000000             RMVMSGD MSGID(USR8164) MSGF(&LIB/&OBJ)
007646000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007647000000
007648000000             ADDMSGD +
007649000000                MSGID(USR8164) +
007650000000                MSGF(&LIB/&OBJ) +
007651000000                MSG( +
007652000000'Les champs contenant des caractüres non äditables sont ignoräs'      +
007653000000                ) +
007654000000                SEV(0) +
007655000000     /*   No replacement variables defined!                         */ +
007656000000                ALROPT(*NO) +
007657000000                CCSID(65535) +
007658000000                /*  -EOF-  */
007659000000
007660000000     /*-------------------------------------------------------------*/
007661000000     /*   Cmd-ADDMSGD für Message-ID :   USR8165                    */
007662000000     /* Veuillez choisir une option avant de faire 'räpäter'        */
007663000000     /*-------------------------------------------------------------*/
007664000000
007665000000             RMVMSGD MSGID(USR8165) MSGF(&LIB/&OBJ)
007666000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007667000000
007668000000             ADDMSGD +
007669000000                MSGID(USR8165) +
007670000000                MSGF(&LIB/&OBJ) +
007671000000                MSG( +
007672000000'Veuillez choisir une option avant de faire ''räpäter'''              +
007673000000                ) +
007674000000                SEV(0) +
007675000000     /*   No replacement variables defined!                         */ +
007676000000                ALROPT(*NO) +
007677000000                CCSID(65535) +
007678000000                /*  -EOF-  */
007679000000
007680000000     /*-------------------------------------------------------------*/
007681000000     /*   Cmd-ADDMSGD für Message-ID :   USR8166                    */
007682000000     /* Impossible d'äxäcuter l'option sans fichier ouvert          */
007683000000     /*-------------------------------------------------------------*/
007684000000
007685000000             RMVMSGD MSGID(USR8166) MSGF(&LIB/&OBJ)
007686000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007687000000
007688000000             ADDMSGD +
007689000000                MSGID(USR8166) +
007690000000                MSGF(&LIB/&OBJ) +
007691000000                MSG( +
007692000000'Impossible d''äxäcuter l''option sans fichier ouvert'                +
007693000000                ) +
007694000000                SEV(0) +
007695000000     /*   No replacement variables defined!                         */ +
007696000000                ALROPT(*NO) +
007697000000                CCSID(65535) +
007698000000                /*  -EOF-  */
007699000000
007700000000     /*-------------------------------------------------------------*/
007701000000     /*   Cmd-ADDMSGD für Message-ID :   USR8167                    */
007702000000     /* Le nÄ de säquence doit être unique.                         */
007703000000     /*-------------------------------------------------------------*/
007704000000
007705000000             RMVMSGD MSGID(USR8167) MSGF(&LIB/&OBJ)
007706000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007707000000
007708000000             ADDMSGD +
007709000000                MSGID(USR8167) +
007710000000                MSGF(&LIB/&OBJ) +
007711000000                MSG( +
007712000000'Le nÄ de säquence doit être unique.'                                 +
007713000000                ) +
007714000000                SEV(0) +
007715000000     /*   No replacement variables defined!                         */ +
007716000000                ALROPT(*NO) +
007717000000                CCSID(65535) +
007718000000                /*  -EOF-  */
007719000000
007720000000     /*-------------------------------------------------------------*/
007721000000     /*   Cmd-ADDMSGD für Message-ID :   USR8168                    */
007722000000     /* Valeur &1 interdite pour l'attribut "Visible/invisible".    */
007723000000     /*-------------------------------------------------------------*/
007724000000
007725000000             RMVMSGD MSGID(USR8168) MSGF(&LIB/&OBJ)
007726000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007727000000
007728000000             ADDMSGD +
007729000000                MSGID(USR8168) +
007730000000                MSGF(&LIB/&OBJ) +
007731000000                MSG( +
007732000000'Valeur &1 interdite pour l''attribut "Visible/invisible".'           +
007733000000                ) +
007734000000                SEV(0) +
007735000000                FMT( +
007736000000                    (*CHAR 10) +
007737000000                ) +
007738000000                ALROPT(*NO) +
007739000000                CCSID(65535) +
007740000000                /*  -EOF-  */
007741000000
007742000000     /*-------------------------------------------------------------*/
007743000000     /*   Cmd-ADDMSGD für Message-ID :   USR8169                    */
007744000000     /* Valeur &1 interdite pour l'attribut "Repärer champ".        */
007745000000     /*-------------------------------------------------------------*/
007746000000
007747000000             RMVMSGD MSGID(USR8169) MSGF(&LIB/&OBJ)
007748000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007749000000
007750000000             ADDMSGD +
007751000000                MSGID(USR8169) +
007752000000                MSGF(&LIB/&OBJ) +
007753000000                MSG( +
007754000000'Valeur &1 interdite pour l''attribut "Repärer champ".'               +
007755000000                ) +
007756000000                SEV(0) +
007757000000                FMT( +
007758000000                    (*CHAR 10) +
007759000000                ) +
007760000000                ALROPT(*NO) +
007761000000                CCSID(65535) +
007762000000                /*  -EOF-  */
007763000000
007764000000     /*-------------------------------------------------------------*/
007765000000     /*   Cmd-ADDMSGD für Message-ID :   USR8170                    */
007766000000     /* Valeur &1 interdite pour l'attribut "Taille le maximum".    */
007767000000     /*-------------------------------------------------------------*/
007768000000
007769000000             RMVMSGD MSGID(USR8170) MSGF(&LIB/&OBJ)
007770000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007771000000
007772000000             ADDMSGD +
007773000000                MSGID(USR8170) +
007774000000                MSGF(&LIB/&OBJ) +
007775000000                MSG( +
007776000000'Valeur &1 interdite pour l''attribut "Taille le maximum".'           +
007777000000                ) +
007778000000                SEV(0) +
007779000000                FMT( +
007780000000                    (*DEC 10 0) +
007781000000                ) +
007782000000                ALROPT(*NO) +
007783000000                CCSID(65535) +
007784000000                /*  -EOF-  */
007785000000
007786000000     /*-------------------------------------------------------------*/
007787000000     /*   Cmd-ADDMSGD für Message-ID :   USR8171                    */
007788000000     /* Valeur invalide '&1' pour champ date, heure ou horodatage.  */
007789000000     /*-------------------------------------------------------------*/
007790000000
007791000000             RMVMSGD MSGID(USR8171) MSGF(&LIB/&OBJ)
007792000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007793000000
007794000000             ADDMSGD +
007795000000                MSGID(USR8171) +
007796000000                MSGF(&LIB/&OBJ) +
007797000000                MSG( +
007798000000'Valeur invalide ''&1'' pour champ date, heure ou horodatage.'        +
007799000000                ) +
007800000000                SEV(0) +
007801000000                FMT( +
007802000000                    (*CHAR 26) +
007803000000                ) +
007804000000                ALROPT(*NO) +
007805000000                CCSID(65535) +
007806000000                /*  -EOF-  */
007807000000
007808000000     /*-------------------------------------------------------------*/
007809000000     /*   Cmd-ADDMSGD für Message-ID :   USR8172                    */
007810000000     /* En traitement: &1                                           */
007811000000     /*-------------------------------------------------------------*/
007812000000
007813000000             RMVMSGD MSGID(USR8172) MSGF(&LIB/&OBJ)
007814000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007815000000
007816000000             ADDMSGD +
007817000000                MSGID(USR8172) +
007818000000                MSGF(&LIB/&OBJ) +
007819000000                MSG( +
007820000000'En traitement: &1'                                                   +
007821000000                ) +
007822000000                SEV(0) +
007823000000                FMT( +
007824000000                    (*CHAR 50) +
007825000000                ) +
007826000000                ALROPT(*NO) +
007827000000                CCSID(65535) +
007828000000                /*  -EOF-  */
007829000000
007830000000     /*-------------------------------------------------------------*/
007831000000     /*   Cmd-ADDMSGD für Message-ID :   USR8173                    */
007832000000     /* Appels räcursifs non supportäs par Peek/400.                */
007833000000     /*-------------------------------------------------------------*/
007834000000
007835000000             RMVMSGD MSGID(USR8173) MSGF(&LIB/&OBJ)
007836000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007837000000
007838000000             ADDMSGD +
007839000000                MSGID(USR8173) +
007840000000                MSGF(&LIB/&OBJ) +
007841000000                MSG( +
007842000000'Appels räcursifs non supportäs par Peek/400.'                        +
007843000000                ) +
007844000000                SEV(0) +
007845000000     /*   No replacement variables defined!                         */ +
007846000000                ALROPT(*NO) +
007847000000                CCSID(65535) +
007848000000                /*  -EOF-  */
007849000000
007850000000     /*-------------------------------------------------------------*/
007851000000     /*   Cmd-ADDMSGD für Message-ID :   USR8174                    */
007852000000     /* Caractüre (&1) interdit dans une chaîne hexa                */
007853000000     /*-------------------------------------------------------------*/
007854000000
007855000000             RMVMSGD MSGID(USR8174) MSGF(&LIB/&OBJ)
007856000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007857000000
007858000000             ADDMSGD +
007859000000                MSGID(USR8174) +
007860000000                MSGF(&LIB/&OBJ) +
007861000000                MSG( +
007862000000'Caractüre (&1) interdit dans une chaîne hexa'                        +
007863000000                ) +
007864000000                SEV(0) +
007865000000                FMT( +
007866000000                    (*CHAR 1) +
007867000000                ) +
007868000000                ALROPT(*NO) +
007869000000                CCSID(65535) +
007870000000                /*  -EOF-  */
007871000000
007872000000     /*-------------------------------------------------------------*/
007873000000     /*   Cmd-ADDMSGD für Message-ID :   USR8175                    */
007874000000     /* Il est interdit de saisir un nombre impair de caractüres    */
007875000000     /*-------------------------------------------------------------*/
007876000000
007877000000             RMVMSGD MSGID(USR8175) MSGF(&LIB/&OBJ)
007878000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007879000000
007880000000             ADDMSGD +
007881000000                MSGID(USR8175) +
007882000000                MSGF(&LIB/&OBJ) +
007883000000                MSG( +
007884000000'Il est interdit de saisir un nombre impair de caractüres'            +
007885000000                ) +
007886000000                SEV(0) +
007887000000                FMT( +
007888000000                    (*CHAR 1) +
007889000000                ) +
007890000000                ALROPT(*NO) +
007891000000                CCSID(65535) +
007892000000                /*  -EOF-  */
007893000000
007894000000     /*-------------------------------------------------------------*/
007895000000     /*   Cmd-ADDMSGD für Message-ID :   USR8176                    */
007896000000     /* Attention : Chaîne trop longue.                             */
007897000000     /*-------------------------------------------------------------*/
007898000000
007899000000             RMVMSGD MSGID(USR8176) MSGF(&LIB/&OBJ)
007900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007901000000
007902000000             ADDMSGD +
007903000000                MSGID(USR8176) +
007904000000                MSGF(&LIB/&OBJ) +
007905000000                MSG( +
007906000000'Attention : Chaîne trop longue.'                                     +
007907000000                ) +
007908000000                SEV(0) +
007909000000                FMT( +
007910000000                    (*CHAR 1) +
007911000000                ) +
007912000000                ALROPT(*NO) +
007913000000                CCSID(65535) +
007914000000                /*  -EOF-  */
007915000000
007916000000     /*-------------------------------------------------------------*/
007917000000     /*   Cmd-ADDMSGD für Message-ID :   USR8177                    */
007918000000     /* La position de däpart däpasse la taille du champ.           */
007919000000     /*-------------------------------------------------------------*/
007920000000
007921000000             RMVMSGD MSGID(USR8177) MSGF(&LIB/&OBJ)
007922000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007923000000
007924000000             ADDMSGD +
007925000000                MSGID(USR8177) +
007926000000                MSGF(&LIB/&OBJ) +
007927000000                MSG( +
007928000000'La position de däpart däpasse la taille du champ.'                   +
007929000000                ) +
007930000000                SEV(0) +
007931000000                FMT( +
007932000000                    (*CHAR 1) +
007933000000                ) +
007934000000                ALROPT(*NO) +
007935000000                CCSID(65535) +
007936000000                /*  -EOF-  */
007937000000
007938000000     /*-------------------------------------------------------------*/
007939000000     /*   Cmd-ADDMSGD für Message-ID :   USR8178                    */
007940000000     /* Position de däpart infärieure ou ägale § 0.                 */
007941000000     /*-------------------------------------------------------------*/
007942000000
007943000000             RMVMSGD MSGID(USR8178) MSGF(&LIB/&OBJ)
007944000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007945000000
007946000000             ADDMSGD +
007947000000                MSGID(USR8178) +
007948000000                MSGF(&LIB/&OBJ) +
007949000000                MSG( +
007950000000'Position de däpart infärieure ou ägale § 0.'                         +
007951000000                ) +
007952000000                SEV(0) +
007953000000     /*   No replacement variables defined!                         */ +
007954000000                ALROPT(*NO) +
007955000000                CCSID(65535) +
007956000000                /*  -EOF-  */
007957000000
007958000000     /*-------------------------------------------------------------*/
007959000000     /*   Cmd-ADDMSGD für Message-ID :   USR8179                    */
007960000000     /* Pas de guide disponible                                     */
007961000000     /*-------------------------------------------------------------*/
007962000000
007963000000             RMVMSGD MSGID(USR8179) MSGF(&LIB/&OBJ)
007964000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007965000000
007966000000             ADDMSGD +
007967000000                MSGID(USR8179) +
007968000000                MSGF(&LIB/&OBJ) +
007969000000                MSG( +
007970000000'Pas de guide disponible'                                             +
007971000000                ) +
007972000000                SEV(0) +
007973000000     /*   No replacement variables defined!                         */ +
007974000000                ALROPT(*NO) +
007975000000                CCSID(65535) +
007976000000                /*  -EOF-  */
007977000000
007978000000     /*-------------------------------------------------------------*/
007979000000     /*   Cmd-ADDMSGD für Message-ID :   USR8180                    */
007980000000     /* Membre &1 introuvable.                                      */
007981000000     /*-------------------------------------------------------------*/
007982000000
007983000000             RMVMSGD MSGID(USR8180) MSGF(&LIB/&OBJ)
007984000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
007985000000
007986000000             ADDMSGD +
007987000000                MSGID(USR8180) +
007988000000                MSGF(&LIB/&OBJ) +
007989000000                MSG( +
007990000000'Membre &1 introuvable.'                                              +
007991000000                ) +
007992000000                SEV(0) +
007993000000                FMT( +
007994000000                    (*CHAR 10) +
007995000000                ) +
007996000000                ALROPT(*NO) +
007997000000                CCSID(65535) +
007998000000                /*  -EOF-  */
007999000000
008000000000     /*-------------------------------------------------------------*/
008001000000     /*   Cmd-ADDMSGD für Message-ID :   USR8181                    */
008002000000     /* Sauvegarde de l'environment impossible. Il manque le nom du */
008003000000     /*-------------------------------------------------------------*/
008004000000
008005000000             RMVMSGD MSGID(USR8181) MSGF(&LIB/&OBJ)
008006000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008007000000
008008000000             ADDMSGD +
008009000000                MSGID(USR8181) +
008010000000                MSGF(&LIB/&OBJ) +
008011000000                MSG( +
008012000000'Sauvegarde de l''environment impossible. Il manque le nom du fichier.-
008013000000'                                                                     +
008014000000                ) +
008015000000                SEV(0) +
008016000000     /*   No replacement variables defined!                         */ +
008017000000                ALROPT(*NO) +
008018000000                CCSID(65535) +
008019000000                /*  -EOF-  */
008020000000
008021000000     /*-------------------------------------------------------------*/
008022000000     /*   Cmd-ADDMSGD für Message-ID :   USR8182                    */
008023000000     /* &1 n'est pas un nom valide pour un objet AS/400.            */
008024000000     /*-------------------------------------------------------------*/
008025000000
008026000000             RMVMSGD MSGID(USR8182) MSGF(&LIB/&OBJ)
008027000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008028000000
008029000000             ADDMSGD +
008030000000                MSGID(USR8182) +
008031000000                MSGF(&LIB/&OBJ) +
008032000000                MSG( +
008033000000'&1 n''est pas un nom valide pour un objet AS/400.'                   +
008034000000                ) +
008035000000                SEV(0) +
008036000000                FMT( +
008037000000                    (*CHAR 10) +
008038000000                ) +
008039000000                ALROPT(*NO) +
008040000000                CCSID(65535) +
008041000000                /*  -EOF-  */
008042000000
008043000000     /*-------------------------------------------------------------*/
008044000000     /*   Cmd-ADDMSGD für Message-ID :   USR8183                    */
008045000000     /* Informations manquantes.                                    */
008046000000     /*-------------------------------------------------------------*/
008047000000
008048000000             RMVMSGD MSGID(USR8183) MSGF(&LIB/&OBJ)
008049000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008050000000
008051000000             ADDMSGD +
008052000000                MSGID(USR8183) +
008053000000                MSGF(&LIB/&OBJ) +
008054000000                MSG( +
008055000000'Informations manquantes.'                                            +
008056000000                ) +
008057000000                SEV(0) +
008058000000     /*   No replacement variables defined!                         */ +
008059000000                ALROPT(*NO) +
008060000000                CCSID(65535) +
008061000000                /*  -EOF-  */
008062000000
008063000000     /*-------------------------------------------------------------*/
008064000000     /*   Cmd-ADDMSGD für Message-ID :   USR8184                    */
008065000000     /* Cette fonction est inactive. Veuillez contacter votre admin */
008066000000     /*-------------------------------------------------------------*/
008067000000
008068000000             RMVMSGD MSGID(USR8184) MSGF(&LIB/&OBJ)
008069000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008070000000
008071000000             ADDMSGD +
008072000000                MSGID(USR8184) +
008073000000                MSGF(&LIB/&OBJ) +
008074000000                MSG( +
008075000000'Cette fonction est inactive. Veuillez contacter votre administrateur.-
008076000000'                                                                     +
008077000000                ) +
008078000000                SEV(0) +
008079000000     /*   No replacement variables defined!                         */ +
008080000000                ALROPT(*NO) +
008081000000                CCSID(65535) +
008082000000                /*  -EOF-  */
008083000000
008084000000     /*-------------------------------------------------------------*/
008085000000     /*   Cmd-ADDMSGD für Message-ID :   USR8185                    */
008086000000     /* Aucun environnement ouvert car aucun späcifiä.              */
008087000000     /*-------------------------------------------------------------*/
008088000000
008089000000             RMVMSGD MSGID(USR8185) MSGF(&LIB/&OBJ)
008090000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008091000000
008092000000             ADDMSGD +
008093000000                MSGID(USR8185) +
008094000000                MSGF(&LIB/&OBJ) +
008095000000                MSG( +
008096000000'Aucun environnement ouvert car aucun späcifiä.'                      +
008097000000                ) +
008098000000                SEV(0) +
008099000000     /*   No replacement variables defined!                         */ +
008100000000                ALROPT(*NO) +
008101000000                CCSID(65535) +
008102000000                /*  -EOF-  */
008103000000
008104000000     /*-------------------------------------------------------------*/
008105000000     /*   Cmd-ADDMSGD für Message-ID :   USR8186                    */
008106000000     /* Attention : chaîne trop courte.                             */
008107000000     /*-------------------------------------------------------------*/
008108000000
008109000000             RMVMSGD MSGID(USR8186) MSGF(&LIB/&OBJ)
008110000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008111000000
008112000000             ADDMSGD +
008113000000                MSGID(USR8186) +
008114000000                MSGF(&LIB/&OBJ) +
008115000000                MSG( +
008116000000'Attention : chaîne trop courte.'                                     +
008117000000                ) +
008118000000                SEV(0) +
008119000000     /*   No replacement variables defined!                         */ +
008120000000                ALROPT(*NO) +
008121000000                CCSID(65535) +
008122000000                /*  -EOF-  */
008123000000
008124000000     /*-------------------------------------------------------------*/
008125000000     /*   Cmd-ADDMSGD für Message-ID :   USR8187                    */
008126000000     /* La longueur du champ däpasse la taille du tampon d'E/S      */
008127000000     /*-------------------------------------------------------------*/
008128000000
008129000000             RMVMSGD MSGID(USR8187) MSGF(&LIB/&OBJ)
008130000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008131000000
008132000000             ADDMSGD +
008133000000                MSGID(USR8187) +
008134000000                MSGF(&LIB/&OBJ) +
008135000000                MSG( +
008136000000'La longueur du champ däpasse la taille du tampon d''E/S'             +
008137000000                ) +
008138000000                SEV(0) +
008139000000     /*   No replacement variables defined!                         */ +
008140000000                ALROPT(*NO) +
008141000000                CCSID(65535) +
008142000000                /*  -EOF-  */
008143000000
008144000000     /*-------------------------------------------------------------*/
008145000000     /*   Cmd-ADDMSGD für Message-ID :   USR8188                    */
008146000000     /* Cräation fichier äcran. Etape: &1, Champ: &2                */
008147000000     /*-------------------------------------------------------------*/
008148000000
008149000000             RMVMSGD MSGID(USR8188) MSGF(&LIB/&OBJ)
008150000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008151000000
008152000000             ADDMSGD +
008153000000                MSGID(USR8188) +
008154000000                MSGF(&LIB/&OBJ) +
008155000000                MSG( +
008156000000'Cräation fichier äcran. Etape: &1, Champ: &2'                        +
008157000000                ) +
008158000000                SEV(0) +
008159000000                FMT( +
008160000000                    (*DEC 5 0) +
008161000000                    (*CHAR 10) +
008162000000                ) +
008163000000                ALROPT(*NO) +
008164000000                CCSID(65535) +
008165000000                /*  -EOF-  */
008166000000
008167000000     /*-------------------------------------------------------------*/
008168000000     /*   Cmd-ADDMSGD für Message-ID :   USR8189                    */
008169000000     /* Cräation programme RPG. Etape: &1, Champ: &2                */
008170000000     /*-------------------------------------------------------------*/
008171000000
008172000000             RMVMSGD MSGID(USR8189) MSGF(&LIB/&OBJ)
008173000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008174000000
008175000000             ADDMSGD +
008176000000                MSGID(USR8189) +
008177000000                MSGF(&LIB/&OBJ) +
008178000000                MSG( +
008179000000'Cräation programme RPG. Etape: &1, Champ: &2'                        +
008180000000                ) +
008181000000                SEV(0) +
008182000000                FMT( +
008183000000                    (*DEC 5 0) +
008184000000                    (*CHAR 10) +
008185000000                ) +
008186000000                ALROPT(*NO) +
008187000000                CCSID(65535) +
008188000000                /*  -EOF-  */
008189000000
008190000000     /*-------------------------------------------------------------*/
008191000000     /*   Cmd-ADDMSGD für Message-ID :   USR8190                    */
008192000000     /* Räponse &1 § la requête.                                    */
008193000000     /*-------------------------------------------------------------*/
008194000000
008195000000             RMVMSGD MSGID(USR8190) MSGF(&LIB/&OBJ)
008196000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008197000000
008198000000             ADDMSGD +
008199000000                MSGID(USR8190) +
008200000000                MSGF(&LIB/&OBJ) +
008201000000                MSG( +
008202000000'Räponse &1 § la requête.'                                            +
008203000000                ) +
008204000000                SEV(0) +
008205000000                FMT( +
008206000000                    (*CHAR 10) +
008207000000                ) +
008208000000                ALROPT(*NO) +
008209000000                CCSID(65535) +
008210000000                /*  -EOF-  */
008211000000
008212000000     /*-------------------------------------------------------------*/
008213000000     /*   Cmd-ADDMSGD für Message-ID :   USR8191                    */
008214000000     /* Ce champ ne peut contenir la valeur NULL.                   */
008215000000     /*-------------------------------------------------------------*/
008216000000
008217000000             RMVMSGD MSGID(USR8191) MSGF(&LIB/&OBJ)
008218000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008219000000
008220000000             ADDMSGD +
008221000000                MSGID(USR8191) +
008222000000                MSGF(&LIB/&OBJ) +
008223000000                MSG( +
008224000000'Ce champ ne peut contenir la valeur NULL.'                           +
008225000000                ) +
008226000000                SEV(0) +
008227000000                FMT( +
008228000000                    (*CHAR 10) +
008229000000                ) +
008230000000                ALROPT(*NO) +
008231000000                CCSID(65535) +
008232000000                /*  -EOF-  */
008233000000
008234000000     /*-------------------------------------------------------------*/
008235000000     /*   Cmd-ADDMSGD für Message-ID :   USR8192                    */
008236000000     /* Le champ &1 contient des donnäes flottantes incorrectes     */
008237000000     /*-------------------------------------------------------------*/
008238000000
008239000000             RMVMSGD MSGID(USR8192) MSGF(&LIB/&OBJ)
008240000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008241000000
008242000000             ADDMSGD +
008243000000                MSGID(USR8192) +
008244000000                MSGF(&LIB/&OBJ) +
008245000000                MSG( +
008246000000'Le champ &1 contient des donnäes flottantes incorrectes'             +
008247000000                ) +
008248000000                SEV(0) +
008249000000                FMT( +
008250000000                    (*CHAR 10) +
008251000000                ) +
008252000000                ALROPT(*NO) +
008253000000                CCSID(65535) +
008254000000                /*  -EOF-  */
008255000000
008256000000     /*-------------------------------------------------------------*/
008257000000     /*   Cmd-ADDMSGD für Message-ID :   USR8193                    */
008258000000     /* Le champ '&1' contient des caractüres ne pouvant être trait */
008259000000     /*-------------------------------------------------------------*/
008260000000
008261000000             RMVMSGD MSGID(USR8193) MSGF(&LIB/&OBJ)
008262000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008263000000
008264000000             ADDMSGD +
008265000000                MSGID(USR8193) +
008266000000                MSGF(&LIB/&OBJ) +
008267000000                MSG( +
008268000000'Le champ ''&1'' contient des caractüres ne pouvant être traitäs dans -
008269000000l''äditeur'                                                           +
008270000000                ) +
008271000000                SEV(0) +
008272000000                FMT( +
008273000000                    (*CHAR 10) +
008274000000                ) +
008275000000                ALROPT(*NO) +
008276000000                CCSID(65535) +
008277000000                /*  -EOF-  */
008278000000
008279000000     /*-------------------------------------------------------------*/
008280000000     /*   Cmd-ADDMSGD für Message-ID :   USR8194                    */
008281000000     /* Fichier '&1' introuvable                                    */
008282000000     /*-------------------------------------------------------------*/
008283000000
008284000000             RMVMSGD MSGID(USR8194) MSGF(&LIB/&OBJ)
008285000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008286000000
008287000000             ADDMSGD +
008288000000                MSGID(USR8194) +
008289000000                MSGF(&LIB/&OBJ) +
008290000000                MSG( +
008291000000'Fichier ''&1'' introuvable'                                          +
008292000000                ) +
008293000000                SEV(0) +
008294000000                FMT( +
008295000000                    (*CHAR 10) +
008296000000                ) +
008297000000                ALROPT(*NO) +
008298000000                CCSID(65535) +
008299000000                /*  -EOF-  */
008300000000
008301000000     /*-------------------------------------------------------------*/
008302000000     /*   Cmd-ADDMSGD für Message-ID :   USR8195                    */
008303000000     /* Requête illägale car ce champ est protägä                   */
008304000000     /*-------------------------------------------------------------*/
008305000000
008306000000             RMVMSGD MSGID(USR8195) MSGF(&LIB/&OBJ)
008307000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008308000000
008309000000             ADDMSGD +
008310000000                MSGID(USR8195) +
008311000000                MSGF(&LIB/&OBJ) +
008312000000                MSG( +
008313000000'Requête illägale car ce champ est protägä'                           +
008314000000                ) +
008315000000                SEV(0) +
008316000000     /*   No replacement variables defined!                         */ +
008317000000                ALROPT(*NO) +
008318000000                CCSID(65535) +
008319000000                /*  -EOF-  */
008320000000
008321000000     /*-------------------------------------------------------------*/
008322000000     /*   Cmd-ADDMSGD für Message-ID :   USR8196                    */
008323000000     /* Field &1 cannot be displayed or changed.                    */
008324000000     /*-------------------------------------------------------------*/
008325000000
008326000000             RMVMSGD MSGID(USR8196) MSGF(&LIB/&OBJ)
008327000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008328000000
008329000000             ADDMSGD +
008330000000                MSGID(USR8196) +
008331000000                MSGF(&LIB/&OBJ) +
008332000000                MSG( +
008333000000'Field &1 cannot be displayed or changed.'                            +
008334000000                ) +
008335000000                SECLVL( +
008336000000'&N &N Possible Causes: &N &B 1. Unknown data type. &B 2. Graphic fiel-
008337000000d without CCSID. &B 3. Packed or zoned field with more than 30 digits.-
008338000000 &B 4. Unknown variable length field.'                                +
008339000000                ) +
008340000000                SEV(0) +
008341000000                FMT( +
008342000000                    (*CHAR 10) +
008343000000                ) +
008344000000                ALROPT(*NO) +
008345000000                CCSID(65535) +
008346000000                /*  -EOF-  */
008347000000
008348000000     /*-------------------------------------------------------------*/
008349000000     /*   Cmd-ADDMSGD für Message-ID :   USR8200                    */
008350000000     /* Suppression enregistrement &1 impossible                    */
008351000000     /*-------------------------------------------------------------*/
008352000000
008353000000             RMVMSGD MSGID(USR8200) MSGF(&LIB/&OBJ)
008354000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008355000000
008356000000             ADDMSGD +
008357000000                MSGID(USR8200) +
008358000000                MSGF(&LIB/&OBJ) +
008359000000                MSG( +
008360000000'Suppression enregistrement &1 impossible'                            +
008361000000                ) +
008362000000                SEV(0) +
008363000000                FMT( +
008364000000                    (*DEC 10 0) +
008365000000                ) +
008366000000                ALROPT(*NO) +
008367000000                CCSID(65535) +
008368000000                /*  -EOF-  */
008369000000
008370000000     /*-------------------------------------------------------------*/
008371000000     /*   Cmd-ADDMSGD für Message-ID :   USR8201                    */
008372000000     /* Enregistrement &1 supprimä                                  */
008373000000     /*-------------------------------------------------------------*/
008374000000
008375000000             RMVMSGD MSGID(USR8201) MSGF(&LIB/&OBJ)
008376000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008377000000
008378000000             ADDMSGD +
008379000000                MSGID(USR8201) +
008380000000                MSGF(&LIB/&OBJ) +
008381000000                MSG( +
008382000000'Enregistrement &1 supprimä'                                          +
008383000000                ) +
008384000000                SEV(0) +
008385000000                FMT( +
008386000000                    (*DEC 10 0) +
008387000000                ) +
008388000000                ALROPT(*NO) +
008389000000                CCSID(65535) +
008390000000                /*  -EOF-  */
008391000000
008392000000     /*-------------------------------------------------------------*/
008393000000     /*   Cmd-ADDMSGD für Message-ID :   USR8202                    */
008394000000     /* Copie enregistrement &1 impossible                          */
008395000000     /*-------------------------------------------------------------*/
008396000000
008397000000             RMVMSGD MSGID(USR8202) MSGF(&LIB/&OBJ)
008398000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008399000000
008400000000             ADDMSGD +
008401000000                MSGID(USR8202) +
008402000000                MSGF(&LIB/&OBJ) +
008403000000                MSG( +
008404000000'Copie enregistrement &1 impossible'                                  +
008405000000                ) +
008406000000                SEV(0) +
008407000000                FMT( +
008408000000                    (*DEC 10 0) +
008409000000                ) +
008410000000                ALROPT(*NO) +
008411000000                CCSID(65535) +
008412000000                /*  -EOF-  */
008413000000
008414000000     /*-------------------------------------------------------------*/
008415000000     /*   Cmd-ADDMSGD für Message-ID :   USR8203                    */
008416000000     /* Enregistrement &1 copiä                                     */
008417000000     /*-------------------------------------------------------------*/
008418000000
008419000000             RMVMSGD MSGID(USR8203) MSGF(&LIB/&OBJ)
008420000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008421000000
008422000000             ADDMSGD +
008423000000                MSGID(USR8203) +
008424000000                MSGF(&LIB/&OBJ) +
008425000000                MSG( +
008426000000'Enregistrement &1 copiä'                                             +
008427000000                ) +
008428000000                SEV(0) +
008429000000                FMT( +
008430000000                    (*DEC 10 0) +
008431000000                ) +
008432000000                ALROPT(*NO) +
008433000000                CCSID(65535) +
008434000000                /*  -EOF-  */
008435000000
008436000000     /*-------------------------------------------------------------*/
008437000000     /*   Cmd-ADDMSGD für Message-ID :   USR8204                    */
008438000000     /* Enreg. de sous fichier invalide                             */
008439000000     /*-------------------------------------------------------------*/
008440000000
008441000000             RMVMSGD MSGID(USR8204) MSGF(&LIB/&OBJ)
008442000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008443000000
008444000000             ADDMSGD +
008445000000                MSGID(USR8204) +
008446000000                MSGF(&LIB/&OBJ) +
008447000000                MSG( +
008448000000'Enreg. de sous fichier invalide'                                     +
008449000000                ) +
008450000000                SECLVL( +
008451000000'&N &N Pointez sur l''enregistrement däsirä et räpätez votre requête.'+
008452000000                ) +
008453000000                SEV(0) +
008454000000     /*   No replacement variables defined!                         */ +
008455000000                ALROPT(*NO) +
008456000000                CCSID(65535) +
008457000000                /*  -EOF-  */
008458000000
008459000000     /*-------------------------------------------------------------*/
008460000000     /*   Cmd-ADDMSGD für Message-ID :   USR8205                    */
008461000000     /* Attention: Impossible de fixer plus de &1 colonnes!         */
008462000000     /*-------------------------------------------------------------*/
008463000000
008464000000             RMVMSGD MSGID(USR8205) MSGF(&LIB/&OBJ)
008465000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008466000000
008467000000             ADDMSGD +
008468000000                MSGID(USR8205) +
008469000000                MSGF(&LIB/&OBJ) +
008470000000                MSG( +
008471000000'Attention: Impossible de fixer plus de &1 colonnes!'                 +
008472000000                ) +
008473000000                SEV(0) +
008474000000                FMT( +
008475000000                    (*DEC 5 0) +
008476000000                ) +
008477000000                ALROPT(*NO) +
008478000000                CCSID(65535) +
008479000000                /*  -EOF-  */
008480000000
008481000000     /*-------------------------------------------------------------*/
008482000000     /*   Cmd-ADDMSGD für Message-ID :   USR8206                    */
008483000000     /* Enregistrement non affichable. La taille däpasse le maximum */
008484000000     /*-------------------------------------------------------------*/
008485000000
008486000000             RMVMSGD MSGID(USR8206) MSGF(&LIB/&OBJ)
008487000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008488000000
008489000000             ADDMSGD +
008490000000                MSGID(USR8206) +
008491000000                MSGF(&LIB/&OBJ) +
008492000000                MSG( +
008493000000'Enregistrement non affichable. La taille däpasse le maximum de &1 oct-
008494000000ets.'                                                                 +
008495000000                ) +
008496000000                SEV(0) +
008497000000                FMT( +
008498000000                    (*DEC 5 0) +
008499000000                ) +
008500000000                ALROPT(*NO) +
008501000000                CCSID(65535) +
008502000000                /*  -EOF-  */
008503000000
008504000000     /*-------------------------------------------------------------*/
008505000000     /*   Cmd-ADDMSGD für Message-ID :   USR8207                    */
008506000000     /* Le fichier ne peut être ouvert, la longueur de l'enregistre */
008507000000     /*-------------------------------------------------------------*/
008508000000
008509000000             RMVMSGD MSGID(USR8207) MSGF(&LIB/&OBJ)
008510000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008511000000
008512000000             ADDMSGD +
008513000000                MSGID(USR8207) +
008514000000                MSGF(&LIB/&OBJ) +
008515000000                MSG( +
008516000000'Le fichier ne peut être ouvert, la longueur de l''enregistrement däpa-
008517000000ssant &1 octets.'                                                     +
008518000000                ) +
008519000000                SEV(0) +
008520000000                FMT( +
008521000000                    (*DEC 5 0) +
008522000000                ) +
008523000000                ALROPT(*NO) +
008524000000                CCSID(65535) +
008525000000                /*  -EOF-  */
008526000000
008527000000     /*-------------------------------------------------------------*/
008528000000     /*   Cmd-ADDMSGD für Message-ID :   USR8208                    */
008529000000     /* Vous n'êtes pas autorisä § modifier des fichiers en lecture */
008530000000     /*-------------------------------------------------------------*/
008531000000
008532000000             RMVMSGD MSGID(USR8208) MSGF(&LIB/&OBJ)
008533000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008534000000
008535000000             ADDMSGD +
008536000000                MSGID(USR8208) +
008537000000                MSGF(&LIB/&OBJ) +
008538000000                MSG( +
008539000000'Vous n''êtes pas autorisä § modifier des fichiers en lecture seule.' +
008540000000                ) +
008541000000                SEV(0) +
008542000000     /*   No replacement variables defined!                         */ +
008543000000                ALROPT(*NO) +
008544000000                CCSID(65535) +
008545000000                /*  -EOF-  */
008546000000
008547000000     /*-------------------------------------------------------------*/
008548000000     /*   Cmd-ADDMSGD für Message-ID :   USR8209                    */
008549000000     /* Veuillez entrer un argument de recherche.                   */
008550000000     /*-------------------------------------------------------------*/
008551000000
008552000000             RMVMSGD MSGID(USR8209) MSGF(&LIB/&OBJ)
008553000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008554000000
008555000000             ADDMSGD +
008556000000                MSGID(USR8209) +
008557000000                MSGF(&LIB/&OBJ) +
008558000000                MSG( +
008559000000'Veuillez entrer un argument de recherche.'                           +
008560000000                ) +
008561000000                SEV(0) +
008562000000     /*   No replacement variables defined!                         */ +
008563000000                ALROPT(*NO) +
008564000000                CCSID(65535) +
008565000000                /*  -EOF-  */
008566000000
008567000000     /*-------------------------------------------------------------*/
008568000000     /*   Cmd-ADDMSGD für Message-ID :   USR8210                    */
008569000000     /* Erreur SQL &1. &2                                           */
008570000000     /*-------------------------------------------------------------*/
008571000000
008572000000             RMVMSGD MSGID(USR8210) MSGF(&LIB/&OBJ)
008573000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008574000000
008575000000             ADDMSGD +
008576000000                MSGID(USR8210) +
008577000000                MSGF(&LIB/&OBJ) +
008578000000                MSG( +
008579000000'Erreur SQL &1. &2'                                                   +
008580000000                ) +
008581000000                SECLVL( +
008582000000'''&N &N Cause  . . . . :   &2 &N &B Vous trouverez plus d''informatio-
008583000000n sur ce code erreur dans le manuel de programmation SQL ou dans le fi-
008584000000chier de messages QSYS/QSQLMSG.'''                                    +
008585000000                ) +
008586000000                SEV(0) +
008587000000                FMT( +
008588000000                    (*CHAR 7) +
008589000000                    (*CHAR 512) +
008590000000                ) +
008591000000                ALROPT(*NO) +
008592000000                CCSID(65535) +
008593000000                /*  -EOF-  */
008594000000
008595000000     /*-------------------------------------------------------------*/
008596000000     /*   Cmd-ADDMSGD für Message-ID :   USR8211                    */
008597000000     /* Veuillez placer le curseur dans un champ et relancer votre  */
008598000000     /*-------------------------------------------------------------*/
008599000000
008600000000             RMVMSGD MSGID(USR8211) MSGF(&LIB/&OBJ)
008601000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008602000000
008603000000             ADDMSGD +
008604000000                MSGID(USR8211) +
008605000000                MSGF(&LIB/&OBJ) +
008606000000                MSG( +
008607000000'Veuillez placer le curseur dans un champ et relancer votre requête.' +
008608000000                ) +
008609000000                SECLVL( +
008610000000'Cause  . . . . :   Le curseur se trouve hors d''un champ ou le champ -
008611000000n''est pas valide pour la requête.'                                   +
008612000000                ) +
008613000000                SEV(0) +
008614000000     /*   No replacement variables defined!                         */ +
008615000000                ALROPT(*NO) +
008616000000                CCSID(65535) +
008617000000                /*  -EOF-  */
008618000000
008619000000     /*-------------------------------------------------------------*/
008620000000     /*   Cmd-ADDMSGD für Message-ID :   USR8212                    */
008621000000     /* Une sälection SQL ne peut s'appliquer qu'aux fichiers physi */
008622000000     /*-------------------------------------------------------------*/
008623000000
008624000000             RMVMSGD MSGID(USR8212) MSGF(&LIB/&OBJ)
008625000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008626000000
008627000000             ADDMSGD +
008628000000                MSGID(USR8212) +
008629000000                MSGF(&LIB/&OBJ) +
008630000000                MSG( +
008631000000'Une sälection SQL ne peut s''appliquer qu''aux fichiers physiques. Ou-
008632000000vrir le fichier physique ?'''                                         +
008633000000                ) +
008634000000                SEV(0) +
008635000000     /*   No replacement variables defined!                         */ +
008636000000                ALROPT(*NO) +
008637000000                CCSID(65535) +
008638000000                /*  -EOF-  */
008639000000
008640000000     /*-------------------------------------------------------------*/
008641000000     /*   Cmd-ADDMSGD für Message-ID :   USR8213                    */
008642000000     /* 1=Sauvegarder; 0=Ne pas sauvegarder                         */
008643000000     /*-------------------------------------------------------------*/
008644000000
008645000000             RMVMSGD MSGID(USR8213) MSGF(&LIB/&OBJ)
008646000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008647000000
008648000000             ADDMSGD +
008649000000                MSGID(USR8213) +
008650000000                MSGF(&LIB/&OBJ) +
008651000000                MSG( +
008652000000'1=Sauvegarder; 0=Ne pas sauvegarder'                                 +
008653000000                ) +
008654000000                SEV(0) +
008655000000     /*   No replacement variables defined!                         */ +
008656000000                ALROPT(*NO) +
008657000000                CCSID(65535) +
008658000000                /*  -EOF-  */
008659000000
008660000000     /*-------------------------------------------------------------*/
008661000000     /*   Cmd-ADDMSGD für Message-ID :   USR8214                    */
008662000000     /* 1=Admettre minuscules 0=Majuscules seulement                */
008663000000     /*-------------------------------------------------------------*/
008664000000
008665000000             RMVMSGD MSGID(USR8214) MSGF(&LIB/&OBJ)
008666000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008667000000
008668000000             ADDMSGD +
008669000000                MSGID(USR8214) +
008670000000                MSGF(&LIB/&OBJ) +
008671000000                MSG( +
008672000000'1=Admettre minuscules 0=Majuscules seulement'                        +
008673000000                ) +
008674000000                SEV(0) +
008675000000     /*   No replacement variables defined!                         */ +
008676000000                ALROPT(*NO) +
008677000000                CCSID(65535) +
008678000000                /*  -EOF-  */
008679000000
008680000000     /*-------------------------------------------------------------*/
008681000000     /*   Cmd-ADDMSGD für Message-ID :   USR8215                    */
008682000000     /* Minuscule interdite                                         */
008683000000     /*-------------------------------------------------------------*/
008684000000
008685000000             RMVMSGD MSGID(USR8215) MSGF(&LIB/&OBJ)
008686000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008687000000
008688000000             ADDMSGD +
008689000000                MSGID(USR8215) +
008690000000                MSGF(&LIB/&OBJ) +
008691000000                MSG( +
008692000000'Minuscule interdite'                                                 +
008693000000                ) +
008694000000                SEV(0) +
008695000000     /*   No replacement variables defined!                         */ +
008696000000                ALROPT(*NO) +
008697000000                CCSID(65535) +
008698000000                /*  -EOF-  */
008699000000
008700000000     /*-------------------------------------------------------------*/
008701000000     /*   Cmd-ADDMSGD für Message-ID :   USR8216                    */
008702000000     /* Ces valeurs sont incompatibles.                             */
008703000000     /*-------------------------------------------------------------*/
008704000000
008705000000             RMVMSGD MSGID(USR8216) MSGF(&LIB/&OBJ)
008706000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008707000000
008708000000             ADDMSGD +
008709000000                MSGID(USR8216) +
008710000000                MSGF(&LIB/&OBJ) +
008711000000                MSG( +
008712000000'Ces valeurs sont incompatibles.'                                     +
008713000000                ) +
008714000000                SECLVL( +
008715000000'Si vous voulez interdire § l''utilisateur de saisir des minuscules, v-
008716000000ous ne pouvez prendre cette valeur comme däfaut.'''                   +
008717000000                ) +
008718000000                SEV(0) +
008719000000     /*   No replacement variables defined!                         */ +
008720000000                ALROPT(*NO) +
008721000000                CCSID(65535) +
008722000000                /*  -EOF-  */
008723000000
008724000000     /*-------------------------------------------------------------*/
008725000000     /*   Cmd-ADDMSGD für Message-ID :   USR8217                    */
008726000000     /* Trier sur le nÄ d'enregistement relatif est impossible.     */
008727000000     /*-------------------------------------------------------------*/
008728000000
008729000000             RMVMSGD MSGID(USR8217) MSGF(&LIB/&OBJ)
008730000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008731000000
008732000000             ADDMSGD +
008733000000                MSGID(USR8217) +
008734000000                MSGF(&LIB/&OBJ) +
008735000000                MSG( +
008736000000'Trier sur le nÄ d''enregistement relatif est impossible.'            +
008737000000                ) +
008738000000                SECLVL( +
008739000000'Il est impossible d''ouvrir ce fichier triä sur le nÄ relatif car il -
008740000000est basä sur plus d''un membre.'                                      +
008741000000                ) +
008742000000                SEV(0) +
008743000000     /*   No replacement variables defined!                         */ +
008744000000                ALROPT(*NO) +
008745000000                CCSID(65535) +
008746000000                /*  -EOF-  */
008747000000
008748000000     /*-------------------------------------------------------------*/
008749000000     /*   Cmd-ADDMSGD für Message-ID :   USR8218                    */
008750000000     /* L'enregistement ne peut être fixä. La vue se base sur de mu */
008751000000     /*-------------------------------------------------------------*/
008752000000
008753000000             RMVMSGD MSGID(USR8218) MSGF(&LIB/&OBJ)
008754000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008755000000
008756000000             ADDMSGD +
008757000000                MSGID(USR8218) +
008758000000                MSGF(&LIB/&OBJ) +
008759000000                MSG( +
008760000000'L''enregistement ne peut être fixä. La vue se base sur de multiples m-
008761000000embres physiques.'                                                    +
008762000000                ) +
008763000000                SECLVL( +
008764000000'&N &N Cause . . . . . :  L''enregistrement ne peut être fixä. Le nÄ d-
008765000000''enregistrement n''est pas unique et il est impossible de däterminer -
008766000000le membre physique qui le contient.'                                  +
008767000000                ) +
008768000000                SEV(0) +
008769000000     /*   No replacement variables defined!                         */ +
008770000000                ALROPT(*NO) +
008771000000                CCSID(65535) +
008772000000                /*  -EOF-  */
008773000000
008774000000     /*-------------------------------------------------------------*/
008775000000     /*   Cmd-ADDMSGD für Message-ID :   USR8219                    */
008776000000     /* Valeur '&1' incorrecte pour un choix Oui/Non                */
008777000000     /*-------------------------------------------------------------*/
008778000000
008779000000             RMVMSGD MSGID(USR8219) MSGF(&LIB/&OBJ)
008780000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008781000000
008782000000             ADDMSGD +
008783000000                MSGID(USR8219) +
008784000000                MSGF(&LIB/&OBJ) +
008785000000                MSG( +
008786000000'Valeur ''&1'' incorrecte pour un choix Oui/Non'                      +
008787000000                ) +
008788000000                SEV(0) +
008789000000                FMT( +
008790000000                    (*CHAR 10) +
008791000000                ) +
008792000000                ALROPT(*NO) +
008793000000                CCSID(65535) +
008794000000                /*  -EOF-  */
008795000000
008796000000     /*-------------------------------------------------------------*/
008797000000     /*   Cmd-ADDMSGD für Message-ID :   USR8220                    */
008798000000     /* Edition interdite. Le champ &1 contient NULL.               */
008799000000     /*-------------------------------------------------------------*/
008800000000
008801000000             RMVMSGD MSGID(USR8220) MSGF(&LIB/&OBJ)
008802000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008803000000
008804000000             ADDMSGD +
008805000000                MSGID(USR8220) +
008806000000                MSGF(&LIB/&OBJ) +
008807000000                MSG( +
008808000000'Edition interdite. Le champ &1 contient NULL.'                       +
008809000000                ) +
008810000000                SEV(0) +
008811000000                FMT( +
008812000000                    (*CHAR 10) +
008813000000                ) +
008814000000                ALROPT(*NO) +
008815000000                CCSID(65535) +
008816000000                /*  -EOF-  */
008817000000
008818000000     /*-------------------------------------------------------------*/
008819000000     /*   Cmd-ADDMSGD für Message-ID :   USR8221                    */
008820000000     /* L'äditeur ne supporte pas le type de donnäe de ce champ.    */
008821000000     /*-------------------------------------------------------------*/
008822000000
008823000000             RMVMSGD MSGID(USR8221) MSGF(&LIB/&OBJ)
008824000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008825000000
008826000000             ADDMSGD +
008827000000                MSGID(USR8221) +
008828000000                MSGF(&LIB/&OBJ) +
008829000000                MSG( +
008830000000'L''äditeur ne supporte pas le type de donnäe de ce champ.'           +
008831000000                ) +
008832000000                SEV(0) +
008833000000                FMT( +
008834000000                    (*CHAR 10) +
008835000000                ) +
008836000000                ALROPT(*NO) +
008837000000                CCSID(65535) +
008838000000                /*  -EOF-  */
008839000000
008840000000     /*-------------------------------------------------------------*/
008841000000     /*   Cmd-ADDMSGD für Message-ID :   USR8222                    */
008842000000     /* Le champ &1 däpasse la taille maximum allouäe § l'äditeur   */
008843000000     /*-------------------------------------------------------------*/
008844000000
008845000000             RMVMSGD MSGID(USR8222) MSGF(&LIB/&OBJ)
008846000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008847000000
008848000000             ADDMSGD +
008849000000                MSGID(USR8222) +
008850000000                MSGF(&LIB/&OBJ) +
008851000000                MSG( +
008852000000'Le champ &1 däpasse la taille maximum allouäe § l''äditeur'          +
008853000000                ) +
008854000000                SEV(0) +
008855000000                FMT( +
008856000000                    (*CHAR 10) +
008857000000                ) +
008858000000                ALROPT(*NO) +
008859000000                CCSID(65535) +
008860000000                /*  -EOF-  */
008861000000
008862000000     /*-------------------------------------------------------------*/
008863000000     /*   Cmd-ADDMSGD für Message-ID :   USR8223                    */
008864000000     /* Saisie basculäe en mode minuscule                           */
008865000000     /*-------------------------------------------------------------*/
008866000000
008867000000             RMVMSGD MSGID(USR8223) MSGF(&LIB/&OBJ)
008868000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008869000000
008870000000             ADDMSGD +
008871000000                MSGID(USR8223) +
008872000000                MSGF(&LIB/&OBJ) +
008873000000                MSG( +
008874000000'Saisie basculäe en mode minuscule'                                   +
008875000000                ) +
008876000000                SEV(0) +
008877000000     /*   No replacement variables defined!                         */ +
008878000000                ALROPT(*NO) +
008879000000                CCSID(65535) +
008880000000                /*  -EOF-  */
008881000000
008882000000     /*-------------------------------------------------------------*/
008883000000     /*   Cmd-ADDMSGD für Message-ID :   USR8224                    */
008884000000     /* Saisie basculäe en mode majuscule                           */
008885000000     /*-------------------------------------------------------------*/
008886000000
008887000000             RMVMSGD MSGID(USR8224) MSGF(&LIB/&OBJ)
008888000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008889000000
008890000000             ADDMSGD +
008891000000                MSGID(USR8224) +
008892000000                MSGF(&LIB/&OBJ) +
008893000000                MSG( +
008894000000'Saisie basculäe en mode majuscule'                                   +
008895000000                ) +
008896000000                SEV(0) +
008897000000     /*   No replacement variables defined!                         */ +
008898000000                ALROPT(*NO) +
008899000000                CCSID(65535) +
008900000000                /*  -EOF-  */
008901000000
008902000000     /*-------------------------------------------------------------*/
008903000000     /*   Cmd-ADDMSGD für Message-ID :   USR8225                    */
008904000000     /* L'enregistrement a ätä modifiä par un autre utilisateur.°°M */
008905000000     /*-------------------------------------------------------------*/
008906000000
008907000000             RMVMSGD MSGID(USR8225) MSGF(&LIB/&OBJ)
008908000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008909000000
008910000000             ADDMSGD +
008911000000                MSGID(USR8225) +
008912000000                MSGF(&LIB/&OBJ) +
008913000000                MSG( +
008914000000'L''enregistrement a ätä modifiä par un autre utilisateur.°°Modifier t-
008915000000out de même ?'                                                        +
008916000000                ) +
008917000000                SEV(0) +
008918000000     /*   No replacement variables defined!                         */ +
008919000000                ALROPT(*NO) +
008920000000                CCSID(65535) +
008921000000                /*  -EOF-  */
008922000000
008923000000     /*-------------------------------------------------------------*/
008924000000     /*   Cmd-ADDMSGD für Message-ID :   USR8226                    */
008925000000     /* Impression effectuäe                                        */
008926000000     /*-------------------------------------------------------------*/
008927000000
008928000000             RMVMSGD MSGID(USR8226) MSGF(&LIB/&OBJ)
008929000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008930000000
008931000000             ADDMSGD +
008932000000                MSGID(USR8226) +
008933000000                MSGF(&LIB/&OBJ) +
008934000000                MSG( +
008935000000'Impression effectuäe'                                                +
008936000000                ) +
008937000000                SEV(0) +
008938000000     /*   No replacement variables defined!                         */ +
008939000000                ALROPT(*NO) +
008940000000                CCSID(65535) +
008941000000                /*  -EOF-  */
008942000000
008943000000     /*-------------------------------------------------------------*/
008944000000     /*   Cmd-ADDMSGD für Message-ID :   USR8227                    */
008945000000     /* Echec de conversion '&1' en numärique                       */
008946000000     /*-------------------------------------------------------------*/
008947000000
008948000000             RMVMSGD MSGID(USR8227) MSGF(&LIB/&OBJ)
008949000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008950000000
008951000000             ADDMSGD +
008952000000                MSGID(USR8227) +
008953000000                MSGF(&LIB/&OBJ) +
008954000000                MSG( +
008955000000'Echec de conversion ''&1'' en numärique'                             +
008956000000                ) +
008957000000                SECLVL( +
008958000000'&N &N Information . . :   Erreur lors de laconversion ''&1'' en numär-
008959000000ique. La chaîne n''a pas pu être convertie en numärique &2(&3,&4).'   +
008960000000                ) +
008961000000                SEV(0) +
008962000000                FMT( +
008963000000                    (*CHAR 256) +
008964000000                    (*CHAR 1) +
008965000000                    (*DEC 5 0) +
008966000000                    (*DEC 5 0) +
008967000000                ) +
008968000000                ALROPT(*NO) +
008969000000                CCSID(65535) +
008970000000                /*  -EOF-  */
008971000000
008972000000     /*-------------------------------------------------------------*/
008973000000     /*   Cmd-ADDMSGD für Message-ID :   USR8228                    */
008974000000     /* Type de donnäe incorrect '&1'.                              */
008975000000     /*-------------------------------------------------------------*/
008976000000
008977000000             RMVMSGD MSGID(USR8228) MSGF(&LIB/&OBJ)
008978000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008979000000
008980000000             ADDMSGD +
008981000000                MSGID(USR8228) +
008982000000                MSGF(&LIB/&OBJ) +
008983000000                MSG( +
008984000000'Type de donnäe incorrect ''&1''.'                                    +
008985000000                ) +
008986000000                SECLVL( +
008987000000'&N &N Information . . :   Le type de donnäe späcifiä  ''&1'' est inco-
008988000000rrect.. Veuillez späcifier un type de donnäe RPG valide et relancer vo-
008989000000tre requête.'                                                         +
008990000000                ) +
008991000000                SEV(0) +
008992000000                FMT( +
008993000000                    (*CHAR 256) +
008994000000                ) +
008995000000                ALROPT(*NO) +
008996000000                CCSID(65535) +
008997000000                /*  -EOF-  */
008998000000
008999000000     /*-------------------------------------------------------------*/
009000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8229                    */
009001000000     /* Taille du champ invalide: '&1'.                             */
009002000000     /*-------------------------------------------------------------*/
009003000000
009004000000             RMVMSGD MSGID(USR8229) MSGF(&LIB/&OBJ)
009005000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009006000000
009007000000             ADDMSGD +
009008000000                MSGID(USR8229) +
009009000000                MSGF(&LIB/&OBJ) +
009010000000                MSG( +
009011000000'Taille du champ invalide: ''&1''.'                                   +
009012000000                ) +
009013000000                SECLVL( +
009014000000'&N &N Information . . :   La taille du champ ''&1'' est incorrecte. V-
009015000000euillez corriger cette valeur et relancer votre requête'              +
009016000000                ) +
009017000000                SEV(0) +
009018000000                FMT( +
009019000000                    (*CHAR 256) +
009020000000                ) +
009021000000                ALROPT(*NO) +
009022000000                CCSID(65535) +
009023000000                /*  -EOF-  */
009024000000
009025000000     /*-------------------------------------------------------------*/
009026000000     /*   Cmd-ADDMSGD für Message-ID :   USR8230                    */
009027000000     /* Nombre incorrect de positions däcimales: '&1'.              */
009028000000     /*-------------------------------------------------------------*/
009029000000
009030000000             RMVMSGD MSGID(USR8230) MSGF(&LIB/&OBJ)
009031000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009032000000
009033000000             ADDMSGD +
009034000000                MSGID(USR8230) +
009035000000                MSGF(&LIB/&OBJ) +
009036000000                MSG( +
009037000000'Nombre incorrect de positions däcimales: ''&1''.'                    +
009038000000                ) +
009039000000                SECLVL( +
009040000000'&N &N Information . . :   Le nombre de däcimales späcifiäes est incor-
009041000000rect. Veuillez corriger et relancer votre requête. Il est § noter que -
009042000000tous les types de donnäe, comme par exemple ''A'' pour les chaînes, ne-
009043000000 requiürent pas de däcimales.'                                        +
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
009054000000     /*   Cmd-ADDMSGD für Message-ID :   USR8231                    */
009055000000     /* Etat de verrouillage de l'enregistrement non modifiable dur */
009056000000     /*-------------------------------------------------------------*/
009057000000
009058000000             RMVMSGD MSGID(USR8231) MSGF(&LIB/&OBJ)
009059000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009060000000
009061000000             ADDMSGD +
009062000000                MSGID(USR8231) +
009063000000                MSGF(&LIB/&OBJ) +
009064000000                MSG( +
009065000000'Etat de verrouillage de l''enregistrement non modifiable durant la co-
009066000000pie ou l''ajout.'''                                                   +
009067000000                ) +
009068000000                SECLVL( +
009069000000'&N &N Information . . :   le verrouillage de l''enregistrement ne peu-
009070000000t être changä. Seule la modification de l''enregistrement peut le chan-
009071000000ger.'''                                                               +
009072000000                ) +
009073000000                SEV(0) +
009074000000     /*   No replacement variables defined!                         */ +
009075000000                ALROPT(*NO) +
009076000000                CCSID(65535) +
009077000000                /*  -EOF-  */
009078000000
009079000000     /*-------------------------------------------------------------*/
009080000000     /*   Cmd-ADDMSGD für Message-ID :   USR8232                    */
009081000000     /* L'enregistrement a ätä modifiä par un autre utilisateur. °° */
009082000000     /*-------------------------------------------------------------*/
009083000000
009084000000             RMVMSGD MSGID(USR8232) MSGF(&LIB/&OBJ)
009085000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009086000000
009087000000             ADDMSGD +
009088000000                MSGID(USR8232) +
009089000000                MSGF(&LIB/&OBJ) +
009090000000                MSG( +
009091000000'L''enregistrement a ätä modifiä par un autre utilisateur. °°Verrouill-
009092000000er l''enregistrement tout de même ?'                                  +
009093000000                ) +
009094000000                SEV(0) +
009095000000     /*   No replacement variables defined!                         */ +
009096000000                ALROPT(*NO) +
009097000000                CCSID(65535) +
009098000000                /*  -EOF-  */
009099000000
009100000000     /*-------------------------------------------------------------*/
009101000000     /*   Cmd-ADDMSGD für Message-ID :   USR8233                    */
009102000000     /* Erreur: Maquette inutilisable. Niveaux de format diffärents */
009103000000     /*-------------------------------------------------------------*/
009104000000
009105000000             RMVMSGD MSGID(USR8233) MSGF(&LIB/&OBJ)
009106000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009107000000
009108000000             ADDMSGD +
009109000000                MSGID(USR8233) +
009110000000                MSGF(&LIB/&OBJ) +
009111000000                MSG( +
009112000000'Erreur: Maquette inutilisable. Niveaux de format diffärents'         +
009113000000                ) +
009114000000                SECLVL( +
009115000000'&N &N Solution  . . . :   Retirer l''ID niveau du fichier &2/&1, memb-
009116000000re &3 pour däsactiver le contrôle et appliquer § nouveau la maquette. -
009117000000Puis sauvegardez la maquette.'                                        +
009118000000                ) +
009119000000                SEV(0) +
009120000000                FMT( +
009121000000                    (*CHAR 10) +
009122000000                    (*CHAR 10) +
009123000000                    (*CHAR 10) +
009124000000                ) +
009125000000                ALROPT(*NO) +
009126000000                CCSID(65535) +
009127000000                /*  -EOF-  */
009128000000
009129000000     /*-------------------------------------------------------------*/
009130000000     /*   Cmd-ADDMSGD für Message-ID :   USR8234                    */
009131000000     /* Impossible de charger la maquette - les niveaux de format n */
009132000000     /*-------------------------------------------------------------*/
009133000000
009134000000             RMVMSGD MSGID(USR8234) MSGF(&LIB/&OBJ)
009135000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009136000000
009137000000             ADDMSGD +
009138000000                MSGID(USR8234) +
009139000000                MSGF(&LIB/&OBJ) +
009140000000                MSG( +
009141000000'Impossible de charger la maquette - les niveaux de format ne correspo-
009142000000ndent pas.'                                                           +
009143000000                ) +
009144000000                SECLVL( +
009145000000'&N &N Cause . . . . niveaux de format diffärents entre fichier et maq-
009146000000uette. Retirer l''ID niveau du fichier &2/&1, membre &3 pour däsactive-
009147000000r le contrôle et appliquer § nouveau la maquette. Puis sauvegarder la -
009148000000maquette.'                                                            +
009149000000                ) +
009150000000                SEV(0) +
009151000000                FMT( +
009152000000                    (*CHAR 10) +
009153000000                    (*CHAR 10) +
009154000000                    (*CHAR 10) +
009155000000                ) +
009156000000                ALROPT(*NO) +
009157000000                CCSID(65535) +
009158000000                /*  -EOF-  */
009159000000
009160000000     /*-------------------------------------------------------------*/
009161000000     /*   Cmd-ADDMSGD für Message-ID :   USR8235                    */
009162000000     /* SQL-Selection not supported for multi-member logical files. */
009163000000     /*-------------------------------------------------------------*/
009164000000
009165000000             RMVMSGD MSGID(USR8235) MSGF(&LIB/&OBJ)
009166000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009167000000
009168000000             ADDMSGD +
009169000000                MSGID(USR8235) +
009170000000                MSGF(&LIB/&OBJ) +
009171000000                MSG( +
009172000000'SQL-Selection not supported for multi-member logical files.'         +
009173000000                ) +
009174000000                SEV(0) +
009175000000     /*   No replacement variables defined!                         */ +
009176000000                ALROPT(*NO) +
009177000000                CCSID(65535) +
009178000000                /*  -EOF-  */
009179000000
009180000000     /*-------------------------------------------------------------*/
009181000000     /*   Cmd-ADDMSGD für Message-ID :   USR8236                    */
009182000000     /* Mode d'insertion activä.                                    */
009183000000     /*-------------------------------------------------------------*/
009184000000
009185000000             RMVMSGD MSGID(USR8236) MSGF(&LIB/&OBJ)
009186000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009187000000
009188000000             ADDMSGD +
009189000000                MSGID(USR8236) +
009190000000                MSGF(&LIB/&OBJ) +
009191000000                MSG( +
009192000000'Mode d''insertion activä.'                                           +
009193000000                ) +
009194000000                SEV(0) +
009195000000     /*   No replacement variables defined!                         */ +
009196000000                ALROPT(*NO) +
009197000000                CCSID(65535) +
009198000000                /*  -EOF-  */
009199000000
009200000000     /*-------------------------------------------------------------*/
009201000000     /*   Cmd-ADDMSGD für Message-ID :   USR8237                    */
009202000000     /* Appuyer sur la touche "Enträe" pour insärer le nombre d'esp */
009203000000     /*-------------------------------------------------------------*/
009204000000
009205000000             RMVMSGD MSGID(USR8237) MSGF(&LIB/&OBJ)
009206000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009207000000
009208000000             ADDMSGD +
009209000000                MSGID(USR8237) +
009210000000                MSGF(&LIB/&OBJ) +
009211000000                MSG( +
009212000000'Appuyer sur la touche "Enträe" pour insärer le nombre d''espaces indi-
009213000000quä.'                                                                 +
009214000000                ) +
009215000000                SEV(0) +
009216000000     /*   No replacement variables defined!                         */ +
009217000000                ALROPT(*NO) +
009218000000                CCSID(65535) +
009219000000                /*  -EOF-  */
009220000000
009221000000     /*-------------------------------------------------------------*/
009222000000     /*   Cmd-ADDMSGD für Message-ID :   USR8238                    */
009223000000     /* Mode de suppression activä.                                 */
009224000000     /*-------------------------------------------------------------*/
009225000000
009226000000             RMVMSGD MSGID(USR8238) MSGF(&LIB/&OBJ)
009227000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009228000000
009229000000             ADDMSGD +
009230000000                MSGID(USR8238) +
009231000000                MSGF(&LIB/&OBJ) +
009232000000                MSG( +
009233000000'Mode de suppression activä.'                                         +
009234000000                ) +
009235000000                SEV(0) +
009236000000     /*   No replacement variables defined!                         */ +
009237000000                ALROPT(*NO) +
009238000000                CCSID(65535) +
009239000000                /*  -EOF-  */
009240000000
009241000000     /*-------------------------------------------------------------*/
009242000000     /*   Cmd-ADDMSGD für Message-ID :   USR8239                    */
009243000000     /* Appuyer sur la touche "Enträe" pour effacer la plage de car */
009244000000     /*-------------------------------------------------------------*/
009245000000
009246000000             RMVMSGD MSGID(USR8239) MSGF(&LIB/&OBJ)
009247000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009248000000
009249000000             ADDMSGD +
009250000000                MSGID(USR8239) +
009251000000                MSGF(&LIB/&OBJ) +
009252000000                MSG( +
009253000000'Appuyer sur la touche "Enträe" pour effacer la plage de caractüres sp-
009254000000äcifiäe.'                                                             +
009255000000                ) +
009256000000                SEV(0) +
009257000000     /*   No replacement variables defined!                         */ +
009258000000                ALROPT(*NO) +
009259000000                CCSID(65535) +
009260000000                /*  -EOF-  */
009261000000
009262000000     /*-------------------------------------------------------------*/
009263000000     /*   Cmd-ADDMSGD für Message-ID :   USR8240                    */
009264000000     /* La valeur ne doit pas être infärieure § 1.                  */
009265000000     /*-------------------------------------------------------------*/
009266000000
009267000000             RMVMSGD MSGID(USR8240) MSGF(&LIB/&OBJ)
009268000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009269000000
009270000000             ADDMSGD +
009271000000                MSGID(USR8240) +
009272000000                MSGF(&LIB/&OBJ) +
009273000000                MSG( +
009274000000'La valeur ne doit pas être infärieure § 1.'                          +
009275000000                ) +
009276000000                SEV(0) +
009277000000     /*   No replacement variables defined!                         */ +
009278000000                ALROPT(*NO) +
009279000000                CCSID(65535) +
009280000000                /*  -EOF-  */
009281000000
009282000000     /*-------------------------------------------------------------*/
009283000000     /*   Cmd-ADDMSGD für Message-ID :   USR8241                    */
009284000000     /* La valeur ne doit pas däpasser la longueur du champ.        */
009285000000     /*-------------------------------------------------------------*/
009286000000
009287000000             RMVMSGD MSGID(USR8241) MSGF(&LIB/&OBJ)
009288000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009289000000
009290000000             ADDMSGD +
009291000000                MSGID(USR8241) +
009292000000                MSGF(&LIB/&OBJ) +
009293000000                MSG( +
009294000000'La valeur ne doit pas däpasser la longueur du champ.'                +
009295000000                ) +
009296000000                SEV(0) +
009297000000     /*   No replacement variables defined!                         */ +
009298000000                ALROPT(*NO) +
009299000000                CCSID(65535) +
009300000000                /*  -EOF-  */
009301000000
009302000000     /*-------------------------------------------------------------*/
009303000000     /*   Cmd-ADDMSGD für Message-ID :   USR9992                    */
009304000000     /* Echec sauvegarde paramütres utilisateur                     */
009305000000     /*-------------------------------------------------------------*/
009306000000
009307000000             RMVMSGD MSGID(USR9992) MSGF(&LIB/&OBJ)
009308000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009309000000
009310000000             ADDMSGD +
009311000000                MSGID(USR9992) +
009312000000                MSGF(&LIB/&OBJ) +
009313000000                MSG( +
009314000000'Echec sauvegarde paramütres utilisateur'                             +
009315000000                ) +
009316000000                SEV(0) +
009317000000     /*   No replacement variables defined!                         */ +
009318000000                ALROPT(*NO) +
009319000000                CCSID(65535) +
009320000000                /*  -EOF-  */
009321000000
009322000000     /*-------------------------------------------------------------*/
009323000000     /*   Cmd-ADDMSGD für Message-ID :   USR9993                    */
009324000000     /* Fichier non ouvert. SQL est limitä aux fichiers physiques   */
009325000000     /*-------------------------------------------------------------*/
009326000000
009327000000             RMVMSGD MSGID(USR9993) MSGF(&LIB/&OBJ)
009328000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009329000000
009330000000             ADDMSGD +
009331000000                MSGID(USR9993) +
009332000000                MSGF(&LIB/&OBJ) +
009333000000                MSG( +
009334000000'Fichier non ouvert. SQL est limitä aux fichiers physiques'           +
009335000000                ) +
009336000000                SEV(0) +
009337000000     /*   No replacement variables defined!                         */ +
009338000000                ALROPT(*NO) +
009339000000                CCSID(65535) +
009340000000                /*  -EOF-  */
009341000000
009342000000     /*-------------------------------------------------------------*/
009343000000     /*   Cmd-ADDMSGD für Message-ID :   USR9994                    */
009344000000     /* Erreur inattendue &1 dans la procädure C &2.                */
009345000000     /*-------------------------------------------------------------*/
009346000000
009347000000             RMVMSGD MSGID(USR9994) MSGF(&LIB/&OBJ)
009348000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009349000000
009350000000             ADDMSGD +
009351000000                MSGID(USR9994) +
009352000000                MSGF(&LIB/&OBJ) +
009353000000                MSG( +
009354000000'Erreur inattendue &1 dans la procädure C &2.'                        +
009355000000                ) +
009356000000                SECLVL( +
009357000000'&N &N Description . . :   &3'                                        +
009358000000                ) +
009359000000                SEV(0) +
009360000000                FMT( +
009361000000                    (*DEC 5 0) +
009362000000                    (*CHAR 32) +
009363000000                    (*CHAR 256) +
009364000000                ) +
009365000000                ALROPT(*NO) +
009366000000                CCSID(65535) +
009367000000                /*  -EOF-  */
009368000000
009369000000     /*-------------------------------------------------------------*/
009370000000     /*   Cmd-ADDMSGD für Message-ID :   USR9995                    */
009371000000     /* Modifie le format d'enregistrement des fichiers de configur */
009372000000     /*-------------------------------------------------------------*/
009373000000
009374000000             RMVMSGD MSGID(USR9995) MSGF(&LIB/&OBJ)
009375000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009376000000
009377000000             ADDMSGD +
009378000000                MSGID(USR9995) +
009379000000                MSGF(&LIB/&OBJ) +
009380000000                MSG( +
009381000000'Modifie le format d''enregistrement des fichiers de configuration ...-
009382000000'                                                                     +
009383000000                ) +
009384000000                SEV(0) +
009385000000     /*   No replacement variables defined!                         */ +
009386000000                ALROPT(*NO) +
009387000000                CCSID(65535) +
009388000000                /*  -EOF-  */
009389000000
009390000000     /*-------------------------------------------------------------*/
009391000000     /*   Cmd-ADDMSGD für Message-ID :   USR9996                    */
009392000000     /* Aucun fichier ouvert.                                       */
009393000000     /*-------------------------------------------------------------*/
009394000000
009395000000             RMVMSGD MSGID(USR9996) MSGF(&LIB/&OBJ)
009396000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009397000000
009398000000             ADDMSGD +
009399000000                MSGID(USR9996) +
009400000000                MSGF(&LIB/&OBJ) +
009401000000                MSG( +
009402000000'Aucun fichier ouvert.'                                               +
009403000000                ) +
009404000000                SEV(0) +
009405000000     /*   No replacement variables defined!                         */ +
009406000000                ALROPT(*NO) +
009407000000                CCSID(65535) +
009408000000                /*  -EOF-  */
009409000000
009410000000     /*-------------------------------------------------------------*/
009411000000     /*   Cmd-ADDMSGD für Message-ID :   USR9997                    */
009412000000     /* &2PEEK/400 est&1 un partagiciel &2Veuillez vous enregistrer */
009413000000     /*-------------------------------------------------------------*/
009414000000
009415000000             RMVMSGD MSGID(USR9997) MSGF(&LIB/&OBJ)
009416000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009417000000
009418000000             ADDMSGD +
009419000000                MSGID(USR9997) +
009420000000                MSGF(&LIB/&OBJ) +
009421000000                MSG( +
009422000000'&2PEEK/400 est&1 un partagiciel &2Veuillez vous enregistrer.'        +
009423000000                ) +
009424000000                SEV(0) +
009425000000                FMT( +
009426000000                    (*CHAR 1) +
009427000000                    (*CHAR 1) +
009428000000                ) +
009429000000                ALROPT(*NO) +
009430000000                CCSID(65535) +
009431000000                /*  -EOF-  */
009432000000
009433000000     /*-------------------------------------------------------------*/
009434000000     /*   Cmd-ADDMSGD für Message-ID :   USR9998                    */
009435000000     /* Message inattendu nÄ &1 reÖu du programme &2.               */
009436000000     /*-------------------------------------------------------------*/
009437000000
009438000000             RMVMSGD MSGID(USR9998) MSGF(&LIB/&OBJ)
009439000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009440000000
009441000000             ADDMSGD +
009442000000                MSGID(USR9998) +
009443000000                MSGF(&LIB/&OBJ) +
009444000000                MSG( +
009445000000'Message inattendu nÄ &1 reÖu du programme &2.'                       +
009446000000                ) +
009447000000                SEV(0) +
009448000000                FMT( +
009449000000                    (*CHAR 7) +
009450000000                    (*CHAR 10) +
009451000000                ) +
009452000000                ALROPT(*NO) +
009453000000                CCSID(65535) +
009454000000                /*  -EOF-  */
009455000000
009456000000     /*-------------------------------------------------------------*/
009457000000     /*   Cmd-ADDMSGD für Message-ID :   USR9999                    */
009458000000     /* &1                                                          */
009459000000     /*-------------------------------------------------------------*/
009460000000
009461000000             RMVMSGD MSGID(USR9999) MSGF(&LIB/&OBJ)
009462000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
009463000000
009464000000             ADDMSGD +
009465000000                MSGID(USR9999) +
009466000000                MSGF(&LIB/&OBJ) +
009467000000                MSG( +
009468000000'&1'                                                                  +
009469000000                ) +
009470000000                SECLVL( +
009471000000'&2'                                                                  +
009472000000                ) +
009473000000                SEV(0) +
009474000000                FMT( +
009475000000                    (*CHAR 128) +
009476000000                    (*CHAR 128) +
009477000000                ) +
009478000000                ALROPT(*NO) +
009479000000                CCSID(65535) +
009480000000                /*  -EOF-  */
009481000000
009482000000             RCLRSC LVL(*)
009483000000
009484000000             ENDPGM
