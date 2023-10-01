      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.0.0                               *
      *  Programm : PEEK03                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 23.10.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Aktualisieren der Feldliste mit Schlüsselinformationen       *
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
     FPEEKFLD   UF   E           K DISK    USROPN
     F                                     PREFIX(F_)
      *===============================================================*
     D PEEK41_NAME     S                   like(pgmCallN_t) inz
      *
      *  list API format KEYL0100
      /COPY QCOPYLE,KEYL0100
      *
      *  list API format FLDL0100
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,PPEEK41
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK03
      /undefine internal_prototype
      *
      *---Copystrecken für Nachrichtenaufbau---------------*
      /COPY QCOPYLE,USR0006
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
     D rtnCode         S                   like(int4_t) inz
     D nbrOfKey        S                   like(int4_t) inz
      *
     D x               S                   like(int4_t) inz
     D y               S                   like(int4_t) inz
     D z               S                   like(int4_t) inz
     D tempStr         S                   like(i_sqlOrder ) inz
     D keyl0100        DS                  likeds(KEYL0100_t)
     D                                     based(pKEYL0100)
     D keyl0100_sql    DS                  likeds(KEYL0100_t) inz
     D data            S            512A   inz
     D numKeyFld       S                   like(int4_t)
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK03          PI
     D  i_qFile                            const likeds(qObj_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  i_access                      1A   const
     D  i_sqlOrder                  512A   const
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
      *----------------------------------------------------*
     C     F_Key         KLIST
     C                   KFLD                    F_Field
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
      *
     C                   EXSR      First
      *---------------------------------------------------*
      *
     C                   IF        i_access = SQL_SEQ
     C                   EXSR      sqlSeq
     C                   ELSE
     C                   EXSR      otherSeq
     C                   Endif
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     ENDE          TAG
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
      *
     C                   EVAL      *INLR = '1'
      *
      *====================================================*
      *  sqlSeq     SQL-Auswahl                            *
      *====================================================*
      *
     C     sqlSeq        BEGSR
      *
     C                   Eval      pKEYL0100 = %addr(keyl0100_sql)
      *
     C                   Eval      numKeyFld = 0
      *
     C                   Eval      x = 1
     C                   Exsr      getNextFld
      *
     C                   DoW       y > 1
      *
     C                   Eval      tempStr = %trim(%subst(i_sqlOrder: x: y-x))
      *  Ende des Feldes ...
     C                   Eval      z = %scan('"': tempStr: 2)
     C                   Eval      keyl0100.APKEYF =
     C                               %trim(%subst(tempStr: 2: z-2))
      *
      *  Alles hinter dem Feld ...
     C                   Eval      tempStr = %trim(%subst(tempStr: z+1))
      *
     C                   If        (tempStr = 'DESC')
     C                   Eval      keyl0100.APKSEQ  = 'D'
     C                   Eval      numKeyFld = numKeyFld + 1
     C                   Eval      keyl0100.APKEYN = numKeyFld
     C                   Exsr      AddKeyInf
     C                   Else
     C                   Eval      keyl0100.APKSEQ  = 'A'
     C                   Eval      numKeyFld = numKeyFld + 1
     C                   Eval      keyl0100.APKEYN = numKeyFld
     C                   Exsr      AddKeyInf
     C                   Endif
      *
     C                   Eval      x = y + 1
     C                   Exsr      getNextFld
     C                   Enddo
      *
     C                   ENDSR
      *
      *====================================================*
      *  getNextFld  nächstes Feld im SQL-String           *
      *====================================================*
      *
     C     getNextFld    BEGSR
      *
     C                   If        x > 512
     C                   Eval      y = 0
     C                   Else
      *
     C                   Eval      y = %scan(',': i_sqlOrder: x)
      *
     C                   IF        (y = 0) and
     C                             (%subst(i_sqlOrder: x) <> ' ')
     C                   Eval      y = %checkr(' ': i_sqlOrder)
     C                   Eval      y = y + 1
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  otherSeq   keine SQl-Auswahl                      *
      *====================================================*
      *
     C     otherSeq      BEGSR
      *
     C                   Eval      pKEYL0100 = %addr(data)
      *
      *  Abrufen der Dateiinformationen ...
     C                   CALLP     PEEK41(i_qFile: i_rcdFmt
     C                                    : '*CREATE': rtnCode: data)
     C                   IF        (rtnCode <= 0)
      *  ... schade, Aufruf ist fehlgeschlagen
     C                   ELSE
      *  Einlesen der Schlüsselinformationen ...
     C                   CALLP     PEEK41(i_qFile: i_rcdFmt
     C                                    : '*KEY': nbrOfKey: data)
      *
     C     1             DO        nbrOfKey
     C                   CALLP     PEEK41(i_qFile: i_rcdFmt
     C                                    : '*READKEY': rtnCode: data)
     C                   EXSR      ADDKEYINF
     C                   Enddo
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  AddKeyInf  Hinzufügen Schlüsselinformationen      *
      *====================================================*
      *
     C     AddKeyInf     BEGSR
      *
     C                   EVAL      F_Field = KEYL0100.APKEYF
     C     F_Key         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '0'
     C                   EVAL      F_Desc = KEYL0100.APKSEQ
     C                   EVAL      F_KSeq = KEYL0100.APKEYN
     C                   EVAL      FLDL0100 = F_FFD
     C                   EVAL      FLDL0100.F1KEYF = '1'
     C                   EVAL      F_FFD = FLDL0100
     C                   UPDATE    FPEEKFLD
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  First  --  Initialize program                     *
      *====================================================*
      *
     C     First         BEGSR
      *
     C                   Z-ADD     *ZEROS        nbrOfKey
      *
      * - Meldung
     C                   Callp     p_sndStsMg('USR8137': i_qFile)
      *
      * - Los gehts'
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
     C                   ENDSR
      *
      *====================================================*
      *  InzSr --  Initialize program                      *
      *====================================================*
      *
     C     InzSr         BEGSR
      *
     C                   IF        (isInzSr = bTrue)
     C                   Leavesr
     C                   ENDIF
      *
     C                   Eval      isInzSr = bTrue
      *
     C                   Eval      PEEK41_NAME = f_pgmCallN('PEEK41')
      *
     C                   OPEN      PEEKFLD
      *
     C                   ENDSR
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
