     /*-----------------------------------------------------------------------*/
     /* Hinweis: Dieses CL muss in einem Job mit der Sprache der              */
     /*          Zielnachrichtendatei kompiliert und ausgeführt werden.       */
     /*-----------------------------------------------------------------------*/
     /* STRPREPRC Compile Options:                                            */
     /* >>PRE-COMPILER<<                                                      */
     /*   >>CRTCMD<<  CALL       PGM(QTEMP/&OB) PARM(&LI);                    */
     /*   >>CMD<<     CHGJOB  LANGID(ENG) CNTRYID(US) CCSID(1140);            */
     /*   >>CMD<<     CRTCLPGM   PGM(QTEMP/&OB) +                             */
     /*                          SRCFILE(&SL/&SF) SRCMBR(&SM) +               */
     /*               TEXT('Peek/400 - English');                             */
     /*   >>EXECUTE<<                                                         */
     /*   >>CMD<<     DLTPGM PGM(QTEMP/&OB);                                  */
     /*   >>CMD<<     CHGJOB  LANGID(DEU) CNTRYID(DE) CCSID(273);             */
     /* >>END-PRE-COMPILER<<                                                  */
     /*-----------------------------------------------------------------------*/
             PGM        PARM(&I_LIB)

             DCL        VAR(&I_LIB     ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&LIB       ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OBJ       ) TYPE(*CHAR) LEN(10)  VALUE('PEEKENG')
             DCL        VAR(&CCSID     ) TYPE(*DEC ) LEN(5 0) VALUE(1140)
             DCL        VAR(&LANGUAGE  ) TYPE(*CHAR) LEN(20)  VALUE('English')

             CHGVAR     VAR(&LIB       ) VALUE(&I_LIB)
             MONMSG     MSGID(MCH3601) EXEC(DO)
               RMVMSG     PGMQ(*SAME (*)) CLEAR(*ALL)
               SNDPGMMSG  MSGID(CPF9898) MSGF(*LIBL/QCPFMSG) +
                            MSGDTA('Usage: CALL PGM(PEEKITAMG) PARM(libName)') +
                            TOPGMQ(*PRV (*PGMBDY)) MSGTYPE(*ESCAPE)
             ENDDO

             DLTMSGF    MSGF(&LIB/&OBJ)
             MONMSG     MSGID(CPF2105) /* Object not found */

             CRTMSGF MSGF(&LIB/&OBJ ) TEXT('Peek/400 - ' *CAT &LANGUAGE)

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BA                    */
     /* Command key F22 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BA) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BA) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F22 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BB                    */
     /* Command key F23 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BB) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BB) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F23 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BC                    */
     /* Command key F24 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BC) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BC) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F24 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BD                    */
     /* Key 'DELETE' is not valid.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BD) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BD) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key ''DELETE'' is not valid.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B1                    */
     /* Command key F13 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B1) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B1) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F13 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B2                    */
     /* Command key F14 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B2) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B2) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F14 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B3                    */
     /* Command key F15 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B3) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B3) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F15 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B4                    */
     /* Command key F16 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B4) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B4) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F16 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B5                    */
     /* Command key F17 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B5) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B5) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F17 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B6                    */
     /* Command key F18 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B6) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B6) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F18 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B7                    */
     /* Command key F19 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B7) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B7) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F19 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B8                    */
     /* Command key F20 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B8) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B8) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F20 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B9                    */
     /* Command key F21 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B9) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B9) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F21 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F1                    */
     /* Key 'ENTER' is not valid.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F1) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F1) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key ''ENTER'' is not valid.'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F3                    */
     /* Key 'HELP' is not valid.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F3) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F3) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key ''HELP'' is not valid.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F4                    */
     /* Key 'PAGE DOWN' is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F4) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F4) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key ''PAGE DOWN'' is not valid.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F5                    */
     /* Key 'PAGE UP' is not valid.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F5) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F5) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key ''PAGE UP'' is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F6                    */
     /* Key 'PRINT' is not valid.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F6) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F6) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key ''PRINT'' is not valid.'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F8                    */
     /* Key 'RESET' is not valid.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F8) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F8) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key ''RESET'' is not valid.'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003A                    */
     /* Command key F10 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003A) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003A) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F10 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003B                    */
     /* Command key F11 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003B) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003B) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F11 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003C                    */
     /* Command key F12 is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003C) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003C) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F12 is not valid.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003F                    */
     /* Key 'LIGHT PEN' is not valid.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003F) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003F) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key ''LIGHT PEN'' is not valid.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0031                    */
     /* Command key F1 is not valid.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F1 is not valid.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0032                    */
     /* Command key F2 is not valid.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F2 is not valid.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0033                    */
     /* Command key F3 is not valid.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F3 is not valid.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0034                    */
     /* Command key F4 is not valid.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F4 is not valid.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0035                    */
     /* Command key F5 is not valid.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F5 is not valid.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0036                    */
     /* Command key F6 is not valid.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F6 is not valid.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0037                    */
     /* Command key F7 is not valid.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F7 is not valid.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0038                    */
     /* Command key F8 is not valid.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F8 is not valid.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0039                    */
     /* Command key F9 is not valid.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key F9 is not valid.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0100                    */
     /* Unknown and invalid key.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unknown and invalid key.'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0001                    */
     /* ENTER                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'ENTER         '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0002                    */
     /* Exit                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Exit          '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0003                    */
     /* Refresh                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Refresh       '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0004                    */
     /* Add record                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Add record    '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0005                    */
     /* Headline                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Headline      '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0006                    */
     /* Mark column                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mark column   '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0007                    */
     /* Move to Top                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Move to Top   '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0008                    */
     /* Pos. Cursor                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pos. Cursor   '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0009                    */
     /* Search                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Search        '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0010                    */
     /* Top                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Top           '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0011                    */
     /* Botton                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Botton        '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0012                    */
     /* Left                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Left          '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0013                    */
     /* Right                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Right         '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0014                    */
     /* Command line                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command line  '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0015                    */
     /* 80/132 Char.                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0015) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0015) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'80/132 Char.  '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0016                    */
     /* More keys                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'More keys     '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0017                    */
     /* Page down                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Page down     '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0018                    */
     /* Page up                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Page up       '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0019                    */
     /* Pin-Row                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pin-Row       '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0020                    */
     /* UnPin-Row                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0020) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0020) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'UnPin-Row     '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0021                    */
     /* Change record                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0021) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0021) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Change record '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0022                    */
     /* Copy record                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0022) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0022) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Copy record   '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0023                    */
     /* Delete record                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0023) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0023) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Delete record '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0024                    */
     /* Display record                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0024) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0024) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Display record'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0025                    */
     /* Settings                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0025) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0025) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Settings      '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0026                    */
     /* Cancel                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0026) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0026) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cancel        '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0027                    */
     /* Save & Exit                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0027) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0027) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Save & Exit   '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0028                    */
     /* Pin-Column                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0028) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0028) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pin-Column    '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0029                    */
     /* UnPin-Column                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0029) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0029) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'UnPin-Column  '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0030                    */
     /* Pin-Column +/-                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0030) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0030) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pin-Column +/-'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0031                    */
     /* Coloured lines                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Coloured lines'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0032                    */
     /* B/W lines                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'B/W lines     '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0033                    */
     /* Colour <-> B/W                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Colour <-> B/W'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0034                    */
     /* Yes to all                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Yes to all    '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0035                    */
     /* More options                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'More options  '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0036                    */
     /* Copy to file                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Copy to file  '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0037                    */
     /* Mark column                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mark column'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0038                    */
     /* UnMark column                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'UnMark column'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0039                    */
     /* Lower Case                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lower Case'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0040                    */
     /* Upper Case                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0040) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0040) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Upper Case'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0041                    */
     /* Lower/Upper +/-                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0041) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0041) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lower/Upper +/-'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0042                    */
     /* Splash-On                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0042) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0042) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Splash-On'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0043                    */
     /* Splash-Off                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0043) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0043) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Splash-Off'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0044                    */
     /* Page left                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0044) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0044) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Page left'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0045                    */
     /* Page right                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0045) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0045) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Page right'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0046                    */
     /* Repeat                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0046) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0046) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Repeat'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0047                    */
     /* Rebuild                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0047) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0047) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Rebuild'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0048                    */
     /* UnPin all Row                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0048) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0048) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'UnPin all Row'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0049                    */
     /* UnPin all Col                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0049) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0049) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'UnPin all Col'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0050                    */
     /* Layout                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0050) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0050) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Layout'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0051                    */
     /* Float keys                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0051) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0051) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Float keys'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0052                    */
     /* Select                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0052) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0052) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Select'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0053                    */
     /* Next mark.                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0053) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0053) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Next mark.'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0054                    */
     /* Previous Mark.                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0054) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0054) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Previous Mark.'                                                      +
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
     /* Prompt                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0056) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0056) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Prompt'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0057                    */
     /* Key order                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0057) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0057) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key order'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0058                    */
     /* Record order                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0058) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0058) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record order'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0059                    */
     /* Key/RRN                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0059) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0059) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key/RRN'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0060                    */
     /* Hex-Edit                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0060) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0060) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Hex-Edit'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0061                    */
     /* About                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0061) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0061) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'About'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0062                    */
     /* Pin Columns                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0062) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0062) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pin Columns'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0063                    */
     /* Clear All                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0063) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0063) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Clear All'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0064                    */
     /* Norm.Dsp.Mode                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0064) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0064) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Norm.Dsp.Mode'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0065                    */
     /* Hex-Dsp.Mode                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0065) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0065) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Hex-Dsp.Mode'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0066                    */
     /* Toggle Dsp.Mode                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0066) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0066) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Toggle Dsp.Mode'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0067                    */
     /* SQL-Selection                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0067) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0067) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL-Selection'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0068                    */
     /* Ins.Key Fields                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0068) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0068) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ins.Key Fields'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0069                    */
     /* Save Env.                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0069) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0069) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Save Env.'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0070                    */
     /* Load Env.                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0070) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0070) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Load Env.'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0071                    */
     /* Delete Env.                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0071) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0071) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Delete Env.    '                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0072                    */
     /* Sort Sequence                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0072) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0072) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sort Sequence'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0073                    */
     /* Yes                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0073) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0073) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Yes'                                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0074                    */
     /* No                                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0074) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0074) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No'                                                                  +
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
     /* First Pos.                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0076) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0076) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'First Pos.'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0077                    */
     /* Last Pos.                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0077) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0077) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Last Pos.'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0078                    */
     /* Environment                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0078) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0078) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Environment'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0079                    */
     /* Layout only                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0079) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0079) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Layout only'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0080                    */
     /* Toggle NULL-Flag                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0080) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0080) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Toggle NULL-Flag'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0081                    */
     /* Toggle Input Mode                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0081) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0081) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Toggle Input Mode'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0082                    */
     /* String-Edit                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0082) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0082) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'String-Edit'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0083                    */
     /* Record Lock                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0083) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0083) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record Lock'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0084                    */
     /* Key lower case                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0084) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0084) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key lower case'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0085                    */
     /* Print                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0085) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0085) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Print'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0086                    */
     /* Insert                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0086) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0086) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Insert'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0087                    */
     /* Delete                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0087) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0087) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Delete'                                                              +
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
     /* File                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'File'                                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0002                    */
     /* Member                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Member'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0003                    */
     /* Type of record access                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Type of record access'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0004                    */
     /* Language                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Language'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0005                    */
     /* Allow to change library                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Allow to change library'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0006                    */
     /* Allow to change file                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Allow to change file'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0007                    */
     /* Allow to change member                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Allow to change member'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0008                    */
     /* Allow to change records                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Allow to change records'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0009                    */
     /* Allow to change SQL WHERE                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Allow to change SQL WHERE'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0010                    */
     /* Allow to change SQL ORDER BY                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Allow to change SQL ORDER BY'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0011                    */
     /* Environment                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Environment'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0012                    */
     /*   Member                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Member'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0013                    */
     /* SQL WHERE clause                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL WHERE clause'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0014                    */
     /* SQL ORDER BY clause                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL ORDER BY clause'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0015                    */
     /* Library                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0015) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0015) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Library'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0016                    */
     /* User settings                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'User settings'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0017                    */
     /* User profile                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'User profile'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0018                    */
     /* Save on exit                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Save on exit'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0019                    */
     /* Load layout only                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Load layout only'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0100                    */
     /* File Editor - Peek/400                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'File Editor - Peek/400'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0101                    */
     /* Display Database Relations                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Display Database Relations'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0001                    */
     /* File:                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'File:'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0002                    */
     /*    Library:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'   Library:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0003                    */
     /*    Member:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'   Member:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0004                    */
     /* Length   :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Length   :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0005                    */
     /* Records  :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Records  :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0006                    */
     /* Field-No.:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field-No.:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0007                    */
     /* Window field:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Window field:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0008                    */
     /*    Format:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'   Format:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0009                    */
     /* File Size:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'File Size:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0010                    */
     /* Record-No:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record-No:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0011                    */
     /* Key-Value:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key-Value:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0012                    */
     /*   Options:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Options:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0013                    */
     /*  File:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' File:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0014                    */
     /* Lib:                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lib:'                                                                +
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
     /* Length:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Length:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0017                    */
     /* Record:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0018                    */
     /* Field-No.:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field-No.:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0019                    */
     /* Window-Field:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Window-Field:'                                                       +
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
     /* Size  :                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0021) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0021) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Size  :'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0022                    */
     /* Record-No:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0022) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0022) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record-No:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0023                    */
     /* Key-Value:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0023) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0023) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key-Value:'                                                          +
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
     /* (No records found)                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0025) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0025) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(No records found)'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0026                    */
     /* Press ENTER to DELETE ...                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0026) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0026) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Press ENTER to DELETE ...'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0027                    */
     /* Expanded record ...                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0027) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0027) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Expanded record ...'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0028                    */
     /* Press ENTER to COPY ...                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0028) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0028) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Press ENTER to COPY ...'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0029                    */
     /* Record:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0029) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0029) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0030                    */
     /* Commitment control                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0030) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0030) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Commitment control'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0031                    */
     /* w/o commit control                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'w/o commit control'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0032                    */
     /* (No records found)                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(No records found)'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0033                    */
     /*      -  Find  -                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'     -  Find  -'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0034                    */
     /* Field                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field'                                                               +
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
     /* Value (without quotes)                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Value (without quotes)'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0037                    */
     /* for generic search)                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'for generic search)'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0038                    */
     /* Max Search ...:                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Max Search ...:'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0039                    */
     /* Search type ..:                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Search type ..:'                                                     +
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
     /* Case-sensitive:                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0041) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0041) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Case-sensitive:'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0042                    */
     /* (1=Yes, 0=No)                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0042) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0042) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(1=Yes, 0=No)'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0043                    */
     /*     - Colour -                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0043) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0043) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'    - Colour -'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0044                    */
     /* -  Select Colour  -                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0044) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0044) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'-  Select Colour  -'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0045                    */
     /* Green                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0045) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0045) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Green    '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0046                    */
     /* White                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0046) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0046) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'White    '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0047                    */
     /* Red                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0047) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0047) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Red      '                                                           +
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
     /* Yellow                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0049) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0049) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Yellow   '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0050                    */
     /* Pink                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0050) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0050) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pink     '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0051                    */
     /* Blue                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0051) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0051) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Blue     '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0052                    */
     /*   - Copy to file -                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0052) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0052) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  - Copy to file -'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0053                    */
     /* File ............:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0053) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0053) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'File ............:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0054                    */
     /* Library .........:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0054) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0054) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Library .........:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0055                    */
     /* Member ..........:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0055) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0055) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Member ..........:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0056                    */
     /* Replace Records .:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0056) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0056) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Replace Records .:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0057                    */
     /* Create File .....:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0057) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0057) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Create File .....:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0058                    */
     /*   - Licence data -                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0058) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0058) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  - Licence data -'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0059                    */
     /* Licence-No:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0059) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0059) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Licence-No:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0060                    */
     /* F9=Test it!                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0060) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0060) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'F9=Test it!'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0061                    */
     /* Licence data has been saved!                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0061) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0061) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Licence data has been saved!'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0062                    */
     /* Sorry, there is no more time left ...                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0062) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0062) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sorry, there is no more time left ...'                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0063                    */
     /* Press ENTER to CHANGE ...                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0063) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0063) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Press ENTER to CHANGE ...'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0064                    */
     /* Press ENTER to COPY ...                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0064) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0064) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Press ENTER to COPY ...'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0065                    */
     /* Press ENTER to ADD ...                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0065) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0065) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Press ENTER to ADD ...'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0066                    */
     /*    More ...                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0066) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0066) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'   More ...'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0067                    */
     /*         End                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0067) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0067) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'        End'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0068                    */
     /* Commit & Rollback                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0068) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0068) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Commit & Rollback'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0069                    */
     /* 80-/132- Character Mode                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0069) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0069) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'80-/132- Character Mode'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0070                    */
     /* Powerfull search engine                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0070) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0070) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Powerfull search engine'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0071                    */
     /* User defined keyboard layout                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0071) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0071) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'User defined keyboard layout'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0072                    */
     /* User defined languages                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0072) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0072) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'User defined languages'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0073                    */
     /*  The ultimative                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0073) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0073) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' The ultimative'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0074                    */
     /* Data base browser                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0074) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0074) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Data base browser'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0075                    */
     /*         * Highlights *                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0075) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0075) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'        * Highlights *        '                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0076                    */
     /* Unprintable Char                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0076) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0076) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unprintable Char'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0077                    */
     /* - Layout -                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0077) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0077) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Layout -'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0078                    */
     /* Search:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0078) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0078) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Search:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0079                    */
     /*  O   Seq.   Field       Description                     Typ */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0079) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0079) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O   Seq.   Field       Description                     Type       St-
rPos '                                                                +
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
     /* Colour .:                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0081) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0081) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Colour .:'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0082                    */
     /* Selection :                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0082) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0082) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Selection :'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0083                    */
     /* Max. Width:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0083) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0083) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Max. Width:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0084                    */
     /* Editcode:                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0084) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0084) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editcode:'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0085                    */
     /* - Select Field -                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0085) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0085) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Select Field -'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0086                    */
     /*  O   Field       Description                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0086) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0086) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O   Field       Description                    '                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0087                    */
     /*  O  File                   Description                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0087) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0087) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O  File                   Description                               -
   '                                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0088                    */
     /* - Display Database Relations -                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0088) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0088) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Display Database Relations -'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0089                    */
     /* Dependancies:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0089) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0089) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Dependancies:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0090                    */
     /* Hex-Editor                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0090) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0090) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Hex-Editor '                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0091                    */
     /* Field .......:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0091) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0091) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field .......:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0092                    */
     /* Length ......:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0092) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0092) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Length ......:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0093                    */
     /* Content ...:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0093) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0093) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Content ...:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0094                    */
     /* Hex .......:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0094) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0094) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Hex .......:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0095                    */
     /* Start pos.  .:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0095) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0095) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Start pos.  .:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0096                    */
     /* Buff.Length:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0096) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0096) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Buff.Length:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0097                    */
     /*  A   Member      Description                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0097) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0097) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Member      Description                                        '+
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0098                    */
     /*   - Select Member -                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0098) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0098) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  - Select Member -   '                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0099                    */
     /* Member   :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0099) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0099) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Member   :'                                                          +
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
     /* - About Peek/400 -                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- About Peek/400 -'                                                  +
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
     /*  Pin Columns                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0106) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0106) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Pin Columns  '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0107                    */
     /*  Seq.   Field       Description                      Key Fi */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0107) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0107) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Seq.   Field       Description                      Key Field'      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0108                    */
     /* - SQL  Selection -                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0108) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0108) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- SQL  Selection -'                                                  +
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
     /* - Create Upd.Program -                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0111) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0111) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Create Upd.Program -'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0112                    */
     /* Lower-Case allowed?                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0112) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0112) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lower-Case allowed?   '                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0113                    */
     /* Default lower-case?                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0113) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0113) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Default lower-case?   '                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0114                    */
     /* Save as default?                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0114) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0114) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Save as default?      '                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0115                    */
     /* SQL-Selection                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0115) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0115) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL-Selection'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0116                    */
     /*    Select Environment                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0116) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0116) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'   Select Environment    '                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0117                    */
     /* File :                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0117) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0117) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'File :'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0118                    */
     /* Library ..:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0118) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0118) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Library ..:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0119                    */
     /*  A   Environment Description                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0119) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0119) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Environment Description'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0120                    */
     /*   Delete environment                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0120) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0120) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Delete environment   '                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0121                    */
     /* File  . . . :                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0121) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0121) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'File  . . . :'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0122                    */
     /* Library . :                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0122) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0122) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Library . :'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0123                    */
     /* Member  . . :                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0123) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0123) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Member  . . :'                                                       +
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
     /* Var. Length:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0125) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0125) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Var. Length:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0126                    */
     /* - Select Record Format -                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0126) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0126) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Select Record Format -'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0127                    */
     /* NULL value                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0127) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0127) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'NULL value'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0128                    */
     /* Text-Editor                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0128) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0128) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Text-Editor'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0129                    */
     /* *** Record locked ***                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0129) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0129) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'*** Record locked ***'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0130                    */
     /* Record unlocked                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0130) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0130) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record unlocked'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0131                    */
     /* Lock record for update?                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0131) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0131) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lock record for update?'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0132                    */
     /* File:                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0132) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0132) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'File: '                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0133                    */
     /*    Library:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0133) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0133) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'   Library:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0134                    */
     /* RRN:                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0134) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0134) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'RRN:'                                                                +
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
     /* Field Name                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0136) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0136) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field Name'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0137                    */
     /* Field Description                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0137) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0137) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field Description'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0138                    */
     /* Field Value                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0138) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0138) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field Value'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0139                    */
     /* Text:                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0139) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0139) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Text:'                                                               +
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
     /* ----- User Defined Options -----                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0141) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0141) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'----- User Defined Options ----- '                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0142                    */
     /*  O   File        Library      Description                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0142) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0142) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O   File        Library      Description'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0143                    */
     /*  - Select File  -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' - Select File  - '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0144                    */
     /* Init. NULL-Fields?                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0144) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0144) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Init. NULL-Fields?'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0145                    */
     /* Keep cursor position?                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0145) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0145) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Keep cursor position?'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0146                    */
     /* Insert                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0146) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0146) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Insert  '                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0147                    */
     /* Delete                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0147) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0147) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Delete  '                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0148                    */
     /* from:                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0148) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0148) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'from:   '                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0149                    */
     /* Length:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0149) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0149) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Length: '                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0150                    */
     /* to:                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0150) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0150) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'to:     '                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0151                    */
     /* Cursor pos. .:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0151) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0151) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cursor pos. .:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
     /* Unable to retrieve record format &3 of file &2/&1.          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to retrieve record format &3 of file &2/&1.'                  +
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
     /* Unable to retrieve list of record formats of file &2/&1.    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to retrieve list of record formats of file &2/&1.'            +
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
     /* Using commitment control ...                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Using commitment control ...'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0004                    */
     /* Unable to open the file using commitment control ...        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to open the file using commitment control ...'                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0005                    */
     /* Unable to open file &1. Refer to joblog.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to open file &1. Refer to joblog.'                            +
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
     /* No key information available of file &2/&1.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No key information available of file &2/&1.'                         +
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
     /* Unable to open file &2/&1 for UPDATE-mode. Changes to the f */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to open file &2/&1 for UPDATE-mode. Changes to the file are no-
t possible.'                                                          +
                ) +
                SECLVL( +
'&N &N Possible Causes: &N &B 1. The debugger has been started with UP-
DPROD(*NO). &B 2. The file is a  JOIN-File &B 3. The file has referenc-
ial constraint rules but is not been journaled. &B 4. The file has tri-
ggers but the trigger programs can not be found. &B 5. The file is a l-
ogical file, based on more than one member.'                          +
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
     /* Unable to locate file &2/&1.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to locate file &2/&1.'                                        +
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
     /* Unable to retrieve object description of file &2/&1.        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to retrieve object description of file &2/&1.'                +
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
     /* Unable to locate library &1.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to locate library &1.'                                        +
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
     /* Could not open file. Refer to the second help text or job p */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Could not open file. Refer to the second help text or job protocol to-
 get further information.'                                            +
                ) +
                SECLVL( +
'&N &N Error text  . . :   &1'                                        +
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
     /* C-IO Error &2: &1                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'C-IO Error &2: &1'                                                   +
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
     /* Executing SQL request ...                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Executing SQL request ...'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0014                    */
     /* Determining number of selected records ...                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Determining number of selected records ...'                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0143                    */
     /* - Select File -                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Select File -'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR1000                    */
     /* Access not allowed for file &2/&1, member &3.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR1000) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR1000) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Access not allowed for file &2/&1, member &3.'                       +
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
     /* Canceld by user using &1.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Canceld by user using &1.'                                           +
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
     /* Just a moment. Please stand by ...                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Just a moment. Please stand by ...'                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8102                    */
     /* Point to record and retry.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8102) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8102) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Point to record and retry.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8103                    */
     /* Unable to close file.                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8103) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8103) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to close file.'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8104                    */
     /* Retrieving field description of file &2/&1.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8104) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8104) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Retrieving field description of file &2/&1.'                         +
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
     /* Retrieving list of record formats of file &2/&1.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8105) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8105) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Retrieving list of record formats of file &2/&1.'                    +
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
     /* Retrieving network attributes.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8106) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8106) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Retrieving network attributes.'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8107                    */
     /* Retrieving objekt attributes of objekt &2/&1.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8107) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8107) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Retrieving objekt attributes of objekt &2/&1.'                       +
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
     /* Unable to find field '&1' in file &3/&2.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8108) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8108) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to find field ''&1'' in file &3/&2.'                          +
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
     /* Retrieving member description of member &3 of file &2/&1.   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8109) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8109) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Retrieving member description of member &3 of file &2/&1.'           +
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
     /* Option '&1' not valid.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8110) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8110) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Option ''&1'' not valid.'                                            +
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
     /* Yes to all.                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8111) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8111) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Yes to all.'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8112                    */
     /* Command accepted.                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8112) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8112) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command accepted.'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8113                    */
     /* Internal command &1 not valid.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8113) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8113) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Internal command &1 not valid.'                                      +
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
     /* Creating RPG-Program ...                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8114) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8114) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Creating RPG-Program ...'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8115                    */
     /* Begin of record.                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8115) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8115) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Begin of record.'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8116                    */
     /* End of record.                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8116) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8116) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'End of record.'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8117                    */
     /* Please point to column and retry.                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8117) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8117) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Please point to column and retry.'                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8118                    */
     /* Pin-Array is full.                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8118) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8118) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pin-Array is full.'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8119                    */
     /* Record already pinned.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8119) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8119) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record already pinned.'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8120                    */
     /* Unable to find record.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8120) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8120) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to find record.'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8121                    */
     /* UnPinned record.                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8121) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8121) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'UnPinned record.'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8122                    */
     /* Command key not valid.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8122) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8122) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Command key not valid.'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8123                    */
     /* Fields greater than 1024 could not be &1changed&2.          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8123) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8123) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fields greater than 1024 could not be &1changed&2.'                  +
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
     /* Operand '&1' not valid.                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8124) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8124) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Operand ''&1'' not valid.'                                           +
                ) +
                SECLVL( +
'&N &B Valid operands are: &N &P EQ   - equal &P NE   - not equal &P L-
T   - lower &P GT   - greater &P LE   - lower/equal &P GE   - greater/-
equal &P LIKE - like'                                                 +
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
     /* Invalid value for number of records to search.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8125) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8125) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid value for number of records to search.'                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8126                    */
     /* Invalid type of search. '&1'                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8126) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8126) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid type of search. ''&1'''                                      +
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
     /* Searching ...                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8127) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8127) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Searching ...'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8128                    */
     /* Searching. &1 of &2 records searched.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8128) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8128) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Searching. &1 of &2 records searched.'                               +
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
     /* Field '&1' of type '&2' not valid.                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8129) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8129) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field ''&1'' of type ''&2'' not valid.'                              +
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
     /* Record found. 'SEARCH'=continue/'ENTER'=Cancel.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8130) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8130) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record found. ''SEARCH''=continue/''ENTER''=Cancel.'                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8131                    */
     /* End of file - string not found. 'SEARCH'=continue/'ENTER'=C */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8131) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8131) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'End of file - string not found. ''SEARCH''=continue/''ENTER''=Cancel.-
'                                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8132                    */
     /* Maximum records searched. 'SEARCH'=continue/'ENTER'=Cancel. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8132) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8132) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Maximum records searched. ''SEARCH''=continue/''ENTER''=Cancel.'     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8133                    */
     /* 1=case-sensitive; 0=non case-sensitive                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8133) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8133) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=case-sensitive; 0=non case-sensitive'                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8134                    */
     /* Combination of operand &1 field &2 not valid.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8134) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8134) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Combination of operand &1 field &2 not valid.'                       +
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
     /* Operand &1 not valid with field type &2.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8135) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8135) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Operand &1 not valid with field type &2.'                            +
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
     /* Field '&1' not found.                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8136) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8136) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field ''&1'' not found.'                                             +
                ) +
                SECLVL( +
'&N &B Special values are: &N &P *RECORD - Search whole record.'      +
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
     /* Retrieving key information of file &2/&1.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8137) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8137) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Retrieving key information of file &2/&1.'                           +
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
     /* Field &1 contains invalid decimal data.                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8138) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8138) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field &1 contains invalid decimal data.'                             +
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
     /* Unable to position subfile.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8139) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8139) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to position subfile.'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8140                    */
     /* Please enter argument to search for.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8140) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8140) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Please enter argument to search for.'                                +
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
     /* Use '&1' for positive and '&2' für negative values as sign. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8141) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8141) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Use ''&1'' for positive and ''&2'' für negative values as sign.'     +
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
     /* Position &1 is reserved for the sign of numeric values.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8142) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8142) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Position &1 is reserved for the sign of numeric values.'             +
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
     /* There is no program function for key &1.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'There is no program function for key &1.'                            +
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
     /* No rekursiv command execution for command &1 possible.      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8144) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8144) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No rekursiv command execution for command &1 possible.'              +
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
     /* Unable to execute command due to empty subfile.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8145) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8145) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to execute command due to empty subfile.'                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8146                    */
     /* Unable to define colour for selected field.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8146) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8146) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to define colour for selected field.'                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8147                    */
     /* Column &1 has not been pinned.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8147) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8147) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Column &1 has not been pinned.'                                      +
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
     /* No more space for pinned column '&1'.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8148) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8148) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No more space for pinned column ''&1''.'                             +
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
     /* Coloured lines are already enabled.                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8149) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8149) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Coloured lines are already enabled.'                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8150                    */
     /* B/W lines are already enabled.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8150) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8150) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'B/W lines are already enabled.'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8151                    */
     /* Invalid name for target file '&1'.                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8151) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8151) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid name for target file ''&1''.'                                +
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
     /* Invalid name for target library '&1'.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8152) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8152) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid name for target library ''&1''.'                             +
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
     /* Invalid name for target member '&1'.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8153) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8153) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid name for target member ''&1''.'                              +
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
     /* Invalid Parameter '&1' for ADD/REPLACE.                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8154) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8154) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid Parameter ''&1'' for ADD/REPLACE.'                           +
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
     /* Invalid  Parameter '&1' for CREATE FILE.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8155) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8155) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid  Parameter ''&1'' for CREATE FILE.'                          +
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
     /* Execution failed.                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8156) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8156) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Execution failed.'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8157                    */
     /* Retrieving system values.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8157) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8157) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Retrieving system values.'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8158                    */
     /* Invalid Licence-No. '&1'.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8158) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8158) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid Licence-No. ''&1''.'                                         +
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
     /* Unable to save licence data.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8159) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8159) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to save licence data.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8160                    */
     /* Language definition file for language &1 not available.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8160) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8160) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Language definition file for language &1 not available.'             +
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
     /* SPLASH-Screen enabled.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8161) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8161) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SPLASH-Screen enabled.'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8162                    */
     /* SPLASH-Screen disabled.                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8162) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8162) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SPLASH-Screen disabled.'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8163                    */
     /* String contains characters below x'40' or equal x'FF'. Repl */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8163) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8163) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'String contains characters below x''40'' or equal x''FF''. Replaced w-
ith: &1'                                                              +
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
     /* Fields containing unprintable characters are hidden.        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8164) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8164) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fields containing unprintable characters are hidden.'                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8165                    */
     /* Please enter an option before choosing "REPEAT".            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8165) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8165) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Please enter an option before choosing "REPEAT".'                    +
                ) +
                SECLVL( +
'Cause . . . . . . : F13 (Repeat) was pressed, but no function was sel-
ected for repetition on this page. &N Recovery  . . . . : Enter an opt-
ion in the option column on this page and press "REPEAT" again.'      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8166                    */
     /* Unable to execute function due to no open file!             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8166) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8166) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to execute function due to no open file!'                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8167                    */
     /* Sequence number must be unique.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8167) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8167) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sequence number must be unique.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8168                    */
     /* Value &1 not allowed for attribute "visible/unvisible".     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8168) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8168) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Value &1 not allowed for attribute "visible/unvisible".'             +
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
     /* Value &1 not allowed for attribute "Mark column".           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8169) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8169) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Value &1 not allowed for attribute "Mark column".'                   +
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
     /* Value &1 not allowed for attribute "Max. size".             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8170) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8170) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Value &1 not allowed for attribute "Max. size".'                     +
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
     /* Invalid value '&1' for time-, date- or timestamp-field      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8171) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8171) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid value ''&1'' for time-, date- or timestamp-field'            +
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
     /* Processing: &1                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8172) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8172) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Processing: &1'                                                      +
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
     /* Recursive call not supported by Pekk/400.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8173) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8173) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Recursive call not supported by Pekk/400.'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8174                    */
     /* Character (&1) not allowed within hex string                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8174) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8174) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Character (&1) not allowed within hex string'                        +
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
     /* It is not allowed to enter an odd number of characters.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8175) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8175) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'It is not allowed to enter an odd number of characters.'             +
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
     /* Warning: String too long.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8176) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8176) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Warning: String too long.'                                           +
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
     /* Startposition exceeds field length.                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8177) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8177) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Startposition exceeds field length.'                                 +
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
     /* Do not enter a start position lower/equal null.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8178) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8178) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Do not enter a start position lower/equal null.'                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8179                    */
     /* No prompt available.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8179) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8179) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No prompt available.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8180                    */
     /* Member '&1' not found.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8180) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8180) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Member ''&1'' not found.'                                            +
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
     /* Can not save environment. File name is missing.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8181) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8181) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Can not save environment. File name is missing.'                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8182                    */
     /* Value &1 not valid as a name for an AS/400 object.          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8182) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8182) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Value &1 not valid as a name for an AS/400 object.'                  +
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
     /* Missing some information.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8183) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8183) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Missing some information.'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8184                    */
     /* This function has not been enabled. Please contact your adm */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8184) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8184) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'This function has not been enabled. Please contact your administrator-
.'                                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8185                    */
     /* No environment specified. No environment opened.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8185) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8185) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No environment specified. No environment opened.'                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8186                    */
     /* Warning: String to short.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8186) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8186) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Warning: String to short.'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8187                    */
     /* Field length exceeds I/O field buffer size.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8187) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8187) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field length exceeds I/O field buffer size.'                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8188                    */
     /* Create Diplay File. Stage: &1, Field: &2                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8188) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8188) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Create Diplay File. Stage: &1, Field: &2'                            +
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
     /* Create RPG Program. Stage: &1, Field: &2                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8189) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8189) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Create RPG Program. Stage: &1, Field: &2'                            +
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
     /* Request answered by &1.                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8190) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8190) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Request answered by &1.'                                             +
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
     /* Field &1 is not NULL capable.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8191) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8191) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field &1 is not NULL capable.'                                       +
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
     /* Field &1 contains invalid float data.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8192) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8192) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field &1 contains invalid float data.'                               +
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
     /* Fields '&1' contains unprintable characters and cannot be e */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8193) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8193) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fields ''&1'' contains unprintable characters and cannot be edited wi-
th the text editor.'                                                  +
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
     /* File '&1' not found.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8194) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8194) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'File ''&1'' not found.'                                              +
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
     /* Illegal request because this field is protected.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8195) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8195) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Illegal request because this field is protected.'                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8196                    */
     /* Field &1 cannot be displayed or changed.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8196) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8196) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field &1 cannot be displayed or changed.'                            +
                ) +
                SECLVL( +
'&N &N Possible Causes: &N &B 1. Unknown data type. &B 2. Graphic fiel-
d without CCSID. &B 3. Packed or zoned field with more than 30 digits.-
 &B 4. Unknown variable length field.'                                +
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
     /* Unable to delete record &1.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8200) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8200) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to delete record &1.'                                         +
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
     /* Record &1 has been deleted.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8201) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8201) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record &1 has been deleted.'                                         +
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
     /* Unable to copy record &1.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8202) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8202) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unable to copy record &1.'                                           +
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
     /* Record &1 has been copied.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8203) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8203) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record &1 has been copied.'                                          +
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
     /* No valid subfile record.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8204) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8204) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No valid subfile record.'                                            +
                ) +
                SECLVL( +
'&N &N Point to the record you want to be choosen and repeat your requ-
est, again.'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8205                    */
     /* Attention: It is not possible to pin more then &1 columns!  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8205) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8205) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Attention: It is not possible to pin more then &1 columns!'          +
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
     /* Can not display record. Record length exceeds maximum of &1 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8206) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8206) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Can not display record. Record length exceeds maximum of &1 bytes.'  +
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
     /* The file can not be opened due to its record length beeing  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8207) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8207) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'The file can not be opened due to its record length beeing greater th-
an &1.'                                                               +
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
     /* You are not allowed to change input-only fields.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8208) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8208) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'You are not allowed to change input-only fields.'                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8209                    */
     /* Please enter a search argument.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8209) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8209) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Please enter a search argument.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8210                    */
     /* SQL-Error &1. &2                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8210) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8210) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL-Error &1. &2'                                                    +
                ) +
                SECLVL( +
'&N &N Reason  . . . . :   &2 &N &B You may find more information abou-
t this error code in the SQL programming manual or in the message file-
 QSYS/QSQLMSG.'                                                       +
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
     /* Please put the cursor into a field and start your request a */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8211) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8211) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Please put the cursor into a field and start your request again.'    +
                ) +
                SECLVL( +
'Reason  . . . . :   The cursor is out of a field or the field is not -
valid for the request.'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8212                    */
     /* The SQL-selection can not be used with files other than phy */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8212) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8212) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'The SQL-selection can not be used with files other than physical file-
s. Open physical file?'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8213                    */
     /* 1=save; 0=do not save                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8213) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8213) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=save; 0=do not save'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8214                    */
     /* 1=enable lower-case; 0=only upper-case                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8214) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8214) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=enable lower-case; 0=only upper-case'                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8215                    */
     /* Lower-Case is not allowed.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8215) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8215) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lower-Case is not allowed.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8216                    */
     /* These values do not fit togehter.                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8216) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8216) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'These values do not fit togehter.'                                   +
                ) +
                SECLVL( +
'If you do not want to allow the user to enter lower case characters, -
you can not set this as the default value.'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8217                    */
     /* Sort by RRN not possible.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8217) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8217) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sort by RRN not possible.'                                           +
                ) +
                SECLVL( +
'It is not possible to open the file for a sort sequence by RRN, since-
 the file is based on more than one member.'                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8218                    */
     /* Record cannot be pinned, because logical file bases on mult */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8218) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8218) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record cannot be pinned, because logical file bases on multiple physi-
cal members.'                                                         +
                ) +
                SECLVL( +
'&N &N Cause . . . . . :   The record cannot be pinned, because the re-
lative record number is not unique and it is not possible to determine-
 the physical member that contains the record.'                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8219                    */
     /* Value '&1' not valid for Yes/No choice.                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8219) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8219) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Value ''&1'' not valid for Yes/No choice.'                           +
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
     /* Editor not allowed. Field &1 is NULL.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8220) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8220) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editor not allowed. Field &1 is NULL.'                               +
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
     /* Editor does not support data type of field &1.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8221) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8221) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editor does not support data type of field &1.'                      +
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
     /* Field &1 exceeds maximum length allowed for editor.         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8222) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8222) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field &1 exceeds maximum length allowed for editor.'                 +
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
     /* Switched key field to lower case mode.                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8223) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8223) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Switched key field to lower case mode.'                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8224                    */
     /* Switched key field to upper case mode.                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8224) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8224) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Switched key field to upper case mode.'                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8225                    */
     /* Record has been changed by another user. Update anyway?     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8225) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8225) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record has been changed by another user.&N&NUpdate anyway?'          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8226                    */
     /* Print operation successfully completed.                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8226) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8226) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Print operation successfully completed.'                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8227                    */
     /* Failed to convert '&1' to a numeric value.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8227) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8227) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Failed to convert ''&1'' to a numeric value.'                        +
                ) +
                SECLVL( +
'&N &N Information . . :   An error occured when trying to convert ''&-
1'' to a numeric value. The string could not be converted to a numeric-
 value of &2(&3,&4).'                                                 +
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
     /* Invalid data type entry: '&1'.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8228) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8228) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid data type entry: ''&1''.'                                    +
                ) +
                SECLVL( +
'&N &N Information . . :   The specified data type entry ''&1'' is inv-
alid. Please specify a valid RPG data type and try your request again.-
'                                                                     +
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
     /* Invalid field length entry: '&1'.                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8229) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8229) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid field length entry: ''&1''.'                                 +
                ) +
                SECLVL( +
'&N &N Information . . :   The specified field length ''&1'' is invali-
d. Please correct the field length and try your request again.'       +
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
     /* Invalid number of decimal positions: '&1'.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8230) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8230) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid number of decimal positions: ''&1''.'                        +
                ) +
                SECLVL( +
'&N &N Information . . :   The specified number of decimal positions '-
'&1'' is invalid. Please correct the number of decimal positions and t-
ry your request again. Please notice that not all data types, such as -
''A'' for String, require decimal positions.'                         +
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
     /* Cannot change record lock due 'copy' or 'add' mode.         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8231) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8231) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cannot change record lock due ''copy'' or ''add'' mode.'             +
                ) +
                SECLVL( +
'&N &N Information . . :   The current state of the record lock cannot-
 be changed. Changing the record lock is only possible when changing a-
 record. It is not possible to change the record lock while copying or-
 adding a record.'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8232                    */
     /* Record has been changed by another user. Lock record anywa  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8232) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8232) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record has been changed by another user.&N&NLock record anyway?'     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8233                    */
     /* Error: Cannot use layout. Record format IDs are different.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8233) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8233) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Error: Cannot use layout. Record format IDs are different.'          +
                ) +
                SECLVL( +
'&N &N Recovery  . . . :   Remove record *RCDFMTID from file &2/&1, me-
mber &3 to disable level check and try to apply the layout again. On s-
uccess save the layout to add the record format level ID.'            +
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
     /* Failed to load layout because record format level IDs do no */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8234) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8234) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Failed to load layout because record format level IDs do not match.' +
                ) +
                SECLVL( +
'&N &N Cause . . . . . :   The specified layout could not be loaded fr-
om the environment file, because the record format level ID of the lay-
out does not match the record format level ID of the specified file.&N-
 Recovery  . . . :   Remove record *RCDFMTID from file &2/&1, member &-
3 to disable level check and try to apply the layout again. On success-
 save the layout to add the record format level ID.'                  +
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
     /* SQL-Selection not supported for multi-member logical files. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8235) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8235) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL-Selection not supported for multi-member logical files.'         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8236                    */
     /* Insert mode activated. Position cursor, then press F7.      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8236) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8236) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Insert mode activated. Position cursor, then press F7. '             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8237                    */
     /* Press Enter to insert the specified number of spaces.       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8237) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8237) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Press Enter to insert the specified number of spaces.'               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8238                    */
     /* Delete mode activated. Position cursor, then press F8.      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8238) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8238) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Delete mode activated. Position cursor, then press F8.'              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8239                    */
     /* Press Enter to delete the specified range of characters.    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8239) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8239) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Press Enter to delete the specified range of characters.'            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8240                    */
     /* Value must not be less than &1.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8240) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8240) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Value must not be less than &1.'                                     +
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
     /* Field length exceeded. The value is &1 characters too long. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8241) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8241) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Field length exceeded. The value is &1 characters too long.'         +
                ) +
                SEV(0) +
                FMT( +
                    (*DEC 5 0) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8242                    */
     /* Invalid date, time or timestamp value in field &1.         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8242) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8242) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invalid date, time or timestamp value in field &1.'                  +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9992                    */
     /* Faild to save workspace settings.                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9992) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9992) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Faild to save workspace settings.'                                   +
                ) +
                SECLVL( +
'&N &N Cause . . . . . :   Workspace settings could not be saved becau-
se of error code &1. &N &N The possible error codes are: &N &B 1 - Fil-
e name (&2) does not match open file. &B 2 - Library name (&2) does no-
t match library of open file. &B 3 - Could not open workspace settings-
 file &3/&2 with member &4.'                                          +
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
     /* No file opened. Using SQL is restricted to physical files.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9993) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9993) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No file opened. Using SQL is restricted to physical files.'          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9994                    */
     /* Unexpected error &1 in C procedure &2.                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9994) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9994) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unexpected error &1 in C procedure &2.'                              +
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
     /* Changing record format of settings file ...                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9995) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9995) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Changing record format of settings file ...'                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9996                    */
     /* No file opened.                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9996) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9996) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No file opened.'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9997                    */
     /* &2PEEK/400 is&1 Shareware. &2Please register your copy.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9997) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9997) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'&2PEEK/400 is&1 Shareware. &2Please register your copy.'             +
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
     /* Unexpected message-id &1 received from program &2.          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9998) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9998) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unexpected message-id &1 received from program &2.'                  +
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
