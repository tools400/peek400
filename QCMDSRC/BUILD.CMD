      /*===============================================================*/
      /* >>PRE-COMPILER<<                                              */
      /*   >>CRTCMD<<  CALL PGM(&LI/CRTPEEKOBJ) PARM(+                 */
      /*                        '&SF' '&SL' '&SM' '&LI' '*NO' +        */
      /*                        'PEEK' '&LI' '*NO');                   */
      /*   >>EXECUTE<<                                                 */
      /* >>END-PRE-COMPILER<<                                          */
      /*===============================================================*/
             CMD        PROMPT('Peek/400 Build')

             PARM       KWD(PRDLIB) +
                          TYPE(*NAME) +
                          LEN(10) +
                          DFT(PEEK) +
                          PROMPT('Production library')

             PARM       KWD(DBGVIEW) +
                          TYPE(*CHAR) +
                          LEN(10) +
                          DFT(*NONE) +
                          RSTD(*YES) +
                          VALUES( +
                            *NONE +
                            *ALL  +
                          ) +
                          PROMPT('Debugging views')

