      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK04                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 28.10.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Abrufen der Dateiinformationen: hier prüfen auf              *
      *                                  Schlüsselinformationen       *
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
      *  list API format KEYL0100
      /COPY QCOPYLE,KEYL0100
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK04
      /undefine internal_prototype
      *
      /COPY QCOPYLE,PPEEK41
      *
      *---Copystrecken für Nachrichtenaufbau---------------*
      /COPY QCOPYLE,USR0006
      *----------------------------------------------------*
      *
      *---Versenden von Nachrichten------------------------*
      /COPY QCOPYLE,API_ERROR
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
     D PEEK41_NAME     S                   like(r§pgmCallN) inz
      *
     D data            S            512A   inz
     D nbrOfKey        S                   like(r§int4    ) inz
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK04          PI
     D  i_qFile                            const likeds(r§qObj)
     D  i_rcdFmt                           const like(r§fmt)
     D  o_msgID                                  like(r§msgId)
     D  o_msgDta                                 like(r§msgDta)
      *
      *---------------------------------------------------*
     C                   EXSR      First
      *---------------------------------------------------*
      *
      *  Abrufen der Dateiinformationen ...
     C                   CALLP     PEEK41(i_qFile: i_rcdFmt: '*CREATE'
     C                                    : nbrOfKey: data)
      *
     C                   IF        (nbrOfKey <= 0)
      *  ... schade, Aufruf ist fehlgeschlagen
     C                   ELSE
      *  Abrufen der Schlüsselfeldinformationen ...
     C                   CALLP     PEEK41(i_qFile: i_rcdFmt: '*KEY'
     C                                    : nbrOfKey: data)
      *
     C     nbrOfKey      IFLE      *ZEROS
     C                   EVAL      o_msgID = 'USR0006'
     C                   EVAL      USR00061 = i_qFile.name
     C                   EVAL      USR00062 = i_qFile.lib
     C                   EVAL      o_msgDta = USR0006
     C                   ELSE
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
     C                   Endif
     C                   Endif
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     ENDE          TAG
      *
     C                   EVAL      *INLR = '1'
      *
      *====================================================*
      *  First  --  Initialize program                     *
      *====================================================*
      *
     C     First         BEGSR
      *
     C                   EVAL      NbrOfKey = *ZEROS
      *
      * - Meldung
      ***                Callp     p_sndStsMg('USR8137': XQFile)
      *
      * - Los gehts'
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
     C                   ENDSR
      *
      *====================================================*
      *  *INZSR --  Initialize program                     *
      *====================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   Eval      PEEK41_NAME = f_pgmCallN('PEEK41')
      *
     C                   ENDSR
      *
      *====================================================*
      *  *PSSR  --  Program error handler                  *
      *====================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   DUMP
      *
     C                   RETURN
      *
     C                   ENDSR     '*CANCL'
      *
