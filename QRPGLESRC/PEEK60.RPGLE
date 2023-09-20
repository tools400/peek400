      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.3.2                               *
      *  Programm : PEEK60                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 08.03.2006  Thomas Raddatz                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Ermitteln Aufwand für Pgm-Generieren              *
      *                                                               *
      * ============================================================= *
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
      *                           OBJLIB(&LI) DEVLIB(&LI) +           *
      *                           SBMJOB(*NO) BNDDIR(PEEK) +          *
      *                           INSTALL(*NO);                       *
      *   >>EXECUTE<<                                                 *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
      *  *ENTRY
     D xAlwLC          S               N
     D xNumPasses      S             10I 0
      *
     D cNumPasses_PEEK08...
     D                 C                   const(4)
      *
     D cNumPasses_PEEK15...
     D                 C                   const(2)
      *
     D cNumPasses_PEEK16...
     D                 C                   const(7)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     C     *entry        Plist
     C                   Parm                    xAlwLC
     C                   Parm                    xNumPasses
      *
      *---------------------------------------------------*
      *
     C                   Exsr      First
      *
      *  Steuerung: Generieren Display File und RPG Programm
     C                   Eval      xNumPasses = cNumPasses_PEEK08
      *
      *  1. Aufruf PEEK15 (generieren Display File)
     C                   Eval      xNumPasses = xNumPasses + cNumPasses_PEEK15
      *
      *  2. Aufruf PEEK15 (generieren Display File, lower cases)
     C                   If        xAlwLC
     C                   Eval      xNumPasses = xNumPasses + cNumPasses_PEEK15
     C                   Endif
      *
      *  3. Aufruf PEEK16 (generieren RPG Programm)
     C                   Eval      xNumPasses = xNumPasses + cNumPasses_PEEK16
      *
      *  Programm verlassen
     C     ende          Tag
      *
     C                   Return
      *
      *============================================================*
      *    First         Initialisierung                           *
      *============================================================*
      *
     C     First         Begsr
      *
     C                   Endsr
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *inzsr        Begsr
      *
     C                   Endsr
      *
      *============================================================*
      *    *PSSR         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *pssr         Begsr
      *
     C                   Dump
      *
     C                   Endsr     '*CANCL'
      *
