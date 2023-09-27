      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK32                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 26.11.97  Raddatz                                 *
      *  geändert : 27.04.99  2.1.0                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Konvertieren nicht darstellbarer Zeichen                     *
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
      /COPY QCOPYLE,PPEEK32
      /undefine internal_prototype
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8163
      *----------------------------------------------------*
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0006
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
      *  Arbeitsfelder
     D X               S                   like(r§int4    ) inz
     D pBuffer         S               *   inz
     D char            S              1A   based(pChar)
     D char_ucs2       S              1C   based(pChar_ucs2)
     D char_utf16      S              1C   ccsid(1200)
      *
      /COPY QCOPYLE,F_PEEK53
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK32          PI
     D  io_buffer                                likeds(rcdBuffer_t)
     D  i_buffLen                          const like(r§int4)
     D  i_ccsid                            const like(r§int4)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
      *----------------------------------------------------*
      *
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
      *    Zeichen mit einer DOUBLE BYTE CCSID, wie 1200 oder 13488
      *    können zur Zeit nicht geprüft werden.
     C                   If        (i_ccsid <> 0)
     C                   Exsr      check_ucs2
     C                   Else
     C                   Exsr      check_sbcs
     C                   Endif
      *
     C                   RETURN
      *
      *============================================================*
      *    Prüfen UCS2 Zeichenkette auf ungültige Zeichen          *
      *============================================================*
      *
     C     check_ucs2    BEGSR
      *
      *      DBCS Zeichen lassen sich zur Zeit nicht prüfen.
      *
     C                   ENDSR
      *
      *============================================================*
      *    Prüfen SBCS Zeichenkette auf ungültige Zeichen          *
      *============================================================*
      *
     C     check_sbcs    BEGSR
      *
     C                   EVAL      pBuffer = %addr(io_buffer)
      *
     C     1             DO        i_buffLen     X
     C                   EVAL      pChar = pBuffer + (x-1)
     C                   IF        (char < x'40' or char = x'FF')
     C                   EVAL      char = SET_CVTC
     C                   EVAL      o_msgID = 'USR8163'
     C                   EVAL      USR81631 = SET_CVTC
     C                   EVAL      o_msgDta = USR8163
     C                   ELSE
      *           Zeichen beibehalten
     C                   Endif
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetUsrSetg    Ermitteln der Standardsprache             *
      *============================================================*
      *
     C     GetUsrSetg    BEGSR
      *
      *  *CVTCHR
     C                   Eval      SET0006 = f_getUsrSg('*CVTCHR'   )
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   EXSR      GetUsrSetg
      *
     C                   ENDSR
      *
      *============================================================*
      *    *PSSR         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   DUMP
      *
     C                   ENDSR     '*CANCL'
      *
