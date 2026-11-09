             CMD        PROMPT('Initialize Peek/400')                 /* RADD */

             PARM       KWD(LANGUAGE) +
                        TYPE(*CHAR) +
                        LEN(4) +
                        DFT(*SAME) +
                        SPCVAL((*SAME '*')) +
                        PROMPT('Language')                            /* RADD */
                                                                      /* RADD */
             PARM       KWD(CCSID)         +
                        TYPE(*DEC)         +
                        LEN(5)             +
                        DFT(*SAME)         +
                        SPCVAL((*SAME -1)  +
                               (*JOB  -2)) +
                        PMTCTL(*PMTRQS) +
                        PROMPT('Coded character set ID')              /* RADD */

