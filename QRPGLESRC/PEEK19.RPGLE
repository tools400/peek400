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
     D XIO_Buffer      S                   like(r§rcdBuf  )
     D XKeyVal         S                   like(r§keyBuf  )
     D XMsgID          S                   like(r§msgID   )
     D XMsgDta         S                   like(r§msgDta  )
      *
     D YData           S            512A   inz
     D YFormat         S             10A   inz
     D YBuffer         S                   like(r§rcdBuf  ) inz
     D YTgtFormat      S             10A   inz
     D YTgtValue       S             10A   inz
     D YOutBuffer      S                   like(r§rcdBuf  ) inz
     D YOutBuffLn      S                   like(r§int4    ) inz
     D YMsgID          S                   like(r§msgID   ) inz
     D YMsgDta         S                   like(r§msgDta  ) inz
      *
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
      *
     D PEEK18          S                   like(r§pgmCallN) inz
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     C     *ENTRY        PLIST
     C                   PARM                    XIO_Buffer
     C                   PARM                    XKeyVal
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK18
     C     P_Peek18      PLIST
     C                   PARM                    YData
     C                   PARM                    YFormat
     C                   PARM                    YBuffer
     C                   PARM                    YTgtFormat
     C                   PARM                    YTgtValue
     C                   PARM                    YOutBuffer
     C                   PARM                    YOutBuffLn
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
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
     C                   MOVEL (P) *BLANKS       XKeyVal
     C                   Z-ADD     1             X
      *
     C                   Z-ADD     1             F2KSeq
     C     F2KEY_L2      SETLL     FPEEKFLDL2
      *
     C                   DO        *HIVAL
     C                   READ      FPEEKFLDL2                             11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   MOVEL (P) F2FFD         FLDL0100
      *
     C                   Eval      yData      = F2FFD
     C                   Eval      yFormat    = F2Format
     C                   Callp     f_rtvFld(yBuffer   :
     C                                      XIO_Buffer:
     C                                      FLDL0100  :
     C                                      bTrue     )
     C                   Eval      yTgtFormat = '*EXTERN'
     C                   Eval      yTgtValue  = '*CURRENT'
     C                   CALL      PEEK18        P_Peek18
      *
      *  Wert ...
     C     1             DO        YOutBuffLn    Y
     C                   Eval      %subst(xKeyVal: x: 1) =
     C                                %subst(yOutBuffer: y: 1)
     C                   ADD       1             X
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
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   Eval      PEEK18 = f_pgmCallN('PEEK18')
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
