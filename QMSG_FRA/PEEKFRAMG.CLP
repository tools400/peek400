     /*-----------------------------------------------------------------------*/
     /* Hinweis: Dieses CL muss in einem Job mit der Sprache der              */
     /*          Zielnachrichtendatei kompiliert und ausgeführt werden.       */
     /*-----------------------------------------------------------------------*/
     /* STRPREPRC Compile Options:                                            */
     /* >>PRE-COMPILER<<                                                      */
     /*   >>CRTCMD<<  CALL       PGM(QTEMP/&OB) PARM(&LI);                    */
     /*   >>CMD<<     CHGJOB  LANGID(FRA) CNTRYID(FR) CCSID(1147);            */
     /*   >>CMD<<     CRTCLPGM   PGM(QTEMP/&OB) +                             */
     /*                          SRCFILE(&SL/&SF) SRCMBR(&SM) +               */
     /*               TEXT('Peek/400 - Francais');                            */
     /*   >>EXECUTE<<                                                         */
     /*   >>CMD<<     DLTPGM PGM(QTEMP/&OB);                                  */
     /*   >>CMD<<     CHGJOB  LANGID(DEU) CNTRYID(DE) CCSID(273);             */
     /* >>END-PRE-COMPILER<<                                                  */
     /*-----------------------------------------------------------------------*/
             PGM        PARM(&I_LIB)

             DCL        VAR(&I_LIB     ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&I_OBJ     ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&LIB       ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OBJ       ) TYPE(*CHAR) LEN(10)  VALUE('PEEKFRA')
             DCL        VAR(&CCSID     ) TYPE(*DEC ) LEN(5 0) VALUE(1147)
             DCL        VAR(&LANGUAGE  ) TYPE(*CHAR) LEN(20)  VALUE('Francais')

             CHGVAR     VAR(&LIB       ) VALUE(&I_LIB)
             MONMSG     MSGID(MCH3601) EXEC(DO)
               RMVMSG     PGMQ(*SAME (*)) CLEAR(*ALL)
               SNDPGMMSG  MSGID(CPF9898) MSGF(*LIBL/QCPFMSG) +
                            MSGDTA('Usage: CALL PGM(PEEKFRAMG) PARM(libName)') +
                            TOPGMQ(*PRV (*PGMBDY)) MSGTYPE(*ESCAPE)
             ENDDO

             DLTMSGF    MSGF(&LIB/&OBJ)
             MONMSG     MSGID(CPF2105) /* Object not found */

             CRTMSGF MSGF(&LIB/&OBJ ) TEXT('Peek/400 - ' *CAT &LANGUAGE)

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BA                    */
     /* Touche F22 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BA) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BA) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F22 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BB                    */
     /* Touche F23 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BB) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BB) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F23 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BC                    */
     /* Touche F24 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BC) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BC) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F24 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BD                    */
     /* Touche 'SUPPR' invalide                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BD) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BD) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche ''SUPPR'' invalide'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B1                    */
     /* Touche F13 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B1) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B1) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F13 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B2                    */
     /* Touche F14 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B2) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B2) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F14 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B3                    */
     /* Touche F15 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B3) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B3) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F15 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B4                    */
     /* Touche F16 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B4) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B4) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F16 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B5                    */
     /* Touche F17 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B5) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B5) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F17 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B6                    */
     /* Touche F18 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B6) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B6) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F18 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B7                    */
     /* Touche F19 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B7) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B7) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F19 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B8                    */
     /* Touche F20 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B8) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B8) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F20 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B9                    */
     /* Touche F21 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B9) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B9) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F21 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F1                    */
     /* Touche 'ENTREE' non valide                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F1) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F1) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche ''ENTREE'' non valide'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F3                    */
     /* Touche 'AIDE' non valide                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F3) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F3) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche ''AIDE'' non valide'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F4                    */
     /* Touche 'PAGE PREC' non valide                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F4) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F4) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche ''PAGE PREC'' non valide'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F5                    */
     /* Touche 'PAGE SUIV' non valide                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F5) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F5) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche ''PAGE SUIV'' non valide'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F6                    */
     /* Touche 'IMPR' non valide                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F6) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F6) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche ''IMPR'' non valide'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F8                    */
     /* Touche 'RESET' non valide                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F8) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F8) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche ''RESET'' non valide'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003A                    */
     /* Touche F10 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003A) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003A) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F10 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003B                    */
     /* Touche F11 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003B) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003B) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F11 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003C                    */
     /* Touche F12 non valide                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003C) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003C) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F12 non valide'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003F                    */
     /* Touche 'CRAYON OPTIQUE' non valide                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003F) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003F) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche ''CRAYON OPTIQUE'' non valide'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0031                    */
     /* Touche F1 non valide                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F1 non valide'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0032                    */
     /* Touche F2 non valide                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F2 non valide'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0033                    */
     /* Touche F3 non valide                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F3 non valide'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0034                    */
     /* Touche F4 non valide                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F4 non valide'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0035                    */
     /* Touche F5 non valide                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F5 non valide'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0036                    */
     /* Touche F6 non valide                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F6 non valide'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0037                    */
     /* Touche F7 non valide                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F7 non valide'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0038                    */
     /* Touche F8 non valide                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F8 non valide'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0039                    */
     /* Touche F9 non valide                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche F9 non valide'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0100                    */
     /* Touche invalide                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche invalide'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0001                    */
     /* Entrée                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Entrée        '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0002                    */
     /* Fin                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fin           '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0003                    */
     /* Rafraîchir                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Rafraîchir    '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0004                    */
     /* Ajouter                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ajouter  '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0005                    */
     /* Nom/lib. champ                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nom/lib. champ'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0006                    */
     /* Sélec.col. +/-                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sélec.col. +/-'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0007                    */
     /* Haut de page                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Haut de page'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0008                    */
     /* Pos. Curseur                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pos. Curseur  '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0009                    */
     /* Recherche                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Recherche     '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0010                    */
     /* Début                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Début         '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0011                    */
     /* Fin                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fin           '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0012                    */
     /* Gauche                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Gauche        '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0013                    */
     /* Droite                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Droite        '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0014                    */
     /* Ligne commande                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ligne commande'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0015                    */
     /* 80/132 colonne                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0015) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0015) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'80/132 colonne'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0016                    */
     /* Autres touches                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Autres touches'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0017                    */
     /* Page avant                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Page avant    '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0018                    */
     /* Page arrière                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Page arrière  '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0019                    */
     /* Fixer ligne                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fixer ligne'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0020                    */
     /* Défixer ligne                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0020) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0020) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Défixer ligne'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0021                    */
     /* Modifier                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0021) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0021) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Modifier      '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0022                    */
     /* Dupliquer                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0022) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0022) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Dupliquer     '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0023                    */
     /* Supprimer                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0023) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0023) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Supprimer     '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0024                    */
     /* Afficher                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0024) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0024) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Afficher      '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0025                    */
     /* Paramétrages                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0025) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0025) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Paramétrages  '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0026                    */
     /* Abandonner                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0026) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0026) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Abandonner    '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0027                    */
     /* Enreg. & quitter                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0027) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0027) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enreg. & quitter'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0028                    */
     /* Fixer col.                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0028) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0028) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fixer col.'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0029                    */
     /* Défixer col.                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0029) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0029) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Défixer col.'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0030                    */
     /* Fixer col. +/-                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0030) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0030) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fixer col. +/-'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0031                    */
     /* Lig. en couleur                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lig. en couleur'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0032                    */
     /* Lig. monochrome                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lig. monochrome'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0033                    */
     /* Couleur/mono.                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Couleur/mono.'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0034                    */
     /* Tous                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tous          '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0035                    */
     /* Plus d'options                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Plus d''options'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0036                    */
     /* Copier vers                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Copier vers   '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0037                    */
     /* Sélect. champ                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sélect. champ'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0038                    */
     /* Libérer champ                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Libérer champ'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0039                    */
     /* Minuscule                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Minuscule '                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0040                    */
     /* Majuscule                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0040) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0040) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Majuscule '                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0041                    */
     /* Maj. / Min.                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0041) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0041) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Maj. / Min.'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0042                    */
     /* Page d'accueil                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0042) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0042) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Page d''accueil'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0043                    */
     /* Pas de page                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0043) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0043) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pas de page'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0044                    */
     /* Page gauche                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0044) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0044) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Page gauche'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0045                    */
     /* Page droite                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0045) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0045) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Page droite'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0046                    */
     /* Repéter                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0046) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0046) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Repéter'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0047                    */
     /* Reconstruire                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0047) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0047) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reconstruire'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0048                    */
     /* Défixer les lignes                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0048) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0048) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Défixer les lignes'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0049                    */
     /* Défixer colonnes                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0049) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0049) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Défixer colonnes'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0050                    */
     /* Maquette                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0050) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0050) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Maquette'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0051                    */
     /* Touches flott.                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0051) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0051) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touches flott.'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0052                    */
     /* Sélectionner                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0052) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0052) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sélectionner'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0053                    */
     /* Sélection suivante                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0053) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0053) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sélection suivante'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0054                    */
     /* Sélection préc.                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0054) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0054) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sélection préc.'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0055                    */
     /* Relations                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0055) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0055) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Relations'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0056                    */
     /* Guide                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0056) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0056) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Guide '                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0057                    */
     /* Ordre clé                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0057) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0057) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ordre clé'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0058                    */
     /* Ordre enreg.                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0058) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0058) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ordre enreg.'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0059                    */
     /* Tri Clef/N°enr.                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0059) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0059) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tri Clef/N°enr.'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0060                    */
     /* Editeur Hexa                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0060) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0060) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editeur Hexa'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0061                    */
     /* Infos                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0061) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0061) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Infos'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0062                    */
     /* Fixer champs                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0062) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0062) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fixer champs'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0063                    */
     /* Efface tout                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0063) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0063) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Efface tout'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0064                    */
     /* Affichage normal                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0064) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0064) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Affichage normal'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0065                    */
     /* Affichage hexa                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0065) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0065) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Affichage hexa'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0066                    */
     /* Hexa/car.                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0066) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0066) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Hexa/car.'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0067                    */
     /* Sélection SQL                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0067) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0067) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sélection SQL'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0068                    */
     /* Ins.champs clef                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0068) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0068) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ins.champs clef'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0069                    */
     /* Sauve environ.                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0069) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0069) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sauve environ.'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0070                    */
     /* Charge environ.                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0070) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0070) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Charge environ.'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0071                    */
     /* Supprime environ.                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0071) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0071) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Supprime environ.'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0072                    */
     /* Séquence de tri                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0072) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0072) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Séquence de tri'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0073                    */
     /* Oui                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0073) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0073) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Oui'                                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0074                    */
     /* Non                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0074) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0074) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non'                                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0075                    */
     /* OK                                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0075) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0075) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'OK'                                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0076                    */
     /* Prem. Pos.                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0076) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0076) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Prem. Pos.'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0077                    */
     /* Dern. Pos.                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0077) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0077) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Dern. Pos.'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0078                    */
     /* Environnement                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0078) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0078) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Environnement'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0079                    */
     /* Maquette seule                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0079) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0079) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Maquette seule'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0080                    */
     /* NULL accepté                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0080) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0080) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'NULL accepté'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0081                    */
     /* Chg mode entrée                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0081) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0081) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Chg mode entrée'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0082                    */
     /* Edite chaîne                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0082) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0082) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Edite chaîne'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0083                    */
     /* Verrouillage                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0083) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0083) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Verrouillage'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0084                    */
     /* Min./maj.                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0084) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0084) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Min./maj.'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0085                    */
     /* Imprimer                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0085) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0085) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Imprimer'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0086                    */
     /* Insérer                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0086) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0086) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Insérer'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0087                    */
     /* Supprimer                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0087) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0087) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Supprimer'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   MBX0001                    */
     /* Information                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(MBX0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(MBX0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Information'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   MBX0002                    */
     /* Questions                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(MBX0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(MBX0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Questions'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0001                    */
     /* Fichier                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fichier'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0002                    */
     /* Membre                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Membre'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0003                    */
     /* Type d'accès                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Type d''accès'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0004                    */
     /* Langue                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Langue'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0005                    */
     /* Droit de changer bibliothèque                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Droit de changer bibliothèque'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0006                    */
     /* Droit de changer de fichier                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Droit de changer de fichier'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0007                    */
     /* Droit de changer de membre                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Droit de changer de membre'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0008                    */
     /* Droit modifier enregistrement                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Droit modifier enregistrement'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0009                    */
     /* Droit de modifier SQL WHERE                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Droit de modifier SQL WHERE'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0010                    */
     /* Droit de modifier ORDER BY                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Droit de modifier ORDER BY'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0011                    */
     /* Environnement                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Environnement'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0012                    */
     /*   Membre                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Membre'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0013                    */
     /* Clause SQL WHERE                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Clause SQL WHERE'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0014                    */
     /* Clause SQL ORDER BY                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Clause SQL ORDER BY'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0015                    */
     /* Bibliothèque                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0015) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0015) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bibliothèque'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0016                    */
     /* Préférences utilisateur                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Préférences utilisateur'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0017                    */
     /* Profil utilisateur                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Profil utilisateur'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0018                    */
     /* Sauvegarder en quittant                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sauvegarder en quittant'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0019                    */
     /* Charger seulement la maquette                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Charger seulement la maquette'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0100                    */
     /* Editeur B.D.D Peek/400                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editeur B.D.D Peek/400'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0101                    */
     /* Afficher relations logiques                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Afficher relations logiques'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0001                    */
     /* Fich.:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fich.:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0002                    */
     /* Bibliothè.:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bibliothè.:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0003                    */
     /*   Membre :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Membre :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0004                    */
     /* Longueur....:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Longueur....:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0005                    */
     /* Nbre enreg..:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nbre enreg..:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0006                    */
     /* N° champ....:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'N° champ....:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0007                    */
     /* Nom du champ:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nom du champ:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0008                    */
     /*   Format :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Format :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0009                    */
     /* Taille fich.:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Taille fich.:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0010                    */
     /* N° enregist.:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'N° enregist.:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0011                    */
     /* Valeur clefs:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valeur clefs:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0012                    */
     /*  Options :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Options :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0013                    */
     /* Fich.:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fich.:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0014                    */
     /* Bib:                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bib:'                                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0015                    */
     /* Mbr:                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0015) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0015) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mbr:'                                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0016                    */
     /* Taille:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Taille:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0017                    */
     /* Enreg.:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enreg.:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0018                    */
     /* N°champ.:                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'N°champ.:'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0019                    */
     /* Nom champ:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nom champ:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0020                    */
     /* Format:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0020) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0020) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Format:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0021                    */
     /* Taille:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0021) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0021) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Taille:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0022                    */
     /* N° enreg.:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0022) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0022) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'N° enreg.:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0023                    */
     /* Valeur clefs:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0023) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0023) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valeur clefs:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0024                    */
     /* Options:                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0024) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0024) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Options:'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0025                    */
     /* (Pas d'enregistrement)                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0025) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0025) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(Pas d''enregistrement)'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0026                    */
     /* Tapez ENTREE pour supprimer.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0026) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0026) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tapez ENTREE pour supprimer.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0027                    */
     /* Détail enregistrement                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0027) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0027) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Détail enregistrement'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0028                    */
     /* Tapez ENTREE pour copier.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0028) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0028) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tapez ENTREE pour copier.'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0029                    */
     /* Enreg.:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0029) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0029) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enreg.:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0030                    */
     /* Journalisation                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0030) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0030) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Journalisation'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0031                    */
     /* Non journalisé                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non journalisé'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0032                    */
     /* (Pas d'enregistrement)                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(Pas d''enregistrement)'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0033                    */
     /*     - Recherche -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'    - Recherche -'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0034                    */
     /* Champ                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Champ'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0035                    */
     /* Op.                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Op.'                                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0036                    */
     /* Valeur (sans quotes)                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valeur (sans quotes)'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0037                    */
     /* pour recherche gén)                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'pour recherche gén)'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0038                    */
     /* Nb.lignes maxi:                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nb.lignes maxi:'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0039                    */
     /* Type recherche:                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Type recherche:'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0040                    */
     /* (Normal/Underline/Reverse/Pin)                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0040) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0040) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(Normal/Underline/Reverse/Pin)'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0041                    */
     /* Respect casse :                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0041) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0041) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Respect casse :'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0042                    */
     /* (1=Oui, 0=Non)                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0042) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0042) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(1=Oui, 0=Non)'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0043                    */
     /*    - Couleur -                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0043) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0043) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'   - Couleur -'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0044                    */
     /* -  Choix Couleur  -                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0044) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0044) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'-  Choix Couleur  -'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0045                    */
     /* Vert                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0045) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0045) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Vert     '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0046                    */
     /* Blanc                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0046) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0046) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Blanc    '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0047                    */
     /* Rouge                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0047) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0047) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Rouge    '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0048                    */
     /* Turquoise                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0048) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0048) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Turquoise'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0049                    */
     /* Jaune                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0049) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0049) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Jaune    '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0050                    */
     /* Rose                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0050) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0050) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Rose     '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0051                    */
     /* Bleu                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0051) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0051) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bleu     '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0052                    */
     /* - Copier vers fic.-                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0052) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0052) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Copier vers fic.-'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0053                    */
     /* Fichier..........:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0053) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0053) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fichier..........:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0054                    */
     /* Bibliothèque.....:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0054) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0054) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bibliothèque.....:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0055                    */
     /* Membre ..........:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0055) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0055) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Membre ..........:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0056                    */
     /* Remplacer enreg..:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0056) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0056) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Remplacer enreg..:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0057                    */
     /* Créer Fichier....:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0057) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0057) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Créer Fichier....:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0058                    */
     /* - Données Licence -                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0058) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0058) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Données Licence -'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0059                    */
     /* N° licence:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0059) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0059) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'N° licence:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0060                    */
     /* F9=Testez!                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0060) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0060) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'F9=Testez!'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0061                    */
     /* Les données de la licence ont été sauvegardées              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0061) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0061) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Les données de la licence ont été sauvegardées'                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0062                    */
     /* Désolé, fin de la période ...........                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0062) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0062) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Désolé, fin de la période ...........'                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0063                    */
     /* ENTREE pour modif.                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0063) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0063) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'ENTREE pour modif.'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0064                    */
     /* ENTREE pour copie                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0064) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0064) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'ENTREE pour copie'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0065                    */
     /* ENTREE pour ajout                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0065) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0065) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'ENTREE pour ajout'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0066                    */
     /* A suivre...                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0066) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0066) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'A suivre...'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0067                    */
     /*         Fin                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0067) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0067) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'        Fin'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0068                    */
     /* Journalisation                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0068) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0068) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Journalisation'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0069                    */
     /* Mode écran 80/132 car.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0069) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0069) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mode écran 80/132 car.'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0070                    */
     /* Moteur de recherche puissant                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0070) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0070) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Moteur de recherche puissant'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0071                    */
     /* Touches de fonction personnalisables                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0071) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0071) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touches de fonction personnalisables'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0072                    */
     /* Choix de la langue                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0072) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0072) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Choix de la langue'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0073                    */
     /*   L'ultime                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0073) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0073) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  L''ultime'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0074                    */
     /* navigateur de BD                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0074) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0074) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'navigateur de BD'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0075                    */
     /*       * Points forts *                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0075) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0075) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'      * Points forts *      '                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0076                    */
     /* Caractère non imprimable                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0076) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0076) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Caractère non imprimable'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0077                    */
     /* -Maquette-                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0077) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0077) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'-Maquette-'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0078                    */
     /* Rech.:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0078) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0078) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Rech.:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0079                    */
     /*  O   Enr.   Champ       Description                     Typ */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0079) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0079) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O   Enr.   Champ       Description                     Type      Pos-
.déb '                                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0080                    */
     /* Visible ..:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0080) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0080) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Visible ..:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0081                    */
     /* Couleur.:                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0081) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0081) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Couleur.:'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0082                    */
     /* Sélection :                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0082) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0082) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sélection :'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0083                    */
     /* Largeur max                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0083) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0083) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Largeur max'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0084                    */
     /* Code Edi:                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0084) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0084) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Code Edi:'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0085                    */
     /* - Choix champ -                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0085) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0085) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Choix champ -'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0086                    */
     /*  O   Champ       Description                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0086) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0086) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O   Champ       Description                    '                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0087                    */
     /*  O  Fichier                Description                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0087) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0087) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O  Fichier                Description                               -
   '                                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0088                    */
     /* -Afficher relations fichiers-                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0088) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0088) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'-Afficher relations fichiers-'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0089                    */
     /* Dépendances:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0089) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0089) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Dépendances:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0090                    */
     /* Editeur Hex                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0090) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0090) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editeur Hex'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0091                    */
     /* Champ .......:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0091) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0091) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Champ .......:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0092                    */
     /* Longueur ....:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0092) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0092) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Longueur ....:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0093                    */
     /* Contenu ...:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0093) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0093) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Contenu ...:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0094                    */
     /* Hexa ......:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0094) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0094) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Hexa ......:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0095                    */
     /* Position déb.:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0095) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0095) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Position déb.:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0096                    */
     /* Tail. Tampon                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0096) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0096) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tail. Tampon'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0097                    */
     /*  A   Membre      Description                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0097) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0097) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Membre      Description                                        '+
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0098                    */
     /*   - Choix Membre -                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0098) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0098) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  - Choix Membre -   '                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0099                    */
     /*  N° membre :                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0099) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0099) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' N° membre :'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0100                    */
     /* Mbr   :                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mbr   :'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0101                    */
     /* - Peek/400 -                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Peek/400 -'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0102                    */
     /* Date  . . .                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0102) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0102) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Date  . . .'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0103                    */
     /* Version . .                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0103) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0103) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Version . .'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0104                    */
     /* E-mail  . .                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0104) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0104) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'E-mail  . .'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0105                    */
     /* Homepage  .                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0105) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0105) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Homepage  .'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0106                    */
     /* Fixer champs                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0106) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0106) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fixer champs'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0107                    */
     /*  N°Enr. Champ       Description                      Champ  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0107) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0107) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' N°Enr. Champ       Description                      Champ clé'      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0108                    */
     /* - Sélection SQL -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0108) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0108) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Sélection SQL -'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0109                    */
     /* WHERE  ....:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0109) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0109) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'WHERE  ....:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0110                    */
     /* ORDER BY  .:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0110) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0110) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'ORDER BY  .:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0111                    */
     /* -Créer Programme Màj-                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0111) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0111) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'-Créer Programme Màj-'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0112                    */
     /* Minuscules admises.... ?                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0112) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0112) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Minuscules admises.... ?'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0113                    */
     /* Minuscules par défaut. ?                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0113) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0113) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Minuscules par défaut. ?'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0114                    */
     /* Sauvegarder par défaut ?                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0114) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0114) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sauvegarder par défaut ?'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0115                    */
     /* Sélection SQL                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0115) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0115) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sélection SQL'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0116                    */
     /*    Choix Environment                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0116) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0116) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'   Choix Environment    '                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0117                    */
     /* Fich.:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0117) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0117) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fich.:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0118                    */
     /* Biblioth..:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0118) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0118) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Biblioth..:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0119                    */
     /*  A   Description  environnement                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0119) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0119) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Description  environnement'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0120                    */
     /* Supprimer environnement                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0120) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0120) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Supprimer environnement'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0121                    */
     /* Fichier . . :                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0121) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0121) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fichier . . :'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0122                    */
     /* Biblioth. :                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0122) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0122) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Biblioth. :'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0123                    */
     /* Membre  . . :                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0123) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0123) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Membre  . . :'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0124                    */
     /* Description :                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0124) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0124) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Description :'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0125                    */
     /* Long.variable:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0125) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0125) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Long.variable:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0126                    */
     /* - Sélect. Format Enreg. -                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0126) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0126) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Sélect. Format Enreg. -'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0127                    */
     /* Valeur NULL                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0127) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0127) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valeur NULL'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0128                    */
     /* Editeur                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0128) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0128) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editeur'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0129                    */
     /* ***Enreg.verouillé***                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0129) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0129) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'***Enreg.verouillé***'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0130                    */
     /* Enreg. déverouillé                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0130) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0130) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enreg. déverouillé'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0131                    */
     /* Verrouiller enregistr. ?                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0131) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0131) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Verrouiller enregistr. ?'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0132                    */
     /* Fich.:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0132) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0132) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fich.:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0133                    */
     /*   Biblioth:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0133) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0133) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Biblioth:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0134                    */
     /* Enr:                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0134) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0134) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enr:'                                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0135                    */
     /*  Page:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0135) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0135) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Page:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0136                    */
     /* Nom champ                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0136) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0136) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nom champ'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0137                    */
     /* Description champ                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0137) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0137) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Description champ'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0138                    */
     /* Valeur champ                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0138) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0138) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valeur champ'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0139                    */
     /* Texte                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0139) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0139) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Texte'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0140                    */
     /*  O   Opt  Description                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0140) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0140) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O   Opt  Description                 '                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0141                    */
     /* ----- Options utilisateur  -----                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0141) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0141) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'----- Options utilisateur  ----- '                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0142                    */
     /*  O   Fichier     Bibliothèque Description                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0142) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0142) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O   Fichier     Bibliothèque Description'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0143                    */
     /*  -Fichier sélec.-                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' -Fichier sélec.-'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0144                    */
     /* Initialise champs NULL ?                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0144) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0144) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Initialise champs NULL ?'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0145                    */
     /* Conserve pos. curseur. ?                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0145) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0145) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Conserve pos. curseur. ?'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0146                    */
     /* Insérer                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0146) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0146) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Insérer'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0147                    */
     /* Supprimer                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0147) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0147) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Supprimer'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0148                    */
     /* de:                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0148) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0148) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'de:'                                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0149                    */
     /* Longueur:                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0149) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0149) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Longueur:'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0150                    */
     /* à:                                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0150) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0150) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'à:'                                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0151                    */
     /* Pos.du curseur                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0151) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0151) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pos. curseur :'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
     /* Enregistrement du format &3 du fichier &2/&1 inaccessible   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enregistrement du format &3 du fichier &2/&1 inaccessible'           +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0002                    */
     /* Extraction impossible de la liste des formats du fichier &2 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Extraction impossible de la liste des formats du fichier &2/&1.'     +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0003                    */
     /* Journalisation active sur ce fichier                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Journalisation active sur ce fichier'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0004                    */
     /* Pas de journalisation sur ce fichier                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pas de journalisation sur ce fichier'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0005                    */
     /* Fichier &1 non ouvert. Voir journal.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fichier &1 non ouvert. Voir journal.'                                +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0006                    */
     /* Pas d'information clef sur fichier &2/&1.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pas d''information clef sur fichier &2/&1.'                          +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0007                    */
     /* Ouverture impossible du fichier &2/&1 en mode MàJ. Modifica */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ouverture impossible du fichier &2/&1 en mode MàJ. Modifications impo-
ossibles.'                                                            +
                ) +
                SECLVL( +
'&N &N Causes possibles: &N &B 1. Le debugger a été démarré en UPDPROD-
(*NO). &B 2. Le fichier est un logique joint &B 3. Le fichier a des rè-
gles d''intégrité mais n''est pas journalisé. &B 4. Le fichier possède-
 des déclencheurs introuvables. &B 5. Le fichier est un logique multi--
membre.'                                                              +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0008                    */
     /* Fichier &2/&1 introuvable                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fichier &2/&1 introuvable'                                           +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0009                    */
     /* Extraction impossible de la description du fichier &2/&1.   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Extraction impossible de la description du fichier &2/&1.'           +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0010                    */
     /* Bibliothèque &1 inexistante                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bibliothèque &1 inexistante'                                         +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0011                    */
     /* Fichier non ouvert. Voir message de second niveau ou la log */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fichier non ouvert. Voir message de second niveau ou la log pour plus-
 d''informations.'                                                    +
                ) +
                SECLVL( +
'&N &N Erreur . .  . . :   &1'                                        +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 256) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0012                    */
     /* Erreur E/S &2: &1                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Erreur E/S &2: &1'                                                   +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 256) +
                    (*DEC 5 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0013                    */
     /* Exécution de la requête.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Exécution de la requête.'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0014                    */
     /* Calcule nombre d'enregistrements selectionnés.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Calcule nombre d''enregistrements selectionnés.'                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0143                    */
     /* - Choix Fichier -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Choix Fichier -'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR1000                    */
     /* Accès non autorisé pour le fichier &2/&1, membre &3.        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR1000) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR1000) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Accès non autorisé pour le fichier &2/&1, membre &3.'                +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8100                    */
     /* Abandon par utilisateur avec &1                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Abandon par utilisateur avec &1'                                     +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8101                    */
     /* Veuillez patienter un moment  ...                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Veuillez patienter un moment  ...'                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8102                    */
     /* Pointez sur un enregistement et réessayez                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8102) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8102) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pointez sur un enregistement et réessayez'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8103                    */
     /* Impossible de fermer le fichier.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8103) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8103) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impossible de fermer le fichier.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8104                    */
     /* Extraction de la description du fichier &2/&1.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8104) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8104) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Extraction de la description du fichier &2/&1.'                      +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8105                    */
     /* Extraction de la liste des formats du fichier &2/&1.        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8105) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8105) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Extraction de la liste des formats du fichier &2/&1.'                +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8106                    */
     /* Extraction des attributs réseau.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8106) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8106) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Extraction des attributs réseau.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8107                    */
     /* Extraction des attributs de l'objet &2/&1.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8107) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8107) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Extraction des attributs de l''objet &2/&1.'                         +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8108                    */
     /* Champ '&1' non trouvé dans fichier &3/&2.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8108) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8108) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Champ ''&1'' non trouvé dans fichier &3/&2.'                         +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8109                    */
     /* Extraction de la description du membre &3 du fichier &2/&1. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8109) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8109) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Extraction de la description du membre &3 du fichier &2/&1.'         +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8110                    */
     /* Option '&1' non valide                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8110) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8110) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Option ''&1'' non valide'                                            +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8111                    */
     /* Oui à tout                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8111) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8111) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Oui à tout'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8112                    */
     /* Commande acceptée                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8112) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8112) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Commande acceptée'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8113                    */
     /* Commande interne &1 invalide                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8113) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8113) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Commande interne &1 invalide'                                        +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8114                    */
     /* Création du programme RPG ..                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8114) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8114) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Création du programme RPG ..'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8115                    */
     /* Début des enregistrements                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8115) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8115) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Début des enregistrements'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8116                    */
     /* Dernière colonne                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8116) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8116) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Dernière colonne'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8117                    */
     /* Pointez un champ et réessayez                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8117) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8117) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pointez un champ et réessayez'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8118                    */
     /* Tableau plein                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8118) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8118) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tableau plein'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8119                    */
     /* Enregistrement déjà fixé                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8119) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8119) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enregistrement déjà fixé'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8120                    */
     /* Enregistrement non trouvé                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8120) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8120) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enregistrement non trouvé'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8121                    */
     /* Enregistrement non fixé                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8121) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8121) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enregistrement non fixé'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8122                    */
     /* Touche incorrecte                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8122) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8122) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Touche incorrecte'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8123                    */
     /* Les champs supérieurs à 1024 car. ne peuvent être &1modifié */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8123) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8123) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Les champs supérieurs à 1024 car. ne peuvent être &1modifiés&2.'     +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 1) +
                    (*CHAR 1) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8124                    */
     /* Opérande '&1' invalide                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8124) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8124) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Opérande ''&1'' invalide'                                            +
                ) +
                SECLVL( +
'&N &B Opérandes valides: &N &P EQ   - égal à &P NE   - différent de &-
P LT   - plus petit que &P GT   - plus grand que &P LE   - plus petit -
ou égal à &P GE   - plus grand ou égal à &P LIKE - comme'             +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8125                    */
     /* Valeur incorrecte pour le nombre d'enregistrements à recher */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8125) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8125) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valeur incorrecte pour le nombre d''enregistrements à rechercher'    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8126                    */
     /* Type de recherche '&1' non valide                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8126) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8126) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Type de recherche ''&1'' non valide'                                 +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8127                    */
     /* Recherche en cours                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8127) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8127) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Recherche en cours'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8128                    */
     /* Recherche en cours. &1 de &2 enregistrements recherchés     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8128) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8128) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Recherche en cours. &1 de &2 enregistrements recherchés'             +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 10 0) +
                    (*DEC 10 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8129                    */
     /* Champ '&1' de type '&2' non valide                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8129) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8129) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Champ ''&1'' de type ''&2'' non valide'                              +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8130                    */
     /* Enregistrement trouvé. 'F16'=continuer/'ENTREE'=Fin.        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8130) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8130) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enregistrement trouvé. ''F16''=continuer/''ENTREE''=Fin.'            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8131                    */
     /* Fin de fichier - aucun résultat. 'F16'=continuer / 'ENTREE' */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8131) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8131) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fin de fichier - aucun résultat. ''F16''=continuer / ''ENTREE''=Fin.'+
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8132                    */
     /* Nbre maximum de lignes atteint 'F16'=Continuer 'ENTREE'=Aba */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8132) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8132) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nbre maximum de lignes atteint ''F16''=Continuer ''ENTREE''=Abandon' +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8133                    */
     /* 1=Respect casse; 0=non respect casse                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8133) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8133) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=Respect casse; 0=non respect casse'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8134                    */
     /* La combinaison de l'opérande &1 avec le champ &2 est invali */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8134) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8134) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La combinaison de l''opérande &1 avec le champ &2 est invalide.'     +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8135                    */
     /* Opérande &1 invalide avec champ de type &2.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8135) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8135) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Opérande &1 invalide avec champ de type &2.'                         +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8136                    */
     /* Champ '&1' introuvable                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8136) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8136) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Champ ''&1'' introuvable'                                            +
                ) +
                SECLVL( +
'&N &B Valeurs possibles: &N &P *RECORD - Recherchez dans tout l''enre-
gistrement'                                                           +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8137                    */
     /* Extraction information clef de &2/&1.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8137) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8137) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Extraction information clef de &2/&1.'                               +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8138                    */
     /* Champ &1 contient des données décimales invalides           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8138) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8138) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Champ &1 contient des données décimales invalides'                   +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8139                    */
     /* Impossible de positionner le sous-fichier                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8139) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8139) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impossible de positionner le sous-fichier'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8140                    */
     /* Veuillez saisir un argument de recherche                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8140) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8140) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Veuillez saisir un argument de recherche'                            +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8141                    */
     /* Utiliser '&1' pour les valeurs positives et '&2' pour les n */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8141) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8141) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Utiliser ''&1'' pour les valeurs positives et ''&2'' pour les négativ-
es.'                                                                  +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8142                    */
     /* Position &1 est réservée au signe des valeurs numériques.   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8142) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8142) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Position &1 est réservée au signe des valeurs numériques.'           +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 10 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8143                    */
     /* Pas de programme associé à la touche &1.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pas de programme associé à la touche &1.'                            +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8144                    */
     /* Exécution récursive impossible pour commande &1.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8144) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8144) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Exécution récursive impossible pour commande &1.'                    +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8145                    */
     /* Impossible d'exécuter une commande - sous-fichier vide.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8145) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8145) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impossible d''exécuter une commande - sous-fichier vide.'            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8146                    */
     /* Positionnez le curseur sur un champ puis Entrée.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8146) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8146) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Positionnez le curseur sur un champ puis Entrée.'                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8147                    */
     /* Le champ &1 n'a pas été pointé                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8147) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8147) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Le champ &1 n''a pas été pointé'                                     +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8148                    */
     /* Plus de place pour le champ '&1'.                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8148) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8148) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Plus de place pour le champ ''&1''.'                                 +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8149                    */
     /* Mode couleur déjà activé pour les lignes.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8149) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8149) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mode couleur déjà activé pour les lignes.'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8150                    */
     /* Mode monochrome déjà activé pour les lignes.                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8150) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8150) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mode monochrome déjà activé pour les lignes.'                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8151                    */
     /* Nom invalide pour fichier cible '&1'.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8151) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8151) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nom invalide pour fichier cible ''&1''.'                             +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8152                    */
     /* Nom invalide pour bibliothèque cible '&1'.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8152) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8152) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nom invalide pour bibliothèque cible ''&1''.'                        +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8153                    */
     /* Nom invalide pour membre cible '&1'.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8153) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8153) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nom invalide pour membre cible ''&1''.'                              +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8154                    */
     /* Paramètre invalide '&1' pour ajout/remplacement.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8154) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8154) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Paramètre invalide ''&1'' pour ajout/remplacement.'                  +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8155                    */
     /* Paramètre invalide '&1' pour création de fichier.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8155) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8155) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Paramètre invalide ''&1'' pour création de fichier.'                 +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8156                    */
     /* Execution en échec                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8156) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8156) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Execution en échec'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8157                    */
     /* Extraction des valeurs système                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8157) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8157) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Extraction des valeurs système'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8158                    */
     /* Licence invalide N°. '&1'.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8158) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8158) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Licence invalide N°. ''&1''.'                                        +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 20) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8159                    */
     /* Impossible de sauvegarder les données de licence.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8159) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8159) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impossible de sauvegarder les données de licence.'                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8160                    */
     /* Fichier des définitions inexistant pour la langue &1.       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8160) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8160) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fichier des définitions inexistant pour la langue &1.'               +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8161                    */
     /* Ecran d'accueil activé                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8161) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8161) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ecran d''accueil activé'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8162                    */
     /* Ecran d'accueil désactivé                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8162) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8162) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ecran d''accueil désactivé'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8163                    */
     /* La chaîne contient des caractères <  x''40'' ou = x''FF''.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8163) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8163) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La chaîne contient des caractères <  x''''40'''' ou = x''''FF''''. Re-
mplacés par: &1'''                                                    +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 1) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8164                    */
     /* Les champs contenant des caractères non éditables sont igno */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8164) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8164) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Les champs contenant des caractères non éditables sont ignorés'      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8165                    */
     /* Veuillez choisir une option avant de faire 'répéter'        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8165) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8165) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Veuillez choisir une option avant de faire ''répéter'''              +
                ) +
                SECLVL( +
'Cause . . . . . . : F13 (Répéter) a été actionnée, mais aucune foncti-
on à répéter n''a été sélectionnée sur cette page. &N Reprise . . . . -
. : Indiquer une option dans la colonne des options de cette page, pui-
s actionner de nouveau ''répéter''.'                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8166                    */
     /* Impossible d'éxécuter l'option sans fichier ouvert          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8166) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8166) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impossible d''éxécuter l''option sans fichier ouvert'                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8167                    */
     /* Le n° de séquence doit être unique.                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8167) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8167) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Le n° de séquence doit être unique.'                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8168                    */
     /* Valeur &1 interdite pour l'attribut "Visible/invisible".    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8168) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8168) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valeur &1 interdite pour l''attribut "Visible/invisible".'           +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8169                    */
     /* Valeur &1 interdite pour l'attribut "Repérer champ".        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8169) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8169) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valeur &1 interdite pour l''attribut "Repérer champ".'               +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8170                    */
     /* Valeur &1 interdite pour l'attribut "Taille le maximum".    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8170) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8170) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valeur &1 interdite pour l''attribut "Taille le maximum".'           +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 10 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8171                    */
     /* Valeur invalide '&1' pour champ date, heure ou horodatage.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8171) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8171) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valeur invalide ''&1'' pour champ date, heure ou horodatage.'        +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 26) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8172                    */
     /* En traitement: &1                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8172) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8172) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'En traitement: &1'                                                   +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 50) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8173                    */
     /* Appels récursifs non supportés par Peek/400.                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8173) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8173) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Appels récursifs non supportés par Peek/400.'                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8174                    */
     /* Caractère (&1) interdit dans une chaîne hexa                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8174) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8174) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Caractère (&1) interdit dans une chaîne hexa'                        +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 1) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8175                    */
     /* Il est interdit de saisir un nombre impair de caractères    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8175) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8175) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il est interdit de saisir un nombre impair de caractères'            +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 1) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8176                    */
     /* Attention : Chaîne trop longue.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8176) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8176) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Attention : Chaîne trop longue.'                                     +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 1) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8177                    */
     /* La position de départ dépasse la taille du champ.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8177) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8177) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La position de départ dépasse la taille du champ.'                   +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 1) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8178                    */
     /* Position de départ inférieure ou égale à 0.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8178) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8178) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Position de départ inférieure ou égale à 0.'                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8179                    */
     /* Pas de guide disponible                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8179) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8179) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pas de guide disponible'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8180                    */
     /* Membre &1 introuvable.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8180) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8180) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Membre &1 introuvable.'                                              +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8181                    */
     /* Sauvegarde de l'environment impossible. Il manque le nom du */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8181) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8181) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sauvegarde de l''environment impossible. Il manque le nom du fichier.-
'                                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8182                    */
     /* &1 n'est pas un nom valide pour un objet AS/400.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8182) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8182) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'&1 n''est pas un nom valide pour un objet AS/400.'                   +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8183                    */
     /* Informations manquantes.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8183) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8183) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Informations manquantes.'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8184                    */
     /* Cette fonction est inactive. Veuillez contacter votre admin */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8184) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8184) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cette fonction est inactive. Veuillez contacter votre administrateur.-
'                                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8185                    */
     /* Aucun environnement ouvert car aucun spécifié.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8185) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8185) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Aucun environnement ouvert car aucun spécifié.'                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8186                    */
     /* Attention : chaîne trop courte.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8186) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8186) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Attention : chaîne trop courte.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8187                    */
     /* La longueur du champ dépasse la taille du tampon d'E/S      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8187) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8187) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La longueur du champ dépasse la taille du tampon d''E/S'             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8188                    */
     /* Création fichier écran. Etape: &1, Champ: &2                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8188) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8188) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Création fichier écran. Etape: &1, Champ: &2'                        +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 5 0) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8189                    */
     /* Création programme RPG. Etape: &1, Champ: &2                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8189) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8189) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Création programme RPG. Etape: &1, Champ: &2'                        +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 5 0) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8190                    */
     /* Réponse &1 à la requête.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8190) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8190) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Réponse &1 à la requête.'                                            +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8191                    */
     /* Le champ &1 n'accepte pas la valeur NULL.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8191) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8191) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Le champ &1 n''accepte pas la valeur NULL.'                          +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8192                    */
     /* Le champ &1 contient des données flottantes incorrectes     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8192) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8192) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Le champ &1 contient des données flottantes incorrectes'             +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8193                    */
     /* Le champ '&1' contient des caractères ne pouvant être trait */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8193) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8193) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Le champ ''&1'' contient des caractères ne pouvant être traités dans -
l''éditeur'                                                           +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8194                    */
     /* Fichier '&1' introuvable                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8194) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8194) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fichier ''&1'' introuvable'                                          +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8195                    */
     /* Requête illégale car ce champ est protégé                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8195) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8195) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Requête illégale car ce champ est protégé'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8196                    */
     /* Le champ &1 ne peut pas être affiché ni modifié.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8196) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8196) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Le champ &1 ne peut pas être affiché ni modifié.'                    +
                ) +
                SECLVL( +
'&N &N Causes possibles: &N &B 1. Type de données inconnu. &B 2. Champ-
 graphique sans CCSID. &B 3. Champ packed ou zoned de plus de 30 chiff-
res. &B 4. Champ de longueur variable de type inconnu.'               +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8200                    */
     /* Suppression enregistrement &1 impossible                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8200) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8200) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Suppression enregistrement &1 impossible'                            +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 10 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8201                    */
     /* Enregistrement &1 supprimé                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8201) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8201) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enregistrement &1 supprimé'                                          +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 10 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8202                    */
     /* Copie enregistrement &1 impossible                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8202) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8202) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Copie enregistrement &1 impossible'                                  +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 10 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8203                    */
     /* Enregistrement &1 copié                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8203) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8203) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enregistrement &1 copié'                                             +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 10 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8204                    */
     /* Enreg. de sous fichier invalide                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8204) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8204) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enreg. de sous fichier invalide'                                     +
                ) +
                SECLVL( +
'&N &N Pointez sur l''enregistrement désiré et répétez votre requête.'+
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8205                    */
     /* Attention: Impossible de fixer plus de &1 colonnes!         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8205) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8205) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Attention: Impossible de fixer plus de &1 colonnes!'                 +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 5 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8206                    */
     /* Enregistrement non affichable. La taille dépasse le maximum */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8206) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8206) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Enregistrement non affichable. La taille dépasse le maximum de &1 oct-
ets.'                                                                 +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 5 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8207                    */
     /* Le fichier ne peut être ouvert, la longueur de l'enregistre */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8207) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8207) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Le fichier ne peut être ouvert, la longueur de l''enregistrement dépa-
ssant &1 octets.'                                                     +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 5 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8208                    */
     /* Vous n'êtes pas autorisé à modifier des fichiers en lecture */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8208) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8208) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Vous n''êtes pas autorisé à modifier des fichiers en lecture seule.' +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8209                    */
     /* Veuillez entrer un argument de recherche.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8209) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8209) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Veuillez entrer un argument de recherche.'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8210                    */
     /* Erreur SQL &1. &2                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8210) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8210) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Erreur SQL &1. &2'                                                   +
                ) +
                SECLVL( +
'''&N &N Cause  . . . . :   &2 &N &B Vous trouverez plus d''informatio-
n sur ce code erreur dans le manuel de programmation SQL ou dans le fi-
chier de messages QSYS/QSQLMSG.'''                                    +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 7) +
                    (*CHAR 512) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8211                    */
     /* Veuillez placer le curseur dans un champ et relancer votre  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8211) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8211) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Veuillez placer le curseur dans un champ et relancer votre requête.' +
                ) +
                SECLVL( +
'Cause  . . . . :   Le curseur se trouve hors d''un champ ou le champ -
n''est pas valide pour la requête.'                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8212                    */
     /* Une sélection SQL ne peut s'appliquer qu'aux fichiers physi */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8212) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8212) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Une sélection SQL ne peut s''appliquer qu''aux fichiers physiques. Ou-
vrir le fichier physique ?'''                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8213                    */
     /* 1=Sauvegarder; 0=Ne pas sauvegarder                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8213) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8213) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=Sauvegarder; 0=Ne pas sauvegarder'                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8214                    */
     /* 1=Admettre minuscules 0=Majuscules seulement                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8214) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8214) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=Admettre minuscules 0=Majuscules seulement'                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8215                    */
     /* Minuscule interdite                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8215) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8215) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Minuscule interdite'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8216                    */
     /* Ces valeurs sont incompatibles.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8216) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8216) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ces valeurs sont incompatibles.'                                     +
                ) +
                SECLVL( +
'Si vous voulez interdire à l''utilisateur de saisir des minuscules, v-
ous ne pouvez prendre cette valeur comme défaut.'''                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8217                    */
     /* Trier sur le n° d'enregistement relatif est impossible.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8217) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8217) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Trier sur le n° d''enregistement relatif est impossible.'            +
                ) +
                SECLVL( +
'Il est impossible d''ouvrir ce fichier trié sur le n° relatif car il -
est basé sur plus d''un membre.'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8218                    */
     /* L'enregistement ne peut être fixé. La vue se base sur de mu */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8218) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8218) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'L''enregistement ne peut être fixé. La vue se base sur de multiples m-
embres physiques.'                                                    +
                ) +
                SECLVL( +
'&N &N Cause . . . . . :  L''enregistrement ne peut être fixé. Le n° d-
''enregistrement n''est pas unique et il est impossible de déterminer -
le membre physique qui le contient.'                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8219                    */
     /* Valeur '&1' incorrecte pour un choix Oui/Non                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8219) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8219) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valeur ''&1'' incorrecte pour un choix Oui/Non'                      +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 1) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8220                    */
     /* Edition interdite. Le champ &1 contient NULL.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8220) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8220) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Edition interdite. Le champ &1 contient NULL.'                       +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8221                    */
     /* L'éditeur ne supporte pas le type de données du champ &1.   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8221) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8221) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'L''éditeur ne supporte pas le type de données du champ &1.'          +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8222                    */
     /* Le champ &1 dépasse la taille maximum allouée à l'éditeur   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8222) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8222) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Le champ &1 dépasse la taille maximum allouée à l''éditeur'          +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8223                    */
     /* Saisie basculée en mode minuscule                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8223) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8223) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Saisie basculée en mode minuscule'                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8224                    */
     /* Saisie basculée en mode majuscule                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8224) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8224) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Saisie basculée en mode majuscule'                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8225                    */
     /* L'enregistrement a été modifié par un autre utilisateur. M  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8225) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8225) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'L''enregistrement a été modifié par un autre utilisateur.&N&NModifier-
 tout de même ?'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8226                    */
     /* Impression effectuée                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8226) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8226) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impression effectuée'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8227                    */
     /* Echec de conversion '&1' en numérique                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8227) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8227) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Echec de conversion ''&1'' en numérique'                             +
                ) +
                SECLVL( +
'&N &N Information . . :   Erreur lors de laconversion ''&1'' en numér-
ique. La chaîne n''a pas pu être convertie en numérique &2(&3,&4).'   +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 256) +
                    (*CHAR 1) +
                    (*DEC 5 0) +
                    (*DEC 5 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8228                    */
     /* Type de donnée incorrect '&1'.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8228) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8228) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Type de donnée incorrect ''&1''.'                                    +
                ) +
                SECLVL( +
'&N &N Information . . :   Le type de donnée spécifié  ''&1'' est inco-
rrect.. Veuillez spécifier un type de donnée RPG valide et relancer vo-
tre requête.'                                                         +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 256) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8229                    */
     /* Taille du champ invalide: '&1'.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8229) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8229) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Taille du champ invalide: ''&1''.'                                   +
                ) +
                SECLVL( +
'&N &N Information . . :   La taille du champ ''&1'' est incorrecte. V-
euillez corriger cette valeur et relancer votre requête'              +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 256) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8230                    */
     /* Nombre incorrect de positions décimales: '&1'.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8230) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8230) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nombre incorrect de positions décimales: ''&1''.'                    +
                ) +
                SECLVL( +
'&N &N Information . . :   Le nombre de décimales indiqué ''&1'' est i-
ncorrect. Veuillez corriger le nombre de décimales et relancer votre r-
equête. Notez que les décimales ne sont pas requises pour tous les typ-
es de données, par exemple ''A'' pour les chaînes de caractères.'     +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 256) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8231                    */
     /* Etat de verrouillage de l'enregistrement non modifiable dur */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8231) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8231) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Etat de verrouillage de l''enregistrement non modifiable durant la co-
pie ou l''ajout.'''                                                   +
                ) +
                SECLVL( +
'&N &N Information . . :   le verrouillage de l''enregistrement ne peu-
t être changé. Seule la modification de l''enregistrement peut le chan-
ger.'''                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8232                    */
     /* L'enregistrement a été modifié par un autre utilisateur.    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8232) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8232) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'L''enregistrement a été modifié par un autre utilisateur.&N&NVerrouil-
ler l''enregistrement tout de même ?'                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8233                    */
     /* Erreur: Maquette inutilisable. Niveaux de format différents */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8233) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8233) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Erreur: Maquette inutilisable. Niveaux de format différents'         +
                ) +
                SECLVL( +
'&N &N Solution  . . . :   Retirer l''ID niveau du fichier &2/&1, memb-
re &3 pour désactiver le contrôle et appliquer à nouveau la maquette. -
Puis sauvegardez la maquette.'                                        +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8234                    */
     /* Impossible de charger la maquette - les niveaux de format n */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8234) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8234) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impossible de charger la maquette - les niveaux de format ne correspo-
ndent pas.'                                                           +
                ) +
                SECLVL( +
'&N &N Cause . . . . . :   La maquette indiquée n''a pas pu être charg-
ée, car l''ID de niveau de format enregistré dans la maquette diffère -
de celui du fichier à afficher.&N Reprise . . . . :   Supprimer l''enr-
egistrement *RCDFMTID du fichier &2/&1, membre &3, pour désactiver le -
contrôle de niveau, puis appliquer à nouveau la maquette. Si le charge-
ment réussit, sauvegarder la maquette pour réintégrer l''ID de niveau -
de format.'                                                           +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8235                    */
     /* La sélection SQL n'est pas prise en charge pour les fichiers*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8235) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8235) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La sélection SQL n''est pas prise en charge pour les fichiers logique-
s multi-membres.'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8236                    */
     /* Mode insertion activé. Positionnez le curseur, puis appuyez */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8236) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8236) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mode insertion activé. Positionnez le curseur, puis appuyez sur F7.' +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8237                    */
     /* Appuyer sur la touche "Entrée" pour insérer le nombre d'esp */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8237) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8237) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Appuyer sur la touche "Entrée" pour insérer le nombre d''espaces indi-
qué.'                                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8238                    */
     /* Mode de suppression activé. Positionnez le curseur, puis ap */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8238) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8238) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mode de suppression activé. Positionnez le curseur, puis appuyez sur -
F8.'                                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8239                    */
     /* Appuyer sur la touche "Entrée" pour effacer la plage de car */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8239) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8239) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Appuyer sur la touche "Entrée" pour effacer la plage de caractères sp-
écifiée.'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8240                    */
     /* La valeur ne doit pas être inférieure à &1.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8240) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8240) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La valeur ne doit pas être inférieure à &1.'                         +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 5 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8241                    */
     /* Longueur de champ dépassée. La valeur est trop longue de &1 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8241) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8241) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Longueur de champ dépassée. La valeur est trop longue de &1 caractère-
s.'                                                                   +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 5 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9992                    */
     /* Echec sauvegarde paramètres utilisateur                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9992) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9992) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Echec sauvegarde paramètres utilisateur'                             +
                ) +
                SECLVL( +
'&N &N Cause . . . . . :   Les paramètres utilisateur n''ont pas pu êt-
re sauvegardés en raison du code d''erreur &1. &N &N Les codes d''erre-
ur possibles sont: &N &B 1 - Le nom du fichier (&2) ne correspond pas -
au fichier ouvert. &B 2 - Le nom de la bibliothèque (&2) ne correspond-
 pas à la bibliothèque du fichier ouvert. &B 3 - Le fichier des paramè-
tres utilisateur &3/&2, membre &4, n''a pas pu être ouvert.'          +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 10 0) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9993                    */
     /* Fichier non ouvert. SQL est limité aux fichiers physiques   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9993) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9993) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fichier non ouvert. SQL est limité aux fichiers physiques'           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9994                    */
     /* Erreur inattendue &1 dans la procédure C &2.                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9994) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9994) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Erreur inattendue &1 dans la procédure C &2.'                        +
                ) +
                SECLVL( +
'&N &N Description . . :   &3'                                        +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 5 0) +
                    (*CHAR 32) +
                    (*CHAR 256) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9995                    */
     /* Modifie le format d'enregistrement des fichiers de configur */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9995) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9995) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Modifie le format d''enregistrement des fichiers de configuration ...-
'                                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9996                    */
     /* Aucun fichier ouvert.                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9996) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9996) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Aucun fichier ouvert.'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9997                    */
     /* &2PEEK/400 est&1 un partagiciel &2Veuillez vous enregistrer */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9997) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9997) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'&2PEEK/400 est&1 un partagiciel &2Veuillez vous enregistrer.'        +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 1) +
                    (*CHAR 1) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9998                    */
     /* Message inattendu n° &1 reçu du programme &2.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9998) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9998) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Message inattendu n° &1 reçu du programme &2.'                       +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 7) +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9999                    */
     /* &1                                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9999) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9999) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'&1'                                                                  +
                ) +
                SECLVL( +
'&2'                                                                  +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 128) +
                    (*CHAR 128) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

             RCLRSC LVL(*)

             ENDPGM
