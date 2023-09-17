     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
     /* &4-Teildatei &3 in Datei &2/&1 existiert bereits.           */                    /* RADD */
     /* ----------------------------------------------------------- */

             PGM        PARM(&LI)

             DCL        VAR(&LI) TYPE(*CHAR) LEN(10)

             RMVMSGD MSGID(USR0001) MSGF(&LI/CRTMSGDS )                                   /* RADD */
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0001) +
                MSGF(&LI/CRTMSGDS ) +
                MSG(+
'&4-Teildatei &3 in Datei &2/&1 existiert bereits.'                   +
                ) +
                SEV(00) +
                FMT( +
                    (*CHAR  10) +
                    (*CHAR  10) +
                    (*CHAR  10) +
                    (*CHAR  10) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */                                                             /* RADD */

     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0002                    */
     /* &4-Teildatei &3 in Datei &2/&1 erstellt.                    */                    /* RADD */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(USR0002) MSGF(&LI/CRTMSGDS )                                   /* RADD */
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0002) +
                MSGF(&LI/CRTMSGDS ) +
                MSG(+
'&4-Teildatei &3 in Datei &2/&1 erstellt.'                            +
                ) +
                SEV(00) +
                FMT( +
                    (*CHAR  10) +
                    (*CHAR  10) +
                    (*CHAR  10) +
                    (*CHAR  10) +
                ) +
                ALROPT(*NO) +
                CCSID( 65535) +
                /*  -EOF-  */                                                             /* RADD */

             ENDPGM
