      /IF NOT DEFINED(D_VARDEF)
      /DEFINE D_VARDEF
      *===============================================================*
      *    Deklaration von Variablengrundtypen & Konstanten           *
      *===============================================================*
      *
      *  Referenzfelder:
     D r§choice        S             75A   template
     D r§headerType    S             10A   template
     D r§attr          S             10A   template
     D r§attrType      S              1A   template
     D r§attrValue     S            512A   template
     D r§accMode       S              1A   template
     D r§bool          S              1A   template
     D r§cmdBuffer     S          32702A   template
     D r§copyRght      S                   like(r§msgDta) template
     D r§dsp80         S                   like(r§bool) template
     D r§fieldNme      S             10A   template
     D r§file          S             10A   template
     D r§fKeyDsp       S             18A   template
     D r§fmt           S             10A   template
     D r§fmtId         S             13A   template
     D r§headTyp       S             10A   template
     D r§hexBuf        S          65532A   template
     D §hexBufLen      C                   const(65532)
     D r§keyBuf        S           2000A   template
     D §keyBufLen      C                   const(2000)
     D r§lib           S             10A   template
     D r§mbr           S             10A   template
     D r§mbrNbr        S             10I 0 template
     D r§rcdFmt        S             10A   template
      *
     D r§rcdFmtInf     DS                  qualified template
     D  name                               like(r§rcdFmt)
     D  id                                 like(r§fmtid)
      *
     D r§mod           S             10A   template
     D r§msgDta        S            512A   template
     D r§msgID         S              7A   template
     D r§msgType       S             10A   template
     D r§option        S             10A   template
     D r§mode          S             10A   template
      *
     D r§pinTabR       DS                  likeds(pinTabR_t) template
      *
     D r§pgm           S             10A   template
     D r§pgmCallN      S             21A   template
     D r§pgmCmd        S             10A   template
     D r§pgmCmdDt      S            256A   template
     D r§proc          S            256A   template
     D r§rcdBuf        S          32766A   template
     D r§rcdBufUcs2    S          16383C   template
      *
     D rcdBuffer_t     DS                  qualified template
     D  sbcs                      32766A
     D  ucs2                      16383C   overlay(sbcs)
      *
     D §rcdBufLen      C                   const(32766)
     D r§rcdNbr        S             10I 0 template
     D r§nullMap       S              1S 0 dim(§nullMapSize)
     D §nullMapSize    C                   const(8000)
     D r§scnAid        S             10A   template
     D r§sqlOrder      S            512A   template
     D r§sqlWhere      S            512A   template
     D r§sqlStmt       S           2000A   template
     D r§user          S             10A   template
      *
     D r§qObj          DS                  qualified template
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
     D  sbcs                               like(r§rcdBuf)
     D  ucs2                               like(r§rcdBufUcs2)
     D                                     overlay(sbcs)
      *
      *  Verwaltung gepinnter Datensätze
     D pinTabR_t       ds                  qualified template
     D  rcdNbr                       10i 0
     D  file                         10a
     D  lib                          10a
     D  mbr                          10a
     D  rcdFmt                       10a
     D  mbrNbr                       10I 0
      *
      *  Integer & Binärwerte:
     D r§int2          S              5I 0 template
     D r§int4          S             10I 0 template
     D r§uint4         S             10U 0 template
      *
      *  Feedback Code:
     D r§fc            S             12A   template
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
