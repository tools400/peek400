      /*===============================================================*/
      /* >>PRE-COMPILER<<                                              */
      /*   >>CRTCMD<<  CRTCMD CMD(&LI/&OB) PGM(&LI/&OB) +              */
      /*                      SRCFILE(&SL/&SF) SRCMBR(*CMD);           */
      /*   >>EXECUTE<<                                                 */
      /* >>END-PRE-COMPILER<<                                          */
      /*===============================================================*/
             CMD        PROMPT('Distribute PEEK/400 library')

             PARM       KWD(RMTUSER)             +
                        TYPE(*CHAR)              +
                        MIN(1)                   +
                        PROMPT('Remote user ID' 2)

             PARM       KWD(RMTPWD)              +
                        TYPE(*CHAR)              +
                        MIN(1)                   +
                        DSPINPUT(*NO)            +
                        PROMPT('Remote password' 3)

             PARM       KWD(RMTLOC)              +
                        TYPE(*NAME)              +
                        MIN(0)                   +
                        MAX(10)                  +
                        DFT(*NONE)               +
                        SPCVAL(*NONE)            +
                        PROMPT('Remote location' 1)

