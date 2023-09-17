     /* ----------------------------------------------------------- */
     /*   Cmd-ADDMSGD für Message-ID :   USR0001                    */
     /* &4-Member &3 in File &2/&1 already exists.                  */                    /* RADD */
     /* ----------------------------------------------------------- */

             PGM        PARM(&LI)

             DCL        VAR(&LI) TYPE(*CHAR) LEN(10)

             RMVMSGD MSGID(USR0001) MSGF(&LI/CRTMSGDSE)                                   /* RADD */
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0001) +
                MSGF(&LI/CRTMSGDSE ) +
                MSG(+
'&4-Member &3 in File &2/&1 already exists.'                          +
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
     /* &4-Member &3 in File &2/&1 created.                         */                    /* RADD */
     /* ----------------------------------------------------------- */

             RMVMSGD MSGID(USR0002) MSGF(&LI/CRTMSGDSE)                                   /* RADD */
             MONMSG  MSGID(CPF2419)     /* MsgID nicht gefunden */

             ADDMSGD +
                MSGID(USR0002) +
                MSGF(&LI/CRTMSGDSE ) +
                MSG(+
'&4-Member &3 in File &2/&1 created.'                                 +
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
