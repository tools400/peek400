      /*%METADATA                                                     */
      /* %TEXT MSG: AID00BA - USR9999                                 */
      /*%EMETADATA                                                    */
     /*-----------------------------------------------------------------------*/
     /* Hinweis: Dieses CL muss in einem Job mit der Sprache der              */
     /*          Zielnachrichtendatei kompiliert und ausgeführt werden.       */
     /*-----------------------------------------------------------------------*/
     /* STRPREPRC Compile Options:                                            */
     /* >>PRE-COMPILER<<                                                      */
     /*   >>CRTCMD<<  CALL       PGM(QTEMP/&OB) PARM(&LI);                    */
     /*   >>CMD<<     CHGJOB  LANGID(ITA) CNTRYID(IT) CCSID(1144);            */
     /*   >>CMD<<     CRTCLPGM   PGM(QTEMP/&OB) +                             */
     /*                          SRCFILE(&SL/&SF) SRCMBR(&SM) +               */
     /*               TEXT('Peek/400 - Italiano');                            */
     /*   >>EXECUTE<<                                                         */
     /*   >>CMD<<     DLTPGM PGM(QTEMP/&OB);                                  */
     /*   >>CMD<<     CHGJOB  LANGID(DEU) CNTRYID(DE) CCSID(273);             */
     /* >>END-PRE-COMPILER<<                                                  */
     /*-----------------------------------------------------------------------*/
             PGM        PARM(&I_LIB)

             DCL        VAR(&I_LIB     ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&I_OBJ     ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&LIB       ) TYPE(*CHAR) LEN(10)
             DCL        VAR(&OBJ       ) TYPE(*CHAR) LEN(10)  VALUE('PEEKITA')
             DCL        VAR(&CCSID     ) TYPE(*DEC ) LEN(5 0) VALUE(1144)
             DCL        VAR(&LANGUAGE  ) TYPE(*CHAR) LEN(20)  VALUE('Italiano')

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
     /* Premuto F22 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BA) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BA) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F22 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BB                    */
     /* Premuto F23 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BB) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BB) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F23 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BC                    */
     /* Premuto F24 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BC) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BC) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F24 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00BD                    */
     /* Tasto 'Cancella' non valido                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00BD) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00BD) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tasto ''Cancella'' non valido '                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B1                    */
     /* Premuto F13 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B1) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B1) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F13 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B2                    */
     /* Premuto F14 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B2) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B2) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F14 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B3                    */
     /* Premuto F15 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B3) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B3) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F15 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B4                    */
     /* Premuto F16 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B4) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B4) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F16 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B5                    */
     /* Premuto F17 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B5) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B5) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F17 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B6                    */
     /* Premuto F18 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B6) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B6) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F18 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B7                    */
     /* Premuto F19 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B7) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B7) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F19 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B8                    */
     /* Premuto F20 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B8) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B8) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F20 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00B9                    */
     /* Premuto F21 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00B9) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00B9) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F21 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F1                    */
     /* Premuto ENTER - tasto non valido                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F1) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F1) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto ENTER - tasto non valido   '                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F3                    */
     /* Tasto 'HELP' non valido                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F3) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F3) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tasto ''HELP'' non valido   '                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F4                    */
     /* Tasto 'pagina giù' non valido                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F4) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F4) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tasto ''pagina giù'' non valido   '                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F5                    */
     /* Tasto 'pagina su' non valido                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F5) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F5) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tasto ''pagina su'' non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F6                    */
     /* Tasto 'STAMP' non valido                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F6) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F6) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tasto ''STAMP'' non valido    '                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID00F8                    */
     /* Tasto 'RESET' non valido                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID00F8) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID00F8) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tasto ''RESET'' non valido        '                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003A                    */
     /* Premuto F10 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003A) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003A) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F10 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003B                    */
     /* Premuto F11 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003B) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003B) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F11 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003C                    */
     /* Premuto F12 - tasto non valido                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003C) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003C) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F12 - tasto non valido  '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID003F                    */
     /* Tasto 'lettura ottica' non valido                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID003F) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID003F) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tasto ''lettura ottica'' non valido'                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0031                    */
     /* Premuto F01 - tasto non valido.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F01 - tasto non valido.'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0032                    */
     /* Premuto F02 - tasto non valido.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F02 - tasto non valido. '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0033                    */
     /* Premuto F03 - tasto non valido.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F03 - tasto non valido. '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0034                    */
     /* Premuto F04 - tasto non valido.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F04 - tasto non valido. '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0035                    */
     /* Premuto F05 - tasto non valido.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F05 - tasto non valido. '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0036                    */
     /* Premuto F06 - tasto non valido.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F06 - tasto non valido. '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0037                    */
     /* Premuto F07 - tasto non valido.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F07 - tasto non valido. '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0038                    */
     /* Premuto F08 - tasto non valido.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F08 - tasto non valido. '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0039                    */
     /* Premuto F09 - tasto non valido.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premuto F09 - tasto non valido. '                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   AID0100                    */
     /* Tasto sconosciuto e non consentito                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(AID0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(AID0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tasto sconosciuto e non consentito  '                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0001                    */
     /* Invio dei dati                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Invio dei dati    '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0002                    */
     /* Terminare                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Terminare         '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0003                    */
     /* Rivisual.video                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Rivisual.video  '                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0004                    */
     /* Inser.rec.                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Inser.rec.        '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0005                    */
     /* intestazione                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'intestazione      '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0006                    */
     /* Sel.colonna +/-                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sel.colonna +/-   '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0007                    */
     /* Ritorna a inizio                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ritorna a inizio '                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0008                    */
     /* Pos.cursore                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pos.cursore       '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0009                    */
     /* Cerca                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cerca             '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0010                    */
     /* Inizio                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Inizio            '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0011                    */
     /* Fine                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fine              '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0012                    */
     /* Sinistra                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sinistra          '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0013                    */
     /* Destra                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Destra            '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0014                    */
     /* Riga comandi                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Riga comandi      '                                                  +
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
'80/132 colonne    '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0016                    */
     /* Altri tasti                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Altri tasti       '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0017                    */
     /* Pagina giù                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pagina giù        '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0018                    */
     /* Pagina su                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pagina su         '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0019                    */
     /* Sel.riga                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sel.riga          '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0020                    */
     /* Desel.riga                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0020) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0020) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Desel.riga        '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0021                    */
     /* Modifica                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0021) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0021) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Modifica          '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0022                    */
     /* Copia                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0022) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0022) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Copia             '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0023                    */
     /* Cancella                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0023) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0023) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cancella          '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0024                    */
     /* Visualizza                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0024) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0024) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Visualizza        '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0025                    */
     /* Impostazione                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0025) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0025) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impostazione '                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0026                    */
     /* Interrompe                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0026) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0026) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Interrompe'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0027                    */
     /* Salva e esce                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0027) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0027) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Salva e esce'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0028                    */
     /* Sel.colonna                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0028) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0028) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sel.colonna'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0029                    */
     /* Desel.colonna                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0029) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0029) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Desel.colonna'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0030                    */
     /* Sel.colonna SN                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0030) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0030) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sel.colonna SN'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0031                    */
     /* Colore righe alt.                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Colore righe alt.'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0032                    */
     /* Righe monocol.                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Righe monocol.'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0033                    */
     /* Color.riga 1/2                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Color.riga 1/2'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0034                    */
     /* Selez.tutti                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0034) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0034) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Selez.tutti '                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0035                    */
     /* Altre opzioni                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0035) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0035) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Altre opzioni'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0036                    */
     /* Copia in file                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Copia in file'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0037                    */
     /* Sel.colonna                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sel.colonna '                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0038                    */
     /* Desel.colonna                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Desel.colonna  '                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0039                    */
     /* Accetta minusc.                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Accetta minusc.'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0040                    */
     /* Solo maiuscole                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0040) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0040) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Solo maiuscole'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0041                    */
     /* Minuscole   +/-                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0041) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0041) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Minuscole   +/-'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0042                    */
     /* Sep.attiva                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0042) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0042) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sep.attiva'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0043                    */
     /* Sep.disatt.                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0043) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0043) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sep.disatt.'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0044                    */
     /* Lato sinis.                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0044) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0044) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lato sinis.'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0045                    */
     /* Lato destro                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0045) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0045) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lato destro '                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0046                    */
     /* Ripetere                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0046) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0046) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ripetere   '                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0047                    */
     /* Ricostruzione                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0047) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0047) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ricostruzione'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0048                    */
     /* Flag riga -                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0048) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0048) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Flag riga - '                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0049                    */
     /* Flag colonna -                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0049) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0049) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Flag colonna -'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0050                    */
     /* Disposizione                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0050) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0050) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Disposizione'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0051                    */
     /* Campi chiave                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0051) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0051) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campi chiave'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0052                    */
     /* Scelta                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0052) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0052) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Scelta '                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0053                    */
     /* Sel.successiva                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0053) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0053) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sel.successiva'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0054                    */
     /* Sel.precedente                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0054) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0054) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sel.precedente '                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0055                    */
     /* Relazioni                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0055) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0055) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Relazioni '                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0056                    */
     /* Comandi operat.                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0056) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0056) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Comandi operat.'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0057                    */
     /* Ordina x chiave                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0057) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0057) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ordina x chiave'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0058                    */
     /* Ordina x NRR                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0058) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0058) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ordina x NRR'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0059                    */
     /* Chiave/NRR                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0059) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0059) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Chiave/NRR'                                                          +
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
     /* Contr.colonne                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0062) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0062) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Contr.colonne '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0063                    */
     /* Desel.tutto                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0063) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0063) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Desel.tutto  '                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0064                    */
     /* Modo carattere                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0064) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0064) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Modo carattere'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0065                    */
     /* Modo esadec                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0065) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0065) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Modo esadec'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0066                    */
     /* Char/Hex                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0066) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0066) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Char/Hex'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0067                    */
     /* SQL-Seleziona                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0067) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0067) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL-Seleziona'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0068                    */
     /* ins.campo ch.                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0068) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0068) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'ins.campo ch.'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0069                    */
     /* Salva Ar.Lav                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0069) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0069) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Salva Ar.Lav'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0070                    */
     /* Carica Ar.Lav                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0070) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0070) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Carica Ar.Lav'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0071                    */
     /* Elimina Ar.Lav                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0071) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0071) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Elimina Ar.Lav'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0072                    */
     /* Seq.di selez.                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0072) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0072) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Seq.di selez.'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0073                    */
     /* Sì                                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0073) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0073) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sì'                                                                  +
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
'No  '                                                                +
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
     /* Inizio                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0076) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0076) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Inizio'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0077                    */
     /* Fine                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0077) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0077) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fine'                                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0078                    */
     /* Area lav.                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0078) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0078) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Area lav.'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0079                    */
     /* Sola dispos.                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0079) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0079) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sola dispos.'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0080                    */
     /* Sì/No val.NULLI                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0080) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0080) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sì/No val.NULLI  '                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0081                    */
     /* Cambio mod.imm.                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0081) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0081) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cambio mod.imm.'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0082                    */
     /* Edit.stringa                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0082) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0082) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Edit.stringa'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0083                    */
     /* Alloc.rec.                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0083) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0083) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Alloc.rec.'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0084                    */
     /* Minuscole                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0084) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0084) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Minuscole'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0085                    */
     /* Stampa                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0085) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0085) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Stampa '                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0086                    */
     /* Inserire                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0086) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0086) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Inserire'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   KEY0087                    */
     /* Cancella                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(KEY0087) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(KEY0087) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cancella'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   MBX0001                    */
     /* Informazioni                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(MBX0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(MBX0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Informazioni'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   MBX0002                    */
     /* Domande                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(MBX0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(MBX0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Domande'                                                             +
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
'File '                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0002                    */
     /* Membro                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Membro   '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0003                    */
     /* Tipo accesso                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tipo accesso'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0004                    */
     /* Lingua                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lingua '                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0005                    */
     /* Autorizz.modif. libreria                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Autorizz.modif. libreria '                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0006                    */
     /* Autorizz.modif. file                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Autorizz.modif. file'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0007                    */
     /* Autorizz.modif. membro                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Autorizz.modif. membro  '                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0008                    */
     /* Autorizz.modifica record                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Autorizz.modifica record '                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0009                    */
     /* Autorizz. modif.SQL WHERE                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Autorizz. modif.SQL WHERE'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0010                    */
     /* Autorizz. modif.SQL ORDER BY                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Autorizz. modif.SQL ORDER BY'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0011                    */
     /* Area di lavoro                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Area di lavoro'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0012                    */
     /*   Membro                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Membro   '                                                         +
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
     /* Libreria                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0015) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0015) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Libreria  '                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0016                    */
     /* Preferenze utente                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Preferenze utente'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0017                    */
     /* Profilo utente                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Profilo utente'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0018                    */
     /* Salva in uscita.                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Salva in uscita.'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0019                    */
     /* Carica solo disposizione                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Carica solo disposizione'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0100                    */
     /* Navigatore db - Peek/400                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Navigatore db - Peek/400'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   PMT0101                    */
     /* Mostra relazioni database                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(PMT0101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(PMT0101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mostra relazioni database   '                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0001                    */
     /* File :                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0001) +
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
     /*   Cmd-ADDMSGD für Message-ID :   TXT0002                    */
     /* Libreria :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Libreria :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0003                    */
     /* Membro :                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Membro :  '                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0004                    */
     /* Lungh.rec.:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lungh.rec.:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0005                    */
     /* N° di rec.:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'N° di rec.:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0006                    */
     /* N° di campi:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'N° di campi:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0007                    */
     /*        Campo:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'       Campo:'                                                       +
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
     /* Dim. file :                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Dim. file :'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0010                    */
     /* N° di rec. :                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'N° di rec. :'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0011                    */
     /* Chiave     :                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Chiave     :'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0012                    */
     /*    Opzioni :                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'   Opzioni :'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0013                    */
     /* File :                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0013) +
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
     /*  Lungh:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0016) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0016) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Lungh:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0017                    */
     /*  Dimen:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0017) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0017) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Dimen:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0018                    */
     /* N°campo  :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0018) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0018) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'N°campo  :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0019                    */
     /*   Nome campo:                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0019) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0019) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  Nome campo:'                                                       +
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
     /* Dimen.:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0021) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0021) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Dimen.:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0022                    */
     /* N°record :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0022) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0022) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'N°record :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0023                    */
     /* Chiave:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0023) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0023) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Chiave:   '                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0024                    */
     /* Opzioni:                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0024) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0024) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Opzioni:'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0025                    */
     /* (Nessun record trovato)                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0025) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0025) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(Nessun record trovato)'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0026                    */
     /* 'ENTER' = Elimina ...                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0026) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0026) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'''ENTER'' = Elimina ...'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0027                    */
     /* Mostra rec esteso...                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0027) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0027) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mostra rec esteso...'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0028                    */
     /* 'ENTER' = Copia ...                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0028) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0028) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'''ENTER'' = Copia ...'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0029                    */
     /* N° rec.:                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0029) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0029) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'N° rec.:'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0030                    */
     /* Contr.sincronia SI                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0030) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0030) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Contr.sincronia SI'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0031                    */
     /* Contr.sincronia NO                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0031) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0031) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Contr.sincronia NO'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0032                    */
     /* (Nessun record trovato)                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0032) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0032) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(Nessun record trovato)'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0033                    */
     /*      - Cerca -                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0033) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0033) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'     - Cerca -'                                                      +
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
     /* Valore (senza apici)                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0036) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0036) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valore (senza apici)'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0037                    */
     /* ricerca generica)                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0037) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0037) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'ricerca generica)'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0038                    */
     /* Dim.max.ricerca                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0038) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0038) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Dim.max.ricerca'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0039                    */
     /* Tipo ricerca :                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0039) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0039) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tipo ricerca :'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0040                    */
     /* (Norm./Sottol./Invers./Finc.)                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0040) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0040) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(Norm./Sottol./Invers./Finc.)'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0041                    */
     /* Perm.minusc...:                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0041) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0041) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Perm.minusc...:'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0042                    */
     /* (1=Sì; 0=No )                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0042) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0042) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'(1=Sì; 0=No )'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0043                    */
     /* - Impostaz.colori -                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0043) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0043) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Impostaz.colori -'                                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0044                    */
     /*   -Scelta colori-                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0044) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0044) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  -Scelta colori-'                                                   +
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
     /* Bianco                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0046) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0046) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Bianco   '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0047                    */
     /* Rosso                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0047) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0047) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Rosso    '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0048                    */
     /* Turchese                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0048) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0048) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Turchese '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0049                    */
     /* Giallo                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0049) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0049) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Giallo   '                                                           +
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
     /* Blu                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0051) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0051) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Blu      '                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0052                    */
     /*  -Copia su file -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0052) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0052) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' -Copia su file -'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0053                    */
     /* File ...........:                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0053) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0053) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'File ...........:'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0054                    */
     /* Libreria  ......:                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0054) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0054) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Libreria  ......:'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0055                    */
     /* Membro   .......:                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0055) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0055) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Membro   .......:'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0056                    */
     /* Sostit. record..:                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0056) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0056) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sostit. record..:'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0057                    */
     /* Creazione file  .:                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0057) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0057) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Creazione file  .:'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0058                    */
     /*   - Dati licenza-                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0058) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0058) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'  - Dati licenza-'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0059                    */
     /*  N°licenza:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0059) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0059) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' N°licenza:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0060                    */
     /* F9=Contr.                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0060) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0060) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'F9=Contr.'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0061                    */
     /* Salvataggio dati di licenza !                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0061) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0061) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Salvataggio dati di licenza !'                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0062                    */
     /* Ci spiace, periodo valutazione terminato                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0062) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0062) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ci spiace, periodo valutazione terminato'                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0063                    */
     /* 'ENTER' = Modifica..                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0063) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0063) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'''ENTER'' = Modifica..'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0064                    */
     /* 'ENTER' = Copia  .....                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0064) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0064) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'''ENTER'' = Copia  .....'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0065                    */
     /* 'ENTER' = Inserimento.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0065) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0065) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'''ENTER'' = Inserimento.'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0066                    */
     /* Continua...                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0066) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0066) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Continua...'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0067                    */
     /*        Fine                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0067) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0067) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'       Fine'                                                         +
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
     /* visualizza 80/132 col.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0069) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0069) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'visualizza 80/132 col.'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0070                    */
     /* Funzione ricerca estesa                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0070) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0070) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funzione ricerca estesa'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0071                    */
     /* Tastiera ridefinibile                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0071) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0071) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tastiera ridefinibile  '                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0072                    */
     /* Cambio della lingua                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0072) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0072) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cambio della lingua '                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0073                    */
     /*  Il più recente                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0073) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0073) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' Il più recente'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0074                    */
     /* Navigatore dati                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0074) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0074) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Navigatore dati '                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0075                    */
     /*      * punti di forza *                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0075) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0075) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'     * punti di forza *      '                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0076                    */
     /* Mostra car.non stamp.                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0076) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0076) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mostra car.non stamp.'                                               +
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
     /* Cerca:                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0078) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0078) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cerca:'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0079                    */
     /*  A   NRR    Campo       Descrizione                     Tip */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0079) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0079) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   NRR    Campo       Descrizione                     Tipo       Po-
sIniz'                                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0080                    */
     /* Visibile .:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0080) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0080) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Visibile .:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0081                    */
     /* Colore..:                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0081) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0081) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Colore..:'                                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0082                    */
     /* Contrasseg:                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0082) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0082) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Contrasseg:'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0083                    */
     /* Mx.Ampiezza                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0083) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0083) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Mx.Ampiezza'                                                         +
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
     /* - Scelta campi-                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0085) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0085) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Scelta campi-'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0086                    */
     /*  A   Campo       Descrizione                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0086) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0086) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Campo       Descrizione                    '                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0087                    */
     /*  A  File                   Testo descriz.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0087) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0087) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A  File                   Testo descriz.                            -
   '                                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0088                    */
     /* - Info relazioni DB        -                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0088) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0088) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Info relazioni DB        -'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0089                    */
     /* Viste logiche                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0089) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0089) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Viste logiche'                                                       +
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
     /* Dimensione ..:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0092) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0092) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Dimensione ..:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0093                    */
     /* Contenuto .:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0093) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0093) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Contenuto .:'                                                        +
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
     /* Pos. iniziale:                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0095) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0095) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pos. iniziale:'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0096                    */
     /* Lungh.buffer                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0096) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0096) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lungh.buffer'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0097                    */
     /*  A   Membro      Descrizione                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0097) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0097) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Membro      Descrizione                                        '+
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0098                    */
     /* - Scelta membro   -                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0098) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0098) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Scelta membro   - '                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0099                    */
     /* Info Membro:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0099) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0099) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Info Membro:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0100                    */
     /* Membro:                                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Membro:'                                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0101                    */
     /* - Info Peek/400 -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Info Peek/400 - '                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0102                    */
     /* Data  . . .                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0102) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0102) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Data  . . .'                                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0103                    */
     /* Versione. .                                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0103) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0103) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Versione. .'                                                         +
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
     /* Fincat.colonne                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0106) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0106) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Fincat.colonne'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0107                    */
     /*  N°Rec  Campo       Descrizione                       C. ch */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0107) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0107) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' N°Rec  Campo       Descrizione                       C. chiave'     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0108                    */
     /*  - SQL  Selez.  -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0108) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0108) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' - SQL  Selez.  - '                                                  +
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
     /* - Crea pgm aggiorn.  -                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0111) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0111) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Crea pgm aggiorn.  -'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0112                    */
     /* Consentite minuscole?                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0112) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0112) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Consentite minuscole? '                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0113                    */
     /* Default Maius/Minusc.?                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0113) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0113) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Default Maius/Minusc.?'                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0114                    */
     /* Salva opzioni come DFT?                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0114) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0114) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Salva opzioni come DFT?'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0115                    */
     /* SQL-Selezioni                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0115) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0115) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SQL-Selezioni'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0116                    */
     /* Selezione area di lavoro                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0116) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0116) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Selezione area di lavoro '                                           +
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
     /* Libreria :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0118) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0118) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Libreria :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0119                    */
     /*  A   Nome a.lav. Descrizione                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0119) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0119) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Nome a.lav. Descrizione'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0120                    */
     /* Elimina area di lavoro                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0120) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0120) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Elimina area di lavoro '                                             +
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
     /* Libreria :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0122) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0122) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Libreria :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0123                    */
     /* Membro  . . :                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0123) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0123) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Membro  . . :'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0124                    */
     /* Descrizione :                                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0124) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0124) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Descrizione :'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0125                    */
     /* Lung.var. .:                                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0125) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0125) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lung.var. .:'                                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0126                    */
     /*  - Selez. Formato Rec-                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0126) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0126) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' - Selez. Formato Rec- '                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0127                    */
     /* Acc.NULLI                                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0127) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0127) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Acc.NULLI'                                                           +
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
     /* *** Record allocato ***                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0129) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0129) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'*** Record allocato ***'                                             +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0130                    */
     /* Record non allocato                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0130) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0130) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record non allocato '                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0131                    */
     /* Blocco lett.record ?                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0131) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0131) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Blocco lett.record ?'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0132                    */
     /* File :                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0132) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0132) +
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
     /*   Cmd-ADDMSGD für Message-ID :   TXT0133                    */
     /* Libreria :                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0133) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0133) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Libreria :'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0134                    */
     /* NRR:                                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0134) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0134) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'NRR:'                                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0135                    */
     /* Pag. :                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0135) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0135) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pag. :'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0136                    */
     /* Nm campo                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0136) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0136) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nm campo'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0137                    */
     /* Descrizione campo                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0137) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0137) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Descrizione campo'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0138                    */
     /* Valore                                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0138) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0138) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valore    '                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0139                    */
     /* Testo                                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0139) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0139) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Testo'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0140                    */
     /*  A   Opz  Descrizione                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0140) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0140) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   Opz  Descrizione                 '                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0141                    */
     /* ------- Opzioni utente --------                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0141) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0141) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'------- Opzioni utente --------'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0142                    */
     /*  A   File        Libreria     Descrizione                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0142) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0142) +
                MSGF(&LIB/&OBJ) +
                MSG( +
' A   File        Libreria     Descrizione'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0143                    */
     /* - Scelta file   -                                           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Scelta file   -'                                                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0144                    */
     /* Iniz. campi nulli?                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0144) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0144) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Iniz. campi nulli?'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0145                    */
     /* Ricorda pos. cursore?                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0145) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0145) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ricorda pos. cursore?'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0146                    */
     /* Inserire                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0146) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0146) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Inserire      '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0147                    */
     /* Cancella                                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0147) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0147) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cancella      '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0148                    */
     /* da:                                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0148) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0148) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'da:           '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0149                    */
     /* Lunghezza:                                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0149) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0149) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lunghezza:    '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0150                    */
     /* a:                                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0150) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0150) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'a:            '                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   TXT0151                    */
     /* Pos. cursore :                                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(TXT0151) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(TXT0151) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Pos. cursore :'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
     /* Formato rec. &3 del file &2/&1 non disponibile.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0001) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0001) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Formato rec. &3 del file &2/&1 non disponibile.'                     +
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
     /* Impossibile reperire la lista dei formati record per il fil */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0002) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0002) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impossibile reperire la lista dei formati record per il file &2/&1 .'+
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
     /* Si sta usando il controllo di sincronia.                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0003) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0003) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Si sta usando il controllo di sincronia.'                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0004                    */
     /* Apertura file senza controllo di sincronia!                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0004) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0004) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Apertura file senza controllo di sincronia!'                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0005                    */
     /* Il file &1 non può essere aperto. Controlla la registrazion */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0005) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0005) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il file &1 non può essere aperto. Controlla la registrazione del lavo-
ro.'                                                                  +
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
     /* Non reperibili informazioni chiavi file &1 in libreria &2.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0006) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0006) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non reperibili informazioni chiavi file &1 in libreria &2.'          +
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
     /* Il file &2/&1 può essere aperto solo in lettura. Modifica d */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0007) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0007) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il file &2/&1 può essere aperto solo in lettura. Modifica dei dati no-
n consentita.'                                                        +
                ) +
                SECLVL( +
'&N &N Possibili cause:   &N &B 1. Sono state iniziate operazioni di D-
EBUG con parametro UPPROD(*NO). &B 2. Il file contiene operatori JOIN -
   &B 3. Sono attive regole di integrità referenziale ma i file non so-
no sotto giornale. &B 4. E''stato definito un trigger ma il programma -
trigger non è nella lista delle librerie &B 5. Si opera con un file lo-
gico multimembro.'                                                    +
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
     /* Il file &2/&1 non è stato trovato.                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0008) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0008) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il file &2/&1 non è stato trovato.'                                  +
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
     /* Errore nel reperimento descrizione oggetto del file  &2/&1. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0009) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0009) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Errore nel reperimento descrizione oggetto del file  &2/&1.'         +
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
     /* Libreria  &1 non trovato.                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0010) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0010) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Libreria  &1 non trovato.'                                           +
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
     /* Il file non può essere aperto. Ulteriori informazioni su me */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0011) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0011) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il file non può essere aperto. Ulteriori informazioni su messaggio di-
 2°livello o nella registrazione lavoro.'                             +
                ) +
                SECLVL( +
'&N &N Testo errore. . :   &1'                                        +
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
     /* Errore I/E  &2: &1                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0012) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0012) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Errore I/E  &2: &1'                                                  +
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
     /* Richiesta SQL in corso ..                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0013) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0013) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Richiesta SQL in corso ..'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0014                    */
     /* Sto conteggiando il n° di rec.selezionati...                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0014) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0014) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sto conteggiando il n° di rec.selezionati...'                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR0143                    */
     /* - Scelta file -                                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR0143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'- Scelta file -'                                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR1000                    */
     /* Accesso non consentito a file &2/&1, membro &3.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR1000) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR1000) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Accesso non consentito a file &2/&1, membro &3.'                     +
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
     /* Elaborazione interrotta da &1                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8100) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8100) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Elaborazione interrotta da &1 '                                      +
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
     /* Inizializzazione in corso                                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8101) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8101) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Inizializzazione in corso'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8102                    */
     /* Sei pregato di posizionare il cursore sul record desiderato */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8102) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8102) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Sei pregato di posizionare il cursore sul record desiderato e ripeter-
e la richiesta.'                                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8103                    */
     /* Non è possibile chiudere il file ora.                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8103) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8103) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non è possibile chiudere il file ora.'                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8104                    */
     /* Reperimento delle descrizioni dei campi del file &2/&1      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8104) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8104) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reperimento delle descrizioni dei campi del file &2/&1'              +
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
     /* Reperimento formati record del file &2/&1.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8105) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8105) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reperimento formati record del file &2/&1.'                          +
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
     /* Reperimento degli attributi di rete                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8106) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8106) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reperimento degli attributi di rete'                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8107                    */
     /* Reperimento attributi dell'oggetto &2/&1.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8107) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8107) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reperimento attributi dell''oggetto &2/&1.'                          +
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
     /* Il campo '&1' non esiste nel file &3/&2                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8108) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8108) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il campo ''&1'' non esiste nel file &3/&2'                           +
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
     /* Reperimento descrizione del membro &3 del file &2/&1.       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8109) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8109) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reperimento descrizione del membro &3 del file &2/&1.'               +
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
     /* Scelta  '&1' non valida.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8110) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8110) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Scelta  ''&1'' non valida.'                                          +
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
     /* Tutti i record sono stati elaborati.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8111) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8111) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tutti i record sono stati elaborati.'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8112                    */
     /* Comando convalidato.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8112) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8112) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Comando convalidato.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8113                    */
     /* Comando interno &1 non valido.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8113) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8113) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Comando interno &1 non valido.'                                      +
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
     /* Creazione programma RPG  ...                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8114) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8114) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Creazione programma RPG  ...'                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8115                    */
     /* Si sta mostrando l'inizio dei dati                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8115) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8115) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Si sta mostrando l''inizio dei dati'                                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8116                    */
     /* Si sta mostrando la fine dei dati.                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8116) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8116) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Si sta mostrando la fine dei dati.'                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8117                    */
     /* Si prega di posizionare il cursore sulla colonna scelta e r */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8117) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8117) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Si prega di posizionare il cursore sulla colonna scelta e ripetere la-
 richiesta.'                                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8118                    */
     /* Tabella per contrass.vuota                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8118) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8118) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tabella per contrass.vuota'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8119                    */
     /* Record già contrassegnato.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8119) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8119) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record già contrassegnato.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8120                    */
     /* Record non trovato                                          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8120) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8120) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record non trovato'                                                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8121                    */
     /* Record non contrassegnato.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8121) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8121) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record non contrassegnato.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8122                    */
     /* Tasto funzionale non consentito                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8122) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8122) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tasto funzionale non consentito'                                     +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8123                    */
     /* Un campo più lungo di 1024 car. non  può  essere&1modificato*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8123) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8123) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Un campo più lungo di 1024 car. non  può  essere&1modificato&2.'     +
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
     /* Operando di confronto '&1' non consentito.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8124) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8124) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Operando di confronto ''&1'' non consentito.'                        +
                ) +
                SECLVL( +
'&N &B Gli operandi validi sono: &N &P EQ   - Uguale &P NE   - Diverso-
  &P LT   - Minore  &P GT   - Maggiore &P LE   - Minore/Uguale  &P GE -
  - Maggiore/Uguale &P LIKE - Simile'                                 +
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
     /* Manca il numero massimo dei record su cui ricercare.        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8125) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8125) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Manca il numero massimo dei record su cui ricercare.'                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8126                    */
     /* Operando di confronto '&1' non consentito.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8126) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8126) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Operando di confronto ''&1'' non consentito.'                        +
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
     /* Ricerca in corso                                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8127) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8127) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ricerca in corso'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8128                    */
     /* Ricerca in corso. &1 su max. &2 record controllati...       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8128) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8128) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ricerca in corso. &1 su max. &2 record controllati...'               +
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
     /* Campo '&1' di tipo '&2' non consentito.                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8129) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8129) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo ''&1'' di tipo ''&2'' non consentito.'                         +
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
     /* Record trovato. 'Cerca'=prosegue /'ENTER'=fine.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8130) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8130) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record trovato. ''Cerca''=prosegue /''ENTER''=fine.'                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8131                    */
     /* Raggiunta la fine dati. Argomento di ricerca non trovato. ' */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8131) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8131) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Raggiunta la fine dati. Argomento di ricerca non trovato. ''Cerca''=C-
ontinua a cercare/''ENTER''=FINE.'                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8132                    */
     /* Ricerca terminata su n°max di record  'Cerca '=Continua a c */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8132) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8132) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ricerca terminata su n°max di record  ''Cerca ''=Continua a cercare/'-
'ENTER''=Fine.'                                                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8133                    */
     /* 1=maius.-minusc.; 0=ignora maius.-minusc.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8133) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8133) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=maius.-minusc.; 0=ignora maius.-minusc.'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8134                    */
     /* Operando &1 con &2 non permesso.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8134) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8134) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Operando &1 con &2 non permesso.'                                    +
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
     /* Operando &1 non consentito se il campo è di tipo &2.        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8135) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8135) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Operando &1 non consentito se il campo è di tipo &2.'                +
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
     /* Campo '&1' non trovato.                                     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8136) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8136) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo ''&1'' non trovato.'                                           +
                ) +
                SECLVL( +
'&N &B Valore speciale: &N &P *RECORD - Ricerca in tutto il file possi-
bile solo con EQ/NE.'                                                 +
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
     /* Reperimento dei campi chiave del file &2/&1                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8137) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8137) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reperimento dei campi chiave del file &2/&1'                         +
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
     /* Trovato valore numerico non valido nel campo &1             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8138) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8138) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Trovato valore numerico non valido nel campo &1'                     +
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
     /* Non riuscito il posizionamento                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8139) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8139) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non riuscito il posizionamento'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8140                    */
     /* E'richiesto un argomento di ricerca.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8140) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8140) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'E''richiesto un argomento di ricerca. '                              +
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
     /* E'valido solo '&1' se il segno è positivo e '&2' se negativ */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8141) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8141) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'E''valido solo ''&1'' se il segno è positivo e ''&2'' se negativo'   +
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
     /* La posizione &1 è riservata per il segno dei valori numeric */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8142) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8142) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La posizione &1 è riservata per il segno dei valori numerici.'       +
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
     /* Il tasto &1 non è assegnato a una funzione.                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8143) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8143) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il tasto &1 non è assegnato a una funzione.'                         +
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
     /* Il comando &1 non può essere richiamato ricorsivamente      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8144) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8144) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il comando &1 non può essere richiamato ricorsivamente'              +
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
     /* Comando non eseguibile con subfile vuoto.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8145) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8145) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Comando non eseguibile con subfile vuoto.'                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8146                    */
     /* Nessun campo valido per la scelta del colore.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8146) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8146) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nessun campo valido per la scelta del colore.'                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8147                    */
     /* Colonna &1 non contrassegnata.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8147) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8147) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Colonna &1 non contrassegnata.'                                      +
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
     /* Spazio non disponibile per la colonna '&1'!                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8148) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8148) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Spazio non disponibile per la colonna ''&1''!'                       +
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
     /* Visualizzazione righe a colori alterni già attiva.          */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8149) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8149) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Visualizzazione righe a colori alterni già attiva.'                  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8150                    */
     /* Visualizzazione righe a colori alterni già disattiva        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8150) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8150) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Visualizzazione righe a colori alterni già disattiva'                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8151                    */
     /* Il nome '&1' non è valido per il file.                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8151) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8151) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il nome ''&1'' non è valido per il file.'                            +
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
     /* Nome libreria '&1' non valido per il file.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8152) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8152) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nome libreria ''&1'' non valido per il file.'                        +
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
     /* Non è valido il nome membro '&1' per il file.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8153) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8153) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non è valido il nome membro ''&1'' per il file.'                     +
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
     /* Parametro '&1' non valido per immissione/aggiornamento.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8154) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8154) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Parametro ''&1'' non valido per immissione/aggiornamento.'           +
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
     /* Parametro '&1' non valido per la creazione del file.        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8155) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8155) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Parametro ''&1'' non valido per la creazione del file.'              +
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
     /* Elaborazione tetminata causa errore.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8156) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8156) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Elaborazione tetminata causa errore.'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8157                    */
     /* Reperimento valore di sistema.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8157) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8157) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Reperimento valore di sistema.'                                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8158                    */
     /* Il codice di licenza '&1' non è valido                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8158) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8158) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il codice di licenza ''&1'' non è valido'                            +
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
     /* Impossibile salvare i dati relativi alla licenza.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8159) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8159) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impossibile salvare i dati relativi alla licenza.'                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8160                    */
     /* Non è disponibile il file di definizione richiesto per la l */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8160) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8160) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non è disponibile il file di definizione richiesto per la lingua &1 .-
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
     /*   Cmd-ADDMSGD für Message-ID :   USR8161                    */
     /* SPLASH-Screen abilitato.                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8161) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8161) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SPLASH-Screen abilitato.'                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8162                    */
     /* SPLASH-Screen disabilitato.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8162) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8162) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'SPLASH-Screen disabilitato.'                                         +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8163                    */
     /* Il campo contiene caratteri non visualizzabili sostituiti c */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8163) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8163) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il campo contiene caratteri non visualizzabili sostituiti con: &1'   +
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
     /* I campi contenenti caratteri non visualizzabili non sono mo */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8164) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8164) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'I campi contenenti caratteri non visualizzabili non sono mostrati.'  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8165                    */
     /* "RIPETI" può essere premuto solo se è stata effettuata una  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8165) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8165) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'"RIPETI" può essere premuto solo se è stata effettuata una scelta.'  +
                ) +
                SECLVL( +
'Spiegazione . . . : F13 (RIPETI) è stato premuto, ma non è stata effe-
ttuata una scelta della funzione da ripetere. &N Correzione  . . . : I-
ndicare una scelta nella colonna delle opzioni di questa pagina e prem-
ere di nuovo "RIPETI".'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8166                    */
     /* Funzione non eseguibile; nessun file è aperto.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8166) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8166) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Funzione non eseguibile; nessun file è aperto.'                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8167                    */
     /* I numeri di sequenza non univoci non sono permessi.         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8167) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8167) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'I numeri di sequenza non univoci non sono permessi.'                 +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8168                    */
     /* 'Il valore &1 non è consentito per l'attributo "Visibile/In */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8168) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8168) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'''Il valore &1 non è consentito per l''attributo "Visibile/Invisibile-
".'''                                                                 +
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
     /* Valore &1 non consentito per l'attributo "Evidenza la colon */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8169) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8169) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valore &1 non consentito per l''attributo "Evidenza la colonna".'    +
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
     /* Il valore &1 per l'attributo "Dimensione massima" non è con */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8170) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8170) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il valore &1 per l''attributo "Dimensione massima" non è consentito.'+
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
     /* Valore '&1' non valido per campi DATA, ORA o TIMESTAMP      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8171) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8171) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valore ''&1'' non valido per campi DATA, ORA o TIMESTAMP'            +
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
     /* In elaborazione: &1                                         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8172) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8172) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'In elaborazione: &1'                                                 +
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
     /* Peek/400 non può essere chiamato ricorsivamente.            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8173) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8173) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Peek/400 non può essere chiamato ricorsivamente.'                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8174                    */
     /* Carattere non valido (&1) in stringa esadecimale.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8174) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8174) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Carattere non valido (&1) in stringa esadecimale.'                   +
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
     /* Il numero dei caratteri deve essere pari.                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8175) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8175) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il numero dei caratteri deve essere pari.'                           +
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
     /* La stringa è troppo lunga.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8176) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8176) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La stringa è troppo lunga.'                                          +
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
     /* Non è ammesso che la posizione iniziale superi la lunghezza */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8177) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8177) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non è ammesso che la posizione iniziale superi la lunghezza stringa.'+
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
     /* La posizione iniziale non può essere zero o inferiore.      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8178) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8178) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La posizione iniziale non può essere zero o inferiore.'              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8179                    */
     /* Nessuna visualizzazione disponibile.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8179) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8179) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nessuna visualizzazione disponibile.'                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8180                    */
     /* Non trovato il membro '&1' .                                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8180) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8180) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non trovato il membro ''&1'' .'                                      +
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
     /* Non è possibile salvare l'ambiente del lavoro senza un nome */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8181) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8181) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non è possibile salvare l''ambiente del lavoro senza un nome.'       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8182                    */
     /* Il valore &1 non è un nome valido per un oggetto AS/400.    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8182) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8182) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il valore &1 non è un nome valido per un oggetto AS/400.'            +
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
     /* Scelta non coerente.                                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8183) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8183) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Scelta non coerente.'                                                +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8184                    */
     /* Questa funzione non è abilitata; si prega di contattare l'a */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8184) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8184) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Questa funzione non è abilitata; si prega di contattare l''amministra-
tore del sistema.'                                                    +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8185                    */
     /* Non è stato fornito e di conseguenza aperto un ambiente di  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8185) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8185) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non è stato fornito e di conseguenza aperto un ambiente di lavoro.'  +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8186                    */
     /* La stringa è troppo breve.                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8186) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8186) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La stringa è troppo breve.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8187                    */
     /* La dimensione del campo supera quella del buffer di dati.   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8187) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8187) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La dimensione del campo supera quella del buffer di dati.'           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8188                    */
     /* Generazione formato video. Fase: &1, Campo: &2              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8188) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8188) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Generazione formato video. Fase: &1, Campo: &2'                      +
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
     /* Generazione progr. RPG. Fase: &1, Campo: &2                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8189) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8189) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Generazione progr. RPG. Fase: &1, Campo: &2'                         +
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
     /* Elaborazione terminata con &1.                              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8190) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8190) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Elaborazione terminata con &1.'                                      +
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
     /* Il campo &1 non permette valori nulli                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8191) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8191) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il campo &1 non permette valori nulli'                               +
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
     /* Trovati valori a virgola mobile non validi nel campo &1.    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8192) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8192) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Trovati valori a virgola mobile non validi nel campo &1.'            +
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
     /* I campi '&1' contengono caratteri non visualizzabili e non  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8193) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8193) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'I campi ''&1'' contengono caratteri non visualizzabili e non sono edi-
tabili in formato testo.'                                             +
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
     /* File '&1' non trovato.                                      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8194) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8194) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'File ''&1'' non trovato.'                                            +
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
     /* Richiesta non consentita. Il campo è protetto.              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8195) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8195) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Richiesta non consentita. Il campo è protetto.'                      +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8196                    */
     /* Il campo &1 non può essere visualizzato o modificato.       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8196) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8196) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il campo &1 non può essere visualizzato o modificato.'               +
                ) +
                SECLVL( +
'&N &N Possibili cause: &N &B 1. Tipo di dati sconosciuto. &B 2. Campo-
 grafico senza CCSID. &B 3. Campo packed o zoned con più di 30 cifre. -
&B 4. Campo a lunghezza variabile di tipo sconosciuto.'               +
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
     /* Record &1 non cancellabile.                                 */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8200) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8200) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Record &1 non cancellabile.'                                         +
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
     /* Il record &1 è stato cancellato.                            */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8201) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8201) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il record &1 è stato cancellato.'                                    +
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
     /* Il record &1 non può essere copiato.                        */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8202) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8202) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il record &1 non può essere copiato.'                                +
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
     /* Il record &1 è stato copiato.                               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8203) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8203) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il record &1 è stato copiato.'                                       +
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
     /* Non selezionati record validi (Help 2° livello disponibile) */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8204) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8204) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non selezionati record validi (Help 2° livello disponibile)'         +
                ) +
                SECLVL( +
'&N &N Posizionare il cursore su un record del subfile e ripetere la r-
ichiesta.'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8205                    */
     /* Non si possono evidenziare più di &1 colonne.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8205) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8205) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non si possono evidenziare più di &1 colonne.'                       +
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
     /* Il record non può essere mostrato; supera la lunghezza mass */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8206) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8206) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il record non può essere mostrato; supera la lunghezza massima consen-
tita &1.'                                                             +
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
     /* Questo file non può essere aperto. La lunghezza record è ma */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8207) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8207) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Questo file non può essere aperto. La lunghezza record è maggiore di -
&1.'                                                                  +
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
     /* Non è possibile modificare campi di sola lettura.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8208) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8208) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non è possibile modificare campi di sola lettura.'                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8209                    */
     /* Si prega di fornire un argomento di ricerca.                */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8209) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8209) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Si prega di fornire un argomento di ricerca.'                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8210                    */
     /* Errore sql &1. &2; testo 2°livello disponibile              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8210) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8210) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Errore sql &1. &2; testo 2°livello disponibile'                      +
                ) +
                SECLVL( +
'&N &N Possibile causa :   &2 &N &B Ulteriori informazioni sono reperi-
bili nella guida SQL per il programmatore o nel file di messaggi QSYS/-
QSQLMSG.'                                                             +
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
     /* Posizionare il cursore su un campo e ripetere la richiesta. */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8211) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8211) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Posizionare il cursore su un campo e ripetere la richiesta.'         +
                ) +
                SECLVL( +
'Spiegazione . . :   Il cursore non è posizionato su un campo oppure i-
l campo su cui si trova non permette la richiesta.'                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8212                    */
     /* La selezione SQL è consentita solo su file fisici. Si desid */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8212) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8212) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La selezione SQL è consentita solo su file fisici. Si desidera che ve-
nga aperto il file fisico?'                                           +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8213                    */
     /* 1=salvare; 0=non salvare                                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8213) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8213) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=salvare; 0=non salvare    '                                        +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8214                    */
     /* 1=minuscole consentite; 0=solo maiuscole                    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8214) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8214) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'1=minuscole consentite; 0=solo maiuscole'                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8215                    */
     /* Inserimento caratteri minuscoli non permesso.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8215) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8215) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Inserimento caratteri minuscoli non permesso.'                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8216                    */
     /* La combinazione immessa non è valida.(Help 2° liv.)         */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8216) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8216) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'La combinazione immessa non è valida.(Help 2° liv.)'                 +
                ) +
                SECLVL( +
'Non si può al tempo stesso proibire i caratteri minuscoli e contempor-
aneamente prevederlo come valore di "default".'                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8217                    */
     /* 'Ordinamento per numero di record non possibile (Help 2° li */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8217) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8217) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'''Ordinamento per numero di record non possibile (Help 2° livello).' +
                ) +
                SECLVL( +
'Il file logico aperto si basa su più di un membro di file fisico.'   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8218                    */
     /* Il record non può essere allocato in quanto il file logico s*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8218) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8218) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il record non può essere allocato in quanto il file logico si basa su-
 più membri fisici. (Help 2°liv.)'                                    +
                ) +
                SECLVL( +
'&N &N Causa . . . . :   Il record non può essere bloccato, in quanto -
il NRR non è univoco, e non è possibile determinare da quale membro di-
 file fisico proviene.'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8219                    */
     /* Il valore '&1' per scelta Sì/No non è consentito.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8219) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8219) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il valore ''&1'' per scelta Sì/No non è consentito.'                 +
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
     /* Valore non editabile. Il campo &1 è NULLO.                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8220) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8220) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valore non editabile. Il campo &1 è NULLO.'                          +
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
     /* Campo &1 non editabile in quanto i dati contenuti sono non  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8221) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8221) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Campo &1 non editabile in quanto i dati contenuti sono non validi.'  +
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
     /* Lunghezza campo &1 supera il massimo permesso dall'editor.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8222) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8222) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lunghezza campo &1 supera il massimo permesso dall''editor.'         +
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
     /* Cambio modalità immissione chiave (caratteri minuscoli).    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8223) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8223) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cambio modalità immissione chiave (caratteri minuscoli).'            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8224                    */
     /* Cambio modalità immissione chiave (caratteri maiuscoli).    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8224) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8224) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Cambio modalità immissione chiave (caratteri maiuscoli).'            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8225                    */
     /* Questo record è in manutenzione da un altro lavoro. Modific */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8225) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8225) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Questo record è in manutenzione da un altro lavoro.&N&NModificarlo co-
munque?'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8226                    */
     /* Operazione di stampa completata con successo.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8226) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8226) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Operazione di stampa completata con successo.'                       +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8227                    */
     /* Non è possibile ottenere un valore numerico valido dalla st */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8227) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8227) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non è possibile ottenere un valore numerico valido dalla stringa ''&1-
''. (Help 2° liv).'                                                   +
                ) +
                SECLVL( +
'&N &N Informazioni. . :   Nella trasformazione in numero di  ''&1'' s-
i è verificato un errore. La stringa non è convertibile in un valore n-
umerico di tipo &2(&3,&4).'                                           +
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
     /* Tipo di dato '&1' invalido                                  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8228) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8228) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Tipo di dato ''&1'' invalido'                                        +
                ) +
                SECLVL( +
'&N &N Spiegazione . . :   Il valore ''&1'' del tipo di dato non è acc-
ettato. Fornire un valore valido per i dati in RPG e ripetere l''opera-
zione'                                                                +
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
     /* Il valore '&1' non è valido per la lunghezza.               */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8229) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8229) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il valore ''&1'' non è valido per la lunghezza.'                     +
                ) +
                SECLVL( +
'&N &N Spiegazione . . :   Il valore fornito ''&1'' come lunghezza cam-
po non è valido. Correggere il dato e ripetere l''operazione.'        +
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
     /* Numero '&1' di posizioni decimali fornito non valido.       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8230) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8230) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Numero ''&1'' di posizioni decimali fornito non valido.'             +
                ) +
                SECLVL( +
'&N &N Spiegazione . . :   Il valore ''&1'' fornito per le cifre decim-
ali non è valido. Correggere il valore e ripetere l''operazione. Notar-
e che non per tutti i tipi di dati occorre fornire le posizioni decima-
li.'                                                                  +
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
     /* Allocazione del record non possibile in copia o inserimento */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8231) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8231) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Allocazione del record non possibile in copia o inserimento.'        +
                ) +
                SECLVL( +
'&N &N Motivo dell''errore:   Si può modificare l''allocazione di un r-
ecord in aggiornamento, ma non durante una operazione di copia o di sc-
rittura di un nuovo record.'                                          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8232                    */
     /* Il record è in modifica da un altro lavoro. Si vuole alloca */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8232) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8232) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il record è in modifica da un altro lavoro.&N&NSi vuole allocarlo com-
unque?'                                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8233                    */
     /* Errore: disposizione non utilizzabile. Gli ID formato record*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8233) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8233) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Errore: disposizione non utilizzabile. Gli ID formato record sono div-
ersi.'                                                                +
                ) +
                SECLVL( +
'&N &N Correzione  . . :   Eliminare il record *RCDFMTID dal file &2/&-
1, membro &3, per disattivare il controllo di livello e applicare di n-
uovo la disposizione. Se riesce, salvare la disposizione per aggiunger-
e l''ID di livello del formato record.'                               +
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
     /* Impossibile caricare la disposizione: gli ID di livello del */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8234) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8234) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impossibile caricare la disposizione: gli ID di livello del formato r-
ecord non corrispondono.'                                             +
                ) +
                SECLVL( +
'&N &N Spiegazione . . :   Non è stato possibile caricare la disposizi-
one indicata dal file di ambiente, in quanto l''ID di livello del form-
ato record della disposizione non corrisponde a quello del file indica-
to.&N Correzione  . . :   Eliminare il record *RCDFMTID dal file &2/&1-
, membro &3, per disattivare il controllo di livello e applicare di nu-
ovo la disposizione. Se riesce, salvare la disposizione per aggiungere-
 l''ID di livello del formato record.'                                +
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
     /* Selezione SQL non supportata per i file logici basati su più*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8235) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8235) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Selezione SQL non supportata per i file logici basati su più membri.'+
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8236                    */
     /* Modalità di inserimento attivata. Posizionare il cursore, q */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8236) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8236) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Modalità di inserimento attivata. Posizionare il cursore, quindi prem-
ere F7.'                                                              +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8237                    */
     /* Premere Invio per inserire il numero di spazi specificato.  */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8237) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8237) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premere Invio per inserire il numero di spazi specificato.'          +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8238                    */
     /* Modalità di cancellazione attivata. Posizionare il cursore, */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8238) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8238) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Modalità di cancellazione attivata. Posizionare il cursore, quindi pr-
emere F8.'                                                            +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8239                    */
     /* Premere Invio per eliminare l'intervallo di caratteri speci */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8239) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8239) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Premere Invio per eliminare l''intervallo di caratteri specificato.' +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8240                    */
     /* Non deve essere inferiore a &1.                             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8240) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8240) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Non deve essere inferiore a &1.'                                     +
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
     /* Lunghezza del campo superata. Il valore supera di &1 caratte*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8241) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8241) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Lunghezza del campo superata. Il valore supera di &1 caratteri.'     +
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
     /* Valore di data, ora o data/ora non valido nel campo &1.    */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8242) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8242) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valore di data, ora o data/ora non valido nel campo &1.'             +
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
     /* Il valore &1 per l'attributo "Codice edit" non è consentito.*/
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8243) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8243) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il valore &1 per l''attributo "Codice edit" non è consentito.'       +
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
     /* Valore del campo &1 fuori dall'intervallo da &2 a &3.       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8244) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8244) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Valore del campo &1 fuori dall''intervallo da &2 a &3.'              +
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
     /* Il campo &1 accetta solo 0 (falso) e 1 (vero).              */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8245) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8245) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Il campo &1 accetta solo 0 (falso) e 1 (vero).'                      +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 10) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR8246                    */
     /* Impossibile salvare il record (stato &1).                   */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR8246) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR8246) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impossibile salvare il record (stato &1).'                           +
                ) +
                SEV(0) +
                FMT( +
                    (*CHAR 5) +
                ) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9989                    */
     /* Impossibile adattare il file delle impostazioni &2/&1.      */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9989) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9989) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impossibile adattare il file delle impostazioni &2/&1.'              +
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
     /* Le impostazioni dell'utente non possono essere salvate.     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9992) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9992) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Le impostazioni dell''utente non possono essere salvate.'            +
                ) +
                SECLVL( +
'&N &N Spiegazione . . :   Non è stato possibile salvare le impostazio-
ni dell''utente a causa del codice di errore &1. &N &N I codici di err-
ore possibili sono: &N &B 1 - Il nome del file (&2) non corrisponde al-
 file aperto. &B 2 - Il nome della libreria (&2) non corrisponde alla -
libreria del file aperto. &B 3 - Non è stato possibile aprire il file -
delle impostazioni utente &3/&2, membro &4.'                          +
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
     /* Impossibile aprire il file. L'uso di SQL è limitato ai FILE */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9993) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9993) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Impossibile aprire il file. L''uso di SQL è limitato ai FILE FISICI' +
                ) +
                SEV(0) +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9994                    */
     /* Trovato errore imprevisto &1 nella funzione C &2.           */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9994) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9994) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Trovato errore imprevisto &1 nella funzione C &2. '                  +
                ) +
                SECLVL( +
'&N &N Testo errore. . :   &3'                                        +
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
     /* Modifica parametri di impostazione in corso ...             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9995) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9995) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Modifica parametri di impostazione in corso ...  '                   +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9996                    */
     /* Nessun file è aperto.                                       */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9996) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9996) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Nessun file è aperto.'                                               +
                ) +
                SEV(0) +
     /*   No replacement variables defined!                         */ +
                ALROPT(*NO) +
                CCSID(&CCSID) +
                /*  -EOF-  */

     /*-------------------------------------------------------------*/
     /*   Cmd-ADDMSGD für Message-ID :   USR9997                    */
     /* &2PEEK/400 è  &1 Shareware. &2 si prega di registrarsi!     */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9997) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9997) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'&2PEEK/400 è  &1 Shareware. &2 si prega di registrarsi!        '     +
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
     /* Ricevuto messaggio inatteso &1 da Programma &2.             */
     /*-------------------------------------------------------------*/

             RMVMSGD MSGID(USR9998) MSGF(&LIB/&OBJ)
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR9998) +
                MSGF(&LIB/&OBJ) +
                MSG( +
'Ricevuto messaggio inatteso &1 da Programma &2.'                     +
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
