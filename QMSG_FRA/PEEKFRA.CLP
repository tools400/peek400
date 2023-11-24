000100000000     /*-----------------------------------------------------------------------*/
000200000000     /* STRPREPRC Compile Options:                                            */
000300000000     /* >>PRE-COMPILER<<                                                      */
000400000000     /*   >>CRTCMD<<  CALL       PGM(QTEMP/&OB) PARM(&LI &OB);                */
000500000000     /*   >>CMD<<     CRTCLPGM   PGM(QTEMP/&OB) +                             */
000600000000     /*                          SRCFILE(&SL/&SF) SRCMBR(&SM) +               */
000700000000     /*               TEXT('Peek/400 - Französische Übersetzung');            */
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
002300000000                            MSGDTA('Usage: CALL PGM(PEEKFRA) +
002400000000                                    PARM(libName [msgFName)') +
002500000000                            TOPGMQ(*PRV (*PGMBDY)) MSGTYPE(*ESCAPE)
002600000000             ENDDO
002700000000
002800000000             CHGVAR     VAR(&OBJ       ) VALUE(&I_OBJ)
002900000000             MONMSG     MSGID(MCH3601) EXEC(DO)
003000000000               RMVMSG     PGMQ(*SAME (*)) CLEAR(*ALL)
003100000000               CHGVAR     VAR(&OBJ) VALUE('PEEKFRA   ')
003200000000             ENDDO
003300000000
003400000000     /*-------------------------------------------------------------*/
003500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BA                    */
003600000000     /* Touche F22 non valide                                       */
003700000000     /*-------------------------------------------------------------*/
003800000000
003900000000             RMVMSGD MSGID(AID00BA) MSGF(&LIB/&OBJ)
004000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
004100000000
004200000000             ADDMSGD +
004300000000                MSGID(AID00BA) +
004400000000                MSGF(&LIB/&OBJ) +
004500000000                MSG( +
004600000000'Touche F22 non valide'                                               +
004700000000                ) +
004800000000                SEV(0) +
004900000000     /*   No replacement variables defined!                         */ +
005000000000                ALROPT(*NO) +
005100000000                CCSID(65535) +
005200000000                /*  -EOF-  */
005300000000
005400000000     /*-------------------------------------------------------------*/
005500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BB                    */
005600000000     /* Touche F23 non valide                                       */
005700000000     /*-------------------------------------------------------------*/
005800000000
005900000000             RMVMSGD MSGID(AID00BB) MSGF(&LIB/&OBJ)
006000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
006100000000
006200000000             ADDMSGD +
006300000000                MSGID(AID00BB) +
006400000000                MSGF(&LIB/&OBJ) +
006500000000                MSG( +
006600000000'Touche F23 non valide'                                               +
006700000000                ) +
006800000000                SEV(0) +
006900000000     /*   No replacement variables defined!                         */ +
007000000000                ALROPT(*NO) +
007100000000                CCSID(65535) +
007200000000                /*  -EOF-  */
007300000000
007400000000     /*-------------------------------------------------------------*/
007500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BC                    */
007600000000     /* Touche F24 non valide                                       */
007700000000     /*-------------------------------------------------------------*/
007800000000
007900000000             RMVMSGD MSGID(AID00BC) MSGF(&LIB/&OBJ)
008000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
008100000000
008200000000             ADDMSGD +
008300000000                MSGID(AID00BC) +
008400000000                MSGF(&LIB/&OBJ) +
008500000000                MSG( +
008600000000'Touche F24 non valide'                                               +
008700000000                ) +
008800000000                SEV(0) +
008900000000     /*   No replacement variables defined!                         */ +
009000000000                ALROPT(*NO) +
009100000000                CCSID(65535) +
009200000000                /*  -EOF-  */
009300000000
009400000000     /*-------------------------------------------------------------*/
009500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00BD                    */
009600000000     /* Touche 'SUPPR' invalide                                     */
009700000000     /*-------------------------------------------------------------*/
009800000000
009900000000             RMVMSGD MSGID(AID00BD) MSGF(&LIB/&OBJ)
010000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
010100000000
010200000000             ADDMSGD +
010300000000                MSGID(AID00BD) +
010400000000                MSGF(&LIB/&OBJ) +
010500000000                MSG( +
010600000000'Touche ''SUPPR'' invalide'                                           +
010700000000                ) +
010800000000                SEV(0) +
010900000000     /*   No replacement variables defined!                         */ +
011000000000                ALROPT(*NO) +
011100000000                CCSID(65535) +
011200000000                /*  -EOF-  */
011300000000
011400000000     /*-------------------------------------------------------------*/
011500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B1                    */
011600000000     /* Touche F13 non valide                                       */
011700000000     /*-------------------------------------------------------------*/
011800000000
011900000000             RMVMSGD MSGID(AID00B1) MSGF(&LIB/&OBJ)
012000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
012100000000
012200000000             ADDMSGD +
012300000000                MSGID(AID00B1) +
012400000000                MSGF(&LIB/&OBJ) +
012500000000                MSG( +
012600000000'Touche F13 non valide'                                               +
012700000000                ) +
012800000000                SEV(0) +
012900000000     /*   No replacement variables defined!                         */ +
013000000000                ALROPT(*NO) +
013100000000                CCSID(65535) +
013200000000                /*  -EOF-  */
013300000000
013400000000     /*-------------------------------------------------------------*/
013500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B2                    */
013600000000     /* Touche F14 non valide                                       */
013700000000     /*-------------------------------------------------------------*/
013800000000
013900000000             RMVMSGD MSGID(AID00B2) MSGF(&LIB/&OBJ)
014000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
014100000000
014200000000             ADDMSGD +
014300000000                MSGID(AID00B2) +
014400000000                MSGF(&LIB/&OBJ) +
014500000000                MSG( +
014600000000'Touche F14 non valide'                                               +
014700000000                ) +
014800000000                SEV(0) +
014900000000     /*   No replacement variables defined!                         */ +
015000000000                ALROPT(*NO) +
015100000000                CCSID(65535) +
015200000000                /*  -EOF-  */
015300000000
015400000000     /*-------------------------------------------------------------*/
015500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B3                    */
015600000000     /* Touche F15 non valide                                       */
015700000000     /*-------------------------------------------------------------*/
015800000000
015900000000             RMVMSGD MSGID(AID00B3) MSGF(&LIB/&OBJ)
016000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
016100000000
016200000000             ADDMSGD +
016300000000                MSGID(AID00B3) +
016400000000                MSGF(&LIB/&OBJ) +
016500000000                MSG( +
016600000000'Touche F15 non valide'                                               +
016700000000                ) +
016800000000                SEV(0) +
016900000000     /*   No replacement variables defined!                         */ +
017000000000                ALROPT(*NO) +
017100000000                CCSID(65535) +
017200000000                /*  -EOF-  */
017300000000
017400000000     /*-------------------------------------------------------------*/
017500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B4                    */
017600000000     /* Touche F16 non valide                                       */
017700000000     /*-------------------------------------------------------------*/
017800000000
017900000000             RMVMSGD MSGID(AID00B4) MSGF(&LIB/&OBJ)
018000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
018100000000
018200000000             ADDMSGD +
018300000000                MSGID(AID00B4) +
018400000000                MSGF(&LIB/&OBJ) +
018500000000                MSG( +
018600000000'Touche F16 non valide'                                               +
018700000000                ) +
018800000000                SEV(0) +
018900000000     /*   No replacement variables defined!                         */ +
019000000000                ALROPT(*NO) +
019100000000                CCSID(65535) +
019200000000                /*  -EOF-  */
019300000000
019400000000     /*-------------------------------------------------------------*/
019500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B5                    */
019600000000     /* Touche F17 non valide                                       */
019700000000     /*-------------------------------------------------------------*/
019800000000
019900000000             RMVMSGD MSGID(AID00B5) MSGF(&LIB/&OBJ)
020000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
020100000000
020200000000             ADDMSGD +
020300000000                MSGID(AID00B5) +
020400000000                MSGF(&LIB/&OBJ) +
020500000000                MSG( +
020600000000'Touche F17 non valide'                                               +
020700000000                ) +
020800000000                SEV(0) +
020900000000     /*   No replacement variables defined!                         */ +
021000000000                ALROPT(*NO) +
021100000000                CCSID(65535) +
021200000000                /*  -EOF-  */
021300000000
021400000000     /*-------------------------------------------------------------*/
021500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B6                    */
021600000000     /* Touche F18 non valide                                       */
021700000000     /*-------------------------------------------------------------*/
021800000000
021900000000             RMVMSGD MSGID(AID00B6) MSGF(&LIB/&OBJ)
022000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
022100000000
022200000000             ADDMSGD +
022300000000                MSGID(AID00B6) +
022400000000                MSGF(&LIB/&OBJ) +
022500000000                MSG( +
022600000000'Touche F18 non valide'                                               +
022700000000                ) +
022800000000                SEV(0) +
022900000000     /*   No replacement variables defined!                         */ +
023000000000                ALROPT(*NO) +
023100000000                CCSID(65535) +
023200000000                /*  -EOF-  */
023300000000
023400000000     /*-------------------------------------------------------------*/
023500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B7                    */
023600000000     /* Touche F19 non valide                                       */
023700000000     /*-------------------------------------------------------------*/
023800000000
023900000000             RMVMSGD MSGID(AID00B7) MSGF(&LIB/&OBJ)
024000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
024100000000
024200000000             ADDMSGD +
024300000000                MSGID(AID00B7) +
024400000000                MSGF(&LIB/&OBJ) +
024500000000                MSG( +
024600000000'Touche F19 non valide'                                               +
024700000000                ) +
024800000000                SEV(0) +
024900000000     /*   No replacement variables defined!                         */ +
025000000000                ALROPT(*NO) +
025100000000                CCSID(65535) +
025200000000                /*  -EOF-  */
025300000000
025400000000     /*-------------------------------------------------------------*/
025500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B8                    */
025600000000     /* Touche F20 non valide                                       */
025700000000     /*-------------------------------------------------------------*/
025800000000
025900000000             RMVMSGD MSGID(AID00B8) MSGF(&LIB/&OBJ)
026000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
026100000000
026200000000             ADDMSGD +
026300000000                MSGID(AID00B8) +
026400000000                MSGF(&LIB/&OBJ) +
026500000000                MSG( +
026600000000'Touche F20 non valide'                                               +
026700000000                ) +
026800000000                SEV(0) +
026900000000     /*   No replacement variables defined!                         */ +
027000000000                ALROPT(*NO) +
027100000000                CCSID(65535) +
027200000000                /*  -EOF-  */
027300000000
027400000000     /*-------------------------------------------------------------*/
027500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00B9                    */
027600000000     /* Touche F21 non valide                                       */
027700000000     /*-------------------------------------------------------------*/
027800000000
027900000000             RMVMSGD MSGID(AID00B9) MSGF(&LIB/&OBJ)
028000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
028100000000
028200000000             ADDMSGD +
028300000000                MSGID(AID00B9) +
028400000000                MSGF(&LIB/&OBJ) +
028500000000                MSG( +
028600000000'Touche F21 non valide'                                               +
028700000000                ) +
028800000000                SEV(0) +
028900000000     /*   No replacement variables defined!                         */ +
029000000000                ALROPT(*NO) +
029100000000                CCSID(65535) +
029200000000                /*  -EOF-  */
029300000000
029400000000     /*-------------------------------------------------------------*/
029500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F1                    */
029600000000     /* Touche 'ENTREE' non valide                                  */
029700000000     /*-------------------------------------------------------------*/
029800000000
029900000000             RMVMSGD MSGID(AID00F1) MSGF(&LIB/&OBJ)
030000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
030100000000
030200000000             ADDMSGD +
030300000000                MSGID(AID00F1) +
030400000000                MSGF(&LIB/&OBJ) +
030500000000                MSG( +
030600000000'Touche ''ENTREE'' non valide'                                        +
030700000000                ) +
030800000000                SEV(0) +
030900000000     /*   No replacement variables defined!                         */ +
031000000000                ALROPT(*NO) +
031100000000                CCSID(65535) +
031200000000                /*  -EOF-  */
031300000000
031400000000     /*-------------------------------------------------------------*/
031500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F3                    */
031600000000     /* Touche 'AIDE' non valide                                    */
031700000000     /*-------------------------------------------------------------*/
031800000000
031900000000             RMVMSGD MSGID(AID00F3) MSGF(&LIB/&OBJ)
032000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
032100000000
032200000000             ADDMSGD +
032300000000                MSGID(AID00F3) +
032400000000                MSGF(&LIB/&OBJ) +
032500000000                MSG( +
032600000000'Touche ''AIDE'' non valide'                                          +
032700000000                ) +
032800000000                SEV(0) +
032900000000     /*   No replacement variables defined!                         */ +
033000000000                ALROPT(*NO) +
033100000000                CCSID(65535) +
033200000000                /*  -EOF-  */
033300000000
033400000000     /*-------------------------------------------------------------*/
033500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F4                    */
033600000000     /* Touche 'PAGE PREC' non valide                               */
033700000000     /*-------------------------------------------------------------*/
033800000000
033900000000             RMVMSGD MSGID(AID00F4) MSGF(&LIB/&OBJ)
034000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
034100000000
034200000000             ADDMSGD +
034300000000                MSGID(AID00F4) +
034400000000                MSGF(&LIB/&OBJ) +
034500000000                MSG( +
034600000000'Touche ''PAGE PREC'' non valide'                                     +
034700000000                ) +
034800000000                SEV(0) +
034900000000     /*   No replacement variables defined!                         */ +
035000000000                ALROPT(*NO) +
035100000000                CCSID(65535) +
035200000000                /*  -EOF-  */
035300000000
035400000000     /*-------------------------------------------------------------*/
035500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F5                    */
035600000000     /* Touche 'PAGE SUIV' non valide                               */
035700000000     /*-------------------------------------------------------------*/
035800000000
035900000000             RMVMSGD MSGID(AID00F5) MSGF(&LIB/&OBJ)
036000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
036100000000
036200000000             ADDMSGD +
036300000000                MSGID(AID00F5) +
036400000000                MSGF(&LIB/&OBJ) +
036500000000                MSG( +
036600000000'Touche ''PAGE SUIV'' non valide'                                     +
036700000000                ) +
036800000000                SEV(0) +
036900000000     /*   No replacement variables defined!                         */ +
037000000000                ALROPT(*NO) +
037100000000                CCSID(65535) +
037200000000                /*  -EOF-  */
037300000000
037400000000     /*-------------------------------------------------------------*/
037500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F6                    */
037600000000     /* Touche 'IMPR' non valide                                    */
037700000000     /*-------------------------------------------------------------*/
037800000000
037900000000             RMVMSGD MSGID(AID00F6) MSGF(&LIB/&OBJ)
038000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
038100000000
038200000000             ADDMSGD +
038300000000                MSGID(AID00F6) +
038400000000                MSGF(&LIB/&OBJ) +
038500000000                MSG( +
038600000000'Touche ''IMPR'' non valide'                                          +
038700000000                ) +
038800000000                SEV(0) +
038900000000     /*   No replacement variables defined!                         */ +
039000000000                ALROPT(*NO) +
039100000000                CCSID(65535) +
039200000000                /*  -EOF-  */
039300000000
039400000000     /*-------------------------------------------------------------*/
039500000000     /*   Cmd-ADDMSGD für Message-ID :   AID00F8                    */
039600000000     /* Touche 'RESET' non valide                                   */
039700000000     /*-------------------------------------------------------------*/
039800000000
039900000000             RMVMSGD MSGID(AID00F8) MSGF(&LIB/&OBJ)
040000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
040100000000
040200000000             ADDMSGD +
040300000000                MSGID(AID00F8) +
040400000000                MSGF(&LIB/&OBJ) +
040500000000                MSG( +
040600000000'Touche ''RESET'' non valide'                                         +
040700000000                ) +
040800000000                SEV(0) +
040900000000     /*   No replacement variables defined!                         */ +
041000000000                ALROPT(*NO) +
041100000000                CCSID(65535) +
041200000000                /*  -EOF-  */
041300000000
041400000000     /*-------------------------------------------------------------*/
041500000000     /*   Cmd-ADDMSGD für Message-ID :   AID003A                    */
041600000000     /* Touche F10 non valide                                       */
041700000000     /*-------------------------------------------------------------*/
041800000000
041900000000             RMVMSGD MSGID(AID003A) MSGF(&LIB/&OBJ)
042000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
042100000000
042200000000             ADDMSGD +
042300000000                MSGID(AID003A) +
042400000000                MSGF(&LIB/&OBJ) +
042500000000                MSG( +
042600000000'Touche F10 non valide'                                               +
042700000000                ) +
042800000000                SEV(0) +
042900000000     /*   No replacement variables defined!                         */ +
043000000000                ALROPT(*NO) +
043100000000                CCSID(65535) +
043200000000                /*  -EOF-  */
043300000000
043400000000     /*-------------------------------------------------------------*/
043500000000     /*   Cmd-ADDMSGD für Message-ID :   AID003B                    */
043600000000     /* Touche F11 non valide                                       */
043700000000     /*-------------------------------------------------------------*/
043800000000
043900000000             RMVMSGD MSGID(AID003B) MSGF(&LIB/&OBJ)
044000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
044100000000
044200000000             ADDMSGD +
044300000000                MSGID(AID003B) +
044400000000                MSGF(&LIB/&OBJ) +
044500000000                MSG( +
044600000000'Touche F11 non valide'                                               +
044700000000                ) +
044800000000                SEV(0) +
044900000000     /*   No replacement variables defined!                         */ +
045000000000                ALROPT(*NO) +
045100000000                CCSID(65535) +
045200000000                /*  -EOF-  */
045300000000
045400000000     /*-------------------------------------------------------------*/
045500000000     /*   Cmd-ADDMSGD für Message-ID :   AID003C                    */
045600000000     /* Touche F12 non valide                                       */
045700000000     /*-------------------------------------------------------------*/
045800000000
045900000000             RMVMSGD MSGID(AID003C) MSGF(&LIB/&OBJ)
046000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
046100000000
046200000000             ADDMSGD +
046300000000                MSGID(AID003C) +
046400000000                MSGF(&LIB/&OBJ) +
046500000000                MSG( +
046600000000'Touche F12 non valide'                                               +
046700000000                ) +
046800000000                SEV(0) +
046900000000     /*   No replacement variables defined!                         */ +
047000000000                ALROPT(*NO) +
047100000000                CCSID(65535) +
047200000000                /*  -EOF-  */
047300000000
047400000000     /*-------------------------------------------------------------*/
047500000000     /*   Cmd-ADDMSGD für Message-ID :   AID003F                    */
047600000000     /* Touche 'CRAYON OPTIQUE' non valide                          */
047700000000     /*-------------------------------------------------------------*/
047800000000
047900000000             RMVMSGD MSGID(AID003F) MSGF(&LIB/&OBJ)
048000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
048100000000
048200000000             ADDMSGD +
048300000000                MSGID(AID003F) +
048400000000                MSGF(&LIB/&OBJ) +
048500000000                MSG( +
048600000000'Touche ''CRAYON OPTIQUE'' non valide'                                +
048700000000                ) +
048800000000                SEV(0) +
048900000000     /*   No replacement variables defined!                         */ +
049000000000                ALROPT(*NO) +
049100000000                CCSID(65535) +
049200000000                /*  -EOF-  */
049300000000
049400000000     /*-------------------------------------------------------------*/
049500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0031                    */
049600000000     /* Touche F1 non valide                                        */
049700000000     /*-------------------------------------------------------------*/
049800000000
049900000000             RMVMSGD MSGID(AID0031) MSGF(&LIB/&OBJ)
050000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
050100000000
050200000000             ADDMSGD +
050300000000                MSGID(AID0031) +
050400000000                MSGF(&LIB/&OBJ) +
050500000000                MSG( +
050600000000'Touche F1 non valide'                                                +
050700000000                ) +
050800000000                SEV(0) +
050900000000     /*   No replacement variables defined!                         */ +
051000000000                ALROPT(*NO) +
051100000000                CCSID(65535) +
051200000000                /*  -EOF-  */
051300000000
051400000000     /*-------------------------------------------------------------*/
051500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0032                    */
051600000000     /* Touche F2 non valide                                        */
051700000000     /*-------------------------------------------------------------*/
051800000000
051900000000             RMVMSGD MSGID(AID0032) MSGF(&LIB/&OBJ)
052000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
052100000000
052200000000             ADDMSGD +
052300000000                MSGID(AID0032) +
052400000000                MSGF(&LIB/&OBJ) +
052500000000                MSG( +
052600000000'Touche F2 non valide'                                                +
052700000000                ) +
052800000000                SEV(0) +
052900000000     /*   No replacement variables defined!                         */ +
053000000000                ALROPT(*NO) +
053100000000                CCSID(65535) +
053200000000                /*  -EOF-  */
053300000000
053400000000     /*-------------------------------------------------------------*/
053500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0033                    */
053600000000     /* Touche F3 non valide                                        */
053700000000     /*-------------------------------------------------------------*/
053800000000
053900000000             RMVMSGD MSGID(AID0033) MSGF(&LIB/&OBJ)
054000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
054100000000
054200000000             ADDMSGD +
054300000000                MSGID(AID0033) +
054400000000                MSGF(&LIB/&OBJ) +
054500000000                MSG( +
054600000000'Touche F3 non valide'                                                +
054700000000                ) +
054800000000                SEV(0) +
054900000000     /*   No replacement variables defined!                         */ +
055000000000                ALROPT(*NO) +
055100000000                CCSID(65535) +
055200000000                /*  -EOF-  */
055300000000
055400000000     /*-------------------------------------------------------------*/
055500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0034                    */
055600000000     /* Touche F4 non valide                                        */
055700000000     /*-------------------------------------------------------------*/
055800000000
055900000000             RMVMSGD MSGID(AID0034) MSGF(&LIB/&OBJ)
056000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
056100000000
056200000000             ADDMSGD +
056300000000                MSGID(AID0034) +
056400000000                MSGF(&LIB/&OBJ) +
056500000000                MSG( +
056600000000'Touche F4 non valide'                                                +
056700000000                ) +
056800000000                SEV(0) +
056900000000     /*   No replacement variables defined!                         */ +
057000000000                ALROPT(*NO) +
057100000000                CCSID(65535) +
057200000000                /*  -EOF-  */
057300000000
057400000000     /*-------------------------------------------------------------*/
057500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0035                    */
057600000000     /* Touche F5 non valide                                        */
057700000000     /*-------------------------------------------------------------*/
057800000000
057900000000             RMVMSGD MSGID(AID0035) MSGF(&LIB/&OBJ)
058000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
058100000000
058200000000             ADDMSGD +
058300000000                MSGID(AID0035) +
058400000000                MSGF(&LIB/&OBJ) +
058500000000                MSG( +
058600000000'Touche F5 non valide'                                                +
058700000000                ) +
058800000000                SEV(0) +
058900000000     /*   No replacement variables defined!                         */ +
059000000000                ALROPT(*NO) +
059100000000                CCSID(65535) +
059200000000                /*  -EOF-  */
059300000000
059400000000     /*-------------------------------------------------------------*/
059500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0036                    */
059600000000     /* Touche F6 non valide                                        */
059700000000     /*-------------------------------------------------------------*/
059800000000
059900000000             RMVMSGD MSGID(AID0036) MSGF(&LIB/&OBJ)
060000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
060100000000
060200000000             ADDMSGD +
060300000000                MSGID(AID0036) +
060400000000                MSGF(&LIB/&OBJ) +
060500000000                MSG( +
060600000000'Touche F6 non valide'                                                +
060700000000                ) +
060800000000                SEV(0) +
060900000000     /*   No replacement variables defined!                         */ +
061000000000                ALROPT(*NO) +
061100000000                CCSID(65535) +
061200000000                /*  -EOF-  */
061300000000
061400000000     /*-------------------------------------------------------------*/
061500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0037                    */
061600000000     /* Touche F7 non valide                                        */
061700000000     /*-------------------------------------------------------------*/
061800000000
061900000000             RMVMSGD MSGID(AID0037) MSGF(&LIB/&OBJ)
062000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
062100000000
062200000000             ADDMSGD +
062300000000                MSGID(AID0037) +
062400000000                MSGF(&LIB/&OBJ) +
062500000000                MSG( +
062600000000'Touche F7 non valide'                                                +
062700000000                ) +
062800000000                SEV(0) +
062900000000     /*   No replacement variables defined!                         */ +
063000000000                ALROPT(*NO) +
063100000000                CCSID(65535) +
063200000000                /*  -EOF-  */
063300000000
063400000000     /*-------------------------------------------------------------*/
063500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0038                    */
063600000000     /* Touche F8 non valide                                        */
063700000000     /*-------------------------------------------------------------*/
063800000000
063900000000             RMVMSGD MSGID(AID0038) MSGF(&LIB/&OBJ)
064000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
064100000000
064200000000             ADDMSGD +
064300000000                MSGID(AID0038) +
064400000000                MSGF(&LIB/&OBJ) +
064500000000                MSG( +
064600000000'Touche F8 non valide'                                                +
064700000000                ) +
064800000000                SEV(0) +
064900000000     /*   No replacement variables defined!                         */ +
065000000000                ALROPT(*NO) +
065100000000                CCSID(65535) +
065200000000                /*  -EOF-  */
065300000000
065400000000     /*-------------------------------------------------------------*/
065500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0039                    */
065600000000     /* Touche F9 non valide                                        */
065700000000     /*-------------------------------------------------------------*/
065800000000
065900000000             RMVMSGD MSGID(AID0039) MSGF(&LIB/&OBJ)
066000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
066100000000
066200000000             ADDMSGD +
066300000000                MSGID(AID0039) +
066400000000                MSGF(&LIB/&OBJ) +
066500000000                MSG( +
066600000000'Touche F9 non valide'                                                +
066700000000                ) +
066800000000                SEV(0) +
066900000000     /*   No replacement variables defined!                         */ +
067000000000                ALROPT(*NO) +
067100000000                CCSID(65535) +
067200000000                /*  -EOF-  */
067300000000
067400000000     /*-------------------------------------------------------------*/
067500000000     /*   Cmd-ADDMSGD für Message-ID :   AID0100                    */
067600000000     /* Touche invalide                                             */
067700000000     /*-------------------------------------------------------------*/
067800000000
067900000000             RMVMSGD MSGID(AID0100) MSGF(&LIB/&OBJ)
068000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
068100000000
068200000000             ADDMSGD +
068300000000                MSGID(AID0100) +
068400000000                MSGF(&LIB/&OBJ) +
068500000000                MSG( +
068600000000'Touche invalide'                                                     +
068700000000                ) +
068800000000                SEV(0) +
068900000000     /*   No replacement variables defined!                         */ +
069000000000                ALROPT(*NO) +
069100000000                CCSID(65535) +
069200000000                /*  -EOF-  */
069300000000
069400000000     /*-------------------------------------------------------------*/
069500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0001                    */
069600000000     /* Enträe                                                      */
069700000000     /*-------------------------------------------------------------*/
069800000000
069900000000             RMVMSGD MSGID(KEY0001) MSGF(&LIB/&OBJ)
070000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
070100000000
070200000000             ADDMSGD +
070300000000                MSGID(KEY0001) +
070400000000                MSGF(&LIB/&OBJ) +
070500000000                MSG( +
070600000000'Enträe        '                                                      +
070700000000                ) +
070800000000                SEV(0) +
070900000000     /*   No replacement variables defined!                         */ +
071000000000                ALROPT(*NO) +
071100000000                CCSID(65535) +
071200000000                /*  -EOF-  */
071300000000
071400000000     /*-------------------------------------------------------------*/
071500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0002                    */
071600000000     /* Fin                                                         */
071700000000     /*-------------------------------------------------------------*/
071800000000
071900000000             RMVMSGD MSGID(KEY0002) MSGF(&LIB/&OBJ)
072000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
072100000000
072200000000             ADDMSGD +
072300000000                MSGID(KEY0002) +
072400000000                MSGF(&LIB/&OBJ) +
072500000000                MSG( +
072600000000'Fin           '                                                      +
072700000000                ) +
072800000000                SEV(0) +
072900000000     /*   No replacement variables defined!                         */ +
073000000000                ALROPT(*NO) +
073100000000                CCSID(65535) +
073200000000                /*  -EOF-  */
073300000000
073400000000     /*-------------------------------------------------------------*/
073500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0003                    */
073600000000     /* Rafraîchir                                                  */
073700000000     /*-------------------------------------------------------------*/
073800000000
073900000000             RMVMSGD MSGID(KEY0003) MSGF(&LIB/&OBJ)
074000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
074100000000
074200000000             ADDMSGD +
074300000000                MSGID(KEY0003) +
074400000000                MSGF(&LIB/&OBJ) +
074500000000                MSG( +
074600000000'Rafraîchir    '                                                      +
074700000000                ) +
074800000000                SEV(0) +
074900000000     /*   No replacement variables defined!                         */ +
075000000000                ALROPT(*NO) +
075100000000                CCSID(65535) +
075200000000                /*  -EOF-  */
075300000000
075400000000     /*-------------------------------------------------------------*/
075500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0004                    */
075600000000     /* Ajouter                                                     */
075700000000     /*-------------------------------------------------------------*/
075800000000
075900000000             RMVMSGD MSGID(KEY0004) MSGF(&LIB/&OBJ)
076000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
076100000000
076200000000             ADDMSGD +
076300000000                MSGID(KEY0004) +
076400000000                MSGF(&LIB/&OBJ) +
076500000000                MSG( +
076600000000'Ajouter  '                                                           +
076700000000                ) +
076800000000                SEV(0) +
076900000000     /*   No replacement variables defined!                         */ +
077000000000                ALROPT(*NO) +
077100000000                CCSID(65535) +
077200000000                /*  -EOF-  */
077300000000
077400000000     /*-------------------------------------------------------------*/
077500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0005                    */
077600000000     /* Nom/lib. champ                                              */
077700000000     /*-------------------------------------------------------------*/
077800000000
077900000000             RMVMSGD MSGID(KEY0005) MSGF(&LIB/&OBJ)
078000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
078100000000
078200000000             ADDMSGD +
078300000000                MSGID(KEY0005) +
078400000000                MSGF(&LIB/&OBJ) +
078500000000                MSG( +
078600000000'Nom/lib. champ'                                                      +
078700000000                ) +
078800000000                SEV(0) +
078900000000     /*   No replacement variables defined!                         */ +
079000000000                ALROPT(*NO) +
079100000000                CCSID(65535) +
079200000000                /*  -EOF-  */
079300000000
079400000000     /*-------------------------------------------------------------*/
079500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0006                    */
079600000000     /* Sälec.col. +/-                                              */
079700000000     /*-------------------------------------------------------------*/
079800000000
079900000000             RMVMSGD MSGID(KEY0006) MSGF(&LIB/&OBJ)
080000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
080100000000
080200000000             ADDMSGD +
080300000000                MSGID(KEY0006) +
080400000000                MSGF(&LIB/&OBJ) +
080500000000                MSG( +
080600000000'Sälec.col. +/-'                                                      +
080700000000                ) +
080800000000                SEV(0) +
080900000000     /*   No replacement variables defined!                         */ +
081000000000                ALROPT(*NO) +
081100000000                CCSID(65535) +
081200000000                /*  -EOF-  */
081300000000
081400000000     /*-------------------------------------------------------------*/
081500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0007                    */
081600000000     /* Haut de page                                                */
081700000000     /*-------------------------------------------------------------*/
081800000000
081900000000             RMVMSGD MSGID(KEY0007) MSGF(&LIB/&OBJ)
082000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
082100000000
082200000000             ADDMSGD +
082300000000                MSGID(KEY0007) +
082400000000                MSGF(&LIB/&OBJ) +
082500000000                MSG( +
082600000000'Haut de page'                                                        +
082700000000                ) +
082800000000                SEV(0) +
082900000000     /*   No replacement variables defined!                         */ +
083000000000                ALROPT(*NO) +
083100000000                CCSID(65535) +
083200000000                /*  -EOF-  */
083300000000
083400000000     /*-------------------------------------------------------------*/
083500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0008                    */
083600000000     /* Pos. Curseur                                                */
083700000000     /*-------------------------------------------------------------*/
083800000000
083900000000             RMVMSGD MSGID(KEY0008) MSGF(&LIB/&OBJ)
084000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
084100000000
084200000000             ADDMSGD +
084300000000                MSGID(KEY0008) +
084400000000                MSGF(&LIB/&OBJ) +
084500000000                MSG( +
084600000000'Pos. Curseur  '                                                      +
084700000000                ) +
084800000000                SEV(0) +
084900000000     /*   No replacement variables defined!                         */ +
085000000000                ALROPT(*NO) +
085100000000                CCSID(65535) +
085200000000                /*  -EOF-  */
085300000000
085400000000     /*-------------------------------------------------------------*/
085500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0009                    */
085600000000     /* Recherche                                                   */
085700000000     /*-------------------------------------------------------------*/
085800000000
085900000000             RMVMSGD MSGID(KEY0009) MSGF(&LIB/&OBJ)
086000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
086100000000
086200000000             ADDMSGD +
086300000000                MSGID(KEY0009) +
086400000000                MSGF(&LIB/&OBJ) +
086500000000                MSG( +
086600000000'Recherche     '                                                      +
086700000000                ) +
086800000000                SEV(0) +
086900000000     /*   No replacement variables defined!                         */ +
087000000000                ALROPT(*NO) +
087100000000                CCSID(65535) +
087200000000                /*  -EOF-  */
087300000000
087400000000     /*-------------------------------------------------------------*/
087500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0010                    */
087600000000     /* Däbut                                                       */
087700000000     /*-------------------------------------------------------------*/
087800000000
087900000000             RMVMSGD MSGID(KEY0010) MSGF(&LIB/&OBJ)
088000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
088100000000
088200000000             ADDMSGD +
088300000000                MSGID(KEY0010) +
088400000000                MSGF(&LIB/&OBJ) +
088500000000                MSG( +
088600000000'Däbut         '                                                      +
088700000000                ) +
088800000000                SEV(0) +
088900000000     /*   No replacement variables defined!                         */ +
089000000000                ALROPT(*NO) +
089100000000                CCSID(65535) +
089200000000                /*  -EOF-  */
089300000000
089400000000     /*-------------------------------------------------------------*/
089500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0011                    */
089600000000     /* Fin                                                         */
089700000000     /*-------------------------------------------------------------*/
089800000000
089900000000             RMVMSGD MSGID(KEY0011) MSGF(&LIB/&OBJ)
090000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
090100000000
090200000000             ADDMSGD +
090300000000                MSGID(KEY0011) +
090400000000                MSGF(&LIB/&OBJ) +
090500000000                MSG( +
090600000000'Fin           '                                                      +
090700000000                ) +
090800000000                SEV(0) +
090900000000     /*   No replacement variables defined!                         */ +
091000000000                ALROPT(*NO) +
091100000000                CCSID(65535) +
091200000000                /*  -EOF-  */
091300000000
091400000000     /*-------------------------------------------------------------*/
091500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0012                    */
091600000000     /* Gauche                                                      */
091700000000     /*-------------------------------------------------------------*/
091800000000
091900000000             RMVMSGD MSGID(KEY0012) MSGF(&LIB/&OBJ)
092000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
092100000000
092200000000             ADDMSGD +
092300000000                MSGID(KEY0012) +
092400000000                MSGF(&LIB/&OBJ) +
092500000000                MSG( +
092600000000'Gauche        '                                                      +
092700000000                ) +
092800000000                SEV(0) +
092900000000     /*   No replacement variables defined!                         */ +
093000000000                ALROPT(*NO) +
093100000000                CCSID(65535) +
093200000000                /*  -EOF-  */
093300000000
093400000000     /*-------------------------------------------------------------*/
093500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0013                    */
093600000000     /* Droite                                                      */
093700000000     /*-------------------------------------------------------------*/
093800000000
093900000000             RMVMSGD MSGID(KEY0013) MSGF(&LIB/&OBJ)
094000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
094100000000
094200000000             ADDMSGD +
094300000000                MSGID(KEY0013) +
094400000000                MSGF(&LIB/&OBJ) +
094500000000                MSG( +
094600000000'Droite        '                                                      +
094700000000                ) +
094800000000                SEV(0) +
094900000000     /*   No replacement variables defined!                         */ +
095000000000                ALROPT(*NO) +
095100000000                CCSID(65535) +
095200000000                /*  -EOF-  */
095300000000
095400000000     /*-------------------------------------------------------------*/
095500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0014                    */
095600000000     /* Ligne commande                                              */
095700000000     /*-------------------------------------------------------------*/
095800000000
095900000000             RMVMSGD MSGID(KEY0014) MSGF(&LIB/&OBJ)
096000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
096100000000
096200000000             ADDMSGD +
096300000000                MSGID(KEY0014) +
096400000000                MSGF(&LIB/&OBJ) +
096500000000                MSG( +
096600000000'Ligne commande'                                                      +
096700000000                ) +
096800000000                SEV(0) +
096900000000     /*   No replacement variables defined!                         */ +
097000000000                ALROPT(*NO) +
097100000000                CCSID(65535) +
097200000000                /*  -EOF-  */
097300000000
097400000000     /*-------------------------------------------------------------*/
097500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0015                    */
097600000000     /* 80/132 colonne                                              */
097700000000     /*-------------------------------------------------------------*/
097800000000
097900000000             RMVMSGD MSGID(KEY0015) MSGF(&LIB/&OBJ)
098000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
098100000000
098200000000             ADDMSGD +
098300000000                MSGID(KEY0015) +
098400000000                MSGF(&LIB/&OBJ) +
098500000000                MSG( +
098600000000'80/132 colonne'                                                      +
098700000000                ) +
098800000000                SEV(0) +
098900000000     /*   No replacement variables defined!                         */ +
099000000000                ALROPT(*NO) +
099100000000                CCSID(65535) +
099200000000                /*  -EOF-  */
099300000000
099400000000     /*-------------------------------------------------------------*/
099500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0016                    */
099600000000     /* Autres touches                                              */
099700000000     /*-------------------------------------------------------------*/
099800000000
099900000000             RMVMSGD MSGID(KEY0016) MSGF(&LIB/&OBJ)
100000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
100100000000
100200000000             ADDMSGD +
100300000000                MSGID(KEY0016) +
100400000000                MSGF(&LIB/&OBJ) +
100500000000                MSG( +
100600000000'Autres touches'                                                      +
100700000000                ) +
100800000000                SEV(0) +
100900000000     /*   No replacement variables defined!                         */ +
101000000000                ALROPT(*NO) +
101100000000                CCSID(65535) +
101200000000                /*  -EOF-  */
101300000000
101400000000     /*-------------------------------------------------------------*/
101500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0017                    */
101600000000     /* Page avant                                                  */
101700000000     /*-------------------------------------------------------------*/
101800000000
101900000000             RMVMSGD MSGID(KEY0017) MSGF(&LIB/&OBJ)
102000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
102100000000
102200000000             ADDMSGD +
102300000000                MSGID(KEY0017) +
102400000000                MSGF(&LIB/&OBJ) +
102500000000                MSG( +
102600000000'Page avant    '                                                      +
102700000000                ) +
102800000000                SEV(0) +
102900000000     /*   No replacement variables defined!                         */ +
103000000000                ALROPT(*NO) +
103100000000                CCSID(65535) +
103200000000                /*  -EOF-  */
103300000000
103400000000     /*-------------------------------------------------------------*/
103500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0018                    */
103600000000     /* Page arriüre                                                */
103700000000     /*-------------------------------------------------------------*/
103800000000
103900000000             RMVMSGD MSGID(KEY0018) MSGF(&LIB/&OBJ)
104000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
104100000000
104200000000             ADDMSGD +
104300000000                MSGID(KEY0018) +
104400000000                MSGF(&LIB/&OBJ) +
104500000000                MSG( +
104600000000'Page arriüre  '                                                      +
104700000000                ) +
104800000000                SEV(0) +
104900000000     /*   No replacement variables defined!                         */ +
105000000000                ALROPT(*NO) +
105100000000                CCSID(65535) +
105200000000                /*  -EOF-  */
105300000000
105400000000     /*-------------------------------------------------------------*/
105500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0019                    */
105600000000     /* Fixer ligne                                                 */
105700000000     /*-------------------------------------------------------------*/
105800000000
105900000000             RMVMSGD MSGID(KEY0019) MSGF(&LIB/&OBJ)
106000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
106100000000
106200000000             ADDMSGD +
106300000000                MSGID(KEY0019) +
106400000000                MSGF(&LIB/&OBJ) +
106500000000                MSG( +
106600000000'Fixer ligne'                                                         +
106700000000                ) +
106800000000                SEV(0) +
106900000000     /*   No replacement variables defined!                         */ +
107000000000                ALROPT(*NO) +
107100000000                CCSID(65535) +
107200000000                /*  -EOF-  */
107300000000
107400000000     /*-------------------------------------------------------------*/
107500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0020                    */
107600000000     /* Däfixer ligne                                               */
107700000000     /*-------------------------------------------------------------*/
107800000000
107900000000             RMVMSGD MSGID(KEY0020) MSGF(&LIB/&OBJ)
108000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
108100000000
108200000000             ADDMSGD +
108300000000                MSGID(KEY0020) +
108400000000                MSGF(&LIB/&OBJ) +
108500000000                MSG( +
108600000000'Däfixer ligne'                                                       +
108700000000                ) +
108800000000                SEV(0) +
108900000000     /*   No replacement variables defined!                         */ +
109000000000                ALROPT(*NO) +
109100000000                CCSID(65535) +
109200000000                /*  -EOF-  */
109300000000
109400000000     /*-------------------------------------------------------------*/
109500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0021                    */
109600000000     /* Modifier                                                    */
109700000000     /*-------------------------------------------------------------*/
109800000000
109900000000             RMVMSGD MSGID(KEY0021) MSGF(&LIB/&OBJ)
110000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
110100000000
110200000000             ADDMSGD +
110300000000                MSGID(KEY0021) +
110400000000                MSGF(&LIB/&OBJ) +
110500000000                MSG( +
110600000000'Modifier      '                                                      +
110700000000                ) +
110800000000                SEV(0) +
110900000000     /*   No replacement variables defined!                         */ +
111000000000                ALROPT(*NO) +
111100000000                CCSID(65535) +
111200000000                /*  -EOF-  */
111300000000
111400000000     /*-------------------------------------------------------------*/
111500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0022                    */
111600000000     /* Dupliquer                                                   */
111700000000     /*-------------------------------------------------------------*/
111800000000
111900000000             RMVMSGD MSGID(KEY0022) MSGF(&LIB/&OBJ)
112000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
112100000000
112200000000             ADDMSGD +
112300000000                MSGID(KEY0022) +
112400000000                MSGF(&LIB/&OBJ) +
112500000000                MSG( +
112600000000'Dupliquer     '                                                      +
112700000000                ) +
112800000000                SEV(0) +
112900000000     /*   No replacement variables defined!                         */ +
113000000000                ALROPT(*NO) +
113100000000                CCSID(65535) +
113200000000                /*  -EOF-  */
113300000000
113400000000     /*-------------------------------------------------------------*/
113500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0023                    */
113600000000     /* Supprimer                                                   */
113700000000     /*-------------------------------------------------------------*/
113800000000
113900000000             RMVMSGD MSGID(KEY0023) MSGF(&LIB/&OBJ)
114000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
114100000000
114200000000             ADDMSGD +
114300000000                MSGID(KEY0023) +
114400000000                MSGF(&LIB/&OBJ) +
114500000000                MSG( +
114600000000'Supprimer     '                                                      +
114700000000                ) +
114800000000                SEV(0) +
114900000000     /*   No replacement variables defined!                         */ +
115000000000                ALROPT(*NO) +
115100000000                CCSID(65535) +
115200000000                /*  -EOF-  */
115300000000
115400000000     /*-------------------------------------------------------------*/
115500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0024                    */
115600000000     /* Afficher                                                    */
115700000000     /*-------------------------------------------------------------*/
115800000000
115900000000             RMVMSGD MSGID(KEY0024) MSGF(&LIB/&OBJ)
116000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
116100000000
116200000000             ADDMSGD +
116300000000                MSGID(KEY0024) +
116400000000                MSGF(&LIB/&OBJ) +
116500000000                MSG( +
116600000000'Afficher      '                                                      +
116700000000                ) +
116800000000                SEV(0) +
116900000000     /*   No replacement variables defined!                         */ +
117000000000                ALROPT(*NO) +
117100000000                CCSID(65535) +
117200000000                /*  -EOF-  */
117300000000
117400000000     /*-------------------------------------------------------------*/
117500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0025                    */
117600000000     /* Paramätrages                                                */
117700000000     /*-------------------------------------------------------------*/
117800000000
117900000000             RMVMSGD MSGID(KEY0025) MSGF(&LIB/&OBJ)
118000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
118100000000
118200000000             ADDMSGD +
118300000000                MSGID(KEY0025) +
118400000000                MSGF(&LIB/&OBJ) +
118500000000                MSG( +
118600000000'Paramätrages  '                                                      +
118700000000                ) +
118800000000                SEV(0) +
118900000000     /*   No replacement variables defined!                         */ +
119000000000                ALROPT(*NO) +
119100000000                CCSID(65535) +
119200000000                /*  -EOF-  */
119300000000
119400000000     /*-------------------------------------------------------------*/
119500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0026                    */
119600000000     /* Abandonner                                                  */
119700000000     /*-------------------------------------------------------------*/
119800000000
119900000000             RMVMSGD MSGID(KEY0026) MSGF(&LIB/&OBJ)
120000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
120100000000
120200000000             ADDMSGD +
120300000000                MSGID(KEY0026) +
120400000000                MSGF(&LIB/&OBJ) +
120500000000                MSG( +
120600000000'Abandonner    '                                                      +
120700000000                ) +
120800000000                SEV(0) +
120900000000     /*   No replacement variables defined!                         */ +
121000000000                ALROPT(*NO) +
121100000000                CCSID(65535) +
121200000000                /*  -EOF-  */
121300000000
121400000000     /*-------------------------------------------------------------*/
121500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0027                    */
121600000000     /* Enreg. & quitter                                            */
121700000000     /*-------------------------------------------------------------*/
121800000000
121900000000             RMVMSGD MSGID(KEY0027) MSGF(&LIB/&OBJ)
122000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
122100000000
122200000000             ADDMSGD +
122300000000                MSGID(KEY0027) +
122400000000                MSGF(&LIB/&OBJ) +
122500000000                MSG( +
122600000000'Enreg. & quitter'                                                    +
122700000000                ) +
122800000000                SEV(0) +
122900000000     /*   No replacement variables defined!                         */ +
123000000000                ALROPT(*NO) +
123100000000                CCSID(65535) +
123200000000                /*  -EOF-  */
123300000000
123400000000     /*-------------------------------------------------------------*/
123500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0028                    */
123600000000     /* Fixer col.                                                  */
123700000000     /*-------------------------------------------------------------*/
123800000000
123900000000             RMVMSGD MSGID(KEY0028) MSGF(&LIB/&OBJ)
124000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
124100000000
124200000000             ADDMSGD +
124300000000                MSGID(KEY0028) +
124400000000                MSGF(&LIB/&OBJ) +
124500000000                MSG( +
124600000000'Fixer col.'                                                          +
124700000000                ) +
124800000000                SEV(0) +
124900000000     /*   No replacement variables defined!                         */ +
125000000000                ALROPT(*NO) +
125100000000                CCSID(65535) +
125200000000                /*  -EOF-  */
125300000000
125400000000     /*-------------------------------------------------------------*/
125500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0029                    */
125600000000     /* Däfixer col.                                                */
125700000000     /*-------------------------------------------------------------*/
125800000000
125900000000             RMVMSGD MSGID(KEY0029) MSGF(&LIB/&OBJ)
126000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
126100000000
126200000000             ADDMSGD +
126300000000                MSGID(KEY0029) +
126400000000                MSGF(&LIB/&OBJ) +
126500000000                MSG( +
126600000000'Däfixer col.'                                                        +
126700000000                ) +
126800000000                SEV(0) +
126900000000     /*   No replacement variables defined!                         */ +
127000000000                ALROPT(*NO) +
127100000000                CCSID(65535) +
127200000000                /*  -EOF-  */
127300000000
127400000000     /*-------------------------------------------------------------*/
127500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0030                    */
127600000000     /* Fixer col. +/-                                              */
127700000000     /*-------------------------------------------------------------*/
127800000000
127900000000             RMVMSGD MSGID(KEY0030) MSGF(&LIB/&OBJ)
128000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
128100000000
128200000000             ADDMSGD +
128300000000                MSGID(KEY0030) +
128400000000                MSGF(&LIB/&OBJ) +
128500000000                MSG( +
128600000000'Fixer col. +/-'                                                      +
128700000000                ) +
128800000000                SEV(0) +
128900000000     /*   No replacement variables defined!                         */ +
129000000000                ALROPT(*NO) +
129100000000                CCSID(65535) +
129200000000                /*  -EOF-  */
129300000000
129400000000     /*-------------------------------------------------------------*/
129500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0031                    */
129600000000     /* Lig. en couleur                                             */
129700000000     /*-------------------------------------------------------------*/
129800000000
129900000000             RMVMSGD MSGID(KEY0031) MSGF(&LIB/&OBJ)
130000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
130100000000
130200000000             ADDMSGD +
130300000000                MSGID(KEY0031) +
130400000000                MSGF(&LIB/&OBJ) +
130500000000                MSG( +
130600000000'Lig. en couleur'                                                     +
130700000000                ) +
130800000000                SEV(0) +
130900000000     /*   No replacement variables defined!                         */ +
131000000000                ALROPT(*NO) +
131100000000                CCSID(65535) +
131200000000                /*  -EOF-  */
131300000000
131400000000     /*-------------------------------------------------------------*/
131500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0032                    */
131600000000     /* Lig. monochrome                                             */
131700000000     /*-------------------------------------------------------------*/
131800000000
131900000000             RMVMSGD MSGID(KEY0032) MSGF(&LIB/&OBJ)
132000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
132100000000
132200000000             ADDMSGD +
132300000000                MSGID(KEY0032) +
132400000000                MSGF(&LIB/&OBJ) +
132500000000                MSG( +
132600000000'Lig. monochrome'                                                     +
132700000000                ) +
132800000000                SEV(0) +
132900000000     /*   No replacement variables defined!                         */ +
133000000000                ALROPT(*NO) +
133100000000                CCSID(65535) +
133200000000                /*  -EOF-  */
133300000000
133400000000     /*-------------------------------------------------------------*/
133500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0033                    */
133600000000     /* Couleur/mono.                                               */
133700000000     /*-------------------------------------------------------------*/
133800000000
133900000000             RMVMSGD MSGID(KEY0033) MSGF(&LIB/&OBJ)
134000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
134100000000
134200000000             ADDMSGD +
134300000000                MSGID(KEY0033) +
134400000000                MSGF(&LIB/&OBJ) +
134500000000                MSG( +
134600000000'Couleur/mono.'                                                       +
134700000000                ) +
134800000000                SEV(0) +
134900000000     /*   No replacement variables defined!                         */ +
135000000000                ALROPT(*NO) +
135100000000                CCSID(65535) +
135200000000                /*  -EOF-  */
135300000000
135400000000     /*-------------------------------------------------------------*/
135500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0034                    */
135600000000     /* Tous                                                        */
135700000000     /*-------------------------------------------------------------*/
135800000000
135900000000             RMVMSGD MSGID(KEY0034) MSGF(&LIB/&OBJ)
136000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
136100000000
136200000000             ADDMSGD +
136300000000                MSGID(KEY0034) +
136400000000                MSGF(&LIB/&OBJ) +
136500000000                MSG( +
136600000000'Tous          '                                                      +
136700000000                ) +
136800000000                SEV(0) +
136900000000     /*   No replacement variables defined!                         */ +
137000000000                ALROPT(*NO) +
137100000000                CCSID(65535) +
137200000000                /*  -EOF-  */
137300000000
137400000000     /*-------------------------------------------------------------*/
137500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0035                    */
137600000000     /* Plus d'options                                              */
137700000000     /*-------------------------------------------------------------*/
137800000000
137900000000             RMVMSGD MSGID(KEY0035) MSGF(&LIB/&OBJ)
138000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
138100000000
138200000000             ADDMSGD +
138300000000                MSGID(KEY0035) +
138400000000                MSGF(&LIB/&OBJ) +
138500000000                MSG( +
138600000000'Plus d''options'                                                     +
138700000000                ) +
138800000000                SEV(0) +
138900000000     /*   No replacement variables defined!                         */ +
139000000000                ALROPT(*NO) +
139100000000                CCSID(65535) +
139200000000                /*  -EOF-  */
139300000000
139400000000     /*-------------------------------------------------------------*/
139500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0036                    */
139600000000     /* Copier vers                                                 */
139700000000     /*-------------------------------------------------------------*/
139800000000
139900000000             RMVMSGD MSGID(KEY0036) MSGF(&LIB/&OBJ)
140000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
140100000000
140200000000             ADDMSGD +
140300000000                MSGID(KEY0036) +
140400000000                MSGF(&LIB/&OBJ) +
140500000000                MSG( +
140600000000'Copier vers   '                                                      +
140700000000                ) +
140800000000                SEV(0) +
140900000000     /*   No replacement variables defined!                         */ +
141000000000                ALROPT(*NO) +
141100000000                CCSID(65535) +
141200000000                /*  -EOF-  */
141300000000
141400000000     /*-------------------------------------------------------------*/
141500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0037                    */
141600000000     /* Sälect. champ                                               */
141700000000     /*-------------------------------------------------------------*/
141800000000
141900000000             RMVMSGD MSGID(KEY0037) MSGF(&LIB/&OBJ)
142000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
142100000000
142200000000             ADDMSGD +
142300000000                MSGID(KEY0037) +
142400000000                MSGF(&LIB/&OBJ) +
142500000000                MSG( +
142600000000'Sälect. champ'                                                       +
142700000000                ) +
142800000000                SEV(0) +
142900000000     /*   No replacement variables defined!                         */ +
143000000000                ALROPT(*NO) +
143100000000                CCSID(65535) +
143200000000                /*  -EOF-  */
143300000000
143400000000     /*-------------------------------------------------------------*/
143500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0038                    */
143600000000     /* Libärer champ                                               */
143700000000     /*-------------------------------------------------------------*/
143800000000
143900000000             RMVMSGD MSGID(KEY0038) MSGF(&LIB/&OBJ)
144000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
144100000000
144200000000             ADDMSGD +
144300000000                MSGID(KEY0038) +
144400000000                MSGF(&LIB/&OBJ) +
144500000000                MSG( +
144600000000'Libärer champ'                                                       +
144700000000                ) +
144800000000                SEV(0) +
144900000000     /*   No replacement variables defined!                         */ +
145000000000                ALROPT(*NO) +
145100000000                CCSID(65535) +
145200000000                /*  -EOF-  */
145300000000
145400000000     /*-------------------------------------------------------------*/
145500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0039                    */
145600000000     /* Minuscule                                                   */
145700000000     /*-------------------------------------------------------------*/
145800000000
145900000000             RMVMSGD MSGID(KEY0039) MSGF(&LIB/&OBJ)
146000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
146100000000
146200000000             ADDMSGD +
146300000000                MSGID(KEY0039) +
146400000000                MSGF(&LIB/&OBJ) +
146500000000                MSG( +
146600000000'Minuscule '                                                          +
146700000000                ) +
146800000000                SEV(0) +
146900000000     /*   No replacement variables defined!                         */ +
147000000000                ALROPT(*NO) +
147100000000                CCSID(65535) +
147200000000                /*  -EOF-  */
147300000000
147400000000     /*-------------------------------------------------------------*/
147500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0040                    */
147600000000     /* Majuscule                                                   */
147700000000     /*-------------------------------------------------------------*/
147800000000
147900000000             RMVMSGD MSGID(KEY0040) MSGF(&LIB/&OBJ)
148000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
148100000000
148200000000             ADDMSGD +
148300000000                MSGID(KEY0040) +
148400000000                MSGF(&LIB/&OBJ) +
148500000000                MSG( +
148600000000'Majuscule '                                                          +
148700000000                ) +
148800000000                SEV(0) +
148900000000     /*   No replacement variables defined!                         */ +
149000000000                ALROPT(*NO) +
149100000000                CCSID(65535) +
149200000000                /*  -EOF-  */
149300000000
149400000000     /*-------------------------------------------------------------*/
149500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0041                    */
149600000000     /* Maj. / Min.                                                 */
149700000000     /*-------------------------------------------------------------*/
149800000000
149900000000             RMVMSGD MSGID(KEY0041) MSGF(&LIB/&OBJ)
150000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
150100000000
150200000000             ADDMSGD +
150300000000                MSGID(KEY0041) +
150400000000                MSGF(&LIB/&OBJ) +
150500000000                MSG( +
150600000000'Maj. / Min.'                                                         +
150700000000                ) +
150800000000                SEV(0) +
150900000000     /*   No replacement variables defined!                         */ +
151000000000                ALROPT(*NO) +
151100000000                CCSID(65535) +
151200000000                /*  -EOF-  */
151300000000
151400000000     /*-------------------------------------------------------------*/
151500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0042                    */
151600000000     /* Page d'accueil                                              */
151700000000     /*-------------------------------------------------------------*/
151800000000
151900000000             RMVMSGD MSGID(KEY0042) MSGF(&LIB/&OBJ)
152000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
152100000000
152200000000             ADDMSGD +
152300000000                MSGID(KEY0042) +
152400000000                MSGF(&LIB/&OBJ) +
152500000000                MSG( +
152600000000'Page d''accueil'                                                     +
152700000000                ) +
152800000000                SEV(0) +
152900000000     /*   No replacement variables defined!                         */ +
153000000000                ALROPT(*NO) +
153100000000                CCSID(65535) +
153200000000                /*  -EOF-  */
153300000000
153400000000     /*-------------------------------------------------------------*/
153500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0043                    */
153600000000     /* Pas de page                                                 */
153700000000     /*-------------------------------------------------------------*/
153800000000
153900000000             RMVMSGD MSGID(KEY0043) MSGF(&LIB/&OBJ)
154000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
154100000000
154200000000             ADDMSGD +
154300000000                MSGID(KEY0043) +
154400000000                MSGF(&LIB/&OBJ) +
154500000000                MSG( +
154600000000'Pas de page'                                                         +
154700000000                ) +
154800000000                SEV(0) +
154900000000     /*   No replacement variables defined!                         */ +
155000000000                ALROPT(*NO) +
155100000000                CCSID(65535) +
155200000000                /*  -EOF-  */
155300000000
155400000000     /*-------------------------------------------------------------*/
155500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0044                    */
155600000000     /* Page gauche                                                 */
155700000000     /*-------------------------------------------------------------*/
155800000000
155900000000             RMVMSGD MSGID(KEY0044) MSGF(&LIB/&OBJ)
156000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
156100000000
156200000000             ADDMSGD +
156300000000                MSGID(KEY0044) +
156400000000                MSGF(&LIB/&OBJ) +
156500000000                MSG( +
156600000000'Page gauche'                                                         +
156700000000                ) +
156800000000                SEV(0) +
156900000000     /*   No replacement variables defined!                         */ +
157000000000                ALROPT(*NO) +
157100000000                CCSID(65535) +
157200000000                /*  -EOF-  */
157300000000
157400000000     /*-------------------------------------------------------------*/
157500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0045                    */
157600000000     /* Page droite                                                 */
157700000000     /*-------------------------------------------------------------*/
157800000000
157900000000             RMVMSGD MSGID(KEY0045) MSGF(&LIB/&OBJ)
158000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
158100000000
158200000000             ADDMSGD +
158300000000                MSGID(KEY0045) +
158400000000                MSGF(&LIB/&OBJ) +
158500000000                MSG( +
158600000000'Page droite'                                                         +
158700000000                ) +
158800000000                SEV(0) +
158900000000     /*   No replacement variables defined!                         */ +
159000000000                ALROPT(*NO) +
159100000000                CCSID(65535) +
159200000000                /*  -EOF-  */
159300000000
159400000000     /*-------------------------------------------------------------*/
159500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0046                    */
159600000000     /* Repäter                                                     */
159700000000     /*-------------------------------------------------------------*/
159800000000
159900000000             RMVMSGD MSGID(KEY0046) MSGF(&LIB/&OBJ)
160000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
160100000000
160200000000             ADDMSGD +
160300000000                MSGID(KEY0046) +
160400000000                MSGF(&LIB/&OBJ) +
160500000000                MSG( +
160600000000'Repäter'                                                             +
160700000000                ) +
160800000000                SEV(0) +
160900000000     /*   No replacement variables defined!                         */ +
161000000000                ALROPT(*NO) +
161100000000                CCSID(65535) +
161200000000                /*  -EOF-  */
161300000000
161400000000     /*-------------------------------------------------------------*/
161500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0047                    */
161600000000     /* Reconstruire                                                */
161700000000     /*-------------------------------------------------------------*/
161800000000
161900000000             RMVMSGD MSGID(KEY0047) MSGF(&LIB/&OBJ)
162000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
162100000000
162200000000             ADDMSGD +
162300000000                MSGID(KEY0047) +
162400000000                MSGF(&LIB/&OBJ) +
162500000000                MSG( +
162600000000'Reconstruire'                                                        +
162700000000                ) +
162800000000                SEV(0) +
162900000000     /*   No replacement variables defined!                         */ +
163000000000                ALROPT(*NO) +
163100000000                CCSID(65535) +
163200000000                /*  -EOF-  */
163300000000
163400000000     /*-------------------------------------------------------------*/
163500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0048                    */
163600000000     /* Däfixer toutes les lignes                                   */
163700000000     /*-------------------------------------------------------------*/
163800000000
163900000000             RMVMSGD MSGID(KEY0048) MSGF(&LIB/&OBJ)
164000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
164100000000
164200000000             ADDMSGD +
164300000000                MSGID(KEY0048) +
164400000000                MSGF(&LIB/&OBJ) +
164500000000                MSG( +
164600000000'Däfixer toutes les lignes'                                           +
164700000000                ) +
164800000000                SEV(0) +
164900000000     /*   No replacement variables defined!                         */ +
165000000000                ALROPT(*NO) +
165100000000                CCSID(65535) +
165200000000                /*  -EOF-  */
165300000000
165400000000     /*-------------------------------------------------------------*/
165500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0049                    */
165600000000     /* Däfixer toutes les colonnes                                 */
165700000000     /*-------------------------------------------------------------*/
165800000000
165900000000             RMVMSGD MSGID(KEY0049) MSGF(&LIB/&OBJ)
166000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
166100000000
166200000000             ADDMSGD +
166300000000                MSGID(KEY0049) +
166400000000                MSGF(&LIB/&OBJ) +
166500000000                MSG( +
166600000000'Däfixer toutes les colonnes'                                         +
166700000000                ) +
166800000000                SEV(0) +
166900000000     /*   No replacement variables defined!                         */ +
167000000000                ALROPT(*NO) +
167100000000                CCSID(65535) +
167200000000                /*  -EOF-  */
167300000000
167400000000     /*-------------------------------------------------------------*/
167500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0050                    */
167600000000     /* Maquette                                                    */
167700000000     /*-------------------------------------------------------------*/
167800000000
167900000000             RMVMSGD MSGID(KEY0050) MSGF(&LIB/&OBJ)
168000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
168100000000
168200000000             ADDMSGD +
168300000000                MSGID(KEY0050) +
168400000000                MSGF(&LIB/&OBJ) +
168500000000                MSG( +
168600000000'Maquette'                                                            +
168700000000                ) +
168800000000                SEV(0) +
168900000000     /*   No replacement variables defined!                         */ +
169000000000                ALROPT(*NO) +
169100000000                CCSID(65535) +
169200000000                /*  -EOF-  */
169300000000
169400000000     /*-------------------------------------------------------------*/
169500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0051                    */
169600000000     /* Touches flott.                                              */
169700000000     /*-------------------------------------------------------------*/
169800000000
169900000000             RMVMSGD MSGID(KEY0051) MSGF(&LIB/&OBJ)
170000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
170100000000
170200000000             ADDMSGD +
170300000000                MSGID(KEY0051) +
170400000000                MSGF(&LIB/&OBJ) +
170500000000                MSG( +
170600000000'Touches flott.'                                                      +
170700000000                ) +
170800000000                SEV(0) +
170900000000     /*   No replacement variables defined!                         */ +
171000000000                ALROPT(*NO) +
171100000000                CCSID(65535) +
171200000000                /*  -EOF-  */
171300000000
171400000000     /*-------------------------------------------------------------*/
171500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0052                    */
171600000000     /* Sälectionner                                                */
171700000000     /*-------------------------------------------------------------*/
171800000000
171900000000             RMVMSGD MSGID(KEY0052) MSGF(&LIB/&OBJ)
172000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
172100000000
172200000000             ADDMSGD +
172300000000                MSGID(KEY0052) +
172400000000                MSGF(&LIB/&OBJ) +
172500000000                MSG( +
172600000000'Sälectionner'                                                        +
172700000000                ) +
172800000000                SEV(0) +
172900000000     /*   No replacement variables defined!                         */ +
173000000000                ALROPT(*NO) +
173100000000                CCSID(65535) +
173200000000                /*  -EOF-  */
173300000000
173400000000     /*-------------------------------------------------------------*/
173500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0053                    */
173600000000     /* Sälection suivante                                          */
173700000000     /*-------------------------------------------------------------*/
173800000000
173900000000             RMVMSGD MSGID(KEY0053) MSGF(&LIB/&OBJ)
174000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
174100000000
174200000000             ADDMSGD +
174300000000                MSGID(KEY0053) +
174400000000                MSGF(&LIB/&OBJ) +
174500000000                MSG( +
174600000000'Sälection suivante'                                                  +
174700000000                ) +
174800000000                SEV(0) +
174900000000     /*   No replacement variables defined!                         */ +
175000000000                ALROPT(*NO) +
175100000000                CCSID(65535) +
175200000000                /*  -EOF-  */
175300000000
175400000000     /*-------------------------------------------------------------*/
175500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0054                    */
175600000000     /* Sälection präcädente                                        */
175700000000     /*-------------------------------------------------------------*/
175800000000
175900000000             RMVMSGD MSGID(KEY0054) MSGF(&LIB/&OBJ)
176000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
176100000000
176200000000             ADDMSGD +
176300000000                MSGID(KEY0054) +
176400000000                MSGF(&LIB/&OBJ) +
176500000000                MSG( +
176600000000'Sälection präcädente'                                                +
176700000000                ) +
176800000000                SEV(0) +
176900000000     /*   No replacement variables defined!                         */ +
177000000000                ALROPT(*NO) +
177100000000                CCSID(65535) +
177200000000                /*  -EOF-  */
177300000000
177400000000     /*-------------------------------------------------------------*/
177500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0055                    */
177600000000     /* Relations                                                   */
177700000000     /*-------------------------------------------------------------*/
177800000000
177900000000             RMVMSGD MSGID(KEY0055) MSGF(&LIB/&OBJ)
178000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
178100000000
178200000000             ADDMSGD +
178300000000                MSGID(KEY0055) +
178400000000                MSGF(&LIB/&OBJ) +
178500000000                MSG( +
178600000000'Relations'                                                           +
178700000000                ) +
178800000000                SEV(0) +
178900000000     /*   No replacement variables defined!                         */ +
179000000000                ALROPT(*NO) +
179100000000                CCSID(65535) +
179200000000                /*  -EOF-  */
179300000000
179400000000     /*-------------------------------------------------------------*/
179500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0056                    */
179600000000     /* Guide                                                       */
179700000000     /*-------------------------------------------------------------*/
179800000000
179900000000             RMVMSGD MSGID(KEY0056) MSGF(&LIB/&OBJ)
180000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
180100000000
180200000000             ADDMSGD +
180300000000                MSGID(KEY0056) +
180400000000                MSGF(&LIB/&OBJ) +
180500000000                MSG( +
180600000000'Guide '                                                              +
180700000000                ) +
180800000000                SEV(0) +
180900000000     /*   No replacement variables defined!                         */ +
181000000000                ALROPT(*NO) +
181100000000                CCSID(65535) +
181200000000                /*  -EOF-  */
181300000000
181400000000     /*-------------------------------------------------------------*/
181500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0057                    */
181600000000     /* Ordre clä                                                   */
181700000000     /*-------------------------------------------------------------*/
181800000000
181900000000             RMVMSGD MSGID(KEY0057) MSGF(&LIB/&OBJ)
182000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
182100000000
182200000000             ADDMSGD +
182300000000                MSGID(KEY0057) +
182400000000                MSGF(&LIB/&OBJ) +
182500000000                MSG( +
182600000000'Ordre clä'                                                           +
182700000000                ) +
182800000000                SEV(0) +
182900000000     /*   No replacement variables defined!                         */ +
183000000000                ALROPT(*NO) +
183100000000                CCSID(65535) +
183200000000                /*  -EOF-  */
183300000000
183400000000     /*-------------------------------------------------------------*/
183500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0058                    */
183600000000     /* Ordre enreg.                                                */
183700000000     /*-------------------------------------------------------------*/
183800000000
183900000000             RMVMSGD MSGID(KEY0058) MSGF(&LIB/&OBJ)
184000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
184100000000
184200000000             ADDMSGD +
184300000000                MSGID(KEY0058) +
184400000000                MSGF(&LIB/&OBJ) +
184500000000                MSG( +
184600000000'Ordre enreg.'                                                        +
184700000000                ) +
184800000000                SEV(0) +
184900000000     /*   No replacement variables defined!                         */ +
185000000000                ALROPT(*NO) +
185100000000                CCSID(65535) +
185200000000                /*  -EOF-  */
185300000000
185400000000     /*-------------------------------------------------------------*/
185500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0059                    */
185600000000     /* Tri Clef/NÄenregistrement                                   */
185700000000     /*-------------------------------------------------------------*/
185800000000
185900000000             RMVMSGD MSGID(KEY0059) MSGF(&LIB/&OBJ)
186000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
186100000000
186200000000             ADDMSGD +
186300000000                MSGID(KEY0059) +
186400000000                MSGF(&LIB/&OBJ) +
186500000000                MSG( +
186600000000'Tri Clef/NÄenregistrement'                                           +
186700000000                ) +
186800000000                SEV(0) +
186900000000     /*   No replacement variables defined!                         */ +
187000000000                ALROPT(*NO) +
187100000000                CCSID(65535) +
187200000000                /*  -EOF-  */
187300000000
187400000000     /*-------------------------------------------------------------*/
187500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0060                    */
187600000000     /* Editeur Hexa                                                */
187700000000     /*-------------------------------------------------------------*/
187800000000
187900000000             RMVMSGD MSGID(KEY0060) MSGF(&LIB/&OBJ)
188000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
188100000000
188200000000             ADDMSGD +
188300000000                MSGID(KEY0060) +
188400000000                MSGF(&LIB/&OBJ) +
188500000000                MSG( +
188600000000'Editeur Hexa'                                                        +
188700000000                ) +
188800000000                SEV(0) +
188900000000     /*   No replacement variables defined!                         */ +
189000000000                ALROPT(*NO) +
189100000000                CCSID(65535) +
189200000000                /*  -EOF-  */
189300000000
189400000000     /*-------------------------------------------------------------*/
189500000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0061                    */
189600000000     /* Infos                                                       */
189700000000     /*-------------------------------------------------------------*/
189800000000
189900000000             RMVMSGD MSGID(KEY0061) MSGF(&LIB/&OBJ)
190000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
190100000000
190200000000             ADDMSGD +
190300000000                MSGID(KEY0061) +
190400000000                MSGF(&LIB/&OBJ) +
190500000000                MSG( +
190600000000'Infos'                                                               +
190700000000                ) +
190800000000                SECLVL( +
190900000000'À propos de'                                                         +
191000000000                ) +
191100000000                SEV(0) +
191200000000     /*   No replacement variables defined!                         */ +
191300000000                ALROPT(*NO) +
191400000000                CCSID(65535) +
191500000000                /*  -EOF-  */
191600000000
191700000000     /*-------------------------------------------------------------*/
191800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0062                    */
191900000000     /* Fixer champs                                                */
192000000000     /*-------------------------------------------------------------*/
192100000000
192200000000             RMVMSGD MSGID(KEY0062) MSGF(&LIB/&OBJ)
192300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
192400000000
192500000000             ADDMSGD +
192600000000                MSGID(KEY0062) +
192700000000                MSGF(&LIB/&OBJ) +
192800000000                MSG( +
192900000000'Fixer champs'                                                        +
193000000000                ) +
193100000000                SEV(0) +
193200000000     /*   No replacement variables defined!                         */ +
193300000000                ALROPT(*NO) +
193400000000                CCSID(65535) +
193500000000                /*  -EOF-  */
193600000000
193700000000     /*-------------------------------------------------------------*/
193800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0063                    */
193900000000     /* Efface tout                                                 */
194000000000     /*-------------------------------------------------------------*/
194100000000
194200000000             RMVMSGD MSGID(KEY0063) MSGF(&LIB/&OBJ)
194300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
194400000000
194500000000             ADDMSGD +
194600000000                MSGID(KEY0063) +
194700000000                MSGF(&LIB/&OBJ) +
194800000000                MSG( +
194900000000'Efface tout'                                                         +
195000000000                ) +
195100000000                SEV(0) +
195200000000     /*   No replacement variables defined!                         */ +
195300000000                ALROPT(*NO) +
195400000000                CCSID(65535) +
195500000000                /*  -EOF-  */
195600000000
195700000000     /*-------------------------------------------------------------*/
195800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0064                    */
195900000000     /* Affichage normal                                            */
196000000000     /*-------------------------------------------------------------*/
196100000000
196200000000             RMVMSGD MSGID(KEY0064) MSGF(&LIB/&OBJ)
196300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
196400000000
196500000000             ADDMSGD +
196600000000                MSGID(KEY0064) +
196700000000                MSGF(&LIB/&OBJ) +
196800000000                MSG( +
196900000000'Affichage normal'                                                    +
197000000000                ) +
197100000000                SEV(0) +
197200000000     /*   No replacement variables defined!                         */ +
197300000000                ALROPT(*NO) +
197400000000                CCSID(65535) +
197500000000                /*  -EOF-  */
197600000000
197700000000     /*-------------------------------------------------------------*/
197800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0065                    */
197900000000     /* Affichage hexa                                              */
198000000000     /*-------------------------------------------------------------*/
198100000000
198200000000             RMVMSGD MSGID(KEY0065) MSGF(&LIB/&OBJ)
198300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
198400000000
198500000000             ADDMSGD +
198600000000                MSGID(KEY0065) +
198700000000                MSGF(&LIB/&OBJ) +
198800000000                MSG( +
198900000000'Affichage hexa'                                                      +
199000000000                ) +
199100000000                SEV(0) +
199200000000     /*   No replacement variables defined!                         */ +
199300000000                ALROPT(*NO) +
199400000000                CCSID(65535) +
199500000000                /*  -EOF-  */
199600000000
199700000000     /*-------------------------------------------------------------*/
199800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0066                    */
199900000000     /* Hexa/car.                                                   */
200000000000     /*-------------------------------------------------------------*/
200100000000
200200000000             RMVMSGD MSGID(KEY0066) MSGF(&LIB/&OBJ)
200300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
200400000000
200500000000             ADDMSGD +
200600000000                MSGID(KEY0066) +
200700000000                MSGF(&LIB/&OBJ) +
200800000000                MSG( +
200900000000'Hexa/car.'                                                           +
201000000000                ) +
201100000000                SEV(0) +
201200000000     /*   No replacement variables defined!                         */ +
201300000000                ALROPT(*NO) +
201400000000                CCSID(65535) +
201500000000                /*  -EOF-  */
201600000000
201700000000     /*-------------------------------------------------------------*/
201800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0067                    */
201900000000     /* Sälection SQL                                               */
202000000000     /*-------------------------------------------------------------*/
202100000000
202200000000             RMVMSGD MSGID(KEY0067) MSGF(&LIB/&OBJ)
202300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
202400000000
202500000000             ADDMSGD +
202600000000                MSGID(KEY0067) +
202700000000                MSGF(&LIB/&OBJ) +
202800000000                MSG( +
202900000000'Sälection SQL'                                                       +
203000000000                ) +
203100000000                SEV(0) +
203200000000     /*   No replacement variables defined!                         */ +
203300000000                ALROPT(*NO) +
203400000000                CCSID(65535) +
203500000000                /*  -EOF-  */
203600000000
203700000000     /*-------------------------------------------------------------*/
203800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0068                    */
203900000000     /* Ins.champs clef                                             */
204000000000     /*-------------------------------------------------------------*/
204100000000
204200000000             RMVMSGD MSGID(KEY0068) MSGF(&LIB/&OBJ)
204300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
204400000000
204500000000             ADDMSGD +
204600000000                MSGID(KEY0068) +
204700000000                MSGF(&LIB/&OBJ) +
204800000000                MSG( +
204900000000'Ins.champs clef'                                                     +
205000000000                ) +
205100000000                SEV(0) +
205200000000     /*   No replacement variables defined!                         */ +
205300000000                ALROPT(*NO) +
205400000000                CCSID(65535) +
205500000000                /*  -EOF-  */
205600000000
205700000000     /*-------------------------------------------------------------*/
205800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0069                    */
205900000000     /* Sauvegarde environnement                                    */
206000000000     /*-------------------------------------------------------------*/
206100000000
206200000000             RMVMSGD MSGID(KEY0069) MSGF(&LIB/&OBJ)
206300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
206400000000
206500000000             ADDMSGD +
206600000000                MSGID(KEY0069) +
206700000000                MSGF(&LIB/&OBJ) +
206800000000                MSG( +
206900000000'Sauvegarde environnement'                                            +
207000000000                ) +
207100000000                SEV(0) +
207200000000     /*   No replacement variables defined!                         */ +
207300000000                ALROPT(*NO) +
207400000000                CCSID(65535) +
207500000000                /*  -EOF-  */
207600000000
207700000000     /*-------------------------------------------------------------*/
207800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0070                    */
207900000000     /* Charge environnement                                        */
208000000000     /*-------------------------------------------------------------*/
208100000000
208200000000             RMVMSGD MSGID(KEY0070) MSGF(&LIB/&OBJ)
208300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
208400000000
208500000000             ADDMSGD +
208600000000                MSGID(KEY0070) +
208700000000                MSGF(&LIB/&OBJ) +
208800000000                MSG( +
208900000000'Charge environnement'                                                +
209000000000                ) +
209100000000                SEV(0) +
209200000000     /*   No replacement variables defined!                         */ +
209300000000                ALROPT(*NO) +
209400000000                CCSID(65535) +
209500000000                /*  -EOF-  */
209600000000
209700000000     /*-------------------------------------------------------------*/
209800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0071                    */
209900000000     /* Supprime environnement                                      */
210000000000     /*-------------------------------------------------------------*/
210100000000
210200000000             RMVMSGD MSGID(KEY0071) MSGF(&LIB/&OBJ)
210300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
210400000000
210500000000             ADDMSGD +
210600000000                MSGID(KEY0071) +
210700000000                MSGF(&LIB/&OBJ) +
210800000000                MSG( +
210900000000'Supprime environnement'                                              +
211000000000                ) +
211100000000                SEV(0) +
211200000000     /*   No replacement variables defined!                         */ +
211300000000                ALROPT(*NO) +
211400000000                CCSID(65535) +
211500000000                /*  -EOF-  */
211600000000
211700000000     /*-------------------------------------------------------------*/
211800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0072                    */
211900000000     /* Säquence de tri                                             */
212000000000     /*-------------------------------------------------------------*/
212100000000
212200000000             RMVMSGD MSGID(KEY0072) MSGF(&LIB/&OBJ)
212300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
212400000000
212500000000             ADDMSGD +
212600000000                MSGID(KEY0072) +
212700000000                MSGF(&LIB/&OBJ) +
212800000000                MSG( +
212900000000'Säquence de tri'                                                     +
213000000000                ) +
213100000000                SEV(0) +
213200000000     /*   No replacement variables defined!                         */ +
213300000000                ALROPT(*NO) +
213400000000                CCSID(65535) +
213500000000                /*  -EOF-  */
213600000000
213700000000     /*-------------------------------------------------------------*/
213800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0073                    */
213900000000     /* Oui                                                         */
214000000000     /*-------------------------------------------------------------*/
214100000000
214200000000             RMVMSGD MSGID(KEY0073) MSGF(&LIB/&OBJ)
214300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
214400000000
214500000000             ADDMSGD +
214600000000                MSGID(KEY0073) +
214700000000                MSGF(&LIB/&OBJ) +
214800000000                MSG( +
214900000000'Oui'                                                                 +
215000000000                ) +
215100000000                SEV(0) +
215200000000     /*   No replacement variables defined!                         */ +
215300000000                ALROPT(*NO) +
215400000000                CCSID(65535) +
215500000000                /*  -EOF-  */
215600000000
215700000000     /*-------------------------------------------------------------*/
215800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0074                    */
215900000000     /* Non                                                         */
216000000000     /*-------------------------------------------------------------*/
216100000000
216200000000             RMVMSGD MSGID(KEY0074) MSGF(&LIB/&OBJ)
216300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
216400000000
216500000000             ADDMSGD +
216600000000                MSGID(KEY0074) +
216700000000                MSGF(&LIB/&OBJ) +
216800000000                MSG( +
216900000000'Non'                                                                 +
217000000000                ) +
217100000000                SEV(0) +
217200000000     /*   No replacement variables defined!                         */ +
217300000000                ALROPT(*NO) +
217400000000                CCSID(65535) +
217500000000                /*  -EOF-  */
217600000000
217700000000     /*-------------------------------------------------------------*/
217800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0075                    */
217900000000     /* OK                                                          */
218000000000     /*-------------------------------------------------------------*/
218100000000
218200000000             RMVMSGD MSGID(KEY0075) MSGF(&LIB/&OBJ)
218300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
218400000000
218500000000             ADDMSGD +
218600000000                MSGID(KEY0075) +
218700000000                MSGF(&LIB/&OBJ) +
218800000000                MSG( +
218900000000'OK'                                                                  +
219000000000                ) +
219100000000                SEV(0) +
219200000000     /*   No replacement variables defined!                         */ +
219300000000                ALROPT(*NO) +
219400000000                CCSID(65535) +
219500000000                /*  -EOF-  */
219600000000
219700000000     /*-------------------------------------------------------------*/
219800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0076                    */
219900000000     /* Prem. Pos.                                                  */
220000000000     /*-------------------------------------------------------------*/
220100000000
220200000000             RMVMSGD MSGID(KEY0076) MSGF(&LIB/&OBJ)
220300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
220400000000
220500000000             ADDMSGD +
220600000000                MSGID(KEY0076) +
220700000000                MSGF(&LIB/&OBJ) +
220800000000                MSG( +
220900000000'Prem. Pos.'                                                          +
221000000000                ) +
221100000000                SEV(0) +
221200000000     /*   No replacement variables defined!                         */ +
221300000000                ALROPT(*NO) +
221400000000                CCSID(65535) +
221500000000                /*  -EOF-  */
221600000000
221700000000     /*-------------------------------------------------------------*/
221800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0077                    */
221900000000     /* Dern. Pos.                                                  */
222000000000     /*-------------------------------------------------------------*/
222100000000
222200000000             RMVMSGD MSGID(KEY0077) MSGF(&LIB/&OBJ)
222300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
222400000000
222500000000             ADDMSGD +
222600000000                MSGID(KEY0077) +
222700000000                MSGF(&LIB/&OBJ) +
222800000000                MSG( +
222900000000'Dern. Pos.'                                                          +
223000000000                ) +
223100000000                SEV(0) +
223200000000     /*   No replacement variables defined!                         */ +
223300000000                ALROPT(*NO) +
223400000000                CCSID(65535) +
223500000000                /*  -EOF-  */
223600000000
223700000000     /*-------------------------------------------------------------*/
223800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0078                    */
223900000000     /* Environnement                                               */
224000000000     /*-------------------------------------------------------------*/
224100000000
224200000000             RMVMSGD MSGID(KEY0078) MSGF(&LIB/&OBJ)
224300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
224400000000
224500000000             ADDMSGD +
224600000000                MSGID(KEY0078) +
224700000000                MSGF(&LIB/&OBJ) +
224800000000                MSG( +
224900000000'Environnement'                                                       +
225000000000                ) +
225100000000                SEV(0) +
225200000000     /*   No replacement variables defined!                         */ +
225300000000                ALROPT(*NO) +
225400000000                CCSID(65535) +
225500000000                /*  -EOF-  */
225600000000
225700000000     /*-------------------------------------------------------------*/
225800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0079                    */
225900000000     /* Maquette seule                                              */
226000000000     /*-------------------------------------------------------------*/
226100000000
226200000000             RMVMSGD MSGID(KEY0079) MSGF(&LIB/&OBJ)
226300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
226400000000
226500000000             ADDMSGD +
226600000000                MSGID(KEY0079) +
226700000000                MSGF(&LIB/&OBJ) +
226800000000                MSG( +
226900000000'Maquette seule'                                                      +
227000000000                ) +
227100000000                SEV(0) +
227200000000     /*   No replacement variables defined!                         */ +
227300000000                ALROPT(*NO) +
227400000000                CCSID(65535) +
227500000000                /*  -EOF-  */
227600000000
227700000000     /*-------------------------------------------------------------*/
227800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0080                    */
227900000000     /* NULL acceptä                                                */
228000000000     /*-------------------------------------------------------------*/
228100000000
228200000000             RMVMSGD MSGID(KEY0080) MSGF(&LIB/&OBJ)
228300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
228400000000
228500000000             ADDMSGD +
228600000000                MSGID(KEY0080) +
228700000000                MSGF(&LIB/&OBJ) +
228800000000                MSG( +
228900000000'NULL acceptä'                                                        +
229000000000                ) +
229100000000                SEV(0) +
229200000000     /*   No replacement variables defined!                         */ +
229300000000                ALROPT(*NO) +
229400000000                CCSID(65535) +
229500000000                /*  -EOF-  */
229600000000
229700000000     /*-------------------------------------------------------------*/
229800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0081                    */
229900000000     /* Chg mode enträe                                             */
230000000000     /*-------------------------------------------------------------*/
230100000000
230200000000             RMVMSGD MSGID(KEY0081) MSGF(&LIB/&OBJ)
230300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
230400000000
230500000000             ADDMSGD +
230600000000                MSGID(KEY0081) +
230700000000                MSGF(&LIB/&OBJ) +
230800000000                MSG( +
230900000000'Chg mode enträe'                                                     +
231000000000                ) +
231100000000                SEV(0) +
231200000000     /*   No replacement variables defined!                         */ +
231300000000                ALROPT(*NO) +
231400000000                CCSID(65535) +
231500000000                /*  -EOF-  */
231600000000
231700000000     /*-------------------------------------------------------------*/
231800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0082                    */
231900000000     /* Edite chaine                                                */
232000000000     /*-------------------------------------------------------------*/
232100000000
232200000000             RMVMSGD MSGID(KEY0082) MSGF(&LIB/&OBJ)
232300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
232400000000
232500000000             ADDMSGD +
232600000000                MSGID(KEY0082) +
232700000000                MSGF(&LIB/&OBJ) +
232800000000                MSG( +
232900000000'Edite chaine'                                                        +
233000000000                ) +
233100000000                SEV(0) +
233200000000     /*   No replacement variables defined!                         */ +
233300000000                ALROPT(*NO) +
233400000000                CCSID(65535) +
233500000000                /*  -EOF-  */
233600000000
233700000000     /*-------------------------------------------------------------*/
233800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0083                    */
233900000000     /* Verrouillage                                                */
234000000000     /*-------------------------------------------------------------*/
234100000000
234200000000             RMVMSGD MSGID(KEY0083) MSGF(&LIB/&OBJ)
234300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
234400000000
234500000000             ADDMSGD +
234600000000                MSGID(KEY0083) +
234700000000                MSGF(&LIB/&OBJ) +
234800000000                MSG( +
234900000000'Verrouillage'                                                        +
235000000000                ) +
235100000000                SEV(0) +
235200000000     /*   No replacement variables defined!                         */ +
235300000000                ALROPT(*NO) +
235400000000                CCSID(65535) +
235500000000                /*  -EOF-  */
235600000000
235700000000     /*-------------------------------------------------------------*/
235800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0084                    */
235900000000     /* Min./maj.                                                   */
236000000000     /*-------------------------------------------------------------*/
236100000000
236200000000             RMVMSGD MSGID(KEY0084) MSGF(&LIB/&OBJ)
236300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
236400000000
236500000000             ADDMSGD +
236600000000                MSGID(KEY0084) +
236700000000                MSGF(&LIB/&OBJ) +
236800000000                MSG( +
236900000000'Min./maj.'                                                           +
237000000000                ) +
237100000000                SEV(0) +
237200000000     /*   No replacement variables defined!                         */ +
237300000000                ALROPT(*NO) +
237400000000                CCSID(65535) +
237500000000                /*  -EOF-  */
237600000000
237700000000     /*-------------------------------------------------------------*/
237800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0085                    */
237900000000     /* Imprimer                                                    */
238000000000     /*-------------------------------------------------------------*/
238100000000
238200000000             RMVMSGD MSGID(KEY0085) MSGF(&LIB/&OBJ)
238300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
238400000000
238500000000             ADDMSGD +
238600000000                MSGID(KEY0085) +
238700000000                MSGF(&LIB/&OBJ) +
238800000000                MSG( +
238900000000'Imprimer'                                                            +
239000000000                ) +
239100000000                SEV(0) +
239200000000     /*   No replacement variables defined!                         */ +
239300000000                ALROPT(*NO) +
239400000000                CCSID(65535) +
239500000000                /*  -EOF-  */
239600000000
239700000000     /*-------------------------------------------------------------*/
239800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0086                    */
239900000000     /* Insärer                                                     */
240000000000     /*-------------------------------------------------------------*/
240100000000
240200000000             RMVMSGD MSGID(KEY0086) MSGF(&LIB/&OBJ)
240300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
240400000000
240500000000             ADDMSGD +
240600000000                MSGID(KEY0086) +
240700000000                MSGF(&LIB/&OBJ) +
240800000000                MSG( +
240900000000'Insärer'                                                             +
241000000000                ) +
241100000000                SEV(0) +
241200000000     /*   No replacement variables defined!                         */ +
241300000000                ALROPT(*NO) +
241400000000                CCSID(65535) +
241500000000                /*  -EOF-  */
241600000000
241700000000     /*-------------------------------------------------------------*/
241800000000     /*   Cmd-ADDMSGD für Message-ID :   KEY0087                    */
241900000000     /* Supprimer                                                   */
242000000000     /*-------------------------------------------------------------*/
242100000000
242200000000             RMVMSGD MSGID(KEY0087) MSGF(&LIB/&OBJ)
242300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
242400000000
242500000000             ADDMSGD +
242600000000                MSGID(KEY0087) +
242700000000                MSGF(&LIB/&OBJ) +
242800000000                MSG( +
242900000000'Supprimer'                                                           +
243000000000                ) +
243100000000                SEV(0) +
243200000000     /*   No replacement variables defined!                         */ +
243300000000                ALROPT(*NO) +
243400000000                CCSID(65535) +
243500000000                /*  -EOF-  */
243600000000
243700000000     /*-------------------------------------------------------------*/
243800000000     /*   Cmd-ADDMSGD für Message-ID :   MBX0001                    */
243900000000     /* Information                                                 */
244000000000     /*-------------------------------------------------------------*/
244100000000
244200000000             RMVMSGD MSGID(MBX0001) MSGF(&LIB/&OBJ)
244300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
244400000000
244500000000             ADDMSGD +
244600000000                MSGID(MBX0001) +
244700000000                MSGF(&LIB/&OBJ) +
244800000000                MSG( +
244900000000'Information'                                                         +
245000000000                ) +
245100000000                SEV(0) +
245200000000     /*   No replacement variables defined!                         */ +
245300000000                ALROPT(*NO) +
245400000000                CCSID(65535) +
245500000000                /*  -EOF-  */
245600000000
245700000000     /*-------------------------------------------------------------*/
245800000000     /*   Cmd-ADDMSGD für Message-ID :   MBX0002                    */
245900000000     /* Questions                                                   */
246000000000     /*-------------------------------------------------------------*/
246100000000
246200000000             RMVMSGD MSGID(MBX0002) MSGF(&LIB/&OBJ)
246300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
246400000000
246500000000             ADDMSGD +
246600000000                MSGID(MBX0002) +
246700000000                MSGF(&LIB/&OBJ) +
246800000000                MSG( +
246900000000'Questions'                                                           +
247000000000                ) +
247100000000                SEV(0) +
247200000000     /*   No replacement variables defined!                         */ +
247300000000                ALROPT(*NO) +
247400000000                CCSID(65535) +
247500000000                /*  -EOF-  */
247600000000
247700000000     /*-------------------------------------------------------------*/
247800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0001                    */
247900000000     /* Fichier                                                     */
248000000000     /*-------------------------------------------------------------*/
248100000000
248200000000             RMVMSGD MSGID(PMT0001) MSGF(&LIB/&OBJ)
248300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
248400000000
248500000000             ADDMSGD +
248600000000                MSGID(PMT0001) +
248700000000                MSGF(&LIB/&OBJ) +
248800000000                MSG( +
248900000000'Fichier'                                                             +
249000000000                ) +
249100000000                SEV(0) +
249200000000     /*   No replacement variables defined!                         */ +
249300000000                ALROPT(*NO) +
249400000000                CCSID(65535) +
249500000000                /*  -EOF-  */
249600000000
249700000000     /*-------------------------------------------------------------*/
249800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0002                    */
249900000000     /* Membre                                                      */
250000000000     /*-------------------------------------------------------------*/
250100000000
250200000000             RMVMSGD MSGID(PMT0002) MSGF(&LIB/&OBJ)
250300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
250400000000
250500000000             ADDMSGD +
250600000000                MSGID(PMT0002) +
250700000000                MSGF(&LIB/&OBJ) +
250800000000                MSG( +
250900000000'Membre'                                                              +
251000000000                ) +
251100000000                SEV(0) +
251200000000     /*   No replacement variables defined!                         */ +
251300000000                ALROPT(*NO) +
251400000000                CCSID(65535) +
251500000000                /*  -EOF-  */
251600000000
251700000000     /*-------------------------------------------------------------*/
251800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0003                    */
251900000000     /* Type d'accüs                                                */
252000000000     /*-------------------------------------------------------------*/
252100000000
252200000000             RMVMSGD MSGID(PMT0003) MSGF(&LIB/&OBJ)
252300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
252400000000
252500000000             ADDMSGD +
252600000000                MSGID(PMT0003) +
252700000000                MSGF(&LIB/&OBJ) +
252800000000                MSG( +
252900000000'Type d''accüs'                                                       +
253000000000                ) +
253100000000                SEV(0) +
253200000000     /*   No replacement variables defined!                         */ +
253300000000                ALROPT(*NO) +
253400000000                CCSID(65535) +
253500000000                /*  -EOF-  */
253600000000
253700000000     /*-------------------------------------------------------------*/
253800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0004                    */
253900000000     /* Langue                                                      */
254000000000     /*-------------------------------------------------------------*/
254100000000
254200000000             RMVMSGD MSGID(PMT0004) MSGF(&LIB/&OBJ)
254300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
254400000000
254500000000             ADDMSGD +
254600000000                MSGID(PMT0004) +
254700000000                MSGF(&LIB/&OBJ) +
254800000000                MSG( +
254900000000'Langue'                                                              +
255000000000                ) +
255100000000                SEV(0) +
255200000000     /*   No replacement variables defined!                         */ +
255300000000                ALROPT(*NO) +
255400000000                CCSID(65535) +
255500000000                /*  -EOF-  */
255600000000
255700000000     /*-------------------------------------------------------------*/
255800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0005                    */
255900000000     /* Droit de changer bibliothüque                               */
256000000000     /*-------------------------------------------------------------*/
256100000000
256200000000             RMVMSGD MSGID(PMT0005) MSGF(&LIB/&OBJ)
256300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
256400000000
256500000000             ADDMSGD +
256600000000                MSGID(PMT0005) +
256700000000                MSGF(&LIB/&OBJ) +
256800000000                MSG( +
256900000000'Droit de changer bibliothüque'                                       +
257000000000                ) +
257100000000                SEV(0) +
257200000000     /*   No replacement variables defined!                         */ +
257300000000                ALROPT(*NO) +
257400000000                CCSID(65535) +
257500000000                /*  -EOF-  */
257600000000
257700000000     /*-------------------------------------------------------------*/
257800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0006                    */
257900000000     /* Droit de changer de fichier                                 */
258000000000     /*-------------------------------------------------------------*/
258100000000
258200000000             RMVMSGD MSGID(PMT0006) MSGF(&LIB/&OBJ)
258300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
258400000000
258500000000             ADDMSGD +
258600000000                MSGID(PMT0006) +
258700000000                MSGF(&LIB/&OBJ) +
258800000000                MSG( +
258900000000'Droit de changer de fichier'                                         +
259000000000                ) +
259100000000                SEV(0) +
259200000000     /*   No replacement variables defined!                         */ +
259300000000                ALROPT(*NO) +
259400000000                CCSID(65535) +
259500000000                /*  -EOF-  */
259600000000
259700000000     /*-------------------------------------------------------------*/
259800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0007                    */
259900000000     /* Droit de changer de membre                                  */
260000000000     /*-------------------------------------------------------------*/
260100000000
260200000000             RMVMSGD MSGID(PMT0007) MSGF(&LIB/&OBJ)
260300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
260400000000
260500000000             ADDMSGD +
260600000000                MSGID(PMT0007) +
260700000000                MSGF(&LIB/&OBJ) +
260800000000                MSG( +
260900000000'Droit de changer de membre'                                          +
261000000000                ) +
261100000000                SEV(0) +
261200000000     /*   No replacement variables defined!                         */ +
261300000000                ALROPT(*NO) +
261400000000                CCSID(65535) +
261500000000                /*  -EOF-  */
261600000000
261700000000     /*-------------------------------------------------------------*/
261800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0008                    */
261900000000     /* Droit modifier enregistrement                               */
262000000000     /*-------------------------------------------------------------*/
262100000000
262200000000             RMVMSGD MSGID(PMT0008) MSGF(&LIB/&OBJ)
262300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
262400000000
262500000000             ADDMSGD +
262600000000                MSGID(PMT0008) +
262700000000                MSGF(&LIB/&OBJ) +
262800000000                MSG( +
262900000000'Droit modifier enregistrement'                                       +
263000000000                ) +
263100000000                SEV(0) +
263200000000     /*   No replacement variables defined!                         */ +
263300000000                ALROPT(*NO) +
263400000000                CCSID(65535) +
263500000000                /*  -EOF-  */
263600000000
263700000000     /*-------------------------------------------------------------*/
263800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0009                    */
263900000000     /* Droit de modifier SQL WHERE                                 */
264000000000     /*-------------------------------------------------------------*/
264100000000
264200000000             RMVMSGD MSGID(PMT0009) MSGF(&LIB/&OBJ)
264300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
264400000000
264500000000             ADDMSGD +
264600000000                MSGID(PMT0009) +
264700000000                MSGF(&LIB/&OBJ) +
264800000000                MSG( +
264900000000'Droit de modifier SQL WHERE'                                         +
265000000000                ) +
265100000000                SEV(0) +
265200000000     /*   No replacement variables defined!                         */ +
265300000000                ALROPT(*NO) +
265400000000                CCSID(65535) +
265500000000                /*  -EOF-  */
265600000000
265700000000     /*-------------------------------------------------------------*/
265800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0010                    */
265900000000     /* Droit de modifier ORDER BY                                  */
266000000000     /*-------------------------------------------------------------*/
266100000000
266200000000             RMVMSGD MSGID(PMT0010) MSGF(&LIB/&OBJ)
266300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
266400000000
266500000000             ADDMSGD +
266600000000                MSGID(PMT0010) +
266700000000                MSGF(&LIB/&OBJ) +
266800000000                MSG( +
266900000000'Droit de modifier ORDER BY'                                          +
267000000000                ) +
267100000000                SEV(0) +
267200000000     /*   No replacement variables defined!                         */ +
267300000000                ALROPT(*NO) +
267400000000                CCSID(65535) +
267500000000                /*  -EOF-  */
267600000000
267700000000     /*-------------------------------------------------------------*/
267800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0011                    */
267900000000     /* Environnement                                               */
268000000000     /*-------------------------------------------------------------*/
268100000000
268200000000             RMVMSGD MSGID(PMT0011) MSGF(&LIB/&OBJ)
268300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
268400000000
268500000000             ADDMSGD +
268600000000                MSGID(PMT0011) +
268700000000                MSGF(&LIB/&OBJ) +
268800000000                MSG( +
268900000000'Environnement'                                                       +
269000000000                ) +
269100000000                SEV(0) +
269200000000     /*   No replacement variables defined!                         */ +
269300000000                ALROPT(*NO) +
269400000000                CCSID(65535) +
269500000000                /*  -EOF-  */
269600000000
269700000000     /*-------------------------------------------------------------*/
269800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0012                    */
269900000000     /*   Membre                                                    */
270000000000     /*-------------------------------------------------------------*/
270100000000
270200000000             RMVMSGD MSGID(PMT0012) MSGF(&LIB/&OBJ)
270300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
270400000000
270500000000             ADDMSGD +
270600000000                MSGID(PMT0012) +
270700000000                MSGF(&LIB/&OBJ) +
270800000000                MSG( +
270900000000'  Membre'                                                            +
271000000000                ) +
271100000000                SEV(0) +
271200000000     /*   No replacement variables defined!                         */ +
271300000000                ALROPT(*NO) +
271400000000                CCSID(65535) +
271500000000                /*  -EOF-  */
271600000000
271700000000     /*-------------------------------------------------------------*/
271800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0013                    */
271900000000     /* Clause SQL WHERE                                            */
272000000000     /*-------------------------------------------------------------*/
272100000000
272200000000             RMVMSGD MSGID(PMT0013) MSGF(&LIB/&OBJ)
272300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
272400000000
272500000000             ADDMSGD +
272600000000                MSGID(PMT0013) +
272700000000                MSGF(&LIB/&OBJ) +
272800000000                MSG( +
272900000000'Clause SQL WHERE'                                                    +
273000000000                ) +
273100000000                SEV(0) +
273200000000     /*   No replacement variables defined!                         */ +
273300000000                ALROPT(*NO) +
273400000000                CCSID(65535) +
273500000000                /*  -EOF-  */
273600000000
273700000000     /*-------------------------------------------------------------*/
273800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0014                    */
273900000000     /* Clause SQL ORDER BY                                         */
274000000000     /*-------------------------------------------------------------*/
274100000000
274200000000             RMVMSGD MSGID(PMT0014) MSGF(&LIB/&OBJ)
274300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
274400000000
274500000000             ADDMSGD +
274600000000                MSGID(PMT0014) +
274700000000                MSGF(&LIB/&OBJ) +
274800000000                MSG( +
274900000000'Clause SQL ORDER BY'                                                 +
275000000000                ) +
275100000000                SEV(0) +
275200000000     /*   No replacement variables defined!                         */ +
275300000000                ALROPT(*NO) +
275400000000                CCSID(65535) +
275500000000                /*  -EOF-  */
275600000000
275700000000     /*-------------------------------------------------------------*/
275800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0015                    */
275900000000     /* Bibliothüque                                                */
276000000000     /*-------------------------------------------------------------*/
276100000000
276200000000             RMVMSGD MSGID(PMT0015) MSGF(&LIB/&OBJ)
276300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
276400000000
276500000000             ADDMSGD +
276600000000                MSGID(PMT0015) +
276700000000                MSGF(&LIB/&OBJ) +
276800000000                MSG( +
276900000000'Bibliothüque'                                                        +
277000000000                ) +
277100000000                SEV(0) +
277200000000     /*   No replacement variables defined!                         */ +
277300000000                ALROPT(*NO) +
277400000000                CCSID(65535) +
277500000000                /*  -EOF-  */
277600000000
277700000000     /*-------------------------------------------------------------*/
277800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0016                    */
277900000000     /* Präfärences utilisateur                                     */
278000000000     /*-------------------------------------------------------------*/
278100000000
278200000000             RMVMSGD MSGID(PMT0016) MSGF(&LIB/&OBJ)
278300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
278400000000
278500000000             ADDMSGD +
278600000000                MSGID(PMT0016) +
278700000000                MSGF(&LIB/&OBJ) +
278800000000                MSG( +
278900000000'Präfärences utilisateur'                                             +
279000000000                ) +
279100000000                SEV(0) +
279200000000     /*   No replacement variables defined!                         */ +
279300000000                ALROPT(*NO) +
279400000000                CCSID(65535) +
279500000000                /*  -EOF-  */
279600000000
279700000000     /*-------------------------------------------------------------*/
279800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0017                    */
279900000000     /* Profil utilisateur                                          */
280000000000     /*-------------------------------------------------------------*/
280100000000
280200000000             RMVMSGD MSGID(PMT0017) MSGF(&LIB/&OBJ)
280300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
280400000000
280500000000             ADDMSGD +
280600000000                MSGID(PMT0017) +
280700000000                MSGF(&LIB/&OBJ) +
280800000000                MSG( +
280900000000'Profil utilisateur'                                                  +
281000000000                ) +
281100000000                SEV(0) +
281200000000     /*   No replacement variables defined!                         */ +
281300000000                ALROPT(*NO) +
281400000000                CCSID(65535) +
281500000000                /*  -EOF-  */
281600000000
281700000000     /*-------------------------------------------------------------*/
281800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0018                    */
281900000000     /* Sauvegarder en quittant                                     */
282000000000     /*-------------------------------------------------------------*/
282100000000
282200000000             RMVMSGD MSGID(PMT0018) MSGF(&LIB/&OBJ)
282300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
282400000000
282500000000             ADDMSGD +
282600000000                MSGID(PMT0018) +
282700000000                MSGF(&LIB/&OBJ) +
282800000000                MSG( +
282900000000'Sauvegarder en quittant'                                             +
283000000000                ) +
283100000000                SEV(0) +
283200000000     /*   No replacement variables defined!                         */ +
283300000000                ALROPT(*NO) +
283400000000                CCSID(65535) +
283500000000                /*  -EOF-  */
283600000000
283700000000     /*-------------------------------------------------------------*/
283800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0019                    */
283900000000     /* Charger seulement la maquette                               */
284000000000     /*-------------------------------------------------------------*/
284100000000
284200000000             RMVMSGD MSGID(PMT0019) MSGF(&LIB/&OBJ)
284300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
284400000000
284500000000             ADDMSGD +
284600000000                MSGID(PMT0019) +
284700000000                MSGF(&LIB/&OBJ) +
284800000000                MSG( +
284900000000'Charger seulement la maquette'                                       +
285000000000                ) +
285100000000                SEV(0) +
285200000000     /*   No replacement variables defined!                         */ +
285300000000                ALROPT(*NO) +
285400000000                CCSID(65535) +
285500000000                /*  -EOF-  */
285600000000
285700000000     /*-------------------------------------------------------------*/
285800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0100                    */
285900000000     /* Editeur B.D.D Peek/400                                      */
286000000000     /*-------------------------------------------------------------*/
286100000000
286200000000             RMVMSGD MSGID(PMT0100) MSGF(&LIB/&OBJ)
286300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
286400000000
286500000000             ADDMSGD +
286600000000                MSGID(PMT0100) +
286700000000                MSGF(&LIB/&OBJ) +
286800000000                MSG( +
286900000000'Editeur B.D.D Peek/400'                                              +
287000000000                ) +
287100000000                SEV(0) +
287200000000     /*   No replacement variables defined!                         */ +
287300000000                ALROPT(*NO) +
287400000000                CCSID(65535) +
287500000000                /*  -EOF-  */
287600000000
287700000000     /*-------------------------------------------------------------*/
287800000000     /*   Cmd-ADDMSGD für Message-ID :   PMT0101                    */
287900000000     /* Afficher relations logiques                                 */
288000000000     /*-------------------------------------------------------------*/
288100000000
288200000000             RMVMSGD MSGID(PMT0101) MSGF(&LIB/&OBJ)
288300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
288400000000
288500000000             ADDMSGD +
288600000000                MSGID(PMT0101) +
288700000000                MSGF(&LIB/&OBJ) +
288800000000                MSG( +
288900000000'Afficher relations logiques'                                         +
289000000000                ) +
289100000000                SEV(0) +
289200000000     /*   No replacement variables defined!                         */ +
289300000000                ALROPT(*NO) +
289400000000                CCSID(65535) +
289500000000                /*  -EOF-  */
289600000000
289700000000     /*-------------------------------------------------------------*/
289800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0001                    */
289900000000     /* Fich.:                                                      */
290000000000     /*-------------------------------------------------------------*/
290100000000
290200000000             RMVMSGD MSGID(TXT0001) MSGF(&LIB/&OBJ)
290300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
290400000000
290500000000             ADDMSGD +
290600000000                MSGID(TXT0001) +
290700000000                MSGF(&LIB/&OBJ) +
290800000000                MSG( +
290900000000'Fich.:'                                                              +
291000000000                ) +
291100000000                SEV(0) +
291200000000     /*   No replacement variables defined!                         */ +
291300000000                ALROPT(*NO) +
291400000000                CCSID(65535) +
291500000000                /*  -EOF-  */
291600000000
291700000000     /*-------------------------------------------------------------*/
291800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0002                    */
291900000000     /* Bibliothü.:                                                 */
292000000000     /*-------------------------------------------------------------*/
292100000000
292200000000             RMVMSGD MSGID(TXT0002) MSGF(&LIB/&OBJ)
292300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
292400000000
292500000000             ADDMSGD +
292600000000                MSGID(TXT0002) +
292700000000                MSGF(&LIB/&OBJ) +
292800000000                MSG( +
292900000000'Bibliothü.:'                                                         +
293000000000                ) +
293100000000                SEV(0) +
293200000000     /*   No replacement variables defined!                         */ +
293300000000                ALROPT(*NO) +
293400000000                CCSID(65535) +
293500000000                /*  -EOF-  */
293600000000
293700000000     /*-------------------------------------------------------------*/
293800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0003                    */
293900000000     /*   Membre :                                                  */
294000000000     /*-------------------------------------------------------------*/
294100000000
294200000000             RMVMSGD MSGID(TXT0003) MSGF(&LIB/&OBJ)
294300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
294400000000
294500000000             ADDMSGD +
294600000000                MSGID(TXT0003) +
294700000000                MSGF(&LIB/&OBJ) +
294800000000                MSG( +
294900000000'  Membre :'                                                          +
295000000000                ) +
295100000000                SEV(0) +
295200000000     /*   No replacement variables defined!                         */ +
295300000000                ALROPT(*NO) +
295400000000                CCSID(65535) +
295500000000                /*  -EOF-  */
295600000000
295700000000     /*-------------------------------------------------------------*/
295800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0004                    */
295900000000     /* Longueur....:                                               */
296000000000     /*-------------------------------------------------------------*/
296100000000
296200000000             RMVMSGD MSGID(TXT0004) MSGF(&LIB/&OBJ)
296300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
296400000000
296500000000             ADDMSGD +
296600000000                MSGID(TXT0004) +
296700000000                MSGF(&LIB/&OBJ) +
296800000000                MSG( +
296900000000'Longueur....:'                                                       +
297000000000                ) +
297100000000                SEV(0) +
297200000000     /*   No replacement variables defined!                         */ +
297300000000                ALROPT(*NO) +
297400000000                CCSID(65535) +
297500000000                /*  -EOF-  */
297600000000
297700000000     /*-------------------------------------------------------------*/
297800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0005                    */
297900000000     /* Nbre enreg..:                                               */
298000000000     /*-------------------------------------------------------------*/
298100000000
298200000000             RMVMSGD MSGID(TXT0005) MSGF(&LIB/&OBJ)
298300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
298400000000
298500000000             ADDMSGD +
298600000000                MSGID(TXT0005) +
298700000000                MSGF(&LIB/&OBJ) +
298800000000                MSG( +
298900000000'Nbre enreg..:'                                                       +
299000000000                ) +
299100000000                SEV(0) +
299200000000     /*   No replacement variables defined!                         */ +
299300000000                ALROPT(*NO) +
299400000000                CCSID(65535) +
299500000000                /*  -EOF-  */
299600000000
299700000000     /*-------------------------------------------------------------*/
299800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0006                    */
299900000000     /* NÄ champ....:                                               */
300000000000     /*-------------------------------------------------------------*/
300100000000
300200000000             RMVMSGD MSGID(TXT0006) MSGF(&LIB/&OBJ)
300300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
300400000000
300500000000             ADDMSGD +
300600000000                MSGID(TXT0006) +
300700000000                MSGF(&LIB/&OBJ) +
300800000000                MSG( +
300900000000'NÄ champ....:'                                                       +
301000000000                ) +
301100000000                SEV(0) +
301200000000     /*   No replacement variables defined!                         */ +
301300000000                ALROPT(*NO) +
301400000000                CCSID(65535) +
301500000000                /*  -EOF-  */
301600000000
301700000000     /*-------------------------------------------------------------*/
301800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0007                    */
301900000000     /* Nom du champ:                                               */
302000000000     /*-------------------------------------------------------------*/
302100000000
302200000000             RMVMSGD MSGID(TXT0007) MSGF(&LIB/&OBJ)
302300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
302400000000
302500000000             ADDMSGD +
302600000000                MSGID(TXT0007) +
302700000000                MSGF(&LIB/&OBJ) +
302800000000                MSG( +
302900000000'Nom du champ:'                                                       +
303000000000                ) +
303100000000                SEV(0) +
303200000000     /*   No replacement variables defined!                         */ +
303300000000                ALROPT(*NO) +
303400000000                CCSID(65535) +
303500000000                /*  -EOF-  */
303600000000
303700000000     /*-------------------------------------------------------------*/
303800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0008                    */
303900000000     /*   Format :                                                  */
304000000000     /*-------------------------------------------------------------*/
304100000000
304200000000             RMVMSGD MSGID(TXT0008) MSGF(&LIB/&OBJ)
304300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
304400000000
304500000000             ADDMSGD +
304600000000                MSGID(TXT0008) +
304700000000                MSGF(&LIB/&OBJ) +
304800000000                MSG( +
304900000000'  Format :'                                                          +
305000000000                ) +
305100000000                SEV(0) +
305200000000     /*   No replacement variables defined!                         */ +
305300000000                ALROPT(*NO) +
305400000000                CCSID(65535) +
305500000000                /*  -EOF-  */
305600000000
305700000000     /*-------------------------------------------------------------*/
305800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0009                    */
305900000000     /* Taille fich.:                                               */
306000000000     /*-------------------------------------------------------------*/
306100000000
306200000000             RMVMSGD MSGID(TXT0009) MSGF(&LIB/&OBJ)
306300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
306400000000
306500000000             ADDMSGD +
306600000000                MSGID(TXT0009) +
306700000000                MSGF(&LIB/&OBJ) +
306800000000                MSG( +
306900000000'Taille fich.:'                                                       +
307000000000                ) +
307100000000                SEV(0) +
307200000000     /*   No replacement variables defined!                         */ +
307300000000                ALROPT(*NO) +
307400000000                CCSID(65535) +
307500000000                /*  -EOF-  */
307600000000
307700000000     /*-------------------------------------------------------------*/
307800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0010                    */
307900000000     /* NÄ enregist.:                                               */
308000000000     /*-------------------------------------------------------------*/
308100000000
308200000000             RMVMSGD MSGID(TXT0010) MSGF(&LIB/&OBJ)
308300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
308400000000
308500000000             ADDMSGD +
308600000000                MSGID(TXT0010) +
308700000000                MSGF(&LIB/&OBJ) +
308800000000                MSG( +
308900000000'NÄ enregist.:'                                                       +
309000000000                ) +
309100000000                SEV(0) +
309200000000     /*   No replacement variables defined!                         */ +
309300000000                ALROPT(*NO) +
309400000000                CCSID(65535) +
309500000000                /*  -EOF-  */
309600000000
309700000000     /*-------------------------------------------------------------*/
309800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0011                    */
309900000000     /* Valeur clefs:                                               */
310000000000     /*-------------------------------------------------------------*/
310100000000
310200000000             RMVMSGD MSGID(TXT0011) MSGF(&LIB/&OBJ)
310300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
310400000000
310500000000             ADDMSGD +
310600000000                MSGID(TXT0011) +
310700000000                MSGF(&LIB/&OBJ) +
310800000000                MSG( +
310900000000'Valeur clefs:'                                                       +
311000000000                ) +
311100000000                SEV(0) +
311200000000     /*   No replacement variables defined!                         */ +
311300000000                ALROPT(*NO) +
311400000000                CCSID(65535) +
311500000000                /*  -EOF-  */
311600000000
311700000000     /*-------------------------------------------------------------*/
311800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0012                    */
311900000000     /*  Options :                                                  */
312000000000     /*-------------------------------------------------------------*/
312100000000
312200000000             RMVMSGD MSGID(TXT0012) MSGF(&LIB/&OBJ)
312300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
312400000000
312500000000             ADDMSGD +
312600000000                MSGID(TXT0012) +
312700000000                MSGF(&LIB/&OBJ) +
312800000000                MSG( +
312900000000' Options :'                                                          +
313000000000                ) +
313100000000                SEV(0) +
313200000000     /*   No replacement variables defined!                         */ +
313300000000                ALROPT(*NO) +
313400000000                CCSID(65535) +
313500000000                /*  -EOF-  */
313600000000
313700000000     /*-------------------------------------------------------------*/
313800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0013                    */
313900000000     /*  Fich.:                                                     */
314000000000     /*-------------------------------------------------------------*/
314100000000
314200000000             RMVMSGD MSGID(TXT0013) MSGF(&LIB/&OBJ)
314300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
314400000000
314500000000             ADDMSGD +
314600000000                MSGID(TXT0013) +
314700000000                MSGF(&LIB/&OBJ) +
314800000000                MSG( +
314900000000' Fich.:'                                                             +
315000000000                ) +
315100000000                SEV(0) +
315200000000     /*   No replacement variables defined!                         */ +
315300000000                ALROPT(*NO) +
315400000000                CCSID(65535) +
315500000000                /*  -EOF-  */
315600000000
315700000000     /*-------------------------------------------------------------*/
315800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0014                    */
315900000000     /* Bib:                                                        */
316000000000     /*-------------------------------------------------------------*/
316100000000
316200000000             RMVMSGD MSGID(TXT0014) MSGF(&LIB/&OBJ)
316300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
316400000000
316500000000             ADDMSGD +
316600000000                MSGID(TXT0014) +
316700000000                MSGF(&LIB/&OBJ) +
316800000000                MSG( +
316900000000'Bib:'                                                                +
317000000000                ) +
317100000000                SEV(0) +
317200000000     /*   No replacement variables defined!                         */ +
317300000000                ALROPT(*NO) +
317400000000                CCSID(65535) +
317500000000                /*  -EOF-  */
317600000000
317700000000     /*-------------------------------------------------------------*/
317800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0015                    */
317900000000     /* Mbr:                                                        */
318000000000     /*-------------------------------------------------------------*/
318100000000
318200000000             RMVMSGD MSGID(TXT0015) MSGF(&LIB/&OBJ)
318300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
318400000000
318500000000             ADDMSGD +
318600000000                MSGID(TXT0015) +
318700000000                MSGF(&LIB/&OBJ) +
318800000000                MSG( +
318900000000'Mbr:'                                                                +
319000000000                ) +
319100000000                SEV(0) +
319200000000     /*   No replacement variables defined!                         */ +
319300000000                ALROPT(*NO) +
319400000000                CCSID(65535) +
319500000000                /*  -EOF-  */
319600000000
319700000000     /*-------------------------------------------------------------*/
319800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0016                    */
319900000000     /* Taille:                                                     */
320000000000     /*-------------------------------------------------------------*/
320100000000
320200000000             RMVMSGD MSGID(TXT0016) MSGF(&LIB/&OBJ)
320300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
320400000000
320500000000             ADDMSGD +
320600000000                MSGID(TXT0016) +
320700000000                MSGF(&LIB/&OBJ) +
320800000000                MSG( +
320900000000'Taille:'                                                             +
321000000000                ) +
321100000000                SEV(0) +
321200000000     /*   No replacement variables defined!                         */ +
321300000000                ALROPT(*NO) +
321400000000                CCSID(65535) +
321500000000                /*  -EOF-  */
321600000000
321700000000     /*-------------------------------------------------------------*/
321800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0017                    */
321900000000     /* Enreg.:                                                     */
322000000000     /*-------------------------------------------------------------*/
322100000000
322200000000             RMVMSGD MSGID(TXT0017) MSGF(&LIB/&OBJ)
322300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
322400000000
322500000000             ADDMSGD +
322600000000                MSGID(TXT0017) +
322700000000                MSGF(&LIB/&OBJ) +
322800000000                MSG( +
322900000000'Enreg.:'                                                             +
323000000000                ) +
323100000000                SEV(0) +
323200000000     /*   No replacement variables defined!                         */ +
323300000000                ALROPT(*NO) +
323400000000                CCSID(65535) +
323500000000                /*  -EOF-  */
323600000000
323700000000     /*-------------------------------------------------------------*/
323800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0018                    */
323900000000     /* NÄchamp.:                                                   */
324000000000     /*-------------------------------------------------------------*/
324100000000
324200000000             RMVMSGD MSGID(TXT0018) MSGF(&LIB/&OBJ)
324300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
324400000000
324500000000             ADDMSGD +
324600000000                MSGID(TXT0018) +
324700000000                MSGF(&LIB/&OBJ) +
324800000000                MSG( +
324900000000'NÄchamp.:'                                                           +
325000000000                ) +
325100000000                SEV(0) +
325200000000     /*   No replacement variables defined!                         */ +
325300000000                ALROPT(*NO) +
325400000000                CCSID(65535) +
325500000000                /*  -EOF-  */
325600000000
325700000000     /*-------------------------------------------------------------*/
325800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0019                    */
325900000000     /* Nom champ:                                                  */
326000000000     /*-------------------------------------------------------------*/
326100000000
326200000000             RMVMSGD MSGID(TXT0019) MSGF(&LIB/&OBJ)
326300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
326400000000
326500000000             ADDMSGD +
326600000000                MSGID(TXT0019) +
326700000000                MSGF(&LIB/&OBJ) +
326800000000                MSG( +
326900000000'Nom champ:'                                                          +
327000000000                ) +
327100000000                SEV(0) +
327200000000     /*   No replacement variables defined!                         */ +
327300000000                ALROPT(*NO) +
327400000000                CCSID(65535) +
327500000000                /*  -EOF-  */
327600000000
327700000000     /*-------------------------------------------------------------*/
327800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0020                    */
327900000000     /* Format:                                                     */
328000000000     /*-------------------------------------------------------------*/
328100000000
328200000000             RMVMSGD MSGID(TXT0020) MSGF(&LIB/&OBJ)
328300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
328400000000
328500000000             ADDMSGD +
328600000000                MSGID(TXT0020) +
328700000000                MSGF(&LIB/&OBJ) +
328800000000                MSG( +
328900000000'Format:'                                                             +
329000000000                ) +
329100000000                SEV(0) +
329200000000     /*   No replacement variables defined!                         */ +
329300000000                ALROPT(*NO) +
329400000000                CCSID(65535) +
329500000000                /*  -EOF-  */
329600000000
329700000000     /*-------------------------------------------------------------*/
329800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0021                    */
329900000000     /* Taille:                                                     */
330000000000     /*-------------------------------------------------------------*/
330100000000
330200000000             RMVMSGD MSGID(TXT0021) MSGF(&LIB/&OBJ)
330300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
330400000000
330500000000             ADDMSGD +
330600000000                MSGID(TXT0021) +
330700000000                MSGF(&LIB/&OBJ) +
330800000000                MSG( +
330900000000'Taille:'                                                             +
331000000000                ) +
331100000000                SEV(0) +
331200000000     /*   No replacement variables defined!                         */ +
331300000000                ALROPT(*NO) +
331400000000                CCSID(65535) +
331500000000                /*  -EOF-  */
331600000000
331700000000     /*-------------------------------------------------------------*/
331800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0022                    */
331900000000     /* NÄ enreg.:                                                  */
332000000000     /*-------------------------------------------------------------*/
332100000000
332200000000             RMVMSGD MSGID(TXT0022) MSGF(&LIB/&OBJ)
332300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
332400000000
332500000000             ADDMSGD +
332600000000                MSGID(TXT0022) +
332700000000                MSGF(&LIB/&OBJ) +
332800000000                MSG( +
332900000000'NÄ enreg.:'                                                          +
333000000000                ) +
333100000000                SEV(0) +
333200000000     /*   No replacement variables defined!                         */ +
333300000000                ALROPT(*NO) +
333400000000                CCSID(65535) +
333500000000                /*  -EOF-  */
333600000000
333700000000     /*-------------------------------------------------------------*/
333800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0023                    */
333900000000     /* Valeur clefs:                                               */
334000000000     /*-------------------------------------------------------------*/
334100000000
334200000000             RMVMSGD MSGID(TXT0023) MSGF(&LIB/&OBJ)
334300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
334400000000
334500000000             ADDMSGD +
334600000000                MSGID(TXT0023) +
334700000000                MSGF(&LIB/&OBJ) +
334800000000                MSG( +
334900000000'Valeur clefs:'                                                       +
335000000000                ) +
335100000000                SEV(0) +
335200000000     /*   No replacement variables defined!                         */ +
335300000000                ALROPT(*NO) +
335400000000                CCSID(65535) +
335500000000                /*  -EOF-  */
335600000000
335700000000     /*-------------------------------------------------------------*/
335800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0024                    */
335900000000     /* Options:                                                    */
336000000000     /*-------------------------------------------------------------*/
336100000000
336200000000             RMVMSGD MSGID(TXT0024) MSGF(&LIB/&OBJ)
336300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
336400000000
336500000000             ADDMSGD +
336600000000                MSGID(TXT0024) +
336700000000                MSGF(&LIB/&OBJ) +
336800000000                MSG( +
336900000000'Options:'                                                            +
337000000000                ) +
337100000000                SEV(0) +
337200000000     /*   No replacement variables defined!                         */ +
337300000000                ALROPT(*NO) +
337400000000                CCSID(65535) +
337500000000                /*  -EOF-  */
337600000000
337700000000     /*-------------------------------------------------------------*/
337800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0025                    */
337900000000     /* (Pas d'enregistrement)                                      */
338000000000     /*-------------------------------------------------------------*/
338100000000
338200000000             RMVMSGD MSGID(TXT0025) MSGF(&LIB/&OBJ)
338300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
338400000000
338500000000             ADDMSGD +
338600000000                MSGID(TXT0025) +
338700000000                MSGF(&LIB/&OBJ) +
338800000000                MSG( +
338900000000'(Pas d''enregistrement)'                                             +
339000000000                ) +
339100000000                SEV(0) +
339200000000     /*   No replacement variables defined!                         */ +
339300000000                ALROPT(*NO) +
339400000000                CCSID(65535) +
339500000000                /*  -EOF-  */
339600000000
339700000000     /*-------------------------------------------------------------*/
339800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0026                    */
339900000000     /* Tapez ENTREE pour supprimer.                                */
340000000000     /*-------------------------------------------------------------*/
340100000000
340200000000             RMVMSGD MSGID(TXT0026) MSGF(&LIB/&OBJ)
340300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
340400000000
340500000000             ADDMSGD +
340600000000                MSGID(TXT0026) +
340700000000                MSGF(&LIB/&OBJ) +
340800000000                MSG( +
340900000000'Tapez ENTREE pour supprimer.'                                        +
341000000000                ) +
341100000000                SEV(0) +
341200000000     /*   No replacement variables defined!                         */ +
341300000000                ALROPT(*NO) +
341400000000                CCSID(65535) +
341500000000                /*  -EOF-  */
341600000000
341700000000     /*-------------------------------------------------------------*/
341800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0027                    */
341900000000     /* Dätail enregistrement                                       */
342000000000     /*-------------------------------------------------------------*/
342100000000
342200000000             RMVMSGD MSGID(TXT0027) MSGF(&LIB/&OBJ)
342300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
342400000000
342500000000             ADDMSGD +
342600000000                MSGID(TXT0027) +
342700000000                MSGF(&LIB/&OBJ) +
342800000000                MSG( +
342900000000'Dätail enregistrement'                                               +
343000000000                ) +
343100000000                SEV(0) +
343200000000     /*   No replacement variables defined!                         */ +
343300000000                ALROPT(*NO) +
343400000000                CCSID(65535) +
343500000000                /*  -EOF-  */
343600000000
343700000000     /*-------------------------------------------------------------*/
343800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0028                    */
343900000000     /* Tapez ENTREE pour copier.                                   */
344000000000     /*-------------------------------------------------------------*/
344100000000
344200000000             RMVMSGD MSGID(TXT0028) MSGF(&LIB/&OBJ)
344300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
344400000000
344500000000             ADDMSGD +
344600000000                MSGID(TXT0028) +
344700000000                MSGF(&LIB/&OBJ) +
344800000000                MSG( +
344900000000'Tapez ENTREE pour copier.'                                           +
345000000000                ) +
345100000000                SEV(0) +
345200000000     /*   No replacement variables defined!                         */ +
345300000000                ALROPT(*NO) +
345400000000                CCSID(65535) +
345500000000                /*  -EOF-  */
345600000000
345700000000     /*-------------------------------------------------------------*/
345800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0029                    */
345900000000     /* Enreg.:                                                     */
346000000000     /*-------------------------------------------------------------*/
346100000000
346200000000             RMVMSGD MSGID(TXT0029) MSGF(&LIB/&OBJ)
346300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
346400000000
346500000000             ADDMSGD +
346600000000                MSGID(TXT0029) +
346700000000                MSGF(&LIB/&OBJ) +
346800000000                MSG( +
346900000000'Enreg.:'                                                             +
347000000000                ) +
347100000000                SEV(0) +
347200000000     /*   No replacement variables defined!                         */ +
347300000000                ALROPT(*NO) +
347400000000                CCSID(65535) +
347500000000                /*  -EOF-  */
347600000000
347700000000     /*-------------------------------------------------------------*/
347800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0030                    */
347900000000     /* Journalisation                                              */
348000000000     /*-------------------------------------------------------------*/
348100000000
348200000000             RMVMSGD MSGID(TXT0030) MSGF(&LIB/&OBJ)
348300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
348400000000
348500000000             ADDMSGD +
348600000000                MSGID(TXT0030) +
348700000000                MSGF(&LIB/&OBJ) +
348800000000                MSG( +
348900000000'Journalisation'                                                      +
349000000000                ) +
349100000000                SEV(0) +
349200000000     /*   No replacement variables defined!                         */ +
349300000000                ALROPT(*NO) +
349400000000                CCSID(65535) +
349500000000                /*  -EOF-  */
349600000000
349700000000     /*-------------------------------------------------------------*/
349800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0031                    */
349900000000     /* Non journalisä                                              */
350000000000     /*-------------------------------------------------------------*/
350100000000
350200000000             RMVMSGD MSGID(TXT0031) MSGF(&LIB/&OBJ)
350300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
350400000000
350500000000             ADDMSGD +
350600000000                MSGID(TXT0031) +
350700000000                MSGF(&LIB/&OBJ) +
350800000000                MSG( +
350900000000'Non journalisä'                                                      +
351000000000                ) +
351100000000                SEV(0) +
351200000000     /*   No replacement variables defined!                         */ +
351300000000                ALROPT(*NO) +
351400000000                CCSID(65535) +
351500000000                /*  -EOF-  */
351600000000
351700000000     /*-------------------------------------------------------------*/
351800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0032                    */
351900000000     /* (Pas d'enregistrement)                                      */
352000000000     /*-------------------------------------------------------------*/
352100000000
352200000000             RMVMSGD MSGID(TXT0032) MSGF(&LIB/&OBJ)
352300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
352400000000
352500000000             ADDMSGD +
352600000000                MSGID(TXT0032) +
352700000000                MSGF(&LIB/&OBJ) +
352800000000                MSG( +
352900000000'(Pas d''enregistrement)'                                             +
353000000000                ) +
353100000000                SEV(0) +
353200000000     /*   No replacement variables defined!                         */ +
353300000000                ALROPT(*NO) +
353400000000                CCSID(65535) +
353500000000                /*  -EOF-  */
353600000000
353700000000     /*-------------------------------------------------------------*/
353800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0033                    */
353900000000     /*     - Recherche -                                           */
354000000000     /*-------------------------------------------------------------*/
354100000000
354200000000             RMVMSGD MSGID(TXT0033) MSGF(&LIB/&OBJ)
354300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
354400000000
354500000000             ADDMSGD +
354600000000                MSGID(TXT0033) +
354700000000                MSGF(&LIB/&OBJ) +
354800000000                MSG( +
354900000000'    - Recherche -'                                                   +
355000000000                ) +
355100000000                SEV(0) +
355200000000     /*   No replacement variables defined!                         */ +
355300000000                ALROPT(*NO) +
355400000000                CCSID(65535) +
355500000000                /*  -EOF-  */
355600000000
355700000000     /*-------------------------------------------------------------*/
355800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0034                    */
355900000000     /* Champ                                                       */
356000000000     /*-------------------------------------------------------------*/
356100000000
356200000000             RMVMSGD MSGID(TXT0034) MSGF(&LIB/&OBJ)
356300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
356400000000
356500000000             ADDMSGD +
356600000000                MSGID(TXT0034) +
356700000000                MSGF(&LIB/&OBJ) +
356800000000                MSG( +
356900000000'Champ'                                                               +
357000000000                ) +
357100000000                SEV(0) +
357200000000     /*   No replacement variables defined!                         */ +
357300000000                ALROPT(*NO) +
357400000000                CCSID(65535) +
357500000000                /*  -EOF-  */
357600000000
357700000000     /*-------------------------------------------------------------*/
357800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0035                    */
357900000000     /* Op.                                                         */
358000000000     /*-------------------------------------------------------------*/
358100000000
358200000000             RMVMSGD MSGID(TXT0035) MSGF(&LIB/&OBJ)
358300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
358400000000
358500000000             ADDMSGD +
358600000000                MSGID(TXT0035) +
358700000000                MSGF(&LIB/&OBJ) +
358800000000                MSG( +
358900000000'Op.'                                                                 +
359000000000                ) +
359100000000                SEV(0) +
359200000000     /*   No replacement variables defined!                         */ +
359300000000                ALROPT(*NO) +
359400000000                CCSID(65535) +
359500000000                /*  -EOF-  */
359600000000
359700000000     /*-------------------------------------------------------------*/
359800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0036                    */
359900000000     /* Valeur (sans quotes)                                        */
360000000000     /*-------------------------------------------------------------*/
360100000000
360200000000             RMVMSGD MSGID(TXT0036) MSGF(&LIB/&OBJ)
360300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
360400000000
360500000000             ADDMSGD +
360600000000                MSGID(TXT0036) +
360700000000                MSGF(&LIB/&OBJ) +
360800000000                MSG( +
360900000000'Valeur (sans quotes)'                                                +
361000000000                ) +
361100000000                SEV(0) +
361200000000     /*   No replacement variables defined!                         */ +
361300000000                ALROPT(*NO) +
361400000000                CCSID(65535) +
361500000000                /*  -EOF-  */
361600000000
361700000000     /*-------------------------------------------------------------*/
361800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0037                    */
361900000000     /* pour recherche gän)                                         */
362000000000     /*-------------------------------------------------------------*/
362100000000
362200000000             RMVMSGD MSGID(TXT0037) MSGF(&LIB/&OBJ)
362300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
362400000000
362500000000             ADDMSGD +
362600000000                MSGID(TXT0037) +
362700000000                MSGF(&LIB/&OBJ) +
362800000000                MSG( +
362900000000'pour recherche gän)'                                                 +
363000000000                ) +
363100000000                SEV(0) +
363200000000     /*   No replacement variables defined!                         */ +
363300000000                ALROPT(*NO) +
363400000000                CCSID(65535) +
363500000000                /*  -EOF-  */
363600000000
363700000000     /*-------------------------------------------------------------*/
363800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0038                    */
363900000000     /* Nb.lignes maxi:                                             */
364000000000     /*-------------------------------------------------------------*/
364100000000
364200000000             RMVMSGD MSGID(TXT0038) MSGF(&LIB/&OBJ)
364300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
364400000000
364500000000             ADDMSGD +
364600000000                MSGID(TXT0038) +
364700000000                MSGF(&LIB/&OBJ) +
364800000000                MSG( +
364900000000'Nb.lignes maxi:'                                                     +
365000000000                ) +
365100000000                SEV(0) +
365200000000     /*   No replacement variables defined!                         */ +
365300000000                ALROPT(*NO) +
365400000000                CCSID(65535) +
365500000000                /*  -EOF-  */
365600000000
365700000000     /*-------------------------------------------------------------*/
365800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0039                    */
365900000000     /* Type recherche:                                             */
366000000000     /*-------------------------------------------------------------*/
366100000000
366200000000             RMVMSGD MSGID(TXT0039) MSGF(&LIB/&OBJ)
366300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
366400000000
366500000000             ADDMSGD +
366600000000                MSGID(TXT0039) +
366700000000                MSGF(&LIB/&OBJ) +
366800000000                MSG( +
366900000000'Type recherche:'                                                     +
367000000000                ) +
367100000000                SEV(0) +
367200000000     /*   No replacement variables defined!                         */ +
367300000000                ALROPT(*NO) +
367400000000                CCSID(65535) +
367500000000                /*  -EOF-  */
367600000000
367700000000     /*-------------------------------------------------------------*/
367800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0040                    */
367900000000     /* (Normal/Underline/Reverse/Pin)                              */
368000000000     /*-------------------------------------------------------------*/
368100000000
368200000000             RMVMSGD MSGID(TXT0040) MSGF(&LIB/&OBJ)
368300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
368400000000
368500000000             ADDMSGD +
368600000000                MSGID(TXT0040) +
368700000000                MSGF(&LIB/&OBJ) +
368800000000                MSG( +
368900000000'(Normal/Underline/Reverse/Pin)'                                      +
369000000000                ) +
369100000000                SEV(0) +
369200000000     /*   No replacement variables defined!                         */ +
369300000000                ALROPT(*NO) +
369400000000                CCSID(65535) +
369500000000                /*  -EOF-  */
369600000000
369700000000     /*-------------------------------------------------------------*/
369800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0041                    */
369900000000     /* Respect casse :                                             */
370000000000     /*-------------------------------------------------------------*/
370100000000
370200000000             RMVMSGD MSGID(TXT0041) MSGF(&LIB/&OBJ)
370300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
370400000000
370500000000             ADDMSGD +
370600000000                MSGID(TXT0041) +
370700000000                MSGF(&LIB/&OBJ) +
370800000000                MSG( +
370900000000'Respect casse :'                                                     +
371000000000                ) +
371100000000                SEV(0) +
371200000000     /*   No replacement variables defined!                         */ +
371300000000                ALROPT(*NO) +
371400000000                CCSID(65535) +
371500000000                /*  -EOF-  */
371600000000
371700000000     /*-------------------------------------------------------------*/
371800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0042                    */
371900000000     /* (1=Oui, 0=Non)                                              */
372000000000     /*-------------------------------------------------------------*/
372100000000
372200000000             RMVMSGD MSGID(TXT0042) MSGF(&LIB/&OBJ)
372300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
372400000000
372500000000             ADDMSGD +
372600000000                MSGID(TXT0042) +
372700000000                MSGF(&LIB/&OBJ) +
372800000000                MSG( +
372900000000'(1=Oui, 0=Non)'                                                      +
373000000000                ) +
373100000000                SEV(0) +
373200000000     /*   No replacement variables defined!                         */ +
373300000000                ALROPT(*NO) +
373400000000                CCSID(65535) +
373500000000                /*  -EOF-  */
373600000000
373700000000     /*-------------------------------------------------------------*/
373800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0043                    */
373900000000     /*    - Couleur -                                              */
374000000000     /*-------------------------------------------------------------*/
374100000000
374200000000             RMVMSGD MSGID(TXT0043) MSGF(&LIB/&OBJ)
374300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
374400000000
374500000000             ADDMSGD +
374600000000                MSGID(TXT0043) +
374700000000                MSGF(&LIB/&OBJ) +
374800000000                MSG( +
374900000000'   - Couleur -'                                                      +
375000000000                ) +
375100000000                SEV(0) +
375200000000     /*   No replacement variables defined!                         */ +
375300000000                ALROPT(*NO) +
375400000000                CCSID(65535) +
375500000000                /*  -EOF-  */
375600000000
375700000000     /*-------------------------------------------------------------*/
375800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0044                    */
375900000000     /* -  Choix Couleur  -                                         */
376000000000     /*-------------------------------------------------------------*/
376100000000
376200000000             RMVMSGD MSGID(TXT0044) MSGF(&LIB/&OBJ)
376300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
376400000000
376500000000             ADDMSGD +
376600000000                MSGID(TXT0044) +
376700000000                MSGF(&LIB/&OBJ) +
376800000000                MSG( +
376900000000'-  Choix Couleur  -'                                                 +
377000000000                ) +
377100000000                SEV(0) +
377200000000     /*   No replacement variables defined!                         */ +
377300000000                ALROPT(*NO) +
377400000000                CCSID(65535) +
377500000000                /*  -EOF-  */
377600000000
377700000000     /*-------------------------------------------------------------*/
377800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0045                    */
377900000000     /* Vert                                                        */
378000000000     /*-------------------------------------------------------------*/
378100000000
378200000000             RMVMSGD MSGID(TXT0045) MSGF(&LIB/&OBJ)
378300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
378400000000
378500000000             ADDMSGD +
378600000000                MSGID(TXT0045) +
378700000000                MSGF(&LIB/&OBJ) +
378800000000                MSG( +
378900000000'Vert     '                                                           +
379000000000                ) +
379100000000                SEV(0) +
379200000000     /*   No replacement variables defined!                         */ +
379300000000                ALROPT(*NO) +
379400000000                CCSID(65535) +
379500000000                /*  -EOF-  */
379600000000
379700000000     /*-------------------------------------------------------------*/
379800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0046                    */
379900000000     /* Blanc                                                       */
380000000000     /*-------------------------------------------------------------*/
380100000000
380200000000             RMVMSGD MSGID(TXT0046) MSGF(&LIB/&OBJ)
380300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
380400000000
380500000000             ADDMSGD +
380600000000                MSGID(TXT0046) +
380700000000                MSGF(&LIB/&OBJ) +
380800000000                MSG( +
380900000000'Blanc    '                                                           +
381000000000                ) +
381100000000                SEV(0) +
381200000000     /*   No replacement variables defined!                         */ +
381300000000                ALROPT(*NO) +
381400000000                CCSID(65535) +
381500000000                /*  -EOF-  */
381600000000
381700000000     /*-------------------------------------------------------------*/
381800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0047                    */
381900000000     /* Rouge                                                       */
382000000000     /*-------------------------------------------------------------*/
382100000000
382200000000             RMVMSGD MSGID(TXT0047) MSGF(&LIB/&OBJ)
382300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
382400000000
382500000000             ADDMSGD +
382600000000                MSGID(TXT0047) +
382700000000                MSGF(&LIB/&OBJ) +
382800000000                MSG( +
382900000000'Rouge    '                                                           +
383000000000                ) +
383100000000                SEV(0) +
383200000000     /*   No replacement variables defined!                         */ +
383300000000                ALROPT(*NO) +
383400000000                CCSID(65535) +
383500000000                /*  -EOF-  */
383600000000
383700000000     /*-------------------------------------------------------------*/
383800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0048                    */
383900000000     /* Turquoise                                                   */
384000000000     /*-------------------------------------------------------------*/
384100000000
384200000000             RMVMSGD MSGID(TXT0048) MSGF(&LIB/&OBJ)
384300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
384400000000
384500000000             ADDMSGD +
384600000000                MSGID(TXT0048) +
384700000000                MSGF(&LIB/&OBJ) +
384800000000                MSG( +
384900000000'Turquoise'                                                           +
385000000000                ) +
385100000000                SEV(0) +
385200000000     /*   No replacement variables defined!                         */ +
385300000000                ALROPT(*NO) +
385400000000                CCSID(65535) +
385500000000                /*  -EOF-  */
385600000000
385700000000     /*-------------------------------------------------------------*/
385800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0049                    */
385900000000     /* Jaune                                                       */
386000000000     /*-------------------------------------------------------------*/
386100000000
386200000000             RMVMSGD MSGID(TXT0049) MSGF(&LIB/&OBJ)
386300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
386400000000
386500000000             ADDMSGD +
386600000000                MSGID(TXT0049) +
386700000000                MSGF(&LIB/&OBJ) +
386800000000                MSG( +
386900000000'Jaune    '                                                           +
387000000000                ) +
387100000000                SEV(0) +
387200000000     /*   No replacement variables defined!                         */ +
387300000000                ALROPT(*NO) +
387400000000                CCSID(65535) +
387500000000                /*  -EOF-  */
387600000000
387700000000     /*-------------------------------------------------------------*/
387800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0050                    */
387900000000     /* Rose                                                        */
388000000000     /*-------------------------------------------------------------*/
388100000000
388200000000             RMVMSGD MSGID(TXT0050) MSGF(&LIB/&OBJ)
388300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
388400000000
388500000000             ADDMSGD +
388600000000                MSGID(TXT0050) +
388700000000                MSGF(&LIB/&OBJ) +
388800000000                MSG( +
388900000000'Rose     '                                                           +
389000000000                ) +
389100000000                SEV(0) +
389200000000     /*   No replacement variables defined!                         */ +
389300000000                ALROPT(*NO) +
389400000000                CCSID(65535) +
389500000000                /*  -EOF-  */
389600000000
389700000000     /*-------------------------------------------------------------*/
389800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0051                    */
389900000000     /* Bleu                                                        */
390000000000     /*-------------------------------------------------------------*/
390100000000
390200000000             RMVMSGD MSGID(TXT0051) MSGF(&LIB/&OBJ)
390300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
390400000000
390500000000             ADDMSGD +
390600000000                MSGID(TXT0051) +
390700000000                MSGF(&LIB/&OBJ) +
390800000000                MSG( +
390900000000'Bleu     '                                                           +
391000000000                ) +
391100000000                SEV(0) +
391200000000     /*   No replacement variables defined!                         */ +
391300000000                ALROPT(*NO) +
391400000000                CCSID(65535) +
391500000000                /*  -EOF-  */
391600000000
391700000000     /*-------------------------------------------------------------*/
391800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0052                    */
391900000000     /* - Copier vers fic.-                                         */
392000000000     /*-------------------------------------------------------------*/
392100000000
392200000000             RMVMSGD MSGID(TXT0052) MSGF(&LIB/&OBJ)
392300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
392400000000
392500000000             ADDMSGD +
392600000000                MSGID(TXT0052) +
392700000000                MSGF(&LIB/&OBJ) +
392800000000                MSG( +
392900000000'- Copier vers fic.-'                                                 +
393000000000                ) +
393100000000                SEV(0) +
393200000000     /*   No replacement variables defined!                         */ +
393300000000                ALROPT(*NO) +
393400000000                CCSID(65535) +
393500000000                /*  -EOF-  */
393600000000
393700000000     /*-------------------------------------------------------------*/
393800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0053                    */
393900000000     /* Fichier..........:                                          */
394000000000     /*-------------------------------------------------------------*/
394100000000
394200000000             RMVMSGD MSGID(TXT0053) MSGF(&LIB/&OBJ)
394300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
394400000000
394500000000             ADDMSGD +
394600000000                MSGID(TXT0053) +
394700000000                MSGF(&LIB/&OBJ) +
394800000000                MSG( +
394900000000'Fichier..........:'                                                  +
395000000000                ) +
395100000000                SEV(0) +
395200000000     /*   No replacement variables defined!                         */ +
395300000000                ALROPT(*NO) +
395400000000                CCSID(65535) +
395500000000                /*  -EOF-  */
395600000000
395700000000     /*-------------------------------------------------------------*/
395800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0054                    */
395900000000     /* Bibliothüque.....:                                          */
396000000000     /*-------------------------------------------------------------*/
396100000000
396200000000             RMVMSGD MSGID(TXT0054) MSGF(&LIB/&OBJ)
396300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
396400000000
396500000000             ADDMSGD +
396600000000                MSGID(TXT0054) +
396700000000                MSGF(&LIB/&OBJ) +
396800000000                MSG( +
396900000000'Bibliothüque.....:'                                                  +
397000000000                ) +
397100000000                SEV(0) +
397200000000     /*   No replacement variables defined!                         */ +
397300000000                ALROPT(*NO) +
397400000000                CCSID(65535) +
397500000000                /*  -EOF-  */
397600000000
397700000000     /*-------------------------------------------------------------*/
397800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0055                    */
397900000000     /* Membre ..........:                                          */
398000000000     /*-------------------------------------------------------------*/
398100000000
398200000000             RMVMSGD MSGID(TXT0055) MSGF(&LIB/&OBJ)
398300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
398400000000
398500000000             ADDMSGD +
398600000000                MSGID(TXT0055) +
398700000000                MSGF(&LIB/&OBJ) +
398800000000                MSG( +
398900000000'Membre ..........:'                                                  +
399000000000                ) +
399100000000                SEV(0) +
399200000000     /*   No replacement variables defined!                         */ +
399300000000                ALROPT(*NO) +
399400000000                CCSID(65535) +
399500000000                /*  -EOF-  */
399600000000
399700000000     /*-------------------------------------------------------------*/
399800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0056                    */
399900000000     /* Remplacer enreg..:                                          */
400000000000     /*-------------------------------------------------------------*/
400100000000
400200000000             RMVMSGD MSGID(TXT0056) MSGF(&LIB/&OBJ)
400300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
400400000000
400500000000             ADDMSGD +
400600000000                MSGID(TXT0056) +
400700000000                MSGF(&LIB/&OBJ) +
400800000000                MSG( +
400900000000'Remplacer enreg..:'                                                  +
401000000000                ) +
401100000000                SEV(0) +
401200000000     /*   No replacement variables defined!                         */ +
401300000000                ALROPT(*NO) +
401400000000                CCSID(65535) +
401500000000                /*  -EOF-  */
401600000000
401700000000     /*-------------------------------------------------------------*/
401800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0057                    */
401900000000     /* Cräer Fichier....:                                          */
402000000000     /*-------------------------------------------------------------*/
402100000000
402200000000             RMVMSGD MSGID(TXT0057) MSGF(&LIB/&OBJ)
402300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
402400000000
402500000000             ADDMSGD +
402600000000                MSGID(TXT0057) +
402700000000                MSGF(&LIB/&OBJ) +
402800000000                MSG( +
402900000000'Cräer Fichier....:'                                                  +
403000000000                ) +
403100000000                SEV(0) +
403200000000     /*   No replacement variables defined!                         */ +
403300000000                ALROPT(*NO) +
403400000000                CCSID(65535) +
403500000000                /*  -EOF-  */
403600000000
403700000000     /*-------------------------------------------------------------*/
403800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0058                    */
403900000000     /* - Donnäes Licence -                                         */
404000000000     /*-------------------------------------------------------------*/
404100000000
404200000000             RMVMSGD MSGID(TXT0058) MSGF(&LIB/&OBJ)
404300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
404400000000
404500000000             ADDMSGD +
404600000000                MSGID(TXT0058) +
404700000000                MSGF(&LIB/&OBJ) +
404800000000                MSG( +
404900000000'- Donnäes Licence -'                                                 +
405000000000                ) +
405100000000                SEV(0) +
405200000000     /*   No replacement variables defined!                         */ +
405300000000                ALROPT(*NO) +
405400000000                CCSID(65535) +
405500000000                /*  -EOF-  */
405600000000
405700000000     /*-------------------------------------------------------------*/
405800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0059                    */
405900000000     /* Licence-No:                                                 */
406000000000     /*-------------------------------------------------------------*/
406100000000
406200000000             RMVMSGD MSGID(TXT0059) MSGF(&LIB/&OBJ)
406300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
406400000000
406500000000             ADDMSGD +
406600000000                MSGID(TXT0059) +
406700000000                MSGF(&LIB/&OBJ) +
406800000000                MSG( +
406900000000'Licence-No:'                                                         +
407000000000                ) +
407100000000                SEV(0) +
407200000000     /*   No replacement variables defined!                         */ +
407300000000                ALROPT(*NO) +
407400000000                CCSID(65535) +
407500000000                /*  -EOF-  */
407600000000
407700000000     /*-------------------------------------------------------------*/
407800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0060                    */
407900000000     /* F9=Testez!                                                  */
408000000000     /*-------------------------------------------------------------*/
408100000000
408200000000             RMVMSGD MSGID(TXT0060) MSGF(&LIB/&OBJ)
408300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
408400000000
408500000000             ADDMSGD +
408600000000                MSGID(TXT0060) +
408700000000                MSGF(&LIB/&OBJ) +
408800000000                MSG( +
408900000000'F9=Testez!'                                                          +
409000000000                ) +
409100000000                SEV(0) +
409200000000     /*   No replacement variables defined!                         */ +
409300000000                ALROPT(*NO) +
409400000000                CCSID(65535) +
409500000000                /*  -EOF-  */
409600000000
409700000000     /*-------------------------------------------------------------*/
409800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0061                    */
409900000000     /* Les donnäes de la licence ont ätä sauvegardäes              */
410000000000     /*-------------------------------------------------------------*/
410100000000
410200000000             RMVMSGD MSGID(TXT0061) MSGF(&LIB/&OBJ)
410300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
410400000000
410500000000             ADDMSGD +
410600000000                MSGID(TXT0061) +
410700000000                MSGF(&LIB/&OBJ) +
410800000000                MSG( +
410900000000'Les donnäes de la licence ont ätä sauvegardäes'                      +
411000000000                ) +
411100000000                SEV(0) +
411200000000     /*   No replacement variables defined!                         */ +
411300000000                ALROPT(*NO) +
411400000000                CCSID(65535) +
411500000000                /*  -EOF-  */
411600000000
411700000000     /*-------------------------------------------------------------*/
411800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0062                    */
411900000000     /* Däsolä, fin de la päriode ...........                       */
412000000000     /*-------------------------------------------------------------*/
412100000000
412200000000             RMVMSGD MSGID(TXT0062) MSGF(&LIB/&OBJ)
412300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
412400000000
412500000000             ADDMSGD +
412600000000                MSGID(TXT0062) +
412700000000                MSGF(&LIB/&OBJ) +
412800000000                MSG( +
412900000000'Däsolä, fin de la päriode ...........'                               +
413000000000                ) +
413100000000                SEV(0) +
413200000000     /*   No replacement variables defined!                         */ +
413300000000                ALROPT(*NO) +
413400000000                CCSID(65535) +
413500000000                /*  -EOF-  */
413600000000
413700000000     /*-------------------------------------------------------------*/
413800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0063                    */
413900000000     /* ENTREE pour modif.                                          */
414000000000     /*-------------------------------------------------------------*/
414100000000
414200000000             RMVMSGD MSGID(TXT0063) MSGF(&LIB/&OBJ)
414300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
414400000000
414500000000             ADDMSGD +
414600000000                MSGID(TXT0063) +
414700000000                MSGF(&LIB/&OBJ) +
414800000000                MSG( +
414900000000'ENTREE pour modif.'                                                  +
415000000000                ) +
415100000000                SEV(0) +
415200000000     /*   No replacement variables defined!                         */ +
415300000000                ALROPT(*NO) +
415400000000                CCSID(65535) +
415500000000                /*  -EOF-  */
415600000000
415700000000     /*-------------------------------------------------------------*/
415800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0064                    */
415900000000     /* ENTREE pour copie                                           */
416000000000     /*-------------------------------------------------------------*/
416100000000
416200000000             RMVMSGD MSGID(TXT0064) MSGF(&LIB/&OBJ)
416300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
416400000000
416500000000             ADDMSGD +
416600000000                MSGID(TXT0064) +
416700000000                MSGF(&LIB/&OBJ) +
416800000000                MSG( +
416900000000'ENTREE pour copie'                                                   +
417000000000                ) +
417100000000                SEV(0) +
417200000000     /*   No replacement variables defined!                         */ +
417300000000                ALROPT(*NO) +
417400000000                CCSID(65535) +
417500000000                /*  -EOF-  */
417600000000
417700000000     /*-------------------------------------------------------------*/
417800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0065                    */
417900000000     /* ENTREE pour ajout                                           */
418000000000     /*-------------------------------------------------------------*/
418100000000
418200000000             RMVMSGD MSGID(TXT0065) MSGF(&LIB/&OBJ)
418300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
418400000000
418500000000             ADDMSGD +
418600000000                MSGID(TXT0065) +
418700000000                MSGF(&LIB/&OBJ) +
418800000000                MSG( +
418900000000'ENTREE pour ajout'                                                   +
419000000000                ) +
419100000000                SEV(0) +
419200000000     /*   No replacement variables defined!                         */ +
419300000000                ALROPT(*NO) +
419400000000                CCSID(65535) +
419500000000                /*  -EOF-  */
419600000000
419700000000     /*-------------------------------------------------------------*/
419800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0066                    */
419900000000     /* A suivre...                                                 */
420000000000     /*-------------------------------------------------------------*/
420100000000
420200000000             RMVMSGD MSGID(TXT0066) MSGF(&LIB/&OBJ)
420300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
420400000000
420500000000             ADDMSGD +
420600000000                MSGID(TXT0066) +
420700000000                MSGF(&LIB/&OBJ) +
420800000000                MSG( +
420900000000'A suivre...'                                                         +
421000000000                ) +
421100000000                SEV(0) +
421200000000     /*   No replacement variables defined!                         */ +
421300000000                ALROPT(*NO) +
421400000000                CCSID(65535) +
421500000000                /*  -EOF-  */
421600000000
421700000000     /*-------------------------------------------------------------*/
421800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0067                    */
421900000000     /*         Fin                                                 */
422000000000     /*-------------------------------------------------------------*/
422100000000
422200000000             RMVMSGD MSGID(TXT0067) MSGF(&LIB/&OBJ)
422300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
422400000000
422500000000             ADDMSGD +
422600000000                MSGID(TXT0067) +
422700000000                MSGF(&LIB/&OBJ) +
422800000000                MSG( +
422900000000'        Fin'                                                         +
423000000000                ) +
423100000000                SEV(0) +
423200000000     /*   No replacement variables defined!                         */ +
423300000000                ALROPT(*NO) +
423400000000                CCSID(65535) +
423500000000                /*  -EOF-  */
423600000000
423700000000     /*-------------------------------------------------------------*/
423800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0068                    */
423900000000     /* Journalisation                                              */
424000000000     /*-------------------------------------------------------------*/
424100000000
424200000000             RMVMSGD MSGID(TXT0068) MSGF(&LIB/&OBJ)
424300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
424400000000
424500000000             ADDMSGD +
424600000000                MSGID(TXT0068) +
424700000000                MSGF(&LIB/&OBJ) +
424800000000                MSG( +
424900000000'Journalisation'                                                      +
425000000000                ) +
425100000000                SEV(0) +
425200000000     /*   No replacement variables defined!                         */ +
425300000000                ALROPT(*NO) +
425400000000                CCSID(65535) +
425500000000                /*  -EOF-  */
425600000000
425700000000     /*-------------------------------------------------------------*/
425800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0069                    */
425900000000     /* Mode äcran 80/132 car.                                      */
426000000000     /*-------------------------------------------------------------*/
426100000000
426200000000             RMVMSGD MSGID(TXT0069) MSGF(&LIB/&OBJ)
426300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
426400000000
426500000000             ADDMSGD +
426600000000                MSGID(TXT0069) +
426700000000                MSGF(&LIB/&OBJ) +
426800000000                MSG( +
426900000000'Mode äcran 80/132 car.'                                              +
427000000000                ) +
427100000000                SEV(0) +
427200000000     /*   No replacement variables defined!                         */ +
427300000000                ALROPT(*NO) +
427400000000                CCSID(65535) +
427500000000                /*  -EOF-  */
427600000000
427700000000     /*-------------------------------------------------------------*/
427800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0070                    */
427900000000     /* Moteur de recherche puissant                                */
428000000000     /*-------------------------------------------------------------*/
428100000000
428200000000             RMVMSGD MSGID(TXT0070) MSGF(&LIB/&OBJ)
428300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
428400000000
428500000000             ADDMSGD +
428600000000                MSGID(TXT0070) +
428700000000                MSGF(&LIB/&OBJ) +
428800000000                MSG( +
428900000000'Moteur de recherche puissant'                                        +
429000000000                ) +
429100000000                SEV(0) +
429200000000     /*   No replacement variables defined!                         */ +
429300000000                ALROPT(*NO) +
429400000000                CCSID(65535) +
429500000000                /*  -EOF-  */
429600000000
429700000000     /*-------------------------------------------------------------*/
429800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0071                    */
429900000000     /* Touches de fonction personnalisables                        */
430000000000     /*-------------------------------------------------------------*/
430100000000
430200000000             RMVMSGD MSGID(TXT0071) MSGF(&LIB/&OBJ)
430300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
430400000000
430500000000             ADDMSGD +
430600000000                MSGID(TXT0071) +
430700000000                MSGF(&LIB/&OBJ) +
430800000000                MSG( +
430900000000'Touches de fonction personnalisables'                                +
431000000000                ) +
431100000000                SEV(0) +
431200000000     /*   No replacement variables defined!                         */ +
431300000000                ALROPT(*NO) +
431400000000                CCSID(65535) +
431500000000                /*  -EOF-  */
431600000000
431700000000     /*-------------------------------------------------------------*/
431800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0072                    */
431900000000     /* Choix de la langue                                          */
432000000000     /*-------------------------------------------------------------*/
432100000000
432200000000             RMVMSGD MSGID(TXT0072) MSGF(&LIB/&OBJ)
432300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
432400000000
432500000000             ADDMSGD +
432600000000                MSGID(TXT0072) +
432700000000                MSGF(&LIB/&OBJ) +
432800000000                MSG( +
432900000000'Choix de la langue'                                                  +
433000000000                ) +
433100000000                SEV(0) +
433200000000     /*   No replacement variables defined!                         */ +
433300000000                ALROPT(*NO) +
433400000000                CCSID(65535) +
433500000000                /*  -EOF-  */
433600000000
433700000000     /*-------------------------------------------------------------*/
433800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0073                    */
433900000000     /*   L'ultime                                                  */
434000000000     /*-------------------------------------------------------------*/
434100000000
434200000000             RMVMSGD MSGID(TXT0073) MSGF(&LIB/&OBJ)
434300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
434400000000
434500000000             ADDMSGD +
434600000000                MSGID(TXT0073) +
434700000000                MSGF(&LIB/&OBJ) +
434800000000                MSG( +
434900000000'  L''ultime'                                                         +
435000000000                ) +
435100000000                SEV(0) +
435200000000     /*   No replacement variables defined!                         */ +
435300000000                ALROPT(*NO) +
435400000000                CCSID(65535) +
435500000000                /*  -EOF-  */
435600000000
435700000000     /*-------------------------------------------------------------*/
435800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0074                    */
435900000000     /* navigateur de base de donnäes                               */
436000000000     /*-------------------------------------------------------------*/
436100000000
436200000000             RMVMSGD MSGID(TXT0074) MSGF(&LIB/&OBJ)
436300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
436400000000
436500000000             ADDMSGD +
436600000000                MSGID(TXT0074) +
436700000000                MSGF(&LIB/&OBJ) +
436800000000                MSG( +
436900000000'navigateur de base de donnäes'                                       +
437000000000                ) +
437100000000                SEV(0) +
437200000000     /*   No replacement variables defined!                         */ +
437300000000                ALROPT(*NO) +
437400000000                CCSID(65535) +
437500000000                /*  -EOF-  */
437600000000
437700000000     /*-------------------------------------------------------------*/
437800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0075                    */
437900000000     /*       * Points forts *                                      */
438000000000     /*-------------------------------------------------------------*/
438100000000
438200000000             RMVMSGD MSGID(TXT0075) MSGF(&LIB/&OBJ)
438300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
438400000000
438500000000             ADDMSGD +
438600000000                MSGID(TXT0075) +
438700000000                MSGF(&LIB/&OBJ) +
438800000000                MSG( +
438900000000'      * Points forts *      '                                        +
439000000000                ) +
439100000000                SEV(0) +
439200000000     /*   No replacement variables defined!                         */ +
439300000000                ALROPT(*NO) +
439400000000                CCSID(65535) +
439500000000                /*  -EOF-  */
439600000000
439700000000     /*-------------------------------------------------------------*/
439800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0076                    */
439900000000     /* Caractüre non imprimable                                    */
440000000000     /*-------------------------------------------------------------*/
440100000000
440200000000             RMVMSGD MSGID(TXT0076) MSGF(&LIB/&OBJ)
440300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
440400000000
440500000000             ADDMSGD +
440600000000                MSGID(TXT0076) +
440700000000                MSGF(&LIB/&OBJ) +
440800000000                MSG( +
440900000000'Caractüre non imprimable'                                            +
441000000000                ) +
441100000000                SEV(0) +
441200000000     /*   No replacement variables defined!                         */ +
441300000000                ALROPT(*NO) +
441400000000                CCSID(65535) +
441500000000                /*  -EOF-  */
441600000000
441700000000     /*-------------------------------------------------------------*/
441800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0077                    */
441900000000     /* -Maquette-                                                  */
442000000000     /*-------------------------------------------------------------*/
442100000000
442200000000             RMVMSGD MSGID(TXT0077) MSGF(&LIB/&OBJ)
442300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
442400000000
442500000000             ADDMSGD +
442600000000                MSGID(TXT0077) +
442700000000                MSGF(&LIB/&OBJ) +
442800000000                MSG( +
442900000000'-Maquette-'                                                          +
443000000000                ) +
443100000000                SEV(0) +
443200000000     /*   No replacement variables defined!                         */ +
443300000000                ALROPT(*NO) +
443400000000                CCSID(65535) +
443500000000                /*  -EOF-  */
443600000000
443700000000     /*-------------------------------------------------------------*/
443800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0078                    */
443900000000     /* Rech.:                                                      */
444000000000     /*-------------------------------------------------------------*/
444100000000
444200000000             RMVMSGD MSGID(TXT0078) MSGF(&LIB/&OBJ)
444300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
444400000000
444500000000             ADDMSGD +
444600000000                MSGID(TXT0078) +
444700000000                MSGF(&LIB/&OBJ) +
444800000000                MSG( +
444900000000'Rech.:'                                                              +
445000000000                ) +
445100000000                SEV(0) +
445200000000     /*   No replacement variables defined!                         */ +
445300000000                ALROPT(*NO) +
445400000000                CCSID(65535) +
445500000000                /*  -EOF-  */
445600000000
445700000000     /*-------------------------------------------------------------*/
445800000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0079                    */
445900000000     /*  O   Enr.   Champ       Description                     Typ */
446000000000     /*-------------------------------------------------------------*/
446100000000
446200000000             RMVMSGD MSGID(TXT0079) MSGF(&LIB/&OBJ)
446300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
446400000000
446500000000             ADDMSGD +
446600000000                MSGID(TXT0079) +
446700000000                MSGF(&LIB/&OBJ) +
446800000000                MSG( +
446900000000' O   Enr.   Champ       Description                     Type      Pos-
447000000000.däb '                                                                +
447100000000                ) +
447200000000                SEV(0) +
447300000000     /*   No replacement variables defined!                         */ +
447400000000                ALROPT(*NO) +
447500000000                CCSID(65535) +
447600000000                /*  -EOF-  */
447700000000
447800000000     /*-------------------------------------------------------------*/
447900000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0080                    */
448000000000     /* Visible ..:                                                 */
448100000000     /*-------------------------------------------------------------*/
448200000000
448300000000             RMVMSGD MSGID(TXT0080) MSGF(&LIB/&OBJ)
448400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
448500000000
448600000000             ADDMSGD +
448700000000                MSGID(TXT0080) +
448800000000                MSGF(&LIB/&OBJ) +
448900000000                MSG( +
449000000000'Visible ..:'                                                         +
449100000000                ) +
449200000000                SEV(0) +
449300000000     /*   No replacement variables defined!                         */ +
449400000000                ALROPT(*NO) +
449500000000                CCSID(65535) +
449600000000                /*  -EOF-  */
449700000000
449800000000     /*-------------------------------------------------------------*/
449900000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0081                    */
450000000000     /* Couleur.:                                                   */
450100000000     /*-------------------------------------------------------------*/
450200000000
450300000000             RMVMSGD MSGID(TXT0081) MSGF(&LIB/&OBJ)
450400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
450500000000
450600000000             ADDMSGD +
450700000000                MSGID(TXT0081) +
450800000000                MSGF(&LIB/&OBJ) +
450900000000                MSG( +
451000000000'Couleur.:'                                                           +
451100000000                ) +
451200000000                SEV(0) +
451300000000     /*   No replacement variables defined!                         */ +
451400000000                ALROPT(*NO) +
451500000000                CCSID(65535) +
451600000000                /*  -EOF-  */
451700000000
451800000000     /*-------------------------------------------------------------*/
451900000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0082                    */
452000000000     /* Sälection :                                                 */
452100000000     /*-------------------------------------------------------------*/
452200000000
452300000000             RMVMSGD MSGID(TXT0082) MSGF(&LIB/&OBJ)
452400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
452500000000
452600000000             ADDMSGD +
452700000000                MSGID(TXT0082) +
452800000000                MSGF(&LIB/&OBJ) +
452900000000                MSG( +
453000000000'Sälection :'                                                         +
453100000000                ) +
453200000000                SEV(0) +
453300000000     /*   No replacement variables defined!                         */ +
453400000000                ALROPT(*NO) +
453500000000                CCSID(65535) +
453600000000                /*  -EOF-  */
453700000000
453800000000     /*-------------------------------------------------------------*/
453900000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0083                    */
454000000000     /* Largeur max                                                 */
454100000000     /*-------------------------------------------------------------*/
454200000000
454300000000             RMVMSGD MSGID(TXT0083) MSGF(&LIB/&OBJ)
454400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
454500000000
454600000000             ADDMSGD +
454700000000                MSGID(TXT0083) +
454800000000                MSGF(&LIB/&OBJ) +
454900000000                MSG( +
455000000000'Largeur max'                                                         +
455100000000                ) +
455200000000                SEV(0) +
455300000000     /*   No replacement variables defined!                         */ +
455400000000                ALROPT(*NO) +
455500000000                CCSID(65535) +
455600000000                /*  -EOF-  */
455700000000
455800000000     /*-------------------------------------------------------------*/
455900000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0084                    */
456000000000     /* Code Edi:                                                   */
456100000000     /*-------------------------------------------------------------*/
456200000000
456300000000             RMVMSGD MSGID(TXT0084) MSGF(&LIB/&OBJ)
456400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
456500000000
456600000000             ADDMSGD +
456700000000                MSGID(TXT0084) +
456800000000                MSGF(&LIB/&OBJ) +
456900000000                MSG( +
457000000000'Code Edi:'                                                           +
457100000000                ) +
457200000000                SEV(0) +
457300000000     /*   No replacement variables defined!                         */ +
457400000000                ALROPT(*NO) +
457500000000                CCSID(65535) +
457600000000                /*  -EOF-  */
457700000000
457800000000     /*-------------------------------------------------------------*/
457900000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0085                    */
458000000000     /* - Choix champ -                                             */
458100000000     /*-------------------------------------------------------------*/
458200000000
458300000000             RMVMSGD MSGID(TXT0085) MSGF(&LIB/&OBJ)
458400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
458500000000
458600000000             ADDMSGD +
458700000000                MSGID(TXT0085) +
458800000000                MSGF(&LIB/&OBJ) +
458900000000                MSG( +
459000000000'- Choix champ -'                                                     +
459100000000                ) +
459200000000                SEV(0) +
459300000000     /*   No replacement variables defined!                         */ +
459400000000                ALROPT(*NO) +
459500000000                CCSID(65535) +
459600000000                /*  -EOF-  */
459700000000
459800000000     /*-------------------------------------------------------------*/
459900000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0086                    */
460000000000     /*  O   Champ       Description                                */
460100000000     /*-------------------------------------------------------------*/
460200000000
460300000000             RMVMSGD MSGID(TXT0086) MSGF(&LIB/&OBJ)
460400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
460500000000
460600000000             ADDMSGD +
460700000000                MSGID(TXT0086) +
460800000000                MSGF(&LIB/&OBJ) +
460900000000                MSG( +
461000000000' O   Champ       Description                    '                    +
461100000000                ) +
461200000000                SEV(0) +
461300000000     /*   No replacement variables defined!                         */ +
461400000000                ALROPT(*NO) +
461500000000                CCSID(65535) +
461600000000                /*  -EOF-  */
461700000000
461800000000     /*-------------------------------------------------------------*/
461900000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0087                    */
462000000000     /*  O  Fichier                Description                      */
462100000000     /*-------------------------------------------------------------*/
462200000000
462300000000             RMVMSGD MSGID(TXT0087) MSGF(&LIB/&OBJ)
462400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
462500000000
462600000000             ADDMSGD +
462700000000                MSGID(TXT0087) +
462800000000                MSGF(&LIB/&OBJ) +
462900000000                MSG( +
463000000000' O  Fichier                Description                               -
463100000000   '                                                                  +
463200000000                ) +
463300000000                SEV(0) +
463400000000     /*   No replacement variables defined!                         */ +
463500000000                ALROPT(*NO) +
463600000000                CCSID(65535) +
463700000000                /*  -EOF-  */
463800000000
463900000000     /*-------------------------------------------------------------*/
464000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0088                    */
464100000000     /* -Afficher relations fichiers-                               */
464200000000     /*-------------------------------------------------------------*/
464300000000
464400000000             RMVMSGD MSGID(TXT0088) MSGF(&LIB/&OBJ)
464500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
464600000000
464700000000             ADDMSGD +
464800000000                MSGID(TXT0088) +
464900000000                MSGF(&LIB/&OBJ) +
465000000000                MSG( +
465100000000'-Afficher relations fichiers-'                                       +
465200000000                ) +
465300000000                SEV(0) +
465400000000     /*   No replacement variables defined!                         */ +
465500000000                ALROPT(*NO) +
465600000000                CCSID(65535) +
465700000000                /*  -EOF-  */
465800000000
465900000000     /*-------------------------------------------------------------*/
466000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0089                    */
466100000000     /* Däpendances:                                                */
466200000000     /*-------------------------------------------------------------*/
466300000000
466400000000             RMVMSGD MSGID(TXT0089) MSGF(&LIB/&OBJ)
466500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
466600000000
466700000000             ADDMSGD +
466800000000                MSGID(TXT0089) +
466900000000                MSGF(&LIB/&OBJ) +
467000000000                MSG( +
467100000000'Däpendances:'                                                        +
467200000000                ) +
467300000000                SEV(0) +
467400000000     /*   No replacement variables defined!                         */ +
467500000000                ALROPT(*NO) +
467600000000                CCSID(65535) +
467700000000                /*  -EOF-  */
467800000000
467900000000     /*-------------------------------------------------------------*/
468000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0090                    */
468100000000     /* Editeur Hexa                                                */
468200000000     /*-------------------------------------------------------------*/
468300000000
468400000000             RMVMSGD MSGID(TXT0090) MSGF(&LIB/&OBJ)
468500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
468600000000
468700000000             ADDMSGD +
468800000000                MSGID(TXT0090) +
468900000000                MSGF(&LIB/&OBJ) +
469000000000                MSG( +
469100000000'Editeur Hexa'                                                        +
469200000000                ) +
469300000000                SEV(0) +
469400000000     /*   No replacement variables defined!                         */ +
469500000000                ALROPT(*NO) +
469600000000                CCSID(65535) +
469700000000                /*  -EOF-  */
469800000000
469900000000     /*-------------------------------------------------------------*/
470000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0091                    */
470100000000     /* Champ .......:                                              */
470200000000     /*-------------------------------------------------------------*/
470300000000
470400000000             RMVMSGD MSGID(TXT0091) MSGF(&LIB/&OBJ)
470500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
470600000000
470700000000             ADDMSGD +
470800000000                MSGID(TXT0091) +
470900000000                MSGF(&LIB/&OBJ) +
471000000000                MSG( +
471100000000'Champ .......:'                                                      +
471200000000                ) +
471300000000                SEV(0) +
471400000000     /*   No replacement variables defined!                         */ +
471500000000                ALROPT(*NO) +
471600000000                CCSID(65535) +
471700000000                /*  -EOF-  */
471800000000
471900000000     /*-------------------------------------------------------------*/
472000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0092                    */
472100000000     /* Longueur ....:                                              */
472200000000     /*-------------------------------------------------------------*/
472300000000
472400000000             RMVMSGD MSGID(TXT0092) MSGF(&LIB/&OBJ)
472500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
472600000000
472700000000             ADDMSGD +
472800000000                MSGID(TXT0092) +
472900000000                MSGF(&LIB/&OBJ) +
473000000000                MSG( +
473100000000'Longueur ....:'                                                      +
473200000000                ) +
473300000000                SEV(0) +
473400000000     /*   No replacement variables defined!                         */ +
473500000000                ALROPT(*NO) +
473600000000                CCSID(65535) +
473700000000                /*  -EOF-  */
473800000000
473900000000     /*-------------------------------------------------------------*/
474000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0093                    */
474100000000     /* Contenu ...:                                                */
474200000000     /*-------------------------------------------------------------*/
474300000000
474400000000             RMVMSGD MSGID(TXT0093) MSGF(&LIB/&OBJ)
474500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
474600000000
474700000000             ADDMSGD +
474800000000                MSGID(TXT0093) +
474900000000                MSGF(&LIB/&OBJ) +
475000000000                MSG( +
475100000000'Contenu ...:'                                                        +
475200000000                ) +
475300000000                SEV(0) +
475400000000     /*   No replacement variables defined!                         */ +
475500000000                ALROPT(*NO) +
475600000000                CCSID(65535) +
475700000000                /*  -EOF-  */
475800000000
475900000000     /*-------------------------------------------------------------*/
476000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0094                    */
476100000000     /* Hexa ......:                                                */
476200000000     /*-------------------------------------------------------------*/
476300000000
476400000000             RMVMSGD MSGID(TXT0094) MSGF(&LIB/&OBJ)
476500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
476600000000
476700000000             ADDMSGD +
476800000000                MSGID(TXT0094) +
476900000000                MSGF(&LIB/&OBJ) +
477000000000                MSG( +
477100000000'Hexa ......:'                                                        +
477200000000                ) +
477300000000                SEV(0) +
477400000000     /*   No replacement variables defined!                         */ +
477500000000                ALROPT(*NO) +
477600000000                CCSID(65535) +
477700000000                /*  -EOF-  */
477800000000
477900000000     /*-------------------------------------------------------------*/
478000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0095                    */
478100000000     /* Position däb.:                                              */
478200000000     /*-------------------------------------------------------------*/
478300000000
478400000000             RMVMSGD MSGID(TXT0095) MSGF(&LIB/&OBJ)
478500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
478600000000
478700000000             ADDMSGD +
478800000000                MSGID(TXT0095) +
478900000000                MSGF(&LIB/&OBJ) +
479000000000                MSG( +
479100000000'Position däb.:'                                                      +
479200000000                ) +
479300000000                SEV(0) +
479400000000     /*   No replacement variables defined!                         */ +
479500000000                ALROPT(*NO) +
479600000000                CCSID(65535) +
479700000000                /*  -EOF-  */
479800000000
479900000000     /*-------------------------------------------------------------*/
480000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0096                    */
480100000000     /* Tail. Tampon                                                */
480200000000     /*-------------------------------------------------------------*/
480300000000
480400000000             RMVMSGD MSGID(TXT0096) MSGF(&LIB/&OBJ)
480500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
480600000000
480700000000             ADDMSGD +
480800000000                MSGID(TXT0096) +
480900000000                MSGF(&LIB/&OBJ) +
481000000000                MSG( +
481100000000'Tail. Tampon'                                                        +
481200000000                ) +
481300000000                SEV(0) +
481400000000     /*   No replacement variables defined!                         */ +
481500000000                ALROPT(*NO) +
481600000000                CCSID(65535) +
481700000000                /*  -EOF-  */
481800000000
481900000000     /*-------------------------------------------------------------*/
482000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0097                    */
482100000000     /*  A   Membre      Description                                */
482200000000     /*-------------------------------------------------------------*/
482300000000
482400000000             RMVMSGD MSGID(TXT0097) MSGF(&LIB/&OBJ)
482500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
482600000000
482700000000             ADDMSGD +
482800000000                MSGID(TXT0097) +
482900000000                MSGF(&LIB/&OBJ) +
483000000000                MSG( +
483100000000' A   Membre      Description                                        '+
483200000000                ) +
483300000000                SEV(0) +
483400000000     /*   No replacement variables defined!                         */ +
483500000000                ALROPT(*NO) +
483600000000                CCSID(65535) +
483700000000                /*  -EOF-  */
483800000000
483900000000     /*-------------------------------------------------------------*/
484000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0098                    */
484100000000     /*   - Choix Membre -                                          */
484200000000     /*-------------------------------------------------------------*/
484300000000
484400000000             RMVMSGD MSGID(TXT0098) MSGF(&LIB/&OBJ)
484500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
484600000000
484700000000             ADDMSGD +
484800000000                MSGID(TXT0098) +
484900000000                MSGF(&LIB/&OBJ) +
485000000000                MSG( +
485100000000'  - Choix Membre -   '                                               +
485200000000                ) +
485300000000                SEV(0) +
485400000000     /*   No replacement variables defined!                         */ +
485500000000                ALROPT(*NO) +
485600000000                CCSID(65535) +
485700000000                /*  -EOF-  */
485800000000
485900000000     /*-------------------------------------------------------------*/
486000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0099                    */
486100000000     /*  NÄ membre :                                                */
486200000000     /*-------------------------------------------------------------*/
486300000000
486400000000             RMVMSGD MSGID(TXT0099) MSGF(&LIB/&OBJ)
486500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
486600000000
486700000000             ADDMSGD +
486800000000                MSGID(TXT0099) +
486900000000                MSGF(&LIB/&OBJ) +
487000000000                MSG( +
487100000000' NÄ membre :'                                                        +
487200000000                ) +
487300000000                SEV(0) +
487400000000     /*   No replacement variables defined!                         */ +
487500000000                ALROPT(*NO) +
487600000000                CCSID(65535) +
487700000000                /*  -EOF-  */
487800000000
487900000000     /*-------------------------------------------------------------*/
488000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0100                    */
488100000000     /* Mbr   :                                                     */
488200000000     /*-------------------------------------------------------------*/
488300000000
488400000000             RMVMSGD MSGID(TXT0100) MSGF(&LIB/&OBJ)
488500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
488600000000
488700000000             ADDMSGD +
488800000000                MSGID(TXT0100) +
488900000000                MSGF(&LIB/&OBJ) +
489000000000                MSG( +
489100000000'Mbr   :'                                                             +
489200000000                ) +
489300000000                SEV(0) +
489400000000     /*   No replacement variables defined!                         */ +
489500000000                ALROPT(*NO) +
489600000000                CCSID(65535) +
489700000000                /*  -EOF-  */
489800000000
489900000000     /*-------------------------------------------------------------*/
490000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0101                    */
490100000000     /* - Peek/400 -                                                */
490200000000     /*-------------------------------------------------------------*/
490300000000
490400000000             RMVMSGD MSGID(TXT0101) MSGF(&LIB/&OBJ)
490500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
490600000000
490700000000             ADDMSGD +
490800000000                MSGID(TXT0101) +
490900000000                MSGF(&LIB/&OBJ) +
491000000000                MSG( +
491100000000'- Peek/400 -'                                                        +
491200000000                ) +
491300000000                SEV(0) +
491400000000     /*   No replacement variables defined!                         */ +
491500000000                ALROPT(*NO) +
491600000000                CCSID(65535) +
491700000000                /*  -EOF-  */
491800000000
491900000000     /*-------------------------------------------------------------*/
492000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0102                    */
492100000000     /* Date  . . .                                                 */
492200000000     /*-------------------------------------------------------------*/
492300000000
492400000000             RMVMSGD MSGID(TXT0102) MSGF(&LIB/&OBJ)
492500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
492600000000
492700000000             ADDMSGD +
492800000000                MSGID(TXT0102) +
492900000000                MSGF(&LIB/&OBJ) +
493000000000                MSG( +
493100000000'Date  . . .'                                                         +
493200000000                ) +
493300000000                SEV(0) +
493400000000     /*   No replacement variables defined!                         */ +
493500000000                ALROPT(*NO) +
493600000000                CCSID(65535) +
493700000000                /*  -EOF-  */
493800000000
493900000000     /*-------------------------------------------------------------*/
494000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0103                    */
494100000000     /* Version . .                                                 */
494200000000     /*-------------------------------------------------------------*/
494300000000
494400000000             RMVMSGD MSGID(TXT0103) MSGF(&LIB/&OBJ)
494500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
494600000000
494700000000             ADDMSGD +
494800000000                MSGID(TXT0103) +
494900000000                MSGF(&LIB/&OBJ) +
495000000000                MSG( +
495100000000'Version . .'                                                         +
495200000000                ) +
495300000000                SEV(0) +
495400000000     /*   No replacement variables defined!                         */ +
495500000000                ALROPT(*NO) +
495600000000                CCSID(65535) +
495700000000                /*  -EOF-  */
495800000000
495900000000     /*-------------------------------------------------------------*/
496000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0104                    */
496100000000     /* E-mail  . .                                                 */
496200000000     /*-------------------------------------------------------------*/
496300000000
496400000000             RMVMSGD MSGID(TXT0104) MSGF(&LIB/&OBJ)
496500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
496600000000
496700000000             ADDMSGD +
496800000000                MSGID(TXT0104) +
496900000000                MSGF(&LIB/&OBJ) +
497000000000                MSG( +
497100000000'E-mail  . .'                                                         +
497200000000                ) +
497300000000                SEV(0) +
497400000000     /*   No replacement variables defined!                         */ +
497500000000                ALROPT(*NO) +
497600000000                CCSID(65535) +
497700000000                /*  -EOF-  */
497800000000
497900000000     /*-------------------------------------------------------------*/
498000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0105                    */
498100000000     /* Homepage  .                                                 */
498200000000     /*-------------------------------------------------------------*/
498300000000
498400000000             RMVMSGD MSGID(TXT0105) MSGF(&LIB/&OBJ)
498500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
498600000000
498700000000             ADDMSGD +
498800000000                MSGID(TXT0105) +
498900000000                MSGF(&LIB/&OBJ) +
499000000000                MSG( +
499100000000'Homepage  .'                                                         +
499200000000                ) +
499300000000                SEV(0) +
499400000000     /*   No replacement variables defined!                         */ +
499500000000                ALROPT(*NO) +
499600000000                CCSID(65535) +
499700000000                /*  -EOF-  */
499800000000
499900000000     /*-------------------------------------------------------------*/
500000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0106                    */
500100000000     /* Fixer champs                                                */
500200000000     /*-------------------------------------------------------------*/
500300000000
500400000000             RMVMSGD MSGID(TXT0106) MSGF(&LIB/&OBJ)
500500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
500600000000
500700000000             ADDMSGD +
500800000000                MSGID(TXT0106) +
500900000000                MSGF(&LIB/&OBJ) +
501000000000                MSG( +
501100000000'Fixer champs'                                                        +
501200000000                ) +
501300000000                SEV(0) +
501400000000     /*   No replacement variables defined!                         */ +
501500000000                ALROPT(*NO) +
501600000000                CCSID(65535) +
501700000000                /*  -EOF-  */
501800000000
501900000000     /*-------------------------------------------------------------*/
502000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0107                    */
502100000000     /*  NÄEnr. Champ       Description                      Champ  */
502200000000     /*-------------------------------------------------------------*/
502300000000
502400000000             RMVMSGD MSGID(TXT0107) MSGF(&LIB/&OBJ)
502500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
502600000000
502700000000             ADDMSGD +
502800000000                MSGID(TXT0107) +
502900000000                MSGF(&LIB/&OBJ) +
503000000000                MSG( +
503100000000' NÄEnr. Champ       Description                      Champ clä'      +
503200000000                ) +
503300000000                SEV(0) +
503400000000     /*   No replacement variables defined!                         */ +
503500000000                ALROPT(*NO) +
503600000000                CCSID(65535) +
503700000000                /*  -EOF-  */
503800000000
503900000000     /*-------------------------------------------------------------*/
504000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0108                    */
504100000000     /* - Sälection SQL -                                           */
504200000000     /*-------------------------------------------------------------*/
504300000000
504400000000             RMVMSGD MSGID(TXT0108) MSGF(&LIB/&OBJ)
504500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
504600000000
504700000000             ADDMSGD +
504800000000                MSGID(TXT0108) +
504900000000                MSGF(&LIB/&OBJ) +
505000000000                MSG( +
505100000000'- Sälection SQL -'                                                   +
505200000000                ) +
505300000000                SEV(0) +
505400000000     /*   No replacement variables defined!                         */ +
505500000000                ALROPT(*NO) +
505600000000                CCSID(65535) +
505700000000                /*  -EOF-  */
505800000000
505900000000     /*-------------------------------------------------------------*/
506000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0109                    */
506100000000     /* WHERE  ....:                                                */
506200000000     /*-------------------------------------------------------------*/
506300000000
506400000000             RMVMSGD MSGID(TXT0109) MSGF(&LIB/&OBJ)
506500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
506600000000
506700000000             ADDMSGD +
506800000000                MSGID(TXT0109) +
506900000000                MSGF(&LIB/&OBJ) +
507000000000                MSG( +
507100000000'WHERE  ....:'                                                        +
507200000000                ) +
507300000000                SEV(0) +
507400000000     /*   No replacement variables defined!                         */ +
507500000000                ALROPT(*NO) +
507600000000                CCSID(65535) +
507700000000                /*  -EOF-  */
507800000000
507900000000     /*-------------------------------------------------------------*/
508000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0110                    */
508100000000     /* ORDER BY  .:                                                */
508200000000     /*-------------------------------------------------------------*/
508300000000
508400000000             RMVMSGD MSGID(TXT0110) MSGF(&LIB/&OBJ)
508500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
508600000000
508700000000             ADDMSGD +
508800000000                MSGID(TXT0110) +
508900000000                MSGF(&LIB/&OBJ) +
509000000000                MSG( +
509100000000'ORDER BY  .:'                                                        +
509200000000                ) +
509300000000                SEV(0) +
509400000000     /*   No replacement variables defined!                         */ +
509500000000                ALROPT(*NO) +
509600000000                CCSID(65535) +
509700000000                /*  -EOF-  */
509800000000
509900000000     /*-------------------------------------------------------------*/
510000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0111                    */
510100000000     /* -Cräer Programme M§j-                                       */
510200000000     /*-------------------------------------------------------------*/
510300000000
510400000000             RMVMSGD MSGID(TXT0111) MSGF(&LIB/&OBJ)
510500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
510600000000
510700000000             ADDMSGD +
510800000000                MSGID(TXT0111) +
510900000000                MSGF(&LIB/&OBJ) +
511000000000                MSG( +
511100000000'-Cräer Programme M§j-'                                               +
511200000000                ) +
511300000000                SEV(0) +
511400000000     /*   No replacement variables defined!                         */ +
511500000000                ALROPT(*NO) +
511600000000                CCSID(65535) +
511700000000                /*  -EOF-  */
511800000000
511900000000     /*-------------------------------------------------------------*/
512000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0112                    */
512100000000     /* Minuscules admises.... ?                                    */
512200000000     /*-------------------------------------------------------------*/
512300000000
512400000000             RMVMSGD MSGID(TXT0112) MSGF(&LIB/&OBJ)
512500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
512600000000
512700000000             ADDMSGD +
512800000000                MSGID(TXT0112) +
512900000000                MSGF(&LIB/&OBJ) +
513000000000                MSG( +
513100000000'Minuscules admises.... ?'                                            +
513200000000                ) +
513300000000                SEV(0) +
513400000000     /*   No replacement variables defined!                         */ +
513500000000                ALROPT(*NO) +
513600000000                CCSID(65535) +
513700000000                /*  -EOF-  */
513800000000
513900000000     /*-------------------------------------------------------------*/
514000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0113                    */
514100000000     /* Minuscules par däfaut. ?                                    */
514200000000     /*-------------------------------------------------------------*/
514300000000
514400000000             RMVMSGD MSGID(TXT0113) MSGF(&LIB/&OBJ)
514500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
514600000000
514700000000             ADDMSGD +
514800000000                MSGID(TXT0113) +
514900000000                MSGF(&LIB/&OBJ) +
515000000000                MSG( +
515100000000'Minuscules par däfaut. ?'                                            +
515200000000                ) +
515300000000                SEV(0) +
515400000000     /*   No replacement variables defined!                         */ +
515500000000                ALROPT(*NO) +
515600000000                CCSID(65535) +
515700000000                /*  -EOF-  */
515800000000
515900000000     /*-------------------------------------------------------------*/
516000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0114                    */
516100000000     /* Sauvegarder par däfaut ?                                    */
516200000000     /*-------------------------------------------------------------*/
516300000000
516400000000             RMVMSGD MSGID(TXT0114) MSGF(&LIB/&OBJ)
516500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
516600000000
516700000000             ADDMSGD +
516800000000                MSGID(TXT0114) +
516900000000                MSGF(&LIB/&OBJ) +
517000000000                MSG( +
517100000000'Sauvegarder par däfaut ?'                                            +
517200000000                ) +
517300000000                SEV(0) +
517400000000     /*   No replacement variables defined!                         */ +
517500000000                ALROPT(*NO) +
517600000000                CCSID(65535) +
517700000000                /*  -EOF-  */
517800000000
517900000000     /*-------------------------------------------------------------*/
518000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0115                    */
518100000000     /* Sälection SQL                                               */
518200000000     /*-------------------------------------------------------------*/
518300000000
518400000000             RMVMSGD MSGID(TXT0115) MSGF(&LIB/&OBJ)
518500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
518600000000
518700000000             ADDMSGD +
518800000000                MSGID(TXT0115) +
518900000000                MSGF(&LIB/&OBJ) +
519000000000                MSG( +
519100000000'Sälection SQL'                                                       +
519200000000                ) +
519300000000                SEV(0) +
519400000000     /*   No replacement variables defined!                         */ +
519500000000                ALROPT(*NO) +
519600000000                CCSID(65535) +
519700000000                /*  -EOF-  */
519800000000
519900000000     /*-------------------------------------------------------------*/
520000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0116                    */
520100000000     /*    Choix Environment                                        */
520200000000     /*-------------------------------------------------------------*/
520300000000
520400000000             RMVMSGD MSGID(TXT0116) MSGF(&LIB/&OBJ)
520500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
520600000000
520700000000             ADDMSGD +
520800000000                MSGID(TXT0116) +
520900000000                MSGF(&LIB/&OBJ) +
521000000000                MSG( +
521100000000'   Choix Environment    '                                            +
521200000000                ) +
521300000000                SEV(0) +
521400000000     /*   No replacement variables defined!                         */ +
521500000000                ALROPT(*NO) +
521600000000                CCSID(65535) +
521700000000                /*  -EOF-  */
521800000000
521900000000     /*-------------------------------------------------------------*/
522000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0117                    */
522100000000     /* Fich.:                                                      */
522200000000     /*-------------------------------------------------------------*/
522300000000
522400000000             RMVMSGD MSGID(TXT0117) MSGF(&LIB/&OBJ)
522500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
522600000000
522700000000             ADDMSGD +
522800000000                MSGID(TXT0117) +
522900000000                MSGF(&LIB/&OBJ) +
523000000000                MSG( +
523100000000'Fich.:'                                                              +
523200000000                ) +
523300000000                SEV(0) +
523400000000     /*   No replacement variables defined!                         */ +
523500000000                ALROPT(*NO) +
523600000000                CCSID(65535) +
523700000000                /*  -EOF-  */
523800000000
523900000000     /*-------------------------------------------------------------*/
524000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0118                    */
524100000000     /* Biblioth..:                                                 */
524200000000     /*-------------------------------------------------------------*/
524300000000
524400000000             RMVMSGD MSGID(TXT0118) MSGF(&LIB/&OBJ)
524500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
524600000000
524700000000             ADDMSGD +
524800000000                MSGID(TXT0118) +
524900000000                MSGF(&LIB/&OBJ) +
525000000000                MSG( +
525100000000'Biblioth..:'                                                         +
525200000000                ) +
525300000000                SEV(0) +
525400000000     /*   No replacement variables defined!                         */ +
525500000000                ALROPT(*NO) +
525600000000                CCSID(65535) +
525700000000                /*  -EOF-  */
525800000000
525900000000     /*-------------------------------------------------------------*/
526000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0119                    */
526100000000     /*  A   Description  environnement                             */
526200000000     /*-------------------------------------------------------------*/
526300000000
526400000000             RMVMSGD MSGID(TXT0119) MSGF(&LIB/&OBJ)
526500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
526600000000
526700000000             ADDMSGD +
526800000000                MSGID(TXT0119) +
526900000000                MSGF(&LIB/&OBJ) +
527000000000                MSG( +
527100000000' A   Description  environnement'                                     +
527200000000                ) +
527300000000                SEV(0) +
527400000000     /*   No replacement variables defined!                         */ +
527500000000                ALROPT(*NO) +
527600000000                CCSID(65535) +
527700000000                /*  -EOF-  */
527800000000
527900000000     /*-------------------------------------------------------------*/
528000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0120                    */
528100000000     /* Supprimer environnement                                     */
528200000000     /*-------------------------------------------------------------*/
528300000000
528400000000             RMVMSGD MSGID(TXT0120) MSGF(&LIB/&OBJ)
528500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
528600000000
528700000000             ADDMSGD +
528800000000                MSGID(TXT0120) +
528900000000                MSGF(&LIB/&OBJ) +
529000000000                MSG( +
529100000000'Supprimer environnement'                                             +
529200000000                ) +
529300000000                SEV(0) +
529400000000     /*   No replacement variables defined!                         */ +
529500000000                ALROPT(*NO) +
529600000000                CCSID(65535) +
529700000000                /*  -EOF-  */
529800000000
529900000000     /*-------------------------------------------------------------*/
530000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0121                    */
530100000000     /* Fichier . . :                                               */
530200000000     /*-------------------------------------------------------------*/
530300000000
530400000000             RMVMSGD MSGID(TXT0121) MSGF(&LIB/&OBJ)
530500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
530600000000
530700000000             ADDMSGD +
530800000000                MSGID(TXT0121) +
530900000000                MSGF(&LIB/&OBJ) +
531000000000                MSG( +
531100000000'Fichier . . :'                                                       +
531200000000                ) +
531300000000                SEV(0) +
531400000000     /*   No replacement variables defined!                         */ +
531500000000                ALROPT(*NO) +
531600000000                CCSID(65535) +
531700000000                /*  -EOF-  */
531800000000
531900000000     /*-------------------------------------------------------------*/
532000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0122                    */
532100000000     /* Biblioth. :                                                 */
532200000000     /*-------------------------------------------------------------*/
532300000000
532400000000             RMVMSGD MSGID(TXT0122) MSGF(&LIB/&OBJ)
532500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
532600000000
532700000000             ADDMSGD +
532800000000                MSGID(TXT0122) +
532900000000                MSGF(&LIB/&OBJ) +
533000000000                MSG( +
533100000000'Biblioth. :'                                                         +
533200000000                ) +
533300000000                SEV(0) +
533400000000     /*   No replacement variables defined!                         */ +
533500000000                ALROPT(*NO) +
533600000000                CCSID(65535) +
533700000000                /*  -EOF-  */
533800000000
533900000000     /*-------------------------------------------------------------*/
534000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0123                    */
534100000000     /* Membre  . . :                                               */
534200000000     /*-------------------------------------------------------------*/
534300000000
534400000000             RMVMSGD MSGID(TXT0123) MSGF(&LIB/&OBJ)
534500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
534600000000
534700000000             ADDMSGD +
534800000000                MSGID(TXT0123) +
534900000000                MSGF(&LIB/&OBJ) +
535000000000                MSG( +
535100000000'Membre  . . :'                                                       +
535200000000                ) +
535300000000                SEV(0) +
535400000000     /*   No replacement variables defined!                         */ +
535500000000                ALROPT(*NO) +
535600000000                CCSID(65535) +
535700000000                /*  -EOF-  */
535800000000
535900000000     /*-------------------------------------------------------------*/
536000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0124                    */
536100000000     /* Description :                                               */
536200000000     /*-------------------------------------------------------------*/
536300000000
536400000000             RMVMSGD MSGID(TXT0124) MSGF(&LIB/&OBJ)
536500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
536600000000
536700000000             ADDMSGD +
536800000000                MSGID(TXT0124) +
536900000000                MSGF(&LIB/&OBJ) +
537000000000                MSG( +
537100000000'Description :'                                                       +
537200000000                ) +
537300000000                SEV(0) +
537400000000     /*   No replacement variables defined!                         */ +
537500000000                ALROPT(*NO) +
537600000000                CCSID(65535) +
537700000000                /*  -EOF-  */
537800000000
537900000000     /*-------------------------------------------------------------*/
538000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0125                    */
538100000000     /* Long.variable:                                              */
538200000000     /*-------------------------------------------------------------*/
538300000000
538400000000             RMVMSGD MSGID(TXT0125) MSGF(&LIB/&OBJ)
538500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
538600000000
538700000000             ADDMSGD +
538800000000                MSGID(TXT0125) +
538900000000                MSGF(&LIB/&OBJ) +
539000000000                MSG( +
539100000000'Long.variable:'                                                      +
539200000000                ) +
539300000000                SEV(0) +
539400000000     /*   No replacement variables defined!                         */ +
539500000000                ALROPT(*NO) +
539600000000                CCSID(65535) +
539700000000                /*  -EOF-  */
539800000000
539900000000     /*-------------------------------------------------------------*/
540000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0126                    */
540100000000     /* - Sälect. Format Enreg. -                                   */
540200000000     /*-------------------------------------------------------------*/
540300000000
540400000000             RMVMSGD MSGID(TXT0126) MSGF(&LIB/&OBJ)
540500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
540600000000
540700000000             ADDMSGD +
540800000000                MSGID(TXT0126) +
540900000000                MSGF(&LIB/&OBJ) +
541000000000                MSG( +
541100000000'- Sälect. Format Enreg. -'                                           +
541200000000                ) +
541300000000                SEV(0) +
541400000000     /*   No replacement variables defined!                         */ +
541500000000                ALROPT(*NO) +
541600000000                CCSID(65535) +
541700000000                /*  -EOF-  */
541800000000
541900000000     /*-------------------------------------------------------------*/
542000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0127                    */
542100000000     /* NULL value                                                  */
542200000000     /*-------------------------------------------------------------*/
542300000000
542400000000             RMVMSGD MSGID(TXT0127) MSGF(&LIB/&OBJ)
542500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
542600000000
542700000000             ADDMSGD +
542800000000                MSGID(TXT0127) +
542900000000                MSGF(&LIB/&OBJ) +
543000000000                MSG( +
543100000000'NULL value'                                                          +
543200000000                ) +
543300000000                SEV(0) +
543400000000     /*   No replacement variables defined!                         */ +
543500000000                ALROPT(*NO) +
543600000000                CCSID(65535) +
543700000000                /*  -EOF-  */
543800000000
543900000000     /*-------------------------------------------------------------*/
544000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0128                    */
544100000000     /* Editeur                                                     */
544200000000     /*-------------------------------------------------------------*/
544300000000
544400000000             RMVMSGD MSGID(TXT0128) MSGF(&LIB/&OBJ)
544500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
544600000000
544700000000             ADDMSGD +
544800000000                MSGID(TXT0128) +
544900000000                MSGF(&LIB/&OBJ) +
545000000000                MSG( +
545100000000'Editeur'                                                             +
545200000000                ) +
545300000000                SEV(0) +
545400000000     /*   No replacement variables defined!                         */ +
545500000000                ALROPT(*NO) +
545600000000                CCSID(65535) +
545700000000                /*  -EOF-  */
545800000000
545900000000     /*-------------------------------------------------------------*/
546000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0129                    */
546100000000     /* ***Enreg.verouillä***                                       */
546200000000     /*-------------------------------------------------------------*/
546300000000
546400000000             RMVMSGD MSGID(TXT0129) MSGF(&LIB/&OBJ)
546500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
546600000000
546700000000             ADDMSGD +
546800000000                MSGID(TXT0129) +
546900000000                MSGF(&LIB/&OBJ) +
547000000000                MSG( +
547100000000'***Enreg.verouillä***'                                               +
547200000000                ) +
547300000000                SEV(0) +
547400000000     /*   No replacement variables defined!                         */ +
547500000000                ALROPT(*NO) +
547600000000                CCSID(65535) +
547700000000                /*  -EOF-  */
547800000000
547900000000     /*-------------------------------------------------------------*/
548000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0130                    */
548100000000     /* Enreg. däverouillä                                          */
548200000000     /*-------------------------------------------------------------*/
548300000000
548400000000             RMVMSGD MSGID(TXT0130) MSGF(&LIB/&OBJ)
548500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
548600000000
548700000000             ADDMSGD +
548800000000                MSGID(TXT0130) +
548900000000                MSGF(&LIB/&OBJ) +
549000000000                MSG( +
549100000000'Enreg. däverouillä'                                                  +
549200000000                ) +
549300000000                SEV(0) +
549400000000     /*   No replacement variables defined!                         */ +
549500000000                ALROPT(*NO) +
549600000000                CCSID(65535) +
549700000000                /*  -EOF-  */
549800000000
549900000000     /*-------------------------------------------------------------*/
550000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0131                    */
550100000000     /* Verrouiller enregistr. ?                                    */
550200000000     /*-------------------------------------------------------------*/
550300000000
550400000000             RMVMSGD MSGID(TXT0131) MSGF(&LIB/&OBJ)
550500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
550600000000
550700000000             ADDMSGD +
550800000000                MSGID(TXT0131) +
550900000000                MSGF(&LIB/&OBJ) +
551000000000                MSG( +
551100000000'Verrouiller enregistr. ?'                                            +
551200000000                ) +
551300000000                SEV(0) +
551400000000     /*   No replacement variables defined!                         */ +
551500000000                ALROPT(*NO) +
551600000000                CCSID(65535) +
551700000000                /*  -EOF-  */
551800000000
551900000000     /*-------------------------------------------------------------*/
552000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0132                    */
552100000000     /* Fich.:                                                      */
552200000000     /*-------------------------------------------------------------*/
552300000000
552400000000             RMVMSGD MSGID(TXT0132) MSGF(&LIB/&OBJ)
552500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
552600000000
552700000000             ADDMSGD +
552800000000                MSGID(TXT0132) +
552900000000                MSGF(&LIB/&OBJ) +
553000000000                MSG( +
553100000000'Fich.:'                                                              +
553200000000                ) +
553300000000                SEV(0) +
553400000000     /*   No replacement variables defined!                         */ +
553500000000                ALROPT(*NO) +
553600000000                CCSID(65535) +
553700000000                /*  -EOF-  */
553800000000
553900000000     /*-------------------------------------------------------------*/
554000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0133                    */
554100000000     /*   Biblioth:                                                 */
554200000000     /*-------------------------------------------------------------*/
554300000000
554400000000             RMVMSGD MSGID(TXT0133) MSGF(&LIB/&OBJ)
554500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
554600000000
554700000000             ADDMSGD +
554800000000                MSGID(TXT0133) +
554900000000                MSGF(&LIB/&OBJ) +
555000000000                MSG( +
555100000000'  Biblioth:'                                                         +
555200000000                ) +
555300000000                SEV(0) +
555400000000     /*   No replacement variables defined!                         */ +
555500000000                ALROPT(*NO) +
555600000000                CCSID(65535) +
555700000000                /*  -EOF-  */
555800000000
555900000000     /*-------------------------------------------------------------*/
556000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0134                    */
556100000000     /* Enr:                                                        */
556200000000     /*-------------------------------------------------------------*/
556300000000
556400000000             RMVMSGD MSGID(TXT0134) MSGF(&LIB/&OBJ)
556500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
556600000000
556700000000             ADDMSGD +
556800000000                MSGID(TXT0134) +
556900000000                MSGF(&LIB/&OBJ) +
557000000000                MSG( +
557100000000'Enr:'                                                                +
557200000000                ) +
557300000000                SEV(0) +
557400000000     /*   No replacement variables defined!                         */ +
557500000000                ALROPT(*NO) +
557600000000                CCSID(65535) +
557700000000                /*  -EOF-  */
557800000000
557900000000     /*-------------------------------------------------------------*/
558000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0135                    */
558100000000     /*  Page:                                                      */
558200000000     /*-------------------------------------------------------------*/
558300000000
558400000000             RMVMSGD MSGID(TXT0135) MSGF(&LIB/&OBJ)
558500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
558600000000
558700000000             ADDMSGD +
558800000000                MSGID(TXT0135) +
558900000000                MSGF(&LIB/&OBJ) +
559000000000                MSG( +
559100000000' Page:'                                                              +
559200000000                ) +
559300000000                SEV(0) +
559400000000     /*   No replacement variables defined!                         */ +
559500000000                ALROPT(*NO) +
559600000000                CCSID(65535) +
559700000000                /*  -EOF-  */
559800000000
559900000000     /*-------------------------------------------------------------*/
560000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0136                    */
560100000000     /* Nom champ                                                   */
560200000000     /*-------------------------------------------------------------*/
560300000000
560400000000             RMVMSGD MSGID(TXT0136) MSGF(&LIB/&OBJ)
560500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
560600000000
560700000000             ADDMSGD +
560800000000                MSGID(TXT0136) +
560900000000                MSGF(&LIB/&OBJ) +
561000000000                MSG( +
561100000000'Nom champ'                                                           +
561200000000                ) +
561300000000                SEV(0) +
561400000000     /*   No replacement variables defined!                         */ +
561500000000                ALROPT(*NO) +
561600000000                CCSID(65535) +
561700000000                /*  -EOF-  */
561800000000
561900000000     /*-------------------------------------------------------------*/
562000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0137                    */
562100000000     /* Description champ                                           */
562200000000     /*-------------------------------------------------------------*/
562300000000
562400000000             RMVMSGD MSGID(TXT0137) MSGF(&LIB/&OBJ)
562500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
562600000000
562700000000             ADDMSGD +
562800000000                MSGID(TXT0137) +
562900000000                MSGF(&LIB/&OBJ) +
563000000000                MSG( +
563100000000'Description champ'                                                   +
563200000000                ) +
563300000000                SEV(0) +
563400000000     /*   No replacement variables defined!                         */ +
563500000000                ALROPT(*NO) +
563600000000                CCSID(65535) +
563700000000                /*  -EOF-  */
563800000000
563900000000     /*-------------------------------------------------------------*/
564000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0138                    */
564100000000     /* Valeur champ                                                */
564200000000     /*-------------------------------------------------------------*/
564300000000
564400000000             RMVMSGD MSGID(TXT0138) MSGF(&LIB/&OBJ)
564500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
564600000000
564700000000             ADDMSGD +
564800000000                MSGID(TXT0138) +
564900000000                MSGF(&LIB/&OBJ) +
565000000000                MSG( +
565100000000'Valeur champ'                                                        +
565200000000                ) +
565300000000                SEV(0) +
565400000000     /*   No replacement variables defined!                         */ +
565500000000                ALROPT(*NO) +
565600000000                CCSID(65535) +
565700000000                /*  -EOF-  */
565800000000
565900000000     /*-------------------------------------------------------------*/
566000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0139                    */
566100000000     /* Texte                                                       */
566200000000     /*-------------------------------------------------------------*/
566300000000
566400000000             RMVMSGD MSGID(TXT0139) MSGF(&LIB/&OBJ)
566500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
566600000000
566700000000             ADDMSGD +
566800000000                MSGID(TXT0139) +
566900000000                MSGF(&LIB/&OBJ) +
567000000000                MSG( +
567100000000'Texte'                                                               +
567200000000                ) +
567300000000                SEV(0) +
567400000000     /*   No replacement variables defined!                         */ +
567500000000                ALROPT(*NO) +
567600000000                CCSID(65535) +
567700000000                /*  -EOF-  */
567800000000
567900000000     /*-------------------------------------------------------------*/
568000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0140                    */
568100000000     /*  O   Opt  Description                                       */
568200000000     /*-------------------------------------------------------------*/
568300000000
568400000000             RMVMSGD MSGID(TXT0140) MSGF(&LIB/&OBJ)
568500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
568600000000
568700000000             ADDMSGD +
568800000000                MSGID(TXT0140) +
568900000000                MSGF(&LIB/&OBJ) +
569000000000                MSG( +
569100000000' O   Opt  Description                 '                              +
569200000000                ) +
569300000000                SEV(0) +
569400000000     /*   No replacement variables defined!                         */ +
569500000000                ALROPT(*NO) +
569600000000                CCSID(65535) +
569700000000                /*  -EOF-  */
569800000000
569900000000     /*-------------------------------------------------------------*/
570000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0141                    */
570100000000     /* ----- Options utilisateur  -----                            */
570200000000     /*-------------------------------------------------------------*/
570300000000
570400000000             RMVMSGD MSGID(TXT0141) MSGF(&LIB/&OBJ)
570500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
570600000000
570700000000             ADDMSGD +
570800000000                MSGID(TXT0141) +
570900000000                MSGF(&LIB/&OBJ) +
571000000000                MSG( +
571100000000'----- Options utilisateur  ----- '                                   +
571200000000                ) +
571300000000                SEV(0) +
571400000000     /*   No replacement variables defined!                         */ +
571500000000                ALROPT(*NO) +
571600000000                CCSID(65535) +
571700000000                /*  -EOF-  */
571800000000
571900000000     /*-------------------------------------------------------------*/
572000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0142                    */
572100000000     /*  O   Fichier     Bibliothüque Description                   */
572200000000     /*-------------------------------------------------------------*/
572300000000
572400000000             RMVMSGD MSGID(TXT0142) MSGF(&LIB/&OBJ)
572500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
572600000000
572700000000             ADDMSGD +
572800000000                MSGID(TXT0142) +
572900000000                MSGF(&LIB/&OBJ) +
573000000000                MSG( +
573100000000' O   Fichier     Bibliothüque Description'                           +
573200000000                ) +
573300000000                SEV(0) +
573400000000     /*   No replacement variables defined!                         */ +
573500000000                ALROPT(*NO) +
573600000000                CCSID(65535) +
573700000000                /*  -EOF-  */
573800000000
573900000000     /*-------------------------------------------------------------*/
574000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0143                    */
574100000000     /*  -Fichier sälec.-                                           */
574200000000     /*-------------------------------------------------------------*/
574300000000
574400000000             RMVMSGD MSGID(TXT0143) MSGF(&LIB/&OBJ)
574500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
574600000000
574700000000             ADDMSGD +
574800000000                MSGID(TXT0143) +
574900000000                MSGF(&LIB/&OBJ) +
575000000000                MSG( +
575100000000' -Fichier sälec.-'                                                   +
575200000000                ) +
575300000000                SEV(0) +
575400000000     /*   No replacement variables defined!                         */ +
575500000000                ALROPT(*NO) +
575600000000                CCSID(65535) +
575700000000                /*  -EOF-  */
575800000000
575900000000     /*-------------------------------------------------------------*/
576000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0144                    */
576100000000     /* Initialise champs NULL ?                                    */
576200000000     /*-------------------------------------------------------------*/
576300000000
576400000000             RMVMSGD MSGID(TXT0144) MSGF(&LIB/&OBJ)
576500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
576600000000
576700000000             ADDMSGD +
576800000000                MSGID(TXT0144) +
576900000000                MSGF(&LIB/&OBJ) +
577000000000                MSG( +
577100000000'Initialise champs NULL ?'                                            +
577200000000                ) +
577300000000                SEV(0) +
577400000000     /*   No replacement variables defined!                         */ +
577500000000                ALROPT(*NO) +
577600000000                CCSID(65535) +
577700000000                /*  -EOF-  */
577800000000
577900000000     /*-------------------------------------------------------------*/
578000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0145                    */
578100000000     /* Conserve pos. curseur. ?                                    */
578200000000     /*-------------------------------------------------------------*/
578300000000
578400000000             RMVMSGD MSGID(TXT0145) MSGF(&LIB/&OBJ)
578500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
578600000000
578700000000             ADDMSGD +
578800000000                MSGID(TXT0145) +
578900000000                MSGF(&LIB/&OBJ) +
579000000000                MSG( +
579100000000'Conserve pos. curseur. ?'                                            +
579200000000                ) +
579300000000                SEV(0) +
579400000000     /*   No replacement variables defined!                         */ +
579500000000                ALROPT(*NO) +
579600000000                CCSID(65535) +
579700000000                /*  -EOF-  */
579800000000
579900000000     /*-------------------------------------------------------------*/
580000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0146                    */
580100000000     /* Insärer                                                     */
580200000000     /*-------------------------------------------------------------*/
580300000000
580400000000             RMVMSGD MSGID(TXT0146) MSGF(&LIB/&OBJ)
580500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
580600000000
580700000000             ADDMSGD +
580800000000                MSGID(TXT0146) +
580900000000                MSGF(&LIB/&OBJ) +
581000000000                MSG( +
581100000000'Insärer'                                                             +
581200000000                ) +
581300000000                SEV(0) +
581400000000     /*   No replacement variables defined!                         */ +
581500000000                ALROPT(*NO) +
581600000000                CCSID(65535) +
581700000000                /*  -EOF-  */
581800000000
581900000000     /*-------------------------------------------------------------*/
582000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0147                    */
582100000000     /* Supprimer                                                   */
582200000000     /*-------------------------------------------------------------*/
582300000000
582400000000             RMVMSGD MSGID(TXT0147) MSGF(&LIB/&OBJ)
582500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
582600000000
582700000000             ADDMSGD +
582800000000                MSGID(TXT0147) +
582900000000                MSGF(&LIB/&OBJ) +
583000000000                MSG( +
583100000000'Supprimer'                                                           +
583200000000                ) +
583300000000                SEV(0) +
583400000000     /*   No replacement variables defined!                         */ +
583500000000                ALROPT(*NO) +
583600000000                CCSID(65535) +
583700000000                /*  -EOF-  */
583800000000
583900000000     /*-------------------------------------------------------------*/
584000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0148                    */
584100000000     /* de:                                                         */
584200000000     /*-------------------------------------------------------------*/
584300000000
584400000000             RMVMSGD MSGID(TXT0148) MSGF(&LIB/&OBJ)
584500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
584600000000
584700000000             ADDMSGD +
584800000000                MSGID(TXT0148) +
584900000000                MSGF(&LIB/&OBJ) +
585000000000                MSG( +
585100000000'de:'                                                                 +
585200000000                ) +
585300000000                SEV(0) +
585400000000     /*   No replacement variables defined!                         */ +
585500000000                ALROPT(*NO) +
585600000000                CCSID(65535) +
585700000000                /*  -EOF-  */
585800000000
585900000000     /*-------------------------------------------------------------*/
586000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0149                    */
586100000000     /* Longueur:                                                   */
586200000000     /*-------------------------------------------------------------*/
586300000000
586400000000             RMVMSGD MSGID(TXT0149) MSGF(&LIB/&OBJ)
586500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
586600000000
586700000000             ADDMSGD +
586800000000                MSGID(TXT0149) +
586900000000                MSGF(&LIB/&OBJ) +
587000000000                MSG( +
587100000000'Longueur:'                                                           +
587200000000                ) +
587300000000                SEV(0) +
587400000000     /*   No replacement variables defined!                         */ +
587500000000                ALROPT(*NO) +
587600000000                CCSID(65535) +
587700000000                /*  -EOF-  */
587800000000
587900000000     /*-------------------------------------------------------------*/
588000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0150                    */
588100000000     /* §:                                                          */
588200000000     /*-------------------------------------------------------------*/
588300000000
588400000000             RMVMSGD MSGID(TXT0150) MSGF(&LIB/&OBJ)
588500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
588600000000
588700000000             ADDMSGD +
588800000000                MSGID(TXT0150) +
588900000000                MSGF(&LIB/&OBJ) +
589000000000                MSG( +
589100000000'§:'                                                                  +
589200000000                ) +
589300000000                SEV(0) +
589400000000     /*   No replacement variables defined!                         */ +
589500000000                ALROPT(*NO) +
589600000000                CCSID(65535) +
589700000000                /*  -EOF-  */
589800000000
589900000000     /*-------------------------------------------------------------*/
590000000000     /*   Cmd-ADDMSGD für Message-ID :   TXT0151                    */
590100000000     /* Pos.du curseur                                              */
590200000000     /*-------------------------------------------------------------*/
590300000000
590400000000             RMVMSGD MSGID(TXT0151) MSGF(&LIB/&OBJ)
590500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
590600000000
590700000000             ADDMSGD +
590800000000                MSGID(TXT0151) +
590900000000                MSGF(&LIB/&OBJ) +
591000000000                MSG( +
591100231124'Pos. curseur :'                                                      +
591200000000                ) +
591300000000                SEV(0) +
591400000000     /*   No replacement variables defined!                         */ +
591500000000                ALROPT(*NO) +
591600000000                CCSID(65535) +
591700000000                /*  -EOF-  */
591800000000
591900000000     /*-------------------------------------------------------------*/
592000000000     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
592100000000     /* Enregistrement du format &3 du fichier &2/&1 inaccessible   */
592200000000     /*-------------------------------------------------------------*/
592300000000
592400000000             RMVMSGD MSGID(USR0001) MSGF(&LIB/&OBJ)
592500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
592600000000
592700000000             ADDMSGD +
592800000000                MSGID(USR0001) +
592900000000                MSGF(&LIB/&OBJ) +
593000000000                MSG( +
593100000000'Enregistrement du format &3 du fichier &2/&1 inaccessible'           +
593200000000                ) +
593300000000                SEV(0) +
593400000000                FMT( +
593500000000                    (*CHAR 10) +
593600000000                    (*CHAR 10) +
593700000000                    (*CHAR 10) +
593800000000                ) +
593900000000                ALROPT(*NO) +
594000000000                CCSID(65535) +
594100000000                /*  -EOF-  */
594200000000
594300000000     /*-------------------------------------------------------------*/
594400000000     /*   Cmd-ADDMSGD für Message-ID :   USR0002                    */
594500000000     /* Extraction impossible de la liste des formats du fichier &2 */
594600000000     /*-------------------------------------------------------------*/
594700000000
594800000000             RMVMSGD MSGID(USR0002) MSGF(&LIB/&OBJ)
594900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
595000000000
595100000000             ADDMSGD +
595200000000                MSGID(USR0002) +
595300000000                MSGF(&LIB/&OBJ) +
595400000000                MSG( +
595500000000'Extraction impossible de la liste des formats du fichier &2/&1.'     +
595600000000                ) +
595700000000                SEV(0) +
595800000000                FMT( +
595900000000                    (*CHAR 10) +
596000000000                    (*CHAR 10) +
596100000000                ) +
596200000000                ALROPT(*NO) +
596300000000                CCSID(65535) +
596400000000                /*  -EOF-  */
596500000000
596600000000     /*-------------------------------------------------------------*/
596700000000     /*   Cmd-ADDMSGD für Message-ID :   USR0003                    */
596800000000     /* Journalisation active sur ce fichier                        */
596900000000     /*-------------------------------------------------------------*/
597000000000
597100000000             RMVMSGD MSGID(USR0003) MSGF(&LIB/&OBJ)
597200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
597300000000
597400000000             ADDMSGD +
597500000000                MSGID(USR0003) +
597600000000                MSGF(&LIB/&OBJ) +
597700000000                MSG( +
597800000000'Journalisation active sur ce fichier'                                +
597900000000                ) +
598000000000                SEV(0) +
598100000000     /*   No replacement variables defined!                         */ +
598200000000                ALROPT(*NO) +
598300000000                CCSID(65535) +
598400000000                /*  -EOF-  */
598500000000
598600000000     /*-------------------------------------------------------------*/
598700000000     /*   Cmd-ADDMSGD für Message-ID :   USR0004                    */
598800000000     /* Pas de journalisation sur ce fichier                        */
598900000000     /*-------------------------------------------------------------*/
599000000000
599100000000             RMVMSGD MSGID(USR0004) MSGF(&LIB/&OBJ)
599200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
599300000000
599400000000             ADDMSGD +
599500000000                MSGID(USR0004) +
599600000000                MSGF(&LIB/&OBJ) +
599700000000                MSG( +
599800000000'Pas de journalisation sur ce fichier'                                +
599900000000                ) +
600000000000                SEV(0) +
600100000000     /*   No replacement variables defined!                         */ +
600200000000                ALROPT(*NO) +
600300000000                CCSID(65535) +
600400000000                /*  -EOF-  */
600500000000
600600000000     /*-------------------------------------------------------------*/
600700000000     /*   Cmd-ADDMSGD für Message-ID :   USR0005                    */
600800000000     /* Fichier &1 non ouvert. Voir journal.                        */
600900000000     /*-------------------------------------------------------------*/
601000000000
601100000000             RMVMSGD MSGID(USR0005) MSGF(&LIB/&OBJ)
601200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
601300000000
601400000000             ADDMSGD +
601500000000                MSGID(USR0005) +
601600000000                MSGF(&LIB/&OBJ) +
601700000000                MSG( +
601800000000'Fichier &1 non ouvert. Voir journal.'                                +
601900000000                ) +
602000000000                SEV(0) +
602100000000                FMT( +
602200000000                    (*CHAR 10) +
602300000000                ) +
602400000000                ALROPT(*NO) +
602500000000                CCSID(65535) +
602600000000                /*  -EOF-  */
602700000000
602800000000     /*-------------------------------------------------------------*/
602900000000     /*   Cmd-ADDMSGD für Message-ID :   USR0006                    */
603000000000     /* Pas d'information clef sur fichier &2/&1.                   */
603100000000     /*-------------------------------------------------------------*/
603200000000
603300000000             RMVMSGD MSGID(USR0006) MSGF(&LIB/&OBJ)
603400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
603500000000
603600000000             ADDMSGD +
603700000000                MSGID(USR0006) +
603800000000                MSGF(&LIB/&OBJ) +
603900000000                MSG( +
604000000000'Pas d''information clef sur fichier &2/&1.'                          +
604100000000                ) +
604200000000                SEV(0) +
604300000000                FMT( +
604400000000                    (*CHAR 10) +
604500000000                    (*CHAR 10) +
604600000000                ) +
604700000000                ALROPT(*NO) +
604800000000                CCSID(65535) +
604900000000                /*  -EOF-  */
605000000000
605100000000     /*-------------------------------------------------------------*/
605200000000     /*   Cmd-ADDMSGD für Message-ID :   USR0007                    */
605300000000     /* Ouverture impossible du fichier &2/&1 en mode M§J. Modifica */
605400000000     /*-------------------------------------------------------------*/
605500000000
605600000000             RMVMSGD MSGID(USR0007) MSGF(&LIB/&OBJ)
605700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
605800000000
605900000000             ADDMSGD +
606000000000                MSGID(USR0007) +
606100000000                MSGF(&LIB/&OBJ) +
606200000000                MSG( +
606300000000'Ouverture impossible du fichier &2/&1 en mode M§J. Modifications impo-
606400000000ossibles.'                                                            +
606500000000                ) +
606600000000                SECLVL( +
606700000000'&N &N Causes possibles: &N &B 1. Le debugger a ätä dämarrä en UPDPROD-
606800000000(*NO). &B 2. Le fichier est un logique joint &B 3. Le fichier a des rü-
606900000000gles d''intägritä mais n''est pas journalisä. &B 4. Le fichier possüde-
607000000000 des däclencheurs introuvables. &B 5. Le fichier est un logique multi--
607100000000membre.'                                                              +
607200000000                ) +
607300000000                SEV(0) +
607400000000                FMT( +
607500000000                    (*CHAR 10) +
607600000000                    (*CHAR 10) +
607700000000                ) +
607800000000                ALROPT(*NO) +
607900000000                CCSID(65535) +
608000000000                /*  -EOF-  */
608100000000
608200000000     /*-------------------------------------------------------------*/
608300000000     /*   Cmd-ADDMSGD für Message-ID :   USR0008                    */
608400000000     /* Fichier &2/&1 introuvable                                   */
608500000000     /*-------------------------------------------------------------*/
608600000000
608700000000             RMVMSGD MSGID(USR0008) MSGF(&LIB/&OBJ)
608800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
608900000000
609000000000             ADDMSGD +
609100000000                MSGID(USR0008) +
609200000000                MSGF(&LIB/&OBJ) +
609300000000                MSG( +
609400000000'Fichier &2/&1 introuvable'                                           +
609500000000                ) +
609600000000                SEV(0) +
609700000000                FMT( +
609800000000                    (*CHAR 10) +
609900000000                    (*CHAR 10) +
610000000000                ) +
610100000000                ALROPT(*NO) +
610200000000                CCSID(65535) +
610300000000                /*  -EOF-  */
610400000000
610500000000     /*-------------------------------------------------------------*/
610600000000     /*   Cmd-ADDMSGD für Message-ID :   USR0009                    */
610700000000     /* Extraction impossible de la description du fichier &2/&1.   */
610800000000     /*-------------------------------------------------------------*/
610900000000
611000000000             RMVMSGD MSGID(USR0009) MSGF(&LIB/&OBJ)
611100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
611200000000
611300000000             ADDMSGD +
611400000000                MSGID(USR0009) +
611500000000                MSGF(&LIB/&OBJ) +
611600000000                MSG( +
611700000000'Extraction impossible de la description du fichier &2/&1.'           +
611800000000                ) +
611900000000                SEV(0) +
612000000000                FMT( +
612100000000                    (*CHAR 10) +
612200000000                    (*CHAR 10) +
612300000000                ) +
612400000000                ALROPT(*NO) +
612500000000                CCSID(65535) +
612600000000                /*  -EOF-  */
612700000000
612800000000     /*-------------------------------------------------------------*/
612900000000     /*   Cmd-ADDMSGD für Message-ID :   USR0010                    */
613000000000     /* Bibliothüque &1 inexistante                                 */
613100000000     /*-------------------------------------------------------------*/
613200000000
613300000000             RMVMSGD MSGID(USR0010) MSGF(&LIB/&OBJ)
613400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
613500000000
613600000000             ADDMSGD +
613700000000                MSGID(USR0010) +
613800000000                MSGF(&LIB/&OBJ) +
613900000000                MSG( +
614000000000'Bibliothüque &1 inexistante'                                         +
614100000000                ) +
614200000000                SEV(0) +
614300000000                FMT( +
614400000000                    (*CHAR 10) +
614500000000                ) +
614600000000                ALROPT(*NO) +
614700000000                CCSID(65535) +
614800000000                /*  -EOF-  */
614900000000
615000000000     /*-------------------------------------------------------------*/
615100000000     /*   Cmd-ADDMSGD für Message-ID :   USR0011                    */
615200000000     /* Fichier non ouvert. Voir message de second niveau ou la log */
615300000000     /*-------------------------------------------------------------*/
615400000000
615500000000             RMVMSGD MSGID(USR0011) MSGF(&LIB/&OBJ)
615600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
615700000000
615800000000             ADDMSGD +
615900000000                MSGID(USR0011) +
616000000000                MSGF(&LIB/&OBJ) +
616100000000                MSG( +
616200000000'Fichier non ouvert. Voir message de second niveau ou la log pour plus-
616300000000 d''informations.'                                                    +
616400000000                ) +
616500000000                SECLVL( +
616600000000'&N &N Erreur . .  . . :   &1'                                        +
616700000000                ) +
616800000000                SEV(0) +
616900000000                FMT( +
617000000000                    (*CHAR 256) +
617100000000                ) +
617200000000                ALROPT(*NO) +
617300000000                CCSID(65535) +
617400000000                /*  -EOF-  */
617500000000
617600000000     /*-------------------------------------------------------------*/
617700000000     /*   Cmd-ADDMSGD für Message-ID :   USR0012                    */
617800000000     /* Erreur E/S &2: &1                                           */
617900000000     /*-------------------------------------------------------------*/
618000000000
618100000000             RMVMSGD MSGID(USR0012) MSGF(&LIB/&OBJ)
618200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
618300000000
618400000000             ADDMSGD +
618500000000                MSGID(USR0012) +
618600000000                MSGF(&LIB/&OBJ) +
618700000000                MSG( +
618800000000'Erreur E/S &2: &1'                                                   +
618900000000                ) +
619000000000                SEV(0) +
619100000000                FMT( +
619200000000                    (*CHAR 256) +
619300000000                    (*DEC 5 0) +
619400000000                ) +
619500000000                ALROPT(*NO) +
619600000000                CCSID(65535) +
619700000000                /*  -EOF-  */
619800000000
619900000000     /*-------------------------------------------------------------*/
620000000000     /*   Cmd-ADDMSGD für Message-ID :   USR0013                    */
620100000000     /* Exäcution de la requête.                                    */
620200000000     /*-------------------------------------------------------------*/
620300000000
620400000000             RMVMSGD MSGID(USR0013) MSGF(&LIB/&OBJ)
620500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
620600000000
620700000000             ADDMSGD +
620800000000                MSGID(USR0013) +
620900000000                MSGF(&LIB/&OBJ) +
621000000000                MSG( +
621100000000'Exäcution de la requête.'                                            +
621200000000                ) +
621300000000                SEV(0) +
621400000000     /*   No replacement variables defined!                         */ +
621500000000                ALROPT(*NO) +
621600000000                CCSID(65535) +
621700000000                /*  -EOF-  */
621800000000
621900000000     /*-------------------------------------------------------------*/
622000000000     /*   Cmd-ADDMSGD für Message-ID :   USR0014                    */
622100000000     /* Calcule nombre d'enregistrements selectionnäs.              */
622200000000     /*-------------------------------------------------------------*/
622300000000
622400000000             RMVMSGD MSGID(USR0014) MSGF(&LIB/&OBJ)
622500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
622600000000
622700000000             ADDMSGD +
622800000000                MSGID(USR0014) +
622900000000                MSGF(&LIB/&OBJ) +
623000000000                MSG( +
623100000000'Calcule nombre d''enregistrements selectionnäs.'                     +
623200000000                ) +
623300000000                SEV(0) +
623400000000     /*   No replacement variables defined!                         */ +
623500000000                ALROPT(*NO) +
623600000000                CCSID(65535) +
623700000000                /*  -EOF-  */
623800000000
623900000000     /*-------------------------------------------------------------*/
624000000000     /*   Cmd-ADDMSGD für Message-ID :   USR0143                    */
624100000000     /* Extraction impossible de l'enregistrement format &3 du fich */
624200000000     /*-------------------------------------------------------------*/
624300000000
624400000000             RMVMSGD MSGID(USR0143) MSGF(&LIB/&OBJ)
624500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
624600000000
624700000000             ADDMSGD +
624800000000                MSGID(USR0143) +
624900000000                MSGF(&LIB/&OBJ) +
625000000000                MSG( +
625100000000'Extraction impossible de l''enregistrement format &3 du fichier &2/&1-
625200000000.'                                                                    +
625300000000                ) +
625400000000                SEV(0) +
625500000000                FMT( +
625600000000                    (*CHAR 10) +
625700000000                    (*CHAR 10) +
625800000000                    (*CHAR 10) +
625900000000                ) +
626000000000                ALROPT(*NO) +
626100000000                CCSID(65535) +
626200000000                /*  -EOF-  */
626300000000
626400000000     /*-------------------------------------------------------------*/
626500000000     /*   Cmd-ADDMSGD für Message-ID :   USR1000                    */
626600000000     /* Accüs non autorisä pour le fichier &2/&1, membre &3.        */
626700000000     /*-------------------------------------------------------------*/
626800000000
626900000000             RMVMSGD MSGID(USR1000) MSGF(&LIB/&OBJ)
627000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
627100000000
627200000000             ADDMSGD +
627300000000                MSGID(USR1000) +
627400000000                MSGF(&LIB/&OBJ) +
627500000000                MSG( +
627600000000'Accüs non autorisä pour le fichier &2/&1, membre &3.'                +
627700000000                ) +
627800000000                SEV(0) +
627900000000                FMT( +
628000000000                    (*CHAR 10) +
628100000000                    (*CHAR 10) +
628200000000                    (*CHAR 10) +
628300000000                ) +
628400000000                ALROPT(*NO) +
628500000000                CCSID(65535) +
628600000000                /*  -EOF-  */
628700000000
628800000000     /*-------------------------------------------------------------*/
628900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8100                    */
629000000000     /* Abandon par utilisateur avec &1                             */
629100000000     /*-------------------------------------------------------------*/
629200000000
629300000000             RMVMSGD MSGID(USR8100) MSGF(&LIB/&OBJ)
629400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
629500000000
629600000000             ADDMSGD +
629700000000                MSGID(USR8100) +
629800000000                MSGF(&LIB/&OBJ) +
629900000000                MSG( +
630000000000'Abandon par utilisateur avec &1'                                     +
630100000000                ) +
630200000000                SEV(0) +
630300000000                FMT( +
630400000000                    (*CHAR 10) +
630500000000                ) +
630600000000                ALROPT(*NO) +
630700000000                CCSID(65535) +
630800000000                /*  -EOF-  */
630900000000
631000000000     /*-------------------------------------------------------------*/
631100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8101                    */
631200000000     /* Veuillez patienter un moment  ...                           */
631300000000     /*-------------------------------------------------------------*/
631400000000
631500000000             RMVMSGD MSGID(USR8101) MSGF(&LIB/&OBJ)
631600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
631700000000
631800000000             ADDMSGD +
631900000000                MSGID(USR8101) +
632000000000                MSGF(&LIB/&OBJ) +
632100000000                MSG( +
632200000000'Veuillez patienter un moment  ...'                                   +
632300000000                ) +
632400000000                SEV(0) +
632500000000     /*   No replacement variables defined!                         */ +
632600000000                ALROPT(*NO) +
632700000000                CCSID(65535) +
632800000000                /*  -EOF-  */
632900000000
633000000000     /*-------------------------------------------------------------*/
633100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8102                    */
633200000000     /* Pointez sur un enregistement et räessayez                   */
633300000000     /*-------------------------------------------------------------*/
633400000000
633500000000             RMVMSGD MSGID(USR8102) MSGF(&LIB/&OBJ)
633600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
633700000000
633800000000             ADDMSGD +
633900000000                MSGID(USR8102) +
634000000000                MSGF(&LIB/&OBJ) +
634100000000                MSG( +
634200000000'Pointez sur un enregistement et räessayez'                           +
634300000000                ) +
634400000000                SEV(0) +
634500000000     /*   No replacement variables defined!                         */ +
634600000000                ALROPT(*NO) +
634700000000                CCSID(65535) +
634800000000                /*  -EOF-  */
634900000000
635000000000     /*-------------------------------------------------------------*/
635100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8103                    */
635200000000     /* Impossible de fermer le fichier.                            */
635300000000     /*-------------------------------------------------------------*/
635400000000
635500000000             RMVMSGD MSGID(USR8103) MSGF(&LIB/&OBJ)
635600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
635700000000
635800000000             ADDMSGD +
635900000000                MSGID(USR8103) +
636000000000                MSGF(&LIB/&OBJ) +
636100000000                MSG( +
636200000000'Impossible de fermer le fichier.'                                    +
636300000000                ) +
636400000000                SEV(0) +
636500000000     /*   No replacement variables defined!                         */ +
636600000000                ALROPT(*NO) +
636700000000                CCSID(65535) +
636800000000                /*  -EOF-  */
636900000000
637000000000     /*-------------------------------------------------------------*/
637100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8104                    */
637200000000     /* Extraction de la description du fichier &2/&1.              */
637300000000     /*-------------------------------------------------------------*/
637400000000
637500000000             RMVMSGD MSGID(USR8104) MSGF(&LIB/&OBJ)
637600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
637700000000
637800000000             ADDMSGD +
637900000000                MSGID(USR8104) +
638000000000                MSGF(&LIB/&OBJ) +
638100000000                MSG( +
638200000000'Extraction de la description du fichier &2/&1.'                      +
638300000000                ) +
638400000000                SEV(0) +
638500000000                FMT( +
638600000000                    (*CHAR 10) +
638700000000                    (*CHAR 10) +
638800000000                ) +
638900000000                ALROPT(*NO) +
639000000000                CCSID(65535) +
639100000000                /*  -EOF-  */
639200000000
639300000000     /*-------------------------------------------------------------*/
639400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8105                    */
639500000000     /* Extraction de la liste des formats du fichier &2/&1.        */
639600000000     /*-------------------------------------------------------------*/
639700000000
639800000000             RMVMSGD MSGID(USR8105) MSGF(&LIB/&OBJ)
639900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
640000000000
640100000000             ADDMSGD +
640200000000                MSGID(USR8105) +
640300000000                MSGF(&LIB/&OBJ) +
640400000000                MSG( +
640500000000'Extraction de la liste des formats du fichier &2/&1.'                +
640600000000                ) +
640700000000                SEV(0) +
640800000000                FMT( +
640900000000                    (*CHAR 10) +
641000000000                    (*CHAR 10) +
641100000000                ) +
641200000000                ALROPT(*NO) +
641300000000                CCSID(65535) +
641400000000                /*  -EOF-  */
641500000000
641600000000     /*-------------------------------------------------------------*/
641700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8106                    */
641800000000     /* Extraction des attributs räseau.                            */
641900000000     /*-------------------------------------------------------------*/
642000000000
642100000000             RMVMSGD MSGID(USR8106) MSGF(&LIB/&OBJ)
642200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
642300000000
642400000000             ADDMSGD +
642500000000                MSGID(USR8106) +
642600000000                MSGF(&LIB/&OBJ) +
642700000000                MSG( +
642800000000'Extraction des attributs räseau.'                                    +
642900000000                ) +
643000000000                SEV(0) +
643100000000     /*   No replacement variables defined!                         */ +
643200000000                ALROPT(*NO) +
643300000000                CCSID(65535) +
643400000000                /*  -EOF-  */
643500000000
643600000000     /*-------------------------------------------------------------*/
643700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8107                    */
643800000000     /* Extraction des attributs de l'objet &2/&1.                  */
643900000000     /*-------------------------------------------------------------*/
644000000000
644100000000             RMVMSGD MSGID(USR8107) MSGF(&LIB/&OBJ)
644200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
644300000000
644400000000             ADDMSGD +
644500000000                MSGID(USR8107) +
644600000000                MSGF(&LIB/&OBJ) +
644700000000                MSG( +
644800000000'Extraction des attributs de l''objet &2/&1.'                         +
644900000000                ) +
645000000000                SEV(0) +
645100000000                FMT( +
645200000000                    (*CHAR 10) +
645300000000                    (*CHAR 10) +
645400000000                    (*CHAR 10) +
645500000000                ) +
645600000000                ALROPT(*NO) +
645700000000                CCSID(65535) +
645800000000                /*  -EOF-  */
645900000000
646000000000     /*-------------------------------------------------------------*/
646100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8108                    */
646200000000     /* Champ '&1' non trouvä dans fichier &3/&2.                   */
646300000000     /*-------------------------------------------------------------*/
646400000000
646500000000             RMVMSGD MSGID(USR8108) MSGF(&LIB/&OBJ)
646600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
646700000000
646800000000             ADDMSGD +
646900000000                MSGID(USR8108) +
647000000000                MSGF(&LIB/&OBJ) +
647100000000                MSG( +
647200000000'Champ ''&1'' non trouvä dans fichier &3/&2.'                         +
647300000000                ) +
647400000000                SEV(0) +
647500000000                FMT( +
647600000000                    (*CHAR 10) +
647700000000                    (*CHAR 10) +
647800000000                    (*CHAR 10) +
647900000000                ) +
648000000000                ALROPT(*NO) +
648100000000                CCSID(65535) +
648200000000                /*  -EOF-  */
648300000000
648400000000     /*-------------------------------------------------------------*/
648500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8109                    */
648600000000     /* Extraction de la description du membre &3 du fichier &2/&1. */
648700000000     /*-------------------------------------------------------------*/
648800000000
648900000000             RMVMSGD MSGID(USR8109) MSGF(&LIB/&OBJ)
649000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
649100000000
649200000000             ADDMSGD +
649300000000                MSGID(USR8109) +
649400000000                MSGF(&LIB/&OBJ) +
649500000000                MSG( +
649600000000'Extraction de la description du membre &3 du fichier &2/&1.'         +
649700000000                ) +
649800000000                SEV(0) +
649900000000                FMT( +
650000000000                    (*CHAR 10) +
650100000000                    (*CHAR 10) +
650200000000                    (*CHAR 10) +
650300000000                ) +
650400000000                ALROPT(*NO) +
650500000000                CCSID(65535) +
650600000000                /*  -EOF-  */
650700000000
650800000000     /*-------------------------------------------------------------*/
650900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8110                    */
651000000000     /* Option '&1' non valide                                      */
651100000000     /*-------------------------------------------------------------*/
651200000000
651300000000             RMVMSGD MSGID(USR8110) MSGF(&LIB/&OBJ)
651400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
651500000000
651600000000             ADDMSGD +
651700000000                MSGID(USR8110) +
651800000000                MSGF(&LIB/&OBJ) +
651900000000                MSG( +
652000000000'Option ''&1'' non valide'                                            +
652100000000                ) +
652200000000                SEV(0) +
652300000000                FMT( +
652400000000                    (*CHAR 10) +
652500000000                ) +
652600000000                ALROPT(*NO) +
652700000000                CCSID(65535) +
652800000000                /*  -EOF-  */
652900000000
653000000000     /*-------------------------------------------------------------*/
653100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8111                    */
653200000000     /* Oui § tout                                                  */
653300000000     /*-------------------------------------------------------------*/
653400000000
653500000000             RMVMSGD MSGID(USR8111) MSGF(&LIB/&OBJ)
653600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
653700000000
653800000000             ADDMSGD +
653900000000                MSGID(USR8111) +
654000000000                MSGF(&LIB/&OBJ) +
654100000000                MSG( +
654200000000'Oui § tout'                                                          +
654300000000                ) +
654400000000                SEV(0) +
654500000000     /*   No replacement variables defined!                         */ +
654600000000                ALROPT(*NO) +
654700000000                CCSID(65535) +
654800000000                /*  -EOF-  */
654900000000
655000000000     /*-------------------------------------------------------------*/
655100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8112                    */
655200000000     /* Commande acceptäe                                           */
655300000000     /*-------------------------------------------------------------*/
655400000000
655500000000             RMVMSGD MSGID(USR8112) MSGF(&LIB/&OBJ)
655600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
655700000000
655800000000             ADDMSGD +
655900000000                MSGID(USR8112) +
656000000000                MSGF(&LIB/&OBJ) +
656100000000                MSG( +
656200000000'Commande acceptäe'                                                   +
656300000000                ) +
656400000000                SEV(0) +
656500000000     /*   No replacement variables defined!                         */ +
656600000000                ALROPT(*NO) +
656700000000                CCSID(65535) +
656800000000                /*  -EOF-  */
656900000000
657000000000     /*-------------------------------------------------------------*/
657100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8113                    */
657200000000     /* Commande interne &1 invalide                                */
657300000000     /*-------------------------------------------------------------*/
657400000000
657500000000             RMVMSGD MSGID(USR8113) MSGF(&LIB/&OBJ)
657600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
657700000000
657800000000             ADDMSGD +
657900000000                MSGID(USR8113) +
658000000000                MSGF(&LIB/&OBJ) +
658100000000                MSG( +
658200000000'Commande interne &1 invalide'                                        +
658300000000                ) +
658400000000                SEV(0) +
658500000000                FMT( +
658600000000                    (*CHAR 10) +
658700000000                ) +
658800000000                ALROPT(*NO) +
658900000000                CCSID(65535) +
659000000000                /*  -EOF-  */
659100000000
659200000000     /*-------------------------------------------------------------*/
659300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8114                    */
659400000000     /* Cräation du programme RPG ..                                */
659500000000     /*-------------------------------------------------------------*/
659600000000
659700000000             RMVMSGD MSGID(USR8114) MSGF(&LIB/&OBJ)
659800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
659900000000
660000000000             ADDMSGD +
660100000000                MSGID(USR8114) +
660200000000                MSGF(&LIB/&OBJ) +
660300000000                MSG( +
660400000000'Cräation du programme RPG ..'                                        +
660500000000                ) +
660600000000                SEV(0) +
660700000000     /*   No replacement variables defined!                         */ +
660800000000                ALROPT(*NO) +
660900000000                CCSID(65535) +
661000000000                /*  -EOF-  */
661100000000
661200000000     /*-------------------------------------------------------------*/
661300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8115                    */
661400000000     /* Däbut des enregistrements                                   */
661500000000     /*-------------------------------------------------------------*/
661600000000
661700000000             RMVMSGD MSGID(USR8115) MSGF(&LIB/&OBJ)
661800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
661900000000
662000000000             ADDMSGD +
662100000000                MSGID(USR8115) +
662200000000                MSGF(&LIB/&OBJ) +
662300000000                MSG( +
662400000000'Däbut des enregistrements'                                           +
662500000000                ) +
662600000000                SEV(0) +
662700000000     /*   No replacement variables defined!                         */ +
662800000000                ALROPT(*NO) +
662900000000                CCSID(65535) +
663000000000                /*  -EOF-  */
663100000000
663200000000     /*-------------------------------------------------------------*/
663300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8116                    */
663400000000     /* Derniüre colonne                                            */
663500000000     /*-------------------------------------------------------------*/
663600000000
663700000000             RMVMSGD MSGID(USR8116) MSGF(&LIB/&OBJ)
663800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
663900000000
664000000000             ADDMSGD +
664100000000                MSGID(USR8116) +
664200000000                MSGF(&LIB/&OBJ) +
664300000000                MSG( +
664400000000'Derniüre colonne'                                                    +
664500000000                ) +
664600000000                SEV(0) +
664700000000     /*   No replacement variables defined!                         */ +
664800000000                ALROPT(*NO) +
664900000000                CCSID(65535) +
665000000000                /*  -EOF-  */
665100000000
665200000000     /*-------------------------------------------------------------*/
665300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8117                    */
665400000000     /* Pointez un champ et räessayez                               */
665500000000     /*-------------------------------------------------------------*/
665600000000
665700000000             RMVMSGD MSGID(USR8117) MSGF(&LIB/&OBJ)
665800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
665900000000
666000000000             ADDMSGD +
666100000000                MSGID(USR8117) +
666200000000                MSGF(&LIB/&OBJ) +
666300000000                MSG( +
666400000000'Pointez un champ et räessayez'                                       +
666500000000                ) +
666600000000                SEV(0) +
666700000000     /*   No replacement variables defined!                         */ +
666800000000                ALROPT(*NO) +
666900000000                CCSID(65535) +
667000000000                /*  -EOF-  */
667100000000
667200000000     /*-------------------------------------------------------------*/
667300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8118                    */
667400000000     /* Tableau plein                                               */
667500000000     /*-------------------------------------------------------------*/
667600000000
667700000000             RMVMSGD MSGID(USR8118) MSGF(&LIB/&OBJ)
667800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
667900000000
668000000000             ADDMSGD +
668100000000                MSGID(USR8118) +
668200000000                MSGF(&LIB/&OBJ) +
668300000000                MSG( +
668400000000'Tableau plein'                                                       +
668500000000                ) +
668600000000                SEV(0) +
668700000000     /*   No replacement variables defined!                         */ +
668800000000                ALROPT(*NO) +
668900000000                CCSID(65535) +
669000000000                /*  -EOF-  */
669100000000
669200000000     /*-------------------------------------------------------------*/
669300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8119                    */
669400000000     /* Enregistrement däj§ fixä                                    */
669500000000     /*-------------------------------------------------------------*/
669600000000
669700000000             RMVMSGD MSGID(USR8119) MSGF(&LIB/&OBJ)
669800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
669900000000
670000000000             ADDMSGD +
670100000000                MSGID(USR8119) +
670200000000                MSGF(&LIB/&OBJ) +
670300000000                MSG( +
670400000000'Enregistrement däj§ fixä'                                            +
670500000000                ) +
670600000000                SEV(0) +
670700000000     /*   No replacement variables defined!                         */ +
670800000000                ALROPT(*NO) +
670900000000                CCSID(65535) +
671000000000                /*  -EOF-  */
671100000000
671200000000     /*-------------------------------------------------------------*/
671300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8120                    */
671400000000     /* Enregistrement non trouvä                                   */
671500000000     /*-------------------------------------------------------------*/
671600000000
671700000000             RMVMSGD MSGID(USR8120) MSGF(&LIB/&OBJ)
671800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
671900000000
672000000000             ADDMSGD +
672100000000                MSGID(USR8120) +
672200000000                MSGF(&LIB/&OBJ) +
672300000000                MSG( +
672400000000'Enregistrement non trouvä'                                           +
672500000000                ) +
672600000000                SEV(0) +
672700000000     /*   No replacement variables defined!                         */ +
672800000000                ALROPT(*NO) +
672900000000                CCSID(65535) +
673000000000                /*  -EOF-  */
673100000000
673200000000     /*-------------------------------------------------------------*/
673300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8121                    */
673400000000     /* Enregistrement non fixä                                     */
673500000000     /*-------------------------------------------------------------*/
673600000000
673700000000             RMVMSGD MSGID(USR8121) MSGF(&LIB/&OBJ)
673800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
673900000000
674000000000             ADDMSGD +
674100000000                MSGID(USR8121) +
674200000000                MSGF(&LIB/&OBJ) +
674300000000                MSG( +
674400000000'Enregistrement non fixä'                                             +
674500000000                ) +
674600000000                SEV(0) +
674700000000     /*   No replacement variables defined!                         */ +
674800000000                ALROPT(*NO) +
674900000000                CCSID(65535) +
675000000000                /*  -EOF-  */
675100000000
675200000000     /*-------------------------------------------------------------*/
675300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8122                    */
675400000000     /* Touche incorrecte                                           */
675500000000     /*-------------------------------------------------------------*/
675600000000
675700000000             RMVMSGD MSGID(USR8122) MSGF(&LIB/&OBJ)
675800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
675900000000
676000000000             ADDMSGD +
676100000000                MSGID(USR8122) +
676200000000                MSGF(&LIB/&OBJ) +
676300000000                MSG( +
676400000000'Touche incorrecte'                                                   +
676500000000                ) +
676600000000                SEV(0) +
676700000000     /*   No replacement variables defined!                         */ +
676800000000                ALROPT(*NO) +
676900000000                CCSID(65535) +
677000000000                /*  -EOF-  */
677100000000
677200000000     /*-------------------------------------------------------------*/
677300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8123                    */
677400000000     /* Les champs supärieurs § 1024 car. ne peuvent être &1modifiä */
677500000000     /*-------------------------------------------------------------*/
677600000000
677700000000             RMVMSGD MSGID(USR8123) MSGF(&LIB/&OBJ)
677800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
677900000000
678000000000             ADDMSGD +
678100000000                MSGID(USR8123) +
678200000000                MSGF(&LIB/&OBJ) +
678300000000                MSG( +
678400000000'Les champs supärieurs § 1024 car. ne peuvent être &1modifiäs&2.'     +
678500000000                ) +
678600000000                SEV(0) +
678700000000                FMT( +
678800000000                    (*CHAR 1) +
678900000000                    (*CHAR 1) +
679000000000                ) +
679100000000                ALROPT(*NO) +
679200000000                CCSID(65535) +
679300000000                /*  -EOF-  */
679400000000
679500000000     /*-------------------------------------------------------------*/
679600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8124                    */
679700000000     /* Opärande '&1' invalide                                      */
679800000000     /*-------------------------------------------------------------*/
679900000000
680000000000             RMVMSGD MSGID(USR8124) MSGF(&LIB/&OBJ)
680100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
680200000000
680300000000             ADDMSGD +
680400000000                MSGID(USR8124) +
680500000000                MSGF(&LIB/&OBJ) +
680600000000                MSG( +
680700000000'Opärande ''&1'' invalide'                                            +
680800000000                ) +
680900000000                SECLVL( +
681000000000'&N &B Opärandes valides: &N &P EQ   - &gal § &P NE   - diffärent de &-
681100000000P LT   - plus petit que &P GT   - plus grand que &P LE   - plus petit -
681200000000ou ägal § &P GE   - plus grand ou ägal § &P LIKE - comme'             +
681300000000                ) +
681400000000                SEV(0) +
681500000000                FMT( +
681600000000                    (*CHAR 10) +
681700000000                ) +
681800000000                ALROPT(*NO) +
681900000000                CCSID(65535) +
682000000000                /*  -EOF-  */
682100000000
682200000000     /*-------------------------------------------------------------*/
682300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8125                    */
682400000000     /* Valeur incorrecte pour le nombre d'enregistrements § recher */
682500000000     /*-------------------------------------------------------------*/
682600000000
682700000000             RMVMSGD MSGID(USR8125) MSGF(&LIB/&OBJ)
682800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
682900000000
683000000000             ADDMSGD +
683100000000                MSGID(USR8125) +
683200000000                MSGF(&LIB/&OBJ) +
683300000000                MSG( +
683400000000'Valeur incorrecte pour le nombre d''enregistrements § rechercher'    +
683500000000                ) +
683600000000                SEV(0) +
683700000000     /*   No replacement variables defined!                         */ +
683800000000                ALROPT(*NO) +
683900000000                CCSID(65535) +
684000000000                /*  -EOF-  */
684100000000
684200000000     /*-------------------------------------------------------------*/
684300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8126                    */
684400000000     /* Type de recherche '&1' non valide                           */
684500000000     /*-------------------------------------------------------------*/
684600000000
684700000000             RMVMSGD MSGID(USR8126) MSGF(&LIB/&OBJ)
684800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
684900000000
685000000000             ADDMSGD +
685100000000                MSGID(USR8126) +
685200000000                MSGF(&LIB/&OBJ) +
685300000000                MSG( +
685400000000'Type de recherche ''&1'' non valide'                                 +
685500000000                ) +
685600000000                SEV(0) +
685700000000                FMT( +
685800000000                    (*CHAR 10) +
685900000000                ) +
686000000000                ALROPT(*NO) +
686100000000                CCSID(65535) +
686200000000                /*  -EOF-  */
686300000000
686400000000     /*-------------------------------------------------------------*/
686500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8127                    */
686600000000     /* Recherche en cours                                          */
686700000000     /*-------------------------------------------------------------*/
686800000000
686900000000             RMVMSGD MSGID(USR8127) MSGF(&LIB/&OBJ)
687000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
687100000000
687200000000             ADDMSGD +
687300000000                MSGID(USR8127) +
687400000000                MSGF(&LIB/&OBJ) +
687500000000                MSG( +
687600000000'Recherche en cours'                                                  +
687700000000                ) +
687800000000                SEV(0) +
687900000000     /*   No replacement variables defined!                         */ +
688000000000                ALROPT(*NO) +
688100000000                CCSID(65535) +
688200000000                /*  -EOF-  */
688300000000
688400000000     /*-------------------------------------------------------------*/
688500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8128                    */
688600000000     /* Recherche en cours. &1 de &2 enregistrements recherchäs     */
688700000000     /*-------------------------------------------------------------*/
688800000000
688900000000             RMVMSGD MSGID(USR8128) MSGF(&LIB/&OBJ)
689000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
689100000000
689200000000             ADDMSGD +
689300000000                MSGID(USR8128) +
689400000000                MSGF(&LIB/&OBJ) +
689500000000                MSG( +
689600000000'Recherche en cours. &1 de &2 enregistrements recherchäs'             +
689700000000                ) +
689800000000                SEV(0) +
689900000000                FMT( +
690000000000                    (*DEC 10 0) +
690100000000                    (*DEC 10 0) +
690200000000                ) +
690300000000                ALROPT(*NO) +
690400000000                CCSID(65535) +
690500000000                /*  -EOF-  */
690600000000
690700000000     /*-------------------------------------------------------------*/
690800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8129                    */
690900000000     /* Champ '&1' de type '&2' non valide                          */
691000000000     /*-------------------------------------------------------------*/
691100000000
691200000000             RMVMSGD MSGID(USR8129) MSGF(&LIB/&OBJ)
691300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
691400000000
691500000000             ADDMSGD +
691600000000                MSGID(USR8129) +
691700000000                MSGF(&LIB/&OBJ) +
691800000000                MSG( +
691900000000'Champ ''&1'' de type ''&2'' non valide'                              +
692000000000                ) +
692100000000                SEV(0) +
692200000000                FMT( +
692300000000                    (*CHAR 10) +
692400000000                    (*CHAR 10) +
692500000000                ) +
692600000000                ALROPT(*NO) +
692700000000                CCSID(65535) +
692800000000                /*  -EOF-  */
692900000000
693000000000     /*-------------------------------------------------------------*/
693100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8130                    */
693200000000     /* Enregistrement trouvä. 'F16'=continuer/'ENTREE'=Fin.        */
693300000000     /*-------------------------------------------------------------*/
693400000000
693500000000             RMVMSGD MSGID(USR8130) MSGF(&LIB/&OBJ)
693600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
693700000000
693800000000             ADDMSGD +
693900000000                MSGID(USR8130) +
694000000000                MSGF(&LIB/&OBJ) +
694100000000                MSG( +
694200000000'Enregistrement trouvä. ''F16''=continuer/''ENTREE''=Fin.'            +
694300000000                ) +
694400000000                SEV(0) +
694500000000     /*   No replacement variables defined!                         */ +
694600000000                ALROPT(*NO) +
694700000000                CCSID(65535) +
694800000000                /*  -EOF-  */
694900000000
695000000000     /*-------------------------------------------------------------*/
695100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8131                    */
695200000000     /* Fin de fichier - aucun räsultat. 'F16'=continuer / 'ENTREE' */
695300000000     /*-------------------------------------------------------------*/
695400000000
695500000000             RMVMSGD MSGID(USR8131) MSGF(&LIB/&OBJ)
695600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
695700000000
695800000000             ADDMSGD +
695900000000                MSGID(USR8131) +
696000000000                MSGF(&LIB/&OBJ) +
696100000000                MSG( +
696200000000'Fin de fichier - aucun räsultat. ''F16''=continuer / ''ENTREE''=Fin.'+
696300000000                ) +
696400000000                SEV(0) +
696500000000     /*   No replacement variables defined!                         */ +
696600000000                ALROPT(*NO) +
696700000000                CCSID(65535) +
696800000000                /*  -EOF-  */
696900000000
697000000000     /*-------------------------------------------------------------*/
697100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8132                    */
697200000000     /* Nbre maximum de lignes atteint 'F16'=Continuer 'ENTREE'=Aba */
697300000000     /*-------------------------------------------------------------*/
697400000000
697500000000             RMVMSGD MSGID(USR8132) MSGF(&LIB/&OBJ)
697600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
697700000000
697800000000             ADDMSGD +
697900000000                MSGID(USR8132) +
698000000000                MSGF(&LIB/&OBJ) +
698100000000                MSG( +
698200000000'Nbre maximum de lignes atteint ''F16''=Continuer ''ENTREE''=Abandon' +
698300000000                ) +
698400000000                SEV(0) +
698500000000     /*   No replacement variables defined!                         */ +
698600000000                ALROPT(*NO) +
698700000000                CCSID(65535) +
698800000000                /*  -EOF-  */
698900000000
699000000000     /*-------------------------------------------------------------*/
699100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8133                    */
699200000000     /* 1=Respect casse; 0=non respect casse                        */
699300000000     /*-------------------------------------------------------------*/
699400000000
699500000000             RMVMSGD MSGID(USR8133) MSGF(&LIB/&OBJ)
699600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
699700000000
699800000000             ADDMSGD +
699900000000                MSGID(USR8133) +
700000000000                MSGF(&LIB/&OBJ) +
700100000000                MSG( +
700200000000'1=Respect casse; 0=non respect casse'                                +
700300000000                ) +
700400000000                SEV(0) +
700500000000     /*   No replacement variables defined!                         */ +
700600000000                ALROPT(*NO) +
700700000000                CCSID(65535) +
700800000000                /*  -EOF-  */
700900000000
701000000000     /*-------------------------------------------------------------*/
701100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8134                    */
701200000000     /* La combinaison de l'opärande &1 avec le champ &2 est invali */
701300000000     /*-------------------------------------------------------------*/
701400000000
701500000000             RMVMSGD MSGID(USR8134) MSGF(&LIB/&OBJ)
701600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
701700000000
701800000000             ADDMSGD +
701900000000                MSGID(USR8134) +
702000000000                MSGF(&LIB/&OBJ) +
702100000000                MSG( +
702200000000'La combinaison de l''opärande &1 avec le champ &2 est invalide.'     +
702300000000                ) +
702400000000                SEV(0) +
702500000000                FMT( +
702600000000                    (*CHAR 10) +
702700000000                    (*CHAR 10) +
702800000000                ) +
702900000000                ALROPT(*NO) +
703000000000                CCSID(65535) +
703100000000                /*  -EOF-  */
703200000000
703300000000     /*-------------------------------------------------------------*/
703400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8135                    */
703500000000     /* Opärande &1 invalide avec champ de type &2.                 */
703600000000     /*-------------------------------------------------------------*/
703700000000
703800000000             RMVMSGD MSGID(USR8135) MSGF(&LIB/&OBJ)
703900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
704000000000
704100000000             ADDMSGD +
704200000000                MSGID(USR8135) +
704300000000                MSGF(&LIB/&OBJ) +
704400000000                MSG( +
704500000000'Opärande &1 invalide avec champ de type &2.'                         +
704600000000                ) +
704700000000                SEV(0) +
704800000000                FMT( +
704900000000                    (*CHAR 10) +
705000000000                    (*CHAR 10) +
705100000000                ) +
705200000000                ALROPT(*NO) +
705300000000                CCSID(65535) +
705400000000                /*  -EOF-  */
705500000000
705600000000     /*-------------------------------------------------------------*/
705700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8136                    */
705800000000     /* Champ '&1' introuvable                                      */
705900000000     /*-------------------------------------------------------------*/
706000000000
706100000000             RMVMSGD MSGID(USR8136) MSGF(&LIB/&OBJ)
706200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
706300000000
706400000000             ADDMSGD +
706500000000                MSGID(USR8136) +
706600000000                MSGF(&LIB/&OBJ) +
706700000000                MSG( +
706800000000'Champ ''&1'' introuvable'                                            +
706900000000                ) +
707000000000                SECLVL( +
707100000000'&N &B Valeurs possibles: &N &P *RECORD - Recherchez dans tout l''enre-
707200000000gistrement'                                                           +
707300000000                ) +
707400000000                SEV(0) +
707500000000                FMT( +
707600000000                    (*CHAR 10) +
707700000000                ) +
707800000000                ALROPT(*NO) +
707900000000                CCSID(65535) +
708000000000                /*  -EOF-  */
708100000000
708200000000     /*-------------------------------------------------------------*/
708300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8137                    */
708400000000     /* Extraction information clef de &2/&1.                       */
708500000000     /*-------------------------------------------------------------*/
708600000000
708700000000             RMVMSGD MSGID(USR8137) MSGF(&LIB/&OBJ)
708800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
708900000000
709000000000             ADDMSGD +
709100000000                MSGID(USR8137) +
709200000000                MSGF(&LIB/&OBJ) +
709300000000                MSG( +
709400000000'Extraction information clef de &2/&1.'                               +
709500000000                ) +
709600000000                SEV(0) +
709700000000                FMT( +
709800000000                    (*CHAR 10) +
709900000000                    (*CHAR 10) +
710000000000                ) +
710100000000                ALROPT(*NO) +
710200000000                CCSID(65535) +
710300000000                /*  -EOF-  */
710400000000
710500000000     /*-------------------------------------------------------------*/
710600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8138                    */
710700000000     /* Champ &1 contient des donnäes däcimales invalides           */
710800000000     /*-------------------------------------------------------------*/
710900000000
711000000000             RMVMSGD MSGID(USR8138) MSGF(&LIB/&OBJ)
711100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
711200000000
711300000000             ADDMSGD +
711400000000                MSGID(USR8138) +
711500000000                MSGF(&LIB/&OBJ) +
711600000000                MSG( +
711700000000'Champ &1 contient des donnäes däcimales invalides'                   +
711800000000                ) +
711900000000                SEV(0) +
712000000000                FMT( +
712100000000                    (*CHAR 10) +
712200000000                ) +
712300000000                ALROPT(*NO) +
712400000000                CCSID(65535) +
712500000000                /*  -EOF-  */
712600000000
712700000000     /*-------------------------------------------------------------*/
712800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8139                    */
712900000000     /* Impossible de positionner le sous-fichier                   */
713000000000     /*-------------------------------------------------------------*/
713100000000
713200000000             RMVMSGD MSGID(USR8139) MSGF(&LIB/&OBJ)
713300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
713400000000
713500000000             ADDMSGD +
713600000000                MSGID(USR8139) +
713700000000                MSGF(&LIB/&OBJ) +
713800000000                MSG( +
713900000000'Impossible de positionner le sous-fichier'                           +
714000000000                ) +
714100000000                SEV(0) +
714200000000     /*   No replacement variables defined!                         */ +
714300000000                ALROPT(*NO) +
714400000000                CCSID(65535) +
714500000000                /*  -EOF-  */
714600000000
714700000000     /*-------------------------------------------------------------*/
714800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8140                    */
714900000000     /* Veuillez saisir un argument de recherche                    */
715000000000     /*-------------------------------------------------------------*/
715100000000
715200000000             RMVMSGD MSGID(USR8140) MSGF(&LIB/&OBJ)
715300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
715400000000
715500000000             ADDMSGD +
715600000000                MSGID(USR8140) +
715700000000                MSGF(&LIB/&OBJ) +
715800000000                MSG( +
715900000000'Veuillez saisir un argument de recherche'                            +
716000000000                ) +
716100000000                SEV(0) +
716200000000                FMT( +
716300000000                    (*CHAR 10) +
716400000000                ) +
716500000000                ALROPT(*NO) +
716600000000                CCSID(65535) +
716700000000                /*  -EOF-  */
716800000000
716900000000     /*-------------------------------------------------------------*/
717000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8141                    */
717100000000     /* Utiliser '&1' pour les valeurs positives et '&2' pour les n */
717200000000     /*-------------------------------------------------------------*/
717300000000
717400000000             RMVMSGD MSGID(USR8141) MSGF(&LIB/&OBJ)
717500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
717600000000
717700000000             ADDMSGD +
717800000000                MSGID(USR8141) +
717900000000                MSGF(&LIB/&OBJ) +
718000000000                MSG( +
718100000000'Utiliser ''&1'' pour les valeurs positives et ''&2'' pour les nägativ-
718200000000es.'                                                                  +
718300000000                ) +
718400000000                SEV(0) +
718500000000                FMT( +
718600000000                    (*CHAR 10) +
718700000000                    (*CHAR 10) +
718800000000                ) +
718900000000                ALROPT(*NO) +
719000000000                CCSID(65535) +
719100000000                /*  -EOF-  */
719200000000
719300000000     /*-------------------------------------------------------------*/
719400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8142                    */
719500000000     /* Position &1 est räserväe au signe des valeurs numäriques.   */
719600000000     /*-------------------------------------------------------------*/
719700000000
719800000000             RMVMSGD MSGID(USR8142) MSGF(&LIB/&OBJ)
719900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
720000000000
720100000000             ADDMSGD +
720200000000                MSGID(USR8142) +
720300000000                MSGF(&LIB/&OBJ) +
720400000000                MSG( +
720500000000'Position &1 est räserväe au signe des valeurs numäriques.'           +
720600000000                ) +
720700000000                SEV(0) +
720800000000                FMT( +
720900000000                    (*DEC 10 0) +
721000000000                ) +
721100000000                ALROPT(*NO) +
721200000000                CCSID(65535) +
721300000000                /*  -EOF-  */
721400000000
721500000000     /*-------------------------------------------------------------*/
721600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8143                    */
721700000000     /* Pas de programme associä § la touche &1.                    */
721800000000     /*-------------------------------------------------------------*/
721900000000
722000000000             RMVMSGD MSGID(USR8143) MSGF(&LIB/&OBJ)
722100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
722200000000
722300000000             ADDMSGD +
722400000000                MSGID(USR8143) +
722500000000                MSGF(&LIB/&OBJ) +
722600000000                MSG( +
722700000000'Pas de programme associä § la touche &1.'                            +
722800000000                ) +
722900000000                SEV(0) +
723000000000                FMT( +
723100000000                    (*CHAR 10) +
723200000000                ) +
723300000000                ALROPT(*NO) +
723400000000                CCSID(65535) +
723500000000                /*  -EOF-  */
723600000000
723700000000     /*-------------------------------------------------------------*/
723800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8144                    */
723900000000     /* Exäcution räcursive impossible pour commande &1.            */
724000000000     /*-------------------------------------------------------------*/
724100000000
724200000000             RMVMSGD MSGID(USR8144) MSGF(&LIB/&OBJ)
724300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
724400000000
724500000000             ADDMSGD +
724600000000                MSGID(USR8144) +
724700000000                MSGF(&LIB/&OBJ) +
724800000000                MSG( +
724900000000'Exäcution räcursive impossible pour commande &1.'                    +
725000000000                ) +
725100000000                SEV(0) +
725200000000                FMT( +
725300000000                    (*CHAR 10) +
725400000000                ) +
725500000000                ALROPT(*NO) +
725600000000                CCSID(65535) +
725700000000                /*  -EOF-  */
725800000000
725900000000     /*-------------------------------------------------------------*/
726000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8145                    */
726100000000     /* Impossible d'exäcuter une commande - sous-fichier vide.     */
726200000000     /*-------------------------------------------------------------*/
726300000000
726400000000             RMVMSGD MSGID(USR8145) MSGF(&LIB/&OBJ)
726500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
726600000000
726700000000             ADDMSGD +
726800000000                MSGID(USR8145) +
726900000000                MSGF(&LIB/&OBJ) +
727000000000                MSG( +
727100000000'Impossible d''exäcuter une commande - sous-fichier vide.'            +
727200000000                ) +
727300000000                SEV(0) +
727400000000     /*   No replacement variables defined!                         */ +
727500000000                ALROPT(*NO) +
727600000000                CCSID(65535) +
727700000000                /*  -EOF-  */
727800000000
727900000000     /*-------------------------------------------------------------*/
728000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8146                    */
728100000000     /* Positionnez le curseur sur un champ puis Enträe.            */
728200000000     /*-------------------------------------------------------------*/
728300000000
728400000000             RMVMSGD MSGID(USR8146) MSGF(&LIB/&OBJ)
728500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
728600000000
728700000000             ADDMSGD +
728800000000                MSGID(USR8146) +
728900000000                MSGF(&LIB/&OBJ) +
729000000000                MSG( +
729100000000'Positionnez le curseur sur un champ puis Enträe.'                    +
729200000000                ) +
729300000000                SEV(0) +
729400000000     /*   No replacement variables defined!                         */ +
729500000000                ALROPT(*NO) +
729600000000                CCSID(65535) +
729700000000                /*  -EOF-  */
729800000000
729900000000     /*-------------------------------------------------------------*/
730000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8147                    */
730100000000     /* Le champ &1 n'a pas ätä pointä                              */
730200000000     /*-------------------------------------------------------------*/
730300000000
730400000000             RMVMSGD MSGID(USR8147) MSGF(&LIB/&OBJ)
730500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
730600000000
730700000000             ADDMSGD +
730800000000                MSGID(USR8147) +
730900000000                MSGF(&LIB/&OBJ) +
731000000000                MSG( +
731100000000'Le champ &1 n''a pas ätä pointä'                                     +
731200000000                ) +
731300000000                SEV(0) +
731400000000                FMT( +
731500000000                    (*CHAR 10) +
731600000000                ) +
731700000000                ALROPT(*NO) +
731800000000                CCSID(65535) +
731900000000                /*  -EOF-  */
732000000000
732100000000     /*-------------------------------------------------------------*/
732200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8148                    */
732300000000     /* Plus de place pour le champ '&1'.                           */
732400000000     /*-------------------------------------------------------------*/
732500000000
732600000000             RMVMSGD MSGID(USR8148) MSGF(&LIB/&OBJ)
732700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
732800000000
732900000000             ADDMSGD +
733000000000                MSGID(USR8148) +
733100000000                MSGF(&LIB/&OBJ) +
733200000000                MSG( +
733300000000'Plus de place pour le champ ''&1''.'                                 +
733400000000                ) +
733500000000                SEV(0) +
733600000000                FMT( +
733700000000                    (*CHAR 10) +
733800000000                ) +
733900000000                ALROPT(*NO) +
734000000000                CCSID(65535) +
734100000000                /*  -EOF-  */
734200000000
734300000000     /*-------------------------------------------------------------*/
734400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8149                    */
734500000000     /* Mode couleur däj§ activä pour les lignes.                   */
734600000000     /*-------------------------------------------------------------*/
734700000000
734800000000             RMVMSGD MSGID(USR8149) MSGF(&LIB/&OBJ)
734900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
735000000000
735100000000             ADDMSGD +
735200000000                MSGID(USR8149) +
735300000000                MSGF(&LIB/&OBJ) +
735400000000                MSG( +
735500000000'Mode couleur däj§ activä pour les lignes.'                           +
735600000000                ) +
735700000000                SEV(0) +
735800000000     /*   No replacement variables defined!                         */ +
735900000000                ALROPT(*NO) +
736000000000                CCSID(65535) +
736100000000                /*  -EOF-  */
736200000000
736300000000     /*-------------------------------------------------------------*/
736400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8150                    */
736500000000     /* Mode monochrome däj§ activä pour les lignes.                */
736600000000     /*-------------------------------------------------------------*/
736700000000
736800000000             RMVMSGD MSGID(USR8150) MSGF(&LIB/&OBJ)
736900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
737000000000
737100000000             ADDMSGD +
737200000000                MSGID(USR8150) +
737300000000                MSGF(&LIB/&OBJ) +
737400000000                MSG( +
737500000000'Mode monochrome däj§ activä pour les lignes.'                        +
737600000000                ) +
737700000000                SEV(0) +
737800000000     /*   No replacement variables defined!                         */ +
737900000000                ALROPT(*NO) +
738000000000                CCSID(65535) +
738100000000                /*  -EOF-  */
738200000000
738300000000     /*-------------------------------------------------------------*/
738400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8151                    */
738500000000     /* Nom invalide pour fichier cible '&1'.                       */
738600000000     /*-------------------------------------------------------------*/
738700000000
738800000000             RMVMSGD MSGID(USR8151) MSGF(&LIB/&OBJ)
738900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
739000000000
739100000000             ADDMSGD +
739200000000                MSGID(USR8151) +
739300000000                MSGF(&LIB/&OBJ) +
739400000000                MSG( +
739500000000'Nom invalide pour fichier cible ''&1''.'                             +
739600000000                ) +
739700000000                SEV(0) +
739800000000                FMT( +
739900000000                    (*CHAR 10) +
740000000000                ) +
740100000000                ALROPT(*NO) +
740200000000                CCSID(65535) +
740300000000                /*  -EOF-  */
740400000000
740500000000     /*-------------------------------------------------------------*/
740600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8152                    */
740700000000     /* Nom invalide pour bibliothüque cible '&1'.                  */
740800000000     /*-------------------------------------------------------------*/
740900000000
741000000000             RMVMSGD MSGID(USR8152) MSGF(&LIB/&OBJ)
741100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
741200000000
741300000000             ADDMSGD +
741400000000                MSGID(USR8152) +
741500000000                MSGF(&LIB/&OBJ) +
741600000000                MSG( +
741700000000'Nom invalide pour bibliothüque cible ''&1''.'                        +
741800000000                ) +
741900000000                SEV(0) +
742000000000                FMT( +
742100000000                    (*CHAR 10) +
742200000000                ) +
742300000000                ALROPT(*NO) +
742400000000                CCSID(65535) +
742500000000                /*  -EOF-  */
742600000000
742700000000     /*-------------------------------------------------------------*/
742800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8153                    */
742900000000     /* Nom invalide pour membre cible '&1'.                        */
743000000000     /*-------------------------------------------------------------*/
743100000000
743200000000             RMVMSGD MSGID(USR8153) MSGF(&LIB/&OBJ)
743300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
743400000000
743500000000             ADDMSGD +
743600000000                MSGID(USR8153) +
743700000000                MSGF(&LIB/&OBJ) +
743800000000                MSG( +
743900000000'Nom invalide pour membre cible ''&1''.'                              +
744000000000                ) +
744100000000                SEV(0) +
744200000000                FMT( +
744300000000                    (*CHAR 10) +
744400000000                ) +
744500000000                ALROPT(*NO) +
744600000000                CCSID(65535) +
744700000000                /*  -EOF-  */
744800000000
744900000000     /*-------------------------------------------------------------*/
745000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8154                    */
745100000000     /* Paramütre invalide '&1' pour ajout/remplacement.            */
745200000000     /*-------------------------------------------------------------*/
745300000000
745400000000             RMVMSGD MSGID(USR8154) MSGF(&LIB/&OBJ)
745500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
745600000000
745700000000             ADDMSGD +
745800000000                MSGID(USR8154) +
745900000000                MSGF(&LIB/&OBJ) +
746000000000                MSG( +
746100000000'Paramütre invalide ''&1'' pour ajout/remplacement.'                  +
746200000000                ) +
746300000000                SEV(0) +
746400000000                FMT( +
746500000000                    (*CHAR 10) +
746600000000                ) +
746700000000                ALROPT(*NO) +
746800000000                CCSID(65535) +
746900000000                /*  -EOF-  */
747000000000
747100000000     /*-------------------------------------------------------------*/
747200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8155                    */
747300000000     /* Paramütre invalide '&1' pour cräation de fichier.           */
747400000000     /*-------------------------------------------------------------*/
747500000000
747600000000             RMVMSGD MSGID(USR8155) MSGF(&LIB/&OBJ)
747700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
747800000000
747900000000             ADDMSGD +
748000000000                MSGID(USR8155) +
748100000000                MSGF(&LIB/&OBJ) +
748200000000                MSG( +
748300000000'Paramütre invalide ''&1'' pour cräation de fichier.'                 +
748400000000                ) +
748500000000                SEV(0) +
748600000000                FMT( +
748700000000                    (*CHAR 10) +
748800000000                ) +
748900000000                ALROPT(*NO) +
749000000000                CCSID(65535) +
749100000000                /*  -EOF-  */
749200000000
749300000000     /*-------------------------------------------------------------*/
749400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8156                    */
749500000000     /* Execution en ächec                                          */
749600000000     /*-------------------------------------------------------------*/
749700000000
749800000000             RMVMSGD MSGID(USR8156) MSGF(&LIB/&OBJ)
749900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
750000000000
750100000000             ADDMSGD +
750200000000                MSGID(USR8156) +
750300000000                MSGF(&LIB/&OBJ) +
750400000000                MSG( +
750500000000'Execution en ächec'                                                  +
750600000000                ) +
750700000000                SEV(0) +
750800000000     /*   No replacement variables defined!                         */ +
750900000000                ALROPT(*NO) +
751000000000                CCSID(65535) +
751100000000                /*  -EOF-  */
751200000000
751300000000     /*-------------------------------------------------------------*/
751400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8157                    */
751500000000     /* Extraction des valeurs systüme                              */
751600000000     /*-------------------------------------------------------------*/
751700000000
751800000000             RMVMSGD MSGID(USR8157) MSGF(&LIB/&OBJ)
751900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
752000000000
752100000000             ADDMSGD +
752200000000                MSGID(USR8157) +
752300000000                MSGF(&LIB/&OBJ) +
752400000000                MSG( +
752500000000'Extraction des valeurs systüme'                                      +
752600000000                ) +
752700000000                SEV(0) +
752800000000     /*   No replacement variables defined!                         */ +
752900000000                ALROPT(*NO) +
753000000000                CCSID(65535) +
753100000000                /*  -EOF-  */
753200000000
753300000000     /*-------------------------------------------------------------*/
753400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8158                    */
753500000000     /* Licence invalide NÄ. '&1'.                                  */
753600000000     /*-------------------------------------------------------------*/
753700000000
753800000000             RMVMSGD MSGID(USR8158) MSGF(&LIB/&OBJ)
753900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
754000000000
754100000000             ADDMSGD +
754200000000                MSGID(USR8158) +
754300000000                MSGF(&LIB/&OBJ) +
754400000000                MSG( +
754500000000'Licence invalide NÄ. ''&1''.'                                        +
754600000000                ) +
754700000000                SEV(0) +
754800000000                FMT( +
754900000000                    (*CHAR 20) +
755000000000                ) +
755100000000                ALROPT(*NO) +
755200000000                CCSID(65535) +
755300000000                /*  -EOF-  */
755400000000
755500000000     /*-------------------------------------------------------------*/
755600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8159                    */
755700000000     /* Impossible de sauvegarder les donnäes de licence.           */
755800000000     /*-------------------------------------------------------------*/
755900000000
756000000000             RMVMSGD MSGID(USR8159) MSGF(&LIB/&OBJ)
756100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
756200000000
756300000000             ADDMSGD +
756400000000                MSGID(USR8159) +
756500000000                MSGF(&LIB/&OBJ) +
756600000000                MSG( +
756700000000'Impossible de sauvegarder les donnäes de licence.'                   +
756800000000                ) +
756900000000                SEV(0) +
757000000000     /*   No replacement variables defined!                         */ +
757100000000                ALROPT(*NO) +
757200000000                CCSID(65535) +
757300000000                /*  -EOF-  */
757400000000
757500000000     /*-------------------------------------------------------------*/
757600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8160                    */
757700000000     /* Fichier des däfinitions inexistant pour la langue &1.       */
757800000000     /*-------------------------------------------------------------*/
757900000000
758000000000             RMVMSGD MSGID(USR8160) MSGF(&LIB/&OBJ)
758100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
758200000000
758300000000             ADDMSGD +
758400000000                MSGID(USR8160) +
758500000000                MSGF(&LIB/&OBJ) +
758600000000                MSG( +
758700000000'Fichier des däfinitions inexistant pour la langue &1.'               +
758800000000                ) +
758900000000                SEV(0) +
759000000000                FMT( +
759100000000                    (*CHAR 10) +
759200000000                ) +
759300000000                ALROPT(*NO) +
759400000000                CCSID(65535) +
759500000000                /*  -EOF-  */
759600000000
759700000000     /*-------------------------------------------------------------*/
759800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8161                    */
759900000000     /* Ecran d'accueil activä                                      */
760000000000     /*-------------------------------------------------------------*/
760100000000
760200000000             RMVMSGD MSGID(USR8161) MSGF(&LIB/&OBJ)
760300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
760400000000
760500000000             ADDMSGD +
760600000000                MSGID(USR8161) +
760700000000                MSGF(&LIB/&OBJ) +
760800000000                MSG( +
760900000000'Ecran d''accueil activä'                                             +
761000000000                ) +
761100000000                SEV(0) +
761200000000     /*   No replacement variables defined!                         */ +
761300000000                ALROPT(*NO) +
761400000000                CCSID(65535) +
761500000000                /*  -EOF-  */
761600000000
761700000000     /*-------------------------------------------------------------*/
761800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8162                    */
761900000000     /* Ecran d'accueil däsactivä                                   */
762000000000     /*-------------------------------------------------------------*/
762100000000
762200000000             RMVMSGD MSGID(USR8162) MSGF(&LIB/&OBJ)
762300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
762400000000
762500000000             ADDMSGD +
762600000000                MSGID(USR8162) +
762700000000                MSGF(&LIB/&OBJ) +
762800000000                MSG( +
762900000000'Ecran d''accueil däsactivä'                                          +
763000000000                ) +
763100000000                SEV(0) +
763200000000     /*   No replacement variables defined!                         */ +
763300000000                ALROPT(*NO) +
763400000000                CCSID(65535) +
763500000000                /*  -EOF-  */
763600000000
763700000000     /*-------------------------------------------------------------*/
763800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8163                    */
763900000000     /* La chaîne contient des caractüres <  x''40'' ou = x''FF''.  */
764000000000     /*-------------------------------------------------------------*/
764100000000
764200000000             RMVMSGD MSGID(USR8163) MSGF(&LIB/&OBJ)
764300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
764400000000
764500000000             ADDMSGD +
764600000000                MSGID(USR8163) +
764700000000                MSGF(&LIB/&OBJ) +
764800000000                MSG( +
764900000000'La chaîne contient des caractüres <  x''''40'''' ou = x''''FF''''. Re-
765000000000mplacäs par: &1'''                                                    +
765100000000                ) +
765200000000                SEV(0) +
765300000000                FMT( +
765400000000                    (*CHAR 1) +
765500000000                ) +
765600000000                ALROPT(*NO) +
765700000000                CCSID(65535) +
765800000000                /*  -EOF-  */
765900000000
766000000000     /*-------------------------------------------------------------*/
766100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8164                    */
766200000000     /* Les champs contenant des caractüres non äditables sont igno */
766300000000     /*-------------------------------------------------------------*/
766400000000
766500000000             RMVMSGD MSGID(USR8164) MSGF(&LIB/&OBJ)
766600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
766700000000
766800000000             ADDMSGD +
766900000000                MSGID(USR8164) +
767000000000                MSGF(&LIB/&OBJ) +
767100000000                MSG( +
767200000000'Les champs contenant des caractüres non äditables sont ignoräs'      +
767300000000                ) +
767400000000                SEV(0) +
767500000000     /*   No replacement variables defined!                         */ +
767600000000                ALROPT(*NO) +
767700000000                CCSID(65535) +
767800000000                /*  -EOF-  */
767900000000
768000000000     /*-------------------------------------------------------------*/
768100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8165                    */
768200000000     /* Veuillez choisir une option avant de faire 'räpäter'        */
768300000000     /*-------------------------------------------------------------*/
768400000000
768500000000             RMVMSGD MSGID(USR8165) MSGF(&LIB/&OBJ)
768600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
768700000000
768800000000             ADDMSGD +
768900000000                MSGID(USR8165) +
769000000000                MSGF(&LIB/&OBJ) +
769100000000                MSG( +
769200000000'Veuillez choisir une option avant de faire ''räpäter'''              +
769300000000                ) +
769400000000                SEV(0) +
769500000000     /*   No replacement variables defined!                         */ +
769600000000                ALROPT(*NO) +
769700000000                CCSID(65535) +
769800000000                /*  -EOF-  */
769900000000
770000000000     /*-------------------------------------------------------------*/
770100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8166                    */
770200000000     /* Impossible d'äxäcuter l'option sans fichier ouvert          */
770300000000     /*-------------------------------------------------------------*/
770400000000
770500000000             RMVMSGD MSGID(USR8166) MSGF(&LIB/&OBJ)
770600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
770700000000
770800000000             ADDMSGD +
770900000000                MSGID(USR8166) +
771000000000                MSGF(&LIB/&OBJ) +
771100000000                MSG( +
771200000000'Impossible d''äxäcuter l''option sans fichier ouvert'                +
771300000000                ) +
771400000000                SEV(0) +
771500000000     /*   No replacement variables defined!                         */ +
771600000000                ALROPT(*NO) +
771700000000                CCSID(65535) +
771800000000                /*  -EOF-  */
771900000000
772000000000     /*-------------------------------------------------------------*/
772100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8167                    */
772200000000     /* Le nÄ de säquence doit être unique.                         */
772300000000     /*-------------------------------------------------------------*/
772400000000
772500000000             RMVMSGD MSGID(USR8167) MSGF(&LIB/&OBJ)
772600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
772700000000
772800000000             ADDMSGD +
772900000000                MSGID(USR8167) +
773000000000                MSGF(&LIB/&OBJ) +
773100000000                MSG( +
773200000000'Le nÄ de säquence doit être unique.'                                 +
773300000000                ) +
773400000000                SEV(0) +
773500000000     /*   No replacement variables defined!                         */ +
773600000000                ALROPT(*NO) +
773700000000                CCSID(65535) +
773800000000                /*  -EOF-  */
773900000000
774000000000     /*-------------------------------------------------------------*/
774100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8168                    */
774200000000     /* Valeur &1 interdite pour l'attribut "Visible/invisible".    */
774300000000     /*-------------------------------------------------------------*/
774400000000
774500000000             RMVMSGD MSGID(USR8168) MSGF(&LIB/&OBJ)
774600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
774700000000
774800000000             ADDMSGD +
774900000000                MSGID(USR8168) +
775000000000                MSGF(&LIB/&OBJ) +
775100000000                MSG( +
775200000000'Valeur &1 interdite pour l''attribut "Visible/invisible".'           +
775300000000                ) +
775400000000                SEV(0) +
775500000000                FMT( +
775600000000                    (*CHAR 10) +
775700000000                ) +
775800000000                ALROPT(*NO) +
775900000000                CCSID(65535) +
776000000000                /*  -EOF-  */
776100000000
776200000000     /*-------------------------------------------------------------*/
776300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8169                    */
776400000000     /* Valeur &1 interdite pour l'attribut "Repärer champ".        */
776500000000     /*-------------------------------------------------------------*/
776600000000
776700000000             RMVMSGD MSGID(USR8169) MSGF(&LIB/&OBJ)
776800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
776900000000
777000000000             ADDMSGD +
777100000000                MSGID(USR8169) +
777200000000                MSGF(&LIB/&OBJ) +
777300000000                MSG( +
777400000000'Valeur &1 interdite pour l''attribut "Repärer champ".'               +
777500000000                ) +
777600000000                SEV(0) +
777700000000                FMT( +
777800000000                    (*CHAR 10) +
777900000000                ) +
778000000000                ALROPT(*NO) +
778100000000                CCSID(65535) +
778200000000                /*  -EOF-  */
778300000000
778400000000     /*-------------------------------------------------------------*/
778500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8170                    */
778600000000     /* Valeur &1 interdite pour l'attribut "Taille le maximum".    */
778700000000     /*-------------------------------------------------------------*/
778800000000
778900000000             RMVMSGD MSGID(USR8170) MSGF(&LIB/&OBJ)
779000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
779100000000
779200000000             ADDMSGD +
779300000000                MSGID(USR8170) +
779400000000                MSGF(&LIB/&OBJ) +
779500000000                MSG( +
779600000000'Valeur &1 interdite pour l''attribut "Taille le maximum".'           +
779700000000                ) +
779800000000                SEV(0) +
779900000000                FMT( +
780000000000                    (*DEC 10 0) +
780100000000                ) +
780200000000                ALROPT(*NO) +
780300000000                CCSID(65535) +
780400000000                /*  -EOF-  */
780500000000
780600000000     /*-------------------------------------------------------------*/
780700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8171                    */
780800000000     /* Valeur invalide '&1' pour champ date, heure ou horodatage.  */
780900000000     /*-------------------------------------------------------------*/
781000000000
781100000000             RMVMSGD MSGID(USR8171) MSGF(&LIB/&OBJ)
781200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
781300000000
781400000000             ADDMSGD +
781500000000                MSGID(USR8171) +
781600000000                MSGF(&LIB/&OBJ) +
781700000000                MSG( +
781800000000'Valeur invalide ''&1'' pour champ date, heure ou horodatage.'        +
781900000000                ) +
782000000000                SEV(0) +
782100000000                FMT( +
782200000000                    (*CHAR 26) +
782300000000                ) +
782400000000                ALROPT(*NO) +
782500000000                CCSID(65535) +
782600000000                /*  -EOF-  */
782700000000
782800000000     /*-------------------------------------------------------------*/
782900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8172                    */
783000000000     /* En traitement: &1                                           */
783100000000     /*-------------------------------------------------------------*/
783200000000
783300000000             RMVMSGD MSGID(USR8172) MSGF(&LIB/&OBJ)
783400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
783500000000
783600000000             ADDMSGD +
783700000000                MSGID(USR8172) +
783800000000                MSGF(&LIB/&OBJ) +
783900000000                MSG( +
784000000000'En traitement: &1'                                                   +
784100000000                ) +
784200000000                SEV(0) +
784300000000                FMT( +
784400000000                    (*CHAR 50) +
784500000000                ) +
784600000000                ALROPT(*NO) +
784700000000                CCSID(65535) +
784800000000                /*  -EOF-  */
784900000000
785000000000     /*-------------------------------------------------------------*/
785100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8173                    */
785200000000     /* Appels räcursifs non supportäs par Peek/400.                */
785300000000     /*-------------------------------------------------------------*/
785400000000
785500000000             RMVMSGD MSGID(USR8173) MSGF(&LIB/&OBJ)
785600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
785700000000
785800000000             ADDMSGD +
785900000000                MSGID(USR8173) +
786000000000                MSGF(&LIB/&OBJ) +
786100000000                MSG( +
786200000000'Appels räcursifs non supportäs par Peek/400.'                        +
786300000000                ) +
786400000000                SEV(0) +
786500000000     /*   No replacement variables defined!                         */ +
786600000000                ALROPT(*NO) +
786700000000                CCSID(65535) +
786800000000                /*  -EOF-  */
786900000000
787000000000     /*-------------------------------------------------------------*/
787100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8174                    */
787200000000     /* Caractüre (&1) interdit dans une chaîne hexa                */
787300000000     /*-------------------------------------------------------------*/
787400000000
787500000000             RMVMSGD MSGID(USR8174) MSGF(&LIB/&OBJ)
787600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
787700000000
787800000000             ADDMSGD +
787900000000                MSGID(USR8174) +
788000000000                MSGF(&LIB/&OBJ) +
788100000000                MSG( +
788200000000'Caractüre (&1) interdit dans une chaîne hexa'                        +
788300000000                ) +
788400000000                SEV(0) +
788500000000                FMT( +
788600000000                    (*CHAR 1) +
788700000000                ) +
788800000000                ALROPT(*NO) +
788900000000                CCSID(65535) +
789000000000                /*  -EOF-  */
789100000000
789200000000     /*-------------------------------------------------------------*/
789300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8175                    */
789400000000     /* Il est interdit de saisir un nombre impair de caractüres    */
789500000000     /*-------------------------------------------------------------*/
789600000000
789700000000             RMVMSGD MSGID(USR8175) MSGF(&LIB/&OBJ)
789800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
789900000000
790000000000             ADDMSGD +
790100000000                MSGID(USR8175) +
790200000000                MSGF(&LIB/&OBJ) +
790300000000                MSG( +
790400000000'Il est interdit de saisir un nombre impair de caractüres'            +
790500000000                ) +
790600000000                SEV(0) +
790700000000                FMT( +
790800000000                    (*CHAR 1) +
790900000000                ) +
791000000000                ALROPT(*NO) +
791100000000                CCSID(65535) +
791200000000                /*  -EOF-  */
791300000000
791400000000     /*-------------------------------------------------------------*/
791500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8176                    */
791600000000     /* Attention : Chaîne trop longue.                             */
791700000000     /*-------------------------------------------------------------*/
791800000000
791900000000             RMVMSGD MSGID(USR8176) MSGF(&LIB/&OBJ)
792000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
792100000000
792200000000             ADDMSGD +
792300000000                MSGID(USR8176) +
792400000000                MSGF(&LIB/&OBJ) +
792500000000                MSG( +
792600000000'Attention : Chaîne trop longue.'                                     +
792700000000                ) +
792800000000                SEV(0) +
792900000000                FMT( +
793000000000                    (*CHAR 1) +
793100000000                ) +
793200000000                ALROPT(*NO) +
793300000000                CCSID(65535) +
793400000000                /*  -EOF-  */
793500000000
793600000000     /*-------------------------------------------------------------*/
793700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8177                    */
793800000000     /* La position de däpart däpasse la taille du champ.           */
793900000000     /*-------------------------------------------------------------*/
794000000000
794100000000             RMVMSGD MSGID(USR8177) MSGF(&LIB/&OBJ)
794200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
794300000000
794400000000             ADDMSGD +
794500000000                MSGID(USR8177) +
794600000000                MSGF(&LIB/&OBJ) +
794700000000                MSG( +
794800000000'La position de däpart däpasse la taille du champ.'                   +
794900000000                ) +
795000000000                SEV(0) +
795100000000                FMT( +
795200000000                    (*CHAR 1) +
795300000000                ) +
795400000000                ALROPT(*NO) +
795500000000                CCSID(65535) +
795600000000                /*  -EOF-  */
795700000000
795800000000     /*-------------------------------------------------------------*/
795900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8178                    */
796000000000     /* Position de däpart infärieure ou ägale § 0.                 */
796100000000     /*-------------------------------------------------------------*/
796200000000
796300000000             RMVMSGD MSGID(USR8178) MSGF(&LIB/&OBJ)
796400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
796500000000
796600000000             ADDMSGD +
796700000000                MSGID(USR8178) +
796800000000                MSGF(&LIB/&OBJ) +
796900000000                MSG( +
797000000000'Position de däpart infärieure ou ägale § 0.'                         +
797100000000                ) +
797200000000                SEV(0) +
797300000000     /*   No replacement variables defined!                         */ +
797400000000                ALROPT(*NO) +
797500000000                CCSID(65535) +
797600000000                /*  -EOF-  */
797700000000
797800000000     /*-------------------------------------------------------------*/
797900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8179                    */
798000000000     /* Pas de guide disponible                                     */
798100000000     /*-------------------------------------------------------------*/
798200000000
798300000000             RMVMSGD MSGID(USR8179) MSGF(&LIB/&OBJ)
798400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
798500000000
798600000000             ADDMSGD +
798700000000                MSGID(USR8179) +
798800000000                MSGF(&LIB/&OBJ) +
798900000000                MSG( +
799000000000'Pas de guide disponible'                                             +
799100000000                ) +
799200000000                SEV(0) +
799300000000     /*   No replacement variables defined!                         */ +
799400000000                ALROPT(*NO) +
799500000000                CCSID(65535) +
799600000000                /*  -EOF-  */
799700000000
799800000000     /*-------------------------------------------------------------*/
799900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8180                    */
800000000000     /* Membre &1 introuvable.                                      */
800100000000     /*-------------------------------------------------------------*/
800200000000
800300000000             RMVMSGD MSGID(USR8180) MSGF(&LIB/&OBJ)
800400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
800500000000
800600000000             ADDMSGD +
800700000000                MSGID(USR8180) +
800800000000                MSGF(&LIB/&OBJ) +
800900000000                MSG( +
801000000000'Membre &1 introuvable.'                                              +
801100000000                ) +
801200000000                SEV(0) +
801300000000                FMT( +
801400000000                    (*CHAR 10) +
801500000000                ) +
801600000000                ALROPT(*NO) +
801700000000                CCSID(65535) +
801800000000                /*  -EOF-  */
801900000000
802000000000     /*-------------------------------------------------------------*/
802100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8181                    */
802200000000     /* Sauvegarde de l'environment impossible. Il manque le nom du */
802300000000     /*-------------------------------------------------------------*/
802400000000
802500000000             RMVMSGD MSGID(USR8181) MSGF(&LIB/&OBJ)
802600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
802700000000
802800000000             ADDMSGD +
802900000000                MSGID(USR8181) +
803000000000                MSGF(&LIB/&OBJ) +
803100000000                MSG( +
803200000000'Sauvegarde de l''environment impossible. Il manque le nom du fichier.-
803300000000'                                                                     +
803400000000                ) +
803500000000                SEV(0) +
803600000000     /*   No replacement variables defined!                         */ +
803700000000                ALROPT(*NO) +
803800000000                CCSID(65535) +
803900000000                /*  -EOF-  */
804000000000
804100000000     /*-------------------------------------------------------------*/
804200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8182                    */
804300000000     /* &1 n'est pas un nom valide pour un objet AS/400.            */
804400000000     /*-------------------------------------------------------------*/
804500000000
804600000000             RMVMSGD MSGID(USR8182) MSGF(&LIB/&OBJ)
804700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
804800000000
804900000000             ADDMSGD +
805000000000                MSGID(USR8182) +
805100000000                MSGF(&LIB/&OBJ) +
805200000000                MSG( +
805300000000'&1 n''est pas un nom valide pour un objet AS/400.'                   +
805400000000                ) +
805500000000                SEV(0) +
805600000000                FMT( +
805700000000                    (*CHAR 10) +
805800000000                ) +
805900000000                ALROPT(*NO) +
806000000000                CCSID(65535) +
806100000000                /*  -EOF-  */
806200000000
806300000000     /*-------------------------------------------------------------*/
806400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8183                    */
806500000000     /* Informations manquantes.                                    */
806600000000     /*-------------------------------------------------------------*/
806700000000
806800000000             RMVMSGD MSGID(USR8183) MSGF(&LIB/&OBJ)
806900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
807000000000
807100000000             ADDMSGD +
807200000000                MSGID(USR8183) +
807300000000                MSGF(&LIB/&OBJ) +
807400000000                MSG( +
807500000000'Informations manquantes.'                                            +
807600000000                ) +
807700000000                SEV(0) +
807800000000     /*   No replacement variables defined!                         */ +
807900000000                ALROPT(*NO) +
808000000000                CCSID(65535) +
808100000000                /*  -EOF-  */
808200000000
808300000000     /*-------------------------------------------------------------*/
808400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8184                    */
808500000000     /* Cette fonction est inactive. Veuillez contacter votre admin */
808600000000     /*-------------------------------------------------------------*/
808700000000
808800000000             RMVMSGD MSGID(USR8184) MSGF(&LIB/&OBJ)
808900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
809000000000
809100000000             ADDMSGD +
809200000000                MSGID(USR8184) +
809300000000                MSGF(&LIB/&OBJ) +
809400000000                MSG( +
809500000000'Cette fonction est inactive. Veuillez contacter votre administrateur.-
809600000000'                                                                     +
809700000000                ) +
809800000000                SEV(0) +
809900000000     /*   No replacement variables defined!                         */ +
810000000000                ALROPT(*NO) +
810100000000                CCSID(65535) +
810200000000                /*  -EOF-  */
810300000000
810400000000     /*-------------------------------------------------------------*/
810500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8185                    */
810600000000     /* Aucun environnement ouvert car aucun späcifiä.              */
810700000000     /*-------------------------------------------------------------*/
810800000000
810900000000             RMVMSGD MSGID(USR8185) MSGF(&LIB/&OBJ)
811000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
811100000000
811200000000             ADDMSGD +
811300000000                MSGID(USR8185) +
811400000000                MSGF(&LIB/&OBJ) +
811500000000                MSG( +
811600000000'Aucun environnement ouvert car aucun späcifiä.'                      +
811700000000                ) +
811800000000                SEV(0) +
811900000000     /*   No replacement variables defined!                         */ +
812000000000                ALROPT(*NO) +
812100000000                CCSID(65535) +
812200000000                /*  -EOF-  */
812300000000
812400000000     /*-------------------------------------------------------------*/
812500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8186                    */
812600000000     /* Attention : chaîne trop courte.                             */
812700000000     /*-------------------------------------------------------------*/
812800000000
812900000000             RMVMSGD MSGID(USR8186) MSGF(&LIB/&OBJ)
813000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
813100000000
813200000000             ADDMSGD +
813300000000                MSGID(USR8186) +
813400000000                MSGF(&LIB/&OBJ) +
813500000000                MSG( +
813600000000'Attention : chaîne trop courte.'                                     +
813700000000                ) +
813800000000                SEV(0) +
813900000000     /*   No replacement variables defined!                         */ +
814000000000                ALROPT(*NO) +
814100000000                CCSID(65535) +
814200000000                /*  -EOF-  */
814300000000
814400000000     /*-------------------------------------------------------------*/
814500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8187                    */
814600000000     /* La longueur du champ däpasse la taille du tampon d'E/S      */
814700000000     /*-------------------------------------------------------------*/
814800000000
814900000000             RMVMSGD MSGID(USR8187) MSGF(&LIB/&OBJ)
815000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
815100000000
815200000000             ADDMSGD +
815300000000                MSGID(USR8187) +
815400000000                MSGF(&LIB/&OBJ) +
815500000000                MSG( +
815600000000'La longueur du champ däpasse la taille du tampon d''E/S'             +
815700000000                ) +
815800000000                SEV(0) +
815900000000     /*   No replacement variables defined!                         */ +
816000000000                ALROPT(*NO) +
816100000000                CCSID(65535) +
816200000000                /*  -EOF-  */
816300000000
816400000000     /*-------------------------------------------------------------*/
816500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8188                    */
816600000000     /* Cräation fichier äcran. Etape: &1, Champ: &2                */
816700000000     /*-------------------------------------------------------------*/
816800000000
816900000000             RMVMSGD MSGID(USR8188) MSGF(&LIB/&OBJ)
817000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
817100000000
817200000000             ADDMSGD +
817300000000                MSGID(USR8188) +
817400000000                MSGF(&LIB/&OBJ) +
817500000000                MSG( +
817600000000'Cräation fichier äcran. Etape: &1, Champ: &2'                        +
817700000000                ) +
817800000000                SEV(0) +
817900000000                FMT( +
818000000000                    (*DEC 5 0) +
818100000000                    (*CHAR 10) +
818200000000                ) +
818300000000                ALROPT(*NO) +
818400000000                CCSID(65535) +
818500000000                /*  -EOF-  */
818600000000
818700000000     /*-------------------------------------------------------------*/
818800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8189                    */
818900000000     /* Cräation programme RPG. Etape: &1, Champ: &2                */
819000000000     /*-------------------------------------------------------------*/
819100000000
819200000000             RMVMSGD MSGID(USR8189) MSGF(&LIB/&OBJ)
819300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
819400000000
819500000000             ADDMSGD +
819600000000                MSGID(USR8189) +
819700000000                MSGF(&LIB/&OBJ) +
819800000000                MSG( +
819900000000'Cräation programme RPG. Etape: &1, Champ: &2'                        +
820000000000                ) +
820100000000                SEV(0) +
820200000000                FMT( +
820300000000                    (*DEC 5 0) +
820400000000                    (*CHAR 10) +
820500000000                ) +
820600000000                ALROPT(*NO) +
820700000000                CCSID(65535) +
820800000000                /*  -EOF-  */
820900000000
821000000000     /*-------------------------------------------------------------*/
821100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8190                    */
821200000000     /* Räponse &1 § la requête.                                    */
821300000000     /*-------------------------------------------------------------*/
821400000000
821500000000             RMVMSGD MSGID(USR8190) MSGF(&LIB/&OBJ)
821600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
821700000000
821800000000             ADDMSGD +
821900000000                MSGID(USR8190) +
822000000000                MSGF(&LIB/&OBJ) +
822100000000                MSG( +
822200000000'Räponse &1 § la requête.'                                            +
822300000000                ) +
822400000000                SEV(0) +
822500000000                FMT( +
822600000000                    (*CHAR 10) +
822700000000                ) +
822800000000                ALROPT(*NO) +
822900000000                CCSID(65535) +
823000000000                /*  -EOF-  */
823100000000
823200000000     /*-------------------------------------------------------------*/
823300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8191                    */
823400000000     /* Ce champ ne peut contenir la valeur NULL.                   */
823500000000     /*-------------------------------------------------------------*/
823600000000
823700000000             RMVMSGD MSGID(USR8191) MSGF(&LIB/&OBJ)
823800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
823900000000
824000000000             ADDMSGD +
824100000000                MSGID(USR8191) +
824200000000                MSGF(&LIB/&OBJ) +
824300000000                MSG( +
824400000000'Ce champ ne peut contenir la valeur NULL.'                           +
824500000000                ) +
824600000000                SEV(0) +
824700000000                FMT( +
824800000000                    (*CHAR 10) +
824900000000                ) +
825000000000                ALROPT(*NO) +
825100000000                CCSID(65535) +
825200000000                /*  -EOF-  */
825300000000
825400000000     /*-------------------------------------------------------------*/
825500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8192                    */
825600000000     /* Le champ &1 contient des donnäes flottantes incorrectes     */
825700000000     /*-------------------------------------------------------------*/
825800000000
825900000000             RMVMSGD MSGID(USR8192) MSGF(&LIB/&OBJ)
826000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
826100000000
826200000000             ADDMSGD +
826300000000                MSGID(USR8192) +
826400000000                MSGF(&LIB/&OBJ) +
826500000000                MSG( +
826600000000'Le champ &1 contient des donnäes flottantes incorrectes'             +
826700000000                ) +
826800000000                SEV(0) +
826900000000                FMT( +
827000000000                    (*CHAR 10) +
827100000000                ) +
827200000000                ALROPT(*NO) +
827300000000                CCSID(65535) +
827400000000                /*  -EOF-  */
827500000000
827600000000     /*-------------------------------------------------------------*/
827700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8193                    */
827800000000     /* Le champ '&1' contient des caractüres ne pouvant être trait */
827900000000     /*-------------------------------------------------------------*/
828000000000
828100000000             RMVMSGD MSGID(USR8193) MSGF(&LIB/&OBJ)
828200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
828300000000
828400000000             ADDMSGD +
828500000000                MSGID(USR8193) +
828600000000                MSGF(&LIB/&OBJ) +
828700000000                MSG( +
828800000000'Le champ ''&1'' contient des caractüres ne pouvant être traitäs dans -
828900000000l''äditeur'                                                           +
829000000000                ) +
829100000000                SEV(0) +
829200000000                FMT( +
829300000000                    (*CHAR 10) +
829400000000                ) +
829500000000                ALROPT(*NO) +
829600000000                CCSID(65535) +
829700000000                /*  -EOF-  */
829800000000
829900000000     /*-------------------------------------------------------------*/
830000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8194                    */
830100000000     /* Fichier '&1' introuvable                                    */
830200000000     /*-------------------------------------------------------------*/
830300000000
830400000000             RMVMSGD MSGID(USR8194) MSGF(&LIB/&OBJ)
830500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
830600000000
830700000000             ADDMSGD +
830800000000                MSGID(USR8194) +
830900000000                MSGF(&LIB/&OBJ) +
831000000000                MSG( +
831100000000'Fichier ''&1'' introuvable'                                          +
831200000000                ) +
831300000000                SEV(0) +
831400000000                FMT( +
831500000000                    (*CHAR 10) +
831600000000                ) +
831700000000                ALROPT(*NO) +
831800000000                CCSID(65535) +
831900000000                /*  -EOF-  */
832000000000
832100000000     /*-------------------------------------------------------------*/
832200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8195                    */
832300000000     /* Requête illägale car ce champ est protägä                   */
832400000000     /*-------------------------------------------------------------*/
832500000000
832600000000             RMVMSGD MSGID(USR8195) MSGF(&LIB/&OBJ)
832700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
832800000000
832900000000             ADDMSGD +
833000000000                MSGID(USR8195) +
833100000000                MSGF(&LIB/&OBJ) +
833200000000                MSG( +
833300000000'Requête illägale car ce champ est protägä'                           +
833400000000                ) +
833500000000                SEV(0) +
833600000000     /*   No replacement variables defined!                         */ +
833700000000                ALROPT(*NO) +
833800000000                CCSID(65535) +
833900000000                /*  -EOF-  */
834000000000
834100000000     /*-------------------------------------------------------------*/
834200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8196                    */
834300000000     /* Field &1 cannot be displayed or changed.                    */
834400000000     /*-------------------------------------------------------------*/
834500000000
834600000000             RMVMSGD MSGID(USR8196) MSGF(&LIB/&OBJ)
834700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
834800000000
834900000000             ADDMSGD +
835000000000                MSGID(USR8196) +
835100000000                MSGF(&LIB/&OBJ) +
835200000000                MSG( +
835300000000'Field &1 cannot be displayed or changed.'                            +
835400000000                ) +
835500000000                SECLVL( +
835600000000'&N &N Possible Causes: &N &B 1. Unknown data type. &B 2. Graphic fiel-
835700000000d without CCSID. &B 3. Packed or zoned field with more than 30 digits.-
835800000000 &B 4. Unknown variable length field.'                                +
835900000000                ) +
836000000000                SEV(0) +
836100000000                FMT( +
836200000000                    (*CHAR 10) +
836300000000                ) +
836400000000                ALROPT(*NO) +
836500000000                CCSID(65535) +
836600000000                /*  -EOF-  */
836700000000
836800000000     /*-------------------------------------------------------------*/
836900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8200                    */
837000000000     /* Suppression enregistrement &1 impossible                    */
837100000000     /*-------------------------------------------------------------*/
837200000000
837300000000             RMVMSGD MSGID(USR8200) MSGF(&LIB/&OBJ)
837400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
837500000000
837600000000             ADDMSGD +
837700000000                MSGID(USR8200) +
837800000000                MSGF(&LIB/&OBJ) +
837900000000                MSG( +
838000000000'Suppression enregistrement &1 impossible'                            +
838100000000                ) +
838200000000                SEV(0) +
838300000000                FMT( +
838400000000                    (*DEC 10 0) +
838500000000                ) +
838600000000                ALROPT(*NO) +
838700000000                CCSID(65535) +
838800000000                /*  -EOF-  */
838900000000
839000000000     /*-------------------------------------------------------------*/
839100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8201                    */
839200000000     /* Enregistrement &1 supprimä                                  */
839300000000     /*-------------------------------------------------------------*/
839400000000
839500000000             RMVMSGD MSGID(USR8201) MSGF(&LIB/&OBJ)
839600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
839700000000
839800000000             ADDMSGD +
839900000000                MSGID(USR8201) +
840000000000                MSGF(&LIB/&OBJ) +
840100000000                MSG( +
840200000000'Enregistrement &1 supprimä'                                          +
840300000000                ) +
840400000000                SEV(0) +
840500000000                FMT( +
840600000000                    (*DEC 10 0) +
840700000000                ) +
840800000000                ALROPT(*NO) +
840900000000                CCSID(65535) +
841000000000                /*  -EOF-  */
841100000000
841200000000     /*-------------------------------------------------------------*/
841300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8202                    */
841400000000     /* Copie enregistrement &1 impossible                          */
841500000000     /*-------------------------------------------------------------*/
841600000000
841700000000             RMVMSGD MSGID(USR8202) MSGF(&LIB/&OBJ)
841800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
841900000000
842000000000             ADDMSGD +
842100000000                MSGID(USR8202) +
842200000000                MSGF(&LIB/&OBJ) +
842300000000                MSG( +
842400000000'Copie enregistrement &1 impossible'                                  +
842500000000                ) +
842600000000                SEV(0) +
842700000000                FMT( +
842800000000                    (*DEC 10 0) +
842900000000                ) +
843000000000                ALROPT(*NO) +
843100000000                CCSID(65535) +
843200000000                /*  -EOF-  */
843300000000
843400000000     /*-------------------------------------------------------------*/
843500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8203                    */
843600000000     /* Enregistrement &1 copiä                                     */
843700000000     /*-------------------------------------------------------------*/
843800000000
843900000000             RMVMSGD MSGID(USR8203) MSGF(&LIB/&OBJ)
844000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
844100000000
844200000000             ADDMSGD +
844300000000                MSGID(USR8203) +
844400000000                MSGF(&LIB/&OBJ) +
844500000000                MSG( +
844600000000'Enregistrement &1 copiä'                                             +
844700000000                ) +
844800000000                SEV(0) +
844900000000                FMT( +
845000000000                    (*DEC 10 0) +
845100000000                ) +
845200000000                ALROPT(*NO) +
845300000000                CCSID(65535) +
845400000000                /*  -EOF-  */
845500000000
845600000000     /*-------------------------------------------------------------*/
845700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8204                    */
845800000000     /* Enreg. de sous fichier invalide                             */
845900000000     /*-------------------------------------------------------------*/
846000000000
846100000000             RMVMSGD MSGID(USR8204) MSGF(&LIB/&OBJ)
846200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
846300000000
846400000000             ADDMSGD +
846500000000                MSGID(USR8204) +
846600000000                MSGF(&LIB/&OBJ) +
846700000000                MSG( +
846800000000'Enreg. de sous fichier invalide'                                     +
846900000000                ) +
847000000000                SECLVL( +
847100000000'&N &N Pointez sur l''enregistrement däsirä et räpätez votre requête.'+
847200000000                ) +
847300000000                SEV(0) +
847400000000     /*   No replacement variables defined!                         */ +
847500000000                ALROPT(*NO) +
847600000000                CCSID(65535) +
847700000000                /*  -EOF-  */
847800000000
847900000000     /*-------------------------------------------------------------*/
848000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8205                    */
848100000000     /* Attention: Impossible de fixer plus de &1 colonnes!         */
848200000000     /*-------------------------------------------------------------*/
848300000000
848400000000             RMVMSGD MSGID(USR8205) MSGF(&LIB/&OBJ)
848500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
848600000000
848700000000             ADDMSGD +
848800000000                MSGID(USR8205) +
848900000000                MSGF(&LIB/&OBJ) +
849000000000                MSG( +
849100000000'Attention: Impossible de fixer plus de &1 colonnes!'                 +
849200000000                ) +
849300000000                SEV(0) +
849400000000                FMT( +
849500000000                    (*DEC 5 0) +
849600000000                ) +
849700000000                ALROPT(*NO) +
849800000000                CCSID(65535) +
849900000000                /*  -EOF-  */
850000000000
850100000000     /*-------------------------------------------------------------*/
850200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8206                    */
850300000000     /* Enregistrement non affichable. La taille däpasse le maximum */
850400000000     /*-------------------------------------------------------------*/
850500000000
850600000000             RMVMSGD MSGID(USR8206) MSGF(&LIB/&OBJ)
850700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
850800000000
850900000000             ADDMSGD +
851000000000                MSGID(USR8206) +
851100000000                MSGF(&LIB/&OBJ) +
851200000000                MSG( +
851300000000'Enregistrement non affichable. La taille däpasse le maximum de &1 oct-
851400000000ets.'                                                                 +
851500000000                ) +
851600000000                SEV(0) +
851700000000                FMT( +
851800000000                    (*DEC 5 0) +
851900000000                ) +
852000000000                ALROPT(*NO) +
852100000000                CCSID(65535) +
852200000000                /*  -EOF-  */
852300000000
852400000000     /*-------------------------------------------------------------*/
852500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8207                    */
852600000000     /* Le fichier ne peut être ouvert, la longueur de l'enregistre */
852700000000     /*-------------------------------------------------------------*/
852800000000
852900000000             RMVMSGD MSGID(USR8207) MSGF(&LIB/&OBJ)
853000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
853100000000
853200000000             ADDMSGD +
853300000000                MSGID(USR8207) +
853400000000                MSGF(&LIB/&OBJ) +
853500000000                MSG( +
853600000000'Le fichier ne peut être ouvert, la longueur de l''enregistrement däpa-
853700000000ssant &1 octets.'                                                     +
853800000000                ) +
853900000000                SEV(0) +
854000000000                FMT( +
854100000000                    (*DEC 5 0) +
854200000000                ) +
854300000000                ALROPT(*NO) +
854400000000                CCSID(65535) +
854500000000                /*  -EOF-  */
854600000000
854700000000     /*-------------------------------------------------------------*/
854800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8208                    */
854900000000     /* Vous n'êtes pas autorisä § modifier des fichiers en lecture */
855000000000     /*-------------------------------------------------------------*/
855100000000
855200000000             RMVMSGD MSGID(USR8208) MSGF(&LIB/&OBJ)
855300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
855400000000
855500000000             ADDMSGD +
855600000000                MSGID(USR8208) +
855700000000                MSGF(&LIB/&OBJ) +
855800000000                MSG( +
855900000000'Vous n''êtes pas autorisä § modifier des fichiers en lecture seule.' +
856000000000                ) +
856100000000                SEV(0) +
856200000000     /*   No replacement variables defined!                         */ +
856300000000                ALROPT(*NO) +
856400000000                CCSID(65535) +
856500000000                /*  -EOF-  */
856600000000
856700000000     /*-------------------------------------------------------------*/
856800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8209                    */
856900000000     /* Veuillez entrer un argument de recherche.                   */
857000000000     /*-------------------------------------------------------------*/
857100000000
857200000000             RMVMSGD MSGID(USR8209) MSGF(&LIB/&OBJ)
857300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
857400000000
857500000000             ADDMSGD +
857600000000                MSGID(USR8209) +
857700000000                MSGF(&LIB/&OBJ) +
857800000000                MSG( +
857900000000'Veuillez entrer un argument de recherche.'                           +
858000000000                ) +
858100000000                SEV(0) +
858200000000     /*   No replacement variables defined!                         */ +
858300000000                ALROPT(*NO) +
858400000000                CCSID(65535) +
858500000000                /*  -EOF-  */
858600000000
858700000000     /*-------------------------------------------------------------*/
858800000000     /*   Cmd-ADDMSGD für Message-ID :   USR8210                    */
858900000000     /* Erreur SQL &1. &2                                           */
859000000000     /*-------------------------------------------------------------*/
859100000000
859200000000             RMVMSGD MSGID(USR8210) MSGF(&LIB/&OBJ)
859300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
859400000000
859500000000             ADDMSGD +
859600000000                MSGID(USR8210) +
859700000000                MSGF(&LIB/&OBJ) +
859800000000                MSG( +
859900000000'Erreur SQL &1. &2'                                                   +
860000000000                ) +
860100000000                SECLVL( +
860200000000'''&N &N Cause  . . . . :   &2 &N &B Vous trouverez plus d''informatio-
860300000000n sur ce code erreur dans le manuel de programmation SQL ou dans le fi-
860400000000chier de messages QSYS/QSQLMSG.'''                                    +
860500000000                ) +
860600000000                SEV(0) +
860700000000                FMT( +
860800000000                    (*CHAR 7) +
860900000000                    (*CHAR 512) +
861000000000                ) +
861100000000                ALROPT(*NO) +
861200000000                CCSID(65535) +
861300000000                /*  -EOF-  */
861400000000
861500000000     /*-------------------------------------------------------------*/
861600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8211                    */
861700000000     /* Veuillez placer le curseur dans un champ et relancer votre  */
861800000000     /*-------------------------------------------------------------*/
861900000000
862000000000             RMVMSGD MSGID(USR8211) MSGF(&LIB/&OBJ)
862100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
862200000000
862300000000             ADDMSGD +
862400000000                MSGID(USR8211) +
862500000000                MSGF(&LIB/&OBJ) +
862600000000                MSG( +
862700000000'Veuillez placer le curseur dans un champ et relancer votre requête.' +
862800000000                ) +
862900000000                SECLVL( +
863000000000'Cause  . . . . :   Le curseur se trouve hors d''un champ ou le champ -
863100000000n''est pas valide pour la requête.'                                   +
863200000000                ) +
863300000000                SEV(0) +
863400000000     /*   No replacement variables defined!                         */ +
863500000000                ALROPT(*NO) +
863600000000                CCSID(65535) +
863700000000                /*  -EOF-  */
863800000000
863900000000     /*-------------------------------------------------------------*/
864000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8212                    */
864100000000     /* Une sälection SQL ne peut s'appliquer qu'aux fichiers physi */
864200000000     /*-------------------------------------------------------------*/
864300000000
864400000000             RMVMSGD MSGID(USR8212) MSGF(&LIB/&OBJ)
864500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
864600000000
864700000000             ADDMSGD +
864800000000                MSGID(USR8212) +
864900000000                MSGF(&LIB/&OBJ) +
865000000000                MSG( +
865100000000'Une sälection SQL ne peut s''appliquer qu''aux fichiers physiques. Ou-
865200000000vrir le fichier physique ?'''                                         +
865300000000                ) +
865400000000                SEV(0) +
865500000000     /*   No replacement variables defined!                         */ +
865600000000                ALROPT(*NO) +
865700000000                CCSID(65535) +
865800000000                /*  -EOF-  */
865900000000
866000000000     /*-------------------------------------------------------------*/
866100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8213                    */
866200000000     /* 1=Sauvegarder; 0=Ne pas sauvegarder                         */
866300000000     /*-------------------------------------------------------------*/
866400000000
866500000000             RMVMSGD MSGID(USR8213) MSGF(&LIB/&OBJ)
866600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
866700000000
866800000000             ADDMSGD +
866900000000                MSGID(USR8213) +
867000000000                MSGF(&LIB/&OBJ) +
867100000000                MSG( +
867200000000'1=Sauvegarder; 0=Ne pas sauvegarder'                                 +
867300000000                ) +
867400000000                SEV(0) +
867500000000     /*   No replacement variables defined!                         */ +
867600000000                ALROPT(*NO) +
867700000000                CCSID(65535) +
867800000000                /*  -EOF-  */
867900000000
868000000000     /*-------------------------------------------------------------*/
868100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8214                    */
868200000000     /* 1=Admettre minuscules 0=Majuscules seulement                */
868300000000     /*-------------------------------------------------------------*/
868400000000
868500000000             RMVMSGD MSGID(USR8214) MSGF(&LIB/&OBJ)
868600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
868700000000
868800000000             ADDMSGD +
868900000000                MSGID(USR8214) +
869000000000                MSGF(&LIB/&OBJ) +
869100000000                MSG( +
869200000000'1=Admettre minuscules 0=Majuscules seulement'                        +
869300000000                ) +
869400000000                SEV(0) +
869500000000     /*   No replacement variables defined!                         */ +
869600000000                ALROPT(*NO) +
869700000000                CCSID(65535) +
869800000000                /*  -EOF-  */
869900000000
870000000000     /*-------------------------------------------------------------*/
870100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8215                    */
870200000000     /* Minuscule interdite                                         */
870300000000     /*-------------------------------------------------------------*/
870400000000
870500000000             RMVMSGD MSGID(USR8215) MSGF(&LIB/&OBJ)
870600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
870700000000
870800000000             ADDMSGD +
870900000000                MSGID(USR8215) +
871000000000                MSGF(&LIB/&OBJ) +
871100000000                MSG( +
871200000000'Minuscule interdite'                                                 +
871300000000                ) +
871400000000                SEV(0) +
871500000000     /*   No replacement variables defined!                         */ +
871600000000                ALROPT(*NO) +
871700000000                CCSID(65535) +
871800000000                /*  -EOF-  */
871900000000
872000000000     /*-------------------------------------------------------------*/
872100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8216                    */
872200000000     /* Ces valeurs sont incompatibles.                             */
872300000000     /*-------------------------------------------------------------*/
872400000000
872500000000             RMVMSGD MSGID(USR8216) MSGF(&LIB/&OBJ)
872600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
872700000000
872800000000             ADDMSGD +
872900000000                MSGID(USR8216) +
873000000000                MSGF(&LIB/&OBJ) +
873100000000                MSG( +
873200000000'Ces valeurs sont incompatibles.'                                     +
873300000000                ) +
873400000000                SECLVL( +
873500000000'Si vous voulez interdire § l''utilisateur de saisir des minuscules, v-
873600000000ous ne pouvez prendre cette valeur comme däfaut.'''                   +
873700000000                ) +
873800000000                SEV(0) +
873900000000     /*   No replacement variables defined!                         */ +
874000000000                ALROPT(*NO) +
874100000000                CCSID(65535) +
874200000000                /*  -EOF-  */
874300000000
874400000000     /*-------------------------------------------------------------*/
874500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8217                    */
874600000000     /* Trier sur le nÄ d'enregistement relatif est impossible.     */
874700000000     /*-------------------------------------------------------------*/
874800000000
874900000000             RMVMSGD MSGID(USR8217) MSGF(&LIB/&OBJ)
875000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
875100000000
875200000000             ADDMSGD +
875300000000                MSGID(USR8217) +
875400000000                MSGF(&LIB/&OBJ) +
875500000000                MSG( +
875600000000'Trier sur le nÄ d''enregistement relatif est impossible.'            +
875700000000                ) +
875800000000                SECLVL( +
875900000000'Il est impossible d''ouvrir ce fichier triä sur le nÄ relatif car il -
876000000000est basä sur plus d''un membre.'                                      +
876100000000                ) +
876200000000                SEV(0) +
876300000000     /*   No replacement variables defined!                         */ +
876400000000                ALROPT(*NO) +
876500000000                CCSID(65535) +
876600000000                /*  -EOF-  */
876700000000
876800000000     /*-------------------------------------------------------------*/
876900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8218                    */
877000000000     /* L'enregistement ne peut être fixä. La vue se base sur de mu */
877100000000     /*-------------------------------------------------------------*/
877200000000
877300000000             RMVMSGD MSGID(USR8218) MSGF(&LIB/&OBJ)
877400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
877500000000
877600000000             ADDMSGD +
877700000000                MSGID(USR8218) +
877800000000                MSGF(&LIB/&OBJ) +
877900000000                MSG( +
878000000000'L''enregistement ne peut être fixä. La vue se base sur de multiples m-
878100000000embres physiques.'                                                    +
878200000000                ) +
878300000000                SECLVL( +
878400000000'&N &N Cause . . . . . :  L''enregistrement ne peut être fixä. Le nÄ d-
878500000000''enregistrement n''est pas unique et il est impossible de däterminer -
878600000000le membre physique qui le contient.'                                  +
878700000000                ) +
878800000000                SEV(0) +
878900000000     /*   No replacement variables defined!                         */ +
879000000000                ALROPT(*NO) +
879100000000                CCSID(65535) +
879200000000                /*  -EOF-  */
879300000000
879400000000     /*-------------------------------------------------------------*/
879500000000     /*   Cmd-ADDMSGD für Message-ID :   USR8219                    */
879600000000     /* Valeur '&1' incorrecte pour un choix Oui/Non                */
879700000000     /*-------------------------------------------------------------*/
879800000000
879900000000             RMVMSGD MSGID(USR8219) MSGF(&LIB/&OBJ)
880000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
880100000000
880200000000             ADDMSGD +
880300000000                MSGID(USR8219) +
880400000000                MSGF(&LIB/&OBJ) +
880500000000                MSG( +
880600000000'Valeur ''&1'' incorrecte pour un choix Oui/Non'                      +
880700000000                ) +
880800000000                SEV(0) +
880900000000                FMT( +
881000000000                    (*CHAR 10) +
881100000000                ) +
881200000000                ALROPT(*NO) +
881300000000                CCSID(65535) +
881400000000                /*  -EOF-  */
881500000000
881600000000     /*-------------------------------------------------------------*/
881700000000     /*   Cmd-ADDMSGD für Message-ID :   USR8220                    */
881800000000     /* Edition interdite. Le champ &1 contient NULL.               */
881900000000     /*-------------------------------------------------------------*/
882000000000
882100000000             RMVMSGD MSGID(USR8220) MSGF(&LIB/&OBJ)
882200000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
882300000000
882400000000             ADDMSGD +
882500000000                MSGID(USR8220) +
882600000000                MSGF(&LIB/&OBJ) +
882700000000                MSG( +
882800000000'Edition interdite. Le champ &1 contient NULL.'                       +
882900000000                ) +
883000000000                SEV(0) +
883100000000                FMT( +
883200000000                    (*CHAR 10) +
883300000000                ) +
883400000000                ALROPT(*NO) +
883500000000                CCSID(65535) +
883600000000                /*  -EOF-  */
883700000000
883800000000     /*-------------------------------------------------------------*/
883900000000     /*   Cmd-ADDMSGD für Message-ID :   USR8221                    */
884000000000     /* L'äditeur ne supporte pas le type de donnäe de ce champ.    */
884100000000     /*-------------------------------------------------------------*/
884200000000
884300000000             RMVMSGD MSGID(USR8221) MSGF(&LIB/&OBJ)
884400000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
884500000000
884600000000             ADDMSGD +
884700000000                MSGID(USR8221) +
884800000000                MSGF(&LIB/&OBJ) +
884900000000                MSG( +
885000000000'L''äditeur ne supporte pas le type de donnäe de ce champ.'           +
885100000000                ) +
885200000000                SEV(0) +
885300000000                FMT( +
885400000000                    (*CHAR 10) +
885500000000                ) +
885600000000                ALROPT(*NO) +
885700000000                CCSID(65535) +
885800000000                /*  -EOF-  */
885900000000
886000000000     /*-------------------------------------------------------------*/
886100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8222                    */
886200000000     /* Le champ &1 däpasse la taille maximum allouäe § l'äditeur   */
886300000000     /*-------------------------------------------------------------*/
886400000000
886500000000             RMVMSGD MSGID(USR8222) MSGF(&LIB/&OBJ)
886600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
886700000000
886800000000             ADDMSGD +
886900000000                MSGID(USR8222) +
887000000000                MSGF(&LIB/&OBJ) +
887100000000                MSG( +
887200000000'Le champ &1 däpasse la taille maximum allouäe § l''äditeur'          +
887300000000                ) +
887400000000                SEV(0) +
887500000000                FMT( +
887600000000                    (*CHAR 10) +
887700000000                ) +
887800000000                ALROPT(*NO) +
887900000000                CCSID(65535) +
888000000000                /*  -EOF-  */
888100000000
888200000000     /*-------------------------------------------------------------*/
888300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8223                    */
888400000000     /* Saisie basculäe en mode minuscule                           */
888500000000     /*-------------------------------------------------------------*/
888600000000
888700000000             RMVMSGD MSGID(USR8223) MSGF(&LIB/&OBJ)
888800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
888900000000
889000000000             ADDMSGD +
889100000000                MSGID(USR8223) +
889200000000                MSGF(&LIB/&OBJ) +
889300000000                MSG( +
889400000000'Saisie basculäe en mode minuscule'                                   +
889500000000                ) +
889600000000                SEV(0) +
889700000000     /*   No replacement variables defined!                         */ +
889800000000                ALROPT(*NO) +
889900000000                CCSID(65535) +
890000000000                /*  -EOF-  */
890100000000
890200000000     /*-------------------------------------------------------------*/
890300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8224                    */
890400000000     /* Saisie basculäe en mode majuscule                           */
890500000000     /*-------------------------------------------------------------*/
890600000000
890700000000             RMVMSGD MSGID(USR8224) MSGF(&LIB/&OBJ)
890800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
890900000000
891000000000             ADDMSGD +
891100000000                MSGID(USR8224) +
891200000000                MSGF(&LIB/&OBJ) +
891300000000                MSG( +
891400000000'Saisie basculäe en mode majuscule'                                   +
891500000000                ) +
891600000000                SEV(0) +
891700000000     /*   No replacement variables defined!                         */ +
891800000000                ALROPT(*NO) +
891900000000                CCSID(65535) +
892000000000                /*  -EOF-  */
892100000000
892200000000     /*-------------------------------------------------------------*/
892300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8225                    */
892400000000     /* L'enregistrement a ätä modifiä par un autre utilisateur.°°M */
892500000000     /*-------------------------------------------------------------*/
892600000000
892700000000             RMVMSGD MSGID(USR8225) MSGF(&LIB/&OBJ)
892800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
892900000000
893000000000             ADDMSGD +
893100000000                MSGID(USR8225) +
893200000000                MSGF(&LIB/&OBJ) +
893300000000                MSG( +
893400000000'L''enregistrement a ätä modifiä par un autre utilisateur.°°Modifier t-
893500000000out de même ?'                                                        +
893600000000                ) +
893700000000                SEV(0) +
893800000000     /*   No replacement variables defined!                         */ +
893900000000                ALROPT(*NO) +
894000000000                CCSID(65535) +
894100000000                /*  -EOF-  */
894200000000
894300000000     /*-------------------------------------------------------------*/
894400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8226                    */
894500000000     /* Impression effectuäe                                        */
894600000000     /*-------------------------------------------------------------*/
894700000000
894800000000             RMVMSGD MSGID(USR8226) MSGF(&LIB/&OBJ)
894900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
895000000000
895100000000             ADDMSGD +
895200000000                MSGID(USR8226) +
895300000000                MSGF(&LIB/&OBJ) +
895400000000                MSG( +
895500000000'Impression effectuäe'                                                +
895600000000                ) +
895700000000                SEV(0) +
895800000000     /*   No replacement variables defined!                         */ +
895900000000                ALROPT(*NO) +
896000000000                CCSID(65535) +
896100000000                /*  -EOF-  */
896200000000
896300000000     /*-------------------------------------------------------------*/
896400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8227                    */
896500000000     /* Echec de conversion '&1' en numärique                       */
896600000000     /*-------------------------------------------------------------*/
896700000000
896800000000             RMVMSGD MSGID(USR8227) MSGF(&LIB/&OBJ)
896900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
897000000000
897100000000             ADDMSGD +
897200000000                MSGID(USR8227) +
897300000000                MSGF(&LIB/&OBJ) +
897400000000                MSG( +
897500000000'Echec de conversion ''&1'' en numärique'                             +
897600000000                ) +
897700000000                SECLVL( +
897800000000'&N &N Information . . :   Erreur lors de laconversion ''&1'' en numär-
897900000000ique. La chaîne n''a pas pu être convertie en numärique &2(&3,&4).'   +
898000000000                ) +
898100000000                SEV(0) +
898200000000                FMT( +
898300000000                    (*CHAR 256) +
898400000000                    (*CHAR 1) +
898500000000                    (*DEC 5 0) +
898600000000                    (*DEC 5 0) +
898700000000                ) +
898800000000                ALROPT(*NO) +
898900000000                CCSID(65535) +
899000000000                /*  -EOF-  */
899100000000
899200000000     /*-------------------------------------------------------------*/
899300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8228                    */
899400000000     /* Type de donnäe incorrect '&1'.                              */
899500000000     /*-------------------------------------------------------------*/
899600000000
899700000000             RMVMSGD MSGID(USR8228) MSGF(&LIB/&OBJ)
899800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
899900000000
900000000000             ADDMSGD +
900100000000                MSGID(USR8228) +
900200000000                MSGF(&LIB/&OBJ) +
900300000000                MSG( +
900400000000'Type de donnäe incorrect ''&1''.'                                    +
900500000000                ) +
900600000000                SECLVL( +
900700000000'&N &N Information . . :   Le type de donnäe späcifiä  ''&1'' est inco-
900800000000rrect.. Veuillez späcifier un type de donnäe RPG valide et relancer vo-
900900000000tre requête.'                                                         +
901000000000                ) +
901100000000                SEV(0) +
901200000000                FMT( +
901300000000                    (*CHAR 256) +
901400000000                ) +
901500000000                ALROPT(*NO) +
901600000000                CCSID(65535) +
901700000000                /*  -EOF-  */
901800000000
901900000000     /*-------------------------------------------------------------*/
902000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8229                    */
902100000000     /* Taille du champ invalide: '&1'.                             */
902200000000     /*-------------------------------------------------------------*/
902300000000
902400000000             RMVMSGD MSGID(USR8229) MSGF(&LIB/&OBJ)
902500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
902600000000
902700000000             ADDMSGD +
902800000000                MSGID(USR8229) +
902900000000                MSGF(&LIB/&OBJ) +
903000000000                MSG( +
903100000000'Taille du champ invalide: ''&1''.'                                   +
903200000000                ) +
903300000000                SECLVL( +
903400000000'&N &N Information . . :   La taille du champ ''&1'' est incorrecte. V-
903500000000euillez corriger cette valeur et relancer votre requête'              +
903600000000                ) +
903700000000                SEV(0) +
903800000000                FMT( +
903900000000                    (*CHAR 256) +
904000000000                ) +
904100000000                ALROPT(*NO) +
904200000000                CCSID(65535) +
904300000000                /*  -EOF-  */
904400000000
904500000000     /*-------------------------------------------------------------*/
904600000000     /*   Cmd-ADDMSGD für Message-ID :   USR8230                    */
904700000000     /* Nombre incorrect de positions däcimales: '&1'.              */
904800000000     /*-------------------------------------------------------------*/
904900000000
905000000000             RMVMSGD MSGID(USR8230) MSGF(&LIB/&OBJ)
905100000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
905200000000
905300000000             ADDMSGD +
905400000000                MSGID(USR8230) +
905500000000                MSGF(&LIB/&OBJ) +
905600000000                MSG( +
905700000000'Nombre incorrect de positions däcimales: ''&1''.'                    +
905800000000                ) +
905900000000                SECLVL( +
906000000000'&N &N Information . . :   Le nombre de däcimales späcifiäes est incor-
906100000000rect. Veuillez corriger et relancer votre requête. Il est § noter que -
906200000000tous les types de donnäe, comme par exemple ''A'' pour les chaînes, ne-
906300000000 requiürent pas de däcimales.'                                        +
906400000000                ) +
906500000000                SEV(0) +
906600000000                FMT( +
906700000000                    (*CHAR 256) +
906800000000                ) +
906900000000                ALROPT(*NO) +
907000000000                CCSID(65535) +
907100000000                /*  -EOF-  */
907200000000
907300000000     /*-------------------------------------------------------------*/
907400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8231                    */
907500000000     /* Etat de verrouillage de l'enregistrement non modifiable dur */
907600000000     /*-------------------------------------------------------------*/
907700000000
907800000000             RMVMSGD MSGID(USR8231) MSGF(&LIB/&OBJ)
907900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
908000000000
908100000000             ADDMSGD +
908200000000                MSGID(USR8231) +
908300000000                MSGF(&LIB/&OBJ) +
908400000000                MSG( +
908500000000'Etat de verrouillage de l''enregistrement non modifiable durant la co-
908600000000pie ou l''ajout.'''                                                   +
908700000000                ) +
908800000000                SECLVL( +
908900000000'&N &N Information . . :   le verrouillage de l''enregistrement ne peu-
909000000000t être changä. Seule la modification de l''enregistrement peut le chan-
909100000000ger.'''                                                               +
909200000000                ) +
909300000000                SEV(0) +
909400000000     /*   No replacement variables defined!                         */ +
909500000000                ALROPT(*NO) +
909600000000                CCSID(65535) +
909700000000                /*  -EOF-  */
909800000000
909900000000     /*-------------------------------------------------------------*/
910000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8232                    */
910100000000     /* L'enregistrement a ätä modifiä par un autre utilisateur. °° */
910200000000     /*-------------------------------------------------------------*/
910300000000
910400000000             RMVMSGD MSGID(USR8232) MSGF(&LIB/&OBJ)
910500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
910600000000
910700000000             ADDMSGD +
910800000000                MSGID(USR8232) +
910900000000                MSGF(&LIB/&OBJ) +
911000000000                MSG( +
911100000000'L''enregistrement a ätä modifiä par un autre utilisateur. °°Verrouill-
911200000000er l''enregistrement tout de même ?'                                  +
911300000000                ) +
911400000000                SEV(0) +
911500000000     /*   No replacement variables defined!                         */ +
911600000000                ALROPT(*NO) +
911700000000                CCSID(65535) +
911800000000                /*  -EOF-  */
911900000000
912000000000     /*-------------------------------------------------------------*/
912100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8233                    */
912200000000     /* Erreur: Maquette inutilisable. Niveaux de format diffärents */
912300000000     /*-------------------------------------------------------------*/
912400000000
912500000000             RMVMSGD MSGID(USR8233) MSGF(&LIB/&OBJ)
912600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
912700000000
912800000000             ADDMSGD +
912900000000                MSGID(USR8233) +
913000000000                MSGF(&LIB/&OBJ) +
913100000000                MSG( +
913200000000'Erreur: Maquette inutilisable. Niveaux de format diffärents'         +
913300000000                ) +
913400000000                SECLVL( +
913500000000'&N &N Solution  . . . :   Retirer l''ID niveau du fichier &2/&1, memb-
913600000000re &3 pour däsactiver le contrôle et appliquer § nouveau la maquette. -
913700000000Puis sauvegardez la maquette.'                                        +
913800000000                ) +
913900000000                SEV(0) +
914000000000                FMT( +
914100000000                    (*CHAR 10) +
914200000000                    (*CHAR 10) +
914300000000                    (*CHAR 10) +
914400000000                ) +
914500000000                ALROPT(*NO) +
914600000000                CCSID(65535) +
914700000000                /*  -EOF-  */
914800000000
914900000000     /*-------------------------------------------------------------*/
915000000000     /*   Cmd-ADDMSGD für Message-ID :   USR8234                    */
915100000000     /* Impossible de charger la maquette - les niveaux de format n */
915200000000     /*-------------------------------------------------------------*/
915300000000
915400000000             RMVMSGD MSGID(USR8234) MSGF(&LIB/&OBJ)
915500000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
915600000000
915700000000             ADDMSGD +
915800000000                MSGID(USR8234) +
915900000000                MSGF(&LIB/&OBJ) +
916000000000                MSG( +
916100000000'Impossible de charger la maquette - les niveaux de format ne correspo-
916200000000ndent pas.'                                                           +
916300000000                ) +
916400000000                SECLVL( +
916500000000'&N &N Cause . . . . niveaux de format diffärents entre fichier et maq-
916600000000uette. Retirer l''ID niveau du fichier &2/&1, membre &3 pour däsactive-
916700000000r le contrôle et appliquer § nouveau la maquette. Puis sauvegarder la -
916800000000maquette.'                                                            +
916900000000                ) +
917000000000                SEV(0) +
917100000000                FMT( +
917200000000                    (*CHAR 10) +
917300000000                    (*CHAR 10) +
917400000000                    (*CHAR 10) +
917500000000                ) +
917600000000                ALROPT(*NO) +
917700000000                CCSID(65535) +
917800000000                /*  -EOF-  */
917900000000
918000000000     /*-------------------------------------------------------------*/
918100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8235                    */
918200000000     /* SQL-Selection not supported for multi-member logical files. */
918300000000     /*-------------------------------------------------------------*/
918400000000
918500000000             RMVMSGD MSGID(USR8235) MSGF(&LIB/&OBJ)
918600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
918700000000
918800000000             ADDMSGD +
918900000000                MSGID(USR8235) +
919000000000                MSGF(&LIB/&OBJ) +
919100000000                MSG( +
919200000000'SQL-Selection not supported for multi-member logical files.'         +
919300000000                ) +
919400000000                SEV(0) +
919500000000     /*   No replacement variables defined!                         */ +
919600000000                ALROPT(*NO) +
919700000000                CCSID(65535) +
919800000000                /*  -EOF-  */
919900000000
920000000000     /*-------------------------------------------------------------*/
920100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8236                    */
920200000000     /* Mode insertion activä. Positionnez le curseur, puis appuyez */
920300000000     /*-------------------------------------------------------------*/
920400000000
920500000000             RMVMSGD MSGID(USR8236) MSGF(&LIB/&OBJ)
920600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
920700000000
920800000000             ADDMSGD +
920900000000                MSGID(USR8236) +
921000000000                MSGF(&LIB/&OBJ) +
921100000000                MSG( +
921200000000'Mode insertion activä. Positionnez le curseur, puis appuyez sur F7.' +
921300000000                ) +
921400000000                SEV(0) +
921500000000     /*   No replacement variables defined!                         */ +
921600000000                ALROPT(*NO) +
921700000000                CCSID(65535) +
921800000000                /*  -EOF-  */
921900000000
922000000000     /*-------------------------------------------------------------*/
922100000000     /*   Cmd-ADDMSGD für Message-ID :   USR8237                    */
922200000000     /* Appuyer sur la touche "Enträe" pour insärer le nombre d'esp */
922300000000     /*-------------------------------------------------------------*/
922400000000
922500000000             RMVMSGD MSGID(USR8237) MSGF(&LIB/&OBJ)
922600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
922700000000
922800000000             ADDMSGD +
922900000000                MSGID(USR8237) +
923000000000                MSGF(&LIB/&OBJ) +
923100000000                MSG( +
923200000000'Appuyer sur la touche "Enträe" pour insärer le nombre d''espaces indi-
923300000000quä.'                                                                 +
923400000000                ) +
923500000000                SEV(0) +
923600000000     /*   No replacement variables defined!                         */ +
923700000000                ALROPT(*NO) +
923800000000                CCSID(65535) +
923900000000                /*  -EOF-  */
924000000000
924100000000     /*-------------------------------------------------------------*/
924200000000     /*   Cmd-ADDMSGD für Message-ID :   USR8238                    */
924300000000     /* Mode de suppression activä. Positionnez le curseur, puis ap */
924400000000     /*-------------------------------------------------------------*/
924500000000
924600000000             RMVMSGD MSGID(USR8238) MSGF(&LIB/&OBJ)
924700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
924800000000
924900000000             ADDMSGD +
925000000000                MSGID(USR8238) +
925100000000                MSGF(&LIB/&OBJ) +
925200000000                MSG( +
925300000000'Mode de suppression activä. Positionnez le curseur, puis appuyez sur -
925400000000F8.'                                                                  +
925500000000                ) +
925600000000                SEV(0) +
925700000000     /*   No replacement variables defined!                         */ +
925800000000                ALROPT(*NO) +
925900000000                CCSID(65535) +
926000000000                /*  -EOF-  */
926100000000
926200000000     /*-------------------------------------------------------------*/
926300000000     /*   Cmd-ADDMSGD für Message-ID :   USR8239                    */
926400000000     /* Appuyer sur la touche "Enträe" pour effacer la plage de car */
926500000000     /*-------------------------------------------------------------*/
926600000000
926700000000             RMVMSGD MSGID(USR8239) MSGF(&LIB/&OBJ)
926800000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
926900000000
927000000000             ADDMSGD +
927100000000                MSGID(USR8239) +
927200000000                MSGF(&LIB/&OBJ) +
927300000000                MSG( +
927400000000'Appuyer sur la touche "Enträe" pour effacer la plage de caractüres sp-
927500000000äcifiäe.'                                                             +
927600000000                ) +
927700000000                SEV(0) +
927800000000     /*   No replacement variables defined!                         */ +
927900000000                ALROPT(*NO) +
928000000000                CCSID(65535) +
928100000000                /*  -EOF-  */
928200000000
928300000000     /*-------------------------------------------------------------*/
928400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8240                    */
928500000000     /* La valeur ne doit pas être infärieure § 1.                  */
928600000000     /*-------------------------------------------------------------*/
928700000000
928800000000             RMVMSGD MSGID(USR8240) MSGF(&LIB/&OBJ)
928900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
929000000000
929100000000             ADDMSGD +
929200000000                MSGID(USR8240) +
929300000000                MSGF(&LIB/&OBJ) +
929400000000                MSG( +
929500000000'La valeur ne doit pas être infärieure § 1.'                          +
929600000000                ) +
929700000000                SEV(0) +
929800000000     /*   No replacement variables defined!                         */ +
929900000000                ALROPT(*NO) +
930000000000                CCSID(65535) +
930100000000                /*  -EOF-  */
930200000000
930300000000     /*-------------------------------------------------------------*/
930400000000     /*   Cmd-ADDMSGD für Message-ID :   USR8241                    */
930500000000     /* La valeur ne doit pas däpasser la longueur du champ.        */
930600000000     /*-------------------------------------------------------------*/
930700000000
930800000000             RMVMSGD MSGID(USR8241) MSGF(&LIB/&OBJ)
930900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
931000000000
931100000000             ADDMSGD +
931200000000                MSGID(USR8241) +
931300000000                MSGF(&LIB/&OBJ) +
931400000000                MSG( +
931500000000'La valeur ne doit pas däpasser la longueur du champ.'                +
931600000000                ) +
931700000000                SEV(0) +
931800000000     /*   No replacement variables defined!                         */ +
931900000000                ALROPT(*NO) +
932000000000                CCSID(65535) +
932100000000                /*  -EOF-  */
932200000000
932300000000     /*-------------------------------------------------------------*/
932400000000     /*   Cmd-ADDMSGD für Message-ID :   USR9992                    */
932500000000     /* Echec sauvegarde paramütres utilisateur                     */
932600000000     /*-------------------------------------------------------------*/
932700000000
932800000000             RMVMSGD MSGID(USR9992) MSGF(&LIB/&OBJ)
932900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
933000000000
933100000000             ADDMSGD +
933200000000                MSGID(USR9992) +
933300000000                MSGF(&LIB/&OBJ) +
933400000000                MSG( +
933500000000'Echec sauvegarde paramütres utilisateur'                             +
933600000000                ) +
933700000000                SEV(0) +
933800000000     /*   No replacement variables defined!                         */ +
933900000000                ALROPT(*NO) +
934000000000                CCSID(65535) +
934100000000                /*  -EOF-  */
934200000000
934300000000     /*-------------------------------------------------------------*/
934400000000     /*   Cmd-ADDMSGD für Message-ID :   USR9993                    */
934500000000     /* Fichier non ouvert. SQL est limitä aux fichiers physiques   */
934600000000     /*-------------------------------------------------------------*/
934700000000
934800000000             RMVMSGD MSGID(USR9993) MSGF(&LIB/&OBJ)
934900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
935000000000
935100000000             ADDMSGD +
935200000000                MSGID(USR9993) +
935300000000                MSGF(&LIB/&OBJ) +
935400000000                MSG( +
935500000000'Fichier non ouvert. SQL est limitä aux fichiers physiques'           +
935600000000                ) +
935700000000                SEV(0) +
935800000000     /*   No replacement variables defined!                         */ +
935900000000                ALROPT(*NO) +
936000000000                CCSID(65535) +
936100000000                /*  -EOF-  */
936200000000
936300000000     /*-------------------------------------------------------------*/
936400000000     /*   Cmd-ADDMSGD für Message-ID :   USR9994                    */
936500000000     /* Erreur inattendue &1 dans la procädure C &2.                */
936600000000     /*-------------------------------------------------------------*/
936700000000
936800000000             RMVMSGD MSGID(USR9994) MSGF(&LIB/&OBJ)
936900000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
937000000000
937100000000             ADDMSGD +
937200000000                MSGID(USR9994) +
937300000000                MSGF(&LIB/&OBJ) +
937400000000                MSG( +
937500000000'Erreur inattendue &1 dans la procädure C &2.'                        +
937600000000                ) +
937700000000                SECLVL( +
937800000000'&N &N Description . . :   &3'                                        +
937900000000                ) +
938000000000                SEV(0) +
938100000000                FMT( +
938200000000                    (*DEC 5 0) +
938300000000                    (*CHAR 32) +
938400000000                    (*CHAR 256) +
938500000000                ) +
938600000000                ALROPT(*NO) +
938700000000                CCSID(65535) +
938800000000                /*  -EOF-  */
938900000000
939000000000     /*-------------------------------------------------------------*/
939100000000     /*   Cmd-ADDMSGD für Message-ID :   USR9995                    */
939200000000     /* Modifie le format d'enregistrement des fichiers de configur */
939300000000     /*-------------------------------------------------------------*/
939400000000
939500000000             RMVMSGD MSGID(USR9995) MSGF(&LIB/&OBJ)
939600000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
939700000000
939800000000             ADDMSGD +
939900000000                MSGID(USR9995) +
940000000000                MSGF(&LIB/&OBJ) +
940100000000                MSG( +
940200000000'Modifie le format d''enregistrement des fichiers de configuration ...-
940300000000'                                                                     +
940400000000                ) +
940500000000                SEV(0) +
940600000000     /*   No replacement variables defined!                         */ +
940700000000                ALROPT(*NO) +
940800000000                CCSID(65535) +
940900000000                /*  -EOF-  */
941000000000
941100000000     /*-------------------------------------------------------------*/
941200000000     /*   Cmd-ADDMSGD für Message-ID :   USR9996                    */
941300000000     /* Aucun fichier ouvert.                                       */
941400000000     /*-------------------------------------------------------------*/
941500000000
941600000000             RMVMSGD MSGID(USR9996) MSGF(&LIB/&OBJ)
941700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
941800000000
941900000000             ADDMSGD +
942000000000                MSGID(USR9996) +
942100000000                MSGF(&LIB/&OBJ) +
942200000000                MSG( +
942300000000'Aucun fichier ouvert.'                                               +
942400000000                ) +
942500000000                SEV(0) +
942600000000     /*   No replacement variables defined!                         */ +
942700000000                ALROPT(*NO) +
942800000000                CCSID(65535) +
942900000000                /*  -EOF-  */
943000000000
943100000000     /*-------------------------------------------------------------*/
943200000000     /*   Cmd-ADDMSGD für Message-ID :   USR9997                    */
943300000000     /* &2PEEK/400 est&1 un partagiciel &2Veuillez vous enregistrer */
943400000000     /*-------------------------------------------------------------*/
943500000000
943600000000             RMVMSGD MSGID(USR9997) MSGF(&LIB/&OBJ)
943700000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
943800000000
943900000000             ADDMSGD +
944000000000                MSGID(USR9997) +
944100000000                MSGF(&LIB/&OBJ) +
944200000000                MSG( +
944300000000'&2PEEK/400 est&1 un partagiciel &2Veuillez vous enregistrer.'        +
944400000000                ) +
944500000000                SEV(0) +
944600000000                FMT( +
944700000000                    (*CHAR 1) +
944800000000                    (*CHAR 1) +
944900000000                ) +
945000000000                ALROPT(*NO) +
945100000000                CCSID(65535) +
945200000000                /*  -EOF-  */
945300000000
945400000000     /*-------------------------------------------------------------*/
945500000000     /*   Cmd-ADDMSGD für Message-ID :   USR9998                    */
945600000000     /* Message inattendu nÄ &1 reÖu du programme &2.               */
945700000000     /*-------------------------------------------------------------*/
945800000000
945900000000             RMVMSGD MSGID(USR9998) MSGF(&LIB/&OBJ)
946000000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
946100000000
946200000000             ADDMSGD +
946300000000                MSGID(USR9998) +
946400000000                MSGF(&LIB/&OBJ) +
946500000000                MSG( +
946600000000'Message inattendu nÄ &1 reÖu du programme &2.'                       +
946700000000                ) +
946800000000                SEV(0) +
946900000000                FMT( +
947000000000                    (*CHAR 7) +
947100000000                    (*CHAR 10) +
947200000000                ) +
947300000000                ALROPT(*NO) +
947400000000                CCSID(65535) +
947500000000                /*  -EOF-  */
947600000000
947700000000     /*-------------------------------------------------------------*/
947800000000     /*   Cmd-ADDMSGD für Message-ID :   USR9999                    */
947900000000     /* &1                                                          */
948000000000     /*-------------------------------------------------------------*/
948100000000
948200000000             RMVMSGD MSGID(USR9999) MSGF(&LIB/&OBJ)
948300000000             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */
948400000000
948500000000             ADDMSGD +
948600000000                MSGID(USR9999) +
948700000000                MSGF(&LIB/&OBJ) +
948800000000                MSG( +
948900000000'&1'                                                                  +
949000000000                ) +
949100000000                SECLVL( +
949200000000'&2'                                                                  +
949300000000                ) +
949400000000                SEV(0) +
949500000000                FMT( +
949600000000                    (*CHAR 128) +
949700000000                    (*CHAR 128) +
949800000000                ) +
949900000000                ALROPT(*NO) +
950000000000                CCSID(65535) +
950100000000                /*  -EOF-  */
950200000000
950300000000             RCLRSC LVL(*)
950400000000
950500000000             ENDPGM
