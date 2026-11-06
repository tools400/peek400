     /*-----------------------------------------------------------------------*/
     /* Hinweis: Dieses CL muss in einem Job mit der Sprache der              */
     /*          Zielnachrichtendatei kompiliert und ausgeführt werden.       */
     /*-----------------------------------------------------------------------*/
     /* STRPREPRC Compile Options:                                            */
     /* >>PRE-COMPILER<<                                                      */
     /*   >>CRTCMD<<  CALL       PGM(QTEMP/&OB) PARM(&LI);                    */
     /*   >>CMD<<     CHGJOB  LANGID(DEU) CNTRYID(DE) CCSID(1141);            */
     /*   >>CMD<<     CRTCLPGM   PGM(QTEMP/&OB) +                             */
     /*                          SRCFILE(&SL/&SF) SRCMBR(&SM) +               */
     /*               TEXT('Peek/400 - Deutsch');                             */
     /*   >>EXECUTE<<                                                         */
     /*   >>CMD<<     DLTPGM PGM(QTEMP/&OB);                                  */
     /*   >>CMD<<     CHGJOB  LANGID(DEU) CNTRYID(DE) CCSID(273);             */
     /* >>END-PRE-COMPILER<<                                                  */
     /*-----------------------------------------------------------------------*/
             PGM        PARM(&I_LIB)

             DCL        VAR(&I_LIB     ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&I_OBJ     ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&LIB       ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OBJ       ) TYPE(*CHAR) LEN(10)  VALUE('PEEKGER')
             DCL        VAR(&CCSID     ) TYPE(*DEC ) LEN(5 0) VALUE(1141)
             DCL        VAR(&LANGUAGE  ) TYPE(*CHAR) LEN(20)  VALUE('Deutsch')

             CHGVAR     VAR(&LIB       ) VALUE(&I_LIB)
             MONMSG     MSGID(MCH3601) EXEC(DO)
               RMVMSG     PGMQ(*SAME (*)) CLEAR(*ALL)
               SNDPGMMSG  MSGID(CPF9898) MSGF(*LIBL/QCPFMSG) +
                            MSGDTA('Usage: CALL PGM(PEEKGERMG) PARM(libName)') +
                            TOPGMQ(*PRV (*PGMBDY)) MSGTYPE(*ESCAPE)
             ENDDO

             DLTMSGF    MSGF(&LIB/&OBJ)
             MONMSG     MSGID(CPF2105) /* Object not found */

             CRTMSGF MSGF(&LIB/&OBJ ) TEXT('Peek/400 - ' *CAT &LANGUAGE)

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BA                    */
     /* Funktionstaste F22 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BA) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BA) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F22 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BB                    */
     /* Funktionstaste F23 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BB) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BB) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F23 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BC                    */
     /* Funktionstaste F24 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BC) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BC) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F24 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BD                    */
     /* Taste 'LÖSCHEN' nicht gültig                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BD) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BD) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Taste ''LÖSCHEN'' nicht gültig'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B1                    */
     /* Funktionstaste F13 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B1) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B1) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F13 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B2                    */
     /* Funktionstaste F14 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B2) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B2) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F14 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B3                    */
     /* Funktionstaste F15 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B3) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B3) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F15 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B4                    */
     /* Funktionstaste F16 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B4) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B4) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F16 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B5                    */
     /* Funktionstaste F17 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B5) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B5) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F17 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B6                    */
     /* Funktionstaste F18 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B6) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B6) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F18 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B7                    */
     /* Funktionstaste F19 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B7) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B7) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F19 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B8                    */
     /* Funktionstaste F20 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B8) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B8) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F20 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B9                    */
     /* Funktionstaste F21 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B9) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B9) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F21 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F1                    */
     /* Taste 'DATENFREIGABE' nicht gültig                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F1) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F1) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Taste ''DATENFREIGABE'' nicht gültig'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F3                    */
     /* Taste 'HILFE' nicht gültig                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F3) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F3) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Taste ''HILFE'' nicht gültig'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F4                    */
     /* Taste 'BILD RUNTER' nicht gültig                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F4) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F4) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Taste ''BILD RUNTER'' nicht gültig'                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F5                    */
     /* Taste 'BILD HOCH' nicht gültig                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F5) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F5) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Taste ''BILD HOCH'' nicht gültig'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F6                    */
     /* Taste 'DRUCKEN' nicht gültig                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F6) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F6) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Taste ''DRUCKEN'' nicht gültig'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F8                    */
     /* Taste 'GRUNDSTELLUNG' nicht gültig                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F8) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F8) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Taste ''GRUNDSTELLUNG'' nicht gültig'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003A                    */
     /* Funktionstaste F10 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003A) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003A) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F10 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003B                    */
     /* Funktionstaste F11 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003B) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003B) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F11 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003C                    */
     /* Funktionstaste F12 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003C) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003C) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F12 nicht gültig.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003F                    */
     /* Taste 'LICHTGRIFFEL' nicht gültig                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003F) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003F) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Taste ''LICHTGRIFFEL'' nicht gültig'                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0031                    */
     /* Funktionstaste F1 nicht gültig.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F1 nicht gültig.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0032                    */
     /* Funktionstaste F2 nicht gültig.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F2 nicht gültig.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0033                    */
     /* Funktionstaste F3 nicht gültig.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F3 nicht gültig.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0034                    */
     /* Funktionstaste F4 nicht gültig.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F4 nicht gültig.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0035                    */
     /* Funktionstaste F5 nicht gültig.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F5 nicht gültig.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0036                    */
     /* Funktionstaste F6 nicht gültig.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F6 nicht gültig.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0037                    */
     /* Funktionstaste F7 nicht gültig.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F7 nicht gültig.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0038                    */
     /* Funktionstaste F8 nicht gültig.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F8 nicht gültig.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0039                    */
     /* Funktionstaste F9 nicht gültig.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste F9 nicht gültig.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0100                    */
     /* Unbekannte und nicht zulässige Taste                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unbekannte und nicht zulässige Taste'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0001                    */
     /* Datenfreigabe                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datenfreigabe     '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0002                    */
     /* Beenden                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Beenden           '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0003                    */
     /* Aktualisieren                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Aktualisieren     '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0004                    */
     /* Neuanlage                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Neuanlage         '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0005                    */
     /* Überschrift                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Überschrift       '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0006                    */
     /* Spalte mark.+/-                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Spalte mark.+/-   '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0007                    */
     /* Nach oben zieh.                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nach oben zieh.   '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0008                    */
     /* Cursor pos.                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cursor pos.       '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0009                    */
     /* Suchen                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Suchen            '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0010                    */
     /* Anfang                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Anfang            '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0011                    */
     /* Ende                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ende              '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0012                    */
     /* Links                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Links             '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0013                    */
     /* Rechts                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Rechts            '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0014                    */
     /* Befehlszeile                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Befehlszeile      '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0015                    */
     /* 80/132 Zeichen                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0015) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0015) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'80/132 Zeichen    '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0016                    */
     /* Weitere Tasten                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Weitere Tasten    '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0017                    */
     /* Bild runter                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bild runter       '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0018                    */
     /* Bild hoch                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bild hoch         '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0019                    */
     /* Pin-Zeile                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pin-Zeile         '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0020                    */
     /* UnPin-Zeile                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0020) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0020) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'UnPin-Zeile       '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0021                    */
     /* Ändern                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0021) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0021) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ändern            '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0022                    */
     /* Kopieren                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0022) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0022) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Kopieren          '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0023                    */
     /* Löschen                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0023) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0023) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Löschen           '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0024                    */
     /* Anzeigen                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0024) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0024) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Anzeigen          '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0025                    */
     /* Einstellungen                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0025) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0025) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Einstellungen'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0026                    */
     /* Abbrechen                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0026) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0026) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Abbrechen'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0027                    */
     /* Sich. & Ende                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0027) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0027) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sich. & Ende'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0028                    */
     /* Pin-Spalte                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0028) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0028) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pin-Spalte'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0029                    */
     /* UnPin-Spalte                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0029) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0029) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'UnPin-Spalte'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0030                    */
     /* Pin-Spalte +/-                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0030) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0030) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pin-Spalte +/-'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0031                    */
     /* Tab.Papier Ein                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tab.Papier Ein'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0032                    */
     /* Tab.Papier aus                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tab.Papier aus'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0033                    */
     /* Tab.Papier +/-                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tab.Papier +/-'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0034                    */
     /* Alle Datensätze                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Alle Datensätze'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0035                    */
     /* Weitere Ausw.                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Weitere Ausw.'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0036                    */
     /* ext. Kopieren                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'ext. Kopieren'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0037                    */
     /* Spalte mark.                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Spalte mark.'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0038                    */
     /* Splt.Mark.aufh.                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Splt.Mark.aufh.'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0039                    */
     /* Kleinbuchstaben                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Kleinbuchstaben'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0040                    */
     /* Großbuchstaben                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0040) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0040) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Großbuchstaben'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0041                    */
     /* Klein/Großb.+/-                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0041) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0041) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Klein/Großb.+/-'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0042                    */
     /* Splash-Ein                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0042) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0042) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Splash-Ein'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0043                    */
     /* Splash-Aus                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0043) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0043) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Splash-Aus'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0044                    */
     /* Seite links                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0044) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0044) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Seite links'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0045                    */
     /* Seite rechts                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0045) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0045) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Seite rechts'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0046                    */
     /* Wiederholen                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0046) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0046) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wiederholen'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0047                    */
     /* Neuerstellung                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0047) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0047) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Neuerstellung'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0048                    */
     /* UnPin Zeilen                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0048) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0048) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'UnPin Zeilen'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0049                    */
     /* UnPin Spalten                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0049) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0049) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'UnPin Spalten'                                                       +
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
     /* Key-Felder                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0051) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0051) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Key-Felder'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0052                    */
     /* Auswahl                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0052) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0052) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Auswahl'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0053                    */
     /* Nächste Mark.                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0053) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0053) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nächste Mark.'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0054                    */
     /* Vorherige Mark.                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0054) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0054) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Vorherige Mark.'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0055                    */
     /* Relationen                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0055) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0055) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Relationen'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0056                    */
     /* Bedienerführung                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0056) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0056) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bedienerführung'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0057                    */
     /* Schlüsselfolge                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0057) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0057) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Schlüsselfolge'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0058                    */
     /* Satzfolge                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0058) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0058) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Satzfolge'                                                           +
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
     /* Info                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0061) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0061) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Info'                                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0062                    */
     /* Spalten pinnen                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0062) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0062) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Spalten pinnen'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0063                    */
     /* Alles Löschen                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0063) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0063) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Alles Löschen'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0064                    */
     /* Norm. Anzeige                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0064) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0064) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Norm. Anzeige'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0065                    */
     /* Hex-Anzeige                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0065) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0065) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Hex-Anzeige'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0066                    */
     /* Umsch.Anzeige                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0066) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0066) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Umsch.Anzeige'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0067                    */
     /* SQL-Auswahl                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0067) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0067) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL-Auswahl'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0068                    */
     /* Einf.Schl.Fld.                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0068) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0068) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Einf.Schl.Fld.'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0069                    */
     /* Sichern Arb.Umg                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0069) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0069) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sichern Arb.Umg'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0070                    */
     /* Laden Arb.Umg                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0070) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0070) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Laden Arb.Umg'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0071                    */
     /* Löschen Arb.Umg                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0071) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0071) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Löschen Arb.Umg'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0072                    */
     /* Sortierfolge                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0072) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0072) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sortierfolge'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0073                    */
     /* Ja                                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0073) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0073) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ja'                                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0074                    */
     /* Nein                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0074) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0074) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nein'                                                                +
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
     /* Anfang                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0076) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0076) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Anfang'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0077                    */
     /* Ende                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0077) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0077) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ende'                                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0078                    */
     /* Umgebung                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0078) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0078) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Umgebung'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0079                    */
     /* nur Layout                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0079) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0079) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'nur Layout'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0080                    */
     /* Umsch. NULL-Ind.                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0080) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0080) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Umsch. NULL-Ind.'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0081                    */
     /* Umsch. Eingabe                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0081) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0081) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Umsch. Eingabe'                                                      +
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
     /* Satzsperre                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0083) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0083) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Satzsperre'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0084                    */
     /* Aufsetzen Kleinb.                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0084) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0084) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Aufsetzen Kleinb.'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0085                    */
     /* Drucken                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0085) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0085) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Drucken'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0086                    */
     /* Einfügen                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0086) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0086) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Einfügen'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0087                    */
     /* Löschen                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0087) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0087) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Löschen'                                                             +
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
     /* Frage                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(MBX0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(MBX0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Frage'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0001                    */
     /* Datei                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0002                    */
     /* Teildatei                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Teildatei'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0003                    */
     /* Zugriffsart                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Zugriffsart'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0004                    */
     /* Sprache                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sprache'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0005                    */
     /* Ändern Bibliothek erlaubt                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ändern Bibliothek erlaubt'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0006                    */
     /* Ändern Datei erlaubt                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ändern Datei erlaubt'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0007                    */
     /* Ändern Teildatei erlaubt                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ändern Teildatei erlaubt'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0008                    */
     /* Ändern Datensätze erlaubt                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ändern Datensätze erlaubt'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0009                    */
     /* Ändern SQL WHERE erlaubt                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ändern SQL WHERE erlaubt'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0010                    */
     /* Ändern SQL ORDER BY erlaubt                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ändern SQL ORDER BY erlaubt'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0011                    */
     /* Arbeitsumgebung                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Arbeitsumgebung'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0012                    */
     /*   Teildatei                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Teildatei'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0013                    */
     /* SQL WHERE                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL WHERE'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0014                    */
     /* SQL ORDER BY                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL ORDER BY'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0015                    */
     /* Bibliothek                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0015) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0015) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bibliothek'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0016                    */
     /* Benutzereinstellungen                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Benutzereinstellungen'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0017                    */
     /* Benutzerprofil                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Benutzerprofil'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0018                    */
     /* Speichern beim Verlassen                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Speichern beim Verlassen'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0019                    */
     /* Nur Layout laden                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nur Layout laden'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0100                    */
     /* Datenbankbrowser - Peek/400                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datenbankbrowser - Peek/400'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0101                    */
     /* Anzeigen Datenbankrelationen                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Anzeigen Datenbankrelationen'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0001                    */
     /* Datei:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0002                    */
     /* Bibliothek:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bibliothek:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0003                    */
     /* Teildatei:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Teildatei:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0004                    */
     /* Satzlänge :                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Satzlänge :'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0005                    */
     /* Anz. Sätze:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Anz. Sätze:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0006                    */
     /* Feld-Nummer:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feld-Nummer:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0007                    */
     /*         Feld:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'        Feld:'                                                       +
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
     /* Dateigröße:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Dateigröße:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0010                    */
     /* Satz-Nr. ..:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Satz-Nr. ..:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0011                    */
     /* Schlüssel  :                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Schlüssel  :'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0012                    */
     /*     Auswahl:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'    Auswahl:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0013                    */
     /* Datei:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei:'                                                              +
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
     /*  Länge:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Länge:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0017                    */
     /*  Sätze:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Sätze:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0018                    */
     /* Feld-Nr. :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feld-Nr. :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0019                    */
     /*     Feldname:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'    Feldname:'                                                       +
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
     /*  Größe:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0021) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0021) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Größe:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0022                    */
     /* Satz-Nr. :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0022) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0022) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Satz-Nr. :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0023                    */
     /* Schlüssel:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0023) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0023) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Schlüssel:'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0024                    */
     /* Auswahl:                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0024) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0024) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Auswahl:'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0025                    */
     /* (Keine Datensätze gefunden)                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0025) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0025) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(Keine Datensätze gefunden)'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0026                    */
     /* 'ENTER' = Löschen ...                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0026) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0026) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'''ENTER'' = Löschen ...'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0027                    */
     /* Datensatzanzeige ...                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0027) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0027) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatzanzeige ...'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0028                    */
     /* 'ENTER' = Kopieren ...                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0028) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0028) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'''ENTER'' = Kopieren ...'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0029                    */
     /* Satz-Nr:                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0029) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0029) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Satz-Nr:'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0030                    */
     /* Commit-Steuerung                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0030) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0030) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Commit-Steuerung  '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0031                    */
     /* ohne Commitsteuer.                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'ohne Commitsteuer.'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0032                    */
     /* (keine Datensätze gefunden)                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(keine Datensätze gefunden)'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0033                    */
     /*      - Suchen -                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'     - Suchen -'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0034                    */
     /*  Feld                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Feld'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0035                    */
     /* Oper.                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Oper.'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0036                    */
     /* Wert (ohne Hochkomma)                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wert (ohne Hochkomma)'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0037                    */
     /* generische Suche)                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'generische Suche)'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0038                    */
     /* Max.Anz. Sätze:                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Max.Anz. Sätze:'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0039                    */
     /* Art der Suche :                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Art der Suche :'                                                     +
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
     /* Groß-/Klein ..:                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0041) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0041) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Groß-/Klein ..:'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0042                    */
     /* (1=Ja; 0=Nein)                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0042) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0042) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(1=Ja; 0=Nein)'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0043                    */
     /* - Farbeinstellung -                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0043) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0043) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Farbeinstellung -'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0044                    */
     /*   - Farbauswahl -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0044) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0044) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  - Farbauswahl -'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0045                    */
     /* Grün                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0045) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0045) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Grün     '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0046                    */
     /* Weiß                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0046) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0046) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Weiß     '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0047                    */
     /* Rot                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0047) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0047) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Rot      '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0048                    */
     /* Türkis                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0048) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0048) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Türkis   '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0049                    */
     /* Gelb                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0049) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0049) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Gelb     '                                                           +
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
     /* Blau                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0051) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0051) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Blau     '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0052                    */
     /*  - ext. Kopieren -                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0052) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0052) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' - ext. Kopieren -'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0053                    */
     /* Datei ...........:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0053) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0053) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei ...........:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0054                    */
     /* Bibliothek ......:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0054) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0054) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bibliothek ......:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0055                    */
     /* Teildatei .......:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0055) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0055) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Teildatei .......:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0056                    */
     /* Sätze ersetzen ..:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0056) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0056) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sätze ersetzen ..:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0057                    */
     /* Datei erstellen .:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0057) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0057) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei erstellen .:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0058                    */
     /*   - Lizenzdaten -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0058) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0058) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  - Lizenzdaten -'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0059                    */
     /*  Lizenz-Nr:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0059) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0059) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Lizenz-Nr:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0060                    */
     /* F9=Testen                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0060) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0060) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'F9=Testen'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0061                    */
     /* Lizenzdaten wurden gesichert!                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0061) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0061) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lizenzdaten wurden gesichert!'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0062                    */
     /* Sorry, der Testzeitraum ist abgelaufen.                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0062) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0062) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sorry, der Testzeitraum ist abgelaufen.'                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0063                    */
     /* 'ENTER' = Ändern ...                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0063) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0063) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'''ENTER'' = Ändern ...'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0064                    */
     /* 'ENTER' = Kopieren ...                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0064) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0064) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'''ENTER'' = Kopieren ...'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0065                    */
     /* 'ENTER' = Einfügen ...                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0065) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0065) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'''ENTER'' = Einfügen ...'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0066                    */
     /* Weitere ...                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0066) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0066) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Weitere ...'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0067                    */
     /*        Ende                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0067) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0067) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'       Ende'                                                         +
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
     /* 80-/132- Zeichen Modus                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0069) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0069) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'80-/132- Zeichen Modus'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0070                    */
     /* Flexible Suchfunktionen                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0070) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0070) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Flexible Suchfunktionen'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0071                    */
     /* Indiv. Tastaturbelegung                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0071) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0071) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Indiv. Tastaturbelegung'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0072                    */
     /* Indiv. Spracherweiterungen                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0072) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0072) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Indiv. Spracherweiterungen'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0073                    */
     /*  Der ultimative                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0073) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0073) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Der ultimative'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0074                    */
     /* Datenbankbrowser                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0074) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0074) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datenbankbrowser'                                                    +
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
     /* Unzulässige Zeichen                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0076) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0076) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unzulässige Zeichen'                                                 +
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
     /* Suchen:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0078) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0078) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Suchen:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0079                    */
     /*  A   Folge  Feld        Bezeichnung                     Typ */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0079) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0079) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Folge  Feld        Bezeichnung                     Typ        St-
rPos '                                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0080                    */
     /* Sichtbar .:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0080) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0080) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sichtbar .:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0081                    */
     /* Farbe ..:                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0081) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0081) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Farbe ..:'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0082                    */
     /* Markierung:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0082) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0082) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Markierung:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0083                    */
     /* Max.Breite:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0083) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0083) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Max.Breite:'                                                         +
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
     /* - Feldauswahl -                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0085) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0085) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Feldauswahl -'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0086                    */
     /*  A   Feld        Bezeichnung                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0086) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0086) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Feld        Bezeichnung                    '                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0087                    */
     /*  A  Datei                  Beschreibung                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0087) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0087) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A  Datei                  Beschreibung                              -
   '                                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0088                    */
     /* - Anz. Datenbankrelationen   -                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0088) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0088) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Anz. Datenbankrelationen   -'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0089                    */
     /* Log. Sichten:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0089) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0089) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Log. Sichten:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0090                    */
     /* Hex-Eingabe                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0090) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0090) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Hex-Eingabe'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0091                    */
     /* Feld ........:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0091) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0091) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feld ........:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0092                    */
     /* Feldlänge ...:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0092) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0092) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feldlänge ...:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0093                    */
     /* Inhalt ....:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0093) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0093) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Inhalt ....:'                                                        +
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
     /* Startposition:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0095) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0095) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Startposition:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0096                    */
     /* Pufferlänge:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0096) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0096) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pufferlänge:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0097                    */
     /*  A   Teildatei   Bezeichnung                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0097) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0097) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Teildatei   Bezeichnung                                        '+
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0098                    */
     /* - Auswahl Teildatei -                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0098) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0098) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Auswahl Teildatei - '                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0099                    */
     /* Anz. Teild:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0099) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0099) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Anz. Teild:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0100                    */
     /*  Teild:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Teild:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0101                    */
     /* - Über Peek/400 -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Über Peek/400 - '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0102                    */
     /* Datum . . .                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0102) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0102) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datum . . .'                                                         +
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
     /* Spalten Pinnen                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0106) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0106) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Spalten Pinnen'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0107                    */
     /*  Folge  Feld        Bezeichnung                      Schl.F */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0107) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0107) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Folge  Feld        Bezeichnung                      Schl.Feld'      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0108                    */
     /*  - SQL  Auswahl -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0108) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0108) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' - SQL  Auswahl - '                                                  +
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
     /* - Programm erstellen -                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0111) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0111) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Programm erstellen -'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0112                    */
     /* Kleinbuchst. erlaubt?                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0112) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0112) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Kleinbuchst. erlaubt? '                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0113                    */
     /* Default Groß-/Kleinb.?                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0113) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0113) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Default Groß-/Kleinb.?'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0114                    */
     /* Als Default speichern?                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0114) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0114) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Als Default speichern?'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0115                    */
     /* SQL-Auswahl                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0115) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0115) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL-Auswahl  '                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0116                    */
     /* Auswählen Arbeitsumgebung                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0116) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0116) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Auswählen Arbeitsumgebung'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0117                    */
     /* Datei:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0117) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0117) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0118                    */
     /* Bibliothek:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0118) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0118) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bibliothek:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0119                    */
     /*  A   Umgebung    Bezeichnung                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0119) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0119) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Umgebung    Bezeichnung'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0120                    */
     /* Löschen Arbeitsumgebung                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0120) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0120) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Löschen Arbeitsumgebung'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0121                    */
     /* Datei . . . :                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0121) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0121) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei . . . :'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0122                    */
     /* Bibliothek:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0122) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0122) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bibliothek:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0123                    */
     /* Teildatei . :                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0123) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0123) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Teildatei . :'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0124                    */
     /* Beschreibung:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0124) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0124) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Beschreibung:'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0125                    */
     /* Akt.Länge .:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0125) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0125) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Akt.Länge .:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0126                    */
     /*  - Auswahl Satzformat -                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0126) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0126) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' - Auswahl Satzformat - '                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0127                    */
     /* NULL Wert                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0127) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0127) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'NULL Wert'                                                           +
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
     /* *** Datensatz gesperrt ***                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0129) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0129) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'*** Datensatz gesperrt ***'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0130                    */
     /* Datensatz nicht gesperrt                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0130) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0130) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatz nicht gesperrt'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0131                    */
     /* Satz gesperrt lesen?                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0131) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0131) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Satz gesperrt lesen?'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0132                    */
     /* Datei:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0132) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0132) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0133                    */
     /* Bibliothek:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0133) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0133) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bibliothek:'                                                         +
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
     /* Seite:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0135) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0135) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Seite:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0136                    */
     /* Feldname                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0136) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0136) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feldname'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0137                    */
     /* Feldbeschreibung                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0137) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0137) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feldbeschreibung'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0138                    */
     /* Feldinhalt                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0138) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0138) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feldinhalt'                                                          +
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
     /*  A   Opt  Bezeichnung                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0140) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0140) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Opt  Bezeichnung                 '                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0141                    */
     /* --------- Kurzbefehle ---------                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0141) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0141) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'--------- Kurzbefehle ---------'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0142                    */
     /*  A   Datei       Bibliothek   Bezeichnung                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0142) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0142) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Datei       Bibliothek   Bezeichnung'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0143                    */
     /* - Auswahl Datei -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Auswahl Datei -'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0144                    */
     /* Init. NULL-Felder?                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0144) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0144) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Init. NULL-Felder?'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0145                    */
     /* Cursorposition merken?                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0145) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0145) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cursorposition merken?'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0146                    */
     /* Einfügen                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0146) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0146) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Einfügen'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0147                    */
     /* Löschen                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0147) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0147) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Löschen'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0148                    */
     /* von:                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0148) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0148) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'von:   '                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0149                    */
     /* Länge:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0149) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0149) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Länge: '                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0150                    */
     /* bis:                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0150) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0150) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'bis:   '                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0151                    */
     /* Cursor Pos. .:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0151) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0151) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cursor Pos. .:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
     /* Satzformat &3 für Datei &2/&1 konnte nicht abgerufen werden */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Satzformat &3 für Datei &2/&1 konnte nicht abgerufen werden.'        +
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
     /* Liste der Satzformate für Datei &2/&1 konnte nicht abgerufe */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Liste der Satzformate für Datei &2/&1 konnte nicht abgerufen werden.'+
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
     /* Datei mit Commitment-Kontrolle geöffnet.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei mit Commitment-Kontrolle geöffnet.'                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0004                    */
     /* Datei OHNE Commitment-Kontrolle geöffnet!                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei OHNE Commitment-Kontrolle geöffnet!'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0005                    */
     /* Datei &1 konnte nicht geöffnet werden. Siehe Jobprotokoll.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei &1 konnte nicht geöffnet werden. Siehe Jobprotokoll.'          +
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
     /* Keine Schlüsselinformationen in Datei &1 in Bibliothek &2.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Keine Schlüsselinformationen in Datei &1 in Bibliothek &2.'          +
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
     /* Die Datei &2/&1 konnte nur für INPUT geöffnet werden. Änder */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Die Datei &2/&1 konnte nur für INPUT geöffnet werden. Änderungen sind-
 nicht möglich.'                                                      +
                ) +
                SECLVL( +
'&N &N Mögliche Ursachen: &N &B 1. Der Debugger ist mit dem Parameter -
UPDPROD(*NO) gestartet worden. &B 2. Es handelt sich um eine JOIN-Date-
i &B 3. Es gibt referenzielle Integritätsregeln und die Datei wird nic-
ht journalisiert. &B 4. Es gibt Triggerdefinitionen und die Triggerpro-
gramme befinden sich nicht in der Bibliotheksliste &B 5. Es handelt si-
ch um eine logische Datei, die auf mehreren Teildateien basiert.'     +
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
     /* Die Datei &2/&1 konnte nicht gefunden werden.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Die Datei &2/&1 konnte nicht gefunden werden.'                       +
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
     /* Fehler beim Abrufen der Objektbeschreibung für Datei &2/&1. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fehler beim Abrufen der Objektbeschreibung für Datei &2/&1.'         +
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
     /* Bibliothek &1 nicht gefunden.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bibliothek &1 nicht gefunden.'                                       +
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
     /* Datei konnte nicht geöffnet werden. Weitere Informationen i */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei konnte nicht geöffnet werden. Weitere Informationen im erweiter-
ten Hilfetext oder im Jobprotokoll.'                                  +
                ) +
                SECLVL( +
'&N &N Fehlertext  . . :   &1'                                        +
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
     /* C-IO Fehler &2: &1                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'C-IO Fehler &2: &1'                                                  +
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
     /* Ausführen SQL Abfrage ...                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ausführen SQL Abfrage ...'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0014                    */
     /* Bestimmen Anzahl ausgewählter Datensätze ...                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bestimmen Anzahl ausgewählter Datensätze ...'                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0143                    */
     /* - Auswahl Datei -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Auswahl Datei -'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR1000                    */
     /* Keine Berechtigung für Datei &2/&1, Teildatei &3.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR1000) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR1000) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Keine Berechtigung für Datei &2/&1, Teildatei &3.'                   +
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
     /* Verarbeitung mit &1 abgebrochen.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Verarbeitung mit &1 abgebrochen.'                                    +
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
     /* Initialisierung läuft ...                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Initialisierung läuft ...'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8102                    */
     /* Bitte mit dem Cursor auf den Datensatz zeigen und die Anfor */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8102) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8102) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bitte mit dem Cursor auf den Datensatz zeigen und die Anforderung wie-
derholen.'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8103                    */
     /* Datei kann nicht geschlossen werden.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8103) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8103) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei kann nicht geschlossen werden.'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8104                    */
     /* Abrufen der Feldbeschreibung für Datei &1 in Bibliothek &2. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8104) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8104) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Abrufen der Feldbeschreibung für Datei &1 in Bibliothek &2.'         +
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
     /* Abrufen der Satzformate für Datei &1 in Bibliothek &2.      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8105) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8105) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Abrufen der Satzformate für Datei &1 in Bibliothek &2.'              +
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
     /* Abrufen von Netzwerkattributen.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8106) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8106) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Abrufen von Netzwerkattributen.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8107                    */
     /* Abrufen von Objektattributen für Objekt &1 in Bibliothek &2 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8107) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8107) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Abrufen von Objektattributen für Objekt &1 in Bibliothek &2.'        +
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
     /* Feld '&1' in Datei &2 in Bibliothek &3 nicht gefunden.      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8108) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8108) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feld ''&1'' in Datei &2 in Bibliothek &3 nicht gefunden.'            +
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
     /* Abrufen der Teildateibeschreibung für Teildatei &3 in Datei */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8109) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8109) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Abrufen der Teildateibeschreibung für Teildatei &3 in Datei &1 in Bib-
liothek &2.'                                                          +
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
     /* Auswahl '&1' nicht gültig.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8110) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8110) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Auswahl ''&1'' nicht gültig.'                                        +
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
     /* Alle Datensätze verarbeiten.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8111) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8111) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Alle Datensätze verarbeiten.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8112                    */
     /* Verarbeitung bestätigt.                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8112) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8112) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Verarbeitung bestätigt.'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8113                    */
     /* Interner Befehl &1 nicht gültig.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8113) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8113) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Interner Befehl &1 nicht gültig.'                                    +
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
     /* RPG-Programm wird erstellt ...                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8114) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8114) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'RPG-Programm wird erstellt ...'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8115                    */
     /* Anfang des Datensatzes angezeigt.                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8115) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8115) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Anfang des Datensatzes angezeigt.'                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8116                    */
     /* Ende des Datensatzes angezeigt.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8116) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8116) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ende des Datensatzes angezeigt.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8117                    */
     /* Bitte mit dem Cursor auf eine Spalte zeigen und die Anforde */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8117) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8117) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bitte mit dem Cursor auf eine Spalte zeigen und die Anforderung wiede-
rholen.'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8118                    */
     /* Tabelle für PIN ist voll.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8118) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8118) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tabelle für PIN ist voll.'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8119                    */
     /* Datensatz bereits gepinned.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8119) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8119) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatz bereits gepinned.'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8120                    */
     /* Datensatz nicht gefunden.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8120) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8120) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatz nicht gefunden.'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8121                    */
     /* Datensatz ist nicht gepinned.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8121) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8121) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatz ist nicht gepinned.'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8122                    */
     /* Funktionstaste nicht zulässig.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8122) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8122) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktionstaste nicht zulässig.'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8123                    */
     /* Felder mit mehr als 1024-Zeichen können&1nicht&2geändert we */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8123) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8123) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Felder mit mehr als 1024-Zeichen können&1nicht&2geändert werden.'    +
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
     /* Vergleichsoperand '&1' nicht zulässig.                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8124) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8124) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Vergleichsoperand ''&1'' nicht zulässig.'                            +
                ) +
                SECLVL( +
'&N &B Zulässige Operanden sind: &N &P EQ   - Gleich &P NE   - Ungleic-
h &P LT   - Kleiner &P GT   - Größer &P LE   - Kleiner/Gleich &P GE   -
- Größer/Gleich &P LIKE - Ähnlich'                                    +
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
     /* Keine Anzahl der max. zu durchsuchenden Datensätze angegebe */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8125) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8125) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Keine Anzahl der max. zu durchsuchenden Datensätze angegeben.'       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8126                    */
     /* Vergleichsoperand '&1' nicht zulässig.                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8126) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8126) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Vergleichsoperand ''&1'' nicht zulässig.'                            +
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
     /* Suche läuft ...                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8127) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8127) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Suche läuft ...'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8128                    */
     /* Suche läuft. &1 von max. &2 Datensätzen durchsucht ...      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8128) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8128) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Suche läuft. &1 von max. &2 Datensätzen durchsucht ...'              +
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
     /* Feld '&1' mit Datentyp '&2' nicht zulässig.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8129) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8129) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feld ''&1'' mit Datentyp ''&2'' nicht zulässig.'                     +
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
     /* Datensatz gefunden. 'SUCHEN'=Weitersuchen/'ENTER'=Ende.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8130) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8130) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatz gefunden. ''SUCHEN''=Weitersuchen/''ENTER''=Ende.'         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8131                    */
     /* Dateiende erreicht. Zeichenfolge nicht gefunden. 'SUCHEN'=W */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8131) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8131) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Dateiende erreicht. Zeichenfolge nicht gefunden. ''SUCHEN''=Weitersuc-
hen/''ENTER''=Ende.'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8132                    */
     /* Maximale Anzahl Datensätze durchsucht. 'SUCHEN'=Weitersuche */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8132) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8132) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Maximale Anzahl Datensätze durchsucht. ''SUCHEN''=Weitersuchen/''ENTE-
R''=Ende.'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8133                    */
     /* 1=case-sensitive; 0=nicht case-sensitive                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8133) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8133) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=case-sensitive; 0=nicht case-sensitive'                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8134                    */
     /* Operand &1 bei &2 nicht erlaubt.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8134) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8134) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Operand &1 bei &2 nicht erlaubt.'                                    +
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
     /* Operand &1 ist bei Datentyp &2 nicht erlaubt.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8135) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8135) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Operand &1 ist bei Datentyp &2 nicht erlaubt.'                       +
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
     /* Feld '&1' nicht gefunden.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8136) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8136) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feld ''&1'' nicht gefunden.'                                         +
                ) +
                SECLVL( +
'&N &B Sonderwerte: &N &P *RECORD - Im ganzen Datensatz suchen, nur mi-
t EQ/NE möglich.'                                                     +
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
     /* Abrufen der Schlüsselfelder für Datei &1 in Bibliothek &2.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8137) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8137) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Abrufen der Schlüsselfelder für Datei &1 in Bibliothek &2.'          +
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
     /* Ungültige numerische Werte im Feld &1 gefunden.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8138) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8138) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungültige numerische Werte im Feld &1 gefunden.'                     +
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
     /* Positionierung fehlgeschlagen.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8139) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8139) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Positionierung fehlgeschlagen.'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8140                    */
     /* Bitte geben Sie eine Suchargument ein.                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8140) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8140) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bitte geben Sie eine Suchargument ein.'                              +
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
     /* Nur '&1' für positive und '&2' für negative Zahlen als Vorz */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8141) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8141) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nur ''&1'' für positive und ''&2'' für negative Zahlen als Vorzeichen-
 gültig.'                                                             +
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
     /* Die Stelle &1 ist bei numerischen Werten für das Vorzeichen */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8142) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8142) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Die Stelle &1 ist bei numerischen Werten für das Vorzeichen reservier-
t.'                                                                   +
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
     /* Der Taste &1 ist keine Programmfunktion zugeordnet.         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Der Taste &1 ist keine Programmfunktion zugeordnet.'                 +
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
     /* Rekursive Befehlsausführung für Befehl &1 nicht zulässig.   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8144) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8144) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Rekursive Befehlsausführung für Befehl &1 nicht zulässig.'           +
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
     /* Funktion kann bei leerer Subfile nicht ausgeführt werden.   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8145) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8145) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktion kann bei leerer Subfile nicht ausgeführt werden.'           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8146                    */
     /* Kein gültiges Feld für Farbauswahl.                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8146) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8146) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Kein gültiges Feld für Farbauswahl.'                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8147                    */
     /* Spalte &1 ist nicht gepinned.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8147) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8147) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Spalte &1 ist nicht gepinned.'                                       +
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
     /* Kein Platz mehr für Spalte '&1'!                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8148) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8148) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Kein Platz mehr für Spalte ''&1''!'                                  +
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
     /* Tabellierpapier ist bereits eingeschaltet.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8149) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8149) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tabellierpapier ist bereits eingeschaltet.'                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8150                    */
     /* Tabellierpapier ist bereits ausgeschaltet.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8150) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8150) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tabellierpapier ist bereits ausgeschaltet.'                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8151                    */
     /* Ungültiger Name '&1' für Zieldatei.                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8151) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8151) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungültiger Name ''&1'' für Zieldatei.'                               +
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
     /* Ungültige Bibliothek '&1' für Zieldatei.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8152) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8152) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungültige Bibliothek ''&1'' für Zieldatei.'                          +
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
     /* Ungültige Teildatei '&1' für Zieldatei.                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8153) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8153) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungültige Teildatei ''&1'' für Zieldatei.'                           +
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
     /* Ungültiger Parameter für ERSETZEN/HINZUFÜGEN '&1' für Zield */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8154) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8154) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungültiger Parameter für ERSETZEN/HINZUFÜGEN ''&1'' für Zieldatei.'  +
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
     /* Ungültiger Parameter für DATEI ERSTELLEN '&1' für Zieldatei */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8155) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8155) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungültiger Parameter für DATEI ERSTELLEN ''&1'' für Zieldatei.'      +
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
     /* Verarbeitung fehlerhaft beendet.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8156) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8156) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Verarbeitung fehlerhaft beendet.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8157                    */
     /* Abrufen von Systemwerten.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8157) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8157) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Abrufen von Systemwerten.'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8158                    */
     /* Ungültige Lizenznummer '&1' eingetragen.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8158) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8158) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungültige Lizenznummer ''&1'' eingetragen.'                          +
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
     /* Lizenzdaten konnten nicht gesichert werden.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8159) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8159) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lizenzdaten konnten nicht gesichert werden.'                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8160                    */
     /* Srachendefinition für Sprache &1 nicht verfügbar.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8160) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8160) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Srachendefinition für Sprache &1 nicht verfügbar.'                   +
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
     /* SPLASH-Screen eingeschaltet.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8161) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8161) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SPLASH-Screen eingeschaltet.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8162                    */
     /* SPLASH-Screen ausgeschaltet.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8162) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8162) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SPLASH-Screen ausgeschaltet.'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8163                    */
     /* Zeichenkette enthält nicht darstellbare Zeichen. Ersetzungs */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8163) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8163) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Zeichenkette enthält nicht darstellbare Zeichen. Ersetzungszeichen: &-
1'                                                                    +
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
     /* Felder mit nicht darstellbaren Zeichen wurden ausgeblendet. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8164) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8164) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Felder mit nicht darstellbaren Zeichen wurden ausgeblendet.'         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8165                    */
     /* "WIEDERHOLEN" kann erst gedrückt werden, wenn auf dieser Se */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8165) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8165) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'"WIEDERHOLEN" kann erst gedrückt werden, wenn auf dieser Seite eine A-
uswahl eingegeben wurde.'                                             +
                ) +
                SECLVL( +
'Ursache . . . . . : F13 (Wiederholen) wurde gedrückt, es wurde jedoch-
 auf dieser Seite keine Funktion zur Wiederholung ausgewählt. &N Fehle-
rbeseitigung : Eine Auswahl in die Auswahlspalte auf dieser Seite eing-
eben und "WIEDERHOLEN" erneut auslösen.'                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8166                    */
     /* Funktion nicht möglich. Keine Datei geöffnet!               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8166) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8166) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funktion nicht möglich. Keine Datei geöffnet!'                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8167                    */
     /* Identische Folgenummern nicht zulässig.                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8167) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8167) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Identische Folgenummern nicht zulässig.'                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8168                    */
     /* Wert &1 für Attribut "Sichtbar/Unsichtbar" nicht zulässig.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8168) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8168) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wert &1 für Attribut "Sichtbar/Unsichtbar" nicht zulässig.'          +
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
     /* Wert &1 für Attribut "Spaltenmarkierung" nicht zulässig.    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8169) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8169) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wert &1 für Attribut "Spaltenmarkierung" nicht zulässig.'            +
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
     /* Wert &1 für Attribut "Max. Größe" nicht zulässig.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8170) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8170) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wert &1 für Attribut "Max. Größe" nicht zulässig.'                   +
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
     /* Ungültiger Wert '&1' für Zeit-, Datum- oder Zeitmarkenfeld  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8171) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8171) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungültiger Wert ''&1'' für Zeit-, Datum- oder Zeitmarkenfeld'        +
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
     /* Bearbeite: &1                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8172) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8172) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bearbeite: &1'                                                       +
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
     /* Peek/400 kann nicht rekursiv aufgerufen werden.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8173) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8173) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Peek/400 kann nicht rekursiv aufgerufen werden.'                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8174                    */
     /* Unzulässige Zeichen (&1) im Hex-String.                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8174) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8174) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unzulässige Zeichen (&1) im Hex-String.'                             +
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
     /* Ungerade Anzahl Zeichen nicht zulässig.                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8175) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8175) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungerade Anzahl Zeichen nicht zulässig.'                             +
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
     /* Warnung: Zeichenkette zu lang.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8176) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8176) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Warnung: Zeichenkette zu lang.'                                      +
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
     /* Startposition darf nicht größer als Feldlänge sein.         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8177) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8177) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Startposition darf nicht größer als Feldlänge sein.'                 +
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
     /* Startposition darf nicht kleiner/gleich Null sein.          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8178) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8178) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Startposition darf nicht kleiner/gleich Null sein.'                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8179                    */
     /* Keine Bedienerführung verfügbar.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8179) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8179) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Keine Bedienerführung verfügbar.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8180                    */
     /* Teildatei '&1' nicht gefunden.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8180) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8180) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Teildatei ''&1'' nicht gefunden.'                                    +
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
     /* Keine Datei zur Speicherung der Arbeitsumgebung angegeben.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8181) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8181) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Keine Datei zur Speicherung der Arbeitsumgebung angegeben.'          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8182                    */
     /* Wert &1 als Name für ein AS/400 Objekt ungültig.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8182) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8182) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wert &1 als Name für ein AS/400 Objekt ungültig.'                    +
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
     /* Unvollständige Auswahl.                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8183) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8183) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unvollständige Auswahl.'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8184                    */
     /* Diese Funktion ist nicht freigeschaltet. Bitte wenden Sie s */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8184) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8184) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Diese Funktion ist nicht freigeschaltet. Bitte wenden Sie sich an Ihr-
en Administrator.'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8185                    */
     /* Keine Arbeitsumgebung angegeben. Arbeitsumgebung nicht geöf */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8185) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8185) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Keine Arbeitsumgebung angegeben. Arbeitsumgebung nicht geöffnet.'    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8186                    */
     /* Warnung: Zeichenkette zu kurz.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8186) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8186) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Warnung: Zeichenkette zu kurz.'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8187                    */
     /* Feldlänge ist größer als Dateipuffer.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8187) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8187) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feldlänge ist größer als Dateipuffer.'                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8188                    */
     /* Generieren Bildschirmdatei. Lauf: &1, Feld: &2              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8188) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8188) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Generieren Bildschirmdatei. Lauf: &1, Feld: &2'                      +
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
     /* Generieren RPG-Programm. Lauf: &1, Feld: &2                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8189) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8189) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Generieren RPG-Programm. Lauf: &1, Feld: &2'                         +
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
     /* Verarbeitung beendet mit &1.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8190) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8190) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Verarbeitung beendet mit &1.'                                        +
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
     /* Feld &1 ist nicht NULL-fähig.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8191) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8191) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feld &1 ist nicht NULL-fähig.'                                       +
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
     /* Ungültigen Float Wert in &1 gefunden.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8192) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8192) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungültigen Float Wert in &1 gefunden.'                               +
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
     /* Felder '&1' enthält nicht darstellbaren Zeichen und kann da */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8193) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8193) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Felder ''&1'' enthält nicht darstellbaren Zeichen und kann daher nich-
t mit dem Texteditor bearbeitet werden.'                              +
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
     /* Datei '&1' nicht gefunden.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8194) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8194) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei ''&1'' nicht gefunden.'                                        +
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
     /* Unzulässige Anforderung. Feld ist für Änderungen gesperrt.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8195) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8195) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unzulässige Anforderung. Feld ist für Änderungen gesperrt.'          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8196                    */
     /* Feld &1 kann nicht angezeigt und geändert werden.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8196) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8196) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feld &1 kann nicht angezeigt und geändert werden.'                   +
                ) +
                SECLVL( +
'&N &N Mögliche Ursachen: &N &B 1. Unbekannter Datentyp. &B 2. Datenty-
p Graphic ohne CCSID. &B 3. Datentyp Packed oder Zoned mit mehr als 30-
 Stellen. &B 4. Feld variabler Länge mit unbekanntem Datentyp.'       +
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
     /* Datensatz &1 konnte nicht gelöscht werden.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8200) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8200) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatz &1 konnte nicht gelöscht werden.'                          +
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
     /* Datensatz &1 wurde gelöscht.                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8201) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8201) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatz &1 wurde gelöscht.'                                        +
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
     /* Datensatz &1 konnte nicht kopiert werden.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8202) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8202) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatz &1 konnte nicht kopiert werden.'                           +
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
     /* Datensatz &1 wurde kopiert.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8203) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8203) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatz &1 wurde kopiert.'                                         +
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
     /* Keine gültige Satzauswahl getroffen.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8204) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8204) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Keine gültige Satzauswahl getroffen.'                                +
                ) +
                SECLVL( +
'&N &N Zeigen Sie mit dem Cursor auf einen Datensatz der Subfile und w-
iederholen Sie die Anforderung.'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8205                    */
     /* Warnung: Es können nicht mehr als &1 Spalten gepinnt werden */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8205) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8205) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Warnung: Es können nicht mehr als &1 Spalten gepinnt werden!'        +
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
     /* Anzeige nicht möglich. Die Satzlänge ist größer als &1 Zeic */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8206) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8206) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Anzeige nicht möglich. Die Satzlänge ist größer als &1 Zeichen.'     +
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
     /* Datei konnte nicht geöffnet werden. Die Satzlänge ist größe */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8207) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8207) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datei konnte nicht geöffnet werden. Die Satzlänge ist größer als &1 Z-
eichen.'                                                              +
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
     /* Nur INPUT-Felder können nicht geändert werden.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8208) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8208) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nur INPUT-Felder können nicht geändert werden.'                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8209                    */
     /* Bitte geben Sie in Suchargument ein.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8209) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8209) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bitte geben Sie in Suchargument ein.'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8210                    */
     /* SQL-Fehler &1 aufgetreten. &2                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8210) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8210) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL-Fehler &1 aufgetreten. &2'                                       +
                ) +
                SECLVL( +
'&N &N Hinweis . . . . :   &2 &N &B Weitere Informationen enthält des -
SQL Programmierhandbuch oder die Nachrichtendatei QSYS/QSQLMSG.'      +
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
     /* Bitte mit dem Cursor auf ein Feld zeigen und die Anforderun */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8211) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8211) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bitte mit dem Cursor auf ein Feld zeigen und die Anforderung wiederho-
len.'                                                                 +
                ) +
                SECLVL( +
'Ursache . . . . :   Der Cursor steht nicht in einem Feld oder das Fel-
d ist für die Anforderung nicht zulässig.'                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8212                    */
     /* Die SQL-Auswahl kann nur auf physischen Dateien angewendet  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8212) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8212) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Die SQL-Auswahl kann nur auf physischen Dateien angewendet werden. So-
ll die physische Datei geöffnet werden?'                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8213                    */
     /* 1=speichern; 0=nicht speichern                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8213) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8213) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=speichern; 0=nicht speichern'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8214                    */
     /* 1=Kleinbuchstaben erlaubt; 0=nur Großbuchstaben             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8214) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8214) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=Kleinbuchstaben erlaubt; 0=nur Großbuchstaben'                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8215                    */
     /* Eingabe in Kleinbuchstaben nicht erlaubt.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8215) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8215) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Eingabe in Kleinbuchstaben nicht erlaubt.'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8216                    */
     /* Diese Eingabekombination ist nicht erlaubt.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8216) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8216) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Diese Eingabekombination ist nicht erlaubt.'                         +
                ) +
                SECLVL( +
'Wenn die Eingabe von Kleinbuchstaben nicht erlaubt ist, dann kann die-
s auch nicht als Standardwert vorbesetzt werden.'                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8217                    */
     /* Sortierung nach relativer Satznummer nicht möglich.         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8217) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8217) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sortierung nach relativer Satznummer nicht möglich.'                 +
                ) +
                SECLVL( +
'Eine Sortierung nach relativer Satznummer ist nicht möglich, weil die-
 geöffnete Datei auf mehrenen Teildateien basiert.'                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8218                    */
     /* Datensatz kann nicht gepinnt werden, wenn die logische Date */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8218) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8218) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatz kann nicht gepinnt werden, wenn die logische Datei auf mehr-
eren physischen Teildateien basiert.'                                 +
                ) +
                SECLVL( +
'&N &N Ursache . . . . :   Der Datensatz kann nicht gepinnt werden, we-
il die relative Satznummer nicht eindeutig ist und nicht ermittelt wer-
den kann, aus welcher physischen Teildatei der Satz kommt.'           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8219                    */
     /* Wert '&1' für Auswahl Ja/Nein nicht zulässig.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8219) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8219) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wert ''&1'' für Auswahl Ja/Nein nicht zulässig.'                     +
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
     /* Editor nicht zulässig. Feld &1 enthält NULL Wert.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8220) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8220) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editor nicht zulässig. Feld &1 enthält NULL Wert.'                   +
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
     /* Editor nicht zulässig. Feld &1 hat ungültigen Datentyp.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8221) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8221) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Editor nicht zulässig. Feld &1 hat ungültigen Datentyp.'             +
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
     /* Feld &1 zu lang für Editor.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8222) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8222) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feld &1 zu lang für Editor.'                                         +
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
     /* Eingabe der Schlüsselfelder auf Kleinbuchstaben geschaltet. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8223) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8223) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Eingabe der Schlüsselfelder auf Kleinbuchstaben geschaltet.'         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8224                    */
     /* Eingabe der Schlüsselfelder auf Grossbuchstaben geschaltet. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8224) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8224) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Eingabe der Schlüsselfelder auf Grossbuchstaben geschaltet.'         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8225                    */
     /* Datensatz wurde zwischenzeitlich von einem anderem Job geän */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8225) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8225) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatz wurde zwischenzeitlich von einem anderem Job geändert.&N&NT-
rotzdem ändern?'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8226                    */
     /* Druckvorgang erfolgreich beendet.                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8226) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8226) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Druckvorgang erfolgreich beendet.'                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8227                    */
     /* Die Zeichenkette '&1' konnte nicht in einen numerischen Wer */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8227) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8227) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Die Zeichenkette ''&1'' konnte nicht in einen numerischen Wert umgese-
tzt werden.'                                                          +
                ) +
                SECLVL( +
'&N &N Information . . :   Bei der Umwandlung der Zeichenkette ''&1'' -
ist ein Fehler aufgetreten. Die Zeichenkette konnte nicht in einen num-
erischen Wert vom Typ &2(&3,&4) umgesetzt werden.'                    +
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
     /* Datentyp '&1' ist ungültig.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8228) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8228) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datentyp ''&1'' ist ungültig.'                                       +
                ) +
                SECLVL( +
'&N &N Information . . :   Der angegebene Datentyp ''&1'' wird nicht u-
nterstützt. Bitte geben Sie einen gültigen RPG Datentyp an und wiederh-
olen Sie die Anforderung.'                                            +
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
     /* Wert '&1' für die Feldlänge ist ungültig.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8229) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8229) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wert ''&1'' für die Feldlänge ist ungültig.'                         +
                ) +
                SECLVL( +
'&N &N Information . . :   Der angegebene Wert ''&1'' für die Feldläng-
e ist ungültig. Bitte korrigieren Sie die Feldlänge und wiederholen Si-
e die Anforderung.'                                                   +
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
     /* Wert '&1' für die Anzahl Nachkommastellen ist ungültig.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8230) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8230) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wert ''&1'' für die Anzahl Nachkommastellen ist ungültig.'           +
                ) +
                SECLVL( +
'&N &N Information . . :   Der angegebene Wert ''&1'' für die Anzahl N-
achkommastellen ist ungültig. Bitte korrigieren Sie die Anzahl Nachkom-
mastellen und wiederholen Sie die Anforderung. Beachten Sie, dass nich-
t alle Datentypen, z.B. ''A'' für Zeichenketten, Nachkommastellen erfo-
rdern.'                                                               +
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
     /* Eine Änderung der Satzsperre ist nur im Änderungsmodus mögl */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8231) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8231) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Eine Änderung der Satzsperre ist nur im Änderungsmodus möglich.'     +
                ) +
                SECLVL( +
'&N &N Information . . :   Die Satzsperre kann nur im Änderungsmodus a-
ngefordert oder freigegeben werden. Beim Kopieren oder bei der Neuanla-
ge von Datensätzen ist dies nicht möglich.'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8232                    */
     /* Datensatz wurde zwischenzeitlich von einem anderem Job geän */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8232) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8232) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Datensatz wurde zwischenzeitlich von einem anderem Job geändert.&N&NT-
rotzdem sperren?'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8233                    */
     /* Fehler: Ungültiges Layout aufgrund abweichender Satzformat- */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8233) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8233) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fehler: Ungültiges Layout aufgrund abweichender Satzformat-ID.'      +
                ) +
                SECLVL( +
'&N &N Fehlerkorrektur :   Versuchsweise kann der Eintrag *RCDFMTID au-
s der Datei &2/&1, Teildatei &3 gelöscht werden, um die Prüfung der Sa-
tzformat_ID ausser Kraft zu setzen. Kann das Layout danach geladen wer-
den, muss es erneut gespeichert werden, um die Satzformat ID wieder hi-
nzuzufügen.'                                                          +
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
     /* Layout konnte aufgrund abweichender Satzformat-IDs nicht ge */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8234) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8234) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Layout konnte aufgrund abweichender Satzformat-IDs nicht geladen werd-
en.'                                                                  +
                ) +
                SECLVL( +
'&N &N Ursache . . . . :   Das angegebene Layout konnte nicht geladen -
werden, weil die im Layout gespeicherte Formatebenen-ID von der Format-
ebenen-ID der anzuzeigenden Datei abweicht.&N Fehlerkorrektur : Versuc-
hsweise kann der Eintrag *RCDFMTID aus der Datei &2/&1, Teildatei &3 g-
elöscht werden, um die Prüfung der Satzformat_ID ausser Kraft zu setze-
n. Kann das Layout danach geladen werden, muss es erneut gespeichert w-
erden, um die Satzformat ID wieder hinzuzufügen.'                     +
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
     /* SQL-Auswahl wird für Multi-Member logische Dateien nicht un */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8235) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8235) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL-Auswahl wird für Multi-Member logische Dateien nicht unterstützt.-
'                                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8236                    */
     /* Einfügemodus aktiviert. Positionieren Cursor, dann F7 drück */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8236) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8236) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Einfügemodus aktiviert. Positionieren Cursor, dann F7 drücken.'      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8237                    */
     /* Eingabetaste drücken, um die angegebenen Anzahl Leerzeichen */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8237) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8237) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Eingabetaste drücken, um die angegebenen Anzahl Leerzeichen einzufüge-
n.'                                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8238                    */
     /* Löschmodus aktiviert. Positionieren Cursor, dann F8 drücken */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8238) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8238) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Löschmodus aktiviert. Positionieren Cursor, dann F8 drücken.'        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8239                    */
     /* Eingabetaste drücken, um den angegebenen Bereich von Zeiche */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8239) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8239) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Eingabetaste drücken, um den angegebenen Bereich von Zeichen zu lösch-
en.'                                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8240                    */
     /* Wert darf nicht kleiner &1 sein.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8240) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8240) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wert darf nicht kleiner &1 sein.'                                    +
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
     /* Feldlänge überschritten. Der Wert ist um &1 Zeichen zu groß */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8241) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8241) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Feldlänge überschritten. Der Wert ist um &1 Zeichen zu groß.'        +
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
     /* Ungültiger Datums-, Zeit- oder Zeitstempelwert im Feld &1. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8242) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8242) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ungültiger Datums-, Zeit- oder Zeitstempelwert im Feld &1.'          +
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
     /* Wert &1 für Attribut "Editcode" nicht zulässig.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8243) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8243) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wert &1 für Attribut "Editcode" nicht zulässig.'                     +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 1) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8244                    */
     /* Wert im Feld &1 außerhalb des Bereichs &2 bis &3.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8244) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8244) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Wert im Feld &1 außerhalb des Bereichs &2 bis &3.'                   +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                    (*CHAR 20) +
                    (*CHAR 20) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8245                    */
     /* Im Feld &1 sind nur 0 (falsch) und 1 (wahr) zulässig.       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8245) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8245) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Im Feld &1 sind nur 0 (falsch) und 1 (wahr) zulässig.'               +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9989                    */
     /* Die Einstellungsdatei &2/&1 konnte nicht angepasst werden.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9989) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9989) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Die Einstellungsdatei &2/&1 konnte nicht angepasst werden.'          +
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
     /*   Cmd-ADDMSGD für Message-ID :   USR9992                    */
     /* Benutzereinstellungen konnten nicht gespeichert werden.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9992) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9992) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Benutzereinstellungen konnten nicht gespeichert werden.'             +
                ) +
                SECLVL( +
'&N &N Ursache . . . . :   Die Benutzereinstellungen konnten aufgrund -
von Ursachencode &1 nicht gespeichert werden. &N &N Die möglichen Ursa-
chencodes sind: &N &B 1 - Name der Datei (&2) stimmt nicht mit der geö-
ffneten Datei überein. &B 2 - Name der Bibliothek (&2) stimmt nicht mi-
t der Bibliothek der geöffneten Datei überein. &B 3 - Datei für Benutz-
ereinstellungen &3/&2 mit Teildatei &4 konnte nicht geöffnet werden.' +
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
     /* Keine Datei geöffnet. Der Zugriff über SQL kann nur auf phy */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9993) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9993) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Keine Datei geöffnet. Der Zugriff über SQL kann nur auf physische Dat-
eien angewendet werden.'                                              +
                ) +
                SEV(0) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9994                    */
     /* Unerwarteter Fehler &1 in C Funktion &2 aufgetreten.        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9994) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9994) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unerwarteter Fehler &1 in C Funktion &2 aufgetreten.'                +
                ) +
                SECLVL( +
'&N &N Fehlertext  . . :   &3'                                        +
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
     /* Struktur der Einstellungsdatei wird angepasst ...           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9995) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9995) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Struktur der Einstellungsdatei wird angepasst ...'                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9996                    */
     /* Keine Datei geöffnet.                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9996) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9996) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Keine Datei geöffnet.'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9997                    */
     /* &2PEEK/400 ist&1 Shareware. &2Bitte lassen Sie sich registr */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9997) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9997) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'&2PEEK/400 ist&1 Shareware. &2Bitte lassen Sie sich registrieren!'   +
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
     /* Unerwartete Nachrichten-ID &1 von Programm &2.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9998) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9998) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Unerwartete Nachrichten-ID &1 von Programm &2.'                      +
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
