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
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK60
      /undefine internal_prototype
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
      /COPY QCOPYLE,CEECNDHDLR
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK60          PI
     D  i_alwLC                            const like(r§bool)
     D  o_numPasses                              like(r§int4)
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
      *  Steuerung: Generieren Display File und RPG Programm
     C                   Eval      o_numPasses = cNumPasses_PEEK08
      *
      *  1. Aufruf PEEK15 (generieren Display File)
     C                   Eval      o_numPasses = o_numPasses + cNumPasses_PEEK15
      *
      *  2. Aufruf PEEK15 (generieren Display File, lower cases)
     C                   If        (i_alwLC = bTrue)
     C                   Eval      o_numPasses = o_numPasses + cNumPasses_PEEK15
     C                   Endif
      *
      *  3. Aufruf PEEK16 (generieren RPG Programm)
     C                   Eval      o_numPasses = o_numPasses + cNumPasses_PEEK16
      *
      *  Programm verlassen
     C     ende          Tag
      *
     C                   Return
      *
      *============================================================*
      *  Program error handler                                     *
      *============================================================*
      *
     P errorHandler    b                   
     D                 pi
     D i_condToken                         value likeds(cee_fc_t)
     D i_pCommArea                   10i 0 value
     D o_action                      10i 0
     D o_newCondToken                            likeds(cee_fc_t)
      /free

         dump;
         o_action = CEE_PERCOLATE;

      /end-free
     P                 e
      *
