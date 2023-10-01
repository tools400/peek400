      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK28                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 03.11.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Ermitteln Systemwerte                                        *
      *                                                               *
      *===============================================================*
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
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK28
      /undefine internal_prototype
      *
      /COPY QCOPYLE,QWCRSVAL
      *
     D YRcvVar         DS           128    INZ
     D   RcvNbrRet             1      4I 0
     D   RcvOffset             5      8I 0
     D   RcvData               9    128A
      *
     D YSystemVal      DS           128    INZ
     D   SystemVal             1     10A
     D   TypeOfData           11     11A
     D   InfStatus            12     12A
     D   LenOfData            13     16I 0
     D   SysValData           17    128A
      *
     D X               S                   like(int4_t) inz
     D errCode         DS                  likeds(errCode_t) inz
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK28          PI
     D  i_attr                             const like(attr_t)
     D  i_noMsg                            const like(bool_t)
     D  o_attrLen                                like(int4_t)
     D  o_attrType                               like(attrType_t)
     D  o_attrValue                              like(attrValue_t)
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
      * - Meldung
     C     i_noMsg       IFEQ      bTrue
     C                   Callp     p_sndStsMg('USR8157': ' ')
     C                   ELSE
      *        keine Statusmeldung ausgeben
     C                   Endif
      *
     C                   CLEAR                   errCode
     C                   EVAL      errCode.bytPrv = %size(errCode)
      *
     C                   CALLP     QWCRSVAL(YRcvVar: %size(YRcvVar): 1
     C                                      : i_attr: errCode)
      *
     C                   IF        (errCode.bytAvl = 0)
     C                   EXSR      GetAttr
     C                   ELSE
     C                   EVAL      o_attrLen = 0
     C                   EVAL      o_attrType = ''
     C                   EVAL      o_attrValue = ''
     C                   Endif
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *====================================================*
      *  GetAttr -  Abrufen der Attributwertes             *
      *====================================================*
      *
     C     GetAttr       BEGSR
      *
     C                   EVAL      X = RcvOffset + 1
     C                   EVAL      YSystemVal = %subst(YRcvVar: X)
      *
     C                   EVAL      o_attrLen = LenOfData
     C                   EVAL      o_attrType = TypeOfData
      *
     C                   EVAL      X = 1
     C                   EVAL      o_attrValue =
     C                               %subst(SysValData: X: o_attrLen)
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
