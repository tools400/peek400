      /*%METADATA                                                     */
      /* %TEXT Peek/400 - File Editor                                 */
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
             CMD        PROMPT(PMT0100)

    /* Datei                                  */
    /* PMT0001:  Datei                        */
             PARM       KWD(FILE)                +
                        TYPE(FILE)               +
                        MIN(1)                   +
                        CHOICE(*NONE)            +
                        PROMPT(PMT0001 1)

    /* Teildatei                              */
    /* PMT0002:  Teildatei                    */
             PARM       KWD(MEMBER)              +
                        TYPE(*NAME)              +
                        LEN(10)                  +
                        DFT(*FIRST)              +
                        SPCVAL((*FIRST *FIRST)   +
                               (*NONE  *NONE ))  +
                        PROMPT(PMT0002 2)

    /* Zugriffsart                            */
    /* PMT0003:  Zugriffsart                  */
             PARM       KWD(ACCESS)              +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*KEY)                +
                        RSTD(*YES)               +
                        SPCVAL((*SQL 2)          +
                               (*KEY 1)          +
                               (*RRN 0))         +
                        PROMPT(PMT0003 3)

    /* Sprache                                */
    /* PMT0004:  Sprache                      */
             PARM       KWD(LANGUAGE)            +
                        TYPE(*CHAR)              +
                        LEN(4)                   +
                        DFT(*DFT)                +
                        SPCVAL((*DFT  ))         +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0004 4)

    /* Ändern Bibliothek erlaubt              */
    /* PMT0005:  Ändern Bibliothek erlaubt    */
             PARM       KWD(ALWCHGLIB)           +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*DFT)                +
                        RSTD(*YES)               +
                        SPCVAL((*DFT '*')        +
                               (*YES '1')        +
                               (*NO  '0'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0005 5)

    /* Ändern Datei erlaubt                   */
    /* PMT0006:  Ändern Datei erlaubt         */
             PARM       KWD(ALWCHGFILE)          +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*DFT)                +
                        RSTD(*YES)               +
                        SPCVAL((*DFT '*')        +
                               (*YES '1')        +
                               (*NO  '0'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0006 6)

    /* Ändern Teildatei erlaubt               */
    /* PMT0007:  Ändern Teildatei erlaubt     */
             PARM       KWD(ALWCHGMBR)           +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*DFT)                +
                        RSTD(*YES)               +
                        SPCVAL((*DFT '*')        +
                               (*YES '1')        +
                               (*NO  '0'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0007 7)

    /* Ändern Datensätze erlaubt              */
    /* PMT0008:  Ändern Datensätze erlaubt    */
             PARM       KWD(ALWCHGRCD)           +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*DFT)                +
                        RSTD(*YES)               +
                        SPCVAL((*DFT   '*')      +
                               (*YES   '1')      +
                               (*NOKEY '2')      +
                               (*NO    '0'))     +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0008 8)

    /* Ändern SQL WHERE erlaubt               */
    /* PMT0009:  Ändern SQL WHERE erlaubt     */
             PARM       KWD(ALWCHGSQLW)          +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*DFT)                +
                        RSTD(*YES)               +
                        SPCVAL((*DFT '*')        +
                               (*YES '1')        +
                               (*NO  '0'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0009 9)

    /* Ändern SQL ORDER BY erlaubt            */
    /* PMT0010:  Ändern SQL ORDER BY erlaubt  */
             PARM       KWD(ALWCHGSQLO)          +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*DFT)                +
                        RSTD(*YES)               +
                        SPCVAL((*DFT '*')        +
                               (*YES '1')        +
                               (*NO  '0'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0010 10)

    /* Arbeitsumgebung                        */
    /* PMT0011:  Arbeitsumgebung              */
             PARM       KWD(ENVFILE)             +
                        TYPE(ENVFILE)            +
                        MIN(0)                   +
                        CHOICE(*NONE)            +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0011 11)

    /* ... Teildatei                          */
    /* PMT0012:  Teildatei                    */
             PARM       KWD(ENVMBR)              +
                        TYPE(*NAME)              +
                        LEN(10)                  +
                        DFT(*FILE)               +
                        SPCVAL((*FILE )          +
                               (*FIRST))         +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0012 12)

    /* ... Autom. speichern ENVFILE           */
    /* PMT0018:  Speichern beim Verlassen     */
             PARM       KWD(ENVSAVE)             +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*NO)                 +
                        SPCVAL((*NO  '0')        +
                               (*YES '1'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0018 13)

    /* ... Nur Layout laden                   */
    /* PMT0019:  Nur Layout laden             */
             PARM       KWD(ENVLAYOUT)           +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*NO)                 +
                        SPCVAL((*NO  '0')        +
                               (*YES '1'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0019 14)

    /* Benutzereinstellungen                  */
    /* PMT0016:  Benutzereinstellungen        */
             PARM       KWD(SETTINGS)            +
                        TYPE(SETTINGS)           +
                        MIN(0)                   +
                        CHOICE(*NONE)            +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0016 15)

    /* SQL WHERE                              */
    /* PMT0013:  SQL WHERE                    */
             PARM       KWD(WHERE )              +
                        TYPE(*CHAR)              +
                        LEN(512)                 +
                        DFT(*NONE)               +
                        SPCVAL((*NONE ''))       +
                        VARY(*YES *INT2)         +
                        CASE(*MIXED)             +
                        PMTCTL(PMTCTL1)          +
                        PROMPT(PMT0013 16)

    /* SQL ORDER BY                           */
    /* PMT0014:  SQL ORDER BY                 */
             PARM       KWD(ORDERBY)             +
                        TYPE(*CHAR)              +
                        LEN(512)                 +
                        DFT(*NONE)               +
                        SPCVAL((*NONE '')        +
                               (*KEY    ))       +
                        VARY(*YES *INT2)         +
                        PMTCTL(PMTCTL1)          +
                        PROMPT(PMT0014 17)

 PMTCTL1:    PMTCTL     CTL(ACCESS  ) COND((*EQ '2')) +
                                      NBRTRUE(*EQ 1)

    /* Datei                                  */
    /* PMT0015:  Bibliothek                   */
FILE:        QUAL       TYPE(*GENERIC)           +
                        LEN(10)                  +
                        MIN(1)                   +
                        SPCVAL((*PRV))
             QUAL       TYPE(*NAME)              +
                        LEN(10)                  +
                        DFT(*LIBL)               +
                        SPCVAL((*LIBL )          +
                               (*CURLIB))        +
                        PROMPT(PMT0015)

    /* Arbeitsumgebung                        */
    /* PMT0015:  Bibliothek                   */
ENVFILE:     QUAL       TYPE(*NAME)              +
                        LEN(10)                  +
                        MIN(0)                   +
                        DFT(*ENVFILE)            +
                        SPCVAL((*NONE)           +
                               (*ENVFILE))
             QUAL       TYPE(*NAME)              +
                        LEN(10)                  +
                        DFT(*LIBL)               +
                        SPCVAL((*LIBL ))         +
                        PROMPT(PMT0015)

    /* Benutzereinstellungen                  */
    /* PMT0001:  Datei                        */
    /* PMT0017:  Benutzerprofil               */
SETTINGS:    ELEM       TYPE(STGFILE)            +
                        DFT(*DFT)                +
                        SNGVAL((*DFT))           +
                        PROMPT(PMT0001)
             ELEM       TYPE(*NAME)              +
                        DFT(*DFT)                +
                        SPCVAL((*DFT))           +
                        PROMPT(PMT0017)

    /* Benutzereinstellungen                  */
    /* PMT0015:  Bibliothek                   */
STGFILE:     QUAL       TYPE(*NAME)              +
                        LEN(10)                  +
                        MIN(1)
             QUAL       TYPE(*NAME)              +
                        LEN(10)                  +
                        DFT(*PRDLIB)             +
                        SPCVAL((*LIBL )          +
                               (*CURLIB)         +
                               (*PRDLIB))        +
                        PROMPT(PMT0015)

