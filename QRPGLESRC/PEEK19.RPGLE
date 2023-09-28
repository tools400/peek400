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
     D YBuffer         S                   like(rcdBuf_t) inz
     D YOutBuffer      S                   like(rcdBuf_t) inz
     D YOutBuffLn      S                   like(int4_t) inz
     D YMsgID          S                   like(msgID_t) inz
     D YMsgDta         S                   like(msgDta_t) inz
      *
     D X               S                   like(int4_t) inz
     D Y               S                   like(int4_t) inz
      *
     D PEEK18_NAME     S                   like(pgmCallN_t) inz
      *
      /COPY QCOPYLE,PPEEK18
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
      *---ENTRY-LISTE--------------------------------------*
      *
     D PEEK19          PI
     D  i_rcdBuffer                        const like(rcdBuf_t)
     D  o_keyVal                                 like(keyBuf_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLDL2
     C     F2KEY_L2      KLIST
     C                   KFLD                    F2KSEQ
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
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
     C     X             IFGT      KEY_BUFF_LEN
     C                   LEAVE
     C                   Endif
     C                   Enddo
      *
     C     X             IFGT      KEY_BUFF_LEN
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
      *====================================================*
      *  InzSr --  Initialize program                      *
      *====================================================*
      *
     C     InzSr         Begsr
      *
     C                   If        (isInzSr = bTrue)
     C                   Leavesr
     C                   Endif
      *
     C                   Eval      isInzSr = bTrue
      *
     C                   Eval      PEEK18_NAME = f_pgmCallN('PEEK18')
      *
     C                   OPEN      PEEKFLDL2
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
