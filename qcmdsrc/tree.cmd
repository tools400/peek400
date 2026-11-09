             CMD        PROMPT(PMT0101)                               /* RADD */

    /* Datei                                  */
    /* PMT0001:  Datei                        */                      /* RADD */
             PARM       KWD(FILE) +
                        TYPE(FILE) +
                        MIN(1) +
                        CHOICE(*NONE) +
                        PROMPT(PMT0001 1)                             /* RADD */

    /* Zugriffsart                            */
    /* PMT0003:  Zugriffsart                  */                      /* RADD */
             PARM       KWD(ACCESS) +
                        TYPE(*CHAR) +
                        LEN(1) +
                        DFT(*KEY) +
                        RSTD(*YES) +
                        SPCVAL( +
                        (*SQL 2) +
                        (*KEY 1) +
                        (*RRN 0)) +
                        PROMPT(PMT0003 2)                             /* RADD */

    /* Sprache                                */
    /* PMT0004:  Sprache                      */                      /* RADD */
             PARM       KWD(LANGUAGE) +
                        TYPE(*CHAR) +
                        LEN(4) +
                        DFT(*DFT) +
                        PMTCTL(*PMTRQS) +
                        CHOICE('*DFT, Sprachenkürzel') +
                        PROMPT(PMT0004 3)                             /* RADD */

    /* Ändern Bibliothek erlaubt              */
    /* PMT0005:  Ändern Bibliothek erlaubt    */                      /* RADD */
             PARM       KWD(ALWCHGLIB) +
                        TYPE(*CHAR) +
                        LEN(1) +
                        DFT(*DFT) +
                        RSTD(*YES) +
                        SPCVAL((*DFT 'D')  +
                               (*YES '1')  +
                               (*NO  '0')) +
                        PMTCTL(*PMTRQS) +
                        PROMPT(PMT0005 4)                             /* RADD */

    /* Ändern Datei erlaubt                   */
    /* PMT0006:  Ändern Datei erlaubt         */                      /* RADD */
             PARM       KWD(ALWCHGFILE) +
                        TYPE(*CHAR) +
                        LEN(1) +
                        DFT(*DFT) +
                        RSTD(*YES) +
                        SPCVAL((*DFT 'D')  +
                               (*YES '1')  +
                               (*NO  '0')) +
                        PMTCTL(*PMTRQS) +
                        PROMPT(PMT0006 5)                             /* RADD */

    /* Ändern Teildatei erlaubt               */
    /* PMT0007:  Ändern Teildatei erlaubt     */                      /* RADD */
             PARM       KWD(ALWCHGMBR) +
                        TYPE(*CHAR) +
                        LEN(1) +
                        DFT(*DFT) +
                        RSTD(*YES) +
                        SPCVAL((*DFT 'D')  +
                               (*YES '1')  +
                               (*NO  '0')) +
                        PMTCTL(*PMTRQS) +
                        PROMPT(PMT0007 6)                             /* RADD */

    /* Ändern Datensätze erlaubt              */
    /* PMT0008:  Ändern Datensätze erlaubt    */                      /* RADD */
             PARM       KWD(ALWCHGRCD) +
                        TYPE(*CHAR) +
                        LEN(1) +
                        DFT(*DFT) +
                        RSTD(*YES) +
                        SPCVAL((*DFT '*')  +
                               (*YES '1')  +
                               (*NO  '0')) +
                        PMTCTL(*PMTRQS) +
                        PROMPT(PMT0008 7)                             /* RADD */
                                                                      /* RADD */
    /* Ändern SQL WHERE erlaubt               */
    /* PMT0009:  Ändern SQL WHERE erlaubt     */                      /* RADD */
             PARM       KWD(ALWCHGSQLW) +
                        TYPE(*CHAR) +
                        LEN(1) +
                        DFT(*DFT) +
                        RSTD(*YES) +
                        SPCVAL((*DFT '*')  +
                               (*YES '1')  +
                               (*NO  '0')) +
                        PMTCTL(*PMTRQS) +
                        PROMPT(PMT0009 8)                             /* RADD */
                                                                      /* RADD */
    /* Ändern SQL WHERE erlaubt               */
    /* PMT0009:  Ändern SQL WHERE erlaubt     */                      /* RADD */
             PARM       KWD(ALWCHGSQLO) +
                        TYPE(*CHAR) +
                        LEN(1) +
                        DFT(*DFT) +
                        RSTD(*YES) +
                        SPCVAL((*DFT '*')  +
                               (*YES '1')  +
                               (*NO  '0')) +
                        PMTCTL(*PMTRQS) +
                        PROMPT(PMT0010 9)                             /* RADD */
                                                                      /* RADD */
    /* Benutzereinstellungen                  */
    /* PMT0016:  Benutzereinstellungen        */                      /* RADD */
             PARM       KWD(SETTINGS)            +
                        TYPE(SETTINGS)           +
                        MIN(0)                   +
                        CHOICE(*NONE)            +
                        PMTCTL(*PMTRQS)          +
                        PROMPT(PMT0016 10)                            /* RADD */
                                                                      /* RADD */
    /* SQL WHERE                              */
    /* PMT0013:  SQL WHERE                    */                      /* RADD */
             PARM       KWD(WHERE ) +
                        TYPE(*CHAR) +
                        LEN(512) +
                        DFT(*NONE) +
                        SPCVAL( +
                          (*NONE '')) +
                        VARY(*YES *INT2) +
                        CASE(*MIXED) +
                        PMTCTL(PMTCTL1) +
                        PROMPT(PMT0013 11)                            /* RADD */
                                                                      /* RADD */
    /* SQL ORDER BY                           */
    /* PMT0014:  SQL ORDER BY                 */                      /* RADD */
             PARM       KWD(ORDERBY) +
                        TYPE(*CHAR) +
                        LEN(512) +
                        DFT(*NONE) +
                        SPCVAL( +
                          (*NONE '')  +
                          (*KEY    )) +
                        VARY(*YES *INT2) +
                        PMTCTL(PMTCTL1) +
                        PROMPT(PMT0014 12)                            /* RADD */
                                                                      /* RADD */
 PMTCTL1:    PMTCTL     CTL(ACCESS  ) COND((*EQ '2')) +
                                      NBRTRUE(*EQ 1)                  /* RADD */

    /* Datei                                  */
    /* PMT0015:  Bibliothek                   */                      /* RADD */
FILE:        QUAL       TYPE(*NAME) +
                        LEN(10) +
                        MIN(1)
             QUAL       TYPE(*NAME) +
                        LEN(10) +
                        DFT(*LIBL) +
                        SPCVAL( +
                          (*LIBL ) +
                          (*CURLIB)) +
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

