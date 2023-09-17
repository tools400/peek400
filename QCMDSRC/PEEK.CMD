      /*===============================================================*/
      /* >>PRE-COMPILER<<                                              */
      /*   >>CRTCMD<<  CALL PGM(&LI/PEEK99) PARM(+                     */
      /*                        '&SF' '&SL' '&SM' '&LI' '*NO' +        */
      /*                        'PEEK' '&LI' '*NO');                   */
      /*   >>EXECUTE<<                                                 */
      /* >>END-PRE-COMPILER<<                                          */
      /*===============================================================*/
             CMD        PROMPT(PMT0100)                               /* RADD */

    /* Datei                                  */
    /* PMT0001:  Datei                        */                      /* RADD */
             PARM       KWD(FILE)                +
                        TYPE(FILE)               +
                        MIN(1)                   +
                        CHOICE(*NONE)            +
                        PROMPT(PMT0001 1)                             /* RADD */

    /* Teildatei                              */
    /* PMT0002:  Teildatei                    */                      /* RADD */
             PARM       KWD(MEMBER)              +
                        TYPE(*NAME)              +
                        LEN(10)                  +
                        DFT(*FIRST)              +
                        SPCVAL((*FIRST *FIRST)   +
                               (*NONE  *NONE ))  +
                        PROMPT(PMT0002 2)                             /* RADD */
                                                                      /* RADD */
    /* Zugriffsart                            */
    /* PMT0003:  Zugriffsart                  */                      /* RADD */
             PARM       KWD(ACCESS)              +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*KEY)                +
                        RSTD(*YES)               +
                        SPCVAL((*SQL 2)          +
                               (*KEY 1)          +
                               (*RRN 0))         +
                        PROMPT(PMT0003 3)                             /* RADD */

    /* Sprache                                */
    /* PMT0004:  Sprache                      */                      /* RADD */
             PARM       KWD(LANGUAGE)            +
                        TYPE(*CHAR)              +
                        LEN(4)                   +
                        DFT(*DFT)                +
                        SPCVAL((*DFT  ))         +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0004 4)                             /* RADD */
                                                                      /* RADD */
    /* Ändern Bibliothek erlaubt              */
    /* PMT0005:  Ändern Bibliothek erlaubt    */                      /* RADD */
             PARM       KWD(ALWCHGLIB)           +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*DFT)                +
                        RSTD(*YES)               +
                        SPCVAL((*DFT '*')        +
                               (*YES '1')        +
                               (*NO  '0'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0005 5)                             /* RADD */

    /* Ändern Datei erlaubt                   */
    /* PMT0006:  Ändern Datei erlaubt         */                      /* RADD */
             PARM       KWD(ALWCHGFILE)          +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*DFT)                +
                        RSTD(*YES)               +
                        SPCVAL((*DFT '*')        +
                               (*YES '1')        +
                               (*NO  '0'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0006 6)                             /* RADD */
                                                                      /* RADD */
    /* Ändern Teildatei erlaubt               */
    /* PMT0007:  Ändern Teildatei erlaubt     */                      /* RADD */
             PARM       KWD(ALWCHGMBR)           +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*DFT)                +
                        RSTD(*YES)               +
                        SPCVAL((*DFT '*')        +
                               (*YES '1')        +
                               (*NO  '0'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0007 7)                             /* RADD */

    /* Ändern Datensätze erlaubt              */
    /* PMT0008:  Ändern Datensätze erlaubt    */                      /* RADD */
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
                        PROMPT(PMT0008 8)                             /* RADD */
                                                                      /* RADD */
    /* Ändern SQL WHERE erlaubt               */
    /* PMT0009:  Ändern SQL WHERE erlaubt     */                      /* RADD */
             PARM       KWD(ALWCHGSQLW)          +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*DFT)                +
                        RSTD(*YES)               +
                        SPCVAL((*DFT '*')        +
                               (*YES '1')        +
                               (*NO  '0'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0009 9)                             /* RADD */
                                                                      /* RADD */
    /* Ändern SQL ORDER BY erlaubt            */
    /* PMT0010:  Ändern SQL ORDER BY erlaubt  */                      /* RADD */
             PARM       KWD(ALWCHGSQLO)          +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*DFT)                +
                        RSTD(*YES)               +
                        SPCVAL((*DFT '*')        +
                               (*YES '1')        +
                               (*NO  '0'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0010 10)                            /* RADD */

    /* Arbeitsumgebung                        */
    /* PMT0011:  Arbeitsumgebung              */                      /* RADD */
             PARM       KWD(ENVFILE)             +
                        TYPE(ENVFILE)            +
                        MIN(0)                   +
                        CHOICE(*NONE)            +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0011 11)                            /* RADD */

    /* ... Teildatei                          */
    /* PMT0012:  Teildatei                    */                      /* RADD */
             PARM       KWD(ENVMBR)              +
                        TYPE(*NAME)              +
                        LEN(10)                  +
                        DFT(*FILE)               +
                        SPCVAL((*FILE )          +
                               (*FIRST))         +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0012 12)                            /* RADD */
                                                                      /* RADD */
    /* ... Autom. speichern ENVFILE           */
    /* PMT0018:  Speichern beim Verlassen     */                      /* RADD */
             PARM       KWD(ENVSAVE)             +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*NO)                 +
                        SPCVAL((*NO  '0')        +
                               (*YES '1'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0018 13)                            /* RADD */
                                                                      /* RADD */
    /* ... Nur Layout laden                   */
    /* PMT0019:  Nur Layout laden             */                      /* RADD */
             PARM       KWD(ENVLAYOUT)           +
                        TYPE(*CHAR)              +
                        LEN(1)                   +
                        DFT(*NO)                 +
                        SPCVAL((*NO  '0')        +
                               (*YES '1'))       +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0019 14)                            /* RADD */
                                                                      /* RADD */
    /* Benutzereinstellungen                  */
    /* PMT0016:  Benutzereinstellungen        */                      /* RADD */
             PARM       KWD(SETTINGS)            +
                        TYPE(SETTINGS)           +
                        MIN(0)                   +
                        CHOICE(*NONE)            +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0016 15)                            /* RADD */
                                                                      /* RADD */
    /* SQL WHERE                              */
    /* PMT0013:  SQL WHERE                    */                      /* RADD */
             PARM       KWD(WHERE )              +
                        TYPE(*CHAR)              +
                        LEN(512)                 +
                        DFT(*NONE)               +
                        SPCVAL((*NONE ''))       +
                        VARY(*YES *INT2)         +
                        CASE(*MIXED)             +
                        PMTCTL(PMTCTL1)          +
                        PROMPT(PMT0013 16)                            /* RADD */
                                                                      /* RADD */
    /* SQL ORDER BY                           */
    /* PMT0014:  SQL ORDER BY                 */                      /* RADD */
             PARM       KWD(ORDERBY)             +
                        TYPE(*CHAR)              +
                        LEN(512)                 +
                        DFT(*NONE)               +
                        SPCVAL((*NONE '')        +
                               (*KEY    ))       +
                        VARY(*YES *INT2)         +
                        PMTCTL(PMTCTL1)          +
                        PROMPT(PMT0014 17)                            /* RADD */
                                                                      /* RADD */
 PMTCTL1:    PMTCTL     CTL(ACCESS  ) COND((*EQ '2')) +
                                      NBRTRUE(*EQ 1)                  /* RADD */

    /* Datei                                  */
    /* PMT0015:  Bibliothek                   */                      /* RADD */
FILE:        QUAL       TYPE(*GENERIC)           +
                        LEN(10)                  +
                        MIN(1)                   +
                        SPCVAL((*PRV))                                /* RADD */
             QUAL       TYPE(*NAME)              +
                        LEN(10)                  +
                        DFT(*LIBL)               +
                        SPCVAL((*LIBL )          +
                               (*CURLIB))        +
                        PROMPT(PMT0015)                               /* RADD */

    /* Arbeitsumgebung                        */
    /* PMT0015:  Bibliothek                   */                      /* RADD */
ENVFILE:     QUAL       TYPE(*NAME)              +
                        LEN(10)                  +
                        MIN(0)                   +
                        DFT(*ENVFILE)            +
                        SPCVAL((*NONE)           +
                               (*ENVFILE))                            /* RADD */
             QUAL       TYPE(*NAME)              +
                        LEN(10)                  +
                        DFT(*LIBL)               +
                        SPCVAL((*LIBL ))         +
                        PROMPT(PMT0015)                               /* RADD */
                                                                      /* RADD */
    /* Benutzereinstellungen                  */
    /* PMT0001:  Datei                        */                      /* RADD */
    /* PMT0017:  Benutzerprofil               */                      /* RADD */
SETTINGS:    ELEM       TYPE(STGFILE)            +
                        DFT(*DFT)                +
                        SNGVAL((*DFT))           +
                        PROMPT(PMT0001)                               /* RADD */
             ELEM       TYPE(*NAME)              +
                        DFT(*DFT)                +
                        SPCVAL((*DFT))           +
                        PROMPT(PMT0017)                               /* RADD */
                                                                      /* RADD */
    /* Benutzereinstellungen                  */
    /* PMT0015:  Bibliothek                   */                      /* RADD */
STGFILE:     QUAL       TYPE(*NAME)              +
                        LEN(10)                  +
                        MIN(1)                                        /* RADD */
             QUAL       TYPE(*NAME)              +
                        LEN(10)                  +
                        DFT(*PRDLIB)             +
                        SPCVAL((*LIBL )          +
                               (*CURLIB)         +
                               (*PRDLIB))        +
                        PROMPT(PMT0015)                               /* RADD */

