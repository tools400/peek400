      /*%METADATA                                                     */
      /* %TEXT Peek/400 - Erstellen PEEK Distributions-Bibliothek     */
      /*%EMETADATA                                                    */
      /*===============================================================*/
      /* >>PRE-COMPILER<<                                              */
      /*   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    */
      /*                           OBJLIB(&LI) DEVLIB(&LI) +           */
      /*                           SBMJOB(*NO) BNDDIR(PEEK) +          */
      /*                           INSTALL(*NO);                       */
      /*   >>EXECUTE<<                                                 */
      /* >>END-PRE-COMPILER<<                                          */
      /*===============================================================*/
             CMD        PROMPT('Peek/400 Build')

             PARM       KWD(DEVLIB) +
                          TYPE(*NAME) +
                          LEN(10) +
                          PROMPT('Development library')

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

