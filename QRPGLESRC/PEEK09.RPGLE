      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK09                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 02.10.96  RADDATZ                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Ermitteln der Objektattribute                                *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  INPUT-Parameter:                                             *
      *  ================                                             *
      *                                                               *
      *  XQObj   - Qualifizierter Objektname                          *
      *                                                               *
      *  OUTPUT-Parameter:                                            *
      *  =================                                            *
      *                                                               *
      *  XValue  - Objektinformationen im Format OBJD0400             *
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
      *  API - DATENSTRUKTUREN                             *
      *----------------------------------------------------*
      *
      *  declarations for QUSROBJD
     D OBJD0400        DS                  likeds(OBJD0400_t) inz
     D errCode         DS                  likeds(errCode_t) inz
      *
      /COPY QCOPYLE,OBJD0400
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,QUSROBJD
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK09
      /undefine internal_prototype
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
      ********************************************************************
      *           Main  Control block                                    *
      ********************************************************************
      *
     D PEEK09          PI
     D  i_qFile                            const likeds(qObj_t)
     D  o_data                                   likeds(OBJD0400_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   Callp     p_sndStsMg('USR8107': i_qFile)
      *
     C                   Clear                   errCode
     C                   Eval      errCode.bytPrv = %size(errCode)
      *
     C                   CALLP     QUSROBJD(OBJD0400: %size(OBJD0400)
     C                                      : 'OBJD0400'
     C                                      : i_qFile: '*FILE'
     C                                      : errCode)
      *
     C                   IF        (errCode.bytAvl = 0)
     C                   EVAL      o_data = OBJD0400
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
     C                   ELSE
     C                   CLEAR                   OBJD0400
     C                   EVAL      o_data = OBJD0400
     C                   EVAL      o_msgID = errCode.excID
     C                   EVAL      o_msgDta = errCode.excDta
     C                   Endif
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     ENDE          TAG
      *
     C                   RETURN
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
