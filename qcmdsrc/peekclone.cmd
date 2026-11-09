             CMD        PROMPT('Clone PEEK/400 library')

             PARM       KWD(TOLIB)               +
                        TYPE(*NAME)              +
                        MIN(1)                   +
                        PROMPT('To library')

             PARM       KWD(FROMLIB)             +
                        TYPE(*NAME)              +
                        MIN(0)                   +
                        DFT(PEEK)                +
                        PROMPT('From library')

