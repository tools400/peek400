      /*%METADATA                                                     */
      /* %TEXT Compile Peek/400 Object                                */
      /*%EMETADATA                                                    */
/* =================================================================== */
/* >>PRE-COMPILER<<                                                    */
/*   >>CRTCMD<< CRTCMD       CMD(&LI/CRTPEEKOBJ) +                     */
/*                           SRCFILE(&SL/&SF) SRCMBR(&SM);             */
/*   >>IMPORTANT<<                                                     */
/*     >>PARM<< PGM(*LIBL/PEEK99);                                     */
/*   >>END-IMPORTANT<<                                                 */
/*   >>EXECUTE<<                                                       */
/* >>END-PRE-COMPILER<<                                                */
/* =================================================================== */
             CMD        PROMPT('Compile Peek/400 Object')

             PARM       KWD(SRCFILE)             +
                        TYPE(FILE)               +
                        MIN(1)                   +
                        PROMPT('Source file' 1)

             PARM       KWD(SRCMBR)              +
                        TYPE(*NAME)              +
                        MIN(1)                   +
                        PROMPT('Source member' 2)

             PARM       KWD(OBJLIB)              +
                        TYPE(*NAME)              +
                        MIN(1)                   +
                        PROMPT('Object library' 3)

             PARM       KWD(SBMJOB)              +
                        TYPE(*CHAR)              +
                        LEN(10)                  +
                        DFT(*NO)                 +
                        SPCVAL(*NO               +
                               *YES)             +
                        PROMPT('Submit job')

             PARM       KWD(BNDDIR)              +
                        TYPE(*CHAR)              +
                        LEN(10)                  +
                        DFT(PEEK)                +
                        PROMPT('Binding directory')

             PARM       KWD(DEVLIB)              +
                        TYPE(*NAME)              +
                        MIN(1)                   +
                        PROMPT('Developing library' 4)

             PARM       KWD(INSTALL)             +
                        TYPE(*LGL)               +
                        DFT(*NO)                 +
                        SPCVAL((*YES '1')        +
                               (*NO  '0'))       +
                        PROMPT('Installation program')

FILE:        QUAL       TYPE(*NAME)              +
                        LEN(10)                  +
                        MIN(1)
             QUAL       TYPE(*NAME)              +
                        LEN(10)                  +
                        DFT(*LIBL)               +
                        SPCVAL((*LIBL )          +
                               (*CURLIB))        +
                        PROMPT('Library')

