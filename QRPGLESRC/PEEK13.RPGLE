      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK13                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 07.10.96  RADDATZ                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Ermitteln der Teildateibeschreibung                          *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  INPUT-Parameter:                                             *
      *  ================                                             *
      *                                                               *
      *  XQFile  - Qualifizierter Dateiname                           *
      *  XMbr    - Name der Teildatei                                 *
      *                                                               *
      *  OUTPUT-Parameter:                                            *
      *  =================                                            *
      *                                                               *
      *  XValue  - Objektinformationen im Format MBRD0200             *
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
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,QUSRMBRD
      /COPY QCOPYLE,MBRD0200
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK13
      /undefine internal_prototype
      *
      /COPY QCOPYLE,API_ERROR
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      *
     D MBRD0200        DS                  likeds(MBRD0200_t) inz
      *
      ********************************************************************
      *           Main  Control block                                    *
      ********************************************************************
      *
     D PEEK13          PI
     D  i_qFile                            const likeds(r§qObj)
     D  i_mbr                              const like(r§mbr)
     D  o_mbrd0200                               likeds(MBRD0200_t)
      *
      *---------------------------------------------------*
      *
      * - Meldung
     C                   Callp     p_sndStsMg('USR8109': i_qFile + i_mbr)
      *
     C                   CALLP     QUSRMBRD(MBRD0200: %size(MBRD0200)
     C                                      : 'MBRD0200'
     C                                      : i_qFile: i_mbr: '0': §ErrorCode)
      *
     C                   IF        (§ErrAvail > 0)
     C                   CLEAR                   o_MBRD0200
     C                   ELSE
     C                   EVAL      o_mbrd0200 = MBRD0200
     C                   Endif
      *
     C                   RETURN
      *
