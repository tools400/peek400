      /IF NOT DEFINED(D_VARDEF)
      /DEFINE D_VARDEF
      *===============================================================*
      *    Deklaration von Variablengrundtypen & Konstanten           *
      *===============================================================*
      *
      *  Referenzfelder:
     D r§choice        S             75A   template
     D r§headerType    S             10A   based(ptrDummy)
     D r§attr          S             10A   based(ptrDummy)
     D r§attrType      S              1A   based(ptrDummy)
     D r§attrValue     S            512A   based(ptrDummy)
     D r§accMode       S              1A   based(ptrDummy)
     D r§bool          S              1A   based(ptrDummy)
     D r§cmdBuffer     S          32702A   based(pDummy  )
     D r§copyRght      S                   like(r§msgDta  )
     D                                     based(ptrDummy)
     D r§dsp80         S                   like(r§bool    )
     D                                     based(ptrDummy)
     D r§fieldNme      S             10A   based(ptrDummy)
     D r§file          S             10A   based(ptrDummy)
     D r§fKeyDsp       S             18A   based(ptrDummy)
     D r§fmt           S             10A   based(ptrDummy)
     D r§fmtId         S             13A   based(ptrDummy)
     D r§headTyp       S             10A   based(ptrDummy)
     D r§hexBuf        S          65532A   based(ptrDummy)
     D §hexBufLen      C                   const(65532)
     D r§keyBuf        S           2000A   based(ptrDummy)
     D §keyBufLen      C                   const(2000)
     D r§lib           S             10A   based(ptrDummy)
     D r§mbr           S             10A   based(ptrDummy)
     D r§mbrNbr        S             10I 0 based(ptrDummy)
     D r§rcdFmt        S             10A   based(ptrDummy)
     D r§rcdFmtInf     DS                  qualified based(ptrDummy)
     D  name                               like(r§rcdFmt)
     D  id                                 like(r§fmtid)
     D r§mod           S             10A   based(ptrDummy)
     D r§msgDta        S            512A   based(ptrDummy)
     D r§msgID         S              7A   based(ptrDummy)
     D r§msgType       S             10A   based(ptrDummy)
     D r§option        S             10A   based(ptrDummy)
     D r§mode          S             10A   based(ptrDummy)
     D r§pinTabR       DS                  likeds(pinTabR_t)
     D                                     based(ptrDummy)
     D r§pgm           S             10A   based(ptrDummy)
     D r§pgmCallN      S             21A   based(ptrDummy)
     D r§pgmCmd        S             10A   based(ptrDummy)
     D r§pgmCmdDt      S            256A   based(ptrDummy)
     D r§proc          S            256A   based(ptrDummy)
     D r§rcdBuf        S          32766A   based(ptrDummy)
     D r§rcdBufUcs2    S          16383C   based(ptrDummy)
     D rcdBuffer_t     DS                  qualified template
     D  sbcs                      32766A
     D  ucs2                      16383C
     D                                     overlay(sbcs)
     D §rcdBufLen      C                   const(32766)
     D r§rcdNbr        S             10I 0 based(ptrDummy)
     D r§nullMap       S              1S 0 dim(§nullMapSize)
     D §nullMapSize    C                   const(8000)
     D r§scnAid        S             10A   based(ptrDummy)
     D r§sqlOrder      S            512A   template
     D r§sqlWhere      S            512A   template
     D r§sqlStmt       S           2000A   based(ptrDummy)
     D r§user          S             10A   based(ptrDummy)
      *
     D r§qObj          DS                  template
     D  name                         10A
     D  lib                          10A
      *
     D errCode_t       DS                  qualified template
     D  bytPrv                       10I 0
     D  bytAvl                       10I 0
     D  excID                         7A
     D  errRes_01                     1A
     D  excDta                      256A
      *
      *  Feldinhalt für Text-/Hex-Editor
     D r§fldInhalt     DS                  qualified template
     D  sbcs                               like(r§rcdBuf    )
     D  ucs2                               like(r§rcdBufUcs2)
     D                                     overlay(sbcs)
      *
      *  Verwaltung gepinnter Datensätze
     D pinTabR_t       ds                  qualified based(pDummy)
     D  rcdNbr                       10i 0
     D  file                         10a
     D  lib                          10a
     D  mbr                          10a
     D  rcdFmt                       10a
     D  mbrNbr                       10I 0
      *
      *  Integer & Binärwerte:
     D r§int2          S              5I 0 based(ptrDummy)
     D r§int4          S             10I 0 based(ptrDummy)
     D r§uint4         S             10U 0 based(ptrDummy)
      *
      *  Feedback Code:
     D r§fc            S             12A   based(ptrDummy)
      *
      *  Lower/Upper case:
     D cLOWER          C                   'abcdefghijklmnopqrstuvwxyzäöüß'
     D cUPPER          C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜß'
      *
      *  Grenzen für relative Satznummer
     D §LowRcdNbr      C                   CONST(1)
     D §HghRcdNbr      C                   CONST(2147483647)
      *
      *  Access mode:
     D r§accessMode    S              1A   template
      *
     D §RrnSeq         C                   CONST('0')
     D §KeySeq         C                   CONST('1')
     D §SqlSeq         C                   CONST('2')
      *
      *  Key-Input-Mode:
     D §KeyModeLower   C                   CONST('1')
     D §KeyModeUpper   C                   CONST('0')
      *
      *  Update-Mode:
     D §upd_dft        C                   CONST('*')
     D §upd_yes        C                   CONST('1')
     D §upd_nokey      C                   CONST('2')
     D §upd_no         C                   CONST('0')
      *
      *  Boolsche Werte:
     D bTrue           C                   CONST('1')
     D bFalse          C                   CONST('0')
     D bNotDef         C                   CONST('-')
     D bEOF            C                   CONST('1')
      *
      *  Dateizugriffe:
     D bFound          C                   CONST('0')
      *
      *  Zustellarten von Nachrichten:
     D §TypInfo        C                   CONST('*INFO')
     D §TypInq         C                   CONST('*INQ')
     D §TypRqs         C                   CONST('*RQS')
     D §TypComp        C                   CONST('*COMP')
     D §TypDiag        C                   CONST('*DIAG')
     D §TypNotify      C                   CONST('*NOTIFY')
     D §TypEscape      C                   CONST('*ESCAPE')
     D §TypStatus      C                   CONST('*STATUS')
      *
      *  Modus:
     D §Batch          C                   CONST('*BATCH')
     D §Inter          C                   CONST('*INTER')
      *
      /ENDIF
