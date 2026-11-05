     /*-----------------------------------------------------------------------*/
     /* Hinweis: Dieses CL muss in einem Job mit der Sprache der              */
     /*          Zielnachrichtendatei kompiliert und ausgeführt werden.       */
     /*-----------------------------------------------------------------------*/
     /* STRPREPRC Compile Options:                                            */
     /* >>PRE-COMPILER<<                                                      */
     /*   >>CRTCMD<<  CALL       PGM(QTEMP/&OB) PARM(&LI);                    */
     /*   >>CMD<<     CHGJOB  LANGID(ESP) CNTRYID(ES) CCSID(1145);            */
     /*   >>CMD<<     CRTCLPGM   PGM(QTEMP/&OB) +                             */
     /*                          SRCFILE(&SL/&SF) SRCMBR(&SM) +               */
     /*               TEXT('Peek/400 - Espanol');                             */
     /*   >>EXECUTE<<                                                         */
     /*   >>CMD<<     DLTPGM PGM(QTEMP/&OB);                                  */
     /*   >>CMD<<     CHGJOB  LANGID(DEU) CNTRYID(DE) CCSID(273);             */
     /* >>END-PRE-COMPILER<<                                                  */
     /*-----------------------------------------------------------------------*/
             PGM        PARM(&I_LIB)

             DCL        VAR(&I_LIB     ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&I_OBJ     ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&LIB       ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OBJ       ) TYPE(*CHAR) LEN(10)  VALUE('PEEKSPA')
             DCL        VAR(&CCSID     ) TYPE(*DEC ) LEN(5 0) VALUE(1145)
             DCL        VAR(&LANGUAGE  ) TYPE(*CHAR) LEN(20)  VALUE('Espanol')

             CHGVAR     VAR(&LIB       ) VALUE(&I_LIB)
             MONMSG     MSGID(MCH3601) EXEC(DO)
               RMVMSG     PGMQ(*SAME (*)) CLEAR(*ALL)
               SNDPGMMSG  MSGID(CPF9898) MSGF(*LIBL/QCPFMSG) +
                            MSGDTA('Usage: CALL PGM(PEEKSPAMG) PARM(libName)') +
                            TOPGMQ(*PRV (*PGMBDY)) MSGTYPE(*ESCAPE)
             ENDDO

             DLTMSGF    MSGF(&LIB/&OBJ)
             MONMSG     MSGID(CPF2105) /* Object not found */

             CRTMSGF MSGF(&LIB/&OBJ ) TEXT('Peek/400 - ' *CAT &LANGUAGE)

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BA                    */
     /* Tecla F22 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BA) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BA) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F22 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BB                    */
     /* Tecla F23 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BB) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BB) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F23 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BC                    */
     /* Tecla F24 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BC) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BC) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F24 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BD                    */
     /* Tecla 'DELETE' no válida.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BD) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BD) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla ''DELETE'' no válida.'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B1                    */
     /* Tecla F13 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B1) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B1) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F13 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B2                    */
     /* TEcla F14 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B2) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B2) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'TEcla F14 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B3                    */
     /* Tecla F15 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B3) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B3) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F15 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B4                    */
     /* Tecla F16 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B4) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B4) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F16 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B5                    */
     /* Tecla F17 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B5) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B5) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F17 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B6                    */
     /* Tecla F18 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B6) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B6) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F18 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B7                    */
     /* Tecla F19 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B7) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B7) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F19 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B8                    */
     /* Tecla F20 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B8) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B8) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F20 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B9                    */
     /* Tecla F21 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B9) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B9) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F21 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F1                    */
     /* Tecla 'ENTER' no válida.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F1) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F1) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla ''ENTER'' no válida.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F3                    */
     /* Tecla 'AYUDA' no válida.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F3) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F3) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla ''AYUDA'' no válida.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F4                    */
     /* Tecla 'PAG. ABAJO' no válida.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F4) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F4) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla ''PAG. ABAJO'' no válida.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F5                    */
     /* Tecla 'PAG.ARRIBA' no válida.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F5) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F5) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla ''PAG.ARRIBA'' no válida.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F6                    */
     /* Tecla 'PRINT' no válida.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F6) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F6) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla ''PRINT'' no válida.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F8                    */
     /* Tecla 'RESET' no válida.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F8) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F8) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla ''RESET'' no válida.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003A                    */
     /* Tecla F10 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003A) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003A) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F10 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003B                    */
     /* Tecla F11 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003B) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003B) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F11 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003C                    */
     /* Tecla F12 no válida.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003C) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003C) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F12 no válida.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003F                    */
     /* Tecla 'LIGHT PEN' no válida.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003F) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003F) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla ''LIGHT PEN'' no válida.'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0031                    */
     /* Tecla F1 no válida.                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F1 no válida.'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0032                    */
     /* Tecla F2 no válida.                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F2 no válida.'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0033                    */
     /* Tecla F3 no válida.                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F3 no válida.'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0034                    */
     /* Tecla F4 no válida.                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F4 no válida.'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0035                    */
     /* Tecla F5 no válida.                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F5 no válida.'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0036                    */
     /* Tecla F6 no válida.                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F6 no válida.'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0037                    */
     /* Tecla F7 no válida.                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F7 no válida.'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0038                    */
     /* Tecla F8 no válida.                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F8 no válida.'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0039                    */
     /* Tecla F9 no válida.                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla F9 no válida.'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0100                    */
     /* Tecla desconocida y no válida                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla desconocida y no válida'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0001                    */
     /* Entrada datos                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Entrada datos '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0002                    */
     /* Salir                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Salir         '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0003                    */
     /* Refrescar                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Refrescar     '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0004                    */
     /* Añadir registro                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Añadir registro'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0005                    */
     /* Cabecera                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cabecera      '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0006                    */
     /* Marcar columna                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Marcar columna'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0007                    */
     /* Mover arriba                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mover arriba  '                                                      +
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
     /* Buscar                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Buscar        '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0010                    */
     /* Arriba                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Arriba        '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0011                    */
     /* Abajo                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Abajo         '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0012                    */
     /* Izquierda                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Izquierda     '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0013                    */
     /* Derecha                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Derecha       '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0014                    */
     /* Lín.mandatos                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lín.mandatos'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0015                    */
     /* 80/132 Car.                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0015) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0015) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'80/132 Car.  '                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0016                    */
     /* Más teclas                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Más teclas    '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0017                    */
     /* Pag. abajo                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pag. abajo    '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0018                    */
     /* Pag. arriba                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pag. arriba   '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0019                    */
     /* Clavar fila                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Clavar fila   '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0020                    */
     /* Desclavar fila                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0020) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0020) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Desclavar fila'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0021                    */
     /* Cambiar                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0021) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0021) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cambiar'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0022                    */
     /* Copiar                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0022) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0022) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Copiar'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0023                    */
     /* Borrar                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0023) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0023) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Borrar'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0024                    */
     /* Ver                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0024) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0024) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ver'                                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0025                    */
     /* Configuración                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0025) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0025) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Configuración '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0026                    */
     /* Cancelar                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0026) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0026) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cancelar      '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0027                    */
     /* Salvar & Salir                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0027) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0027) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Salvar & Salir'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0028                    */
     /* Clavar Columna                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0028) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0028) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Clavar Columna'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0029                    */
     /* Desclavar Columna                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0029) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0029) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Desclavar Columna'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0030                    */
     /* Clavar Columna +/-                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0030) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0030) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Clavar Columna +/-'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0031                    */
     /* Líneas Coloreadas                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Líneas Coloreadas'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0032                    */
     /* Líneas B/N                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Líneas B/N    '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0033                    */
     /* Color <-> B/N                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Color <-> B/N'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0034                    */
     /* Sí a todo                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sí a todo     '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0035                    */
     /* Más opciones                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Más opciones  '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0036                    */
     /* Copiar a archivo                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Copiar a archivo'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0037                    */
     /* Marcar columna                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Marcar columna'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0038                    */
     /* Desmarcar columna                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Desmarcar columna'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0039                    */
     /* Minúsculas                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Minúsculas'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0040                    */
     /* Mayúsculas                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0040) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0040) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mayúsculas'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0041                    */
     /* Min/May +/-                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0041) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0041) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Min/May +/-'                                                         +
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
     /* Pag. izquierda                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0044) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0044) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pag. izquierda'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0045                    */
     /* Pag. derecha                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0045) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0045) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pag. derecha'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0046                    */
     /* Repetir                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0046) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0046) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Repetir'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0047                    */
     /* Reconstruir                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0047) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0047) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reconstruir'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0048                    */
     /* Desclavar filas                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0048) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0048) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Desclavar filas'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0049                    */
     /* Desclavar columnas                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0049) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0049) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Desclavar columnas'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0050                    */
     /* Diseño                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0050) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0050) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Diseño'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0051                    */
     /* Teclas flotantes                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0051) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0051) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Teclas flotantes'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0052                    */
     /* Seleccionar                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0052) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0052) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Seleccionar'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0053                    */
     /* Marca siguiente.                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0053) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0053) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Marca siguiente.'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0054                    */
     /* Marca Anterior                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0054) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0054) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Marca Anterior'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0055                    */
     /* Relaciones                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0055) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0055) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Relaciones'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0056                    */
     /* Solicitud                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0056) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0056) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Solicitud'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0057                    */
     /* Orden por clave                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0057) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0057) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Orden por clave'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0058                    */
     /* Orden por registro                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0058) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0058) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Orden por registro'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0059                    */
     /* Clave/RRN                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0059) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0059) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Clave/RRN'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0060                    */
     /* Edicion Hex.                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0060) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0060) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Edicion Hex.'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0061                    */
     /* Acerca de                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0061) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0061) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Acerca de'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0062                    */
     /* Col.clavadas                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0062) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0062) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Col.clavadas'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0063                    */
     /* Borrar todo                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0063) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0063) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Borrar todo'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0064                    */
     /* Vis.Normal                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0064) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0064) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Vis.Normal'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0065                    */
     /* Vis.Hex                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0065) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0065) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Vis.Hex'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0066                    */
     /* Cambiar modo vis.                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0066) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0066) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cambiar modo vis.'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0067                    */
     /* Selección SQL                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0067) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0067) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Selección SQL'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0068                    */
     /* Ins.Cpos Clave                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0068) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0068) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ins.Cpos Clave'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0069                    */
     /* Salvar Entorno                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0069) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0069) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Salvar Entorno'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0070                    */
     /* Cargar Entorno                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0070) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0070) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cargar Entorno'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0071                    */
     /* Borrar Entorno                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0071) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0071) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Borrar Entorno '                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0072                    */
     /* Sec. clasificación                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0072) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0072) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sec. clasificación'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0073                    */
     /* Sí                                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0073) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0073) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sí'                                                                  +
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
     /* Primera Pos.                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0076) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0076) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Primera Pos.'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0077                    */
     /* Ultima Pos.                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0077) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0077) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ultima Pos.'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0078                    */
     /* Entorno                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0078) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0078) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Entorno'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0079                    */
     /* Diseño sólo                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0079) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0079) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Diseño sólo'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0080                    */
     /* Cambiar NULL-Flag                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0080) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0080) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cambiar NULL-Flag'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0081                    */
     /* Cambiar modo ent.                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0081) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0081) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cambiar modo ent.'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0082                    */
     /* Editar cadena                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0082) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0082) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editar cadena'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0083                    */
     /* Bloqueo registro                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0083) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0083) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bloqueo registro'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0084                    */
     /* Tecla minúscúlas                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0084) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0084) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tecla minúscúlas'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0085                    */
     /* Imprimir                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0085) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0085) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Imprimir'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0086                    */
     /* Inserte                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0086) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0086) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Inserte'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0087                    */
     /* Borrar                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0087) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0087) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Borrar'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   MBX0001                    */
     /* Información                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(MBX0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(MBX0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Información'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   MBX0002                    */
     /* Preguntas                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(MBX0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(MBX0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Preguntas'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0001                    */
     /* Fichero                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fichero'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0002                    */
     /* Miembro                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Miembro'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0003                    */
     /* Tipo de acceso de registro                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tipo de acceso de registro'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0004                    */
     /* Idioma                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Idioma'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0005                    */
     /* Permitir cambio de biblioteca                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Permitir cambio de biblioteca'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0006                    */
     /* Permitir cambio de archivo                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Permitir cambio de archivo'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0007                    */
     /* Permitir cambio de miembro                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Permitir cambio de miembro'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0008                    */
     /* Permitir cambiar registros                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Permitir cambiar registros'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0009                    */
     /* Permitir cambiar SQL WHERE                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Permitir cambiar SQL WHERE'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0010                    */
     /* Permitir cambiar SQL ORDER BY                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Permitir cambiar SQL ORDER BY'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0011                    */
     /* Entorno                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Entorno'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0012                    */
     /*   Miembro                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Miembro'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0013                    */
     /* Claúsula SQL WHERE                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Claúsula SQL WHERE'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0014                    */
     /* Claúsula SQL ORDER BY                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Claúsula SQL ORDER BY'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0015                    */
     /* Biblioteca                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0015) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0015) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Biblioteca'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0016                    */
     /* Configuración de usuario                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Configuración de usuario'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0017                    */
     /* Perfil de Usuario                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Perfil de Usuario'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0018                    */
     /* Guardar al salir                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Guardar al salir'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0019                    */
     /* Cargar solo el diseño                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cargar solo el diseño'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0100                    */
     /* Editor de Archivo - Peek/400                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editor de Archivo - Peek/400'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0101                    */
     /* Ver relación de base de datos                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ver relación de base de datos'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0001                    */
     /* Fich:                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fich:'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0002                    */
     /* Biblioteca:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Biblioteca:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0003                    */
     /*   Miembro:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Miembro:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0004                    */
     /* Longitud :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Longitud :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0005                    */
     /* Registros:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Registros:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0006                    */
     /* Campo-No.:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo-No.:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0007                    */
     /*  Campo vent.:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Campo vent.:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0008                    */
     /*   Formato:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Formato:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0009                    */
     /* Tamaño arch.:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tamaño arch.:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0010                    */
     /* Registro-No:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Registro-No:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0011                    */
     /* Valor de Clave:                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor de Clave:'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0012                    */
     /*   Opciones:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Opciones:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0013                    */
     /*  Fich:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Fich:'                                                              +
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
     /* Long..:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Long..:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0017                    */
     /* Reg...:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reg...:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0018                    */
     /* Campo-No.:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo-No.:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0019                    */
     /* Cpo Ventana:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cpo Ventana:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0020                    */
     /* Fmto..:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0020) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0020) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fmto..:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0021                    */
     /* Tamaño:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0021) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0021) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tamaño:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0022                    */
     /* Reg-No:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0022) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0022) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reg-No:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0023                    */
     /* Clave....:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0023) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0023) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Clave....:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0024                    */
     /* Opcion.:                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0024) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0024) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Opcion.:'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0025                    */
     /* (No hay registros)                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0025) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0025) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(No hay registros)'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0026                    */
     /* Pulse ENTER para Borrar..                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0026) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0026) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pulse ENTER para Borrar..'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0027                    */
     /* Reg. Expandido  ...                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0027) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0027) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reg. Expandido  ...'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0028                    */
     /* Pulse ENTER para COPIA.                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0028) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0028) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pulse ENTER para COPIA.'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0029                    */
     /* N° reg.:                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0029) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0029) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'N° reg.:'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0030                    */
     /* Ctl.Compromiso                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0030) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0030) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ctl.Compromiso    '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0031                    */
     /* w/o Ctl.Compromiso                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'w/o Ctl.Compromiso'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0032                    */
     /* (No hay registros)                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(No hay registros)'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0033                    */
     /*     -Encontrar-                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'    -Encontrar-'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0034                    */
     /* Campo                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo'                                                               +
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
     /* Valor (sin comillas)                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor (sin comillas)'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0037                    */
     /* para búsq. genér.)                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'para búsq. genér.)'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0038                    */
     /* Busq. Max. ...:                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Busq. Max. ...:'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0039                    */
     /* Tipo Busq.  ..:                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tipo Busq.  ..:'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0040                    */
     /* (Normal/Subrayado/Reverso/Cla)                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0040) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0040) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(Normal/Subrayado/Reverso/Cla)'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0041                    */
     /* Sensible-Mayus:                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0041) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0041) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sensible-Mayus:'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0042                    */
     /* (1=Sí , 0=No)                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0042) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0042) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(1=Sí , 0=No)'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0043                    */
     /*     - Color  -                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0043) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0043) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'    - Color  -'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0044                    */
     /* -  Selec. Color   -                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0044) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0044) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'-  Selec. Color   -'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0045                    */
     /* Verde                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0045) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0045) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Verde    '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0046                    */
     /* Blanco                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0046) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0046) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Blanco   '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0047                    */
     /* Rojo                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0047) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0047) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Rojo     '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0048                    */
     /* Turquesa                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0048) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0048) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Turquesa '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0049                    */
     /* Amarillo                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0049) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0049) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Amarillo '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0050                    */
     /* Rosa                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0050) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0050) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Rosa     '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0051                    */
     /* Azul                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0051) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0051) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Azul     '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0052                    */
     /*   -Copiar a Fich.-                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0052) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0052) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  -Copiar a Fich.-'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0053                    */
     /* Fichero .........:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0053) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0053) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fichero .........:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0054                    */
     /* Biblioteca.......:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0054) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0054) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Biblioteca.......:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0055                    */
     /* Miembro .........:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0055) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0055) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Miembro .........:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0056                    */
     /* Reemplazar Regs .:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0056) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0056) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reemplazar Regs .:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0057                    */
     /* Crear Archivo ...:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0057) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0057) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Crear Archivo ...:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0058                    */
     /*   - Fecha Licenc.-                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0058) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0058) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  - Fecha Licenc.-'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0059                    */
     /* Licenc.-No:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0059) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0059) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Licenc.-No:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0060                    */
     /* F9=Prueba !                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0060) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0060) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'F9=Prueba !'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0061                    */
     /* Fecha Lic. se ha salvado   !                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0061) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0061) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fecha Lic. se ha salvado   !'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0062                    */
     /* Perdón, ya no queda tiempo        ...                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0062) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0062) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Perdón, ya no queda tiempo        ...'                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0063                    */
     /* Pulse ENTER para CAMBIAR.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0063) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0063) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pulse ENTER para CAMBIAR.'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0064                    */
     /* Pulse ENTER para COPIAR                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0064) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0064) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pulse ENTER para COPIAR'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0065                    */
     /* Pulse ENTER para AÑAD.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0065) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0065) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pulse ENTER para AÑAD.'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0066                    */
     /*    Más  ...                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0066) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0066) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'   Más  ...'                                                         +
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
     /* 80-/132- Modo Caracter                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0069) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0069) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'80-/132- Modo Caracter '                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0070                    */
     /* Motor de Búsq. Avanzado                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0070) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0070) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Motor de Búsq. Avanzado'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0071                    */
     /* Teclado def. por usuario                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0071) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0071) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Teclado def. por usuario    '                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0072                    */
     /* Lenguas def.por usuar.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0072) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0072) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lenguas def.por usuar.'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0073                    */
     /*  El definitivo                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0073) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0073) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' El definitivo '                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0074                    */
     /* navegador de BD                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0074) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0074) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'navegador de BD  '                                                   +
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
     /* Car.no Imprim.                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0076) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0076) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Car.no Imprim.  '                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0077                    */
     /* - Diseño -                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0077) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0077) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Diseño -'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0078                    */
     /* Busqu.:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0078) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0078) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Busqu.:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0079                    */
     /*  O   Sec.   Campo       Descripción                     Tip */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0079) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0079) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O   Sec.   Campo       Descripción                     Tipo       Po-
sIni '                                                                +
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
     /* Color  .:                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0081) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0081) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Color  .:'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0082                    */
     /* Selección :                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0082) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0082) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Selección :'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0083                    */
     /* Max. Ancho:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0083) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0083) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Max. Ancho:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0084                    */
     /* Editcod.:                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0084) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0084) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editcod.:'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0085                    */
     /* - Selec. Campo -                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0085) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0085) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Selec. Campo -'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0086                    */
     /*  O   Campo       Descripción                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0086) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0086) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O   Campo       Descripción                    '                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0087                    */
     /*  O  Fich                   Descripción                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0087) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0087) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O  Fich                   Descripción                               -
   '                                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0088                    */
     /* - Ver Rel. de Base de Datos  -                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0088) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0088) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Ver Rel. de Base de Datos  -'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0089                    */
     /* Dependencias:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0089) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0089) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Dependencias:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0090                    */
     /* Editor-Hex                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0090) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0090) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editor-Hex '                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0091                    */
     /* Campo .......:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0091) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0091) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo .......:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0092                    */
     /* Long.  ......:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0092) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0092) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Long.  ......:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0093                    */
     /* Contenido .:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0093) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0093) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Contenido .:'                                                        +
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
     /* PosInicial ..:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0095) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0095) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'PosInicial ..:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0096                    */
     /* Long.Buffer:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0096) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0096) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Long.Buffer:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0097                    */
     /*  A   Miembro     Descripción                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0097) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0097) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Miembro     Descripción                                        '+
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0098                    */
     /*   - Selecc Mbro   -                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0098) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0098) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  - Selecc Mbro   -   '                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0099                    */
     /* Miembro  :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0099) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0099) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Miembro  :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0100                    */
     /* Mbro..:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mbro..:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0101                    */
     /* - Sobre Peek/400 -                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Sobre Peek/400 -'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0102                    */
     /* Fecha . . .                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0102) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0102) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fecha . . .'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0103                    */
     /* Versión . .                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0103) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0103) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Versión . .'                                                         +
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
     /*  Col Clavadas                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0106) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0106) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Col Clavadas '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0107                    */
     /*  Sec.   Campo       Descripción                      Cpo Cl */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0107) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0107) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Sec.   Campo       Descripción                      Cpo Clave'      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0108                    */
     /* - Selección SQL  -                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0108) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0108) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Selección SQL  -'                                                  +
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
     /* - Crear Prog.Act.    -                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0111) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0111) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Crear Prog.Act.    -'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0112                    */
     /* Minúsculas permitidas?                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0112) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0112) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Minúsculas permitidas?'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0113                    */
     /* Minusc. por defecto?                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0113) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0113) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Minusc. por defecto?  '                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0114                    */
     /* Salvar como default                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0114) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0114) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Salvar como default   '                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0115                    */
     /* Selección SQL                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0115) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0115) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Selección SQL'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0116                    */
     /*    Selecc Entorno                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0116) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0116) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'   Selecc Entorno        '                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0117                    */
     /* Fich :                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0117) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0117) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fich :'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0118                    */
     /* Biblioteca:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0118) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0118) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Biblioteca:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0119                    */
     /*  A   Descripción de Entorno                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0119) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0119) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Descripción de Entorno '                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0120                    */
     /*   Borrar entorno                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0120) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0120) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Borrar entorno       '                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0121                    */
     /* Fich  . . . :                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0121) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0121) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fich  . . . :'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0122                    */
     /* Biblioteca:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0122) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0122) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Biblioteca:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0123                    */
     /* Miembro . . :                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0123) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0123) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Miembro . . :'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0124                    */
     /* Descripción :                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0124) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0124) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Descripción :'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0125                    */
     /* Long.Var.  :                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0125) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0125) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Long.Var.  :'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0126                    */
     /* - Selecc Formato Reg.  -                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0126) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0126) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Selecc Formato Reg.  -'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0127                    */
     /* Valor NULL                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0127) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0127) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor NULL'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0128                    */
     /* Editor Txt                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0128) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0128) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editor Txt '                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0129                    */
     /* *** Reg.Bloqueado ***                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0129) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0129) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'*** Reg.Bloqueado ***'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0130                    */
     /* Reg.Desbloqu.                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0130) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0130) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reg.Desbloqu.  '                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0131                    */
     /* Bloquear Reg para Act.?                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0131) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0131) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bloquear Reg para Act.?'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0132                    */
     /* Fich:                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0132) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0132) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fich: '                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0133                    */
     /*    Bibliot:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0133) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0133) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'   Bibliot:'                                                         +
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
     /*  Pag.:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0135) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0135) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Pag.:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0136                    */
     /* Nombre Cpo                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0136) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0136) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nombre Cpo'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0137                    */
     /* Descripción Campo                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0137) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0137) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Descripción Campo'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0138                    */
     /* Valor Campo                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0138) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0138) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor Campo'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0139                    */
     /* Txt :                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0139) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0139) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Txt :'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0140                    */
     /*  O   Opc  Descripción                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0140) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0140) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O   Opc  Descripción                 '                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0141                    */
     /* ----- Opciones Def Usuario -----                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0141) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0141) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'----- Opciones Def Usuario ----- '                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0142                    */
     /*  O   Fich        Bibliot      Descripción                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0142) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0142) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' O   Fich        Bibliot      Descripción'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0143                    */
     /*  - Selecc Fich  -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' - Selecc Fich  - '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0144                    */
     /* Inic. campos NULL?                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0144) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0144) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Inic. campos NULL?'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0145                    */
     /* Recordar pos. cursor?                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0145) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0145) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Recordar pos. cursor?'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0146                    */
     /* Inserte                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0146) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0146) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Inserte'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0147                    */
     /* Borrar                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0147) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0147) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Borrar'                                                              +
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
     /* Longitud:                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0149) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0149) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Longitud:'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0150                    */
     /* hasta:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0150) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0150) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'hasta:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0151                    */
     /* Pos.del cursor                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0151) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0151) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pos. cursor .:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
     /* Incapaz de recuperar fmto de reg &3 de fich &2/&1.          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Incapaz de recuperar fmto de reg &3 de fich &2/&1.'                  +
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
     /* Incapaz de recuperar lista de fmts de reg de fich &2/&1.    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Incapaz de recuperar lista de fmts de reg de fich &2/&1.'            +
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
     /* Usando control de comprom...                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Usando control de comprom...'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0004                    */
     /* Incapaz de abrir fich usando control de compromiso.         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Incapaz de abrir fich usando control de compromiso.'                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0005                    */
     /* Incapaz de abrir fich &1. Ver joblog.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Incapaz de abrir fich &1. Ver joblog.'                               +
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
     /* Sin información de clave para fich.  &2/&1.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sin información de clave para fich.  &2/&1.'                         +
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
     /* Incapaz de abrir fich &2/&1 para Actualiz. .No se puede cam */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Incapaz de abrir fich &2/&1 para Actualiz. .No se puede cambiar el fi-
chero.      '                                                         +
                ) +
                SECLVL( +
'&N &N Causas posibles: &N &B 1. El depurador se ha iniciado con UPDPR-
OD(*NO). &B 2. El archivo es un archivo JOIN. &B 3. El archivo tiene r-
eglas de integridad referencial pero no se registra por diario. &B 4. -
El archivo tiene desencadenantes pero no se encuentran los programas c-
orrespondientes. &B 5. El archivo es un archivo lógico basado en más d-
e un miembro.'                                                        +
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
     /* Incapaz de situar fich &2/&1                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Incapaz de situar fich &2/&1'                                        +
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
     /* Incapaz de recuperar desc. de objeto de fich. &2/&1.        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Incapaz de recuperar desc. de objeto de fich. &2/&1.'                +
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
     /* Incapaz de situar Bibl. &1.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Incapaz de situar Bibl. &1.'                                         +
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
     /* No se pudo abrir el archivo. Consulte el segundo nivel de ay*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No se pudo abrir el archivo. Consulte el segundo nivel de ayuda o el -
registro del trabajo para obtener más información.'                   +
                ) +
                SECLVL( +
'&N &N Texto error . . :   &1'                                        +
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
     /* Error C-E/S &2: &1                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Error C-E/S &2: &1'                                                  +
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
     /* Ejecutando petición SQL ...                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ejecutando petición SQL ...'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0014                    */
     /* Determinando el número de registros seleccionados ...       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Determinando el número de registros seleccionados ...'               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0143                    */
     /* - Selecc Fichero -                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Selecc Fichero -'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR1000                    */
     /* Access no permitido para fich &2/&1, mbr &3.                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR1000) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR1000) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Access no permitido para fich &2/&1, mbr &3.'                        +
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
     /* Cancel por usr usando &1.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cancel por usr usando &1.'                                           +
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
     /* Un momento. Permanezca atento..                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Un momento. Permanezca atento..'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8102                    */
     /* Apunte al reg. y reintente                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8102) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8102) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Apunte al reg. y reintente'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8103                    */
     /* Incapaz de cerr.fich.                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8103) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8103) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Incapaz de cerr.fich.'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8104                    */
     /* Recuperando descr. de campo de fich. &2/&1.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8104) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8104) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Recuperando descr. de campo de fich. &2/&1.'                         +
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
     /* Recuperando lista de fmtos de reg de fich &2/&1.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8105) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8105) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Recuperando lista de fmtos de reg de fich &2/&1.'                    +
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
     /* Recuperando atributos de red.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8106) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8106) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Recuperando atributos de red.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8107                    */
     /* Recuperando atributos de objeto &2/&1.                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8107) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8107) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Recuperando atributos de objeto &2/&1.'                              +
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
     /* No encuentro campo '&1' en fich &3/&2.                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8108) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8108) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No encuentro campo ''&1'' en fich &3/&2.'                            +
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
     /* Recuperando descripción de mimbro &3 de fich &2/&1.         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8109) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8109) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Recuperando descripción de mimbro &3 de fich &2/&1.'                 +
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
     /* Opción '&1' no válida.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8110) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8110) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Opción ''&1'' no válida.'                                            +
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
     /* Sí a todo.                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8111) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8111) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sí a todo.'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8112                    */
     /* Mdato aceptado.                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8112) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8112) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mdato aceptado.  '                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8113                    */
     /* Mdato interno &1 no válido.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8113) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8113) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mdato interno &1 no válido.'                                         +
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
     /* Creando Programa-RPG ...                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8114) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8114) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Creando Programa-RPG ...'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8115                    */
     /* Inicio de reg.                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8115) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8115) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Inicio de reg.  '                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8116                    */
     /* Fin of reg.                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8116) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8116) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fin of reg.   '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8117                    */
     /* Apunte a la columna y reintente.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8117) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8117) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Apunte a la columna y reintente.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8118                    */
     /* Pin-Array llena.                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8118) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8118) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pin-Array llena.'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8119                    */
     /* Registro ya clavado.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8119) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8119) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Registro ya clavado.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8120                    */
     /* No encuentro el reg.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8120) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8120) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No encuentro el reg.  '                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8121                    */
     /* Reg. sin clavar.                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8121) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8121) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reg. sin clavar.'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8122                    */
     /* Mandato no válido.                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8122) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8122) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mandato no válido.    '                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8123                    */
     /* Campos mayores de 1024 no se pueden &1cambiar&2.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8123) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8123) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campos mayores de 1024 no se pueden &1cambiar&2.'                    +
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
     /* Oper.   '&1' no válido.                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8124) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8124) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Oper.   ''&1'' no válido.'                                           +
                ) +
                SECLVL( +
'&N &B Los operandos válidos son: &N &P EQ   - igual &P NE   - distint-
o &P LT   - menor &P GT   - mayor &P LE   - menor/igual &P GE   - mayo-
r/igual &P LIKE - similar'                                            +
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
     /* Valor no válido para número de regs. a buscar.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8125) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8125) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor no válido para número de regs. a buscar.'                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8126                    */
     /* Tipo de busq invalido. '&1'                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8126) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8126) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tipo de busq invalido. ''&1'''                                       +
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
     /* Buscando  ...                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8127) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8127) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Buscando  ...'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8128                    */
     /* Buscando. &1 de &2 regs buscados.                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8128) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8128) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Buscando. &1 de &2 regs buscados.'                                   +
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
     /* Campo '&1' de tipo '&2' no válido                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8129) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8129) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo ''&1'' de tipo ''&2'' no válido'                               +
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
     /* Ref. hallado. 'SEARCH'=continua/'ENTER'=Cancel.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8130) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8130) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ref. hallado. ''SEARCH''=continua/''ENTER''=Cancel.'                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8131                    */
     /* Fin de fich - cad. no hallada. 'SEARCH'=continua/'ENTER'=Ca */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8131) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8131) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fin de fich - cad. no hallada. ''SEARCH''=continua/''ENTER''=Cancel.'+
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8132                    */
     /* Maximo de regs buscadnos. 'SEARCH'=continua/'ENTER'=Cancel. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8132) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8132) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Maximo de regs buscadnos. ''SEARCH''=continua/''ENTER''=Cancel.'     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8133                    */
     /* 1=Sensible Mayus; 0=No Sensible Mayus                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8133) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8133) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=Sensible Mayus; 0=No Sensible Mayus'                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8134                    */
     /* Combinación de operando &1 cpo &2 no válida                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8134) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8134) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Combinación de operando &1 cpo &2 no válida'                         +
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
     /* Operando &1 no válido con campo tipo &2.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8135) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8135) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Operando &1 no válido con campo tipo &2.'                            +
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
     /* Campo '&1' no hallado                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8136) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8136) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo ''&1'' no hallado'                                             +
                ) +
                SECLVL( +
'&N &B Valores especiales: &N &P *RECORD - Buscar en todo el registro.-
'                                                                     +
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
     /* Recuperando inf. de clave de fich. &2/&1.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8137) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8137) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Recuperando inf. de clave de fich. &2/&1.'                           +
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
     /* Campo &1 tiene datos decim. no válidos                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8138) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8138) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo &1 tiene datos decim. no válidos'                              +
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
     /* No puedo situar subfichero.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8139) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8139) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No puedo situar subfichero.'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8140                    */
     /* Introduzca argumento de búsqueda.                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8140) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8140) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Introduzca argumento de búsqueda.'                                   +
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
     /* Use '&1' para signo positivo y '&2' para signo negativo.    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8141) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8141) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Use ''&1'' para signo positivo y ''&2'' para signo negativo.'        +
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
     /* Posición &1 se reserva para signo de valores numéricos.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8142) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8142) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Posición &1 se reserva para signo de valores numéricos.'             +
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
     /* No hay función de programa para tecla &1                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No hay función de programa para tecla &1'                            +
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
     /* Imposible ejecucion recursiva para el mandato &1.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8144) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8144) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Imposible ejecucion recursiva para el mandato &1.'                   +
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
     /* Subfichero vacío. Imposible ejecutar mdato.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8145) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8145) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Subfichero vacío. Imposible ejecutar mdato.'                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8146                    */
     /* No puedo definir color para campo selecc.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8146) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8146) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No puedo definir color para campo selecc.'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8147                    */
     /* Columna &1 sin clavar.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8147) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8147) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Columna &1 sin clavar.'                                              +
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
     /* Sin espacio para col clavada '&1'.                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8148) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8148) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sin espacio para col clavada ''&1''.'                                +
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
     /* Líneas coloreadas ya activas.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8149) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8149) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Líneas coloreadas ya activas.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8150                    */
     /* Líneas B/N ya activas.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8150) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8150) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Líneas B/N ya activas.'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8151                    */
     /* nombre inval. para fich.dest '&1'.                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8151) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8151) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'nombre inval. para fich.dest ''&1''.'                                +
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
     /* Nombre inválido para lib. dest '&1'.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8152) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8152) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nombre inválido para lib. dest ''&1''.'                              +
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
     /* Nombre invalido para mbro dest '&1'.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8153) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8153) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nombre invalido para mbro dest ''&1''.'                              +
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
     /* Parám. invalid '&1' para ADD/REPLACE.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8154) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8154) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Parám. invalid ''&1'' para ADD/REPLACE.'                             +
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
     /* Param. inválido  '&1' para CREATE FILE.                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8155) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8155) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Param. inválido  ''&1'' para CREATE FILE.'                           +
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
     /* Ejecución falló.                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8156) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8156) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ejecución falló.'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8157                    */
     /* Recuperando val. de sist.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8157) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8157) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Recuperando val. de sist.'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8158                    */
     /* No.de lic inv-No. '&1'.                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8158) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8158) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No.de lic inv-No. ''&1''.'                                           +
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
     /* No puedo salvar datos de lic                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8159) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8159) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No puedo salvar datos de lic'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8160                    */
     /* fich. de definicíon de lenguaje &1 no disponible.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8160) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8160) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'fich. de definicíon de lenguaje &1 no disponible.'                   +
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
     /* SPLASH-Pant.Habilitada                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8161) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8161) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SPLASH-Pant.Habilitada'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8162                    */
     /* SPLASH-Pant.Deshabilit.                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8162) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8162) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SPLASH-Pant.Deshabilit.'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8163                    */
     /* Cadena tiene caracteres menores que  x'40' o iguales a 'FF' */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8163) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8163) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cadena tiene caracteres menores que  x''40'' o iguales a ''FF''. Sust-
 con: &1'                                                             +
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
     /* Campos con caract. no imprimibles se han escondidos.        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8164) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8164) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campos con caract. no imprimibles se han escondidos.'                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8165                    */
     /* introduzca opción antes de elegir "REPETIR".                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8165) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8165) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'introduzca opción antes de elegir "REPETIR".'                        +
                ) +
                SECLVL( +
'Causa . . . . . . : Se ha pulsado F13 (Repetir), pero en esta página -
no se ha seleccionado ninguna función para repetir. &N Recuperación  .-
 . : Indique una opción en la columna de opciones de esta página y vue-
lva a pulsar "REPETIR".'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8166                    */
     /* No puedo ejecutar función. Fichero no abierto !             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8166) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8166) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No puedo ejecutar función. Fichero no abierto !'                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8167                    */
     /* Num. de sec. debe ser único.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8167) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8167) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Num. de sec. debe ser único.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8168                    */
     /* Valor &1 no permitido para atr. "visible/unvisible".        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8168) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8168) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor &1 no permitido para atr. "visible/unvisible".'                +
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
     /* Valor &1 no permitido para atr. "Marcar columna".           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8169) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8169) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor &1 no permitido para atr. "Marcar columna".'                   +
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
     /* Valor &1 no permitido para atr. "Tamaño.Max".               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8170) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8170) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor &1 no permitido para atr. "Tamaño.Max".'                       +
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
     /* Valor Inválido '&1' for time-, date- o timestamp            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8171) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8171) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor Inválido ''&1'' for time-, date- o timestamp'                  +
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
     /* Procesando: &1                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8172) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8172) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Procesando: &1'                                                      +
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
     /* PEEK no soporta llamada recursiva.                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8173) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8173) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'PEEK no soporta llamada recursiva.'                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8174                    */
     /* Caracter (&1) no permitido en cadena hex                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8174) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8174) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Caracter (&1) no permitido en cadena hex'                            +
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
     /* No se permite entrar un número impar de caracteres.         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8175) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8175) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No se permite entrar un número impar de caracteres.'                 +
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
     /* Aviso: Cadena muy larga                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8176) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8176) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Aviso: Cadena muy larga'                                             +
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
     /* PosIniciañ excede long. de campo.                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8177) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8177) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'PosIniciañ excede long. de campo.'                                   +
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
     /* No entre una pos. inic. menor o igual que null.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8178) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8178) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No entre una pos. inic. menor o igual que null.'                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8179                    */
     /* No prompt disponible                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8179) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8179) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No prompt disponible'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8180                    */
     /* Mbro '&1' no hallado                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8180) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8180) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mbro ''&1'' no hallado'                                              +
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
     /* No puedo salvar entorno. Falta nombre de fich.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8181) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8181) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No puedo salvar entorno. Falta nombre de fich.'                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8182                    */
     /* Valor &1 no válido como nombre para obj. AS/400.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8182) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8182) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor &1 no válido como nombre para obj. AS/400.'                    +
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
     /* Falta alguna información.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8183) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8183) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Falta alguna información.'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8184                    */
     /* Esta función no se ha habilitado. Contacte con administrado */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8184) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8184) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Esta función no se ha habilitado. Contacte con administrador.'       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8185                    */
     /* Sin entorno especifocado. No se abrió entorno.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8185) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8185) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sin entorno especifocado. No se abrió entorno.'                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8186                    */
     /* Aviso: Cadena muy corta                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8186) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8186) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Aviso: Cadena muy corta'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8187                    */
     /* Long.de campo excede tamaño de buffer d cpo                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8187) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8187) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Long.de campo excede tamaño de buffer d cpo'                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8188                    */
     /* Crear Fich. de Pant. Fase: &1, Campo: &2                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8188) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8188) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Crear Fich. de Pant. Fase: &1, Campo: &2'                            +
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
     /* Crear Programa RPG. Fase: &1, Campo: &2                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8189) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8189) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Crear Programa RPG. Fase: &1, Campo: &2'                             +
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
     /* Petic.respondida por &1                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8190) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8190) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Petic.respondida por &1'                                             +
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
     /* Campo &1 no puede ser NULL.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8191) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8191) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo &1 no puede ser NULL.'                                         +
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
     /* Campo &1 tiene datos flot.no válidos.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8192) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8192) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo &1 tiene datos flot.no válidos.'                               +
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
     /* Campo '&1' tiene caracter no imprimible yno se puede editar */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8193) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8193) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo ''&1'' tiene caracter no imprimible yno se puede editar con edi-
tor de textos.'                                                       +
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
     /* Fich '&1' no halla.                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8194) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8194) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fich ''&1'' no halla.'                                               +
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
     /* Petición ilegal. Cpo protegido.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8195) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8195) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Petición ilegal. Cpo protegido.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8196                    */
     /* El campo &1 no se puede mostrar ni modificar.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8196) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8196) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'El campo &1 no se puede mostrar ni modificar.'                       +
                ) +
                SECLVL( +
'&N &N Causas posibles: &N &B 1. Tipo de datos desconocido. &B 2. Camp-
o gráfico sin CCSID. &B 3. Campo packed o zoned con más de 30 dígitos.-
 &B 4. Campo de longitud variable de tipo desconocido.'               +
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
     /* No puedo borrar registro &1                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8200) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8200) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No puedo borrar registro &1'                                         +
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
     /* Registro &1 se ha borrado                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8201) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8201) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Registro &1 se ha borrado'                                           +
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
     /* No puedo copiar reg. &1.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8202) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8202) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No puedo copiar reg. &1.'                                            +
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
     /* Reg &1 ha sido copiado.                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8203) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8203) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reg &1 ha sido copiado.'                                             +
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
     /* Reg de subarch no válido                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8204) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8204) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reg de subarch no válido'                                            +
                ) +
                SECLVL( +
'&N &N Sitúe el cursor sobre el registro deseado y repita la petición.-
'                                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8205                    */
     /* Atención: No es posible clavar más de &1 columnas!          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8205) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8205) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Atención: No es posible clavar más de &1 columnas!'                  +
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
     /* No puedo ver registro. Long. de reg. excede maximo de &1 by */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8206) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8206) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No puedo ver registro. Long. de reg. excede maximo de &1 bytes.'     +
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
     /* No se puede abrir fichero porque su longitud de registro es */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8207) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8207) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No se puede abrir fichero porque su longitud de registro es mayor que-
 &1.'                                                                 +
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
     /* No puedes cambiar ficheros de solo entrada.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8208) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8208) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No puedes cambiar ficheros de solo entrada.'                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8209                    */
     /* Entre un argumento de búsqueda.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8209) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8209) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Entre un argumento de búsqueda.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8210                    */
     /* Error SQL &1. &2                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8210) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8210) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Error SQL &1. &2'                                                    +
                ) +
                SECLVL( +
'&N &N Motivo  . . . . :   &2 &N &B Encontrará más información sobre e-
ste código de error en el manual de programación SQL o en el archivo d-
e mensajes QSYS/QSQLMSG.'                                             +
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
     /* Coloque el cursor sobre un campo u reinicie su petición de  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8211) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8211) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Coloque el cursor sobre un campo u reinicie su petición de nuevo'    +
                ) +
                SECLVL( +
'Motivo  . . . . :   El cursor está fuera de un campo o el campo no es-
 válido para esta petición.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8212                    */
     /* La selección SQL solo puede usarse con ficheros físicos. ¿Ab*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8212) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8212) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La selección SQL solo puede usarse con ficheros físicos. ¿Abrir fiche-
ro físico?'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8213                    */
     /* 1=salvar; 0=No salvar                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8213) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8213) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=salvar; 0=No salvar'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8214                    */
     /* 1=Habilita Minus; 0=Solo Mayus                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8214) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8214) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=Habilita Minus; 0=Solo Mayus'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8215                    */
     /* No se permiten Minúsculas.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8215) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8215) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No se permiten Minúsculas.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8216                    */
     /* Valores no casan unos con otros.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8216) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8216) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valores no casan unos con otros.'                                    +
                ) +
                SECLVL( +
'Si no desea permitir que el usuario introduzca minúsculas, no puede e-
stablecer esto como valor por omisión.'                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8217                    */
     /* Imposible Clas. por RRN                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8217) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8217) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Imposible Clas. por RRN'                                             +
                ) +
                SECLVL( +
'No es posible abrir el archivo para una secuencia por RRN, ya que el -
archivo se basa en más de un miembro.'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8218                    */
     /* No puedo clavar registro, porque el lógico se basa en múlti */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8218) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8218) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No puedo clavar registro, porque el lógico se basa en múltiples miemb-
ros físicos.'                                                         +
                ) +
                SECLVL( +
'&N &N Causa . . . . . :   No se puede clavar el registro porque el nú-
mero relativo de registro no es único y no se puede determinar el miem-
bro físico que lo contiene.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8219                    */
     /* Valor '&1' no válido para sel. Sí/No.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8219) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8219) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor ''&1'' no válido para sel. Sí/No.'                             +
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
     /* Editor no permitido. Campo &1 es NULL                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8220) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8220) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editor no permitido. Campo &1 es NULL'                               +
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
     /* Editor no soporta el tipo de datos de cpo &1.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8221) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8221) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editor no soporta el tipo de datos de cpo &1.'                       +
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
     /* Campo &1 excede long. máxima permitida para editor.         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8222) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8222) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo &1 excede long. máxima permitida para editor.'                 +
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
     /* Campo de clave cambiado a minúsculas.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8223) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8223) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo de clave cambiado a minúsculas.'                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8224                    */
     /* Campo de clave cambiado a mayúsculas.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8224) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8224) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo de clave cambiado a mayúsculas.'                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8225                    */
     /* Registro cambiado por otro usuario. ¿Actualizar de todos mod*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8225) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8225) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Registro cambiado por otro usuario.&N&N¿Actualizar de todos modos?'  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8226                    */
     /* Operación de impresión acabó con éxito.                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8226) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8226) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Operación de impresión acabó con éxito.'                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8227                    */
     /* Error al convertir '&1' a valor numérico                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8227) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8227) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Error al convertir ''&1'' a valor numérico'                          +
                ) +
                SECLVL( +
'&N &N Información . . :   Se ha producido un error al convertir ''&1'-
' en un valor numérico. La cadena no se pudo convertir en un valor num-
érico de &2(&3,&4).'                                                  +
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
     /* Entr.Inv de tipo de dato: '&1'                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8228) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8228) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Entr.Inv de tipo de dato: ''&1'''                                    +
                ) +
                SECLVL( +
'&N &N Información . . :   El tipo de datos indicado ''&1'' no es váli-
do. Indique un tipo de datos RPG válido y repita la petición.'        +
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
     /* Entr.de long de cpo no val: '&1'.                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8229) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8229) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Entr.de long de cpo no val: ''&1''.'                                 +
                ) +
                SECLVL( +
'&N &N Información . . :   La longitud de campo indicada ''&1'' no es -
válida. Corrija la longitud de campo y repita la petición.'           +
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
     /* Número inválido de pos. decimales: '&1'.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8230) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8230) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Número inválido de pos. decimales: ''&1''.'                          +
                ) +
                SECLVL( +
'&N &N Información . . :   El número de posiciones decimales indicado -
''&1'' no es válido. Corrija el número de posiciones decimales y repit-
a la petición. Tenga en cuenta que no todos los tipos de datos, como '-
'A'' para cadenas, requieren posiciones decimales.'                   +
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
     /* No puedo cambiar Bloq.reg. por 'copy' o 'add'.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8231) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8231) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No puedo cambiar Bloq.reg. por ''copy'' o ''add''.'                  +
                ) +
                SECLVL( +
'&N &N Información . . :   No se puede cambiar el estado actual del bl-
oqueo de registro. El bloqueo solo se puede cambiar al modificar un re-
gistro, no al copiar o añadir uno.'                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8232                    */
     /* Registro cambiado por otro usuario. ¿Bloquear de todos modos*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8232) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8232) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Registro cambiado por otro usuario.&N&N¿Bloquear de todos modos?'    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8233                    */
     /* Error: no se puede usar el diseño. Los ID de formato de regi*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8233) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8233) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Error: no se puede usar el diseño. Los ID de formato de registro difi-
eren.'                                                                +
                ) +
                SECLVL( +
'&N &N Recuperación  . :   Elimine el registro *RCDFMTID del archivo &-
2/&1, miembro &3, para desactivar la comprobación de nivel y vuelva a -
aplicar el diseño. Si funciona, guarde el diseño para añadir el ID de -
nivel de formato de registro.'                                        +
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
     /* No se pudo cargar el diseño porque los ID de nivel de format*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8234) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8234) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No se pudo cargar el diseño porque los ID de nivel de formato de regi-
stro no coinciden.'                                                   +
                ) +
                SECLVL( +
'&N &N Causa . . . . . :   No se pudo cargar el diseño indicado desde -
el archivo de entorno, porque el ID de nivel de formato de registro de-
l diseño no coincide con el del archivo indicado.&N Recuperación  . : -
  Elimine el registro *RCDFMTID del archivo &2/&1, miembro &3, para de-
sactivar la comprobación de nivel y vuelva a aplicar el diseño. Si fun-
ciona, guarde el diseño para añadir el ID de nivel de formato de regis-
tro.'                                                                 +
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
     /* La selección SQL no está soportada para archivos lógicos de */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8235) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8235) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La selección SQL no está soportada para archivos lógicos de varios mi-
embros.'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8236                    */
     /* Modo de inserción activado. Coloque el cursor y luego presi */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8236) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8236) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Modo de inserción activado. Coloque el cursor y luego presione F7.'  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8237                    */
     /* Pulse Intro para insertar el número de espacios especificad */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8237) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8237) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pulse Intro para insertar el número de espacios especificado.'       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8238                    */
     /* Modo de borrar activado. Coloque el cursor y luego presione */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8238) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8238) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Modo de borrar activado. Coloque el cursor y luego presione F8.'     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8239                    */
     /* Pulse Intro para borrar el intervalo de     caracteres espe */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8239) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8239) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pulse Intro para borrar el intervalo de     caracteres especificado.'+
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8240                    */
     /* No debe ser inferior a &1.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8240) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8240) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No debe ser inferior a &1.'                                          +
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
     /* Longitud de campo superada. El valor excede en &1 caracteres*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8241) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8241) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Longitud de campo superada. El valor excede en &1 caracteres.'       +
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
     /* Valor de fecha, hora o indicación de fecha y hora no válido*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8242) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8242) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor de fecha, hora o indicación de fecha y hora no válido en el cam-
po &1.'                                                               +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8243                    */
     /* Valor &1 no permitido para atr. "Código edic.".             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8243) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8243) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valor &1 no permitido para atr. "Código edic.".'                     +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 1) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9992                    */
     /* No se pudieron guardar los ajustes del usuario.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9992) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9992) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No se pudieron guardar los ajustes del usuario.'                     +
                ) +
                SECLVL( +
'&N &N Causa . . . . . :   No se pudieron guardar los ajustes del usua-
rio debido al código de error &1. &N &N Los códigos de error posibles -
son: &N &B 1 - El nombre del archivo (&2) no coincide con el archivo a-
bierto. &B 2 - El nombre de la biblioteca (&2) no coincide con la bibl-
ioteca del archivo abierto. &B 3 - No se pudo abrir el archivo de ajus-
tes del usuario &3/&2 con el miembro &4.'                             +
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
     /* No se abrió el fichero. El uso de SQL es posible solo para  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9993) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9993) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'No se abrió el fichero. El uso de SQL es posible solo para archivos f-
ísicos.'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9994                    */
     /* Error inesperado &1 en proced. C &2.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9994) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9994) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Error inesperado &1 en proced. C &2.'                                +
                ) +
                SECLVL( +
'&N &N Descripción . . :   &3'                                        +
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
     /* Cambiando fmt de reg. del fich de config...                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9995) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9995) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cambiando fmt de reg. del fich de config...'                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9996                    */
     /* Fich no abierto                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9996) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9996) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fich no abierto'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9997                    */
     /* &2PEEK/400 es&1 Shareware. &2Registre su copia.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9997) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9997) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'&2PEEK/400 es&1 Shareware. &2Registre su copia.'                     +
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
     /* id de msg inesperado &1 recivido de programa &2.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9998) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9998) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'id de msg inesperado &1 recivido de programa &2.'                    +
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
