       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 1.4.0                               *
       //  Programm : PEEK13                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 07.10.96  RADDATZ                                 *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Dokumentation:                                               *
       //                                                               *
       //  Ermitteln der Teildateibeschreibung                          *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  INPUT-Parameter:                                             *
       //  ================                                             *
       //                                                               *
       //  XQFile  - Qualifizierter Dateiname                           *
       //  XMbr    - Name der Teildatei                                 *
       //                                                               *
       //  OUTPUT-Parameter:                                            *
       //  =================                                            *
       //                                                               *
       //  XValue  - Objektinformationen im Format MBRD0200             *
       //                                                               *
       // ============================================================= *
       // >>PRE-COMPILER<<                                              *
       //   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
       //                           OBJLIB(&LI) DEVLIB(&LI) +           *
       //                           SBMJOB(*NO) BNDDIR(PEEK) +          *
       //                           INSTALL(*NO);                       *
       //   >>EXECUTE<<                                                 *
       // >>END-PRE-COMPILER<<                                          *
       //===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,QUSRMBRD
      /COPY QCOPYLE,MBRD0200

      /define internal_prototype
      /COPY QCOPYLE,PPEEK13
      /undefine internal_prototype

      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58

       dcl-ds mbrd0200 likeds(mbrd0200_t) inz;
       dcl-ds errcode likeds(errcode_t) inz;

       //*******************************************************************
       //           Main  Control block                                    *
       //*******************************************************************

       dcl-pi peek13;
         i_qfile         const likeds(qobj_t);
         i_mbr           const like(mbr_t);
         o_mbrd0200      likeds(mbrd0200_t);
       end-pi;

       //---------------------------------------------------*

       // - Meldung
       p_sndstsmg('USR8109': i_qfile + i_mbr);

       clear errcode;
       errcode.bytprv = %size(errcode);

       qusrmbrd(mbrd0200: %size(mbrd0200)
               : 'MBRD0200'
               : i_qfile: i_mbr: '0': errcode);

       if (errcode.bytavl > 0);
          clear o_mbrd0200;
       else;
          o_mbrd0200 = mbrd0200;
       endif;

       return;

