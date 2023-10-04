      /IF NOT DEFINED(D_VARDEF)
      /DEFINE D_VARDEF
      *===============================================================*
      *    Deklaration von Variablengrundtypen & Konstanten           *
      *===============================================================*
      *
      *  Referenzfelder:
     D commitLvl_t     S              1A   template
     D choice_t        S             75A   template
     D headerType_t    S             10A   template
     D attr_t          S             10A   template
     D attrType_t      S              1A   template
     D attrValue_t     S            512A   template
     D accMode_t       S              1A   template
     D bool_t          S              1A   template
     D cmdBuffer_t     S          32702A   template
     D copyRght_t      S                   like(msgDta_t) template
     D dsp80_t         S                   like(bool_t) template
     D fieldNme_t      S             10A   template
     D file_t          S             10A   template
     D fKeyDsp_t       S             18A   template
     D fmt_t           S             10A   template
     D fmtId_t         S             13A   template
     D headTyp_t       S             10A   template
      *
     D hexBuf_t        S          65532A   template
      *
     D keyBuf_t        S           2000A   template
     D KEY_BUFF_LEN    C                   const(2000)
      *
     D lib_t           S             10A   template
     D mbr_t           S             10A   template
     D mbrNbr_t        S             10I 0 template
     D rcdFmt_t        S             10A   template
     D text_t          S             50a   template
     D colHeading_t    S            128A   varying template
      *
     D rcdFmtInf_t     DS                  qualified template
     D  name                               like(rcdFmt_t)
     D  id                                 like(fmtid_t)
      *
     D mod_t           S             10A   template
     D msgDta_t        S            512A   template
     D msgID_t         S              7A   template
     D msgType_t       S             10A   template
      *
     D function_t      S             10A   template
     D option_t        S             10A   template
     D mode_t          S             10A   template
     D type_t          S             10A   template
      *
     D pgm_t           S             10A   template
     D pgmCallN_t      S             21A   template
     D pgmCmd_t        S             10A   template
     D pgmCmdDt_t      S            256A   template
     D proc_t          S            256A   template
     D rcdBuf_t        S          32766A   template
     D rcdBufUcs2_t    S          16383C   template
      *
     D rcdBuffer_t     DS                  qualified template
     D  sbcs                      32766A
     D  ucs2                      16383C   overlay(sbcs)
     D RCD_BUFF_LEN    C                   const(32766)
      *
     D rcdNbr_t        S             10I 0 template
     D nullMap_t       S              1S 0 dim(NULL_MAP_SIZE)
     D NULL_MAP_SIZE   C                   const(8000)
      *
     D scnAid_t        S             10A   template
     D sqlOrder_t      S            512A   template
     D sqlWhere_t      S            512A   template
     D sqlStmt_t       S           2000A   template
     D user_t          S             10A   template
      *
     D qObj_t          DS                  qualified template
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
     D fldInhalt_t     DS                  qualified template
     D  sbcs                               like(rcdBuf_t)
     D  ucs2                               like(rcdBufUcs2_t)
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
     D int2_t          S              5I 0 template
     D int4_t          S             10I 0 template
     D uint4_t         S             10U 0 template
      *
      *  Lower/Upper case:
     D cLOWER          C                   'abcdefghijklmnopqrstuvwxyzäöüß'
     D cUPPER          C                   'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜß'
      *
      *  Feedback Code:
     D fc_t            S             12A   template
      *
     D NUMERIC_DIGITS  C                   '1234567890'
      *
      *  Grenzen für relative Satznummer
     D LOW_RCD_NBR     C                   CONST(1)
     D HIGH_RCD_NBR    C                   CONST(2147483647)
      *
      *  Access mode:
     D accessMode_t    S              1A   template
      *
     D RRN_SEQ         C                   CONST('0')
     D KEY_SEQ         C                   CONST('1')
     D SQL_SEQ         C                   CONST('2')
      *
      *  Key-Input-Mode:
     D KEY_MODE_LOWER  C                   CONST('1')
     D KEY_MODE_UPPER  C                   CONST('0')
      *
      *  Update-Mode:
     D UPD_M_DFT       C                   CONST('*')
     D UPD_M_YES       C                   CONST('1')
     D UPD_M_NOKEY     C                   CONST('2')
     D UPD_M_NO        C                   CONST('0')
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
     D MSG_T_INFO      C                   CONST('*INFO')
     D MSG_T_INQ       C                   CONST('*INQ')
     D MSG_T_RQS       C                   CONST('*RQS')
     D MSG_T_COMP      C                   CONST('*COMP')
     D MSG_T_DIAG      C                   CONST('*DIAG')
     D MSG_T_NOTIFY    C                   CONST('*NOTIFY')
     D MSG_T_ESCAPE    C                   CONST('*ESCAPE')
     D MSG_T_STATUS    C                   CONST('*STATUS')
      *
      *  Modus:
     D MODE_BATCH      C                   CONST('*BATCH')
     D MODE_INTER      C                   CONST('*INTER')
      *
     D USRSPC_NAME     C                   '§PEEK§'
     D USRSPC_LIBRARY  C                   'QTEMP'
      *
     D WORK_FILE_NAME...
     D                 C                   'PEEKWRK'
     D WORK_FILE_LIBRARY...
     D                 C                   'QTEMP'
     D WORK_FILE_MEMBER...
     D                 C                   '*FIRST'
      *
      /ENDIF
