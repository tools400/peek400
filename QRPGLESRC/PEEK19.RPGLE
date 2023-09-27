      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK19                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 27.10.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Erstellen externen Aufsetzschlüssel                          *
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
     FPEEKFLDL2 IF   E           K DISK    USROPN
     F                                     RENAME(FPEEKFLD:FPEEKFLDL2)
     F                                     INFSR(*PSSR)
     F                                     PREFIX(F2)
     F                                     INFDS(Peek_L2_DS)
      *
      *---API-Formate--------------------------------------*
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK19
      /undefine internal_prototype
      *
      *----------------------------------------------------*
      *  I N F D S - D E F I N I T I O N E N               *
      *----------------------------------------------------*
      *
     DPeek_L2_DS       DS
     D P2File                 83     92A
     D P2Library              93    102A
     D P2Member              129    138A
     D P2RcdNbr              397    400I 0
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D YBuffer         S                   like(r§rcdBuf  ) inz
     D YOutBuffer      S                   like(r§rcdBuf  ) inz
     D YOutBuffLn      S                   like(r§int4    ) inz
     D YMsgID          S                   like(r§msgID   ) inz
     D YMsgDta         S                   like(r§msgDta  ) inz
      *
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
      *
     D PEEK18_NAME     S                   like(r§pgmCallN) inz
      *
      /COPY QCOPYLE,PPEEK18
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     D PEEK19          PI
     D  i_rcdBuffer                        const like(r§rcdBuf)
     D  o_keyVal                                 like(r§keyBuf)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLDL2
     C     F2KEY_L2      KLIST
     C                   KFLD                    F2KSEQ
      *
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
      *
     C                   EVAL      o_keyVal = *BLANKS
     C                   EVAL      X = 1
      *
     C                   EVAL      F2KSeq = 1
     C     F2KEY_L2      SETLL     FPEEKFLDL2
      *
     C                   DO        *HIVAL
     C                   READ      FPEEKFLDL2                             11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   EVAL      FLDL0100 = F2FFD
      *
     C                   Callp     f_rtvFld(yBuffer   :
     C                                      i_rcdBuffer:
     C                                      FLDL0100  :
     C                                      bTrue     )
      *
     C                   CALLP     PEEK18(FLDL0100: F2Format: yBuffer
     C                                    : '*EXTERN': '*CURRENT'
     C                                    : YOutBuffer: YOutBuffLn
     C                                    : YMsgID: YMsgDta)
      *
      *  Wert ...
     C     1             DO        YOutBuffLn    Y
     C                   Eval      %subst(o_keyVal: x: 1) =
     C                                %subst(yOutBuffer: y: 1)
     C                   EVAL      X = X + 1
     C     X             IFGT      §keyBufLen
     C                   LEAVE
     C                   Endif
     C                   Enddo
      *
     C     X             IFGT      §keyBufLen
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
     C                   RETURN
      *
      *============================================================*
      *    First         Initialisierung                           *
      *============================================================*
      *
     C     First         BEGSR
      *
      * - Programm initialisieren
      ***                Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   Eval      PEEK18_NAME = f_pgmCallN('PEEK18')
      *
     C                   OPEN      PEEKFLDL2
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
